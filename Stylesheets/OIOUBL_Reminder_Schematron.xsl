<?xml version="1.0" encoding="UTF-16" standalone="yes"?>
<xsl:stylesheet doc:dummy-for-xmlns="" cac:dummy-for-xmlns="" cbc:dummy-for-xmlns="" ccts:dummy-for-xmlns="" sdt:dummy-for-xmlns="" udt:dummy-for-xmlns="" ext:dummy-for-xmlns="" xs:dummy-for-xmlns="" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:Reminder-2" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" xmlns:xs="http://www.w3.org/2001/XMLSchema">
<!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. The name or details of 
    this mode may change during 1Q 2007.-->


<!--PHASES-->


<!--PROLOG-->
<xsl:output method="xml" encoding="utf-8" />

<!--KEYS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path">
<xsl:apply-templates select="parent::*" mode="schematron-get-full-path" />
<xsl:text>/</xsl:text>
<xsl:choose>
<xsl:when test="namespace-uri()=''"><xsl:value-of select="name()" /></xsl:when>
<xsl:otherwise>
<xsl:text>*:</xsl:text>
<xsl:value-of select="local-name()" />
<xsl:text>[namespace-uri()='</xsl:text>
<xsl:value-of select="namespace-uri()" />
<xsl:text>']</xsl:text>
</xsl:otherwise>
</xsl:choose>
<xsl:variable name="preceding" select="count(preceding-sibling::*[local-name()=local-name(current())&#xA;	  		                             and namespace-uri() = namespace-uri(current())])" />
<xsl:text>[</xsl:text>
<xsl:value-of select="1+ $preceding" />
<xsl:text>]</xsl:text>
</xsl:template>
<xsl:template match="@*" mode="schematron-get-full-path">
<xsl:apply-templates select="parent::*" mode="schematron-get-full-path" />
<xsl:text>/</xsl:text>
<xsl:choose>
<xsl:when test="namespace-uri()=''">@sch:schema</xsl:when>
<xsl:otherwise>
<xsl:text>@*[local-name()='</xsl:text>
<xsl:value-of select="local-name()" />
<xsl:text>' and namespace-uri()='</xsl:text>
<xsl:value-of select="namespace-uri()" />
<xsl:text>']</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2">
<xsl:for-each select="ancestor-or-self::*">
<xsl:text>/</xsl:text>
<xsl:value-of select="name(.)" />
<xsl:if test="preceding-sibling::*[name(.)=name(current())]">
<xsl:text>[</xsl:text>
<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />
<xsl:text>]</xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:if test="not(self::*)">
<xsl:text />/@<xsl:value-of select="name(.)" />
</xsl:if>
</xsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path" />
<xsl:template match="text()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')" />
</xsl:template>
<xsl:template match="comment()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')" />
</xsl:template>
<xsl:template match="processing-instruction()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')" />
</xsl:template>
<xsl:template match="@*" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.@', name())" />
</xsl:template>
<xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:text>.</xsl:text>
<xsl:choose>
<xsl:when test="count(. | ../namespace::*) = count(../namespace::*)">
<xsl:value-of select="concat('.namespace::-',1+count(namespace::*),'-')" />
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template>
<xsl:template match="*" mode="generate-id-2" priority="2">
<xsl:text>U</xsl:text>
<xsl:number level="multiple" count="*" />
</xsl:template>
<xsl:template match="node()" mode="generate-id-2">
<xsl:text>U.</xsl:text>
<xsl:number level="multiple" count="*" />
<xsl:text>n</xsl:text>
<xsl:number count="node()" />
</xsl:template>
<xsl:template match="@*" mode="generate-id-2">
<xsl:text>U.</xsl:text>
<xsl:number level="multiple" count="*" />
<xsl:text>_</xsl:text>
<xsl:value-of select="string-length(local-name(.))" />
<xsl:text>_</xsl:text>
<xsl:value-of select="translate(name(),':','.')" />
</xsl:template>
<!--Strip characters-->
<xsl:template match="text()" priority="-1" />

<!--SCHEMA METADATA-->
<xsl:template match="/"><Schematron>
<Information>Checking OIOUBL-2.02 Reminder, 2018-09-15, Version 1.10.0.35220</Information>
<xsl:apply-templates select="/" mode="M10" /><xsl:apply-templates select="/" mode="M12" /><xsl:apply-templates select="/" mode="M13" /><xsl:apply-templates select="/" mode="M14" /><xsl:apply-templates select="/" mode="M15" /><xsl:apply-templates select="/" mode="M16" /><xsl:apply-templates select="/" mode="M17" /><xsl:apply-templates select="/" mode="M18" /><xsl:apply-templates select="/" mode="M19" /><xsl:apply-templates select="/" mode="M20" /><xsl:apply-templates select="/" mode="M21" /><xsl:apply-templates select="/" mode="M22" /><xsl:apply-templates select="/" mode="M23" /><xsl:apply-templates select="/" mode="M24" /><xsl:apply-templates select="/" mode="M25" /><xsl:apply-templates select="/" mode="M27" /><xsl:apply-templates select="/" mode="M28" /><xsl:apply-templates select="/" mode="M29" /><xsl:apply-templates select="/" mode="M30" /><xsl:apply-templates select="/" mode="M31" /><xsl:apply-templates select="/" mode="M32" /><xsl:apply-templates select="/" mode="M33" /><xsl:apply-templates select="/" mode="M34" /></Schematron>
</xsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN abstracts2-->
<xsl:variable name="AccountType" select="',1,2,3,'" />
<xsl:variable name="AccountType_listID" select="'urn:oioubl:codelist:accounttypecode-1.1'" />
<xsl:variable name="AccountType_agencyID" select="'320'" />
<xsl:variable name="UN_AddressFormat" select="',1,2,3,4,5,6,7,8,9,'" />
<xsl:variable name="UN_AddressFormat_listID" select="'UN/ECE 3477'" />
<xsl:variable name="UN_AddressFormat_agencyID" select="'6'" />
<xsl:variable name="AddressFormat" select="',StructuredDK,StructuredID,StructuredLax,StructuredRegion,Unstructured,'" />
<xsl:variable name="AddressFormat_listID" select="'urn:oioubl:codelist:addressformatcode-1.1'" />
<xsl:variable name="AddressFormat_agencyID" select="'320'" />
<xsl:variable name="AddressType" select="',Home,Business,'" />
<xsl:variable name="AddressType_listID" select="'urn:oioubl:codelist:addresstypecode-1.1'" />
<xsl:variable name="AddressType_agencyID" select="'320'" />
<xsl:variable name="Allowance" select="',1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,ZZZ,'" />
<xsl:variable name="Allowance_listID" select="'UN/ECE 4465'" />
<xsl:variable name="Allowance_agencyID" select="'6'" />
<xsl:variable name="CatDocType" select="',Brochure,Drawing,Picture,ProductSheet,'" />
<xsl:variable name="CatDocType_listID" select="'urn:oioubl:codelist:cataloguedocumenttypecode-1.1'" />
<xsl:variable name="CatDocType_agencyID" select="'320'" />
<xsl:variable name="CatDocType2" select="',Brochure,Drawing,Picture,ProductSheet,PictureURL,'" />
<xsl:variable name="CatDocType2_listID2" select="'urn:oioubl:codelist:cataloguedocumenttypecode-1.2'" />
<xsl:variable name="CatAction" select="',Update,Delete,Add,'" />
<xsl:variable name="CatAction_listID" select="'urn:oioubl:codelist:catalogueactioncode-1.1'" />
<xsl:variable name="CatAction_agencyID" select="'320'" />
<xsl:variable name="CountryCode" select="',AD,AE,AF,AG,AI,AL,AM,AO,AQ,AR,AS,AT,AU,AW,AX,AZ,BA,BB,BD,BE,BF,BG,BH,BI,BJ,BM,BN,BO,BQ,BR,BS,BT,BV,BW,BY,BZ,CA,CC,CD,CF,CG,CH,CI,CK,CL,CM,CN,CO,CR,CU,CV,CW,CX,CY,CZ,DE,DJ,DK,DM,DO,DZ,EC,EE,EG,EH,ER,ES,ET,FI,FJ,FK,FM,FO,FR,GA,GB,GD,GE,GF,GG,GH,GI,GL,GM,GN,GP,GQ,GR,GS,GT,GU,GW,GY,HK,HM,HN,HR,HT,HU,ID,IE,IL,IM,IN,IO,IQ,IR,IS,IT,JE,JM,JO,JP,KE,KG,KH,KI,KM,KN,KP,KR,KW,KY,KZ,LA,LB,LC,LI,LK,LR,LS,LT,LU,LV,LY,MA,MC,MD,ME,MG,MH,MK,ML,MM,MN,MO,MP,MQ,MR,MS,MT,MU,MV,MW,MX,MY,MZ,NA,NC,NE,NF,NG,NI,NL,NO,NP,NR,NU,NZ,OM,PA,PE,PF,PG,PH,PK,PL,PM,PN,PR,PS,PT,PW,PY,QA,RE,RO,RS,RU,RW,SA,SB,SC,SD,SE,SG,SH,SI,SJ,SK,SL,SM,SN,SO,SR,SS,ST,SV,SX,SY,SZ,TC,TD,TF,TG,TH,TJ,TK,TL,TM,TN,TO,TR,TT,TV,TW,TZ,UA,UG,UM,US,UY,UZ,VA,VC,VE,VG,VI,VN,VU,WF,WS,YE,YT,ZA,ZM,ZW,'" />
<xsl:variable name="CountryCode_listID" select="'ISO3166-2'" />
<xsl:variable name="CountryCode_agencyID" select="'6'" />
<xsl:variable name="CountrySub" select="',DK-81,'" />
<xsl:variable name="CountrySub_listID" select="'ISO 3166-2'" />
<xsl:variable name="CountrySub_agencyID" select="'6'" />
<xsl:variable name="CurrencyCode" select="',EUR,AFA,DZD,ADP,ARS,AMD,AWG,AUD,AZM,BSD,BHD,THB,PAB,BBD,BYB,BYR,BEF,BZD,BMD,VEB,BOB,BRL,BND,BGN,BIF,CAD,CVE,KYD,GHC,XOF,XAF,XPF,CLP,COP,KMF,BAM,NIO,CRC,HRK,CUP,CYP,CZK,GMD,DKK,MKD,DEM,DJF,STD,DOP,VND,GRD,XCD,EGP,SVC,ETB,FKP,FJD,HUF,CDF,FRF,GIP,HTG,PYG,GNF,GWP,GYD,HKD,UAH,ISK,INR,IRR,IQD,IEP,ITL,JMD,JOD,KES,PGK,LAK,EEK,KWD,MWK,ZMK,AOA,MMK,GEL,LVL,LBP,ALL,HNL,SLL,ROL,BGL,LRD,LYD,SZL,LTL,LSL,LUF,MGF,MYR,MTL,TMM,FIM,MUR,MZM,MXN,MXV,MDL,MAD,BOV,NGN,ERN,NAD,NPR,ANG,NLG,ILS,TWD,NZD,BTN,KPW,NOK,PEN,MRO,TOP,PKR,MOP,UYU,PHP,PTE,GBP,BWP,QAR,GTQ,ZAR,OMR,KHR,MVR,IDR,RUB,RUR,RWF,SHP,SAR,ATS,XDR,SCR,SGD,SKK,SBD,KGS,SOS,ESP,LKR,SDD,SRG,SEK,CHF,SYP,TJR,BDT,WST,TZS,KZT,TPE,SIT,TTD,MNT,TND,TRL,AED,UGX,CLF,USD,UZS,VUV,KRW,YER,JPY,CNY,YUM,ZWD,PLN,AFA,DZD,ADP,ARS,AMD,AWG,AUD,AZM,BSD,BHD,THB,PAB,BBD,BYB,BYR,BEF,BZD,BMD,VEB,BOB,BRL,BND,BGN,'" />
<xsl:variable name="CurrencyCode_listID" select="'ISO 4217 Alpha'" />
<xsl:variable name="CurrencyCode_agencyID" select="'6'" />
<xsl:variable name="Discrepancy" select="',Billing1,Billing2,Billing3,Condition1,Condition2,Condition3,Condition4,Condition5,Condition6,Delivery1,Delivery2,Delivery3,Quality1,Quality2,ZZZ,'" />
<xsl:variable name="Discrepancy_listID" select="'urn:oioubl:codelist:discrepancyresponsecode-1.1'" />
<xsl:variable name="Discrepancy_agencyID" select="'320'" />
<xsl:variable name="DocTypeCode" select="'rule'" />
<xsl:variable name="DocTypeCode_listID" select="'UN/ECE 1001'" />
<xsl:variable name="DocTypeCode_agencyID" select="'6'" />
<xsl:variable name="InvTypeCode" select="',325,380,393,'" />
<xsl:variable name="InvTypeCode_listID" select="'urn:oioubl:codelist:invoicetypecode-1.1'" />
<xsl:variable name="InvTypeCode_agencyID" select="'320'" />
<xsl:variable name="InvTypeCode2" select="',325,380,390,393,'" />
<xsl:variable name="InvTypeCode2_listID" select="'urn:oioubl:codelist:invoicetypecode-1.2'" />
<xsl:variable name="UNSPSC" select="'rule'" />
<xsl:variable name="UNSPSC_listID" select="'UNSPSC'" />
<xsl:variable name="UNSPSC_agencyID" select="'113'" />
<xsl:variable name="LifeCycle" select="',Available,DeletedAnnouncement,ItemDeleted,NewAnnouncement,NewAvailable,ItemTemporarilyUnavailable,'" />
<xsl:variable name="LifeCycle_listID" select="'urn:oioubl:codelist:lifecyclestatuscode-1.1'" />
<xsl:variable name="LifeCycle_agencyID" select="'320'" />
<xsl:variable name="LineResponse" select="',BusinessAccept,BusinessReject,'" />
<xsl:variable name="LineResponse_listID" select="'urn:oioubl:codelist:lineresponsecode-1.1'" />
<xsl:variable name="LineResponse_agencyID" select="'320'" />
<xsl:variable name="LineStatus" select="',Added,Cancelled,Disputed,NoStatus,Revised,'" />
<xsl:variable name="LineStatus_listID" select="'urn:oioubl:codelist:linestatuscode-1.1'" />
<xsl:variable name="LineStatus_agencyID" select="'320'" />
<xsl:variable name="LossRisk" select="',FOB,'" />
<xsl:variable name="LossRisk_listID" select="'urn:oioubl:codelist:lossriskresponsibilitycode-1.1'" />
<xsl:variable name="LossRisk_agencyID" select="'320'" />
<xsl:variable name="PaymentChannel" select="',BBAN,DK:BANK,DK:FIK,DK:GIRO,DK:NEMKONTO,FI:BANK,FI:GIRO,GB:BACS,GB:BANK,GB:GIRO,IBAN,IS:BANK,IS:GIRO,IS:IK66,IS:RB,NO:BANK,SE:BANKGIRO,SE:PLUSGIRO,SWIFTUS,ZZZ,'" />
<xsl:variable name="PaymentChannel_listID" select="'urn:oioubl:codelist:paymentchannelcode-1.1'" />
<xsl:variable name="PaymentChannel_agencyID" select="'320'" />
<xsl:variable name="PriceType" select="',AAA,AAB,AAC,AAD,AAE,AAF,AAG,AAH,AAI,AAJ,AAK,AAL,AAM,AAN,AAO,AAP,AAQ,AAR,AAS,AAT,AAU,AAV,AAW,AAX,AAY,AAZ,ABA,ABB,ABC,ABD,ABE,ABF,ABG,ABH,ABI,ABJ,ABK,ABL,ABM,ABN,ABO,ABP,ABQ,ABR,ABS,ABT,ABU,ABV,AI,ALT,AP,BR,CAT,CDV,CON,CP,CU,CUP,CUS,DAP,DIS,DPR,DR,DSC,EC,ES,EUP,FCR,GRP,INV,LBL,MAX,MIN,MNR,MSR,MXR,NE,NQT,NTP,NW,OCR,OFR,PAQ,PBQ,PPD,PPR,PRO,PRP,PW,QTE,RES,RTP,SHD,SRP,SW,TB,TRF,TU,TW,WH,'" />
<xsl:variable name="PriceType_listID" select="'UN/ECE 5387'" />
<xsl:variable name="PriceType_agencyID" select="'6'" />
<xsl:variable name="PriceListStat" select="',Original,Copy,Revision,Cancellation,'" />
<xsl:variable name="PriceListStat_listID" select="'urn:oioubl.codelist:priceliststatuscode-1.1,urn:oioubl:codelist:priceliststatuscode-1.1'" />
<xsl:variable name="PriceListStat_agencyID" select="'320'" />
<xsl:variable name="RemType" select="',Reminder,Advis,'" />
<xsl:variable name="RemType_listID" select="',urn:oioubl.codelist:remindertypecode-1.1,urn:oioubl:codelist:remindertypecode-1.1,'" />
<xsl:variable name="RemType_agencyID" select="'320'" />
<xsl:variable name="RemAlc" select="',PenaltyFee,PenaltyRate,'" />
<xsl:variable name="RemAlc_listID" select="'urn:oioubl:codelist:reminderallowancechargereasoncode-1.0'" />
<xsl:variable name="RemAlc_agencyID" select="'320'" />
<xsl:variable name="Response" select="',BusinessAccept,BusinessReject,ProfileAccept,ProfileReject,TechnicalAccept,TechnicalReject,'" />
<xsl:variable name="Response_listID" select="'urn:oioubl:codelist:responsecode-1.1'" />
<xsl:variable name="Response_agencyID" select="'320'" />
<xsl:variable name="ResponseDocType" select="',ApplicationResponse,Catalogue,CatalogueDeletion,CatalogueItemSpecificationUpdate,CatalogueItemUpdate,CataloguePricingUpdate,CataloguePriceUpdate,CatalogueRequest,CreditNote,Invoice,Order,OrderCancellation,OrderChange,OrderResponse,OrderResponseSimple,Reminder,Statement,Payment,PersonalSecure,ZZZ,'" />
<xsl:variable name="ResponseDocType_listID" select="'urn:oioubl:codelist:responsedocumenttypecode-1.1'" />
<xsl:variable name="ResponseDocType_agencyID" select="'320'" />
<xsl:variable name="ResponseDocType2" select="',ApplicationResponse,Catalogue,CatalogueDeletion,CatalogueItemSpecificationUpdate,CatalogueItemUpdate,CataloguePricingUpdate,CataloguePriceUpdate,CatalogueRequest,CreditNote,Invoice,Order,OrderCancellation,OrderChange,OrderResponse,OrderResponseSimple,Reminder,Statement,Payment,UtilityStatement,PersonalSecure,ZZZ,'" />
<xsl:variable name="ResponseDocType2_listID" select="'urn:oioubl:codelist:responsedocumenttypecode-1.2'" />
<xsl:variable name="ResponseDocType2_agencyID" select="'320'" />
<xsl:variable name="SubStatus" select="',DeliveryDateChanged,DeliveryDateNotPossible,DeliveryPartyUnknown,ItemDeleted,ItemNotFound,ItemNotInAssortment,ItemReplaced,ItemTemporarilyUnavailable,NewAnnouncement,OrderedQuantityChanged,OrderLineRejected,Original,SeasonalItemUnavailable,Substitution,'" />
<xsl:variable name="SubStatus_listID" select="'urn:oioubl:codelist:substitutionstatuscode-1.1'" />
<xsl:variable name="SubStatus_agencyID" select="'320'" />
<xsl:variable name="TaxExemption" select="',AAA,AAB,AAC,AAE,AAF,AAG,AAH,AAI,AAJ,AAK,AAL,AAM,AAN,AAO,'" />
<xsl:variable name="TaxExemption_listID" select="'CWA 15577'" />
<xsl:variable name="TaxExemption_agencyID" select="'CEN'" />
<xsl:variable name="TaxType" select="',StandardRated,ZeroRated,'" />
<xsl:variable name="TaxType_listID" select="'urn:oioubl:codelist:taxtypecode-1.1'" />
<xsl:variable name="TaxType_agencyID" select="'320'" />
<xsl:variable name="TaxType2" select="',StandardRated,ZeroRated,ReverseCharge,'" />
<xsl:variable name="TaxType_listID2" select="'urn:oioubl:codelist:taxtypecode-1.2'" />
<xsl:variable name="UnitMeasure" select="'xsd'" />
<xsl:variable name="UnitMeasure_listID" select="'UN/ECE rec 20'" />
<xsl:variable name="UnitMeasure_agencyID" select="'6'" />
<xsl:variable name="UtilityStatType" select="',MultiSettlement,Internet,Television,Fibernet,Lighting,OutdoorLighting,Cooling,DistantCooling,ChimneySweep,Antenna,Drain,Waste,Sewage,WasteWater,Water,Heating,DistrictHeating,Electricity,Tele,TeleExtended,Gas,Oil,Goods,Sprinkler,Assorted,'" />
<xsl:variable name="UtilityStatType_listID" select="'urn:oioubl:codelist:utilitystatementtypecode-1.0'" />
<xsl:variable name="UtilityStatType_agencyID" select="'320'" />
<xsl:variable name="UtilityPrivacyCode" select="',CompanyLevel,UserLevel,NotRelevant,'" />
<xsl:variable name="UtilityPrivacyCode_listID" select="'urn:oioubl:codelist:privacycode-1.0'" />
<xsl:variable name="UtilityPrivacyCode_agencyID" select="'320'" />
<xsl:variable name="UtilityTeleCatCode" select="',Subscription,OneTime,Consumption,Service900,SpecialServices,Assorted,'" />
<xsl:variable name="UtilityTeleCatCode_listID" select="'urn:oioubl:codelist:telecategorycode-1.0'" />
<xsl:variable name="UtilityTeleCatCode_agencyID" select="'320'" />
<xsl:variable name="UtilityTeleSupTypeCode" select="',Tele,Internet,Television,Assorted,'" />
<xsl:variable name="UtilityTeleSupTypeCode_listID" select="'urn:oioubl:codelist:telecommunicationssupplytypecode-1.0'" />
<xsl:variable name="UtilityTeleSupTypeCode_agencyID" select="'320'" />
<xsl:variable name="UtilityTeleCallCode" select="',CallAttempt,Freephone,SwitchedCall,ZoneCall,ServiceNumber,Services,Streaming,Roaming,TastSelv,Data,Mobile,WiredPhone,FAX,SMS,MMS,WAP,GPRS,Assorted,'" />
<xsl:variable name="UtilityTeleCallCode_listID" select="'urn:oioubl:codelist:telecallcode-1.0'" />
<xsl:variable name="UtilityTeleCallCode_agencyID" select="'320'" />
<xsl:variable name="UtilityDutyCode" select="',CallAttempt,ConnectionFee,InternationalConnection,Freephone,ZoneCall,Roaming,Donation,Service900,SpecialServices,ServiceNumber,Services,TastSelv,Switched,Routed,ConsumptionFee,ConsumptionInternational,ConsumptionSpecialRate,Streaming,Charge,Discount,Assorted,'" />
<xsl:variable name="UtilityDutyCode_listID" select="'urn:oioubl:codelist:dutycode-1.0'" />
<xsl:variable name="UtilityDutyCode_agencyID" select="'320'" />
<xsl:variable name="UtilitySpecTypeCode" select="',Onaccount,YearlyStatement,FinalSettlement,Statement,MonthlyStatement,QuarterlyStatement,SixMonthStatement,CurrentStatement,RelocationSettlement,ExtraordinaryStatement,Regulation,Cancellation,Assorted,'" />
<xsl:variable name="UtilitySpecTypeCode_listID" select="'urn:oioubl:codelist:specificationtypecode-1.0'" />
<xsl:variable name="UtilitySpecTypeCode_agencyID" select="'320'" />
<xsl:variable name="UtilitySubIDTypeCode" select="',APL,DPA,DSH,DX,ERH,FKR,FLX,FRS,IP,ISP,IWA,KPM,KT1,KT2,KT3,MOB,NAV,PBS,SIK,SUS,TIP,TKA,TLF,VAG,VSS,GSM,CDA,PBX,ISP,ZZZ,'" />
<xsl:variable name="UtilitySubIDTypeCode_listID" select="'urn:oioubl:codelist:subscriberidtypecode-1.0'" />
<xsl:variable name="UtilitySubIDTypeCode_agencyID" select="'320'" />
<xsl:variable name="UtilityMeterConCode" select="',Factor,'" />
<xsl:variable name="UtilityMeterConCode_listID" select="'urn:oioubl:codelist:meterconstantcode-1.0'" />
<xsl:variable name="UtilityMeterConCode_agencyID" select="'320'" />
<xsl:variable name="UtilityReaMetCode" select="',Remote,ReadByInspector,Card,SMS,PDA,VoiceResponse,WEB,Estimated,EstimatedAutomatic,EstimatedOfficer,EstimatedAfterError,Reset,PieceCount,HourlyAmount,Manual,CustomerService,Calculated,Unknown,'" />
<xsl:variable name="UtilityReaMetCode_listID" select="'urn:oioubl:codelist:meterreadingmethodcode-1.0'" />
<xsl:variable name="UtilityReaMetCode_agencyID" select="'320'" />
<xsl:variable name="UtilityMRTypeCode" select="',Electricity,Water,Heating,Gas,Oil,Sewage,WasteWater,RefuseDisposal,DistantCooling,Assorted,'" />
<xsl:variable name="UtilityMRTypeCode_listID" select="'urn:oioubl:codelist:meterreadingtypecode-1.0'" />
<xsl:variable name="UtilityMRTypeCode_agencyID" select="'320'" />
<xsl:variable name="UtilityConTypeCode" select="',Subscription,Consumption,Service900,SpecialServices,Assorted,'" />
<xsl:variable name="UtilityConTypeCode_listID" select="'urn:oioubl:codelist:consumptiontypecode-1.0'" />
<xsl:variable name="UtilityConTypeCode_agencyID" select="'320'" />
<xsl:variable name="UtilityCELCode" select="',A,B,C,D,E,F,G,'" />
<xsl:variable name="UtilityCELCode_listID" select="'urn:oioubl:codelist:consumersenergylevelcode-1.0'" />
<xsl:variable name="UtilityCELCode_agencyID" select="'320'" />
<xsl:variable name="UtilityResTypeCode" select="',House,Apartment,IndustriProperty,Assorted,'" />
<xsl:variable name="UtilityResTypeCode_listID" select="'urn:oioubl:codelist:residencetypecode-1.0'" />
<xsl:variable name="UtilityResTypeCode_agencyID" select="'320'" />
<xsl:variable name="UtilityHeaTypeCode" select="',Electricity,Gas,Oil,Coal,DistrictHeating,DistantCooling,SolarEnergy,WindEnergy,Wood,GeothermalHeat,Assorted,'" />
<xsl:variable name="UtilityHeaTypeCode_listID" select="'urn:oioubl:codelist:heatingtypecode-1.0'" />
<xsl:variable name="UtilityHeaTypeCode_agencyID" select="'320'" />
<xsl:variable name="UtilityCorTypeCode" select="',HeatingCorrection,GasCorrection,OtherCorrection,'" />
<xsl:variable name="UtilityCorTypeCode_listID" select="'urn:oioubl:codelist:correctiontypecode-1.0'" />
<xsl:variable name="UtilityCorTypeCode_agencyID" select="'320'" />
<xsl:variable name="UtilityCCTypeCode" select="',SubcriptionType1,SubcriptionType2,SubcriptionType3,ShortTermSubscription,ServiceSubscription,24HourServiceType1,24HourServiceType2,BasicService,3HourService,DeliveryService,CallInServiceType1,CallInServiceType2,RentalType1,RentalType2,Leasing,TeleTime,Attempt,Discount,EmployeeInternet,SalesSector,Sales,Administration,ShopService,Assorted,'" />
<xsl:variable name="UtilityCCTypeCode_listID" select="'urn:oioubl:codelist:currentchargetypecode-1.0'" />
<xsl:variable name="UtilityCCTypeCode_agencyID" select="'320'" />
<xsl:variable name="UtilityOTCTypeCode" select="',InstallationCharge,ReInstallationCharge,Opening,ReOpening,Assumption,Installation,Connection,Change,NumberChange,Conversion,BuyBack,Reception,Relocation,Upgrade,Repair,Debugging,Compensation,MinConsumption,Charge,Discount,ServiceInformation,SpecialService,Blocking,Termination,Sealing,GoodsPayment,Assorted,'" />
<xsl:variable name="UtilityOTCTypeCode_listID" select="'urn:oioubl:codelist:onetimechargetypecode-1.0'" />
<xsl:variable name="UtilityOTCTypeCode_agencyID" select="'320'" />
<xsl:variable name="Delivery_1" select="',EXW,FCA,FAS,FOB,CFR,CIF,CPT,CIP,DAF,DES,DEQ,DDU,DDP,'" />
<xsl:variable name="Delivery_1_schemeID" select="'INCOTERMS 2000'" />
<xsl:variable name="Delivery_1_agencyID" select="'NES'" />
<xsl:variable name="Delivery_2" select="',001 EXW,002 FCA,003 FAS,004 FOB,005 FCA,006 CPT,007 CIP,008 CFR,009 CIF,010 CPT,011 CIP,012 CPT,013 CIP,014 CPT,015 CIP,016 DES,017 DRQ,018 DAF,019 DDU,021 DDP,022 DDU,023 DDP,'" />
<xsl:variable name="Delivery_2_schemeID" select="'COMBITERMS 2000'" />
<xsl:variable name="Delivery_2_agencyID" select="'NES'" />
<xsl:variable name="Dimension" select="',A,AAA,AAB,AAC,AAD,AAE,AAF,AAJ,AAK,AAL,AAM,AAN,AAO,AAP,AAQ,AAR,AAS,AAT,AAU,AAV,AAW,AAX,AAY,AAZ,ABA,ABB,ABC,ABD,ABE,ABJ,ABS,ABX,ABY,ABZ,ACA,ACE,ACG,ACN,ACP,ACS,ACV,ACW,ACX,ADR,ADS,ADT,ADU,ADV,ADW,ADX,ADY,ADZ,AEA,AEB,AEC,AED,AEE,AEF,AEG,AEH,AEI,AEJ,AEK,AEM,AEN,AEO,AEP,AEQ,AER,AET,AEU,AEV,AEW,AEX,AEY,AEZ,AF,AFA,AFB,AFC,AFD,AFE,AFF,AFG,AFH,AFI,AFJ,AFK,B,BL,BMY,BMZ,BNA,BNB,BNC,BND,BNE,BNF,BNG,BNH,BNI,BNJ,BNK,BNL,BNM,BNN,BNO,BNP,BNQ,BNR,BNS,BNT,BR,BRA,BRE,BS,BSW,BW,CHN,CM,CT,CV,CZ,D,DI,DL,DN,DP,DR,DS,DW,E,EA,F,FI,FL,FN,FV,G,GG,GW,HF,HM,HT,IB,ID,L,LM,LN,LND,M,MO,MW,N,OD,PRS,PTN,RA,RF,RJ,RMW,RP,RUN,RY,SQ,T,TC,TH,TN,TT,U,VH,VW,WA,WD,WM,WT,WU,XH,XQ,XZ,YS,ZAL,ZAS,ZB,ZBI,ZC,ZCA,ZCB,ZCE,ZCL,ZCO,ZCR,ZCU,ZFE,ZFS,ZGE,ZH,ZK,ZMG,ZMN,ZMO,ZN,ZNA,ZNB,ZNI,ZO,ZP,ZPB,ZS,ZSB,ZSE,ZSI,ZSL,ZSN,ZTA,ZTE,ZTI,ZV,ZW,ZWA,ZZN,ZZR,ZZZ,'" />
<xsl:variable name="Dimension_schemeID" select="'UN/ECE 6313'" />
<xsl:variable name="Dimension_agencyID" select="'6'" />
<xsl:variable name="BIC" select="'rule'" />
<xsl:variable name="BIC_schemeID" select="'BIC'" />
<xsl:variable name="BIC_agencyID" select="'17'" />
<xsl:variable name="IBAN" select="'rule'" />
<xsl:variable name="IBAN_schemeID" select="'IBAN'" />
<xsl:variable name="IBAN_agencyID" select="'17'" />
<xsl:variable name="LocID" select="'rule'" />
<xsl:variable name="LocID_schemeID" select="'UN/ECE rec 16'" />
<xsl:variable name="LocID_agencyID" select="'6'" />
<xsl:variable name="PaymentID" select="',01,04,15,71,73,75,'" />
<xsl:variable name="PaymentID_schemeID" select="'urn:oioubl:id:paymentid-1.1'" />
<xsl:variable name="PaymentID_agencyID" select="'320'" />
<xsl:variable name="Profile1" select="',NONE,Procurement-BilSim-1.0,Procurement-BilSimR-1.0,Procurement-PayBas-1.0,Procurement-PayBasR-1.0,Procurement-OrdSim-BilSim-1.0,Procurement-OrdSimR-BilSim-1.0,Procurement-OrdSim-BilSimR-1.0,Procurement-OrdSimR-BilSimR-1.0,Procurement-OrdAdv-BilSim-1.0,Procurement-OrdAdv-BilSimR-1.0,Procurement-OrdAdvR-BilSim-1.0,Procurement-OrdAdvR-BilSimR-1.0,Procurement-OrdSel-BilSim-1.0,Procurement-OrdSel-BilSimR-1.0,Catalogue-CatBas-1.0,Catalogue-CatBasR-1.0,Catalogue-CatSim-1.0,Catalogue-CatSimR-1.0,Catalogue-CatExt-1.0,Catalogue-CatExtR-1.0,Catalogue-CatAdv-1.0,Catalogue-CatAdvR-1.0,urn:www.nesubl.eu:profiles:profile1:ver1.0,urn:www.nesubl.eu:profiles:profile2:ver1.0,urn:www.nesubl.eu:profiles:profile5:ver1.0,urn:www.nesubl.eu:profiles:profile7:ver1.0,urn:www.nesubl.eu:profiles:profile8:ver1.0,'" />
<xsl:variable name="Profile1_schemeID" select="'urn:oioubl:id:profileid-1.1'" />
<xsl:variable name="Profile1_agencyID" select="'320'" />
<xsl:variable name="Profile2" select="',NONE,Procurement-BilSim-1.0,Procurement-BilSimR-1.0,Procurement-PayBas-1.0,Procurement-PayBasR-1.0,Procurement-OrdSim-BilSim-1.0,Procurement-OrdSimR-BilSim-1.0,Procurement-OrdSim-BilSimR-1.0,Procurement-OrdSimR-BilSimR-1.0,Procurement-OrdAdv-BilSim-1.0,Procurement-OrdAdv-BilSimR-1.0,Procurement-OrdAdvR-BilSim-1.0,Procurement-OrdAdvR-BilSimR-1.0,Procurement-OrdSel-BilSim-1.0,Procurement-OrdSel-BilSimR-1.0,Catalogue-CatBas-1.0,Catalogue-CatBasR-1.0,Catalogue-CatSim-1.0,Catalogue-CatSimR-1.0,Catalogue-CatExt-1.0,Catalogue-CatExtR-1.0,Catalogue-CatAdv-1.0,Catalogue-CatAdvR-1.0,urn:www.nesubl.eu:profiles:profile1:ver1.0,urn:www.nesubl.eu:profiles:profile2:ver1.0,urn:www.nesubl.eu:profiles:profile5:ver1.0,urn:www.nesubl.eu:profiles:profile7:ver1.0,urn:www.nesubl.eu:profiles:profile8:ver1.0,urn:www.nesubl.eu:profiles:profile1:ver2.0,urn:www.nesubl.eu:profiles:profile2:ver2.0,urn:www.nesubl.eu:profiles:profile5:ver2.0,urn:www.nesubl.eu:profiles:profile7:ver2.0,urn:www.nesubl.eu:profiles:profile8:ver2.0,'" />
<xsl:variable name="Profile2_schemeID" select="'urn:oioubl:id:profileid-1.2'" />
<xsl:variable name="Profile3" select="',NONE,Procurement-BilSim-1.0,Procurement-BilSimR-1.0,Procurement-PayBas-1.0,Procurement-PayBasR-1.0,Procurement-OrdSim-BilSim-1.0,Procurement-OrdSimR-BilSim-1.0,Procurement-OrdSim-BilSimR-1.0,Procurement-OrdSimR-BilSimR-1.0,Procurement-OrdAdv-BilSim-1.0,Procurement-OrdAdv-BilSimR-1.0,Procurement-OrdAdvR-BilSim-1.0,Procurement-OrdAdvR-BilSimR-1.0,Procurement-OrdSel-BilSim-1.0,Procurement-OrdSel-BilSimR-1.0,Catalogue-CatBas-1.0,Catalogue-CatBasR-1.0,Catalogue-CatSim-1.0,Catalogue-CatSimR-1.0,Catalogue-CatExt-1.0,Catalogue-CatExtR-1.0,Catalogue-CatAdv-1.0,Catalogue-CatAdvR-1.0,urn:www.nesubl.eu:profiles:profile1:ver1.0,urn:www.nesubl.eu:profiles:profile2:ver1.0,urn:www.nesubl.eu:profiles:profile5:ver1.0,urn:www.nesubl.eu:profiles:profile7:ver1.0,urn:www.nesubl.eu:profiles:profile8:ver1.0,urn:www.nesubl.eu:profiles:profile1:ver2.0,urn:www.nesubl.eu:profiles:profile2:ver2.0,urn:www.nesubl.eu:profiles:profile5:ver2.0,urn:www.nesubl.eu:profiles:profile7:ver2.0,urn:www.nesubl.eu:profiles:profile8:ver2.0,Reference-Utility-1.0,Reference-UtilityR-1.0,'" />
<xsl:variable name="Profile3_schemeID" select="'urn:oioubl:id:profileid-1.3'" />
<xsl:variable name="Profile4" select="',NONE,Procurement-BilSim-1.0,Procurement-BilSimR-1.0,Procurement-PayBas-1.0,Procurement-PayBasR-1.0,Procurement-OrdSim-1.0,Procurement-OrdSimR-1.0,Procurement-OrdSim-BilSim-1.0,Procurement-OrdSimR-BilSim-1.0,Procurement-OrdSim-BilSimR-1.0,Procurement-OrdSimR-BilSimR-1.0,Procurement-OrdAdv-BilSim-1.0,Procurement-OrdAdv-BilSimR-1.0,Procurement-OrdAdvR-BilSim-1.0,Procurement-OrdAdvR-BilSimR-1.0,Procurement-OrdSel-BilSim-1.0,Procurement-OrdSel-BilSimR-1.0,Catalogue-CatBas-1.0,Catalogue-CatBasR-1.0,Catalogue-CatSim-1.0,Catalogue-CatSimR-1.0,Catalogue-CatExt-1.0,Catalogue-CatExtR-1.0,Catalogue-CatAdv-1.0,Catalogue-CatAdvR-1.0,urn:www.nesubl.eu:profiles:profile1:ver1.0,urn:www.nesubl.eu:profiles:profile2:ver1.0,urn:www.nesubl.eu:profiles:profile5:ver1.0,urn:www.nesubl.eu:profiles:profile7:ver1.0,urn:www.nesubl.eu:profiles:profile8:ver1.0,urn:www.nesubl.eu:profiles:profile1:ver2.0,urn:www.nesubl.eu:profiles:profile2:ver2.0,urn:www.nesubl.eu:profiles:profile3:ver2.0,urn:www.nesubl.eu:profiles:profile5:ver2.0,urn:www.nesubl.eu:profiles:profile7:ver2.0,urn:www.nesubl.eu:profiles:profile8:ver2.0,Reference-Utility-1.0,Reference-UtilityR-1.0,urn:www.cenbii.eu:profile:bii30:ver2.0,Procurement-TecRes-1.0,Catalogue-CatPriUpd-1.0,Catalogue-CatPriUpdR-1.0,'" />
<xsl:variable name="Profile4_schemeID" select="'urn:oioubl:id:profileid-1.4'" />
<xsl:variable name="Profile5" select="',NONE,Procurement-BilSim-1.0,Procurement-BilSimR-1.0,Procurement-PayBas-1.0,Procurement-PayBasR-1.0,Procurement-OrdSim-1.0,Procurement-OrdSimR-1.0,Procurement-OrdSim-BilSim-1.0,Procurement-OrdSimR-BilSim-1.0,Procurement-OrdSim-BilSimR-1.0,Procurement-OrdSimR-BilSimR-1.0,Procurement-OrdAdv-BilSim-1.0,Procurement-OrdAdv-BilSimR-1.0,Procurement-OrdAdvR-BilSim-1.0,Procurement-OrdAdvR-BilSimR-1.0,Procurement-OrdSel-BilSim-1.0,Procurement-OrdSel-BilSimR-1.0,Catalogue-CatBas-1.0,Catalogue-CatBasR-1.0,Catalogue-CatSim-1.0,Catalogue-CatSimR-1.0,Catalogue-CatExt-1.0,Catalogue-CatExtR-1.0,Catalogue-CatAdv-1.0,Catalogue-CatAdvR-1.0,urn:www.nesubl.eu:profiles:profile1:ver1.0,urn:www.nesubl.eu:profiles:profile2:ver1.0,urn:www.nesubl.eu:profiles:profile5:ver1.0,urn:www.nesubl.eu:profiles:profile7:ver1.0,urn:www.nesubl.eu:profiles:profile8:ver1.0,urn:www.nesubl.eu:profiles:profile1:ver2.0,urn:www.nesubl.eu:profiles:profile2:ver2.0,urn:www.nesubl.eu:profiles:profile3:ver2.0,urn:www.nesubl.eu:profiles:profile5:ver2.0,urn:www.nesubl.eu:profiles:profile7:ver2.0,urn:www.nesubl.eu:profiles:profile8:ver2.0,Reference-Utility-1.0,Reference-UtilityR-1.0,urn:www.cenbii.eu:profile:bii30:ver2.0,Procurement-TecRes-1.0,Catalogue-CatPriUpd-1.0,Catalogue-CatPriUpdR-1.0,Procurement-OrdRes-1.0,'" />
<xsl:variable name="Profile5_schemeID" select="'urn:oioubl:id:profileid-1.5'" />
<xsl:variable name="Profile6" select="',NONE,Procurement-BilSim-1.0,Procurement-BilSimR-1.0,Procurement-PayBas-1.0,Procurement-PayBasR-1.0,Procurement-OrdSim-1.0,Procurement-OrdSimR-1.0,Procurement-OrdSim-BilSim-1.0,Procurement-OrdSimR-BilSim-1.0,Procurement-OrdSim-BilSimR-1.0,Procurement-OrdSimR-BilSimR-1.0,Procurement-OrdAdv-BilSim-1.0,Procurement-OrdAdv-BilSimR-1.0,Procurement-OrdAdvR-BilSim-1.0,Procurement-OrdAdvR-BilSimR-1.0,Procurement-OrdSel-BilSim-1.0,Procurement-OrdSel-BilSimR-1.0,Catalogue-CatBas-1.0,Catalogue-CatBasR-1.0,Catalogue-CatSim-1.0,Catalogue-CatSimR-1.0,Catalogue-CatExt-1.0,Catalogue-CatExtR-1.0,Catalogue-CatAdv-1.0,Catalogue-CatAdvR-1.0,urn:www.nesubl.eu:profiles:profile1:ver1.0,urn:www.nesubl.eu:profiles:profile2:ver1.0,urn:www.nesubl.eu:profiles:profile5:ver1.0,urn:www.nesubl.eu:profiles:profile7:ver1.0,urn:www.nesubl.eu:profiles:profile8:ver1.0,urn:www.nesubl.eu:profiles:profile1:ver2.0,urn:www.nesubl.eu:profiles:profile2:ver2.0,urn:www.nesubl.eu:profiles:profile3:ver2.0,urn:www.nesubl.eu:profiles:profile5:ver2.0,urn:www.nesubl.eu:profiles:profile7:ver2.0,urn:www.nesubl.eu:profiles:profile8:ver2.0,Reference-Utility-1.0,Reference-UtilityR-1.0,urn:www.cenbii.eu:profile:bii30:ver2.0,Procurement-TecRes-1.0,Catalogue-CatPriUpd-1.0,Catalogue-CatPriUpdR-1.0,Procurement-OrdRes-1.0,Procurement-BilSimReminderOnly-1.0,'" />
<xsl:variable name="Profile6_schemeID" select="'urn:oioubl:id:profileid-1.6'" />
<xsl:variable name="IbanOnly" select="',AT,BE,CY,EE,FI,FR,DE,GR,IE,IT,LV,LT,LU,MT,NL,PT,SK,SI,ES,BG,HR,CZ,DK,HU,PL,RO,SE,GB,IS,LI,NO,MC,SM,CH,'" />
<xsl:variable name="TaxCategory1" select="',ZeroRated,StandardRated,ReverseCharge,Excise,3010,3020,3021,3022,3023,3024,3025,3030,3040,3041,3048,3049,3050,3051,3052,3053,3054,3055,3056,3057,3058,3059,3060,3061,3062,3063,3064,3065,3066,3067,3068,3070,3071,3072,3073,3075,3080,3081,3082,3083,3084,3085,3086,3090,3091,3092,3093,3094,3095,3096,3100,3101,3102,3120,3121,3122,3123,3130,3140,3141,3160,3161,3162,3163,3170,3171,3240,3241,3242,3245,3246,3247,3250,3251,3260,3271,3272,3273,3276,3277,3280,3281,3282,3283,3290,3291,3292,3293,3294,3295,3296,3297,3300,3301,3302,3303,3304,3305,3310,3311,3320,3321,3330,3331,3340,3341,3350,3351,3360,3370,3380,3400,3403,3404,3405,3406,3410,3420,3430,3440,3441,3451,3452,3453,3500,3501,3502,3503,3600,3620,3621,3622,3623,3624,3630,3631,3632,3633,3634,3635,3636,3637,3638,3640,3641,3645,3650,3660,3661,3670,3671,'" />
<xsl:variable name="TaxCategory1_schemeID" select="'urn:oioubl:id:taxcategoryid-1.1'" />
<xsl:variable name="TaxCategory1_agencyID" select="'320'" />
<xsl:variable name="TaxCategory2" select="',ZeroRated,StandardRated,ReverseCharge,Excise,3010,3020,3021,3022,3023,3024,3025,3030,3040,3041,3048,3049,3050,3051,3052,3053,3054,3055,3056,3057,3058,3059,3060,3061,3062,3063,3064,3065,3066,3067,3068,3070,3071,3072,3073,3075,3077,3080,3081,3082,3083,3084,3085,3086,3090,3091,3092,3093,3094,3095,3096,3100,3101,3102,3104,3120,3121,3122,3123,3130,3140,3141,3160,3161,3162,3163,3170,3171,3240,3241,3242,3245,3246,3247,3250,3251,3260,3271,3272,3273,3276,3277,3280,3281,3282,3283,3290,3291,3292,3293,3294,3295,3296,3297,3300,3301,3302,3303,3304,3305,3310,3311,3320,3321,3330,3331,3340,3341,3350,3351,3360,3370,3380,3400,3403,3404,3405,3406,3410,3420,3430,3440,3441,3451,3452,3453,3500,3501,3502,3503,3600,3620,3621,3622,3623,3624,3630,3631,3632,3633,3634,3635,3636,3637,3638,3640,3641,3645,3650,3660,3661,3670,3671,310301,310302,310303,310304,310305,310306,310307,'" />
<xsl:variable name="TaxCategory2_schemeID" select="'urn:oioubl:id:taxcategoryid-1.2'" />
<xsl:variable name="TaxCategory2_agencyID" select="'320'" />
<xsl:variable name="TaxCategory3" select="',ZeroRated,StandardRated,ReverseCharge,Excise,3010,3020,3021,3022,3023,3024,3025,3030,3031,3032,3033,3034,3040,3041,3048,3049,3050,3051,3052,3053,3054,3055,3056,3057,3058,3059,3060,3061,3062,3063,3064,3065,3066,3067,3068,3070,3071,3072,3073,3075,3077,3080,3081,3082,3083,3084,3085,3086,3090,3091,3092,3093,3094,3095,3096,3100,3101,3102,3103,3104,3120,3121,3122,3123,3130,3140,3141,3160,3161,3162,3163,3170,3171,3240,3241,3242,3245,3246,3247,3250,3251,3260,3271,3272,3273,3276,3277,3280,3281,3282,3283,3290,3291,3292,3293,3294,3295,3296,3297,3300,3301,3302,3303,3304,3305,3310,3311,3320,3321,3330,3331,3340,3341,3350,3351,3360,3370,3380,3400,3403,3404,3405,3406,3410,3420,3430,3440,3441,3451,3452,3453,3500,3501,3502,3503,3600,3620,3621,3622,3623,3624,3630,3631,3632,3633,3634,3635,3636,3637,3638,3639,3640,3641,3645,3650,3660,3661,310301,310302,310303,310304,310305,310306,310307,'" />
<xsl:variable name="TaxCategory3_schemeID" select="'urn:oioubl:id:taxcategoryid-1.3'" />
<xsl:variable name="TaxCategory3_agencyID" select="'320'" />
<xsl:variable name="TaxScheme" select="',9,10,11,16,17,18,19,21,24,25,27,28,30,31,32,33,39,40,41,53,54,56,57,61,62,63,69,70,71,72,75,76,77,79,85,86,87,91,94,95,97,98,99,100,108,109,110,111,127,128,130,133,134,135,136,137,138,139,140,142,146,151,152,VAT,0,'" />
<xsl:variable name="TaxScheme_schemeID" select="'urn:oioubl:id:taxschemeid-1.1'" />
<xsl:variable name="TaxScheme_agencyID" select="'320'" />
<xsl:variable name="TaxScheme2" select="',9,10,11,16,17,18,19,21,21a,21b,21c,21d,21e,21f,24,25,27,28,30,31,32,33,39,40,41,53,54,56,57,61,61a,62,63,69,70,71,72,75,76,77,79,85,86,87,91,94,94a,95,97,98,99,99a,100,108,109,110,110a,110b,110c,111,112,112a,112b,112c,112d,112e,112f,127,127a,127b,127c,128,130,133,134,135,136,137,138,139,140,142,146,151,152,VAT,0,'" />
<xsl:variable name="TaxScheme2_schemeID" select="'urn:oioubl:id:taxschemeid-1.2'" />
<xsl:variable name="TaxScheme2_agencyID" select="'320'" />
<xsl:variable name="TaxScheme4" select="',9,10,11,16,17,18,19,21,21a,21b,21c,21d,21e,21f,24,25,27,28,30,31,32,33,39,40,41,53,54,56,57,61,61a,62,63,68,69,70,71,72,75,76,77,79,85,86,87,91,94,95,97,98,99,99a,100,108,109,110,110a,110b,110c,111,112,112a,112b,112c,112d,112e,112f,127,127a,127b,127c,128,130,133,134,135,136,137,138,139,140,142,146,151,152,171,VAT,0,'" />
<xsl:variable name="TaxScheme4_schemeID" select="'urn:oioubl:id:taxschemeid-1.4'" />
<xsl:variable name="TaxScheme4_agencyID" select="'320'" />
<xsl:variable name="TaxScheme5" select="',9,10,16,17,18,19,21,21a,21b,21c,21d,21e,21f,24,25,27,30,31,32,33,39,40,54,56,57,61,61a,63,68,69,70,71,72,75,76,77,79,85,87,91,94,95,97,98,100,108,109,110,110a,110b,110c,111,127,127a,127b,127c,128,130,133,134,135,136,137,138,139,142,146,151,152,156,160,161,162,163,164,167,168,184,185,186,VAT,0,'" />
<xsl:variable name="TaxScheme5_schemeID" select="'urn:oioubl:id:taxschemeid-1.5'" />
<xsl:variable name="TaxScheme5_agencyID" select="'320'" />
<xsl:variable name="EndpointID_schemeID" select="',GLN,DUNS,DK:P,DK:CVR,DK:CPR,DK:SE,DK:VANS,FR:SIRET,SE:ORGNR,FI:OVT,IT:FTI,IT:SIA,IT:SECETI,IT:VAT,IT:CF,NO:ORGNR,NO:VAT,HU:VAT,EU:VAT,EU:REID,AT:VAT,AT:GOV,AT:CID,IS:KT,IBAN,AT:KUR,ES:VAT,IT:IPA,AD:VAT,AL:VAT,BA:VAT,BE:VAT,BG:VAT,CH:VAT,CY:VAT,CZ:VAT,DE:VAT,EE:VAT,GB:VAT,GR:VAT,HR:VAT,IE:VAT,LI:VAT,LT:VAT,LU:VAT,LV:VAT,MC:VAT,ME:VAT,MK:VAT,MT:VAT,NL:VAT,PL:VAT,PT:VAT,RO:VAT,RS:VAT,SI:VAT,SK:VAT,SM:VAT,TR:VAT,VA:VAT,'" />
<xsl:variable name="PartyID_schemeID" select="',GLN,DUNS,DK:P,DK:CVR,DK:CPR,DK:SE,FR:SIRET,ZZZ,DK:TELEFON,FI:ORGNR,IS:VSKNR,NO:EFO,NO:NOBB,NO:NODI,NO:ORGNR,NO:VAT,SE:VAT,SE:ORGNR,FI:OVT,IT:FTI,IT:SIA,IT:SECETI,IT:VAT,IT:CF,HU:VAT,EU:VAT,EU:REID,AT:VAT,AT:GOV,AT:CID,IS:KT,IBAN,AT:KUR,ES:VAT,IT:IPA,AD:VAT,AL:VAT,BA:VAT,BE:VAT,BG:VAT,CH:VAT,CY:VAT,CZ:VAT,DE:VAT,EE:VAT,GB:VAT,GR:VAT,HR:VAT,IE:VAT,LI:VAT,LT:VAT,LU:VAT,LV:VAT,MC:VAT,ME:VAT,MK:VAT,MT:VAT,NL:VAT,PL:VAT,PT:VAT,RO:VAT,RS:VAT,SI:VAT,SK:VAT,SM:VAT,TR:VAT,VA:VAT,'" />
<xsl:variable name="PartyLegalID" select="',DK:CVR,DK:CPR,ZZZ,'" />
<xsl:variable name="PartyTaxID" select="',DK:SE,ZZZ,'" />
<xsl:variable name="UtilityCPointID" select="',GSRN,ZZZ,'" />
<xsl:variable name="Quantity_unitCode" select="',04,05,08,10,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,40,41,43,44,45,46,47,48,53,54,56,57,58,59,60,61,62,63,64,66,69,71,72,73,74,76,77,78,80,81,84,85,87,89,90,91,92,93,94,95,96,97,98,1A,1B,1C,1D,1E,1F,1G,1H,1I,1J,1K,1L,1M,1X,2A,2B,2C,2I,2J,2K,2L,2M,2N,2P,2Q,2R,2U,2V,2W,2X,2Y,2Z,3B,3C,3E,3G,3H,3I,4A,4B,4C,4E,4G,4H,4K,4L,4M,4N,4O,4P,4Q,4R,4T,4U,4W,4X,5A,5B,5C,5E,5F,5G,5H,5I,5J,5K,5P,5Q,A1,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A2,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A3,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A4,A40,A41,A42,A43,A44,A45,A47,A48,A49,A5,A50,A51,A52,A53,A54,A55,A56,A57,A58,A6,A60,A61,A62,A63,A64,A65,A66,A67,A68,A69,A7,A70,A71,A73,A74,A75,A76,A77,A78,A79,A8,A80,A81,A82,A83,A84,A85,A86,A87,A88,A89,A9,A90,A91,A93,A94,A95,A96,A97,A98,AA,AB,ACR,AD,AE,AH,AI,AJ,AK,AL,AM,AMH,AMP,ANN,AP,APZ,AQ,AR,ARE,AS,ASM,ASU,ATM,ATT,AV,AW,AY,AZ,B0,B1,B11,B12,B13,B14,B15,B16,B18,B2,B20,B21,B22,B23,B24,B25,B26,B27,B28,B29,B3,B31,B32,B33,B34,B35,B36,B37,B38,B39,B4,B40,B41,B42,B43,B44,B45,B46,B47,B48,B49,B5,B50,B51,B52,B53,B54,B55,B56,B57,B58,B59,B6,B60,B61,B62,B63,B64,B65,B66,B67,B69,B7,B70,B71,B72,B73,B74,B75,B76,B77,B78,B79,B8,B81,B83,B84,B85,B86,B87,B88,B89,B9,B90,B91,B92,B93,B94,B95,B96,B97,B98,B99,BAR,BB,BD,BE,BFT,BG,BH,BHP,BIL,BJ,BK,BL,BLD,BLL,BO,BP,BQL,BR,BT,BTU,BUA,BUI,BW,BX,BZ,C0,C1,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C2,C20,C22,C23,C24,C25,C26,C27,C28,C29,C3,C30,C31,C32,C33,C34,C35,C36,C38,C39,C4,C40,C41,C42,C43,C44,C45,C46,C47,C48,C49,C5,C50,C51,C52,C53,C54,C55,C56,C57,C58,C59,C6,C60,C61,C62,C63,C64,C65,C66,C67,C68,C69,C7,C70,C71,C72,C73,C75,C76,C77,C78,C8,C80,C81,C82,C83,C84,C85,C86,C87,C88,C89,C9,C90,C91,C92,C93,C94,C95,C96,C97,C98,C99,CA,CCT,CDL,CEL,CEN,CG,CGM,CH,CJ,CK,CKG,CL,CLF,CLT,CMK,CMQ,CMT,CNP,CNT,CO,COU,CQ,CR,CS,CT,CTM,CU,CUR,CV,CWA,CWI,CY,CZ,D1,D10,D12,D13,D14,D15,D16,D17,D18,D19,D2,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,D32,D33,D34,D35,D37,D38,D39,D40,D41,D42,D43,D44,D45,D46,D47,D48,D49,D5,D50,D51,D52,D53,D54,D55,D56,D57,D58,D59,D6,D60,D61,D62,D63,D64,D65,D66,D67,D69,D7,D70,D71,D72,D73,D74,D75,D76,D77,D79,D8,D80,D81,D82,D83,D85,D86,D87,D88,D89,D9,D90,D91,D92,D93,D94,D95,D96,D97,D98,D99,DAA,DAD,DAY,DB,DC,DD,DE,DEC,DG,DI,DJ,DLT,DMK,DMQ,DMT,DN,DPC,DPR,DPT,DQ,DR,DRA,DRI,DRL,DRM,DS,DT,DTN,DU,DWT,DX,DY,DZN,DZP,E2,E3,E4,E5,EA,EB,EC,EP,EQ,EV,F1,F9,FAH,FAR,FB,FC,FD,FE,FF,FG,FH,FL,FM,FOT,FP,FR,FS,FTK,FTQ,G2,G3,G7,GB,GBQ,GC,GD,GE,GF,GFI,GGR,GH,GIA,GII,GJ,GK,GL,GLD,GLI,GLL,GM,GN,GO,GP,GQ,GRM,GRN,GRO,GRT,GT,GV,GW,GWH,GY,GZ,H1,H2,HA,HAR,HBA,HBX,HC,HD,HE,HF,HGM,HH,HI,HIU,HJ,HK,HL,HLT,HM,HMQ,HMT,HN,HO,HP,HPA,HS,HT,HTZ,HUR,HY,IA,IC,IE,IF,II,IL,IM,INH,INK,INQ,IP,IT,IU,IV,J2,JB,JE,JG,JK,JM,JO,JOU,JR,K1,K2,K3,K5,K6,KA,KB,KBA,KD,KEL,KF,KG,KGM,KGS,KHZ,KI,KJ,KJO,KL,KMH,KMK,KMQ,KNI,KNS,KNT,KO,KPA,KPH,KPO,KPP,KR,KS,KSD,KSH,KT,KTM,KTN,KUR,KVA,KVR,KVT,KW,KWH,KWT,KX,L2,LA,LBR,LBT,LC,LD,LE,LEF,LF,LH,LI,LJ,LK,LM,LN,LO,LP,LPA,LR,LS,LTN,LTR,LUM,LUX,LX,LY,M0,M1,M4,M5,M7,M9,MA,MAL,MAM,MAW,MBE,MBF,MBR,MC,MCU,MD,MF,MGM,MHZ,MIK,MIL,MIN,MIO,MIU,MK,MLD,MLT,MMK,MMQ,MMT,MON,MPA,MQ,MQH,MQS,MSK,MT,MTK,MTQ,MTR,MTS,MV,MVA,MWH,N1,N2,N3,NA,NAR,NB,NBB,NC,NCL,ND,NE,NEW,NF,NG,NH,NI,NIU,NJ,NL,NMI,NMP,NN,NPL,NPR,NPT,NQ,NR,NRL,NT,NTT,NU,NV,NX,NY,OA,OHM,ON,ONZ,OP,OT,OZ,OZA,OZI,P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,PA,PAL,PB,PD,PE,PF,PG,PGL,PI,PK,PL,PM,PN,PO,PQ,PR,PS,PT,PTD,PTI,PTL,PU,PV,PW,PY,PZ,Q3,QA,QAN,QB,QD,QH,QK,QR,QT,QTD,QTI,QTL,QTR,R1,R4,R9,RA,RD,RG,RH,RK,RL,RM,RN,RO,RP,RPM,RPS,RS,RT,RU,S3,S4,S5,S6,S7,S8,SA,SAN,SCO,SCR,SD,SE,SEC,SET,SG,SHT,SIE,SK,SL,SMI,SN,SO,SP,SQ,SR,SS,SST,ST,STI,STN,SV,SW,SX,T0,T1,T3,T4,T5,T6,T7,T8,TA,TAH,TC,TD,TE,TF,TI,TJ,TK,TL,TN,TNE,TP,TPR,TQ,TQD,TR,TRL,TS,TSD,TSH,TT,TU,TV,TW,TY,U1,U2,UA,UB,UC,UD,UE,UF,UH,UM,VA,VI,VLT,VQ,VS,W2,W4,WA,WB,WCD,WE,WEB,WEE,WG,WH,WHR,WI,WM,WR,WSD,WTT,WW,X1,YDK,YDQ,YL,YRD,YT,Z1,Z2,Z3,Z4,Z5,Z6,Z8,ZP,ZZ,'" />
<xsl:variable name="PersonalSecure" select="',1,2,3,'" />
<xsl:variable name="PersonalSecure_schemeID" select="'urn:oioubl:id:personalsecure-1.0'" />
<xsl:variable name="PersonalSecure_agencyID" select="'320'" />
<xsl:template match="text()" priority="-1" mode="M10" />
<xsl:template match="@*|node()" priority="-2" mode="M10">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M10" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M10" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN abstracts-->


	<!--RULE -->
<xsl:template match="//*[@currencyID]" priority="3988" mode="M12">
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M12" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M12" />
<xsl:template match="@*|node()" priority="-2" mode="M12">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M12" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M12" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN ublextensions-->


	<!--RULE -->
<xsl:template match="doc:Reminder" priority="3999" mode="M13">

		<!--REPORT -->
<xsl:if test="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionAgencyID = 'Digitaliseringsstyrelsen' and (ext:UBLExtensions/ext:UBLExtension/cbc:ID &lt; '1001' or ext:UBLExtensions/ext:UBLExtension/cbc:ID &gt; '1999')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>ext:UBLExtensions/ext:UBLExtension/ext:ExtensionAgencyID = 'Digitaliseringsstyrelsen' and (ext:UBLExtensions/ext:UBLExtension/cbc:ID &lt; '1001' or ext:UBLExtensions/ext:UBLExtension/cbc:ID &gt; '1999')</Pattern>
<Description>[F-LIB313] Invalid UBLExtension/ID when UBLExtension/ExtensionAgencyID is equal to 'Digitaliseringsstyrelsen'. ID must be an assigned value between '1001' and '1999'.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M13" />
<xsl:template match="@*|node()" priority="-2" mode="M13">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M13" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M13" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN profile-->


	<!--RULE -->
<xsl:template match="/" priority="3999" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="local-name(*) = 'Reminder'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(*) = 'Reminder'</Pattern>
<Description>[F-REM001] Root element must be Reminder</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="namespace-uri(*) = 'urn:oasis:names:specification:ubl:schema:xsd:Reminder-2'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>namespace-uri(*) = 'urn:oasis:names:specification:ubl:schema:xsd:Reminder-2'</Pattern>
<Description>[F-REM096] The documenttype does not match an OIOUBL Reminder and can not be validated by this schematron.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder" priority="3998" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:UBLVersionID = '2.0'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UBLVersionID = '2.0'</Pattern>
<Description>[F-LIB001] Invalid UBLVersionID. Must be '2.0'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CustomizationID = 'OIOUBL-2.01' or cbc:CustomizationID = 'OIOUBL-2.02'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CustomizationID = 'OIOUBL-2.01' or cbc:CustomizationID = 'OIOUBL-2.02'</Pattern>
<Description>[F-LIB002] Invalid CustomizationID. Must be either 'OIOUBL-2.01' or 'OIOUBL-2.02'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ProfileID/@schemeID = $Profile1_schemeID or cbc:ProfileID/@schemeID = $Profile2_schemeID or cbc:ProfileID/@schemeID = $Profile3_schemeID or cbc:ProfileID/@schemeID = $Profile4_schemeID or cbc:ProfileID/@schemeID = $Profile5_schemeID or cbc:ProfileID/@schemeID = $Profile6_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile1_schemeID or cbc:ProfileID/@schemeID = $Profile2_schemeID or cbc:ProfileID/@schemeID = $Profile3_schemeID or cbc:ProfileID/@schemeID = $Profile4_schemeID or cbc:ProfileID/@schemeID = $Profile5_schemeID or cbc:ProfileID/@schemeID = $Profile6_schemeID</Pattern>
<Description>[W-LIB003] Invalid schemeID. Must be '<xsl:text />
<xsl:value-of select="$Profile1_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$Profile2_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$Profile3_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$Profile4_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$Profile5_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$Profile6_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ProfileID/@schemeAgencyID = $Profile1_agencyID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeAgencyID = $Profile1_agencyID</Pattern>
<Description>[W-LIB203] Invalid schemeAgencyID. Must be '<xsl:text />
<xsl:value-of select="$Profile1_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:ProfileID/@schemeID = $Profile1_schemeID and not (contains($Profile1, concat(',',cbc:ProfileID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile1_schemeID and not (contains($Profile1, concat(',',cbc:ProfileID,',')))</Pattern>
<Description>[F-LIB004] Invalid ProfileID: '<xsl:text />
<xsl:value-of select="cbc:ProfileID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ProfileID/@schemeID = $Profile2_schemeID and not (contains($Profile2, concat(',',cbc:ProfileID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile2_schemeID and not (contains($Profile2, concat(',',cbc:ProfileID,',')))</Pattern>
<Description>[F-LIB302] Invalid ProfileID: '<xsl:text />
<xsl:value-of select="cbc:ProfileID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ProfileID/@schemeID = $Profile3_schemeID and not (contains($Profile3, concat(',',cbc:ProfileID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile3_schemeID and not (contains($Profile3, concat(',',cbc:ProfileID,',')))</Pattern>
<Description>[F-LIB308] Invalid ProfileID: '<xsl:text />
<xsl:value-of select="cbc:ProfileID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ProfileID/@schemeID = $Profile4_schemeID and not (contains($Profile4, concat(',',cbc:ProfileID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile4_schemeID and not (contains($Profile4, concat(',',cbc:ProfileID,',')))</Pattern>
<Description>[F-LIB325] Invalid ProfileID: '<xsl:text />
<xsl:value-of select="cbc:ProfileID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ProfileID/@schemeID = $Profile5_schemeID and not (contains($Profile5, concat(',',cbc:ProfileID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile5_schemeID and not (contains($Profile5, concat(',',cbc:ProfileID,',')))</Pattern>
<Description>[F-LIB327] Invalid ProfileID: '<xsl:text />
<xsl:value-of select="cbc:ProfileID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ProfileID/@schemeID = $Profile6_schemeID and not (contains($Profile6, concat(',',cbc:ProfileID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile6_schemeID and not (contains($Profile6, concat(',',cbc:ProfileID,',')))</Pattern>
<Description>[F-LIB351] Invalid ProfileID: '<xsl:text />
<xsl:value-of select="cbc:ProfileID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:variable name="Profile" select="cbc:ProfileID" />
<xsl:variable name="Document" select="local-name(/*)" />

		<!--REPORT -->
<xsl:if test="($Profile = 'Procurement-OrdRes-1.0') and not ($Document = 'OrderResponse')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>($Profile = 'Procurement-OrdRes-1.0') and not ($Document = 'OrderResponse')</Pattern>
<Description>[F-LIB328] The profile '<xsl:text />
<xsl:value-of select="$Profile" />
<xsl:text />' is not allowed in the document type '<xsl:text />
<xsl:value-of select="$Document" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="($Profile = 'Procurement-BilSimReminderOnly-1.0') and not ($Document = 'Reminder')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>($Profile = 'Procurement-BilSimReminderOnly-1.0') and not ($Document = 'Reminder')</Pattern>
<Description>[F-LIB352] The profile '<xsl:text />
<xsl:value-of select="$Profile" />
<xsl:text />' is not allowed in the document type '<xsl:text />
<xsl:value-of select="$Document" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M14" />
<xsl:template match="@*|node()" priority="-2" mode="M14">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M14" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M14" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN reminder-->


	<!--RULE -->
<xsl:template match="doc:Reminder" priority="3999" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxPointDate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxPointDate) = 0</Pattern>
<Description>[F-REM002] TaxPointDate element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:LineCountNumeric) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:LineCountNumeric) = 0</Pattern>
<Description>[F-REM003] LineCountNumeric element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReminderTypeCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReminderTypeCode != ''</Pattern>
<Description>[F-REM006] Invalid ReminderTypeCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ReminderSequenceNumeric) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ReminderSequenceNumeric) != ''</Pattern>
<Description>[F-REM007] Invalid ReminderSequenceNumeric. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:DocumentCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentCurrencyCode != ''</Pattern>
<Description>[F-REM008] Invalid DocumentCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-REM010] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReminderTypeCode/@listID = 'urn:oioubl.codelist:remindertypecode-1.1' or cbc:ReminderTypeCode/@listID = 'urn:oioubl:codelist:remindertypecode-1.1'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReminderTypeCode/@listID = 'urn:oioubl.codelist:remindertypecode-1.1' or cbc:ReminderTypeCode/@listID = 'urn:oioubl:codelist:remindertypecode-1.1'</Pattern>
<Description>[F-REM059] Invalid listID. Must be 'urn:oioubl.codelist:remindertypecode-1.1' or 'urn:oioubl:codelist:remindertypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReminderTypeCode/@listAgencyID = '320'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReminderTypeCode/@listAgencyID = '320'</Pattern>
<Description>[F-REM060] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReminderTypeCode = 'Reminder' or cbc:ReminderTypeCode = 'Advis'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReminderTypeCode = 'Reminder' or cbc:ReminderTypeCode = 'Advis'</Pattern>
<Description>[F-REM061] Invalid ReminderTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AccountingCost and cbc:AccountingCostCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AccountingCost and cbc:AccountingCostCode</Pattern>
<Description>[F-LIB021] Use either AccountingCost or AccountingCostCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ReminderPeriod) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ReminderPeriod) &gt; 1</Pattern>
<Description>[F-REM070] No more than one ReminderPeriod class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:UUID" priority="3998" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="string-length(string(.)) = 36" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(string(.)) = 36</Pattern>
<Description>[F-LIB006] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:Note" priority="3997" mode="M15">

		<!--REPORT -->
