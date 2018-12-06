# SELinux

## Dictionary
*DAC* --> Discretionary access control
*MAC* --> Mandatory access control
*Security Context Label* --> The colon delimited label given by SELinux to every object on the system. Passing the -Z parameter to many linux commands will return it. 
*Type Enforcement* --> (TE) Targeted policies rely mostly on the _type_ attribute of the Security Context Label, so we say it uses type enforcement. 
*Domain* --> in the context of _processes_, we typically call the type field the domain because this implementation allows us to run processes 'sandboxed' in their own domains. 
*Access Vector Cache* --> (AVC) The result of a policy lookup is stored in the AVC to make policy decisions faster.	 
*Policy Package* --> What the .pp extension stands for. These are binary files.

## Modes
Disabled
	- SELinux Turned Off
	- No Enhancing
	- Leaves on DAC
Permissive
	- SELinux Turned On
	- Policy Loaded
	- Not Enforcing the policy (Permits all access)
	- Logs what would have been denied
	- Labels objects
Enforcing
	- SELinux Turned On
	- Policy Loaded
	- Enforcing the Policy
$ getenforce --> returns whether or not we are enforcing selinux policies on this machine
$ sestatus --> returns info about selinux on our box, included whether or not it is enforcing
$ setenforce --> takes a 1 or 0 to change from enforcing mode to permissive mode
/etc/selinux/config --> selinux config file to make persistent changes to selinux

## Labels
SELinux Labels contain
	- User
	- Role
	- *Type*
	- Level
	
user_u:role_r:type_t:level --> all objects get labeled with an SELinux Security Context. Policies use these contexts to enforce policies

## Policy Types
Targeted Policy 
	- Default policy on rhel based distros
	- Most likely policy we'll have to work with
MLS
	- Multi Level Security
	- Designed for government-grade security
	- Complex 
	- Unlikely to be used in our data center
Minimum
	- Bare bones version of Targeted for low spec machines
	- Build and load policies just for specific services.


## Policy Config Files
SELinux policies work on the principle of modules that can be dynamically loaded or unloaded into the kernal at run time. 
/etc/selinux/targeted/ --> the location of our targeted policy

## Types
Type Enforcement (TE)

	- Think of it as the type in *user_u:role_r:type_t:level*
	-	Objects with the same security requirements get grouped together into the same type, then objects of the same type are allowed to interact with eachother.
	-	Domains use the type field to limit interaction between processes using Type Enforcement.
	- unconfined_t is a domain that doesn't have an selinux policy that confines it to a domain. Typically user processes and custom software will run in this domain. 
$ seinfo -t --> see a list of selinux types available from the current policy
	- Type is the most important thing to understand about SELinux, you could almost get away without knowing about the other 3
system_u is used for system processes

## Users
By default, users are mapped to the unconfined_u selinux user. 
$ seinfo -u --> shows a list of the defined users in the current policy
$ semanage login -l --> mapping of linux users to selinux users

## Roles
Not used frequently in the targeted policy. 
Roles can be accessed by users.
$ seinfo -r --> shows the roles in the current policy
system_r is used for system processes
	
## Levels
Only used in the MLS Policy. Disregard.

## Decision making process
	- Default answer = No!
	- All allowed access requires an Allow Rule
	- Deny messages get logged to the SELinux Log files
	- The result of a policy looked is stored in the Access Vector Cache (quicker decision making)
	- Using Targeted Policy, SELinux is using the type field to decide if access is allowed.
	- SELinux sits on previously existing DAC rules.

## The Targeted Policy
	- Type Enforcement Targets (confines) specific daemons
		- Network Facing
		- Start at Boot
	- User processes often aren't targeted and usually run in the unconfined_t domain.
$ seinfo -aunconfined_domain_type -x --> list out all unconfined domains in our current policy
	- Everything _not_ targeted runs in an unconfined domain, only subject to DAC

## Allow Rules
	- Allow Access (AKA Policy Rules)
$ sesearch --allow --> Show allow rules in the current policy. Huge output, grep it. 
*allow http_d httpd_content_type : file { ioctl read getattr lock open };*
	- allow --> the allow rule
	- http_d httpd_content_type --> any object with the http_d type (in the http domain) can access objects with httpd_content_type
	- file --> as long as the object is a file
	- { ioctl read getattr lock open } --> This type of access is allowed

## Policy Module
	- SELinux Policies are based on the idea of loadable kernel module. 
	- We can dynamically load and unload policy moduals, but they most be manually loaded. 
