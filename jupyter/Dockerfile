#FROM cschranz/gpu-jupyter:latest
FROM cschranz/gpu-jupyter:v1.4_cuda-11.6_ubuntu-20.04


# DeepDetect notebook dependencies
USER root
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update -y && apt-get -y install python3-matplotlib && apt clean
RUN pip install --no-cache-dir librosa tqdm altair appdirs ipywidgets
RUN python3 -m jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN pip install "git+https://github.com/jolibrain/dd_widgets@master#egg=dd_widgets"
RUN pip install "git+https://github.com/jolibrain/deepdetect.git#egg=dd_client&subdirectory=clients/python"
RUN sed -i '/"password"/d' /etc/jupyter/jupyter_notebook_config.json

USER $NB_UID
ADD files/jupyter_server_config.py /etc/jupyter/
