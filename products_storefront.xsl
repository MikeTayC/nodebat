<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslt="http://xml.apache.org/xslt"
                exclude-result-prefixes="xslt">

    <xsl:output method="xml" xslt:indent-amount="4" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
        <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

        <catalog xmlns="http://www.demandware.com/xml/impex/catalog/2006-10-31" catalog-id="livingproof-storefront-en">
            <header>
                <image-settings>
                    <internal-location base-path="/images"/>
                    <view-types>
                        <view-type>large</view-type>
                        <view-type>medium</view-type>
                        <view-type>small</view-type>
                        <view-type>swatch</view-type>
                        <view-type>hi-res</view-type>
                    </view-types>
                    <alt-pattern>${productname}</alt-pattern>
                    <title-pattern>${productname}</title-pattern>
                </image-settings>
            </header>

            <xsl:for-each select="csv_root_node/row">
                <xsl:variable name="categoryId" select="category_id"/>
                <category category-id="{$categoryId}">
                    <xsl:if test="display_name != ''"><display-name xml:lang="x-default"><xsl:value-of select="display_name"/></display-name></xsl:if>
                    <xsl:if test="online != ''"><online-flag><xsl:value-of select="online"/></online-flag></xsl:if>
                    <xsl:if test="parent_category != ''"><parent><xsl:value-of select="parent_category"/></parent></xsl:if>
                    <xsl:if test="position != ''"><position><xsl:value-of select="position"/></position></xsl:if>
                    <xsl:if test="image != ''"><image><xsl:value-of select="image"/></image></xsl:if>
                    <xsl:if test="template != ''"><template><xsl:value-of select="template"/></template></xsl:if>
                    <page-attributes>
                        <xsl:if test="page_title != ''"><page-title xml:lang="x-default"><xsl:value-of select="page_title"/></page-title></xsl:if>
                        <xsl:if test="page_description != ''"><page-description xml:lang="x-default"><xsl:value-of select="page_description"/></page-description></xsl:if>

                    </page-attributes>
                    <custom-attributes>
                        <xsl:if test="show_in_menu != ''"><custom-attribute attribute-id="showInMenu"><xsl:value-of select="show_in_menu"/></custom-attribute></xsl:if>
                    </custom-attributes>
                </category>
            </xsl:for-each>
        </catalog>
    </xsl:template>
</xsl:stylesheet>