<xsl:if test="count(../cbc:Note) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Note) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB011] The attribute languageID should be used when more than one <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text /> element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB012] Multilanguage error. Replicated <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text /> elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:DocumentCurrencyCode" priority="3996" mode="M15">

		<!--REPORT -->
<xsl:if test="/*/cac:ReminderLine/cbc:DebitLineAmount[@currencyID][@currencyID!=string(current())]">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>/*/cac:ReminderLine/cbc:DebitLineAmount[@currencyID][@currencyID!=string(current())]</Pattern>
<Description>[F-REM067] There is a DebitLineAmount for one or more Reminder lines where the currencyID does not equal the DocumentCurrencyCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="/*/cac:ReminderLine/cbc:CreditLineAmount[@currencyID][@currencyID!=string(current())]">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>/*/cac:ReminderLine/cbc:CreditLineAmount[@currencyID][@currencyID!=string(current())]</Pattern>
<Description>[F-REM068] There is a CreditLineAmount for one or more Reminder lines where the currencyID does not equal the DocumentCurrencyCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="/*/cac:LegalMonetaryTotal/cbc:LineExtensionAmount[@currencyID][@currencyID!=string(current())]">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>/*/cac:LegalMonetaryTotal/cbc:LineExtensionAmount[@currencyID][@currencyID!=string(current())]</Pattern>
<Description>[F-REM065] There is a LineExtensionAmount where the currencyID does not equal the DocumentCurrencyCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="/*/cac:LegalMonetaryTotal/cbc:PayableAmount[@currencyID][@currencyID!=string(current())]">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>/*/cac:LegalMonetaryTotal/cbc:PayableAmount[@currencyID][@currencyID!=string(current())]</Pattern>
<Description>[F-REM066] There is a PayableAmount where the currencyID does not equal the DocumentCurrencyCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="./@listID and ./@listID != $CurrencyCode_listID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID and ./@listID != $CurrencyCode_listID</Pattern>
<Description>[F-LIB296] Invalid listID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_listID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID</Pattern>
<Description>[F-LIB297] Invalid listAgencyID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="contains($CurrencyCode, concat(',',.,','))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>contains($CurrencyCode, concat(',',.,','))</Pattern>
<Description>[F-LIB298] Invalid CurrencyCode: '<xsl:text />
<xsl:value-of select="." />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:TaxCurrencyCode" priority="3995" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test=".='DKK' or . ='EUR'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>.='DKK' or . ='EUR'</Pattern>
<Description>[F-REM012] TaxCurrencyCode must be either DKK or EUR</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/*/cac:TaxTotal/cac:TaxSubtotal/cbc:TransactionCurrencyTaxAmount) != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(/*/cac:TaxTotal/cac:TaxSubtotal/cbc:TransactionCurrencyTaxAmount) != 0</Pattern>
<Description>[F-REM014] One TransactionCurrencyTaxAmount element must be present when TaxCurrencyCode element is used</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:PricingCurrencyCode" priority="3994" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/*/cac:PricingExchangeRate) != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(/*/cac:PricingExchangeRate) != 0</Pattern>
<Description>[F-REM062] One PricingExchangeRate class must be present when PricingCurrencyCode element is used</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="./@listID and ./@listID != $CurrencyCode_listID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID and ./@listID != $CurrencyCode_listID</Pattern>
<Description>[F-LIB296] Invalid listID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_listID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID</Pattern>
<Description>[F-LIB297] Invalid listAgencyID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="contains($CurrencyCode, concat(',',.,','))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>contains($CurrencyCode, concat(',',.,','))</Pattern>
<Description>[F-LIB298] Invalid CurrencyCode: '<xsl:text />
<xsl:value-of select="." />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:PaymentCurrencyCode" priority="3993" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/*/cac:PaymentExchangeRate) != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(/*/cac:PaymentExchangeRate) != 0</Pattern>
<Description>[F-REM063] One PaymentExchangeRate class must be present when PaymentCurrencyCode element is used</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="./@listID and ./@listID != $CurrencyCode_listID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID and ./@listID != $CurrencyCode_listID</Pattern>
<Description>[F-LIB296] Invalid listID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_listID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID</Pattern>
<Description>[F-LIB297] Invalid listAgencyID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="contains($CurrencyCode, concat(',',.,','))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>contains($CurrencyCode, concat(',',.,','))</Pattern>
<Description>[F-LIB298] Invalid CurrencyCode: '<xsl:text />
<xsl:value-of select="." />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:PaymentAlternativeCurrencyCode" priority="3992" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/*/cac:PaymentAlternativeExchangeRate) != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(/*/cac:PaymentAlternativeExchangeRate) != 0</Pattern>
<Description>[F-REM064] One PaymentAlternativeExchangeRate class must be present when PaymentAlternativeCurrencyCode element is used</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="./@listID and ./@listID != $CurrencyCode_listID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID and ./@listID != $CurrencyCode_listID</Pattern>
<Description>[F-LIB296] Invalid listID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_listID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID</Pattern>
<Description>[F-LIB297] Invalid listAgencyID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="contains($CurrencyCode, concat(',',.,','))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>contains($CurrencyCode, concat(',',.,','))</Pattern>
<Description>[F-LIB298] Invalid CurrencyCode: '<xsl:text />
<xsl:value-of select="." />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M15" />
<xsl:template match="@*|node()" priority="-2" mode="M15">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M15" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M15" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN reminderperiod-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderPeriod" priority="3999" mode="M16">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderPeriod/cbc:Description" priority="3998" mode="M16">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M16" />
<xsl:template match="@*|node()" priority="-2" mode="M16">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M16" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M16" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN additionaldocumentreference-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AdditionalDocumentReference" priority="3999" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:DocumentType or cbc:DocumentTypeCode" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentType or cbc:DocumentTypeCode</Pattern>
<Description>[F-LIB092] Use either DocumentType or DocumentTypeCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB093] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:DocumentType and cbc:DocumentTypeCode != 'ZZZ'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentType and cbc:DocumentTypeCode != 'ZZZ'</Pattern>
<Description>[F-LIB094] Use either DocumentType or DocumentTypeCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB095] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB097] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB098] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB279] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:DocumentTypeCode = 'PersonalSecure') and not (contains($PersonalSecure, concat(',',cbc:ID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:DocumentTypeCode = 'PersonalSecure') and not (contains($PersonalSecure, concat(',',cbc:ID,',')))</Pattern>
<Description>[F-LIB335] When DocumentTypeCode equals 'PersonalSecure', the ID must be either '1', '2' or '3'.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M17" />
<xsl:template match="@*|node()" priority="-2" mode="M17">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M17" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M17" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN signature-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature" priority="3999" mode="M18">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-REM015] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty" priority="3998" mode="M18">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkCareIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkCareIndicator) = 0</Pattern>
<Description>[F-LIB166] MarkCareIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkAttentionIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkAttentionIndicator) = 0</Pattern>
<Description>[F-LIB167] MarkAttentionIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AgentParty) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AgentParty) = 0</Pattern>
<Description>[F-LIB168] AgentParty class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')</Pattern>
<Description>[F-LIB022] PartyName/Name is mandatory if PartyIdentification/ID is not found</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EndpointID and not(contains($EndpointID_schemeID, concat(',',cbc:EndpointID/@schemeID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID and not(contains($EndpointID_schemeID, concat(',',cbc:EndpointID/@schemeID,',')))</Pattern>
<Description>[F-LIB179] Invalid schemeID: '<xsl:text />
<xsl:value-of select="cbc:EndpointID/@schemeID" />
<xsl:text />'. Must be a value from the codelist: '<xsl:text />
<xsl:value-of select="$EndpointID_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB180] schemeID = DK:CVR, EndpointID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)</Pattern>
<Description>[F-LIB215] schemeID = DK:CPR, EndpointID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB181] schemeID = GLN, EndpointID must be a valid GLN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB216] schemeID = EAN, EndpointID must be a valid EAN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:PartyLegalEntity) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyLegalEntity) &gt; 1</Pattern>
<Description>[F-REM069] No more than one PartyLegalEntity class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PartyIdentification" priority="3997" mode="M18">

		<!--REPORT -->
