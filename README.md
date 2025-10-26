# 🏆 Proyecto SIGET – Sistema de Información y Gestión de Torneos

---

## 📘 Resumen del Proyecto

El proyecto **SIGET** tiene como propósito desarrollar una **plataforma web centralizada** para la **gestión integral de torneos deportivos** en contextos académicos y amateurs.

Su objetivo principal es reemplazar los **procesos manuales y dispersos** (como el registro de resultados en hojas de cálculo o grupos de mensajería) por un sistema **digital, trazable y organizado**, que permita registrar equipos, árbitros, partidos y resultados de forma estructurada.

### 🎯 Propósito del sistema
La plataforma se plantea inicialmente como un **Producto Mínimo Viable (MVP)** enfocado en garantizar:

- 🔗 **Trazabilidad completa** de los datos del torneo.  
- ⚙️ **Integridad en los registros** de equipos y resultados.  
- 📊 **Automatización** de estadísticas y reportes de rendimiento.  
- 🌐 **Accesibilidad** para los distintos actores (administrador, organizador, árbitro y jugador).

---

## ⚙️ Funcionalidades Principales

- 🧾 Registro de equipos, jugadores y árbitros.  
- 📅 Programación de partidos con control de horarios y árbitros.  
- 📈 Actualización automática de estadísticas y posiciones.  
- 🔁 Control de estados de partidos (*scheduled*, *played*, *cancelled*).  
- 📊 Consultas y reportes dinámicos de desempeño por equipo.

---

## 🧩 Documentación de la Base de Datos

- 📄 [Ver Documentación en Markdown](./database/documentation/siget_base_de_datos.md)  
- 🗺️ [Ver Diagrama ER](./modeling-and-docs/uml/export/er_siget.png)

---

## 🧠 Contexto Académico

**Asignaturas:**
- 🧩 Bases de Datos  
- 🧠 Modelos y Documentación del Software  

**Docente:** Ing. Hely Suárez Marín  
**Institución:** Fundación de Estudios Superiores Comfanorte – FESC  

**Integrantes:**  
- 👩‍💻 Nelly Fabiola Cano Oviedo  
- 👨‍💻 Néstor Iván Granados Valenzuela  

**📅 Fecha:** Octubre / 2025  

---

## 🛠️ Tecnologías Utilizadas

| Categoría | Herramienta / Tecnología |
|------------|---------------------------|
| **Base de Datos** | PostgreSQL / MySQL |
| **Modelado UML / ER** | PlantUML |
| **Documentación Técnica** | Markdown (.md) |
| **Entorno de Trabajo** | VSCode |
| **Control de Versiones** | Git + GitHub |

---

## 🤝 Contribuir a SIGET

### 🧭 Convenciones
- Archivos fuente de diagramas: `modeling-and-docs/uml/src/*.puml`  
- No editar imágenes manualmente; generar con herramientas automáticas (`export_uml.sh` o `.ps1`).  
- Documentos en `docs/` con nombres numerados (`01_`, `02_`, `03_`).  

### 🚀 Flujo de Trabajo
1. Crear rama: `feat/<tema>` o `fix/<tema>`.  
2. Realizar cambios en `.puml` o `.md`.  
3. Exportar imágenes si aplica.  
4. Commit con convención:


---

✍️ **Fundación de Estudios Superiores Comfanorte – Facultad de Ingeniería de Software – 2025**
