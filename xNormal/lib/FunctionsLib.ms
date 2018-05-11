-- By Hua(xu.sun RD63)
-- "2012/10/24"

-----------------------------------------------------Dll setup----------------------------------------------------------
function fnRestartThisScript = 
(
	name = Winking_xNormal_gMyPath + "..\\Init_xNormal.ms";
	fileIn name;
)

function fnCopyPlugin pFileNameStr =
(
	copyFile (Winking_xNormal_gDllPluginPath + pFileNameStr) (Winking_xNormal_gMaxPluginPath + pFileNameStr)
)

function fnIsPluginExist pFileNameStr =
(
	exist = false;
	files = getFiles (Winking_xNormal_gMaxPluginPath + "*" + Winking_xNormal_gDllPluginNameExtension);
	for name in files do
	(
		if pFileNameStr == (filenameFromPath name) then
			exist = true;
	)
	
	return exist;
)

function fnMakePlatformString =
(
	local platformStr;
	if is64bitApplication() then
		platformStr = "x64";
	else
		platformStr = "x86";
	
	return platformStr;
)

function fnMakeWildCardString = 
(
	local platformStr = fnMakePlatformString();
	"*" + platformStr + Winking_xNormal_gDllPluginNameExtension;
)

function fnMakeupMaxString pMaxVersionStr =
(
	local platformStr = fnMakePlatformString();
	Winking_xNormal_gDllPluginNamePrefix + pMaxVersionStr + platformStr + Winking_xNormal_gDllPluginNameExtension;
)

function fnMakePluginDllName =
(
	local ver;
	ver = MaxVersion();
	filestr = case ver[1] of
		(
			12000: fnMakeupMaxString "2010";
			13000: fnMakeupMaxString "2011";
		)
	filestr
)

function fnDllSetupImp =
(
	--do not works well
	local filestr, wildcardstr;
	
	filestr = fnMakePluginDllName();
	wildcardstr = fnMakeWildCardString();
	loadDllsFromDir Winking_xNormal_gDllPluginPath wildcardstr;
	scanForNewPlugins;
)

function fnHasDLL =
(
	local filename = fnMakePluginDllName();
	fnIsPluginExist filename;
)

function fnCopyDLL =
(
	local filename = fnMakePluginDllName();
	copyFile (Winking_xNormal_gDllPluginPath + filename) (Winking_xNormal_gMaxPluginPath + filename);
)

function fnDllSetup =
(
	try
	(
		SBM.Export_UVs = true;
	)
	catch
	(
		fnDllSetupImp();
	)
)
-----------------------------------------------------global initialize----------------------------------------------------------
function fnReadConfigFile = 
(
	local last_xNormalPath,last_xNormalSettingFile,LastLowPolyPath,LastHighPolyPath,LastEdgePadding,LastUseSceneHighPoly;
	
	last_xNormalPath = getINISetting Winking_xNormal_gConfigFile "xNormalPath" "Path";
	if last_xNormalPath != "#" do Winking_xNormal_g_xNormalPath = last_xNormalPath;
	

	--print last_xNormalPath;
	--print Winking_xNormal_g_xNormalPath;
	
	last_xNormalSettingFile = getINISetting Winking_xNormal_gConfigFile "LastSettingFile" "Name";
	if last_xNormalSettingFile != "#" do	Winking_xNormal_gLastSettingFileName = last_xNormalSettingFile;
	
	last_xNormalIntermediatePolyPath = getINISetting Winking_xNormal_gConfigFile "IntermediatePoly" "Path";
	if last_xNormalIntermediatePolyPath != "#" do Winking_xNormal_gLastIntermediatePolyDirPath = last_xNormalIntermediatePolyPath;
	
	last_xNormalHighPolyPath = getINISetting Winking_xNormal_gConfigFile "HighPoly" "Path";
	if last_xNormalHighPolyPath != "#" do Winking_xNormal_gLastHighPolyDirPath = last_xNormalHighPolyPath;
	
	last_xNormalHighPolyPath = getINISetting Winking_xNormal_gConfigFile "UseSceneHighPoly" "Enabled";
	if last_xNormalHighPolyPath != "#" do Winking_xNormal_gLastUseSceneHighPoly = last_xNormalHighPolyPath;
		
	--LastLowPolyPath = getINISetting Winking_xNormal_gConfigFile "LowPoly" "Path";
	--if LastLowPolyPath != "#" do	Winking_xNormal_gLastLowPolyPath = LastLowPolyPath;
		
	--LastHighPolyPath = getINISetting Winking_xNormal_gConfigFile "HighPoly" "Path";
	--if LastHighPolyPath != "#" do	Winking_xNormal_gLastHighPolyDirPath = LastHighPolyPath;
		
	--LastEdgePadding = getINISetting Winking_xNormal_gConfigFile "Texture" "EdgePadding";
	--if LastEdgePadding !="#" do Winking_xNormal_gLastEdgePadding = LastEdgePadding;
)

