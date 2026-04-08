%% -------------------------------------------------------------------
%% This is a generated file.
%% -------------------------------------------------------------------

-module(diameter_rfc7155_nasreq).

-moduledoc(false).

-compile({parse_transform, diameter_exprecs}).

-compile(nowarn_unused_function).

-dialyzer(no_return).

-export_records([diameter_nasreq_ACR,
                 diameter_nasreq_ACA,
                 diameter_nasreq_Tunneling,
                 'diameter_nasreq_Proxy-Info',
                 'diameter_nasreq_Failed-AVP',
                 'diameter_nasreq_Experimental-Result',
                 'diameter_nasreq_Vendor-Specific-Application-Id']).

-record(diameter_nasreq_ACR,
        {'Session-Id',
         'Origin-Host',
         'Origin-Realm',
         'Destination-Realm',
         'Accounting-Record-Type',
         'Accounting-Record-Number',
         'Acct-Application-Id',
         'User-Name' = [],
         'Accounting-Sub-Session-Id' = [],
         'Acct-Session-Id' = [],
         'Acct-Multi-Session-Id' = [],
         'Origin-AAA-Protocol' = [],
         'Origin-State-Id' = [],
         'Destination-Host' = [],
         'Event-Timestamp' = [],
         'Acct-Delay-Time' = [],
         'NAS-Identifier' = [],
         'NAS-IP-Address' = [],
         'NAS-IPv6-Address' = [],
         'NAS-Port' = [],
         'NAS-Port-Id' = [],
         'NAS-Port-Type' = [],
         'Class' = [],
         'Service-Type' = [],
         'Termination-Cause' = [],
         'Accounting-Input-Octets' = [],
         'Accounting-Input-Packets' = [],
         'Accounting-Output-Octets' = [],
         'Accounting-Output-Packets' = [],
         'Acct-Authentic' = [],
         'Accounting-Auth-Method' = [],
         'Acct-Link-Count' = [],
         'Acct-Session-Time' = [],
         'Acct-Tunnel-Connection' = [],
         'Acct-Tunnel-Packets-Lost' = [],
         'Callback-Id' = [],
         'Callback-Number' = [],
         'Called-Station-Id' = [],
         'Calling-Station-Id' = [],
         'Connect-Info' = [],
         'Originating-Line-Info' = [],
         'Authorization-Lifetime' = [],
         'Session-Timeout' = [],
         'Idle-Timeout' = [],
         'Port-Limit' = [],
         'Accounting-Realtime-Required' = [],
         'Acct-Interim-Interval' = [],
         'Filter-Id' = [],
         'NAS-Filter-Rule' = [],
         'QoS-Filter-Rule' = [],
         'Framed-AppleTalk-Link' = [],
         'Framed-AppleTalk-Network' = [],
         'Framed-AppleTalk-Zone' = [],
         'Framed-Compression' = [],
         'Framed-Interface-Id' = [],
         'Framed-IP-Address' = [],
         'Framed-IP-Netmask' = [],
         'Framed-IPv6-Prefix' = [],
         'Framed-IPv6-Pool' = [],
         'Framed-IPv6-Route' = [],
         'Framed-IPX-Network' = [],
         'Framed-MTU' = [],
         'Framed-Pool' = [],
         'Framed-Protocol' = [],
         'Framed-Route' = [],
         'Framed-Routing' = [],
         'Login-IP-Host' = [],
         'Login-IPv6-Host' = [],
         'Login-LAT-Group' = [],
         'Login-LAT-Node' = [],
         'Login-LAT-Port' = [],
         'Login-LAT-Service' = [],
         'Login-Service' = [],
         'Login-TCP-Port' = [],
         'Tunneling' = [],
         'Proxy-Info' = [],
         'Route-Record' = [],
         'AVP' = []}).

-record(diameter_nasreq_ACA,
        {'Session-Id',
         'Result-Code',
         'Origin-Host',
         'Origin-Realm',
         'Accounting-Record-Type',
         'Accounting-Record-Number',
         'Acct-Application-Id',
         'User-Name' = [],
         'Accounting-Sub-Session-Id' = [],
         'Acct-Session-Id' = [],
         'Acct-Multi-Session-Id' = [],
         'Event-Timestamp' = [],
         'Error-Message' = [],
         'Error-Reporting-Host' = [],
         'Failed-AVP' = [],
         'Origin-AAA-Protocol' = [],
         'Origin-State-Id' = [],
         'NAS-Identifier' = [],
         'NAS-IP-Address' = [],
         'NAS-IPv6-Address' = [],
         'NAS-Port' = [],
         'NAS-Port-Id' = [],
         'NAS-Port-Type' = [],
         'Service-Type' = [],
         'Termination-Cause' = [],
         'Accounting-Realtime-Required' = [],
         'Acct-Interim-Interval' = [],
         'Class' = [],
         'Proxy-Info' = [],
         'AVP' = []}).

-record(diameter_nasreq_Tunneling,
        {'Tunnel-Type',
         'Tunnel-Medium-Type',
         'Tunnel-Client-Endpoint',
         'Tunnel-Server-Endpoint',
         'Tunnel-Preference' = [],
         'Tunnel-Client-Auth-Id' = [],
         'Tunnel-Server-Auth-Id' = [],
         'Tunnel-Assignment-Id' = [],
         'Tunnel-Password' = [],
         'Tunnel-Private-Group-Id' = []}).

-record('diameter_nasreq_Proxy-Info',
        {'Proxy-Host', 'Proxy-State', 'AVP' = []}).

-record('diameter_nasreq_Failed-AVP', {'AVP' = []}).

-record('diameter_nasreq_Experimental-Result',
        {'Vendor-Id', 'Experimental-Result-Code'}).

-record('diameter_nasreq_Vendor-Specific-Application-Id',
        {'Vendor-Id',
         'Auth-Application-Id' = [],
         'Acct-Application-Id' = []}).

-export([name/0,
         id/0,
         vendor_id/0,
         vendor_name/0,
         decode_avps/3,
         encode_avps/3,
         grouped_avp/4,
         msg_name/2,
         msg_header/1,
         rec2msg/1,
         msg2rec/1,
         name2rec/1,
         avp_name/2,
         avp_arity/1,
         avp_arity/2,
         avp_header/1,
         avp/4,
         enumerated_avp/3,
         empty_value/2,
         dict/0]).

-include_lib("diameter/include/diameter.hrl").

-include_lib("diameter/include/diameter_gen.hrl").

name() -> diameter_rfc7155_nasreq.

id() -> 1.

vendor_id() -> 0.

vendor_name() -> 'IETF'.

msg_name(271, true) -> 'ACR';
msg_name(271, false) -> 'ACA';
msg_name(_, _) -> ''.

msg_header('ACR') -> {271, 192, 1};
msg_header('ACA') -> {271, 64, 1};
msg_header(_) -> erlang:error(badarg).

rec2msg(diameter_nasreq_ACR) -> 'ACR';
rec2msg(diameter_nasreq_ACA) -> 'ACA';
rec2msg(_) -> erlang:error(badarg).

msg2rec('ACR') -> diameter_nasreq_ACR;
msg2rec('ACA') -> diameter_nasreq_ACA;
msg2rec(_) -> erlang:error(badarg).

name2rec('Tunneling') -> diameter_nasreq_Tunneling;
name2rec('Proxy-Info') -> 'diameter_nasreq_Proxy-Info';
name2rec('Failed-AVP') -> 'diameter_nasreq_Failed-AVP';
name2rec('Experimental-Result') ->
    'diameter_nasreq_Experimental-Result';
name2rec('Vendor-Specific-Application-Id') ->
    'diameter_nasreq_Vendor-Specific-Application-Id';
name2rec(T) -> msg2rec(T).

avp_name(406, undefined) ->
    {'Accounting-Auth-Method', 'Enumerated'};
avp_name(363, undefined) ->
    {'Accounting-Input-Octets', 'Unsigned64'};
avp_name(365, undefined) ->
    {'Accounting-Input-Packets', 'Unsigned64'};
avp_name(364, undefined) ->
    {'Accounting-Output-Octets', 'Unsigned64'};
avp_name(366, undefined) ->
    {'Accounting-Output-Packets', 'Unsigned64'};
avp_name(45, undefined) ->
    {'Acct-Authentic', 'Enumerated'};
avp_name(41, undefined) ->
    {'Acct-Delay-Time', 'Unsigned32'};
avp_name(51, undefined) ->
    {'Acct-Link-Count', 'Unsigned32'};
avp_name(46, undefined) ->
    {'Acct-Session-Time', 'Unsigned32'};
avp_name(68, undefined) ->
    {'Acct-Tunnel-Connection', 'OctetString'};
avp_name(86, undefined) ->
    {'Acct-Tunnel-Packets-Lost', 'Unsigned32'};
avp_name(20, undefined) ->
    {'Callback-Id', 'UTF8String'};
avp_name(19, undefined) ->
    {'Callback-Number', 'UTF8String'};
avp_name(30, undefined) ->
    {'Called-Station-Id', 'UTF8String'};
avp_name(31, undefined) ->
    {'Calling-Station-Id', 'UTF8String'};
avp_name(77, undefined) ->
    {'Connect-Info', 'UTF8String'};
avp_name(11, undefined) -> {'Filter-Id', 'UTF8String'};
avp_name(37, undefined) ->
    {'Framed-AppleTalk-Link', 'Unsigned32'};
avp_name(38, undefined) ->
    {'Framed-AppleTalk-Network', 'Unsigned32'};
avp_name(39, undefined) ->
    {'Framed-AppleTalk-Zone', 'OctetString'};
avp_name(13, undefined) ->
    {'Framed-Compression', 'Enumerated'};
avp_name(8, undefined) ->
    {'Framed-IP-Address', 'OctetString'};
avp_name(9, undefined) ->
    {'Framed-IP-Netmask', 'OctetString'};
avp_name(23, undefined) ->
    {'Framed-IPX-Network', 'Unsigned32'};
avp_name(100, undefined) ->
    {'Framed-IPv6-Pool', 'OctetString'};
avp_name(97, undefined) ->
    {'Framed-IPv6-Prefix', 'OctetString'};
avp_name(99, undefined) ->
    {'Framed-IPv6-Route', 'UTF8String'};
avp_name(96, undefined) ->
    {'Framed-Interface-Id', 'Unsigned64'};
avp_name(12, undefined) -> {'Framed-MTU', 'Unsigned32'};
avp_name(88, undefined) ->
    {'Framed-Pool', 'OctetString'};
avp_name(7, undefined) ->
    {'Framed-Protocol', 'Enumerated'};
avp_name(22, undefined) ->
    {'Framed-Route', 'UTF8String'};
avp_name(10, undefined) ->
    {'Framed-Routing', 'Enumerated'};
avp_name(28, undefined) ->
    {'Idle-Timeout', 'Unsigned32'};
avp_name(14, undefined) ->
    {'Login-IP-Host', 'OctetString'};
avp_name(98, undefined) ->
    {'Login-IPv6-Host', 'OctetString'};
avp_name(36, undefined) ->
    {'Login-LAT-Group', 'OctetString'};
avp_name(35, undefined) ->
    {'Login-LAT-Node', 'OctetString'};
avp_name(63, undefined) ->
    {'Login-LAT-Port', 'OctetString'};
avp_name(34, undefined) ->
    {'Login-LAT-Service', 'OctetString'};
avp_name(15, undefined) ->
    {'Login-Service', 'Enumerated'};
avp_name(16, undefined) ->
    {'Login-TCP-Port', 'Unsigned32'};
avp_name(400, undefined) ->
    {'NAS-Filter-Rule', 'IPFilterRule'};
avp_name(4, undefined) ->
    {'NAS-IP-Address', 'OctetString'};
avp_name(95, undefined) ->
    {'NAS-IPv6-Address', 'OctetString'};
avp_name(32, undefined) ->
    {'NAS-Identifier', 'UTF8String'};
avp_name(5, undefined) -> {'NAS-Port', 'Unsigned32'};
avp_name(87, undefined) ->
    {'NAS-Port-Id', 'UTF8String'};
avp_name(61, undefined) ->
    {'NAS-Port-Type', 'Enumerated'};
avp_name(408, undefined) ->
    {'Origin-AAA-Protocol', 'Enumerated'};
avp_name(94, undefined) ->
    {'Originating-Line-Info', 'OctetString'};
