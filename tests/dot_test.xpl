<?xml version="1.0"?>
<p:declare-step name="pipeline" xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
  xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:svg="http://www.w3.org/2000/svg">
  <p:documentation>Convert inline graphviz dot to svg.</p:documentation>
  <p:input port="source">
    <p:inline>
      <dot>
        digraph g {
        compound="true";bgcolor="";fontcolor="";fontname="";fontsize="";label="";margin="";nodesep="";rankdir="";ranksep="";ratio="";size="";
        node[shape="record",label="&lt;10&gt; left | &lt;11&gt; middle |
        &lt;12&gt;
        right",color="",fillcolor="",fontcolor="",fontname="",fontsize="",height="",style="",URL="",width="",]{struct0};
        node[shape="record",label="&lt;20&gt; one | &lt;21&gt;
        two",color="",fillcolor="",fontcolor="",fontname="",fontsize="",height="",style="",URL="",width="",]{struct1};
        node[shape="record",label="&lt;30&gt; hello world | {&lt;311&gt;
        b | {&lt;3120&gt; c | &lt;3121&gt; d | &lt;3122&gt; e} |
        &lt;313&gt; f} | &lt;32&gt; g | &lt;33&gt;
        h",color="",fillcolor="",fontcolor="",fontname="",fontsize="",height="",style="",URL="",width="",]{struct2};
        edge[arrowhead="",arrowsize="",arrowtail="",constraint="",color="",decorate="",dir="",fontcolor="",fontname="",fontsize="",headlabel="",headport="",label="",labeldistance="",labelfloat="",labelfontcolor="",labelfontname="",labelfontsize="",minlen="",samehead="",sametail="",style="",taillabel="",tailport="",URL="",lhead="",ltail=""]
        struct0:11 -&gt; struct1:20;
        edge[arrowhead="",arrowsize="",arrowtail="",constraint="",color="",decorate="",dir="",fontcolor="",fontname="",fontsize="",headlabel="",headport="",label="",labeldistance="",labelfloat="",labelfontcolor="",labelfontname="",labelfontsize="",minlen="",samehead="",sametail="",style="",taillabel="",tailport="",URL="",lhead="",ltail=""]
        struct0:12 -&gt; struct2:3121;}
</dot>
    </p:inline>

  </p:input>
  <!-- 
	<p:output port="result"/>

	 -->
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
  <p:store name="store" href="out/dot_test.svg" indent="true" />
</p:declare-step>
