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
                <xsl:variable name="incrementId" select="sku"/>
                <xsl:variable name="siteId" select="'SiteGenesis'" />
                <xsl:if test="categories">
                    <xsl:for-each select="categories">
                        <xsl:variable name="categoryId" select="categoryId"/>
                        <category-assignment category-id="{$categoryId}" product-id="{$incrementId}"/>
                    </xsl:for-each>
                </xsl:if>
            </xsl:for-each>
        </catalog>
    </xsl:template>
</xsl:stylesheet>
