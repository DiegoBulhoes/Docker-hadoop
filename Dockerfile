FROM ubuntu:20.04

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y openjdk-8-jdk htop ssh git curl openssh-server && \
    rm -rf /var/lib/apt/list/*

RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh

RUN groupadd --gid 1000 hadoop \
    && useradd --uid 1000 --gid hadoop --shell /bin/bash --create-home hadoop
RUN echo "hadoop:hadoop" | chpasswd
RUN mkdir -p /home/hadoop/.ssh && ssh-keygen -q  -f /home/hadoop/.ssh/id_rsa -N """"
RUN cp /home/hadoop/.ssh/id_rsa.pub /home/hadoop/.ssh/authorized_keys

CMD    ["/usr/sbin/sshd", "-D"]