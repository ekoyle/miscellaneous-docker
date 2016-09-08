# apache_db_redirect
Debian-based container to redirect everything for a host to a URL.

#SQL schema

```sql
CREATE TABLE host_redir (
    id serial primary key,
    fromhost varchar,
    tourl varchar
);

CREATE INDEX host_redir_host_index ON host_redir(host);
```

#Environment

Please set the following environment variables.

 * `DB_CONNSTR` - postgresql database connection string (ie. `dbname=<name> host=<hostname> user=<username>`)
 * `REDIR_FAILURE_BASE` - base URL to send unknown requests (set to `http://failed.example` to redirect failures to `http://failed.example/host=<failed_fromhost>`)

