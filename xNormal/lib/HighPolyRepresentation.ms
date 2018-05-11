struct HighPolyTriKeyItem
(
	K1, K2, K3,
	
	Function fnSameFile pHighPolyTriKeyItem =
	(
		return K3.FullFileName == pHighPolyTriKeyItem.K3.FullFileName;
	),
	
	Function fnBuildIntermediatePolyPath =
	(
		local myname,mypath;
		myname = filenameFromPath K3.FullFileName;
		mypath = Winking_xNormal_gLastIntermediatePolyDirPath + myname;
		return mypath;
	),
	
	--- fnHasIntermeditaFie() check before Importing
	Function fnImportMyFile =
	(
		local oldNode, IntermediatePath, importedIntermediatePoly;
		oldNode = K2;
		if oldNode != undefined then
			delete oldNode;
		IntermediatePath = fnBuildIntermediatePolyPath();
		importedIntermediatePoly = fnImportObj IntermediatePath;
		K2 = importedIntermediatePoly;
		K3.fnUpdateModData();
	),
	
	Function fnBuildIndexedString =
	(
		Local GroupName = fnGetGroupName K1;
		if K1 == 0 then
		(
			"--" + K1 as string + "--\t" + K2.name + "\t" + K3.fnGetFileName();
		)
		else
		(
			"--" + GroupName + "--\t" + K2.name + "\t" + K3.fnGetFileName();
		)
	),
	
	Function fnBuildDuplicatedIndexedString =
	(
		Local GroupName = fnGetGroupName K1;
		if K1 == 0 then
		(
			"-[" + K1 as string + "]-\t" + K2.name + K3.fnGetFileName();
		)
		else
		(
			"-[" + GroupName + "]-\t" + K2.name + K3.fnGetFileName();
		)
	)
);

