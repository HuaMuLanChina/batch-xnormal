-- By Hua(xu.sun RD63)
-- "2012/10/24"

--struct IndexedObj (Index, Obj, File);-- for low poly related data, inode.Handle for obj;
--struct LowPolyRepresentation-- array of low poly datas;

struct TriKeyItem(K1, K2, K3);
struct TriItemCollection
(
	private
	TriKeyItemArray = #(),
	
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
		append TriKeyItemArray pIndexedObj;
	),
	
	Function fnCount =
	(
		TriKeyItemArray.count;
	),
	
	Function fnGet pIndex =
	(
		TriKeyItemArray[pIndex];
	),
	
	Function fnRemove pIndex =
	(
		deleteItem TriKeyItemArray pIndex;
	),
	
	Function fnInsert pNewItem pIndex =
	(
		insertItem pNewItem TriKeyItemArray pIndex;
	),
	
	Function fnClear =
	(
		TriKeyItemArray = #();
	),
	
	Function fnGetData =
	(
		return TriKeyItemArray;
	),
	
	Function fnUpdateK1 pIndex pK1 =
	(
		TriKeyItemArray[pIndex].K1 = pK1;
	),
	
	Function fnUpdateK2 pIndex pK2 =
	(
		TriKeyItemArray[pIndex].K2 = pK2;
	),
	
	Function fnUpdateK3 pIndex pK3 =
	(
		TriKeyItemArray[pIndex].K3 = pK3;
	),
	
	Function fnDuplicate pIndex to2:undefined =
	(
		local newItem = copy TriKeyItemArray[pIndex];
		if to2 == undefined then
			insertItem newItem TriKeyItemArray (pIndex + 1);
		else
			insertItem newItem TriKeyItemArray to2;
		newItem;
	),
	
	Function fnFindPostionByK1 pK1 =
	(
		local index, item, rel = -1;
		
		for index = 1 to TriKeyItemArray.count do
		(
			item = TriKeyItemArray[index];
			if item.K1 == pK1 then
			(
				rel = index;
				exit;
			)
		)
		
		return rel;
	),
	
	Function fnFindPostionsByK1 pK1 =
	(
		local index, item, rel = #();
		
		for index = 1 to TriKeyItemArray.count do
		(
			item = TriKeyItemArray[index];
			if item.K1 == pK1 then
			(
				append rel index;
			)
		)
		
		return rel;
	),
	
	Function fnFindItemByK1 pK1 =
	(
		local item,rel;
		for item in TriKeyItemArray do
		(
			if item.K1 == pK1 then
			(
				rel = item;
				exit;
			)
		)
		
		return rel;
	),
	
	Function fnFindItemsByK1 pK1 =
	(
		local item,rel =#();
		for item in TriKeyItemArray do
		(
			if item.K1 == pK1 then
			(
				append rel item;
			)
		)
		
		return rel;
	),
	
	Function fnFindItemsByK1WithRestriction pRestrictionPositions pK1 =
	(
		local index, item, rel =#();
		for index in pRestrictionPositions do
		(
			item = TriKeyItemArray[index];
			if item.K1 == pK1 then
					append rel item;
		)
		
		return rel;
	),
	
	Function fnFindPostionByK2 pK2 =
	(
		local index, item, rel = -1;
		
		for index = 1 to TriKeyItemArray.count do
		(
			item = TriKeyItemArray[index];
			if item.K2 == pK2 then
			(
				rel = index;
				exit;
			)
		)
		
		return rel;
	),
	
	Function fnFindItemByK2 pK2 =
	(
		local item,rel;
		for item in TriKeyItemArray do
		(
			if item.K2 == pK2 then
			(
				rel = item;
				exit;
			)
		)
		
		return rel;
	),
	
	Function fnFindItemsByK2 pK2 =
	(
		local item,rel = #();
		for item in TriKeyItemArray do
		(
			if item.K2 == pK2 then
			(
				append rel item;
			)
		)
		
		return rel;
	),
	
	Function fnFindPostionByK3 pK3 =
	(
		local index, item, rel = -1;
		
		for index = 1 to TriKeyItemArray.count do
		(
			item = TriKeyItemArray[index];
			if item.K3 == pK3 then
			(
				rel = index;
				exit;
			)
		)
		
		return rel;
	),
	
	Function fnFindItemByK3 pK3 =
	(
		local item,rel;
		for item in TriKeyItemArray do
		(
			if item.K3 == pK3 then
			(
				rel = item;
				exit;
			)
		)
		
		return rel;
	),
	
	Function fnFindItemsByK3 pK3 =
	(
		local item,rel =#();
		for item in TriKeyItemArray do
		(
			if item.K3 == pK3 then
			(
				append rel item;
			)
		)
		
		return rel;
	),
	
	Function fnCollectK2 =
	(
		local K2Set = #();
		for item in TriKeyItemArray do
		(
			append K2Set item.K2;
		)
		
		return K2Set;
	),
	
	Function fnCollectK3 =
	(
		local K3Set = #();
		for item in TriKeyItemArray do
		(
			append K3Set item.K3;
		)
		
		return K3Set;
	),
	
	Function fnSort pCompareFN:undefined =
	(
		if pCompareFN == undefined then
			qsort TriKeyItemArray fnCompareFN;
		else
			qsort TriKeyItemArray pCompareFN;
	),
	
	private
	
	Function fnParseDataStr pStr =
	(
		exeStr = "Winking_xNormal_gInterChangeData = " + pStr;
		execute exeStr;
		Winking_xNormal_gInterChangeData.K2 = maxOps.getNodeByHandle Winking_xNormal_gInterChangeData.K2;
		fnAdd Winking_xNormal_gInterChangeData;
	),
	
	Function fnWriteSub pFile =
	(
		for triItem in TriKeyItemArray do
		(
			if triItem.K3 != undefined then
				format "LowPolyTriKeyItem K1:% K2:% K3:(PhsicalFileStruct fullFileName:@\"%\");\n" triItem.K1 triItem.K2.inode.handle triItem.K3.fullFileName to:pFile;
			else
				format "LowPolyTriKeyItem K1:% K2:% K3:%;\n" triItem.K1 triItem.K2.inode.handle triItem.K3 to:pFile;
		)
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
	
	public
	Function fnWriteSection pFile=
	(
		fnWriteSub pFile;
		format ".\n" to:pFile;
	),
	
	Function fnReadSection pFile =
	(
		fnClear();
		fnReadSub pFile;
	),
	
	Function fnDebugPrint =
	(
		local item;
		for item in TriKeyItemArray do
		(
			format "TriKeyItem K1:% K2:% K3:%;\n" item.K1 item.K2 item.K3;
		)
	)
);