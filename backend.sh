MYSQL_PASSWORD=${1}
log_file=/tmp/expense.log
echo -e "\e[34m disable the default version\e[0m"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file

echo -e "\e[34m install the nodejs\e[0m"
dnf install nodejs -y &>>$log_file
cp backend.service /etc/systemd/system/backend.service &>>$log_file

echo -e "\e[34m add username\e[0m"
useradd expense &>>$log_file

echo -e "\e[34m remove app folder\e[0m"
rm -rf /app &>>$log_file

echo -e "\e[34m create app\e[0m"
mkdir /app &>>$log_file
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file


echo -e "\e[34m intall npm\e[0m"
npm install &>>$log_file


systemctl daemon-reload &>>$log_file

echo -e "\e[34m  enable backend\e[0m"
systemctl enable backend &>>$log_file

echo -e "\e[34m  restart backend\e[0m"
systemctl restart backend &>>$log_file

echo -e "\e[34m install mysql\e[0m"
dnf install mysql -y &>>$log_file

mysql -h mysql-dev.tejas1996.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file