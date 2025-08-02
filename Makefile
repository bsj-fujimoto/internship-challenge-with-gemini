# ==============================================================================
# 開発環境用 Makefile
# ==============================================================================

.PHONY: setup start stop reset-db gemini backend frontend cleanup help

# デフォルトターゲット（helpを表示）
.DEFAULT_GOAL := help

help: ## このヘルプメッセージを表示
	@echo "利用可能なコマンド:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## 初回セットアップ（Docker環境構築 + データベース初期化）
	@echo "🚀 開発環境をセットアップ中..."
	@echo "📦 Dockerコンテナをビルド・起動しています..."
	docker compose build --no-cache
	docker compose up -d
	sleep 10
	@echo "🗄️  テスト用データベースを初期化しています..."
	docker compose exec backend sh -c "php artisan app:init-database-test"
	@echo "✅ セットアップが完了しました！"

start: ## Docker環境を起動
	@echo "🚀 Docker環境を起動中..."
	docker compose up -d
	@echo "✅ 起動完了！"

stop: ## Docker環境を停止
	@echo "⏹️  Docker環境を停止中..."
	docker compose stop
	@echo "✅ 停止完了！"

reset-db: ## データベースをリセット（テスト環境/本番環境選択可能）
	@echo "🗄️  データベースをリセットします..."
	@echo ""
	@echo "📊 データベース初期化オプション:"
	@echo "   1. テスト環境用 (1,000件のデータを生成) - 開発・テスト用"
	@echo "   2. 本番環境用 (100万件のデータを生成) - パフォーマンステスト用"
	@echo ""
	@echo "⚠️  注意: 既存のデータベースは完全に削除されます！"
	@echo ""
	@read -p "どちらの環境でリセットしますか？ [1:テスト/2:本番]: " db_env; \
	if [ "$$db_env" = "2" ]; then \
		echo "🏭 本番環境用データベースを初期化中（100万件のデータ生成）..."; \
		echo "⏳ この処理には時間がかかる場合があります..."; \
		docker compose exec backend sh -c "php artisan app:init-database-production"; \
	else \
		echo "🧪 テスト環境用データベースを初期化中（1,000件のデータ生成）..."; \
		docker compose exec backend sh -c "php artisan app:init-database-test"; \
	fi; \
	echo "✅ データベースのリセットが完了しました！"

gemini: ## Geminiコンテナでgeminiコマンドを実行（Yoloモード選択可能）
	@echo "🤖 Geminiを起動します..."
	@echo ""
	@echo "💡 Yoloモードについて:"
	@echo "   • 通常モード: Geminiが提案する変更を一つずつ確認してから実行"
	@echo "   • Yoloモード (-y): すべての変更を自動承認して実行（高速だが注意が必要）"
	@echo ""
	@read -p "Yoloモード（自動承認）を使用しますか？ [y/N]: " yolo_mode; \
	if [ "$$yolo_mode" = "y" ] || [ "$$yolo_mode" = "Y" ]; then \
		echo "🚀 Yoloモードで起動中..."; \
		docker compose exec gemini sh -c "gemini -y"; \
	else \
		echo "🔍 通常モードで起動中..."; \
		docker compose exec gemini gemini; \
	fi

backend: ## バックエンドコンテナのbashシェルに接続
	@echo "🔧 バックエンドコンテナに接続中..."
	docker compose exec backend bash

frontend: ## フロントエンドコンテナのbashシェルに接続
	@echo "🔧 フロントエンドコンテナに接続中..."
	docker compose exec frontend bash

cleanup: ## Docker環境を完全にクリーンアップ（イメージ・ボリューム・オーファンコンテナを削除）
	@echo "🧹 Docker環境をクリーンアップ中..."
	@echo "⚠️  すべてのイメージ、ボリューム、オーファンコンテナが削除されます"
	docker compose down --rmi all --volumes --remove-orphans
	@echo "✅ クリーンアップ完了！"
