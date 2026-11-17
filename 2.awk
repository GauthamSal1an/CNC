BEGIN{
    tcp_pkt = 0;
    tcp_size = 0;
    udp_pkt = 0;
    udp_size = 0;
}{
    if ( $5 == "tcp" && $1 == "r" && $4 == "3" ){
        tcp_pkt ++;
        tcp_size += $6;
    }

    if ( $5 == "cbr" && $1 == "r" && $4 == "3" ){
        udp_pkt++;
        udp_size += $6;
    }
}END{
    duration = 2.5
    printf("Throughput of UDP is: %.2f", (udp_size*8)/(duration*1000));
    printf("Number of packets through UDP is %d", udp_pkt);
    printf("Throughput of TCP is: %.2f", (tcp_size*8)/(duration*1000));
    printf("Number of packets through TCP is %d", tcp_pkt);
}