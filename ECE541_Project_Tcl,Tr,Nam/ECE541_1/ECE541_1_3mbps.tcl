#Create a simulator object

set ns [new Simulator]

 

#Open the nam trace file

set nf [open ECE541_1_a_3mbps.nam w]

$ns namtrace-all $nf

 

set nd [open ECE541_1_3mbps.tr w]

$ns trace-all $nd

 

#Define a 'finish' procedure

proc finish {} {

        global ns nf nd

        $ns flush-trace

        #Close the trace file

        close $nf

        close $nd

        #Execute nam on the trace file

        exec nam ECE541_1_a_3mbps.nam &

        exit 0

}

 

#Create two nodes

set n0 [$ns node]

set n1 [$ns node]

 

#Create links between the nodes

$ns duplex-link $n0 $n1 1Mb 10ms DropTail

$ns duplex-link-op $n0 $n1 orient right

$ns duplex-link-op $n0 $n1 queuePos 0.5



#Create a UDP agent and attach it to node n0

set udp [new Agent/UDP]

$ns attach-agent $n0 $udp

 

# Create a CBR traffic source and attach it to udp

set cbr [new Application/Traffic/CBR]

$cbr set rate_ 3mbps

$cbr attach-agent $udp

 

#Create a Null agent (a traffic sink) and attach it to node n1

set null [new Agent/Null]

$ns attach-agent $n1 $null

 

#Connect the traffic sources with the traffic sink

$ns connect $udp $null  

 

#Schedule events for the CBR agents

$ns at 0 "$cbr start"

$ns at 10 "$cbr stop"



#Call the finish procedure after 5 seconds of simulation time

$ns at 10.1 "finish"

 

#Run the simulation

$ns run
