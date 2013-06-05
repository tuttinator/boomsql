set -x
set -e
if [ ! -e /home/ubuntu/freetds/lib ]; then
  wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-stable.tgz
  mkdir -p /home/ubuntu/freetds
  tar xvzf freetds-stable.tgz
  cd freetds-0.91
  ./configure --prefix /home/ubuntu/freetds
  make
  make install
fi