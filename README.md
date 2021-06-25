# alembic-sqlalchemy-example

It is just a example using [Alembic](https://alembic.sqlalchemy.org/en/latest/) with PostgreSQL.
- **Alembic** - Alembic provides for the creation, management, and invocation of change management scripts for a relational database, using SQLAlchemy as the underlying engine.

Steps to use:
1. Create database first in postgres. Once, database creates mention postgres database name and credentials in `config.py` and `alembic.ini` files.
    ```postgres-sql
    create database <dbname-here>;
    ```
2. Install requirements in virtual environment:
   ```shell
   $ make create-env
   $ make install-requirements
   ```
3. Now, follow below commands one-by-one:
    ```shell
    $ # Apply migrations
    $ make db-upgrade
    $ # Autogenerate migration scripts
    $ MESSAGE="some message" make db-revision
    $ # Generate raw query as in .sql file. 
    $ make db-raw-query
    ```
4. There are more commands just execute `make help` command on terminal.
   ```shell
   $ make help
   # This is self documentation
   alembic-init                   Initiate database migrations
   clean                          Remove unwanted stuff
   compile-requirements           Perform pip-compile
   create-env                     Create virtual environment
   db-raw-query                   Get raw SQL query.
   db-revision                    alembic revision
   db-upgrade                     Prepare for database migrations
   install-requirements           Install requirements
   lint-black                     Preform code linting using black
   lint-flake                     Perform code linting by flake8
   security-check                 Security check
   ```