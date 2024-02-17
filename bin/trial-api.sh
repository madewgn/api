#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
export ungu='\033[0;35m'
clear
# =========================================
export MYIP=$(curl -s https://ipinfo.io/ip/)
IP=$(curl -sS ipv4.icanhazip.com)
ipsaya=$(wget -qO- ipinfo.io/ip)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://rizki.serv00.net/Autoscript-by-azi-main/izin"
CITY=$(cat /etc/xray/city)
PUB=$(cat /etc/slowdns/server.pub)
NS=$(cat /root/nsdomain)
domain=$(cat /etc/xray/domain)
checking_sc() {
  useexp=$(wget -qO- $data_ip | grep $ipsaya | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne
  else
    echo -e "${RED}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT}               ⇱ INFORMASI LISENSI ⇲          ${NC}"
    echo -e "${RED}╚════════════════════════════════════════════════════╝${NC}"
    echo -e "                 IP ${RED} $ipsaya${NC}"
    echo -e "                 ${YELLOW}PERIZINAN DITOLAK${NC}"
    echo -e "     ${YELLOW} SCRIPT TIDAK BISA DI GUNAKAN DI VPS ANDA${NC}"
    echo -e "    ${YELLOW} SILAHKAN LAKUKAN REGISTRASI TERLEBIH DAHULU${NC}"
    echo -e "${RED}═════════════════════════════════════════════════════${NC}"
    echo -e "        Harga Untuk 1 Bulan 1 IP Address : 15K"
    echo -e "                 ${CYAN}KONTAK REGISTRASI${NC}"
    echo -e "   ${LIGHT}|Telegram: @Rizyul04   | WhatsApp: 085163567549|${NC}"
    echo -e "${RED}═════════════════════════════════════════════════════${NC}"
    exit
  fi
}

clear
# Getting
echo -e "$RED═════════════════════════════════════════════${NC}"
echo -e "\E[47;1;30m            ⇱ CREATE TRIAL SSH ⇲             \E[0m"
echo -e "$RED═════════════════════════════════════════════${NC}"
Login=trial$(tr </dev/urandom -dc X-Z0-9 | head -c4)
masaaktif=1
Pass="1"
max="2"
domain=$(cat /etc/xray/domain)
sldomain=$(cat /root/nsdomain)
cdndomain=$(cat /root/awscdndomain)
slkey=$(cat /etc/slowdns/server.pub)
clear
echo 1 >/etc/dvs/limit/ssh/ip/${Login}
clear

echo "Script AutoCreate Akun SSH dan OpenVPN"
sleep 3
echo Ping Host
echo Cek Hak Akses...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Membuat Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
IP=$(wget -qO- ipinfo.io/ip)
ws="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2 | sed 's/ //g')"
ws2="$(cat ~/log-install.txt | grep -w "Websocket None TLS" | cut -d: -f2 | sed 's/ //g')"

ssl="$(cat ~/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear
useradd -e $(date -d "$masaaktif hours" +"%H:%M:%S") -s /bin/false -M $Login
expi="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"

echo -e "$Pass\n$Pass\n" | passwd $Login &>/dev/null
hariini=$(date -d "0 hours" +"%H:%M:%S")
expi=$(date -d "$masaaktif hours" +"%H:%M:%S")
clear
echo -e ""
echo -e "$RED═════════════════════════════════════════════${NC}"
echo -e "\E[47;1;30m             ⇱ TRIAL AKUN SSH ⇲              \E[0m"
echo -e "$RED═════════════════════════════════════════════${NC}"
echo -e "${LIGHT}Username: $Login"
echo -e "Password: $Pass"
echo -e "Created: Jam $hariini"
echo -e "Expired: Jam $expi"
echo -e "$RED═════════════════════════════════════════════${NC}"
echo -e "IP/Host: $IP"
echo -e "Domain SSH: $domain"
echo -e "Domain Cloudflare: $domain"
echo -e "PubKey : $slkey"
echo -e "Nameserver: $sldomain"
echo -e "$RED═════════════════════════════════════════════${NC}"
echo -e "OpenSSH: 22"
echo -e "Dropbear: 44, 69, 143"
echo -e "STunnel4: 442,222,2096"
echo -e "SlowDNS port: 53,5300,8080,443,80"
echo -e "SSH Websocket SSL/TLS: 443"
echo -e "SSH Websocket HTTP: 80,8080,8880"
echo -e "SSH Websocket Direct: 8080"
echo -e "OPEN VPN: 1194"
echo -e "BadVPN UDPGW: 7100,7200,7300"
echo -e "Proxy CloudFront: [OFF]"
echo -e "Proxy Squid: [ON]"
echo -e "OVPN TCP: http://$IP:81/tcp.ovpn"
echo -e "OVPN UDP: http://$IP:81/udp.ovpn"
echo -e "OVPN SSL: http://$IP:81/ssl.ovpn"
echo -e "$RED═════════════════════════════════════════════${NC}"
echo -e "SNI/Server Spoof: isi dengan bug"
echo -e "Payload Websocket SSL/TLS"
echo -e "$RED═════════════════════════════════════════════${NC}"
echo -e "GET wss://bug.com/ HTTP/1.1[crlf]Host: [host][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "$RED═════════════════════════════════════════════${NC}"
echo -e "Payload Websocket HTTP"
echo -e "$RED═════════════════════════════════════════════${NC}"
echo -e "GET / HTTP/1.1[crlf]Host: [host][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "$RED═════════════════════════════════════════════${NC}"
