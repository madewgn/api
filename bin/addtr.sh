#!/bin/bash

###########- COLOR CODE -##############
NC="\e[0m"
RED="\033[0;31m"
COLOR1="\033[0;35m"
YELLOW="\033[0;33m"
LIGHT="\033[0;37m"
###########- END COLOR CODE -##########

function addtrojan() {
    clear
    source /root/devils/var.txt && echo $BOT_TOKEN >.bot
    azi=$(cat .bot)
    source /root/devils/var.txt && echo $ADMIN >.id
    aji=$(cat .id)
    export TIME="10"
    export URL="https://api.telegram.org/bot$azi/sendMessage"
    source /var/lib/ssnvpn-pro/ipvps.conf
    domain=$(cat /etc/xray/domain)
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m              ⇱ CREATE TROJAN USER ⇲              \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    tr="$(cat ~/log-install.txt | grep -w "Trojan WS " | cut -d: -f2 | sed 's/ //g')"
    until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
        echo ""
        echo "   Setup Limit Quota/ip for Account"
        echo "    ➤  0 For Unlimited/No Limit"
        echo "    ➤  1-999 For limited/Limit"
        echo ""
        read -rp " Input Username : " user
        read -rp " Input limit Quota :" Quota
        read -rp " Input limit IP :" iplimit
        read -rp " Expired (days): " masaaktif
        folder="/etc/dvs/limit/trojan/ip/"

        if [ ! -d "$folder" ]; then
            mkdir -p "$folder"
        else
            echo ""
        fi
        echo $iplimit >/etc/dvs/limit/vmess/ip/${user}

        if [ -z $user ]; then
            echo -e "$LIGHT [Error] Username cannot be empty $NC"
            echo -e "$RED══════════════════════════════════════════════════$NC"
            echo ""
            read -n 1 -s -r -p "   Press any key to back on menu"
            menu
        fi
        user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)
        if [[ ${user_EXISTS} == '1' ]]; then
            clear

            echo -e "$RED══════════════════════════════════════════════════$NC"
            echo -e "\E[47;1;30m              ⇱ CREATE TROJAN USER ⇲              \E[0m"
            echo -e "$RED══════════════════════════════════════════════════$NC"
            echo -e "$LIGHT Please choose another name. $NC"
            echo -e "$RED══════════════════════════════════════════════════$NC"
            read -n 1 -s -r -p "   Press any key to back on menu"
            trojan-menu
        fi
    done

    uuid=$(cat /proc/sys/kernel/random/uuid)
    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
    sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

    systemctl restart xray
    trojanlink1="trojan://${uuid}@${domain}:${tr}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"
    trojanlink="trojan://${uuid}@bug.com:${tr}?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
    if [ ! -e /etc/trojan ]; then
        mkdir -p /etc/trojan
    fi
    if [ -z ${iplimit} ]; then
        iplimit="0"
    fi
    if [ -z ${Quota} ]; then
        Quota="0"
    fi
    c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
    d=$((${c} * 1024 * 1024 * 1024))
    if [[ ${c} != "0" ]]; then
        echo "${d}" >/etc/trojan/${user}
    fi
    DATADB=$(cat /etc/trojan/.trojan.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
    if [[ "${DATADB}" != '' ]]; then
        sed -i "/\b${user}\b/d" /etc/trojan/.trojan.db
    fi
    echo "### ${user} ${exp} ${uuid}" >>/etc/trojan/.trojan.db
    clear

    # untuk restore
    #//echo "$user $exp $max $uuid" >> /root/limit/limittrojan.txt

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

    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "\E[47;1;30m               • CREATE TROJAN USER •             \E[0m" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Remarks     : ${user}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Expired On  : $exp" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Host/IP     : ${domain}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Port        : ${tr}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Key         : ${uuid}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} limit quota : $Quota GB" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} limit IP    : $iplimit IP" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Path        : /trojan-ws" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Path WSS    : wss://bug.com/trojan-ws" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} ServiceName : trojan-grpc" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "Link WS : ${trojanlink}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "Link GRPC : ${trojanlink1}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "Format OpenClash : http://${domain}:81/trojan-$user.yaml" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo "" | tee -a /etc/xray/log-create-${user}.log
    cat >/tmp/trojan/$user.txt <<EOF
-------------------------------------------
Remarks       : ${user}
Expired On    : $exp
Domain        : ${domain}
Port TLS      : ${tr}
id            : ${uuid}
Limit (GB)    : $Quota GB
Limit (IP)    : $iplimit IP
------------------------------------------
Link TLS :
${trojanlink}
-------------------------------------------
Link GRPC :
${trojanlink1}
--------------------------------------------
EOF
    TEXT="
<code>───────────────────────────</code>
<code>     🎗 CREATE TROJAN USER 🎗</code>
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
<code>Limit (GB)   : </code><code>$Quota GB</code>
<code>Limit (IP)   : </code><code>$iplimit IP</code>
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

}

addtrojan
