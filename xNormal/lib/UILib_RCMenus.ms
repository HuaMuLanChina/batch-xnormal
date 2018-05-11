rcmenu RCTitleList
(
	subMenu "xNormal"
	(
		menuItem mi_SaveListSetting		"保存高低模型列表信息";
		menuItem mi_LoadListSetting		"载入高低模型列表信息";
		separator sp1;
		menuItem mi_SaveBatchSetting	"保存渲染批次设定文件";
	)
	
	subMenu "Update"
	(
		menuItem mi_Update "更新";
	)
	
	on mi_SaveListSetting picked do
	(
		rol_xNormal.SaveListSetting();
	)
	
	on mi_LoadListSetting picked do
	(
		rol_xNormal.LoadListSetting();
	)
	
	on mi_SaveBatchSetting picked do
	(
		rol_xNormal.SaveBatchSettings();
	)
	
	on mi_Update picked do
	(
		rol_xNormal.Update();
	)
)

rcmenu RCLowPolyList
(
	menuItem mi_SelectAccordingScenseObject "选择场景对应低模";
	menuItem mi_SyncLowHigh "同步高低模选择项"
	menuItem mi_BakeSetup "添加Projection"
	
	on mi_SelectAccordingScenseObject picked do
	(
		rol_xNormal.SelectAccordingScenseObjectLowPolyList();
	)
	
	on mi_SyncLowHigh picked do
	(
		rol_xNormal.SyncSelectedLowAndHighPoly();
	)
	
	on mi_BakeSetup picked do
	(
		rol_xNormal.SetupBakeSelected();
	)
)

rcmenu RCHighPolyList
(
	menuItem mi_SelectAccordingScenseObject "选择场景物体对应高模";
	menuItem mi_SyncLowHigh "同步高低模选择项";
	menuItem mi_CopySelect "重复增加此项";
	
	on mi_SelectAccordingScenseObject picked do
	(
		rol_xNormal.SelectAccordingScenseObjectHighPolyList();
	)
	
	on mi_SyncLowHigh picked do
	(
		rol_xNormal.SyncSelectedLowAndHighPoly();
	)
	
	on mi_CopySelect picked do
	(
		rol_xNormal.Copy_Selected();
	)
)