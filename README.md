# 🏆 **SIGET – Sistema de Información y Gestión de Torneos**

**Proyecto Académico Integrado – Bases de Datos / Modelos y Documentación del Software**
**Institución:** Fundación de Estudios Superiores Comfanorte – FESC
**Docente:** Ing. Hely Suárez Marín

**Integrantes:**

* **Nelly Fabiola Cano Oviedo**
* **Néstor Iván Granados Valenzuela**

**Fecha:** Noviembre / 2025

---

# 📘 **Descripción del Proyecto**

**SIGET** es un sistema académico diseñado para centralizar y optimizar la gestión de torneos deportivos en contextos educativos.
Este repositorio reúne:

* El **modelado UML completo**
* La **base de datos relacional (PostgreSQL)**
* La **documentación técnica integral**
* La **estructura organizada del proyecto**

SIGET propone una solución modular y escalable que permite registrar equipos, jugadores, árbitros, programar partidos y gestionar resultados, garantizando trazabilidad y consistencia.

---

# 🎯 **Objetivo del Proyecto**

Desarrollar la documentación técnica formal (UML + BD + análisis) de un sistema orientado a gestionar torneos deportivos, asegurando coherencia entre sus modelos conceptual, lógico y físico.

---

# 🧩 **Funcionalidades del MVP**

* Registro de **equipos**, **jugadores** y **árbitros**
* Programación de **partidos** (fecha/hora/sede)
* **Asignación de árbitros** activos
* **Registro de resultados** con validaciones
* Generación de **estadísticas básicas** por equipo
* Roles: **Administrador**, **Árbitro**, **Espectador**

---

# 🏗️ **Arquitectura General del Repositorio**

```plaintext
SIGET/
│
├── database/
│   ├── documentation/         → Documentación de BD (Markdown)
│   ├── db/dumps/              → Esquema SQL + datos de prueba
│   └── images/                → ERD y relacional exportado
│
├── modeling-and-docs/
│   ├── documentation/         → Documentación UML consolidada
│   ├── uml/                   → Archivos PlantUML (.puml)
│   │     ├── src/             → Diagramas fuente
│   │     └── export/          → Diagramas PNG/SVG
│   └── releases/docs/         → PDFs y DOCX finales
│
└── documentation/
    ├── siget_documentacion_general.md  → Documento principal
    └── README.md                       → (este archivo)
```

---

# 📊 **Diagramas UML Incluidos**

Los diagramas generados en PlantUML incluyen:

* Casos de Uso
* Actividades
* Secuencias (Programar y Registrar Resultado)
* Comunicación
* Clases
* Objetos
* Estados
* Componentes
* Paquetes
* Timing
* Deployment
* Installation

Todos se encuentran en:

```
modeling-and-docs/uml/export/
```

---

# 🗄️ **Modelo de Base de Datos**

Implementado en **PostgreSQL 14+**, con:

* PK, FK, UNIQUE, CHECK
* Normalización hasta **3FN**
* Vistas para estadísticas:

  * `vw_team_matches`
  * `vw_team_stats`

Archivos SQL:

```
database/db/dumps/siget_schema.sql
database/db/dumps/siget_schema_data.sql
```

Documentación completa:

```
database/documentation/siget_base_de_datos.md
```

---

# 🧱 **Tecnologías Utilizadas**

| Categoría            | Herramienta  |
| -------------------- | ------------ |
| Modelado UML         | PlantUML     |
| Base de Datos        | PostgreSQL   |
| Documentación        | Markdown     |
| Control de Versiones | Git + GitHub |
| Editor               | VSCode       |

---

# 🌐 **Cómo Navegar el Proyecto**

1. 🔸 **Si buscas la BD:**
   → `database/documentation/siget_base_de_datos.md`

2. 🔸 **Si buscas los diagramas UML:**
   → `modeling-and-docs/documentation/documentacion_siget.md`

3. 🔸 **Si buscas el documento general del proyecto:**
   → `documentation/siget_documentacion_general.md`

4. 🔸 **Si quieres los .puml para editar:**
   → `modeling-and-docs/uml/src/`

5. 🔸 **Si quieres los diagramas exportados:**
   → `modeling-and-docs/uml/export/`

---

# 📈 **Estado del Proyecto**

✔ Documentación UML completa
✔ Modelo relacional normalizado
✔ Scripts SQL funcionales
✔ Documentación general consolidada

---

# 📎 **Documentos Clave**

* 📘 **Documentación UML**
  `modeling-and-docs/documentation/documentacion_siget.md`

* 📄 **Documentación Base de Datos**
  `database/documentation/siget_base_de_datos.md`

* 📗 **Documento General del Proyecto**
  `documentation/siget_documentacion_general.md`

---

# 💡 **Sobre el Proyecto**

SIGET es un ejercicio académico integral que combina análisis, diseño y modelado técnico.
Este repositorio sirve como base para implementar más adelante una aplicación web completa con autenticación, vistas avanzadas, reportes y manejo de múltiples torneos.

---

# © **2025 – FESC · Facultad de Ingeniería de Software**

**Proyecto Académico SIGET**

