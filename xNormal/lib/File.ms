Struct PhsicalFileStruct
(
	public
	-- because on create calls fnLoadModData and LoadModDat needs FullFileName to be initialised so this data member should declared before LoadModData; I don't readlly know why:P
	FullFileName,
	
	private
	FileModDate,
	
	function fnLoadModData =
	(
		if doesFileExist FullFileName then
			FileModDate = getFileModDate FullFileName;
	),
	on create do
	(
		fnLoadModData();
	),
	public
	function fnGetFileName =
	(
		filenameFromPath FullFileName;
	),
	
	function fnGetFilenameFile =
	(
		GetFilenameFile FullFileName;
	),
	
	function fnGetFilenamePath =
	(
		getFilenamePath FullFileName;
	),
	
	function fnGetFileExtensionString =
	(
		getFilenameType FullFileName;
	),
	
	function fnGetModData =
	(
		return FileModDate;
	),
	
	function fnRelocate pLocation =
	(
		local fileName = fnGetFileName();
		FullFileName = pLocation + fileName;
		fnLoadModData();
	),
	
	function fnHasFileBeenModified =
	(
		currentModData = getFileModDate FullFileName;
		return (currentModData != FileModDate);
	),
	
	function fnUpdateModData =
	(
		fnLoadModData();
	),
	
	function fnFileIsNetWorkFile =
	(
		pathIsNetworkPath FullFileName;
	),
	
	function fnIsSameFile pFile =
	(
		return FullFileName == pFile.FullFileName and FileModDate == pFile.fnGetModData();
	)
)