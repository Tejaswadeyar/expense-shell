echo -e "\e[34m disable the default version\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[34m install the nodejs\e[0m"
dnf install nodejs -y
cp backend.service /etc/systemd/system/backend.service

echo -e "\e[34m add username\e[0m"
useradd expense

echo -e "\e[34m remove app folder\e[0m"
rm -rf /app

echo -e "\e[34m create app\e[0m"
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip


echo -e "\e[34m intall npm\e[0m"
npm install


systemctl daemon-reload

echo -e "\e[34m  enable backend\e[0m"
systemctl enable backend

echo -e "\e[34m  restart backend\e[0m"
systemctl restart backend

echo -e "\e[34m install mysql\e[0m"
dnf install mysql -y

mysql -h mysql-dev.tejas1996.online -uroot -pExpenseApp@1 < /app/schema/backend.sql