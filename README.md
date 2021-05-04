# Cross-iOS

## 環境構築 ##

### Dependencies

Xcode: 12.3 以上 
OS: macOS Catalina 10.15.7 以上
Homebrew: v2.6.1以上
Ruby: v2.7.2以上
Bundler: v2.1.4以上
CocoaPods: v1.10.0 を使ってください

### インストール

Rubyのバージョンを確認し、条件を満たしていない場合はrbenv等を使って指定のバージョン以上にする

リポジトリをcloneする

`$ git clone git@bitbucket.org:emoshu/cross-ios.git ` 

CocoaPodsインストール

`$ gem install -v 1.10.0 cocoapods `

SwiftLintインストール

`$ brew install swiftlint `

Cross-iOSのルートディレクトリに移動し下記を実行

`$ bundle install `
`$ pod install `

Cross.xcworkspace を開いてビルド・実行する

実機で動かす場合、fastlaneのmatchを使って証明書とProvisioningProfileを設定する

`$ fastlane match development `

## Scheme ##
| Scheme名 | 内容 |
|:-----------|:------------|
| production | ストア配布用ビルド設定 |
| ad-hoc | テストアプリ配布用ビルド設定 |
| development | 開発用ビルド設定 |

## ブランチ戦略 ##

##### `master` ブランチ
- 現在リリースされているバージョン  
- `master` には直接コミットしない  
- `master` へのマージは `release` ブランチを通して行う  
- `master`にマージ後は`tag`を設定する(`v*.*.*-rc1`)  
##### `develop` ブランチ
- 開発用ブランチ  
- 実装した機能をリリースする際はここからリリースブランチ`release` を作成する   
##### `feature` ブランチ
- フィーチャーブランチ  
- フィーチャーブランチは `develop` ブランチから作成する
- フィーチャーブランチは JIRAのチケットに対応しており、`feature/cross_***`とする(`***`はチケット番号)  
##### `release` ブランチ
- リリースブランチ  
- アプリの申請時に`develop` ブランチから作成し、`release/v*.*.*` とする(`*.*.*`はバージョン)  
- 審査通過およびリリース後に`master` ブランチにマージする  

## Architecture ##

Crossでは*MVP* (*Passive View*)を採用している
MVVMはRxSwiftの使用が前提となっており学習コストも高いので使わない

View-Presenter-Model間のオブジェクトのやり取りはprotocolを介して行う  
基本はこの構造に沿うように実装するが絶体守らなければならないものではない（納期優先の場合など）  
この構造から外れる実装をする場合はTODOコメントを書いておいて時間があるときに対応する 

### View
- 画面の表示と遷移を担当
- データのロードや何かしらの処理が必要な場合はPresenterを操作する
- UIViewなどの表示系コンポーネント操作が主な役割

### Presenter
- ViewとModelを仲介する役割
- Viewからイベント受け取り、必要な情報をModelから引き出してViewを更新する
- ModelやRepositoryなどのデータ操作が主な役割
- アプリケーションビジネスルールを書く場所

### Model
- データアクセスを担当
- 必要なデータの構造や取得方法に関する実装を行う
- 外部APIにアクセスし何らかの処理を行う場合はModel, データを操作する場合はRepositoryを使う
- エンタープライズビジネスルールを書く場所

## プルリクエストを出す前に ##
- SwiftLintでコードを静的チェックする（ビルド時にチェックされる）
- Warningがなくならないとマージしないというルールはないが簡単に直せるものであれば対応しておく
- チェックルールは.swiftlint.ymlにある

手動でチェック

`$ swiftlint `

自動修正あり

`$ swiftlint autocorrect --format `

## App Distribution ##

前提: [fastlane](https://docs.fastlane.tools) とDistribution用の証明書およびProvisioningProfileがインストールされていること

`$ fastlane distribute release_note:"text"`
