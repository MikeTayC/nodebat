<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslt="http://xml.apache.org/xslt"
                exclude-result-prefixes="xslt">

    <xsl:output method="xml" xslt:indent-amount="4" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
        <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

        <catalog xmlns="http://www.demandware.com/xml/impex/catalog/2006-10-31" catalog-id="dirtdevil-master">
            <header>
                <image-settings>
                    <external-location>
                        <http-url>http://media.dirtdevil.com/i/ttifloorcare/</http-url>
                        <https-url>https://media.dirtdevil.com/i/ttifloorcare/</https-url>
                    </external-location>
                    <view-types>
                        <view-type>large</view-type>
                        <view-type>medium</view-type>
                        <view-type>small</view-type>
                        <view-type>swatch</view-type>
                        <view-type>hi-res</view-type>
                        <view-type>image</view-type>
                        <view-type>video</view-type>
                        <view-type>spin</view-type>
                        <view-type>set</view-type>
                        <view-type>lifestyle</view-type>
                        <view-type>quickview</view-type>
                        <view-type>zoom</view-type>
                    </view-types>
                    <variation-attribute-id>color</variation-attribute-id>
                    <alt-pattern>${productname}, ${variationvalue}, ${viewtype}</alt-pattern>
                    <title-pattern>${productname}, ${variationvalue}</title-pattern>
                </image-settings>
            </header>

            <category category-id="MAIN">
                <display-name xml:lang="x-default">Main</display-name>
                <online-flag>true</online-flag>
                <parent>root</parent>
            </category>

            <xsl:for-each select="csv_root_node/row">
                <xsl:variable name="incrementId" select="item_number"/>
                <xsl:variable name="siteId" select="'dirtdevil'" />

                <product product-id="{$incrementId}">
                    <xsl:if test="ean != ''"><ean><xsl:value-of select="ean"/></ean></xsl:if>
                    <xsl:if test="upc_code != ''"><upc><xsl:value-of select="upc_code"/></upc></xsl:if>
                    <xsl:if test="unit != ''"><unit><xsl:value-of select="unit"/></unit></xsl:if>
                    <xsl:if test="min-order-quantity != ''"><min-order-quantity><xsl:value-of select="min-order-quantity"/></min-order-quantity></xsl:if>
                    <xsl:if test="step-quantity != ''"><step-quantity><xsl:value-of select="step-quantity"/></step-quantity></xsl:if>

                    <xsl:if test="product_name != '' or item_description != ''">
                        <display-name xml:lang="x-default">
                            <xsl:choose>
                                <xsl:when test="product_name != ''">
                                    <xsl:value-of select="product_name"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="item_description"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </display-name>
                    </xsl:if>

                    <xsl:if test="lead_in != ''"><short-description xml:lang="x-default"><xsl:value-of select="lead_in"/></short-description></xsl:if>
                    <xsl:if test="web_description != ''"><long-description xml:lang="x-default"><xsl:value-of select="web_description"/></long-description></xsl:if>

                    <xsl:choose>
                        <xsl:when test="ProductType = 'Variation Master'">
                            <online-flag>true</online-flag>
                            <searchable-flag>false</searchable-flag>
                        </xsl:when>
                        <xsl:when test="ProductType = 'Product Set'">
                            <online-flag>true</online-flag>
                            <searchable-flag>false</searchable-flag>
                        </xsl:when>
                        <xsl:otherwise>
                            <online-flag>true</online-flag>
                            <searchable-flag>true</searchable-flag>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:if test="online-from != ''"><online-from><xsl:value-of select="online-from"/></online-from></xsl:if>
                    <xsl:if test="online-to != ''"><online-to><xsl:value-of select="online-to"/></online-to></xsl:if>
                    <xsl:if test="available-flag != ''"><available-flag><xsl:value-of select="translate(available-flag, $uppercase, $smallcase)"/></available-flag></xsl:if>
                    <xsl:if test="brand != ''"><brand><xsl:value-of select="brand"/></brand></xsl:if>
                    <xsl:if test="manufacturer-name != ''"><manufacturer-name><xsl:value-of select="manufacturer-name"/></manufacturer-name></xsl:if>
                    <xsl:if test="manufacturer-sku != ''"><manufacturer-sku><xsl:value-of select="manufacturer-sku"/></manufacturer-sku></xsl:if>
                    <xsl:if test="search-placement != ''"><search-placement site-id="{$siteId}"><xsl:value-of select="search-placement"/></search-placement></xsl:if>
                    <xsl:if test="search-rank != ''"><search-rank site-id="{$siteId}"><xsl:value-of select="search-rank"/></search-rank></xsl:if>
                    <xsl:if test="sitemap-included-flag != ''"><sitemap-included-flag site-id="{$siteId}"><xsl:value-of select="sitemap-included-flag"/></sitemap-included-flag></xsl:if>
                    <xsl:if test="sitemap-changefrequency != ''"><sitemap-changefrequency site-id="{$siteId}"><xsl:value-of select="sitemap-changefrequency"/></sitemap-changefrequency></xsl:if>
                    <xsl:if test="sitemap-priority != ''"><sitemap-priority site-id="{$siteId}"><xsl:value-of select="sitemap-priority"/></sitemap-priority></xsl:if>
                    <xsl:if test="pinterest-enabled-flag != ''"><pinterest-enabled-flag><xsl:value-of select="translate(pinterest-enabled-flag, $uppercase, $smallcase)"/></pinterest-enabled-flag></xsl:if>
                    <xsl:if test="facebook-enabled-flag != ''"><facebook-enabled-flag><xsl:value-of select="translate(facebook-enabled-flag, $uppercase, $smallcase)"/></facebook-enabled-flag></xsl:if>
                    <xsl:if test="Tax-Class-Id != ''"><tax-class-id><xsl:value-of select="Tax-Class-Id"/></tax-class-id></xsl:if>
                    <page-attributes>
                        <xsl:if test="page_title != ''"><page-title xml:lang="x-default"><xsl:value-of select="page_title"/></page-title></xsl:if>
                        <xsl:if test="meta_description != ''"> <page-description xml:lang="x-default"><xsl:value-of select="meta_description"/></page-description></xsl:if>
                        <xsl:if test="meta_keywords != ''"><page-keywords xml:lang="x-default"><xsl:value-of select="meta_keywords"/></page-keywords></xsl:if>
                    </page-attributes>
                    <custom-attributes>
                        <xsl:if test="above_floor_cleaning_reach != ''"><custom-attribute attribute-id="above_floor_cleaning_reach"><xsl:value-of select="above_floor_cleaning_reach"/></custom-attribute></xsl:if>
                        <xsl:if test="accessories_included != ''"><custom-attribute attribute-id="accessories_included"><xsl:value-of select="accessories_included"/></custom-attribute></xsl:if>
                        <xsl:if test="ad_tagline != ''"><custom-attribute attribute-id="ad_tagline"><xsl:value-of select="ad_tagline"/></custom-attribute></xsl:if>
                        <xsl:if test="aham_certified != ''"><custom-attribute attribute-id="aham_certified"><xsl:value-of select="aham_certified"/></custom-attribute></xsl:if>
                        <xsl:if test="allergenblock != ''"><custom-attribute attribute-id="allergenblock"><xsl:value-of select="allergenblock"/></custom-attribute></xsl:if>
                        <xsl:if test="assembled_unit_depth != ''"><custom-attribute attribute-id="assembled_unit_depth"><xsl:value-of select="assembled_unit_depth"/></custom-attribute></xsl:if>
                        <xsl:if test="assembled_unit_height != ''"><custom-attribute attribute-id="assembled_unit_height"><xsl:value-of select="assembled_unit_height"/></custom-attribute></xsl:if>
                        <xsl:if test="assembled_unit_width != ''"><custom-attribute attribute-id="assembled_unit_width"><xsl:value-of select="assembled_unit_width"/></custom-attribute></xsl:if>
                        <xsl:if test="assembly_required != ''"><custom-attribute attribute-id="assembly_required"><xsl:value-of select="assembly_required"/></custom-attribute></xsl:if>
                        <xsl:if test="auto_cord_rewind != ''"><custom-attribute attribute-id="auto_cord_rewind"><xsl:value-of select="auto_cord_rewind"/></custom-attribute></xsl:if>
                        <xsl:if test="auto_detergent_mix != ''"><custom-attribute attribute-id="auto_detergent_mix"><xsl:value-of select="auto_detergent_mix"/></custom-attribute></xsl:if>
                        <xsl:if test="available_in_ca != ''"><custom-attribute attribute-id="available_in_ca"><xsl:value-of select="available_in_ca"/></custom-attribute></xsl:if>
                        <xsl:if test="available_in_us != ''"><custom-attribute attribute-id="available_in_us"><xsl:value-of select="available_in_us"/></custom-attribute></xsl:if>
                        <xsl:if test="available_modes != ''"><custom-attribute attribute-id="available_modes"><xsl:value-of select="available_modes"/></custom-attribute></xsl:if>
                        <xsl:if test="average_rating != ''"><custom-attribute attribute-id="average_rating"><xsl:value-of select="average_rating"/></custom-attribute></xsl:if>
                        <xsl:if test="bagless != ''"><custom-attribute attribute-id="bagless"><xsl:value-of select="bagless"/></custom-attribute></xsl:if>
                        <xsl:if test="battery_run_time != ''"><custom-attribute attribute-id="battery_run_time"><xsl:value-of select="battery_run_time"/></custom-attribute></xsl:if>
                        <xsl:if test="battery_type != ''"><custom-attribute attribute-id="battery_type"><xsl:value-of select="battery_type"/></custom-attribute></xsl:if>
                        <xsl:if test="battery_volts != ''"><custom-attribute attribute-id="battery_volts"><xsl:value-of select="battery_volts"/></custom-attribute></xsl:if>
                        <xsl:if test="bin_capacity != ''"><custom-attribute attribute-id="bin_capacity"><xsl:value-of select="bin_capacity"/></custom-attribute></xsl:if>
                        <xsl:if test="brush_speed != ''"><custom-attribute attribute-id="brush_speed"><xsl:value-of select="brush_speed"/></custom-attribute></xsl:if>
                        <xsl:if test="brushed_edge_cleaning != ''"><custom-attribute attribute-id="brushed_edge_cleaning"><xsl:value-of select="brushed_edge_cleaning"/></custom-attribute></xsl:if>
                        <xsl:if test="brushroll_shutoff != ''"><custom-attribute attribute-id="brushroll_shutoff"><xsl:value-of select="brushroll_shutoff"/></custom-attribute></xsl:if>
                        <xsl:if test="brushroll_window != ''"><custom-attribute attribute-id="brushroll_window"><xsl:value-of select="brushroll_window"/></custom-attribute></xsl:if>
                        <xsl:if test="bumper_type != ''"><custom-attribute attribute-id="bumper_type"><xsl:value-of select="bumper_type"/></custom-attribute></xsl:if>
                        <xsl:if test="carb_certified != ''"><custom-attribute attribute-id="carb_certified"><xsl:value-of select="carb_certified"/></custom-attribute></xsl:if>
                        <xsl:if test="charge_time != ''"><custom-attribute attribute-id="charge_time"><xsl:value-of select="charge_time"/></custom-attribute></xsl:if>
                        <xsl:if test="clean_air_delivery_rate != ''"><custom-attribute attribute-id="clean_air_delivery_rate"><xsl:value-of select="clean_air_delivery_rate"/></custom-attribute></xsl:if>
                        <xsl:if test="clean_surge != ''"><custom-attribute attribute-id="clean_surge"><xsl:value-of select="clean_surge"/></custom-attribute></xsl:if>
                        <xsl:if test="clean_water_capacity != ''"><custom-attribute attribute-id="clean_water_capacity"><xsl:value-of select="clean_water_capacity"/></custom-attribute></xsl:if>
                        <xsl:if test="cleaning_solutions_included != ''"><custom-attribute attribute-id="cleaning_solutions_included"><xsl:value-of select="cleaning_solutions_included"/></custom-attribute></xsl:if>
                        <xsl:if test="color_exact != ''"><custom-attribute attribute-id="color"><xsl:value-of select="color_exact"/></custom-attribute></xsl:if>
                        <xsl:if test="continuous_steam_time_hi != ''"><custom-attribute attribute-id="continuous_steam_time_hi"><xsl:value-of select="continuous_steam_time_hi"/></custom-attribute></xsl:if>
                        <xsl:if test="continuous_steam_time_low != ''"><custom-attribute attribute-id="continuous_steam_time_low"><xsl:value-of select="continuous_steam_time_low"/></custom-attribute></xsl:if>
                        <xsl:if test="cord_length != ''"><custom-attribute attribute-id="cordLength"><xsl:value-of select="cord_length"/></custom-attribute></xsl:if>
                        <xsl:if test="cordless != ''"><custom-attribute attribute-id="cordless"><xsl:value-of select="cordless"/></custom-attribute></xsl:if>
                        <xsl:if test="country_of_origin != ''"><custom-attribute attribute-id="country_of_origin"><xsl:value-of select="country_of_origin"/></custom-attribute></xsl:if>
                        <xsl:if test="cyclonic_action != ''"><custom-attribute attribute-id="cyclonic_action"><xsl:value-of select="cyclonic_action"/></custom-attribute></xsl:if>
                        <xsl:if test="detachable_hand_vac != ''"><custom-attribute attribute-id="detachable_hand_vac"><xsl:value-of select="detachable_hand_vac"/></custom-attribute></xsl:if>
                        <xsl:if test="detachable_handle != ''"><custom-attribute attribute-id="detachable_handle"><xsl:value-of select="detachable_handle"/></custom-attribute></xsl:if>
                        <xsl:if test="detergent_capacity != ''"><custom-attribute attribute-id="detergent_capacity"><xsl:value-of select="detergent_capacity"/></custom-attribute></xsl:if>
                        <xsl:if test="dirt_cup != ''"><custom-attribute attribute-id="dirt_cup"><xsl:value-of select="dirt_cup"/></custom-attribute></xsl:if>
                        <xsl:if test="dirt_cup_capacity != ''"><custom-attribute attribute-id="dirt_cup_capacity"><xsl:value-of select="dirt_cup_capacity"/></custom-attribute></xsl:if>
                        <xsl:if test="dirt_finder != ''"><custom-attribute attribute-id="dirt_finder"><xsl:value-of select="dirt_finder"/></custom-attribute></xsl:if>
                        <xsl:if test="dirt_path != ''"><custom-attribute attribute-id="dirt_path"><xsl:value-of select="dirt_path"/></custom-attribute></xsl:if>
                        <xsl:if test="dirty_water_capacity != ''"><custom-attribute attribute-id="dirty_water_capacity"><xsl:value-of select="dirty_water_capacity"/></custom-attribute></xsl:if>
                        <xsl:if test="dry_nozzle_brush_type != ''"><custom-attribute attribute-id="dry_nozzle_brush_type"><xsl:value-of select="dry_nozzle_brush_type"/></custom-attribute></xsl:if>
                        <xsl:if test="empty_bin != ''"><custom-attribute attribute-id="empty_bin"><xsl:value-of select="empty_bin"/></custom-attribute></xsl:if>
                        <xsl:if test="energy_star_compliant != ''"><custom-attribute attribute-id="energyStar"><xsl:value-of select="energy_star_compliant"/></custom-attribute></xsl:if>
                        <xsl:if test="filter_type_part_number != ''"><custom-attribute attribute-id="filter_type_part_number"><xsl:value-of select="filter_type_part_number"/></custom-attribute></xsl:if>
                        <xsl:if test="filtration != ''"><custom-attribute attribute-id="filtration"><xsl:value-of select="filtration"/></custom-attribute></xsl:if>
                        <xsl:if test="filtration_features != ''"><custom-attribute attribute-id="filtration_features"><xsl:value-of select="filtration_features"/></custom-attribute></xsl:if>
                        <xsl:if test="fingertip_controls != ''"><custom-attribute attribute-id="fingertip_controls"><xsl:value-of select="fingertip_controls"/></custom-attribute></xsl:if>
                        <xsl:if test="full_indicator != ''"><custom-attribute attribute-id="full_indicator"><xsl:value-of select="full_indicator"/></custom-attribute></xsl:if>
                        <xsl:if test="grip_type != ''"><custom-attribute attribute-id="grip_type"><xsl:value-of select="grip_type"/></custom-attribute></xsl:if>
                        <xsl:if test="handle != ''"><custom-attribute attribute-id="handle"><xsl:value-of select="handle"/></custom-attribute></xsl:if>
                        <xsl:if test="handle_material != ''"><custom-attribute attribute-id="handle_material"><xsl:value-of select="handle_material"/></custom-attribute></xsl:if>
                        <xsl:if test="headlight != ''"><custom-attribute attribute-id="headlight"><xsl:value-of select="headlight"/></custom-attribute></xsl:if>
                        <xsl:if test="heated_cleaning != ''"><custom-attribute attribute-id="heated_cleaning"><xsl:value-of select="heated_cleaning"/></custom-attribute></xsl:if>
                        <xsl:if test="heating_time != ''"><custom-attribute attribute-id="heating_time"><xsl:value-of select="heating_time"/></custom-attribute></xsl:if>
                        <xsl:if test="height_adjustment != ''"><custom-attribute attribute-id="heightAdjustment"><xsl:value-of select="height_adjustment"/></custom-attribute></xsl:if>
                        <xsl:if test="high_pressure_hose != ''"><custom-attribute attribute-id="high_pressure_hose"><xsl:value-of select="high_pressure_hose"/></custom-attribute></xsl:if>
                        <xsl:if test="hose_color != ''"><custom-attribute attribute-id="hose_color"><xsl:value-of select="hose_color"/></custom-attribute></xsl:if>
                        <xsl:if test="hose_length != ''"><custom-attribute attribute-id="hose_length"><xsl:value-of select="hose_length"/></custom-attribute></xsl:if>
                        <xsl:if test="hose_type != ''"><custom-attribute attribute-id="hose_type"><xsl:value-of select="hose_type"/></custom-attribute></xsl:if>
                        <xsl:if test="ionizer != ''"><custom-attribute attribute-id="ionizer"><xsl:value-of select="ionizer"/></custom-attribute></xsl:if>
                        <xsl:if test="item_id != ''"><custom-attribute attribute-id="item_id"><xsl:value-of select="item_id"/></custom-attribute></xsl:if>
                        <xsl:if test="lcd_display != ''"><custom-attribute attribute-id="lcd_display"><xsl:value-of select="lcd_display"/></custom-attribute></xsl:if>
                        <xsl:if test="lightweight != ''"><custom-attribute attribute-id="lightweight"><xsl:value-of select="lightweight"/></custom-attribute></xsl:if>
                        <xsl:if test="lithium_ion != ''"><custom-attribute attribute-id="lithium_ion"><xsl:value-of select="lithium_ion"/></custom-attribute></xsl:if>

                        <xsl:if test="motor_amps != ''"><custom-attribute attribute-id="motor_amps"><xsl:value-of select="motor_amps"/></custom-attribute></xsl:if>
                        <xsl:if test="motor_volts != ''"><custom-attribute attribute-id="motor_volts"><xsl:value-of select="motor_volts"/></custom-attribute></xsl:if>
                        <xsl:if test="motor_warranty != '' and motor_warranty != '0 Days'"><custom-attribute attribute-id="motor_warranty"><xsl:value-of select="motor_warranty"/></custom-attribute></xsl:if>
                        <xsl:if test="motor_watts != ''"><custom-attribute attribute-id="motor_watts"><xsl:value-of select="motor_watts"/></custom-attribute></xsl:if>
                        <xsl:if test="multi_speed_fan != ''"><custom-attribute attribute-id="multi_speed_fan"><xsl:value-of select="multi_speed_fan"/></custom-attribute></xsl:if>
                        <xsl:if test="nozzle_width != ''"><custom-attribute attribute-id="nozzle_width"><xsl:value-of select="nozzle_width"/></custom-attribute></xsl:if>
                        <xsl:if test="number_of_cyclones != ''"><custom-attribute attribute-id="number_of_cyclones"><xsl:value-of select="number_of_cyclones"/></custom-attribute></xsl:if>
                        <xsl:if test="number_of_motors != ''"><custom-attribute attribute-id="number_of_motors"><xsl:value-of select="number_of_motors"/></custom-attribute></xsl:if>
                        <xsl:if test="on_demand_wand != ''"><custom-attribute attribute-id="on_demand_wand"><xsl:value-of select="on_demand_wand"/></custom-attribute></xsl:if>
                        <xsl:if test="onboard_tools != ''"><custom-attribute attribute-id="onboard_tools"><xsl:value-of select="onboard_tools"/></custom-attribute></xsl:if>
                        <xsl:if test="over_the_wall_separator != ''"><custom-attribute attribute-id="over_the_wall_separator"><xsl:value-of select="over_the_wall_separator"/></custom-attribute></xsl:if>
                        <xsl:if test="part_parent_sku != ''"><custom-attribute attribute-id="part_parent_sku"><xsl:value-of select="part_parent_sku"/></custom-attribute></xsl:if>
                        <xsl:if test="pdp_description != ''"><custom-attribute attribute-id="longDescription"><xsl:value-of select="pdp_description"/></custom-attribute></xsl:if>
                        <xsl:if test="pdp_features != ''"><custom-attribute attribute-id="features"><xsl:value-of select="pdp_features"/></custom-attribute></xsl:if>
                        <xsl:if test="pdp_whats_in_box != ''"><custom-attribute attribute-id="included"><xsl:value-of select="pdp_whats_in_box"/></custom-attribute></xsl:if>
                        <xsl:if test="perfect_for_pets != ''"><custom-attribute attribute-id="perfect_for_pets"><xsl:value-of select="perfect_for_pets"/></custom-attribute></xsl:if>
                        <xsl:if test="performance_check_indicator != ''"><custom-attribute attribute-id="performance_check_indicator"><xsl:value-of select="performance_check_indicator"/></custom-attribute></xsl:if>
                        <xsl:if test="power_nozzle != ''"><custom-attribute attribute-id="power_nozzle"><xsl:value-of select="power_nozzle"/></custom-attribute></xsl:if>
                        <xsl:if test="pressurized_steam != ''"><custom-attribute attribute-id="pressurized_steam"><xsl:value-of select="pressurized_steam"/></custom-attribute></xsl:if>
                        <xsl:if test="primary_filter_life != ''"><custom-attribute attribute-id="primary_filter_life"><xsl:value-of select="primary_filter_life"/></custom-attribute></xsl:if>
                        <xsl:if test="product_demo != ''"><custom-attribute attribute-id="product_demo"><xsl:value-of select="product_demo"/></custom-attribute></xsl:if>
                        <xsl:if test="product_weight != ''"><custom-attribute attribute-id="weight"><xsl:value-of select="product_weight"/></custom-attribute></xsl:if>
                        <xsl:if test="quick_release_cord != ''"><custom-attribute attribute-id="quick_release_cord"><xsl:value-of select="quick_release_cord"/></custom-attribute></xsl:if>
                        <xsl:if test="ready_to_use_hose != ''"><custom-attribute attribute-id="ready_to_use_hose"><xsl:value-of select="ready_to_use_hose"/></custom-attribute></xsl:if>
                        <xsl:if test="remote_control != ''"><custom-attribute attribute-id="remote_control"><xsl:value-of select="remote_control"/></custom-attribute></xsl:if>
                        <xsl:if test="removable_brushes != ''"><custom-attribute attribute-id="removable_brushes"><xsl:value-of select="removable_brushes"/></custom-attribute></xsl:if>
                        <xsl:if test="removable_nozzle != ''"><custom-attribute attribute-id="removable_nozzle"><xsl:value-of select="removable_nozzle"/></custom-attribute></xsl:if>
                        <xsl:if test="removable_solution_tank != ''"><custom-attribute attribute-id="removable_solution_tank"><xsl:value-of select="removable_solution_tank"/></custom-attribute></xsl:if>
                        <xsl:if test="removable_water_tank != ''"><custom-attribute attribute-id="removable_water_tank"><xsl:value-of select="removable_water_tank"/></custom-attribute></xsl:if>
                        <xsl:if test="rinse != ''"><custom-attribute attribute-id="rinse"><xsl:value-of select="rinse"/></custom-attribute></xsl:if>
                        <xsl:if test="safety_pressure_indicator != ''"><custom-attribute attribute-id="safety_pressure_indicator"><xsl:value-of select="safety_pressure_indicator"/></custom-attribute></xsl:if>
                        <xsl:if test="safety_rated != ''"><custom-attribute attribute-id="safety_rated"><xsl:value-of select="safety_rated"/></custom-attribute></xsl:if>
                        <xsl:if test="scatter_guard != ''"><custom-attribute attribute-id="scatter_guard"><xsl:value-of select="scatter_guard"/></custom-attribute></xsl:if>
                        <xsl:if test="secondary_filtration != ''"><custom-attribute attribute-id="secondary_filtration"><xsl:value-of select="secondary_filtration"/></custom-attribute></xsl:if>
                        <xsl:if test="secondary_filtration_features != ''"><custom-attribute attribute-id="secondary_filtration_features"><xsl:value-of select="secondary_filtration_features"/></custom-attribute></xsl:if>
                        <xsl:if test="self_propelled != ''"><custom-attribute attribute-id="self_propelled"><xsl:value-of select="self_propelled"/></custom-attribute></xsl:if>
                        <xsl:if test="spot_sprayer != ''"><custom-attribute attribute-id="spot_sprayer"><xsl:value-of select="spot_sprayer"/></custom-attribute></xsl:if>
                        <xsl:if test="steam_intensity_adjustment != ''"><custom-attribute attribute-id="steam_intensity_adjustment"><xsl:value-of select="steam_intensity_adjustment"/></custom-attribute></xsl:if>
                        <xsl:if test="steamstream_technology != ''"><custom-attribute attribute-id="steamstream_technology"><xsl:value-of select="steamstream_technology"/></custom-attribute></xsl:if>
                        <xsl:if test="steerable != ''"><custom-attribute attribute-id="steerable"><xsl:value-of select="steerable"/></custom-attribute></xsl:if>
                        <xsl:if test="base_model != '' and ProductType != 'Variation Master' and ProductType != 'Product Set'">
                            <custom-attribute attribute-id="style"><xsl:value-of select="base_model"/></custom-attribute>
                        </xsl:if>
                        <xsl:if test="suction_technology != ''"><custom-attribute attribute-id="suction_technology"><xsl:value-of select="suction_technology"/></custom-attribute></xsl:if>
                        <xsl:if test="swivel_head != ''"><custom-attribute attribute-id="swivel_head"><xsl:value-of select="swivel_head"/></custom-attribute></xsl:if>
                        <xsl:if test="tank_system != ''"><custom-attribute attribute-id="tank_system"><xsl:value-of select="tank_system"/></custom-attribute></xsl:if>
                        <xsl:if test="timer != ''"><custom-attribute attribute-id="timer"><xsl:value-of select="timer"/></custom-attribute></xsl:if>
                        <xsl:if test="tools_included != ''"><custom-attribute attribute-id="tools_included"><xsl:value-of select="tools_included"/></custom-attribute></xsl:if>
                        <xsl:if test="touch_screen_control_panel != ''"><custom-attribute attribute-id="touch_screen_control_panel"><xsl:value-of select="touch_screen_control_panel"/></custom-attribute></xsl:if>
                        <xsl:if test="tvpage_video_url != ''"><custom-attribute attribute-id="tvpage_video_url"><xsl:value-of select="tvpage_video_url"/></custom-attribute></xsl:if>
                        <xsl:if test="uv_bulb != ''"><custom-attribute attribute-id="uv_bulb"><xsl:value-of select="uv_bulb"/></custom-attribute></xsl:if>
                        <xsl:if test="variable_suction_control != ''"><custom-attribute attribute-id="variable_suction_control"><xsl:value-of select="variable_suction_control"/></custom-attribute></xsl:if>
                        <xsl:if test="video_instruction_guide != ''"><custom-attribute attribute-id="video_instruction_guide"><xsl:value-of select="video_instruction_guide"/></custom-attribute></xsl:if>
                        <xsl:if test="wall_mountable != ''"><custom-attribute attribute-id="wall_mountable"><xsl:value-of select="wall_mountable"/></custom-attribute></xsl:if>
                        <xsl:if test="wand != ''"><custom-attribute attribute-id="wand"><xsl:value-of select="wand"/></custom-attribute></xsl:if>
                        <xsl:if test="wand_style != ''"><custom-attribute attribute-id="wand_style"><xsl:value-of select="wand_style"/></custom-attribute></xsl:if>
                        <xsl:if test="wand_type != ''"><custom-attribute attribute-id="wand_type"><xsl:value-of select="wand_type"/></custom-attribute></xsl:if>
                        <xsl:if test="water_level_indicator != ''"><custom-attribute attribute-id="water_level_indicator"><xsl:value-of select="water_level_indicator"/></custom-attribute></xsl:if>
                        <xsl:if test="wet_nozzle_brush_type != ''"><custom-attribute attribute-id="wet_nozzle_brush_type"><xsl:value-of select="wet_nozzle_brush_type"/></custom-attribute></xsl:if>
                        <xsl:if test="wheel_type != ''"><custom-attribute attribute-id="wheel_type"><xsl:value-of select="wheel_type"/></custom-attribute></xsl:if>
                        <xsl:if test="windtunnel_technology != ''"><custom-attribute attribute-id="windtunnel_technology"><xsl:value-of select="windtunnel_technology"/></custom-attribute></xsl:if>

                        <!-- New Fields -->
                        <xsl:if test="foldable_handle != ''"><custom-attribute attribute-id="foldable_handle"><xsl:value-of select="foldable_handle"/></custom-attribute></xsl:if>
                        <xsl:if test="vaccuum_mode != ''"><custom-attribute attribute-id="vaccuum_mode"><xsl:value-of select="vaccuum_mode"/></custom-attribute></xsl:if>
                        <xsl:if test="steam_floor_setting != ''"><custom-attribute attribute-id="steam_floor_setting"><xsl:value-of select="steam_floor_setting"/></custom-attribute></xsl:if>
                        <xsl:if test="tile_and_grout_scrub_brush != ''"><custom-attribute attribute-id="tile_and_grout_scrub_brush"><xsl:value-of select="tile_and_grout_scrub_brush"/></custom-attribute></xsl:if>
                        <xsl:if test="bacteria_removal != ''"><custom-attribute attribute-id="bacteria_removal"><xsl:value-of select="bacteria_removal"/></custom-attribute></xsl:if>
                        <xsl:if test="rinse_mode != ''"><custom-attribute attribute-id="rinse_mode"><xsl:value-of select="rinse_mode"/></custom-attribute></xsl:if>
                        <xsl:if test="surface_type != ''"><custom-attribute attribute-id="surface_type"><xsl:value-of select="surface_type"/></custom-attribute></xsl:if>
                        <xsl:if test="professional_grade != ''"><custom-attribute attribute-id="professional_grade"><xsl:value-of select="professional_grade"/></custom-attribute></xsl:if>
                        <xsl:if test="storage != ''"><custom-attribute attribute-id="storage"><xsl:value-of select="storage"/></custom-attribute></xsl:if>
                        <xsl:if test="auto_docking != ''"><custom-attribute attribute-id="auto_docking"><xsl:value-of select="auto_docking"/></custom-attribute></xsl:if>
                        <xsl:if test="memory != ''"><custom-attribute attribute-id="memory"><xsl:value-of select="memory"/></custom-attribute></xsl:if>
                        <xsl:if test="removable_battery != ''"><custom-attribute attribute-id="removable_battery"><xsl:value-of select="removable_battery"/></custom-attribute></xsl:if>
                        <xsl:if test="connectivity != ''"><custom-attribute attribute-id="connectivity"><xsl:value-of select="connectivity"/></custom-attribute></xsl:if>
                        <xsl:if test="navigation != ''"><custom-attribute attribute-id="navigation"><xsl:value-of select="navigation"/></custom-attribute></xsl:if>
                        <xsl:if test="brush_system != ''"><custom-attribute attribute-id="brush_system"><xsl:value-of select="brush_system"/></custom-attribute></xsl:if>
                        <xsl:if test="reach != ''"><custom-attribute attribute-id="reach"><xsl:value-of select="reach"/></custom-attribute></xsl:if>
                        <xsl:if test="multi_floor_on_off != ''"><custom-attribute attribute-id="multi_floor_on_off"><xsl:value-of select="multi_floor_on_off"/></custom-attribute></xsl:if>
                        <xsl:if test="cleaning_path != ''"><custom-attribute attribute-id="cleaning_path"><xsl:value-of select="cleaning_path"/></custom-attribute></xsl:if>
                        <xsl:if test="sealed_allergen_systtem != ''"><custom-attribute attribute-id="sealed_allergen_systtem"><xsl:value-of select="sealed_allergen_systtem"/></custom-attribute></xsl:if>

                        <xsl:if test="unit_weight != ''"><custom-attribute attribute-id="unit_weight"><xsl:value-of select="unit_weight"/></custom-attribute></xsl:if>
                        <xsl:if test="unit_weight_uom != ''"><custom-attribute attribute-id="unit_weight_uom"><xsl:value-of select="unit_weight_uom"/></custom-attribute></xsl:if>
                        <xsl:if test="unit_height != ''"><custom-attribute attribute-id="unit_height"><xsl:value-of select="unit_height"/></custom-attribute></xsl:if>
                        <xsl:if test="unit_length != ''"><custom-attribute attribute-id="unit_length"><xsl:value-of select="unit_length"/></custom-attribute></xsl:if>
                        <xsl:if test="unit_width != ''"><custom-attribute attribute-id="unit_width"><xsl:value-of select="unit_width"/></custom-attribute></xsl:if>

                        <!-- Web Fields -->
                        <xsl:if test="web_features != ''"><custom-attribute attribute-id="features"><xsl:value-of select="web_features"/></custom-attribute></xsl:if>
                        <xsl:if test="web_box != ''"><custom-attribute attribute-id="included"><xsl:value-of select="web_box"/></custom-attribute></xsl:if>


                        <!-- Set Flag for shipping on lithium Ion battery products -->
                        <xsl:if test="shipping_lithium_ion != ''">
                            <xsl:choose>
                                <xsl:when test="shipping_lithium_ion = 'Y'">
                                    <custom-attribute attribute-id="shipping_lithium_ion">true</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = 'N'">
                                    <custom-attribute attribute-id="shipping_lithium_ion">false</custom-attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <custom-attribute attribute-id="shipping_lithium_ion">false</custom-attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>

                        <xsl:if test="ProductType = 'Product Set'">
                            <custom-attribute attribute-id="is_parts_set">true</custom-attribute>
                        </xsl:if>

                        <xsl:if test="product_class != ''">
                            <custom-attribute attribute-id="product_class"><xsl:value-of select="product_class"/></custom-attribute>

                            <xsl:choose>
                                <xsl:when test="product_class = '08'">
                                    <custom-attribute attribute-id="product_class_description">CLOTH BAGS</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '09'">
                                    <custom-attribute attribute-id="product_class_description">FILTER BAGS</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '10'">
                                    <custom-attribute attribute-id="product_class_description">FILTERS</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '13'">
                                    <custom-attribute attribute-id="product_class_description">MOTORS</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '15'">
                                    <custom-attribute attribute-id="product_class_description">POWER CORDS</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '16'">
                                    <custom-attribute attribute-id="product_class_description">AGITATOR BRUSHES AND BRISTLES</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '18'">
                                    <custom-attribute attribute-id="product_class_description">HOSES</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '20'">
                                    <custom-attribute attribute-id="product_class_description">POWER NOZZLES</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '28'">
                                    <custom-attribute attribute-id="product_class_description">PLASTIC PARTS</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '29'">
                                    <custom-attribute attribute-id="product_class_description">BELTS</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '30'">
                                    <custom-attribute attribute-id="product_class_description">CLEANING SOLUTION</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '36'">
                                    <custom-attribute attribute-id="product_class_description">REPLACEMENT PADS</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '37'">
                                    <custom-attribute attribute-id="product_class_description">BATTERIES</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '38'">
                                    <custom-attribute attribute-id="product_class_description">CHARGERS</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '50'">
                                    <custom-attribute attribute-id="product_class_description">POWERED HAND TOOL</custom-attribute>
                                </xsl:when>
                                <xsl:when test="product_class = '03'">
                                    <custom-attribute attribute-id="product_class_description">FINISHED GOODS</custom-attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <custom-attribute attribute-id="product_class_description">FINISHED GOODS</custom-attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                    </custom-attributes>
                    <classification-category>MAIN</classification-category>

                    <xsl:if test="ProductType = 'Product Set' and product-set-products != '' ">
                        <product-set-products>
                            <xsl:for-each select="product-set-products/product">
                                <xsl:element name="product-set-products">
                                    <xsl:attribute name="product-id">
                                        <xsl:value-of select="."/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:for-each>
                        </product-set-products>
                    </xsl:if>
                </product>
            </xsl:for-each>
            <xsl:for-each select="csv_root_node/row">
                <xsl:if test="ProductType = 'Product Set'">
                    <xsl:variable name="incrementId" select="item_number"/>
                    <category-assignment category-id="MAIN" product-id="{$incrementId}"/>
                </xsl:if>
            </xsl:for-each>
        </catalog>
    </xsl:template>
</xsl:stylesheet>
