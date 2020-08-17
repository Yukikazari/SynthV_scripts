# SynthV_scripts

## これはなに
SynthVのスクリプト作りたいねーってやつです

## 共通の使い方
1.ダウンロードしてSynthVの\[スクリプト→スクリプトフォルダを開く]で表示されるフォルダに入れる  
2.再スキャンを実行  
3.スクリプトを選択して実行  

## seek.lua
スクリプトはPlay/seekです.  
ダウンロードは[ここ](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F8.2/seek.lua)  
シーク再生するスクリプトです  
再生開始したタイミングに戻ってるだけなので表示位置は元と違う可能性が高いです  
問題がありそうなら元の位置に戻るようにするかもしれません   
例外処理雑なのでエラー吐いたら停止状態でスクリプト実行してみてください  

spacebarに割り当てした場合デフォルト設定と競合して正常に作動しない可能性があります  
対処法として  
- 他のキーを割り当てに使う  
- 日本語入力のspacebarを使う(文字コードが違うため別のキーと認識されるようです)  
- KeySwapなどを使いキーを入れ替えて使う  
あたりで対処してください.  
SynthV起動時のみのKeySwapアプリとかまぁ…うん…  

## ライセンス
[Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)

## 連絡先
ゆきかざり   
Twitter:[@hanayuki7793](https://twitter.com/hanayuki7793)  
