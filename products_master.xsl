<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslt="http://xml.apache.org/xslt"
                exclude-result-prefixes="xslt">

    <xsl:output method="xml" xslt:indent-amount="4" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
        <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

        <catalog xmlns="http://www.demandware.com/xml/impex/catalog/2006-10-31" catalog-id="livingproof-master">
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

                <product product-id="{$incrementId}">

                    <xsl:if test="ean != ''"><ean><xsl:value-of select="ean"/></ean></xsl:if>
                    <xsl:if test="upc != ''"><upc><xsl:value-of select="upc"/></upc></xsl:if>
                    <xsl:if test="unit != ''"><unit><xsl:value-of select="unit"/></unit></xsl:if>
                    <xsl:if test="min-order-quantity != ''"><min-order-quantity><xsl:value-of select="min-order-quantity"/></min-order-quantity></xsl:if>
                    <xsl:if test="step-quantity != ''"><step-quantity><xsl:value-of select="step-quantity"/></step-quantity></xsl:if>

                    <xsl:if test="name != ''"><display-name><xsl:value-of select="name"/></display-name></xsl:if>

                    <xsl:if test="short_description != ''"><short-description xml:lang="x-default"><xsl:value-of select="short_description"/></short-description></xsl:if>
                    <xsl:if test="description != ''"><long-description xml:lang="x-default"><xsl:value-of select="description"/></long-description></xsl:if>

                    <xsl:choose>
                        <xsl:when test="status = '1'">
                            <online-flag>true</online-flag>
                        </xsl:when>
                        <xsl:otherwise>
                            <online-flag>false</online-flag>
                        </xsl:otherwise>
                    </xsl:choose>

                    <!--<xsl:choose>-->
                        <!--<xsl:when test="visibility = '4' or visibility = '3'">-->
                            <searchable-flag>true</searchable-flag>
                        <!--</xsl:when>-->
                        <!--<xsl:otherwise>-->
                            <!--<searchable-flag>false</searchable-flag>-->
                        <!--</xsl:otherwise>-->
                    <!--</xsl:choose>-->
                        <images>
                            <xsl:if test="image != ''">
                                <image-group view-type="hi-res">
                                    <xsl:variable name="baseImage" select="image"/>
                                    <image path="hi-res/{$baseImage}"/>
                                </image-group>
                            </xsl:if>
                            <xsl:if test="child">
                                <xsl:for-each select="child">
                                    <xsl:if test="image != ''">
                                        <xsl:variable name="childImage" select="image"/>
                                        <xsl:variable name="variationValue" select="size_variations_value"/>

                                        <image-group view-type="hi-res" variation-value="{$variationValue}">
                                            <image path="hi-res/{$childImage}"/>
                                        </image-group>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </images>

                    <tax-class-id>standard</tax-class-id>

                    <xsl:if test="manufacturer != ''"><manufacturer-name><xsl:value-of select="manufacturer"/></manufacturer-name></xsl:if>
                    <xsl:if test="sku"><manufacturer-sku>1<xsl:value-of select="sku"/></manufacturer-sku></xsl:if>
                    <xsl:choose>
                        <xsl:when test="sitemap_included_flag = ''">
                            <sitemap-included-flag site-id="{$siteId}">true</sitemap-included-flag>
                        </xsl:when>
                        <xsl:otherwise>
                            <sitemap-included-flag site-id="{$siteId}"><xsl:value-of select="sitemap_included_flag"/></sitemap-included-flag>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="sitemap-changefrequency != ''"><sitemap-changefrequency site-id="{$siteId}"><xsl:value-of select="sitemap-changefrequency"/></sitemap-changefrequency></xsl:if>
                    <xsl:if test="sitemap-priority != ''"><sitemap-priority site-id="{$siteId}"><xsl:value-of select="sitemap-priority"/></sitemap-priority></xsl:if>

                    <custom-attributes>
                        <xsl:if test="product_size_value != ''"><custom-attribute attribute-id="sizeType"><xsl:value-of select="product_size_value"/></custom-attribute></xsl:if>
                        <xsl:if test="size_variations_value != ''"><custom-attribute attribute-id="size"><xsl:value-of select="size_variations_value"/></custom-attribute></xsl:if>
                        <xsl:if test="franchise_value != ''"><custom-attribute attribute-id="collection"><xsl:value-of select="franchise_value"/></custom-attribute></xsl:if>
                        <xsl:choose>
                            <xsl:when test="hazardous_material = '' or hazardous_material='0'">
                                <custom-attribute attribute-id="hazardous">false</custom-attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <custom-attribute attribute-id="hazardous">true</custom-attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                    </custom-attributes>

                    <xsl:if test="child">
                        <variations>
                            <attributes>
                                <variation-attribute attribute-id="size" variation-attribute-id="size">
                                    <display-name xml:lang="x-default">Size</display-name>
                                    <variation-attribute-values>
                                        <xsl:for-each select="child">
                                            <xsl:variable name="variantSize" select="size_variations_value"/>
                                            <variation-attribute-value value="{$variantSize}">
                                                <display-value xml:lang="x-default"><xsl:value-of select="size_variations_value"/></display-value>
                                                <description xml:lang="x-default"><xsl:value-of select="size_variations_value"/></description>
                                            </variation-attribute-value>
                                        </xsl:for-each>
                                    </variation-attribute-values>
                                </variation-attribute>
                            </attributes>
                            <variants>
                                <xsl:for-each select="child">
                                    <xsl:variable name="childSku" select="sku"/>
                                    <variant product-id="{$childSku}"/>
                                </xsl:for-each>
                            </variants>
                        </variations>
                    </xsl:if>
                </product>
            </xsl:for-each>

            <xsl:for-each select="csv_root_node/row">
                    <xsl:variable name="incrementId" select="sku"/>
                    <xsl:variable name="collection" select="franchise_value"/>

                    <category-assignment category-id="{$collection}" product-id="{$incrementId}"/>
            </xsl:for-each>
        </catalog>
    </xsl:template>
</xsl:stylesheet>
