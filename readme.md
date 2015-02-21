# xproc graphviz
An XProc library to run `Graphviz` tools to generate svg.
 
xmlns:dot="https://github.com/apb2006/xproc-graphviz"
## load from github
````
<p:import href="https://rawgit.com/apb2006/xproc-graphviz/master/graphviz.xpl" />
````
## steps
* dot:dotsvg 
 Input is dotML, o/p is svg.
* dot:dot-to-svg
Run graphviz exe to get svg from dot
* dot:dotML-to-dot

## Dependancies
### Requires
A local install of graphviz on the path
### Embeds
DotML http://www.martin-loetzsch.de/DOTML

## License
Copyright 2015 Andy Bunce. Licensed under the Apache License, Version 2.0
