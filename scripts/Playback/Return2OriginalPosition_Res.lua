settings = {
    -- コールバック待機時間(ms)    
    waittime = 100,

    -- 動作開始時のメッセージウィンドウの表示 false:非表示 true:表示
    messagetype = true
}

function getClientInfo()
    return {
      name = SV:T("[Resident] Return to Original Position"),
      category = "Play",
      author = "Yukikazari",
      versionNumber = 1,
      minEditorVersion = 2 ^ 16 + 8
    }
end

function getTranslations(langCode)
    if langCode == "ja-jp" then
        return {
            {"[Resident] Return to Original Position", "再生後元の位置に戻る 常駐型"},
            {"Script : ON", "スクリプトを開始しました"}
        }
    end
end

posdata = {
    playhead = 0,
    prop = 0
}

getStatus = function()
    local playback = SV:getPlayback()
    local playhead = playback:getPlayhead()
    local status = playback:getStatus()

    local me = SV:getMainEditor()
    local nav = me:getNavigation()
    local viewrange = nav:getTimeViewRange()

    return {
        playhead = function(self) return playhead end,
        status = function(self) return status end,
        navigation = function(self) return nav end,
        lview = function(self) return viewrange[1] end,
        rview = function(self) return viewrange[2] end,
        viewrange = function(self) return viewrange[2] - viewrange[1] end
    }
end

function convProp(obj)
    -- ブリック
    local range = obj:viewrange()
    -- 秒
    local splayhead = obj:playhead()
    -- ブリック
    local bplayhead = TimeAxis:getBlickFromSeconds(splayhead)
    -- ブリック
    local lrange = obj:lview()
    local rrange = obj:rview()
    -- playheadより左側の割合
    local res = (bplayhead - lrange) / range

    if lrange <= bplayhead and bplayhead <= rrange then
        return res
    else
        return 0.5
    end
end

function returnPosition(obj)
    -- ブリック
    local range = obj:viewrange()
    -- 秒
    local splayhead = posdata["playhead"]
    -- ブリック
    local bplayhead = TimeAxis:getBlickFromSeconds(splayhead)
    -- ブリック
    local lview = bplayhead - range * posdata["prop"]

    local pb = SV:getPlayback()
    pb:seek(splayhead)
    pb:stop()

    local nav = SV:getMainEditor():getNavigation()
    nav:setTimeLeft(lview)
    return
end

function main()
    if settings["messagetype"] then
        SV:showMessageBox(SV:T("Return to Original Position"), SV:T("Script : ON"))
    end

    local pj = SV:getProject()
    TimeAxis = pj:getTimeAxis()

    local nowplaying = false

    local obj = getStatus()
    if obj:status() == "looping" then
        SV:finish()
        return
    elseif obj:status() == "playing" then
        nowplaying = true
    end

    local nowdata = obj
    local tmp = 0
    func = function()
        tmp = tmp + 1
        local obj = getStatus()
        if obj:status() == "stopped" then
            if nowplaying then
                returnPosition(obj)
                nowplaying = false
            else
                nowdata = obj
            end
        elseif obj:status() == "playing" then
            if not nowplaying then
                posdata["playhead"] = nowdata:playhead()
                posdata["prop"] = convProp(nowdata)
                nowplaying = true
            end
        else
            SV:finish()
            return
        end
        SV:setTimeout(settings["waittime"], func)
    end
    func()
end
