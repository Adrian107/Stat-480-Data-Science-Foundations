
cd ~/Stat480/hb-workspace/input/ncdc

./ncdc_data.sh 1910 1919

#Exercise 1


hadoop fs -put ~/Stat480/hb-workspace/input/ncdc/all/191* input/ncdc/all

##Change the permission
chmod a+x /home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q1_map.py
chmod a+x /home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q1_reduce.py

##Quotes from the Notes
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
  -files /home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q1_map.py,\
/home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q1_reduce.py \
  -input input/ncdc/all\
  -output outputpy \
  -mapper "/home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q1_map.py" \
  -reducer "/home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q1_reduce.py" 


# See result files.
hadoop fs -ls outputpy

# View results.
hadoop fs -cat outputpy/part*

# Need to delete outputpy directory to use outputpy directory again.
hadoop fs -rm -r -f outputpy



#Exercise 2

##Change the permission
chmod a+x /home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q2_map.py
chmod a+x /home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q2_reduce.py


##Quotes from the Notes
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
  -files /home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q2_map.py,\
/home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q2_reduce.py \
  -input input/ncdc/all\
  -output outputpy2 \
  -mapper "/home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q2_map.py" \
  -reducer "/home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q2_reduce.py" 


# See result files.
hadoop fs -ls outputpy2

# View results.
hadoop fs -cat outputpy2/part*

# Need to delete outputpy directory to use outputpy directory again.
hadoop fs -rm -r -f outputpy2




#Exercise 3

##Change the permission
chmod a+x /home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q3_map.py
chmod a+x /home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q3_reduce.py


##Quotes from the Notes
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
  -files /home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q3_map.py,\
/home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q3_reduce.py \
  -input input/ncdc/all\
  -output outputpy3 \
  -mapper "/home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q3_map.py" \
  -reducer "/home/donghan2/Stat480/hb-workspace/ch02-mr-intro/src/main/python/HW05_Q3_reduce.py" 



# See result files.
hadoop fs -ls outputpy3

# View results.
hadoop fs -cat outputpy3/part*

# Need to delete outputpy directory to use outputpy directory again.
hadoop fs -rm -r -f outputpy3

