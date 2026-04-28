# サブスク管理

## サービス概要

サブスク管理は、自分が利用しているサブスクを一元管理できるサービスです。サービス名・金額・支払いサイクルを登録すると、毎月の合計支払い額を確認でき、支払日が近づいたらメールでお知らせします。

## URL

https://www.subscmanage.com

## スクリーンショット

<img width="545" height="672" alt="スクリーンショット 2026-04-19 21 52 29" src="https://github.com/user-attachments/assets/110988d6-4005-413e-a15d-1d437eb249f4" />

<img width="502" height="519" alt="スクリーンショット 2026-04-19 21 52 54" src="https://github.com/user-attachments/assets/81b95451-900d-4d95-80d6-1ffdf4f6bc72" />

## 技術スタック

| カテゴリ | 技術 |
|---|---|
| バックエンド | Ruby 3.4.7 / Ruby on Rails 8.1.1 |
| フロントエンド | Tailwind CSS v4 / Stimulus.js / Turbo |
| データベース | PostgreSQL |
| 認証 | Devise |
| メール送信 | Resend |
| デプロイ | Kamal |

## 環境構築

### 1. リポジトリの取得

```bash
git clone https://github.com/thmz337/subscmanage.git
cd subscmanage
```

### 2. 環境変数の設定

`.env.example` をコピーして `.env` を作成し、各値を設定してください。

```bash
cp .env.example .env
```

| 変数名 | 説明 |
|---|---|
| `RESEND_API_KEY` | [Resend](https://resend.com) で発行したAPIキー |
| `MAIL_FROM` | Resend で認証済みドメインの送信元メールアドレス |

### 3. セットアップ

```bash
bin/setup
```

### 4. 初期データの投入

```bash
bin/rails db:seed
```

開発環境では以下のユーザーが作成されます。

| ロール | メールアドレス | パスワード |
|---|---|---|
| 管理者 | admin@example.com | password |
| 一般ユーザー | user@example.com | password |

### 5. アプリの起動

```bash
foreman start -f Procfile.dev
```

アプリは http://localhost:5000 で起動します。

### メール確認（開発環境）

開発環境では送信メールを letter_opener で確認できます。

http://localhost:5000/letter_opener

## テスト

```bash
bin/rails test
bin/rails test:system
```
