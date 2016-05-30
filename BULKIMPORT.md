Identity Manager Bulk Loads
===========================


In OIM many transactions are part of a defined workflow. Those  
workflows may be started in an user interface or automatically as consequence
of an internal or external state change.

However, the state model and the dependencies become complicated soon. They
state evaluations also become a burden for performance tuning.

To be able to import big data segments, like users, authorization, etc.
application operations should be provided with a simple and clear technical
process. This process shall support working with lists and segements.


The Tools
---------

Identity Manager comes with the _OIM bulk load tools_ - a collection of batch
interfaces close to the database.  Supported data sources are _CSV text files_ 
and _database tables_.

The business logic of the job is primarily implemented in stored procedures,
called by Java classes, which in turn are called by several shell scripts.
Business objects/entities:

- users (incl. hierarchies)
- accounts (incl. hierarchies)
- role categories
- roles hierarchies
- role memberships

_Simple Entity Diagram:_

```
                       User Related Data        .      Setup Data
      
  +--------------+                              |
  | Organization |
  |     APT      |                              .
  +------+-------+
         |    +-------+                +------+ |
         |    |  Hier |                | Hier |
  +------A----v--+    |    +-----------v--+   | .   +----------------+
  |     User     |----+    |    Account   |---+     |  Role Categ.   |
  |     USR      +---------+      ACT     |     |   |                |
  +------+-------+         +--------------+         +----------------+
         |                                      .            |    +-------+
         |                                                   |    |  Hier |
  +------A-------+                              |   +--------v----v--+    |
  | Role Members.|                                  |      Role      |----+
  |              +----------------------------------+                |
  +------+-------+                              .   +----------------+

  Legend:    Hier .... Hierarchy
```


Relations between the entites are supported as well.  This is also true for
references to the same type of entity.

_Example: the "reports to" relation between users (like team lead) is
implemented as a second run after the data import.  The logical references are
replaced with the newly created technical (primary) keys of the USR table._

The bulk jobs disable several database integrity checks during the bulk insert. 
When the job data has been inserted/updated all defined integrity checks are
applied at once.


Data Structure
--------------

The data definition follows the implementation technology - the data structure
looks very much like the table definition in the OIM schema, we can use the
column names of the destination tables.

As an example, an user import may look like this:

```
USR_LOGIN,USR_FIRST_NAME,USR_LAST_NAME,USR_TYPE,USR_EMP_TYPE,USR_EMAIL,USR_PASSWORD
pwd21,Johnny,Passw21,End-User,Full-Time,pwd21@example.com,0940:J4SfeBy9fxiGXyiE7BS93Q==,
pwd22,Peter,Passw22,End-User,Full-Time,pwd22@example.com,0940:J4SfeBy9fxiGXyiE7BS93Q==,
pwd23,Tom,Passw23,End-User,Full-Time,pwd23@example.com,0940:J4SfeBy9fxiGXyiE7BS93Q==,
```

The first line as the header contain the column names, separated by comma.  All
other lines contain user data.  Don't put any spaces before or after the comma
and close each data line with a separator, otherwise the importer will add an
CRLF to the last field of the record.


User Passwords
--------------

There are two ways of setting the user password of imported records:

  1. copying the password from an existing reference user
  2. specifying an encrypted password for each record

Method 1 is used when the `USR_PASSWORD` column is missing, in case it's stated
the password will be set. For batch encryption of plaintext passwords see
project `oim-crypt`.





