set ns [ new Simulator ]

set nf [ open out.nam w ]
$ns namtrace-all $nf

set tf [ open out.tr w ]
$ns trace-all $tf

proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec nam out.nam &
    exit 0
}

set n0 [ $ns node ]
set n1 [ $ns node ]
set n2 [ $ns node ]

$ns duplex-link $n0 $n1 10Mb 10ms DropTail
$ns queue-limit $n0 $n1 10
$ns duplex-link $n1 $n2 10Mb 10ms DropTail
$ns queue-limit $n1 $n2 2

set udp [ new Agent/UDP ]
$ns attach-agent $n0 $udp
set null [ new Agent/Null ]
$ns attach-agent $n2 $null
$ns connect $udp $null

set cbr [ new Application/Traffic/CBR ]
$cbr packetSize_ 1500
$cbr interval_ 0.0005
$cbr attach-agent $udp

$ns at 0.5 "$cbr start"
$ns at 3.5 "$cbr stop"
$ns at 4.0 "finish"

$ns run