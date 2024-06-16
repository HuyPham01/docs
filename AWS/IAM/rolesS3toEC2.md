# Step-1 Create an IAM instance profile that grants access to Amazon S3.
Open the IAM console.  
Choose Roles, and then choose Create role.  
Select AWS Service, and then choose EC2.  
Select Next: Permissions.  
![image](https://github.com/HuyPham01/docs/assets/96679595/83dc9995-6aca-4ca0-8596-f528ea7d09d9)  
Note: Creating a policy with the minimum required permissions is a security best practice. However, to allow EC2 access to all your Amazon S3 buckets, you can use the AmazonS3ReadOnlyAccess or AmazonS3FullAccess managed IAM policy.  

Select Next: Tags, and then select Next: Review.  
Enter a Role name, and then select Create role.  
# Step-2 Create an EC2 instance and attach IAM instance profile to this instance
Click on checkbox on that instance and go to Actions tab > Security > Modify IAM role.  
![image](https://github.com/HuyPham01/docs/assets/96679595/0358393b-ce26-45f5-866b-05794d227e47)  
Now select the IAM role that you created in step-1 then save it  
![image](https://github.com/HuyPham01/docs/assets/96679595/ec579dfa-201c-47fd-9854-7013765a3692)  
Reboot instance or systemctl restart amazon-ssm-agent
# Step-3 Validate S3 to check permissions
Go to Permissions>Bucket Policy  
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::***/*"
        }
    ]
}
```
`Resource`: properties -> (ARN)  
# Step-4 Validate access to S3 buckets
setup aws cli
```
apt update
apt install awscli
```
`aws s3 ls` list bucket
`aws s3 ls <bucket-name>' show Objects
Fix show objects: `An error occurred (IllegalLocationConstraintException) when calling the ListObjectsV2 operation:..........`
`aws s3 ls <bucket-name> --region xxx'  
