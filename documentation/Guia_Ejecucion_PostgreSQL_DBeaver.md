# Guía rápida: ejecutar el script en PostgreSQL con DBeaver

1) Conéctate a la base **postgres** y ejecuta:
```sql
DROP DATABASE IF EXISTS tournament_db WITH (FORCE);
CREATE DATABASE tournament_db;
```
2) Cambia la conexión del editor a **tournament_db** y ejecuta el resto del script (sin `\c`):
`BaseDeDatos/SQL/tournament_postgres.sql`.
