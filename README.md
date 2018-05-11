游戏用批量烘培<br>
Batch Baking Tools For Game Artist<br>

<p>
设计需求:winking artist 编码:孙* UI设计: 姜*<br>
Design And Require By winking aritists<br>
Coding by *sun<br>
UI by Derek Jiang<br>
</p>

<p>
软件机制<br>
xnormal可以通过xml文件保存自己工作所需的参数。通过动态生成这个设定文件，并且用命令行调用xnormal载入动态生成的设定文件来烘培贴图。<br>
在max里通过高低模的匹配生成多个批次的设定文件。从而一个烘培多张贴图。<br>
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
5如果再高低模型列表里有选择的话并将选择的模型渲染序号大于0，将只渲染选择的这个序号的模型。没有任何选择，将全部渲染。<br>
5if only seletion item in the list will be rendered, no selection will render all.<br>
</p>


<p>
如果你的高模在zbrush里怎么办？<br>
这时需要把使用场景高模的选择框点掉。这时添加点击添加高模就会出现一个弹出窗口，需要指定中模和高模文件位置。<br>
这两个位置就是zb里导出的模型位置，中模和高模名字要一样，没有中文，obj格式。<br>
中模就是zbrush里降级后的模型，会导入到max里于低模匹配生成渲染批次。中模只是zb高模在max里的代理。<br>
高模就是zbrush里到高模，会最终用于烘培。<br>
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

