import os
os.umask(0o002)

c.NotebookApp.base_url = '/code'
c.NotebookApp.allow_origin = '*'
c.NotebookApp.token = ''
