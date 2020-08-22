# SynthV_scripts

## これはなに
SynthVのスクリプト作りたいねーってやつです

## 共通の使い方
1.ダウンロードしてSynthVの\[スクリプト→スクリプトフォルダを開く]で表示されるフォルダに入れる  
2.再スキャンを実行  
3.スクリプトを選択して実行  

## seek.lua
スクリプトは\[Play/seek]です  
ダウンロードは[ここ](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F8.2/seek.lua)  
シーク再生するスクリプトです  
再生開始時点でのバーの位置と画面内での座標を記録しておいてそこに戻るようになっています  
ほぼほぼ同じ位置に戻るはずですが割合で戻してるので1mm前後のズレが生じる可能性があります  
例外処理雑なのでエラー吐いたら停止状態でスクリプト実行してみてください  

spacebarに割り当てした場合デフォルト設定と競合して正常に作動しない可能性があります  
対処法として  
- 他のキーを割り当てに使う  
- 日本語入力のspacebarを使う(文字コードが違うため別のキーと認識されるようです)  
- KeySwapなどを使いキーを入れ替えて使う  

あたりで対処してください.  
SynthV起動時のみのKeySwapアプリとかまぁ…うん…  

## ChangeLyrics_default2pitch.lua
スクリプトは\[Lyrics/歌詞をどれみにするやつ]です  
ダウンロードは[ここ](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F8.3/ChangeLyrics_default2pitch.lua)  
デフォルト設定のままの歌詞のみをCeVIOライクな音階歌詞に変更するスクリプトです  
デフォルトの歌詞を"la"以外に変更している場合はluaファイル内1行目をその歌詞に書き換えてください  

これいる？(謎)  

## ライセンス
[Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)

## 更新履歴
### seek.lua
2020/8/17 v1.1公開 シーク時の挙動とスケール変更時の挙動をちょっと使いやすく  
2020/8/17 v1.0公開

### ChangeLyrics_default2pitch.lua
2020/8/19 v1.0公開

## 連絡先
ゆきかざり   
Twitter:[@hanayuki7793](https://twitter.com/hanayuki7793)  
