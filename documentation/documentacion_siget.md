# Proyecto de Sistema de Gestión de Torneos Deportivos
**Modelos y Documentación del Software**  
**Docente:** Ing. Hely Suárez Marín  

**Integrantes:**  
- Nelly Fabiola Cano Oviedo  
- Néstor Iván Granados Valenzuela  

**Fecha:** Octubre / 2025  

---

## 🧠 Problema
Los torneos deportivos académicos y aficionados suelen gestionar su información con hojas de cálculo, formularios dispersos o mensajería instantánea. A medida que crece el número de equipos, jugadores y partidos, también aumenta la complejidad operativa: programar encuentros sin choques de horario, asignar árbitros disponibles, registrar resultados de forma confiable y consultar estadísticas básicas.  

Este manejo manual y descentralizado provoca errores de transcripción (marcadores mal digitados, equipos repetidos), inconsistencia de datos (jugadores duplicados, árbitros inhabilitados asignados por error) y poca trazabilidad (no queda claro quién cambió un resultado ni cuándo).  
La ausencia de un modelo único limita la generación de estadísticas confiables (partidos jugados, victorias, empates, derrotas) y dificulta la rendición de cuentas.  
En consecuencia, se afectan la transparencia del torneo y la experiencia de participantes y organizadores.

---

## 💡 Solución
Se propone una **plataforma web simple y centralizada** de Gestión de Torneos Deportivos que estandarice:

1. Registro de equipos y jugadores.  
2. Programación de partidos (fecha/hora/sede).  
3. Asignación de árbitros disponibles.  
4. Registro de resultados.  
5. Generación de estadísticas básicas por equipo.

El acceso se realiza con roles mínimos (**Administrador, Árbitro, Espectador**) para delimitar responsabilidades y reducir errores.  
El sistema define **reglas de negocio** que evitan inconsistencias (por ejemplo, no se puede programar un partido con el mismo equipo como local y visitante, o cerrar un partido *played* con goles negativos).  
Toda la información queda persistida en una **base de datos relacional** con **integridad referencial**.

---

## 🚀 Impacto
1. **Eficiencia y trazabilidad:** Disminuye tiempos de registro y elimina duplicidades. Cada cambio queda asociado a un usuario/fecha, reforzando el control.  
2. **Transparencia del torneo:** Estadísticas generadas a partir de resultados verificables en la BD; se reducen conflictos por errores humanos.  
3. **Escalabilidad académica:** La documentación (UML + BD normalizada) deja una base sólida para futuras extensiones (múltiples torneos, fases, sanciones, tablas de posiciones).

---

## 1️⃣ Resumen del Problema
El manejo manual y distribuido de información en torneos deportivos provoca **inconsistencias**, **pérdida de trazabilidad** y **dificulta estadísticas confiables**.  
Esto impacta la calidad organizativa y la experiencia de equipos y árbitros.

---

## 2️⃣ Posible solución (plataforma mínima de torneo)
Se propone un **MVP** que cubra el ciclo esencial:  
**inscripción de equipos/jugadores → programación y arbitraje → registro de resultados → estadísticas**.  
La solución se documenta completamente (UML + BD) para una implementación posterior.

### Alcance (MVP)
- Registrar **Equipos** (nombre, ciudad, entrenador) y **Jugadores** (básicos y pertenencia a un equipo).  
- Registrar **Árbitros** (licencia, contacto, estado activo).  
- **Programar** partidos con fecha y hora, asegurando que **local ≠ visitante**.  
- **Asignar** árbitro disponible.  
- **Registrar** resultados (goles local/visitante) y marcar estado del partido como **played**.  
- **Generar** estadísticas básicas: jugados, ganados, empatados y perdidos por equipo.

### Actores y Funciones
| **Actor** | **Funciones principales** |
|------------|---------------------------|
| **Administrador** | Gestiona equipos, jugadores y árbitros; programa partidos; registra resultados; consulta estadísticas. |
| **Árbitro** | (Opcional) Confirma validez del resultado o reporta incidentes. |
| **Espectador** | Consulta estadísticas y resultados publicados. |

### Reglas clave del sistema
- Un partido **no puede** tener el mismo equipo como local y visitante.  
- Un partido **played** debe registrar **goles ≥ 0**.  
- Un **árbitro inactivo** no puede asignarse.  
- Las **estadísticas** se **derivan** de los partidos; **no** se almacenan acumulados (evita inconsistencias).

