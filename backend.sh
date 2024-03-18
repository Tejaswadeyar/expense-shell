MYSQL_PASSWORD=$1
Component=backend
source common.sh

Head "disable the default version"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file
if [ $? -eq 0 ]; then
   echo SUCCESS
  else
   echo FALIURE
   exit 1
fi

Head " install the nodejs"
dnf install nodejs -y &>>$log_file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ $? -eq 0 ]; then
   echo SUCCESS
  else
   echo FALIURE
   exit 1
fi

Head "add username"
useradd expense &>>$log_file
if [ $? -eq 0 ]; then
   echo SUCCESS
  else
   echo FALIURE
   exit 1
fi

App_prereq "/app"

Head "intall npm"
npm install &>>$log_file
if [ $? -eq 0 ]; then
   echo SUCCESS
  else
   echo FALIURE
   exit 1
fi

systemctl daemon-reload &>>$log_file
if [ $? -eq 0 ]; then
   echo SUCCESS
  else
   echo FALIURE
   exit 1
fi

Head "enable backend"
systemctl enable backend &>>$log_file
if [ $? -eq 0 ]; then
   echo SUCCESS
  else
   echo FALIURE
   exit 1
fi

Head "restart backend"
systemctl restart backend &>>$log_file
if [ $? -eq 0 ]; then
   echo SUCCESS
  else
   echo FALIURE
   exit 1
fi

Head "install mysql"
dnf install mysql -y &>>$log_file
if [ $? -eq 0 ]; then
   echo SUCCESS
  else
   echo FALIURE
   exit 1
fi

Head "Load schema"
mysql -h mysql-dev.tejas1996.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file
if [ $? -eq 0 ]; then
   echo SUCCESS
  else
   echo FALIURE
   exit 1
fi