# Modelo Relacional

**teams**(id PK, name, coach_name, city, created_at)

**players**(id PK, team_id FK→teams.id, first_name, last_name, position, jersey_number, birthdate, email, active, created_at)

**referees**(id PK, first_name, last_name, license_code UNIQUE, category, phone, email UNIQUE, active, created_at)

**matches**(id PK, home_team_id FK→teams.id, away_team_id FK→teams.id, referee_id FK→referees.id, match_date, match_time, venue, status CHECK('scheduled'/'played'/'cancelled'), home_goals, away_goals, created_at)

**Restricciones**
- CHECK: `home_team_id <> away_team_id`.
- Índices: por FK y `(match_date, match_time)`.
