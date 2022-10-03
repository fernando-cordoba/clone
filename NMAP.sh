#!/bin/bash

echo "Escaneando con NMAP a los  equipos de la  subred"
nmap -iL IP.txt > IPs-escaneadas.txt
echo "******************"
echo "Revise fichero IPs-escaneadas.txt"
