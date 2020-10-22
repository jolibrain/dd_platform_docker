FROM cschranz/gpu-jupyter:latest


# DeepDetect notebook dependencies
USER root
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update -y && apt-get -y install python3-matplotlib && apt clean
RUN pip install --no-cache-dir librosa tqdm altair appdirs ipywidgets
RUN python3 -m jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN pip install git+https://github.com/jolibrain/dd_widgets
RUN pip install git+https://github.com/deepdetect.git#egg=dd_client&subdirectory=clients/python
RUN sed -i '/"password"/d' /etc/jupyter/jupyter_notebook_config.json

USER $NB_UID
ADD files/jupyter_notebook_config.py /home/jovyan/.jupyter/
