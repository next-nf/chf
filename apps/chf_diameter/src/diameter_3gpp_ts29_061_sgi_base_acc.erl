%% -------------------------------------------------------------------
%% This is a generated file.
%% -------------------------------------------------------------------

-module(diameter_3gpp_ts29_061_sgi_base_acc).

-moduledoc(false).

-compile({parse_transform, diameter_exprecs}).

-compile(nowarn_unused_function).

-dialyzer(no_return).

-export_records([diameter_sgi_base_acc_ACR,
                 diameter_sgi_base_acc_ACA,
                 'diameter_sgi_base_acc_Proxy-Info',
                 'diameter_sgi_base_acc_Failed-AVP',
                 'diameter_sgi_base_acc_Experimental-Result',
                 'diameter_sgi_base_acc_Vendor-Specific-Application-Id',
                 'diameter_sgi_base_acc_CHAP-Auth',
                 diameter_sgi_base_acc_Tunneling,
                 'diameter_sgi_base_acc_Cost-Information',
                 'diameter_sgi_base_acc_Unit-Value',
                 'diameter_sgi_base_acc_Multiple-Services-Credit-Control',
                 'diameter_sgi_base_acc_Granted-Service-Unit',
                 'diameter_sgi_base_acc_Requested-Service-Unit',
                 'diameter_sgi_base_acc_Used-Service-Unit',
                 'diameter_sgi_base_acc_CC-Money',
                 'diameter_sgi_base_acc_G-S-U-Pool-Reference',
                 'diameter_sgi_base_acc_Final-Unit-Indication',
                 'diameter_sgi_base_acc_Redirect-Server',
                 'diameter_sgi_base_acc_Service-Parameter-Info',
                 'diameter_sgi_base_acc_Subscription-Id',
                 'diameter_sgi_base_acc_User-Equipment-Info',
                 'diameter_sgi_base_acc_TP-Previous-PS-Information']).

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

-record('diameter_sgi_base_acc_TP-Previous-PS-Information',
        {'QoS-Information' = [],
         'SGSN-Address' = [],
         '3GPP-SGSN-MCC-MNC' = [],
         '3GPP-MS-TimeZone' = [],
         '3GPP-User-Location-Info' = [],
         '3GPP-RAT-Type' = [],
         'AVP' = []}).

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

name() -> diameter_3gpp_ts29_061_sgi_base_acc.

id() -> 3.

vendor_id() -> 10415.

vendor_name() -> '3GPP'.

msg_name(271, true) -> 'ACR';
msg_name(271, false) -> 'ACA';
msg_name(_, _) -> ''.

msg_header('ACR') -> {271, 192, 3};
msg_header('ACA') -> {271, 64, 3};
msg_header(_) -> erlang:error(badarg).

rec2msg(diameter_sgi_base_acc_ACR) -> 'ACR';
rec2msg(diameter_sgi_base_acc_ACA) -> 'ACA';
rec2msg(_) -> erlang:error(badarg).

msg2rec('ACR') -> diameter_sgi_base_acc_ACR;
msg2rec('ACA') -> diameter_sgi_base_acc_ACA;
msg2rec(_) -> erlang:error(badarg).

name2rec('Proxy-Info') ->
    'diameter_sgi_base_acc_Proxy-Info';
name2rec('Failed-AVP') ->
    'diameter_sgi_base_acc_Failed-AVP';
name2rec('Experimental-Result') ->
    'diameter_sgi_base_acc_Experimental-Result';
name2rec('Vendor-Specific-Application-Id') ->
    'diameter_sgi_base_acc_Vendor-Specific-Application-Id';
name2rec('CHAP-Auth') ->
    'diameter_sgi_base_acc_CHAP-Auth';
name2rec('Tunneling') ->
    diameter_sgi_base_acc_Tunneling;
name2rec('Cost-Information') ->
    'diameter_sgi_base_acc_Cost-Information';
name2rec('Unit-Value') ->
    'diameter_sgi_base_acc_Unit-Value';
name2rec('Multiple-Services-Credit-Control') ->
    'diameter_sgi_base_acc_Multiple-Services-Credit-Control';
name2rec('Granted-Service-Unit') ->
    'diameter_sgi_base_acc_Granted-Service-Unit';
name2rec('Requested-Service-Unit') ->
    'diameter_sgi_base_acc_Requested-Service-Unit';
name2rec('Used-Service-Unit') ->
    'diameter_sgi_base_acc_Used-Service-Unit';
name2rec('CC-Money') ->
    'diameter_sgi_base_acc_CC-Money';
name2rec('G-S-U-Pool-Reference') ->
    'diameter_sgi_base_acc_G-S-U-Pool-Reference';
name2rec('Final-Unit-Indication') ->
    'diameter_sgi_base_acc_Final-Unit-Indication';
name2rec('Redirect-Server') ->
    'diameter_sgi_base_acc_Redirect-Server';
name2rec('Service-Parameter-Info') ->
    'diameter_sgi_base_acc_Service-Parameter-Info';
name2rec('Subscription-Id') ->
    'diameter_sgi_base_acc_Subscription-Id';
name2rec('User-Equipment-Info') ->
    'diameter_sgi_base_acc_User-Equipment-Info';
name2rec('TP-Previous-PS-Information') ->
    'diameter_sgi_base_acc_TP-Previous-PS-Information';
name2rec(T) -> msg2rec(T).

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
avp_name(84, undefined) ->
    {'ARAP-Challenge-Response', 'OctetString'};
avp_name(71, undefined) ->
    {'ARAP-Features', 'OctetString'};
avp_name(70, undefined) ->
    {'ARAP-Password', 'OctetString'};
avp_name(73, undefined) ->
    {'ARAP-Security', 'Unsigned32'};
avp_name(74, undefined) ->
    {'ARAP-Security-Data', 'OctetString'};
avp_name(72, undefined) ->
    {'ARAP-Zone-Access', 'Enumerated'};
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
avp_name(403, undefined) ->
    {'CHAP-Algorithm', 'Enumerated'};
avp_name(402, undefined) -> {'CHAP-Auth', 'Grouped'};
avp_name(60, undefined) ->
    {'CHAP-Challenge', 'OctetString'};
avp_name(404, undefined) ->
    {'CHAP-Ident', 'OctetString'};
avp_name(405, undefined) ->
    {'CHAP-Response', 'OctetString'};
avp_name(20, undefined) ->
    {'Callback-Id', 'UTF8String'};
avp_name(19, undefined) ->
    {'Callback-Number', 'UTF8String'};
avp_name(30, undefined) ->
    {'Called-Station-Id', 'UTF8String'};
avp_name(31, undefined) ->
    {'Calling-Station-Id', 'UTF8String'};
avp_name(78, undefined) ->
    {'Configuration-Token', 'OctetString'};
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
    {'Framed-IPX-Network', 'UTF8String'};
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
avp_name(75, undefined) ->
    {'Password-Retry', 'Unsigned32'};
avp_name(62, undefined) -> {'Port-Limit', 'Unsigned32'};
avp_name(76, undefined) -> {'Prompt', 'Enumerated'};
avp_name(407, undefined) ->
    {'QoS-Filter-Rule', 'QoSFilterRule'};
avp_name(18, undefined) ->
    {'Reply-Message', 'UTF8String'};
avp_name(6, undefined) ->
    {'Service-Type', 'Enumerated'};
avp_name(24, undefined) -> {'State', 'OctetString'};
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
avp_name(2, undefined) ->
    {'User-Password', 'OctetString'};
avp_name(411, undefined) ->
    {'CC-Correlation-Id', 'OctetString'};
avp_name(412, undefined) ->
    {'CC-Input-Octets', 'Unsigned64'};
avp_name(413, undefined) -> {'CC-Money', 'Grouped'};
avp_name(414, undefined) ->
    {'CC-Output-Octets', 'Unsigned64'};
avp_name(415, undefined) ->
    {'CC-Request-Number', 'Unsigned32'};
avp_name(416, undefined) ->
    {'CC-Request-Type', 'Enumerated'};
avp_name(417, undefined) ->
    {'CC-Service-Specific-Units', 'Unsigned64'};
avp_name(418, undefined) ->
    {'CC-Session-Failover', 'Enumerated'};
avp_name(419, undefined) ->
    {'CC-Sub-Session-Id', 'Unsigned64'};
avp_name(420, undefined) -> {'CC-Time', 'Unsigned32'};
avp_name(421, undefined) ->
    {'CC-Total-Octets', 'Unsigned64'};
avp_name(454, undefined) ->
    {'CC-Unit-Type', 'Enumerated'};
avp_name(422, undefined) ->
    {'Check-Balance-Result', 'Enumerated'};
avp_name(423, undefined) ->
    {'Cost-Information', 'Grouped'};
avp_name(424, undefined) -> {'Cost-Unit', 'UTF8String'};
avp_name(426, undefined) ->
    {'Credit-Control', 'Enumerated'};
avp_name(427, undefined) ->
    {'Credit-Control-Failure-Handling', 'Enumerated'};
avp_name(425, undefined) ->
    {'Currency-Code', 'Unsigned32'};
avp_name(428, undefined) ->
    {'Direct-Debiting-Failure-Handling', 'Enumerated'};
avp_name(429, undefined) -> {'Exponent', 'Integer32'};
avp_name(449, undefined) ->
    {'Final-Unit-Action', 'Enumerated'};
avp_name(430, undefined) ->
    {'Final-Unit-Indication', 'Grouped'};
avp_name(453, undefined) ->
    {'G-S-U-Pool-Identifier', 'Unsigned32'};
avp_name(457, undefined) ->
    {'G-S-U-Pool-Reference', 'Grouped'};
avp_name(431, undefined) ->
    {'Granted-Service-Unit', 'Grouped'};
avp_name(456, undefined) ->
    {'Multiple-Services-Credit-Control', 'Grouped'};
avp_name(455, undefined) ->
    {'Multiple-Services-Indicator', 'Enumerated'};
avp_name(432, undefined) ->
    {'Rating-Group', 'Unsigned32'};
avp_name(433, undefined) ->
    {'Redirect-Address-Type', 'Enumerated'};
avp_name(434, undefined) ->
    {'Redirect-Server', 'Grouped'};
avp_name(435, undefined) ->
    {'Redirect-Server-Address', 'UTF8String'};
avp_name(436, undefined) ->
    {'Requested-Action', 'Enumerated'};
avp_name(437, undefined) ->
    {'Requested-Service-Unit', 'Grouped'};
avp_name(438, undefined) ->
    {'Restriction-Filter-Rule', 'IPFilterRule'};
avp_name(461, undefined) ->
    {'Service-Context-Id', 'UTF8String'};
avp_name(439, undefined) ->
    {'Service-Identifier', 'Unsigned32'};
avp_name(440, undefined) ->
    {'Service-Parameter-Info', 'Grouped'};
avp_name(441, undefined) ->
    {'Service-Parameter-Type', 'Unsigned32'};
avp_name(442, undefined) ->
    {'Service-Parameter-Value', 'OctetString'};
avp_name(443, undefined) ->
    {'Subscription-Id', 'Grouped'};
avp_name(444, undefined) ->
    {'Subscription-Id-Data', 'UTF8String'};
avp_name(450, undefined) ->
    {'Subscription-Id-Type', 'Enumerated'};
avp_name(452, undefined) ->
    {'Tariff-Change-Usage', 'Enumerated'};
avp_name(451, undefined) ->
    {'Tariff-Time-Change', 'Time'};
avp_name(445, undefined) -> {'Unit-Value', 'Grouped'};
avp_name(446, undefined) ->
    {'Used-Service-Unit', 'Grouped'};
avp_name(458, undefined) ->
    {'User-Equipment-Info', 'Grouped'};
avp_name(459, undefined) ->
    {'User-Equipment-Info-Type', 'Enumerated'};
avp_name(460, undefined) ->
    {'User-Equipment-Info-Value', 'OctetString'};
avp_name(448, undefined) ->
    {'Validity-Time', 'Unsigned32'};
avp_name(447, undefined) ->
    {'Value-Digits', 'Integer64'};
avp_name(27, 10415) ->
    {'3GPP-Allocate-IP-Type', 'OctetString'};
avp_name(24, 10415) ->
    {'3GPP-CAMEL-Charging-Info', 'OctetString'};
avp_name(4, 10415) ->
    {'3GPP-CG-Address', 'OctetString'};
avp_name(14, 10415) ->
    {'3GPP-CG-IPv6-Address', 'OctetString'};
avp_name(13, 10415) ->
    {'3GPP-Charging-Characteristics', 'UTF8String'};
avp_name(2, 10415) ->
    {'3GPP-Charging-Id', 'Unsigned32'};
avp_name(7, 10415) ->
    {'3GPP-GGSN-Address', 'OctetString'};
