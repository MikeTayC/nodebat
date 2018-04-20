<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslt="http://xml.apache.org/xslt"
                exclude-result-prefixes="xslt">

    <xsl:output method="xml" xslt:indent-amount="4" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <pricebooks xmlns="http://www.demandware.com/xml/impex/pricebook/2006-10-31">
            <pricebook>
                <header pricebook-id="livingproof-usd-list-prices">
                    <currency>USD</currency>
                    <display-name xml:lang="x-default">List Prices</display-name>
                    <online-flag>true</online-flag>
                </header>
                <price-tables>
                    <xsl:for-each select="csv_root_node/row">
                        <xsl:if test="price != ''">
                            <xsl:variable name="incrementId" select="sku "/>
                            <price-table product-id="{$incrementId}">
                                <amount quantity="1"><xsl:value-of select="price"/></amount>
                            </price-table>
                        </xsl:if>
                    </xsl:for-each>
                </price-tables>
            </pricebook>
        </pricebooks>
    </xsl:template>
</xsl:stylesheet>