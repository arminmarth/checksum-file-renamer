FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    sha1sum \
    sha256sum \
    sha512sum \
    md5sum \
    exiftool

COPY rename_files.sh /rename_files.sh

ENTRYPOINT ["/rename_files.sh"]

CMD ["-h"]
