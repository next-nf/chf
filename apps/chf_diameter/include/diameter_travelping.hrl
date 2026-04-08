%% -------------------------------------------------------------------
%% This is a generated file.
%% -------------------------------------------------------------------

-hrl_name('diameter_travelping.hrl').


%%% -------------------------------------------------------
%%% Grouped AVP records:
%%% -------------------------------------------------------

-record('diameter_travelping_TP-Previous-PS-Information',
        {'QoS-Information' = [],
         'SGSN-Address' = [],
         '3GPP-SGSN-MCC-MNC' = [],
         '3GPP-MS-TimeZone' = [],
         '3GPP-User-Location-Info' = [],
         '3GPP-RAT-Type' = [],
         'AVP' = []}).


%%% -------------------------------------------------------
%%% Grouped AVP records from diameter_3gpp_ts29_212:
%%% -------------------------------------------------------

-record('diameter_travelping_Access-Network-Charging-Identifier-Gx',
        {'Access-Network-Charging-Identifier-Value',
         'Charging-Rule-Base-Name' = [],
         'Charging-Rule-Name' = [],
         'IP-CAN-Session-Charging-Scope' = [],
         'AVP' = []}).

-record('diameter_travelping_Allocation-Retention-Priority',
        {'Priority-Level',
         'Pre-emption-Capability' = [],
         'Pre-emption-Vulnerability' = []}).

-record('diameter_travelping_Application-Detection-Information',
        {'TDF-Application-Identifier',
         'TDF-Application-Instance-Identifier' = [],
         'Flow-Information' = [],
         'AVP' = []}).

-record('diameter_travelping_Charging-Rule-Definition',
        {'Charging-Rule-Name',
         'Service-Identifier' = [],
         'Rating-Group' = [],
         'Flow-Information' = [],
         'TDF-Application-Identifier' = [],
         'Flow-Status' = [],
         'QoS-Information' = [],
         'PS-to-CS-Session-Continuity' = [],
         'Reporting-Level' = [],
         'Online' = [],
         'Offline' = [],
         'Metering-Method' = [],
         'Precedence' = [],
         'AF-Charging-Identifier' = [],
         'Flows' = [],
         'Monitoring-Key' = [],
         'Redirect-Information' = [],
         'Mute-Notification' = [],
         'AF-Signalling-Protocol' = [],
         'Sponsor-Identity' = [],
         'Application-Service-Provider-Identity' = [],
         'Required-Access-Info' = [],
         'AVP' = []}).

-record('diameter_travelping_Charging-Rule-Install',
        {'Charging-Rule-Definition' = [],
         'Charging-Rule-Name' = [],
         'Charging-Rule-Base-Name' = [],
         'Bearer-Identifier' = [],
         'Rule-Activation-Time' = [],
         'Rule-Deactivation-Time' = [],
         'Resource-Allocation-Notification' = [],
         'Charging-Correlation-Indicator' = [],
         'AVP' = []}).

-record('diameter_travelping_Charging-Rule-Remove',
        {'Charging-Rule-Name' = [],
         'Charging-Rule-Base-Name' = [],
         'Required-Access-Info' = [],
         'AVP' = []}).

-record('diameter_travelping_Charging-Rule-Report',
        {'Charging-Rule-Name' = [],
         'Charging-Rule-Base-Name' = [],
         'Bearer-Identifier' = [],
         'PCC-Rule-Status' = [],
         'Rule-Failure-Code' = [],
         'Final-Unit-Indication' = [],
         'RAN-NAS-Release-Cause' = [],
         'AVP' = []}).

-record('diameter_travelping_CoA-Information',
        {'Tunnel-Information', 'CoA-IP-Address', 'AVP' = []}).

-record('diameter_travelping_Conditional-APN-Aggregate-Max-Bitrate',
        {'APN-Aggregate-Max-Bitrate-UL' = [],
         'APN-Aggregate-Max-Bitrate-DL' = [],
         'IP-CAN-Type' = [],
         'RAT-Type' = [],
         'AVP' = []}).

-record('diameter_travelping_Default-EPS-Bearer-QoS',
        {'QoS-Class-Identifier' = [],
         'Allocation-Retention-Priority' = [],
         'AVP' = []}).

-record('diameter_travelping_Default-QoS-Information',
        {'QoS-Class-Identifier' = [],
         'Max-Requested-Bandwidth-UL' = [],
         'Max-Requested-Bandwidth-DL' = [],
         'Default-QoS-Name' = [],
         'AVP' = []}).

-record('diameter_travelping_Event-Report-Indication',
        {'Event-Trigger' = [],
         'IP-CAN-Type' = [],
         'AN-GW-Address' = [],
         '3GPP-SGSN-Address' = [],
         '3GPP-SGSN-IPv6-Address' = [],
         '3GPP-SGSN-MCC-MNC' = [],
         'Framed-IP-Address' = [],
         'RAT-Type' = [],
         'RAI' = [],
         '3GPP-User-Location-Info' = [],
         '3GPP-MS-TimeZone' = [],
         'Routing-IP-Address' = [],
         'UE-Local-IP-Address' = [],
         'HeNB-Local-IP-Address' = [],
         'UDP-Source-Port' = [],
         'Presence-Reporting-Area-Information' = [],
         'AVP' = []}).

-record('diameter_travelping_Fixed-User-Location-Info',
        {'Logical-Access-ID' = [],
         'Physical-Access-ID' = [],
         'AVP' = []}).

-record('diameter_travelping_Flow-Information',
        {'Flow-Description' = [],
         'Packet-Filter-Identifier' = [],
         'Packet-Filter-Usage' = [],
         'ToS-Traffic-Class' = [],
         'Security-Parameter-Index' = [],
         'Flow-Label' = [],
         'Flow-Direction' = [],
         'AVP' = []}).

-record('diameter_travelping_Packet-Filter-Information',
        {'Packet-Filter-Identifier' = [],
         'Precedence' = [],
         'Packet-Filter-Content' = [],
         'ToS-Traffic-Class' = [],
         'Security-Parameter-Index' = [],
         'Flow-Label' = [],
         'Flow-Direction' = [],
         'AVP' = []}).

-record('diameter_travelping_Presence-Reporting-Area-Information',
        {'Presence-Reporting-Area-Identifier' = [],
         'Presence-Reporting-Area-Status' = [],
         'Presence-Reporting-Area-Elements-List' = [],
         'AVP' = []}).

-record('diameter_travelping_QoS-Information',
        {'QoS-Class-Identifier' = [],
         'Max-Requested-Bandwidth-UL' = [],
         'Max-Requested-Bandwidth-DL' = [],
         'Guaranteed-Bitrate-UL' = [],
         'Guaranteed-Bitrate-DL' = [],
         'Bearer-Identifier' = [],
         'Allocation-Retention-Priority' = [],
         'APN-Aggregate-Max-Bitrate-UL' = [],
         'APN-Aggregate-Max-Bitrate-DL' = [],
         'Conditional-APN-Aggregate-Max-Bitrate' = [],
         'AVP' = []}).

-record('diameter_travelping_Redirect-Information',
        {'Redirect-Support' = [],
         'Redirect-Address-Type' = [],
         'Redirect-Server-Address' = [],
         'AVP' = []}).

-record('diameter_travelping_Routing-Filter',
        {'Flow-Description',
         'Flow-Direction',
         'ToS-Traffic-Class' = [],
         'Security-Parameter-Index' = [],
         'Flow-Label' = [],
         'AVP' = []}).

-record('diameter_travelping_Routing-Rule-Definition',
        {'Routing-Rule-Identifier',
         'Routing-Filter' = [],
         'Precedence' = [],
         'Routing-IP-Address' = [],
         'AVP' = []}).

-record('diameter_travelping_Routing-Rule-Install',
        {'Routing-Rule-Definition' = [], 'AVP' = []}).

-record('diameter_travelping_Routing-Rule-Remove',
        {'Routing-Rule-Identifier' = [], 'AVP' = []}).

-record('diameter_travelping_TDF-Information',
        {'TDF-Destination-Realm' = [],
         'TDF-Destination-Host' = [],
         'TDF-IP-Address' = []}).

-record('diameter_travelping_Tunnel-Information',
        {'Tunnel-Header-Length' = [],
         'Tunnel-Header-Filter' = [],
         'AVP' = []}).

-record('diameter_travelping_TFT-Packet-Filter-Information',
        {'Precedence' = [],
         'TFT-Filter' = [],
         'ToS-Traffic-Class' = [],
         'Security-Parameter-Index' = [],
         'Flow-Label' = [],
         'Flow-Direction' = [],
         'AVP' = []}).

-record('diameter_travelping_Usage-Monitoring-Information',
        {'Monitoring-Key' = [],
         'Granted-Service-Unit' = [],
         'Used-Service-Unit' = [],
         'Usage-Monitoring-Level' = [],
         'Usage-Monitoring-Report' = [],
         'Usage-Monitoring-Support' = [],
         'AVP' = []}).


%%% -------------------------------------------------------
%%% Grouped AVP records from diameter_3gpp_ts32_299:
%%% -------------------------------------------------------

-record('diameter_travelping_Access-Network-Info-Change',
        {'Access-Network-Information' = [],
         'Cellular-Network-Information' = [],
         'Change-Time' = []}).

-record('diameter_travelping_Access-Transfer-Information',
        {'Access-Transfer-Type' = [],
         'Access-Network-Information' = [],
         'Cellular-Network-Information' = [],
         'Inter-UE-Transfer' = [],
         'User-Equipment-Info' = [],
         'Instance-Id' = [],
         'Related-IMS-Charging-Identifier' = [],
         'Related-IMS-Charging-Identifier-Node' = [],
         'Change-Time' = []}).

-record('diameter_travelping_Accumulated-Cost',
        {'Value-Digits', 'Exponent' = []}).

-record('diameter_travelping_Additional-Content-Information',
        {'Type-Number' = [],
         'Additional-Type-Information' = [],
         'Content-Size' = []}).

-record('diameter_travelping_Address-Domain',
        {'Domain-Name' = [], '3GPP-IMSI-MCC-MNC' = []}).

-record('diameter_travelping_AF-Correlation-Information',
        {'AF-Charging-Identifier', 'Flows' = []}).

-record('diameter_travelping_Announcement-Information',
        {'Announcement-Identifier',
         'Variable-Part' = [],
         'Time-Indicator' = [],
         'Quota-Indicator' = [],
         'Announcement-Order' = [],
         'Play-Alternative' = [],
         'Privacy-Indicator' = [],
         'Language' = []}).

-record('diameter_travelping_AoC-Cost-Information',
        {'Accumulated-Cost' = [],
         'Incremental-Cost' = [],
         'Currency-Code' = []}).

-record('diameter_travelping_AoC-Information',
        {'AoC-Cost-Information' = [],
         'Tariff-Information' = [],
         'AoC-Subscription-Information' = []}).

-record('diameter_travelping_AoC-Service',
        {'AoC-Service-Obligatory-Type' = [],
         'AoC-Service-Type' = []}).

-record('diameter_travelping_AoC-Subscription-Information',
        {'AoC-Service' = [],
         'AoC-Format' = [],
         'Preferred-AoC-Currency' = []}).

-record('diameter_travelping_APN-Rate-Control',
        {'APN-Rate-Control-Uplink' = [],
         'APN-Rate-Control-Downlink' = []}).

-record('diameter_travelping_APN-Rate-Control-Downlink',
        {'Rate-Control-Time-Unit' = [],
         'Rate-Control-Max-Rate' = [],
         'Rate-Control-Max-Message-Size' = []}).

-record('diameter_travelping_APN-Rate-Control-Uplink',
        {'Additional-Exception-Reports' = [],
         'Rate-Control-Time-Unit' = [],
         'Rate-Control-Max-Rate' = []}).

-record('diameter_travelping_Application-Server-Information',
        {'Application-Server' = [],
         'Application-Provided-Called-Party-Address' = [],
         'Status-AS-Code' = []}).

-record('diameter_travelping_Basic-Service-Code',
        {'Bearer-Service' = [], 'Teleservice' = []}).

-record('diameter_travelping_Called-Identity-Change',
        {'Called-Identity' = [], 'Change-Time' = []}).

-record('diameter_travelping_Coverage-Info',
        {'Coverage-Status' = [],
         'Change-Time' = [],
         'Location-Info' = []}).

-record('diameter_travelping_CPDT-Information',
        {'Serving-Node-Identity' = [],
         'SGW-Change' = [],
         'NIDD-Submission' = []}).

-record('diameter_travelping_Current-Tariff',
        {'Currency-Code' = [],
         'Scale-Factor' = [],
         'Rate-Element' = []}).

-record('diameter_travelping_Destination-Interface',
        {'Interface-Id' = [],
         'Interface-Text' = [],
         'Interface-Port' = [],
         'Interface-Type' = []}).

-record('diameter_travelping_Early-Media-Description',
        {'SDP-TimeStamps' = [],
         'SDP-Media-Component' = [],
         'SDP-Session-Description' = []}).

-record('diameter_travelping_Enhanced-Diagnostics',
        {'RAN-NAS-Release-Cause' = []}).

-record(diameter_travelping_Envelope,
        {'Envelope-Start-Time',
         'Envelope-End-Time' = [],
         'CC-Total-Octets' = [],
         'CC-Input-Octets' = [],
         'CC-Output-Octets' = [],
         'CC-Service-Specific-Units' = []}).

-record('diameter_travelping_Event-Type',
        {'SIP-Method' = [], 'Event' = [], 'Expires' = []}).

-record('diameter_travelping_Incremental-Cost',
        {'Value-Digits', 'Exponent' = []}).

