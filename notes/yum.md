# Yum

## Commands worth writing down
yum list installed | grep mysql --> Installed being most of the packages we care about
sudo yum remove mysql-commercial-backup.x86_64 --> Removing a package
sudo yum install htop --> installing a package
yum history --> lists dates of the changes and who made them


# run this for our outages to update everything but the kernel.
sudo yum -x 'kernel*' update 
