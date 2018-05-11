rcmenu RCTitleList
(
	subMenu "xNormal"
	(
		menuItem mi_SaveListSetting		"����ߵ�ģ���б���Ϣ";
		menuItem mi_LoadListSetting		"����ߵ�ģ���б���Ϣ";
		separator sp1;
		menuItem mi_SaveBatchSetting	"������Ⱦ�����趨�ļ�";
	)
	
	subMenu "Update"
	(
		menuItem mi_Update "����";
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
	menuItem mi_SelectAccordingScenseObject "ѡ�񳡾���Ӧ��ģ";
	menuItem mi_SyncLowHigh "ͬ���ߵ�ģѡ����"
	menuItem mi_BakeSetup "����Projection"
	
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
	menuItem mi_SelectAccordingScenseObject "ѡ�񳡾������Ӧ��ģ";
	menuItem mi_SyncLowHigh "ͬ���ߵ�ģѡ����";
	menuItem mi_CopySelect "�ظ����Ӵ���";
	
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