-record('diameter_travelping_IMS-Information',
        {'Node-Functionality',
         'Event-Type' = [],
         'Role-Of-Node' = [],
         'User-Session-Id' = [],
         'Outgoing-Session-Id' = [],
         'Session-Priority' = [],
         'Calling-Party-Address' = [],
         'Called-Party-Address' = [],
         'Called-Asserted-Identity' = [],
         'Called-Identity-Change' = [],
         'Number-Portability-Routing-Information' = [],
         'Carrier-Select-Routing-Information' = [],
         'Alternate-Charged-Party-Address' = [],
         'Requested-Party-Address' = [],
         'Associated-URI' = [],
         'Time-Stamps' = [],
         'Application-Server-Information' = [],
         'Inter-Operator-Identifier' = [],
         'Transit-IOI-List' = [],
         'IMS-Charging-Identifier' = [],
         'SDP-Session-Description' = [],
         'SDP-Media-Component' = [],
         'Served-Party-IP-Address' = [],
         'Trunk-Group-Id' = [],
         'Bearer-Service' = [],
         'Service-Id' = [],
         'Service-Specific-Info' = [],
         'Message-Body' = [],
         'Cause-Code' = [],
         'Reason-Header' = [],
         'Access-Network-Information' = [],
         'Cellular-Network-Information' = [],
         'Early-Media-Description' = [],
         'IMS-Communication-Service-Identifier' = [],
         'IMS-Application-Reference-Identifier' = [],
         'Online-Charging-Flag' = [],
         'Real-Time-Tariff-Information' = [],
         'Account-Expiration' = [],
         'Initial-IMS-Charging-Identifier' = [],
         'NNI-Information' = [],
         'From-Address' = [],
         'IMS-Emergency-Indicator' = [],
         'IMS-Visited-Network-Identifier' = [],
         'Access-Network-Info-Change' = [],
         'Access-Transfer-Information' = [],
         'Related-IMS-Charging-Identifier' = [],
         'Related-IMS-Charging-Identifier-Node' = [],
         'Route-Header-Received' = [],
         'Route-Header-Transmitted' = [],
         'Instance-Id' = [],
         'TAD-Identifier' = [],
         'FE-Identifier-List' = []}).

-record('diameter_travelping_Inter-Operator-Identifier',
        {'Originating-IOI' = [], 'Terminating-IOI' = []}).

-record('diameter_travelping_ISUP-Cause',
        {'ISUP-Cause-Location' = [],
         'ISUP-Cause-Value' = [],
         'ISUP-Cause-Diagnostics' = []}).

-record('diameter_travelping_LCS-Client-ID',
        {'LCS-Client-Type' = [],
         'LCS-Client-External-ID' = [],
         'LCS-Client-Dialed-By-MS' = [],
         'LCS-Client-Name' = [],
         'LCS-APN' = [],
         'LCS-Requestor-ID' = []}).

-record('diameter_travelping_LCS-Client-Name',
        {'LCS-Data-Coding-Scheme' = [],
         'LCS-Name-String' = [],
         'LCS-Format-Indicator' = []}).

-record('diameter_travelping_LCS-Information',
        {'LCS-Client-ID' = [],
         'Location-Type' = [],
         'Location-Estimate' = [],
         'Positioning-Data' = [],
         '3GPP-IMSI' = [],
         'MSISDN' = []}).

-record('diameter_travelping_LCS-Requestor-ID',
        {'LCS-Data-Coding-Scheme' = [],
         'LCS-Requestor-ID-String' = []}).

-record('diameter_travelping_Location-Info',
        {'3GPP-User-Location-Info' = [], 'Change-Time' = []}).

-record('diameter_travelping_Location-Type',
        {'Location-Estimate-Type' = [],
         'Deferred-Location-Event-Type' = []}).

-record('diameter_travelping_MBMS-Information',
        {'TMGI' = [],
         'MBMS-User-Service-Type' = [],
         'File-Repair-Supported' = [],
         'MBMS-2G-3G-Indicator' = [],
         'MBMS-Service-Area' = [],
         'MBMS-Session-Identity' = [],
         'CN-IP-Multicast-Distribution' = [],
         'MBMS-GW-Address' = [],
         'MBMS-Charged-Party' = [],
         'MSISDN' = []}).

-record('diameter_travelping_Message-Body',
        {'Content-Type',
         'Content-Length',
         'Content-Disposition' = [],
         'Originator' = []}).

-record('diameter_travelping_Message-Class',
        {'Class-Identifier' = [], 'Token-Text' = []}).

-record('diameter_travelping_MM-Content-Type',
        {'Type-Number' = [],
         'Additional-Type-Information' = [],
         'Content-Size' = [],
         'Additional-Content-Information' = []}).

-record('diameter_travelping_MMS-Information',
        {'Originator-Address' = [],
         'Recipient-Address' = [],
         'Submission-Time' = [],
         'MM-Content-Type' = [],
         'Priority' = [],
         'Message-ID' = [],
         'Message-Type' = [],
         'Message-Size' = [],
         'Message-Class' = [],
         'Delivery-Report-Requested' = [],
         'Read-Reply-Report-Requested' = [],
         'MMBox-Storage-Requested' = [],
         'Applic-ID' = [],
         'Reply-Applic-ID' = [],
         'Aux-Applic-Info' = [],
         'Content-Class' = [],
         'DRM-Content' = [],
         'Adaptations' = []}).

-record('diameter_travelping_MMTel-Information',
        {'Supplementary-Service' = []}).

-record('diameter_travelping_Monitoring-Event-Information',
        {'Monitoring-Event-Functionality' = [],
         'Event-Timestamp' = [],
         'Monitoring-Event-Configuration-Activity' = [],
         'Charged-Party' = [],
         'Monitoring-Event-Report-Data' = []}).

-record('diameter_travelping_Monitoring-Event-Report-Data',
        {'Event-Timestamp' = [],
         'Monitoring-Event-Report-Number' = [],
         'Charged-Party' = [],
         'Subscription-Id' = []}).

-record('diameter_travelping_Next-Tariff',
        {'Currency-Code' = [],
         'Scale-Factor' = [],
         'Rate-Element' = []}).

-record('diameter_travelping_NIDD-Submission',
        {'Submission-Time' = [],
         'Event-Timestamp' = [],
         'Accounting-Input-Octets' = [],
         'Accounting-Output-Octets' = [],
         'Change-Condition' = []}).

-record('diameter_travelping_NNI-Information',
        {'Session-Direction' = [],
         'NNI-Type' = [],
         'Relationship-Mode' = [],
         'Neighbour-Node-Address' = []}).

-record('diameter_travelping_Offline-Charging',
        {'Quota-Consumption-Time' = [],
         'Time-Quota-Mechanism' = [],
         'Envelope-Reporting' = [],
         'Multiple-Services-Credit-Control' = [],
         'AVP' = []}).

-record('diameter_travelping_Originator-Address',
        {'Address-Type' = [],
         'Address-Data' = [],
         'Address-Domain' = []}).

-record('diameter_travelping_Originator-Interface',
        {'Interface-Id' = [],
         'Interface-Text' = [],
         'Interface-Port' = [],
         'Interface-Type' = []}).

-record('diameter_travelping_Originator-Received-Address',
        {'Address-Type' = [],
         'Address-Data' = [],
         'Address-Domain' = []}).

-record('diameter_travelping_Participant-Group',
        {'Called-Party-Address' = [],
         'Participant-Access-Priority' = [],
         'User-Participating-Type' = []}).

-record('diameter_travelping_PoC-Information',
        {'PoC-Server-Role' = [],
         'PoC-Session-Type' = [],
         'PoC-User-Role' = [],
         'PoC-Session-Initiation-Type' = [],
         'PoC-Event-Type' = [],
         'Number-Of-Participants' = [],
         'Participants-Involved' = [],
         'Participant-Group' = [],
         'Talk-Burst-Exchange' = [],
         'PoC-Controlling-Address' = [],
         'PoC-Group-Name' = [],
         'PoC-Session-Id' = [],
         'Charged-Party' = []}).

-record('diameter_travelping_PoC-User-Role',
        {'PoC-User-Role-IDs' = [],
         'PoC-User-Role-Info-Units' = []}).

-record('diameter_travelping_ProSe-Direct-Communication-Reception-Data-Container',
        {'Local-Sequence-Number' = [],
         'Coverage-Status' = [],
         '3GPP-User-Location-Info' = [],
         'Accounting-Input-Octets' = [],
         'Change-Time' = [],
         'Change-Condition' = [],
         'Usage-Information-Report-Sequence-Number' = [],
         'Radio-Resources-Indicator' = [],
         'Radio-Frequency' = []}).

-record('diameter_travelping_ProSe-Direct-Communication-Transmission-Data-Container',
        {'Local-Sequence-Number' = [],
         'Coverage-Status' = [],
         '3GPP-User-Location-Info' = [],
         'Accounting-Output-Octets' = [],
         'Change-Time' = [],
         'Change-Condition' = [],
         'Usage-Information-Report-Sequence-Number' = [],
         'Radio-Resources-Indicator' = [],
         'Radio-Frequency' = []}).

-record('diameter_travelping_ProSe-Information',
        {'Announcing-UE-HPLMN-Identifier' = [],
         'Announcing-UE-VPLMN-Identifier' = [],
         'Monitoring-UE-HPLMN-Identifier' = [],
         'Monitoring-UE-VPLMN-Identifier' = [],
         'Role-Of-ProSe-Function' = [],
         'ProSe-3rd-Party-Application-ID' = [],
         'Application-Specific-Data' = [],
         'ProSe-Event-Type' = [],
         'ProSe-Direct-Discovery-Model' = [],
         'ProSe-Function-IP-Address' = [],
         'ProSe-Role-Of-UE' = [],
         'ProSe-Request-Timestamp' = [],
         'PC3-Control-Protocol-Cause' = [],
         'Monitoring-UE-Identifier' = [],
         'Requestor-PLMN-Identifier' = [],
         'Requested-PLMN-Identifier' = [],
         'ProSe-Range-Class' = [],
         'Proximity-Alert-Indication' = [],
         'Proximity-Alert-Timestamp' = [],
         'Proximity-Cancellation-Timestamp' = [],
         'ProSe-Reason-For-Cancellation' = [],
         'PC3-EPC-Control-Protocol-Cause' = [],
         'ProSe-UE-ID' = [],
         'ProSe-Source-IP-Address' = [],
         'Layer-2-Group-ID' = [],
         'ProSe-Group-IP-Multicast-Address' = [],
         'Coverage-Info' = [],
         'Radio-Parameter-Set-Info' = [],
         'Transmitter-Info' = [],
         'Time-First-Transmission' = [],
         'Time-First-Reception' = [],
         'ProSe-Direct-Communication-Transmission-Data-Container'
             = [],
         'ProSe-Direct-Communication-Reception-Data-Container' =
             [],
         'Announcing-PLMN-ID' = [],
         'ProSe-Target-Layer-2-ID' = [],
         'Relay-IP-address' = [],
         'ProSe-UE-to-Network-Relay-UE-ID' = [],
         'Target-IP-Address' = [],
         'PC5-Radio-Technology' = []}).

-record('diameter_travelping_PS-Furnish-Charging-Information',
        {'3GPP-Charging-Id',
         'PS-Free-Format-Data',
         'PS-Append-Free-Format-Data' = []}).

-record('diameter_travelping_PS-Information',
        {'3GPP-Charging-Id' = [],
         'PDN-Connection-Charging-ID' = [],
         'Node-Id' = [],
         '3GPP-PDP-Type' = [],
         'PDP-Address' = [],
         'PDP-Address-Prefix-Length' = [],
         'Dynamic-Address-Flag' = [],
         'Dynamic-Address-Flag-Extension' = [],
         'QoS-Information' = [],
         'SGSN-Address' = [],
         'GGSN-Address' = [],
         'TDF-IP-Address' = [],
         'SGW-Address' = [],
         'TWAG-Address' = [],
         'CG-Address' = [],
         'Serving-Node-Type' = [],
         'SGW-Change' = [],
         '3GPP-IMSI-MCC-MNC' = [],
         'IMSI-Unauthenticated-Flag' = [],
         '3GPP-GGSN-MCC-MNC' = [],
         '3GPP-NSAPI' = [],
         'Called-Station-Id' = [],
         '3GPP-Session-Stop-Indicator' = [],
         '3GPP-Selection-Mode' = [],
         '3GPP-Charging-Characteristics' = [],
         'Charging-Characteristics-Selection-Mode' = [],
         '3GPP-SGSN-MCC-MNC' = [],
         '3GPP-MS-TimeZone' = [],
         'Charging-Rule-Base-Name' = [],
         '3GPP-User-Location-Info' = [],
         'User-Location-Info-Time' = [],
         'User-CSG-Information' = [],
         'Presence-Reporting-Area-Information' = [],
         'TWAN-User-Location-Info' = [],
         'UWAN-User-Location-Info' = [],
         '3GPP-RAT-Type' = [],
         'PS-Furnish-Charging-Information' = [],
         'PDP-Context-Type' = [],
         'Offline-Charging' = [],
         'Traffic-Data-Volumes' = [],
         'Service-Data-Container' = [],
         'User-Equipment-Info' = [],
         'Start-Time' = [],
         'Stop-Time' = [],
         'Change-Condition' = [],
         'Diagnostics' = [],
         'Low-Priority-Indicator' = [],
         'Logical-Access-ID' = [],
         'Physical-Access-ID' = [],
         'Fixed-User-Location-Info' = [],
         'CN-Operator-Selection-Entity' = [],
         'Enhanced-Diagnostics' = [],
         'SGi-PtP-Tunnelling-Method' = [],
         'CP-CIoT-EPS-Optimisation-Indicator' = [],
         'UNI-PDU-CP-Only-Flag' = [],
         'APN-Rate-Control' = [],
         'Charging-Per-IP-CAN-Session-Indicator' = [],
         '3GPP-PS-Data-Off-Status' = [],
         'SCS-AS-Address' = [],
         'Unused-Quota-Timer' = [],
         'RAN-Secondary-RAT-Usage-Report' = [],
         'AVP' = []}).

-record('diameter_travelping_Radio-Parameter-Set-Info',
        {'Radio-Parameter-Set-Values' = [],
         'Change-Time' = []}).

-record('diameter_travelping_RAN-Secondary-RAT-Usage-Report',
        {'Secondary-RAT-Type' = [],
         'RAN-Start-Timestamp' = [],
         'RAN-End-Timestamp' = [],
         'Accounting-Input-Octets' = [],
         'Accounting-Output-Octets' = [],
         '3GPP-Charging-Id' = []}).

-record('diameter_travelping_Rate-Element',
        {'CC-Unit-Type',
         'Charge-Reason-Code' = [],
         'Unit-Value' = [],
         'Unit-Cost' = [],
         'Unit-Quota-Threshold' = []}).

-record('diameter_travelping_Real-Time-Tariff-Information',
        {'Tariff-Information' = [], 'Tariff-XML' = []}).