<xsl:if test="not(contains($PartyID_schemeID, concat(',',cbc:ID/@schemeID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(contains($PartyID_schemeID, concat(',',cbc:ID/@schemeID,',')))</Pattern>
<Description>[F-LIB183] Invalid schemeID: '<xsl:text />
<xsl:value-of select="cbc:ID/@schemeID" />
<xsl:text />'. Must be a value from the codelist: '<xsl:text />
<xsl:value-of select="$PartyID_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB184] schemeID = DK:CVR, ID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB217] schemeID = DK:CPR, ID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB185] schemeID = GLN, ID must be a valid GLN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB218] schemeID = EAN, ID must be a valid EAN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB287] schemeID = DK:P, ID must be a valid P number (like '1234567890', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PartyName" priority="3996" mode="M18">

		<!--REPORT -->
<xsl:if test="count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)</Pattern>
<Description>[W-LIB219] The attribute Name@languageID should be used when more than one PartyName class is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID</Pattern>
<Description>[W-LIB220] Multilanguage error. Replicated PartyName classes with same Name@languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PostalAddress" priority="3995" mode="M18">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:AddressFormatCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:AddressFormatCode) != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used, the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB301] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation" priority="3994" mode="M18">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)</Pattern>
<Description>[F-LIB221] If ID not specified, Address is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation/cac:ValidityPeriod" priority="3993" mode="M18">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3992" mode="M18">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation/cac:Address" priority="3991" mode="M18">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:AddressFormatCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:AddressFormatCode) != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used, the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB301] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PartyTaxScheme" priority="3990" mode="M18">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxLevelCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxLevelCode) = 0</Pattern>
<Description>[F-LIB192] TaxLevelCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:CompanyID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:CompanyID) != ''</Pattern>
<Description>[F-LIB193] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ' " />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB195] Invalid schemeID. Must be a valid scheme for PartyTaxScheme/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB196] schemeID = DK:SE, CompanyID must be a valid SE number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PartyTaxScheme/cac:TaxScheme" priority="3989" mode="M18">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB065] Invalid TaxScheme/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:Name) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:Name) != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))</Pattern>
<Description>[F-LIB197] TaxTypeCode must be a value from the '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />' codelist when TaxScheme/ID is different from '63' or 'VAT' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme4_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme5_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))</Pattern>
<Description>[F-LIB071] Invalid listID. Must be either '<xsl:text />
<xsl:value-of select="$TaxType_listID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB337] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the country codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PartyLegalEntity" priority="3988" mode="M18">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:CorporateRegistrationScheme) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:CorporateRegistrationScheme) = 0</Pattern>
<Description>[F-LIB186] CorporateRegistrationScheme class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:CompanyID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:CompanyID) != ''</Pattern>
<Description>[F-LIB187] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB189] Invalid schemeID. Must be a valid scheme for PartyLegalEntity/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB190] schemeID = DK:CVR, CompanyID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)</Pattern>
<Description>[F-LIB191] schemeID = DK:CPR, CompanyID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:Contact" priority="3987" mode="M18">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field in the Contact class should be specified</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')</Pattern>
<Description>[F-LIB237] When Contact/OtherCommunication is used, the element Contact/OtherCommunication/Value must be filled out.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:Person" priority="3986" mode="M18">

		<!--REPORT -->
