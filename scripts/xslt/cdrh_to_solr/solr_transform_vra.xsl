<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:vra="http://www.vraweb.org/vracore4.htm"
	xpath-default-namespace="http://www.vraweb.org/vracore4.htm"
	exclude-result-prefixes="#all"
	version="2.0">
	
	<!-- ==================================================================== -->
	<!--                               IMPORTS                                -->
	<!-- ==================================================================== -->
	
	<xsl:import href="lib/common.xsl"/>
	<xsl:import href="lib/cdrh_vra.xsl"/>
	<!-- If this file is living in a collections directory, the paths will be
       ../../../scripts/xslt/cdrh_to_solr/lib/common.xsl -->

	<xsl:output indent="yes" omit-xml-declaration="yes"/>
	
	<!-- ==================================================================== -->
	<!--                           PARAMETERS                                 -->
	<!-- ==================================================================== -->
	
	<!-- Defined in collection config files -->
	<xsl:param name="fig_location"/>  <!-- url for figures -->
	<xsl:param name="file_location"/> <!-- url for tei files -->
	<xsl:param name="figures"/>       <!-- boolean for if figs should be displayed (not for this script, for html script) -->
	<xsl:param name="fw"/>            <!-- boolean for html not for this script -->
	<xsl:param name="pb"/>            <!-- boolean for page breaks in html, not this script -->
	<xsl:param name="collection"/>       <!-- longer name of collection -->
	<xsl:param name="slug"/>          <!-- slug of collection -->
	<xsl:param name="site_url"/>
	


	<!-- ==================================================================== -->
	<!--                            OVERRIDES                                 -->
	<!-- ==================================================================== -->
	
	<!-- Individual collections can override matched templates from the
       imported stylesheets above by including new templates here -->
	<!-- Named templates can be overridden if included in matched templates
       here.  You cannot call a named template from directly within the stylesheet tag
       but you can redefine one here to be called by an imported template -->
	
	<!-- The below will override the entire text matching template -->
	<!-- <xsl:template match="text">
        <xsl:call-template name="fake_template"/>
      </xsl:template> -->
	
	<!-- The below will override templates with the same name -->
	<!-- <xsl:template name="fake_template">
        This fake template would override fake_template if it was defined
        in one of the imported files
      </xsl:template> -->
	
	
	<!-- Uncomment this to prevent personography behavior -->
	<!-- <xsl:template name="personography"/> -->
	
	<!-- Uncomment this and fill it in with your own fields
       this will not affect the personography solr entries -->
	<!-- <xsl:template name="extras">
    <field name="new_field_s">Your thing here</field>
  </xsl:template> -->


</xsl:stylesheet>
