defaultlyrics = "la"

function getClientInfo()
    return {
      name = "歌詞をどれみにするやつ",
      category = "Lyrics",
      author = "Yukikazari",
      versionNumber = 1,
      minEditorVersion = 2^16 + 8
    }
end

function pitch2lyrics(Pitch)
  local num = Pitch % 12
  local Lyrics = ""
  if num == 0 or num == 1 then
    Lyrics = "ど"
  elseif num == 2 or num == 3 then
    Lyrics = "れ"
  elseif num == 4 then
    Lyrics = "み"
  elseif num == 5 or num == 6 then
    Lyrics = "ふぁ"
  elseif num == 7 or num == 8 then
    Lyrics = "そ"
  elseif num == 9 or num == 10 then
    Lyrics = "ら"
  else
    Lyrics = "し"
  end
  return Lyrics
end

function convLyrics(Lyrics, Pitch)
  if Lyrics == defaultlyrics then
    Lyrics = pitch2lyrics(Pitch)
    result = result + 1
  end
  return Lyrics
end

function main()
  result = 0
  local Track = SV:getMainEditor():getCurrentTrack()
  local CloneTrack = Track:clone()
  local NumGroups = Track:getNumGroups()
  for i=1, NumGroups do
    local GroupReference = Track:getGroupReference(i)
    local NoteGroup = GroupReference:getTarget()
    local NumNotes = NoteGroup:getNumNotes()
    for j=1, NumNotes do
      local Note = NoteGroup:getNote(j)
      local Lyrics = Note:getLyrics()
      local Pitch = Note:getPitch()
      Lyrics = convLyrics(Lyrics, Pitch)
      Note:setLyrics(Lyrics)
    end
  end
  SV:showMessageBox("result", result.."個のノートを変更しました")
  SV:finish()
end