function fnReadSettingFileNames = 
(
	Local myFile;
	SettingFilePath = Winking_xNormal_gSettingFilePath + "*.xml";
	Winking_xNormal_gSettingFilePaths = getFiles SettingFilePath;
	
	Winking_xNormal_gSettingFiles = #();
	for f in Winking_xNormal_gSettingFilePaths do 
	(
		myFile = filenameFromPath  f;
		append Winking_xNormal_gSettingFiles myFile;
	)

)

function fnSet2LastSelection = 
(
	for i=1 to Winking_xNormal_gSettingFilePaths.count do
	(
		if last_xNormalSettingFile == Winking_xNormal_gSettingFilePaths[i] then
		(
			Winking_xNormal_gLastSelection = i;
			break;
		)
	)
)

function fnInitGlobalDependencies =
(
	fnReadConfigFile();
	fnReadSettingFileNames();
	fnSet2LastSelection();
	
	Winking_xNormal_gLastHighPolyPaths = #();
	Winking_xNormal_gHighPolyObjs = #();
	Winking_xNormal_gLastLowPolyPath = "";
	Winking_xNormal_gLastEdgePadding = 2;
)

-----------------------------------------------------INI File Access----------------------------------------------------------

function fnINIFileSet_xNormalExcutablePath pExePath = 
(
	setINISetting Winking_xNormal_gConfigFile "xNormalPath" "Path" pExePath;
)

function fnINIFileSet_LastSettingFileName pName =
(
	setINISetting Winking_xNormal_gConfigFile "LastSettingFile" "Name" pName;
)

function fnINIFileSet_LastLowPolyPath pPath =
(
	setINISetting Winking_xNormal_gConfigFile "LowPoly" "Path" pPath;
)

function fnINIFileSet_LastIntermediatePolyPath pPath =
(
	setINISetting Winking_xNormal_gConfigFile "IntermediatePoly" "Path" pPath;
)

function fnINIFileSet_LastHighPolyPath pPath =
(
	setINISetting Winking_xNormal_gConfigFile "HighPoly" "Path" pPath;
)

function fnINIFileSet_LastEdgePadding pValue = 
(
	setINISetting Winking_xNormal_gConfigFile "Texture" "EdgePadding" pValue;
)

function fnINIFileSet_LastUseSceneHighPoly pEnabled =
(
	setINISetting Winking_xNormal_gConfigFile "UseSceneHighPoly" "Enabled" pEnabled;
)
-----------------------------------------------------XML Setting File Access----------------------------------------------------------

function fnInitalizeXMLDoc = 
(
	dotNet.loadAssembly "system.xml";
	Winking_xNormal_gXMLDocObject = dotNetObject "system.xml.xmlDocument";
	xmlPath = Winking_xNormal_gSettingFilePath + Winking_xNormal_gLastSettingFileName;
	Winking_xNormal_gXMLDocObject.load xmlPath;
	
	Winking_xNormal_gXMLDocObjectEle = Winking_xNormal_gXMLDocObject.documentElement;
)

