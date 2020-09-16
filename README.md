# README

## アプリ名

・コイズミ bot 試作１号機

## 機能概要

#### Line Messaging API

1.  送信テキストに対応したリプライ
2.  Flex Message を使ったデザイン

#### スクレイピング

gem mechanize を使用し TECH CAMP ブログの新着から最新３件を取得する

#### openweathermap API

天気情報の取得に利用し、ラインの位置情報から天気情報を取得する

## 制作背景

当初 steamnews アプリを作りたいと考えていました。

steam のプラットフォームは中途半端に日本語化対応しており<br>
欲しい情報が英語のままで情報取得に不便さを感じたため<br>
情報収集手順を簡易化したかったのですが<br>
これを作ろうとした段階では WEBAPI を使用したことがなく<br>
また steamAPI の参考記事も少なかったため一旦 API を学ぶためのアプリを作り学習しようと考えました。<br>
そこで参考記事の多い linebot を選定しました。

機能は外部 API の他は興味があった項目(外部 API,bot,スクレイピング)を選出し実装、<br>
このアプリを通じて外部 API に関する知見がある程度たまったので<br>
TECHCAMP チーム開発カリキュラム終了後<br>
steamAPI を使用した news アプリを作成予定です。

## 参考画像

<img width="1092" alt="スクリーンショット 2020-08-02 18 06 52" src="https://user-images.githubusercontent.com/64514926/89119917-c7579e80-d4ec-11ea-9de4-90879b78ea72.png">
