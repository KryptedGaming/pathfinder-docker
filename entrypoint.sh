#!/bin/bash
function replace_setting() {
    sed -i -E "s/$1/$2/g" $3
}
echo "Replacing settings"
replace_setting "^SERVER\s*=\s*.*$" "SERVER = ${SERVER}" "/var/www/pathfinder/app/environment.ini"
replace_setting "^DB_PF_DNS\s*=\s*.*$" "DB_PF_DNS                         =   mysql:host=db;port=3306;" "/var/www/pathfinder/app/environment.ini"
replace_setting "^DB_UNIVERSE_DNS\s*=\s*.*$" "DB_UNIVERSE_DNS                         =   mysql:host=db;port=3306;" "/var/www/pathfinder/app/environment.ini"
replace_setting "^URL\s*=\s*.*$" "URL                         =   ${SCHEME}${URL}" "/var/www/pathfinder/app/environment.ini"
replace_setting "DB_PF_PASS\s*=\s*.*" "DB_PF_PASS                  =   ${MYSQL_PASSWORD}" "/var/www/pathfinder/app/environment.ini"
replace_setting "DB_PF_USER\s*=\s*.*" "DB_PF_USER                  =   ${MYSQL_USER}" "/var/www/pathfinder/app/environment.ini"
replace_setting "DB_PF_NAME\s*=\s*.*" "DB_PF_NAME           =   pathfinder" "/var/www/pathfinder/app/environment.ini"
replace_setting "DB_UNIVERSE_NAME\s*=\s*.*" "DB_UNIVERSE_NAME           =   eve_universe" "/var/www/pathfinder/app/environment.ini"
replace_setting "DB_UNIVERSE_PASS\s*=\s*.*" "DB_UNIVERSE_PASS            =   ${MYSQL_PASSWORD}" "/var/www/pathfinder/app/environment.ini"
replace_setting "DB_UNIVERSE_USER\s*=\s*.*" "DB_UNIVERSE_USER            =   ${MYSQL_USER}" "/var/www/pathfinder/app/environment.ini"
replace_setting "CCP_SSO_CLIENT_ID\s*=\s*.*" "CCP_SSO_CLIENT_ID           =   ${CCP_SSO_CLIENT_ID}" "/var/www/pathfinder/app/environment.ini"
replace_setting "CCP_SSO_SECRET_KEY\s*=\s*.*" "CCP_SSO_SECRET_KEY          =   ${CCP_SSO_SECRET_KEY}" "/var/www/pathfinder/app/environment.ini"
replace_setting "CHARACTER\s*=\s*.*" "CHARACTER          =   ${CHARACTER}" "/var/www/pathfinder/app/pathfinder.ini"
replace_setting "CORPORATION\s*=\s*.*" "CORPORATION          =   ${CORPORATION}" "/var/www/pathfinder/app/pathfinder.ini"
replace_setting "ALLIANCE\s*=\s*.*" "ALLIANCE          =   ${ALLIANCE}" "/var/www/pathfinder/app/pathfinder.ini"
replace_setting "domain.com" "${URL}" "/etc/nginx/sites-available/default"
replace_setting "web\s*=\s*.*" "web     = ${CronWebUI}" "/var/www/pathfinder/app/cron.ini"
if [ "${SETUP}" != "True" ]; then
 replace_setting "^GET @setup.*$" "" "/var/www/pathfinder/app/routes.ini"
fi

if ["${UseRedis}" != "False"]; then
 replace_setting "CACHE\s*=\s*.*" "CACHE           =   redis=localhost:6379:1" "/var/www/pathfinder/app/config.ini"
fi

if [ "${UseWebSockets}" == "True" ]; then
 replace_setting ";SOCKET_HOST" "SOCKET_HOST" "/var/www/pathfinder/app/environment.ini"
 replace_setting ";SOCKET_PORT" "SOCKET_PORT" "/var/www/pathfinder/app/environment.ini"
fi

# SMTP
# if [ "${CUSTOM_SMTP}" == "True" ]; then
#  replace_setting ";SOCKET_HOST" "SOCKET_HOST" "/var/www/pathfinder/app/environment.ini"
#  replace_setting ";SOCKET_PORT" "SOCKET_PORT" "/var/www/pathfinder/app/environment.ini"
# fi

echo "[PATHFINDER]" >> /var/www/pathfinder/conf/pathfinder.ini
echo "NAME                        =   ${NAME}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "" >> /var/www/pathfinder/conf/pathfinder.ini
echo "[PATHFINDER.MAP.PRIVATE]" >> /var/www/pathfinder/conf/pathfinder.ini
echo "LIFETIME                         =   ${PrivateLIFETIME}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "MAX_COUNT                       =   ${PrivateMAX_COUNT}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "MAX_SHARED                        =   ${PrivateMAX_SHARED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "MAX_SYSTEMS                        =   ${PrivateMAX_SYSTEMS}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "LOG_ACTIVITY_ENABLED                        =   ${PrivateLOG_ACTIVITY_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "LOG_HISTORY_ENABLED                        =   ${PrivateLOG_HISTORY_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "SEND_HISTORY_SLACK_ENABLED                        =   ${PrivateSEND_HISTORY_SLACK_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "SEND_RALLY_SLACK_ENABLED                        =   ${PrivateSEND_RALLY_SLACK_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "SEND_HISTORY_DISCORD_ENABLED                        =   ${PrivateSEND_HISTORY_DISCORD_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "SEND_RALLY_DISCORD_ENABLED                        =   ${PrivateSEND_RALLY_DISCORD_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "SEND_RALLY_Mail_ENABLED                        =   ${PrivateSEND_RALLY_Mail_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "[PATHFINDER.MAP.CORPORATION]" >> /var/www/pathfinder/conf/pathfinder.ini
echo "LIFETIME                        =   ${CorpLIFETIME}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "MAX_COUNT                       =   ${CorpMAX_COUNT}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "MAX_SHARED                      =   ${CorpMAX_SHARED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "MAX_SYSTEMS                     =   ${CorpMAX_SYSTEMS}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "LOG_ACTIVITY_ENABLED            =   ${CorpLOG_ACTIVITY_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "LOG_HISTORY_ENABLED             =   ${CorpLOG_HISTORY_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "SEND_HISTORY_SLACK_ENABLED      =   ${CorpSEND_HISTORY_SLACK_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "SEND_RALLY_SLACK_ENABLED        =   ${CorpSEND_RALLY_SLACK_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "SEND_HISTORY_DISCORD_ENABLED    =   ${CorpSEND_HISTORY_DISCORD_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "SEND_RALLY_DISCORD_ENABLED      =   ${CorpSEND_RALLY_DISCORD_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini
echo "SEND_RALLY_Mail_ENABLED         =   ${CorpSEND_RALLY_Mail_ENABLED}" >> /var/www/pathfinder/conf/pathfinder.ini


if [ "${AddAdminChar}" != "False" ]; then
 echo "[PATHFINDER.ROLES]" >> /var/www/pathfinder/conf/pathfinder.ini
 echo "CHARACTER.0.ID = ${AdminCharID}" >> /var/www/pathfinder/conf/pathfinder.ini
 echo "CHARACTER.0.ROLE = SUPER" >> /var/www/pathfinder/conf/pathfinder.ini
fi

echo "Starting Services"
crontab /home/default_crontab
service cron start
service php7.2-fpm start
service redis-server start
service pathfinder-websocket start
nginx -g "daemon off;"