---------------------------------------------------Handler---------------------------------------------
	on rol_xNormal open do
	(
		local selectionMode,drawMode;
		listbox_lowPoly.Size.Height = listbox_highPoly.Size.Height = 226;
		listbox_lowPoly.Size.Width = listbox_highPoly.Size.Width = 112;
		listbox_lowPoly.HorizontalScrollBar = listbox_highPoly.HorizontalScrollBar = true;
		listbox_lowPoly.ScrollAlwaysVisible = listbox_highPoly.ScrollAlwaysVisible = true;
		selectionMode = dotNetClass "System.Windows.Forms.SelectionMode";
		listbox_highPoly.SelectionMode = selectionMode.MultiExtended;
		listbox_lowPoly.SelectionMode = selectionMode.MultiExtended;
		checkbox_UseSceneHighPolys.checked = Winking_xNormal_gLastUseSceneHighPoly as BooleanClass;
		checkbox_useAOReflector.checked = myRender.IsAOReflectorON;
		checkbox_genNormal.checked = myRender.IsGenNormal;
		checkbox_genHeights.checked = myRender.IsGenHeights;
		checkbox_genBent.checked = myRender.IsGenBent;
		checkbox_genPRT.checked = myRender.IsGenPRT;
		checkbox_genConvexity.checked = myRender.IsGenConvexity;
		checkbox_genThickness.checked = myRender.IsGenThickness;
		checkbox_genProximity.checked = myRender.IsGenProximity;
		checkbox_genCavity.checked = myRender.IsGenCavity;
		checkbox_genWireRays.checked = myRender.IsGenWireRays;
		checkbox_genDirections.checked = myRender.IsGenDirections;
		checkbox_genRadiosityNormals.checked = myRender.IsGenRadiosityNormals;
		checkbox_useBakeHighpolyVCols.checked = myRender.IsUseBakeHighpolyVCols;
		checkbox_genCurv.checked = myRender.IsGenCurv;
		checkbox_genTranslu.checked = myRender.IsGenTranslu;
		checkbox_genDerivNM.checked = myRender.IsGenDerivNM;
		checkbox_forMax.checked = true;
		
		myName = getFilenameFile maxFileName;
		if myName == "" then myName = "Test";
		et_xNormalTexPath.Text = Winking_xNormal_gTexturePath + myName + ".TGA";
		
		callbacks.removeScripts id:#myNodeChangeCallBack;
		callbacks.addScript #selectionSetChanged "rol_xNormal.fnTIME_CALLBACK_NODE_SELECTION_CHANGE()" id:#myNodeChangeCallBack;
	)
	
	on checkbox_useAOReflector CheckedChanged arg do
	(
		local count;
		if checkbox_useAOReflector.checked and checkbox_useAO.checked then
		(
			count = myRender.GenAOReflectorNode();
			if count == 0 then
				messageBox "没有添加中模到场景，无法正确生产地板。"
		)else if checkbox_useAOReflector.checked == false then
		(
			myRender.DeleteAOReflectorNode();
		)
	)
	
	on et_xNormalOrderNum TextChanged sender arg do
	(
		if not (fnValidGroupName (et_xNormalOrderNum.Text)) then
		(
			MessageBox "输入不合法，请输入数字序号。" title:"输入不合法";
			et_xNormalOrderNum.Text = "1";
		)
		--else if (et_xNormalOrderNum.Text <= "z" and et_xNormalOrderNum.Text >= "a") then
		--(
		--	et_xNormalOrderNum.Text = fnLowerCase2UpperCase (et_xNormalOrderNum.Text);
		--)
	)
	
	on listbox_highPoly DoubleClick sender arg do
	(
		rol_xNormal.SelectTheSameIndexHighPolyList();
	)
	
	on btn_Navigate2ExePath click do
	(
		myPath = getOpenFileName  \
		caption:"xNormal Path" \
		filename:"xNormal.exe" \
		types:"EXE(*.exe)";
		
		if myPath != undefined then 
		(
			et_xNormalPath.text =  myPath;
			Winking_xNormal_g_xNormalPath = myPath;
		)
	)
	
	on checkbox_UseSceneHighPolys CheckedChanged arg do
	(
		Winking_xNormal_gLastUseSceneHighPoly = checkbox_UseSceneHighPolys.checked;
		myRender.fnClearHighPolyList();
		listbox_highPoly.Items.Clear();
		if Winking_xNormal_gLastUseSceneHighPoly then
		(
			btn_AddIntermediatePoly.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_addHiPoly.bmp"));
			Winking_xNormal_gLastHighPolyDirPath = Winking_xNormal_gTempFilePath + "HighPolys\\";
		)
		else
		(
			btn_AddIntermediatePoly.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_addMidPoly.bmp"));
		)
	)
	
	on btn_NumDown click do
	(
		Local Index = if et_xNormalOrderNum.Text == "0" then 0 else fnGetIndexByGroupName et_xNormalOrderNum.Text;
		
		for i=0 to (listbox_highPoly.Items.Count-1) do
		(
			if listbox_highPoly.GetSelected i then
			(
				myRender.fnUpdateHighPolyIndex (i+1) Index;
			)
		)
		
		for i=0 to (listbox_lowPoly.Items.Count-1) do
		(
			if listbox_lowPoly.GetSelected i then
			(
				myRender.fnUpdateLowPolyIndex (i+1) Index;
			)
		)
		
		myRender.fnSortLowPoly();
		myRender.fnSortHighPoly();
		
		SyncLowArrayData2UI();
		SyncHighArrayData2UI();
		
		et_xNormalOrderNum.Text = fnGetGroupName (Index + 1);
		myRender.fnSaveLast();
	)
	
	on btn_AddLowPoly click do
	(
		local LowPolyObj,lowItem;
		for LowPolyObj in selection do
		(
			if (not (myRender.fnHasLowPoly LowPolyObj)) and (not (myRender.fnHasHighPoly LowPolyObj)) then
			(
				lowItem = myRender.fnAddLowPoly LowPolyObj;
			)
		)
		SyncLowArrayData2UI();
		myRender.fnSaveLast();
	)
	
	on btn_Arrow click do
	(
		ReadLastHighPolyList();
		myRender.fnSaveLast();
	)
	
	on btn_AddIntermediatePoly click do
	(
		if (Winking_xNormal_gLastUseSceneHighPoly as BooleanClass) then
		(
			for o in selection do
			(
				if not (myRender.fnHasHighPoly o) then
				(
					highItem = myRender.fnAddHighPoly o;
					listbox_highPoly.Items.Add (highItem.fnBuildIndexedString());
				)
			)
			myRender.fnSaveLast();
		)
		else
		(
			try
			(
				destroyDialog rol_xNormal_HighPoly;
			)
			catch()
			createdialog rol_xNormal_HighPoly width:300 height:211 modal:true;
			setFocus rol_xNormal_HighPoly;
		)
	)
	
	on listbox_lowPoly KeyDown senderArg arg do
	(
		keys = dotNetClass "System.Windows.Forms.Keys"
		if arg.KeyCode == keys.Delete then
		(
			fnOnlistbox_lowPolyDelKey();
			myRender.fnSaveLast();
		)
	)
	
	on listbox_lowPoly DoubleClick sender arg do
	(
		rol_xNormal.SelectTheSameIndexLowPolyList();
	)
	
	on listbox_lowPoly MouseDown sender arg do
	(
		MouseButtons = dotNetClass "System.Windows.Forms.MouseButtons";
		if arg.Button == MouseButtons.Right then
		(
			popUpMenu RCLowPolyList;
		)
	)
	
	on listbox_highPoly KeyDown senderArg arg do
	(
		keys = dotNetClass "System.Windows.Forms.Keys"
		if arg.KeyCode == keys.Delete then
		(
			fnOnlistbox_highPolyDelKey();
			myRender.fnSaveLast();
		)
	)
	
	on listbox_highPoly MouseDown sender arg do
	(
		MouseButtons = dotNetClass "System.Windows.Forms.MouseButtons";
		if arg.Button == MouseButtons.Right then
		(
			popUpMenu RCHighPolyList;
		)	
	)
	
	on btn_SelectTexPath click do
	(
		myName = getFilenameFile maxFileName;
		if myName == "" then myName = "Test";
		myPath = getSaveFileName  \
		caption:"Output Texture Path" \
		filename:(Winking_xNormal_gTexturePath + myName) \
		types:"TGA Exporter(*.tga)|*.tga|JPG Exporter(*.jpg)|*.jpg|BMP Exporter(*.bmp)|*bmp|PNG Exporter(*.png)|*.png|";
		
		if myPath != undefined then 
		(
			et_xNormalTexPath.text =  myPath;
		)
	)
	
	on btn_genMaps click do
	(
		setFocus et_xNormalTexPath;
		btn_genMaps.enabled = false;
		if fnValidCheck() then
		(
			fnSyncArg();
			myRender.fnBatchRender (fnFindSelectedLowIndices()) (fnFindSelectedIndices());
			messagebox "渲染结束"
		)
		btn_genMaps.enabled = true;
	)
	
	on btn_BakeTest click do
	(
		TestBakeSelected();
	)
	
	on btn_ShowTex click do
	(
		myRender.fnAssignBatchMat();
	)
	
	on btn_Navigate2TexPath click do
	(
		TexturePathExportPath = getFilenamePath (et_xNormalTexPath.text);
		ShellLaunch TexturePathExportPath "";
	)
	
	on btn_Clean click do
	(
		rol_xNormal.CheckUpdateModifiedPoly();
	)
	
	on btn_Clean rightclick do
	(
		if queryBox "是否进行清空?" beep:false then
		(
			myRender.fnReset();
			listbox_lowPoly.items.Clear();
			listbox_highPoly.Items.Clear();
		)
	)
	
	on ddl_TextureWidth selected index do
	(
		ddl_TextureHeight.selection = index;
		
		if Winking_xNormal_gTextureParam[index] <= 512 then
			ddl_EdgePadding.selection = 2;
		if Winking_xNormal_gTextureParam[index] >= 1024 then
			ddl_EdgePadding.selection = 3;
		if Winking_xNormal_gTextureParam[index] >= 2048 then
			ddl_EdgePadding.selection = 4;
		if Winking_xNormal_gTextureParam[index] >= 4096 then
			ddl_EdgePadding.selection = 5;
	)
	
	on ddl_TextureHeight selected index do
	(
	)
	
	on btn_HelpFile click do
	(
	)
	
	function fnRestoreAllINIFileSettings =
	(
		fnINIFileSet_LastSettingFileName Winking_xNormal_gLastSettingFileName;
		fnINIFileSet_xNormalExcutablePath Winking_xNormal_g_xNormalPath;
		fnINIFileSet_LastLowPolyPath Winking_xNormal_gLastLowPolyPath;
		fnINIFileSet_LastIntermediatePolyPath Winking_xNormal_gLastIntermediatePolyDirPath;
		fnINIFileSet_LastHighPolyPath Winking_xNormal_gLastHighPolyDirPath;
		fnINIFileSet_LastEdgePadding (Winking_xNormal_gTextureParamEdgePaddingStr[ddl_EdgePadding.selection] as string);
		fnINIFileSet_LastUseSceneHighPoly (Winking_xNormal_gLastUseSceneHighPoly as string);
	)
	
	on rol_xNormal close do
	(
		try
		(
			destroyDialog rol_xNormal_HighPoly;
		)
		catch()
		fnRestoreAllINIFileSettings();
		callbacks.removeScripts id:#myNodeChangeCallBack;
	)