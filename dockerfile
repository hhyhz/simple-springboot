#基础镜像为官方centos7
FROM centos:7
MAINTAINER salo

ARG PROJECT_NAME

#暂用本地项目
COPY . /usr/local/${PROJECT_NAME}/

#设置工作目录
WORKDIR /usr/local/

#安装wget,下载安装jdk/maven
RUN yum install -y -q wget \
&& wget -q --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz" \
&& tar xzf jdk-8u141-linux-x64.tar.gz \
&& rm -rf jdk-8u141-linux-x64.tar.gz \
&& wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo \
&& yum -y -q install apache-maven

#配置环境
ENV JAVA_HOME /usr/local/jdk1.8.0_141
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin

#设置工作目录
WORKDIR /usr/local/${PROJECT_NAME}/

CMD mvn spring-boot:run
