
rollout rol_xNormal_HighPoly "高模设置"
(
	local bLockPath = false;
	imgTag bmp_BigGB bitmap:(openBitMap (Winking_xNormal_gIconPath + "xNormal_bg_02.bmp")) enabled:false pos:[0,0];
	dotNetControl checkbox_LockPath "System.Windows.Forms.CheckBox" width:15 height:14 pos:[105,38];
	dotNetControl et_xNormalIntermediatePoly "System.Windows.Forms.TextBox" text:Winking_xNormal_gLastIntermediatePolyDirPath width:200 height:20 pos:[20,82] readOnly:true;
	imgTag btn_IntermediatePolyPath bitmap:(openBitMap (Winking_xNormal_gIconPath + "xNormal_btn_appointPath.bmp")) pos:[230,79]
	dotNetControl et_xNormalHighPoly "System.Windows.Forms.TextBox" text:Winking_xNormal_gLastHighPolyDirPath width:200 height:20 pos:[20,137] readOnly:true;
	imgTag btn_HighPolyPath bitmap:(openBitMap (Winking_xNormal_gIconPath + "xNormal_btn_appointPath.bmp")) pos:[230,134];
	imgTag btn_addHigh bitmap:(openBitMap (Winking_xNormal_gIconPath + "xNormal_btn_addHiPoly.bmp")) pos:[187,175];
	
	on et_xNormalIntermediatePoly TextChanged sender arg do
	(
		Winking_xNormal_gLastIntermediatePolyDirPath = et_xNormalIntermediatePoly.Text;
	)
	
	on et_xNormalHighPoly TextChanged sender arg do
	(
		Winking_xNormal_gLastHighPolyDirPath = et_xNormalHighPoly.Text;
	)
	
	on btn_IntermediatePolyPath click do
	(
		Winking_xNormal_gLastIntermediatePolyDirPath = getFilenamePath Winking_xNormal_gLastIntermediatePolyDirPath;
		--format "initialDir:%\n" Winking_xNormal_gLastIntermediatePolyDirPath;
		newPath = getSavePath caption:"设置中模读取路径" initialDir:(Winking_xNormal_gLastIntermediatePolyDirPath);
		if newPath != undefined then
		(
			et_xNormalIntermediatePoly.Text = Winking_xNormal_gLastIntermediatePolyDirPath = newPath + "\\";
		)
	)
	
	on btn_HighPolyPath click do
	(
		Winking_xNormal_gLastHighPolyDirPath = getFilenamePath Winking_xNormal_gLastHighPolyDirPath;
		--format "initialDir:%\n" Winking_xNormal_gLastHighPolyDirPath;
		newPath = getSavePath caption:"设置高模读取路径" initialDir:(Winking_xNormal_gLastHighPolyDirPath);
		if newPath != undefined then
		(
			et_xNormalHighPoly.Text = Winking_xNormal_gLastHighPolyDirPath = newPath + "\\";
		)
	)
	
	on checkbox_LockPath CheckedChanged arg do
	(
		if checkbox_LockPath.checked then
		(
			et_xNormalHighPoly.Enabled = false;
			btn_HighPolyPath.Enabled = false;
			bLockPath = true;
		)
		else
		(
			et_xNormalHighPoly.Enabled = true;
			btn_HighPolyPath.Enabled = true;
			bLockPath = false;
		)
	)
	
	on btn_addHigh click do
	(
		try
		(
			destroyDialog rol_xNormal_HighPoly;
		)
		catch()
		if Winking_xNormal_gLastIntermediatePolyDirPath[Winking_xNormal_gLastIntermediatePolyDirPath.count] != "\\" then
			Winking_xNormal_gLastIntermediatePolyDirPath += "\\";
		if Winking_xNormal_gLastHighPolyDirPath[Winking_xNormal_gLastHighPolyDirPath.count] != "\\" then
			Winking_xNormal_gLastHighPolyDirPath += "\\";
		if bLockPath then
		(
			Winking_xNormal_gLastHighPolyDirPath = Winking_xNormal_gLastIntermediatePolyDirPath;
		)
		rol_xNormal.CheckUpdateModifiedPoly();
		rol_xNormal.myRender.fnSaveLast();
	)
)

