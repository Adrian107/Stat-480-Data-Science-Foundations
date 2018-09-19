# Get data from 2002 and 2005
./airlines_data_individual.sh 2002 2005

# The script writes data to a file called airlines.csv .
# Let's move that so we know what's actually in the file.
mv airlines.csv AirlineData0205.csv

# Run .hive script to combine AirlineData0205.csv with
# airports.csv, carriers.csv, and plane-data.csv
# Pipe the script output to a combined csv file called
# AllAirlineData0205.csv
hive -f combineData.hive | sed 's/[\t]/,/g'  > AllAirlineData0205.csv