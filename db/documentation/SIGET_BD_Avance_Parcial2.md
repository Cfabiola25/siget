# 🧾 Documentación Base de la Base de Datos – SIGET  
**Avance Segundo Parcial – Bases de Datos**

**Docente:**  
Ing. Hely Suárez Marín  

**Integrantes:**  
- Nelly Fabiola Cano Oviedo  
- Néstor Iván Granados Valenzuela  

**Fecha:**  
Octubre / 2025  

---

## 🧩 Resumen del Problema

Las instituciones educativas que organizan **torneos deportivos internos** enfrentan múltiples dificultades al registrar la información de sus equipos, árbitros y resultados de forma manual.  
El uso de hojas de cálculo y mensajería instantánea genera **errores de registro, pérdida de trazabilidad y duplicidad de datos**, lo que dificulta la gestión eficiente y el análisis del rendimiento de los equipos.

---

## 💡 Solución Propuesta

Se plantea el desarrollo del sistema **SIGET – Sistema de Información y Gestión de Torneos**, una plataforma web que centraliza la información de los torneos, optimiza el flujo operativo y mejora la toma de decisiones mediante estadísticas automáticas.

El sistema permitirá:

- Registrar equipos, jugadores y árbitros.  
- Programar y actualizar partidos.  
- Controlar resultados y calcular estadísticas automáticamente.  
- Garantizar la trazabilidad de cada evento deportivo.  

Los roles principales serán:

| **Rol** | **Funciones principales** |
|----------|----------------------------|
| **Administrador** | Supervisa la operación general, gestiona usuarios, roles y configuraciones globales. |
| **Organizador** | Registra equipos, jugadores y árbitros; programa los partidos y controla resultados. |
| **Árbitro** | Registra marcadores y estados del partido. |
| **Jugador** | Consulta calendario, resultados y rendimiento del equipo. |

---

## ⚙️ Reglas Clave del Sistema

- No se pueden registrar partidos con equipos duplicados (mismo equipo como local y visitante).  
- Un árbitro no puede dirigir dos partidos simultáneamente.  
- Los goles no pueden ser negativos.  
- El estado de un partido debe ser uno de los siguientes: `{scheduled, played, cancelled}`.  
- Todos los registros deben incluir fecha, hora y usuario responsable.

---

## 1️⃣ Descripción General del Proceso

El flujo operativo del sistema SIGET inicia con el registro de equipos y jugadores.  
Posteriormente, se programan los partidos asignando árbitros y horarios.  
Durante la ejecución, los árbitros registran los resultados y el sistema actualiza automáticamente las estadísticas de los equipos.  
Finalmente, los usuarios pueden visualizar reportes y métricas del desempeño global.

---

## 2️⃣ Revisión / Investigación de Verificabilidad

Durante la etapa de análisis, se revisaron los métodos actuales utilizados en instituciones deportivas locales.  
Se observó que la mayoría emplea herramientas informales como Excel o grupos de WhatsApp para coordinar partidos.  
Esto genera errores humanos, versiones inconsistentes y falta de control histórico de los datos, especialmente en eventos académicos con múltiples equipos.  

El modelo SIGET busca eliminar estos problemas mediante un sistema relacional robusto y validaciones automáticas.

---

## 3️⃣ Diagramas UML para la BD

### 3.1 Casos de Uso

El **diagrama de casos de uso** muestra las acciones principales de los distintos actores del sistema.

- El **Administrador** gestiona roles, usuarios y parámetros generales.  
- El **Organizador** crea equipos, registra árbitros y programa partidos.  
- El **Árbitro** ingresa los resultados y estados del encuentro.  
- Los **Jugadores** consultan los datos y estadísticas de su equipo.

📎 Archivo: 

[Diagrama Casos de Uso](../images/png/usecase.png)

---

### 3.2 Diagrama de Clases

El **diagrama de clases** representa las entidades del sistema y sus relaciones dentro de la base de datos.  
Muestra clases como **Equipo**, **Jugador**, **Árbitro**, **Partido** y sus asociaciones a través de llaves foráneas.  
Este modelo refleja directamente la estructura lógica del esquema `tournament_db`.

📎 Archivo: 

[Diagrama de Clases](../images/png/class.png)

---

### 3.3 Diagrama de Estados

El **diagrama de estados** representa el ciclo de vida de un partido.  
Inicia en `Programado (scheduled)`, puede cambiar a `Jugado (played)` o `Cancelado (cancelled)`, y actualiza las estadísticas según los resultados.

📎 Archivo: 

[Diagrama de Estado](../images/png/state_match.png)

---

## 4️⃣ Relaciones Principales

| **Relación** | **Tipo** | **Descripción** |
|---------------|----------|-----------------|
| equipo (1) — (N) jugador | 1:N | Un equipo tiene varios jugadores. |
| árbitro (1) — (N) partido | 1:N | Un árbitro puede dirigir múltiples partidos. |
| equipo (1) — (N) partido_local | 1:N | Un equipo puede ser local en varios partidos. |
| equipo (1) — (N) partido_visitante | 1:N | Un equipo puede ser visitante en varios partidos. |

---

## 5️⃣ Restricciones (CHECK)

| **Tabla** | **Condición** |
|------------|---------------|
| `matches` | `home_team_id <> away_team_id` |
| `matches` | `home_goals >= 0 AND away_goals >= 0` |
| `matches` | `status ∈ {scheduled, played, cancelled}` |

---

## 6️⃣ Llaves Primarias (PK)

| **Tabla** | **Llave Primaria** | **Descripción** |
|------------|--------------------|-----------------|
| `teams` | `id` | Identificador único del equipo. |
| `players` | `id` | Identificador único del jugador. |
| `referees` | `id` | Identificador único del árbitro. |
| `matches` | `id` | Identificador único del partido. |

---

## 7️⃣ Llaves Foráneas (FK)

| **Tabla** | **Columna FK** | **Referencia** | **Descripción** |
|------------|----------------|----------------|-----------------|
| `players` | `team_id` | `teams(id)` | Cada jugador pertenece a un equipo. |
| `matches` | `home_team_id` | `teams(id)` | Equipo local. |
| `matches` | `away_team_id` | `teams(id)` | Equipo visitante. |
| `matches` | `referee_id` | `referees(id)` | Árbitro asignado. |

---

## 8️⃣ Llaves Únicas (UNIQUE)

| **Tabla** | **Columna** | **Descripción** |
|------------|-------------|-----------------|
| `teams` | `name` | Evita nombres de equipos duplicados. |
| `referees` | `email` | Garantiza correos únicos por árbitro. |

---

## 9️⃣ Implementación SQL

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
  status ENUM('scheduled','played','cancelled'),
  home_goals INT CHECK (home_goals >= 0),
  away_goals INT CHECK (away_goals >= 0)
);
