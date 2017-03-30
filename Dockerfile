# Adapted from https://raw.githubusercontent.com/sequenceiq/docker-liquibase
FROM java

MAINTAINER ronalddddd

# download liquibase
# ADD https://github.com/liquibase/liquibase/releases/download/liquibase-parent-3.5.3/liquibase-3.5.3-bin.tar.gz /tmp/liquibase-3.5.3-bin.tar.gz
#COPY lib/liquibase-3.5.3-bin.tar.gz /tmp/liquibase-3.5.3-bin.tar.gz
# Using 3.5.0 because later versions introduces a bug that causes addAutoIncrement changes to fail: https://liquibase.jira.com/browse/CORE-2978?page=com.atlassian.streams.streams-jira-plugin%3Aactivity-stream-issue-tab
COPY lib/liquibase-3.5.0-bin.tar.gz /tmp/liquibase-3.5.3-bin.tar.gz

# Create a directory for liquibase
RUN mkdir /opt/liquibase

# Unpack the distribution
RUN tar -xzf /tmp/liquibase-3.5.3-bin.tar.gz -C /opt/liquibase
RUN chmod +x /opt/liquibase/liquibase

# Symlink to liquibase to be on the path
RUN ln -s /opt/liquibase/liquibase /usr/local/bin/

# Get the postgres JDBC driver from http://jdbc.postgresql.org/download.html
# ADD https://jdbc.postgresql.org/download/postgresql-42.0.0.jar /opt/jdbc_drivers/
COPY lib/postgresql-42.0.0.jar /opt/jdbc_drivers/

RUN ln -s /opt/jdbc_drivers/postgresql-42.0.0.jar /usr/local/bin/

# Add command scripts
ADD scripts /scripts
RUN chmod -R +x /scripts

# Symlink the scripts
RUN ln -s /scripts/* /usr/local/bin/

#VOLUME ["/changelogs"]

WORKDIR /

#ENTRYPOINT ["/bin/bash", "-c"]

ONBUILD ADD ./changelogs /changelogs
