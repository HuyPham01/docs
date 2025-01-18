```
PUT _template/template_geoip
{
 "index_patterns": ["filebeat-*"],
 "settings": {
   "number_of_shards": 3,
   "index.lifecycle.name": "delete_1h",
   "codec": "best_compression",
   "refresh_interval": "5m",
   "number_of_replicas": "0"
 },
 "mappings": {
   "properties": {
     "@timestamp" : {
       "type": "date"
     },
     "@version" : {
       "type": "keyword"
     },
     "geoip.geo": {
       "dynamic": true,
       "properties": {
         "location": {
           "type": "geo_point"
         }
       }
     }
   }
 }
}
```
`number_of_shards : 3` chia đều ra 3 node  
`"refresh_interval": "5m"` 5m sẽ set index  
`"number_of_replicas": "0"` replicas bằng 0 lên để 1  
field vào `geoip.geo` và `location` mapping thành `geoip.geo.location` với value là `geo_point`
