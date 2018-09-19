cd ~/Stat480/RDataScience/AirlineDelays

vi combinescript

cp 2000.csv AirlineData2000s.csv
for year in {2000..2008}
do
tail -n+2 $year.csv >>AirlineData2000s.csv
done

./combinescript
