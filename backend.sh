MYSQL_PASSWORD=${1}
log_file=/tmp/expense.log

Head() {
  echo -e "\e[35m$2\e[om"
  }

Head " disable the default version"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file

Head " install the nodejs"
dnf install nodejs -y &>>$log_file
cp backend.service /etc/systemd/system/backend.service &>>$log_file

Head " add username"
useradd expense &>>$log_file

Head " remove app folder"
rm -rf /app &>>$log_file

Head " create app"
mkdir /app &>>$log_file
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file


Head " intall npm"
npm install &>>$log_file


systemctl daemon-reload &>>$log_file

Head "  enable backend"
systemctl enable backend &>>$log_file

Head "  restart backend"
systemctl restart backend &>>$log_file

Head " install mysql"
dnf install mysql -y &>>$log_file

mysql -h mysql-dev.tejas1996.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file