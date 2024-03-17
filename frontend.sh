log_file=/tmp/expense.log

Head() {
  echo -e "\e[36m$1\e[0m"
  }


Head "install nginx"
dnf install nginx -y &>>$log_file
echo $?

Head "copy the .conf to defult expense.conf"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

Head "remove default htlm code"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?

Head "download Application code"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
echo $?

cd  /usr/share/nginx/html &>>$log_file

Heead "extract the frontend.zip file"
unzip /tmp/frontend.zip &>>$log_file
echo $?

Head "start the nginx service"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
echo $?