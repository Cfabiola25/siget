# 📘 **SIGET – Sistema de Gestión de Torneos**

**Modelos y Documentación del Software**
**Docente:** Ing. Hely Suárez Marín
**Institución:** Fundación de Estudios Superiores Comfanorte – FESC

**Integrantes:**

* Nelly Fabiola Cano Oviedo
* Néstor Iván Granados Valenzuela

**Fecha:** Noviembre / 2025

---

# 1. Introducción

La gestión de torneos deportivos en contextos académicos presenta retos significativos cuando se realiza mediante métodos manuales como hojas de cálculo, formularios aislados y mensajería informal. Estos mecanismos dificultan el control de programación, la asignación de árbitros, el registro de resultados y la generación de estadísticas confiables.

El proyecto **SIGET** (Sistema de Información y Gestión de Torneos) propone una solución tecnológica centralizada para administrar todos los procesos clave del torneo, garantizando trazabilidad, integridad de los datos y organización eficiente.
Esta documentación reúne el análisis, modelado UML y lineamientos técnicos que fundamentan el desarrollo del sistema.

---

# 2. Problema

El manejo manual y distribuido de información genera:

* **Duplicidades** en jugadores, equipos o árbitros.
* **Errores** al registrar resultados o programar partidos.
* **Falta de trazabilidad**, impidiendo conocer quién registró qué cambios.
* **Estadísticas poco confiables**, al depender de datos dispersos.
* **Dificultad de coordinación**, afectando la transparencia del torneo.

Estas limitaciones impactan negativamente la credibilidad, la eficiencia operativa y la experiencia de los participantes.

---

# 3. Propuesta de Solución

SIGET se plantea como una **plataforma web centralizada**, simple y fácil de operar, que integra todo el ciclo de gestión del torneo:

1. Registro de **equipos** y **jugadores**.
2. Registro y control de **árbitros activos**.
3. **Programación de partidos** con fecha, hora y sede.
4. **Asignación de árbitros** disponibles.
5. **Registro de resultados** con validaciones.
6. **Estadísticas automáticas** derivadas de los partidos jugados.

El sistema aplica reglas de negocio que garantizan consistencia y evita errores comunes, como asignar árbitros inactivos o registrar goles negativos.
Toda la información queda almacenada en una **base de datos relacional** con integridad referencial.

---

# 4. Impacto del Sistema

* **Eficiencia y control:** se reduce la carga manual y se eliminan duplicidades.
* **Trazabilidad:** cada cambio queda asociado a un usuario y un momento específico.
* **Transparencia:** las estadísticas del torneo se basan en datos verificables.
* **Escalabilidad técnica:** la documentación UML y la BD normalizada permiten extender el sistema a nuevas funcionalidades.

---

# 5. Alcance del MVP

El MVP de SIGET incluye:

* Registro de equipos, jugadores y árbitros.
* Programación de partidos (asegurando que local ≠ visitante).
* Asignación de árbitros activos.
* Registro de resultados con validación de goles.
* Generación de estadísticas básicas: jugados, ganados, empatados, perdidos.
* Roles: Administrador, Árbitro (opcional), Espectador.

---

# 6. Descripción General del Proceso

El flujo operativo del torneo en SIGET se desarrolla así:

1. Se registran los equipos, jugadores y árbitros.
2. Se programan los partidos con su respectiva información.
3. Se asignan árbitros activos.
4. Tras el encuentro, el árbitro o administrador registra los goles.
5. El sistema actualiza estadísticas y tabla de posiciones.

**Mapa de procesos:**
[Mapa de Procesos](../../modeling-and-docs/uml/export/mapa_de_procesos.png)

---

# 7. Verificación del Modelo

Durante la investigación se contrastaron los flujos manuales tradicionales (planillas, chats, fotos de pizarrón, etc.) con el modelo sistemático de SIGET.
Los principales problemas detectados—errores de transcripción, falta de control de versiones y pérdida de información—se resuelven mediante:

* Integridad referencial
* Reglas de negocio
* Validaciones
* Vistas estadísticas derivadas
* Trazabilidad en el sistema

---

# 8. Diagramas UML del Sistema

## 5.1 Casos de Uso

