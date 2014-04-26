import util
import prediction_model

util.set_data_flag('test')
all_device_uid = ['E2C56DB5-DFFB-48D2-B060-D0F5A71096E' + str(i) for i in range(1, 6)]
all_distance_samples = util.get_all_distance_samples()

interval = prediction_model.get_history_interval()
if interval <= 0:
    print 'History interval must be a positive value!'
    exit(0)

deviations = []

for timestamp, distance in all_distance_samples.iteritems():
    rssi_samples = {uid: util.get_rssi_history(uid, timestamp, interval) for uid in all_device_uid}
    deviations.append(abs((prediction_model.prediction_distance(timestamp, rssi_samples) - distance) / 10))

score = 1000 / ((sum(deviations) / len(deviations)) * (interval))

print '---------------------------------------------------------------------'
print 'Your model\'s score (with higher being better) is %f' % score
print '---------------------------------------------------------------------'
print '\t History interval: %f s' % interval
print '\tAverage deviation: %f cm' % (sum(deviations) / len(deviations))
print '---------------------------------------------------------------------'