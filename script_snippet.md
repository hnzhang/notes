User Data for EC2 instances
# install Apache web server on Amazon linux
```bash
yum update -y
yum install httpd -y
service httpd start
chkconfig httpd on
mkdir /var/www/html/

```
# change password for a user in script
```bash
echo "<new_password>" | passwd --stdin ec2-user
```




#cmds

chown --to change owner 
chmod change mode of a folder
