# Install packages

apt-get update

apt-get install -y \
    locales \
    python3 \
    libpython3.6 \
    libxml2 \
    libjson-c3

rm -rf /var/lib/apt/lists/*

# Make Python3 default
ln -s /usr/bin/python3 /usr/bin/python

# Setup user

# Creation of postgres user and group
groupadd -g 1500 postgres
useradd --shell /bin/bash --uid 1500 --gid 1500 --home /data/ postgres


# Creation of data folder
mkdir -p /data/
chmod 0700 /data/
chown postgres:postgres /data/


# Clean up
rm -Rf /usr/local/src

chmod 755 /usr/local/bin/run.sh

chmod 777 /usr/local/bin/pg_hba_conf

chmod 777 /usr/local/bin/postgresql_conf

ldconfig
