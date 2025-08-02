# GEMINI.md

## プロジェクト概要

これは、インターンシップの課題として設計されたユーザー管理アプリケーションです。このアプリケーションは、パフォーマンスのボトルネック、セキュリティの脆弱性、劣悪なユーザーエクスペリエンスなど、さまざまな問題を含んで意図的に構築されています。このプロジェクトの目標は、これらの問題を特定し、修正することです。

このアプリケーションは、Next.js、TypeScript、Tailwind CSSで構築されたフロントエンドと、LaravelとMySQLを搭載したバックエンドで構成されています。環境全体がDockerを使用してコンテナ化されています。

## ビルドと実行

### 前提条件

*   DockerとDocker Compose
*   Git
*   Make（macOS/Linux標準、Windows の場合は WSL2 推奨）

### セットアップ

1.  **リポジトリをクローンします:**
    ```bash
    git clone https://github.com/bravesoft-inc/internship-challenge-with-gemini.git
    cd internship-challenge-with-gemini
    ```

2.  **利用可能なコマンドを確認:**
    ```bash
    make help
    ```

3.  **初回セットアップ（推奨）:**
    ```bash
    make setup
    ```
    このコマンドで以下が自動実行されます：
    - Docker環境のビルドと起動
    - テスト用データベースの初期化（1,000件のデータ生成）

4.  **アプリケーションにアクセスします:**
    *   **フロントエンド:** `http://localhost:3000`
    *   **バックエンドAPI:** `http://localhost:8000/api`

### 主要なMakeコマンド

| コマンド | 説明 |
|---------|------|
| `make setup` | 初回セットアップ（Docker環境構築 + データベース初期化） |
| `make start` | Docker環境を起動 |
| `make stop` | Docker環境を停止 |
| `make reset-db` | データベースをリセット（テスト/本番環境選択可能） |
| `make gemini` | Geminiを起動（Yoloモード選択可能） |
| `make backend` | バックエンドコンテナのbashシェルに接続 |
| `make frontend` | フロントエンドコンテナのbashシェルに接続 |
| `make cleanup` | Docker環境を完全にクリーンアップ |

### Geminiの使用方法

Geminiを使用してコードの改善を行う場合：

```bash
make gemini
```

実行時に以下を選択できます：
- **通常モード**: Geminiが提案する変更を一つずつ確認してから実行
- **Yoloモード (-y)**: すべての変更を自動承認して実行（高速だが注意が必要）

### データベースの管理

データベースをリセットしたい場合：

```bash
make reset-db
```

実行時に以下を選択できます：
- **テスト環境用**: 1,000件のデータを生成（開発・テスト用）
- **本番環境用**: 100万件のデータを生成（パフォーマンステスト用）

### 開発時のワークフロー

1. **環境起動**: `make start`
2. **コード修正**: エディタでコードを編集
3. **Geminiで改善**: `make gemini`
4. **データベースリセット**: `make reset-db`（必要に応じて）
5. **環境停止**: `make stop`

## 開発規約

このプロジェクトには、明確なコーディングスタイルガイドラインはありません。ただし、既存のコードはLaravelとNext.jsの標準的な規約に従っています。変更を加える際には、以下に従うことをお勧めします。

*   **バックエンド:** PHPのPSR-12コーディングスタイルガイドに従ってください。
*   **フロントエンド:** 標準的なReact/Next.jsのコーディング規約に従ってください。
*   **テスト:** `ISSUES.md`ファイルには、対処する必要のある多くの問題が概説されています。変更を加える前に、問題を再現するテストを作成することをお勧めします。これにより、修正が効果的であり、リグレッションが発生しないことを確認できます。

## 主要ファイル

*   `README.md`: プロジェクトの概要とセットアップ手順が含まれています。
*   `ISSUES.md`: 修正が必要な問題の詳細なリストが記載されています。
*   `docker-compose.yml`: フロントエンド、バックエンド、およびデータベース用のDockerコンテナを定義します。
*   `frontend/`: Next.jsフロントエンドアプリケーションが含まれています。
*   `backend/`: Laravelバックエンドアプリケーションが含まれています。
*   `backend/app/Http/Controllers/UserController.php`: ユーザー関連のリクエストを処理するためのメインコントローラーです。
*   `backend/routes/api.php`: バックエンドのAPIルートを定義します。
*   `frontend/src/app/page.tsx`: フロントエンドアプリケーションのメインページです。
*   `frontend/src/app/users/list/page.tsx`: ユーザーリストページです。
*   `frontend/src/app/users/add/page.tsx`: ユーザー追加ページです。
*   `frontend/src/app/users/import/page.tsx`: CSVインポートページです。
*   `frontend/src/app/users/export/page.tsx`: CSVエクスポートページです。

## 今後の対話について

今後の対話では、基本的に日本語を使用します。