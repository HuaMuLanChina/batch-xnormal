-- By Hua(xu.sun RD63)
-- "2012/10/24"

struct Pair(K1, K2);
struct PairVector
(
	pairArray = #(),
	
	Function count =
	(
		return pairArray.count;
	),
	
	Function get pIndex =
	(
		return pairArray[pIndex];
	),
	
	Function Add pPair =
	(
		append pairArray pPair;
	), 
	
	Function Remove pIndex =
	(
		deleteItem pairArray pIndex;
	),
	
	Function CopyItem pIndex =
	(
		local newItem = copy pairArray[pIndex];
		insertItem newItem pairArray (pIndex + 1);
		newItem;
	),
	
	Function K1_2_K2 pK1 =
	(
		result = undefined;
		for pair in pairArray do
		(
			if pair.K1 == pK1 then
				result = pair.K2;
		)
		
		return result;
	),
	
	Function K2_2_K1 pK2 =
	(
		result = undefined;
		for pair in pairArray do
		(
			if pair.K2 == pK2 then
				result = pair.K1;
		)
		
		return result;
	),
	
	Function SetK1ByK2 pK2 pK1 =
	(
		for pair in pairArray do
		(
			if pair.K2 == pK2 then
				pair.K1 = pK1;
		)
	),
	
	Function SetK2ByK1 pK1 pK2 =
	(
		for pair in pairArray do
		(
			if pair.K1 == pK1 then
				pair.K2 = pK2;
		)
	),
	
	Function Clear =
	(
		pairArray = #();
	),
	
	Function DebugPrint =
	(
		for pair in pairArray do
		(
			format "Pair K1:% K2:\"%\"\n" pair.K1 pair.K2;
		)
	),
	
	------------------------------------------------------external file read&write--------------------------------------------------
	Function ParseDataStr pStr =
	(
		exeStr = "Winking_xNormal_gInterChangeData = " + pStr;
		execute exeStr;
		Winking_xNormal_gInterChangeData.K1 = getNodeByName Winking_xNormal_gInterChangeData.K1;
		Add Winking_xNormal_gInterChangeData;
	),
	
	Function writeSub pFile =
	(
		for pair in pairArray do
		(
			format "Pair K1:\"%\" K2:@\"%\";\n" pair.K1.name pair.K2 to:pFile;
		)
	),
	
	Function readSub pFile =
	(
		while not(eof pFile) do
		(
			newline = readLine pFile;
			ParseDataStr newline;
		)
	),
	
	Function Write pPath =
	(
		pFile = openFile pPath mode:"w";
		writeSub pFile;
		close pFile;
	),
	
	Function Read pPath =
	(
		Clear();
		pFile = openFile pPath mode:"r";
		readSub pFile;
		close pFile;
	)
)