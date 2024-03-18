log_file=/tmp/expense.log

Head() {
  echo -e "\e[36m$1\e[0m"
  }


  App_prereq() {
    DIR=$1
   Head "remove app folder"
   rm -rf $1 &>>$log_file
   Stat $?

   Head "create application directory"
   mkdir $1 &>>$log_file
   Stat $?

   Head "Download the application content"
   curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
   Stat $?

   cd $1

   Head "Extract the application content"
   unzip /tmp/${component}.zip &>>$log_file
   Stat $?
  }


Stat() {
  if [ $1 -eq 0 ]; then
       echo SUCCESS
      else
       echo FALIURE
       exit 1
    fi
}
