-- ==========================================
-- CREACIÓN DE LA BASE DE DATOS SIGET
-- ==========================================

-- Conéctate como usuario postgres en psql
-- o usa pgAdmin y ejecuta esto:

CREATE DATABASE siget_db
  WITH 
  OWNER = postgres
  ENCODING = 'UTF8'
  LC_COLLATE = 'es_CO.UTF-8'
  LC_CTYPE = 'es_CO.UTF-8'
  TABLESPACE = pg_default
  CONNECTION LIMIT = -1;

-- Esto crea una base llamada siget_db.

-- Ahora conéctate a ella:
\c siget_db;

-- SIGET – Esquema base (DDL) – PostgreSQL 14+
-- Contiene: TABLAS, TIPOS, CONSTRAINTS, ÍNDICES y VISTAS
-- No crea la base de datos; ejecute en la BD elegida (ej. siget_db)

BEGIN;

-- Limpieza segura (orden correcto)
DROP VIEW IF EXISTS vw_team_stats CASCADE;
DROP VIEW IF EXISTS vw_team_matches CASCADE;

DROP TABLE IF EXISTS matches CASCADE;
DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS referees CASCADE;
DROP TABLE IF EXISTS teams CASCADE;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_type WHERE typname = 'match_status') THEN
    DROP TYPE match_status;
  END IF;
END$$;

-- =========================
-- Tablas maestras
-- =========================

CREATE TABLE teams (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(100) NOT NULL UNIQUE,
  coach_name  VARCHAR(100),
  city        VARCHAR(80),
  created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE referees (
  id           SERIAL PRIMARY KEY,
  first_name   VARCHAR(60) NOT NULL,
  last_name    VARCHAR(60) NOT NULL,
  license_code VARCHAR(40) NOT NULL UNIQUE,
  category     VARCHAR(20),
  phone        VARCHAR(30),
  email        VARCHAR(120) NOT NULL UNIQUE,
  active       BOOLEAN NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE players (
  id           SERIAL PRIMARY KEY,
  team_id      INT NOT NULL REFERENCES teams(id) ON DELETE CASCADE ON UPDATE CASCADE,
  first_name   VARCHAR(60) NOT NULL,
  last_name    VARCHAR(60) NOT NULL,
  position     VARCHAR(30),
  jersey_number INT,
  birthdate    DATE,
  email        VARCHAR(120),
  active       BOOLEAN NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- Estados del partido
-- =========================
CREATE TYPE match_status AS ENUM ('scheduled','played','cancelled');

-- =========================
-- Tabla transaccional
-- =========================
CREATE TABLE matches (
  id            SERIAL PRIMARY KEY,
  home_team_id  INT NOT NULL REFERENCES teams(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  away_team_id  INT NOT NULL REFERENCES teams(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  referee_id    INT NOT NULL REFERENCES referees(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  match_date    DATE NOT NULL,
  match_time    TIME NOT NULL,
  venue         VARCHAR(120),
  status        match_status NOT NULL DEFAULT 'scheduled',
  home_goals    INT CHECK (home_goals >= 0),
  away_goals    INT CHECK (away_goals >= 0),
  created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT chk_teams_distintos CHECK (home_team_id <> away_team_id)
);

-- =========================
-- Índices de consulta
-- =========================
CREATE INDEX idx_matches_date_time ON matches (match_date, match_time);
CREATE INDEX idx_players_team ON players (team_id);
CREATE INDEX idx_matches_referee ON matches (referee_id);

-- =========================
-- Vistas de apoyo
-- =========================
CREATE VIEW vw_team_matches AS
SELECT
  t.id  AS team_id,
  t.name AS team_name,
  m.id  AS match_id,
  CASE
    WHEN m.home_team_id = t.id THEN 'home'
    WHEN m.away_team_id = t.id THEN 'away'
  END AS role,
  m.status,
  m.home_goals,
  m.away_goals
FROM teams t
JOIN matches m
  ON m.home_team_id = t.id OR m.away_team_id = t.id;

CREATE VIEW vw_team_stats AS
SELECT
  team_id,
  team_name,
  COUNT(*) FILTER (WHERE status='played') AS played,
  SUM(
    CASE
      WHEN status='played' AND role='home' AND home_goals > away_goals THEN 1
      WHEN status='played' AND role='away' AND away_goals > home_goals THEN 1
      ELSE 0
    END) AS wins,
  SUM(CASE WHEN status='played' AND home_goals = away_goals THEN 1 ELSE 0 END) AS draws,
  SUM(
    CASE
      WHEN status='played' AND role='home' AND home_goals < away_goals THEN 1
      WHEN status='played' AND role='away' AND away_goals < home_goals THEN 1
      ELSE 0
    END) AS losses
FROM vw_team_matches
GROUP BY team_id, team_name;

COMMIT;
