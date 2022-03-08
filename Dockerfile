# syntax=docker/dockerfile:1

FROM amd64/ubuntu:20.04

LABEL version="1.0.0"
LABEL name="PAC Protocol Masternode"
LABEL description="Hosting your own masternode using by docker."
LABEL url="https://pacprotocol.com"
LABEL maintainer="yan.h@pacprotocol.com"

ENV EXT=".tgz"
ENV BINARY_URL="https://github.com/pacprotocol/pacprotocol/releases/download/v0.17.0.4/pacprotocol-v0.17.0.4-lin64.tgz"

ENV HIDE_DIR="/PACProtocolHidden"
ENV WORK_DIR="/PACProtocol"
ENV DATA_PATH="${WORK_DIR}/.pacprotocol"
ENV CONFIG_PATH="${DATA_PATH}/pacprotocol.conf"

RUN mkdir -p ${HIDE_DIR}

# Add pac protocol daemon and client to bin directory
ADD ${BINARY_URL} /tmp/
RUN tar -xvf /tmp/pac*${EXT} -C /tmp/
RUN cp /tmp/pac*/* /usr/local/bin
RUN rm -rf /tmp/pac*

# Update + install needed dependencies
RUN apt-get -y update
RUN apt-get -y install -qq --force-yes pwgen git cron python3-virtualenv virtualenv wget rename systemctl

# Install Sentinel
RUN git clone https://github.com/pacprotocol/sentinel.git ${HIDE_DIR}/sentinel
RUN echo pacprotocol_conf=${CONFIG_PATH} >> ${HIDE_DIR}/sentinel/sentinel.conf
RUN cd ${HIDE_DIR}/sentinel && virtualenv ./venv && ./venv/bin/pip install -r requirements.txt

# Create systemctl service TODO: Remove services because we want to use Docker outside as service.
ADD pac.service /etc/systemd/system/pac.service

# Clear not needed bash scripts and dependencies
RUN apt-get purge --auto-remove -y git rename

# Add command files
ADD ./bin/* /usr/local/bin/
RUN chmod a+x /usr/local/bin/*

# Add cronjobs
ADD crontab /etc/cron.d/crontab
RUN chmod 0600 /etc/cron.d/crontab
RUN touch /var/log/cron.log

# Expose Port for PAC Protocol
EXPOSE 7112:7112 7111:7111

WORKDIR ${WORK_DIR}

# Used for debugging
SHELL ["/bin/bash", "-c"]

CMD ["mn-start"]