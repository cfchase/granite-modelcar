FROM registry.access.redhat.com/ubi9/ubi-minimal:9.4

RUN microdnf -y install git git-lfs

RUN git clone https://huggingface.co/ibm-granite/granite-7b-instruct /models && rm -rf /models/.git

USER 1001