---

## 3️⃣ Descripción general del proceso
El organizador registra equipos/jugadores y árbitros.  
Luego programa cada partido, asigna un árbitro y, al finalizar el encuentro, registra el resultado.  
Las estadísticas se consultan en cualquier momento con base en los resultados ya cerrados (*played*).

### 🗺️ Mapa de Procesos
![Mapa de Procesos](../uml/export/png/MapadeProcesos.png)  
**Propósito.** Visualizar el flujo global de registro, programación y resultados.  
**Qué representa.** Etapas: planeación (registro), operación (programación/resultado), control (estadísticas).  
**Cómo leerlo.** Las columnas muestran responsabilidades y el orden lógico de las actividades.  
**Razón de diseño.** Permitir seguimiento claro entre procesos y roles.  
**Relación con BD / reglas.** Cada bloque mapea operaciones de las tablas principales (`teams`, `matches`, `referees`).

---

## 4️⃣ Revisión / Verificabilidad
Se contrastaron flujos básicos con prácticas reales: **planillas de papel** o **mensajes dispersos** suelen generar conflictos por falta de control de versiones y responsabilidades.  
El modelo propuesto corrige esto mediante **integridad referencial**, **reglas de negocio** y **vistas** para estadísticas.

---

## 5️⃣ Diagramas UML realizados

### 5.1 Casos de Uso
![Casos de Uso](../uml/export/png/usecase.png)  
**Propósito.** Mostrar qué funcionalidades ofrece el sistema según el actor.  
**Qué representa.** Actores: Administrador, Árbitro y Espectador con casos clave (*Registrar*, *Programar*, *Asignar*, *Registrar Resultado*, *Consultar Estadísticas*).  
**Cómo leerlo.** Cada actor conecta con los casos que puede ejecutar.  
**Razón de diseño.** Clarificar roles y alcance funcional del MVP.  
**Relación con BD / reglas.** Justifica la creación de entidades `teams`, `players`, `matches`, `referees`.

---

### 5.2 Actividades (Registrar Resultado)
![Actividad – Registrar Resultado](../uml/export/png/activity_registrar_resultado.png)  
**Propósito.** Describir el flujo operativo para registrar un resultado.  
**Qué representa.** Secuencia de validaciones: existencia del partido, estado “scheduled”, goles ≥ 0, actualización a “played”.  
**Cómo leerlo.** Cajas representan actividades; rombos, decisiones; flechas, flujo.  
**Razón de diseño.** Resalta validaciones críticas para integridad de datos.  
**Relación con BD / reglas.** Actualiza `matches.status` y los campos `home_goals`, `away_goals`.

---

### 5.3 Secuencia (Programar Partido)
![Diagrama de Secuencia – Programar Partido](../uml/export/png/sequence_programar_partido.png)  
**Propósito.** Mostrar el intercambio de mensajes al crear un partido.  
**Qué representa.** Comunicación entre UI, servicio y repositorio para validar equipos, árbitro y guardar datos.  
**Cómo leerlo.** Flujo vertical temporal con llamadas secuenciales.  
**Razón de diseño.** Explicar paso a paso las validaciones previas a persistir un partido.  
**Relación con BD / reglas.** Inserta en `matches` con validación `home_team_id <> away_team_id`.

---

### 5.4 Comunicación (Registrar Resultado)
![Diagrama de Comunicación](../uml/export/png/communication_registrar_resultado.png)  
**Propósito.** Mostrar la colaboración entre objetos durante el registro del resultado.  
**Qué representa.** Admin → Servicio → Repositorio, con numeración de mensajes.  
**Cómo leerlo.** Sigue los números para identificar flujo de ejecución.  
**Razón de diseño.** Refuerza la trazabilidad y la comunicación entre capas.  
**Relación con BD / reglas.** Modifica `matches` y actualiza vistas estadísticas.

---

### 5.5 Paquetes
![Diagrama de Paquetes](../uml/export/png/package.png)  
**Propósito.** Organizar el sistema por capas lógicas.  
**Qué representa.** UI (presentación), Application (lógica), Domain (entidades), Infrastructure (persistencia).  
**Cómo leerlo.** Dependencias jerárquicas entre capas.  
**Razón de diseño.** Facilitar mantenimiento y pruebas.  
**Relación con BD / reglas.** Domain encapsula entidades mapeadas a las tablas del modelo relacional.

