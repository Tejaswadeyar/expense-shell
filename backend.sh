echo -e "\e[34m disable the default version\e[om"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[34m install the nodejs\e[om"
dnf install nodejs -y
cp backend.service /etc/systemd/system/backend.service

echo -e "\e[34m add username\e[om"
useradd expense

echo -e "\e[34m remove app folder\e[om"
rm -rf /app

echo -e "\e[34m create app\e[om"
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip


echo -e "\e[34m intall npm\e[om"
npm install


systemctl daemon-reload

echo -e "\e[34m  enable backend\e[om"
systemctl enable backend

echo -e "\e[34m  restart backend\e[om"
systemctl restart backend

echo -e "\e[34m install mysql\e[om"
dnf install mysql -y

mysql -h mysql-dev.tejas1996.online -uroot -pExpenseApp@1 < /app/schema/backend.sql