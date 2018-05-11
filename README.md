游戏用批量烘培<br>
Batch Baking Tools For Game Artist<br>

<p>
设计需求:winking artist 编码:孙* UI设计: 姜*<br>
Design And Require By winking aritists<br>
Coding by *sun<br>
UI by Derek Jiang<br>
</p>

<p>
没有正确烘培出来可能是哪里的问题？<br>
Normal map didn't correct or no map texture file comes out?<br>
</p>

<p>
1右键添加projector修改器<br>
1right click , add projector modifier<br>
2渲染的序号是0，添加到高低模列表时默认时0，选择高低模，按向下的箭头按钮分配一个渲染序号<br>
2your batch number is 0, when adding low&high model to the plug list, their default is 0. select low-high pair model name in the list, press down-arrow button, then it will give your a batch num.<br>
3在Temp文件夹里有HighPolys/LowPolys/IntermediatePolys有存放导出到xnormal的sbm模型，清空一下，因为为了加快导出速度，如果导出模型已经存在会不再从新导出，所有对模型修改后也要清一下这里的文件。<br>
3clear the HighPolys/LowPolys/IntermediatePolys folder under Temp folder. for exporting speed reason, already exists sbm file will not be exported again. <br>
	so clear it when you modify you model or you find normal map not correct caused by wrong low & high model setup.<br>
4安装设置好xnormal的位置<br>
4intall xnormal and set correct path in the plug.<br>
</p>


<p>
如何查看排除错误？<br>
How to debug when something went wrong<br>

在xNormal\xNormalSettingFiles文件夹下会对每个渲染批次生成一个对应xnormal设定文件， 命名很明显说明代表的批次，独立启动xnormal 在xnormal里载入出问题批次的设定文件<br>
under xNormal\xNormalSettingFiles folder there actually xnormal setting files for each of your rendering. file name will clearly explain which batch it belongs to. run xnormal and load them.<br>
</p>

<p>
最后在技术人员指导下使用<br>
ask your teck people  how to use it.<br>
Macro文件夹是为了在max里创建自定义UI做的 mzp.run之类的文件是为了做安装文件<br>
Macro folder files are for custoem UI in max. mzp.run file and relitive is for auto-installation<br>
</p>

<p>
孙*/*sun:qq343294964@126.com
</p>

