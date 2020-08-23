

function getClientInfo()
    return {
      name = SV:T("Change Whole Note"),
      category = "Notes",
      author = "Yukikazari",
      versionNumber = 1,
      minEditorVersion = 65540
    }
end

function getTranslations(langCode)
    if langCode == "ja-jp" then
        return {
            {"Change Whole Note", "全音符にする"}
        }
    end
end

function main()
    local TrackInnerSelectionState = SV:getMainEditor():getSelection()
    local Notes = TrackInnerSelectionState:getSelectedNotes()

    SV:showMessageBox(#Note, Notes[1])
    

    SV:finish()
end
