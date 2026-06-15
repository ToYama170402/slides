#import "@preview/touying:0.7.4": *
#import themes.simple: *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#codly(languages: codly-languages)

#set text(
  font: ("Haranoaji", "Inter"),
  lang: "ja"
)

#show: simple-theme.with(
  aspect-ratio: "16-9",
  config-common(show-bibliography-as-footnote: bibliography("citation.bib"))
)

#show link: underline
#show link: set text(fill: blue)

#let git_graph = [
  #show text: it => text(size:15pt, it)
  #diagram(
    spacing: (0pt, 8pt),
    node-shape: circle,
    edge-stroke: 8pt,
    node((0, -1), [main]),
    node((1, -1), [feature]),
    node((2, -1), [commit message]),
    node((0, 0), fill: gray, width: 15pt, height: 15pt, name: <first_commit>),
    node((2,0), [first commit]),
    node((0,1), fill: gray, width: 15pt, height: 15pt),
    node((2,1), [hoge]),
    node((0, 4), fill: gray, width: 15pt, height: 15pt),
    node((2,4), [fuga]),
    node((0,5), fill: gray, width: 15pt, height: 15pt),
    node((2,5), [hogehoge]),
    node((1,2), fill: gray, width: 15pt, height: 15pt),
    node((2,2), [fugafuga]),
    node((1,3), fill: gray, width: 15pt, height: 15pt),
    node((2,3), [piyopiyo]),
    node((0,6), fill: gray, width: 15pt, height: 15pt),
    node((2,6), [piyo]),
    edge((0,0), (0,7)),
    edge((0,1), (1,1), (1,6), (0,6)),
  )
]

= Git/GitHubの使い方

= Git

// Gitのロゴを置きたい
== Gitとは

'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency. ' @git-scm.com

Gitは小さいプロジェクトから非常に大きなプロジェクトまで全てを高速で効率的に扱うために設計された自由でオープンソースな分散バージョン管理システムです。\
バージョン管理ツールのデファクトスタンダード

== バージョン管理とは

コードの歴史を記録する行為

- 変更前後の状態を保存/管理する
- 変更理由を保存/管理する
- 変更前がよかったなぁ〜って時に便利
  - 変更して動かなくなった時に戻したくなる
- どうしてこの変更を行ったかわかる
- (広義には)並行してコードを変更/保存/管理できる

== バージョン管理の必要性
// どれが最新状態かわからなくなる典型例の写真

- 変更で重大な欠陥が発生した時にすぐに元に戻せる
  - 思い切った変更をする心理的障壁が下がる
- 変更した理由がわかる
- 並行してコードを変更できる
  - 並行して機能を開発出来る

== Gitの類似ツール

- SCCS (source code control system) 世界初のVCS @sccs
- RCS (revision control system) ファイルごとに管理 @rcs
- CVS (concurrent versions system) @cvs

多分お世話になることはない…と思う……

---

#slide[
  - Subversion @svn
  - Fossil @fossil
  - Unity Version Control @unity_vcs
  - jj @jj
][
  - SQLiteは独自のVCSを作って使っている
  - jjはGit互換の新しいVCS
]

== Gitの概念

Gitには概念や操作が多い

#columns(2)[
  - レポジトリ(repository)
  - ブランチ(branch)
  - クローン(clone)
  - フェッチ(fetch)
  - プル(pull)
  - ステージ(stage)
  - コミット(commit)
  - プッシュ(push)
  - マージ(merge)
  - コンフリクト(conflict)
]

== レポジトリ(リポジトリ)(repository)

- コード保存場所≒(プロジェクト)フォルダー
- ローカルとリモートの２つがある
  - ローカルは自分のPC
  - リモートはどこかのPC
    - GitHubとかGitLabとか
    - ファイルサーバーとかでも良い
  - *分散*バージョン管理システムと言われる所以

== ブランチ(branch)

#slide(composer: (1fr, auto))[
  - 変更履歴(歴史)の分岐
  - 統合できる
  - 並行してコードを変更する機能
  - レポジトリ毎に存在
    - ローカルにもリモートにも作れる
    - 別のPCにも作れる
][
  #git_graph
]
---

#slide()[
  - チーム開発で必須
  - 使いこなせると非常に便利

  ブランチを切る(歴史を分岐する)\
  〜(ブランチ名)ブランチが〜
][
  ```bash
  # ブランチの一覧
  git branch
  # ブランチの切り替え
  git switch <ブランチ名>
  # ブランチの作成
  git switch -c <ブランチ名>
  # ブランチの削除
  git branch -d <ブランチ名>
  ```
]

== クローン(clone) `git clone`

