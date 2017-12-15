FROM bitwalker/alpine-elixir:1.5.0

LABEL version="0.0.1"

ENV MIX_ENV=local
ENV AWS_ACCESS_KEY_ID=AKIAJHBHPGA3VDBJTBNQ
ENV AWS_SECRET_ACCESS_KEY=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
ENV S3_URL=s3_niq_careers
ENV S3_PORT=10001
ENV BUCKET_NAME=niq-test
ENV AWS_REGION=us-east-1
ENV SMTP_USERNAME=AKIAJZK7T4SSH6G7CGVA
ENV SMTP_PASSWORD=ApXegRkZdHH467JBUzettKDMV3oT1+6mV2+zEVS39ndX
ENV SES_SERVER=email-smtp.us-east-1.amazonaws.com
ENV SES_PORT=587
ENV SYSTEM_DEFAULT_EMAIL=xpto@useniq.com

RUN apk update
RUN apk --update upgrade
RUN apk add --update build-base bash curl

RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force

WORKDIR /opt/app
