# Load ubuntu OS
FROM ubuntu:latest
RUN apt-get update && apt-get -y update
RUN apt-get install -y build-essential python3.6 python3-pip python3-dev
RUN pip3 install -q pip 
RUN mkdir src
WORKDIR src/
COPY . .

# Install requirement packages and pytorch (need to download seperately)
RUN pip3 install -q -r requirements.txt
RUN pip3 install -q torch==1.5.0+cpu torchvision==0.6.0+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN pip3 install jupyter

# Setting from jupyter notebook authors
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# Run jupyter notebook
CMD ["jupyter", "notebook", "--port=8888", "--ip=0.0.0.0", "--allow-root"]

