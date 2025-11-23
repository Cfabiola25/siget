# **Documentación Base de la Base de Datos – SIGET**

**Sistema de Información y Gestión de Torneos Deportivos**

**Asignatura:** Bases de Datos
**Docente:** Ing. Hely Suárez Marín
**Institución:** Fundación de Estudios Superiores Comfanorte – FESC
**Integrantes:**

* Nelly Fabiola Cano Oviedo
* Néstor Iván Granados Valenzuela
  **Fecha:** Noviembre / 2025

---

# 1. Introducción

El proyecto **SIGET** tiene como finalidad optimizar la administración de torneos deportivos en contextos académicos y amateurs, donde la información suele gestionarse en hojas de cálculo, formularios dispersos y grupos de mensajería.
Este manejo informal genera duplicidad de datos, errores al registrar partidos y resultados, pérdida de trazabilidad y dificultades para obtener estadísticas confiables.

Para resolver estas problemáticas, se diseñó una **base de datos relacional** que actúa como núcleo del sistema, garantizando:

* Integridad referencial
* Consistencia en la información
* Reglas de negocio claramente aplicadas
* Trazabilidad de cambios
* Estadísticas derivadas de datos verificables

Esta documentación describe el **modelo conceptual, lógico y físico**, así como sus reglas, restricciones, normalización y vistas derivadas.

---

# 2. Modelo Conceptual (Entidad–Relación)

El modelo conceptual define los elementos fundamentales del dominio de SIGET y las relaciones entre ellos.

## 2.1 Entidades principales

| Entidad     | Descripción                                                               |
| ----------- | ------------------------------------------------------------------------- |
| **Team**    | Equipo participante en el torneo. Incluye nombre, ciudad y entrenador.    |
| **Player**  | Jugador perteneciente a un equipo, con datos personales y posición.       |
| **Referee** | Árbitro habilitado para dirigir encuentros, con licencia y estado activo. |
| **Match**   | Partido entre dos equipos, con fecha, hora, árbitro asignado y marcador.  |

## 2.2 Relaciones

| Relación                     | Cardinalidad | Descripción                                          |
| ---------------------------- | ------------ | ---------------------------------------------------- |
| **Team — Player**            | 1 : N        | Un equipo tiene varios jugadores.                    |
| **Team — Match (local)**     | 1 : N        | Un equipo puede ser local en múltiples partidos.     |
| **Team — Match (visitante)** | 1 : N        | Un equipo puede ser visitante en múltiples partidos. |
| **Referee — Match**          | 1 : N        | Un árbitro puede dirigir varios partidos.            |

📌 El diagrama ER se encuentra exportado como:
![Diagrama ER](../../modeling-and-docs/uml/export/modelo_er.jpg) 
---

# 3. Modelo Lógico (Relacional)

El modelo lógico traduce el ER en tablas relacionales con llaves primarias, foráneas, restricciones y reglas de integridad.

## 3.1 Tablas principales

| Tabla             | Contenido                          |
| ----------------- | ---------------------------------- |
| `teams`           | Equipos participantes              |
| `players`         | Jugadores asociados a equipos      |
| `referees`        | Árbitros con licencia y estado     |
| `matches`         | Partidos, asignaciones, resultados |
| `vw_team_matches` | Vista de partidos por equipo       |
| `vw_team_stats`   | Vista de estadísticas por equipo   |

📌 Diagrama relacional exportado como:
![Esquema Relacional](../../modeling-and-docs/uml/export/tournament_db%20-%20public.png) 

---

# 4. Normalización

El modelo cumple hasta **3FN**, garantizando integridad y evitando redundancia.

| Forma Normal | Evidencia                                              |
| ------------ | ------------------------------------------------------ |
| **1FN**      | Atributos atómicos (sin listas o multivalores).        |
| **2FN**      | PK simples → no hay dependencias parciales.            |
| **3FN**      | Sin dependencias transitivas entre atributos no clave. |

📌 Las estadísticas **no se almacenan**, se calculan dinámicamente en `vw_team_stats`.

---

# 5. Reglas de Negocio y Restricciones de Integridad

## 5.1 Reglas Clave del Sistema

