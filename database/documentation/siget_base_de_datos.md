# 🧾 Documentación Base de la Base de Datos – SIGET

**Proyecto:** Sistema de Información y Gestión de Torneos (SIGET)  
**Asignatura:** Bases de Datos  
**Docente:** Ing. Hely Suárez Marín  
**Institución:** Fundación de Estudios Superiores Comfanorte – FESC  
**Integrantes:**  
- Nelly Fabiola Cano Oviedo  
- Néstor Iván Granados Valenzuela  
**Fecha:** Octubre / 2025  

---

## 1️⃣ Introducción

El proyecto **SIGET** busca optimizar la gestión de torneos deportivos en contextos académicos y amateurs.  
Actualmente, muchas instituciones registran información en hojas de cálculo y grupos de mensajería, lo que ocasiona duplicidad de datos, errores en resultados y pérdida de trazabilidad.  

Esta documentación detalla el diseño e implementación de la **base de datos relacional** que sustenta el sistema SIGET.  
El modelo garantiza integridad referencial, consistencia de datos y soporte para la generación automática de estadísticas del torneo.

---

## 2️⃣ Modelo Conceptual (Entidad–Relación)

El **modelo conceptual** define las entidades principales del dominio y sus relaciones.  
Cada entidad representa un actor o componente esencial del torneo.

### 🧱 Entidades Principales

| Entidad | Descripción |
|----------|--------------|
| **Team** | Representa a un equipo participante (nombre, ciudad, entrenador). |
| **Player** | Jugador perteneciente a un equipo, con información personal y posición. |
| **Referee** | Árbitro habilitado para dirigir partidos, con licencia y estado activo. |
| **Match** | Partido entre dos equipos, con árbitro asignado, fecha, hora y marcador. |

### 🔗 Relaciones Clave

| Relación | Tipo | Descripción |
|-----------|------|--------------|
| Team — Player | 1:N | Un equipo tiene muchos jugadores. |
| Team — Match (local) | 1:N | Un equipo puede ser local en varios partidos. |
| Team — Match (visitante) | 1:N | Un equipo puede ser visitante en varios partidos. |
| Referee — Match | 1:N | Un árbitro puede dirigir varios partidos. |

### 📊 Diagrama ER

![Diagrama ER](../../modeling-and-docs/uml/export/modelo_er.jpg)

---

## 3️⃣ Modelo Lógico (Relacional)

El **modelo lógico** traduce las entidades y relaciones del ER a tablas con llaves primarias, foráneas y restricciones de integridad.

| Tabla | Descripción |
|--------|--------------|
| `teams` | Almacena los equipos participantes. |
| `players` | Contiene los jugadores y su pertenencia a equipos. |
| `referees` | Registra árbitros activos e información de contacto. |
| `matches` | Registra los partidos programados, sus resultados y estado. |

### ⚙️ Esquema Relacional

![Esquema Relacional](../../modeling-and-docs/uml/export/tournament_db%20-%20public.png)

---

## 4️⃣ Normalización

El diseño cumple con la **Tercera Forma Normal (3FN)** garantizando integridad y evitando redundancia.

| Forma Normal | Cumplimiento | Ejemplo |
|---------------|--------------|----------|
| **1FN** | Todos los atributos son atómicos. | Cada jugador tiene un solo número de camiseta. |
| **2FN** | Todos los atributos dependen completamente de la PK. | `team_id` depende solo de `players.id`. |
| **3FN** | No hay dependencias transitivas. | `email` pertenece a la entidad árbitro, no a otra. |

📘 *Las estadísticas no se almacenan directamente; se calculan dinámicamente desde los partidos jugados.*

---

## 5️⃣ Restricciones y Reglas de Negocio

| Tipo | Tabla | Restricción | Descripción |
|------|--------|-------------|--------------|
| **CHECK** | matches | `home_team_id <> away_team_id` | Evita partidos con el mismo equipo. |
| **CHECK** | matches | `home_goals >= 0 AND away_goals >= 0` | Goles no negativos. |
| **CHECK** | matches | `status ∈ {scheduled, played, cancelled}` | Controla el ciclo de vida del partido. |
| **UNIQUE** | teams | `name` | No permite equipos duplicados. |
| **UNIQUE** | referees | `license_code`, `email` | Cada árbitro debe ser único. |
| **FOREIGN KEY** | players | `team_id → teams(id)` | Cada jugador pertenece a un equipo. |
| **FOREIGN KEY** | matches | `referee_id → referees(id)` | Cada partido tiene un árbitro asignado. |

---

## 6️⃣ Implementación SQL

El diseño fue implementado para **PostgreSQL 14+** y **MySQL 8+**, garantizando compatibilidad con ambos motores.

| Motor | Archivo | Descripción |
|--------|----------|-------------|
| PostgreSQL | `../../database/db/dumps/postgres/siget_schema.sql` | Esquema base con constraints y vistas. |
| PostgreSQL | `../../database/db/dumps/postgres/siget_schema_data.sql` | Inserciones demo para pruebas. |

---

### 🔍 Tablas Principales

```sql
CREATE TABLE teams (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  coach_name VARCHAR(100),
  city VARCHAR(80)
);

CREATE TABLE matches (
  id SERIAL PRIMARY KEY,
  home_team_id INT REFERENCES teams(id),
  away_team_id INT REFERENCES teams(id),
  referee_id INT REFERENCES referees(id),
  match_date DATE,
  match_time TIME,
  status VARCHAR(20) CHECK (status IN ('scheduled','played','cancelled')),
  home_goals INT CHECK (home_goals >= 0),
  away_goals INT CHECK (away_goals >= 0)
);
