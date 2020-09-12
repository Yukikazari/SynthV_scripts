QUARTER = 705600000
isDuration = QUARTER / 2

--[[
motiontype 0 : 複数ノート選択時に間隔を保持する
motiontype 1 : 複数ノート選択時に間隔をなるべく埋める
]]
motiontype = 0

function getClientInfo()
    return {
      name = SV:T("Lengthen Eighth Notes"),
      category = "Notes",
      author = "Yukikazari",
      versionNumber = 1,
      minEditorVersion = 2^16 + 8
    }
end

function getTranslations(langCode)
    if langCode == "ja-jp" then
        return {
            {"Lengthen Eighth Notes", "8分音符分伸ばす"}
        }
    end
    return {}
end

function main()
    local TrackInnerSelectionState = SV:getMainEditor():getSelection()
    local Notes = TrackInnerSelectionState:getSelectedNotes()

    if #Notes == 1 then
        local Note = Notes[1]
        Note:setDuration(Note:getDuration() + isDuration)

    elseif #Notes > 1 then
        if motiontype == 0 then
            local extention = 0            
            for i, Note in ipairs(Notes) do
                local duration = Note:getDuration()
                Note:setOnset(Note:getOnset() + extention)
                Note:setDuration(duration + isDuration)
                extention = extention + isDuration
            end

        else
            local isOnset = Notes[1]:getOnset()
            for i, Note in ipairs(Notes) do
                local duration = Note:getDuration()
                Note:setOnset(isOnset)
                Note:setDuration(duration + isDuration)
                if i ~= #Notes then
                    local nextOnset = Notes[i+1]:getOnset()
                    if isOnset + duration + isDuration > nextOnset then
                        isOnset = isOnset + duration + isDuration
                    else
                        isOnset = nextOnset
                    end
                end
            end
        end
    end

    SV:finish()
end
