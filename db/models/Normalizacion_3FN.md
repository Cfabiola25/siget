# Normalización hasta 3FN

**1FN**: Todos los atributos son atómicos; no hay listas ni grupos repetidos.

**2FN**: No existen dependencias parciales; todas las tablas usan PK simple (`id`).

**3FN**: No hay dependencias transitivas entre atributos no clave. Atributos como `email` y `license_code` pertenecen a sus entidades. Las estadísticas se derivan de `matches`, por lo que no se almacenan para evitar anomalías de actualización.
