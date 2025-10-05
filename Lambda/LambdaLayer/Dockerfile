# ベースイメージの設定
FROM public.ecr.aws/lambda/python:3.12

# 下記コマンドを実行する作業ディレクトリの指定
WORKDIR /work


# ベースイメージのパッケージを最新化
# zipファイル作成に必要なコマンドの導入
# 不要なキャッシュの削除
RUN dnf -y update && \
    dnf -y install zip && \
    dnf clean all

# psycopg2-binary のインストール（Lambda Layer 用）
RUN pip install psycopg2-binary -t /python/lib/python3.12/site-packages/

# エントリポイントの無効化
ENTRYPOINT [""]

# zipファイル作成コマンド実行
CMD ["zip", "-r", "psycopg2-3.12.zip", "/python/"]
