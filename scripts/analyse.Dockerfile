FROM alpine
RUN apk add --update jq && rm -rf /var/cache/apk/*
COPY analyse.sh /analyse.sh
RUN chmod +x /analyse.sh
CMD ["/analyse.sh"]