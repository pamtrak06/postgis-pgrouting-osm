FROM starefossen/pgrouting

run apt-get update -y
run apt-get install -y git
run apt-get install -y pkg-config
run apt-get install -y build-essential

# osm2pgrouting Requirements
run apt-get install -y libpq-dev
run apt-get install -y expat
run apt-get install -y libboost-all-dev
run apt-get install -y cmake

# osm2pgsql Requirements
run apt-get install -y libexpat1-dev zlib1g-dev \
  libbz2-dev libgeos-dev libgeos++-dev libproj-dev lua5.2 \
  liblua5.2-dev

# compile osm2pgrouting
run git clone https://github.com/pgRouting/osm2pgrouting.git
run cd osm2pgrouting && cmake -H. -Bbuild && \
    cd build/ && make && make install

# compile osm2pgsql
run git clone git://github.com/openstreetmap/osm2pgsql.git
run cd osm2pgsql && mkdir build && cd build && cmake .. \
    && make && make install

# Setup home environment
env PKG_CONFIG_PATH /root/lib/pkgconfig
env LD_LIBRARY_PATH /root/lib

add bashrc /root/.bashrc


