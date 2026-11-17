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
set n4 [ $ns node ]
set n5 [ $ns node ]
set n6 [ $ns node ]
set n7 [ $ns node ]

$ns make-lan "$n0 $n1 $n2 $n3 $n4 $n5 $n6" 10Mb 10ms LL Queue/DropTail Mac/802_3
$ns duplex-link $n6 $n7 10Mb 10ms DropTail
$ns duplex-link-op $n6 $n7 orient right-down

set tcp [ new Agent/TCP ]
$ns attach-agent $n0 $tcp
set tcpsink [ new Agent/TCPSink ]
$ns attach-agent $n7 $tcpsink
$ns connect $tcp $tcpsink

set ftp [ new Application/FTP ]
$ftp attach-agent $tcp

$ns at 0.5 "$ftp start"
$ns at 3.5 "$ftp stop"
$ns at 4.0 "finish"

$ns run