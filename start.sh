#!/bin/bash

cd
cd tp1/jelly/pox/ext/

sudo python build_topology.sh -r0

sudo python build_topology.sh -r1

sudo python build_topology.sh -r2

cd

cd tp1/fattree/lib

sudo python pox.py DCController --topo=ft,4 --routing=ECMP 1>/dev/null

sudo python FT_TCP_ECMP_1.py -i data_iperf -d /mnt/tcp_FT_ecmp8_1/ -p  0.03 -t 10 --ecmp --iperf 1>/dev/null 2>&1


cd /mnt/tcp_FT_ecmp8_1/

cat *.out | grep sender | awk -F' ' '{print $5}' > data

soma=$(paste -sd+ data | bc)

div=$(cat data | wc -l)

total=`echo "scale=2 ; $soma / $div" | bc`

echo "ft ecmp8 tcp 1flow average : $total" > average.txt





