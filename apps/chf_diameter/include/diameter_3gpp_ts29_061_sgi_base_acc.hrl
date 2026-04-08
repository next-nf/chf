%% -------------------------------------------------------------------
%% This is a generated file.
%% -------------------------------------------------------------------

-hrl_name('diameter_3gpp_ts29_061_sgi_base_acc.hrl').


%%% -------------------------------------------------------
%%% Message records:
%%% -------------------------------------------------------

-record(diameter_sgi_base_acc_ACR,
        {'Session-Id',
         'Origin-Host',
         'Origin-Realm',
         'Destination-Realm',
         'Accounting-Record-Type',
         'Accounting-Record-Number',
         'Acct-Application-Id' = [],
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
         '3GPP-IMSI' = [],
         '3GPP-Charging-Id' = [],
         '3GPP-PDP-Type' = [],
         '3GPP-CG-Address' = [],
         '3GPP-GPRS-Negotiated-QoS-Profile' = [],
         '3GPP-SGSN-Address' = [],
         '3GPP-GGSN-Address' = [],
         '3GPP-IMSI-MCC-MNC' = [],
         '3GPP-GGSN-MCC-MNC' = [],
         '3GPP-NSAPI' = [],
         '3GPP-Selection-Mode' = [],
         '3GPP-Charging-Characteristics' = [],
         '3GPP-CG-IPv6-Address' = [],
         '3GPP-SGSN-IPv6-Address' = [],
         '3GPP-GGSN-IPv6-Address' = [],
         '3GPP-SGSN-MCC-MNC' = [],
         '3GPP-IMEISV' = [],
         '3GPP-RAT-Type' = [],
         '3GPP-User-Location-Info' = [],
         '3GPP-MS-TimeZone' = [],
         '3GPP-CAMEL-Charging-Info' = [],
         '3GPP-Packet-Filter' = [],
         '3GPP-Negotiated-DSCP' = [],
         'TWAN-Identifier' = [],
         '3GPP-User-Location-Info-Time' = [],
         'TP-NAT-IP-Address' = [],
         'TP-NAT-Pool-Id' = [],
         'TP-NAT-Port-Start' = [],
         'TP-NAT-Port-End' = [],
         'AVP' = []}).

-record(diameter_sgi_base_acc_ACA,
        {'Session-Id',
         'Result-Code',
         'Origin-Host',
         'Origin-Realm',
         'Accounting-Record-Type',
         'Accounting-Record-Number',
         'Acct-Application-Id' = [],
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
         '3GPP-IPv6-DNS-Servers' = [],
         'AVP' = []}).


%%% -------------------------------------------------------
%%% Grouped AVP records from diameter_gen_base_rfc6733:
%%% -------------------------------------------------------

-record('diameter_sgi_base_acc_Proxy-Info',
        {'Proxy-Host', 'Proxy-State', 'AVP' = []}).

-record('diameter_sgi_base_acc_Failed-AVP',
        {'AVP' = []}).

-record('diameter_sgi_base_acc_Experimental-Result',
        {'Vendor-Id', 'Experimental-Result-Code'}).

-record('diameter_sgi_base_acc_Vendor-Specific-Application-Id',
        {'Vendor-Id',
         'Auth-Application-Id' = [],
         'Acct-Application-Id' = []}).


%%% -------------------------------------------------------
%%% Grouped AVP records from diameter_rfc4005_nasreq:
%%% -------------------------------------------------------

-record('diameter_sgi_base_acc_CHAP-Auth',
        {'CHAP-Algorithm',
         'CHAP-Ident',
         'CHAP-Response' = [],
         'AVP' = []}).

