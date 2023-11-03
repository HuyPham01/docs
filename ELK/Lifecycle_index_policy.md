# ILM
Architecture hot-warm-cold là gì:  
Các logs của ngày hôm nay đang được lập index, trong khi các logs của tuần này được mong muốn nhất (host). Nhật ký của tuần trước cũng có thể tìm kiếm được, nhưng không thường xuyên như nhật ký (warm) của tuần hiện tại. Mặt khác, nhật ký của tháng trước có thể được xem rất thường xuyên hoặc không thường xuyên (cold)  
![image](https://github.com/HuyPham01/docs/assets/96679595/e2a94606-650b-414b-8841-0eb10622fee8)  

# Step 1 create Index Lifecycle Policies
Management → Index Lifecycle Policies → Create 
![image](https://github.com/HuyPham01/docs/assets/96679595/09197427-9ea6-469e-8dd9-6158bef1a3dc)  
Add name policy  
![image](https://github.com/HuyPham01/docs/assets/96679595/f1fe29e8-e6f8-4451-95ca-d6dd2452b087)  
Thiết lập độ ưu tiên của từng giai đoạn  
- Host
![image](https://github.com/HuyPham01/docs/assets/96679595/0defd110-7b9b-4ded-86d5-204bf8a036ab)  
Default được thiết lập ở 30 ngày 50Gb tùy điều kiện nào đến trước
- Warm
![image](https://github.com/HuyPham01/docs/assets/96679595/4f2c643d-8c5a-4a34-bdef-74d9c0e33f48)  
Thiết lập khoảng thời gian được lưu trữ tại warm
- Cold
![image](https://github.com/HuyPham01/docs/assets/96679595/f78b9847-d9ce-42f5-afbb-a96a6d027844)  
Thiết lập khoảng thời gian được lưu trữ tại Cold
- Delete  
![image](https://github.com/HuyPham01/docs/assets/96679595/93c8e413-32d4-457a-ab19-fb8ab01dfa98)
Xóa index theo thời gian chỉ định  
- Save policy
# Step 2 Create Index templates
Management → Index Management  →Index Templates  
![image](https://github.com/HuyPham01/docs/assets/96679595/739dca1f-019b-42da-a667-72d5f33159df)  
Legacy index templates → Create Legacy Templates   
![image](https://github.com/HuyPham01/docs/assets/96679595/3793437b-b6b9-4618-a863-144a120a9a14)  
Logistics:  

- Add name index template  

- Index patterns ( nginx-*)
![image](https://github.com/HuyPham01/docs/assets/96679595/54453b9e-fcaf-459a-a858-07b559074b5f)  
Index settings :
```bash
{
  "index": {
    "number_of_shards": "1",
    "refresh_interval": "5s"
  }
}
```
Mappings :  
![image](https://github.com/HuyPham01/docs/assets/96679595/831cb73f-9c5c-4cdb-9a0e-e62e2cf01cb2)  
Aliases  Next ( bỏ qua )  

Review ( Save )  
# Step 3 add policy to index template
Chọn policy cần thêm vào index template   
![image](https://github.com/HuyPham01/docs/assets/96679595/d64de610-e40b-48d3-92b0-cac823fa5c3f)  
Click Show legacy index templates  

chọn template  

add alias  
![image](https://github.com/HuyPham01/docs/assets/96679595/c6197e6a-4d75-47be-a787-85a4254c1966)  

Add policy  
# Step 4 configuration output logstash
```bash
output {
 if "nginx" in [type] {
   elasticsearch {
     hosts => ["localhost:9200"]
     index => "%{[type]}-%{+YYYY.MM.dd}-000001"
     manage_template => true
     template_name => "nginx-template"
     ilm_enabled => true
     ilm_rollover_alias => "nginx"
     ilm_pattern => "000001"

    }
  }
 if "nginx" not in [tags] {
   elasticsearch {
     hosts => ["localhost:9200"]
     index => "calico-%{+YYYY.MM.dd}"
    }
  }
}
```
- name index phải khớp với pattern ^.*-\d+$, ví dụ (my-index-000001).  

- template_name  : name template vừa tạo trên giao diện console  

- ilm_rollover_alias   :  đặt alias cho index  

- ilm_pattern   :   the pattern to use for the index names  là một số tăng dần  

## Policy 60day  
Host 30d or 50GB  

Warm 7d  

Cold 30d  

Delete 60d  
