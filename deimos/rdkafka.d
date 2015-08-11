module deimos.rdkafka;

import core.stdc.stdio;
import core.sys.posix.sys.types; 

extern (C):

alias kafka_errors rd_kafka_resp_err_t;

alias kafka_conf rd_kafka_conf_res_t;
 


enum rd_kafka_type_t
{
    RD_KAFKA_PRODUCER = 0,
    RD_KAFKA_CONSUMER = 1
}

enum kafka_errors
{
    RD_KAFKA_RESP_ERR__BEGIN = -200,
    RD_KAFKA_RESP_ERR__BAD_MSG = -199,
    RD_KAFKA_RESP_ERR__BAD_COMPRESSION = -198,
    RD_KAFKA_RESP_ERR__DESTROY = -197,
    RD_KAFKA_RESP_ERR__FAIL = -196,
    RD_KAFKA_RESP_ERR__TRANSPORT = -195,
    RD_KAFKA_RESP_ERR__CRIT_SYS_RESOURCE = -194,
    RD_KAFKA_RESP_ERR__RESOLVE = -193,
    RD_KAFKA_RESP_ERR__MSG_TIMED_OUT = -192,
    RD_KAFKA_RESP_ERR__PARTITION_EOF = -191,
    RD_KAFKA_RESP_ERR__UNKNOWN_PARTITION = -190,
    RD_KAFKA_RESP_ERR__FS = -189,
    RD_KAFKA_RESP_ERR__UNKNOWN_TOPIC = -188,
    RD_KAFKA_RESP_ERR__ALL_BROKERS_DOWN = -187,
    RD_KAFKA_RESP_ERR__INVALID_ARG = -186,
    RD_KAFKA_RESP_ERR__TIMED_OUT = -185,
    RD_KAFKA_RESP_ERR__QUEUE_FULL = -184,
    RD_KAFKA_RESP_ERR__ISR_INSUFF = -183,
    RD_KAFKA_RESP_ERR__END = -100,
    RD_KAFKA_RESP_ERR_UNKNOWN = -1,
    RD_KAFKA_RESP_ERR_NO_ERROR = 0,
    RD_KAFKA_RESP_ERR_OFFSET_OUT_OF_RANGE = 1,
    RD_KAFKA_RESP_ERR_INVALID_MSG = 2,
    RD_KAFKA_RESP_ERR_UNKNOWN_TOPIC_OR_PART = 3,
    RD_KAFKA_RESP_ERR_INVALID_MSG_SIZE = 4,
    RD_KAFKA_RESP_ERR_LEADER_NOT_AVAILABLE = 5,
    RD_KAFKA_RESP_ERR_NOT_LEADER_FOR_PARTITION = 6,
    RD_KAFKA_RESP_ERR_REQUEST_TIMED_OUT = 7,
    RD_KAFKA_RESP_ERR_BROKER_NOT_AVAILABLE = 8,
    RD_KAFKA_RESP_ERR_REPLICA_NOT_AVAILABLE = 9,
    RD_KAFKA_RESP_ERR_MSG_SIZE_TOO_LARGE = 10,
    RD_KAFKA_RESP_ERR_STALE_CTRL_EPOCH = 11,
    RD_KAFKA_RESP_ERR_OFFSET_METADATA_TOO_LARGE = 12
}

enum kafka_conf
{
    RD_KAFKA_CONF_UNKNOWN = -2,
    RD_KAFKA_CONF_INVALID = -1,
    RD_KAFKA_CONF_OK = 0
}

struct rd_kafka_message_t
{
    rd_kafka_resp_err_t err;
    rd_kafka_topic_t* rkt;
    int partition;
    void* payload;
    size_t len;
    void* key;
    size_t key_len;
    long offset;
    void* _private;
}

struct rd_kafka_metadata_broker_t
{
    int id;
    char* host;
    int port;
}

struct rd_kafka_metadata_partition_t
{
    int id;
    rd_kafka_resp_err_t err;
    int leader;
    int replica_cnt;
    int* replicas;
    int isr_cnt;
    int* isrs;
}