<xsl:if test="(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')</Pattern>
<Description>[F-LIB024] There must be a FirstName if the FamilyName is not present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:DigitalSignatureAttachment" priority="3985" mode="M18">

		<!--REPORT -->
<xsl:if test="cbc:EmbeddedDocumentBinaryObject and cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EmbeddedDocumentBinaryObject and cac:ExternalReference</Pattern>
<Description>[F-LIB284] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EmbeddedDocumentBinaryObject and not(cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EmbeddedDocumentBinaryObject and not(cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB285] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ExternalReference and not(cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ExternalReference and not(cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB286] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:OriginalDocumentReference" priority="3984" mode="M18">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:DocumentType or cbc:DocumentTypeCode" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentType or cbc:DocumentTypeCode</Pattern>
<Description>[F-LIB092] Use either DocumentType or DocumentTypeCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB093] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:DocumentType and cbc:DocumentTypeCode != 'ZZZ'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentType and cbc:DocumentTypeCode != 'ZZZ'</Pattern>
<Description>[F-LIB094] Use either DocumentType or DocumentTypeCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB095] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB097] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB098] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB279] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:DocumentTypeCode = 'PersonalSecure') and not (contains($PersonalSecure, concat(',',cbc:ID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:DocumentTypeCode = 'PersonalSecure') and not (contains($PersonalSecure, concat(',',cbc:ID,',')))</Pattern>
<Description>[F-LIB335] When DocumentTypeCode equals 'PersonalSecure', the ID must be either '1', '2' or '3'.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M18" />
<xsl:template match="@*|node()" priority="-2" mode="M18">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M18" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M18" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN accountingsupplierparty-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty" priority="3999" mode="M19">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DataSendingCapability) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DataSendingCapability) = 0</Pattern>
<Description>[F-REM016] DataSendingCapability element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:Party) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:Party) = 1</Pattern>
<Description>[F-REM017] Party class must be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party" priority="3998" mode="M19">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkCareIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkCareIndicator) = 0</Pattern>
<Description>[F-LIB166] MarkCareIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkAttentionIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkAttentionIndicator) = 0</Pattern>
<Description>[F-LIB167] MarkAttentionIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AgentParty) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AgentParty) = 0</Pattern>
<Description>[F-LIB168] AgentParty class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:EndpointID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:EndpointID) != ''</Pattern>
<Description>[F-REM018] Invalid EndpointID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PartyLegalEntity) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyLegalEntity) = 1</Pattern>
<Description>[F-REM021] One PartyLegalEntity class must be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')</Pattern>
<Description>[F-LIB022] PartyName/Name is mandatory if PartyIdentification/ID is not found</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EndpointID and not(contains($EndpointID_schemeID, concat(',',cbc:EndpointID/@schemeID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID and not(contains($EndpointID_schemeID, concat(',',cbc:EndpointID/@schemeID,',')))</Pattern>
<Description>[F-LIB179] Invalid schemeID: '<xsl:text />
<xsl:value-of select="cbc:EndpointID/@schemeID" />
<xsl:text />'. Must be a value from the codelist: '<xsl:text />
<xsl:value-of select="$EndpointID_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB180] schemeID = DK:CVR, EndpointID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)</Pattern>
<Description>[F-LIB215] schemeID = DK:CPR, EndpointID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB181] schemeID = GLN, EndpointID must be a valid GLN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB216] schemeID = EAN, EndpointID must be a valid EAN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification" priority="3997" mode="M19">

		<!--REPORT -->
<xsl:if test="not(contains($PartyID_schemeID, concat(',',cbc:ID/@schemeID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(contains($PartyID_schemeID, concat(',',cbc:ID/@schemeID,',')))</Pattern>
<Description>[F-LIB183] Invalid schemeID: '<xsl:text />
<xsl:value-of select="cbc:ID/@schemeID" />
<xsl:text />'. Must be a value from the codelist: '<xsl:text />
<xsl:value-of select="$PartyID_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB184] schemeID = DK:CVR, ID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB217] schemeID = DK:CPR, ID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB185] schemeID = GLN, ID must be a valid GLN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB218] schemeID = EAN, ID must be a valid EAN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB287] schemeID = DK:P, ID must be a valid P number (like '1234567890', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PartyName" priority="3996" mode="M19">

		<!--REPORT -->
<xsl:if test="count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)</Pattern>
<Description>[W-LIB219] The attribute Name@languageID should be used when more than one PartyName class is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID</Pattern>
<Description>[W-LIB220] Multilanguage error. Replicated PartyName classes with same Name@languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress" priority="3995" mode="M19">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:AddressFormatCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:AddressFormatCode) != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used, the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB301] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation" priority="3994" mode="M19">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)</Pattern>
<Description>[F-LIB221] If ID not specified, Address is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:ValidityPeriod" priority="3993" mode="M19">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3992" mode="M19">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address" priority="3991" mode="M19">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:AddressFormatCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:AddressFormatCode) != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used, the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB301] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme" priority="3990" mode="M19">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxLevelCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxLevelCode) = 0</Pattern>
<Description>[F-LIB192] TaxLevelCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:CompanyID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:CompanyID) != ''</Pattern>
<Description>[F-LIB193] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ' " />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB195] Invalid schemeID. Must be a valid scheme for PartyTaxScheme/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB196] schemeID = DK:SE, CompanyID must be a valid SE number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme" priority="3989" mode="M19">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB065] Invalid TaxScheme/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:Name) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:Name) != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))</Pattern>
<Description>[F-LIB197] TaxTypeCode must be a value from the '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />' codelist when TaxScheme/ID is different from '63' or 'VAT' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme4_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme5_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))</Pattern>
<Description>[F-LIB071] Invalid listID. Must be either '<xsl:text />
<xsl:value-of select="$TaxType_listID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB337] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the country codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity" priority="3988" mode="M19">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:CorporateRegistrationScheme) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:CorporateRegistrationScheme) = 0</Pattern>
<Description>[F-LIB186] CorporateRegistrationScheme class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:CompanyID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:CompanyID) != ''</Pattern>
<Description>[F-LIB187] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB189] Invalid schemeID. Must be a valid scheme for PartyLegalEntity/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB190] schemeID = DK:CVR, CompanyID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)</Pattern>
<Description>[F-LIB191] schemeID = DK:CPR, CompanyID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:Contact" priority="3987" mode="M19">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field in the Contact class should be specified</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')</Pattern>
<Description>[F-LIB237] When Contact/OtherCommunication is used, the element Contact/OtherCommunication/Value must be filled out.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:Person" priority="3986" mode="M19">

		<!--REPORT -->