-record(diameter_sgi_base_acc_Tunneling,
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
%%% Grouped AVP records from diameter_rfc4006_cc:
%%% -------------------------------------------------------

-record('diameter_sgi_base_acc_Cost-Information',
        {'Unit-Value', 'Currency-Code', 'Cost-Unit' = []}).

-record('diameter_sgi_base_acc_Unit-Value',
        {'Value-Digits', 'Exponent' = []}).

-record('diameter_sgi_base_acc_Multiple-Services-Credit-Control',
        {'Granted-Service-Unit' = [],
         'Requested-Service-Unit' = [],
         'Used-Service-Unit' = [],
         'Tariff-Change-Usage' = [],
         'Service-Identifier' = [],
         'Rating-Group' = [],
         'G-S-U-Pool-Reference' = [],
         'Validity-Time' = [],
         'Result-Code' = [],
         'Final-Unit-Indication' = [],
         'AVP' = []}).

-record('diameter_sgi_base_acc_Granted-Service-Unit',
        {'Tariff-Time-Change' = [],
         'CC-Time' = [],
         'CC-Money' = [],
         'CC-Total-Octets' = [],
         'CC-Input-Octets' = [],
         'CC-Output-Octets' = [],
         'CC-Service-Specific-Units' = [],
         'AVP' = []}).

-record('diameter_sgi_base_acc_Requested-Service-Unit',
        {'CC-Time' = [],
         'CC-Money' = [],
         'CC-Total-Octets' = [],
         'CC-Input-Octets' = [],
         'CC-Output-Octets' = [],
         'CC-Service-Specific-Units' = [],
         'AVP' = []}).

-record('diameter_sgi_base_acc_Used-Service-Unit',
        {'Tariff-Change-Usage' = [],
         'CC-Time' = [],
         'CC-Money' = [],
         'CC-Total-Octets' = [],
         'CC-Input-Octets' = [],
         'CC-Output-Octets' = [],
         'CC-Service-Specific-Units' = [],
         'AVP' = []}).

-record('diameter_sgi_base_acc_CC-Money',
        {'Unit-Value', 'Currency-Code' = []}).

-record('diameter_sgi_base_acc_G-S-U-Pool-Reference',
        {'G-S-U-Pool-Identifier',
         'CC-Unit-Type',
         'Unit-Value'}).

-record('diameter_sgi_base_acc_Final-Unit-Indication',
        {'Final-Unit-Action',
         'Restriction-Filter-Rule' = [],
         'Filter-Id' = [],
         'Redirect-Server' = []}).

-record('diameter_sgi_base_acc_Redirect-Server',
        {'Redirect-Address-Type', 'Redirect-Server-Address'}).

-record('diameter_sgi_base_acc_Service-Parameter-Info',
        {'Service-Parameter-Type', 'Service-Parameter-Value'}).

-record('diameter_sgi_base_acc_Subscription-Id',
        {'Subscription-Id-Type', 'Subscription-Id-Data'}).

-record('diameter_sgi_base_acc_User-Equipment-Info',
        {'User-Equipment-Info-Type',
         'User-Equipment-Info-Value'}).


%%% -------------------------------------------------------
%%% Grouped AVP records from diameter_travelping:
%%% -------------------------------------------------------

-record('diameter_sgi_base_acc_TP-Previous-PS-Information',
        {'QoS-Information' = [],
         'SGSN-Address' = [],
         '3GPP-SGSN-MCC-MNC' = [],
         '3GPP-MS-TimeZone' = [],
         '3GPP-User-Location-Info' = [],
         '3GPP-RAT-Type' = [],
         'AVP' = []}).


%%% -------------------------------------------------------
%%% ENUM Macros:
%%% -------------------------------------------------------

-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_PPP', 1).
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_SLIP', 2).
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_ARAP', 3).
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_GANDALF', 4).
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_XYLOGICS', 5).
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_X75', 6).
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_GPRS_PDP_CONTEXT', 7).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_USER_REQUEST', 11).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_LOST_CARRIER', 12).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_LOST_SERVICE', 13).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_IDLE_TIMEOUT', 14).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_SESSION_TIMEOUT', 15).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_ADMIN_RESET', 16).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_ADMIN_REBOOT', 17).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_PORT_ERROR', 18).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_NAS_ERROR', 19).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_NAS_REQUEST', 20).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_NAS_REBOOT', 21).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_PORT_UNNEEDED', 22).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_PORT_PREEMPTED', 23).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_PORT_SUSPENDED', 24).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_SERVICE_UNAVAILABLE', 25).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_CALLBACK', 26).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_USER_ERROR', 27).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_HOST_REQUEST', 28).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_SUPPLICANT_RESTART', 29).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_REAUTHORIZATION_FAILURE', 30).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_PORT_REINIT', 31).
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_PORT_DISABLED', 32).



%%% -------------------------------------------------------
%%% ENUM Macros from diameter_gen_base_rfc6733:
%%% -------------------------------------------------------

