struct TestBake
(
	BakedObj,
	Width,
	Height,
	EdgePadding,
	OutPath,
	
	function GetMinLength =
	(
		if Width > Height then Height else Width;
	),
	
	function GetReferredObjs =
	(
		ReferredHighPolys = #();
		for o in Geometry do
		(
			if o != BakedObj and o.isHidden == false then
			(
				append ReferredHighPolys o;
			)
		)
		
		return ReferredHighPolys;
	),
	
	function SetupProjectionSub pReferredHighPolys =
	(
		local proMod = fnAddProjectionModifier BakedObj pReferredHighPolys;
		proMod.displayCage = true;
		proMod.displayCageShaded = true;
		proMod.displayCageOffset = true;
	),
	
	function SetupProjection pReferredHighPolys =
	(
		if not (fnCheckIfHasCageAndEditMeshModifier BakedObj false) then
		(
			SetupProjectionSub pReferredHighPolys;
		)
	),
	
	function RenderSetup =
	(
		autoBackup.enabled=false;
		renderers.current = Default_Scanline_Renderer();
		scanlineRender.antiAliasing=false;
		scanlineRender.filterMaps=false;
		scanlineRender.antiAliasFilter=Area();
		renderers.production.globalSamplerEnabled=false;
	),
	
	function Setup =
	(
		ReferredHighPolys = GetReferredObjs();
		SetupProjection ReferredHighPolys;
	),
	
	function Test = 
	(
		local minLength = GetMinLength();
		RenderSetup();
		
		--Clear all render elements  

		BakedObj.iNodeBakeProperties.removeAllBakeElements();  

		--Preparing the Bake Elements:

		myBakeCompleteMap = CompleteMap(); -- instance of the bake element class

		--set the size of the baked map
		myBakeCompleteMap.outputSzX = minLength;
		myBakeCompleteMap.outputSzY = minLength;

		--specify the full file path, name and type:

		myBakeCompleteMap.fileType = OutPath;

		myBakeCompleteMap.fileName = filenameFromPath myBakeCompleteMap.fileType;

		myBakeCompleteMap.filterOn = true; --enable filtering 

		myBakeCompleteMap.shadowsOn =true; --enable shadows

		myBakeCompleteMap.enabled = true; --enable baking

		 

		--Preparing the pBakedObject for baking:

		BakedObj.INodeBakeProperties.addBakeElement myBakeCompleteMap; --add second element

		BakedObj.INodeBakeProperties.bakeEnabled = true; --enabling baking

		BakedObj.INodeBakeProperties.bakeChannel = 1; --channel to bake

		BakedObj.INodeBakeProperties.nDilations = EdgePadding; --expand the texture a bit

		BakedObj.INodeBakeProjProperties.enabled = true;
		
		select BakedObj; --we are baking the selection, so we select the pBakedObject

		--Call the renderer to bake both elements: 
		
		macros.run "Render" "BakeDialog";
		
		try(destroyDialog gTextureBakeDialog)catch()

		render rendertype:#bakeSelected vfb:on progressBar:false outputSize:[minLength,minLength];
	)
);
