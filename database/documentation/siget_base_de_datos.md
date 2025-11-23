# 🧾 Documentación Base de la Base de Datos – SIGET

**Proyecto:** Sistema de Información y Gestión de Torneos (SIGET)
**Asignatura:** Bases de Datos
**Docente:** Ing. Hely Suárez Marín
**Institución:** Fundación de Estudios Superiores Comfanorte – FESC
**Integrantes:**

* Nelly Fabiola Cano Oviedo
* Néstor Iván Granados Valenzuela
  **Fecha:** Noviembre / 2025

---

## 1️⃣ Introducción

El proyecto **SIGET** busca optimizar la gestión de torneos deportivos en contextos académicos y amateurs.
En muchos casos, la información se maneja mediante hojas de cálculo y mensajería instantánea, lo que genera duplicidad de datos, errores en los resultados y pérdida de trazabilidad.

Esta documentación describe el diseño de la **base de datos relacional** que soporta SIGET. El modelo está orientado a garantizar integridad referencial, consistencia y soporte para estadísticas automáticas del torneo.

---

## 2️⃣ Modelo Conceptual (Entidad–Relación)

El **modelo conceptual** define las entidades principales del dominio y sus relaciones.

### 🧱 Entidades principales

| Entidad     | Descripción                                                              |
| ----------- | ------------------------------------------------------------------------ |
| **Team**    | Representa a un equipo participante (nombre, ciudad, entrenador).        |
| **Player**  | Jugador perteneciente a un equipo, con información básica y posición.    |
| **Referee** | Árbitro habilitado para dirigir partidos, con licencia y estado activo.  |
| **Match**   | Partido entre dos equipos, con árbitro asignado, fecha, hora y marcador. |

### 🔗 Relaciones clave

| Relación                 | Tipo | Descripción                                       |
| ------------------------ | ---- | ------------------------------------------------- |
| Team — Player            | 1:N  | Un equipo puede tener muchos jugadores.           |
| Team — Match (local)     | 1:N  | Un equipo puede ser local en varios partidos.     |
| Team — Match (visitante) | 1:N  | Un equipo puede ser visitante en varios partidos. |
| Referee — Match          | 1:N  | Un árbitro puede dirigir varios partidos.         |

### 📊 Diagrama ER

![Diagrama ER](../../modeling-and-docs/uml/export/modelo_er.jpg)
---

## 3️⃣ Modelo Lógico (Relacional)

El **modelo lógico** traduce las entidades y relaciones del ER a tablas con llaves primarias, foráneas y restricciones de integridad.

### Tablas principales

| Tabla             | Descripción                                         |
| ----------------- | --------------------------------------------------- |
| `teams`           | Equipos participantes.                              |
| `players`         | Jugadores y su pertenencia a equipos.               |
| `referees`        | Árbitros con datos de contacto y estado activo.     |
| `matches`         | Partidos programados, con resultado y estado.       |
| `vw_team_matches` | Vista de partidos por equipo (rol local/visitante). |
| `vw_team_stats`   | Vista de estadísticas básicas por equipo.           |

### ⚙️ Esquema relacional

![Esquema Relacional](../../modeling-and-docs/uml/export/tournament_db%20-%20public.png)

---

## 4️⃣ Normalización

El diseño cumple con **Tercera Forma Normal (3FN)**:

| Forma Normal | Cumplimiento                                                  |
| ------------ | ------------------------------------------------------------- |
| **1FN**      | Atributos atómicos, sin listas ni campos multivalor.          |
| **2FN**      | Claves primarias simples → no hay dependencias parciales.     |
| **3FN**      | No existen dependencias transitivas entre atributos no clave. |

🔎 Las estadísticas **no** se almacenan como columnas acumuladas; se calculan desde los partidos *played* a través de vistas (`vw_team_stats`), lo que evita inconsistencias.

---

## 5️⃣ Restricciones y Reglas de Negocio

| Tipo            | Tabla    | Restricción                                             | Descripción                                  |
| --------------- | -------- | ------------------------------------------------------- | -------------------------------------------- |
| **CHECK**       | matches  | `home_team_id <> away_team_id`                          | Impide partidos con el mismo equipo.         |
| **CHECK**       | matches  | `home_goals >= 0 AND away_goals >= 0`                   | Goles no negativos.                          |
| **CHECK**       | matches  | `status IN ('scheduled','played','cancelled')`          | Control del ciclo de vida del partido.       |
| **UNIQUE**      | teams    | `name`                                                  | Evita equipos duplicados.                    |
| **UNIQUE**      | referees | `license_code`, `email`                                 | Cada árbitro tiene licencia y correo únicos. |
| **FOREIGN KEY** | players  | `team_id → teams(id)`                                   | Cada jugador pertenece a un equipo.          |
| **FOREIGN KEY** | matches  | `home_team_id → teams(id)` / `away_team_id → teams(id)` | Relación con equipos local/visitante.        |
| **FOREIGN KEY** | matches  | `referee_id → referees(id)`                             | Relación con árbitros.                       |

---

## 6️⃣ Implementación SQL

La base fue implementada principalmente en **PostgreSQL 14+** (compatible con MySQL 8+ con ligeros ajustes de tipos).

| Motor      | Archivo                 | Descripción                            |
| ---------- | ----------------------- | -------------------------------------- |
| PostgreSQL | `siget_schema.sql`      | Esquema base con tablas, FKs y vistas. |
| PostgreSQL | `siget_schema_data.sql` | Datos de ejemplo para pruebas.         |

### 🧩 Tablas principales (extracto)

> *(Fragmento ilustrativo, alineado con tu `schema.sql`)*

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
