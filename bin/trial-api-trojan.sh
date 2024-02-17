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
if [[ "$IP" = "" ]]; then
  domain=$(cat /etc/xray/domain)
else
  domain=$IP
fi
tr="$(cat ~/log-install.txt | grep -w "Trojan WS " | cut -d: -f2 | sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
  clear
  echo -e "$RED══════════════════════════════════════════════════$NC"
  echo -e "\E[47;1;30m               ⇱ TRIAL TROJAN ACCOUNT             \E[0m"
  echo -e "$RED══════════════════════════════════════════════════$NC"
  user=Trial$(tr </dev/urandom -dc X-Z0-9 | head -c4)
  echo 1 >/etc/dvs/limit/trojan/ip/${user}
  uuid=$(cat /proc/sys/kernel/random/uuid)
  Quota="1"
  exp=$(date -d "1 hour" +"%T")
  echo "Expiry date: $exp"

  user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

  if [[ ${user_EXISTS} == '1' ]]; then
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m               ⇱ TRIAL TROJAN ACCOUNT             \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo ""
    echo "A client with the specified name was already created, please choose another name."
    echo ""
    echo -e "$RED══════════════════════════════════════════════════$NC"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
  fi
done

sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

DATADB=$(cat /root/akun/trojan/.trojan.conf | grep "^#!" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /root/akun/trojan/.trojan.conf
fi
echo "#! ${user} ${exp} ${uuid}" >>/root/akun/trojan/.trojan.conf

# Link Trojan Akun
systemctl restart xray
trojanlink1="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink="trojan://${uuid}@bugkamu.com:443?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"

cat >/home/vps/public_html/trojan-$user.yaml <<-END

# Format Trojan GO/WS

- name: Trojan-$user-GO/WS
  server: ${domain}
  port: 443
  type: trojan
  password: ${uuid}
  network: ws
  sni: ${domain}
  skip-cert-verify: true
  udp: true
  ws-opts:
    path: /trojan-ws
    headers:
        Host: ${domain}

# Format Trojan gRPC

- name: Trojan-$user-gRPC
  type: trojan
  server: ${domain}
  port: 443
  password: ${uuid}
  udp: true
  sni: ${domain}
  skip-cert-verify: true
  network: grpc
  grpc-opts:
    grpc-service-name: trojan-grpc

END
TEXT="
<code>───────────────────────────</code>
<code>      🎗 TRIAL TROJAN USER 🎗</code>
<code>───────────────────────────</code>
<code>Remarks      : </code> <code>${user}</code>
<code>Expired On   : </code><code>${exp}</code>
<code>Domain       : </code> <code>${domain}</code>
<code>Port TLS     : </code> <code>443</code>
<code>Port NTLS    : </code> <code>80</code>
<code>Port GRPC    : </code> <code>443</code>
<code>User ID      : </code> <code>${uuid}</code>
<code>AlterId      : 0</code>
<code>Security     : auto</code>
<code>Network      : WS or gRPC</code>
<code>Path WS      : </code> <code>/trojan-ws</code>
<code>ServiceName  : </code> <code>trojan-grpc</code>
<code>──────────────────────</code>
<code>Link TLS     :</code> 
<code>${trojanlink}</code>
<code>──────────────────────</code>
<code>Link GRPC    :</code> 
<code>${trojanlink1}</code>
<code>──────────────────────</code>
<code>Format OpenClash : </code> https://${domain}:81/trojan-$user.yaml
<code>──────────────────────</code>
"
curl -s --max-time $TIME -d "chat_id=$aji&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

clear
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/trojan/$user.txt
echo -e "\E[47;1;30m              • TRIAL TROJAN USER •              \E[0m" | tee -a /root/akun/trojan/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1 ${NC} Remarks     : ${user}" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1 ${NC} Expired On  : $exp" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1 ${NC} Host/IP     : ${domain}" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1 ${NC} Port        : ${tr}" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1 ${NC} Key         : ${uuid}" | tee -a /root/akun/trojan/$user.txt
#echo -e "$COLOR1 ${NC} limit quota : $Quota GB" | tee -a /root/akun/trojan/$user.txt
#echo -e "$COLOR1 ${NC} limit IP    : $iplimit IP" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1 ${NC} Path        : /trojan-ws" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1 ${NC} Path WSS    : wss://bug.com/trojan-ws" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1 ${NC} ServiceName : trojan-grpc" | tee -a /root/akun/trojan/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/trojan/$user.txt
echo -e "Link WS : ${trojanlink}" | tee -a /root/akun/trojan/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/trojan/$user.txt
echo -e "Link GRPC : ${trojanlink1}" | tee -a /root/akun/trojan/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/trojan/$user.txt
echo -e "Format OpenClash : http://${domain}:81/trojan-$user.yaml" | tee -a /root/akun/trojan/$user.txt
echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /root/akun/trojan/$user.txt
echo "" | tee -a /root/akun/trojan/$user.txt