avp_name(16, 10415) ->
    {'3GPP-GGSN-IPv6-Address', 'OctetString'};
avp_name(9, 10415) ->
    {'3GPP-GGSN-MCC-MNC', 'UTF8String'};
avp_name(5, 10415) ->
    {'3GPP-GPRS-Negotiated-QoS-Profile', 'UTF8String'};
avp_name(20, 10415) -> {'3GPP-IMEISV', 'OctetString'};
avp_name(1, 10415) -> {'3GPP-IMSI', 'UTF8String'};
avp_name(8, 10415) ->
    {'3GPP-IMSI-MCC-MNC', 'UTF8String'};
avp_name(17, 10415) ->
    {'3GPP-IPv6-DNS-Servers', 'OctetString'};
avp_name(23, 10415) ->
    {'3GPP-MS-TimeZone', 'OctetString'};
avp_name(10, 10415) -> {'3GPP-NSAPI', 'OctetString'};
avp_name(26, 10415) ->
    {'3GPP-Negotiated-DSCP', 'OctetString'};
avp_name(3, 10415) -> {'3GPP-PDP-Type', 'Enumerated'};
avp_name(25, 10415) ->
    {'3GPP-Packet-Filter', 'OctetString'};
avp_name(21, 10415) -> {'3GPP-RAT-Type', 'OctetString'};
avp_name(6, 10415) ->
    {'3GPP-SGSN-Address', 'OctetString'};
avp_name(15, 10415) ->
    {'3GPP-SGSN-IPv6-Address', 'OctetString'};
avp_name(18, 10415) ->
    {'3GPP-SGSN-MCC-MNC', 'UTF8String'};
avp_name(12, 10415) ->
    {'3GPP-Selection-Mode', 'UTF8String'};
avp_name(11, 10415) ->
    {'3GPP-Session-Stop-Indicator', 'OctetString'};
avp_name(22, 10415) ->
    {'3GPP-User-Location-Info', 'OctetString'};
avp_name(30, 10415) ->
    {'3GPP-User-Location-Info-Time', 'Unsigned32'};
avp_name(29, 10415) ->
    {'TWAN-Identifier', 'OctetString'};
avp_name(16, 18681) ->
    {'TP-NAT-IP-Address', 'OctetString'};
avp_name(27, 18681) -> {'TP-NAT-Pool-Id', 'UTF8String'};
avp_name(29, 18681) ->
    {'TP-NAT-Port-End', 'Unsigned32'};
avp_name(28, 18681) ->
    {'TP-NAT-Port-Start', 'Unsigned32'};
avp_name(64, 18681) ->
    {'TP-Previous-PS-Information', 'Grouped'};
avp_name(_, _) -> 'AVP'.

