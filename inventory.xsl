<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslt="http://xml.apache.org/xslt"
                exclude-result-prefixes="xslt">

    <xsl:output method="xml" xslt:indent-amount="4" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
        <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
        <inventory xmlns="http://www.demandware.com/xml/impex/inventory/2007-05-31">
            <inventory-list>
                <header list-id="livingproof_inventory">
                    <default-instock>true</default-instock>
                    <description>Living Proof Inventory</description>
                    <use-bundle-inventory-only>false</use-bundle-inventory-only>
                    <on-order>true</on-order>
                </header>
                <records>
                    <xsl:for-each select="csv_root_node/row">
                        <xsl:variable name="incrementId" select="sku"/>
                        <record product-id="{$incrementId}">
                            <xsl:if test="inventory != ''"><allocation><xsl:value-of select="inventory"/></allocation></xsl:if>
                            <perpetual>true</perpetual>
                            <preorder-backorder-handling>none</preorder-backorder-handling>
                            <preorder-backorder-allocation>0</preorder-backorder-allocation>
                            <xsl:if test="inventory != ''"><ats><xsl:value-of select="inventory"/></ats></xsl:if>
                            <on-order>0</on-order>
                            <turnover>0</turnover>
                        </record>
                    </xsl:for-each>
                </records>
            </inventory-list>
        </inventory>
    </xsl:template>
</xsl:stylesheet>
