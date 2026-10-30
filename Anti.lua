client = nil
service = nil
Pcall = nil
Routine = nil
GetEnv = nil
origEnv = nil
logError = nil
return function(arg1, callback)
    local env = callback(nil, {script = script})
    setfenv(1, env)
    local _G, game = _G, game
    local script, getfenv = script, getfenv
    local setfenv, workspace = setfenv, workspace
    local getmetatable = getmetatable
    local setmetatable = setmetatable
    local loadstring, coroutine = loadstring, coroutine
    local rawequal = rawequal
    local typeof, print, math, warn = typeof, print, math, warn
    local error, pcall = error, pcall
    local xpcall = xpcall
    local select = select
    local rawset, rawget, ipairs, pairs, next, Rect, Axes, os, time = rawset, rawget, ipairs, pairs, next, Rect, Axes, os, time
    local Faces, unpack, string = Faces, unpack, string
    local Color3, newproxy = Color3, newproxy
    local tostring = tostring
    local tonumber, Instance = tonumber, Instance
    local TweenInfo, BrickColor, NumberRange, ColorSequence, NumberSequence, ColorSequenceKeypoint, NumberSequenceKeypoint, PhysicalProperties, Region3int16, Vector3int16, require, table = TweenInfo, BrickColor, NumberRange, ColorSequence, NumberSequence, ColorSequenceKeypoint, NumberSequenceKeypoint, PhysicalProperties, Region3int16, Vector3int16, require, table
    local type = type
    local wait, Enum = wait, Enum
    local UDim, UDim2, Vector2, Vector3, Region3, CFrame, Ray, delay, only = UDim, UDim2, Vector2, Vector3, Region3, CFrame, Ray, delay, nil
    local v1
    local v2
    local v3
    local service2 = env.service
    local client2 = env.client
    local core = client2.Core
    local remote = client2.Remote
    local functions = client2.Functions
    local disconnect = client2.Disconnect
    local send = client2.Remote.Send
    local get = client2.Remote.Get
    local networkClient = service2.NetworkClient
    local kill = client2.Kill
    local localPlayer = service2.Players.LocalPlayer
    local value = select(2, pcall(service2.RunService.IsStudio, service2.RunService))
    local kick = localPlayer.Kick
    local result = service2.GuiService:IsTenFootInterface()
    local v4 = service2.UserInputService.TouchEnabled and not service2.UserInputService.KeyboardEnabled and not service2.UserInputService.MouseEnabled
    local function Init()
        v2 = client2.UI
        only = client2.Anti
        v3 = client2.Variables
        v1 = client2.Process
        only.Init = nil
    end
    local function RunAfterLoaded()
        service2.Player.Changed:Connect(function()
            if only.RLocked(service2.Player) then
                only.Detected('kick', 'Player is Roblox Locked')
            end
        end)
        only.RunAfterLoaded = nil
    end
    local function RunLast()
        only.RunLast = nil
    end
    getfenv().client = nil
    getfenv().service = nil
    getfenv().script = nil
    local function detected(text, value2, arg3)
        if networkClient and text ~= '_' then
            pcall(send, 'Detected', text, tostring(value2) .. (result and ' - On Xbox' or v4 and ' - On mobile' or ''))
            task.wait(0.5)
            if text == 'kick' and not value then
                if arg3 then
                    localPlayer:Kick(':' .. ':' .. ' ' .. 'A' .. 'd' .. 'o' .. 'n' .. 'i' .. 's' .. ' ' .. 'A' .. 'n' .. 't' .. 'i' .. ' ' .. 'C' .. 'h' .. 'e' .. 'a' .. 't' .. ':' .. ':' .. '\n' .. tostring(value2))
                else
                    disconnect(value2)
                end
            elseif text == 'crash' and not value then
                kill(value2)
            end
        end
        return true
    end
    local v5
    local v6
    local v7
    task.spawn(xpcall, function()
        v5, v6, v7 = debug.info(detected, 'nsl')
    end, function()
        detected('crash', 'Tamper Protection 0xCCD44')
        task.wait(1)
        pcall(disconnect, 'Adonis_0xCCD44')
        pcall(kill, 'Adonis_0xCCD44')
        pcall(kick, localPlayer, 'Adonis_0xCCD44')
    end)
    local function compareTables(list, arg2)
        if service2.CountTable(list) ~= service2.CountTable(arg2) then
            return false
        end
        for k, _ in list do
            if rawequal(list[k], arg2[k]) then
                continue
            end
            return false
        end
        return true
    end
    local object = newproxy(true)
    local metatable = getmetatable(object)
    function metatable.__index()
        detected('kick', 'Proxy metaMethod 0x215F')
        return task.wait(200)
    end
    function metatable.__newindex()
        detected('kick', 'Proxy metaMethod 0x86F1')
        return task.wait(200)
    end
    function metatable.__tostring()
        detected('kick', 'Proxy metaMethod 0xC0BD0')
        return task.wait(200)
    end
    function metatable.__unm()
        detected('kick', 'Proxy metaMethod 0x10F00')
        return task.wait(200)
    end
    function metatable.__add()
        detected('kick', 'Proxy metaMethod 0x60DC3')
        return task.wait(200)
    end
    function metatable.__sub()
        detected('kick', 'Proxy metaMethod 0x90F5D')
        return task.wait(200)
    end
    function metatable.__mul()
        detected('kick', 'Proxy metaMethod 0x19999')
        return task.wait(200)
    end
    function metatable.__div()
        detected('kick', 'Proxy metaMethod 0x1D14AC')
        return task.wait(200)
    end
    function metatable.__mod()
        detected('kick', 'Proxy metaMethod 0x786C64')
        return task.wait(200)
    end
    function metatable.__pow()
        detected('kick', 'Proxy metaMethod 0x1D948C')
        return task.wait(200)
    end
    function metatable.__len()
        detected('kick', 'Proxy metaMethod 0xBE931')
        return task.wait(200)
    end
    metatable.__metatable = 'The metatable is locked'
    local result2 = table.freeze({indexInstance = {}, newindexInstance = {}, namecallInstance = {}, indexEnum = {}, namecallEnum = {}, eqEnum = {}})
    local tbl = {}
    local result3 = service2.UnWrap(game)
    local function checkStack(arg1)
        local v1 = #result2[arg1] <= 0
        for i = 3, 4 do
            local result = debug.info(i, 'f')
            if v1 then
                result2[arg1][i] = result
            elseif result2[arg1][i] ~= result then
                return true
            end
        end
        return false
    end
    local function isMethamethodValid(value)
        if not value or type(value) ~= 'function' or debug.info(value, 's') ~= '[C]' or debug.info(value, 'l') ~= -1 or debug.info(value, 'n') ~= '' or debug.info(value, 'a') ~= 0 then
            return false
        end
        return true
    end
    local result4 = table.freeze({indexInstance = table.freeze({'kick', function()
        local flag = false
        local v1
        local success, result = xpcall(function()
            local _ = result3.____________
        end, function()
            v1 = debug.info(2, 'f')
            if flag or checkStack('indexInstance') then
                flag = true
            end
        end)
        if not isMethamethodValid(v1) then
            return true
        end
        local success2, result2 = pcall(v1, result3)
        local success3, result4 = pcall(v1)
        pcall(v1, object, 'GetChildren')
        pcall(v1, object)
        pcall(v1, result3, object)
        if flag or success or success3 or success2 then
            return true
        end
        if not tbl.indexInstance then
            tbl.indexInstance = {result, result4, result2}
        end
        return not compareTables(tbl.indexInstance, {result, result4, result2})
    end}), newindexInstance = table.freeze({'kick', function()
        local flag = false
        local v1
        local success, result = xpcall(function()
            result3.____________ = 5
        end, function()
            v1 = debug.info(2, 'f')
            if flag or checkStack('newindexInstance') then
                flag = true
            end
        end)
        if not isMethamethodValid(v1) then
            return true
        end
        local success2, result2 = pcall(v1, result3)
        local success3, result4 = pcall(v1)
        pcall(v1, object, 'GetChildren')
        pcall(v1, object)
        pcall(v1, result3, object)
        pcall(v1, result3, 'AllowThirdPartySales', object)
        if flag or success or success3 or success2 then
            return true
        end
        if not tbl.newindexInstance then
            tbl.newindexInstance = {result, result4, result2}
        end
        return not compareTables(tbl.newindexInstance, {result, result4, result2})
    end}), namecallInstance = table.freeze({'kick', function()
        local flag = false
        local v1
        local success, result = xpcall(function()
            local _ = result3:____________()
        end, function()
            v1 = debug.info(2, 'f')
            if flag or checkStack('namecallInstance') then
                flag = true
            end
        end)
        if not isMethamethodValid(v1) then
            return true
        end
        local success2, result2 = pcall(v1, result3)
        local success3, result4 = pcall(v1)
        pcall(v1, object)
        pcall(v1, result3, object)
        if flag or success or success3 or success2 then
            return not value
        end
        if not tbl.namecallInstance then
            tbl.namecallInstance = {result, result4, result2}
        end
        return not compareTables(tbl.namecallInstance, {result, result4, result2}) and not value
    end}), indexEnum = table.freeze({'kick', function()
        local flag = false
        local v1
        local success, result = xpcall(function()
            local _ = Enum.HumanoidStateType.____________
        end, function()
            v1 = debug.info(2, 'f')
            if flag or checkStack('indexEnum') then
                flag = true
            end
        end)
        if not isMethamethodValid(v1) then
            return true
        end
        local success2, result2 = pcall(v1, Enum.HumanoidStateType)
        local success3, result3 = pcall(v1)
        pcall(v1, object, 'Name')
        pcall(v1, object)
        pcall(v1, Enum.HumanoidStateType, object)
        if flag or success or success3 or success2 then
            return true
        end
        if not tbl.indexEnum then
            tbl.indexEnum = {result, result3, result2}
        end
        return not compareTables(tbl.indexEnum, {result, result3, result2})
    end}), namecallEnum = table.freeze({'kick', function()
        local flag = false
        local v1
        local success, result = xpcall(function()
            local _ = Enum.HumanoidStateType:____________()
        end, function()
            v1 = debug.info(2, 'f')
            if flag or checkStack('namecallEnum') then
                flag = true
            end
        end)
        if not isMethamethodValid(v1) then
            return true
        end
        local success2, result2 = pcall(v1, Enum.HumanoidStateType)
        local success3, result3 = pcall(v1)
        pcall(v1, object)
        pcall(v1, Enum.HumanoidStateType, object)
        if flag or success or success3 or success2 then
            return true
        end
        if not tbl.namecallEnum then
            tbl.namecallEnum = {result, result3, result2}
        end
        return not compareTables(tbl.namecallEnum, {result, result3, result2})
    end}), eqEnum = table.freeze({'kick', function()
        return not (Enum.HumanoidStateType.Running == Enum.HumanoidStateType.Running)
    end})})
    local result5 = service2.UnWrap(Instance.new('RemoteEvent'))
    local result6 = service2.UnWrap(Instance.new('RemoteFunction'))
    local result7 = service2.UnWrap(service2.LogService)
    local object2 = setmetatable({}, {__mode = 'k'})
    service2.UnWrap(service2.Players).ChildRemoved:Connect(function(child)
        if child:IsA('Player') then
            object2[child] = true
        end
    end)
    Routine(function()
        while true do
            local v1, v2, v3, v4, v8, v9 = debug.info(detected, 'slanf')
            if v1 ~= v6 or v2 ~= v7 or v8 ~= v5 or v3 ~= 3 or v4 or v9 ~= detected or not detected('_', '_', true) then
                while true do
                end
            end
            for k, v in result4 do
                local first = v[1]
                local second = v[2]
                local success, result = pcall(second)
                if not success or result ~= false and result ~= true then
                    detected('crash', 'Tamper Protection 0xDD42F')
                    task.wait(1)
                    pcall(disconnect, 'Adonis_0xDD42F')
                    pcall(kill, 'Adonis_0xDD42F')
                    pcall(kick, localPlayer, 'Adonis_0xDD42F')
                elseif result then
                    detected(first, `{k} detector detected`)
                end
            end
            local flag = false
            task.spawn(xpcall, function()
                local result = service2.UnWrap(localPlayer)
                local player = service2.UnWrap(workspace)
                local success, result2 = pcall(function()
                    result.Kick(player, 'If this message appears, report it to Adonis maintainers. 0x1')
                end)
                local success2, result4 = pcall(function()
                    player:Kick('If this message appears, report it to Adonis maintainers. 0x2')
                end)
                if success or result2 ~= 'Expected \':\' not \'.\' calling member function Kick' or success2 or (string.match(result4, '^Kick is not a valid member of Workspace "(.+)"$') or '') ~= player:GetFullName() then
                    detected('kick', 'Anti kick found! Method 0x3')
                    warn(success, result2, '|', success2, result4)
                end
                if #service2.Players:GetPlayers() > 1 then
                    local players = service2.Players
                    for _, player2 in service2.Players:GetPlayers() do
                        local player3 = service2.UnWrap(player2)
                        if player3 and not object2[player3] and player3.Parent == players and player3 ~= result then
                            local success3, result5 = pcall(result.Kick, player3, 'If this message appears, report it to Adonis maintainers. 0x2')
                            local success4, result6 = pcall(function()
                                player3:Kick('If this message appears, report it to Adonis maintainers. 0x4')
                            end)
                            if not success3 and result5 == 'Cannot kick a non-local Player from a LocalScript' and not success4 and result6 == 'Cannot kick a non-local Player from a LocalScript' then
                                continue
                            end
                            detected('kick', 'Anti kick found! Method 0x6')
                            warn(success3, result5, '|', success4, result6)
                        end
                    end
                end
                local success5, result7 = pcall(function()
                    result:KicK('If this message appears, report it to Adonis maintainers. 0x5')
                end)
                if success5 or (string.match(result7, '^%a+ is not a valid member of Player "(.+)"$') or '') ~= result:GetFullName() then
                    detected('kick', 'Anti kick found! Method 0x4')
                end
                local success6, result8 = pcall(service2.UnWrap(player).GetRealPhysicsFPS, result3)
                if success6 or not string.match(result8, 'Expected \':\' not \'.\' calling member function GetRealPhysicsFPS') then
                    detected('kick', 'Anti FPS detection found!')
                end
                flag = true
            end, function()
                detected('crash', 'Tamper Protection 0x16E68')
                task.wait(1)
                pcall(disconnect, 'Adonis_0x16E68')
                pcall(kill, 'Adonis_0x16E68')
                pcall(kick, localPlayer, 'Adonis_0x16E68')
            end)
            task.spawn(xpcall, function()
                task.wait(4)
                if not flag then
                    detected('kick', 'Anti kick found! Method 0x3')
                end
            end, function()
                detected('crash', 'Tamper Protection 0x7D2B')
                task.wait(1)
                pcall(disconnect, 'Adonis_0x7D2B')
                pcall(kill, 'Adonis_0x7D2B')
                pcall(kick, localPlayer, 'Adonis_0x7D2B')
            end)
            local flag2 = false
            task.spawn(xpcall, function()
                local remote = service2.UnWrap(workspace)
                local success, result = pcall(function()
                    result7:getlogHistory()
                end)
                local success2, result2 = pcall(function()
                    result7.GetLogHistory(remote)
                end)
                local success3, result3 = pcall(function()
                    remote:GetLogHistory()
                end)
                if success or (string.match(result, '^%a+ is not a valid member of LogService "(.+)"$') or '') ~= result7:GetFullName() or success2 or result2 ~= 'Expected \':\' not \'.\' calling member function GetLogHistory' or success3 or (string.match(result3, '^GetLogHistory is not a valid member of Workspace "(.+)"$') or '') ~= remote:GetFullName() then
                    detected('kick', '0x7D3C GetLogHistory function hooks detected')
                end
                local success4, result4 = pcall(function()
                    result5:fireserver()
                end)
                local success5, result8 = pcall(function()
                    result5.FireServer(remote)
                end)
                local success6, result9 = pcall(function()
                    remote:FireServer()
                end)
                if success4 or (string.match(result4, '^%a+ is not a valid member of RemoteEvent "(.+)"$') or '') ~= result5:GetFullName() or success5 or result8 ~= 'Expected \':\' not \'.\' calling member function FireServer' or success6 or (string.match(result9, '^FireServer is not a valid member of Workspace "(.+)"$') or '') ~= remote:GetFullName() then
                    detected('kick', 'FireServer function hooks detected')
                end
                pcall(result5.FireServer, object, object)
                local success7, result10 = pcall(function()
                    result6:invokeserver()
                end)
                local success8, result11 = pcall(function()
                    result6.InvokeServer(remote)
                end)
                local success9, result12 = pcall(function()
                    remote:InvokeServer()
                end)
                if success7 or (string.match(result10, '^%a+ is not a valid member of RemoteFunction "(.+)"$') or '') ~= result6:GetFullName() or success8 or result11 ~= 'Expected \':\' not \'.\' calling member function InvokeServer' or success9 or (string.match(result12, '^InvokeServer is not a valid member of Workspace "(.+)"$') or '') ~= remote:GetFullName() then
                    detected('kick', 'InvokeServer function hooks detected')
                end
                pcall(result6.InvokeServer, object, result5)
                flag2 = true
            end, function()
                detected('crash', 'Tamper Protection 0xB3EB')
                task.wait(1)
                pcall(disconnect, 'Adonis_0xB3EB')
                pcall(kill, 'Adonis_0xB3EB')
                pcall(kick, localPlayer, 'Adonis_0xB3EB')
            end)
            task.spawn(xpcall, function()
                task.wait(4)
                if not flag2 then
                    detected('kick', 'Remote and/or logservice spoofcheck failed')
                end
            end, function()
                detected('crash', 'Tamper Protection 0x33E0')
                task.wait(1)
                pcall(disconnect, 'Adonis_0x33E0')
                pcall(kill, 'Adonis_0x33E0')
                pcall(kick, localPlayer, 'Adonis_0x33E0')
            end)
            task.wait(5)
        end
    end)
    local function launch(arg1, arg2)
        if only.Detectors[arg1] and service2.NetworkClient then
            only.Detectors[arg1](arg2)
        end
    end
    local __index = {}
    only = service2.ReadOnly({Init = Init, RunLast = RunLast, RunAfterLoaded = RunAfterLoaded, Launch = launch, Detected = detected, Detectors = service2.ReadOnly(setmetatable({}, {__index = __index}), false, true), AddDetector = function(arg1, arg2)
        if not __index[arg1] then
            __index[arg1] = arg2
        end
    end, RLocked = function(arg1)
        return not pcall(function()
            return arg1.GetFullName(arg1)
        end)
    end}, {Init = true, RunLast = true, RunAfterLoaded = true}, true)
    client2.Anti = only
    local metaFunc = service2.MetaFunc
    local callback2 = metaFunc(service2.TrackTask)
    local callback3 = metaFunc(pcall)
    local callback4 = metaFunc(task.wait)
    local _ = metaFunc(time)
    callback2('Thread: TableCheck', metaFunc(function()
        while callback4(1) do
            local success, value, v1, v2, v3, v4, v5, v6, v7, v8 = coroutine.resume(coroutine.create(function()
                return client2.Core, client2.Remote, client2.Functions, client2.Anti, client2.Remote.Send, client2.Remote.Get, client2.Anti.Detected, client2.Disconnect, client2.Kill
            end))
            if success and value == core and v1 == remote and v2 == functions and v3 == only and v4 == send and v5 == get and v6 == detected and v7 == disconnect and v8 == kill then
                continue
            end
            callback3(detected, 'crash', 'Tamper Protection 0x273A')
            callback4(1)
            callback3(disconnect, 'Adonis_0x273A')
            callback3(kill, 'Adonis_0x273A')
            callback3(kick, localPlayer, 'Adonis_0x273A')
        end
    end))
end