avp_name(62, undefined) -> {'Port-Limit', 'Unsigned32'};
avp_name(407, undefined) ->
    {'QoS-Filter-Rule', 'QoSFilterRule'};
avp_name(6, undefined) ->
    {'Service-Type', 'Enumerated'};
avp_name(82, undefined) ->
    {'Tunnel-Assignment-Id', 'OctetString'};
avp_name(90, undefined) ->
    {'Tunnel-Client-Auth-Id', 'UTF8String'};
avp_name(66, undefined) ->
    {'Tunnel-Client-Endpoint', 'UTF8String'};
avp_name(65, undefined) ->
    {'Tunnel-Medium-Type', 'Enumerated'};
avp_name(69, undefined) ->
    {'Tunnel-Password', 'OctetString'};
avp_name(83, undefined) ->
    {'Tunnel-Preference', 'Unsigned32'};
avp_name(81, undefined) ->
    {'Tunnel-Private-Group-Id', 'OctetString'};
avp_name(91, undefined) ->
    {'Tunnel-Server-Auth-Id', 'UTF8String'};
avp_name(67, undefined) ->
    {'Tunnel-Server-Endpoint', 'UTF8String'};
avp_name(64, undefined) ->
    {'Tunnel-Type', 'Enumerated'};
avp_name(401, undefined) -> {'Tunneling', 'Grouped'};
avp_name(483, undefined) ->
    {'Accounting-Realtime-Required', 'Enumerated'};
avp_name(485, undefined) ->
    {'Accounting-Record-Number', 'Unsigned32'};
avp_name(480, undefined) ->
    {'Accounting-Record-Type', 'Enumerated'};
avp_name(287, undefined) ->
    {'Accounting-Sub-Session-Id', 'Unsigned64'};
avp_name(259, undefined) ->
    {'Acct-Application-Id', 'Unsigned32'};
avp_name(85, undefined) ->
    {'Acct-Interim-Interval', 'Unsigned32'};
avp_name(50, undefined) ->
    {'Acct-Multi-Session-Id', 'UTF8String'};
avp_name(44, undefined) ->
    {'Acct-Session-Id', 'OctetString'};
avp_name(258, undefined) ->
    {'Auth-Application-Id', 'Unsigned32'};
avp_name(276, undefined) ->
    {'Auth-Grace-Period', 'Unsigned32'};
avp_name(274, undefined) ->
    {'Auth-Request-Type', 'Enumerated'};
avp_name(277, undefined) ->
    {'Auth-Session-State', 'Enumerated'};
avp_name(291, undefined) ->
    {'Authorization-Lifetime', 'Unsigned32'};
avp_name(25, undefined) -> {'Class', 'OctetString'};
avp_name(293, undefined) ->
    {'Destination-Host', 'DiameterIdentity'};
avp_name(283, undefined) ->
    {'Destination-Realm', 'DiameterIdentity'};
avp_name(273, undefined) ->
    {'Disconnect-Cause', 'Enumerated'};
avp_name(281, undefined) ->
    {'Error-Message', 'UTF8String'};
avp_name(294, undefined) ->
    {'Error-Reporting-Host', 'DiameterIdentity'};
avp_name(55, undefined) -> {'Event-Timestamp', 'Time'};
avp_name(297, undefined) ->
    {'Experimental-Result', 'Grouped'};
avp_name(298, undefined) ->
    {'Experimental-Result-Code', 'Unsigned32'};
avp_name(279, undefined) -> {'Failed-AVP', 'Grouped'};
avp_name(267, undefined) ->
    {'Firmware-Revision', 'Unsigned32'};
avp_name(257, undefined) ->
    {'Host-IP-Address', 'Address'};
avp_name(299, undefined) ->
    {'Inband-Security-Id', 'Unsigned32'};
avp_name(272, undefined) ->
    {'Multi-Round-Time-Out', 'Unsigned32'};
avp_name(264, undefined) ->
    {'Origin-Host', 'DiameterIdentity'};
avp_name(296, undefined) ->
    {'Origin-Realm', 'DiameterIdentity'};
avp_name(278, undefined) ->
    {'Origin-State-Id', 'Unsigned32'};
avp_name(269, undefined) ->
    {'Product-Name', 'UTF8String'};
avp_name(280, undefined) ->
    {'Proxy-Host', 'DiameterIdentity'};
avp_name(284, undefined) -> {'Proxy-Info', 'Grouped'};
avp_name(33, undefined) ->
    {'Proxy-State', 'OctetString'};
avp_name(285, undefined) ->
    {'Re-Auth-Request-Type', 'Enumerated'};
avp_name(292, undefined) ->
    {'Redirect-Host', 'DiameterURI'};
avp_name(261, undefined) ->
    {'Redirect-Host-Usage', 'Enumerated'};
avp_name(262, undefined) ->
    {'Redirect-Max-Cache-Time', 'Unsigned32'};
avp_name(268, undefined) ->
    {'Result-Code', 'Unsigned32'};
avp_name(282, undefined) ->
    {'Route-Record', 'DiameterIdentity'};
avp_name(270, undefined) ->
    {'Session-Binding', 'Unsigned32'};
avp_name(263, undefined) ->
    {'Session-Id', 'UTF8String'};
avp_name(271, undefined) ->
    {'Session-Server-Failover', 'Enumerated'};
avp_name(27, undefined) ->
    {'Session-Timeout', 'Unsigned32'};
avp_name(265, undefined) ->
    {'Supported-Vendor-Id', 'Unsigned32'};
avp_name(295, undefined) ->
    {'Termination-Cause', 'Enumerated'};
avp_name(1, undefined) -> {'User-Name', 'UTF8String'};
avp_name(266, undefined) -> {'Vendor-Id', 'Unsigned32'};
avp_name(260, undefined) ->
    {'Vendor-Specific-Application-Id', 'Grouped'};
avp_name(_, _) -> 'AVP'.

