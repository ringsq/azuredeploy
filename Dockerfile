FROM mcr.microsoft.com/azure-cli
RUN apk add gettext
ADD deploy.sh /bin/
RUN chmod +x /bin/deploy.sh
ENTRYPOINT /bin/deploy.sh