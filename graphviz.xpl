<p:library version="1.0" xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:dot="https://github.com/apb2006/xproc-graphviz">
	<p:documentation>Interface to Graphviz
	Copyright 2015 Andy Bunce

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
	
	Requires dot on path
   tested with dot - graphviz version 2.25.20091030.0445 (20091030.0445)
	</p:documentation>
	
	<p:declare-step type="dot:dotsvg" name="dotml-dotsvg">
		<p:option name="style" required="false" select="'dot'" />
		<p:input port="source" primary="true" sequence="true" />
		<p:input port="opts" kind="parameter" >
			<p:inline>
				<c:param-set>
					<c:param name="filter" value="MyShadow" />
					<c:param name="autosize" value="0" />
				</c:param-set>
			</p:inline>
		</p:input>
		<p:output port="result" />
		<p:documentation>Input is dotML, o/p is svg.
		</p:documentation>

		<dot:dotML-to-dot />
		<dot:dot-to-svg>
			<p:with-option name="style" select="$style" />
		</dot:dot-to-svg>
		<p:xslt name="jazz">
			<p:input port="stylesheet">
				<p:document href="etc/vizgraph.xsl" />
			</p:input>
			<p:input port="parameters">
				<p:pipe port="opts" step="dotml-dotsvg"/>
			</p:input>
		</p:xslt>
	</p:declare-step>

	<p:declare-step type="dot:dot-to-svg" name="makesvg">
		<p:option name="style" required="false" select="'dot'" />
		<p:input port="source" primary="true" sequence="true" />
		<p:output port="result" />
		<p:documentation>Run graphviz exe to get svg from dot.
			</p:documentation>
		<p:exec args="-Tsvg" result-is-xml="false" source-is-xml="false"
			wrap-result-lines="true">
			<p:with-option name="command" select="$style" />
		</p:exec>
		<!-- hack to remove dtd -->
		<p:delete match="//c:line[position()&lt;7]" />
		<p:unescape-markup />
		<p:unwrap match="c:result" />
		<p:filter select="//svg:svg" />
	</p:declare-step>

	<p:declare-step type="dot:dotML-to-dot" name="makeDot">

		<p:input port="source" primary="true" sequence="true" />

		<p:output port="result" />
		<p:documentation>Input is dotML, o/p is dot. </p:documentation>
		<p:xslt>
			<p:input port="stylesheet">
				<p:document href="etc/dotML-to-dot.xsl" />
			</p:input>
			<p:input port="parameters">
				<p:empty />
			</p:input>
		</p:xslt>

	</p:declare-step>
</p:library>