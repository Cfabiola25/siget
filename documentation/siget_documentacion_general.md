# 🏆 SIGET – Sistema de Información y Gestión de Torneos

**Proyecto Académico Integrado – Bases de Datos / Modelos y Documentación del Software**  
**Institución:** Fundación de Estudios Superiores Comfanorte – FESC  
**Docente:** Ing. Hely Suárez Marín  
**Integrantes:**  
- Nelly Fabiola Cano Oviedo  
- Néstor Iván Granados Valenzuela  
**Fecha:** Octubre / 2025  

---

## 📘 Introducción

El proyecto **SIGET (Sistema de Información y Gestión de Torneos)** tiene como propósito diseñar y documentar una solución informática que optimice la organización de torneos deportivos internos en entornos académicos.

Actualmente, muchas instituciones gestionan los torneos mediante hojas de cálculo o mensajes dispersos, lo que genera **duplicidad de datos, errores de registro y pérdida de trazabilidad**.  
SIGET busca **centralizar la información** y garantizar una administración ordenada, confiable y verificable de equipos, jugadores, árbitros y resultados.

---

## 🎯 Objetivos

### Objetivo general
Diseñar y documentar un sistema relacional y modular para la **gestión digital de torneos deportivos**, integrando el modelado de datos, reglas de negocio y diagramas UML bajo buenas prácticas de documentación técnica.

### Objetivos específicos
1. Modelar las entidades y relaciones mediante **diagramas UML** (casos de uso, clases, estados y secuencias).  
2. Implementar la **base de datos relacional en PostgreSQL**, aplicando restricciones, llaves y vistas estadísticas.  
3. Documentar los procesos y artefactos del sistema en formato **Markdown**, para facilitar su mantenimiento y evaluación.  
4. Garantizar la **coherencia y trazabilidad** entre el modelo conceptual, lógico y físico.  

---

## 🧩 Alcance del Proyecto

El sistema SIGET cubre el flujo básico de un torneo académico:

1. Registro de **equipos, jugadores y árbitros**.  
2. Programación de **partidos** (fecha, hora, sede y árbitro asignado).  
3. Registro de **resultados** y actualización de estadísticas automáticas.  
4. Consulta de **reportes y métricas** (partidos jugados, victorias, empates, derrotas).  

🔸 Se aborda hasta el nivel de **modelado y base de datos**, con vistas y documentación técnica completa.  
🔸 La capa de aplicación (frontend/backend) se deja como fase posterior del desarrollo.

---

## ⚙️ Arquitectura General

El proyecto se organiza en tres componentes principales:

| Módulo | Descripción | Documentación |
|---------|--------------|---------------|
| **Base de Datos** | Estructura relacional, restricciones, normalización y vistas. | [📄 Ver documentación de BD](../database/documentation/siget_base_de_datos.md) |
| **Modelado y UML** | Diagramas de clases, casos de uso, secuencia, estados y despliegue. | [📘 Ver documentación UML](../modeling-and-docs/documentation/documentacion_siget.md) |
| **Documentación General** | Contexto, objetivos, alcance y enlaces entre módulos. | *(este documento)* |

---

## 🧱 Estructura del Proyecto

```plaintext
SIGET/
│
├── 📁 database/
│   ├── 📁 documentation/         → Documentación de la base de datos
│   ├── 📁 db/dumps/              → Archivos SQL (PostgreSQL)
│   └── 📁 images/                → Diagramas ER y vistas relacionales
│
├── 📁 modeling-and-docs/
│   ├── 📁 documentation/         → Documentación UML
│   ├── 📁 uml/                   → Archivos fuente (.puml) y exportados (.png)
│   └── 📁 releases/docs/         → Documentos finales (PDF y DOCX)
│
└── 📁 documentation/
    └── siget_documentacion_general.md  → Documento principal (este)
```

---

## 🔗 Relación entre Componentes

| Elemento | Propósito | Ejemplo |
|-----------|------------|----------|
| **Entidad** | Representa una tabla o clase del sistema. | `Team`, `Player`, `Referee`, `Match` |
| **Regla de Negocio** | Define restricciones o validaciones. | “Un partido no puede tener el mismo equipo como local y visitante.” |
| **Vista** | Genera información derivada o consolidada. | `vw_team_stats` |
| **Diagrama UML** | Explica visualmente los procesos del sistema. | Casos de Uso, Clases, Estados, Secuencia |

---

## 📚 Metodología de Desarrollo

El proyecto sigue un enfoque **incremental y documental**, que combina:
1. **Análisis del dominio** (revisión de procesos manuales actuales).  
2. **Modelado UML** (para representar procesos y entidades).  
3. **Diseño lógico-relacional** (normalización y restricciones).  
4. **Documentación técnica en Markdown** (autoexplicativa, enlazada y versionable con Git).  

---

## 🧩 Herramientas Utilizadas

| Categoría | Herramienta | Propósito |
|------------|--------------|------------|
| **Modelado UML** | PlantUML | Creación de diagramas y vistas exportadas. |
| **Gestión de BD** | PostgreSQL 14+ | Implementación de esquema y datos de prueba. |
| **Documentación** | Markdown (.md) | Estandarización y presentación técnica. |
| **Control de Versiones** | Git y GitHub | Seguimiento y sincronización del trabajo. |

---

## 📈 Resultados Esperados

- Modelo de datos **normalizado** y funcional.  
- Documentación **clara y trazable** entre niveles (UML ↔ BD).  
- Diagramas coherentes con las reglas del sistema.  
- Entregable académico listo para evaluación o extensión futura.  

---

## ✅ Conclusiones

El proyecto **SIGET** demuestra la importancia de integrar el **modelado visual (UML)** con el **diseño relacional (SQL)** dentro de un mismo flujo académico.  
La documentación consolidada facilita la comprensión del sistema, su mantenimiento y su futura implementación como aplicación web.  

> 🧠 Este conjunto de documentos constituye la base formal del proyecto SIGET y su arquitectura de información.

---

## 📎 Documentos Relacionados

- [📘 Base de Datos](../database/documentation/siget_base_de_datos.md)  
- [📗 Modelado y UML](../modeling-and-docs/documentation/documentacion_siget.md)

---

© 2025 · **FESC – Facultad de Ingeniería de Software** · Proyecto SIGET
