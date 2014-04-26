import redis

r = redis.StrictRedis(host='localhost', port=6379, db=0)

with open('distance.txt') as fp:
    for line in fp:
        timestamp, distance = line.split(', ')
        r.zadd('distance_training_timestamps', float(timestamp), float(timestamp))
        r.hset('distance_training_samples', float(timestamp), int(distance))

with open('distance_test.txt') as fp:
    for line in fp:
        timestamp, distance = line.split(', ')
        r.zadd('distance_test_timestamps', float(timestamp), float(timestamp))
        r.hset('distance_test_samples', float(timestamp), int(distance))

with open('rssi.txt') as fp:
    for line in fp:
        timestamp, uid, rssi, _ = line.split(', ')
        r.zadd('rssi_training_timestamps' + uid, float(timestamp), float(timestamp))
        r.hset('rssi_training_samples' + uid, float(timestamp), int(rssi))

with open('rssi_test.txt') as fp:
    for line in fp:
        timestamp, uid, rssi, _ = line.split(', ')
        r.zadd('rssi_test_timestamps' + uid, float(timestamp), float(timestamp))
        r.hset('rssi_test_samples' + uid, float(timestamp), int(rssi))