* **Propósito:** mostrar las funcionalidades del sistema desde la perspectiva de los usuarios.
* **Representación:**

  * *Administrador:* gestiona entidades, programa partidos, asigna árbitros y registra resultados.
  * *Árbitro:* registra resultados y consulta datos.
  * *Espectador:* consulta estadísticas.
* **Aspectos clave:** *Programar Partido* incluye *Asignar Árbitro*.
* **Reglas:** goles ≥ 0, estado scheduled → played.

[Casos de Uso](../../modeling-and-docs/uml/export/usecase.png)

---

## 5.2 Actividad – Registrar Resultado

* **Propósito:** representar el flujo para cerrar un partido.
* **Flujo:** verificación de estado → validación de goles → actualización a *played*.
* **Reglas:** no se permiten goles negativos.
* **Resultado:** actualización de estadísticas.

[Diagrama de Actividades](../../modeling-and-docs/uml/export/activity_registrar_resultado.png)

---

## 5.3 Secuencia – Programar Partido

* **Propósito:** visualizar la interacción entre UI → Servicio → Repositorios.
* **Flujo:** validación de equipos → persistencia → asignación de árbitro.
* **Regla:** home_team_id ≠ away_team_id.

[Diagrama de Secuencia (Programar Partido)](../../modeling-and-docs/uml/export/sequence_programar_partido.png)

---

## 5.4 Comunicación – Registrar Resultado

* **Propósito:** mostrar la colaboración entre objetos.
* **Flujo:** UI → Service → Repo → BD → Confirmación.

[Diagrama de Comunicación](../../modeling-and-docs/uml/export/communication_registrar_resultado.png)

---

## 5.5 Paquetes

* **Capas:** UI, Application, Domain, Infrastructure.
* **Objetivo:** modularidad y separación de responsabilidades.

[Diagrama de Paquetes](../../modeling-and-docs/uml/export/package.png)

---

## 5.6 Clases

* **Entidades:** Team, Player, Referee, Match, MatchStatus.
* **Relaciones:** Team 1–N Player, Match → Team (local/visitante), Match → Referee.
* **Coherencia:** corresponde directamente al modelo relacional.


[Diagrama de Clases](../../modeling-and-docs/uml/export/class.png)

---

## 5.7 Objetos

* **Propósito:** ejemplificar un partido real con equipos y árbitro.

[Diagrama de Objetos](../../modeling-and-docs/uml/export/object.png)

---

## 5.8 Estados (Partido)

* **Estados:** scheduled → played / cancelled.
* **Reglas:** transiciones controladas por acciones del sistema.

[Diagrama de Estados](../../modeling-and-docs/uml/export/state_match.png)

---

## 5.9 Secuencia – Registrar Resultado

* **Propósito:** representar el proceso completo de registro de resultado.
* **Flujo:** ingreso → validación → actualización → confirmación.

[Diagrama de Secuencia (Registrar Resultado)](../../modeling-and-docs/uml/export/sequence_registrar_resultado.png)

---

## 5.10 Componentes

* **Componentes:** Web Client → API → Módulos internos → BD.
* **Objetivo:** identificar el ecosistema técnico del sistema.

[Diagrama de Componentes](../../modeling-and-docs/uml/export/component.png)

---

## 5.11 Diagrama de Tiempo (Timing)

* **Propósito:** ilustrar el ciclo temporal del partido desde programación hasta cierre.

[Diagrama de Tiempo](../../modeling-and-docs/uml/export/timing_match.png)

---

## 5.12 Instalación / Deployment

* **Estructura:** Cliente Web → Servidor API (Docker) → Servidor BD.
* **Comunicación:** HTTP/HTTPS y conexión SQL.

[Diagrama de Instalación](../../modeling-and-docs/uml/export/installation.png)  

[Diagrama de Despliegue](../../modeling-and-docs/uml/export/deployment.png)

---

# 9. Conclusión

La documentación del proyecto **SIGET** refleja un sistema sólido y coherente para la gestión de torneos deportivos.
El análisis, las reglas del negocio, el modelado UML y la base de datos normalizada proporcionan la estructura necesaria para implementar una solución escalable, transparente y confiable.

El modelo presentado permite extender SIGET en fases posteriores, incorporando funcionalidades como reportes avanzados, múltiples torneos, autenticación completa y control de sanciones, manteniendo siempre la integridad de los datos.

