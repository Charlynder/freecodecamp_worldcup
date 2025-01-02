# FreeCodeCamp WorldCup

Create the database. 
```bash
psql --username=freecodecamp --dbname=postgre -a -f worldcup.sql
```

Make the bash scripts exacutable using 
```bash
chmod +x insert_data.sh queries.sh
```

Inser the data & queries the database to ensure the data has been insert correctly
```bash
./inser_data.sh; ./queries.sh
```

Make sure the code has pased the test
```
space + Enter
```
