BEGIN{
    tcp_size = 0;
}{
    if ($5 == "tcp" && $1 == "r" && $4 == "7"){
        tcp_size += $6;
    }
}END{
    duration = 3.5;
    printf("Throughput: %.2f", (tcp_size*8)/(duration*1000))
}