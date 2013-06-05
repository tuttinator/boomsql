set -x
set -e
if [ ! -e ~/freetds/lib ]; then
  wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-0.92.79.tar.gz
  mkdir -p ~/freetds
  tar xvzf freetds-0.92.79.tar.gz
  cd freetds-0.92.79
  ./configure --prefix ~/freetds
  make
  make install
fi