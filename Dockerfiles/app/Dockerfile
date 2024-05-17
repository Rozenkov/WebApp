FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install git maven -y
RUN git clone -b main https://github.com/Rozenkov/WebApp.git
RUN cd WebApp && mvn install

FROM tomcat:8-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE WebApp/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