struct HighPolyRep
(
	private
		mTriItemCollection = TriItemCollection(),
		
	Function MyFindItem pItem =
	(
		local index = 0;
		for i=1 to mTriItemCollection.fnCount() do
		(
			myItem = mTriItemCollection.fnGet i;
			if pItem.fnSameFile myItem then
				index = i;
		)
		
		return index;
	),
	
	Function FindAddedNewObj pCurrentArray =
	(
		local myArrayObj, index, objFound = #();
		for myArrayObj in pCurrentArray do
		(
			index = MyFindItem myArrayObj;
			if index == 0 then
			(
				append objFound myArrayObj;
			)
		)
		objFound;
	),
	
	Function fnWriteSub pFile =
	(
		local triItem,i;
		
		for i = 1 to mTriItemCollection.fnCount() do
		(
			triItem = mTriItemCollection.fnGet i;
			format "HighPolyTriKeyItem K1:% K2:\"%\" K3:(PhsicalFileStruct fullFileName:@\"%\");\n" triItem.K1 triItem.K2.name triItem.K3.fullFileName to:pFile;
		)
	),
	
	Function fnParseDataStr pStr =
	(
		local exeStr,nodeName,throwStr;
		exeStr = "Winking_xNormal_gInterChangeData = " + pStr;
		execute exeStr;
		nodeName = Winking_xNormal_gInterChangeData.K2
		Winking_xNormal_gInterChangeData.K2 = getNodeByName Winking_xNormal_gInterChangeData.K2;
		if Winking_xNormal_gInterChangeData.K2 == undefined then
		(
			throwStr = "模型" + nodeName + "没有被找到!?";
			throw throwStr;
		)
		mTriItemCollection.fnAdd Winking_xNormal_gInterChangeData;
	),
	
	Function fnReadSub pFile =
	(
		local newline;
		while not (eof pFile) do
		(
			newline = readLine pFile;
			if (newline[1] == ".") then
			(
				exit;
			)
			fnParseDataStr newline;
		)
	),
	
	Function fnCompareFN p1 p2=
	(
		case of
		(
			(p1.K1 < p2.K1):-1
			(p1.K1 > p2.K1):1
			default:0
		)
	),
	
	public
	Function fnAdd pIndexedObj =
	(
		mTriItemCollection.fnAdd pIndexedObj;
	),
	
	Function fnCount =
	(
		mTriItemCollection.fnCount();
	),
	
	Function fnGet pIndex =
	(
		mTriItemCollection.fnGet pIndex;
	),
	
	Function fnRemove pIndex =
	(
		mTriItemCollection.fnRemove pIndex;
	),
	
	Function fnInsert pNewItem pIndex =
	(
		mTriItemCollection.fnInsert pNewItem pIndex;
	),
	
	Function fnClear =
	(
		mTriItemCollection.fnClear();
	),
	
	Function fnDeleteAllAndClear =
	(
		for i = 1 to mTriItemCollection.fnCount() do
		(
			triItem = mTriItemCollection.fnGet i;
			delete triItem.K2;
		)
		
		fnClear();
	),
	
	Function fnUpdateK1 pIndex pK1 =
	(
		mTriItemCollection.fnUpdateK1 pIndex pK1;
	),
	
	Function fnUpdateK2 pIndex pK2 =
	(
		mTriItemCollection.fnUpdateK2 pIndex pK2;
	),
	
	Function fnUpdateK3 pIndex pK3 =
	(
		mTriItemCollection.fnUpdateK3 pIndex pK3;
	),
	
	Function fnDuplicate pIndex to2:undefined =
	(
		mTriItemCollection.fnDuplicate pIndex to2:to2;
	),
	
	Function fnFindPostionByK1 pK1 =
	(
		return mTriItemCollection.fnFindPostionByK1 pK1;
	),
	
	Function fnFindPostionsByK1 pK1 =
	(
		return mTriItemCollection.fnFindPostionsByK1 pK1;
	),
	
	Function fnFindItemByK1 pK1 =
	(
		return mTriItemCollection.fnFindItemByK1 pK1;
	),
	
	Function fnFindItemsByK1 pK1 =
	(
		return mTriItemCollection.fnFindItemsByK1 pK1;
	),
	
	Function fnFindItemsByK1WithRestriction pRestrictionPositions pK1 =
	(
		return mTriItemCollection.fnFindItemsByK1WithRestriction pRestrictionPositions pK1;
	),
	
	Function fnFindPostionByK2 pK2 =
	(
		return mTriItemCollection.fnFindPostionByK2 pK2;
	),
	
	Function fnFindItemByK2 pK2 =
	(
		return mTriItemCollection.fnFindItemByK2 pK2;
	),
	
	Function fnFindItemsByK2 pK2 =
	(
		return mTriItemCollection.fnFindItemsByK2 pK2;
	),
	
	Function fnFindPostionByK3 pK3 =
	(
		return mTriItemCollection.fnFindPostionByK3 pK3;
	),
	
	Function fnFindItemByK3 pK3 =
	(
		return mTriItemCollection.fnFindItemByK3 pK3;
	),
	
	Function fnFindItemsByK3 pK3 =
	(
		return mTriItemCollection.fnFindItemsByK3 pK3;
	),
	
	Function fnCollectK2 =
	(
		return mTriItemCollection.fnCollectK2();
	),
	
	Function fnCollectK3 =
	(
		return mTriItemCollection.fnCollectK3();
	),
	
	Function fnSort =
	(
		mTriItemCollection.fnSort pCompareFN:fnCompareFN;
	),
	
------------------------------------------------------------------extendingFunctions------------------------------------------------
	private
	Function fnRelocateHighPoly =
	(
		local Index,HighItem,oldPath;
		
		for Index = 1 to mTriItemCollection.fnCount() do
		(
			HighItem = mTriItemCollection.fnGet Index;
			--先更新看看以前有没有修改，然后再重新定位新的高模地址。
			if HighItem.K3.fnGetFilenamePath() != (Winking_xNormal_gLastHighPolyDirPath as string) then
			(
				oldPath = HighItem.K3.FullFileName;
				HighItem.K3.fnRelocate Winking_xNormal_gLastHighPolyDirPath;
				--假设先更新，这里就不用重新导入了。
				--HighItem.fnImportMyFile();
				format "% Updata File from:% to:%;\n" Winking_xNormal_g_xNormalNotePrefix oldPath HighItem.K3.FullFileName;
			)
		)
	),
	
	Function fnUpdateChangedHighPoly =
	(
		local Index,HighItem;
		
		for Index = 1 to mTriItemCollection.fnCount() do
		(
			HighItem = mTriItemCollection.fnGet Index;
			
			if HighItem.K3.fnHasFileBeenModified() then
			(
				HighItem.fnImportMyFile();
				format "% Updata File %;\n" Winking_xNormal_g_xNormalNotePrefix HighItem.K3.FullFileName;
			)
		)
	),
	
	Function fnUpdateNewAddedNewObj =
	(
		local index,extension = undefined,highItem = undefined,highPoly = undefined,IndexedHighList = undefined,IntermediatePoly = undefined;
		local currentIndexedHighPolyPathArray = #(), differentObjs = #();
		local HighPolyPaths = getFiles (Winking_xNormal_gLastHighPolyDirPath + "*.obj");
		local IntermediatePolyPaths = getFiles (Winking_xNormal_gLastIntermediatePolyDirPath + "*.obj");
		local msg;

		for IntermediatePoly in IntermediatePolyPaths do
		(
			extension = getFilenameType IntermediatePoly;
			if extension.count == 4 then
			(
				highPoly = Winking_xNormal_gLastHighPolyDirPath + (filenameFromPath IntermediatePoly);
				index = findItem HighPolyPaths highPoly;
				if index > 0 then
				(
					highItem = HighPolyTriKeyItem K1:0 K3:(PhsicalFileStruct FullFileName:(HighPolyPaths[index]));
					append currentIndexedHighPolyPathArray highItem;
				)
				else
				(
					msg = "缺失对应高模文件" + (filenameFromPath IntermediatePoly);
					throw msg;
				)
			)
		)
		
		if mTriItemCollection.fnCount() < currentIndexedHighPolyPathArray.count then
		(
			differentObjs = FindAddedNewObj currentIndexedHighPolyPathArray;
			
			for highItem in differentObjs do
			(
				highItem.fnImportMyFile();
				mTriItemCollection.fnAdd highItem;
			)
		)
	),
	public
	Function fnCheck =
	(
		local Index,HighItem,msg,rel = true;
		
		for Index = 1 to mTriItemCollection.fnCount() do
		(
			HighItem = mTriItemCollection.fnGet Index;
			if not (doesFileExist HighItem.K3.FullFileName) then
			(
				fnExportHigh HighItem.K2 HighItem.K3.FullFileName;
				HighItem.K3.fnUpdateModData();
			)
		)
		
		return rel;
	),
	
	Function fnUpdateChangedFiles pChangeUpdate pAddingUpdate =
	(
		if pChangeUpdate then 
			fnUpdateChangedHighPoly();
		if pAddingUpdate then
			fnUpdateNewAddedNewObj();
		--先更新看看以前有没有修改，然后再重新定位新的高模地址。
		fnRelocateHighPoly();
	),
	
	Function fnWriteSection pFile =
	(
		fnWriteSub pFile;
		format ".\n" to:pFile;
	),
	
	Function fnReadSection pFile =
	(
		fnReadSub pFile;
	),
	
	Function fnDebugPrint =
	(
		format "-----HighPolyRep-----\n";
		mTriItemCollection.fnDebugPrint();
	)
)