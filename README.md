# ✈️Tripot Share
<img width="1000" alt="tripot_share" src="https://github.com/maru973/Tripot_Share/assets/148407473/92c9c79d-0684-45f8-9f1e-9f3bda8832b5">

<br>

## ■ サービスURL
　https://tripot-share.com/<br>
　ゲストログイン機能を実装しておりますので、会員登録をせずにお試しいただけます。

<br>

## ■ サービス概要
　旅行メンバーとそれぞれの行きたいスポットを共有しながら簡単に旅行プランをつくることができるサービスです。

<br>

## ■ このサービスへの思い・作りたい理由
　友達と旅行計画を立てる際、それぞれの行きたい場所をリストアップして送り合い、それを検索して内容を把握し計画を立てることに手間を感じていました。
特に代表的な観光地以外の場所を訪れる際は、計画を一から立てる必要があります。
この手間を解消し、メンバーの行きたい場所を一括で表示できるようにしたいと考えました。<br>
　また旅行先の地理に詳しいわけではないため、行きたい場所を網羅する最適なルートを考えることが難しいと感じています。
出発点に近い場所から順番にある程度のルートを自動で決めてくれるものがあれば、より簡単かつ柔軟なオリジナルの旅行計画を立てることができると考えました。

<br>

## ■ ユーザー層
- モデルコースではなくオリジナルの旅行プランを簡単に立てたい方
- メンバーそれぞれの行きたいスポットを楽に共有したい方

<br>

## ■ サービスの利用イメージ
### 簡単5ステップ
1. まずはプラン作成・スポット登録 :round_pushpin: 
2. メンバーを招待
3. 登録したプランに対してどのくらい行きたいかを0~4ポイントでメンバーそれぞれが選択
3. メンバーのポイントを集計して、高得点の６位までをランキングで表示
4. ランキングのスポットを経由地として、出発地から到着地までの最適なルートを生成 :car: 
5. 好きな並び替えて再検索

気軽にスポットを登録してメンバーと共有できるため、より効率よく旅行を楽しむことができたらいいなと思っています。

<br>

## ■ ユーザーの獲得について
　Xでの発信や招待されたユーザーが次に旅行をするときに新たなユーザーを招待することでユーザーの獲得をしていきたいと考えています。<br>
　またゲストログインでお試しいただいたユーザーが、招待機能を使用するために会員登録することでユーザー獲得に繋げていきたいと思っています。

<br>

## ■ サービスの差別化ポイント・推しポイント
　類似サービスとしてGoogle Mapが挙げられますが、投票機能や最適化されたルートを提案することで差別化を図っています。
- Google Mapではあくまでも経路検索がメインであるため、みんなの行きたいスポットを共有して、調べて、まとめることは個人で行うことになります。
Google Mapに含まれていないその部分から一貫してサポートし、旅行プランを作成する時間を短縮することができます。
- Google Mapでは基本的に入力した順序でのみルートが生成されますが、Tripot Shareなら出発地から到着地までの間で効率よく周ることができるルートを提案します。
また提案されたルートをもとに並び替えて再検索することでよりオリジナルなルートの作成が可能です。

<br>

## ■ 機能紹介
| 会員登録・ログイン | プラン一覧 |
| ---- | ---- |
|<img width="1440" alt="68f238180723fd3be84e24de10f8818d" src="https://github.com/maru973/Tripot_Share/assets/148407473/5238e175-17a2-4ed2-a89d-4d873e196a28">　| <img width="950" alt="c4286fe00e7651a58615382783fce7da" src="https://github.com/maru973/Tripot_Share/assets/148407473/629eac49-f0e1-47c7-851d-409dfb0ef5d9">　|
| `devise`で会員登録・ログイン機能を実装しました。メールアドレスとLINEでのログインをユーザーが選択できるようになっています。メールアドレスで登録したユーザーはパスワードの再設定ができます。 | 旅のしおりをイメージしたカードは、画面サイズによってデザインを変えています。みんなのプランページでは他の人のプランも参考にすることができます。`ransack`を使用して見たいプランをすぐに検索できるようにしています。 |

<br>

