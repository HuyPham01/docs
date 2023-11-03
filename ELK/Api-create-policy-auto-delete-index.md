# Step 1 Create policy
```bash
PUT _ilm/policy/delete_1d
{
  "policy": {
    "phases": {
      "delete": {
        "min_age": "1d",
        "actions": {
          "delete": {}
        }
      }
    }
  }
}
```
# Step 2 Create template
 `Template index` sẽ được áp dụng để định dạng chỉ `index` tiếp theo các quy tắc được xác định trong mẫu.  
 ```bash
PUT _template/my_test_template
{
  "index_patterns": ["nginx-*"],
  "settings": {
    "number_of_shards": 1,
    "index.lifecycle.name": "delete_1d"   
  }
}
```
# Step 3 Set policy
Set policy cho index cũ  
```bash
PUT nginx-*/_settings
{
  "index": {
    "lifecycle": {
      "name": "delete_1d"
    }
  }
}
```
Check age index dùng api GET  
```bash
GET nginx-*/_ilm/explain
```
Sau khi vào trạng thái Delete từ 0 - 30p index sẽ được xóa   
