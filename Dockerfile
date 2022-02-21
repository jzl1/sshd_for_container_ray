FROM debian
RUN apt update \
  && apt install ssh wget tar -y \
  && mkdir /run/sshd \
  && mkdir /etc/frp \
  && wget -O /agent.tar.gz "https://github.com/naiba/nezha/releases/download/v0.12.3/nezha-agent_linux_amd64.tar.gz" \
  && wget -O /xray.zip "https://github.com/XTLS/Xray-core/releases/download/v1.5.3/Xray-linux-64.zip" \
  && wget -O /frpc "https://raw.githubusercontent.com/jzl1/sshd_for_container/main/frpc" \
  && wget -O /start.sh "https://raw.githubusercontent.com/jzl1/sshd_for_container/main/start.sh" \
  && echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config \
  && unzip -f xray.zip \
  && tar xvf /agent.tar.gz \
  && rm -rf /agent.tar.gz LICENSE README.md xray.zip \
  && chmod 755 /nezha-agent \
  && chmod 755 /frpc \
  && chmod 755 /start.sh 
CMD /start.sh
