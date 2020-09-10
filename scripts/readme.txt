==はじめに==
スクリプトは階層構造のフォルダでも読み込むことができます。
.../scripts/Yukikazari/Lyrics/hoge.lua
などの形でも正常に動作しますので適当に分類しておくと便利だと思います。

==導入方法==
・SynthVエディタの[スクリプト/スクリプトフォルダを開く]からscriptフォルダを開き、
　その中にダウンロードしたファイルを入れる。
・Proエディタでしか機能しません
・基本的に最新のエディタでの利用を想定しています。
　旧バージョンで利用する場合はスクリプトファイル内の{minEditorVersion = 2^16 + n}のnの値を任意の数字に書き換えてください。

==各スクリプトの説明とか==
Lyrics
・ChangeLyrics_default2pitch.lua
選択したノートのうちデフォルト歌詞(la)のものをドレミに変更します。
デフォルト歌詞を変更している場合はスクリプトの1行目を変更してください。

Notes
・Change__Notes.lua
選択したノートの長さを__内の数値に変更します。

・Lengthen__Notes.lua
選択したノートの長さを__内の数値分伸ばします。

・Shorten__Notes.lua
選択したノートの長さを__内の数値分縮めます。

Whole:全音符 Half:2分音符 Quarter:4分音符 Eighth:8分音符 Sixteenth:16分音符

Play
・Return2OriginalPosition.lua
再生終了時に再生開始した位置に再生バーを戻します。
再生/終了を共にこのスクリプトを利用して行う必要があります。

・Return2OriginalPosition_Res.lua
上記スクリプトの常駐型です。
通常の再生/終了を検知して再生バーの移動を行うため他のスクリプトと競合すると挙動がおかしくなる可能性があります。


==配布元URL==
https://github.com/Yukikazari/SynthV_scripts

==連絡先==
ゆきかざり
https://twitter.com/hanayuki7793
yukikazari7793@gmail.com (反応怪しめ)