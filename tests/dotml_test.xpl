<?xml version="1.0"?>
<p:declare-step name="pipeline"  version="1.0"
    xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:c="http://www.w3.org/ns/xproc-step" 
	xmlns:svg="http://www.w3.org/2000/svg">
	<p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl" />
	  <p:documentation>Convert dotML to svg.</p:documentation>
	<p:input port="source">
		<p:document href="sample_dotml.xml" />
	</p:input>
	
	<p:output port="result">
		<p:pipe step="store" port="result" />
	</p:output>
 <p:log
	port="result"               
	href="log.txt"/>
	<p:xslt>
		<p:input port="stylesheet">
			<p:document href="../etc/dotml2dot.xsl" />
		</p:input>
		<p:input port="parameters">
			<p:empty />
		</p:input>
	</p:xslt>
  
	<p:exec command="dot" args="-Tsvg" result-is-xml="true"
		source-is-xml="false" />

	<p:filter select="//svg:svg" />

	<p:xslt>
		<p:input port="stylesheet">
			<p:document href="../etc/vizgraph.xsl" />
		</p:input>
		<p:input port="parameters">
			<p:empty />
		</p:input>
	</p:xslt>
	 
	<p:store name="store" href="out/dotml.svg" indent="true" />

</p:declare-step>
