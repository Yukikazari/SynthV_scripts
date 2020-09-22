-- デフォルト歌詞の設定
defaultlyrics = "la"
setdefaultlyrics = "la"

motiontype = {}

--[[
    motiontype[1]: ノートの選択方法
    0: 不要な歌詞が含まれるノートを選択する
    1: 残す歌詞の先頭を選択する
]]
motiontype[1] = 0

Q = SV.QUARTER

function getClientInfo()
    return {
      name = SV:T("Move Front Lyrics"),
      category = "Lyrics",
      author = "Yukikazari",
      versionNumber = 1,
      minEditorVersion = 0x010008
    }
end

function getTranslations(langCode)
    if langCode == "ja-jp" then
        return {
            {"Move Front Lyrics", "歌詞を手前に移動する"},
            {"error", "エラー"},
            {"selected note couldn't find out in Track", "選択されたノートがトラック上で見つかりません"}
        }
    end
end

function getVowel()
    --[[
        直前の母音拾って設定する歌詞変更しようと思ったけど
        これいる？ってなったので必要そうなら作る
    ]]
end

function main()
    Project = SV:getProject()
    MV = SV:getMainEditor()
    Track = MV:getCurrentTrack()
    local TSS = MV:getSelection()
    local Notes = TSS:getSelectedNotes()

    if #Notes == 0 then
        SV:finish()
        return
    end

    local nOnset = Notes[1]:getOnset()
    local nidx = -1
    local NG = Track:getGroupReference(1):getTarget()    
    local maxnidx = NG:getNumNotes()

    for i = 1, maxnidx do
        if NG:getNote(i):getOnset() == nOnset then
            nidx = i
            break
        end
    end

    if nidx == -1 then
        SV:showMessageBox(SV:T("error"), SV:T("selected note couldn't find out in Track"))
        SV:finish()
        return
    end

    local lyrics = {}

    if motiontype[1] == 0 then
        nidx = nidx + #Notes
    end

    for i=nidx, maxnidx do
        lyrics[#lyrics+1] = NG:getNote(i):getLyrics()
    end

    nidx = math.max(nidx - #Notes, 1)

    for i = 1, #lyrics do
        NG:getNote(nidx):setLyrics(lyrics[i])
        nidx = nidx + 1
    end

    for i = nidx, maxnidx do
        NG:getNote(i):setLyrics(defaultlyrics)
    end

    SV:finish()
end