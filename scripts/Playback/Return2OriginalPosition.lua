function getClientInfo()
    return {
      name = SV:T("Return to Original Position"),
      category = "Playback",
      author = "Yukikazari",
      versionNumber = 1.2,
      minEditorVersion = 2^16 + 8
    }
end

function getTranslations(langCode)
    if langCode == "ja-jp" then
        return {
            {"Return to Original Position", "再生後元の位置に戻る"}
        }
    end
end

function readfile()
    local f = io.open("seek.txt", "r")
    local a = {}
    for line in f:lines() do
        a[#a + 1] = line
    end

    if #a ~= 2 then
        a[2] = a[1]
    end

    return a
end

function convstarttime(prop, splaystart)
    local bplaystart = TimeAxis:getBlickFromSeconds(splaystart)
    local range = viewrange[2] - viewrange[1]
    local res = bplaystart - range * prop
    return res
end

function convprop(splaystart)
    local bplaystart = TimeAxis:getBlickFromSeconds(splaystart)
    local range = viewrange[2] - viewrange[1]
    local res = (bplaystart - viewrange[1]) / range
    return res
end

function main()
    local pb = SV:getPlayback()
    local status = pb:getStatus()

    local mv = SV:getMainEditor()
    local mvcs = mv:getNavigation()
    viewrange = mvcs:getTimeViewRange()

    local pj = SV:getProject()
    TimeAxis = pj:getTimeAxis()

    if status == "stopped" then
        local playstart = pb:getPlayhead()
        local prop = convprop(playstart)

        f = io.open("seek.txt", "w")
        f:write(playstart.."\n")
        f:write(prop)
        f:close()

        pb:play()
    else
        local playstart = 0
        local screenstart = 0
        local stat, ret = pcall(readfile)
        if stat then
            playstart = ret[1]
            screenstart = convstarttime(ret[2], playstart)
        end

        pb:seek(playstart)
        pb:pause()

        mvcs:setTimeLeft(screenstart)
    end
    SV:finish()
end
