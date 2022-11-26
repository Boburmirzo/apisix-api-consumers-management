# 1. 

curl http://127.0.0.1:9180/apisix/admin/consumers -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d '
{
   "username":"consumer1",
   "plugins":{
      "key-auth":{
         "key":"auth-one"
      },
      "limit-count":{
         "count":2,
         "time_window":60,
         "rejected_code":503,
         "rejected_msg":"Requests are too many, please try again later or upgrade your subscription plan.",
         "key":"remote_addr"
      }
   }
}'

# 2. 

curl http://127.0.0.1:9180/apisix/admin/routes/1 -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d '
{
  "name": "Route for consumer request rate limiting",
  "methods": [
    "GET"
  ],
  "uri": "/api/products",
    "plugins": {
        "key-auth": {}
    },
  "upstream": {
    "type": "roundrobin",
    "nodes": {
      "productapi:80": 1
    }
  }
}'

# 3. 

curl http://127.0.0.1:9080/api/products -H 'apikey: auth-one' -i