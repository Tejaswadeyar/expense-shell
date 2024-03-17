MYSQL_PASSWORD=$1
Component=backend
source common.sh

Head "disable the default version"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file
echo $?

Head " install the nodejs"
dnf install nodejs -y &>>$log_file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

Head "add username"
useradd expense &>>$log_file
echo $?

App_prereq "/app"

Head "intall npm"
npm install &>>$log_file
echo $?

systemctl daemon-reload &>>$log_file
echo $?

Head "enable backend"
systemctl enable backend &>>$log_file
echo $?

Head "restart backend"
systemctl restart backend &>>$log_file
echo $?

Head "install mysql"
dnf install mysql -y &>>$log_file
echo $?

Head "Load schema"
mysql -h mysql-dev.tejas1996.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file
echo $?