-- By Hua(xu.sun RD63)
-- "2012/10/24"
try
(
	destroyDialog rol_xNormal;
)
catch()

include "xNormal/Globals.ms"
 
include "xNormal/lib/FunctionsLib.ms"
 
include "xNormal/lib/Pairs.ms"

include "xNormal/lib/File.ms"

include "xNormal/lib/TriItemCollection.ms"
include "xNormal/lib/LowPolyRepresentation.ms"
include "xNormal/lib/HighPolyRepresentation.ms"

include "xNormal/lib/AO_Reflector.ms"

include "xNormal/lib/TestBake.ms"

include "xNormal/lib/BatchRender.ms"

include "xNormal/lib/UILib.ms"


	fnInitGlobalDependencies();
	createdialog rol_xNormal menu:RCTitleList width:300 height:750;


