from fastapi import *
import trial
import create
import uvicorn


from fastapi import FastAPI, Request
from pydantic import BaseModel
import uvicorn
import create
import subprocess



from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from pydantic import BaseModel
import jwt
from jwt.exceptions import DecodeError


# Secret key untuk JWT (sebaiknya simpan dengan aman, jangan letakkan di sini)
SECRET_KEY = "madewgn"
ALGORITHM = "HS256"

# Model untuk JWT token
class Token(BaseModel):
    access_token: str
    token_type: str

# Mekanisme otentikasi
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# Fungsi untuk memverifikasi token JWT
def verify_token(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        # Di sini Anda dapat menambahkan logika untuk memeriksa dan mengizinkan akses berdasarkan payload token yang diterima
        return payload
    except DecodeError:
        raise HTTPException(status_code=401, detail="Token tidak valid")



app = FastAPI()

# Model Pydantic untuk data yang diharapkan
class UserData(BaseModel):
    username: str
    rebug: str
    expired: int

class sssh(BaseModel):
    username: str
    pw: str
    expired: int


class PerPanjang(BaseModel):
    username: str
    expired: int


@app.get("/protected")
async def protected_route(token: str = Depends(verify_token)):
    return {"pesan": "Akses berhasil!"}

@app.post("/vps/renewtrojan")
async def renew_tr(request: Request, user_data: PerPanjang):
    return create.trojan(user_data.username, user_data.expired)
@app.post("/vps/renewvmess")
async def renew_vm(request: Request, user_data: PerPanjang):
    return create.trojan(user_data.username, user_data.expired)


@app.post("/vps/renewvless")
async def renew_vl(request: Request, user_data: PerPanjang):
    return create.trojan(user_data.username, user_data.expired)



@app.get("/update")
async def up():
    subprocess.check_output('cd /etc/api && git pull', shell=True).decode("utf-8")
    #    subprocess.check_output('systemctl restart wgnapi', shell=True).decode("utf-8")
    return "berhasil di update"


@app.post("/vps/trialvlessws")
async def index():
    return trial.trial_vl()


@app.post("/vps/trialtrojanws")
async def trialtr():
    return trial.trial_tr()

    

@app.post("/vps/trialvmessws")
async def trialws():
    return trial.trial_vm()



@app.post("/vps/trialsshvpn")
async def trialssh():
    return trial.trial_ssh()



# create






@app.post("/vps/sshvpn")
async def sshv(request: Request, data: sssh):
    return create.ssh(data.username,data.pw,data.expired)


@app.post("/vps/trojanws")
async def tr(request: Request, user_data: UserData):
    return create.trojan(user_data.username, user_data.expired)

@app.post("/vps/vmessws")
async def vm(request: Request, user_data: UserData):
    return create.vmess(user_data.username, user_data.expired)

@app.post("/vps/vlessws")
async def vl(request: Request, user_data: UserData):
    return create.vless(user_data.username, user_data.expired)



if __name__ == "__main__":
   uvicorn.run("main:app", host="0.0.0.0", port=9000, reload=True)

