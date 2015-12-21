BEGIN {
totalpckts = 0;
pcktslost = 0;
lossrate = 0;
}
#body
{
        event = $1
	time = $2
        pcktsize = $6

if ((( event == "r") || ( event == "d")) && ( time >= 0 ))
{	
totalpckts+=pcktsize*8/1000;
}

if (( event == "d") && ( time >= 0 ))
{
pcktslost+=pcktsize*8/1000;
}

}

END {
lossrate = pcktslost/totalpckts;
print ("loss-rate: "lossrate);
}

