# Documentación Base de la Base de Datos – SIGET (Sistema de Información y Gestión de Torneos)
**Asignatura:** Bases de Datos  
**Docente:**  
Ing. Hely Suárez Marín  

**Integrantes:**  
- Nelly Fabiola Cano Oviedo 
- Néstor Iván Granados Valenzuela  

**Fecha:** Octubre / 9 / 2025  

---

## **Resumen del Problema**

Las instituciones académicas y deportivas que organizan torneos enfrentan dificultades al manejar la información de manera manual o en archivos dispersos. La falta de un sistema centralizado genera errores en la programación de partidos, duplicidad de datos y poca trazabilidad de resultados.  
Esto ocasiona problemas de comunicación entre los encargados, retrasos en la actualización de estadísticas y escasa transparencia en el desarrollo de los eventos.  
A nivel operativo, la ausencia de control unificado impide obtener reportes confiables sobre el rendimiento de los equipos o el desempeño de los árbitros, afectando la eficiencia y la credibilidad del torneo.

---

## **Solución**

Se propone el desarrollo de **SIGET (Sistema de Información y Gestión de Torneos)**, una plataforma web sencilla y centralizada que estandariza la gestión de los torneos deportivos.  
El sistema permitirá realizar las siguientes operaciones:

- Registro de **equipos** (nombre, ciudad, entrenador).  
- Registro de **jugadores** asociados a cada equipo.  
- Registro de **árbitros** con licencia, categoría y estado activo.  
- **Programación de partidos**, con control de fechas, horas y sedes.  
- **Asignación de árbitros** disponibles a cada partido.  
- **Registro de resultados**, validando goles y estado del partido (*scheduled, played, cancelled*).  
- **Consulta de estadísticas** automáticas por equipo, derivadas de los resultados almacenados.

El acceso estará basado en roles (Administrador, Árbitro y Espectador), garantizando que cada usuario gestione solo la información correspondiente a su función.  
El sistema reforzará la trazabilidad y la integridad mediante validaciones de negocio, restricciones en la base de datos y relaciones bien definidas.

---

## **Actores y Funciones**

| **Actor** | **Funciones principales** |
|------------|----------------------------|
| **Administrador** | Registra equipos, jugadores y árbitros; programa partidos; asigna árbitros; registra resultados; consulta estadísticas. |
| **Árbitro** | Supervisa o confirma los resultados de los partidos que dirige. |
| **Espectador** | Consulta resultados y estadísticas generales del torneo. |

---

## **Reglas Clave del Sistema**

- No se permite programar un partido donde el equipo local y visitante sean el mismo.  
- Un árbitro inactivo no puede ser asignado a un partido.  
- Los goles deben ser **mayores o iguales a cero** para partidos en estado *played*.  
- Las estadísticas se generan a partir de los resultados reales (no se almacenan acumuladas).  
- Cada cambio debe quedar registrado con fecha, hora y usuario responsable.  

---

## **1. Descripción general del proceso**

### **Flujo de Proceso**

El organizador del torneo registra los equipos, jugadores y árbitros disponibles.  
Posteriormente, programa los partidos y asigna los árbitros correspondientes.  
Al finalizar cada encuentro, el resultado se registra en el sistema, actualizando las estadísticas generales de los equipos.  
Las vistas de estadísticas permiten consultar información resumida de partidos jugados, ganados, empatados o perdidos.


[Mapa de Procesos](MapadeProcesos.png)
---

## **2. Revisión / Investigación de Verificabilidad**

Se observó la gestión tradicional de torneos en entornos académicos sin soporte informático formal.  
El registro de partidos y resultados se realiza mediante hojas de cálculo y grupos de mensajería, lo que genera inconsistencias, errores de comunicación y pérdida de información.  
Este enfoque carece de mecanismos de control, duplicando esfuerzos y afectando la credibilidad de los resultados.  
Con **SIGET**, toda la información se centraliza en una base de datos relacional con reglas de integridad, evitando la duplicidad y garantizando resultados verificables.

---

## **3. Diagramas UML para la Base de Datos**

### **3.1 Diagrama de Casos de Uso**

