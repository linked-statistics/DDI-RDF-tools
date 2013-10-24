<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template name="createUriByElement">
        <xsl:param name="element" as="node()"/>
    </xsl:template>    
    
    <xsl:template name="createUriByReference">
        <xsl:param name="element" as="node()"/>
    </xsl:template>
</xsl:stylesheet>