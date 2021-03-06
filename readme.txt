==================================================================================
实验设备说明：
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

测试设备为 MacBook Pro，受测设备是 TI CC2540 的蓝牙终端，动态测距使用 KS 103 超声波传感器

==================================================================================
信号强度数据集			rssi.txt
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

样例：
1396258359.649243, E2C56DB5-DFFB-48D2-B060-D0F5A71096E1, -77, -59
\_______________/  \___________________________________/ \_/  \_/
        |                           |                     |     \
        |                           |                     |      \
        |                           |                     |       \
        |                           |                     |        \
      时间戳                   蓝牙终端 ID            信号强度   天线功率

详细描述：
----------------+-------------------------------------------------------------
	项目		|	描述
————------------+-------------------------------------------------------------
	时间戳		|	数据采集的时间，自 1970-01-01 08:00:00 GMT 至当前时间的总秒数
	蓝牙终端 ID	|	数据所对应的蓝牙终端
	信号强度	|	蓝牙终端与测量设备之间的距离
	天线功率	|	蓝牙终端当前的信号功率
----------------+-------------------------------------------------------------

蓝牙终端共有五个，分固定终端和移动终端两种，固定终端的信号强度可以作为当前环境中无线通信频
道的拥挤程度，可以利用其来修正由环境给移动终端与测试设备间信号强度所带来的的影响：

----------------+-------------------------------------------+-----------------
	终端类型|	ID                              | 与测试设备距离
----------------+-------------------------------------------+-----------------
	固定终端|E2C56DB5-DFFB-48D2-B060-D0F5A71096E1	|	3M
		|E2C56DB5-DFFB-48D2-B060-D0F5A71096E2	|	2M
		|E2C56DB5-DFFB-48D2-B060-D0F5A71096E3	|	3M
		|E2C56DB5-DFFB-48D2-B060-D0F5A71096E4	|	1M
————------------+-------------------------------------------+------------------
	移动终端|E2C56DB5-DFFB-48D2-B060-D0F5A71096E5	|	 *
----------------+-------------------------------------------+------------------

==================================================================================
移动终端距离数据集			distance.txt
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

样例：
1396258343.984018, 2996
\_______________/  \__/
        |            \
        |             \
        |              \
        |               \
      时间戳            距离

详细描述：
----------------+-------------------------------------------------------------
	项目		|	描述
————------------+-------------------------------------------------------------
	时间戳		|	数据采集的时间，自 1970-01-01 08:00:00 GMT 至当前时间的总秒数
	距离		|	测试设备与移动终端之间的距离，单位为毫米
----------------+-------------------------------------------------------------

==================================================================================
备注
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1、	为了简化任务，测试设备的天线功率一致设定为-59，因此该信息可以从模型中忽略。
2、	设备收集过程中，距离信息绝大多数时间误差为 cm 级，但依然存在异常值，实际数据采集中移动设备
	与测量设备之间距离小于5M，其中个别超出5M的数值为错误干扰（例如：11248），需要考虑剔除。
3、	为了完整保存原始数据的信息，数据集中没有对移动设备的距离和信号强度做匹配。在实际处理时，可
	以考虑通过相邻时刻的样本值来进行平均映射，减少由于离群值所引入的误差。
4、	由于信号强度的分辨率有限，故模型能达到分米级的误差已经非常优秀，不必苛求更低数量级的精确。

==================================================================================
