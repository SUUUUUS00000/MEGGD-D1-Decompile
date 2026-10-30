server = nil
service = nil
Routine = nil
GetEnv = nil
origEnv = nil
logError = nil
return function(arg1, callback)
    local env = callback(nil, {script = script})
    setfenv(1, env)
    local server2 = arg1.Server
    local service2 = arg1.Service
    local counts = {}
    local v1 = os.clock() + 60
    local v2
    local v3
    local v4
    local v5
    local v6
    local v7
    local v8
    local v9
    local v10
    local v11
    local function Init()
        v2 = server2.Functions
        v3 = server2.Admin
        v4 = server2.Anti
        v5 = server2.Core
        v6 = server2.HTTP
        v7 = server2.Logs
        v8 = server2.Remote
        v9 = server2.Process
        v10 = server2.Variables
        v11 = server2.Settings
        service2.StartLoop('ClientCheck', 30, v4.CheckAllClients, true)
        v4.Init = nil
        v7:AddLog('Script', 'AntiExploit Module Initialized')
    end
    local function RunAfterPlugins(arg1)
        v4.RunAfterPlugins = nil
        v7:AddLog('Script', 'Anti Module RunAfterPlugins Finished')
    end
    server2.Anti = {Init = Init, RunAfterPlugins = RunAfterPlugins, ClientTimeoutLimit = 300, SpoofCheckCache = {}, KickedPlayers = setmetatable({}, {__mode = 'k'}), RemovePlayer = function(instance, desc)
        desc = tostring(desc) or 'No Reason Given'
        if service2.RunService:IsStudio() then
            warn(`:: Adonis Anti Cheat :: Anticheat triggered for {instance.Name}, not kicking because in studio; {desc}`)
            return
        end
        pcall(function()
            service2.UnWrap(instance):Kick(`:: Adonis Anti Cheat :: {desc}`)
        end)
        task.wait(1)
        pcall(instance.Destroy, instance)
        pcall(service2.Delete, instance)
        v7.AddLog('Script', {Text = `Server removed {instance}`, Desc = desc})
    end, CheckAllClients = function()
        if v11.CheckClients and server2.Running then
            v7.AddLog(v7.Script, {Text = 'Checking Clients', Desc = 'Making sure all clients are active'})
            for _, player in service2.Players:GetPlayers() do
                if player and player:IsA('Player') then
                    local text = tostring(player.UserId)
                    local client = v8.Clients[text]
                    if client and client.LastUpdate and client.PlayerLoaded and os.time() - client.LastUpdate > v4.ClientTimeoutLimit then
                        v4.Detected(player, 'Kick', `Client Not Responding [>{v4.ClientTimeoutLimit} seconds]`)
                    end
                end
            end
        end
    end, UserSpoofCheck = function(player)
        if not service2.RunService:IsStudio() then
            local userService = service2.UserService
            local success, result = pcall(function()
                local playerData = v4.SpoofCheckCache[player.UserId] or userService:GetUserInfosByUserIdsAsync({player.UserId})
                local player2 = playerData and playerData[1]
                v4.SpoofCheckCache[player.UserId] = playerData
                if player2 and player2.Id == player.UserId then
                    if player.Name ~= player2.Username or player.DisplayName ~= player2.DisplayName then
                        return true
                    end
                else
                    for _, v in playerData do
                        if v.Id == player.UserId and (player.Name ~= v.Username or player.DisplayName ~= v.DisplayName) then
                            return true
                        end
                    end
                end
            end)
            if not success then
                warn(`Failed to check validity of player's name, reason: {result}`)
            end
        end
    end, CheckBackpack = function(parent, name)
        local success, result = pcall(function()
            return parent:WaitForChild('Backpack', 60):FindFirstChild(name)
        end)
        return success or false
    end, Detected = function(player, text, value)
        local substring = string.sub(string.gsub(tostring(value), '\n', ''), 1, 50)
        if v4.KickedPlayers[player] then
            player:Kick(`:: Adonis Anti Cheat ::\n{substring}`)
            return
        end
        if service2.RunService:IsStudio() then
            warn(`ANTI-EXPLOIT: {player.Name} {text} {substring}`)
        elseif service2.NetworkServer and player then
            if string.lower(text) == 'kick' then
                v4.KickedPlayers[player] = true
                v4.RemovePlayer(player, substring)
            elseif string.lower(text) == 'kill' and player.Character then
                local humanoid = player.Character:FindFirstChildOfClass('Humanoid')
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Dead)
                    humanoid.Health = 0
                end
                player.Character:BreakJoints()
            elseif string.lower(text) == 'crash' then
                v4.KickedPlayers[player] = true
                v8.Send(player, 'Function', 'Kill')
                v8.Clients[tostring(player.UserId)] = nil
                task.wait(5)
                pcall(function()
                    local script2 = v5.NewScript('LocalScript', 'while true do end')
                    script2.Parent = player.Backpack
                    script2.Disabled = false
                end)
                v4.RemovePlayer(player, substring)
            elseif string.lower(text) ~= 'log' then
                v4.Detected(player, 'Kick', 'Spoofed log')
                return
            end
        end
        v7.AddLog(v7.Script, {Text = `AE Detected {player}`, Desc = `The Anti-Exploit system detected strange activity from {player}`, Player = player})
        v7.AddLog(v7.Exploit, {Text = `[Action: {text} User: ({player})] {string.sub(substring, 1, 50)} (Mouse over for full info)`, Desc = tostring(substring), Player = player})
        if v11.AENotifs == true or v11.ExploitNotifications == true then
            local text2 = `{text}{player}{substring}`
            if os.clock() > v1 then
                counts = {}
                v1 = os.clock() + 60
            end
            if not counts[text2] then
                counts[text2] = 1
            elseif (string.lower(text) == 'log' or string.lower(text) == 'kill') and counts[text2] > 3 then
                return
            end
            counts[text2] += 1
            for _, player2 in service2.Players:GetPlayers() do
                if v3.GetLevel(player2) >= v11.Ranks.Moderators.Level then
                    v2.Notification('Notification', string.format('%s was detected for exploiting, action: %s info: %s  (See exploitlogs for full info)', player.Name, text, string.sub(substring, 1, 50)), {player2}, 30, 'MatIcon://Notification important', v5.Bytecode(`client.Remote.Send('ProcessCommand','{v11.Prefix}exploitlogs')`))
                end
            end
        end
    end}
end