rollout rol_xNormal "Winking-xNormal For Max beta"
(
	local myRender = BatchRender();
	--local copiedItems = #();
	local isUITriggeredSelectionChange = false;

	imgTag bmp_BigBG bitmap:(openBitMap (Winking_xNormal_gIconPath + "xNormal_bg.bmp")) enabled:false pos:[0,0];
	---------------------------------------------step1---------------------------------------------------
	dotNetControl et_xNormalPath "System.Windows.Forms.TextBox" text:Winking_xNormal_g_xNormalPath width:200 height:20 pos:[20,147] readOnly:true;
	imgTag btn_Navigate2ExePath bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_appointPath.bmp")) pos:[225,143] \
		tooltip:"  浏览 xNormal 安装路径，指定 xNormal 启动文件。 ";
	dotNetControl checkbox_UseSceneHighPolys "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[120, 207];
	dotNetControl et_xNormalOrderNum "System.Windows.Forms.TextBox" Text:"1" Width:22 height:20 Pos:[232, 202];
	imgTag btn_NumDown bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_changePrefix.bmp")) Pos:[255, 198] \
		tooltip:"  添加烘焙序号到选择行。 ";
	--imgTag btn_AddHighPoly bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_addHiPoly.bmp")) Pos:[177,198] \
	--	tooltip:"  添加场景中的高模到列表窗口。 ";
	dotNetControl listbox_lowPoly "System.Windows.Forms.ListBox" Width:112 Height:226 Pos:[25, 231];
	imgTag btn_Arrow bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_refresh.bmp")) Pos:[140,230]	\
		tooltip:"  读取最后一次高低模型列表。 ";
	dotNetControl listbox_highPoly "System.Windows.Forms.ListBox" Width:112 Height:226 Pos:[162, 231];
	imgTag btn_AddLowPoly bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_pickLowPoly.bmp")) Pos:[42,465] \
		tooltip:"  添加低模到列表窗口。 ";
	imgTag btn_Clean bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_delMesh.png")) transparent:(color 255 255 255) Pos:[135,465] \
		tooltip:"  左键更新右键清除列表中全部数据。 ";
	imgTag btn_AddIntermediatePoly bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_addMidPoly.bmp")) Pos:[177,465] \
		tooltip:"  添加中模到列表窗口。 ";
	dotNetControl et_xNormalTexPath "System.Windows.Forms.TextBox" width:200 height:20  pos:[20,535] readOnly:true;
	dotNetControl checkbox_useAOReflector "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[25, 556];
	dotNetControl checkbox_useAO "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[150, 556];
	dotNetControl checkbox_genNormal "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[210, 556];
	imgTag btn_SelectTexPath bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_appointPath.bmp")) pos:[230,530] \
		tooltip:"  浏览 Bake 贴图路径。";
	DropDownList ddl_TextureWidth items:Winking_xNormal_gTextureParamStr selection:6 width:65 pos:[25,593];
	DropDownList ddl_TextureHeight items:Winking_xNormal_gTextureParamStr selection:6 width:65 pos:[97,593];
	DropDownList ddl_Antialising items:Winking_xNormal_gTextureParamAntialisingStr selection:3 width:40 pos:[170,593];
	DropDownList ddl_EdgePadding items:Winking_xNormal_gTextureParamEdgePaddingStr selection:3 width:40 pos:[233,593];
	dotNetControl checkbox_forMax "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[25, 620];
	dotNetControl checkbox_forMaya "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[111, 620];
	colorpicker cp_NormalBG color:(color 128 128 255) width:25 height:15 pos:[250,618];
	imgTag btn_BakeTest bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_test_bakeTex.bmp")) pos:[100,655];
	imgTag btn_genMaps bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_bakeTex.bmp")) transparent:(color 255 255 255) pos:[15,646];
	imgTag btn_ShowTex bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_showTex.bmp")) pos:[180,659] \
		tooltip:"  高质量显示贴图。";
	imgTag btn_Navigate2TexPath bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_browse.bmp")) pos:[170,689] \
		tooltip:"  浏览贴图。";
	imgTag btn_HelpFile bitmap:(openBitMap  (Winking_xNormal_gIconPath + "xNormal_btn_help.bmp")) transparent:(color 255 255 255) pos:[260,676];
	
	--mooton mofify
	
	dotNetControl checkbox_genHeights "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[25, 5];
	dotNetControl checkbox_genBent "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[85, 5];
	dotNetControl checkbox_genPRT "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[145, 5];
	dotNetControl checkbox_genConvexity "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[205, 5];
	dotNetControl checkbox_genThickness "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[25, 40];
	dotNetControl checkbox_genProximity "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[85, 40];
	dotNetControl checkbox_genCavity "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[145, 40];
	dotNetControl checkbox_genWireRays "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[205, 40];
	dotNetControl checkbox_genDirections "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[25, 75];
	dotNetControl checkbox_genRadiosityNormals "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[85, 75];
	dotNetControl checkbox_useBakeHighpolyVCols "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[145, 75];
	dotNetControl checkbox_genCurv "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[205, 75];
	dotNetControl checkbox_genTranslu "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[25, 110];
	dotNetControl checkbox_genDerivNM "System.Windows.Forms.CheckBox" width:15 height:14 Pos:[145, 110];
	
	
	include "xNormal/lib/UILib_Functions.ms"
	
	include "xNormal/lib/UILib_Appearance.ms"
	
	include "xNormal/lib/UILib_Handlers.ms"
)