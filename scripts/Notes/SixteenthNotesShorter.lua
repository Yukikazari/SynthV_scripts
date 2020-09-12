QUARTER = 705600000
isDuration = QUARTER / 4

-- motiontype[1]と[2]は両方同じ数値にした方が使いやすいと思います
motiontype = {}
--[[
motiontype[1] 0 : 複数ノート選択時に位置を保持する
motiontype[1] 1 : 複数ノート選択時に生じた間隔を埋める

LengthenSixteenthNotes.luaと逆にするのがおすすめです
]]
motiontype[1] = 1

--[[
motiontype[2] 0 : 何もしない
motiontype[2] 1 : 同じフレーズに含まれるノートの位置を調整する

LengthenSixteenthNotes.luaと同じにするのがおすすめです
]]
motiontype[2] = 1

--[[
motiontype[3] 0 : 何もしない
motiontype[2] 1 : 選択範囲、または同じフレーズ内に含まれるノートグループの位置を調節する

好みによります。スクリプトによるノートグループの移動はctrl+Zなどで戻せないので注意してください。
]]
motiontype[3] = 1

function getClientInfo()
    return {
      name = SV:T("Sixteenth Notes Shorter"),
      category = "Notes",
      author = "Yukikazari",
      versionNumber = 1,
      minEditorVersion = 2^16 + 8
    }
end

function getTranslations(langCode)
    if langCode == "ja-jp" then
        return {
            {"Sixteenth Notes Shorter", "16分音符分縮める"}
        }
    end
    return {}
end

function getGroups()
    --[[
        現在のトラックに含まれるMainGroup以外のノートのリストを取得します。

        return : NoteGroupReferences (array)
    ]]
    local NoteGroupReferences = {}
    local NoteGroupsNum = Track:getNumGroups()

    if NoteGroupsNum > 1 then
        for i=1, NoteGroupsNum-1 do
            NoteGroupReferences[i] = Track:getGroupReference(i+1)
        end
    end
    return NoteGroupReferences
end

function getTargetNote(Note)
    --[[
        対象のノートのMainGroupにおけるindexを取得します。
        param : Note (object)
        return : index (number)
    ]]
    local MainNoteGroup = Track:getGroupReference(1):getTarget()
    local MainNoteGroupNumNotes = MainNoteGroup:getNumNotes()
    local targetOnset = Note:getOnset()
    local targetNoteindex = -1

    -- Onsetを参照しindexを取得する
    for i=1, MainNoteGroupNumNotes do
        if MainNoteGroup:getNote(i):getOnset() == targetOnset then
            targetNoteindex = i
            break
        end
    end

    -- 同じOnsetに複数のノートがあった場合に5個先までのノートを探索する
    if MainNoteGroup:getNote(targetNoteindex) ~= Note then
        for i=1, math.min(5, MainNoteGroupNumNotes - targetNoteindex) do
            if MainNoteGroup:getNote(targetNoteindex + i) == Note then
                targetNoteindex = targetNoteindex + i
                break
            end
        end
    end

    if targetNoteindex == -1 then
        return 1
    end

    return targetNoteindex

end

function getNearNoteGroupindex(Note, NoteGroupReferences)
    --[[
        対象のノートより前にある最も近いノートグループのindexを取得します。
        そのようなノートグループが存在しない場合はindexとしてノートグループの数を返します。
        param : Note (object)
                NoteGroupReferences (object)

        return : index (number)
    ]]
    local starttiming = Note:getOnset()
    local lastNoteGroupindex = -1

    for i=1, #NoteGroupReferences do
        local t_st = NoteGroupReferences[i]:getOnset()
        if t_st >= starttiming then
            lastNoteGroupindex = i - 1
            break
        end
    end

    if lastNoteGroupindex == -1 then
        return #NoteGroupReferences
    end

    return lastNoteGroupindex
end

