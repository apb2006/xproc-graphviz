<?xml version="1.0"?>
<p:declare-step name="pipeline" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:svg="http://www.w3.org/2000/svg"
  version="1.0">
  <p:documentation>Convert inline graphviz dot to svg.
  note requires internet connection to get svg DTD
  </p:documentation>
  <p:input port="source">
    <p:inline>
      <dot>digraph G { a -&gt; b}</dot>
    </p:inline>
  </p:input>
  <!-- 
	<p:output port="result"/>

	 -->
  <p:exec name="rundot" command="dot" args="-Tsvg" result-is-xml="true"
    source-is-xml="false">
    <p:input port="source">
      <p:pipe step="pipeline" port="source" />
    </p:input>
  </p:exec>

  <p:filter name="select" select="//svg:svg">
    <p:input port="source">
      <p:pipe step="rundot" port="result" />
    </p:input>
  </p:filter>


  <p:xslt name="tidysvg">
    <p:input port="source">
      <p:pipe step="select" port="result" />
    </p:input>
    <p:input port="stylesheet">
      <p:document href="../etc/vizgraph.xsl" />
    </p:input>
    <p:input port="parameters">
      <p:empty />
    </p:input>
  </p:xslt>
  <p:store name="store" href="out/dot_test2.svg" indent="true">
    <p:input port="source">
      <p:pipe step="tidysvg" port="result" />
    </p:input>
  </p:store>
</p:declare-step>