* Un partido no puede tener el mismo equipo como local y visitante.
* Un árbitro inactivo no puede asignarse a un partido.
* Goles registrados deben ser **mayores o iguales a cero**.
* El estado del partido debe ser: `scheduled`, `played`, `cancelled`.
* Las estadísticas se derivan únicamente de partidos **played**.

## 5.2 CHECK Constraints

| Tabla     | Restricción                                    |
| --------- | ---------------------------------------------- |
| `matches` | `home_team_id <> away_team_id`                 |
| `matches` | `home_goals >= 0` y `away_goals >= 0`          |
| `matches` | `status IN ('scheduled','played','cancelled')` |

## 5.3 Primary Keys (PK)

| Tabla      | PK |
| ---------- | -- |
| `teams`    | id |
| `players`  | id |
| `referees` | id |
| `matches`  | id |

## 5.4 Foreign Keys (FK)

| Tabla     | FK           | Referencia   | Uso                           |
| --------- | ------------ | ------------ | ----------------------------- |
| `players` | team_id      | teams(id)    | Jugador pertenece a un equipo |
| `matches` | home_team_id | teams(id)    | Equipo local                  |
| `matches` | away_team_id | teams(id)    | Equipo visitante              |
| `matches` | referee_id   | referees(id) | Árbitro asignado              |

## 5.5 UNIQUE Constraints

| Tabla      | Campo        | Motivo                    |
| ---------- | ------------ | ------------------------- |
| `teams`    | name         | Evitar equipos duplicados |
| `referees` | license_code | Licencia única            |
| `referees` | email        | Contacto único            |

---

# 6. Implementación SQL

SIGET utiliza **PostgreSQL 14+** como motor recomendado.

## 6.1 Archivos incluidos

| Motor      | Archivo                 |
| ---------- | ----------------------- |
| PostgreSQL | `siget_schema.sql`      |
| PostgreSQL | `siget_schema_data.sql` |

## 6.2 Estructura base (extracto)

```sql
CREATE TABLE teams (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  coach_name VARCHAR(100),
  city VARCHAR(80),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE matches (
  id SERIAL PRIMARY KEY,
  home_team_id INT NOT NULL REFERENCES teams(id),
  away_team_id INT NOT NULL REFERENCES teams(id),
  referee_id INT REFERENCES referees(id),
  match_date DATE NOT NULL,
  match_time TIME NOT NULL,
  venue VARCHAR(150),
  status VARCHAR(20) CHECK (status IN ('scheduled','played','cancelled')),
  home_goals INT DEFAULT 0 CHECK (home_goals >= 0),
  away_goals INT DEFAULT 0 CHECK (away_goals >= 0),
  created_at TIMESTAMP DEFAULT NOW(),
  CONSTRAINT chk_teams_different CHECK (home_team_id <> away_team_id)
);
```

---

# 7. Vistas SQL

## 7.1 `vw_team_matches`

* Relaciona equipos con partidos
* Indica si el equipo jugó como local o visitante

## 7.2 `vw_team_stats`

* Calcula:

  * Partidos jugados
  * Ganados
  * Empatados
  * Perdidos
* Solo usa partidos en estado `played`

Estas vistas garantizan estadísticas consistentes sin duplicar datos.

---

# 8. Guía de Ejecución (PostgreSQL — DBeaver)

1. Conectarse al motor PostgreSQL como superusuario.
2. Ejecutar `siget_schema.sql` en la base general.
3. Crear base `tournament_db` (si no existe).
4. Ejecutar el resto del script dentro de esta base (sin usar `\c`).
5. Verificar creación de tablas, tipo `match_status`, índices y vistas.

---

# 9. Conclusión

La base de datos del sistema **SIGET** está diseñada para garantizar integridad, trazabilidad y consistencia en la gestión del torneo.
El modelo ER, su traducción al modelo relacional y la implementación SQL establecen una estructura clara y escalable que soporta procesos clave como registro de entidades, programación de partidos, arbitraje, resultados y estadísticas.

Este trabajo constituye la base técnica para el desarrollo de la plataforma SIGET y una referencia sólida para futuras ampliaciones académicas.

