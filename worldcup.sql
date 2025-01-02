DROP DATABASE worldcup;

CREATE DATABASE worldcup;

ALTER DATABASE worldcup OWNER TO freecodecamp;

\c worldcup;

CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    name CHARACTER(15) UNIQUE NOT NULL
);

CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    year INTEGER NOT NULL,
    round VARCHAR(20) NOT NULL,
    winner_id INTEGER REFERENCES teams(team_id) NOT NULL,
    opponent_id INTEGER REFERENCES teams(team_id) NOT NULL,
    winner_goals INTEGER NOT NULL,
    opponent_goals INTEGER NOT NULL
);
