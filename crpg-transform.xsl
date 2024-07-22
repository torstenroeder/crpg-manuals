<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema">

	<xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:template match="/">
		<xsl:result-document href="crpg-manuals.html">
			<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;&#xa;</xsl:text>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="html/body/div[@class='manuals']" xpath-default-namespace="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="tei">
		<xsl:variable name="data" select="document('crpg-data.xml')"/>
		<div class="manuals">
			<xsl:for-each select="$data//text/body"
				xpath-default-namespace="http://www.tei-c.org/ns/1.0">
				<xsl:for-each select="div">
					<div>
						<xsl:choose>
							<xsl:when test="position() = 1">
								<span class="title">
									<xsl:value-of select="../head[1]"/>
									<xsl:text> (</xsl:text>
									<xsl:value-of select="bibl/date[1]"/>
									<xsl:text>)</xsl:text>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<span class="title">
									<xsl:text>└ </xsl:text>
									<xsl:value-of select="bibl/title[1]"/>
								</span>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:for-each select="pb">
							<span>
								<xsl:attribute name="class" select="replace(@ana, '#', '')"/>
								<xsl:attribute name="title"
									select="concat('page ', @n, ', ', replace(@ana, '#', ''))"/>
								<xsl:text>&#160;</xsl:text>
							</span>
						</xsl:for-each>
					</div>
				</xsl:for-each>
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