function main()
    TrackInnerSelectionState = SV:getMainEditor():getSelection()
    Track = SV:getMainEditor():getCurrentTrack()
    Notes = TrackInnerSelectionState:getSelectedNotes()

    local backNotes = {}
    local backNoteGroupReferences = {}

    -- motiontype[2]==1の場合のみ
    if (#Notes > 0) and (motiontype[2] == 1) then
        local Note = Notes[#Notes]

        -- ノートグループの取得 getGroupReference(1)はメインノートグループ
        local NoteGroupReferences = getGroups(Track)

        local MainNoteGroup = Track:getGroupReference(1):getTarget()
        local MainNoteGroupNumNotes = MainNoteGroup:getNumNotes()

        -- 最終ノートのindexを取得
        local lastNoteindex = getTargetNote(Note)
        
        -- 始点ノートより手前にある最も近いノートグループのindexを取得
        local lastNoteGroupindex = getNearNoteGroupindex(Notes[1], NoteGroupReferences)

        local starttiming = Notes[1]:getOnset()
        local lasttiming = Note:getOnset() + Note:getDuration()

        local isNext = true

        -- 選択している範囲と接しているノートとノートグループを取得
        while isNext do
            isNext = false
            t_lastNoteindex = lastNoteindex
            t_lastNoteGroupindex = lastNoteGroupindex

            while t_lastNoteindex < MainNoteGroupNumNotes do
                local tNote = MainNoteGroup:getNote(t_lastNoteindex + 1)
                if tNote:getOnset() <= lasttiming and tNote:getOnset() >= starttiming then
                    backNotes[#backNotes + 1] = tNote
                    t_lastNoteindex = t_lastNoteindex + 1
                    lastNoteindex = t_lastNoteindex
                    lasttiming = math.max(lasttiming, tNote:getOnset() + tNote:getDuration())
                    isNext = true
                else
                    break
                end
            end
            
            while t_lastNoteGroupindex < #NoteGroupReferences do
                local tNoteGroupReference = NoteGroupReferences[t_lastNoteGroupindex + 1]
                if tNoteGroupReference:getOnset() <= lasttiming and tNoteGroupReference:getOnset() >= starttiming then
                    backNoteGroupReferences[#backNoteGroupReferences + 1] = tNoteGroupReference
                    t_lastNoteGroupindex = t_lastNoteGroupindex + 1
                    lastNoteGroupindex = t_lastNoteGroupindex
                    lasttiming = math.max(lasttiming, tNoteGroupReference:getEnd())
                    isNext = true
                else
                    break
                end
            end
        end
    end

    local count = 0
    local onsets = {}

    if #Notes == 1 then
        local Note = Notes[1]
        if Note:getDuration() > isDuration then
            Note:setDuration(Note:getDuration() - isDuration)
            count = 1
        end

    elseif #Notes > 1 then
        for i, Note in ipairs(Notes) do
            t_Onset = Note:getOnset()
            if motiontype[1] == 1 then
                Note:setOnset(t_Onset - isDuration * count)
            end
            if Note:getDuration() > isDuration then
                Note:setDuration(Note:getDuration() - isDuration)
                count = count + 1
            end
            onsets[#onsets + 1] = {o = t_Onset, c = count}
        end
    end

    if (#Notes > 0) and (motiontype[2] == 1) then
        --[[
        @param{array} backNotes
        @param{array} backNoteGroupReferences
        ]]
        for i=1, #backNotes do
            backNotes[i]:setOnset(backNotes[i]:getOnset() - isDuration * count)
        end

        local lastonsetindex = 1

        if motiontype[3] == 1 then
            for i=1, #backNoteGroupReferences do
                local t_Onset = backNoteGroupReferences[i]:getOnset()
                for i=lastonsetindex, #onsets do
                    if onsets[i]["o"] > t_Onset then
                        count = onsets[i - 1]["c"]
                        lastonsetindex = i
                        break
                    end
                end
                backNoteGroupReferences[i]:setTimeOffset(backNoteGroupReferences[i]:getTimeOffset() - isDuration * count)
            end
        end
    end

    SV:finish()
end
