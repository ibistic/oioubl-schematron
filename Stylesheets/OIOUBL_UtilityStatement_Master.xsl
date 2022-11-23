<?xml version="1.0" encoding="UTF-8"?>

<!--
******************************************************************************************************************

		OIOUBL Schematron

		publisher:          NemHandel / Erhvervsstyrelsen
        Repository path:    $HeadURL$
        File version:       $Revision$
        Last changed by:    $Author$
        Last changed date:  $Date$

		Description:        This document is produced as part of the OIOUBL schematron package
		
		                    This XSL is part of a dynamic function where the correct 
		                    UTS XSL is choosen based on current date
		                    
		                    To use the dynamic function you will need to 
		                    - Use the "OIOUBL_UtilityStatement_Master" as the main XSL for UTS
		                    - Ensure that the XSL's below are in the same folder as the "OIOUBL_UtilityStatement_Master.xsl" 
		                      - Old UTS XSL: OIOUBL_UtilityStatement_Schematron2.1b.xsl
		                      - New UTS XSL: OIOUBL_UtilityStatement_Schematron2.1.xsl (Mandatory from 30-11-2022)
		                      
		                    If the dynamic function is not to be used then just ensure the the XLS below are set into production the 30-11-2022
		                    - UTS XSL: OIOUBL_UtilityStatement_Schematron.xsl
		                                    
		                    
		Rights:             It can be used following the Common Creative Licence

		all terms derived from http://dublincore.org/documents/dcmi-terms/

		For more information, see www.oioubl.info or email support@nemhandel.dk

******************************************************************************************************************
-->
<xsl:stylesheet
   xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
   xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
   xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:UtilityStatement-2"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   version="2.0">
   
   <xsl:import href="OIOUBL_UtilityStatement_Schematron2.1b.xsl"/>
   <xsl:import href="OIOUBL_UtilityStatement_Schematron2.1.xsl"/>
   
   <!-- Date format needs to be YYYY-MM-DD -->
   <xsl:variable name="CurrentDate" select="current-date()"/>
   <!-- ReleareDate are 2022-11-30 where the new UTS XSL must go in production  -->
   <xsl:variable name="ReleaseDate" select="xs:date('2022-11-30')"/>
      
      
      <xsl:template match="/">
         <xsl:choose>            
            <xsl:when test="xs:date($CurrentDate) &lt; xs:date($ReleaseDate)">
               <xsl:apply-templates select="/" mode="Old"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates select="/" mode="New"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:template>
      
  
      

</xsl:stylesheet>