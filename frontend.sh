log_file=/tmp/expense.log

Head() {
  echo -e "\e[36m$1\e[0m"
  }


 Head"install nginic"
dnf install nginx -y
echo $?

Head"copy the .conf to defult expense.conf"
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

Head"remove default htlm code"
rm -rf /usr/share/nginx/html/*
echo $?

Head"download Application code"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip
echo $?

cd  /usr/share/nginx/html

Heead"extract the frontend.zip file"
unzip /tmp/frontend.zip
echo $?

Head"start the nginx service"
systemctl enable nginx
systemctl restart nginx
echo $?