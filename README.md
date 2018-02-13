# Twinkpot
<img width="750" alt="2018-02-12 2 43 10" src="https://user-images.githubusercontent.com/25474041/36155264-45255c40-1117-11e8-933f-31fd69979b8f.png">
<img width="750" alt="2018-02-13 23 41 38" src="https://user-images.githubusercontent.com/25474041/36155372-8cfad586-1117-11e8-97d8-712db9f98701.png">

## Twinkpotとは
「フォトジェニックな写真」から行きたい場所を見つけることができます。 写真から行きたい場所を見つけることに最適化されたアプリケーションです。   
また、写真からあなただけの旅行プランを作成することができ、フォトジェニックな旅が体験できます。
### 由来
「Twinkle」 + 「Spot」

## なぜ作ったのか
昨今、Instagramから行きたい場所を探す若者が増えている。しかし、Instagramは場所（都道府県や市区町村）を探すのには最適化されておらず
「探しにくい」という課題を抱えている為。

## 技術スタック
- フロントエンド  
Vue.js,  vue-router,  axios,  Service Worker,
Adobe Creative Cloud SDK,  Sass,  webpack

- サーバサイド  
Ruby on Rails5.1,
Unicorn(アプリケーションサーバ)

- インフラ  
Amazon EC2(AmazonLinux),   Amazon CloudFront,
AmazonElastiCache(Redis),  Amazon S3,
MySQL5.6,  Nginx,  HTTP2

- API  
Google Maps API

- その他  
git-flow, capistrano

## 工夫点
- CDN(CloudFront)
- キャッシュサーバ(Redis)
- PWA
- gzip圧縮（転送量削減）

## 今後の展望(タスク)
- Instagram API
- ネイティヴアプリ(Swift,Kotlin)
- レコメンドの実装

## 注意点
あまり投稿・削除等はしないでいただけると嬉しいです（ストレージ容量の関係で....）

## サンプル
**テストアカウント**  
 メールアドレス: yuko@gmail.com  
 パスワード: yuko0111
