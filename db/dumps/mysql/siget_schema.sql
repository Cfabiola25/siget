-- SIGET – Esquema base (DDL) – MySQL 8+
-- Requiere: ENGINE=InnoDB, sql_mode con CHECK habilitado (MySQL 8.0.16+)
-- Ejecute en la BD elegida (ej. tournament_db)

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP VIEW IF EXISTS vw_team_stats;
DROP VIEW IF EXISTS vw_team_matches;

DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS referees;
DROP TABLE IF EXISTS teams;

SET FOREIGN_KEY_CHECKS = 1;

-- =========================
-- Tablas maestras
-- =========================

CREATE TABLE teams (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(100) NOT NULL UNIQUE,
  coach_name  VARCHAR(100),
  city        VARCHAR(80),
  created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE referees (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  first_name   VARCHAR(60) NOT NULL,
  last_name    VARCHAR(60) NOT NULL,
  license_code VARCHAR(40) NOT NULL UNIQUE,
  category     VARCHAR(20),
  phone        VARCHAR(30),
  email        VARCHAR(120) NOT NULL UNIQUE,
  active       BOOLEAN NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE players (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  team_id       INT NOT NULL,
  first_name    VARCHAR(60) NOT NULL,
  last_name     VARCHAR(60) NOT NULL,
  position      VARCHAR(30),
  jersey_number INT,
  birthdate     DATE,
  email         VARCHAR(120),
  active        BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_players_team
    FOREIGN KEY (team_id) REFERENCES teams(id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- Tabla transaccional
-- =========================
CREATE TABLE matches (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  home_team_id  INT NOT NULL,
  away_team_id  INT NOT NULL,
  referee_id    INT NOT NULL,
  match_date    DATE NOT NULL,
  match_time    TIME NOT NULL,
  venue         VARCHAR(120),
  status        ENUM('scheduled','played','cancelled') NOT NULL DEFAULT 'scheduled',
  home_goals    INT,
  away_goals    INT,
  created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_matches_home_team
    FOREIGN KEY (home_team_id) REFERENCES teams(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_matches_away_team
    FOREIGN KEY (away_team_id) REFERENCES teams(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_matches_referee
    FOREIGN KEY (referee_id) REFERENCES referees(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT chk_teams_distintos CHECK (home_team_id <> away_team_id),
  CONSTRAINT chk_home_goals_nonneg CHECK (home_goals IS NULL OR home_goals >= 0),
  CONSTRAINT chk_away_goals_nonneg CHECK (away_goals IS NULL OR away_goals >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- Índices
-- =========================
CREATE INDEX idx_matches_date_time ON matches (match_date, match_time);
CREATE INDEX idx_players_team ON players (team_id);
CREATE INDEX idx_matches_referee ON matches (referee_id);

-- =========================
-- Vistas (compatibles con MySQL)
-- =========================
CREATE OR REPLACE VIEW vw_team_matches AS
SELECT
  t.id   AS team_id,
  t.name AS team_name,
  m.id   AS match_id,
  CASE
    WHEN m.home_team_id = t.id THEN 'home'
    WHEN m.away_team_id = t.id THEN 'away'
  END AS role,
  m.status,
  m.home_goals,
  m.away_goals
FROM teams t
JOIN matches m
  ON (m.home_team_id = t.id OR m.away_team_id = t.id);

CREATE OR REPLACE VIEW vw_team_stats AS
SELECT
  tm.team_id,
  tm.team_name,
  SUM(CASE WHEN m.status = 'played' THEN 1 ELSE 0 END) AS played,
  SUM(
    CASE
      WHEN m.status='played'
       AND ((tm.role='home' AND m.home_goals > m.away_goals)
         OR (tm.role='away' AND m.away_goals > m.home_goals))
      THEN 1 ELSE 0
    END) AS wins,
  SUM(CASE WHEN m.status='played' AND m.home_goals = m.away_goals THEN 1 ELSE 0 END) AS draws,
  SUM(
    CASE
      WHEN m.status='played'
       AND ((tm.role='home' AND m.home_goals < m.away_goals)
         OR (tm.role='away' AND m.away_goals < m.home_goals))
      THEN 1 ELSE 0
    END) AS losses
FROM vw_team_matches tm
JOIN matches m ON m.id = tm.match_id
GROUP BY tm.team_id, tm.team_name;