struct rd_kafka_metadata_topic_t
{
    char* topic;
    int partition_cnt;
    rd_kafka_metadata_partition_t* partitions;
    rd_kafka_resp_err_t err;
}

struct rd_kafka_metadata_t
{
    int broker_cnt;
    rd_kafka_metadata_broker_t* brokers;
    int topic_cnt;
    rd_kafka_metadata_topic_t* topics;
    int orig_broker_id;
    char* orig_broker_name;
}

struct rd_kafka_t;


struct rd_kafka_topic_t;


struct rd_kafka_conf_t;


struct rd_kafka_topic_conf_t;


struct rd_kafka_queue_t;


int rd_kafka_version ();
const(char)* rd_kafka_version_str ();
const(char)* rd_kafka_err2str (rd_kafka_resp_err_t err);
rd_kafka_resp_err_t rd_kafka_errno2err (int errnox);
void rd_kafka_message_destroy (rd_kafka_message_t* rkmessage);
const(char)* rd_kafka_message_errstr (const(rd_kafka_message_t)* rkmessage);
rd_kafka_conf_t* rd_kafka_conf_new ();
void rd_kafka_conf_destroy (rd_kafka_conf_t* conf);
rd_kafka_conf_t* rd_kafka_conf_dup (const(rd_kafka_conf_t)* conf);
rd_kafka_conf_res_t rd_kafka_conf_set (rd_kafka_conf_t* conf, const(char)* name, const(char)* value, char* errstr, size_t errstr_size);
void rd_kafka_conf_set_dr_cb (rd_kafka_conf_t* conf, void function (rd_kafka_t*, void*, size_t, rd_kafka_resp_err_t, void*, void*) dr_cb);
void rd_kafka_conf_set_dr_msg_cb (rd_kafka_conf_t* conf, void function (rd_kafka_t*, const(rd_kafka_message_t)*, void*) dr_msg_cb);
void rd_kafka_conf_set_error_cb (rd_kafka_conf_t* conf, void function (rd_kafka_t*, int, const(char)*, void*) error_cb);
void rd_kafka_conf_set_log_cb (rd_kafka_conf_t* conf, void function (const(rd_kafka_t)*, int, const(char)*, const(char)*) log_cb);
void rd_kafka_conf_set_stats_cb (rd_kafka_conf_t* conf, int function (rd_kafka_t*, char*, size_t, void*) stats_cb);
void rd_kafka_conf_set_socket_cb (rd_kafka_conf_t* conf, int function (int, int, int, void*) socket_cb);
void rd_kafka_conf_set_open_cb (rd_kafka_conf_t* conf, int function (const(char)*, int, mode_t, void*) open_cb);
void rd_kafka_conf_set_opaque (rd_kafka_conf_t* conf, void* opaque);
void* rd_kafka_opaque (const(rd_kafka_t)* rk);
const(char*)* rd_kafka_conf_dump (rd_kafka_conf_t* conf, size_t* cntp);
const(char*)* rd_kafka_topic_conf_dump (rd_kafka_topic_conf_t* conf, size_t* cntp);
void rd_kafka_conf_dump_free (const(char*)* arr, size_t cnt);
void rd_kafka_conf_properties_show (FILE* fp);
rd_kafka_topic_conf_t* rd_kafka_topic_conf_new ();
rd_kafka_topic_conf_t* rd_kafka_topic_conf_dup (const(rd_kafka_topic_conf_t)* conf);
void rd_kafka_topic_conf_destroy (rd_kafka_topic_conf_t* topic_conf);
rd_kafka_conf_res_t rd_kafka_topic_conf_set (rd_kafka_topic_conf_t* conf, const(char)* name, const(char)* value, char* errstr, size_t errstr_size);
void rd_kafka_topic_conf_set_opaque (rd_kafka_topic_conf_t* conf, void* opaque);
void rd_kafka_topic_conf_set_partitioner_cb (rd_kafka_topic_conf_t* topic_conf, int function (const(rd_kafka_topic_t)*, const(void)*, size_t, int, void*, void*) partitioner);
int rd_kafka_topic_partition_available (const(rd_kafka_topic_t)* rkt, int partition);
int rd_kafka_msg_partitioner_random (const(rd_kafka_topic_t)* rkt, const(void)* key, size_t keylen, int partition_cnt, void* opaque, void* msg_opaque);
rd_kafka_t* rd_kafka_new (rd_kafka_type_t type, rd_kafka_conf_t* conf, char* errstr, size_t errstr_size);
void rd_kafka_destroy (rd_kafka_t* rk);
const(char)* rd_kafka_name (const(rd_kafka_t)* rk);
rd_kafka_topic_t* rd_kafka_topic_new (rd_kafka_t* rk, const(char)* topic, rd_kafka_topic_conf_t* conf);
void rd_kafka_topic_destroy (rd_kafka_topic_t* rkt);
const(char)* rd_kafka_topic_name (const(rd_kafka_topic_t)* rkt);
rd_kafka_queue_t* rd_kafka_queue_new (rd_kafka_t* rk);
void rd_kafka_queue_destroy (rd_kafka_queue_t* rkqu);
int rd_kafka_consume_start (rd_kafka_topic_t* rkt, int partition, long offset);
int rd_kafka_consume_start_queue (rd_kafka_topic_t* rkt, int partition, long offset, rd_kafka_queue_t* rkqu);
int rd_kafka_consume_stop (rd_kafka_topic_t* rkt, int partition);
rd_kafka_message_t* rd_kafka_consume (rd_kafka_topic_t* rkt, int partition, int timeout_ms);
ssize_t rd_kafka_consume_batch (rd_kafka_topic_t* rkt, int partition, int timeout_ms, rd_kafka_message_t** rkmessages, size_t rkmessages_size);
int rd_kafka_consume_callback (rd_kafka_topic_t* rkt, int partition, int timeout_ms, void function (rd_kafka_message_t*, void*) consume_cb, void* opaque);
rd_kafka_message_t* rd_kafka_consume_queue (rd_kafka_queue_t* rkqu, int timeout_ms);
ssize_t rd_kafka_consume_batch_queue (rd_kafka_queue_t* rkqu, int timeout_ms, rd_kafka_message_t** rkmessages, size_t rkmessages_size);
int rd_kafka_consume_callback_queue (rd_kafka_queue_t* rkqu, int timeout_ms, void function (rd_kafka_message_t*, void*) consume_cb, void* opaque);
rd_kafka_resp_err_t rd_kafka_offset_store (rd_kafka_topic_t* rkt, int partition, long offset);
int rd_kafka_produce (rd_kafka_topic_t* rkt, int partitition, int msgflags, void* payload, size_t len, const(void)* key, size_t keylen, void* msg_opaque);
int rd_kafka_produce_batch (rd_kafka_topic_t* rkt, int partition, int msgflags, rd_kafka_message_t* rkmessages, int message_cnt);
rd_kafka_resp_err_t rd_kafka_metadata (rd_kafka_t* rk, int all_topics, rd_kafka_topic_t* only_rkt, const(rd_kafka_metadata_t*)* metadatap, int timeout_ms);
void rd_kafka_metadata_destroy (const(rd_kafka_metadata_t)* metadata);
int rd_kafka_poll (rd_kafka_t* rk, int timeout_ms);
int rd_kafka_brokers_add (rd_kafka_t* rk, const(char)* brokerlist);
void rd_kafka_set_logger (rd_kafka_t* rk, void function (const(rd_kafka_t)*, int, const(char)*, const(char)*) func);
void rd_kafka_set_log_level (rd_kafka_t* rk, int level);
void rd_kafka_log_print (const(rd_kafka_t)* rk, int level, const(char)* fac, const(char)* buf);
void rd_kafka_log_syslog (const(rd_kafka_t)* rk, int level, const(char)* fac, const(char)* buf);
int rd_kafka_outq_len (rd_kafka_t* rk);
void rd_kafka_dump (FILE* fp, rd_kafka_t* rk);
int rd_kafka_thread_cnt ();
int rd_kafka_wait_destroyed (int timeout_ms);