-ifndef('DIAMETER_SGI_BASE_ACC_DISCONNECT-CAUSE_REBOOTING').
-define('DIAMETER_SGI_BASE_ACC_DISCONNECT-CAUSE_REBOOTING', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_DISCONNECT-CAUSE_BUSY').
-define('DIAMETER_SGI_BASE_ACC_DISCONNECT-CAUSE_BUSY', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_DISCONNECT-CAUSE_DO_NOT_WANT_TO_TALK_TO_YOU').
-define('DIAMETER_SGI_BASE_ACC_DISCONNECT-CAUSE_DO_NOT_WANT_TO_TALK_TO_YOU', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_DONT_CACHE').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_DONT_CACHE', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_ALL_SESSION').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_ALL_SESSION', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_ALL_REALM').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_ALL_REALM', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_REALM_AND_APPLICATION').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_REALM_AND_APPLICATION', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_ALL_APPLICATION').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_ALL_APPLICATION', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_ALL_HOST').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_ALL_HOST', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_ALL_USER').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-HOST-USAGE_ALL_USER', 6).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_AUTH-REQUEST-TYPE_AUTHENTICATE_ONLY').
-define('DIAMETER_SGI_BASE_ACC_AUTH-REQUEST-TYPE_AUTHENTICATE_ONLY', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_AUTH-REQUEST-TYPE_AUTHORIZE_ONLY').
-define('DIAMETER_SGI_BASE_ACC_AUTH-REQUEST-TYPE_AUTHORIZE_ONLY', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE').
-define('DIAMETER_SGI_BASE_ACC_AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_AUTH-SESSION-STATE_STATE_MAINTAINED').
-define('DIAMETER_SGI_BASE_ACC_AUTH-SESSION-STATE_STATE_MAINTAINED', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_AUTH-SESSION-STATE_NO_STATE_MAINTAINED').
-define('DIAMETER_SGI_BASE_ACC_AUTH-SESSION-STATE_NO_STATE_MAINTAINED', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_RE-AUTH-REQUEST-TYPE_AUTHORIZE_ONLY').
-define('DIAMETER_SGI_BASE_ACC_RE-AUTH-REQUEST-TYPE_AUTHORIZE_ONLY', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_RE-AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE').
-define('DIAMETER_SGI_BASE_ACC_RE-AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_LOGOUT').
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_LOGOUT', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_SERVICE_NOT_PROVIDED').
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_SERVICE_NOT_PROVIDED', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_BAD_ANSWER').
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_BAD_ANSWER', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_ADMINISTRATIVE').
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_ADMINISTRATIVE', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_LINK_BROKEN').
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_LINK_BROKEN', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_AUTH_EXPIRED').
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_AUTH_EXPIRED', 6).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_USER_MOVED').
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_USER_MOVED', 7).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_SESSION_TIMEOUT').
-define('DIAMETER_SGI_BASE_ACC_TERMINATION-CAUSE_SESSION_TIMEOUT', 8).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SESSION-SERVER-FAILOVER_REFUSE_SERVICE').
-define('DIAMETER_SGI_BASE_ACC_SESSION-SERVER-FAILOVER_REFUSE_SERVICE', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SESSION-SERVER-FAILOVER_TRY_AGAIN').
-define('DIAMETER_SGI_BASE_ACC_SESSION-SERVER-FAILOVER_TRY_AGAIN', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SESSION-SERVER-FAILOVER_ALLOW_SERVICE').
-define('DIAMETER_SGI_BASE_ACC_SESSION-SERVER-FAILOVER_ALLOW_SERVICE', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SESSION-SERVER-FAILOVER_TRY_AGAIN_ALLOW_SERVICE').
-define('DIAMETER_SGI_BASE_ACC_SESSION-SERVER-FAILOVER_TRY_AGAIN_ALLOW_SERVICE', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-RECORD-TYPE_EVENT_RECORD').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-RECORD-TYPE_EVENT_RECORD', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-RECORD-TYPE_START_RECORD').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-RECORD-TYPE_START_RECORD', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-RECORD-TYPE_INTERIM_RECORD').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-RECORD-TYPE_INTERIM_RECORD', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-RECORD-TYPE_STOP_RECORD').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-RECORD-TYPE_STOP_RECORD', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-REALTIME-REQUIRED_DELIVER_AND_GRANT').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-REALTIME-REQUIRED_DELIVER_AND_GRANT', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_STORE').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_STORE', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_LOSE').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_LOSE', 3).
-endif.



%%% -------------------------------------------------------
%%% ENUM Macros from diameter_rfc4005_nasreq:
%%% -------------------------------------------------------

-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ASYNC').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ASYNC', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_SYNC').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_SYNC', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ISDN_SYNC').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ISDN_SYNC', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ISDN_ASYNC_V120').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ISDN_ASYNC_V120', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ISDN_ASYNC_V110').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ISDN_ASYNC_V110', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_VIRTUAL').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_VIRTUAL', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_PIAFS').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_PIAFS', 6).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_HDLC_CLEAR_CHANNEL').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_HDLC_CLEAR_CHANNEL', 7).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_X25').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_X25', 8).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_X75').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_X75', 9).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_G3FAX').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_G3FAX', 10).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_SDSL').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_SDSL', 11).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ADSL-CAP').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ADSL-CAP', 12).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ADSL-DMT').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ADSL-DMT', 13).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_IDSL').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_IDSL', 14).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ETHERNET').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_ETHERNET', 15).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_XDSL').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_XDSL', 16).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_CABLE').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_CABLE', 17).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_WIRELESS_OTHER').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_WIRELESS_OTHER', 18).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_WIRELESS_802.11').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_WIRELESS_802.11', 19).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_TOKEN-RING').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_TOKEN-RING', 20).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_FDDI').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_FDDI', 21).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_WIRELESS_CDMA2000').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_WIRELESS_CDMA2000', 22).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_WIRELESS_UMTS').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_WIRELESS_UMTS', 23).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_WIRELESS_1X-EV').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_WIRELESS_1X-EV', 24).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_IAPP').
-define('DIAMETER_SGI_BASE_ACC_NAS-PORT-TYPE_IAPP', 25).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_PROMPT_NO_ECHO').
-define('DIAMETER_SGI_BASE_ACC_PROMPT_NO_ECHO', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_PROMPT_ECHO').
-define('DIAMETER_SGI_BASE_ACC_PROMPT_ECHO', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CHAP-ALGORITHM_WITH_MD5').
-define('DIAMETER_SGI_BASE_ACC_CHAP-ALGORITHM_WITH_MD5', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_LOGIN').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_LOGIN', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_FRAMED').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_FRAMED', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_CALLBACK_LOGIN').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_CALLBACK_LOGIN', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_CALLBACK_FRAMED').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_CALLBACK_FRAMED', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_OUTBOUND').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_OUTBOUND', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_ADMINISTRATIVE').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_ADMINISTRATIVE', 6).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_NAS_PROMPT').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_NAS_PROMPT', 7).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_AUTHENTICATE_ONLY').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_AUTHENTICATE_ONLY', 8).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_CALLBACK_NAS_PROMPT').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_CALLBACK_NAS_PROMPT', 9).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_CALL_CHECK').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_CALL_CHECK', 10).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_CALLBACK_ADMINISTRATIVE').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_CALLBACK_ADMINISTRATIVE', 11).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_VOICE').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_VOICE', 12).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_FAX').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_FAX', 13).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_MODEM_RELAY').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_MODEM_RELAY', 14).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_IAPP-REGISTER').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_IAPP-REGISTER', 15).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_IAPP-AP-CHECK').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_IAPP-AP-CHECK', 16).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_AUTHORIZE_ONLY').
-define('DIAMETER_SGI_BASE_ACC_SERVICE-TYPE_AUTHORIZE_ONLY', 17).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_PPP').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_PPP', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_SLIP').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_SLIP', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_ARAP').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_ARAP', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_GANDALF').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_GANDALF', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_XYLOGICS').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_XYLOGICS', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_X75').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-PROTOCOL_X75', 6).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-ROUTING_NONE').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-ROUTING_NONE', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-ROUTING_SEND').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-ROUTING_SEND', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-ROUTING_LISTEN').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-ROUTING_LISTEN', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-ROUTING_SEND_AND_LISTEN').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-ROUTING_SEND_AND_LISTEN', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-COMPRESSION_NONE').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-COMPRESSION_NONE', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-COMPRESSION_VJ').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-COMPRESSION_VJ', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-COMPRESSION_IPX').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-COMPRESSION_IPX', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FRAMED-COMPRESSION_STAC-LZS').
-define('DIAMETER_SGI_BASE_ACC_FRAMED-COMPRESSION_STAC-LZS', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ARAP-ZONE-ACCESS_DEFAULT').
-define('DIAMETER_SGI_BASE_ACC_ARAP-ZONE-ACCESS_DEFAULT', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ARAP-ZONE-ACCESS_FILTER_INCLUSIVELY').
-define('DIAMETER_SGI_BASE_ACC_ARAP-ZONE-ACCESS_FILTER_INCLUSIVELY', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ARAP-ZONE-ACCESS_FILTER_EXCLUSIVELY').
-define('DIAMETER_SGI_BASE_ACC_ARAP-ZONE-ACCESS_FILTER_EXCLUSIVELY', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_TELNET').
-define('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_TELNET', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_RLOGIN').
-define('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_RLOGIN', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_TCP_CLEAR').
-define('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_TCP_CLEAR', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_PORTMASTER').
-define('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_PORTMASTER', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_LAT').
-define('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_LAT', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_X25-PAD').
-define('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_X25-PAD', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_X25-T3POS').
-define('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_X25-T3POS', 6).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_TCP_CLEAR_QUIET').
-define('DIAMETER_SGI_BASE_ACC_LOGIN-SERVICE_TCP_CLEAR_QUIET', 8).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_PPTP').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_PPTP', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_L2F').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_L2F', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_L2TP').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_L2TP', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_ATMP').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_ATMP', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_VTP').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_VTP', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_AH').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_AH', 6).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_IP-IP').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_IP-IP', 7).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_MIN-IP-IP').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_MIN-IP-IP', 8).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_ESP').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_ESP', 9).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_GRE').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_GRE', 10).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_DVS').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_DVS', 11).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_IP-IN-IP').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_IP-IN-IP', 12).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_VLAN').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-TYPE_VLAN', 13).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_IPV4').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_IPV4', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_IPV6').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_IPV6', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_NSAP').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_NSAP', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_HDLC').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_HDLC', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_BBN_1822').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_BBN_1822', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_802').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_802', 6).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_E163').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_E163', 7).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_E164').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_E164', 8).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_F69').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_F69', 9).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_X121').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_X121', 10).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_IPX').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_IPX', 11).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_APPLETALK').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_APPLETALK', 12).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_DECNET_IV').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_DECNET_IV', 13).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_BANYAN_VINES').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_BANYAN_VINES', 14).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_E164_NSAP').
-define('DIAMETER_SGI_BASE_ACC_TUNNEL-MEDIUM-TYPE_E164_NSAP', 15).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCT-AUTHENTIC_RADIUS').
-define('DIAMETER_SGI_BASE_ACC_ACCT-AUTHENTIC_RADIUS', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCT-AUTHENTIC_LOCAL').
-define('DIAMETER_SGI_BASE_ACC_ACCT-AUTHENTIC_LOCAL', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCT-AUTHENTIC_REMOTE').
-define('DIAMETER_SGI_BASE_ACC_ACCT-AUTHENTIC_REMOTE', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCT-AUTHENTIC_DIAMETER').
-define('DIAMETER_SGI_BASE_ACC_ACCT-AUTHENTIC_DIAMETER', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_PAP').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_PAP', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_CHAP').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_CHAP', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_MS-CHAP-1').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_MS-CHAP-1', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_MS-CHAP-2').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_MS-CHAP-2', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_EAP').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_EAP', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_NONE').
-define('DIAMETER_SGI_BASE_ACC_ACCOUNTING-AUTH-METHOD_NONE', 7).
-endif.



%%% -------------------------------------------------------
%%% ENUM Macros from diameter_rfc4006_cc:
%%% -------------------------------------------------------

-ifndef('DIAMETER_SGI_BASE_ACC_CC-REQUEST-TYPE_INITIAL_REQUEST').
-define('DIAMETER_SGI_BASE_ACC_CC-REQUEST-TYPE_INITIAL_REQUEST', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-REQUEST-TYPE_UPDATE_REQUEST').
-define('DIAMETER_SGI_BASE_ACC_CC-REQUEST-TYPE_UPDATE_REQUEST', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-REQUEST-TYPE_TERMINATION_REQUEST').
-define('DIAMETER_SGI_BASE_ACC_CC-REQUEST-TYPE_TERMINATION_REQUEST', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-REQUEST-TYPE_EVENT_REQUEST').
-define('DIAMETER_SGI_BASE_ACC_CC-REQUEST-TYPE_EVENT_REQUEST', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-SESSION-FAILOVER_NOT_SUPPORTED').
-define('DIAMETER_SGI_BASE_ACC_CC-SESSION-FAILOVER_NOT_SUPPORTED', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-SESSION-FAILOVER_SUPPORTED').
-define('DIAMETER_SGI_BASE_ACC_CC-SESSION-FAILOVER_SUPPORTED', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CHECK-BALANCE-RESULT_ENOUGH_CREDIT').
-define('DIAMETER_SGI_BASE_ACC_CHECK-BALANCE-RESULT_ENOUGH_CREDIT', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CHECK-BALANCE-RESULT_NO_CREDIT').
-define('DIAMETER_SGI_BASE_ACC_CHECK-BALANCE-RESULT_NO_CREDIT', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CREDIT-CONTROL_AUTHORIZATION').
-define('DIAMETER_SGI_BASE_ACC_CREDIT-CONTROL_AUTHORIZATION', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CREDIT-CONTROL_RE_AUTHORIZATION').
-define('DIAMETER_SGI_BASE_ACC_CREDIT-CONTROL_RE_AUTHORIZATION', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CREDIT-CONTROL-FAILURE-HANDLING_TERMINATE').
-define('DIAMETER_SGI_BASE_ACC_CREDIT-CONTROL-FAILURE-HANDLING_TERMINATE', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CREDIT-CONTROL-FAILURE-HANDLING_CONTINUE').
-define('DIAMETER_SGI_BASE_ACC_CREDIT-CONTROL-FAILURE-HANDLING_CONTINUE', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CREDIT-CONTROL-FAILURE-HANDLING_RETRY_AND_TERMINATE').
-define('DIAMETER_SGI_BASE_ACC_CREDIT-CONTROL-FAILURE-HANDLING_RETRY_AND_TERMINATE', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_DIRECT-DEBITING-FAILURE-HANDLING_TERMINATE_OR_BUFFER').
-define('DIAMETER_SGI_BASE_ACC_DIRECT-DEBITING-FAILURE-HANDLING_TERMINATE_OR_BUFFER', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_DIRECT-DEBITING-FAILURE-HANDLING_CONTINUE').
-define('DIAMETER_SGI_BASE_ACC_DIRECT-DEBITING-FAILURE-HANDLING_CONTINUE', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TARIFF-CHANGE-USAGE_UNIT_BEFORE_TARIFF_CHANGE').
-define('DIAMETER_SGI_BASE_ACC_TARIFF-CHANGE-USAGE_UNIT_BEFORE_TARIFF_CHANGE', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TARIFF-CHANGE-USAGE_UNIT_AFTER_TARIFF_CHANGE').
-define('DIAMETER_SGI_BASE_ACC_TARIFF-CHANGE-USAGE_UNIT_AFTER_TARIFF_CHANGE', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_TARIFF-CHANGE-USAGE_UNIT_INDETERMINATE').
-define('DIAMETER_SGI_BASE_ACC_TARIFF-CHANGE-USAGE_UNIT_INDETERMINATE', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_TIME').
-define('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_TIME', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_MONEY').
-define('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_MONEY', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_TOTAL-OCTETS').
-define('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_TOTAL-OCTETS', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_INPUT-OCTETS').
-define('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_INPUT-OCTETS', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_OUTPUT-OCTETS').
-define('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_OUTPUT-OCTETS', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_SERVICE-SPECIFIC-UNITS').
-define('DIAMETER_SGI_BASE_ACC_CC-UNIT-TYPE_SERVICE-SPECIFIC-UNITS', 5).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FINAL-UNIT-ACTION_TERMINATE').
-define('DIAMETER_SGI_BASE_ACC_FINAL-UNIT-ACTION_TERMINATE', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FINAL-UNIT-ACTION_REDIRECT').
-define('DIAMETER_SGI_BASE_ACC_FINAL-UNIT-ACTION_REDIRECT', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_FINAL-UNIT-ACTION_RESTRICT_ACCESS').
-define('DIAMETER_SGI_BASE_ACC_FINAL-UNIT-ACTION_RESTRICT_ACCESS', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-ADDRESS-TYPE_IPV4').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-ADDRESS-TYPE_IPV4', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-ADDRESS-TYPE_IPV6').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-ADDRESS-TYPE_IPV6', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-ADDRESS-TYPE_URL').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-ADDRESS-TYPE_URL', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REDIRECT-ADDRESS-TYPE_SIP_URI').
-define('DIAMETER_SGI_BASE_ACC_REDIRECT-ADDRESS-TYPE_SIP_URI', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_MULTIPLE-SERVICES-INDICATOR_NOT_SUPPORTED').
-define('DIAMETER_SGI_BASE_ACC_MULTIPLE-SERVICES-INDICATOR_NOT_SUPPORTED', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_MULTIPLE-SERVICES-INDICATOR_SUPPORTED').
-define('DIAMETER_SGI_BASE_ACC_MULTIPLE-SERVICES-INDICATOR_SUPPORTED', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REQUESTED-ACTION_DIRECT_DEBITING').
-define('DIAMETER_SGI_BASE_ACC_REQUESTED-ACTION_DIRECT_DEBITING', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REQUESTED-ACTION_REFUND_ACCOUNT').
-define('DIAMETER_SGI_BASE_ACC_REQUESTED-ACTION_REFUND_ACCOUNT', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REQUESTED-ACTION_CHECK_BALANCE').
-define('DIAMETER_SGI_BASE_ACC_REQUESTED-ACTION_CHECK_BALANCE', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_REQUESTED-ACTION_PRICE_ENQUIRY').
-define('DIAMETER_SGI_BASE_ACC_REQUESTED-ACTION_PRICE_ENQUIRY', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SUBSCRIPTION-ID-TYPE_END_USER_E164').
-define('DIAMETER_SGI_BASE_ACC_SUBSCRIPTION-ID-TYPE_END_USER_E164', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SUBSCRIPTION-ID-TYPE_END_USER_IMSI').
-define('DIAMETER_SGI_BASE_ACC_SUBSCRIPTION-ID-TYPE_END_USER_IMSI', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SUBSCRIPTION-ID-TYPE_END_USER_SIP_URI').
-define('DIAMETER_SGI_BASE_ACC_SUBSCRIPTION-ID-TYPE_END_USER_SIP_URI', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SUBSCRIPTION-ID-TYPE_END_USER_NAI').
-define('DIAMETER_SGI_BASE_ACC_SUBSCRIPTION-ID-TYPE_END_USER_NAI', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_SUBSCRIPTION-ID-TYPE_END_USER_PRIVATE').
-define('DIAMETER_SGI_BASE_ACC_SUBSCRIPTION-ID-TYPE_END_USER_PRIVATE', 4).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_USER-EQUIPMENT-INFO-TYPE_IMEISV').
-define('DIAMETER_SGI_BASE_ACC_USER-EQUIPMENT-INFO-TYPE_IMEISV', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_USER-EQUIPMENT-INFO-TYPE_MAC').
-define('DIAMETER_SGI_BASE_ACC_USER-EQUIPMENT-INFO-TYPE_MAC', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_USER-EQUIPMENT-INFO-TYPE_EUI64').
-define('DIAMETER_SGI_BASE_ACC_USER-EQUIPMENT-INFO-TYPE_EUI64', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_USER-EQUIPMENT-INFO-TYPE_MODIFIED_EUI64').
-define('DIAMETER_SGI_BASE_ACC_USER-EQUIPMENT-INFO-TYPE_MODIFIED_EUI64', 3).
-endif.



%%% -------------------------------------------------------
%%% ENUM Macros from diameter_3gpp_base:
%%% -------------------------------------------------------

-ifndef('DIAMETER_SGI_BASE_ACC_3GPP-PDP-TYPE_IPV4').
-define('DIAMETER_SGI_BASE_ACC_3GPP-PDP-TYPE_IPV4', 0).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_3GPP-PDP-TYPE_PPP').
-define('DIAMETER_SGI_BASE_ACC_3GPP-PDP-TYPE_PPP', 1).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_3GPP-PDP-TYPE_IPV6').
-define('DIAMETER_SGI_BASE_ACC_3GPP-PDP-TYPE_IPV6', 2).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_3GPP-PDP-TYPE_IPV4V6').
-define('DIAMETER_SGI_BASE_ACC_3GPP-PDP-TYPE_IPV4V6', 3).
-endif.
-ifndef('DIAMETER_SGI_BASE_ACC_3GPP-PDP-TYPE_NON-IP').
-define('DIAMETER_SGI_BASE_ACC_3GPP-PDP-TYPE_NON-IP', 4).
-endif.

