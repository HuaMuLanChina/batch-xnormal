struct AO_Reflector
(
	ReflectorNode,
	ReflectorPath,
	function fnGenReflector nodes =
	(
		local Mins = #(), Maxs = #();
		local aabb,minn,maxx,width,hight,ReflectorPosition;
		local xMin,xMax,yMin,yMax,zMin;
		
		for node in nodes do
		(
			aabb = nodeLocalBoundingBox node;
			append Mins aabb[1];
			append Maxs aabb[2];
		)
		
		xMin = Mins[1].x;
		yMin = Mins[1].y;
		zMin = Mins[1].z;
		for minn in Mins do
		(
			if minn.x < xMin then
				xMin = minn.x;
			if minn.y < yMin then
				yMin = minn.y;
			if minn.z < zMin then
				zMin = minn.z;
		)
		
		xMax = Maxs[1].x;
		yMax = Maxs[1].y;
		for maxx in Maxs do
		(
			if maxx.x > xMax then
				xMax = maxx.x;
			if maxx.y > yMax then
				yMax = maxx.y;
		)
		
		width = (xMax - xMin)*2;
		hight = (yMax - yMin)*2;
		ReflectorPosition = [0.0,0.0,zMin - 0.1];
		
		ReflectorNode = Plane pos:ReflectorPosition widthsegs:1 lengthsegs:1 width:width length:hight;

		ReflectorPath = Winking_xNormal_gLowPolyDirPath + "Reflector.obj";
		ReflectorNode;
	),
	
	function DelAOReflector =
	(
		if ReflectorNode != undefined and not (isDeleted ReflectorNode) then
		(
			delete ReflectorNode;
			ReflectorNode = undefined;
		)
	),
	
	function Export =
	(
		if ReflectorNode != undefined and not (isDeleted ReflectorNode) and ReflectorPath != undefined then
			fnExportObj ReflectorNode ReflectorPath;
		return ReflectorPath;
	)
)