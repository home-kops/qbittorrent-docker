FROM qbittorrentofficial/qbittorrent-nox:5.0.4-1

ENV XDG_CONFIG_HOME="/config"

RUN apk update && apk upgrade

# Install jackett
RUN cd /opt && \
    f=Jackett.Binaries.LinuxMuslAMDx64.tar.gz && \
    wget -c https://github.com/Jackett/Jackett/releases/latest/download/"$f" && \
    tar -xzf "$f" && rm -f "$f" && \
    cd Jackett* && \
    chown qbtUser:qbtUser -R "/opt/Jackett"

# Install OpenVPN
RUN apk add --no-cache openvpn && \
    openvpn --version

# Install unzip
RUN apk add --no-cache unzip

RUN cd /etc/openvpn && \
    wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip && \
    unzip ovpn.zip && \
    rm ovpn.zip

# Install ssmtp and mailx
RUN apk add ssmtp mailx

# Install clamav
RUN apk add --no-cache clamav clamav-daemon

RUN addgroup qbtUser clamav

# Copy the scan_file script
COPY files/scan_file /scan_file
RUN chmod +x /scan_file

# Copy the entrypoint script
COPY files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