avp_arity('ACR') ->
    [{'Session-Id', 1},
     {'Origin-Host', 1},
     {'Origin-Realm', 1},
     {'Destination-Realm', 1},
     {'Accounting-Record-Type', 1},
     {'Accounting-Record-Number', 1},
     {'Acct-Application-Id', 1},
     {'User-Name', {0, 1}},
     {'Accounting-Sub-Session-Id', {0, 1}},
     {'Acct-Session-Id', {0, 1}},
     {'Acct-Multi-Session-Id', {0, 1}},
     {'Origin-AAA-Protocol', {0, 1}},
     {'Origin-State-Id', {0, 1}},
     {'Destination-Host', {0, 1}},
     {'Event-Timestamp', {0, 1}},
     {'Acct-Delay-Time', {0, 1}},
     {'NAS-Identifier', {0, 1}},
     {'NAS-IP-Address', {0, 1}},
     {'NAS-IPv6-Address', {0, 1}},
     {'NAS-Port', {0, 1}},
     {'NAS-Port-Id', {0, 1}},
     {'NAS-Port-Type', {0, 1}},
     {'Class', {0, '*'}},
     {'Service-Type', {0, 1}},
     {'Termination-Cause', {0, 1}},
     {'Accounting-Input-Octets', {0, 1}},
     {'Accounting-Input-Packets', {0, 1}},
     {'Accounting-Output-Octets', {0, 1}},
     {'Accounting-Output-Packets', {0, 1}},
     {'Acct-Authentic', {0, 1}},
     {'Accounting-Auth-Method', {0, 1}},
     {'Acct-Link-Count', {0, 1}},
     {'Acct-Session-Time', {0, 1}},
     {'Acct-Tunnel-Connection', {0, 1}},
     {'Acct-Tunnel-Packets-Lost', {0, 1}},
     {'Callback-Id', {0, 1}},
     {'Callback-Number', {0, 1}},
     {'Called-Station-Id', {0, 1}},
     {'Calling-Station-Id', {0, 1}},
     {'Connect-Info', {0, '*'}},
     {'Originating-Line-Info', {0, 1}},
     {'Authorization-Lifetime', {0, 1}},
     {'Session-Timeout', {0, 1}},
     {'Idle-Timeout', {0, 1}},
     {'Port-Limit', {0, 1}},
     {'Accounting-Realtime-Required', {0, 1}},
     {'Acct-Interim-Interval', {0, 1}},
     {'Filter-Id', {0, '*'}},
     {'NAS-Filter-Rule', {0, '*'}},
     {'QoS-Filter-Rule', {0, '*'}},
     {'Framed-AppleTalk-Link', {0, 1}},
     {'Framed-AppleTalk-Network', {0, 1}},
     {'Framed-AppleTalk-Zone', {0, 1}},
     {'Framed-Compression', {0, 1}},
     {'Framed-Interface-Id', {0, 1}},
     {'Framed-IP-Address', {0, 1}},
     {'Framed-IP-Netmask', {0, 1}},
     {'Framed-IPv6-Prefix', {0, '*'}},
     {'Framed-IPv6-Pool', {0, 1}},
     {'Framed-IPv6-Route', {0, '*'}},
     {'Framed-IPX-Network', {0, 1}},
     {'Framed-MTU', {0, 1}},
     {'Framed-Pool', {0, 1}},
     {'Framed-Protocol', {0, 1}},
     {'Framed-Route', {0, '*'}},
     {'Framed-Routing', {0, 1}},
     {'Login-IP-Host', {0, '*'}},
     {'Login-IPv6-Host', {0, '*'}},
     {'Login-LAT-Group', {0, 1}},
     {'Login-LAT-Node', {0, 1}},
     {'Login-LAT-Port', {0, 1}},
     {'Login-LAT-Service', {0, 1}},
     {'Login-Service', {0, 1}},
     {'Login-TCP-Port', {0, 1}},
     {'Tunneling', {0, '*'}},
     {'Proxy-Info', {0, '*'}},
     {'Route-Record', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('ACA') ->
    [{'Session-Id', 1},
     {'Result-Code', 1},
     {'Origin-Host', 1},
     {'Origin-Realm', 1},
     {'Accounting-Record-Type', 1},
     {'Accounting-Record-Number', 1},
     {'Acct-Application-Id', 1},
     {'User-Name', {0, 1}},
     {'Accounting-Sub-Session-Id', {0, 1}},
     {'Acct-Session-Id', {0, 1}},
     {'Acct-Multi-Session-Id', {0, 1}},
     {'Event-Timestamp', {0, 1}},
     {'Error-Message', {0, 1}},
     {'Error-Reporting-Host', {0, 1}},
     {'Failed-AVP', {0, '*'}},
     {'Origin-AAA-Protocol', {0, 1}},
     {'Origin-State-Id', {0, 1}},
     {'NAS-Identifier', {0, 1}},
     {'NAS-IP-Address', {0, 1}},
     {'NAS-IPv6-Address', {0, 1}},
     {'NAS-Port', {0, 1}},
     {'NAS-Port-Id', {0, 1}},
     {'NAS-Port-Type', {0, 1}},
     {'Service-Type', {0, 1}},
     {'Termination-Cause', {0, 1}},
     {'Accounting-Realtime-Required', {0, 1}},
     {'Acct-Interim-Interval', {0, 1}},
     {'Class', {0, '*'}},
     {'Proxy-Info', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('Tunneling') ->
    [{'Tunnel-Type', 1},
     {'Tunnel-Medium-Type', 1},
     {'Tunnel-Client-Endpoint', 1},
     {'Tunnel-Server-Endpoint', 1},
     {'Tunnel-Preference', {0, 1}},
     {'Tunnel-Client-Auth-Id', {0, 1}},
     {'Tunnel-Server-Auth-Id', {0, 1}},
     {'Tunnel-Assignment-Id', {0, 1}},
     {'Tunnel-Password', {0, 1}},
     {'Tunnel-Private-Group-Id', {0, 1}}];
avp_arity('Proxy-Info') ->
    [{'Proxy-Host', 1},
     {'Proxy-State', 1},
     {'AVP', {0, '*'}}];
avp_arity('Failed-AVP') -> [{'AVP', {1, '*'}}];
avp_arity('Experimental-Result') ->
    [{'Vendor-Id', 1}, {'Experimental-Result-Code', 1}];
avp_arity('Vendor-Specific-Application-Id') ->
    [{'Vendor-Id', 1},
     {'Auth-Application-Id', {0, 1}},
     {'Acct-Application-Id', {0, 1}}];
avp_arity(_) -> erlang:error(badarg).

avp_arity('ACR', 'Session-Id') -> 1;
avp_arity('ACR', 'Origin-Host') -> 1;
avp_arity('ACR', 'Origin-Realm') -> 1;
avp_arity('ACR', 'Destination-Realm') -> 1;
avp_arity('ACR', 'Accounting-Record-Type') -> 1;
avp_arity('ACR', 'Accounting-Record-Number') -> 1;
avp_arity('ACR', 'Acct-Application-Id') -> 1;
avp_arity('ACR', 'User-Name') -> {0, 1};
avp_arity('ACR', 'Accounting-Sub-Session-Id') -> {0, 1};
avp_arity('ACR', 'Acct-Session-Id') -> {0, 1};
avp_arity('ACR', 'Acct-Multi-Session-Id') -> {0, 1};
avp_arity('ACR', 'Origin-AAA-Protocol') -> {0, 1};
avp_arity('ACR', 'Origin-State-Id') -> {0, 1};
avp_arity('ACR', 'Destination-Host') -> {0, 1};
avp_arity('ACR', 'Event-Timestamp') -> {0, 1};
avp_arity('ACR', 'Acct-Delay-Time') -> {0, 1};
avp_arity('ACR', 'NAS-Identifier') -> {0, 1};
avp_arity('ACR', 'NAS-IP-Address') -> {0, 1};
avp_arity('ACR', 'NAS-IPv6-Address') -> {0, 1};
avp_arity('ACR', 'NAS-Port') -> {0, 1};
avp_arity('ACR', 'NAS-Port-Id') -> {0, 1};
avp_arity('ACR', 'NAS-Port-Type') -> {0, 1};
avp_arity('ACR', 'Class') -> {0, '*'};
avp_arity('ACR', 'Service-Type') -> {0, 1};
avp_arity('ACR', 'Termination-Cause') -> {0, 1};
avp_arity('ACR', 'Accounting-Input-Octets') -> {0, 1};
avp_arity('ACR', 'Accounting-Input-Packets') -> {0, 1};
avp_arity('ACR', 'Accounting-Output-Octets') -> {0, 1};
avp_arity('ACR', 'Accounting-Output-Packets') -> {0, 1};
avp_arity('ACR', 'Acct-Authentic') -> {0, 1};
avp_arity('ACR', 'Accounting-Auth-Method') -> {0, 1};
avp_arity('ACR', 'Acct-Link-Count') -> {0, 1};
avp_arity('ACR', 'Acct-Session-Time') -> {0, 1};
avp_arity('ACR', 'Acct-Tunnel-Connection') -> {0, 1};
avp_arity('ACR', 'Acct-Tunnel-Packets-Lost') -> {0, 1};
avp_arity('ACR', 'Callback-Id') -> {0, 1};
avp_arity('ACR', 'Callback-Number') -> {0, 1};
avp_arity('ACR', 'Called-Station-Id') -> {0, 1};
avp_arity('ACR', 'Calling-Station-Id') -> {0, 1};
avp_arity('ACR', 'Connect-Info') -> {0, '*'};
avp_arity('ACR', 'Originating-Line-Info') -> {0, 1};
avp_arity('ACR', 'Authorization-Lifetime') -> {0, 1};
avp_arity('ACR', 'Session-Timeout') -> {0, 1};
avp_arity('ACR', 'Idle-Timeout') -> {0, 1};
avp_arity('ACR', 'Port-Limit') -> {0, 1};
avp_arity('ACR', 'Accounting-Realtime-Required') ->
    {0, 1};
avp_arity('ACR', 'Acct-Interim-Interval') -> {0, 1};
avp_arity('ACR', 'Filter-Id') -> {0, '*'};
avp_arity('ACR', 'NAS-Filter-Rule') -> {0, '*'};
avp_arity('ACR', 'QoS-Filter-Rule') -> {0, '*'};
avp_arity('ACR', 'Framed-AppleTalk-Link') -> {0, 1};
avp_arity('ACR', 'Framed-AppleTalk-Network') -> {0, 1};
avp_arity('ACR', 'Framed-AppleTalk-Zone') -> {0, 1};
avp_arity('ACR', 'Framed-Compression') -> {0, 1};
avp_arity('ACR', 'Framed-Interface-Id') -> {0, 1};
avp_arity('ACR', 'Framed-IP-Address') -> {0, 1};
avp_arity('ACR', 'Framed-IP-Netmask') -> {0, 1};
avp_arity('ACR', 'Framed-IPv6-Prefix') -> {0, '*'};
avp_arity('ACR', 'Framed-IPv6-Pool') -> {0, 1};
avp_arity('ACR', 'Framed-IPv6-Route') -> {0, '*'};
avp_arity('ACR', 'Framed-IPX-Network') -> {0, 1};
avp_arity('ACR', 'Framed-MTU') -> {0, 1};
avp_arity('ACR', 'Framed-Pool') -> {0, 1};
avp_arity('ACR', 'Framed-Protocol') -> {0, 1};
avp_arity('ACR', 'Framed-Route') -> {0, '*'};
avp_arity('ACR', 'Framed-Routing') -> {0, 1};
avp_arity('ACR', 'Login-IP-Host') -> {0, '*'};
avp_arity('ACR', 'Login-IPv6-Host') -> {0, '*'};
avp_arity('ACR', 'Login-LAT-Group') -> {0, 1};
avp_arity('ACR', 'Login-LAT-Node') -> {0, 1};
avp_arity('ACR', 'Login-LAT-Port') -> {0, 1};
avp_arity('ACR', 'Login-LAT-Service') -> {0, 1};
avp_arity('ACR', 'Login-Service') -> {0, 1};
avp_arity('ACR', 'Login-TCP-Port') -> {0, 1};
avp_arity('ACR', 'Tunneling') -> {0, '*'};
avp_arity('ACR', 'Proxy-Info') -> {0, '*'};
avp_arity('ACR', 'Route-Record') -> {0, '*'};
avp_arity('ACR', 'AVP') -> {0, '*'};
avp_arity('ACA', 'Session-Id') -> 1;
avp_arity('ACA', 'Result-Code') -> 1;
avp_arity('ACA', 'Origin-Host') -> 1;
avp_arity('ACA', 'Origin-Realm') -> 1;
avp_arity('ACA', 'Accounting-Record-Type') -> 1;
avp_arity('ACA', 'Accounting-Record-Number') -> 1;
avp_arity('ACA', 'Acct-Application-Id') -> 1;
avp_arity('ACA', 'User-Name') -> {0, 1};
avp_arity('ACA', 'Accounting-Sub-Session-Id') -> {0, 1};
avp_arity('ACA', 'Acct-Session-Id') -> {0, 1};
avp_arity('ACA', 'Acct-Multi-Session-Id') -> {0, 1};
avp_arity('ACA', 'Event-Timestamp') -> {0, 1};
avp_arity('ACA', 'Error-Message') -> {0, 1};
avp_arity('ACA', 'Error-Reporting-Host') -> {0, 1};
avp_arity('ACA', 'Failed-AVP') -> {0, '*'};
avp_arity('ACA', 'Origin-AAA-Protocol') -> {0, 1};
avp_arity('ACA', 'Origin-State-Id') -> {0, 1};
avp_arity('ACA', 'NAS-Identifier') -> {0, 1};
avp_arity('ACA', 'NAS-IP-Address') -> {0, 1};
avp_arity('ACA', 'NAS-IPv6-Address') -> {0, 1};
avp_arity('ACA', 'NAS-Port') -> {0, 1};
avp_arity('ACA', 'NAS-Port-Id') -> {0, 1};
avp_arity('ACA', 'NAS-Port-Type') -> {0, 1};
avp_arity('ACA', 'Service-Type') -> {0, 1};
avp_arity('ACA', 'Termination-Cause') -> {0, 1};
avp_arity('ACA', 'Accounting-Realtime-Required') ->
    {0, 1};
avp_arity('ACA', 'Acct-Interim-Interval') -> {0, 1};
avp_arity('ACA', 'Class') -> {0, '*'};
avp_arity('ACA', 'Proxy-Info') -> {0, '*'};
avp_arity('ACA', 'AVP') -> {0, '*'};
avp_arity('Tunneling', 'Tunnel-Type') -> 1;
avp_arity('Tunneling', 'Tunnel-Medium-Type') -> 1;
avp_arity('Tunneling', 'Tunnel-Client-Endpoint') -> 1;
avp_arity('Tunneling', 'Tunnel-Server-Endpoint') -> 1;
avp_arity('Tunneling', 'Tunnel-Preference') -> {0, 1};
avp_arity('Tunneling', 'Tunnel-Client-Auth-Id') ->
    {0, 1};
avp_arity('Tunneling', 'Tunnel-Server-Auth-Id') ->
    {0, 1};
avp_arity('Tunneling', 'Tunnel-Assignment-Id') ->
    {0, 1};
avp_arity('Tunneling', 'Tunnel-Password') -> {0, 1};
avp_arity('Tunneling', 'Tunnel-Private-Group-Id') ->
    {0, 1};
avp_arity('Proxy-Info', 'Proxy-Host') -> 1;
avp_arity('Proxy-Info', 'Proxy-State') -> 1;
avp_arity('Proxy-Info', 'AVP') -> {0, '*'};
avp_arity('Failed-AVP', 'AVP') -> {1, '*'};
avp_arity('Experimental-Result', 'Vendor-Id') -> 1;
avp_arity('Experimental-Result',
          'Experimental-Result-Code') ->
    1;
avp_arity('Vendor-Specific-Application-Id',
          'Vendor-Id') ->
    1;
avp_arity('Vendor-Specific-Application-Id',
          'Auth-Application-Id') ->
    {0, 1};
avp_arity('Vendor-Specific-Application-Id',
          'Acct-Application-Id') ->
    {0, 1};
avp_arity(_, _) -> 0.

avp_header('Accounting-Auth-Method') ->
    {406, 64, undefined};
avp_header('Accounting-Input-Octets') ->
    {363, 64, undefined};
avp_header('Accounting-Input-Packets') ->
    {365, 64, undefined};
avp_header('Accounting-Output-Octets') ->
    {364, 64, undefined};
avp_header('Accounting-Output-Packets') ->
    {366, 64, undefined};
avp_header('Acct-Authentic') -> {45, 64, undefined};
avp_header('Acct-Delay-Time') -> {41, 64, undefined};
avp_header('Acct-Link-Count') -> {51, 64, undefined};
avp_header('Acct-Session-Time') -> {46, 64, undefined};
avp_header('Acct-Tunnel-Connection') ->
    {68, 64, undefined};
avp_header('Acct-Tunnel-Packets-Lost') ->
    {86, 64, undefined};
avp_header('Callback-Id') -> {20, 64, undefined};
avp_header('Callback-Number') -> {19, 64, undefined};
avp_header('Called-Station-Id') -> {30, 64, undefined};
avp_header('Calling-Station-Id') -> {31, 64, undefined};
avp_header('Connect-Info') -> {77, 64, undefined};
avp_header('Filter-Id') -> {11, 64, undefined};
avp_header('Framed-AppleTalk-Link') ->
    {37, 64, undefined};
avp_header('Framed-AppleTalk-Network') ->
    {38, 64, undefined};
avp_header('Framed-AppleTalk-Zone') ->
    {39, 64, undefined};
avp_header('Framed-Compression') -> {13, 64, undefined};
avp_header('Framed-IP-Address') -> {8, 64, undefined};
avp_header('Framed-IP-Netmask') -> {9, 64, undefined};
avp_header('Framed-IPX-Network') -> {23, 64, undefined};
avp_header('Framed-IPv6-Pool') -> {100, 64, undefined};
avp_header('Framed-IPv6-Prefix') -> {97, 64, undefined};
avp_header('Framed-IPv6-Route') -> {99, 64, undefined};
avp_header('Framed-Interface-Id') ->
    {96, 64, undefined};
avp_header('Framed-MTU') -> {12, 64, undefined};
avp_header('Framed-Pool') -> {88, 64, undefined};
avp_header('Framed-Protocol') -> {7, 64, undefined};
avp_header('Framed-Route') -> {22, 64, undefined};
avp_header('Framed-Routing') -> {10, 64, undefined};
avp_header('Idle-Timeout') -> {28, 64, undefined};
avp_header('Login-IP-Host') -> {14, 64, undefined};
avp_header('Login-IPv6-Host') -> {98, 64, undefined};
avp_header('Login-LAT-Group') -> {36, 64, undefined};
avp_header('Login-LAT-Node') -> {35, 64, undefined};
avp_header('Login-LAT-Port') -> {63, 64, undefined};
avp_header('Login-LAT-Service') -> {34, 64, undefined};
avp_header('Login-Service') -> {15, 64, undefined};
avp_header('Login-TCP-Port') -> {16, 64, undefined};
avp_header('NAS-Filter-Rule') -> {400, 64, undefined};
avp_header('NAS-IP-Address') -> {4, 64, undefined};
avp_header('NAS-IPv6-Address') -> {95, 64, undefined};
avp_header('NAS-Identifier') -> {32, 64, undefined};
avp_header('NAS-Port') -> {5, 64, undefined};
avp_header('NAS-Port-Id') -> {87, 64, undefined};
avp_header('NAS-Port-Type') -> {61, 64, undefined};
avp_header('Origin-AAA-Protocol') ->
    {408, 64, undefined};
avp_header('Originating-Line-Info') ->
    {94, 64, undefined};
avp_header('Port-Limit') -> {62, 64, undefined};
avp_header('QoS-Filter-Rule') -> {407, 64, undefined};
avp_header('Service-Type') -> {6, 64, undefined};
avp_header('Tunnel-Assignment-Id') ->
    {82, 64, undefined};
avp_header('Tunnel-Client-Auth-Id') ->
    {90, 64, undefined};
avp_header('Tunnel-Client-Endpoint') ->
    {66, 64, undefined};
avp_header('Tunnel-Medium-Type') -> {65, 64, undefined};
avp_header('Tunnel-Password') -> {69, 64, undefined};
avp_header('Tunnel-Preference') -> {83, 64, undefined};
avp_header('Tunnel-Private-Group-Id') ->
    {81, 64, undefined};
avp_header('Tunnel-Server-Auth-Id') ->
    {91, 64, undefined};
avp_header('Tunnel-Server-Endpoint') ->
    {67, 64, undefined};
avp_header('Tunnel-Type') -> {64, 64, undefined};
avp_header('Tunneling') -> {401, 64, undefined};
avp_header('Accounting-Realtime-Required') ->
    diameter_gen_base_rfc6733:avp_header('Accounting-Realtime-Required');
avp_header('Accounting-Record-Number') ->
    diameter_gen_base_rfc6733:avp_header('Accounting-Record-Number');
avp_header('Accounting-Record-Type') ->
    diameter_gen_base_rfc6733:avp_header('Accounting-Record-Type');
avp_header('Accounting-Sub-Session-Id') ->
    diameter_gen_base_rfc6733:avp_header('Accounting-Sub-Session-Id');
avp_header('Acct-Application-Id') ->
    diameter_gen_base_rfc6733:avp_header('Acct-Application-Id');
avp_header('Acct-Interim-Interval') ->
    diameter_gen_base_rfc6733:avp_header('Acct-Interim-Interval');
avp_header('Acct-Multi-Session-Id') ->
    diameter_gen_base_rfc6733:avp_header('Acct-Multi-Session-Id');
avp_header('Acct-Session-Id') ->
    diameter_gen_base_rfc6733:avp_header('Acct-Session-Id');
avp_header('Auth-Application-Id') ->
    diameter_gen_base_rfc6733:avp_header('Auth-Application-Id');
avp_header('Auth-Grace-Period') ->
    diameter_gen_base_rfc6733:avp_header('Auth-Grace-Period');
avp_header('Auth-Request-Type') ->
    diameter_gen_base_rfc6733:avp_header('Auth-Request-Type');
avp_header('Auth-Session-State') ->
    diameter_gen_base_rfc6733:avp_header('Auth-Session-State');
avp_header('Authorization-Lifetime') ->
    diameter_gen_base_rfc6733:avp_header('Authorization-Lifetime');
avp_header('Class') ->
    diameter_gen_base_rfc6733:avp_header('Class');
avp_header('Destination-Host') ->
    diameter_gen_base_rfc6733:avp_header('Destination-Host');
avp_header('Destination-Realm') ->
    diameter_gen_base_rfc6733:avp_header('Destination-Realm');
avp_header('Disconnect-Cause') ->
    diameter_gen_base_rfc6733:avp_header('Disconnect-Cause');
avp_header('Error-Message') ->
    diameter_gen_base_rfc6733:avp_header('Error-Message');
avp_header('Error-Reporting-Host') ->
    diameter_gen_base_rfc6733:avp_header('Error-Reporting-Host');
avp_header('Event-Timestamp') ->
    diameter_gen_base_rfc6733:avp_header('Event-Timestamp');
avp_header('Experimental-Result') ->
    diameter_gen_base_rfc6733:avp_header('Experimental-Result');
avp_header('Experimental-Result-Code') ->
    diameter_gen_base_rfc6733:avp_header('Experimental-Result-Code');
avp_header('Failed-AVP') ->
    diameter_gen_base_rfc6733:avp_header('Failed-AVP');
avp_header('Firmware-Revision') ->
    diameter_gen_base_rfc6733:avp_header('Firmware-Revision');
avp_header('Host-IP-Address') ->
    diameter_gen_base_rfc6733:avp_header('Host-IP-Address');
avp_header('Inband-Security-Id') ->
    diameter_gen_base_rfc6733:avp_header('Inband-Security-Id');
avp_header('Multi-Round-Time-Out') ->
    diameter_gen_base_rfc6733:avp_header('Multi-Round-Time-Out');
avp_header('Origin-Host') ->
    diameter_gen_base_rfc6733:avp_header('Origin-Host');
avp_header('Origin-Realm') ->
    diameter_gen_base_rfc6733:avp_header('Origin-Realm');
avp_header('Origin-State-Id') ->
    diameter_gen_base_rfc6733:avp_header('Origin-State-Id');
avp_header('Product-Name') ->
    diameter_gen_base_rfc6733:avp_header('Product-Name');
avp_header('Proxy-Host') ->
    diameter_gen_base_rfc6733:avp_header('Proxy-Host');
avp_header('Proxy-Info') ->
    diameter_gen_base_rfc6733:avp_header('Proxy-Info');
avp_header('Proxy-State') ->
    diameter_gen_base_rfc6733:avp_header('Proxy-State');
avp_header('Re-Auth-Request-Type') ->
    diameter_gen_base_rfc6733:avp_header('Re-Auth-Request-Type');
avp_header('Redirect-Host') ->
    diameter_gen_base_rfc6733:avp_header('Redirect-Host');
avp_header('Redirect-Host-Usage') ->
    diameter_gen_base_rfc6733:avp_header('Redirect-Host-Usage');
avp_header('Redirect-Max-Cache-Time') ->
    diameter_gen_base_rfc6733:avp_header('Redirect-Max-Cache-Time');
avp_header('Result-Code') ->
    diameter_gen_base_rfc6733:avp_header('Result-Code');
avp_header('Route-Record') ->
    diameter_gen_base_rfc6733:avp_header('Route-Record');
avp_header('Session-Binding') ->
    diameter_gen_base_rfc6733:avp_header('Session-Binding');
avp_header('Session-Id') ->
    diameter_gen_base_rfc6733:avp_header('Session-Id');
avp_header('Session-Server-Failover') ->
    diameter_gen_base_rfc6733:avp_header('Session-Server-Failover');
avp_header('Session-Timeout') ->
    diameter_gen_base_rfc6733:avp_header('Session-Timeout');
avp_header('Supported-Vendor-Id') ->
    diameter_gen_base_rfc6733:avp_header('Supported-Vendor-Id');
avp_header('Termination-Cause') ->
    diameter_gen_base_rfc6733:avp_header('Termination-Cause');
avp_header('User-Name') ->
    diameter_gen_base_rfc6733:avp_header('User-Name');
avp_header('Vendor-Id') ->
    diameter_gen_base_rfc6733:avp_header('Vendor-Id');
avp_header('Vendor-Specific-Application-Id') ->
    diameter_gen_base_rfc6733:avp_header('Vendor-Specific-Application-Id');
avp_header(_) -> erlang:error(badarg).

avp(T, Data, 'Accounting-Auth-Method', _) ->
    enumerated_avp(T, 'Accounting-Auth-Method', Data);
avp(T, Data, 'Accounting-Input-Octets', Opts) ->
    diameter_types:'Unsigned64'(T, Data, Opts);
avp(T, Data, 'Accounting-Input-Packets', Opts) ->
    diameter_types:'Unsigned64'(T, Data, Opts);
avp(T, Data, 'Accounting-Output-Octets', Opts) ->
    diameter_types:'Unsigned64'(T, Data, Opts);
avp(T, Data, 'Accounting-Output-Packets', Opts) ->
    diameter_types:'Unsigned64'(T, Data, Opts);
avp(T, Data, 'Acct-Authentic', _) ->
    enumerated_avp(T, 'Acct-Authentic', Data);
avp(T, Data, 'Acct-Delay-Time', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'Acct-Link-Count', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'Acct-Session-Time', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'Acct-Tunnel-Connection', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Acct-Tunnel-Packets-Lost', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'Callback-Id', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Callback-Number', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Called-Station-Id', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Calling-Station-Id', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Connect-Info', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Filter-Id', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Framed-AppleTalk-Link', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'Framed-AppleTalk-Network', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'Framed-AppleTalk-Zone', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Framed-Compression', _) ->
    enumerated_avp(T, 'Framed-Compression', Data);
avp(T, Data, 'Framed-IP-Address', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Framed-IP-Netmask', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Framed-IPX-Network', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'Framed-IPv6-Pool', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Framed-IPv6-Prefix', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Framed-IPv6-Route', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Framed-Interface-Id', Opts) ->
    diameter_types:'Unsigned64'(T, Data, Opts);
avp(T, Data, 'Framed-MTU', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'Framed-Pool', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Framed-Protocol', _) ->
    enumerated_avp(T, 'Framed-Protocol', Data);
avp(T, Data, 'Framed-Route', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Framed-Routing', _) ->
    enumerated_avp(T, 'Framed-Routing', Data);
avp(T, Data, 'Idle-Timeout', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'Login-IP-Host', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Login-IPv6-Host', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Login-LAT-Group', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Login-LAT-Node', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Login-LAT-Port', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Login-LAT-Service', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Login-Service', _) ->
    enumerated_avp(T, 'Login-Service', Data);
avp(T, Data, 'Login-TCP-Port', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'NAS-Filter-Rule', Opts) ->
    diameter_types:'IPFilterRule'(T, Data, Opts);
avp(T, Data, 'NAS-IP-Address', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'NAS-IPv6-Address', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'NAS-Identifier', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'NAS-Port', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'NAS-Port-Id', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'NAS-Port-Type', _) ->
    enumerated_avp(T, 'NAS-Port-Type', Data);
avp(T, Data, 'Origin-AAA-Protocol', _) ->
    enumerated_avp(T, 'Origin-AAA-Protocol', Data);
avp(T, Data, 'Originating-Line-Info', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Port-Limit', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'QoS-Filter-Rule', Opts) ->
    diameter_types:'QoSFilterRule'(T, Data, Opts);
avp(T, Data, 'Service-Type', _) ->
    enumerated_avp(T, 'Service-Type', Data);
avp(T, Data, 'Tunnel-Assignment-Id', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Tunnel-Client-Auth-Id', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Tunnel-Client-Endpoint', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Tunnel-Medium-Type', _) ->
    enumerated_avp(T, 'Tunnel-Medium-Type', Data);
avp(T, Data, 'Tunnel-Password', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Tunnel-Preference', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'Tunnel-Private-Group-Id', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'Tunnel-Server-Auth-Id', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Tunnel-Server-Endpoint', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'Tunnel-Type', _) ->
    enumerated_avp(T, 'Tunnel-Type', Data);
avp(T, Data, 'Tunneling', Opts) ->
    grouped_avp(T, 'Tunneling', Data, Opts);
avp(T, Data, 'Accounting-Realtime-Required', Opts) ->
    avp(T,
        Data,
        'Accounting-Realtime-Required',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Accounting-Record-Number', Opts) ->
    avp(T,
        Data,
        'Accounting-Record-Number',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Accounting-Record-Type', Opts) ->
    avp(T,
        Data,
        'Accounting-Record-Type',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Accounting-Sub-Session-Id', Opts) ->
    avp(T,
        Data,
        'Accounting-Sub-Session-Id',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Acct-Application-Id', Opts) ->
    avp(T,
        Data,
        'Acct-Application-Id',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Acct-Interim-Interval', Opts) ->
    avp(T,
        Data,
        'Acct-Interim-Interval',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Acct-Multi-Session-Id', Opts) ->
    avp(T,
        Data,
        'Acct-Multi-Session-Id',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Acct-Session-Id', Opts) ->
    avp(T,
        Data,
        'Acct-Session-Id',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Auth-Application-Id', Opts) ->
    avp(T,
        Data,
        'Auth-Application-Id',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Auth-Grace-Period', Opts) ->
    avp(T,
        Data,
        'Auth-Grace-Period',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Auth-Request-Type', Opts) ->
    avp(T,
        Data,
        'Auth-Request-Type',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Auth-Session-State', Opts) ->
    avp(T,
        Data,
        'Auth-Session-State',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Authorization-Lifetime', Opts) ->
    avp(T,
        Data,
        'Authorization-Lifetime',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Class', Opts) ->
    avp(T, Data, 'Class', Opts, diameter_gen_base_rfc6733);
avp(T, Data, 'Destination-Host', Opts) ->
    avp(T,
        Data,
        'Destination-Host',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Destination-Realm', Opts) ->
    avp(T,
        Data,
        'Destination-Realm',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Disconnect-Cause', Opts) ->
    avp(T,
        Data,
        'Disconnect-Cause',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Error-Message', Opts) ->
    avp(T,
        Data,
        'Error-Message',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Error-Reporting-Host', Opts) ->
    avp(T,
        Data,
        'Error-Reporting-Host',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Event-Timestamp', Opts) ->
    avp(T,
        Data,
        'Event-Timestamp',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Experimental-Result', Opts) ->
    grouped_avp(T, 'Experimental-Result', Data, Opts);
avp(T, Data, 'Experimental-Result-Code', Opts) ->
    avp(T,
        Data,
        'Experimental-Result-Code',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Failed-AVP', Opts) ->
    grouped_avp(T, 'Failed-AVP', Data, Opts);
avp(T, Data, 'Firmware-Revision', Opts) ->
    avp(T,
        Data,
        'Firmware-Revision',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Host-IP-Address', Opts) ->
    avp(T,
        Data,
        'Host-IP-Address',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Inband-Security-Id', Opts) ->
    avp(T,
        Data,
        'Inband-Security-Id',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Multi-Round-Time-Out', Opts) ->
    avp(T,
        Data,
        'Multi-Round-Time-Out',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Origin-Host', Opts) ->
    avp(T,
        Data,
        'Origin-Host',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Origin-Realm', Opts) ->
    avp(T,
        Data,
        'Origin-Realm',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Origin-State-Id', Opts) ->
    avp(T,
        Data,
        'Origin-State-Id',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Product-Name', Opts) ->
    avp(T,
        Data,
        'Product-Name',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Proxy-Host', Opts) ->
    avp(T,
        Data,
        'Proxy-Host',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Proxy-Info', Opts) ->
    grouped_avp(T, 'Proxy-Info', Data, Opts);
avp(T, Data, 'Proxy-State', Opts) ->
    avp(T,
        Data,
        'Proxy-State',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Re-Auth-Request-Type', Opts) ->
    avp(T,
        Data,
        'Re-Auth-Request-Type',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Redirect-Host', Opts) ->
    avp(T,
        Data,
        'Redirect-Host',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Redirect-Host-Usage', Opts) ->
    avp(T,
        Data,
        'Redirect-Host-Usage',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Redirect-Max-Cache-Time', Opts) ->
    avp(T,
        Data,
        'Redirect-Max-Cache-Time',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Result-Code', Opts) ->
    avp(T,
        Data,
        'Result-Code',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Route-Record', Opts) ->
    avp(T,
        Data,
        'Route-Record',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Session-Binding', Opts) ->
    avp(T,
        Data,
        'Session-Binding',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Session-Id', Opts) ->
    avp(T,
        Data,
        'Session-Id',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Session-Server-Failover', Opts) ->
    avp(T,
        Data,
        'Session-Server-Failover',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Session-Timeout', Opts) ->
    avp(T,
        Data,
        'Session-Timeout',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Supported-Vendor-Id', Opts) ->
    avp(T,
        Data,
        'Supported-Vendor-Id',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Termination-Cause', Opts) ->
    avp(T,
        Data,
        'Termination-Cause',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'User-Name', Opts) ->
    avp(T,
        Data,
        'User-Name',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Vendor-Id', Opts) ->
    avp(T,
        Data,
        'Vendor-Id',
        Opts,
        diameter_gen_base_rfc6733);
avp(T, Data, 'Vendor-Specific-Application-Id', Opts) ->
    grouped_avp(T,
                'Vendor-Specific-Application-Id',
                Data,
                Opts);
avp(_, _, _, _) -> erlang:error(badarg).

enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 0>>) ->
    0;
enumerated_avp(encode, 'Service-Type', 0) ->
    <<0, 0, 0, 0>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 1>>) ->
    1;
enumerated_avp(encode, 'Service-Type', 1) ->
    <<0, 0, 0, 1>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 2>>) ->
    2;
enumerated_avp(encode, 'Service-Type', 2) ->
    <<0, 0, 0, 2>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 3>>) ->
    3;
enumerated_avp(encode, 'Service-Type', 3) ->
    <<0, 0, 0, 3>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 4>>) ->
    4;
enumerated_avp(encode, 'Service-Type', 4) ->
    <<0, 0, 0, 4>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 5>>) ->
    5;
enumerated_avp(encode, 'Service-Type', 5) ->
    <<0, 0, 0, 5>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 6>>) ->
    6;
enumerated_avp(encode, 'Service-Type', 6) ->
    <<0, 0, 0, 6>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 7>>) ->
    7;
enumerated_avp(encode, 'Service-Type', 7) ->
    <<0, 0, 0, 7>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 8>>) ->
    8;
enumerated_avp(encode, 'Service-Type', 8) ->
    <<0, 0, 0, 8>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 9>>) ->
    9;
enumerated_avp(encode, 'Service-Type', 9) ->
    <<0, 0, 0, 9>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 10>>) ->
    10;
enumerated_avp(encode, 'Service-Type', 10) ->
    <<0, 0, 0, 10>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 11>>) ->
    11;
enumerated_avp(encode, 'Service-Type', 11) ->
    <<0, 0, 0, 11>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 12>>) ->
    12;
enumerated_avp(encode, 'Service-Type', 12) ->
    <<0, 0, 0, 12>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 13>>) ->
    13;
enumerated_avp(encode, 'Service-Type', 13) ->
    <<0, 0, 0, 13>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 14>>) ->
    14;
enumerated_avp(encode, 'Service-Type', 14) ->
    <<0, 0, 0, 14>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 15>>) ->
    15;
enumerated_avp(encode, 'Service-Type', 15) ->
    <<0, 0, 0, 15>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 16>>) ->
    16;
enumerated_avp(encode, 'Service-Type', 16) ->
    <<0, 0, 0, 16>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 17>>) ->
    17;
enumerated_avp(encode, 'Service-Type', 17) ->
    <<0, 0, 0, 17>>;
enumerated_avp(decode, 'Service-Type',
               <<0, 0, 0, 18>>) ->
    18;
enumerated_avp(encode, 'Service-Type', 18) ->
    <<0, 0, 0, 18>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 0, 1>>) ->
    1;
enumerated_avp(encode, 'Framed-Protocol', 1) ->
    <<0, 0, 0, 1>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 0, 2>>) ->
    2;
enumerated_avp(encode, 'Framed-Protocol', 2) ->
    <<0, 0, 0, 2>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 0, 3>>) ->
    3;
enumerated_avp(encode, 'Framed-Protocol', 3) ->
    <<0, 0, 0, 3>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 0, 4>>) ->
    4;
enumerated_avp(encode, 'Framed-Protocol', 4) ->
    <<0, 0, 0, 4>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 0, 5>>) ->
    5;
enumerated_avp(encode, 'Framed-Protocol', 5) ->
    <<0, 0, 0, 5>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 0, 6>>) ->
    6;
enumerated_avp(encode, 'Framed-Protocol', 6) ->
    <<0, 0, 0, 6>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 0, 7>>) ->
    7;
enumerated_avp(encode, 'Framed-Protocol', 7) ->
    <<0, 0, 0, 7>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 0, 255>>) ->
    255;
enumerated_avp(encode, 'Framed-Protocol', 255) ->
    <<0, 0, 0, 255>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 1, 0>>) ->
    256;
enumerated_avp(encode, 'Framed-Protocol', 256) ->
    <<0, 0, 1, 0>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 1, 1>>) ->
    257;
enumerated_avp(encode, 'Framed-Protocol', 257) ->
    <<0, 0, 1, 1>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 1, 2>>) ->
    258;
enumerated_avp(encode, 'Framed-Protocol', 258) ->
    <<0, 0, 1, 2>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 1, 3>>) ->
    259;
enumerated_avp(encode, 'Framed-Protocol', 259) ->
    <<0, 0, 1, 3>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 1, 4>>) ->
    260;
enumerated_avp(encode, 'Framed-Protocol', 260) ->
    <<0, 0, 1, 4>>;
enumerated_avp(decode, 'Framed-Protocol',
               <<0, 0, 1, 5>>) ->
    261;
enumerated_avp(encode, 'Framed-Protocol', 261) ->
    <<0, 0, 1, 5>>;
enumerated_avp(decode, 'Framed-Routing',
               <<0, 0, 0, 0>>) ->
    0;
enumerated_avp(encode, 'Framed-Routing', 0) ->
    <<0, 0, 0, 0>>;
enumerated_avp(decode, 'Framed-Routing',
               <<0, 0, 0, 1>>) ->
    1;
enumerated_avp(encode, 'Framed-Routing', 1) ->
    <<0, 0, 0, 1>>;
enumerated_avp(decode, 'Framed-Routing',
               <<0, 0, 0, 2>>) ->
    2;
enumerated_avp(encode, 'Framed-Routing', 2) ->
    <<0, 0, 0, 2>>;
enumerated_avp(decode, 'Framed-Routing',
               <<0, 0, 0, 3>>) ->
    3;
enumerated_avp(encode, 'Framed-Routing', 3) ->
    <<0, 0, 0, 3>>;
enumerated_avp(decode, 'Framed-Compression',
               <<0, 0, 0, 0>>) ->
    0;
enumerated_avp(encode, 'Framed-Compression', 0) ->
    <<0, 0, 0, 0>>;
enumerated_avp(decode, 'Framed-Compression',
               <<0, 0, 0, 2>>) ->
    2;
enumerated_avp(encode, 'Framed-Compression', 2) ->
    <<0, 0, 0, 2>>;
enumerated_avp(decode, 'Framed-Compression',
               <<0, 0, 0, 3>>) ->
    3;
enumerated_avp(encode, 'Framed-Compression', 3) ->
    <<0, 0, 0, 3>>;
enumerated_avp(decode, 'Login-Service',
               <<0, 0, 0, 0>>) ->
    0;
enumerated_avp(encode, 'Login-Service', 0) ->
    <<0, 0, 0, 0>>;
enumerated_avp(decode, 'Login-Service',
               <<0, 0, 0, 1>>) ->
    1;
enumerated_avp(encode, 'Login-Service', 1) ->
    <<0, 0, 0, 1>>;
enumerated_avp(decode, 'Login-Service',
               <<0, 0, 0, 2>>) ->
    2;
enumerated_avp(encode, 'Login-Service', 2) ->
    <<0, 0, 0, 2>>;
enumerated_avp(decode, 'Login-Service',
               <<0, 0, 0, 3>>) ->
    3;
enumerated_avp(encode, 'Login-Service', 3) ->
    <<0, 0, 0, 3>>;
enumerated_avp(decode, 'Login-Service',
               <<0, 0, 0, 4>>) ->
    4;
enumerated_avp(encode, 'Login-Service', 4) ->
    <<0, 0, 0, 4>>;
enumerated_avp(decode, 'Login-Service',
               <<0, 0, 0, 5>>) ->
    5;
enumerated_avp(encode, 'Login-Service', 5) ->
    <<0, 0, 0, 5>>;
enumerated_avp(decode, 'Login-Service',
               <<0, 0, 0, 6>>) ->
    6;
enumerated_avp(encode, 'Login-Service', 6) ->
    <<0, 0, 0, 6>>;
enumerated_avp(decode, 'Login-Service',
               <<0, 0, 0, 7>>) ->
    7;
enumerated_avp(encode, 'Login-Service', 7) ->
    <<0, 0, 0, 7>>;
enumerated_avp(decode, 'Acct-Authentic',
               <<0, 0, 0, 0>>) ->
    0;
enumerated_avp(encode, 'Acct-Authentic', 0) ->
    <<0, 0, 0, 0>>;
enumerated_avp(decode, 'Acct-Authentic',
               <<0, 0, 0, 1>>) ->
    1;
enumerated_avp(encode, 'Acct-Authentic', 1) ->
    <<0, 0, 0, 1>>;
enumerated_avp(decode, 'Acct-Authentic',
               <<0, 0, 0, 2>>) ->
    2;
enumerated_avp(encode, 'Acct-Authentic', 2) ->
    <<0, 0, 0, 2>>;
enumerated_avp(decode, 'Acct-Authentic',
               <<0, 0, 0, 3>>) ->
    3;
enumerated_avp(encode, 'Acct-Authentic', 3) ->
    <<0, 0, 0, 3>>;
enumerated_avp(decode, 'Acct-Authentic',
               <<0, 0, 0, 4>>) ->
    4;
enumerated_avp(encode, 'Acct-Authentic', 4) ->
    <<0, 0, 0, 4>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 0>>) ->
    0;
enumerated_avp(encode, 'NAS-Port-Type', 0) ->
    <<0, 0, 0, 0>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 1>>) ->
    1;
enumerated_avp(encode, 'NAS-Port-Type', 1) ->
    <<0, 0, 0, 1>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 2>>) ->
    2;
enumerated_avp(encode, 'NAS-Port-Type', 2) ->
    <<0, 0, 0, 2>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 3>>) ->
    3;
enumerated_avp(encode, 'NAS-Port-Type', 3) ->
    <<0, 0, 0, 3>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 4>>) ->
    4;
enumerated_avp(encode, 'NAS-Port-Type', 4) ->
    <<0, 0, 0, 4>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 5>>) ->
    5;
enumerated_avp(encode, 'NAS-Port-Type', 5) ->
    <<0, 0, 0, 5>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 6>>) ->
    6;
enumerated_avp(encode, 'NAS-Port-Type', 6) ->
    <<0, 0, 0, 6>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 7>>) ->
    7;
enumerated_avp(encode, 'NAS-Port-Type', 7) ->
    <<0, 0, 0, 7>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 8>>) ->
    8;
enumerated_avp(encode, 'NAS-Port-Type', 8) ->
    <<0, 0, 0, 8>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 9>>) ->
    9;
enumerated_avp(encode, 'NAS-Port-Type', 9) ->
    <<0, 0, 0, 9>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 10>>) ->
    10;
enumerated_avp(encode, 'NAS-Port-Type', 10) ->
    <<0, 0, 0, 10>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 11>>) ->
    11;
enumerated_avp(encode, 'NAS-Port-Type', 11) ->
    <<0, 0, 0, 11>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 14>>) ->
    14;
enumerated_avp(encode, 'NAS-Port-Type', 14) ->
    <<0, 0, 0, 14>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 15>>) ->
    15;
enumerated_avp(encode, 'NAS-Port-Type', 15) ->
    <<0, 0, 0, 15>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 16>>) ->
    16;
enumerated_avp(encode, 'NAS-Port-Type', 16) ->
    <<0, 0, 0, 16>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 17>>) ->
    17;
enumerated_avp(encode, 'NAS-Port-Type', 17) ->
    <<0, 0, 0, 17>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 18>>) ->
    18;
enumerated_avp(encode, 'NAS-Port-Type', 18) ->
    <<0, 0, 0, 18>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 19>>) ->
    19;
enumerated_avp(encode, 'NAS-Port-Type', 19) ->
    <<0, 0, 0, 19>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 20>>) ->
    20;
enumerated_avp(encode, 'NAS-Port-Type', 20) ->
    <<0, 0, 0, 20>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 21>>) ->
    21;
