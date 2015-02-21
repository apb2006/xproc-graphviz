<?xml version="1.0"?>
<!-- tidy up graphviz svg o/p -->
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/2000/svg"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:param name="filter">
		MyFilter
	</xsl:param>
	<xsl:param name="autosize" select="1" />
	<xsl:param name="title" select="concat('xslt title: ',current-dateTime())" />
	<!-- centimeters -->
	<xsl:param name="width-mm" select="100" />
	<xsl:output method="xml" encoding="UTF-8" indent="yes"
		omit-xml-declaration="yes" />

	<xsl:template match="/svg:svg">
		<!-- add viewbox convert size to mm or 100% -->
		<xsl:variable name="w" select="substring-before(@width,'pt')" />
		<xsl:variable name="h" select="substring-before(@height,'pt')" />
		<xsl:variable name="convert_pt2mm" select="25.4 div 72" />
		<xsl:choose>
			<xsl:when test="1=$autosize">

				<svg width="100%" height="100%" preserveAspectRatio="xMidYMid meet"
					viewBox="0 0 {$w} {$h}" text-rendering="optimizeLegibility">
					<defs>
						<xsl:copy-of
							select="document('filters.svg')/svg:defs/svg:filter[@id=$filter]" />
					</defs>
					<xsl:apply-templates select="*" />
				</svg>
			</xsl:when>
			<xsl:when test="2=$autosize">
				<xsl:variable name="y-scale" select="$h div $w " />
				<xsl:variable name="width" select="$width-mm" />
				<xsl:variable name="height" select="$width * $y-scale" />
				<svg width="{$width}mx" height="{$height}mm"
					preserveAspectRatio="xMidYMid meet" viewBox="0 0 {$w} {$h}"
					text-rendering="optimizeLegibility">
					<defs>
						<xsl:copy-of
							select="document('filters.svg')/svg:defs/svg:filter[@id=$filter]" />
					</defs>
					<xsl:apply-templates select="*" />
				</svg>
			</xsl:when>
			<xsl:otherwise>
				<svg width="{$w}px" height="{$h}px" viewBox="0 0 {$w} {$h}"
					preserveAspectRatio="xMidYMid meet" text-rendering="optimizeLegibility">
					<defs>
						<xsl:copy-of
							select="document('filters.svg')/svg:defs/svg:filter[@id=$filter]" />
					</defs>
					<xsl:apply-templates select="*" />
				</svg>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="copy-content">
		<xsl:apply-templates select="@*|processing-instruction()|*|text()" />
	</xsl:template>
	<!--default behaviours for all nodes -->
	<xsl:template match="processing-instruction()|*|@*|text()">
		<xsl:copy>
			<xsl:call-template name="copy-content" />
		</xsl:copy>
	</xsl:template>
	<!-- apply non text in nodes -->
	<xsl:template match="svg:g[@class='node']">
		<g>
			<g filter="url(#{$filter})">
				<xsl:apply-templates select="*[local-name()!='text']" />
			</g>
			<g>
				<xsl:apply-templates select="svg:text" />
			</g>
		</g>
	</xsl:template>

	<xsl:template match="/svg:svg/svg:g/svg:title/text()">
		<xsl:value-of select="$title" />
	</xsl:template>
</xsl:stylesheet>
