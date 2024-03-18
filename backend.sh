MYSQL_PASSWORD=$1
Component=backend
source common.sh

Head "disable the default version"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file

Stat $?


Head " install the nodejs"
dnf install nodejs -y &>>$log_file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
Stat $?

Head "add username"
id expense &>>$log_file
if [ $? -nq 0 ]; then
  useradd expense &>>$log_file
fi
Stat $?

App_prereq "/app"

Head "intall npm"
npm install &>>$log_file
Stat $?

systemctl daemon-reload &>>$log_file
Stat $?

Head "enable backend"
systemctl enable backend &>>$log_file
Stat $?

Head "restart backend"
systemctl restart backend &>>$log_file
Stat $?

Head "install mysql"
dnf install mysql -y &>>$log_file
Stat $?

Head "Load schema"
mysql -h mysql-dev.tejas1996.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file
Stat $?