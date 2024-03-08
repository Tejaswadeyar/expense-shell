echo -e "\e[34m disable the default version\e[0m"
dnf module disable nodejs -y &>>/tmp/expense.log
dnf module enable nodejs:18 -y &>>/tmp/expense.log

echo -e "\e[34m install the nodejs\e[0m"
dnf install nodejs -y &>>/tmp/expense.log
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log

echo -e "\e[34m add username\e[0m"
useradd expense &>>/tmp/expense.log

echo -e "\e[34m remove app folder\e[0m"
rm -rf /app &>>/tmp/expense.log

echo -e "\e[34m create app\e[0m"
mkdir /app &>>/tmp/expense.log
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>/tmp/expense.log
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log


echo -e "\e[34m intall npm\e[0m"
npm install &>>/tmp/expense.log


systemctl daemon-reload &>>/tmp/expense.log

echo -e "\e[34m  enable backend\e[0m"
systemctl enable backend &>>/tmp/expense.log

echo -e "\e[34m  restart backend\e[0m"
systemctl restart backend &>>/tmp/expense.log

echo -e "\e[34m install mysql\e[0m"
dnf install mysql -y &>>/tmp/expense.log

mysql -h mysql-dev.tejas1996.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log