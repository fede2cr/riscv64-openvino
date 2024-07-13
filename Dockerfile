FROM docker.io/fede2/riscv64-ubuntu2404:latest

RUN apt-get update && apt-get dist-upgrade -y && \
  apt-get install git -y

RUN git clone https://github.com/openvinotoolkit/openvino.git \
  && cd openvino \
  && git submodule update --init --recursive

RUN cd openvino && ./install_build_dependencies.sh \
  && mkdir build && cd build \
  && cmake -DCMAKE_BUILD_TYPE=Release .. \
  && cmake --build . -j $(nproc)
