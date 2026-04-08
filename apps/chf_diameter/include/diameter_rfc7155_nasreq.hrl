%% -------------------------------------------------------------------
%% This is a generated file.
%% -------------------------------------------------------------------

-hrl_name('diameter_rfc7155_nasreq.hrl').


%%% -------------------------------------------------------
%%% Message records:
%%% -------------------------------------------------------

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


%%% -------------------------------------------------------
%%% Grouped AVP records:
%%% -------------------------------------------------------

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


%%% -------------------------------------------------------
%%% Grouped AVP records from diameter_gen_base_rfc6733:
%%% -------------------------------------------------------

-record('diameter_nasreq_Proxy-Info',
        {'Proxy-Host', 'Proxy-State', 'AVP' = []}).

-record('diameter_nasreq_Failed-AVP', {'AVP' = []}).

-record('diameter_nasreq_Experimental-Result',
        {'Vendor-Id', 'Experimental-Result-Code'}).

-record('diameter_nasreq_Vendor-Specific-Application-Id',
        {'Vendor-Id',
         'Auth-Application-Id' = [],
         'Acct-Application-Id' = []}).


%%% -------------------------------------------------------
%%% ENUM Macros:
%%% -------------------------------------------------------

-define('DIAMETER_NASREQ_SERVICE-TYPE_UNKNOWN', 0).
-define('DIAMETER_NASREQ_SERVICE-TYPE_LOGIN', 1).
-define('DIAMETER_NASREQ_SERVICE-TYPE_FRAMED', 2).
-define('DIAMETER_NASREQ_SERVICE-TYPE_CALLBACK_LOGIN', 3).
-define('DIAMETER_NASREQ_SERVICE-TYPE_CALLBACK_FRAMED', 4).
-define('DIAMETER_NASREQ_SERVICE-TYPE_OUTBOUND', 5).
-define('DIAMETER_NASREQ_SERVICE-TYPE_ADMINISTRATIVE', 6).
-define('DIAMETER_NASREQ_SERVICE-TYPE_NAS_PROMPT', 7).
-define('DIAMETER_NASREQ_SERVICE-TYPE_AUTHENTICATE_ONLY', 8).
-define('DIAMETER_NASREQ_SERVICE-TYPE_CALLBACK_NAS_PROMPT', 9).
-define('DIAMETER_NASREQ_SERVICE-TYPE_CALL_CHECK', 10).
-define('DIAMETER_NASREQ_SERVICE-TYPE_CALLBACK_ADMINISTRATIVE', 11).
-define('DIAMETER_NASREQ_SERVICE-TYPE_VOICE', 12).
-define('DIAMETER_NASREQ_SERVICE-TYPE_FAX', 13).
-define('DIAMETER_NASREQ_SERVICE-TYPE_MODEM_RELAY', 14).
-define('DIAMETER_NASREQ_SERVICE-TYPE_IAPP_REGISTER', 15).
-define('DIAMETER_NASREQ_SERVICE-TYPE_IAPP_AP_CHECK', 16).
-define('DIAMETER_NASREQ_SERVICE-TYPE_AUTHORIZE_ONLY', 17).
-define('DIAMETER_NASREQ_SERVICE-TYPE_FRAMED_MANAGEMENT', 18).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_PPP', 1).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_SLIP', 2).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_ARAP', 3).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_GANDALF', 4).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_XYLOGICS', 5).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_X_75', 6).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_GPRS_PDP_CONTEXT', 7).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_ASCEND_ARA', 255).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_MPP', 256).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_EURAW', 257).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_EUUI', 258).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_X25', 259).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_COMB', 260).
-define('DIAMETER_NASREQ_FRAMED-PROTOCOL_FR', 261).
-define('DIAMETER_NASREQ_FRAMED-ROUTING_NONE', 0).
-define('DIAMETER_NASREQ_FRAMED-ROUTING_SEND_ROUTING_PACKETS', 1).
-define('DIAMETER_NASREQ_FRAMED-ROUTING_LISTEN_FOR_ROUTING_PACKETS', 2).
-define('DIAMETER_NASREQ_FRAMED-ROUTING_SEND_AND_LISTEN', 3).
-define('DIAMETER_NASREQ_FRAMED-COMPRESSION_NONE', 0).
-define('DIAMETER_NASREQ_FRAMED-COMPRESSION_IPX_HEADER_COMPRESSION', 2).
-define('DIAMETER_NASREQ_FRAMED-COMPRESSION_STAC_LZS_COMPRESSION', 3).
-define('DIAMETER_NASREQ_LOGIN-SERVICE_TELNET', 0).
-define('DIAMETER_NASREQ_LOGIN-SERVICE_RLOGIN', 1).
-define('DIAMETER_NASREQ_LOGIN-SERVICE_TCP_CLEAR', 2).
-define('DIAMETER_NASREQ_LOGIN-SERVICE_PORTMASTER', 3).
-define('DIAMETER_NASREQ_LOGIN-SERVICE_LAT', 4).
-define('DIAMETER_NASREQ_LOGIN-SERVICE_X25_PAD', 5).
-define('DIAMETER_NASREQ_LOGIN-SERVICE_X25_T3POS', 6).
-define('DIAMETER_NASREQ_LOGIN-SERVICE_UNASSIGNED', 7).
-define('DIAMETER_NASREQ_ACCT-AUTHENTIC_NONE', 0).
-define('DIAMETER_NASREQ_ACCT-AUTHENTIC_RADIUS', 1).
-define('DIAMETER_NASREQ_ACCT-AUTHENTIC_LOCAL', 2).
-define('DIAMETER_NASREQ_ACCT-AUTHENTIC_REMOTE', 3).
-define('DIAMETER_NASREQ_ACCT-AUTHENTIC_DIAMETER', 4).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_ASYNC', 0).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_SYNC', 1).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_ISDN_SYNC', 2).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_ISDN_ASYNC_V120', 3).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_ISDN_ASYNC_V110', 4).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_VIRTUAL', 5).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_PIAFS', 6).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_HDLC_CLEAR_CHANNEL', 7).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_X25', 8).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_X75', 9).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_G_3_FAX', 10).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_SDSL_SYMMETRIC_DSL', 11).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_IDSL_ISDN_DIGITAL_SUBSCRIBER_LINE', 14).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_ETHERNET', 15).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_XDSL_DIGITAL_SUBSCRIBER_LINE_OF_UNKNOWN_TYPE', 16).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_CABLE', 17).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_WIRELESS_OTHER', 18).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_WIRELESS_IEEE_802_11', 19).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_TOKEN_RING', 20).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_FDDI', 21).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_WIRELESS_CDMA2000', 22).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_WIRELESS_UMTS', 23).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_WIRELESS_1X_EV', 24).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_IAPP', 25).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_FTTP_FIBER_TO_THE_PREMISES', 26).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_WIRELESS_IEEE_802_16', 27).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_WIRELESS_IEEE_802_20', 28).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_WIRELESS_IEEE_802_22', 29).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_PPPOA_PPP_OVER_ATM', 30).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_PPPOEOA_PPP_OVER_ETHERNET_OVER_ATM', 31).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_PPPOEOE_PPP_OVER_ETHERNET_OVER_ETHERNET', 32).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_PPPOEOVLAN_PPP_OVER_ETHERNET_OVER_VLAN', 33).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_PPPOEOQINQ_PPP_OVER_ETHERNET_OVER_IEEE_802_1QINQ', 34).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_XPON_PASSIVE_OPTICAL_NETWORK', 35).
-define('DIAMETER_NASREQ_NAS-PORT-TYPE_WIRELESS_XGP', 36).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_PPTP', 1).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_L2F', 2).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_L2TP', 3).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_ATMP', 4).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_VTP', 5).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_AH', 6).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_IP_IP_ENCAP', 7).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_MIN_IP_IP', 8).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_ESP', 9).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_GRE', 10).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_DVS', 11).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_IP_IN_IP_TUNNELING', 12).
-define('DIAMETER_NASREQ_TUNNEL-TYPE_VLAN', 13).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_IPV4', 1).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_IPV6', 2).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_NSAP', 3).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_HDLC', 4).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_BBN', 5).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_IEEE_802', 6).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_E_163', 7).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_E_164', 8).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_F_69', 9).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_X_121', 10).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_IPX', 11).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_APPLETALK_802', 12).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_DECNET4', 13).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_VINES', 14).
-define('DIAMETER_NASREQ_TUNNEL-MEDIUM-TYPE_E_164_NSAP', 15).
-define('DIAMETER_NASREQ_ACCOUNTING-AUTH-METHOD_PAP', 1).
-define('DIAMETER_NASREQ_ACCOUNTING-AUTH-METHOD_CHAP', 2).
-define('DIAMETER_NASREQ_ACCOUNTING-AUTH-METHOD_MS_CHAP_1', 3).
-define('DIAMETER_NASREQ_ACCOUNTING-AUTH-METHOD_MS_CHAP_2', 4).
-define('DIAMETER_NASREQ_ACCOUNTING-AUTH-METHOD_EAP', 5).
-define('DIAMETER_NASREQ_ACCOUNTING-AUTH-METHOD_UNDEFINED', 6).
-define('DIAMETER_NASREQ_ACCOUNTING-AUTH-METHOD_NONE', 7).
-define('DIAMETER_NASREQ_ORIGIN-AAA-PROTOCOL_RADIUS', 1).