enumerated_avp(encode, 'NAS-Port-Type', 21) ->
    <<0, 0, 0, 21>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 22>>) ->
    22;
enumerated_avp(encode, 'NAS-Port-Type', 22) ->
    <<0, 0, 0, 22>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 23>>) ->
    23;
enumerated_avp(encode, 'NAS-Port-Type', 23) ->
    <<0, 0, 0, 23>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 24>>) ->
    24;
enumerated_avp(encode, 'NAS-Port-Type', 24) ->
    <<0, 0, 0, 24>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 25>>) ->
    25;
enumerated_avp(encode, 'NAS-Port-Type', 25) ->
    <<0, 0, 0, 25>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 26>>) ->
    26;
enumerated_avp(encode, 'NAS-Port-Type', 26) ->
    <<0, 0, 0, 26>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 27>>) ->
    27;
enumerated_avp(encode, 'NAS-Port-Type', 27) ->
    <<0, 0, 0, 27>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 28>>) ->
    28;
enumerated_avp(encode, 'NAS-Port-Type', 28) ->
    <<0, 0, 0, 28>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 29>>) ->
    29;
enumerated_avp(encode, 'NAS-Port-Type', 29) ->
    <<0, 0, 0, 29>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 30>>) ->
    30;
enumerated_avp(encode, 'NAS-Port-Type', 30) ->
    <<0, 0, 0, 30>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 31>>) ->
    31;
