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
source /root/devils/var.txt && echo $BOT_TOKEN >.bot
azi=$(cat .bot)
source /root/devils/var.txt && echo $ADMIN >.id
aji=$(cat .id)
export TIME="10"
export URL="https://api.telegram.org/bot$azi/sendMessage"
source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
  domain=$(cat /etc/xray/domain)
else
  domain=$IP
fi

tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2 | sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2 | sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
  echo -e "$RED══════════════════════════════════════════════════$NC"
  echo -e "\E[47;1;30m               ⇱ TRIAL VMESS USER ⇲               \E[0m"
  echo -e "$RED══════════════════════════════════════════════════$NC"
  user=Devils$(tr </dev/urandom -dc X-Z0-9 | head -c4)
  echo 1 >/etc/dvs/limit/vmess/ip/${user}

  uuid=$(cat /proc/sys/kernel/random/uuid)
  Quota="1"
  exp=$(date -d "1 hour" +"%T")
  echo "Expiry date: $exp"
  CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

  if [[ ${CLIENT_EXISTS} == '1' ]]; then
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m               ⇱ TRIAL VMESS USER ⇲               \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo ""
    echo "A client with the specified name was already created, please choose another name."
    echo ""
    echo -e "$RED══════════════════════════════════════════════════$NC"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
  fi
done

sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
exp=$(date -d "$masaaktif hours" +"%H:%M:%S")
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json

DATADB=$(cat /root/akun/vmess/.vmess.conf | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /root/akun/vmess/.vmess.conf
fi
echo "### ${user} ${exp} ${uuid}" >>/root/akun/vmess/.vmess.conf

asu=$(cat <<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF
)
ask=$(cat <<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF
)
grpc=$(cat <<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF
)
vmess_base641=$(base64 -w 0 <<<$vmess_json1)
vmess_base642=$(base64 -w 0 <<<$vmess_json2)
vmess_base643=$(base64 -w 0 <<<$vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray >/dev/null 2>&1
service cron restart >/dev/null 2>&1

cat >/home/vps/public_html/vmess-$user.yaml <<-END

# Format Vmess WS TLS

- name: Vmess-$user-WS TLS
  type: vmess
  server: ${domain}
  port: 443
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess WS Non TLS

- name: Vmess-$user-WS Non TLS
  type: vmess
  server: ${domain}
  port: 80
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess gRPC

- name: Vmess-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vmess
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  network: grpc
  tls: true
  servername: ${domain}
  skip-cert-verify: true
  grpc-opts:
    grpc-service-name: vmess-grpc


END
TEXT="
<code>───────────────────────────</code>
<code>      🎗 TRIAL VMESS USER 🎗</code>
<code>───────────────────────────</code>
<code>Remarks    : </code><code>${user}</code>
<code>Expired On : </code><code>${exp}</code>
<code>Domain     : </code><code>${domain} GB</code>
<code>Port TLS   : 443</code>
<code>Port NTLS  : 80</code>
<code>Port GRPC  : 443</code>
<code>User ID    : </code><code>${uuid}</code>
<code>AlterId    : 0</code>
<code>Security   : auto</code>
<code>Network    : WS or gRPC</code>
<code>Path       : (/vmess - /whatever)</code>
<code>Path WSS   : (wss://bug.com/vmess)</code>
<code>ServiceName: vmess-grpc</code>
<code>───────────────────────────</code>
<code>Link TLS   :</code> 
<code>${vmesslink1}</code>
<code>───────────────────────────</code>
<code>Link NTLS  :</code> 
<code>${vmesslink2}</code>
<code>───────────────────────────</code>
<code>Link GRPC  :</code> 
<code>${vmesslink3}</code>
<code>───────────────────────────</code>
<code>Format OpenClash :</code> https://${domain}:81/vmess-$user.yaml
<code>───────────────────────────</code>
"
curl -s --max-time $TIME -d "chat_id=$aji&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/vmess/$user.txt
echo -e "\E[47;1;30m                • TRIAL VMESS USER •              \E[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} Remarks       : ${user}" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} Expired On    : $exp" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} Domain        : ${domain}" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} Port TLS      : ${tls}" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} Port none TLS : ${none}" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} Port  GRPC    : ${tls}" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} id            : ${uuid}" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} Security      : auto" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} Network       : ws" | tee -a /root/akun/vmess/$user.txt
#echo -e "$COLOR1 ${NC} Limit (GB)    : $Quota GB"  | tee -a /root/akun/vmess/$user.txt
#echo -e "$COLOR1 ${NC} Limit (IP)    : $iplimit IP"  | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} Path          : /vmess - /whatever" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} Path WSS      : wss://bug.com/vmess" | tee -a /root/akun/vmess/$user.txt
echo -e "$COLOR1 ${NC} ServiceName   : vmess-grpc" | tee -a /root/akun/vmess/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/vmess/$user.txt
echo -e "Link TLS : ${vmesslink1}" | tee -a /root/akun/vmess/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/vmess/$user.txt
echo -e "None TLS : ${vmesslink2}" | tee -a /root/akun/vmess/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/vmess/$user.txt
echo -e "Link GRPC : ${vmesslink3}" | tee -a /root/akun/vmess/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/vmess/$user.txt
echo -e "Config OpenClash : http://${domain}:81/vmess-$user.yaml" | tee -a /root/akun/vmess/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/vmess/$user.txt
echo "" | tee -a /root/akun/vmess/$user.txt