---

### 5.6 Clases
![Diagrama de Clases](../uml/export/png/class.png)  
**Propósito.** Mostrar la estructura estática del sistema.  
**Qué representa.** Entidades: Team, Player, Referee, Match, con atributos y cardinalidades.  
**Cómo leerlo.** Cada clase muestra atributos y asociaciones con multiplicidades.  
**Razón de diseño.** Reflejar la estructura de la BD en orientación a objetos.  
**Relación con BD / reglas.** Traducción directa a `teams`, `players`, `referees`, `matches`.

---

### 5.7 Objetos
![Diagrama de Objetos](../uml/export/png/object.png)  
**Propósito.** Validar el modelo con instancias concretas.  
**Qué representa.** Ejemplo de partido programado entre dos equipos con árbitro asignado.  
**Cómo leerlo.** Objetos con valores reales y referencias activas.  
**Razón de diseño.** Comprobar coherencia y relaciones 1:N.  
**Relación con BD / reglas.** Corresponde a registros en `matches` y FKs relacionadas.

---

### 5.8 Estados (Partido)
![Diagrama de Estados](../uml/export/png/state_match.png)  
**Propósito.** Modelar el **ciclo de vida** del partido.  
**Qué representa.** Estados `scheduled`, `played` y `cancelled` con transiciones válidas.  
**Cómo leerlo.** Flechas con eventos (registrar resultado → *played*; cancelar → *cancelled*).  
**Razón de diseño.** Evitar estados ambiguos y reforzar **consistencia** operacional.  
**Relación con BD / reglas.** Persistido en `matches.status` (ENUM/CHK).

---

### 5.9 Secuencia (Registrar Resultado)
![Diagrama de Secuencia – Registrar Resultado](../uml/export/png/sequence_registrar_resultado.png)  
**Propósito.** Explicar el proceso de registro del marcador.  
**Qué representa.** Flujo entre interfaz, servicio y repositorio para validar estado y guardar datos.  
**Cómo leerlo.** Mensajes verticales cronológicos.  
**Razón de diseño.** Garantizar que el resultado se registre solo una vez y con datos válidos.  
**Relación con BD / reglas.** Cambios en `matches`, actualización de vistas estadísticas.

---

### 5.10 Componentes
![Diagrama de Componentes](../uml/export/png/component.png)  
**Propósito.** Representar los módulos físicos del sistema.  
**Qué representa.** API, módulos funcionales (Equipos, Partidos, Árbitros) y conexión con la BD.  
**Cómo leerlo.** Cajas son componentes, líneas son dependencias.  
**Razón de diseño.** Mostrar separación entre backend y persistencia.  
**Relación con BD / reglas.** Cada módulo usa DAOs que acceden a las tablas específicas.

---

### 5.11 Tiempo (Timing)
![Diagrama de Tiempo](../uml/export/png/timing_match.png)  
**Propósito.** Mostrar la evolución temporal del ciclo del partido.  
**Qué representa.** Cambios de estado y eventos (programación, juego, registro de resultado).  
**Cómo leerlo.** Ejes horizontales por participante con marcas de tiempo.  
**Razón de diseño.** Identificar demoras entre fases y sincronización.  
**Relación con BD / reglas.** Corresponde a cambios de `matches.status` y fecha/hora.

---

### 5.12 Instalación / Despliegue
![Diagrama de Instalación](../uml/export/png/installation.png)  
![Diagrama de Despliegue](../uml/export/png/deployment.png)  
**Propósito.** Mostrar los nodos físicos y lógicos de la instalación del sistema.  
**Qué representa.** Cliente (navegador), servidor de aplicación (API) y servidor de BD (PostgreSQL/MySQL).  
**Cómo leerlo.** Nodos conectados por protocolos HTTP/HTTPS y TCP.  
**Razón de diseño.** Ilustrar arquitectura cliente-servidor simple.  
**Relación con BD / reglas.** Requiere configuración de conexión en `.env` y puertos (5432/3306).

---

## 🏁 Conclusión
El diseño de la base de datos del proyecto **SIGET** garantiza la **integridad, trazabilidad y coherencia** de la información del torneo.  
Las relaciones entre entidades reflejan fielmente los procesos de **registro, programación y resultados**.  
Cada diagrama UML respalda una perspectiva distinta del sistema, consolidando una documentación académica completa y funcional.
