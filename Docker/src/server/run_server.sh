#!/bin/bash

# Очистка старых процессо
pkill -f "./server" 
pkill -f "spawn-fcgi" 
nginx -s stop 

# Компиляция сервера
gcc server.c -o server -lfcgi

# Запуск FastCGI сервера
spawn-fcgi -p 8080 ./server > /dev/null 2>&1 &

# Запуск Nginx с нашим конфигом и без вывода ошибок
nginx -g "daemon off;" -e /dev/null