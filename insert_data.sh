#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games")

echo '========'

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    # Use INSERT ... ON CONFLICT DO NOTHING to handle duplicates efficiently
    $PSQL "INSERT INTO teams(name) VALUES('$WINNER') ON CONFLICT (name) DO NOTHING"
    $PSQL "INSERT INTO teams(name) VALUES('$OPPONENT') ON CONFLICT (name) DO NOTHING"

    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # Check if IDs are still empty after potential inserts/conflict
    if [[ -z "$winner_id" || -z "$opponent_id" ]]; then
      echo "Error: Could not retrieve team IDs for $WINNER or $OPPONENT" >&2
      exit 1
    fi

    $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $winner_id, $opponent_id, $WINNER_GOALS, $OPPONENT_GOALS)"
  fi
done

echo '================'
