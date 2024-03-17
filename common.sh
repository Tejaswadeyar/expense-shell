log_file=/tmp/expense.log

Head() {
  echo -e "\e[36m$1\e[0m"
  }


  App_prereq() {
    DIR=$1
   Head "remove app folder"
   rm -rf $1 &>>$log_file
   echo $?

   Head "create application directory"
   mkdir $1 &>>$log_file
   echo $?

   Head "Download the application content"
   curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
   echo $?

   cd $1

   Head "Extract the application content"
   unzip /tmp/${component}.zip &>>$log_file
   echo $?

  }