enumerated_avp(encode, 'NAS-Port-Type', 31) ->
    <<0, 0, 0, 31>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 32>>) ->
    32;
enumerated_avp(encode, 'NAS-Port-Type', 32) ->
    <<0, 0, 0, 32>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 33>>) ->
    33;
enumerated_avp(encode, 'NAS-Port-Type', 33) ->
    <<0, 0, 0, 33>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 34>>) ->
    34;
enumerated_avp(encode, 'NAS-Port-Type', 34) ->
    <<0, 0, 0, 34>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 35>>) ->
    35;
enumerated_avp(encode, 'NAS-Port-Type', 35) ->
    <<0, 0, 0, 35>>;
enumerated_avp(decode, 'NAS-Port-Type',
               <<0, 0, 0, 36>>) ->
    36;
enumerated_avp(encode, 'NAS-Port-Type', 36) ->
    <<0, 0, 0, 36>>;
enumerated_avp(decode, 'Tunnel-Type', <<0, 0, 0, 1>>) ->
    1;
enumerated_avp(encode, 'Tunnel-Type', 1) ->
    <<0, 0, 0, 1>>;
enumerated_avp(decode, 'Tunnel-Type', <<0, 0, 0, 2>>) ->
    2;
enumerated_avp(encode, 'Tunnel-Type', 2) ->
    <<0, 0, 0, 2>>;
