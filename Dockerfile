FROM websphere-liberty:microProfile

# Install opentracing usr feature
RUN wget -t 10 -x -nd -P /opt/ibm/wlp/usr https://repo1.maven.org/maven2/net/wasdev/wlp/tracer/liberty-opentracing-zipkintracer/1.0/liberty-opentracing-zipkintracer-1.0-sample.zip && cd /opt/ibm/wlp/usr && unzip liberty-opentracing-zipkintracer-1.0-sample.zip && rm liberty-opentracing-zipkintracer-1.0-sample.zip

COPY server.xml /config/server.xml

# Don't fail on rc 22 feature already installed
RUN installUtility install --acceptLicense defaultServer || if [ $? -ne 22 ]; then exit $?; fi

COPY jvm.options /config/jvm.options

COPY target/acmeair-customerservice-java-2.0.0-SNAPSHOT.war /config/apps/

