# Post Migration Rundown
## A word from the DB Team

With proper QA from business and hard work from Seth, Justin, Scott, John, Trint, and George, the Migration night was a success. We are confident in the move and feel like similar migrations in the future will continue to get smoother and smoother. While there were many pitfalls in the process, I personally have walked away from this project feeling much more knowledgable and prepared for the future.   

## Mysql
### The Good
- Amazon Data Migration Services was definitely a good choice. It's quick, relatively easy to configure, and though their documentation fails to mention it, it's a great way to get data _OUT_ of AWS.
- Redgate's MySQL Compare did a great job of moving the Stored Procedures, Functions, and Indexes over that DMS leaves behind. 
- MySQL Enterprise Backup is a much more performant way to perform database backups than mysqldump. (Just remember that restores require the mysql daemon to be off on the target box)


### Challenges
-  Given the time restraint of this migration, we were unable to successfully set up a MySQL cluster for production. 
-  We managed to wrangle SELinux into submission, but at this point we still need to invest more time into understanding it fully.

### Things We should do next time
- Match versions from the get go. Migration is a bad time to perform upgrades, so let's make sure that's our first priority
- If possible, we should set up Navicat Monitor 
- We should build a script to scrape mysql system variables and compare them to the defaults. We should also use Percona's tool that autogenerates my.cnf and make some educated decisions for tuning. 
- I really think it's worth using Percona's tools instead of MySQL Enterprise. 

## MongoDB
### The Good  
- With some time investment, MongoDB Replication sets were quite easy to learn and understand. 
- Th

### Challenges
- As stated for MySQL, our biggest issue with MongoDB was version mismatch. We made some bad assumptions that wasted a lot of time. The upside is that 
- While the replSet was configured correctly, the php driver still needed tweaking to the readPreference to be able to make use of it. 
- We turned SELinux to permissive mode on the replication set as we ran out of time to configure it correctly. 

## Migration Night
- Went off without a hitch. 
- All of our time estimates were met and we were ready for testing on time. 

## Post Migration
- Performance issues 
	- MongoDB memory usage
		- Added Indexes for queries that were using in memory sort
		- fixed the readPreference of the php driver
	- MySQL Connections
		- Wouldn't have been an issue if we'd compared the system variables from their prod server in AWS
	- MySQL CPU Usage
		- Can sporadically shoot up
		- We need to identify poor running queries and see if we can take some load off of the system by building indexes.
	- MySQL Memory Usage
		- Low
		- We need to research why it's usually so little of its available memory. 
