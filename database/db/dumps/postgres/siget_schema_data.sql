-- =================================
-- DATOS DE EJEMPLO PARA SIGET
-- =================================

-- Equipos
INSERT INTO teams (name, coach_name, city)
VALUES
('Tiburones FC', 'Carlos Peña', 'Cúcuta'),
('Leones SC', 'Miguel Duarte', 'Villa del Rosario'),
('Halcones Norte', 'Jorge López', 'Los Patios');

-- Árbitros
INSERT INTO referees (first_name, last_name, license_code, category, phone, email)
VALUES
('Ana', 'Gómez', 'COL-ARB-001', 'A', '3001112233', 'ana@gref.com'),
('Luis', 'Moreno', 'COL-ARB-002', 'B', '3004455667', 'luis@gref.com');

-- Jugadores
INSERT INTO players (team_id, first_name, last_name, position, jersey_number, birthdate, email)
VALUES
(1, 'Daniel', 'Suárez', 'Delantero', 9, '2003-06-20', 'daniel@team.com'),
(1, 'Sergio', 'Mora', 'Portero', 1, '2002-04-10', 'sergio@team.com'),
(2, 'Juan', 'Ríos', 'Defensa', 4, '2004-01-15', 'juan@team.com');

-- Partidos programados
INSERT INTO matches (home_team_id, away_team_id, referee_id, match_date, match_time, venue)
VALUES
(1, 2, 1, '2025-10-15', '15:00', 'Cancha Sintética 12 de Octubre'),
(2, 3, 2, '2025-10-20', '16:30', 'Estadio Los Fundadores');

-- Actualizar un partido a played (ejemplo)
UPDATE matches
SET status = 'played', home_goals = 3, away_goals = 1
WHERE id = 1;
