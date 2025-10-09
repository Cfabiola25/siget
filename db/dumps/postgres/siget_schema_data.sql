-- SIGET – Esquema + Datos demo (PostgreSQL)
\i 'dumps/postgres/siget_schema.sql'  -- importa el DDL anterior si desea

BEGIN;

-- ====== Datos demo (IDs fijos para reproducibilidad) ======
-- Equipos
INSERT INTO teams (id, name, coach_name, city) VALUES
  (1,'Tiburones FC','Carlos Mena','Cúcuta'),
  (2,'Leones SC','María Rojas','Ocaña');

-- Árbitros
INSERT INTO referees (id, first_name, last_name, license_code, category, phone, email, active) VALUES
  (1,'Ana','Pérez','REF-001','Regional','3001112233','ana.perez@siget.test', TRUE),
  (2,'Luis','Gómez','REF-002','Regional','3004445566','luis.gomez@siget.test', TRUE);

-- Jugadores (subset)
INSERT INTO players (id, team_id, first_name, last_name, position, jersey_number, birthdate, email) VALUES
  (1,1,'Javier','Suárez','FW',9,'2002-05-11','j.suarez@siget.test'),
  (2,1,'Mateo','López','GK',1,'2001-02-03','m.lopez@siget.test'),
  (3,2,'Santiago','Pardo','FW',10,'2000-09-22','s.pardo@siget.test'),
  (4,2,'David','Mora','DF',4,'2001-12-01','d.mora@siget.test');

-- Partidos
-- 1) Programado (scheduled)
INSERT INTO matches (id, home_team_id, away_team_id, referee_id, match_date, match_time, venue, status)
VALUES (1, 1, 2, 1, CURRENT_DATE + INTERVAL '2 day', '16:00', 'Coliseo Central', 'scheduled');

-- 2) Jugado (played)
INSERT INTO matches (id, home_team_id, away_team_id, referee_id, match_date, match_time, venue, status, home_goals, away_goals)
VALUES (2, 2, 1, 2, CURRENT_DATE - INTERVAL '3 day', '18:30', 'Estadio Norte', 'played', 1, 2);

COMMIT;

-- Consultas de verificación rápida:
-- SELECT * FROM vw_team_stats ORDER BY team_name;
