<?xml version="1.0"?>
<!-- Stefan Karpinski [stefan.karpinski@post.harvard.edu] -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template match="/">
  <html>
    <head>
      <title><xsl:value-of select="resume/name"/></title>
      <xsl:copy-of select="document('resume.css')"/>
    </head>
    <body>
      <xsl:apply-templates/>
    </body>
  </html>
</xsl:template>

<xsl:template match="resume">
  <div class="header">
    <table align="center" width="100%">
      <tr valign="middle">
        <td width="30%" align="left">
          <xsl:apply-templates select="address[1]"/>
        </td>
        <td width="40%" align="center">
          <h1 class="name"><xsl:value-of select="name"/></h1>
          <div class="email">
            <xsl:text>[</xsl:text>
            <a><xsl:attribute name="href">
              <xsl:text>mailto:</xsl:text>
              <xsl:value-of select="name"/>
              <xsl:text> &lt;</xsl:text>
              <xsl:value-of select="email"/>
              <xsl:text>&gt;</xsl:text>
               </xsl:attribute>
              <i><xsl:value-of select="email"/></i>
            </a>
            <xsl:text>]</xsl:text>
          </div>
        </td>
        <td width="30%" align="right">
          <xsl:apply-templates select="address[2]"/>
        </td>
      </tr>
    </table>
  </div>
  <xsl:for-each select="section">
    <div class="section">
      <h2 class="section-title">
        <xsl:value-of select="@title"/>
      </h2>
      <xsl:apply-templates/>
    </div>
  </xsl:for-each>
</xsl:template>

<xsl:template match="address">
  <div class="address">
    <a style="border-bottom: none" target="_blank">
      <xsl:attribute name="href">
        <xsl:text>http://maps.google.com/maps?q=</xsl:text>
        <xsl:value-of select=".//street"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select=".//city"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select=".//state"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select=".//zip"/>
      </xsl:attribute>
      <xsl:for-each select="line">
        <xsl:apply-templates/><br/>
      </xsl:for-each>
    </a>
    <xsl:if test="@which">
      <xsl:text>[</xsl:text>
      <i><xsl:value-of select="@which"/></i>
      <xsl:text>]</xsl:text>
    </xsl:if>
  </div>
</xsl:template>

<xsl:template match="address//phone">
  <xsl:text>tel: </xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="address//country">
  <i><xsl:apply-templates/></i>
</xsl:template>

<xsl:template match="entry">
  <table width="100%">
  <tr>
    <td align="left" class="entry-name">
      <xsl:apply-templates select="name"/>
    </td>
    <td align="right" class="entry-info">
      <xsl:apply-templates select="dates"/>
      <xsl:text>; </xsl:text>
      <a target="_blank">
        <xsl:attribute name="href">
          <xsl:text>http://maps.google.com/maps?q=</xsl:text>
          <xsl:value-of select="location"/>
        </xsl:attribute>
        <i><xsl:apply-templates select="location"/></i>
      </a>
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <xsl:for-each select="paragraph">
        <p class="entry-text">
          <xsl:if test="position()=1 and ../position">
             <b class="entry-position">
               <xsl:apply-templates select="../position"/>
               <xsl:text>.</xsl:text>
             </b>
             <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:apply-templates/>
        </p>
      </xsl:for-each>
    </td>
  </tr>
  </table>
</xsl:template>

<xsl:template match="entry/name">
  <xsl:choose>
    <xsl:when test="../link">
      <a target="_blank">
        <xsl:attribute name="href">
          <xsl:value-of select="../link"/>
        </xsl:attribute>
        <xsl:apply-templates/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="entry/paragraph/position">
  <b class="entry-position"><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="paragraph">
  <p><xsl:if test="@label">
    <xsl:attribute name="class">entry</xsl:attribute>
    <b><xsl:value-of select="@label"/>
       <xsl:text>:</xsl:text></b>
     </xsl:if>
    <xsl:apply-templates/>
  </p>
</xsl:template>

<xsl:template match="project">
  <i><xsl:apply-templates select="name"/><xsl:text> Project</xsl:text></i>
  <xsl:if test="date">
    <xsl:text> [</xsl:text>
    <xsl:apply-templates select="date"/>
    <xsl:text>]</xsl:text>
  </xsl:if>
  <xsl:text>:</xsl:text>
  <xsl:apply-templates select="description"/>
</xsl:template>

<xsl:template match="italic">
  <i><xsl:apply-templates/></i>
</xsl:template>

<xsl:template match="bold">
  <b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="quote">
  <xsl:text>"</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>"</xsl:text>
</xsl:template>

<xsl:template match="link">
  <a target="_blank">
    <xsl:attribute name="href">
      <xsl:choose>
        <xsl:when test="@href">
          <xsl:value-of select="@href"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates/>
  </a>
</xsl:template>

</xsl:stylesheet>
