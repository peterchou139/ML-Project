def get_history_interval():
	#设置模型所需的信号强度历史记录时长
	return 5

def mean(num_list):
	return sum(num_list) / len(num_list)

def prediction_distance(timestamp, rssi_samples):
	#通过历史记录预测距离
	x = [0, 0, 0, 0, 0, 0]
	x[0] = mean(rssi_samples['E2C56DB5-DFFB-48D2-B060-D0F5A71096E1'].values())
	x[1] = mean(rssi_samples['E2C56DB5-DFFB-48D2-B060-D0F5A71096E2'].values())
	x[2] = mean(rssi_samples['E2C56DB5-DFFB-48D2-B060-D0F5A71096E3'].values())
	x[3] = mean(rssi_samples['E2C56DB5-DFFB-48D2-B060-D0F5A71096E4'].values())
	x[4] = mean(rssi_samples['E2C56DB5-DFFB-48D2-B060-D0F5A71096E5'].values())
	x[5] = x[4] ** 2
	x[0] = (x[0] - -79.800206) / 1.663817
	x[1] = (x[1] - -72.490216) / 1.091984
	x[2] = (x[2] - -63.335736) / 0.781586
	x[3] = (x[3] - -69.104016) / 1.410745
	x[4] = (x[4] - -57.290422) / 6.040422
	x[5] = (x[5] - 3318.641607) / 679.902122
	return 1890.505868 + -31.251771 * x[0] + -1.271860 * x[1] + 28.779601 * x[2] + 18.526284 * x[3] + -427.017691 * x[4] + 439.759407 * x[5]