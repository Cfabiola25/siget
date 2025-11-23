-- ================================
-- SCHEMA: SIGET – ESTRUCTURA BASE
-- ================================

-- Crear tipo enumerado para estados del partido
CREATE TYPE match_status AS ENUM ('scheduled', 'played', 'cancelled');

-- ================================
-- TABLA: teams
-- ================================
CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    coach_name VARCHAR(120),
    city VARCHAR(80),
    created_at TIMESTAMP DEFAULT NOW()
);

-- ================================
-- TABLA: referees
-- ================================
CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    license_code VARCHAR(50) UNIQUE NOT NULL,
    category VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(120) UNIQUE NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ================================
-- TABLA: players
-- ================================
CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    team_id INT NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    position VARCHAR(40),
    jersey_number INT,
    birthdate DATE,
    email VARCHAR(120),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ================================
-- TABLA: matches
-- ================================
CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    home_team_id INT NOT NULL REFERENCES teams(id),
    away_team_id INT NOT NULL REFERENCES teams(id),
    referee_id INT REFERENCES referees(id),
    match_date DATE NOT NULL,
    match_time TIME NOT NULL,
    venue VARCHAR(150),
    status match_status DEFAULT 'scheduled',
    home_goals INT DEFAULT 0 CHECK (home_goals >= 0),
    away_goals INT DEFAULT 0 CHECK (away_goals >= 0),
    created_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT chk_teams_different CHECK (home_team_id <> away_team_id)
);

-- INDEXES (recomendados)
CREATE INDEX idx_players_team ON players(team_id);
CREATE INDEX idx_matches_status ON matches(status);
CREATE INDEX idx_matches_referee ON matches(referee_id);

-- ================================
-- VISTAS
-- ================================

-- Vista: matches por equipo indicando rol
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

-- Vista: estadísticas por equipo
CREATE VIEW vw_team_stats AS
SELECT 
    t.id AS team_id,
    t.name AS team_name,
    COUNT(m.id) FILTER (WHERE m.status = 'played') AS played,
    COUNT(*) FILTER (
        WHERE m.status = 'played' AND 
        ((m.home_team_id = t.id AND m.home_goals > m.away_goals) OR 
         (m.away_team_id = t.id AND m.away_goals > m.home_goals))
    ) AS wins,
    COUNT(*) FILTER (
        WHERE m.status = 'played' AND m.home_goals = m.away_goals
    ) AS draws,
    COUNT(*) FILTER (
        WHERE m.status = 'played' AND 
        ((m.home_team_id = t.id AND m.home_goals < m.away_goals) OR 
         (m.away_team_id = t.id AND m.away_goals < m.home_goals))
    ) AS losses
FROM teams t
LEFT JOIN matches m 
    ON m.home_team_id = t.id OR m.away_team_id = t.id
GROUP BY t.id, t.name;