function fnSaveXMLDoc = 
(
	Winking_xNormal_gXMLDocObject.Save (Winking_xNormal_gSettingFilePath + Winking_xNormal_gLastSettingFileName);
)
-- pLowPaths string array
-- pUseCage string
function fnSetLowPolyExportPath pLowPaths pUseCage = 
(
	--fnInitalizeXMLDoc();
	
	--docEle = Winking_xNormal_gXMLDocObject.documentElement;
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"LowPolyModel"
	MyNode.RemoveAll();
	for p in pLowPaths do
	(
		meshNode = Winking_xNormal_gXMLDocObject.CreateElement "Mesh";
		meshNode.SetAttribute "Visible" "true";
		meshNode.SetAttribute "File" p.K3.FullFileName;
		meshNode.SetAttribute "AverageNormals" "UseExportedNormals";
		meshNode.SetAttribute "MaxRayDistanceFront" "0.500000"
		meshNode.SetAttribute "MaxRayDistanceBack" "0.500000"
		meshNode.SetAttribute "UseCage" (pUseCage as string)
		meshNode.SetAttribute "NormapMapType" "Tangent-space" 
		meshNode.SetAttribute "UsePerVertexColors" "true" 
		meshNode.SetAttribute "UseFresnel" "false" 
		meshNode.SetAttribute "FresnelRefractiveIndex" "1.330000" 
		meshNode.SetAttribute "ReflectHDRMult" "1.000000" 
		meshNode.SetAttribute "VectorDisplacementTS" "false" 
		meshNode.SetAttribute "VDMSwizzleX" "X+" 
		meshNode.SetAttribute "VDMSwizzleY" "Y+" 
		meshNode.SetAttribute "VDMSwizzleZ" "Z+" 
		meshNode.SetAttribute "BatchProtect" "false" 
		meshNode.SetAttribute "CastShadows" "true" 
		meshNode.SetAttribute "ReceiveShadows" "true" 
		meshNode.SetAttribute "BackfaceCull" "true" 
		meshNode.SetAttribute "NMSwizzleX" "X+" 
		meshNode.SetAttribute "NMSwizzleY" "Y+" 
		meshNode.SetAttribute "NMSwizzleZ" "Z+" 
		meshNode.SetAttribute "HighpolyNormalsOverrideTangentSpace" "true" 
		meshNode.SetAttribute "TransparencyMode" "None" 
		meshNode.SetAttribute "AlphaTestValue" "127" 
		meshNode.SetAttribute "Matte" "false" 
		meshNode.SetAttribute "Scale" "1.000000" 
		meshNode.SetAttribute "MatchUVs" "false" 
		meshNode.SetAttribute "UOffset" "false" 
		meshNode.SetAttribute "VOffset" "false"
		MyNode.AppendChild meshNode;
	)
	
	--fnSaveXMLDoc();
)

function fnSetHighPolyExportPath pArrayHighPath = 
(
	--fnInitalizeXMLDoc();
	
	--docEle = Winking_xNormal_gXMLDocObject.documentElement;
	
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"HighPolyModel";
	MyNode.RemoveAll();
	for p in pArrayHighPath do
	(
		meshNode = Winking_xNormal_gXMLDocObject.CreateElement "Mesh";
		meshNode.SetAttribute "Visible" "true";
		meshNode.SetAttribute "Scale" "1.000000";
		meshNode.SetAttribute "IgnorePerVertexColor" "true";
		meshNode.SetAttribute "AverageNormals" "UseExportedNormals";
		meshNode.SetAttribute "BaseTexIsTSNM" "false";
		meshNode.SetAttribute "File" p;
		MyNode.AppendChild meshNode;
	)
	
	--fnSaveXMLDoc();
)

function fnSetOutputFilePath pOutPath = 
(
	--fnInitalizeXMLDoc();
	
	--docEle = Winking_xNormal_gXMLDocObject.documentElement;
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps"
	MyNode.SetAttribute "File" pOutPath;
	
	--fnSaveXMLDoc();
)

function fnSetOutputFileTexWidth pWidth = 
(
	--fnInitalizeXMLDoc();
	
	--docEle = Winking_xNormal_gXMLDocObject.documentElement;
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps"
	MyNode.SetAttribute "Width" pWidth;
	
	--fnSaveXMLDoc();
)

function fnSetOutputFileTexHight pHeight = 
(
	--fnInitalizeXMLDoc();
	
	--docEle = Winking_xNormal_gXMLDocObject.documentElement;
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps"
	MyNode.SetAttribute "Height" pHeight;
	
	--fnSaveXMLDoc();
)

