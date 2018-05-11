-- By Hua(xu.sun RD63)
-- "2012/10/24"

--
--
global Winking_xNormal_g_xNormalNotePrefix = " xNormal: ";

-- global declaration only for rcmenu to known it;
global rol_xNormal; 


--
--
global Winking_xNormal_gConfigFile = Winking_xNormal_gMyPath + "xNormal\\Setttings.ini";

--
--
global Winking_xNormal_gSettingFilePath = Winking_xNormal_gMyPath + "xNormal\\xNormalSettingFiles\\";

--
--
global Winking_xNormal_gTempFilePath = Winking_xNormal_gMyPath + "Temp\\";


--
--
global Winking_xNormal_gDllPluginNamePrefix = "mxs_sbm_ultilityExtension";


--
--
global Winking_xNormal_gDllPluginNameExtension = ".dlu";


--
--
global Winking_xNormal_gDllPluginPath = Winking_xNormal_gMyPath + "xNormal\\Dll\\";


--
--
global Winking_xNormal_gMaxPluginPath = (GetDir #maxroot) + "plugins\\";


--
--
global Winking_xNormal_gIconPath = Winking_xNormal_gMyPath + "xNormal\\Icons\\";

-- xNormal Setting Files FullPath
-- initialized by FunctionLib-fnReadSettingFileNames
global Winking_xNormal_gSettingFilePaths = #();

-- xNormal Setting File names
-- initialized by FunctionLib-fnReadSettingFileNames Referred by UILib-xNormal
global Winking_xNormal_gSettingFiles = #();

-- xNormal executable path
-- initialized by FunctionLib-fnReadConfigFile
global Winking_xNormal_g_xNormalPath = "";

-- xNormal Plug Last Setting : xNormal Setting File Name
-- initialized by FunctionLib-fnReadConfigFile
global Winking_xNormal_gLastSettingFileName = "";


-- xNormal Plug Last Setting : xNormal Setting File Name Index
-- initialized by FunctionLib-fnInitGlobalDependencies referred by UILib-xNormal
global Winking_xNormal_gLastSelection = 1;
--
--


global Winking_xNormal_gLastLowPolyPath = "";
--
--


global Winking_xNormal_gLastHighPolyPaths = #();
global Winking_xNormal_gHighPolyObjs = #();
--
--


global Winking_xNormal_gLastHighPolyDirPath = Winking_xNormal_gTempFilePath + "HighPolys\\";
global Winking_xNormal_gLastIntermediatePolyDirPath = Winking_xNormal_gTempFilePath + "IntermediatePolys\\";

global Winking_xNormal_gLastUseSceneHighPoly = false;
--
--


global Winking_xNormal_gXMLDocObject;
global Winking_xNormal_gXMLDocObjectEle;


--
--
global Winking_xNormal_gTextureParamStr = #("16","32","64","128","256","512","1024","2048","4096","8192");
global Winking_xNormal_gTextureParam = #(16,32,64,128,256,512,1024,2048,4096,8192);
global Winking_xNormal_gTextureParamAntialisingStr = #("1x","2x","4x");
global Winking_xNormal_gTextureParamAntialisingSettingFileStr = #("1","2","4");
global Winking_xNormal_gTextureParamEdgePaddingStr = #("1","2","4","8","16","32","3");
--
--
global Winking_xNormal_gLowPolyDirPath = Winking_xNormal_gTempFilePath + "LowPolys\\";

global Winking_xNormal_gTexturePath = Winking_xNormal_gTempFilePath + "Texture\\";

global Winking_xNormal_gDataFileNamepath = Winking_xNormal_gTempFilePath + "Data\\";

global Winking_xNormal_gInterChangeData = undefined; -- for external high poly list Data reading interChange;

global Winking_xNormal_gxNormalDiaologHandler = undefined; -- used to close the xnormal dialogue automatically;