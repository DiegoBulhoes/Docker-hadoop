FROM ubuntu:20.04

RUN mkdir /var/run/sshd
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

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /home/hadoop/.bashrc
RUN echo "export HADOOP_MAPRED_HOME=/opt/hadoop" >> /home/hadoop/.bashrc
RUN echo "export HADOOP_COMMON_HOME=/opt/hadoop" >> /home/hadoop/.bashrc
RUN echo "export HADOOP_HDFS_HOME=/opt/hadoop" >> /home/hadoop/.bashrc
RUN echo "export HADOOP_YARN_HOME=/opt/hadoop" >> /home/hadoop/.bashrc
RUN echo "export PATH=/bin/hadoop:/bin/hadoop:$PATH" >> /home/hadoop/.bashrc

RUN chown -R hadoop:hadoop /home/hadoop/

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 9870 8088 19888 22 80

CMD    ["/usr/sbin/sshd", "-D"]