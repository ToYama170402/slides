#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#codly(languages: codly-languages)

#set text(
  font: ("Haranoaji", "Inter"),
  lang: "ja",
)

#show: (
  metropolis-theme.with(
    aspect-ratio: "16-9",
    config-info(
      title: [角間坂RTA],
      author: [ToYama],
      date: [2026/07/03],
      subtitle: [毎日の登校にワクワクを],
    ),

    config-common(show-bibliography-as-footnote: bibliography("citation.bib")),
  )
)

#show link: underline
#show link: set text(fill: blue)

#title-slide()

#outline-slide(title: [目次], spacing: 0.2em)

#focus-slide([毎日の登校にワクワクを])

== アプリ概要

- 角間坂を上る速さを競うRTAスマホアプリ
- 徒歩の部/自転車の部の２つの部門(予定)
- 総合教育棟コース/自然研コース(予定)
- 起動したらすぐに測定可能
- トップ画面には角間あざみが！

== 開発現状

- ☑環境構築
- ☑外部設計
- ☑内部設計
- ☑詳細設計
- ☑裏側のロジック実装
- ❌️UIの実装
- ❌️CI/CDの整備
- ❌️アプリのリリース

== 使用技術

=== Flutter

- アプリケーションフレームワーク
- クロスプラットフォーム(iPhone/Android/Windows/Mac/Linux)
- Google謹製

=== Supabase

- BaaS(Backend as a Service)
- オープンソース
- DB/認証/エッジ関数/ストレージ など

== 今後の展望

- UIの実装
- アプリのリリース
- 実際に使ってみる

== 今回挑戦したこと

#columns(2)[
  - Agentic コーディング
    - 今までやってこなかったから慣れない…
    - 完成するか心配
    - トークンが足りない…(GitHub Copilot Student)
  - Flutterの使用
    - ほとんどAIが書いたからなんもわからん
  - モバイルアプリ開発
    - ほとんどAIが書い(以下略)
  #colbreak()
  - Nix devshellでのFlutter環境の構築
    - 本当はpackageまでやりたいけど明らかに割に合わなそうだったのでdevshellで妥協
]


== イラスト募集

- 角間あざみを起用したい
- トップ画面/アイコン など

=== (角間)あざみとは @oai:kanazawa-u.repo.nii.ac.jp:00028689

- 金沢大学に宿った精霊の女の子
- アカンサスポータルのイメージキャラクター
- くすんだ緑色の着物を着ている
- 少し紫がかった長髪
- 側頭部に特徴的な耳のようなものが生えている

(スライドをGitHubで公開していて再配布になるため画像はなし)

== 困っていること

- イラストが描けないこと
- ゲームっぽいUIが書けないこと
- AIのトークンが足りない
  - あまりお金を掛けたくない…
- アプリストアに登録するのが面倒
  - あまりお金を…(以下略)
  - Apple Developer Program 99 USD/year
  - Google Play Console 25 USD

== 雑三行まとめ

- 角間坂で競争するネタアプリを作ってるよ
- AIのトークンをくれ
- 角間あざみを誰か描いてくれないかなぁ
