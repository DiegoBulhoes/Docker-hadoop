# Docker-hadoop

[![Docker](https://github.com/DiegoBulhoes/Docker-hadoop/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/DiegoBulhoes/Docker-hadoop/actions/workflows/docker-publish.yml)

Container contendo uma a instalação basica do Hadoop.

## Exemplo

Para utilizar a imagem já criada será necessario se autenticar na plataforma Github. Segue o [link da documentação](https://docs.github.com/pt/packages/working-with-a-github-packages-registry/working-with-the-docker-registry#authenticating-with-a-personal-access-token)

Após a autenticação será necessario construir o container, para facilitar foi criado o arquivo [docker-compose.yml](https://github.com/DiegoBulhoes/Docker-hadoop/blob/main/docker-compose.yml)

```shell
docker-compose up -d  --build  
```

Os passos seguintes será necessario estar dentro do container:

```shell
docker exec -ti master su hadoop
```

Crie um hdfs

```shell
/opt/hadoop/bin/hdfs namenode -format
```

Inicialize os serviços

```shell
/opt/hadoop/sbin/start-all.sh
```

Para executar uma aplicação wordcount Hadoop deverá ser criado um diretorio no qual será gerado uma pasta de input:

```shell
mkdir input
cp /opt/hadoop/etc/hadoop/*.xml input
```

Copiar o diretório input para o HDFS

```shell
/opt/hadoop/bin/hadoop dfs -copyFromLocal input /in
```

Execultar o WordCount

```shell
/opt/hadoop/bin/hadoop jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.2.jar wordcount /in output
```

Coletar a saída do HDFS

```shell
/opt/hadoop/bin/hdfs dfs -get output output
cat output/*
```
