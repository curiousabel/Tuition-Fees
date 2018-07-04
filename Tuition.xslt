<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>

  <xsl:param name="user-selected-region"/>
  <xsl:param name="user-selected-field"/>
  <xsl:output method="html" indent="yes"/>
  
  <xsl:template match="/">
    <html>
      <style>
        body
        {
        background-color:grey;
        }
        h1
        {
        font-family:"Consolas";
        color:lightblue;
        font-size:24px;
        }
        td,th
        {
        font-family:"Consolas";
        font-size:18px;
        text-align:left
        }

      </style>
      <body>

        <h1>
         Undergraduate Tuition Fees, Canadian Students 
         </h1>
        <xsl:if test="//series/@region-code = $user-selected-region" > 
        <h2>

          By Field-of-Study in  <xsl:value-of select="//region[@code = $user-selected-region]/@description"/>  
        </h2>

        <table>
          <!-- Add column headings -->
          <tr>
            <th>Region </th>
            <th>Tuition,2016 ($) </th>
            <th>Tuition,2017 ($) </th>
          </tr>

          <!-- Populate the table with a row -->
    
                <xsl:for-each select="//series[@region-code = $user-selected-region]">
        <xsl:variable name="field-code" select="@field-code"/>
      <tr>
      <td >
        <xsl:value-of select="//field[@code=$field-code]/@description"/>
      </td>
      <td>
        <xsl:value-of select="./tuition[@year=2016]"/>
      </td>
      <td>
        <xsl:value-of select="./tuition[@year=2017]"/>
      </td>
    </tr>
  </xsl:for-each>
          
        </table>
        </xsl:if>


        <xsl:if test="//series/@field-code = $user-selected-field" >
          <h2>

            For  <xsl:value-of select="//field[@code = $user-selected-field]/@description"/>  By  Geographic Area
          </h2>

          <table>
            <!-- Add column headings -->
            <tr>
              <th>
                Field Of Study<!--<xsl:value-of select="//region"/>-->
              </th>
              <th>Tuition,2016 ($) </th>
              <th>Tuition,2017 ($) </th>
            </tr>
      
        

            <!-- Populate the table with a row for each field -->
            <xsl:apply-templates select="//series[@field-code = $user-selected-field]">
              <xsl:sort select="./tuition[@year=2017] " order="descending" data-type="number"/>
            </xsl:apply-templates>
          </table>
        </xsl:if>
       
      </body>
    </html>
  </xsl:template>


<!-- this is for the region table list -->

  <!--<xsl:template match="//series[@region-code ]" >
    <xsl:value-of select="//series[@region-code = $user-selected-region]"/>
         <xsl:variable name="field-code" select="@field-code"/>
    <tr>  
       <td> <xsl:value-of select="//field[@code = 5]/@description"/> </td>
      <td> <xsl:value-of select="./tuition[@year=2016]"/> </td>        
      <td> <xsl:value-of select="./tuition[@year=2017]"/> </td>    
    </tr>
  </xsl:template>-->

  <!-- this is for the region table list -->

  <!--<xsl: match="//series[@region-code]">
    <xsl:variable name="field-code" select="@field-code"/>
    <tr>
      <td>
        <xsl:value-of select="//field[@code=$field-code]/@description"/>
      </td>
      <td>
        <xsl:value-of select="./tuition[@year=2016]"/>
      </td>
      <td>
        <xsl:value-of select="./tuition[@year=2017]"/>
      </td>
    </tr>
  </xsl:template>-->
        

  <!-- this is for the Fields  table list -->

  <xsl:template match="//series[@field-code]">
    <xsl:variable name="region-code" select="@region-code"/>
    <!--Add rows -->
    <tr>
      <td>
        <xsl:value-of select="//region[@code=$region-code]/@description"/>
      </td>
      <td>
        <xsl:value-of select="./tuition[@year=2016]"/>
      </td>
      <td>
        <xsl:value-of select="./tuition[@year=2017]"/>
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
