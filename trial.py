import subprocess,re,json,base64,random







HOST =  subprocess.check_output('cat /etc/xray/domain', shell=True).decode("utf-8")
kota =  subprocess.check_output('cat /etc/xray/city', shell=True).decode("utf-8")
ISP =  subprocess.check_output('cat /etc/xray/isp', shell=True).decode("utf-8")
DOMAIN = HOST
quota = '1000'
limit_ip = '2'





def trial_ssh():
    user = "trialX"+str(random.randint(100,1000))
    exp = "1 hour"

    cmd = f'trial-api.sh'
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
          print("Username:", username)
          print("Password:", password)
          data =  {
          "meta": {
            "code": 200,
            "status": "success",
            "ip_address": HOST,
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
            "exp": exp,
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





def trial_vl():
    exp = "1 Hours"
    cmd = f'trial-api-vless.sh'
    try:
        a = subprocess.check_output(cmd, shell=True).decode("utf-8")
        print(a)
    except:
        print("**User Already Exist**")
    else:
        #today = DT.date.today()
        #later = today + DT.timedelta(days=int(exp))
        x = [x.group() for x in re.finditer("vless://(.*)",a)]
        print(x)
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
    "expired": exp,
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


def trial_vm():
    exp = "1 Hours"
    cmd = f'trial-api-vmess.sh'
    try:
        a = subprocess.check_output(cmd, shell=True).decode("utf-8")
    except:
        print("**User Already Exist**")
    else:
        #        today = DT.date.today()
        #        later = today + DT.timedelta(days=int(exp))
        b = [x.group() for x in re.finditer("vmess://(.*)",a)]
        #print(b)
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
    "expired": exp,
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
      "none": b[1].strip("'").replace(" ","")
    }
  }
}

def trial_tr():
    exp = "1 Hours"
    cmd = f'trial-api-trojan.sh'
    try:
        a = subprocess.check_output(cmd, shell=True).decode("utf-8")
    except:
        print("**User Already Exist**")
    else:
        #today = DT.date.today()
        #later = today + DT.timedelta(days=int(exp))
        b = [x.group() for x in re.finditer("trojan://(.*)",a)]
        print(b)
        remarks = re.search("#(.*)",b[0]).group(1)
        domain = re.search("@(.*?):",b[0]).group(1)
        uuid = re.search("trojan://(.*?)@",b[0]).group(1)

        return {
  "meta": {
    "code": 200,
    "status": "success",
    "ip_address": HOST,
    "message": "Create TROJAN-WS Success"

  },
    "data": {
    "hostname": HOST,
    "ISP": ISP,
    "CITY": kota,
    "username": remarks,
    "expired": exp,
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
        
        
        
        
        
        
if __name__ == '__main__':  
    trial_ssh()      
        
 