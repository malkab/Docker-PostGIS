FROM malkab/postgis:holistic_hornet

ENV PASSWORD=aaa
ENV LANG=en_US.UTF-8

# Custom user mapping
ENV POSTGRESUSERID 1005
ENV POSTGRESGROUPID 1005

ADD assets/initdb.sh /
ADD assets/tests.sql /
ADD assets/postgis_test.sql /
