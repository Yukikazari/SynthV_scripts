QUARTER = 705600000
isDuration = QUARTER / 4

function getClientInfo()
    return {
      name = SV:T("Change Sixteenth Notes"),
      category = "Notes",
      author = "Yukikazari",
      versionNumber = 1,
      minEditorVersion = 65540
    }
end

function getTranslations(langCode)
    if langCode == "ja-jp" then
        return {
            {"Change Sixteenth Notes", "16分音符にする"}
        }
    end
    return {}
end

function main()
    local TrackInnerSelectionState = SV:getMainEditor():getSelection()
    local Notes = TrackInnerSelectionState:getSelectedNotes()

    if #Notes == 1 then
        local Note = Notes[1]
        Note:setDuration(isDuration)
    elseif #Notes > 1 then
        local extention = 0
        for i, Note in ipairs(Notes) do
            local duration = Note:getDuration()
            Note:setOnset(Note:getOnset() + extention)
            Note:setDuration(isDuration)
            extention = extention + isDuration - duration
        end
    end

    SV:finish()
end
