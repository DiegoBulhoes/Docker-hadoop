# Docker-hadoop

Container contendo uma a instalação basica do Hadoop.

## Exemplo

Para executar uma aplicação Hadoop deverá ser criado um diretório no qual será gerado uma pasta de saída, a pasta de saída **não pode existir**.

```shell
./hadoop-3.2.2/bin/hdfs namenode -format
```

Inicialize os serviços:

```shell
./hadoop-3.2.2/sbin/start-dfs.sh
./hadoop-3.2.2/sbin/start-yarn.sh
```

Para executar uma aplicação Hadoop deverá ser criado um diretorio no qual será gerado uma pasta de saída, a pasta de saída **não pode existir**.

```shell
mkdir input
cp hadoop-3.2.2/etc/hadoop/*.xml input
```

Copiar o diretório input para o HDFS

```shell
hadoop dfs -copyFromLocal input /in
```

Execultar o WordCount

```shell
hadoop jar hadoop-3.2.2/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.2.jar wordcount /in output
```

Coletar a saída do HDFS

```shell
hdfs dfs -get output output
cat output/*
```