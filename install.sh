apt install tmux -y
git clone https://github.com/madewgn/api /etc/api
pip3 install -U pip
pip3 install fastapi uvicorn pytz
cat > /etc/systemd/system/wgnapi.service << END
[Unit]
Description=Simple api - @madewgn
After=network.target

[Service]
WorkingDirectory=/etc/api
ExecStart=python3 main.py
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start wgnapi
systemctl enable wgnapi
systemctl restart wgnapi




# restart api
cd /etc/
wget https://sc.madewgn.my.id/res-api.sh
cat > /etc/systemd/system/res-api.service << END
[Unit]
Description=auto restart api - @madewgn
After=network.target

[Service]
WorkingDirectory=/etc/
ExecStart=bash res-api.sh
Restart=always

[Install]
WantedBy=multi-user.target
END



systemctl start res-api
systemctl enable res-api
systemctl restart res-api




