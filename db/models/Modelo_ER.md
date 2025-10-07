# Modelo Entidad–Relación (ER)

**Entidades principales**
- **Equipo (teams)**
- **Jugador (players)**
- **Árbitro (referees)**
- **Partido (matches)**

**Relaciones**
- **Equipo 1 — N Jugador:** Un equipo tiene muchos jugadores; cada jugador pertenece a un equipo.
- **Partido N — 1 Árbitro:** Un árbitro puede dirigir muchos partidos; cada partido lo dirige un árbitro.
- **Partido — Equipos:** Cada partido tiene **equipo local** y **equipo visitante** (dos FK a `teams`) y **deben ser distintos**.

> El diagrama ER está en `UML/er.puml` (PlantUML).

**Cardinalidades y reglas de negocio**
- `home_team_id <> away_team_id` (equipos distintos).
- `status ∈ {scheduled, played, cancelled}`.
- `home_goals, away_goals ≥ 0` cuando el partido se marca como *played* (validación de aplicación).
