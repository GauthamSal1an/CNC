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
set n8 [ $ns node ]

$ns make-lan "$n0 $n1 $n2 $n3 $n4 $n5 $n6 $n7" 10Mb 10ms LL Queue/DropTail Mac/802_3
$ns duplex-link $n7 $n8 10Mb 10ms DropTail
$ns duplex-link-op $n7 $n8 orient right-down

set tcp0 [ new Agent/TCP ]
$ns attach-agent $n0 $tcp0
set tcpsink0 [ new Agent/TCPSink ]
$ns attach-agent $n8 $tcpsink0
$ns connect $tcp0 $tcpsink0

set ftp0 [ new Application/FTP ]
$ftp0 attach-agent $tcp0

set tcp1 [ new Agent/TCP ]
$ns attach-agent $n1 $tcp1
set tcpsink1 [ new Agen/TCPSink ]
$ns attach-agent $n6 $tcpsink1

set ftp1 [ new Application/FTP ]
$ftp1 attach-agent $tcp1

set file1 [ open file1.tr w ]
$tcp0 attach $file1

set file2 [ open file2.tr w ]
$tcp1 attach $file2

$tcp0 trace cwnd_

$tcp1 trace cwnd_

$ns at 0.5 "$ftp0 start"
$ns at 0.5 "$ftp1 start"
$ns at 4.0 "$ftp0 stop"
$ns at 4.0 "$ftp1 stop"
$ns at 4.5 "finish"

$ns run