$ semodule -l --> show list of loaded policy modules
/etc/selinux/targeted/modules/active/modules --> module files in raw form (list from  semodule command)

## Policy Packages
	- .pp extension means policy package file. (binary files). 
$ semodule -d xen --> disable/unload the xen module. (Recompiles and reloads the entire policy)
	- All policy packages are combined together into a single policy binary, which is loaded into memory as the active policy.
/etc/selinux/targeted/policy --> the monolithic policy binary 

## Default file contexts
/etc/selinux/targeted/contexts/files/file_contexts --> contains the default file context for the entire file system

## Booleans
	- SELinux booleans are simple on off settings.
$ getsebool -a --> lists all of the possible settings that can be set and unset using booleans. grep it
$ semanage boolean -l --> list the boolean settings with a description of what they do.
$ setsebool samba_export_all_ro on -P  --> or 1, or true.. -P makes the boolean change persist by making a new version of the policy and reloading it into the kernel
/etc/selinux/targeted/modules/active/booleans.local --> this file shows the changes you've made to the policy.

## Audit2Allow
	- A tool that takes selinux error messages and uses them to create new rules
$ chcon -t user_home_t /var/www/html/index.html --> change context type to user_home_t of file index.html
$ grep AVC /var/log/audit/audit.log --> Shows AVC errors in the audit log
$ audit2allow -wa --> shows error messages with a human readable reason
$ audit2allow -aM --> checks the audit log for errors and makes a new module package
$ semodule -i test.local.pp --> adds the given policy package to the module
	- Only create a new policy if absolutely neccesary. First, try:		
		- Booleans
		- Types
		- Labels

## Permissive Domains
	- Allows us to put specific domains into permissive mode
	- This is favorable to putting the entire system into permissive mode
$ semanage permissive -l --> shows a list of permissive domains on our system
$ seinfo --> shows general informatio about selinux
$ semanage permissive -a domain_name --> adds domain_name to use permissive mode
$ semodule -d test.local --> disables the test.local policy rule 
$ semodule -r test.local --> removes the test.local policy rule

## Troubleshooting
### Best Practices & Common Mistakes
	- Installing and running programs in nonstandard directories, running services against non standard points, etc can cause issues with selinux. 
	- SELinux types are inherited by parent directories. Be aware of where you're creating files for a custom program
	- Switch selinux to permissive mode using setenforce 0 to test if an issue is related to selinux
	- When working with the target policy, we can be pretty sure the issue is type related. 

### More about Labels
$ semanage fcontext -at httpd_sys_content_t "/www(/.*)?" --> This creates a local rules that says any files in www/ should by default get an selinux type of httpd_sys_content_t*
$ restorecon -R -v /www --> should set all files in this directory recursively to the conext we created above. 
	- To make sure this worked, setenforce 1 and make sure it works now.
	- Copied files inherit their context from the new directory. 
	- Moved files will keep their context.
	- To preserve the context when copying files, pass -c 
$ cp -c /www/index.php /web --> copies index.php to web maintaining the context label.
	- When switching from disabled to permissive, selinux will have to label the filesystem after a reboot. 
	- To force a relabel on boot, create a file called autorelabel in the root directory
$ touch /.autorelabel --> resets selinux back to default values on boot. remove the file after done.
	- chcon doesn't update the file_contexts file.
$ getfatter -m security.selinux -d /var/index.html --> show information about the label.
$ semanage fcontext -at httpd_sys_content_t "/web(/.*)?" --> fcontext: manage file context mappings -at:add type mapping httpd_sys_content_t: type to map /web...: the location we want to map it to.*
/etc/selinux/targeted/contexts/files/file_contexts.local --> The file that is changed by the semanage fcontext command

### Logs
	- We should run auditd and setroubleshootd
/var/log/messages --> where messages go if auditd isn't running.
/var/log/audit/audit.log --> where messages go if auditd is running.
	- if auditd and setroubleshootd are both running, logs go to both places.
$ grep "SELinux is preventing" /var/log/messages --> shows useful selinux logs and commands to run for more info
$ grep denied /var/log/audit/audit.log --> shows avc denied messages 

## Don't Audit
	- Not all denies get logged.
	- Don't bother reporting denials that have a high probability of not hurting the system.
$ seinfo | grep Dontaudit --> shows how many denies we aren't auditing
$ semodule -DB --> Disable Dontaudit logs so we can see all logs for the system
$ semodule -B --> Enable Dontaudit to decrease logging on unneccesary denies. 
