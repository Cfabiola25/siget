# 🏆 **SIGET – Sistema de Información y Gestión de Torneos**

**Proyecto Académico Integrado – Bases de Datos / Modelos y Documentación del Software**

**Institución:** Fundación de Estudios Superiores Comfanorte – FESC
**Docente:** Ing. Hely Suárez Marín

**Integrantes:**

* Nelly Fabiola Cano Oviedo
* Néstor Iván Granados Valenzuela

**Fecha:** Noviembre / 2025

---

# 📘 1. Introducción

El proyecto **SIGET** (Sistema de Información y Gestión de Torneos) tiene como finalidad diseñar, estructurar y documentar una solución informática que permita optimizar la gestión de torneos deportivos en ambientes académicos.

Hoy en día, la mayoría de instituciones registran información deportiva mediante hojas de cálculo, documentos dispersos o mensajería instantánea. Este enfoque genera:

* Duplicidad de datos
* Errores en resultados
* Falta de trazabilidad
* Dificultad para generar estadísticas confiables

SIGET propone una **plataforma centralizada**, respaldada por un modelo de datos sólido y una documentación UML coherente, que permita administrar equipos, jugadores, árbitros, partidos y resultados de forma clara, trazable y verificable.

---

# 🎯 2. Objetivos

## 2.1 Objetivo General

Diseñar y documentar un sistema relacional y modular para la **gestión digital de torneos deportivos**, garantizando integridad, coherencia y trazabilidad mediante diagramas UML, modelo relacional y documentación técnica.

## 2.2 Objetivos Específicos

1. Modelar actores, procesos y entidades mediante **diagramas UML** (casos de uso, clases, estados, actividades, secuencias, componentes y despliegue).
2. Construir una **base de datos relacional** en PostgreSQL con restricciones, llaves, índices y vistas estadísticas.
3. Documentar todo el proyecto en formato **Markdown**, de forma clara y navegable.
4. Mantener coherencia entre el modelo conceptual, lógico y físico, asegurando trazabilidad documental.

---

# 🧩 3. Alcance del Proyecto

El alcance del MVP desarrollado cubre:

1. Registro de **equipos, jugadores y árbitros**.
2. Programación de **partidos** con fecha, hora, sede y árbitro asignado.
3. Registro de **resultados** y actualización de estadísticas básicas.
4. Consulta de **reportes**, estados y métricas deportivas.
5. Modelado completo (UML + BD) para permitir una futura implementación de la aplicación web.

🔹 *La fase de desarrollo (frontend/backend) queda fuera del alcance actual, enfocándose exclusivamente en análisis, diseño y documentación técnica.*

---

# ⚙️ 4. Arquitectura General del Proyecto

El repositorio SIGET se organiza en tres bloques documentales:

| Módulo                    | Descripción                                       | Documento                                                |
| ------------------------- | ------------------------------------------------- | -------------------------------------------------------- |
| **Base de Datos**         | Estructura relacional, normalización y vistas SQL | `database/documentation/siget_base_de_datos.md` [📄 Ver documentación de BD](../database/documentation/siget_base_de_datos.md)          |
| **Modelado UML**          | Diagramas del sistema y su justificación          | `modeling-and-docs/documentation/documentacion_siget.md` [📘 Ver documentación UML](../modeling-and-docs/documentation/documentacion_siget.md) |
| **Documentación General** | Objetivos, alcance y vínculos entre módulos       | *este documento*                                         |

---

# 🧱 5. Estructura del Repositorio

```plaintext
SIGET/
│
├── database/
│   ├── documentation/           → Documentación de la base de datos
│   ├── db/dumps/                → SQL del esquema y datos
│   └── images/                  → ER y relacional
│
├── modeling-and-docs/
│   ├── documentation/           → Documentación UML
│   ├── uml/                     → .puml + imágenes exportadas
│   └── releases/docs/           → Archivos finales PDF/DOCX
│
└── documentation/
    └── siget_documentacion_general.md
```

---

# 🔗 6. Relación entre Componentes del Sistema

| Elemento             | Rol dentro del proyecto                                           |
| -------------------- | ----------------------------------------------------------------- |
| **Entidad**          | Representa una tabla o clase del dominio (`Team`, `Player`, etc.) |
| **Regla de negocio** | Define restricciones o validaciones del sistema                   |
| **Vista SQL**        | Genera datos derivados (ej. estadísticas)                         |
| **Diagrama UML**     | Explica procesos, estructura o interacción del sistema            |

Esta relación garantiza coherencia entre **UML → BD → Documentación**.

---

# 📚 7. Metodología de Desarrollo

El proyecto adoptó un enfoque **incremental, documentado y basado en buenas prácticas**, compuesto por:

1. **Levantamiento del dominio** mediante análisis del proceso real.
2. **Modelado UML**, para representar de forma visual actores, entidades, procesos y flujos.
3. **Diseño relacional**, con normalización hasta 3FN.
4. **Documentación en Markdown**, permitiendo control de versiones y trazabilidad.

---

# 🧩 8. Herramientas Utilizadas

| Categoría      | Herramienta    | Función                          |
| -------------- | -------------- | -------------------------------- |
| Modelado UML   | PlantUML       | Generación de diagramas formales |
| Base de Datos  | PostgreSQL 14+ | Implementación del esquema       |
| Documentación  | Markdown (.md) | Estandarización y reutilización  |
| Versionamiento | Git + GitHub   | Control del proyecto             |

---

# 📈 9. Resultados Obtenidos

* Modelo relacional **coherente**, con PK, FK, CHECK y UNIQUE.
* Diagramas UML **alineados a la base de datos** y a las reglas de negocio.
* Documentación completa, clara y estructurada.
* Vistas SQL para estadísticas verificables.
* Repositorio organizado para facilitar evaluación y mantenimiento.

---

# 📝 10. Conclusiones

El proyecto **SIGET** demuestra la importancia de integrar el análisis, modelado y diseño de datos en un marco académico sólido.
La documentación generada constituye la **base formal del sistema** y asegura que, en fases futuras, el desarrollo web pueda implementarse siguiendo una arquitectura clara, trazable y bien fundamentada.

SIGET se convierte así en un ejemplo completo de cómo un proyecto académico puede consolidarse mediante buenas prácticas de documentación y modelado.

---

# 📎 11. Documentos Relacionados

* **Base de Datos:**
[📄 Ver documentación de BD](../database/documentation/siget_base_de_datos.md)

* **Modelado UML:**
[📘 Ver documentación UML](../modeling-and-docs/documentation/documentacion_siget.md) 
---

© 2025 – **FESC · Facultad de Ingeniería de Software**
Proyecto Académico SIGET
