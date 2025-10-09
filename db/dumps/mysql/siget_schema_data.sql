-- SIGET – Esquema + Datos demo (MySQL 8+)
-- Puede llamar primero a: SOURCE dumps/mysql/siget_schema.sql;

START TRANSACTION;

-- Equipos
INSERT INTO teams (id, name, coach_name, city, created_at) VALUES
  (1,'Tiburones FC','Carlos Mena','Cúcuta', NOW()),
  (2,'Leones SC','María Rojas','Ocaña', NOW());

-- Árbitros
INSERT INTO referees (id, first_name, last_name, license_code, category, phone, email, active, created_at) VALUES
  (1,'Ana','Pérez','REF-001','Regional','3001112233','ana.perez@siget.test', TRUE, NOW()),
  (2,'Luis','Gómez','REF-002','Regional','3004445566','luis.gomez@siget.test', TRUE, NOW());

-- Jugadores (subset)
INSERT INTO players (id, team_id, first_name, last_name, position, jersey_number, birthdate, email, active, created_at) VALUES
  (1,1,'Javier','Suárez','FW',9,'2002-05-11','j.suarez@siget.test', TRUE, NOW()),
  (2,1,'Mateo','López','GK',1,'2001-02-03','m.lopez@siget.test', TRUE, NOW()),
  (3,2,'Santiago','Pardo','FW',10,'2000-09-22','s.pardo@siget.test', TRUE, NOW()),
  (4,2,'David','Mora','DF',4,'2001-12-01','d.mora@siget.test', TRUE, NOW());

-- Partidos
INSERT INTO matches (id, home_team_id, away_team_id, referee_id, match_date, match_time, venue, status)
VALUES (1, 1, 2, 1, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '16:00:00', 'Coliseo Central', 'scheduled');

INSERT INTO matches (id, home_team_id, away_team_id, referee_id, match_date, match_time, venue, status, home_goals, away_goals)
VALUES (2, 2, 1, 2, DATE_SUB(CURDATE(), INTERVAL 3 DAY), '18:30:00', 'Estadio Norte', 'played', 1, 2);

COMMIT;

-- Verificación rápida:
-- SELECT * FROM vw_team_stats ORDER BY team_name;