<xsl:if test="(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')</Pattern>
<Description>[F-LIB024] There must be a FirstName if the FamilyName is not present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:SellerSupplierParty/cac:DespatchContact" priority="3985" mode="M19">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field in the Contact class should be specified</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')</Pattern>
<Description>[F-LIB237] When Contact/OtherCommunication is used, the element Contact/OtherCommunication/Value must be filled out.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:SellerSupplierParty/cac:AccountingContact" priority="3984" mode="M19">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field in the Contact class should be specified</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')</Pattern>
<Description>[F-LIB237] When Contact/OtherCommunication is used, the element Contact/OtherCommunication/Value must be filled out.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:SellerSupplierParty/cac:SellerContact" priority="3983" mode="M19">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field in the Contact class should be specified</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')</Pattern>
<Description>[F-LIB237] When Contact/OtherCommunication is used, the element Contact/OtherCommunication/Value must be filled out.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M19" />
<xsl:template match="@*|node()" priority="-2" mode="M19">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M19" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M19" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN accountingcustomerparty-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty" priority="3999" mode="M20">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:Party) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:Party) = 1</Pattern>
<Description>[F-REM024] One Party class must be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party" priority="3998" mode="M20">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkCareIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkCareIndicator) = 0</Pattern>
<Description>[F-LIB166] MarkCareIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkAttentionIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkAttentionIndicator) = 0</Pattern>
<Description>[F-LIB167] MarkAttentionIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AgentParty) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AgentParty) = 0</Pattern>
<Description>[F-LIB168] AgentParty class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:EndpointID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:EndpointID) != ''</Pattern>
<Description>[F-REM025] Invalid EndpointID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:Contact) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:Contact) = 1</Pattern>
<Description>[F-REM071] One Contact class must be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')</Pattern>
<Description>[F-LIB022] PartyName/Name is mandatory if PartyIdentification/ID is not found</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EndpointID and not(contains($EndpointID_schemeID, concat(',',cbc:EndpointID/@schemeID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID and not(contains($EndpointID_schemeID, concat(',',cbc:EndpointID/@schemeID,',')))</Pattern>
<Description>[F-LIB179] Invalid schemeID: '<xsl:text />
<xsl:value-of select="cbc:EndpointID/@schemeID" />
<xsl:text />'. Must be a value from the codelist: '<xsl:text />
<xsl:value-of select="$EndpointID_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB180] schemeID = DK:CVR, EndpointID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)</Pattern>
<Description>[F-LIB215] schemeID = DK:CPR, EndpointID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB181] schemeID = GLN, EndpointID must be a valid GLN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB216] schemeID = EAN, EndpointID must be a valid EAN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:PartyLegalEntity) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyLegalEntity) &gt; 1</Pattern>
<Description>[F-REM093] No more than one PartyLegalEntity class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification" priority="3997" mode="M20">

		<!--REPORT -->
<xsl:if test="not(contains($PartyID_schemeID, concat(',',cbc:ID/@schemeID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(contains($PartyID_schemeID, concat(',',cbc:ID/@schemeID,',')))</Pattern>
<Description>[F-LIB183] Invalid schemeID: '<xsl:text />
<xsl:value-of select="cbc:ID/@schemeID" />
<xsl:text />'. Must be a value from the codelist: '<xsl:text />
<xsl:value-of select="$PartyID_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB184] schemeID = DK:CVR, ID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB217] schemeID = DK:CPR, ID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB185] schemeID = GLN, ID must be a valid GLN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB218] schemeID = EAN, ID must be a valid EAN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB287] schemeID = DK:P, ID must be a valid P number (like '1234567890', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PartyName" priority="3996" mode="M20">

		<!--REPORT -->
<xsl:if test="count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)</Pattern>
<Description>[W-LIB219] The attribute Name@languageID should be used when more than one PartyName class is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID</Pattern>
<Description>[W-LIB220] Multilanguage error. Replicated PartyName classes with same Name@languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress" priority="3995" mode="M20">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:AddressFormatCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:AddressFormatCode) != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used, the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB301] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation" priority="3994" mode="M20">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)</Pattern>
<Description>[F-LIB221] If ID not specified, Address is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:ValidityPeriod" priority="3993" mode="M20">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3992" mode="M20">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address" priority="3991" mode="M20">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:AddressFormatCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:AddressFormatCode) != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used, the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB301] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme" priority="3990" mode="M20">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxLevelCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxLevelCode) = 0</Pattern>
<Description>[F-LIB192] TaxLevelCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:CompanyID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:CompanyID) != ''</Pattern>
<Description>[F-LIB193] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ' " />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB195] Invalid schemeID. Must be a valid scheme for PartyTaxScheme/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB196] schemeID = DK:SE, CompanyID must be a valid SE number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme" priority="3989" mode="M20">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB065] Invalid TaxScheme/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:Name) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:Name) != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))</Pattern>
<Description>[F-LIB197] TaxTypeCode must be a value from the '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />' codelist when TaxScheme/ID is different from '63' or 'VAT' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme4_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme5_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))</Pattern>
<Description>[F-LIB071] Invalid listID. Must be either '<xsl:text />
<xsl:value-of select="$TaxType_listID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB337] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the country codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity" priority="3988" mode="M20">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:CorporateRegistrationScheme) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:CorporateRegistrationScheme) = 0</Pattern>
<Description>[F-LIB186] CorporateRegistrationScheme class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:CompanyID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:CompanyID) != ''</Pattern>
<Description>[F-LIB187] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB189] Invalid schemeID. Must be a valid scheme for PartyLegalEntity/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB190] schemeID = DK:CVR, CompanyID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)</Pattern>
<Description>[F-LIB191] schemeID = DK:CPR, CompanyID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:Contact" priority="3987" mode="M20">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field in the Contact class should be specified</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')</Pattern>
<Description>[F-LIB237] When Contact/OtherCommunication is used, the element Contact/OtherCommunication/Value must be filled out.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:Person" priority="3986" mode="M20">

		<!--REPORT -->
<xsl:if test="(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')</Pattern>
<Description>[F-LIB024] There must be a FirstName if the FamilyName is not present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:DeliveryContact" priority="3985" mode="M20">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field in the Contact class should be specified</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')</Pattern>
<Description>[F-LIB237] When Contact/OtherCommunication is used, the element Contact/OtherCommunication/Value must be filled out.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:AccountingContact" priority="3984" mode="M20">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field in the Contact class should be specified</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')</Pattern>
<Description>[F-LIB237] When Contact/OtherCommunication is used, the element Contact/OtherCommunication/Value must be filled out.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:BuyerContact" priority="3983" mode="M20">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field in the Contact class should be specified</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')</Pattern>
<Description>[F-LIB237] When Contact/OtherCommunication is used, the element Contact/OtherCommunication/Value must be filled out.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M20" />
<xsl:template match="@*|node()" priority="-2" mode="M20">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M20" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M20" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN payeeparty-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty" priority="3999" mode="M21">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkCareIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkCareIndicator) = 0</Pattern>
<Description>[F-LIB166] MarkCareIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkAttentionIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkAttentionIndicator) = 0</Pattern>
<Description>[F-LIB167] MarkAttentionIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AgentParty) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AgentParty) = 0</Pattern>
<Description>[F-LIB168] AgentParty class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:EndpointID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:EndpointID) != ''</Pattern>
<Description>[F-REM034] Invalid EndpointID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')</Pattern>
<Description>[F-LIB022] PartyName/Name is mandatory if PartyIdentification/ID is not found</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EndpointID and not(contains($EndpointID_schemeID, concat(',',cbc:EndpointID/@schemeID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID and not(contains($EndpointID_schemeID, concat(',',cbc:EndpointID/@schemeID,',')))</Pattern>
<Description>[F-LIB179] Invalid schemeID: '<xsl:text />
<xsl:value-of select="cbc:EndpointID/@schemeID" />
<xsl:text />'. Must be a value from the codelist: '<xsl:text />
<xsl:value-of select="$EndpointID_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB180] schemeID = DK:CVR, EndpointID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)</Pattern>
<Description>[F-LIB215] schemeID = DK:CPR, EndpointID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB181] schemeID = GLN, EndpointID must be a valid GLN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB216] schemeID = EAN, EndpointID must be a valid EAN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:EndpointID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:PartyLegalEntity) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyLegalEntity) &gt; 1</Pattern>
<Description>[F-REM072] No more than one PartyLegalEntity class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PartyIdentification" priority="3998" mode="M21">

		<!--REPORT -->
<xsl:if test="not(contains($PartyID_schemeID, concat(',',cbc:ID/@schemeID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(contains($PartyID_schemeID, concat(',',cbc:ID/@schemeID,',')))</Pattern>
<Description>[F-LIB183] Invalid schemeID: '<xsl:text />
<xsl:value-of select="cbc:ID/@schemeID" />
<xsl:text />'. Must be a value from the codelist: '<xsl:text />
<xsl:value-of select="$PartyID_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB184] schemeID = DK:CVR, ID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB217] schemeID = DK:CPR, ID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB185] schemeID = GLN, ID must be a valid GLN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB218] schemeID = EAN, ID must be a valid EAN number (like '1234567890123', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB287] schemeID = DK:P, ID must be a valid P number (like '1234567890', value found: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PartyName" priority="3997" mode="M21">

		<!--REPORT -->