El diagrama de casos de uso ilustra las principales funciones del sistema y los actores involucrados.  
Muestra la interacción entre **Administrador**, **Árbitro** y **Espectador**.  
El Administrador tiene control total sobre el registro de entidades y operaciones; el Árbitro interviene en la validación de resultados; y el Espectador solo consulta información.  
Los casos incluyen: *Registrar Equipos*, *Registrar Jugadores*, *Registrar Árbitros*, *Programar Partido*, *Asignar Árbitro*, *Registrar Resultado* y *Consultar Estadísticas*.

[Casos de Uso](usecase.png)

---

### **3.2 Diagrama de Clases**

El diagrama de clases representa la estructura estática del sistema, mostrando las entidades y sus relaciones.  
Incluye las clases principales:  
- `Equipo`  
- `Jugador`  
- `Árbitro`  
- `Partido`  

Las asociaciones definen que un equipo tiene muchos jugadores, que cada partido involucra dos equipos y un árbitro, y que el estado del partido determina la validez de los resultados.  
Este modelo refleja la estructura de la base de datos relacional **siget_db**.

[Diagrama de Clases](class.png)

---

### **3.3 Diagrama de Estados**

El diagrama de estados describe el ciclo de vida de un partido dentro del sistema.  
Comienza en *Programado (scheduled)*, pasa a *Jugado (played)* tras registrar el resultado, o puede cambiar a *Cancelado (cancelled)* si no se disputa.  
Refleja las transiciones válidas y asegura la coherencia en la gestión de los partidos.

[Diagrama de Estados](state_match.png)

---

## **4. Relaciones de la Base de Datos**

| **Entidad / Relación** | **Tipo de relación** |
|--------------------------|----------------------|
| Equipo (1) — (N) Jugador | Un equipo tiene varios jugadores. |
| Árbitro (1) — (N) Partido | Un árbitro puede dirigir varios partidos. |
| Equipo (1) — (N) Partido (rol local) | Un equipo puede ser local en varios partidos. |
| Equipo (1) — (N) Partido (rol visitante) | Un equipo puede ser visitante en varios partidos. |

---

## **5. Restricciones CHECK**

| **Tabla** | **Restricción** |
|------------|-----------------|
| `matches` | `home_team_id <> away_team_id` |
| `matches` | `status ∈ {scheduled, played, cancelled}` |
| `matches` | `home_goals, away_goals >= 0` |
| `referees` | `active ∈ {true, false}` |

---

## **6. Llaves Primarias (PK)**

| **Tabla** | **Llave primaria** | **Descripción** |
|------------|--------------------|-----------------|
| `teams` | `id` | Identificador único del equipo. |
| `players` | `id` | Identificador único del jugador. |
| `referees` | `id` | Identificador único del árbitro. |
| `matches` | `id` | Identificador principal del partido. |

---

## **7. Llaves Foráneas (FK)**

| **Tabla** | **Columna FK** | **Referencia** | **Relación** |
|------------|----------------|----------------|---------------|
| `players` | `team_id` | `teams(id)` | Cada jugador pertenece a un equipo. |
| `matches` | `home_team_id` | `teams(id)` | Define el equipo local. |
| `matches` | `away_team_id` | `teams(id)` | Define el equipo visitante. |
| `matches` | `referee_id` | `referees(id)` | El árbitro que dirige el partido. |

---

## **8. Llaves Únicas (UNIQUE)**

| **Tabla** | **Columna** | **Descripción** |
|------------|--------------|-----------------|
| `teams` | `name` | Cada equipo debe tener un nombre único. |
| `referees` | `license_code` | Ningún árbitro puede repetir número de licencia. |
| `referees` | `email` | El correo de árbitro debe ser único. |

---

## **9. Conclusión**

El diseño de la base de datos del proyecto **SIGET** garantiza la integridad, trazabilidad y coherencia de la información del torneo.  
Las relaciones entre entidades reflejan de forma clara los procesos reales: registro, programación y resultados.  
Este modelo, junto con los diagramas UML, constituye la base técnica para el desarrollo futuro de la plataforma web de gestión deportiva.

---
