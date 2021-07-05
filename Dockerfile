FROM hashicorp/terraform

RUN apk --no-cache add jq

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
