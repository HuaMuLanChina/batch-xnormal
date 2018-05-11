	function fnValidCheck =
	(
		if not(doesFileExist et_xNormalPath.text) then
		(
			messageBox "xNormal可执行文件不存在。";
			return false;
		)
		return true;
	)
	
	function fnOnlistbox_lowPolyDelKey =
	(
		while listbox_lowPoly.SelectedIndex > -1 do
		(
			myRender.fnRemoveLow (listbox_lowPoly.SelectedIndex + 1);
			listbox_lowPoly.Items.RemoveAt listbox_lowPoly.SelectedIndex;
		)
	)
	
	function fnOnlistbox_highPolyDelKey =
	(
		while listbox_highPoly.SelectedIndex > -1 do
		(
			myRender.fnRemoveHigh (listbox_highPoly.SelectedIndex + 1);
			listbox_highPoly.Items.RemoveAt listbox_highPoly.SelectedIndex;
		)
	)
	
	function fnGetLowIndices =
	(
		indices = #();
		for node in selection do
		(
			index = myRender.fnFindLowPoly node;
			if index != -1 then
			(
				append indices (index - 1);
			)
		)
		return indices;
	)
	
	function fnGetHighIndices =
	(
		indices = #();
		for node in selection do
		(
			index = myRender.fnFindHighPoly node;
			if index != -1 then
			(
				append indices (index - 1);
			)
		)
		return indices;
	)
	
	function fnChangeSelectLowAndHigh pLowIndices pHighIndices =
	(
		for index in pLowIndices do
		(
			listbox_lowPoly.SetSelected index true;
		)
		for index in pHighIndices do
		(
			listbox_highPoly.SetSelected index true;
		)
	)
	
	function fnSyncScenseSelection2UI =
	(
		listbox_lowPoly.ClearSelected();
		listbox_highPoly.ClearSelected();
		lowIndices = fnGetLowIndices();
		highIndices = fnGetHighIndices();
		fnChangeSelectLowAndHigh lowIndices highIndices;
	)
	
	function fnTIME_CALLBACK_NODE_SELECTION_CHANGE =
	(
		if not isUITriggeredSelectionChange then
		(
			fnSyncScenseSelection2UI();
		)
	)
	
	function fnSyncArg =
	(
		myRender.IsUseAO = checkbox_useAO.checked;
		myRender.IsGenNormal = checkbox_genNormal.checked;
		myRender.IsForMax = checkbox_forMax.checked;
		myRender.IsForMaya = checkbox_forMaya.checked;
		myRender.IsAOReflectorON = checkbox_useAOReflector.checked;
		
		myRender.IsGenHeights = checkbox_genHeights.checked;
		myRender.IsGenBent = checkbox_genBent.checked;
		myRender.IsGenPRT = checkbox_genPRT.checked;
		myRender.IsGenConvexity = checkbox_genConvexity.checked;
		myRender.IsGenThickness = checkbox_genThickness.checked;
		myRender.IsGenProximity = checkbox_genProximity.checked;
		myRender.IsGenCavity = checkbox_genCavity.checked;
		myRender.IsGenWireRays = checkbox_genWireRays.checked;
		myRender.IsGenDirections = checkbox_genDirections.checked;
		myRender.IsGenRadiosityNormals = checkbox_genRadiosityNormals.checked;
		myRender.IsUseBakeHighpolyVCols = checkbox_useBakeHighpolyVCols.checked;
		myRender.IsGenCurv = checkbox_genCurv.checked;
		myRender.IsGenTranslu = checkbox_genTranslu.checked;
		myRender.IsGenDerivNM = checkbox_genDerivNM.checked;
		
		myRender.TextureWidthSelection = ddl_TextureWidth.selection;
		myRender.TextureHighSelection = ddl_TextureHeight.selection;
		myRender.EdgePaddingSelection = ddl_EdgePadding.selection;
		myRender.AntialisingSelection = ddl_Antialising.selection;
		myRender.BGcolor = cp_NormalBG.color;
		myRender.fullTexturePath = et_xNormalTexPath.text;
	)
	
	function fnFindSelectedLowIndices =
	(
		Indices = #();
		if listbox_lowPoly.SelectedIndices.count > 0 then
		(
			for i = 0 to listbox_lowPoly.SelectedIndices.count - 1 do
			(
				index = listbox_lowPoly.SelectedIndices.Item[i] + 1;
				append Indices index;
			)
		)
		
		return Indices;
	)
	
	function fnFindSelectedIndices =
	(
		Indices = #();
		if listbox_lowPoly.SelectedIndices.count > 0 then
		(
			for i = 0 to listbox_lowPoly.SelectedIndices.count - 1 do
			(
				index = listbox_lowPoly.SelectedIndices.Item[i] + 1;
				id = (myRender.fnGetLowPoly index).K1;
				if id != 0 then
					appendIfUnique Indices id;
			)
		)
		
		return Indices;
	)
	
	function SyncLowArrayData2UI=
	(
		local lowItem,i;
		listbox_lowPoly.Items.Clear();
		for i = 1 to myRender.fnGetLowPolyCount() do
		(
			lowItem = myRender.fnGetLowPoly i;
			listbox_lowPoly.Items.Add (lowItem.fnBuildIndexedString());
		)
	)
	
	function SyncHighArrayData2UI  = 
	(
		local i,indexedHigh,lastHigh;
		listbox_highPoly.Items.Clear();
		
		for i = 1 to myRender.fnGetHighPolyCount() do
		(
			indexedHigh = myRender.fnGetHighPoly i;
			if lastHigh != undefined and lastHigh.K3.fnIsSameFile indexedHigh.K3 then
			(
				itemStr = indexedHigh.fnBuildDuplicatedIndexedString();
			)
			else
			(
				itemStr = indexedHigh.fnBuildIndexedString();
			)
			
			listbox_highPoly.Items.Add itemStr;
			lastHigh = indexedHigh;
		)
	)
	
	function ReadLastHighPolyList =
	(
		try
		(
			myRender.fnReadLast();
		)
		catch
		(
			myRender.fnReset();
			messageBox ("未能正确加载!\n:" + getCurrentException());
		)
		SyncLowArrayData2UI();
		SyncHighArrayData2UI();
	)
	
	function FindAccordingLowInScence =
	(
		local need2Select = #();
		if listbox_lowPoly.SelectedIndices.count > 0 then
		(
			for i = 0 to listbox_lowPoly.SelectedIndices.count - 1 do
			(
				local index = listbox_lowPoly.SelectedIndices.Item[i] + 1;
				append need2Select (myRender.fnGetLowPoly index).K2;
			)
		)
		
		return need2Select;
	)
	
	function FindAccordingHighInScence =
	(
		local need2Select = #();
		if listbox_highPoly.SelectedIndices.count > 0 then
		(
			for i = 0 to listbox_highPoly.SelectedIndices.count - 1 do
			(
				local index = listbox_highPoly.SelectedIndices.Item[i] + 1;
				append need2Select ((myRender.fnGetHighPoly index).K2);
			)
		)
		
		return need2Select;
	)
	
	function SelectTheSameIndexLowPolyList =
	(
		local i = listbox_lowPoly.SelectedIndex + 1;
		local selectedIndex = (myRender.fnGetLowPoly i).K1;
		local Indices = myRender.fnFindLowPolyPosByIndex selectedIndex;
		
		for ii in Indices do
		(
			index = ii - 1;
			listbox_lowPoly.SetSelected index true;
		)
	)
	
	function SelectAccordingScenseObjectLowPolyList =
	(
		isUITriggeredSelectionChange = true;
		local lows = FindAccordingLowInScence();
		if lows != undefined then
			select lows;
		isUITriggeredSelectionChange = false;
	)
	
	function SelectTheSameIndexHighPolyList =
	(
		local i = listbox_highPoly.SelectedIndex + 1;
		local selectedIndex = (myRender.fnGetHighPoly i).K1;
		local Indices = myRender.fnFindHighPolyPosByIndex selectedIndex;
		
		for ii in Indices do
		(
			index = ii - 1;
			listbox_highPoly.SetSelected index true;
		)
	)
	
	function SelectAccordingScenseObjectHighPolyList =
	(
		isUITriggeredSelectionChange = true;
		local highs = FindAccordingHighInScence();
		if highs != undefined then
			select highs;
		isUITriggeredSelectionChange = false;
	)
	
	function SyncSelectedLowAndHighPolySub pLowArray pHighArray =
	(
		local need2select = pLowArray + pHighArray;
		select need2select;
	)
	
	function SyncSelectedLowAndHighPoly =
	(
		isUITriggeredSelectionChange = true;
		local lows, highs;
		lows = FindAccordingLowInScence();
		highs = FindAccordingHighInScence();
		SyncSelectedLowAndHighPolySub lows highs;
		isUITriggeredSelectionChange = false;
	)
	
	function SetupBakeSelected =
	(
		local i = listbox_lowPoly.SelectedIndex + 1;
		local obj = (myRender.fnGetLowPoly i).K2;
		
		myTestBake = TestBake();
		myTestBake.BakedObj = obj;
		myTestBake.Setup();
	)
	
	function TestBakeSelected =
	(
		local i = listbox_lowPoly.SelectedIndex + 1;
		if i > 0 then 
		(
			local obj = (myRender.fnGetLowPoly i).K2;
			
			myTestBake = TestBake();
			myTestBake.BakedObj = obj;
			myTestBake.Width = Winking_xNormal_gTextureParam[ddl_TextureWidth.selection];
			myTestBake.Height = Winking_xNormal_gTextureParam[ddl_TextureHeight.selection];
			myTestBake.EdgePadding = Winking_xNormal_gTextureParamEdgePaddingStr[ddl_EdgePadding.selection] as integer;
			myName = getFilenameFile maxFileName;
			if myName == "" then myName = "Test";
			myTestBake.OutPath = Winking_xNormal_gTexturePath + myName + "BakeTest.TGA";
			myTestBake.Test();
		)
	)
	
	function CheckUpdateModifiedPoly =
	(
		try
		(
			if checkbox_UseSceneHighPolys.checked then
			(
				myRender.fnUpdateChangedHighPolyFile2Scene true false;
			)
			else
			(
				myRender.fnUpdateChangedHighPolyFile2Scene true true;
			)
			SyncHighArrayData2UI();
		)
		catch
		(
			myRender.fnReset();
			messageBox (getCurrentException()) title:"警告" beep:on;
		)
	)
	
	function Copy_Selected =
	(
		local IndexedHighList;
		local selectIndex = listbox_highPoly.SelectedIndex + 1;
		
		if listbox_highPoly.SelectedIndices.count > 0 then
		(
			myRender.fnCopyHigh selectIndex;
			SyncHighArrayData2UI();
		)
	)
	
	function SaveListSetting =
	(
		local myPath = getSaveFileName caption:"保存设置路径：" types:"Data(*.dat)|*.dat|";
		if myPath != undefined then
			myRender.fnSaveData myPath;
	)
	
	function LoadListSetting =
	(
		local myPath = getOpenFileName caption:"读取设置路径：" types:"Data(*.dat)|*.dat|";
		if myPath != undefined then
		(
			try
			(
				myRender.fnReadData myPath;
			)
			catch
			(
				myRender.fnReset();
				messageBox ("未能正确加载!\n:" + getCurrentException());
			)
			SyncLowArrayData2UI();
			SyncHighArrayData2UI();
			
		)
	)
	
	function SaveBatchSettings =
	(
		local myPath = getSavePath caption:"保存设置路径：";
		if myPath != undefined and fnValidCheck() then
		(
			CheckUpdateModifiedPoly();
			fnSyncArg();
			myRender.fnGenBatchSetting (fnFindSelectedLowIndices()) (fnFindSelectedIndices()) myPath;
			messagebox "渲染结束"
		)
	)
	
	function Update =
	(
		try
		(
			destroyDialog rol_xNormal;
		)
		catch()
		fnUpdateMyself();	
		fileIN "$userscripts\\xNormalTag2\\Init_xNormal.ms";--重新开启xNormal;
	)