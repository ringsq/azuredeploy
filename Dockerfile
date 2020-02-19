FROM mcr.microsoft.com/azure-cli
ADD deploy.sh /bin/
RUN chmod +x /bin/deploy.sh
ENTRYPOINT /bin/deploy.sh

