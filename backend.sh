echo disable the default version
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo install the nodejs
dnf install nodejs -y
cp backend.service /etc/systemd/system/backend.service

echo add username
useradd expense

echo remove app folder
rm -rf /app

echo create app
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip


echo intall npm
npm install


systemctl daemon-reload

echo enable backend
systemctl enable backend

echo restart backend
systemctl restart backend

echo install mysq l
dnf install mysql -y

mysql -h mysql-dev.tejas1996.online -uroot -pExpenseApp@1 < /app/schema/backend.sql