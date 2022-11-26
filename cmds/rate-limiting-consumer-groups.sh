curl http://127.0.0.1:9180/apisix/admin/consumer_groups/basic_plan -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d '
{
    "plugins": {
        "limit-count": {
            "count": 2,
            "time_window": 60,
            "rejected_code": 503,
            "group": "basic_plan"
        }
    }
}'

curl http://127.0.0.1:9180/apisix/admin/consumer_groups/premium_plan -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d '
{
    "plugins": {
        "limit-count": {
            "count": 200,
            "time_window": 60,
            "rejected_code": 503,
            "group": "premium_plan"
        }
    }
}'

# create consumer 1
curl http://127.0.0.1:9180/apisix/admin/consumers -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d '
{
    "username": "consumer1",
    "plugins": {
        "key-auth": {
            "key": "auth-one"
        }
    },
    "group_id": "basic_plan"
}'

# create consumer 2
curl http://127.0.0.1:9180/apisix/admin/consumers -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d '
{
    "username": "consumer2",
    "plugins": {
        "key-auth": {
            "key": "auth-two"
        }
    },
    "group_id": "premium_plan"
}'

curl http://127.0.0.1:9180/apisix/admin/consumers -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d '
{
    "username": "consumer3",
    "plugins": {
        "key-auth": {
            "key": "auth-three"
        }
    },
    "group_id": "premium_plan"
}'

curl -i http://127.0.0.1:9080/api/products -H 'apikey: auth-one'

curl -i http://127.0.0.1:9080/api/products -H 'apikey: auth-two'

curl -i http://127.0.0.1:9080/api/products -H 'apikey: auth-three'