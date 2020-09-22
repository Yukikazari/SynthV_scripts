-- デフォルト歌詞の設定
defaultlyrics = "la"
setdefaultlyrics = "la"

motiontype = {}

--[[
    motiontype[1]: ノート追加場所
    0: メインノートグループの後ろ
    1: トラックの一番後ろ
]]
motiontype[1] = 1

Q = SV.QUARTER

function getClientInfo()
    return {
      name = SV:T("Move Back Lyrics"),
      category = "Lyrics",
      author = "Yukikazari",
      versionNumber = 1,
      minEditorVersion = 0x010008
    }
end

function getTranslations(langCode)
    if langCode == "ja-jp" then
        return {
            {"Move Back Lyrics", "歌詞を後ろに移動する"},
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

    for i=nidx, maxnidx do
        lyrics[#lyrics+1] = NG:getNote(i):getLyrics()
    end

    local ly = setdefaultlyrics
    for i = 1, #Notes do
        Notes[i]:setLyrics(ly)
    end
    
    nidx = nidx + #Notes
    local i = 1
    local jump = 0

    local last = NG:getNote(NG:getNumNotes()):getEnd()

    if motiontype[1] == 1 and Track:getNumGroups() > 1 then
        for i=2, Track:getNumGroups() do
            local l = Track:getGroupReference(i):getEnd()
            if l > last then
                last = l
            end
        end
    end

    while i <= #lyrics do
        if lyrics[i] ~= defaultlyrics or i <= #Notes then
            if nidx <= maxnidx then
                NG:getNote(nidx):setLyrics(lyrics[i])
            else
                local note = SV:create("Note")
                note:setTimeRange(last, Q)
                note:setLyrics(lyrics[i])
                note:setPitch(60)
                NG:addNote(note)

                last = last + Q
            end
            nidx = nidx + 1
        else
            jump = jump + 1
        end
        i = i + 1

        if jump >= #Notes then
            break
        end
    end

    SV:finish()
end