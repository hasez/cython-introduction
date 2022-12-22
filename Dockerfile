FROM python:3

RUN apt-get update -qq && \
    apt-get install -y locales vim less && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

# work user
# ARG USER_UID=1000
# ARG USER=app
ARG USER_UID=1000
ARG USER_GID=1000
ARG USER_NAME=app
ENV PATH ${PATH}:/home/${USER_NAME}/.local/bin
RUN /usr/sbin/useradd --uid ${USER_UID} --groups sudo ${USER_NAME} \
    && echo "${USER_NAME} ALL=NOPASSWD: ALL" >> /etc/sudoers

ARG HOME_DIR=/home/${USER_NAME}
RUN mkdir -p ${HOME_DIR}/src
COPY requirements.txt ${HOME_DIR}
RUN chown -R ${USER_NAME}:${USER_NAME} ${HOME_DIR}
WORKDIR ${HOME_DIR}
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools
RUN pip3 install -r requirements.txt

USER ${USER_NAME}