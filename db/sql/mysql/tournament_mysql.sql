-- MySQL 8+
DROP DATABASE IF EXISTS tournament_db;
CREATE DATABASE tournament_db CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE tournament_db;

CREATE TABLE teams (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  coach_name VARCHAR(100) NULL,
  city VARCHAR(80) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE referees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  license_code VARCHAR(40) NOT NULL UNIQUE,
  category VARCHAR(20) NULL,
  phone VARCHAR(30) NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE players (
  id INT AUTO_INCREMENT PRIMARY KEY,
  team_id INT NOT NULL,
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  position VARCHAR(30) NULL,
  jersey_number INT NULL,
  birthdate DATE NULL,
  email VARCHAR(120) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_players_team FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE matches (
  id INT AUTO_INCREMENT PRIMARY KEY,
  home_team_id INT NOT NULL,
  away_team_id INT NOT NULL,
  referee_id INT NOT NULL,
  match_date DATE NOT NULL,
  match_time TIME NOT NULL,
  venue VARCHAR(120) NULL,
  status ENUM('scheduled','played','cancelled') NOT NULL DEFAULT 'scheduled',
  home_goals INT NULL CHECK (home_goals >= 0),
  away_goals INT NULL CHECK (away_goals >= 0),
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_matches_home FOREIGN KEY (home_team_id) REFERENCES teams(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_matches_away FOREIGN KEY (away_team_id) REFERENCES teams(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_matches_ref FOREIGN KEY (referee_id) REFERENCES referees(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT chk_teams_distintos CHECK (home_team_id <> away_team_id)
);

CREATE INDEX idx_matches_date_time ON matches (match_date, match_time);
CREATE INDEX idx_players_team ON players (team_id);
CREATE INDEX idx_matches_referee ON matches (referee_id);

-- Vistas básicas de estadísticas
CREATE VIEW vw_team_matches AS
SELECT
  t.id AS team_id,
  t.name AS team_name,
  m.id AS match_id,
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
  COUNT(*) FILTER (WHERE status='played') AS played, -- MySQL ignora FILTER, se calcula con SUM
  SUM(CASE WHEN status='played' THEN 1 ELSE 0 END) AS played_mysql,
  SUM(CASE
        WHEN status='played' AND role='home' AND home_goals > away_goals THEN 1
        WHEN status='played' AND role='away' AND away_goals > home_goals THEN 1
        ELSE 0 END) AS wins,
  SUM(CASE WHEN status='played' AND home_goals = away_goals THEN 1 ELSE 0 END) AS draws,
  SUM(CASE
        WHEN status='played' AND role='home' AND home_goals < away_goals THEN 1
        WHEN status='played' AND role='away' AND away_goals < home_goals THEN 1
        ELSE 0 END) AS losses
FROM vw_team_matches
GROUP BY team_id, team_name;