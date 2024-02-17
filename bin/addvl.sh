#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
###########- COLOR CODE -##############
NC="\e[0m"
RED="\033[0;31m"
COLOR1="\033[0;35m"
YELLOW="\033[0;33m"
LIGHT="\033[0;37m"
###########- END COLOR CODE -##########

function addvless() {
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
    echo -e "\E[47;1;30m               ⇱ CREATE VLESS USER ⇲              \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2 | sed 's/ //g')"
    none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2 | sed 's/ //g')"
    until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
        echo ""
        echo "   Setup Limit Quota/ip for Account"
        echo "    ➤  0 For Unlimited/No Limit"
        echo "    ➤  1-999 For limited/Limit"
        echo ""
        read -rp " Input Username : " user
        read -rp " Input limit Quota :" Quota
        read -rp " Input limit IP :" iplimit
        read -p " Expired (days): " masaaktif
        #//read -rp " input your limit login:" max  #!/bin/bash

        folder="/etc/dvs/limit/vless/ip/"
        if [ ! -d "$folder" ]; then
            mkdir -p "$folder"
        else
            echo ""
        fi
        echo $iplimit >/etc/dvs/limit/vless/ip/${user}

        if [ -z $user ]; then
            echo -e "$LIGHT [Error] Username cannot be empty $NC"
            echo -e "$RED══════════════════════════════════════════════════$NC"
            echo ""
            read -n 1 -s -r -p "   Press any key to back on menu"
            menu
        fi
        CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

        if [[ ${CLIENT_EXISTS} == '1' ]]; then
            clear
            echo -e "$RED══════════════════════════════════════════════════$NC"
            echo -e "\E[47;1;30m               ⇱ CREATE VLESS USER ⇲              \E[0m"
            echo -e "$RED══════════════════════════════════════════════════$NC"
            echo -e "$LIGHT Please choose another name. $NC"
            echo -e "$RED══════════════════════════════════════════════════$NC"
            read -n 1 -s -r -p "   Press any key to back on menu"
            menu
        fi
    done

    uuid=$(cat /proc/sys/kernel/random/uuid)

    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    asu=$(
        cat <<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vless",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF
    )
    ask=$(
        cat <<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vless",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
    )
    grpc=$(
        cat <<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vless-grpc",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF
    )
    vless_base641=$(base64 -w 0 <<<$vless_json1)
    vless_base642=$(base64 -w 0 <<<$vless_json2)
    vless_base643=$(base64 -w 0 <<<$vless_json3)
    vlesslink1="vless://$(echo $asu | base64 -w 0)"
    vlesslink2="vless://$(echo $ask | base64 -w 0)"
    vlesslink3="vless://$(echo $grpc | base64 -w 0)"
    systemctl restart xray >/dev/null 2>&1
    service cron restart >/dev/null 2>&1
    if [ ! -e /etc/vless ]; then
        mkdir -p /etc/vless
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
        echo "${d}" >/etc/vless/${user}
    fi
    DATADB=$(cat /etc/vless/.vless.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
    if [[ "${DATADB}" != '' ]]; then
        sed -i "/\b${user}\b/d" /etc/vless/.vless.db
    fi
    echo "### ${user} ${exp} ${uuid}" >>/etc/vless/.vless.db
    clear -x
    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    # untuk restore

    cat >/home/vps/public_html/vless-$user.yaml <<-END


# Format vless WS TLS

- name: vless-$user-WS TLS
  type: vless
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
    path: /vless
    headers:
      Host: ${domain}

# Format vless WS Non TLS

- name: vless-$user-WS Non TLS
  type: vless
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
    path: /vless
    headers:
      Host: ${domain}

# Format vless gRPC

- name: vless-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vless
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  network: grpc
  tls: true
  servername: ${domain}
  skip-cert-verify: true
  grpc-opts:
    grpc-service-name: vless-grpc


END
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "\E[47;1;30m                • CREATE VLESS USER •             \E[0m" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Remarks       : ${user}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Expired On    : $exp" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Domain        : ${domain}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Port TLS      : ${tls}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Port none TLS : ${none}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Port  GRPC    : ${tls}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} id            : ${uuid}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Security      : auto" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Network       : ws" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Limit (GB)    : $Quota GB" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Limit (IP)    : $iplimit IP" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Path          : /vless - /whatever" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Path WSS      : wss://bug.com/vless" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} ServiceName   : vless-grpc" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "Link TLS : ${vlesslink1}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "None TLS : ${vlesslink2}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "Link GRPC : ${vlesslink3}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Config OpenClash : http://${domain}:81/vless-$user.yaml" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo "" | tee -a /etc/xray/log-create-${user}.log
    cat >/tmp/vless/$user.txt <<EOF
-------------------------------------------
Remarks       : ${user}
Expired On    : $exp
Domain        : ${domain}
Port TLS      : ${tls}
Port none TLS : ${none}
id            : ${uuid}
Limit (IP)    : ${iplimit}
Limit (GB)    : $Quota GB
------------------------------------------
Link TLS :
${vlesslink1}
-------------------------------------------
Link none TLS :
${vlesslink2}
-------------------------------------------
Link GRPC :
${vlesslink3}
--------------------------------------------
EOF
    TEXT="
<code>───────────────────────────</code>
<code>      🎗 CREATE VLESS USER 🎗</code>
<code>───────────────────────────</code>
<code>Remarks    : </code><code>${user}</code>
<code>Expired On : </code><code>${exp}</code>
<code>Domain     : </code><code>${domain}</code>
<code>Port TLS   : 443</code>
<code>Port NTLS  : 80</code>
<code>Port GRPC  : 443</code>
<code>User ID    : </code><code>${uuid}</code>
<code>AlterId    : 0</code>
<code>Security   : auto</code>
<code>Network    : WS or gRPC</code>
<code>Limit (GB) : </code><code>$Quota GB</code>
<code>Limit (IP) : </code><code>$iplimit IP</code>
<code>Path       : (/vless - /whatever)</code>
<code>Path WSS   : (wss://bug.com/vless)</code>
<code>ServiceName: vless-grpc</code>
<code>───────────────────────────</code>
<code>Link TLS     :</code> 
<code>${vlesslink1}</code>
<code>───────────────────────────</code>
<code>Link NTLS    :</code> 
<code>${vlesslink2}</code>
<code>───────────────────────────</code>
<code>Link GRPC    :</code> 
<code>${vlesslink3}</code>
<code>───────────────────────────</code>
<code>Format OpenClash :</code> https://${domain}:81/vless-$user.yaml
<code>───────────────────────────</code>
"
    curl -s --max-time $TIME -d "chat_id=$aji&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

}

addvless
