<?xml version="1.0"?>
<p:declare-step name="pipeline" version="1.0"
	xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:dot="https://github.com/apb2006/xproc-graphviz" xmlns:svg="http://www.w3.org/2000/svg">
	<p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl" />
	<p:documentation>
		Test loading of library.
	</p:documentation>
	<p:import href="../graphviz.xpl" />
	<p:input port="source">
		<p:document href="sample_dotml.xml" />
	</p:input>

	<p:output port="result">
		<p:pipe step="store" port="result" />
	</p:output>
	<p:log port="result" href="log.txt" />

	<dot:dotsvg>
	<p:with-param name="title" select="concat('graphviz test: ',current-dateTime())"/>
	</dot:dotsvg>

	<p:store name="store" href="out/dotml.svg" indent="true" />

</p:declare-step>
