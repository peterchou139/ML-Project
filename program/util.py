import redis

r = redis.StrictRedis(host='localhost', port=6379, db=0)

DATA_FLAG = 'training' 

def set_data_flag(flag):
    global DATA_FLAG
    DATA_FLAG = flag

def get_rssi_history(uid, timestamp, interval=5):
    timestamps = r.zrangebyscore('rssi_%s_timestamps%s' % (DATA_FLAG, uid), timestamp - interval, timestamp)
    return {float(timestamp): int(r.hget('rssi_%s_samples%s' % (DATA_FLAG, uid), timestamp)) for timestamp in timestamps}

def get_distance_history(timestamp, interval=5):
    timestamps = r.zrangebyscore('distance_%s_timestamps' % DATA_FLAG, timestamp - interval, timestamp)
    return {float(timestamp): int(r.hget('distance_%s_samples') % DATA_FLAG, timestamp) for timestamp in timestamps}

def get_all_distance_samples():
    return {float(timestamp): int(distance) for timestamp, distance in r.hgetall('distance_%s_samples' % DATA_FLAG).iteritems()}