if IY_LOADED and not _G.IY_DEBUG then
    return
end
pcall(function()
    getgenv().IY_LOADED = true
end)
if not game:IsLoaded() then
    game.Loaded:Wait()
end
missing = function(arg1, value, arg3)
    if type(value) == arg1 then
        return value
    end
    return arg3
end
cloneref = missing('function', cloneref, function(...)
    return ...
end)
gethui = missing('function', gethui or get_hidden_gui)
syn = missing('table', syn)
syn_protect_gui = missing('function', syn and syn.protect_gui)
sethidden = missing('function', sethiddenproperty or set_hidden_property or set_hidden_prop)
gethidden = missing('function', gethiddenproperty or get_hidden_property or get_hidden_prop)
queueteleport = missing('function', queue_on_teleport or syn and syn.queue_on_teleport or fluxus and fluxus.queue_on_teleport)
httprequest = missing('function', request or http_request or syn and syn.request or http and http.request or fluxus and fluxus.request)
everyClipboard = missing('function', setclipboard or toclipboard or set_clipboard or Clipboard and Clipboard.set)
firetouchinterest = missing('function', firetouchinterest)
waxwritefile, waxreadfile = writefile, readfile
writefile = missing('function', waxwritefile) and function(arg1, arg2, flag)
    if flag == true then
        return pcall(waxwritefile, arg1, arg2)
    end
    waxwritefile(arg1, arg2)
end
readfile = missing('function', waxreadfile) and function(arg1, flag)
    if flag == true then
        return pcall(waxreadfile, arg1)
    end
    return waxreadfile(arg1)
end
isfile = missing('function', isfile, readfile and function(arg1)
    local success, result = pcall(function()
        return readfile(arg1)
    end)
    return success and result ~= nil and result ~= ''
end)
makefolder = missing('function', makefolder)
isfolder = missing('function', isfolder)
waxgetcustomasset = missing('function', getcustomasset or getsynasset)
hookfunction = missing('function', hookfunction)
hookmetamethod = missing('function', hookmetamethod)
getnamecallmethod = missing('function', getnamecallmethod or get_namecall_method)
checkcaller = missing('function', checkcaller, function()
    return false
end)
newcclosure = missing('function', newcclosure, function(callback, ...)
    return callback(...)
end)
getgc = missing('function', getgc or get_gc_objects)
setthreadidentity = missing('function', setthreadidentity or syn and syn.set_thread_identity or syn_context_set or setthreadcontext)
replicatesignal = missing('function', replicatesignal)
getconnections = missing('function', getconnections or get_signal_cons)
Services = setmetatable({}, {__index = function(tbl, key)
    local success, result = pcall(function()
        return cloneref(game:GetService(key))
    end)
    if success then
        rawset(tbl, key, result)
        return result
    end
    error('Invalid Service: ' .. tostring(key))
end})
Players = Services.Players
UserInputService = Services.UserInputService
TweenService = Services.TweenService
HttpService = Services.HttpService
ExperienceService = Services.ExperienceService
MarketplaceService = Services.MarketplaceService
RunService = Services.RunService
TeleportService = Services.TeleportService
StarterGui = Services.StarterGui
GuiService = Services.GuiService
Lighting = Services.Lighting
ContextActionService = Services.ContextActionService
ReplicatedStorage = Services.ReplicatedStorage
GroupService = Services.GroupService
PathService = Services.PathfindingService
SoundService = Services.SoundService
Teams = Services.Teams
StarterPlayer = Services.StarterPlayer
InsertService = Services.InsertService
ChatService = Services.Chat
ProximityPromptService = Services.ProximityPromptService
ContentProvider = Services.ContentProvider
StatsService = Services.Stats
MaterialService = Services.MaterialService
AvatarEditorService = Services.AvatarEditorService
TextService = Services.TextService
TextChatService = Services.TextChatService
CaptureService = Services.CaptureService
VoiceChatService = Services.VoiceChatService
SocialService = Services.SocialService
PlayerGui = cloneref(Players.LocalPlayer:FindFirstChildWhichIsA('PlayerGui'))
COREGUI = Services.CoreGui or PlayerGui
IYMouse = cloneref(Players.LocalPlayer:GetMouse())
PlaceId, JobId = game.PlaceId, game.JobId
xpcall(function()
    IsOnMobile = table.find({Enum.Platform.Android, Enum.Platform.IOS}, UserInputService:GetPlatform())
end, function()
    IsOnMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end)
isLegacyChat = TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService
local data = {['infiniteyield/assets/bindsandplugins.png'] = 'rbxassetid://5147695474', ['infiniteyield/assets/close.png'] = 'rbxassetid://5054663650', ['infiniteyield/assets/editaliases.png'] = 'rbxassetid://5147488658', ['infiniteyield/assets/editkeybinds.png'] = 'rbxassetid://129697930', ['infiniteyield/assets/edittheme.png'] = 'rbxassetid://4911962991', ['infiniteyield/assets/editwaypoints.png'] = 'rbxassetid://5147488592', ['infiniteyield/assets/imgstudiopluginlogo.png'] = 'rbxassetid://4113050383', ['infiniteyield/assets/logo.png'] = 'rbxassetid://1352543873', ['infiniteyield/assets/minimize.png'] = 'rbxassetid://2406617031', ['infiniteyield/assets/pin.png'] = 'rbxassetid://6234691350', ['infiniteyield/assets/reference.png'] = 'rbxassetid://3523243755', ['infiniteyield/assets/settings.png'] = 'rbxassetid://1204397029', ['infiniteyield/assets/scrollbar.png'] = 'rbxassetid://75024581433929'}
local function getcustomasset2(arg1)
    if waxgetcustomasset then
        local success, result = pcall(function()
            return waxgetcustomasset(arg1)
        end)
        if success and result ~= nil and result ~= '' then
            return result
        end
    end
    return data[arg1]
end
if makefolder and isfolder and writefile and isfile then
    pcall(function()
        for _, name in {'infiniteyield', 'infiniteyield/assets'} do
            if isfolder(name) then
                continue
            end
            makefolder(name)
        end
        for entry in data do
            if not isfile(entry) and entry ~= 'infiniteyield/assets/scrollbar.png' then
                writefile(entry, game:HttpGet((entry:gsub('infiniteyield/', 'https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/'))))
            end
        end
        if IsOnMobile then
            writefile('infiniteyield/assets/.nomedia', '')
        end
    end)
end
currentVersion = '6.4.2'
ScaledHolder = Instance.new('Frame')
Scale = Instance.new('UIScale')
Holder = Instance.new('Frame')
Title = Instance.new('TextLabel')
Dark = Instance.new('Frame')
Cmdbar = Instance.new('TextBox')
CMDsF = Instance.new('ScrollingFrame')
cmdListLayout = Instance.new('UIListLayout')
SettingsButton = Instance.new('ImageButton')
ColorsButton = Instance.new('ImageButton')
Settings = Instance.new('Frame')
Prefix = Instance.new('TextLabel')
PrefixBox = Instance.new('TextBox')
Keybinds = Instance.new('TextLabel')
StayOpen = Instance.new('TextLabel')
Button = Instance.new('Frame')
On = Instance.new('TextButton')
Positions = Instance.new('TextLabel')
EventBind = Instance.new('TextLabel')
Plugins = Instance.new('TextLabel')
Example = Instance.new('TextButton')
Notification = Instance.new('Frame')
Title_2 = Instance.new('TextLabel')
Text_2 = Instance.new('TextLabel')
CloseButton = Instance.new('TextButton')
CloseImage = Instance.new('ImageLabel')
PinButton = Instance.new('TextButton')
PinImage = Instance.new('ImageLabel')
Tooltip = Instance.new('Frame')
Title_3 = Instance.new('TextLabel')
Description = Instance.new('TextLabel')
IntroBackground = Instance.new('Frame')
Logo = Instance.new('ImageLabel')
Credits = Instance.new('TextBox')
KeybindsFrame = Instance.new('Frame')
Close = Instance.new('TextButton')
Add = Instance.new('TextButton')
Delete = Instance.new('TextButton')
Holder_2 = Instance.new('ScrollingFrame')
Example_2 = Instance.new('Frame')
Text_3 = Instance.new('TextLabel')
Delete_2 = Instance.new('TextButton')
KeybindEditor = Instance.new('Frame')
background_2 = Instance.new('Frame')
Dark_3 = Instance.new('Frame')
Directions = Instance.new('TextLabel')
BindTo = Instance.new('TextButton')
TriggerLabel = Instance.new('TextLabel')
BindTriggerSelect = Instance.new('TextButton')
Add_2 = Instance.new('TextButton')
Toggles = Instance.new('ScrollingFrame')
ClickTP = Instance.new('TextLabel')
Select = Instance.new('TextButton')
ClickDelete = Instance.new('TextLabel')
Select_2 = Instance.new('TextButton')
Cmdbar_2 = Instance.new('TextBox')
Cmdbar_3 = Instance.new('TextBox')
CreateToggle = Instance.new('TextLabel')
Button_2 = Instance.new('Frame')
On_2 = Instance.new('TextButton')
shadow_2 = Instance.new('Frame')
PopupText_2 = Instance.new('TextLabel')
Exit_2 = Instance.new('TextButton')
ExitImage_2 = Instance.new('ImageLabel')
PositionsFrame = Instance.new('Frame')
Close_3 = Instance.new('TextButton')
Delete_5 = Instance.new('TextButton')
Part = Instance.new('TextButton')
Holder_4 = Instance.new('ScrollingFrame')
Example_4 = Instance.new('Frame')
Text_5 = Instance.new('TextLabel')
Delete_6 = Instance.new('TextButton')
TP = Instance.new('TextButton')
AliasesFrame = Instance.new('Frame')
Close_2 = Instance.new('TextButton')
Delete_3 = Instance.new('TextButton')
Holder_3 = Instance.new('ScrollingFrame')
Example_3 = Instance.new('Frame')
Text_4 = Instance.new('TextLabel')
Delete_4 = Instance.new('TextButton')
Aliases = Instance.new('TextLabel')
PluginsFrame = Instance.new('Frame')
Close_4 = Instance.new('TextButton')
Add_3 = Instance.new('TextButton')
Holder_5 = Instance.new('ScrollingFrame')
Example_5 = Instance.new('Frame')
Text_6 = Instance.new('TextLabel')
Delete_7 = Instance.new('TextButton')
PluginEditor = Instance.new('Frame')
background_3 = Instance.new('Frame')
Dark_2 = Instance.new('Frame')
Img = Instance.new('ImageButton')
AddPlugin = Instance.new('TextButton')
FileName = Instance.new('TextBox')
About = Instance.new('TextLabel')
Directions_2 = Instance.new('TextLabel')
shadow_3 = Instance.new('Frame')
PopupText_3 = Instance.new('TextLabel')
Exit_3 = Instance.new('TextButton')
ExitImage_3 = Instance.new('ImageLabel')
AliasHint = Instance.new('TextLabel')
PluginsHint = Instance.new('TextLabel')
PositionsHint = Instance.new('TextLabel')
ToPartFrame = Instance.new('Frame')
background_4 = Instance.new('Frame')
ChoosePart = Instance.new('TextButton')
CopyPath = Instance.new('TextButton')
Directions_3 = Instance.new('TextLabel')
Path = Instance.new('TextLabel')
shadow_4 = Instance.new('Frame')
PopupText_5 = Instance.new('TextLabel')
Exit_4 = Instance.new('TextButton')
ExitImage_5 = Instance.new('ImageLabel')
logs = Instance.new('Frame')
shadow = Instance.new('Frame')
Hide = Instance.new('TextButton')
ImageLabel = Instance.new('ImageLabel')
PopupText = Instance.new('TextLabel')
Exit = Instance.new('TextButton')
ImageLabel_2 = Instance.new('ImageLabel')
background = Instance.new('Frame')
chat = Instance.new('Frame')
Clear = Instance.new('TextButton')
SaveChatlogs = Instance.new('TextButton')
Toggle = Instance.new('TextButton')
scroll_2 = Instance.new('ScrollingFrame')
join = Instance.new('Frame')
Toggle_2 = Instance.new('TextButton')
Clear_2 = Instance.new('TextButton')
scroll_3 = Instance.new('ScrollingFrame')
listlayout = Instance.new('UIListLayout', scroll_3)
selectChat = Instance.new('TextButton')
selectJoin = Instance.new('TextButton')
randomString = function()
    local randomValue = math.random(10, 20)
    local list = {}
    for i = 1, randomValue do
        list[i] = string.char(math.random(32, 126))
    end
    return table.concat(list)
end
PARENT = nil
MAX_DISPLAY_ORDER = 1.7976931348623157e+308
if gethui then
    local screenGui = Instance.new('ScreenGui')
    screenGui.Name = randomString()
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = MAX_DISPLAY_ORDER
    screenGui.Parent = gethui()
    PARENT = screenGui
elseif not is_sirhurt_closure and syn_protect_gui then
    local screenGui2 = Instance.new('ScreenGui')
    screenGui2.Name = randomString()
    screenGui2.ResetOnSpawn = false
    screenGui2.DisplayOrder = MAX_DISPLAY_ORDER
    syn_protect_gui(screenGui2)
    screenGui2.Parent = COREGUI
    PARENT = screenGui2
elseif COREGUI:FindFirstChild('RobloxGui') then
    PARENT = COREGUI.RobloxGui
else
    local screenGui3 = Instance.new('ScreenGui')
    screenGui3.Name = randomString()
    screenGui3.ResetOnSpawn = false
    screenGui3.DisplayOrder = MAX_DISPLAY_ORDER
    screenGui3.Parent = COREGUI
    PARENT = screenGui3
end
shade1 = {}
shade2 = {}
shade3 = {}
text1 = {}
text2 = {}
scroll = {}
ScaledHolder.Name = randomString()
ScaledHolder.Size = UDim2.fromScale(1, 1)
ScaledHolder.BackgroundTransparency = 1
ScaledHolder.Parent = PARENT
Scale.Name = randomString()
Holder.Name = randomString()
Holder.Parent = ScaledHolder
Holder.Active = true
Holder.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Holder.BorderSizePixel = 0
Holder.Position = UDim2.new(1, -250, 1, -220)
Holder.Size = UDim2.new(0, 250, 0, 220)
Holder.ZIndex = 10
table.insert(shade2, Holder)
Title.Name = 'Title'
Title.Parent = Holder
Title.Active = true
Title.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(0, 250, 0, 20)
Title.Font = Enum.Font.SourceSans
Title.TextSize = 18
Title.Text = 'Infinite Yield FE v' .. currentVersion
local v1 = ({['01 01'] = '🎆', ['02 14'] = '💝', ['03 17'] = '☘️', [(function(number)
    local floored = math.floor(number / 100)
    local floored2 = math.floor((13 + 8 * floored) / 25)
    local remainder = (15 - floored2 + floored - math.floor(floored / 4)) % 30
    local remainder2 = (4 + floored - math.floor(floored / 4)) % 7
    local v1 = (19 * (number % 19) + remainder) % 30
    local v2 = (2 * (number % 4) + 4 * (number % 7) + 6 * v1 + remainder2) % 7
    local v3 = 22 + v1 + v2
    if v1 == 29 and v2 == 6 then
        return '04 19'
    end
    if v1 == 28 and v2 == 6 then
        return '04 18'
    end
    if v3 > 31 then
        return ('04 %02d'):format(v3 - 31)
    end
    return ('03 %02d'):format(v3)
end)(tonumber(os.date('%Y')))] = '🥚', ['10 31'] = '🎃', ['12 25'] = '🎄'})[os.date('%m %d')]
if v1 then
    Title.Text = ('%s %s %s'):format(v1, Title.Text, v1)
end
Title.TextColor3 = Color3.new(1, 1, 1)
Title.ZIndex = 10
table.insert(shade1, Title)
table.insert(text1, Title)
Dark.Name = 'Dark'
Dark.Parent = Holder
Dark.Active = true
Dark.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
Dark.BorderSizePixel = 0
Dark.Position = UDim2.new(0, 0, 0, 45)
Dark.Size = UDim2.new(0, 250, 0, 175)
Dark.ZIndex = 10
table.insert(shade1, Dark)
Cmdbar.Name = 'Cmdbar'
Cmdbar.Parent = Holder
Cmdbar.BackgroundTransparency = 1
Cmdbar.BorderSizePixel = 0
Cmdbar.Position = UDim2.new(0, 5, 0, 20)
Cmdbar.Size = UDim2.new(0, 240, 0, 25)
Cmdbar.Font = Enum.Font.SourceSans
Cmdbar.TextSize = 18
Cmdbar.TextXAlignment = Enum.TextXAlignment.Left
Cmdbar.TextColor3 = Color3.new(1, 1, 1)
Cmdbar.Text = ''
Cmdbar.ZIndex = 10
Cmdbar.PlaceholderText = 'Command Bar'
CMDsF.Name = 'CMDs'
CMDsF.Parent = Holder
CMDsF.BackgroundTransparency = 1
CMDsF.BorderSizePixel = 0
CMDsF.Position = UDim2.new(0, 5, 0, 45)
CMDsF.Size = UDim2.new(0, 245, 0, 175)
CMDsF.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
CMDsF.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
CMDsF.CanvasSize = UDim2.new(0, 0, 0, 0)
CMDsF.MidImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
CMDsF.ScrollBarThickness = 8
CMDsF.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
CMDsF.VerticalScrollBarInset = 'Always'
CMDsF.ZIndex = 10
table.insert(scroll, CMDsF)
cmdListLayout.Parent = CMDsF
SettingsButton.Name = 'SettingsButton'
SettingsButton.Parent = Holder
SettingsButton.BackgroundTransparency = 1
SettingsButton.Position = UDim2.new(0, 230, 0, 0)
SettingsButton.Size = UDim2.new(0, 20, 0, 20)
SettingsButton.Image = getcustomasset2('infiniteyield/assets/settings.png')
SettingsButton.ZIndex = 10
ReferenceButton = Instance.new('ImageButton')
ReferenceButton.Name = 'ReferenceButton'
ReferenceButton.Parent = Holder
ReferenceButton.BackgroundTransparency = 1
ReferenceButton.Position = UDim2.new(0, 212, 0, 2)
ReferenceButton.Size = UDim2.new(0, 16, 0, 16)
ReferenceButton.Image = getcustomasset2('infiniteyield/assets/reference.png')
ReferenceButton.ZIndex = 10
Settings.Name = 'Settings'
Settings.Parent = Holder
Settings.Active = true
Settings.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
Settings.BorderSizePixel = 0
Settings.Position = UDim2.new(0, 0, 0, 220)
Settings.Size = UDim2.new(0, 250, 0, 175)
Settings.ZIndex = 10
table.insert(shade1, Settings)
SettingsHolder = Instance.new('ScrollingFrame')
SettingsHolder.Name = 'Holder'
SettingsHolder.Parent = Settings
SettingsHolder.BackgroundTransparency = 1
SettingsHolder.BorderSizePixel = 0
SettingsHolder.Size = UDim2.new(1, 0, 1, 0)
SettingsHolder.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
SettingsHolder.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
SettingsHolder.CanvasSize = UDim2.new(0, 0, 0, 235)
SettingsHolder.MidImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
SettingsHolder.ScrollBarThickness = 8
SettingsHolder.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
SettingsHolder.VerticalScrollBarInset = 'Always'
SettingsHolder.ZIndex = 10
table.insert(scroll, SettingsHolder)
Prefix.Name = 'Prefix'
Prefix.Parent = SettingsHolder
Prefix.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Prefix.BorderSizePixel = 0
Prefix.BackgroundTransparency = 1
Prefix.Position = UDim2.new(0, 5, 0, 5)
Prefix.Size = UDim2.new(1, -10, 0, 20)
Prefix.Font = Enum.Font.SourceSans
Prefix.TextSize = 14
Prefix.Text = 'Prefix'
Prefix.TextColor3 = Color3.new(1, 1, 1)
Prefix.TextXAlignment = Enum.TextXAlignment.Left
Prefix.ZIndex = 10
table.insert(shade2, Prefix)
table.insert(text1, Prefix)
PrefixBox.Name = 'PrefixBox'
PrefixBox.Parent = Prefix
PrefixBox.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
PrefixBox.BorderSizePixel = 0
PrefixBox.Position = UDim2.new(1, -20, 0, 0)
PrefixBox.Size = UDim2.new(0, 20, 0, 20)
PrefixBox.Font = Enum.Font.SourceSansBold
PrefixBox.TextSize = 14
PrefixBox.Text = ''
PrefixBox.TextColor3 = Color3.new(0, 0, 0)
PrefixBox.ZIndex = 10
table.insert(shade3, PrefixBox)
table.insert(text2, PrefixBox)
makeSettingsButton = function(text, image, x)
    local textButton = Instance.new('TextButton')
    textButton.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
    textButton.BorderSizePixel = 0
    textButton.Position = UDim2.new(0, 0, 0, 0)
    textButton.Size = UDim2.new(1, 0, 0, 25)
    textButton.Text = ''
    textButton.ZIndex = 10
    local imageLabel = Instance.new('ImageLabel')
    imageLabel.Name = 'Icon'
    imageLabel.Parent = textButton
    imageLabel.Position = UDim2.new(0, 5, 0, 5)
    imageLabel.Size = UDim2.new(0, 16, 0, 16)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = image
    imageLabel.ZIndex = 10
    if x then
        imageLabel.ScaleType = Enum.ScaleType.Crop
        imageLabel.ImageRectSize = Vector2.new(16, 16)
        imageLabel.ImageRectOffset = Vector2.new(x, 0)
    end
    local textLabel = Instance.new('TextLabel')
    textLabel.Name = 'ButtonLabel'
    textLabel.Parent = textButton
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.Position = UDim2.new(0, 28, 0, 0)
    textLabel.Size = UDim2.new(1, -28, 1, 0)
    textLabel.Font = Enum.Font.SourceSans
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextSize = 14
    textLabel.ZIndex = 10
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    table.insert(shade2, textButton)
    table.insert(text1, textLabel)
    return textButton
end
ColorsButton = makeSettingsButton('Edit Theme', getcustomasset2('infiniteyield/assets/edittheme.png'))
ColorsButton.Position = UDim2.new(0, 5, 0, 55)
ColorsButton.Size = UDim2.new(1, -10, 0, 25)
ColorsButton.Name = 'Colors'
ColorsButton.Parent = SettingsHolder
Keybinds = makeSettingsButton('Edit Keybinds', getcustomasset2('infiniteyield/assets/editkeybinds.png'))
Keybinds.Position = UDim2.new(0, 5, 0, 85)
Keybinds.Size = UDim2.new(1, -10, 0, 25)
Keybinds.Name = 'Keybinds'
Keybinds.Parent = SettingsHolder
Aliases = makeSettingsButton('Edit Aliases', getcustomasset2('infiniteyield/assets/editaliases.png'))
Aliases.Position = UDim2.new(0, 5, 0, 115)
Aliases.Size = UDim2.new(1, -10, 0, 25)
Aliases.Name = 'Aliases'
Aliases.Parent = SettingsHolder
StayOpen.Name = 'StayOpen'
StayOpen.Parent = SettingsHolder
StayOpen.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
StayOpen.BorderSizePixel = 0
StayOpen.BackgroundTransparency = 1
StayOpen.Position = UDim2.new(0, 5, 0, 30)
StayOpen.Size = UDim2.new(1, -10, 0, 20)
StayOpen.Font = Enum.Font.SourceSans
StayOpen.TextSize = 14
StayOpen.Text = 'Keep Menu Open'
StayOpen.TextColor3 = Color3.new(1, 1, 1)
StayOpen.TextXAlignment = Enum.TextXAlignment.Left
StayOpen.ZIndex = 10
table.insert(shade2, StayOpen)
table.insert(text1, StayOpen)
Button.Name = 'Button'
Button.Parent = StayOpen
Button.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
Button.BorderSizePixel = 0
Button.Position = UDim2.new(1, -20, 0, 0)
Button.Size = UDim2.new(0, 20, 0, 20)
Button.ZIndex = 10
table.insert(shade3, Button)
On.Name = 'On'
On.Parent = Button
On.BackgroundColor3 = Color3.fromRGB(150, 150, 151)
On.BackgroundTransparency = 1
On.BorderSizePixel = 0
On.Position = UDim2.new(0, 2, 0, 2)
On.Size = UDim2.new(0, 16, 0, 16)
On.Font = Enum.Font.SourceSans
On.FontSize = Enum.FontSize.Size14
On.Text = ''
On.TextColor3 = Color3.new(0, 0, 0)
On.ZIndex = 10
Positions = makeSettingsButton('Edit/Goto Waypoints', getcustomasset2('infiniteyield/assets/editwaypoints.png'))
Positions.Position = UDim2.new(0, 5, 0, 145)
Positions.Size = UDim2.new(1, -10, 0, 25)
Positions.Name = 'Waypoints'
Positions.Parent = SettingsHolder
EventBind = makeSettingsButton('Edit Event Binds', getcustomasset2('infiniteyield/assets/bindsandplugins.png'), 759)
EventBind.Position = UDim2.new(0, 5, 0, 205)
EventBind.Size = UDim2.new(1, -10, 0, 25)
EventBind.Name = 'EventBinds'
EventBind.Parent = SettingsHolder
Plugins = makeSettingsButton('Manage Plugins', getcustomasset2('infiniteyield/assets/bindsandplugins.png'), 743)
Plugins.Position = UDim2.new(0, 5, 0, 175)
Plugins.Size = UDim2.new(1, -10, 0, 25)
Plugins.Name = 'Plugins'
Plugins.Parent = SettingsHolder
Example.Name = 'Example'
Example.Parent = Holder
Example.BackgroundTransparency = 1
Example.BorderSizePixel = 0
Example.Size = UDim2.new(0, 190, 0, 20)
Example.Visible = false
Example.Font = Enum.Font.SourceSans
Example.TextSize = 18
Example.Text = 'Example'
Example.TextColor3 = Color3.new(1, 1, 1)
Example.TextXAlignment = Enum.TextXAlignment.Left
Example.ZIndex = 10
table.insert(text1, Example)
Notification.Name = randomString()
Notification.Parent = ScaledHolder
Notification.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
Notification.BorderSizePixel = 0
Notification.Position = UDim2.new(1, -500, 1, 20)
Notification.Size = UDim2.new(0, 250, 0, 100)
Notification.ZIndex = 10
table.insert(shade1, Notification)
Title_2.Name = 'Title'
Title_2.Parent = Notification
Title_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Title_2.BorderSizePixel = 0
Title_2.Size = UDim2.new(0, 250, 0, 20)
Title_2.Font = Enum.Font.SourceSans
Title_2.TextSize = 14
Title_2.Text = 'Notification Title'
Title_2.TextColor3 = Color3.new(1, 1, 1)
Title_2.ZIndex = 10
table.insert(shade2, Title_2)
table.insert(text1, Title_2)
Text_2.Name = 'Text'
Text_2.Parent = Notification
Text_2.BackgroundTransparency = 1
Text_2.BorderSizePixel = 0
Text_2.Position = UDim2.new(0, 5, 0, 25)
Text_2.Size = UDim2.new(0, 240, 0, 75)
Text_2.Font = Enum.Font.SourceSans
Text_2.TextSize = 16
Text_2.Text = 'Notification Text'
Text_2.TextColor3 = Color3.new(1, 1, 1)
Text_2.TextWrapped = true
Text_2.ZIndex = 10
table.insert(text1, Text_2)
CloseButton.Name = 'CloseButton'
CloseButton.Parent = Notification
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -20, 0, 0)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Text = ''
CloseButton.ZIndex = 10
CloseImage.Parent = CloseButton
CloseImage.BackgroundColor3 = Color3.new(1, 1, 1)
CloseImage.BackgroundTransparency = 1
CloseImage.Position = UDim2.new(0, 5, 0, 5)
CloseImage.Size = UDim2.new(0, 10, 0, 10)
CloseImage.Image = getcustomasset2('infiniteyield/assets/close.png')
CloseImage.ZIndex = 10
PinButton.Name = 'PinButton'
PinButton.Parent = Notification
PinButton.BackgroundTransparency = 1
PinButton.Size = UDim2.new(0, 20, 0, 20)
PinButton.ZIndex = 10
PinButton.Text = ''
PinImage.Parent = PinButton
PinImage.BackgroundColor3 = Color3.new(1, 1, 1)
PinImage.BackgroundTransparency = 1
PinImage.Position = UDim2.new(0, 3, 0, 3)
PinImage.Size = UDim2.new(0, 14, 0, 14)
PinImage.ZIndex = 10
PinImage.Image = getcustomasset2('infiniteyield/assets/pin.png')
Tooltip.Name = randomString()
Tooltip.Parent = ScaledHolder
Tooltip.Active = true
Tooltip.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
Tooltip.BackgroundTransparency = 0.1
Tooltip.BorderSizePixel = 0
Tooltip.Size = UDim2.new(0, 200, 0, 96)
Tooltip.Visible = false
Tooltip.ZIndex = 10
table.insert(shade1, Tooltip)
Title_3.Name = 'Title'
Title_3.Parent = Tooltip
Title_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Title_3.BackgroundTransparency = 0.1
Title_3.BorderSizePixel = 0
Title_3.Size = UDim2.new(0, 200, 0, 20)
Title_3.Font = Enum.Font.SourceSans
Title_3.TextSize = 14
Title_3.Text = ''
Title_3.TextColor3 = Color3.new(1, 1, 1)
Title_3.TextTransparency = 0.1
Title_3.ZIndex = 10
table.insert(shade2, Title_3)
table.insert(text1, Title_3)
Description.Name = 'Description'
Description.Parent = Tooltip
Description.BackgroundTransparency = 1
Description.BorderSizePixel = 0
Description.Size = UDim2.new(0, 180, 0, 72)
Description.Position = UDim2.new(0, 10, 0, 18)
Description.Font = Enum.Font.SourceSans
Description.TextSize = 16
Description.Text = ''
Description.TextColor3 = Color3.new(1, 1, 1)
Description.TextTransparency = 0.1
Description.TextWrapped = true
Description.ZIndex = 10
table.insert(text1, Description)
IntroBackground.Name = 'IntroBackground'
IntroBackground.Parent = Holder
IntroBackground.Active = true
IntroBackground.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
IntroBackground.BorderSizePixel = 0
IntroBackground.Position = UDim2.new(0, 0, 0, 45)
IntroBackground.Size = UDim2.new(0, 250, 0, 175)
IntroBackground.ZIndex = 10
Logo.Name = 'Logo'
Logo.Parent = Holder
Logo.BackgroundTransparency = 1
Logo.BorderSizePixel = 0
Logo.Position = UDim2.new(0, 125, 0, 127)
Logo.Size = UDim2.new(0, 10, 0, 10)
Logo.Image = getcustomasset2('infiniteyield/assets/logo.png')
Logo.ImageTransparency = 0
Logo.ZIndex = 10
Credits.Name = 'Credits'
Credits.Parent = Holder
Credits.BackgroundTransparency = 1
Credits.BorderSizePixel = 0
Credits.Position = UDim2.new(0, 0, 0.9, 30)
Credits.Size = UDim2.new(0, 250, 0, 20)
Credits.Font = Enum.Font.SourceSansLight
Credits.FontSize = Enum.FontSize.Size14
Credits.Text = 'Edge // Zwolf // Moon // Toon // Peyton // ATP'
Credits.TextColor3 = Color3.new(1, 1, 1)
Credits.ZIndex = 10
KeybindsFrame.Name = 'KeybindsFrame'
KeybindsFrame.Parent = Settings
KeybindsFrame.Active = true
KeybindsFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
KeybindsFrame.BorderSizePixel = 0
KeybindsFrame.Position = UDim2.new(0, 0, 0, 175)
KeybindsFrame.Size = UDim2.new(0, 250, 0, 175)
KeybindsFrame.ZIndex = 10
table.insert(shade1, KeybindsFrame)
Close.Name = 'Close'
Close.Parent = KeybindsFrame
Close.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0, 205, 0, 150)
Close.Size = UDim2.new(0, 40, 0, 20)
Close.Font = Enum.Font.SourceSans
Close.TextSize = 14
Close.Text = 'Close'
Close.TextColor3 = Color3.new(1, 1, 1)
Close.ZIndex = 10
table.insert(shade2, Close)
table.insert(text1, Close)
Add.Name = 'Add'
Add.Parent = KeybindsFrame
Add.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Add.BorderSizePixel = 0
Add.Position = UDim2.new(0, 5, 0, 150)
Add.Size = UDim2.new(0, 40, 0, 20)
Add.Font = Enum.Font.SourceSans
Add.TextSize = 14
Add.Text = 'Add'
Add.TextColor3 = Color3.new(1, 1, 1)
Add.ZIndex = 10
table.insert(shade2, Add)
table.insert(text1, Add)
Delete.Name = 'Delete'
Delete.Parent = KeybindsFrame
Delete.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Delete.BorderSizePixel = 0
Delete.Position = UDim2.new(0, 50, 0, 150)
Delete.Size = UDim2.new(0, 40, 0, 20)
Delete.Font = Enum.Font.SourceSans
Delete.TextSize = 14
Delete.Text = 'Clear'
Delete.TextColor3 = Color3.new(1, 1, 1)
Delete.ZIndex = 10
table.insert(shade2, Delete)
table.insert(text1, Delete)
Holder_2.Name = 'Holder'
Holder_2.Parent = KeybindsFrame
Holder_2.BackgroundTransparency = 1
Holder_2.BorderSizePixel = 0
Holder_2.Position = UDim2.new(0, 0, 0, 0)
Holder_2.Size = UDim2.new(0, 250, 0, 145)
Holder_2.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
Holder_2.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_2.CanvasSize = UDim2.new(0, 0, 0, 0)
Holder_2.MidImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_2.ScrollBarThickness = 0
Holder_2.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_2.VerticalScrollBarInset = 'Always'
Holder_2.ZIndex = 10
Example_2.Name = 'Example'
Example_2.Parent = KeybindsFrame
Example_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Example_2.BorderSizePixel = 0
Example_2.Size = UDim2.new(0, 10, 0, 20)
Example_2.Visible = false
Example_2.ZIndex = 10
table.insert(shade2, Example_2)
Text_3.Name = 'Text'
Text_3.Parent = Example_2
Text_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Text_3.BorderSizePixel = 0
Text_3.Position = UDim2.new(0, 10, 0, 0)
Text_3.Size = UDim2.new(0, 240, 0, 20)
Text_3.Font = Enum.Font.SourceSans
Text_3.TextSize = 14
Text_3.Text = 'nom'
Text_3.TextColor3 = Color3.new(1, 1, 1)
Text_3.TextXAlignment = Enum.TextXAlignment.Left
Text_3.ZIndex = 10
table.insert(shade2, Text_3)
table.insert(text1, Text_3)
Delete_2.Name = 'Delete'
Delete_2.Parent = Text_3
Delete_2.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
Delete_2.BorderSizePixel = 0
Delete_2.Position = UDim2.new(0, 200, 0, 0)
Delete_2.Size = UDim2.new(0, 40, 0, 20)
Delete_2.Font = Enum.Font.SourceSans
Delete_2.TextSize = 14
Delete_2.Text = 'Delete'
Delete_2.TextColor3 = Color3.new(0, 0, 0)
Delete_2.ZIndex = 10
table.insert(shade3, Delete_2)
table.insert(text2, Delete_2)
KeybindEditor.Name = randomString()
KeybindEditor.Parent = ScaledHolder
KeybindEditor.Active = true
KeybindEditor.BackgroundTransparency = 1
KeybindEditor.Position = UDim2.new(0.5, -180, 0, -500)
KeybindEditor.Size = UDim2.new(0, 360, 0, 20)
KeybindEditor.ZIndex = 10
background_2.Name = 'background'
background_2.Parent = KeybindEditor
background_2.Active = true
background_2.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
background_2.BorderSizePixel = 0
background_2.Position = UDim2.new(0, 0, 0, 20)
background_2.Size = UDim2.new(0, 360, 0, 185)
background_2.ZIndex = 10
table.insert(shade1, background_2)
Dark_3.Name = 'Dark'
Dark_3.Parent = background_2
Dark_3.Active = true
Dark_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Dark_3.BorderSizePixel = 0
Dark_3.Position = UDim2.new(0, 135, 0, 0)
Dark_3.Size = UDim2.new(0, 2, 0, 185)
Dark_3.ZIndex = 10
table.insert(shade2, Dark_3)
Directions.Name = 'Directions'
Directions.Parent = background_2
Directions.BackgroundTransparency = 1
Directions.BorderSizePixel = 0
Directions.Position = UDim2.new(0, 10, 0, 15)
Directions.Size = UDim2.new(0, 115, 0, 90)
Directions.ZIndex = 10
Directions.Font = Enum.Font.SourceSans
Directions.Text = 'Click the button below and press a key/mouse button. Then select what you want to bind it to.'
Directions.TextColor3 = Color3.fromRGB(255, 255, 255)
Directions.TextSize = 14
Directions.TextWrapped = true
Directions.TextYAlignment = Enum.TextYAlignment.Top
table.insert(text1, Directions)
BindTo.Name = 'BindTo'
BindTo.Parent = background_2
BindTo.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
BindTo.BorderSizePixel = 0
BindTo.Position = UDim2.new(0, 10, 0, 95)
BindTo.Size = UDim2.new(0, 115, 0, 50)
BindTo.ZIndex = 10
BindTo.Font = Enum.Font.SourceSans
BindTo.Text = 'Click to bind'
BindTo.TextColor3 = Color3.fromRGB(255, 255, 255)
BindTo.TextSize = 16
table.insert(shade2, BindTo)
table.insert(text1, BindTo)
TriggerLabel.Name = 'TriggerLabel'
TriggerLabel.Parent = background_2
TriggerLabel.BackgroundTransparency = 1
TriggerLabel.Position = UDim2.new(0, 10, 0, 155)
TriggerLabel.Size = UDim2.new(0, 45, 0, 20)
TriggerLabel.ZIndex = 10
TriggerLabel.Font = Enum.Font.SourceSans
TriggerLabel.Text = 'Trigger:'
TriggerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TriggerLabel.TextSize = 14
TriggerLabel.TextXAlignment = Enum.TextXAlignment.Left
table.insert(text1, TriggerLabel)
BindTriggerSelect.Name = 'BindTo'
BindTriggerSelect.Parent = background_2
BindTriggerSelect.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
BindTriggerSelect.BorderSizePixel = 0
BindTriggerSelect.Position = UDim2.new(0, 60, 0, 155)
BindTriggerSelect.Size = UDim2.new(0, 65, 0, 20)
BindTriggerSelect.ZIndex = 10
BindTriggerSelect.Font = Enum.Font.SourceSans
BindTriggerSelect.Text = 'KeyDown'
BindTriggerSelect.TextColor3 = Color3.fromRGB(255, 255, 255)
BindTriggerSelect.TextSize = 16
table.insert(shade2, BindTriggerSelect)
table.insert(text1, BindTriggerSelect)
Add_2.Name = 'Add'
Add_2.Parent = background_2
Add_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Add_2.BorderSizePixel = 0
Add_2.Position = UDim2.new(0, 310, 0, 35)
Add_2.Size = UDim2.new(0, 40, 0, 20)
Add_2.ZIndex = 10
Add_2.Font = Enum.Font.SourceSans
Add_2.Text = 'Add'
Add_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Add_2.TextSize = 14
table.insert(shade2, Add_2)
table.insert(text1, Add_2)
Toggles.Name = 'Toggles'
Toggles.Parent = background_2
Toggles.BackgroundTransparency = 1
Toggles.BorderSizePixel = 0
Toggles.Position = UDim2.new(0, 150, 0, 125)
Toggles.Size = UDim2.new(0, 200, 0, 50)
Toggles.ZIndex = 10
Toggles.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Toggles.CanvasSize = UDim2.new(0, 0, 0, 50)
Toggles.ScrollBarThickness = 8
Toggles.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Toggles.VerticalScrollBarInset = Enum.ScrollBarInset.Always
table.insert(scroll, Toggles)
ClickTP.Name = 'Click TP (Hold Key & Click)'
ClickTP.Parent = Toggles
ClickTP.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
ClickTP.BorderSizePixel = 0
ClickTP.Size = UDim2.new(0, 200, 0, 20)
ClickTP.ZIndex = 10
ClickTP.Font = Enum.Font.SourceSans
ClickTP.Text = '    Click TP (Hold Key & Click)'
ClickTP.TextColor3 = Color3.fromRGB(255, 255, 255)
ClickTP.TextSize = 14
ClickTP.TextXAlignment = Enum.TextXAlignment.Left
table.insert(shade2, ClickTP)
table.insert(text1, ClickTP)
Select.Name = 'Select'
Select.Parent = ClickTP
Select.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
Select.BorderSizePixel = 0
Select.Position = UDim2.new(0, 160, 0, 0)
Select.Size = UDim2.new(0, 40, 0, 20)
Select.ZIndex = 10
Select.Font = Enum.Font.SourceSans
Select.Text = 'Add'
Select.TextColor3 = Color3.fromRGB(0, 0, 0)
Select.TextSize = 14
table.insert(shade3, Select)
table.insert(text2, Select)
ClickDelete.Name = 'Click Delete (Hold Key & Click)'
ClickDelete.Parent = Toggles
ClickDelete.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
ClickDelete.BorderSizePixel = 0
ClickDelete.Position = UDim2.new(0, 0, 0, 25)
ClickDelete.Size = UDim2.new(0, 200, 0, 20)
ClickDelete.ZIndex = 10
ClickDelete.Font = Enum.Font.SourceSans
ClickDelete.Text = '    Click Delete (Hold Key & Click)'
ClickDelete.TextColor3 = Color3.fromRGB(255, 255, 255)
ClickDelete.TextSize = 14
ClickDelete.TextXAlignment = Enum.TextXAlignment.Left
table.insert(shade2, ClickDelete)
table.insert(text1, ClickDelete)
Select_2.Name = 'Select'
Select_2.Parent = ClickDelete
Select_2.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
Select_2.BorderSizePixel = 0
Select_2.Position = UDim2.new(0, 160, 0, 0)
Select_2.Size = UDim2.new(0, 40, 0, 20)
Select_2.ZIndex = 10
Select_2.Font = Enum.Font.SourceSans
Select_2.Text = 'Add'
Select_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Select_2.TextSize = 14
table.insert(shade3, Select_2)
table.insert(text2, Select_2)
Cmdbar_2.Name = 'Cmdbar_2'
Cmdbar_2.Parent = background_2
Cmdbar_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Cmdbar_2.BorderSizePixel = 0
Cmdbar_2.Position = UDim2.new(0, 150, 0, 35)
Cmdbar_2.Size = UDim2.new(0, 150, 0, 20)
Cmdbar_2.ZIndex = 10
Cmdbar_2.Font = Enum.Font.SourceSans
Cmdbar_2.PlaceholderText = 'Command'
Cmdbar_2.Text = ''
Cmdbar_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Cmdbar_2.TextSize = 14
Cmdbar_2.TextXAlignment = Enum.TextXAlignment.Left
Cmdbar_3.Name = 'Cmdbar_3'
Cmdbar_3.Parent = background_2
Cmdbar_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Cmdbar_3.BorderSizePixel = 0
Cmdbar_3.Position = UDim2.new(0, 150, 0, 60)
Cmdbar_3.Size = UDim2.new(0, 150, 0, 20)
Cmdbar_3.ZIndex = 10
Cmdbar_3.Font = Enum.Font.SourceSans
Cmdbar_3.PlaceholderText = 'Command 2'
Cmdbar_3.Text = ''
Cmdbar_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Cmdbar_3.TextSize = 14
Cmdbar_3.TextXAlignment = Enum.TextXAlignment.Left
CreateToggle.Name = 'CreateToggle'
CreateToggle.Parent = background_2
CreateToggle.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
CreateToggle.BackgroundTransparency = 1
CreateToggle.BorderSizePixel = 0
CreateToggle.Position = UDim2.new(0, 152, 0, 10)
CreateToggle.Size = UDim2.new(0, 198, 0, 20)
CreateToggle.ZIndex = 10
CreateToggle.Font = Enum.Font.SourceSans
CreateToggle.Text = 'Create Toggle'
CreateToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
CreateToggle.TextSize = 14
CreateToggle.TextXAlignment = Enum.TextXAlignment.Left
table.insert(text1, CreateToggle)
Button_2.Name = 'Button'
Button_2.Parent = CreateToggle
Button_2.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
Button_2.BorderSizePixel = 0
Button_2.Position = UDim2.new(1, -20, 0, 0)
Button_2.Size = UDim2.new(0, 20, 0, 20)
Button_2.ZIndex = 10
table.insert(shade3, Button_2)
On_2.Name = 'On'
On_2.Parent = Button_2
On_2.BackgroundColor3 = Color3.fromRGB(150, 150, 151)
On_2.BackgroundTransparency = 1
On_2.BorderSizePixel = 0
On_2.Position = UDim2.new(0, 2, 0, 2)
On_2.Size = UDim2.new(0, 16, 0, 16)
On_2.ZIndex = 10
On_2.Font = Enum.Font.SourceSans
On_2.Text = ''
On_2.TextColor3 = Color3.fromRGB(0, 0, 0)
On_2.TextSize = 14
shadow_2.Name = 'shadow'
shadow_2.Parent = KeybindEditor
shadow_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
shadow_2.BorderSizePixel = 0
shadow_2.Size = UDim2.new(0, 360, 0, 20)
shadow_2.ZIndex = 10
table.insert(shade2, shadow_2)
PopupText_2.Name = 'PopupText_2'
PopupText_2.Parent = shadow_2
PopupText_2.BackgroundTransparency = 1
PopupText_2.Size = UDim2.new(1, 0, 0.949999988, 0)
PopupText_2.ZIndex = 10
PopupText_2.Font = Enum.Font.SourceSans
PopupText_2.Text = 'Set Keybinds'
PopupText_2.TextColor3 = Color3.fromRGB(255, 255, 255)
PopupText_2.TextSize = 14
PopupText_2.TextWrapped = true
table.insert(text1, PopupText_2)
Exit_2.Name = 'Exit_2'
Exit_2.Parent = shadow_2
Exit_2.BackgroundTransparency = 1
Exit_2.Position = UDim2.new(1, -20, 0, 0)
Exit_2.Size = UDim2.new(0, 20, 0, 20)
Exit_2.ZIndex = 10
Exit_2.Text = ''
ExitImage_2.Parent = Exit_2
ExitImage_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ExitImage_2.BackgroundTransparency = 1
ExitImage_2.Position = UDim2.new(0, 5, 0, 5)
ExitImage_2.Size = UDim2.new(0, 10, 0, 10)
ExitImage_2.ZIndex = 10
ExitImage_2.Image = getcustomasset2('infiniteyield/assets/close.png')
PositionsFrame.Name = 'PositionsFrame'
PositionsFrame.Parent = Settings
PositionsFrame.Active = true
PositionsFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
PositionsFrame.BorderSizePixel = 0
PositionsFrame.Size = UDim2.new(0, 250, 0, 175)
PositionsFrame.Position = UDim2.new(0, 0, 0, 175)
PositionsFrame.ZIndex = 10
table.insert(shade1, PositionsFrame)
Close_3.Name = 'Close'
Close_3.Parent = PositionsFrame
Close_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Close_3.BorderSizePixel = 0
Close_3.Position = UDim2.new(0, 205, 0, 150)
Close_3.Size = UDim2.new(0, 40, 0, 20)
Close_3.Font = Enum.Font.SourceSans
Close_3.TextSize = 14
Close_3.Text = 'Close'
Close_3.TextColor3 = Color3.new(1, 1, 1)
Close_3.ZIndex = 10
table.insert(shade2, Close_3)
table.insert(text1, Close_3)
Delete_5.Name = 'Delete'
Delete_5.Parent = PositionsFrame
Delete_5.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Delete_5.BorderSizePixel = 0
Delete_5.Position = UDim2.new(0, 50, 0, 150)
Delete_5.Size = UDim2.new(0, 40, 0, 20)
Delete_5.Font = Enum.Font.SourceSans
Delete_5.TextSize = 14
Delete_5.Text = 'Clear'
Delete_5.TextColor3 = Color3.new(1, 1, 1)
Delete_5.ZIndex = 10
table.insert(shade2, Delete_5)
table.insert(text1, Delete_5)
Part.Name = 'PartGoto'
Part.Parent = PositionsFrame
Part.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Part.BorderSizePixel = 0
Part.Position = UDim2.new(0, 5, 0, 150)
Part.Size = UDim2.new(0, 40, 0, 20)
Part.Font = Enum.Font.SourceSans
Part.TextSize = 14
Part.Text = 'Part'
Part.TextColor3 = Color3.new(1, 1, 1)
Part.ZIndex = 10
table.insert(shade2, Part)
table.insert(text1, Part)
Holder_4.Name = 'Holder'
Holder_4.Parent = PositionsFrame
Holder_4.BackgroundTransparency = 1
Holder_4.BorderSizePixel = 0
Holder_4.Position = UDim2.new(0, 0, 0, 0)
Holder_4.Selectable = false
Holder_4.Size = UDim2.new(0, 250, 0, 145)
Holder_4.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
Holder_4.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_4.CanvasSize = UDim2.new(0, 0, 0, 0)
Holder_4.MidImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_4.ScrollBarThickness = 0
Holder_4.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_4.VerticalScrollBarInset = 'Always'
Holder_4.ZIndex = 10
Example_4.Name = 'Example'
Example_4.Parent = PositionsFrame
Example_4.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Example_4.BorderSizePixel = 0
Example_4.Size = UDim2.new(0, 10, 0, 20)
Example_4.Visible = false
Example_4.Position = UDim2.new(0, 0, 0, -5)
Example_4.ZIndex = 10
table.insert(shade2, Example_4)
Text_5.Name = 'Text'
Text_5.Parent = Example_4
Text_5.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Text_5.BorderSizePixel = 0
Text_5.Position = UDim2.new(0, 10, 0, 0)
Text_5.Size = UDim2.new(0, 240, 0, 20)
Text_5.Font = Enum.Font.SourceSans
Text_5.TextSize = 14
Text_5.Text = 'Position'
Text_5.TextColor3 = Color3.new(1, 1, 1)
Text_5.TextXAlignment = Enum.TextXAlignment.Left
Text_5.ZIndex = 10
table.insert(shade2, Text_5)
table.insert(text1, Text_5)
Delete_6.Name = 'Delete'
Delete_6.Parent = Text_5
Delete_6.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
Delete_6.BorderSizePixel = 0
Delete_6.Position = UDim2.new(0, 200, 0, 0)
Delete_6.Size = UDim2.new(0, 40, 0, 20)
Delete_6.Font = Enum.Font.SourceSans
Delete_6.TextSize = 14
Delete_6.Text = 'Delete'
Delete_6.TextColor3 = Color3.new(0, 0, 0)
Delete_6.ZIndex = 10
table.insert(shade3, Delete_6)
table.insert(text2, Delete_6)
TP.Name = 'TP'
TP.Parent = Text_5
TP.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
TP.BorderSizePixel = 0
TP.Position = UDim2.new(0, 155, 0, 0)
TP.Size = UDim2.new(0, 40, 0, 20)
TP.Font = Enum.Font.SourceSans
TP.TextSize = 14
TP.Text = 'Goto'
TP.TextColor3 = Color3.new(0, 0, 0)
TP.ZIndex = 10
table.insert(shade3, TP)
table.insert(text2, TP)
AliasesFrame.Name = 'AliasesFrame'
AliasesFrame.Parent = Settings
AliasesFrame.Active = true
AliasesFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
AliasesFrame.BorderSizePixel = 0
AliasesFrame.Position = UDim2.new(0, 0, 0, 175)
AliasesFrame.Size = UDim2.new(0, 250, 0, 175)
AliasesFrame.ZIndex = 10
table.insert(shade1, AliasesFrame)
Close_2.Name = 'Close'
Close_2.Parent = AliasesFrame
Close_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Close_2.BorderSizePixel = 0
Close_2.Position = UDim2.new(0, 205, 0, 150)
Close_2.Size = UDim2.new(0, 40, 0, 20)
Close_2.Font = Enum.Font.SourceSans
Close_2.TextSize = 14
Close_2.Text = 'Close'
Close_2.TextColor3 = Color3.new(1, 1, 1)
Close_2.ZIndex = 10
table.insert(shade2, Close_2)
table.insert(text1, Close_2)
Delete_3.Name = 'Delete'
Delete_3.Parent = AliasesFrame
Delete_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Delete_3.BorderSizePixel = 0
Delete_3.Position = UDim2.new(0, 5, 0, 150)
Delete_3.Size = UDim2.new(0, 40, 0, 20)
Delete_3.Font = Enum.Font.SourceSans
Delete_3.TextSize = 14
Delete_3.Text = 'Clear'
Delete_3.TextColor3 = Color3.new(1, 1, 1)
Delete_3.ZIndex = 10
table.insert(shade2, Delete_3)
table.insert(text1, Delete_3)
Holder_3.Name = 'Holder'
Holder_3.Parent = AliasesFrame
Holder_3.BackgroundTransparency = 1
Holder_3.BorderSizePixel = 0
Holder_3.Position = UDim2.new(0, 0, 0, 0)
Holder_3.Size = UDim2.new(0, 250, 0, 145)
Holder_3.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
Holder_3.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_3.CanvasSize = UDim2.new(0, 0, 0, 0)
Holder_3.MidImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_3.ScrollBarThickness = 0
Holder_3.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_3.VerticalScrollBarInset = 'Always'
Holder_3.ZIndex = 10
Example_3.Name = 'Example'
Example_3.Parent = AliasesFrame
Example_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Example_3.BorderSizePixel = 0
Example_3.Size = UDim2.new(0, 10, 0, 20)
Example_3.Visible = false
Example_3.ZIndex = 10
table.insert(shade2, Example_3)
Text_4.Name = 'Text'
Text_4.Parent = Example_3
Text_4.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Text_4.BorderSizePixel = 0
Text_4.Position = UDim2.new(0, 10, 0, 0)
Text_4.Size = UDim2.new(0, 240, 0, 20)
Text_4.Font = Enum.Font.SourceSans
Text_4.TextSize = 14
Text_4.Text = 'honk'
Text_4.TextColor3 = Color3.new(1, 1, 1)
Text_4.TextXAlignment = Enum.TextXAlignment.Left
Text_4.ZIndex = 10
table.insert(shade2, Text_4)
table.insert(text1, Text_4)
Delete_4.Name = 'Delete'
Delete_4.Parent = Text_4
Delete_4.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
Delete_4.BorderSizePixel = 0
Delete_4.Position = UDim2.new(0, 200, 0, 0)
Delete_4.Size = UDim2.new(0, 40, 0, 20)
Delete_4.Font = Enum.Font.SourceSans
Delete_4.TextSize = 14
Delete_4.Text = 'Delete'
Delete_4.TextColor3 = Color3.new(0, 0, 0)
Delete_4.ZIndex = 10
table.insert(shade3, Delete_4)
table.insert(text2, Delete_4)
PluginsFrame.Name = 'PluginsFrame'
PluginsFrame.Parent = Settings
PluginsFrame.Active = true
PluginsFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
PluginsFrame.BorderSizePixel = 0
PluginsFrame.Position = UDim2.new(0, 0, 0, 175)
PluginsFrame.Size = UDim2.new(0, 250, 0, 175)
PluginsFrame.ZIndex = 10
table.insert(shade1, PluginsFrame)
Close_4.Name = 'Close'
Close_4.Parent = PluginsFrame
Close_4.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Close_4.BorderSizePixel = 0
Close_4.Position = UDim2.new(0, 205, 0, 150)
Close_4.Size = UDim2.new(0, 40, 0, 20)
Close_4.Font = Enum.Font.SourceSans
Close_4.TextSize = 14
Close_4.Text = 'Close'
Close_4.TextColor3 = Color3.new(1, 1, 1)
Close_4.ZIndex = 10
table.insert(shade2, Close_4)
table.insert(text1, Close_4)
Add_3.Name = 'Add'
Add_3.Parent = PluginsFrame
Add_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Add_3.BorderSizePixel = 0
Add_3.Position = UDim2.new(0, 5, 0, 150)
Add_3.Size = UDim2.new(0, 40, 0, 20)
Add_3.Font = Enum.Font.SourceSans
Add_3.TextSize = 14
Add_3.Text = 'Add'
Add_3.TextColor3 = Color3.new(1, 1, 1)
Add_3.ZIndex = 10
table.insert(shade2, Add_3)
table.insert(text1, Add_3)
Holder_5.Name = 'Holder'
Holder_5.Parent = PluginsFrame
Holder_5.BackgroundTransparency = 1
Holder_5.BorderSizePixel = 0
Holder_5.Position = UDim2.new(0, 0, 0, 0)
Holder_5.Selectable = false
Holder_5.Size = UDim2.new(0, 250, 0, 145)
Holder_5.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
Holder_5.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_5.CanvasSize = UDim2.new(0, 0, 0, 0)
Holder_5.MidImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_5.ScrollBarThickness = 0
Holder_5.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Holder_5.VerticalScrollBarInset = 'Always'
Holder_5.ZIndex = 10
Example_5.Name = 'Example'
Example_5.Parent = PluginsFrame
Example_5.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Example_5.BorderSizePixel = 0
Example_5.Size = UDim2.new(0, 10, 0, 20)
Example_5.Visible = false
Example_5.ZIndex = 10
table.insert(shade2, Example_5)
Text_6.Name = 'Text'
Text_6.Parent = Example_5
Text_6.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Text_6.BorderSizePixel = 0
Text_6.Position = UDim2.new(0, 10, 0, 0)
Text_6.Size = UDim2.new(0, 240, 0, 20)
Text_6.Font = Enum.Font.SourceSans
Text_6.TextSize = 14
Text_6.Text = 'F4 > Toggle Fly'
Text_6.TextColor3 = Color3.new(1, 1, 1)
Text_6.TextXAlignment = Enum.TextXAlignment.Left
Text_6.ZIndex = 10
table.insert(shade2, Text_6)
table.insert(text1, Text_6)
Delete_7.Name = 'Delete'
Delete_7.Parent = Text_6
Delete_7.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
Delete_7.BorderSizePixel = 0
Delete_7.Position = UDim2.new(0, 200, 0, 0)
Delete_7.Size = UDim2.new(0, 40, 0, 20)
Delete_7.Font = Enum.Font.SourceSans
Delete_7.TextSize = 14
Delete_7.Text = 'Delete'
Delete_7.TextColor3 = Color3.new(0, 0, 0)
Delete_7.ZIndex = 10
table.insert(shade3, Delete_7)
table.insert(text2, Delete_7)
PluginEditor.Name = randomString()
PluginEditor.Parent = ScaledHolder
PluginEditor.BorderSizePixel = 0
PluginEditor.Active = true
PluginEditor.BackgroundTransparency = 1
PluginEditor.Position = UDim2.new(0.5, -180, 0, -500)
PluginEditor.Size = UDim2.new(0, 360, 0, 20)
PluginEditor.ZIndex = 10
background_3.Name = 'background'
background_3.Parent = PluginEditor
background_3.Active = true
background_3.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
background_3.BorderSizePixel = 0
background_3.Position = UDim2.new(0, 0, 0, 20)
background_3.Size = UDim2.new(0, 360, 0, 160)
background_3.ZIndex = 10
table.insert(shade1, background_3)
Dark_2.Name = 'Dark'
Dark_2.Parent = background_3
Dark_2.Active = true
Dark_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Dark_2.BorderSizePixel = 0
Dark_2.Position = UDim2.new(0, 222, 0, 0)
Dark_2.Size = UDim2.new(0, 2, 0, 160)
Dark_2.ZIndex = 10
table.insert(shade2, Dark_2)
Img.Name = 'Img'
Img.Parent = background_3
Img.BackgroundTransparency = 1
Img.Position = UDim2.new(0, 242, 0, 3)
Img.Size = UDim2.new(0, 100, 0, 95)
Img.Image = getcustomasset2('infiniteyield/assets/imgstudiopluginlogo.png')
Img.ZIndex = 10
AddPlugin.Name = 'AddPlugin'
AddPlugin.Parent = background_3
AddPlugin.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
AddPlugin.BorderSizePixel = 0
AddPlugin.Position = UDim2.new(0, 235, 0, 100)
AddPlugin.Size = UDim2.new(0, 115, 0, 50)
AddPlugin.Font = Enum.Font.SourceSans
AddPlugin.TextSize = 14
AddPlugin.Text = 'Add Plugin'
AddPlugin.TextColor3 = Color3.new(1, 1, 1)
AddPlugin.ZIndex = 10
table.insert(shade2, AddPlugin)
table.insert(text1, AddPlugin)
FileName.Name = 'FileName'
FileName.Parent = background_3
FileName.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
FileName.BorderSizePixel = 0
FileName.Position = UDim2.new(0.028, 0, 0.625, 0)
FileName.Size = UDim2.new(0, 200, 0, 50)
FileName.Font = Enum.Font.SourceSans
FileName.TextSize = 14
FileName.Text = 'Plugin File Name'
FileName.TextColor3 = Color3.new(1, 1, 1)
FileName.ZIndex = 10
table.insert(shade2, FileName)
table.insert(text1, FileName)
About.Name = 'About'
About.Parent = background_3
About.BackgroundTransparency = 1
About.BorderSizePixel = 0
About.Position = UDim2.new(0, 17, 0, 10)
About.Size = UDim2.new(0, 187, 0, 49)
About.Font = Enum.Font.SourceSans
About.TextSize = 14
About.Text = 'Plugins are .iy files and should be located in the \'workspace\' folder of your exploit.'
About.TextColor3 = Color3.fromRGB(255, 255, 255)
About.TextWrapped = true
About.TextYAlignment = Enum.TextYAlignment.Top
About.ZIndex = 10
table.insert(text1, About)
Directions_2.Name = 'Directions'
Directions_2.Parent = background_3
Directions_2.BackgroundTransparency = 1
Directions_2.BorderSizePixel = 0
Directions_2.Position = UDim2.new(0, 17, 0, 60)
Directions_2.Size = UDim2.new(0, 187, 0, 49)
Directions_2.Font = Enum.Font.SourceSans
Directions_2.TextSize = 14
Directions_2.Text = 'Type the name of the plugin file you want to add below.'
Directions_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Directions_2.TextWrapped = true
Directions_2.TextYAlignment = Enum.TextYAlignment.Top
Directions_2.ZIndex = 10
table.insert(text1, Directions_2)
shadow_3.Name = 'shadow'
shadow_3.Parent = PluginEditor
shadow_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
shadow_3.BorderSizePixel = 0
shadow_3.Size = UDim2.new(0, 360, 0, 20)
shadow_3.ZIndex = 10
table.insert(shade2, shadow_3)
PopupText_3.Name = 'PopupText'
PopupText_3.Parent = shadow_3
PopupText_3.BackgroundTransparency = 1
PopupText_3.Size = UDim2.new(1, 0, 0.95, 0)
PopupText_3.ZIndex = 10
PopupText_3.Font = Enum.Font.SourceSans
PopupText_3.TextSize = 14
PopupText_3.Text = 'Add Plugins'
PopupText_3.TextColor3 = Color3.new(1, 1, 1)
PopupText_3.TextWrapped = true
table.insert(text1, PopupText_3)
Exit_3.Name = 'Exit'
Exit_3.Parent = shadow_3
Exit_3.BackgroundTransparency = 1
Exit_3.Position = UDim2.new(1, -20, 0, 0)
Exit_3.Size = UDim2.new(0, 20, 0, 20)
Exit_3.Text = ''
Exit_3.ZIndex = 10
ExitImage_3.Parent = Exit_3
ExitImage_3.BackgroundColor3 = Color3.new(1, 1, 1)
ExitImage_3.BackgroundTransparency = 1
ExitImage_3.Position = UDim2.new(0, 5, 0, 5)
ExitImage_3.Size = UDim2.new(0, 10, 0, 10)
ExitImage_3.Image = getcustomasset2('infiniteyield/assets/close.png')
ExitImage_3.ZIndex = 10
AliasHint.Name = 'AliasHint'
AliasHint.Parent = AliasesFrame
AliasHint.BackgroundTransparency = 1
AliasHint.BorderSizePixel = 0
AliasHint.Position = UDim2.new(0, 25, 0, 40)
AliasHint.Size = UDim2.new(0, 200, 0, 50)
AliasHint.Font = Enum.Font.SourceSansItalic
AliasHint.TextSize = 16
AliasHint.Text = 'Add aliases by using the \'addalias\' command'
AliasHint.TextColor3 = Color3.new(1, 1, 1)
AliasHint.TextStrokeColor3 = Color3.new(1, 1, 1)
AliasHint.TextWrapped = true
AliasHint.ZIndex = 10
table.insert(text1, AliasHint)
PluginsHint.Name = 'PluginsHint'
PluginsHint.Parent = PluginsFrame
PluginsHint.BackgroundTransparency = 1
PluginsHint.BorderSizePixel = 0
PluginsHint.Position = UDim2.new(0, 25, 0, 40)
PluginsHint.Size = UDim2.new(0, 200, 0, 50)
PluginsHint.Font = Enum.Font.SourceSansItalic
PluginsHint.TextSize = 16
PluginsHint.Text = 'Download plugins from the IY Discord (discord.gg/78ZuWSq)'
PluginsHint.TextColor3 = Color3.new(1, 1, 1)
PluginsHint.TextStrokeColor3 = Color3.new(1, 1, 1)
PluginsHint.TextWrapped = true
PluginsHint.ZIndex = 10
table.insert(text1, PluginsHint)
PositionsHint.Name = 'PositionsHint'
PositionsHint.Parent = PositionsFrame
PositionsHint.BackgroundTransparency = 1
PositionsHint.BorderSizePixel = 0
PositionsHint.Position = UDim2.new(0, 25, 0, 40)
PositionsHint.Size = UDim2.new(0, 200, 0, 70)
PositionsHint.Font = Enum.Font.SourceSansItalic
PositionsHint.TextSize = 16
PositionsHint.Text = 'Use the \'swp\' or \'setwaypoint\' command to add a position using your character (NOTE: Part teleports will not save)'
PositionsHint.TextColor3 = Color3.new(1, 1, 1)
PositionsHint.TextStrokeColor3 = Color3.new(1, 1, 1)
PositionsHint.TextWrapped = true
PositionsHint.ZIndex = 10
table.insert(text1, PositionsHint)
ToPartFrame.Name = randomString()
ToPartFrame.Parent = ScaledHolder
ToPartFrame.Active = true
ToPartFrame.BackgroundTransparency = 1
ToPartFrame.Position = UDim2.new(0.5, -180, 0, -500)
ToPartFrame.Size = UDim2.new(0, 360, 0, 20)
ToPartFrame.ZIndex = 10
background_4.Name = 'background'
background_4.Parent = ToPartFrame
background_4.Active = true
background_4.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
background_4.BorderSizePixel = 0
background_4.Position = UDim2.new(0, 0, 0, 20)
background_4.Size = UDim2.new(0, 360, 0, 117)
background_4.ZIndex = 10
table.insert(shade1, background_4)
ChoosePart.Name = 'ChoosePart'
ChoosePart.Parent = background_4
ChoosePart.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
ChoosePart.BorderSizePixel = 0
ChoosePart.Position = UDim2.new(0, 100, 0, 55)
ChoosePart.Size = UDim2.new(0, 75, 0, 30)
ChoosePart.Font = Enum.Font.SourceSans
ChoosePart.TextSize = 14
ChoosePart.Text = 'Select Part'
ChoosePart.TextColor3 = Color3.new(1, 1, 1)
ChoosePart.ZIndex = 10
table.insert(shade2, ChoosePart)
table.insert(text1, ChoosePart)
CopyPath.Name = 'CopyPath'
CopyPath.Parent = background_4
CopyPath.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
CopyPath.BorderSizePixel = 0
CopyPath.Position = UDim2.new(0, 185, 0, 55)
CopyPath.Size = UDim2.new(0, 75, 0, 30)
CopyPath.Font = Enum.Font.SourceSans
CopyPath.TextSize = 14
CopyPath.Text = 'Copy Path'
CopyPath.TextColor3 = Color3.new(1, 1, 1)
CopyPath.ZIndex = 10
table.insert(shade2, CopyPath)
table.insert(text1, CopyPath)
Directions_3.Name = 'Directions'
Directions_3.Parent = background_4
Directions_3.BackgroundTransparency = 1
Directions_3.BorderSizePixel = 0
Directions_3.Position = UDim2.new(0, 51, 0, 17)
Directions_3.Size = UDim2.new(0, 257, 0, 32)
Directions_3.Font = Enum.Font.SourceSans
Directions_3.TextSize = 14
Directions_3.Text = 'Click on a part and then click the "Select Part" button below to set it as a teleport location'
Directions_3.TextColor3 = Color3.new(1, 1, 1)
Directions_3.TextWrapped = true
Directions_3.TextYAlignment = Enum.TextYAlignment.Top
Directions_3.ZIndex = 10
table.insert(text1, Directions_3)
Path.Name = 'Path'
Path.Parent = background_4
Path.BackgroundTransparency = 1
Path.BorderSizePixel = 0
Path.Position = UDim2.new(0, 0, 0, 94)
Path.Size = UDim2.new(0, 360, 0, 16)
Path.Font = Enum.Font.SourceSansItalic
Path.TextSize = 14
Path.Text = ''
Path.TextColor3 = Color3.new(1, 1, 1)
Path.TextScaled = true
Path.TextWrapped = true
Path.TextYAlignment = Enum.TextYAlignment.Top
Path.ZIndex = 10
table.insert(text1, Path)
shadow_4.Name = 'shadow'
shadow_4.Parent = ToPartFrame
shadow_4.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
shadow_4.BorderSizePixel = 0
shadow_4.Size = UDim2.new(0, 360, 0, 20)
shadow_4.ZIndex = 10
table.insert(shade2, shadow_4)
PopupText_5.Name = 'PopupText'
PopupText_5.Parent = shadow_4
PopupText_5.BackgroundTransparency = 1
PopupText_5.Size = UDim2.new(1, 0, 0.95, 0)
PopupText_5.ZIndex = 10
PopupText_5.Font = Enum.Font.SourceSans
PopupText_5.TextSize = 14
PopupText_5.Text = 'Teleport to Part'
PopupText_5.TextColor3 = Color3.new(1, 1, 1)
PopupText_5.TextWrapped = true
table.insert(text1, PopupText_5)
Exit_4.Name = 'Exit'
Exit_4.Parent = shadow_4
Exit_4.BackgroundTransparency = 1
Exit_4.Position = UDim2.new(1, -20, 0, 0)
Exit_4.Size = UDim2.new(0, 20, 0, 20)
Exit_4.Text = ''
Exit_4.ZIndex = 10
ExitImage_5.Parent = Exit_4
ExitImage_5.BackgroundColor3 = Color3.new(1, 1, 1)
ExitImage_5.BackgroundTransparency = 1
ExitImage_5.Position = UDim2.new(0, 5, 0, 5)
ExitImage_5.Size = UDim2.new(0, 10, 0, 10)
ExitImage_5.Image = getcustomasset2('infiniteyield/assets/close.png')
ExitImage_5.ZIndex = 10
logs.Name = randomString()
logs.Parent = ScaledHolder
logs.Active = true
logs.BackgroundTransparency = 1
logs.Position = UDim2.new(0, 0, 1, 10)
logs.Size = UDim2.new(0, 338, 0, 20)
logs.ZIndex = 10
shadow.Name = 'shadow'
shadow.Parent = logs
shadow.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
shadow.BorderSizePixel = 0
shadow.Position = UDim2.new(0, 0, 0.00999999978, 0)
shadow.Size = UDim2.new(0, 338, 0, 20)
shadow.ZIndex = 10
table.insert(shade2, shadow)
Hide.Name = 'Hide'
Hide.Parent = shadow
Hide.BackgroundTransparency = 1
Hide.Position = UDim2.new(1, -40, 0, 0)
Hide.Size = UDim2.new(0, 20, 0, 20)
Hide.ZIndex = 10
Hide.Text = ''
ImageLabel.Parent = Hide
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(0, 3, 0, 3)
ImageLabel.Size = UDim2.new(0, 14, 0, 14)
ImageLabel.Image = getcustomasset2('infiniteyield/assets/minimize.png')
ImageLabel.ZIndex = 10
PopupText.Name = 'PopupText'
PopupText.Parent = shadow
PopupText.BackgroundTransparency = 1
PopupText.Size = UDim2.new(1, 0, 0.949999988, 0)
PopupText.ZIndex = 10
PopupText.Font = Enum.Font.SourceSans
PopupText.FontSize = Enum.FontSize.Size14
PopupText.Text = 'Logs'
PopupText.TextColor3 = Color3.new(1, 1, 1)
PopupText.TextWrapped = true
table.insert(text1, PopupText)
Exit.Name = 'Exit'
Exit.Parent = shadow
Exit.BackgroundTransparency = 1
Exit.Position = UDim2.new(1, -20, 0, 0)
Exit.Size = UDim2.new(0, 20, 0, 20)
Exit.ZIndex = 10
Exit.Text = ''
ImageLabel_2.Parent = Exit
ImageLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel_2.BackgroundTransparency = 1
ImageLabel_2.Position = UDim2.new(0, 5, 0, 5)
ImageLabel_2.Size = UDim2.new(0, 10, 0, 10)
ImageLabel_2.Image = getcustomasset2('infiniteyield/assets/close.png')
ImageLabel_2.ZIndex = 10
background.Name = 'background'
background.Parent = logs
background.Active = true
background.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.145098)
background.BorderSizePixel = 0
background.ClipsDescendants = true
background.Position = UDim2.new(0, 0, 1, 0)
background.Size = UDim2.new(0, 338, 0, 245)
background.ZIndex = 10
chat.Name = 'chat'
chat.Parent = background
chat.Active = true
chat.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.145098)
chat.BorderSizePixel = 0
chat.ClipsDescendants = true
chat.Size = UDim2.new(0, 338, 0, 245)
chat.ZIndex = 10
table.insert(shade1, chat)
Clear.Name = 'Clear'
Clear.Parent = chat
Clear.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
Clear.BorderSizePixel = 0
Clear.Position = UDim2.new(0, 5, 0, 220)
Clear.Size = UDim2.new(0, 50, 0, 20)
Clear.ZIndex = 10
Clear.Font = Enum.Font.SourceSans
Clear.FontSize = Enum.FontSize.Size14
Clear.Text = 'Clear'
Clear.TextColor3 = Color3.new(1, 1, 1)
table.insert(shade2, Clear)
table.insert(text1, Clear)
SaveChatlogs.Name = 'SaveChatlogs'
SaveChatlogs.Parent = chat
SaveChatlogs.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
SaveChatlogs.BorderSizePixel = 0
SaveChatlogs.Position = UDim2.new(0, 258, 0, 220)
SaveChatlogs.Size = UDim2.new(0, 75, 0, 20)
SaveChatlogs.ZIndex = 10
SaveChatlogs.Font = Enum.Font.SourceSans
SaveChatlogs.FontSize = Enum.FontSize.Size14
SaveChatlogs.Text = 'Save To .txt'
SaveChatlogs.TextColor3 = Color3.new(1, 1, 1)
table.insert(shade2, SaveChatlogs)
table.insert(text1, SaveChatlogs)
Toggle.Name = 'Toggle'
Toggle.Parent = chat
Toggle.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
Toggle.BorderSizePixel = 0
Toggle.Position = UDim2.new(0, 60, 0, 220)
Toggle.Size = UDim2.new(0, 66, 0, 20)
Toggle.ZIndex = 10
Toggle.Font = Enum.Font.SourceSans
Toggle.FontSize = Enum.FontSize.Size14
Toggle.Text = 'Disabled'
Toggle.TextColor3 = Color3.new(1, 1, 1)
table.insert(shade2, Toggle)
table.insert(text1, Toggle)
scroll_2.Name = 'scroll'
scroll_2.Parent = chat
scroll_2.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
scroll_2.BorderSizePixel = 0
scroll_2.Position = UDim2.new(0, 5, 0, 25)
scroll_2.Size = UDim2.new(0, 328, 0, 190)
scroll_2.ZIndex = 10
scroll_2.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
scroll_2.CanvasSize = UDim2.new(0, 0, 0, 10)
scroll_2.ScrollBarThickness = 8
scroll_2.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
table.insert(scroll, scroll_2)
table.insert(shade2, scroll_2)
join.Name = 'join'
join.Parent = background
join.Active = true
join.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.145098)
join.BorderSizePixel = 0
join.ClipsDescendants = true
join.Size = UDim2.new(0, 338, 0, 245)
join.Visible = false
join.ZIndex = 10
table.insert(shade1, join)
Toggle_2.Name = 'Toggle'
Toggle_2.Parent = join
Toggle_2.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
Toggle_2.BorderSizePixel = 0
Toggle_2.Position = UDim2.new(0, 60, 0, 220)
Toggle_2.Size = UDim2.new(0, 66, 0, 20)
Toggle_2.ZIndex = 10
Toggle_2.Font = Enum.Font.SourceSans
Toggle_2.FontSize = Enum.FontSize.Size14
Toggle_2.Text = 'Disabled'
Toggle_2.TextColor3 = Color3.new(1, 1, 1)
table.insert(shade2, Toggle_2)
table.insert(text1, Toggle_2)
Clear_2.Name = 'Clear'
Clear_2.Parent = join
Clear_2.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
Clear_2.BorderSizePixel = 0
Clear_2.Position = UDim2.new(0, 5, 0, 220)
Clear_2.Size = UDim2.new(0, 50, 0, 20)
Clear_2.ZIndex = 10
Clear_2.Font = Enum.Font.SourceSans
Clear_2.FontSize = Enum.FontSize.Size14
Clear_2.Text = 'Clear'
Clear_2.TextColor3 = Color3.new(1, 1, 1)
table.insert(shade2, Clear_2)
table.insert(text1, Clear_2)
scroll_3.Name = 'scroll'
scroll_3.Parent = join
scroll_3.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
scroll_3.BorderSizePixel = 0
scroll_3.Position = UDim2.new(0, 5, 0, 25)
scroll_3.Size = UDim2.new(0, 328, 0, 190)
scroll_3.ZIndex = 10
scroll_3.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
scroll_3.CanvasSize = UDim2.new(0, 0, 0, 10)
scroll_3.ScrollBarThickness = 8
scroll_3.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
table.insert(scroll, scroll_3)
table.insert(shade2, scroll_3)
selectChat.Name = 'selectChat'
selectChat.Parent = background
selectChat.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
selectChat.BorderSizePixel = 0
selectChat.Position = UDim2.new(0, 5, 0, 5)
selectChat.Size = UDim2.new(0, 164, 0, 20)
selectChat.ZIndex = 10
selectChat.Font = Enum.Font.SourceSans
selectChat.FontSize = Enum.FontSize.Size14
selectChat.Text = 'Chat Logs'
selectChat.TextColor3 = Color3.new(1, 1, 1)
table.insert(shade2, selectChat)
table.insert(text1, selectChat)
selectJoin.Name = 'selectJoin'
selectJoin.Parent = background
selectJoin.BackgroundColor3 = Color3.new(0.305882, 0.305882, 0.309804)
selectJoin.BorderSizePixel = 0
selectJoin.Position = UDim2.new(0, 169, 0, 5)
selectJoin.Size = UDim2.new(0, 164, 0, 20)
selectJoin.ZIndex = 10
selectJoin.Font = Enum.Font.SourceSans
selectJoin.FontSize = Enum.FontSize.Size14
selectJoin.Text = 'Join Logs'
selectJoin.TextColor3 = Color3.new(1, 1, 1)
table.insert(shade3, selectJoin)
table.insert(text1, selectJoin)
create = function(map)
    local list = {}
    for _, v in pairs(map) do
        list[v[1]] = Instance.new(v[2])
    end
    for _, v in pairs(map) do
        for k2, v2 in pairs(v[3]) do
            if type(v2) == 'table' then
                list[v[1]][k2] = list[v2[1]]
            else
                list[v[1]][k2] = v2
            end
        end
    end
    return list[1]
end
ViewportTextBox = (function()
    local __index = {Update = function(number)
        local cursorPosition = number.TextBox.CursorPosition
        local text = number.TextBox.Text
        if text == '' then
            number.TextBox.Position = UDim2.new(0, 2, 0, 0)
            return
        elseif cursorPosition == -1 then
            return
        else
            local result = text:sub(1, cursorPosition - 1)
            local xOffset
            local v1 = -number.TextBox.Position.X.Offset
            local v2 = v1 + number.View.AbsoluteSize.X
            local x = TextService:GetTextSize(text, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X
            xOffset = if v2 < TextService:GetTextSize(result, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X then math.max(-2, TextService:GetTextSize(result, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X - number.View.AbsoluteSize.X + 2) else if TextService:GetTextSize(result, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X >= v1 then if x >= v2 then math.max(-2, TextService:GetTextSize(result, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X - number.View.AbsoluteSize.X + 2) else math.max(-2, x - number.View.AbsoluteSize.X + 2) else math.max(-2, TextService:GetTextSize(result, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X - 2)
            if xOffset then
                number.TextBox.Position = UDim2.new(0, -xOffset, 0, 0)
                number.TextBox.Size = UDim2.new(1, xOffset, 1, 0)
            end
        end
    end}
    local class = {__index = __index}
    return {convert = function(textBox)
        local object = setmetatable({OffsetX = 0, TextBox = textBox}, class)
        local frame = Instance.new('Frame')
        frame.BackgroundTransparency = textBox.BackgroundTransparency
        frame.BackgroundColor3 = textBox.BackgroundColor3
        frame.BorderSizePixel = textBox.BorderSizePixel
        frame.BorderColor3 = textBox.BorderColor3
        frame.Position = textBox.Position
        frame.Size = textBox.Size
        frame.ClipsDescendants = true
        frame.Name = textBox.Name
        frame.ZIndex = 10
        textBox.BackgroundTransparency = 1
        textBox.Position = UDim2.new(0, 4, 0, 0)
        textBox.Size = UDim2.new(1, -8, 1, 0)
        textBox.TextXAlignment = Enum.TextXAlignment.Left
        textBox.Name = 'Input'
        table.insert(text1, textBox)
        table.insert(shade2, frame)
        object.View = frame
        textBox.Changed:Connect(function(value)
            if value == 'Text' or value == 'CursorPosition' or value == 'AbsoluteSize' then
                object:Update()
            end
        end)
        object:Update()
        frame.Parent = textBox.Parent
        textBox.Parent = frame
        return object
    end}
end)()
ViewportTextBox.convert(Cmdbar).View.ZIndex = 10
ViewportTextBox.convert(Cmdbar_2).View.ZIndex = 10
ViewportTextBox.convert(Cmdbar_3).View.ZIndex = 10
writefileExploit = function()
    if writefile then
        return true
    end
end
readfileExploit = function()
    if readfile then
        return true
    end
end
isNumber = function(text)
    if tonumber(text) ~= nil or text == 'inf' then
        return true
    end
end
vtype = function(value, arg2)
    if value == nil then
        return false
    end
    if type(value) == 'userdata' then
        return typeof(value) == arg2
    end
    return type(value) == arg2
end
getRoot = function(parent)
    if parent and parent:FindFirstChildOfClass('Humanoid') then
        return parent:FindFirstChildOfClass('Humanoid').RootPart
    end
    return nil
end
tools = function(parent)
    if parent:FindFirstChildOfClass('Backpack'):FindFirstChildOfClass('Tool') or parent.Character:FindFirstChildOfClass('Tool') then
        return true
    end
end
r15 = function(player)
    if player.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R15 then
        return true
    end
end
breakVelocity = function()
    local vector3 = Vector3.new(0, 0, 0)
    for _, descendant in ipairs(Players.LocalPlayer.Character:GetDescendants()) do
        if not descendant:IsA('BasePart') then
            continue
        end
        descendant.Velocity = vector3
        descendant.RotVelocity = vector3
    end
end
toClipboard = function(value)
    if everyClipboard then
        everyClipboard(tostring(value))
        notify('Clipboard', 'Copied to clipboard')
        return
    end
    notify('Clipboard', 'Your exploit doesn\'t have the ability to use the clipboard')
end
chatMessage = function(value)
    value = tostring(value)
    if not isLegacyChat then
        TextChatService.TextChannels.RBXGeneral:SendAsync(value)
        return
    end
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(value, 'All')
end
getHierarchy = function(text)
    local name
    local flag
    if string.find(text.Name, ' ') then
        name = '["' .. text.Name .. '"]'
        flag = false
    else
        name = text.Name
        flag = true
    end
    local parent = text
    local parent2 = text
    local className = ''
    if parent.Parent ~= game then
        repeat
            parent = parent.Parent
            className = parent.ClassName
        until parent.Parent == game
    end
    if parent2.Parent ~= parent then
        while true do
            parent2 = parent2.Parent
            flag = if string.find(tostring(parent2), ' ') then false else true
            if parent2.Parent == parent then
                break
            end
        end
    elseif string.find(tostring(parent2), ' ') then
        name = '["' .. parent2.Name .. '"]'
        flag = false
    end
    if flag then
        return 'game:GetService("' .. className .. '").' .. name
    end
    return 'game:GetService("' .. className .. '")' .. name
end
AllWaypoints = {}
local flag = false
writefileCooldown = function(arg1, arg2)
    task.spawn(function()
        if not flag then
            flag = true
            writefile(arg1, arg2, true)
        else
            repeat
                wait()
            until flag == false
            writefileCooldown(arg1, arg2)
        end
        wait(3)
        flag = false
    end)
end
dragGUI = function(instance)
    task.spawn(function()
        local v1
        local v2
        local vector3 = Vector3.new(0, 0, 0)
        local v3
        local function update(arg1)
            local v1 = arg1.Position - vector3
            local udim2 = UDim2.new(v3.X.Scale, v3.X.Offset + v1.X, v3.Y.Scale, v3.Y.Offset + v1.Y)
            TweenService:Create(instance, TweenInfo.new(0.2), {Position = udim2}):Play()
        end
        instance.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                v1 = true
                vector3 = input.Position
                v3 = instance.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        v1 = false
                    end
                end)
            end
        end)
        instance.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                v2 = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == v2 and v1 then
                update(input)
            end
        end)
    end)
end
dragGUI(logs)
dragGUI(KeybindEditor)
dragGUI(PluginEditor)
dragGUI(ToPartFrame)
eventEditor = (function()
    local map = {}
    local function registerEvent(arg1, arg2)
        map[arg1] = {commands = {}, sets = arg2 or {}}
    end
    local callback
    local function fireEvent(arg1, ...)
        local map2 = {...}
        local entry = map[arg1]
        if entry then
            for k, command in pairs(entry.commands) do
                local index = true
                for k2, set in pairs(entry.sets) do
                    local text = map2[k2]
                    local text3 = command[2][k2]
                    local type2 = set.Type
                    if type2 == 'Player' then
                        if text3 == 0 then
                            index = index and tostring(Players.LocalPlayer) == text
                        else
                            if text3 ~= 1 then
                                index = index and table.find(getPlayer(text3, Players.LocalPlayer), text)
                            end
                        end
                    elseif type2 == 'String' then
                        if text3 ~= 0 then
                            local find = index
                            if find then
                                find = string.find
                                find = find(text:lower(), text3:lower())
                            end
                            index = find
                        end
                    elseif type2 == 'Number' and text3 ~= 0 then
                        index = index and tonumber(text) <= tonumber(text3)
                    end
                    if not index then
                        break
                    end
                end
                if not index then
                    continue
                end
                pcall(task.spawn(function()
                    local text = command[1]
                    for k, v in pairs(map2) do
                        text = text:gsub('%$' .. k, v)
                    end
                    if text:lower():match('plugin') then
                        return
                    end
                    wait(command[3] or 0)
                    execCmd(text)
                end))
            end
        end
    end
    local parent = create({{1, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'EventEditor', Position = UDim2.new(0.5, -175, 0, -500), Size = UDim2.new(0, 350, 0, 20), ZIndex = 10}}, {2, 'Frame', {BackgroundColor3 = currentShade2, BorderSizePixel = 0, Name = 'TopBar', Parent = {1}, Size = UDim2.new(1, 0, 0, 20), ZIndex = 10}}, {3, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {2}, Position = UDim2.new(0, 0, 0, 0), Size = UDim2.new(1, 0, 0.95, 0), Text = 'Event Editor', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 10}}, {4, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Close', Parent = {2}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 20), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, ZIndex = 10}}, {5, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = getcustomasset2('infiniteyield/assets/close.png'), Parent = {4}, Position = UDim2.new(0, 5, 0, 5), Size = UDim2.new(0, 10, 0, 10), ZIndex = 10}}, {6, 'Frame', {BackgroundColor3 = currentShade1, BorderSizePixel = 0, Name = 'Content', Parent = {1}, Position = UDim2.new(0, 0, 0, 20), Size = UDim2.new(1, 0, 0, 202), ZIndex = 10}}, {7, 'ScrollingFrame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png', CanvasSize = UDim2.new(0, 0, 0, 100), Name = 'List', Parent = {6}, Position = UDim2.new(0, 5, 0, 5), ScrollBarImageColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052), ScrollBarThickness = 8, Size = UDim2.new(1, -10, 1, -10), TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png', ZIndex = 10}}, {8, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Holder', Parent = {7}, Size = UDim2.new(1, 0, 1, 0), ZIndex = 10}}, {9, 'UIListLayout', {Parent = {8}, SortOrder = 2}}, {10, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.3137255012989, 0.3137255012989, 0.3137255012989), BorderSizePixel = 0, ClipsDescendants = true, Name = 'Settings', Parent = {6}, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 150, 1, 0), ZIndex = 10}}, {11, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833), Name = 'Slider', Parent = {10}, Position = UDim2.new(0, -150, 0, 0), Size = UDim2.new(1, 0, 1, 0), ZIndex = 10}}, {12, 'Frame', {BackgroundColor3 = Color3.new(0.23529413342476, 0.23529413342476, 0.23529413342476), BorderColor3 = Color3.new(0.3137255012989, 0.3137255012989, 0.3137255012989), BorderSizePixel = 0, Name = 'Line', Parent = {11}, Size = UDim2.new(0, 1, 1, 0), ZIndex = 10}}, {13, 'ScrollingFrame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png', CanvasSize = UDim2.new(0, 0, 0, 100), Name = 'List', Parent = {11}, Position = UDim2.new(0, 0, 0, 25), ScrollBarImageColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052), ScrollBarThickness = 8, Size = UDim2.new(1, 0, 1, -25), TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png', ZIndex = 10}}, {14, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Holder', Parent = {13}, Size = UDim2.new(1, 0, 1, 0), ZIndex = 10}}, {15, 'UIListLayout', {Parent = {14}, SortOrder = 2}}, {16, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {11}, Size = UDim2.new(1, 0, 0, 20), Text = 'Event Settings', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, ZIndex = 10}}, {17, 'TextButton', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833), BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), Font = 3, Name = 'Close', BorderSizePixel = 0, Parent = {11}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 20), Text = '<', TextColor3 = Color3.new(1, 1, 1), TextSize = 18, ZIndex = 10}}, {18, 'Folder', {Name = 'Templates', Parent = {10}}}, {19, 'Frame', {BackgroundColor3 = Color3.new(0.19607844948769, 0.19607844948769, 0.19607844948769), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), Name = 'Players', Parent = {18}, Position = UDim2.new(0, 0, 0, 25), Size = UDim2.new(1, 0, 0, 86), Visible = false, ZIndex = 10}}, {20, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {19}, Size = UDim2.new(1, 0, 0, 20), Text = 'Choose Players', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, ZIndex = 10}}, {21, 'TextLabel', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Any', Parent = {19}, Position = UDim2.new(0, 5, 0, 42), Size = UDim2.new(1, -10, 0, 20), Text = 'Any Player', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {22, 'Frame', {BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052), BorderSizePixel = 0, Name = 'Button', Parent = {21}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 20), ZIndex = 10}}, {23, 'TextButton', {BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'On', Parent = {22}, Position = UDim2.new(0, 2, 0, 2), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14, ZIndex = 10}}, {24, 'TextLabel', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Me', Parent = {19}, Position = UDim2.new(0, 5, 0, 20), Size = UDim2.new(1, -10, 0, 20), Text = 'Me Only', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {25, 'Frame', {BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052), BorderSizePixel = 0, Name = 'Button', Parent = {24}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 20), ZIndex = 10}}, {26, 'TextButton', {BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'On', Parent = {25}, Position = UDim2.new(0, 2, 0, 2), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14, ZIndex = 10}}, {27, 'TextBox', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, ClearTextOnFocus = false, Font = 3, Name = 'Custom', Parent = {19}, PlaceholderColor3 = Color3.new(0.47058826684952, 0.47058826684952, 0.47058826684952), PlaceholderText = 'Custom Player Set', Position = UDim2.new(0, 5, 0, 64), Size = UDim2.new(1, -35, 0, 20), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {28, 'Frame', {BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052), BorderSizePixel = 0, Name = 'CustomButton', Parent = {19}, Position = UDim2.new(1, -25, 0, 64), Size = UDim2.new(0, 20, 0, 20), ZIndex = 10}}, {29, 'TextButton', {BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'On', Parent = {28}, Position = UDim2.new(0, 2, 0, 2), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14, ZIndex = 10}}, {30, 'Frame', {BackgroundColor3 = Color3.new(0.19607844948769, 0.19607844948769, 0.19607844948769), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), Name = 'Strings', Parent = {18}, Position = UDim2.new(0, 0, 0, 25), Size = UDim2.new(1, 0, 0, 64), Visible = false, ZIndex = 10}}, {31, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {30}, Size = UDim2.new(1, 0, 0, 20), Text = 'Choose String', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, ZIndex = 10}}, {32, 'TextLabel', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Any', Parent = {30}, Position = UDim2.new(0, 5, 0, 20), Size = UDim2.new(1, -10, 0, 20), Text = 'Any String', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {33, 'Frame', {BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052), BorderSizePixel = 0, Name = 'Button', Parent = {32}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 20), ZIndex = 10}}, {34, 'TextButton', {BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'On', Parent = {33}, Position = UDim2.new(0, 2, 0, 2), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14, ZIndex = 10}}, {54, 'Frame', {BackgroundColor3 = Color3.new(0.19607844948769, 0.19607844948769, 0.19607844948769), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), Name = 'Numbers', Parent = {18}, Position = UDim2.new(0, 0, 0, 25), Size = UDim2.new(1, 0, 0, 64), Visible = false, ZIndex = 10}}, {55, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {54}, Size = UDim2.new(1, 0, 0, 20), Text = 'Choose String', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, ZIndex = 10}}, {56, 'TextLabel', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Any', Parent = {54}, Position = UDim2.new(0, 5, 0, 20), Size = UDim2.new(1, -10, 0, 20), Text = 'Any Number', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {57, 'Frame', {BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052), BorderSizePixel = 0, Name = 'Button', Parent = {56}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 20), ZIndex = 10}}, {58, 'TextButton', {BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'On', Parent = {57}, Position = UDim2.new(0, 2, 0, 2), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14, ZIndex = 10}}, {59, 'TextBox', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, ClearTextOnFocus = false, Font = 3, Name = 'Custom', Parent = {54}, PlaceholderColor3 = Color3.new(0.47058826684952, 0.47058826684952, 0.47058826684952), PlaceholderText = 'Number', Position = UDim2.new(0, 5, 0, 42), Size = UDim2.new(1, -35, 0, 20), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {60, 'Frame', {BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052), BorderSizePixel = 0, Name = 'CustomButton', Parent = {54}, Position = UDim2.new(1, -25, 0, 42), Size = UDim2.new(0, 20, 0, 20), ZIndex = 10}}, {61, 'TextButton', {BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'On', Parent = {60}, Position = UDim2.new(0, 2, 0, 2), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14, ZIndex = 10}}, {35, 'TextBox', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, ClearTextOnFocus = false, Font = 3, Name = 'Custom', Parent = {30}, PlaceholderColor3 = Color3.new(0.47058826684952, 0.47058826684952, 0.47058826684952), PlaceholderText = 'Match String', Position = UDim2.new(0, 5, 0, 42), Size = UDim2.new(1, -35, 0, 20), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {36, 'Frame', {BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052), BorderSizePixel = 0, Name = 'CustomButton', Parent = {30}, Position = UDim2.new(1, -25, 0, 42), Size = UDim2.new(0, 20, 0, 20), ZIndex = 10}}, {37, 'TextButton', {BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'On', Parent = {36}, Position = UDim2.new(0, 2, 0, 2), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14, ZIndex = 10}}, {38, 'Frame', {BackgroundColor3 = Color3.new(0.19607844948769, 0.19607844948769, 0.19607844948769), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), Name = 'DelayEditor', Parent = {18}, Position = UDim2.new(0, 0, 0, 25), Size = UDim2.new(1, 0, 0, 24), Visible = false, ZIndex = 10}}, {39, 'TextBox', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, Font = 3, Name = 'Secs', Parent = {38}, PlaceholderColor3 = Color3.new(0.47058826684952, 0.47058826684952, 0.47058826684952), Position = UDim2.new(0, 60, 0, 2), Size = UDim2.new(1, -65, 0, 20), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {40, 'TextLabel', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Label', Parent = {39}, Position = UDim2.new(0, -55, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = 'Delay (s):', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {41, 'Frame', {BackgroundColor3 = currentShade1, BorderSizePixel = 0, ClipsDescendants = true, Name = 'EventTemplate', Parent = {6}, Size = UDim2.new(1, 0, 0, 20), Visible = false, ZIndex = 10}}, {42, 'TextButton', {BackgroundColor3 = currentText1, BackgroundTransparency = 1, Font = 3, Name = 'Expand', Parent = {41}, Size = UDim2.new(0, 20, 0, 20), Text = '>', TextColor3 = Color3.new(1, 1, 1), TextSize = 18, ZIndex = 10}}, {43, 'TextLabel', {BackgroundColor3 = currentText1, BackgroundTransparency = 1, Font = 3, Name = 'EventName', Parent = {41}, Position = UDim2.new(0, 25, 0, 0), Size = UDim2.new(1, -25, 0, 20), Text = 'OnSpawn', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {44, 'Frame', {BackgroundColor3 = Color3.new(0.19607844948769, 0.19607844948769, 0.19607844948769), BorderSizePixel = 0, BackgroundTransparency = 1, ClipsDescendants = true, Name = 'Cmds', Parent = {41}, Position = UDim2.new(0, 0, 0, 20), Size = UDim2.new(1, 0, 1, -20), ZIndex = 10}}, {45, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833), BorderColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), Name = 'Add', Parent = {44}, Position = UDim2.new(0, 0, 1, -20), Size = UDim2.new(1, 0, 0, 20), ZIndex = 10}}, {46, 'TextBox', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ClearTextOnFocus = false, Font = 3, Parent = {45}, PlaceholderColor3 = Color3.new(0.7843137383461, 0.7843137383461, 0.7843137383461), PlaceholderText = 'Add new command', Position = UDim2.new(0, 5, 0, 0), Size = UDim2.new(1, -10, 1, 0), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {47, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Holder', Parent = {44}, Size = UDim2.new(1, 0, 1, -20), ZIndex = 10}}, {48, 'UIListLayout', {Parent = {47}, SortOrder = 2}}, {49, 'Frame', {currentShade1, BorderSizePixel = 0, ClipsDescendants = true, Name = 'CmdTemplate', Parent = {6}, Size = UDim2.new(1, 0, 0, 20), Visible = false, ZIndex = 10}}, {50, 'TextBox', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ClearTextOnFocus = false, Font = 3, Parent = {49}, PlaceholderColor3 = Color3.new(1, 1, 1), Position = UDim2.new(0, 5, 0, 0), Size = UDim2.new(1, -45, 0, 20), Text = 'a\\b\\c\\d', TextColor3 = currentText1, TextSize = 14, TextXAlignment = 0, ZIndex = 10}}, {51, 'TextButton', {BackgroundColor3 = currentShade1, BorderSizePixel = 0, Font = 3, Name = 'Delete', Parent = {49}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 20), Text = 'X', TextColor3 = Color3.new(1, 1, 1), TextSize = 18, ZIndex = 10}}, {52, 'TextButton', {BackgroundColor3 = currentShade1, BorderSizePixel = 0, Font = 3, Name = 'Settings', Parent = {49}, Position = UDim2.new(1, -40, 0, 0), Size = UDim2.new(0, 20, 0, 20), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 18, ZIndex = 10}}, {53, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = getcustomasset2('infiniteyield/assets/settings.png'), Parent = {52}, Position = UDim2.new(0, 2, 0, 2), Size = UDim2.new(0, 16, 0, 16), ZIndex = 10}}})
    parent.Name = randomString()
    local content = parent:WaitForChild('Content')
    local list = content:WaitForChild('List')
    local holder = list:WaitForChild('Holder')
    local cmdTemplate = content:WaitForChild('CmdTemplate')
    local eventTemplate = content:WaitForChild('EventTemplate')
    local slider = content:WaitForChild('Settings'):WaitForChild('Slider')
    local templates = content.Settings:WaitForChild('Templates')
    local holder2 = slider:WaitForChild('List'):WaitForChild('Holder')
    table.insert(shade2, parent.TopBar)
    table.insert(shade1, content)
    table.insert(shade2, eventTemplate)
    table.insert(text1, eventTemplate.EventName)
    table.insert(shade1, eventTemplate.Cmds.Add)
    table.insert(shade1, cmdTemplate)
    table.insert(text1, cmdTemplate.TextBox)
    table.insert(shade2, cmdTemplate.Delete)
    table.insert(shade2, cmdTemplate.Settings)
    table.insert(scroll, content.List)
    table.insert(shade1, slider)
    table.insert(shade2, slider.Line)
    table.insert(shade2, slider.Close)
    table.insert(scroll, slider.List)
    table.insert(shade2, templates.DelayEditor.Secs)
    table.insert(text1, templates.DelayEditor.Secs)
    table.insert(text1, templates.DelayEditor.Secs.Label)
    table.insert(text1, templates.Players.Title)
    table.insert(shade3, templates.Players.CustomButton)
    table.insert(shade2, templates.Players.Custom)
    table.insert(text1, templates.Players.Custom)
    table.insert(shade3, templates.Players.Any.Button)
    table.insert(shade3, templates.Players.Me.Button)
    table.insert(text1, templates.Players.Any)
    table.insert(text1, templates.Players.Me)
    table.insert(text1, templates.Strings.Title)
    table.insert(text1, templates.Strings.Any)
    table.insert(shade3, templates.Strings.Any.Button)
    table.insert(shade3, templates.Strings.CustomButton)
    table.insert(text1, templates.Strings.Custom)
    table.insert(shade2, templates.Strings.Custom)
    table.insert(text1, templates.Players.Me)
    table.insert(text1, templates.Numbers.Title)
    table.insert(text1, templates.Numbers.Any)
    table.insert(shade3, templates.Numbers.Any.Button)
    table.insert(shade3, templates.Numbers.CustomButton)
    table.insert(text1, templates.Numbers.Custom)
    table.insert(shade2, templates.Numbers.Custom)
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local v1
    slider:WaitForChild('Close').MouseButton1Click:Connect(function()
        slider:TweenPosition(UDim2.new(0, -150, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
    end)
    local function resizeList()
        local total = 0
        for _, child in pairs(holder:GetChildren()) do
            if child.Name ~= 'EventTemplate' then
                continue
            end
            total += 20
            if child.Expand.Rotation ~= 90 then
                continue
            end
            total += 20 * (1 + (#map[child.EventName:GetAttribute('RawName')].commands or 0))
        end
        TweenService:Create(list, tweenInfo, {CanvasSize = UDim2.new(0, 0, 0, total)}):Play()
        if list.AbsoluteSize.Y < total then
            holder.Size = UDim2.new(1, -8, 1, 0)
            return
        end
        holder.Size = UDim2.new(1, 0, 1, 0)
    end
    local function resizeSettingsList()
        local total = 0
        for _, child in pairs(holder2:GetChildren()) do
            if not child:IsA('Frame') then
                continue
            end
            total += child.AbsoluteSize.Y
        end
        holder2.Parent.CanvasSize = UDim2.new(0, 0, 0, total)
        if holder2.Parent.AbsoluteSize.Y < total then
            holder2.Size = UDim2.new(1, -8, 1, 0)
            return
        end
        holder2.Size = UDim2.new(1, 0, 1, 0)
    end
    local function setupCheckbox(arg1, callback)
        local v1 = arg1.On.BackgroundTransparency == 0
        local function update()
            arg1.On.BackgroundTransparency = v1 and 0 or 1
        end
        arg1.On.MouseButton1Click:Connect(function()
            v1 = not v1
            update()
            if callback then
                callback(v1)
            end
        end)
        return {Toggle = function(arg1)
            v1 = not v1
            update()
            if not arg1 and callback then
                callback(v1)
            end
        end, Enable = function(arg1)
            if v1 then
                return
            end
            v1 = true
            update()
            if not arg1 and callback then
                callback(v1)
            end
        end, Disable = function(arg1)
            if not v1 then
                return
            end
            v1 = false
            update()
            if not arg1 and callback then
                callback(v1)
            end
        end, IsEnabled = function()
            return v1
        end}
    end
    local function openSettingsEditor(arg1, list)
        v1 = list
        for _, child in pairs(holder2:GetChildren()) do
            if not child:IsA('Frame') then
                continue
            end
            child:Destroy()
        end
        local clone = templates.DelayEditor:Clone()
        clone.Secs.FocusLost:Connect(function()
            list[3] = tonumber(clone.Secs.Text) or 0
            clone.Secs.Text = list[3]
            if callback then
                callback()
            end
        end)
        clone.Secs.Text = list[3]
        clone.Visible = true
        table.insert(shade2, clone.Secs)
        table.insert(text1, clone.Secs)
        table.insert(text1, clone.Secs.Label)
        clone.Parent = holder2
        for k, set in pairs(arg1.sets) do
            if set.Type == 'Player' then
                local clone2 = templates.Players:Clone()
                clone2.Title.Text = set.Name or 'Player'
                local result
                local result2
                local result3
                result = setupCheckbox(clone2.Me.Button, function(arg1)
                    if not arg1 then
                        return
                    end
                    result2.Disable()
                    result3.Disable()
                    list[2][k] = 0
                    if callback then
                        callback()
                    end
                end)
                result2 = setupCheckbox(clone2.Any.Button, function(arg1)
                    if not arg1 then
                        return
                    end
                    result.Disable()
                    result3.Disable()
                    list[2][k] = 1
                    if callback then
                        callback()
                    end
                end)
                local custom = clone2.Custom
                result3 = setupCheckbox(clone2.CustomButton, function(arg1)
                    if not arg1 then
                        return
                    end
                    result.Disable()
                    result2.Disable()
                    list[2][k] = custom.Text
                    if callback then
                        callback()
                    end
                end)
                ViewportTextBox.convert(custom)
                custom.FocusLost:Connect(function()
                    if result3:IsEnabled() then
                        list[2][k] = custom.Text
                        if callback then
                            callback()
                        end
                    end
                end)
                local text = list[2][k]
                if text == 0 then
                    result:Enable()
                elseif text == 1 then
                    result2:Enable()
                else
                    result3:Enable()
                    custom.Text = text
                end
                clone2.Visible = true
                table.insert(text1, clone2.Title)
                table.insert(shade3, clone2.CustomButton)
                table.insert(shade3, clone2.Any.Button)
                table.insert(shade3, clone2.Me.Button)
                table.insert(text1, clone2.Any)
                table.insert(text1, clone2.Me)
                clone2.Parent = holder2
            elseif set.Type == 'String' then
                local clone3 = templates.Strings:Clone()
                clone3.Title.Text = set.Name or 'String'
                local result4
                local result5
                result4 = setupCheckbox(clone3.Any.Button, function(arg1)
                    if not arg1 then
                        return
                    end
                    result5.Disable()
                    list[2][k] = 0
                    if callback then
                        callback()
                    end
                end)
                local custom2 = clone3.Custom
                result5 = setupCheckbox(clone3.CustomButton, function(arg1)
                    if not arg1 then
                        return
                    end
                    result4.Disable()
                    list[2][k] = custom2.Text
                    if callback then
                        callback()
                    end
                end)
                ViewportTextBox.convert(custom2)
                custom2.FocusLost:Connect(function()
                    if result5:IsEnabled() then
                        list[2][k] = custom2.Text
                        if callback then
                            callback()
                        end
                    end
                end)
                local text3 = list[2][k]
                if text3 == 0 then
                    result4:Enable()
                else
                    result5:Enable()
                    custom2.Text = text3
                end
                clone3.Visible = true
                table.insert(text1, clone3.Title)
                table.insert(text1, clone3.Any)
                table.insert(shade3, clone3.Any.Button)
                table.insert(shade3, clone3.CustomButton)
                clone3.Parent = holder2
            elseif set.Type == 'Number' then
                local clone4 = templates.Numbers:Clone()
                clone4.Title.Text = set.Name or 'Number'
                local result6
                local result7
                result6 = setupCheckbox(clone4.Any.Button, function(arg1)
                    if not arg1 then
                        return
                    end
                    result7.Disable()
                    list[2][k] = 0
                    if callback then
                        callback()
                    end
                end)
                local custom3 = clone4.Custom
                result7 = setupCheckbox(clone4.CustomButton, function(arg1)
                    if not arg1 then
                        return
                    end
                    result6.Disable()
                    list[2][k] = custom3.Text
                    if callback then
                        callback()
                    end
                end)
                ViewportTextBox.convert(custom3)
                custom3.FocusLost:Connect(function()
                    list[2][k] = tonumber(custom3.Text) or 0
                    custom3.Text = list[2][k]
                    if result7:IsEnabled() and callback then
                        callback()
                    end
                end)
                local text4 = list[2][k]
                if text4 == 0 then
                    result6:Enable()
                else
                    result7:Enable()
                    custom3.Text = text4
                end
                clone4.Visible = true
                table.insert(text1, clone4.Title)
                table.insert(text1, clone4.Any)
                table.insert(shade3, clone4.Any.Button)
                table.insert(shade3, clone4.CustomButton)
                clone4.Parent = holder2
            end
        end
        resizeSettingsList()
        slider:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
    end
    local function defaultSettings(arg1)
        local list = {}
        for _, set in pairs(arg1.sets) do
            if set.Type == 'Player' then
                list[#list + 1] = set.Default or 0
            elseif set.Type == 'String' then
                list[#list + 1] = set.Default or 0
            elseif set.Type == 'Number' then
                list[#list + 1] = set.Default or 0
            end
        end
        return list
    end
    local function refreshList()
        for _, child in pairs(holder:GetChildren()) do
            if not child:IsA('Frame') then
                continue
            end
            child:Destroy()
        end
        for k, v in pairs(map) do
            local clone = eventTemplate:Clone()
            clone.EventName.Text = k
            clone.Visible = true
            clone.EventName:SetAttribute('RawName', k)
            table.insert(shade2, clone)
            table.insert(text1, clone.EventName)
            table.insert(shade1, clone.Cmds.Add)
            local flag = false
            clone.Expand.MouseButton1Down:Connect(function()
                flag = not flag
                clone:TweenSize(UDim2.new(1, 0, 0, 20 + (flag and 20 * #clone.Cmds.Holder:GetChildren() or 0)), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
                clone.Expand.Rotation = flag and 90 or 0
                resizeList()
            end)
            local function refreshCommands()
                for _, child in pairs(clone.Cmds.Holder:GetChildren()) do
                    if child.Name ~= 'CmdTemplate' then
                        continue
                    end
                    child:Destroy()
                end
                clone.EventName.Text = k .. (#v.commands > 0 and ' (' .. #v.commands .. ')' or '')
                for k3, command in pairs(v.commands) do
                    local clone2 = cmdTemplate:Clone()
                    local textBox = clone2.TextBox
                    ViewportTextBox.convert(textBox)
                    textBox.Text = command[1]
                    clone2.Visible = true
                    table.insert(shade1, clone2)
                    table.insert(shade2, clone2.Delete)
                    table.insert(shade2, clone2.Settings)
                    textBox.FocusLost:Connect(function()
                        v.commands[k3] = {textBox.Text, command[2], command[3]}
                        if callback then
                            callback()
                        end
                    end)
                    clone2.Settings.MouseButton1Click:Connect(function()
                        openSettingsEditor(v, command)
                    end)
                    clone2.Delete.MouseButton1Click:Connect(function()
                        table.remove(v.commands, k3)
                        refreshCommands()
                        resizeList()
                        if v1 == command then
                            slider:TweenPosition(UDim2.new(0, -150, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
                        end
                        if callback then
                            callback()
                        end
                    end)
                    clone2.Parent = clone.Cmds.Holder
                end
                clone:TweenSize(UDim2.new(1, 0, 0, 20 + (flag and 20 * #clone.Cmds.Holder:GetChildren() or 0)), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
            end
            local textBox = clone.Cmds.Add.TextBox
            ViewportTextBox.convert(textBox)
            textBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    v.commands[#v.commands + 1] = {textBox.Text, defaultSettings(v), 0}
                    textBox.Text = ''
                    refreshCommands()
                    resizeList()
                    if callback then
                        callback()
                    end
                end
            end)
            clone.Parent = holder
            refreshCommands()
        end
        resizeList()
    end
    local function saveData()
        local value = {}
        for k, v in pairs(map) do
            value[k] = v.commands
        end
        return HttpService:JSONEncode(value)
    end
    local function loadData(json)
        local map2 = HttpService:JSONDecode(json)
        for k, v in pairs(map2) do
            if not map[k] then
                continue
            end
            map[k].commands = v
        end
    end
    local function addCmd(arg1, item)
        table.insert(map[arg1].commands, item)
    end
    local function setOnEdited(value)
        if type(value) == 'function' then
            callback = value
        end
    end
    parent.TopBar.Close.MouseButton1Click:Connect(function()
        parent:TweenPosition(UDim2.new(0.5, -175, 0, -500), 'InOut', 'Quart', 0.5, true, nil)
    end)
    dragGUI(parent)
    parent.Parent = ScaledHolder
    return {RegisterEvent = registerEvent, FireEvent = fireEvent, Refresh = refreshList, SaveData = saveData, LoadData = loadData, AddCmd = addCmd, Frame = parent, SetOnEdited = setOnEdited}
end)()
reference = (function()
    local parent = create({{1, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, Name = 'Main', Position = UDim2.new(0.5, -250, 0, -500), Size = UDim2.new(0, 500, 0, 20), ZIndex = 10}}, {2, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderSizePixel = 0, Name = 'TopBar', Parent = {1}, Size = UDim2.new(1, 0, 0, 20), ZIndex = 10}}, {3, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {2}, Size = UDim2.new(1, 0, 0.94999998807907, 0), Text = 'Reference', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, ZIndex = 10}}, {4, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Close', Parent = {2}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 20), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, ZIndex = 10}}, {5, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = getcustomasset2('infiniteyield/assets/close.png'), Parent = {4}, Position = UDim2.new(0, 5, 0, 5), Size = UDim2.new(0, 10, 0, 10), ZIndex = 10}}, {6, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833), BorderSizePixel = 0, Name = 'Content', Parent = {1}, Position = UDim2.new(0, 0, 0, 20), Size = UDim2.new(1, 0, 0, 300), ZIndex = 10}}, {7, 'ScrollingFrame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png', CanvasSize = UDim2.new(0, 0, 0, 1313), Name = 'List', Parent = {6}, ScrollBarImageColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052), ScrollBarThickness = 8, Size = UDim2.new(1, 0, 1, 0), TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png', VerticalScrollBarInset = 2, ZIndex = 10}}, {8, 'UIListLayout', {Parent = {7}, SortOrder = 2}}, {9, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Section', Parent = {7}, Size = UDim2.new(1, 0, 0, 429), ZIndex = 10}}, {10, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Header', Parent = {9}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(1, -8, 0, 20), Text = 'Special Player Cases', TextColor3 = Color3.new(1, 1, 1), TextSize = 20, TextXAlignment = 0, ZIndex = 10}}, {11, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {9}, Position = UDim2.new(0, 8, 0, 25), Size = UDim2.new(1, -8, 0, 20), Text = 'These keywords can be used to quickly select groups of players in commands:', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {12, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderSizePixel = 0, Name = 'Line', Parent = {9}, Position = UDim2.new(0, 10, 1, -1), Size = UDim2.new(1, -20, 0, 1), ZIndex = 10}}, {13, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Cases', Parent = {9}, Position = UDim2.new(0, 8, 0, 55), Size = UDim2.new(1, -16, 0, 342), ZIndex = 10}}, {14, 'UIListLayout', {Parent = {13}, SortOrder = 2}}, {15, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = -4, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {16, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {15}, Size = UDim2.new(1, 0, 1, 0), Text = 'all', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {17, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {15}, Position = UDim2.new(0, 15, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- includes everyone', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {18, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = -3, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {19, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {18}, Size = UDim2.new(1, 0, 1, 0), Text = 'others', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {20, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {18}, Position = UDim2.new(0, 37, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- includes everyone except you', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {21, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = -2, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {22, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {21}, Size = UDim2.new(1, 0, 1, 0), Text = 'me', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {23, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {21}, Position = UDim2.new(0, 19, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- includes your player only', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {24, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {25, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {24}, Size = UDim2.new(1, 0, 1, 0), Text = '#[number]', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {26, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {24}, Position = UDim2.new(0, 59, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- gets a specified amount of random players', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {27, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {28, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {27}, Size = UDim2.new(1, 0, 1, 0), Text = 'random', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {29, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {27}, Position = UDim2.new(0, 44, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- affects a random player', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {30, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {31, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {30}, Size = UDim2.new(1, 0, 1, 0), Text = '%[team name]', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {32, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {30}, Position = UDim2.new(0, 78, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- includes everyone on a given team', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {33, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {34, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {33}, Size = UDim2.new(1, 0, 1, 0), Text = 'allies / team', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {35, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {33}, Position = UDim2.new(0, 63, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- players who are on your team', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {36, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {37, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {36}, Size = UDim2.new(1, 0, 1, 0), Text = 'enemies / nonteam', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {38, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {36}, Position = UDim2.new(0, 101, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- players who are not on your team', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {39, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {40, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {39}, Size = UDim2.new(1, 0, 1, 0), Text = 'friends', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {41, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {39}, Position = UDim2.new(0, 40, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- anyone who is friends with you', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {42, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {43, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {42}, Size = UDim2.new(1, 0, 1, 0), Text = 'nonfriends', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {44, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {42}, Position = UDim2.new(0, 61, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- anyone who is not friends with you', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {45, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {46, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {45}, Size = UDim2.new(1, 0, 1, 0), Text = 'guests', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {47, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {45}, Position = UDim2.new(0, 36, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- guest players (obsolete)', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {48, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {49, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {48}, Size = UDim2.new(1, 0, 1, 0), Text = 'bacons', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {50, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {48}, Position = UDim2.new(0, 40, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- anyone with the "bacon" or pal hair', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {51, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {52, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {51}, Size = UDim2.new(1, 0, 1, 0), Text = 'age[number]', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {53, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {51}, Position = UDim2.new(0, 71, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- includes anyone below or at the given age', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {54, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {55, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {54}, Size = UDim2.new(1, 0, 1, 0), Text = 'rad[number]', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {56, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {54}, Position = UDim2.new(0, 70, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- includes anyone within the given radius', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {57, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {58, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {57}, Size = UDim2.new(1, 0, 1, 0), Text = 'nearest', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {59, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {57}, Position = UDim2.new(0, 43, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- gets the closest player to you', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {60, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {61, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {60}, Size = UDim2.new(1, 0, 1, 0), Text = 'farthest', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {62, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {60}, Position = UDim2.new(0, 46, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- gets the farthest player from you', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {63, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {64, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {63}, Size = UDim2.new(1, 0, 1, 0), Text = 'group[ID]', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {65, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {63}, Position = UDim2.new(0, 55, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- gets players who are in a certain group', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {66, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {67, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {66}, Size = UDim2.new(1, 0, 1, 0), Text = 'alive', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {68, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {66}, Position = UDim2.new(0, 27, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- gets players who are alive', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {69, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {70, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {69}, Size = UDim2.new(1, 0, 1, 0), Text = 'dead', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {71, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {69}, Position = UDim2.new(0, 29, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- gets players who are dead', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {72, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = -1, Name = 'Case', Parent = {13}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, 0, 0, 18), ZIndex = 10}}, {73, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'CaseName', Parent = {72}, Size = UDim2.new(1, 0, 1, 0), Text = '@username', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {74, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'CaseDesc', Parent = {72}, Position = UDim2.new(0, 66, 0, 0), Size = UDim2.new(1, 0, 1, 0), Text = '- searches for players by username only (ignores displaynames)', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {75, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Section', Parent = {7}, Size = UDim2.new(1, 0, 0, 180), ZIndex = 10}}, {76, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Header', Parent = {75}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(1, -8, 0, 20), Text = 'Various Operators', TextColor3 = Color3.new(1, 1, 1), TextSize = 20, TextXAlignment = 0, ZIndex = 10}}, {77, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderSizePixel = 0, Name = 'Line', Parent = {75}, Position = UDim2.new(0, 10, 1, -1), Size = UDim2.new(1, -20, 0, 1), ZIndex = 10}}, {78, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Text', Parent = {75}, Position = UDim2.new(0, 8, 0, 30), Size = UDim2.new(1, -8, 0, 16), Text = 'Use commas to separate multiple expressions:', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {79, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Text', Parent = {75}, Position = UDim2.new(0, 8, 0, 75), Size = UDim2.new(1, -8, 0, 16), Text = 'Use - to exclude, and + to include players in your expression:', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {80, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {75}, Position = UDim2.new(0, 8, 0, 91), Size = UDim2.new(1, -8, 0, 16), Text = ';locate %blue-friends (gets players in blue team who aren\'t your friends)', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {81, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {75}, Position = UDim2.new(0, 8, 0, 46), Size = UDim2.new(1, -8, 0, 16), Text = ';locate noob,noob2,bob', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {82, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Text', Parent = {75}, Position = UDim2.new(0, 8, 0, 120), Size = UDim2.new(1, -8, 0, 16), Text = 'Put ! before a command to run it with the last arguments it was ran with:', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {83, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {75}, Position = UDim2.new(0, 8, 0, 136), Size = UDim2.new(1, -8, 0, 32), Text = 'After running ;offset 0 100 0,  you can run !offset anytime to repeat that command with the same arguments that were used to run it last time', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {84, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Section', Parent = {7}, Size = UDim2.new(1, 0, 0, 154), ZIndex = 10}}, {85, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Header', Parent = {84}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(1, -8, 0, 20), Text = 'Command Looping', TextColor3 = Color3.new(1, 1, 1), TextSize = 20, TextXAlignment = 0, ZIndex = 10}}, {86, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Text', Parent = {84}, Position = UDim2.new(0, 8, 0, 30), Size = UDim2.new(1, -8, 0, 20), Text = 'Form: [How many times it loops]^[delay (optional)]^[command]', TextColor3 = Color3.new(1, 1, 1), TextSize = 15, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {87, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderSizePixel = 0, Name = 'Line', Parent = {84}, Position = UDim2.new(0, 10, 1, -1), Size = UDim2.new(1, -20, 0, 1), ZIndex = 10}}, {88, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {84}, Position = UDim2.new(0, 8, 0, 50), Size = UDim2.new(1, -8, 0, 20), Text = 'Use the \'breakloops\' command to stop all running loops.', TextColor3 = Color3.new(1, 1, 1), TextSize = 15, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {89, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Text', Parent = {84}, Position = UDim2.new(0, 8, 0, 80), Size = UDim2.new(1, -8, 0, 16), Text = 'Examples:', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {90, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {84}, Position = UDim2.new(0, 8, 0, 98), Size = UDim2.new(1, -8, 0, 42), Text = ';5^btools - gives you 5 sets of btools\n;10^3^drophats - drops your hats every 3 seconds 10 times\n;inf^0.1^animspeed 100 - infinitely loops your animation speed to 100', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {91, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Section', Parent = {7}, Size = UDim2.new(1, 0, 0, 120), ZIndex = 10}}, {92, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Header', Parent = {91}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(1, -8, 0, 20), Text = 'Execute Multiple Commands at Once', TextColor3 = Color3.new(1, 1, 1), TextSize = 20, TextXAlignment = 0, ZIndex = 10}}, {93, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Text', Parent = {91}, Position = UDim2.new(0, 8, 0, 30), Size = UDim2.new(1, -8, 0, 20), Text = 'You can execute multiple commands at once using "\\"', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {94, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderSizePixel = 0, Name = 'Line', Parent = {91}, Position = UDim2.new(0, 10, 1, -1), Size = UDim2.new(1, -20, 0, 1), ZIndex = 10}}, {95, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Text', Parent = {91}, Position = UDim2.new(0, 8, 0, 60), Size = UDim2.new(1, -8, 0, 16), Text = 'Examples:', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {96, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {91}, Position = UDim2.new(0, 8, 0, 78), Size = UDim2.new(1, -8, 0, 32), Text = ';drophats\\respawn - drops your hats and respawns you\n;enable inventory\\enable playerlist\\refresh - enables those coregui items and refreshes you', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {97, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Section', Parent = {7}, Size = UDim2.new(1, 0, 0, 75), ZIndex = 10}}, {98, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Header', Parent = {97}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(1, -8, 0, 20), Text = 'Browse Command History', TextColor3 = Color3.new(1, 1, 1), TextSize = 20, TextXAlignment = 0, ZIndex = 10}}, {99, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {97}, Position = UDim2.new(0, 8, 0, 30), Size = UDim2.new(1, -8, 0, 32), Text = 'While focused on the command bar, you can use the up and down arrow keys to browse recently used commands', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {100, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderSizePixel = 0, Name = 'Line', Parent = {97}, Position = UDim2.new(0, 10, 1, -1), Size = UDim2.new(1, -20, 0, 1), ZIndex = 10}}, {101, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Section', Parent = {7}, Size = UDim2.new(1, 0, 0, 75), ZIndex = 10}}, {102, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Header', Parent = {101}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(1, -8, 0, 20), Text = 'Autocomplete in the Command Bar', TextColor3 = Color3.new(1, 1, 1), TextSize = 20, TextXAlignment = 0, ZIndex = 10}}, {103, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {101}, Position = UDim2.new(0, 8, 0, 30), Size = UDim2.new(1, -8, 0, 32), Text = 'While focused on the command bar, you can use the tab key to insert the top suggested command into the command bar.', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {104, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderSizePixel = 0, Name = 'Line', Parent = {101}, Position = UDim2.new(0, 10, 1, -1), Size = UDim2.new(1, -20, 0, 1), ZIndex = 10}}, {105, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Section', Parent = {7}, Size = UDim2.new(1, 0, 0, 175), ZIndex = 10}}, {106, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Header', Parent = {105}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(1, -8, 0, 20), Text = 'Using Event Binds', TextColor3 = Color3.new(1, 1, 1), TextSize = 20, TextXAlignment = 0, ZIndex = 10}}, {107, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {105}, Position = UDim2.new(0, 8, 0, 30), Size = UDim2.new(1, -8, 0, 32), Text = 'Use event binds to set up commands that get executed when certain events happen. You can edit the conditions for an event command to run (such as which player triggers it).', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {108, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderSizePixel = 0, Name = 'Line', Parent = {105}, Position = UDim2.new(0, 10, 1, -1), Size = UDim2.new(1, -20, 0, 1), ZIndex = 10}}, {109, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {105}, Position = UDim2.new(0, 8, 0, 70), Size = UDim2.new(1, -8, 0, 48), Text = 'Some events may send arguments; you can use them in your event command by using $ followed by the argument number ($1, $2, etc). You can find out the order and types of these arguments by looking at the settings of the event command.', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {110, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Text', Parent = {105}, Position = UDim2.new(0, 8, 0, 130), Size = UDim2.new(1, -8, 0, 16), Text = 'Example:', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {111, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {105}, Position = UDim2.new(0, 8, 0, 148), Size = UDim2.new(1, -8, 0, 16), Text = 'Setting up \'goto $1\' on the OnChatted event will teleport you to any player that chats.', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, TextYAlignment = 0, ZIndex = 10}}, {112, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Section', Parent = {7}, Size = UDim2.new(1, 0, 0, 105), ZIndex = 10}}, {113, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Header', Parent = {112}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(1, -8, 0, 20), Text = 'Get Further Help', TextColor3 = Color3.new(1, 1, 1), TextSize = 20, TextXAlignment = 0, ZIndex = 10}}, {114, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Text', Parent = {112}, Position = UDim2.new(0, 8, 0, 30), Size = UDim2.new(1, -8, 0, 32), Text = 'You can join the Discord server to get support with IY,  and read up on more documentation such as the Plugin API.', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextWrapped = true, TextXAlignment = 0, ZIndex = 10}}, {115, 'Frame', {BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), BorderSizePixel = 0, Name = 'Line', Parent = {112}, Position = UDim2.new(0, 10, 1, -1), Size = UDim2.new(1, -20, 0, 1), Visible = false, ZIndex = 10}}, {116, 'TextButton', {BackgroundColor3 = Color3.new(0.48627451062202, 0.61960786581039, 0.85098040103912), BorderColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), Font = 4, Name = 'InviteButton', Parent = {112}, Position = UDim2.new(0, 5, 0, 75), Size = UDim2.new(1, -10, 0, 25), Text = 'Copy Discord Invite Link (https://discord.gg/78ZuWSq)', TextColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054), TextSize = 16, ZIndex = 10}}})
    for _, descendant in pairs(parent.Content.List:GetDescendants()) do
        if not descendant:IsA('TextLabel') then
            continue
        end
        table.insert(text1, descendant)
    end
    table.insert(scroll, parent.Content.List)
    table.insert(shade1, parent.Content)
    table.insert(shade2, parent.TopBar)
    parent.Name = randomString()
    parent.TopBar.Close.MouseButton1Click:Connect(function()
        parent:TweenPosition(UDim2.new(0.5, -250, 0, -500), 'InOut', 'Quart', 0.5, true, nil)
    end)
    local inviteButton = parent:FindFirstChild('InviteButton', true)
    local v1
    inviteButton.MouseButton1Click:Connect(function()
        if everyClipboard then
            toClipboard('https://discord.gg/78ZuWSq')
            inviteButton.Text = 'Copied'
        else
            inviteButton.Text = 'No Clipboard Function, type out the link'
        end
        local now = tick()
        v1 = now
        wait(2)
        if v1 ~= now then
            return
        end
        inviteButton.Text = 'Copy Discord Invite Link (https://discord.gg/78ZuWSq)'
    end)
    dragGUI(parent)
    parent.Parent = ScaledHolder
    ReferenceButton.MouseButton1Click:Connect(function()
        parent:TweenPosition(UDim2.new(0.5, -250, 0.5, -150), 'InOut', 'Quart', 0.5, true, nil)
    end)
end)()
currentShade1 = Color3.fromRGB(36, 36, 37)
currentShade2 = Color3.fromRGB(46, 46, 47)
currentShade3 = Color3.fromRGB(78, 78, 79)
currentText1 = Color3.new(1, 1, 1)
currentText2 = Color3.new(0, 0, 0)
currentScroll = Color3.fromRGB(78, 78, 79)
defaultGuiScale = IsOnMobile and 0.9 or 1
defaultsettings = {prefix = ';', StayOpen = false, guiScale = defaultGuiScale, espTransparency = 0.3, keepIY = true, logsEnabled = false, jLogsEnabled = false, aliases = {}, binds = {}, WayPoints = {}, PluginsTable = {}, currentShade1 = {currentShade1.R, currentShade1.G, currentShade1.B}, currentShade2 = {currentShade2.R, currentShade2.G, currentShade2.B}, currentShade3 = {currentShade3.R, currentShade3.G, currentShade3.B}, currentText1 = {currentText1.R, currentText1.G, currentText1.B}, currentText2 = {currentText2.R, currentText2.G, currentText2.B}, currentScroll = {currentScroll.R, currentScroll.G, currentScroll.B}, eventBinds = eventEditor.SaveData()}
defaults = HttpService:JSONEncode(defaultsettings)
nosaves = false
useFactorySettings = function()
    prefix = ';'
    StayOpen = false
    guiScale = defaultGuiScale
    KeepInfYield = true
    espTransparency = 0.3
    logsEnabled = false
    jLogsEnabled = false
    logsWebhook = nil
    aliases = {}
    binds = {}
    WayPoints = {}
    PluginsTable = {}
end
createPopup = function(text, text3)
    local frame = Instance.new('Frame')
    local frame2 = Instance.new('Frame')
    local textLabel = Instance.new('TextLabel')
    local frame3 = Instance.new('Frame')
    local textLabel2 = Instance.new('TextLabel')
    local textButton = Instance.new('TextButton')
    local imageLabel = Instance.new('ImageLabel')
    frame.Name = randomString()
    frame.Parent = ScaledHolder
    frame.Active = true
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(0.5, -180, 0, -500)
    frame.Size = UDim2.new(0, 360, 0, 20)
    frame.ZIndex = 10
    frame2.Name = 'background'
    frame2.Parent = frame
    frame2.Active = true
    frame2.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
    frame2.BorderSizePixel = 0
    frame2.Position = UDim2.new(0, 0, 0, 20)
    frame2.Size = UDim2.new(0, 360, 0, 205)
    frame2.ZIndex = 10
    textLabel.Name = 'Directions'
    textLabel.Parent = frame2
    textLabel.BackgroundTransparency = 1
    textLabel.BorderSizePixel = 0
    textLabel.Position = UDim2.new(0, 10, 0, 10)
    textLabel.Size = UDim2.new(0, 340, 0, 185)
    textLabel.Font = Enum.Font.SourceSans
    textLabel.TextSize = 14
    textLabel.Text = text3
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextWrapped = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.ZIndex = 10
    frame3.Name = 'shadow'
    frame3.Parent = frame
    frame3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
    frame3.BorderSizePixel = 0
    frame3.Size = UDim2.new(0, 360, 0, 20)
    frame3.ZIndex = 10
    textLabel2.Name = 'PopupText'
    textLabel2.Parent = frame3
    textLabel2.BackgroundTransparency = 1
    textLabel2.Size = UDim2.new(1, 0, 0.95, 0)
    textLabel2.ZIndex = 10
    textLabel2.Font = Enum.Font.SourceSans
    textLabel2.TextSize = 14
    textLabel2.Text = text
    textLabel2.TextColor3 = Color3.new(1, 1, 1)
    textLabel2.TextWrapped = true
    textButton.Name = 'Exit'
    textButton.Parent = frame3
    textButton.BackgroundTransparency = 1
    textButton.Position = UDim2.new(1, -20, 0, 0)
    textButton.Size = UDim2.new(0, 20, 0, 20)
    textButton.Text = ''
    textButton.ZIndex = 10
    imageLabel.Parent = textButton
    imageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Position = UDim2.new(0, 5, 0, 5)
    imageLabel.Size = UDim2.new(0, 10, 0, 10)
    imageLabel.Image = getcustomasset2('infiniteyield/assets/close.png')
    imageLabel.ZIndex = 10
    frame:TweenPosition(UDim2.new(0.5, -180, 0, 150), 'InOut', 'Quart', 0.5, true, nil)
    textButton.MouseButton1Click:Connect(function()
        frame:TweenPosition(UDim2.new(0.5, -180, 0, -500), 'InOut', 'Quart', 0.5, true, nil)
        task.wait(0.6)
        frame:Destroy()
    end)
end
local v2
local num = 0
saves = function()
    if writefileExploit() and readfileExploit() and num < 10 then
        local v1, value = readfile('IY_FE.iy', true)
        if v1 then
            if value ~= nil and tostring(value):gsub('%s', '') ~= '' then
                local success, result = pcall(function()
                    local result = HttpService:JSONDecode(value)
                    if vtype(result.prefix, 'string') then
                        prefix = result.prefix
                    else
                        prefix = ';'
                    end
                    if vtype(result.StayOpen, 'boolean') then
                        StayOpen = result.StayOpen
                    else
                        StayOpen = false
                    end
                    if vtype(result.guiScale, 'number') then
                        guiScale = result.guiScale
                    else
                        guiScale = defaultGuiScale
                    end
                    if vtype(result.keepIY, 'boolean') then
                        KeepInfYield = result.keepIY
                    else
                        KeepInfYield = true
                    end
                    if vtype(result.espTransparency, 'number') then
                        espTransparency = result.espTransparency
                    else
                        espTransparency = 0.3
                    end
                    if vtype(result.logsEnabled, 'boolean') then
                        logsEnabled = result.logsEnabled
                    else
                        logsEnabled = false
                    end
                    if vtype(result.jLogsEnabled, 'boolean') then
                        jLogsEnabled = result.jLogsEnabled
                    else
                        jLogsEnabled = false
                    end
                    if vtype(result.logsWebhook, 'string') then
                        logsWebhook = result.logsWebhook
                    else
                        logsWebhook = nil
                    end
                    if vtype(result.aliases, 'table') then
                        aliases = result.aliases
                    else
                        aliases = {}
                    end
                    if vtype(result.binds, 'table') then
                        binds = result.binds
                    else
                        binds = {}
                    end
                    if vtype(result.spawnCmds, 'table') then
                        spawnCmds = result.spawnCmds
                    end
                    if vtype(result.WayPoints, 'table') then
                        AllWaypoints = result.WayPoints
                    else
                        WayPoints = {}
                        AllWaypoints = {}
                    end
                    if vtype(result.PluginsTable, 'table') then
                        PluginsTable = result.PluginsTable
                    else
                        PluginsTable = {}
                    end
                    if vtype(result.currentShade1, 'table') then
                        currentShade1 = Color3.new(result.currentShade1[1], result.currentShade1[2], result.currentShade1[3])
                    end
                    if vtype(result.currentShade2, 'table') then
                        currentShade2 = Color3.new(result.currentShade2[1], result.currentShade2[2], result.currentShade2[3])
                    end
                    if vtype(result.currentShade3, 'table') then
                        currentShade3 = Color3.new(result.currentShade3[1], result.currentShade3[2], result.currentShade3[3])
                    end
                    if vtype(result.currentText1, 'table') then
                        currentText1 = Color3.new(result.currentText1[1], result.currentText1[2], result.currentText1[3])
                    end
                    if vtype(result.currentText2, 'table') then
                        currentText2 = Color3.new(result.currentText2[1], result.currentText2[2], result.currentText2[3])
                    end
                    if vtype(result.currentScroll, 'table') then
                        currentScroll = Color3.new(result.currentScroll[1], result.currentScroll[2], result.currentScroll[3])
                    end
                    if vtype(result.eventBinds, 'string') then
                        v2 = result.eventBinds
                    end
                end)
                if not success then
                    num = num + 1
                    warn('Save Json Error:', result)
                    warn('Overwriting Save File')
                    writefile('IY_FE.iy', defaults, true)
                    wait()
                    saves()
                end
            else
                writefile('IY_FE.iy', defaults, true)
                wait()
                local v3, value2 = readfile('IY_FE.iy', true)
                if v3 and value2 ~= nil and tostring(value2):gsub('%s', '') ~= '' then
                    saves()
                    return
                end
                nosaves = true
                useFactorySettings()
                createPopup('File Error', 'There was a problem writing a save file to your PC.\n\nPlease contact the developer/support team for your exploit and tell them writefile/readfile is not working.\n\nYour settings, keybinds, waypoints, and aliases will not save if you continue.\n\nThings to try:\n> Make sure a \'workspace\' folder is located in the same folder as your exploit\n> If your exploit is inside of a zip/rar file, extract it.\n> Rejoin the game and try again or restart your PC and try again.')
                return
            end
        end
        writefile('IY_FE.iy', defaults, true)
        wait()
        local v4, value3 = readfile('IY_FE.iy', true)
        if v4 and value3 ~= nil and tostring(value3):gsub('%s', '') ~= '' then
            saves()
            return
        end
        nosaves = true
        useFactorySettings()
        createPopup('File Error', 'There was a problem writing a save file to your PC.\n\nPlease contact the developer/support team for your exploit and tell them writefile/readfile is not working.\n\nYour settings, keybinds, waypoints, and aliases will not save if you continue.\n\nThings to try:\n> Make sure a \'workspace\' folder is located in the same folder as your exploit\n> If your exploit is inside of a zip/rar file, extract it.\n> Rejoin the game and try again or restart your PC and try again.')
    else
        if num >= 10 then
            nosaves = true
            useFactorySettings()
            createPopup('File Error', 'Sorry, we have attempted to parse your save file, but it is unreadable!\n\nInfinite Yield is now using factory settings until your exploit\'s file system works.\n\nYour save file has not been deleted.')
            return
        end
        nosaves = true
        useFactorySettings()
    end
end
saves()
updatesaves = function()
    if nosaves == false and writefileExploit() then
        local value = {prefix = prefix, StayOpen = StayOpen, guiScale = guiScale, keepIY = KeepInfYield, espTransparency = espTransparency, logsEnabled = logsEnabled, jLogsEnabled = jLogsEnabled, logsWebhook = logsWebhook, aliases = aliases, binds = binds or {}, WayPoints = AllWaypoints, PluginsTable = PluginsTable, currentShade1 = {currentShade1.R, currentShade1.G, currentShade1.B}, currentShade2 = {currentShade2.R, currentShade2.G, currentShade2.B}, currentShade3 = {currentShade3.R, currentShade3.G, currentShade3.B}, currentText1 = {currentText1.R, currentText1.G, currentText1.B}, currentText2 = {currentText2.R, currentText2.G, currentText2.B}, currentScroll = {currentScroll.R, currentScroll.G, currentScroll.B}, eventBinds = eventEditor.SaveData()}
        writefileCooldown('IY_FE.iy', HttpService:JSONEncode(value))
    end
end
eventEditor.SetOnEdited(updatesaves)
pWayPoints = {}
WayPoints = {}
if #AllWaypoints > 0 then
    for i = 1, #AllWaypoints do
        if AllWaypoints[i].GAME and AllWaypoints[i].GAME ~= PlaceId then
            continue
        end
        WayPoints[#WayPoints + 1] = {NAME = AllWaypoints[i].NAME, COORD = {AllWaypoints[i].COORD[1], AllWaypoints[i].COORD[2], AllWaypoints[i].COORD[3]}, GAME = AllWaypoints[i].GAME}
    end
end
if type(binds) ~= 'table' then
    binds = {}
end
if type(PluginsTable) == 'table' then
    for i = #PluginsTable, 1, -1 do
        if string.sub(PluginsTable[i], -3) == '.iy' then
            continue
        end
        table.remove(PluginsTable, i)
    end
end
Time = function()
    local floored = math.floor(tick() % 86400 / 3600)
    local floored2 = math.floor(tick() % 3600 / 60)
    local floored3 = math.floor(tick() % 60)
    local v1 = floored > 11 and 'PM' or 'AM'
    floored = floored % 12 == 0 and 12 or floored % 12
    floored = floored < 10 and '0' .. floored or floored
    floored2 = floored2 < 10 and '0' .. floored2 or floored2
    floored3 = floored3 < 10 and '0' .. floored3 or floored3
    return floored .. ':' .. floored2 .. ':' .. floored3 .. ' ' .. v1
end
PrefixBox.Text = prefix
local flag2 = false
local flag3 = false
if StayOpen == false then
    On.BackgroundTransparency = 1
else
    On.BackgroundTransparency = 0
end
if logsEnabled then
    Toggle.Text = 'Enabled'
else
    Toggle.Text = 'Disabled'
end
if jLogsEnabled then
    Toggle_2.Text = 'Enabled'
else
    Toggle_2.Text = 'Disabled'
end
maximizeHolder = function()
    if StayOpen == false then
        Holder:TweenPosition(UDim2.new(1, Holder.Position.X.Offset, 1, -220), 'InOut', 'Quart', 0.2, true, nil)
    end
end
minimizeNum = -20
minimizeHolder = function()
    if StayOpen == false then
        Holder:TweenPosition(UDim2.new(1, Holder.Position.X.Offset, 1, minimizeNum), 'InOut', 'Quart', 0.5, true, nil)
    end
end
cmdbarHolder = function()
    if StayOpen == false then
        Holder:TweenPosition(UDim2.new(1, Holder.Position.X.Offset, 1, -45), 'InOut', 'Quart', 0.5, true, nil)
    end
end
pinNotification = nil
local num2 = 0
notify = function(text, text3, seconds)
    task.spawn(function()
        local v1 = num2 + 1
        local flag = false
        num2 = num2 + 1
        if pinNotification then
            pinNotification:Disconnect()
        end
        pinNotification = PinButton.MouseButton1Click:Connect(function()
            task.spawn(function()
                pinNotification:Disconnect()
                flag = true
                Title_2.BackgroundTransparency = 1
                wait(0.5)
                Title_2.BackgroundTransparency = 0
            end)
        end)
        Notification:TweenPosition(UDim2.new(1, Notification.Position.X.Offset, 1, 0), 'InOut', 'Quart', 0.5, true, nil)
        wait(0.6)
        local flag2 = false
        if text3 then
            Title_2.Text = text
            Text_2.Text = text3
        else
            Title_2.Text = 'Notification'
            Text_2.Text = text
        end
        Notification:TweenPosition(UDim2.new(1, Notification.Position.X.Offset, 1, -100), 'InOut', 'Quart', 0.5, true, nil)
        CloseButton.MouseButton1Click:Connect(function()
            Notification:TweenPosition(UDim2.new(1, Notification.Position.X.Offset, 1, 0), 'InOut', 'Quart', 0.5, true, nil)
            flag2 = true
            pinNotification:Disconnect()
        end)
        if seconds and isNumber(seconds) then
            wait(seconds)
        else
            wait(10)
        end
        if v1 == num2 then
            if flag2 == false and flag == false then
                pinNotification:Disconnect()
                Notification:TweenPosition(UDim2.new(1, Notification.Position.X.Offset, 1, 0), 'InOut', 'Quart', 0.5, true, nil)
            end
            num2 = 0
        end
    end)
end
local v3
local label
local num3 = 1
CreateLabel = function(name, text)
    if v3 == name .. text then
        num3 = num3 + 1
        label.Text = Time() .. ' - [' .. name .. ']: ' .. text .. ' (x' .. num3 .. ')'
        return
    end
    if num3 > 1 then
        num3 = 1
    end
    if #scroll_2:GetChildren() >= 2546 then
        scroll_2:ClearAllChildren()
    end
    local yOffset = 0
    for _, child in pairs(scroll_2:GetChildren()) do
        if child then
            yOffset = child.Size.Y.Offset + yOffset
        end
        if child then
            continue
        end
        yOffset = 0
    end
    local textLabel = Instance.new('TextLabel')
    v3 = name .. text
    label = textLabel
    textLabel.Name = name
    textLabel.Parent = scroll_2
    textLabel.ZIndex = 10
    textLabel.RichText = true
    textLabel.Text = Time() .. ' - [' .. name .. ']: ' .. text
    textLabel.Text = textLabel.ContentText
    textLabel.Size = UDim2.new(0, 322, 0, 84)
    textLabel.BackgroundTransparency = 1
    textLabel.BorderSizePixel = 0
    textLabel.Font = 'SourceSans'
    textLabel.Position = UDim2.new(-1, 0, 0, yOffset)
    textLabel.TextTransparency = 1
    textLabel.TextScaled = false
    textLabel.TextSize = 14
    textLabel.TextWrapped = true
    textLabel.TextXAlignment = 'Left'
    textLabel.TextYAlignment = 'Top'
    textLabel.TextColor3 = currentText1
    textLabel.Size = UDim2.new(0, 322, 0, textLabel.TextBounds.Y)
    table.insert(text1, textLabel)
    scroll_2.CanvasSize = UDim2.new(0, 0, 0, yOffset + textLabel.TextBounds.Y)
    scroll_2.CanvasPosition = Vector2.new(0, scroll_2.CanvasPosition.Y + textLabel.TextBounds.Y)
    textLabel:TweenPosition(UDim2.new(0, 3, 0, yOffset), 'In', 'Quint', 0.5)
    TweenService:Create(textLabel, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {TextTransparency = 0}):Play()
end
CreateJoinLabel = function(player, text)
    if #scroll_3:GetChildren() >= 2546 then
        scroll_3:ClearAllChildren()
    end
    local frame = Instance.new('Frame')
    local textLabel = Instance.new('TextLabel')
    local textLabel2 = Instance.new('TextLabel')
    local imageLabel = Instance.new('ImageLabel')
    frame.Name = randomString()
    frame.Parent = scroll_3
    frame.BackgroundColor3 = Color3.new(1, 1, 1)
    frame.BackgroundTransparency = 1
    frame.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
    frame.Size = UDim2.new(1, 0, 0, 50)
    textLabel.Name = randomString()
    textLabel.Parent = frame
    textLabel.BackgroundTransparency = 1
    textLabel.BorderSizePixel = 0
    textLabel.Position = UDim2.new(0, 45, 0, 0)
    textLabel.Size = UDim2.new(0, 135, 1, 0)
    textLabel.ZIndex = 10
    textLabel.Font = Enum.Font.SourceSans
    textLabel.FontSize = Enum.FontSize.Size14
    textLabel.Text = 'Username: ' .. player.Name .. '\nJoined Server: ' .. Time()
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextWrapped = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel2.Name = randomString()
    textLabel2.Parent = frame
    textLabel2.BackgroundTransparency = 1
    textLabel2.BorderSizePixel = 0
    textLabel2.Position = UDim2.new(0, 185, 0, 0)
    textLabel2.Size = UDim2.new(0, 140, 1, -5)
    textLabel2.ZIndex = 10
    textLabel2.Font = Enum.Font.SourceSans
    textLabel2.FontSize = Enum.FontSize.Size14
    textLabel2.Text = 'User ID: ' .. text .. '\nAccount Age: ' .. player.AccountAge .. '\nJoined Roblox: Loading...'
    textLabel2.TextColor3 = Color3.new(1, 1, 1)
    textLabel2.TextWrapped = true
    textLabel2.TextXAlignment = Enum.TextXAlignment.Left
    textLabel2.TextYAlignment = Enum.TextYAlignment.Center
    imageLabel.Parent = frame
    imageLabel.BackgroundTransparency = 1
    imageLabel.BorderSizePixel = 0
    imageLabel.Size = UDim2.new(0, 45, 1, 0)
    imageLabel.Image = Players:GetUserThumbnailAsync(text, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
    scroll_3.CanvasSize = UDim2.new(0, 0, 0, listlayout.AbsoluteContentSize.Y)
    scroll_3.CanvasPosition = Vector2.new(0, scroll_2.CanvasPosition.Y + frame.AbsoluteSize.Y)
    local dateText = os.date('!%Y-%m-%d', os.time() - player.AccountAge * 86400)
    local list = string.split(dateText, '-')
    textLabel2.Text = string.gsub(textLabel2.Text, 'Loading...', list[2] .. '/' .. list[3] .. '/' .. list[1])
end
IYMouse.KeyDown:Connect(function(arg1)
    if arg1 == prefix then
        RunService.RenderStepped:Wait()
        Cmdbar:CaptureFocus()
        maximizeHolder()
    end
end)
local num4 = 0
Holder.MouseEnter:Connect(function()
    num4 = 0
    maximizeHolder()
end)
Holder.MouseLeave:Connect(function()
    if not Cmdbar:IsFocused() then
        local now = tick()
        num4 = now
        wait(1)
        if num4 ~= now then
            return
        end
        if not Cmdbar:IsFocused() then
            minimizeHolder()
        end
    end
end)
updateColors = function(backgroundColor3, arg2)
    if arg2 == shade1 then
        for _, v in pairs(shade1) do
            v.BackgroundColor3 = backgroundColor3
        end
        currentShade1 = backgroundColor3
        return
    end
    if arg2 == shade2 then
        for _, v in pairs(shade2) do
            v.BackgroundColor3 = backgroundColor3
        end
        currentShade2 = backgroundColor3
        return
    end
    if arg2 == shade3 then
        for _, v in pairs(shade3) do
            v.BackgroundColor3 = backgroundColor3
        end
        currentShade3 = backgroundColor3
        return
    end
    if arg2 == text1 then
        for _, v in pairs(text1) do
            v.TextColor3 = backgroundColor3
            if not v:IsA('TextBox') then
                continue
            end
            v.PlaceholderColor3 = backgroundColor3
        end
        currentText1 = backgroundColor3
        return
    end
    if arg2 == text2 then
        for _, v in pairs(text2) do
            v.TextColor3 = backgroundColor3
        end
        currentText2 = backgroundColor3
        return
    end
    if arg2 == scroll then
        for _, v in pairs(scroll) do
            v.ScrollBarImageColor3 = backgroundColor3
        end
        currentScroll = backgroundColor3
    end
end
local flag4 = false
ColorsButton.MouseButton1Click:Connect(function()
    cache_currentShade1 = currentShade1
    cache_currentShade2 = currentShade2
    cache_currentShade3 = currentShade3
    cache_currentText1 = currentText1
    cache_currentText2 = currentText2
    cache_currentScroll = currentScroll
    if not flag4 then
        flag4 = true
        picker = game:GetObjects('rbxassetid://4908465318')[1]
        picker.Name = randomString()
        picker.Parent = ScaledHolder
        local data
        data = {new = function()
            local object = setmetatable({}, {})
            local colorPicker = picker.ColorPicker
            local topBar = colorPicker.TopBar
            local exit = topBar.Exit
            local content = colorPicker.Content
            local colorSpace = content.ColorSpaceFrame.ColorSpace
            local colorStrip = content.ColorStrip
            local preview = content.Preview
            local basicColors = content.BasicColors
            local customColors = content.CustomColors
            local default = content.Default
            local cancel = content.Cancel
            local shade12 = content.Shade1
            local shade22 = content.Shade2
            local shade32 = content.Shade3
            local text12 = content.Text1
            local text22 = content.Text2
            local scroll2 = content.Scroll
            local scope = colorSpace.Scope
            local arrow = content.ArrowFrame.Arrow
            local input = content.Hue.Input
            local input2 = content.Sat.Input
            local input3 = content.Val.Input
            local input4 = content.Red.Input
            local input5 = content.Green.Input
            local input6 = content.Blue.Input
            local IYMouse = IYMouse
            local num = 0
            local num2 = 0
            local num3 = 1
            local num4 = 1
            local num5 = 1
            local num6 = 1
            local color3 = Color3.new(0, 0, 0)
            local map = {Color3.new(0, 0, 0), Color3.new(0.66666668653488, 0, 0), Color3.new(0, 0.33333334326744, 0), Color3.new(0.66666668653488, 0.33333334326744, 0), Color3.new(0, 0.66666668653488, 0), Color3.new(0.66666668653488, 0.66666668653488, 0), Color3.new(0, 1, 0), Color3.new(0.66666668653488, 1, 0), Color3.new(0, 0, 0.49803924560547), Color3.new(0.66666668653488, 0, 0.49803924560547), Color3.new(0, 0.33333334326744, 0.49803924560547), Color3.new(0.66666668653488, 0.33333334326744, 0.49803924560547), Color3.new(0, 0.66666668653488, 0.49803924560547), Color3.new(0.66666668653488, 0.66666668653488, 0.49803924560547), Color3.new(0, 1, 0.49803924560547), (Color3.new(0.66666668653488, 1, 0.49803924560547)), Color3.new(0, 0, 1), Color3.new(0.66666668653488, 0, 1), Color3.new(0, 0.33333334326744, 1), Color3.new(0.66666668653488, 0.33333334326744, 1), Color3.new(0, 0.66666668653488, 1), Color3.new(0.66666668653488, 0.66666668653488, 1), Color3.new(0, 1, 1), Color3.new(0.66666668653488, 1, 1), Color3.new(0.33333334326744, 0, 0), Color3.new(1, 0, 0), Color3.new(0.33333334326744, 0.33333334326744, 0), Color3.new(1, 0.33333334326744, 0), Color3.new(0.33333334326744, 0.66666668653488, 0), Color3.new(1, 0.66666668653488, 0), Color3.new(0.33333334326744, 1, 0), (Color3.new(1, 1, 0)), Color3.new(0.33333334326744, 0, 0.49803924560547), Color3.new(1, 0, 0.49803924560547), Color3.new(0.33333334326744, 0.33333334326744, 0.49803924560547), Color3.new(1, 0.33333334326744, 0.49803924560547), Color3.new(0.33333334326744, 0.66666668653488, 0.49803924560547), Color3.new(1, 0.66666668653488, 0.49803924560547), Color3.new(0.33333334326744, 1, 0.49803924560547), Color3.new(1, 1, 0.49803924560547), Color3.new(0.33333334326744, 0, 1), Color3.new(1, 0, 1), Color3.new(0.33333334326744, 0.33333334326744, 1), Color3.new(1, 0.33333334326744, 1), Color3.new(0.33333334326744, 0.66666668653488, 1), Color3.new(1, 0.66666668653488, 1), Color3.new(0.33333334326744, 1, 1), Color3.new(1, 1, 1)}
            local list = {}
            dragGUI(picker)
            local function updateColor(arg1)
                local v1 = 219 - num * 219
                local v2 = 199 - num2 * 199
                local v3 = 199 - num3 * 199
                local _ = Color3.fromHSV(num, num2, num3)
                if arg1 == 2 or not arg1 then
                    input.Text = tostring(math.ceil(359 * num))
                    input2.Text = tostring(math.ceil(255 * num2))
                    input3.Text = tostring(math.floor(255 * num3))
                end
                if arg1 == 1 or not arg1 then
                    input4.Text = tostring(math.floor(255 * num4))
                    input5.Text = tostring(math.floor(255 * num5))
                    input6.Text = tostring(math.floor(255 * num6))
                end
                color3 = Color3.new(num4, num5, num6)
                scope.Position = UDim2.new(0, v1 - 9, 0, v2 - 9)
                colorStrip.ImageColor3 = Color3.fromHSV(num, num2, 1)
                arrow.Position = UDim2.new(0, -2, 0, v3 - 4)
                preview.BackgroundColor3 = color3
                object.Color = color3
                if object.Changed then
                    object:Changed(color3)
                end
            end
            local function colorSpaceInput()
                local v1 = IYMouse.X - colorSpace.AbsolutePosition.X
                local v2 = IYMouse.Y - colorSpace.AbsolutePosition.Y
                local v3 = if v1 >= 0 then if v1 <= 219 then v1 else 219 else 0
                local v4 = if v2 >= 0 then if v2 <= 199 then v2 else 199 else 0
                num = (219 - v3) / 219
                num2 = (199 - v4) / 199
                local color = Color3.fromHSV(num, num2, num3)
                num4, num5, num6 = color.r, color.g, color.b
                updateColor()
            end
            local function colorStripInput()
                local v1 = if IYMouse.Y - colorStrip.AbsolutePosition.Y >= 0 then if IYMouse.Y - colorStrip.AbsolutePosition.Y <= 199 then IYMouse.Y - colorStrip.AbsolutePosition.Y else 199 else 0
                num3 = (199 - v1) / 199
                local color = Color3.fromHSV(num, num2, num3)
                num4, num5, num6 = color.r, color.g, color.b
                updateColor()
            end
            local function hookButtons(label, callback)
                label.ArrowFrame.Up.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        label.ArrowFrame.Up.BackgroundTransparency = 0.5
                        return
                    end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local connection
                        local v1
                        local now = tick()
                        local flag = true
                        local number = tonumber(label.Text)
                        if not number then
                            return
                        end
                        connection = UserInputService.InputEnded:Connect(function(input)
                            if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                                return
                            end
                            connection:Disconnect()
                            flag = false
                        end)
                        number += 1
                        callback(number)
                        while flag do
                            if tick() - now > 0.3 then
                                number += 1
                                callback(number)
                            end
                            wait(0.1)
                        end
                    end
                end)
                label.ArrowFrame.Up.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        label.ArrowFrame.Up.BackgroundTransparency = 1
                    end
                end)
                label.ArrowFrame.Down.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        label.ArrowFrame.Down.BackgroundTransparency = 0.5
                        return
                    end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local connection
                        local v1
                        local now = tick()
                        local flag = true
                        local number = tonumber(label.Text)
                        if not number then
                            return
                        end
                        connection = UserInputService.InputEnded:Connect(function(input)
                            if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                                return
                            end
                            connection:Disconnect()
                            flag = false
                        end)
                        number -= 1
                        callback(number)
                        while flag do
                            if tick() - now > 0.3 then
                                number -= 1
                                callback(number)
                            end
                            wait(0.1)
                        end
                    end
                end)
                label.ArrowFrame.Down.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        label.ArrowFrame.Down.BackgroundTransparency = 1
                    end
                end)
            end
            colorSpace.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local connection
                    local connection2
                    connection = UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                            return
                        end
                        connection:Disconnect()
                        connection2:Disconnect()
                    end)
                    connection2 = UserInputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            colorSpaceInput()
                        end
                    end)
                    colorSpaceInput()
                end
            end)
            colorStrip.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local connection
                    local connection2
                    connection = UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                            return
                        end
                        connection:Disconnect()
                        connection2:Disconnect()
                    end)
                    connection2 = UserInputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            colorStripInput()
                        end
                    end)
                    colorStripInput()
                end
            end)
            local function updateHue(text)
                local number = tonumber(text)
                if number then
                    num = math.clamp(math.floor(number), 0, 359) / 359
                    local color = Color3.fromHSV(num, num2, num3)
                    num4, num5, num6 = color.r, color.g, color.b
                    input.Text = tostring(num * 359)
                    updateColor(1)
                end
            end
            input.FocusLost:Connect(function()
                updateHue(input.Text)
            end)
            hookButtons(input, updateHue)
            local function updateSat(text)
                local number = tonumber(text)
                if number then
                    num2 = math.clamp(math.floor(number), 0, 255) / 255
                    local color = Color3.fromHSV(num, num2, num3)
                    num4, num5, num6 = color.r, color.g, color.b
                    input2.Text = tostring(num2 * 255)
                    updateColor(1)
                end
            end
            input2.FocusLost:Connect(function()
                updateSat(input2.Text)
            end)
            hookButtons(input2, updateSat)
            local function updateVal(text)
                local number = tonumber(text)
                if number then
                    num3 = math.clamp(math.floor(number), 0, 255) / 255
                    local color = Color3.fromHSV(num, num2, num3)
                    num4, num5, num6 = color.r, color.g, color.b
                    input3.Text = tostring(num3 * 255)
                    updateColor(1)
                end
            end
            input3.FocusLost:Connect(function()
                updateVal(input3.Text)
            end)
            hookButtons(input3, updateVal)
            local function updateRed(text)
                local number = tonumber(text)
                if number then
                    num4 = math.clamp(math.floor(number), 0, 255) / 255
                    local color3 = Color3.new(num4, num5, num6)
                    num, num2, num3 = Color3.toHSV(color3)
                    input4.Text = tostring(num4 * 255)
                    updateColor(2)
                end
            end
            input4.FocusLost:Connect(function()
                updateRed(input4.Text)
            end)
            hookButtons(input4, updateRed)
            local function updateGreen(text)
                local number = tonumber(text)
                if number then
                    num5 = math.clamp(math.floor(number), 0, 255) / 255
                    local color3 = Color3.new(num4, num5, num6)
                    num, num2, num3 = Color3.toHSV(color3)
                    input5.Text = tostring(num5 * 255)
                    updateColor(2)
                end
            end
            input5.FocusLost:Connect(function()
                updateGreen(input5.Text)
            end)
            hookButtons(input5, updateGreen)
            local function updateBlue(text)
                local number = tonumber(text)
                if number then
                    num6 = math.clamp(math.floor(number), 0, 255) / 255
                    local color3 = Color3.new(num4, num5, num6)
                    num, num2, num3 = Color3.toHSV(color3)
                    input6.Text = tostring(num6 * 255)
                    updateColor(2)
                end
            end
            input6.FocusLost:Connect(function()
                updateBlue(input6.Text)
            end)
            hookButtons(input6, updateBlue)
            local textButton = Instance.new('TextButton')
            textButton.Name = 'Choice'
            textButton.Size = UDim2.new(0, 25, 0, 18)
            textButton.BorderColor3 = Color3.new(0.3764705882352941, 0.3764705882352941, 0.3764705882352941)
            textButton.Text = ''
            textButton.AutoButtonColor = false
            textButton.ZIndex = 10
            local count = 0
            local count2 = 0
            for _, v in pairs(map) do
                local clone = textButton:Clone()
                clone.BackgroundColor3 = v
                clone.Position = UDim2.new(0, 1 + 30 * count2, 0, 21 + 23 * count)
                clone.MouseButton1Click:Connect(function()
                    num4, num5, num6 = v.r, v.g, v.b
                    local color3 = Color3.new(num4, num5, num6)
                    num, num2, num3 = Color3.toHSV(color3)
                    updateColor()
                end)
                clone.Parent = basicColors
                count2 += 1
                if count2 ~= 6 then
                    continue
                end
                count += 1
                count2 = 0
            end
            local count3 = 0
            local count4 = 0
            for i = 1, 12 do
                local backgroundColor3 = list[i] or Color3.new(0, 0, 0)
                local clone2 = textButton:Clone()
                clone2.BackgroundColor3 = backgroundColor3
                clone2.Position = UDim2.new(0, 1 + 30 * count4, 0, 20 + 23 * count3)
                clone2.MouseButton1Click:Connect(function()
                    local v1 = list[i] or Color3.new(0, 0, 0)
                    num4, num5, num6 = v1.r, v1.g, v1.b
                    num, num2, num3 = Color3.toHSV(v1)
                    updateColor()
                end)
                clone2.MouseButton2Click:Connect(function()
                    list[i] = color3
                    clone2.BackgroundColor3 = color3
                end)
                clone2.Parent = customColors
                count4 += 1
                if count4 ~= 6 then
                    continue
                end
                count3 += 1
                count4 = 0
            end
            shade12.MouseButton1Click:Connect(function()
                if object.Confirm then
                    object:Confirm(color3, shade1)
                end
            end)
            shade12.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    shade12.BackgroundTransparency = 0.4
                end
            end)
            shade12.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    shade12.BackgroundTransparency = 0
                end
            end)
            shade22.MouseButton1Click:Connect(function()
                if object.Confirm then
                    object:Confirm(color3, shade2)
                end
            end)
            shade22.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    shade22.BackgroundTransparency = 0.4
                end
            end)
            shade22.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    shade22.BackgroundTransparency = 0
                end
            end)
            shade32.MouseButton1Click:Connect(function()
                if object.Confirm then
                    object:Confirm(color3, shade3)
                end
            end)
            shade32.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    shade32.BackgroundTransparency = 0.4
                end
            end)
            shade32.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    shade32.BackgroundTransparency = 0
                end
            end)
            text12.MouseButton1Click:Connect(function()
                if object.Confirm then
                    object:Confirm(color3, text1)
                end
            end)
            text12.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    text12.BackgroundTransparency = 0.4
                end
            end)
            text12.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    text12.BackgroundTransparency = 0
                end
            end)
            text22.MouseButton1Click:Connect(function()
                if object.Confirm then
                    object:Confirm(color3, text2)
                end
            end)
            text22.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    text22.BackgroundTransparency = 0.4
                end
            end)
            text22.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    text22.BackgroundTransparency = 0
                end
            end)
            scroll2.MouseButton1Click:Connect(function()
                if object.Confirm then
                    object:Confirm(color3, scroll)
                end
            end)
            scroll2.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    scroll2.BackgroundTransparency = 0.4
                end
            end)
            scroll2.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    scroll2.BackgroundTransparency = 0
                end
            end)
            cancel.MouseButton1Click:Connect(function()
                if object.Cancel then
                    object:Cancel()
                end
            end)
            cancel.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    cancel.BackgroundTransparency = 0.4
                end
            end)
            cancel.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    cancel.BackgroundTransparency = 0
                end
            end)
            default.MouseButton1Click:Connect(function()
                if object.Default then
                    object:Default()
                end
            end)
            default.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    default.BackgroundTransparency = 0.4
                end
            end)
            default.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    default.BackgroundTransparency = 0
                end
            end)
            exit.MouseButton1Click:Connect(function()
                picker:TweenPosition(UDim2.new(0.5, -219, 0, -500), 'InOut', 'Quart', 0.5, true, nil)
            end)
            updateColor()
            function object.SetColor(arg1, arg2)
                num4, num5, num6 = arg2.r, arg2.g, arg2.b
                num, num2, num3 = Color3.toHSV(arg2)
                updateColor()
            end
            return object
        end}
        picker:TweenPosition(UDim2.new(0.5, -219, 0, 100), 'InOut', 'Quart', 0.5, true, nil)
        local object = data.new()
        function object.Confirm(arg1, arg2, arg3)
            updateColors(arg2, arg3)
            wait()
            updatesaves()
        end
        function object.Cancel(arg1)
            updateColors(cache_currentShade1, shade1)
            updateColors(cache_currentShade2, shade2)
            updateColors(cache_currentShade3, shade3)
            updateColors(cache_currentText1, text1)
            updateColors(cache_currentText2, text2)
            updateColors(cache_currentScroll, scroll)
            wait()
            updatesaves()
        end
        function object.Default(arg1)
            updateColors(Color3.fromRGB(36, 36, 37), shade1)
            updateColors(Color3.fromRGB(46, 46, 47), shade2)
            updateColors(Color3.fromRGB(78, 78, 79), shade3)
            updateColors(Color3.new(1, 1, 1), text1)
            updateColors(Color3.new(0, 0, 0), text2)
            updateColors(Color3.fromRGB(78, 78, 79), scroll)
            wait()
            updatesaves()
        end
        return
    end
    picker:TweenPosition(UDim2.new(0.5, -219, 0, 100), 'InOut', 'Quart', 0.5, true, nil)
end)
SettingsButton.MouseButton1Click:Connect(function()
    if flag2 == false then
        flag2 = true
        Settings:TweenPosition(UDim2.new(0, 0, 0, 45), 'InOut', 'Quart', 0.5, true, nil)
        CMDsF.Visible = false
        return
    end
    flag2 = false
    CMDsF.Visible = true
    Settings:TweenPosition(UDim2.new(0, 0, 0, 220), 'InOut', 'Quart', 0.5, true, nil)
end)
On.MouseButton1Click:Connect(function()
    if flag3 == false then
        if StayOpen == false then
            StayOpen = true
            On.BackgroundTransparency = 0
        else
            StayOpen = false
            On.BackgroundTransparency = 1
        end
        updatesaves()
    end
end)
Clear.MouseButton1Down:Connect(function()
    for _, child in pairs(scroll_2:GetChildren()) do
        child:Destroy()
    end
    scroll_2.CanvasSize = UDim2.new(0, 0, 0, 10)
end)
Clear_2.MouseButton1Down:Connect(function()
    for _, child in pairs(scroll_3:GetChildren()) do
        child:Destroy()
    end
    scroll_3.CanvasSize = UDim2.new(0, 0, 0, 10)
end)
Toggle.MouseButton1Down:Connect(function()
    if logsEnabled then
        logsEnabled = false
        Toggle.Text = 'Disabled'
        updatesaves()
        return
    end
    logsEnabled = true
    Toggle.Text = 'Enabled'
    updatesaves()
end)
Toggle_2.MouseButton1Down:Connect(function()
    if jLogsEnabled then
        jLogsEnabled = false
        Toggle_2.Text = 'Disabled'
        updatesaves()
        return
    end
    jLogsEnabled = true
    Toggle_2.Text = 'Enabled'
    updatesaves()
end)
selectChat.MouseButton1Down:Connect(function()
    join.Visible = false
    chat.Visible = true
    table.remove(shade3, table.find(shade3, selectChat))
    table.remove(shade2, table.find(shade2, selectJoin))
    table.insert(shade2, selectChat)
    table.insert(shade3, selectJoin)
    selectJoin.BackgroundColor3 = currentShade3
    selectChat.BackgroundColor3 = currentShade2
end)
selectJoin.MouseButton1Down:Connect(function()
    chat.Visible = false
    join.Visible = true
    table.remove(shade3, table.find(shade3, selectJoin))
    table.remove(shade2, table.find(shade2, selectChat))
    table.insert(shade2, selectJoin)
    table.insert(shade3, selectChat)
    selectChat.BackgroundColor3 = currentShade3
    selectJoin.BackgroundColor3 = currentShade2
end)
if not writefileExploit() then
    notify('Saves', 'Your exploit does not support read/write file. Your settings will not save.')
end
avatarcache = {}
sendChatWebhook = function(player, content)
    if httprequest and vtype(logsWebhook, 'string') then
        local userId = player.UserId
        local avatar_url = avatarcache[userId]
        if not avatar_url then
            local data = HttpService:JSONDecode(httprequest({Url = 'https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=' .. userId .. '&size=420x420&format=Png&isCircular=false', Method = 'GET'}).Body).data
            avatar_url = data and data[1].state == 'Completed' and data[1].imageUrl or 'https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/assets/plain.png'
            avatarcache[userId] = avatar_url
        end
        local body = HttpService:JSONEncode({content = content, avatar_url = avatar_url, username = formatUsername(player), allowed_mentions = {parse = {}}})
        httprequest({Url = logsWebhook, Method = 'POST', Headers = {['Content-Type'] = 'application/json'}, Body = body})
    end
end
ChatLog = function(arg1)
    arg1.Chatted:Connect(function(message)
        if logsEnabled == true then
            CreateLabel(arg1.Name, message)
            sendChatWebhook(arg1, message)
        end
    end)
end
JoinLog = function(player)
    if jLogsEnabled == true then
        CreateJoinLabel(player, player.UserId)
    end
end
CleanFileName = function(value)
    return tostring(value):gsub('[*\\?:<>|]+', ''):sub(1, 175)
end
SaveChatlogs.MouseButton1Down:Connect(function()
    if writefileExploit() then
        if #scroll_2:GetChildren() > 0 then
            notify('Loading', 'Hold on a sec')
            local result = CleanFileName(MarketplaceService:GetProductInfo(PlaceId).Name)
            local text = '-- Infinite Yield Chat logs for "' .. result .. '"\n'
            for _, child in pairs(scroll_2:GetChildren()) do
                text ..= '\n' .. child.Text
            end
            local text3 = tostring(text)
            local num = 0
            local function nameFile()
                local v1
                pcall(function()
                    v1 = readfile(result .. ' Chat Logs (' .. num .. ').txt')
                end)
                if v1 then
                    num = num + 1
                    nameFile()
                else
                    writefileCooldown(result .. ' Chat Logs (' .. num .. ').txt', text3)
                end
            end
            nameFile()
            notify('Chat Logs', 'Saved chat logs to the workspace folder within your exploit folder.')
        end
    else
        notify('Chat Logs', 'Your exploit does not support write file. You cannot save chat logs.')
    end
end)
if isLegacyChat then
    for _, player in pairs(Players:GetPlayers()) do
        ChatLog(player)
    end
end
Players.PlayerRemoving:Connect(function(player)
    if ESPenabled or CHMSenabled or COREGUI:FindFirstChild(player.Name .. '_LC') then
        for _, child in pairs(COREGUI:GetChildren()) do
            if child.Name ~= player.Name .. '_ESP' and child.Name ~= player.Name .. '_LC' and child.Name ~= player.Name .. '_CHMS' then
                continue
            end
            child:Destroy()
        end
    end
    if viewing ~= nil and player == viewing then
        workspace.CurrentCamera.CameraSubject = Players.LocalPlayer.Character
        viewing = nil
        if viewDied then
            viewDied:Disconnect()
            viewChanged:Disconnect()
        end
        notify('Spectate', 'View turned off (player left)')
    end
    eventEditor.FireEvent('OnLeave', player.Name)
end)
Exit.MouseButton1Down:Connect(function()
    logs:TweenPosition(UDim2.new(0, 0, 1, 10), 'InOut', 'Quart', 0.3, true, nil)
end)
Hide.MouseButton1Down:Connect(function()
    if logs.Position ~= UDim2.new(0, 0, 1, -20) then
        logs:TweenPosition(UDim2.new(0, 0, 1, -20), 'InOut', 'Quart', 0.3, true, nil)
        return
    end
    logs:TweenPosition(UDim2.new(0, 0, 1, -265), 'InOut', 'Quart', 0.3, true, nil)
end)
EventBind.MouseButton1Click:Connect(function()
    eventEditor.Frame:TweenPosition(UDim2.new(0.5, -175, 0.5, -101), 'InOut', 'Quart', 0.5, true, nil)
end)
Keybinds.MouseButton1Click:Connect(function()
    KeybindsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), 'InOut', 'Quart', 0.5, true, nil)
    wait(0.5)
    SettingsHolder.Visible = false
end)
Close.MouseButton1Click:Connect(function()
    SettingsHolder.Visible = true
    KeybindsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), 'InOut', 'Quart', 0.5, true, nil)
end)
Keybinds.MouseButton1Click:Connect(function()
    KeybindsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), 'InOut', 'Quart', 0.5, true, nil)
    wait(0.5)
    SettingsHolder.Visible = false
end)
Add.MouseButton1Click:Connect(function()
    KeybindEditor:TweenPosition(UDim2.new(0.5, -180, 0, 260), 'InOut', 'Quart', 0.5, true, nil)
end)
Delete.MouseButton1Click:Connect(function()
    binds = {}
    refreshbinds()
    updatesaves()
    notify('Keybinds Updated', 'Removed all keybinds')
end)
Close_2.MouseButton1Click:Connect(function()
    SettingsHolder.Visible = true
    AliasesFrame:TweenPosition(UDim2.new(0, 0, 0, 175), 'InOut', 'Quart', 0.5, true, nil)
end)
Aliases.MouseButton1Click:Connect(function()
    AliasesFrame:TweenPosition(UDim2.new(0, 0, 0, 0), 'InOut', 'Quart', 0.5, true, nil)
    wait(0.5)
    SettingsHolder.Visible = false
end)
Close_3.MouseButton1Click:Connect(function()
    SettingsHolder.Visible = true
    PositionsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), 'InOut', 'Quart', 0.5, true, nil)
end)
Positions.MouseButton1Click:Connect(function()
    PositionsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), 'InOut', 'Quart', 0.5, true, nil)
    wait(0.5)
    SettingsHolder.Visible = false
end)
local selectionBox = Instance.new('SelectionBox')
selectionBox.Name = randomString()
selectionBox.Color3 = Color3.new(255, 255, 255)
selectionBox.Adornee = nil
selectionBox.Parent = PARENT
local selectionBox2 = Instance.new('SelectionBox')
selectionBox2.Name = randomString()
selectionBox2.Color3 = Color3.new(0, 166, 0)
selectionBox2.Adornee = nil
selectionBox2.Parent = PARENT
local connection
local connection2
selectPart = function()
    ToPartFrame:TweenPosition(UDim2.new(0.5, -180, 0, 335), 'InOut', 'Quart', 0.5, true, nil)
    local function HighlightPart()
        if selectionBox2.Adornee ~= IYMouse.Target then
            selectionBox.Adornee = IYMouse.Target
            return
        end
        selectionBox.Adornee = nil
    end
    connection = IYMouse.Move:Connect(HighlightPart)
    local function SelectPart()
        if IYMouse.Target ~= nil then
            selectionBox2.Adornee = IYMouse.Target
            Path.Text = getHierarchy(IYMouse.Target)
        end
    end
    connection2 = IYMouse.Button1Down:Connect(SelectPart)
end
Part.MouseButton1Click:Connect(function()
    selectPart()
end)
Exit_4.MouseButton1Click:Connect(function()
    ToPartFrame:TweenPosition(UDim2.new(0.5, -180, 0, -500), 'InOut', 'Quart', 0.5, true, nil)
    if connection then
        connection:Disconnect()
    end
    if connection2 then
        connection2:Disconnect()
    end
    selectionBox.Adornee = nil
    selectionBox2.Adornee = nil
    Path.Text = ''
end)
CopyPath.MouseButton1Click:Connect(function()
    if Path.Text ~= '' then
        toClipboard(Path.Text)
        return
    end
    notify('Copy Path', 'Select a part to copy its path')
end)
ChoosePart.MouseButton1Click:Connect(function()
    if Path.Text ~= '' then
        local text = ''
        local function handleWpNames()
            local flag = false
            for _, pWayPoint in pairs(pWayPoints) do
                if pWayPoint.NAME:lower() ~= selectionBox2.Adornee.Name:lower() .. text then
                    continue
                end
                flag = true
            end
            if not flag then
                notify('Modified Waypoints', 'Created waypoint: ' .. selectionBox2.Adornee.Name .. text)
                pWayPoints[#pWayPoints + 1] = {NAME = selectionBox2.Adornee.Name .. text, COORD = {selectionBox2.Adornee}}
                return
            end
            if isNumber(text) then
                text = text + 1
            else
                text = 1
            end
            handleWpNames()
        end
        handleWpNames()
        refreshwaypoints()
        return
    end
    notify('Part Selection', 'Select a part first')
end)
cmds = {}
customAlias = {}
Delete_3.MouseButton1Click:Connect(function()
    customAlias = {}
    aliases = {}
    notify('Aliases Modified', 'Removed all aliases')
    updatesaves()
    refreshaliases()
end)
PrefixBox:GetPropertyChangedSignal('Text'):Connect(function()
    prefix = PrefixBox.Text
    Cmdbar.PlaceholderText = 'Command Bar (' .. prefix .. ')'
    updatesaves()
end)
CamViewport = function()
    if workspace.CurrentCamera then
        return workspace.CurrentCamera.ViewportSize.X
    end
end
UpdateToViewport = function()
    if Holder.Position.X.Offset < -CamViewport() then
        Holder:TweenPosition(UDim2.new(1, -CamViewport(), Holder.Position.Y.Scale, Holder.Position.Y.Offset), 'InOut', 'Quart', 0.04, true, nil)
        Notification:TweenPosition(UDim2.new(1, -CamViewport() + 250, Notification.Position.Y.Scale, Notification.Position.Y.Offset), 'InOut', 'Quart', 0.04, true, nil)
    end
end
CameraChanged = workspace.CurrentCamera:GetPropertyChangedSignal('ViewportSize'):Connect(UpdateToViewport)
updateCamera = function(arg1, arg2)
    if arg2 ~= workspace then
        CamMoved:Disconnect()
        CameraChanged:Disconnect()
        repeat
            wait()
        until workspace.CurrentCamera
        CameraChanged = workspace.CurrentCamera:GetPropertyChangedSignal('ViewportSize'):Connect(UpdateToViewport)
        CamMoved = workspace.CurrentCamera.AncestryChanged:Connect(updateCamera)
    end
end
CamMoved = workspace.CurrentCamera.AncestryChanged:Connect(updateCamera)
dragMain = function(userInputService, instance)
    task.spawn(function()
        local v1
        local v2
        local vector3 = Vector3.new(0, 0, 0)
        local v3
        local function update(arg1)
            local num, v1 = -250, arg1.Position - vector3
            local num2
            if v3.X.Offset + v1.X <= -500 then
                local udim2 = UDim2.new(1, -250, Notification.Position.Y.Scale, Notification.Position.Y.Offset)
                TweenService:Create(Notification, TweenInfo.new(0.2), {Position = udim2}):Play()
                num2 = 250
            else
                local udim22 = UDim2.new(1, -500, Notification.Position.Y.Scale, Notification.Position.Y.Offset)
                TweenService:Create(Notification, TweenInfo.new(0.2), {Position = udim22}):Play()
                num2 = -250
            end
            if v3.X.Offset + v1.X <= -250 and -CamViewport() <= v3.X.Offset + v1.X then
                local udim23 = UDim2.new(v3.X.Scale, v3.X.Offset + v1.X, instance.Position.Y.Scale, instance.Position.Y.Offset)
                TweenService:Create(instance, TweenInfo.new(0.2), {Position = udim23}):Play()
                local udim24 = UDim2.new(v3.X.Scale, v3.X.Offset + v1.X + num2, Notification.Position.Y.Scale, Notification.Position.Y.Offset)
                TweenService:Create(Notification, TweenInfo.new(0.2), {Position = udim24}):Play()
                return
            end
            if v3.X.Offset + v1.X > -500 then
                local udim25 = UDim2.new(1, -250, instance.Position.Y.Scale, instance.Position.Y.Offset)
                TweenService:Create(instance, TweenInfo.new(0.2), {Position = udim25}):Play()
                return
            end
            if -CamViewport() > v3.X.Offset + v1.X then
                instance:TweenPosition(UDim2.new(1, -CamViewport(), instance.Position.Y.Scale, instance.Position.Y.Offset), 'InOut', 'Quart', 0.04, true, nil)
                local udim26 = UDim2.new(1, -CamViewport(), instance.Position.Y.Scale, instance.Position.Y.Offset)
                TweenService:Create(instance, TweenInfo.new(0.2), {Position = udim26}):Play()
                local udim27 = UDim2.new(1, -CamViewport() + 250, Notification.Position.Y.Scale, Notification.Position.Y.Offset)
                TweenService:Create(Notification, TweenInfo.new(0.2), {Position = udim27}):Play()
            end
        end
        userInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                v1 = true
                vector3 = input.Position
                v3 = instance.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        v1 = false
                    end
                end)
            end
        end)
        userInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                v2 = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == v2 and v1 then
                update(input)
            end
        end)
    end)
end
dragMain(Title, Holder)
Match = function(text, text3)
    text3 = text3:gsub('%W', '%%%1')
    return text:lower():find(text3:lower()) and true
end
local vector2 = Vector2.new(0, 0)
local v4
local function updateCommandCanvasSize(arg1)
    local num = Scale and Scale.Scale or 1
    if num <= 0 then
        num = 1
    end
    local y = cmdListLayout.AbsoluteContentSize.Y
    local ceiled = math.ceil(y / num)
    arg1.CanvasSize = UDim2.new(0, 0, 0, math.max(0, ceiled))
end
cmdListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
    updateCommandCanvasSize(CMDsF)
end)
IndexContents = function(text, arg2, arg3, arg4)
    CMDsF.CanvasPosition = Vector2.new(0, 0)
    local count = 0
    local CMDsF = CMDsF
    v4 = nil
    local list = {}
    if text:sub(#text, #text) == '\\' then
        text = ''
    end
    for match in string.gmatch(text, '[^\\]+') do
        table.insert(list, match)
    end
    if #list > 0 then
        text = list[#list]
    end
    if text:sub(1, 1) == '!' then
        text = text:sub(2)
    end
    for _, child in next, CMDsF:GetChildren() do
        if not child:IsA('TextButton') then
            continue
        end
        if arg2 then
            if Match(child.Text, text) then
                count += 1
                child.Visible = true
                if v4 ~= nil then
                    continue
                end
                v4 = child.Text
            else
                child.Visible = false
            end
        else
            child.Visible = true
            if v4 ~= nil then
                continue
            end
            v4 = child.Text
        end
    end
    updateCommandCanvasSize(CMDsF)
    if not arg4 then
        if count == 0 or string.find(text, ' ') then
            if not arg3 then
                minimizeHolder()
                return
            end
            if arg3 then
                cmdbarHolder()
            end
        else
            maximizeHolder()
            return
        end
    end
    minimizeHolder()
end
task.spawn(function()
    if not isLegacyChat then
        return
    end
    local instance
    local success, result = pcall(function()
        instance = PlayerGui:WaitForChild('Chat').Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
    end)
    if success then
        local function chatboxFocused()
            vector2 = CMDsF.CanvasPosition
        end
        local connection = instance.Focused:Connect(chatboxFocused)
        local function Index()
            if instance.Text:lower():sub(1, 1) == prefix then
                if flag2 == true then
                    wait(0.2)
                    CMDsF.Visible = true
                    Settings:TweenPosition(UDim2.new(0, 0, 0, 220), 'InOut', 'Quart', 0.2, true, nil)
                end
                IndexContents(PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar.Text:lower():sub(2), true)
                return
            end
            minimizeHolder()
            if flag2 == true then
                wait(0.2)
                Settings:TweenPosition(UDim2.new(0, 0, 0, 45), 'InOut', 'Quart', 0.2, true, nil)
                CMDsF.Visible = false
            end
        end
        local connection2 = instance:GetPropertyChangedSignal('Text'):Connect(Index)
        local function chatboxFocusLost(enterPressed)
            if not enterPressed or instance.Text:lower():sub(1, 1) ~= prefix then
                IndexContents('', true)
            end
            CMDsF.CanvasPosition = vector2
            minimizeHolder()
        end
        local connection3 = instance.FocusLost:Connect(chatboxFocusLost)
        PlayerGui:WaitForChild('Chat').Frame.ChatBarParentFrame.ChildAdded:Connect(function(child)
            wait()
            if child:FindFirstChild('BoxFrame') then
                instance = PlayerGui:WaitForChild('Chat').Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
                if connection then
                    connection:Disconnect()
                end
                connection = instance.Focused:Connect(chatboxFocused)
                if connection2 then
                    connection2:Disconnect()
                end
                connection2 = instance:GetPropertyChangedSignal('Text'):Connect(Index)
                if connection3 then
                    connection3:Disconnect()
                end
                connection3 = instance.FocusLost:Connect(chatboxFocusLost)
            end
        end)
    end
end)
autoComplete = function(text, text3)
    local list = {'[', '/', '(', ' '}
    local num = 0
    for i = 1, #text do
        local value = text:sub(i, i)
        if not table.find(list, value) then
            continue
        end
        num = i
        break
    end
    text3 = text3 or Cmdbar.Text
    local count = 0
    local num2 = 1
    local result = string.find(text3, '\\', num2)
    while result do
        count = result
        local v1 = result + 1
        result = string.find(text3, '\\', v1)
    end
    if text3:sub(count + 1, count + 1) == '!' then
        count += 1
    end
    Cmdbar.Text = text3:sub(1, count) .. text:sub(1, num - 1) .. ' '
    RunService.RenderStepped:Wait()
    Cmdbar.Text = Cmdbar.Text:gsub('\t', '')
    Cmdbar.CursorPosition = #Cmdbar.Text + 1
end
CMDs = {}
CMDs[#CMDs + 1] = {NAME = 'discord / support / help', DESC = 'Invite to the Infinite Yield discord server.'}
CMDs[#CMDs + 1] = {NAME = 'guiscale [number]', DESC = 'Changes the size of the gui. [number] accepts decimals and whole numbers. Min is 0.4 and Max is 2'}
CMDs[#CMDs + 1] = {NAME = 'console', DESC = 'Opens the Roblox console'}
CMDs[#CMDs + 1] = {NAME = 'oldconsole', DESC = 'Loads an old-themed Roblox console'}
CMDs[#CMDs + 1] = {NAME = 'explorer / dex', DESC = 'Opens Dex++ by Chillz'}
CMDs[#CMDs + 1] = {NAME = 'moondex / mdex', DESC = 'Opens DEX by Moon'}
CMDs[#CMDs + 1] = {NAME = 'remotespy / rspy', DESC = 'Opens Cobalt to intercept incoming and outgoing network traffic'}
CMDs[#CMDs + 1] = {NAME = 'simplespy / sspy', DESC = 'Opens Simple Spy V3 to intercept remote calls from the client to the server'}
CMDs[#CMDs + 1] = {NAME = 'audiologger / alogger', DESC = 'Opens Edges audio logger'}
CMDs[#CMDs + 1] = {NAME = 'serverinfo / info', DESC = 'Gives you info about the server'}
CMDs[#CMDs + 1] = {NAME = 'jobid', DESC = 'Copies the games JobId to your clipboard'}
CMDs[#CMDs + 1] = {NAME = 'notifyjobid', DESC = 'Notifies you the games JobId'}
CMDs[#CMDs + 1] = {NAME = 'rejoin / rj [reposition]', DESC = 'Makes you rejoin the game'}
CMDs[#CMDs + 1] = {NAME = 'inviteprompt', DESC = 'Prompts the user of your choice that they had invited you. Requires a rejoin to function.'}
CMDs[#CMDs + 1] = {NAME = 'autorejoin / autorj', DESC = 'Automatically rejoins the server if you get kicked/disconnected'}
CMDs[#CMDs + 1] = {NAME = 'serverhop / shop', DESC = 'Teleports you to a different server'}
CMDs[#CMDs + 1] = {NAME = 'gameteleport / gametp [place ID]', DESC = 'Joins a game by ID'}
CMDs[#CMDs + 1] = {NAME = 'antiidle / antiafk', DESC = 'Prevents the game from kicking you for being idle/afk'}
CMDs[#CMDs + 1] = {NAME = 'datalimit [num]', DESC = 'Set outgoing KBPS limit'}
CMDs[#CMDs + 1] = {NAME = 'replicationlag / backtrack [num]', DESC = 'Set IncomingReplicationLag'}
CMDs[#CMDs + 1] = {NAME = 'creatorid / creator', DESC = 'Notifies you the creators ID'}
CMDs[#CMDs + 1] = {NAME = 'copycreatorid / copycreator', DESC = 'Copies the creators ID to your clipboard'}
CMDs[#CMDs + 1] = {NAME = 'setcreatorid / setcreator', DESC = 'Sets your userid to the creators ID'}
CMDs[#CMDs + 1] = {NAME = 'noprompts', DESC = 'Prevents the game from showing you purchase/premium prompts'}
CMDs[#CMDs + 1] = {NAME = 'showprompts', DESC = 'Allows the game to show purchase/premium prompts again'}
CMDs[#CMDs + 1] = {NAME = 'enable [inventory/playerlist/chat/reset/emotes/all]', DESC = 'Toggles visibility of coregui items'}
CMDs[#CMDs + 1] = {NAME = 'disable [inventory/playerlist/chat/reset/emotes/all]', DESC = 'Toggles visibility of coregui items'}
CMDs[#CMDs + 1] = {NAME = 'showguis', DESC = 'Shows any invisible GUIs'}
CMDs[#CMDs + 1] = {NAME = 'unshowguis', DESC = 'Undoes showguis'}
CMDs[#CMDs + 1] = {NAME = 'hideguis', DESC = 'Hides any GUIs in PlayerGui'}
CMDs[#CMDs + 1] = {NAME = 'unhideguis', DESC = 'Undoes hideguis'}
CMDs[#CMDs + 1] = {NAME = 'guidelete', DESC = 'Enables backspace to delete GUI'}
CMDs[#CMDs + 1] = {NAME = 'unguidelete / noguidelete', DESC = 'Disables guidelete'}
CMDs[#CMDs + 1] = {NAME = 'hideiy', DESC = 'Hides the main IY GUI'}
CMDs[#CMDs + 1] = {NAME = 'showiy / unhideiy', DESC = 'Shows IY again'}
CMDs[#CMDs + 1] = {NAME = 'keepiy', DESC = 'Auto execute IY when you teleport through servers'}
CMDs[#CMDs + 1] = {NAME = 'unkeepiy', DESC = 'Disable keepiy'}
CMDs[#CMDs + 1] = {NAME = 'togglekeepiy', DESC = 'Toggles keepiy'}
CMDs[#CMDs + 1] = {NAME = 'removeads / adblock', DESC = 'Automatically removes ad billboards'}
CMDs[#CMDs + 1] = {NAME = 'savegame / saveplace', DESC = 'Uses saveinstance to save the game'}
CMDs[#CMDs + 1] = {NAME = 'clearerror', DESC = 'Clears the annoying box and blur when a game kicks you'}
CMDs[#CMDs + 1] = {NAME = 'antigameplaypaused', DESC = 'Clears the annoying box shown when a game is loading assets due to network lag'}
CMDs[#CMDs + 1] = {NAME = 'unantigameplaypaused', DESC = 'Disables antigameplaypaused'}
CMDs[#CMDs + 1] = {NAME = 'clientantikick / antikick (CLIENT)', DESC = 'Prevents localscripts from kicking you'}
CMDs[#CMDs + 1] = {NAME = 'clientantiteleport / antiteleport (CLIENT)', DESC = 'Prevents localscripts from teleporting you'}
CMDs[#CMDs + 1] = {NAME = 'allowrejoin / allowrj (CLIENT)', DESC = 'Toggles if antiteleport allows you to rejoin or not'}
CMDs[#CMDs + 1] = {NAME = 'cancelteleport / canceltp', DESC = 'Cancels teleports in progress'}
CMDs[#CMDs + 1] = {NAME = 'volume / vol [0-10]', DESC = 'Adjusts your game volume on a scale of 0 to 10'}
CMDs[#CMDs + 1] = {NAME = 'antilag / boostfps / lowgraphics', DESC = 'Lowers game quality to boost FPS'}
CMDs[#CMDs + 1] = {NAME = 'record / rec', DESC = 'Starts Roblox recorder'}
CMDs[#CMDs + 1] = {NAME = 'screenshot / scrnshot', DESC = 'Takes a screenshot'}
CMDs[#CMDs + 1] = {NAME = 'togglefullscreen / togglefs', DESC = 'Toggles fullscreen'}
CMDs[#CMDs + 1] = {NAME = 'notify [text]', DESC = 'Sends you a notification with the provided text'}
CMDs[#CMDs + 1] = {NAME = 'lastcommand / lastcmd', DESC = 'Executes the previous command used'}
CMDs[#CMDs + 1] = {NAME = 'notifyping / ping', DESC = 'Notify yourself your ping'}
CMDs[#CMDs + 1] = {NAME = 'norender', DESC = 'Disable 3d Rendering to decrease the amount of CPU the client uses'}
CMDs[#CMDs + 1] = {NAME = 'render', DESC = 'Enable 3d Rendering'}
CMDs[#CMDs + 1] = {NAME = 'use2022materials / 2022materials', DESC = 'Enables 2022 material textures'}
CMDs[#CMDs + 1] = {NAME = 'unuse2022materials / un2022materials', DESC = 'Disables 2022 material textures'}
CMDs[#CMDs + 1] = {NAME = 'alignmentkeys', DESC = 'Enables the left and right alignment keys (comma and period)'}
CMDs[#CMDs + 1] = {NAME = 'unalignmentkeys / noalignmentkeys', DESC = 'Disables the alignment keys'}
CMDs[#CMDs + 1] = {NAME = 'ctrllock', DESC = 'Binds Shiftlock to LeftControl'}
CMDs[#CMDs + 1] = {NAME = 'unctrllock', DESC = 'Re-binds Shiftlock to LeftShift'}
CMDs[#CMDs + 1] = {NAME = 'exit / shutdown / leave', DESC = 'Exits the game'}
CMDs[#CMDs + 1] = {NAME = 'removecmd / deletecmd', DESC = 'Removes a command until the script is reloaded'}
CMDs[#CMDs + 1] = {NAME = 'breakloops / break (cmd loops)', DESC = 'Stops any cmd loops (;100^1^cmd)'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'noclip', DESC = 'Go through objects'}
CMDs[#CMDs + 1] = {NAME = 'unnoclip / clip', DESC = 'Disables noclip'}
CMDs[#CMDs + 1] = {NAME = 'fly [speed]', DESC = 'Makes you fly'}
CMDs[#CMDs + 1] = {NAME = 'unfly', DESC = 'Disables fly'}
CMDs[#CMDs + 1] = {NAME = 'flyspeed [num]', DESC = 'Set fly speed (default is 20)'}
CMDs[#CMDs + 1] = {NAME = 'vehiclefly / vfly [speed]', DESC = 'Makes you fly in a vehicle'}
CMDs[#CMDs + 1] = {NAME = 'unvehiclefly / unvfly', DESC = 'Disables vehicle fly'}
CMDs[#CMDs + 1] = {NAME = 'vehicleflyspeed  / vflyspeed [num]', DESC = 'Set vehicle fly speed'}
CMDs[#CMDs + 1] = {NAME = 'cframefly / cfly [speed]', DESC = 'Makes you fly, bypassing some anti cheats (works on mobile)'}
CMDs[#CMDs + 1] = {NAME = 'uncframefly / uncfly', DESC = 'Disables cfly'}
CMDs[#CMDs + 1] = {NAME = 'cframeflyspeed  / cflyspeed [num]', DESC = 'Sets cfly speed'}
CMDs[#CMDs + 1] = {NAME = 'qefly [true / false]', DESC = 'Enables or disables the Q and E hotkeys for fly'}
CMDs[#CMDs + 1] = {NAME = 'vehiclenoclip / vnoclip', DESC = 'Turns off vehicle collision'}
CMDs[#CMDs + 1] = {NAME = 'vehicleclip / vclip / unvnoclip', DESC = 'Enables vehicle collision'}
CMDs[#CMDs + 1] = {NAME = 'float /  platform', DESC = 'Spawns a platform beneath you causing you to float'}
CMDs[#CMDs + 1] = {NAME = 'unfloat / noplatform', DESC = 'Removes the platform'}
CMDs[#CMDs + 1] = {NAME = 'swim', DESC = 'Allows you to swim in the air'}
CMDs[#CMDs + 1] = {NAME = 'unswim / noswim', DESC = 'Stops you from swimming everywhere'}
CMDs[#CMDs + 1] = {NAME = 'toggleswim', DESC = 'Toggles swimming'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'setwaypoint / swp [name]', DESC = 'Sets a waypoint at your position'}
CMDs[#CMDs + 1] = {NAME = 'waypointpos / wpp [name] [X Y Z]', DESC = 'Sets a waypoint with specified coordinates'}
CMDs[#CMDs + 1] = {NAME = 'waypoints', DESC = 'Shows a list of currently active waypoints'}
CMDs[#CMDs + 1] = {NAME = 'showwaypoints / showwp', DESC = 'Shows all currently set waypoints'}
CMDs[#CMDs + 1] = {NAME = 'hidewaypoints / hidewp', DESC = 'Hides shown waypoints'}
CMDs[#CMDs + 1] = {NAME = 'waypoint / wp [name]', DESC = 'Teleports player to a waypoint'}
CMDs[#CMDs + 1] = {NAME = 'tweenwaypoint / twp [name]', DESC = 'Tweens player to a waypoint'}
CMDs[#CMDs + 1] = {NAME = 'walktowaypoint / wtwp [name]', DESC = 'Walks player to a waypoint'}
CMDs[#CMDs + 1] = {NAME = 'deletewaypoint / dwp [name]', DESC = 'Deletes a waypoint'}
CMDs[#CMDs + 1] = {NAME = 'clearwaypoints / cwp', DESC = 'Clears all waypoints'}
CMDs[#CMDs + 1] = {NAME = 'cleargamewaypoints / cgamewp', DESC = 'Clears all waypoints for the game you are in'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'goto [player] [request stream]', DESC = 'Go to a player'}
CMDs[#CMDs + 1] = {NAME = 'tweengoto / tgoto [player]', DESC = 'Tween to a player (bypasses some anti cheats)'}
CMDs[#CMDs + 1] = {NAME = 'tweenspeed / tspeed [num]', DESC = 'Sets how fast all tween commands go (default is 1)'}
CMDs[#CMDs + 1] = {NAME = 'vehiclegoto / vgoto [player]', DESC = 'Go to a player while in a vehicle'}
CMDs[#CMDs + 1] = {NAME = 'loopgoto [player] [distance] [delay]', DESC = 'Loop teleport to a player'}
CMDs[#CMDs + 1] = {NAME = 'unloopgoto', DESC = 'Stops teleporting you to a player'}
CMDs[#CMDs + 1] = {NAME = 'pulsetp / ptp [player] [seconds]', DESC = 'Teleports you to a player for a specified amount of time'}
CMDs[#CMDs + 1] = {NAME = 'clientbring / cbring [player] (CLIENT)', DESC = 'Bring a player'}
CMDs[#CMDs + 1] = {NAME = 'loopbring [player] [distance] [delay] (CLIENT)', DESC = 'Loop brings a player to you (useful for killing)'}
CMDs[#CMDs + 1] = {NAME = 'unloopbring [player]', DESC = 'Undoes loopbring'}
CMDs[#CMDs + 1] = {NAME = 'freeze / fr [player] (CLIENT)', DESC = 'Freezes a player'}
CMDs[#CMDs + 1] = {NAME = 'freezeanims', DESC = 'Freezes your animations / pauses your animations - Does not work on default animations'}
CMDs[#CMDs + 1] = {NAME = 'unfreezeanims', DESC = 'Unfreezes your animations / plays your animations'}
CMDs[#CMDs + 1] = {NAME = 'thaw / unfr [player] (CLIENT)', DESC = 'Unfreezes a player'}
CMDs[#CMDs + 1] = {NAME = 'anchor', DESC = 'Anchors your characters RootPart'}
CMDs[#CMDs + 1] = {NAME = 'unanchor', DESC = 'Unanchors your characters RootPart'}
CMDs[#CMDs + 1] = {NAME = 'tpposition / tppos [X Y Z]', DESC = 'Teleports you to certain coordinates'}
CMDs[#CMDs + 1] = {NAME = 'tweentpposition / ttppos [X Y Z]', DESC = 'Tween to coordinates (bypasses some anti cheats)'}
CMDs[#CMDs + 1] = {NAME = 'offset [X Y Z]', DESC = 'Offsets you by certain coordinates'}
CMDs[#CMDs + 1] = {NAME = 'tweenoffset / toffset [X Y Z]', DESC = 'Tween offset (bypasses some anti cheats)'}
CMDs[#CMDs + 1] = {NAME = 'thru [num]', DESC = 'Teleports you [num] studs ahead of where your character is facing'}
CMDs[#CMDs + 1] = {NAME = 'notifyposition / notifypos [player]', DESC = 'Notifies you the coordinates of a character'}
CMDs[#CMDs + 1] = {NAME = 'copyposition / copypos [player]', DESC = 'Copies the coordinates of a character to your clipboard'}
CMDs[#CMDs + 1] = {NAME = 'walktoposition / walktopos [X Y Z]', DESC = 'Makes you walk to a coordinate'}
CMDs[#CMDs + 1] = {NAME = 'spawnpoint / spawn [delay]', DESC = 'Sets a position where you will spawn'}
CMDs[#CMDs + 1] = {NAME = 'nospawnpoint / nospawn', DESC = 'Removes your custom spawn point'}
CMDs[#CMDs + 1] = {NAME = 'flashback / diedtp', DESC = 'Teleports you to where you last died'}
CMDs[#CMDs + 1] = {NAME = 'walltp', DESC = 'Teleports you above/over any wall you run into'}
CMDs[#CMDs + 1] = {NAME = 'nowalltp / unwalltp', DESC = 'Disables walltp'}
CMDs[#CMDs + 1] = {NAME = 'teleporttool / tptool', DESC = 'Gives you a teleport tool'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'logs', DESC = 'Opens the logs GUI'}
CMDs[#CMDs + 1] = {NAME = 'chatlogs / clogs', DESC = 'Log what people say or whisper'}
CMDs[#CMDs + 1] = {NAME = 'joinlogs / jlogs', DESC = 'Log when people join'}
CMDs[#CMDs + 1] = {NAME = 'chatlogswebhook / logswebhook [url]', DESC = 'Set a discord webhook for chatlogs to go to (provide no url to disable this)'}
CMDs[#CMDs + 1] = {NAME = 'chat / say [text]', DESC = 'Makes you chat a string (possible mute bypass)'}
CMDs[#CMDs + 1] = {NAME = 'spam [text]', DESC = 'Makes you spam the chat'}
CMDs[#CMDs + 1] = {NAME = 'unspam', DESC = 'Turns off spam'}
CMDs[#CMDs + 1] = {NAME = 'whisper / pm [player] [text]', DESC = 'Makes you whisper a string to someone (possible mute bypass)'}
CMDs[#CMDs + 1] = {NAME = 'pmspam [player] [text]', DESC = 'Makes you spam a players whispers'}
CMDs[#CMDs + 1] = {NAME = 'unpmspam [player]', DESC = 'Turns off pm spam'}
CMDs[#CMDs + 1] = {NAME = 'spamspeed [num]', DESC = 'How quickly you spam (default is 1)'}
CMDs[#CMDs + 1] = {NAME = 'bubblechat (CLIENT)', DESC = 'Enables bubble chat for your client'}
CMDs[#CMDs + 1] = {NAME = 'unbubblechat / nobubblechat', DESC = 'Disables the bubblechat command'}
CMDs[#CMDs + 1] = {NAME = 'chatwindow', DESC = 'Enables the chat window for your client'}
CMDs[#CMDs + 1] = {NAME = 'unchatwindow / nochatwindow', DESC = 'Disables the chat window for your client'}
CMDs[#CMDs + 1] = {NAME = 'darkchat', DESC = 'Makes the chat window dark for your client'}
CMDs[#CMDs + 1] = {NAME = 'listento [player]', DESC = 'Listens to the area around a player. Can also eavesdrop with vc'}
CMDs[#CMDs + 1] = {NAME = 'unlistento', DESC = 'Disables listento'}
CMDs[#CMDs + 1] = {NAME = 'muteallvoices / muteallvcs', DESC = 'Mutes voice chat for all players'}
CMDs[#CMDs + 1] = {NAME = 'unmuteallvoices / unmuteallvcs', DESC = 'Unmutes voice chat for all players'}
CMDs[#CMDs + 1] = {NAME = 'mutevc [player]', DESC = 'Mutes the voice chat of a player'}
CMDs[#CMDs + 1] = {NAME = 'unmutevc [player]', DESC = 'Unmutes the voice chat of a player'}
CMDs[#CMDs + 1] = {NAME = 'phonebook / call', DESC = 'Prompts the Roblox phonebook UI to let you call your friends. Needs voice chat enabled'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'esp', DESC = 'View all players and their status'}
CMDs[#CMDs + 1] = {NAME = 'espteam', DESC = 'ESP but teammates are green and bad guys are red'}
CMDs[#CMDs + 1] = {NAME = 'noesp / unesp / unespteam', DESC = 'Removes ESP'}
CMDs[#CMDs + 1] = {NAME = 'esptransparency [number]', DESC = 'Changes the transparency of ESP related commands'}
CMDs[#CMDs + 1] = {NAME = 'partesp [part name]', DESC = 'Highlights a part'}
CMDs[#CMDs + 1] = {NAME = 'unpartesp / nopartesp [part name]', DESC = 'removes partesp'}
CMDs[#CMDs + 1] = {NAME = 'chams', DESC = 'ESP but without text in the way'}
CMDs[#CMDs + 1] = {NAME = 'nochams / unchams', DESC = 'Removes chams'}
CMDs[#CMDs + 1] = {NAME = 'locate [player]', DESC = 'View a single player and their status'}
CMDs[#CMDs + 1] = {NAME = 'unlocate / nolocate [player]', DESC = 'Removes locate'}
CMDs[#CMDs + 1] = {NAME = 'xray', DESC = 'Makes all parts in workspace transparent'}
CMDs[#CMDs + 1] = {NAME = 'unxray / noxray', DESC = 'Restores transparency to all parts in workspace'}
CMDs[#CMDs + 1] = {NAME = 'loopxray', DESC = 'Makes all parts in workspace transparent but looped'}
CMDs[#CMDs + 1] = {NAME = 'unloopxray', DESC = 'Unloops xray'}
CMDs[#CMDs + 1] = {NAME = 'togglexray', DESC = 'Toggles xray'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'spectate / view [player]', DESC = 'View a player'}
CMDs[#CMDs + 1] = {NAME = 'viewpart / viewp [part name]', DESC = 'View a part'}
CMDs[#CMDs + 1] = {NAME = 'unspectate / unview', DESC = 'Stops viewing player'}
CMDs[#CMDs + 1] = {NAME = 'freecam / fc', DESC = 'Allows you to freely move camera around the game'}
CMDs[#CMDs + 1] = {NAME = 'freecampos / fcpos [X Y Z]', DESC = 'Moves / opens freecam in a certain position'}
CMDs[#CMDs + 1] = {NAME = 'freecamwaypoint / fcwp [name]', DESC = 'Moves / opens freecam to a waypoint'}
CMDs[#CMDs + 1] = {NAME = 'freecamgoto / fcgoto / fctp [player]', DESC = 'Moves / opens freecam to a player'}
CMDs[#CMDs + 1] = {NAME = 'unfreecam / unfc', DESC = 'Disables freecam'}
CMDs[#CMDs + 1] = {NAME = 'freecamspeed / fcspeed [num]', DESC = 'Adjusts freecam speed (default is 1)'}
CMDs[#CMDs + 1] = {NAME = 'notifyfreecamposition / notifyfcpos', DESC = 'Noitifies you your freecam coordinates'}
CMDs[#CMDs + 1] = {NAME = 'copyfreecamposition / copyfcpos', DESC = 'Copies your freecam coordinates to your clipboard'}
CMDs[#CMDs + 1] = {NAME = 'gotocamera / gotocam', DESC = 'Teleports you to the location of your camera'}
CMDs[#CMDs + 1] = {NAME = 'tweengotocam / tgotocam', DESC = 'Tweens you to the location of your camera'}
CMDs[#CMDs + 1] = {NAME = 'firstp', DESC = 'Forces camera to go into first person'}
CMDs[#CMDs + 1] = {NAME = 'thirdp', DESC = 'Allows camera to go into third person'}
CMDs[#CMDs + 1] = {NAME = 'noclipcam / nccam', DESC = 'Allows camera to go through objects like walls'}
CMDs[#CMDs + 1] = {NAME = 'maxzoom [num]', DESC = 'Maximum camera zoom'}
CMDs[#CMDs + 1] = {NAME = 'minzoom [num]', DESC = 'Minimum camera zoom'}
CMDs[#CMDs + 1] = {NAME = 'camdistance [num]', DESC = 'Changes camera distance from your player'}
CMDs[#CMDs + 1] = {NAME = 'fov [num]', DESC = 'Adjusts field of view (default is 70)'}
CMDs[#CMDs + 1] = {NAME = 'fixcam / restorecam', DESC = 'Fixes camera'}
CMDs[#CMDs + 1] = {NAME = 'enableshiftlock / enablesl', DESC = 'Enables the shift lock option'}
CMDs[#CMDs + 1] = {NAME = 'lookat [player]', DESC = 'Moves your camera view to a player'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'btools (CLIENT)', DESC = 'Gives you building tools (DOES NOT REPLICATE)'}
CMDs[#CMDs + 1] = {NAME = 'f3x (CLIENT)', DESC = 'Gives you F3X building tools (DOES NOT REPLICATE)'}
CMDs[#CMDs + 1] = {NAME = 'partname / partpath', DESC = 'Allows you to click a part to see its path & name'}
CMDs[#CMDs + 1] = {NAME = 'delete [instance name] (CLIENT)', DESC = 'Removes any part with a certain name from the workspace (DOES NOT REPLICATE)'}
CMDs[#CMDs + 1] = {NAME = 'deleteclass / dc [class name] (CLIENT)', DESC = 'Removes any part with a certain classname from the workspace (DOES NOT REPLICATE)'}
CMDs[#CMDs + 1] = {NAME = 'lockworkspace / lockws', DESC = 'Locks the whole workspace'}
CMDs[#CMDs + 1] = {NAME = 'unlockworkspace / unlockws', DESC = 'Unlocks the whole workspace'}
CMDs[#CMDs + 1] = {NAME = 'invisibleparts / invisparts (CLIENT)', DESC = 'Shows invisible parts'}
CMDs[#CMDs + 1] = {NAME = 'uninvisibleparts / uninvisparts (CLIENT)', DESC = 'Makes parts affected by invisparts return to normal'}
CMDs[#CMDs + 1] = {NAME = 'deleteinvisparts / dip (CLIENT)', DESC = 'Deletes invisible parts'}
CMDs[#CMDs + 1] = {NAME = 'gotopart [part name]', DESC = 'Moves your character to a part or multiple parts'}
CMDs[#CMDs + 1] = {NAME = 'tweengotopart / tgotopart [part name]', DESC = 'Tweens your character to a part or multiple parts'}
CMDs[#CMDs + 1] = {NAME = 'gotopartclass / gpc [class name]', DESC = 'Moves your character to a part or multiple parts based on classname'}
CMDs[#CMDs + 1] = {NAME = 'tweengotopartclass / tgpc [class name]', DESC = 'Tweens your character to a part or multiple parts based on classname'}
CMDs[#CMDs + 1] = {NAME = 'gotomodel [part name]', DESC = 'Moves your character to a model or multiple models'}
CMDs[#CMDs + 1] = {NAME = 'tweengotomodel / tgotomodel [part name]', DESC = 'Tweens your character to a model or multiple models'}
CMDs[#CMDs + 1] = {NAME = 'gotopartdelay / gotomodeldelay [num]', DESC = 'Adjusts how quickly you teleport to each part (default is 0.1)'}
CMDs[#CMDs + 1] = {NAME = 'bringpart [part name] (CLIENT)', DESC = 'Moves a part or multiple parts to your character'}
CMDs[#CMDs + 1] = {NAME = 'bringpartclass / bpc [class name] (CLIENT)', DESC = 'Moves a part or multiple parts to your character based on classname'}
CMDs[#CMDs + 1] = {NAME = 'noclickdetectorlimits / nocdlimits', DESC = 'Sets all click detectors MaxActivationDistance to math.huge'}
CMDs[#CMDs + 1] = {NAME = 'fireclickdetectors / firecd [name]', DESC = 'Uses all click detectors in a game or uses the optional name'}
CMDs[#CMDs + 1] = {NAME = 'firetouchinterests / touchinterests [name]', DESC = 'Uses all touchinterests in a game or uses the optional name'}
CMDs[#CMDs + 1] = {NAME = 'noproximitypromptlimits / nopplimits', DESC = 'Sets all proximity prompts MaxActivationDistance to math.huge'}
CMDs[#CMDs + 1] = {NAME = 'fireproximityprompts / firepp [name]', DESC = 'Uses all proximity prompts in a game or uses the optional name'}
CMDs[#CMDs + 1] = {NAME = 'instantproximityprompts / instantpp', DESC = 'Disable the cooldown for proximity prompts'}
CMDs[#CMDs + 1] = {NAME = 'uninstantproximityprompts / uninstantpp', DESC = 'Undo the cooldown removal'}
CMDs[#CMDs + 1] = {NAME = 'tpunanchored / tpua [player]', DESC = 'Teleports unanchored parts to a player'}
CMDs[#CMDs + 1] = {NAME = 'animsunanchored / freezeua', DESC = 'Freezes unanchored parts'}
CMDs[#CMDs + 1] = {NAME = 'thawunanchored / thawua / unfreezeua', DESC = 'Thaws unanchored parts'}
CMDs[#CMDs + 1] = {NAME = 'removeterrain / rterrain / noterrain', DESC = 'Removes all terrain'}
CMDs[#CMDs + 1] = {NAME = 'clearnilinstances / nonilinstances / cni', DESC = 'Removes nil instances'}
CMDs[#CMDs + 1] = {NAME = 'destroyheight / dh [num]', DESC = 'Sets FallenPartsDestroyHeight'}
CMDs[#CMDs + 1] = {NAME = 'fakeout', DESC = 'Tp to the void and then back (useful to kill people attached to you)'}
CMDs[#CMDs + 1] = {NAME = 'antivoid', DESC = 'Prevents you from falling into the void by launching you upwards'}
CMDs[#CMDs + 1] = {NAME = 'unantivoid / noantivoid', DESC = 'Disables antivoid'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'fullbright / fb (CLIENT)', DESC = 'Makes the map brighter / more visible'}
CMDs[#CMDs + 1] = {NAME = 'loopfullbright / loopfb (CLIENT)', DESC = 'Makes the map brighter / more visible but looped'}
CMDs[#CMDs + 1] = {NAME = 'unloopfullbright / unloopfb', DESC = 'Unloops fullbright'}
CMDs[#CMDs + 1] = {NAME = 'ambient [num] [num] [num] (CLIENT)', DESC = 'Changes ambient'}
CMDs[#CMDs + 1] = {NAME = 'day (CLIENT)', DESC = 'Changes the time to day for the client'}
CMDs[#CMDs + 1] = {NAME = 'night (CLIENT)', DESC = 'Changes the time to night for the client'}
CMDs[#CMDs + 1] = {NAME = 'nofog (CLIENT)', DESC = 'Removes fog'}
CMDs[#CMDs + 1] = {NAME = 'brightness [num] (CLIENT)', DESC = 'Changes the brightness lighting property'}
CMDs[#CMDs + 1] = {NAME = 'globalshadows / gshadows (CLIENT)', DESC = 'Enables global shadows'}
CMDs[#CMDs + 1] = {NAME = 'noglobalshadows / nogshadows (CLIENT)', DESC = 'Disables global shadows'}
CMDs[#CMDs + 1] = {NAME = 'restorelighting / rlighting', DESC = 'Restores Lighting properties'}
CMDs[#CMDs + 1] = {NAME = 'light [radius] [brightness] (CLIENT)', DESC = 'Gives your player dynamic light'}
CMDs[#CMDs + 1] = {NAME = 'nolight / unlight', DESC = 'Removes dynamic light from your player'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'inspect / examine [player]', DESC = 'Opens InspectMenu for a certain player'}
CMDs[#CMDs + 1] = {NAME = 'age [player]', DESC = 'Tells you the age of a player'}
CMDs[#CMDs + 1] = {NAME = 'chatage [player]', DESC = 'Chats the age of a player'}
CMDs[#CMDs + 1] = {NAME = 'joindate / jd [player]', DESC = 'Tells you the date the player joined Roblox'}
CMDs[#CMDs + 1] = {NAME = 'chatjoindate / cjd [player]', DESC = 'Chats the date the player joined Roblox'}
CMDs[#CMDs + 1] = {NAME = 'copyname / copyuser [player]', DESC = 'Copies a players full username to your clipboard'}
CMDs[#CMDs + 1] = {NAME = 'userid / id [player]', DESC = 'Notifies a players user ID'}
CMDs[#CMDs + 1] = {NAME = 'copyplaceid / placeid', DESC = 'Copies the current place id to your clipboard'}
CMDs[#CMDs + 1] = {NAME = 'copygameid / gameid', DESC = 'Copies the current game id to your clipboard'}
CMDs[#CMDs + 1] = {NAME = 'copyuserid / copyid [player]', DESC = 'Copies a players user ID to your clipboard'}
CMDs[#CMDs + 1] = {NAME = 'appearanceid / aid [player]', DESC = 'Notifies a players appearance ID'}
CMDs[#CMDs + 1] = {NAME = 'copyappearanceid / caid [player]', DESC = 'Copies a players appearance ID to your clipboard'}
CMDs[#CMDs + 1] = {NAME = 'bang [player] [speed]', DESC = 'owo'}
CMDs[#CMDs + 1] = {NAME = 'unbang', DESC = 'uwu'}
CMDs[#CMDs + 1] = {NAME = 'jerk', DESC = 'Makes you jork it'}
CMDs[#CMDs + 1] = {NAME = 'scare / spook [player]', DESC = 'Teleports in front of a player for half a second'}
CMDs[#CMDs + 1] = {NAME = 'carpet [player]', DESC = 'Be someones carpet'}
CMDs[#CMDs + 1] = {NAME = 'uncarpet', DESC = 'Undoes carpet'}
CMDs[#CMDs + 1] = {NAME = 'friend [player]', DESC = 'Sends a friend request to certain players'}
CMDs[#CMDs + 1] = {NAME = 'unfriend [player]', DESC = 'Unfriends certain players'}
CMDs[#CMDs + 1] = {NAME = 'headsit [player]', DESC = 'Sit on a players head'}
CMDs[#CMDs + 1] = {NAME = 'walkto / follow [player]', DESC = 'Follow a player'}
CMDs[#CMDs + 1] = {NAME = 'pathfindwalkto / pathfindfollow [player]', DESC = 'Follow a player using pathfinding'}
CMDs[#CMDs + 1] = {NAME = 'pathfindwalktowaypoint / pathfindwalktowp [waypoint]', DESC = 'Walk to a waypoint using pathfinding'}
CMDs[#CMDs + 1] = {NAME = 'unwalkto / unfollow', DESC = 'Stops following a player'}
CMDs[#CMDs + 1] = {NAME = 'orbit [player] [speed] [distance]', DESC = 'Makes your character orbit around a player with an optional speed and an optional distance'}
CMDs[#CMDs + 1] = {NAME = 'unorbit', DESC = 'Disables orbit'}
CMDs[#CMDs + 1] = {NAME = 'stareat / stare [player]', DESC = 'Stare / look at a player'}
CMDs[#CMDs + 1] = {NAME = 'unstareat / unstare [player]', DESC = 'Disables stareat'}
CMDs[#CMDs + 1] = {NAME = 'rolewatch [group id] [role name]', DESC = 'Notify if someone from a watched group joins the server'}
CMDs[#CMDs + 1] = {NAME = 'rolewatchstop / unrolewatch', DESC = 'Disable Rolewatch'}
CMDs[#CMDs + 1] = {NAME = 'rolewatchleave', DESC = 'Toggle if you should leave the game if someone from a watched group joins the server'}
CMDs[#CMDs + 1] = {NAME = 'staffwatch', DESC = 'Notify if a staff member of the game joins the server'}
CMDs[#CMDs + 1] = {NAME = 'unstaffwatch', DESC = 'Disable Staffwatch'}
CMDs[#CMDs + 1] = {NAME = 'findfriendgroups', DESC = 'Notifies you if any players are friends with each other'}
CMDs[#CMDs + 1] = {NAME = 'handlekill / hkill [player] [radius] (TOOL)', DESC = 'Kills a player using tool damage (YOU NEED A TOOL)'}
CMDs[#CMDs + 1] = {NAME = 'fling', DESC = 'Flings anyone you touch'}
CMDs[#CMDs + 1] = {NAME = 'unfling', DESC = 'Disables the fling command'}
CMDs[#CMDs + 1] = {NAME = 'flyfling [speed]', DESC = 'Basically the invisfling command but not invisible'}
CMDs[#CMDs + 1] = {NAME = 'unflyfling', DESC = 'Disables the flyfling command'}
CMDs[#CMDs + 1] = {NAME = 'walkfling', DESC = 'Basically fling but no spinning'}
CMDs[#CMDs + 1] = {NAME = 'unwalkfling / nowalkfling', DESC = 'Disables walkfling'}
CMDs[#CMDs + 1] = {NAME = 'invisfling', DESC = 'Enables invisible fling (the invis part is patched, try using the god command before using this)'}
CMDs[#CMDs + 1] = {NAME = 'antifling', DESC = 'Disables player collisions to prevent you from being flung'}
CMDs[#CMDs + 1] = {NAME = 'unantifling', DESC = 'Disables antifling'}
CMDs[#CMDs + 1] = {NAME = 'loopoof', DESC = 'Loops everyones character sounds (everyone can hear)'}
CMDs[#CMDs + 1] = {NAME = 'unloopoof', DESC = 'Stops the oof chaos'}
CMDs[#CMDs + 1] = {NAME = 'muteboombox [player]', DESC = 'Mutes someones boombox'}
CMDs[#CMDs + 1] = {NAME = 'unmuteboombox [player]', DESC = 'Unmutes someones boombox'}
CMDs[#CMDs + 1] = {NAME = 'hitboxes', DESC = 'Shows all rendered bounding boxes'}
CMDs[#CMDs + 1] = {NAME = 'unhitboxes', DESC = 'Stops showing all rendered bounding boxes'}
CMDs[#CMDs + 1] = {NAME = 'hitbox [player] [size] [transparency]', DESC = 'Expands the hitbox for players HumanoidRootPart (default is 1)'}
CMDs[#CMDs + 1] = {NAME = 'headsize [player] [size]', DESC = 'Expands the head size for players Head (default is 1)'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'reset', DESC = 'Resets your character normally'}
CMDs[#CMDs + 1] = {NAME = 'respawn', DESC = 'Respawns you'}
CMDs[#CMDs + 1] = {NAME = 'refresh / re', DESC = 'Respawns and brings you back to the same position'}
CMDs[#CMDs + 1] = {NAME = 'god', DESC = 'Makes your character difficult to kill in most games'}
CMDs[#CMDs + 1] = {NAME = 'invisible / invis', DESC = 'Makes you invisible to other players'}
CMDs[#CMDs + 1] = {NAME = 'visible / vis', DESC = 'Makes you visible to other players'}
CMDs[#CMDs + 1] = {NAME = 'toolinvisible / toolinvis / tinvis', DESC = 'Makes you invisible to other players and able to use tools'}
CMDs[#CMDs + 1] = {NAME = 'speed / ws / walkspeed [num]', DESC = 'Change your walkspeed (default is 16)'}
CMDs[#CMDs + 1] = {NAME = 'spoofspeed / spoofws [num]', DESC = 'Spoofs your WalkSpeed on the Client'}
CMDs[#CMDs + 1] = {NAME = 'loopspeed / loopws [num]', DESC = 'Loops your walkspeed'}
CMDs[#CMDs + 1] = {NAME = 'unloopspeed / unloopws', DESC = 'Turns off loopspeed'}
CMDs[#CMDs + 1] = {NAME = 'hipheight / hheight [num]', DESC = 'Adjusts hip height'}
CMDs[#CMDs + 1] = {NAME = 'jumppower / jpower / jp [num]', DESC = 'Change a players jump height (default is 50)'}
CMDs[#CMDs + 1] = {NAME = 'spoofjumppower / spoofjp [num]', DESC = 'Spoofs your JumpPower on the Client'}
CMDs[#CMDs + 1] = {NAME = 'loopjumppower / loopjp [num]', DESC = 'Loops your jump height'}
CMDs[#CMDs + 1] = {NAME = 'unloopjumppower / unloopjp', DESC = 'Turns off loopjumppower'}
CMDs[#CMDs + 1] = {NAME = 'maxslopeangle / msa [num]', DESC = 'Adjusts MaxSlopeAngle'}
CMDs[#CMDs + 1] = {NAME = 'gravity / grav [num] (CLIENT)', DESC = 'Change your gravity'}
CMDs[#CMDs + 1] = {NAME = 'sit', DESC = 'Makes your character sit'}
CMDs[#CMDs + 1] = {NAME = 'lay / laydown', DESC = 'Makes your character lay down'}
CMDs[#CMDs + 1] = {NAME = 'sitwalk', DESC = 'Makes your character sit while still being able to walk'}
CMDs[#CMDs + 1] = {NAME = 'nosit', DESC = 'Prevents your character from sitting'}
CMDs[#CMDs + 1] = {NAME = 'unnosit', DESC = 'Disables nosit'}
CMDs[#CMDs + 1] = {NAME = 'jump', DESC = 'Makes your character jump'}
CMDs[#CMDs + 1] = {NAME = 'infinitejump / infjump', DESC = 'Allows you to jump before hitting the ground'}
CMDs[#CMDs + 1] = {NAME = 'uninfinitejump / uninfjump', DESC = 'Disables infjump'}
CMDs[#CMDs + 1] = {NAME = 'flyjump', DESC = 'Allows you to hold space to fly up'}
CMDs[#CMDs + 1] = {NAME = 'unflyjump', DESC = 'Disables flyjump'}
CMDs[#CMDs + 1] = {NAME = 'autojump / ajump', DESC = 'Automatically jumps when you run into an object'}
CMDs[#CMDs + 1] = {NAME = 'unautojump / unajump', DESC = 'Disables autojump'}
CMDs[#CMDs + 1] = {NAME = 'edgejump / ejump', DESC = 'Automatically jumps when you get to the edge of an object'}
CMDs[#CMDs + 1] = {NAME = 'unedgejump / unejump', DESC = 'Disables edgejump'}
CMDs[#CMDs + 1] = {NAME = 'platformstand / stun', DESC = 'Enables PlatformStand'}
CMDs[#CMDs + 1] = {NAME = 'unplatformstand / unstun', DESC = 'Disables PlatformStand'}
CMDs[#CMDs + 1] = {NAME = 'norotate / noautorotate', DESC = 'Disables AutoRotate'}
CMDs[#CMDs + 1] = {NAME = 'unnorotate / autorotate', DESC = 'Enables AutoRotate'}
CMDs[#CMDs + 1] = {NAME = 'enablestate [StateType]', DESC = 'Enables a humanoid state type'}
CMDs[#CMDs + 1] = {NAME = 'disablestate [StateType]', DESC = 'Disables a humanoid state type'}
CMDs[#CMDs + 1] = {NAME = 'team [team name] (CLIENT)', DESC = 'Changes your team. Sometimes fools localscripts.'}
CMDs[#CMDs + 1] = {NAME = 'nobillboardgui / nobgui / noname', DESC = 'Removes billboard and surface GUIs from your players (i.e. name GUIs at cafes)'}
CMDs[#CMDs + 1] = {NAME = 'loopnobgui / loopnoname', DESC = 'Loop removes billboard and surface GUIs from your players (i.e. name GUIs at cafes)'}
CMDs[#CMDs + 1] = {NAME = 'unloopnobgui / unloopnoname', DESC = 'Disables loopnobgui'}
CMDs[#CMDs + 1] = {NAME = 'noarms', DESC = 'Removes your arms'}
CMDs[#CMDs + 1] = {NAME = 'nolegs', DESC = 'Removes your legs'}
CMDs[#CMDs + 1] = {NAME = 'nolimbs', DESC = 'Removes your limbs'}
CMDs[#CMDs + 1] = {NAME = 'naked (CLIENT)', DESC = 'Removes your clothing'}
CMDs[#CMDs + 1] = {NAME = 'noface / removeface', DESC = 'Removes your face'}
CMDs[#CMDs + 1] = {NAME = 'blockhead', DESC = 'Turns your head into a block'}
CMDs[#CMDs + 1] = {NAME = 'blockhats', DESC = 'Turns your hats into blocks'}
CMDs[#CMDs + 1] = {NAME = 'blocktool', DESC = 'Turns the currently selected tool into a block'}
CMDs[#CMDs + 1] = {NAME = 'creeper', DESC = 'Makes you look like a creeper'}
CMDs[#CMDs + 1] = {NAME = 'drophats', DESC = 'Drops your hats'}
CMDs[#CMDs + 1] = {NAME = 'nohats / deletehats / rhats', DESC = 'Deletes your hats'}
CMDs[#CMDs + 1] = {NAME = 'hatspin / spinhats', DESC = 'Spins your characters accessories'}
CMDs[#CMDs + 1] = {NAME = 'unhatspin / unspinhats', DESC = 'Undoes spinhats'}
CMDs[#CMDs + 1] = {NAME = 'clearhats / cleanhats', DESC = 'Clears hats in the workspace'}
CMDs[#CMDs + 1] = {NAME = 'chardelete / cd [instance name]', DESC = 'Removes any part with a certain name from your character'}
CMDs[#CMDs + 1] = {NAME = 'chardeleteclass / cdc [class name]', DESC = 'Removes any part with a certain classname from your character'}
CMDs[#CMDs + 1] = {NAME = 'deletevelocity / dv / removeforces', DESC = 'Removes any velocity / force instances in your character'}
CMDs[#CMDs + 1] = {NAME = 'weaken [num]', DESC = 'Makes your character less dense'}
CMDs[#CMDs + 1] = {NAME = 'unweaken', DESC = 'Sets your characters CustomPhysicalProperties to default'}
CMDs[#CMDs + 1] = {NAME = 'strengthen [num]', DESC = 'Makes your character more dense (CustomPhysicalProperties)'}
CMDs[#CMDs + 1] = {NAME = 'unstrengthen', DESC = 'Sets your characters CustomPhysicalProperties to default'}
CMDs[#CMDs + 1] = {NAME = 'breakvelocity', DESC = 'Sets your characters velocity to 0'}
CMDs[#CMDs + 1] = {NAME = 'spin [speed]', DESC = 'Spins your character'}
CMDs[#CMDs + 1] = {NAME = 'unspin', DESC = 'Disables spin'}
CMDs[#CMDs + 1] = {NAME = 'split', DESC = 'Splits your character in half'}
CMDs[#CMDs + 1] = {NAME = 'nilchar', DESC = 'Sets your characters parent to nil'}
CMDs[#CMDs + 1] = {NAME = 'unnilchar / nonilchar', DESC = 'Sets your characters parent to workspace'}
CMDs[#CMDs + 1] = {NAME = 'noroot / removeroot / rroot', DESC = 'Removes your characters HumanoidRootPart'}
CMDs[#CMDs + 1] = {NAME = 'replaceroot', DESC = 'Replaces your characters HumanoidRootPart'}
CMDs[#CMDs + 1] = {NAME = 'clearcharappearance / clearchar / clrchar', DESC = 'Removes all accessory, shirt, pants, charactermesh, and bodycolors'}
CMDs[#CMDs + 1] = {NAME = 'tpwalk / teleportwalk [num]', DESC = 'Teleports you to your move direction'}
CMDs[#CMDs + 1] = {NAME = 'untpwalk / unteleportwalk', DESC = 'Undoes tpwalk / teleportwalk'}
CMDs[#CMDs + 1] = {NAME = 'trip', DESC = 'Makes your character fall over'}
CMDs[#CMDs + 1] = {NAME = 'wallwalk / walkonwalls', DESC = 'Walk on walls'}
CMDs[#CMDs + 1] = {NAME = 'promptr6', DESC = 'Prompts the game to switch your rig type to R6'}
CMDs[#CMDs + 1] = {NAME = 'promptr15', DESC = 'Prompts the game to switch your rig type to R15'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'animation / anim [ID] [speed]', DESC = 'Makes your character perform an animation (must be an animation on the marketplace or by roblox/stickmasterluke to replicate)'}
CMDs[#CMDs + 1] = {NAME = 'emote / em [ID] [speed]', DESC = 'Makes your character perform an emote (must be on the marketplace or by roblox/stickmasterluke to replicate)'}
CMDs[#CMDs + 1] = {NAME = 'dance', DESC = 'Makes you  d a n c e'}
CMDs[#CMDs + 1] = {NAME = 'undance', DESC = 'Stops dance animations'}
CMDs[#CMDs + 1] = {NAME = 'spasm', DESC = 'Makes you  c r a z y'}
CMDs[#CMDs + 1] = {NAME = 'unspasm', DESC = 'Stops spasm'}
CMDs[#CMDs + 1] = {NAME = 'headthrow', DESC = 'Simply makes you throw your head'}
CMDs[#CMDs + 1] = {NAME = 'noanim', DESC = 'Disables your animations'}
CMDs[#CMDs + 1] = {NAME = 'reanim', DESC = 'Restores your animations'}
CMDs[#CMDs + 1] = {NAME = 'animspeed [num]', DESC = 'Changes the speed of your current animation'}
CMDs[#CMDs + 1] = {NAME = 'copyanimation / copyanim / copyemote [player]', DESC = 'Copies someone elses animation'}
CMDs[#CMDs + 1] = {NAME = 'copyanimationid / copyanimid / copyemoteid [player]', DESC = 'Copies your animation id or someone elses to your clipboard'}
CMDs[#CMDs + 1] = {NAME = 'loopanimation / loopanim', DESC = 'Loops your current animation'}
CMDs[#CMDs + 1] = {NAME = 'stopanimations / stopanims', DESC = 'Stops running animations'}
CMDs[#CMDs + 1] = {NAME = 'refreshanimations / refreshanims', DESC = 'Refreshes animations'}
CMDs[#CMDs + 1] = {NAME = 'allowcustomanim / allowcustomanimations', DESC = 'Lets you use custom animation packs instead'}
CMDs[#CMDs + 1] = {NAME = 'unallowcustomanim / unallowcustomanimations', DESC = 'Doesn\'t let you use custom animation packs instead'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'autoclick [click delay] [release delay]', DESC = 'Automatically clicks your mouse with a set delay'}
CMDs[#CMDs + 1] = {NAME = 'unautoclick / noautoclick', DESC = 'Turns off autoclick'}
CMDs[#CMDs + 1] = {NAME = 'autokeypress [key] [down delay] [up delay]', DESC = 'Automatically presses a key with a set delay'}
CMDs[#CMDs + 1] = {NAME = 'unautokeypress', DESC = 'Stops autokeypress'}
CMDs[#CMDs + 1] = {NAME = 'hovername', DESC = 'Shows a players username when your mouse is hovered over them'}
CMDs[#CMDs + 1] = {NAME = 'unhovername / nohovername', DESC = 'Turns off hovername'}
CMDs[#CMDs + 1] = {NAME = 'mousesensitivity / ms [0-10]', DESC = 'Sets your mouse sensitivity (affects first person and right click drag) (default is 1)'}
CMDs[#CMDs + 1] = {NAME = 'clickdelete', DESC = 'Go to Settings > Keybinds > Add for click delete'}
CMDs[#CMDs + 1] = {NAME = 'clickteleport', DESC = 'Go to Settings > Keybinds > Add for click teleport'}
CMDs[#CMDs + 1] = {NAME = 'mouseteleport / mousetp', DESC = 'Teleports your character to your mouse. This is recommended as a keybind'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'tools', DESC = 'Copies tools from ReplicatedStorage and Lighting'}
CMDs[#CMDs + 1] = {NAME = 'notools / removetools / deletetools', DESC = 'Removes tools from character and backpack'}
CMDs[#CMDs + 1] = {NAME = 'deleteselectedtool / dst', DESC = 'Removes any currently selected tools'}
CMDs[#CMDs + 1] = {NAME = 'grabtools', DESC = 'Automatically get tools that are dropped'}
CMDs[#CMDs + 1] = {NAME = 'ungrabtools / nograbtools', DESC = 'Disables grabtools'}
CMDs[#CMDs + 1] = {NAME = 'copytools [player] (CLIENT)', DESC = 'Copies a players tools'}
CMDs[#CMDs + 1] = {NAME = 'dupetools / clonetools [num]', DESC = 'Duplicates your inventory tools a set amount of times'}
CMDs[#CMDs + 1] = {NAME = 'droptools', DESC = 'Drops your tools'}
CMDs[#CMDs + 1] = {NAME = 'droppabletools', DESC = 'Makes your tools droppable'}
CMDs[#CMDs + 1] = {NAME = 'equiptools', DESC = 'Equips every tool in your inventory at once'}
CMDs[#CMDs + 1] = {NAME = 'unequiptools', DESC = 'Unequips every tool you are currently holding at once'}
CMDs[#CMDs + 1] = {NAME = 'removespecifictool [name]', DESC = 'Automatically remove a specific tool from your inventory'}
CMDs[#CMDs + 1] = {NAME = 'unremovespecifictool [name]', DESC = 'Stops removing a specific tool from your inventory'}
CMDs[#CMDs + 1] = {NAME = 'clearremovespecifictool', DESC = 'Stop removing all specific tools from your inventory'}
CMDs[#CMDs + 1] = {NAME = 'reach [num]', DESC = 'Increases the hitbox of your held tool'}
CMDs[#CMDs + 1] = {NAME = 'boxreach [num]', DESC = 'Increases the hitbox of your held tool in a box shape'}
CMDs[#CMDs + 1] = {NAME = 'unreach / noreach', DESC = 'Turns off reach'}
CMDs[#CMDs + 1] = {NAME = 'grippos [X Y Z]', DESC = 'Changes your current tools grip position'}
CMDs[#CMDs + 1] = {NAME = 'usetools [amount] [delay]', DESC = 'Activates all tools in your backpack at the same time'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'addalias [cmd] [alias]', DESC = 'Adds an alias to a command'}
CMDs[#CMDs + 1] = {NAME = 'removealias [alias]', DESC = 'Removes a custom alias'}
CMDs[#CMDs + 1] = {NAME = 'clraliases', DESC = 'Removes all custom aliases'}
CMDs[#CMDs + 1] = {NAME = '', DESC = ''}
CMDs[#CMDs + 1] = {NAME = 'addplugin / plugin [name]', DESC = 'Add a plugin via command'}
CMDs[#CMDs + 1] = {NAME = 'removeplugin / deleteplugin [name]', DESC = 'Remove a plugin via command'}
CMDs[#CMDs + 1] = {NAME = 'reloadplugin [name]', DESC = 'Reloads a plugin'}
CMDs[#CMDs + 1] = {NAME = 'addallplugins / loadallplugins', DESC = 'Adds all available plugins from the workspace folder'}
for i = 1, #CMDs do
    local clone = Example:Clone()
    clone.Parent = CMDsF
    clone.Visible = false
    clone.Text = CMDs[i].NAME
    clone.Name = 'CMD'
    table.insert(text1, clone)
    if CMDs[i].DESC == '' then
        continue
    end
    clone:SetAttribute('Title', CMDs[i].NAME)
    clone:SetAttribute('Desc', CMDs[i].DESC)
    clone.MouseButton1Down:Connect(function()
        if not IsOnMobile and clone.Visible and clone.TextTransparency == 0 then
            local text = Cmdbar.Text
            Cmdbar:CaptureFocus()
            autoComplete(clone.Text, text)
            maximizeHolder()
        end
    end)
end
IndexContents('', true)
checkTT = function()
    local v1
    local guiObjectsAtPosition = COREGUI:GetGuiObjectsAtPosition(IYMouse.X, IYMouse.Y)
    for _, v in pairs(guiObjectsAtPosition) do
        if v.Parent ~= CMDsF then
            continue
        end
        v1 = v
    end
    if v1 ~= nil and v1:GetAttribute('Title') ~= nil then
        local x = IYMouse.X
        local y = IYMouse.Y
        local xOffset
        local yOffset
        xOffset = if IYMouse.X > 200 then x - 201 else x + 21
        yOffset = if IYMouse.ViewSizeY - 96 < IYMouse.Y then y - 97 else y
        Tooltip.Position = UDim2.new(0, xOffset, 0, yOffset)
        Description.Text = v1:GetAttribute('Desc')
        if v1:GetAttribute('Title') ~= nil then
            Title_3.Text = v1:GetAttribute('Title')
        else
            Title_3.Text = ''
        end
        Tooltip.Visible = true
        return
    end
    Tooltip.Visible = false
end
FindInTable = function(map, arg2)
    if map == nil then
        return false
    end
    for _, v in pairs(map) do
        if v ~= arg2 then
            continue
        end
        return true
    end
    return false
end
GetInTable = function(list, arg2)
    for i = 1, #list do
        if list[i] ~= arg2 then
            continue
        end
        return i
    end
    return false
end
respawn = function(player)
    if invisRunning then
        TurnVisible()
    end
    local character = player.Character
    local humanoid2 = character:FindFirstChildWhichIsA('Humanoid')
    local fallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight
    local _ = workspace.CurrentCamera.CameraType
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    workspace.FallenPartsDestroyHeight = 0 / 0
    getRoot(character).Position = Vector3.yAxis * fallenPartsDestroyHeight
    task.wait(player:GetNetworkPing())
    workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight
    repeat
        task.wait()
    until not character.Parent or not humanoid2.Parent or humanoid2 and humanoid2.Health <= 0
    if humanoid2 then
        humanoid2:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
    end
end
local flag5 = false
refresh = function(player)
    flag5 = true
    local root = getRoot(player.Character)
    local cframe = root.CFrame
    local cframe2 = workspace.CurrentCamera.CFrame
    respawn(player)
    task.spawn(function()
        local parent = player.CharacterAdded:Wait()
        local humanoid2 = parent:FindFirstChildOfClass('Humanoid')
        while not humanoid2 do
            wait()
            humanoid2 = parent:FindFirstChildOfClass('Humanoid')
        end
        local rootPart = humanoid2.RootPart
        local cframe3 = cframe
        local cframe4 = task.wait() and cframe2
        rootPart.CFrame = cframe3
        workspace.CurrentCamera.CFrame = cframe4
        flag5 = false
    end)
end
local cframe
onDied = function()
    task.spawn(function()
        if pcall(function()
            Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        end) and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
            Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
                if getRoot(Players.LocalPlayer.Character) then
                    cframe = getRoot(Players.LocalPlayer.Character).CFrame
                end
            end)
            return
        end
        wait(2)
        onDied()
    end)
end
Clip = true
spDelay = 0.1
Players.LocalPlayer.CharacterAdded:Connect(function()
    NOFLY()
    floating = false
    if not Clip then
        execCmd('clip')
    end
    repeat
        wait()
    until getRoot(Players.LocalPlayer.Character)
    pcall(function()
        if spawnpoint and not flag5 and spawnpos ~= nil then
            wait(spDelay)
            getRoot(Players.LocalPlayer.Character).CFrame = spawnpos
        end
    end)
    onDied()
end)
onDied()
local data2 = {truthy = {['true'] = true, t = true, ['1'] = true, yes = true, y = true, on = true, enable = true, enabled = true}, falsy = {['false'] = true, f = true, ['0'] = true, no = true, n = true, off = true, disable = true, disabled = true}}
parseBoolean = function(value, arg2)
    value = tostring(value):lower()
    if data2.truthy[value] then
        return true
    end
    if data2.falsy[value] then
        return false
    end
    return arg2 or false
end
getstring = function(arg1, arg2)
    return table.concat(arg2 or cargs, ' ', arg1)
end
findCmd = function(text)
    for _, cmd in pairs(cmds) do
        if cmd.NAME:lower() ~= text:lower() and not FindInTable(cmd.ALIAS, text:lower()) then
            continue
        end
        return cmd
    end
    return customAlias[text:lower()]
end
splitString = function(text, text3)
    local list = {}
    if text3 == nil then
        text3 = ','
    end
    for match in string.gmatch(text, '[^' .. text3 .. ']+') do
        table.insert(list, match)
    end
    return list
end
cmdHistory = {}
local map = {}
local num5 = 0
local num6 = 0
execCmd = function(text, arg2, arg3)
    text = text:gsub('%s+$', '')
    task.spawn(function()
        local text3 = text
        text = string.gsub(text, '\\\\', '%%BackSlash%%')
        local map2 = splitString(text, '\\')
        for _, v in pairs(map2) do
            v = string.gsub(v, '%%BackSlash%%', '\\')
            local v1, v2, number = v:find('^(%d+)%^')
            local seconds = 0
            local flag = false
            if number then
                v = v:sub(v2 + 1)
                local v3, v4, text4 = v:find('^([%d%.]+)%^')
                if text4 then
                    v = v:sub(v4 + 1)
                    seconds = tonumber(text4) or 0
                end
            else
                local v5, v6 = v:find('^inf%^')
                if v5 then
                    flag = true
                    v = v:sub(v6 + 1)
                    local v7, v8, text5 = v:find('^([%d%.]+)%^')
                    if text5 then
                        v = v:sub(v8 + 1)
                        text5 = tonumber(text5) or 1
                        seconds = text5 > 0 and text5 or 1
                    else
                        seconds = 1
                    end
                end
            end
            number = tonumber(number or 1)
            if v:sub(1, 1) == '!' then
                local list = splitString(v:sub(2), ' ')
                if list[1] and map[list[1]] then
                    v = map[list[1]]
                end
            end
            local list2 = splitString(v, ' ')
            local first = list2[1]
            local cmd = findCmd(first)
            if not cmd then
                continue
            end
            table.remove(list2, 1)
            cargs = list2
            if not arg2 then
                arg2 = Players.LocalPlayer
            end
            if arg3 then
                if arg2 == Players.LocalPlayer and cmdHistory[1] ~= text3 and text3:sub(1, 11) ~= 'lastcommand' and text3:sub(1, 7) ~= 'lastcmd' then
                    table.insert(cmdHistory, 1, text3)
                end
                if #cmdHistory > 30 then
                    table.remove(cmdHistory)
                end
                map[first] = v
            end
            local now = tick()
            if flag then
                while true do
                    if num6 >= now then
                        break
                    end
                    local success, result = pcall(cmd.FUNC, list2, arg2)
                    if not success and _G.IY_DEBUG then
                        warn('Command Error:', first, result)
                    end
                    wait(seconds)
                end
            else
                for _ = 1, number do
                    if now < num6 then
                        break
                    end
                    local success2, result2 = pcall(cmd.FUNC, list2, arg2)
                    if not success2 and _G.IY_DEBUG then
                        warn('Command Error:', first, result2)
                        notify('Command Error: ' .. first, 'Check console')
                    end
                    if success2 and type(result2) == 'string' and not table.find(list2, 'nonotify') then
                        notify('Command: ' .. first, result2)
                    end
                    if seconds == 0 then
                        continue
                    end
                    wait(seconds)
                end
            end
        end
    end)
end
addcmd = function(name, arg2, func, plugin)
    cmds[#cmds + 1] = {NAME = name, ALIAS = arg2 or {}, FUNC = func, PLUGIN = plugin}
end
removecmd = function(text)
    if text ~= ' ' then
        for i = #cmds, 1, -1 do
            if cmds[i].NAME ~= text and not FindInTable(cmds[i].ALIAS, text) then
                continue
            end
            table.remove(cmds, i)
            for _, child in pairs(CMDsF:GetChildren()) do
                if not string.find(child.Text, '^' .. text .. '$') and not string.find(child.Text, '^' .. text .. ' ') and not string.find(child.Text, ' ' .. text .. '$') and not string.find(child.Text, ' ' .. text .. ' ') then
                    continue
                end
                child.TextTransparency = 0.7
                child.MouseButton1Click:Connect(function()
                    notify(child.Text, 'Command has been disabled by you or a plugin')
                end)
            end
        end
    end
end
overridecmd = function(arg1, func)
    local cmd = findCmd(arg1)
    if cmd and cmd.FUNC then
        cmd.FUNC = func
    end
end
addbind = function(command, key, iskeyup, toggle)
    if toggle then
        binds[#binds + 1] = {COMMAND = command, KEY = key, ISKEYUP = iskeyup, TOGGLE = toggle}
        return
    end
    binds[#binds + 1] = {COMMAND = command, KEY = key, ISKEYUP = iskeyup}
end
addcmdtext = function(text, text3, value)
    local clone = Example:Clone()
    local text4 = tostring(text)
    local text5 = tostring(value)
    clone.Parent = CMDsF
    clone.Visible = false
    clone.Text = text
    clone.Name = 'PLUGIN_' .. text3
    table.insert(text1, clone)
    if value and value ~= '' then
        clone:SetAttribute('Title', text4)
        clone:SetAttribute('Desc', text5)
        clone.MouseButton1Down:Connect(function()
            if clone.Visible and clone.TextTransparency == 0 then
                Cmdbar:CaptureFocus()
                autoComplete(clone.Text)
                maximizeHolder()
            end
        end)
    end
end
local function compute(arg1)
    local result = workspace.CurrentCamera:WorldToScreenPoint(arg1.Position)
    return Vector2.new(result.X, result.Y)
end
local function compute2()
    return Vector2.new(IYMouse.X, IYMouse.Y)
end
local function processChildren()
    local v1
    local huge = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChildOfClass('Humanoid') then
            for _, child in pairs(player.Character:GetChildren()) do
                if not string.find(child.Name, 'Torso') then
                    continue
                end
                local magnitude = (compute(child) - compute2()).Magnitude
                if magnitude < huge then
                    huge = magnitude
                    v1 = player
                end
            end
        end
    end
    return v1
end
SpecialPlayerCases = {all = function(arg1)
    return Players:GetPlayers()
end, others = function(arg1)
    local list = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player == arg1 then
            continue
        end
        table.insert(list, player)
    end
    return list
end, me = function(arg1)
    return {arg1}
end, ['#(%d+)'] = function(arg1, list, list2)
    local list3 = {}
    local number = tonumber(list[1])
    local list4 = {unpack(list2)}
    for _ = 1, number do
        if #list4 == 0 then
            break
        end
        local randomValue = math.random(1, #list4)
        table.insert(list3, list4[randomValue])
        table.remove(list4, randomValue)
    end
    return list3
end, random = function(arg1, arg2, arg3)
    local players = Players:GetPlayers()
    local localPlayer = Players.LocalPlayer
    table.remove(players, table.find(players, localPlayer))
    return {players[math.random(1, #players)]}
end, ['%%(.+)'] = function(arg1, list)
    local list2 = {}
    local first = list[1]
    for _, player in pairs(Players:GetPlayers()) do
        if player.Team and string.sub(string.lower(player.Team.Name), 1, #first) == string.lower(first) then
            table.insert(list2, player)
        end
    end
    return list2
end, allies = function(player)
    local list = {}
    local team = player.Team
    for _, player2 in pairs(Players:GetPlayers()) do
        if player2.Team ~= team then
            continue
        end
        table.insert(list, player2)
    end
    return list
end, enemies = function(player)
    local list = {}
    local team = player.Team
    for _, player2 in pairs(Players:GetPlayers()) do
        if player2.Team == team then
            continue
        end
        table.insert(list, player2)
    end
    return list
end, team = function(player)
    local list = {}
    local team = player.Team
    for _, player2 in pairs(Players:GetPlayers()) do
        if player2.Team ~= team then
            continue
        end
        table.insert(list, player2)
    end
    return list
end, nonteam = function(player)
    local list = {}
    local team = player.Team
    for _, player2 in pairs(Players:GetPlayers()) do
        if player2.Team == team then
            continue
        end
        table.insert(list, player2)
    end
    return list
end, friends = function(player, arg2)
    local list = {}
    for _, player2 in pairs(Players:GetPlayers()) do
        if player2:IsFriendsWith(player.UserId) and player2 ~= player then
            table.insert(list, player2)
        end
    end
    return list
end, nonfriends = function(player, arg2)
    local list = {}
    for _, player2 in pairs(Players:GetPlayers()) do
        if not player2:IsFriendsWith(player.UserId) and player2 ~= player then
            table.insert(list, player2)
        end
    end
    return list
end, guests = function(arg1, arg2)
    local list = {}
    for _, player in pairs(Players:GetPlayers()) do
        if not player.Guest then
            continue
        end
        table.insert(list, player)
    end
    return list
end, bacons = function(arg1, arg2)
    local list = {}
    for _, player in pairs(Players:GetPlayers()) do
        if not player.Character:FindFirstChild('Pal Hair') and not player.Character:FindFirstChild('Kate Hair') then
            continue
        end
        table.insert(list, player)
    end
    return list
end, ['age(%d+)'] = function(arg1, list)
    local list2 = {}
    local number = tonumber(list[1])
    if not number == nil then
        return
    end
    for _, player in pairs(Players:GetPlayers()) do
        if player.AccountAge <= number then
            table.insert(list2, player)
        end
    end
    return list2
end, nearest = function(player, arg2, map)
    local character = player.Character
    if not character or not getRoot(character) then
        return
    end
    local huge = math.huge
    local list
    for _, v in pairs(map) do
        if v ~= player and v.Character then
            local result = v:DistanceFromCharacter(getRoot(character).Position)
            if result < huge then
                huge = result
                list = {v}
            end
        end
    end
    return list
end, farthest = function(player, arg2, map)
    local character = player.Character
    if not character or not getRoot(character) then
        return
    end
    local result = 0
    local list
    for _, v in pairs(map) do
        if v ~= player and v.Character then
            local result2 = v:DistanceFromCharacter(getRoot(character).Position)
            if result < result2 then
                result = result2
                list = {v}
            end
        end
    end
    return list
end, ['group(%d+)'] = function(arg1, list)
    local list2 = {}
    local number = tonumber(list[1])
    for _, player in pairs(Players:GetPlayers()) do
        if not player:IsInGroup(number) then
            continue
        end
        table.insert(list2, player)
    end
    return list2
end, alive = function(arg1, arg2)
    local list = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').Health > 0 then
            table.insert(list, player)
        end
    end
    return list
end, dead = function(arg1, arg2)
    local list = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').Health > 0 then
            continue
        end
        table.insert(list, player)
    end
    return list
end, ['rad(%d+)'] = function(player, list)
    local list2 = {}
    local number = tonumber(list[1])
    local character = player.Character
    if not character or not getRoot(character) then
        return
    end
    for _, player2 in pairs(Players:GetPlayers()) do
        if player2.Character and getRoot(player2.Character) then
            local magnitude = (getRoot(player2.Character).Position - getRoot(character).Position).magnitude
            if magnitude <= number then
                table.insert(list2, player2)
            end
        end
    end
    return list2
end, cursor = function(arg1)
    local list = {}
    local item = processChildren()
    if item ~= nil then
        table.insert(list, item)
    end
    return list
end, npcs = function(arg1, arg2)
    local list = {}
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA('Model') and getRoot(descendant) and descendant:FindFirstChildWhichIsA('Humanoid') and Players:GetPlayerFromCharacter(descendant) == nil then
            local player = Instance.new('Player')
            player.Name = descendant.Name .. ' - ' .. descendant:FindFirstChildWhichIsA('Humanoid').DisplayName
            player.Character = descendant
            table.insert(list, player)
        end
    end
    return list
end}
toTokens = function(text)
    local list = {}
    for match, match2 in string.gmatch(text, '([+-])([^+-]+)') do
        table.insert(list, {Operator = match, Name = match2})
    end
    return list
end
onlyIncludeInTable = function(map, map2)
    local set = {}
    local list = {}
    for _, v in pairs(map2) do
        set[v.Name] = true
    end
    for _, v in pairs(map) do
        if not set[v.Name] then
            continue
        end
        table.insert(list, v)
    end
    return list
end
removeTableMatches = function(map, map2)
    local set = {}
    local list = {}
    for _, v in pairs(map2) do
        set[v.Name] = true
    end
    for _, v in pairs(map) do
        if set[v.Name] then
            continue
        end
        table.insert(list, v)
    end
    return list
end
getPlayersByName = function(text)
    local lowered, length, list = string.lower(text), #text, {}
    for _, player in pairs(Players:GetPlayers()) do
        if lowered:sub(0, 1) == '@' then
            if string.sub(string.lower(player.Name), 1, length - 1) ~= lowered:sub(2) then
                continue
            end
            table.insert(list, player)
        elseif string.sub(string.lower(player.Name), 1, length) == lowered or string.sub(string.lower(player.DisplayName), 1, length) == lowered then
            table.insert(list, player)
        end
    end
    return list
end
getPlayer = function(arg1, instance)
    if arg1 == nil then
        return {instance.Name}
    end
    local map = splitString(arg1, ',')
    local list = {}
    for _, v in pairs(map) do
        if string.sub(v, 1, 1) ~= '+' and string.sub(v, 1, 1) ~= '-' then
            v = '+' .. v
        end
        local tokens = toTokens(v)
        local players = Players:GetPlayers()
        for _, token in pairs(tokens) do
            if token.Operator == '+' then
                local name = token.Name
                local flag = false
                for k3, specialPlayerCas in pairs(SpecialPlayerCases) do
                    local list2 = {string.match(name, '^' .. k3 .. '$')}
                    if #list2 > 0 then
                        flag = true
                        players = onlyIncludeInTable(players, specialPlayerCas(instance, list2, players))
                    end
                end
                if flag then
                    continue
                end
                players = onlyIncludeInTable(players, getPlayersByName(name))
            else
                local name2 = token.Name
                local flag2 = false
                for k4, specialPlayerCas in pairs(SpecialPlayerCases) do
                    local list3 = {string.match(name2, '^' .. k4 .. '$')}
                    if #list3 > 0 then
                        flag2 = true
                        players = removeTableMatches(players, specialPlayerCas(instance, list3, players))
                    end
                end
                if flag2 then
                    continue
                end
                players = removeTableMatches(players, getPlayersByName(name2))
            end
        end
        for _, player in pairs(players) do
            table.insert(list, player)
        end
    end
    local list4 = {}
    for _, v in pairs(list) do
        table.insert(list4, v.Name)
    end
    return list4
end
formatUsername = function(player)
    if player.DisplayName ~= player.Name then
        return string.format('%s (%s)', player.Name, player.DisplayName)
    end
    return player.Name
end
getprfx = function(text)
    if text:sub(1, string.len(prefix)) == prefix then
        return {'cmd', string.len(prefix) + 1}
    end
end
do_exec = function(text, arg2)
    text = text:gsub('/e ', '')
    local list = getprfx(text)
    if not list then
        return
    end
    text = text:sub(list[2])
    if list[1] == 'cmd' then
        execCmd(text, arg2, true)
        IndexContents('', true, false, true)
        CMDsF.CanvasPosition = vector2
    end
end
lastTextBoxString, lastTextBoxCon, lastEnteredString = nil, nil, nil
UserInputService.TextBoxFocused:Connect(function(instance)
    if lastTextBoxCon then
        lastTextBoxCon:Disconnect()
    end
    if instance == Cmdbar then
        lastTextBoxString = nil
        return
    end
    lastTextBoxString = instance.Text
    lastTextBoxCon = instance:GetPropertyChangedSignal('Text'):Connect(function()
        if not UserInputService:IsKeyDown(Enum.KeyCode.Return) and not UserInputService:IsKeyDown(Enum.KeyCode.KeypadEnter) then
            lastTextBoxString = instance.Text
        end
    end)
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        if Cmdbar and Cmdbar:IsFocused() then
            if input.KeyCode == Enum.KeyCode.Up then
                num5 = num5 + 1
                if num5 > #cmdHistory then
                    num5 = #cmdHistory
                end
                Cmdbar.Text = cmdHistory[num5] or ''
                Cmdbar.CursorPosition = 1020
                return
            end
            if input.KeyCode == Enum.KeyCode.Down then
                num5 = num5 - 1
                if num5 < 0 then
                    num5 = 0
                end
                Cmdbar.Text = cmdHistory[num5] or ''
                Cmdbar.CursorPosition = 1020
            end
        elseif input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter then
            lastEnteredString = lastTextBoxString
        end
    end
end)
Players.LocalPlayer.Chatted:Connect(function()
    wait()
    if lastEnteredString then
        local lastEnteredString2 = lastEnteredString
        lastEnteredString = nil
        do_exec(lastEnteredString2, Players.LocalPlayer)
    end
end)
Cmdbar.PlaceholderText = 'Command Bar (' .. prefix .. ')'
Cmdbar:GetPropertyChangedSignal('Text'):Connect(function()
    if Cmdbar:IsFocused() then
        IndexContents(Cmdbar.Text, true, true)
    end
end)
local connection3
tabAllowed = true
Cmdbar.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local result = Cmdbar.Text:gsub('^' .. prefix, '')
        execCmd(result, Players.LocalPlayer, true)
    end
    if connection3 then
        connection3:Disconnect()
    end
    wait()
    if not Cmdbar:IsFocused() then
        Cmdbar.Text = ''
        IndexContents('', true, false, true)
        if flag2 == true then
            wait(0.2)
            Settings:TweenPosition(UDim2.new(0, 0, 0, 45), 'InOut', 'Quart', 0.2, true, nil)
            CMDsF.Visible = false
        end
    end
    CMDsF.CanvasPosition = vector2
end)
Cmdbar.Focused:Connect(function()
    num5 = 0
    vector2 = CMDsF.CanvasPosition
    if flag2 == true then
        wait(0.2)
        CMDsF.Visible = true
        Settings:TweenPosition(UDim2.new(0, 0, 0, 220), 'InOut', 'Quart', 0.2, true, nil)
    end
    connection3 = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if Cmdbar:IsFocused() then
            if tabAllowed == true and input.KeyCode == Enum.KeyCode.Tab and v4 ~= nil then
                autoComplete(v4)
            end
        else
            connection3:Disconnect()
        end
    end)
end)
ESPenabled = false
CHMSenabled = false
round = function(number, arg2)
    local v1 = 10 ^ (arg2 or 0)
    return math.floor(number * v1 + 0.5) / v1
end
ESP = function(instance, arg2)
    task.spawn(function()
        for _, child in pairs(COREGUI:GetChildren()) do
            if child.Name ~= instance.Name .. '_ESP' then
                continue
            end
            child:Destroy()
        end
        wait()
        if instance.Character and instance.Name ~= Players.LocalPlayer.Name and not COREGUI:FindFirstChild(instance.Name .. '_ESP') then
            local folder = Instance.new('Folder')
            folder.Name = instance.Name .. '_ESP'
            folder.Parent = COREGUI
            repeat
                wait(1)
            until instance.Character and getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid')
            for _, child in pairs(instance.Character:GetChildren()) do
                if not child:IsA('BasePart') then
                    continue
                end
                local boxHandleAdornment = Instance.new('BoxHandleAdornment')
                boxHandleAdornment.Name = instance.Name
                boxHandleAdornment.Parent = folder
                boxHandleAdornment.Adornee = child
                boxHandleAdornment.AlwaysOnTop = true
                boxHandleAdornment.ZIndex = 10
                boxHandleAdornment.Size = child.Size
                boxHandleAdornment.Transparency = espTransparency
                if arg2 == true then
                    boxHandleAdornment.Color = BrickColor.new(instance.TeamColor == Players.LocalPlayer.TeamColor and 'Bright green' or 'Bright red')
                else
                    boxHandleAdornment.Color = instance.TeamColor
                end
            end
            if instance.Character and instance.Character:FindFirstChild('Head') then
                local billboardGui = Instance.new('BillboardGui')
                local textLabel = Instance.new('TextLabel')
                billboardGui.Adornee = instance.Character.Head
                billboardGui.Name = instance.Name
                billboardGui.Parent = folder
                billboardGui.Size = UDim2.new(0, 100, 0, 150)
                billboardGui.StudsOffset = Vector3.new(0, 1, 0)
                billboardGui.AlwaysOnTop = true
                textLabel.Parent = billboardGui
                textLabel.BackgroundTransparency = 1
                textLabel.Position = UDim2.new(0, 0, 0, -50)
                textLabel.Size = UDim2.new(0, 100, 0, 100)
                textLabel.Font = Enum.Font.SourceSansSemibold
                textLabel.TextSize = 20
                textLabel.TextColor3 = Color3.new(1, 1, 1)
                textLabel.TextStrokeTransparency = 0
                textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
                textLabel.Text = 'Name: ' .. instance.Name
                textLabel.ZIndex = 10
                local connection
                local connection2
                local connection3
                connection3 = instance.CharacterAdded:Connect(function()
                    if ESPenabled then
                        connection:Disconnect()
                        connection2:Disconnect()
                        folder:Destroy()
                        repeat
                            wait(1)
                        until getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid')
                        ESP(instance, arg2)
                        connection3:Disconnect()
                        return
                    end
                    connection2:Disconnect()
                    connection3:Disconnect()
                end)
                connection2 = instance:GetPropertyChangedSignal('TeamColor'):Connect(function()
                    if ESPenabled then
                        connection:Disconnect()
                        connection3:Disconnect()
                        folder:Destroy()
                        repeat
                            wait(1)
                        until getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid')
                        ESP(instance, arg2)
                        connection2:Disconnect()
                        return
                    end
                    connection2:Disconnect()
                end)
                local function espLoop()
                    if COREGUI:FindFirstChild(instance.Name .. '_ESP') then
                        if instance.Character and getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid') and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                            local floored = math.floor((getRoot(Players.LocalPlayer.Character).Position - getRoot(instance.Character).Position).magnitude)
                            textLabel.Text = 'Name: ' .. instance.Name .. ' | Health: ' .. round(instance.Character:FindFirstChildOfClass('Humanoid').Health, 1) .. ' | Studs: ' .. floored
                        end
                    else
                        connection2:Disconnect()
                        connection3:Disconnect()
                        connection:Disconnect()
                    end
                end
                connection = RunService.RenderStepped:Connect(espLoop)
            end
        end
    end)
end
CHMS = function(instance)
    task.spawn(function()
        for _, child in pairs(COREGUI:GetChildren()) do
            if child.Name ~= instance.Name .. '_CHMS' then
                continue
            end
            child:Destroy()
        end
        wait()
        if instance.Character and instance.Name ~= Players.LocalPlayer.Name and not COREGUI:FindFirstChild(instance.Name .. '_CHMS') then
            local folder = Instance.new('Folder')
            folder.Name = instance.Name .. '_CHMS'
            folder.Parent = COREGUI
            repeat
                wait(1)
            until instance.Character and getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid')
            for _, child in pairs(instance.Character:GetChildren()) do
                if not child:IsA('BasePart') then
                    continue
                end
                local boxHandleAdornment = Instance.new('BoxHandleAdornment')
                boxHandleAdornment.Name = instance.Name
                boxHandleAdornment.Parent = folder
                boxHandleAdornment.Adornee = child
                boxHandleAdornment.AlwaysOnTop = true
                boxHandleAdornment.ZIndex = 10
                boxHandleAdornment.Size = child.Size
                boxHandleAdornment.Transparency = espTransparency
                boxHandleAdornment.Color = instance.TeamColor
            end
            local connection
            local connection2
            local connection3
            connection = instance.CharacterAdded:Connect(function()
                if CHMSenabled then
                    folder:Destroy()
                    connection2:Disconnect()
                    repeat
                        wait(1)
                    until getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid')
                    CHMS(instance)
                    connection:Disconnect()
                    return
                end
                connection2:Disconnect()
                connection:Disconnect()
            end)
            connection2 = instance:GetPropertyChangedSignal('TeamColor'):Connect(function()
                if CHMSenabled then
                    folder:Destroy()
                    connection:Disconnect()
                    repeat
                        wait(1)
                    until getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid')
                    CHMS(instance)
                    connection2:Disconnect()
                    return
                end
                connection2:Disconnect()
            end)
            connection3 = folder.AncestryChanged:Connect(function()
                connection2:Disconnect()
                connection:Disconnect()
                connection3:Disconnect()
            end)
        end
    end)
end
Locate = function(instance)
    task.spawn(function()
        for _, child in pairs(COREGUI:GetChildren()) do
            if child.Name ~= instance.Name .. '_LC' then
                continue
            end
            child:Destroy()
        end
        wait()
        if instance.Character and instance.Name ~= Players.LocalPlayer.Name and not COREGUI:FindFirstChild(instance.Name .. '_LC') then
            local folder = Instance.new('Folder')
            folder.Name = instance.Name .. '_LC'
            folder.Parent = COREGUI
            repeat
                wait(1)
            until instance.Character and getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid')
            for _, child in pairs(instance.Character:GetChildren()) do
                if not child:IsA('BasePart') then
                    continue
                end
                local boxHandleAdornment = Instance.new('BoxHandleAdornment')
                boxHandleAdornment.Name = instance.Name
                boxHandleAdornment.Parent = folder
                boxHandleAdornment.Adornee = child
                boxHandleAdornment.AlwaysOnTop = true
                boxHandleAdornment.ZIndex = 10
                boxHandleAdornment.Size = child.Size
                boxHandleAdornment.Transparency = espTransparency
                boxHandleAdornment.Color = instance.TeamColor
            end
            if instance.Character and instance.Character:FindFirstChild('Head') then
                local billboardGui = Instance.new('BillboardGui')
                local textLabel = Instance.new('TextLabel')
                billboardGui.Adornee = instance.Character.Head
                billboardGui.Name = instance.Name
                billboardGui.Parent = folder
                billboardGui.Size = UDim2.new(0, 100, 0, 150)
                billboardGui.StudsOffset = Vector3.new(0, 1, 0)
                billboardGui.AlwaysOnTop = true
                textLabel.Parent = billboardGui
                textLabel.BackgroundTransparency = 1
                textLabel.Position = UDim2.new(0, 0, 0, -50)
                textLabel.Size = UDim2.new(0, 100, 0, 100)
                textLabel.Font = Enum.Font.SourceSansSemibold
                textLabel.TextSize = 20
                textLabel.TextColor3 = Color3.new(1, 1, 1)
                textLabel.TextStrokeTransparency = 0
                textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
                textLabel.Text = 'Name: ' .. instance.Name
                textLabel.ZIndex = 10
                local connection
                local connection2
                local connection3
                connection2 = instance.CharacterAdded:Connect(function()
                    if folder ~= nil and folder.Parent ~= nil then
                        connection:Disconnect()
                        connection3:Disconnect()
                        folder:Destroy()
                        repeat
                            wait(1)
                        until getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid')
                        Locate(instance)
                        connection2:Disconnect()
                        return
                    end
                    connection3:Disconnect()
                    connection2:Disconnect()
                end)
                connection3 = instance:GetPropertyChangedSignal('TeamColor'):Connect(function()
                    if folder ~= nil and folder.Parent ~= nil then
                        connection:Disconnect()
                        connection2:Disconnect()
                        folder:Destroy()
                        repeat
                            wait(1)
                        until getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid')
                        Locate(instance)
                        connection3:Disconnect()
                        return
                    end
                    connection3:Disconnect()
                end)
                local function lcLoop()
                    if COREGUI:FindFirstChild(instance.Name .. '_LC') then
                        if instance.Character and getRoot(instance.Character) and instance.Character:FindFirstChildOfClass('Humanoid') and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                            local floored = math.floor((getRoot(Players.LocalPlayer.Character).Position - getRoot(instance.Character).Position).magnitude)
                            textLabel.Text = 'Name: ' .. instance.Name .. ' | Health: ' .. round(instance.Character:FindFirstChildOfClass('Humanoid').Health, 1) .. ' | Studs: ' .. floored
                        end
                    else
                        connection3:Disconnect()
                        connection2:Disconnect()
                        connection:Disconnect()
                    end
                end
                connection = RunService.RenderStepped:Connect(lcLoop)
            end
        end
    end)
end
local KeybindEditor2, flag6 = KeybindEditor, false
local flag7 = false
refreshbinds = function()
    if Holder_2 then
        Holder_2:ClearAllChildren()
        Holder_2.CanvasSize = UDim2.new(0, 0, 0, 10)
        for i = 1, #binds do
            local v1 = i * 25 - 25
            local clone = Example_2:Clone()
            clone.Parent = Holder_2
            clone.Visible = true
            clone.Position = UDim2.new(0, 0, 0, v1 + 5)
            table.insert(shade2, clone)
            table.insert(shade2, clone.Text)
            table.insert(text1, clone.Text)
            table.insert(shade3, clone.Text.Delete)
            table.insert(text2, clone.Text.Delete)
            local text = tostring(binds[i].KEY)
            local v2
            v2 = if text == 'RightClick' or text == 'LeftClick' then text else text:sub(14)
            if binds[i].TOGGLE then
                clone.Text.Text = v2 .. ' > ' .. binds[i].COMMAND .. ' / ' .. binds[i].TOGGLE
            else
                clone.Text.Text = v2 .. ' > ' .. binds[i].COMMAND .. '  ' .. (binds[i].ISKEYUP and '(keyup)' or '(keydown)')
            end
            Holder_2.CanvasSize = UDim2.new(0, 0, 0, v1 + 30)
            clone.Text.Delete.MouseButton1Click:Connect(function()
                unkeybind(binds[i].COMMAND, binds[i].KEY)
            end)
        end
    end
end
refreshbinds()
toggleOn = {}
unkeybind = function(text, text3)
    for i = #binds, 1, -1 do
        if binds[i].COMMAND == text and binds[i].KEY == text3 then
            toggleOn[binds[i]] = nil
            table.remove(binds, i)
        end
    end
    refreshbinds()
    updatesaves()
    if text3 == 'RightClick' or text3 == 'LeftClick' then
        notify('Keybinds Updated', 'Unbinded ' .. text3 .. ' from ' .. text)
        return
    end
    notify('Keybinds Updated', 'Unbinded ' .. text3:sub(14) .. ' from ' .. text)
end
PositionsFrame.Delete.MouseButton1Click:Connect(function()
    execCmd('cpos')
end)
refreshwaypoints = function()
    if #WayPoints > 0 or #pWayPoints > 0 then
        PositionsHint:Destroy()
    end
    if Holder_4 then
        Holder_4:ClearAllChildren()
        Holder_4.CanvasSize = UDim2.new(0, 0, 0, 10)
        local count = 1
        for i = 1, #WayPoints do
            local v1 = count * 25 - 25
            local clone = Example_4:Clone()
            clone.Parent = Holder_4
            clone.Visible = true
            clone.Position = UDim2.new(0, 0, 0, v1 + 5)
            clone.Text.Text = WayPoints[i].NAME
            table.insert(shade2, clone)
            table.insert(shade2, clone.Text)
            table.insert(text1, clone.Text)
            table.insert(shade3, clone.Text.Delete)
            table.insert(text2, clone.Text.Delete)
            table.insert(shade3, clone.Text.TP)
            table.insert(text2, clone.Text.TP)
            Holder_4.CanvasSize = UDim2.new(0, 0, 0, v1 + 30)
            clone.Text.Delete.MouseButton1Click:Connect(function()
                execCmd('dpos ' .. WayPoints[i].NAME)
            end)
            clone.Text.TP.MouseButton1Click:Connect(function()
                execCmd('loadpos ' .. WayPoints[i].NAME)
            end)
            count += 1
        end
        for i = 1, #pWayPoints do
            local v2 = count * 25 - 25
            local clone2 = Example_4:Clone()
            clone2.Parent = Holder_4
            clone2.Visible = true
            clone2.Position = UDim2.new(0, 0, 0, v2 + 5)
            clone2.Text.Text = pWayPoints[i].NAME
            table.insert(shade2, clone2)
            table.insert(shade2, clone2.Text)
            table.insert(text1, clone2.Text)
            table.insert(shade3, clone2.Text.Delete)
            table.insert(text2, clone2.Text.Delete)
            table.insert(shade3, clone2.Text.TP)
            table.insert(text2, clone2.Text.TP)
            Holder_4.CanvasSize = UDim2.new(0, 0, 0, v2 + 30)
            clone2.Text.Delete.MouseButton1Click:Connect(function()
                execCmd('dpos ' .. pWayPoints[i].NAME)
            end)
            clone2.Text.TP.MouseButton1Click:Connect(function()
                execCmd('loadpos ' .. pWayPoints[i].NAME)
            end)
            count += 1
        end
    end
end
refreshwaypoints()
refreshaliases = function()
    if #aliases > 0 then
        AliasHint:Destroy()
    end
    if Holder_3 then
        Holder_3:ClearAllChildren()
        Holder_3.CanvasSize = UDim2.new(0, 0, 0, 10)
        for i = 1, #aliases do
            local v1 = i * 25 - 25
            local clone = Example_3:Clone()
            clone.Parent = Holder_3
            clone.Visible = true
            clone.Position = UDim2.new(0, 0, 0, v1 + 5)
            clone.Text.Text = aliases[i].CMD .. ' > ' .. aliases[i].ALIAS
            table.insert(shade2, clone)
            table.insert(shade2, clone.Text)
            table.insert(text1, clone.Text)
            table.insert(shade3, clone.Text.Delete)
            table.insert(text2, clone.Text.Delete)
            Holder_3.CanvasSize = UDim2.new(0, 0, 0, v1 + 30)
            clone.Text.Delete.MouseButton1Click:Connect(function()
                execCmd('removealias ' .. aliases[i].ALIAS)
            end)
        end
    end
end
local flag8 = false
BindTo.MouseButton1Click:Connect(function()
    flag6 = true
    BindTo.Text = 'Press something'
end)
BindTriggerSelect.MouseButton1Click:Connect(function()
    flag8 = not flag8
    BindTriggerSelect.Text = flag8 and 'KeyUp' or 'KeyDown'
end)
newToggle = false
Cmdbar_3.Parent.Visible = false
On_2.MouseButton1Click:Connect(function()
    if newToggle == false then
        newToggle = true
        On_2.BackgroundTransparency = 0
        Cmdbar_3.Parent.Visible = true
        BindTriggerSelect.Visible = false
        return
    end
    newToggle = false
    On_2.BackgroundTransparency = 1
    Cmdbar_3.Parent.Visible = false
    BindTriggerSelect.Visible = true
end)
Add_2.MouseButton1Click:Connect(function()
    if flag7 then
        if string.find(Cmdbar_2.Text, '\\\\') or string.find(Cmdbar_3.Text, '\\\\') then
            notify('Keybind Error', 'Only use one backslash to keybind multiple commands into one keybind or command')
            return
        end
        if newToggle and Cmdbar_3.Text ~= '' and Cmdbar_2.text ~= '' then
            addbind(Cmdbar_2.Text, keyPressed, false, Cmdbar_3.Text)
        elseif not newToggle and Cmdbar_2.text ~= '' then
            addbind(Cmdbar_2.Text, keyPressed, flag8)
        else
            return
        end
        refreshbinds()
        updatesaves()
        if keyPressed == 'RightClick' or keyPressed == 'LeftClick' then
            notify('Keybinds Updated', 'Binded ' .. keyPressed .. ' to ' .. Cmdbar_2.Text .. (newToggle and ' / ' .. Cmdbar_3.Text or ''))
            return
        end
        notify('Keybinds Updated', 'Binded ' .. keyPressed:sub(14) .. ' to ' .. Cmdbar_2.Text .. (newToggle and ' / ' .. Cmdbar_3.Text or ''))
    end
end)
Exit_2.MouseButton1Click:Connect(function()
    Cmdbar_2.Text = 'Command'
    Cmdbar_3.Text = 'Command 2'
    BindTo.Text = 'Click to bind'
    flag8 = false
    BindTriggerSelect.Text = 'KeyDown'
    flag7 = false
    KeybindEditor:TweenPosition(UDim2.new(0.5, -180, 0, -500), 'InOut', 'Quart', 0.5, true, nil)
end)
onInputBegan = function(arg1, arg2)
    if flag6 then
        if arg1.UserInputType == Enum.UserInputType.Keyboard then
            keyPressed = tostring(arg1.KeyCode)
            BindTo.Text = keyPressed:sub(14)
        elseif arg1.UserInputType == Enum.UserInputType.MouseButton1 then
            keyPressed = 'LeftClick'
            BindTo.Text = 'LeftClick'
        elseif arg1.UserInputType == Enum.UserInputType.MouseButton2 then
            keyPressed = 'RightClick'
            BindTo.Text = 'RightClick'
        end
        flag6 = false
        flag7 = true
    end
    if not arg2 and #binds > 0 then
        for _, bind in pairs(binds) do
            if not bind.ISKEYUP and (arg1.UserInputType == Enum.UserInputType.Keyboard and bind.KEY:lower() == tostring(arg1.KeyCode):lower() or arg1.UserInputType == Enum.UserInputType.MouseButton1 and bind.KEY:lower() == 'leftclick' or arg1.UserInputType == Enum.UserInputType.MouseButton2 and bind.KEY:lower() == 'rightclick') then
                if bind.TOGGLE then
                    local v1 = toggleOn[bind] == true
                    toggleOn[bind] = not v1
                    if v1 then
                        execCmd(bind.TOGGLE, Players.LocalPlayer)
                    else
                        execCmd(bind.COMMAND, Players.LocalPlayer)
                    end
                else
                    execCmd(bind.COMMAND, Players.LocalPlayer)
                end
            end
        end
    end
end
onInputEnded = function(arg1, arg2)
    if not arg2 and #binds > 0 then
        for _, bind in pairs(binds) do
            if bind.ISKEYUP and (arg1.UserInputType == Enum.UserInputType.Keyboard and bind.KEY:lower() == tostring(arg1.KeyCode):lower() or arg1.UserInputType == Enum.UserInputType.MouseButton1 and bind.KEY:lower() == 'leftclick' or arg1.UserInputType == Enum.UserInputType.MouseButton2 and bind.KEY:lower() == 'rightclick') then
                execCmd(bind.COMMAND, Players.LocalPlayer)
            end
        end
    end
end
UserInputService.InputBegan:Connect(onInputBegan)
UserInputService.InputEnded:Connect(onInputEnded)
ClickTP.Select.MouseButton1Click:Connect(function()
    if flag7 then
        addbind('clicktp', keyPressed, flag8)
        refreshbinds()
        updatesaves()
        if keyPressed == 'RightClick' or keyPressed == 'LeftClick' then
            notify('Keybinds Updated', 'Binded ' .. keyPressed .. ' to click tp')
            return
        end
        notify('Keybinds Updated', 'Binded ' .. keyPressed:sub(14) .. ' to click tp')
    end
end)
ClickDelete.Select.MouseButton1Click:Connect(function()
    if flag7 then
        addbind('clickdel', keyPressed, flag8)
        refreshbinds()
        updatesaves()
        if keyPressed == 'RightClick' or keyPressed == 'LeftClick' then
            notify('Keybinds Updated', 'Binded ' .. keyPressed .. ' to click delete')
            return
        end
        notify('Keybinds Updated', 'Binded ' .. keyPressed:sub(14) .. ' to click delete')
    end
end)
local function clicktpFunc()
    pcall(function()
        local character = Players.LocalPlayer.Character
        local humanoid2 = character:FindFirstChildOfClass('Humanoid')
        if humanoid2 and humanoid2.SeatPart then
            humanoid2.Sit = false
            wait(0.1)
        end
        local v1 = humanoid2 and humanoid2.HipHeight > 0 and humanoid2.HipHeight + 1
        local root = getRoot(character)
        local position = root.Position
        local position2 = IYMouse.Hit.Position
        local v2 = CFrame.new(position2, Vector3.new(position.X, position2.Y, position.Z)) * CFrame.Angles(0, math.pi, 0)
        root.CFrame = v2 + Vector3.new(0, v1 or 4, 0)
        breakVelocity()
    end)
end
IYMouse.Button1Down:Connect(function()
    for _, bind in pairs(binds) do
        if bind.COMMAND == 'clicktp' then
            local key = bind.KEY
            if key == 'RightClick' and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) and Players.LocalPlayer.Character then
                clicktpFunc()
            elseif key == 'LeftClick' and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) and Players.LocalPlayer.Character then
                clicktpFunc()
            else
                if not UserInputService:IsKeyDown(Enum.KeyCode[key:sub(14)]) then
                    continue
                end
                if not Players.LocalPlayer.Character then
                    continue
                end
                clicktpFunc()
            end
        elseif bind.COMMAND == 'clickdel' then
            local key2 = bind.KEY
            if key2 == 'RightClick' and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                pcall(function()
                    IYMouse.Target:Destroy()
                end)
            elseif key2 == 'LeftClick' and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                pcall(function()
                    IYMouse.Target:Destroy()
                end)
            elseif UserInputService:IsKeyDown(Enum.KeyCode[key2:sub(14)]) then
                pcall(function()
                    IYMouse.Target:Destroy()
                end)
            end
        end
    end
end)
PluginsGUI = PluginEditor.background
addPlugin = function(text)
    if text:lower() == 'plugin file name' or text:lower() == 'iy_fe.iy' or text == 'iy_fe' then
        notify('Plugin Error', 'Please enter a valid plugin')
        return
    end
    local v1
    local item
    if text:sub(-3) == '.iy' then
        pcall(function()
            v1 = readfile(text)
        end)
        item = text
    else
        pcall(function()
            v1 = readfile(text .. '.iy')
        end)
        item = text .. '.iy'
    end
    if v1 then
        if not FindInTable(PluginsTable, item) then
            table.insert(PluginsTable, item)
            LoadPlugin(item)
            refreshplugins()
            pcall(eventEditor.Refresh)
        else
            notify('Plugin Error', 'This plugin is already added')
        end
    else
        notify('Plugin Error', 'Cannot locate file "' .. item .. '". Is the file in the correct folder?')
    end
end
deletePlugin = function(text)
    local text3 = text .. '.iy'
    if text:sub(-3) == '.iy' then
        text3 = text
    end
    for i = #cmds, 1, -1 do
        if cmds[i].PLUGIN ~= text3 then
            continue
        end
        table.remove(cmds, i)
    end
    for _, child in pairs(CMDsF:GetChildren()) do
        if child.Name ~= 'PLUGIN_' .. text3 then
            continue
        end
        child:Destroy()
    end
    for k, plugins in pairs(PluginsTable) do
        if plugins ~= text3 then
            continue
        end
        table.remove(PluginsTable, k)
        notify('Removed Plugin', text3 .. ' was removed')
    end
    IndexContents('', true)
    refreshplugins()
end
refreshplugins = function(arg1)
    if #PluginsTable > 0 then
        PluginsHint:Destroy()
    end
    if Holder_5 then
        Holder_5:ClearAllChildren()
        Holder_5.CanvasSize = UDim2.new(0, 0, 0, 10)
        for k, plugins in pairs(PluginsTable) do
            local v1 = k * 25 - 25
            local clone = Example_5:Clone()
            clone.Parent = Holder_5
            clone.Visible = true
            clone.Position = UDim2.new(0, 0, 0, v1 + 5)
            clone.Text.Text = plugins
            table.insert(shade2, clone)
            table.insert(shade2, clone.Text)
            table.insert(text1, clone.Text)
            table.insert(shade3, clone.Text.Delete)
            table.insert(text2, clone.Text.Delete)
            Holder_5.CanvasSize = UDim2.new(0, 0, 0, v1 + 30)
            clone.Text.Delete.MouseButton1Click:Connect(function()
                deletePlugin(plugins)
            end)
        end
        if not arg1 then
            updatesaves()
        end
    end
end
LoadPlugin = function(arg1, arg2)
    local v1
    CatchedPluginLoad = function()
        v1 = loadfile(arg1)()
    end
    handlePluginError = function(value)
        notify('Plugin Error', 'An error occurred with the plugin, "' .. arg1 .. '" and it could not be loaded')
        if FindInTable(PluginsTable, arg1) then
            for k, plugins in pairs(PluginsTable) do
                if plugins ~= arg1 then
                    continue
                end
                table.remove(PluginsTable, k)
            end
        end
        updatesaves()
        print('Original Error: ' .. tostring(value))
        print('Plugin Error, stack traceback: ' .. tostring(debug.traceback()))
        v1 = nil
        return false
    end
    xpcall(CatchedPluginLoad, handlePluginError)
    if v1 ~= nil then
        if not arg2 then
            notify('Loaded Plugin', 'Name: ' .. v1.PluginName .. '\n' .. 'Description: ' .. v1.PluginDescription)
        end
        addcmdtext('', arg1)
        addcmdtext(string.upper('--' .. v1.PluginName), arg1, v1.PluginDescription)
        if v1.Commands then
            for k, command in pairs(v1.Commands) do
                local text = ''
                local v2 = k
                local function handleNames()
                    v2 = k
                    if findCmd(v2 .. text) then
                        if isNumber(text) then
                            text = text + 1
                        else
                            text = 1
                        end
                        handleNames()
                        return
                    end
                    v2 ..= text
                end
                handleNames()
                addcmd(v2, command.Aliases, command.Function, arg1)
                if command.ListName then
                    local listName = command.ListName
                    local map = {k, unpack(command.Aliases)}
                    for _, v in pairs(map) do
                        listName = listName:gsub(v, v .. text)
                    end
                    addcmdtext(listName, arg1, command.Description)
                else
                    addcmdtext(v2, arg1, command.Description)
                end
            end
        end
        IndexContents('', true)
    elseif v1 == nil then
        v1 = nil
    end
end
FindPlugins = function()
    if PluginsTable ~= nil and type(PluginsTable) == 'table' then
        for _, plugins in pairs(PluginsTable) do
            LoadPlugin(plugins, true)
        end
        refreshplugins(true)
    end
end
AddPlugin.MouseButton1Click:Connect(function()
    addPlugin(PluginsGUI.FileName.Text)
end)
Exit_3.MouseButton1Click:Connect(function()
    PluginEditor:TweenPosition(UDim2.new(0.5, -180, 0, -500), 'InOut', 'Quart', 0.5, true, nil)
    FileName.Text = 'Plugin File Name'
end)
Add_3.MouseButton1Click:Connect(function()
    PluginEditor:TweenPosition(UDim2.new(0.5, -180, 0, 310), 'InOut', 'Quart', 0.5, true, nil)
end)
Plugins.MouseButton1Click:Connect(function()
    if writefileExploit() then
        PluginsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), 'InOut', 'Quart', 0.5, true, nil)
        wait(0.5)
        SettingsHolder.Visible = false
        return
    end
    notify('Incompatible Exploit', 'Your exploit is unable to use plugins (missing read/writefile)')
end)
Close_4.MouseButton1Click:Connect(function()
    SettingsHolder.Visible = true
    PluginsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), 'InOut', 'Quart', 0.5, true, nil)
end)
local flag9 = false
Players.LocalPlayer.OnTeleport:Connect(function(arg1)
    if KeepInfYield and not flag9 and queueteleport then
        flag9 = true
        queueteleport('loadstring(game:HttpGet(\'https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source\'))()')
    end
end)
addcmd('addalias', {}, function(list, arg2)
    if #list < 2 then
        return
    end
    local lowered = string.lower(list[1])
    local lowered2 = string.lower(list[2])
    for _, cmd in pairs(cmds) do
        if cmd.NAME:lower() ~= lowered and not FindInTable(cmd.ALIAS, lowered) then
            continue
        end
        customAlias[lowered2] = cmd
        aliases[#aliases + 1] = {CMD = lowered, ALIAS = lowered2}
        notify('Aliases Modified', 'Added ' .. lowered2 .. ' as an alias to ' .. lowered)
        updatesaves()
        refreshaliases()
        return
    end
end)
addcmd('removealias', {}, function(list, arg2)
    if #list < 1 then
        return
    end
    local lowered = string.lower(list[1])
    if customAlias[lowered] then
        local name = customAlias[lowered].NAME
        customAlias[lowered] = nil
        for i = #aliases, 1, -1 do
            if aliases[i].ALIAS ~= tostring(lowered) then
                continue
            end
            table.remove(aliases, i)
        end
        notify('Aliases Modified', 'Removed the alias ' .. lowered .. ' from ' .. name)
        updatesaves()
        refreshaliases()
    end
end)
addcmd('clraliases', {}, function(arg1, arg2)
    customAlias = {}
    aliases = {}
    notify('Aliases Modified', 'Removed all aliases')
    updatesaves()
    refreshaliases()
end)
addcmd('discord', {'support', 'help'}, function(arg1, arg2)
    if everyClipboard then
        toClipboard('https://discord.com/invite/78ZuWSq')
        notify('Discord Invite', 'Copied to clipboard!\ndiscord.gg/78ZuWSq')
    else
        notify('Discord Invite', 'discord.gg/78ZuWSq')
    end
    if httprequest then
        httprequest({Url = 'http://127.0.0.1:6463/rpc?v=1', Method = 'POST', Headers = {['Content-Type'] = 'application/json', Origin = 'https://discord.com'}, Body = HttpService:JSONEncode({cmd = 'INVITE_BROWSER', nonce = HttpService:GenerateGUID(false), args = {code = '78ZuWSq'}})})
    end
end)
addcmd('keepiy', {}, function(arg1, arg2)
    if queueteleport then
        KeepInfYield = true
        notify('KeepIY', 'Infinite Yield will now run after you teleport')
        updatesaves()
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing queue_on_teleport)')
end)
addcmd('unkeepiy', {}, function(arg1, arg2)
    if queueteleport then
        KeepInfYield = false
        notify('KeepIY', 'Infinite Yield will no longer run after you teleport')
        updatesaves()
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing queue_on_teleport)')
end)
addcmd('togglekeepiy', {}, function(arg1, arg2)
    if queueteleport then
        KeepInfYield = not KeepInfYield
        updatesaves()
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing queue_on_teleport)')
end)
local flag10 = true
addcmd('serverinfo', {'info', 'sinfo'}, function(arg1, player)
    if not flag10 then
        return
    end
    flag10 = false
    task.spawn(function()
        local frame = Instance.new('Frame')
        local frame2 = Instance.new('Frame')
        local textLabel = Instance.new('TextLabel')
        local textButton = Instance.new('TextButton')
        local imageLabel = Instance.new('ImageLabel')
        local frame3 = Instance.new('Frame')
        local textLabel2 = Instance.new('TextLabel')
        local textLabel3 = Instance.new('TextLabel')
        local textLabel4 = Instance.new('TextLabel')
        local textLabel5 = Instance.new('TextLabel')
        local textLabel6 = Instance.new('TextLabel')
        local textLabel7 = Instance.new('TextLabel')
        local textLabel8 = Instance.new('TextLabel')
        local textLabel9 = Instance.new('TextLabel')
        local textLabel10 = Instance.new('TextLabel')
        local textLabel11 = Instance.new('TextLabel')
        local textButton2 = Instance.new('TextButton')
        local textButton3 = Instance.new('TextButton')
        local textButton4 = Instance.new('TextButton')
        local textButton5 = Instance.new('TextButton')
        frame.Name = randomString()
        frame.Parent = ScaledHolder
        frame.Active = true
        frame.BackgroundTransparency = 1
        frame.Position = UDim2.new(0.5, -130, 0, -500)
        frame.Size = UDim2.new(0, 250, 0, 20)
        frame.ZIndex = 10
        dragGUI(frame)
        frame2.Name = 'shadow'
        frame2.Parent = frame
        frame2.BackgroundColor3 = currentShade2
        frame2.BorderSizePixel = 0
        frame2.Size = UDim2.new(0, 250, 0, 20)
        frame2.ZIndex = 10
        table.insert(shade2, frame2)
        textLabel.Name = 'PopupText'
        textLabel.Parent = frame2
        textLabel.BackgroundTransparency = 1
        textLabel.Size = UDim2.new(1, 0, 0.95, 0)
        textLabel.ZIndex = 10
        textLabel.Font = Enum.Font.SourceSans
        textLabel.TextSize = 14
        textLabel.Text = 'Server'
        textLabel.TextColor3 = currentText1
        textLabel.TextWrapped = true
        table.insert(text1, textLabel)
        textButton.Name = 'Exit'
        textButton.Parent = frame2
        textButton.BackgroundTransparency = 1
        textButton.Position = UDim2.new(1, -20, 0, 0)
        textButton.Size = UDim2.new(0, 20, 0, 20)
        textButton.Text = ''
        textButton.ZIndex = 10
        imageLabel.Parent = textButton
        imageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
        imageLabel.BackgroundTransparency = 1
        imageLabel.Position = UDim2.new(0, 5, 0, 5)
        imageLabel.Size = UDim2.new(0, 10, 0, 10)
        imageLabel.Image = getcustomasset2('infiniteyield/assets/close.png')
        imageLabel.ZIndex = 10
        frame3.Name = 'background'
        frame3.Parent = frame
        frame3.Active = true
        frame3.BackgroundColor3 = currentShade1
        frame3.BorderSizePixel = 0
        frame3.Position = UDim2.new(0, 0, 1, 0)
        frame3.Size = UDim2.new(0, 250, 0, 250)
        frame3.ZIndex = 10
        table.insert(shade1, frame3)
        textLabel2.Name = 'Text Label'
        textLabel2.Parent = frame3
        textLabel2.BackgroundTransparency = 1
        textLabel2.BorderSizePixel = 0
        textLabel2.Position = UDim2.new(0, 5, 0, 80)
        textLabel2.Size = UDim2.new(0, 100, 0, 20)
        textLabel2.ZIndex = 10
        textLabel2.Font = Enum.Font.SourceSansLight
        textLabel2.TextSize = 20
        textLabel2.Text = 'Run Time:'
        textLabel2.TextColor3 = currentText1
        textLabel2.TextXAlignment = Enum.TextXAlignment.Left
        table.insert(text1, textLabel2)
        textLabel3.Name = 'Text Label2'
        textLabel3.Parent = frame3
        textLabel3.BackgroundTransparency = 1
        textLabel3.BorderSizePixel = 0
        textLabel3.Position = UDim2.new(0, 5, 0, 130)
        textLabel3.Size = UDim2.new(0, 100, 0, 20)
        textLabel3.ZIndex = 10
        textLabel3.Font = Enum.Font.SourceSansLight
        textLabel3.TextSize = 20
        textLabel3.Text = 'Statistics:'
        textLabel3.TextColor3 = currentText1
        textLabel3.TextXAlignment = Enum.TextXAlignment.Left
        table.insert(text1, textLabel3)
        textLabel4.Name = 'Text Label3'
        textLabel4.Parent = frame3
        textLabel4.BackgroundTransparency = 1
        textLabel4.BorderSizePixel = 0
        textLabel4.Position = UDim2.new(0, 5, 0, 10)
        textLabel4.Size = UDim2.new(0, 100, 0, 20)
        textLabel4.ZIndex = 10
        textLabel4.Font = Enum.Font.SourceSansLight
        textLabel4.TextSize = 20
        textLabel4.Text = 'Local Player:'
        textLabel4.TextColor3 = currentText1
        textLabel4.TextXAlignment = Enum.TextXAlignment.Left
        table.insert(text1, textLabel4)
        textLabel5.Name = 'Time'
        textLabel5.Parent = frame3
        textLabel5.BackgroundTransparency = 1
        textLabel5.BorderSizePixel = 0
        textLabel5.Position = UDim2.new(0, 5, 0, 105)
        textLabel5.Size = UDim2.new(0, 100, 0, 20)
        textLabel5.ZIndex = 10
        textLabel5.Font = Enum.Font.SourceSans
        textLabel5.FontSize = Enum.FontSize.Size14
        textLabel5.Text = 'LOADING'
        textLabel5.TextColor3 = currentText1
        textLabel5.TextXAlignment = Enum.TextXAlignment.Left
        table.insert(text1, textLabel5)
        textLabel6.Name = 'appearance'
        textLabel6.Parent = frame3
        textLabel6.BackgroundTransparency = 1
        textLabel6.BorderSizePixel = 0
        textLabel6.Position = UDim2.new(0, 5, 0, 55)
        textLabel6.Size = UDim2.new(0, 100, 0, 20)
        textLabel6.ZIndex = 10
        textLabel6.Font = Enum.Font.SourceSans
        textLabel6.FontSize = Enum.FontSize.Size14
        textLabel6.Text = 'Appearance: LOADING'
        textLabel6.TextColor3 = currentText1
        textLabel6.TextXAlignment = Enum.TextXAlignment.Left
        table.insert(text1, textLabel6)
        textLabel7.Name = 'maxplayers'
        textLabel7.Parent = frame3
        textLabel7.BackgroundTransparency = 1
        textLabel7.BorderSizePixel = 0
        textLabel7.Position = UDim2.new(0, 5, 0, 175)
        textLabel7.Size = UDim2.new(0, 100, 0, 20)
        textLabel7.ZIndex = 10
        textLabel7.Font = Enum.Font.SourceSans
        textLabel7.FontSize = Enum.FontSize.Size14
        textLabel7.Text = 'LOADING'
        textLabel7.TextColor3 = currentText1
        textLabel7.TextXAlignment = Enum.TextXAlignment.Left
        table.insert(text1, textLabel7)
        textLabel8.Name = 'name'
        textLabel8.Parent = frame3
        textLabel8.BackgroundTransparency = 1
        textLabel8.BorderSizePixel = 0
        textLabel8.Position = UDim2.new(0, 5, 0, 215)
        textLabel8.Size = UDim2.new(0, 240, 0, 30)
        textLabel8.ZIndex = 10
        textLabel8.Font = Enum.Font.SourceSans
        textLabel8.FontSize = Enum.FontSize.Size14
        textLabel8.Text = 'Place Name: LOADING'
        textLabel8.TextColor3 = currentText1
        textLabel8.TextWrapped = true
        textLabel8.TextXAlignment = Enum.TextXAlignment.Left
        textLabel8.TextYAlignment = Enum.TextYAlignment.Top
        table.insert(text1, textLabel8)
        textLabel9.Name = 'placeid'
        textLabel9.Parent = frame3
        textLabel9.BackgroundTransparency = 1
        textLabel9.BorderSizePixel = 0
        textLabel9.Position = UDim2.new(0, 5, 0, 195)
        textLabel9.Size = UDim2.new(0, 100, 0, 20)
        textLabel9.ZIndex = 10
        textLabel9.Font = Enum.Font.SourceSans
        textLabel9.FontSize = Enum.FontSize.Size14
        textLabel9.Text = 'Place ID: LOADING'
        textLabel9.TextColor3 = currentText1
        textLabel9.TextXAlignment = Enum.TextXAlignment.Left
        table.insert(text1, textLabel9)
        textLabel10.Name = 'playerid'
        textLabel10.Parent = frame3
        textLabel10.BackgroundTransparency = 1
        textLabel10.BorderSizePixel = 0
        textLabel10.Position = UDim2.new(0, 5, 0, 35)
        textLabel10.Size = UDim2.new(0, 100, 0, 20)
        textLabel10.ZIndex = 10
        textLabel10.Font = Enum.Font.SourceSans
        textLabel10.FontSize = Enum.FontSize.Size14
        textLabel10.Text = 'Player ID: LOADING'
        textLabel10.TextColor3 = currentText1
        textLabel10.TextXAlignment = Enum.TextXAlignment.Left
        table.insert(text1, textLabel10)
        textLabel11.Name = 'players'
        textLabel11.Parent = frame3
        textLabel11.BackgroundTransparency = 1
        textLabel11.BorderSizePixel = 0
        textLabel11.Position = UDim2.new(0, 5, 0, 155)
        textLabel11.Size = UDim2.new(0, 100, 0, 20)
        textLabel11.ZIndex = 10
        textLabel11.Font = Enum.Font.SourceSans
        textLabel11.FontSize = Enum.FontSize.Size14
        textLabel11.Text = 'LOADING'
        textLabel11.TextColor3 = currentText1
        textLabel11.TextXAlignment = Enum.TextXAlignment.Left
        table.insert(text1, textLabel11)
        textButton2.Name = 'CopyApp'
        textButton2.Parent = frame3
        textButton2.BackgroundColor3 = currentShade2
        textButton2.BorderSizePixel = 0
        textButton2.Position = UDim2.new(0, 210, 0, 55)
        textButton2.Size = UDim2.new(0, 35, 0, 20)
        textButton2.Font = Enum.Font.SourceSans
        textButton2.TextSize = 14
        textButton2.Text = 'Copy'
        textButton2.TextColor3 = currentText1
        textButton2.ZIndex = 10
        table.insert(shade2, textButton2)
        table.insert(text1, textButton2)
        textButton3.Name = 'CopyPlrID'
        textButton3.Parent = frame3
        textButton3.BackgroundColor3 = currentShade2
        textButton3.BorderSizePixel = 0
        textButton3.Position = UDim2.new(0, 210, 0, 35)
        textButton3.Size = UDim2.new(0, 35, 0, 20)
        textButton3.Font = Enum.Font.SourceSans
        textButton3.TextSize = 14
        textButton3.Text = 'Copy'
        textButton3.TextColor3 = currentText1
        textButton3.ZIndex = 10
        table.insert(shade2, textButton3)
        table.insert(text1, textButton3)
        textButton4.Name = 'CopyPlcID'
        textButton4.Parent = frame3
        textButton4.BackgroundColor3 = currentShade2
        textButton4.BorderSizePixel = 0
        textButton4.Position = UDim2.new(0, 210, 0, 195)
        textButton4.Size = UDim2.new(0, 35, 0, 20)
        textButton4.Font = Enum.Font.SourceSans
        textButton4.TextSize = 14
        textButton4.Text = 'Copy'
        textButton4.TextColor3 = currentText1
        textButton4.ZIndex = 10
        table.insert(shade2, textButton4)
        table.insert(text1, textButton4)
        textButton5.Name = 'CopyPlcName'
        textButton5.Parent = frame3
        textButton5.BackgroundColor3 = currentShade2
        textButton5.BorderSizePixel = 0
        textButton5.Position = UDim2.new(0, 210, 0, 215)
        textButton5.Size = UDim2.new(0, 35, 0, 20)
        textButton5.Font = Enum.Font.SourceSans
        textButton5.TextSize = 14
        textButton5.Text = 'Copy'
        textButton5.TextColor3 = currentText1
        textButton5.ZIndex = 10
        table.insert(shade2, textButton5)
        table.insert(text1, textButton5)
        frame:TweenPosition(UDim2.new(0.5, -130, 0, 100), 'InOut', 'Quart', 0.5, true, nil)
        wait(0.5)
        textButton.MouseButton1Click:Connect(function()
            frame:TweenPosition(UDim2.new(0.5, -130, 0, -500), 'InOut', 'Quart', 0.5, true, nil)
            wait(0.6)
            frame:Destroy()
            flag10 = true
        end)
        local productInfo = MarketplaceService:GetProductInfo(PlaceId)
        frame3.name.Text = 'Place Name: ' .. productInfo.Name
        frame3.playerid.Text = 'Player ID: ' .. player.UserId
        frame3.maxplayers.Text = Players.MaxPlayers .. ' Players Max'
        frame3.placeid.Text = 'Place ID: ' .. PlaceId
        textButton2.MouseButton1Click:Connect(function()
            toClipboard(player.CharacterAppearanceId)
        end)
        textButton3.MouseButton1Click:Connect(function()
            toClipboard(player.UserId)
        end)
        textButton4.MouseButton1Click:Connect(function()
            toClipboard(PlaceId)
        end)
        textButton5.MouseButton1Click:Connect(function()
            toClipboard(productInfo.Name)
        end)
        repeat
            local players = Players:GetPlayers()
            frame3.players.Text = #players .. ' Player(s)'
            frame3.appearance.Text = 'Appearance: ' .. player.CharacterAppearanceId
            local floored = math.floor(workspace.DistributedGameTime)
            local floored2 = math.floor(workspace.DistributedGameTime / 60)
            local floored3 = math.floor(workspace.DistributedGameTime / 60 / 60)
            local v1 = floored - floored2 * 60
            local v2 = floored2 - floored3 * 60
            if floored3 < 1 then
                if v2 < 1 then
                    frame3.Time.Text = v1 .. ' Second(s)'
                else
                    frame3.Time.Text = v2 .. ' Minute(s), ' .. v1 .. ' Second(s)'
                end
            else
                frame3.Time.Text = floored3 .. ' Hour(s), ' .. v2 .. ' Minute(s), ' .. v1 .. ' Second(s)'
            end
            wait(1)
        until frame3.Parent == nil
    end)
end)
addcmd('jobid', {}, function(arg1, arg2)
    toClipboard('roblox://placeId=' .. PlaceId .. '&gameInstanceId=' .. JobId)
end)
addcmd('notifyjobid', {}, function(arg1, arg2)
    notify('JobId / PlaceId', JobId .. ' / ' .. PlaceId)
end)
addcmd('breakloops', {'break'}, function(arg1, arg2)
    num6 = tick()
end)
addcmd('gametp', {'gameteleport'}, function(list, arg2)
    TeleportService:Teleport(list[1])
end)
teleportRespawnHandler = 'local ok, data = pcall(function() return game:GetService("TeleportService"):GetLocalPlayerTeleportData() end)\nif ok and typeof(data) == "CFrame" then\n    local Players = game:GetService("Players")\n    local ME = Players.LocalPlayer\n    while not ME do\n        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()\n        ME = Players.LocalPlayer\n    end\n\n    local Character = ME.Character or ME.CharacterAdded:Wait()\n    Character:WaitForChild("HumanoidRootPart")\n\n    local t = tick()\n    while (tick() - t) <= 0.3 do\n        Character:PivotTo(data)\n        task.wait()\n    end\nend\n'
addcmd('rejoin', {'rj'}, function(list, player)
    local pivot
    if parseBoolean(list[1], false) == true then
        if queueteleport then
            if player.Character then
                pivot = player.Character:GetPivot()
                queueteleport(teleportRespawnHandler)
            end
        else
            notify('Incompatible Exploit', 'Your exploit does not support this argument (missing queue_on_teleport)')
        end
    end
    if #Players:GetPlayers() <= 1 then
        Players.LocalPlayer:Kick('\nRejoining...')
        task.wait(0.3)
        TeleportService:Teleport(PlaceId, Players.LocalPlayer, pivot)
        return
    end
    TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer, nil, pivot)
end)
addcmd('inviteprompt', {}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    if #player > 0 then
        ExperienceService:LaunchExperience({placeId = PlaceId, gameInstanceId = JobId, referredByPlayerId = plr[1].UserId})
    end
end)
addcmd('autorejoin', {'autorj'}, function(arg1, arg2)
    GuiService.ErrorMessageChanged:Connect(function()
        execCmd('rejoin')
    end)
    notify('Auto Rejoin', 'Auto rejoin enabled')
end)
addcmd('serverhop', {'shop'}, function(arg1, arg2)
    local list = {}
    local json = game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceId .. '/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true')
    local result = HttpService:JSONDecode(json)
    if result and result.data then
        for _, entry in next, result.data do
            if type(entry) == 'table' and tonumber(entry.playing) and tonumber(entry.maxPlayers) and entry.playing < entry.maxPlayers and entry.id ~= JobId then
                table.insert(list, 1, entry.id)
            end
        end
    end
    if #list > 0 then
        TeleportService:TeleportToPlaceInstance(PlaceId, list[math.random(1, #list)], Players.LocalPlayer)
        return
    end
    return notify('Serverhop', 'Couldn\'t find a server.')
end)
addcmd('exit', {'shutdown', 'leave'}, function(arg1, arg2)
    game:Shutdown()
end)
local set = {}
local connection4
addcmd('noclip', {}, function(list, player)
    pcall(function()
        connection4:Disconnect()
    end)
    Clip = false
    task.wait(0.1)
    set = {}
    connection4 = RunService.Stepped:Connect(function()
        if Clip == false and player.Character ~= nil then
            for _, descendant in pairs(player.Character:GetDescendants()) do
                if descendant:IsA('BasePart') and descendant.CanCollide == true and descendant.Name ~= floatName then
                    descendant.CanCollide = false
                    set[descendant] = true
                end
            end
        end
    end)
    if list[1] and list[1] == 'nonotify' then
        return
    end
    notify('Noclip', 'Noclip Enabled')
end)
addcmd('unnoclip', {'clip'}, function(list, arg2)
    pcall(function()
        connection4:Disconnect()
    end)
    Clip = true
    task.wait(0.1)
    for k, _ in pairs(set) do
        if typeof(k) == 'Instance' and k:IsA('BasePart') and k.Parent then
            k.CanCollide = true
        end
    end
    set = {}
    if list[1] and list[1] == 'nonotify' then
        return
    end
    notify('Noclip', 'Noclip Disabled')
end)
addcmd('togglenoclip', {}, function(arg1, arg2)
    execCmd(Clip and 'noclip' or 'unnoclip')
end)
FLYING = false
QEfly = true
iyflyspeed = 1
vehicleflyspeed = 1
sFLY = function(arg1)
    local localPlayer = Players.LocalPlayer
    local parent = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local humanoid2 = parent:FindFirstChildOfClass('Humanoid')
    if not humanoid2 then
        repeat
            task.wait()
        until parent:FindFirstChildOfClass('Humanoid')
        humanoid2 = parent:FindFirstChildOfClass('Humanoid')
    end
    if flyKeyDown or flyKeyUp then
        flyKeyDown:Disconnect()
        flyKeyUp:Disconnect()
    end
    local root = getRoot(parent)
    local data = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local data2 = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local num = 0
    local function FLY()
        FLYING = true
        local bodyGyro = Instance.new('BodyGyro')
        local bodyVelocity = Instance.new('BodyVelocity')
        bodyGyro.P = 90000
        bodyGyro.Parent = root
        bodyVelocity.Parent = root
        bodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
        bodyGyro.CFrame = root.CFrame
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
        task.spawn(function()
            repeat
                task.wait()
                local currentCamera = workspace.CurrentCamera
                if not arg1 and humanoid2 then
                    humanoid2.PlatformStand = true
                end
                if data.L + data.R ~= 0 or data.F + data.B ~= 0 or data.Q + data.E ~= 0 then
                    num = 50
                elseif data.L + data.R == 0 and data.F + data.B == 0 and data.Q + data.E == 0 and num ~= 0 then
                    num = 0
                end
                if data.L + data.R ~= 0 or data.F + data.B ~= 0 or data.Q + data.E ~= 0 then
                    bodyVelocity.Velocity = (currentCamera.CFrame.LookVector * (data.F + data.B) + (currentCamera.CFrame * CFrame.new(data.L + data.R, (data.F + data.B + data.Q + data.E) * 0.2, 0).p - currentCamera.CFrame.p)) * num
                    data2 = {F = data.F, B = data.B, L = data.L, R = data.R}
                elseif data.L + data.R == 0 and data.F + data.B == 0 and data.Q + data.E == 0 and num ~= 0 then
                    bodyVelocity.Velocity = (currentCamera.CFrame.LookVector * (data2.F + data2.B) + (currentCamera.CFrame * CFrame.new(data2.L + data2.R, (data2.F + data2.B + data.Q + data.E) * 0.2, 0).p - currentCamera.CFrame.p)) * num
                else
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
                bodyGyro.CFrame = currentCamera.CFrame
            until not FLYING
            data = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            data2 = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            num = 0
            bodyGyro:Destroy()
            bodyVelocity:Destroy()
            if humanoid2 then
                humanoid2.PlatformStand = false
            end
        end)
    end
    flyKeyDown = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then
            return
        end
        if input.KeyCode == Enum.KeyCode.W then
            data.F = arg1 and vehicleflyspeed or iyflyspeed
        elseif input.KeyCode == Enum.KeyCode.S then
            data.B = -(arg1 and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.A then
            data.L = -(arg1 and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.D then
            data.R = arg1 and vehicleflyspeed or iyflyspeed
        elseif input.KeyCode == Enum.KeyCode.E and QEfly then
            data.Q = (arg1 and vehicleflyspeed or iyflyspeed) * 2
        elseif input.KeyCode == Enum.KeyCode.Q and QEfly then
            data.E = -(arg1 and vehicleflyspeed or iyflyspeed) * 2
        end
        pcall(function()
            camera.CameraType = Enum.CameraType.Track
        end)
    end)
    flyKeyUp = UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then
            return
        end
        if input.KeyCode == Enum.KeyCode.W then
            data.F = 0
            return
        end
        if input.KeyCode == Enum.KeyCode.S then
            data.B = 0
            return
        end
        if input.KeyCode == Enum.KeyCode.A then
            data.L = 0
            return
        end
        if input.KeyCode == Enum.KeyCode.D then
            data.R = 0
            return
        end
        if input.KeyCode == Enum.KeyCode.E then
            data.Q = 0
            return
        end
        if input.KeyCode == Enum.KeyCode.Q then
            data.E = 0
        end
    end)
    FLY()
end
NOFLY = function()
    FLYING = false
    if flyKeyDown or flyKeyUp then
        flyKeyDown:Disconnect()
        flyKeyUp:Disconnect()
    end
    if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
        Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
    end
    pcall(function()
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end)
end
local name = randomString()
local name2 = randomString()
local connection5
local connection6
local function handlePlayer(player)
    pcall(function()
        FLYING = false
        local root = getRoot(player.Character)
        root:FindFirstChild(name):Destroy()
        root:FindFirstChild(name2):Destroy()
        player.Character:FindFirstChildWhichIsA('Humanoid').PlatformStand = false
        connection5:Disconnect()
        connection6:Disconnect()
    end)
end
local function connectEvents(player, arg2)
    handlePlayer(player)
    FLYING = true
    local root = getRoot(player.Character)
    local currentCamera = workspace.CurrentCamera
    local vector3 = Vector3.new()
    local vector32 = Vector3.new(0, 0, 0)
    local vector33 = Vector3.new(9000000000, 9000000000, 9000000000)
    local ControlModule = require(player.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild('ControlModule'))
    local bodyVelocity = Instance.new('BodyVelocity')
    bodyVelocity.Name = name
    bodyVelocity.Parent = root
    bodyVelocity.MaxForce = vector32
    bodyVelocity.Velocity = vector32
    local bodyGyro = Instance.new('BodyGyro')
    bodyGyro.Name = name2
    bodyGyro.Parent = root
    bodyGyro.MaxTorque = vector33
    bodyGyro.P = 1000
    bodyGyro.D = 50
    connection5 = player.CharacterAdded:Connect(function()
        local bodyVelocity = Instance.new('BodyVelocity')
        bodyVelocity.Name = name
        bodyVelocity.Parent = root
        bodyVelocity.MaxForce = vector32
        bodyVelocity.Velocity = vector32
        local bodyGyro = Instance.new('BodyGyro')
        bodyGyro.Name = name2
        bodyGyro.Parent = root
        bodyGyro.MaxTorque = vector33
        bodyGyro.P = 1000
        bodyGyro.D = 50
    end)
    connection6 = RunService.RenderStepped:Connect(function()
        root = getRoot(player.Character)
        currentCamera = workspace.CurrentCamera
        if player.Character:FindFirstChildWhichIsA('Humanoid') and root and root:FindFirstChild(name) and root:FindFirstChild(name2) then
            local humanoid2 = player.Character:FindFirstChildWhichIsA('Humanoid')
            local firstChild = root:FindFirstChild(name)
            local firstChild2 = root:FindFirstChild(name2)
            firstChild.MaxForce = vector33
            firstChild2.MaxTorque = vector33
            if not arg2 then
                humanoid2.PlatformStand = true
            end
            firstChild2.CFrame = currentCamera.CoordinateFrame
            firstChild.Velocity = vector3
            local moveVector = ControlModule:GetMoveVector()
            if moveVector.X > 0 then
                firstChild.Velocity = firstChild.Velocity + currentCamera.CFrame.RightVector * (moveVector.X * ((arg2 and vehicleflyspeed or iyflyspeed) * 50))
            end
            if moveVector.X < 0 then
                firstChild.Velocity = firstChild.Velocity + currentCamera.CFrame.RightVector * (moveVector.X * ((arg2 and vehicleflyspeed or iyflyspeed) * 50))
            end
            if moveVector.Z > 0 then
                firstChild.Velocity = firstChild.Velocity - currentCamera.CFrame.LookVector * (moveVector.Z * ((arg2 and vehicleflyspeed or iyflyspeed) * 50))
            end
            if moveVector.Z < 0 then
                firstChild.Velocity = firstChild.Velocity - currentCamera.CFrame.LookVector * (moveVector.Z * ((arg2 and vehicleflyspeed or iyflyspeed) * 50))
            end
        end
    end)
end
addcmd('fly', {}, function(list, arg2)
    if not IsOnMobile then
        NOFLY()
        wait()
        sFLY()
    else
        connectEvents(arg2)
    end
    if list[1] and isNumber(list[1]) then
        iyflyspeed = list[1]
    end
end)
addcmd('flyspeed', {'flysp'}, function(list, arg2)
    local v1 = list[1] or 1
    if isNumber(v1) then
        iyflyspeed = v1
    end
end)
addcmd('unfly', {'nofly', 'novfly', 'unvehiclefly', 'novehiclefly', 'unvfly'}, function(arg1, arg2)
    if not IsOnMobile then
        NOFLY()
        return
    end
    handlePlayer(arg2)
end)
addcmd('vfly', {'vehiclefly'}, function(list, arg2)
    if not IsOnMobile then
        NOFLY()
        wait()
        sFLY(true)
    else
        connectEvents(arg2, true)
    end
    if list[1] and isNumber(list[1]) then
        vehicleflyspeed = list[1]
    end
end)
addcmd('togglevfly', {}, function(arg1, arg2)
    if FLYING then
        if not IsOnMobile then
            NOFLY()
            return
        end
        handlePlayer(arg2)
        return
    end
    if not IsOnMobile then
        sFLY(true)
        return
    end
    connectEvents(arg2, true)
end)
addcmd('vflyspeed', {'vflysp', 'vehicleflyspeed', 'vehicleflysp'}, function(list, arg2)
    local v1 = list[1] or 1
    if isNumber(v1) then
        vehicleflyspeed = v1
    end
end)
addcmd('qefly', {'flyqe'}, function(list, arg2)
    if list[1] == 'false' then
        QEfly = false
        return
    end
    QEfly = true
end)
addcmd('togglefly', {}, function(arg1, arg2)
    if FLYING then
        if not IsOnMobile then
            NOFLY()
            return
        end
        handlePlayer(arg2)
        return
    end
    if not IsOnMobile then
        sFLY()
        return
    end
    connectEvents(arg2)
end)
CFspeed = 50
addcmd('cframefly', {'cfly'}, function(list, player)
    if list[1] and isNumber(list[1]) then
        CFspeed = list[1]
    end
    player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
    local head = player.Character:WaitForChild('Head')
    head.Anchored = true
    if CFloop then
        CFloop:Disconnect()
    end
    CFloop = RunService.Heartbeat:Connect(function(deltaTime)
        local v1 = player.Character:FindFirstChildOfClass('Humanoid').MoveDirection * (CFspeed * deltaTime)
        local cframe = head.CFrame
        local currentCamera = workspace.CurrentCamera
        local cframe2 = currentCamera.CFrame
        local position = cframe:ToObjectSpace(cframe2).Position
        cframe2 *= CFrame.new(-position.X, -position.Y, -position.Z + 1)
        local position2 = cframe2.Position
        local position3 = cframe.Position
        local position4 = CFrame.new(position2, Vector3.new(position3.X, position2.Y, position3.Z)):VectorToObjectSpace(v1)
        head.CFrame = CFrame.new(position3) * (cframe2 - position2) * CFrame.new(position4)
    end)
end)
addcmd('uncframefly', {'uncfly'}, function(arg1, player)
    if CFloop then
        CFloop:Disconnect()
        player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
        player.Character:WaitForChild('Head').Anchored = false
    end
end)
addcmd('cframeflyspeed', {'cflyspeed'}, function(list, arg2)
    if isNumber(list[1]) then
        CFspeed = list[1]
    end
end)
floating = false
local connection7
local connection8
local connection9
addcmd('float', {'platform'}, function(arg1, player)
    local character = player.Character
    floatName = randomString()
    floating = true
    if character and not character:FindFirstChild(floatName) then
        task.spawn(function()
            local lookAt = -3.1
            local part = Instance.new('Part')
            part.Name = floatName
            part.Parent = character
            part.Transparency = 1
            part.Size = Vector3.new(2, 0.2, 1.5)
            part.Anchored = true
            notify('Float', 'Started floating (Q = down & E = up)')
            connection7 = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then
                    return
                end
                if input.KeyCode == Enum.KeyCode.Q then
                    lookAt -= 0.5
                end
                if input.KeyCode == Enum.KeyCode.E then
                    lookAt += 1.5
                end
            end)
            connection8 = UserInputService.InputEnded:Connect(function(input, gameProcessed)
                if gameProcessed then
                    return
                end
                if input.KeyCode == Enum.KeyCode.Q then
                    lookAt += 0.5
                end
                if input.KeyCode == Enum.KeyCode.E then
                    lookAt -= 1.5
                end
            end)
            floatDied = player.Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
                connection9:Disconnect()
                part:Destroy()
                floatDied:Disconnect()
                connection7:Disconnect()
                connection8:Disconnect()
                floatName = nil
            end)
            local function floatPadLoop()
                if character:FindFirstChild(floatName) and getRoot(character) then
                    part.CFrame = getRoot(character).CFrame * CFrame.new(0, lookAt, 0)
                    return
                end
                connection9:Disconnect()
                part:Destroy()
                floatDied:Disconnect()
                connection7:Disconnect()
                connection8:Disconnect()
                floatName = nil
            end
            connection9 = RunService.PreAnimation:Connect(floatPadLoop)
        end)
    end
end)
addcmd('unfloat', {'nofloat', 'unplatform', 'noplatform'}, function(arg1, player)
    floating = false
    local character = player.Character
    notify('Float', 'Stopped floating')
    if character:FindFirstChild(floatName) then
        character:FindFirstChild(floatName):Destroy()
    end
    if floatDied then
        connection9:Disconnect()
        floatDied:Disconnect()
        connection7:Disconnect()
        connection8:Disconnect()
        floatName = nil
    end
end)
addcmd('togglefloat', {}, function(arg1, arg2)
    if floating then
        execCmd('unfloat')
        return
    end
    execCmd('float')
end)
swimming = false
local gravity = workspace.Gravity
local connection10
addcmd('swim', {}, function(arg1, player)
    if not swimming and player and player.Character and player.Character:FindFirstChildWhichIsA('Humanoid') then
        gravity = workspace.Gravity
        workspace.Gravity = 0
        local function onDied2()
            workspace.Gravity = gravity
            swimming = false
        end
        local humanoid2 = player.Character:FindFirstChildWhichIsA('Humanoid')
        gravReset = humanoid2.Died:Connect(onDied2)
        local enumItems = Enum.HumanoidStateType:GetEnumItems()
        table.remove(enumItems, table.find(enumItems, Enum.HumanoidStateType.None))
        for _, enumItem in pairs(enumItems) do
            humanoid2:SetStateEnabled(enumItem, false)
        end
        humanoid2:ChangeState(Enum.HumanoidStateType.Swimming)
        connection10 = RunService.Heartbeat:Connect(function()
            pcall(function()
                getRoot(player.Character).Velocity = humanoid2.MoveDirection ~= Vector3.new() and (getRoot(player.Character).Velocity or Vector3.new()) or humanoid2.MoveDirection == Vector3.new() and (UserInputService:IsKeyDown(Enum.KeyCode.Space) and getRoot(player.Character).Velocity or Vector3.new())
            end)
        end)
        swimming = true
    end
end)
addcmd('unswim', {'noswim'}, function(arg1, player)
    if player and player.Character and player.Character:FindFirstChildWhichIsA('Humanoid') then
        workspace.Gravity = gravity
        swimming = false
        if gravReset then
            gravReset:Disconnect()
        end
        if connection10 ~= nil then
            connection10:Disconnect()
            connection10 = nil
        end
        local humanoid2 = player.Character:FindFirstChildWhichIsA('Humanoid')
        local enumItems = Enum.HumanoidStateType:GetEnumItems()
        table.remove(enumItems, table.find(enumItems, Enum.HumanoidStateType.None))
        for _, enumItem in pairs(enumItems) do
            humanoid2:SetStateEnabled(enumItem, true)
        end
    end
end)
addcmd('toggleswim', {}, function(arg1, arg2)
    if swimming then
        execCmd('unswim')
        return
    end
    execCmd('swim')
end)
addcmd('setwaypoint', {'swp', 'setwp', 'spos', 'saveposition', 'savepos'}, function(arg1, player)
    local text = tostring(getstring(1, arg1))
    if getRoot(player.Character) then
        notify('Modified Waypoints', 'Created waypoint: ' .. getstring(1, arg1))
        local root = getRoot(player.Character)
        WayPoints[#WayPoints + 1] = {NAME = text, COORD = {math.floor(root.Position.X), math.floor(root.Position.Y), math.floor(root.Position.Z)}, GAME = PlaceId}
        if AllWaypoints ~= nil then
            AllWaypoints[#AllWaypoints + 1] = {NAME = text, COORD = {math.floor(root.Position.X), math.floor(root.Position.Y), math.floor(root.Position.Z)}, GAME = PlaceId}
        end
    end
    refreshwaypoints()
    updatesaves()
end)
addcmd('waypointpos', {'wpp', 'setwaypointposition', 'setpos', 'setwaypoint', 'setwaypointpos'}, function(list, player)
    local text = tostring(getstring(1, list))
    if getRoot(player.Character) then
        notify('Modified Waypoints', 'Created waypoint: ' .. getstring(1, list))
        WayPoints[#WayPoints + 1] = {NAME = text, COORD = {list[2], list[3], list[4]}, GAME = PlaceId}
        if AllWaypoints ~= nil then
            AllWaypoints[#AllWaypoints + 1] = {NAME = text, COORD = {list[2], list[3], list[4]}, GAME = PlaceId}
        end
    end
    refreshwaypoints()
    updatesaves()
end)
addcmd('waypoints', {'positions'}, function(arg1, arg2)
    if flag2 == false then
        flag2 = true
        Settings:TweenPosition(UDim2.new(0, 0, 0, 45), 'InOut', 'Quart', 0.5, true, nil)
        CMDsF.Visible = false
    end
    KeybindsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), 'InOut', 'Quart', 0.5, true, nil)
    AliasesFrame:TweenPosition(UDim2.new(0, 0, 0, 175), 'InOut', 'Quart', 0.5, true, nil)
    PluginsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), 'InOut', 'Quart', 0.5, true, nil)
    PositionsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), 'InOut', 'Quart', 0.5, true, nil)
    wait(0.5)
    SettingsHolder.Visible = false
    maximizeHolder()
end)
waypointParts = {}
addcmd('showwaypoints', {'showwp', 'showwps'}, function(arg1, arg2)
    execCmd('hidewaypoints')
    wait()
    for k, _ in pairs(WayPoints) do
        local position = WayPoints[k].COORD[1]
        local lookAt = WayPoints[k].COORD[2]
        local v1 = WayPoints[k].COORD[3]
        local part = Instance.new('Part')
        part.Size = Vector3.new(5, 5, 5)
        part.CFrame = CFrame.new(position, lookAt, v1)
        part.Parent = workspace
        part.Anchored = true
        part.CanCollide = false
        table.insert(waypointParts, part)
        local boxHandleAdornment = Instance.new('BoxHandleAdornment')
        boxHandleAdornment.Adornee = part
        boxHandleAdornment.AlwaysOnTop = true
        boxHandleAdornment.ZIndex = 10
        boxHandleAdornment.Size = part.Size
        boxHandleAdornment.Parent = part
    end
    for k, _ in pairs(pWayPoints) do
        local boxHandleAdornment2 = Instance.new('BoxHandleAdornment')
        boxHandleAdornment2.Adornee = pWayPoints[k].COORD[1]
        boxHandleAdornment2.AlwaysOnTop = true
        boxHandleAdornment2.ZIndex = 10
        boxHandleAdornment2.Size = pWayPoints[k].COORD[1].Size
        boxHandleAdornment2.Parent = pWayPoints[k].COORD[1]
        table.insert(waypointParts, boxHandleAdornment2)
    end
end)
addcmd('hidewaypoints', {'hidewp', 'hidewps'}, function(arg1, arg2)
    for _, waypointPart in pairs(waypointParts) do
        waypointPart:Destroy()
    end
    waypointParts = {}
end)
addcmd('waypoint', {'wp', 'lpos', 'loadposition', 'loadpos'}, function(arg1, player)
    local text = tostring(getstring(1, arg1))
    if player.Character then
        for k, _ in pairs(WayPoints) do
            if tostring(WayPoints[k].NAME):lower() ~= tostring(text):lower() then
                continue
            end
            local position = WayPoints[k].COORD[1]
            local lookAt = WayPoints[k].COORD[2]
            local v1 = WayPoints[k].COORD[3]
            getRoot(player.Character).CFrame = CFrame.new(position, lookAt, v1)
        end
        for k, _ in pairs(pWayPoints) do
            if tostring(pWayPoints[k].NAME):lower() ~= tostring(text):lower() then
                continue
            end
            getRoot(player.Character).CFrame = CFrame.new(pWayPoints[k].COORD[1].Position)
        end
    end
end)
tweenSpeed = 1
addcmd('tweenspeed', {'tspeed'}, function(list, arg2)
    local text = list[1] or 1
    if tonumber(text) then
        tweenSpeed = tonumber(text)
    end
end)
addcmd('tweenwaypoint', {'twp'}, function(arg1, player)
    local text = tostring(getstring(1, arg1))
    if player.Character then
        for k, _ in pairs(WayPoints) do
            local position = WayPoints[k].COORD[1]
            local lookAt = WayPoints[k].COORD[2]
            local v1 = WayPoints[k].COORD[3]
            if tostring(WayPoints[k].NAME):lower() ~= tostring(text):lower() then
                continue
            end
            TweenService:Create(getRoot(player.Character), TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(position, lookAt, v1)}):Play()
        end
        for k, _ in pairs(pWayPoints) do
            if tostring(pWayPoints[k].NAME):lower() ~= tostring(text):lower() then
                continue
            end
            TweenService:Create(getRoot(player.Character), TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pWayPoints[k].COORD[1].Position)}):Play()
        end
    end
end)
addcmd('walktowaypoint', {'wtwp'}, function(arg1, player)
    local text = tostring(getstring(1, arg1))
    if player.Character then
        for k, _ in pairs(WayPoints) do
            local x = WayPoints[k].COORD[1]
            local y = WayPoints[k].COORD[2]
            local z = WayPoints[k].COORD[3]
            if tostring(WayPoints[k].NAME):lower() ~= tostring(text):lower() then
                continue
            end
            if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                player.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(0.1)
            end
            player.Character:FindFirstChildOfClass('Humanoid').WalkToPoint = Vector3.new(x, y, z)
        end
        for k, _ in pairs(pWayPoints) do
            if tostring(pWayPoints[k].NAME):lower() ~= tostring(text):lower() then
                continue
            end
            if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                player.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(0.1)
            end
            player.Character:FindFirstChildOfClass('Humanoid').WalkToPoint = Vector3.new(pWayPoints[k].COORD[1].Position)
        end
    end
end)
addcmd('deletewaypoint', {'dwp', 'dpos', 'deleteposition', 'deletepos'}, function(arg1, arg2)
    for k, wayPoint in pairs(WayPoints) do
        if wayPoint.NAME:lower() ~= tostring(getstring(1, arg1)):lower() then
            continue
        end
        notify('Modified Waypoints', 'Deleted waypoint: ' .. wayPoint.NAME)
        table.remove(WayPoints, k)
    end
    if AllWaypoints ~= nil and #AllWaypoints > 0 then
        for k, allWaypoint in pairs(AllWaypoints) do
            if allWaypoint.NAME:lower() == tostring(getstring(1, arg1)):lower() and (not allWaypoint.GAME or allWaypoint.GAME == PlaceId) then
                table.remove(AllWaypoints, k)
            end
        end
    end
    for k, pWayPoint in pairs(pWayPoints) do
        if pWayPoint.NAME:lower() ~= tostring(getstring(1, arg1)):lower() then
            continue
        end
        notify('Modified Waypoints', 'Deleted waypoint: ' .. pWayPoint.NAME)
        table.remove(pWayPoints, k)
    end
    refreshwaypoints()
    updatesaves()
end)
addcmd('clearwaypoints', {'cwp', 'clearpositions', 'cpos', 'clearpos'}, function(arg1, arg2)
    WayPoints = {}
    pWayPoints = {}
    refreshwaypoints()
    updatesaves()
    AllWaypoints = {}
    notify('Modified Waypoints', 'Removed all waypoints')
end)
addcmd('cleargamewaypoints', {'cgamewp'}, function(arg1, arg2)
    for k, wayPoint in pairs(WayPoints) do
        if wayPoint.GAME ~= PlaceId then
            continue
        end
        table.remove(WayPoints, k)
    end
    if AllWaypoints ~= nil and #AllWaypoints > 0 then
        for k, allWaypoint in pairs(AllWaypoints) do
            if allWaypoint.GAME ~= PlaceId then
                continue
            end
            table.remove(AllWaypoints, k)
        end
    end
    for k, pWayPoint in pairs(pWayPoints) do
        if pWayPoint.GAME ~= PlaceId then
            continue
        end
        table.remove(pWayPoints, k)
    end
    refreshwaypoints()
    updatesaves()
    notify('Modified Waypoints', 'Deleted game waypoints')
end)
local data3 = {inventory = Enum.CoreGuiType.Backpack, leaderboard = Enum.CoreGuiType.PlayerList, emotes = Enum.CoreGuiType.EmotesMenu}
for _, item in ipairs(Enum.CoreGuiType:GetEnumItems()) do
    data3[item.Name:lower()] = item
end
addcmd('enable', {}, function(list, arg2)
    local result = list[1] and list[1]:lower()
    if result then
        if result == 'reset' then
            StarterGui:SetCore('ResetButtonCallback', true)
            return
        end
        local entry = data3[result]
        if entry then
            StarterGui:SetCoreGuiEnabled(entry, true)
        end
    end
end)
addcmd('disable', {}, function(list, arg2)
    local result = list[1] and list[1]:lower()
    if result then
        if result == 'reset' then
            StarterGui:SetCore('ResetButtonCallback', false)
            return
        end
        local entry = data3[result]
        if entry then
            StarterGui:SetCoreGuiEnabled(entry, false)
        end
    end
end)
local list = {}
addcmd('showguis', {}, function(arg1, arg2)
    for _, descendant in pairs(PlayerGui:GetDescendants()) do
        if not descendant:IsA('Frame') and not descendant:IsA('ImageLabel') and not descendant:IsA('ScrollingFrame') then
            continue
        end
        if descendant.Visible then
            continue
        end
        descendant.Visible = true
        if FindInTable(list, descendant) then
            continue
        end
        table.insert(list, descendant)
    end
end)
addcmd('unshowguis', {}, function(arg1, arg2)
    for _, v in pairs(list) do
        v.Visible = false
    end
    list = {}
end)
local list2 = {}
addcmd('hideguis', {}, function(arg1, arg2)
    for _, descendant in pairs(PlayerGui:GetDescendants()) do
        if not descendant:IsA('Frame') and not descendant:IsA('ImageLabel') and not descendant:IsA('ScrollingFrame') then
            continue
        end
        if not descendant.Visible then
            continue
        end
        descendant.Visible = false
        if FindInTable(list2, descendant) then
            continue
        end
        table.insert(list2, descendant)
    end
end)
addcmd('unhideguis', {}, function(arg1, arg2)
    for _, v in pairs(list2) do
        v.Visible = true
    end
    list2 = {}
end)
deleteGuisAtPos = function()
    pcall(function()
        local guiObjectsAtPosition = PlayerGui:GetGuiObjectsAtPosition(IYMouse.X, IYMouse.Y)
        for _, v in pairs(guiObjectsAtPosition) do
            if v.Visible ~= true then
                continue
            end
            v:Destroy()
        end
    end)
end
local connection11
addcmd('guidelete', {}, function(arg1, arg2)
    connection11 = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Backspace then
            deleteGuisAtPos()
        end
    end)
    notify('GUI Delete Enabled', 'Hover over a GUI and press backspace to delete it')
end)
addcmd('unguidelete', {'noguidelete'}, function(arg1, arg2)
    if connection11 then
        connection11:Disconnect()
    end
    notify('GUI Delete Disabled', 'GUI backspace delete has been disabled')
end)
local StayOpen2 = StayOpen
addcmd('hideiy', {}, function(list, arg2)
    flag3 = true
    StayOpen2 = StayOpen
    if StayOpen == true then
        StayOpen = false
        On.BackgroundTransparency = 1
    end
    minimizeNum = 0
    minimizeHolder()
    if not list[1] or tostring(list[1]) ~= 'nonotify' then
        notify('IY Hidden', 'You can press the prefix key to access the command bar')
    end
end)
addcmd('showiy', {'unhideiy'}, function(arg1, arg2)
    flag3 = false
    minimizeNum = -20
    if StayOpen2 then
        maximizeHolder()
        StayOpen = true
        On.BackgroundTransparency = 0
        return
    end
    minimizeHolder()
end)
addcmd('rec', {'record'}, function(arg1, arg2)
    return COREGUI:ToggleRecording()
end)
addcmd('screenshot', {'scrnshot'}, function(arg1, arg2)
    return COREGUI:TakeScreenshot()
end)
addcmd('togglefs', {'togglefullscreen'}, function(arg1, arg2)
    return GuiService:ToggleFullscreen()
end)
addcmd('inspect', {'examine'}, function(list, arg2)
    for _, v in ipairs(getPlayer(list[1], arg2)) do
        GuiService:CloseInspectMenu()
        GuiService:InspectPlayerFromUserId(Players[v].UserId)
    end
end)
addcmd('savegame', {'saveplace'}, function(arg1, arg2)
    if saveinstance then
        notify('Loading', 'Downloading game. This will take a while')
        saveinstance()
        notify('Game Saved', 'Saved place to the workspace folder within your exploit folder.')
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing saveinstance)')
end)
addcmd('clearerror', {'clearerrors'}, function(arg1, arg2)
    GuiService:ClearError()
end)
addcmd('antigameplaypaused', {}, function(arg1, arg2)
    pcall(function()
        networkPaused:Disconnect()
    end)
    networkPaused = COREGUI.RobloxGui.ChildAdded:Connect(function(child)
        if child.Name == 'CoreScripts/NetworkPause' then
            child:Destroy()
        end
    end)
    COREGUI.RobloxGui['CoreScripts/NetworkPause']:Destroy()
end)
addcmd('unantigameplaypaused', {}, function(arg1, arg2)
    networkPaused:Disconnect()
end)
addcmd('clientantikick', {'antikick'}, function(arg1, arg2)
    if not hookmetamethod then
        return notify('Incompatible Exploit', 'Your exploit does not support this command (missing hookmetamethod)')
    end
    local localPlayer = Players.LocalPlayer
    local callback
    callback = hookmetamethod(game, '__namecall', newcclosure(function(...)
        local v1 = getnamecallmethod and getnamecallmethod() or ''
        if select(1, ...) == localPlayer and v1 == 'Kick' or v1 == 'kick' then
            return nil
        end
        return callback(...)
    end))
    hookfunction(localPlayer.Kick, newcclosure(function(arg1, arg2)
        if arg1 ~= lp then
            error('Expected \':\' not \'.\' calling member function Kick', 2)
        end
        return nil
    end))
    notify('Client Antikick', 'Client anti kick is now active (only effective on localscript kick)')
end)
allow_rj = true
addcmd('clientantiteleport', {'antiteleport'}, function(arg1, arg2)
    if not hookmetamethod then
        return notify('Incompatible Exploit', 'Your exploit does not support this command (missing hookmetamethod)')
    end
    local callback
    callback = hookfunction(TeleportService.Teleport, newcclosure(function(arg1, value, arg3, arg4, value2)
        if checkcaller() or allow_rj and value == game.PlaceId then
            return callback(arg1, value, arg3, arg4, value2)
        end
        if arg1 ~= TeleportService then
            error('Expected \':\' not \'.\' calling member function Teleport', 2)
        end
        if value == nil then
            error('Argument 1 missing or nil', 2)
        end
        if typeof(value) ~= 'number' and value ~= true then
            error(`Unable to cast {typeof(value)} to int64`, 2)
        elseif value == true then
            return
        end
        if typeof(value2) ~= 'Instance' and value2 ~= nil then
            error('Unable to cast value to Object', 2)
        end
        return nil
    end))
    hookfunction(TeleportService.TeleportAsync, newcclosure(function(arg1, arg2, value, arg4)
        if arg1 ~= TeleportService then
            error('Expected \':\' not \'.\' calling member function TeleportAsync', 2)
        end
        if value == nil then
            error('Argument 2 missing or nil', 2)
        end
        if typeof(value) ~= 'table' then
            error('Unable to cast value to Objects', 2)
        end
        error('TeleportUnknown must be called from a Server', 2)
    end))
    local callback2
    callback2 = hookmetamethod(game, '__namecall', newcclosure(function(...)
        local result = getnamecallmethod()
        if select(1, ...) == TeleportService and result == 'teleport' or result == 'Teleport' or result == 'TeleportToPlaceInstance' or result == 'TeleportAsync' then
            if checkcaller() or allow_rj and select(2, ...) == game.PlaceId then
                return callback2(...)
            end
            return
        end
        return callback2(...)
    end))
    notify('Client AntiTP', 'Client anti teleport is now active (only effective on localscript teleport)')
end)
addcmd('allowrejoin', {'allowrj'}, function(arg1, arg2)
    allow_rj = not allow_rj
    notify('Client AntiTP', `Scripts now may{allow_rj and '' or ' not'} make you rejoin the server`)
end)
addcmd('cancelteleport', {'canceltp'}, function(arg1, arg2)
    TeleportService:TeleportCancel()
end)
addcmd('volume', {'vol'}, function(list, arg2)
    UserSettings():GetService('UserGameSettings').MasterVolume = list[1] / 10
end)
addcmd('antilag', {'boostfps', 'lowgraphics'}, function(arg1, arg2)
    local terrain = workspace:FindFirstChildWhichIsA('Terrain')
    terrain.WaterWaveSize = 0
    terrain.WaterWaveSpeed = 0
    terrain.WaterReflectance = 0
    terrain.WaterTransparency = 1
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9000000000
    Lighting.FogStart = 9000000000
    settings().Rendering.QualityLevel = 1
    for _, descendant in pairs(game:GetDescendants()) do
        if descendant:IsA('BasePart') then
            descendant.CastShadow = false
            descendant.Material = 'Plastic'
            descendant.Reflectance = 0
            descendant.BackSurface = 'SmoothNoOutlines'
            descendant.BottomSurface = 'SmoothNoOutlines'
            descendant.FrontSurface = 'SmoothNoOutlines'
            descendant.LeftSurface = 'SmoothNoOutlines'
            descendant.RightSurface = 'SmoothNoOutlines'
            descendant.TopSurface = 'SmoothNoOutlines'
        elseif descendant:IsA('Decal') then
            descendant.Transparency = 1
            descendant.Texture = ''
        elseif descendant:IsA('ParticleEmitter') or descendant:IsA('Trail') then
            descendant.Lifetime = NumberRange.new(0)
        end
    end
    for _, descendant in pairs(Lighting:GetDescendants()) do
        if not descendant:IsA('PostEffect') then
            continue
        end
        descendant.Enabled = false
    end
    workspace.DescendantAdded:Connect(function(descendant)
        task.spawn(function()
            if descendant:IsA('ForceField') or descendant:IsA('Sparkles') or descendant:IsA('Smoke') or descendant:IsA('Fire') or descendant:IsA('Beam') then
                RunService.Heartbeat:Wait()
                descendant:Destroy()
                return
            end
            if descendant:IsA('BasePart') then
                descendant.CastShadow = false
            end
        end)
    end)
end)
addcmd('setfpscap', {'fpscap', 'maxfps'}, function(list, arg2)
    if fpscaploop then
        task.cancel(fpscaploop)
        fpscaploop = nil
    end
    local num, v1 = 60, tonumber(list[1]) or 1000000
    if v1 == 'none' then
        return
    end
    local v2
    if v1 > 0 then
        v2 = v1
    else
        return notify('Invalid argument', 'Please provide a number above 0 or \'none\'.')
    end
    if setfpscap and type(setfpscap) == 'function' then
        setfpscap(v2)
    else
        fpscaploop = task.spawn(function()
            local startTime = os.clock()
            while true do
                if os.clock() >= startTime + 1 / v2 then
                    startTime = os.clock()
                    task.wait()
                end
            end
        end)
    end
end)
addcmd('notify', {}, function(arg1, arg2)
    notify(getstring(1, arg1))
end)
addcmd('lastcommand', {'lastcmd'}, function(arg1, arg2)
    if cmdHistory[1]:sub(1, 11) ~= 'lastcommand' and cmdHistory[1]:sub(1, 7) ~= 'lastcmd' then
        execCmd(cmdHistory[1])
    end
end)
addcmd('esp', {}, function(arg1, instance)
    if not CHMSenabled then
        ESPenabled = true
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name == instance.Name then
                continue
            end
            ESP(player)
        end
        return
    end
    notify('ESP', 'Disable chams (nochams) before using esp')
end)
addcmd('espteam', {}, function(arg1, instance)
    if not CHMSenabled then
        ESPenabled = true
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name == instance.Name then
                continue
            end
            ESP(player, true)
        end
        return
    end
    notify('ESP', 'Disable chams (nochams) before using esp')
end)
addcmd('noesp', {'unesp', 'unespteam'}, function(arg1, arg2)
    ESPenabled = false
    for _, child in pairs(COREGUI:GetChildren()) do
        if string.sub(child.Name, -4) ~= '_ESP' then
            continue
        end
        child:Destroy()
    end
end)
addcmd('esptransparency', {}, function(list, arg2)
    espTransparency = tonumber(list[1]) or 0.3
    if ESPenabled then
        execCmd('esp')
    end
    if CHMSenabled then
        execCmd('chams')
    end
    updatesaves()
end)
local list3 = {}
local connection12
partAdded = function(parent)
    if #list3 > 0 then
        if FindInTable(list3, parent.Name:lower()) then
            local boxHandleAdornment = Instance.new('BoxHandleAdornment')
            boxHandleAdornment.Name = parent.Name:lower() .. '_PESP'
            boxHandleAdornment.Parent = parent
            boxHandleAdornment.Adornee = parent
            boxHandleAdornment.AlwaysOnTop = true
            boxHandleAdornment.ZIndex = 0
            boxHandleAdornment.Size = parent.Size
            boxHandleAdornment.Transparency = espTransparency
            boxHandleAdornment.Color = BrickColor.new('Lime green')
        end
    else
        connection12:Disconnect()
        connection12 = nil
    end
end
addcmd('partesp', {}, function(arg1, arg2)
    local item = getstring(1, arg1):lower()
    if not FindInTable(list3, item) then
        table.insert(list3, item)
        for _, descendant in pairs(workspace:GetDescendants()) do
            if descendant:IsA('BasePart') and descendant.Name:lower() == item then
                local boxHandleAdornment = Instance.new('BoxHandleAdornment')
                boxHandleAdornment.Name = item .. '_PESP'
                boxHandleAdornment.Parent = descendant
                boxHandleAdornment.Adornee = descendant
                boxHandleAdornment.AlwaysOnTop = true
                boxHandleAdornment.ZIndex = 0
                boxHandleAdornment.Size = descendant.Size
                boxHandleAdornment.Transparency = espTransparency
                boxHandleAdornment.Color = BrickColor.new('Lime green')
            end
        end
    end
    if connection12 == nil then
        connection12 = workspace.DescendantAdded:Connect(partAdded)
    end
end)
addcmd('unpartesp', {'nopartesp'}, function(list, arg2)
    if list[1] then
        local result = getstring(1, list):lower()
        if FindInTable(list3, result) then
            table.remove(list3, GetInTable(list3, result))
        end
        for _, descendant in pairs(workspace:GetDescendants()) do
            if descendant:IsA('BoxHandleAdornment') and descendant.Name == result .. '_PESP' then
                descendant:Destroy()
            end
        end
        return
    end
    connection12:Disconnect()
    connection12 = nil
    list3 = {}
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA('BoxHandleAdornment') and descendant.Name:sub(-5) == '_PESP' then
            descendant:Destroy()
        end
    end
end)
addcmd('chams', {}, function(arg1, instance)
    if not ESPenabled then
        CHMSenabled = true
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name == instance.Name then
                continue
            end
            CHMS(player)
        end
        return
    end
    notify('Chams', 'Disable ESP (noesp) before using chams')
end)
addcmd('nochams', {'unchams'}, function(arg1, arg2)
    CHMSenabled = false
    for _, player in pairs(Players:GetPlayers()) do
        for _, child in pairs(COREGUI:GetChildren()) do
            if child.Name ~= player.Name .. '_CHMS' then
                continue
            end
            child:Destroy()
        end
    end
end)
addcmd('locate', {}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        Locate(Players[v])
    end
end)
addcmd('nolocate', {'unlocate'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    if list[1] then
        for _, v in pairs(player) do
            for _, child in pairs(COREGUI:GetChildren()) do
                if child.Name ~= Players[v].Name .. '_LC' then
                    continue
                end
                child:Destroy()
            end
        end
        return
    end
    for _, child in pairs(COREGUI:GetChildren()) do
        if string.sub(child.Name, -3) ~= '_LC' then
            continue
        end
        child:Destroy()
    end
end)
viewing = nil
addcmd('view', {'spectate'}, function(list, arg2)
    StopFreecam()
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        if viewDied then
            viewDied:Disconnect()
            viewChanged:Disconnect()
        end
        viewing = Players[v]
        workspace.CurrentCamera.CameraSubject = viewing.Character
        notify('Spectate', 'Viewing ' .. Players[v].Name)
        local function viewDiedFunc()
            repeat
                wait()
            until Players[v].Character ~= nil and getRoot(Players[v].Character)
            workspace.CurrentCamera.CameraSubject = viewing.Character
        end
        viewDied = Players[v].CharacterAdded:Connect(viewDiedFunc)
        local function viewChangedFunc()
            workspace.CurrentCamera.CameraSubject = viewing.Character
        end
        viewChanged = workspace.CurrentCamera:GetPropertyChangedSignal('CameraSubject'):Connect(viewChangedFunc)
    end
end)
addcmd('viewpart', {'viewp'}, function(list, arg2)
    StopFreecam()
    if list[1] then
        for _, descendant in pairs(workspace:GetDescendants()) do
            if descendant.Name:lower() == getstring(1, list):lower() and descendant:IsA('BasePart') then
                wait(0.1)
                workspace.CurrentCamera.CameraSubject = descendant
            end
        end
    end
end)
addcmd('unview', {'unspectate'}, function(arg1, player)
    StopFreecam()
    if viewing ~= nil then
        viewing = nil
        notify('Spectate', 'View turned off')
    end
    if viewDied then
        viewDied:Disconnect()
        viewChanged:Disconnect()
    end
    workspace.CurrentCamera.CameraSubject = player.Character
end)
fcRunning = false
local currentCamera = workspace.CurrentCamera
workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
    local currentCamera2 = workspace.CurrentCamera
    if currentCamera2 then
        currentCamera = currentCamera2
    end
end)
local value = Enum.ContextActionPriority.High.Value
Spring = {}
Spring.__index = Spring
function Spring.new(arg1, number)
    local object = setmetatable({}, Spring)
    object.f = arg1
    object.p = number
    object.v = number * 0
    return object
end
function Spring:Update(number, arg3)
    local v1 = self.f * 2 * math.pi
    local p = self.p
    local v2 = self.v
    local v3 = arg3 - p
    local result = math.exp(-v1 * number)
    local v4 = arg3 + (v2 * number - v3 * (v1 * number + 1)) * result
    self.p, self.v = v4, (v1 * number * (v3 * v1 - v2) + v2) * result
    return v4
end
function Spring:Reset(number)
    self.p = number
    self.v = number * 0
end
local vector3 = Vector3.new()
local vector22 = Vector2.new()
local spring = Spring.new(5, Vector3.new())
local spring2 = Spring.new(5, Vector2.new())
Input = {}
keyboard = {W = 0, A = 0, S = 0, D = 0, E = 0, Q = 0, Up = 0, Down = 0, LeftShift = 0}
mouse = {Delta = Vector2.new()}
NAV_KEYBOARD_SPEED = Vector3.new(1, 1, 1)
PAN_MOUSE_SPEED = Vector2.new(1, 1) * (math.pi / 64)
NAV_ADJ_SPEED = 0.75
NAV_SHIFT_MUL = 0.25
navSpeed = 1
function Input.Vel(arg1)
    navSpeed = math.clamp(navSpeed + arg1 * (keyboard.Up - keyboard.Down) * NAV_ADJ_SPEED, 0.01, 4)
    local v1 = Vector3.new(keyboard.D - keyboard.A, keyboard.E - keyboard.Q, keyboard.S - keyboard.W) * NAV_KEYBOARD_SPEED
    return v1 * (navSpeed * (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and NAV_SHIFT_MUL or 1))
end
function Input.Pan(arg1)
    local v1 = mouse.Delta * PAN_MOUSE_SPEED
    mouse.Delta = Vector2.new()
    return v1
end
Keypress = function(arg1, arg2, arg3)
    keyboard[arg3.KeyCode.Name] = arg2 == Enum.UserInputState.Begin and 1 or 0
    return Enum.ContextActionResult.Sink
end
MousePan = function(arg1, arg2, arg3)
    local delta = arg3.Delta
    mouse.Delta = Vector2.new(-delta.y, -delta.x)
    return Enum.ContextActionResult.Sink
end
Zero = function(map)
    for k, v in pairs(map) do
        map[k] = v * 0
    end
end
function Input.StartCapture()
    ContextActionService:BindActionAtPriority('FreecamKeyboard', Keypress, false, value, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.E, Enum.KeyCode.Q, Enum.KeyCode.Up, Enum.KeyCode.Down)
    ContextActionService:BindActionAtPriority('FreecamMousePan', MousePan, false, value, Enum.UserInputType.MouseMovement)
end
function Input.StopCapture()
    navSpeed = 1
    Zero(keyboard)
    Zero(mouse)
    ContextActionService:UnbindAction('FreecamKeyboard')
    ContextActionService:UnbindAction('FreecamMousePan')
end
GetFocusDistance = function(arg1)
    local viewportSize = currentCamera.ViewportSize
    local v1 = 2 * math.tan(cameraFov / 2)
    local v2 = viewportSize.x / viewportSize.y * v1
    local rightVector = arg1.rightVector
    local upVector = arg1.upVector
    local lookVector = arg1.lookVector
    local vector3 = Vector3.new()
    local magnitude = 512
    for i = 0, 1, 0.5 do
        for j = 0, 1, 0.5 do
            local v3 = (i - 0.5) * v2
            local v4 = (j - 0.5) * v1
            local v5 = rightVector * v3 - upVector * v4 + lookVector
            local v6 = arg1.p + v5 * 0.1
            local v7, v8 = workspace:FindPartOnRay(Ray.new(v6, v5.unit * magnitude))
            local magnitude2 = (v8 - v6).magnitude
            if magnitude2 < magnitude then
                magnitude = magnitude2
                vector3 = v5.unit
            end
        end
    end
    return lookVector:Dot(vector3) * magnitude
end
local function StepFreecam(deltaTime)
    local result = spring:Update(deltaTime, Input.Vel(deltaTime))
    local result2 = spring2:Update(deltaTime, Input.Pan(deltaTime))
    local root = math.sqrt(math.tan(math.rad(35)) / math.tan(math.rad(cameraFov / 2)))
    vector22 = vector22 + result2 * Vector2.new(0.75, 1) * 8 * (deltaTime / root)
    vector22 = Vector2.new(math.clamp(vector22.x, -math.rad(90), math.rad(90)), vector22.y % (2 * math.pi))
    local cframe = CFrame.new(vector3) * CFrame.fromOrientation(vector22.x, vector22.y, 0) * CFrame.new(result * Vector3.new(1, 1, 1) * 64 * deltaTime)
    vector3 = cframe.p
    currentCamera.CFrame = cframe
    currentCamera.Focus = cframe * CFrame.new(0, 0, -GetFocusDistance(cframe))
    currentCamera.FieldOfView = cameraFov
end
local object = {}
mouseBehavior = ''
mouseIconEnabled = ''
cameraType = ''
cameraFocus = ''
cameraCFrame = ''
cameraFieldOfView = ''
function object.Push()
    cameraFieldOfView = currentCamera.FieldOfView
    currentCamera.FieldOfView = 70
    cameraType = currentCamera.CameraType
    currentCamera.CameraType = Enum.CameraType.Custom
    cameraCFrame = currentCamera.CFrame
    cameraFocus = currentCamera.Focus
    mouseIconEnabled = UserInputService.MouseIconEnabled
    UserInputService.MouseIconEnabled = true
    mouseBehavior = UserInputService.MouseBehavior
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end
function object.Pop()
    currentCamera.FieldOfView = 70
    currentCamera.CameraType = cameraType
    cameraType = nil
    currentCamera.CFrame = cameraCFrame
    cameraCFrame = nil
    currentCamera.Focus = cameraFocus
    cameraFocus = nil
    UserInputService.MouseIconEnabled = mouseIconEnabled
    mouseIconEnabled = nil
    UserInputService.MouseBehavior = mouseBehavior
    mouseBehavior = nil
end
StartFreecam = function(arg1)
    if fcRunning then
        StopFreecam()
    end
    local cframe = currentCamera.CFrame
    if arg1 then
        cframe = arg1
    end
    vector22 = Vector2.new()
    vector3 = cframe.p
    cameraFov = currentCamera.FieldOfView
    spring:Reset(Vector3.new())
    spring2:Reset(Vector2.new())
    object.Push()
    RunService:BindToRenderStep('Freecam', Enum.RenderPriority.Camera.Value, StepFreecam)
    Input.StartCapture()
    fcRunning = true
end
StopFreecam = function()
    if not fcRunning then
        return
    end
    Input.StopCapture()
    RunService:UnbindFromRenderStep('Freecam')
    object.Pop()
    workspace.Camera.FieldOfView = 70
    fcRunning = false
end
addcmd('freecam', {'fc'}, function(arg1, arg2)
    StartFreecam()
end)
addcmd('freecampos', {'fcpos', 'fcp', 'freecamposition', 'fcposition'}, function(list, arg2)
    if not list[1] then
        return
    end
    local cframe = CFrame.new(list[1], list[2], list[3])
    StartFreecam(cframe)
end)
addcmd('freecamwaypoint', {'fcwp'}, function(arg1, player)
    local text = tostring(getstring(1, arg1))
    if player.Character then
        for k, _ in pairs(WayPoints) do
            local position = WayPoints[k].COORD[1]
            local lookAt = WayPoints[k].COORD[2]
            local v1 = WayPoints[k].COORD[3]
            if tostring(WayPoints[k].NAME):lower() ~= tostring(text):lower() then
                continue
            end
            StartFreecam(CFrame.new(position, lookAt, v1))
        end
        for k, _ in pairs(pWayPoints) do
            if tostring(pWayPoints[k].NAME):lower() ~= tostring(text):lower() then
                continue
            end
            StartFreecam(CFrame.new(pWayPoints[k].COORD[1].Position))
        end
    end
end)
addcmd('freecamgoto', {'fcgoto', 'freecamtp', 'fctp'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        StartFreecam(getRoot(Players[v].Character).CFrame)
    end
end)
addcmd('unfreecam', {'nofreecam', 'unfc', 'nofc'}, function(arg1, arg2)
    StopFreecam()
end)
addcmd('freecamspeed', {'fcspeed'}, function(list, arg2)
    local x = list[1] or 1
    if isNumber(x) then
        NAV_KEYBOARD_SPEED = Vector3.new(x, x, x)
    end
end)
addcmd('notifyfreecamposition', {'notifyfcpos'}, function(arg1, arg2)
    if fcRunning then
        local x = workspace.CurrentCamera.CFrame.Position.X
        local y = workspace.CurrentCamera.CFrame.Position.Y
        local z = workspace.CurrentCamera.CFrame.Position.Z
        local format = string.format
        local round2 = math.round
        notify('Current Position', format('%s, %s, %s', round2(x), round2(y), round2(z)))
    end
end)
addcmd('copyfreecamposition', {'copyfcpos'}, function(arg1, arg2)
    if fcRunning then
        local x = workspace.CurrentCamera.CFrame.Position.X
        local y = workspace.CurrentCamera.CFrame.Position.Y
        local z = workspace.CurrentCamera.CFrame.Position.Z
        local format = string.format
        local round2 = math.round
        toClipboard(format('%s, %s, %s', round2(x), round2(y), round2(z)))
    end
end)
addcmd('gotocamera', {'gotocam', 'tocam'}, function(arg1, player)
    getRoot(player.Character).CFrame = workspace.Camera.CFrame
end)
addcmd('tweengotocamera', {'tweengotocam', 'tgotocam', 'ttocam'}, function(arg1, player)
    TweenService:Create(getRoot(player.Character), TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = workspace.Camera.CFrame}):Play()
end)
addcmd('fov', {}, function(list, arg2)
    local fieldOfView = list[1] or 70
    if isNumber(fieldOfView) then
        workspace.CurrentCamera.FieldOfView = fieldOfView
    end
end)
local cameraMaxZoomDistance = Players.LocalPlayer.CameraMaxZoomDistance
local cameraMinZoomDistance = Players.LocalPlayer.CameraMinZoomDistance
addcmd('lookat', {}, function(list, arg2)
    if arg2.CameraMaxZoomDistance ~= 0.5 then
        cameraMaxZoomDistance = arg2.CameraMaxZoomDistance
        cameraMinZoomDistance = arg2.CameraMinZoomDistance
    end
    arg2.CameraMaxZoomDistance = 0.5
    arg2.CameraMinZoomDistance = 0.5
    wait()
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        local character = Players[v].Character
        if character and character:FindFirstChild('Head') then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, character.Head.CFrame.p)
            wait(0.1)
        end
    end
    arg2.CameraMaxZoomDistance = cameraMaxZoomDistance
    arg2.CameraMinZoomDistance = cameraMinZoomDistance
end)
addcmd('fixcam', {'restorecam'}, function(arg1, player)
    StopFreecam()
    execCmd('unview')
    workspace.CurrentCamera:remove()
    wait(0.1)
    repeat
        wait()
    until player.Character ~= nil
    workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildWhichIsA('Humanoid')
    workspace.CurrentCamera.CameraType = 'Custom'
    player.CameraMinZoomDistance = 0.5
    player.CameraMaxZoomDistance = 400
    player.CameraMode = 'Classic'
    player.Character.Head.Anchored = false
end)
addcmd('enableshiftlock', {'enablesl', 'shiftlock'}, function(arg1, instance)
    local function enableShiftlock()
        instance.DevEnableMouseLock = true
    end
    instance:GetPropertyChangedSignal('DevEnableMouseLock'):Connect(enableShiftlock)
    enableShiftlock()
    notify('Shiftlock', 'Shift lock should now be available')
end)
addcmd('firstp', {}, function(arg1, arg2)
    arg2.CameraMode = 'LockFirstPerson'
end)
addcmd('thirdp', {}, function(arg1, arg2)
    arg2.CameraMode = 'Classic'
end)
addcmd('noclipcam', {'nccam'}, function(arg1, arg2)
    local callback = debug and debug.setconstant or setconstant
    local callback2 = debug and debug.getconstants or getconstants
    if not callback or not getgc or not callback2 then
        return notify('Incompatible Exploit', 'Your exploit does not support this command (missing setconstant or getconstants or getgc)')
    end
    local popper = arg2.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
    for _, v in pairs(getgc()) do
        if type(v) == 'function' and getfenv(v).script == popper then
            for k2, v2 in pairs(callback2(v)) do
                if tonumber(v2) == 0.25 then
                    callback(v, k2, 0)
                elseif tonumber(v2) == 0 then
                    callback(v, k2, 0.25)
                end
            end
        end
    end
end)
addcmd('maxzoom', {}, function(list, arg2)
    arg2.CameraMaxZoomDistance = list[1]
end)
addcmd('minzoom', {}, function(list, arg2)
    arg2.CameraMinZoomDistance = list[1]
end)
addcmd('camdistance', {}, function(list, arg2)
    local cameraMaxZoomDistance = arg2.CameraMaxZoomDistance
    local cameraMinZoomDistance = arg2.CameraMinZoomDistance
    if cameraMaxZoomDistance < tonumber(list[1]) then
        cameraMaxZoomDistance = list[1]
    end
    arg2.CameraMaxZoomDistance = list[1]
    arg2.CameraMinZoomDistance = list[1]
    wait()
    arg2.CameraMaxZoomDistance = cameraMaxZoomDistance
    arg2.CameraMinZoomDistance = cameraMinZoomDistance
end)
addcmd('unlockws', {'unlockworkspace'}, function(arg1, arg2)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if not descendant:IsA('BasePart') then
            continue
        end
        descendant.Locked = false
    end
end)
addcmd('lockws', {'lockworkspace'}, function(arg1, arg2)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if not descendant:IsA('BasePart') then
            continue
        end
        descendant.Locked = true
    end
end)
addcmd('delete', {'remove'}, function(arg1, arg2)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.Name:lower() ~= getstring(1, arg1):lower() then
            continue
        end
        descendant:Destroy()
    end
    notify('Item(s) Deleted', 'Deleted ' .. getstring(1, arg1))
end)
addcmd('deleteclass', {'removeclass', 'deleteclassname', 'removeclassname', 'dc'}, function(arg1, arg2)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.ClassName:lower() ~= getstring(1, arg1):lower() then
            continue
        end
        descendant:Destroy()
    end
    notify('Item(s) Deleted', 'Deleted items with ClassName ' .. getstring(1, arg1))
end)
addcmd('chardelete', {'charremove', 'cd'}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if descendant.Name:lower() ~= getstring(1, arg1):lower() then
            continue
        end
        descendant:Destroy()
    end
    notify('Item(s) Deleted', 'Deleted ' .. getstring(1, arg1))
end)
addcmd('chardeleteclass', {'charremoveclass', 'chardeleteclassname', 'charremoveclassname', 'cdc'}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if descendant.ClassName:lower() ~= getstring(1, arg1):lower() then
            continue
        end
        descendant:Destroy()
    end
    notify('Item(s) Deleted', 'Deleted items with ClassName ' .. getstring(1, arg1))
end)
addcmd('deletevelocity', {'dv', 'removevelocity', 'removeforces'}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if not descendant:IsA('BodyVelocity') and not descendant:IsA('BodyGyro') and not descendant:IsA('RocketPropulsion') and not descendant:IsA('BodyThrust') and not descendant:IsA('BodyAngularVelocity') and not descendant:IsA('AngularVelocity') and not descendant:IsA('BodyForce') and not descendant:IsA('VectorForce') and not descendant:IsA('LineForce') then
            continue
        end
        descendant:Destroy()
    end
end)
addcmd('deleteinvisparts', {'deleteinvisibleparts', 'dip'}, function(arg1, arg2)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA('BasePart') and descendant.Transparency == 1 and descendant.CanCollide then
            descendant:Destroy()
        end
    end
end)
local list4 = {}
addcmd('invisibleparts', {'invisparts'}, function(arg1, arg2)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA('BasePart') and descendant.Transparency == 1 then
            if not table.find(list4, descendant) then
                table.insert(list4, descendant)
            end
            descendant.Transparency = 0
        end
    end
end)
addcmd('uninvisibleparts', {'uninvisparts'}, function(arg1, arg2)
    for _, v in pairs(list4) do
        v.Transparency = 1
    end
    list4 = {}
end)
addcmd('btools', {}, function(arg1, parent)
    for i = 1, 4 do
        local hopperBin = Instance.new('HopperBin')
        hopperBin.BinType = i
        hopperBin.Name = randomString()
        hopperBin.Parent = parent:FindFirstChildWhichIsA('Backpack')
    end
end)
addcmd('f3x', {'fex'}, function(arg1, arg2)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/f3x.lua'))()
end)
addcmd('partpath', {'partname'}, function(arg1, arg2)
    selectPart()
end)
local connection13
addcmd('antiafk', {'antiidle'}, function(list, arg2)
    if getconnections then
        for _, v in getconnections(arg2.Idled) do
            pcall(function()
                v:Disable()
            end)
            pcall(function()
                v:Disconnect()
            end)
        end
    end
    pcall(function()
        connection13:Disconnect()
    end)
    connection13 = arg2.Idled:Connect(function()
        local virtualInputManager = Instance.new('VirtualInputManager')
        virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        virtualInputManager:Destroy()
    end)
    if not list[1] or tostring(list[1]) ~= 'nonotify' then
        notify('Anti Idle', 'Anti idle is enabled')
    end
end)
addcmd('datalimit', {}, function(list, arg2)
    local number = tonumber(list[1])
    if number then
        Services.NetworkClient:SetOutgoingKBPSLimit(number)
    end
end)
addcmd('replicationlag', {'backtrack'}, function(list, arg2)
    if tonumber(list[1]) then
        settings():GetService('NetworkSettings').IncomingReplicationLag = list[1]
    end
end)
addcmd('noprompts', {'nopurchaseprompts'}, function(arg1, arg2)
    COREGUI.PurchasePromptApp.Enabled = false
end)
addcmd('showprompts', {'showpurchaseprompts'}, function(arg1, arg2)
    COREGUI.PurchasePromptApp.Enabled = true
end)
promptNewRig = function(player, arg2)
    local humanoid2 = player.Character:FindFirstChildWhichIsA('Humanoid')
    if humanoid2 then
        AvatarEditorService:PromptSaveAvatar(humanoid2.HumanoidDescription, Enum.HumanoidRigType[arg2])
        local result = AvatarEditorService.PromptSaveAvatarCompleted:Wait()
        if result == Enum.AvatarPromptResult.Success then
            execCmd('reset')
        end
    end
end
addcmd('promptr6', {}, function(arg1, arg2)
    promptNewRig(arg2, 'R6')
end)
addcmd('promptr15', {}, function(arg1, arg2)
    promptNewRig(arg2, 'R15')
end)
addcmd('wallwalk', {'walkonwalls'}, function(arg1, arg2)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/wallwalker.lua'))()
end)
addcmd('age', {}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    local list2 = {}
    for _, v in pairs(player) do
        local player2 = Players[v]
        table.insert(list2, player2.Name .. '\'s age is: ' .. player2.AccountAge)
    end
    notify('Account Age', table.concat(list2, ',\n'))
end)
addcmd('chatage', {}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    local list2 = {}
    for _, v in pairs(player) do
        local player2 = Players[v]
        table.insert(list2, player2.Name .. '\'s age is: ' .. player2.AccountAge)
    end
    local joined = table.concat(list2, ', ')
    chatMessage(joined)
end)
addcmd('joindate', {'jd'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    local list2 = {}
    for _, v in pairs(player) do
        local player2 = Players[v]
        local v1 = player2.AccountAge * 24 * 60 * 60
        local timestamp = os.time()
        local item = player2.Name .. ' joined: ' .. os.date('%m/%d/%y', timestamp - v1)
        table.insert(list2, item)
    end
    notify('Join Date (Month/Day/Year)', table.concat(list2, ',\n'))
end)
addcmd('chatjoindate', {'cjd'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    local list2 = {}
    for _, v in pairs(player) do
        local player2 = Players[v]
        local v1 = player2.AccountAge * 24 * 60 * 60
        local timestamp = os.time()
        local item = player2.Name .. ' joined: ' .. os.date('%m/%d/%y', timestamp - v1)
        table.insert(list2, item)
    end
    local joined = table.concat(list2, ', ')
    chatMessage(joined)
end)
addcmd('copyname', {'copyuser'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        local text = tostring(Players[v].Name)
        toClipboard(text)
    end
end)
addcmd('userid', {'id'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        local text = tostring(Players[v].UserId)
        notify('User ID', text)
    end
end)
addcmd('copyplaceid', {'placeid'}, function(arg1, arg2)
    toClipboard(PlaceId)
end)
addcmd('copygameid', {'gameid'}, function(arg1, arg2)
    toClipboard(game.GameId)
end)
addcmd('copyid', {'copyuserid'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        local text = tostring(Players[v].UserId)
        toClipboard(text)
    end
end)
addcmd('creatorid', {'creator'}, function(arg1, player)
    if game.CreatorType == Enum.CreatorType.User then
        notify('Creator ID', game.CreatorId)
        return
    end
    if game.CreatorType == Enum.CreatorType.Group then
        local id = GroupService:GetGroupInfoAsync(game.CreatorId).Owner.Id
        player.UserId = id
        notify('Creator ID', id)
    end
end)
addcmd('copycreatorid', {'copycreator'}, function(arg1, arg2)
    if game.CreatorType == Enum.CreatorType.User then
        toClipboard(game.CreatorId)
        notify('Copied ID', 'Copied creator ID to clipboard')
        return
    end
    if game.CreatorType == Enum.CreatorType.Group then
        local id = GroupService:GetGroupInfoAsync(game.CreatorId).Owner.Id
        toClipboard(id)
        notify('Copied ID', 'Copied creator ID to clipboard')
    end
end)
addcmd('setcreatorid', {'setcreator'}, function(arg1, player)
    if game.CreatorType == Enum.CreatorType.User then
        player.UserId = game.CreatorId
        notify('Set ID', 'Set UserId to ' .. game.CreatorId)
        return
    end
    if game.CreatorType == Enum.CreatorType.Group then
        local id = GroupService:GetGroupInfoAsync(game.CreatorId).Owner.Id
        player.UserId = id
        notify('Set ID', 'Set UserId to ' .. id)
    end
end)
addcmd('appearanceid', {'aid'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        local text = tostring(Players[v].CharacterAppearanceId)
        notify('Appearance ID', text)
    end
end)
addcmd('copyappearanceid', {'caid'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        local text = tostring(Players[v].CharacterAppearanceId)
        toClipboard(text)
    end
end)
addcmd('norender', {}, function(arg1, arg2)
    RunService:Set3dRenderingEnabled(false)
end)
addcmd('render', {}, function(arg1, arg2)
    RunService:Set3dRenderingEnabled(true)
end)
addcmd('2022materials', {'use2022materials'}, function(arg1, arg2)
    if sethidden then
        sethidden(MaterialService, 'Use2022Materials', true)
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing sethiddenproperty)')
end)
addcmd('un2022materials', {'unuse2022materials'}, function(arg1, arg2)
    if sethidden then
        sethidden(MaterialService, 'Use2022Materials', false)
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing sethiddenproperty)')
end)
addcmd('goto', {'to'}, function(list, player)
    local parent = player and player.Character
    local humanoid2 = parent and parent:FindFirstChildWhichIsA('Humanoid')
    if humanoid2 == nil then
        return
    else
        if humanoid2 and humanoid2.SeatPart then
            humanoid2.Sit = false
            task.wait(0.1)
        end
        local boolean = parseBoolean(list[2], false)
        for _, v in getPlayer(list[1], player) do
            local character = Players[v].Character
            if character == nil then
                continue
            end
            local pivot = character:GetPivot()
            local position = pivot.Position
            if boolean and workspace.StreamingEnabled then
                task.spawn(player.RequestStreamAroundAsync, player, position, 5)
                character:WaitForChild('HumanoidRootPart', 5)
            end
            player.Character:PivotTo(CFrame.new(position + pivot.LookVector * 3, position))
            breakVelocity()
            return
        end
    end
end)
addcmd('tweengoto', {'tgoto', 'tto', 'tweento'}, function(list, player)
    local parent = player and player.Character
    local humanoid2 = parent and parent:FindFirstChildWhichIsA('Humanoid')
    local value = humanoid2 and humanoid2:GetStateEnabled(Enum.HumanoidStateType.Seated)
    if humanoid2 then
        humanoid2:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    end
    local player2 = getPlayer(list[1], player)
    for _, v in pairs(player2) do
        if Players[v].Character == nil then
            continue
        end
        if humanoid2 and humanoid2.SeatPart then
            humanoid2.Sit = false
            task.wait(0.1)
        end
        TweenService:Create(getRoot(player.Character), TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = getRoot(Players[v].Character):GetPivot() + Vector3.new(3, 1, 0)}):Play()
    end
    execCmd('breakvelocity')
    if type(value) == 'boolean' then
        humanoid2:SetStateEnabled(Enum.HumanoidStateType.Seated, value)
    end
end)
addcmd('vehiclegoto', {'vgoto', 'vtp', 'vehicletp'}, function(list, player)
    local v1 = if player.Character then player.Character:FindFirstChildOfClass('Humanoid') else nil
    if not v1 then
        return
    else
        local model = if v1.SeatPart then v1.SeatPart:FindFirstAncestorWhichIsA('Model') else nil
        if model == nil then
            notify('Vehicle Goto', 'Make sure you\'re sitting in a vehicle.')
            return
        end
        for _, v in getPlayer(list[1], player) do
            if Players[v].Character == nil then
                continue
            end
            local root = getRoot(Players[v].Character)
            if root == nil then
                continue
            end
            model:PivotTo(root:GetPivot())
            return
        end
    end
end)
addcmd('pulsetp', {'ptp'}, function(list, player)
    local player2 = getPlayer(list[1], player)
    for _, v in pairs(player2) do
        if Players[v].Character == nil then
            continue
        end
        local cframe = getRoot(player.Character).CFrame
        local seconds = list[2] or 1
        if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
            player.Character:FindFirstChildOfClass('Humanoid').Sit = false
            wait(0.1)
        end
        getRoot(player.Character).CFrame = getRoot(Players[v].Character).CFrame + Vector3.new(3, 1, 0)
        wait(seconds)
        getRoot(player.Character).CFrame = cframe
    end
    execCmd('breakvelocity')
end)
local list5 = {}
addcmd('vehiclenoclip', {'vnoclip'}, function(arg1, player)
    list5 = {}
    local seatPart = player.Character:FindFirstChildOfClass('Humanoid').SeatPart
    local parent = seatPart.Parent
    repeat
        if parent.ClassName == 'Model' then
            continue
        end
        parent = parent.Parent
    until parent.ClassName == 'Model'
    wait(0.1)
    execCmd('noclip')
    for _, descendant in pairs(parent:GetDescendants()) do
        if descendant:IsA('BasePart') and descendant.CanCollide then
            table.insert(list5, descendant)
            descendant.CanCollide = false
        end
    end
end)
addcmd('vehicleclip', {'vclip', 'unvnoclip', 'unvehiclenoclip'}, function(arg1, arg2)
    execCmd('clip')
    for _, v in pairs(list5) do
        v.CanCollide = true
    end
    list5 = {}
end)
addcmd('togglevnoclip', {}, function(arg1, arg2)
    execCmd(Clip and 'vnoclip' or 'vclip')
end)
addcmd('clientbring', {'cbring'}, function(list, player)
    local player2 = getPlayer(list[1], player)
    for _, v in pairs(player2) do
        if Players[v].Character == nil then
            continue
        end
        if Players[v].Character:FindFirstChildOfClass('Humanoid') then
            Players[v].Character:FindFirstChildOfClass('Humanoid').Sit = false
        end
        wait()
        getRoot(Players[v].Character).CFrame = getRoot(player.Character).CFrame + Vector3.new(3, 1, 0)
    end
end)
local list6 = {}
addcmd('loopbring', {}, function(list, player)
    local player2 = getPlayer(list[1], player)
    for _, v in pairs(player2) do
        task.spawn(function()
            if Players[v].Name ~= player.Name and not FindInTable(list6, Players[v].Name) then
                table.insert(list6, Players[v].Name)
                local name = Players[v].Name
                local character, second = Players[v].Character, 3
                if list[2] and isNumber(list[2]) then
                    second = list[2]
                end
                local third = 0
                if list[3] and isNumber(list[3]) then
                    third = list[3]
                end
                repeat
                    for _, _ in pairs(player2) do
                        if Players:FindFirstChild(v) then
                            local character2 = Players[v].Character
                            if character2 ~= nil and Players[v].Character ~= nil and getRoot(character2) and player.Character ~= nil and getRoot(player.Character) then
                                getRoot(character2).CFrame = getRoot(player.Character).CFrame + Vector3.new(second, 1, 0)
                            end
                            wait(third)
                        else
                            for k2, v3 in pairs(list6) do
                                if v3 ~= name then
                                    continue
                                end
                                table.remove(list6, k2)
                            end
                        end
                    end
                until not FindInTable(list6, name)
            end
        end)
    end
end)
addcmd('unloopbring', {'noloopbring'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for k, v in pairs(player) do
        task.spawn(function()
            for k, v2 in pairs(list6) do
                if v2 ~= Players[v].Name then
                    continue
                end
                table.remove(list6, k)
            end
        end)
    end
end)
local flag11 = false
local flag12 = false
addcmd('walkto', {'follow'}, function(list, player)
    local player2 = getPlayer(list[1], player)
    for _, v in pairs(player2) do
        if Players[v].Character == nil then
            continue
        end
        if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
            player.Character:FindFirstChildOfClass('Humanoid').Sit = false
            wait(0.1)
        end
        flag11 = true
        repeat
            wait()
            player.Character:FindFirstChildOfClass('Humanoid'):MoveTo(getRoot(Players[v].Character).Position)
        until Players[v].Character == nil or not getRoot(Players[v].Character) or flag11 == false
    end
end)
addcmd('pathfindwalkto', {'pathfindfollow'}, function(list, player)
    flag11 = false
    wait()
    local player2 = getPlayer(list[1], player)
    local humanoid2 = Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
    local path = PathService:CreatePath()
    for _, v in pairs(player2) do
        if Players[v].Character == nil then
            continue
        end
        if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
            player.Character:FindFirstChildOfClass('Humanoid').Sit = false
            wait(0.1)
        end
        flag11 = true
        repeat
            wait()
            local success, result = pcall(function()
                path:ComputeAsync(getRoot(player.Character).Position, getRoot(Players[v].Character).Position)
                local waypoints = path:GetWaypoints()
                local magnitude
                for _, waypoint in pairs(waypoints) do
                    local position = waypoint.Position
                    humanoid2:MoveTo(position)
                    repeat
                        magnitude = (position - humanoid2.Parent.PrimaryPart.Position).magnitude
                        wait()
                    until magnitude <= 5
                end
            end)
            if success then
                continue
            end
            player.Character:FindFirstChildOfClass('Humanoid'):MoveTo(getRoot(Players[v].Character).Position)
        until Players[v].Character == nil or not getRoot(Players[v].Character) or flag11 == false
    end
end)
addcmd('pathfindwalktowaypoint', {'pathfindwalktowp'}, function(arg1, player)
    flag12 = false
    wait()
    local text = tostring(getstring(1, arg1))
    local humanoid2 = Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
    local path = PathService:CreatePath()
    if player.Character then
        for k, _ in pairs(WayPoints) do
            if tostring(WayPoints[k].NAME):lower() ~= tostring(text):lower() then
                continue
            end
            if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                player.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(0.1)
            end
            local vector3 = Vector3.new(WayPoints[k].COORD[1], WayPoints[k].COORD[2], WayPoints[k].COORD[3])
            flag12 = true
            repeat
                wait()
                local success, result = pcall(function()
                    path:ComputeAsync(getRoot(player.Character).Position, vector3)
                    local waypoints = path:GetWaypoints()
                    local magnitude
                    for _, waypoint in pairs(waypoints) do
                        local position = waypoint.Position
                        humanoid2:MoveTo(position)
                        repeat
                            magnitude = (position - humanoid2.Parent.PrimaryPart.Position).magnitude
                            wait()
                        until magnitude <= 5
                    end
                end)
                if success then
                    continue
                end
                player.Character:FindFirstChildOfClass('Humanoid'):MoveTo(vector3)
            until not player.Character or flag12 == false
        end
        for k, _ in pairs(pWayPoints) do
            if tostring(pWayPoints[k].NAME):lower() ~= tostring(text):lower() then
                continue
            end
            if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                player.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(0.1)
            end
            local position = pWayPoints[k].COORD[1].Position
            flag12 = true
            repeat
                wait()
                local success2, result2 = pcall(function()
                    path:ComputeAsync(getRoot(player.Character).Position, position)
                    local waypoints = path:GetWaypoints()
                    local magnitude
                    for _, waypoint in pairs(waypoints) do
                        local position2 = waypoint.Position
                        humanoid2:MoveTo(position2)
                        repeat
                            magnitude = (position2 - humanoid2.Parent.PrimaryPart.Position).magnitude
                            wait()
                        until magnitude <= 5
                    end
                end)
                if success2 then
                    continue
                end
                player.Character:FindFirstChildOfClass('Humanoid'):MoveTo(position)
            until not player.Character or flag12 == false
        end
    end
end)
addcmd('unwalkto', {'nowalkto', 'unfollow', 'nofollow'}, function(arg1, arg2)
    flag11 = false
    flag12 = false
end)
addcmd('orbit', {}, function(list, player)
    execCmd('unorbit nonotify')
    local firstChild = Players:FindFirstChild(getPlayer(list[1], player)[1])
    local root = getRoot(player.Character)
    local humanoid2 = player.Character:FindFirstChildWhichIsA('Humanoid')
    if firstChild and firstChild.Character and getRoot(firstChild.Character) and root and humanoid2 then
        local num = 0
        local v1 = tonumber(list[2]) or 0.2
        local position = tonumber(list[3]) or 6
        orbit1 = RunService.Stepped:Connect(function()
            breakVelocity()
            num = num + v1
            local position2 = getRoot(firstChild.Character).Position
            local position3 = (CFrame.new(position2) * CFrame.Angles(0, math.rad(num), 0) * CFrame.new(position, 0, 0)).Position
            root.CFrame = CFrame.lookAt(position3, Vector3.new(position2.X, position3.Y, position2.Z))
        end)
        orbit2 = humanoid2.Died:Connect(function()
            execCmd('unorbit')
        end)
        orbit3 = humanoid2.Seated:Connect(function(active)
            if active then
                execCmd('unorbit')
            end
        end)
        notify('Orbit', 'Started orbiting ' .. formatUsername(firstChild))
    end
end)
addcmd('unorbit', {}, function(list, arg2)
    if orbit1 then
        orbit1:Disconnect()
    end
    if orbit2 then
        orbit2:Disconnect()
    end
    if orbit3 then
        orbit3:Disconnect()
    end
    if list[1] ~= 'nonotify' then
        notify('Orbit', 'Stopped orbiting player')
    end
end)
addcmd('freeze', {'fr'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    if player ~= nil then
        for _, v in pairs(player) do
            task.spawn(function()
                for _, descendant in next, Players[v].Character:GetDescendants() do
                    if descendant:IsA('BasePart') and not descendant.Anchored then
                        descendant.Anchored = true
                    end
                end
            end)
        end
    end
end)
addcmd('thaw', {'unfreeze', 'unfr'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    if player ~= nil then
        for _, v in pairs(player) do
            task.spawn(function()
                for _, descendant in next, Players[v].Character:GetDescendants() do
                    if descendant.Name ~= floatName and descendant:IsA('BasePart') and descendant.Anchored then
                        descendant.Anchored = false
                    end
                end
            end)
        end
    end
end)
addcmd('anchor', {}, function(arg1, player)
    getRoot(player.Character).Anchored = true
end)
addcmd('unanchor', {}, function(arg1, player)
    getRoot(player.Character).Anchored = false
end)
oofing = false
addcmd('loopoof', {}, function(arg1, arg2)
    oofing = true
    repeat
        wait(0.1)
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character ~= nil and player.Character:FindFirstChild('Head') then
                for _, child in pairs(player.Character.Head:GetChildren()) do
                    if not child:IsA('Sound') then
                        continue
                    end
                    child.Playing = true
                end
            end
        end
    until oofing == false
end)
addcmd('unloopoof', {}, function(arg1, arg2)
    oofing = false
end)
local flag13 = false
addcmd('muteboombox', {}, function(list, arg2)
    if not flag13 and SoundService.RespectFilteringEnabled then
        flag13 = true
        notify('RespectFilteringEnabled', 'RespectFilteringEnabled is set to true (the command will still work but may only be clientsided)')
    end
    local player = getPlayer(list[1], arg2)
    if player ~= nil then
        for _, v in pairs(player) do
            task.spawn(function()
                for _, descendant in next, Players[v].Character:GetDescendants() do
                    if descendant:IsA('Sound') and descendant.Playing == true then
                        descendant.Playing = false
                    end
                end
                for _, v2 in next, Players[v]:FindFirstChildOfClass('Backpack'):GetDescendants() do
                    if v2:IsA('Sound') and v2.Playing == true then
                        v2.Playing = false
                    end
                end
            end)
        end
    end
end)
addcmd('unmuteboombox', {}, function(list, arg2)
    if not flag13 and SoundService.RespectFilteringEnabled then
        flag13 = true
        notify('RespectFilteringEnabled', 'RespectFilteringEnabled is set to true (the command will still work but may only be clientsided)')
    end
    local player = getPlayer(list[1], arg2)
    if player ~= nil then
        for _, v in pairs(player) do
            task.spawn(function()
                for _, descendant in next, Players[v].Character:GetDescendants() do
                    if descendant:IsA('Sound') and descendant.Playing == false then
                        descendant.Playing = true
                    end
                end
            end)
        end
    end
end)
addcmd('reset', {}, function(arg1, player)
    local humanoid2 = player.Character and player.Character:FindFirstChildWhichIsA('Humanoid')
    if humanoid2 then
        humanoid2:ChangeState(Enum.HumanoidStateType.Dead)
        return
    end
    player.Character:BreakJoints()
end)
addcmd('freezeanims', {}, function(arg1, player)
    local humanoid2 = player.Character:FindFirstChildOfClass('Humanoid') or player.Character:FindFirstChildOfClass('AnimationController')
    local playingAnimationTracks = humanoid2:GetPlayingAnimationTracks()
    for _, playingAnimationTrack in pairs(playingAnimationTracks) do
        playingAnimationTrack:AdjustSpeed(0)
    end
end)
addcmd('unfreezeanims', {}, function(arg1, player)
    local humanoid2 = player.Character:FindFirstChildOfClass('Humanoid') or player.Character:FindFirstChildOfClass('AnimationController')
    local playingAnimationTracks = humanoid2:GetPlayingAnimationTracks()
    for _, playingAnimationTrack in pairs(playingAnimationTracks) do
        playingAnimationTrack:AdjustSpeed(1)
    end
end)
addcmd('respawn', {}, function(arg1, arg2)
    respawn(arg2)
end)
addcmd('refresh', {'re'}, function(arg1, arg2)
    refresh(arg2)
end)
addcmd('god', {}, function(arg1, player)
    local currentCamera = workspace.CurrentCamera
    local character = player.Character
    local cframe, template = currentCamera.CFrame, character and character:FindFirstChildWhichIsA('Humanoid')
    local clone = template:Clone()
    clone.Parent = char
    player.Character = nil
    clone:SetStateEnabled(15, false)
    clone:SetStateEnabled(1, false)
    clone:SetStateEnabled(0, false)
    clone.BreakJointsOnDeath = true
    template:Destroy()
    player.Character = char
    currentCamera.CameraSubject = clone
    currentCamera.CFrame = task.wait() and pos
    clone.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    local animate = character:FindFirstChild('Animate')
    if animate then
        animate.Disabled = true
        task.wait()
        animate.Disabled = false
    end
    clone.Health = clone.MaxHealth
end)
invisRunning = false
addcmd('invisible', {'invis'}, function(arg1, player)
    if invisRunning then
        return
    end
    invisRunning = true
    repeat
        wait(0.1)
    until player.Character
    local character = player.Character
    character.Archivable = true
    local flag = false
    local flag2 = true
    local clone = character:Clone()
    clone.Parent = Lighting
    local fallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight
    clone.Name = ''
    local cframe
    local connection = RunService.Stepped:Connect(function()
        pcall(function()
            local v1
            v1 = tostring(fallenPartsDestroyHeight):find('-') and true or false
            local position = player.Character.Humanoid.RootPart.Position
            local text = tostring(position)
            local list = text:split(', ')
            local _ = tonumber(list[1])
            local number = tonumber(list[2])
            local _ = tonumber(list[3])
            if v1 == true then
                if number <= fallenPartsDestroyHeight then
                    Respawn()
                end
            elseif v1 == false and fallenPartsDestroyHeight <= number then
                Respawn()
            end
        end)
    end)
    for _, descendant in pairs(clone:GetDescendants()) do
        if not descendant:IsA('BasePart') then
            continue
        end
        if descendant.Name == 'HumanoidRootPart' then
            descendant.Transparency = 1
        else
            descendant.Transparency = 0.5
        end
    end
    Respawn = function()
        flag2 = false
        if flag == true then
            pcall(function()
                player.Character = character
                wait()
                character.Parent = workspace
                character:FindFirstChildWhichIsA('Humanoid'):Destroy()
                flag = false
                clone.Parent = nil
                invisRunning = false
            end)
            return
        end
        if flag == false then
            pcall(function()
                player.Character = character
                wait()
                character.Parent = workspace
                character:FindFirstChildWhichIsA('Humanoid'):Destroy()
                TurnVisible()
            end)
        end
    end
    local connection2
    connection2 = clone:FindFirstChildOfClass('Humanoid').Died:Connect(function()
        Respawn()
        connection2:Disconnect()
    end)
    if flag == true then
        return
    end
    flag = true
    cframe = workspace.CurrentCamera.CFrame
    local cframe2 = player.Character.Humanoid.RootPart.CFrame
    character:MoveTo(Vector3.new(0, math.pi * 1000000, 0))
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    wait(0.2)
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    character.Parent = Lighting
    clone.Parent = workspace
    clone.Humanoid.RootPart.CFrame = cframe2
    player.Character = clone
    execCmd('fixcam')
    player.Character.Animate.Disabled = true
    player.Character.Animate.Disabled = false
    TurnVisible = function()
        if flag == false then
            return
        end
        connection:Disconnect()
        connection2:Disconnect()
        cframe = workspace.CurrentCamera.CFrame
        character = character
        local cframe2 = player.Character.Humanoid.RootPart.CFrame
        character.Humanoid.RootPart.CFrame = cframe2
        clone:Destroy()
        player.Character = character
        character.Parent = workspace
        flag = false
        player.Character.Animate.Disabled = true
        player.Character.Animate.Disabled = false
        connection2 = character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
            Respawn()
            connection2:Disconnect()
        end)
        invisRunning = false
    end
    notify('Invisible', 'You now appear invisible to other players')
end)
addcmd('visible', {'vis', 'uninvisible'}, function(arg1, arg2)
    TurnVisible()
end)
addcmd('toggleinvis', {}, function(arg1, arg2)
    execCmd(invisRunning and 'visible' or 'invisible')
end)
addcmd('toolinvisible', {'toolinvis', 'tinvis'}, function(arg1, arg2)
    local character = Players.LocalPlayer.Character
    local flag = false
    local part = Instance.new('Part')
    part.Anchored = true
    part.CanCollide = true
    part.Size = Vector3.new(10, 1, 10)
    part.Position = Vector3.new(0, 10000, 0)
    part.Parent = workspace
    local connection = part.Touched:connect(function(instance)
        if instance.Parent.Name == Players.LocalPlayer.Name and flag == false then
            flag = true
            local function apply()
                local clone = character.Humanoid.RootPart:Clone()
                task.wait(0.25)
                character.Humanoid.RootPart:Destroy()
                clone.Parent = character
                character:MoveTo(loc)
                flag = false
            end
            if character then
                apply()
            end
        end
    end)
    repeat
        wait()
    until character
    local connection2
    connection2 = Players.LocalPlayer.CharacterAdded:connect(function(arg1)
        connection:Disconnect()
        part:Destroy()
        connection2:Disconnect()
    end)
    loc = character.Humanoid.RootPart.Position
    character:MoveTo(part.Position + Vector3.new(0, 0.5, 0))
end)
addcmd('strengthen', {}, function(list, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if descendant.ClassName ~= 'Part' then
            continue
        end
        if list[1] then
            descendant.CustomPhysicalProperties = PhysicalProperties.new(list[1], 0.3, 0.5)
        else
            descendant.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
        end
    end
end)
addcmd('weaken', {}, function(list, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if descendant.ClassName ~= 'Part' then
            continue
        end
        if list[1] then
            descendant.CustomPhysicalProperties = PhysicalProperties.new(-list[1], 0.3, 0.5)
        else
            descendant.CustomPhysicalProperties = PhysicalProperties.new(0, 0.3, 0.5)
        end
    end
end)
addcmd('unweaken', {'unstrengthen'}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if descendant.ClassName ~= 'Part' then
            continue
        end
        descendant.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
    end
end)
addcmd('breakvelocity', {}, function(arg1, player)
    local flag = false
    local vector3 = Vector3.new(0, 0, 0)
    delay(1, function()
        flag = true
    end)
    while not flag do
        for _, descendant in ipairs(player.Character:GetDescendants()) do
            if not descendant:IsA('BasePart') then
                continue
            end
            descendant.Velocity = vector3
            descendant.RotVelocity = vector3
        end
        wait()
    end
end)
addcmd('jpower', {'jumppower', 'jp'}, function(list, player)
    local jumpPower = list[1] or 50
    if isNumber(jumpPower) then
        if player.Character:FindFirstChildOfClass('Humanoid').UseJumpPower then
            player.Character:FindFirstChildOfClass('Humanoid').JumpPower = jumpPower
            return
        end
        player.Character:FindFirstChildOfClass('Humanoid').JumpHeight = jumpPower
    end
end)
addcmd('maxslopeangle', {'msa'}, function(list, player)
    local maxSlopeAngle = list[1] or 89
    if isNumber(maxSlopeAngle) then
        player.Character:FindFirstChildWhichIsA('Humanoid').MaxSlopeAngle = maxSlopeAngle
    end
end)
addcmd('gravity', {'grav'}, function(list, arg2)
    local gravity2 = list[1] or gravity
    if isNumber(gravity2) then
        workspace.Gravity = gravity2
    end
end)
addcmd('hipheight', {'hheight'}, function(list, player)
    local hipHeight = list[1] or r15(player) and 2.1 or 0
    if isNumber(hipHeight) then
        player.Character:FindFirstChildWhichIsA('Humanoid').HipHeight = hipHeight
    end
end)
addcmd('dance', {}, function(arg1, player)
    pcall(execCmd, 'undance')
    local names = {'27789359', '30196114', '248263260', '45834924', '33796059', '28488254', '52155728'}
    if r15(player) then
        names = {'3333432454', '4555808220', '4049037604', '4555782893', '10214311282', '10714010337', '10713981723', '10714372526', '10714076981', '10714392151', '11444443576'}
    end
    local animation = Instance.new('Animation')
    animation.AnimationId = 'rbxassetid://' .. names[math.random(1, #names)]
    danceTrack = player.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(animation)
    danceTrack.Looped = true
    danceTrack:Play()
end)
addcmd('undance', {'nodance'}, function(arg1, arg2)
    danceTrack:Stop()
    danceTrack:Destroy()
end)
addcmd('nolimbs', {'rlimbs'}, function(arg1, player)
    if r15(player) then
        for _, child in pairs(player.Character:GetChildren()) do
            if child:IsA('BasePart') and child.Name == 'RightUpperLeg' or child.Name == 'LeftUpperLeg' or child.Name == 'RightUpperArm' or child.Name == 'LeftUpperArm' then
                child:Destroy()
            end
        end
        return
    end
    for _, child in pairs(player.Character:GetChildren()) do
        if child:IsA('BasePart') and child.Name == 'Right Leg' or child.Name == 'Left Leg' or child.Name == 'Right Arm' or child.Name == 'Left Arm' then
            child:Destroy()
        end
    end
end)
addcmd('noarms', {'rarms'}, function(arg1, player)
    if r15(player) then
        for _, child in pairs(player.Character:GetChildren()) do
            if child:IsA('BasePart') and child.Name == 'RightUpperArm' or child.Name == 'LeftUpperArm' then
                child:Destroy()
            end
        end
        return
    end
    for _, child in pairs(player.Character:GetChildren()) do
        if child:IsA('BasePart') and child.Name == 'Right Arm' or child.Name == 'Left Arm' then
            child:Destroy()
        end
    end
end)
addcmd('nolegs', {'rlegs'}, function(arg1, player)
    if r15(player) then
        for _, child in pairs(player.Character:GetChildren()) do
            if child:IsA('BasePart') and child.Name == 'RightUpperLeg' or child.Name == 'LeftUpperLeg' then
                child:Destroy()
            end
        end
        return
    end
    for _, child in pairs(player.Character:GetChildren()) do
        if child:IsA('BasePart') and child.Name == 'Right Leg' or child.Name == 'Left Leg' then
            child:Destroy()
        end
    end
end)
addcmd('sit', {}, function(arg1, player)
    player.Character:FindFirstChildWhichIsA('Humanoid').Sit = true
end)
addcmd('lay', {'laydown'}, function(arg1, player)
    local humanoid2 = player.Character:FindFirstChildWhichIsA('Humanoid')
    humanoid2.Sit = true
    task.wait(0.1)
    humanoid2.RootPart.CFrame = humanoid2.RootPart.CFrame * CFrame.Angles(math.pi * 0.5, 0, 0)
    for _, track in ipairs(humanoid2:GetPlayingAnimationTracks()) do
        track:Stop()
    end
end)
addcmd('sitwalk', {}, function(arg1, player)
    local animate = player.Character.Animate
    local animationId = animate.sit:FindFirstChildWhichIsA('Animation').AnimationId
    animate.idle:FindFirstChildWhichIsA('Animation').AnimationId = animationId
    animate.walk:FindFirstChildWhichIsA('Animation').AnimationId = animationId
    animate.run:FindFirstChildWhichIsA('Animation').AnimationId = animationId
    animate.jump:FindFirstChildWhichIsA('Animation').AnimationId = animationId
    player.Character:FindFirstChildWhichIsA('Humanoid').HipHeight = not r15(player) and -1.5 or 0.5
end)
addcmd('nosit', {}, function(arg1, player)
    player.Character:FindFirstChildWhichIsA('Humanoid'):SetStateEnabled(Enum.HumanoidStateType.Seated, false)
end)
addcmd('unnosit', {}, function(arg1, player)
    player.Character:FindFirstChildWhichIsA('Humanoid'):SetStateEnabled(Enum.HumanoidStateType.Seated, true)
end)
addcmd('jump', {}, function(arg1, player)
    player.Character:FindFirstChildWhichIsA('Humanoid'):ChangeState(Enum.HumanoidStateType.Jumping)
end)
local connection14
infJumpDebounce = false
addcmd('infjump', {'infinitejump'}, function(arg1, player)
    if connection14 then
        connection14:Disconnect()
    end
    infJumpDebounce = false
    connection14 = UserInputService.JumpRequest:Connect(function()
        if not infJumpDebounce then
            infJumpDebounce = true
            player.Character:FindFirstChildWhichIsA('Humanoid'):ChangeState(Enum.HumanoidStateType.Jumping)
            wait()
            infJumpDebounce = false
        end
    end)
end)
addcmd('uninfjump', {'uninfinitejump', 'noinfjump', 'noinfinitejump'}, function(arg1, arg2)
    if connection14 then
        connection14:Disconnect()
    end
    infJumpDebounce = false
end)
local connection15
addcmd('flyjump', {}, function(arg1, player)
    if connection15 then
        connection15:Disconnect()
    end
    connection15 = UserInputService.JumpRequest:Connect(function()
        player.Character:FindFirstChildWhichIsA('Humanoid'):ChangeState(Enum.HumanoidStateType.Jumping)
    end)
end)
addcmd('unflyjump', {'noflyjump'}, function(arg1, arg2)
    if connection15 then
        connection15:Disconnect()
    end
end)
local tbl = {}
addcmd('autojump', {'ajump'}, function(arg1, player)
    local character = player.Character
    local humanoid2 = character and character:FindFirstChildWhichIsA('Humanoid')
    local function autoJump()
        if character and humanoid2 then
            local partOnRay = workspace:FindPartOnRay(Ray.new(humanoid2.RootPart.Position - Vector3.new(0, 1.5, 0), humanoid2.RootPart.CFrame.lookVector * 3), humanoid2.Parent)
            local partOnRay2 = workspace:FindPartOnRay(Ray.new(humanoid2.RootPart.Position + Vector3.new(0, 1.5, 0), humanoid2.RootPart.CFrame.lookVector * 3), humanoid2.Parent)
            if partOnRay or partOnRay2 then
                humanoid2.Jump = true
            end
        end
    end
    autoJump()
    local tbl2 = tbl
    if tbl.ajLoop and tbl.ajLoop:Disconnect() then
    end
    tbl2.ajLoop = RunService.RenderStepped:Connect(autoJump)
    local tbl3 = tbl
    if tbl.ajCA and tbl.ajCA:Disconnect() then
    end
    tbl3.ajCA = player.CharacterAdded:Connect(function(character2)
        local humanoid3 = character2:WaitForChild('Humanoid')
        character = character2
        humanoid2 = humanoid3
        autoJump()
        local tbl2 = tbl
        if tbl.ajLoop and tbl.ajLoop:Disconnect() then
        end
        tbl2.ajLoop = RunService.RenderStepped:Connect(autoJump)
    end)
end)
addcmd('unautojump', {'noautojump', 'noajump', 'unajump'}, function(arg1, arg2)
    local tbl2 = tbl
    if tbl.ajLoop and tbl.ajLoop:Disconnect() then
    end
    tbl2.ajLoop = nil
    local tbl3 = tbl
    if tbl.ajCA and tbl.ajCA:Disconnect() then
    end
    tbl3.ajCA = nil
end)
addcmd('edgejump', {'ejump'}, function(arg1, player)
    local character = player.Character
    local humanoid2 = character and character:FindFirstChildWhichIsA('Humanoid')
    local v1
    local v2
    local cframe
    local function edgejump()
        if character and humanoid2 then
            v2 = v1
            v1 = humanoid2:GetState()
            if v2 ~= v1 and v1 == Enum.HumanoidStateType.Freefall and v2 ~= Enum.HumanoidStateType.Jumping then
                character.Humanoid.RootPart.CFrame = cframe
                character.Humanoid.RootPart.Velocity = Vector3.new(character.Humanoid.RootPart.Velocity.X, humanoid2.JumpPower or humanoid2.JumpHeight, character.Humanoid.RootPart.Velocity.Z)
            end
            cframe = character.Humanoid.RootPart.CFrame
        end
    end
    edgejump()
    local tbl2 = tbl
    if tbl.ejLoop and tbl.ejLoop:Disconnect() then
    end
    tbl2.ejLoop = RunService.RenderStepped:Connect(edgejump)
    local tbl3 = tbl
    if tbl.ejCA and tbl.ejCA:Disconnect() then
    end
    tbl3.ejCA = player.CharacterAdded:Connect(function(character2)
        local humanoid3 = character2:WaitForChild('Humanoid')
        character = character2
        humanoid2 = humanoid3
        edgejump()
        local tbl2 = tbl
        if tbl.ejLoop and tbl.ejLoop:Disconnect() then
        end
        tbl2.ejLoop = RunService.RenderStepped:Connect(edgejump)
    end)
end)
addcmd('unedgejump', {'noedgejump', 'noejump', 'unejump'}, function(arg1, arg2)
    local tbl2 = tbl
    if tbl.ejLoop and tbl.ejLoop:Disconnect() then
    end
    tbl2.ejLoop = nil
    local tbl3 = tbl
    if tbl.ejCA and tbl.ejCA:Disconnect() then
    end
    tbl3.ejCA = nil
end)
addcmd('team', {}, function(arg1, player)
    local text = getstring(1, arg1)
    local team
    local root = player.Character and getRoot(player.Character)
    for _, child in ipairs(Teams:GetChildren()) do
        if not child.Name:lower():match(text:lower()) then
            continue
        end
        team = child
        break
    end
    if not team then
        return notify('Invalid Team', text .. ' is not a valid team')
    end
    if root and firetouchinterest then
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA('SpawnLocation') and descendant.BrickColor == team.TeamColor and descendant.AllowTeamChangeOnTouch == true then
                firetouchinterest(descendant, root, 0)
                firetouchinterest(descendant, root, 1)
                return
            end
        end
        return
    end
    player.Team = team
end)
addcmd('nobgui', {'unbgui', 'nobillboardgui', 'unbillboardgui', 'noname', 'rohg'}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if not descendant:IsA('BillboardGui') and not descendant:IsA('SurfaceGui') then
            continue
        end
        descendant:Destroy()
    end
end)
addcmd('loopnobgui', {'loopunbgui', 'loopnobillboardgui', 'loopunbillboardgui', 'loopnoname', 'looprohg'}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if not descendant:IsA('BillboardGui') and not descendant:IsA('SurfaceGui') then
            continue
        end
        descendant:Destroy()
    end
    local function charPartAdded(descendant)
        if descendant:IsA('BillboardGui') or descendant:IsA('SurfaceGui') then
            wait()
            descendant:Destroy()
        end
    end
    charPartTrigger = player.Character.DescendantAdded:Connect(charPartAdded)
end)
addcmd('unloopnobgui', {'unloopunbgui', 'unloopnobillboardgui', 'unloopunbillboardgui', 'unloopnoname', 'unlooprohg'}, function(arg1, arg2)
    if charPartTrigger then
        charPartTrigger:Disconnect()
    end
end)
addcmd('spasm', {}, function(arg1, player)
    if not r15(player) then
        local character = player.Character
        SpasmAnim = Instance.new('Animation')
        SpasmAnim.AnimationId = 'rbxassetid://33796059'
        Spasm = character:FindFirstChildOfClass('Humanoid'):LoadAnimation(SpasmAnim)
        Spasm:Play()
        Spasm:AdjustSpeed(99)
        return
    end
    notify('R6 Required', 'This command requires the r6 rig type')
end)
addcmd('unspasm', {'nospasm'}, function(arg1, arg2)
    Spasm:Stop()
    SpasmAnim:Destroy()
end)
addcmd('headthrow', {}, function(arg1, player)
    if not r15(player) then
        local animation = Instance.new('Animation')
        animation.AnimationId = 'rbxassetid://35154961'
        local animationTrack = player.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(animation)
        animationTrack:Play(0)
        animationTrack:AdjustSpeed(1)
        return
    end
    notify('R6 Required', 'This command requires the r6 rig type')
end)
local function anim2track(arg1)
    local objects = game:GetObjects(arg1)
    for i = 1, #objects do
        if not objects[i]:IsA('Animation') then
            continue
        end
        return objects[i].AnimationId
    end
    return arg1
end
addcmd('animation', {'anim'}, function(list, player)
    local text = tostring(list[1])
    if not text:find('rbxassetid://') then
        text = 'rbxassetid://' .. text
    end
    text = anim2track(text)
    local animation = Instance.new('Animation')
    animation.AnimationId = text
    local animationTrack = player.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(animation)
    animationTrack.Priority = Enum.AnimationPriority.Movement
    animationTrack:Play()
    if list[2] then
        animationTrack:AdjustSpeed(tostring(list[2]))
    end
end)
addcmd('emote', {'em'}, function(list, arg2)
    local track = humanoid:PlayEmoteAndGetAnimTrackById(list[1])
    if list[2] then
        track:AdjustSpeed(tostring(list[2]))
    end
end)
addcmd('noanim', {}, function(arg1, player)
    player.Character.Animate.Disabled = true
end)
addcmd('reanim', {}, function(arg1, player)
    player.Character.Animate.Disabled = false
end)
addcmd('animspeed', {}, function(list, player)
    local character = player.Character
    local humanoid2 = character:FindFirstChildOfClass('Humanoid') or character:FindFirstChildOfClass('AnimationController')
    for _, track in next, humanoid2:GetPlayingAnimationTracks() do
        track:AdjustSpeed(tonumber(list[1] or 1))
    end
end)
addcmd('copyanimation', {'copyanim', 'copyemote'}, function(list, player)
    local player2 = getPlayer(list[1], player)
    for _, v in ipairs(player2) do
        local _ = Players[v].Character
        for _, v2 in pairs(player.Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks()) do
            v2:Stop()
        end
        for _, v3 in pairs(Players[v].Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks()) do
            if string.find(v3.Animation.AnimationId, '507768375') then
                continue
            end
            local animationTrack = player.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(v3.Animation)
            animationTrack:Play(0.1, 1, v3.Speed)
            animationTrack.TimePosition = v3.TimePosition
            task.spawn(function()
                v3.Stopped:Wait()
                animationTrack:Stop()
                animationTrack:Destroy()
            end)
        end
    end
end)
addcmd('copyanimationid', {'copyanimid', 'copyemoteid'}, function(list, arg2)
    local function handlePlayer(player)
        local text = 'Animations Copied'
        for _, v in pairs(player.Character:FindFirstChildWhichIsA('Humanoid'):GetPlayingAnimationTracks()) do
            local animationId = v.Animation.AnimationId
            local text3 = animationId:find('rbxassetid://') and animationId:match('%d+')
            if not string.find(animationId, '507768375') and not string.find(animationId, '180435571') then
                if text3 then
                    local success, result = pcall(function()
                        return MarketplaceService:GetProductInfo(tonumber(text3)).Name
                    end)
                    local v1 = success and result or 'Failed to get name'
                    text ..= '\n\nName: ' .. v1 .. '\nAnimation Id: ' .. animationId
                else
                    text ..= '\n\nAnimation Id: ' .. animationId
                end
            end
        end
        if text ~= 'Animations Copied' then
            toClipboard(text)
            return
        end
        notify('Animations', 'No animations to copy')
    end
    if list[1] then
        handlePlayer(Players[getPlayer(list[1], arg2)[1]])
        return
    end
    handlePlayer(arg2)
end)
addcmd('stopanimations', {'stopanims', 'stopanim'}, function(arg1, player)
    local character = player.Character
    local humanoid2 = character:FindFirstChildOfClass('Humanoid') or character:FindFirstChildOfClass('AnimationController')
    for _, track in next, humanoid2:GetPlayingAnimationTracks() do
        track:Stop()
    end
end)
addcmd('refreshanimations', {'refreshanimation', 'refreshanims', 'refreshanim'}, function(arg1, player)
    local parent = player.Character or player.CharacterAdded:Wait()
    local humanoid2 = parent and parent:WaitForChild('Humanoid', 15)
    local animate = parent and parent:WaitForChild('Animate', 15)
    if not humanoid2 or not animate then
        return notify('Refresh Animations', 'Failed to get Animate/Humanoid')
    end
    animate.Disabled = true
    for _, track in ipairs(humanoid2:GetPlayingAnimationTracks()) do
        track:Stop()
    end
    animate.Disabled = false
end)
addcmd('allowcustomanim', {'allowcustomanimations'}, function(arg1, arg2)
    StarterPlayer.AllowCustomAnimations = true
    execCmd('refreshanimations')
end)
addcmd('unallowcustomanim', {'unallowcustomanimations'}, function(arg1, arg2)
    StarterPlayer.AllowCustomAnimations = false
    execCmd('refreshanimations')
end)
addcmd('loopanimation', {'loopanim'}, function(arg1, player)
    local character = player.Character
    local firstChildWhichIsA = character and character.FindFirstChildWhichIsA(character, 'Humanoid')
    for _, track in ipairs(firstChildWhichIsA.GetPlayingAnimationTracks(firstChildWhichIsA)) do
        track.Looped = true
    end
end)
addcmd('tpposition', {'tppos'}, function(list, player)
    if #list < 3 then
        return
    end
    local number, number2, number3 = tonumber((list[1]:gsub(',', ''))), tonumber((list[2]:gsub(',', ''))), tonumber((list[3]:gsub(',', '')))
    local character = player.Character
    if character and getRoot(character) then
        getRoot(character).CFrame = CFrame.new(number, number2, number3)
    end
end)
addcmd('tweentpposition', {'ttppos'}, function(list, player)
    if #list < 3 then
        return
    end
    local number, number2, number3 = tonumber((list[1]:gsub(',', ''))), tonumber((list[2]:gsub(',', ''))), tonumber((list[3]:gsub(',', '')))
    local character = player.Character
    if character and getRoot(character) then
        TweenService:Create(getRoot(player.Character), TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(number, number2, number3)}):Play()
    end
end)
addcmd('offset', {}, function(list, player)
    if #list < 3 then
        return
    end
    player.Character:TranslateBy(Vector3.new(tonumber(list[1]) or 0, tonumber(list[2]) or 0, tonumber(list[3]) or 0))
end)
addcmd('tweenoffset', {'toffset'}, function(list, player)
    if #list < 3 then
        return
    end
    local number, number2, number3 = tonumber(list[1]), tonumber(list[2]), tonumber(list[3])
    local root = getRoot(player.Character)
    local position = root.Position + Vector3.new(number, number2, number3)
    TweenService:Create(root, TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(position)}):Play()
    breakVelocity()
end)
addcmd('clickteleport', {}, function(arg1, arg2)
    if arg2 ~= Players.LocalPlayer then
        return
    end
    notify('Click TP', 'Go to Settings > Keybinds > Add to set up click teleport')
end)
addcmd('mouseteleport', {'mousetp'}, function(arg1, player)
    local root = getRoot(player.Character)
    local hit = IYMouse.Hit
    if root and hit then
        root.CFrame = CFrame.new(hit.X, hit.Y + 3, hit.Z, select(4, root.CFrame:components()))
        breakVelocity()
    end
end)
addcmd('tptool', {'teleporttool'}, function(arg1, parent)
    local tool = Instance.new('Tool')
    tool.Name = 'Teleport Tool'
    tool.RequiresHandle = false
    tool.Parent = parent:FindFirstChildOfClass('Backpack')
    tool.Activated:Connect(function()
        local root = getRoot(parent.Character)
        local hit = IYMouse.Hit
        if not root or not hit then
            return
        end
        root.CFrame = CFrame.new(hit.X, hit.Y + 3, hit.Z, select(4, root.CFrame:components()))
        breakVelocity()
    end)
end)
addcmd('thru', {}, function(list, player)
    local root = getRoot(player.Character)
    local v1 = tonumber(list[1]) or 5
    local position = root.CFrame.Position + root.CFrame.LookVector * v1
    root.CFrame = CFrame.new(position, position + root.CFrame.LookVector)
end)
addcmd('clickdelete', {}, function(arg1, arg2)
    if arg2 == Players.LocalPlayer then
        notify('Click Delete', 'Go to Settings > Keybinds > Add to set up click delete')
    end
end)
addcmd('getposition', {'getpos', 'notifypos', 'notifyposition'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        local character = Players[v].Character
        local root = character and (getRoot(character) or character:FindFirstChildWhichIsA('BasePart'))
        root = root and root.Position
        if not root then
            return notify('Getposition Error', 'Missing character')
        end
        local v1 = math.round(root.X) .. ', ' .. math.round(root.Y) .. ', ' .. math.round(root.Z)
        notify('Current Position', v1)
    end
end)
addcmd('copyposition', {'copypos'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        local character = Players[v].Character
        local root = character and (getRoot(character) or character:FindFirstChildWhichIsA('BasePart'))
        root = root and root.Position
        if not root then
            return notify('Getposition Error', 'Missing character')
        end
        local v1 = math.round(root.X) .. ', ' .. math.round(root.Y) .. ', ' .. math.round(root.Z)
        toClipboard(v1)
    end
end)
addcmd('walktopos', {'walktoposition'}, function(list, player)
    if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
        player.Character:FindFirstChildOfClass('Humanoid').Sit = false
        wait(0.1)
    end
    player.Character:FindFirstChildOfClass('Humanoid').WalkToPoint = Vector3.new(list[1], list[2], list[3])
end)
addcmd('speed', {'ws', 'walkspeed'}, function(list, player)
    if list[2] then
        local walkSpeed = list[2] or 16
        if isNumber(walkSpeed) then
            player.Character:FindFirstChildOfClass('Humanoid').WalkSpeed = walkSpeed
        end
    else
        local walkSpeed2 = list[1] or 16
        if isNumber(walkSpeed2) then
            player.Character:FindFirstChildOfClass('Humanoid').WalkSpeed = walkSpeed2
        end
    end
end)
addcmd('spoofspeed', {'spoofws', 'spoofwalkspeed'}, function(list, player)
    if list[1] and isNumber(list[1]) then
        if hookmetamethod then
            local character = player.Character
            local v1
            local callback
            callback = hookmetamethod(game, '__index', function(instance, text)
                if not checkcaller() and typeof(instance) == 'Instance' and instance:IsA('Humanoid') and (text == 'WalkSpeed' or text == 'walkSpeed') and instance:IsDescendantOf(character) then
                    return v1 or list[1]
                end
                return callback(instance, text)
            end)
            local callback2
            callback2 = hookmetamethod(game, '__newindex', function(instance, text, text3)
                if not checkcaller() and typeof(instance) == 'Instance' and instance:IsA('Humanoid') and (text == 'WalkSpeed' or text == 'walkSpeed') and instance:IsDescendantOf(character) then
                    v1 = tonumber(text3)
                end
                return callback2(instance, text, text3)
            end)
            return
        end
        notify('Incompatible Exploit', 'Your exploit does not support this command (missing hookmetamethod)')
    end
end)
addcmd('loopspeed', {'loopws'}, function(list, player)
    local walkSpeed = list[1] or 16
    if list[2] then
        walkSpeed = list[2] or 16
    end
    if isNumber(walkSpeed) then
        local parent = player.Character or workspace:FindFirstChild(player.Name)
        local instance = parent and parent:FindFirstChildWhichIsA('Humanoid')
        local function WalkSpeedChange()
            if parent and instance then
                instance.WalkSpeed = walkSpeed
            end
        end
        WalkSpeedChange()
        local tbl2 = tbl
        if tbl.wsLoop and tbl.wsLoop:Disconnect() then
        end
        tbl2.wsLoop = instance:GetPropertyChangedSignal('WalkSpeed'):Connect(WalkSpeedChange)
        local tbl3 = tbl
        if tbl.wsCA and tbl.wsCA:Disconnect() then
        end
        tbl3.wsCA = player.CharacterAdded:Connect(function(character)
            local humanoid2 = character:WaitForChild('Humanoid')
            parent = character
            instance = humanoid2
            WalkSpeedChange()
            local tbl2 = tbl
            if tbl.wsLoop and tbl.wsLoop:Disconnect() then
            end
            tbl2.wsLoop = instance:GetPropertyChangedSignal('WalkSpeed'):Connect(WalkSpeedChange)
        end)
    end
end)
addcmd('unloopspeed', {'unloopws'}, function(arg1, arg2)
    local tbl2 = tbl
    if tbl.wsLoop and tbl.wsLoop:Disconnect() then
    end
    tbl2.wsLoop = nil
    local tbl3 = tbl
    if tbl.wsCA and tbl.wsCA:Disconnect() then
    end
    tbl3.wsCA = nil
end)
addcmd('spoofjumppower', {'spoofjp'}, function(list, player)
    if list[1] and isNumber(list[1]) then
        if hookmetamethod then
            local character = player.Character
            local v1
            local callback
            callback = hookmetamethod(game, '__index', function(instance, text)
                if not checkcaller() and typeof(instance) == 'Instance' and instance:IsA('Humanoid') and (text == 'JumpPower' or text == 'jumpPower') and instance:IsDescendantOf(character) then
                    return v1 or list[1]
                end
                return callback(instance, text)
            end)
            local callback2
            callback2 = hookmetamethod(game, '__newindex', function(instance, text, text3)
                if not checkcaller() and typeof(instance) == 'Instance' and instance:IsA('Humanoid') and (text == 'JumpPower' or text == 'jumpPower') and instance:IsDescendantOf(character) then
                    v1 = tonumber(text3)
                end
                return callback2(instance, text, text3)
            end)
            return
        end
        notify('Incompatible Exploit', 'Your exploit does not support this command (missing hookmetamethod)')
    end
end)
addcmd('loopjumppower', {'loopjp', 'loopjpower'}, function(list, player)
    local jumpPower = list[1] or 50
    if isNumber(jumpPower) then
        local parent = player.Character or workspace:FindFirstChild(player.Name)
        local instance = parent and parent:FindFirstChildWhichIsA('Humanoid')
        local function JumpPowerChange()
            if parent and instance then
                if player.Character:FindFirstChildOfClass('Humanoid').UseJumpPower then
                    player.Character:FindFirstChildOfClass('Humanoid').JumpPower = jumpPower
                    return
                end
                player.Character:FindFirstChildOfClass('Humanoid').JumpHeight = jumpPower
            end
        end
        JumpPowerChange()
        local tbl2 = tbl
        if tbl.jpLoop and tbl.jpLoop:Disconnect() then
        end
        tbl2.jpLoop = instance:GetPropertyChangedSignal('JumpPower'):Connect(JumpPowerChange)
        local tbl3 = tbl
        if tbl.jpCA and tbl.jpCA:Disconnect() then
        end
        tbl3.jpCA = player.CharacterAdded:Connect(function(character)
            local humanoid2 = character:WaitForChild('Humanoid')
            parent = character
            instance = humanoid2
            JumpPowerChange()
            local tbl2 = tbl
            if tbl.jpLoop and tbl.jpLoop:Disconnect() then
            end
            tbl2.jpLoop = instance:GetPropertyChangedSignal('JumpPower'):Connect(JumpPowerChange)
        end)
    end
end)
addcmd('unloopjumppower', {'unloopjp', 'unloopjpower'}, function(arg1, player)
    local parent = player.Character or workspace:FindFirstChild(player.Name)
    local humanoid2 = parent and parent:FindFirstChildWhichIsA('Humanoid')
    local tbl2 = tbl
    if tbl.jpLoop and tbl.jpLoop:Disconnect() then
    end
    tbl2.jpLoop = nil
    local tbl3 = tbl
    if tbl.jpCA and tbl.jpCA:Disconnect() then
    end
    tbl3.jpCA = nil
    if parent and humanoid2 then
        if player.Character:FindFirstChildOfClass('Humanoid').UseJumpPower then
            player.Character:FindFirstChildOfClass('Humanoid').JumpPower = 50
            return
        end
        player.Character:FindFirstChildOfClass('Humanoid').JumpHeight = 50
    end
end)
addcmd('tools', {'gears'}, function(arg1, parent)
    local function copy(parent2)
        for _, child in pairs(parent2:GetChildren()) do
            if child:IsA('Tool') or child:IsA('HopperBin') then
                child:Clone().Parent = parent:FindFirstChildOfClass('Backpack')
            end
            copy(child)
        end
    end
    copy(Lighting)
    local function copy2(parent2)
        for _, child in pairs(parent2:GetChildren()) do
            if child:IsA('Tool') or child:IsA('HopperBin') then
                child:Clone().Parent = parent:FindFirstChildOfClass('Backpack')
            end
            copy2(child)
        end
    end
    copy2(ReplicatedStorage)
    notify('Tools', 'Copied tools from ReplicatedStorage and Lighting')
end)
addcmd('notools', {'rtools', 'clrtools', 'removetools', 'deletetools', 'dtools'}, function(arg1, parent)
    for _, v in pairs(parent:FindFirstChildOfClass('Backpack'):GetDescendants()) do
        if not v:IsA('Tool') and not v:IsA('HopperBin') then
            continue
        end
        v:Destroy()
    end
    for _, descendant in pairs(parent.Character:GetDescendants()) do
        if not descendant:IsA('Tool') and not descendant:IsA('HopperBin') then
            continue
        end
        descendant:Destroy()
    end
end)
addcmd('deleteselectedtool', {'dst'}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if not descendant:IsA('Tool') and not descendant:IsA('HopperBin') then
            continue
        end
        descendant:Destroy()
    end
end)
addcmd('console', {}, function(arg1, arg2)
    StarterGui:SetCore('DevConsoleVisible', true)
end)
addcmd('oldconsole', {}, function(arg1, arg2)
    notify('Loading', 'Hold on a sec')
    local success, result = pcall(function()
        return game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/console.lua', true)
    end)
    local value, v1 = loadstring(result)
    if typeof(value) ~= 'function' then
        return
    end
    local success2, result2 = pcall(value)
    if not success2 then
        if printconsole then
            printconsole(result2)
        elseif printoutput then
            printoutput(result2)
        end
    end
    wait(1)
    notify('Console', 'Press F9 to open the console')
end)
addcmd('explorer', {'dex'}, function(arg1, arg2)
    notify('Loading', 'Hold on a sec')
    loadstring(game:HttpGet('https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua'))()
end)
addcmd('moondex', {'mdex'}, function(arg1, arg2)
    notify('Loading', 'Hold on a sec')
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
end)
addcmd('remotespy', {'rspy', 'cobalt', 'cspy'}, function(arg1, arg2)
    notify('Loading', 'Hold on a sec')
    loadstring(game:HttpGet('https://gitlab.com/upio/cobalt/-/releases/permalink/latest/downloads/Cobalt.luau'))()
end)
addcmd('simplespy', {'sspy'}, function(arg1, arg2)
    notify('Loading', 'Hold on a sec')
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua'))()
end)
addcmd('audiologger', {'alogger'}, function(arg1, arg2)
    notify('Loading', 'Hold on a sec')
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/audiologger.lua', true))()
end)
local v5
addcmd('loopgoto', {}, function(list, player)
    local player2 = getPlayer(list[1], player)
    for _, v in pairs(player2) do
        v5 = nil
        if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
            player.Character:FindFirstChildOfClass('Humanoid').Sit = false
            wait(0.1)
        end
        v5 = Players[v]
        local second = 3
        if list[2] and isNumber(list[2]) then
            second = list[2]
        end
        local third = 0
        if list[3] and isNumber(list[3]) then
            third = list[3]
        end
        repeat
            if Players:FindFirstChild(v) then
                if Players[v].Character ~= nil then
                    getRoot(player.Character).CFrame = getRoot(Players[v].Character).CFrame + Vector3.new(second, 1, 0)
                end
                wait(third)
            else
                v5 = nil
            end
        until v5 ~= Players[v]
    end
end)
addcmd('unloopgoto', {'noloopgoto'}, function(arg1, arg2)
    v5 = nil
end)
addcmd('headsit', {}, function(list, player)
    local player2 = getPlayer(list[1], player)
    if headSit then
        headSit:Disconnect()
    end
    for _, v in pairs(player2) do
        player.Character:FindFirstChildOfClass('Humanoid').Sit = true
        headSit = RunService.Heartbeat:Connect(function()
            if Players:FindFirstChild(Players[v].Name) and Players[v].Character ~= nil and getRoot(Players[v].Character) and getRoot(player.Character) and player.Character:FindFirstChildOfClass('Humanoid').Sit == true then
                getRoot(player.Character).CFrame = getRoot(Players[v].Character).CFrame * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 1.6, 0.4)
                return
            end
            headSit:Disconnect()
        end)
    end
end)
addcmd('chat', {'say'}, function(arg1, arg2)
    local result = getstring(1, arg1)
    chatMessage(result)
end)
spamming = false
spamspeed = 1
addcmd('spam', {}, function(arg1, arg2)
    spamming = true
    local result = getstring(1, arg1)
    repeat
        wait(spamspeed)
        chatMessage(result)
    until spamming == false
end)
addcmd('nospam', {'unspam'}, function(arg1, arg2)
    spamming = false
end)
addcmd('whisper', {'pm'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        task.spawn(function()
            local name = Players[v].Name
            local result = getstring(2, list)
            chatMessage('/w ' .. name .. ' ' .. result)
        end)
    end
end)
pmspamming = {}
addcmd('pmspam', {}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for k, v in pairs(player) do
        task.spawn(function()
            local name = Players[v].Name
            if FindInTable(pmspamming, name) then
                return
            end
            table.insert(pmspamming, name)
            local result = getstring(2, list)
            repeat
                if Players:FindFirstChild(v) then
                    wait(spamspeed)
                    chatMessage('/w ' .. name .. ' ' .. result)
                else
                    for k, v2 in pairs(pmspamming) do
                        if v2 ~= name then
                            continue
                        end
                        table.remove(pmspamming, k)
                    end
                end
            until not FindInTable(pmspamming, name)
        end)
    end
end)
addcmd('nopmspam', {'unpmspam'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for k, v in pairs(player) do
        task.spawn(function()
            for k, v2 in pairs(pmspamming) do
                if v2 ~= Players[v].Name then
                    continue
                end
                table.remove(pmspamming, k)
            end
        end)
    end
end)
addcmd('spamspeed', {}, function(list, arg2)
    local v1 = list[1] or 1
    if isNumber(v1) then
        spamspeed = v1
    end
end)
addcmd('bubblechat', {}, function(arg1, arg2)
    if isLegacyChat then
        ChatService.BubbleChatEnabled = true
        return
    end
    TextChatService.BubbleChatConfiguration.Enabled = true
end)
addcmd('unbubblechat', {'nobubblechat'}, function(arg1, arg2)
    if isLegacyChat then
        ChatService.BubbleChatEnabled = false
        return
    end
    TextChatService.BubbleChatConfiguration.Enabled = false
end)
addcmd('chatwindow', {}, function(arg1, arg2)
    TextChatService.ChatWindowConfiguration.Enabled = true
end)
addcmd('unchatwindow', {'nochatwindow'}, function(arg1, arg2)
    TextChatService.ChatWindowConfiguration.Enabled = false
end)
addcmd('darkchat', {}, function(arg1, arg2)
    local bubbleChatConfiguration = TextChatService:FindFirstChildOfClass('BubbleChatConfiguration')
    local chatWindowConfiguration = TextChatService:FindFirstChildOfClass('ChatWindowConfiguration')
    local chatInputBarConfiguration = TextChatService:FindFirstChildOfClass('ChatInputBarConfiguration')
    if bubbleChatConfiguration then
        bubbleChatConfiguration.Enabled = true
        bubbleChatConfiguration.BackgroundColor3 = Color3.fromRGB()
        bubbleChatConfiguration.BackgroundTransparency = 0.3
        bubbleChatConfiguration.TailVisible = true
        bubbleChatConfiguration.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    if chatWindowConfiguration then
        chatWindowConfiguration.Enabled = true
        chatWindowConfiguration.BackgroundColor3 = Color3.fromRGB()
        chatWindowConfiguration.BackgroundTransparency = 0.3
        chatWindowConfiguration.TextColor3 = Color3.fromRGB(255, 255, 255)
        chatWindowConfiguration.TextStrokeColor3 = Color3.fromRGB()
        chatWindowConfiguration.TextStrokeTransparency = 0.5
    end
    if chatInputBarConfiguration then
        chatInputBarConfiguration.Enabled = true
        chatInputBarConfiguration.BackgroundColor3 = Color3.fromRGB()
        chatInputBarConfiguration.BackgroundTransparency = 0.5
        chatInputBarConfiguration.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
        chatInputBarConfiguration.TextColor3 = Color3.fromRGB(255, 255, 255)
        chatInputBarConfiguration.TextStrokeColor3 = Color3.fromRGB()
        chatInputBarConfiguration.TextStrokeTransparency = 0.5
    end
end)
addcmd('blockhead', {}, function(arg1, player)
    player.Character.Head:FindFirstChildOfClass('SpecialMesh'):Destroy()
end)
addcmd('blockhats', {}, function(arg1, player)
    for _, v in pairs(player.Character:FindFirstChildOfClass('Humanoid'):GetAccessories()) do
        for _, descendant in pairs(v:GetDescendants()) do
            if not descendant:IsA('SpecialMesh') then
                continue
            end
            descendant:Destroy()
        end
    end
end)
addcmd('blocktool', {}, function(arg1, player)
    for _, child in pairs(player.Character:GetChildren()) do
        if not child:IsA('Tool') and not child:IsA('HopperBin') then
            continue
        end
        for _, descendant in pairs(child:GetDescendants()) do
            if not descendant:IsA('SpecialMesh') then
                continue
            end
            descendant:Destroy()
        end
    end
end)
addcmd('creeper', {}, function(arg1, player)
    if r15(player) then
        player.Character.Head:FindFirstChildOfClass('SpecialMesh'):Destroy()
        player.Character.LeftUpperArm:Destroy()
        player.Character.RightUpperArm:Destroy()
        player.Character:FindFirstChildOfClass('Humanoid'):RemoveAccessories()
        return
    end
    player.Character.Head:FindFirstChildOfClass('SpecialMesh'):Destroy()
    player.Character['Left Arm']:Destroy()
    player.Character['Right Arm']:Destroy()
    player.Character:FindFirstChildOfClass('Humanoid'):RemoveAccessories()
end)
getTorso = function(parent)
    parent = parent or Players.LocalPlayer.Character
    return parent:FindFirstChild('Torso') or parent:FindFirstChild('UpperTorso') or parent:FindFirstChild('LowerTorso') or parent:FindFirstChild('HumanoidRootPart')
end
addcmd('bang', {'rape'}, function(list, player)
    execCmd('unbang')
    wait()
    local humanoid2 = player.Character:FindFirstChildWhichIsA('Humanoid')
    bangAnim = Instance.new('Animation')
    bangAnim.AnimationId = not r15(player) and 'rbxassetid://148840371' or 'rbxassetid://5918726674'
    bang = humanoid2:LoadAnimation(bangAnim)
    bang:Play(0.1, 1, 1)
    bang:AdjustSpeed(list[2] or 3)
    bangDied = humanoid2.Died:Connect(function()
        bang:Stop()
        bangAnim:Destroy()
        bangDied:Disconnect()
        bangLoop:Disconnect()
    end)
    if list[1] then
        local player2 = getPlayer(list[1], player)
        for _, v in pairs(player2) do
            local name = Players[v].Name
            local cframe = CFrame.new(0, 0, 1.1)
            bangLoop = RunService.Stepped:Connect(function()
                pcall(function()
                    local torso = getTorso(Players[name].Character)
                    getRoot(player.Character).CFrame = torso.CFrame * cframe
                end)
            end)
            return
        end
    end
end)
addcmd('unbang', {'unrape'}, function(arg1, arg2)
    if bangDied then
        bangDied:Disconnect()
        bang:Stop()
        bangAnim:Destroy()
        bangLoop:Disconnect()
    end
end)
addcmd('carpet', {}, function(list, player)
    if not r15(player) then
        execCmd('uncarpet')
        wait()
        local player2 = getPlayer(list[1], player)
        for _, v in pairs(player2) do
            carpetAnim = Instance.new('Animation')
            carpetAnim.AnimationId = 'rbxassetid://282574440'
            carpet = player.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(carpetAnim)
            carpet:Play(0.1, 1, 1)
            local name = Players[v].Name
            carpetDied = player.Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
                carpetLoop:Disconnect()
                carpet:Stop()
                carpetAnim:Destroy()
                carpetDied:Disconnect()
            end)
            carpetLoop = RunService.Heartbeat:Connect(function()
                pcall(function()
                    getRoot(Players.LocalPlayer.Character).CFrame = getRoot(Players[name].Character).CFrame
                end)
            end)
        end
        return
    end
    notify('R6 Required', 'This command requires the r6 rig type')
end)
addcmd('uncarpet', {'nocarpet'}, function(arg1, arg2)
    if carpetLoop then
        carpetLoop:Disconnect()
        carpetDied:Disconnect()
        carpet:Stop()
        carpetAnim:Destroy()
    end
end)
addcmd('friend', {}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        arg2:RequestFriendship(Players[v])
    end
end)
addcmd('unfriend', {}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        arg2:RevokeFriendship(Players[v])
    end
end)
addcmd('bringpart', {}, function(arg1, player)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.Name:lower() == getstring(1, arg1):lower() and descendant:IsA('BasePart') then
            descendant.CFrame = getRoot(player.Character).CFrame
        end
    end
end)
addcmd('bringpartclass', {'bpc'}, function(arg1, player)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.ClassName:lower() == getstring(1, arg1):lower() and descendant:IsA('BasePart') then
            descendant.CFrame = getRoot(player.Character).CFrame
        end
    end
end)
gotopartDelay = 0.1
addcmd('gotopart', {'topart'}, function(arg1, player)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.Name:lower() == getstring(1, arg1):lower() and descendant:IsA('BasePart') then
            if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                player.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(0.1)
            end
            wait(gotopartDelay)
            getRoot(player.Character).CFrame = descendant.CFrame
        end
    end
end)
addcmd('tweengotopart', {'tgotopart', 'ttopart'}, function(arg1, player)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.Name:lower() == getstring(1, arg1):lower() and descendant:IsA('BasePart') then
            if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                player.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(0.1)
            end
            wait(gotopartDelay)
            TweenService:Create(getRoot(player.Character), TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = descendant.CFrame}):Play()
        end
    end
end)
addcmd('gotopartclass', {'gpc'}, function(arg1, player)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.ClassName:lower() == getstring(1, arg1):lower() and descendant:IsA('BasePart') then
            if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                player.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(0.1)
            end
            wait(gotopartDelay)
            getRoot(player.Character).CFrame = descendant.CFrame
        end
    end
end)
addcmd('tweengotopartclass', {'tgpc'}, function(arg1, player)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.ClassName:lower() == getstring(1, arg1):lower() and descendant:IsA('BasePart') then
            if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                player.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(0.1)
            end
            wait(gotopartDelay)
            TweenService:Create(getRoot(player.Character), TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = descendant.CFrame}):Play()
        end
    end
end)
addcmd('gotomodel', {'tomodel'}, function(arg1, player)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.Name:lower() == getstring(1, arg1):lower() and descendant:IsA('Model') then
            if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                player.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(0.1)
            end
            wait(gotopartDelay)
            getRoot(player.Character).CFrame = descendant:GetModelCFrame()
        end
    end
end)
addcmd('tweengotomodel', {'tgotomodel', 'ttomodel'}, function(arg1, player)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.Name:lower() == getstring(1, arg1):lower() and descendant:IsA('Model') then
            if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                player.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(0.1)
            end
            wait(gotopartDelay)
            TweenService:Create(getRoot(player.Character), TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = descendant:GetModelCFrame()}):Play()
        end
    end
end)
addcmd('gotopartdelay', {}, function(list, arg2)
    local v1 = list[1] or 0.1
    if isNumber(v1) then
        gotopartDelay = v1
    end
end)
addcmd('noclickdetectorlimits', {'nocdlimits', 'removecdlimits'}, function(arg1, arg2)
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if not descendant:IsA('ClickDetector') then
            continue
        end
        descendant.MaxActivationDistance = math.huge
    end
end)
addcmd('fireclickdetectors', {'firecd', 'firecds'}, function(list, arg2)
    if fireclickdetector then
        if list[1] then
            local result = getstring(1, list):lower()
            for _, descendant in ipairs(workspace:GetDescendants()) do
                if descendant:IsA('ClickDetector') and descendant.Name:lower() == result or descendant.Parent.Name:lower() == result then
                    fireclickdetector(descendant)
                end
            end
            return
        end
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if not descendant:IsA('ClickDetector') then
                continue
            end
            fireclickdetector(descendant)
        end
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing fireclickdetector)')
end)
addcmd('noproximitypromptlimits', {'nopplimits', 'removepplimits'}, function(arg1, arg2)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if not descendant:IsA('ProximityPrompt') then
            continue
        end
        descendant.MaxActivationDistance = math.huge
    end
end)
addcmd('fireproximityprompts', {'firepp'}, function(list, arg2)
    if fireproximityprompt then
        if list[1] then
            local result = getstring(1, list)
            for _, descendant in ipairs(workspace:GetDescendants()) do
                if descendant:IsA('ProximityPrompt') and descendant.Name == result or descendant.Parent.Name == result then
                    fireproximityprompt(descendant)
                end
            end
            return
        end
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if not descendant:IsA('ProximityPrompt') then
                continue
            end
            fireproximityprompt(descendant)
        end
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing fireproximityprompt)')
end)
local connection16
addcmd('instantproximityprompts', {'instantpp'}, function(arg1, arg2)
    if fireproximityprompt then
        execCmd('uninstantproximityprompts')
        wait(0.1)
        connection16 = ProximityPromptService.PromptButtonHoldBegan:Connect(function(arg1)
            fireproximityprompt(arg1)
        end)
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing fireproximityprompt)')
end)
addcmd('uninstantproximityprompts', {'uninstantpp'}, function(arg1, arg2)
    if connection16 ~= nil then
        connection16:Disconnect()
        connection16 = nil
    end
end)
addcmd('notifyping', {'ping'}, function(arg1, number)
    notify('Ping', math.round(number:GetNetworkPing() * 1000) .. 'ms')
end)
addcmd('grabtools', {}, function(arg1, player)
    local humanoid2 = player.Character:FindFirstChildWhichIsA('Humanoid')
    for _, child in ipairs(workspace:GetChildren()) do
        if player.Character and child:IsA('BackpackItem') and child:FindFirstChild('Handle') then
            humanoid2:EquipTool(child)
        end
    end
    if grabtoolsFunc then
        grabtoolsFunc:Disconnect()
    end
    grabtoolsFunc = workspace.ChildAdded:Connect(function(child)
        if player.Character and child:IsA('BackpackItem') and child:FindFirstChild('Handle') then
            humanoid2:EquipTool(child)
        end
    end)
    notify('Grabtools', 'Picking up any dropped tools')
end)
addcmd('nograbtools', {'ungrabtools'}, function(arg1, arg2)
    if grabtoolsFunc then
        grabtoolsFunc:Disconnect()
    end
    notify('Grabtools', 'Grabtools has been disabled')
end)
local map2 = {}
addcmd('removespecifictool', {}, function(list, parent)
    if list[1] and parent:FindFirstChildOfClass('Backpack') then
        local lowered = string.lower(getstring(1, list))
        map2[lowered] = RunService.RenderStepped:Connect(function()
            if parent:FindFirstChildOfClass('Backpack') then
                for _, v in pairs(parent:FindFirstChildOfClass('Backpack'):GetChildren()) do
                    if v.Name:lower() ~= lowered then
                        continue
                    end
                    v:Remove()
                end
            end
        end)
    end
end)
addcmd('unremovespecifictool', {}, function(list, arg2)
    if list[1] then
        local lowered = string.lower(getstring(1, list))
        if map2[lowered] ~= nil then
            map2[lowered]:Disconnect()
            map2[lowered] = nil
        end
    end
end)
addcmd('clearremovespecifictool', {}, function(arg1, arg2)
    for v in pairs(map2) do
        map2[v]:Disconnect()
        map2[v] = nil
    end
end)
addcmd('light', {}, function(list, player)
    local pointLight = Instance.new('PointLight')
    pointLight.Parent = getRoot(player.Character)
    pointLight.Range = 30
    if list[1] then
        pointLight.Brightness = list[2]
        pointLight.Range = list[1]
        return
    end
    pointLight.Brightness = 5
end)
addcmd('unlight', {'nolight'}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if descendant.ClassName ~= 'PointLight' then
            continue
        end
        descendant:Destroy()
    end
end)
addcmd('copytools', {}, function(list, parent)
    local player = getPlayer(list[1], parent)
    for _, v in pairs(player) do
        task.spawn(function()
            for _, v2 in pairs(Players[v]:FindFirstChildOfClass('Backpack'):GetChildren()) do
                if not v2:IsA('Tool') and not v2:IsA('HopperBin') then
                    continue
                end
                v2:Clone().Parent = parent:FindFirstChildOfClass('Backpack')
            end
        end)
    end
end)
addcmd('naked', {}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if not descendant:IsA('Clothing') and not descendant:IsA('ShirtGraphic') then
            continue
        end
        descendant:Destroy()
    end
end)
addcmd('noface', {'removeface'}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if descendant:IsA('Decal') and descendant.Name == 'face' then
            descendant:Destroy()
        end
    end
end)
addcmd('spawnpoint', {'spawn'}, function(list, player)
    spawnpos = getRoot(player.Character).CFrame
    spawnpoint = true
    spDelay = tonumber(list[1]) or 0.1
    notify('Spawn Point', 'Spawn point created at ' .. tostring(spawnpos))
end)
addcmd('nospawnpoint', {'nospawn', 'removespawnpoint'}, function(arg1, arg2)
    spawnpoint = false
    notify('Spawn Point', 'Removed spawn point')
end)
addcmd('flashback', {'diedtp'}, function(arg1, player)
    if cframe ~= nil then
        if player.Character:FindFirstChildOfClass('Humanoid') and player.Character:FindFirstChildOfClass('Humanoid').SeatPart then
            player.Character:FindFirstChildOfClass('Humanoid').Sit = false
            wait(0.1)
        end
        getRoot(player.Character).CFrame = cframe
    end
end)
addcmd('hatspin', {'spinhats'}, function(list, player)
    execCmd('unhatspin')
    wait(0.5)
    for _, v in pairs(player.Character:FindFirstChildOfClass('Humanoid'):GetAccessories()) do
        local bodyPosition = Instance.new('BodyPosition')
        bodyPosition.Name = randomString()
        bodyPosition.Parent = v.Handle
        local bodyAngularVelocity = Instance.new('BodyAngularVelocity')
        bodyAngularVelocity.Name = randomString()
        bodyAngularVelocity.Parent = v.Handle
        v.Handle:FindFirstChildOfClass('Weld'):Destroy()
        if list[1] then
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, list[1], 0)
            bodyAngularVelocity.MaxTorque = Vector3.new(0, list[1] * 2, 0)
        else
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, 100, 0)
            bodyAngularVelocity.MaxTorque = Vector3.new(0, 200, 0)
        end
        bodyPosition.P = 30000
        bodyPosition.D = 50
        spinhats = RunService.Stepped:Connect(function()
            pcall(function()
                bodyPosition.Position = Players.LocalPlayer.Character.Head.Position
            end)
        end)
    end
end)
addcmd('unhatspin', {'unspinhats'}, function(arg1, player)
    if spinhats then
        spinhats:Disconnect()
    end
    for _, v in pairs(player.Character:FindFirstChildOfClass('Humanoid'):GetAccessories()) do
        v.Parent = workspace
        for _, v2 in pairs(v.Handle) do
            if not v2:IsA('BodyPosition') and not v2:IsA('BodyAngularVelocity') then
                continue
            end
            v2:Destroy()
        end
        wait()
        v.Parent = player.Character
    end
end)
addcmd('clearhats', {'cleanhats'}, function(arg1, arg2)
    if firetouchinterest then
        local localPlayer = Players.LocalPlayer
        local character = localPlayer.Character
        local cframe = getRoot(character).CFrame
        local list = {}
        for _, child in ipairs(workspace:GetChildren()) do
            if not child:IsA('Accessory') then
                continue
            end
            table.insert(list, child)
        end
        for _, v in ipairs(character:FindFirstChildOfClass('Humanoid'):GetAccessories()) do
            v:Destroy()
        end
        for i = 1, #list do
            repeat
                RunService.Heartbeat:wait()
            until list[i]
            firetouchinterest(list[i].Handle, getRoot(character), 0)
            repeat
                RunService.Heartbeat:wait()
            until character:FindFirstChildOfClass('Accessory')
            character:FindFirstChildOfClass('Accessory'):Destroy()
            repeat
                RunService.Heartbeat:wait()
            until not character:FindFirstChildOfClass('Accessory')
        end
        execCmd('reset')
        localPlayer.CharacterAdded:Wait()
        for _ = 1, 20 do
            RunService.Heartbeat:Wait()
            if not getRoot(localPlayer.Character) then
                continue
            end
            getRoot(localPlayer.Character).Humanoid.RootPart.CFrame = cframe
        end
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing firetouchinterest)')
end)
addcmd('split', {}, function(arg1, player)
    if r15(player) then
        player.Character.UpperTorso.Waist:Destroy()
        return
    end
    notify('R15 Required', 'This command requires the r15 rig type')
end)
addcmd('nilchar', {}, function(arg1, player)
    if player.Character ~= nil then
        player.Character.Parent = nil
    end
end)
addcmd('unnilchar', {'nonilchar'}, function(arg1, player)
    if player.Character ~= nil then
        player.Character.Parent = workspace
    end
end)
addcmd('noroot', {'removeroot', 'rroot'}, function(arg1, player)
    if player.Character ~= nil then
        local character = Players.LocalPlayer.Character
        character.Parent = nil
        character.Humanoid.RootPart:Destroy()
        character.Parent = workspace
    end
end)
addcmd('replaceroot', {'replacerootpart'}, function(arg1, player)
    if player.Character ~= nil and getRoot(player.Character) then
        local character = player.Character
        local parent = character.Parent
        local template = character and getRoot(character)
        local cframe = template.CFrame
        character.Parent = game
        local clone = template:Clone()
        clone.Parent = character
        local _ = template:Destroy()
        clone.CFrame = cframe
        character.Parent = parent
    end
end)
addcmd('clearcharappearance', {'clearchar', 'clrchar'}, function(arg1, arg2)
    arg2:ClearCharacterAppearance()
end)
addcmd('equiptools', {}, function(arg1, parent)
    for _, v in pairs(parent:FindFirstChildOfClass('Backpack'):GetChildren()) do
        if not v:IsA('Tool') and not v:IsA('HopperBin') then
            continue
        end
        v.Parent = parent.Character
    end
end)
addcmd('unequiptools', {}, function(arg1, player)
    player.Character:FindFirstChildOfClass('Humanoid'):UnequipTools()
end)
local function GetHandleTools(player)
    player = player or Players.LocalPlayer
    local list = {}
    for _, v in ipairs(player.Character and player.Character:GetChildren() or {}) do
        if v.IsA(v, 'BackpackItem') and v.FindFirstChild(v, 'Handle') then
            list[#list + 1] = v
        end
    end
    for _, child in ipairs(player.Backpack:GetChildren()) do
        if child.IsA(child, 'BackpackItem') and child.FindFirstChild(child, 'Handle') then
            list[#list + 1] = child
        end
    end
    return list
end
addcmd('dupetools', {'clonetools'}, function(list, player)
    local count = tonumber(list[1]) or 1
    local position = player.Character.Humanoid.RootPart.Position
    local list2 = {}
    local vector3 = Vector3.new(math.random(-200000, 200000), 200000, math.random(-200000, 200000))
    for i = 1, count do
        local humanoid2 = player.Character:WaitForChild('Humanoid')
        wait(0.1, humanoid2.Parent:MoveTo(vector3))
        humanoid2.RootPart.Anchored = player:ClearCharacterAppearance(wait(0.1)) or true
        local handleTools = GetHandleTools(player)
        while #handleTools > 0 do
            for _, handleTool in ipairs(handleTools) do
                task.spawn(function()
                    for _ = 1, 25 do
                        handleTool.Parent = player.Character
                        handleTool.Handle.Anchored = true
                    end
                    for _ = 1, 5 do
                        handleTool.Parent = workspace
                    end
                    table.insert(list2, handleTool.Handle)
                end)
            end
            handleTools = GetHandleTools(player)
        end
        wait(0.1)
        player.Character = player.Character:Destroy()
        player.CharacterAdded:Wait():WaitForChild('Humanoid').Parent:MoveTo(count == i and position or vector3, wait(0.1))
        if i == count or i % 5 == 0 then
            local rootPart = player.Character.Humanoid.RootPart
            if type(firetouchinterest) == 'function' then
                for _, v in ipairs(list2) do
                    if not firetouchinterest(v, rootPart, 1, firetouchinterest(v, rootPart, 0)) then
                    end
                    v.Anchored = false
                end
            else
                for _, v in ipairs(list2) do
                    task.spawn(function()
                        local canCollide = v.CanCollide
                        v.CanCollide = false
                        v.Anchored = false
                        for _ = 1, 10 do
                            v.CFrame = rootPart.CFrame
                            wait()
                        end
                        v.CanCollide = canCollide
                    end)
                end
            end
            wait(0.1)
            list2 = {}
        end
        vector3 += Vector3.new(10, math.random(-5, 5), 0)
    end
end)
addcmd('touchinterests', {'touchinterest', 'firetouchinterests', 'firetouchinterest'}, function(list, player)
    local root = getRoot(player.Character) or player.Character:FindFirstChildWhichIsA('BasePart')
    if not firetouchinterest then
        notify('Incompatible Exploit', 'Your exploit does not support this command (missing firetouchinterest)')
        return
    end
    local function Touch(arg1)
        arg1 = arg1.FindFirstAncestorWhichIsA(arg1, 'Part')
        if arg1 then
            return task.spawn(function()
                firetouchinterest(arg1, root, 1, wait() and firetouchinterest(arg1, root, 0))
            end)
        end
        arg1.CFrame = root.CFrame
    end
    if list[1] then
        local result = getstring(1, list):lower()
        print(result .. ' -name')
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA('TouchTransmitter') and descendant.Name:lower() == result or descendant.Parent.Name:lower() == result then
                Touch(descendant)
            end
        end
        return
    end
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if not descendant.IsA(descendant, 'TouchTransmitter') then
            continue
        end
        Touch(descendant)
    end
end)
addcmd('fullbright', {'fb', 'fullbrightness'}, function(arg1, arg2)
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)
addcmd('loopfullbright', {'loopfb'}, function(arg1, arg2)
    if brightLoop then
        brightLoop:Disconnect()
    end
    local function brightFunc()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
    brightLoop = RunService.RenderStepped:Connect(brightFunc)
end)
addcmd('unloopfullbright', {'unloopfb'}, function(arg1, arg2)
    if brightLoop then
        brightLoop:Disconnect()
    end
end)
addcmd('ambient', {}, function(list, arg2)
    Lighting.Ambient = Color3.new(list[1], list[2], list[3])
    Lighting.OutdoorAmbient = Color3.new(list[1], list[2], list[3])
end)
addcmd('day', {}, function(arg1, arg2)
    Lighting.ClockTime = 14
end)
addcmd('night', {}, function(arg1, arg2)
    Lighting.ClockTime = 0
end)
addcmd('nofog', {}, function(arg1, arg2)
    Lighting.FogEnd = 100000
    for _, descendant in pairs(Lighting:GetDescendants()) do
        if not descendant:IsA('Atmosphere') then
            continue
        end
        descendant:Destroy()
    end
end)
addcmd('brightness', {}, function(list, arg2)
    Lighting.Brightness = list[1]
end)
addcmd('globalshadows', {'gshadows'}, function(arg1, arg2)
    Lighting.GlobalShadows = true
end)
addcmd('unglobalshadows', {'nogshadows', 'ungshadows', 'noglobalshadows'}, function(arg1, arg2)
    Lighting.GlobalShadows = false
end)
origsettings = {abt = Lighting.Ambient, oabt = Lighting.OutdoorAmbient, brt = Lighting.Brightness, time = Lighting.ClockTime, fe = Lighting.FogEnd, fs = Lighting.FogStart, gs = Lighting.GlobalShadows}
addcmd('restorelighting', {'rlighting'}, function(arg1, arg2)
    Lighting.Ambient = origsettings.abt
    Lighting.OutdoorAmbient = origsettings.oabt
    Lighting.Brightness = origsettings.brt
    Lighting.ClockTime = origsettings.time
    Lighting.FogEnd = origsettings.fe
    Lighting.FogStart = origsettings.fs
    Lighting.GlobalShadows = origsettings.gs
end)
addcmd('stun', {'platformstand'}, function(arg1, player)
    player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
end)
addcmd('unstun', {'nostun', 'unplatformstand', 'noplatformstand'}, function(arg1, player)
    player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
end)
addcmd('norotate', {'noautorotate'}, function(arg1, player)
    player.Character:FindFirstChildOfClass('Humanoid').AutoRotate = false
end)
addcmd('unnorotate', {'autorotate'}, function(arg1, player)
    player.Character:FindFirstChildOfClass('Humanoid').AutoRotate = true
end)
addcmd('enablestate', {}, function(list, player)
    local first = list[1]
    player.Character:FindFirstChildOfClass('Humanoid'):SetStateEnabled(first, true)
end)
addcmd('disablestate', {}, function(list, player)
    local first = list[1]
    player.Character:FindFirstChildOfClass('Humanoid'):SetStateEnabled(first, false)
end)
addcmd('drophats', {'drophat'}, function(arg1, player)
    if player.Character then
        for _, v in pairs(player.Character:FindFirstChildOfClass('Humanoid'):GetAccessories()) do
            v.Parent = workspace
        end
    end
end)
addcmd('deletehats', {'nohats', 'rhats'}, function(arg1, player)
    for _, descendant in next, player.Character:GetDescendants() do
        if not descendant:IsA('Accessory') then
            continue
        end
        for _, descendant2 in next, descendant:GetDescendants() do
            if not descendant2:IsA('Weld') then
                continue
            end
            descendant2:Destroy()
        end
    end
end)
addcmd('droptools', {'droptool'}, function(arg1, arg2)
    for _, child in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
        if not child:IsA('Tool') then
            continue
        end
        child.Parent = Players.LocalPlayer.Character
    end
    wait()
    for _, child in pairs(Players.LocalPlayer.Character:GetChildren()) do
        if not child:IsA('Tool') then
            continue
        end
        child.Parent = workspace
    end
end)
addcmd('droppabletools', {}, function(arg1, parent)
    if parent.Character then
        for _, child in pairs(parent.Character:GetChildren()) do
            if not child:IsA('Tool') then
                continue
            end
            child.CanBeDropped = true
        end
    end
    if parent:FindFirstChildOfClass('Backpack') then
        for _, v in pairs(parent:FindFirstChildOfClass('Backpack'):GetChildren()) do
            if not v:IsA('Tool') then
                continue
            end
            v.CanBeDropped = true
        end
    end
end)
local size = ''
local gripPos = ''
addcmd('reach', {}, function(list, player)
    execCmd('unreach')
    wait()
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if not descendant:IsA('Tool') then
            continue
        end
        if list[1] then
            size = descendant.Handle.Size
            gripPos = descendant.GripPos
            local selectionBox = Instance.new('SelectionBox')
            selectionBox.Name = 'SelectionBoxCreated'
            selectionBox.Parent = descendant.Handle
            selectionBox.Adornee = descendant.Handle
            descendant.Handle.Massless = true
            descendant.Handle.Size = Vector3.new(0.5, 0.5, list[1])
            descendant.GripPos = Vector3.new(0, 0, 0)
            player.Character:FindFirstChildOfClass('Humanoid'):UnequipTools()
        else
            size = descendant.Handle.Size
            gripPos = descendant.GripPos
            local selectionBox2 = Instance.new('SelectionBox')
            selectionBox2.Name = 'SelectionBoxCreated'
            selectionBox2.Parent = descendant.Handle
            selectionBox2.Adornee = descendant.Handle
            descendant.Handle.Massless = true
            descendant.Handle.Size = Vector3.new(0.5, 0.5, 60)
            descendant.GripPos = Vector3.new(0, 0, 0)
            player.Character:FindFirstChildOfClass('Humanoid'):UnequipTools()
        end
    end
end)
addcmd('boxreach', {}, function(list, player)
    execCmd('unreach')
    wait()
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if not descendant:IsA('Tool') then
            continue
        end
        local x = tonumber(list[1]) or 60
        size = descendant.Handle.Size
        gripPos = descendant.GripPos
        local selectionBox = Instance.new('SelectionBox')
        selectionBox.Name = 'SelectionBoxCreated'
        selectionBox.Parent = descendant.Handle
        selectionBox.Adornee = descendant.Handle
        descendant.Handle.Massless = true
        descendant.Handle.Size = Vector3.new(x, x, x)
        descendant.GripPos = Vector3.new(0, 0, 0)
        player.Character:FindFirstChildOfClass('Humanoid'):UnequipTools()
    end
end)
addcmd('unreach', {'noreach', 'unboxreach'}, function(arg1, player)
    for _, descendant in pairs(player.Character:GetDescendants()) do
        if not descendant:IsA('Tool') then
            continue
        end
        descendant.Handle.Size = size
        descendant.GripPos = gripPos
        descendant.Handle.SelectionBoxCreated:Destroy()
    end
end)
addcmd('grippos', {}, function(list, parent)
    for _, descendant in pairs(parent.Character:GetDescendants()) do
        if not descendant:IsA('Tool') then
            continue
        end
        descendant.Parent = parent:FindFirstChildOfClass('Backpack')
        descendant.GripPos = Vector3.new(list[1], list[2], list[3])
        descendant.Parent = parent.Character
    end
end)
addcmd('usetools', {}, function(list, parent)
    local backpack = parent:FindFirstChildOfClass('Backpack')
    local count = tonumber(list[1]) or 1
    local seconds = tonumber(list[2]) or false
    for _, child in ipairs(backpack:GetChildren()) do
        child.Parent = parent.Character
        task.spawn(function()
            for _ = 1, count do
                child:Activate()
                if not seconds then
                    continue
                end
                wait(seconds)
            end
            child.Parent = backpack
        end)
    end
end)
addcmd('logs', {}, function(arg1, arg2)
    logsEnabled = true
    jLogsEnabled = true
    Toggle.Text = 'Enabled'
    Toggle_2.Text = 'Enabled'
    logs:TweenPosition(UDim2.new(0, 0, 1, -265), 'InOut', 'Quart', 0.3, true, nil)
end)
addcmd('chatlogs', {'clogs'}, function(arg1, arg2)
    logsEnabled = true
    join.Visible = false
    chat.Visible = true
    table.remove(shade3, table.find(shade3, selectChat))
    table.remove(shade2, table.find(shade2, selectJoin))
    table.insert(shade2, selectChat)
    table.insert(shade3, selectJoin)
    selectJoin.BackgroundColor3 = currentShade3
    selectChat.BackgroundColor3 = currentShade2
    Toggle.Text = 'Enabled'
    logs:TweenPosition(UDim2.new(0, 0, 1, -265), 'InOut', 'Quart', 0.3, true, nil)
end)
addcmd('joinlogs', {'jlogs'}, function(arg1, arg2)
    jLogsEnabled = true
    chat.Visible = false
    join.Visible = true
    table.remove(shade3, table.find(shade3, selectJoin))
    table.remove(shade2, table.find(shade2, selectChat))
    table.insert(shade2, selectJoin)
    table.insert(shade3, selectChat)
    selectChat.BackgroundColor3 = currentShade3
    selectJoin.BackgroundColor3 = currentShade2
    Toggle_2.Text = 'Enabled'
    logs:TweenPosition(UDim2.new(0, 0, 1, -265), 'InOut', 'Quart', 0.3, true, nil)
end)
addcmd('chatlogswebhook', {'logswebhook'}, function(list, arg2)
    if not httprequest then
        return notify('Incompatible Exploit', 'Your exploit does not support this command (missing request)')
    end
    logsWebhook = list[1] or nil
    updatesaves()
end)
flinging = false
addcmd('fling', {}, function(arg1, player)
    flinging = false
    for _, descendant in next, player.Character:GetDescendants() do
        if not descendant:IsA('BasePart') then
            continue
        end
        descendant.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
    end
    execCmd('noclip nonotify')
    task.wait(0.1)
    local bodyAngularVelocity = Instance.new('BodyAngularVelocity')
    bodyAngularVelocity.Name = randomString()
    bodyAngularVelocity.Parent = getRoot(player.Character)
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 99999, 0)
    bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
    bodyAngularVelocity.P = math.huge
    for _, child in next, player.Character:GetChildren() do
        if not child:IsA('BasePart') then
            continue
        end
        child.Massless = true
        child.Velocity = Vector3.zero
    end
    flinging = true
    flingDied = player.Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
        execCmd('unfling')
    end)
    repeat
        bodyAngularVelocity.AngularVelocity = Vector3.new(0, 99999, 0)
        task.wait(0.2)
        bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
        task.wait(0.1)
    until flinging == false
end)
addcmd('unfling', {'nofling'}, function(arg1, player)
    execCmd('clip nonotify')
    if flingDied then
        flingDied:Disconnect()
    end
    flinging = false
    task.wait(0.1)
    local character = player.Character
    if not character or not getRoot(character) then
        return
    end
    for _, descendant in next, character:GetDescendants() do
        if descendant:IsA('BasePart') then
            descendant.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
            descendant.Massless = false
            descendant.Velocity = Vector3.zero
        elseif descendant:IsA('BodyAngularVelocity') then
            descendant:Destroy()
        end
    end
end)
addcmd('togglefling', {}, function(arg1, arg2)
    if flinging then
        execCmd('unfling')
        return
    end
    execCmd('fling')
end)
addcmd('flyfling', {}, function(list, arg2)
    execCmd('unvehiclefly\\unwalkfling')
    task.wait()
    vehicleflyspeed = tonumber(list[1]) or vehicleflyspeed
    execCmd('vehiclefly\\walkfling')
end)
addcmd('unflyfling', {}, function(arg1, arg2)
    execCmd('unvehiclefly\\unwalkfling\\breakvelocity')
end)
addcmd('toggleflyfling', {}, function(arg1, arg2)
    execCmd(flinging and 'unflyfling' or 'flyfling')
end)
walkflinging = false
addcmd('walkfling', {}, function(arg1, player)
    execCmd('unwalkfling')
    local humanoid2 = player.Character:FindFirstChildWhichIsA('Humanoid')
    if humanoid2 then
        humanoid2.Died:Connect(function()
            execCmd('unwalkfling')
        end)
    end
    execCmd('noclip nonotify')
    walkflinging = true
    repeat
        RunService.Heartbeat:Wait()
        local character = player.Character
        local root = getRoot(character)
        local velocity
        local y = 0.1
        while not character or not character.Parent or not root or not root.Parent do
            RunService.Heartbeat:Wait()
            character = player.Character
            root = getRoot(character)
        end
        velocity = root.Velocity
        root.Velocity = velocity * 10000 + Vector3.new(0, 10000, 0)
        RunService.RenderStepped:Wait()
        if character and character.Parent and root and root.Parent then
            root.Velocity = velocity
        end
        RunService.Stepped:Wait()
        if character and character.Parent and root and root.Parent then
            root.Velocity = velocity + Vector3.new(0, y, 0)
            y *= -1
        end
    until walkflinging == false
end)
addcmd('unwalkfling', {'nowalkfling'}, function(arg1, arg2)
    walkflinging = false
    execCmd('unnoclip nonotify')
end)
addcmd('togglewalkfling', {}, function(arg1, arg2)
    execCmd(walkflinging and 'unwalkfling' or 'walkfling')
end)
addcmd('invisfling', {}, function(arg1, player)
    local character = player.Character
    character:FindFirstChildWhichIsA('Humanoid'):SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    local model = Instance.new('Model')
    model.Parent = player.Character
    local part = Instance.new('Part')
    part.Name = 'Torso'
    part.CanCollide = false
    part.Anchored = true
    local part2 = Instance.new('Part')
    part2.Name = 'Head'
    part2.Parent = model
    part2.Anchored = true
    part2.CanCollide = false
    local humanoid2 = Instance.new('Humanoid')
    humanoid2.Name = 'Humanoid'
    humanoid2.Parent = model
    part.Position = Vector3.new(0, 9999, 0)
    player.Character = model
    wait(3)
    player.Character = character
    wait(3)
    local humanoid3 = Instance.new('Humanoid')
    part2:Clone()
    humanoid3.Parent = player.Character
    local root = getRoot(player.Character)
    for _, child in pairs(player.Character:GetChildren()) do
        if child ~= root and child.Name ~= 'Humanoid' then
            child:Destroy()
        end
    end
    root.Transparency = 0
    root.Color = Color3.new(1, 1, 1)
    local connection
    connection = RunService.Stepped:Connect(function()
        if player.Character and getRoot(player.Character) then
            getRoot(player.Character).CanCollide = false
            return
        end
        connection:Disconnect()
    end)
    sFLY()
    workspace.CurrentCamera.CameraSubject = root
    local bodyThrust = Instance.new('BodyThrust')
    bodyThrust.Parent = getRoot(player.Character)
    bodyThrust.Force = Vector3.new(99999, 999990, 99999)
    bodyThrust.Location = getRoot(player.Character).Position
end)
addcmd('antifling', {}, function(arg1, arg2)
    if antifling then
        antifling:Disconnect()
        antifling = nil
    end
    antifling = RunService.Stepped:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= arg2 and player.Character then
                for _, descendant in pairs(player.Character:GetDescendants()) do
                    if not descendant:IsA('BasePart') then
                        continue
                    end
                    descendant.CanCollide = false
                end
            end
        end
    end)
end)
addcmd('unantifling', {}, function(arg1, arg2)
    if antifling then
        antifling:Disconnect()
        antifling = nil
    end
end)
addcmd('toggleantifling', {}, function(arg1, arg2)
    execCmd(antifling and 'unantifling' or 'antifling')
end)
attach = function(parent, player)
    if tools(parent) then
        local character = parent.Character
        local _ = player.Character
        local humanoid2 = parent.Character:FindFirstChildOfClass('Humanoid')
        local root = getRoot(parent.Character)
        local root2 = getRoot(player.Character)
        humanoid2.Name = '1'
        local clone = humanoid2:Clone()
        clone.Parent = character
        clone.Name = 'Humanoid'
        wait()
        humanoid2:Destroy()
        workspace.CurrentCamera.CameraSubject = character
        clone.DisplayDistanceType = 'None'
        local tool = parent:FindFirstChildOfClass('Backpack'):FindFirstChildOfClass('Tool') or parent.Character:FindFirstChildOfClass('Tool')
        tool.Parent = character
        root.CFrame = root2.CFrame * CFrame.new(0, 0, 0) * CFrame.new(math.random(-100, 100) / 200, math.random(-100, 100) / 200, math.random(-100, 100) / 200)
        local count = 0
        while true do
            wait(0.1)
            count += 1
            root.CFrame = root2.CFrame
            if tool.Parent == character and root and root2 and root.Parent and root2.Parent and count <= 250 then
                continue
            end
            if count > 2 then
                break
            end
        end
    else
        notify('Tool Required', 'You need to have an item in your inventory to use this command')
    end
end
kill = function(player, player2, arg3)
    if tools(player) then
        if player2 ~= nil then
            local cframe = getRoot(player.Character).CFrame
            if not arg3 then
                refresh(player)
                wait()
                repeat
                    wait()
                until player.Character ~= nil and getRoot(player.Character)
                wait(0.3)
            end
            local root = getRoot(player.Character)
            attach(player, player2)
            repeat
                wait()
                root.CFrame = CFrame.new(999999, workspace.FallenPartsDestroyHeight + 5, 999999)
            until not getRoot(player2.Character) or not getRoot(player.Character)
            local parent = player.CharacterAdded:Wait()
            local instance = parent:FindFirstChildOfClass('Humanoid') or parent.ChildAdded:Wait()
            while not instance:IsA('Humanoid') do
                instance = parent:FindFirstChildOfClass('Humanoid') or parent.ChildAdded:Wait()
            end
            instance.RootPart.CFrame = cframe
        end
    else
        notify('Tool Required', 'You need to have an item in your inventory to use this command')
    end
end
addcmd('handlekill', {'hkill'}, function(list, player)
    if not firetouchinterest then
        return notify('Incompatible Exploit', 'Your exploit does not support this command (missing firetouchinterest)')
    end
    if not player.Character then
        return
    end
    local tool = player.Character:FindFirstChildWhichIsA('Tool')
    local handle = tool and tool:FindFirstChild('Handle')
    if not handle then
        return notify('Handle Kill', 'You need to hold a "Tool" that does damage on touch. For example a common Sword tool.')
    end
    local value = tonumber(list[2]) or math.huge
    if value ~= math.huge then
        notify('Handle Kill', ('Started!\nRadius: %s'):format(tostring(value):upper()))
    end
    while task.wait() and player.Character and tool.Parent and tool.Parent == player.Character do
        for _, v in next, getPlayer(list[1], player) do
            local player2 = Players[v]
            if player2 ~= player and player2.Character then
                local humanoid2 = player2.Character:FindFirstChildWhichIsA('Humanoid')
                local root = humanoid2 and getRoot(player2.Character)
                if root and humanoid2.Health > 0 and humanoid2:GetState() ~= Enum.HumanoidStateType.Dead and player:DistanceFromCharacter(root.Position) <= value then
                    firetouchinterest(handle, root, 1)
                    firetouchinterest(handle, root, 0)
                end
            end
        end
    end
    notify('Handle Kill', 'Stopped!')
end)
tpwalkStack = 0
addcmd('teleportwalk', {'tpwalk'}, function(list, player)
    pcall(function()
        tpwalking:Disconnect()
    end)
    local character = player.Character
    local humanoid2 = character and character:FindFirstChildWhichIsA('Humanoid')
    local v1 = list[1] and isNumber(list[1]) and tonumber(list[1]) or 1
    if parseBoolean(list[2]) then
        tpwalkStack = tpwalkStack + v1
    end
    tpwalking = RunService.Heartbeat:Connect(function(deltaTime)
        if not character or not humanoid2 or not humanoid2.Parent then
            tpwalking:Disconnect()
            return
        end
        if humanoid2.MoveDirection.Magnitude > 0 then
            character:TranslateBy(humanoid2.MoveDirection * (v1 + tpwalkStack) * deltaTime * 10)
        end
    end)
end)
addcmd('unteleportwalk', {'untpwalk'}, function(arg1, arg2)
    tpwalkStack = 0
    tpwalking:Disconnect()
end)
bring = function(player, player2, arg3)
    if tools(player) then
        if player2 ~= nil then
            local cframe = getRoot(player.Character).CFrame
            if not arg3 then
                refresh(player)
                wait()
                repeat
                    wait()
                until player.Character ~= nil and getRoot(player.Character)
                wait(0.3)
            end
            local root = getRoot(player.Character)
            attach(player, player2)
            repeat
                wait()
                root.CFrame = cframe
            until not getRoot(player2.Character) or not getRoot(player.Character)
            local parent = player.CharacterAdded:Wait()
            local instance = parent:FindFirstChildOfClass('Humanoid') or parent.ChildAdded:Wait()
            while not instance:IsA('Humanoid') do
                instance = parent:FindFirstChildOfClass('Humanoid') or parent.ChildAdded:Wait()
            end
            instance.RootPart.CFrame = cframe
        end
    else
        notify('Tool Required', 'You need to have an item in your inventory to use this command')
    end
end
teleport = function(player, player2, player3, arg4)
    if tools(player) then
        if player2 ~= nil then
            local cframe = getRoot(player.Character).CFrame
            if not arg4 then
                refresh(player)
                wait()
                repeat
                    wait()
                until player.Character ~= nil and getRoot(player.Character)
                wait(0.3)
            end
            local root = getRoot(player.Character)
            local root2 = getRoot(player3.Character)
            attach(player, player2)
            repeat
                wait()
                root.CFrame = root2.CFrame
            until not getRoot(player2.Character) or not getRoot(player.Character)
            wait(1)
            local parent = player.CharacterAdded:Wait()
            local instance = parent:FindFirstChildOfClass('Humanoid') or parent.ChildAdded:Wait()
            while not instance:IsA('Humanoid') do
                instance = parent:FindFirstChildOfClass('Humanoid') or parent.ChildAdded:Wait()
            end
            instance.RootPart.CFrame = cframe
        end
    else
        notify('Tool Required', 'You need to have an item in your inventory to use this command')
    end
end
addcmd('spin', {}, function(list, player)
    local first = 20
    if list[1] and isNumber(list[1]) then
        first = list[1]
    end
    for _, child in pairs(getRoot(player.Character):GetChildren()) do
        if child.Name ~= 'Spinning' then
            continue
        end
        child:Destroy()
    end
    local bodyAngularVelocity = Instance.new('BodyAngularVelocity')
    bodyAngularVelocity.Name = 'Spinning'
    bodyAngularVelocity.Parent = getRoot(player.Character)
    bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, first, 0)
end)
addcmd('unspin', {}, function(arg1, player)
    for _, child in pairs(getRoot(player.Character):GetChildren()) do
        if child.Name ~= 'Spinning' then
            continue
        end
        child:Destroy()
    end
end)
xrayEnabled = false
xray = function()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA('BasePart') and not descendant.Parent:FindFirstChildWhichIsA('Humanoid') and not descendant.Parent.Parent:FindFirstChildWhichIsA('Humanoid') then
            descendant.LocalTransparencyModifier = xrayEnabled and 0.5 or 0
        end
    end
end
addcmd('xray', {}, function(arg1, arg2)
    xrayEnabled = true
    xray()
end)
addcmd('unxray', {'noxray'}, function(arg1, arg2)
    xrayEnabled = false
    xray()
end)
addcmd('togglexray', {}, function(arg1, arg2)
    xrayEnabled = not xrayEnabled
    xray()
end)
addcmd('loopxray', {}, function(arg1, arg2)
    pcall(function()
        xrayLoop:Disconnect()
    end)
    xrayLoop = RunService.RenderStepped:Connect(function()
        xrayEnabled = true
        xray()
    end)
end)
addcmd('unloopxray', {}, function(arg1, arg2)
    pcall(function()
        xrayLoop:Disconnect()
    end)
    xrayEnabled = false
    xray()
end)
local connection17
addcmd('walltp', {}, function(arg1, player)
    local part
    part = if r15(player) then player.Character.UpperTorso else player.Character.Torso
    local function touchedFunc(otherPart)
        local root = getRoot(player.Character)
        if otherPart:IsA('BasePart') and otherPart.Position.Y > root.Position.Y - player.Character:FindFirstChildOfClass('Humanoid').HipHeight then
            local root2 = getRoot(otherPart.Parent)
            if root2 ~= nil then
                root.CFrame = otherPart.CFrame * CFrame.new(root.CFrame.lookVector.X, root2.Size.Z / 2 + player.Character:FindFirstChildOfClass('Humanoid').HipHeight, root.CFrame.lookVector.Z)
                return
            end
            if root2 == nil then
                root.CFrame = otherPart.CFrame * CFrame.new(root.CFrame.lookVector.X, otherPart.Size.Y / 2 + player.Character:FindFirstChildOfClass('Humanoid').HipHeight, root.CFrame.lookVector.Z)
            end
        end
    end
    connection17 = part.Touched:Connect(touchedFunc)
end)
addcmd('unwalltp', {'nowalltp'}, function(arg1, arg2)
    if connection17 then
        connection17:Disconnect()
    end
end)
autoclicking = false
addcmd('autoclick', {}, function(list, arg2)
    if mouse1press and mouse1release then
        execCmd('unautoclick')
        wait()
        local first = 0.1
        local second = 0.1
        if list[1] and isNumber(list[1]) then
            first = list[1]
        end
        if list[2] and isNumber(list[2]) then
            second = list[2]
        end
        autoclicking = true
        cancelAutoClick = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and (input.KeyCode == Enum.KeyCode.Backspace and UserInputService:IsKeyDown(Enum.KeyCode.Equals) or input.KeyCode == Enum.KeyCode.Equals and UserInputService:IsKeyDown(Enum.KeyCode.Backspace)) then
                autoclicking = false
                cancelAutoClick:Disconnect()
            end
        end)
        notify('Auto Clicker', 'Press [backspace] and [=] at the same time to stop')
        while true do
            wait(first)
            mouse1press()
            wait(second)
            mouse1release()
            if autoclicking == false then
                break
            end
        end
    else
        notify('Auto Clicker', 'Your exploit doesn\'t have the ability to use the autoclick')
    end
end)
addcmd('unautoclick', {'noautoclick'}, function(arg1, arg2)
    autoclicking = false
    if cancelAutoClick then
        cancelAutoClick:Disconnect()
    end
end)
addcmd('mousesensitivity', {'ms'}, function(list, arg2)
    UserInputService.MouseDeltaSensitivity = list[1]
end)
local label2
local v6
addcmd('hovername', {}, function(arg1, arg2)
    execCmd('unhovername')
    wait()
    label2 = Instance.new('TextLabel')
    label2.Name = randomString()
    label2.Parent = ScaledHolder
    label2.BackgroundTransparency = 1
    label2.Size = UDim2.new(0, 200, 0, 30)
    label2.Font = Enum.Font.Code
    label2.TextSize = 16
    label2.Text = ''
    label2.TextColor3 = Color3.new(1, 1, 1)
    label2.TextStrokeTransparency = 0
    label2.TextXAlignment = Enum.TextXAlignment.Left
    label2.ZIndex = 10
    v6 = Instance.new('SelectionBox')
    v6.Name = randomString()
    v6.LineThickness = 0.03
    v6.Color3 = Color3.new(1, 1, 1)
    local function updateNameBox()
        local parent
        local target = IYMouse.Target
        if target then
            local humanoid2 = target.Parent:FindFirstChildOfClass('Humanoid') or target.Parent.Parent:FindFirstChildOfClass('Humanoid')
            if humanoid2 then
                parent = humanoid2.Parent
            end
        end
        if parent ~= nil then
            local x = IYMouse.X
            local y = IYMouse.Y
            local xOffset
            if IYMouse.X > 200 then
                xOffset = x - 205
                label2.TextXAlignment = Enum.TextXAlignment.Right
            else
                xOffset = x + 25
                label2.TextXAlignment = Enum.TextXAlignment.Left
            end
            label2.Position = UDim2.new(0, xOffset, 0, y)
            label2.Text = parent.Name
            label2.Visible = true
            v6.Parent = parent
            v6.Adornee = parent
            return
        end
        label2.Visible = false
        v6.Parent = nil
        v6.Adornee = nil
    end
    nbUpdateFunc = IYMouse.Move:Connect(updateNameBox)
end)
addcmd('unhovername', {'nohovername'}, function(arg1, arg2)
    if nbUpdateFunc then
        nbUpdateFunc:Disconnect()
        label2:Destroy()
        v6:Destroy()
    end
end)
addcmd('headsize', {}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        if Players[v] ~= arg2 and Players[v].Character:FindFirstChild('Head') then
            local number = tonumber(list[2])
            local vector3 = Vector3.new(number, number, number)
            local head = Players[v].Character:FindFirstChild('Head')
            if not head:IsA('BasePart') then
                continue
            end
            head.CanCollide = false
            if not list[2] or number == 1 then
                head.Size = Vector3.new(2, 1, 1)
            else
                head.Size = vector3
            end
        end
    end
end)
addcmd('hitbox', {}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    local transparency = list[3] and tonumber(list[3]) or 0.4
    for _, v in pairs(player) do
        if Players[v] ~= arg2 and getRoot(Players[v].Character) then
            local number = tonumber(list[2])
            local vector3 = Vector3.new(number, number, number)
            local root = getRoot(Players[v].Character)
            if not root:IsA('BasePart') then
                continue
            end
            root.CanCollide = false
            if not list[2] or number == 1 then
                root.Size = Vector3.new(2, 1, 1)
                root.Transparency = transparency
            else
                root.Size = vector3
                root.Transparency = transparency
            end
        end
    end
end)
addcmd('hitboxes', {}, function(arg1, arg2)
    settings():GetService('RenderSettings').ShowBoundingBoxes = true
end)
addcmd('unhitboxes', {}, function(arg1, arg2)
    settings():GetService('RenderSettings').ShowBoundingBoxes = false
end)
addcmd('stareat', {'stare'}, function(list, arg2)
    local player = getPlayer(list[1], arg2)
    for _, v in pairs(player) do
        if stareLoop then
            stareLoop:Disconnect()
        end
        if not getRoot(Players.LocalPlayer.Character) and getRoot(Players[v].Character) then
            return
        end
        local function stareFunc()
            if Players.LocalPlayer.Character.PrimaryPart and Players:FindFirstChild(v) and Players[v].Character ~= nil and getRoot(Players[v].Character) then
                local position = Players.LocalPlayer.Character.PrimaryPart.Position
                local position2 = getRoot(Players[v].Character).Position
                local vector3 = Vector3.new(position2.X, position.Y, position2.Z)
                local cframe = CFrame.new(position, vector3)
                Players.LocalPlayer.Character:SetPrimaryPartCFrame(cframe)
                return
            end
            if not Players:FindFirstChild(v) then
                stareLoop:Disconnect()
            end
        end
        stareLoop = RunService.RenderStepped:Connect(stareFunc)
    end
end)
addcmd('unstareat', {'unstare', 'nostare', 'nostareat'}, function(arg1, arg2)
    if stareLoop then
        stareLoop:Disconnect()
    end
end)
RolewatchData = {Group = 0, Role = '', Leave = false}
RolewatchConnection = Players.PlayerAdded:Connect(function(player)
    if RolewatchData.Group == 0 then
        return
    end
    if player:IsInGroup(RolewatchData.Group) and tostring(player:GetRoleInGroup(RolewatchData.Group)):lower() == RolewatchData.Role:lower() then
        if RolewatchData.Leave == true then
            Players.LocalPlayer:Kick('\n\nRolewatch\nPlayer "' .. tostring(player.Name) .. '" has joined with the Role "' .. RolewatchData.Role .. '"\n')
            return
        end
        notify('Rolewatch', 'Player "' .. tostring(player.Name) .. '" has joined with the Role "' .. RolewatchData.Role .. '"')
    end
end)
addcmd('rolewatch', {}, function(list, arg2)
    local number = tonumber(list[1] or 0)
    local tostring2 = list[2]
    if tostring2 then
        tostring2 = tostring
        tostring2 = tostring2(getstring(2, list))
    end
    if number and tostring2 then
        RolewatchData.Group = number
        RolewatchData.Role = tostring2
        notify('Rolewatch', 'Watching Group ID "' .. tostring(number) .. '" for Role "' .. tostring2 .. '"')
    end
end)
addcmd('rolewatchstop', {}, function(arg1, arg2)
    RolewatchData.Group = 0
    RolewatchData.Role = ''
    RolewatchData.Leave = false
    notify('Rolewatch', 'Disabled')
end)
addcmd('rolewatchleave', {'unrolewatch'}, function(arg1, arg2)
    RolewatchData.Leave = not RolewatchData.Leave
    notify('Rolewatch', RolewatchData.Leave and 'Leave has been Enabled' or 'Leave has been Disabled')
end)
staffRoles = {'mod', 'admin', 'staff', 'dev', 'founder', 'owner', 'supervis', 'manager', 'management', 'executive', 'president', 'chairman', 'chairwoman', 'chairperson', 'director'}
getStaffRole = function(player)
    local roleInGroup = player:GetRoleInGroup(game.CreatorId)
    local data = {Role = roleInGroup, Staff = false}
    if player:IsInGroup(1200769) then
        data.Role = 'Roblox Employee'
        data.Staff = true
    end
    for _, staffRole in pairs(staffRoles) do
        if not string.find(string.lower(roleInGroup), staffRole) then
            continue
        end
        data.Staff = true
    end
    return data
end
addcmd('staffwatch', {}, function(arg1, arg2)
    if staffwatchjoin then
        staffwatchjoin:Disconnect()
    end
    if game.CreatorType == Enum.CreatorType.Group then
        local list = {}
        staffwatchjoin = Players.PlayerAdded:Connect(function(player)
            local staffRole = getStaffRole(player)
            if staffRole.Staff then
                notify('Staffwatch', formatUsername(player) .. ' is a ' .. staffRole.Role)
            end
        end)
        for _, player in pairs(Players:GetPlayers()) do
            local staffRole = getStaffRole(player)
            if not staffRole.Staff then
                continue
            end
            table.insert(list, formatUsername(player) .. ' is a ' .. staffRole.Role)
        end
        if #list > 0 then
            notify('Staffwatch', table.concat(list, ',\n'))
            return
        end
        notify('Staffwatch', 'Enabled')
        return
    end
    notify('Staffwatch', 'Game is not owned by a Group')
end)
addcmd('unstaffwatch', {}, function(arg1, arg2)
    if staffwatchjoin then
        staffwatchjoin:Disconnect()
    end
    notify('Staffwatch', 'Disabled')
end)
local function playerGroups()
    local players = Players:GetPlayers()
    local map = {}
    local set = {}
    local list = {}
    for _, player in ipairs(players) do
        map[player] = {}
    end
    for i = 1, #players do
        for j = i + 1, #players do
            local item = players[i]
            local item2 = players[j]
            local success, result = pcall(function()
                return item:IsFriendsWithAsync(item2.UserId)
            end)
            if success and result then
                table.insert(map[item], item2)
                table.insert(map[item2], item)
            end
        end
    end
    local function dfs(item, list)
        set[item] = true
        table.insert(list, item)
        for _, v in ipairs(map[item]) do
            if set[v] then
                continue
            end
            dfs(v, list)
        end
    end
    for _, player in ipairs(players) do
        if set[player] then
            continue
        end
        local item3 = {}
        dfs(player, item3)
        table.insert(list, item3)
    end
    return list
end
addcmd('findfriendgroups', {}, function(arg1, arg2)
    notify('Checking Players', 'This might take a while (slow function)')
    local list = playerGroups()
    local coreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList)
    local text = ''
    local count = 1
    local count2 = 0
    for _, v in ipairs(list) do
        if #v == 1 then
            continue
        end
        local list2 = {}
        for _, v2 in ipairs(v) do
            table.insert(list2, coreGuiEnabled and v2.DisplayName or v2.Name)
        end
        text ..= count .. '. ' .. table.concat(list2, ', ') .. '\n'
        count += 1
        count2 += 1
    end
    createPopup('Friend Groups', count2 == 0 and 'None' or text)
end)
addcmd('removeterrain', {'rterrain', 'noterrain'}, function(arg1, arg2)
    workspace:FindFirstChildOfClass('Terrain'):Clear()
end)
addcmd('clearnilinstances', {'nonilinstances', 'cni'}, function(arg1, arg2)
    if getnilinstances then
        for _, getnilinstance in pairs(getnilinstances()) do
            getnilinstance:Destroy()
        end
        return
    end
    notify('Incompatible Exploit', 'Your exploit does not support this command (missing getnilinstances)')
end)
addcmd('destroyheight', {'dh'}, function(list, arg2)
    local fallenPartsDestroyHeight = list[1] or -500
    if isNumber(fallenPartsDestroyHeight) then
        workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight
    end
end)
OrgDestroyHeight = workspace.FallenPartsDestroyHeight
addcmd('antivoid', {}, function(list, player)
    execCmd('unantivoid nonotify')
    task.wait()
    antivoidloop = RunService.Stepped:Connect(function()
        local root = getRoot(player.Character)
        if root and root.Position.Y <= OrgDestroyHeight + 25 then
            root.Velocity = root.Velocity + Vector3.new(0, 250, 0)
        end
    end)
    if list[1] ~= 'nonotify' then
        notify('antivoid', 'Enabled')
    end
end)
addcmd('unantivoid', {'noantivoid'}, function(list, arg2)
    pcall(function()
        antivoidloop:Disconnect()
    end)
    antivoidloop = nil
    if list[1] ~= 'nonotify' then
        notify('antivoid', 'Disabled')
    end
end)
antivoidWasEnabled = false
addcmd('fakeout', {}, function(arg1, player)
    local root = getRoot(player.Character)
    local cframe = root.CFrame
    if antivoidloop then
        execCmd('unantivoid nonotify')
        antivoidWasEnabled = true
    end
    workspace.FallenPartsDestroyHeight = 0 / 0
    root.CFrame = CFrame.new(Vector3.new(0, OrgDestroyHeight - 25, 0))
    task.wait(1)
    root.CFrame = cframe
    workspace.FallenPartsDestroyHeight = OrgDestroyHeight
    if antivoidWasEnabled then
        execCmd('antivoid nonotify')
        antivoidWasEnabled = false
    end
end)
addcmd('trip', {}, function(arg1, player)
    local humanoid2 = player.Character and player.Character:FindFirstChildWhichIsA('Humanoid')
    local root = player.Character and getRoot(player.Character)
    if humanoid2 and root then
        humanoid2:ChangeState(Enum.HumanoidStateType.FallingDown)
        root.Velocity = root.CFrame.LookVector * 30
    end
end)
addcmd('removeads', {'adblock'}, function(arg1, arg2)
    while wait() do
        pcall(function()
            for _, descendant in pairs(workspace:GetDescendants()) do
                if not descendant:IsA('PackageLink') then
                    continue
                end
                if descendant.Parent:FindFirstChild('ADpart') then
                    descendant.Parent:Destroy()
                end
                if not descendant.Parent:FindFirstChild('AdGuiAdornee') then
                    continue
                end
                descendant.Parent.Parent:Destroy()
            end
        end)
    end
end)
addcmd('scare', {'spook'}, function(list, player)
    local player2 = getPlayer(list[1], player)
    local cframe
    for _, v in pairs(player2) do
        local root = player.Character and getRoot(player.Character)
        local player3 = Players[v]
        local root2 = player3 and player3.Character and getRoot(player3.Character)
        if root and root2 and player3 ~= player then
            cframe = root.CFrame
            root.CFrame = root2.CFrame + root2.CFrame.lookVector * 2
            root.CFrame = CFrame.new(root.Position, root2.Position)
            task.wait(0.5)
            root.CFrame = cframe
        end
    end
end)
addcmd('alignmentkeys', {}, function(arg1, arg2)
    alignmentKeys = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then
            return
        end
        if input.KeyCode == Enum.KeyCode.Comma then
            workspace.CurrentCamera:PanUnits(-1)
        end
        if input.KeyCode == Enum.KeyCode.Period then
            workspace.CurrentCamera:PanUnits(1)
        end
    end)
    alignmentKeysEmotes = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu)
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
end)
addcmd('unalignmentkeys', {'noalignmentkeys'}, function(arg1, arg2)
    if type(alignmentKeysEmotes) == 'boolean' then
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, alignmentKeysEmotes)
    end
    alignmentKeys:Disconnect()
end)
addcmd('ctrllock', {}, function(arg1, arg2)
    local mouseLockController = arg2.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild('CameraModule'):WaitForChild('MouseLockController')
    local boundKeys = mouseLockController:FindFirstChild('BoundKeys')
    if boundKeys then
        boundKeys.Value = 'LeftControl'
        return
    end
    boundKeys = Instance.new('StringValue')
    boundKeys.Name = 'BoundKeys'
    boundKeys.Value = 'LeftControl'
    boundKeys.Parent = mouseLockController
end)
addcmd('unctrllock', {}, function(arg1, arg2)
    local mouseLockController = arg2.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild('CameraModule'):WaitForChild('MouseLockController')
    local boundKeys = mouseLockController:FindFirstChild('BoundKeys')
    if boundKeys then
        boundKeys.Value = 'LeftShift'
        return
    end
    boundKeys = Instance.new('StringValue')
    boundKeys.Name = 'BoundKeys'
    boundKeys.Value = 'LeftShift'
    boundKeys.Parent = mouseLockController
end)
addcmd('listento', {}, function(list, arg2)
    execCmd('unlistento')
    if not list[1] then
        return
    end
    local firstChild = Players:FindFirstChild(getPlayer(list[1], arg2)[1])
    local root = firstChild and firstChild.Character and getRoot(firstChild.Character)
    if root then
        SoundService:SetListener(Enum.ListenerType.ObjectPosition, root)
        listentoChar = firstChild.CharacterAdded:Connect(function()
            repeat
                task.wait()
            until Players[firstChild.Name].Character ~= nil and getRoot(Players[firstChild.Name].Character)
            SoundService:SetListener(Enum.ListenerType.ObjectPosition, getRoot(Players[firstChild.Name].Character))
        end)
    end
end)
addcmd('unlistento', {}, function(arg1, arg2)
    SoundService:SetListener(Enum.ListenerType.Camera)
    listentoChar:Disconnect()
end)
addcmd('jerk', {}, function(arg1, parent)
    local humanoid2 = parent.Character:FindFirstChildWhichIsA('Humanoid')
    local backpack = parent:FindFirstChildWhichIsA('Backpack')
    if not humanoid2 or not backpack then
        return
    else
        local tool = Instance.new('Tool')
        tool.Name = 'Jerk Off'
        tool.ToolTip = 'in the stripped club. straight up "jorking it" . and by "it" , haha, well. let\'s justr say. My peanits.'
        tool.RequiresHandle = false
        tool.Parent = backpack
        local flag = false
        local animationTrack
        local function stopTomfoolery()
            flag = false
            if animationTrack then
                animationTrack:Stop()
                animationTrack = nil
            end
        end
        tool.Equipped:Connect(function()
            flag = true
        end)
        tool.Unequipped:Connect(stopTomfoolery)
        humanoid2.Died:Connect(stopTomfoolery)
        while task.wait() do
            if not flag then
                continue
            end
            local result = r15(parent)
            if not animationTrack then
                local animation = Instance.new('Animation')
                animation.AnimationId = not result and 'rbxassetid://72042024' or 'rbxassetid://698251653'
                animationTrack = humanoid2:LoadAnimation(animation)
            end
            animationTrack:Play()
            animationTrack:AdjustSpeed(result and 0.7 or 0.65)
            animationTrack.TimePosition = 0.6
            task.wait(0.1)
            while animationTrack and animationTrack.TimePosition < (not result and 0.65 or 0.7) do
                task.wait(0.1)
            end
            if not animationTrack then
                continue
            end
            animationTrack:Stop()
            animationTrack = nil
        end
    end
end)
addcmd('guiscale', {}, function(list, arg2)
    if list[1] and isNumber(list[1]) then
        local number = tonumber(list[1])
        if number % 1 == 0 then
            number /= 100
        end
        if number == 0.01 then
            number = 1
        end
        if number == 0.02 then
            number = 2
        end
        if number >= 0.4 and number <= 2 then
            guiScale = number
        end
    else
        guiScale = defaultGuiScale
    end
    Scale.Scale = math.max(Holder.AbsoluteSize.X / 1920, guiScale)
    updatesaves()
end)
addcmd('muteallvoices', {'muteallvcs'}, function(arg1, arg2)
    Services.VoiceChatInternal:SubscribePauseAll(true)
end)
addcmd('unmuteallvoices', {'unmuteallvcs'}, function(arg1, arg2)
    Services.VoiceChatInternal:SubscribePauseAll(false)
end)
addcmd('mutevc', {}, function(list, arg2)
    for _, v in getPlayer(list[1], arg2) do
        if Players[v] == arg2 then
            continue
        end
        Services.VoiceChatInternal:SubscribePause(Players[v].UserId, true)
    end
end)
addcmd('unmutevc', {}, function(list, arg2)
    for _, v in getPlayer(list[1], arg2) do
        if Players[v] == arg2 then
            continue
        end
        Services.VoiceChatInternal:SubscribePause(Players[v].UserId, false)
    end
end)
addcmd('phonebook', {'call'}, function(arg1, arg2)
    local success, result = pcall(function()
        return SocialService:CanSendCallInviteAsync(arg2)
    end)
    if success and result then
        SocialService:PromptPhoneBook(arg2, '')
        return
    end
    notify('Phonebook', 'It seems you\'re not able to call anyone. Sorry!')
end)
local connection18
frozenParts = {}
addcmd('freezeunanchored', {'freezeua'}, function(arg1, player)
    local names = {'Head', 'UpperTorso', 'LowerTorso', 'RightUpperArm', 'LeftUpperArm', 'RightLowerArm', 'LeftLowerArm', 'RightHand', 'LeftHand', 'RightUpperLeg', 'LeftUpperLeg', 'RightLowerLeg', 'LeftLowerLeg', 'RightFoot', 'LeftFoot', 'Torso', 'Right Arm', 'Left Arm', 'Right Leg', 'Left Leg', 'HumanoidRootPart'}
    local function FREEZENOOB(descendant)
        if descendant:IsA('BasePart') and descendant.Anchored == false then
            local flag = false
            for i = 1, #names do
                if descendant.Name ~= names[i] then
                    continue
                end
                flag = true
            end
            if player.Character and descendant:IsDescendantOf(player.Character) then
                flag = true
            end
            if flag == false then
                for _, child in pairs(descendant:GetChildren()) do
                    if not child:IsA('BodyPosition') and not child:IsA('BodyGyro') then
                        continue
                    end
                    child:Destroy()
                end
                local bodyPosition = Instance.new('BodyPosition')
                bodyPosition.Parent = descendant
                bodyPosition.Position = descendant.Position
                bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                local bodyGyro = Instance.new('BodyGyro')
                bodyGyro.Parent = descendant
                bodyGyro.CFrame = descendant.CFrame
                bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                if not table.find(frozenParts, descendant) then
                    table.insert(frozenParts, descendant)
                end
            end
        end
    end
    for _, descendant in pairs(workspace:GetDescendants()) do
        FREEZENOOB(descendant)
    end
    connection18 = workspace.DescendantAdded:Connect(FREEZENOOB)
end)
addcmd('thawunanchored', {'thawua', 'unfreezeunanchored', 'unfreezeua'}, function(arg1, arg2)
    if connection18 then
        connection18:Disconnect()
    end
    for _, frozenPart in pairs(frozenParts) do
        for _, child in pairs(frozenPart:GetChildren()) do
            if not child:IsA('BodyPosition') and not child:IsA('BodyGyro') then
                continue
            end
            child:Destroy()
        end
    end
    frozenParts = {}
end)
addcmd('tpunanchored', {'tpua'}, function(list, player)
    local player2 = getPlayer(list[1], player)
    for _, v in pairs(player2) do
        local list2 = {}
        for _, descendant in pairs(workspace:GetDescendants()) do
            if Players[v].Character:FindFirstChild('Head') and descendant:IsA('BasePart') and descendant.Anchored == false and not descendant:IsDescendantOf(player.Character) then
                if descendant.Name == 'Torso' == false and descendant.Name == 'Head' == false and descendant.Name == 'Right Arm' == false and descendant.Name == 'Left Arm' == false and descendant.Name == 'Right Leg' == false and descendant.Name == 'Left Leg' == false and descendant.Name == 'HumanoidRootPart' == false then
                    for _, child in pairs(descendant:GetChildren()) do
                        if not child:IsA('BodyPosition') and not child:IsA('BodyGyro') then
                            continue
                        end
                        child:Destroy()
                    end
                    local bodyPosition = Instance.new('BodyPosition')
                    bodyPosition.Parent = descendant
                    bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    table.insert(list2, bodyPosition)
                    if table.find(frozenParts, descendant) then
                        continue
                    end
                    table.insert(frozenParts, descendant)
                end
            end
        end
        for _, v2 in pairs(list2) do
            v2.Position = Players[v].Character.Head.Position
        end
    end
end)
keycodeMap = {['0'] = 48, ['1'] = 49, ['2'] = 50, ['3'] = 51, ['4'] = 52, ['5'] = 53, ['6'] = 54, ['7'] = 55, ['8'] = 56, ['9'] = 57, a = 65, b = 66, c = 67, d = 68, e = 69, f = 70, g = 71, h = 72, i = 73, j = 74, k = 75, l = 76, m = 77, n = 78, o = 79, p = 80, q = 81, r = 82, s = 83, t = 84, u = 85, v = 86, w = 87, x = 88, y = 89, z = 90, enter = 13, shift = 16, ctrl = 17, alt = 18, pause = 19, capslock = 20, spacebar = 32, space = 32, pageup = 33, pagedown = 34, ['end'] = 35, home = 36, left = 37, up = 38, right = 39, down = 40, insert = 45, delete = 46, f1 = 112, f2 = 113, f3 = 114, f4 = 115, f5 = 116, f6 = 117, f7 = 118, f8 = 119, f9 = 120, f10 = 121, f11 = 122, f12 = 123}
autoKeyPressing = false
cancelAutoKeyPress = nil
addcmd('autokeypress', {'keypress'}, function(list, arg2)
    if keypress and keyrelease and list[1] then
        local v1 = keycodeMap[list[1]:lower()]
        if not v1 then
            notify('Auto Key Press', 'Invalid key')
            return
        end
        execCmd('unautokeypress')
        wait()
        local second = 0.1
        local third = 0.1
        if list[2] and isNumber(list[2]) then
            second = list[2]
        end
        if list[3] and isNumber(list[3]) then
            third = list[3]
        end
        autoKeyPressing = true
        cancelAutoKeyPress = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and (input.KeyCode == Enum.KeyCode.Backspace and UserInputService:IsKeyDown(Enum.KeyCode.Equals) or input.KeyCode == Enum.KeyCode.Equals and UserInputService:IsKeyDown(Enum.KeyCode.Backspace)) then
                autoKeyPressing = false
                cancelAutoKeyPress:Disconnect()
            end
        end)
        notify('Auto Key Press', 'Press [backspace] and [=] at the same time to stop')
        repeat
            wait(second)
            keypress(v1)
            wait(third)
            keyrelease(v1)
        until autoKeyPressing == false
        if cancelAutoKeyPress then
            cancelAutoKeyPress:Disconnect()
            keyrelease(v1)
        end
    else
        notify('Auto Key Press', 'Your exploit doesn\'t have the ability to use auto key press')
    end
end)
addcmd('unautokeypress', {'noautokeypress', 'unkeypress', 'nokeypress'}, function(arg1, arg2)
    autoKeyPressing = false
    if cancelAutoKeyPress then
        cancelAutoKeyPress:Disconnect()
    end
end)
addcmd('addplugin', {'plugin'}, function(arg1, arg2)
    addPlugin(getstring(1, arg1))
end)
addcmd('removeplugin', {'deleteplugin'}, function(arg1, arg2)
    deletePlugin(getstring(1, arg1))
end)
addcmd('reloadplugin', {}, function(arg1, arg2)
    local result = getstring(1, arg1)
    deletePlugin(result)
    wait(1)
    addPlugin(result)
end)
addcmd('addallplugins', {'loadallplugins'}, function(arg1, arg2)
    if not listfiles or not isfolder then
        notify('Incompatible Exploit', 'Your exploit does not support this command (missing listfiles/isfolder)')
        return
    end
    for _, listfile in ipairs(listfiles('')) do
        local text = listfile:match('([^/\\]+%.iy)$')
        if text and text:lower() ~= 'iy_fe.iy' and not isfolder(text) and not table.find(PluginsTable, text) then
            addPlugin(text)
        end
    end
end)
addcmd('removecmd', {'deletecmd'}, function(list, arg2)
    removecmd(list[1])
end)
addcmd('debug', {}, function(list, arg2)
    _G.IY_DEBUG = parseBoolean(list[1], true)
    if _G.IY_DEBUG then
        return 'Enabled'
    end
    return 'Disabled'
end)
if IsOnMobile then
    local textButton = Instance.new('TextButton')
    local uiCorner = Instance.new('UICorner')
    textButton.Name = randomString()
    textButton.Parent = PARENT
    textButton.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
    textButton.BackgroundTransparency = 0.14
    textButton.Position = UDim2.new(0.489, 0, 0, 0)
    textButton.Size = UDim2.new(0, 32, 0, 33)
    textButton.Font = Enum.Font.SourceSansBold
    textButton.Text = 'IY'
    textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton.TextSize = 20
    textButton.TextWrapped = true
    textButton.ZIndex = 10
    textButton.Draggable = true
    uiCorner.Name = randomString()
    uiCorner.CornerRadius = UDim.new(0.5, 0)
    uiCorner.Parent = textButton
    textButton.MouseButton1Click:Connect(function()
        Cmdbar:CaptureFocus()
        maximizeHolder()
    end)
    table.insert(shade1, textButton)
    table.insert(text1, textButton)
end
pcall(function()
    Scale.Scale = math.max(Holder.AbsoluteSize.X / 1920, guiScale)
end)
Scale.Parent = ScaledHolder
ScaledHolder.Size = UDim2.fromScale(1 / Scale.Scale, 1 / Scale.Scale)
Scale:GetPropertyChangedSignal('Scale'):Connect(function()
    ScaledHolder.Size = UDim2.fromScale(1 / Scale.Scale, 1 / Scale.Scale)
    for _, descendant in ScaledHolder:GetDescendants() do
        if descendant:IsA('GuiObject') and descendant.Visible then
            descendant.Visible = false
            descendant.Visible = true
        end
    end
end)
updateColors(currentShade1, shade1)
updateColors(currentShade2, shade2)
updateColors(currentShade3, shade3)
updateColors(currentText1, text1)
updateColors(currentText2, text2)
updateColors(currentScroll, scroll)
if PluginsTable ~= nil or PluginsTable ~= {} then
    FindPlugins(PluginsTable)
end
eventEditor.RegisterEvent('OnExecute')
eventEditor.RegisterEvent('OnSpawn', {{Type = 'Player', Name = 'Player Filter ($1)'}})
eventEditor.RegisterEvent('OnDied', {{Type = 'Player', Name = 'Player Filter ($1)'}})
eventEditor.RegisterEvent('OnDamage', {{Type = 'Player', Name = 'Player Filter ($1)'}, {Type = 'Number', Name = 'Below Health ($2)'}})
eventEditor.RegisterEvent('OnKilled', {{Type = 'Player', Name = 'Victim Player ($1)'}, {Type = 'Player', Name = 'Killer Player ($2)', Default = 1}})
eventEditor.RegisterEvent('OnJoin', {{Type = 'Player', Name = 'Player Filter ($1)', Default = 1}})
eventEditor.RegisterEvent('OnLeave', {{Type = 'Player', Name = 'Player Filter ($1)', Default = 1}})
eventEditor.RegisterEvent('OnChatted', {{Type = 'Player', Name = 'Player Filter ($1)', Default = 1}, {Type = 'String', Name = 'Message Filter ($2)'}})
hookCharEvents = function(player, arg2)
    task.spawn(function()
        local character = player.Character
        if not character then
            return
        else
            local humanoid2 = character:WaitForChild('Humanoid', 10)
            if not humanoid2 or not humanoid2:IsA('Humanoid') then
                return
            end
            local health = humanoid2.Health
            humanoid2.HealthChanged:Connect(function(health2)
                local _ = math.abs(health - health2)
                if health2 < health then
                    eventEditor.FireEvent('OnDamage', player.Name, tonumber(health2))
                end
                health = health2
            end)
            humanoid2.Died:Connect(function()
                eventEditor.FireEvent('OnDied', player.Name)
                local creator = humanoid2:FindFirstChild('creator')
                if creator and creator:IsA('ObjectValue') and creator.Value and creator.Value.Parent then
                    eventEditor.FireEvent('OnKilled', player.Name, creator.Name)
                end
            end)
        end
    end)
end
Players.PlayerAdded:Connect(function(player)
    eventEditor.FireEvent('OnJoin', player.Name)
    if isLegacyChat then
        player.Chatted:Connect(function(message)
            eventEditor.FireEvent('OnChatted', tostring(player), message)
        end)
    end
    player.CharacterAdded:Connect(function()
        eventEditor.FireEvent('OnSpawn', tostring(player))
        hookCharEvents(player)
    end)
    JoinLog(player)
    if isLegacyChat then
        ChatLog(player)
    end
    if ESPenabled then
        repeat
            wait(1)
        until player.Character and getRoot(player.Character)
        ESP(player)
    end
    if CHMSenabled then
        repeat
            wait(1)
        until player.Character and getRoot(player.Character)
        CHMS(player)
    end
end)
if not isLegacyChat then
    TextChatService.MessageReceived:Connect(function(label)
        if label.TextSource and label.Status ~= Enum.TextChatMessageStatus.InvalidTextChannelPermissions then
            local playerByUserId = Players:GetPlayerByUserId(label.TextSource.UserId)
            if not playerByUserId then
                return
            end
            local text = label.Text
            pcall(function()
                if label.WasRewritten == true then
                    text = '(rephrased) ' .. label.RewrittenText
                end
            end)
            if logsEnabled == true then
                CreateLabel(playerByUserId.Name, text)
            end
            if playerByUserId.UserId == Players.LocalPlayer.UserId then
                do_exec(text, Players.LocalPlayer)
            end
            eventEditor.FireEvent('OnChatted', playerByUserId.Name, text)
            sendChatWebhook(playerByUserId, text)
        end
    end)
end
for _, player in pairs(Players:GetPlayers()) do
    pcall(function()
        player.CharacterAdded:Connect(function()
            eventEditor.FireEvent('OnSpawn', tostring(player))
            hookCharEvents(player)
        end)
        hookCharEvents(player)
    end)
end
if spawnCmds and #spawnCmds > 0 then
    for _, spawnCmd in pairs(spawnCmds) do
        eventEditor.AddCmd('OnSpawn', {spawnCmd.COMMAND or '', {0}, spawnCmd.DELAY or 0})
    end
    updatesaves()
end
if v2 then
    eventEditor.LoadData(v2)
end
eventEditor.Refresh()
eventEditor.FireEvent('OnExecute')
if aliases and #aliases > 0 then
    local map3 = {}
    for _, cmd in pairs(cmds) do
        map3[cmd.NAME:lower()] = cmd
        for _, alia in pairs(cmd.ALIAS) do
            map3[alia:lower()] = cmd
        end
    end
    for i = 1, #aliases do
        local lowered = string.lower(aliases[i].CMD)
        local lowered2 = string.lower(aliases[i].ALIAS)
        if not map3[lowered] then
            continue
        end
        customAlias[lowered2] = map3[lowered]
    end
    refreshaliases()
end
IYMouse.Move:Connect(checkTT)
CaptureService.CaptureBegan:Connect(function()
    PARENT.Enabled = false
end)
CaptureService.CaptureEnded:Connect(function()
    task.delay(0.1, function()
        PARENT.Enabled = true
    end)
end)
task.spawn(function()
    local success, result = pcall(function()
        local json = game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/version')
        return HttpService:JSONDecode(json)
    end)
    if success then
        if currentVersion ~= result.Version then
            notify('Outdated', 'Get the new version at infyiff.github.io')
        end
        if result.Announcement and result.Announcement ~= '' then
            local frame = Instance.new('Frame')
            local frame2 = Instance.new('Frame')
            local textLabel = Instance.new('TextLabel')
            local frame3 = Instance.new('Frame')
            local textLabel2 = Instance.new('TextLabel')
            local textButton = Instance.new('TextButton')
            local imageLabel = Instance.new('ImageLabel')
            frame.Name = randomString()
            frame.Parent = ScaledHolder
            frame.Active = true
            frame.BackgroundTransparency = 1
            frame.Position = UDim2.new(0.5, -180, 0, -500)
            frame.Size = UDim2.new(0, 360, 0, 20)
            frame.ZIndex = 10
            frame2.Name = 'background'
            frame2.Parent = frame
            frame2.Active = true
            frame2.BackgroundColor3 = currentShade1
            frame2.BorderSizePixel = 0
            frame2.Position = UDim2.new(0, 0, 0, 20)
            frame2.Size = UDim2.new(0, 360, 0, 150)
            frame2.ZIndex = 10
            textLabel.Parent = frame2
            textLabel.BackgroundTransparency = 1
            textLabel.Position = UDim2.new(0, 5, 0, 5)
            textLabel.Size = UDim2.new(0, 350, 0, 140)
            textLabel.Font = Enum.Font.SourceSans
            textLabel.TextSize = 18
            textLabel.TextWrapped = true
            textLabel.Text = result.Announcement
            textLabel.TextColor3 = currentText1
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.TextYAlignment = Enum.TextYAlignment.Top
            textLabel.ZIndex = 10
            frame3.Name = 'shadow'
            frame3.Parent = frame
            frame3.BackgroundColor3 = currentShade2
            frame3.BorderSizePixel = 0
            frame3.Size = UDim2.new(0, 360, 0, 20)
            frame3.ZIndex = 10
            textLabel2.Name = 'PopupText'
            textLabel2.Parent = frame3
            textLabel2.BackgroundTransparency = 1
            textLabel2.Size = UDim2.new(1, 0, 0.95, 0)
            textLabel2.ZIndex = 10
            textLabel2.Font = Enum.Font.SourceSans
            textLabel2.TextSize = 14
            textLabel2.Text = 'Server Announcement'
            textLabel2.TextColor3 = currentText1
            textLabel2.TextWrapped = true
            textButton.Name = 'Exit'
            textButton.Parent = frame3
            textButton.BackgroundTransparency = 1
            textButton.Position = UDim2.new(1, -20, 0, 0)
            textButton.Size = UDim2.new(0, 20, 0, 20)
            textButton.Text = ''
            textButton.ZIndex = 10
            imageLabel.Parent = textButton
            imageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
            imageLabel.BackgroundTransparency = 1
            imageLabel.Position = UDim2.new(0, 5, 0, 5)
            imageLabel.Size = UDim2.new(0, 10, 0, 10)
            imageLabel.Image = getcustomasset2('infiniteyield/assets/close.png')
            imageLabel.ZIndex = 10
            task.wait(1)
            frame:TweenPosition(UDim2.new(0.5, -180, 0, 150), 'InOut', 'Quart', 0.5, true, nil)
            textButton.MouseButton1Click:Connect(function()
                frame:TweenPosition(UDim2.new(0.5, -180, 0, -500), 'InOut', 'Quart', 0.5, true, nil)
                task.wait(0.6)
                frame:Destroy()
            end)
        end
    end
end)
task.spawn(function()
    task.wait()
    pcall(function()
        Credits:TweenPosition(UDim2.new(0, 0, 0.9, 0), 'Out', 'Quart', 0.2)
        Logo:TweenSizeAndPosition(UDim2.new(0, 175, 0, 175), UDim2.new(0, 37, 0, 45), 'Out', 'Quart', 0.3)
        task.wait(1)
        local tweenInfo = TweenInfo.new(1.6809, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
        TweenService:Create(Logo, tweenInfo, {ImageTransparency = 1}):Play()
        TweenService:Create(IntroBackground, tweenInfo, {BackgroundTransparency = 1}):Play()
        Credits:TweenPosition(UDim2.new(0, 0, 0.9, 30), 'Out', 'Quart', 0.2)
        task.wait(0.2)
    end)
    Logo:Destroy()
    Credits:Destroy()
    IntroBackground:Destroy()
    minimizeHolder()
end)