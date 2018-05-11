-- By Hua(xu.sun RD63)
-- "2012/10/24"


struct LowPolyTriKeyItem
(
	K1, K2, K3,
	Function fnBuildIndexedString =
	(
		Local GroupName = fnGetGroupName K1;
		if K1 == 0 then
		(
			"--" + K1 as string + "--\t" + K2.name;
		)
		else
		(
			"--" + GroupName + "--\t" + K2.name;
		)	
	)
);