#slide()[
  - リモートレポジトリからレポジトリ全体を丸々DL
  - そのレポジトリで作業する一番最初に一回だけ実行

  (レポジトリ名)をクローンする
][
  ```bash
  # クローンする
  git clone <レポジトリのURL>
  ```
]

== フェッチ(fetch) `git fetch`

#slide()[
- リモートレポジトリの最新情報を取得
- ローカルレポジトリの状態は更新しない
- 大体プル(pull)する前に実行する

フェッチする
][
  ```bash
  # フェッチする
  git fetch
  ```
]

== プル(pull) `git pull`

#slide()[
  - リモートブランチの状態をローカルに同期

  (変更内容/コミット/ブランチなど)をプルする
][
  ```bash
  # 上流ブランチを現在のブランチにプルする
  # ローカルブランチに紐付けられているリモートブランチがプルされる
  git pull
  # リモートのmainブランチを現在のブランチにプルする
  git pull origin main
  ```
]

== ステージ(stage) `git add`

#slide()[
  - コミットする準備場所
  - コミットの前段階
  - コミットに含めるファイルの整理
  - コミット内容の確認
  - 誤コミット防止
  - 変更内容の一時保存

  (ファイル名)をステージする
][
  ```bash
  # ステージする
  git add <ファイル名>
  # unstageする
  git reset <ファイル名>
  ```
]

== コミット(commit) `git commit`

#slide(composer: (1fr, auto))[
  - あるブランチに対する変更内容
  - コミットを積み上げることで変更履歴を記録していく

  (ファイル名)をコミットする\
  このコミットが〜
  ```bash
  # コミットする
  git commit -m "コミットメッセージ"
  ```
][
  #git_graph
]

== プッシュ(push) `git push`

- ローカルの変更内容をリモートに送信

プッシュする

```bash
# 現在ブランチを紐付けられているリモートブランチにプッシュする
git push
# リモートのmainブランチにプッシュする
git push origin main
```

== マージ(merge) `git merge`

#slide(composer: (1fr,auto))[
- ブランチを統合する
- 色んな種類がある

〜(ブランチ名)と〜をマージする

```bash
# mainブランチに切り替え
git switch main
# featureブランチをマージ
git merge feature
```
][
  #git_graph
]

== コンフリクト(conflict)

- ブランチを統合する時に発生することがある
- リモートブランチをpullする時にも発生することがある
- ブランチが統合出来ない状態
- 統合するブランチそれぞれで同じファイルの同じ行を変更していると発生
- 手動でコンフリクトを解決してマージする

〜と〜をマージしようとしたらコンフリクトした

== 参考になりそうなリンク

- #link("https://koseki.hatenablog.com/entry/2014/04/22/inside-git-1", "Git の仕組み (1)")
- #link("https://git-scm.com/cheat-sheet", "Git Cheat Sheet")
- #link("https://backlog.com/ja/git-tutorial/", "サル先生のGit入門")
- #link("https://qiita.com/chihiro/items/04482caebc702e75e84d", "【Git】commitの粒度")

= GitHub

== GitHub(ギットハブ)とは

'GitHub は、コードを書く際に、保存、共有、他の人との共同作業ができるクラウド ベースのプラットフォームです。'@about_github

Gitのリモートレポジトリとそれに関連する機能を提供するサービス及び運営企業の名前(Microsoftに買収された)

コードホスティングサービスのデファクトスタンダード

== 類似サービス/ツール

- GitLab @gitlab
- Bitbucket @bitbucket
- Gitee@gitee (簡体字:码云; 繁体字:碼雲; 拼音: Mǎyún)@gitee_wikipedia

GitHubで提供される機能一つだけ(IssueやProjectなど)を提供するサービス/ツールも沢山ある

== GitHubで出来ること

- コードホスティング(リモートレポジトリの作成)@github_repository
- バグ管理(Issues)@github_issues
- コードレビュー(Pull Request/プルリク)@github_pull_req

---

- プロジェクト管理(Projects)@github_projects
- CI/CD(Actions)@github_actions

などなど

== コードホスティング

#columns(2)[
  - 開発の起点
  - プロジェクトのディレクトリ構造
  - ブランチの切り替え
  - README
  - その他ボタン/リンク
  #figure(
    image("./image/repository.png"),
    caption: [VSCodeのレポジトリ@vscode_repository]
  )
]

== Issues

#columns(2)[
  - レポジトリ専用の掲示板
  - タスクやバグを書くことが多い
  - プルリクやProjectsと連携できる
  #figure(
    image("./image/issues.png"),
    caption: [VSCodeのIssues@vscode_issues]
  )
]

== Pull Request

