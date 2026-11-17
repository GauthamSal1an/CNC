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
set n3 [ $ns node ]

$ns duplex-link $n0 $n2 10Mb 10ms DropTail
$ns duplex-link $n1 $n2 10Mb 10ms DropTail
$ns duplex-link $n2 $n3 10Mb 10ms DropTail

set tcp [ new Agent/TCP ]
$ns attach-agent $n0 $tcp
set tcpsink [ new Agent/TCPSink ]
$ns attach-agent $n3 $tcpsink
$ns connect $tcp $tcpsink

set ftp [ new Application/FTP ]
$ftp attach-agent $tcp

set udp [ new Agent/UDP ]
$ns attach-agent $n1 $udp
set null [ new Agent/Null ]
$ns attach-agent $n3 $null
$ns connect $udp $null

set cbr [ new Application/Traffic/CBR ]
$cbr set interval_ 0.0005
$cbr set packetSize_ 1500
$cbr attach-agent $udp

$ns at 0.5 "$ftp start"
$ns at 3.0 "$ftp stop"

$ns at 0.5 "$cbr start"
$ns at 3.0 "$cbr stop"

$ns at 3.5 "finish"

$ns run