| プラン作成 | プラン編集 |
| ---- | ---- |
| ![5bf75f89d932c951626f540ac7de7b62](https://github.com/maru973/Tripot_Share/assets/148407473/a4b323f0-c91e-4292-ab74-0e8274c47401) | ![9ed132335c1ae5b7e0a5794751ea638e](https://github.com/maru973/Tripot_Share/assets/148407473/331d4cdd-c8e8-4b9f-812b-0afee3956fa3) |
| 旅行先の都道府県を選択すると地図が生成されたときに、その都道府県にズームされた地図が表示されます。 | プラン情報の編集は`TurboStream`を使用して非同期でできるようにしました。マイプランページとみんなのプランページからのみ編集できます。 |

<br>

| スポット登録 | スポット詳細情報 |
| ---- | ---- |
|　![094729461d286ded30c3b8b0f7dfdb76](https://github.com/maru973/Tripot_Share/assets/148407473/8d0258f6-d403-41b6-9f4e-6b08dc424683)　|　![71b154f289f439699a624b644b25969b](https://github.com/maru973/Tripot_Share/assets/148407473/11bebf74-91cd-44ef-98bd-a5c6eb1beae3)　|
| スポットを入力するとオートコンプリートで入力候補を表示します。登録するとリストとマーカーが非同期で表示されます。 | それぞれのスポット名をクリックすると詳細情報がモーダルで表示されます。ℹ️をクリックすると現在の曜日が表示され、営業時間の確認を促すようにしました。 |

<br>

| プラン・スポット削除 | メンバー招待 |
| ---- | ---- |
| ![4ebc40b3981cfdf81ee1266cfcdf41c7](https://github.com/maru973/Tripot_Share/assets/148407473/6f8d2665-aa67-4314-b5f5-a8fc6ba66d52) | ![36eec3270f9a79f8893b719617c425d2](https://github.com/maru973/Tripot_Share/assets/148407473/6f89c2d2-889d-4a50-9ee6-c6bd15b98161) |
| スポット削除は`TurboStream`を使用しました。意図していないものを削除してしまうことを防ぐため、詳細ページからのみプラン削除ができるようにしました。 | 各プランにメンバーを招待できます。招待メールを送信するかリンクを共有する方法から選択できます。招待リンクはボタンをクリックするとコピーができるようにしました。 |

<br>

| ランキング投票 | ランキング |
| ---- | ---- |
| ![a995ffe443a756d1384a48ae5f9441ed](https://github.com/maru973/Tripot_Share/assets/148407473/df5ac9bc-73f9-404a-88f3-9d00a0fe5dfa) | <img width="1000" alt="7d28a6f70841846294de841fc3a7408f" src="https://github.com/maru973/Tripot_Share/assets/148407473/fb342204-b64a-46db-825f-17355a2d48af"> |
| プランに登録した全スポットに対してメンバーはそれぞれ行きたい度合いを0~4ポイントの中から選択し投票をします。 | ポイントを自動集計し、上位６位までのスポットを詳細ページのランキングタブに表示します。 |

<br>

| ルート作成 | ルート再検索 |
| ---- | ---- |
| ![d2f48ca8ed967b6aab3c8a9b11224586](https://github.com/maru973/Tripot_Share/assets/148407473/ad89e458-1c5d-4b15-b82f-0e9c39850391) | ![a6703e0a9b5cded20ed57792f2602d5c](https://github.com/maru973/Tripot_Share/assets/148407473/41180994-41ce-4a12-a72c-19fe63ff95e7) |
| ランキングの上位６位を経由して、出発地から到着地までの最適なルートを自動で検索します。 | スポットを並び替えて再度ルート検索ができます。並び替えは`sortablejs`を使用しました。 |

<br>

| 初回モーダル | ゲストログイン |
| ---- | ---- |
| ![92642eb3f7c1706fcccf65bf700b435a](https://github.com/maru973/Tripot_Share/assets/148407473/e838b8e0-7adb-48f6-9ba0-13933a54c17e) | ![f1c35cb83f72480baeafbcfce3698a4a](https://github.com/maru973/Tripot_Share/assets/148407473/6dafa708-a2bd-4886-83aa-aa1d07d26daa) |
| 作成　or　参加したプランの詳細ページに遷移した最初の一回のみメンバー招待を促すモーダルを表示するようにしました。 | 会員登録なしでもゲストとしてログインできるようにしました。ゲストユーザーはアカウントの削除、編集、招待機能は使用できません。 |  
<br>

## ■ 今後の開発について
### リアルタイム編集機能の実現（action cable）
メンバー同士がリアルタイムでスポット登録できるようになれば、よりUX向上になるとつながると考えています。

### RSpec
テストコードが書けていないので、バグやエラーを早期発見できるようにしたいです。
追加機能をデプロイした際に、今までの機能が動かないといったことがないようにしたいと考えています。

<br>

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

<br>

## ■ 画面遷移図
https://www.figma.com/file/lBu251dgQyLeiJrADJ3aS6/Untitled?type=design&node-id=0-1&mode=design&t=X9p84atC6EmjmI3p-0

<br>

## ■ ER図
![卒業制作](https://github.com/maru973/Tripot_Share/assets/148407473/e29a7c15-6853-4f15-ba31-b38bf4ca78e6)