-record('diameter_travelping_Recipient-Address',
        {'Address-Type' = [],
         'Address-Data' = [],
         'Address-Domain' = [],
         'Addressee-Type' = []}).

-record('diameter_travelping_Recipient-Info',
        {'Destination-Interface' = [],
         'Recipient-Address' = [],
         'Recipient-Received-Address' = [],
         'Recipient-SCCP-Address' = [],
         'SM-Protocol-ID' = []}).

-record('diameter_travelping_Recipient-Received-Address',
        {'Address-Type' = [],
         'Address-Data' = [],
         'Address-Domain' = []}).

-record('diameter_travelping_Related-Change-Condition-Information',
        {'SGSN-Address' = [],
         'Change-Condition' = [],
         '3GPP-User-Location-Info' = [],
         'UWAN-User-Location-Info' = [],
         'Presence-Reporting-Area-Status' = [],
         'User-CSG-Information' = [],
         '3GPP-RAT-Type' = []}).

-record('diameter_travelping_Related-Trigger',
        {'Trigger-Type' = []}).

-record('diameter_travelping_Remaining-Balance',
        {'Unit-Value', 'Currency-Code'}).

-record('diameter_travelping_Scale-Factor',
        {'Value-Digits', 'Exponent' = []}).

-record('diameter_travelping_SCS-AS-Address',
        {'SCS-Realm' = [], 'SCS-Address' = []}).

-record('diameter_travelping_SDP-Media-Component',
        {'SDP-Media-Name' = [],
         'SDP-Media-Description' = [],
         'Local-GW-Inserted-Indication' = [],
         'IP-Realm-Default-Indication' = [],
         'Transcoder-Inserted-Indication' = [],
         'Media-Initiator-Flag' = [],
         'Media-Initiator-Party' = [],
         '3GPP-Charging-Id' = [],
         'Access-Network-Charging-Identifier-Value' = [],
         'SDP-Type' = []}).

-record('diameter_travelping_SDP-TimeStamps',
        {'SDP-Offer-Timestamp' = [],
         'SDP-Answer-Timestamp' = []}).

-record('diameter_travelping_Service-Data-Container',
        {'AF-Correlation-Information' = [],
         'Charging-Rule-Base-Name' = [],
         'Accounting-Input-Octets' = [],
         'Accounting-Output-Octets' = [],
         'Local-Sequence-Number' = [],
         'QoS-Information' = [],
         'Rating-Group' = [],
         'Change-Time' = [],
         'Service-Identifier' = [],
         'Service-Specific-Info' = [],
         'SGSN-Address' = [],
         'Time-First-Usage' = [],
         'Time-Last-Usage' = [],
         'Time-Usage' = [],
         'Change-Condition' = [],
         '3GPP-User-Location-Info' = [],
         'UWAN-User-Location-Info' = [],
         'Sponsor-Identity' = [],
         'Application-Service-Provider-Identity' = [],
         'Presence-Reporting-Area-Information' = [],
         'Presence-Reporting-Area-Status' = [],
         'User-CSG-Information' = [],
         '3GPP-RAT-Type' = [],
         'Related-Change-Condition-Information' = [],
         'APN-Rate-Control' = [],
         '3GPP-PS-Data-Off-Status' = []}).

-record('diameter_travelping_Service-Specific-Info',
        {'Service-Specific-Data' = [],
         'Service-Specific-Type' = []}).

-record('diameter_travelping_SM-Device-Trigger-Information',
        {'MTC-IWF-Address' = [], 'Validity-Time' = []}).

-record('diameter_travelping_SMS-Information',
        {'SMS-Node' = [],
         'Client-Address' = [],
         'Originator-SCCP-Address' = [],
         'SMSC-Address' = [],
         'Data-Coding-Scheme' = [],
         'SM-Discharge-Time' = [],
         'SM-Message-Type' = [],
         'Originator-Interface' = [],
         'SM-Protocol-ID' = [],
         'Reply-Path-Requested' = [],
         'SM-Status' = [],
         'SM-User-Data-Header' = [],
         'Number-Of-Messages-Sent' = [],
         'SM-Sequence-Number' = [],
         'Recipient-Info' = [],
         'Originator-Received-Address' = [],
         'SM-Service-Type' = [],
         'SMS-Result' = [],
         'SM-Device-Trigger-Indicator' = [],
         'SM-Device-Trigger-Information' = [],
         'MTC-IWF-Address' = []}).

-record('diameter_travelping_Supplementary-Service',
        {'MMTel-SService-Type' = [],
         'Service-Mode' = [],
         'Number-Of-Diversions' = [],
         'Associated-Party-Address' = [],
         'Service-Id' = [],
         'Change-Time' = [],
         'Number-Of-Participants' = [],
         'Participant-Action-Type' = [],
         'CUG-Information' = [],
         'AoC-Information' = []}).

-record('diameter_travelping_Talk-Burst-Exchange',
        {'PoC-Change-Time',
         'Number-Of-Talk-Bursts' = [],
         'Talk-Burst-Volume' = [],
         'Talk-Burst-Time' = [],
         'Number-Of-Received-Talk-Bursts' = [],
         'Received-Talk-Burst-Volume' = [],
         'Received-Talk-Burst-Time' = [],
         'Number-Of-Participants' = [],
         'PoC-Change-Condition' = []}).

-record('diameter_travelping_Tariff-Information',
        {'Current-Tariff',
         'Tariff-Time-Change' = [],
         'Next-Tariff' = []}).

-record('diameter_travelping_Time-Quota-Mechanism',
        {'Time-Quota-Type', 'Base-Time-Interval'}).

-record('diameter_travelping_Time-Stamps',
        {'SIP-Request-Timestamp' = [],
         'SIP-Response-Timestamp' = [],
         'SIP-Request-Timestamp-Fraction' = [],
         'SIP-Response-Timestamp-Fraction' = []}).

-record('diameter_travelping_Traffic-Data-Volumes',
        {'QoS-Information' = [],
         'Accounting-Input-Octets' = [],
         'Accounting-Output-Octets' = [],
         'Change-Condition' = [],
         'Change-Time' = [],
         '3GPP-User-Location-Info' = [],
         'UWAN-User-Location-Info' = [],
         '3GPP-Charging-Id' = [],
         'Presence-Reporting-Area-Status' = [],
         'User-CSG-Information' = [],
         '3GPP-RAT-Type' = [],
         'Related-Change-Condition-Information' = [],
         'Diagnostics' = [],
         'Enhanced-Diagnostics' = [],
         'CP-CIoT-EPS-Optimisation-Indicator' = []}).

-record('diameter_travelping_Transmitter-Info',
        {'ProSe-Source-IP-Address' = [], 'ProSe-UE-ID' = []}).

-record(diameter_travelping_Trigger,
        {'Trigger-Type' = []}).

-record('diameter_travelping_Trunk-Group-Id',
        {'Incoming-Trunk-Group-Id' = [],
         'Outgoing-Trunk-Group-Id' = []}).

-record('diameter_travelping_TWAN-User-Location-Info',
        {'BSSID' = []}).

-record('diameter_travelping_Unit-Cost',
        {'Value-Digits', 'Exponent' = []}).

-record('diameter_travelping_User-CSG-Information',
        {'CSG-Access-Mode', 'CSG-Membership-Indication' = []}).

-record('diameter_travelping_UWAN-User-Location-Info',
        {'UE-Local-IP-Address',
         'UDP-Source-Port' = [],
         'BSSID' = []}).

-record('diameter_travelping_Variable-Part',
        {'Variable-Part-Type',
         'Variable-Part-Value',
         'Variable-Part-Order' = []}).

-record('diameter_travelping_VCS-Information',
        {'Bearer-Capability' = [],
         'Network-Call-Reference-Number' = [],
         'MSC-Address' = [],
         'Basic-Service-Code' = [],
         'ISUP-Location-Number' = [],
         'VLR-Number' = [],
         'Forwarding-Pending' = [],
         'ISUP-Cause' = [],
         'Start-Time' = [],
         'Start-of-Charging' = [],
         'Stop-Time' = [],
         'PS-Free-Format-Data' = []}).


%%% -------------------------------------------------------
%%% ENUM Macros from diameter_3gpp_base:
%%% -------------------------------------------------------

