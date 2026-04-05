dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -qy module disable postgresql
dnf install -y postgresql16-server postgresql16
/usr/pgsql-16/bin/postgresql-16-setup initdb
sed -i "s/^#\?listen_addresses.*/listen_addresses = '*'/" /var/lib/pgsql/16/data/postgresql.conf

FILE="/var/lib/pgsql/16/data/pg_hba.conf"

sed -i "s/^local[[:space:]]\+all[[:space:]]\+all[[:space:]]\+peer/local   all             all                                     trust/" "$FILE"

grep -q "^host[[:space:]]\+all[[:space:]]\+all[[:space:]]\+0.0.0.0/0[[:space:]]\+scram-sha-256" "$FILE" || \
echo "host    all    all    0.0.0.0/0    scram-sha-256" >> "$FILE"