<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mets="http://www.loc.gov/METS/"
                xmlns:saxon="http://saxon.sf.net/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ubl="http://www.loc.gov/mods/v3"
                extension-element-prefixes="saxon" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="node() | @*" name="identity">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:param name="object"/>
    <xsl:template match="/">
        <ubl:mets-mods>
            <ubl:fileName>
                <xsl:value-of select="$object"/>
            </ubl:fileName>
            <ubl:recordDate>
                <xsl:value-of select="//mets:metsHdr/@CREATEDATE"/>
            </ubl:recordDate>
            <ubl:title>
                <xsl:value-of select="//*[local-name() = 'mods']/*[local-name() = 'titleInfo']/*[local-name() = 'title']"/>
            </ubl:title>
            <xsl:if test="//*[local-name() = 'subtitle']">
                <ubl:subTitle>
                    <xsl:value-of select="//*[local-name() = 'subtitle']"/>
                </ubl:subTitle>
            </xsl:if>
            <ubl:kitodo>
                <xsl:value-of select="//*[local-name() = 'identifier'][@type = 'goobi']"/>
            </ubl:kitodo>
            <ubl:urn>
                <xsl:value-of select="//*[local-name() = 'identifier'][@type = 'urn']"/>
            </ubl:urn>
            <ubl:ppn>
                <xsl:value-of select="//*[local-name() = 'identifier'][@type = 'swb-ppn']"/>
            </ubl:ppn>
            <xsl:if test="contains(//*[local-name() = 'recordIdentifier'], 'manuscripta-mediaevalia')">
                <ubl:collection>
                    <xsl:text>Manuscripta-Medievalia</xsl:text>
                </ubl:collection>
            </xsl:if>
            <ubl:collection>
                <xsl:value-of select="//mods:relatedItem/mods:titleInfo/mods:title"/>
            </ubl:collection>
            <xsl:if test="contains(//*[local-name() = 'recordIdentifier'], 'manuscripta-mediaevalia')">
                <ubl:manuscriptaMedaevalia>
                    <xsl:value-of select="//*[local-name() = 'recordIdentifier']"/>
                </ubl:manuscriptaMedaevalia>
            </xsl:if>
            <xsl:if test="//*[local-name() = 'identifier'][@type = 'vd17']">
                <ubl:vd17>
                    <xsl:value-of select="//*[local-name() = 'identifier'][@type = 'vd17']"/>
                </ubl:vd17>
            </xsl:if>
            <xsl:if test="//*[local-name() = 'identifier'][@type = 'vd16']">
                <ubl:vd16>
                    <xsl:value-of select="//*[local-name() = 'identifier'][@type = 'vd16']"/>
                </ubl:vd16>
            </xsl:if>
            <xsl:if test="//*[local-name() = 'shelfLocator']">
                <ubl:callNumber>
                    <xsl:value-of select="//*[local-name() = 'shelfLocator']"/>
                </ubl:callNumber>
            </xsl:if>
            <ubl:owner>
                <xsl:value-of select="//*[local-name() = 'owner']"/>
            </ubl:owner>
            <ubl:author>
                <xsl:value-of select="//*[local-name() = 'displayForm']"/>
            </ubl:author>
            <xsl:if test="//*[local-name() = 'placeTerm']">
                <ubl:place>
                    <xsl:value-of select="//*[local-name() = 'placeTerm']"/>
                </ubl:place>
            </xsl:if>
            <xsl:if test="//*[local-name() = 'place'][@eventType = 'manufacture']">
                <ubl:localisierung>
                    <xsl:value-of select="//*[local-name() = 'place'][@eventType = 'manufacture']"/>
                </ubl:localisierung>
            </xsl:if>
            <ubl:date>
                <xsl:value-of select="//*[local-name() = 'dateOther']"/>
            </ubl:date>
            <xsl:if test="//*[local-name() = 'dateCreated']">
                <ubl:datierung>
                    <xsl:value-of select="//*[local-name() = 'dateCreated']"/>
                </ubl:datierung>
            </xsl:if>
            <ubl:publisher>
                <xsl:value-of select="//*[local-name() = 'publisher']"/>
            </ubl:publisher>
            <ubl:physicalDescription>
                <xsl:value-of select="//*[local-name() = 'extent']"/>
            </ubl:physicalDescription>
            <xsl:if test="//*[local-name() = 'extent'][@unit = 'leaves']">
                <ubl:umfang>
                    <xsl:value-of select="//*[local-name() = 'extent'][@unit = 'leaves']"/>
                </ubl:umfang>
            </xsl:if>
            <xsl:if test="//*[local-name() = 'extent'][@unit = 'cm']">
                <ubl:abmessung>
                    <xsl:value-of select="//*[local-name() = 'extent'][@unit = 'cm']"/>
                </ubl:abmessung>
            </xsl:if>
            <xsl:if test="//*[local-name() = 'typeOfResource']">
                <ubl:medium>
                    <xsl:value-of select="//*[local-name() = 'typeOfResource']"/>
                </ubl:medium>
            </xsl:if>
            <xsl:if test="//*[local-name() = 'form'][@type = 'material']">
                <ubl:beschreibstoff>
                    <xsl:value-of select="//*[local-name() = 'form'][@type = 'material']"/>
                </ubl:beschreibstoff>
            </xsl:if>
            <ubl:manifestType>
                <xsl:value-of select="//*[local-name() = 'structMap'][@TYPE = 'LOGICAL']//*[local-name() = 'div'][@ID = 'LOG_0000']/@TYPE"/>
            </ubl:manifestType>

            <xsl:if test="//mods:scriptTerm">
                <ubl:script-iso-15924>
                    <xsl:value-of select="//mods:scriptTerm"/>
                </ubl:script-iso-15924>
            </xsl:if>
            <xsl:if test="//mods:language//text()">
                <xsl:choose>
                    <xsl:when test="//mods:languageTerm[@authority = 'rfc3066']">
                        <xsl:for-each select="//mods:languageTerm[@authority = 'rfc3066']/string()">
                            <ubl:language-iso639-2>
                                <xsl:value-of select="."/>
                            </ubl:language-iso639-2>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'deutsch / lateinisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'Deutsch / lateinisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'deutsch / lateinisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'deutsch und lateinisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'deutsch/lateinisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'lateinisch / deutsch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'lateinisch/deutsch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'lateinisch deutsch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'lateinisch und deutsch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'lateinisch ostmitteldeutsch'">
                        <ubl:language-iso639-2>
                            <xsl:text>gmh</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'lateinisch / ostmitteldeutsch / deutsch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>gmh</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'lateinisch hebräisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>heb</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'lateinisch und deutsch ostmitteldeutsch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>gmh</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'lateinisch / ostmitteldeutsch / deutsch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                        <ubl:language-iso639-2>
                            <xsl:text>gmh</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'lateinisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'Lateinisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>lat</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'griechisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>gre</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'deutsch'">
                        <ubl:language-iso639-2>
                            <xsl:text>deu</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'hebräisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>heb</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'ostfränkisch'">
                        <ubl:language-iso639-3>
                            <xsl:text>vmf</xsl:text>
                        </ubl:language-iso639-3>
                    </xsl:when>
                    <xsl:when test="//mods:language//text() = 'mittelniederländisch'">
                        <ubl:language-iso639-2>
                            <xsl:text>dum</xsl:text>
                        </ubl:language-iso639-2>
                    </xsl:when>
                </xsl:choose>
            </xsl:if>
            <ubl:structures>
                <xsl:for-each select="//*[local-name() = 'structMap'][@TYPE = 'LOGICAL']//*[local-name() = 'div']">
                    <structure>
                        <ubl:structId>
                            <xsl:value-of select="./@ID"/>
                        </ubl:structId>
                        <ubl:structLabel>
                            <xsl:value-of select="./@LABEL"/>
                        </ubl:structLabel>
                        <ubl:structType>
                            <xsl:value-of select="./@TYPE"/>
                        </ubl:structType>
                    </structure>
                </xsl:for-each>
            </ubl:structures>
        </ubl:mets-mods>
    </xsl:template>
</xsl:stylesheet>

