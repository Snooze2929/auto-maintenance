FROM public.ecr.aws/lambda/python:3.12

WORKDIR /work

# 必要なパッケージだけインストール（高速化オプションなし）
RUN dnf -y update && \
    dnf -y install zip && \
    dnf clean all

# psycopg2-binary のインストール（Lambda Layer 用）
RUN pip install psycopg2-binary -t /python/lib/python3.12/site-packages/

# 出力する zip ファイルの作成
ENTRYPOINT [""]
CMD ["zip", "-r", "psycopg2-3.12.zip", "/python/"]
