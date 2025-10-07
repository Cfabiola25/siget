# Documentación Base de la Base de Datos – SIGET (Sistema de Información y Gestión de Torneos)
**Asignatura:** Bases de Datos  
**Docente:**  
Ing. Hely Suárez Marín  

**Integrantes:**  
- Nelly Fabiola Cano Oviedo  
- Néstor Iván Granados Valenzuela  

**Fecha:** Octubre / 9 / 2025  

---

## 🧠 Resumen del Problema
Las instituciones académicas y deportivas que organizan torneos enfrentan dificultades al manejar la información de manera manual o en archivos dispersos.  
La falta de un sistema centralizado genera errores en la programación de partidos, duplicidad de datos y poca trazabilidad de resultados.  

Esto ocasiona problemas de comunicación entre los encargados, retrasos en la actualización de estadísticas y escasa transparencia en el desarrollo de los eventos.  
A nivel operativo, la ausencia de control unificado impide obtener reportes confiables sobre el rendimiento de los equipos o el desempeño de los árbitros, afectando la eficiencia y la credibilidad del torneo.

---

## 💡 Solución
Se propone el desarrollo de **SIGET (Sistema de Información y Gestión de Torneos)**, una plataforma web sencilla y centralizada que estandariza la gestión de los torneos deportivos.  

**Operaciones principales:**
- Registro de equipos (nombre, ciudad, entrenador)  
- Registro de jugadores asociados a cada equipo  
- Registro de árbitros con licencia, categoría y estado activo  
- Programación de partidos (fecha, hora, sede)  
- Asignación de árbitros disponibles a cada partido  
- Registro de resultados (validando goles y estado)  
- Consulta de estadísticas automáticas derivadas de los resultados  

El acceso se realiza con roles **Administrador, Árbitro y Espectador**, garantizando que cada usuario solo gestione la información que le corresponde.

---

## 👥 Actores y Funciones

| **Actor** | **Funciones principales** |
|------------|-----------------------------|
| **Administrador** | Registra equipos, jugadores y árbitros; programa partidos; asigna árbitros; registra resultados; consulta estadísticas. |
| **Árbitro** | Supervisa o confirma los resultados de los partidos que dirige. |
| **Espectador** | Consulta resultados y estadísticas generales del torneo. |

---

## ⚙️ Reglas Clave del Sistema
- No se permite programar un partido donde el equipo local y visitante sean el mismo.  
- Un árbitro inactivo no puede ser asignado a un partido.  
- Los goles deben ser **mayores o iguales a cero** para partidos en estado *played*.  
- Las estadísticas se calculan dinámicamente a partir de los resultados.  
- Cada cambio queda registrado con **fecha, hora y usuario responsable**.  

---

## 1️⃣ Descripción general del proceso

El organizador registra equipos/jugadores y árbitros. Luego programa cada partido, asigna un árbitro y, al finalizar el encuentro, registra el resultado.  
Las estadísticas se consultan en cualquier momento con base en los resultados ya cerrados (*played*).

### 🗺️ Mapa de Procesos
![Mapa de Procesos](../uml/export/png/MapadeProcesos.png)

---

## 2️⃣ Revisión / Verificabilidad
Se observó la gestión tradicional de torneos en entornos académicos sin soporte informático formal.  
El registro de partidos y resultados se realiza mediante hojas de cálculo y grupos de mensajería, lo que genera inconsistencias, errores de comunicación y pérdida de información.  
Con **SIGET**, toda la información se centraliza en una base de datos relacional con reglas de integridad, evitando duplicidad y garantizando resultados verificables.

---

## 3️⃣ Diagramas UML para la Base de Datos

### 3.1 📌 Diagrama de Casos de Uso
Muestra las principales funciones del sistema y los actores involucrados.  
Los casos incluyen: Registrar Equipos, Jugadores, Árbitros, Programar Partido, Asignar Árbitro, Registrar Resultado y Consultar Estadísticas.

![Casos de Uso](../uml/export/png/usecase.png)

---

### 3.2 🧩 Diagrama de Clases
Representa las entidades principales del sistema y sus relaciones: **Equipo**, **Jugador**, **Árbitro** y **Partido**.

![Diagrama de Clases](../uml/export/png/class.png)

---

### 3.3 🔄 Diagrama de Estados
Describe el ciclo de vida del partido dentro del sistema.  
Estados posibles: *scheduled*, *played* y *cancelled*.

![Diagrama de Estados](../uml/export/png/state_match.png)

---

## 4️⃣ Relaciones de la Base de Datos

| **Entidad / Relación** | **Tipo de relación** |
|--------------------------|----------------------|
| Equipo (1) — (N) Jugador | Un equipo tiene varios jugadores. |
| Árbitro (1) — (N) Partido | Un árbitro puede dirigir varios partidos. |
| Equipo (1) — (N) Partido (rol local) | Un equipo puede ser local en varios partidos. |
| Equipo (1) — (N) Partido (rol visitante) | Un equipo puede ser visitante en varios partidos. |

---

## 5️⃣ Restricciones CHECK

| **Tabla** | **Restricción** |
|------------|----------------|
| matches | `home_team_id <> away_team_id` |
| matches | `status ∈ {scheduled, played, cancelled}` |
| matches | `home_goals, away_goals >= 0` |
| referees | `active ∈ {true, false}` |

---

## 6️⃣ Llaves Primarias (PK)

| **Tabla** | **Llave primaria** | **Descripción** |
|------------|--------------------|----------------|
| teams | id | Identificador único del equipo. |
| players | id | Identificador único del jugador. |
| referees | id | Identificador único del árbitro. |
| matches | id | Identificador principal del partido. |

---

## 7️⃣ Llaves Foráneas (FK)

| **Tabla** | **Columna FK** | **Referencia** | **Relación** |
|------------|----------------|----------------|---------------|
| players | team_id | teams(id) | Cada jugador pertenece a un equipo. |
| matches | home_team_id | teams(id) | Define el equipo local. |
| matches | away_team_id | teams(id) | Define el equipo visitante. |
| matches | referee_id | referees(id) | El árbitro que dirige el partido. |

---

## 8️⃣ Llaves Únicas (UNIQUE)

| **Tabla** | **Columna** | **Descripción** |
|------------|-------------|-----------------|
| teams | name | Cada equipo debe tener un nombre único. |
| referees | license_code | Ningún árbitro puede repetir número de licencia. |
| referees | email | El correo de árbitro debe ser único. |

---

## 9️⃣ Diagramas Complementarios UML

### 🧠 Actividades
![Actividad – Registrar Resultado](../uml/export/png/activity_registrar_resultado.png)

### 🔁 Comunicación
![Comunicación – Registrar Resultado](../uml/export/png/communication_registrar_resultado.png)

### ⏱️ Tiempo
![Timing – Match](../uml/export/png/timing_match.png)

### 📦 Paquetes
![Paquetes](../uml/export/png/package.png)

### ⚙️ Componentes
![Componentes](../uml/export/png/component.png)

### 🧱 Despliegue
![Deployment](../uml/export/png/deployment.png)

### 🧰 Instalación
![Instalación](../uml/export/png/installation.png)

---

## 🔚 Conclusión
El diseño de la base de datos del proyecto **SIGET** garantiza la integridad, trazabilidad y coherencia de la información del torneo.  
Las relaciones entre entidades reflejan fielmente los procesos de **registro, programación y resultados**.  
Este modelo, junto con los diagramas UML, constituye la base técnica sólida para el desarrollo futuro de la plataforma de gestión deportiva.
