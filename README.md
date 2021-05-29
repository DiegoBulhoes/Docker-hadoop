# Docker-hadoop

Container contendo uma a instalação basica do Hadoop.

## Exemplo

Para executar uma aplicação Hadoop deverá ser criado um diretório no qual será gerado uma pasta de saída, a pasta de saída **não pode existir**.

```shell
/opt/hadoop/bin/hdfs namenode -format
```

Inicialize os serviços:

```shell
/opt/hadoop/sbin/start-all.sh
```

Para executar uma aplicação wordcount Hadoop deverá ser criado um diretorio no qual será gerado uma pasta de saída, a pasta de saída **não pode existir**.

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
/opt/hadoop/bin/hadoop jar hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.2.jar wordcount /in output
```

Coletar a saída do HDFS

```shell
/opt/hadoop/bin/hdfs dfs -get output output
cat output/*
```