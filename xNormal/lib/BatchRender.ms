struct RParam
(
	IsUseCage = true,
	IsUseAO = false,
	IsGenNormal = true,
	IsForMax = true,
	IsForMaya = false,
	IsAOReflectorON = false,
	IsUseBaseMap = false,
	
	IsGenHeights = false,
	IsGenBent = false,
	IsGenPRT = false,
	IsGenConvexity = false,
	IsGenThickness = false,
	IsGenProximity = false,
	IsGenCavity = false,
	IsGenWireRays = false,
	IsGenDirections = false,
	IsGenRadiosityNormals = false,
	IsUseBakeHighpolyVCols = false,
	IsGenCurv = false,
	IsGenTranslu = false,
	IsGenDerivNM = false,

	TextureWidthSelection = 6,
	TextureHighSelection = 6,
	EdgePaddingSelection = 3,
	AntialisingSelection = 3,
	BGcolor = (color 128 128 255),
	fullTexturePath,
	AOReflectorPath
);
struct Low2HighArrayMap (LowObjArray,HighPathArray,RParam);



struct BatchRender
(
	public
		IsUseCage = true,
		IsUseAO = false,
		IsGenNormal = true,
		IsForMax = true,
		IsForMaya = false,
		IsAOReflectorON = false,
		IsUseBaseMap = true,
		
		IsGenHeights = false,
		IsGenBent = false,
		IsGenPRT = false,
		IsGenConvexity = false,
		IsGenThickness = false,
		IsGenProximity = false,
		IsGenCavity = false,
		IsGenWireRays = false,
		IsGenDirections = false,
		IsGenRadiosityNormals = false,
		IsUseBakeHighpolyVCols = false,
		IsGenCurv = false,
		IsGenTranslu = false,
		IsGenDerivNM = false,

		TextureWidthSelection = 6,
		TextureHighSelection = 6,
		EdgePaddingSelection = 3,
		AntialisingSelection = 3,
		BGcolor = (color 128 128 255),
		fullTexturePath,
		AOReflectorPath,
	private
		IndexedArray = #(),-- start from 1 , 0 not render
		
		LowPolyRepresentation = TriItemCollection(),
		HighPolyRepresentation = HighPolyRep(),
		BatchJobArray = #(),
		
		OriginalMat = #(),
		NormalTextureMat = #(),
		state = true,			-- used for assign mat
		
		myAOReflector = AO_Reflector(),
		
		function fnFillArgs &pRParam =
		(
			pRParam.IsUseCage		=	IsUseCage;
			pRParam.IsUseAO			=	IsUseAO;
			pRParam.IsGenNormal		= 	IsGenNormal;
			pRParam.IsForMax 		=	IsForMax;
			pRParam.IsForMaya		=	IsForMaya;
			pRParam.IsAOReflectorON	=	IsAOReflectorON;
			
			pRParam.IsGenHeights	=	IsGenHeights;
			pRParam.IsGenBent		=	IsGenBent;
			pRParam.IsGenPRT		=	IsGenPRT;
			pRParam.IsGenConvexity	=	IsGenConvexity;
			pRParam.IsGenThickness	=	IsGenThickness;
			pRParam.IsGenProximity	=	IsGenProximity;
			pRParam.IsGenCavity		=	IsGenCavity;
			pRParam.IsGenWireRays	=	IsGenWireRays;
			pRParam.IsGenDirections =	IsGenDirections;
			pRParam.IsGenRadiosityNormals	=	IsGenRadiosityNormals;
			pRParam.IsUseBakeHighpolyVCols	=	IsUseBakeHighpolyVCols;
			pRParam.IsGenCurv		=	IsGenCurv;
			pRParam.IsGenTranslu	=	IsGenTranslu;
			pRParam.IsGenDerivNM	=	IsGenDerivNM;

			pRParam.TextureWidthSelection	=	TextureWidthSelection;
			pRParam.TextureHighSelection	=	TextureHighSelection;
			pRParam.EdgePaddingSelection	=	EdgePaddingSelection;
			pRParam.AntialisingSelection	=	AntialisingSelection;
			pRParam.BGcolor					=	BGcolor;
			pRParam.fullTexturePath			=	fullTexturePath;
			pRParam.AOReflectorPath			=	AOReflectorPath;
		),
		function fnExportAOReflector =
		(
			AOReflectorPath = myAOReflector.Export();
		),
		function fnStoreOriginalMat =
		(
			OriginalMat = #();
			for job in BatchJobArray do
			(
				subMatArray = #();
				for o in job.LowObjArray do
				(
					append subMatArray o.K2.mat;
				)
				append OriginalMat subMatArray;
			)
		),
		function fnMakeTexturePath index = 
		(
			texPath = getFilenamePath fullTexturePath;
			name = getFilenameFile fullTexturePath;
			newName = name + (index as string);
			extension = getFilenameType fullTexturePath;
			fileName = texPath + newName + extension;
			return fileName;
		),
		function fnSetGeneralAllPath index =
		(
			local JobRenderingParam = BatchJobArray[index].RParam;
			
			fnInitalizeXMLDoc();
			
			fnSetGenBaseTex (JobRenderingParam.IsUseBaseMap as string);
			fnSetOutputFileTexWidth Winking_xNormal_gTextureParamStr[JobRenderingParam.TextureWidthSelection];
			fnSetOutputFileTexHight Winking_xNormal_gTextureParamStr[JobRenderingParam.TextureHighSelection];
			fnSetOutputFileEdgePadding (Winking_xNormal_gTextureParamEdgePaddingStr[JobRenderingParam.EdgePaddingSelection]);
			fnSetAntialising Winking_xNormal_gTextureParamAntialisingSettingFileStr[JobRenderingParam.AntialisingSelection];
			
			type = 0;
			if JobRenderingParam.IsForMaya then type = 1;
				
			fnSetOutputFileTangentSpaceType type;
			
			fnSetNormalBG (JobRenderingParam.BGcolor.red as string) (JobRenderingParam.BGcolor.green as string) (JobRenderingParam.BGcolor.blue as string);
			
			fnSetGenAO (JobRenderingParam.IsUseAO as string);
			fnSetGenNormal(JobRenderingParam.IsGenNormal as string);
			fnSetGenHeights (JobRenderingParam.IsGenHeights as string);
			fnSetGenBent (JobRenderingParam.IsGenBent as string);
			fnSetGenPRT (JobRenderingParam.IsGenPRT as string);
			fnSetGenConvexity (JobRenderingParam.IsGenConvexity as string);
			fnSetGenThickness (JobRenderingParam.IsGenThickness as string);
			fnSetGenProximity (JobRenderingParam.IsGenProximity as string);
			fnSetGenCavity (JobRenderingParam.IsGenCavity as string);
			fnSetGenWireRays (JobRenderingParam.IsGenWireRays as string);
			fnSetGenDirections (JobRenderingParam.IsGenDirections as string);
			fnSetGenRadiosityNormals (JobRenderingParam.IsGenRadiosityNormals as string);
			fnSetBakeHighpolyVCols (JobRenderingParam.IsUseBakeHighpolyVCols as string);
			fnSetGenCurv (JobRenderingParam.IsGenCurv as string);
			fnSetGenTranslu (JobRenderingParam.IsGenTranslu as string);
			fnSetGenDerivNM (JobRenderingParam.IsGenDerivNM as string);
			
			fnSaveXMLDoc();
		),
		function fnSetBatchAllPath index = 
		(
			local highPath = BatchJobArray[index].HighPathArray;
			fnInitalizeXMLDoc();
			
			fnSetLowPolyExportPath BatchJobArray[index].LowObjArray (fnCheckIfHasCageAndEditMeshModifier BatchJobArray[index].LowObjArray[1].K2 false);

			fnSetHighPolyExportPath highPath;
			local myTexturePath = fnMakeTexturePath BatchJobArray[index].LowObjArray[1].K1;
			fnSetOutputFilePath myTexturePath;
			
			
			fnSaveXMLDoc();
		),
		function fnBatchRenderSub index = 
		(
			CommandPath = getFilenamePath ( Winking_xNormal_g_xNormalPath);
			CommandString = filenameFromPath ( Winking_xNormal_g_xNormalPath);
			ParaString = Winking_xNormal_gSettingFilePath + Winking_xNormal_gLastSettingFileName;
			ParaString = "\"" + ParaString + "\"";
			CommandString += (" " + ParaString);
			HiddenDOSCommand CommandString startpath:CommandPath ;
			
			path1 = Winking_xNormal_gLastSettingFileName;
			path2 = (BatchJobArray[index].LowObjArray[1].K2.name) + ".xml";
			copyCommandString = "copy " + path1 + " " + path2;
			HiddenDOSCommand copyCommandString startpath:Winking_xNormal_gSettingFilePath;
		),
		function fnGenBatchSettingSub index pPath =
		(
			local path1 = Winking_xNormal_gLastSettingFileName;
			local path2 = "\"" + pPath + "\\" + (BatchJobArray[index].LowObjArray[1].K2.name) + ".xml" + "\"";
			copyCommandString = "copy " + path1 + " " + path2;
			HiddenDOSCommand copyCommandString startpath:Winking_xNormal_gSettingFilePath;
		),
		function fnMakeBatchBakedMat index = 
		(
			mat = standardMaterial shaderType:1;
			
			texPath = getFilenamePath fullTexturePath;
			name = getFilenameFile fullTexturePath;
			newNormalMapName = name + (BatchJobArray[index].LowObjArray[1].K1 as string) + "_normals";
			extension = getFilenameType fullTexturePath;
			
			if IsGenNormal then
			(
				NormalFileName = texPath + newNormalMapName + extension;
				bumpMap = Bitmaptexture filename:NormalFileName;
				bumpMap.reload();
				NormalBumpTex = Normal_Bump normal_map:bumpMap;
				mat.maps[9] = NormalBumpTex;
			)
			
			if IsUseAO then
			(
				newAOName = name + (BatchJobArray[index].LowObjArray[1].K1 as string) + "_occlusion";
				AOFileName = texPath + newAOName + extension;
				aoMap = Bitmaptexture filename:AOFileName;
				aoMap.reload();
				mat.maps[2] = aoMap;
			)
			
			mat.mapAmounts[9] = 100;
			mat.specularLevel = 50;
			mat.glossiness = 25;
			
			return mat;
		),
		function fnSetUpBatchMaterial index= 
		(
			mat = fnMakeBatchBakedMat index;
			append NormalTextureMat mat;
		),
		function fnAssignNormalMatOne index =
		(
			for lowObj in BatchJobArray[index].LowObjArray do
			(
				lowObj.K2.mat = NormalTextureMat[index];
				meditMaterials[1] = NormalTextureMat[index];
				enableHardwareMaterial lowObj.K2.mat on;
				showHWTextureMap lowObj.K2.mat on;
				sleep 1;
			)
		),
		function fnAssignBatchMatOne index = 
		(
			fnAssignNormalMatOne index;
		),
		function fnRestoreOriginalMat =
		(
			for i = 1 to BatchJobArray.count do
			(
				for j = 1 to BatchJobArray[i].LowObjArray.count do
				(
					BatchJobArray[i].LowObjArray[j].K2.mat = OriginalMat[i][j];
				)
			)
		),	
		function fnAssignNormalMat =
		(
			max mtledit
			for i = 1 to BatchJobArray.count do
			(
				for lowObj in BatchJobArray[i].LowObjArray do
				(
					lowObj.K2.mat = NormalTextureMat[i];
					meditMaterials[activeMeditSlot] = NormalTextureMat[i];
					enableHardwareMaterial lowObj.K2.mat on;
					showHWTextureMap lowObj.K2.mat on;
					sleep 1;
				)
			)
		),
		function fnLowPolyCageCheck =
		(
			local index, item, rel;
			for index = 1 to LowPolyRepresentation.fnCount() do
			(
				item = LowPolyRepresentation.fnGet index;
				rel = fnCheckIfHasCageAndEditMeshModifier item.K2 true;
			)
			rel;
		),
		function fnFindObjsByIndex pIndex =
		(			
			return LowPolyRepresentation.fnFindItemsByK1 pIndex;
		),
		function fnFindAllUsedIndices =
		(
			IndexedArray = #();
			local index, item, rel;
			for index = 1 to LowPolyRepresentation.fnCount() do
			(
				item = LowPolyRepresentation.fnGet index;
				print item;
				if item.K1 > 0 then
					appendIfUnique IndexedArray item.K1;-- store index in use
			)
		),
		function fnGenJobSequenceArray pUsedIndices=
		(
			local item;
			BatchJobArray = #();

			for i in pUsedIndices do
			(
				local usedLowObjs = fnFindObjsByIndex i;
				local HighPolyPathList = #(),AOReflectorHighPolyPathList;
				local RenderingParam = RParam(),RenderingParamWithReflector;
				local loopindex;
				fnFillArgs RenderingParam;

				for j = 1 to usedLowObjs.count do
				(
					lwPath = Winking_xNormal_gLowPolyDirPath + "LowMeshTemp" + (i as string) + "_" + (j as string) + ".sbm";
					fnExportLow usedLowObjs[j].K2 lwPath;
					usedLowObjs[j].K3 = PhsicalFileStruct FullFileName:lwPath;
				)
				HighPolyRepresentation.fnCheck();
				for loopindex = 1 to HighPolyRepresentation.fnCount() do
				(
					IndexedHighObj = HighPolyRepresentation.fnGet loopindex;
					if IndexedHighObj.K1 == i then
					(
						append HighPolyPathList IndexedHighObj.K3.FullFileName;
					)
				)
				
				if RenderingParam.IsUseAO then
				(
					if not RenderingParam.IsGenNormal then 
					(
						RenderingParam.IsUseBaseMap = false
					)
					else
					(
						RenderingParam.IsUseBaseMap = fnIsUseBaseMap();
					)
					if not IsAOReflectorON then
					(
						item = Low2HighArrayMap LowObjArray:usedLowObjs HighPathArray:HighPolyPathList RParam:RenderingParam;
						append BatchJobArray item;
					)
					else
					(
						if RenderingParam.IsGenNormal then
						(
							RenderingParam.IsUseAO = false;
							item = Low2HighArrayMap LowObjArray:usedLowObjs HighPathArray:HighPolyPathList RParam:RenderingParam;
							append BatchJobArray item;
						)
						
						RenderingParamWithReflector = copy RenderingParam;
						RenderingParamWithReflector.IsUseAO = true;
						RenderingParamWithReflector.IsUseBaseMap = false;
						RenderingParamWithReflector.IsGenNormal = false;
						RenderingParamWithReflector.IsAOReflectorON = true;
						AOReflectorHighPolyPathList = deepCopy HighPolyPathList;
						append AOReflectorHighPolyPathList RenderingParamWithReflector.AOReflectorPath;
						item = Low2HighArrayMap LowObjArray:usedLowObjs HighPathArray:AOReflectorHighPolyPathList RParam:RenderingParamWithReflector;
						append BatchJobArray item;
					)
				)
				else
				(
					RenderingParam.IsUseBaseMap = fnIsUseBaseMap();
					item = Low2HighArrayMap LowObjArray:usedLowObjs HighPathArray:HighPolyPathList RParam:RenderingParam;
					append BatchJobArray item;
				)
			)
		),
		function fnFindObjsByIndexInSelected pSelectedLow pIndex =
		(
			return LowPolyRepresentation.fnFindItemsByK1WithRestriction pSelectedLow pIndex;
		),
		function fnGenJobSequenceArrayInSelected pSelectedLow pUsedIndices=
		(
			BatchJobArray = #();
			for i in pUsedIndices do
			(
				local usedLowObjs = fnFindObjsByIndexInSelected pSelectedLow i;
				local RenderingParam = RParam(),RenderingParamWithReflector;
				local HighPolyPathList = #(),AOReflectorHighPolyPathList;
				
				fnFillArgs RenderingParam;
				
				for j = 1 to usedLowObjs.count do
				(
					lwPath = Winking_xNormal_gLowPolyDirPath + "LowMeshTemp" + (i as string) + "_" + (j as string) + ".sbm";
					fnExportLow usedLowObjs[j].K2 lwPath;
					usedLowObjs[j].K3 = PhsicalFileStruct FullFileName:lwPath;
				)
				HighPolyRepresentation.fnCheck();
				for loopindex = 1 to HighPolyRepresentation.fnCount() do
				(
					IndexedHighObj = HighPolyRepresentation.fnGet loopindex;
					if IndexedHighObj.K1 == i then
					(
						append HighPolyPathList IndexedHighObj.K3.FullFileName;
					)
				)
				
				if RenderingParam.IsUseAO then
				(
					if not RenderingParam.IsGenNormal then 
					(
						RenderingParam.IsUseBaseMap = false
					)
					else
					(
						RenderingParam.IsUseBaseMap = fnIsUseBaseMap();
					)
					if not IsAOReflectorON then
					(
						item = Low2HighArrayMap LowObjArray:usedLowObjs HighPathArray:HighPolyPathList RParam:RenderingParam;
						append BatchJobArray item;
					)
					else
					(
						if RenderingParam.IsGenNormal then
						(
							RenderingParam.IsUseAO = false;
							item = Low2HighArrayMap LowObjArray:usedLowObjs HighPathArray:HighPolyPathList RParam:RenderingParam;
							append BatchJobArray item;
						)
						
						RenderingParamWithReflector = copy RenderingParam;
						RenderingParamWithReflector.IsUseAO = true;
						RenderingParamWithReflector.IsUseBaseMap = false;
						RenderingParamWithReflector.IsGenNormal = false;
						RenderingParamWithReflector.IsAOReflectorON = true;
						AOReflectorHighPolyPathList = deepCopy HighPolyPathList;
						append AOReflectorHighPolyPathList RenderingParamWithReflector.AOReflectorPath;
						item = Low2HighArrayMap LowObjArray:usedLowObjs HighPathArray:AOReflectorHighPolyPathList RParam:RenderingParamWithReflector;
						append BatchJobArray item;
					)
				)
				else
				(
					RenderingParam.IsUseBaseMap = fnIsUseBaseMap();
					item = Low2HighArrayMap LowObjArray:usedLowObjs HighPathArray:HighPolyPathList RParam:RenderingParam;
					append BatchJobArray item;
				)
			)
		),
	public
		function fnAddLowPoly pLowPoly = 
		(
			local lowItem = LowPolyTriKeyItem K1:0 K2:pLowPoly;
			LowPolyRepresentation.fnAdd lowItem;
			return lowItem;
		),
		function fnGetLowPolyCount =
		(
			return LowPolyRepresentation.fnCount();
		),
		function fnGetLowPoly pIndex =
		(
			return LowPolyRepresentation.fnGet pIndex;
		),
		function fnGetHighPoly pIndex =
		(
			return HighPolyRepresentation.fnGet pIndex;
		),
		function fnGetHighPolyCount =
		(
			return HighPolyRepresentation.fnCount();
		),
		function fnHasLowPoly pLowPoly =
		(
			local itemArray = LowPolyRepresentation.fnFindItemsByK2 pLowPoly;
			
			return itemArray.count > 0;
		),
		function fnHasHighPoly pHighPoly =
		(
			local itemArray = HighPolyRepresentation.fnFindItemsByK2 pHighPoly;
		
			return itemArray.count > 0;
		),
		function fnFindLowPoly pLowPoly =
		(
			return LowPolyRepresentation.fnFindPostionByK2 pLowPoly;
		),
		function fnFindHighPoly pNode =
		(
			return HighPolyRepresentation.fnFindPostionByK2 pNode;
		),
		function fnCopyHigh pIndex =
		(
			HighPolyRepresentation.fnDuplicate pIndex;
		),
		function fnRemoveLow pIndex =
		(
			LowPolyRepresentation.fnRemove pIndex;
		),
		function fnRemoveHigh pIndex =
		(
			HighPolyRepresentation.fnRemove pIndex;
		),
		function fnUpdateChangedHighPolyFile2Scene pChangeUpdate pAddingUpdate =
		(
			HighPolyRepresentation.fnUpdateChangedFiles pChangeUpdate pAddingUpdate;
		),
		function fnUpdateLowPolyIndex indexOfArray newIndex = 
		(
			LowPolyRepresentation.fnUpdateK1 indexOfArray newIndex;
		),
		function fnSortLowPoly =
		(
			LowPolyRepresentation.fnSort();
		),
		function fnUpdateHighPolyIndex indexOfArray newIndex = 
		(
			HighPolyRepresentation.fnUpdateK1 indexOfArray newIndex;
		),
		function fnSortHighPoly =
		(
			HighPolyRepresentation.fnSort();
		),
		function fnDebugPrint =
		(
			LowPolyRepresentation.fnDebugPrint();
			HighPolyRepresentation.fnDebugPrint();
			for job in BatchJobArray do
			(
				format "BatchJobArray LowObjArray:% HighPathArray:% RParam:%\n" job.LowObjArray job.HighPathArray job.RParam;
			)
			for mat in OriginalMat do
			(
				format "mat:%\n" mat;
			)
			format "state:%\n" state;
		),
		function fnNoticePrint =
		(
			local item;
			for job in BatchJobArray do
			(
				format "------------------------BatchJobArray----------------------------\n";
				format "低模物体\n";
				for item in job.LowObjArray do
				(
					format "%\n" item;
				)
				format "高模物体\n";
				for item in job.HighPathArray do
				(
					format "%\n" item;
				)
				format "渲染参数\n";
				format "%\n" job.RParam;
				format "-----------------------------------------------------------------\n";
			)
		),
		function GenAOReflectorNode =
		(
			local myLowNodes = LowPolyRepresentation.fnCollectK2();
			local myHighNodes = HighPolyRepresentation.fnCollectK2();
			local ret;
			if myHighNodes.count > 0 then
			(
				myAOReflector.fnGenReflector myHighNodes;
				ret = myHighNodes.count;
			)
			else
			(
				myAOReflector.fnGenReflector myLowNodes;
				ret = myLowNodes.count;
			)
			return ret;
		),
		function DeleteAOReflectorNode =
		(
			myAOReflector.DelAOReflector();
		),
		--pSelectedLowIndices 当前选择的序号
		--pUsedIndices 当前被选中的项目里全部被使用的序号
		function fnBatchRender pSelectedLowIndices pUsedIndices =
		(
			OriginalMat = #();
			NormalTextureMat = #();
			state = true;			-- used for assign mat
			fnLowPolyCageCheck();
			fnFindAllUsedIndices();
			if IsUseAO and IsAOReflectorON then
				fnExportAOReflector();
			if pUsedIndices.count > 0 then
			(
				fnGenJobSequenceArrayInSelected pSelectedLowIndices pUsedIndices;--只渲染当前被选中的 ；
			)
			else
			(
				fnGenJobSequenceArray IndexedArray;
			)
			fnStoreOriginalMat();
			
			fnNoticePrint();
			--fnDebugPrintData();
			progressStart  "渲染进程";
			
			progressUpdate 1;
			for i = 1 to BatchJobArray.count do
			(
				--select BatchJobArray[i].LowObjArray.K1;
				
				sleep 1;
				
				fnSetGeneralAllPath i;
				fnSetBatchAllPath i;
				if (i - 1) > 0 then
					progressUpdate ((((i - 1) as float)/BatchJobArray.count * 100) as integer);
				fnBatchRenderSub i;
				
				fnSetUpBatchMaterial i;
				
				--fnAssignBatchMatOne i;
			)
			progressUpdate 100;
			progressEnd();
			fnPromptMessage "完成烘培:P";
		),
		function fnGenBatchSetting pSelectedLowIndices pUsedIndices pPath =
		(
			OriginalMat = #();
			NormalTextureMat = #();
			state = true;			-- used for assign mat
			fnLowPolyCageCheck();
			fnFindAllUsedIndices();
			if IsUseAO and IsAOReflectorON then
				fnExportAOReflector();
			if pUsedIndices.count > 0 then
				fnGenJobSequenceArrayInSelected pSelectedLowIndices pUsedIndices;--只渲染当前被选中的 ；
			else
				fnGenJobSequenceArray IndexedArray;
			
			progressStart  "渲染进程";
			
			progressUpdate 1;
			for i = 1 to BatchJobArray.count do
			(
				
				sleep 1;
				
				fnSetGeneralAllPath i;
				fnSetBatchAllPath i;
				if (i - 1) > 0 then
					progressUpdate ((((i - 1) as float)/BatchJobArray.count * 100) as integer);
				fnGenBatchSettingSub i pPath;
			)
			progressUpdate 100;
			progressEnd();
			fnPromptMessage "完成烘培:P";
		),
		function fnAssignBatchMat = 
		(
			if state then
			(
				fnAssignNormalMat();
			)
			else
			(
				fnRestoreOriginalMat();
			)
			
			state = not state;
		),
		function fnReset =
		(
			LowPolyRepresentation.fnClear();
			HighPolyRepresentation.fnDeleteAllAndClear();
			BatchJobArray = #();
			IndexedArray = #();
			OriginalMat = #();
			NormalTextureMat = #();
			state = false;
		),
		function fnSaveData pPath =
		(
			local saveFile = openFile pPath mode:"w";
			LowPolyRepresentation.fnWriteSection saveFile;
			HighPolyRepresentation.fnWriteSection saveFile;
			close saveFile;
		),
		function fnSaveLast =
		(
			local mypath = Winking_xNormal_gDataFileNamepath + "xNormalLastLists.Dat";
			fnSaveData mypath;
		),
		function fnReadData pPath =
		(
			local saveFile = openFile pPath mode:"r";
			LowPolyRepresentation.fnReadSection saveFile;
			HighPolyRepresentation.fnReadSection saveFile;
			close saveFile;
		),
		function fnReadLast =
		(
			local mypath = Winking_xNormal_gDataFileNamepath + "xNormalLastLists.Dat";
			fnReadData mypath;
		),
	public
		function fnFindHighPolyPosByIndex pIndex =
		(
			return HighPolyRepresentation.fnFindPostionsByK1 pIndex;
		),
		function fnFindLowPolyPosByIndex pIndex =
		(
			return LowPolyRepresentation.fnFindPostionsByK1 pIndex;
		),
		function fnAddHighPoly pHighPoly =
		(
			highPath = Winking_xNormal_gLastHighPolyDirPath + "HighMeshTemp" + (HighPolyRepresentation.fnCount() as string) + ".sbm";
			--fnExportHigh pHighPoly highPath;
			indexedHighPoly = HighPolyTriKeyItem K1:0 K2:pHighPoly K3:(PhsicalFileStruct FullFileName:highPath);
			HighPolyRepresentation.fnAdd indexedHighPoly;
			return indexedHighPoly;
		),
		function fnClearHighPolyList =
		(
			HighPolyRepresentation.fnClear();
		)
);