enumerated_avp(decode, 'Tunnel-Type', <<0, 0, 0, 3>>) ->
    3;
enumerated_avp(encode, 'Tunnel-Type', 3) ->
    <<0, 0, 0, 3>>;
enumerated_avp(decode, 'Tunnel-Type', <<0, 0, 0, 4>>) ->
    4;
enumerated_avp(encode, 'Tunnel-Type', 4) ->
    <<0, 0, 0, 4>>;
enumerated_avp(decode, 'Tunnel-Type', <<0, 0, 0, 5>>) ->
    5;
enumerated_avp(encode, 'Tunnel-Type', 5) ->
    <<0, 0, 0, 5>>;
enumerated_avp(decode, 'Tunnel-Type', <<0, 0, 0, 6>>) ->
    6;
enumerated_avp(encode, 'Tunnel-Type', 6) ->
    <<0, 0, 0, 6>>;
enumerated_avp(decode, 'Tunnel-Type', <<0, 0, 0, 7>>) ->
    7;
enumerated_avp(encode, 'Tunnel-Type', 7) ->
    <<0, 0, 0, 7>>;
enumerated_avp(decode, 'Tunnel-Type', <<0, 0, 0, 8>>) ->
    8;
enumerated_avp(encode, 'Tunnel-Type', 8) ->
    <<0, 0, 0, 8>>;
enumerated_avp(decode, 'Tunnel-Type', <<0, 0, 0, 9>>) ->
    9;
enumerated_avp(encode, 'Tunnel-Type', 9) ->
    <<0, 0, 0, 9>>;
enumerated_avp(decode, 'Tunnel-Type',
               <<0, 0, 0, 10>>) ->
    10;
enumerated_avp(encode, 'Tunnel-Type', 10) ->
    <<0, 0, 0, 10>>;
enumerated_avp(decode, 'Tunnel-Type',
               <<0, 0, 0, 11>>) ->
    11;
enumerated_avp(encode, 'Tunnel-Type', 11) ->
    <<0, 0, 0, 11>>;
enumerated_avp(decode, 'Tunnel-Type',
               <<0, 0, 0, 12>>) ->
    12;
enumerated_avp(encode, 'Tunnel-Type', 12) ->
    <<0, 0, 0, 12>>;
enumerated_avp(decode, 'Tunnel-Type',
               <<0, 0, 0, 13>>) ->
    13;
enumerated_avp(encode, 'Tunnel-Type', 13) ->
    <<0, 0, 0, 13>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 1>>) ->
    1;
enumerated_avp(encode, 'Tunnel-Medium-Type', 1) ->
    <<0, 0, 0, 1>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 2>>) ->
    2;
enumerated_avp(encode, 'Tunnel-Medium-Type', 2) ->
    <<0, 0, 0, 2>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 3>>) ->
    3;
enumerated_avp(encode, 'Tunnel-Medium-Type', 3) ->
    <<0, 0, 0, 3>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 4>>) ->
    4;
enumerated_avp(encode, 'Tunnel-Medium-Type', 4) ->
    <<0, 0, 0, 4>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 5>>) ->
    5;
enumerated_avp(encode, 'Tunnel-Medium-Type', 5) ->
    <<0, 0, 0, 5>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 6>>) ->
    6;
enumerated_avp(encode, 'Tunnel-Medium-Type', 6) ->
    <<0, 0, 0, 6>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 7>>) ->
    7;
enumerated_avp(encode, 'Tunnel-Medium-Type', 7) ->
    <<0, 0, 0, 7>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 8>>) ->
    8;
enumerated_avp(encode, 'Tunnel-Medium-Type', 8) ->
    <<0, 0, 0, 8>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 9>>) ->
    9;
enumerated_avp(encode, 'Tunnel-Medium-Type', 9) ->
    <<0, 0, 0, 9>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 10>>) ->
    10;
enumerated_avp(encode, 'Tunnel-Medium-Type', 10) ->
    <<0, 0, 0, 10>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 11>>) ->
    11;
enumerated_avp(encode, 'Tunnel-Medium-Type', 11) ->
    <<0, 0, 0, 11>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 12>>) ->
    12;
enumerated_avp(encode, 'Tunnel-Medium-Type', 12) ->
    <<0, 0, 0, 12>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 13>>) ->
    13;
enumerated_avp(encode, 'Tunnel-Medium-Type', 13) ->
    <<0, 0, 0, 13>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 14>>) ->
    14;
enumerated_avp(encode, 'Tunnel-Medium-Type', 14) ->
    <<0, 0, 0, 14>>;
enumerated_avp(decode, 'Tunnel-Medium-Type',
               <<0, 0, 0, 15>>) ->
    15;
enumerated_avp(encode, 'Tunnel-Medium-Type', 15) ->
    <<0, 0, 0, 15>>;
enumerated_avp(decode, 'Accounting-Auth-Method',
               <<0, 0, 0, 1>>) ->
    1;
enumerated_avp(encode, 'Accounting-Auth-Method', 1) ->
    <<0, 0, 0, 1>>;
enumerated_avp(decode, 'Accounting-Auth-Method',
               <<0, 0, 0, 2>>) ->
    2;
enumerated_avp(encode, 'Accounting-Auth-Method', 2) ->
    <<0, 0, 0, 2>>;
enumerated_avp(decode, 'Accounting-Auth-Method',
               <<0, 0, 0, 3>>) ->
    3;
enumerated_avp(encode, 'Accounting-Auth-Method', 3) ->
    <<0, 0, 0, 3>>;
enumerated_avp(decode, 'Accounting-Auth-Method',
               <<0, 0, 0, 4>>) ->
    4;
