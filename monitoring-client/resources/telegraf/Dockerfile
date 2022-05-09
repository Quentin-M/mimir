FROM telegraf:1.22.3
RUN sed -r -i 's/^deb(.*)$/deb\1 contrib non-free/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install --yes zfsutils-linux python3 && \
  rm -rf /var/lib/apt/lists/*
RUN sed -i 's/^#//' /etc/sudoers.d/zfs
ADD ./zpool-stats.py /usr/local/bin/zpool-stats.py
ADD ./znapzend-ztatz.py /usr/local/bin/znapzend-ztatz.py

