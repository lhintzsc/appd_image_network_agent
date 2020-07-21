FROM openjdk:8-jre-slim
MAINTAINER lhintzsc@cisco.com

# set environment variables
ENV APPD_HOME /opt/appd
ENV NETV_AGENT_HOME ${APPD_HOME}/network_agent
ENV NETV_PORT=3892

# install packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y bash && \
    apt-get install -y gawk && \
    apt-get install -y sed && \
    apt-get install -y grep && \
    apt-get install -y coreutils && \
    apt-get install -y vim-tiny && \
    apt-get install -y iproute2 && \
    apt-get install -y procps && \
    apt-get install -y sysstat && \
    apt-get install -y nmap && \
    apt-get install -y net-tools && \
    apt-get install -y tcpdump && \
    apt-get install -y curl && \
    apt-get install -y sysvinit-utils && \
    apt-get install -y openssh-client && \
    rm -rf /var/lib/apt/lists/*

# install agent and startup script
ADD network_agent ${NETV_AGENT_HOME}
ADD start_network_agent.sh ${NETV_AGENT_HOME}/start_network_agent.sh
RUN chmod 744 ${NETV_AGENT_HOME}/start_network_agent.sh

# Configure and Run AppDynamics Machine Agent
WORKDIR ${NETV_AGENT_HOME}
EXPOSE ${NETV_PORT}
CMD "${NETV_AGENT_HOME}/start_network_agent.sh"
