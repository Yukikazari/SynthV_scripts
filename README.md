# SynthVスクリプト
[download](https://img.shields.io/npm/dt/SynthV_scripts.svg) 
[license](https://img.shields.io/npm/dt/SynthV_scripts.svg)
## 共通の使い方
1.ダウンロードしてSynthVの\[スクリプト→スクリプトフォルダを開く]で表示されるフォルダに入れる  
2.再スキャンを実行  
3.スクリプトを選択して実行  
<br>

## ダウンロード

### [**一括ダウンロード**](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F8.4b/Yukikazari.zip)  
現状動作が確認できているスクリプトファイルの一括ダウンロード  

[**Return2OriginalPosition.lua**](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F8.4a/Return2OriginalPosition.lua)  

[**ChangeLyrics_default2pitch.lua**](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F8.3/ChangeLyrics_default2pitch.lua)

[その他動作保障のないスクリプト](https://github.com/Yukikazari/SynthV_scripts/archive/master.zip)  
<br>

## スクリプト説明

### Return2OriginalPosition.lua
スクリプトは\[Play/再生後元の位置に戻る]です  
再生終了時に再生開始ポイントに戻るスクリプトです  
seek.luaって付けてましたけどよく考えたらシーク再生じゃなかったので変更しました  
 
例外処理雑なのでエラー吐いたら停止状態でスクリプト実行してみてください  

\:warning: spacebarに割り当てした場合デフォルト設定と競合して正常に作動しない可能性があります  
対処法として  
- 他のキーを割り当てに使う  
- 日本語入力のspacebarを使う(文字コードが違うため別のキーと認識されるようです)  
- KeySwapなどを使いキーを入れ替えて使う  

あたりで対処してください.  
SynthV起動時のみのKeySwapアプリとかまぁ…うん…  
<br>

### ChangeLyrics_default2pitch.lua
スクリプトは\[Lyrics/歌詞をどれみにするやつ]です  
デフォルト設定のままの歌詞のみをCeVIOライクな音階歌詞に変更するスクリプトです  
デフォルトの歌詞を"la"以外に変更している場合はluaファイル内1行目をその歌詞に書き換えてください  

これいる？(謎)  
<br>

## 更新履歴
### Return2OriginalPosition.lua
2020/8/23 v1.2公開 名称の変更, 他言語対応  
2020/8/17 v1.1公開 シーク時の挙動とスケール変更時の挙動をちょっと使いやすく  
2020/8/17 v1.0公開

### ChangeLyrics_default2pitch.lua
2020/8/19 v1.0公開  
<br>

## 連絡先
ゆきかざり   
Twitter:[@hanayuki7793](https://twitter.com/hanayuki7793)  
<br>


## ライセンス
Copyright 2020 Yukikazari

Licensed under the Apache License, Version 2.0 (the “License”);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an “AS IS” BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