function fnSetOutputFileEdgePadding pPadding = 
(
	--fnInitalizeXMLDoc();
	
	--docEle = Winking_xNormal_gXMLDocObject.documentElement;
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps"
	MyNode.SetAttribute "EdgePadding" pPadding;
	
	--fnSaveXMLDoc();
)

function fnSetAntialising pAmount = 
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps"
	MyNode.SetAttribute "AA" pAmount;
)

--pType 0 for Max 1 for Maya
function fnSetOutputFileTangentSpaceType pType = 
(
	--fnInitalizeXMLDoc();
	
	--docEle = Winking_xNormal_gXMLDocObject.documentElement;
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps"
	if pType == 0 then
	(
		MyNode.SetAttribute "SwizzleY" "Y-";
	)
	else
	(
		MyNode.SetAttribute "SwizzleY" "Y+";
	)
	
	--fnSaveXMLDoc();
)

function fnSetNormalBG pR pG pB = 
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps/NMBackgroundColor";
	MyNode.SetAttribute "R" pR;
	MyNode.SetAttribute "G" pG;
	MyNode.SetAttribute "B" pB;
)

function fnSetGenAO pState = 
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenAO" pState;
)

function fnSetGenNormal pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenNormals" pState;
)

function fnSetGenBaseTex pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "BakeHighpolyBaseTex" pState;
)

function fnSetGenHeights pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenHeights" pState;
)

function fnSetGenBent pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenBent" pState;
)

function fnSetGenPRT pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenPRT" pState;
)

function fnSetGenConvexity pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenConvexity" pState;
)

function fnSetGenThickness pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenThickness" pState;
)

function fnSetGenProximity pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenProximity" pState;
)

function fnSetGenCavity pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenCavity" pState;
)

function fnSetGenWireRays pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenWireRays" pState;
)

function fnSetGenDirections pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenDirections" pState;
)

function fnSetGenRadiosityNormals pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenRadiosityNormals" pState;
)

function fnSetBakeHighpolyVCols pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "BakeHighpolyVCols" pState;
)

function fnSetGenCurv pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenCurv" pState;
)

function fnSetGenTranslu pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenTranslu" pState;
)

function fnSetGenDerivNM pState =
(
	MyNode = Winking_xNormal_gXMLDocObjectEle.SelectSingleNode @"GenerateMaps";
	MyNode.SetAttribute "GenDerivNM" pState;
)
-----------------------------------------------------SBM Exporter--------------------------------------------------

function EndxNmormalDialog =
(
	try
	(
		if Winking_xNormal_gxNormalDiaologHandler != undefined then
		(
			UIAccessor.CloseDialog Winking_xNormal_gxNormalDiaologHandler;
			Winking_xNormal_gxNormalDiaologHandler = undefined;
		)
	)
	catch();
	true
)

function GetHighPolyExpectedTime =
(
	time = 5000;
	node = selection[1];
	if node.mesh.numFaces < 5000 then
		time = 500;
	else
		time = node.mesh.numFaces / 16;

	return time;
)

function GetLowPolyExpectedTime =
(
	time = 5000;
	node = selection[1];
	if node.mesh.numFaces < 5000 then
		time = 500;
	else
		time = node.mesh.numFaces / 10;
	return time;
)