avp_arity('ACR') ->
    [{'Session-Id', 1},
     {'Origin-Host', 1},
     {'Origin-Realm', 1},
     {'Destination-Realm', 1},
     {'Accounting-Record-Type', 1},
     {'Accounting-Record-Number', 1},
     {'Acct-Application-Id', {0, 1}},
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
     {'3GPP-IMSI', {0, 1}},
     {'3GPP-Charging-Id', {0, 1}},
     {'3GPP-PDP-Type', {0, 1}},
     {'3GPP-CG-Address', {0, 1}},
     {'3GPP-GPRS-Negotiated-QoS-Profile', {0, 1}},
     {'3GPP-SGSN-Address', {0, 1}},
     {'3GPP-GGSN-Address', {0, 1}},
     {'3GPP-IMSI-MCC-MNC', {0, 1}},
     {'3GPP-GGSN-MCC-MNC', {0, 1}},
     {'3GPP-NSAPI', {0, 1}},
     {'3GPP-Selection-Mode', {0, 1}},
     {'3GPP-Charging-Characteristics', {0, 1}},
     {'3GPP-CG-IPv6-Address', {0, 1}},
     {'3GPP-SGSN-IPv6-Address', {0, 1}},
     {'3GPP-GGSN-IPv6-Address', {0, 1}},
     {'3GPP-SGSN-MCC-MNC', {0, 1}},
     {'3GPP-IMEISV', {0, 1}},
     {'3GPP-RAT-Type', {0, 1}},
     {'3GPP-User-Location-Info', {0, 1}},
     {'3GPP-MS-TimeZone', {0, 1}},
     {'3GPP-CAMEL-Charging-Info', {0, 1}},
     {'3GPP-Packet-Filter', {0, 1}},
     {'3GPP-Negotiated-DSCP', {0, 1}},
     {'TWAN-Identifier', {0, 1}},
     {'3GPP-User-Location-Info-Time', {0, 1}},
     {'TP-NAT-IP-Address', {0, 1}},
     {'TP-NAT-Pool-Id', {0, 1}},
     {'TP-NAT-Port-Start', {0, 1}},
     {'TP-NAT-Port-End', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('ACA') ->
    [{'Session-Id', 1},
     {'Result-Code', 1},
     {'Origin-Host', 1},
     {'Origin-Realm', 1},
     {'Accounting-Record-Type', 1},
     {'Accounting-Record-Number', 1},
     {'Acct-Application-Id', {0, 1}},
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
     {'3GPP-IPv6-DNS-Servers', {0, 1}},
     {'AVP', {0, '*'}}];
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
avp_arity('CHAP-Auth') ->
    [{'CHAP-Algorithm', 1},
     {'CHAP-Ident', 1},
     {'CHAP-Response', {0, 1}},
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
avp_arity('Cost-Information') ->
    [{'Unit-Value', 1},
     {'Currency-Code', 1},
     {'Cost-Unit', {0, 1}}];
avp_arity('Unit-Value') ->
    [{'Value-Digits', 1}, {'Exponent', {0, 1}}];
avp_arity('Multiple-Services-Credit-Control') ->
    [{'Granted-Service-Unit', {0, 1}},
     {'Requested-Service-Unit', {0, 1}},
     {'Used-Service-Unit', {0, '*'}},
     {'Tariff-Change-Usage', {0, 1}},
     {'Service-Identifier', {0, '*'}},
     {'Rating-Group', {0, 1}},
     {'G-S-U-Pool-Reference', {0, '*'}},
     {'Validity-Time', {0, 1}},
     {'Result-Code', {0, 1}},
     {'Final-Unit-Indication', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Granted-Service-Unit') ->
    [{'Tariff-Time-Change', {0, 1}},
     {'CC-Time', {0, 1}},
     {'CC-Money', {0, 1}},
     {'CC-Total-Octets', {0, 1}},
     {'CC-Input-Octets', {0, 1}},
     {'CC-Output-Octets', {0, 1}},
     {'CC-Service-Specific-Units', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Requested-Service-Unit') ->
    [{'CC-Time', {0, 1}},
     {'CC-Money', {0, 1}},
     {'CC-Total-Octets', {0, 1}},
     {'CC-Input-Octets', {0, 1}},
     {'CC-Output-Octets', {0, 1}},
     {'CC-Service-Specific-Units', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Used-Service-Unit') ->
    [{'Tariff-Change-Usage', {0, 1}},
     {'CC-Time', {0, 1}},
     {'CC-Money', {0, 1}},
     {'CC-Total-Octets', {0, 1}},
     {'CC-Input-Octets', {0, 1}},
     {'CC-Output-Octets', {0, 1}},
     {'CC-Service-Specific-Units', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('CC-Money') ->
    [{'Unit-Value', 1}, {'Currency-Code', {0, 1}}];
avp_arity('G-S-U-Pool-Reference') ->
    [{'G-S-U-Pool-Identifier', 1},
     {'CC-Unit-Type', 1},
     {'Unit-Value', 1}];
avp_arity('Final-Unit-Indication') ->
    [{'Final-Unit-Action', 1},
     {'Restriction-Filter-Rule', {0, '*'}},
     {'Filter-Id', {0, '*'}},
     {'Redirect-Server', {0, 1}}];
avp_arity('Redirect-Server') ->
    [{'Redirect-Address-Type', 1},
     {'Redirect-Server-Address', 1}];
avp_arity('Service-Parameter-Info') ->
    [{'Service-Parameter-Type', 1},
     {'Service-Parameter-Value', 1}];
avp_arity('Subscription-Id') ->
    [{'Subscription-Id-Type', 1},
     {'Subscription-Id-Data', 1}];
avp_arity('User-Equipment-Info') ->
    [{'User-Equipment-Info-Type', 1},
     {'User-Equipment-Info-Value', 1}];
avp_arity('TP-Previous-PS-Information') ->
    [{'QoS-Information', {0, 1}},
     {'SGSN-Address', {0, '*'}},
     {'3GPP-SGSN-MCC-MNC', {0, 1}},
     {'3GPP-MS-TimeZone', {0, 1}},
     {'3GPP-User-Location-Info', {0, 1}},
     {'3GPP-RAT-Type', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity(_) -> erlang:error(badarg).

avp_arity('ACR', 'Session-Id') -> 1;
avp_arity('ACR', 'Origin-Host') -> 1;
avp_arity('ACR', 'Origin-Realm') -> 1;
avp_arity('ACR', 'Destination-Realm') -> 1;
avp_arity('ACR', 'Accounting-Record-Type') -> 1;
avp_arity('ACR', 'Accounting-Record-Number') -> 1;
avp_arity('ACR', 'Acct-Application-Id') -> {0, 1};
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
avp_arity('ACR', '3GPP-IMSI') -> {0, 1};
avp_arity('ACR', '3GPP-Charging-Id') -> {0, 1};
avp_arity('ACR', '3GPP-PDP-Type') -> {0, 1};
avp_arity('ACR', '3GPP-CG-Address') -> {0, 1};
avp_arity('ACR', '3GPP-GPRS-Negotiated-QoS-Profile') ->
    {0, 1};
avp_arity('ACR', '3GPP-SGSN-Address') -> {0, 1};
avp_arity('ACR', '3GPP-GGSN-Address') -> {0, 1};
avp_arity('ACR', '3GPP-IMSI-MCC-MNC') -> {0, 1};
avp_arity('ACR', '3GPP-GGSN-MCC-MNC') -> {0, 1};
avp_arity('ACR', '3GPP-NSAPI') -> {0, 1};
avp_arity('ACR', '3GPP-Selection-Mode') -> {0, 1};
avp_arity('ACR', '3GPP-Charging-Characteristics') ->
    {0, 1};
avp_arity('ACR', '3GPP-CG-IPv6-Address') -> {0, 1};
avp_arity('ACR', '3GPP-SGSN-IPv6-Address') -> {0, 1};
avp_arity('ACR', '3GPP-GGSN-IPv6-Address') -> {0, 1};
avp_arity('ACR', '3GPP-SGSN-MCC-MNC') -> {0, 1};
avp_arity('ACR', '3GPP-IMEISV') -> {0, 1};
avp_arity('ACR', '3GPP-RAT-Type') -> {0, 1};
avp_arity('ACR', '3GPP-User-Location-Info') -> {0, 1};
avp_arity('ACR', '3GPP-MS-TimeZone') -> {0, 1};
avp_arity('ACR', '3GPP-CAMEL-Charging-Info') -> {0, 1};
avp_arity('ACR', '3GPP-Packet-Filter') -> {0, 1};
avp_arity('ACR', '3GPP-Negotiated-DSCP') -> {0, 1};
avp_arity('ACR', 'TWAN-Identifier') -> {0, 1};
avp_arity('ACR', '3GPP-User-Location-Info-Time') ->
    {0, 1};
avp_arity('ACR', 'TP-NAT-IP-Address') -> {0, 1};
avp_arity('ACR', 'TP-NAT-Pool-Id') -> {0, 1};
avp_arity('ACR', 'TP-NAT-Port-Start') -> {0, 1};
avp_arity('ACR', 'TP-NAT-Port-End') -> {0, 1};
avp_arity('ACR', 'AVP') -> {0, '*'};
avp_arity('ACA', 'Session-Id') -> 1;
avp_arity('ACA', 'Result-Code') -> 1;
avp_arity('ACA', 'Origin-Host') -> 1;
avp_arity('ACA', 'Origin-Realm') -> 1;
avp_arity('ACA', 'Accounting-Record-Type') -> 1;
avp_arity('ACA', 'Accounting-Record-Number') -> 1;
avp_arity('ACA', 'Acct-Application-Id') -> {0, 1};
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
avp_arity('ACA', '3GPP-IPv6-DNS-Servers') -> {0, 1};
avp_arity('ACA', 'AVP') -> {0, '*'};
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
avp_arity('CHAP-Auth', 'CHAP-Algorithm') -> 1;
avp_arity('CHAP-Auth', 'CHAP-Ident') -> 1;
avp_arity('CHAP-Auth', 'CHAP-Response') -> {0, 1};
avp_arity('CHAP-Auth', 'AVP') -> {0, '*'};
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
avp_arity('Cost-Information', 'Unit-Value') -> 1;
avp_arity('Cost-Information', 'Currency-Code') -> 1;
avp_arity('Cost-Information', 'Cost-Unit') -> {0, 1};
avp_arity('Unit-Value', 'Value-Digits') -> 1;
avp_arity('Unit-Value', 'Exponent') -> {0, 1};
avp_arity('Multiple-Services-Credit-Control',
          'Granted-Service-Unit') ->
    {0, 1};
avp_arity('Multiple-Services-Credit-Control',
          'Requested-Service-Unit') ->
    {0, 1};
avp_arity('Multiple-Services-Credit-Control',
          'Used-Service-Unit') ->
    {0, '*'};
avp_arity('Multiple-Services-Credit-Control',
          'Tariff-Change-Usage') ->
    {0, 1};
avp_arity('Multiple-Services-Credit-Control',
          'Service-Identifier') ->
    {0, '*'};
avp_arity('Multiple-Services-Credit-Control',
          'Rating-Group') ->
    {0, 1};
avp_arity('Multiple-Services-Credit-Control',
          'G-S-U-Pool-Reference') ->
    {0, '*'};
avp_arity('Multiple-Services-Credit-Control',
          'Validity-Time') ->
    {0, 1};
avp_arity('Multiple-Services-Credit-Control',
          'Result-Code') ->
    {0, 1};
avp_arity('Multiple-Services-Credit-Control',
          'Final-Unit-Indication') ->
    {0, 1};
avp_arity('Multiple-Services-Credit-Control', 'AVP') ->
    {0, '*'};
avp_arity('Granted-Service-Unit',
          'Tariff-Time-Change') ->
    {0, 1};
avp_arity('Granted-Service-Unit', 'CC-Time') -> {0, 1};
avp_arity('Granted-Service-Unit', 'CC-Money') -> {0, 1};
avp_arity('Granted-Service-Unit', 'CC-Total-Octets') ->
    {0, 1};
avp_arity('Granted-Service-Unit', 'CC-Input-Octets') ->
    {0, 1};
avp_arity('Granted-Service-Unit', 'CC-Output-Octets') ->
    {0, 1};
avp_arity('Granted-Service-Unit',
          'CC-Service-Specific-Units') ->
    {0, 1};
avp_arity('Granted-Service-Unit', 'AVP') -> {0, '*'};
avp_arity('Requested-Service-Unit', 'CC-Time') ->
    {0, 1};
avp_arity('Requested-Service-Unit', 'CC-Money') ->
    {0, 1};
avp_arity('Requested-Service-Unit',
          'CC-Total-Octets') ->
    {0, 1};
avp_arity('Requested-Service-Unit',
          'CC-Input-Octets') ->
    {0, 1};
avp_arity('Requested-Service-Unit',
          'CC-Output-Octets') ->
    {0, 1};
avp_arity('Requested-Service-Unit',
          'CC-Service-Specific-Units') ->
    {0, 1};
avp_arity('Requested-Service-Unit', 'AVP') -> {0, '*'};
avp_arity('Used-Service-Unit', 'Tariff-Change-Usage') ->
    {0, 1};
avp_arity('Used-Service-Unit', 'CC-Time') -> {0, 1};
avp_arity('Used-Service-Unit', 'CC-Money') -> {0, 1};
avp_arity('Used-Service-Unit', 'CC-Total-Octets') ->
    {0, 1};
avp_arity('Used-Service-Unit', 'CC-Input-Octets') ->
    {0, 1};
avp_arity('Used-Service-Unit', 'CC-Output-Octets') ->
    {0, 1};
avp_arity('Used-Service-Unit',
          'CC-Service-Specific-Units') ->
    {0, 1};
avp_arity('Used-Service-Unit', 'AVP') -> {0, '*'};
avp_arity('CC-Money', 'Unit-Value') -> 1;
avp_arity('CC-Money', 'Currency-Code') -> {0, 1};
avp_arity('G-S-U-Pool-Reference',
          'G-S-U-Pool-Identifier') ->
    1;
avp_arity('G-S-U-Pool-Reference', 'CC-Unit-Type') -> 1;
avp_arity('G-S-U-Pool-Reference', 'Unit-Value') -> 1;
avp_arity('Final-Unit-Indication',
          'Final-Unit-Action') ->
    1;
avp_arity('Final-Unit-Indication',
          'Restriction-Filter-Rule') ->
    {0, '*'};
avp_arity('Final-Unit-Indication', 'Filter-Id') ->
    {0, '*'};
avp_arity('Final-Unit-Indication', 'Redirect-Server') ->
    {0, 1};
avp_arity('Redirect-Server', 'Redirect-Address-Type') ->
    1;
avp_arity('Redirect-Server',
          'Redirect-Server-Address') ->
    1;
avp_arity('Service-Parameter-Info',
          'Service-Parameter-Type') ->
    1;
avp_arity('Service-Parameter-Info',
          'Service-Parameter-Value') ->
    1;
avp_arity('Subscription-Id', 'Subscription-Id-Type') ->
    1;
avp_arity('Subscription-Id', 'Subscription-Id-Data') ->
    1;
avp_arity('User-Equipment-Info',
          'User-Equipment-Info-Type') ->
    1;
avp_arity('User-Equipment-Info',
          'User-Equipment-Info-Value') ->
    1;
avp_arity('TP-Previous-PS-Information',
          'QoS-Information') ->
    {0, 1};
avp_arity('TP-Previous-PS-Information',
          'SGSN-Address') ->
    {0, '*'};
avp_arity('TP-Previous-PS-Information',
          '3GPP-SGSN-MCC-MNC') ->
    {0, 1};
avp_arity('TP-Previous-PS-Information',
          '3GPP-MS-TimeZone') ->
    {0, 1};
avp_arity('TP-Previous-PS-Information',
          '3GPP-User-Location-Info') ->
    {0, 1};
avp_arity('TP-Previous-PS-Information',
          '3GPP-RAT-Type') ->
    {0, 1};
avp_arity('TP-Previous-PS-Information', 'AVP') ->
    {0, '*'};
avp_arity(_, _) -> 0.

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
avp_header('ARAP-Challenge-Response') ->
    diameter_rfc4005_nasreq:avp_header('ARAP-Challenge-Response');
avp_header('ARAP-Features') ->
    diameter_rfc4005_nasreq:avp_header('ARAP-Features');
avp_header('ARAP-Password') ->
    diameter_rfc4005_nasreq:avp_header('ARAP-Password');
avp_header('ARAP-Security') ->
    diameter_rfc4005_nasreq:avp_header('ARAP-Security');
avp_header('ARAP-Security-Data') ->
    diameter_rfc4005_nasreq:avp_header('ARAP-Security-Data');
avp_header('ARAP-Zone-Access') ->
    diameter_rfc4005_nasreq:avp_header('ARAP-Zone-Access');
avp_header('Accounting-Auth-Method') ->
    diameter_rfc4005_nasreq:avp_header('Accounting-Auth-Method');
avp_header('Accounting-Input-Octets') ->
    diameter_rfc4005_nasreq:avp_header('Accounting-Input-Octets');
avp_header('Accounting-Input-Packets') ->
    diameter_rfc4005_nasreq:avp_header('Accounting-Input-Packets');
avp_header('Accounting-Output-Octets') ->
    diameter_rfc4005_nasreq:avp_header('Accounting-Output-Octets');
avp_header('Accounting-Output-Packets') ->
    diameter_rfc4005_nasreq:avp_header('Accounting-Output-Packets');
avp_header('Acct-Authentic') ->
    diameter_rfc4005_nasreq:avp_header('Acct-Authentic');
avp_header('Acct-Delay-Time') ->
    diameter_rfc4005_nasreq:avp_header('Acct-Delay-Time');
avp_header('Acct-Link-Count') ->
    diameter_rfc4005_nasreq:avp_header('Acct-Link-Count');
avp_header('Acct-Session-Time') ->
    diameter_rfc4005_nasreq:avp_header('Acct-Session-Time');
avp_header('Acct-Tunnel-Connection') ->
    diameter_rfc4005_nasreq:avp_header('Acct-Tunnel-Connection');
avp_header('Acct-Tunnel-Packets-Lost') ->
    diameter_rfc4005_nasreq:avp_header('Acct-Tunnel-Packets-Lost');
avp_header('CHAP-Algorithm') ->
    diameter_rfc4005_nasreq:avp_header('CHAP-Algorithm');
avp_header('CHAP-Auth') ->
    diameter_rfc4005_nasreq:avp_header('CHAP-Auth');
avp_header('CHAP-Challenge') ->
    diameter_rfc4005_nasreq:avp_header('CHAP-Challenge');
avp_header('CHAP-Ident') ->
    diameter_rfc4005_nasreq:avp_header('CHAP-Ident');
avp_header('CHAP-Response') ->
    diameter_rfc4005_nasreq:avp_header('CHAP-Response');
avp_header('Callback-Id') ->
    diameter_rfc4005_nasreq:avp_header('Callback-Id');
avp_header('Callback-Number') ->
    diameter_rfc4005_nasreq:avp_header('Callback-Number');
avp_header('Called-Station-Id') ->
    diameter_rfc4005_nasreq:avp_header('Called-Station-Id');
avp_header('Calling-Station-Id') ->
    diameter_rfc4005_nasreq:avp_header('Calling-Station-Id');
avp_header('Configuration-Token') ->
    diameter_rfc4005_nasreq:avp_header('Configuration-Token');
avp_header('Connect-Info') ->
    diameter_rfc4005_nasreq:avp_header('Connect-Info');
avp_header('Filter-Id') ->
    diameter_rfc4005_nasreq:avp_header('Filter-Id');
avp_header('Framed-AppleTalk-Link') ->
    diameter_rfc4005_nasreq:avp_header('Framed-AppleTalk-Link');
avp_header('Framed-AppleTalk-Network') ->
    diameter_rfc4005_nasreq:avp_header('Framed-AppleTalk-Network');
avp_header('Framed-AppleTalk-Zone') ->
    diameter_rfc4005_nasreq:avp_header('Framed-AppleTalk-Zone');
avp_header('Framed-Compression') ->
    diameter_rfc4005_nasreq:avp_header('Framed-Compression');
avp_header('Framed-IP-Address') ->
    diameter_rfc4005_nasreq:avp_header('Framed-IP-Address');
avp_header('Framed-IP-Netmask') ->
    diameter_rfc4005_nasreq:avp_header('Framed-IP-Netmask');
avp_header('Framed-IPX-Network') ->
    diameter_rfc4005_nasreq:avp_header('Framed-IPX-Network');
avp_header('Framed-IPv6-Pool') ->
    diameter_rfc4005_nasreq:avp_header('Framed-IPv6-Pool');
avp_header('Framed-IPv6-Prefix') ->
    diameter_rfc4005_nasreq:avp_header('Framed-IPv6-Prefix');
avp_header('Framed-IPv6-Route') ->
    diameter_rfc4005_nasreq:avp_header('Framed-IPv6-Route');
avp_header('Framed-Interface-Id') ->
    diameter_rfc4005_nasreq:avp_header('Framed-Interface-Id');
avp_header('Framed-MTU') ->
    diameter_rfc4005_nasreq:avp_header('Framed-MTU');
avp_header('Framed-Pool') ->
    diameter_rfc4005_nasreq:avp_header('Framed-Pool');
avp_header('Framed-Protocol') ->
    diameter_rfc4005_nasreq:avp_header('Framed-Protocol');
avp_header('Framed-Route') ->
    diameter_rfc4005_nasreq:avp_header('Framed-Route');
avp_header('Framed-Routing') ->
    diameter_rfc4005_nasreq:avp_header('Framed-Routing');
avp_header('Idle-Timeout') ->
    diameter_rfc4005_nasreq:avp_header('Idle-Timeout');
avp_header('Login-IP-Host') ->
    diameter_rfc4005_nasreq:avp_header('Login-IP-Host');
avp_header('Login-IPv6-Host') ->
    diameter_rfc4005_nasreq:avp_header('Login-IPv6-Host');
avp_header('Login-LAT-Group') ->
    diameter_rfc4005_nasreq:avp_header('Login-LAT-Group');
avp_header('Login-LAT-Node') ->
    diameter_rfc4005_nasreq:avp_header('Login-LAT-Node');
avp_header('Login-LAT-Port') ->
    diameter_rfc4005_nasreq:avp_header('Login-LAT-Port');
avp_header('Login-LAT-Service') ->
    diameter_rfc4005_nasreq:avp_header('Login-LAT-Service');
avp_header('Login-Service') ->
    diameter_rfc4005_nasreq:avp_header('Login-Service');
avp_header('Login-TCP-Port') ->
    diameter_rfc4005_nasreq:avp_header('Login-TCP-Port');
avp_header('NAS-Filter-Rule') ->
    diameter_rfc4005_nasreq:avp_header('NAS-Filter-Rule');
avp_header('NAS-IP-Address') ->
    diameter_rfc4005_nasreq:avp_header('NAS-IP-Address');
avp_header('NAS-IPv6-Address') ->
    diameter_rfc4005_nasreq:avp_header('NAS-IPv6-Address');
avp_header('NAS-Identifier') ->
    diameter_rfc4005_nasreq:avp_header('NAS-Identifier');
avp_header('NAS-Port') ->
    diameter_rfc4005_nasreq:avp_header('NAS-Port');
avp_header('NAS-Port-Id') ->
    diameter_rfc4005_nasreq:avp_header('NAS-Port-Id');
avp_header('NAS-Port-Type') ->
    diameter_rfc4005_nasreq:avp_header('NAS-Port-Type');
avp_header('Origin-AAA-Protocol') ->
    diameter_rfc4005_nasreq:avp_header('Origin-AAA-Protocol');
avp_header('Originating-Line-Info') ->
    diameter_rfc4005_nasreq:avp_header('Originating-Line-Info');
avp_header('Password-Retry') ->
    diameter_rfc4005_nasreq:avp_header('Password-Retry');
avp_header('Port-Limit') ->
    diameter_rfc4005_nasreq:avp_header('Port-Limit');
avp_header('Prompt') ->
    diameter_rfc4005_nasreq:avp_header('Prompt');
avp_header('QoS-Filter-Rule') ->
    diameter_rfc4005_nasreq:avp_header('QoS-Filter-Rule');
avp_header('Reply-Message') ->
    diameter_rfc4005_nasreq:avp_header('Reply-Message');
avp_header('Service-Type') ->
    diameter_rfc4005_nasreq:avp_header('Service-Type');
avp_header('State') ->
    diameter_rfc4005_nasreq:avp_header('State');
avp_header('Tunnel-Assignment-Id') ->
    diameter_rfc4005_nasreq:avp_header('Tunnel-Assignment-Id');
avp_header('Tunnel-Client-Auth-Id') ->
    diameter_rfc4005_nasreq:avp_header('Tunnel-Client-Auth-Id');
avp_header('Tunnel-Client-Endpoint') ->
    diameter_rfc4005_nasreq:avp_header('Tunnel-Client-Endpoint');
avp_header('Tunnel-Medium-Type') ->
    diameter_rfc4005_nasreq:avp_header('Tunnel-Medium-Type');
avp_header('Tunnel-Password') ->
    diameter_rfc4005_nasreq:avp_header('Tunnel-Password');
avp_header('Tunnel-Preference') ->
    diameter_rfc4005_nasreq:avp_header('Tunnel-Preference');
avp_header('Tunnel-Private-Group-Id') ->
    diameter_rfc4005_nasreq:avp_header('Tunnel-Private-Group-Id');
avp_header('Tunnel-Server-Auth-Id') ->
    diameter_rfc4005_nasreq:avp_header('Tunnel-Server-Auth-Id');
avp_header('Tunnel-Server-Endpoint') ->
    diameter_rfc4005_nasreq:avp_header('Tunnel-Server-Endpoint');
avp_header('Tunnel-Type') ->
    diameter_rfc4005_nasreq:avp_header('Tunnel-Type');
avp_header('Tunneling') ->
    diameter_rfc4005_nasreq:avp_header('Tunneling');
avp_header('User-Password') ->
    diameter_rfc4005_nasreq:avp_header('User-Password');
avp_header('CC-Correlation-Id') ->
    diameter_rfc4006_cc:avp_header('CC-Correlation-Id');
avp_header('CC-Input-Octets') ->
    diameter_rfc4006_cc:avp_header('CC-Input-Octets');
avp_header('CC-Money') ->
    diameter_rfc4006_cc:avp_header('CC-Money');
avp_header('CC-Output-Octets') ->
    diameter_rfc4006_cc:avp_header('CC-Output-Octets');
avp_header('CC-Request-Number') ->
    diameter_rfc4006_cc:avp_header('CC-Request-Number');
avp_header('CC-Request-Type') ->
    diameter_rfc4006_cc:avp_header('CC-Request-Type');
avp_header('CC-Service-Specific-Units') ->
    diameter_rfc4006_cc:avp_header('CC-Service-Specific-Units');
avp_header('CC-Session-Failover') ->
    diameter_rfc4006_cc:avp_header('CC-Session-Failover');
avp_header('CC-Sub-Session-Id') ->
    diameter_rfc4006_cc:avp_header('CC-Sub-Session-Id');
avp_header('CC-Time') ->
    diameter_rfc4006_cc:avp_header('CC-Time');
avp_header('CC-Total-Octets') ->
    diameter_rfc4006_cc:avp_header('CC-Total-Octets');
avp_header('CC-Unit-Type') ->
    diameter_rfc4006_cc:avp_header('CC-Unit-Type');
avp_header('Check-Balance-Result') ->
    diameter_rfc4006_cc:avp_header('Check-Balance-Result');
avp_header('Cost-Information') ->
    diameter_rfc4006_cc:avp_header('Cost-Information');
avp_header('Cost-Unit') ->
    diameter_rfc4006_cc:avp_header('Cost-Unit');
avp_header('Credit-Control') ->
    diameter_rfc4006_cc:avp_header('Credit-Control');
avp_header('Credit-Control-Failure-Handling') ->
    diameter_rfc4006_cc:avp_header('Credit-Control-Failure-Handling');
avp_header('Currency-Code') ->
    diameter_rfc4006_cc:avp_header('Currency-Code');
avp_header('Direct-Debiting-Failure-Handling') ->
    diameter_rfc4006_cc:avp_header('Direct-Debiting-Failure-Handling');
avp_header('Exponent') ->
    diameter_rfc4006_cc:avp_header('Exponent');
avp_header('Final-Unit-Action') ->
    diameter_rfc4006_cc:avp_header('Final-Unit-Action');
avp_header('Final-Unit-Indication') ->
    diameter_rfc4006_cc:avp_header('Final-Unit-Indication');
avp_header('G-S-U-Pool-Identifier') ->
    diameter_rfc4006_cc:avp_header('G-S-U-Pool-Identifier');
avp_header('G-S-U-Pool-Reference') ->
    diameter_rfc4006_cc:avp_header('G-S-U-Pool-Reference');
avp_header('Granted-Service-Unit') ->
    diameter_rfc4006_cc:avp_header('Granted-Service-Unit');
avp_header('Multiple-Services-Credit-Control') ->
    diameter_rfc4006_cc:avp_header('Multiple-Services-Credit-Control');
avp_header('Multiple-Services-Indicator') ->
    diameter_rfc4006_cc:avp_header('Multiple-Services-Indicator');
avp_header('Rating-Group') ->
    diameter_rfc4006_cc:avp_header('Rating-Group');
avp_header('Redirect-Address-Type') ->
    diameter_rfc4006_cc:avp_header('Redirect-Address-Type');
avp_header('Redirect-Server') ->
    diameter_rfc4006_cc:avp_header('Redirect-Server');
avp_header('Redirect-Server-Address') ->
    diameter_rfc4006_cc:avp_header('Redirect-Server-Address');
avp_header('Requested-Action') ->
    diameter_rfc4006_cc:avp_header('Requested-Action');
avp_header('Requested-Service-Unit') ->
    diameter_rfc4006_cc:avp_header('Requested-Service-Unit');
avp_header('Restriction-Filter-Rule') ->
    diameter_rfc4006_cc:avp_header('Restriction-Filter-Rule');
avp_header('Service-Context-Id') ->
    diameter_rfc4006_cc:avp_header('Service-Context-Id');
avp_header('Service-Identifier') ->
    diameter_rfc4006_cc:avp_header('Service-Identifier');
avp_header('Service-Parameter-Info') ->
    diameter_rfc4006_cc:avp_header('Service-Parameter-Info');
avp_header('Service-Parameter-Type') ->
    diameter_rfc4006_cc:avp_header('Service-Parameter-Type');
avp_header('Service-Parameter-Value') ->
    diameter_rfc4006_cc:avp_header('Service-Parameter-Value');
avp_header('Subscription-Id') ->
    diameter_rfc4006_cc:avp_header('Subscription-Id');
avp_header('Subscription-Id-Data') ->
    diameter_rfc4006_cc:avp_header('Subscription-Id-Data');
avp_header('Subscription-Id-Type') ->
    diameter_rfc4006_cc:avp_header('Subscription-Id-Type');
avp_header('Tariff-Change-Usage') ->
    diameter_rfc4006_cc:avp_header('Tariff-Change-Usage');
avp_header('Tariff-Time-Change') ->
    diameter_rfc4006_cc:avp_header('Tariff-Time-Change');
avp_header('Unit-Value') ->
    diameter_rfc4006_cc:avp_header('Unit-Value');
avp_header('Used-Service-Unit') ->
    diameter_rfc4006_cc:avp_header('Used-Service-Unit');
avp_header('User-Equipment-Info') ->
    diameter_rfc4006_cc:avp_header('User-Equipment-Info');
avp_header('User-Equipment-Info-Type') ->
    diameter_rfc4006_cc:avp_header('User-Equipment-Info-Type');
avp_header('User-Equipment-Info-Value') ->
    diameter_rfc4006_cc:avp_header('User-Equipment-Info-Value');
avp_header('Validity-Time') ->
    diameter_rfc4006_cc:avp_header('Validity-Time');
avp_header('Value-Digits') ->
    diameter_rfc4006_cc:avp_header('Value-Digits');
avp_header('3GPP-Allocate-IP-Type') ->
    diameter_3gpp_base:avp_header('3GPP-Allocate-IP-Type');
avp_header('3GPP-CAMEL-Charging-Info') ->
    diameter_3gpp_base:avp_header('3GPP-CAMEL-Charging-Info');
avp_header('3GPP-CG-Address') ->
    diameter_3gpp_base:avp_header('3GPP-CG-Address');
avp_header('3GPP-CG-IPv6-Address') ->
    diameter_3gpp_base:avp_header('3GPP-CG-IPv6-Address');
avp_header('3GPP-Charging-Characteristics') ->
    diameter_3gpp_base:avp_header('3GPP-Charging-Characteristics');
avp_header('3GPP-Charging-Id') ->
    diameter_3gpp_base:avp_header('3GPP-Charging-Id');
avp_header('3GPP-GGSN-Address') ->
    diameter_3gpp_base:avp_header('3GPP-GGSN-Address');
avp_header('3GPP-GGSN-IPv6-Address') ->
    diameter_3gpp_base:avp_header('3GPP-GGSN-IPv6-Address');
avp_header('3GPP-GGSN-MCC-MNC') ->
    diameter_3gpp_base:avp_header('3GPP-GGSN-MCC-MNC');
avp_header('3GPP-GPRS-Negotiated-QoS-Profile') ->
    diameter_3gpp_base:avp_header('3GPP-GPRS-Negotiated-QoS-Profile');
avp_header('3GPP-IMEISV') ->
    diameter_3gpp_base:avp_header('3GPP-IMEISV');
avp_header('3GPP-IMSI') ->
    diameter_3gpp_base:avp_header('3GPP-IMSI');
avp_header('3GPP-IMSI-MCC-MNC') ->
    diameter_3gpp_base:avp_header('3GPP-IMSI-MCC-MNC');
avp_header('3GPP-IPv6-DNS-Servers') ->
    diameter_3gpp_base:avp_header('3GPP-IPv6-DNS-Servers');
avp_header('3GPP-MS-TimeZone') ->
    diameter_3gpp_base:avp_header('3GPP-MS-TimeZone');
avp_header('3GPP-NSAPI') ->
    diameter_3gpp_base:avp_header('3GPP-NSAPI');
avp_header('3GPP-Negotiated-DSCP') ->
    diameter_3gpp_base:avp_header('3GPP-Negotiated-DSCP');
avp_header('3GPP-PDP-Type') ->
    diameter_3gpp_base:avp_header('3GPP-PDP-Type');
avp_header('3GPP-Packet-Filter') ->
    diameter_3gpp_base:avp_header('3GPP-Packet-Filter');
avp_header('3GPP-RAT-Type') ->
    diameter_3gpp_base:avp_header('3GPP-RAT-Type');
avp_header('3GPP-SGSN-Address') ->
    diameter_3gpp_base:avp_header('3GPP-SGSN-Address');
avp_header('3GPP-SGSN-IPv6-Address') ->
    diameter_3gpp_base:avp_header('3GPP-SGSN-IPv6-Address');
avp_header('3GPP-SGSN-MCC-MNC') ->
    diameter_3gpp_base:avp_header('3GPP-SGSN-MCC-MNC');
avp_header('3GPP-Selection-Mode') ->
    diameter_3gpp_base:avp_header('3GPP-Selection-Mode');
avp_header('3GPP-Session-Stop-Indicator') ->
    diameter_3gpp_base:avp_header('3GPP-Session-Stop-Indicator');
avp_header('3GPP-User-Location-Info') ->
    diameter_3gpp_base:avp_header('3GPP-User-Location-Info');
avp_header('3GPP-User-Location-Info-Time') ->
    diameter_3gpp_base:avp_header('3GPP-User-Location-Info-Time');
avp_header('TWAN-Identifier') ->
    diameter_3gpp_base:avp_header('TWAN-Identifier');
avp_header('TP-NAT-IP-Address') ->
    diameter_travelping:avp_header('TP-NAT-IP-Address');
avp_header('TP-NAT-Pool-Id') ->
    diameter_travelping:avp_header('TP-NAT-Pool-Id');
avp_header('TP-NAT-Port-End') ->
    diameter_travelping:avp_header('TP-NAT-Port-End');
avp_header('TP-NAT-Port-Start') ->
    diameter_travelping:avp_header('TP-NAT-Port-Start');
avp_header('TP-Previous-PS-Information') ->
    diameter_travelping:avp_header('TP-Previous-PS-Information');
avp_header(_) -> erlang:error(badarg).

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
avp(T, Data, 'Termination-Cause', _) ->
    enumerated_avp(T, 'Termination-Cause', Data);
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
avp(T, Data, 'ARAP-Challenge-Response', Opts) ->
    avp(T,
        Data,
        'ARAP-Challenge-Response',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'ARAP-Features', Opts) ->
    avp(T,
        Data,
        'ARAP-Features',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'ARAP-Password', Opts) ->
    avp(T,
        Data,
        'ARAP-Password',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'ARAP-Security', Opts) ->
    avp(T,
        Data,
        'ARAP-Security',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'ARAP-Security-Data', Opts) ->
    avp(T,
        Data,
        'ARAP-Security-Data',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'ARAP-Zone-Access', Opts) ->
    avp(T,
        Data,
        'ARAP-Zone-Access',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Accounting-Auth-Method', Opts) ->
    avp(T,
        Data,
        'Accounting-Auth-Method',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Accounting-Input-Octets', Opts) ->
    avp(T,
        Data,
        'Accounting-Input-Octets',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Accounting-Input-Packets', Opts) ->
    avp(T,
        Data,
        'Accounting-Input-Packets',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Accounting-Output-Octets', Opts) ->
    avp(T,
        Data,
        'Accounting-Output-Octets',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Accounting-Output-Packets', Opts) ->
    avp(T,
        Data,
        'Accounting-Output-Packets',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Acct-Authentic', Opts) ->
    avp(T,
        Data,
        'Acct-Authentic',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Acct-Delay-Time', Opts) ->
    avp(T,
        Data,
        'Acct-Delay-Time',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Acct-Link-Count', Opts) ->
    avp(T,
        Data,
        'Acct-Link-Count',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Acct-Session-Time', Opts) ->
    avp(T,
        Data,
        'Acct-Session-Time',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Acct-Tunnel-Connection', Opts) ->
    avp(T,
        Data,
        'Acct-Tunnel-Connection',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Acct-Tunnel-Packets-Lost', Opts) ->
    avp(T,
        Data,
        'Acct-Tunnel-Packets-Lost',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'CHAP-Algorithm', Opts) ->
    avp(T,
        Data,
        'CHAP-Algorithm',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'CHAP-Auth', Opts) ->
    grouped_avp(T, 'CHAP-Auth', Data, Opts);
avp(T, Data, 'CHAP-Challenge', Opts) ->
    avp(T,
        Data,
        'CHAP-Challenge',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'CHAP-Ident', Opts) ->
    avp(T,
        Data,
        'CHAP-Ident',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'CHAP-Response', Opts) ->
    avp(T,
        Data,
        'CHAP-Response',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Callback-Id', Opts) ->
    avp(T,
        Data,
        'Callback-Id',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Callback-Number', Opts) ->
    avp(T,
        Data,
        'Callback-Number',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Called-Station-Id', Opts) ->
    avp(T,
        Data,
        'Called-Station-Id',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Calling-Station-Id', Opts) ->
    avp(T,
        Data,
        'Calling-Station-Id',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Configuration-Token', Opts) ->
    avp(T,
        Data,
        'Configuration-Token',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Connect-Info', Opts) ->
    avp(T,
        Data,
        'Connect-Info',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Filter-Id', Opts) ->
    avp(T,
        Data,
        'Filter-Id',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-AppleTalk-Link', Opts) ->
    avp(T,
        Data,
        'Framed-AppleTalk-Link',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-AppleTalk-Network', Opts) ->
    avp(T,
        Data,
        'Framed-AppleTalk-Network',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-AppleTalk-Zone', Opts) ->
    avp(T,
        Data,
        'Framed-AppleTalk-Zone',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-Compression', Opts) ->
    avp(T,
        Data,
        'Framed-Compression',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-IP-Address', Opts) ->
    avp(T,
        Data,
        'Framed-IP-Address',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-IP-Netmask', Opts) ->
    avp(T,
        Data,
        'Framed-IP-Netmask',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-IPX-Network', Opts) ->
    avp(T,
        Data,
        'Framed-IPX-Network',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-IPv6-Pool', Opts) ->
    avp(T,
        Data,
        'Framed-IPv6-Pool',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-IPv6-Prefix', Opts) ->
    avp(T,
        Data,
        'Framed-IPv6-Prefix',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-IPv6-Route', Opts) ->
    avp(T,
        Data,
        'Framed-IPv6-Route',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-Interface-Id', Opts) ->
    avp(T,
        Data,
        'Framed-Interface-Id',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-MTU', Opts) ->
    avp(T,
        Data,
        'Framed-MTU',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-Pool', Opts) ->
    avp(T,
        Data,
        'Framed-Pool',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-Protocol', _) ->
    enumerated_avp(T, 'Framed-Protocol', Data);
avp(T, Data, 'Framed-Route', Opts) ->
    avp(T,
        Data,
        'Framed-Route',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Framed-Routing', Opts) ->
    avp(T,
        Data,
        'Framed-Routing',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Idle-Timeout', Opts) ->
    avp(T,
        Data,
        'Idle-Timeout',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Login-IP-Host', Opts) ->
    avp(T,
        Data,
        'Login-IP-Host',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Login-IPv6-Host', Opts) ->
    avp(T,
        Data,
        'Login-IPv6-Host',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Login-LAT-Group', Opts) ->
    avp(T,
        Data,
        'Login-LAT-Group',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Login-LAT-Node', Opts) ->
    avp(T,
        Data,
        'Login-LAT-Node',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Login-LAT-Port', Opts) ->
    avp(T,
        Data,
        'Login-LAT-Port',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Login-LAT-Service', Opts) ->
    avp(T,
        Data,
        'Login-LAT-Service',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Login-Service', Opts) ->
    avp(T,
        Data,
        'Login-Service',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Login-TCP-Port', Opts) ->
    avp(T,
        Data,
        'Login-TCP-Port',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'NAS-Filter-Rule', Opts) ->
    avp(T,
        Data,
        'NAS-Filter-Rule',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'NAS-IP-Address', Opts) ->
    avp(T,
        Data,
        'NAS-IP-Address',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'NAS-IPv6-Address', Opts) ->
    avp(T,
        Data,
        'NAS-IPv6-Address',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'NAS-Identifier', Opts) ->
    avp(T,
        Data,
        'NAS-Identifier',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'NAS-Port', Opts) ->
    avp(T, Data, 'NAS-Port', Opts, diameter_rfc4005_nasreq);
avp(T, Data, 'NAS-Port-Id', Opts) ->
    avp(T,
        Data,
        'NAS-Port-Id',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'NAS-Port-Type', Opts) ->
    avp(T,
        Data,
        'NAS-Port-Type',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Origin-AAA-Protocol', Opts) ->
    avp(T,
        Data,
        'Origin-AAA-Protocol',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Originating-Line-Info', Opts) ->
    avp(T,
        Data,
        'Originating-Line-Info',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Password-Retry', Opts) ->
    avp(T,
        Data,
        'Password-Retry',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Port-Limit', Opts) ->
    avp(T,
        Data,
        'Port-Limit',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Prompt', Opts) ->
    avp(T, Data, 'Prompt', Opts, diameter_rfc4005_nasreq);
avp(T, Data, 'QoS-Filter-Rule', Opts) ->
    avp(T,
        Data,
        'QoS-Filter-Rule',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Reply-Message', Opts) ->
    avp(T,
        Data,
        'Reply-Message',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Service-Type', Opts) ->
    avp(T,
        Data,
        'Service-Type',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'State', Opts) ->
    avp(T, Data, 'State', Opts, diameter_rfc4005_nasreq);
avp(T, Data, 'Tunnel-Assignment-Id', Opts) ->
    avp(T,
        Data,
        'Tunnel-Assignment-Id',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Tunnel-Client-Auth-Id', Opts) ->
    avp(T,
        Data,
        'Tunnel-Client-Auth-Id',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Tunnel-Client-Endpoint', Opts) ->
    avp(T,
        Data,
        'Tunnel-Client-Endpoint',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Tunnel-Medium-Type', Opts) ->
    avp(T,
        Data,
        'Tunnel-Medium-Type',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Tunnel-Password', Opts) ->
    avp(T,
        Data,
        'Tunnel-Password',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Tunnel-Preference', Opts) ->
    avp(T,
        Data,
        'Tunnel-Preference',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Tunnel-Private-Group-Id', Opts) ->
    avp(T,
        Data,
        'Tunnel-Private-Group-Id',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Tunnel-Server-Auth-Id', Opts) ->
    avp(T,
        Data,
        'Tunnel-Server-Auth-Id',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Tunnel-Server-Endpoint', Opts) ->
    avp(T,
        Data,
        'Tunnel-Server-Endpoint',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Tunnel-Type', Opts) ->
    avp(T,
        Data,
        'Tunnel-Type',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'Tunneling', Opts) ->
    grouped_avp(T, 'Tunneling', Data, Opts);
avp(T, Data, 'User-Password', Opts) ->
    avp(T,
        Data,
        'User-Password',
        Opts,
        diameter_rfc4005_nasreq);
avp(T, Data, 'CC-Correlation-Id', Opts) ->
    avp(T,
        Data,
        'CC-Correlation-Id',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'CC-Input-Octets', Opts) ->
    avp(T,
        Data,
        'CC-Input-Octets',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'CC-Money', Opts) ->
    grouped_avp(T, 'CC-Money', Data, Opts);
avp(T, Data, 'CC-Output-Octets', Opts) ->
    avp(T,
        Data,
        'CC-Output-Octets',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'CC-Request-Number', Opts) ->
    avp(T,
        Data,
        'CC-Request-Number',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'CC-Request-Type', Opts) ->
    avp(T,
        Data,
        'CC-Request-Type',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'CC-Service-Specific-Units', Opts) ->
    avp(T,
        Data,
        'CC-Service-Specific-Units',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'CC-Session-Failover', Opts) ->
    avp(T,
        Data,
        'CC-Session-Failover',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'CC-Sub-Session-Id', Opts) ->
    avp(T,
        Data,
        'CC-Sub-Session-Id',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'CC-Time', Opts) ->
    avp(T, Data, 'CC-Time', Opts, diameter_rfc4006_cc);
avp(T, Data, 'CC-Total-Octets', Opts) ->
    avp(T,
        Data,
        'CC-Total-Octets',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'CC-Unit-Type', Opts) ->
    avp(T, Data, 'CC-Unit-Type', Opts, diameter_rfc4006_cc);
avp(T, Data, 'Check-Balance-Result', Opts) ->
    avp(T,
        Data,
        'Check-Balance-Result',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Cost-Information', Opts) ->
    grouped_avp(T, 'Cost-Information', Data, Opts);
avp(T, Data, 'Cost-Unit', Opts) ->
    avp(T, Data, 'Cost-Unit', Opts, diameter_rfc4006_cc);
avp(T, Data, 'Credit-Control', Opts) ->
    avp(T,
        Data,
        'Credit-Control',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Credit-Control-Failure-Handling', Opts) ->
    avp(T,
        Data,
        'Credit-Control-Failure-Handling',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Currency-Code', Opts) ->
    avp(T,
        Data,
        'Currency-Code',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Direct-Debiting-Failure-Handling',
    Opts) ->
    avp(T,
        Data,
        'Direct-Debiting-Failure-Handling',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Exponent', Opts) ->
    avp(T, Data, 'Exponent', Opts, diameter_rfc4006_cc);
avp(T, Data, 'Final-Unit-Action', Opts) ->
    avp(T,
        Data,
        'Final-Unit-Action',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Final-Unit-Indication', Opts) ->
    grouped_avp(T, 'Final-Unit-Indication', Data, Opts);
avp(T, Data, 'G-S-U-Pool-Identifier', Opts) ->
    avp(T,
        Data,
        'G-S-U-Pool-Identifier',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'G-S-U-Pool-Reference', Opts) ->
    grouped_avp(T, 'G-S-U-Pool-Reference', Data, Opts);
avp(T, Data, 'Granted-Service-Unit', Opts) ->
    grouped_avp(T, 'Granted-Service-Unit', Data, Opts);
avp(T, Data, 'Multiple-Services-Credit-Control',
    Opts) ->
    grouped_avp(T,
                'Multiple-Services-Credit-Control',
                Data,
                Opts);
avp(T, Data, 'Multiple-Services-Indicator', Opts) ->
    avp(T,
        Data,
        'Multiple-Services-Indicator',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Rating-Group', Opts) ->
    avp(T, Data, 'Rating-Group', Opts, diameter_rfc4006_cc);
avp(T, Data, 'Redirect-Address-Type', Opts) ->
    avp(T,
        Data,
        'Redirect-Address-Type',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Redirect-Server', Opts) ->
    grouped_avp(T, 'Redirect-Server', Data, Opts);
avp(T, Data, 'Redirect-Server-Address', Opts) ->
    avp(T,
        Data,
        'Redirect-Server-Address',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Requested-Action', Opts) ->
    avp(T,
        Data,
        'Requested-Action',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Requested-Service-Unit', Opts) ->
    grouped_avp(T, 'Requested-Service-Unit', Data, Opts);
avp(T, Data, 'Restriction-Filter-Rule', Opts) ->
    avp(T,
        Data,
        'Restriction-Filter-Rule',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Service-Context-Id', Opts) ->
    avp(T,
        Data,
        'Service-Context-Id',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Service-Identifier', Opts) ->
    avp(T,
        Data,
        'Service-Identifier',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Service-Parameter-Info', Opts) ->
    grouped_avp(T, 'Service-Parameter-Info', Data, Opts);
avp(T, Data, 'Service-Parameter-Type', Opts) ->
    avp(T,
        Data,
        'Service-Parameter-Type',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Service-Parameter-Value', Opts) ->
    avp(T,
        Data,
        'Service-Parameter-Value',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Subscription-Id', Opts) ->
    grouped_avp(T, 'Subscription-Id', Data, Opts);
avp(T, Data, 'Subscription-Id-Data', Opts) ->
    avp(T,
        Data,
        'Subscription-Id-Data',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Subscription-Id-Type', Opts) ->
    avp(T,
        Data,
        'Subscription-Id-Type',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Tariff-Change-Usage', Opts) ->
    avp(T,
        Data,
        'Tariff-Change-Usage',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Tariff-Time-Change', Opts) ->
    avp(T,
        Data,
        'Tariff-Time-Change',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Unit-Value', Opts) ->
    grouped_avp(T, 'Unit-Value', Data, Opts);
avp(T, Data, 'Used-Service-Unit', Opts) ->
    grouped_avp(T, 'Used-Service-Unit', Data, Opts);
avp(T, Data, 'User-Equipment-Info', Opts) ->
    grouped_avp(T, 'User-Equipment-Info', Data, Opts);
avp(T, Data, 'User-Equipment-Info-Type', Opts) ->
    avp(T,
        Data,
        'User-Equipment-Info-Type',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'User-Equipment-Info-Value', Opts) ->
    avp(T,
        Data,
        'User-Equipment-Info-Value',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Validity-Time', Opts) ->
    avp(T,
        Data,
        'Validity-Time',
        Opts,
        diameter_rfc4006_cc);
avp(T, Data, 'Value-Digits', Opts) ->
    avp(T, Data, 'Value-Digits', Opts, diameter_rfc4006_cc);
avp(T, Data, '3GPP-Allocate-IP-Type', Opts) ->
    avp(T,
        Data,
        '3GPP-Allocate-IP-Type',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-CAMEL-Charging-Info', Opts) ->
    avp(T,
        Data,
        '3GPP-CAMEL-Charging-Info',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-CG-Address', Opts) ->
    avp(T,
        Data,
        '3GPP-CG-Address',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-CG-IPv6-Address', Opts) ->
    avp(T,
        Data,
        '3GPP-CG-IPv6-Address',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-Charging-Characteristics', Opts) ->
    avp(T,
        Data,
        '3GPP-Charging-Characteristics',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-Charging-Id', Opts) ->
    avp(T,
        Data,
        '3GPP-Charging-Id',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-GGSN-Address', Opts) ->
    avp(T,
        Data,
        '3GPP-GGSN-Address',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-GGSN-IPv6-Address', Opts) ->
    avp(T,
        Data,
        '3GPP-GGSN-IPv6-Address',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-GGSN-MCC-MNC', Opts) ->
    avp(T,
        Data,
        '3GPP-GGSN-MCC-MNC',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-GPRS-Negotiated-QoS-Profile',
    Opts) ->
    avp(T,
        Data,
        '3GPP-GPRS-Negotiated-QoS-Profile',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-IMEISV', Opts) ->
    avp(T, Data, '3GPP-IMEISV', Opts, diameter_3gpp_base);
avp(T, Data, '3GPP-IMSI', Opts) ->
    avp(T, Data, '3GPP-IMSI', Opts, diameter_3gpp_base);
avp(T, Data, '3GPP-IMSI-MCC-MNC', Opts) ->
    avp(T,
        Data,
        '3GPP-IMSI-MCC-MNC',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-IPv6-DNS-Servers', Opts) ->
    avp(T,
        Data,
        '3GPP-IPv6-DNS-Servers',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-MS-TimeZone', Opts) ->
    avp(T,
        Data,
        '3GPP-MS-TimeZone',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-NSAPI', Opts) ->
    avp(T, Data, '3GPP-NSAPI', Opts, diameter_3gpp_base);
avp(T, Data, '3GPP-Negotiated-DSCP', Opts) ->
    avp(T,
        Data,
        '3GPP-Negotiated-DSCP',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-PDP-Type', Opts) ->
    avp(T, Data, '3GPP-PDP-Type', Opts, diameter_3gpp_base);
avp(T, Data, '3GPP-Packet-Filter', Opts) ->
    avp(T,
        Data,
        '3GPP-Packet-Filter',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-RAT-Type', Opts) ->
    avp(T, Data, '3GPP-RAT-Type', Opts, diameter_3gpp_base);
avp(T, Data, '3GPP-SGSN-Address', Opts) ->
    avp(T,
        Data,
        '3GPP-SGSN-Address',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-SGSN-IPv6-Address', Opts) ->
    avp(T,
        Data,
        '3GPP-SGSN-IPv6-Address',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-SGSN-MCC-MNC', Opts) ->
    avp(T,
        Data,
        '3GPP-SGSN-MCC-MNC',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-Selection-Mode', Opts) ->
    avp(T,
        Data,
        '3GPP-Selection-Mode',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-Session-Stop-Indicator', Opts) ->
    avp(T,
        Data,
        '3GPP-Session-Stop-Indicator',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-User-Location-Info', Opts) ->
    avp(T,
        Data,
        '3GPP-User-Location-Info',
        Opts,
        diameter_3gpp_base);
avp(T, Data, '3GPP-User-Location-Info-Time', Opts) ->
    avp(T,
        Data,
        '3GPP-User-Location-Info-Time',
        Opts,
        diameter_3gpp_base);
avp(T, Data, 'TWAN-Identifier', Opts) ->
    avp(T,
        Data,
        'TWAN-Identifier',
        Opts,
        diameter_3gpp_base);
avp(T, Data, 'TP-NAT-IP-Address', Opts) ->
    avp(T,
        Data,
        'TP-NAT-IP-Address',
        Opts,
        diameter_travelping);
avp(T, Data, 'TP-NAT-Pool-Id', Opts) ->
    avp(T,
        Data,
        'TP-NAT-Pool-Id',
        Opts,
        diameter_travelping);
avp(T, Data, 'TP-NAT-Port-End', Opts) ->
    avp(T,
        Data,
        'TP-NAT-Port-End',
        Opts,
        diameter_travelping);
avp(T, Data, 'TP-NAT-Port-Start', Opts) ->
    avp(T,
        Data,
        'TP-NAT-Port-Start',
        Opts,
        diameter_travelping);
avp(T, Data, 'TP-Previous-PS-Information', Opts) ->
    grouped_avp(T,
                'TP-Previous-PS-Information',
                Data,
                Opts);
avp(_, _, _, _) -> erlang:error(badarg).

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
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 11>>) ->
    11;
enumerated_avp(encode, 'Termination-Cause', 11) ->
    <<0, 0, 0, 11>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 12>>) ->
    12;
enumerated_avp(encode, 'Termination-Cause', 12) ->
    <<0, 0, 0, 12>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 13>>) ->
    13;
enumerated_avp(encode, 'Termination-Cause', 13) ->
    <<0, 0, 0, 13>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 14>>) ->
    14;
enumerated_avp(encode, 'Termination-Cause', 14) ->
    <<0, 0, 0, 14>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 15>>) ->
    15;
enumerated_avp(encode, 'Termination-Cause', 15) ->
    <<0, 0, 0, 15>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 16>>) ->
    16;
enumerated_avp(encode, 'Termination-Cause', 16) ->
    <<0, 0, 0, 16>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 17>>) ->
    17;
enumerated_avp(encode, 'Termination-Cause', 17) ->
    <<0, 0, 0, 17>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 18>>) ->
    18;
enumerated_avp(encode, 'Termination-Cause', 18) ->
    <<0, 0, 0, 18>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 19>>) ->
    19;
enumerated_avp(encode, 'Termination-Cause', 19) ->
    <<0, 0, 0, 19>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 20>>) ->
    20;
enumerated_avp(encode, 'Termination-Cause', 20) ->
    <<0, 0, 0, 20>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 21>>) ->
    21;
enumerated_avp(encode, 'Termination-Cause', 21) ->
    <<0, 0, 0, 21>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 22>>) ->
    22;
enumerated_avp(encode, 'Termination-Cause', 22) ->
    <<0, 0, 0, 22>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 23>>) ->
    23;
enumerated_avp(encode, 'Termination-Cause', 23) ->
    <<0, 0, 0, 23>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 24>>) ->
    24;
enumerated_avp(encode, 'Termination-Cause', 24) ->
    <<0, 0, 0, 24>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 25>>) ->
    25;
enumerated_avp(encode, 'Termination-Cause', 25) ->
    <<0, 0, 0, 25>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 26>>) ->
    26;
enumerated_avp(encode, 'Termination-Cause', 26) ->
    <<0, 0, 0, 26>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 27>>) ->
    27;
enumerated_avp(encode, 'Termination-Cause', 27) ->
    <<0, 0, 0, 27>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 28>>) ->
    28;
enumerated_avp(encode, 'Termination-Cause', 28) ->
    <<0, 0, 0, 28>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 29>>) ->
    29;
enumerated_avp(encode, 'Termination-Cause', 29) ->
    <<0, 0, 0, 29>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 30>>) ->
    30;
enumerated_avp(encode, 'Termination-Cause', 30) ->
    <<0, 0, 0, 30>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 31>>) ->
    31;
enumerated_avp(encode, 'Termination-Cause', 31) ->
    <<0, 0, 0, 31>>;
enumerated_avp(decode, 'Termination-Cause',
               <<0, 0, 0, 32>>) ->
    32;
enumerated_avp(encode, 'Termination-Cause', 32) ->
    <<0, 0, 0, 32>>;
enumerated_avp(T, 'Termination-Cause', Data) ->
    diameter_gen_base_rfc6733:enumerated_avp(T,
                                             'Termination-Cause',
                                             Data);
enumerated_avp(T, 'Framed-Protocol', Data) ->
    diameter_rfc4005_nasreq:enumerated_avp(T,
                                           'Framed-Protocol',
                                           Data);
enumerated_avp(_, _, _) -> erlang:error(badarg).

empty_value('Proxy-Info', Opts) ->
    empty_group('Proxy-Info', Opts);
empty_value('Failed-AVP', Opts) ->
    empty_group('Failed-AVP', Opts);
empty_value('Experimental-Result', Opts) ->
    empty_group('Experimental-Result', Opts);
empty_value('Vendor-Specific-Application-Id', Opts) ->
    empty_group('Vendor-Specific-Application-Id', Opts);
empty_value('CHAP-Auth', Opts) ->
    empty_group('CHAP-Auth', Opts);
empty_value('Tunneling', Opts) ->
    empty_group('Tunneling', Opts);
empty_value('Cost-Information', Opts) ->
    empty_group('Cost-Information', Opts);
empty_value('Unit-Value', Opts) ->
    empty_group('Unit-Value', Opts);
empty_value('Multiple-Services-Credit-Control', Opts) ->
    empty_group('Multiple-Services-Credit-Control', Opts);
empty_value('Granted-Service-Unit', Opts) ->
    empty_group('Granted-Service-Unit', Opts);
empty_value('Requested-Service-Unit', Opts) ->
    empty_group('Requested-Service-Unit', Opts);
empty_value('Used-Service-Unit', Opts) ->
    empty_group('Used-Service-Unit', Opts);
empty_value('CC-Money', Opts) ->
    empty_group('CC-Money', Opts);
empty_value('G-S-U-Pool-Reference', Opts) ->
    empty_group('G-S-U-Pool-Reference', Opts);
empty_value('Final-Unit-Indication', Opts) ->
    empty_group('Final-Unit-Indication', Opts);
empty_value('Redirect-Server', Opts) ->
    empty_group('Redirect-Server', Opts);
empty_value('Service-Parameter-Info', Opts) ->
    empty_group('Service-Parameter-Info', Opts);
empty_value('Subscription-Id', Opts) ->
    empty_group('Subscription-Id', Opts);
empty_value('User-Equipment-Info', Opts) ->
    empty_group('User-Equipment-Info', Opts);
empty_value('TP-Previous-PS-Information', Opts) ->
    empty_group('TP-Previous-PS-Information', Opts);
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
empty_value('NAS-Port-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Prompt', _) -> <<0, 0, 0, 0>>;
empty_value('CHAP-Algorithm', _) -> <<0, 0, 0, 0>>;
empty_value('Service-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Framed-Protocol', _) -> <<0, 0, 0, 0>>;
empty_value('Framed-Routing', _) -> <<0, 0, 0, 0>>;
empty_value('Framed-Compression', _) -> <<0, 0, 0, 0>>;
empty_value('ARAP-Zone-Access', _) -> <<0, 0, 0, 0>>;
empty_value('Login-Service', _) -> <<0, 0, 0, 0>>;
empty_value('Tunnel-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Tunnel-Medium-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Acct-Authentic', _) -> <<0, 0, 0, 0>>;
empty_value('Accounting-Auth-Method', _) ->
    <<0, 0, 0, 0>>;
empty_value('CC-Request-Type', _) -> <<0, 0, 0, 0>>;
empty_value('CC-Session-Failover', _) -> <<0, 0, 0, 0>>;
empty_value('Check-Balance-Result', _) ->
    <<0, 0, 0, 0>>;
empty_value('Credit-Control', _) -> <<0, 0, 0, 0>>;
empty_value('Credit-Control-Failure-Handling', _) ->
    <<0, 0, 0, 0>>;
empty_value('Direct-Debiting-Failure-Handling', _) ->
    <<0, 0, 0, 0>>;
empty_value('Tariff-Change-Usage', _) -> <<0, 0, 0, 0>>;
empty_value('CC-Unit-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Final-Unit-Action', _) -> <<0, 0, 0, 0>>;
empty_value('Redirect-Address-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('Multiple-Services-Indicator', _) ->
    <<0, 0, 0, 0>>;
empty_value('Requested-Action', _) -> <<0, 0, 0, 0>>;
empty_value('Subscription-Id-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('User-Equipment-Info-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('3GPP-PDP-Type', _) -> <<0, 0, 0, 0>>;
empty_value(Name, Opts) -> empty(Name, Opts).

dict() ->
    [1,
     {avp_types, []},
     {avp_vendor_id, []},
     {codecs, []},
     {command_codes, [{271, "ACR", "ACA"}]},
     {custom_types, []},
     {define, []},
     {enum,
      [{"Framed-Protocol",
        [{"PPP", 1},
         {"SLIP", 2},
         {"ARAP", 3},
         {"GANDALF", 4},
         {"XYLOGICS", 5},
         {"X75", 6},
         {"GPRS_PDP_CONTEXT", 7}]},
       {"Termination-Cause",
        [{"USER_REQUEST", 11},
         {"LOST_CARRIER", 12},
         {"LOST_SERVICE", 13},
         {"IDLE_TIMEOUT", 14},
         {"SESSION_TIMEOUT", 15},
         {"ADMIN_RESET", 16},
         {"ADMIN_REBOOT", 17},
         {"PORT_ERROR", 18},
         {"NAS_ERROR", 19},
         {"NAS_REQUEST", 20},
         {"NAS_REBOOT", 21},
         {"PORT_UNNEEDED", 22},
         {"PORT_PREEMPTED", 23},
         {"PORT_SUSPENDED", 24},
         {"SERVICE_UNAVAILABLE", 25},
         {"CALLBACK", 26},
         {"USER_ERROR", 27},
         {"HOST_REQUEST", 28},
         {"SUPPLICANT_RESTART", 29},
         {"REAUTHORIZATION_FAILURE", 30},
         {"PORT_REINIT", 31},
         {"PORT_DISABLED", 32}]}]},
     {grouped, []},
     {id, 3},
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
          "M"}]},
       {diameter_rfc4005_nasreq,
        [{"ARAP-Challenge-Response", 84, "OctetString", "M"},
         {"ARAP-Features", 71, "OctetString", "M"},
         {"ARAP-Password", 70, "OctetString", "M"},
         {"ARAP-Security", 73, "Unsigned32", "M"},
         {"ARAP-Security-Data", 74, "OctetString", "M"},
         {"ARAP-Zone-Access", 72, "Enumerated", "M"},
         {"Accounting-Auth-Method", 406, "Enumerated", "M"},
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
         {"CHAP-Algorithm", 403, "Enumerated", "M"},
         {"CHAP-Auth", 402, "Grouped", "M"},
         {"CHAP-Challenge", 60, "OctetString", "M"},
         {"CHAP-Ident", 404, "OctetString", "M"},
         {"CHAP-Response", 405, "OctetString", "M"},
         {"Callback-Id", 20, "UTF8String", "M"},
         {"Callback-Number", 19, "UTF8String", "M"},
         {"Called-Station-Id", 30, "UTF8String", "M"},
         {"Calling-Station-Id", 31, "UTF8String", "M"},
         {"Configuration-Token", 78, "OctetString", "M"},
         {"Connect-Info", 77, "UTF8String", "M"},
         {"Filter-Id", 11, "UTF8String", "M"},
         {"Framed-AppleTalk-Link", 37, "Unsigned32", "M"},
         {"Framed-AppleTalk-Network", 38, "Unsigned32", "M"},
         {"Framed-AppleTalk-Zone", 39, "OctetString", "M"},
         {"Framed-Compression", 13, "Enumerated", "M"},
         {"Framed-IP-Address", 8, "OctetString", "M"},
         {"Framed-IP-Netmask", 9, "OctetString", "M"},
         {"Framed-IPX-Network", 23, "UTF8String", "M"},
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
         {"Originating-Line-Info", 94, "OctetString", []},
         {"Password-Retry", 75, "Unsigned32", "M"},
         {"Port-Limit", 62, "Unsigned32", "M"},
         {"Prompt", 76, "Enumerated", "M"},
         {"QoS-Filter-Rule", 407, "QoSFilterRule", []},
         {"Reply-Message", 18, "UTF8String", "M"},
         {"Service-Type", 6, "Enumerated", "M"},
         {"State", 24, "OctetString", "M"},
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
         {"Tunneling", 401, "Grouped", "M"},
         {"User-Password", 2, "OctetString", "M"}]},
       {diameter_rfc4006_cc,
        [{"CC-Correlation-Id", 411, "OctetString", []},
         {"CC-Input-Octets", 412, "Unsigned64", "M"},
         {"CC-Money", 413, "Grouped", "M"},
         {"CC-Output-Octets", 414, "Unsigned64", "M"},
         {"CC-Request-Number", 415, "Unsigned32", "M"},
         {"CC-Request-Type", 416, "Enumerated", "M"},
         {"CC-Service-Specific-Units", 417, "Unsigned64", "M"},
         {"CC-Session-Failover", 418, "Enumerated", "M"},
         {"CC-Sub-Session-Id", 419, "Unsigned64", "M"},
         {"CC-Time", 420, "Unsigned32", "M"},
         {"CC-Total-Octets", 421, "Unsigned64", "M"},
         {"CC-Unit-Type", 454, "Enumerated", "M"},
         {"Check-Balance-Result", 422, "Enumerated", "M"},
         {"Cost-Information", 423, "Grouped", "M"},
         {"Cost-Unit", 424, "UTF8String", "M"},
         {"Credit-Control", 426, "Enumerated", "M"},
         {"Credit-Control-Failure-Handling",
          427,
          "Enumerated",
          "M"},
         {"Currency-Code", 425, "Unsigned32", "M"},
         {"Direct-Debiting-Failure-Handling",
          428,
          "Enumerated",
          "M"},
         {"Exponent", 429, "Integer32", "M"},
         {"Final-Unit-Action", 449, "Enumerated", "M"},
         {"Final-Unit-Indication", 430, "Grouped", "M"},
         {"G-S-U-Pool-Identifier", 453, "Unsigned32", "M"},
         {"G-S-U-Pool-Reference", 457, "Grouped", "M"},
         {"Granted-Service-Unit", 431, "Grouped", "M"},
         {"Multiple-Services-Credit-Control",
          456,
          "Grouped",
          "M"},
         {"Multiple-Services-Indicator", 455, "Enumerated", "M"},
         {"Rating-Group", 432, "Unsigned32", "M"},
         {"Redirect-Address-Type", 433, "Enumerated", "M"},
         {"Redirect-Server", 434, "Grouped", "M"},
         {"Redirect-Server-Address", 435, "UTF8String", "M"},
         {"Requested-Action", 436, "Enumerated", "M"},
         {"Requested-Service-Unit", 437, "Grouped", "M"},
         {"Restriction-Filter-Rule", 438, "IPFilterRule", "M"},
         {"Service-Context-Id", 461, "UTF8String", "M"},
         {"Service-Identifier", 439, "Unsigned32", "M"},
         {"Service-Parameter-Info", 440, "Grouped", []},
         {"Service-Parameter-Type", 441, "Unsigned32", []},
         {"Service-Parameter-Value", 442, "OctetString", []},
         {"Subscription-Id", 443, "Grouped", "M"},
         {"Subscription-Id-Data", 444, "UTF8String", "M"},
         {"Subscription-Id-Type", 450, "Enumerated", "M"},
         {"Tariff-Change-Usage", 452, "Enumerated", "M"},
         {"Tariff-Time-Change", 451, "Time", "M"},
         {"Unit-Value", 445, "Grouped", "M"},
         {"Used-Service-Unit", 446, "Grouped", "M"},
         {"User-Equipment-Info", 458, "Grouped", []},
         {"User-Equipment-Info-Type", 459, "Enumerated", []},
         {"User-Equipment-Info-Value", 460, "OctetString", []},
         {"Validity-Time", 448, "Unsigned32", "M"},
         {"Value-Digits", 447, "Integer64", "M"}]},
       {diameter_3gpp_base,
        [{"3GPP-Allocate-IP-Type", 27, "OctetString", "V"},
         {"3GPP-CAMEL-Charging-Info", 24, "OctetString", "V"},
         {"3GPP-CG-Address", 4, "OctetString", "V"},
         {"3GPP-CG-IPv6-Address", 14, "OctetString", "V"},
         {"3GPP-Charging-Characteristics",
          13,
          "UTF8String",
          "V"},
         {"3GPP-Charging-Id", 2, "Unsigned32", "V"},
         {"3GPP-GGSN-Address", 7, "OctetString", "V"},
         {"3GPP-GGSN-IPv6-Address", 16, "OctetString", "V"},
         {"3GPP-GGSN-MCC-MNC", 9, "UTF8String", "V"},
         {"3GPP-GPRS-Negotiated-QoS-Profile",
          5,
          "UTF8String",
          "V"},
         {"3GPP-IMEISV", 20, "OctetString", "V"},
         {"3GPP-IMSI", 1, "UTF8String", "V"},
         {"3GPP-IMSI-MCC-MNC", 8, "UTF8String", "V"},
         {"3GPP-IPv6-DNS-Servers", 17, "OctetString", "V"},
         {"3GPP-MS-TimeZone", 23, "OctetString", "V"},
         {"3GPP-NSAPI", 10, "OctetString", "V"},
         {"3GPP-Negotiated-DSCP", 26, "OctetString", "V"},
         {"3GPP-PDP-Type", 3, "Enumerated", "V"},
         {"3GPP-Packet-Filter", 25, "OctetString", "V"},
         {"3GPP-RAT-Type", 21, "OctetString", "V"},
         {"3GPP-SGSN-Address", 6, "OctetString", "V"},
         {"3GPP-SGSN-IPv6-Address", 15, "OctetString", "V"},
         {"3GPP-SGSN-MCC-MNC", 18, "UTF8String", "V"},
         {"3GPP-Selection-Mode", 12, "UTF8String", "V"},
         {"3GPP-Session-Stop-Indicator", 11, "OctetString", "V"},
         {"3GPP-User-Location-Info", 22, "OctetString", "V"},
         {"3GPP-User-Location-Info-Time", 30, "Unsigned32", "V"},
         {"TWAN-Identifier", 29, "OctetString", "V"}]},
       {diameter_travelping,
        [{"TP-NAT-IP-Address", 16, "OctetString", "V"},
         {"TP-NAT-Pool-Id", 27, "UTF8String", "V"},
         {"TP-NAT-Port-End", 29, "Unsigned32", "V"},
         {"TP-NAT-Port-Start", 28, "Unsigned32", "V"},
         {"TP-Previous-PS-Information", 64, "Grouped", "V"}]}]},
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
           {"GRANT_AND_LOSE", 3}]}]},
       {diameter_rfc4005_nasreq,
        [{"NAS-Port-Type",
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
           {"G3FAX", 10},
           {"SDSL", 11},
           {"ADSL-CAP", 12},
           {"ADSL-DMT", 13},
           {"IDSL", 14},
           {"ETHERNET", 15},
           {"XDSL", 16},
           {"CABLE", 17},
           {"WIRELESS_OTHER", 18},
           {"WIRELESS_802.11", 19},
           {"TOKEN-RING", 20},
           {"FDDI", 21},
           {"WIRELESS_CDMA2000", 22},
           {"WIRELESS_UMTS", 23},
           {"WIRELESS_1X-EV", 24},
           {"IAPP", 25}]},
         {"Prompt", [{"NO_ECHO", 0}, {"ECHO", 1}]},
         {"CHAP-Algorithm", [{"WITH_MD5", 5}]},
         {"Service-Type",
          [{"LOGIN", 1},
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
           {"IAPP-REGISTER", 15},
           {"IAPP-AP-CHECK", 16},
           {"AUTHORIZE_ONLY", 17}]},
         {"Framed-Protocol",
          [{"PPP", 1},
           {"SLIP", 2},
           {"ARAP", 3},
           {"GANDALF", 4},
           {"XYLOGICS", 5},
           {"X75", 6}]},
         {"Framed-Routing",
          [{"NONE", 0},
           {"SEND", 1},
           {"LISTEN", 2},
           {"SEND_AND_LISTEN", 3}]},
         {"Framed-Compression",
          [{"NONE", 0}, {"VJ", 1}, {"IPX", 2}, {"STAC-LZS", 3}]},
         {"ARAP-Zone-Access",
          [{"DEFAULT", 1},
           {"FILTER_INCLUSIVELY", 2},
           {"FILTER_EXCLUSIVELY", 4}]},
         {"Login-Service",
          [{"TELNET", 0},
           {"RLOGIN", 1},
           {"TCP_CLEAR", 2},
           {"PORTMASTER", 3},
           {"LAT", 4},
           {"X25-PAD", 5},
           {"X25-T3POS", 6},
           {"TCP_CLEAR_QUIET", 8}]},
         {"Tunnel-Type",
          [{"PPTP", 1},
           {"L2F", 2},
           {"L2TP", 3},
           {"ATMP", 4},
           {"VTP", 5},
           {"AH", 6},
           {"IP-IP", 7},
           {"MIN-IP-IP", 8},
           {"ESP", 9},
           {"GRE", 10},
           {"DVS", 11},
           {"IP-IN-IP", 12},
           {"VLAN", 13}]},
         {"Tunnel-Medium-Type",
          [{"IPV4", 1},
           {"IPV6", 2},
           {"NSAP", 3},
           {"HDLC", 4},
           {"BBN_1822", 5},
           {"802", 6},
           {"E163", 7},
           {"E164", 8},
           {"F69", 9},
           {"X121", 10},
           {"IPX", 11},
           {"APPLETALK", 12},
           {"DECNET_IV", 13},
           {"BANYAN_VINES", 14},
           {"E164_NSAP", 15}]},
         {"Acct-Authentic",
          [{"RADIUS", 1},
           {"LOCAL", 2},
           {"REMOTE", 3},
           {"DIAMETER", 4}]},
         {"Accounting-Auth-Method",
          [{"PAP", 1},
           {"CHAP", 2},
           {"MS-CHAP-1", 3},
           {"MS-CHAP-2", 4},
           {"EAP", 5},
           {"NONE", 7}]}]},
       {diameter_rfc4006_cc,
        [{"CC-Request-Type",
          [{"INITIAL_REQUEST", 1},
           {"UPDATE_REQUEST", 2},
           {"TERMINATION_REQUEST", 3},
           {"EVENT_REQUEST", 4}]},
         {"CC-Session-Failover",
          [{"NOT_SUPPORTED", 0}, {"SUPPORTED", 1}]},
         {"Check-Balance-Result",
          [{"ENOUGH_CREDIT", 0}, {"NO_CREDIT", 1}]},
         {"Credit-Control",
          [{"AUTHORIZATION", 0}, {"RE_AUTHORIZATION", 1}]},
         {"Credit-Control-Failure-Handling",
          [{"TERMINATE", 0},
           {"CONTINUE", 1},
           {"RETRY_AND_TERMINATE", 2}]},
         {"Direct-Debiting-Failure-Handling",
          [{"TERMINATE_OR_BUFFER", 0}, {"CONTINUE", 1}]},
         {"Tariff-Change-Usage",
          [{"UNIT_BEFORE_TARIFF_CHANGE", 0},
           {"UNIT_AFTER_TARIFF_CHANGE", 1},
           {"UNIT_INDETERMINATE", 2}]},
         {"CC-Unit-Type",
          [{"TIME", 0},
           {"MONEY", 1},
           {"TOTAL-OCTETS", 2},
           {"INPUT-OCTETS", 3},
           {"OUTPUT-OCTETS", 4},
           {"SERVICE-SPECIFIC-UNITS", 5}]},
         {"Final-Unit-Action",
          [{"TERMINATE", 0},
           {"REDIRECT", 1},
           {"RESTRICT_ACCESS", 2}]},
         {"Redirect-Address-Type",
          [{"IPV4", 0}, {"IPV6", 1}, {"URL", 2}, {"SIP_URI", 3}]},
         {"Multiple-Services-Indicator",
          [{"NOT_SUPPORTED", 0}, {"SUPPORTED", 1}]},
         {"Requested-Action",
          [{"DIRECT_DEBITING", 0},
           {"REFUND_ACCOUNT", 1},
           {"CHECK_BALANCE", 2},
           {"PRICE_ENQUIRY", 3}]},
         {"Subscription-Id-Type",
          [{"END_USER_E164", 0},
           {"END_USER_IMSI", 1},
           {"END_USER_SIP_URI", 2},
           {"END_USER_NAI", 3},
           {"END_USER_PRIVATE", 4}]},
         {"User-Equipment-Info-Type",
          [{"IMEISV", 0},
           {"MAC", 1},
           {"EUI64", 2},
           {"MODIFIED_EUI64", 3}]}]},
       {diameter_3gpp_base,
        [{"3GPP-PDP-Type",
          [{"IPv4", 0},
           {"PPP", 1},
           {"IPv6", 2},
           {"IPv4v6", 3},
           {"Non-IP", 4}]}]}]},
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
           ["Acct-Application-Id"]]}]},
       {diameter_rfc4005_nasreq,
        [{"CHAP-Auth",
          402,
          [],
          [{"CHAP-Algorithm"},
           {"CHAP-Ident"},
           ["CHAP-Response"],
           {'*', ["AVP"]}]},
         {"Tunneling",
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
       {diameter_rfc4006_cc,
        [{"Cost-Information",
          423,
          [],
          [{"Unit-Value"}, {"Currency-Code"}, ["Cost-Unit"]]},
         {"Unit-Value",
          445,
          [],
          [{"Value-Digits"}, ["Exponent"]]},
         {"Multiple-Services-Credit-Control",
          456,
          [],
          [["Granted-Service-Unit"],
           ["Requested-Service-Unit"],
           {'*', ["Used-Service-Unit"]},
           ["Tariff-Change-Usage"],
           {'*', ["Service-Identifier"]},
           ["Rating-Group"],
           {'*', ["G-S-U-Pool-Reference"]},
           ["Validity-Time"],
           ["Result-Code"],
           ["Final-Unit-Indication"],
           {'*', ["AVP"]}]},
         {"Granted-Service-Unit",
          431,
          [],
          [["Tariff-Time-Change"],
           ["CC-Time"],
           ["CC-Money"],
           ["CC-Total-Octets"],
           ["CC-Input-Octets"],
           ["CC-Output-Octets"],
           ["CC-Service-Specific-Units"],
           {'*', ["AVP"]}]},
         {"Requested-Service-Unit",
          437,
          [],
          [["CC-Time"],
           ["CC-Money"],
           ["CC-Total-Octets"],
           ["CC-Input-Octets"],
           ["CC-Output-Octets"],
           ["CC-Service-Specific-Units"],
           {'*', ["AVP"]}]},
         {"Used-Service-Unit",
          446,
          [],
          [["Tariff-Change-Usage"],
           ["CC-Time"],
           ["CC-Money"],
           ["CC-Total-Octets"],
           ["CC-Input-Octets"],
           ["CC-Output-Octets"],
           ["CC-Service-Specific-Units"],
           {'*', ["AVP"]}]},
         {"CC-Money",
          413,
          [],
          [{"Unit-Value"}, ["Currency-Code"]]},
         {"G-S-U-Pool-Reference",
          457,
          [],
          [{"G-S-U-Pool-Identifier"},
           {"CC-Unit-Type"},
           {"Unit-Value"}]},
         {"Final-Unit-Indication",
          430,
          [],
          [{"Final-Unit-Action"},
           {'*', ["Restriction-Filter-Rule"]},
           {'*', ["Filter-Id"]},
           ["Redirect-Server"]]},
         {"Redirect-Server",
          434,
          [],
          [{"Redirect-Address-Type"},
           {"Redirect-Server-Address"}]},
         {"Service-Parameter-Info",
          440,
          [],
          [{"Service-Parameter-Type"},
           {"Service-Parameter-Value"}]},
         {"Subscription-Id",
          443,
          [],
          [{"Subscription-Id-Type"}, {"Subscription-Id-Data"}]},
         {"User-Equipment-Info",
          458,
          [],
          [{"User-Equipment-Info-Type"},
           {"User-Equipment-Info-Value"}]}]},
       {diameter_travelping,
        [{"TP-Previous-PS-Information",
          64,
          [],
          [["QoS-Information"],
           {'*', ["SGSN-Address"]},
           ["3GPP-SGSN-MCC-MNC"],
           ["3GPP-MS-TimeZone"],
           ["3GPP-User-Location-Info"],
           ["3GPP-RAT-Type"],
           {'*', ["AVP"]}]}]}]},
     {inherits,
      [{"diameter_travelping", []},
       {"diameter_3gpp_base", []},
       {"diameter_rfc4006_cc", []},
       {"diameter_rfc4005_nasreq", []},
       {"diameter_gen_base_rfc6733", []}]},
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
         ["Acct-Application-Id"],
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
         ["3GPP-IMSI"],
         ["3GPP-Charging-Id"],
         ["3GPP-PDP-Type"],
         ["3GPP-CG-Address"],
         ["3GPP-GPRS-Negotiated-QoS-Profile"],
         ["3GPP-SGSN-Address"],
         ["3GPP-GGSN-Address"],
         ["3GPP-IMSI-MCC-MNC"],
         ["3GPP-GGSN-MCC-MNC"],
         ["3GPP-NSAPI"],
         ["3GPP-Selection-Mode"],
         ["3GPP-Charging-Characteristics"],
         ["3GPP-CG-IPv6-Address"],
         ["3GPP-SGSN-IPv6-Address"],
         ["3GPP-GGSN-IPv6-Address"],
         ["3GPP-SGSN-MCC-MNC"],
         ["3GPP-IMEISV"],
         ["3GPP-RAT-Type"],
         ["3GPP-User-Location-Info"],
         ["3GPP-MS-TimeZone"],
         ["3GPP-CAMEL-Charging-Info"],
         ["3GPP-Packet-Filter"],
         ["3GPP-Negotiated-DSCP"],
         ["TWAN-Identifier"],
         ["3GPP-User-Location-Info-Time"],
         ["TP-NAT-IP-Address"],
         ["TP-NAT-Pool-Id"],
         ["TP-NAT-Port-Start"],
         ["TP-NAT-Port-End"],
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
         ["Acct-Application-Id"],
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
         ["3GPP-IPv6-DNS-Servers"],
         {'*', ["AVP"]}]}]},
     {name, "diameter_3gpp_ts29_061_sgi_base_acc"},
     {prefix, "diameter_sgi_base_acc"},
     {vendor, {10415, "3GPP"}}].


