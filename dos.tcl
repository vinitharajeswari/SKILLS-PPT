#create a simulator
set ns [new Simulator]
#create trace file
set tracefile[open dos.tr w]
$ns trace-all $tracefile
#nam file creation
set namfile[open dos.anm w]
$ns namtrace-all $namfile
#finish procedure
proc  finish{}
{
global ns tracefile namfile
$ns flush-trace
close $tracefile
close $namfile
exec nam dos.nam &
exit 0
}
#create node
set server1[$ns node]
set server2[$ns node]
set client1[$ns node]
set client2[$ns node]
set attacker[$ns node]
#connection 
$ns duplex-line $client1 $server1 12Mb 100ms DropTail
$ns duplex-line $client2 $server1 12Mb 100ms DropTail
$ns duplex-line $attacker $server1 12Mb 100ms DropTail
$ns duplex-line $server1 $server2 6Mb 200ms DropTail

$ns queue-limit $server1 $server2 20
#create agents
set udp1[new Agent/UDP]
$ns attach-agent $client1 $udp1
set udp2[new Agent/UDP]
$ns attach-agent $client2 $udp2
set udp3[new Agent/UDP]
$ns attach-agent $client3 $udp3
set null [new Agent/Null]
$ns attach-agent $server2 $null
$ns connect $udp1 $null
$ns connect $udp2 $null
$ns connect $udp3 $null
#traffic
set cbr1[new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set packet_size_7000
$cbr1 set rate_0.4mb
$cbr1 set random_false
$cbr1 set interval_0.08

set cbr2[new Application/Traffic/CBR]
$cbr2 attach-agent $udp2
$cbr2 set packet_size_4000
$cbr2 set rate_0.6mb
$cbr2 set random_false
$cbr1 set interval_0.05

set cbr3[new Application/Traffic/CBR]
$cbr3 attach-agent $udp3
$cbr3 set packet_size_24000
$cbr3 set rate_0.4mb
$cbr3 set random_false
$cbr3 set interval_0.02
#start traffic 
$ns at 0.1 "$cbr1 start"
$ns at 0.1 "$cbr2 start"
$ns at 1.5 "$cbr3 start"
$ns at 0.5 "$cbr4 start"
$ns at 2.0 "$cbr5 start"
$ns at 2.5 "$cbr6 start"

$ns at 3.0 "finish"
$ns run
