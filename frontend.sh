component=frontend
source common.sh


Head "install nginx"
dnf install nginx -y &>>$log_file
Stat $?

Head "copy the .conf to defult expense.conf"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
Stat $?

App_prereq "/usr/share/nginx/html"

Head "start the nginx service"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
Stat $?