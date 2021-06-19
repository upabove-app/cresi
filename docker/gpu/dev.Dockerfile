FROM nvidia/cuda:11.0-devel-ubuntu20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        curl \
        vim \
        wget \
        make \
        g++ \
        unzip \
        ca-certificates \
        libsm6 \
        libxext6 \
        libxrender-dev \
        python3-opencv \ 
        libgdal \
        libgdal-dev \
        gdal-bin \
        libproj-dev \
    &&  rm -rf /var/lib/apt/lists/*
ENV PATH /opt/conda/bin:$PATH
CMD [ "/bin/bash" ]
# Leave these args here to better use the Docker build cache
ARG CONDA_VERSION=py38_4.9.2
ARG CONDA_MD5=122c8c9beb51e124ab32a0fa6426c656
ENV PYTHON_VERSION=3.8
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh -O miniconda.sh && \
    echo "${CONDA_MD5}  miniconda.sh" > miniconda.md5 && \
    if ! md5sum --status -c miniconda.md5; then exit 1; fi && \
    mkdir -p /opt && \
    sh miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh miniconda.md5 && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

COPY ./environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

ENV LD_LIBRARY_PATH /opt/conda/lib:/opt/conda/envs/cresi/lib:${LD_LIBRARY_PATH}

RUN apt install -y libgl1-mesa-glx

RUN /opt/conda/bin/conda clean -ya

#  PATH into conda environment
ENV PATH /opt/conda/envs/cresi/bin:$PATH

# specify vscode as the user name in the docker

ARG USERNAME=root

# RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
#     && mkdir /commandhistory \
#     && touch /commandhistory/.bash_history \
#     && chown -R $USERNAME /commandhistory \
#     && echo $SNIPPET >> "/home/$USERNAME/.bashrc"

# Specify matplotlib backend
WORKDIR /${USERNAME}/.config/matplotlib
RUN echo "backend : Agg" >> matplotlibrc

WORKDIR /workspace
