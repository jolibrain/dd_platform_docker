FROM filebrowser/filebrowser:v2.9.0-debian
RUN mkdir /data
RUN chmod 777 /data
ADD branding /branding
RUN chmod -R 755 /branding

RUN /filebrowser -d /data/db -c /dev/null config init \
    --address "" \
    --auth.method noauth \
    --port 8888 \
    --baseurl "/filebrowser" \
    --root "/srv/data" \
    --branding.name "DeepDetect" \
    --branding.files "/branding" \
    --branding.disableExternal

RUN /filebrowser -d /data/db -c /dev/null users add deepdetect deepdetect \
    --lockPassword \
    --perm.admin=false  \
    --perm.create  \
    --perm.delete  \
    --perm.download  \
    --perm.execute=false  \
    --perm.modify=false  \
    --perm.rename  \
    --perm.share=false

RUN /filebrowser -d /data/db -c /dev/null users ls
RUN /filebrowser -d /data/db -c /dev/null config cat
RUN chmod 777 /data/db
ENTRYPOINT ["/filebrowser", "-d", "/data/db", "-c", "/dev/null", "--disable-exec", "--noauth", "--username", "deepdetect"]
