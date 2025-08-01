#использем официальный образ nginx последней версии
FROM nginx:latest

#создаем внутри контейнера папку с последующим копированием всех файлов
WORKDIR /server

#libfcgi-dev - библиотеки для FastCGI, spawn-fcgi - утилита для запуска FastCGI процессов, 
#procps - утилиты для работы с процессами (например, ps), удаляю кэш для уменьш разм образа
RUN apt-get update && \
    apt-get install -y gcc libfcgi-dev spawn-fcgi procps && \ 
    rm -rf /var/lib/apt/lists/*

#копирую файлы в контейнер в server - точку тк прописали выше с какой директорией работаем 
COPY server/server.c .

#заменяю стандартный nginx на свой 
COPY server/nginx/nginx.conf /etc/nginx/nginx.conf 
COPY server/run_server.sh .

#делаю скрипт исполняемым / 
RUN chmod +x run_server.sh 

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

RUN adduser --disabled-password --gecos '' appuser && \
chown -R appuser:appuser /etc/nginx/ && \
chown -R appuser:appuser /server/ && \
chown -R appuser:appuser /var/log/nginx/

RUN mkdir -p /run /var/cache/nginx /var/log/nginx && \
    chown -R appuser:appuser /run /var/cache/nginx /var/log/nginx /etc/nginx

USER appuser

CMD ["sh", "run_server.sh"]