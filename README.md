# SynthVスクリプト
![download](https://img.shields.io/github/downloads/Yukikazari/SynthV_scripts/total) 
![license](https://img.shields.io/github/license/Yukikazari/SynthV_scripts)
## 共通の使い方
1.ダウンロードしてSynthVの\[スクリプト→スクリプトフォルダを開く]で表示されるフォルダに入れる  
2.再スキャンを実行  
3.スクリプトを選択して実行  
<br>

## ダウンロード

### [**一括ダウンロード**](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F9.3/Yukikazari.zip)  
>現状動作が確認できているスクリプトファイルの一括ダウンロード  
おすすめです

- [**Return2OriginalPosition.lua**](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F9.3/Return2OriginalPosition.lua)  

- [**Return2OriginalPosition_Res.lua**](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F9.3/Return2OriginalPosition_Res.lua)  

- [**ChangeLyrics_default2pitch.lua**](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F9/ChangeLyrics_default2pitch.lua)  

- [**Changes.zip**](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F9.2/Changes.zip)  

- [**Longers.zip**](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F9.2/Longers.zip)  

- [**Shorters.zip**](https://github.com/Yukikazari/SynthV_scripts/releases/download/20%2F9.2/Shorters.zip)  

[その他動作保障のないものを含む全てのスクリプト](https://github.com/Yukikazari/SynthV_scripts/archive/master.zip)  
<br>

## スクリプト内容
- ### Playback
    - #### 再生後元の位置に戻る (Return2OriginalPosition.lua)
        >再生終了時に再生開始ポイントに戻るスクリプトです  
        再生/終了の両方で利用してください  
        seek.luaって付けてましたけどよく考えたらシーク再生じゃなかったので変更しました  

    - #### 再生後元の位置に戻る 常駐型 (Return2OriginalPosition_Res.lua)
        >上記スクリプトの常駐型です  
        通常の再生/終了処理を検知して再生バーを移動させます  
        他の再生系スクリプトと同時に利用すると意図しない動作をする可能性があります  

<br>

- ### Lyrics

    - #### 歌詞をどれみにするやつ (ChangeLyrics_default2pitch.lua)
        >デフォルト設定のままの歌詞のみをCeVIOライクな音階歌詞に変更するスクリプトです  
        デフォルトの歌詞を"la"以外に変更している場合はluaファイル内1行目をその歌詞に書き換えてください  

        >これいる？(謎)  

<br>

- ### Notes  
    - #### ___にする(Change2\_\_\_.lua)  
        >選択した任意の数のノートの長さを一括で変更します  
        他のノートやノートグループの位置は変更されません

    - #### ___分伸ばす(\_\_\_NotesLonger.lua)  
        >選択した任意の数のノートの長さを一定値伸ばします  
        設定により他のノートやノートグループの位置を変更するかどうか選択ができます  
        ファイル内のmotiontypeの値を変更してください  

    - #### ___分縮める(\_\_\_NotesShorter.lua)  
        >選択した任意の数のノートの長さを一定値縮めます  
        設定により他のノートやノートグループの位置を変更するかどうか選択ができます  
        ファイル内のmotiontypeの値を変更してください  

    以下のオプションが含まれます。  
    >Whole : 全音符  
    Half : 2分音符  
    Quarter : 4分音符  
    Eighth : 8分音符  
    Sixteenth : 16分音符  

<br>

## snippetsフォルダについて
詳しくはこちらを参照してください。  
[紹介ブロマガ](https://ch.nicovideo.jp/hanayuki7793/blomaga/ar1946020)  

<br>

## 更新履歴
### Return2OriginalPosition.lua
2020/8/23 v1.2公開 名称の変更, 他言語対応  
2020/8/17 v1.1公開 シーク時の挙動とスケール変更時の挙動をちょっと使いやすく  
2020/8/17 v1.0公開

### Return2OriginalPosition_Res.lua
2020/9/10 v1.0公開

### ChangeLyrics_default2pitch.lua
2020/8/19 v1.0公開  

### Change2\_\_\_.lua
2020/9/13 v1.0公開  

### \_\_\_NotesLonger.lua
2020/9/13 v1.0公開  

### \_\_\_NotesShorter.lua
2020/9/13 v1.0公開  
<br>

## 連絡先
ゆきかざり   
Twitter : [@hanayuki7793](https://twitter.com/hanayuki7793)  
mail : `yukikazari7793☆gmail.com` (☆→@)  
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