enumerated_avp(encode, 'Accounting-Auth-Method', 4) ->
    <<0, 0, 0, 4>>;
enumerated_avp(decode, 'Accounting-Auth-Method',
               <<0, 0, 0, 5>>) ->
    5;
enumerated_avp(encode, 'Accounting-Auth-Method', 5) ->
    <<0, 0, 0, 5>>;
enumerated_avp(decode, 'Accounting-Auth-Method',
               <<0, 0, 0, 6>>) ->
    6;
enumerated_avp(encode, 'Accounting-Auth-Method', 6) ->
    <<0, 0, 0, 6>>;
enumerated_avp(decode, 'Accounting-Auth-Method',
               <<0, 0, 0, 7>>) ->
    7;
enumerated_avp(encode, 'Accounting-Auth-Method', 7) ->
    <<0, 0, 0, 7>>;
enumerated_avp(decode, 'Origin-AAA-Protocol',
               <<0, 0, 0, 1>>) ->
    1;
enumerated_avp(encode, 'Origin-AAA-Protocol', 1) ->
    <<0, 0, 0, 1>>;
enumerated_avp(_, _, _) -> erlang:error(badarg).

empty_value('Tunneling', Opts) ->
    empty_group('Tunneling', Opts);
empty_value('Proxy-Info', Opts) ->
    empty_group('Proxy-Info', Opts);
empty_value('Failed-AVP', Opts) ->
    empty_group('Failed-AVP', Opts);
empty_value('Experimental-Result', Opts) ->
    empty_group('Experimental-Result', Opts);
empty_value('Vendor-Specific-Application-Id', Opts) ->
    empty_group('Vendor-Specific-Application-Id', Opts);
empty_value('Service-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Framed-Protocol', _) -> <<0, 0, 0, 0>>;
empty_value('Framed-Routing', _) -> <<0, 0, 0, 0>>;
empty_value('Framed-Compression', _) -> <<0, 0, 0, 0>>;
empty_value('Login-Service', _) -> <<0, 0, 0, 0>>;
empty_value('Acct-Authentic', _) -> <<0, 0, 0, 0>>;
empty_value('NAS-Port-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Tunnel-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Tunnel-Medium-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Accounting-Auth-Method', _) ->
    <<0, 0, 0, 0>>;
