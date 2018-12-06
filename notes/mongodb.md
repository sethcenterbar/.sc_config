## cmd
$ mongodump --out /mnt/mysqlbackup/ofimongodbcluster/dumps/{directory} --> mongodump and store results in {directory}
$ mongorestore /mnt/mysqlbackup/ofimongodbcluster/dumps/{directory} --> mongorestore from {directory}
$ mongotop -- View process usage within mongo

## dir 
/etc/mongod.conf --> The configuration file used when the mongo daemon starts.
/var/lib/mongo --> The data directory we are using for mongod

## firewalld 
--> Add a comment to explain what this is and where it goes. 
``` 
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>MongoDB</short>
  <description>MongoDB NoSQL Database.</description>
  <port protocol="tcp" port="27017"/>
</service>
```
