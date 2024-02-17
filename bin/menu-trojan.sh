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

BURIQ() {
    curl -sS https://rizki.serv00.net/Autoscript-by-azi-main/izin >/root/tmp
    data=($(cat /root/tmp | grep -E "^### " | awk '{print $2}'))
    for user in "${data[@]}"; do
        exp=($(grep -E "^### $user" "/root/tmp" | awk '{print $3}'))
        d1=($(date -d "$exp" +%s))
        d2=($(date -d "$biji" +%s))
        exp2=$(((d1 - d2) / 86400))
        if [[ "$exp2" -le "0" ]]; then
            echo $user >/etc/.$user.ini
        else
            rm -f /etc/.$user.ini >/dev/null 2>&1
        fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://rizki.serv00.net/Autoscript-by-azi-main/izin | grep $MYIP | awk '{print $2}')
echo $Name >/usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman() {
    if [ -f "/etc/.$Name.ini" ]; then
        CekTwo=$(cat /etc/.$Name.ini)
        if [ "$CekOne" = "$CekTwo" ]; then
            res="Expired"
        fi
    else
        res="Permission Accepted..."
    fi
}

PERMISSION() {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS curl -sS https://rizki.serv00.net/Autoscript-by-azi-main/izin | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
        Bloman
    else
        res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

function con() {
    local -i bytes=$1
    if [[ $bytes -lt 1024 ]]; then
        echo "${bytes}B"
    elif [[ $bytes -lt 1048576 ]]; then
        echo "$(((bytes + 1023) / 1024))KB"
    elif [[ $bytes -lt 1073741824 ]]; then
        echo "$(((bytes + 1048575) / 1048576))MB"
    else
        echo "$(((bytes + 1073741823) / 1073741824))GB"
    fi
}

function cektrojan() {
    clear
    echo -n >/tmp/other.txt
    data=($(cat /etc/xray/config.json | grep '^#!' | cut -d ' ' -f 2 | sort | uniq))
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m              ⇱ TROJAN USER ONLINE ⇲              \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "   user  ║ usage ║ quota ║ limit ║ login ║ waktu "
    echo -e "$RED══════════════════════════════════════════════════$NC"

    for akun in "${data[@]}"; do
        if [[ -z "$akun" ]]; then
            akun="tidakada"
        fi
        echo -n >/tmp/iptrojan.txt
        data2=($(cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq))
        for ip in "${data2[@]}"; do
            jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
            if [[ "$jum" = "$ip" ]]; then
                echo "$jum" >>/tmp/iptrojan.txt
            else
                echo "$ip" >>/tmp/other.txt
            fi
            jum2=$(cat /tmp/iptrojan.txt)
            sed -i "/$jum2/d" /tmp/other.txt >/dev/null 2>&1
        done
        jum=$(cat /tmp/iptrojan.txt)
        if [[ -z "$jum" ]]; then
            echo >/dev/null
        else
            iplimit=$(cat /etc/dvs/limit/trojan/ip/${akun})
            jum2=$(cat /tmp/iptrojan.txt | wc -l)
            byte=$(cat /etc/trojan/${akun})
            lim=$(con ${byte})
            wey=$(cat /etc/limit/trojan/${akun})
            gb=$(con ${wey})
            lastlogin=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)

            printf "  %-13s %-7s %-8s %2s\n" " ${akun}      ${gb}" "   ${lim}      $iplimit" "      $jum2     $lastlogin"
        fi
        rm -rf /tmp/iptrojan.txt
    done
    rm -rf /tmp/other.txt
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m                ⇱ DEVILS TUNNELING ⇲              \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo ""
    read -n 1 -s -r -p "   Press any key to back on menu"
    menu-trojan
}

function deltrojan() {
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m              ⇱ DELETE TROJAN USER ⇲              \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "$LIGHT  • You Dont have any existing clients!"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m              ⇱ DEVILS TUNNELING ⇲                \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo ""
        read -n 1 -s -r -p "   Press any key to back on menu"
        menu-trojan
    fi
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m              ⇱ DELETE TROJAN USER ⇲              \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "${RED}╔══• ${NC}${LIGHT}No  Username    Expired ${NC}"
    echo -e "${RED}╚════════════════════════════════════╝${NC}"
    grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
    echo -e "${RED}══════════════════════════════════════${NC}"
    echo -e "${LIGHT}Select 0 to return${NC}"
    echo -e "${LIGHT}Press CTRL+C To Exit${NC}"
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Delete: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                menu-trojan
            fi
        fi
    done
    user=$(grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    uuid=$(grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
    sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
    sed -i "/^### $user $exp/d" /etc/trojan/.trojan.db
    echo "### $user $exp $uuid" >>/etc/vless/akundeletetrojan
    clear
    sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
    sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
    rm /etc/dvs/limit/trojan/ip/${user}
    clear
    #rm /home/vps/public_html/trojan-$user.yaml >/dev/null 2>&1
    rm /etc/dvs/limit/trojan/ip/${user} >/dev/null 2>&1
    #rm /etc/trojan/${user}login >/dev/null 2>&1
    systemctl restart xray >/dev/null 2>&1
    service cron restart >/dev/null 2>&1
    service cron reload >/dev/null 2>&1
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m   ⇱ Trojan Account Deleted Successfully ⇲         \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo " Client Name : $user"
    echo " Expired On  : $exp"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo ""
    read -n 1 -s -r -p "   Press any key to back on menu"
    menu-trojan
}

function blacklist() {
    file="/root/limit/removeaccounttrojan.txt"
    if [ ! -d "$file" ]; then
        mkdir -p "$file"
    else
        echo ""
    fi
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/limit/removeaccounttrojan.txt")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m                ⇱ ABUSER TROJAN USER ⇲            \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e " • tidakada yang melanggar"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m                  ⇱ DEVILS TUNNELING ⇲            \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo ""
        read -n 1 -s -r -p "   Press any key to back on menu"
        menu-trojan
    fi
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m                ⇱ ABUSER TROJAN USER ⇲            \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "${RED}╔══• ${NC}${LIGHT}No  Username    Expired ${NC}"
    echo -e "${RED}╚════════════════════════════════════╝${NC}"
    grep -E "^### " "/root/limit/removeaccounttrojan.txt" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
    echo -e "${RED}══════════════════════════════════════${NC}"
    echo -e "${LIGHT}Select 0 to return${NC}"
    echo -e "${LIGHT}Write clear to delete all the accounts${NC}"
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                menu-trojan
            fi
        fi
    done
    user=$(grep -E "^### " "/root/limit/removeaccounttrojan.txt" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    uuid=$(grep -E "^### " "/root/limit/removeaccounttrojan.txt" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -E "^### " "/root/limit/removeaccounttrojan.txt" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)

    sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    sed -i '/#trojangrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    #menghapusbaris
    sed -i "/$user/d" /root/limit/limittrojan.txt
    systemctl restart xray >/dev/null 2>&1
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m                ⇱ UNLOCKED TROJAN USER ⇲             \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "   • Account Unlocked Successfully"
    echo -e ""
    echo -e "   • Client Name : $user"
    echo -e "   • Expired On  : $exp"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m                  ⇱ DEVILS TUNNELING ⇲            \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo ""
    read -n 1 -s -r -p "   Press any key to back on menu"
    menu-trojan
}

function renewtrojan() {
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        clear
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m            ⇱ Renew Trojan Account ⇲              \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "$LIGHT  • You Dont have any existing clients!"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m              ⇱ DEVILS TUNNELING ⇲                \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo ""
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        menu-trojan
    fi
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m            ⇱ Renew Trojan Account ⇲              \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "${RED}╔══• ${NC}${LIGHT}No  Username    Expired ${NC}"
    echo -e "${RED}╚════════════════════════════════════╝${NC}"
    grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
    echo -e "${RED}══════════════════════════════════════${NC}"
    echo -e "${LIGHT}Select 0 to return${NC}"
    echo -e "${LIGHT}Press CTRL+C To Exit${NC}"
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Renew: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                menu-trojan
            fi
        fi
    done
    read -p "Expired (days): " masaaktif
    read -p "Limit User (GB): " Quota
    read -p "Limit User (IP): " iplimit
    user=$(grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    user=$(grep -E "^### " "/etc/trojan/.trojan.db" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -E "^### " "/etc/trojan/.trojan.db" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    mkdir -p /etc/dvs/limit/trojan/ip
    if [ $iplimit -eq 0 ]; then
        iplimit=6969
    fi
    echo $iplimit >/etc/dvs/limit/trojan/ip/${user}
    if [ ! -e /etc/trojan/ ]; then
        mkdir -p /etc/trojan/
    fi

    if [ -z ${Quota} ]; then
        Quota="0"
    fi

    c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
    d=$((${c} * 1024 * 1024 * 1024))

    if [[ ${c} != "0" ]]; then
        echo "${d}" >/etc/trojan/${user}
    fi
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(((d1 - d2) / 86400))
    exp3=$(($exp2 + $masaaktif))
    exp4=$(date -d "$exp3 days" +"%Y-%m-%d")
    sed -i "/#! $user/c\#! $user $exp4" /etc/xray/config.json
    sed -i "/### $user/c\### $user $exp4" /etc/trojan/.trojan.db
    systemctl restart xray >/dev/null 2>&1
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m             ⇱ Renew Trojan Account ⇲             \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "   [INFO]  $user Account Renewed Successfully"
    echo -e " "
    echo -e "    Client Name : $user"
    echo -e "    Days Added  : $masaaktif Days"
    echo -e "    limit ip    : $iplimit ip"
    echo -e "    limit Quota : $Quota GB"
    echo -e "    Expired On  : $exp4"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m                ⇱ DEVILS TUNNELING ⇲              \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo ""

}
function con() {
    local -i bytes=$1
    if [[ $bytes -lt 1024 ]]; then
        echo "${bytes}B"
    elif [[ $bytes -lt 1048576 ]]; then
        echo "$(((bytes + 1023) / 1024))KB"
    elif [[ $bytes -lt 1073741824 ]]; then
        echo "$(((bytes + 1048575) / 1048576))MB"
    else
        echo "$(((bytes + 1073741823) / 1073741824))GB"
    fi
}

function cekmember() {
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m              ⇱  LIST TROJAN USER ⇲               \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "$LIGHT  • You Dont have any existing clients!"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m              ⇱ DEVILS TUNNELING ⇲                \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo ""
        read -n 1 -s -r -p "   Press any key to back on menu"
        menu-trojan
    fi
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m              ⇱  LIST TROJAN USER ⇲               \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "  user  ║ usage  ║   quota  ║ limit ip ║ expired"
    echo -e "$RED══════════════════════════════════════════════════$NC"

    data=($(cat /etc/xray/config.json | grep '#!' | cut -d ' ' -f 2 | sort | uniq))
    for akun in "${data[@]}"; do

        exp=$(grep -wE "^#! $akun" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        iplimit=$(cat /etc/dvs/limit/trojan/ip/${akun})
        byte=$(cat /etc/trojan/${akun})
        lim=$(con ${byte})
        wey=$(cat /etc/limit/trojan/${akun})
        gb=$(con ${wey})

        printf "%-10s %-10s %-10s %-20s\n" " ${akun}" " ${gb}" "${lim}" "$iplimit     $exp"

    done

    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m                ⇱ DEVILS TUNNELING ⇲              \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    read -n 1 -s -r -p "  • [NOTE] Press any key to back on menu"
    menu-trojan

}

function cek() {
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        clear
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m            ⇱ Config Trojan Account ⇲             \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "$LIGHT  • You Dont have any existing clients!"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m              ⇱ DEVILS TUNNELING ⇲                \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        menu-trojan
    fi
    clear
    echo ""
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m            ⇱ Config Trojan Account ⇲             \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "${RED}╔══• ${NC}${LIGHT}No  Username    Expired ${NC}"
    echo -e "${RED}╚════════════════════════════════════╝${NC}"
    grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
    echo -e "${RED}══════════════════════════════════════${NC}"
    echo -e "${LIGHT}Select 0 to return${NC}"
    echo -e "${LIGHT}Press CTRL+C To Exit${NC}"
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Detail: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                menu-trojan
            fi
        fi
    done
    clear
    user=$(grep -E "^### " "/etc/trojan/.trojan.db" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    cat /etc/xray/log-create-${user}.log
    read -n 1 -s -r -p "Press any key to back on menu"
    menu-trojan
}

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

    read -n 1 -s -r -p "   Press any key to back on menu"
    menu-trojan
}

clear
function res-user() {
    clear
    source /root/devils/var.txt && echo $BOT_TOKEN >.bot
    azi=$(cat .bot)
    source /root/devils/var.txt && echo $ADMIN >.id
    aji=$(cat .id)
    export TIME="10"
    export URL="https://api.telegram.org/bot$azi/sendMessage"
    domain=$(cat /etc/xray/domain)
    ISP=$(cat /etc/xray/isp)
    CITY=$(cat /etc/xray/city)
    cd
    if [ ! -e /etc/trojan/akundeletetrojan ]; then
        echo "" >/etc/trojan/akundeletetrojan
    fi
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/trojan/akundeletetrojan")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m            ⇱ Restore Trojan Account ⇲            \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "$LIGHT  • You Dont have any existing clients!"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m               ⇱ DEVILS TUNNELING ⇲               \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        menu-trojan
    fi

    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m            ⇱ Restore Trojan Account ⇲            \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "${RED}╔══• ${NC}${LIGHT}No  Username    Expired ${NC}"
    echo -e "${RED}╚════════════════════════════════════╝${NC}"
    grep -E "^### " "/etc/vless/akundeletevless" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
    echo -e "${RED}══════════════════════════════════════${NC}"
    echo -e "${LIGHT}Select 0 to return${NC}"
    echo -e "${LIGHT}Write clear to delete all the accounts${NC}"
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Restore: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                menu-trojan
            fi
            if [[ ${CLIENT_NUMBER} == 'clear' ]]; then
                rm /etc/trojan/akundeletetrojan
                menu-trojan
            fi
        fi
    done
    read -p "Expired (days): " masaaktif
    read -p "Limit User (GB): " Quota
    read -p "Limit User (IP): " iplimit
    exp=$(grep -wE "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    exp=$(grep -wE "^### $user" "/etc/trojan/.trojan.db" | cut -d ' ' -f 3 | sort | uniq)
    mkdir -p /etc/dvs/limit/trojan/ip
    if [ $iplimit -eq 0 ]; then
        iplimit=6969
    fi
    echo "$iplimit" >/etc/dvs/limit/trojan/ip/${user}
    if [ ! -e /etc/trojan/ ]; then
        mkdir -p /etc/trojan/
    fi

    if [ -z ${Quota} ]; then
        Quota="0"
    fi

    c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
    d=$((${c} * 1024 * 1024 * 1024))

    if [[ ${c} != "0" ]]; then
        echo "${d}" >/etc/limit/trojan/${user}
    fi
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(((d1 - d2) / 86400))
    exp3=$(($exp2 + $masaaktif))
    exp4=$(date -d "$exp3 days" +"%Y-%m-%d")
    sed -i "/#! $user/c\#! $user $exp4" /etc/xray/config.json
    sed -i "/### $user/c\### $user $exp4" /etc/trojan/.trojan.db
    user=$(grep -E "^### " "/etc/trojan/akundelete" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    uuid=$(grep -E "^### " "/etc/trojan/akundelete" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
    sed -i '/#trojan$/a\#! '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    sed -i '/#trojangrpc$/a\#! '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    echo "${Qouta}" >/etc/limit/trojan/${user}
    echo "${iplimit}" >/etc/dvs/limit/trojan/ip/${user}
    echo "### ${user} ${exp} ${uuid}" >>/etc/trojan/.trojan.db
    sed -i "/### $user $exp $uuid/d" /etc/trojan/akundeletetrojan
    systemctl restart xray
    TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b> XRAY TROJAN RESTORE</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$user </code>
<b>IP LIMIT  :</b> <code>$iplimit IP </code>
<b>EXPIRED  :</b> <code>$exp </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Succes Restore This Akun...</i>
"
    curl -s --max-time $TIME -d "chat_id=$aji&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m    ⇱ Trojan Account Restore Successfully ⇲        \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo " DOMAIN : $domain"
    echo " ISP  : $ISP $CITY"
    echo " USERNAME : $user"
    echo " IP LIMIT : $iplimit IP"
    echo " EXPIRED  : $exp"
    echo " Succes to Restore"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu-trojan
}
chngelimit() {
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m               ⇱ CHANGE TROJAN USER ⇲             \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "$LIGHT  • You Dont have any existing clients!"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m                ⇱ DEVILS TUNNELING ⇲              \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo ""
        read -n 1 -s -r -p "   Press any key to back on menu"
        menu-trojan
    fi
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m               ⇱ CHANGE TROJAN USER ⇲             \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "${RED}╔══• ${NC}${LIGHT}No  Username    Expired ${NC}"
    echo -e "${RED}╚════════════════════════════════════╝${NC}"
    grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
    echo -e "${RED}══════════════════════════════════════${NC}"
    echo -e "${LIGHT}Select 0 to return${NC}"
    echo -e "${LIGHT}Press CTRL+C To Exit${NC}"
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Change: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                menu-trojan
            fi
        fi
    done
    user=$(grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    user=$(grep -E "^### " "/etc/trojan/.trojan.db" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    clear
    read -p "Limit User (GB): " Quota
    read -p "Limit User (IP): " iplimit
    if [ $iplimit -eq 0 ]; then
        iplimit=6969
    fi
    echo "${iplimit}" >/etc/dvs/limit/trojan/ip/${user}
    if [ ! -e /etc/trojan ]; then
        mkdir -p /etc/trojan
    fi
    if [ -z ${iplimit} ]; then
        iplim="0"
    fi
    if [ -z ${Quota} ]; then
        Quota="0"
    fi
    c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
    d=$((${c} * 1024 * 1024 * 1024))
    if [[ ${c} != "0" ]]; then
        echo "${d}" >/etc/trojan/${user}
    fi
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m              ⇱ Change Trojan Account ⇲           \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "   [INFO]  $user Account Change Successfully"
    echo -e " "
    echo -e "    Client Name : $user"
    echo -e "    limit ip    : $iplimit ip"
    echo -e "    limit Quota : $Quota GB"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m                ⇱ DEVILS TUNNELING ⇲              \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu-trojan
}
function resquota() {
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m               ⇱ Reset Quota Trojan ⇲             \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "$LIGHT  • You Dont have any existing clients!"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo -e "\E[47;1;30m                ⇱ DEVILS TUNNELING ⇲              \E[0m"
        echo -e "$RED══════════════════════════════════════════════════$NC"
        echo ""
        read -n 1 -s -r -p "   Press any key to back on menu"
        menu-trojan
    fi
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m               ⇱ Reset Quota Trojan ⇲             \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "${RED}╔══• ${NC}${LIGHT}No  Username    Expired ${NC}"
    echo -e "${RED}╚════════════════════════════════════╝${NC}"
    grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
    echo -e "${RED}══════════════════════════════════════${NC}"
    echo -e "${LIGHT}Select 0 to return${NC}"
    echo -e "${LIGHT}Press CTRL+C To Exit${NC}"
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Reset: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                menu-trojan
            fi
        fi
    done
    user=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    user=$(grep -E "^### " "/etc/trojan/.trojan.db" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    echo "0" >/etc/trojan/${user}
    clear
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo -e "\E[47;1;30m       Trojan Account Was Successfully Reset      \E[0m"
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo ""
    echo " Client Name  : $user"
    echo " Successfully Resset Quota"
    echo ""
    echo -e "$RED══════════════════════════════════════════════════$NC"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu-trojan
}
clear
echo -e "${RED}╔══════════════════════════════════════════╗${NC}"
echo -e " \E[47;1;30m             ⇱ TROJAN MENU  ⇲             \E[0m"
echo -e "${RED}╚══════════════════════════════════════════╝${NC}"
echo -e ""
echo -e " ${LIGHT}[${RED}01${LIGHT}]${NC} ${RED}• ${LIGHT} ADD TROJAN ACCOUNT  $NC"
echo -e " ${LIGHT}[${RED}02${LIGHT}]${NC} ${RED}• ${LIGHT} ADD TROJAN ACCOUNT MANUAL UUID  $NC"
echo -e " ${LIGHT}[${RED}03${LIGHT}]${NC} ${RED}• ${LIGHT} RENEW TROJAN ACCOUNT ${NC}"
echo -e " ${LIGHT}[${RED}04${LIGHT}]${NC} ${RED}• ${LIGHT} DELETE TROJAN ACCOUNT ${NC}"
echo -e " ${LIGHT}[${RED}05${LIGHT}]${NC} ${RED}• ${LIGHT} USER ONLINE ACCOUNT $NC"
echo -e " ${LIGHT}[${RED}06${LIGHT}]${NC} ${RED}• ${LIGHT} CEK USAGE MAMBER${NC}"
echo -e " ${LIGHT}[${RED}07${LIGHT}]${NC} ${RED}• ${LIGHT} DETAIL CONFIG ACCOUNT${NC}"
echo -e " ${LIGHT}[${RED}08${LIGHT}]${NC} ${RED}• ${LIGHT} RESTORE EXP/DEL USER${NC}"
echo -e " ${LIGHT}[${RED}09${LIGHT}]${NC} ${RED}• ${LIGHT} CHANGE LIMIT TROJAN ACCOUNT${NC}"
echo -e " ${LIGHT}[${RED}10${LIGHT}]${NC} ${RED}• ${LIGHT} RESET QUOTA VMESS ACCOUNT${NC}"
echo -e " ${LIGHT}[${RED}11${LIGHT}]${NC} ${RED}• ${LIGHT} UNLOCK ABUSER IP TROJAN ACCOUNT${NC}"
echo -e " ${LIGHT}[${RED}00${LIGHT}]${NC} ${RED}• ${LIGHT} GO BACK${NC}"
echo -e ""
echo -e "${RED}════════════════════════════════════════════${NC}"
echo -e "\E[47;1;30m            ⇱ DEVILS TUNNELING ⇲            \E[0m"
echo -e "${RED}════════════════════════════════════════════${NC}"
echo -e ""
read -p " Select menu :  " opt
echo -e ""
case $opt in
01 | 1)
    clear
    addtrojan
    ;;
02 | 2)
    clear
    manual-tr
    ;;
03 | 3)
    clear
    renewtrojan
    ;;
04 | 4)
    clear
    deltrojan
    ;;
05 | 5)
    clear
    cektrojan
    ;;
06 | 6)
    clear
    cekmember
    ;;
07 | 7)
    clear
    cek
    ;;
08 | 8)
    clear
    res-user
    ;;
09 | 9)
    clear
    chngelimit
    ;;
10 | 10)
    clear
    resquota
    ;;
11 | 11)
    clear
    blacklist
    ;;
00 | 0)
    clear
    menu
    ;;
*)
    clear
    menu-trojan
    ;;
esac
