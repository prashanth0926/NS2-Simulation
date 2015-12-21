BEGIN {
totalpckts = 0;
gotime = 0;
starttime = 0;
endtime = 0;
throughput = 0;
}
#body
{
        event = $1
	time = $2
        pcktsize = $6

 if(gotime == 0) {
	starttime = time;
	gotime = 1; 
  } else {
	endtime = time;
  }

#============= CALCULATE throughput=================

if (( event == "r") && ( time >= starttime ))
{
duration = endtime - starttime;
totalpckts+=pcktsize*8/1000;
throughput = totalpckts/duration;
}

}


END {
print ("throughput: "throughput"kbps");
}

