FROM ubuntu:zesty
MAINTAINER Tristan Everitt
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install build-essential git

# Fetch imapsync source
RUN git clone git://github.com/imapsync/imapsync.git

# Install dependencies
# As per http://imapsync.lamiral.info/INSTALL.d/INSTALL.Ubuntu.txt
RUN apt-get -y install libauthen-ntlm-perl libclass-load-perl libcrypt-ssleay-perl libdata-uniqid-perl libdigest-hmac-perl libdist-checkconflicts-perl libfile-copy-recursive-perl libio-compress-perl libio-socket-inet6-perl libio-socket-ssl-perl libio-tee-perl libmail-imapclient-perl libmodule-scandeps-perl libnet-ssleay-perl libpar-packer-perl libreadonly-perl libsys-meminfo-perl libterm-readkey-perl libtest-fatal-perl libtest-mock-guard-perl libtest-pod-perl libtest-requires-perl libtest-simple-perl libunicode-string-perl liburi-perl make cpanminus

# Update Perl modules
RUN cpanm "JSON::WebToken"
RUN cpanm "Test::MockObject"
RUN cpanm "Mail::IMAPClient"


# Cleanup
RUN rm -rf /var/lib/apt/lists/*

# Build it
RUN mkdir -p imapsync/dist
RUN cd imapsync && make install

# Define Entrypoint
ENTRYPOINT ["imapsync"]
