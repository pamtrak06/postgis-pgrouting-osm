FROM starefossen/pgrouting

LABEL maintainer="pamtrak06@gmail.com" \
      description="osm2pgrouting + osm2pgsql"

RUN apt-get update -y && \
    apt-get install -y git pkg-config build-essential

# osm2pgrouting Requirements
RUN apt-get install -y libpq-dev expat libboost-all-dev cmake

# osm2pgsql Requirements
RUN apt-get install -y libexpat1-dev zlib1g-dev \
  libbz2-dev libgeos-dev libgeos++-dev libproj-dev lua5.2 \
  liblua5.2-dev

# compile osm2pgrouting
ENV OSM_2_PGROUTING_VERSION=2.3.3
RUN git clone https://github.com/pgRouting/osm2pgrouting.git
RUN cd osm2pgrouting && \
    git fetch --all && git checkout $OSM_2_PGROUTING_VERSION && \
    cmake -H. -Bbuild && \
    cd build/ && make && make install

# compile osm2pgsql
ENV OSM_2_PGRSQL_VERSION=0.94
RUN git clone git://github.com/openstreetmap/osm2pgsql.git && \
    cd osm2pgsql && \
    git fetch --all && git checkout $OSM_2_PGRSQL_VERSION && \
    mkdir build && cd build && cmake .. && \
    make && make install

# Setup home environment
env PKG_CONFIG_PATH /root/lib/pkgconfig
env LD_LIBRARY_PATH /root/lib

add bashrc /root/.bashrc


