FROM public.ecr.aws/docker/library/elixir:1.17.3-otp-27

# Add a non-root user for better security
ARG USER=flamel
RUN adduser --disabled-password --gecos "" $USER && \
    mkdir -p /home/$USER

# Switch to the non-root user and set up their environment
USER $USER
WORKDIR /home/$USER

RUN bash -c 'mix do local.rebar --force, local.hex --force && \
    mix escript.install hex livebook --force'

ENV PATH="/home/${USER}/.mix/escripts:${PATH}"

CMD ["/bin/bash"]