#columns(2)[
  - レビュー依頼
  - 作業したブランチと紐付いている
  - レビューが完了するとマージしてプルリクはcloseする
  #figure(
    image("./image/pull_request.png"),
    caption: [VSCodeのプルリク@vscode_pull_req]
  )
]

== Projects

#columns(2)[
  - カンバン/ガントチャートとかが作れる
  - Issuesやプルリクなどと連携できる
  #figure(
    image("./image/projects.png"),
    caption: [VSCodeのProjects@vscode_projects]
  )
]

== Actions

#columns(2)[
  - CI/CD
  - レポジトリでのイベントや時間で事前に定義した作業を自動で実行する
  - プルリク時に自動でテスト/ビルド/ステージング環境にデプロイなど
  #figure(
    image("./image/actions.png"),
    caption: [VSCodeのActions@vscode_actions]
  )
]

== GitHubフロー@github_flow

#slide(composer: (1fr, 0.5fr))[
  - ブランチ戦略と呼ばれるものの一種
    - ブランチをどう活用するか
    - 他にも色々ある
  - GitHubが提唱する作業の流れ
  - プルリクを中心としている
][
  #show text: it => text(size: 20pt, it)
  #diagram(
    spacing: 15pt,
    node((0,0), [ブランチの作成], name: <checkout>),
    node((0,1), [変更作業], name: <commit>),
    node((0,2), [プルリクの作成], name: <pr>),
    node((0,3), [レビュー], name: <review>),
    node((0,4), [修正], name: <revice>),
    node((0,5), [マージ], name: <merge>),
    edge(<checkout>, <commit>, "->"),
    edge(<commit>, <pr>, "->"),
    edge(<pr>, <review>, "->"),
    edge(<review>, <revice>, bend: 40deg, "->"),
    edge(<revice>, <review>, bend: 40deg, "->"),
    edge(<revice>, <merge>, "->"),
  )
]

== Organisation@github_organisation

- GitHubでの組織
- CASるの活動の成果物はCASるのOrganisation所有のレポジトリに上げることが多い

== 参考になりそうなリンク

GitやGitHubはそれ単体で１つ本が書けるので、今わからなくてもそんなに落ち込む必要はない

- #link("https://docs.github.com/ja", "GitHubドキュメント")

= やってみよう

== やってみよう

GitHubのプロフィールをカスタムする

#columns(2)[
  + アカウントを作る
  + Organisationに追加する
  + レポジトリを作成する
    - レポジトリ名は\<自分のユーザーID\>
    - プロフィールを書くためのレポジトリ
  + Git(とお好みのGUI)をインストールする
    - VSCode/GitHub Desktopなど
  + レポジトリをクローンする
  + ブランチを作成する
  + `README.md`を追加してコミット/プッシュする
    - プロフィールを書こう
  + プルリクを作成する
  + マージする
]

== マークダウンの書き方

#columns(2)[
  #raw(
"# 見出し1
## 見出し2
### 見出し3
#### 見出し4
##### 見出し5
###### 見出し6

段落 **太字** __下線__
`インラインコード`

- 箇条書き
- 箇条書き
  - ネスト出来る

1. 番号付き箇条書き
2. 番号付き箇条書き
  1. ネスト出来る

```
コードブロック
```

- [ ] チェックリスト
- [x] チェック済

表も書ける

|見出し|見出し|
|----|----|
|セル|セル|
|セル|セル|",
    lang: "markdown"
  )

  - HTMLとかLaTeXみたいに、どこかの組織が統一した文法を定義していないので実装依存/方言多数
  - GitHubのいたるところでも書くことが出来る@github_markdown
  - プレビューはVSCode拡張などで
]


== コミット/プッシュするときに注意していること

- コミットメッセージは変更内容と変更した理由を書く
  - 少なくともどちらかは書く(`a`とか`hoge`はやめよう)
- 後で戻すことを念頭にコミットする
  - 意味のあるまとまりでコミットする
  - 動かない状態を(極力)コミットしない
- 即コミット即プッシュは(極力)やらない
  - コミット/プッシュしていいか吟味する
  - セルフレビューの推奨

== 話さなかったこと

- コミットメッセージの具体的な書き方
  - チームで統一すると良い
- コミット/Issue粒度
  - プロジェクトの進め方による
  - 意味のあるまとまりでコミットすると適切な粒度になる
- `git rebase`回り
  - 初学者には難しい(とされている)
  - 便利
---
- `git add -p`
  - ファイルの一部分をステージ
  - コミット内容の整理に使える
- `git mv <ファイル名>`
- `git rm <ファイル名>`
- `git cherry-pick <コミット番号>`

== 参考文献

#magic.bibliography(title: none)