%%% -------------------------------------------------------
%%% ENUM Macros from diameter_gen_base_rfc6733:
%%% -------------------------------------------------------

-ifndef('DIAMETER_NASREQ_DISCONNECT-CAUSE_REBOOTING').
-define('DIAMETER_NASREQ_DISCONNECT-CAUSE_REBOOTING', 0).
-endif.
-ifndef('DIAMETER_NASREQ_DISCONNECT-CAUSE_BUSY').
-define('DIAMETER_NASREQ_DISCONNECT-CAUSE_BUSY', 1).
-endif.
-ifndef('DIAMETER_NASREQ_DISCONNECT-CAUSE_DO_NOT_WANT_TO_TALK_TO_YOU').
-define('DIAMETER_NASREQ_DISCONNECT-CAUSE_DO_NOT_WANT_TO_TALK_TO_YOU', 2).
-endif.
-ifndef('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_DONT_CACHE').
-define('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_DONT_CACHE', 0).
-endif.
-ifndef('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_ALL_SESSION').
-define('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_ALL_SESSION', 1).
-endif.
-ifndef('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_ALL_REALM').
-define('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_ALL_REALM', 2).
-endif.
-ifndef('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_REALM_AND_APPLICATION').
-define('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_REALM_AND_APPLICATION', 3).
-endif.
-ifndef('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_ALL_APPLICATION').
-define('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_ALL_APPLICATION', 4).
-endif.
-ifndef('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_ALL_HOST').
-define('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_ALL_HOST', 5).
-endif.
-ifndef('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_ALL_USER').
-define('DIAMETER_NASREQ_REDIRECT-HOST-USAGE_ALL_USER', 6).
-endif.
-ifndef('DIAMETER_NASREQ_AUTH-REQUEST-TYPE_AUTHENTICATE_ONLY').
-define('DIAMETER_NASREQ_AUTH-REQUEST-TYPE_AUTHENTICATE_ONLY', 1).
-endif.
-ifndef('DIAMETER_NASREQ_AUTH-REQUEST-TYPE_AUTHORIZE_ONLY').
-define('DIAMETER_NASREQ_AUTH-REQUEST-TYPE_AUTHORIZE_ONLY', 2).
-endif.
-ifndef('DIAMETER_NASREQ_AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE').
-define('DIAMETER_NASREQ_AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE', 3).
-endif.
-ifndef('DIAMETER_NASREQ_AUTH-SESSION-STATE_STATE_MAINTAINED').
-define('DIAMETER_NASREQ_AUTH-SESSION-STATE_STATE_MAINTAINED', 0).
-endif.
-ifndef('DIAMETER_NASREQ_AUTH-SESSION-STATE_NO_STATE_MAINTAINED').
-define('DIAMETER_NASREQ_AUTH-SESSION-STATE_NO_STATE_MAINTAINED', 1).
-endif.
-ifndef('DIAMETER_NASREQ_RE-AUTH-REQUEST-TYPE_AUTHORIZE_ONLY').
-define('DIAMETER_NASREQ_RE-AUTH-REQUEST-TYPE_AUTHORIZE_ONLY', 0).
-endif.
-ifndef('DIAMETER_NASREQ_RE-AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE').
-define('DIAMETER_NASREQ_RE-AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE', 1).
-endif.
-ifndef('DIAMETER_NASREQ_TERMINATION-CAUSE_LOGOUT').
-define('DIAMETER_NASREQ_TERMINATION-CAUSE_LOGOUT', 1).
-endif.
-ifndef('DIAMETER_NASREQ_TERMINATION-CAUSE_SERVICE_NOT_PROVIDED').
-define('DIAMETER_NASREQ_TERMINATION-CAUSE_SERVICE_NOT_PROVIDED', 2).
-endif.
-ifndef('DIAMETER_NASREQ_TERMINATION-CAUSE_BAD_ANSWER').
-define('DIAMETER_NASREQ_TERMINATION-CAUSE_BAD_ANSWER', 3).
-endif.
-ifndef('DIAMETER_NASREQ_TERMINATION-CAUSE_ADMINISTRATIVE').
-define('DIAMETER_NASREQ_TERMINATION-CAUSE_ADMINISTRATIVE', 4).
-endif.
-ifndef('DIAMETER_NASREQ_TERMINATION-CAUSE_LINK_BROKEN').
-define('DIAMETER_NASREQ_TERMINATION-CAUSE_LINK_BROKEN', 5).
-endif.
-ifndef('DIAMETER_NASREQ_TERMINATION-CAUSE_AUTH_EXPIRED').
-define('DIAMETER_NASREQ_TERMINATION-CAUSE_AUTH_EXPIRED', 6).
-endif.
-ifndef('DIAMETER_NASREQ_TERMINATION-CAUSE_USER_MOVED').
-define('DIAMETER_NASREQ_TERMINATION-CAUSE_USER_MOVED', 7).
-endif.
-ifndef('DIAMETER_NASREQ_TERMINATION-CAUSE_SESSION_TIMEOUT').
-define('DIAMETER_NASREQ_TERMINATION-CAUSE_SESSION_TIMEOUT', 8).
-endif.
-ifndef('DIAMETER_NASREQ_SESSION-SERVER-FAILOVER_REFUSE_SERVICE').
-define('DIAMETER_NASREQ_SESSION-SERVER-FAILOVER_REFUSE_SERVICE', 0).
-endif.
-ifndef('DIAMETER_NASREQ_SESSION-SERVER-FAILOVER_TRY_AGAIN').
-define('DIAMETER_NASREQ_SESSION-SERVER-FAILOVER_TRY_AGAIN', 1).
-endif.
-ifndef('DIAMETER_NASREQ_SESSION-SERVER-FAILOVER_ALLOW_SERVICE').
-define('DIAMETER_NASREQ_SESSION-SERVER-FAILOVER_ALLOW_SERVICE', 2).
-endif.
-ifndef('DIAMETER_NASREQ_SESSION-SERVER-FAILOVER_TRY_AGAIN_ALLOW_SERVICE').
-define('DIAMETER_NASREQ_SESSION-SERVER-FAILOVER_TRY_AGAIN_ALLOW_SERVICE', 3).
-endif.
-ifndef('DIAMETER_NASREQ_ACCOUNTING-RECORD-TYPE_EVENT_RECORD').
-define('DIAMETER_NASREQ_ACCOUNTING-RECORD-TYPE_EVENT_RECORD', 1).
-endif.
-ifndef('DIAMETER_NASREQ_ACCOUNTING-RECORD-TYPE_START_RECORD').
-define('DIAMETER_NASREQ_ACCOUNTING-RECORD-TYPE_START_RECORD', 2).
-endif.
-ifndef('DIAMETER_NASREQ_ACCOUNTING-RECORD-TYPE_INTERIM_RECORD').
-define('DIAMETER_NASREQ_ACCOUNTING-RECORD-TYPE_INTERIM_RECORD', 3).
-endif.
-ifndef('DIAMETER_NASREQ_ACCOUNTING-RECORD-TYPE_STOP_RECORD').
-define('DIAMETER_NASREQ_ACCOUNTING-RECORD-TYPE_STOP_RECORD', 4).
-endif.
-ifndef('DIAMETER_NASREQ_ACCOUNTING-REALTIME-REQUIRED_DELIVER_AND_GRANT').
-define('DIAMETER_NASREQ_ACCOUNTING-REALTIME-REQUIRED_DELIVER_AND_GRANT', 1).
-endif.
-ifndef('DIAMETER_NASREQ_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_STORE').
-define('DIAMETER_NASREQ_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_STORE', 2).
-endif.
-ifndef('DIAMETER_NASREQ_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_LOSE').
-define('DIAMETER_NASREQ_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_LOSE', 3).
-endif.

