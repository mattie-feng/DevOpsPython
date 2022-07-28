FROM alpine
RUN echo "https://mirrors.aliyun.com/alpine/v3.6/main/" > /etc/apk/repositories

RUN apk update
RUN apk add python3
RUN python3 -m pip install -U pip
RUN pip3 install --upgrade pip -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com


COPY . /

WORKDIR /

RUN python3 -m pip install Flask -i https://pypi.tuna.tsinghua.edu.cn/simple

ENTRYPOINT [ "python3" ]

CMD [ "easy_flask.py" ]
