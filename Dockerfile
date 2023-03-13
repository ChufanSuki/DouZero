FROM nvidia/cuda:11.4.2-runtime-ubuntu20.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    python3-pip \
    git
RUN ln -s /usr/bin/python3 /usr/bin/python

COPY pyproject.toml pyproject.toml
RUN pip install poetry --upgrade
COPY poetry.lock poetry.lock
RUN poetry install

# Run.
CMD ["bash", "-c", "poetry run python train.py \
       --gpu_devices 0,1,2,3 \
       --num_actor_devices 3 \
       --num_actors 15\
       --training_device 3"]


# Docker commands:
#   docker rm douzero -v
#   docker build -t douzero .
#   docker run --name douzero douzero
# or
#   docker run --name douzero -it douzero /bin/bash