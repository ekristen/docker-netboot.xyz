FROM alpine:3.6

ENTRYPOINT ["in.tftpd"]
CMD ["-L", "--verbose", "-u", "root", "--secure", "-m", "/config/rules.map", "/tftpboot"]
EXPOSE 69/udp

RUN apk --update add --no-cache tftp-hpa && mkdir -p /tftpboot

ADD https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe /tftpboot/
ADD https://boot.netboot.xyz/ipxe/netboot.xyz-undionly.kpxe /tftpboot/
ADD https://boot.netboot.xyz/ipxe/netboot.xyz.efi /tftpboot/

RUN find /tftpboot -type f -exec chmod 0444 {} +

COPY rules.map /config/rules.map