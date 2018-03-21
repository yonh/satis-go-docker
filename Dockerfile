from ubuntu:16.04

RUN mkdir /opt/satis-go/
RUN apt update && apt-get install -y php7.0-cli php7.0-xml php7.0-mbstring php7.0-zip git wget
run wget -qO- https://github.com/benschw/satis-go/releases/download/0.1.1/satis-go-`uname`-`uname -m`.gz | gunzip > /opt/satis-go/satis-go && \
	wget -qO- https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#run composer create-project composer/satis /opt/satis --stability=dev --keep-vcs && \
run composer create-project composer/satis /opt/satis --no-dev && \
    ln -s /opt/satis/bin/satis /usr/local/bin/satis && \
    chmod +x /opt/satis-go/satis-go && chmod +x /opt/satis/bin/satis
run wget -qO-  https://github.com/benschw/satis-admin/releases/download/0.1.1/admin-ui.tar.gz | tar xzv -C /opt/satis-go/


ADD config.yaml /opt/satis-go/

expose 80

cmd ["/opt/satis-go/satis-go"]
