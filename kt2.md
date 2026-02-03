```
CREATE DATABASE IIITIIIXXIVGzgzyanNA;
SHOW DATABASES;

CREATE USER rl_supplier_relations_officer@'127.0.0.1' IDENTIFIED BY 'Pa$$w0rd'; GRANT ALL ON IIITIIIXXIVGzgzyanNA TO rl_supplier_relations_officer@'127.0.0.1';
CREATE USER rl_sales_consultant@'127.0.0.1' IDENTIFIED BY 'Pa$$w0rd'; GRANT ALL ON IIITIIIXXIVGzgzyanNA TO rl_sales_consultant@'127.0.0.1';
CREATE USER admin@'127.0.0.1' IDENTIFIED BY 'Pa$$w0rd'; GRANT ALL ON IIITIIIXXIVGzgzyanNA TO admin@'127.0.0.1';
SELECT Host, User, Password FROM mysql.user WHERE User LIKE 'rl_%';
```