function fnAutoHighPolySBM_ExporterUI flag:on =
(
	if flag then
	(
		DialogMonitorOPS.UnRegisterNotification id:#autoSBMPress;
		function fnAutoPressForSBM_Exporter =
		(
			WindowHandle = DialogMonitorOPS.GetWindowHandle()
			if UIAccessor.GetWindowText WindowHandle == "xNormal SBM Exporter" do
			(
				local HighMeshbutton,exportbutton,closebutton
				dialogControllersHandles = UIAccessor.GetChildWindows WindowHandle;
				myTimer = dotNetObject "System.Timers.Timer";
				myTimer.Interval = GetHighPolyExpectedTime();
				myTimer.AutoReset = false;
				dotNet.addEventHandler myTimer "Elapsed" EndxNmormalDialog;
				Winking_xNormal_gxNormalDiaologHandler = WindowHandle;
				for hand in dialogControllersHandles do
				(
					text = UIAccessor.GetWindowText hand;
					
					if text == "High definition mesh" then
						HighMeshbutton = hand;
					if text == "&Export" then
						exportbutton = hand;
					if text == "&Close" then
						closebutton = hand;
				)
				
				
				if HighMeshbutton != undefined then
				(
					UIAccessor.SendMessage HighMeshbutton 0x0201 0x00000001 0x0009004C;
					UIAccessor.SendMessage HighMeshbutton 0x0202 0x00000000 0x0009004C;
				)
				
				
				if exportbutton != undefined then
				(
					UIAccessor.SendMessage exportbutton 0x0201 0x00000001 0x0012000E;
					UIAccessor.SendMessage exportbutton 0x0202 0x00000000 0x0012000E;
					myTimer.Enabled = true;
				)
			)
			true
		)
		DialogMonitorOPS.RegisterNotification fnAutoPressForSBM_Exporter id:#autoSBMPress;
		DialogMonitorOPS.Enabled = true;
	)
	else(
		DialogMonitorOPS.UnRegisterNotification id:#autoSBMPress;
		DialogMonitorOPS.Enabled = false;
	)
)

function fnAutoLowPolySBM_ExporterUI flag:on =
(
	if flag then
	(
		DialogMonitorOPS.UnRegisterNotification id:#autoSBMPress;
		function fnAutoPressForSBM_Exporter =
		(
			WindowHandle = DialogMonitorOPS.GetWindowHandle()
			if UIAccessor.GetWindowText WindowHandle == "xNormal SBM Exporter" do
			(
				local lowMeshbutton,exportbutton,closebutton;
				dialogControllersHandles = UIAccessor.GetChildWindows WindowHandle;
				myTimer = dotNetObject "System.Timers.Timer";
				myTimer.Interval = GetLowPolyExpectedTime();
				myTimer.AutoReset = false;
				dotNet.addEventHandler myTimer "Elapsed" EndxNmormalDialog;
				Winking_xNormal_gxNormalDiaologHandler = WindowHandle;
				for hand in dialogControllersHandles do
				(
					text = UIAccessor.GetWindowText hand;
					
					if text == "Low definition mesh" then
						lowMeshbutton = hand;
					if text == "&Export" then
						exportbutton = hand;
					if text == "&Close" then
						closebutton = hand;
				)
				if lowMeshbutton != undefined then
				(
					UIAccessor.SendMessage lowMeshbutton 0x0201 0x00000001 0x0009004C;
					UIAccessor.SendMessage lowMeshbutton 0x0202 0x00000000 0x0009004C;
					--UIAccessor.SendMessage 0x000F 0 0
				)
				if exportbutton != undefined then
				(
					UIAccessor.SendMessage exportbutton 0x0201 0x00000001 0x0012000E;
					UIAccessor.SendMessage exportbutton 0x0202 0x00000000 0x0012000E;
					myTimer.Enabled = true;
				)
			)
			true
		)
		DialogMonitorOPS.RegisterNotification fnAutoPressForSBM_Exporter id:#autoSBMPress;
		DialogMonitorOPS.Enabled = true;
	)
	else(
		DialogMonitorOPS.UnRegisterNotification id:#autoSBMPress;
		DialogMonitorOPS.Enabled = false;
	)
)

function fnHighSetting =
(
	SBM.Export_UVs = false;
	SBM.Export_tangent_basis = false;
	SBM.Export_cage = false;
	SBM.Export_normals = false;
)

function fnLowSetting =
(
	SBM.Export_UVs = true;
	SBM.Export_tangent_basis = true;
	SBM.Export_cage = true;
	SBM.Export_normals = true;
)

function fnExportHigh pNode pPath =
(
	--fnHighSetting();
	--SBM.Export pNode pPath;
	fnAutoHighPolySBM_ExporterUI();
	select pNode;
	pNode.ishidden = false;
	exportFile pPath #noPrompt selectedOnly:true using:xNormalSBMExp;
	fnAutoHighPolySBM_ExporterUI flag:off;
)

