import subprocess,re,json,base64

HOST =  subprocess.check_output('cat /etc/xray/domain', shell=True).decode("utf-8")
kota =  subprocess.check_output('cat /etc/xray/city', shell=True).decode("utf-8")
ISP =  subprocess.check_output('cat /etc/xray/isp', shell=True).decode("utf-8")
DOMAIN = HOST
quota = '1000'
limit_ip = '2'




from datetime import datetime, timedelta
import pytz

def get_future_date(days):
    # Zona waktu Makassar
    makassar_tz = pytz.timezone('Asia/Makassar')

    # Mendapatkan tanggal hari ini dengan zona waktu Makassar
    today = datetime.now(makassar_tz)

    # Convert days to an integer
    days = int(days)

    # Menghitung tanggal di masa depan sesuai dengan jumlah hari yang dimasukkan
    future_date = today + timedelta(days=days)

    # Format tanggal dalam string "YYYY-MM-DD"
    formatted_future_date = future_date.strftime('%Y-%m-%d')

    return formatted_future_date

# Contoh penggunaan: Mendapatkan tanggal 30 hari ke depan



def ssh(user,pw,exp):
    cmd = f'printf "%s\n" "{user}" "{pw}" "{exp}" "{limit_ip}" | usernew.sh'
    tgl = get_future_date(exp)
    try:
      text = subprocess.check_output(cmd,shell=True)
    except:
      print("**User Already Exist**")
    else:
        text = text.decode('utf-8')

        username_regex = r"Username: (\w+)"
        password_regex = r"Password: (\w+)"

        username_match = re.search(username_regex, text)
        password_match = re.search(password_regex, text)


        username = username_match.group(1)
        password = password_match.group(1)
        data =  {
          "meta": {
            "code": 200,
            "status": "success",
            "ip_address": "172.105.123.98",
            "message": "Create SSH Success"
          },
          "data": {
            "hostname": HOST,
            "ISP": ISP,
            "CITY": kota,
            "username": username,
            "servername": "",
            "pubkey": "",
            "password": password,
            "exp": tgl,
            "port": {
              "tls": 443,
              "none": 80,
              "drop1": 90,
              "drop2": 69,
              "ssh1": 444,
              "ovpntcp": 1194,
              "ovpnudp": 25000,
              "slowdns": 53,
              "slowdns1": 5300,
              "sshohp": 9080,
              "sshudp": "1-65535",
              "ovpnohp": 9088,
              "squid": 3128,
              "udpcustom": "1-65535"
            },
            "payloadws": {
              "payloadcdn": "GET / HTTP/1.1[crlf]Host: [host_port][crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]",
              "payloadwithpath": "GET /worryfree/ssh HTTP/1.1[crlf]Host: BUG[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
            }
          }
        }

        return data










def vless(user,exp):
    cmd = f'printf "%s\n" "{user}" "{quota}" "{limit_ip}" "{exp}" | addvl.sh'
    tgl = get_future_date(exp)
    try:
        a = subprocess.check_output(cmd, shell=True).decode("utf-8")
    except:
        print("**User Already Exist**")
    else:
        x = [x.group() for x in re.finditer("vless://(.*)",a)]
        #print(x)
        remarks = re.search("#(.*)",x[0]).group(1)
        # domain = re.search("@(.*?):",x[0]).group(1)
        uuid = re.search("vless://(.*?)@",x[0]).group(1)
        # path = re.search("path=(.*)&",x[0]).group(1)

        return {
  "meta": {
    "code": 200,
    "status": "success",
    "ip_address": DOMAIN,
    "message": "Create VLESS-WS Success"
  },
  "data": {
    "hostname": DOMAIN,
    "ISP": ISP,
    "CITY": kota,
    "username": remarks,
    "expired": tgl,
    "uuid": uuid,
    "port": {
      "tls": "443",
      "none": "80",
      "any": "8080"
    },
    "path": {
      "stn": "/vless",
      "multi": "/yourbug/vless"
    },
    "link": {
      "tls": x[0],
      "none": x[1].replace(" ","")
    }
  }
}




def vmess(user,exp):
    cmd = f'printf "%s\n" "{user}" "{quota}" "{limit_ip}" "{exp}" | addvm.sh'
    tgl = get_future_date(exp)
    try:
        a = subprocess.check_output(cmd, shell=True).decode("utf-8")
    except:
        print("**User Already Exist**")
    else:
        #        today = DT.date.today()
        #        later = today + DT.timedelta(days=int(exp))
        b = [x.group() for x in re.finditer("vmess://(.*)",a)]
#           c = [x.group() for x in re.finditer("Host XrayDNS(.*)",a)]
#           d = [x.group() for x in re.finditer("Pub Key(.*)",a)]
        print(b)
        z = base64.b64decode(b[0].replace("vmess://","")).decode("ascii")
        z = json.loads(z)
        z1 = base64.b64decode(b[1].replace("vmess://","")).decode("ascii")
        z1 = json.loads(z1)

        return {
  "meta": {                                                                                              "code": 200,                                                                                         "status": "success",                                                                                 "ip_address": "172.105.123.98",                                                                      "message": "Create VMESS-WS Success"
  },
  "data": {
    "hostname": DOMAIN,
    "ISP": ISP,
    "CITY": kota,
    "username": z['ps'],
    "expired": tgl,
    "uuid": z['id'],
    "port": {
      "tls": "443",
      "none": "80",
      "any": "8080"
    },
    "path": {
      "stn": "/vmess",
      "multi": "/yourbug"
    },
    "link": {
      "tls": b[0].strip("'").replace(" ",""),
      "none": b[1].strip("'").replace(" ",""), 
      "grpc": b[2].strip("'")
    }
  }
}



def trojan(user,exp):
    cmd = f'printf "%s\n" "{user}" "{quota}" "{limit_ip}" "{exp}" | addtr.sh'
    tgl = get_future_date(exp)
    try:
        a = subprocess.check_output(cmd, shell=True).decode("utf-8")
    except:
        print("**User Already Exist**")
    else:
        # today = DT.date.today()
        # later = today + DT.timedelta(days=int(exp))
        b = [x.group() for x in re.finditer("trojan://(.*)",a)]
        #print(b)
        domain = HOST
        uuid = re.search("trojan://(.*?)@",b[0]).group(1)
        remarks = re.search("#(.*)",b[0]).group(1)
        return {
  "meta": {
    "code": 200,
    "status": "success",
    "ip_address": domain,
    "message": "Create TROJAN-WS Success"

  },
    "data": {
    "hostname": domain,
    "ISP": ISP,                                              
    "CITY": kota,
    "username": remarks,
    "expired": tgl,
    "uuid": uuid,
    "port": {
      "tls": "443"
    },
    "path": {
      "stn": "/trojan",
      "multi": "/yourbug/trojan"
    },
    "link": {
      "tls": b[0].replace(" ",""),
      "grpc": b[1].replace(" ","")
      
    }
  }
}


