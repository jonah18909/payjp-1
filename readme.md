## errors
test する時に使う予定です
[ref:error](https://pay.jp/docs/api/#error)
### aboutPAYJP
Completed 500 Internal Server Error in 272ms (ActiveRecord: 2.9ms)
Payjp::InvalidRequestError (The amount must be between 50 and 9,999,999 JPY.):
Payjp::AuthenticationError (No API key provided. Set your API key using "Payjp.api_key = <API-KEY>". You can generate API keys from the Payjp web interface. See https://pay.jp/api for details, or email support@pay.jp if you have any questions.):

# payjp

## payjpを登録

## ファイルを変更
1. .env.org を .env にファイル名を変更する
2. 変更したファイル(.env)のなかにある該当箇所に秘密鍵を入力して保存しておく
3. app/views/products/show.html.erb のdata-keyのところの公開鍵を自分のものに変更する
