ARG ARCH="amd64"
ARG OS="linux"
FROM        quay.io/prometheus/busybox:latest
LABEL maintainer="The ABCDEvOps Authors <support@abcdevops.com>"

ARG ARCH="amd64"
ARG OS="linux"
COPY .build/${OS}-${ARCH}/aws_billing_exporter /bin/aws_billing_exporter

ENTRYPOINT ["/bin/aws_billing_exporter"]
EXPOSE     9614
