```sql
CREATE DATABASE IIITIIIXXIVGzgzyanNA;
SHOW DATABASES;

CREATE USER rl_supplier_relations_officer@'127.0.0.1' IDENTIFIED BY 'Pa$$w0rd'; GRANT ALL ON IIITIIIXXIVGzgzyanNA TO rl_supplier_relations_officer@'127.0.0.1';
CREATE USER rl_sales_consultant@'127.0.0.1' IDENTIFIED BY 'Pa$$w0rd'; GRANT ALL ON IIITIIIXXIVGzgzyanNA TO rl_sales_consultant@'127.0.0.1';
CREATE USER rl_admin@'127.0.0.1' IDENTIFIED BY 'Pa$$w0rd'; GRANT ALL ON IIITIIIXXIVGzgzyanNA TO rl_admin@'127.0.0.1';
SELECT Host, User, Password FROM mysql.user WHERE User LIKE 'rl_%';
```

```bat
for %i in (rl_supplier_relations_officer rl_sales_consultant rl_admin) do @(echo.Checking user: %i&(echo.SHOW DATABASES; & echo.exit) | C:\xampp\mysql\bin\mysql -u%i -h 127.0.0.1 -pPa$$w0rd&echo.=====)
```
