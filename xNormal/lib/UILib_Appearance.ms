-----------------------------------------------appearance-------------------------------------------------
	on btn_Navigate2ExePath mouseout do
	(
		btn_Navigate2ExePath.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_appointPath.bmp"));
	)
	
	on btn_Navigate2ExePath mouseover do
	(
		btn_Navigate2ExePath.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_appointPath_down.bmp"));
	)
	
	on btn_NumDown mouseout do
	(
		btn_NumDown.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_changePrefix.bmp"));
	)
	
	on btn_NumDown mouseover do
	(
		btn_NumDown.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_changePrefix_down.bmp"));
	)
	
	on btn_AddLowPoly mouseout do
	(
		btn_AddLowPoly.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_pickLowPoly.bmp"));
	)
	
	on btn_AddLowPoly mouseover do
	(
		btn_AddLowPoly.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_pickLowPoly_down.bmp"));
	)
	
	--on btn_AddHighPoly mouseout do
	--(
	--	btn_AddHighPoly.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_addHiPoly.bmp"));
	--)
	
	--on btn_AddHighPoly mouseover do
	--(
	--	btn_AddHighPoly.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_addHiPoly_down.bmp"));
	--)
	
	on btn_Arrow mouseout do
	(
		btn_Arrow.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_refresh.bmp"));
	)
	
	on btn_Arrow mouseover do
	(
		btn_Arrow.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_refresh_down.bmp"));
	)
	
	on btn_AddIntermediatePoly mouseout do
	(
		if (Winking_xNormal_gLastUseSceneHighPoly as BooleanClass) then
		(
			btn_AddIntermediatePoly.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_addHiPoly.bmp"));
		)
		else
		(
			btn_AddIntermediatePoly.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_addMidPoly.bmp"));
		)
	)
	
	on btn_AddIntermediatePoly mouseover do
	(
		if (Winking_xNormal_gLastUseSceneHighPoly as BooleanClass) then
		(
			btn_AddIntermediatePoly.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_addHiPoly_down.bmp"));
		)
		else
		(
			btn_AddIntermediatePoly.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_addMidPoly_down.bmp"));
		)
	)
	
	on btn_SelectTexPath mouseout do
	(
		btn_SelectTexPath.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_appointPath.bmp"));
	)
	
	on btn_SelectTexPath mouseover do
	(
		btn_SelectTexPath.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_appointPath_down.bmp"));
	)
	
	on btn_genMaps mouseout do
	(
		btn_genMaps.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_bakeTex.bmp"));
	)
	
	on btn_genMaps mouseover do
	(
		btn_genMaps.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_bakeTex_down.bmp"));
	)
	
	on btn_BakeTest mouseout do
	(
		btn_BakeTest.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_test_bakeTex.bmp"));
	)
	
	on btn_BakeTest mouseover do
	(
		btn_BakeTest.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_test_bakeTex_down.bmp"));
	)
	
	on btn_ShowTex mouseout do
	(
		btn_ShowTex.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_showTex.bmp"));
	)
	
	on btn_ShowTex mouseover do
	(
		btn_ShowTex.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_showTex_down.bmp"));
	)
	
	on btn_Navigate2TexPath mouseout do
	(
		btn_Navigate2TexPath.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_browse.bmp"));
	)
	
	on btn_Navigate2TexPath mouseover do
	(
		btn_Navigate2TexPath.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_browse_down.bmp"));
	)
	
	on btn_Clean mouseout do
	(
		btn_Clean.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_delMesh.png"));
	)
	
	on btn_Clean mouseover do
	(
		btn_Clean.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_delMesh_down.png"));
	)
	
	on btn_HelpFile mouseout do
	(
		btn_HelpFile.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_help.bmp"));
	)
	
	on btn_HelpFile mouseover do
	(
		btn_HelpFile.bitmap = openbitmap((Winking_xNormal_gIconPath + "xNormal_btn_help_down.bmp"));
	)