<xsl:if test="count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)</Pattern>
<Description>[W-LIB219] The attribute Name@languageID should be used when more than one PartyName class is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID</Pattern>
<Description>[W-LIB220] Multilanguage error. Replicated PartyName classes with same Name@languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PostalAddress" priority="3996" mode="M21">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:AddressFormatCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:AddressFormatCode) != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used, the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB301] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PhysicalLocation" priority="3995" mode="M21">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)</Pattern>
<Description>[F-LIB221] If ID not specified, Address is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PhysicalLocation/cac:ValidityPeriod" priority="3994" mode="M21">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3993" mode="M21">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PhysicalLocation/cac:Address" priority="3992" mode="M21">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:AddressFormatCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:AddressFormatCode) != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(normalize-space(cbc:AddressFormatCode) = 'StructuredDK' or normalize-space(cbc:AddressFormatCode) = 'StructuredLax' or normalize-space(cbc:AddressFormatCode) = 'StructuredID' or normalize-space(cbc:AddressFormatCode) = 'StructuredRegion' or normalize-space(cbc:AddressFormatCode) = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used, the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or normalize-space(cbc:PostalZone) = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or normalize-space(cbc:StreetName) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or normalize-space(cbc:BuildingNumber) = '') and (not(cbc:Postbox) or normalize-space(cbc:Postbox) = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country/cbc:IdentificationCode and not(contains($CountryCode, concat(',',cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB301] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PartyTaxScheme" priority="3991" mode="M21">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxLevelCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxLevelCode) = 0</Pattern>
<Description>[F-LIB192] TaxLevelCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:CompanyID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:CompanyID) != ''</Pattern>
<Description>[F-LIB193] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ' " />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB195] Invalid schemeID. Must be a valid scheme for PartyTaxScheme/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB196] schemeID = DK:SE, CompanyID must be a valid SE number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PartyTaxScheme/cac:TaxScheme" priority="3990" mode="M21">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB065] Invalid TaxScheme/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:Name) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:Name) != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))</Pattern>
<Description>[F-LIB197] TaxTypeCode must be a value from the '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />' codelist when TaxScheme/ID is different from '63' or 'VAT' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme4_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme5_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))</Pattern>
<Description>[F-LIB071] Invalid listID. Must be either '<xsl:text />
<xsl:value-of select="$TaxType_listID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB337] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the country codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PartyLegalEntity" priority="3989" mode="M21">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:CorporateRegistrationScheme) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:CorporateRegistrationScheme) = 0</Pattern>
<Description>[F-LIB186] CorporateRegistrationScheme class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:CompanyID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:CompanyID) != ''</Pattern>
<Description>[F-LIB187] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB189] Invalid schemeID. Must be a valid scheme for PartyLegalEntity/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB190] schemeID = DK:CVR, CompanyID must be a valid CVR number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)</Pattern>
<Description>[F-LIB191] schemeID = DK:CPR, CompanyID must be a valid CPR number (like '1234560000', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:Contact" priority="3988" mode="M21">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field in the Contact class should be specified</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and (normalize-space(cac:OtherCommunication/cbc:Value) = '')</Pattern>
<Description>[F-LIB237] When Contact/OtherCommunication is used, the element Contact/OtherCommunication/Value must be filled out.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:Person" priority="3987" mode="M21">

		<!--REPORT -->
<xsl:if test="(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')</Pattern>
<Description>[F-LIB024] There must be a FirstName if the FamilyName is not present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M21" />
<xsl:template match="@*|node()" priority="-2" mode="M21">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M21" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M21" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN taxRepresentativeParty-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxRepresentativeParty" priority="3999" mode="M22">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:WebsiteURI) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:WebsiteURI) = 0</Pattern>
<Description>[F-LIB355] WebsiteURI element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:LogoReferenceID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:LogoReferenceID) = 0</Pattern>
<Description>[F-LIB356] LogoReferenceID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:EndpointID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:EndpointID) = 0</Pattern>
<Description>[F-LIB357] EndpointID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PartyIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyIdentification) = 0</Pattern>
<Description>[F-LIB358] PartyIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:Language) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:Language) = 0</Pattern>
<Description>[F-LIB359] Language element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PhysicalLocation) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PhysicalLocation) = 0</Pattern>
<Description>[F-LIB360] PhysicalLocation element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PartyLegalEntity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyLegalEntity) = 0</Pattern>
<Description>[F-LIB361] PartyLegalEntity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:Contact) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:Contact) = 0</Pattern>
<Description>[F-LIB362] Contact element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:Person) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:Person) = 0</Pattern>
<Description>[F-LIB363] Person element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cac:PartyName and cac:PartyName/cbc:Name and (normalize-space(cac:PartyName/cbc:Name) != '')" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PartyName and cac:PartyName/cbc:Name and (normalize-space(cac:PartyName/cbc:Name) != '')</Pattern>
<Description>[F-LIB353] PartyName/Name is mandatory in TaxRepresentativeParty</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cac:PostalAddress and cac:PostalAddress/cbc:AddressFormatCode and (normalize-space(cac:PostalAddress/cbc:AddressFormatCode) != '')" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PostalAddress and cac:PostalAddress/cbc:AddressFormatCode and (normalize-space(cac:PostalAddress/cbc:AddressFormatCode) != '')</Pattern>
<Description>[F-LIB354] PostalAddress/AddressFormatCode is mandatory in TaxRepresentativeParty</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cac:PartyTaxScheme" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PartyTaxScheme</Pattern>
<Description>[F-LIB371] PartyTaxScheme is mandatory in TaxRepresentativeParty</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="(not(cac:PartyTaxScheme)) or cac:PartyTaxScheme/cac:TaxScheme" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cac:PartyTaxScheme)) or cac:PartyTaxScheme/cac:TaxScheme</Pattern>
<Description>[F-LIB372] PartyTaxScheme/TaxScheme is mandatory in TaxRepresentativeParty</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M22" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxRepresentativeParty/cac:PartyTaxScheme" priority="3998" mode="M22">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxLevelCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxLevelCode) = 0</Pattern>
<Description>[F-LIB192] TaxLevelCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:CompanyID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:CompanyID) != ''</Pattern>
<Description>[F-LIB193] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ' " />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB195] Invalid schemeID. Must be a valid scheme for PartyTaxScheme/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(normalize-space(cbc:CompanyID)) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB196] schemeID = DK:SE, CompanyID must be a valid SE number (like 'DK12345678', value found: '<xsl:text />
<xsl:value-of select="cbc:CompanyID" />
<xsl:text />')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M22" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxRepresentativeParty/cac:PartyTaxScheme/cac:TaxScheme" priority="3997" mode="M22">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB065] Invalid TaxScheme/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:Name) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:Name) != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))</Pattern>
<Description>[F-LIB197] TaxTypeCode must be a value from the '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />' codelist when TaxScheme/ID is different from '63' or 'VAT' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme4_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme5_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))</Pattern>
<Description>[F-LIB071] Invalid listID. Must be either '<xsl:text />
<xsl:value-of select="$TaxType_listID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB337] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the country codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M22" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M22" />
<xsl:template match="@*|node()" priority="-2" mode="M22">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M22" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M22" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN paymentmeans-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentMeans" priority="3999" mode="M23">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cac:Address) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cac:Address) = 0</Pattern>
<Description>[F-LIB151] Address class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PayerFinancialAccount/cac:Country) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PayerFinancialAccount/cac:Country) = 0</Pattern>
<Description>[F-LIB162] Country class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cac:Address) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cac:Address) = 0</Pattern>
<Description>[F-LIB243] Address class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PayeeFinancialAccount/cac:Country) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PayeeFinancialAccount/cac:Country) = 0</Pattern>
<Description>[F-LIB244] Country class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:PaymentMeansCode = '1' or cbc:PaymentMeansCode = '10' or cbc:PaymentMeansCode = '20' or cbc:PaymentMeansCode = '31' or cbc:PaymentMeansCode = '42' or cbc:PaymentMeansCode = '48' or cbc:PaymentMeansCode = '49' or cbc:PaymentMeansCode = '50' or cbc:PaymentMeansCode = '93' or cbc:PaymentMeansCode = '97'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '1' or cbc:PaymentMeansCode = '10' or cbc:PaymentMeansCode = '20' or cbc:PaymentMeansCode = '31' or cbc:PaymentMeansCode = '42' or cbc:PaymentMeansCode = '48' or cbc:PaymentMeansCode = '49' or cbc:PaymentMeansCode = '50' or cbc:PaymentMeansCode = '93' or cbc:PaymentMeansCode = '97'</Pattern>
<Description>[F-LIB100] Invalid PaymentMeansCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="count(../cac:PaymentMeans) &gt; 1 and not(cbc:ID != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PaymentMeans) &gt; 1 and not(cbc:ID != '')</Pattern>
<Description>[W-LIB241] PaymentMeans/ID should be used when more than one instance of the PaymentMeans class is present.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:PayerFinancialAccount/cbc:AccountTypeCode and not(cac:PayerFinancialAccount/cbc:AccountTypeCode/@listID = 'urn:oioubl:codelist:accounttypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PayerFinancialAccount/cbc:AccountTypeCode and not(cac:PayerFinancialAccount/cbc:AccountTypeCode/@listID = 'urn:oioubl:codelist:accounttypecode-1.1')</Pattern>
<Description>[F-LIB105] Invalid listID. Must be 'urn:oioubl:codelist:accounttypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:PayerFinancialAccount/cbc:AccountTypeCode and not(cac:PayerFinancialAccount/cbc:AccountTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PayerFinancialAccount/cbc:AccountTypeCode and not(cac:PayerFinancialAccount/cbc:AccountTypeCode/@listAgencyID = '320')</Pattern>
<Description>[W-LIB121] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:PayeeFinancialAccount/cbc:AccountTypeCode and not(cac:PayeeFinancialAccount/cbc:AccountTypeCode/@listID = 'urn:oioubl:codelist:accounttypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PayeeFinancialAccount/cbc:AccountTypeCode and not(cac:PayeeFinancialAccount/cbc:AccountTypeCode/@listID = 'urn:oioubl:codelist:accounttypecode-1.1')</Pattern>
<Description>[F-LIB136] Invalid listID. Must be 'urn:oioubl:codelist:accounttypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:PayeeFinancialAccount/cbc:AccountTypeCode and not(cac:PayeeFinancialAccount/cbc:AccountTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PayeeFinancialAccount/cbc:AccountTypeCode and not(cac:PayeeFinancialAccount/cbc:AccountTypeCode/@listAgencyID = '320')</Pattern>
<Description>[W-LIB141] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and (cbc:InstructionID != '') and ((string-length(cbc:InstructionID)&gt; 25) or not(starts-with(cbc:InstructionID, 'RF')) )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and (cbc:InstructionID != '') and ((string-length(cbc:InstructionID)&gt; 25) or not(starts-with(cbc:InstructionID, 'RF')) )</Pattern>
<Description>[F-LIB330] PaymentMeansCode = 31, InstructionID element must start with 'RF' and be no more than 25 characters.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and cbc:InstructionNote">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and cbc:InstructionNote</Pattern>
<Description>[F-LIB103] PaymentMeansCode = 31, InstructionNote element not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and cbc:PaymentID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and cbc:PaymentID</Pattern>
<Description>[F-LIB104] PaymentMeansCode = 31, PaymentID element not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')</Pattern>
<Description>[F-LIB106] PaymentMeansCode = 31, Invalid listID. Must be 'urn:oioubl:codelist:paymentchannelcode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and not(cac:PayeeFinancialAccount/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and not(cac:PayeeFinancialAccount/cbc:ID)</Pattern>
<Description>[F-LIB107] PaymentMeansCode = 31, ID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and not(cbc:PaymentChannelCode = 'IBAN' or cbc:PaymentChannelCode = 'ZZZ')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and not(cbc:PaymentChannelCode = 'IBAN' or cbc:PaymentChannelCode = 'ZZZ')</Pattern>
<Description>[F-LIB109] PaymentMeansCode = 31, PaymentChannelCode must equal IBAN or ZZZ</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20</Pattern>
<Description>[F-LIB110] PaymentMeansCode = 31, PaymentNote must be no more than 20 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and string-length(cac:PayeeFinancialAccount/cbc:PaymentNote)&gt; 20">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and string-length(cac:PayeeFinancialAccount/cbc:PaymentNote)&gt; 20</Pattern>
<Description>[F-LIB111] PaymentMeansCode = 31, PaymentNote must be no more than 20 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and string-length(cac:CreditAccount/cbc:AccountID) &gt; 8">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and string-length(cac:CreditAccount/cbc:AccountID) &gt; 8</Pattern>
<Description>[F-LIB112] PaymentMeansCode = 31, AccountID must be no more than 8 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and (cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and (cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)</Pattern>
<Description>[F-LIB108] PaymentMeansCode = 31, FinancialInstitutionBranch/ID (Registreringsnummer) element is not used, when PaymentChannelCode equals IBAN</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID)</Pattern>
<Description>[F-LIB113] PaymentMeansCode = 31, ID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayeeFinancialAccount/cbc:ID) &gt; 34">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayeeFinancialAccount/cbc:ID) &gt; 34</Pattern>
<Description>[F-LIB114] PaymentMeansCode = 31, Account ID must be no more than 34 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayeeFinancialAccount/cbc:ID) &lt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayeeFinancialAccount/cbc:ID) &lt; 1</Pattern>
<Description>[F-LIB115] PaymentMeansCode = 31, Account ID must must not be empty.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)</Pattern>
<Description>[F-LIB276] PaymentMeansCode = 31, FinancialInstitutionBranch/ID (Registreringsnummer) element is mandatory, when PaymentChannelCode equals ZZZ</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:Name)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:Name)</Pattern>
<Description>[F-LIB116] PaymentMeansCode = 31, FinancialInstitutionBranch/Name element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address)</Pattern>
<Description>[F-LIB117] PaymentMeansCode = 31, FinancialInstitutionBranch/Address class is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and cac:CreditAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and cac:CreditAccount</Pattern>
<Description>[F-LIB122] PaymentMeansCode = 42, CreditAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and cbc:PaymentID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and cbc:PaymentID</Pattern>
<Description>[F-LIB120] PaymentMeansCode = 42, PaymentID element not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and cbc:InstructionNote">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and cbc:InstructionNote</Pattern>
<Description>[F-LIB119] PaymentMeansCode = 42, InstructionNote element not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and (cbc:InstructionID != '') and ((string-length(cbc:InstructionID)&gt; 25) or not(starts-with(cbc:InstructionID, 'RF')) )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and (cbc:InstructionID != '') and ((string-length(cbc:InstructionID)&gt; 25) or not(starts-with(cbc:InstructionID, 'RF')) )</Pattern>
<Description>[F-LIB331] PaymentMeansCode = 42, InstructionID element must be maximum 25 characters and start with 'RF'.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and not (cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and not (cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')</Pattern>
<Description>[F-LIB123] PaymentMeansCode = 42, Invalid listID. Must be 'urn:oioubl:codelist:paymentchannelcode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and cbc:PaymentChannelCode != 'DK:BANK'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and cbc:PaymentChannelCode != 'DK:BANK'</Pattern>
<Description>[F-LIB128] PaymentMeansCode = 42, PaymentChannelCode must equal DK:BANK</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20</Pattern>
<Description>[F-LIB129] PaymentMeansCode = 42, PaymentNote must be no more than 20 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cbc:PaymentNote)&gt; 20">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cbc:PaymentNote)&gt; 20</Pattern>
<Description>[F-LIB133] PaymentMeansCode = 42, PaymentNote must be no more than 20 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and (cac:PayerFinancialAccount/cac:FinancialInstitutionBranch) and not(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and (cac:PayerFinancialAccount/cac:FinancialInstitutionBranch) and not(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)</Pattern>
<Description>[F-LIB124] PaymentMeansCode = 42, FinancialInstitutionBranch/ID (Registreringsnummer) element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount)</Pattern>
<Description>[F-LIB125] PaymentMeansCode = 42, PayeeFinancialAccount class is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount/cbc:ID)</Pattern>
<Description>[F-LIB126] PaymentMeansCode = 42, Account ID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)</Pattern>
<Description>[F-LIB127] PaymentMeansCode = 42, FinancialInstitutionBranch/ID (Registreringsnummer)  element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and string-length(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID) &gt; 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and string-length(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID) &gt; 4</Pattern>
<Description>[F-LIB130] PaymentMeansCode = 42, FinancialInstitutionBranch/ID (Registreringsnummer) must be no more than 4 numerical characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cbc:ID)&gt; 10">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cbc:ID)&gt; 10</Pattern>
<Description>[F-LIB131] PaymentMeansCode = 42,  Account ID must be no more than 10 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)&gt; 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)&gt; 4</Pattern>
<Description>[F-LIB132] PaymentMeansCode = 42, FinancialInstitutionBranch/ID (Registreringsnummer) must be no more than 4 numerical characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and not(number(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and not(number(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID))</Pattern>
<Description>[F-LIB311] FinancialInstitutionBranch/ID (Registreringsnummer) must contain a numerical value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cbc:PaymentDueDate">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cbc:PaymentDueDate</Pattern>
<Description>[F-LIB364] When PaymentMeansCode is '48', PaymentDueDate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cbc:PaymentChannelCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cbc:PaymentChannelCode</Pattern>
<Description>[F-LIB365] When PaymentMeansCode is '48', PaymentChannelCode class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cbc:InstructionID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cbc:InstructionID</Pattern>
<Description>[F-LIB366] When PaymentMeansCode is '48', InstructionID class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cbc:InstructionNote">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cbc:InstructionNote</Pattern>
<Description>[F-LIB367] When PaymentMeansCode is '48', InstructionNote class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:PayerFinancialAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:PayerFinancialAccount</Pattern>
<Description>[F-LIB368] When PaymentMeansCode is '48', PayerFinancialAccount class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:PayeeFinancialAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:PayeeFinancialAccount</Pattern>
<Description>[F-LIB369] When PaymentMeansCode is '48', PayeeFinancialAccount class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:CreditAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:CreditAccount</Pattern>
<Description>[F-LIB370] When PaymentMeansCode is '48', CreditAccount class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and not (cac:CardAccount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and not (cac:CardAccount)</Pattern>
<Description>[F-LIB342] When PaymentMeansCode is '48', the CardAccount class must be used</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:CardTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:CardTypeCode</Pattern>
<Description>[F-LIB343] When PaymentMeansCode is '48', CardAccount/CardTypeCode class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:ValidityStartDate">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:ValidityStartDate</Pattern>
<Description>[F-LIB344] When PaymentMeansCode is '48', CardAccount/ValidityStartDate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:ExpiryDate">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:ExpiryDate</Pattern>
<Description>[F-LIB345] When PaymentMeansCode is '48', CardAccount/ExpiryDate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:IssuerID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:IssuerID</Pattern>
<Description>[F-LIB346] When PaymentMeansCode is '48', CardAccount/IssuerID class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:IssueNumberID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:IssueNumberID</Pattern>
<Description>[F-LIB347] When PaymentMeansCode is '48', CardAccount/IssueNumberID class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:CV2ID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:CV2ID</Pattern>
<Description>[F-LIB348] When PaymentMeansCode is '48', CardAccount/CV2ID class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:CardChipCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:CardChipCode</Pattern>
<Description>[F-LIB349] When PaymentMeansCode is '48', CardAccount/CardChipCode class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:ChipApplicationID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '48' and cac:CardAccount/cbc:ChipApplicationID</Pattern>
<Description>[F-LIB350] When PaymentMeansCode is '48', CardAccount/ChipApplicationID class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49') and cbc:InstructionNote">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49') and cbc:InstructionNote</Pattern>
<Description>[F-LIB135] PaymentMeansCode = 49, InstructionNote element not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49') and cac:CreditAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49') and cac:CreditAccount</Pattern>
<Description>[F-LIB137] PaymentMeansCode = 49, CreditAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49') and cbc:PaymentChannelCode and cbc:InstructionID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49') and cbc:PaymentChannelCode and cbc:InstructionID</Pattern>
<Description>[F-LIB134] PaymentMeansCode = 49, Use either PaymentChannelCode or InstructionID element</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20</Pattern>
<Description>[F-LIB288] PaymentMeansCode = 49, PaymentNote must be no more than 20 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode = 'IBAN' or cbc:PaymentChannelCode = 'DK:BANK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode = 'IBAN' or cbc:PaymentChannelCode = 'DK:BANK')</Pattern>
<Description>[F-LIB289] PaymentMeansCode = 49, If present, PaymentChannelCode must equal IBAN or DK:BANK</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49') and string-length(cbc:InstructionID) &gt; 60">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49') and string-length(cbc:InstructionID) &gt; 60</Pattern>
<Description>[F-LIB140] PaymentMeansCode = 49, InstructionID must be no more than 60 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'DK:BANK') and (string-length(cac:PayerFinancialAccount/cbc:ID) != 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'DK:BANK') and (string-length(cac:PayerFinancialAccount/cbc:ID) != 10)</Pattern>
<Description>[F-LIB290] PaymentMeansCode = 49, For DK:BANK, Account ID must be 10 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'DK:BANK') and (string-length(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID) != 4)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'DK:BANK') and (string-length(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID) != 4)</Pattern>
<Description>[F-LIB291] PaymentMeansCode = 49, For DK:BANK, FinancialInstitutionBranch/ID (Registreringsnummer) must be 4 numerical characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayerFinancialAccount/cbc:ID) &gt; 34">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayerFinancialAccount/cbc:ID) &gt; 34</Pattern>
<Description>[F-LIB292] PaymentMeansCode = 49, For IBAN, Account ID must be no more than 34 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayerFinancialAccount/cbc:ID) &lt; 18">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayerFinancialAccount/cbc:ID) &lt; 18</Pattern>
<Description>[F-LIB293] PaymentMeansCode = 49, For IBAN, Account ID must be at least 18 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and (cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and (cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)</Pattern>
<Description>[F-LIB294] PaymentMeansCode = 49, FinancialInstitutionBranch/ID (Registreringsnummer) element is not used, when PaymentChannelCode equals IBAN</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and not(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and not(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID)</Pattern>
<Description>[F-LIB295] PaymentMeansCode = 49, For IBAN, ID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and cac:CreditAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and cac:CreditAccount</Pattern>
<Description>[F-LIB142] PaymentMeansCode = 50, CreditAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and not(cbc:PaymentID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and not(cbc:PaymentID)</Pattern>
<Description>[F-LIB144] PaymentMeansCode = 50, PaymentID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and not(cac:PayeeFinancialAccount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and not(cac:PayeeFinancialAccount)</Pattern>
<Description>[F-LIB319] PaymentMeansCode = 50, PayeeFinancialAccount class is mandatory.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and not(cac:PayeeFinancialAccount/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and not(cac:PayeeFinancialAccount/cbc:ID)</Pattern>
<Description>[F-LIB320] PaymentMeansCode = 50, PayeeFinancialAccount.ID element is mandatory.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and (cbc:PaymentID = '04' or cbc:PaymentID = '15') and not(cbc:InstructionID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and (cbc:PaymentID = '04' or cbc:PaymentID = '15') and not(cbc:InstructionID)</Pattern>
<Description>[F-LIB145] PaymentMeansCode = 50, InstructionID is mandatory when PaymentID equals 04 or 15</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50' and cbc:PaymentChannelCode) and cbc:PaymentChannelCode != 'DK:GIRO'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50' and cbc:PaymentChannelCode) and cbc:PaymentChannelCode != 'DK:GIRO'</Pattern>
<Description>[F-LIB146] PaymentMeansCode = 50, PaymentChannelCode must equal DK:GIRO</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')</Pattern>
<Description>[F-LIB143] PaymentMeansCode = 50, Invalid listID. Must be 'urn:oioubl:codelist:paymentchannelcode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and not(cbc:PaymentID = '01' or cbc:PaymentID = '04' or cbc:PaymentID = '15')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and not(cbc:PaymentID = '01' or cbc:PaymentID = '04' or cbc:PaymentID = '15')</Pattern>
<Description>[F-LIB147] PaymentMeansCode = 50, PaymentID must equal 01, 04 or 15</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and cbc:InstructionNote and not(cbc:PaymentID = '01')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and cbc:InstructionNote and not(cbc:PaymentID = '01')</Pattern>
<Description>[F-LIB148] PaymentMeansCode = 50, InstructionNote only allowed if PaymentID equals 01</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and string-length(cbc:InstructionID) &gt; 16">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and string-length(cbc:InstructionID) &gt; 16</Pattern>
<Description>[F-LIB149] PaymentMeansCode = 50, InstructionID must be no more than 16 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and (cbc:PaymentID = '04' or cbc:PaymentID = '15') and string(number(cbc:InstructionID)) = 'NaN'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and (cbc:PaymentID = '04' or cbc:PaymentID = '15') and string(number(cbc:InstructionID)) = 'NaN'</Pattern>
<Description>[F-LIB312] PaymentMeansCode = 50, InstructionID must be a numeric value when PaymentID equals 04 or 15.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50' or cbc:PaymentChannelCode ='DK:GIRO') and (string-length(cac:PayeeFinancialAccount/cbc:ID) &lt; 7 or string-length(cac:PayeeFinancialAccount/cbc:ID) &gt; 8 or string(number(cac:PayeeFinancialAccount/cbc:ID)) = 'NaN')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50' or cbc:PaymentChannelCode ='DK:GIRO') and (string-length(cac:PayeeFinancialAccount/cbc:ID) &lt; 7 or string-length(cac:PayeeFinancialAccount/cbc:ID) &gt; 8 or string(number(cac:PayeeFinancialAccount/cbc:ID)) = 'NaN')</Pattern>
<Description>[F-LIB321] PaymentMeansCode = 50 or PaymentChannelCode = DK:GIRO, PayeeFinancialAccount.ID must consist of 7 or 8 numerical characters.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and not(cbc:PaymentID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and not(cbc:PaymentID)</Pattern>
<Description>[F-LIB152] PaymentMeansCode = 93, PaymentID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and (cbc:PaymentID = '71' or cbc:PaymentID = '75') and not(cbc:InstructionID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and (cbc:PaymentID = '71' or cbc:PaymentID = '75') and not(cbc:InstructionID)</Pattern>
<Description>[F-LIB153] PaymentMeansCode = 93, InstructionID is mandatory when PaymentID equals 71 or 75</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93' and cbc:PaymentChannelCode) and cbc:PaymentChannelCode != 'DK:FIK'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93' and cbc:PaymentChannelCode) and cbc:PaymentChannelCode != 'DK:FIK'</Pattern>
<Description>[F-LIB277] PaymentMeansCode = 93, PaymentChannelCode must equal DK:FIK</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')</Pattern>
<Description>[F-LIB278] PaymentMeansCode = 93, Invalid listID. Must be 'urn:oioubl:codelist:paymentchannelcode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and cbc:InstructionNote and not(cbc:PaymentID = '73' or cbc:PaymentID = '75')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and cbc:InstructionNote and not(cbc:PaymentID = '73' or cbc:PaymentID = '75')</Pattern>
<Description>[F-LIB154] PaymentMeansCode = 93, InstructionNote only allowed if PaymentID equals 73 or 75</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and not(cbc:PaymentID = '71' or cbc:PaymentID = '73' or cbc:PaymentID = '75')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and not(cbc:PaymentID = '71' or cbc:PaymentID = '73' or cbc:PaymentID = '75')</Pattern>
<Description>[F-LIB155] PaymentMeansCode = 93, PaymentID must equal 71, 73 or 75</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '71' and string-length(cbc:InstructionID) != 15">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '71' and string-length(cbc:InstructionID) != 15</Pattern>
<Description>[F-LIB156] PaymentMeansCode = 93, InstructionID must be equal to 15 characters (when PaymentID equals 71)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '75' and string-length(cbc:InstructionID) != 16">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '75' and string-length(cbc:InstructionID) != 16</Pattern>
<Description>[F-LIB157] PaymentMeansCode = 93, InstructionID must be equal to 16 characters (when PaymentID equals 75)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and (cbc:PaymentID = '71' or cbc:PaymentID = '75') and string(number(cbc:InstructionID)) = 'NaN'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and (cbc:PaymentID = '71' or cbc:PaymentID = '75') and string(number(cbc:InstructionID)) = 'NaN'</Pattern>
<Description>[F-LIB336] PaymentMeansCode = 93, InstructionID must be a numeric value when PaymentID equals 71 or 75.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '73' and cbc:InstructionID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '73' and cbc:InstructionID</Pattern>
<Description>[F-LIB275] PaymentMeansCode = 93, InstructionID only allowed if PaymentID equals 71 or 75</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and string-length(cac:CreditAccount/cbc:AccountID) != 8">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and string-length(cac:CreditAccount/cbc:AccountID) != 8</Pattern>
<Description>[F-LIB305] PaymentMeansCode = 93, AccountID must be 8 characters</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cbc:PaymentChannelCode and not(cbc:PaymentChannelCode = 'DK:NEMKONTO')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cbc:PaymentChannelCode and not(cbc:PaymentChannelCode = 'DK:NEMKONTO')</Pattern>
<Description>[F-LIB158] PaymentMeansCode = 97, PaymentChannelCode element only allowed with value = "DK:NEMKONTO"</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cbc:InstructionID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cbc:InstructionID</Pattern>
<Description>[F-LIB159] PaymentMeansCode = 97, InstructionID element not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cbc:InstructionNote">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cbc:InstructionNote</Pattern>
<Description>[F-LIB160] PaymentMeansCode = 97, InstructionNote element not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cbc:PaymentID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cbc:PaymentID</Pattern>
<Description>[F-LIB161] PaymentMeansCode = 97, PaymentID element not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cac:PayerFinancialAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cac:PayerFinancialAccount</Pattern>
<Description>[F-LIB163] PaymentMeansCode = 97, PayerFinancialAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cac:PayeeFinancialAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cac:PayeeFinancialAccount</Pattern>
<Description>[F-LIB164] PaymentMeansCode = 97, PayeeFinancialAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cac:CreditAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cac:CreditAccount</Pattern>
<Description>[F-LIB165] PaymentMeansCode = 97, CreditAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M23" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M23" />
<xsl:template match="@*|node()" priority="-2" mode="M23">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M23" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M23" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN paymentterms-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms" priority="3999" mode="M24">

		<!--REPORT -->
<xsl:if test="count(../cac:PaymentTerms) &gt; 1 and not(cbc:ID != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PaymentTerms) &gt; 1 and not(cbc:ID != '')</Pattern>
<Description>[W-LIB245]: ID should be used when more than one instance of the PaymentTerms class is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID = 'Factoring' and not(cbc:Note != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID = 'Factoring' and not(cbc:Note != '')</Pattern>
<Description>[F-LIB246] when ID equals 'Factoring', Note element is mandatory (factoring note)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cbc:Note) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:Note) &gt; 1</Pattern>
<Description>[F-LIB247] No more than one Note element may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cbc:PaymentMeansID" priority="3998" mode="M24">
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cbc:Amount" priority="3997" mode="M24">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB019] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cac:SettlementPeriod" priority="3996" mode="M24">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cac:SettlementPeriod/cbc:Description" priority="3995" mode="M24">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cac:PenaltyPeriod" priority="3994" mode="M24">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cac:PenaltyPeriod/cbc:Description" priority="3993" mode="M24">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M24" />
<xsl:template match="@*|node()" priority="-2" mode="M24">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M24" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M24" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN prepaidpayment-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PrepaidPayment" priority="3999" mode="M25">
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M25" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M25" />
<xsl:template match="@*|node()" priority="-2" mode="M25">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M25" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M25" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PrepaidPayment/cbc:PaidAmount" priority="3974" mode="M0">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0" />
</xsl:template>

<!--PATTERN allowancecharge-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge" priority="3999" mode="M27">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:TaxTotal) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:TaxTotal) = 0</Pattern>
<Description>[F-LIB224] TaxTotal class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PaymentMeans) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PaymentMeans) = 0</Pattern>
<Description>[F-LIB225] PaymentMeans class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:TaxCategory) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:TaxCategory) = 1</Pattern>
<Description>[F-LIB226] One TaxCategory class must be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:MultiplierFactorNumeric and not(cbc:BaseAmount != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MultiplierFactorNumeric and not(cbc:BaseAmount != '')</Pattern>
<Description>[F-LIB248] When MultiplierFactorNumeric is used, BaseAmount is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="starts-with(cbc:MultiplierFactorNumeric,'-')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>starts-with(cbc:MultiplierFactorNumeric,'-')</Pattern>
<Description>[F-LIB227] MultiplierFactorNumeric must be a positive number</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:MultiplierFactorNumeric and ((cbc:Amount - (cbc:BaseAmount * cbc:MultiplierFactorNumeric) &lt; '-1.00') or (cbc:Amount - (cbc:BaseAmount * cbc:MultiplierFactorNumeric) &gt; '1.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MultiplierFactorNumeric and ((cbc:Amount - (cbc:BaseAmount * cbc:MultiplierFactorNumeric) &lt; '-1.00') or (cbc:Amount - (cbc:BaseAmount * cbc:MultiplierFactorNumeric) &gt; '1.00'))</Pattern>
<Description>[F-LIB228] Amount must equal BaseAmount * MultiplierFactorNumeric</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AccountingCost and cbc:AccountingCostCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AccountingCost and cbc:AccountingCostCode</Pattern>
<Description>[F-LIB021] Use either AccountingCost or AccountingCostCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AllowanceChargeReason and cbc:AllowanceChargeReasonCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AllowanceChargeReason and cbc:AllowanceChargeReasonCode</Pattern>
<Description>[F-REM094] Use either AllowanceChargeReason or AllowanceChargeReasonCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cbc:AllowanceChargeReasonCode" priority="3998" mode="M27">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="./@listID = 'urn:oioubl:codelist:reminderallowancechargereasoncode-1.0'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID = 'urn:oioubl:codelist:reminderallowancechargereasoncode-1.0'</Pattern>
<Description>[W-REM095] Invalid listID. Must be 'urn:oioubl:codelist:reminderallowancechargereasoncode-1.0'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="./@listAgencyID = '320'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listAgencyID = '320'</Pattern>
<Description>[W-REM096] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test=". = 'PenaltyFee' or . = 'PenaltyRate'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>. = 'PenaltyFee' or . = 'PenaltyRate'</Pattern>
<Description>[F-REM097] Invalid AllowanceChargeReasonCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cbc:SequenceNumeric" priority="3997" mode="M27">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-'))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-'))</Pattern>
<Description>[F-LIB020] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cbc:Amount" priority="3996" mode="M27">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB019] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cbc:BaseAmount" priority="3995" mode="M27">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB019] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cac:TaxCategory" priority="3994" mode="M27">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRange) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRange) = 0</Pattern>
<Description>[F-LIB072] TierRange element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRatePercent) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRatePercent) = 0</Pattern>
<Description>[F-LIB073] TierRatePercent element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB074] Invalid TaxCategory/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxCategory1_schemeID or cbc:ID/@schemeID = $TaxCategory2_schemeID or cbc:ID/@schemeID = $TaxCategory3_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxCategory1_schemeID or cbc:ID/@schemeID = $TaxCategory2_schemeID or cbc:ID/@schemeID = $TaxCategory3_schemeID</Pattern>
<Description>[F-LIB075] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxCategory1_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxCategory2_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxCategory3_schemeID" />
<xsl:text />'.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeAgencyID = $TaxCategory2_agencyID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeAgencyID = $TaxCategory2_agencyID</Pattern>
<Description>[W-LIB229] Invalid schemeAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="((cbc:ID/@schemeID = $TaxCategory1_schemeID) and not (contains($TaxCategory1, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory2_schemeID) and not (contains($TaxCategory2, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory3_schemeID) and not (contains($TaxCategory3, concat(',',cbc:ID,','))))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>((cbc:ID/@schemeID = $TaxCategory1_schemeID) and not (contains($TaxCategory1, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory2_schemeID) and not (contains($TaxCategory2, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory3_schemeID) and not (contains($TaxCategory3, concat(',',cbc:ID,','))))</Pattern>
<Description>[F-LIB309] Invalid ID: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))</Pattern>
<Description>[W-LIB230] Name should only be used within NES profiles</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and cbc:Percent">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and cbc:Percent</Pattern>
<Description>[F-LIB231] Use either PerUnitAmount or Percent</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')</Pattern>
<Description>[F-LIB232] When PerUnitAmount is used, BaseUnitMeasure is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme" priority="3993" mode="M27">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB065] Invalid TaxScheme/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:Name) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:Name) != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))</Pattern>
<Description>[F-LIB197] TaxTypeCode must be a value from the '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />' codelist when TaxScheme/ID is different from '63' or 'VAT' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme4_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme5_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))</Pattern>
<Description>[F-LIB071] Invalid listID. Must be either '<xsl:text />
<xsl:value-of select="$TaxType_listID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB337] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the country codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M27" />
<xsl:template match="@*|node()" priority="-2" mode="M27">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M27" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M27" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN taxexchangerate-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxExchangeRate" priority="3999" mode="M28">

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract and not(normalize-space(cac:ForeignExchangeContract/cbc:ID) != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract and not(normalize-space(cac:ForeignExchangeContract/cbc:ID) != '')</Pattern>
<Description>[F-LIB238] Invalid TaxExchangeRate/ForeignExchangeRate/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:SourceCurrencyCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:SourceCurrencyCode) != ''</Pattern>
<Description>[F-LIB083] Invalid SourceCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:TargetCurrencyCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:TargetCurrencyCode) != ''</Pattern>
<Description>[F-LIB084] Invalid TargetCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB085] Invalid SourceCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB086] Invalid SourceCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB087] Invalid TargetCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB088] Invalid TargetCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)</Pattern>
<Description>[F-LIB089] Invalid CalculationRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4</Pattern>
<Description>[F-LIB090] Invalid CalculationRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:MathematicOperatorCode != 'multiply' and cbc:MathematicOperatorCode != 'divide'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MathematicOperatorCode != 'multiply' and cbc:MathematicOperatorCode != 'divide'</Pattern>
<Description>[F-LIB310] Invalid MathematicOperatorCode. Must either be 'multiply' or 'divide'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType</Pattern>
<Description>[F-LIB239] Use either ContractTypeCode or ContractType</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1</Pattern>
<Description>[F-LIB240] No more than one ContractDocumentReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M28" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod" priority="3998" mode="M28">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M28" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod/cbc:Description" priority="3997" mode="M28">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M28" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxExchangeRate/cac:ForeignExchangeContract/cac:ContractDocumentReference" priority="3996" mode="M28">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M28" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M28" />
<xsl:template match="@*|node()" priority="-2" mode="M28">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M28" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M28" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN pricingexchangerate-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PricingExchangeRate" priority="3999" mode="M29">

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract and not(normalize-space(cac:ForeignExchangeContract/cbc:ID) != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract and not(normalize-space(cac:ForeignExchangeContract/cbc:ID) != '')</Pattern>
<Description>[F-LIB238] Invalid TaxExchangeRate/ForeignExchangeRate/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:SourceCurrencyCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:SourceCurrencyCode) != ''</Pattern>
<Description>[F-LIB083] Invalid SourceCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:TargetCurrencyCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:TargetCurrencyCode) != ''</Pattern>
<Description>[F-LIB084] Invalid TargetCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB085] Invalid SourceCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB086] Invalid SourceCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB087] Invalid TargetCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB088] Invalid TargetCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)</Pattern>
<Description>[F-LIB089] Invalid CalculationRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4</Pattern>
<Description>[F-LIB090] Invalid CalculationRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:MathematicOperatorCode != 'multiply' and cbc:MathematicOperatorCode != 'divide'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MathematicOperatorCode != 'multiply' and cbc:MathematicOperatorCode != 'divide'</Pattern>
<Description>[F-LIB310] Invalid MathematicOperatorCode. Must either be 'multiply' or 'divide'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType</Pattern>
<Description>[F-LIB239] Use either ContractTypeCode or ContractType</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1</Pattern>
<Description>[F-LIB240] No more than one ContractDocumentReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M29" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PricingExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod" priority="3998" mode="M29">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M29" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PricingExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod/cbc:Description" priority="3997" mode="M29">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M29" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PricingExchangeRate/cac:ForeignExchangeContract/cac:ContractDocumentReference" priority="3996" mode="M29">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M29" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M29" />
<xsl:template match="@*|node()" priority="-2" mode="M29">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M29" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M29" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN paymentexchangerate-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentExchangeRate" priority="3999" mode="M30">

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract and not(normalize-space(cac:ForeignExchangeContract/cbc:ID) != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract and not(normalize-space(cac:ForeignExchangeContract/cbc:ID) != '')</Pattern>
<Description>[F-LIB238] Invalid TaxExchangeRate/ForeignExchangeRate/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:SourceCurrencyCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:SourceCurrencyCode) != ''</Pattern>
<Description>[F-LIB083] Invalid SourceCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:TargetCurrencyCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:TargetCurrencyCode) != ''</Pattern>
<Description>[F-LIB084] Invalid TargetCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB085] Invalid SourceCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB086] Invalid SourceCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB087] Invalid TargetCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB088] Invalid TargetCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)</Pattern>
<Description>[F-LIB089] Invalid CalculationRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4</Pattern>
<Description>[F-LIB090] Invalid CalculationRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:MathematicOperatorCode != 'multiply' and cbc:MathematicOperatorCode != 'divide'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MathematicOperatorCode != 'multiply' and cbc:MathematicOperatorCode != 'divide'</Pattern>
<Description>[F-LIB310] Invalid MathematicOperatorCode. Must either be 'multiply' or 'divide'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType</Pattern>
<Description>[F-LIB239] Use either ContractTypeCode or ContractType</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1</Pattern>
<Description>[F-LIB240] No more than one ContractDocumentReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod" priority="3998" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod/cbc:Description" priority="3997" mode="M30">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentExchangeRate/cac:ForeignExchangeContract/cac:ContractDocumentReference" priority="3996" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M30" />
<xsl:template match="@*|node()" priority="-2" mode="M30">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M30" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M30" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN paymentalternativeexchangerate-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentAlternativeExchangeRate" priority="3999" mode="M31">

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract and not(normalize-space(cac:ForeignExchangeContract/cbc:ID) != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract and not(normalize-space(cac:ForeignExchangeContract/cbc:ID) != '')</Pattern>
<Description>[F-LIB238] Invalid TaxExchangeRate/ForeignExchangeRate/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:SourceCurrencyCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:SourceCurrencyCode) != ''</Pattern>
<Description>[F-LIB083] Invalid SourceCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:TargetCurrencyCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:TargetCurrencyCode) != ''</Pattern>
<Description>[F-LIB084] Invalid TargetCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB085] Invalid SourceCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB086] Invalid SourceCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB087] Invalid TargetCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB088] Invalid TargetCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)</Pattern>
<Description>[F-LIB089] Invalid CalculationRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4</Pattern>
<Description>[F-LIB090] Invalid CalculationRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:MathematicOperatorCode != 'multiply' and cbc:MathematicOperatorCode != 'divide'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MathematicOperatorCode != 'multiply' and cbc:MathematicOperatorCode != 'divide'</Pattern>
<Description>[F-LIB310] Invalid MathematicOperatorCode. Must either be 'multiply' or 'divide'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType</Pattern>
<Description>[F-LIB239] Use either ContractTypeCode or ContractType</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1</Pattern>
<Description>[F-LIB240] No more than one ContractDocumentReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentAlternativeExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod" priority="3998" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentAlternativeExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod/cbc:Description" priority="3997" mode="M31">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentAlternativeExchangeRate/cac:ForeignExchangeContract/cac:ContractDocumentReference" priority="3996" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M31" />
<xsl:template match="@*|node()" priority="-2" mode="M31">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M31" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M31" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN taxtotal-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxTotal" priority="3999" mode="M32">

		<!--REPORT -->
