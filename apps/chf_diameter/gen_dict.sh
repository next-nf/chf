#!/bin/sh
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# Copyright (C) 2026 Nathan Foster <next-nf@proton.me>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Generate the Diameter dictionary codecs from their .dia sources using OTP's
# own dictionary compiler (diameter_make, shipped with the diameter app). This
# replaces the third-party rebar3_diameter_compiler plugin, which does not build
# on OTP-29 (its clean_diameter.erl uses a bare `catch`, a hard error there).
#
# Invoked from apps/chf_diameter/rebar.config as compile/eunit/ct pre_hooks, and
# as a clean post_hook (`sh gen_dict.sh clean`). rebar3 runs hook commands via
# open_port/spawn, which does NOT interpret shell operators (&&, ;, |, globs,
# redirects) -- only a single program runs -- so all multi-step logic lives here,
# in one script run as a single command. We cd into the script's own directory
# (via $0) so the relative paths below resolve regardless of the caller's CWD
# (the compile hook runs with CWD = this app dir; eunit/ct run from the project
# root).
set -e
cd "$(dirname "$0")"

# `sh gen_dict.sh clean` removes the generated artifacts (used by the clean
# post_hook). Done here, not in rebar.config, because the glob would not expand
# under open_port. Only the generated diameter_*.{erl,hrl} match -- the
# hand-written sources are chf_diameter_*.erl, so they are never touched.
if [ "$1" = "clean" ]; then
    rm -f src/diameter_*.erl include/diameter_*.hrl
    exit 0
fi

# Generation order is a topological sort of the @inherits graph across dia/.
# diameter_make resolves @inherits by loading the inherited dictionary's compiled
# module from the code path and reading its dict/0 -- so each dictionary must be
# generated, compiled, and loaded BEFORE any dictionary that inherits it, or
# generation fails with {error,{not_loaded,[...]}}. The two OTP base dictionaries
# (diameter_gen_base_rfc6733, diameter_gen_acct_rfc6733) ship with the diameter
# application and are already on the path. The compiled beams exist only in the
# generator VM (code:load_binary, no .beam on disk), so there is nothing extra to
# clean up.
mkdir -p src include

erl -noshell -eval '
  Order = [
    "diameter_3gpp_base",
    "diameter_rfc4005_nasreq",
    "diameter_3gpp_ts29_229",
    "diameter_rfc7155_nasreq",
    "diameter_etsi_es283_034",
    "diameter_3gpp_ts29_329",
    "diameter_rfc4006_cc",
    "diameter_3gpp_ts29_061_gmb",
    "diameter_3gpp_ts29_214",
    "diameter_3gpp_ts29_212",
    "diameter_3gpp_ts32_299",
    "diameter_travelping",
    "diameter_3gpp_ts32_299_si",
    "diameter_3gpp_ts29_061_sgi_base_acc",
    "diameter_3gpp_ts32_299_ro",
    "diameter_3gpp_ts32_299_rf"
  ],
  lists:foreach(fun(Name) ->
    Dia = "dia/" ++ Name ++ ".dia",
    case diameter_make:codec(Dia, [{outdir, "src"}]) of
      ok -> ok;
      GenErr ->
        io:format(standard_error, "diameter codec gen failed for ~s: ~p~n", [Name, GenErr]),
        halt(1)
    end,
    Erl = "src/" ++ Name ++ ".erl",
    case compile:file(Erl, [binary, return_errors, {i, "src"}]) of
      {ok, Mod, Bin} ->
        {module, Mod} = code:load_binary(Mod, Erl, Bin);
      CErr ->
        io:format(standard_error, "diameter codec compile failed for ~s: ~p~n", [Name, CErr]),
        halt(1)
    end
  end, Order),
  halt()' \
    -s init stop

# Keep the project layout: generated .erl stays in src/ (compiled by rebar3),
# generated .hrl moves to include/. The glob is safe here -- this is a real
# /bin/sh, not the rebar3 hook runner.
mv -f src/diameter_*.hrl include/
