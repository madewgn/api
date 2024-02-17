#!/bin/bash
clear
ipsaya=$(wget -qO- ipinfo.io/ip)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/JurigVPN/izinsc/main/ip"
checking_sc() {
  useexp=$(wget -qO- $data_ip | grep $ipsaya | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne
  else
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          \033[0m"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e ""
    echo -e "            ${RED}PERMISSION DENIED !${NC}"
    echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
    echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
    echo -e "             \033[0;33mContact Admin :${NC}"
    echo -e "      \033[0;36mTelegram${NC} t.me/JurigVPN"
    echo -e "      ${GREEN}WhatsApp${NC} wa.me/6283850135751"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    exit
  fi
}

clear
RED='\033[0;31m'
NC='\e[0m'
gray="\e[1;30m"
Blue="\033[1;36m"
GREEN='\033[0;32m'
grenbo="\033[1;95m"
YELL='\033[1;33m'
BGX="\033[42m"
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
domain=$(cat /etc/xray/domain)
IP=$(curl -sS ifconfig.me)
CITY=$(cat /etc/xray/city)
PUB=$(cat /etc/slowdns/server.pub)
NS=$(cat /etc/xray/dns)
TIMES="10"
CHATID=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 3)
KEY=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 2)
URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
echo -e "\033[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " \e[1;97m             CREATE TRIALL SSH OVPN ACCOUNT       \e[0m"
echo -e "\033[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
LOGIN=Trial-SSH$(tr </dev/urandom -dc 0-9 | head -c3)
PASSWD=1Jam
EXPIRED=1
useradd -e $(date -d "$EXPIRED days" +"%H") -s /bin/false -M $LOGIN
exp="$(chage -l $LOGIN | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$PASSWD\n$PASSWD\n" | passwd $LOGIN &>/dev/null

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/ssh/${LOGIN}
fi
DATADB=$(cat /etc/ssh/.ssh.db | grep "^###" | grep -w "${LOGIN}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${LOGIN}\b/d" /etc/ssh/.ssh.db
fi
echo "### ${LOGIN} " >>/etc/ssh/.ssh.db

cat >/var/www/html/ssh-$LOGIN.txt <<-END
=======================
P R O J E C T  O F
=======================
Telegram: t.me/JurigVPN 
=======================
Format SSH OVPN Triall Account
=======================

Username         : $LOGIN
Password         : $PASSWD
Expired          : $exp
_______________________________
IP               : $IP
Host             : $domain
Host Slowdns     : ${NS}
Pub Key          : ${PUB}
Location         : $CITY
Port OpenSSH     : 443, 80, 22
Port Dropbear    : 143, 109
Port Dropbear WS : 443, 109
Port SSH WS      : 80
Port SSH SSL WS  : 443
Port SSL/TLS     : 443
Port OVPN WS SSL : 443
Port OVPN SSL    : 1194
Port OVPN TCP    : 1194
Port OVPN UDP    : 2200
Proxy Squid 1    : 3128
Proxy Squid 2    : 8000
Proxy Squid 3    : 8080
BadVPN UDP       : 7100, 7300, 7300
_______________________________
Payload WSS: GET wss://BUG.COM/ HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf] 
_______________________________
OpenVPN WS SSL : https://$domain:81/"$domain"-ws-ssl.ovpn
OpenVPN SSL : https://$domain:81/"$domain"-ssl.ovpn
OpenVPN TCP : https://$domain:81/"$domain"-tcp.ovpn
OpenVPN UDP : https://$domain:81/"$domain"-udp.ovpn
_______________________________

END
TEXT="
<code>───────────────────────────</code>
<code>      SSH OVPN Account     </code>
<code>───────────────────────────</code>
<code>Username         : </code><code>$LOGIN</code>
<code>Password         : </code><code>$PASSWD</code>
<code>Expired          : $exp</code>
<code>───────────────────────────</code>
<code>Host             : </code><code>$domain</code>
<code>Host Slowdns     : </code><code>${NS}</code>
<code>Location         : $CITY</code>
<code>SSH UDP     : </code><code>1-65535</code>
<code>OpenSSH     : 443, 80, 22</code>
<code>Dropbear    : 143, 109</code>
<code>Dropbear WS : 443, 109</code>
<code>DNS         : 443, 53, 22</code> 
<code>SSH WS      : 80 </code>
<code>SSH SSL WS  : 443</code>
<code>SSL/TLS     : 443</code>
<code>OVPN WS SSL : 443</code>
<code>OVPN SSL    : 443</code>
<code>OVPN TCP    : 443, 1194</code>
<code>OVPN UDP    : 2200</code>
<code>Proxy Squid      : 3128</code>
<code>BadVPN UDP       : 7100, 7300, 7300</code>
<code>Pub Key          : </code><code>${PUB}</code>
<code>───────────────────────────</code>
<code>Payload WS       : GET / HTTP/1.1[crlf]Host: $domain[crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]</code>
<code>Payload WSS      : GET wss://[host]/ HTTP/1.1[crlf]Host: $domain[host_port][crlf]Upgrade: Websocket[crlf]Connection: Keep-Alive[crlf]Upgrade: websocket[crlf][crlf]</code>
<code>───────────────────────────</code>
<code>OpenVPN WS SSL   : </code>https://$domain:81/"$domain"-ws-ssl.ovpn
<code>OpenVPN SSL      : </code>https://$domain:81/"$domain"-ssl.ovpn
<code>OpenVPN TCP      : </code>https://$domain:81/"$domain"-tcp.ovpn
<code>OpenVPN UDP      : </code>https://$domain:81/"$domain"-udp.ovpn
<code>───────────────────────────</code>
<code>Save Link Account: </code>https://$domain:81/ssh-$LOGIN.txt
<code>───────────────────────────</code>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL
clear
echo -e "\033[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " \e[1;97m             SUCCESS CREATE TRIALL ACCOUNT      \e[0m"
echo -e "\033[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Username         : $LOGIN"
echo -e "Password         : $PASSWD"
echo -e "Expired          : $exp"
echo -e "\033[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Host             : $domain"
echo -e "Host Slowdns     : ${NS}"
echo -e "SSH UDP    : 1-65535"
echo -e "OpenSSH     : 443, 80, 22"
echo -e "DNS         : 443, 53 ,22"
echo -e "Dropbear    : 443, 109"
echo -e "Dropbear WS : 443, 109"
echo -e "SSH WS      : 80 "
echo -e "SSH SSL WS  : 443"
echo -e "SSL/TLS     : 443"
echo -e "OVPN WS SSL : 443"
echo -e "OVPN SSL    : 443"
echo -e "OVPN TCP    : 443, 1194"
echo -e "OVPN UDP    : 2200"
echo -e "Proxy Squid      : 3128"
echo -e "BadVPN UDP       : 7100, 7300, 7300"
echo -e "Pub Key          : ${PUB}"
echo -e "\033[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Payload WS       : GET / HTTP/1.1[crlf]Host: $domain[crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "Payload WSS      : GET wss://[host]/ HTTP/1.1[crlf]Host: $domain[host_port][crlf]Upgrade: Websocket[crlf]Connection: Keep-Alive[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "\033[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "OpenVPN WS SSL   : https://$domain:81/"$domain"-ws-ssl.ovpn"
echo -e "OpenVPN SSL      : https://$domain:81/"$domain"-ssl.ovpn"
echo -e "OpenVPN TCP      : https://$domain:81/"$domain"-tcp.ovpn"
echo -e "OpenVPN UDP      : https://$domain:81/"$domain"-udp.ovpn"
echo -e "\033[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Save Link Account: https://$domain:81/ssh-$LOGIN.txt"
echo -e "\033[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
