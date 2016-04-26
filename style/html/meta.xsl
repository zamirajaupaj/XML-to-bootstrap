<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     HTML meta elements
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     HTML5 doctype
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for the doctype -->
  <xsl:template name="html.doctype">

    <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>]]></xsl:text>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     HTML head elements
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for document head -->
  <xsl:template name="html.head">
    <xsl:param name="page.title" /><!-- string -->

    <!-- options -->
    <xsl:variable name="site.title" select="/site/options/option[@name = 'site.title']" />

    <!-- document head -->
    <head>
      <title>
        <xsl:value-of select="$page.title" />
        <xsl:text> </xsl:text>&#183;<xsl:text> </xsl:text>
        <xsl:value-of select="$site.title" />
      </title>

      <!-- generate meta elements -->
      <xsl:call-template name="html.head.meta" />

      <!-- generate stylesheet links -->
      <xsl:call-template name="html.head.link" />

    </head>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     HTML meta elements
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for meta elements in document head -->
  <xsl:template name="html.head.meta">

    <!-- options -->
    <xsl:variable name="site.author" select="/site/options/option[@name = 'site.author']" />

    <!-- meta elements -->
    <meta charset="utf-8" />
    <meta name="author" content="{$site.author}" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     HTML stylesheets
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for stylesheet links in document
       head -->
  <xsl:template name="html.head.link">

    <!-- stylesheets from options (CDN) -->
    <xsl:for-each select="/site/options/option[@name = 'cdn.stylesheets']/link">

      <link rel="stylesheet">
        <xsl:attribute name="href">

          <!-- prepend base URL if necessary -->
          <xsl:if test="not(starts-with(@href, '//'))">
            <xsl:value-of select="$site.url" />
          </xsl:if>

          <xsl:value-of select="@href" />

        </xsl:attribute>
      </link>

    </xsl:for-each>

    <!-- custom stylesheet -->
    <link rel="stylesheet" href="{$site.url}css/style.css" />

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     HTML scripts
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for scripts - imported at end of
       document -->
  <xsl:template name="html.script">

    <!-- scripts from options (CDN) -->
    <xsl:for-each select="/site/options/option[@name = 'cdn.scripts']/script">

      <xsl:choose>
        <xsl:when test="@src">

          <!-- import external script -->
          <script>
            <xsl:attribute name="src">

              <!-- prepend base URL if necessary -->
              <xsl:if test="not(starts-with(@src, '//'))">
                <xsl:value-of select="$site.url" />
              </xsl:if>

              <xsl:value-of select="@src" />

            </xsl:attribute>

            <!-- prevent script tag from collapsing -->
            <xsl:text> </xsl:text>

          </script>

        </xsl:when>
        <xsl:otherwise>

          <!-- copy local script -->
          <script>

            <!-- add base URL to script -->
            <xsl:call-template name="string.replace">
              <xsl:with-param name="string" select="node()" />
              <xsl:with-param name="search">SITE.URL</xsl:with-param>
              <xsl:with-param name="replace" select="$site.url" />
            </xsl:call-template>

          </script>

        </xsl:otherwise>
      </xsl:choose>

    </xsl:for-each>

    <!-- custom script -->
    <script src="{$site.url}js/script.js">

      <!-- prevent script tag from collapsing -->
      <xsl:text> </xsl:text>

    </script>

  </xsl:template>

</xsl:stylesheet>