<xsl:if test="cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID = ./following-sibling::*/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID = ./following-sibling::*/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID</Pattern>
<Description>[F-LIB314] Using the same TaxScheme ID in two different TaxTotal classes are not allowed.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(../cac:TaxTotal[cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID = '63' or cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID = 'VAT']) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:TaxTotal[cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID = '63' or cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID = 'VAT']) = 1</Pattern>
<Description>[F-LIB306] Exactly one TaxTotal class must contain VAT (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(cbc:TaxAmount, '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(cbc:TaxAmount, '.')) != 2</Pattern>
<Description>[F-LIB250] Invalid TaxAmount. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:RoundingAmount and (cbc:RoundingAmount = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:RoundingAmount and (cbc:RoundingAmount = 0)</Pattern>
<Description>[F-LIB251] Invalid RoundingAmount. Must not be zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:RoundingAmount and string-length(substring-after(cbc:RoundingAmount, '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:RoundingAmount and string-length(substring-after(cbc:RoundingAmount, '.')) != 2</Pattern>
<Description>[F-LIB252] Invalid RoundingAmount. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TaxEvidenceIndicator = 'false' and /doc:Invoice/cbc:InvoiceTypeCode != '325'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TaxEvidenceIndicator = 'false' and /doc:Invoice/cbc:InvoiceTypeCode != '325'</Pattern>
<Description>[F-LIB253] Can only be false if proforma invoice (InvoiceTypeCode = '325')</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M32" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxTotal/cac:TaxSubtotal" priority="3998" mode="M32">
<xsl:variable name="ID63" select="cac:TaxCategory/cac:TaxScheme/cbc:ID = '63'" />

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:Percent) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:Percent) = 0</Pattern>
<Description>[F-LIB254] Percent element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BaseUnitMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BaseUnitMeasure) = 0</Pattern>
<Description>[F-LIB255] BaseUnitMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:PerUnitAmount) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:PerUnitAmount) = 0</Pattern>
<Description>[F-LIB256] PerUnitAmount element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRange) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRange) = 0</Pattern>
<Description>[F-LIB257] TierRange element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRatePercent) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRatePercent) = 0</Pattern>
<Description>[F-LIB258] TierRatePercent element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:TaxableAmount) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:TaxableAmount) != ''</Pattern>
<Description>[F-LIB259] Invalid TaxableAmount. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="$ID63 and cac:TaxCategory/cac:TaxScheme/cbc:ID = ./following-sibling::*/cac:TaxCategory/cac:TaxScheme/cbc:ID and cac:TaxCategory/cbc:ID = ./following-sibling::*/cac:TaxCategory/cbc:ID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>$ID63 and cac:TaxCategory/cac:TaxScheme/cbc:ID = ./following-sibling::*/cac:TaxCategory/cac:TaxScheme/cbc:ID and cac:TaxCategory/cbc:ID = ./following-sibling::*/cac:TaxCategory/cbc:ID</Pattern>
<Description>[F-LIB315] Specifying the same TaxSubtotal.TaxCategory.ID in one TaxTotal class is not allowed</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:TaxCategory/cac:TaxScheme/cbc:ID != ./following-sibling::*/cac:TaxCategory/cac:TaxScheme/cbc:ID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:TaxCategory/cac:TaxScheme/cbc:ID != ./following-sibling::*/cac:TaxCategory/cac:TaxScheme/cbc:ID</Pattern>
<Description>[F-LIB316] Specifying different TaxScheme.ID in same TaxTotal class is not allowed.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(cbc:TaxableAmount, '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(cbc:TaxableAmount, '.')) != 2</Pattern>
<Description>[F-LIB261] Invalid TaxableAmount. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(cbc:TaxAmount, '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(cbc:TaxAmount, '.')) != 2</Pattern>
<Description>[F-LIB263] Invalid TaxAmount. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationSequenceNumeric and (starts-with(cbc:CalculationSequenceNumeric,'-') or cbc:CalculationSequenceNumeric = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationSequenceNumeric and (starts-with(cbc:CalculationSequenceNumeric,'-') or cbc:CalculationSequenceNumeric = 0)</Pattern>
<Description>[F-LIB264] Invalid CalculationSequenceNumeric. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="/doc:Invoice/cac:TaxExchangeRate and count(cbc:TransactionCurrencyTaxAmount) = 0">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>/doc:Invoice/cac:TaxExchangeRate and count(cbc:TransactionCurrencyTaxAmount) = 0</Pattern>
<Description>[F-LIB265] if Tax Currency is different from Document Currency, TransactionCurrencyTaxAmount is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TransactionCurrencyTaxAmount and (starts-with(cbc:TransactionCurrencyTaxAmount,'-'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TransactionCurrencyTaxAmount and (starts-with(cbc:TransactionCurrencyTaxAmount,'-'))</Pattern>
<Description>[F-LIB266] Invalid TransactionCurrencyTaxAmount. Must not be negative</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TransactionCurrencyTaxAmount and string-length(substring-after(cbc:TransactionCurrencyTaxAmount, '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TransactionCurrencyTaxAmount and string-length(substring-after(cbc:TransactionCurrencyTaxAmount, '.')) != 2</Pattern>
<Description>[F-LIB267] Invalid TransactionCurrencyTaxAmount. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:TaxCategory/cac:TaxScheme/cbc:ID = 'VAT') and not(cac:TaxCategory/cbc:Percent)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:TaxCategory/cac:TaxScheme/cbc:ID = 'VAT') and not(cac:TaxCategory/cbc:Percent)</Pattern>
<Description>[F-LIB333] When TaxCategory/TaxScheme/Id is VAT, the TaxCategory/Percent must be present.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:TaxCategory/cac:TaxScheme/cbc:ID = 'VAT') and ((cac:TaxCategory/cbc:Percent = '') or (string-length(substring-after(cac:TaxCategory/cbc:Percent, '.')) &gt; 2))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:TaxCategory/cac:TaxScheme/cbc:ID = 'VAT') and ((cac:TaxCategory/cbc:Percent = '') or (string-length(substring-after(cac:TaxCategory/cbc:Percent, '.')) &gt; 2))</Pattern>
<Description>[F-LIB334] The TaxCategory/Percent must contain a decimal value with maximum 2 decimals.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M32" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory" priority="3997" mode="M32">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRange) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRange) = 0</Pattern>
<Description>[F-LIB072] TierRange element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRatePercent) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRatePercent) = 0</Pattern>
<Description>[F-LIB073] TierRatePercent element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB074] Invalid TaxCategory/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxCategory1_schemeID or cbc:ID/@schemeID = $TaxCategory2_schemeID or cbc:ID/@schemeID = $TaxCategory3_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxCategory1_schemeID or cbc:ID/@schemeID = $TaxCategory2_schemeID or cbc:ID/@schemeID = $TaxCategory3_schemeID</Pattern>
<Description>[F-LIB075] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxCategory1_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxCategory2_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxCategory3_schemeID" />
<xsl:text />'.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeAgencyID = $TaxCategory2_agencyID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeAgencyID = $TaxCategory2_agencyID</Pattern>
<Description>[W-LIB229] Invalid schemeAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="((cbc:ID/@schemeID = $TaxCategory1_schemeID) and not (contains($TaxCategory1, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory2_schemeID) and not (contains($TaxCategory2, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory3_schemeID) and not (contains($TaxCategory3, concat(',',cbc:ID,','))))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>((cbc:ID/@schemeID = $TaxCategory1_schemeID) and not (contains($TaxCategory1, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory2_schemeID) and not (contains($TaxCategory2, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory3_schemeID) and not (contains($TaxCategory3, concat(',',cbc:ID,','))))</Pattern>
<Description>[F-LIB309] Invalid ID: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))</Pattern>
<Description>[W-LIB230] Name should only be used within NES profiles</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and cbc:Percent">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and cbc:Percent</Pattern>
<Description>[F-LIB231] Use either PerUnitAmount or Percent</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')</Pattern>
<Description>[F-LIB232] When PerUnitAmount is used, BaseUnitMeasure is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M32" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme" priority="3996" mode="M32">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB065] Invalid TaxScheme/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:Name) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:Name) != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))</Pattern>
<Description>[F-LIB197] TaxTypeCode must be a value from the '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />' codelist when TaxScheme/ID is different from '63' or 'VAT' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme4_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme5_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))</Pattern>
<Description>[F-LIB071] Invalid listID. Must be either '<xsl:text />
<xsl:value-of select="$TaxType_listID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB337] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the country codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M32" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M32" />
<xsl:template match="@*|node()" priority="-2" mode="M32">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M32" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M32" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN legalmonetarytotal-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal" priority="3999" mode="M33">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:LineExtensionAmount) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:LineExtensionAmount) != ''</Pattern>
<Description>[F-REM054] Invalid LineExtensionAmount. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="count(../cac:AllowanceCharge[cbc:ChargeIndicator='false']) and not(cbc:AllowanceTotalAmount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:AllowanceCharge[cbc:ChargeIndicator='false']) and not(cbc:AllowanceTotalAmount)</Pattern>
<Description>[F-REM074] AllowanceTotalAmount is mandatory when AllowanceCharge classes (with ChargeIndicator='false') are present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(../cac:AllowanceCharge[cbc:ChargeIndicator='true']) and not(cbc:ChargeTotalAmount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:AllowanceCharge[cbc:ChargeIndicator='true']) and not(cbc:ChargeTotalAmount)</Pattern>
<Description>[F-REM075] ChargeTotalAmount is mandatory when AllowanceCharge classes (with ChargeIndicator='true') are present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(../cac:PrepaidPayment/cbc:PaidAmount) and not(cbc:PrepaidAmount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PrepaidPayment/cbc:PaidAmount) and not(cbc:PrepaidAmount)</Pattern>
<Description>[F-REM076] PrepaidAmount is mandatory when PrepaidPayment/PaidAmount elements are present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(../cac:TaxTotal/cbc:RoundingAmount) and not(cbc:PayableRoundingAmount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:TaxTotal/cbc:RoundingAmount) and not(cbc:PayableRoundingAmount)</Pattern>
<Description>[F-REM077] PayableRoundingAmount is mandatory when TaxTotal/RoundingAmount elements are present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TaxExclusiveAmount and not(format-number(cbc:TaxExclusiveAmount,'##.00') = format-number(sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TaxExclusiveAmount and not(format-number(cbc:TaxExclusiveAmount,'##.00') = format-number(sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount),'##.00'))</Pattern>
<Description>[F-REM079] The sum of TaxTotal/TaxSubtotal/TaxAmount elements must equal TaxExclusiveAmount</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TaxInclusiveAmount and not(format-number(cbc:TaxInclusiveAmount,'##.00') = format-number(sum(cbc:LineExtensionAmount) + sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount) + sum(cbc:ChargeTotalAmount) - sum(cbc:AllowanceTotalAmount) + sum(cbc:PayableRoundingAmount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TaxInclusiveAmount and not(format-number(cbc:TaxInclusiveAmount,'##.00') = format-number(sum(cbc:LineExtensionAmount) + sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount) + sum(cbc:ChargeTotalAmount) - sum(cbc:AllowanceTotalAmount) + sum(cbc:PayableRoundingAmount),'##.00'))</Pattern>
<Description>[F-REM080] TaxInclusiveAmount is calculated incorrectly</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AllowanceTotalAmount and not(format-number(cbc:AllowanceTotalAmount,'##.00') = format-number(sum(../cac:AllowanceCharge[cbc:ChargeIndicator='false']/cbc:Amount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AllowanceTotalAmount and not(format-number(cbc:AllowanceTotalAmount,'##.00') = format-number(sum(../cac:AllowanceCharge[cbc:ChargeIndicator='false']/cbc:Amount),'##.00'))</Pattern>
<Description>[F-REM081] The sum of AllowanceCharge/Amount elements (with ChargeIndicator='false') must equal AllowanceTotalAmount</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ChargeTotalAmount and not(format-number(cbc:ChargeTotalAmount,'##.00') = format-number(sum(../cac:AllowanceCharge[cbc:ChargeIndicator='true']/cbc:Amount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ChargeTotalAmount and not(format-number(cbc:ChargeTotalAmount,'##.00') = format-number(sum(../cac:AllowanceCharge[cbc:ChargeIndicator='true']/cbc:Amount),'##.00'))</Pattern>
<Description>[F-REM082] The sum of AllowanceCharge/Amount elements (with ChargeIndicator='true') must equal cbc:ChargeTotalAmount</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PrepaidAmount and not(format-number(cbc:PrepaidAmount,'##.00') = format-number(sum(../cac:PrepaidPayment/cbc:PaidAmount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PrepaidAmount and not(format-number(cbc:PrepaidAmount,'##.00') = format-number(sum(../cac:PrepaidPayment/cbc:PaidAmount),'##.00'))</Pattern>
<Description>[F-REM083] The sum of PrepaidPayment/PaidAmount elements must equal PrepaidAmount</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PayableRoundingAmount and not(format-number(cbc:PayableRoundingAmount,'##.00') = format-number(sum(../cac:TaxTotal/cbc:RoundingAmount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PayableRoundingAmount and not(format-number(cbc:PayableRoundingAmount,'##.00') = format-number(sum(../cac:TaxTotal/cbc:RoundingAmount),'##.00'))</Pattern>
<Description>[F-REM084] The sum of TaxTotal/RoundingAmount elements must equal PayableRoundingAmount</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="format-number(sum(cbc:PayableAmount) *-1,'##.00') = format-number((sum(cbc:LineExtensionAmount) + sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount) + sum(cbc:ChargeTotalAmount) - sum(cbc:AllowanceTotalAmount) - sum(cbc:PrepaidAmount) + sum(cbc:PayableRoundingAmount)) *-1,'##.00')" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>format-number(sum(cbc:PayableAmount) *-1,'##.00') = format-number((sum(cbc:LineExtensionAmount) + sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount) + sum(cbc:ChargeTotalAmount) - sum(cbc:AllowanceTotalAmount) - sum(cbc:PrepaidAmount) + sum(cbc:PayableRoundingAmount)) *-1,'##.00')</Pattern>
<Description>[F-REM085] PayableAmount is calculated incorrectly</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(count(../cac:PaymentTerms) &gt; 0) and not (  (format-number(cbc:PayableAmount,'##.00') = format-number(sum(../cac:PaymentTerms/cbc:Amount),'##.00'))   or   (format-number(cbc:PayableAmount,'##.00') = format-number(../cac:PaymentTerms[1]/cbc:Amount,'##.00')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(count(../cac:PaymentTerms) &gt; 0) and not ( (format-number(cbc:PayableAmount,'##.00') = format-number(sum(../cac:PaymentTerms/cbc:Amount),'##.00')) or (format-number(cbc:PayableAmount,'##.00') = format-number(../cac:PaymentTerms[1]/cbc:Amount,'##.00')))</Pattern>
<Description>[F-REM086] The sum of PaymentTerms/Amount elements or the value of the first PaymentTerms/Amount must equal PayableAmount</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M33" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:LineExtensionAmount" priority="3998" mode="M33">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test=". != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>. != 0</Pattern>
<Description>[F-LIB303] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M33" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount" priority="3997" mode="M33">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-'))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-'))</Pattern>
<Description>[F-LIB016] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M33" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount" priority="3996" mode="M33">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M33" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount" priority="3995" mode="M33">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M33" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount" priority="3994" mode="M33">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M33" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:PrepaidAmount" priority="3993" mode="M33">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M33" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:PayableRoundingAmount" priority="3992" mode="M33">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test=". != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>. != 0</Pattern>
<Description>[F-LIB303] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M33" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:PayableAmount" priority="3991" mode="M33">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M33" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M33" />
<xsl:template match="@*|node()" priority="-2" mode="M33">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M33" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M33" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN reminderline-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine" priority="3999" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-REM058] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AccountingCost and cbc:AccountingCostCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AccountingCost and cbc:AccountingCostCode</Pattern>
<Description>[F-LIB021] Use either AccountingCost or AccountingCostCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ReminderPeriod) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ReminderPeriod) &gt; 1</Pattern>
<Description>[F-REM087] No more than one ReminderPeriod class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:BillingReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:BillingReference) &gt; 1</Pattern>
<Description>[F-REM088] No more than one BillingReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cbc:UUID" priority="3998" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="string-length(string(.)) = 36" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(string(.)) = 36</Pattern>
<Description>[F-LIB006] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cbc:DebitLineAmount" priority="3997" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cbc:CreditLineAmount" priority="3996" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ReminderPeriod" priority="3995" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ReminderPeriod/cbc:Description" priority="3994" mode="M34">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference" priority="3993" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:DebitNoteDocumentReference) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:DebitNoteDocumentReference) = 0</Pattern>
<Description>[F-REM089] DebitNoteDocumentReference class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AdditionalDocumentReference) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AdditionalDocumentReference) = 0</Pattern>
<Description>[F-REM090] AdditionalDocumentReference class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="count(cac:BillingReferenceLine) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:BillingReferenceLine) &gt; 1</Pattern>
<Description>[F-REM091] No more than one BillingReferenceLine class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:InvoiceDocumentReference" priority="3992" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:SelfBilledInvoiceDocumentReference" priority="3991" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:CreditNoteDocumentReference" priority="3990" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:SelfBilledCreditNoteDocumentReference" priority="3989" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:ReminderDocumentReference" priority="3988" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine" priority="3987" mode="M34">

		<!--REPORT -->
<xsl:if test="count(cac:AllowanceCharge) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AllowanceCharge) &gt; 1</Pattern>
<Description>[F-REM092] No more than one AllowanceCharge class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge" priority="3986" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:TaxTotal) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:TaxTotal) = 0</Pattern>
<Description>[F-LIB224] TaxTotal class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PaymentMeans) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PaymentMeans) = 0</Pattern>
<Description>[F-LIB225] PaymentMeans class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:TaxCategory) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:TaxCategory) = 1</Pattern>
<Description>[F-LIB226] One TaxCategory class must be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:MultiplierFactorNumeric and not(cbc:BaseAmount != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MultiplierFactorNumeric and not(cbc:BaseAmount != '')</Pattern>
<Description>[F-LIB248] When MultiplierFactorNumeric is used, BaseAmount is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="starts-with(cbc:MultiplierFactorNumeric,'-')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>starts-with(cbc:MultiplierFactorNumeric,'-')</Pattern>
<Description>[F-LIB227] MultiplierFactorNumeric must be a positive number</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:MultiplierFactorNumeric and ((cbc:Amount - (cbc:BaseAmount * cbc:MultiplierFactorNumeric) &lt; '-1.00') or (cbc:Amount - (cbc:BaseAmount * cbc:MultiplierFactorNumeric) &gt; '1.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MultiplierFactorNumeric and ((cbc:Amount - (cbc:BaseAmount * cbc:MultiplierFactorNumeric) &lt; '-1.00') or (cbc:Amount - (cbc:BaseAmount * cbc:MultiplierFactorNumeric) &gt; '1.00'))</Pattern>
<Description>[F-LIB228] Amount must equal BaseAmount * MultiplierFactorNumeric</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AccountingCost and cbc:AccountingCostCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AccountingCost and cbc:AccountingCostCode</Pattern>
<Description>[F-LIB021] Use either AccountingCost or AccountingCostCode</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge/cbc:SequenceNumeric" priority="3985" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-'))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-'))</Pattern>
<Description>[F-LIB020] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge/cbc:Amount" priority="3984" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB019] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge/cbc:BaseAmount" priority="3983" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB019] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge/cac:TaxCategory" priority="3982" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRange) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRange) = 0</Pattern>
<Description>[F-LIB072] TierRange element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRatePercent) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRatePercent) = 0</Pattern>
<Description>[F-LIB073] TierRatePercent element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB074] Invalid TaxCategory/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxCategory1_schemeID or cbc:ID/@schemeID = $TaxCategory2_schemeID or cbc:ID/@schemeID = $TaxCategory3_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxCategory1_schemeID or cbc:ID/@schemeID = $TaxCategory2_schemeID or cbc:ID/@schemeID = $TaxCategory3_schemeID</Pattern>
<Description>[F-LIB075] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxCategory1_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxCategory2_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxCategory3_schemeID" />
<xsl:text />'.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeAgencyID = $TaxCategory2_agencyID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeAgencyID = $TaxCategory2_agencyID</Pattern>
<Description>[W-LIB229] Invalid schemeAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="((cbc:ID/@schemeID = $TaxCategory1_schemeID) and not (contains($TaxCategory1, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory2_schemeID) and not (contains($TaxCategory2, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory3_schemeID) and not (contains($TaxCategory3, concat(',',cbc:ID,','))))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>((cbc:ID/@schemeID = $TaxCategory1_schemeID) and not (contains($TaxCategory1, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory2_schemeID) and not (contains($TaxCategory2, concat(',',cbc:ID,',')))) or ((cbc:ID/@schemeID = $TaxCategory3_schemeID) and not (contains($TaxCategory3, concat(',',cbc:ID,','))))</Pattern>
<Description>[F-LIB309] Invalid ID: '<xsl:text />
<xsl:value-of select="cbc:ID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))</Pattern>
<Description>[W-LIB230] Name should only be used within NES profiles</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and cbc:Percent">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and cbc:Percent</Pattern>
<Description>[F-LIB231] Use either PerUnitAmount or Percent</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')</Pattern>
<Description>[F-LIB232] When PerUnitAmount is used, BaseUnitMeasure is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme" priority="3981" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:ID) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:ID) != ''</Pattern>
<Description>[F-LIB065] Invalid TaxScheme/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:Name) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:Name) != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not((cbc:ID = '63' or cbc:ID = 'VAT')) and not(contains($TaxType2, concat(',',cbc:TaxTypeCode,',')))</Pattern>
<Description>[F-LIB197] TaxTypeCode must be a value from the '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />' codelist when TaxScheme/ID is different from '63' or 'VAT' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID or cbc:ID/@schemeID = $TaxScheme4_schemeID or cbc:ID/@schemeID = $TaxScheme5_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be either '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />', '<xsl:text />
<xsl:value-of select="$TaxScheme4_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme5_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not((cbc:TaxTypeCode/@listID = $TaxType_listID) or (cbc:TaxTypeCode/@listID = $TaxType_listID2))</Pattern>
<Description>[F-LIB071] Invalid listID. Must be either '<xsl:text />
<xsl:value-of select="$TaxType_listID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxType_listID2" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode) and not(contains($CountryCode, concat(',',cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode,',')))</Pattern>
<Description>[F-LIB337] Invalid Country/IdentificationCode: '<xsl:text />
<xsl:value-of select="cac:JurisdictionRegionAddress/cac:Country/cbc:IdentificationCode" />
<xsl:text />'. Must be a value from the country codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ExchangeRate" priority="3980" mode="M34">

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract and not(normalize-space(cac:ForeignExchangeContract/cbc:ID) != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract and not(normalize-space(cac:ForeignExchangeContract/cbc:ID) != '')</Pattern>
<Description>[F-LIB238] Invalid TaxExchangeRate/ForeignExchangeRate/ID. Must contain a value.</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:SourceCurrencyCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:SourceCurrencyCode) != ''</Pattern>
<Description>[F-LIB083] Invalid SourceCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="normalize-space(cbc:TargetCurrencyCode) != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>normalize-space(cbc:TargetCurrencyCode) != ''</Pattern>
<Description>[F-LIB084] Invalid TargetCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB085] Invalid SourceCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB086] Invalid SourceCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB087] Invalid TargetCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB088] Invalid TargetCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)</Pattern>
<Description>[F-LIB089] Invalid CalculationRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4</Pattern>
<Description>[F-LIB090] Invalid CalculationRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:MathematicOperatorCode != 'multiply' and cbc:MathematicOperatorCode != 'divide'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MathematicOperatorCode != 'multiply' and cbc:MathematicOperatorCode != 'divide'</Pattern>
<Description>[F-LIB310] Invalid MathematicOperatorCode. Must either be 'multiply' or 'divide'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType</Pattern>
<Description>[F-LIB239] Use either ContractTypeCode or ContractType</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1</Pattern>
<Description>[F-LIB240] No more than one ContractDocumentReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod" priority="3979" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod/cbc:Description" priority="3978" mode="M34">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ExchangeRate/cac:ForeignExchangeContract/cac:ContractDocumentReference" priority="3977" mode="M34">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name()" />[<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M34" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M34" />
<xsl:template match="@*|node()" priority="-2" mode="M34">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M34" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M34" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>
