# Use the official Tomcat image as the base image
FROM tomcat:latest

# Remove the default Tomcat webapps directory
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your web application WAR file to the Tomcat webapps directory
COPY src/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose the port that Tomcat will run on (default is 8080)
EXPOSE 8080

# Start Tomcat when the container runs
CMD ["catalina.sh", "run"]
