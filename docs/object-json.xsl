<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mets="http://www.loc.gov/METS/" xmlns:saxon="http://saxon.sf.net/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ubl="http://www.loc.gov/mods/v3" extension-element-prefixes="saxon" version="2.0">
    <xsl:output method="xml" indent="no"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="object"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="text()"/>
    <xsl:template match="mets:dmdSec[@ID = 'DMDLOG_0000']">
        <ubl:metadata>
            <ubl:fileName>
                <xsl:value-of select="$object"/>
            </ubl:fileName>
            <ubl:recordDate>
                <xsl:value-of select="//mets:metsHdr/@CREATEDATE"/>
            </ubl:recordDate>
            <ubl:title>
                <xsl:value-of select="//mets:dmdSec[@ID = 'DMDLOG_0000']//mods:mods/mods:titleInfo/*[local-name() = 'title']"/>
            </ubl:title>
            <xsl:if test="//mods:subTitle or //mods:subtitle">
                <ubl:subTitle>
                    <xsl:value-of select="//mods:subTitle"/>
                    <xsl:value-of select="//mods:subtitle"/>
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
            <xsl:for-each select="//mods:relatedItem/mods:titleInfo/mods:title">
                <ubl:collection>
                    <xsl:value-of select="."/>
                </ubl:collection>
            </xsl:for-each>
            <xsl:if test="contains(//*[local-name() = 'recordIdentifier'], 'manuscripta-mediaevalia')">
                <ubl:manuscriptaMediaevalia>
                    <xsl:value-of select="//*[local-name() = 'recordIdentifier']"/>
                </ubl:manuscriptaMediaevalia>
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
            <xsl:call-template name="structure-authors">
                <xsl:with-param name="structureId">DMDLOG_0000</xsl:with-param>
            </xsl:call-template>
            <xsl:if test="//*[local-name() = 'placeTerm']">
                <ubl:place>
                    <xsl:value-of select="//*[local-name() = 'placeTerm']"/>
                </ubl:place>
            </xsl:if>
            <xsl:if test="//*[local-name() = 'place'][@eventType = 'manufacture']">
                <ubl:localisierung>
                    <xsl:value-of select="normalize-space(//*[local-name() = 'place'][@eventType = 'manufacture'])"/>
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
                    <xsl:value-of select="normalize-space(//*[local-name() = 'extent'][@unit = 'leaves'])"/>
                </ubl:umfang>
            </xsl:if>
            <xsl:if test="//*[local-name() = 'extent'][@unit = 'cm']">
                <ubl:abmessung>
                    <xsl:value-of select="normalize-space(//*[local-name() = 'extent'][@unit = 'cm'])"/>
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
                <ubl:script-iso15924>
                    <xsl:value-of select="//mods:scriptTerm"/>
                </ubl:script-iso15924>
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
                    <xsl:when test="//mods:languageTerm">
                        <xsl:for-each select="//mods:languageTerm/string()">
                            <xsl:call-template name="resolve-languages">
                                <xsl:with-param name="language" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="//mods:language/text()">
                        <xsl:for-each select="//mods:language/text()">
                            <xsl:call-template name="resolve-languages">
                                <xsl:with-param name="language" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:when>
                </xsl:choose>
            </xsl:if>
        </ubl:metadata>
    </xsl:template>
    <xsl:template match="mets:structMap[@TYPE = 'LOGICAL']">
        <xsl:if test="count(.//mets:div[@ID]) > 1">
            <xsl:for-each select=".//*[local-name() = 'div']">
                <structures>
                    <ubl:structId>
                        <xsl:value-of select="./@ID"/>
                    </ubl:structId>
                    <ubl:structLabel>
                        <xsl:value-of select="./@LABEL"/>
                    </ubl:structLabel>
                    <ubl:structType>
                        <xsl:value-of select="./@TYPE"/>
                    </ubl:structType>
                    <xsl:call-template name="structure-authors">
                        <xsl:with-param name="structureId" select="./@DMDID"/>
                    </xsl:call-template>
                </structures>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <xsl:template name="structure-authors">
        <xsl:param name="structureId"/>
        <xsl:for-each select="//mets:dmdSec[@ID = $structureId]//mods:name">
            <xsl:if test="./mods:role/mods:roleTerm/text() = 'aut'">
                <ubl:author>
                    <ubl:label><xsl:value-of select="./mods:displayForm/text()"/></ubl:label>
                    <ubl:GND><xsl:value-of select="./@valueURI"/></ubl:GND>
                </ubl:author>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="resolve-languages">
        <xsl:param name="language"/>
        <xsl:if test="$language = 'deutsch / lateinisch'">
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'Deutsch / lateinisch'">
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'deutsch und lateinisch'">
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'deutsch/lateinisch'">
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'lateinisch / deutsch'">
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'lateinisch/deutsch'">
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'lateinisch deutsch'">
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'lateinisch und deutsch'">
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'lateinisch ostmitteldeutsch'">
            <ubl:language-iso639-2>
                <xsl:text>gmh</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'lateinisch / ostmitteldeutsch / deutsch'">
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>gmh</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'lateinisch / deutsch / mitteldeutsch'">
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>gmh</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'lateinisch und deutsch ostmitteldeutsch'">
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
            <ubl:language-iso639-2>
                <xsl:text>gmh</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'lateinisch'">
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'Lateinisch'">
            <ubl:language-iso639-2>
                <xsl:text>lat</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'griechisch'">
            <ubl:language-iso639-2>
                <xsl:text>gre</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'deutsch'">
            <ubl:language-iso639-2>
                <xsl:text>deu</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'hebräisch'">
            <ubl:language-iso639-2>
                <xsl:text>heb</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'ostfränkisch'">
            <ubl:language-iso639-3>
                <xsl:text>vmf</xsl:text>
            </ubl:language-iso639-3>
        </xsl:if>
        <xsl:if test="$language = 'mittelniederländisch'">
            <ubl:language-iso639-2>
                <xsl:text>dum</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
        <xsl:if test="$language = 'bairisch'">
            <ubl:language-iso639-2>
                <xsl:text>gem</xsl:text>
            </ubl:language-iso639-2>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>