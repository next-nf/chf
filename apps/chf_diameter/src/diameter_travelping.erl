%% -------------------------------------------------------------------
%% This is a generated file.
%% -------------------------------------------------------------------

-module(diameter_travelping).

-moduledoc(false).

-compile({parse_transform, diameter_exprecs}).

-compile(nowarn_unused_function).

-dialyzer(no_return).

-export_records(['diameter_travelping_TP-Previous-PS-Information',
                 'diameter_travelping_Access-Network-Charging-Identifier-Gx',
                 'diameter_travelping_Allocation-Retention-Priority',
                 'diameter_travelping_Application-Detection-Information',
                 'diameter_travelping_Charging-Rule-Definition',
                 'diameter_travelping_Charging-Rule-Install',
                 'diameter_travelping_Charging-Rule-Remove',
                 'diameter_travelping_Charging-Rule-Report',
                 'diameter_travelping_CoA-Information',
                 'diameter_travelping_Conditional-APN-Aggregate-Max-Bitrate',
                 'diameter_travelping_Default-EPS-Bearer-QoS',
                 'diameter_travelping_Default-QoS-Information',
                 'diameter_travelping_Event-Report-Indication',
                 'diameter_travelping_Fixed-User-Location-Info',
                 'diameter_travelping_Flow-Information',
                 'diameter_travelping_Packet-Filter-Information',
                 'diameter_travelping_Presence-Reporting-Area-Information',
                 'diameter_travelping_QoS-Information',
                 'diameter_travelping_Redirect-Information',
                 'diameter_travelping_Routing-Filter',
                 'diameter_travelping_Routing-Rule-Definition',
                 'diameter_travelping_Routing-Rule-Install',
                 'diameter_travelping_Routing-Rule-Remove',
                 'diameter_travelping_TDF-Information',
                 'diameter_travelping_Tunnel-Information',
                 'diameter_travelping_TFT-Packet-Filter-Information',
                 'diameter_travelping_Usage-Monitoring-Information',
                 'diameter_travelping_Access-Network-Info-Change',
                 'diameter_travelping_Access-Transfer-Information',
                 'diameter_travelping_Accumulated-Cost',
                 'diameter_travelping_Additional-Content-Information',
                 'diameter_travelping_Address-Domain',
                 'diameter_travelping_AF-Correlation-Information',
                 'diameter_travelping_Announcement-Information',
                 'diameter_travelping_AoC-Cost-Information',
                 'diameter_travelping_AoC-Information',
                 'diameter_travelping_AoC-Service',
                 'diameter_travelping_AoC-Subscription-Information',
                 'diameter_travelping_APN-Rate-Control',
                 'diameter_travelping_APN-Rate-Control-Downlink',
                 'diameter_travelping_APN-Rate-Control-Uplink',
                 'diameter_travelping_Application-Server-Information',
                 'diameter_travelping_Basic-Service-Code',
                 'diameter_travelping_Called-Identity-Change',
                 'diameter_travelping_Coverage-Info',
                 'diameter_travelping_CPDT-Information',
                 'diameter_travelping_Current-Tariff',
                 'diameter_travelping_Destination-Interface',
                 'diameter_travelping_Early-Media-Description',
                 'diameter_travelping_Enhanced-Diagnostics',
                 diameter_travelping_Envelope,
                 'diameter_travelping_Event-Type',
                 'diameter_travelping_Incremental-Cost',
                 'diameter_travelping_IMS-Information',
                 'diameter_travelping_Inter-Operator-Identifier',
                 'diameter_travelping_ISUP-Cause',
                 'diameter_travelping_LCS-Client-ID',
                 'diameter_travelping_LCS-Client-Name',
                 'diameter_travelping_LCS-Information',
                 'diameter_travelping_LCS-Requestor-ID',
                 'diameter_travelping_Location-Info',
                 'diameter_travelping_Location-Type',
                 'diameter_travelping_MBMS-Information',
                 'diameter_travelping_Message-Body',
                 'diameter_travelping_Message-Class',
                 'diameter_travelping_MM-Content-Type',
                 'diameter_travelping_MMS-Information',
                 'diameter_travelping_MMTel-Information',
                 'diameter_travelping_Monitoring-Event-Information',
                 'diameter_travelping_Monitoring-Event-Report-Data',
                 'diameter_travelping_Next-Tariff',
                 'diameter_travelping_NIDD-Submission',
                 'diameter_travelping_NNI-Information',
                 'diameter_travelping_Offline-Charging',
                 'diameter_travelping_Originator-Address',
                 'diameter_travelping_Originator-Interface',
                 'diameter_travelping_Originator-Received-Address',
                 'diameter_travelping_Participant-Group',
                 'diameter_travelping_PoC-Information',
                 'diameter_travelping_PoC-User-Role',
                 'diameter_travelping_ProSe-Direct-Communication-Reception-Data-Container',
                 'diameter_travelping_ProSe-Direct-Communication-Transmission-Data-Container',
                 'diameter_travelping_ProSe-Information',
                 'diameter_travelping_PS-Furnish-Charging-Information',
                 'diameter_travelping_PS-Information',
                 'diameter_travelping_Radio-Parameter-Set-Info',
                 'diameter_travelping_RAN-Secondary-RAT-Usage-Report',
                 'diameter_travelping_Rate-Element',
                 'diameter_travelping_Real-Time-Tariff-Information',
                 'diameter_travelping_Recipient-Address',
                 'diameter_travelping_Recipient-Info',
                 'diameter_travelping_Recipient-Received-Address',
                 'diameter_travelping_Related-Change-Condition-Information',
                 'diameter_travelping_Related-Trigger',
                 'diameter_travelping_Remaining-Balance',
                 'diameter_travelping_Scale-Factor',
                 'diameter_travelping_SCS-AS-Address',
                 'diameter_travelping_SDP-Media-Component',
                 'diameter_travelping_SDP-TimeStamps',
                 'diameter_travelping_Service-Data-Container',
                 'diameter_travelping_Service-Specific-Info',
                 'diameter_travelping_SM-Device-Trigger-Information',
                 'diameter_travelping_SMS-Information',
                 'diameter_travelping_Supplementary-Service',
                 'diameter_travelping_Talk-Burst-Exchange',
                 'diameter_travelping_Tariff-Information',
                 'diameter_travelping_Time-Quota-Mechanism',
                 'diameter_travelping_Time-Stamps',
                 'diameter_travelping_Traffic-Data-Volumes',
                 'diameter_travelping_Transmitter-Info',
                 diameter_travelping_Trigger,
                 'diameter_travelping_Trunk-Group-Id',
                 'diameter_travelping_TWAN-User-Location-Info',
                 'diameter_travelping_Unit-Cost',
                 'diameter_travelping_User-CSG-Information',
                 'diameter_travelping_UWAN-User-Location-Info',
                 'diameter_travelping_Variable-Part',
                 'diameter_travelping_VCS-Information']).

-record('diameter_travelping_TP-Previous-PS-Information',
        {'QoS-Information' = [],
         'SGSN-Address' = [],
         '3GPP-SGSN-MCC-MNC' = [],
         '3GPP-MS-TimeZone' = [],
         '3GPP-User-Location-Info' = [],
         '3GPP-RAT-Type' = [],
         'AVP' = []}).

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

name() -> diameter_travelping.

id() -> 1.

vendor_id() -> 18681.

vendor_name() -> 'Travelping'.

msg_name(_, _) -> ''.

msg_header(_) -> erlang:error(badarg).

rec2msg(_) -> erlang:error(badarg).

msg2rec(_) -> erlang:error(badarg).

name2rec('TP-Previous-PS-Information') ->
    'diameter_travelping_TP-Previous-PS-Information';
name2rec('Access-Network-Charging-Identifier-Gx') ->
    'diameter_travelping_Access-Network-Charging-Identifier-Gx';
name2rec('Allocation-Retention-Priority') ->
    'diameter_travelping_Allocation-Retention-Priority';
name2rec('Application-Detection-Information') ->
    'diameter_travelping_Application-Detection-Information';
name2rec('Charging-Rule-Definition') ->
    'diameter_travelping_Charging-Rule-Definition';
name2rec('Charging-Rule-Install') ->
    'diameter_travelping_Charging-Rule-Install';
name2rec('Charging-Rule-Remove') ->
    'diameter_travelping_Charging-Rule-Remove';
name2rec('Charging-Rule-Report') ->
    'diameter_travelping_Charging-Rule-Report';
name2rec('CoA-Information') ->
    'diameter_travelping_CoA-Information';
name2rec('Conditional-APN-Aggregate-Max-Bitrate') ->
    'diameter_travelping_Conditional-APN-Aggregate-Max-Bitrate';
name2rec('Default-EPS-Bearer-QoS') ->
    'diameter_travelping_Default-EPS-Bearer-QoS';
name2rec('Default-QoS-Information') ->
    'diameter_travelping_Default-QoS-Information';
name2rec('Event-Report-Indication') ->
    'diameter_travelping_Event-Report-Indication';
name2rec('Fixed-User-Location-Info') ->
    'diameter_travelping_Fixed-User-Location-Info';
name2rec('Flow-Information') ->
    'diameter_travelping_Flow-Information';
name2rec('Packet-Filter-Information') ->
    'diameter_travelping_Packet-Filter-Information';
name2rec('Presence-Reporting-Area-Information') ->
    'diameter_travelping_Presence-Reporting-Area-Information';
name2rec('QoS-Information') ->
    'diameter_travelping_QoS-Information';
name2rec('Redirect-Information') ->
    'diameter_travelping_Redirect-Information';
name2rec('Routing-Filter') ->
    'diameter_travelping_Routing-Filter';
name2rec('Routing-Rule-Definition') ->
    'diameter_travelping_Routing-Rule-Definition';
name2rec('Routing-Rule-Install') ->
    'diameter_travelping_Routing-Rule-Install';
name2rec('Routing-Rule-Remove') ->
    'diameter_travelping_Routing-Rule-Remove';
name2rec('TDF-Information') ->
    'diameter_travelping_TDF-Information';
name2rec('Tunnel-Information') ->
    'diameter_travelping_Tunnel-Information';
name2rec('TFT-Packet-Filter-Information') ->
    'diameter_travelping_TFT-Packet-Filter-Information';
name2rec('Usage-Monitoring-Information') ->
    'diameter_travelping_Usage-Monitoring-Information';
name2rec('Access-Network-Info-Change') ->
    'diameter_travelping_Access-Network-Info-Change';
name2rec('Access-Transfer-Information') ->
    'diameter_travelping_Access-Transfer-Information';
name2rec('Accumulated-Cost') ->
    'diameter_travelping_Accumulated-Cost';
name2rec('Additional-Content-Information') ->
    'diameter_travelping_Additional-Content-Information';
name2rec('Address-Domain') ->
    'diameter_travelping_Address-Domain';
name2rec('AF-Correlation-Information') ->
    'diameter_travelping_AF-Correlation-Information';
name2rec('Announcement-Information') ->
    'diameter_travelping_Announcement-Information';
name2rec('AoC-Cost-Information') ->
    'diameter_travelping_AoC-Cost-Information';
name2rec('AoC-Information') ->
    'diameter_travelping_AoC-Information';
name2rec('AoC-Service') ->
    'diameter_travelping_AoC-Service';
name2rec('AoC-Subscription-Information') ->
    'diameter_travelping_AoC-Subscription-Information';
name2rec('APN-Rate-Control') ->
    'diameter_travelping_APN-Rate-Control';
name2rec('APN-Rate-Control-Downlink') ->
    'diameter_travelping_APN-Rate-Control-Downlink';
name2rec('APN-Rate-Control-Uplink') ->
    'diameter_travelping_APN-Rate-Control-Uplink';
name2rec('Application-Server-Information') ->
    'diameter_travelping_Application-Server-Information';
name2rec('Basic-Service-Code') ->
    'diameter_travelping_Basic-Service-Code';
name2rec('Called-Identity-Change') ->
    'diameter_travelping_Called-Identity-Change';
name2rec('Coverage-Info') ->
    'diameter_travelping_Coverage-Info';
name2rec('CPDT-Information') ->
    'diameter_travelping_CPDT-Information';
name2rec('Current-Tariff') ->
    'diameter_travelping_Current-Tariff';
name2rec('Destination-Interface') ->
    'diameter_travelping_Destination-Interface';
name2rec('Early-Media-Description') ->
    'diameter_travelping_Early-Media-Description';
name2rec('Enhanced-Diagnostics') ->
    'diameter_travelping_Enhanced-Diagnostics';
name2rec('Envelope') -> diameter_travelping_Envelope;
name2rec('Event-Type') ->
    'diameter_travelping_Event-Type';
name2rec('Incremental-Cost') ->
    'diameter_travelping_Incremental-Cost';
name2rec('IMS-Information') ->
    'diameter_travelping_IMS-Information';
name2rec('Inter-Operator-Identifier') ->
    'diameter_travelping_Inter-Operator-Identifier';
name2rec('ISUP-Cause') ->
    'diameter_travelping_ISUP-Cause';
name2rec('LCS-Client-ID') ->
    'diameter_travelping_LCS-Client-ID';
name2rec('LCS-Client-Name') ->
    'diameter_travelping_LCS-Client-Name';
name2rec('LCS-Information') ->
    'diameter_travelping_LCS-Information';
name2rec('LCS-Requestor-ID') ->
    'diameter_travelping_LCS-Requestor-ID';
name2rec('Location-Info') ->
    'diameter_travelping_Location-Info';
name2rec('Location-Type') ->
    'diameter_travelping_Location-Type';
name2rec('MBMS-Information') ->
    'diameter_travelping_MBMS-Information';
name2rec('Message-Body') ->
    'diameter_travelping_Message-Body';
name2rec('Message-Class') ->
    'diameter_travelping_Message-Class';
name2rec('MM-Content-Type') ->
    'diameter_travelping_MM-Content-Type';
name2rec('MMS-Information') ->
    'diameter_travelping_MMS-Information';
name2rec('MMTel-Information') ->
    'diameter_travelping_MMTel-Information';
name2rec('Monitoring-Event-Information') ->
    'diameter_travelping_Monitoring-Event-Information';
name2rec('Monitoring-Event-Report-Data') ->
    'diameter_travelping_Monitoring-Event-Report-Data';
name2rec('Next-Tariff') ->
    'diameter_travelping_Next-Tariff';
name2rec('NIDD-Submission') ->
    'diameter_travelping_NIDD-Submission';
name2rec('NNI-Information') ->
    'diameter_travelping_NNI-Information';
name2rec('Offline-Charging') ->
    'diameter_travelping_Offline-Charging';
name2rec('Originator-Address') ->
    'diameter_travelping_Originator-Address';
name2rec('Originator-Interface') ->
    'diameter_travelping_Originator-Interface';
name2rec('Originator-Received-Address') ->
    'diameter_travelping_Originator-Received-Address';
name2rec('Participant-Group') ->
    'diameter_travelping_Participant-Group';
name2rec('PoC-Information') ->
    'diameter_travelping_PoC-Information';
name2rec('PoC-User-Role') ->
    'diameter_travelping_PoC-User-Role';
name2rec('ProSe-Direct-Communication-Reception-Data-Container') ->
    'diameter_travelping_ProSe-Direct-Communication-Reception-Data-Container';
name2rec('ProSe-Direct-Communication-Transmission-Data-Container') ->
    'diameter_travelping_ProSe-Direct-Communication-Transmission-Data-Container';
name2rec('ProSe-Information') ->
    'diameter_travelping_ProSe-Information';
name2rec('PS-Furnish-Charging-Information') ->
    'diameter_travelping_PS-Furnish-Charging-Information';
name2rec('PS-Information') ->
    'diameter_travelping_PS-Information';
name2rec('Radio-Parameter-Set-Info') ->
    'diameter_travelping_Radio-Parameter-Set-Info';
name2rec('RAN-Secondary-RAT-Usage-Report') ->
    'diameter_travelping_RAN-Secondary-RAT-Usage-Report';
name2rec('Rate-Element') ->
    'diameter_travelping_Rate-Element';
name2rec('Real-Time-Tariff-Information') ->
    'diameter_travelping_Real-Time-Tariff-Information';
name2rec('Recipient-Address') ->
    'diameter_travelping_Recipient-Address';
name2rec('Recipient-Info') ->
    'diameter_travelping_Recipient-Info';
name2rec('Recipient-Received-Address') ->
    'diameter_travelping_Recipient-Received-Address';
name2rec('Related-Change-Condition-Information') ->
    'diameter_travelping_Related-Change-Condition-Information';
name2rec('Related-Trigger') ->
    'diameter_travelping_Related-Trigger';
name2rec('Remaining-Balance') ->
    'diameter_travelping_Remaining-Balance';
name2rec('Scale-Factor') ->
    'diameter_travelping_Scale-Factor';
name2rec('SCS-AS-Address') ->
    'diameter_travelping_SCS-AS-Address';
name2rec('SDP-Media-Component') ->
    'diameter_travelping_SDP-Media-Component';
name2rec('SDP-TimeStamps') ->
    'diameter_travelping_SDP-TimeStamps';
name2rec('Service-Data-Container') ->
    'diameter_travelping_Service-Data-Container';
name2rec('Service-Specific-Info') ->
    'diameter_travelping_Service-Specific-Info';
name2rec('SM-Device-Trigger-Information') ->
    'diameter_travelping_SM-Device-Trigger-Information';
name2rec('SMS-Information') ->
    'diameter_travelping_SMS-Information';
name2rec('Supplementary-Service') ->
    'diameter_travelping_Supplementary-Service';
name2rec('Talk-Burst-Exchange') ->
    'diameter_travelping_Talk-Burst-Exchange';
name2rec('Tariff-Information') ->
    'diameter_travelping_Tariff-Information';
name2rec('Time-Quota-Mechanism') ->
    'diameter_travelping_Time-Quota-Mechanism';
name2rec('Time-Stamps') ->
    'diameter_travelping_Time-Stamps';
name2rec('Traffic-Data-Volumes') ->
    'diameter_travelping_Traffic-Data-Volumes';
name2rec('Transmitter-Info') ->
    'diameter_travelping_Transmitter-Info';
name2rec('Trigger') -> diameter_travelping_Trigger;
name2rec('Trunk-Group-Id') ->
    'diameter_travelping_Trunk-Group-Id';
name2rec('TWAN-User-Location-Info') ->
    'diameter_travelping_TWAN-User-Location-Info';
name2rec('Unit-Cost') ->
    'diameter_travelping_Unit-Cost';
name2rec('User-CSG-Information') ->
    'diameter_travelping_User-CSG-Information';
name2rec('UWAN-User-Location-Info') ->
    'diameter_travelping_UWAN-User-Location-Info';
name2rec('Variable-Part') ->
    'diameter_travelping_Variable-Part';
name2rec('VCS-Information') ->
    'diameter_travelping_VCS-Information';
name2rec(T) -> msg2rec(T).

avp_name(16, 18681) ->
    {'TP-NAT-IP-Address', 'OctetString'};
avp_name(27, 18681) -> {'TP-NAT-Pool-Id', 'UTF8String'};
avp_name(29, 18681) ->
    {'TP-NAT-Port-End', 'Unsigned32'};
avp_name(28, 18681) ->
    {'TP-NAT-Port-Start', 'Unsigned32'};
avp_name(64, 18681) ->
    {'TP-Previous-PS-Information', 'Grouped'};
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
avp_name(1050, 10415) -> {'AN-GW-Address', 'Address'};
avp_name(2811, 10415) -> {'AN-GW-Status', 'Enumerated'};
avp_name(1040, 10415) ->
    {'APN-Aggregate-Max-Bitrate-DL', 'Unsigned32'};
avp_name(1041, 10415) ->
    {'APN-Aggregate-Max-Bitrate-UL', 'Unsigned32'};
avp_name(1022, 10415) ->
    {'Access-Network-Charging-Identifier-Gx', 'Grouped'};
avp_name(1034, 10415) ->
    {'Allocation-Retention-Priority', 'Grouped'};
avp_name(1098, 10415) ->
    {'Application-Detection-Information', 'Grouped'};
avp_name(1023, 10415) ->
    {'Bearer-Control-Mode', 'Enumerated'};
avp_name(1020, 10415) ->
    {'Bearer-Identifier', 'OctetString'};
avp_name(1021, 10415) ->
    {'Bearer-Operation', 'Enumerated'};
avp_name(1000, 10415) -> {'Bearer-Usage', 'Enumerated'};
avp_name(1071, 10415) ->
    {'CSG-Information-Reporting', 'Enumerated'};
avp_name(1073, 10415) ->
    {'Charging-Correlation-Indicator', 'Enumerated'};
avp_name(1004, 10415) ->
    {'Charging-Rule-Base-Name', 'UTF8String'};
avp_name(1003, 10415) ->
    {'Charging-Rule-Definition', 'Grouped'};
avp_name(1001, 10415) ->
    {'Charging-Rule-Install', 'Grouped'};
avp_name(1005, 10415) ->
    {'Charging-Rule-Name', 'OctetString'};
avp_name(1002, 10415) ->
    {'Charging-Rule-Remove', 'Grouped'};
avp_name(1018, 10415) ->
    {'Charging-Rule-Report', 'Grouped'};
avp_name(1035, 10415) -> {'CoA-IP-Address', 'Address'};
avp_name(1039, 10415) -> {'CoA-Information', 'Grouped'};
avp_name(2818, 10415) ->
    {'Conditional-APN-Aggregate-Max-Bitrate', 'Grouped'};
avp_name(1082, 10415) ->
    {'Credit-Management-Status', 'Unsigned32'};
avp_name(1049, 10415) ->
    {'Default-EPS-Bearer-QoS', 'Grouped'};
avp_name(2816, 10415) ->
    {'Default-QoS-Information', 'Grouped'};
avp_name(2817, 10415) ->
    {'Default-QoS-Name', 'UTF8String'};
avp_name(1033, 10415) ->
    {'Event-Report-Indication', 'Grouped'};
avp_name(1006, 10415) ->
    {'Event-Trigger', 'Enumerated'};
avp_name(2825, 10415) ->
    {'Fixed-User-Location-Info', 'Grouped'};
avp_name(1080, 10415) ->
    {'Flow-Direction', 'Enumerated'};
avp_name(1058, 10415) ->
    {'Flow-Information', 'Grouped'};
avp_name(1057, 10415) -> {'Flow-Label', 'OctetString'};
avp_name(1025, 10415) ->
    {'Guaranteed-Bitrate-DL', 'Unsigned32'};
avp_name(1026, 10415) ->
    {'Guaranteed-Bitrate-UL', 'Unsigned32'};
avp_name(2804, 10415) ->
    {'HeNB-Local-IP-Address', 'Address'};
avp_name(2827, 10415) ->
    {'IP-CAN-Session-Charging-Scope', 'Enumerated'};
avp_name(1027, 10415) -> {'IP-CAN-Type', 'Enumerated'};
avp_name(1007, 10415) ->
    {'Metering-Method', 'Enumerated'};
avp_name(1066, 10415) ->
    {'Monitoring-Key', 'OctetString'};
avp_name(2810, 10415) -> {'Monitoring-Time', 'Time'};
avp_name(2809, 10415) ->
    {'Mute-Notification', 'Enumerated'};
avp_name(2824, 10415) ->
    {'NetLoc-Access-Support', 'Unsigned32'};
avp_name(1024, 10415) ->
    {'Network-Request-Support', 'Enumerated'};
avp_name(1008, 10415) -> {'Offline', 'Enumerated'};
avp_name(1009, 10415) -> {'Online', 'Enumerated'};
avp_name(1019, 10415) ->
    {'PCC-Rule-Status', 'Enumerated'};
avp_name(2826, 10415) ->
    {'PCSCF-Restoration-Indication', 'Unsigned32'};
avp_name(1065, 10415) ->
    {'PDN-Connection-ID', 'OctetString'};
avp_name(1099, 10415) ->
    {'PS-to-CS-Session-Continuity', 'Enumerated'};
avp_name(1059, 10415) ->
    {'Packet-Filter-Content', 'IPFilterRule'};
avp_name(1060, 10415) ->
    {'Packet-Filter-Identifier', 'OctetString'};
avp_name(1061, 10415) ->
    {'Packet-Filter-Information', 'Grouped'};
avp_name(1062, 10415) ->
    {'Packet-Filter-Operation', 'Enumerated'};
avp_name(1072, 10415) ->
    {'Packet-Filter-Usage', 'Enumerated'};
avp_name(1047, 10415) ->
    {'Pre-emption-Capability', 'Enumerated'};
avp_name(1048, 10415) ->
    {'Pre-emption-Vulnerability', 'Enumerated'};
avp_name(1010, 10415) -> {'Precedence', 'Unsigned32'};
avp_name(2820, 10415) ->
    {'Presence-Reporting-Area-Elements-List',
     'OctetString'};
avp_name(2821, 10415) ->
    {'Presence-Reporting-Area-Identifier', 'OctetString'};
avp_name(2822, 10415) ->
    {'Presence-Reporting-Area-Information', 'Grouped'};
avp_name(2823, 10415) ->
    {'Presence-Reporting-Area-Status', 'Unsigned32'};
avp_name(1046, 10415) ->
    {'Priority-Level', 'Unsigned32'};
avp_name(1028, 10415) ->
    {'QoS-Class-Identifier', 'Unsigned32'};
avp_name(1016, 10415) -> {'QoS-Information', 'Grouped'};
avp_name(1029, 10415) ->
    {'QoS-Negotiation', 'Enumerated'};
avp_name(1030, 10415) -> {'QoS-Upgrade', 'Enumerated'};
avp_name(2819, 10415) ->
    {'RAN-NAS-Release-Cause', 'OctetString'};
avp_name(1032, 10415) -> {'RAT-Type', 'Enumerated'};
avp_name(1085, 10415) ->
    {'Redirect-Information', 'Grouped'};
avp_name(1086, 10415) ->
    {'Redirect-Support', 'Enumerated'};
avp_name(1011, 10415) ->
    {'Reporting-Level', 'Enumerated'};
avp_name(1063, 10415) ->
    {'Resource-Allocation-Notification', 'Enumerated'};
avp_name(1042, 10415) -> {'Revalidation-Time', 'Time'};
avp_name(1078, 10415) -> {'Routing-Filter', 'Grouped'};
avp_name(1079, 10415) ->
    {'Routing-IP-Address', 'Address'};
avp_name(1076, 10415) ->
    {'Routing-Rule-Definition', 'Grouped'};
avp_name(1077, 10415) ->
    {'Routing-Rule-Identifier', 'OctetString'};
avp_name(1081, 10415) ->
    {'Routing-Rule-Install', 'Grouped'};
avp_name(1075, 10415) ->
    {'Routing-Rule-Remove', 'Grouped'};
avp_name(1043, 10415) ->
    {'Rule-Activation-Time', 'Time'};
avp_name(1044, 10415) ->
    {'Rule-Deactivation-Time', 'Time'};
avp_name(1031, 10415) ->
    {'Rule-Failure-Code', 'Enumerated'};
avp_name(1056, 10415) ->
    {'Security-Parameter-Index', 'OctetString'};
avp_name(1045, 10415) ->
    {'Session-Release-Cause', 'Enumerated'};
avp_name(1088, 10415) ->
    {'TDF-Application-Identifier', 'OctetString'};
avp_name(2802, 10415) ->
    {'TDF-Application-Instance-Identifier', 'OctetString'};
avp_name(1089, 10415) ->
    {'TDF-Destination-Host', 'DiameterIdentity'};
avp_name(1090, 10415) ->
    {'TDF-Destination-Realm', 'DiameterIdentity'};
avp_name(1091, 10415) -> {'TDF-IP-Address', 'Address'};
avp_name(1087, 10415) -> {'TDF-Information', 'Grouped'};
avp_name(1012, 10415) -> {'TFT-Filter', 'IPFilterRule'};
avp_name(1013, 10415) ->
    {'TFT-Packet-Filter-Information', 'Grouped'};
avp_name(1014, 10415) ->
    {'ToS-Traffic-Class', 'OctetString'};
avp_name(1036, 10415) ->
    {'Tunnel-Header-Filter', 'IPFilterRule'};
avp_name(1037, 10415) ->
    {'Tunnel-Header-Length', 'Unsigned32'};
avp_name(1038, 10415) ->
    {'Tunnel-Information', 'Grouped'};
avp_name(2806, 10415) ->
    {'UDP-Source-Port', 'Unsigned32'};
avp_name(2805, 10415) ->
    {'UE-Local-IP-Address', 'Address'};
avp_name(1067, 10415) ->
    {'Usage-Monitoring-Information', 'Grouped'};
avp_name(1068, 10415) ->
    {'Usage-Monitoring-Level', 'Enumerated'};
avp_name(1069, 10415) ->
    {'Usage-Monitoring-Report', 'Enumerated'};
avp_name(1070, 10415) ->
    {'Usage-Monitoring-Support', 'Enumerated'};
avp_name(2812, 10415) ->
    {'User-Location-Info-Time', 'Time'};
avp_name(4406, 10415) ->
    {'3GPP-PS-Data-Off-Status', 'Enumerated'};
avp_name(1276, 10415) ->
    {'AF-Correlation-Information', 'Grouped'};
avp_name(3933, 10415) ->
    {'APN-Rate-Control', 'Grouped'};
avp_name(3934, 10415) ->
    {'APN-Rate-Control-Downlink', 'Grouped'};
avp_name(3935, 10415) ->
    {'APN-Rate-Control-Uplink', 'Grouped'};
avp_name(4401, 10415) ->
    {'Access-Network-Info-Change', 'Grouped'};
avp_name(1263, 10415) ->
    {'Access-Network-Information', 'OctetString'};
avp_name(2709, 10415) ->
    {'Access-Transfer-Information', 'Grouped'};
avp_name(2710, 10415) ->
    {'Access-Transfer-Type', 'Enumerated'};
avp_name(2309, 10415) -> {'Account-Expiration', 'Time'};
avp_name(2052, 10415) ->
    {'Accumulated-Cost', 'Grouped'};
avp_name(1217, 10415) -> {'Adaptations', 'Enumerated'};
avp_name(1207, 10415) ->
    {'Additional-Content-Information', 'Grouped'};
avp_name(3936, 10415) ->
    {'Additional-Exception-Reports', 'Enumerated'};
avp_name(1205, 10415) ->
    {'Additional-Type-Information', 'UTF8String'};
avp_name(897, 10415) -> {'Address-Data', 'UTF8String'};
avp_name(898, 10415) -> {'Address-Domain', 'Grouped'};
avp_name(899, 10415) -> {'Address-Type', 'Enumerated'};
avp_name(1208, 10415) ->
    {'Addressee-Type', 'Enumerated'};
avp_name(1280, 10415) ->
    {'Alternate-Charged-Party-Address', 'UTF8String'};
avp_name(3905, 10415) ->
    {'Announcement-Identifier', 'Unsigned32'};
avp_name(3904, 10415) ->
    {'Announcement-Information', 'Grouped'};
avp_name(3906, 10415) ->
    {'Announcement-Order', 'Unsigned32'};
avp_name(4408, 10415) ->
    {'Announcing-PLMN-ID', 'UTF8String'};
avp_name(3426, 10415) ->
    {'Announcing-UE-HPLMN-Identifier', 'UTF8String'};
avp_name(3427, 10415) ->
    {'Announcing-UE-VPLMN-Identifier', 'UTF8String'};
avp_name(2053, 10415) ->
    {'AoC-Cost-Information', 'Grouped'};
avp_name(2310, 10415) -> {'AoC-Format', 'Enumerated'};
avp_name(2054, 10415) -> {'AoC-Information', 'Grouped'};
avp_name(2055, 10415) ->
    {'AoC-Request-Type', 'Enumerated'};
avp_name(2311, 10415) -> {'AoC-Service', 'Grouped'};
avp_name(2312, 10415) ->
    {'AoC-Service-Obligatory-Type', 'Enumerated'};
avp_name(2313, 10415) ->
    {'AoC-Service-Type', 'Enumerated'};
avp_name(2314, 10415) ->
    {'AoC-Subscription-Information', 'Grouped'};
avp_name(1218, 10415) -> {'Applic-ID', 'UTF8String'};
avp_name(837, 10415) ->
    {'Application-Provided-Called-Party-Address',
     'UTF8String'};
avp_name(836, 10415) ->
    {'Application-Server', 'UTF8String'};
avp_name(850, 10415) ->
    {'Application-Server-Information', 'Grouped'};
avp_name(3458, 10415) ->
    {'Application-Specific-Data', 'OctetString'};
avp_name(2035, 10415) ->
    {'Associated-Party-Address', 'UTF8String'};
avp_name(856, 10415) ->
    {'Associated-URI', 'UTF8String'};
avp_name(849, 10415) ->
    {'Authorised-QoS', 'UTF8String'};
avp_name(1219, 10415) ->
    {'Aux-Applic-Info', 'UTF8String'};
avp_name(2716, 10415) -> {'BSSID', 'UTF8String'};
avp_name(1265, 10415) ->
    {'Base-Time-Interval', 'Unsigned32'};
avp_name(3411, 10415) ->
    {'Basic-Service-Code', 'Grouped'};
avp_name(3412, 10415) ->
    {'Bearer-Capability', 'OctetString'};
avp_name(854, 10415) ->
    {'Bearer-Service', 'OctetString'};
avp_name(846, 10415) -> {'CG-Address', 'Address'};
avp_name(3421, 10415) ->
    {'CN-Operator-Selection-Entity', 'Enumerated'};
avp_name(3930, 10415) ->
    {'CP-CIoT-EPS-Optimisation-Indicator', 'Enumerated'};
avp_name(3927, 10415) ->
    {'CPDT-Information', 'Grouped'};
avp_name(2317, 10415) ->
    {'CSG-Access-Mode', 'Enumerated'};
avp_name(2318, 10415) ->
    {'CSG-Membership-Indication', 'Enumerated'};
avp_name(2304, 10415) ->
    {'CUG-Information', 'OctetString'};
avp_name(1250, 10415) ->
    {'Called-Asserted-Identity', 'UTF8String'};
avp_name(3916, 10415) ->
    {'Called-Identity', 'UTF8String'};
avp_name(3917, 10415) ->
    {'Called-Identity-Change', 'Grouped'};
avp_name(832, 10415) ->
    {'Called-Party-Address', 'UTF8String'};
avp_name(831, 10415) ->
    {'Calling-Party-Address', 'UTF8String'};
avp_name(2023, 10415) ->
    {'Carrier-Select-Routing-Information', 'UTF8String'};
avp_name(861, 10415) -> {'Cause-Code', 'Integer32'};
avp_name(3924, 10415) ->
    {'Cellular-Network-Information', 'OctetString'};
avp_name(2037, 10415) ->
    {'Change-Condition', 'Integer32'};
avp_name(2038, 10415) -> {'Change-Time', 'Time'};
avp_name(2118, 10415) ->
    {'Charge-Reason-Code', 'Enumerated'};
avp_name(857, 10415) -> {'Charged-Party', 'UTF8String'};
avp_name(2066, 10415) ->
    {'Charging-Characteristics-Selection-Mode',
     'Enumerated'};
avp_name(4400, 10415) ->
    {'Charging-Per-IP-CAN-Session-Indicator', 'Enumerated'};
avp_name(1214, 10415) ->
    {'Class-Identifier', 'Enumerated'};
avp_name(2018, 10415) -> {'Client-Address', 'Address'};
avp_name(1220, 10415) ->
    {'Content-Class', 'Enumerated'};
avp_name(828, 10415) ->
    {'Content-Disposition', 'UTF8String'};
avp_name(827, 10415) ->
    {'Content-Length', 'Unsigned32'};
avp_name(1206, 10415) -> {'Content-Size', 'Unsigned32'};
avp_name(826, 10415) -> {'Content-Type', 'UTF8String'};
avp_name(3459, 10415) -> {'Coverage-Info', 'Grouped'};
avp_name(3428, 10415) ->
    {'Coverage-Status', 'Enumerated'};
avp_name(2056, 10415) -> {'Current-Tariff', 'Grouped'};
avp_name(1221, 10415) -> {'DRM-Content', 'Enumerated'};
avp_name(2001, 10415) ->
    {'Data-Coding-Scheme', 'Integer32'};
avp_name(1230, 10415) ->
    {'Deferred-Location-Event-Type', 'UTF8String'};
avp_name(1216, 10415) ->
    {'Delivery-Report-Requested', 'Enumerated'};
avp_name(2002, 10415) ->
    {'Destination-Interface', 'Grouped'};
avp_name(2039, 10415) -> {'Diagnostics', 'Integer32'};
avp_name(4402, 10415) ->
    {'Discoveree-UE-HPLMN-Identifier', 'UTF8String'};
avp_name(4403, 10415) ->
    {'Discoveree-UE-VPLMN-Identifier', 'UTF8String'};
avp_name(4404, 10415) ->
    {'Discoverer-UE-HPLMN-Identifier', 'UTF8String'};
avp_name(4405, 10415) ->
    {'Discoverer-UE-VPLMN-Identifier', 'UTF8String'};
avp_name(1200, 10415) -> {'Domain-Name', 'UTF8String'};
avp_name(2051, 10415) ->
    {'Dynamic-Address-Flag', 'Enumerated'};
avp_name(2068, 10415) ->
    {'Dynamic-Address-Flag-Extension', 'Enumerated'};
avp_name(3425, 10415) -> {'EPDG-Address', 'Address'};
avp_name(1272, 10415) ->
    {'Early-Media-Description', 'Grouped'};
avp_name(3901, 10415) ->
    {'Enhanced-Diagnostics', 'Grouped'};
avp_name(1266, 10415) -> {'Envelope', 'Grouped'};
avp_name(1267, 10415) -> {'Envelope-End-Time', 'Time'};
avp_name(1268, 10415) ->
    {'Envelope-Reporting', 'Enumerated'};
avp_name(1269, 10415) ->
    {'Envelope-Start-Time', 'Time'};
avp_name(825, 10415) -> {'Event', 'UTF8String'};
avp_name(1258, 10415) ->
    {'Event-Charging-TimeStamp', 'Time'};
avp_name(823, 10415) -> {'Event-Type', 'Grouped'};
avp_name(888, 10415) -> {'Expires', 'Unsigned32'};
avp_name(4413, 10415) ->
    {'FE-Identifier-List', 'UTF8String'};
avp_name(1224, 10415) ->
    {'File-Repair-Supported', 'Enumerated'};
avp_name(3415, 10415) ->
    {'Forwarding-Pending', 'Enumerated'};
avp_name(2708, 10415) -> {'From-Address', 'UTF8String'};
avp_name(847, 10415) -> {'GGSN-Address', 'Address'};
avp_name(2601, 10415) ->
    {'IMS-Application-Reference-Identifier', 'UTF8String'};
avp_name(841, 10415) ->
    {'IMS-Charging-Identifier', 'UTF8String'};
avp_name(1281, 10415) ->
    {'IMS-Communication-Service-Identifier', 'UTF8String'};
avp_name(2322, 10415) ->
    {'IMS-Emergency-Indicator', 'Enumerated'};
avp_name(876, 10415) -> {'IMS-Information', 'Grouped'};
avp_name(2713, 10415) ->
    {'IMS-Visited-Network-Identifier', 'UTF8String'};
avp_name(2308, 10415) ->
    {'IMSI-Unauthenticated-Flag', 'Enumerated'};
avp_name(2603, 10415) ->
    {'IP-Realm-Default-Indication', 'Enumerated'};
avp_name(3416, 10415) -> {'ISUP-Cause', 'Grouped'};
avp_name(3422, 10415) ->
    {'ISUP-Cause-Diagnostics', 'OctetString'};
avp_name(3423, 10415) ->
    {'ISUP-Cause-Location', 'Unsigned32'};
avp_name(3424, 10415) ->
    {'ISUP-Cause-Value', 'Unsigned32'};
avp_name(3414, 10415) ->
    {'ISUP-Location-Number', 'OctetString'};
avp_name(852, 10415) ->
    {'Incoming-Trunk-Group-Id', 'UTF8String'};
avp_name(2062, 10415) ->
    {'Incremental-Cost', 'Grouped'};
avp_name(2321, 10415) ->
    {'Initial-IMS-Charging-Identifier', 'UTF8String'};
avp_name(3402, 10415) -> {'Instance-Id', 'UTF8String'};
avp_name(838, 10415) ->
    {'Inter-Operator-Identifier', 'Grouped'};
avp_name(3902, 10415) ->
    {'Inter-UE-Transfer', 'Enumerated'};
avp_name(2003, 10415) -> {'Interface-Id', 'UTF8String'};
avp_name(2004, 10415) ->
    {'Interface-Port', 'UTF8String'};
avp_name(2005, 10415) ->
    {'Interface-Text', 'UTF8String'};
avp_name(2006, 10415) ->
    {'Interface-Type', 'Enumerated'};
avp_name(1231, 10415) -> {'LCS-APN', 'UTF8String'};
avp_name(1233, 10415) ->
    {'LCS-Client-Dialed-By-MS', 'UTF8String'};
avp_name(1234, 10415) ->
    {'LCS-Client-External-ID', 'UTF8String'};
avp_name(1232, 10415) -> {'LCS-Client-ID', 'Grouped'};
avp_name(1235, 10415) -> {'LCS-Client-Name', 'Grouped'};
avp_name(1241, 10415) ->
    {'LCS-Client-Type', 'Enumerated'};
avp_name(1236, 10415) ->
    {'LCS-Data-Coding-Scheme', 'UTF8String'};
avp_name(1237, 10415) ->
    {'LCS-Format-Indicator', 'Enumerated'};
avp_name(878, 10415) -> {'LCS-Information', 'Grouped'};
avp_name(1238, 10415) ->
    {'LCS-Name-String', 'UTF8String'};
avp_name(1239, 10415) ->
    {'LCS-Requestor-ID', 'Grouped'};
avp_name(1240, 10415) ->
    {'LCS-Requestor-ID-String', 'UTF8String'};
avp_name(3914, 10415) -> {'Language', 'UTF8String'};
avp_name(3429, 10415) ->
    {'Layer-2-Group-ID', 'OctetString'};
avp_name(2604, 10415) ->
    {'Local-GW-Inserted-Indication', 'Enumerated'};
avp_name(2063, 10415) ->
    {'Local-Sequence-Number', 'Unsigned32'};
avp_name(1242, 10415) ->
    {'Location-Estimate', 'OctetString'};
avp_name(1243, 10415) ->
    {'Location-Estimate-Type', 'Enumerated'};
avp_name(3460, 10415) -> {'Location-Info', 'Grouped'};
avp_name(1244, 10415) -> {'Location-Type', 'Grouped'};
avp_name(2020, 10415) ->
    {'Low-Balance-Indication', 'Enumerated'};
avp_name(2602, 10415) ->
    {'Low-Priority-Indicator', 'Enumerated'};
avp_name(2323, 10415) ->
    {'MBMS-Charged-Party', 'Enumerated'};
avp_name(2307, 10415) -> {'MBMS-GW-Address', 'Address'};
avp_name(880, 10415) -> {'MBMS-Information', 'Grouped'};
avp_name(1225, 10415) ->
    {'MBMS-User-Service-Type', 'Enumerated'};
avp_name(1203, 10415) -> {'MM-Content-Type', 'Grouped'};
avp_name(1248, 10415) ->
    {'MMBox-Storage-Requested', 'Enumerated'};
avp_name(877, 10415) -> {'MMS-Information', 'Grouped'};
avp_name(2030, 10415) ->
    {'MMTel-Information', 'Grouped'};
avp_name(2031, 10415) ->
    {'MMTel-SService-Type', 'Unsigned32'};
avp_name(3417, 10415) -> {'MSC-Address', 'OctetString'};
avp_name(3406, 10415) -> {'MTC-IWF-Address', 'Address'};
avp_name(882, 10415) ->
    {'Media-Initiator-Flag', 'Enumerated'};
avp_name(1288, 10415) ->
    {'Media-Initiator-Party', 'UTF8String'};
avp_name(889, 10415) -> {'Message-Body', 'Grouped'};
avp_name(1213, 10415) -> {'Message-Class', 'Grouped'};
avp_name(1210, 10415) -> {'Message-ID', 'UTF8String'};
avp_name(1212, 10415) -> {'Message-Size', 'Unsigned32'};
avp_name(1211, 10415) -> {'Message-Type', 'Enumerated'};
avp_name(3430, 10415) ->
    {'Monitored-PLMN-Identifier', 'UTF8String'};
avp_name(3919, 10415) ->
    {'Monitoring-Event-Configuration-Activity',
     'Integer32'};
avp_name(3922, 10415) ->
    {'Monitoring-Event-Functionality', 'Integer32'};
avp_name(3921, 10415) ->
    {'Monitoring-Event-Information', 'Grouped'};
avp_name(3920, 10415) ->
    {'Monitoring-Event-Report-Data', 'Grouped'};
avp_name(3923, 10415) ->
    {'Monitoring-Event-Report-Number', 'Unsigned32'};
avp_name(3431, 10415) ->
    {'Monitoring-UE-HPLMN-Identifier', 'UTF8String'};
avp_name(3432, 10415) ->
    {'Monitoring-UE-Identifier', 'UTF8String'};
avp_name(3433, 10415) ->
    {'Monitoring-UE-VPLMN-Identifier', 'UTF8String'};
avp_name(3928, 10415) -> {'NIDD-Submission', 'Grouped'};
avp_name(2703, 10415) -> {'NNI-Information', 'Grouped'};
avp_name(2704, 10415) -> {'NNI-Type', 'Enumerated'};
avp_name(2705, 10415) ->
    {'Neighbour-Node-Address', 'Address'};
avp_name(3418, 10415) ->
    {'Network-Call-Reference-Number', 'OctetString'};
avp_name(2057, 10415) -> {'Next-Tariff', 'Grouped'};
avp_name(862, 10415) ->
    {'Node-Functionality', 'Enumerated'};
avp_name(2064, 10415) -> {'Node-Id', 'UTF8String'};
avp_name(2034, 10415) ->
    {'Number-Of-Diversions', 'Unsigned32'};
avp_name(2019, 10415) ->
    {'Number-Of-Messages-Sent', 'Unsigned32'};
avp_name(885, 10415) ->
    {'Number-Of-Participants', 'Unsigned32'};
avp_name(1282, 10415) ->
    {'Number-Of-Received-Talk-Bursts', 'Unsigned32'};
avp_name(1283, 10415) ->
    {'Number-Of-Talk-Bursts', 'Unsigned32'};
avp_name(2024, 10415) ->
    {'Number-Portability-Routing-Information',
     'UTF8String'};
avp_name(1278, 10415) ->
    {'Offline-Charging', 'Grouped'};
avp_name(2303, 10415) ->
    {'Online-Charging-Flag', 'Enumerated'};
avp_name(839, 10415) ->
    {'Originating-IOI', 'UTF8String'};
avp_name(864, 10415) -> {'Originator', 'Enumerated'};
avp_name(886, 10415) ->
    {'Originator-Address', 'Grouped'};
avp_name(2009, 10415) ->
    {'Originator-Interface', 'Grouped'};
avp_name(2027, 10415) ->
    {'Originator-Received-Address', 'Grouped'};
avp_name(2008, 10415) ->
    {'Originator-SCCP-Address', 'Address'};
avp_name(2320, 10415) ->
    {'Outgoing-Session-Id', 'UTF8String'};
avp_name(853, 10415) ->
    {'Outgoing-Trunk-Group-Id', 'UTF8String'};
avp_name(3434, 10415) ->
    {'PC3-Control-Protocol-Cause', 'Integer32'};
avp_name(3435, 10415) ->
    {'PC3-EPC-Control-Protocol-Cause', 'Integer32'};
avp_name(1300, 10415) ->
    {'PC5-Radio-Technology', 'Enumerated'};
avp_name(2050, 10415) ->
    {'PDN-Connection-Charging-ID', 'Unsigned32'};
avp_name(1227, 10415) -> {'PDP-Address', 'Address'};
avp_name(2606, 10415) ->
    {'PDP-Address-Prefix-Length', 'Unsigned32'};
avp_name(1247, 10415) ->
    {'PDP-Context-Type', 'Enumerated'};
avp_name(867, 10415) ->
    {'PS-Append-Free-Format-Data', 'Enumerated'};
avp_name(866, 10415) ->
    {'PS-Free-Format-Data', 'OctetString'};
avp_name(865, 10415) ->
    {'PS-Furnish-Charging-Information', 'Grouped'};
avp_name(874, 10415) -> {'PS-Information', 'Grouped'};
avp_name(1259, 10415) ->
    {'Participant-Access-Priority', 'Enumerated'};
avp_name(2049, 10415) ->
    {'Participant-Action-Type', 'Enumerated'};
avp_name(1260, 10415) ->
    {'Participant-Group', 'Grouped'};
avp_name(887, 10415) ->
    {'Participants-Involved', 'UTF8String'};
avp_name(3913, 10415) ->
    {'Play-Alternative', 'Enumerated'};
avp_name(1261, 10415) ->
    {'PoC-Change-Condition', 'Enumerated'};
avp_name(1262, 10415) -> {'PoC-Change-Time', 'Time'};
avp_name(858, 10415) ->
    {'PoC-Controlling-Address', 'UTF8String'};
avp_name(2025, 10415) ->
    {'PoC-Event-Type', 'Enumerated'};
avp_name(859, 10415) ->
    {'PoC-Group-Name', 'UTF8String'};
avp_name(879, 10415) -> {'PoC-Information', 'Grouped'};
avp_name(883, 10415) ->
    {'PoC-Server-Role', 'Enumerated'};
avp_name(1229, 10415) ->
    {'PoC-Session-Id', 'UTF8String'};
avp_name(1277, 10415) ->
    {'PoC-Session-Initiation-Type', 'Enumerated'};
avp_name(884, 10415) ->
    {'PoC-Session-Type', 'Enumerated'};
avp_name(1252, 10415) -> {'PoC-User-Role', 'Grouped'};
avp_name(1253, 10415) ->
    {'PoC-User-Role-IDs', 'UTF8String'};
avp_name(1254, 10415) ->
    {'PoC-User-Role-Info-Units', 'Enumerated'};
avp_name(1245, 10415) ->
    {'Positioning-Data', 'UTF8String'};
avp_name(2315, 10415) ->
    {'Preferred-AoC-Currency', 'Unsigned32'};
avp_name(1209, 10415) -> {'Priority', 'Enumerated'};
avp_name(3915, 10415) ->
    {'Privacy-Indicator', 'Enumerated'};
avp_name(3440, 10415) ->
    {'ProSe-3rd-Party-Application-ID', 'UTF8String'};
avp_name(3461, 10415) ->
    {'ProSe-Direct-Communication-Reception-Data-Container',
     'Grouped'};
avp_name(3441, 10415) ->
    {'ProSe-Direct-Communication-Transmission-Data-Container',
     'Grouped'};
avp_name(3442, 10415) ->
    {'ProSe-Direct-Discovery-Model', 'Enumerated'};
avp_name(3443, 10415) ->
    {'ProSe-Event-Type', 'Enumerated'};
avp_name(3444, 10415) ->
    {'ProSe-Function-IP-Address', 'Address'};
avp_name(3457, 10415) ->
    {'ProSe-Function-PLMN-Identifier', 'UTF8String'};
avp_name(3445, 10415) ->
    {'ProSe-Functionality', 'Enumerated'};
avp_name(3446, 10415) ->
    {'ProSe-Group-IP-Multicast-Address', 'Address'};
avp_name(3447, 10415) ->
    {'ProSe-Information', 'Grouped'};
avp_name(3448, 10415) ->
    {'ProSe-Range-Class', 'Enumerated'};
avp_name(3449, 10415) ->
    {'ProSe-Reason-For-Cancellation', 'Enumerated'};
avp_name(3450, 10415) ->
    {'ProSe-Request-Timestamp', 'Time'};
avp_name(3451, 10415) ->
    {'ProSe-Role-Of-UE', 'Enumerated'};
avp_name(3452, 10415) ->
    {'ProSe-Source-IP-Address', 'Address'};
avp_name(4410, 10415) ->
    {'ProSe-Target-Layer-2-ID', 'OctetString'};
avp_name(3453, 10415) -> {'ProSe-UE-ID', 'OctetString'};
avp_name(4409, 10415) ->
    {'ProSe-UE-to-Network-Relay-UE-ID', 'OctetString'};
avp_name(3454, 10415) ->
    {'Proximity-Alert-Indication', 'Enumerated'};
avp_name(3455, 10415) ->
    {'Proximity-Alert-Timestamp', 'Time'};
avp_name(3456, 10415) ->
    {'Proximity-Cancellation-Timestamp', 'Time'};
avp_name(881, 10415) ->
    {'Quota-Consumption-Time', 'Unsigned32'};
avp_name(871, 10415) ->
    {'Quota-Holding-Time', 'Unsigned32'};
avp_name(3912, 10415) ->
    {'Quota-Indicator', 'Enumerated'};
avp_name(1301, 10415) -> {'RAN-End-Timestamp', 'Time'};
avp_name(1302, 10415) ->
    {'RAN-Secondary-RAT-Usage-Report', 'Grouped'};
avp_name(1303, 10415) ->
    {'RAN-Start-Timestamp', 'Time'};
avp_name(3462, 10415) ->
    {'Radio-Frequency', 'OctetString'};
avp_name(3463, 10415) ->
    {'Radio-Parameter-Set-Info', 'Grouped'};
avp_name(3464, 10415) ->
    {'Radio-Parameter-Set-Values', 'OctetString'};
avp_name(3465, 10415) ->
    {'Radio-Resources-Indicator', 'Integer32'};
avp_name(3937, 10415) ->
    {'Rate-Control-Max-Message-Size', 'Unsigned32'};
avp_name(3938, 10415) ->
    {'Rate-Control-Max-Rate', 'Unsigned32'};
avp_name(3939, 10415) ->
    {'Rate-Control-Time-Unit', 'Unsigned32'};
avp_name(2058, 10415) -> {'Rate-Element', 'Grouped'};
avp_name(1222, 10415) ->
    {'Read-Reply-Report-Requested', 'Enumerated'};
avp_name(2305, 10415) ->
    {'Real-Time-Tariff-Information', 'Grouped'};
avp_name(3401, 10415) ->
    {'Reason-Header', 'UTF8String'};
avp_name(1284, 10415) ->
    {'Received-Talk-Burst-Time', 'Unsigned32'};
avp_name(1285, 10415) ->
    {'Received-Talk-Burst-Volume', 'Unsigned32'};
avp_name(1201, 10415) ->
    {'Recipient-Address', 'Grouped'};
avp_name(2026, 10415) -> {'Recipient-Info', 'Grouped'};
avp_name(2028, 10415) ->
    {'Recipient-Received-Address', 'Grouped'};
avp_name(2010, 10415) ->
    {'Recipient-SCCP-Address', 'Address'};
avp_name(2022, 10415) ->
    {'Refund-Information', 'OctetString'};
avp_name(3925, 10415) ->
    {'Related-Change-Condition-Information', 'Grouped'};
avp_name(2711, 10415) ->
    {'Related-IMS-Charging-Identifier', 'UTF8String'};
avp_name(2712, 10415) ->
    {'Related-IMS-Charging-Identifier-Node', 'Address'};
avp_name(3926, 10415) -> {'Related-Trigger', 'Grouped'};
avp_name(2706, 10415) ->
    {'Relationship-Mode', 'Enumerated'};
avp_name(4411, 10415) ->
    {'Relay-IP-address', 'Address'};
avp_name(2021, 10415) ->
    {'Remaining-Balance', 'Grouped'};
avp_name(1223, 10415) ->
    {'Reply-Applic-ID', 'UTF8String'};
avp_name(2011, 10415) ->
    {'Reply-Path-Requested', 'Enumerated'};
avp_name(872, 10415) ->
    {'Reporting-Reason', 'Enumerated'};
avp_name(3436, 10415) ->
    {'Requested-PLMN-Identifier', 'UTF8String'};
avp_name(1251, 10415) ->
    {'Requested-Party-Address', 'UTF8String'};
avp_name(3437, 10415) ->
    {'Requestor-PLMN-Identifier', 'UTF8String'};
avp_name(829, 10415) -> {'Role-Of-Node', 'Enumerated'};
avp_name(3438, 10415) ->
    {'Role-Of-ProSe-Function', 'Enumerated'};
avp_name(3403, 10415) ->
    {'Route-Header-Received', 'UTF8String'};
avp_name(3404, 10415) ->
    {'Route-Header-Transmitted', 'UTF8String'};
avp_name(3940, 10415) -> {'SCS-AS-Address', 'Grouped'};
avp_name(3941, 10415) -> {'SCS-Address', 'Address'};
avp_name(3942, 10415) ->
    {'SCS-Realm', 'DiameterIdentity'};
avp_name(1275, 10415) ->
    {'SDP-Answer-Timestamp', 'Time'};
avp_name(843, 10415) ->
    {'SDP-Media-Component', 'Grouped'};
avp_name(845, 10415) ->
    {'SDP-Media-Description', 'UTF8String'};
avp_name(844, 10415) ->
    {'SDP-Media-Name', 'UTF8String'};
avp_name(1274, 10415) ->
    {'SDP-Offer-Timestamp', 'Time'};
avp_name(842, 10415) ->
    {'SDP-Session-Description', 'UTF8String'};
avp_name(1273, 10415) -> {'SDP-TimeStamps', 'Grouped'};
avp_name(2036, 10415) -> {'SDP-Type', 'Enumerated'};
avp_name(1228, 10415) -> {'SGSN-Address', 'Address'};
avp_name(2067, 10415) -> {'SGW-Address', 'Address'};
avp_name(2065, 10415) -> {'SGW-Change', 'Enumerated'};
avp_name(3931, 10415) ->
    {'SGi-PtP-Tunnelling-Method', 'Enumerated'};
avp_name(824, 10415) -> {'SIP-Method', 'UTF8String'};
avp_name(834, 10415) ->
    {'SIP-Request-Timestamp', 'Time'};
avp_name(2301, 10415) ->
    {'SIP-Request-Timestamp-Fraction', 'Unsigned32'};
avp_name(835, 10415) ->
    {'SIP-Response-Timestamp', 'Time'};
avp_name(2302, 10415) ->
    {'SIP-Response-Timestamp-Fraction', 'Unsigned32'};
avp_name(3407, 10415) ->
    {'SM-Device-Trigger-Indicator', 'Enumerated'};
avp_name(3405, 10415) ->
    {'SM-Device-Trigger-Information', 'Grouped'};
avp_name(2012, 10415) -> {'SM-Discharge-Time', 'Time'};
avp_name(2007, 10415) ->
    {'SM-Message-Type', 'Enumerated'};
avp_name(2013, 10415) ->
    {'SM-Protocol-ID', 'OctetString'};
avp_name(3408, 10415) ->
    {'SM-Sequence-Number', 'Unsigned32'};
avp_name(2029, 10415) ->
    {'SM-Service-Type', 'Enumerated'};
avp_name(2014, 10415) -> {'SM-Status', 'OctetString'};
avp_name(2015, 10415) ->
    {'SM-User-Data-Header', 'OctetString'};
avp_name(2000, 10415) -> {'SMS-Information', 'Grouped'};
avp_name(2016, 10415) -> {'SMS-Node', 'Enumerated'};
avp_name(3409, 10415) -> {'SMS-Result', 'Unsigned32'};
avp_name(2017, 10415) -> {'SMSC-Address', 'Address'};
avp_name(2059, 10415) -> {'Scale-Factor', 'Grouped'};
avp_name(1304, 10415) ->
    {'Secondary-RAT-Type', 'OctetString'};
avp_name(848, 10415) ->
    {'Served-Party-IP-Address', 'Address'};
avp_name(2040, 10415) ->
    {'Service-Data-Container', 'Grouped'};
avp_name(855, 10415) -> {'Service-Id', 'UTF8String'};
avp_name(2032, 10415) -> {'Service-Mode', 'Unsigned32'};
avp_name(863, 10415) ->
    {'Service-Specific-Data', 'UTF8String'};
avp_name(1249, 10415) ->
    {'Service-Specific-Info', 'Grouped'};
avp_name(1257, 10415) ->
    {'Service-Specific-Type', 'Unsigned32'};
avp_name(3929, 10415) ->
    {'Serving-Node-Identity', 'DiameterIdentity'};
avp_name(2047, 10415) ->
    {'Serving-Node-Type', 'Enumerated'};
avp_name(2707, 10415) ->
    {'Session-Direction', 'Enumerated'};
avp_name(2041, 10415) -> {'Start-Time', 'Time'};
avp_name(3419, 10415) -> {'Start-of-Charging', 'Time'};
avp_name(2702, 10415) ->
    {'Status-AS-Code', 'Enumerated'};
avp_name(2042, 10415) -> {'Stop-Time', 'Time'};
avp_name(1202, 10415) -> {'Submission-Time', 'Time'};
avp_name(2033, 10415) ->
    {'Subscriber-Role', 'Enumerated'};
avp_name(2048, 10415) ->
    {'Supplementary-Service', 'Grouped'};
avp_name(2717, 10415) ->
    {'TAD-Identifier', 'Enumerated'};
avp_name(3903, 10415) -> {'TWAG-Address', 'Address'};
avp_name(2714, 10415) ->
    {'TWAN-User-Location-Info', 'Grouped'};
avp_name(1255, 10415) ->
    {'Talk-Burst-Exchange', 'Grouped'};
avp_name(1286, 10415) ->
    {'Talk-Burst-Time', 'Unsigned32'};
avp_name(1287, 10415) ->
    {'Talk-Burst-Volume', 'Unsigned32'};
avp_name(4412, 10415) ->
    {'Target-IP-Address', 'Address'};
avp_name(2060, 10415) ->
    {'Tariff-Information', 'Grouped'};
avp_name(2306, 10415) -> {'Tariff-XML', 'UTF8String'};
avp_name(3413, 10415) -> {'Teleservice', 'OctetString'};
avp_name(840, 10415) ->
    {'Terminating-IOI', 'UTF8String'};
avp_name(3466, 10415) ->
    {'Time-First-Reception', 'Time'};
avp_name(3467, 10415) ->
    {'Time-First-Transmission', 'Time'};
avp_name(2043, 10415) -> {'Time-First-Usage', 'Time'};
avp_name(3911, 10415) ->
    {'Time-Indicator', 'Unsigned32'};
avp_name(2044, 10415) -> {'Time-Last-Usage', 'Time'};
avp_name(1270, 10415) ->
    {'Time-Quota-Mechanism', 'Grouped'};
avp_name(868, 10415) ->
    {'Time-Quota-Threshold', 'Unsigned32'};
avp_name(1271, 10415) ->
    {'Time-Quota-Type', 'Enumerated'};
avp_name(833, 10415) -> {'Time-Stamps', 'Grouped'};
avp_name(2045, 10415) -> {'Time-Usage', 'Unsigned32'};
avp_name(1215, 10415) -> {'Token-Text', 'UTF8String'};
avp_name(2046, 10415) ->
    {'Traffic-Data-Volumes', 'Grouped'};
avp_name(2605, 10415) ->
    {'Transcoder-Inserted-Indication', 'Enumerated'};
avp_name(2701, 10415) ->
    {'Transit-IOI-List', 'UTF8String'};
avp_name(3468, 10415) ->
    {'Transmitter-Info', 'Grouped'};
avp_name(1264, 10415) -> {'Trigger', 'Grouped'};
avp_name(870, 10415) -> {'Trigger-Type', 'Enumerated'};
avp_name(851, 10415) -> {'Trunk-Group-Id', 'Grouped'};
avp_name(1204, 10415) -> {'Type-Number', 'Enumerated'};
avp_name(3932, 10415) ->
    {'UNI-PDU-CP-Only-Flag', 'Enumerated'};
avp_name(3918, 10415) ->
    {'UWAN-User-Location-Info', 'Grouped'};
avp_name(2061, 10415) -> {'Unit-Cost', 'Grouped'};
avp_name(1226, 10415) ->
    {'Unit-Quota-Threshold', 'Unsigned32'};
avp_name(4407, 10415) ->
    {'Unused-Quota-Timer', 'Unsigned32'};
avp_name(3439, 10415) ->
    {'Usage-Information-Report-Sequence-Number',
     'Integer32'};
avp_name(2319, 10415) ->
    {'User-CSG-Information', 'Grouped'};
avp_name(1279, 10415) ->
    {'User-Participating-Type', 'Enumerated'};
avp_name(830, 10415) ->
    {'User-Session-Id', 'UTF8String'};
avp_name(3410, 10415) -> {'VCS-Information', 'Grouped'};
avp_name(3420, 10415) -> {'VLR-Number', 'OctetString'};
avp_name(3907, 10415) -> {'Variable-Part', 'Grouped'};
avp_name(3908, 10415) ->
    {'Variable-Part-Order', 'Unsigned32'};
avp_name(3909, 10415) ->
    {'Variable-Part-Type', 'Enumerated'};
avp_name(3910, 10415) ->
    {'Variable-Part-Value', 'UTF8String'};
avp_name(869, 10415) ->
    {'Volume-Quota-Threshold', 'Unsigned32'};
avp_name(_, _) -> 'AVP'.

avp_arity('TP-Previous-PS-Information') ->
    [{'QoS-Information', {0, 1}},
     {'SGSN-Address', {0, '*'}},
     {'3GPP-SGSN-MCC-MNC', {0, 1}},
     {'3GPP-MS-TimeZone', {0, 1}},
     {'3GPP-User-Location-Info', {0, 1}},
     {'3GPP-RAT-Type', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Access-Network-Charging-Identifier-Gx') ->
    [{'Access-Network-Charging-Identifier-Value', 1},
     {'Charging-Rule-Base-Name', {0, '*'}},
     {'Charging-Rule-Name', {0, '*'}},
     {'IP-CAN-Session-Charging-Scope', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Allocation-Retention-Priority') ->
    [{'Priority-Level', 1},
     {'Pre-emption-Capability', {0, 1}},
     {'Pre-emption-Vulnerability', {0, 1}}];
avp_arity('Application-Detection-Information') ->
    [{'TDF-Application-Identifier', 1},
     {'TDF-Application-Instance-Identifier', {0, 1}},
     {'Flow-Information', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('Charging-Rule-Definition') ->
    [{'Charging-Rule-Name', 1},
     {'Service-Identifier', {0, 1}},
     {'Rating-Group', {0, 1}},
     {'Flow-Information', {0, '*'}},
     {'TDF-Application-Identifier', {0, 1}},
     {'Flow-Status', {0, 1}},
     {'QoS-Information', {0, 1}},
     {'PS-to-CS-Session-Continuity', {0, 1}},
     {'Reporting-Level', {0, 1}},
     {'Online', {0, 1}},
     {'Offline', {0, 1}},
     {'Metering-Method', {0, 1}},
     {'Precedence', {0, 1}},
     {'AF-Charging-Identifier', {0, 1}},
     {'Flows', {0, '*'}},
     {'Monitoring-Key', {0, 1}},
     {'Redirect-Information', {0, 1}},
     {'Mute-Notification', {0, 1}},
     {'AF-Signalling-Protocol', {0, 1}},
     {'Sponsor-Identity', {0, 1}},
     {'Application-Service-Provider-Identity', {0, 1}},
     {'Required-Access-Info', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('Charging-Rule-Install') ->
    [{'Charging-Rule-Definition', {0, '*'}},
     {'Charging-Rule-Name', {0, '*'}},
     {'Charging-Rule-Base-Name', {0, '*'}},
     {'Bearer-Identifier', {0, 1}},
     {'Rule-Activation-Time', {0, 1}},
     {'Rule-Deactivation-Time', {0, 1}},
     {'Resource-Allocation-Notification', {0, 1}},
     {'Charging-Correlation-Indicator', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Charging-Rule-Remove') ->
    [{'Charging-Rule-Name', {0, '*'}},
     {'Charging-Rule-Base-Name', {0, '*'}},
     {'Required-Access-Info', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('Charging-Rule-Report') ->
    [{'Charging-Rule-Name', {0, '*'}},
     {'Charging-Rule-Base-Name', {0, '*'}},
     {'Bearer-Identifier', {0, 1}},
     {'PCC-Rule-Status', {0, 1}},
     {'Rule-Failure-Code', {0, 1}},
     {'Final-Unit-Indication', {0, 1}},
     {'RAN-NAS-Release-Cause', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('CoA-Information') ->
    [{'Tunnel-Information', 1},
     {'CoA-IP-Address', 1},
     {'AVP', {0, '*'}}];
avp_arity('Conditional-APN-Aggregate-Max-Bitrate') ->
    [{'APN-Aggregate-Max-Bitrate-UL', {0, 1}},
     {'APN-Aggregate-Max-Bitrate-DL', {0, 1}},
     {'IP-CAN-Type', {0, '*'}},
     {'RAT-Type', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('Default-EPS-Bearer-QoS') ->
    [{'QoS-Class-Identifier', {0, 1}},
     {'Allocation-Retention-Priority', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Default-QoS-Information') ->
    [{'QoS-Class-Identifier', {0, 1}},
     {'Max-Requested-Bandwidth-UL', {0, 1}},
     {'Max-Requested-Bandwidth-DL', {0, 1}},
     {'Default-QoS-Name', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Event-Report-Indication') ->
    [{'Event-Trigger', {0, '*'}},
     {'IP-CAN-Type', {0, 1}},
     {'AN-GW-Address', {0, 2}},
     {'3GPP-SGSN-Address', {0, 1}},
     {'3GPP-SGSN-IPv6-Address', {0, 1}},
     {'3GPP-SGSN-MCC-MNC', {0, 1}},
     {'Framed-IP-Address', {0, 1}},
     {'RAT-Type', {0, 1}},
     {'RAI', {0, 1}},
     {'3GPP-User-Location-Info', {0, 1}},
     {'3GPP-MS-TimeZone', {0, 1}},
     {'Routing-IP-Address', {0, 1}},
     {'UE-Local-IP-Address', {0, 1}},
     {'HeNB-Local-IP-Address', {0, 1}},
     {'UDP-Source-Port', {0, 1}},
     {'Presence-Reporting-Area-Information', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Fixed-User-Location-Info') ->
    [{'Logical-Access-ID', {0, 1}},
     {'Physical-Access-ID', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Flow-Information') ->
    [{'Flow-Description', {0, 1}},
     {'Packet-Filter-Identifier', {0, 1}},
     {'Packet-Filter-Usage', {0, 1}},
     {'ToS-Traffic-Class', {0, 1}},
     {'Security-Parameter-Index', {0, 1}},
     {'Flow-Label', {0, 1}},
     {'Flow-Direction', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Packet-Filter-Information') ->
    [{'Packet-Filter-Identifier', {0, 1}},
     {'Precedence', {0, 1}},
     {'Packet-Filter-Content', {0, 1}},
     {'ToS-Traffic-Class', {0, 1}},
     {'Security-Parameter-Index', {0, 1}},
     {'Flow-Label', {0, 1}},
     {'Flow-Direction', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Presence-Reporting-Area-Information') ->
    [{'Presence-Reporting-Area-Identifier', {0, 1}},
     {'Presence-Reporting-Area-Status', {0, 1}},
     {'Presence-Reporting-Area-Elements-List', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('QoS-Information') ->
    [{'QoS-Class-Identifier', {0, 1}},
     {'Max-Requested-Bandwidth-UL', {0, 1}},
     {'Max-Requested-Bandwidth-DL', {0, 1}},
     {'Guaranteed-Bitrate-UL', {0, 1}},
     {'Guaranteed-Bitrate-DL', {0, 1}},
     {'Bearer-Identifier', {0, 1}},
     {'Allocation-Retention-Priority', {0, 1}},
     {'APN-Aggregate-Max-Bitrate-UL', {0, 1}},
     {'APN-Aggregate-Max-Bitrate-DL', {0, 1}},
     {'Conditional-APN-Aggregate-Max-Bitrate', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('Redirect-Information') ->
    [{'Redirect-Support', {0, 1}},
     {'Redirect-Address-Type', {0, 1}},
     {'Redirect-Server-Address', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Routing-Filter') ->
    [{'Flow-Description', 1},
     {'Flow-Direction', 1},
     {'ToS-Traffic-Class', {0, 1}},
     {'Security-Parameter-Index', {0, 1}},
     {'Flow-Label', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Routing-Rule-Definition') ->
    [{'Routing-Rule-Identifier', 1},
     {'Routing-Filter', {0, '*'}},
     {'Precedence', {0, 1}},
     {'Routing-IP-Address', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Routing-Rule-Install') ->
    [{'Routing-Rule-Definition', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('Routing-Rule-Remove') ->
    [{'Routing-Rule-Identifier', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('TDF-Information') ->
    [{'TDF-Destination-Realm', {0, 1}},
     {'TDF-Destination-Host', {0, 1}},
     {'TDF-IP-Address', {0, 1}}];
avp_arity('Tunnel-Information') ->
    [{'Tunnel-Header-Length', {0, 1}},
     {'Tunnel-Header-Filter', {0, 2}},
     {'AVP', {0, '*'}}];
avp_arity('TFT-Packet-Filter-Information') ->
    [{'Precedence', {0, 1}},
     {'TFT-Filter', {0, 1}},
     {'ToS-Traffic-Class', {0, 1}},
     {'Security-Parameter-Index', {0, 1}},
     {'Flow-Label', {0, 1}},
     {'Flow-Direction', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Usage-Monitoring-Information') ->
    [{'Monitoring-Key', {0, 1}},
     {'Granted-Service-Unit', {0, 2}},
     {'Used-Service-Unit', {0, 2}},
     {'Usage-Monitoring-Level', {0, 1}},
     {'Usage-Monitoring-Report', {0, 1}},
     {'Usage-Monitoring-Support', {0, 1}},
     {'AVP', {0, '*'}}];
avp_arity('Access-Network-Info-Change') ->
    [{'Access-Network-Information', {0, '*'}},
     {'Cellular-Network-Information', {0, 1}},
     {'Change-Time', {0, 1}}];
avp_arity('Access-Transfer-Information') ->
    [{'Access-Transfer-Type', {0, 1}},
     {'Access-Network-Information', {0, '*'}},
     {'Cellular-Network-Information', {0, 1}},
     {'Inter-UE-Transfer', {0, 1}},
     {'User-Equipment-Info', {0, 1}},
     {'Instance-Id', {0, 1}},
     {'Related-IMS-Charging-Identifier', {0, 1}},
     {'Related-IMS-Charging-Identifier-Node', {0, 1}},
     {'Change-Time', {0, 1}}];
avp_arity('Accumulated-Cost') ->
    [{'Value-Digits', 1}, {'Exponent', {0, 1}}];
avp_arity('Additional-Content-Information') ->
    [{'Type-Number', {0, 1}},
     {'Additional-Type-Information', {0, 1}},
     {'Content-Size', {0, 1}}];
avp_arity('Address-Domain') ->
    [{'Domain-Name', {0, 1}},
     {'3GPP-IMSI-MCC-MNC', {0, 1}}];
avp_arity('AF-Correlation-Information') ->
    [{'AF-Charging-Identifier', 1}, {'Flows', {0, '*'}}];
avp_arity('Announcement-Information') ->
    [{'Announcement-Identifier', 1},
     {'Variable-Part', {0, '*'}},
     {'Time-Indicator', {0, 1}},
     {'Quota-Indicator', {0, 1}},
     {'Announcement-Order', {0, 1}},
     {'Play-Alternative', {0, 1}},
     {'Privacy-Indicator', {0, 1}},
     {'Language', {0, 1}}];
avp_arity('AoC-Cost-Information') ->
    [{'Accumulated-Cost', {0, 1}},
     {'Incremental-Cost', {0, '*'}},
     {'Currency-Code', {0, 1}}];
avp_arity('AoC-Information') ->
    [{'AoC-Cost-Information', {0, 1}},
     {'Tariff-Information', {0, 1}},
     {'AoC-Subscription-Information', {0, 1}}];
avp_arity('AoC-Service') ->
    [{'AoC-Service-Obligatory-Type', {0, 1}},
     {'AoC-Service-Type', {0, 1}}];
avp_arity('AoC-Subscription-Information') ->
    [{'AoC-Service', {0, '*'}},
     {'AoC-Format', {0, 1}},
     {'Preferred-AoC-Currency', {0, 1}}];
avp_arity('APN-Rate-Control') ->
    [{'APN-Rate-Control-Uplink', {0, 1}},
     {'APN-Rate-Control-Downlink', {0, 1}}];
avp_arity('APN-Rate-Control-Downlink') ->
    [{'Rate-Control-Time-Unit', {0, 1}},
     {'Rate-Control-Max-Rate', {0, 1}},
     {'Rate-Control-Max-Message-Size', {0, 1}}];
avp_arity('APN-Rate-Control-Uplink') ->
    [{'Additional-Exception-Reports', {0, 1}},
     {'Rate-Control-Time-Unit', {0, 1}},
     {'Rate-Control-Max-Rate', {0, 1}}];
avp_arity('Application-Server-Information') ->
    [{'Application-Server', {0, 1}},
     {'Application-Provided-Called-Party-Address', {0, '*'}},
     {'Status-AS-Code', {0, 1}}];
avp_arity('Basic-Service-Code') ->
    [{'Bearer-Service', {0, 1}}, {'Teleservice', {0, 1}}];
avp_arity('Called-Identity-Change') ->
    [{'Called-Identity', {0, 1}}, {'Change-Time', {0, 1}}];
avp_arity('Coverage-Info') ->
    [{'Coverage-Status', {0, 1}},
     {'Change-Time', {0, 1}},
     {'Location-Info', {0, '*'}}];
avp_arity('CPDT-Information') ->
    [{'Serving-Node-Identity', {0, 1}},
     {'SGW-Change', {0, 1}},
     {'NIDD-Submission', {0, 1}}];
avp_arity('Current-Tariff') ->
    [{'Currency-Code', {0, 1}},
     {'Scale-Factor', {0, 1}},
     {'Rate-Element', {0, '*'}}];
avp_arity('Destination-Interface') ->
    [{'Interface-Id', {0, 1}},
     {'Interface-Text', {0, 1}},
     {'Interface-Port', {0, 1}},
     {'Interface-Type', {0, 1}}];
avp_arity('Early-Media-Description') ->
    [{'SDP-TimeStamps', {0, 1}},
     {'SDP-Media-Component', {0, '*'}},
     {'SDP-Session-Description', {0, '*'}}];
avp_arity('Enhanced-Diagnostics') ->
    [{'RAN-NAS-Release-Cause', {0, '*'}}];
avp_arity('Envelope') ->
    [{'Envelope-Start-Time', 1},
     {'Envelope-End-Time', {0, 1}},
     {'CC-Total-Octets', {0, 1}},
     {'CC-Input-Octets', {0, 1}},
     {'CC-Output-Octets', {0, 1}},
     {'CC-Service-Specific-Units', {0, 1}}];
avp_arity('Event-Type') ->
    [{'SIP-Method', {0, 1}},
     {'Event', {0, 1}},
     {'Expires', {0, 1}}];
avp_arity('Incremental-Cost') ->
    [{'Value-Digits', 1}, {'Exponent', {0, 1}}];
avp_arity('IMS-Information') ->
    [{'Node-Functionality', 1},
     {'Event-Type', {0, 1}},
     {'Role-Of-Node', {0, 1}},
     {'User-Session-Id', {0, 1}},
     {'Outgoing-Session-Id', {0, 1}},
     {'Session-Priority', {0, 1}},
     {'Calling-Party-Address', {0, '*'}},
     {'Called-Party-Address', {0, 1}},
     {'Called-Asserted-Identity', {0, '*'}},
     {'Called-Identity-Change', {0, 1}},
     {'Number-Portability-Routing-Information', {0, 1}},
     {'Carrier-Select-Routing-Information', {0, 1}},
     {'Alternate-Charged-Party-Address', {0, 1}},
     {'Requested-Party-Address', {0, '*'}},
     {'Associated-URI', {0, '*'}},
     {'Time-Stamps', {0, 1}},
     {'Application-Server-Information', {0, '*'}},
     {'Inter-Operator-Identifier', {0, '*'}},
     {'Transit-IOI-List', {0, '*'}},
     {'IMS-Charging-Identifier', {0, 1}},
     {'SDP-Session-Description', {0, '*'}},
     {'SDP-Media-Component', {0, '*'}},
     {'Served-Party-IP-Address', {0, 1}},
     {'Trunk-Group-Id', {0, 1}},
     {'Bearer-Service', {0, 1}},
     {'Service-Id', {0, 1}},
     {'Service-Specific-Info', {0, '*'}},
     {'Message-Body', {0, '*'}},
     {'Cause-Code', {0, 1}},
     {'Reason-Header', {0, '*'}},
     {'Access-Network-Information', {0, '*'}},
     {'Cellular-Network-Information', {0, 1}},
     {'Early-Media-Description', {0, '*'}},
     {'IMS-Communication-Service-Identifier', {0, 1}},
     {'IMS-Application-Reference-Identifier', {0, 1}},
     {'Online-Charging-Flag', {0, 1}},
     {'Real-Time-Tariff-Information', {0, 1}},
     {'Account-Expiration', {0, 1}},
     {'Initial-IMS-Charging-Identifier', {0, 1}},
     {'NNI-Information', {0, '*'}},
     {'From-Address', {0, 1}},
     {'IMS-Emergency-Indicator', {0, 1}},
     {'IMS-Visited-Network-Identifier', {0, 1}},
     {'Access-Network-Info-Change', {0, '*'}},
     {'Access-Transfer-Information', {0, '*'}},
     {'Related-IMS-Charging-Identifier', {0, 1}},
     {'Related-IMS-Charging-Identifier-Node', {0, 1}},
     {'Route-Header-Received', {0, 1}},
     {'Route-Header-Transmitted', {0, 1}},
     {'Instance-Id', {0, 1}},
     {'TAD-Identifier', {0, 1}},
     {'FE-Identifier-List', {0, 1}}];
avp_arity('Inter-Operator-Identifier') ->
    [{'Originating-IOI', {0, 1}},
     {'Terminating-IOI', {0, 1}}];
avp_arity('ISUP-Cause') ->
    [{'ISUP-Cause-Location', {0, 1}},
     {'ISUP-Cause-Value', {0, 1}},
     {'ISUP-Cause-Diagnostics', {0, 1}}];
avp_arity('LCS-Client-ID') ->
    [{'LCS-Client-Type', {0, 1}},
     {'LCS-Client-External-ID', {0, 1}},
     {'LCS-Client-Dialed-By-MS', {0, 1}},
     {'LCS-Client-Name', {0, 1}},
     {'LCS-APN', {0, 1}},
     {'LCS-Requestor-ID', {0, 1}}];
avp_arity('LCS-Client-Name') ->
    [{'LCS-Data-Coding-Scheme', {0, 1}},
     {'LCS-Name-String', {0, 1}},
     {'LCS-Format-Indicator', {0, 1}}];
avp_arity('LCS-Information') ->
    [{'LCS-Client-ID', {0, 1}},
     {'Location-Type', {0, 1}},
     {'Location-Estimate', {0, 1}},
     {'Positioning-Data', {0, 1}},
     {'3GPP-IMSI', {0, 1}},
     {'MSISDN', {0, 1}}];
avp_arity('LCS-Requestor-ID') ->
    [{'LCS-Data-Coding-Scheme', {0, 1}},
     {'LCS-Requestor-ID-String', {0, 1}}];
avp_arity('Location-Info') ->
    [{'3GPP-User-Location-Info', {0, 1}},
     {'Change-Time', {0, 1}}];
avp_arity('Location-Type') ->
    [{'Location-Estimate-Type', {0, 1}},
     {'Deferred-Location-Event-Type', {0, 1}}];
avp_arity('MBMS-Information') ->
    [{'TMGI', {0, 1}},
     {'MBMS-User-Service-Type', {0, 1}},
     {'File-Repair-Supported', {0, 1}},
     {'MBMS-2G-3G-Indicator', {0, 1}},
     {'MBMS-Service-Area', {0, '*'}},
     {'MBMS-Session-Identity', {0, 1}},
     {'CN-IP-Multicast-Distribution', {0, 1}},
     {'MBMS-GW-Address', {0, 1}},
     {'MBMS-Charged-Party', {0, 1}},
     {'MSISDN', {0, '*'}}];
avp_arity('Message-Body') ->
    [{'Content-Type', 1},
     {'Content-Length', 1},
     {'Content-Disposition', {0, 1}},
     {'Originator', {0, 1}}];
avp_arity('Message-Class') ->
    [{'Class-Identifier', {0, 1}}, {'Token-Text', {0, 1}}];
avp_arity('MM-Content-Type') ->
    [{'Type-Number', {0, 1}},
     {'Additional-Type-Information', {0, 1}},
     {'Content-Size', {0, 1}},
     {'Additional-Content-Information', {0, '*'}}];
avp_arity('MMS-Information') ->
    [{'Originator-Address', {0, 1}},
     {'Recipient-Address', {0, '*'}},
     {'Submission-Time', {0, 1}},
     {'MM-Content-Type', {0, 1}},
     {'Priority', {0, 1}},
     {'Message-ID', {0, 1}},
     {'Message-Type', {0, 1}},
     {'Message-Size', {0, 1}},
     {'Message-Class', {0, 1}},
     {'Delivery-Report-Requested', {0, 1}},
     {'Read-Reply-Report-Requested', {0, 1}},
     {'MMBox-Storage-Requested', {0, 1}},
     {'Applic-ID', {0, 1}},
     {'Reply-Applic-ID', {0, 1}},
     {'Aux-Applic-Info', {0, 1}},
     {'Content-Class', {0, 1}},
     {'DRM-Content', {0, 1}},
     {'Adaptations', {0, 1}}];
avp_arity('MMTel-Information') ->
    [{'Supplementary-Service', {0, '*'}}];
avp_arity('Monitoring-Event-Information') ->
    [{'Monitoring-Event-Functionality', {0, 1}},
     {'Event-Timestamp', {0, 1}},
     {'Monitoring-Event-Configuration-Activity', {0, 1}},
     {'Charged-Party', {0, 1}},
     {'Monitoring-Event-Report-Data', {0, '*'}}];
avp_arity('Monitoring-Event-Report-Data') ->
    [{'Event-Timestamp', {0, 1}},
     {'Monitoring-Event-Report-Number', {0, 1}},
     {'Charged-Party', {0, 1}},
     {'Subscription-Id', {0, 1}}];
avp_arity('Next-Tariff') ->
    [{'Currency-Code', {0, 1}},
     {'Scale-Factor', {0, 1}},
     {'Rate-Element', {0, '*'}}];
avp_arity('NIDD-Submission') ->
    [{'Submission-Time', {0, 1}},
     {'Event-Timestamp', {0, 1}},
     {'Accounting-Input-Octets', {0, 1}},
     {'Accounting-Output-Octets', {0, 1}},
     {'Change-Condition', {0, 1}}];
avp_arity('NNI-Information') ->
    [{'Session-Direction', {0, 1}},
     {'NNI-Type', {0, 1}},
     {'Relationship-Mode', {0, 1}},
     {'Neighbour-Node-Address', {0, 1}}];
avp_arity('Offline-Charging') ->
    [{'Quota-Consumption-Time', {0, 1}},
     {'Time-Quota-Mechanism', {0, 1}},
     {'Envelope-Reporting', {0, 1}},
     {'Multiple-Services-Credit-Control', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('Originator-Address') ->
    [{'Address-Type', {0, 1}},
     {'Address-Data', {0, 1}},
     {'Address-Domain', {0, 1}}];
avp_arity('Originator-Interface') ->
    [{'Interface-Id', {0, 1}},
     {'Interface-Text', {0, 1}},
     {'Interface-Port', {0, 1}},
     {'Interface-Type', {0, 1}}];
avp_arity('Originator-Received-Address') ->
    [{'Address-Type', {0, 1}},
     {'Address-Data', {0, 1}},
     {'Address-Domain', {0, 1}}];
avp_arity('Participant-Group') ->
    [{'Called-Party-Address', {0, 1}},
     {'Participant-Access-Priority', {0, 1}},
     {'User-Participating-Type', {0, 1}}];
avp_arity('PoC-Information') ->
    [{'PoC-Server-Role', {0, 1}},
     {'PoC-Session-Type', {0, 1}},
     {'PoC-User-Role', {0, 1}},
     {'PoC-Session-Initiation-Type', {0, 1}},
     {'PoC-Event-Type', {0, 1}},
     {'Number-Of-Participants', {0, 1}},
     {'Participants-Involved', {0, '*'}},
     {'Participant-Group', {0, '*'}},
     {'Talk-Burst-Exchange', {0, '*'}},
     {'PoC-Controlling-Address', {0, 1}},
     {'PoC-Group-Name', {0, 1}},
     {'PoC-Session-Id', {0, 1}},
     {'Charged-Party', {0, 1}}];
avp_arity('PoC-User-Role') ->
    [{'PoC-User-Role-IDs', {0, 1}},
     {'PoC-User-Role-Info-Units', {0, 1}}];
avp_arity('ProSe-Direct-Communication-Reception-Data-Container') ->
    [{'Local-Sequence-Number', {0, 1}},
     {'Coverage-Status', {0, 1}},
     {'3GPP-User-Location-Info', {0, 1}},
     {'Accounting-Input-Octets', {0, 1}},
     {'Change-Time', {0, 1}},
     {'Change-Condition', {0, 1}},
     {'Usage-Information-Report-Sequence-Number', {0, 1}},
     {'Radio-Resources-Indicator', {0, 1}},
     {'Radio-Frequency', {0, 1}}];
avp_arity('ProSe-Direct-Communication-Transmission-Data-Container') ->
    [{'Local-Sequence-Number', {0, 1}},
     {'Coverage-Status', {0, 1}},
     {'3GPP-User-Location-Info', {0, 1}},
     {'Accounting-Output-Octets', {0, 1}},
     {'Change-Time', {0, 1}},
     {'Change-Condition', {0, 1}},
     {'Usage-Information-Report-Sequence-Number', {0, 1}},
     {'Radio-Resources-Indicator', {0, 1}},
     {'Radio-Frequency', {0, 1}}];
avp_arity('ProSe-Information') ->
    [{'Announcing-UE-HPLMN-Identifier', {0, 1}},
     {'Announcing-UE-VPLMN-Identifier', {0, 1}},
     {'Monitoring-UE-HPLMN-Identifier', {0, 1}},
     {'Monitoring-UE-VPLMN-Identifier', {0, 1}},
     {'Role-Of-ProSe-Function', {0, 1}},
     {'ProSe-3rd-Party-Application-ID', {0, 1}},
     {'Application-Specific-Data', {0, 1}},
     {'ProSe-Event-Type', {0, 1}},
     {'ProSe-Direct-Discovery-Model', {0, 1}},
     {'ProSe-Function-IP-Address', {0, 1}},
     {'ProSe-Role-Of-UE', {0, 1}},
     {'ProSe-Request-Timestamp', {0, 1}},
     {'PC3-Control-Protocol-Cause', {0, 1}},
     {'Monitoring-UE-Identifier', {0, 1}},
     {'Requestor-PLMN-Identifier', {0, 1}},
     {'Requested-PLMN-Identifier', {0, 1}},
     {'ProSe-Range-Class', {0, 1}},
     {'Proximity-Alert-Indication', {0, 1}},
     {'Proximity-Alert-Timestamp', {0, 1}},
     {'Proximity-Cancellation-Timestamp', {0, 1}},
     {'ProSe-Reason-For-Cancellation', {0, 1}},
     {'PC3-EPC-Control-Protocol-Cause', {0, 1}},
     {'ProSe-UE-ID', {0, 1}},
     {'ProSe-Source-IP-Address', {0, 1}},
     {'Layer-2-Group-ID', {0, 1}},
     {'ProSe-Group-IP-Multicast-Address', {0, 1}},
     {'Coverage-Info', {0, '*'}},
     {'Radio-Parameter-Set-Info', {0, '*'}},
     {'Transmitter-Info', {0, '*'}},
     {'Time-First-Transmission', {0, 1}},
     {'Time-First-Reception', {0, 1}},
     {'ProSe-Direct-Communication-Transmission-Data-Container',
      {0, '*'}},
     {'ProSe-Direct-Communication-Reception-Data-Container',
      {0, '*'}},
     {'Announcing-PLMN-ID', {0, 1}},
     {'ProSe-Target-Layer-2-ID', {0, 1}},
     {'Relay-IP-address', {0, 1}},
     {'ProSe-UE-to-Network-Relay-UE-ID', {0, 1}},
     {'Target-IP-Address', {0, 1}},
     {'PC5-Radio-Technology', {0, 1}}];
avp_arity('PS-Furnish-Charging-Information') ->
    [{'3GPP-Charging-Id', 1},
     {'PS-Free-Format-Data', 1},
     {'PS-Append-Free-Format-Data', {0, 1}}];
avp_arity('PS-Information') ->
    [{'3GPP-Charging-Id', {0, 1}},
     {'PDN-Connection-Charging-ID', {0, 1}},
     {'Node-Id', {0, 1}},
     {'3GPP-PDP-Type', {0, 1}},
     {'PDP-Address', {0, '*'}},
     {'PDP-Address-Prefix-Length', {0, 1}},
     {'Dynamic-Address-Flag', {0, 1}},
     {'Dynamic-Address-Flag-Extension', {0, 1}},
     {'QoS-Information', {0, 1}},
     {'SGSN-Address', {0, '*'}},
     {'GGSN-Address', {0, '*'}},
     {'TDF-IP-Address', {0, '*'}},
     {'SGW-Address', {0, '*'}},
     {'TWAG-Address', {0, '*'}},
     {'CG-Address', {0, 1}},
     {'Serving-Node-Type', {0, 1}},
     {'SGW-Change', {0, 1}},
     {'3GPP-IMSI-MCC-MNC', {0, 1}},
     {'IMSI-Unauthenticated-Flag', {0, 1}},
     {'3GPP-GGSN-MCC-MNC', {0, 1}},
     {'3GPP-NSAPI', {0, 1}},
     {'Called-Station-Id', {0, 1}},
     {'3GPP-Session-Stop-Indicator', {0, 1}},
     {'3GPP-Selection-Mode', {0, 1}},
     {'3GPP-Charging-Characteristics', {0, 1}},
     {'Charging-Characteristics-Selection-Mode', {0, 1}},
     {'3GPP-SGSN-MCC-MNC', {0, 1}},
     {'3GPP-MS-TimeZone', {0, 1}},
     {'Charging-Rule-Base-Name', {0, 1}},
     {'3GPP-User-Location-Info', {0, 1}},
     {'User-Location-Info-Time', {0, 1}},
     {'User-CSG-Information', {0, 1}},
     {'Presence-Reporting-Area-Information', {0, '*'}},
     {'TWAN-User-Location-Info', {0, 1}},
     {'UWAN-User-Location-Info', {0, 1}},
     {'3GPP-RAT-Type', {0, 1}},
     {'PS-Furnish-Charging-Information', {0, 1}},
     {'PDP-Context-Type', {0, 1}},
     {'Offline-Charging', {0, 1}},
     {'Traffic-Data-Volumes', {0, '*'}},
     {'Service-Data-Container', {0, '*'}},
     {'User-Equipment-Info', {0, 1}},
     {'Start-Time', {0, 1}},
     {'Stop-Time', {0, 1}},
     {'Change-Condition', {0, 1}},
     {'Diagnostics', {0, 1}},
     {'Low-Priority-Indicator', {0, 1}},
     {'Logical-Access-ID', {0, 1}},
     {'Physical-Access-ID', {0, 1}},
     {'Fixed-User-Location-Info', {0, 1}},
     {'CN-Operator-Selection-Entity', {0, 1}},
     {'Enhanced-Diagnostics', {0, 1}},
     {'SGi-PtP-Tunnelling-Method', {0, 1}},
     {'CP-CIoT-EPS-Optimisation-Indicator', {0, 1}},
     {'UNI-PDU-CP-Only-Flag', {0, 1}},
     {'APN-Rate-Control', {0, 1}},
     {'Charging-Per-IP-CAN-Session-Indicator', {0, 1}},
     {'3GPP-PS-Data-Off-Status', {0, 1}},
     {'SCS-AS-Address', {0, 1}},
     {'Unused-Quota-Timer', {0, 1}},
     {'RAN-Secondary-RAT-Usage-Report', {0, '*'}},
     {'AVP', {0, '*'}}];
avp_arity('Radio-Parameter-Set-Info') ->
    [{'Radio-Parameter-Set-Values', {0, 1}},
     {'Change-Time', {0, 1}}];
avp_arity('RAN-Secondary-RAT-Usage-Report') ->
    [{'Secondary-RAT-Type', {0, 1}},
     {'RAN-Start-Timestamp', {0, 1}},
     {'RAN-End-Timestamp', {0, 1}},
     {'Accounting-Input-Octets', {0, 1}},
     {'Accounting-Output-Octets', {0, 1}},
     {'3GPP-Charging-Id', {0, 1}}];
avp_arity('Rate-Element') ->
    [{'CC-Unit-Type', 1},
     {'Charge-Reason-Code', {0, 1}},
     {'Unit-Value', {0, 1}},
     {'Unit-Cost', {0, 1}},
     {'Unit-Quota-Threshold', {0, 1}}];
avp_arity('Real-Time-Tariff-Information') ->
    [{'Tariff-Information', {0, 1}},
     {'Tariff-XML', {0, 1}}];
avp_arity('Recipient-Address') ->
    [{'Address-Type', {0, 1}},
     {'Address-Data', {0, 1}},
     {'Address-Domain', {0, 1}},
     {'Addressee-Type', {0, 1}}];
avp_arity('Recipient-Info') ->
    [{'Destination-Interface', {0, 1}},
     {'Recipient-Address', {0, '*'}},
     {'Recipient-Received-Address', {0, '*'}},
     {'Recipient-SCCP-Address', {0, 1}},
     {'SM-Protocol-ID', {0, 1}}];
avp_arity('Recipient-Received-Address') ->
    [{'Address-Type', {0, 1}},
     {'Address-Data', {0, 1}},
     {'Address-Domain', {0, 1}}];
avp_arity('Related-Change-Condition-Information') ->
    [{'SGSN-Address', {0, 1}},
     {'Change-Condition', {0, '*'}},
     {'3GPP-User-Location-Info', {0, 1}},
     {'UWAN-User-Location-Info', {0, 1}},
     {'Presence-Reporting-Area-Status', {0, 1}},
     {'User-CSG-Information', {0, 1}},
     {'3GPP-RAT-Type', {0, 1}}];
avp_arity('Related-Trigger') ->
    [{'Trigger-Type', {0, '*'}}];
avp_arity('Remaining-Balance') ->
    [{'Unit-Value', 1}, {'Currency-Code', 1}];
avp_arity('Scale-Factor') ->
    [{'Value-Digits', 1}, {'Exponent', {0, 1}}];
avp_arity('SCS-AS-Address') ->
    [{'SCS-Realm', {0, 1}}, {'SCS-Address', {0, 1}}];
avp_arity('SDP-Media-Component') ->
    [{'SDP-Media-Name', {0, 1}},
     {'SDP-Media-Description', {0, '*'}},
     {'Local-GW-Inserted-Indication', {0, 1}},
     {'IP-Realm-Default-Indication', {0, 1}},
     {'Transcoder-Inserted-Indication', {0, 1}},
     {'Media-Initiator-Flag', {0, 1}},
     {'Media-Initiator-Party', {0, 1}},
     {'3GPP-Charging-Id', {0, 1}},
     {'Access-Network-Charging-Identifier-Value', {0, 1}},
     {'SDP-Type', {0, 1}}];
avp_arity('SDP-TimeStamps') ->
    [{'SDP-Offer-Timestamp', {0, 1}},
     {'SDP-Answer-Timestamp', {0, 1}}];
avp_arity('Service-Data-Container') ->
    [{'AF-Correlation-Information', {0, 1}},
     {'Charging-Rule-Base-Name', {0, 1}},
     {'Accounting-Input-Octets', {0, 1}},
     {'Accounting-Output-Octets', {0, 1}},
     {'Local-Sequence-Number', {0, 1}},
     {'QoS-Information', {0, 1}},
     {'Rating-Group', {0, 1}},
     {'Change-Time', {0, 1}},
     {'Service-Identifier', {0, 1}},
     {'Service-Specific-Info', {0, 1}},
     {'SGSN-Address', {0, 1}},
     {'Time-First-Usage', {0, 1}},
     {'Time-Last-Usage', {0, 1}},
     {'Time-Usage', {0, 1}},
     {'Change-Condition', {0, '*'}},
     {'3GPP-User-Location-Info', {0, 1}},
     {'UWAN-User-Location-Info', {0, 1}},
     {'Sponsor-Identity', {0, 1}},
     {'Application-Service-Provider-Identity', {0, 1}},
     {'Presence-Reporting-Area-Information', {0, '*'}},
     {'Presence-Reporting-Area-Status', {0, 1}},
     {'User-CSG-Information', {0, 1}},
     {'3GPP-RAT-Type', {0, 1}},
     {'Related-Change-Condition-Information', {0, 1}},
     {'APN-Rate-Control', {0, 1}},
     {'3GPP-PS-Data-Off-Status', {0, 1}}];
avp_arity('Service-Specific-Info') ->
    [{'Service-Specific-Data', {0, 1}},
     {'Service-Specific-Type', {0, 1}}];
avp_arity('SM-Device-Trigger-Information') ->
    [{'MTC-IWF-Address', {0, 1}},
     {'Validity-Time', {0, 1}}];
avp_arity('SMS-Information') ->
    [{'SMS-Node', {0, 1}},
     {'Client-Address', {0, 1}},
     {'Originator-SCCP-Address', {0, 1}},
     {'SMSC-Address', {0, 1}},
     {'Data-Coding-Scheme', {0, 1}},
     {'SM-Discharge-Time', {0, 1}},
     {'SM-Message-Type', {0, 1}},
     {'Originator-Interface', {0, 1}},
     {'SM-Protocol-ID', {0, 1}},
     {'Reply-Path-Requested', {0, 1}},
     {'SM-Status', {0, 1}},
     {'SM-User-Data-Header', {0, 1}},
     {'Number-Of-Messages-Sent', {0, 1}},
     {'SM-Sequence-Number', {0, 1}},
     {'Recipient-Info', {0, '*'}},
     {'Originator-Received-Address', {0, 1}},
     {'SM-Service-Type', {0, 1}},
     {'SMS-Result', {0, 1}},
     {'SM-Device-Trigger-Indicator', {0, 1}},
     {'SM-Device-Trigger-Information', {0, 1}},
     {'MTC-IWF-Address', {0, 1}}];
avp_arity('Supplementary-Service') ->
    [{'MMTel-SService-Type', {0, 1}},
     {'Service-Mode', {0, 1}},
     {'Number-Of-Diversions', {0, 1}},
     {'Associated-Party-Address', {0, 1}},
     {'Service-Id', {0, 1}},
     {'Change-Time', {0, 1}},
     {'Number-Of-Participants', {0, 1}},
     {'Participant-Action-Type', {0, 1}},
     {'CUG-Information', {0, 1}},
     {'AoC-Information', {0, 1}}];
avp_arity('Talk-Burst-Exchange') ->
    [{'PoC-Change-Time', 1},
     {'Number-Of-Talk-Bursts', {0, 1}},
     {'Talk-Burst-Volume', {0, 1}},
     {'Talk-Burst-Time', {0, 1}},
     {'Number-Of-Received-Talk-Bursts', {0, 1}},
     {'Received-Talk-Burst-Volume', {0, 1}},
     {'Received-Talk-Burst-Time', {0, 1}},
     {'Number-Of-Participants', {0, 1}},
     {'PoC-Change-Condition', {0, 1}}];
avp_arity('Tariff-Information') ->
    [{'Current-Tariff', 1},
     {'Tariff-Time-Change', {0, 1}},
     {'Next-Tariff', {0, 1}}];
avp_arity('Time-Quota-Mechanism') ->
    [{'Time-Quota-Type', 1}, {'Base-Time-Interval', 1}];
avp_arity('Time-Stamps') ->
    [{'SIP-Request-Timestamp', {0, 1}},
     {'SIP-Response-Timestamp', {0, 1}},
     {'SIP-Request-Timestamp-Fraction', {0, 1}},
     {'SIP-Response-Timestamp-Fraction', {0, 1}}];
avp_arity('Traffic-Data-Volumes') ->
    [{'QoS-Information', {0, 1}},
     {'Accounting-Input-Octets', {0, 1}},
     {'Accounting-Output-Octets', {0, 1}},
     {'Change-Condition', {0, 1}},
     {'Change-Time', {0, 1}},
     {'3GPP-User-Location-Info', {0, 1}},
     {'UWAN-User-Location-Info', {0, 1}},
     {'3GPP-Charging-Id', {0, 1}},
     {'Presence-Reporting-Area-Status', {0, 1}},
     {'User-CSG-Information', {0, 1}},
     {'3GPP-RAT-Type', {0, 1}},
     {'Related-Change-Condition-Information', {0, 1}},
     {'Diagnostics', {0, 1}},
     {'Enhanced-Diagnostics', {0, 1}},
     {'CP-CIoT-EPS-Optimisation-Indicator', {0, 1}}];
avp_arity('Transmitter-Info') ->
    [{'ProSe-Source-IP-Address', {0, 1}},
     {'ProSe-UE-ID', {0, 1}}];
avp_arity('Trigger') -> [{'Trigger-Type', {0, '*'}}];
avp_arity('Trunk-Group-Id') ->
    [{'Incoming-Trunk-Group-Id', {0, 1}},
     {'Outgoing-Trunk-Group-Id', {0, 1}}];
avp_arity('TWAN-User-Location-Info') ->
    [{'BSSID', {0, 1}}];
avp_arity('Unit-Cost') ->
    [{'Value-Digits', 1}, {'Exponent', {0, 1}}];
avp_arity('User-CSG-Information') ->
    [{'CSG-Access-Mode', 1},
     {'CSG-Membership-Indication', {0, 1}}];
avp_arity('UWAN-User-Location-Info') ->
    [{'UE-Local-IP-Address', 1},
     {'UDP-Source-Port', {0, 1}},
     {'BSSID', {0, 1}}];
avp_arity('Variable-Part') ->
    [{'Variable-Part-Type', 1},
     {'Variable-Part-Value', 1},
     {'Variable-Part-Order', {0, 1}}];
avp_arity('VCS-Information') ->
    [{'Bearer-Capability', {0, 1}},
     {'Network-Call-Reference-Number', {0, 1}},
     {'MSC-Address', {0, 1}},
     {'Basic-Service-Code', {0, 1}},
     {'ISUP-Location-Number', {0, 1}},
     {'VLR-Number', {0, 1}},
     {'Forwarding-Pending', {0, 1}},
     {'ISUP-Cause', {0, 1}},
     {'Start-Time', {0, 1}},
     {'Start-of-Charging', {0, 1}},
     {'Stop-Time', {0, 1}},
     {'PS-Free-Format-Data', {0, 1}}];
avp_arity(_) -> erlang:error(badarg).

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
avp_arity('Access-Network-Charging-Identifier-Gx',
          'Access-Network-Charging-Identifier-Value') ->
    1;
avp_arity('Access-Network-Charging-Identifier-Gx',
          'Charging-Rule-Base-Name') ->
    {0, '*'};
avp_arity('Access-Network-Charging-Identifier-Gx',
          'Charging-Rule-Name') ->
    {0, '*'};
avp_arity('Access-Network-Charging-Identifier-Gx',
          'IP-CAN-Session-Charging-Scope') ->
    {0, 1};
avp_arity('Access-Network-Charging-Identifier-Gx',
          'AVP') ->
    {0, '*'};
avp_arity('Allocation-Retention-Priority',
          'Priority-Level') ->
    1;
avp_arity('Allocation-Retention-Priority',
          'Pre-emption-Capability') ->
    {0, 1};
avp_arity('Allocation-Retention-Priority',
          'Pre-emption-Vulnerability') ->
    {0, 1};
avp_arity('Application-Detection-Information',
          'TDF-Application-Identifier') ->
    1;
avp_arity('Application-Detection-Information',
          'TDF-Application-Instance-Identifier') ->
    {0, 1};
avp_arity('Application-Detection-Information',
          'Flow-Information') ->
    {0, '*'};
avp_arity('Application-Detection-Information', 'AVP') ->
    {0, '*'};
avp_arity('Charging-Rule-Definition',
          'Charging-Rule-Name') ->
    1;
avp_arity('Charging-Rule-Definition',
          'Service-Identifier') ->
    {0, 1};
avp_arity('Charging-Rule-Definition', 'Rating-Group') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'Flow-Information') ->
    {0, '*'};
avp_arity('Charging-Rule-Definition',
          'TDF-Application-Identifier') ->
    {0, 1};
avp_arity('Charging-Rule-Definition', 'Flow-Status') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'QoS-Information') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'PS-to-CS-Session-Continuity') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'Reporting-Level') ->
    {0, 1};
avp_arity('Charging-Rule-Definition', 'Online') ->
    {0, 1};
avp_arity('Charging-Rule-Definition', 'Offline') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'Metering-Method') ->
    {0, 1};
avp_arity('Charging-Rule-Definition', 'Precedence') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'AF-Charging-Identifier') ->
    {0, 1};
avp_arity('Charging-Rule-Definition', 'Flows') ->
    {0, '*'};
avp_arity('Charging-Rule-Definition',
          'Monitoring-Key') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'Redirect-Information') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'Mute-Notification') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'AF-Signalling-Protocol') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'Sponsor-Identity') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'Application-Service-Provider-Identity') ->
    {0, 1};
avp_arity('Charging-Rule-Definition',
          'Required-Access-Info') ->
    {0, '*'};
avp_arity('Charging-Rule-Definition', 'AVP') ->
    {0, '*'};
avp_arity('Charging-Rule-Install',
          'Charging-Rule-Definition') ->
    {0, '*'};
avp_arity('Charging-Rule-Install',
          'Charging-Rule-Name') ->
    {0, '*'};
avp_arity('Charging-Rule-Install',
          'Charging-Rule-Base-Name') ->
    {0, '*'};
avp_arity('Charging-Rule-Install',
          'Bearer-Identifier') ->
    {0, 1};
avp_arity('Charging-Rule-Install',
          'Rule-Activation-Time') ->
    {0, 1};
avp_arity('Charging-Rule-Install',
          'Rule-Deactivation-Time') ->
    {0, 1};
avp_arity('Charging-Rule-Install',
          'Resource-Allocation-Notification') ->
    {0, 1};
avp_arity('Charging-Rule-Install',
          'Charging-Correlation-Indicator') ->
    {0, 1};
avp_arity('Charging-Rule-Install', 'AVP') -> {0, '*'};
avp_arity('Charging-Rule-Remove',
          'Charging-Rule-Name') ->
    {0, '*'};
avp_arity('Charging-Rule-Remove',
          'Charging-Rule-Base-Name') ->
    {0, '*'};
avp_arity('Charging-Rule-Remove',
          'Required-Access-Info') ->
    {0, '*'};
avp_arity('Charging-Rule-Remove', 'AVP') -> {0, '*'};
avp_arity('Charging-Rule-Report',
          'Charging-Rule-Name') ->
    {0, '*'};
avp_arity('Charging-Rule-Report',
          'Charging-Rule-Base-Name') ->
    {0, '*'};
avp_arity('Charging-Rule-Report',
          'Bearer-Identifier') ->
    {0, 1};
avp_arity('Charging-Rule-Report', 'PCC-Rule-Status') ->
    {0, 1};
avp_arity('Charging-Rule-Report',
          'Rule-Failure-Code') ->
    {0, 1};
avp_arity('Charging-Rule-Report',
          'Final-Unit-Indication') ->
    {0, 1};
avp_arity('Charging-Rule-Report',
          'RAN-NAS-Release-Cause') ->
    {0, '*'};
avp_arity('Charging-Rule-Report', 'AVP') -> {0, '*'};
avp_arity('CoA-Information', 'Tunnel-Information') -> 1;
avp_arity('CoA-Information', 'CoA-IP-Address') -> 1;
avp_arity('CoA-Information', 'AVP') -> {0, '*'};
avp_arity('Conditional-APN-Aggregate-Max-Bitrate',
          'APN-Aggregate-Max-Bitrate-UL') ->
    {0, 1};
avp_arity('Conditional-APN-Aggregate-Max-Bitrate',
          'APN-Aggregate-Max-Bitrate-DL') ->
    {0, 1};
avp_arity('Conditional-APN-Aggregate-Max-Bitrate',
          'IP-CAN-Type') ->
    {0, '*'};
avp_arity('Conditional-APN-Aggregate-Max-Bitrate',
          'RAT-Type') ->
    {0, '*'};
avp_arity('Conditional-APN-Aggregate-Max-Bitrate',
          'AVP') ->
    {0, '*'};
avp_arity('Default-EPS-Bearer-QoS',
          'QoS-Class-Identifier') ->
    {0, 1};
avp_arity('Default-EPS-Bearer-QoS',
          'Allocation-Retention-Priority') ->
    {0, 1};
avp_arity('Default-EPS-Bearer-QoS', 'AVP') -> {0, '*'};
avp_arity('Default-QoS-Information',
          'QoS-Class-Identifier') ->
    {0, 1};
avp_arity('Default-QoS-Information',
          'Max-Requested-Bandwidth-UL') ->
    {0, 1};
avp_arity('Default-QoS-Information',
          'Max-Requested-Bandwidth-DL') ->
    {0, 1};
avp_arity('Default-QoS-Information',
          'Default-QoS-Name') ->
    {0, 1};
avp_arity('Default-QoS-Information', 'AVP') -> {0, '*'};
avp_arity('Event-Report-Indication', 'Event-Trigger') ->
    {0, '*'};
avp_arity('Event-Report-Indication', 'IP-CAN-Type') ->
    {0, 1};
avp_arity('Event-Report-Indication', 'AN-GW-Address') ->
    {0, 2};
avp_arity('Event-Report-Indication',
          '3GPP-SGSN-Address') ->
    {0, 1};
avp_arity('Event-Report-Indication',
          '3GPP-SGSN-IPv6-Address') ->
    {0, 1};
avp_arity('Event-Report-Indication',
          '3GPP-SGSN-MCC-MNC') ->
    {0, 1};
avp_arity('Event-Report-Indication',
          'Framed-IP-Address') ->
    {0, 1};
avp_arity('Event-Report-Indication', 'RAT-Type') ->
    {0, 1};
avp_arity('Event-Report-Indication', 'RAI') -> {0, 1};
avp_arity('Event-Report-Indication',
          '3GPP-User-Location-Info') ->
    {0, 1};
avp_arity('Event-Report-Indication',
          '3GPP-MS-TimeZone') ->
    {0, 1};
avp_arity('Event-Report-Indication',
          'Routing-IP-Address') ->
    {0, 1};
avp_arity('Event-Report-Indication',
          'UE-Local-IP-Address') ->
    {0, 1};
avp_arity('Event-Report-Indication',
          'HeNB-Local-IP-Address') ->
    {0, 1};
avp_arity('Event-Report-Indication',
          'UDP-Source-Port') ->
    {0, 1};
avp_arity('Event-Report-Indication',
          'Presence-Reporting-Area-Information') ->
    {0, 1};
avp_arity('Event-Report-Indication', 'AVP') -> {0, '*'};
avp_arity('Fixed-User-Location-Info',
          'Logical-Access-ID') ->
    {0, 1};
avp_arity('Fixed-User-Location-Info',
          'Physical-Access-ID') ->
    {0, 1};
avp_arity('Fixed-User-Location-Info', 'AVP') ->
    {0, '*'};
avp_arity('Flow-Information', 'Flow-Description') ->
    {0, 1};
avp_arity('Flow-Information',
          'Packet-Filter-Identifier') ->
    {0, 1};
avp_arity('Flow-Information', 'Packet-Filter-Usage') ->
    {0, 1};
avp_arity('Flow-Information', 'ToS-Traffic-Class') ->
    {0, 1};
avp_arity('Flow-Information',
          'Security-Parameter-Index') ->
    {0, 1};
avp_arity('Flow-Information', 'Flow-Label') -> {0, 1};
avp_arity('Flow-Information', 'Flow-Direction') ->
    {0, 1};
avp_arity('Flow-Information', 'AVP') -> {0, '*'};
avp_arity('Packet-Filter-Information',
          'Packet-Filter-Identifier') ->
    {0, 1};
avp_arity('Packet-Filter-Information', 'Precedence') ->
    {0, 1};
avp_arity('Packet-Filter-Information',
          'Packet-Filter-Content') ->
    {0, 1};
avp_arity('Packet-Filter-Information',
          'ToS-Traffic-Class') ->
    {0, 1};
avp_arity('Packet-Filter-Information',
          'Security-Parameter-Index') ->
    {0, 1};
avp_arity('Packet-Filter-Information', 'Flow-Label') ->
    {0, 1};
avp_arity('Packet-Filter-Information',
          'Flow-Direction') ->
    {0, 1};
avp_arity('Packet-Filter-Information', 'AVP') ->
    {0, '*'};
avp_arity('Presence-Reporting-Area-Information',
          'Presence-Reporting-Area-Identifier') ->
    {0, 1};
avp_arity('Presence-Reporting-Area-Information',
          'Presence-Reporting-Area-Status') ->
    {0, 1};
avp_arity('Presence-Reporting-Area-Information',
          'Presence-Reporting-Area-Elements-List') ->
    {0, 1};
avp_arity('Presence-Reporting-Area-Information',
          'AVP') ->
    {0, '*'};
avp_arity('QoS-Information', 'QoS-Class-Identifier') ->
    {0, 1};
avp_arity('QoS-Information',
          'Max-Requested-Bandwidth-UL') ->
    {0, 1};
avp_arity('QoS-Information',
          'Max-Requested-Bandwidth-DL') ->
    {0, 1};
avp_arity('QoS-Information', 'Guaranteed-Bitrate-UL') ->
    {0, 1};
avp_arity('QoS-Information', 'Guaranteed-Bitrate-DL') ->
    {0, 1};
avp_arity('QoS-Information', 'Bearer-Identifier') ->
    {0, 1};
avp_arity('QoS-Information',
          'Allocation-Retention-Priority') ->
    {0, 1};
avp_arity('QoS-Information',
          'APN-Aggregate-Max-Bitrate-UL') ->
    {0, 1};
avp_arity('QoS-Information',
          'APN-Aggregate-Max-Bitrate-DL') ->
    {0, 1};
avp_arity('QoS-Information',
          'Conditional-APN-Aggregate-Max-Bitrate') ->
    {0, '*'};
avp_arity('QoS-Information', 'AVP') -> {0, '*'};
avp_arity('Redirect-Information', 'Redirect-Support') ->
    {0, 1};
avp_arity('Redirect-Information',
          'Redirect-Address-Type') ->
    {0, 1};
avp_arity('Redirect-Information',
          'Redirect-Server-Address') ->
    {0, 1};
avp_arity('Redirect-Information', 'AVP') -> {0, '*'};
avp_arity('Routing-Filter', 'Flow-Description') -> 1;
avp_arity('Routing-Filter', 'Flow-Direction') -> 1;
avp_arity('Routing-Filter', 'ToS-Traffic-Class') ->
    {0, 1};
avp_arity('Routing-Filter',
          'Security-Parameter-Index') ->
    {0, 1};
avp_arity('Routing-Filter', 'Flow-Label') -> {0, 1};
avp_arity('Routing-Filter', 'AVP') -> {0, '*'};
avp_arity('Routing-Rule-Definition',
          'Routing-Rule-Identifier') ->
    1;
avp_arity('Routing-Rule-Definition',
          'Routing-Filter') ->
    {0, '*'};
avp_arity('Routing-Rule-Definition', 'Precedence') ->
    {0, 1};
avp_arity('Routing-Rule-Definition',
          'Routing-IP-Address') ->
    {0, 1};
avp_arity('Routing-Rule-Definition', 'AVP') -> {0, '*'};
avp_arity('Routing-Rule-Install',
          'Routing-Rule-Definition') ->
    {0, '*'};
avp_arity('Routing-Rule-Install', 'AVP') -> {0, '*'};
avp_arity('Routing-Rule-Remove',
          'Routing-Rule-Identifier') ->
    {0, '*'};
avp_arity('Routing-Rule-Remove', 'AVP') -> {0, '*'};
avp_arity('TDF-Information', 'TDF-Destination-Realm') ->
    {0, 1};
avp_arity('TDF-Information', 'TDF-Destination-Host') ->
    {0, 1};
avp_arity('TDF-Information', 'TDF-IP-Address') ->
    {0, 1};
avp_arity('Tunnel-Information',
          'Tunnel-Header-Length') ->
    {0, 1};
avp_arity('Tunnel-Information',
          'Tunnel-Header-Filter') ->
    {0, 2};
avp_arity('Tunnel-Information', 'AVP') -> {0, '*'};
avp_arity('TFT-Packet-Filter-Information',
          'Precedence') ->
    {0, 1};
avp_arity('TFT-Packet-Filter-Information',
          'TFT-Filter') ->
    {0, 1};
avp_arity('TFT-Packet-Filter-Information',
          'ToS-Traffic-Class') ->
    {0, 1};
avp_arity('TFT-Packet-Filter-Information',
          'Security-Parameter-Index') ->
    {0, 1};
avp_arity('TFT-Packet-Filter-Information',
          'Flow-Label') ->
    {0, 1};
avp_arity('TFT-Packet-Filter-Information',
          'Flow-Direction') ->
    {0, 1};
avp_arity('TFT-Packet-Filter-Information', 'AVP') ->
    {0, '*'};
avp_arity('Usage-Monitoring-Information',
          'Monitoring-Key') ->
    {0, 1};
avp_arity('Usage-Monitoring-Information',
          'Granted-Service-Unit') ->
    {0, 2};
avp_arity('Usage-Monitoring-Information',
          'Used-Service-Unit') ->
    {0, 2};
avp_arity('Usage-Monitoring-Information',
          'Usage-Monitoring-Level') ->
    {0, 1};
avp_arity('Usage-Monitoring-Information',
          'Usage-Monitoring-Report') ->
    {0, 1};
avp_arity('Usage-Monitoring-Information',
          'Usage-Monitoring-Support') ->
    {0, 1};
avp_arity('Usage-Monitoring-Information', 'AVP') ->
    {0, '*'};
avp_arity('Access-Network-Info-Change',
          'Access-Network-Information') ->
    {0, '*'};
avp_arity('Access-Network-Info-Change',
          'Cellular-Network-Information') ->
    {0, 1};
avp_arity('Access-Network-Info-Change',
          'Change-Time') ->
    {0, 1};
avp_arity('Access-Transfer-Information',
          'Access-Transfer-Type') ->
    {0, 1};
avp_arity('Access-Transfer-Information',
          'Access-Network-Information') ->
    {0, '*'};
avp_arity('Access-Transfer-Information',
          'Cellular-Network-Information') ->
    {0, 1};
avp_arity('Access-Transfer-Information',
          'Inter-UE-Transfer') ->
    {0, 1};
avp_arity('Access-Transfer-Information',
          'User-Equipment-Info') ->
    {0, 1};
avp_arity('Access-Transfer-Information',
          'Instance-Id') ->
    {0, 1};
avp_arity('Access-Transfer-Information',
          'Related-IMS-Charging-Identifier') ->
    {0, 1};
avp_arity('Access-Transfer-Information',
          'Related-IMS-Charging-Identifier-Node') ->
    {0, 1};
avp_arity('Access-Transfer-Information',
          'Change-Time') ->
    {0, 1};
avp_arity('Accumulated-Cost', 'Value-Digits') -> 1;
avp_arity('Accumulated-Cost', 'Exponent') -> {0, 1};
avp_arity('Additional-Content-Information',
          'Type-Number') ->
    {0, 1};
avp_arity('Additional-Content-Information',
          'Additional-Type-Information') ->
    {0, 1};
avp_arity('Additional-Content-Information',
          'Content-Size') ->
    {0, 1};
avp_arity('Address-Domain', 'Domain-Name') -> {0, 1};
avp_arity('Address-Domain', '3GPP-IMSI-MCC-MNC') ->
    {0, 1};
avp_arity('AF-Correlation-Information',
          'AF-Charging-Identifier') ->
    1;
avp_arity('AF-Correlation-Information', 'Flows') ->
    {0, '*'};
avp_arity('Announcement-Information',
          'Announcement-Identifier') ->
    1;
avp_arity('Announcement-Information',
          'Variable-Part') ->
    {0, '*'};
avp_arity('Announcement-Information',
          'Time-Indicator') ->
    {0, 1};
avp_arity('Announcement-Information',
          'Quota-Indicator') ->
    {0, 1};
avp_arity('Announcement-Information',
          'Announcement-Order') ->
    {0, 1};
avp_arity('Announcement-Information',
          'Play-Alternative') ->
    {0, 1};
avp_arity('Announcement-Information',
          'Privacy-Indicator') ->
    {0, 1};
avp_arity('Announcement-Information', 'Language') ->
    {0, 1};
avp_arity('AoC-Cost-Information', 'Accumulated-Cost') ->
    {0, 1};
avp_arity('AoC-Cost-Information', 'Incremental-Cost') ->
    {0, '*'};
avp_arity('AoC-Cost-Information', 'Currency-Code') ->
    {0, 1};
avp_arity('AoC-Information', 'AoC-Cost-Information') ->
    {0, 1};
avp_arity('AoC-Information', 'Tariff-Information') ->
    {0, 1};
avp_arity('AoC-Information',
          'AoC-Subscription-Information') ->
    {0, 1};
avp_arity('AoC-Service',
          'AoC-Service-Obligatory-Type') ->
    {0, 1};
avp_arity('AoC-Service', 'AoC-Service-Type') -> {0, 1};
avp_arity('AoC-Subscription-Information',
          'AoC-Service') ->
    {0, '*'};
avp_arity('AoC-Subscription-Information',
          'AoC-Format') ->
    {0, 1};
avp_arity('AoC-Subscription-Information',
          'Preferred-AoC-Currency') ->
    {0, 1};
avp_arity('APN-Rate-Control',
          'APN-Rate-Control-Uplink') ->
    {0, 1};
avp_arity('APN-Rate-Control',
          'APN-Rate-Control-Downlink') ->
    {0, 1};
avp_arity('APN-Rate-Control-Downlink',
          'Rate-Control-Time-Unit') ->
    {0, 1};
avp_arity('APN-Rate-Control-Downlink',
          'Rate-Control-Max-Rate') ->
    {0, 1};
avp_arity('APN-Rate-Control-Downlink',
          'Rate-Control-Max-Message-Size') ->
    {0, 1};
avp_arity('APN-Rate-Control-Uplink',
          'Additional-Exception-Reports') ->
    {0, 1};
avp_arity('APN-Rate-Control-Uplink',
          'Rate-Control-Time-Unit') ->
    {0, 1};
avp_arity('APN-Rate-Control-Uplink',
          'Rate-Control-Max-Rate') ->
    {0, 1};
avp_arity('Application-Server-Information',
          'Application-Server') ->
    {0, 1};
avp_arity('Application-Server-Information',
          'Application-Provided-Called-Party-Address') ->
    {0, '*'};
avp_arity('Application-Server-Information',
          'Status-AS-Code') ->
    {0, 1};
avp_arity('Basic-Service-Code', 'Bearer-Service') ->
    {0, 1};
avp_arity('Basic-Service-Code', 'Teleservice') ->
    {0, 1};
avp_arity('Called-Identity-Change',
          'Called-Identity') ->
    {0, 1};
avp_arity('Called-Identity-Change', 'Change-Time') ->
    {0, 1};
avp_arity('Coverage-Info', 'Coverage-Status') -> {0, 1};
avp_arity('Coverage-Info', 'Change-Time') -> {0, 1};
avp_arity('Coverage-Info', 'Location-Info') -> {0, '*'};
avp_arity('CPDT-Information',
          'Serving-Node-Identity') ->
    {0, 1};
avp_arity('CPDT-Information', 'SGW-Change') -> {0, 1};
avp_arity('CPDT-Information', 'NIDD-Submission') ->
    {0, 1};
avp_arity('Current-Tariff', 'Currency-Code') -> {0, 1};
avp_arity('Current-Tariff', 'Scale-Factor') -> {0, 1};
avp_arity('Current-Tariff', 'Rate-Element') -> {0, '*'};
avp_arity('Destination-Interface', 'Interface-Id') ->
    {0, 1};
avp_arity('Destination-Interface', 'Interface-Text') ->
    {0, 1};
avp_arity('Destination-Interface', 'Interface-Port') ->
    {0, 1};
avp_arity('Destination-Interface', 'Interface-Type') ->
    {0, 1};
avp_arity('Early-Media-Description',
          'SDP-TimeStamps') ->
    {0, 1};
avp_arity('Early-Media-Description',
          'SDP-Media-Component') ->
    {0, '*'};
avp_arity('Early-Media-Description',
          'SDP-Session-Description') ->
    {0, '*'};
avp_arity('Enhanced-Diagnostics',
          'RAN-NAS-Release-Cause') ->
    {0, '*'};
avp_arity('Envelope', 'Envelope-Start-Time') -> 1;
avp_arity('Envelope', 'Envelope-End-Time') -> {0, 1};
avp_arity('Envelope', 'CC-Total-Octets') -> {0, 1};
avp_arity('Envelope', 'CC-Input-Octets') -> {0, 1};
avp_arity('Envelope', 'CC-Output-Octets') -> {0, 1};
avp_arity('Envelope', 'CC-Service-Specific-Units') ->
    {0, 1};
avp_arity('Event-Type', 'SIP-Method') -> {0, 1};
avp_arity('Event-Type', 'Event') -> {0, 1};
avp_arity('Event-Type', 'Expires') -> {0, 1};
avp_arity('Incremental-Cost', 'Value-Digits') -> 1;
avp_arity('Incremental-Cost', 'Exponent') -> {0, 1};
avp_arity('IMS-Information', 'Node-Functionality') -> 1;
avp_arity('IMS-Information', 'Event-Type') -> {0, 1};
avp_arity('IMS-Information', 'Role-Of-Node') -> {0, 1};
avp_arity('IMS-Information', 'User-Session-Id') ->
    {0, 1};
avp_arity('IMS-Information', 'Outgoing-Session-Id') ->
    {0, 1};
avp_arity('IMS-Information', 'Session-Priority') ->
    {0, 1};
avp_arity('IMS-Information', 'Calling-Party-Address') ->
    {0, '*'};
avp_arity('IMS-Information', 'Called-Party-Address') ->
    {0, 1};
avp_arity('IMS-Information',
          'Called-Asserted-Identity') ->
    {0, '*'};
avp_arity('IMS-Information',
          'Called-Identity-Change') ->
    {0, 1};
avp_arity('IMS-Information',
          'Number-Portability-Routing-Information') ->
    {0, 1};
avp_arity('IMS-Information',
          'Carrier-Select-Routing-Information') ->
    {0, 1};
avp_arity('IMS-Information',
          'Alternate-Charged-Party-Address') ->
    {0, 1};
avp_arity('IMS-Information',
          'Requested-Party-Address') ->
    {0, '*'};
avp_arity('IMS-Information', 'Associated-URI') ->
    {0, '*'};
avp_arity('IMS-Information', 'Time-Stamps') -> {0, 1};
avp_arity('IMS-Information',
          'Application-Server-Information') ->
    {0, '*'};
avp_arity('IMS-Information',
          'Inter-Operator-Identifier') ->
    {0, '*'};
avp_arity('IMS-Information', 'Transit-IOI-List') ->
    {0, '*'};
avp_arity('IMS-Information',
          'IMS-Charging-Identifier') ->
    {0, 1};
avp_arity('IMS-Information',
          'SDP-Session-Description') ->
    {0, '*'};
avp_arity('IMS-Information', 'SDP-Media-Component') ->
    {0, '*'};
avp_arity('IMS-Information',
          'Served-Party-IP-Address') ->
    {0, 1};
avp_arity('IMS-Information', 'Trunk-Group-Id') ->
    {0, 1};
avp_arity('IMS-Information', 'Bearer-Service') ->
    {0, 1};
avp_arity('IMS-Information', 'Service-Id') -> {0, 1};
avp_arity('IMS-Information', 'Service-Specific-Info') ->
    {0, '*'};
avp_arity('IMS-Information', 'Message-Body') ->
    {0, '*'};
avp_arity('IMS-Information', 'Cause-Code') -> {0, 1};
avp_arity('IMS-Information', 'Reason-Header') ->
    {0, '*'};
avp_arity('IMS-Information',
          'Access-Network-Information') ->
    {0, '*'};
avp_arity('IMS-Information',
          'Cellular-Network-Information') ->
    {0, 1};
avp_arity('IMS-Information',
          'Early-Media-Description') ->
    {0, '*'};
avp_arity('IMS-Information',
          'IMS-Communication-Service-Identifier') ->
    {0, 1};
avp_arity('IMS-Information',
          'IMS-Application-Reference-Identifier') ->
    {0, 1};
avp_arity('IMS-Information', 'Online-Charging-Flag') ->
    {0, 1};
avp_arity('IMS-Information',
          'Real-Time-Tariff-Information') ->
    {0, 1};
avp_arity('IMS-Information', 'Account-Expiration') ->
    {0, 1};
avp_arity('IMS-Information',
          'Initial-IMS-Charging-Identifier') ->
    {0, 1};
avp_arity('IMS-Information', 'NNI-Information') ->
    {0, '*'};
avp_arity('IMS-Information', 'From-Address') -> {0, 1};
avp_arity('IMS-Information',
          'IMS-Emergency-Indicator') ->
    {0, 1};
avp_arity('IMS-Information',
          'IMS-Visited-Network-Identifier') ->
    {0, 1};
avp_arity('IMS-Information',
          'Access-Network-Info-Change') ->
    {0, '*'};
avp_arity('IMS-Information',
          'Access-Transfer-Information') ->
    {0, '*'};
avp_arity('IMS-Information',
          'Related-IMS-Charging-Identifier') ->
    {0, 1};
avp_arity('IMS-Information',
          'Related-IMS-Charging-Identifier-Node') ->
    {0, 1};
avp_arity('IMS-Information', 'Route-Header-Received') ->
    {0, 1};
avp_arity('IMS-Information',
          'Route-Header-Transmitted') ->
    {0, 1};
avp_arity('IMS-Information', 'Instance-Id') -> {0, 1};
avp_arity('IMS-Information', 'TAD-Identifier') ->
    {0, 1};
avp_arity('IMS-Information', 'FE-Identifier-List') ->
    {0, 1};
avp_arity('Inter-Operator-Identifier',
          'Originating-IOI') ->
    {0, 1};
avp_arity('Inter-Operator-Identifier',
          'Terminating-IOI') ->
    {0, 1};
avp_arity('ISUP-Cause', 'ISUP-Cause-Location') ->
    {0, 1};
avp_arity('ISUP-Cause', 'ISUP-Cause-Value') -> {0, 1};
avp_arity('ISUP-Cause', 'ISUP-Cause-Diagnostics') ->
    {0, 1};
avp_arity('LCS-Client-ID', 'LCS-Client-Type') -> {0, 1};
avp_arity('LCS-Client-ID', 'LCS-Client-External-ID') ->
    {0, 1};
avp_arity('LCS-Client-ID', 'LCS-Client-Dialed-By-MS') ->
    {0, 1};
avp_arity('LCS-Client-ID', 'LCS-Client-Name') -> {0, 1};
avp_arity('LCS-Client-ID', 'LCS-APN') -> {0, 1};
avp_arity('LCS-Client-ID', 'LCS-Requestor-ID') ->
    {0, 1};
avp_arity('LCS-Client-Name',
          'LCS-Data-Coding-Scheme') ->
    {0, 1};
avp_arity('LCS-Client-Name', 'LCS-Name-String') ->
    {0, 1};
avp_arity('LCS-Client-Name', 'LCS-Format-Indicator') ->
    {0, 1};
avp_arity('LCS-Information', 'LCS-Client-ID') -> {0, 1};
avp_arity('LCS-Information', 'Location-Type') -> {0, 1};
avp_arity('LCS-Information', 'Location-Estimate') ->
    {0, 1};
avp_arity('LCS-Information', 'Positioning-Data') ->
    {0, 1};
avp_arity('LCS-Information', '3GPP-IMSI') -> {0, 1};
avp_arity('LCS-Information', 'MSISDN') -> {0, 1};
avp_arity('LCS-Requestor-ID',
          'LCS-Data-Coding-Scheme') ->
    {0, 1};
avp_arity('LCS-Requestor-ID',
          'LCS-Requestor-ID-String') ->
    {0, 1};
avp_arity('Location-Info', '3GPP-User-Location-Info') ->
    {0, 1};
avp_arity('Location-Info', 'Change-Time') -> {0, 1};
avp_arity('Location-Type', 'Location-Estimate-Type') ->
    {0, 1};
avp_arity('Location-Type',
          'Deferred-Location-Event-Type') ->
    {0, 1};
avp_arity('MBMS-Information', 'TMGI') -> {0, 1};
avp_arity('MBMS-Information',
          'MBMS-User-Service-Type') ->
    {0, 1};
avp_arity('MBMS-Information',
          'File-Repair-Supported') ->
    {0, 1};
avp_arity('MBMS-Information', 'MBMS-2G-3G-Indicator') ->
    {0, 1};
avp_arity('MBMS-Information', 'MBMS-Service-Area') ->
    {0, '*'};
avp_arity('MBMS-Information',
          'MBMS-Session-Identity') ->
    {0, 1};
avp_arity('MBMS-Information',
          'CN-IP-Multicast-Distribution') ->
    {0, 1};
avp_arity('MBMS-Information', 'MBMS-GW-Address') ->
    {0, 1};
avp_arity('MBMS-Information', 'MBMS-Charged-Party') ->
    {0, 1};
avp_arity('MBMS-Information', 'MSISDN') -> {0, '*'};
avp_arity('Message-Body', 'Content-Type') -> 1;
avp_arity('Message-Body', 'Content-Length') -> 1;
avp_arity('Message-Body', 'Content-Disposition') ->
    {0, 1};
avp_arity('Message-Body', 'Originator') -> {0, 1};
avp_arity('Message-Class', 'Class-Identifier') ->
    {0, 1};
avp_arity('Message-Class', 'Token-Text') -> {0, 1};
avp_arity('MM-Content-Type', 'Type-Number') -> {0, 1};
avp_arity('MM-Content-Type',
          'Additional-Type-Information') ->
    {0, 1};
avp_arity('MM-Content-Type', 'Content-Size') -> {0, 1};
avp_arity('MM-Content-Type',
          'Additional-Content-Information') ->
    {0, '*'};
avp_arity('MMS-Information', 'Originator-Address') ->
    {0, 1};
avp_arity('MMS-Information', 'Recipient-Address') ->
    {0, '*'};
avp_arity('MMS-Information', 'Submission-Time') ->
    {0, 1};
avp_arity('MMS-Information', 'MM-Content-Type') ->
    {0, 1};
avp_arity('MMS-Information', 'Priority') -> {0, 1};
avp_arity('MMS-Information', 'Message-ID') -> {0, 1};
avp_arity('MMS-Information', 'Message-Type') -> {0, 1};
avp_arity('MMS-Information', 'Message-Size') -> {0, 1};
avp_arity('MMS-Information', 'Message-Class') -> {0, 1};
avp_arity('MMS-Information',
          'Delivery-Report-Requested') ->
    {0, 1};
avp_arity('MMS-Information',
          'Read-Reply-Report-Requested') ->
    {0, 1};
avp_arity('MMS-Information',
          'MMBox-Storage-Requested') ->
    {0, 1};
avp_arity('MMS-Information', 'Applic-ID') -> {0, 1};
avp_arity('MMS-Information', 'Reply-Applic-ID') ->
    {0, 1};
avp_arity('MMS-Information', 'Aux-Applic-Info') ->
    {0, 1};
avp_arity('MMS-Information', 'Content-Class') -> {0, 1};
avp_arity('MMS-Information', 'DRM-Content') -> {0, 1};
avp_arity('MMS-Information', 'Adaptations') -> {0, 1};
avp_arity('MMTel-Information',
          'Supplementary-Service') ->
    {0, '*'};
avp_arity('Monitoring-Event-Information',
          'Monitoring-Event-Functionality') ->
    {0, 1};
avp_arity('Monitoring-Event-Information',
          'Event-Timestamp') ->
    {0, 1};
avp_arity('Monitoring-Event-Information',
          'Monitoring-Event-Configuration-Activity') ->
    {0, 1};
avp_arity('Monitoring-Event-Information',
          'Charged-Party') ->
    {0, 1};
avp_arity('Monitoring-Event-Information',
          'Monitoring-Event-Report-Data') ->
    {0, '*'};
avp_arity('Monitoring-Event-Report-Data',
          'Event-Timestamp') ->
    {0, 1};
avp_arity('Monitoring-Event-Report-Data',
          'Monitoring-Event-Report-Number') ->
    {0, 1};
avp_arity('Monitoring-Event-Report-Data',
          'Charged-Party') ->
    {0, 1};
avp_arity('Monitoring-Event-Report-Data',
          'Subscription-Id') ->
    {0, 1};
avp_arity('Next-Tariff', 'Currency-Code') -> {0, 1};
avp_arity('Next-Tariff', 'Scale-Factor') -> {0, 1};
avp_arity('Next-Tariff', 'Rate-Element') -> {0, '*'};
avp_arity('NIDD-Submission', 'Submission-Time') ->
    {0, 1};
avp_arity('NIDD-Submission', 'Event-Timestamp') ->
    {0, 1};
avp_arity('NIDD-Submission',
          'Accounting-Input-Octets') ->
    {0, 1};
avp_arity('NIDD-Submission',
          'Accounting-Output-Octets') ->
    {0, 1};
avp_arity('NIDD-Submission', 'Change-Condition') ->
    {0, 1};
avp_arity('NNI-Information', 'Session-Direction') ->
    {0, 1};
avp_arity('NNI-Information', 'NNI-Type') -> {0, 1};
avp_arity('NNI-Information', 'Relationship-Mode') ->
    {0, 1};
avp_arity('NNI-Information',
          'Neighbour-Node-Address') ->
    {0, 1};
avp_arity('Offline-Charging',
          'Quota-Consumption-Time') ->
    {0, 1};
avp_arity('Offline-Charging', 'Time-Quota-Mechanism') ->
    {0, 1};
avp_arity('Offline-Charging', 'Envelope-Reporting') ->
    {0, 1};
avp_arity('Offline-Charging',
          'Multiple-Services-Credit-Control') ->
    {0, '*'};
avp_arity('Offline-Charging', 'AVP') -> {0, '*'};
avp_arity('Originator-Address', 'Address-Type') ->
    {0, 1};
avp_arity('Originator-Address', 'Address-Data') ->
    {0, 1};
avp_arity('Originator-Address', 'Address-Domain') ->
    {0, 1};
avp_arity('Originator-Interface', 'Interface-Id') ->
    {0, 1};
avp_arity('Originator-Interface', 'Interface-Text') ->
    {0, 1};
avp_arity('Originator-Interface', 'Interface-Port') ->
    {0, 1};
avp_arity('Originator-Interface', 'Interface-Type') ->
    {0, 1};
avp_arity('Originator-Received-Address',
          'Address-Type') ->
    {0, 1};
avp_arity('Originator-Received-Address',
          'Address-Data') ->
    {0, 1};
avp_arity('Originator-Received-Address',
          'Address-Domain') ->
    {0, 1};
avp_arity('Participant-Group',
          'Called-Party-Address') ->
    {0, 1};
avp_arity('Participant-Group',
          'Participant-Access-Priority') ->
    {0, 1};
avp_arity('Participant-Group',
          'User-Participating-Type') ->
    {0, 1};
avp_arity('PoC-Information', 'PoC-Server-Role') ->
    {0, 1};
avp_arity('PoC-Information', 'PoC-Session-Type') ->
    {0, 1};
avp_arity('PoC-Information', 'PoC-User-Role') -> {0, 1};
avp_arity('PoC-Information',
          'PoC-Session-Initiation-Type') ->
    {0, 1};
avp_arity('PoC-Information', 'PoC-Event-Type') ->
    {0, 1};
avp_arity('PoC-Information',
          'Number-Of-Participants') ->
    {0, 1};
avp_arity('PoC-Information', 'Participants-Involved') ->
    {0, '*'};
avp_arity('PoC-Information', 'Participant-Group') ->
    {0, '*'};
avp_arity('PoC-Information', 'Talk-Burst-Exchange') ->
    {0, '*'};
avp_arity('PoC-Information',
          'PoC-Controlling-Address') ->
    {0, 1};
avp_arity('PoC-Information', 'PoC-Group-Name') ->
    {0, 1};
avp_arity('PoC-Information', 'PoC-Session-Id') ->
    {0, 1};
avp_arity('PoC-Information', 'Charged-Party') -> {0, 1};
avp_arity('PoC-User-Role', 'PoC-User-Role-IDs') ->
    {0, 1};
avp_arity('PoC-User-Role',
          'PoC-User-Role-Info-Units') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Reception-Data-Container',
          'Local-Sequence-Number') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Reception-Data-Container',
          'Coverage-Status') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Reception-Data-Container',
          '3GPP-User-Location-Info') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Reception-Data-Container',
          'Accounting-Input-Octets') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Reception-Data-Container',
          'Change-Time') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Reception-Data-Container',
          'Change-Condition') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Reception-Data-Container',
          'Usage-Information-Report-Sequence-Number') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Reception-Data-Container',
          'Radio-Resources-Indicator') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Reception-Data-Container',
          'Radio-Frequency') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Transmission-Data-Container',
          'Local-Sequence-Number') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Transmission-Data-Container',
          'Coverage-Status') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Transmission-Data-Container',
          '3GPP-User-Location-Info') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Transmission-Data-Container',
          'Accounting-Output-Octets') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Transmission-Data-Container',
          'Change-Time') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Transmission-Data-Container',
          'Change-Condition') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Transmission-Data-Container',
          'Usage-Information-Report-Sequence-Number') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Transmission-Data-Container',
          'Radio-Resources-Indicator') ->
    {0, 1};
avp_arity('ProSe-Direct-Communication-Transmission-Data-Container',
          'Radio-Frequency') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Announcing-UE-HPLMN-Identifier') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Announcing-UE-VPLMN-Identifier') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Monitoring-UE-HPLMN-Identifier') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Monitoring-UE-VPLMN-Identifier') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Role-Of-ProSe-Function') ->
    {0, 1};
avp_arity('ProSe-Information',
          'ProSe-3rd-Party-Application-ID') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Application-Specific-Data') ->
    {0, 1};
avp_arity('ProSe-Information', 'ProSe-Event-Type') ->
    {0, 1};
avp_arity('ProSe-Information',
          'ProSe-Direct-Discovery-Model') ->
    {0, 1};
avp_arity('ProSe-Information',
          'ProSe-Function-IP-Address') ->
    {0, 1};
avp_arity('ProSe-Information', 'ProSe-Role-Of-UE') ->
    {0, 1};
avp_arity('ProSe-Information',
          'ProSe-Request-Timestamp') ->
    {0, 1};
avp_arity('ProSe-Information',
          'PC3-Control-Protocol-Cause') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Monitoring-UE-Identifier') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Requestor-PLMN-Identifier') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Requested-PLMN-Identifier') ->
    {0, 1};
avp_arity('ProSe-Information', 'ProSe-Range-Class') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Proximity-Alert-Indication') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Proximity-Alert-Timestamp') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Proximity-Cancellation-Timestamp') ->
    {0, 1};
avp_arity('ProSe-Information',
          'ProSe-Reason-For-Cancellation') ->
    {0, 1};
avp_arity('ProSe-Information',
          'PC3-EPC-Control-Protocol-Cause') ->
    {0, 1};
avp_arity('ProSe-Information', 'ProSe-UE-ID') -> {0, 1};
avp_arity('ProSe-Information',
          'ProSe-Source-IP-Address') ->
    {0, 1};
avp_arity('ProSe-Information', 'Layer-2-Group-ID') ->
    {0, 1};
avp_arity('ProSe-Information',
          'ProSe-Group-IP-Multicast-Address') ->
    {0, 1};
avp_arity('ProSe-Information', 'Coverage-Info') ->
    {0, '*'};
avp_arity('ProSe-Information',
          'Radio-Parameter-Set-Info') ->
    {0, '*'};
avp_arity('ProSe-Information', 'Transmitter-Info') ->
    {0, '*'};
avp_arity('ProSe-Information',
          'Time-First-Transmission') ->
    {0, 1};
avp_arity('ProSe-Information',
          'Time-First-Reception') ->
    {0, 1};
avp_arity('ProSe-Information',
          'ProSe-Direct-Communication-Transmission-Data-Container') ->
    {0, '*'};
avp_arity('ProSe-Information',
          'ProSe-Direct-Communication-Reception-Data-Container') ->
    {0, '*'};
avp_arity('ProSe-Information', 'Announcing-PLMN-ID') ->
    {0, 1};
avp_arity('ProSe-Information',
          'ProSe-Target-Layer-2-ID') ->
    {0, 1};
avp_arity('ProSe-Information', 'Relay-IP-address') ->
    {0, 1};
avp_arity('ProSe-Information',
          'ProSe-UE-to-Network-Relay-UE-ID') ->
    {0, 1};
avp_arity('ProSe-Information', 'Target-IP-Address') ->
    {0, 1};
avp_arity('ProSe-Information',
          'PC5-Radio-Technology') ->
    {0, 1};
avp_arity('PS-Furnish-Charging-Information',
          '3GPP-Charging-Id') ->
    1;
avp_arity('PS-Furnish-Charging-Information',
          'PS-Free-Format-Data') ->
    1;
avp_arity('PS-Furnish-Charging-Information',
          'PS-Append-Free-Format-Data') ->
    {0, 1};
avp_arity('PS-Information', '3GPP-Charging-Id') ->
    {0, 1};
avp_arity('PS-Information',
          'PDN-Connection-Charging-ID') ->
    {0, 1};
avp_arity('PS-Information', 'Node-Id') -> {0, 1};
avp_arity('PS-Information', '3GPP-PDP-Type') -> {0, 1};
avp_arity('PS-Information', 'PDP-Address') -> {0, '*'};
avp_arity('PS-Information',
          'PDP-Address-Prefix-Length') ->
    {0, 1};
avp_arity('PS-Information', 'Dynamic-Address-Flag') ->
    {0, 1};
avp_arity('PS-Information',
          'Dynamic-Address-Flag-Extension') ->
    {0, 1};
avp_arity('PS-Information', 'QoS-Information') ->
    {0, 1};
avp_arity('PS-Information', 'SGSN-Address') -> {0, '*'};
avp_arity('PS-Information', 'GGSN-Address') -> {0, '*'};
avp_arity('PS-Information', 'TDF-IP-Address') ->
    {0, '*'};
avp_arity('PS-Information', 'SGW-Address') -> {0, '*'};
avp_arity('PS-Information', 'TWAG-Address') -> {0, '*'};
avp_arity('PS-Information', 'CG-Address') -> {0, 1};
avp_arity('PS-Information', 'Serving-Node-Type') ->
    {0, 1};
avp_arity('PS-Information', 'SGW-Change') -> {0, 1};
avp_arity('PS-Information', '3GPP-IMSI-MCC-MNC') ->
    {0, 1};
avp_arity('PS-Information',
          'IMSI-Unauthenticated-Flag') ->
    {0, 1};
avp_arity('PS-Information', '3GPP-GGSN-MCC-MNC') ->
    {0, 1};
avp_arity('PS-Information', '3GPP-NSAPI') -> {0, 1};
avp_arity('PS-Information', 'Called-Station-Id') ->
    {0, 1};
avp_arity('PS-Information',
          '3GPP-Session-Stop-Indicator') ->
    {0, 1};
avp_arity('PS-Information', '3GPP-Selection-Mode') ->
    {0, 1};
avp_arity('PS-Information',
          '3GPP-Charging-Characteristics') ->
    {0, 1};
avp_arity('PS-Information',
          'Charging-Characteristics-Selection-Mode') ->
    {0, 1};
avp_arity('PS-Information', '3GPP-SGSN-MCC-MNC') ->
    {0, 1};
avp_arity('PS-Information', '3GPP-MS-TimeZone') ->
    {0, 1};
avp_arity('PS-Information',
          'Charging-Rule-Base-Name') ->
    {0, 1};
avp_arity('PS-Information',
          '3GPP-User-Location-Info') ->
    {0, 1};
avp_arity('PS-Information',
          'User-Location-Info-Time') ->
    {0, 1};
avp_arity('PS-Information', 'User-CSG-Information') ->
    {0, 1};
avp_arity('PS-Information',
          'Presence-Reporting-Area-Information') ->
    {0, '*'};
avp_arity('PS-Information',
          'TWAN-User-Location-Info') ->
    {0, 1};
avp_arity('PS-Information',
          'UWAN-User-Location-Info') ->
    {0, 1};
avp_arity('PS-Information', '3GPP-RAT-Type') -> {0, 1};
avp_arity('PS-Information',
          'PS-Furnish-Charging-Information') ->
    {0, 1};
avp_arity('PS-Information', 'PDP-Context-Type') ->
    {0, 1};
avp_arity('PS-Information', 'Offline-Charging') ->
    {0, 1};
avp_arity('PS-Information', 'Traffic-Data-Volumes') ->
    {0, '*'};
avp_arity('PS-Information', 'Service-Data-Container') ->
    {0, '*'};
avp_arity('PS-Information', 'User-Equipment-Info') ->
    {0, 1};
avp_arity('PS-Information', 'Start-Time') -> {0, 1};
avp_arity('PS-Information', 'Stop-Time') -> {0, 1};
avp_arity('PS-Information', 'Change-Condition') ->
    {0, 1};
avp_arity('PS-Information', 'Diagnostics') -> {0, 1};
avp_arity('PS-Information', 'Low-Priority-Indicator') ->
    {0, 1};
avp_arity('PS-Information', 'Logical-Access-ID') ->
    {0, 1};
avp_arity('PS-Information', 'Physical-Access-ID') ->
    {0, 1};
avp_arity('PS-Information',
          'Fixed-User-Location-Info') ->
    {0, 1};
avp_arity('PS-Information',
          'CN-Operator-Selection-Entity') ->
    {0, 1};
avp_arity('PS-Information', 'Enhanced-Diagnostics') ->
    {0, 1};
avp_arity('PS-Information',
          'SGi-PtP-Tunnelling-Method') ->
    {0, 1};
avp_arity('PS-Information',
          'CP-CIoT-EPS-Optimisation-Indicator') ->
    {0, 1};
avp_arity('PS-Information', 'UNI-PDU-CP-Only-Flag') ->
    {0, 1};
avp_arity('PS-Information', 'APN-Rate-Control') ->
    {0, 1};
avp_arity('PS-Information',
          'Charging-Per-IP-CAN-Session-Indicator') ->
    {0, 1};
avp_arity('PS-Information',
          '3GPP-PS-Data-Off-Status') ->
    {0, 1};
avp_arity('PS-Information', 'SCS-AS-Address') -> {0, 1};
avp_arity('PS-Information', 'Unused-Quota-Timer') ->
    {0, 1};
avp_arity('PS-Information',
          'RAN-Secondary-RAT-Usage-Report') ->
    {0, '*'};
avp_arity('PS-Information', 'AVP') -> {0, '*'};
avp_arity('Radio-Parameter-Set-Info',
          'Radio-Parameter-Set-Values') ->
    {0, 1};
avp_arity('Radio-Parameter-Set-Info', 'Change-Time') ->
    {0, 1};
avp_arity('RAN-Secondary-RAT-Usage-Report',
          'Secondary-RAT-Type') ->
    {0, 1};
avp_arity('RAN-Secondary-RAT-Usage-Report',
          'RAN-Start-Timestamp') ->
    {0, 1};
avp_arity('RAN-Secondary-RAT-Usage-Report',
          'RAN-End-Timestamp') ->
    {0, 1};
avp_arity('RAN-Secondary-RAT-Usage-Report',
          'Accounting-Input-Octets') ->
    {0, 1};
avp_arity('RAN-Secondary-RAT-Usage-Report',
          'Accounting-Output-Octets') ->
    {0, 1};
avp_arity('RAN-Secondary-RAT-Usage-Report',
          '3GPP-Charging-Id') ->
    {0, 1};
avp_arity('Rate-Element', 'CC-Unit-Type') -> 1;
avp_arity('Rate-Element', 'Charge-Reason-Code') ->
    {0, 1};
avp_arity('Rate-Element', 'Unit-Value') -> {0, 1};
avp_arity('Rate-Element', 'Unit-Cost') -> {0, 1};
avp_arity('Rate-Element', 'Unit-Quota-Threshold') ->
    {0, 1};
avp_arity('Real-Time-Tariff-Information',
          'Tariff-Information') ->
    {0, 1};
avp_arity('Real-Time-Tariff-Information',
          'Tariff-XML') ->
    {0, 1};
avp_arity('Recipient-Address', 'Address-Type') ->
    {0, 1};
avp_arity('Recipient-Address', 'Address-Data') ->
    {0, 1};
avp_arity('Recipient-Address', 'Address-Domain') ->
    {0, 1};
avp_arity('Recipient-Address', 'Addressee-Type') ->
    {0, 1};
avp_arity('Recipient-Info', 'Destination-Interface') ->
    {0, 1};
avp_arity('Recipient-Info', 'Recipient-Address') ->
    {0, '*'};
avp_arity('Recipient-Info',
          'Recipient-Received-Address') ->
    {0, '*'};
avp_arity('Recipient-Info', 'Recipient-SCCP-Address') ->
    {0, 1};
avp_arity('Recipient-Info', 'SM-Protocol-ID') -> {0, 1};
avp_arity('Recipient-Received-Address',
          'Address-Type') ->
    {0, 1};
avp_arity('Recipient-Received-Address',
          'Address-Data') ->
    {0, 1};
avp_arity('Recipient-Received-Address',
          'Address-Domain') ->
    {0, 1};
avp_arity('Related-Change-Condition-Information',
          'SGSN-Address') ->
    {0, 1};
avp_arity('Related-Change-Condition-Information',
          'Change-Condition') ->
    {0, '*'};
avp_arity('Related-Change-Condition-Information',
          '3GPP-User-Location-Info') ->
    {0, 1};
avp_arity('Related-Change-Condition-Information',
          'UWAN-User-Location-Info') ->
    {0, 1};
avp_arity('Related-Change-Condition-Information',
          'Presence-Reporting-Area-Status') ->
    {0, 1};
avp_arity('Related-Change-Condition-Information',
          'User-CSG-Information') ->
    {0, 1};
avp_arity('Related-Change-Condition-Information',
          '3GPP-RAT-Type') ->
    {0, 1};
avp_arity('Related-Trigger', 'Trigger-Type') ->
    {0, '*'};
avp_arity('Remaining-Balance', 'Unit-Value') -> 1;
avp_arity('Remaining-Balance', 'Currency-Code') -> 1;
avp_arity('Scale-Factor', 'Value-Digits') -> 1;
avp_arity('Scale-Factor', 'Exponent') -> {0, 1};
avp_arity('SCS-AS-Address', 'SCS-Realm') -> {0, 1};
avp_arity('SCS-AS-Address', 'SCS-Address') -> {0, 1};
avp_arity('SDP-Media-Component', 'SDP-Media-Name') ->
    {0, 1};
avp_arity('SDP-Media-Component',
          'SDP-Media-Description') ->
    {0, '*'};
avp_arity('SDP-Media-Component',
          'Local-GW-Inserted-Indication') ->
    {0, 1};
avp_arity('SDP-Media-Component',
          'IP-Realm-Default-Indication') ->
    {0, 1};
avp_arity('SDP-Media-Component',
          'Transcoder-Inserted-Indication') ->
    {0, 1};
avp_arity('SDP-Media-Component',
          'Media-Initiator-Flag') ->
    {0, 1};
avp_arity('SDP-Media-Component',
          'Media-Initiator-Party') ->
    {0, 1};
avp_arity('SDP-Media-Component', '3GPP-Charging-Id') ->
    {0, 1};
avp_arity('SDP-Media-Component',
          'Access-Network-Charging-Identifier-Value') ->
    {0, 1};
avp_arity('SDP-Media-Component', 'SDP-Type') -> {0, 1};
avp_arity('SDP-TimeStamps', 'SDP-Offer-Timestamp') ->
    {0, 1};
avp_arity('SDP-TimeStamps', 'SDP-Answer-Timestamp') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'AF-Correlation-Information') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Charging-Rule-Base-Name') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Accounting-Input-Octets') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Accounting-Output-Octets') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Local-Sequence-Number') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'QoS-Information') ->
    {0, 1};
avp_arity('Service-Data-Container', 'Rating-Group') ->
    {0, 1};
avp_arity('Service-Data-Container', 'Change-Time') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Service-Identifier') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Service-Specific-Info') ->
    {0, 1};
avp_arity('Service-Data-Container', 'SGSN-Address') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Time-First-Usage') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Time-Last-Usage') ->
    {0, 1};
avp_arity('Service-Data-Container', 'Time-Usage') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Change-Condition') ->
    {0, '*'};
avp_arity('Service-Data-Container',
          '3GPP-User-Location-Info') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'UWAN-User-Location-Info') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Sponsor-Identity') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Application-Service-Provider-Identity') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Presence-Reporting-Area-Information') ->
    {0, '*'};
avp_arity('Service-Data-Container',
          'Presence-Reporting-Area-Status') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'User-CSG-Information') ->
    {0, 1};
avp_arity('Service-Data-Container', '3GPP-RAT-Type') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'Related-Change-Condition-Information') ->
    {0, 1};
avp_arity('Service-Data-Container',
          'APN-Rate-Control') ->
    {0, 1};
avp_arity('Service-Data-Container',
          '3GPP-PS-Data-Off-Status') ->
    {0, 1};
avp_arity('Service-Specific-Info',
          'Service-Specific-Data') ->
    {0, 1};
avp_arity('Service-Specific-Info',
          'Service-Specific-Type') ->
    {0, 1};
avp_arity('SM-Device-Trigger-Information',
          'MTC-IWF-Address') ->
    {0, 1};
avp_arity('SM-Device-Trigger-Information',
          'Validity-Time') ->
    {0, 1};
avp_arity('SMS-Information', 'SMS-Node') -> {0, 1};
avp_arity('SMS-Information', 'Client-Address') ->
    {0, 1};
avp_arity('SMS-Information',
          'Originator-SCCP-Address') ->
    {0, 1};
avp_arity('SMS-Information', 'SMSC-Address') -> {0, 1};
avp_arity('SMS-Information', 'Data-Coding-Scheme') ->
    {0, 1};
avp_arity('SMS-Information', 'SM-Discharge-Time') ->
    {0, 1};
avp_arity('SMS-Information', 'SM-Message-Type') ->
    {0, 1};
avp_arity('SMS-Information', 'Originator-Interface') ->
    {0, 1};
avp_arity('SMS-Information', 'SM-Protocol-ID') ->
    {0, 1};
avp_arity('SMS-Information', 'Reply-Path-Requested') ->
    {0, 1};
avp_arity('SMS-Information', 'SM-Status') -> {0, 1};
avp_arity('SMS-Information', 'SM-User-Data-Header') ->
    {0, 1};
avp_arity('SMS-Information',
          'Number-Of-Messages-Sent') ->
    {0, 1};
avp_arity('SMS-Information', 'SM-Sequence-Number') ->
    {0, 1};
avp_arity('SMS-Information', 'Recipient-Info') ->
    {0, '*'};
avp_arity('SMS-Information',
          'Originator-Received-Address') ->
    {0, 1};
avp_arity('SMS-Information', 'SM-Service-Type') ->
    {0, 1};
avp_arity('SMS-Information', 'SMS-Result') -> {0, 1};
avp_arity('SMS-Information',
          'SM-Device-Trigger-Indicator') ->
    {0, 1};
avp_arity('SMS-Information',
          'SM-Device-Trigger-Information') ->
    {0, 1};
avp_arity('SMS-Information', 'MTC-IWF-Address') ->
    {0, 1};
avp_arity('Supplementary-Service',
          'MMTel-SService-Type') ->
    {0, 1};
avp_arity('Supplementary-Service', 'Service-Mode') ->
    {0, 1};
avp_arity('Supplementary-Service',
          'Number-Of-Diversions') ->
    {0, 1};
avp_arity('Supplementary-Service',
          'Associated-Party-Address') ->
    {0, 1};
avp_arity('Supplementary-Service', 'Service-Id') ->
    {0, 1};
avp_arity('Supplementary-Service', 'Change-Time') ->
    {0, 1};
avp_arity('Supplementary-Service',
          'Number-Of-Participants') ->
    {0, 1};
avp_arity('Supplementary-Service',
          'Participant-Action-Type') ->
    {0, 1};
avp_arity('Supplementary-Service', 'CUG-Information') ->
    {0, 1};
avp_arity('Supplementary-Service', 'AoC-Information') ->
    {0, 1};
avp_arity('Talk-Burst-Exchange', 'PoC-Change-Time') ->
    1;
avp_arity('Talk-Burst-Exchange',
          'Number-Of-Talk-Bursts') ->
    {0, 1};
avp_arity('Talk-Burst-Exchange', 'Talk-Burst-Volume') ->
    {0, 1};
avp_arity('Talk-Burst-Exchange', 'Talk-Burst-Time') ->
    {0, 1};
avp_arity('Talk-Burst-Exchange',
          'Number-Of-Received-Talk-Bursts') ->
    {0, 1};
avp_arity('Talk-Burst-Exchange',
          'Received-Talk-Burst-Volume') ->
    {0, 1};
avp_arity('Talk-Burst-Exchange',
          'Received-Talk-Burst-Time') ->
    {0, 1};
avp_arity('Talk-Burst-Exchange',
          'Number-Of-Participants') ->
    {0, 1};
avp_arity('Talk-Burst-Exchange',
          'PoC-Change-Condition') ->
    {0, 1};
avp_arity('Tariff-Information', 'Current-Tariff') -> 1;
avp_arity('Tariff-Information', 'Tariff-Time-Change') ->
    {0, 1};
avp_arity('Tariff-Information', 'Next-Tariff') ->
    {0, 1};
avp_arity('Time-Quota-Mechanism', 'Time-Quota-Type') ->
    1;
avp_arity('Time-Quota-Mechanism',
          'Base-Time-Interval') ->
    1;
avp_arity('Time-Stamps', 'SIP-Request-Timestamp') ->
    {0, 1};
avp_arity('Time-Stamps', 'SIP-Response-Timestamp') ->
    {0, 1};
avp_arity('Time-Stamps',
          'SIP-Request-Timestamp-Fraction') ->
    {0, 1};
avp_arity('Time-Stamps',
          'SIP-Response-Timestamp-Fraction') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes', 'QoS-Information') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes',
          'Accounting-Input-Octets') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes',
          'Accounting-Output-Octets') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes', 'Change-Condition') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes', 'Change-Time') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes',
          '3GPP-User-Location-Info') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes',
          'UWAN-User-Location-Info') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes', '3GPP-Charging-Id') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes',
          'Presence-Reporting-Area-Status') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes',
          'User-CSG-Information') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes', '3GPP-RAT-Type') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes',
          'Related-Change-Condition-Information') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes', 'Diagnostics') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes',
          'Enhanced-Diagnostics') ->
    {0, 1};
avp_arity('Traffic-Data-Volumes',
          'CP-CIoT-EPS-Optimisation-Indicator') ->
    {0, 1};
avp_arity('Transmitter-Info',
          'ProSe-Source-IP-Address') ->
    {0, 1};
avp_arity('Transmitter-Info', 'ProSe-UE-ID') -> {0, 1};
avp_arity('Trigger', 'Trigger-Type') -> {0, '*'};
avp_arity('Trunk-Group-Id',
          'Incoming-Trunk-Group-Id') ->
    {0, 1};
avp_arity('Trunk-Group-Id',
          'Outgoing-Trunk-Group-Id') ->
    {0, 1};
avp_arity('TWAN-User-Location-Info', 'BSSID') -> {0, 1};
avp_arity('Unit-Cost', 'Value-Digits') -> 1;
avp_arity('Unit-Cost', 'Exponent') -> {0, 1};
avp_arity('User-CSG-Information', 'CSG-Access-Mode') ->
    1;
avp_arity('User-CSG-Information',
          'CSG-Membership-Indication') ->
    {0, 1};
avp_arity('UWAN-User-Location-Info',
          'UE-Local-IP-Address') ->
    1;
avp_arity('UWAN-User-Location-Info',
          'UDP-Source-Port') ->
    {0, 1};
avp_arity('UWAN-User-Location-Info', 'BSSID') -> {0, 1};
avp_arity('Variable-Part', 'Variable-Part-Type') -> 1;
avp_arity('Variable-Part', 'Variable-Part-Value') -> 1;
avp_arity('Variable-Part', 'Variable-Part-Order') ->
    {0, 1};
avp_arity('VCS-Information', 'Bearer-Capability') ->
    {0, 1};
avp_arity('VCS-Information',
          'Network-Call-Reference-Number') ->
    {0, 1};
avp_arity('VCS-Information', 'MSC-Address') -> {0, 1};
avp_arity('VCS-Information', 'Basic-Service-Code') ->
    {0, 1};
avp_arity('VCS-Information', 'ISUP-Location-Number') ->
    {0, 1};
avp_arity('VCS-Information', 'VLR-Number') -> {0, 1};
avp_arity('VCS-Information', 'Forwarding-Pending') ->
    {0, 1};
avp_arity('VCS-Information', 'ISUP-Cause') -> {0, 1};
avp_arity('VCS-Information', 'Start-Time') -> {0, 1};
avp_arity('VCS-Information', 'Start-of-Charging') ->
    {0, 1};
avp_arity('VCS-Information', 'Stop-Time') -> {0, 1};
avp_arity('VCS-Information', 'PS-Free-Format-Data') ->
    {0, 1};
avp_arity(_, _) -> 0.

avp_header('TP-NAT-IP-Address') -> {16, 128, 18681};
avp_header('TP-NAT-Pool-Id') -> {27, 128, 18681};
avp_header('TP-NAT-Port-End') -> {29, 128, 18681};
avp_header('TP-NAT-Port-Start') -> {28, 128, 18681};
avp_header('TP-Previous-PS-Information') ->
    {64, 128, 18681};
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
avp_header('AN-GW-Address') ->
    diameter_3gpp_ts29_212:avp_header('AN-GW-Address');
avp_header('AN-GW-Status') ->
    diameter_3gpp_ts29_212:avp_header('AN-GW-Status');
avp_header('APN-Aggregate-Max-Bitrate-DL') ->
    diameter_3gpp_ts29_212:avp_header('APN-Aggregate-Max-Bitrate-DL');
avp_header('APN-Aggregate-Max-Bitrate-UL') ->
    diameter_3gpp_ts29_212:avp_header('APN-Aggregate-Max-Bitrate-UL');
avp_header('Access-Network-Charging-Identifier-Gx') ->
    diameter_3gpp_ts29_212:avp_header('Access-Network-Charging-Identifier-Gx');
avp_header('Allocation-Retention-Priority') ->
    diameter_3gpp_ts29_212:avp_header('Allocation-Retention-Priority');
avp_header('Application-Detection-Information') ->
    diameter_3gpp_ts29_212:avp_header('Application-Detection-Information');
avp_header('Bearer-Control-Mode') ->
    diameter_3gpp_ts29_212:avp_header('Bearer-Control-Mode');
avp_header('Bearer-Identifier') ->
    diameter_3gpp_ts29_212:avp_header('Bearer-Identifier');
avp_header('Bearer-Operation') ->
    diameter_3gpp_ts29_212:avp_header('Bearer-Operation');
avp_header('Bearer-Usage') ->
    diameter_3gpp_ts29_212:avp_header('Bearer-Usage');
avp_header('CSG-Information-Reporting') ->
    diameter_3gpp_ts29_212:avp_header('CSG-Information-Reporting');
avp_header('Charging-Correlation-Indicator') ->
    diameter_3gpp_ts29_212:avp_header('Charging-Correlation-Indicator');
avp_header('Charging-Rule-Base-Name') ->
    diameter_3gpp_ts29_212:avp_header('Charging-Rule-Base-Name');
avp_header('Charging-Rule-Definition') ->
    diameter_3gpp_ts29_212:avp_header('Charging-Rule-Definition');
avp_header('Charging-Rule-Install') ->
    diameter_3gpp_ts29_212:avp_header('Charging-Rule-Install');
avp_header('Charging-Rule-Name') ->
    diameter_3gpp_ts29_212:avp_header('Charging-Rule-Name');
avp_header('Charging-Rule-Remove') ->
    diameter_3gpp_ts29_212:avp_header('Charging-Rule-Remove');
avp_header('Charging-Rule-Report') ->
    diameter_3gpp_ts29_212:avp_header('Charging-Rule-Report');
avp_header('CoA-IP-Address') ->
    diameter_3gpp_ts29_212:avp_header('CoA-IP-Address');
avp_header('CoA-Information') ->
    diameter_3gpp_ts29_212:avp_header('CoA-Information');
avp_header('Conditional-APN-Aggregate-Max-Bitrate') ->
    diameter_3gpp_ts29_212:avp_header('Conditional-APN-Aggregate-Max-Bitrate');
avp_header('Credit-Management-Status') ->
    diameter_3gpp_ts29_212:avp_header('Credit-Management-Status');
avp_header('Default-EPS-Bearer-QoS') ->
    diameter_3gpp_ts29_212:avp_header('Default-EPS-Bearer-QoS');
avp_header('Default-QoS-Information') ->
    diameter_3gpp_ts29_212:avp_header('Default-QoS-Information');
avp_header('Default-QoS-Name') ->
    diameter_3gpp_ts29_212:avp_header('Default-QoS-Name');
avp_header('Event-Report-Indication') ->
    diameter_3gpp_ts29_212:avp_header('Event-Report-Indication');
avp_header('Event-Trigger') ->
    diameter_3gpp_ts29_212:avp_header('Event-Trigger');
avp_header('Fixed-User-Location-Info') ->
    diameter_3gpp_ts29_212:avp_header('Fixed-User-Location-Info');
avp_header('Flow-Direction') ->
    diameter_3gpp_ts29_212:avp_header('Flow-Direction');
avp_header('Flow-Information') ->
    diameter_3gpp_ts29_212:avp_header('Flow-Information');
avp_header('Flow-Label') ->
    diameter_3gpp_ts29_212:avp_header('Flow-Label');
avp_header('Guaranteed-Bitrate-DL') ->
    diameter_3gpp_ts29_212:avp_header('Guaranteed-Bitrate-DL');
avp_header('Guaranteed-Bitrate-UL') ->
    diameter_3gpp_ts29_212:avp_header('Guaranteed-Bitrate-UL');
avp_header('HeNB-Local-IP-Address') ->
    diameter_3gpp_ts29_212:avp_header('HeNB-Local-IP-Address');
avp_header('IP-CAN-Session-Charging-Scope') ->
    diameter_3gpp_ts29_212:avp_header('IP-CAN-Session-Charging-Scope');
avp_header('IP-CAN-Type') ->
    diameter_3gpp_ts29_212:avp_header('IP-CAN-Type');
avp_header('Metering-Method') ->
    diameter_3gpp_ts29_212:avp_header('Metering-Method');
avp_header('Monitoring-Key') ->
    diameter_3gpp_ts29_212:avp_header('Monitoring-Key');
avp_header('Monitoring-Time') ->
    diameter_3gpp_ts29_212:avp_header('Monitoring-Time');
avp_header('Mute-Notification') ->
    diameter_3gpp_ts29_212:avp_header('Mute-Notification');
avp_header('NetLoc-Access-Support') ->
    diameter_3gpp_ts29_212:avp_header('NetLoc-Access-Support');
avp_header('Network-Request-Support') ->
    diameter_3gpp_ts29_212:avp_header('Network-Request-Support');
avp_header('Offline') ->
    diameter_3gpp_ts29_212:avp_header('Offline');
avp_header('Online') ->
    diameter_3gpp_ts29_212:avp_header('Online');
avp_header('PCC-Rule-Status') ->
    diameter_3gpp_ts29_212:avp_header('PCC-Rule-Status');
avp_header('PCSCF-Restoration-Indication') ->
    diameter_3gpp_ts29_212:avp_header('PCSCF-Restoration-Indication');
avp_header('PDN-Connection-ID') ->
    diameter_3gpp_ts29_212:avp_header('PDN-Connection-ID');
avp_header('PS-to-CS-Session-Continuity') ->
    diameter_3gpp_ts29_212:avp_header('PS-to-CS-Session-Continuity');
avp_header('Packet-Filter-Content') ->
    diameter_3gpp_ts29_212:avp_header('Packet-Filter-Content');
avp_header('Packet-Filter-Identifier') ->
    diameter_3gpp_ts29_212:avp_header('Packet-Filter-Identifier');
avp_header('Packet-Filter-Information') ->
    diameter_3gpp_ts29_212:avp_header('Packet-Filter-Information');
avp_header('Packet-Filter-Operation') ->
    diameter_3gpp_ts29_212:avp_header('Packet-Filter-Operation');
avp_header('Packet-Filter-Usage') ->
    diameter_3gpp_ts29_212:avp_header('Packet-Filter-Usage');
avp_header('Pre-emption-Capability') ->
    diameter_3gpp_ts29_212:avp_header('Pre-emption-Capability');
avp_header('Pre-emption-Vulnerability') ->
    diameter_3gpp_ts29_212:avp_header('Pre-emption-Vulnerability');
avp_header('Precedence') ->
    diameter_3gpp_ts29_212:avp_header('Precedence');
avp_header('Presence-Reporting-Area-Elements-List') ->
    diameter_3gpp_ts29_212:avp_header('Presence-Reporting-Area-Elements-List');
avp_header('Presence-Reporting-Area-Identifier') ->
    diameter_3gpp_ts29_212:avp_header('Presence-Reporting-Area-Identifier');
avp_header('Presence-Reporting-Area-Information') ->
    diameter_3gpp_ts29_212:avp_header('Presence-Reporting-Area-Information');
avp_header('Presence-Reporting-Area-Status') ->
    diameter_3gpp_ts29_212:avp_header('Presence-Reporting-Area-Status');
avp_header('Priority-Level') ->
    diameter_3gpp_ts29_212:avp_header('Priority-Level');
avp_header('QoS-Class-Identifier') ->
    diameter_3gpp_ts29_212:avp_header('QoS-Class-Identifier');
avp_header('QoS-Information') ->
    diameter_3gpp_ts29_212:avp_header('QoS-Information');
avp_header('QoS-Negotiation') ->
    diameter_3gpp_ts29_212:avp_header('QoS-Negotiation');
avp_header('QoS-Upgrade') ->
    diameter_3gpp_ts29_212:avp_header('QoS-Upgrade');
avp_header('RAN-NAS-Release-Cause') ->
    diameter_3gpp_ts29_212:avp_header('RAN-NAS-Release-Cause');
avp_header('RAT-Type') ->
    diameter_3gpp_ts29_212:avp_header('RAT-Type');
avp_header('Redirect-Information') ->
    diameter_3gpp_ts29_212:avp_header('Redirect-Information');
avp_header('Redirect-Support') ->
    diameter_3gpp_ts29_212:avp_header('Redirect-Support');
avp_header('Reporting-Level') ->
    diameter_3gpp_ts29_212:avp_header('Reporting-Level');
avp_header('Resource-Allocation-Notification') ->
    diameter_3gpp_ts29_212:avp_header('Resource-Allocation-Notification');
avp_header('Revalidation-Time') ->
    diameter_3gpp_ts29_212:avp_header('Revalidation-Time');
avp_header('Routing-Filter') ->
    diameter_3gpp_ts29_212:avp_header('Routing-Filter');
avp_header('Routing-IP-Address') ->
    diameter_3gpp_ts29_212:avp_header('Routing-IP-Address');
avp_header('Routing-Rule-Definition') ->
    diameter_3gpp_ts29_212:avp_header('Routing-Rule-Definition');
avp_header('Routing-Rule-Identifier') ->
    diameter_3gpp_ts29_212:avp_header('Routing-Rule-Identifier');
avp_header('Routing-Rule-Install') ->
    diameter_3gpp_ts29_212:avp_header('Routing-Rule-Install');
avp_header('Routing-Rule-Remove') ->
    diameter_3gpp_ts29_212:avp_header('Routing-Rule-Remove');
avp_header('Rule-Activation-Time') ->
    diameter_3gpp_ts29_212:avp_header('Rule-Activation-Time');
avp_header('Rule-Deactivation-Time') ->
    diameter_3gpp_ts29_212:avp_header('Rule-Deactivation-Time');
avp_header('Rule-Failure-Code') ->
    diameter_3gpp_ts29_212:avp_header('Rule-Failure-Code');
avp_header('Security-Parameter-Index') ->
    diameter_3gpp_ts29_212:avp_header('Security-Parameter-Index');
avp_header('Session-Release-Cause') ->
    diameter_3gpp_ts29_212:avp_header('Session-Release-Cause');
avp_header('TDF-Application-Identifier') ->
    diameter_3gpp_ts29_212:avp_header('TDF-Application-Identifier');
avp_header('TDF-Application-Instance-Identifier') ->
    diameter_3gpp_ts29_212:avp_header('TDF-Application-Instance-Identifier');
avp_header('TDF-Destination-Host') ->
    diameter_3gpp_ts29_212:avp_header('TDF-Destination-Host');
avp_header('TDF-Destination-Realm') ->
    diameter_3gpp_ts29_212:avp_header('TDF-Destination-Realm');
avp_header('TDF-IP-Address') ->
    diameter_3gpp_ts29_212:avp_header('TDF-IP-Address');
avp_header('TDF-Information') ->
    diameter_3gpp_ts29_212:avp_header('TDF-Information');
avp_header('TFT-Filter') ->
    diameter_3gpp_ts29_212:avp_header('TFT-Filter');
avp_header('TFT-Packet-Filter-Information') ->
    diameter_3gpp_ts29_212:avp_header('TFT-Packet-Filter-Information');
avp_header('ToS-Traffic-Class') ->
    diameter_3gpp_ts29_212:avp_header('ToS-Traffic-Class');
avp_header('Tunnel-Header-Filter') ->
    diameter_3gpp_ts29_212:avp_header('Tunnel-Header-Filter');
avp_header('Tunnel-Header-Length') ->
    diameter_3gpp_ts29_212:avp_header('Tunnel-Header-Length');
avp_header('Tunnel-Information') ->
    diameter_3gpp_ts29_212:avp_header('Tunnel-Information');
avp_header('UDP-Source-Port') ->
    diameter_3gpp_ts29_212:avp_header('UDP-Source-Port');
avp_header('UE-Local-IP-Address') ->
    diameter_3gpp_ts29_212:avp_header('UE-Local-IP-Address');
avp_header('Usage-Monitoring-Information') ->
    diameter_3gpp_ts29_212:avp_header('Usage-Monitoring-Information');
avp_header('Usage-Monitoring-Level') ->
    diameter_3gpp_ts29_212:avp_header('Usage-Monitoring-Level');
avp_header('Usage-Monitoring-Report') ->
    diameter_3gpp_ts29_212:avp_header('Usage-Monitoring-Report');
avp_header('Usage-Monitoring-Support') ->
    diameter_3gpp_ts29_212:avp_header('Usage-Monitoring-Support');
avp_header('User-Location-Info-Time') ->
    diameter_3gpp_ts29_212:avp_header('User-Location-Info-Time');
avp_header('3GPP-PS-Data-Off-Status') ->
    diameter_3gpp_ts32_299:avp_header('3GPP-PS-Data-Off-Status');
avp_header('AF-Correlation-Information') ->
    diameter_3gpp_ts32_299:avp_header('AF-Correlation-Information');
avp_header('APN-Rate-Control') ->
    diameter_3gpp_ts32_299:avp_header('APN-Rate-Control');
avp_header('APN-Rate-Control-Downlink') ->
    diameter_3gpp_ts32_299:avp_header('APN-Rate-Control-Downlink');
avp_header('APN-Rate-Control-Uplink') ->
    diameter_3gpp_ts32_299:avp_header('APN-Rate-Control-Uplink');
avp_header('Access-Network-Info-Change') ->
    diameter_3gpp_ts32_299:avp_header('Access-Network-Info-Change');
avp_header('Access-Network-Information') ->
    diameter_3gpp_ts32_299:avp_header('Access-Network-Information');
avp_header('Access-Transfer-Information') ->
    diameter_3gpp_ts32_299:avp_header('Access-Transfer-Information');
avp_header('Access-Transfer-Type') ->
    diameter_3gpp_ts32_299:avp_header('Access-Transfer-Type');
avp_header('Account-Expiration') ->
    diameter_3gpp_ts32_299:avp_header('Account-Expiration');
avp_header('Accumulated-Cost') ->
    diameter_3gpp_ts32_299:avp_header('Accumulated-Cost');
avp_header('Adaptations') ->
    diameter_3gpp_ts32_299:avp_header('Adaptations');
avp_header('Additional-Content-Information') ->
    diameter_3gpp_ts32_299:avp_header('Additional-Content-Information');
avp_header('Additional-Exception-Reports') ->
    diameter_3gpp_ts32_299:avp_header('Additional-Exception-Reports');
avp_header('Additional-Type-Information') ->
    diameter_3gpp_ts32_299:avp_header('Additional-Type-Information');
avp_header('Address-Data') ->
    diameter_3gpp_ts32_299:avp_header('Address-Data');
avp_header('Address-Domain') ->
    diameter_3gpp_ts32_299:avp_header('Address-Domain');
avp_header('Address-Type') ->
    diameter_3gpp_ts32_299:avp_header('Address-Type');
avp_header('Addressee-Type') ->
    diameter_3gpp_ts32_299:avp_header('Addressee-Type');
avp_header('Alternate-Charged-Party-Address') ->
    diameter_3gpp_ts32_299:avp_header('Alternate-Charged-Party-Address');
avp_header('Announcement-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Announcement-Identifier');
avp_header('Announcement-Information') ->
    diameter_3gpp_ts32_299:avp_header('Announcement-Information');
avp_header('Announcement-Order') ->
    diameter_3gpp_ts32_299:avp_header('Announcement-Order');
avp_header('Announcing-PLMN-ID') ->
    diameter_3gpp_ts32_299:avp_header('Announcing-PLMN-ID');
avp_header('Announcing-UE-HPLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Announcing-UE-HPLMN-Identifier');
avp_header('Announcing-UE-VPLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Announcing-UE-VPLMN-Identifier');
avp_header('AoC-Cost-Information') ->
    diameter_3gpp_ts32_299:avp_header('AoC-Cost-Information');
avp_header('AoC-Format') ->
    diameter_3gpp_ts32_299:avp_header('AoC-Format');
avp_header('AoC-Information') ->
    diameter_3gpp_ts32_299:avp_header('AoC-Information');
avp_header('AoC-Request-Type') ->
    diameter_3gpp_ts32_299:avp_header('AoC-Request-Type');
avp_header('AoC-Service') ->
    diameter_3gpp_ts32_299:avp_header('AoC-Service');
avp_header('AoC-Service-Obligatory-Type') ->
    diameter_3gpp_ts32_299:avp_header('AoC-Service-Obligatory-Type');
avp_header('AoC-Service-Type') ->
    diameter_3gpp_ts32_299:avp_header('AoC-Service-Type');
avp_header('AoC-Subscription-Information') ->
    diameter_3gpp_ts32_299:avp_header('AoC-Subscription-Information');
avp_header('Applic-ID') ->
    diameter_3gpp_ts32_299:avp_header('Applic-ID');
avp_header('Application-Provided-Called-Party-Address') ->
    diameter_3gpp_ts32_299:avp_header('Application-Provided-Called-Party-Address');
avp_header('Application-Server') ->
    diameter_3gpp_ts32_299:avp_header('Application-Server');
avp_header('Application-Server-Information') ->
    diameter_3gpp_ts32_299:avp_header('Application-Server-Information');
avp_header('Application-Specific-Data') ->
    diameter_3gpp_ts32_299:avp_header('Application-Specific-Data');
avp_header('Associated-Party-Address') ->
    diameter_3gpp_ts32_299:avp_header('Associated-Party-Address');
avp_header('Associated-URI') ->
    diameter_3gpp_ts32_299:avp_header('Associated-URI');
avp_header('Authorised-QoS') ->
    diameter_3gpp_ts32_299:avp_header('Authorised-QoS');
avp_header('Aux-Applic-Info') ->
    diameter_3gpp_ts32_299:avp_header('Aux-Applic-Info');
avp_header('BSSID') ->
    diameter_3gpp_ts32_299:avp_header('BSSID');
avp_header('Base-Time-Interval') ->
    diameter_3gpp_ts32_299:avp_header('Base-Time-Interval');
avp_header('Basic-Service-Code') ->
    diameter_3gpp_ts32_299:avp_header('Basic-Service-Code');
avp_header('Bearer-Capability') ->
    diameter_3gpp_ts32_299:avp_header('Bearer-Capability');
avp_header('Bearer-Service') ->
    diameter_3gpp_ts32_299:avp_header('Bearer-Service');
avp_header('CG-Address') ->
    diameter_3gpp_ts32_299:avp_header('CG-Address');
avp_header('CN-Operator-Selection-Entity') ->
    diameter_3gpp_ts32_299:avp_header('CN-Operator-Selection-Entity');
avp_header('CP-CIoT-EPS-Optimisation-Indicator') ->
    diameter_3gpp_ts32_299:avp_header('CP-CIoT-EPS-Optimisation-Indicator');
avp_header('CPDT-Information') ->
    diameter_3gpp_ts32_299:avp_header('CPDT-Information');
avp_header('CSG-Access-Mode') ->
    diameter_3gpp_ts32_299:avp_header('CSG-Access-Mode');
avp_header('CSG-Membership-Indication') ->
    diameter_3gpp_ts32_299:avp_header('CSG-Membership-Indication');
avp_header('CUG-Information') ->
    diameter_3gpp_ts32_299:avp_header('CUG-Information');
avp_header('Called-Asserted-Identity') ->
    diameter_3gpp_ts32_299:avp_header('Called-Asserted-Identity');
avp_header('Called-Identity') ->
    diameter_3gpp_ts32_299:avp_header('Called-Identity');
avp_header('Called-Identity-Change') ->
    diameter_3gpp_ts32_299:avp_header('Called-Identity-Change');
avp_header('Called-Party-Address') ->
    diameter_3gpp_ts32_299:avp_header('Called-Party-Address');
avp_header('Calling-Party-Address') ->
    diameter_3gpp_ts32_299:avp_header('Calling-Party-Address');
avp_header('Carrier-Select-Routing-Information') ->
    diameter_3gpp_ts32_299:avp_header('Carrier-Select-Routing-Information');
avp_header('Cause-Code') ->
    diameter_3gpp_ts32_299:avp_header('Cause-Code');
avp_header('Cellular-Network-Information') ->
    diameter_3gpp_ts32_299:avp_header('Cellular-Network-Information');
avp_header('Change-Condition') ->
    diameter_3gpp_ts32_299:avp_header('Change-Condition');
avp_header('Change-Time') ->
    diameter_3gpp_ts32_299:avp_header('Change-Time');
avp_header('Charge-Reason-Code') ->
    diameter_3gpp_ts32_299:avp_header('Charge-Reason-Code');
avp_header('Charged-Party') ->
    diameter_3gpp_ts32_299:avp_header('Charged-Party');
avp_header('Charging-Characteristics-Selection-Mode') ->
    diameter_3gpp_ts32_299:avp_header('Charging-Characteristics-Selection-Mode');
avp_header('Charging-Per-IP-CAN-Session-Indicator') ->
    diameter_3gpp_ts32_299:avp_header('Charging-Per-IP-CAN-Session-Indicator');
avp_header('Class-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Class-Identifier');
avp_header('Client-Address') ->
    diameter_3gpp_ts32_299:avp_header('Client-Address');
avp_header('Content-Class') ->
    diameter_3gpp_ts32_299:avp_header('Content-Class');
avp_header('Content-Disposition') ->
    diameter_3gpp_ts32_299:avp_header('Content-Disposition');
avp_header('Content-Length') ->
    diameter_3gpp_ts32_299:avp_header('Content-Length');
avp_header('Content-Size') ->
    diameter_3gpp_ts32_299:avp_header('Content-Size');
avp_header('Content-Type') ->
    diameter_3gpp_ts32_299:avp_header('Content-Type');
avp_header('Coverage-Info') ->
    diameter_3gpp_ts32_299:avp_header('Coverage-Info');
avp_header('Coverage-Status') ->
    diameter_3gpp_ts32_299:avp_header('Coverage-Status');
avp_header('Current-Tariff') ->
    diameter_3gpp_ts32_299:avp_header('Current-Tariff');
avp_header('DRM-Content') ->
    diameter_3gpp_ts32_299:avp_header('DRM-Content');
avp_header('Data-Coding-Scheme') ->
    diameter_3gpp_ts32_299:avp_header('Data-Coding-Scheme');
avp_header('Deferred-Location-Event-Type') ->
    diameter_3gpp_ts32_299:avp_header('Deferred-Location-Event-Type');
avp_header('Delivery-Report-Requested') ->
    diameter_3gpp_ts32_299:avp_header('Delivery-Report-Requested');
avp_header('Destination-Interface') ->
    diameter_3gpp_ts32_299:avp_header('Destination-Interface');
avp_header('Diagnostics') ->
    diameter_3gpp_ts32_299:avp_header('Diagnostics');
avp_header('Discoveree-UE-HPLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Discoveree-UE-HPLMN-Identifier');
avp_header('Discoveree-UE-VPLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Discoveree-UE-VPLMN-Identifier');
avp_header('Discoverer-UE-HPLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Discoverer-UE-HPLMN-Identifier');
avp_header('Discoverer-UE-VPLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Discoverer-UE-VPLMN-Identifier');
avp_header('Domain-Name') ->
    diameter_3gpp_ts32_299:avp_header('Domain-Name');
avp_header('Dynamic-Address-Flag') ->
    diameter_3gpp_ts32_299:avp_header('Dynamic-Address-Flag');
avp_header('Dynamic-Address-Flag-Extension') ->
    diameter_3gpp_ts32_299:avp_header('Dynamic-Address-Flag-Extension');
avp_header('EPDG-Address') ->
    diameter_3gpp_ts32_299:avp_header('EPDG-Address');
avp_header('Early-Media-Description') ->
    diameter_3gpp_ts32_299:avp_header('Early-Media-Description');
avp_header('Enhanced-Diagnostics') ->
    diameter_3gpp_ts32_299:avp_header('Enhanced-Diagnostics');
avp_header('Envelope') ->
    diameter_3gpp_ts32_299:avp_header('Envelope');
avp_header('Envelope-End-Time') ->
    diameter_3gpp_ts32_299:avp_header('Envelope-End-Time');
avp_header('Envelope-Reporting') ->
    diameter_3gpp_ts32_299:avp_header('Envelope-Reporting');
avp_header('Envelope-Start-Time') ->
    diameter_3gpp_ts32_299:avp_header('Envelope-Start-Time');
avp_header('Event') ->
    diameter_3gpp_ts32_299:avp_header('Event');
avp_header('Event-Charging-TimeStamp') ->
    diameter_3gpp_ts32_299:avp_header('Event-Charging-TimeStamp');
avp_header('Event-Type') ->
    diameter_3gpp_ts32_299:avp_header('Event-Type');
avp_header('Expires') ->
    diameter_3gpp_ts32_299:avp_header('Expires');
avp_header('FE-Identifier-List') ->
    diameter_3gpp_ts32_299:avp_header('FE-Identifier-List');
avp_header('File-Repair-Supported') ->
    diameter_3gpp_ts32_299:avp_header('File-Repair-Supported');
avp_header('Forwarding-Pending') ->
    diameter_3gpp_ts32_299:avp_header('Forwarding-Pending');
avp_header('From-Address') ->
    diameter_3gpp_ts32_299:avp_header('From-Address');
avp_header('GGSN-Address') ->
    diameter_3gpp_ts32_299:avp_header('GGSN-Address');
avp_header('IMS-Application-Reference-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('IMS-Application-Reference-Identifier');
avp_header('IMS-Charging-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('IMS-Charging-Identifier');
avp_header('IMS-Communication-Service-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('IMS-Communication-Service-Identifier');
avp_header('IMS-Emergency-Indicator') ->
    diameter_3gpp_ts32_299:avp_header('IMS-Emergency-Indicator');
avp_header('IMS-Information') ->
    diameter_3gpp_ts32_299:avp_header('IMS-Information');
avp_header('IMS-Visited-Network-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('IMS-Visited-Network-Identifier');
avp_header('IMSI-Unauthenticated-Flag') ->
    diameter_3gpp_ts32_299:avp_header('IMSI-Unauthenticated-Flag');
avp_header('IP-Realm-Default-Indication') ->
    diameter_3gpp_ts32_299:avp_header('IP-Realm-Default-Indication');
avp_header('ISUP-Cause') ->
    diameter_3gpp_ts32_299:avp_header('ISUP-Cause');
avp_header('ISUP-Cause-Diagnostics') ->
    diameter_3gpp_ts32_299:avp_header('ISUP-Cause-Diagnostics');
avp_header('ISUP-Cause-Location') ->
    diameter_3gpp_ts32_299:avp_header('ISUP-Cause-Location');
avp_header('ISUP-Cause-Value') ->
    diameter_3gpp_ts32_299:avp_header('ISUP-Cause-Value');
avp_header('ISUP-Location-Number') ->
    diameter_3gpp_ts32_299:avp_header('ISUP-Location-Number');
avp_header('Incoming-Trunk-Group-Id') ->
    diameter_3gpp_ts32_299:avp_header('Incoming-Trunk-Group-Id');
avp_header('Incremental-Cost') ->
    diameter_3gpp_ts32_299:avp_header('Incremental-Cost');
avp_header('Initial-IMS-Charging-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Initial-IMS-Charging-Identifier');
avp_header('Instance-Id') ->
    diameter_3gpp_ts32_299:avp_header('Instance-Id');
avp_header('Inter-Operator-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Inter-Operator-Identifier');
avp_header('Inter-UE-Transfer') ->
    diameter_3gpp_ts32_299:avp_header('Inter-UE-Transfer');
avp_header('Interface-Id') ->
    diameter_3gpp_ts32_299:avp_header('Interface-Id');
avp_header('Interface-Port') ->
    diameter_3gpp_ts32_299:avp_header('Interface-Port');
avp_header('Interface-Text') ->
    diameter_3gpp_ts32_299:avp_header('Interface-Text');
avp_header('Interface-Type') ->
    diameter_3gpp_ts32_299:avp_header('Interface-Type');
avp_header('LCS-APN') ->
    diameter_3gpp_ts32_299:avp_header('LCS-APN');
avp_header('LCS-Client-Dialed-By-MS') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Client-Dialed-By-MS');
avp_header('LCS-Client-External-ID') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Client-External-ID');
avp_header('LCS-Client-ID') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Client-ID');
avp_header('LCS-Client-Name') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Client-Name');
avp_header('LCS-Client-Type') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Client-Type');
avp_header('LCS-Data-Coding-Scheme') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Data-Coding-Scheme');
avp_header('LCS-Format-Indicator') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Format-Indicator');
avp_header('LCS-Information') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Information');
avp_header('LCS-Name-String') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Name-String');
avp_header('LCS-Requestor-ID') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Requestor-ID');
avp_header('LCS-Requestor-ID-String') ->
    diameter_3gpp_ts32_299:avp_header('LCS-Requestor-ID-String');
avp_header('Language') ->
    diameter_3gpp_ts32_299:avp_header('Language');
avp_header('Layer-2-Group-ID') ->
    diameter_3gpp_ts32_299:avp_header('Layer-2-Group-ID');
avp_header('Local-GW-Inserted-Indication') ->
    diameter_3gpp_ts32_299:avp_header('Local-GW-Inserted-Indication');
avp_header('Local-Sequence-Number') ->
    diameter_3gpp_ts32_299:avp_header('Local-Sequence-Number');
avp_header('Location-Estimate') ->
    diameter_3gpp_ts32_299:avp_header('Location-Estimate');
avp_header('Location-Estimate-Type') ->
    diameter_3gpp_ts32_299:avp_header('Location-Estimate-Type');
avp_header('Location-Info') ->
    diameter_3gpp_ts32_299:avp_header('Location-Info');
avp_header('Location-Type') ->
    diameter_3gpp_ts32_299:avp_header('Location-Type');
avp_header('Low-Balance-Indication') ->
    diameter_3gpp_ts32_299:avp_header('Low-Balance-Indication');
avp_header('Low-Priority-Indicator') ->
    diameter_3gpp_ts32_299:avp_header('Low-Priority-Indicator');
avp_header('MBMS-Charged-Party') ->
    diameter_3gpp_ts32_299:avp_header('MBMS-Charged-Party');
avp_header('MBMS-GW-Address') ->
    diameter_3gpp_ts32_299:avp_header('MBMS-GW-Address');
avp_header('MBMS-Information') ->
    diameter_3gpp_ts32_299:avp_header('MBMS-Information');
avp_header('MBMS-User-Service-Type') ->
    diameter_3gpp_ts32_299:avp_header('MBMS-User-Service-Type');
avp_header('MM-Content-Type') ->
    diameter_3gpp_ts32_299:avp_header('MM-Content-Type');
avp_header('MMBox-Storage-Requested') ->
    diameter_3gpp_ts32_299:avp_header('MMBox-Storage-Requested');
avp_header('MMS-Information') ->
    diameter_3gpp_ts32_299:avp_header('MMS-Information');
avp_header('MMTel-Information') ->
    diameter_3gpp_ts32_299:avp_header('MMTel-Information');
avp_header('MMTel-SService-Type') ->
    diameter_3gpp_ts32_299:avp_header('MMTel-SService-Type');
avp_header('MSC-Address') ->
    diameter_3gpp_ts32_299:avp_header('MSC-Address');
avp_header('MTC-IWF-Address') ->
    diameter_3gpp_ts32_299:avp_header('MTC-IWF-Address');
avp_header('Media-Initiator-Flag') ->
    diameter_3gpp_ts32_299:avp_header('Media-Initiator-Flag');
avp_header('Media-Initiator-Party') ->
    diameter_3gpp_ts32_299:avp_header('Media-Initiator-Party');
avp_header('Message-Body') ->
    diameter_3gpp_ts32_299:avp_header('Message-Body');
avp_header('Message-Class') ->
    diameter_3gpp_ts32_299:avp_header('Message-Class');
avp_header('Message-ID') ->
    diameter_3gpp_ts32_299:avp_header('Message-ID');
avp_header('Message-Size') ->
    diameter_3gpp_ts32_299:avp_header('Message-Size');
avp_header('Message-Type') ->
    diameter_3gpp_ts32_299:avp_header('Message-Type');
avp_header('Monitored-PLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Monitored-PLMN-Identifier');
avp_header('Monitoring-Event-Configuration-Activity') ->
    diameter_3gpp_ts32_299:avp_header('Monitoring-Event-Configuration-Activity');
avp_header('Monitoring-Event-Functionality') ->
    diameter_3gpp_ts32_299:avp_header('Monitoring-Event-Functionality');
avp_header('Monitoring-Event-Information') ->
    diameter_3gpp_ts32_299:avp_header('Monitoring-Event-Information');
avp_header('Monitoring-Event-Report-Data') ->
    diameter_3gpp_ts32_299:avp_header('Monitoring-Event-Report-Data');
avp_header('Monitoring-Event-Report-Number') ->
    diameter_3gpp_ts32_299:avp_header('Monitoring-Event-Report-Number');
avp_header('Monitoring-UE-HPLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Monitoring-UE-HPLMN-Identifier');
avp_header('Monitoring-UE-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Monitoring-UE-Identifier');
avp_header('Monitoring-UE-VPLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Monitoring-UE-VPLMN-Identifier');
avp_header('NIDD-Submission') ->
    diameter_3gpp_ts32_299:avp_header('NIDD-Submission');
avp_header('NNI-Information') ->
    diameter_3gpp_ts32_299:avp_header('NNI-Information');
avp_header('NNI-Type') ->
    diameter_3gpp_ts32_299:avp_header('NNI-Type');
avp_header('Neighbour-Node-Address') ->
    diameter_3gpp_ts32_299:avp_header('Neighbour-Node-Address');
avp_header('Network-Call-Reference-Number') ->
    diameter_3gpp_ts32_299:avp_header('Network-Call-Reference-Number');
avp_header('Next-Tariff') ->
    diameter_3gpp_ts32_299:avp_header('Next-Tariff');
avp_header('Node-Functionality') ->
    diameter_3gpp_ts32_299:avp_header('Node-Functionality');
avp_header('Node-Id') ->
    diameter_3gpp_ts32_299:avp_header('Node-Id');
avp_header('Number-Of-Diversions') ->
    diameter_3gpp_ts32_299:avp_header('Number-Of-Diversions');
avp_header('Number-Of-Messages-Sent') ->
    diameter_3gpp_ts32_299:avp_header('Number-Of-Messages-Sent');
avp_header('Number-Of-Participants') ->
    diameter_3gpp_ts32_299:avp_header('Number-Of-Participants');
avp_header('Number-Of-Received-Talk-Bursts') ->
    diameter_3gpp_ts32_299:avp_header('Number-Of-Received-Talk-Bursts');
avp_header('Number-Of-Talk-Bursts') ->
    diameter_3gpp_ts32_299:avp_header('Number-Of-Talk-Bursts');
avp_header('Number-Portability-Routing-Information') ->
    diameter_3gpp_ts32_299:avp_header('Number-Portability-Routing-Information');
avp_header('Offline-Charging') ->
    diameter_3gpp_ts32_299:avp_header('Offline-Charging');
avp_header('Online-Charging-Flag') ->
    diameter_3gpp_ts32_299:avp_header('Online-Charging-Flag');
avp_header('Originating-IOI') ->
    diameter_3gpp_ts32_299:avp_header('Originating-IOI');
avp_header('Originator') ->
    diameter_3gpp_ts32_299:avp_header('Originator');
avp_header('Originator-Address') ->
    diameter_3gpp_ts32_299:avp_header('Originator-Address');
avp_header('Originator-Interface') ->
    diameter_3gpp_ts32_299:avp_header('Originator-Interface');
avp_header('Originator-Received-Address') ->
    diameter_3gpp_ts32_299:avp_header('Originator-Received-Address');
avp_header('Originator-SCCP-Address') ->
    diameter_3gpp_ts32_299:avp_header('Originator-SCCP-Address');
avp_header('Outgoing-Session-Id') ->
    diameter_3gpp_ts32_299:avp_header('Outgoing-Session-Id');
avp_header('Outgoing-Trunk-Group-Id') ->
    diameter_3gpp_ts32_299:avp_header('Outgoing-Trunk-Group-Id');
avp_header('PC3-Control-Protocol-Cause') ->
    diameter_3gpp_ts32_299:avp_header('PC3-Control-Protocol-Cause');
avp_header('PC3-EPC-Control-Protocol-Cause') ->
    diameter_3gpp_ts32_299:avp_header('PC3-EPC-Control-Protocol-Cause');
avp_header('PC5-Radio-Technology') ->
    diameter_3gpp_ts32_299:avp_header('PC5-Radio-Technology');
avp_header('PDN-Connection-Charging-ID') ->
    diameter_3gpp_ts32_299:avp_header('PDN-Connection-Charging-ID');
avp_header('PDP-Address') ->
    diameter_3gpp_ts32_299:avp_header('PDP-Address');
avp_header('PDP-Address-Prefix-Length') ->
    diameter_3gpp_ts32_299:avp_header('PDP-Address-Prefix-Length');
avp_header('PDP-Context-Type') ->
    diameter_3gpp_ts32_299:avp_header('PDP-Context-Type');
avp_header('PS-Append-Free-Format-Data') ->
    diameter_3gpp_ts32_299:avp_header('PS-Append-Free-Format-Data');
avp_header('PS-Free-Format-Data') ->
    diameter_3gpp_ts32_299:avp_header('PS-Free-Format-Data');
avp_header('PS-Furnish-Charging-Information') ->
    diameter_3gpp_ts32_299:avp_header('PS-Furnish-Charging-Information');
avp_header('PS-Information') ->
    diameter_3gpp_ts32_299:avp_header('PS-Information');
avp_header('Participant-Access-Priority') ->
    diameter_3gpp_ts32_299:avp_header('Participant-Access-Priority');
avp_header('Participant-Action-Type') ->
    diameter_3gpp_ts32_299:avp_header('Participant-Action-Type');
avp_header('Participant-Group') ->
    diameter_3gpp_ts32_299:avp_header('Participant-Group');
avp_header('Participants-Involved') ->
    diameter_3gpp_ts32_299:avp_header('Participants-Involved');
avp_header('Play-Alternative') ->
    diameter_3gpp_ts32_299:avp_header('Play-Alternative');
avp_header('PoC-Change-Condition') ->
    diameter_3gpp_ts32_299:avp_header('PoC-Change-Condition');
avp_header('PoC-Change-Time') ->
    diameter_3gpp_ts32_299:avp_header('PoC-Change-Time');
avp_header('PoC-Controlling-Address') ->
    diameter_3gpp_ts32_299:avp_header('PoC-Controlling-Address');
avp_header('PoC-Event-Type') ->
    diameter_3gpp_ts32_299:avp_header('PoC-Event-Type');
avp_header('PoC-Group-Name') ->
    diameter_3gpp_ts32_299:avp_header('PoC-Group-Name');
avp_header('PoC-Information') ->
    diameter_3gpp_ts32_299:avp_header('PoC-Information');
avp_header('PoC-Server-Role') ->
    diameter_3gpp_ts32_299:avp_header('PoC-Server-Role');
avp_header('PoC-Session-Id') ->
    diameter_3gpp_ts32_299:avp_header('PoC-Session-Id');
avp_header('PoC-Session-Initiation-Type') ->
    diameter_3gpp_ts32_299:avp_header('PoC-Session-Initiation-Type');
avp_header('PoC-Session-Type') ->
    diameter_3gpp_ts32_299:avp_header('PoC-Session-Type');
avp_header('PoC-User-Role') ->
    diameter_3gpp_ts32_299:avp_header('PoC-User-Role');
avp_header('PoC-User-Role-IDs') ->
    diameter_3gpp_ts32_299:avp_header('PoC-User-Role-IDs');
avp_header('PoC-User-Role-Info-Units') ->
    diameter_3gpp_ts32_299:avp_header('PoC-User-Role-Info-Units');
avp_header('Positioning-Data') ->
    diameter_3gpp_ts32_299:avp_header('Positioning-Data');
avp_header('Preferred-AoC-Currency') ->
    diameter_3gpp_ts32_299:avp_header('Preferred-AoC-Currency');
avp_header('Priority') ->
    diameter_3gpp_ts32_299:avp_header('Priority');
avp_header('Privacy-Indicator') ->
    diameter_3gpp_ts32_299:avp_header('Privacy-Indicator');
avp_header('ProSe-3rd-Party-Application-ID') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-3rd-Party-Application-ID');
avp_header('ProSe-Direct-Communication-Reception-Data-Container') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Direct-Communication-Reception-Data-Container');
avp_header('ProSe-Direct-Communication-Transmission-Data-Container') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Direct-Communication-Transmission-Data-Container');
avp_header('ProSe-Direct-Discovery-Model') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Direct-Discovery-Model');
avp_header('ProSe-Event-Type') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Event-Type');
avp_header('ProSe-Function-IP-Address') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Function-IP-Address');
avp_header('ProSe-Function-PLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Function-PLMN-Identifier');
avp_header('ProSe-Functionality') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Functionality');
avp_header('ProSe-Group-IP-Multicast-Address') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Group-IP-Multicast-Address');
avp_header('ProSe-Information') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Information');
avp_header('ProSe-Range-Class') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Range-Class');
avp_header('ProSe-Reason-For-Cancellation') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Reason-For-Cancellation');
avp_header('ProSe-Request-Timestamp') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Request-Timestamp');
avp_header('ProSe-Role-Of-UE') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Role-Of-UE');
avp_header('ProSe-Source-IP-Address') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Source-IP-Address');
avp_header('ProSe-Target-Layer-2-ID') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-Target-Layer-2-ID');
avp_header('ProSe-UE-ID') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-UE-ID');
avp_header('ProSe-UE-to-Network-Relay-UE-ID') ->
    diameter_3gpp_ts32_299:avp_header('ProSe-UE-to-Network-Relay-UE-ID');
avp_header('Proximity-Alert-Indication') ->
    diameter_3gpp_ts32_299:avp_header('Proximity-Alert-Indication');
avp_header('Proximity-Alert-Timestamp') ->
    diameter_3gpp_ts32_299:avp_header('Proximity-Alert-Timestamp');
avp_header('Proximity-Cancellation-Timestamp') ->
    diameter_3gpp_ts32_299:avp_header('Proximity-Cancellation-Timestamp');
avp_header('Quota-Consumption-Time') ->
    diameter_3gpp_ts32_299:avp_header('Quota-Consumption-Time');
avp_header('Quota-Holding-Time') ->
    diameter_3gpp_ts32_299:avp_header('Quota-Holding-Time');
avp_header('Quota-Indicator') ->
    diameter_3gpp_ts32_299:avp_header('Quota-Indicator');
avp_header('RAN-End-Timestamp') ->
    diameter_3gpp_ts32_299:avp_header('RAN-End-Timestamp');
avp_header('RAN-Secondary-RAT-Usage-Report') ->
    diameter_3gpp_ts32_299:avp_header('RAN-Secondary-RAT-Usage-Report');
avp_header('RAN-Start-Timestamp') ->
    diameter_3gpp_ts32_299:avp_header('RAN-Start-Timestamp');
avp_header('Radio-Frequency') ->
    diameter_3gpp_ts32_299:avp_header('Radio-Frequency');
avp_header('Radio-Parameter-Set-Info') ->
    diameter_3gpp_ts32_299:avp_header('Radio-Parameter-Set-Info');
avp_header('Radio-Parameter-Set-Values') ->
    diameter_3gpp_ts32_299:avp_header('Radio-Parameter-Set-Values');
avp_header('Radio-Resources-Indicator') ->
    diameter_3gpp_ts32_299:avp_header('Radio-Resources-Indicator');
avp_header('Rate-Control-Max-Message-Size') ->
    diameter_3gpp_ts32_299:avp_header('Rate-Control-Max-Message-Size');
avp_header('Rate-Control-Max-Rate') ->
    diameter_3gpp_ts32_299:avp_header('Rate-Control-Max-Rate');
avp_header('Rate-Control-Time-Unit') ->
    diameter_3gpp_ts32_299:avp_header('Rate-Control-Time-Unit');
avp_header('Rate-Element') ->
    diameter_3gpp_ts32_299:avp_header('Rate-Element');
avp_header('Read-Reply-Report-Requested') ->
    diameter_3gpp_ts32_299:avp_header('Read-Reply-Report-Requested');
avp_header('Real-Time-Tariff-Information') ->
    diameter_3gpp_ts32_299:avp_header('Real-Time-Tariff-Information');
avp_header('Reason-Header') ->
    diameter_3gpp_ts32_299:avp_header('Reason-Header');
avp_header('Received-Talk-Burst-Time') ->
    diameter_3gpp_ts32_299:avp_header('Received-Talk-Burst-Time');
avp_header('Received-Talk-Burst-Volume') ->
    diameter_3gpp_ts32_299:avp_header('Received-Talk-Burst-Volume');
avp_header('Recipient-Address') ->
    diameter_3gpp_ts32_299:avp_header('Recipient-Address');
avp_header('Recipient-Info') ->
    diameter_3gpp_ts32_299:avp_header('Recipient-Info');
avp_header('Recipient-Received-Address') ->
    diameter_3gpp_ts32_299:avp_header('Recipient-Received-Address');
avp_header('Recipient-SCCP-Address') ->
    diameter_3gpp_ts32_299:avp_header('Recipient-SCCP-Address');
avp_header('Refund-Information') ->
    diameter_3gpp_ts32_299:avp_header('Refund-Information');
avp_header('Related-Change-Condition-Information') ->
    diameter_3gpp_ts32_299:avp_header('Related-Change-Condition-Information');
avp_header('Related-IMS-Charging-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Related-IMS-Charging-Identifier');
avp_header('Related-IMS-Charging-Identifier-Node') ->
    diameter_3gpp_ts32_299:avp_header('Related-IMS-Charging-Identifier-Node');
avp_header('Related-Trigger') ->
    diameter_3gpp_ts32_299:avp_header('Related-Trigger');
avp_header('Relationship-Mode') ->
    diameter_3gpp_ts32_299:avp_header('Relationship-Mode');
avp_header('Relay-IP-address') ->
    diameter_3gpp_ts32_299:avp_header('Relay-IP-address');
avp_header('Remaining-Balance') ->
    diameter_3gpp_ts32_299:avp_header('Remaining-Balance');
avp_header('Reply-Applic-ID') ->
    diameter_3gpp_ts32_299:avp_header('Reply-Applic-ID');
avp_header('Reply-Path-Requested') ->
    diameter_3gpp_ts32_299:avp_header('Reply-Path-Requested');
avp_header('Reporting-Reason') ->
    diameter_3gpp_ts32_299:avp_header('Reporting-Reason');
avp_header('Requested-PLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Requested-PLMN-Identifier');
avp_header('Requested-Party-Address') ->
    diameter_3gpp_ts32_299:avp_header('Requested-Party-Address');
avp_header('Requestor-PLMN-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('Requestor-PLMN-Identifier');
avp_header('Role-Of-Node') ->
    diameter_3gpp_ts32_299:avp_header('Role-Of-Node');
avp_header('Role-Of-ProSe-Function') ->
    diameter_3gpp_ts32_299:avp_header('Role-Of-ProSe-Function');
avp_header('Route-Header-Received') ->
    diameter_3gpp_ts32_299:avp_header('Route-Header-Received');
avp_header('Route-Header-Transmitted') ->
    diameter_3gpp_ts32_299:avp_header('Route-Header-Transmitted');
avp_header('SCS-AS-Address') ->
    diameter_3gpp_ts32_299:avp_header('SCS-AS-Address');
avp_header('SCS-Address') ->
    diameter_3gpp_ts32_299:avp_header('SCS-Address');
avp_header('SCS-Realm') ->
    diameter_3gpp_ts32_299:avp_header('SCS-Realm');
avp_header('SDP-Answer-Timestamp') ->
    diameter_3gpp_ts32_299:avp_header('SDP-Answer-Timestamp');
avp_header('SDP-Media-Component') ->
    diameter_3gpp_ts32_299:avp_header('SDP-Media-Component');
avp_header('SDP-Media-Description') ->
    diameter_3gpp_ts32_299:avp_header('SDP-Media-Description');
avp_header('SDP-Media-Name') ->
    diameter_3gpp_ts32_299:avp_header('SDP-Media-Name');
avp_header('SDP-Offer-Timestamp') ->
    diameter_3gpp_ts32_299:avp_header('SDP-Offer-Timestamp');
avp_header('SDP-Session-Description') ->
    diameter_3gpp_ts32_299:avp_header('SDP-Session-Description');
avp_header('SDP-TimeStamps') ->
    diameter_3gpp_ts32_299:avp_header('SDP-TimeStamps');
avp_header('SDP-Type') ->
    diameter_3gpp_ts32_299:avp_header('SDP-Type');
avp_header('SGSN-Address') ->
    diameter_3gpp_ts32_299:avp_header('SGSN-Address');
avp_header('SGW-Address') ->
    diameter_3gpp_ts32_299:avp_header('SGW-Address');
avp_header('SGW-Change') ->
    diameter_3gpp_ts32_299:avp_header('SGW-Change');
avp_header('SGi-PtP-Tunnelling-Method') ->
    diameter_3gpp_ts32_299:avp_header('SGi-PtP-Tunnelling-Method');
avp_header('SIP-Method') ->
    diameter_3gpp_ts32_299:avp_header('SIP-Method');
avp_header('SIP-Request-Timestamp') ->
    diameter_3gpp_ts32_299:avp_header('SIP-Request-Timestamp');
avp_header('SIP-Request-Timestamp-Fraction') ->
    diameter_3gpp_ts32_299:avp_header('SIP-Request-Timestamp-Fraction');
avp_header('SIP-Response-Timestamp') ->
    diameter_3gpp_ts32_299:avp_header('SIP-Response-Timestamp');
avp_header('SIP-Response-Timestamp-Fraction') ->
    diameter_3gpp_ts32_299:avp_header('SIP-Response-Timestamp-Fraction');
avp_header('SM-Device-Trigger-Indicator') ->
    diameter_3gpp_ts32_299:avp_header('SM-Device-Trigger-Indicator');
avp_header('SM-Device-Trigger-Information') ->
    diameter_3gpp_ts32_299:avp_header('SM-Device-Trigger-Information');
avp_header('SM-Discharge-Time') ->
    diameter_3gpp_ts32_299:avp_header('SM-Discharge-Time');
avp_header('SM-Message-Type') ->
    diameter_3gpp_ts32_299:avp_header('SM-Message-Type');
avp_header('SM-Protocol-ID') ->
    diameter_3gpp_ts32_299:avp_header('SM-Protocol-ID');
avp_header('SM-Sequence-Number') ->
    diameter_3gpp_ts32_299:avp_header('SM-Sequence-Number');
avp_header('SM-Service-Type') ->
    diameter_3gpp_ts32_299:avp_header('SM-Service-Type');
avp_header('SM-Status') ->
    diameter_3gpp_ts32_299:avp_header('SM-Status');
avp_header('SM-User-Data-Header') ->
    diameter_3gpp_ts32_299:avp_header('SM-User-Data-Header');
avp_header('SMS-Information') ->
    diameter_3gpp_ts32_299:avp_header('SMS-Information');
avp_header('SMS-Node') ->
    diameter_3gpp_ts32_299:avp_header('SMS-Node');
avp_header('SMS-Result') ->
    diameter_3gpp_ts32_299:avp_header('SMS-Result');
avp_header('SMSC-Address') ->
    diameter_3gpp_ts32_299:avp_header('SMSC-Address');
avp_header('Scale-Factor') ->
    diameter_3gpp_ts32_299:avp_header('Scale-Factor');
avp_header('Secondary-RAT-Type') ->
    diameter_3gpp_ts32_299:avp_header('Secondary-RAT-Type');
avp_header('Served-Party-IP-Address') ->
    diameter_3gpp_ts32_299:avp_header('Served-Party-IP-Address');
avp_header('Service-Data-Container') ->
    diameter_3gpp_ts32_299:avp_header('Service-Data-Container');
avp_header('Service-Id') ->
    diameter_3gpp_ts32_299:avp_header('Service-Id');
avp_header('Service-Mode') ->
    diameter_3gpp_ts32_299:avp_header('Service-Mode');
avp_header('Service-Specific-Data') ->
    diameter_3gpp_ts32_299:avp_header('Service-Specific-Data');
avp_header('Service-Specific-Info') ->
    diameter_3gpp_ts32_299:avp_header('Service-Specific-Info');
avp_header('Service-Specific-Type') ->
    diameter_3gpp_ts32_299:avp_header('Service-Specific-Type');
avp_header('Serving-Node-Identity') ->
    diameter_3gpp_ts32_299:avp_header('Serving-Node-Identity');
avp_header('Serving-Node-Type') ->
    diameter_3gpp_ts32_299:avp_header('Serving-Node-Type');
avp_header('Session-Direction') ->
    diameter_3gpp_ts32_299:avp_header('Session-Direction');
avp_header('Start-Time') ->
    diameter_3gpp_ts32_299:avp_header('Start-Time');
avp_header('Start-of-Charging') ->
    diameter_3gpp_ts32_299:avp_header('Start-of-Charging');
avp_header('Status-AS-Code') ->
    diameter_3gpp_ts32_299:avp_header('Status-AS-Code');
avp_header('Stop-Time') ->
    diameter_3gpp_ts32_299:avp_header('Stop-Time');
avp_header('Submission-Time') ->
    diameter_3gpp_ts32_299:avp_header('Submission-Time');
avp_header('Subscriber-Role') ->
    diameter_3gpp_ts32_299:avp_header('Subscriber-Role');
avp_header('Supplementary-Service') ->
    diameter_3gpp_ts32_299:avp_header('Supplementary-Service');
avp_header('TAD-Identifier') ->
    diameter_3gpp_ts32_299:avp_header('TAD-Identifier');
avp_header('TWAG-Address') ->
    diameter_3gpp_ts32_299:avp_header('TWAG-Address');
avp_header('TWAN-User-Location-Info') ->
    diameter_3gpp_ts32_299:avp_header('TWAN-User-Location-Info');
avp_header('Talk-Burst-Exchange') ->
    diameter_3gpp_ts32_299:avp_header('Talk-Burst-Exchange');
avp_header('Talk-Burst-Time') ->
    diameter_3gpp_ts32_299:avp_header('Talk-Burst-Time');
avp_header('Talk-Burst-Volume') ->
    diameter_3gpp_ts32_299:avp_header('Talk-Burst-Volume');
avp_header('Target-IP-Address') ->
    diameter_3gpp_ts32_299:avp_header('Target-IP-Address');
avp_header('Tariff-Information') ->
    diameter_3gpp_ts32_299:avp_header('Tariff-Information');
avp_header('Tariff-XML') ->
    diameter_3gpp_ts32_299:avp_header('Tariff-XML');
avp_header('Teleservice') ->
    diameter_3gpp_ts32_299:avp_header('Teleservice');
avp_header('Terminating-IOI') ->
    diameter_3gpp_ts32_299:avp_header('Terminating-IOI');
avp_header('Time-First-Reception') ->
    diameter_3gpp_ts32_299:avp_header('Time-First-Reception');
avp_header('Time-First-Transmission') ->
    diameter_3gpp_ts32_299:avp_header('Time-First-Transmission');
avp_header('Time-First-Usage') ->
    diameter_3gpp_ts32_299:avp_header('Time-First-Usage');
avp_header('Time-Indicator') ->
    diameter_3gpp_ts32_299:avp_header('Time-Indicator');
avp_header('Time-Last-Usage') ->
    diameter_3gpp_ts32_299:avp_header('Time-Last-Usage');
avp_header('Time-Quota-Mechanism') ->
    diameter_3gpp_ts32_299:avp_header('Time-Quota-Mechanism');
avp_header('Time-Quota-Threshold') ->
    diameter_3gpp_ts32_299:avp_header('Time-Quota-Threshold');
avp_header('Time-Quota-Type') ->
    diameter_3gpp_ts32_299:avp_header('Time-Quota-Type');
avp_header('Time-Stamps') ->
    diameter_3gpp_ts32_299:avp_header('Time-Stamps');
avp_header('Time-Usage') ->
    diameter_3gpp_ts32_299:avp_header('Time-Usage');
avp_header('Token-Text') ->
    diameter_3gpp_ts32_299:avp_header('Token-Text');
avp_header('Traffic-Data-Volumes') ->
    diameter_3gpp_ts32_299:avp_header('Traffic-Data-Volumes');
avp_header('Transcoder-Inserted-Indication') ->
    diameter_3gpp_ts32_299:avp_header('Transcoder-Inserted-Indication');
avp_header('Transit-IOI-List') ->
    diameter_3gpp_ts32_299:avp_header('Transit-IOI-List');
avp_header('Transmitter-Info') ->
    diameter_3gpp_ts32_299:avp_header('Transmitter-Info');
avp_header('Trigger') ->
    diameter_3gpp_ts32_299:avp_header('Trigger');
avp_header('Trigger-Type') ->
    diameter_3gpp_ts32_299:avp_header('Trigger-Type');
avp_header('Trunk-Group-Id') ->
    diameter_3gpp_ts32_299:avp_header('Trunk-Group-Id');
avp_header('Type-Number') ->
    diameter_3gpp_ts32_299:avp_header('Type-Number');
avp_header('UNI-PDU-CP-Only-Flag') ->
    diameter_3gpp_ts32_299:avp_header('UNI-PDU-CP-Only-Flag');
avp_header('UWAN-User-Location-Info') ->
    diameter_3gpp_ts32_299:avp_header('UWAN-User-Location-Info');
avp_header('Unit-Cost') ->
    diameter_3gpp_ts32_299:avp_header('Unit-Cost');
avp_header('Unit-Quota-Threshold') ->
    diameter_3gpp_ts32_299:avp_header('Unit-Quota-Threshold');
avp_header('Unused-Quota-Timer') ->
    diameter_3gpp_ts32_299:avp_header('Unused-Quota-Timer');
avp_header('Usage-Information-Report-Sequence-Number') ->
    diameter_3gpp_ts32_299:avp_header('Usage-Information-Report-Sequence-Number');
avp_header('User-CSG-Information') ->
    diameter_3gpp_ts32_299:avp_header('User-CSG-Information');
avp_header('User-Participating-Type') ->
    diameter_3gpp_ts32_299:avp_header('User-Participating-Type');
avp_header('User-Session-Id') ->
    diameter_3gpp_ts32_299:avp_header('User-Session-Id');
avp_header('VCS-Information') ->
    diameter_3gpp_ts32_299:avp_header('VCS-Information');
avp_header('VLR-Number') ->
    diameter_3gpp_ts32_299:avp_header('VLR-Number');
avp_header('Variable-Part') ->
    diameter_3gpp_ts32_299:avp_header('Variable-Part');
avp_header('Variable-Part-Order') ->
    diameter_3gpp_ts32_299:avp_header('Variable-Part-Order');
avp_header('Variable-Part-Type') ->
    diameter_3gpp_ts32_299:avp_header('Variable-Part-Type');
avp_header('Variable-Part-Value') ->
    diameter_3gpp_ts32_299:avp_header('Variable-Part-Value');
avp_header('Volume-Quota-Threshold') ->
    diameter_3gpp_ts32_299:avp_header('Volume-Quota-Threshold');
avp_header(_) -> erlang:error(badarg).

avp(T, Data, 'TP-NAT-IP-Address', Opts) ->
    diameter_types:'OctetString'(T, Data, Opts);
avp(T, Data, 'TP-NAT-Pool-Id', Opts) ->
    diameter_types:'UTF8String'(T, Data, Opts);
avp(T, Data, 'TP-NAT-Port-End', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'TP-NAT-Port-Start', Opts) ->
    diameter_types:'Unsigned32'(T, Data, Opts);
avp(T, Data, 'TP-Previous-PS-Information', Opts) ->
    grouped_avp(T,
                'TP-Previous-PS-Information',
                Data,
                Opts);
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
avp(T, Data, 'AN-GW-Address', Opts) ->
    avp(T,
        Data,
        'AN-GW-Address',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'AN-GW-Status', Opts) ->
    avp(T,
        Data,
        'AN-GW-Status',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'APN-Aggregate-Max-Bitrate-DL', Opts) ->
    avp(T,
        Data,
        'APN-Aggregate-Max-Bitrate-DL',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'APN-Aggregate-Max-Bitrate-UL', Opts) ->
    avp(T,
        Data,
        'APN-Aggregate-Max-Bitrate-UL',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Access-Network-Charging-Identifier-Gx',
    Opts) ->
    grouped_avp(T,
                'Access-Network-Charging-Identifier-Gx',
                Data,
                Opts);
avp(T, Data, 'Allocation-Retention-Priority', Opts) ->
    grouped_avp(T,
                'Allocation-Retention-Priority',
                Data,
                Opts);
avp(T, Data, 'Application-Detection-Information',
    Opts) ->
    grouped_avp(T,
                'Application-Detection-Information',
                Data,
                Opts);
avp(T, Data, 'Bearer-Control-Mode', Opts) ->
    avp(T,
        Data,
        'Bearer-Control-Mode',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Bearer-Identifier', Opts) ->
    avp(T,
        Data,
        'Bearer-Identifier',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Bearer-Operation', Opts) ->
    avp(T,
        Data,
        'Bearer-Operation',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Bearer-Usage', Opts) ->
    avp(T,
        Data,
        'Bearer-Usage',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'CSG-Information-Reporting', Opts) ->
    avp(T,
        Data,
        'CSG-Information-Reporting',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Charging-Correlation-Indicator', Opts) ->
    avp(T,
        Data,
        'Charging-Correlation-Indicator',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Charging-Rule-Base-Name', Opts) ->
    avp(T,
        Data,
        'Charging-Rule-Base-Name',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Charging-Rule-Definition', Opts) ->
    grouped_avp(T, 'Charging-Rule-Definition', Data, Opts);
avp(T, Data, 'Charging-Rule-Install', Opts) ->
    grouped_avp(T, 'Charging-Rule-Install', Data, Opts);
avp(T, Data, 'Charging-Rule-Name', Opts) ->
    avp(T,
        Data,
        'Charging-Rule-Name',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Charging-Rule-Remove', Opts) ->
    grouped_avp(T, 'Charging-Rule-Remove', Data, Opts);
avp(T, Data, 'Charging-Rule-Report', Opts) ->
    grouped_avp(T, 'Charging-Rule-Report', Data, Opts);
avp(T, Data, 'CoA-IP-Address', Opts) ->
    avp(T,
        Data,
        'CoA-IP-Address',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'CoA-Information', Opts) ->
    grouped_avp(T, 'CoA-Information', Data, Opts);
avp(T, Data, 'Conditional-APN-Aggregate-Max-Bitrate',
    Opts) ->
    grouped_avp(T,
                'Conditional-APN-Aggregate-Max-Bitrate',
                Data,
                Opts);
avp(T, Data, 'Credit-Management-Status', Opts) ->
    avp(T,
        Data,
        'Credit-Management-Status',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Default-EPS-Bearer-QoS', Opts) ->
    grouped_avp(T, 'Default-EPS-Bearer-QoS', Data, Opts);
avp(T, Data, 'Default-QoS-Information', Opts) ->
    grouped_avp(T, 'Default-QoS-Information', Data, Opts);
avp(T, Data, 'Default-QoS-Name', Opts) ->
    avp(T,
        Data,
        'Default-QoS-Name',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Event-Report-Indication', Opts) ->
    grouped_avp(T, 'Event-Report-Indication', Data, Opts);
avp(T, Data, 'Event-Trigger', Opts) ->
    avp(T,
        Data,
        'Event-Trigger',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Fixed-User-Location-Info', Opts) ->
    grouped_avp(T, 'Fixed-User-Location-Info', Data, Opts);
avp(T, Data, 'Flow-Direction', Opts) ->
    avp(T,
        Data,
        'Flow-Direction',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Flow-Information', Opts) ->
    grouped_avp(T, 'Flow-Information', Data, Opts);
avp(T, Data, 'Flow-Label', Opts) ->
    avp(T,
        Data,
        'Flow-Label',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Guaranteed-Bitrate-DL', Opts) ->
    avp(T,
        Data,
        'Guaranteed-Bitrate-DL',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Guaranteed-Bitrate-UL', Opts) ->
    avp(T,
        Data,
        'Guaranteed-Bitrate-UL',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'HeNB-Local-IP-Address', Opts) ->
    avp(T,
        Data,
        'HeNB-Local-IP-Address',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'IP-CAN-Session-Charging-Scope', Opts) ->
    avp(T,
        Data,
        'IP-CAN-Session-Charging-Scope',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'IP-CAN-Type', Opts) ->
    avp(T,
        Data,
        'IP-CAN-Type',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Metering-Method', Opts) ->
    avp(T,
        Data,
        'Metering-Method',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Monitoring-Key', Opts) ->
    avp(T,
        Data,
        'Monitoring-Key',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Monitoring-Time', Opts) ->
    avp(T,
        Data,
        'Monitoring-Time',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Mute-Notification', Opts) ->
    avp(T,
        Data,
        'Mute-Notification',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'NetLoc-Access-Support', Opts) ->
    avp(T,
        Data,
        'NetLoc-Access-Support',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Network-Request-Support', Opts) ->
    avp(T,
        Data,
        'Network-Request-Support',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Offline', Opts) ->
    avp(T, Data, 'Offline', Opts, diameter_3gpp_ts29_212);
avp(T, Data, 'Online', Opts) ->
    avp(T, Data, 'Online', Opts, diameter_3gpp_ts29_212);
avp(T, Data, 'PCC-Rule-Status', Opts) ->
    avp(T,
        Data,
        'PCC-Rule-Status',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'PCSCF-Restoration-Indication', Opts) ->
    avp(T,
        Data,
        'PCSCF-Restoration-Indication',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'PDN-Connection-ID', Opts) ->
    avp(T,
        Data,
        'PDN-Connection-ID',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'PS-to-CS-Session-Continuity', Opts) ->
    avp(T,
        Data,
        'PS-to-CS-Session-Continuity',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Packet-Filter-Content', Opts) ->
    avp(T,
        Data,
        'Packet-Filter-Content',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Packet-Filter-Identifier', Opts) ->
    avp(T,
        Data,
        'Packet-Filter-Identifier',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Packet-Filter-Information', Opts) ->
    grouped_avp(T, 'Packet-Filter-Information', Data, Opts);
avp(T, Data, 'Packet-Filter-Operation', Opts) ->
    avp(T,
        Data,
        'Packet-Filter-Operation',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Packet-Filter-Usage', Opts) ->
    avp(T,
        Data,
        'Packet-Filter-Usage',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Pre-emption-Capability', Opts) ->
    avp(T,
        Data,
        'Pre-emption-Capability',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Pre-emption-Vulnerability', Opts) ->
    avp(T,
        Data,
        'Pre-emption-Vulnerability',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Precedence', Opts) ->
    avp(T,
        Data,
        'Precedence',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Presence-Reporting-Area-Elements-List',
    Opts) ->
    avp(T,
        Data,
        'Presence-Reporting-Area-Elements-List',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Presence-Reporting-Area-Identifier',
    Opts) ->
    avp(T,
        Data,
        'Presence-Reporting-Area-Identifier',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Presence-Reporting-Area-Information',
    Opts) ->
    grouped_avp(T,
                'Presence-Reporting-Area-Information',
                Data,
                Opts);
avp(T, Data, 'Presence-Reporting-Area-Status', Opts) ->
    avp(T,
        Data,
        'Presence-Reporting-Area-Status',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Priority-Level', Opts) ->
    avp(T,
        Data,
        'Priority-Level',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'QoS-Class-Identifier', Opts) ->
    avp(T,
        Data,
        'QoS-Class-Identifier',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'QoS-Information', Opts) ->
    grouped_avp(T, 'QoS-Information', Data, Opts);
avp(T, Data, 'QoS-Negotiation', Opts) ->
    avp(T,
        Data,
        'QoS-Negotiation',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'QoS-Upgrade', Opts) ->
    avp(T,
        Data,
        'QoS-Upgrade',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'RAN-NAS-Release-Cause', Opts) ->
    avp(T,
        Data,
        'RAN-NAS-Release-Cause',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'RAT-Type', Opts) ->
    avp(T, Data, 'RAT-Type', Opts, diameter_3gpp_ts29_212);
avp(T, Data, 'Redirect-Information', Opts) ->
    grouped_avp(T, 'Redirect-Information', Data, Opts);
avp(T, Data, 'Redirect-Support', Opts) ->
    avp(T,
        Data,
        'Redirect-Support',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Reporting-Level', Opts) ->
    avp(T,
        Data,
        'Reporting-Level',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Resource-Allocation-Notification',
    Opts) ->
    avp(T,
        Data,
        'Resource-Allocation-Notification',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Revalidation-Time', Opts) ->
    avp(T,
        Data,
        'Revalidation-Time',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Routing-Filter', Opts) ->
    grouped_avp(T, 'Routing-Filter', Data, Opts);
avp(T, Data, 'Routing-IP-Address', Opts) ->
    avp(T,
        Data,
        'Routing-IP-Address',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Routing-Rule-Definition', Opts) ->
    grouped_avp(T, 'Routing-Rule-Definition', Data, Opts);
avp(T, Data, 'Routing-Rule-Identifier', Opts) ->
    avp(T,
        Data,
        'Routing-Rule-Identifier',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Routing-Rule-Install', Opts) ->
    grouped_avp(T, 'Routing-Rule-Install', Data, Opts);
avp(T, Data, 'Routing-Rule-Remove', Opts) ->
    grouped_avp(T, 'Routing-Rule-Remove', Data, Opts);
avp(T, Data, 'Rule-Activation-Time', Opts) ->
    avp(T,
        Data,
        'Rule-Activation-Time',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Rule-Deactivation-Time', Opts) ->
    avp(T,
        Data,
        'Rule-Deactivation-Time',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Rule-Failure-Code', Opts) ->
    avp(T,
        Data,
        'Rule-Failure-Code',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Security-Parameter-Index', Opts) ->
    avp(T,
        Data,
        'Security-Parameter-Index',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Session-Release-Cause', Opts) ->
    avp(T,
        Data,
        'Session-Release-Cause',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'TDF-Application-Identifier', Opts) ->
    avp(T,
        Data,
        'TDF-Application-Identifier',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'TDF-Application-Instance-Identifier',
    Opts) ->
    avp(T,
        Data,
        'TDF-Application-Instance-Identifier',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'TDF-Destination-Host', Opts) ->
    avp(T,
        Data,
        'TDF-Destination-Host',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'TDF-Destination-Realm', Opts) ->
    avp(T,
        Data,
        'TDF-Destination-Realm',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'TDF-IP-Address', Opts) ->
    avp(T,
        Data,
        'TDF-IP-Address',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'TDF-Information', Opts) ->
    grouped_avp(T, 'TDF-Information', Data, Opts);
avp(T, Data, 'TFT-Filter', Opts) ->
    avp(T,
        Data,
        'TFT-Filter',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'TFT-Packet-Filter-Information', Opts) ->
    grouped_avp(T,
                'TFT-Packet-Filter-Information',
                Data,
                Opts);
avp(T, Data, 'ToS-Traffic-Class', Opts) ->
    avp(T,
        Data,
        'ToS-Traffic-Class',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Tunnel-Header-Filter', Opts) ->
    avp(T,
        Data,
        'Tunnel-Header-Filter',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Tunnel-Header-Length', Opts) ->
    avp(T,
        Data,
        'Tunnel-Header-Length',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Tunnel-Information', Opts) ->
    grouped_avp(T, 'Tunnel-Information', Data, Opts);
avp(T, Data, 'UDP-Source-Port', Opts) ->
    avp(T,
        Data,
        'UDP-Source-Port',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'UE-Local-IP-Address', Opts) ->
    avp(T,
        Data,
        'UE-Local-IP-Address',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Usage-Monitoring-Information', Opts) ->
    grouped_avp(T,
                'Usage-Monitoring-Information',
                Data,
                Opts);
avp(T, Data, 'Usage-Monitoring-Level', Opts) ->
    avp(T,
        Data,
        'Usage-Monitoring-Level',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Usage-Monitoring-Report', Opts) ->
    avp(T,
        Data,
        'Usage-Monitoring-Report',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'Usage-Monitoring-Support', Opts) ->
    avp(T,
        Data,
        'Usage-Monitoring-Support',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, 'User-Location-Info-Time', Opts) ->
    avp(T,
        Data,
        'User-Location-Info-Time',
        Opts,
        diameter_3gpp_ts29_212);
avp(T, Data, '3GPP-PS-Data-Off-Status', Opts) ->
    avp(T,
        Data,
        '3GPP-PS-Data-Off-Status',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'AF-Correlation-Information', Opts) ->
    grouped_avp(T,
                'AF-Correlation-Information',
                Data,
                Opts);
avp(T, Data, 'APN-Rate-Control', Opts) ->
    grouped_avp(T, 'APN-Rate-Control', Data, Opts);
avp(T, Data, 'APN-Rate-Control-Downlink', Opts) ->
    grouped_avp(T, 'APN-Rate-Control-Downlink', Data, Opts);
avp(T, Data, 'APN-Rate-Control-Uplink', Opts) ->
    grouped_avp(T, 'APN-Rate-Control-Uplink', Data, Opts);
avp(T, Data, 'Access-Network-Info-Change', Opts) ->
    grouped_avp(T,
                'Access-Network-Info-Change',
                Data,
                Opts);
avp(T, Data, 'Access-Network-Information', Opts) ->
    avp(T,
        Data,
        'Access-Network-Information',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Access-Transfer-Information', Opts) ->
    grouped_avp(T,
                'Access-Transfer-Information',
                Data,
                Opts);
avp(T, Data, 'Access-Transfer-Type', Opts) ->
    avp(T,
        Data,
        'Access-Transfer-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Account-Expiration', Opts) ->
    avp(T,
        Data,
        'Account-Expiration',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Accumulated-Cost', Opts) ->
    grouped_avp(T, 'Accumulated-Cost', Data, Opts);
avp(T, Data, 'Adaptations', Opts) ->
    avp(T,
        Data,
        'Adaptations',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Additional-Content-Information', Opts) ->
    grouped_avp(T,
                'Additional-Content-Information',
                Data,
                Opts);
avp(T, Data, 'Additional-Exception-Reports', Opts) ->
    avp(T,
        Data,
        'Additional-Exception-Reports',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Additional-Type-Information', Opts) ->
    avp(T,
        Data,
        'Additional-Type-Information',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Address-Data', Opts) ->
    avp(T,
        Data,
        'Address-Data',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Address-Domain', Opts) ->
    grouped_avp(T, 'Address-Domain', Data, Opts);
avp(T, Data, 'Address-Type', Opts) ->
    avp(T,
        Data,
        'Address-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Addressee-Type', Opts) ->
    avp(T,
        Data,
        'Addressee-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Alternate-Charged-Party-Address', Opts) ->
    avp(T,
        Data,
        'Alternate-Charged-Party-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Announcement-Identifier', Opts) ->
    avp(T,
        Data,
        'Announcement-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Announcement-Information', Opts) ->
    grouped_avp(T, 'Announcement-Information', Data, Opts);
avp(T, Data, 'Announcement-Order', Opts) ->
    avp(T,
        Data,
        'Announcement-Order',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Announcing-PLMN-ID', Opts) ->
    avp(T,
        Data,
        'Announcing-PLMN-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Announcing-UE-HPLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Announcing-UE-HPLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Announcing-UE-VPLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Announcing-UE-VPLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'AoC-Cost-Information', Opts) ->
    grouped_avp(T, 'AoC-Cost-Information', Data, Opts);
avp(T, Data, 'AoC-Format', Opts) ->
    avp(T,
        Data,
        'AoC-Format',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'AoC-Information', Opts) ->
    grouped_avp(T, 'AoC-Information', Data, Opts);
avp(T, Data, 'AoC-Request-Type', Opts) ->
    avp(T,
        Data,
        'AoC-Request-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'AoC-Service', Opts) ->
    grouped_avp(T, 'AoC-Service', Data, Opts);
avp(T, Data, 'AoC-Service-Obligatory-Type', Opts) ->
    avp(T,
        Data,
        'AoC-Service-Obligatory-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'AoC-Service-Type', Opts) ->
    avp(T,
        Data,
        'AoC-Service-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'AoC-Subscription-Information', Opts) ->
    grouped_avp(T,
                'AoC-Subscription-Information',
                Data,
                Opts);
avp(T, Data, 'Applic-ID', Opts) ->
    avp(T, Data, 'Applic-ID', Opts, diameter_3gpp_ts32_299);
avp(T, Data,
    'Application-Provided-Called-Party-Address', Opts) ->
    avp(T,
        Data,
        'Application-Provided-Called-Party-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Application-Server', Opts) ->
    avp(T,
        Data,
        'Application-Server',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Application-Server-Information', Opts) ->
    grouped_avp(T,
                'Application-Server-Information',
                Data,
                Opts);
avp(T, Data, 'Application-Specific-Data', Opts) ->
    avp(T,
        Data,
        'Application-Specific-Data',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Associated-Party-Address', Opts) ->
    avp(T,
        Data,
        'Associated-Party-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Associated-URI', Opts) ->
    avp(T,
        Data,
        'Associated-URI',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Authorised-QoS', Opts) ->
    avp(T,
        Data,
        'Authorised-QoS',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Aux-Applic-Info', Opts) ->
    avp(T,
        Data,
        'Aux-Applic-Info',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'BSSID', Opts) ->
    avp(T, Data, 'BSSID', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'Base-Time-Interval', Opts) ->
    avp(T,
        Data,
        'Base-Time-Interval',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Basic-Service-Code', Opts) ->
    grouped_avp(T, 'Basic-Service-Code', Data, Opts);
avp(T, Data, 'Bearer-Capability', Opts) ->
    avp(T,
        Data,
        'Bearer-Capability',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Bearer-Service', Opts) ->
    avp(T,
        Data,
        'Bearer-Service',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'CG-Address', Opts) ->
    avp(T,
        Data,
        'CG-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'CN-Operator-Selection-Entity', Opts) ->
    avp(T,
        Data,
        'CN-Operator-Selection-Entity',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'CP-CIoT-EPS-Optimisation-Indicator',
    Opts) ->
    avp(T,
        Data,
        'CP-CIoT-EPS-Optimisation-Indicator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'CPDT-Information', Opts) ->
    grouped_avp(T, 'CPDT-Information', Data, Opts);
avp(T, Data, 'CSG-Access-Mode', Opts) ->
    avp(T,
        Data,
        'CSG-Access-Mode',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'CSG-Membership-Indication', Opts) ->
    avp(T,
        Data,
        'CSG-Membership-Indication',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'CUG-Information', Opts) ->
    avp(T,
        Data,
        'CUG-Information',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Called-Asserted-Identity', Opts) ->
    avp(T,
        Data,
        'Called-Asserted-Identity',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Called-Identity', Opts) ->
    avp(T,
        Data,
        'Called-Identity',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Called-Identity-Change', Opts) ->
    grouped_avp(T, 'Called-Identity-Change', Data, Opts);
avp(T, Data, 'Called-Party-Address', Opts) ->
    avp(T,
        Data,
        'Called-Party-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Calling-Party-Address', Opts) ->
    avp(T,
        Data,
        'Calling-Party-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Carrier-Select-Routing-Information',
    Opts) ->
    avp(T,
        Data,
        'Carrier-Select-Routing-Information',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Cause-Code', Opts) ->
    avp(T,
        Data,
        'Cause-Code',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Cellular-Network-Information', Opts) ->
    avp(T,
        Data,
        'Cellular-Network-Information',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Change-Condition', Opts) ->
    avp(T,
        Data,
        'Change-Condition',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Change-Time', Opts) ->
    avp(T,
        Data,
        'Change-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Charge-Reason-Code', Opts) ->
    avp(T,
        Data,
        'Charge-Reason-Code',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Charged-Party', Opts) ->
    avp(T,
        Data,
        'Charged-Party',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Charging-Characteristics-Selection-Mode',
    Opts) ->
    avp(T,
        Data,
        'Charging-Characteristics-Selection-Mode',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Charging-Per-IP-CAN-Session-Indicator',
    Opts) ->
    avp(T,
        Data,
        'Charging-Per-IP-CAN-Session-Indicator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Class-Identifier', Opts) ->
    avp(T,
        Data,
        'Class-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Client-Address', Opts) ->
    avp(T,
        Data,
        'Client-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Content-Class', Opts) ->
    avp(T,
        Data,
        'Content-Class',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Content-Disposition', Opts) ->
    avp(T,
        Data,
        'Content-Disposition',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Content-Length', Opts) ->
    avp(T,
        Data,
        'Content-Length',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Content-Size', Opts) ->
    avp(T,
        Data,
        'Content-Size',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Content-Type', Opts) ->
    avp(T,
        Data,
        'Content-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Coverage-Info', Opts) ->
    grouped_avp(T, 'Coverage-Info', Data, Opts);
avp(T, Data, 'Coverage-Status', Opts) ->
    avp(T,
        Data,
        'Coverage-Status',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Current-Tariff', Opts) ->
    grouped_avp(T, 'Current-Tariff', Data, Opts);
avp(T, Data, 'DRM-Content', Opts) ->
    avp(T,
        Data,
        'DRM-Content',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Data-Coding-Scheme', Opts) ->
    avp(T,
        Data,
        'Data-Coding-Scheme',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Deferred-Location-Event-Type', Opts) ->
    avp(T,
        Data,
        'Deferred-Location-Event-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Delivery-Report-Requested', Opts) ->
    avp(T,
        Data,
        'Delivery-Report-Requested',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Destination-Interface', Opts) ->
    grouped_avp(T, 'Destination-Interface', Data, Opts);
avp(T, Data, 'Diagnostics', Opts) ->
    avp(T,
        Data,
        'Diagnostics',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Discoveree-UE-HPLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Discoveree-UE-HPLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Discoveree-UE-VPLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Discoveree-UE-VPLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Discoverer-UE-HPLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Discoverer-UE-HPLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Discoverer-UE-VPLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Discoverer-UE-VPLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Domain-Name', Opts) ->
    avp(T,
        Data,
        'Domain-Name',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Dynamic-Address-Flag', Opts) ->
    avp(T,
        Data,
        'Dynamic-Address-Flag',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Dynamic-Address-Flag-Extension', Opts) ->
    avp(T,
        Data,
        'Dynamic-Address-Flag-Extension',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'EPDG-Address', Opts) ->
    avp(T,
        Data,
        'EPDG-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Early-Media-Description', Opts) ->
    grouped_avp(T, 'Early-Media-Description', Data, Opts);
avp(T, Data, 'Enhanced-Diagnostics', Opts) ->
    grouped_avp(T, 'Enhanced-Diagnostics', Data, Opts);
avp(T, Data, 'Envelope', Opts) ->
    grouped_avp(T, 'Envelope', Data, Opts);
avp(T, Data, 'Envelope-End-Time', Opts) ->
    avp(T,
        Data,
        'Envelope-End-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Envelope-Reporting', Opts) ->
    avp(T,
        Data,
        'Envelope-Reporting',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Envelope-Start-Time', Opts) ->
    avp(T,
        Data,
        'Envelope-Start-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Event', Opts) ->
    avp(T, Data, 'Event', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'Event-Charging-TimeStamp', Opts) ->
    avp(T,
        Data,
        'Event-Charging-TimeStamp',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Event-Type', Opts) ->
    grouped_avp(T, 'Event-Type', Data, Opts);
avp(T, Data, 'Expires', Opts) ->
    avp(T, Data, 'Expires', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'FE-Identifier-List', Opts) ->
    avp(T,
        Data,
        'FE-Identifier-List',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'File-Repair-Supported', Opts) ->
    avp(T,
        Data,
        'File-Repair-Supported',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Forwarding-Pending', Opts) ->
    avp(T,
        Data,
        'Forwarding-Pending',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'From-Address', Opts) ->
    avp(T,
        Data,
        'From-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'GGSN-Address', Opts) ->
    avp(T,
        Data,
        'GGSN-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'IMS-Application-Reference-Identifier',
    Opts) ->
    avp(T,
        Data,
        'IMS-Application-Reference-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'IMS-Charging-Identifier', Opts) ->
    avp(T,
        Data,
        'IMS-Charging-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'IMS-Communication-Service-Identifier',
    Opts) ->
    avp(T,
        Data,
        'IMS-Communication-Service-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'IMS-Emergency-Indicator', Opts) ->
    avp(T,
        Data,
        'IMS-Emergency-Indicator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'IMS-Information', Opts) ->
    grouped_avp(T, 'IMS-Information', Data, Opts);
avp(T, Data, 'IMS-Visited-Network-Identifier', Opts) ->
    avp(T,
        Data,
        'IMS-Visited-Network-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'IMSI-Unauthenticated-Flag', Opts) ->
    avp(T,
        Data,
        'IMSI-Unauthenticated-Flag',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'IP-Realm-Default-Indication', Opts) ->
    avp(T,
        Data,
        'IP-Realm-Default-Indication',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ISUP-Cause', Opts) ->
    grouped_avp(T, 'ISUP-Cause', Data, Opts);
avp(T, Data, 'ISUP-Cause-Diagnostics', Opts) ->
    avp(T,
        Data,
        'ISUP-Cause-Diagnostics',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ISUP-Cause-Location', Opts) ->
    avp(T,
        Data,
        'ISUP-Cause-Location',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ISUP-Cause-Value', Opts) ->
    avp(T,
        Data,
        'ISUP-Cause-Value',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ISUP-Location-Number', Opts) ->
    avp(T,
        Data,
        'ISUP-Location-Number',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Incoming-Trunk-Group-Id', Opts) ->
    avp(T,
        Data,
        'Incoming-Trunk-Group-Id',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Incremental-Cost', Opts) ->
    grouped_avp(T, 'Incremental-Cost', Data, Opts);
avp(T, Data, 'Initial-IMS-Charging-Identifier', Opts) ->
    avp(T,
        Data,
        'Initial-IMS-Charging-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Instance-Id', Opts) ->
    avp(T,
        Data,
        'Instance-Id',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Inter-Operator-Identifier', Opts) ->
    grouped_avp(T, 'Inter-Operator-Identifier', Data, Opts);
avp(T, Data, 'Inter-UE-Transfer', Opts) ->
    avp(T,
        Data,
        'Inter-UE-Transfer',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Interface-Id', Opts) ->
    avp(T,
        Data,
        'Interface-Id',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Interface-Port', Opts) ->
    avp(T,
        Data,
        'Interface-Port',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Interface-Text', Opts) ->
    avp(T,
        Data,
        'Interface-Text',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Interface-Type', Opts) ->
    avp(T,
        Data,
        'Interface-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'LCS-APN', Opts) ->
    avp(T, Data, 'LCS-APN', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'LCS-Client-Dialed-By-MS', Opts) ->
    avp(T,
        Data,
        'LCS-Client-Dialed-By-MS',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'LCS-Client-External-ID', Opts) ->
    avp(T,
        Data,
        'LCS-Client-External-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'LCS-Client-ID', Opts) ->
    grouped_avp(T, 'LCS-Client-ID', Data, Opts);
avp(T, Data, 'LCS-Client-Name', Opts) ->
    grouped_avp(T, 'LCS-Client-Name', Data, Opts);
avp(T, Data, 'LCS-Client-Type', Opts) ->
    avp(T,
        Data,
        'LCS-Client-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'LCS-Data-Coding-Scheme', Opts) ->
    avp(T,
        Data,
        'LCS-Data-Coding-Scheme',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'LCS-Format-Indicator', Opts) ->
    avp(T,
        Data,
        'LCS-Format-Indicator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'LCS-Information', Opts) ->
    grouped_avp(T, 'LCS-Information', Data, Opts);
avp(T, Data, 'LCS-Name-String', Opts) ->
    avp(T,
        Data,
        'LCS-Name-String',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'LCS-Requestor-ID', Opts) ->
    grouped_avp(T, 'LCS-Requestor-ID', Data, Opts);
avp(T, Data, 'LCS-Requestor-ID-String', Opts) ->
    avp(T,
        Data,
        'LCS-Requestor-ID-String',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Language', Opts) ->
    avp(T, Data, 'Language', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'Layer-2-Group-ID', Opts) ->
    avp(T,
        Data,
        'Layer-2-Group-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Local-GW-Inserted-Indication', Opts) ->
    avp(T,
        Data,
        'Local-GW-Inserted-Indication',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Local-Sequence-Number', Opts) ->
    avp(T,
        Data,
        'Local-Sequence-Number',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Location-Estimate', Opts) ->
    avp(T,
        Data,
        'Location-Estimate',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Location-Estimate-Type', Opts) ->
    avp(T,
        Data,
        'Location-Estimate-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Location-Info', Opts) ->
    grouped_avp(T, 'Location-Info', Data, Opts);
avp(T, Data, 'Location-Type', Opts) ->
    grouped_avp(T, 'Location-Type', Data, Opts);
avp(T, Data, 'Low-Balance-Indication', Opts) ->
    avp(T,
        Data,
        'Low-Balance-Indication',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Low-Priority-Indicator', Opts) ->
    avp(T,
        Data,
        'Low-Priority-Indicator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'MBMS-Charged-Party', Opts) ->
    avp(T,
        Data,
        'MBMS-Charged-Party',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'MBMS-GW-Address', Opts) ->
    avp(T,
        Data,
        'MBMS-GW-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'MBMS-Information', Opts) ->
    grouped_avp(T, 'MBMS-Information', Data, Opts);
avp(T, Data, 'MBMS-User-Service-Type', Opts) ->
    avp(T,
        Data,
        'MBMS-User-Service-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'MM-Content-Type', Opts) ->
    grouped_avp(T, 'MM-Content-Type', Data, Opts);
avp(T, Data, 'MMBox-Storage-Requested', Opts) ->
    avp(T,
        Data,
        'MMBox-Storage-Requested',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'MMS-Information', Opts) ->
    grouped_avp(T, 'MMS-Information', Data, Opts);
avp(T, Data, 'MMTel-Information', Opts) ->
    grouped_avp(T, 'MMTel-Information', Data, Opts);
avp(T, Data, 'MMTel-SService-Type', Opts) ->
    avp(T,
        Data,
        'MMTel-SService-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'MSC-Address', Opts) ->
    avp(T,
        Data,
        'MSC-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'MTC-IWF-Address', Opts) ->
    avp(T,
        Data,
        'MTC-IWF-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Media-Initiator-Flag', Opts) ->
    avp(T,
        Data,
        'Media-Initiator-Flag',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Media-Initiator-Party', Opts) ->
    avp(T,
        Data,
        'Media-Initiator-Party',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Message-Body', Opts) ->
    grouped_avp(T, 'Message-Body', Data, Opts);
avp(T, Data, 'Message-Class', Opts) ->
    grouped_avp(T, 'Message-Class', Data, Opts);
avp(T, Data, 'Message-ID', Opts) ->
    avp(T,
        Data,
        'Message-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Message-Size', Opts) ->
    avp(T,
        Data,
        'Message-Size',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Message-Type', Opts) ->
    avp(T,
        Data,
        'Message-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Monitored-PLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Monitored-PLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Monitoring-Event-Configuration-Activity',
    Opts) ->
    avp(T,
        Data,
        'Monitoring-Event-Configuration-Activity',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Monitoring-Event-Functionality', Opts) ->
    avp(T,
        Data,
        'Monitoring-Event-Functionality',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Monitoring-Event-Information', Opts) ->
    grouped_avp(T,
                'Monitoring-Event-Information',
                Data,
                Opts);
avp(T, Data, 'Monitoring-Event-Report-Data', Opts) ->
    grouped_avp(T,
                'Monitoring-Event-Report-Data',
                Data,
                Opts);
avp(T, Data, 'Monitoring-Event-Report-Number', Opts) ->
    avp(T,
        Data,
        'Monitoring-Event-Report-Number',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Monitoring-UE-HPLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Monitoring-UE-HPLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Monitoring-UE-Identifier', Opts) ->
    avp(T,
        Data,
        'Monitoring-UE-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Monitoring-UE-VPLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Monitoring-UE-VPLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'NIDD-Submission', Opts) ->
    grouped_avp(T, 'NIDD-Submission', Data, Opts);
avp(T, Data, 'NNI-Information', Opts) ->
    grouped_avp(T, 'NNI-Information', Data, Opts);
avp(T, Data, 'NNI-Type', Opts) ->
    avp(T, Data, 'NNI-Type', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'Neighbour-Node-Address', Opts) ->
    avp(T,
        Data,
        'Neighbour-Node-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Network-Call-Reference-Number', Opts) ->
    avp(T,
        Data,
        'Network-Call-Reference-Number',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Next-Tariff', Opts) ->
    grouped_avp(T, 'Next-Tariff', Data, Opts);
avp(T, Data, 'Node-Functionality', Opts) ->
    avp(T,
        Data,
        'Node-Functionality',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Node-Id', Opts) ->
    avp(T, Data, 'Node-Id', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'Number-Of-Diversions', Opts) ->
    avp(T,
        Data,
        'Number-Of-Diversions',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Number-Of-Messages-Sent', Opts) ->
    avp(T,
        Data,
        'Number-Of-Messages-Sent',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Number-Of-Participants', Opts) ->
    avp(T,
        Data,
        'Number-Of-Participants',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Number-Of-Received-Talk-Bursts', Opts) ->
    avp(T,
        Data,
        'Number-Of-Received-Talk-Bursts',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Number-Of-Talk-Bursts', Opts) ->
    avp(T,
        Data,
        'Number-Of-Talk-Bursts',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Number-Portability-Routing-Information',
    Opts) ->
    avp(T,
        Data,
        'Number-Portability-Routing-Information',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Offline-Charging', Opts) ->
    grouped_avp(T, 'Offline-Charging', Data, Opts);
avp(T, Data, 'Online-Charging-Flag', Opts) ->
    avp(T,
        Data,
        'Online-Charging-Flag',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Originating-IOI', Opts) ->
    avp(T,
        Data,
        'Originating-IOI',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Originator', Opts) ->
    avp(T,
        Data,
        'Originator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Originator-Address', Opts) ->
    grouped_avp(T, 'Originator-Address', Data, Opts);
avp(T, Data, 'Originator-Interface', Opts) ->
    grouped_avp(T, 'Originator-Interface', Data, Opts);
avp(T, Data, 'Originator-Received-Address', Opts) ->
    grouped_avp(T,
                'Originator-Received-Address',
                Data,
                Opts);
avp(T, Data, 'Originator-SCCP-Address', Opts) ->
    avp(T,
        Data,
        'Originator-SCCP-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Outgoing-Session-Id', Opts) ->
    avp(T,
        Data,
        'Outgoing-Session-Id',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Outgoing-Trunk-Group-Id', Opts) ->
    avp(T,
        Data,
        'Outgoing-Trunk-Group-Id',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PC3-Control-Protocol-Cause', Opts) ->
    avp(T,
        Data,
        'PC3-Control-Protocol-Cause',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PC3-EPC-Control-Protocol-Cause', Opts) ->
    avp(T,
        Data,
        'PC3-EPC-Control-Protocol-Cause',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PC5-Radio-Technology', Opts) ->
    avp(T,
        Data,
        'PC5-Radio-Technology',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PDN-Connection-Charging-ID', Opts) ->
    avp(T,
        Data,
        'PDN-Connection-Charging-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PDP-Address', Opts) ->
    avp(T,
        Data,
        'PDP-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PDP-Address-Prefix-Length', Opts) ->
    avp(T,
        Data,
        'PDP-Address-Prefix-Length',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PDP-Context-Type', Opts) ->
    avp(T,
        Data,
        'PDP-Context-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PS-Append-Free-Format-Data', Opts) ->
    avp(T,
        Data,
        'PS-Append-Free-Format-Data',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PS-Free-Format-Data', Opts) ->
    avp(T,
        Data,
        'PS-Free-Format-Data',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PS-Furnish-Charging-Information', Opts) ->
    grouped_avp(T,
                'PS-Furnish-Charging-Information',
                Data,
                Opts);
avp(T, Data, 'PS-Information', Opts) ->
    grouped_avp(T, 'PS-Information', Data, Opts);
avp(T, Data, 'Participant-Access-Priority', Opts) ->
    avp(T,
        Data,
        'Participant-Access-Priority',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Participant-Action-Type', Opts) ->
    avp(T,
        Data,
        'Participant-Action-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Participant-Group', Opts) ->
    grouped_avp(T, 'Participant-Group', Data, Opts);
avp(T, Data, 'Participants-Involved', Opts) ->
    avp(T,
        Data,
        'Participants-Involved',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Play-Alternative', Opts) ->
    avp(T,
        Data,
        'Play-Alternative',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-Change-Condition', Opts) ->
    avp(T,
        Data,
        'PoC-Change-Condition',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-Change-Time', Opts) ->
    avp(T,
        Data,
        'PoC-Change-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-Controlling-Address', Opts) ->
    avp(T,
        Data,
        'PoC-Controlling-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-Event-Type', Opts) ->
    avp(T,
        Data,
        'PoC-Event-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-Group-Name', Opts) ->
    avp(T,
        Data,
        'PoC-Group-Name',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-Information', Opts) ->
    grouped_avp(T, 'PoC-Information', Data, Opts);
avp(T, Data, 'PoC-Server-Role', Opts) ->
    avp(T,
        Data,
        'PoC-Server-Role',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-Session-Id', Opts) ->
    avp(T,
        Data,
        'PoC-Session-Id',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-Session-Initiation-Type', Opts) ->
    avp(T,
        Data,
        'PoC-Session-Initiation-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-Session-Type', Opts) ->
    avp(T,
        Data,
        'PoC-Session-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-User-Role', Opts) ->
    grouped_avp(T, 'PoC-User-Role', Data, Opts);
avp(T, Data, 'PoC-User-Role-IDs', Opts) ->
    avp(T,
        Data,
        'PoC-User-Role-IDs',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'PoC-User-Role-Info-Units', Opts) ->
    avp(T,
        Data,
        'PoC-User-Role-Info-Units',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Positioning-Data', Opts) ->
    avp(T,
        Data,
        'Positioning-Data',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Preferred-AoC-Currency', Opts) ->
    avp(T,
        Data,
        'Preferred-AoC-Currency',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Priority', Opts) ->
    avp(T, Data, 'Priority', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'Privacy-Indicator', Opts) ->
    avp(T,
        Data,
        'Privacy-Indicator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-3rd-Party-Application-ID', Opts) ->
    avp(T,
        Data,
        'ProSe-3rd-Party-Application-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data,
    'ProSe-Direct-Communication-Reception-Data-Container',
    Opts) ->
    grouped_avp(T,
                'ProSe-Direct-Communication-Reception-Data-Container',
                Data,
                Opts);
avp(T, Data,
    'ProSe-Direct-Communication-Transmission-Data-Container',
    Opts) ->
    grouped_avp(T,
                'ProSe-Direct-Communication-Transmission-Data-Container',
                Data,
                Opts);
avp(T, Data, 'ProSe-Direct-Discovery-Model', Opts) ->
    avp(T,
        Data,
        'ProSe-Direct-Discovery-Model',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Event-Type', Opts) ->
    avp(T,
        Data,
        'ProSe-Event-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Function-IP-Address', Opts) ->
    avp(T,
        Data,
        'ProSe-Function-IP-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Function-PLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'ProSe-Function-PLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Functionality', Opts) ->
    avp(T,
        Data,
        'ProSe-Functionality',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Group-IP-Multicast-Address',
    Opts) ->
    avp(T,
        Data,
        'ProSe-Group-IP-Multicast-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Information', Opts) ->
    grouped_avp(T, 'ProSe-Information', Data, Opts);
avp(T, Data, 'ProSe-Range-Class', Opts) ->
    avp(T,
        Data,
        'ProSe-Range-Class',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Reason-For-Cancellation', Opts) ->
    avp(T,
        Data,
        'ProSe-Reason-For-Cancellation',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Request-Timestamp', Opts) ->
    avp(T,
        Data,
        'ProSe-Request-Timestamp',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Role-Of-UE', Opts) ->
    avp(T,
        Data,
        'ProSe-Role-Of-UE',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Source-IP-Address', Opts) ->
    avp(T,
        Data,
        'ProSe-Source-IP-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-Target-Layer-2-ID', Opts) ->
    avp(T,
        Data,
        'ProSe-Target-Layer-2-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-UE-ID', Opts) ->
    avp(T,
        Data,
        'ProSe-UE-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'ProSe-UE-to-Network-Relay-UE-ID', Opts) ->
    avp(T,
        Data,
        'ProSe-UE-to-Network-Relay-UE-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Proximity-Alert-Indication', Opts) ->
    avp(T,
        Data,
        'Proximity-Alert-Indication',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Proximity-Alert-Timestamp', Opts) ->
    avp(T,
        Data,
        'Proximity-Alert-Timestamp',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Proximity-Cancellation-Timestamp',
    Opts) ->
    avp(T,
        Data,
        'Proximity-Cancellation-Timestamp',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Quota-Consumption-Time', Opts) ->
    avp(T,
        Data,
        'Quota-Consumption-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Quota-Holding-Time', Opts) ->
    avp(T,
        Data,
        'Quota-Holding-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Quota-Indicator', Opts) ->
    avp(T,
        Data,
        'Quota-Indicator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'RAN-End-Timestamp', Opts) ->
    avp(T,
        Data,
        'RAN-End-Timestamp',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'RAN-Secondary-RAT-Usage-Report', Opts) ->
    grouped_avp(T,
                'RAN-Secondary-RAT-Usage-Report',
                Data,
                Opts);
avp(T, Data, 'RAN-Start-Timestamp', Opts) ->
    avp(T,
        Data,
        'RAN-Start-Timestamp',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Radio-Frequency', Opts) ->
    avp(T,
        Data,
        'Radio-Frequency',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Radio-Parameter-Set-Info', Opts) ->
    grouped_avp(T, 'Radio-Parameter-Set-Info', Data, Opts);
avp(T, Data, 'Radio-Parameter-Set-Values', Opts) ->
    avp(T,
        Data,
        'Radio-Parameter-Set-Values',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Radio-Resources-Indicator', Opts) ->
    avp(T,
        Data,
        'Radio-Resources-Indicator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Rate-Control-Max-Message-Size', Opts) ->
    avp(T,
        Data,
        'Rate-Control-Max-Message-Size',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Rate-Control-Max-Rate', Opts) ->
    avp(T,
        Data,
        'Rate-Control-Max-Rate',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Rate-Control-Time-Unit', Opts) ->
    avp(T,
        Data,
        'Rate-Control-Time-Unit',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Rate-Element', Opts) ->
    grouped_avp(T, 'Rate-Element', Data, Opts);
avp(T, Data, 'Read-Reply-Report-Requested', Opts) ->
    avp(T,
        Data,
        'Read-Reply-Report-Requested',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Real-Time-Tariff-Information', Opts) ->
    grouped_avp(T,
                'Real-Time-Tariff-Information',
                Data,
                Opts);
avp(T, Data, 'Reason-Header', Opts) ->
    avp(T,
        Data,
        'Reason-Header',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Received-Talk-Burst-Time', Opts) ->
    avp(T,
        Data,
        'Received-Talk-Burst-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Received-Talk-Burst-Volume', Opts) ->
    avp(T,
        Data,
        'Received-Talk-Burst-Volume',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Recipient-Address', Opts) ->
    grouped_avp(T, 'Recipient-Address', Data, Opts);
avp(T, Data, 'Recipient-Info', Opts) ->
    grouped_avp(T, 'Recipient-Info', Data, Opts);
avp(T, Data, 'Recipient-Received-Address', Opts) ->
    grouped_avp(T,
                'Recipient-Received-Address',
                Data,
                Opts);
avp(T, Data, 'Recipient-SCCP-Address', Opts) ->
    avp(T,
        Data,
        'Recipient-SCCP-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Refund-Information', Opts) ->
    avp(T,
        Data,
        'Refund-Information',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Related-Change-Condition-Information',
    Opts) ->
    grouped_avp(T,
                'Related-Change-Condition-Information',
                Data,
                Opts);
avp(T, Data, 'Related-IMS-Charging-Identifier', Opts) ->
    avp(T,
        Data,
        'Related-IMS-Charging-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Related-IMS-Charging-Identifier-Node',
    Opts) ->
    avp(T,
        Data,
        'Related-IMS-Charging-Identifier-Node',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Related-Trigger', Opts) ->
    grouped_avp(T, 'Related-Trigger', Data, Opts);
avp(T, Data, 'Relationship-Mode', Opts) ->
    avp(T,
        Data,
        'Relationship-Mode',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Relay-IP-address', Opts) ->
    avp(T,
        Data,
        'Relay-IP-address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Remaining-Balance', Opts) ->
    grouped_avp(T, 'Remaining-Balance', Data, Opts);
avp(T, Data, 'Reply-Applic-ID', Opts) ->
    avp(T,
        Data,
        'Reply-Applic-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Reply-Path-Requested', Opts) ->
    avp(T,
        Data,
        'Reply-Path-Requested',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Reporting-Reason', Opts) ->
    avp(T,
        Data,
        'Reporting-Reason',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Requested-PLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Requested-PLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Requested-Party-Address', Opts) ->
    avp(T,
        Data,
        'Requested-Party-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Requestor-PLMN-Identifier', Opts) ->
    avp(T,
        Data,
        'Requestor-PLMN-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Role-Of-Node', Opts) ->
    avp(T,
        Data,
        'Role-Of-Node',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Role-Of-ProSe-Function', Opts) ->
    avp(T,
        Data,
        'Role-Of-ProSe-Function',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Route-Header-Received', Opts) ->
    avp(T,
        Data,
        'Route-Header-Received',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Route-Header-Transmitted', Opts) ->
    avp(T,
        Data,
        'Route-Header-Transmitted',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SCS-AS-Address', Opts) ->
    grouped_avp(T, 'SCS-AS-Address', Data, Opts);
avp(T, Data, 'SCS-Address', Opts) ->
    avp(T,
        Data,
        'SCS-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SCS-Realm', Opts) ->
    avp(T, Data, 'SCS-Realm', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'SDP-Answer-Timestamp', Opts) ->
    avp(T,
        Data,
        'SDP-Answer-Timestamp',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SDP-Media-Component', Opts) ->
    grouped_avp(T, 'SDP-Media-Component', Data, Opts);
avp(T, Data, 'SDP-Media-Description', Opts) ->
    avp(T,
        Data,
        'SDP-Media-Description',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SDP-Media-Name', Opts) ->
    avp(T,
        Data,
        'SDP-Media-Name',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SDP-Offer-Timestamp', Opts) ->
    avp(T,
        Data,
        'SDP-Offer-Timestamp',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SDP-Session-Description', Opts) ->
    avp(T,
        Data,
        'SDP-Session-Description',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SDP-TimeStamps', Opts) ->
    grouped_avp(T, 'SDP-TimeStamps', Data, Opts);
avp(T, Data, 'SDP-Type', Opts) ->
    avp(T, Data, 'SDP-Type', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'SGSN-Address', Opts) ->
    avp(T,
        Data,
        'SGSN-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SGW-Address', Opts) ->
    avp(T,
        Data,
        'SGW-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SGW-Change', Opts) ->
    avp(T,
        Data,
        'SGW-Change',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SGi-PtP-Tunnelling-Method', Opts) ->
    avp(T,
        Data,
        'SGi-PtP-Tunnelling-Method',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SIP-Method', Opts) ->
    avp(T,
        Data,
        'SIP-Method',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SIP-Request-Timestamp', Opts) ->
    avp(T,
        Data,
        'SIP-Request-Timestamp',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SIP-Request-Timestamp-Fraction', Opts) ->
    avp(T,
        Data,
        'SIP-Request-Timestamp-Fraction',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SIP-Response-Timestamp', Opts) ->
    avp(T,
        Data,
        'SIP-Response-Timestamp',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SIP-Response-Timestamp-Fraction', Opts) ->
    avp(T,
        Data,
        'SIP-Response-Timestamp-Fraction',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SM-Device-Trigger-Indicator', Opts) ->
    avp(T,
        Data,
        'SM-Device-Trigger-Indicator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SM-Device-Trigger-Information', Opts) ->
    grouped_avp(T,
                'SM-Device-Trigger-Information',
                Data,
                Opts);
avp(T, Data, 'SM-Discharge-Time', Opts) ->
    avp(T,
        Data,
        'SM-Discharge-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SM-Message-Type', Opts) ->
    avp(T,
        Data,
        'SM-Message-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SM-Protocol-ID', Opts) ->
    avp(T,
        Data,
        'SM-Protocol-ID',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SM-Sequence-Number', Opts) ->
    avp(T,
        Data,
        'SM-Sequence-Number',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SM-Service-Type', Opts) ->
    avp(T,
        Data,
        'SM-Service-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SM-Status', Opts) ->
    avp(T, Data, 'SM-Status', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'SM-User-Data-Header', Opts) ->
    avp(T,
        Data,
        'SM-User-Data-Header',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SMS-Information', Opts) ->
    grouped_avp(T, 'SMS-Information', Data, Opts);
avp(T, Data, 'SMS-Node', Opts) ->
    avp(T, Data, 'SMS-Node', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'SMS-Result', Opts) ->
    avp(T,
        Data,
        'SMS-Result',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'SMSC-Address', Opts) ->
    avp(T,
        Data,
        'SMSC-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Scale-Factor', Opts) ->
    grouped_avp(T, 'Scale-Factor', Data, Opts);
avp(T, Data, 'Secondary-RAT-Type', Opts) ->
    avp(T,
        Data,
        'Secondary-RAT-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Served-Party-IP-Address', Opts) ->
    avp(T,
        Data,
        'Served-Party-IP-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Service-Data-Container', Opts) ->
    grouped_avp(T, 'Service-Data-Container', Data, Opts);
avp(T, Data, 'Service-Id', Opts) ->
    avp(T,
        Data,
        'Service-Id',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Service-Mode', Opts) ->
    avp(T,
        Data,
        'Service-Mode',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Service-Specific-Data', Opts) ->
    avp(T,
        Data,
        'Service-Specific-Data',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Service-Specific-Info', Opts) ->
    grouped_avp(T, 'Service-Specific-Info', Data, Opts);
avp(T, Data, 'Service-Specific-Type', Opts) ->
    avp(T,
        Data,
        'Service-Specific-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Serving-Node-Identity', Opts) ->
    avp(T,
        Data,
        'Serving-Node-Identity',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Serving-Node-Type', Opts) ->
    avp(T,
        Data,
        'Serving-Node-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Session-Direction', Opts) ->
    avp(T,
        Data,
        'Session-Direction',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Start-Time', Opts) ->
    avp(T,
        Data,
        'Start-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Start-of-Charging', Opts) ->
    avp(T,
        Data,
        'Start-of-Charging',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Status-AS-Code', Opts) ->
    avp(T,
        Data,
        'Status-AS-Code',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Stop-Time', Opts) ->
    avp(T, Data, 'Stop-Time', Opts, diameter_3gpp_ts32_299);
avp(T, Data, 'Submission-Time', Opts) ->
    avp(T,
        Data,
        'Submission-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Subscriber-Role', Opts) ->
    avp(T,
        Data,
        'Subscriber-Role',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Supplementary-Service', Opts) ->
    grouped_avp(T, 'Supplementary-Service', Data, Opts);
avp(T, Data, 'TAD-Identifier', Opts) ->
    avp(T,
        Data,
        'TAD-Identifier',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'TWAG-Address', Opts) ->
    avp(T,
        Data,
        'TWAG-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'TWAN-User-Location-Info', Opts) ->
    grouped_avp(T, 'TWAN-User-Location-Info', Data, Opts);
avp(T, Data, 'Talk-Burst-Exchange', Opts) ->
    grouped_avp(T, 'Talk-Burst-Exchange', Data, Opts);
avp(T, Data, 'Talk-Burst-Time', Opts) ->
    avp(T,
        Data,
        'Talk-Burst-Time',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Talk-Burst-Volume', Opts) ->
    avp(T,
        Data,
        'Talk-Burst-Volume',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Target-IP-Address', Opts) ->
    avp(T,
        Data,
        'Target-IP-Address',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Tariff-Information', Opts) ->
    grouped_avp(T, 'Tariff-Information', Data, Opts);
avp(T, Data, 'Tariff-XML', Opts) ->
    avp(T,
        Data,
        'Tariff-XML',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Teleservice', Opts) ->
    avp(T,
        Data,
        'Teleservice',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Terminating-IOI', Opts) ->
    avp(T,
        Data,
        'Terminating-IOI',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Time-First-Reception', Opts) ->
    avp(T,
        Data,
        'Time-First-Reception',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Time-First-Transmission', Opts) ->
    avp(T,
        Data,
        'Time-First-Transmission',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Time-First-Usage', Opts) ->
    avp(T,
        Data,
        'Time-First-Usage',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Time-Indicator', Opts) ->
    avp(T,
        Data,
        'Time-Indicator',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Time-Last-Usage', Opts) ->
    avp(T,
        Data,
        'Time-Last-Usage',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Time-Quota-Mechanism', Opts) ->
    grouped_avp(T, 'Time-Quota-Mechanism', Data, Opts);
avp(T, Data, 'Time-Quota-Threshold', Opts) ->
    avp(T,
        Data,
        'Time-Quota-Threshold',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Time-Quota-Type', Opts) ->
    avp(T,
        Data,
        'Time-Quota-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Time-Stamps', Opts) ->
    grouped_avp(T, 'Time-Stamps', Data, Opts);
avp(T, Data, 'Time-Usage', Opts) ->
    avp(T,
        Data,
        'Time-Usage',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Token-Text', Opts) ->
    avp(T,
        Data,
        'Token-Text',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Traffic-Data-Volumes', Opts) ->
    grouped_avp(T, 'Traffic-Data-Volumes', Data, Opts);
avp(T, Data, 'Transcoder-Inserted-Indication', Opts) ->
    avp(T,
        Data,
        'Transcoder-Inserted-Indication',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Transit-IOI-List', Opts) ->
    avp(T,
        Data,
        'Transit-IOI-List',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Transmitter-Info', Opts) ->
    grouped_avp(T, 'Transmitter-Info', Data, Opts);
avp(T, Data, 'Trigger', Opts) ->
    grouped_avp(T, 'Trigger', Data, Opts);
avp(T, Data, 'Trigger-Type', Opts) ->
    avp(T,
        Data,
        'Trigger-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Trunk-Group-Id', Opts) ->
    grouped_avp(T, 'Trunk-Group-Id', Data, Opts);
avp(T, Data, 'Type-Number', Opts) ->
    avp(T,
        Data,
        'Type-Number',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'UNI-PDU-CP-Only-Flag', Opts) ->
    avp(T,
        Data,
        'UNI-PDU-CP-Only-Flag',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'UWAN-User-Location-Info', Opts) ->
    grouped_avp(T, 'UWAN-User-Location-Info', Data, Opts);
avp(T, Data, 'Unit-Cost', Opts) ->
    grouped_avp(T, 'Unit-Cost', Data, Opts);
avp(T, Data, 'Unit-Quota-Threshold', Opts) ->
    avp(T,
        Data,
        'Unit-Quota-Threshold',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Unused-Quota-Timer', Opts) ->
    avp(T,
        Data,
        'Unused-Quota-Timer',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Usage-Information-Report-Sequence-Number',
    Opts) ->
    avp(T,
        Data,
        'Usage-Information-Report-Sequence-Number',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'User-CSG-Information', Opts) ->
    grouped_avp(T, 'User-CSG-Information', Data, Opts);
avp(T, Data, 'User-Participating-Type', Opts) ->
    avp(T,
        Data,
        'User-Participating-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'User-Session-Id', Opts) ->
    avp(T,
        Data,
        'User-Session-Id',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'VCS-Information', Opts) ->
    grouped_avp(T, 'VCS-Information', Data, Opts);
avp(T, Data, 'VLR-Number', Opts) ->
    avp(T,
        Data,
        'VLR-Number',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Variable-Part', Opts) ->
    grouped_avp(T, 'Variable-Part', Data, Opts);
avp(T, Data, 'Variable-Part-Order', Opts) ->
    avp(T,
        Data,
        'Variable-Part-Order',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Variable-Part-Type', Opts) ->
    avp(T,
        Data,
        'Variable-Part-Type',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Variable-Part-Value', Opts) ->
    avp(T,
        Data,
        'Variable-Part-Value',
        Opts,
        diameter_3gpp_ts32_299);
avp(T, Data, 'Volume-Quota-Threshold', Opts) ->
    avp(T,
        Data,
        'Volume-Quota-Threshold',
        Opts,
        diameter_3gpp_ts32_299);
avp(_, _, _, _) -> erlang:error(badarg).

enumerated_avp(_, _, _) -> erlang:error(badarg).

empty_value('TP-Previous-PS-Information', Opts) ->
    empty_group('TP-Previous-PS-Information', Opts);
empty_value('Access-Network-Charging-Identifier-Gx',
            Opts) ->
    empty_group('Access-Network-Charging-Identifier-Gx',
                Opts);
empty_value('Allocation-Retention-Priority', Opts) ->
    empty_group('Allocation-Retention-Priority', Opts);
empty_value('Application-Detection-Information',
            Opts) ->
    empty_group('Application-Detection-Information', Opts);
empty_value('Charging-Rule-Definition', Opts) ->
    empty_group('Charging-Rule-Definition', Opts);
empty_value('Charging-Rule-Install', Opts) ->
    empty_group('Charging-Rule-Install', Opts);
empty_value('Charging-Rule-Remove', Opts) ->
    empty_group('Charging-Rule-Remove', Opts);
empty_value('Charging-Rule-Report', Opts) ->
    empty_group('Charging-Rule-Report', Opts);
empty_value('CoA-Information', Opts) ->
    empty_group('CoA-Information', Opts);
empty_value('Conditional-APN-Aggregate-Max-Bitrate',
            Opts) ->
    empty_group('Conditional-APN-Aggregate-Max-Bitrate',
                Opts);
empty_value('Default-EPS-Bearer-QoS', Opts) ->
    empty_group('Default-EPS-Bearer-QoS', Opts);
empty_value('Default-QoS-Information', Opts) ->
    empty_group('Default-QoS-Information', Opts);
empty_value('Event-Report-Indication', Opts) ->
    empty_group('Event-Report-Indication', Opts);
empty_value('Fixed-User-Location-Info', Opts) ->
    empty_group('Fixed-User-Location-Info', Opts);
empty_value('Flow-Information', Opts) ->
    empty_group('Flow-Information', Opts);
empty_value('Packet-Filter-Information', Opts) ->
    empty_group('Packet-Filter-Information', Opts);
empty_value('Presence-Reporting-Area-Information',
            Opts) ->
    empty_group('Presence-Reporting-Area-Information',
                Opts);
empty_value('QoS-Information', Opts) ->
    empty_group('QoS-Information', Opts);
empty_value('Redirect-Information', Opts) ->
    empty_group('Redirect-Information', Opts);
empty_value('Routing-Filter', Opts) ->
    empty_group('Routing-Filter', Opts);
empty_value('Routing-Rule-Definition', Opts) ->
    empty_group('Routing-Rule-Definition', Opts);
empty_value('Routing-Rule-Install', Opts) ->
    empty_group('Routing-Rule-Install', Opts);
empty_value('Routing-Rule-Remove', Opts) ->
    empty_group('Routing-Rule-Remove', Opts);
empty_value('TDF-Information', Opts) ->
    empty_group('TDF-Information', Opts);
empty_value('Tunnel-Information', Opts) ->
    empty_group('Tunnel-Information', Opts);
empty_value('TFT-Packet-Filter-Information', Opts) ->
    empty_group('TFT-Packet-Filter-Information', Opts);
empty_value('Usage-Monitoring-Information', Opts) ->
    empty_group('Usage-Monitoring-Information', Opts);
empty_value('Access-Network-Info-Change', Opts) ->
    empty_group('Access-Network-Info-Change', Opts);
empty_value('Access-Transfer-Information', Opts) ->
    empty_group('Access-Transfer-Information', Opts);
empty_value('Accumulated-Cost', Opts) ->
    empty_group('Accumulated-Cost', Opts);
empty_value('Additional-Content-Information', Opts) ->
    empty_group('Additional-Content-Information', Opts);
empty_value('Address-Domain', Opts) ->
    empty_group('Address-Domain', Opts);
empty_value('AF-Correlation-Information', Opts) ->
    empty_group('AF-Correlation-Information', Opts);
empty_value('Announcement-Information', Opts) ->
    empty_group('Announcement-Information', Opts);
empty_value('AoC-Cost-Information', Opts) ->
    empty_group('AoC-Cost-Information', Opts);
empty_value('AoC-Information', Opts) ->
    empty_group('AoC-Information', Opts);
empty_value('AoC-Service', Opts) ->
    empty_group('AoC-Service', Opts);
empty_value('AoC-Subscription-Information', Opts) ->
    empty_group('AoC-Subscription-Information', Opts);
empty_value('APN-Rate-Control', Opts) ->
    empty_group('APN-Rate-Control', Opts);
empty_value('APN-Rate-Control-Downlink', Opts) ->
    empty_group('APN-Rate-Control-Downlink', Opts);
empty_value('APN-Rate-Control-Uplink', Opts) ->
    empty_group('APN-Rate-Control-Uplink', Opts);
empty_value('Application-Server-Information', Opts) ->
    empty_group('Application-Server-Information', Opts);
empty_value('Basic-Service-Code', Opts) ->
    empty_group('Basic-Service-Code', Opts);
empty_value('Called-Identity-Change', Opts) ->
    empty_group('Called-Identity-Change', Opts);
empty_value('Coverage-Info', Opts) ->
    empty_group('Coverage-Info', Opts);
empty_value('CPDT-Information', Opts) ->
    empty_group('CPDT-Information', Opts);
empty_value('Current-Tariff', Opts) ->
    empty_group('Current-Tariff', Opts);
empty_value('Destination-Interface', Opts) ->
    empty_group('Destination-Interface', Opts);
empty_value('Early-Media-Description', Opts) ->
    empty_group('Early-Media-Description', Opts);
empty_value('Enhanced-Diagnostics', Opts) ->
    empty_group('Enhanced-Diagnostics', Opts);
empty_value('Envelope', Opts) ->
    empty_group('Envelope', Opts);
empty_value('Event-Type', Opts) ->
    empty_group('Event-Type', Opts);
empty_value('Incremental-Cost', Opts) ->
    empty_group('Incremental-Cost', Opts);
empty_value('IMS-Information', Opts) ->
    empty_group('IMS-Information', Opts);
empty_value('Inter-Operator-Identifier', Opts) ->
    empty_group('Inter-Operator-Identifier', Opts);
empty_value('ISUP-Cause', Opts) ->
    empty_group('ISUP-Cause', Opts);
empty_value('LCS-Client-ID', Opts) ->
    empty_group('LCS-Client-ID', Opts);
empty_value('LCS-Client-Name', Opts) ->
    empty_group('LCS-Client-Name', Opts);
empty_value('LCS-Information', Opts) ->
    empty_group('LCS-Information', Opts);
empty_value('LCS-Requestor-ID', Opts) ->
    empty_group('LCS-Requestor-ID', Opts);
empty_value('Location-Info', Opts) ->
    empty_group('Location-Info', Opts);
empty_value('Location-Type', Opts) ->
    empty_group('Location-Type', Opts);
empty_value('MBMS-Information', Opts) ->
    empty_group('MBMS-Information', Opts);
empty_value('Message-Body', Opts) ->
    empty_group('Message-Body', Opts);
empty_value('Message-Class', Opts) ->
    empty_group('Message-Class', Opts);
empty_value('MM-Content-Type', Opts) ->
    empty_group('MM-Content-Type', Opts);
empty_value('MMS-Information', Opts) ->
    empty_group('MMS-Information', Opts);
empty_value('MMTel-Information', Opts) ->
    empty_group('MMTel-Information', Opts);
empty_value('Monitoring-Event-Information', Opts) ->
    empty_group('Monitoring-Event-Information', Opts);
empty_value('Monitoring-Event-Report-Data', Opts) ->
    empty_group('Monitoring-Event-Report-Data', Opts);
empty_value('Next-Tariff', Opts) ->
    empty_group('Next-Tariff', Opts);
empty_value('NIDD-Submission', Opts) ->
    empty_group('NIDD-Submission', Opts);
empty_value('NNI-Information', Opts) ->
    empty_group('NNI-Information', Opts);
empty_value('Offline-Charging', Opts) ->
    empty_group('Offline-Charging', Opts);
empty_value('Originator-Address', Opts) ->
    empty_group('Originator-Address', Opts);
empty_value('Originator-Interface', Opts) ->
    empty_group('Originator-Interface', Opts);
empty_value('Originator-Received-Address', Opts) ->
    empty_group('Originator-Received-Address', Opts);
empty_value('Participant-Group', Opts) ->
    empty_group('Participant-Group', Opts);
empty_value('PoC-Information', Opts) ->
    empty_group('PoC-Information', Opts);
empty_value('PoC-User-Role', Opts) ->
    empty_group('PoC-User-Role', Opts);
empty_value('ProSe-Direct-Communication-Reception-Data-Container',
            Opts) ->
    empty_group('ProSe-Direct-Communication-Reception-Data-Container',
                Opts);
empty_value('ProSe-Direct-Communication-Transmission-Data-Container',
            Opts) ->
    empty_group('ProSe-Direct-Communication-Transmission-Data-Container',
                Opts);
empty_value('ProSe-Information', Opts) ->
    empty_group('ProSe-Information', Opts);
empty_value('PS-Furnish-Charging-Information', Opts) ->
    empty_group('PS-Furnish-Charging-Information', Opts);
empty_value('PS-Information', Opts) ->
    empty_group('PS-Information', Opts);
empty_value('Radio-Parameter-Set-Info', Opts) ->
    empty_group('Radio-Parameter-Set-Info', Opts);
empty_value('RAN-Secondary-RAT-Usage-Report', Opts) ->
    empty_group('RAN-Secondary-RAT-Usage-Report', Opts);
empty_value('Rate-Element', Opts) ->
    empty_group('Rate-Element', Opts);
empty_value('Real-Time-Tariff-Information', Opts) ->
    empty_group('Real-Time-Tariff-Information', Opts);
empty_value('Recipient-Address', Opts) ->
    empty_group('Recipient-Address', Opts);
empty_value('Recipient-Info', Opts) ->
    empty_group('Recipient-Info', Opts);
empty_value('Recipient-Received-Address', Opts) ->
    empty_group('Recipient-Received-Address', Opts);
empty_value('Related-Change-Condition-Information',
            Opts) ->
    empty_group('Related-Change-Condition-Information',
                Opts);
empty_value('Related-Trigger', Opts) ->
    empty_group('Related-Trigger', Opts);
empty_value('Remaining-Balance', Opts) ->
    empty_group('Remaining-Balance', Opts);
empty_value('Scale-Factor', Opts) ->
    empty_group('Scale-Factor', Opts);
empty_value('SCS-AS-Address', Opts) ->
    empty_group('SCS-AS-Address', Opts);
empty_value('SDP-Media-Component', Opts) ->
    empty_group('SDP-Media-Component', Opts);
empty_value('SDP-TimeStamps', Opts) ->
    empty_group('SDP-TimeStamps', Opts);
empty_value('Service-Data-Container', Opts) ->
    empty_group('Service-Data-Container', Opts);
empty_value('Service-Specific-Info', Opts) ->
    empty_group('Service-Specific-Info', Opts);
empty_value('SM-Device-Trigger-Information', Opts) ->
    empty_group('SM-Device-Trigger-Information', Opts);
empty_value('SMS-Information', Opts) ->
    empty_group('SMS-Information', Opts);
empty_value('Supplementary-Service', Opts) ->
    empty_group('Supplementary-Service', Opts);
empty_value('Talk-Burst-Exchange', Opts) ->
    empty_group('Talk-Burst-Exchange', Opts);
empty_value('Tariff-Information', Opts) ->
    empty_group('Tariff-Information', Opts);
empty_value('Time-Quota-Mechanism', Opts) ->
    empty_group('Time-Quota-Mechanism', Opts);
empty_value('Time-Stamps', Opts) ->
    empty_group('Time-Stamps', Opts);
empty_value('Traffic-Data-Volumes', Opts) ->
    empty_group('Traffic-Data-Volumes', Opts);
empty_value('Transmitter-Info', Opts) ->
    empty_group('Transmitter-Info', Opts);
empty_value('Trigger', Opts) ->
    empty_group('Trigger', Opts);
empty_value('Trunk-Group-Id', Opts) ->
    empty_group('Trunk-Group-Id', Opts);
empty_value('TWAN-User-Location-Info', Opts) ->
    empty_group('TWAN-User-Location-Info', Opts);
empty_value('Unit-Cost', Opts) ->
    empty_group('Unit-Cost', Opts);
empty_value('User-CSG-Information', Opts) ->
    empty_group('User-CSG-Information', Opts);
empty_value('UWAN-User-Location-Info', Opts) ->
    empty_group('UWAN-User-Location-Info', Opts);
empty_value('Variable-Part', Opts) ->
    empty_group('Variable-Part', Opts);
empty_value('VCS-Information', Opts) ->
    empty_group('VCS-Information', Opts);
empty_value('3GPP-PDP-Type', _) -> <<0, 0, 0, 0>>;
empty_value('AN-GW-Status', _) -> <<0, 0, 0, 0>>;
empty_value('Bearer-Control-Mode', _) -> <<0, 0, 0, 0>>;
empty_value('Bearer-Operation', _) -> <<0, 0, 0, 0>>;
empty_value('Bearer-Usage', _) -> <<0, 0, 0, 0>>;
empty_value('Charging-Correlation-Indicator', _) ->
    <<0, 0, 0, 0>>;
empty_value('CSG-Information-Reporting', _) ->
    <<0, 0, 0, 0>>;
empty_value('Event-Trigger', _) -> <<0, 0, 0, 0>>;
empty_value('Flow-Direction', _) -> <<0, 0, 0, 0>>;
empty_value('IP-CAN-Session-Charging-Scope', _) ->
    <<0, 0, 0, 0>>;
empty_value('IP-CAN-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Metering-Method', _) -> <<0, 0, 0, 0>>;
empty_value('Mute-Notification', _) -> <<0, 0, 0, 0>>;
empty_value('Network-Request-Support', _) ->
    <<0, 0, 0, 0>>;
empty_value('Offline', _) -> <<0, 0, 0, 0>>;
empty_value('Online', _) -> <<0, 0, 0, 0>>;
empty_value('Packet-Filter-Operation', _) ->
    <<0, 0, 0, 0>>;
empty_value('Packet-Filter-Usage', _) -> <<0, 0, 0, 0>>;
empty_value('PCC-Rule-Status', _) -> <<0, 0, 0, 0>>;
empty_value('Pre-emption-Capability', _) ->
    <<0, 0, 0, 0>>;
empty_value('Pre-emption-Vulnerability', _) ->
    <<0, 0, 0, 0>>;
empty_value('PS-to-CS-Session-Continuity', _) ->
    <<0, 0, 0, 0>>;
empty_value('QoS-Negotiation', _) -> <<0, 0, 0, 0>>;
empty_value('QoS-Upgrade', _) -> <<0, 0, 0, 0>>;
empty_value('RAT-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Redirect-Support', _) -> <<0, 0, 0, 0>>;
empty_value('Reporting-Level', _) -> <<0, 0, 0, 0>>;
empty_value('Resource-Allocation-Notification', _) ->
    <<0, 0, 0, 0>>;
empty_value('Rule-Failure-Code', _) -> <<0, 0, 0, 0>>;
empty_value('Session-Release-Cause', _) ->
    <<0, 0, 0, 0>>;
empty_value('Usage-Monitoring-Level', _) ->
    <<0, 0, 0, 0>>;
empty_value('Usage-Monitoring-Report', _) ->
    <<0, 0, 0, 0>>;
empty_value('Usage-Monitoring-Support', _) ->
    <<0, 0, 0, 0>>;
empty_value('3GPP-PS-Data-Off-Status', _) ->
    <<0, 0, 0, 0>>;
empty_value('Access-Transfer-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('Adaptations', _) -> <<0, 0, 0, 0>>;
empty_value('Additional-Exception-Reports', _) ->
    <<0, 0, 0, 0>>;
empty_value('Address-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Addressee-Type', _) -> <<0, 0, 0, 0>>;
empty_value('AoC-Format', _) -> <<0, 0, 0, 0>>;
empty_value('AoC-Request-Type', _) -> <<0, 0, 0, 0>>;
empty_value('AoC-Service-Obligatory-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('AoC-Service-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Charge-Reason-Code', _) -> <<0, 0, 0, 0>>;
empty_value('Charging-Characteristics-Selection-Mode',
            _) ->
    <<0, 0, 0, 0>>;
empty_value('Charging-Per-IP-CAN-Session-Indicator',
            _) ->
    <<0, 0, 0, 0>>;
empty_value('Class-Identifier', _) -> <<0, 0, 0, 0>>;
empty_value('CN-Operator-Selection-Entity', _) ->
    <<0, 0, 0, 0>>;
empty_value('Content-Class', _) -> <<0, 0, 0, 0>>;
empty_value('Coverage-Status', _) -> <<0, 0, 0, 0>>;
empty_value('CP-CIoT-EPS-Optimisation-Indicator', _) ->
    <<0, 0, 0, 0>>;
empty_value('CSG-Access-Mode', _) -> <<0, 0, 0, 0>>;
empty_value('CSG-Membership-Indication', _) ->
    <<0, 0, 0, 0>>;
empty_value('Delivery-Report-Requested', _) ->
    <<0, 0, 0, 0>>;
empty_value('DRM-Content', _) -> <<0, 0, 0, 0>>;
empty_value('Dynamic-Address-Flag', _) ->
    <<0, 0, 0, 0>>;
empty_value('Dynamic-Address-Flag-Extension', _) ->
    <<0, 0, 0, 0>>;
empty_value('Envelope-Reporting', _) -> <<0, 0, 0, 0>>;
empty_value('File-Repair-Supported', _) ->
    <<0, 0, 0, 0>>;
empty_value('Forwarding-Pending', _) -> <<0, 0, 0, 0>>;
empty_value('Interface-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Inter-UE-Transfer', _) -> <<0, 0, 0, 0>>;
empty_value('IMS-Emergency-Indicator', _) ->
    <<0, 0, 0, 0>>;
empty_value('IMSI-Unauthenticated-Flag', _) ->
    <<0, 0, 0, 0>>;
empty_value('IP-Realm-Default-Indication', _) ->
    <<0, 0, 0, 0>>;
empty_value('LCS-Client-Type', _) -> <<0, 0, 0, 0>>;
empty_value('LCS-Format-Indicator', _) ->
    <<0, 0, 0, 0>>;
empty_value('Local-GW-Inserted-Indication', _) ->
    <<0, 0, 0, 0>>;
empty_value('Location-Estimate-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('Low-Balance-Indication', _) ->
    <<0, 0, 0, 0>>;
empty_value('Low-Priority-Indicator', _) ->
    <<0, 0, 0, 0>>;
empty_value('MBMS-Charged-Party', _) -> <<0, 0, 0, 0>>;
empty_value('MBMS-User-Service-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('Media-Initiator-Flag', _) ->
    <<0, 0, 0, 0>>;
empty_value('Message-Type', _) -> <<0, 0, 0, 0>>;
empty_value('MMBox-Storage-Requested', _) ->
    <<0, 0, 0, 0>>;
empty_value('NNI-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Node-Functionality', _) -> <<0, 0, 0, 0>>;
empty_value('Online-Charging-Flag', _) ->
    <<0, 0, 0, 0>>;
empty_value('Originator', _) -> <<0, 0, 0, 0>>;
empty_value('Participant-Access-Priority', _) ->
    <<0, 0, 0, 0>>;
empty_value('Participant-Action-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('PC5-Radio-Technology', _) ->
    <<0, 0, 0, 0>>;
empty_value('PDP-Context-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Play-Alternative', _) -> <<0, 0, 0, 0>>;
empty_value('PoC-Change-Condition', _) ->
    <<0, 0, 0, 0>>;
empty_value('PoC-Event-Type', _) -> <<0, 0, 0, 0>>;
empty_value('PoC-Server-Role', _) -> <<0, 0, 0, 0>>;
empty_value('PoC-Session-Initiation-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('PoC-Session-Type', _) -> <<0, 0, 0, 0>>;
empty_value('PoC-User-Role-Info-Units', _) ->
    <<0, 0, 0, 0>>;
empty_value('Priority', _) -> <<0, 0, 0, 0>>;
empty_value('Privacy-Indicator', _) -> <<0, 0, 0, 0>>;
empty_value('ProSe-Direct-Discovery-Model', _) ->
    <<0, 0, 0, 0>>;
empty_value('ProSe-Event-Type', _) -> <<0, 0, 0, 0>>;
empty_value('ProSe-Functionality', _) -> <<0, 0, 0, 0>>;
empty_value('ProSe-Range-Class', _) -> <<0, 0, 0, 0>>;
empty_value('ProSe-Reason-For-Cancellation', _) ->
    <<0, 0, 0, 0>>;
empty_value('ProSe-Role-Of-UE', _) -> <<0, 0, 0, 0>>;
empty_value('Proximity-Alert-Indication', _) ->
    <<0, 0, 0, 0>>;
empty_value('PS-Append-Free-Format-Data', _) ->
    <<0, 0, 0, 0>>;
empty_value('Quota-Indicator', _) -> <<0, 0, 0, 0>>;
empty_value('Read-Reply-Report-Requested', _) ->
    <<0, 0, 0, 0>>;
empty_value('Relationship-Mode', _) -> <<0, 0, 0, 0>>;
empty_value('Reply-Path-Requested', _) ->
    <<0, 0, 0, 0>>;
empty_value('Reporting-Reason', _) -> <<0, 0, 0, 0>>;
empty_value('Role-Of-Node', _) -> <<0, 0, 0, 0>>;
empty_value('Role-Of-ProSe-Function', _) ->
    <<0, 0, 0, 0>>;
empty_value('SDP-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Session-Direction', _) -> <<0, 0, 0, 0>>;
empty_value('Serving-Node-Type', _) -> <<0, 0, 0, 0>>;
empty_value('SGi-PtP-Tunnelling-Method', _) ->
    <<0, 0, 0, 0>>;
empty_value('SGW-Change', _) -> <<0, 0, 0, 0>>;
empty_value('SM-Device-Trigger-Indicator', _) ->
    <<0, 0, 0, 0>>;
empty_value('SM-Message-Type', _) -> <<0, 0, 0, 0>>;
empty_value('SMS-Node', _) -> <<0, 0, 0, 0>>;
empty_value('SM-Service-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Status-AS-Code', _) -> <<0, 0, 0, 0>>;
empty_value('Subscriber-Role', _) -> <<0, 0, 0, 0>>;
empty_value('TAD-Identifier', _) -> <<0, 0, 0, 0>>;
empty_value('Time-Quota-Type', _) -> <<0, 0, 0, 0>>;
empty_value('Transcoder-Inserted-Indication', _) ->
    <<0, 0, 0, 0>>;
empty_value('Trigger-Type', _) -> <<0, 0, 0, 0>>;
empty_value('UNI-PDU-CP-Only-Flag', _) ->
    <<0, 0, 0, 0>>;
empty_value('User-Participating-Type', _) ->
    <<0, 0, 0, 0>>;
empty_value('Variable-Part-Type', _) -> <<0, 0, 0, 0>>;
empty_value(Name, Opts) -> empty(Name, Opts).

dict() ->
    [1,
     {avp_types,
      [{"TP-NAT-IP-Address", 16, "OctetString", "V"},
       {"TP-NAT-Pool-Id", 27, "UTF8String", "V"},
       {"TP-NAT-Port-End", 29, "Unsigned32", "V"},
       {"TP-NAT-Port-Start", 28, "Unsigned32", "V"},
       {"TP-Previous-PS-Information", 64, "Grouped", "V"}]},
     {avp_vendor_id, []},
     {codecs, []},
     {command_codes, []},
     {custom_types, []},
     {define, []},
     {enum, []},
     {grouped,
      [{"TP-Previous-PS-Information",
        64,
        [],
        [["QoS-Information"],
         {'*', ["SGSN-Address"]},
         ["3GPP-SGSN-MCC-MNC"],
         ["3GPP-MS-TimeZone"],
         ["3GPP-User-Location-Info"],
         ["3GPP-RAT-Type"],
         {'*', ["AVP"]}]}]},
     {id, 1},
     {import_avps,
      [{diameter_3gpp_base,
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
       {diameter_3gpp_ts29_212,
        [{"AN-GW-Address", 1050, "Address", "V"},
         {"AN-GW-Status", 2811, "Enumerated", "V"},
         {"APN-Aggregate-Max-Bitrate-DL",
          1040,
          "Unsigned32",
          "V"},
         {"APN-Aggregate-Max-Bitrate-UL",
          1041,
          "Unsigned32",
          "V"},
         {"Access-Network-Charging-Identifier-Gx",
          1022,
          "Grouped",
          "MV"},
         {"Allocation-Retention-Priority", 1034, "Grouped", "V"},
         {"Application-Detection-Information",
          1098,
          "Grouped",
          "V"},
         {"Bearer-Control-Mode", 1023, "Enumerated", "MV"},
         {"Bearer-Identifier", 1020, "OctetString", "MV"},
         {"Bearer-Operation", 1021, "Enumerated", "MV"},
         {"Bearer-Usage", 1000, "Enumerated", "MV"},
         {"CSG-Information-Reporting", 1071, "Enumerated", "V"},
         {"Charging-Correlation-Indicator",
          1073,
          "Enumerated",
          "V"},
         {"Charging-Rule-Base-Name", 1004, "UTF8String", "MV"},
         {"Charging-Rule-Definition", 1003, "Grouped", "MV"},
         {"Charging-Rule-Install", 1001, "Grouped", "MV"},
         {"Charging-Rule-Name", 1005, "OctetString", "MV"},
         {"Charging-Rule-Remove", 1002, "Grouped", "MV"},
         {"Charging-Rule-Report", 1018, "Grouped", "MV"},
         {"CoA-IP-Address", 1035, "Address", "V"},
         {"CoA-Information", 1039, "Grouped", "V"},
         {"Conditional-APN-Aggregate-Max-Bitrate",
          2818,
          "Grouped",
          "V"},
         {"Credit-Management-Status", 1082, "Unsigned32", "V"},
         {"Default-EPS-Bearer-QoS", 1049, "Grouped", "V"},
         {"Default-QoS-Information", 2816, "Grouped", "V"},
         {"Default-QoS-Name", 2817, "UTF8String", "V"},
         {"Event-Report-Indication", 1033, "Grouped", "V"},
         {"Event-Trigger", 1006, "Enumerated", "MV"},
         {"Fixed-User-Location-Info", 2825, "Grouped", "V"},
         {"Flow-Direction", 1080, "Enumerated", "V"},
         {"Flow-Information", 1058, "Grouped", "V"},
         {"Flow-Label", 1057, "OctetString", "V"},
         {"Guaranteed-Bitrate-DL", 1025, "Unsigned32", "MV"},
         {"Guaranteed-Bitrate-UL", 1026, "Unsigned32", "MV"},
         {"HeNB-Local-IP-Address", 2804, "Address", "V"},
         {"IP-CAN-Session-Charging-Scope",
          2827,
          "Enumerated",
          "V"},
         {"IP-CAN-Type", 1027, "Enumerated", "MV"},
         {"Metering-Method", 1007, "Enumerated", "MV"},
         {"Monitoring-Key", 1066, "OctetString", "V"},
         {"Monitoring-Time", 2810, "Time", "V"},
         {"Mute-Notification", 2809, "Enumerated", "V"},
         {"NetLoc-Access-Support", 2824, "Unsigned32", "V"},
         {"Network-Request-Support", 1024, "Enumerated", "MV"},
         {"Offline", 1008, "Enumerated", "MV"},
         {"Online", 1009, "Enumerated", "MV"},
         {"PCC-Rule-Status", 1019, "Enumerated", "MV"},
         {"PCSCF-Restoration-Indication",
          2826,
          "Unsigned32",
          "V"},
         {"PDN-Connection-ID", 1065, "OctetString", "V"},
         {"PS-to-CS-Session-Continuity",
          1099,
          "Enumerated",
          "V"},
         {"Packet-Filter-Content", 1059, "IPFilterRule", "V"},
         {"Packet-Filter-Identifier", 1060, "OctetString", "V"},
         {"Packet-Filter-Information", 1061, "Grouped", "V"},
         {"Packet-Filter-Operation", 1062, "Enumerated", "V"},
         {"Packet-Filter-Usage", 1072, "Enumerated", "V"},
         {"Pre-emption-Capability", 1047, "Enumerated", "V"},
         {"Pre-emption-Vulnerability", 1048, "Enumerated", "V"},
         {"Precedence", 1010, "Unsigned32", "MV"},
         {"Presence-Reporting-Area-Elements-List",
          2820,
          "OctetString",
          "V"},
         {"Presence-Reporting-Area-Identifier",
          2821,
          "OctetString",
          "V"},
         {"Presence-Reporting-Area-Information",
          2822,
          "Grouped",
          "V"},
         {"Presence-Reporting-Area-Status",
          2823,
          "Unsigned32",
          "V"},
         {"Priority-Level", 1046, "Unsigned32", "V"},
         {"QoS-Class-Identifier", 1028, "Unsigned32", "MV"},
         {"QoS-Information", 1016, "Grouped", "MV"},
         {"QoS-Negotiation", 1029, "Enumerated", "MV"},
         {"QoS-Upgrade", 1030, "Enumerated", "MV"},
         {"RAN-NAS-Release-Cause", 2819, "OctetString", "V"},
         {"RAT-Type", 1032, "Enumerated", "V"},
         {"Redirect-Information", 1085, "Grouped", "V"},
         {"Redirect-Support", 1086, "Enumerated", "V"},
         {"Reporting-Level", 1011, "Enumerated", "MV"},
         {"Resource-Allocation-Notification",
          1063,
          "Enumerated",
          "V"},
         {"Revalidation-Time", 1042, "Time", "MV"},
         {"Routing-Filter", 1078, "Grouped", "V"},
         {"Routing-IP-Address", 1079, "Address", "V"},
         {"Routing-Rule-Definition", 1076, "Grouped", "V"},
         {"Routing-Rule-Identifier", 1077, "OctetString", "V"},
         {"Routing-Rule-Install", 1081, "Grouped", "V"},
         {"Routing-Rule-Remove", 1075, "Grouped", "V"},
         {"Rule-Activation-Time", 1043, "Time", "MV"},
         {"Rule-Deactivation-Time", 1044, "Time", "MV"},
         {"Rule-Failure-Code", 1031, "Enumerated", "MV"},
         {"Security-Parameter-Index", 1056, "OctetString", "V"},
         {"Session-Release-Cause", 1045, "Enumerated", "MV"},
         {"TDF-Application-Identifier",
          1088,
          "OctetString",
          "V"},
         {"TDF-Application-Instance-Identifier",
          2802,
          "OctetString",
          "V"},
         {"TDF-Destination-Host", 1089, "DiameterIdentity", "V"},
         {"TDF-Destination-Realm",
          1090,
          "DiameterIdentity",
          "V"},
         {"TDF-IP-Address", 1091, "Address", "V"},
         {"TDF-Information", 1087, "Grouped", "V"},
         {"TFT-Filter", 1012, "IPFilterRule", "MV"},
         {"TFT-Packet-Filter-Information",
          1013,
          "Grouped",
          "MV"},
         {"ToS-Traffic-Class", 1014, "OctetString", "MV"},
         {"Tunnel-Header-Filter", 1036, "IPFilterRule", "V"},
         {"Tunnel-Header-Length", 1037, "Unsigned32", "V"},
         {"Tunnel-Information", 1038, "Grouped", "V"},
         {"UDP-Source-Port", 2806, "Unsigned32", "V"},
         {"UE-Local-IP-Address", 2805, "Address", "V"},
         {"Usage-Monitoring-Information", 1067, "Grouped", "V"},
         {"Usage-Monitoring-Level", 1068, "Enumerated", "V"},
         {"Usage-Monitoring-Report", 1069, "Enumerated", "V"},
         {"Usage-Monitoring-Support", 1070, "Enumerated", "V"},
         {"User-Location-Info-Time", 2812, "Time", "V"}]},
       {diameter_3gpp_ts32_299,
        [{"3GPP-PS-Data-Off-Status", 4406, "Enumerated", "MV"},
         {"AF-Correlation-Information", 1276, "Grouped", "MV"},
         {"APN-Rate-Control", 3933, "Grouped", "MV"},
         {"APN-Rate-Control-Downlink", 3934, "Grouped", "MV"},
         {"APN-Rate-Control-Uplink", 3935, "Grouped", "MV"},
         {"Access-Network-Info-Change", 4401, "Grouped", "MV"},
         {"Access-Network-Information",
          1263,
          "OctetString",
          "MV"},
         {"Access-Transfer-Information", 2709, "Grouped", "MV"},
         {"Access-Transfer-Type", 2710, "Enumerated", "MV"},
         {"Account-Expiration", 2309, "Time", "MV"},
         {"Accumulated-Cost", 2052, "Grouped", "MV"},
         {"Adaptations", 1217, "Enumerated", "MV"},
         {"Additional-Content-Information",
          1207,
          "Grouped",
          "MV"},
         {"Additional-Exception-Reports",
          3936,
          "Enumerated",
          "MV"},
         {"Additional-Type-Information",
          1205,
          "UTF8String",
          "MV"},
         {"Address-Data", 897, "UTF8String", "MV"},
         {"Address-Domain", 898, "Grouped", "MV"},
         {"Address-Type", 899, "Enumerated", "MV"},
         {"Addressee-Type", 1208, "Enumerated", "MV"},
         {"Alternate-Charged-Party-Address",
          1280,
          "UTF8String",
          "MV"},
         {"Announcement-Identifier", 3905, "Unsigned32", "MV"},
         {"Announcement-Information", 3904, "Grouped", "MV"},
         {"Announcement-Order", 3906, "Unsigned32", "MV"},
         {"Announcing-PLMN-ID", 4408, "UTF8String", "MV"},
         {"Announcing-UE-HPLMN-Identifier",
          3426,
          "UTF8String",
          "MV"},
         {"Announcing-UE-VPLMN-Identifier",
          3427,
          "UTF8String",
          "MV"},
         {"AoC-Cost-Information", 2053, "Grouped", "MV"},
         {"AoC-Format", 2310, "Enumerated", "MV"},
         {"AoC-Information", 2054, "Grouped", "MV"},
         {"AoC-Request-Type", 2055, "Enumerated", "MV"},
         {"AoC-Service", 2311, "Grouped", "MV"},
         {"AoC-Service-Obligatory-Type",
          2312,
          "Enumerated",
          "MV"},
         {"AoC-Service-Type", 2313, "Enumerated", "MV"},
         {"AoC-Subscription-Information", 2314, "Grouped", "MV"},
         {"Applic-ID", 1218, "UTF8String", "MV"},
         {"Application-Provided-Called-Party-Address",
          837,
          "UTF8String",
          "MV"},
         {"Application-Server", 836, "UTF8String", "MV"},
         {"Application-Server-Information",
          850,
          "Grouped",
          "MV"},
         {"Application-Specific-Data",
          3458,
          "OctetString",
          "MV"},
         {"Associated-Party-Address", 2035, "UTF8String", "MV"},
         {"Associated-URI", 856, "UTF8String", "MV"},
         {"Authorised-QoS", 849, "UTF8String", "MV"},
         {"Aux-Applic-Info", 1219, "UTF8String", "MV"},
         {"BSSID", 2716, "UTF8String", "MV"},
         {"Base-Time-Interval", 1265, "Unsigned32", "MV"},
         {"Basic-Service-Code", 3411, "Grouped", "MV"},
         {"Bearer-Capability", 3412, "OctetString", "MV"},
         {"Bearer-Service", 854, "OctetString", "MV"},
         {"CG-Address", 846, "Address", "MV"},
         {"CN-Operator-Selection-Entity",
          3421,
          "Enumerated",
          "MV"},
         {"CP-CIoT-EPS-Optimisation-Indicator",
          3930,
          "Enumerated",
          "MV"},
         {"CPDT-Information", 3927, "Grouped", "MV"},
         {"CSG-Access-Mode", 2317, "Enumerated", "MV"},
         {"CSG-Membership-Indication", 2318, "Enumerated", "MV"},
         {"CUG-Information", 2304, "OctetString", "MV"},
         {"Called-Asserted-Identity", 1250, "UTF8String", "MV"},
         {"Called-Identity", 3916, "UTF8String", "MV"},
         {"Called-Identity-Change", 3917, "Grouped", "MV"},
         {"Called-Party-Address", 832, "UTF8String", "MV"},
         {"Calling-Party-Address", 831, "UTF8String", "MV"},
         {"Carrier-Select-Routing-Information",
          2023,
          "UTF8String",
          "MV"},
         {"Cause-Code", 861, "Integer32", "MV"},
         {"Cellular-Network-Information",
          3924,
          "OctetString",
          "MV"},
         {"Change-Condition", 2037, "Integer32", "MV"},
         {"Change-Time", 2038, "Time", "MV"},
         {"Charge-Reason-Code", 2118, "Enumerated", "MV"},
         {"Charged-Party", 857, "UTF8String", "MV"},
         {"Charging-Characteristics-Selection-Mode",
          2066,
          "Enumerated",
          "MV"},
         {"Charging-Per-IP-CAN-Session-Indicator",
          4400,
          "Enumerated",
          "MV"},
         {"Class-Identifier", 1214, "Enumerated", "MV"},
         {"Client-Address", 2018, "Address", "MV"},
         {"Content-Class", 1220, "Enumerated", "MV"},
         {"Content-Disposition", 828, "UTF8String", "MV"},
         {"Content-Length", 827, "Unsigned32", "MV"},
         {"Content-Size", 1206, "Unsigned32", "MV"},
         {"Content-Type", 826, "UTF8String", "MV"},
         {"Coverage-Info", 3459, "Grouped", "MV"},
         {"Coverage-Status", 3428, "Enumerated", "MV"},
         {"Current-Tariff", 2056, "Grouped", "MV"},
         {"DRM-Content", 1221, "Enumerated", "MV"},
         {"Data-Coding-Scheme", 2001, "Integer32", "MV"},
         {"Deferred-Location-Event-Type",
          1230,
          "UTF8String",
          "MV"},
         {"Delivery-Report-Requested", 1216, "Enumerated", "MV"},
         {"Destination-Interface", 2002, "Grouped", "MV"},
         {"Diagnostics", 2039, "Integer32", "MV"},
         {"Discoveree-UE-HPLMN-Identifier",
          4402,
          "UTF8String",
          "MV"},
         {"Discoveree-UE-VPLMN-Identifier",
          4403,
          "UTF8String",
          "MV"},
         {"Discoverer-UE-HPLMN-Identifier",
          4404,
          "UTF8String",
          "MV"},
         {"Discoverer-UE-VPLMN-Identifier",
          4405,
          "UTF8String",
          "MV"},
         {"Domain-Name", 1200, "UTF8String", "MV"},
         {"Dynamic-Address-Flag", 2051, "Enumerated", "MV"},
         {"Dynamic-Address-Flag-Extension",
          2068,
          "Enumerated",
          "MV"},
         {"EPDG-Address", 3425, "Address", "MV"},
         {"Early-Media-Description", 1272, "Grouped", "MV"},
         {"Enhanced-Diagnostics", 3901, "Grouped", "MV"},
         {"Envelope", 1266, "Grouped", "MV"},
         {"Envelope-End-Time", 1267, "Time", "MV"},
         {"Envelope-Reporting", 1268, "Enumerated", "MV"},
         {"Envelope-Start-Time", 1269, "Time", "MV"},
         {"Event", 825, "UTF8String", "MV"},
         {"Event-Charging-TimeStamp", 1258, "Time", "MV"},
         {"Event-Type", 823, "Grouped", "MV"},
         {"Expires", 888, "Unsigned32", "MV"},
         {"FE-Identifier-List", 4413, "UTF8String", "MV"},
         {"File-Repair-Supported", 1224, "Enumerated", "MV"},
         {"Forwarding-Pending", 3415, "Enumerated", "MV"},
         {"From-Address", 2708, "UTF8String", "MV"},
         {"GGSN-Address", 847, "Address", "MV"},
         {"IMS-Application-Reference-Identifier",
          2601,
          "UTF8String",
          "MV"},
         {"IMS-Charging-Identifier", 841, "UTF8String", "MV"},
         {"IMS-Communication-Service-Identifier",
          1281,
          "UTF8String",
          "MV"},
         {"IMS-Emergency-Indicator", 2322, "Enumerated", "MV"},
         {"IMS-Information", 876, "Grouped", "MV"},
         {"IMS-Visited-Network-Identifier",
          2713,
          "UTF8String",
          "MV"},
         {"IMSI-Unauthenticated-Flag", 2308, "Enumerated", "MV"},
         {"IP-Realm-Default-Indication",
          2603,
          "Enumerated",
          "MV"},
         {"ISUP-Cause", 3416, "Grouped", "MV"},
         {"ISUP-Cause-Diagnostics", 3422, "OctetString", "MV"},
         {"ISUP-Cause-Location", 3423, "Unsigned32", "MV"},
         {"ISUP-Cause-Value", 3424, "Unsigned32", "MV"},
         {"ISUP-Location-Number", 3414, "OctetString", "MV"},
         {"Incoming-Trunk-Group-Id", 852, "UTF8String", "MV"},
         {"Incremental-Cost", 2062, "Grouped", "MV"},
         {"Initial-IMS-Charging-Identifier",
          2321,
          "UTF8String",
          "MV"},
         {"Instance-Id", 3402, "UTF8String", "MV"},
         {"Inter-Operator-Identifier", 838, "Grouped", "MV"},
         {"Inter-UE-Transfer", 3902, "Enumerated", "MV"},
         {"Interface-Id", 2003, "UTF8String", "MV"},
         {"Interface-Port", 2004, "UTF8String", "MV"},
         {"Interface-Text", 2005, "UTF8String", "MV"},
         {"Interface-Type", 2006, "Enumerated", "MV"},
         {"LCS-APN", 1231, "UTF8String", "MV"},
         {"LCS-Client-Dialed-By-MS", 1233, "UTF8String", "MV"},
         {"LCS-Client-External-ID", 1234, "UTF8String", "MV"},
         {"LCS-Client-ID", 1232, "Grouped", "MV"},
         {"LCS-Client-Name", 1235, "Grouped", "MV"},
         {"LCS-Client-Type", 1241, "Enumerated", "MV"},
         {"LCS-Data-Coding-Scheme", 1236, "UTF8String", "MV"},
         {"LCS-Format-Indicator", 1237, "Enumerated", "MV"},
         {"LCS-Information", 878, "Grouped", "MV"},
         {"LCS-Name-String", 1238, "UTF8String", "MV"},
         {"LCS-Requestor-ID", 1239, "Grouped", "MV"},
         {"LCS-Requestor-ID-String", 1240, "UTF8String", "MV"},
         {"Language", 3914, "UTF8String", "MV"},
         {"Layer-2-Group-ID", 3429, "OctetString", "MV"},
         {"Local-GW-Inserted-Indication",
          2604,
          "Enumerated",
          "MV"},
         {"Local-Sequence-Number", 2063, "Unsigned32", "MV"},
         {"Location-Estimate", 1242, "OctetString", "MV"},
         {"Location-Estimate-Type", 1243, "Enumerated", "MV"},
         {"Location-Info", 3460, "Grouped", "MV"},
         {"Location-Type", 1244, "Grouped", "MV"},
         {"Low-Balance-Indication", 2020, "Enumerated", "MV"},
         {"Low-Priority-Indicator", 2602, "Enumerated", "MV"},
         {"MBMS-Charged-Party", 2323, "Enumerated", "MV"},
         {"MBMS-GW-Address", 2307, "Address", "MV"},
         {"MBMS-Information", 880, "Grouped", "MV"},
         {"MBMS-User-Service-Type", 1225, "Enumerated", "MV"},
         {"MM-Content-Type", 1203, "Grouped", "MV"},
         {"MMBox-Storage-Requested", 1248, "Enumerated", "MV"},
         {"MMS-Information", 877, "Grouped", "MV"},
         {"MMTel-Information", 2030, "Grouped", "MV"},
         {"MMTel-SService-Type", 2031, "Unsigned32", "MV"},
         {"MSC-Address", 3417, "OctetString", "MV"},
         {"MTC-IWF-Address", 3406, "Address", "MV"},
         {"Media-Initiator-Flag", 882, "Enumerated", "MV"},
         {"Media-Initiator-Party", 1288, "UTF8String", "MV"},
         {"Message-Body", 889, "Grouped", "MV"},
         {"Message-Class", 1213, "Grouped", "MV"},
         {"Message-ID", 1210, "UTF8String", "MV"},
         {"Message-Size", 1212, "Unsigned32", "MV"},
         {"Message-Type", 1211, "Enumerated", "MV"},
         {"Monitored-PLMN-Identifier", 3430, "UTF8String", "MV"},
         {"Monitoring-Event-Configuration-Activity",
          3919,
          "Integer32",
          "MV"},
         {"Monitoring-Event-Functionality",
          3922,
          "Integer32",
          "MV"},
         {"Monitoring-Event-Information", 3921, "Grouped", "MV"},
         {"Monitoring-Event-Report-Data", 3920, "Grouped", "MV"},
         {"Monitoring-Event-Report-Number",
          3923,
          "Unsigned32",
          "MV"},
         {"Monitoring-UE-HPLMN-Identifier",
          3431,
          "UTF8String",
          "MV"},
         {"Monitoring-UE-Identifier", 3432, "UTF8String", "MV"},
         {"Monitoring-UE-VPLMN-Identifier",
          3433,
          "UTF8String",
          "MV"},
         {"NIDD-Submission", 3928, "Grouped", "VM"},
         {"NNI-Information", 2703, "Grouped", "MV"},
         {"NNI-Type", 2704, "Enumerated", "MV"},
         {"Neighbour-Node-Address", 2705, "Address", "MV"},
         {"Network-Call-Reference-Number",
          3418,
          "OctetString",
          "MV"},
         {"Next-Tariff", 2057, "Grouped", "VM"},
         {"Node-Functionality", 862, "Enumerated", "MV"},
         {"Node-Id", 2064, "UTF8String", "MV"},
         {"Number-Of-Diversions", 2034, "Unsigned32", "MV"},
         {"Number-Of-Messages-Sent", 2019, "Unsigned32", "MV"},
         {"Number-Of-Participants", 885, "Unsigned32", "MV"},
         {"Number-Of-Received-Talk-Bursts",
          1282,
          "Unsigned32",
          "MV"},
         {"Number-Of-Talk-Bursts", 1283, "Unsigned32", "MV"},
         {"Number-Portability-Routing-Information",
          2024,
          "UTF8String",
          "MV"},
         {"Offline-Charging", 1278, "Grouped", "MV"},
         {"Online-Charging-Flag", 2303, "Enumerated", "MV"},
         {"Originating-IOI", 839, "UTF8String", "MV"},
         {"Originator", 864, "Enumerated", "MV"},
         {"Originator-Address", 886, "Grouped", "MV"},
         {"Originator-Interface", 2009, "Grouped", "MV"},
         {"Originator-Received-Address", 2027, "Grouped", "MV"},
         {"Originator-SCCP-Address", 2008, "Address", "MV"},
         {"Outgoing-Session-Id", 2320, "UTF8String", "MV"},
         {"Outgoing-Trunk-Group-Id", 853, "UTF8String", "MV"},
         {"PC3-Control-Protocol-Cause", 3434, "Integer32", "MV"},
         {"PC3-EPC-Control-Protocol-Cause",
          3435,
          "Integer32",
          "MV"},
         {"PC5-Radio-Technology", 1300, "Enumerated", "V"},
         {"PDN-Connection-Charging-ID",
          2050,
          "Unsigned32",
          "MV"},
         {"PDP-Address", 1227, "Address", "MV"},
         {"PDP-Address-Prefix-Length", 2606, "Unsigned32", "MV"},
         {"PDP-Context-Type", 1247, "Enumerated", "MV"},
         {"PS-Append-Free-Format-Data", 867, "Enumerated", "MV"},
         {"PS-Free-Format-Data", 866, "OctetString", "MV"},
         {"PS-Furnish-Charging-Information",
          865,
          "Grouped",
          "MV"},
         {"PS-Information", 874, "Grouped", "MV"},
         {"Participant-Access-Priority",
          1259,
          "Enumerated",
          "MV"},
         {"Participant-Action-Type", 2049, "Enumerated", "MV"},
         {"Participant-Group", 1260, "Grouped", "MV"},
         {"Participants-Involved", 887, "UTF8String", "MV"},
         {"Play-Alternative", 3913, "Enumerated", "MV"},
         {"PoC-Change-Condition", 1261, "Enumerated", "MV"},
         {"PoC-Change-Time", 1262, "Time", "MV"},
         {"PoC-Controlling-Address", 858, "UTF8String", "MV"},
         {"PoC-Event-Type", 2025, "Enumerated", "MV"},
         {"PoC-Group-Name", 859, "UTF8String", "MV"},
         {"PoC-Information", 879, "Grouped", "MV"},
         {"PoC-Server-Role", 883, "Enumerated", "MV"},
         {"PoC-Session-Id", 1229, "UTF8String", "MV"},
         {"PoC-Session-Initiation-Type",
          1277,
          "Enumerated",
          "MV"},
         {"PoC-Session-Type", 884, "Enumerated", "MV"},
         {"PoC-User-Role", 1252, "Grouped", "MV"},
         {"PoC-User-Role-IDs", 1253, "UTF8String", "MV"},
         {"PoC-User-Role-Info-Units", 1254, "Enumerated", "MV"},
         {"Positioning-Data", 1245, "UTF8String", "MV"},
         {"Preferred-AoC-Currency", 2315, "Unsigned32", "MV"},
         {"Priority", 1209, "Enumerated", "MV"},
         {"Privacy-Indicator", 3915, "Enumerated", "MV"},
         {"ProSe-3rd-Party-Application-ID",
          3440,
          "UTF8String",
          "MV"},
         {"ProSe-Direct-Communication-Reception-Data-Con"
          "tainer",
          3461,
          "Grouped",
          "MV"},
         {"ProSe-Direct-Communication-Transmission-Data-"
          "Container",
          3441,
          "Grouped",
          "MV"},
         {"ProSe-Direct-Discovery-Model",
          3442,
          "Enumerated",
          "MV"},
         {"ProSe-Event-Type", 3443, "Enumerated", "MV"},
         {"ProSe-Function-IP-Address", 3444, "Address", "MV"},
         {"ProSe-Function-PLMN-Identifier",
          3457,
          "UTF8String",
          "MV"},
         {"ProSe-Functionality", 3445, "Enumerated", "MV"},
         {"ProSe-Group-IP-Multicast-Address",
          3446,
          "Address",
          "MV"},
         {"ProSe-Information", 3447, "Grouped", "MV"},
         {"ProSe-Range-Class", 3448, "Enumerated", "MV"},
         {"ProSe-Reason-For-Cancellation",
          3449,
          "Enumerated",
          "MV"},
         {"ProSe-Request-Timestamp", 3450, "Time", "MV"},
         {"ProSe-Role-Of-UE", 3451, "Enumerated", "MV"},
         {"ProSe-Source-IP-Address", 3452, "Address", "MV"},
         {"ProSe-Target-Layer-2-ID", 4410, "OctetString", "MV"},
         {"ProSe-UE-ID", 3453, "OctetString", "MV"},
         {"ProSe-UE-to-Network-Relay-UE-ID",
          4409,
          "OctetString",
          "MV"},
         {"Proximity-Alert-Indication",
          3454,
          "Enumerated",
          "MV"},
         {"Proximity-Alert-Timestamp", 3455, "Time", "MV"},
         {"Proximity-Cancellation-Timestamp",
          3456,
          "Time",
          "MV"},
         {"Quota-Consumption-Time", 881, "Unsigned32", "MV"},
         {"Quota-Holding-Time", 871, "Unsigned32", "MV"},
         {"Quota-Indicator", 3912, "Enumerated", "MV"},
         {"RAN-End-Timestamp", 1301, "Time", "V"},
         {"RAN-Secondary-RAT-Usage-Report",
          1302,
          "Grouped",
          "V"},
         {"RAN-Start-Timestamp", 1303, "Time", "V"},
         {"Radio-Frequency", 3462, "OctetString", "MV"},
         {"Radio-Parameter-Set-Info", 3463, "Grouped", "MV"},
         {"Radio-Parameter-Set-Values",
          3464,
          "OctetString",
          "MV"},
         {"Radio-Resources-Indicator", 3465, "Integer32", "MV"},
         {"Rate-Control-Max-Message-Size",
          3937,
          "Unsigned32",
          "MV"},
         {"Rate-Control-Max-Rate", 3938, "Unsigned32", "MV"},
         {"Rate-Control-Time-Unit", 3939, "Unsigned32", "MV"},
         {"Rate-Element", 2058, "Grouped", "MV"},
         {"Read-Reply-Report-Requested",
          1222,
          "Enumerated",
          "MV"},
         {"Real-Time-Tariff-Information", 2305, "Grouped", "MV"},
         {"Reason-Header", 3401, "UTF8String", "MV"},
         {"Received-Talk-Burst-Time", 1284, "Unsigned32", "MV"},
         {"Received-Talk-Burst-Volume",
          1285,
          "Unsigned32",
          "MV"},
         {"Recipient-Address", 1201, "Grouped", "MV"},
         {"Recipient-Info", 2026, "Grouped", "MV"},
         {"Recipient-Received-Address", 2028, "Grouped", "MV"},
         {"Recipient-SCCP-Address", 2010, "Address", "MV"},
         {"Refund-Information", 2022, "OctetString", "MV"},
         {"Related-Change-Condition-Information",
          3925,
          "Grouped",
          "MV"},
         {"Related-IMS-Charging-Identifier",
          2711,
          "UTF8String",
          "MV"},
         {"Related-IMS-Charging-Identifier-Node",
          2712,
          "Address",
          "MV"},
         {"Related-Trigger", 3926, "Grouped", "MV"},
         {"Relationship-Mode", 2706, "Enumerated", "MV"},
         {"Relay-IP-address", 4411, "Address", "MV"},
         {"Remaining-Balance", 2021, "Grouped", "MV"},
         {"Reply-Applic-ID", 1223, "UTF8String", "MV"},
         {"Reply-Path-Requested", 2011, "Enumerated", "MV"},
         {"Reporting-Reason", 872, "Enumerated", "MV"},
         {"Requested-PLMN-Identifier", 3436, "UTF8String", "MV"},
         {"Requested-Party-Address", 1251, "UTF8String", "MV"},
         {"Requestor-PLMN-Identifier", 3437, "UTF8String", "MV"},
         {"Role-Of-Node", 829, "Enumerated", "MV"},
         {"Role-Of-ProSe-Function", 3438, "Enumerated", "MV"},
         {"Route-Header-Received", 3403, "UTF8String", "MV"},
         {"Route-Header-Transmitted", 3404, "UTF8String", "MV"},
         {"SCS-AS-Address", 3940, "Grouped", "MV"},
         {"SCS-Address", 3941, "Address", "MV"},
         {"SCS-Realm", 3942, "DiameterIdentity", "MV"},
         {"SDP-Answer-Timestamp", 1275, "Time", "MV"},
         {"SDP-Media-Component", 843, "Grouped", "MV"},
         {"SDP-Media-Description", 845, "UTF8String", "MV"},
         {"SDP-Media-Name", 844, "UTF8String", "MV"},
         {"SDP-Offer-Timestamp", 1274, "Time", "MV"},
         {"SDP-Session-Description", 842, "UTF8String", "MV"},
         {"SDP-TimeStamps", 1273, "Grouped", "MV"},
         {"SDP-Type", 2036, "Enumerated", "MV"},
         {"SGSN-Address", 1228, "Address", "MV"},
         {"SGW-Address", 2067, "Address", "MV"},
         {"SGW-Change", 2065, "Enumerated", "MV"},
         {"SGi-PtP-Tunnelling-Method", 3931, "Enumerated", "MV"},
         {"SIP-Method", 824, "UTF8String", "MV"},
         {"SIP-Request-Timestamp", 834, "Time", "MV"},
         {"SIP-Request-Timestamp-Fraction",
          2301,
          "Unsigned32",
          "MV"},
         {"SIP-Response-Timestamp", 835, "Time", "MV"},
         {"SIP-Response-Timestamp-Fraction",
          2302,
          "Unsigned32",
          "MV"},
         {"SM-Device-Trigger-Indicator",
          3407,
          "Enumerated",
          "MV"},
         {"SM-Device-Trigger-Information",
          3405,
          "Grouped",
          "MV"},
         {"SM-Discharge-Time", 2012, "Time", "MV"},
         {"SM-Message-Type", 2007, "Enumerated", "MV"},
         {"SM-Protocol-ID", 2013, "OctetString", "MV"},
         {"SM-Sequence-Number", 3408, "Unsigned32", "MV"},
         {"SM-Service-Type", 2029, "Enumerated", "MV"},
         {"SM-Status", 2014, "OctetString", "MV"},
         {"SM-User-Data-Header", 2015, "OctetString", "MV"},
         {"SMS-Information", 2000, "Grouped", "MV"},
         {"SMS-Node", 2016, "Enumerated", "MV"},
         {"SMS-Result", 3409, "Unsigned32", "MV"},
         {"SMSC-Address", 2017, "Address", "MV"},
         {"Scale-Factor", 2059, "Grouped", "MV"},
         {"Secondary-RAT-Type", 1304, "OctetString", "V"},
         {"Served-Party-IP-Address", 848, "Address", "MV"},
         {"Service-Data-Container", 2040, "Grouped", "MV"},
         {"Service-Id", 855, "UTF8String", "MV"},
         {"Service-Mode", 2032, "Unsigned32", "MV"},
         {"Service-Specific-Data", 863, "UTF8String", "MV"},
         {"Service-Specific-Info", 1249, "Grouped", "MV"},
         {"Service-Specific-Type", 1257, "Unsigned32", "MV"},
         {"Serving-Node-Identity",
          3929,
          "DiameterIdentity",
          "MV"},
         {"Serving-Node-Type", 2047, "Enumerated", "MV"},
         {"Session-Direction", 2707, "Enumerated", "MV"},
         {"Start-Time", 2041, "Time", "MV"},
         {"Start-of-Charging", 3419, "Time", "MV"},
         {"Status-AS-Code", 2702, "Enumerated", "MV"},
         {"Stop-Time", 2042, "Time", "MV"},
         {"Submission-Time", 1202, "Time", "MV"},
         {"Subscriber-Role", 2033, "Enumerated", "MV"},
         {"Supplementary-Service", 2048, "Grouped", "MV"},
         {"TAD-Identifier", 2717, "Enumerated", "MV"},
         {"TWAG-Address", 3903, "Address", "MV"},
         {"TWAN-User-Location-Info", 2714, "Grouped", "MV"},
         {"Talk-Burst-Exchange", 1255, "Grouped", "MV"},
         {"Talk-Burst-Time", 1286, "Unsigned32", "MV"},
         {"Talk-Burst-Volume", 1287, "Unsigned32", "MV"},
         {"Target-IP-Address", 4412, "Address", "MV"},
         {"Tariff-Information", 2060, "Grouped", "MV"},
         {"Tariff-XML", 2306, "UTF8String", "MV"},
         {"Teleservice", 3413, "OctetString", "MV"},
         {"Terminating-IOI", 840, "UTF8String", "MV"},
         {"Time-First-Reception", 3466, "Time", "MV"},
         {"Time-First-Transmission", 3467, "Time", "MV"},
         {"Time-First-Usage", 2043, "Time", "MV"},
         {"Time-Indicator", 3911, "Unsigned32", "MV"},
         {"Time-Last-Usage", 2044, "Time", "MV"},
         {"Time-Quota-Mechanism", 1270, "Grouped", "MV"},
         {"Time-Quota-Threshold", 868, "Unsigned32", "MV"},
         {"Time-Quota-Type", 1271, "Enumerated", "MV"},
         {"Time-Stamps", 833, "Grouped", "MV"},
         {"Time-Usage", 2045, "Unsigned32", "MV"},
         {"Token-Text", 1215, "UTF8String", "MV"},
         {"Traffic-Data-Volumes", 2046, "Grouped", "MV"},
         {"Transcoder-Inserted-Indication",
          2605,
          "Enumerated",
          "MV"},
         {"Transit-IOI-List", 2701, "UTF8String", "MV"},
         {"Transmitter-Info", 3468, "Grouped", "MV"},
         {"Trigger", 1264, "Grouped", "MV"},
         {"Trigger-Type", 870, "Enumerated", "MV"},
         {"Trunk-Group-Id", 851, "Grouped", "MV"},
         {"Type-Number", 1204, "Enumerated", "MV"},
         {"UNI-PDU-CP-Only-Flag", 3932, "Enumerated", "MV"},
         {"UWAN-User-Location-Info", 3918, "Grouped", "MV"},
         {"Unit-Cost", 2061, "Grouped", "MV"},
         {"Unit-Quota-Threshold", 1226, "Unsigned32", "MV"},
         {"Unused-Quota-Timer", 4407, "Unsigned32", "MV"},
         {"Usage-Information-Report-Sequence-Number",
          3439,
          "Integer32",
          "MV"},
         {"User-CSG-Information", 2319, "Grouped", "MV"},
         {"User-Participating-Type", 1279, "Enumerated", "MV"},
         {"User-Session-Id", 830, "UTF8String", "MV"},
         {"VCS-Information", 3410, "Grouped", "MV"},
         {"VLR-Number", 3420, "OctetString", "MV"},
         {"Variable-Part", 3907, "Grouped", "MV"},
         {"Variable-Part-Order", 3908, "Unsigned32", "MV"},
         {"Variable-Part-Type", 3909, "Enumerated", "MV"},
         {"Variable-Part-Value", 3910, "UTF8String", "MV"},
         {"Volume-Quota-Threshold", 869, "Unsigned32", "MV"}]}]},
     {import_enums,
      [{diameter_3gpp_base,
        [{"3GPP-PDP-Type",
          [{"IPv4", 0},
           {"PPP", 1},
           {"IPv6", 2},
           {"IPv4v6", 3},
           {"Non-IP", 4}]}]},
       {diameter_3gpp_ts29_212,
        [{"AN-GW-Status", [{"AN_GW_FAILED", 0}]},
         {"Bearer-Control-Mode",
          [{"UE_ONLY", 0}, {"RESERVED", 1}, {"UE_NW", 2}]},
         {"Bearer-Operation",
          [{"TERMINATION", 0},
           {"ESTABLISHMENT", 1},
           {"MODIFICATION", 2}]},
         {"Bearer-Usage",
          [{"GENERAL", 0}, {"IMS_SIGNALLING", 1}]},
         {"Charging-Correlation-Indicator",
          [{"CHARGING_IDENTIFIER_REQUIRED", 0}]},
         {"CSG-Information-Reporting",
          [{"CHANGE_CSG_CELL", 0},
           {"CHANGE_CSG_SUBSCRIBED_HYBRID_CELL", 1},
           {"CHANGE_CSG_UNSUBSCRIBED_HYBRID_CELL", 2}]},
         {"Event-Trigger",
          [{"SGSN_CHANGE", 0},
           {"QOS_CHANGE", 1},
           {"RAT_CHANGE", 2},
           {"TFT_CHANGE", 3},
           {"PLMN_CHANGE", 4},
           {"LOSS_OF_BEARER", 5},
           {"RECOVERY_OF_BEARER", 6},
           {"IP-CAN_CHANGE", 7},
           {"QOS_CHANGE_EXCEEDING_AUTHORIZATION", 11},
           {"RAI_CHANGE", 12},
           {"USER_LOCATION_CHANGE", 13},
           {"NO_EVENT_TRIGGERS", 14},
           {"OUT_OF_CREDIT", 15},
           {"REALLOCATION_OF_CREDIT", 16},
           {"REVALIDATION_TIMEOUT", 17},
           {"UE_IP_ADDRESS_ALLOCATE", 18},
           {"UE_IP_ADDRESS_RELEASE", 19},
           {"DEFAULT_EPS_BEARER_QOS_CHANGE", 20},
           {"AN_GW_CHANGE", 21},
           {"SUCCESSFUL_RESOURCE_ALLOCATION", 22},
           {"RESOURCE_MODIFICATION_REQUEST", 23},
           {"PGW_TRACE_CONTROL", 24},
           {"UE_TIME_ZONE_CHANGE", 25},
           {"TAI_CHANGE", 26},
           {"ECGI_CHANGE", 27},
           {"CHARGING_CORRELATION_EXCHANGE", 28},
           {"APN-AMBR_MODIFICATION_FAILURE", 29},
           {"USER_CSG_INFORMATION_CHANGE", 30},
           {"USAGE_REPORT", 33},
           {"DEFAULT-EPS-BEARER-QOS_MODIFICATION_FAILURE", 34},
           {"USER_CSG_HYBRID_SUBSCRIBED_INFORMATION_CHANGE", 35},
           {"USER_CSG_HYBRID_UNSUBSCRIBED_INFORMATION_CHANGE", 36},
           {"ROUTING_RULE_CHANGE", 37},
           {"APPLICATION_START", 39},
           {"APPLICATION_STOP", 40},
           {"CS_TO_PS_HANDOVER", 42},
           {"UE_LOCAL_IP_ADDRESS_CHANGE", 43},
           {"HNB_LOCAL_IP_ADDRESS_CHANGE", 44},
           {"ACCESS_NETWORK_INFO_REPORT", 45},
           {"CREDIT_MANAGEMENT_SESSION_FAILURE", 46},
           {"DEFAULT_QOS_CHANGE", 47},
           {"CHANGE_OF_UE_PRESENCE_IN_PRESENCE_REPORTING_A"
            "REA_REPORT",
            48}]},
         {"Flow-Direction",
          [{"UNSPECIFIED", 0},
           {"DOWNLINK", 1},
           {"UPLINK", 2},
           {"BIDIRECTIONAL", 3}]},
         {"IP-CAN-Session-Charging-Scope",
          [{"IP-CAN_SESSION_SCOPE", 0}]},
         {"IP-CAN-Type",
          [{"3GPP-GPRS", 0},
           {"DOCSIS", 1},
           {"xDSL", 2},
           {"WiMAX", 3},
           {"3GPP2", 4},
           {"3GPP-EPS", 5},
           {"Non-3GPP-EPS", 6},
           {"FBA", 7}]},
         {"Metering-Method",
          [{"DURATION", 0},
           {"VOLUME", 1},
           {"DURATION_VOLUME", 2},
           {"EVENT", 3}]},
         {"Mute-Notification", [{"MUTE_REQUIRED", 0}]},
         {"Network-Request-Support",
          [{"NETWORK_REQUEST_NOT_SUPPORTED", 0},
           {"NETWORK_REQUEST_SUPPORTED", 1}]},
         {"Offline",
          [{"DISABLE_OFFLINE", 0}, {"ENABLE_OFFLINE", 1}]},
         {"Online",
          [{"DISABLE_ONLINE", 0}, {"ENABLE_ONLINE", 1}]},
         {"Packet-Filter-Operation",
          [{"DELETION", 0},
           {"ADDITION", 1},
           {"MODIFICATION", 2}]},
         {"Packet-Filter-Usage", [{"SEND_TO_UE", 1}]},
         {"PCC-Rule-Status",
          [{"ACTIVE", 0},
           {"INACTIVE", 1},
           {"TEMPORARILY_INACTIVE", 2}]},
         {"Pre-emption-Capability",
          [{"PRE-EMPTION_CAPABILITY_ENABLED", 0},
           {"PRE-EMPTION_CAPABILITY_DISABLED", 1}]},
         {"Pre-emption-Vulnerability",
          [{"PRE-EMPTION_VULNERABILITY_ENABLED", 0},
           {"PRE-EMPTION_VULNERABILITY_DISABLED", 1}]},
         {"PS-to-CS-Session-Continuity",
          [{"VIDEO_PS2CS_CONT_CANDIDATE", 0}]},
         {"QoS-Negotiation",
          [{"NO_QoS_NEGOTIATION", 0},
           {"QoS_NEGOTIATION_SUPPORTED", 1}]},
         {"QoS-Upgrade",
          [{"QoS_UPGRADE_NOT_SUPPORTED", 0},
           {"QoS_UPGRADE_SUPPORTED", 1}]},
         {"RAT-Type",
          [{"WLAN", 0},
           {"VIRTUAL", 1},
           {"UTRAN", 1000},
           {"GERAN", 1001},
           {"GAN", 1002},
           {"HSPA_EVOLUTION", 1003},
           {"EUTRAN", 1004},
           {"CDMA2000_1X", 2000},
           {"HRPD", 2001},
           {"UMB", 2002},
           {"EHRPD", 2003}]},
         {"Redirect-Support",
          [{"REDIRECTION_DISABLED", 0},
           {"REDIRECTION_ENABLED", 1}]},
         {"Reporting-Level",
          [{"SERVICE_IDENTIFIER_LEVEL", 0},
           {"RATING_GROUP_LEVEL", 1},
           {"SPONSORED_CONNECTIVITY_LEVEL", 2}]},
         {"Resource-Allocation-Notification",
          [{"ENABLE_NOTIFICATION", 0}]},
         {"Rule-Failure-Code",
          [{"UNKNOWN_RULE_NAME", 1},
           {"RATING_GROUP_ERROR", 2},
           {"SERVICE_IDENTIFIER_ERROR", 3},
           {"GW_PCEF_MALFUNCTION", 4},
           {"RESOURCES_LIMITATION", 5},
           {"MAX_NR_BEARERS_REACHED", 6},
           {"UNKNOWN_BEARER_ID", 7},
           {"MISSING_BEARER_ID", 8},
           {"MISSING_FLOW_INFORMATION", 9},
           {"RESOURCE_ALLOCATION_FAILURE", 10},
           {"UNSUCCESSFUL_QOS_VALIDATION", 11},
           {"INCORRECT_FLOW_INFORMATION", 12},
           {"PS_TO_CS_HANDOVER", 13},
           {"TDF_APPLICATION_IDENTIFIER_ERROR", 14},
           {"NO_BEARER_BOUND", 15},
           {"FILTER_RESTRICTIONS", 16},
           {"AN_GW_FAILED", 17},
           {"MISSING_REDIRECT_SERVER_ADDRESS", 18},
           {"CM_END_USER_SERVICE_DENIED", 19},
           {"CM_CREDIT_CONTROL_NOT_APPLICABLE", 20},
           {"CM_AUTHORIZATION_REJECTED", 21},
           {"CM_USER_UNKNOWN", 22},
           {"CM_RATING_FAILED", 23}]},
         {"Session-Release-Cause",
          [{"UNSPECIFIED_REASON", 0},
           {"UE_SUBSCRIPTION_REASON", 1},
           {"INSUFFICIENT_SERVER_RESOURCES", 2},
           {"IP_CAN_SESSION_TERMINATION", 3},
           {"UE_IP_ADDRESS_RELEASE", 4}]},
         {"Usage-Monitoring-Level",
          [{"SESSION_LEVEL", 0},
           {"PCC_RULE_LEVEL", 1},
           {"ADC_RULE_LEVEL", 2}]},
         {"Usage-Monitoring-Report",
          [{"USAGE_MONITORING_REPORT_REQUIRED", 0}]},
         {"Usage-Monitoring-Support",
          [{"USAGE_MONITORING_DISABLED", 0}]}]},
       {diameter_3gpp_ts32_299,
        [{"3GPP-PS-Data-Off-Status",
          [{"Active", 0}, {"Inactive", 1}]},
         {"Access-Transfer-Type",
          [{"PS-to-CS-Transfer", 0},
           {"CS-to-PS-Transfer", 1},
           {"PS-to-PS-Transfer", 2},
           {"CS-to-CS-Transfer", 3}]},
         {"Adaptations", [{"Yes", 0}, {"No", 1}]},
         {"Additional-Exception-Reports",
          [{"Not-allowed", 0}, {"Allowed", 1}]},
         {"Address-Type",
          [{"e-mail-address", 0},
           {"MSISDN", 1},
           {"IPv4-Address", 2},
           {"IPv6-Address", 3},
           {"Numeric-Shortcode", 4},
           {"Alphanumeric-Shortcode", 5},
           {"Other", 6},
           {"IMSI", 7}]},
         {"Addressee-Type", [{"TO", 0}, {"CC", 1}, {"BCC", 2}]},
         {"AoC-Format",
          [{"MONETARY", 0}, {"NON_MONETARY", 1}, {"CAI", 2}]},
         {"AoC-Request-Type",
          [{"AoC_NOT_REQUESTED", 0},
           {"AoC_FULL", 1},
           {"AoC_COST_ONLY", 2},
           {"AoC_TARIFF_ONLY", 3}]},
         {"AoC-Service-Obligatory-Type",
          [{"NON_BINDING", 0}, {"BINDING", 1}]},
         {"AoC-Service-Type",
          [{"NONE", 0},
           {"AOC-S", 1},
           {"AOC-D", 2},
           {"AOC-E", 3}]},
         {"Charge-Reason-Code",
          [{"UNKNOWN", 0},
           {"USAGE", 1},
           {"COMMUNICATION-ATTEMPT-CHARGE", 2},
           {"SETUP-CHARGE", 3},
           {"ADD-ON-CHARGE", 4}]},
         {"Charging-Characteristics-Selection-Mode",
          [{"Serving-Node-Supplied", 0},
           {"Subscription-specific", 1},
           {"APN-specific", 2},
           {"Home-Default", 3},
           {"Roaming-Default", 4},
           {"Visiting-Default", 5}]},
         {"Charging-Per-IP-CAN-Session-Indicator",
          [{"Inactive", 0}, {"Active", 1}]},
         {"Class-Identifier",
          [{"Personal", 0},
           {"Advertisement", 1},
           {"Informational", 2},
           {"Auto", 3}]},
         {"CN-Operator-Selection-Entity",
          [{"The-Serving-Network-has-been-selected-by-the-UE", 0},
           {"The-Serving-Network-has-been-selected-by-the-"
            "network",
            1}]},
         {"Content-Class",
          [{"text", 0},
           {"image-basic", 1},
           {"image-rich", 2},
           {"video-basic", 3},
           {"video-rich", 4},
           {"megapixel", 5},
           {"content-basic", 6},
           {"content-rich", 7}]},
         {"Coverage-Status",
          [{"Out-of-coverage", 0}, {"In-coverage", 1}]},
         {"CP-CIoT-EPS-Optimisation-Indicator",
          [{"Not-Apply", 0}, {"Apply", 1}]},
         {"CSG-Access-Mode",
          [{"Closed-mode", 0}, {"Hybrid-Mode", 1}]},
         {"CSG-Membership-Indication",
          [{"Not-CSG-member", 0}, {"CSG-Member", 1}]},
         {"Delivery-Report-Requested", [{"No", 0}, {"Yes", 1}]},
         {"DRM-Content", [{"No", 0}, {"Yes", 1}]},
         {"Dynamic-Address-Flag",
          [{"Static", 0}, {"Dynamic", 1}]},
         {"Dynamic-Address-Flag-Extension",
          [{"Static", 0}, {"Dynamic", 1}]},
         {"Envelope-Reporting",
          [{"DO_NOT_REPORT_ENVELOPES", 0},
           {"REPORT_ENVELOPES", 1},
           {"REPORT_ENVELOPES_WITH_VOLUME", 2},
           {"REPORT_ENVELOPES_WITH_EVENTS", 3},
           {"REPORT_ENVELOPES_WITH_VOLUME_AND_EVENTS", 4}]},
         {"File-Repair-Supported",
          [{"SUPPORTED", 1}, {"NOT_SUPPORTED", 2}]},
         {"Forwarding-Pending",
          [{"Forwarding-not-pending", 0},
           {"Forwarding-pending", 1}]},
         {"Interface-Type",
          [{"Unknown", 0},
           {"MOBILE_ORIGINATING", 1},
           {"MOBILE_TERMINATING", 2},
           {"APPLICATION_ORIGINATING", 3},
           {"APPLICATION_TERMINATION", 4}]},
         {"Inter-UE-Transfer",
          [{"Intra-UE-transfer", 0}, {"Inter-UE-transfer", 1}]},
         {"IMS-Emergency-Indicator",
          [{"Non-Emergency", 0}, {"Emergency", 1}]},
         {"IMSI-Unauthenticated-Flag",
          [{"Authenticated", 0}, {"Unauthenticated", 1}]},
         {"IP-Realm-Default-Indication",
          [{"Default-IP-Realm-Not-used", 0},
           {"Default-IP-realm-used", 1}]},
         {"LCS-Client-Type",
          [{"EMERGENCY_SERVICES", 0},
           {"VALUE_ADDED_SERVICES", 1},
           {"PLMN_OPERATOR_SERVICES", 2},
           {"LAWFUL_INTERCEPT_SERVICES", 3}]},
         {"LCS-Format-Indicator",
          [{"LOGICAL_NAME", 0},
           {"EMAIL_ADDRESS", 1},
           {"MSISDN", 2},
           {"URL", 3},
           {"SIP_URL", 4}]},
         {"Local-GW-Inserted-Indication",
          [{"Local-GW-Not-Inserted", 0},
           {"Local-GW-Inserted", 1}]},
         {"Location-Estimate-Type",
          [{"CURRENT_LOCATION", 0},
           {"CURRENT_LAST_KNOWN_LOCATION", 1},
           {"INITIAL_LOCATION", 2},
           {"ACTIVATE_DEFERRED_LOCATION", 3},
           {"CANCEL_DEFERRED_LOCATION", 4}]},
         {"Low-Balance-Indication",
          [{"NOT-APPLICABLE", 0}, {"YES", 1}]},
         {"Low-Priority-Indicator", [{"NO", 0}, {"YES", 1}]},
         {"MBMS-Charged-Party",
          [{"Content-Provider", 0}, {"Subscriber", 1}]},
         {"MBMS-User-Service-Type",
          [{"DOWNLOAD", 1}, {"STREAMING", 2}]},
         {"Media-Initiator-Flag",
          [{"called-party", 0},
           {"calling-party", 1},
           {"unknown", 2}]},
         {"Message-Type",
          [{"m-send-req", 1},
           {"m-send-conf", 2},
           {"m-notification-ind", 3},
           {"m-notifyresp-ind", 4},
           {"m-retrieve-conf", 5},
           {"m-acknowledge-ind", 6},
           {"m-delivery-ind", 7},
           {"m-read-rec-ind", 8},
           {"m-read-orig-ind", 9},
           {"m-forward-req", 10},
           {"m-forward-conf", 11},
           {"m-mbox-store-conf", 12},
           {"m-mbox-view-conf", 13},
           {"m-mbox-upload-conf", 14},
           {"m-mbox-delete-conf", 15}]},
         {"MMBox-Storage-Requested", [{"No", 0}, {"Yes", 1}]},
         {"NNI-Type",
          [{"non-roaming", 0},
           {"roaming-without-loopback", 1},
           {"roaming-with-loopback", 2}]},
         {"Node-Functionality",
          [{"S-CSCF", 0},
           {"P-CSCF", 1},
           {"I-CSCF", 2},
           {"MRFC", 3},
           {"MGCF", 4},
           {"BGCF", 5},
           {"AS", 6},
           {"IBCF", 7},
           {"S-GW", 8},
           {"P-GW", 9},
           {"HSGW", 10},
           {"E-CSCF", 11},
           {"MME", 12},
           {"TRF", 13},
           {"TF", 14},
           {"ATCF", 15},
           {"Proxy-Function", 16},
           {"ePDG", 17},
           {"TDF", 18},
           {"TWAG", 19},
           {"SCEF", 20},
           {"IWK-SCEF", 21}]},
         {"Online-Charging-Flag",
          [{"ECF-address-not-provided", 0},
           {"ECF-address-provided", 1}]},
         {"Originator",
          [{"Calling-Party", 0}, {"Called-Party", 1}]},
         {"Participant-Access-Priority",
          [{"Pre-emptive-priority", 1},
           {"High-priority", 2},
           {"Normal-priority", 3},
           {"Low-priority", 4}]},
         {"Participant-Action-Type",
          [{"CREATE_CONF", 0},
           {"JOIN_CONF", 1},
           {"INVITE_INTO_CONF", 2},
           {"QUIT_CONF", 3}]},
         {"PC5-Radio-Technology",
          [{"EUTRA", 0},
           {"WLAN", 1},
           {"Both-EUTRA-and-WLAN", 2}]},
         {"PDP-Context-Type",
          [{"Primary", 0}, {"Secondary", 1}]},
         {"Play-Alternative",
          [{"served-party", 0}, {"remote-party", 1}]},
         {"PoC-Change-Condition",
          [{"ServiceChange", 0},
           {"VolumeLimit", 1},
           {"TimeLimit", 2},
           {"NumberofTalkBurstLimit", 3},
           {"NumberofActiveParticipants", 4},
           {"TariffTime", 5}]},
         {"PoC-Event-Type",
          [{"Normal", 0},
           {"Instant-Personal-Alert-event", 1},
           {"PoC-Group-Advertisement-event", 2},
           {"Early-Ssession-Setting-up-event", 3},
           {"PoC-Talk-Burst", 4}]},
         {"PoC-Server-Role",
          [{"Participating-PoC-Server", 0},
           {"Controlling-PoC-Server", 1},
           {"Interworking-function", 2},
           {"Interworking-selection-function", 3}]},
         {"PoC-Session-Initiation-Type",
          [{"Pre-established", 0}, {"On-demand", 1}]},
         {"PoC-Session-Type",
          [{"1-to-1-PoC-session", 0},
           {"Chat-PoC-group-session", 1},
           {"Pre-arranged-PoC-group-session", 2},
           {"Ad-hoc-PoC-group-session", 3}]},
         {"PoC-User-Role-Info-Units",
          [{"Moderator", 1},
           {"Dispatcher", 2},
           {"Session-Owner", 3},
           {"Session-Participant", 4}]},
         {"Priority", [{"Low", 0}, {"Normal", 1}, {"High", 2}]},
         {"Privacy-Indicator",
          [{"NOT_PRIVATE", 0}, {"PRIVATE", 1}]},
         {"ProSe-Direct-Discovery-Model",
          [{"Model-A", 0}, {"Model-B", 1}]},
         {"ProSe-Event-Type",
          [{"Annoucing", 0},
           {"Monitoring", 1},
           {"Match-Report", 2}]},
         {"ProSe-Functionality",
          [{"Direct-discovery", 0},
           {"EPC-level-discovery", 1},
           {"Direct-communication", 2}]},
         {"ProSe-Range-Class",
          [{"Reserved", 0},
           {"50m", 1},
           {"100m", 2},
           {"200m", 3},
           {"500m", 4},
           {"1000m", 5}]},
         {"ProSe-Reason-For-Cancellation",
          [{"Proximity-Alert-sent", 0},
           {"Time-expired-with-no-renewal", 1},
           {"Requestor-cancellation", 2}]},
         {"ProSe-Role-Of-UE",
          [{"Announcing-UE", 0},
           {"Monitoring-UE", 1},
           {"Requestor-UE", 2},
           {"Requested-UE", 3}]},
         {"Proximity-Alert-Indication",
          [{"Alert", 0}, {"No-Alert", 1}]},
         {"PS-Append-Free-Format-Data",
          [{"Append", 0}, {"Overwrite", 1}]},
         {"Quota-Indicator",
          [{"QUOTA_IS_NOT_USED_DURING_PLAYBACK", 0},
           {"QUOTA_IS_USED_DURING_PLAYBACK", 1}]},
         {"Read-Reply-Report-Requested",
          [{"No", 0}, {"Yes", 1}]},
         {"Relationship-Mode",
          [{"trusted", 0}, {"non-trusted", 1}]},
         {"Reply-Path-Requested",
          [{"No-Reply-Path-Set", 0}, {"Reply-path-Set", 1}]},
         {"Reporting-Reason",
          [{"THRESHOLD", 0},
           {"QHT", 1},
           {"FINAL", 2},
           {"QUOTA_EXHAUSTED", 3},
           {"VALIDITY_TIME", 4},
           {"OTHER_QUOTA_TYPE", 5},
           {"RATING_CONDITION_CHANGE", 6},
           {"FORCED_REAUTHORISATION", 7},
           {"POOL_EXHAUSTED", 8},
           {"UNUSED_QUOTA_TIMER", 9}]},
         {"Role-Of-Node",
          [{"ORIGINATING_ROLE", 0},
           {"TERMINATING_ROLE", 1},
           {"FORWARDING_ROLE", 2}]},
         {"Role-Of-ProSe-Function",
          [{"HPLMN", 0}, {"VPLMN", 1}, {"Local-PLMN", 2}]},
         {"SDP-Type", [{"SDP-Offer", 0}, {"SDP-Answer", 1}]},
         {"Session-Direction",
          [{"inbound", 0}, {"outbound", 1}]},
         {"Serving-Node-Type",
          [{"SGSN", 0},
           {"PMIPSGW", 1},
           {"GTPSGW", 2},
           {"ePDG", 3},
           {"hSGW", 4},
           {"MME", 5},
           {"TWAN", 6}]},
         {"SGi-PtP-Tunnelling-Method",
          [{"UDP_IP_based", 0}, {"Others", 1}]},
         {"SGW-Change",
          [{"ACR_Start_NOT_due_to_SGW_Change", 0},
           {"ACR_Start_due_to_SGW_Change", 1}]},
         {"SM-Device-Trigger-Indicator",
          [{"Not-DeviceTrigger", 0},
           {"Device-Trigger-request", 1},
           {"Device-Trigger-replace", 2},
           {"Device-Trigger-recall", 3}]},
         {"SM-Message-Type",
          [{"SUBMISSION", 0},
           {"DELIVERY_REPORT", 1},
           {"SM-Service-Request", 2},
           {"T4-Device-Trigger", 3},
           {"SM-Device-Trigger", 4},
           {"MO-SMS-T4-submission", 5}]},
         {"SMS-Node",
          [{"SMS-Router", 0},
           {"IP-SM-GW", 1},
           {"SMS-Router-and-IP-SM-GW", 2},
           {"SMS-SC", 3}]},
         {"SM-Service-Type",
          [{"VAS4SMS-Short-Message-content-processing", 0},
           {"VAS4SMS-Short-Message-forwarding", 1},
           {"VAS4SMS-Short-Message-Forwarding-multiple-sub"
            "scriptions",
            2},
           {"VAS4SMS-Short-Message-filtering", 3},
           {"VAS4SMS-Short-Message-receipt", 4},
           {"VAS4SMS-Short-Message-Network-Storage", 5},
           {"VAS4SMS-Short-Message-to-multiple-destinations", 6},
           {"VAS4SMS-Short-Message-Virtual-Private-Network", 7},
           {"VAS4SMS-Short-Message-Auto-Reply", 8},
           {"VAS4SMS-Short-Message-Personal-Signature", 9},
           {"VAS4SMS-Short-Message-Deferred-Delivery", 10}]},
         {"Status-AS-Code",
          [{"4xx", 0}, {"5xx", 1}, {"Timeout", 2}]},
         {"Subscriber-Role",
          [{"Originating", 0}, {"Terminating", 1}]},
         {"TAD-Identifier", [{"CS", 0}, {"PS", 1}]},
         {"Time-Quota-Type",
          [{"DISCRETE_TIME_PERIOD", 0},
           {"CONTINUOUS_TIME_PERIOD", 1}]},
         {"Transcoder-Inserted-Indication",
          [{"Transcoder-Not-Inserted", 0},
           {"Transcoder-Inserted", 1}]},
         {"Trigger-Type",
          [{"CHANGE_IN_SGSN_IP_ADDRESS", 1},
           {"CHANGE_IN_QOS", 2},
           {"CHANGE_IN_LOCATION", 3},
           {"CHANGE_IN_RAT", 4},
           {"CHANGE_IN_UE_TIMEZONE", 5},
           {"CHANGEINQOS_TRAFFIC_CLASS", 10},
           {"CHANGEINQOS_RELIABILITY_CLASS", 11},
           {"CHANGEINQOS_DELAY_CLASS", 12},
           {"CHANGEINQOS_PEAK_THROUGHPUT", 13},
           {"CHANGEINQOS_PRECEDENCE_CLASS", 14},
           {"CHANGEINQOS_MEAN_THROUGHPUT", 15},
           {"CHANGEINQOS_MAXIMUM_BIT_RATE_FOR_UPLINK", 16},
           {"CHANGEINQOS_MAXIMUM_BIT_RATE_FOR_DOWNLINK", 17},
           {"CHANGEINQOS_RESIDUAL_BER", 18},
           {"CHANGEINQOS_SDU_ERROR_RATIO", 19},
           {"CHANGEINQOS_TRANSFER_DELAY", 20},
           {"CHANGEINQOS_TRAFFIC_HANDLING_PRIORITY", 21},
           {"CHANGEINQOS_GUARANTEED_BIT_RATE_FOR_UPLINK", 22},
           {"CHANGEINQOS_GUARANTEED_BIT_RATE_FOR_DOWNLINK", 23},
           {"CHANGEINQOS_APN_AGGREGATE_MAXIMUM_BIT_RATE", 24},
           {"CHANGEINLOCATION_MCC", 30},
           {"CHANGEINLOCATION_MNC", 31},
           {"CHANGEINLOCATION_RAC", 32},
           {"CHANGEINLOCATION_LAC", 33},
           {"CHANGEINLOCATION_CellId", 34},
           {"CHANGEINLOCATION_TAC", 35},
           {"CHANGEINLOCATION_ECGI", 36},
           {"CHANGE_IN_MEDIA_COMPOSITION", 40},
           {"CHANGE_IN_PARTICIPANTS_NMB", 50},
           {"CHANGE_IN_THRSHLD_OF_PARTICIPANTS_NMB", 51},
           {"CHANGE_IN_USER_PARTICIPATING_TYPE", 52},
           {"CHANGE_IN_SERVICE_CONDITION", 60},
           {"CHANGE_IN_SERVING_NODE", 61},
           {"CHANGE_IN_ACCESS_FOR_A_SERVICE_DATA_FLOW", 62},
           {"CHANGE_IN_USER_CSG_INFORMATION", 70},
           {"CHANGE_IN_HYBRID_SUBSCRIBED_USER_CSG_INFORMATION",
            71},
           {"CHANGE_IN_HYBRID_UNSUBSCRIBED_USER_CSG_INFORM"
            "ATION",
            72},
           {"CHANGE_OF_UE_PRESENCE_IN_PRESENCE_REPORTING_AREA",
            73},
           {"CHANGE_IN_APN_RATE_CONTROL", 75},
           {"CHANGE_IN_3GPP_PS_DATA_OFF", 76}]},
         {"UNI-PDU-CP-Only-Flag",
          [{"UNI-PDU-both-UP-CP", 0}, {"UNI-PDU-CP-Only", 1}]},
         {"User-Participating-Type",
          [{"Normal", 0}, {"NW-PoC-Box", 1}, {"UE-PoC-Box", 2}]},
         {"Variable-Part-Type",
          [{"Integer", 0},
           {"Number", 1},
           {"Time", 2},
           {"Date", 3},
           {"Currency", 4}]}]}]},
     {import_groups,
      [{diameter_3gpp_ts29_212,
        [{"Access-Network-Charging-Identifier-Gx",
          1022,
          [],
          [{"Access-Network-Charging-Identifier-Value"},
           {'*', ["Charging-Rule-Base-Name"]},
           {'*', ["Charging-Rule-Name"]},
           ["IP-CAN-Session-Charging-Scope"],
           {'*', ["AVP"]}]},
         {"Allocation-Retention-Priority",
          1034,
          [],
          [{"Priority-Level"},
           ["Pre-emption-Capability"],
           ["Pre-emption-Vulnerability"]]},
         {"Application-Detection-Information",
          1098,
          [],
          [{"TDF-Application-Identifier"},
           ["TDF-Application-Instance-Identifier"],
           {'*', ["Flow-Information"]},
           {'*', ["AVP"]}]},
         {"Charging-Rule-Definition",
          1003,
          [],
          [{"Charging-Rule-Name"},
           ["Service-Identifier"],
           ["Rating-Group"],
           {'*', ["Flow-Information"]},
           ["TDF-Application-Identifier"],
           ["Flow-Status"],
           ["QoS-Information"],
           ["PS-to-CS-Session-Continuity"],
           ["Reporting-Level"],
           ["Online"],
           ["Offline"],
           ["Metering-Method"],
           ["Precedence"],
           ["AF-Charging-Identifier"],
           {'*', ["Flows"]},
           ["Monitoring-Key"],
           ["Redirect-Information"],
           ["Mute-Notification"],
           ["AF-Signalling-Protocol"],
           ["Sponsor-Identity"],
           ["Application-Service-Provider-Identity"],
           {'*', ["Required-Access-Info"]},
           {'*', ["AVP"]}]},
         {"Charging-Rule-Install",
          1001,
          [],
          [{'*', ["Charging-Rule-Definition"]},
           {'*', ["Charging-Rule-Name"]},
           {'*', ["Charging-Rule-Base-Name"]},
           ["Bearer-Identifier"],
           ["Rule-Activation-Time"],
           ["Rule-Deactivation-Time"],
           ["Resource-Allocation-Notification"],
           ["Charging-Correlation-Indicator"],
           {'*', ["AVP"]}]},
         {"Charging-Rule-Remove",
          1002,
          [],
          [{'*', ["Charging-Rule-Name"]},
           {'*', ["Charging-Rule-Base-Name"]},
           {'*', ["Required-Access-Info"]},
           {'*', ["AVP"]}]},
         {"Charging-Rule-Report",
          1018,
          [],
          [{'*', ["Charging-Rule-Name"]},
           {'*', ["Charging-Rule-Base-Name"]},
           ["Bearer-Identifier"],
           ["PCC-Rule-Status"],
           ["Rule-Failure-Code"],
           ["Final-Unit-Indication"],
           {'*', ["RAN-NAS-Release-Cause"]},
           {'*', ["AVP"]}]},
         {"CoA-Information",
          1039,
          [],
          [{"Tunnel-Information"},
           {"CoA-IP-Address"},
           {'*', ["AVP"]}]},
         {"Conditional-APN-Aggregate-Max-Bitrate",
          2818,
          [],
          [["APN-Aggregate-Max-Bitrate-UL"],
           ["APN-Aggregate-Max-Bitrate-DL"],
           {'*', ["IP-CAN-Type"]},
           {'*', ["RAT-Type"]},
           {'*', ["AVP"]}]},
         {"Default-EPS-Bearer-QoS",
          1049,
          [],
          [["QoS-Class-Identifier"],
           ["Allocation-Retention-Priority"],
           {'*', ["AVP"]}]},
         {"Default-QoS-Information",
          2816,
          [],
          [["QoS-Class-Identifier"],
           ["Max-Requested-Bandwidth-UL"],
           ["Max-Requested-Bandwidth-DL"],
           ["Default-QoS-Name"],
           {'*', ["AVP"]}]},
         {"Event-Report-Indication",
          1033,
          [],
          [{'*', ["Event-Trigger"]},
           ["IP-CAN-Type"],
           {{0, 2}, ["AN-GW-Address"]},
           ["3GPP-SGSN-Address"],
           ["3GPP-SGSN-IPv6-Address"],
           ["3GPP-SGSN-MCC-MNC"],
           ["Framed-IP-Address"],
           ["RAT-Type"],
           ["RAI"],
           ["3GPP-User-Location-Info"],
           ["3GPP-MS-TimeZone"],
           ["Routing-IP-Address"],
           ["UE-Local-IP-Address"],
           ["HeNB-Local-IP-Address"],
           ["UDP-Source-Port"],
           ["Presence-Reporting-Area-Information"],
           {'*', ["AVP"]}]},
         {"Fixed-User-Location-Info",
          2825,
          [],
          [["Logical-Access-ID"],
           ["Physical-Access-ID"],
           {'*', ["AVP"]}]},
         {"Flow-Information",
          1058,
          [],
          [["Flow-Description"],
           ["Packet-Filter-Identifier"],
           ["Packet-Filter-Usage"],
           ["ToS-Traffic-Class"],
           ["Security-Parameter-Index"],
           ["Flow-Label"],
           ["Flow-Direction"],
           {'*', ["AVP"]}]},
         {"Packet-Filter-Information",
          1061,
          [],
          [["Packet-Filter-Identifier"],
           ["Precedence"],
           ["Packet-Filter-Content"],
           ["ToS-Traffic-Class"],
           ["Security-Parameter-Index"],
           ["Flow-Label"],
           ["Flow-Direction"],
           {'*', ["AVP"]}]},
         {"Presence-Reporting-Area-Information",
          2822,
          [],
          [["Presence-Reporting-Area-Identifier"],
           ["Presence-Reporting-Area-Status"],
           ["Presence-Reporting-Area-Elements-List"],
           {'*', ["AVP"]}]},
         {"QoS-Information",
          1016,
          [],
          [["QoS-Class-Identifier"],
           ["Max-Requested-Bandwidth-UL"],
           ["Max-Requested-Bandwidth-DL"],
           ["Guaranteed-Bitrate-UL"],
           ["Guaranteed-Bitrate-DL"],
           ["Bearer-Identifier"],
           ["Allocation-Retention-Priority"],
           ["APN-Aggregate-Max-Bitrate-UL"],
           ["APN-Aggregate-Max-Bitrate-DL"],
           {'*', ["Conditional-APN-Aggregate-Max-Bitrate"]},
           {'*', ["AVP"]}]},
         {"Redirect-Information",
          1085,
          [],
          [["Redirect-Support"],
           ["Redirect-Address-Type"],
           ["Redirect-Server-Address"],
           {'*', ["AVP"]}]},
         {"Routing-Filter",
          1078,
          [],
          [{"Flow-Description"},
           {"Flow-Direction"},
           ["ToS-Traffic-Class"],
           ["Security-Parameter-Index"],
           ["Flow-Label"],
           {'*', ["AVP"]}]},
         {"Routing-Rule-Definition",
          1076,
          [],
          [{"Routing-Rule-Identifier"},
           {'*', ["Routing-Filter"]},
           ["Precedence"],
           ["Routing-IP-Address"],
           {'*', ["AVP"]}]},
         {"Routing-Rule-Install",
          1081,
          [],
          [{'*', ["Routing-Rule-Definition"]}, {'*', ["AVP"]}]},
         {"Routing-Rule-Remove",
          1075,
          [],
          [{'*', ["Routing-Rule-Identifier"]}, {'*', ["AVP"]}]},
         {"TDF-Information",
          1087,
          [],
          [["TDF-Destination-Realm"],
           ["TDF-Destination-Host"],
           ["TDF-IP-Address"]]},
         {"Tunnel-Information",
          1038,
          [],
          [["Tunnel-Header-Length"],
           {{0, 2}, ["Tunnel-Header-Filter"]},
           {'*', ["AVP"]}]},
         {"TFT-Packet-Filter-Information",
          1013,
          [],
          [["Precedence"],
           ["TFT-Filter"],
           ["ToS-Traffic-Class"],
           ["Security-Parameter-Index"],
           ["Flow-Label"],
           ["Flow-Direction"],
           {'*', ["AVP"]}]},
         {"Usage-Monitoring-Information",
          1067,
          [],
          [["Monitoring-Key"],
           {{0, 2}, ["Granted-Service-Unit"]},
           {{0, 2}, ["Used-Service-Unit"]},
           ["Usage-Monitoring-Level"],
           ["Usage-Monitoring-Report"],
           ["Usage-Monitoring-Support"],
           {'*', ["AVP"]}]}]},
       {diameter_3gpp_ts32_299,
        [{"Access-Network-Info-Change",
          4401,
          [],
          [{'*', ["Access-Network-Information"]},
           ["Cellular-Network-Information"],
           ["Change-Time"]]},
         {"Access-Transfer-Information",
          2709,
          [],
          [["Access-Transfer-Type"],
           {'*', ["Access-Network-Information"]},
           ["Cellular-Network-Information"],
           ["Inter-UE-Transfer"],
           ["User-Equipment-Info"],
           ["Instance-Id"],
           ["Related-IMS-Charging-Identifier"],
           ["Related-IMS-Charging-Identifier-Node"],
           ["Change-Time"]]},
         {"Accumulated-Cost",
          2052,
          [],
          [{"Value-Digits"}, ["Exponent"]]},
         {"Additional-Content-Information",
          1207,
          [],
          [["Type-Number"],
           ["Additional-Type-Information"],
           ["Content-Size"]]},
         {"Address-Domain",
          898,
          [],
          [["Domain-Name"], ["3GPP-IMSI-MCC-MNC"]]},
         {"AF-Correlation-Information",
          1276,
          [],
          [{"AF-Charging-Identifier"}, {'*', ["Flows"]}]},
         {"Announcement-Information",
          3904,
          [],
          [{"Announcement-Identifier"},
           {'*', ["Variable-Part"]},
           ["Time-Indicator"],
           ["Quota-Indicator"],
           ["Announcement-Order"],
           ["Play-Alternative"],
           ["Privacy-Indicator"],
           ["Language"]]},
         {"AoC-Cost-Information",
          2053,
          [],
          [["Accumulated-Cost"],
           {'*', ["Incremental-Cost"]},
           ["Currency-Code"]]},
         {"AoC-Information",
          2054,
          [],
          [["AoC-Cost-Information"],
           ["Tariff-Information"],
           ["AoC-Subscription-Information"]]},
         {"AoC-Service",
          2311,
          [],
          [["AoC-Service-Obligatory-Type"],
           ["AoC-Service-Type"]]},
         {"AoC-Subscription-Information",
          2314,
          [],
          [{'*', ["AoC-Service"]},
           ["AoC-Format"],
           ["Preferred-AoC-Currency"]]},
         {"APN-Rate-Control",
          3933,
          [],
          [["APN-Rate-Control-Uplink"],
           ["APN-Rate-Control-Downlink"]]},
         {"APN-Rate-Control-Downlink",
          3934,
          [],
          [["Rate-Control-Time-Unit"],
           ["Rate-Control-Max-Rate"],
           ["Rate-Control-Max-Message-Size"]]},
         {"APN-Rate-Control-Uplink",
          3935,
          [],
          [["Additional-Exception-Reports"],
           ["Rate-Control-Time-Unit"],
           ["Rate-Control-Max-Rate"]]},
         {"Application-Server-Information",
          850,
          [],
          [["Application-Server"],
           {'*', ["Application-Provided-Called-Party-Address"]},
           ["Status-AS-Code"]]},
         {"Basic-Service-Code",
          3411,
          [],
          [["Bearer-Service"], ["Teleservice"]]},
         {"Called-Identity-Change",
          3917,
          [],
          [["Called-Identity"], ["Change-Time"]]},
         {"Coverage-Info",
          3459,
          [],
          [["Coverage-Status"],
           ["Change-Time"],
           {'*', ["Location-Info"]}]},
         {"CPDT-Information",
          3927,
          [],
          [["Serving-Node-Identity"],
           ["SGW-Change"],
           ["NIDD-Submission"]]},
         {"Current-Tariff",
          2056,
          [],
          [["Currency-Code"],
           ["Scale-Factor"],
           {'*', ["Rate-Element"]}]},
         {"Destination-Interface",
          2002,
          [],
          [["Interface-Id"],
           ["Interface-Text"],
           ["Interface-Port"],
           ["Interface-Type"]]},
         {"Early-Media-Description",
          1272,
          [],
          [["SDP-TimeStamps"],
           {'*', ["SDP-Media-Component"]},
           {'*', ["SDP-Session-Description"]}]},
         {"Enhanced-Diagnostics",
          3901,
          [],
          [{'*', ["RAN-NAS-Release-Cause"]}]},
         {"Envelope",
          1266,
          [],
          [{"Envelope-Start-Time"},
           ["Envelope-End-Time"],
           ["CC-Total-Octets"],
           ["CC-Input-Octets"],
           ["CC-Output-Octets"],
           ["CC-Service-Specific-Units"]]},
         {"Event-Type",
          823,
          [],
          [["SIP-Method"], ["Event"], ["Expires"]]},
         {"Incremental-Cost",
          2062,
          [],
          [{"Value-Digits"}, ["Exponent"]]},
         {"IMS-Information",
          876,
          [],
          [{"Node-Functionality"},
           ["Event-Type"],
           ["Role-Of-Node"],
           ["User-Session-Id"],
           ["Outgoing-Session-Id"],
           ["Session-Priority"],
           {'*', ["Calling-Party-Address"]},
           ["Called-Party-Address"],
           {'*', ["Called-Asserted-Identity"]},
           ["Called-Identity-Change"],
           ["Number-Portability-Routing-Information"],
           ["Carrier-Select-Routing-Information"],
           ["Alternate-Charged-Party-Address"],
           {'*', ["Requested-Party-Address"]},
           {'*', ["Associated-URI"]},
           ["Time-Stamps"],
           {'*', ["Application-Server-Information"]},
           {'*', ["Inter-Operator-Identifier"]},
           {'*', ["Transit-IOI-List"]},
           ["IMS-Charging-Identifier"],
           {'*', ["SDP-Session-Description"]},
           {'*', ["SDP-Media-Component"]},
           ["Served-Party-IP-Address"],
           ["Trunk-Group-Id"],
           ["Bearer-Service"],
           ["Service-Id"],
           {'*', ["Service-Specific-Info"]},
           {'*', ["Message-Body"]},
           ["Cause-Code"],
           {'*', ["Reason-Header"]},
           {'*', ["Access-Network-Information"]},
           ["Cellular-Network-Information"],
           {'*', ["Early-Media-Description"]},
           ["IMS-Communication-Service-Identifier"],
           ["IMS-Application-Reference-Identifier"],
           ["Online-Charging-Flag"],
           ["Real-Time-Tariff-Information"],
           ["Account-Expiration"],
           ["Initial-IMS-Charging-Identifier"],
           {'*', ["NNI-Information"]},
           ["From-Address"],
           ["IMS-Emergency-Indicator"],
           ["IMS-Visited-Network-Identifier"],
           {'*', ["Access-Network-Info-Change"]},
           {'*', ["Access-Transfer-Information"]},
           ["Related-IMS-Charging-Identifier"],
           ["Related-IMS-Charging-Identifier-Node"],
           ["Route-Header-Received"],
           ["Route-Header-Transmitted"],
           ["Instance-Id"],
           ["TAD-Identifier"],
           ["FE-Identifier-List"]]},
         {"Inter-Operator-Identifier",
          838,
          [],
          [["Originating-IOI"], ["Terminating-IOI"]]},
         {"ISUP-Cause",
          3416,
          [],
          [["ISUP-Cause-Location"],
           ["ISUP-Cause-Value"],
           ["ISUP-Cause-Diagnostics"]]},
         {"LCS-Client-ID",
          1232,
          [],
          [["LCS-Client-Type"],
           ["LCS-Client-External-ID"],
           ["LCS-Client-Dialed-By-MS"],
           ["LCS-Client-Name"],
           ["LCS-APN"],
           ["LCS-Requestor-ID"]]},
         {"LCS-Client-Name",
          1235,
          [],
          [["LCS-Data-Coding-Scheme"],
           ["LCS-Name-String"],
           ["LCS-Format-Indicator"]]},
         {"LCS-Information",
          878,
          [],
          [["LCS-Client-ID"],
           ["Location-Type"],
           ["Location-Estimate"],
           ["Positioning-Data"],
           ["3GPP-IMSI"],
           ["MSISDN"]]},
         {"LCS-Requestor-ID",
          1239,
          [],
          [["LCS-Data-Coding-Scheme"],
           ["LCS-Requestor-ID-String"]]},
         {"Location-Info",
          3460,
          [],
          [["3GPP-User-Location-Info"], ["Change-Time"]]},
         {"Location-Type",
          1244,
          [],
          [["Location-Estimate-Type"],
           ["Deferred-Location-Event-Type"]]},
         {"MBMS-Information",
          880,
          [],
          [["TMGI"],
           ["MBMS-User-Service-Type"],
           ["File-Repair-Supported"],
           ["MBMS-2G-3G-Indicator"],
           {'*', ["MBMS-Service-Area"]},
           ["MBMS-Session-Identity"],
           ["CN-IP-Multicast-Distribution"],
           ["MBMS-GW-Address"],
           ["MBMS-Charged-Party"],
           {'*', ["MSISDN"]}]},
         {"Message-Body",
          889,
          [],
          [{"Content-Type"},
           {"Content-Length"},
           ["Content-Disposition"],
           ["Originator"]]},
         {"Message-Class",
          1213,
          [],
          [["Class-Identifier"], ["Token-Text"]]},
         {"MM-Content-Type",
          1203,
          [],
          [["Type-Number"],
           ["Additional-Type-Information"],
           ["Content-Size"],
           {'*', ["Additional-Content-Information"]}]},
         {"MMS-Information",
          877,
          [],
          [["Originator-Address"],
           {'*', ["Recipient-Address"]},
           ["Submission-Time"],
           ["MM-Content-Type"],
           ["Priority"],
           ["Message-ID"],
           ["Message-Type"],
           ["Message-Size"],
           ["Message-Class"],
           ["Delivery-Report-Requested"],
           ["Read-Reply-Report-Requested"],
           ["MMBox-Storage-Requested"],
           ["Applic-ID"],
           ["Reply-Applic-ID"],
           ["Aux-Applic-Info"],
           ["Content-Class"],
           ["DRM-Content"],
           ["Adaptations"]]},
         {"MMTel-Information",
          2030,
          [],
          [{'*', ["Supplementary-Service"]}]},
         {"Monitoring-Event-Information",
          3921,
          [],
          [["Monitoring-Event-Functionality"],
           ["Event-Timestamp"],
           ["Monitoring-Event-Configuration-Activity"],
           ["Charged-Party"],
           {'*', ["Monitoring-Event-Report-Data"]}]},
         {"Monitoring-Event-Report-Data",
          3920,
          [],
          [["Event-Timestamp"],
           ["Monitoring-Event-Report-Number"],
           ["Charged-Party"],
           ["Subscription-Id"]]},
         {"Next-Tariff",
          2057,
          [],
          [["Currency-Code"],
           ["Scale-Factor"],
           {'*', ["Rate-Element"]}]},
         {"NIDD-Submission",
          3928,
          [],
          [["Submission-Time"],
           ["Event-Timestamp"],
           ["Accounting-Input-Octets"],
           ["Accounting-Output-Octets"],
           ["Change-Condition"]]},
         {"NNI-Information",
          2703,
          [],
          [["Session-Direction"],
           ["NNI-Type"],
           ["Relationship-Mode"],
           ["Neighbour-Node-Address"]]},
         {"Offline-Charging",
          1278,
          [],
          [["Quota-Consumption-Time"],
           ["Time-Quota-Mechanism"],
           ["Envelope-Reporting"],
           {'*', ["Multiple-Services-Credit-Control"]},
           {'*', ["AVP"]}]},
         {"Originator-Address",
          886,
          [],
          [["Address-Type"],
           ["Address-Data"],
           ["Address-Domain"]]},
         {"Originator-Interface",
          2009,
          [],
          [["Interface-Id"],
           ["Interface-Text"],
           ["Interface-Port"],
           ["Interface-Type"]]},
         {"Originator-Received-Address",
          2027,
          [],
          [["Address-Type"],
           ["Address-Data"],
           ["Address-Domain"]]},
         {"Participant-Group",
          1260,
          [],
          [["Called-Party-Address"],
           ["Participant-Access-Priority"],
           ["User-Participating-Type"]]},
         {"PoC-Information",
          879,
          [],
          [["PoC-Server-Role"],
           ["PoC-Session-Type"],
           ["PoC-User-Role"],
           ["PoC-Session-Initiation-Type"],
           ["PoC-Event-Type"],
           ["Number-Of-Participants"],
           {'*', ["Participants-Involved"]},
           {'*', ["Participant-Group"]},
           {'*', ["Talk-Burst-Exchange"]},
           ["PoC-Controlling-Address"],
           ["PoC-Group-Name"],
           ["PoC-Session-Id"],
           ["Charged-Party"]]},
         {"PoC-User-Role",
          1252,
          [],
          [["PoC-User-Role-IDs"], ["PoC-User-Role-Info-Units"]]},
         {"ProSe-Direct-Communication-Reception-Data-Con"
          "tainer",
          3461,
          [],
          [["Local-Sequence-Number"],
           ["Coverage-Status"],
           ["3GPP-User-Location-Info"],
           ["Accounting-Input-Octets"],
           ["Change-Time"],
           ["Change-Condition"],
           ["Usage-Information-Report-Sequence-Number"],
           ["Radio-Resources-Indicator"],
           ["Radio-Frequency"]]},
         {"ProSe-Direct-Communication-Transmission-Data-"
          "Container",
          3441,
          [],
          [["Local-Sequence-Number"],
           ["Coverage-Status"],
           ["3GPP-User-Location-Info"],
           ["Accounting-Output-Octets"],
           ["Change-Time"],
           ["Change-Condition"],
           ["Usage-Information-Report-Sequence-Number"],
           ["Radio-Resources-Indicator"],
           ["Radio-Frequency"]]},
         {"ProSe-Information",
          3447,
          [],
          [["Announcing-UE-HPLMN-Identifier"],
           ["Announcing-UE-VPLMN-Identifier"],
           ["Monitoring-UE-HPLMN-Identifier"],
           ["Monitoring-UE-VPLMN-Identifier"],
           ["Role-Of-ProSe-Function"],
           ["ProSe-3rd-Party-Application-ID"],
           ["Application-Specific-Data"],
           ["ProSe-Event-Type"],
           ["ProSe-Direct-Discovery-Model"],
           ["ProSe-Function-IP-Address"],
           ["ProSe-Role-Of-UE"],
           ["ProSe-Request-Timestamp"],
           ["PC3-Control-Protocol-Cause"],
           ["Monitoring-UE-Identifier"],
           ["Requestor-PLMN-Identifier"],
           ["Requested-PLMN-Identifier"],
           ["ProSe-Range-Class"],
           ["Proximity-Alert-Indication"],
           ["Proximity-Alert-Timestamp"],
           ["Proximity-Cancellation-Timestamp"],
           ["ProSe-Reason-For-Cancellation"],
           ["PC3-EPC-Control-Protocol-Cause"],
           ["ProSe-UE-ID"],
           ["ProSe-Source-IP-Address"],
           ["Layer-2-Group-ID"],
           ["ProSe-Group-IP-Multicast-Address"],
           {'*', ["Coverage-Info"]},
           {'*', ["Radio-Parameter-Set-Info"]},
           {'*', ["Transmitter-Info"]},
           ["Time-First-Transmission"],
           ["Time-First-Reception"],
           {'*',
            ["ProSe-Direct-Communication-Transmission-Data-"
             "Container"]},
           {'*',
            ["ProSe-Direct-Communication-Reception-Data-Con"
             "tainer"]},
           ["Announcing-PLMN-ID"],
           ["ProSe-Target-Layer-2-ID"],
           ["Relay-IP-address"],
           ["ProSe-UE-to-Network-Relay-UE-ID"],
           ["Target-IP-Address"],
           ["PC5-Radio-Technology"]]},
         {"PS-Furnish-Charging-Information",
          865,
          [],
          [{"3GPP-Charging-Id"},
           {"PS-Free-Format-Data"},
           ["PS-Append-Free-Format-Data"]]},
         {"PS-Information",
          874,
          [],
          [["3GPP-Charging-Id"],
           ["PDN-Connection-Charging-ID"],
           ["Node-Id"],
           ["3GPP-PDP-Type"],
           {'*', ["PDP-Address"]},
           ["PDP-Address-Prefix-Length"],
           ["Dynamic-Address-Flag"],
           ["Dynamic-Address-Flag-Extension"],
           ["QoS-Information"],
           {'*', ["SGSN-Address"]},
           {'*', ["GGSN-Address"]},
           {'*', ["TDF-IP-Address"]},
           {'*', ["SGW-Address"]},
           {'*', ["TWAG-Address"]},
           ["CG-Address"],
           ["Serving-Node-Type"],
           ["SGW-Change"],
           ["3GPP-IMSI-MCC-MNC"],
           ["IMSI-Unauthenticated-Flag"],
           ["3GPP-GGSN-MCC-MNC"],
           ["3GPP-NSAPI"],
           ["Called-Station-Id"],
           ["3GPP-Session-Stop-Indicator"],
           ["3GPP-Selection-Mode"],
           ["3GPP-Charging-Characteristics"],
           ["Charging-Characteristics-Selection-Mode"],
           ["3GPP-SGSN-MCC-MNC"],
           ["3GPP-MS-TimeZone"],
           ["Charging-Rule-Base-Name"],
           ["3GPP-User-Location-Info"],
           ["User-Location-Info-Time"],
           ["User-CSG-Information"],
           {'*', ["Presence-Reporting-Area-Information"]},
           ["TWAN-User-Location-Info"],
           ["UWAN-User-Location-Info"],
           ["3GPP-RAT-Type"],
           ["PS-Furnish-Charging-Information"],
           ["PDP-Context-Type"],
           ["Offline-Charging"],
           {'*', ["Traffic-Data-Volumes"]},
           {'*', ["Service-Data-Container"]},
           ["User-Equipment-Info"],
           ["Start-Time"],
           ["Stop-Time"],
           ["Change-Condition"],
           ["Diagnostics"],
           ["Low-Priority-Indicator"],
           ["Logical-Access-ID"],
           ["Physical-Access-ID"],
           ["Fixed-User-Location-Info"],
           ["CN-Operator-Selection-Entity"],
           ["Enhanced-Diagnostics"],
           ["SGi-PtP-Tunnelling-Method"],
           ["CP-CIoT-EPS-Optimisation-Indicator"],
           ["UNI-PDU-CP-Only-Flag"],
           ["APN-Rate-Control"],
           ["Charging-Per-IP-CAN-Session-Indicator"],
           ["3GPP-PS-Data-Off-Status"],
           ["SCS-AS-Address"],
           ["Unused-Quota-Timer"],
           {'*', ["RAN-Secondary-RAT-Usage-Report"]},
           {'*', ["AVP"]}]},
         {"Radio-Parameter-Set-Info",
          3463,
          [],
          [["Radio-Parameter-Set-Values"], ["Change-Time"]]},
         {"RAN-Secondary-RAT-Usage-Report",
          1302,
          [],
          [["Secondary-RAT-Type"],
           ["RAN-Start-Timestamp"],
           ["RAN-End-Timestamp"],
           ["Accounting-Input-Octets"],
           ["Accounting-Output-Octets"],
           ["3GPP-Charging-Id"]]},
         {"Rate-Element",
          2058,
          [],
          [{"CC-Unit-Type"},
           ["Charge-Reason-Code"],
           ["Unit-Value"],
           ["Unit-Cost"],
           ["Unit-Quota-Threshold"]]},
         {"Real-Time-Tariff-Information",
          2305,
          [],
          [["Tariff-Information"], ["Tariff-XML"]]},
         {"Recipient-Address",
          1201,
          [],
          [["Address-Type"],
           ["Address-Data"],
           ["Address-Domain"],
           ["Addressee-Type"]]},
         {"Recipient-Info",
          2026,
          [],
          [["Destination-Interface"],
           {'*', ["Recipient-Address"]},
           {'*', ["Recipient-Received-Address"]},
           ["Recipient-SCCP-Address"],
           ["SM-Protocol-ID"]]},
         {"Recipient-Received-Address",
          2028,
          [],
          [["Address-Type"],
           ["Address-Data"],
           ["Address-Domain"]]},
         {"Related-Change-Condition-Information",
          3925,
          [],
          [["SGSN-Address"],
           {'*', ["Change-Condition"]},
           ["3GPP-User-Location-Info"],
           ["UWAN-User-Location-Info"],
           ["Presence-Reporting-Area-Status"],
           ["User-CSG-Information"],
           ["3GPP-RAT-Type"]]},
         {"Related-Trigger",
          3926,
          [],
          [{'*', ["Trigger-Type"]}]},
         {"Remaining-Balance",
          2021,
          [],
          [{"Unit-Value"}, {"Currency-Code"}]},
         {"Scale-Factor",
          2059,
          [],
          [{"Value-Digits"}, ["Exponent"]]},
         {"SCS-AS-Address",
          3940,
          [],
          [["SCS-Realm"], ["SCS-Address"]]},
         {"SDP-Media-Component",
          843,
          [],
          [["SDP-Media-Name"],
           {'*', ["SDP-Media-Description"]},
           ["Local-GW-Inserted-Indication"],
           ["IP-Realm-Default-Indication"],
           ["Transcoder-Inserted-Indication"],
           ["Media-Initiator-Flag"],
           ["Media-Initiator-Party"],
           ["3GPP-Charging-Id"],
           ["Access-Network-Charging-Identifier-Value"],
           ["SDP-Type"]]},
         {"SDP-TimeStamps",
          1273,
          [],
          [["SDP-Offer-Timestamp"], ["SDP-Answer-Timestamp"]]},
         {"Service-Data-Container",
          2040,
          [],
          [["AF-Correlation-Information"],
           ["Charging-Rule-Base-Name"],
           ["Accounting-Input-Octets"],
           ["Accounting-Output-Octets"],
           ["Local-Sequence-Number"],
           ["QoS-Information"],
           ["Rating-Group"],
           ["Change-Time"],
           ["Service-Identifier"],
           ["Service-Specific-Info"],
           ["SGSN-Address"],
           ["Time-First-Usage"],
           ["Time-Last-Usage"],
           ["Time-Usage"],
           {'*', ["Change-Condition"]},
           ["3GPP-User-Location-Info"],
           ["UWAN-User-Location-Info"],
           ["Sponsor-Identity"],
           ["Application-Service-Provider-Identity"],
           {'*', ["Presence-Reporting-Area-Information"]},
           ["Presence-Reporting-Area-Status"],
           ["User-CSG-Information"],
           ["3GPP-RAT-Type"],
           ["Related-Change-Condition-Information"],
           ["APN-Rate-Control"],
           ["3GPP-PS-Data-Off-Status"]]},
         {"Service-Specific-Info",
          1249,
          [],
          [["Service-Specific-Data"], ["Service-Specific-Type"]]},
         {"SM-Device-Trigger-Information",
          3405,
          [],
          [["MTC-IWF-Address"], ["Validity-Time"]]},
         {"SMS-Information",
          2000,
          [],
          [["SMS-Node"],
           ["Client-Address"],
           ["Originator-SCCP-Address"],
           ["SMSC-Address"],
           ["Data-Coding-Scheme"],
           ["SM-Discharge-Time"],
           ["SM-Message-Type"],
           ["Originator-Interface"],
           ["SM-Protocol-ID"],
           ["Reply-Path-Requested"],
           ["SM-Status"],
           ["SM-User-Data-Header"],
           ["Number-Of-Messages-Sent"],
           ["SM-Sequence-Number"],
           {'*', ["Recipient-Info"]},
           ["Originator-Received-Address"],
           ["SM-Service-Type"],
           ["SMS-Result"],
           ["SM-Device-Trigger-Indicator"],
           ["SM-Device-Trigger-Information"],
           ["MTC-IWF-Address"]]},
         {"Supplementary-Service",
          2048,
          [],
          [["MMTel-SService-Type"],
           ["Service-Mode"],
           ["Number-Of-Diversions"],
           ["Associated-Party-Address"],
           ["Service-Id"],
           ["Change-Time"],
           ["Number-Of-Participants"],
           ["Participant-Action-Type"],
           ["CUG-Information"],
           ["AoC-Information"]]},
         {"Talk-Burst-Exchange",
          1255,
          [],
          [{"PoC-Change-Time"},
           ["Number-Of-Talk-Bursts"],
           ["Talk-Burst-Volume"],
           ["Talk-Burst-Time"],
           ["Number-Of-Received-Talk-Bursts"],
           ["Received-Talk-Burst-Volume"],
           ["Received-Talk-Burst-Time"],
           ["Number-Of-Participants"],
           ["PoC-Change-Condition"]]},
         {"Tariff-Information",
          2060,
          [],
          [{"Current-Tariff"},
           ["Tariff-Time-Change"],
           ["Next-Tariff"]]},
         {"Time-Quota-Mechanism",
          1270,
          [],
          [{"Time-Quota-Type"}, {"Base-Time-Interval"}]},
         {"Time-Stamps",
          833,
          [],
          [["SIP-Request-Timestamp"],
           ["SIP-Response-Timestamp"],
           ["SIP-Request-Timestamp-Fraction"],
           ["SIP-Response-Timestamp-Fraction"]]},
         {"Traffic-Data-Volumes",
          2046,
          [],
          [["QoS-Information"],
           ["Accounting-Input-Octets"],
           ["Accounting-Output-Octets"],
           ["Change-Condition"],
           ["Change-Time"],
           ["3GPP-User-Location-Info"],
           ["UWAN-User-Location-Info"],
           ["3GPP-Charging-Id"],
           ["Presence-Reporting-Area-Status"],
           ["User-CSG-Information"],
           ["3GPP-RAT-Type"],
           ["Related-Change-Condition-Information"],
           ["Diagnostics"],
           ["Enhanced-Diagnostics"],
           ["CP-CIoT-EPS-Optimisation-Indicator"]]},
         {"Transmitter-Info",
          3468,
          [],
          [["ProSe-Source-IP-Address"], ["ProSe-UE-ID"]]},
         {"Trigger", 1264, [], [{'*', ["Trigger-Type"]}]},
         {"Trunk-Group-Id",
          851,
          [],
          [["Incoming-Trunk-Group-Id"],
           ["Outgoing-Trunk-Group-Id"]]},
         {"TWAN-User-Location-Info", 2714, [], [["BSSID"]]},
         {"Unit-Cost",
          2061,
          [],
          [{"Value-Digits"}, ["Exponent"]]},
         {"User-CSG-Information",
          2319,
          [],
          [{"CSG-Access-Mode"}, ["CSG-Membership-Indication"]]},
         {"UWAN-User-Location-Info",
          3918,
          [],
          [{"UE-Local-IP-Address"},
           ["UDP-Source-Port"],
           ["BSSID"]]},
         {"Variable-Part",
          3907,
          [],
          [{"Variable-Part-Type"},
           {"Variable-Part-Value"},
           ["Variable-Part-Order"]]},
         {"VCS-Information",
          3410,
          [],
          [["Bearer-Capability"],
           ["Network-Call-Reference-Number"],
           ["MSC-Address"],
           ["Basic-Service-Code"],
           ["ISUP-Location-Number"],
           ["VLR-Number"],
           ["Forwarding-Pending"],
           ["ISUP-Cause"],
           ["Start-Time"],
           ["Start-of-Charging"],
           ["Stop-Time"],
           ["PS-Free-Format-Data"]]}]}]},
     {inherits,
      [{"diameter_3gpp_ts32_299", []},
       {"diameter_3gpp_ts29_212", []},
       {"diameter_3gpp_base", []}]},
     {messages, []},
     {name, "diameter_travelping"},
     {prefix, "diameter_travelping"},
     {vendor, {18681, "Travelping"}}].