empty_value('Origin-AAA-Protocol', _) -> <<0, 0, 0, 0>>;
empty_value('Disconnect-Cause', _) -> <<0, 0, 0, 0>>;
empty_value('Redirect-Host-Usage', _) -> <<0, 0, 0, 0>>;
empty_value('Auth-Request-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Auth-Session-State', _) -> <<0, 0, 0, 0>>;
empty_value('Re-Auth-Request-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('Termination-Cause', _) -> <<0, 0, 0, 0>>;
empty_value('Session-Server-Failover', _) ->
    <<0, 0, 0, 0>>;
empty_value('Accounting-Record-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('Accounting-Realtime-Required', _) ->
    <<0, 0, 0, 0>>;
empty_value(Name, Opts) -> empty(Name, Opts).

dict() ->
    [1,
     {avp_types,
      [{"Accounting-Auth-Method", 406, "Enumerated", "M"},
       {"Accounting-Input-Octets", 363, "Unsigned64", "M"},
       {"Accounting-Input-Packets", 365, "Unsigned64", "M"},
       {"Accounting-Output-Octets", 364, "Unsigned64", "M"},
       {"Accounting-Output-Packets", 366, "Unsigned64", "M"},
       {"Acct-Authentic", 45, "Enumerated", "M"},
       {"Acct-Delay-Time", 41, "Unsigned32", "M"},
       {"Acct-Link-Count", 51, "Unsigned32", "M"},
       {"Acct-Session-Time", 46, "Unsigned32", "M"},
       {"Acct-Tunnel-Connection", 68, "OctetString", "M"},
       {"Acct-Tunnel-Packets-Lost", 86, "Unsigned32", "M"},
       {"Callback-Id", 20, "UTF8String", "M"},
       {"Callback-Number", 19, "UTF8String", "M"},
       {"Called-Station-Id", 30, "UTF8String", "M"},
       {"Calling-Station-Id", 31, "UTF8String", "M"},
       {"Connect-Info", 77, "UTF8String", "M"},
       {"Filter-Id", 11, "UTF8String", "M"},
       {"Framed-AppleTalk-Link", 37, "Unsigned32", "M"},
       {"Framed-AppleTalk-Network", 38, "Unsigned32", "M"},
       {"Framed-AppleTalk-Zone", 39, "OctetString", "M"},
       {"Framed-Compression", 13, "Enumerated", "M"},
       {"Framed-IP-Address", 8, "OctetString", "M"},
       {"Framed-IP-Netmask", 9, "OctetString", "M"},
       {"Framed-IPX-Network", 23, "Unsigned32", "M"},
       {"Framed-IPv6-Pool", 100, "OctetString", "M"},
       {"Framed-IPv6-Prefix", 97, "OctetString", "M"},
       {"Framed-IPv6-Route", 99, "UTF8String", "M"},
       {"Framed-Interface-Id", 96, "Unsigned64", "M"},
       {"Framed-MTU", 12, "Unsigned32", "M"},
       {"Framed-Pool", 88, "OctetString", "M"},
       {"Framed-Protocol", 7, "Enumerated", "M"},
       {"Framed-Route", 22, "UTF8String", "M"},
       {"Framed-Routing", 10, "Enumerated", "M"},
       {"Idle-Timeout", 28, "Unsigned32", "M"},
       {"Login-IP-Host", 14, "OctetString", "M"},
       {"Login-IPv6-Host", 98, "OctetString", "M"},
       {"Login-LAT-Group", 36, "OctetString", "M"},
       {"Login-LAT-Node", 35, "OctetString", "M"},
       {"Login-LAT-Port", 63, "OctetString", "M"},
       {"Login-LAT-Service", 34, "OctetString", "M"},
       {"Login-Service", 15, "Enumerated", "M"},
       {"Login-TCP-Port", 16, "Unsigned32", "M"},
       {"NAS-Filter-Rule", 400, "IPFilterRule", "M"},
       {"NAS-IP-Address", 4, "OctetString", "M"},
       {"NAS-IPv6-Address", 95, "OctetString", "M"},
       {"NAS-Identifier", 32, "UTF8String", "M"},
       {"NAS-Port", 5, "Unsigned32", "M"},
       {"NAS-Port-Id", 87, "UTF8String", "M"},
       {"NAS-Port-Type", 61, "Enumerated", "M"},
       {"Origin-AAA-Protocol", 408, "Enumerated", "M"},
       {"Originating-Line-Info", 94, "OctetString", "M"},
       {"Port-Limit", 62, "Unsigned32", "M"},
       {"QoS-Filter-Rule", 407, "QoSFilterRule", "M"},
       {"Service-Type", 6, "Enumerated", "M"},
       {"Tunnel-Assignment-Id", 82, "OctetString", "M"},
       {"Tunnel-Client-Auth-Id", 90, "UTF8String", "M"},
       {"Tunnel-Client-Endpoint", 66, "UTF8String", "M"},
       {"Tunnel-Medium-Type", 65, "Enumerated", "M"},
       {"Tunnel-Password", 69, "OctetString", "M"},
       {"Tunnel-Preference", 83, "Unsigned32", "M"},
       {"Tunnel-Private-Group-Id", 81, "OctetString", "M"},
       {"Tunnel-Server-Auth-Id", 91, "UTF8String", "M"},
       {"Tunnel-Server-Endpoint", 67, "UTF8String", "M"},
       {"Tunnel-Type", 64, "Enumerated", "M"},
       {"Tunneling", 401, "Grouped", "M"}]},
     {avp_vendor_id, []},
     {codecs, []},
     {command_codes, [{271, "ACR", "ACA"}]},
     {custom_types, []},
     {define, []},
     {enum,
      [{"Service-Type",
        [{"UNKNOWN", 0},
         {"LOGIN", 1},
         {"FRAMED", 2},
         {"CALLBACK_LOGIN", 3},
         {"CALLBACK_FRAMED", 4},
         {"OUTBOUND", 5},
         {"ADMINISTRATIVE", 6},
         {"NAS_PROMPT", 7},
         {"AUTHENTICATE_ONLY", 8},
         {"CALLBACK_NAS_PROMPT", 9},
         {"CALL_CHECK", 10},
         {"CALLBACK_ADMINISTRATIVE", 11},
         {"VOICE", 12},
         {"FAX", 13},
         {"MODEM_RELAY", 14},
         {"IAPP_REGISTER", 15},
         {"IAPP_AP_CHECK", 16},
         {"AUTHORIZE_ONLY", 17},
         {"FRAMED_MANAGEMENT", 18}]},
       {"Framed-Protocol",
        [{"PPP", 1},
         {"SLIP", 2},
         {"ARAP", 3},
         {"GANDALF", 4},
         {"XYLOGICS", 5},
         {"X_75", 6},
         {"GPRS_PDP_CONTEXT", 7},
         {"ASCEND_ARA", 255},
         {"MPP", 256},
         {"EURAW", 257},
         {"EUUI", 258},
         {"X25", 259},
         {"COMB", 260},
         {"FR", 261}]},
       {"Framed-Routing",
        [{"NONE", 0},
         {"SEND_ROUTING_PACKETS", 1},
         {"LISTEN_FOR_ROUTING_PACKETS", 2},
         {"SEND_AND_LISTEN", 3}]},
       {"Framed-Compression",
        [{"NONE", 0},
         {"IPX_HEADER_COMPRESSION", 2},
         {"STAC_LZS_COMPRESSION", 3}]},
       {"Login-Service",
        [{"TELNET", 0},
         {"RLOGIN", 1},
         {"TCP_CLEAR", 2},
         {"PORTMASTER", 3},
         {"LAT", 4},
         {"X25_PAD", 5},
         {"X25_T3POS", 6},
         {"UNASSIGNED", 7}]},
       {"Acct-Authentic",
        [{"NONE", 0},
         {"RADIUS", 1},
         {"LOCAL", 2},
         {"REMOTE", 3},
         {"DIAMETER", 4}]},
       {"NAS-Port-Type",
        [{"ASYNC", 0},
         {"SYNC", 1},
         {"ISDN_SYNC", 2},
         {"ISDN_ASYNC_V120", 3},
         {"ISDN_ASYNC_V110", 4},
         {"VIRTUAL", 5},
         {"PIAFS", 6},
         {"HDLC_CLEAR_CHANNEL", 7},
         {"X25", 8},
         {"X75", 9},
         {"G_3_FAX", 10},
         {"SDSL_SYMMETRIC_DSL", 11},
         {"IDSL_ISDN_DIGITAL_SUBSCRIBER_LINE", 14},
         {"ETHERNET", 15},
         {"XDSL_DIGITAL_SUBSCRIBER_LINE_OF_UNKNOWN_TYPE", 16},
         {"CABLE", 17},
         {"WIRELESS_OTHER", 18},
         {"WIRELESS_IEEE_802_11", 19},
         {"TOKEN_RING", 20},
         {"FDDI", 21},
         {"WIRELESS_CDMA2000", 22},
         {"WIRELESS_UMTS", 23},
         {"WIRELESS_1X_EV", 24},
         {"IAPP", 25},
         {"FTTP_FIBER_TO_THE_PREMISES", 26},
         {"WIRELESS_IEEE_802_16", 27},
         {"WIRELESS_IEEE_802_20", 28},
         {"WIRELESS_IEEE_802_22", 29},
         {"PPPOA_PPP_OVER_ATM", 30},
         {"PPPOEOA_PPP_OVER_ETHERNET_OVER_ATM", 31},
         {"PPPOEOE_PPP_OVER_ETHERNET_OVER_ETHERNET", 32},
         {"PPPOEOVLAN_PPP_OVER_ETHERNET_OVER_VLAN", 33},
         {"PPPOEOQINQ_PPP_OVER_ETHERNET_OVER_IEEE_802_1QINQ",
          34},
         {"XPON_PASSIVE_OPTICAL_NETWORK", 35},
         {"WIRELESS_XGP", 36}]},
       {"Tunnel-Type",
        [{"PPTP", 1},
         {"L2F", 2},
         {"L2TP", 3},
         {"ATMP", 4},
         {"VTP", 5},
         {"AH", 6},
         {"IP_IP_ENCAP", 7},
         {"MIN_IP_IP", 8},
         {"ESP", 9},
         {"GRE", 10},
         {"DVS", 11},
         {"IP_IN_IP_TUNNELING", 12},
         {"VLAN", 13}]},
       {"Tunnel-Medium-Type",
        [{"IPV4", 1},
         {"IPV6", 2},
         {"NSAP", 3},
         {"HDLC", 4},
         {"BBN", 5},
         {"IEEE_802", 6},
         {"E_163", 7},
         {"E_164", 8},
         {"F_69", 9},
         {"X_121", 10},
         {"IPX", 11},
         {"APPLETALK_802", 12},
         {"DECNET4", 13},
         {"VINES", 14},
         {"E_164_NSAP", 15}]},
       {"Accounting-Auth-Method",
        [{"PAP", 1},
         {"CHAP", 2},
         {"MS_CHAP_1", 3},
         {"MS_CHAP_2", 4},
         {"EAP", 5},
         {"UNDEFINED", 6},
         {"NONE", 7}]},
       {"Origin-AAA-Protocol", [{"RADIUS", 1}]}]},
     {grouped,
      [{"Tunneling",
        401,
        [],
        [{"Tunnel-Type"},
         {"Tunnel-Medium-Type"},
         {"Tunnel-Client-Endpoint"},
         {"Tunnel-Server-Endpoint"},
         ["Tunnel-Preference"],
         ["Tunnel-Client-Auth-Id"],
         ["Tunnel-Server-Auth-Id"],
         ["Tunnel-Assignment-Id"],
         ["Tunnel-Password"],
         ["Tunnel-Private-Group-Id"]]}]},
     {id, 1},
     {import_avps,
      [{diameter_gen_base_rfc6733,
        [{"Accounting-Realtime-Required",
          483,
          "Enumerated",
          "M"},
         {"Accounting-Record-Number", 485, "Unsigned32", "M"},
         {"Accounting-Record-Type", 480, "Enumerated", "M"},
         {"Accounting-Sub-Session-Id", 287, "Unsigned64", "M"},
         {"Acct-Application-Id", 259, "Unsigned32", "M"},
         {"Acct-Interim-Interval", 85, "Unsigned32", "M"},
         {"Acct-Multi-Session-Id", 50, "UTF8String", "M"},
         {"Acct-Session-Id", 44, "OctetString", "M"},
         {"Auth-Application-Id", 258, "Unsigned32", "M"},
         {"Auth-Grace-Period", 276, "Unsigned32", "M"},
         {"Auth-Request-Type", 274, "Enumerated", "M"},
         {"Auth-Session-State", 277, "Enumerated", "M"},
         {"Authorization-Lifetime", 291, "Unsigned32", "M"},
         {"Class", 25, "OctetString", "M"},
         {"Destination-Host", 293, "DiameterIdentity", "M"},
         {"Destination-Realm", 283, "DiameterIdentity", "M"},
         {"Disconnect-Cause", 273, "Enumerated", "M"},
         {"Error-Message", 281, "UTF8String", []},
         {"Error-Reporting-Host", 294, "DiameterIdentity", []},
         {"Event-Timestamp", 55, "Time", "M"},
         {"Experimental-Result", 297, "Grouped", "M"},
         {"Experimental-Result-Code", 298, "Unsigned32", "M"},
         {"Failed-AVP", 279, "Grouped", "M"},
         {"Firmware-Revision", 267, "Unsigned32", []},
         {"Host-IP-Address", 257, "Address", "M"},
         {"Inband-Security-Id", 299, "Unsigned32", "M"},
         {"Multi-Round-Time-Out", 272, "Unsigned32", "M"},
         {"Origin-Host", 264, "DiameterIdentity", "M"},
         {"Origin-Realm", 296, "DiameterIdentity", "M"},
         {"Origin-State-Id", 278, "Unsigned32", "M"},
         {"Product-Name", 269, "UTF8String", []},
         {"Proxy-Host", 280, "DiameterIdentity", "M"},
         {"Proxy-Info", 284, "Grouped", "M"},
         {"Proxy-State", 33, "OctetString", "M"},
         {"Re-Auth-Request-Type", 285, "Enumerated", "M"},
         {"Redirect-Host", 292, "DiameterURI", "M"},
         {"Redirect-Host-Usage", 261, "Enumerated", "M"},
         {"Redirect-Max-Cache-Time", 262, "Unsigned32", "M"},
         {"Result-Code", 268, "Unsigned32", "M"},
         {"Route-Record", 282, "DiameterIdentity", "M"},
         {"Session-Binding", 270, "Unsigned32", "M"},
         {"Session-Id", 263, "UTF8String", "M"},
         {"Session-Server-Failover", 271, "Enumerated", "M"},
         {"Session-Timeout", 27, "Unsigned32", "M"},
         {"Supported-Vendor-Id", 265, "Unsigned32", "M"},
         {"Termination-Cause", 295, "Enumerated", "M"},
         {"User-Name", 1, "UTF8String", "M"},
         {"Vendor-Id", 266, "Unsigned32", "M"},
         {"Vendor-Specific-Application-Id",
          260,
          "Grouped",
          "M"}]}]},
     {import_enums,
      [{diameter_gen_base_rfc6733,
        [{"Disconnect-Cause",
          [{"REBOOTING", 0},
           {"BUSY", 1},
           {"DO_NOT_WANT_TO_TALK_TO_YOU", 2}]},
         {"Redirect-Host-Usage",
          [{"DONT_CACHE", 0},
           {"ALL_SESSION", 1},
           {"ALL_REALM", 2},
           {"REALM_AND_APPLICATION", 3},
           {"ALL_APPLICATION", 4},
           {"ALL_HOST", 5},
           {"ALL_USER", 6}]},
         {"Auth-Request-Type",
          [{"AUTHENTICATE_ONLY", 1},
           {"AUTHORIZE_ONLY", 2},
           {"AUTHORIZE_AUTHENTICATE", 3}]},
         {"Auth-Session-State",
          [{"STATE_MAINTAINED", 0}, {"NO_STATE_MAINTAINED", 1}]},
         {"Re-Auth-Request-Type",
          [{"AUTHORIZE_ONLY", 0}, {"AUTHORIZE_AUTHENTICATE", 1}]},
         {"Termination-Cause",
          [{"LOGOUT", 1},
           {"SERVICE_NOT_PROVIDED", 2},
           {"BAD_ANSWER", 3},
           {"ADMINISTRATIVE", 4},
           {"LINK_BROKEN", 5},
           {"AUTH_EXPIRED", 6},
           {"USER_MOVED", 7},
           {"SESSION_TIMEOUT", 8}]},
         {"Session-Server-Failover",
          [{"REFUSE_SERVICE", 0},
           {"TRY_AGAIN", 1},
           {"ALLOW_SERVICE", 2},
           {"TRY_AGAIN_ALLOW_SERVICE", 3}]},
         {"Accounting-Record-Type",
          [{"EVENT_RECORD", 1},
           {"START_RECORD", 2},
           {"INTERIM_RECORD", 3},
           {"STOP_RECORD", 4}]},
         {"Accounting-Realtime-Required",
          [{"DELIVER_AND_GRANT", 1},
           {"GRANT_AND_STORE", 2},
           {"GRANT_AND_LOSE", 3}]}]}]},
     {import_groups,
      [{diameter_gen_base_rfc6733,
        [{"Proxy-Info",
          284,
          [],
          [{"Proxy-Host"}, {"Proxy-State"}, {'*', ["AVP"]}]},
         {"Failed-AVP", 279, [], [{'*', {"AVP"}}]},
         {"Experimental-Result",
          297,
          [],
          [{"Vendor-Id"}, {"Experimental-Result-Code"}]},
         {"Vendor-Specific-Application-Id",
          260,
          [],
          [{"Vendor-Id"},
           ["Auth-Application-Id"],
           ["Acct-Application-Id"]]}]}]},
     {inherits, [{"diameter_gen_base_rfc6733", []}]},
     {messages,
      [{"ACR",
        271,
        ['REQ', 'PXY'],
        [],
        [{{"Session-Id"}},
         {"Origin-Host"},
         {"Origin-Realm"},
         {"Destination-Realm"},
         {"Accounting-Record-Type"},
         {"Accounting-Record-Number"},
         {"Acct-Application-Id"},
         ["User-Name"],
         ["Accounting-Sub-Session-Id"],
         ["Acct-Session-Id"],
         ["Acct-Multi-Session-Id"],
         ["Origin-AAA-Protocol"],
         ["Origin-State-Id"],
         ["Destination-Host"],
         ["Event-Timestamp"],
         ["Acct-Delay-Time"],
         ["NAS-Identifier"],
         ["NAS-IP-Address"],
         ["NAS-IPv6-Address"],
         ["NAS-Port"],
         ["NAS-Port-Id"],
         ["NAS-Port-Type"],
         {'*', ["Class"]},
         ["Service-Type"],
         ["Termination-Cause"],
         ["Accounting-Input-Octets"],
         ["Accounting-Input-Packets"],
         ["Accounting-Output-Octets"],
         ["Accounting-Output-Packets"],
         ["Acct-Authentic"],
         ["Accounting-Auth-Method"],
         ["Acct-Link-Count"],
         ["Acct-Session-Time"],
         ["Acct-Tunnel-Connection"],
         ["Acct-Tunnel-Packets-Lost"],
         ["Callback-Id"],
         ["Callback-Number"],
         ["Called-Station-Id"],
         ["Calling-Station-Id"],
         {'*', ["Connect-Info"]},
         ["Originating-Line-Info"],
         ["Authorization-Lifetime"],
         ["Session-Timeout"],
         ["Idle-Timeout"],
         ["Port-Limit"],
         ["Accounting-Realtime-Required"],
         ["Acct-Interim-Interval"],
         {'*', ["Filter-Id"]},
         {'*', ["NAS-Filter-Rule"]},
         {'*', ["QoS-Filter-Rule"]},
         ["Framed-AppleTalk-Link"],
         ["Framed-AppleTalk-Network"],
         ["Framed-AppleTalk-Zone"],
         ["Framed-Compression"],
         ["Framed-Interface-Id"],
         ["Framed-IP-Address"],
         ["Framed-IP-Netmask"],
         {'*', ["Framed-IPv6-Prefix"]},
         ["Framed-IPv6-Pool"],
         {'*', ["Framed-IPv6-Route"]},
         ["Framed-IPX-Network"],
         ["Framed-MTU"],
         ["Framed-Pool"],
         ["Framed-Protocol"],
         {'*', ["Framed-Route"]},
         ["Framed-Routing"],
         {'*', ["Login-IP-Host"]},
         {'*', ["Login-IPv6-Host"]},
         ["Login-LAT-Group"],
         ["Login-LAT-Node"],
         ["Login-LAT-Port"],
         ["Login-LAT-Service"],
         ["Login-Service"],
         ["Login-TCP-Port"],
         {'*', ["Tunneling"]},
         {'*', ["Proxy-Info"]},
         {'*', ["Route-Record"]},
         {'*', ["AVP"]}]},
       {"ACA",
        271,
        ['PXY'],
        [],
        [{{"Session-Id"}},
         {"Result-Code"},
         {"Origin-Host"},
         {"Origin-Realm"},
         {"Accounting-Record-Type"},
         {"Accounting-Record-Number"},
         {"Acct-Application-Id"},
         ["User-Name"],
         ["Accounting-Sub-Session-Id"],
         ["Acct-Session-Id"],
         ["Acct-Multi-Session-Id"],
         ["Event-Timestamp"],
         ["Error-Message"],
         ["Error-Reporting-Host"],
         {'*', ["Failed-AVP"]},
         ["Origin-AAA-Protocol"],
         ["Origin-State-Id"],
         ["NAS-Identifier"],
         ["NAS-IP-Address"],
         ["NAS-IPv6-Address"],
         ["NAS-Port"],
         ["NAS-Port-Id"],
         ["NAS-Port-Type"],
         ["Service-Type"],
         ["Termination-Cause"],
         ["Accounting-Realtime-Required"],
         ["Acct-Interim-Interval"],
         {'*', ["Class"]},
         {'*', ["Proxy-Info"]},
         {'*', ["AVP"]}]}]},
     {name, "diameter_rfc7155_nasreq"},
     {prefix, "diameter_nasreq"},
     {vendor, {0, "IETF"}}].


