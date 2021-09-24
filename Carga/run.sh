#userid -- ORACLE username/password@IP:PUERTO/SID
#control -- control file name
#log -- log file name
#bad -- bad file name
sqlldr system control=carga.ctl log=[BD1]carga.log bad=[BD1]carga.bad
echo " "
echo -e "\e[96m  ENTER PARA CONTINUAR ... \e[0m"
read