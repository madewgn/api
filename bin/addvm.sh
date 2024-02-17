#!/bin/bash
touch /etc/xray/blacklist.json
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
###########- COLOR CODE -##############
colornow=$(cat /etc/ssnvpn/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1='\033[0;35m'
###########- END COLOR CODE -##########

function addvmess() {
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
    echo -e "\E[47;1;30m               ⇱ CREATE VMESS USER ⇲              \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2 | sed 's/ //g')"
    none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2 | sed 's/ //g')"
    until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
        echo ""
        echo "   Setup Limit Quota/ip for Account"
        echo "    ➤  0 For Unlimited/No Limit"
        echo "    ➤  1-999 For limited/Limit"
        echo ""
        read -rp " Input Username : " user
        read -rp " Input limit Quota :" Quota
        read -rp " Input limit Ip :" iplimit
        read -rp " Expired (days): " masaaktif
        #//read -rp " input your limit login:" max  #!/bin/bash

        folder="/etc/dvs/limit/vmess/ip/"
        if [ ! -d "$folder" ]; then
            mkdir -p "$folder"
        else
            echo ""
        fi
        if [ $iplimit -eq 0 ]; then
            iplimit=6969
        fi
        echo $iplimit >/etc/dvs/limit/vmess/ip/${user}

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
            echo -e "\E[47;1;30m               ⇱ CREATE VMESS USER ⇲              \E[0m"
            echo -e "$RED══════════════════════════════════════════════════$NC"
            echo -e "$LIGHT Please choose another name. $NC"
            echo -e "$RED══════════════════════════════════════════════════$NC"
            read -n 1 -s -r -p "   Press any key to back on menu"
            menu
        fi
    done

    uuid=$(cat /proc/sys/kernel/random/uuid)
    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    sed -i '/#vmess$/a\### '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    sed -i '/#vmessgrpc$/a\### '"$user $exp $uuid"'\
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
      "path": "/vmess",
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
      "path": "/vmess",
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
      "path": "vmess-grpc",
      "type": "none",
      "host": "${domain}",
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
    if [ ! -e /etc/vmess ]; then
        mkdir -p /etc/vmess
    fi
    if [ -z ${Quota} ]; then
        Quota="0"
    fi
    c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
    d=$((${c} * 1024 * 1024 * 1024))
    if [[ ${c} != "0" ]]; then
        echo "${d}" >/etc/vmess/${user}
    fi
    DATADB=$(cat /etc/vmess/.vmess.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
    if [[ "${DATADB}" != '' ]]; then
        sed -i "/\b${user}\b/d" /etc/vmess/.vmess.db
    fi
    echo "### ${user} ${exp} ${uuid}" >>/etc/vmess/.vmess.db

    clear -x
    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    # untuk restore

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
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "\E[47;1;30m                • CREATE VMESS USER •             \E[0m" | tee -a /etc/xray/log-create-${user}.log
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
    echo -e "$COLOR1 ${NC} Path          : /vmess - /whatever" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Path WSS      : wss://bug.com/vmess" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} ServiceName   : vmess-grpc" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "Link TLS : ${vmesslink1}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "None TLS : ${vmesslink2}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "Link GRPC : ${vmesslink3}" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$COLOR1 ${NC} Config OpenClash : http://${domain}:81/vmess-$user.yaml" | tee -a /etc/xray/log-create-${user}.log
    echo -e "$RED══════════════════════════════════════════════════$NC" | tee -a /etc/xray/log-create-${user}.log
    echo "" | tee -a /etc/xray/log-create-${user}.log
    cat >/tmp/vmess/$user.txt <<EOF
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
${vmesslink1}
-------------------------------------------
Link none TLS :
${vmesslink2}
-------------------------------------------
Link GRPC :
${vmesslink3}
--------------------------------------------
EOF
    TEXT="
<code>───────────────────────────</code>
<code>      🎗 CREATE VMESS USER 🎗</code>
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

}

addvmess
