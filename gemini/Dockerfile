FROM node:22-alpine

# 必要なパッケージをインストール
RUN apk add --no-cache git bash fish

# gemini-cliをグローバルインストール
RUN npm install -g @google/gemini-cli

RUN mkdir -p ~/.gemini && cat <<EOF > ~/.gemini/settings.json
{
  "selectedAuthType": "oauth-personal"
}
EOF

# 作業ディレクトリを設定
WORKDIR /app

# デフォルトコマンドをshに設定
CMD ["sh"]