QUARTER = 705600000
isDuration = QUARTER

--[[
motiontype 0 : 複数ノート選択時に位置を保持する
motiontype 1 : 複数ノート選択時に生じた間隔を埋める
]]
motiontype = 1

function getClientInfo()
    return {
      name = SV:T("Shorten Quarter Notes"),
      category = "Notes",
      author = "Yukikazari",
      versionNumber = 1,
      minEditorVersion = 65540
    }
end

function getTranslations(langCode)
    if langCode == "ja-jp" then
        return {
            {"Shorten Quarter Notes", "4分音符分縮める"}
        }
    end
    return {}
end

function main()
    local TrackInnerSelectionState = SV:getMainEditor():getSelection()
    local Notes = TrackInnerSelectionState:getSelectedNotes()

    if #Notes == 1 then
        local Note = Notes[1]
        if Note:getDuration() > isDuration then
            Note:setDuration(Note:getDuration() - isDuration)
        end

    elseif #Notes > 1 then
        if motiontype == 0 then  
            for i, Note in ipairs(Notes) do
                if Note:getDuration() > isDuration then
                    Note:setDuration(Note:getDuration() - isDuration)
                end
            end

        else
            local count = 0
            for i, Note in ipairs(Notes) do
                    Note:setOnset(Note:getOnset() - isDuration * count)                
                if Note:getDuration() > isDuration then
                    Note:setDuration(Note:getDuration() - isDuration)
                    count = count + 1
                end
            end
        end
    end
    SV:finish()
end
