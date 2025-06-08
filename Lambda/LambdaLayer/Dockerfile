FROM public.ecr.aws/lambda/python3.12

WORKDIR /work

# システム更新と必要なパッケージのインストール
RUN dnf update && dnf install zip

RUN pip install --upgrade pip && \
    pip install psycop2-binary -t /python/lib/python3.12/site-packages/

ENTRYPOINT [""]
CMD zip -r psycopg2-3.12.zip /python/ 