-ifndef('DIAMETER_TRAVELPING_3GPP-PDP-TYPE_IPV4').
-define('DIAMETER_TRAVELPING_3GPP-PDP-TYPE_IPV4', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_3GPP-PDP-TYPE_PPP').
-define('DIAMETER_TRAVELPING_3GPP-PDP-TYPE_PPP', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_3GPP-PDP-TYPE_IPV6').
-define('DIAMETER_TRAVELPING_3GPP-PDP-TYPE_IPV6', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_3GPP-PDP-TYPE_IPV4V6').
-define('DIAMETER_TRAVELPING_3GPP-PDP-TYPE_IPV4V6', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_3GPP-PDP-TYPE_NON-IP').
-define('DIAMETER_TRAVELPING_3GPP-PDP-TYPE_NON-IP', 4).
-endif.



%%% -------------------------------------------------------
%%% ENUM Macros from diameter_3gpp_ts29_212:
%%% -------------------------------------------------------

-ifndef('DIAMETER_TRAVELPING_AN-GW-STATUS_AN_GW_FAILED').
-define('DIAMETER_TRAVELPING_AN-GW-STATUS_AN_GW_FAILED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_BEARER-CONTROL-MODE_UE_ONLY').
-define('DIAMETER_TRAVELPING_BEARER-CONTROL-MODE_UE_ONLY', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_BEARER-CONTROL-MODE_RESERVED').
-define('DIAMETER_TRAVELPING_BEARER-CONTROL-MODE_RESERVED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_BEARER-CONTROL-MODE_UE_NW').
-define('DIAMETER_TRAVELPING_BEARER-CONTROL-MODE_UE_NW', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_BEARER-OPERATION_TERMINATION').
-define('DIAMETER_TRAVELPING_BEARER-OPERATION_TERMINATION', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_BEARER-OPERATION_ESTABLISHMENT').
-define('DIAMETER_TRAVELPING_BEARER-OPERATION_ESTABLISHMENT', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_BEARER-OPERATION_MODIFICATION').
-define('DIAMETER_TRAVELPING_BEARER-OPERATION_MODIFICATION', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_BEARER-USAGE_GENERAL').
-define('DIAMETER_TRAVELPING_BEARER-USAGE_GENERAL', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_BEARER-USAGE_IMS_SIGNALLING').
-define('DIAMETER_TRAVELPING_BEARER-USAGE_IMS_SIGNALLING', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGING-CORRELATION-INDICATOR_CHARGING_IDENTIFIER_REQUIRED').
-define('DIAMETER_TRAVELPING_CHARGING-CORRELATION-INDICATOR_CHARGING_IDENTIFIER_REQUIRED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CSG-INFORMATION-REPORTING_CHANGE_CSG_CELL').
-define('DIAMETER_TRAVELPING_CSG-INFORMATION-REPORTING_CHANGE_CSG_CELL', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CSG-INFORMATION-REPORTING_CHANGE_CSG_SUBSCRIBED_HYBRID_CELL').
-define('DIAMETER_TRAVELPING_CSG-INFORMATION-REPORTING_CHANGE_CSG_SUBSCRIBED_HYBRID_CELL', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CSG-INFORMATION-REPORTING_CHANGE_CSG_UNSUBSCRIBED_HYBRID_CELL').
-define('DIAMETER_TRAVELPING_CSG-INFORMATION-REPORTING_CHANGE_CSG_UNSUBSCRIBED_HYBRID_CELL', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_SGSN_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_SGSN_CHANGE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_QOS_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_QOS_CHANGE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_RAT_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_RAT_CHANGE', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_TFT_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_TFT_CHANGE', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_PLMN_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_PLMN_CHANGE', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_LOSS_OF_BEARER').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_LOSS_OF_BEARER', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_RECOVERY_OF_BEARER').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_RECOVERY_OF_BEARER', 6).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_IP-CAN_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_IP-CAN_CHANGE', 7).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_QOS_CHANGE_EXCEEDING_AUTHORIZATION').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_QOS_CHANGE_EXCEEDING_AUTHORIZATION', 11).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_RAI_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_RAI_CHANGE', 12).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_USER_LOCATION_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_USER_LOCATION_CHANGE', 13).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_NO_EVENT_TRIGGERS').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_NO_EVENT_TRIGGERS', 14).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_OUT_OF_CREDIT').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_OUT_OF_CREDIT', 15).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_REALLOCATION_OF_CREDIT').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_REALLOCATION_OF_CREDIT', 16).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_REVALIDATION_TIMEOUT').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_REVALIDATION_TIMEOUT', 17).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_UE_IP_ADDRESS_ALLOCATE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_UE_IP_ADDRESS_ALLOCATE', 18).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_UE_IP_ADDRESS_RELEASE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_UE_IP_ADDRESS_RELEASE', 19).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_DEFAULT_EPS_BEARER_QOS_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_DEFAULT_EPS_BEARER_QOS_CHANGE', 20).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_AN_GW_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_AN_GW_CHANGE', 21).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_SUCCESSFUL_RESOURCE_ALLOCATION').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_SUCCESSFUL_RESOURCE_ALLOCATION', 22).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_RESOURCE_MODIFICATION_REQUEST').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_RESOURCE_MODIFICATION_REQUEST', 23).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_PGW_TRACE_CONTROL').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_PGW_TRACE_CONTROL', 24).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_UE_TIME_ZONE_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_UE_TIME_ZONE_CHANGE', 25).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_TAI_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_TAI_CHANGE', 26).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_ECGI_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_ECGI_CHANGE', 27).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_CHARGING_CORRELATION_EXCHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_CHARGING_CORRELATION_EXCHANGE', 28).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_APN-AMBR_MODIFICATION_FAILURE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_APN-AMBR_MODIFICATION_FAILURE', 29).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_USER_CSG_INFORMATION_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_USER_CSG_INFORMATION_CHANGE', 30).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_USAGE_REPORT').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_USAGE_REPORT', 33).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_DEFAULT-EPS-BEARER-QOS_MODIFICATION_FAILURE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_DEFAULT-EPS-BEARER-QOS_MODIFICATION_FAILURE', 34).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_USER_CSG_HYBRID_SUBSCRIBED_INFORMATION_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_USER_CSG_HYBRID_SUBSCRIBED_INFORMATION_CHANGE', 35).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_USER_CSG_HYBRID_UNSUBSCRIBED_INFORMATION_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_USER_CSG_HYBRID_UNSUBSCRIBED_INFORMATION_CHANGE', 36).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_ROUTING_RULE_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_ROUTING_RULE_CHANGE', 37).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_APPLICATION_START').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_APPLICATION_START', 39).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_APPLICATION_STOP').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_APPLICATION_STOP', 40).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_CS_TO_PS_HANDOVER').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_CS_TO_PS_HANDOVER', 42).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_UE_LOCAL_IP_ADDRESS_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_UE_LOCAL_IP_ADDRESS_CHANGE', 43).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_HNB_LOCAL_IP_ADDRESS_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_HNB_LOCAL_IP_ADDRESS_CHANGE', 44).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_ACCESS_NETWORK_INFO_REPORT').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_ACCESS_NETWORK_INFO_REPORT', 45).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_CREDIT_MANAGEMENT_SESSION_FAILURE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_CREDIT_MANAGEMENT_SESSION_FAILURE', 46).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_DEFAULT_QOS_CHANGE').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_DEFAULT_QOS_CHANGE', 47).
-endif.
-ifndef('DIAMETER_TRAVELPING_EVENT-TRIGGER_CHANGE_OF_UE_PRESENCE_IN_PRESENCE_REPORTING_AREA_REPORT').
-define('DIAMETER_TRAVELPING_EVENT-TRIGGER_CHANGE_OF_UE_PRESENCE_IN_PRESENCE_REPORTING_AREA_REPORT', 48).
-endif.
-ifndef('DIAMETER_TRAVELPING_FLOW-DIRECTION_UNSPECIFIED').
-define('DIAMETER_TRAVELPING_FLOW-DIRECTION_UNSPECIFIED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_FLOW-DIRECTION_DOWNLINK').
-define('DIAMETER_TRAVELPING_FLOW-DIRECTION_DOWNLINK', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_FLOW-DIRECTION_UPLINK').
-define('DIAMETER_TRAVELPING_FLOW-DIRECTION_UPLINK', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_FLOW-DIRECTION_BIDIRECTIONAL').
-define('DIAMETER_TRAVELPING_FLOW-DIRECTION_BIDIRECTIONAL', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-CAN-SESSION-CHARGING-SCOPE_IP-CAN_SESSION_SCOPE').
-define('DIAMETER_TRAVELPING_IP-CAN-SESSION-CHARGING-SCOPE_IP-CAN_SESSION_SCOPE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-CAN-TYPE_3GPP-GPRS').
-define('DIAMETER_TRAVELPING_IP-CAN-TYPE_3GPP-GPRS', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-CAN-TYPE_DOCSIS').
-define('DIAMETER_TRAVELPING_IP-CAN-TYPE_DOCSIS', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-CAN-TYPE_XDSL').
-define('DIAMETER_TRAVELPING_IP-CAN-TYPE_XDSL', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-CAN-TYPE_WIMAX').
-define('DIAMETER_TRAVELPING_IP-CAN-TYPE_WIMAX', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-CAN-TYPE_3GPP2').
-define('DIAMETER_TRAVELPING_IP-CAN-TYPE_3GPP2', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-CAN-TYPE_3GPP-EPS').
-define('DIAMETER_TRAVELPING_IP-CAN-TYPE_3GPP-EPS', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-CAN-TYPE_NON-3GPP-EPS').
-define('DIAMETER_TRAVELPING_IP-CAN-TYPE_NON-3GPP-EPS', 6).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-CAN-TYPE_FBA').
-define('DIAMETER_TRAVELPING_IP-CAN-TYPE_FBA', 7).
-endif.
-ifndef('DIAMETER_TRAVELPING_METERING-METHOD_DURATION').
-define('DIAMETER_TRAVELPING_METERING-METHOD_DURATION', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_METERING-METHOD_VOLUME').
-define('DIAMETER_TRAVELPING_METERING-METHOD_VOLUME', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_METERING-METHOD_DURATION_VOLUME').
-define('DIAMETER_TRAVELPING_METERING-METHOD_DURATION_VOLUME', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_METERING-METHOD_EVENT').
-define('DIAMETER_TRAVELPING_METERING-METHOD_EVENT', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_MUTE-NOTIFICATION_MUTE_REQUIRED').
-define('DIAMETER_TRAVELPING_MUTE-NOTIFICATION_MUTE_REQUIRED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_NETWORK-REQUEST-SUPPORT_NETWORK_REQUEST_NOT_SUPPORTED').
-define('DIAMETER_TRAVELPING_NETWORK-REQUEST-SUPPORT_NETWORK_REQUEST_NOT_SUPPORTED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_NETWORK-REQUEST-SUPPORT_NETWORK_REQUEST_SUPPORTED').
-define('DIAMETER_TRAVELPING_NETWORK-REQUEST-SUPPORT_NETWORK_REQUEST_SUPPORTED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_OFFLINE_DISABLE_OFFLINE').
-define('DIAMETER_TRAVELPING_OFFLINE_DISABLE_OFFLINE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_OFFLINE_ENABLE_OFFLINE').
-define('DIAMETER_TRAVELPING_OFFLINE_ENABLE_OFFLINE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ONLINE_DISABLE_ONLINE').
-define('DIAMETER_TRAVELPING_ONLINE_DISABLE_ONLINE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ONLINE_ENABLE_ONLINE').
-define('DIAMETER_TRAVELPING_ONLINE_ENABLE_ONLINE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PACKET-FILTER-OPERATION_DELETION').
-define('DIAMETER_TRAVELPING_PACKET-FILTER-OPERATION_DELETION', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PACKET-FILTER-OPERATION_ADDITION').
-define('DIAMETER_TRAVELPING_PACKET-FILTER-OPERATION_ADDITION', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PACKET-FILTER-OPERATION_MODIFICATION').
-define('DIAMETER_TRAVELPING_PACKET-FILTER-OPERATION_MODIFICATION', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PACKET-FILTER-USAGE_SEND_TO_UE').
-define('DIAMETER_TRAVELPING_PACKET-FILTER-USAGE_SEND_TO_UE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PCC-RULE-STATUS_ACTIVE').
-define('DIAMETER_TRAVELPING_PCC-RULE-STATUS_ACTIVE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PCC-RULE-STATUS_INACTIVE').
-define('DIAMETER_TRAVELPING_PCC-RULE-STATUS_INACTIVE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PCC-RULE-STATUS_TEMPORARILY_INACTIVE').
-define('DIAMETER_TRAVELPING_PCC-RULE-STATUS_TEMPORARILY_INACTIVE', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PRE-EMPTION-CAPABILITY_PRE-EMPTION_CAPABILITY_ENABLED').
-define('DIAMETER_TRAVELPING_PRE-EMPTION-CAPABILITY_PRE-EMPTION_CAPABILITY_ENABLED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PRE-EMPTION-CAPABILITY_PRE-EMPTION_CAPABILITY_DISABLED').
-define('DIAMETER_TRAVELPING_PRE-EMPTION-CAPABILITY_PRE-EMPTION_CAPABILITY_DISABLED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PRE-EMPTION-VULNERABILITY_PRE-EMPTION_VULNERABILITY_ENABLED').
-define('DIAMETER_TRAVELPING_PRE-EMPTION-VULNERABILITY_PRE-EMPTION_VULNERABILITY_ENABLED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PRE-EMPTION-VULNERABILITY_PRE-EMPTION_VULNERABILITY_DISABLED').
-define('DIAMETER_TRAVELPING_PRE-EMPTION-VULNERABILITY_PRE-EMPTION_VULNERABILITY_DISABLED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PS-TO-CS-SESSION-CONTINUITY_VIDEO_PS2CS_CONT_CANDIDATE').
-define('DIAMETER_TRAVELPING_PS-TO-CS-SESSION-CONTINUITY_VIDEO_PS2CS_CONT_CANDIDATE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_QOS-NEGOTIATION_NO_QOS_NEGOTIATION').
-define('DIAMETER_TRAVELPING_QOS-NEGOTIATION_NO_QOS_NEGOTIATION', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_QOS-NEGOTIATION_QOS_NEGOTIATION_SUPPORTED').
-define('DIAMETER_TRAVELPING_QOS-NEGOTIATION_QOS_NEGOTIATION_SUPPORTED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_QOS-UPGRADE_QOS_UPGRADE_NOT_SUPPORTED').
-define('DIAMETER_TRAVELPING_QOS-UPGRADE_QOS_UPGRADE_NOT_SUPPORTED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_QOS-UPGRADE_QOS_UPGRADE_SUPPORTED').
-define('DIAMETER_TRAVELPING_QOS-UPGRADE_QOS_UPGRADE_SUPPORTED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_WLAN').
-define('DIAMETER_TRAVELPING_RAT-TYPE_WLAN', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_VIRTUAL').
-define('DIAMETER_TRAVELPING_RAT-TYPE_VIRTUAL', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_UTRAN').
-define('DIAMETER_TRAVELPING_RAT-TYPE_UTRAN', 1000).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_GERAN').
-define('DIAMETER_TRAVELPING_RAT-TYPE_GERAN', 1001).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_GAN').
-define('DIAMETER_TRAVELPING_RAT-TYPE_GAN', 1002).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_HSPA_EVOLUTION').
-define('DIAMETER_TRAVELPING_RAT-TYPE_HSPA_EVOLUTION', 1003).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_EUTRAN').
-define('DIAMETER_TRAVELPING_RAT-TYPE_EUTRAN', 1004).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_CDMA2000_1X').
-define('DIAMETER_TRAVELPING_RAT-TYPE_CDMA2000_1X', 2000).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_HRPD').
-define('DIAMETER_TRAVELPING_RAT-TYPE_HRPD', 2001).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_UMB').
-define('DIAMETER_TRAVELPING_RAT-TYPE_UMB', 2002).
-endif.
-ifndef('DIAMETER_TRAVELPING_RAT-TYPE_EHRPD').
-define('DIAMETER_TRAVELPING_RAT-TYPE_EHRPD', 2003).
-endif.
-ifndef('DIAMETER_TRAVELPING_REDIRECT-SUPPORT_REDIRECTION_DISABLED').
-define('DIAMETER_TRAVELPING_REDIRECT-SUPPORT_REDIRECTION_DISABLED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_REDIRECT-SUPPORT_REDIRECTION_ENABLED').
-define('DIAMETER_TRAVELPING_REDIRECT-SUPPORT_REDIRECTION_ENABLED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-LEVEL_SERVICE_IDENTIFIER_LEVEL').
-define('DIAMETER_TRAVELPING_REPORTING-LEVEL_SERVICE_IDENTIFIER_LEVEL', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-LEVEL_RATING_GROUP_LEVEL').
-define('DIAMETER_TRAVELPING_REPORTING-LEVEL_RATING_GROUP_LEVEL', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-LEVEL_SPONSORED_CONNECTIVITY_LEVEL').
-define('DIAMETER_TRAVELPING_REPORTING-LEVEL_SPONSORED_CONNECTIVITY_LEVEL', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_RESOURCE-ALLOCATION-NOTIFICATION_ENABLE_NOTIFICATION').
-define('DIAMETER_TRAVELPING_RESOURCE-ALLOCATION-NOTIFICATION_ENABLE_NOTIFICATION', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_UNKNOWN_RULE_NAME').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_UNKNOWN_RULE_NAME', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_RATING_GROUP_ERROR').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_RATING_GROUP_ERROR', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_SERVICE_IDENTIFIER_ERROR').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_SERVICE_IDENTIFIER_ERROR', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_GW_PCEF_MALFUNCTION').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_GW_PCEF_MALFUNCTION', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_RESOURCES_LIMITATION').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_RESOURCES_LIMITATION', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_MAX_NR_BEARERS_REACHED').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_MAX_NR_BEARERS_REACHED', 6).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_UNKNOWN_BEARER_ID').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_UNKNOWN_BEARER_ID', 7).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_MISSING_BEARER_ID').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_MISSING_BEARER_ID', 8).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_MISSING_FLOW_INFORMATION').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_MISSING_FLOW_INFORMATION', 9).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_RESOURCE_ALLOCATION_FAILURE').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_RESOURCE_ALLOCATION_FAILURE', 10).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_UNSUCCESSFUL_QOS_VALIDATION').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_UNSUCCESSFUL_QOS_VALIDATION', 11).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_INCORRECT_FLOW_INFORMATION').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_INCORRECT_FLOW_INFORMATION', 12).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_PS_TO_CS_HANDOVER').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_PS_TO_CS_HANDOVER', 13).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_TDF_APPLICATION_IDENTIFIER_ERROR').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_TDF_APPLICATION_IDENTIFIER_ERROR', 14).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_NO_BEARER_BOUND').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_NO_BEARER_BOUND', 15).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_FILTER_RESTRICTIONS').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_FILTER_RESTRICTIONS', 16).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_AN_GW_FAILED').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_AN_GW_FAILED', 17).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_MISSING_REDIRECT_SERVER_ADDRESS').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_MISSING_REDIRECT_SERVER_ADDRESS', 18).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_CM_END_USER_SERVICE_DENIED').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_CM_END_USER_SERVICE_DENIED', 19).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_CM_CREDIT_CONTROL_NOT_APPLICABLE').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_CM_CREDIT_CONTROL_NOT_APPLICABLE', 20).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_CM_AUTHORIZATION_REJECTED').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_CM_AUTHORIZATION_REJECTED', 21).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_CM_USER_UNKNOWN').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_CM_USER_UNKNOWN', 22).
-endif.
-ifndef('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_CM_RATING_FAILED').
-define('DIAMETER_TRAVELPING_RULE-FAILURE-CODE_CM_RATING_FAILED', 23).
-endif.
-ifndef('DIAMETER_TRAVELPING_SESSION-RELEASE-CAUSE_UNSPECIFIED_REASON').
-define('DIAMETER_TRAVELPING_SESSION-RELEASE-CAUSE_UNSPECIFIED_REASON', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SESSION-RELEASE-CAUSE_UE_SUBSCRIPTION_REASON').
-define('DIAMETER_TRAVELPING_SESSION-RELEASE-CAUSE_UE_SUBSCRIPTION_REASON', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_SESSION-RELEASE-CAUSE_INSUFFICIENT_SERVER_RESOURCES').
-define('DIAMETER_TRAVELPING_SESSION-RELEASE-CAUSE_INSUFFICIENT_SERVER_RESOURCES', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_SESSION-RELEASE-CAUSE_IP_CAN_SESSION_TERMINATION').
-define('DIAMETER_TRAVELPING_SESSION-RELEASE-CAUSE_IP_CAN_SESSION_TERMINATION', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_SESSION-RELEASE-CAUSE_UE_IP_ADDRESS_RELEASE').
-define('DIAMETER_TRAVELPING_SESSION-RELEASE-CAUSE_UE_IP_ADDRESS_RELEASE', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_USAGE-MONITORING-LEVEL_SESSION_LEVEL').
-define('DIAMETER_TRAVELPING_USAGE-MONITORING-LEVEL_SESSION_LEVEL', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_USAGE-MONITORING-LEVEL_PCC_RULE_LEVEL').
-define('DIAMETER_TRAVELPING_USAGE-MONITORING-LEVEL_PCC_RULE_LEVEL', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_USAGE-MONITORING-LEVEL_ADC_RULE_LEVEL').
-define('DIAMETER_TRAVELPING_USAGE-MONITORING-LEVEL_ADC_RULE_LEVEL', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_USAGE-MONITORING-REPORT_USAGE_MONITORING_REPORT_REQUIRED').
-define('DIAMETER_TRAVELPING_USAGE-MONITORING-REPORT_USAGE_MONITORING_REPORT_REQUIRED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_USAGE-MONITORING-SUPPORT_USAGE_MONITORING_DISABLED').
-define('DIAMETER_TRAVELPING_USAGE-MONITORING-SUPPORT_USAGE_MONITORING_DISABLED', 0).
-endif.



%%% -------------------------------------------------------
%%% ENUM Macros from diameter_3gpp_ts32_299:
%%% -------------------------------------------------------

-ifndef('DIAMETER_TRAVELPING_3GPP-PS-DATA-OFF-STATUS_ACTIVE').
-define('DIAMETER_TRAVELPING_3GPP-PS-DATA-OFF-STATUS_ACTIVE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_3GPP-PS-DATA-OFF-STATUS_INACTIVE').
-define('DIAMETER_TRAVELPING_3GPP-PS-DATA-OFF-STATUS_INACTIVE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ACCESS-TRANSFER-TYPE_PS-TO-CS-TRANSFER').
-define('DIAMETER_TRAVELPING_ACCESS-TRANSFER-TYPE_PS-TO-CS-TRANSFER', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ACCESS-TRANSFER-TYPE_CS-TO-PS-TRANSFER').
-define('DIAMETER_TRAVELPING_ACCESS-TRANSFER-TYPE_CS-TO-PS-TRANSFER', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ACCESS-TRANSFER-TYPE_PS-TO-PS-TRANSFER').
-define('DIAMETER_TRAVELPING_ACCESS-TRANSFER-TYPE_PS-TO-PS-TRANSFER', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_ACCESS-TRANSFER-TYPE_CS-TO-CS-TRANSFER').
-define('DIAMETER_TRAVELPING_ACCESS-TRANSFER-TYPE_CS-TO-CS-TRANSFER', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADAPTATIONS_YES').
-define('DIAMETER_TRAVELPING_ADAPTATIONS_YES', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADAPTATIONS_NO').
-define('DIAMETER_TRAVELPING_ADAPTATIONS_NO', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDITIONAL-EXCEPTION-REPORTS_NOT-ALLOWED').
-define('DIAMETER_TRAVELPING_ADDITIONAL-EXCEPTION-REPORTS_NOT-ALLOWED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDITIONAL-EXCEPTION-REPORTS_ALLOWED').
-define('DIAMETER_TRAVELPING_ADDITIONAL-EXCEPTION-REPORTS_ALLOWED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESS-TYPE_E-MAIL-ADDRESS').
-define('DIAMETER_TRAVELPING_ADDRESS-TYPE_E-MAIL-ADDRESS', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESS-TYPE_MSISDN').
-define('DIAMETER_TRAVELPING_ADDRESS-TYPE_MSISDN', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESS-TYPE_IPV4-ADDRESS').
-define('DIAMETER_TRAVELPING_ADDRESS-TYPE_IPV4-ADDRESS', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESS-TYPE_IPV6-ADDRESS').
-define('DIAMETER_TRAVELPING_ADDRESS-TYPE_IPV6-ADDRESS', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESS-TYPE_NUMERIC-SHORTCODE').
-define('DIAMETER_TRAVELPING_ADDRESS-TYPE_NUMERIC-SHORTCODE', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESS-TYPE_ALPHANUMERIC-SHORTCODE').
-define('DIAMETER_TRAVELPING_ADDRESS-TYPE_ALPHANUMERIC-SHORTCODE', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESS-TYPE_OTHER').
-define('DIAMETER_TRAVELPING_ADDRESS-TYPE_OTHER', 6).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESS-TYPE_IMSI').
-define('DIAMETER_TRAVELPING_ADDRESS-TYPE_IMSI', 7).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESSEE-TYPE_TO').
-define('DIAMETER_TRAVELPING_ADDRESSEE-TYPE_TO', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESSEE-TYPE_CC').
-define('DIAMETER_TRAVELPING_ADDRESSEE-TYPE_CC', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ADDRESSEE-TYPE_BCC').
-define('DIAMETER_TRAVELPING_ADDRESSEE-TYPE_BCC', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-FORMAT_MONETARY').
-define('DIAMETER_TRAVELPING_AOC-FORMAT_MONETARY', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-FORMAT_NON_MONETARY').
-define('DIAMETER_TRAVELPING_AOC-FORMAT_NON_MONETARY', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-FORMAT_CAI').
-define('DIAMETER_TRAVELPING_AOC-FORMAT_CAI', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-REQUEST-TYPE_AOC_NOT_REQUESTED').
-define('DIAMETER_TRAVELPING_AOC-REQUEST-TYPE_AOC_NOT_REQUESTED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-REQUEST-TYPE_AOC_FULL').
-define('DIAMETER_TRAVELPING_AOC-REQUEST-TYPE_AOC_FULL', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-REQUEST-TYPE_AOC_COST_ONLY').
-define('DIAMETER_TRAVELPING_AOC-REQUEST-TYPE_AOC_COST_ONLY', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-REQUEST-TYPE_AOC_TARIFF_ONLY').
-define('DIAMETER_TRAVELPING_AOC-REQUEST-TYPE_AOC_TARIFF_ONLY', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-SERVICE-OBLIGATORY-TYPE_NON_BINDING').
-define('DIAMETER_TRAVELPING_AOC-SERVICE-OBLIGATORY-TYPE_NON_BINDING', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-SERVICE-OBLIGATORY-TYPE_BINDING').
-define('DIAMETER_TRAVELPING_AOC-SERVICE-OBLIGATORY-TYPE_BINDING', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-SERVICE-TYPE_NONE').
-define('DIAMETER_TRAVELPING_AOC-SERVICE-TYPE_NONE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-SERVICE-TYPE_AOC-S').
-define('DIAMETER_TRAVELPING_AOC-SERVICE-TYPE_AOC-S', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-SERVICE-TYPE_AOC-D').
-define('DIAMETER_TRAVELPING_AOC-SERVICE-TYPE_AOC-D', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_AOC-SERVICE-TYPE_AOC-E').
-define('DIAMETER_TRAVELPING_AOC-SERVICE-TYPE_AOC-E', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGE-REASON-CODE_UNKNOWN').
-define('DIAMETER_TRAVELPING_CHARGE-REASON-CODE_UNKNOWN', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGE-REASON-CODE_USAGE').
-define('DIAMETER_TRAVELPING_CHARGE-REASON-CODE_USAGE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGE-REASON-CODE_COMMUNICATION-ATTEMPT-CHARGE').
-define('DIAMETER_TRAVELPING_CHARGE-REASON-CODE_COMMUNICATION-ATTEMPT-CHARGE', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGE-REASON-CODE_SETUP-CHARGE').
-define('DIAMETER_TRAVELPING_CHARGE-REASON-CODE_SETUP-CHARGE', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGE-REASON-CODE_ADD-ON-CHARGE').
-define('DIAMETER_TRAVELPING_CHARGE-REASON-CODE_ADD-ON-CHARGE', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_SERVING-NODE-SUPPLIED').
-define('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_SERVING-NODE-SUPPLIED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_SUBSCRIPTION-SPECIFIC').
-define('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_SUBSCRIPTION-SPECIFIC', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_APN-SPECIFIC').
-define('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_APN-SPECIFIC', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_HOME-DEFAULT').
-define('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_HOME-DEFAULT', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_ROAMING-DEFAULT').
-define('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_ROAMING-DEFAULT', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_VISITING-DEFAULT').
-define('DIAMETER_TRAVELPING_CHARGING-CHARACTERISTICS-SELECTION-MODE_VISITING-DEFAULT', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGING-PER-IP-CAN-SESSION-INDICATOR_INACTIVE').
-define('DIAMETER_TRAVELPING_CHARGING-PER-IP-CAN-SESSION-INDICATOR_INACTIVE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CHARGING-PER-IP-CAN-SESSION-INDICATOR_ACTIVE').
-define('DIAMETER_TRAVELPING_CHARGING-PER-IP-CAN-SESSION-INDICATOR_ACTIVE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CLASS-IDENTIFIER_PERSONAL').
-define('DIAMETER_TRAVELPING_CLASS-IDENTIFIER_PERSONAL', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CLASS-IDENTIFIER_ADVERTISEMENT').
-define('DIAMETER_TRAVELPING_CLASS-IDENTIFIER_ADVERTISEMENT', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CLASS-IDENTIFIER_INFORMATIONAL').
-define('DIAMETER_TRAVELPING_CLASS-IDENTIFIER_INFORMATIONAL', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_CLASS-IDENTIFIER_AUTO').
-define('DIAMETER_TRAVELPING_CLASS-IDENTIFIER_AUTO', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_CN-OPERATOR-SELECTION-ENTITY_THE-SERVING-NETWORK-HAS-BEEN-SELECTED-BY-THE-UE').
-define('DIAMETER_TRAVELPING_CN-OPERATOR-SELECTION-ENTITY_THE-SERVING-NETWORK-HAS-BEEN-SELECTED-BY-THE-UE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CN-OPERATOR-SELECTION-ENTITY_THE-SERVING-NETWORK-HAS-BEEN-SELECTED-BY-THE-NETWORK').
-define('DIAMETER_TRAVELPING_CN-OPERATOR-SELECTION-ENTITY_THE-SERVING-NETWORK-HAS-BEEN-SELECTED-BY-THE-NETWORK', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CONTENT-CLASS_TEXT').
-define('DIAMETER_TRAVELPING_CONTENT-CLASS_TEXT', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CONTENT-CLASS_IMAGE-BASIC').
-define('DIAMETER_TRAVELPING_CONTENT-CLASS_IMAGE-BASIC', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CONTENT-CLASS_IMAGE-RICH').
-define('DIAMETER_TRAVELPING_CONTENT-CLASS_IMAGE-RICH', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_CONTENT-CLASS_VIDEO-BASIC').
-define('DIAMETER_TRAVELPING_CONTENT-CLASS_VIDEO-BASIC', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_CONTENT-CLASS_VIDEO-RICH').
-define('DIAMETER_TRAVELPING_CONTENT-CLASS_VIDEO-RICH', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_CONTENT-CLASS_MEGAPIXEL').
-define('DIAMETER_TRAVELPING_CONTENT-CLASS_MEGAPIXEL', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_CONTENT-CLASS_CONTENT-BASIC').
-define('DIAMETER_TRAVELPING_CONTENT-CLASS_CONTENT-BASIC', 6).
-endif.
-ifndef('DIAMETER_TRAVELPING_CONTENT-CLASS_CONTENT-RICH').
-define('DIAMETER_TRAVELPING_CONTENT-CLASS_CONTENT-RICH', 7).
-endif.
-ifndef('DIAMETER_TRAVELPING_COVERAGE-STATUS_OUT-OF-COVERAGE').
-define('DIAMETER_TRAVELPING_COVERAGE-STATUS_OUT-OF-COVERAGE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_COVERAGE-STATUS_IN-COVERAGE').
-define('DIAMETER_TRAVELPING_COVERAGE-STATUS_IN-COVERAGE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CP-CIOT-EPS-OPTIMISATION-INDICATOR_NOT-APPLY').
-define('DIAMETER_TRAVELPING_CP-CIOT-EPS-OPTIMISATION-INDICATOR_NOT-APPLY', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CP-CIOT-EPS-OPTIMISATION-INDICATOR_APPLY').
-define('DIAMETER_TRAVELPING_CP-CIOT-EPS-OPTIMISATION-INDICATOR_APPLY', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CSG-ACCESS-MODE_CLOSED-MODE').
-define('DIAMETER_TRAVELPING_CSG-ACCESS-MODE_CLOSED-MODE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CSG-ACCESS-MODE_HYBRID-MODE').
-define('DIAMETER_TRAVELPING_CSG-ACCESS-MODE_HYBRID-MODE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_CSG-MEMBERSHIP-INDICATION_NOT-CSG-MEMBER').
-define('DIAMETER_TRAVELPING_CSG-MEMBERSHIP-INDICATION_NOT-CSG-MEMBER', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_CSG-MEMBERSHIP-INDICATION_CSG-MEMBER').
-define('DIAMETER_TRAVELPING_CSG-MEMBERSHIP-INDICATION_CSG-MEMBER', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_DELIVERY-REPORT-REQUESTED_NO').
-define('DIAMETER_TRAVELPING_DELIVERY-REPORT-REQUESTED_NO', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_DELIVERY-REPORT-REQUESTED_YES').
-define('DIAMETER_TRAVELPING_DELIVERY-REPORT-REQUESTED_YES', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_DRM-CONTENT_NO').
-define('DIAMETER_TRAVELPING_DRM-CONTENT_NO', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_DRM-CONTENT_YES').
-define('DIAMETER_TRAVELPING_DRM-CONTENT_YES', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_DYNAMIC-ADDRESS-FLAG_STATIC').
-define('DIAMETER_TRAVELPING_DYNAMIC-ADDRESS-FLAG_STATIC', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_DYNAMIC-ADDRESS-FLAG_DYNAMIC').
-define('DIAMETER_TRAVELPING_DYNAMIC-ADDRESS-FLAG_DYNAMIC', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_DYNAMIC-ADDRESS-FLAG-EXTENSION_STATIC').
-define('DIAMETER_TRAVELPING_DYNAMIC-ADDRESS-FLAG-EXTENSION_STATIC', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_DYNAMIC-ADDRESS-FLAG-EXTENSION_DYNAMIC').
-define('DIAMETER_TRAVELPING_DYNAMIC-ADDRESS-FLAG-EXTENSION_DYNAMIC', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ENVELOPE-REPORTING_DO_NOT_REPORT_ENVELOPES').
-define('DIAMETER_TRAVELPING_ENVELOPE-REPORTING_DO_NOT_REPORT_ENVELOPES', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ENVELOPE-REPORTING_REPORT_ENVELOPES').
-define('DIAMETER_TRAVELPING_ENVELOPE-REPORTING_REPORT_ENVELOPES', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ENVELOPE-REPORTING_REPORT_ENVELOPES_WITH_VOLUME').
-define('DIAMETER_TRAVELPING_ENVELOPE-REPORTING_REPORT_ENVELOPES_WITH_VOLUME', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_ENVELOPE-REPORTING_REPORT_ENVELOPES_WITH_EVENTS').
-define('DIAMETER_TRAVELPING_ENVELOPE-REPORTING_REPORT_ENVELOPES_WITH_EVENTS', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_ENVELOPE-REPORTING_REPORT_ENVELOPES_WITH_VOLUME_AND_EVENTS').
-define('DIAMETER_TRAVELPING_ENVELOPE-REPORTING_REPORT_ENVELOPES_WITH_VOLUME_AND_EVENTS', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_FILE-REPAIR-SUPPORTED_SUPPORTED').
-define('DIAMETER_TRAVELPING_FILE-REPAIR-SUPPORTED_SUPPORTED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_FILE-REPAIR-SUPPORTED_NOT_SUPPORTED').
-define('DIAMETER_TRAVELPING_FILE-REPAIR-SUPPORTED_NOT_SUPPORTED', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_FORWARDING-PENDING_FORWARDING-NOT-PENDING').
-define('DIAMETER_TRAVELPING_FORWARDING-PENDING_FORWARDING-NOT-PENDING', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_FORWARDING-PENDING_FORWARDING-PENDING').
-define('DIAMETER_TRAVELPING_FORWARDING-PENDING_FORWARDING-PENDING', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_INTERFACE-TYPE_UNKNOWN').
-define('DIAMETER_TRAVELPING_INTERFACE-TYPE_UNKNOWN', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_INTERFACE-TYPE_MOBILE_ORIGINATING').
-define('DIAMETER_TRAVELPING_INTERFACE-TYPE_MOBILE_ORIGINATING', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_INTERFACE-TYPE_MOBILE_TERMINATING').
-define('DIAMETER_TRAVELPING_INTERFACE-TYPE_MOBILE_TERMINATING', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_INTERFACE-TYPE_APPLICATION_ORIGINATING').
-define('DIAMETER_TRAVELPING_INTERFACE-TYPE_APPLICATION_ORIGINATING', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_INTERFACE-TYPE_APPLICATION_TERMINATION').
-define('DIAMETER_TRAVELPING_INTERFACE-TYPE_APPLICATION_TERMINATION', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_INTER-UE-TRANSFER_INTRA-UE-TRANSFER').
-define('DIAMETER_TRAVELPING_INTER-UE-TRANSFER_INTRA-UE-TRANSFER', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_INTER-UE-TRANSFER_INTER-UE-TRANSFER').
-define('DIAMETER_TRAVELPING_INTER-UE-TRANSFER_INTER-UE-TRANSFER', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_IMS-EMERGENCY-INDICATOR_NON-EMERGENCY').
-define('DIAMETER_TRAVELPING_IMS-EMERGENCY-INDICATOR_NON-EMERGENCY', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_IMS-EMERGENCY-INDICATOR_EMERGENCY').
-define('DIAMETER_TRAVELPING_IMS-EMERGENCY-INDICATOR_EMERGENCY', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_IMSI-UNAUTHENTICATED-FLAG_AUTHENTICATED').
-define('DIAMETER_TRAVELPING_IMSI-UNAUTHENTICATED-FLAG_AUTHENTICATED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_IMSI-UNAUTHENTICATED-FLAG_UNAUTHENTICATED').
-define('DIAMETER_TRAVELPING_IMSI-UNAUTHENTICATED-FLAG_UNAUTHENTICATED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-REALM-DEFAULT-INDICATION_DEFAULT-IP-REALM-NOT-USED').
-define('DIAMETER_TRAVELPING_IP-REALM-DEFAULT-INDICATION_DEFAULT-IP-REALM-NOT-USED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_IP-REALM-DEFAULT-INDICATION_DEFAULT-IP-REALM-USED').
-define('DIAMETER_TRAVELPING_IP-REALM-DEFAULT-INDICATION_DEFAULT-IP-REALM-USED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_LCS-CLIENT-TYPE_EMERGENCY_SERVICES').
-define('DIAMETER_TRAVELPING_LCS-CLIENT-TYPE_EMERGENCY_SERVICES', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_LCS-CLIENT-TYPE_VALUE_ADDED_SERVICES').
-define('DIAMETER_TRAVELPING_LCS-CLIENT-TYPE_VALUE_ADDED_SERVICES', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_LCS-CLIENT-TYPE_PLMN_OPERATOR_SERVICES').
-define('DIAMETER_TRAVELPING_LCS-CLIENT-TYPE_PLMN_OPERATOR_SERVICES', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_LCS-CLIENT-TYPE_LAWFUL_INTERCEPT_SERVICES').
-define('DIAMETER_TRAVELPING_LCS-CLIENT-TYPE_LAWFUL_INTERCEPT_SERVICES', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_LCS-FORMAT-INDICATOR_LOGICAL_NAME').
-define('DIAMETER_TRAVELPING_LCS-FORMAT-INDICATOR_LOGICAL_NAME', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_LCS-FORMAT-INDICATOR_EMAIL_ADDRESS').
-define('DIAMETER_TRAVELPING_LCS-FORMAT-INDICATOR_EMAIL_ADDRESS', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_LCS-FORMAT-INDICATOR_MSISDN').
-define('DIAMETER_TRAVELPING_LCS-FORMAT-INDICATOR_MSISDN', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_LCS-FORMAT-INDICATOR_URL').
-define('DIAMETER_TRAVELPING_LCS-FORMAT-INDICATOR_URL', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_LCS-FORMAT-INDICATOR_SIP_URL').
-define('DIAMETER_TRAVELPING_LCS-FORMAT-INDICATOR_SIP_URL', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOCAL-GW-INSERTED-INDICATION_LOCAL-GW-NOT-INSERTED').
-define('DIAMETER_TRAVELPING_LOCAL-GW-INSERTED-INDICATION_LOCAL-GW-NOT-INSERTED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOCAL-GW-INSERTED-INDICATION_LOCAL-GW-INSERTED').
-define('DIAMETER_TRAVELPING_LOCAL-GW-INSERTED-INDICATION_LOCAL-GW-INSERTED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOCATION-ESTIMATE-TYPE_CURRENT_LOCATION').
-define('DIAMETER_TRAVELPING_LOCATION-ESTIMATE-TYPE_CURRENT_LOCATION', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOCATION-ESTIMATE-TYPE_CURRENT_LAST_KNOWN_LOCATION').
-define('DIAMETER_TRAVELPING_LOCATION-ESTIMATE-TYPE_CURRENT_LAST_KNOWN_LOCATION', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOCATION-ESTIMATE-TYPE_INITIAL_LOCATION').
-define('DIAMETER_TRAVELPING_LOCATION-ESTIMATE-TYPE_INITIAL_LOCATION', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOCATION-ESTIMATE-TYPE_ACTIVATE_DEFERRED_LOCATION').
-define('DIAMETER_TRAVELPING_LOCATION-ESTIMATE-TYPE_ACTIVATE_DEFERRED_LOCATION', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOCATION-ESTIMATE-TYPE_CANCEL_DEFERRED_LOCATION').
-define('DIAMETER_TRAVELPING_LOCATION-ESTIMATE-TYPE_CANCEL_DEFERRED_LOCATION', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOW-BALANCE-INDICATION_NOT-APPLICABLE').
-define('DIAMETER_TRAVELPING_LOW-BALANCE-INDICATION_NOT-APPLICABLE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOW-BALANCE-INDICATION_YES').
-define('DIAMETER_TRAVELPING_LOW-BALANCE-INDICATION_YES', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOW-PRIORITY-INDICATOR_NO').
-define('DIAMETER_TRAVELPING_LOW-PRIORITY-INDICATOR_NO', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_LOW-PRIORITY-INDICATOR_YES').
-define('DIAMETER_TRAVELPING_LOW-PRIORITY-INDICATOR_YES', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_MBMS-CHARGED-PARTY_CONTENT-PROVIDER').
-define('DIAMETER_TRAVELPING_MBMS-CHARGED-PARTY_CONTENT-PROVIDER', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_MBMS-CHARGED-PARTY_SUBSCRIBER').
-define('DIAMETER_TRAVELPING_MBMS-CHARGED-PARTY_SUBSCRIBER', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_MBMS-USER-SERVICE-TYPE_DOWNLOAD').
-define('DIAMETER_TRAVELPING_MBMS-USER-SERVICE-TYPE_DOWNLOAD', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_MBMS-USER-SERVICE-TYPE_STREAMING').
-define('DIAMETER_TRAVELPING_MBMS-USER-SERVICE-TYPE_STREAMING', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_MEDIA-INITIATOR-FLAG_CALLED-PARTY').
-define('DIAMETER_TRAVELPING_MEDIA-INITIATOR-FLAG_CALLED-PARTY', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_MEDIA-INITIATOR-FLAG_CALLING-PARTY').
-define('DIAMETER_TRAVELPING_MEDIA-INITIATOR-FLAG_CALLING-PARTY', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_MEDIA-INITIATOR-FLAG_UNKNOWN').
-define('DIAMETER_TRAVELPING_MEDIA-INITIATOR-FLAG_UNKNOWN', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-SEND-REQ').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-SEND-REQ', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-SEND-CONF').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-SEND-CONF', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-NOTIFICATION-IND').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-NOTIFICATION-IND', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-NOTIFYRESP-IND').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-NOTIFYRESP-IND', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-RETRIEVE-CONF').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-RETRIEVE-CONF', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-ACKNOWLEDGE-IND').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-ACKNOWLEDGE-IND', 6).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-DELIVERY-IND').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-DELIVERY-IND', 7).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-READ-REC-IND').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-READ-REC-IND', 8).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-READ-ORIG-IND').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-READ-ORIG-IND', 9).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-FORWARD-REQ').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-FORWARD-REQ', 10).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-FORWARD-CONF').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-FORWARD-CONF', 11).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-MBOX-STORE-CONF').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-MBOX-STORE-CONF', 12).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-MBOX-VIEW-CONF').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-MBOX-VIEW-CONF', 13).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-MBOX-UPLOAD-CONF').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-MBOX-UPLOAD-CONF', 14).
-endif.
-ifndef('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-MBOX-DELETE-CONF').
-define('DIAMETER_TRAVELPING_MESSAGE-TYPE_M-MBOX-DELETE-CONF', 15).
-endif.
-ifndef('DIAMETER_TRAVELPING_MMBOX-STORAGE-REQUESTED_NO').
-define('DIAMETER_TRAVELPING_MMBOX-STORAGE-REQUESTED_NO', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_MMBOX-STORAGE-REQUESTED_YES').
-define('DIAMETER_TRAVELPING_MMBOX-STORAGE-REQUESTED_YES', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_NNI-TYPE_NON-ROAMING').
-define('DIAMETER_TRAVELPING_NNI-TYPE_NON-ROAMING', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_NNI-TYPE_ROAMING-WITHOUT-LOOPBACK').
-define('DIAMETER_TRAVELPING_NNI-TYPE_ROAMING-WITHOUT-LOOPBACK', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_NNI-TYPE_ROAMING-WITH-LOOPBACK').
-define('DIAMETER_TRAVELPING_NNI-TYPE_ROAMING-WITH-LOOPBACK', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_S-CSCF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_S-CSCF', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_P-CSCF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_P-CSCF', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_I-CSCF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_I-CSCF', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_MRFC').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_MRFC', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_MGCF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_MGCF', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_BGCF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_BGCF', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_AS').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_AS', 6).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_IBCF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_IBCF', 7).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_S-GW').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_S-GW', 8).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_P-GW').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_P-GW', 9).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_HSGW').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_HSGW', 10).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_E-CSCF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_E-CSCF', 11).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_MME').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_MME', 12).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_TRF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_TRF', 13).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_TF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_TF', 14).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_ATCF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_ATCF', 15).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_PROXY-FUNCTION').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_PROXY-FUNCTION', 16).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_EPDG').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_EPDG', 17).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_TDF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_TDF', 18).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_TWAG').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_TWAG', 19).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_SCEF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_SCEF', 20).
-endif.
-ifndef('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_IWK-SCEF').
-define('DIAMETER_TRAVELPING_NODE-FUNCTIONALITY_IWK-SCEF', 21).
-endif.
-ifndef('DIAMETER_TRAVELPING_ONLINE-CHARGING-FLAG_ECF-ADDRESS-NOT-PROVIDED').
-define('DIAMETER_TRAVELPING_ONLINE-CHARGING-FLAG_ECF-ADDRESS-NOT-PROVIDED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ONLINE-CHARGING-FLAG_ECF-ADDRESS-PROVIDED').
-define('DIAMETER_TRAVELPING_ONLINE-CHARGING-FLAG_ECF-ADDRESS-PROVIDED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ORIGINATOR_CALLING-PARTY').
-define('DIAMETER_TRAVELPING_ORIGINATOR_CALLING-PARTY', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ORIGINATOR_CALLED-PARTY').
-define('DIAMETER_TRAVELPING_ORIGINATOR_CALLED-PARTY', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PARTICIPANT-ACCESS-PRIORITY_PRE-EMPTIVE-PRIORITY').
-define('DIAMETER_TRAVELPING_PARTICIPANT-ACCESS-PRIORITY_PRE-EMPTIVE-PRIORITY', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PARTICIPANT-ACCESS-PRIORITY_HIGH-PRIORITY').
-define('DIAMETER_TRAVELPING_PARTICIPANT-ACCESS-PRIORITY_HIGH-PRIORITY', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PARTICIPANT-ACCESS-PRIORITY_NORMAL-PRIORITY').
-define('DIAMETER_TRAVELPING_PARTICIPANT-ACCESS-PRIORITY_NORMAL-PRIORITY', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_PARTICIPANT-ACCESS-PRIORITY_LOW-PRIORITY').
-define('DIAMETER_TRAVELPING_PARTICIPANT-ACCESS-PRIORITY_LOW-PRIORITY', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_PARTICIPANT-ACTION-TYPE_CREATE_CONF').
-define('DIAMETER_TRAVELPING_PARTICIPANT-ACTION-TYPE_CREATE_CONF', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PARTICIPANT-ACTION-TYPE_JOIN_CONF').
-define('DIAMETER_TRAVELPING_PARTICIPANT-ACTION-TYPE_JOIN_CONF', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PARTICIPANT-ACTION-TYPE_INVITE_INTO_CONF').
-define('DIAMETER_TRAVELPING_PARTICIPANT-ACTION-TYPE_INVITE_INTO_CONF', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PARTICIPANT-ACTION-TYPE_QUIT_CONF').
-define('DIAMETER_TRAVELPING_PARTICIPANT-ACTION-TYPE_QUIT_CONF', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_PC5-RADIO-TECHNOLOGY_EUTRA').
-define('DIAMETER_TRAVELPING_PC5-RADIO-TECHNOLOGY_EUTRA', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PC5-RADIO-TECHNOLOGY_WLAN').
-define('DIAMETER_TRAVELPING_PC5-RADIO-TECHNOLOGY_WLAN', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PC5-RADIO-TECHNOLOGY_BOTH-EUTRA-AND-WLAN').
-define('DIAMETER_TRAVELPING_PC5-RADIO-TECHNOLOGY_BOTH-EUTRA-AND-WLAN', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PDP-CONTEXT-TYPE_PRIMARY').
-define('DIAMETER_TRAVELPING_PDP-CONTEXT-TYPE_PRIMARY', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PDP-CONTEXT-TYPE_SECONDARY').
-define('DIAMETER_TRAVELPING_PDP-CONTEXT-TYPE_SECONDARY', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PLAY-ALTERNATIVE_SERVED-PARTY').
-define('DIAMETER_TRAVELPING_PLAY-ALTERNATIVE_SERVED-PARTY', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PLAY-ALTERNATIVE_REMOTE-PARTY').
-define('DIAMETER_TRAVELPING_PLAY-ALTERNATIVE_REMOTE-PARTY', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_SERVICECHANGE').
-define('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_SERVICECHANGE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_VOLUMELIMIT').
-define('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_VOLUMELIMIT', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_TIMELIMIT').
-define('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_TIMELIMIT', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_NUMBEROFTALKBURSTLIMIT').
-define('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_NUMBEROFTALKBURSTLIMIT', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_NUMBEROFACTIVEPARTICIPANTS').
-define('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_NUMBEROFACTIVEPARTICIPANTS', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_TARIFFTIME').
-define('DIAMETER_TRAVELPING_POC-CHANGE-CONDITION_TARIFFTIME', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-EVENT-TYPE_NORMAL').
-define('DIAMETER_TRAVELPING_POC-EVENT-TYPE_NORMAL', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-EVENT-TYPE_INSTANT-PERSONAL-ALERT-EVENT').
-define('DIAMETER_TRAVELPING_POC-EVENT-TYPE_INSTANT-PERSONAL-ALERT-EVENT', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-EVENT-TYPE_POC-GROUP-ADVERTISEMENT-EVENT').
-define('DIAMETER_TRAVELPING_POC-EVENT-TYPE_POC-GROUP-ADVERTISEMENT-EVENT', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-EVENT-TYPE_EARLY-SSESSION-SETTING-UP-EVENT').
-define('DIAMETER_TRAVELPING_POC-EVENT-TYPE_EARLY-SSESSION-SETTING-UP-EVENT', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-EVENT-TYPE_POC-TALK-BURST').
-define('DIAMETER_TRAVELPING_POC-EVENT-TYPE_POC-TALK-BURST', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-SERVER-ROLE_PARTICIPATING-POC-SERVER').
-define('DIAMETER_TRAVELPING_POC-SERVER-ROLE_PARTICIPATING-POC-SERVER', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-SERVER-ROLE_CONTROLLING-POC-SERVER').
-define('DIAMETER_TRAVELPING_POC-SERVER-ROLE_CONTROLLING-POC-SERVER', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-SERVER-ROLE_INTERWORKING-FUNCTION').
-define('DIAMETER_TRAVELPING_POC-SERVER-ROLE_INTERWORKING-FUNCTION', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-SERVER-ROLE_INTERWORKING-SELECTION-FUNCTION').
-define('DIAMETER_TRAVELPING_POC-SERVER-ROLE_INTERWORKING-SELECTION-FUNCTION', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-SESSION-INITIATION-TYPE_PRE-ESTABLISHED').
-define('DIAMETER_TRAVELPING_POC-SESSION-INITIATION-TYPE_PRE-ESTABLISHED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-SESSION-INITIATION-TYPE_ON-DEMAND').
-define('DIAMETER_TRAVELPING_POC-SESSION-INITIATION-TYPE_ON-DEMAND', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-SESSION-TYPE_1-TO-1-POC-SESSION').
-define('DIAMETER_TRAVELPING_POC-SESSION-TYPE_1-TO-1-POC-SESSION', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-SESSION-TYPE_CHAT-POC-GROUP-SESSION').
-define('DIAMETER_TRAVELPING_POC-SESSION-TYPE_CHAT-POC-GROUP-SESSION', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-SESSION-TYPE_PRE-ARRANGED-POC-GROUP-SESSION').
-define('DIAMETER_TRAVELPING_POC-SESSION-TYPE_PRE-ARRANGED-POC-GROUP-SESSION', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-SESSION-TYPE_AD-HOC-POC-GROUP-SESSION').
-define('DIAMETER_TRAVELPING_POC-SESSION-TYPE_AD-HOC-POC-GROUP-SESSION', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-USER-ROLE-INFO-UNITS_MODERATOR').
-define('DIAMETER_TRAVELPING_POC-USER-ROLE-INFO-UNITS_MODERATOR', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-USER-ROLE-INFO-UNITS_DISPATCHER').
-define('DIAMETER_TRAVELPING_POC-USER-ROLE-INFO-UNITS_DISPATCHER', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-USER-ROLE-INFO-UNITS_SESSION-OWNER').
-define('DIAMETER_TRAVELPING_POC-USER-ROLE-INFO-UNITS_SESSION-OWNER', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_POC-USER-ROLE-INFO-UNITS_SESSION-PARTICIPANT').
-define('DIAMETER_TRAVELPING_POC-USER-ROLE-INFO-UNITS_SESSION-PARTICIPANT', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_PRIORITY_LOW').
-define('DIAMETER_TRAVELPING_PRIORITY_LOW', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PRIORITY_NORMAL').
-define('DIAMETER_TRAVELPING_PRIORITY_NORMAL', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PRIORITY_HIGH').
-define('DIAMETER_TRAVELPING_PRIORITY_HIGH', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PRIVACY-INDICATOR_NOT_PRIVATE').
-define('DIAMETER_TRAVELPING_PRIVACY-INDICATOR_NOT_PRIVATE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PRIVACY-INDICATOR_PRIVATE').
-define('DIAMETER_TRAVELPING_PRIVACY-INDICATOR_PRIVATE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-DIRECT-DISCOVERY-MODEL_MODEL-A').
-define('DIAMETER_TRAVELPING_PROSE-DIRECT-DISCOVERY-MODEL_MODEL-A', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-DIRECT-DISCOVERY-MODEL_MODEL-B').
-define('DIAMETER_TRAVELPING_PROSE-DIRECT-DISCOVERY-MODEL_MODEL-B', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-EVENT-TYPE_ANNOUCING').
-define('DIAMETER_TRAVELPING_PROSE-EVENT-TYPE_ANNOUCING', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-EVENT-TYPE_MONITORING').
-define('DIAMETER_TRAVELPING_PROSE-EVENT-TYPE_MONITORING', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-EVENT-TYPE_MATCH-REPORT').
-define('DIAMETER_TRAVELPING_PROSE-EVENT-TYPE_MATCH-REPORT', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-FUNCTIONALITY_DIRECT-DISCOVERY').
-define('DIAMETER_TRAVELPING_PROSE-FUNCTIONALITY_DIRECT-DISCOVERY', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-FUNCTIONALITY_EPC-LEVEL-DISCOVERY').
-define('DIAMETER_TRAVELPING_PROSE-FUNCTIONALITY_EPC-LEVEL-DISCOVERY', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-FUNCTIONALITY_DIRECT-COMMUNICATION').
-define('DIAMETER_TRAVELPING_PROSE-FUNCTIONALITY_DIRECT-COMMUNICATION', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_RESERVED').
-define('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_RESERVED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_50M').
-define('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_50M', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_100M').
-define('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_100M', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_200M').
-define('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_200M', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_500M').
-define('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_500M', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_1000M').
-define('DIAMETER_TRAVELPING_PROSE-RANGE-CLASS_1000M', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-REASON-FOR-CANCELLATION_PROXIMITY-ALERT-SENT').
-define('DIAMETER_TRAVELPING_PROSE-REASON-FOR-CANCELLATION_PROXIMITY-ALERT-SENT', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-REASON-FOR-CANCELLATION_TIME-EXPIRED-WITH-NO-RENEWAL').
-define('DIAMETER_TRAVELPING_PROSE-REASON-FOR-CANCELLATION_TIME-EXPIRED-WITH-NO-RENEWAL', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-REASON-FOR-CANCELLATION_REQUESTOR-CANCELLATION').
-define('DIAMETER_TRAVELPING_PROSE-REASON-FOR-CANCELLATION_REQUESTOR-CANCELLATION', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-ROLE-OF-UE_ANNOUNCING-UE').
-define('DIAMETER_TRAVELPING_PROSE-ROLE-OF-UE_ANNOUNCING-UE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-ROLE-OF-UE_MONITORING-UE').
-define('DIAMETER_TRAVELPING_PROSE-ROLE-OF-UE_MONITORING-UE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-ROLE-OF-UE_REQUESTOR-UE').
-define('DIAMETER_TRAVELPING_PROSE-ROLE-OF-UE_REQUESTOR-UE', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROSE-ROLE-OF-UE_REQUESTED-UE').
-define('DIAMETER_TRAVELPING_PROSE-ROLE-OF-UE_REQUESTED-UE', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROXIMITY-ALERT-INDICATION_ALERT').
-define('DIAMETER_TRAVELPING_PROXIMITY-ALERT-INDICATION_ALERT', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PROXIMITY-ALERT-INDICATION_NO-ALERT').
-define('DIAMETER_TRAVELPING_PROXIMITY-ALERT-INDICATION_NO-ALERT', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_PS-APPEND-FREE-FORMAT-DATA_APPEND').
-define('DIAMETER_TRAVELPING_PS-APPEND-FREE-FORMAT-DATA_APPEND', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_PS-APPEND-FREE-FORMAT-DATA_OVERWRITE').
-define('DIAMETER_TRAVELPING_PS-APPEND-FREE-FORMAT-DATA_OVERWRITE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_QUOTA-INDICATOR_QUOTA_IS_NOT_USED_DURING_PLAYBACK').
-define('DIAMETER_TRAVELPING_QUOTA-INDICATOR_QUOTA_IS_NOT_USED_DURING_PLAYBACK', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_QUOTA-INDICATOR_QUOTA_IS_USED_DURING_PLAYBACK').
-define('DIAMETER_TRAVELPING_QUOTA-INDICATOR_QUOTA_IS_USED_DURING_PLAYBACK', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_READ-REPLY-REPORT-REQUESTED_NO').
-define('DIAMETER_TRAVELPING_READ-REPLY-REPORT-REQUESTED_NO', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_READ-REPLY-REPORT-REQUESTED_YES').
-define('DIAMETER_TRAVELPING_READ-REPLY-REPORT-REQUESTED_YES', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_RELATIONSHIP-MODE_TRUSTED').
-define('DIAMETER_TRAVELPING_RELATIONSHIP-MODE_TRUSTED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_RELATIONSHIP-MODE_NON-TRUSTED').
-define('DIAMETER_TRAVELPING_RELATIONSHIP-MODE_NON-TRUSTED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPLY-PATH-REQUESTED_NO-REPLY-PATH-SET').
-define('DIAMETER_TRAVELPING_REPLY-PATH-REQUESTED_NO-REPLY-PATH-SET', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPLY-PATH-REQUESTED_REPLY-PATH-SET').
-define('DIAMETER_TRAVELPING_REPLY-PATH-REQUESTED_REPLY-PATH-SET', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-REASON_THRESHOLD').
-define('DIAMETER_TRAVELPING_REPORTING-REASON_THRESHOLD', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-REASON_QHT').
-define('DIAMETER_TRAVELPING_REPORTING-REASON_QHT', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-REASON_FINAL').
-define('DIAMETER_TRAVELPING_REPORTING-REASON_FINAL', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-REASON_QUOTA_EXHAUSTED').
-define('DIAMETER_TRAVELPING_REPORTING-REASON_QUOTA_EXHAUSTED', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-REASON_VALIDITY_TIME').
-define('DIAMETER_TRAVELPING_REPORTING-REASON_VALIDITY_TIME', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-REASON_OTHER_QUOTA_TYPE').
-define('DIAMETER_TRAVELPING_REPORTING-REASON_OTHER_QUOTA_TYPE', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-REASON_RATING_CONDITION_CHANGE').
-define('DIAMETER_TRAVELPING_REPORTING-REASON_RATING_CONDITION_CHANGE', 6).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-REASON_FORCED_REAUTHORISATION').
-define('DIAMETER_TRAVELPING_REPORTING-REASON_FORCED_REAUTHORISATION', 7).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-REASON_POOL_EXHAUSTED').
-define('DIAMETER_TRAVELPING_REPORTING-REASON_POOL_EXHAUSTED', 8).
-endif.
-ifndef('DIAMETER_TRAVELPING_REPORTING-REASON_UNUSED_QUOTA_TIMER').
-define('DIAMETER_TRAVELPING_REPORTING-REASON_UNUSED_QUOTA_TIMER', 9).
-endif.
-ifndef('DIAMETER_TRAVELPING_ROLE-OF-NODE_ORIGINATING_ROLE').
-define('DIAMETER_TRAVELPING_ROLE-OF-NODE_ORIGINATING_ROLE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ROLE-OF-NODE_TERMINATING_ROLE').
-define('DIAMETER_TRAVELPING_ROLE-OF-NODE_TERMINATING_ROLE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ROLE-OF-NODE_FORWARDING_ROLE').
-define('DIAMETER_TRAVELPING_ROLE-OF-NODE_FORWARDING_ROLE', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_ROLE-OF-PROSE-FUNCTION_HPLMN').
-define('DIAMETER_TRAVELPING_ROLE-OF-PROSE-FUNCTION_HPLMN', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_ROLE-OF-PROSE-FUNCTION_VPLMN').
-define('DIAMETER_TRAVELPING_ROLE-OF-PROSE-FUNCTION_VPLMN', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_ROLE-OF-PROSE-FUNCTION_LOCAL-PLMN').
-define('DIAMETER_TRAVELPING_ROLE-OF-PROSE-FUNCTION_LOCAL-PLMN', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_SDP-TYPE_SDP-OFFER').
-define('DIAMETER_TRAVELPING_SDP-TYPE_SDP-OFFER', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SDP-TYPE_SDP-ANSWER').
-define('DIAMETER_TRAVELPING_SDP-TYPE_SDP-ANSWER', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_SESSION-DIRECTION_INBOUND').
-define('DIAMETER_TRAVELPING_SESSION-DIRECTION_INBOUND', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SESSION-DIRECTION_OUTBOUND').
-define('DIAMETER_TRAVELPING_SESSION-DIRECTION_OUTBOUND', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_SGSN').
-define('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_SGSN', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_PMIPSGW').
-define('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_PMIPSGW', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_GTPSGW').
-define('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_GTPSGW', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_EPDG').
-define('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_EPDG', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_HSGW').
-define('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_HSGW', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_MME').
-define('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_MME', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_TWAN').
-define('DIAMETER_TRAVELPING_SERVING-NODE-TYPE_TWAN', 6).
-endif.
-ifndef('DIAMETER_TRAVELPING_SGI-PTP-TUNNELLING-METHOD_UDP_IP_BASED').
-define('DIAMETER_TRAVELPING_SGI-PTP-TUNNELLING-METHOD_UDP_IP_BASED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SGI-PTP-TUNNELLING-METHOD_OTHERS').
-define('DIAMETER_TRAVELPING_SGI-PTP-TUNNELLING-METHOD_OTHERS', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_SGW-CHANGE_ACR_START_NOT_DUE_TO_SGW_CHANGE').
-define('DIAMETER_TRAVELPING_SGW-CHANGE_ACR_START_NOT_DUE_TO_SGW_CHANGE', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SGW-CHANGE_ACR_START_DUE_TO_SGW_CHANGE').
-define('DIAMETER_TRAVELPING_SGW-CHANGE_ACR_START_DUE_TO_SGW_CHANGE', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-DEVICE-TRIGGER-INDICATOR_NOT-DEVICETRIGGER').
-define('DIAMETER_TRAVELPING_SM-DEVICE-TRIGGER-INDICATOR_NOT-DEVICETRIGGER', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-DEVICE-TRIGGER-INDICATOR_DEVICE-TRIGGER-REQUEST').
-define('DIAMETER_TRAVELPING_SM-DEVICE-TRIGGER-INDICATOR_DEVICE-TRIGGER-REQUEST', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-DEVICE-TRIGGER-INDICATOR_DEVICE-TRIGGER-REPLACE').
-define('DIAMETER_TRAVELPING_SM-DEVICE-TRIGGER-INDICATOR_DEVICE-TRIGGER-REPLACE', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-DEVICE-TRIGGER-INDICATOR_DEVICE-TRIGGER-RECALL').
-define('DIAMETER_TRAVELPING_SM-DEVICE-TRIGGER-INDICATOR_DEVICE-TRIGGER-RECALL', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_SUBMISSION').
-define('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_SUBMISSION', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_DELIVERY_REPORT').
-define('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_DELIVERY_REPORT', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_SM-SERVICE-REQUEST').
-define('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_SM-SERVICE-REQUEST', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_T4-DEVICE-TRIGGER').
-define('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_T4-DEVICE-TRIGGER', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_SM-DEVICE-TRIGGER').
-define('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_SM-DEVICE-TRIGGER', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_MO-SMS-T4-SUBMISSION').
-define('DIAMETER_TRAVELPING_SM-MESSAGE-TYPE_MO-SMS-T4-SUBMISSION', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_SMS-NODE_SMS-ROUTER').
-define('DIAMETER_TRAVELPING_SMS-NODE_SMS-ROUTER', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SMS-NODE_IP-SM-GW').
-define('DIAMETER_TRAVELPING_SMS-NODE_IP-SM-GW', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_SMS-NODE_SMS-ROUTER-AND-IP-SM-GW').
-define('DIAMETER_TRAVELPING_SMS-NODE_SMS-ROUTER-AND-IP-SM-GW', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_SMS-NODE_SMS-SC').
-define('DIAMETER_TRAVELPING_SMS-NODE_SMS-SC', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-CONTENT-PROCESSING').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-CONTENT-PROCESSING', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-FORWARDING').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-FORWARDING', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-FORWARDING-MULTIPLE-SUBSCRIPTIONS').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-FORWARDING-MULTIPLE-SUBSCRIPTIONS', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-FILTERING').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-FILTERING', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-RECEIPT').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-RECEIPT', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-NETWORK-STORAGE').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-NETWORK-STORAGE', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-TO-MULTIPLE-DESTINATIONS').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-TO-MULTIPLE-DESTINATIONS', 6).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-VIRTUAL-PRIVATE-NETWORK').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-VIRTUAL-PRIVATE-NETWORK', 7).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-AUTO-REPLY').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-AUTO-REPLY', 8).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-PERSONAL-SIGNATURE').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-PERSONAL-SIGNATURE', 9).
-endif.
-ifndef('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-DEFERRED-DELIVERY').
-define('DIAMETER_TRAVELPING_SM-SERVICE-TYPE_VAS4SMS-SHORT-MESSAGE-DEFERRED-DELIVERY', 10).
-endif.
-ifndef('DIAMETER_TRAVELPING_STATUS-AS-CODE_4XX').
-define('DIAMETER_TRAVELPING_STATUS-AS-CODE_4XX', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_STATUS-AS-CODE_5XX').
-define('DIAMETER_TRAVELPING_STATUS-AS-CODE_5XX', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_STATUS-AS-CODE_TIMEOUT').
-define('DIAMETER_TRAVELPING_STATUS-AS-CODE_TIMEOUT', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_SUBSCRIBER-ROLE_ORIGINATING').
-define('DIAMETER_TRAVELPING_SUBSCRIBER-ROLE_ORIGINATING', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_SUBSCRIBER-ROLE_TERMINATING').
-define('DIAMETER_TRAVELPING_SUBSCRIBER-ROLE_TERMINATING', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_TAD-IDENTIFIER_CS').
-define('DIAMETER_TRAVELPING_TAD-IDENTIFIER_CS', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_TAD-IDENTIFIER_PS').
-define('DIAMETER_TRAVELPING_TAD-IDENTIFIER_PS', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_TIME-QUOTA-TYPE_DISCRETE_TIME_PERIOD').
-define('DIAMETER_TRAVELPING_TIME-QUOTA-TYPE_DISCRETE_TIME_PERIOD', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_TIME-QUOTA-TYPE_CONTINUOUS_TIME_PERIOD').
-define('DIAMETER_TRAVELPING_TIME-QUOTA-TYPE_CONTINUOUS_TIME_PERIOD', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRANSCODER-INSERTED-INDICATION_TRANSCODER-NOT-INSERTED').
-define('DIAMETER_TRAVELPING_TRANSCODER-INSERTED-INDICATION_TRANSCODER-NOT-INSERTED', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRANSCODER-INSERTED-INDICATION_TRANSCODER-INSERTED').
-define('DIAMETER_TRAVELPING_TRANSCODER-INSERTED-INDICATION_TRANSCODER-INSERTED', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_SGSN_IP_ADDRESS').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_SGSN_IP_ADDRESS', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_QOS').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_QOS', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_LOCATION').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_LOCATION', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_RAT').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_RAT', 4).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_UE_TIMEZONE').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_UE_TIMEZONE', 5).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_TRAFFIC_CLASS').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_TRAFFIC_CLASS', 10).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_RELIABILITY_CLASS').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_RELIABILITY_CLASS', 11).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_DELAY_CLASS').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_DELAY_CLASS', 12).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_PEAK_THROUGHPUT').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_PEAK_THROUGHPUT', 13).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_PRECEDENCE_CLASS').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_PRECEDENCE_CLASS', 14).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_MEAN_THROUGHPUT').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_MEAN_THROUGHPUT', 15).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_MAXIMUM_BIT_RATE_FOR_UPLINK').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_MAXIMUM_BIT_RATE_FOR_UPLINK', 16).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_MAXIMUM_BIT_RATE_FOR_DOWNLINK').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_MAXIMUM_BIT_RATE_FOR_DOWNLINK', 17).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_RESIDUAL_BER').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_RESIDUAL_BER', 18).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_SDU_ERROR_RATIO').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_SDU_ERROR_RATIO', 19).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_TRANSFER_DELAY').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_TRANSFER_DELAY', 20).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_TRAFFIC_HANDLING_PRIORITY').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_TRAFFIC_HANDLING_PRIORITY', 21).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_GUARANTEED_BIT_RATE_FOR_UPLINK').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_GUARANTEED_BIT_RATE_FOR_UPLINK', 22).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_GUARANTEED_BIT_RATE_FOR_DOWNLINK').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_GUARANTEED_BIT_RATE_FOR_DOWNLINK', 23).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_APN_AGGREGATE_MAXIMUM_BIT_RATE').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINQOS_APN_AGGREGATE_MAXIMUM_BIT_RATE', 24).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_MCC').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_MCC', 30).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_MNC').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_MNC', 31).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_RAC').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_RAC', 32).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_LAC').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_LAC', 33).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_CELLID').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_CELLID', 34).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_TAC').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_TAC', 35).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_ECGI').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGEINLOCATION_ECGI', 36).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_MEDIA_COMPOSITION').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_MEDIA_COMPOSITION', 40).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_PARTICIPANTS_NMB').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_PARTICIPANTS_NMB', 50).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_THRSHLD_OF_PARTICIPANTS_NMB').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_THRSHLD_OF_PARTICIPANTS_NMB', 51).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_USER_PARTICIPATING_TYPE').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_USER_PARTICIPATING_TYPE', 52).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_SERVICE_CONDITION').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_SERVICE_CONDITION', 60).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_SERVING_NODE').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_SERVING_NODE', 61).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_ACCESS_FOR_A_SERVICE_DATA_FLOW').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_ACCESS_FOR_A_SERVICE_DATA_FLOW', 62).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_USER_CSG_INFORMATION').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_USER_CSG_INFORMATION', 70).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_HYBRID_SUBSCRIBED_USER_CSG_INFORMATION').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_HYBRID_SUBSCRIBED_USER_CSG_INFORMATION', 71).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_HYBRID_UNSUBSCRIBED_USER_CSG_INFORMATION').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_HYBRID_UNSUBSCRIBED_USER_CSG_INFORMATION', 72).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_OF_UE_PRESENCE_IN_PRESENCE_REPORTING_AREA').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_OF_UE_PRESENCE_IN_PRESENCE_REPORTING_AREA', 73).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_APN_RATE_CONTROL').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_APN_RATE_CONTROL', 75).
-endif.
-ifndef('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_3GPP_PS_DATA_OFF').
-define('DIAMETER_TRAVELPING_TRIGGER-TYPE_CHANGE_IN_3GPP_PS_DATA_OFF', 76).
-endif.
-ifndef('DIAMETER_TRAVELPING_UNI-PDU-CP-ONLY-FLAG_UNI-PDU-BOTH-UP-CP').
-define('DIAMETER_TRAVELPING_UNI-PDU-CP-ONLY-FLAG_UNI-PDU-BOTH-UP-CP', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_UNI-PDU-CP-ONLY-FLAG_UNI-PDU-CP-ONLY').
-define('DIAMETER_TRAVELPING_UNI-PDU-CP-ONLY-FLAG_UNI-PDU-CP-ONLY', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_USER-PARTICIPATING-TYPE_NORMAL').
-define('DIAMETER_TRAVELPING_USER-PARTICIPATING-TYPE_NORMAL', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_USER-PARTICIPATING-TYPE_NW-POC-BOX').
-define('DIAMETER_TRAVELPING_USER-PARTICIPATING-TYPE_NW-POC-BOX', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_USER-PARTICIPATING-TYPE_UE-POC-BOX').
-define('DIAMETER_TRAVELPING_USER-PARTICIPATING-TYPE_UE-POC-BOX', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_VARIABLE-PART-TYPE_INTEGER').
-define('DIAMETER_TRAVELPING_VARIABLE-PART-TYPE_INTEGER', 0).
-endif.
-ifndef('DIAMETER_TRAVELPING_VARIABLE-PART-TYPE_NUMBER').
-define('DIAMETER_TRAVELPING_VARIABLE-PART-TYPE_NUMBER', 1).
-endif.
-ifndef('DIAMETER_TRAVELPING_VARIABLE-PART-TYPE_TIME').
-define('DIAMETER_TRAVELPING_VARIABLE-PART-TYPE_TIME', 2).
-endif.
-ifndef('DIAMETER_TRAVELPING_VARIABLE-PART-TYPE_DATE').
-define('DIAMETER_TRAVELPING_VARIABLE-PART-TYPE_DATE', 3).
-endif.
-ifndef('DIAMETER_TRAVELPING_VARIABLE-PART-TYPE_CURRENCY').
-define('DIAMETER_TRAVELPING_VARIABLE-PART-TYPE_CURRENCY', 4).
-endif.

