# Tripot Share
<img width="1000" alt="tripot_share" src="https://github.com/maru973/Tripot_Share/assets/148407473/92c9c79d-0684-45f8-9f1e-9f3bda8832b5">

## ■ サービスURL
https://tripot-share.com/<br />
ゲストログイン機能を実装しておりますので、会員登録をせずにお試しいただけます。

## ■ サービス概要
旅行メンバーとそれぞれの行きたいスポットを共有しながら旅行プランをつくることができるサービスです。<br>
ユーザーは行きたいスポットを登録し、登録されたスポットに対してどのくらい行きたいかを投票し、上位６位までのランキングを作成します。
最後に出発地点と最終地点を登録すれば、ランキングのスポットを経由する最適なルートを提案します。
生成されたルートはスポットを並び替えて再検索できるため、自分だけの旅行プランをつくることができます。


## ■ このサービスへの思い・作りたい理由
友達と旅行計画を立てる際、それぞれの行きたい場所をリストアップして送り合い、それを検索して内容を把握し計画を立てることに手間を感じていました。
特に代表的な観光地以外の場所を訪れる際は、計画を一から立てる必要があります。
この手間を解消し、メンバーの行きたい場所を一括で表示できるようにしたいと考えました。<br>
また旅行先の地理に詳しいわけではないため、行きたい場所を網羅する最適なルートを考えることが難しいと感じています。
出発点に近い場所から順番にある程度のルートを自動で決めてくれるものがあれば、より簡単かつ柔軟なオリジナルの旅行計画を立てることができると考えました。


## ■ ユーザー層
- オリジナルの旅行計画を簡単に立てたい個人やグループ
  

## ■ サービスの利用イメージ
- 行きたい場所を入力し登録すると、地図上にピンが立つ。
- メンバーに招待コードを共有し、行きたい場所を登録してもらう。
- 各メンバーの登録した場所が色別のピンで地図上に表示される。
- 出発点と最終到着地点を入力すると登録された場所を効率よく回れるルートが表示される。
- ドラック&ドロップとで柔軟にルートの変更が可能。
  

## ■ ユーザーの獲得について
- Xでの発信を通じてユーザーを獲得。
- 招待されて使用した未登録ユーザーが会員登録をして新たな未登録ユーザーを招待する。


## ■ サービスの差別化ポイント・推しポイント
複数の行きたい場所があるとき、Google Mapであれば入力した順にルートが表示され、それを自分で動かしてルートを作成します。<br>
しかしながらこのサービスでは入力した順序ではなく出発点から近い順でルートを提案することにより、効率の良いルートを自動で提案することができます。<br>
また提案されたルートを自分で修正することができるため、オリジナリティある最適なルート作成が可能です。


## ■ 機能紹介
| ログイン | プラン一覧 |
| ---- | ---- |
| 画像 | 画像 |
| `devise`でログイン機能を実装しました。メールアドレスとLINEでのログインをユーザーが選択できるようになっています。 | 学校の旅行のしおりをイメージしたカードデザインにし、旅行へのワクワク感を演出しました。画面サイズに合わせてデザインを変えています。マイプランページとみんなのプランページがあり、自分のプランだけでなく他の人のプランも参考にすることができます。`ransack`を使用して見たいプランをすぐに検索できるようにしています。 |

<br>

| プラン作成 | プラン編集 |
| ---- | ---- |
| 画像 | 画像 |
| 旅行先の都道府県を選択すると地図が生成されたときに、その都道府県にズームされた地図が表示されます。 | 説明 |

<br>

| スポット登録 | スポット詳細情報 |
| ---- | ---- |
| 画像 | 画像 |
| 説明 | 説明 |

<br>

| プラン・スポット削除 | メンバー招待 |
| ---- | ---- |
| 画像 | 画像 |
| 説明 | 説明 |

<br>

| ランキング投票 | ランキング |
| ---- | ---- |
| 画像 | 画像 |
| 説明 | 説明 |

<br>

| ルート作成 | ルート再検索 |
| ---- | ---- |
| 画像 | 画像 |
| 説明 | 説明 |

<br>

| 初回モーダル | ゲストログイン |
| ---- | ---- |
| 画像 | 画像 |
| 説明 | 説明 |  

## ■ 今後の開発について
### リアルタイム編集機能の実現（action cable）
メンバー同士がリアルタイムでスポット登録できるようになれば、よりUX向上になるとつながると考えています。

### RSpec
テストコードが書けていないので、バグやエラーを早期発見できるようにしたいです。
追加機能をデプロイした際に、今までの機能が動かないといったことがないようにしたいと考えています。

## ■ 使用技術
|  | 技術 |
| ---- | ---- |
| フロントエンド | TailwindCSS（daisyUI）　/　JavaScript　/　Hotwire |
| バックエンド | Ruby 3.2.2　/　Ruby on Rails 7.1.3 |
| データベース | PostgreSQL |
| CI/CL | GitHubActions |
| インフラ | Fly.io　/　AmazonS3 |
| API | Google Maps JavaScript API　/　Google Places API　/　Google Geocoding API　/　Google Directions API |
| その他 | Docker　/ Devise |


## ■ 画面遷移図
https://www.figma.com/file/lBu251dgQyLeiJrADJ3aS6/Untitled?type=design&node-id=0-1&mode=design&t=X9p84atC6EmjmI3p-0

## ■ ER図
![卒業制作](https://github.com/maru973/Tripot_Share/assets/148407473/e29a7c15-6853-4f15-ba31-b38bf4ca78e6)

