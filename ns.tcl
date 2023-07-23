create a simulator
set ns [new simulator]
#craete trace file
set trace file [open stable.tr w]
$ns trace-all $tracefile
#nam file creation
set namfile[open stable.anm w]
$ns namtrace-all $namfile
#finish procedure
proc finish { }
{
gloabl ns tracefile namfile
$ns flush-trace
close $tracefile
close $namfile
exec nam stable.nam
exit 0
}
#node creation 
set n1[$ns node]
set n2[$ns node]
#cconnection
$ns duplex-link $n1 $n2 5Mb 2ms Droptail
#agent creation
set udp [new Agent /UDP]
$ns attach-agent $n1 $Udp
set null[new Agent/Null]
$ns attach-agent $ns2 $null
$ns connect $Udp $null
#generate the traffic
set cbrstable [new Application/Traffic/CBR]
$cbrstable attack-agent $udp
#start traffic
$ns at 0.1 "$cbrstable start"
$ns at 4.5 "$cbrstable stop"
$ns at 5.0 "finish"
$ns run
