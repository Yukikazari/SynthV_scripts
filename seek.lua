function getClientInfo()
    return {
      name = "seek",
      category = "Play",
      author = "Yukikazari",
      versionNumber = 1,
      minEditorVersion = 65540
    }
end

function readfile()
    f = io.open("seek.txt", "r")
    for line in f:lines() do
        st = line
    end
    return st
end

function main()
    local st = 0
    local stat, ret = pcall(readfile)
    if stat then
        st = ret
    end

    pb = SV:getPlayback()
    status = pb:getStatus()

    if status == "stopped" then
        local sttm = pb:getPlayhead()
        f = io.open("seek.txt", "w")
        f:write(sttm)
        f:close()

        pb:play()
    else
        pb:seek(st)
        pb:pause()
    end
    SV:finish()
end