function fnExportLow pNode pPath =
(
	--fnLowSetting();
	--SBM.Export pNode pPath;
	fnAutoLowPolySBM_ExporterUI();
	--sleep 20;
	select pNode;
	pNode.ishidden = false;
	exportFile pPath #noPrompt selectedOnly:true using:xNormalSBMExp;
	fnAutoLowPolySBM_ExporterUI flag:off;
	--gc light:true;
)
-----------------------------------------------------Misc----------------------------------------------------------
function fnUpdateMyself =
(
	--local pathStr = "\"" + (getdir #userscripts) + "\"";
	local pathStr = (getdir #userscripts) + "\\xNormalTag2";
	HiddenDOSCommand "Update.bat" startpath:pathStr;
)

function fnLowerCase2UpperCase pChar =
(
	return bit.intAsChar(bit.charAsInt pChar - 32);
)

function fnGetGroupName pIndex =
(
	--Local baseNo = (bit.charAsInt "A") - 1;
	--Local GroupName = bit.intAsChar (baseNo + pIndex);
	local GroupName = pIndex as string;
	return GroupName;
)

function fnGetIndexByGroupName pGroupName =
(
	--Local baseNo = (bit.charAsInt "A") - 1;
	--local thisIndex = (bit.charAsInt pGroupName) - baseNo;
	local thisIndex = pGroupName as integer;
	return thisIndex;
)

function fnIsIntegerChar pChar =
(
	return (pChar >= "0" and pChar <= "9");
)

function fnValidGroupName pGroupName =
(
	--return (pGroupName == "0") or (pGroupName >= "A" and pGroupName <= "Z") or (pGroupName >= "a" and pGroupName <= "z");
	local integerChar,ret = true;
	for i = 1 to pGroupName.Count do
	(
		if not(fnIsIntegerChar pGroupName[i]) then
		ret = false;
		break;
	)
	
	return ret;
)

function fnImportObj pPath =
(
	importFile pPath #noPrompt using:ObjImp;
	return selection[1];
)

function fnExportObj pNode pPath =
(
	select pNode;
	pNode.ishidden = false;
	exportFile pPath #noPrompt selectedOnly:true using:ObjExp;
)

function fnIsUseBaseMap =
(
	(getINISetting Winking_xNormal_gConfigFile "HighpolyBaseTex" "BakeHighpolyBaseTex") as BooleanClass;
)

function fnPromptMessage pStr = 
(
	pushPrompt pStr;
	--flush;
)

function fnPrint_xNormalNote pNoticeString =
(
	noticeString = Winking_xNormal_g_xNormalNotePrefix + pNoticeString + ";";
	format "% \n" noticeString;
	pushPrompt noticeString;
	--flush;
)

function fnPrint_xNormalNote_Genral pDescription pNoticeString =
(
	fnPrint_xNormalNote (pDescription + pNoticeString);
)

function fnPrint_xNormalNote_Pick pName =
(
	fnPrint_xNormalNote_Genral "拣选了物体"  pName;
)

function fnPrint_xNormalNote_Export pName pPath =
(
	fnPrint_xNormalNote_Genral "物体被导出" (pName + " = " + pPath);
)

function fnSetEditMesh pNode =
(
	addModifier pNode (Edit_Mesh()) before:pNode.modifiers.count;
)

function fnCheckIfHasEditMesh pNode =
(
	for m in pNode.modifiers do
	(
		if classof m == Edit_Mesh then
		(
			return true;
		)
	)
	
	return false;
)

function fnCheckIfHasCageAndEditMeshModifier pNode pAddEditMeshMod =
(
	for m in pNode.modifiers do
	(
		if classof m == Projection then
		(
			if pAddEditMeshMod then
			(
				if not(fnCheckIfHasEditMesh pNode) then
				(
					fnSetEditMesh pNode;
				)
			)
			return true;
		)
	)
	
	return false;
)

function fnAddProjectionModifier pBaseObj pReferredHighPoly =
(
	proMod = Projection();
	for o in pReferredHighPoly do
	(
		if proMod.isValidObject o then
		(
			proMod.addObjectNode o;
		)
	)
	addModifier pBaseObj proMod;
	proMod;
)

