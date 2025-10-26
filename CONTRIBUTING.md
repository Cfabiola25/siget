# Contribuir a SIGET

## Convenciones
- Archivos fuente de diagramas en `uml/src/*.puml`.
- No edites imágenes manualmente; genera con `tools/export_uml.sh` o `.ps1`.
- Documentos en `docs/` con nombres numerados (01_, 02_, 03_).

## Flujo de trabajo
1. Crea rama: `feat/<tema>` o `fix/<tema>`.
2. Cambios en `.puml` o `.md`.
3. Exporta imágenes si aplica.
4. Commit: `feat(uml): actualiza diagrama de clases`
5. Pull Request con descripción.

## Estilo
- Español formal y claro.
- Diagramas: PlantUML estándar.
- SQL: compatible con PostgreSQL 14+ y MySQL 8+.
