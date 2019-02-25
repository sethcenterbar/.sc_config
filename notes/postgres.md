# Tables:

Same as other dbs


# Views: 

Virtual tables like in other dbs, can also be used as security around records


# Schemas: 

Same, used typically for user permissions around databases


# Tablespaces:

A table space is a storage location where the actual data that is underlying the db objects is stored.

They are a layer of abstraction between the physical and logical data and serves to allocate storage for all rdms managed sections.

### Default tablespaces in postgres
Pg_default -- storing users data
Pg_global -- storing system data


# Functions

A Block of reusable SQL code.
This code can return a scalar value of a list of records or composite objects.

These are stored at the schema level.

### Example functions
get_customer_balance



# Sequences

Used to manage sequences that have incrementing unique values.

look like actor_actor_id_seq (actor table, on actor_id)

```sql
-- Create the sequence
CREATE SEQUENCE public.actor_actor_id_sq
	INCREMENT 1
	START 200
	MINVALUE 1
	MAXVALUE 9223372036854775807
	CACHE 1;

-- Change the owner to the postgres user
ALTER SEQUENCE public.actor_actor_id_seq
	OWNER TO postgres;
```

# Extension

Used to wrap other objects into a single unit. 
Makes it easier to maintain objects.
Casts, indexes, functions, etc can be wrapped into extensions
I have no idea what this is for lol.


# PostgreSQL Roles Management

Roles can be:
- Users
- Groups

Roles can own tables, functions, etc. 
They can assign privileges on other roles. 
Roles can inherit from other roles. 
Roles that have login rights are known as users.

DB Roles are global across a database cluster.
DB Roles are completely separate from OS users. 

```sql
CREATE ROLE rolename;
```

## Role Attributes

Only roles with the login attribute can be used as the inital role name for a db connection. These can be considered the same as a db user. 

```sql
CREATE ROLE name LOGIN;
CREATE USER name; -- Creates user and assumes LOGIN
```

### Super User

```sql
CREATE ROLE existing_role_name SUPERUSER;
```

## Database Creation 

A role must be explicitely given permission to create databses (except superusers)

```sql
CREATE ROLE name CREATEDB;
```

## Role creation

A role must be explicitely given permission to create more roles (except superusers)

```sql
CREATE ROLE name CREATEROLE;
```

This role can alter and drop other roles and grant or revoke membership in them.

## Initiating replication

A role must be explicitely given permission to initiate replication 

```sql
CREATE ROLE yeet REPLICATION LOGIN;
```

## Password
Only significant if the client authentication method requires it

```sql
CREATE ROLE name PASSWORD "string";
```

## Best practice
Create a role that has the CREATEDB and CREATEROLE privileges, but not the superuser privileges.
This allows you to not use a superuser when you don't have to.

## Role Membership
Grouping users together to ease management of privileges.
Priviliges can be granted or revoked from a group.
Create a role that represents the group then grant membership in group role to individual user roles.

# Database backups

Pg_dump (single database backup) -- dump, good for small dbs
Pg_dumpall (all database backup)
pgadmin (gui to use the dump)

# PostgreSQL tablespace

A location on disk where pgsql stores data

## Advantages:
- If a partition is running out of space, you can create a new tablespace on a different partition
- You can use the statistics of database objects usages to optimize the performance of the databases.

# Create a postgres tablespace
```sql
CREATE TABLESPACE tablespace_name
OWNER user_name
LOCATION directory_path;
```
```sql
ALTER TABLESPACE action;
ALTER TABLESPACE tblspc_name RENAME TO new_name;
ALTER TABLESPACE tblspc_name OWNER TO new_owner;
```
```sql
DROP TABLESPACE IF EXISTS tablespc_name;
```





