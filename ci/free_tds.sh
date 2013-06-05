set -x
set -e
if [ ! -e /home/ubuntu/freetds/lib ]; then
  wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-0.92.79.tar.gz
  mkdir -p /home/ubuntu/freetds
  tar xvzf freetds-0.92.79.tar.gz
  cd freetds-0.92
  ./configure --prefix /home/ubuntu/freetds
  make
  make install
fi