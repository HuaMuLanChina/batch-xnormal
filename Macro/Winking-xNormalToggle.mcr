-------------------------------------------------------------------------------
-- xNormal.mcr
--
-- History:
--  04.10 2013 - xu.sun
--
-- 
-------------------------------------------------------------------------------



macroScript xNormalToggle 
	buttonText:"xNormal" 
	category:"Winking"
	internalCategory:"Winking" 
	tooltip:"Toggle xNormal Dialog-box" 
	icon:#("xNormalToggle", 1)
(
	on execute do
	(
		fileIN "$userscripts\\xNormalTag2\\Init_xNormal.ms"; --修改此处路径；
	)
)