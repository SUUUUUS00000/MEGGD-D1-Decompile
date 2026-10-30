local nodes = {}
local selection
local callback = cloneref or function(...)
    return ...
end
local data = {Explorer = function()
    local v1
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
    local service
    local player
    local callback2
    local v12
    return {InitDeps = function(self)
        v1 = self.Main
        v2 = self.Lib
        v3 = self.Apps
        v4 = self.Settings
        v9 = self.API
        v10 = self.RMD
        v11 = self.env
        service = self.service
        player = self.plr
        callback2 = self.create
        v12 = self.createSimple
    end, InitAfterMain = function()
        v5 = v3.Explorer
        v6 = v3.Properties
        v7 = v3.ScriptViewer
        v8 = v3.Notebook
    end, Main = function()
        local object = {}
        local tbl = {}
        local map = {}
        local map2 = {}
        local set = {}
        local specResults = {}
        local set2
        local template
        local template2
        local toolBar
        local connection
        local connection2
        local connection3
        local findFirstAncestorWhichIsA = game.FindFirstAncestorWhichIsA
        local getDescendants = game.GetDescendants
        local getTextSize = service.TextService.GetTextSize
        local flag = false
        local flag2 = false
        local data = {Obj = Instance.new('Folder')}
        local num = 0
        local v3
        local v5
        local list
        local label
        local v8
        local callback3
        local v12
        local v13
        local table = table
        local math = math
        local set3 = {}
        local tbl2 = {}
        local connect = game.DescendantAdded.Connect
        local handler
        local handler2
        local handler3
        function handler(descendant)
            if nodes[descendant] then
                return
            end
            local flag3 = false
            local firstAncestorWhichIsA = findFirstAncestorWhichIsA(descendant, 'Instance')
            local list = nodes[firstAncestorWhichIsA]
            if not list then
                if set3[descendant] then
                    tbl2[descendant] = tbl2[descendant] or {connect(descendant.ChildAdded, handler), connect(descendant.AncestryChanged, handler3)}
                    list = data
                    flag3 = true
                else
                    return
                end
            elseif set3[firstAncestorWhichIsA] or list == data then
                set3[descendant] = true
                tbl2[descendant] = tbl2[descendant] or {connect(descendant.ChildAdded, handler), connect(descendant.AncestryChanged, handler3)}
                flag3 = true
            end
            local data2 = {Obj = descendant, Parent = list}
            nodes[descendant] = data2
            if v12 and set2[list] and list.Sorted then
                local num = 1
                local count = #list
                local floor = math.floor
                local nodeSorter = object.NodeSorter
                local item = count == 0 and 1
                if not item then
                    while true do
                        if count <= num then
                            if nodeSorter(data2, list[num]) then
                                item = num
                                break
                            end
                            item = num + 1
                            break
                        end
                        local result = floor((num + count) / 2)
                        if nodeSorter(data2, list[result]) then
                            count = result - 1
                        else
                            num = result + 1
                        end
                    end
                end
                table.insert(list, item, data2)
            else
                list[#list + 1] = data2
                list.Sorted = nil
            end
            local descendants = getDescendants(descendant)
            for i = 1, #descendants do
                local obj = descendants[i]
                if nodes[obj] then
                    continue
                end
                local list2 = nodes[findFirstAncestorWhichIsA(obj, 'Instance')]
                if not list2 then
                    continue
                end
                local data3 = {Obj = obj, Parent = list2}
                nodes[obj] = data3
                list2[#list2 + 1] = data3
                if not flag3 then
                    continue
                end
                set3[obj] = true
                tbl2[obj] = tbl2[obj] or {connect(obj.ChildAdded, handler), connect(obj.AncestryChanged, handler3)}
            end
            if callback3 and v13 then
                callback3({data2})
            end
            if not flag and object.IsNodeVisible(list) then
                if set2[list] then
                    object.PerformUpdate()
                    return
                end
                if not flag2 then
                    object.PerformRefresh()
                end
            end
        end
        function handler2(descendant)
            local node = nodes[descendant]
            if not node then
                return
            end
            if set3[node.Obj] then
                handler3(node.Obj)
                return
            end
            local parent = node.Parent
            if parent then
                parent.HasDel = true
            end
            local function recur(list)
                for i = 1, #list do
                    local list2 = list[i]
                    if list2.Del then
                        continue
                    end
                    nodes[list2.Obj] = nil
                    if #list2 > 0 then
                        recur(list2)
                    end
                end
            end
            recur(node)
            node.Del = true
            nodes[descendant] = nil
            if parent and not flag and object.IsNodeVisible(parent) then
                if set2[parent] then
                    object.PerformUpdate()
                    return
                end
                if not flag2 then
                    object.PerformRefresh()
                end
            end
        end
        function handler3(arg1)
            local value = nodes[arg1]
            if not value then
                return
            end
            local parent = value.Parent
            local list = nodes[findFirstAncestorWhichIsA(arg1, 'Instance')]
            if parent == list then
                return
            end
            if not list then
                if set3[arg1] then
                    list = data
                else
                    return
                end
            elseif set3[list.Obj] or list == data then
                set3[arg1] = true
                tbl2[arg1] = tbl2[arg1] or {connect(arg1.ChildAdded, handler), connect(arg1.AncestryChanged, handler3)}
            end
            if parent then
                local index = table.find(parent, value)
                if index then
                    table.remove(parent, index)
                end
            end
            value.Id = nil
            value.Parent = list
            if v12 and set2[list] and list.Sorted then
                local num = 1
                local count = #list
                local floor = math.floor
                local nodeSorter = object.NodeSorter
                local item = count == 0 and 1
                if not item then
                    while true do
                        if count <= num then
                            if nodeSorter(value, list[num]) then
                                item = num
                                break
                            end
                            item = num + 1
                            break
                        end
                        local result = floor((num + count) / 2)
                        if nodeSorter(value, list[result]) then
                            count = result - 1
                        else
                            num = result + 1
                        end
                    end
                end
                table.insert(list, item, value)
            else
                list[#list + 1] = value
                list.Sorted = nil
            end
            if callback3 and set[value] then
                local parent2 = value.Parent
                while parent2 and (not set[parent2] or set2[parent2] == 0) do
                    set2[parent2] = true
                    set[parent2] = true
                    parent2 = parent2.Parent
                end
            end
            if not flag and (object.IsNodeVisible(list) or object.IsNodeVisible(parent)) then
                if set2[list] or set2[parent] then
                    object.PerformUpdate()
                    return
                end
                if not flag2 then
                    object.PerformRefresh()
                end
            end
        end
        object.ViewWidth = 0
        object.Index = 0
        object.EntryIndent = 20
        object.FreeWidth = 32
        object.GuiElems = {}
        function object.InitRenameBox()
            label = callback2({{1, 'TextBox', {BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderColor3 = Color3.new(0.062745101749897, 0.51764708757401, 1), BorderMode = 2, ClearTextOnFocus = false, Font = 3, Name = 'RenameBox', PlaceholderColor3 = Color3.new(0.69803923368454, 0.69803923368454, 0.69803923368454), Position = UDim2.new(0, 26, 0, 2), Size = UDim2.new(0, 200, 0, 16), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, Visible = false, ZIndex = 2}}})
            label.Parent = object.Window.GuiElems.Content.List
            label.FocusLost:Connect(function()
                if not v8 then
                    return
                end
                pcall(function()
                    v8.Obj.Name = label.Text
                end)
                v8 = nil
                object.Refresh()
            end)
            label.Focused:Connect(function()
                label.SelectionStart = 1
                label.CursorPosition = #label.Text + 1
            end)
        end
        function object:SetRenamingNode()
            v8 = self
            label.Text = tostring(self.Obj)
            label:CaptureFocus()
            object.Refresh()
        end
        function object.SetSortingEnabled(sorting)
            v12 = sorting
            v4.Explorer.Sorting = sorting
        end
        function object.UpdateView()
            local ceiled = math.ceil(template2.AbsoluteSize.Y / 20)
            local x = template2.AbsoluteSize.X
            local totalSpace = object.ViewWidth + object.FreeWidth
            v3.VisibleSpace = ceiled
            v3.TotalSpace = #tbl + 1
            v5.VisibleSpace = x
            v5.TotalSpace = totalSpace
            v3.Gui.Visible = ceiled < #tbl + 1
            v5.Gui.Visible = x < totalSpace
            local size = template2.Size
            template2.Size = UDim2.new(1, v3.Gui.Visible and -16 or 0, 1, v5.Gui.Visible and -39 or -23)
            if size ~= template2.Size then
                object.UpdateView()
                return
            end
            v3:Update()
            v5:Update()
            label.Size = UDim2.new(0, x - 100, 0, 16)
            if v3.Gui.Visible and v5.Gui.Visible then
                v3.Gui.Size = UDim2.new(0, 16, 1, -39)
                v5.Gui.Size = UDim2.new(1, -16, 0, 16)
                object.Window.GuiElems.Content.ScrollCorner.Visible = true
            else
                v3.Gui.Size = UDim2.new(0, 16, 1, -23)
                v5.Gui.Size = UDim2.new(1, 0, 0, 16)
                object.Window.GuiElems.Content.ScrollCorner.Visible = false
            end
            object.Index = v3.Index
        end
        function object:NodeSorter(arg2)
            if self.Del or arg2.Del then
                return false
            end
            local class = self.Class
            local class2 = arg2.Class
            if not class then
                class = self.Obj.ClassName
                self.Class = class
            end
            if not class2 then
                class2 = arg2.Obj.ClassName
                arg2.Class = class2
            end
            local entry = map2[class]
            local entry2 = map2[class2]
            if not entry then
                entry = v10.Classes[class] and tonumber(v10.Classes[class].ExplorerOrder) or 9999
                map2[class] = entry
            end
            if not entry2 then
                entry2 = v10.Classes[class2] and tonumber(v10.Classes[class2].ExplorerOrder) or 9999
                map2[class2] = entry2
            end
            if entry ~= entry2 then
                return entry < entry2
            else
                local text, text2 = tostring(self.Obj), tostring(arg2.Obj)
                if text ~= text2 then
                    return text < text2
                else
                    if class ~= class2 then
                        return class < class2
                    end
                    local id = self.Id
                    if not id then
                        id = num
                        num = (num + 0.001) % 999999999
                        self.Id = id
                    end
                    local id2 = arg2.Id
                    if not id2 then
                        id2 = num
                        num = (num + 0.001) % 999999999
                        arg2.Id = id2
                    end
                    return id < id2
                end
            end
        end
        function object.Update()
            table.clear(tbl)
            local maxNameWidth = 0
            local maxDepth = 1
            local count = 1
            local map = {}
            local sourceSans = Enum.Font.SourceSans
            local vector2 = Vector2.new(math.huge, 20)
            local useNameWidth = v4.Explorer.UseNameWidth
            local sort = table.sort
            local nodeSorter = object.NodeSorter
            local v1 = set2 == object.SearchExpanded
            local textService = service.TextService
            local function recur(list, arg2)
                if maxDepth < arg2 then
                    maxDepth = arg2
                end
                arg2 += 1
                if v12 and not list.Sorted then
                    sort(list, nodeSorter)
                    list.Sorted = true
                end
                for i = 1, #list do
                    local list2 = list[i]
                    if v1 and not set[list2] then
                        continue
                    end
                    if list2.Del then
                        continue
                    end
                    if useNameWidth then
                        local nameWidth = list2.NameWidth
                        if not nameWidth then
                            local text = tostring(list2.Obj)
                            nameWidth = map[text]
                            if not nameWidth then
                                nameWidth = getTextSize(textService, text, 14, sourceSans, vector2).X
                                map[text] = nameWidth
                            end
                            list2.NameWidth = nameWidth
                        end
                        if maxNameWidth < nameWidth then
                            maxNameWidth = nameWidth
                        end
                    end
                    tbl[count] = list2
                    count = count + 1
                    if set2[list2] and #list2 > 0 then
                        recur(list2, arg2)
                    end
                end
            end
            recur(nodes[game], 1)
            if v11.getnilinstances and (not v1 or set[data]) then
                tbl[count] = data
                count = count + 1
                if set2[data] then
                    recur(data, 2)
                end
            end
            object.MaxNameWidth = maxNameWidth
            object.MaxDepth = maxDepth
            object.ViewWidth = useNameWidth and object.EntryIndent * maxDepth + maxNameWidth + 26 or object.EntryIndent * maxDepth + 226
            object.UpdateView()
        end
        function object.StartDrag(arg1, arg2)
            if object.Dragging then
                return
            end
            object.Dragging = true
            local clone = template2:Clone()
            clone:ClearAllChildren()
            for k, v in pairs(map) do
                local v3 = tbl[k + object.Index]
                if v3 and selection.Map[v3] then
                    local clone2 = v:Clone()
                    clone2.Active = false
                    clone2.Indent.Expand.Visible = false
                    clone2.Parent = clone
                end
            end
            local screenGui = Instance.new('ScreenGui')
            screenGui.DisplayOrder = v1.DisplayOrders.Menu
            clone.Parent = screenGui
            v2.ShowGui(screenGui)
            local gui = callback2({{1, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'DragSelect', Size = UDim2.new(1, 0, 1, 0)}}, {2, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Name = 'Line', Parent = {1}, Size = UDim2.new(1, 0, 0, 1), ZIndex = 2}}, {3, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Name = 'Line', Parent = {1}, Position = UDim2.new(0, 0, 1, -1), Size = UDim2.new(1, 0, 0, 1), ZIndex = 2}}, {4, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Name = 'Line', Parent = {1}, Size = UDim2.new(0, 1, 1, 0), ZIndex = 2}}, {5, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Name = 'Line', Parent = {1}, Position = UDim2.new(1, -1, 0, 0), Size = UDim2.new(0, 1, 1, 0), ZIndex = 2}}})
            gui.Parent = template2
            local mouse = v1.Mouse or service.Players.LocalPlayer:GetMouse()
            local function move()
                local xOffset = mouse.X - arg1
                local yOffset = mouse.Y - arg2
                clone.Position = UDim2.new(0, xOffset, 0, yOffset)
                for i = 1, #map do
                    local entry = map[i]
                    if not v2.CheckMouseInGui(entry) then
                        continue
                    end
                    gui.Position = UDim2.new(0, entry.Indent.Position.X.Offset - v5.Index, 0, entry.Position.Y.Offset)
                    gui.Size = UDim2.new(0, entry.Size.X.Offset - entry.Indent.Position.X.Offset, 0, 20)
                    gui.Visible = true
                    return
                end
                gui.Visible = false
            end
            move()
            local userInputService = service.UserInputService
            local connection
            local connection2
            connection = userInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    move()
                end
            end)
            connection2 = userInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    connection2:Disconnect()
                    connection:Disconnect()
                    screenGui:Destroy()
                    gui:Destroy()
                    object.Dragging = false
                    for i = 1, #map do
                        if not v2.CheckMouseInGui(map[i]) then
                            continue
                        end
                        local v1 = tbl[i + object.Index]
                        if not v1 then
                            break
                        end
                        if selection.Map[v1] then
                            return
                        else
                            local obj = v1.Obj
                            local list = selection.List
                            for j = 1, #list do
                                local entry = list[j]
                                pcall(function()
                                    entry.Obj.Parent = obj
                                end)
                            end
                            object.ViewNode(list[1])
                            return
                        end
                    end
                end
            end)
        end
        function object.NewListEntry(number)
            local clone = template:Clone()
            clone.Position = UDim2.new(0, 0, 0, 20 * (number - 1))
            local flag = false
            clone.InputBegan:Connect(function(input)
                local v1 = tbl[number + object.Index]
                if not v1 or selection.Map[v1] or input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end
                clone.Indent.BackgroundColor3 = v4.Theme.Button
                clone.Indent.BorderSizePixel = 0
                clone.Indent.BackgroundTransparency = 0
            end)
            clone.InputEnded:Connect(function(input)
                local v1 = tbl[number + object.Index]
                if not v1 or selection.Map[v1] or input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end
                clone.Indent.BackgroundTransparency = 1
            end)
            clone.MouseButton1Down:Connect(function()
            end)
            clone.MouseButton1Up:Connect(function()
            end)
            clone.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local connection
                    local connection2
                    local mouse = v1.Mouse or player:GetMouse()
                    local x = mouse.X
                    local y = mouse.Y
                    local v2 = x - template2.AbsolutePosition.X
                    local v3 = y - template2.AbsolutePosition.Y
                    connection = callback(game:GetService('UserInputService')).InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            connection:Disconnect()
                            connection2:Disconnect()
                        end
                    end)
                    connection2 = callback(game:GetService('UserInputService')).InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            local v1 = mouse.X - x
                            local v4 = mouse.Y - y
                            local root = math.sqrt(v1 ^ 2 + v4 ^ 2)
                            if root > 5 then
                                connection:Disconnect()
                                connection2:Disconnect()
                                flag = false
                                object.StartDrag(v2, v3)
                            end
                        end
                    end)
                end
            end)
            clone.MouseButton2Down:Connect(function()
            end)
            clone.Indent.Expand.InputBegan:Connect(function(input)
                local v1 = tbl[number + object.Index]
                if not v1 or input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end
                object.MiscIcons:DisplayByKey(clone.Indent.Expand.Icon, set2[v1] and 'Collapse_Over' or 'Expand_Over')
            end)
            clone.Indent.Expand.InputEnded:Connect(function(input)
                local v1 = tbl[number + object.Index]
                if not v1 or input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end
                object.MiscIcons:DisplayByKey(clone.Indent.Expand.Icon, set2[v1] and 'Collapse' or 'Expand')
            end)
            clone.Indent.Expand.MouseButton1Down:Connect(function()
                local list = tbl[number + object.Index]
                if not list or #list == 0 then
                    return
                end
                set2[list] = not set2[list]
                object.Update()
                object.Refresh()
            end)
            clone.Parent = template2
            return clone
        end
        function object.Refresh()
            local max = math.max(math.ceil(template2.AbsoluteSize.Y / 20), 0)
            local flag = false
            local isA = game.IsA
            for i = 1, max do
                local listEntry = map[i]
                if not map[i] then
                    listEntry = object.NewListEntry(i)
                    map[i] = listEntry
                    object.ClickSystem:Add(listEntry)
                end
                local list = tbl[i + object.Index]
                if list then
                    local obj = list.Obj
                    local xOffset = object.EntryIndent * object.NodeDepth(list)
                    listEntry.Visible = true
                    listEntry.Position = UDim2.new(0, -v5.Index, 0, listEntry.Position.Y.Offset)
                    listEntry.Size = UDim2.new(0, object.ViewWidth, 0, 20)
                    listEntry.Indent.EntryName.Text = tostring(list.Obj)
                    listEntry.Indent.Position = UDim2.new(0, xOffset, 0, 0)
                    listEntry.Indent.Size = UDim2.new(1, -xOffset, 1, 0)
                    listEntry.Indent.EntryName.TextTruncate = v4.Explorer.UseNameWidth and Enum.TextTruncate.None or Enum.TextTruncate.AtEnd
                    if (isA(obj, 'LocalScript') or isA(obj, 'Script')) and obj.Disabled then
                        object.MiscIcons:DisplayByKey(listEntry.Indent.Icon, isA(obj, 'LocalScript') and 'LocalScript_Disabled' or 'Script_Disabled')
                    else
                        local class = v10.Classes[obj.ClassName]
                        object.ClassIcons:Display(listEntry.Indent.Icon, class and class.ExplorerImageIndex or 0)
                    end
                    if selection.Map[list] then
                        listEntry.Indent.BackgroundColor3 = v4.Theme.ListSelection
                        listEntry.Indent.BorderSizePixel = 0
                        listEntry.Indent.BackgroundTransparency = 0
                    elseif v2.CheckMouseInGui(listEntry) then
                        listEntry.Indent.BackgroundColor3 = v4.Theme.Button
                    else
                        listEntry.Indent.BackgroundTransparency = 1
                    end
                    if list == v8 then
                        flag = true
                        label.Position = UDim2.new(0, xOffset + 25 - v5.Index, 0, listEntry.Position.Y.Offset + 2)
                        label.Visible = true
                    end
                    if #list > 0 and set2[list] ~= 0 then
                        if v2.CheckMouseInGui(listEntry.Indent.Expand) then
                            object.MiscIcons:DisplayByKey(listEntry.Indent.Expand.Icon, set2[list] and 'Collapse_Over' or 'Expand_Over')
                        else
                            object.MiscIcons:DisplayByKey(listEntry.Indent.Expand.Icon, set2[list] and 'Collapse' or 'Expand')
                        end
                        listEntry.Indent.Expand.Visible = true
                    else
                        listEntry.Indent.Expand.Visible = false
                    end
                else
                    listEntry.Visible = false
                end
            end
            if not flag then
                label.Visible = false
            end
            for i = max + 1, #map do
                object.ClickSystem:Remove(map[i])
                map[i]:Destroy()
                map[i] = nil
            end
        end
        function object.PerformUpdate(arg1)
            flag = true
            v2.FastWait(not arg1 and 0.1)
            if not flag then
                return
            end
            flag = false
            if not object.Window:IsVisible() then
                return
            end
            object.Update()
            object.Refresh()
        end
        function object.ForceUpdate(arg1)
            flag = false
            object.Update()
            if not arg1 then
                object.Refresh()
            end
        end
        function object.PerformRefresh()
            flag2 = true
            v2.FastWait(0.1)
            flag2 = false
            if flag or not object.Window:IsVisible() then
                return
            end
            object.Refresh()
        end
        function object.IsNodeVisible(instance)
            if not instance then
                return
            end
            local parent = instance.Parent
            while parent do
                if not set2[parent] then
                    return false
                end
                parent = parent.Parent
            end
            return true
        end
        function object.NodeDepth(instance)
            local count = 0
            if instance == data then
                return 1
            end
            local parent = instance.Parent
            while parent do
                if parent == data then
                    count = count + 1
                end
                parent = parent.Parent
                count = count + 1
            end
            return count
        end
        function object.SetupConnections()
            if connection then
                connection:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
            if connection3 then
                connection3:Disconnect()
            end
            if v1.Elevated then
                connection = game.DescendantAdded:Connect(handler)
                connection2 = game.DescendantRemoving:Connect(handler2)
            else
                connection = game.DescendantAdded:Connect(function(descendant)
                    pcall(handler, descendant)
                end)
                connection2 = game.DescendantRemoving:Connect(function(descendant)
                    pcall(handler2, descendant)
                end)
            end
            if v4.Explorer.UseNameWidth then
                connection3 = game.ItemChanged:Connect(function(arg1, text)
                    if text == 'Parent' and nodes[arg1] then
                        handler3(arg1)
                        return
                    end
                    if text == 'Name' and nodes[arg1] then
                        nodes[arg1].NameWidth = nil
                    end
                end)
                return
            end
            connection3 = game.ItemChanged:Connect(function(arg1, text)
                if text == 'Parent' and nodes[arg1] then
                    handler3(arg1)
                end
            end)
        end
        function object.ViewNode(arg1)
            if not arg1 then
                return
            end
            object.MakeNodeVisible(arg1)
            object.ForceUpdate(true)
            local visibleSpace = v3.VisibleSpace
            for k, v in next, tbl do
                if v ~= arg1 then
                    continue
                end
                local index = k - 1
                if index < object.Index then
                    v3.Index = index
                elseif object.Index + visibleSpace - 1 <= index then
                    v3.Index = index - visibleSpace + 2
                end
            end
            v3:Update()
            object.Index = v3.Index
            object.Refresh()
        end
        function object.ViewObj(arg1)
            object.ViewNode(nodes[arg1])
        end
        function object.MakeNodeVisible(instance, arg2)
            if not instance then
                return
            end
            local flag2 = false
            if arg2 and not set2[instance] then
                set2[instance] = true
                flag2 = true
            end
            local parent = instance.Parent
            while parent do
                flag2 = true
                set2[parent] = true
                parent = parent.Parent
            end
            if flag2 and not flag then
                coroutine.wrap(object.PerformUpdate)(true)
            end
        end
        function object.ShowRightClick()
            local rightClickContext = object.RightClickContext
            rightClickContext:Clear()
            local list2 = selection.List
            local map = selection.Map
            local v2 = #list == 0
            local set = {}
            local classes = v9.Classes
            for i = 1, #list2 do
                local entry = list2[i]
                local class = entry.Class
                if not class then
                    class = entry.Obj.ClassName
                    entry.Class = class
                end
                local superclass = classes[class]
                while superclass and not set[superclass.Name] do
                    set[superclass.Name] = true
                    superclass = superclass.Superclass
                end
            end
            rightClickContext:AddRegistered('CUT')
            rightClickContext:AddRegistered('COPY')
            rightClickContext:AddRegistered('PASTE', v2)
            rightClickContext:AddRegistered('DUPLICATE')
            rightClickContext:AddRegistered('DELETE')
            rightClickContext:AddRegistered('RENAME', #list2 ~= 1)
            rightClickContext:AddDivider()
            rightClickContext:AddRegistered('GROUP')
            rightClickContext:AddRegistered('UNGROUP')
            rightClickContext:AddRegistered('SELECT_CHILDREN')
            rightClickContext:AddRegistered('JUMP_TO_PARENT')
            rightClickContext:AddRegistered('EXPAND_ALL')
            rightClickContext:AddRegistered('COLLAPSE_ALL')
            rightClickContext:AddDivider()
            if set2 == object.SearchExpanded then
                rightClickContext:AddRegistered('CLEAR_SEARCH_AND_JUMP_TO')
            end
            if v11.setclipboard then
                rightClickContext:AddRegistered('COPY_PATH')
            end
            rightClickContext:AddRegistered('INSERT_OBJECT')
            rightClickContext:AddRegistered('SAVE_INST')
            rightClickContext:AddRegistered('CALL_FUNCTION')
            rightClickContext:AddRegistered('VIEW_CONNECTIONS')
            rightClickContext:AddRegistered('GET_REFERENCES')
            rightClickContext:AddRegistered('VIEW_API')
            rightClickContext:QueueDivider()
            if set.BasePart or set.Model then
                rightClickContext:AddRegistered('TELEPORT_TO')
                rightClickContext:AddRegistered('VIEW_OBJECT')
            end
            if set.TouchTransmitter then
                rightClickContext:AddRegistered('FIRE_TOUCHTRANSMITTER', firetouchinterest == nil)
            end
            if set.ClickDetector then
                rightClickContext:AddRegistered('FIRE_CLICKDETECTOR', fireclickdetector == nil)
            end
            if set.ProximityPrompt then
                rightClickContext:AddRegistered('FIRE_PROXIMITYPROMPT', fireproximityprompt == nil)
            end
            if set.Player then
                rightClickContext:AddRegistered('SELECT_CHARACTER')
            end
            if set.Players then
                rightClickContext:AddRegistered('SELECT_LOCAL_PLAYER')
            end
            if set.LuaSourceContainer then
                rightClickContext:AddRegistered('VIEW_SCRIPT')
            end
            if map[data] then
                rightClickContext:AddRegistered('REFRESH_NIL')
                rightClickContext:AddRegistered('HIDE_NIL')
            end
            object.LastRightClickX, object.LastRightClickY = v1.Mouse.X, v1.Mouse.Y
            rightClickContext:Show()
        end
        function object.InitRightClick()
            local contextMenu = v2.ContextMenu.new()
            contextMenu:Register('CUT', {Name = 'Cut', IconMap = object.MiscIcons, Icon = 'Cut', DisabledIcon = 'Cut_Disabled', Shortcut = 'Ctrl+Z', OnClick = function()
                local destroy = game.Destroy
                local clone = game.Clone
                local list2 = selection.List
                local map = {}
                local count = 1
                for i = 1, #list2 do
                    local obj = list2[i].Obj
                    local success, result = pcall(clone, obj)
                    if success and result then
                        map[count] = result
                        count = count + 1
                    end
                    pcall(destroy, obj)
                end
                list = map
                selection:Clear()
            end})
            contextMenu:Register('COPY', {Name = 'Copy', IconMap = object.MiscIcons, Icon = 'Copy', DisabledIcon = 'Copy_Disabled', Shortcut = 'Ctrl+C', OnClick = function()
                local clone = game.Clone
                local list2 = selection.List
                local map = {}
                local count = 1
                for i = 1, #list2 do
                    local obj = list2[i].Obj
                    local success, result = pcall(clone, obj)
                    if success and result then
                        map[count] = result
                        count = count + 1
                    end
                end
                list = map
            end})
            contextMenu:Register('PASTE', {Name = 'Paste Into', IconMap = object.MiscIcons, Icon = 'Paste', DisabledIcon = 'Paste_Disabled', Shortcut = 'Ctrl+Shift+V', OnClick = function()
                local list2 = selection.List
                local list3 = {}
                local count = 1
                for i = 1, #list2 do
                    local entry = list2[i]
                    local obj = entry.Obj
                    object.MakeNodeVisible(entry, true)
                    for j = 1, #list do
                        local clone = list[j]:Clone()
                        if not clone then
                            continue
                        end
                        clone.Parent = obj
                        local node = nodes[clone]
                        if not node then
                            continue
                        end
                        list3[count] = node
                        count = count + 1
                    end
                end
                selection:SetTable(list3)
                if #list3 > 0 then
                    object.ViewNode(list3[1])
                end
            end})
            contextMenu:Register('DUPLICATE', {Name = 'Duplicate', IconMap = object.MiscIcons, Icon = 'Copy', DisabledIcon = 'Copy_Disabled', Shortcut = 'Ctrl+D', OnClick = function()
                local clone = game.Clone
                local list = selection.List
                local list2 = {}
                local count = 1
                for i = 1, #list do
                    local entry = list[i]
                    local obj = entry.Obj
                    local parent = entry.Parent and entry.Parent.Obj
                    object.MakeNodeVisible(entry)
                    local success, result = pcall(clone, obj)
                    if success and result then
                        result.Parent = parent
                        local node = nodes[result]
                        if not node then
                            continue
                        end
                        list2[count] = node
                        count = count + 1
                    end
                end
                selection:SetTable(list2)
                if #list2 > 0 then
                    object.ViewNode(list2[1])
                end
            end})
            contextMenu:Register('DELETE', {Name = 'Delete', IconMap = object.MiscIcons, Icon = 'Delete', DisabledIcon = 'Delete_Disabled', Shortcut = 'Del', OnClick = function()
                local destroy = game.Destroy
                local list = selection.List
                for i = 1, #list do
                    pcall(destroy, list[i].Obj)
                end
                selection:Clear()
            end})
            contextMenu:Register('RENAME', {Name = 'Rename', IconMap = object.MiscIcons, Icon = 'Rename', DisabledIcon = 'Rename_Disabled', Shortcut = 'F2', OnClick = function()
                local list = selection.List
                if list[1] then
                    object.SetRenamingNode(list[1])
                end
            end})
            contextMenu:Register('GROUP', {Name = 'Group', IconMap = object.MiscIcons, Icon = 'Group', DisabledIcon = 'Group_Disabled', Shortcut = 'Ctrl+G', OnClick = function()
                local list = selection.List
                if #list == 0 then
                    return
                end
                local model = Instance.new('Model', list[#list].Obj.Parent)
                for i = 1, #list do
                    pcall(function()
                        list[i].Obj.Parent = model
                    end)
                end
                if nodes[model] then
                    selection:Set(nodes[model])
                    object.ViewNode(nodes[model])
                end
            end})
            contextMenu:Register('UNGROUP', {Name = 'Ungroup', IconMap = object.MiscIcons, Icon = 'Ungroup', DisabledIcon = 'Ungroup_Disabled', Shortcut = 'Ctrl+U', OnClick = function()
                local list = {}
                local num = 1
                local isA = game.IsA
                local function ungroup(list2)
                    local obj = list2.Parent.Obj
                    local list3 = {}
                    local count = 1
                    for i = 1, #list2 do
                        local entry = list2[i]
                        list[num] = entry
                        list3[count] = entry
                        num = num + 1
                        count = count + 1
                    end
                    for i = 1, #list3 do
                        pcall(function()
                            list3[i].Obj.Parent = obj
                        end)
                    end
                    list2.Obj:Destroy()
                end
                for _, v in next, selection.List do
                    if not isA(v.Obj, 'Model') then
                        continue
                    end
                    ungroup(v)
                end
                selection:SetTable(list)
                if #list > 0 then
                    object.ViewNode(list[1])
                end
            end})
            contextMenu:Register('SELECT_CHILDREN', {Name = 'Select Children', IconMap = object.MiscIcons, Icon = 'SelectChildren', DisabledIcon = 'SelectChildren_Disabled', OnClick = function()
                local list = {}
                local count = 1
                local list2 = selection.List
                for i = 1, #list2 do
                    local list3 = list2[i]
                    for j = 1, #list3 do
                        local entry = list3[j]
                        if j == 1 then
                            object.MakeNodeVisible(entry)
                        end
                        list[count] = entry
                        count = count + 1
                    end
                end
                selection:SetTable(list)
                if #list > 0 then
                    object.ViewNode(list[1])
                    return
                end
                object.Refresh()
            end})
            contextMenu:Register('JUMP_TO_PARENT', {Name = 'Jump to Parent', IconMap = object.MiscIcons, Icon = 'JumpToParent', OnClick = function()
                local list = {}
                local count = 1
                local list2 = selection.List
                for i = 1, #list2 do
                    local entry = list2[i]
                    if not entry.Parent then
                        continue
                    end
                    list[count] = entry.Parent
                    count = count + 1
                end
                selection:SetTable(list)
                if #list > 0 then
                    object.ViewNode(list[1])
                    return
                end
                object.Refresh()
            end})
            contextMenu:Register('TELEPORT_TO', {Name = 'Teleport To', IconMap = object.MiscIcons, Icon = 'TeleportTo', OnClick = function()
                local list = selection.List
                local isA = game.IsA
                local humanoidRootPart = player.Character and player.Character:FindFirstChild('HumanoidRootPart')
                if not humanoidRootPart then
                    return
                else
                    for i = 1, #list do
                        local entry = list[i]
                        if isA(entry.Obj, 'BasePart') then
                            humanoidRootPart.CFrame = entry.Obj.CFrame + v4.Explorer.TeleportToOffset
                            return
                        end
                        if not isA(entry.Obj, 'Model') then
                            continue
                        end
                        if entry.Obj.PrimaryPart then
                            humanoidRootPart.CFrame = entry.Obj.PrimaryPart.CFrame + v4.Explorer.TeleportToOffset
                            return
                        end
                        local basePart = entry.Obj:FindFirstChildWhichIsA('BasePart', true)
                        if basePart and nodes[basePart] then
                            humanoidRootPart.CFrame = nodes[basePart].Obj.CFrame + v4.Explorer.TeleportToOffset
                        end
                    end
                end
            end})
            contextMenu:Register('EXPAND_ALL', {Name = 'Expand All', OnClick = function()
                local list = selection.List
                local function expand(list)
                    set2[list] = true
                    for i = 1, #list do
                        if #list[i] > 0 then
                            expand(list[i])
                        end
                    end
                end
                for i = 1, #list do
                    expand(list[i])
                end
                object.ForceUpdate()
            end})
            contextMenu:Register('COLLAPSE_ALL', {Name = 'Collapse All', OnClick = function()
                local list = selection.List
                local function expand(list)
                    set2[list] = nil
                    for i = 1, #list do
                        if #list[i] > 0 then
                            expand(list[i])
                        end
                    end
                end
                for i = 1, #list do
                    expand(list[i])
                end
                object.ForceUpdate()
            end})
            contextMenu:Register('CLEAR_SEARCH_AND_JUMP_TO', {Name = 'Clear Search and Jump to', OnClick = function()
                local list = {}
                local count = 1
                local list2 = selection.List
                for i = 1, #list2 do
                    list[count] = list2[i]
                    count = count + 1
                end
                selection:SetTable(list)
                object.ClearSearch()
                if #list > 0 then
                    object.ViewNode(list[1])
                end
            end})
            local function handleText(text)
                if text:sub(1, 28) == 'game:GetService("Workspace")' then
                    text = text:gsub('game:GetService%("Workspace"%)', 'workspace', 1)
                end
                if text:sub(1, 27 + #player.Name) == 'game:GetService("Players").' .. player.Name then
                    text = text:gsub('game:GetService%("Players"%).' .. player.Name, 'game:GetService("Players").LocalPlayer', 1)
                end
                return text
            end
            contextMenu:Register('COPY_PATH', {Name = 'Copy Path', OnClick = function()
                local list = selection.List
                if #list == 1 then
                    v11.setclipboard(handleText(object.GetInstancePath(list[1].Obj)))
                    return
                end
                if #list > 1 then
                    local list2 = {'{'}
                    local count = 2
                    for i = 1, #list do
                        local list3 = '\t' .. handleText(object.GetInstancePath(list[i].Obj)) .. ','
                        if #list3 > 0 then
                            list2[count] = list3
                            count = count + 1
                        end
                    end
                    list2[count] = '}'
                    v11.setclipboard(table.concat(list2, '\n'))
                end
            end})
            contextMenu:Register('INSERT_OBJECT', {Name = 'Insert Object', IconMap = object.MiscIcons, Icon = 'InsertObject', OnClick = function()
                local mouse = v1.Mouse
                local lastRightClickX = object.LastRightClickX or mouse.X
                local lastRightClickY = object.LastRightClickY or mouse.Y
                object.InsertObjectContext:Show(lastRightClickX, lastRightClickY)
            end})
            contextMenu:Register('CALL_FUNCTION', {Name = 'Call Function', IconMap = object.ClassIcons, Icon = 66, OnClick = function()
            end})
            contextMenu:Register('GET_REFERENCES', {Name = 'Get Lua References', IconMap = object.ClassIcons, Icon = 34, OnClick = function()
            end})
            contextMenu:Register('SAVE_INST', {Name = 'Save to File', IconMap = object.MiscIcons, Icon = 'Save', OnClick = function()
            end})
            contextMenu:Register('VIEW_CONNECTIONS', {Name = 'View Connections', OnClick = function()
            end})
            contextMenu:Register('VIEW_API', {Name = 'View API Page', IconMap = object.MiscIcons, Icon = 'Reference', OnClick = function()
            end})
            contextMenu:Register('VIEW_OBJECT', {Name = 'View Object (Right click to reset)', IconMap = object.ClassIcons, Icon = 5, OnClick = function()
                local list = selection.List
                local isA = game.IsA
                for i = 1, #list do
                    local entry = list[i]
                    if not isA(entry.Obj, 'BasePart') and not isA(entry.Obj, 'Model') then
                        continue
                    end
                    workspace.CurrentCamera.CameraSubject = entry.Obj
                    return
                end
            end, OnRightClick = function()
                workspace.CurrentCamera.CameraSubject = player.Character
            end})
            contextMenu:Register('FIRE_TOUCHTRANSMITTER', {Name = 'Fire TouchTransmitter', IconMap = object.ClassIcons, Icon = 37, OnClick = function()
                local humanoidRootPart = player.Character and player.Character:FindFirstChild('HumanoidRootPart')
                if not humanoidRootPart then
                    return
                end
                for _, v in ipairs(selection.List) do
                    if v.Obj and v.Obj:IsA('TouchTransmitter') then
                        firetouchinterest(humanoidRootPart, v.Obj.Parent, 0)
                    end
                end
            end})
            contextMenu:Register('FIRE_CLICKDETECTOR', {Name = 'Fire ClickDetector', IconMap = object.ClassIcons, Icon = 41, OnClick = function()
                if not player.Character or not player.Character:FindFirstChild('HumanoidRootPart') then
                    return
                end
                for _, v in ipairs(selection.List) do
                    if v.Obj and v.Obj:IsA('ClickDetector') then
                        fireclickdetector(v.Obj)
                    end
                end
            end})
            contextMenu:Register('FIRE_PROXIMITYPROMPT', {Name = 'Fire ProximityPrompt', IconMap = object.ClassIcons, Icon = 124, OnClick = function()
                if not player.Character or not player.Character:FindFirstChild('HumanoidRootPart') then
                    return
                end
                for _, v in ipairs(selection.List) do
                    if v.Obj and v.Obj:IsA('ProximityPrompt') then
                        fireproximityprompt(v.Obj)
                    end
                end
            end})
            contextMenu:Register('VIEW_SCRIPT', {Name = 'View Script', IconMap = object.MiscIcons, Icon = 'ViewScript', OnClick = function()
                local obj = selection.List[1] and selection.List[1].Obj
                if obj then
                    v7.ViewScript(obj)
                end
            end})
            contextMenu:Register('SELECT_CHARACTER', {Name = 'Select Character', IconMap = object.ClassIcons, Icon = 9, OnClick = function()
                local list = {}
                local count = 1
                local list2 = selection.List
                local isA = game.IsA
                for i = 1, #list2 do
                    local entry = list2[i]
                    if isA(entry.Obj, 'Player') and nodes[entry.Obj.Character] then
                        list[count] = nodes[entry.Obj.Character]
                        count = count + 1
                    end
                end
                selection:SetTable(list)
                if #list > 0 then
                    object.ViewNode(list[1])
                    return
                end
                object.Refresh()
            end})
            contextMenu:Register('SELECT_LOCAL_PLAYER', {Name = 'Select Local Player', IconMap = object.ClassIcons, Icon = 9, OnClick = function()
                pcall(function()
                    if nodes[player] then
                        selection:Set(nodes[player])
                        object.ViewNode(nodes[player])
                    end
                end)
            end})
            contextMenu:Register('REFRESH_NIL', {Name = 'Refresh Nil Instances', OnClick = function()
                object.RefreshNilInstances()
            end})
            contextMenu:Register('HIDE_NIL', {Name = 'Hide Nil Instances', OnClick = function()
                object.HideNilInstances()
            end})
            object.RightClickContext = contextMenu
        end
        function object.HideNilInstances()
            table.clear(set3)
            local disconnect = Instance.new('Folder').ChildAdded:Connect(function()
            end).Disconnect
            for _, v in next, tbl2 do
                disconnect(v[1])
                disconnect(v[2])
            end
            table.clear(tbl2)
            for i = 1, #data do
                coroutine.wrap(handler2)(data[i].Obj)
            end
            object.Update()
            object.Refresh()
        end
        function object.RefreshNilInstances()
            if not v11.getnilinstances then
                return
            end
            local list = v11.getnilinstances()
            local game = game
            local getDescendants = game.GetDescendants
            for i = 1, #list do
                local entry = list[i]
                if entry ~= game then
                    set3[entry] = true
                    local descendants = getDescendants(entry)
                    for j = 1, #descendants do
                        set3[descendants[j]] = true
                    end
                end
            end
            for i = 1, #list do
                local entry2 = list[i]
                local node = nodes[entry2]
                if node then
                    continue
                end
                coroutine.wrap(handler)(entry2)
            end
            object.Update()
            object.Refresh()
        end
        function object.GetInstancePath(arg1)
            local findFirstChild = game.FindFirstChild
            local getChildren = game.GetChildren
            local text = ''
            local value = arg1
            local tostring = tostring
            local match = string.match
            local _ = string.gsub
            local find = table.find
            local copyPathUseGetChildren = v4.Explorer.CopyPathUseGetChildren
            local formatLuaString = v2.FormatLuaString
            while value do
                if value == game then
                    text = 'game' .. text
                    return text
                end
                local className = value.ClassName
                local text2 = tostring(value)
                local v1
                v1 = match(text2, '^[%a_][%w_]*$') and '.' .. text2 or '["' .. formatLuaString(text2) .. '"]'
                local parent = value.Parent
                if parent then
                    local firstChild = findFirstChild(parent, text2)
                    if copyPathUseGetChildren and firstChild and firstChild ~= value then
                        local children = getChildren(parent)
                        local result = find(children, value)
                        v1 = ':GetChildren()[' .. result .. ']'
                    else
                        if parent == game and v9.Classes[className] and v9.Classes[className].Tags.Service then
                            v1 = ':GetService("' .. className .. '")'
                        end
                    end
                elseif parent == nil then
                    v1 = 'local getNil = function(name, class) for _, v in next, getnilinstances() do if v.ClassName == class and v.Name == name then return v end end end' .. ('\n\ngetNil("%s", "%s")'):format(value.Name, className)
                end
                text = v1 .. text
                value = parent
            end
            return text
        end
        function object.InitInsertObject()
            local contextMenu = v2.ContextMenu.new()
            contextMenu.SearchEnabled = true
            contextMenu.MaxHeight = 400
            contextMenu:ApplyTheme({ContentColor = v4.Theme.Main2, OutlineColor = v4.Theme.Outline1, DividerColor = v4.Theme.Outline1, TextColor = v4.Theme.Text, HighlightColor = v4.Theme.ButtonHover})
            local list = {}
            for _, class in next, v9.Classes do
                local tags = class.Tags
                if not tags.NotCreatable and not tags.Service then
                    local class2 = v10.Classes[class.Name]
                    list[#list + 1] = {class, class2 and class2.ClassCategory or 'Uncategorized'}
                end
            end
            table.sort(list, function(a, b)
                if a[2] ~= b[2] then
                    return a[2] < b[2]
                end
                return a[1].Name < b[1].Name
            end)
            local function onClick(arg1)
                local list = selection.List
                local new = Instance.new
                for i = 1, #list do
                    local entry = list[i]
                    local obj = entry.Obj
                    object.MakeNodeVisible(entry, true)
                    pcall(new, arg1, obj)
                end
            end
            local text = ''
            for i = 1, #list do
                local v1 = list[i][1]
                local class = v10.Classes[v1.Name]
                local icon = class and tonumber(class.ExplorerImageIndex) or 0
                local v3 = list[i][2]
                if text ~= v3 then
                    contextMenu:AddDivider(v3)
                    text = v3
                end
                contextMenu:Add({Name = v1.Name, IconMap = object.ClassIcons, Icon = icon, OnClick = onClick})
            end
            object.InsertObjectContext = contextMenu
        end
        object.SearchFilters = {Comparison = {isa = function(text)
            local lower = string.lower
            local find = string.find
            local result = string.split(text)[1]
            if not result then
                return
            end
            result = lower(result)
            local v1
            for k, _ in pairs(v9.Classes) do
                local result2 = lower(k)
                if result2 == result then
                    v1 = k
                    break
                end
                if not find(result2, result, 1, true) then
                    continue
                end
                v1 = k
            end
            if not v1 then
                return
            end
            return {Headers = {'local isa = game.IsA'}, Predicate = 'isa(obj,\'' .. v1 .. '\')'}
        end, remotes = function(arg1)
            return {Headers = {'local isa = game.IsA'}, Predicate = 'isa(obj,\'RemoteEvent\') or isa(obj,\'RemoteFunction\')'}
        end, bindables = function(arg1)
            return {Headers = {'local isa = game.IsA'}, Predicate = 'isa(obj,\'BindableEvent\') or isa(obj,\'BindableFunction\')'}
        end, rad = function(text)
            local number = tonumber(text)
            if not number then
                return
            end
            if not service.Players.LocalPlayer.Character or not service.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') or not service.Players.LocalPlayer.Character.HumanoidRootPart:IsA('BasePart') then
                return
            end
            return {Headers = {'local isa = game.IsA', 'local hrp = service.Players.LocalPlayer.Character.HumanoidRootPart'}, Setups = {'local hrpPos = hrp.Position'}, ObjectDefs = {'local isBasePart = isa(obj,\'BasePart\')'}, Predicate = '(isBasePart and (obj.Position-hrpPos).Magnitude <= ' .. number .. ')'}
        end}, Specific = {players = function()
            return function()
                return service.Players:GetPlayers()
            end
        end, loadedmodules = function()
            return v11.getloadedmodules
        end}, Default = function(text, arg2)
            local text2 = text:gsub('"', '\\"'):gsub('\n', '\\n')
            if arg2 then
                return {Headers = {'local find = string.find'}, ObjectDefs = {'local objName = tostring(obj)'}, Predicate = 'find(objName,"' .. text2 .. '",1,true)'}
            end
            return {Headers = {'local lower = string.lower', 'local find = string.find', 'local tostring = tostring'}, ObjectDefs = {'local lowerName = lower(tostring(obj))'}, Predicate = 'find(lowerName,"' .. text2:lower() .. '",1,true)'}
        end, SpecificDefault = function(text)
            return {Headers = {}, ObjectDefs = {'local isSpec' .. text .. ' = specResults[' .. text .. '][node]'}, Predicate = 'isSpec' .. text}
        end}
        function object.BuildSearchFunc(text)
            local list = {}
            local map = {}
            local text2 = ''
            local rep = string.rep
            local list2 = text:gsub('\\.', '  '):gsub('".-"', function(list)
                return rep(' ', #list)
            end)
            local set2 = {}
            local set3 = {}
            local set4 = {}
            local find, sub, lower = string.find, string.sub, string.lower
            local match = string.match
            local data = {['('] = '(', [')'] = ')', ['||'] = ' or ', ['&&'] = ' and '}
            local comparison = object.SearchFilters.Comparison
            local specific = object.SearchFilters.Specific
            local num = 1
            local v1
            local function processFilter(arg1)
                if arg1.Headers then
                    local headers = arg1.Headers
                    for i = 1, #headers do
                        set2[headers[i]] = true
                    end
                end
                if arg1.ObjectDefs then
                    local objectDefs = arg1.ObjectDefs
                    for i = 1, #objectDefs do
                        set3[objectDefs[i]] = true
                    end
                end
                if arg1.Setups then
                    local setups = arg1.Setups
                    for i = 1, #setups do
                        set4[setups[i]] = true
                    end
                end
                text2 ..= arg1.Predicate
            end
            local list3 = {}
            local map2 = {}
            local find2 = string.find
            local sub2 = string.sub
            local function findAll(arg1, list)
                local count = #list3 + 1
                local num = 1
                local count2 = #list
                local v1, v2, v3 = find2(arg1, list, num, true)
                while v1 do
                    list3[count] = v1
                    map2[v1] = {count2, list}
                    count = count + 1
                    local v4 = v2 + 1
                    local v5, v6, v7 = find2(arg1, list, v4, true)
                    v1 = v5
                    v2 = v6
                    local _ = v7
                end
            end
            local _ = tick()
            findAll(list2, '&&')
            findAll(list2, '||')
            findAll(list2, '(')
            findAll(list2, ')')
            table.sort(list3)
            table.insert(list3, #list2 + 1)
            local function inQuotes(list)
                local count = #list
                if sub2(list, 1, 1) == '"' and sub2(list, count, count) == '"' then
                    return sub2(list, 2, count - 1)
                end
            end
            for i = 1, #list3 do
                local entry = list3[i]
                local list4 = map2[entry] or {1}
                local v2 = data[list4[2]]
                local result = sub2(text, num, entry - 1)
                local list5 = match(result, '^%s*(.-)%s*$') or ''
                if #list5 > 0 then
                    if sub2(list5, 1, 1) == '!' then
                        list5 = sub2(list5, 2)
                        text2 ..= 'not '
                    end
                    local result2 = inQuotes(list5)
                    if result2 then
                        processFilter(object.SearchFilters.Default(result2, true))
                    else
                        local v3, v4 = find2(list5, '%S+')
                        if v3 then
                            local result3 = sub2(list5, v3, v4)
                            local result4 = sub2(result3, 1, 1) == '/' and lower(sub2(result3, 2))
                            local callback = result4 and comparison[result4]
                            local callback2 = result4 and specific[result4]
                            if callback then
                                local result5 = sub2(list5, v4 + 2)
                                local result6 = callback(inQuotes(result5) or result5)
                                if result6 then
                                    processFilter(result6)
                                else
                                    text2 ..= 'false'
                                end
                            elseif callback2 then
                                local result7 = sub2(list5, v4 + 2)
                                local result8 = callback2(inQuotes(result7) or result7)
                                if result8 then
                                    if not map[list5] then
                                        list[#list + 1] = result8
                                        map[list5] = #list
                                    end
                                    processFilter(object.SearchFilters.SpecificDefault(map[list5]))
                                else
                                    text2 ..= 'false'
                                end
                            else
                                processFilter(object.SearchFilters.Default(list5))
                            end
                        end
                    end
                end
                if v2 then
                    text2 ..= v2
                    if v2 == '(' and (#list5 > 0 or v1 == ')') then
                        return
                    end
                    v1 = v2
                end
                num = entry + list4[1]
            end
            local text3 = ''
            local text4 = ''
            local text5 = ''
            for k, _ in next, set4 do
                text3 ..= k .. '\n'
            end
            for k, _ in next, set2 do
                text4 ..= k .. '\n'
            end
            for k, _ in next, set3 do
                text5 ..= k .. '\n'
            end
            local result9 = ('local searchResults = searchResults\nlocal nodes = nodes\nlocal expandTable = Explorer.SearchExpanded\nlocal specResults = specResults\nlocal service = service\n\n%s\nlocal function search(root)\t\n%s\n\t\n\tlocal expandedpar = false\n\tfor i = 1,#root do\n\t\tlocal node = root[i]\n\t\tlocal obj = node.Obj\n\t\t\n%s\n\t\t\n\t\tif %s then\n\t\t\texpandTable[node] = 0\n\t\t\tsearchResults[node] = true\n\t\t\tif not expandedpar then\n\t\t\t\tlocal parnode = node.Parent\n\t\t\t\twhile parnode and (not searchResults[parnode] or expandTable[parnode] == 0) do\n\t\t\t\t\texpandTable[parnode] = true\n\t\t\t\t\tsearchResults[parnode] = true\n\t\t\t\t\tparnode = parnode.Parent\n\t\t\t\tend\n\t\t\t\texpandedpar = true\n\t\t\tend\n\t\tend\n\t\t\n\t\tif #node > 0 then search(node) end\n\tend\nend\nreturn search'):format(text4, text3, text5, text2)
            local success, result10 = pcall(loadstring, result9)
            if not success or not result10 then
                return nil, list
            else
                local object2 = setmetatable({searchResults = set, nodes = nodes, Explorer = object, specResults = specResults, service = service}, {__index = getfenv()})
                setfenv(result10, object2)
                return result10(), list
            end
        end
        function object.DoSearch(list)
            table.clear(object.SearchExpanded)
            table.clear(set)
            set2 = #list == 0 and object.Expanded or object.SearchExpanded
            callback3 = nil
            if #list > 0 then
                local searchExpanded = object.SearchExpanded
                local list2
                local lower = string.lower
                local find = string.find
                local tostring = tostring
                local result = lower(list)
                local function defaultSearch(list)
                    local flag = false
                    for i = 1, #list do
                        local list2 = list[i]
                        local obj = list2.Obj
                        if find(lower(tostring(obj)), result, 1, true) then
                            searchExpanded[list2] = 0
                            set[list2] = true
                            if not flag then
                                local parent = list2.Parent
                                while parent and (not set[parent] or searchExpanded[parent] == 0) do
                                    set2[parent] = true
                                    set[parent] = true
                                    parent = parent.Parent
                                end
                                flag = true
                            end
                        end
                        if #list2 > 0 then
                            defaultSearch(list2)
                        end
                    end
                end
                if v1.Elevated then
                    local _ = tick()
                    callback3, list2 = object.BuildSearchFunc(list)
                else
                    callback3 = defaultSearch
                end
                if list2 then
                    table.clear(specResults)
                    for i = 1, #list2 do
                        local set3 = {}
                        specResults[i] = set3
                        local list3 = list2[i]()
                        for j = 1, #list3 do
                            local v2 = nodes[list3[j]]
                            if not v2 then
                                continue
                            end
                            set3[v2] = true
                        end
                    end
                end
                if callback3 then
                    local _ = tick()
                    callback3(nodes[game])
                    callback3(data)
                end
            end
            object.ForceUpdate()
        end
        function object.ClearSearch()
            object.GuiElems.SearchBar.Text = ''
            set2 = object.Expanded
            callback3 = nil
        end
        function object.InitSearch()
            local searchBox = object.GuiElems.ToolBar.SearchFrame.SearchBox
            object.GuiElems.SearchBar = searchBox
            v2.ViewportTextBox.convert(searchBox)
            searchBox.FocusLost:Connect(function()
                object.DoSearch(searchBox.Text)
            end)
        end
        function object.InitEntryTemplate()
            template = callback2({{1, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.new(0, 0, 0), Font = 3, Name = 'Entry', Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(0, 250, 0, 20), Text = '', TextSize = 14}}, {2, 'Frame', {BackgroundColor3 = Color3.new(0.04313725605607, 0.35294118523598, 0.68627452850342), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.33725491166115, 0.49019610881805, 0.73725491762161), BorderSizePixel = 0, Name = 'Indent', Parent = {1}, Position = UDim2.new(0, 20, 0, 0), Size = UDim2.new(1, -20, 1, 0)}}, {3, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'EntryName', Parent = {2}, Position = UDim2.new(0, 26, 0, 0), Size = UDim2.new(1, -26, 1, 0), Text = 'Workspace', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {4, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ClipsDescendants = true, Font = 3, Name = 'Expand', Parent = {2}, Position = UDim2.new(0, -20, 0, 0), Size = UDim2.new(0, 20, 0, 20), Text = '', TextSize = 14}}, {5, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://5642383285', ImageRectOffset = Vector2.new(144, 16), ImageRectSize = Vector2.new(16, 16), Name = 'Icon', Parent = {4}, Position = UDim2.new(0, 2, 0, 2), ScaleType = 4, Size = UDim2.new(0, 16, 0, 16)}}, {6, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxasset://textures/ClassImages.png', ImageRectOffset = Vector2.new(304, 0), ImageRectSize = Vector2.new(16, 16), Name = 'Icon', Parent = {2}, Position = UDim2.new(0, 4, 0, 2), ScaleType = 4, Size = UDim2.new(0, 16, 0, 16)}}})
            local clickSystem = v2.ClickSystem.new()
            clickSystem.AllowedButtons = {1, 2}
            clickSystem.OnDown:Connect(function(value, arg2, arg3)
                local index = table.find(map, value)
                if not index then
                    return
                end
                local piviot = tbl[index + object.Index]
                if not piviot then
                    return
                end
                local _ = map[index]
                if arg3 == 1 then
                    if arg2 == 2 then
                        if piviot.Obj:IsA('LuaSourceContainer') then
                            v7.ViewScript(piviot.Obj)
                        elseif #piviot > 0 and set2[piviot] ~= 0 then
                            set2[piviot] = not set2[piviot]
                            object.Update()
                        end
                    end
                    if v6.SelectObject(piviot.Obj) then
                        clickSystem.IsRenaming = false
                        return
                    end
                    clickSystem.IsRenaming = selection.Map[piviot]
                    if v2.IsShiftDown() then
                        if not selection.Piviot then
                            return
                        end
                        local index2 = table.find(tbl, selection.Piviot)
                        local find = table.find
                        local min = tbl
                        local max = find(min, piviot)
                        if not index2 or not max then
                            return
                        else
                            min = math.min(index2, max)
                            max = math.max(index2, max)
                            index2 = min
                            local list = selection.List
                            for i = #list, 1, -1 do
                                local entry = list[i]
                                if not selection.ShiftSet[entry] then
                                    continue
                                end
                                selection.Map[entry] = nil
                                table.remove(list, i)
                            end
                            selection.ShiftSet = {}
                            for i = index2, max do
                                local entry2 = tbl[i]
                                if selection.Map[entry2] then
                                    continue
                                end
                                selection.ShiftSet[entry2] = true
                                selection.Map[entry2] = true
                                list[#list + 1] = entry2
                            end
                            selection.Changed:Fire()
                        end
                    elseif v2.IsCtrlDown() then
                        selection.ShiftSet = {}
                        if selection.Map[piviot] then
                            selection:Remove(piviot)
                        else
                            selection:Add(piviot)
                        end
                        selection.Piviot = piviot
                        clickSystem.IsRenaming = false
                    else
                        if not selection.Map[piviot] then
                            selection.ShiftSet = {}
                            selection:Set(piviot)
                            selection.Piviot = piviot
                        end
                    end
                elseif arg3 == 2 then
                    if v6.SelectObject(piviot.Obj) then
                        return
                    end
                    if not v2.IsCtrlDown() and not selection.Map[piviot] then
                        selection.ShiftSet = {}
                        selection:Set(piviot)
                        selection.Piviot = piviot
                        object.Refresh()
                    end
                end
                object.Refresh()
            end)
            clickSystem.OnRelease:Connect(function(value, arg2, arg3)
                local index = table.find(map, value)
                if not index then
                    return
                else
                    local piviot = tbl[index + object.Index]
                    if not piviot then
                        return
                    end
                    if arg3 == 1 then
                        if selection.Map[piviot] and not v2.IsShiftDown() and not v2.IsCtrlDown() then
                            selection.ShiftSet = {}
                            selection:Set(piviot)
                            selection.Piviot = piviot
                            object.Refresh()
                        end
                        local clickId = clickSystem.ClickId
                        v2.FastWait(clickSystem.ComboTime)
                        if arg2 == 1 and clickId == clickSystem.ClickId and clickSystem.IsRenaming and selection.Map[piviot] then
                            object.SetRenamingNode(piviot)
                        end
                    elseif arg3 == 2 then
                        object.ShowRightClick()
                    end
                end
            end)
            object.ClickSystem = clickSystem
        end
        function object.InitDelCleaner()
            coroutine.wrap(function()
                local fastWait = v2.FastWait
                while true do
                    local flag = false
                    local count = 0
                    for _, node in next, nodes do
                        if node.HasDel then
                            local count2
                            for i = 1, #node do
                                if not node[i].Del then
                                    continue
                                end
                                count2 = i
                                break
                            end
                            if count2 then
                                for i = count2 + 1, #node do
                                    local entry = node[i]
                                    if entry.Del then
                                        continue
                                    end
                                    node[count2] = entry
                                    count2 += 1
                                end
                                for i = count2, #node do
                                    node[i] = nil
                                end
                            end
                            node.HasDel = false
                            flag = true
                            fastWait()
                        end
                        count = count + 1
                        if count > 10000 then
                            count = 0
                            fastWait()
                        end
                    end
                    if flag and not flag2 then
                        object.PerformRefresh()
                    end
                    fastWait(0.5)
                end
            end)()
        end
        function object.UpdateSelectionVisuals()
            local screenGui = object.SelectionVisualsHolder
            local isA = game.IsA
            local clone = game.Clone
            if not screenGui then
                screenGui = Instance.new('ScreenGui')
                screenGui.Name = 'ExplorerSelections'
                screenGui.DisplayOrder = v1.DisplayOrders.Core
                v2.ShowGui(screenGui)
                object.SelectionVisualsHolder = screenGui
                object.SelectionVisualCons = {}
                local selectionVisualGui = callback2({{1, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Size = UDim2.new(0, 100, 0, 100)}}, {2, 'Frame', {BackgroundColor3 = Color3.new(0.04313725605607, 0.35294118523598, 0.68627452850342), BorderSizePixel = 0, Parent = {1}, Position = UDim2.new(0, -1, 0, -1), Size = UDim2.new(1, 2, 0, 1)}}, {3, 'Frame', {BackgroundColor3 = Color3.new(0.04313725605607, 0.35294118523598, 0.68627452850342), BorderSizePixel = 0, Parent = {1}, Position = UDim2.new(0, -1, 1, 0), Size = UDim2.new(1, 2, 0, 1)}}, {4, 'Frame', {BackgroundColor3 = Color3.new(0.04313725605607, 0.35294118523598, 0.68627452850342), BorderSizePixel = 0, Parent = {1}, Position = UDim2.new(0, -1, 0, 0), Size = UDim2.new(0, 1, 1, 0)}}, {5, 'Frame', {BackgroundColor3 = Color3.new(0.04313725605607, 0.35294118523598, 0.68627452850342), BorderSizePixel = 0, Parent = {1}, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 1, 1, 0)}}})
                object.SelectionVisualGui = selectionVisualGui
                local selectionBox = Instance.new('SelectionBox')
                selectionBox.LineThickness = 0.03
                selectionBox.Color3 = Color3.fromRGB(0, 170, 255)
                object.SelectionVisualBox = selectionBox
            end
            screenGui:ClearAllChildren()
            for _, child in pairs(object.SelectionVisualGui:GetChildren()) do
                child.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            end
            local selectionVisualCons = object.SelectionVisualCons
            for i = 1, #selectionVisualCons do
                selectionVisualCons[i].Destroy()
            end
            table.clear(selectionVisualCons)
            local partSelectionBox = v4.Explorer.PartSelectionBox
            local guiSelectionBox = v4.Explorer.GuiSelectionBox
            if not partSelectionBox and not guiSelectionBox then
                return
            end
            local selectionVisualGui2 = object.SelectionVisualGui
            local selectionVisualBox = object.SelectionVisualBox
            local attachTo = v2.AttachTo
            local list = selection.List
            local count = 1
            local count2 = 0
            local node = nodes[workspace]
            for i = 1, #list do
                if count2 > 1000 then
                    break
                end
                local entry = list[i]
                local obj = entry.Obj
                if entry ~= node then
                    if isA(obj, 'GuiObject') and guiSelectionBox then
                        local result = clone(selectionVisualGui2)
                        selectionVisualCons[count] = attachTo(result, {Target = obj, Resize = true})
                        count = count + 1
                        result.Parent = screenGui
                        count2 += 1
                    elseif isA(obj, 'PVInstance') and partSelectionBox then
                        local result2 = clone(selectionVisualBox)
                        result2.Adornee = obj
                        result2.Parent = screenGui
                        count2 += 1
                    end
                end
            end
        end
        function object.Init()
            object.ClassIcons = v2.IconMap.newLinear('rbxasset://textures/ClassImages.png', 16, 16)
            object.MiscIcons = v1.MiscIcons
            list = {}
            selection = v2.Set.new()
            selection.ShiftSet = {}
            selection.Changed:Connect(v6.ShowExplorerProps)
            object.Selection = selection
            object.InitRightClick()
            object.InitInsertObject()
            object.SetSortingEnabled(v4.Explorer.Sorting)
            object.Expanded = setmetatable({}, {__mode = 'k'})
            object.SearchExpanded = setmetatable({}, {__mode = 'k'})
            set2 = object.Expanded
            data.Obj.Name = 'Nil Instances'
            data.Locked = true
            local result = callback2({{1, 'Folder', {Name = 'ExplorerItems'}}, {2, 'Frame', {BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BorderSizePixel = 0, Name = 'ToolBar', Parent = {1}, Size = UDim2.new(1, 0, 0, 22)}}, {3, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.1176470592618, 0.1176470592618, 0.1176470592618), BorderSizePixel = 0, Name = 'SearchFrame', Parent = {2}, Position = UDim2.new(0, 3, 0, 1), Size = UDim2.new(1, -6, 0, 18)}}, {4, 'TextBox', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ClearTextOnFocus = false, Font = 3, Name = 'SearchBox', Parent = {3}, PlaceholderColor3 = Color3.new(0.39215689897537, 0.39215689897537, 0.39215689897537), PlaceholderText = 'Search workspace', Position = UDim2.new(0, 4, 0, 0), Size = UDim2.new(1, -24, 0, 18), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0}}, {5, 'UICorner', {CornerRadius = UDim.new(0, 2), Parent = {3}}}, {6, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Reset', Parent = {3}, Position = UDim2.new(1, -17, 0, 1), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14}}, {7, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://5034718129', ImageColor3 = Color3.new(0.39215686917305, 0.39215686917305, 0.39215686917305), Parent = {6}, Size = UDim2.new(0, 16, 0, 16)}}, {8, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Refresh', Parent = {2}, Position = UDim2.new(1, -20, 0, 1), Size = UDim2.new(0, 18, 0, 18), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, Visible = false}}, {9, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://5642310344', Parent = {8}, Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(0, 12, 0, 12)}}, {10, 'Frame', {BackgroundColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, Name = 'ScrollCorner', Parent = {1}, Position = UDim2.new(1, -16, 1, -16), Size = UDim2.new(0, 16, 0, 16), Visible = false}}, {11, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ClipsDescendants = true, Name = 'List', Parent = {1}, Position = UDim2.new(0, 0, 0, 23), Size = UDim2.new(1, 0, 1, -23)}}})
            toolBar = result.ToolBar
            template2 = result.List
            object.GuiElems.ToolBar = toolBar
            object.GuiElems.TreeFrame = template2
            v3 = v2.ScrollBar.new()
            v3.WheelIncrement = 3
            v3.Gui.Position = UDim2.new(1, -16, 0, 23)
            v3:SetScrollFrame(template2)
            v3.Scrolled:Connect(function()
                object.Index = v3.Index
                object.Refresh()
            end)
            v5 = v2.ScrollBar.new(true)
            v5.Increment = 5
            v5.WheelIncrement = object.EntryIndent
            v5.Gui.Position = UDim2.new(0, 0, 1, -16)
            v5.Scrolled:Connect(function()
                object.Refresh()
            end)
            local window = v2.Window.new()
            object.Window = window
            window:SetTitle('Explorer')
            window.GuiElems.Line.Position = UDim2.new(0, 0, 0, 22)
            object.InitEntryTemplate()
            toolBar.Parent = window.GuiElems.Content
            template2.Parent = window.GuiElems.Content
            result.ScrollCorner.Parent = window.GuiElems.Content
            v3.Gui.Parent = window.GuiElems.Content
            v5.Gui.Parent = window.GuiElems.Content
            object.InitRenameBox()
            object.InitSearch()
            object.InitDelCleaner()
            selection.Changed:Connect(object.UpdateSelectionVisuals)
            window.GuiElems.Main:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
                if object.Active then
                    object.UpdateView()
                    object.Refresh()
                end
            end)
            window.OnActivate:Connect(function()
                object.Active = true
                object.UpdateView()
                object.Update()
                object.Refresh()
            end)
            window.OnRestore:Connect(function()
                object.Active = true
                object.UpdateView()
                object.Update()
                object.Refresh()
            end)
            window.OnDeactivate:Connect(function()
                object.Active = false
            end)
            window.OnMinimize:Connect(function()
                object.Active = false
            end)
            v13 = v4.Explorer.AutoUpdateSearch
            nodes[game] = {Obj = game}
            set2[nodes[game]] = true
            if v11.getnilinstances then
                nodes[data.Obj] = data
            end
            object.SetupConnections()
            local descendants = getDescendants(game)
            if v1.Elevated then
                for i = 1, #descendants do
                    local obj = descendants[i]
                    local list2 = nodes[findFirstAncestorWhichIsA(obj, 'Instance')]
                    if not list2 then
                        continue
                    end
                    local data2 = {Obj = obj, Parent = list2}
                    nodes[obj] = data2
                    list2[#list2 + 1] = data2
                end
                return
            else
                for i = 1, #descendants do
                    local obj2 = descendants[i]
                    local success, result2 = pcall(findFirstAncestorWhichIsA, obj2, 'Instance')
                    local list3 = nodes[result2]
                    if not list3 then
                        continue
                    end
                    local data3 = {Obj = obj2, Parent = list3}
                    nodes[obj2] = data3
                    list3[#list3 + 1] = data3
                end
            end
        end
        return object
    end}
end, Properties = function()
    local v1
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
    local v12
    local v13
    local callback
    local v14
    return {InitDeps = function(self)
        v1 = self.Main
        v2 = self.Lib
        v3 = self.Apps
        v4 = self.Settings
        v9 = self.API
        v10 = self.RMD
        v11 = self.env
        v12 = self.service
        v13 = self.plr
        callback = self.create
        v14 = self.createSimple
    end, InitAfterMain = function()
        v5 = v3.Explorer
        v6 = v3.Properties
        v7 = v3.ScriptViewer
        v8 = v3.Notebook
    end, Main = function()
        local object = {}
        local window
        local toolBar
        local parent
        local v3
        local v6
        local v7
        local list = {}
        local tbl = {}
        local set = {}
        local map = {}
        local list2 = {}
        local tbl2 = {}
        local gui
        local label
        local v8
        local list3 = {}
        local list4 = {}
        local table = table
        local string = string
        local getPropertyChangedSignal = game.GetPropertyChangedSignal
        local getAttributeChangedSignal = game.GetAttributeChangedSignal
        local isA = game.IsA
        local getAttribute = game.GetAttribute
        local setAttribute = game.SetAttribute
        object.GuiElems = {}
        object.Index = 0
        object.ViewWidth = 0
        object.MinInputWidth = 100
        object.EntryIndent = 16
        object.EntryOffset = 4
        object.NameWidthCache = {}
        object.SubPropCache = {}
        object.ClassLists = {}
        object.SearchText = ''
        object.AddAttributeProp = {Category = 'Attributes', Class = '', Name = '', SpecialRow = 'AddAttribute', Tags = {}}
        object.SoundPreviewProp = {Category = 'Data', ValueType = {Name = 'SoundPlayer'}, Class = 'Sound', Name = 'Preview', Tags = {}}
        object.IgnoreProps = {DataModel = {PrivateServerId = true, PrivateServerOwnerId = true, VIPServerId = true, VIPServerOwnerId = true}}
        object.ExpandableTypes = {Vector2 = true, Vector3 = true, UDim = true, UDim2 = true, CFrame = true, Rect = true, PhysicalProperties = true, Ray = true, NumberRange = true, Faces = true, Axes = true}
        object.ExpandableProps = {['Sound.SoundId'] = true}
        object.CollapsedCategories = {['Surface Inputs'] = true, Surface = true}
        object.ConflictSubProps = {Vector2 = {'X', 'Y'}, Vector3 = {'X', 'Y', 'Z'}, UDim = {'Scale', 'Offset'}, UDim2 = {'X', 'X.Scale', 'X.Offset', 'Y', 'Y.Scale', 'Y.Offset'}, CFrame = {'Position', 'Position.X', 'Position.Y', 'Position.Z', 'RightVector', 'RightVector.X', 'RightVector.Y', 'RightVector.Z', 'UpVector', 'UpVector.X', 'UpVector.Y', 'UpVector.Z', 'LookVector', 'LookVector.X', 'LookVector.Y', 'LookVector.Z'}, Rect = {'Min.X', 'Min.Y', 'Max.X', 'Max.Y'}, PhysicalProperties = {'Density', 'Elasticity', 'ElasticityWeight', 'Friction', 'FrictionWeight'}, Ray = {'Origin', 'Origin.X', 'Origin.Y', 'Origin.Z', 'Direction', 'Direction.X', 'Direction.Y', 'Direction.Z'}, NumberRange = {'Min', 'Max'}, Faces = {'Back', 'Bottom', 'Front', 'Left', 'Right', 'Top'}, Axes = {'X', 'Y', 'Z'}}
        object.ConflictIgnore = {BasePart = {ResizableFaces = true}}
        object.RoundableTypes = {float = true, double = true, Color3 = true, UDim = true, UDim2 = true, Vector2 = true, Vector3 = true, NumberRange = true, Rect = true, NumberSequence = true, ColorSequence = true, Ray = true, CFrame = true}
        object.TypeNameConvert = {number = 'double', boolean = 'bool'}
        object.ToNumberTypes = {int = true, int64 = true, float = true, double = true}
        object.DefaultPropValue = {string = '', bool = false, double = 0, UDim = UDim.new(0, 0), UDim2 = UDim2.new(0, 0, 0, 0), BrickColor = BrickColor.new('Medium stone grey'), Color3 = Color3.new(1, 1, 1), Vector2 = Vector2.new(0, 0), Vector3 = Vector3.new(0, 0, 0), NumberSequence = NumberSequence.new(1), ColorSequence = ColorSequence.new(Color3.new(1, 1, 1)), NumberRange = NumberRange.new(0), Rect = Rect.new(0, 0, 0, 0)}
        object.AllowedAttributeTypes = {'string', 'boolean', 'number', 'UDim', 'UDim2', 'BrickColor', 'Color3', 'Vector2', 'Vector3', 'NumberSequence', 'ColorSequence', 'NumberRange', 'Rect'}
        function object:StringToValue(text)
            local valueType = self.ValueType
            local name = valueType.Name
            if name == 'string' or name == 'Content' then
                return text
            end
            if object.ToNumberTypes[name] then
                return tonumber(text)
            end
            if name == 'Vector2' then
                local list = text:split(',')
                local number, number2 = tonumber(list[1]), tonumber(list[2])
                if number and number2 and #list >= 2 then
                    return Vector2.new(number, number2)
                end
            elseif name == 'Vector3' then
                local list2 = text:split(',')
                local number3, number4, number5 = tonumber(list2[1]), tonumber(list2[2]), tonumber(list2[3])
                if number3 and number4 and number5 and #list2 >= 3 then
                    return Vector3.new(number3, number4, number5)
                end
            elseif name == 'UDim' then
                local list3 = text:split(',')
                local number6, number7 = tonumber(list3[1]), tonumber(list3[2])
                if number6 and number7 and #list3 >= 2 then
                    return UDim.new(number6, number7)
                end
            elseif name == 'UDim2' then
                local list4 = text:gsub('[{}]', ''):split(',')
                local number8, number9, number10, number11 = tonumber(list4[1]), tonumber(list4[2]), tonumber(list4[3]), tonumber(list4[4])
                if number8 and number9 and number10 and number11 and #list4 >= 4 then
                    return UDim2.new(number8, number9, number10, number11)
                end
            elseif name == 'CFrame' then
                local list5 = text:split(',')
                local success, result = pcall(CFrame.new, unpack(list5))
                if success and #list5 >= 12 then
                    return result
                end
            elseif name == 'Rect' then
                local list6 = text:split(',')
                local success2, result2 = pcall(Rect.new, unpack(list6))
                if success2 and #list6 >= 4 then
                    return result2
                end
            elseif name == 'Ray' then
                local list7 = text:gsub('[{}]', ''):split(',')
                local success3, result3 = pcall(Vector3.new, unpack(list7, 1, 3))
                local success4, result4 = pcall(Vector3.new, unpack(list7, 4, 6))
                if success3 and success4 and #list7 >= 6 then
                    return Ray.new(result3, result4)
                end
            elseif name == 'NumberRange' then
                local list8 = text:split(',')
                local success5, result5 = pcall(NumberRange.new, unpack(list8))
                if success5 and #list8 >= 1 then
                    return result5
                end
            elseif name == 'Color3' then
                local list9 = text:gsub('[{}]', ''):split(',')
                local success6, result6 = pcall(Color3.fromRGB, unpack(list9))
                if success6 and #list9 >= 3 then
                    return result6
                end
            end
            return nil
        end
        function object:ValueToString(value)
            local valueType = self.ValueType
            local name = valueType.Name
            if name == 'Color3' then
                return v2.ColorToBytes(value)
            end
            if name == 'NumberRange' then
                return value.Min .. ', ' .. value.Max
            end
            return tostring(value)
        end
        function object.GetIndexableProps(arg1, instance)
            if not v1.Elevated and not pcall(function()
                return arg1.ClassName
            end) then
                return nil
            end
            local v2 = object.IgnoreProps[instance.Name] or {}
            local map = {}
            local count = 1
            local properties = instance.Properties
            for i = 1, #properties do
                local property = properties[i]
                if not v2[property.Name] and pcall(function()
                    return arg1[property.Name]
                end) then
                    map[count] = property
                    count = count + 1
                end
            end
            return map
        end
        function object.FindFirstObjWhichIsA(arg1)
            local list = object.ClassLists[arg1] or {}
            if list and #list > 0 then
                return list[1]
            end
            return nil
        end
        function object.ComputeConflicts(text)
            local maxConflictCheck = v4.Properties.MaxConflictCheck
            local list2 = v5.Selection.List
            local classLists = object.ClassLists
            local split = string.split
            local clear = table.clear
            local conflictIgnore = object.ConflictIgnore
            local set = {}
            local list3 = text and {text} or list
            if text then
                local v1 = text.Class .. '.' .. text.Name
                tbl2[v1] = nil
                local list4 = object.ConflictSubProps[text.ValueType.Name] or {}
                for i = 1, #list4 do
                    tbl2[v1 .. '.' .. list4[i]] = nil
                end
            else
                table.clear(tbl2)
            end
            if #list2 > 0 then
                for i = 1, #list3 do
                    local entry = list3[i]
                    local name = entry.Name
                    local class = entry.Class
                    local rootType = entry.RootType or entry.ValueType
                    local name2 = rootType.Name
                    local attributeName = entry.AttributeName
                    local v2 = class .. '.' .. name
                    local count = 0
                    local list5 = object.ConflictSubProps[name2] or {}
                    local count2 = #list5
                    local v3 = count2 + 1
                    local count3 = 0
                    local list6 = {}
                    local v6 = conflictIgnore[class] and conflictIgnore[class][name]
                    local v7 = name2 == 'PhysicalProperties'
                    local isAttribute = entry.IsAttribute
                    local multiType = entry.MultiType
                    clear(set)
                    if not multiType then
                        local attribute
                        local entry2
                        local flag
                        local list7 = classLists[entry.Class] or {}
                        for j = 1, #list7 do
                            local entry3 = list7[j]
                            if not flag then
                                if isAttribute then
                                    attribute = getAttribute(entry3, attributeName)
                                    if attribute ~= nil then
                                        entry2 = entry3
                                        flag = true
                                    end
                                else
                                    attribute = entry3[name]
                                    entry2 = entry3
                                    flag = true
                                end
                                if v6 then
                                    break
                                end
                            else
                                local attribute2
                                local flag2
                                if isAttribute then
                                    attribute2 = getAttribute(entry3, attributeName)
                                    if attribute2 == nil then
                                        flag2 = true
                                    end
                                else
                                    attribute2 = entry3[name]
                                end
                                if not flag2 then
                                    if not set[1] then
                                        if v7 then
                                            if (attribute and true or false) ~= (attribute2 and true or false) then
                                                set[1] = true
                                                count3 += 1
                                            end
                                        elseif attribute ~= attribute2 then
                                            set[1] = true
                                            count3 += 1
                                        end
                                    end
                                    if count2 > 0 then
                                        for k = 1, count2 do
                                            local list8 = list6[k]
                                            if not list8 then
                                                list8 = split(list5[k], '.')
                                                list6[k] = list8
                                            end
                                            local attribute3 = attribute
                                            local attribute4 = attribute2
                                            for l = 1, #list8 do
                                                if not attribute3 then
                                                    break
                                                end
                                                if not attribute4 then
                                                    break
                                                end
                                                local entry4 = list8[l]
                                                attribute3 = attribute3[entry4]
                                                attribute4 = attribute4[entry4]
                                            end
                                            local v8 = k + 1
                                            if not set[v8] and attribute3 ~= attribute4 then
                                                set[v8] = true
                                                count3 += 1
                                            end
                                        end
                                    end
                                    if count3 == v3 then
                                        break
                                    end
                                end
                            end
                            count = count + 1
                            if count == maxConflictCheck then
                                break
                            end
                        end
                        if not set[1] then
                            tbl2[v2] = entry2
                        end
                        for j = 1, count2 do
                            if set[j + 1] then
                                continue
                            end
                            tbl2[v2 .. '.' .. list5[j]] = entry2
                        end
                    end
                end
            end
            if text then
                object.Refresh()
            end
        end
        v4.Properties.ShowAttributes = true
        function object.ShowExplorerProps()
            local _ = v4.Properties.MaxConflictCheck
            local list2 = v5.Selection.List
            local set = {}
            local count = 1
            local _ = v1.Elevated
            local showDeprecated = v4.Properties.ShowDeprecated
            local showHidden = v4.Properties.ShowHidden
            local classes = v9.Classes
            local classLists = {}
            local lower = string.lower
            local propertyOrders = v10.PropertyOrders
            local getAttributes = game.GetAttributes
            local maxAttributes = v4.Properties.MaxAttributes
            local showAttributes = v4.Properties.ShowAttributes
            local map2 = {}
            local count2 = 0
            local typeof = typeof
            local typeNameConvert = object.TypeNameConvert
            table.clear(list)
            for i = 1, #list2 do
                local entry = list2[i]
                local obj = entry.Obj
                local class = entry.Class
                if not class then
                    class = obj.ClassName
                    entry.Class = class
                end
                local superclass = classes[class]
                while superclass do
                    local name = superclass.Name
                    if not set[name] then
                        local indexableProps = map[name]
                        if not indexableProps then
                            indexableProps = object.GetIndexableProps(obj, superclass)
                            map[name] = indexableProps
                        end
                        for j = 1, #indexableProps do
                            local indexableProp = indexableProps[j]
                            local tags = indexableProp.Tags
                            if tags.Deprecated and not showDeprecated then
                                continue
                            end
                            if tags.Hidden and not showHidden then
                                continue
                            end
                            list[count] = indexableProp
                            count = count + 1
                        end
                        set[name] = true
                    end
                    local list3 = classLists[name]
                    if not list3 then
                        list3 = {}
                        classLists[name] = list3
                    end
                    list3[#list3 + 1] = obj
                    superclass = superclass.Superclass
                end
                if showAttributes and count2 < maxAttributes then
                    local attributes = getAttributes(obj)
                    for k, attribute in pairs(attributes) do
                        local kind = typeof(attribute)
                        if not map2[k] then
                            local category = kind == 'Instance' and 'Class' or kind == 'EnumItem' and 'Enum' or 'Other'
                            local valueType = {Name = typeNameConvert[kind] or kind, Category = category}
                            local data = {IsAttribute = true, Name = 'ATTR_' .. k, AttributeName = k, DisplayName = k, Class = 'Instance', ValueType = valueType, Category = 'Attributes', Tags = {}}
                            list[count] = data
                            count = count + 1
                            count2 += 1
                            map2[k] = {kind, data}
                            if count2 == maxAttributes then
                                break
                            end
                        elseif map2[k][1] ~= kind then
                            map2[k][2].MultiType = true
                            map2[k][2].Tags.ReadOnly = true
                            map2[k][2].ValueType = {Name = 'string'}
                        end
                    end
                end
            end
            table.sort(list, function(a, b)
                if a.Category ~= b.Category then
                    return (v7[a.Category] or 9999) < (v7[b.Category] or 9999)
                end
                local v1 = propertyOrders[a.Class] and propertyOrders[a.Class][a.Name] or 9999999
                local v2 = propertyOrders[b.Class] and propertyOrders[b.Class][b.Name] or 9999999
                if v1 ~= v2 then
                    return v1 < v2
                end
                return lower(a.Name) < lower(b.Name)
            end)
            object.ClassLists = classLists
            object.ComputeConflicts()
            if #list > 0 then
                list[#list + 1] = object.AddAttributeProp
            end
            object.Update()
            object.Refresh()
        end
        function object.UpdateView()
            local ceiled = math.ceil(parent.AbsoluteSize.Y / 23)
            local x = parent.AbsoluteSize.X
            local totalSpace = object.ViewWidth + object.MinInputWidth
            v3.VisibleSpace = ceiled
            v3.TotalSpace = #tbl + 1
            v6.VisibleSpace = x
            v6.TotalSpace = totalSpace
            v3.Gui.Visible = ceiled < #tbl + 1
            v6.Gui.Visible = v4.Properties.ScaleType == 0 and x < totalSpace
            local size = parent.Size
            parent.Size = UDim2.new(1, v3.Gui.Visible and -16 or 0, 1, v6.Gui.Visible and -39 or -23)
            if size ~= parent.Size then
                object.UpdateView()
                return
            end
            v3:Update()
            v6:Update()
            if v3.Gui.Visible and v6.Gui.Visible then
                v3.Gui.Size = UDim2.new(0, 16, 1, -39)
                v6.Gui.Size = UDim2.new(1, -16, 0, 16)
                object.Window.GuiElems.Content.ScrollCorner.Visible = true
            else
                v3.Gui.Size = UDim2.new(0, 16, 1, -23)
                v6.Gui.Size = UDim2.new(1, 0, 0, 16)
                object.Window.GuiElems.Content.ScrollCorner.Visible = false
            end
            object.Index = v3.Index
        end
        function object.MakeSubProp(map, arg2, valueType, displayName)
            local player = {}
            for k, v in pairs(map) do
                player[k] = v
            end
            player.RootType = player.RootType or player.ValueType
            player.ValueType = valueType
            player.SubName = player.SubName and player.SubName .. arg2 or arg2
            player.DisplayName = displayName
            return player
        end
        function object.GetExpandedProps(instance)
            local list = {}
            local valueType = instance.ValueType
            local name = valueType.Name
            local makeSubProp = object.MakeSubProp
            if name == 'Vector2' then
                list[1] = makeSubProp(instance, '.X', {Name = 'float'})
                list[2] = makeSubProp(instance, '.Y', {Name = 'float'})
            elseif name == 'Vector3' then
                list[1] = makeSubProp(instance, '.X', {Name = 'float'})
                list[2] = makeSubProp(instance, '.Y', {Name = 'float'})
                list[3] = makeSubProp(instance, '.Z', {Name = 'float'})
            elseif name == 'CFrame' then
                list[1] = makeSubProp(instance, '.Position', {Name = 'Vector3'})
                list[2] = makeSubProp(instance, '.RightVector', {Name = 'Vector3'})
                list[3] = makeSubProp(instance, '.UpVector', {Name = 'Vector3'})
                list[4] = makeSubProp(instance, '.LookVector', {Name = 'Vector3'})
            elseif name == 'UDim' then
                list[1] = makeSubProp(instance, '.Scale', {Name = 'float'})
                list[2] = makeSubProp(instance, '.Offset', {Name = 'int'})
            elseif name == 'UDim2' then
                list[1] = makeSubProp(instance, '.X', {Name = 'UDim'})
                list[2] = makeSubProp(instance, '.Y', {Name = 'UDim'})
            elseif name == 'Rect' then
                list[1] = makeSubProp(instance, '.Min.X', {Name = 'float'}, 'X0')
                list[2] = makeSubProp(instance, '.Min.Y', {Name = 'float'}, 'Y0')
                list[3] = makeSubProp(instance, '.Max.X', {Name = 'float'}, 'X1')
                list[4] = makeSubProp(instance, '.Max.Y', {Name = 'float'}, 'Y1')
            elseif name == 'PhysicalProperties' then
                list[1] = makeSubProp(instance, '.Density', {Name = 'float'})
                list[2] = makeSubProp(instance, '.Elasticity', {Name = 'float'})
                list[3] = makeSubProp(instance, '.ElasticityWeight', {Name = 'float'})
                list[4] = makeSubProp(instance, '.Friction', {Name = 'float'})
                list[5] = makeSubProp(instance, '.FrictionWeight', {Name = 'float'})
            elseif name == 'Ray' then
                list[1] = makeSubProp(instance, '.Origin', {Name = 'Vector3'})
                list[2] = makeSubProp(instance, '.Direction', {Name = 'Vector3'})
            elseif name == 'NumberRange' then
                list[1] = makeSubProp(instance, '.Min', {Name = 'float'})
                list[2] = makeSubProp(instance, '.Max', {Name = 'float'})
            elseif name == 'Faces' then
                list[1] = makeSubProp(instance, '.Back', {Name = 'bool'})
                list[2] = makeSubProp(instance, '.Bottom', {Name = 'bool'})
                list[3] = makeSubProp(instance, '.Front', {Name = 'bool'})
                list[4] = makeSubProp(instance, '.Left', {Name = 'bool'})
                list[5] = makeSubProp(instance, '.Right', {Name = 'bool'})
                list[6] = makeSubProp(instance, '.Top', {Name = 'bool'})
            elseif name == 'Axes' then
                list[1] = makeSubProp(instance, '.X', {Name = 'bool'})
                list[2] = makeSubProp(instance, '.Y', {Name = 'bool'})
                list[3] = makeSubProp(instance, '.Z', {Name = 'bool'})
            end
            if instance.Name == 'SoundId' and instance.Class == 'Sound' then
                list[1] = object.SoundPreviewProp
            end
            return list
        end
        function object.Update()
            table.clear(tbl)
            local nameWidthCache = object.NameWidthCache
            local v1
            local num = 1
            local num2 = 0
            local num3 = 1
            local textService = v12.TextService
            local getTextSize = textService.GetTextSize
            local sourceSans = Enum.Font.SourceSans
            local vector2 = Vector2.new(math.huge, 20)
            local split = string.split
            local entryIndent = object.EntryIndent
            local v2 = v4.Properties.ScaleType == 0
            local find = string.find
            local lower = string.lower
            local result = #object.SearchText > 0 and lower(object.SearchText)
            local function recur(list, depth)
                local subName2
                for i = 1, #list do
                    local entry = list[i]
                    local name = entry.Name
                    local subName = entry.SubName
                    local category = entry.Category
                    local v3
                    v3 = not result and true or depth ~= 1 and true or (if not find(lower(name), result, 1, true) then v3 else true)
                    if v3 and v1 ~= category then
                        tbl[num] = {CategoryName = category}
                        num = num + 1
                        v1 = category
                    end
                    local set2 = set
                    subName2 = category
                    local text = 'CAT_' .. subName2
                    if set2[text] and v3 or entry.SpecialRow then
                        if depth > 1 then
                            entry.Depth = depth
                            if num3 < depth then
                                num3 = depth
                            end
                        end
                        if v2 then
                            local list2 = subName and split(subName, '.')
                            local displayName = entry.DisplayName or list2 and list2[#list2] or name
                            local x = nameWidthCache[displayName]
                            if not x then
                                x = getTextSize(textService, displayName, 14, sourceSans, vector2).X
                                nameWidthCache[displayName] = x
                            end
                            local v4 = x + entryIndent * depth
                            if num2 < v4 then
                                num2 = v4
                            end
                        end
                        tbl[num] = entry
                        num = num + 1
                        local class = entry.Class
                        local name2 = entry.Name
                        subName2 = entry.SubName or ''
                        local v5 = class .. '.' .. name2 .. subName2
                        if not set[v5] then
                            continue
                        end
                        local v6 = depth + 1
                        local expandedProps = object.GetExpandedProps(entry)
                        local count = #expandedProps
                        subName2 = 0
                        if subName2 >= count then
                            continue
                        end
                        local callback = recur
                        subName2 = expandedProps
                        callback(subName2, v6)
                    end
                end
            end
            recur(list, 1)
            v8 = nil
            object.ViewWidth = num2 + 9 + object.EntryOffset
            object.UpdateView()
        end
        function object.NewPropEntry(fullNameFrameIndex)
            local clone = object.EntryTemplate:Clone()
            local nameFrame = clone.NameFrame
            local valueFrame = clone.ValueFrame
            local checkbox = v2.Checkbox.new(1)
            checkbox.Gui.Position = UDim2.new(0, 3, 0, 3)
            checkbox.Gui.Parent = valueFrame
            checkbox.OnInput:Connect(function()
                local v1 = tbl[fullNameFrameIndex + object.Index]
                if not v1 then
                    return
                end
                if v1.ValueType.Name == 'PhysicalProperties' then
                    object.SetProp(v1, checkbox.Toggled and true or nil)
                    return
                end
                object.SetProp(v1, checkbox.Toggled)
            end)
            list3[fullNameFrameIndex] = checkbox
            local label = v1.MiscIcons:GetLabel()
            label.Position = UDim2.new(0, 2, 0, 3)
            label.Parent = clone.ValueFrame.RightButton
            clone.Position = UDim2.new(0, 0, 0, 23 * (fullNameFrameIndex - 1))
            nameFrame.Expand.InputBegan:Connect(function(input)
                local v2 = tbl[fullNameFrameIndex + object.Index]
                if not v2 or input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end
                local v3 = v2.CategoryName and 'CAT_' .. v2.CategoryName or v2.Class .. '.' .. v2.Name .. (v2.SubName or '')
                v1.MiscIcons:DisplayByKey(clone.NameFrame.Expand.Icon, set[v3] and 'Collapse_Over' or 'Expand_Over')
            end)
            nameFrame.Expand.InputEnded:Connect(function(input)
                local v2 = tbl[fullNameFrameIndex + object.Index]
                if not v2 or input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end
                local v3 = v2.CategoryName and 'CAT_' .. v2.CategoryName or v2.Class .. '.' .. v2.Name .. (v2.SubName or '')
                v1.MiscIcons:DisplayByKey(clone.NameFrame.Expand.Icon, set[v3] and 'Collapse' or 'Expand')
            end)
            nameFrame.Expand.MouseButton1Down:Connect(function()
                local v1 = tbl[fullNameFrameIndex + object.Index]
                if not v1 then
                    return
                end
                local v2 = v1.CategoryName and 'CAT_' .. v1.CategoryName or v1.Class .. '.' .. v1.Name .. (v1.SubName or '')
                if not v1.CategoryName and not object.ExpandableTypes[v1.ValueType and v1.ValueType.Name] and not object.ExpandableProps[v2] then
                    return
                end
                set[v2] = not set[v2]
                object.Update()
                object.Refresh()
            end)
            nameFrame.PropName.InputBegan:Connect(function(input)
                local player = tbl[fullNameFrameIndex + object.Index]
                if not player then
                    return
                end
                if input.UserInputType == Enum.UserInputType.MouseMovement and not nameFrame.PropName.TextFits then
                    local fullNameFrame = object.FullNameFrame
                    local list = string.split(player.Class .. '.' .. player.Name .. (player.SubName or ''), '.')
                    local text = player.DisplayName or list[#list]
                    local x = v12.TextService:GetTextSize(text, 14, Enum.Font.SourceSans, Vector2.new(math.huge, 20)).X
                    fullNameFrame.TextLabel.Text = text
                    fullNameFrame.Size = UDim2.new(0, x + 4, 0, 22)
                    fullNameFrame.Visible = true
                    object.FullNameFrameIndex = fullNameFrameIndex
                    object.FullNameFrameAttach.SetData(fullNameFrame, {Target = nameFrame})
                    object.FullNameFrameAttach.Enable()
                end
            end)
            nameFrame.PropName.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement and object.FullNameFrameIndex == fullNameFrameIndex then
                    object.FullNameFrame.Visible = false
                    object.FullNameFrameAttach.Disable()
                end
            end)
            valueFrame.ValueBox.MouseButton1Down:Connect(function()
                local v1 = tbl[fullNameFrameIndex + object.Index]
                if not v1 then
                    return
                end
                object.SetInputProp(v1, fullNameFrameIndex)
            end)
            valueFrame.ColorButton.MouseButton1Down:Connect(function()
                local v1 = tbl[fullNameFrameIndex + object.Index]
                if not v1 then
                    return
                end
                object.SetInputProp(v1, fullNameFrameIndex, 'color')
            end)
            valueFrame.RightButton.MouseButton1Click:Connect(function()
                local v1 = tbl[fullNameFrameIndex + object.Index]
                if not v1 then
                    return
                end
                local v2 = v1.Class .. '.' .. v1.Name .. (v1.SubName or '')
                local v3 = v8 and v8.Class .. '.' .. v8.Name .. (v8.SubName or '')
                if v2 == v3 and v8.ValueType.Category == 'Class' then
                    v8 = nil
                    object.SetProp(v1, nil)
                    return
                end
                object.SetInputProp(v1, fullNameFrameIndex, 'right')
            end)
            nameFrame.ToggleAttributes.MouseButton1Click:Connect(function()
                v4.Properties.ShowAttributes = not v4.Properties.ShowAttributes
                object.ShowExplorerProps()
            end)
            clone.RowButton.MouseButton1Click:Connect(function()
                object.DisplayAddAttributeWindow()
            end)
            clone.EditAttributeButton.MouseButton1Down:Connect(function()
                local v1 = tbl[fullNameFrameIndex + object.Index]
                if not v1 then
                    return
                end
                object.DisplayAttributeContext(v1)
            end)
            valueFrame.SoundPreview.ControlButton.MouseButton1Click:Connect(function()
                if object.PreviewSound and object.PreviewSound.Playing then
                    object.SetSoundPreview(false)
                    return
                end
                local firstObjWhichIsA = object.FindFirstObjWhichIsA('Sound')
                if firstObjWhichIsA then
                    object.SetSoundPreview(firstObjWhichIsA)
                end
            end)
            valueFrame.SoundPreview.InputBegan:Connect(function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return
                end
                local connection
                local connection2
                connection = v12.UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        return
                    end
                    connection:Disconnect()
                    connection2:Disconnect()
                end)
                local timeLine = clone.ValueFrame.SoundPreview.TimeLine
                local firstObjWhichIsA = object.FindFirstObjWhichIsA('Sound')
                if firstObjWhichIsA then
                    object.SetSoundPreview(firstObjWhichIsA, true)
                end
                local function update(arg1)
                    local previewSound = object.PreviewSound
                    if not previewSound or previewSound.TimeLength == 0 then
                        return
                    end
                    local x = arg1.Position.X
                    local absoluteSize = timeLine.AbsoluteSize
                    local v1 = x - timeLine.AbsolutePosition.X
                    if absoluteSize.X <= 1 then
                        return
                    end
                    local v2 = if v1 >= 0 then if absoluteSize.X > v1 then v1 else absoluteSize.X - 1 else 0
                    local xScale = v2 / (absoluteSize.X - 1)
                    previewSound.TimePosition = xScale * previewSound.TimeLength
                    timeLine.Slider.Position = UDim2.new(xScale, -4, 0, -8)
                end
                update(input)
                connection2 = v12.UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        update(input)
                    end
                end)
            end)
            clone.Parent = parent
            return {Gui = clone, GuiElems = {NameFrame = nameFrame, ValueFrame = valueFrame, PropName = nameFrame.PropName, ValueBox = valueFrame.ValueBox, Expand = nameFrame.Expand, ColorButton = valueFrame.ColorButton, ColorPreview = valueFrame.ColorButton.ColorPreview, Gradient = valueFrame.ColorButton.ColorPreview.UIGradient, EnumArrow = valueFrame.EnumArrow, Checkbox = valueFrame.Checkbox, RightButton = valueFrame.RightButton, RightButtonIcon = label, RowButton = clone.RowButton, EditAttributeButton = clone.EditAttributeButton, ToggleAttributes = nameFrame.ToggleAttributes, SoundPreview = valueFrame.SoundPreview, SoundPreviewSlider = valueFrame.SoundPreview.TimeLine.Slider}}
        end
        function object.GetSoundPreviewEntry()
            for i = 1, #tbl do
                if tbl[i] ~= object.SoundPreviewProp then
                    continue
                end
                return list2[i - object.Index]
            end
        end
        function object.SetSoundPreview(sound, arg2)
            local sound2 = object.PreviewSound
            if not sound2 then
                sound2 = Instance.new('Sound')
                sound2.Name = 'Preview'
                sound2.Paused:Connect(function()
                    local soundPreviewEntry = object.GetSoundPreviewEntry()
                    if soundPreviewEntry then
                        v1.MiscIcons:DisplayByKey(soundPreviewEntry.GuiElems.SoundPreview.ControlButton.Icon, 'Play')
                    end
                end)
                sound2.Resumed:Connect(function()
                    object.Refresh()
                end)
                sound2.Ended:Connect(function()
                    local soundPreviewEntry = object.GetSoundPreviewEntry()
                    if soundPreviewEntry then
                        soundPreviewEntry.GuiElems.SoundPreviewSlider.Position = UDim2.new(0, -4, 0, -8)
                    end
                    object.Refresh()
                end)
                sound2.Parent = window.Gui
                object.PreviewSound = sound2
            end
            if not sound then
                sound2:Pause()
            else
                local v3 = sound2.SoundId ~= sound.SoundId
                sound2.SoundId = sound.SoundId
                sound2.PlaybackSpeed = sound.PlaybackSpeed
                sound2.Volume = sound.Volume
                if v3 then
                    sound2.TimePosition = 0
                end
                if not arg2 then
                    sound2:Resume()
                end
                coroutine.wrap(function()
                    local now = tick()
                    object.SoundPreviewTime = now
                    while now == object.SoundPreviewTime and sound2.Playing do
                        local soundPreviewEntry = object.GetSoundPreviewEntry()
                        if soundPreviewEntry then
                            local timeLength = sound2.TimeLength
                            local xScale = sound2.TimePosition / (timeLength == 0 and 1 or timeLength)
                            soundPreviewEntry.GuiElems.SoundPreviewSlider.Position = UDim2.new(xScale, -4, 0, -8)
                        end
                        v2.FastWait()
                    end
                end)()
                object.Refresh()
            end
        end
        function object.DisplayAttributeContext(arg1)
            local attributeContext = object.AttributeContext
            if not attributeContext then
                attributeContext = v2.ContextMenu.new()
                attributeContext.Iconless = true
                attributeContext.Width = 80
            end
            attributeContext:Clear()
            attributeContext:Add({Name = 'Edit', OnClick = function()
                object.DisplayAddAttributeWindow(arg1)
            end})
            attributeContext:Add({Name = 'Delete', OnClick = function()
                object.SetProp(arg1, nil, true)
                object.ShowExplorerProps()
            end})
            attributeContext:Show()
        end
        function object.DisplayAddAttributeWindow(editingAttribute)
            local addAttributeWindow = object.AddAttributeWindow
            if not addAttributeWindow then
                addAttributeWindow = v2.Window.new()
                addAttributeWindow.Alignable = false
                addAttributeWindow.Resizable = false
                addAttributeWindow:SetTitle('Add Attribute')
                addAttributeWindow:SetSize(200, 130)
                local button = v2.Button.new()
                local label = v2.Label.new()
                label.Text = 'Name'
                label.Position = UDim2.new(0, 30, 0, 10)
                label.Size = UDim2.new(0, 40, 0, 20)
                addAttributeWindow:Add(label)
                local viewportTextBox = v2.ViewportTextBox.new()
                viewportTextBox.Position = UDim2.new(0, 75, 0, 10)
                viewportTextBox.Size = UDim2.new(0, 120, 0, 20)
                addAttributeWindow:Add(viewportTextBox, 'NameBox')
                viewportTextBox.TextBox:GetPropertyChangedSignal('Text'):Connect(function()
                    button:SetDisabled(#viewportTextBox:GetText() == 0)
                end)
                local label2 = v2.Label.new()
                label2.Text = 'Type'
                label2.Position = UDim2.new(0, 30, 0, 40)
                label2.Size = UDim2.new(0, 40, 0, 20)
                addAttributeWindow:Add(label2)
                local dropDown = v2.DropDown.new()
                dropDown.CanBeEmpty = false
                dropDown.Position = UDim2.new(0, 75, 0, 40)
                dropDown.Size = UDim2.new(0, 120, 0, 20)
                dropDown:SetOptions(object.AllowedAttributeTypes)
                addAttributeWindow:Add(dropDown, 'TypeChooser')
                local label3 = v2.Label.new()
                label3.Text = ''
                label3.Position = UDim2.new(0, 5, 1, -45)
                label3.Size = UDim2.new(1, -10, 0, 20)
                label3.TextColor3 = v4.Theme.Important
                addAttributeWindow.ErrorLabel = label3
                addAttributeWindow:Add(label3, 'Error')
                local button2 = v2.Button.new()
                button2.Text = 'Cancel'
                button2.Position = UDim2.new(1, -97, 1, -25)
                button2.Size = UDim2.new(0, 92, 0, 20)
                button2.OnClick:Connect(function()
                    addAttributeWindow:Close()
                end)
                addAttributeWindow:Add(button2)
                button.Text = 'Save'
                button.Position = UDim2.new(0, 5, 1, -25)
                button.Size = UDim2.new(0, 92, 0, 20)
                button.OnClick:Connect(function()
                    local text = viewportTextBox:GetText()
                    if #text > 100 then
                        label3.Text = 'Error: Name over 100 chars'
                        return
                    end
                    if text:sub(1, 3) == 'RBX' then
                        label3.Text = 'Error: Name begins with \'RBX\''
                        return
                    end
                    local selected = dropDown.Selected
                    local valueType = {Name = object.TypeNameConvert[selected] or selected, Category = 'DataType'}
                    local data = {IsAttribute = true, Name = 'ATTR_' .. text, AttributeName = text, DisplayName = text, Class = 'Instance', ValueType = valueType, Category = 'Attributes', Tags = {}}
                    v4.Properties.ShowAttributes = true
                    object.SetProp(data, object.DefaultPropValue[valueType.Name], true, object.EditingAttribute)
                    object.ShowExplorerProps()
                    addAttributeWindow:Close()
                end)
                addAttributeWindow:Add(button, 'SaveButton')
                object.AddAttributeWindow = addAttributeWindow
            end
            object.EditingAttribute = editingAttribute
            addAttributeWindow:SetTitle(editingAttribute and 'Edit Attribute ' .. editingAttribute.AttributeName or 'Add Attribute')
            addAttributeWindow.Elements.Error.Text = ''
            addAttributeWindow.Elements.NameBox:SetText('')
            addAttributeWindow.Elements.SaveButton:SetDisabled(true)
            addAttributeWindow.Elements.TypeChooser:SetSelected(1)
            addAttributeWindow:Show()
        end
        function object:IsTextEditable()
            local valueType = self.ValueType
            local name = valueType.Name
            return name ~= 'bool' and valueType.Category ~= 'Enum' and valueType.Category ~= 'Class' and name ~= 'BrickColor'
        end
        function object.DisplayEnumDropdown(arg1)
            local enumContext = object.EnumContext
            if not enumContext then
                enumContext = v2.ContextMenu.new()
                enumContext.Iconless = true
                enumContext.MaxHeight = 200
                enumContext.ReverseYOffset = 22
                object.EnumDropdown = enumContext
            end
            if not v8 or v8.ValueType.Category ~= 'Enum' then
                return
            end
            local v1 = v8
            local entry = list2[arg1]
            local valueFrame = entry.GuiElems.ValueFrame
            local v3 = Enum[v1.ValueType.Name]
            if not v3 then
                return
            end
            local list = {}
            for _, item in next, v3:GetEnumItems() do
                list[#list + 1] = item
            end
            table.sort(list, function(a, b)
                return a.Name < b.Name
            end)
            enumContext:Clear()
            local function onClick(arg1)
                if v1 ~= v8 then
                    return
                end
                local entry = v3[arg1]
                v8 = nil
                object.SetProp(v1, entry)
            end
            for i = 1, #list do
                local entry2 = list[i]
                enumContext:Add({Name = entry2.Name, OnClick = onClick})
            end
            enumContext.Width = valueFrame.AbsoluteSize.X
            enumContext:Show(valueFrame.AbsolutePosition.X, valueFrame.AbsolutePosition.Y + 22)
        end
        function object.DisplayBrickColorEditor(currentProp, arg2, savedColor)
            local brickColorEditor = object.BrickColorEditor
            if not brickColorEditor then
                brickColorEditor = v2.BrickColorPicker.new()
                brickColorEditor.Gui.DisplayOrder = v1.DisplayOrders.Menu
                brickColorEditor.ReverseYOffset = 22
                brickColorEditor.OnSelect:Connect(function(arg1)
                    if not brickColorEditor.CurrentProp or brickColorEditor.CurrentProp.ValueType.Name ~= 'BrickColor' then
                        return
                    end
                    if brickColorEditor.CurrentProp == v8 then
                        v8 = nil
                    end
                    object.SetProp(brickColorEditor.CurrentProp, BrickColor.new(arg1))
                end)
                brickColorEditor.OnMoreColors:Connect(function()
                    brickColorEditor:Close()
                    local v1
                    for _, property in pairs(v9.Classes.BasePart.Properties) do
                        if property.Name ~= 'Color' then
                            continue
                        end
                        v1 = property
                        break
                    end
                    object.DisplayColorEditor(v1, brickColorEditor.SavedColor.Color)
                end)
                object.BrickColorEditor = brickColorEditor
            end
            local entry = list2[arg2]
            local valueFrame = entry.GuiElems.ValueFrame
            brickColorEditor.CurrentProp = currentProp
            brickColorEditor.SavedColor = savedColor
            if currentProp and currentProp.Class == 'BasePart' and currentProp.Name == 'BrickColor' then
                brickColorEditor:SetMoreColorsVisible(true)
            else
                brickColorEditor:SetMoreColorsVisible(false)
            end
            brickColorEditor:Show(valueFrame.AbsolutePosition.X, valueFrame.AbsolutePosition.Y + 22)
        end
        function object.DisplayColorEditor(currentProp, arg2)
            local colorEditor = object.ColorEditor
            if not colorEditor then
                colorEditor = v2.ColorPicker.new()
                colorEditor.OnSelect:Connect(function(arg1)
                    if not colorEditor.CurrentProp then
                        return
                    end
                    local name = colorEditor.CurrentProp.ValueType.Name
                    if name ~= 'Color3' and name ~= 'BrickColor' then
                        return
                    end
                    local v1 = name == 'Color3' and arg1 or BrickColor.new(arg1)
                    if colorEditor.CurrentProp == v8 then
                        v8 = nil
                    end
                    object.SetProp(colorEditor.CurrentProp, v1)
                end)
                object.ColorEditor = colorEditor
            end
            colorEditor.CurrentProp = currentProp
            if arg2 then
                colorEditor:SetColor(arg2)
            else
                local firstPropVal = object.GetFirstPropVal(currentProp)
                if firstPropVal then
                    colorEditor:SetColor(firstPropVal)
                end
            end
            colorEditor:Show()
        end
        function object.DisplayNumberSequenceEditor(currentProp, arg2)
            local numberSequenceEditor = object.NumberSequenceEditor
            if not numberSequenceEditor then
                numberSequenceEditor = v2.NumberSequenceEditor.new()
                numberSequenceEditor.OnSelect:Connect(function(arg1)
                    if not numberSequenceEditor.CurrentProp or numberSequenceEditor.CurrentProp.ValueType.Name ~= 'NumberSequence' then
                        return
                    end
                    if numberSequenceEditor.CurrentProp == v8 then
                        v8 = nil
                    end
                    object.SetProp(numberSequenceEditor.CurrentProp, arg1)
                end)
                object.NumberSequenceEditor = numberSequenceEditor
            end
            numberSequenceEditor.CurrentProp = currentProp
            if arg2 then
                numberSequenceEditor:SetSequence(arg2)
            else
                local firstPropVal = object.GetFirstPropVal(currentProp)
                if firstPropVal then
                    numberSequenceEditor:SetSequence(firstPropVal)
                end
            end
            numberSequenceEditor:Show()
        end
        function object.DisplayColorSequenceEditor(currentProp, arg2)
            local colorSequenceEditor = object.ColorSequenceEditor
            if not colorSequenceEditor then
                colorSequenceEditor = v2.ColorSequenceEditor.new()
                colorSequenceEditor.OnSelect:Connect(function(arg1)
                    if not colorSequenceEditor.CurrentProp or colorSequenceEditor.CurrentProp.ValueType.Name ~= 'ColorSequence' then
                        return
                    end
                    if colorSequenceEditor.CurrentProp == v8 then
                        v8 = nil
                    end
                    object.SetProp(colorSequenceEditor.CurrentProp, arg1)
                end)
                object.ColorSequenceEditor = colorSequenceEditor
            end
            colorSequenceEditor.CurrentProp = currentProp
            if arg2 then
                colorSequenceEditor:SetSequence(arg2)
            else
                local firstPropVal = object.GetFirstPropVal(currentProp)
                if firstPropVal then
                    colorSequenceEditor:SetSequence(firstPropVal)
                end
            end
            colorSequenceEditor:Show()
        end
        function object:GetFirstPropVal()
            local firstObjWhichIsA = object.FindFirstObjWhichIsA(self.Class)
            if firstObjWhichIsA then
                return object.GetPropVal(self, firstObjWhichIsA)
            end
        end
        function object.GetPropVal(text, arg2)
            if text.MultiType then
                return '<Multiple Types>'
            end
            if not arg2 then
                return
            end
            local attribute
            if text.IsAttribute then
                attribute = getAttribute(arg2, text.AttributeName)
                if attribute == nil then
                    return nil
                end
                local kind = typeof(attribute)
                local v1 = object.TypeNameConvert[kind] or kind
                if text.RootType then
                    if text.RootType.Name ~= v1 then
                        return nil
                    end
                else
                    if text.ValueType.Name ~= v1 then
                        return nil
                    end
                end
            else
                attribute = arg2[text.Name]
            end
            if text.SubName then
                local list = string.split(text.SubName, '.')
                for i = 1, #list do
                    local list2 = list[i]
                    if #list2 > 0 and attribute then
                        attribute = attribute[list2]
                    end
                end
            end
            return attribute
        end
        function object.SelectObject(arg1)
            if v8 and v8.ValueType.Category == 'Class' then
                local v1 = v8
                v8 = nil
                if isA(arg1, v1.ValueType.Name) then
                    object.SetProp(v1, arg1)
                else
                    object.Refresh()
                end
                return true
            end
            return false
        end
        function object.DisplayProp(text, arg2)
            local name, valueType = text.Name, text.ValueType
            local name2 = valueType.Name
            local tags = text.Tags
            local v3 = text.Class .. '.' .. text.Name .. (text.SubName or '')
            local entry = tbl2[v3]
            local entry2 = list2[arg2]
            local UDim2 = UDim2
            local guiElems = entry2.GuiElems
            local valueFrame, valueBox = guiElems.ValueFrame, guiElems.ValueBox
            local colorButton = guiElems.ColorButton
            local colorPreview = guiElems.ColorPreview
            local gradient = guiElems.Gradient
            local enumArrow = guiElems.EnumArrow
            local checkbox = guiElems.Checkbox
            local rightButton = guiElems.RightButton
            local soundPreview = guiElems.SoundPreview
            local propVal = object.GetPropVal(text, entry)
            local v5 = v8 and v8.Class .. '.' .. v8.Name .. (v8.SubName or '')
            local xOffset = 4
            local num = 6
            if name2 == 'Color3' or name2 == 'BrickColor' or name2 == 'ColorSequence' then
                colorButton.Visible = true
                enumArrow.Visible = false
                if propVal then
                    gradient.Color = name2 == 'Color3' and ColorSequence.new(propVal) or name2 == 'BrickColor' and ColorSequence.new(propVal.Color) or propVal
                else
                    gradient.Color = ColorSequence.new(Color3.new(1, 1, 1))
                end
                colorPreview.BorderColor3 = name2 == 'ColorSequence' and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
                xOffset = 22
                num = 24 + (name2 == 'ColorSequence' and 20 or 0)
            elseif valueType.Category == 'Enum' then
                colorButton.Visible = false
                enumArrow.Visible = not text.Tags.ReadOnly
                num = 22
            elseif v3 == v5 and valueType.Category == 'Class' or name2 == 'NumberSequence' then
                colorButton.Visible = false
                enumArrow.Visible = false
                num = 26
            else
                colorButton.Visible = false
                enumArrow.Visible = false
            end
            valueBox.Position = UDim2.new(0, xOffset, 0, 0)
            valueBox.Size = UDim2.new(1, -num, 1, 0)
            if v5 == v3 and valueType.Category == 'Class' then
                v1.MiscIcons:DisplayByKey(guiElems.RightButtonIcon, 'Delete')
                guiElems.RightButtonIcon.Visible = true
                rightButton.Text = ''
                rightButton.Visible = true
            elseif name2 == 'NumberSequence' or name2 == 'ColorSequence' then
                guiElems.RightButtonIcon.Visible = false
                rightButton.Text = '...'
                rightButton.Visible = true
            else
                rightButton.Visible = false
            end
            if name2 == 'bool' or name2 == 'PhysicalProperties' then
                valueBox.Visible = false
                checkbox.Visible = true
                soundPreview.Visible = false
                list3[arg2].Disabled = tags.ReadOnly
                if name2 == 'PhysicalProperties' and tbl2[v3] then
                    list3[arg2]:SetState(propVal and true or false)
                    return
                end
                list3[arg2]:SetState(propVal)
                return
            elseif name2 == 'SoundPlayer' then
                valueBox.Visible = false
                checkbox.Visible = false
                soundPreview.Visible = true
                v1.MiscIcons:DisplayByKey(soundPreview.ControlButton.Icon, object.PreviewSound and object.PreviewSound.Playing and 'Pause' or 'Play')
                return
            else
                valueBox.Visible = true
                checkbox.Visible = false
                soundPreview.Visible = false
                if propVal ~= nil then
                    if name2 == 'Color3' then
                        valueBox.Text = '[' .. v2.ColorToBytes(propVal) .. ']'
                    elseif valueType.Category == 'Enum' then
                        valueBox.Text = propVal.Name
                    elseif object.RoundableTypes[name2] and v4.Properties.NumberRounding then
                        local text2 = object.ValueToString(text, propVal)
                        valueBox.Text = text2:gsub('-?%d+%.%d+', function(arg1)
                            return tostring(tonumber(('%.' .. v4.Properties.NumberRounding .. 'f'):format(arg1)))
                        end)
                    else
                        valueBox.Text = object.ValueToString(text, propVal)
                    end
                else
                    valueBox.Text = ''
                end
                valueBox.TextColor3 = tags.ReadOnly and v4.Theme.PlaceholderText or v4.Theme.Text
            end
        end
        function object.Refresh()
            local max = math.max(math.ceil(parent.AbsoluteSize.Y / 23), 0)
            local x = parent.AbsoluteSize.X
            local max2 = math.max(object.MinInputWidth, x - object.ViewWidth)
            local flag = false
            local isA, UDim2 = game.IsA, UDim2
            local split = string.split
            local scaleType = v4.Properties.ScaleType
            for i = 1, #list4 do
                list4[i]:Disconnect()
            end
            table.clear(list4)
            object.FullNameFrame.Visible = false
            object.FullNameFrameAttach.Disable()
            for i = 1, max do
                local propEntry = list2[i]
                if not list2[i] then
                    propEntry = object.NewPropEntry(i)
                    list2[i] = propEntry
                end
                local gui2 = propEntry.Gui
                local guiElems = propEntry.GuiElems
                local nameFrame = guiElems.NameFrame
                local propName = guiElems.PropName
                local valueFrame = guiElems.ValueFrame
                local expand = guiElems.Expand
                local valueBox = guiElems.ValueBox
                local propName2 = guiElems.PropName
                local rightButton, editAttributeButton = guiElems.RightButton, guiElems.EditAttributeButton
                local toggleAttributes = guiElems.ToggleAttributes
                local player = tbl[i + object.Index]
                if player then
                    local v3 = scaleType == 0 and v6.Index or 0
                    gui2.Visible = true
                    gui2.Position = UDim2.new(0, -v3, 0, gui2.Position.Y.Offset)
                    gui2.Size = UDim2.new(scaleType == 0 and 0 or 1, scaleType == 0 and object.ViewWidth + max2 or 0, 0, 22)
                    if player.SpecialRow then
                        if player.SpecialRow == 'AddAttribute' then
                            nameFrame.Visible = false
                            valueFrame.Visible = false
                            guiElems.RowButton.Visible = true
                        end
                    else
                        nameFrame.Visible = true
                        guiElems.RowButton.Visible = false
                        local v5 = object.EntryIndent * (player.Depth or 1)
                        local xOffset = v5 + object.EntryOffset
                        nameFrame.Position = UDim2.new(0, xOffset, 0, 0)
                        propName.Size = UDim2.new(1, -2 - (scaleType == 0 and 0 or 6), 1, 0)
                        local v7 = player.CategoryName and 'CAT_' .. player.CategoryName or player.Class .. '.' .. player.Name .. (player.SubName or '')
                        if player.CategoryName then
                            gui2.BackgroundColor3 = v4.Theme.Main1
                            valueFrame.Visible = false
                            propName2.Text = player.CategoryName
                            propName2.Font = Enum.Font.SourceSansBold
                            expand.Visible = true
                            propName2.TextColor3 = v4.Theme.Text
                            nameFrame.BackgroundTransparency = 1
                            nameFrame.Size = UDim2.new(1, 0, 1, 0)
                            editAttributeButton.Visible = false
                            local showAttributes = v4.Properties.ShowAttributes
                            toggleAttributes.Position = UDim2.new(1, -85 - xOffset, 0, 0)
                            toggleAttributes.Text = showAttributes and '[Setting: ON]' or '[Setting: OFF]'
                            toggleAttributes.TextColor3 = v4.Theme.Text
                            toggleAttributes.Visible = player.CategoryName == 'Attributes'
                        else
                            local name = player.Name
                            local valueType = player.ValueType
                            local name2 = valueType.Name
                            local tags = player.Tags
                            local entry = tbl2[v7]
                            local v9 = player.IsAttribute and 20 or 0
                            editAttributeButton.Visible = player.IsAttribute and not player.RootType
                            toggleAttributes.Visible = false
                            if scaleType == 0 then
                                nameFrame.Size = UDim2.new(0, object.ViewWidth - xOffset - 1, 1, 0)
                                valueFrame.Position = UDim2.new(0, object.ViewWidth, 0, 0)
                                valueFrame.Size = UDim2.new(0, max2 - v9, 1, 0)
                            else
                                nameFrame.Size = UDim2.new(0.5, -xOffset - 1, 1, 0)
                                valueFrame.Position = UDim2.new(0.5, 0, 0, 0)
                                valueFrame.Size = UDim2.new(0.5, -v9, 1, 0)
                            end
                            local list = split(v7, '.')
                            propName2.Text = player.DisplayName or list[#list]
                            propName2.Font = Enum.Font.SourceSans
                            gui2.BackgroundColor3 = v4.Theme.Main2
                            valueFrame.Visible = true
                            expand.Visible = valueType.Category == 'DataType' and object.ExpandableTypes[name2] or object.ExpandableProps[v7]
                            propName2.TextColor3 = tags.ReadOnly and v4.Theme.PlaceholderText or v4.Theme.Text
                            object.DisplayProp(player, i)
                            if entry then
                                if player.IsAttribute then
                                    list4[#list4 + 1] = getAttributeChangedSignal(entry, player.AttributeName):Connect(function()
                                        object.DisplayProp(player, i)
                                    end)
                                else
                                    list4[#list4 + 1] = getPropertyChangedSignal(entry, name):Connect(function()
                                        object.DisplayProp(player, i)
                                    end)
                                end
                            end
                            local visible = valueBox.Visible
                            if v7 == (v8 and v8.Class .. '.' .. v8.Name .. (v8.SubName or '')) then
                                nameFrame.BackgroundColor3 = v4.Theme.ListSelection
                                nameFrame.BackgroundTransparency = 0
                                if valueType.Category == 'Class' or valueType.Category == 'Enum' or name2 == 'BrickColor' then
                                    valueFrame.BackgroundColor3 = v4.Theme.TextBox
                                    valueFrame.BackgroundTransparency = 0
                                    valueBox.Visible = true
                                else
                                    flag = true
                                    local xScale = scaleType == 0 and 0 or 0.5
                                    local total = scaleType == 0 and object.ViewWidth - v6.Index or 0
                                    local num = 0
                                    if name2 == 'Color3' or name2 == 'ColorSequence' then
                                        total += 22
                                    end
                                    if name2 == 'NumberSequence' or name2 == 'ColorSequence' then
                                        num = 20
                                    end
                                    gui.Position = UDim2.new(xScale, total, 0, gui2.Position.Y.Offset)
                                    gui.Size = UDim2.new(1 - xScale, -total - num - v9, 0, 22)
                                    gui.Visible = true
                                    valueBox.Visible = false
                                end
                            else
                                nameFrame.BackgroundColor3 = v4.Theme.Main1
                                nameFrame.BackgroundTransparency = 1
                                valueFrame.BackgroundColor3 = v4.Theme.Main1
                                valueFrame.BackgroundTransparency = 1
                                valueBox.Visible = visible
                            end
                        end
                        if player.CategoryName or object.ExpandableTypes[player.ValueType and player.ValueType.Name] or object.ExpandableProps[v7] then
                            if v2.CheckMouseInGui(expand) then
                                v1.MiscIcons:DisplayByKey(expand.Icon, set[v7] and 'Collapse_Over' or 'Expand_Over')
                            else
                                v1.MiscIcons:DisplayByKey(expand.Icon, set[v7] and 'Collapse' or 'Expand')
                            end
                            expand.Visible = true
                        else
                            expand.Visible = false
                        end
                    end
                    gui2.Visible = true
                else
                    gui2.Visible = false
                end
            end
            if not flag then
                gui.Visible = false
            end
            for i = max + 1, #list2 do
                list2[i].Gui:Destroy()
                list2[i] = nil
                list3[i] = nil
            end
        end
        function object.SetProp(instance, arg2, arg3, arg4)
            local list = v5.Selection.List
            local name = instance.Name
            local subName = instance.SubName
            local class = instance.Class
            local valueType = instance.ValueType
            local name2 = valueType.Name
            local attributeName = instance.AttributeName
            local rootType = instance.RootType
            local name3 = rootType and rootType.Name
            local Vector3 = Vector3
            for i = 1, #list do
                local entry = list[i]
                local obj = entry.Obj
                if not isA(obj, class) then
                    continue
                end
                pcall(function()
                    local vector2 = arg2
                    local v1
                    v1 = if instance.IsAttribute then getAttribute(obj, attributeName) else obj[name]
                    if arg4 then
                        if arg4.ValueType.Name == name2 then
                            vector2 = getAttribute(obj, arg4.AttributeName) or vector2
                        end
                        setAttribute(obj, arg4.AttributeName, nil)
                    end
                    if name3 then
                        if name3 == 'Vector2' then
                            vector2 = Vector2.new(subName == '.X' and vector2 or v1.X, subName == '.Y' and vector2 or v1.Y)
                        elseif name3 == 'Vector3' then
                            vector2 = Vector3.new(subName == '.X' and vector2 or v1.X, subName == '.Y' and vector2 or v1.Y, subName == '.Z' and vector2 or v1.Z)
                        elseif name3 == 'UDim' then
                            vector2 = UDim.new(subName == '.Scale' and vector2 or v1.Scale, subName == '.Offset' and vector2 or v1.Offset)
                        elseif name3 == 'UDim2' then
                            local x = v1.X
                            local y = v1.Y
                            local xScale = subName == '.X' and vector2 or UDim.new(subName == '.X.Scale' and vector2 or x.Scale, subName == '.X.Offset' and vector2 or x.Offset)
                            local xOffset = subName == '.Y' and vector2 or UDim.new(subName == '.Y.Scale' and vector2 or y.Scale, subName == '.Y.Offset' and vector2 or y.Offset)
                            vector2 = UDim2.new(xScale, xOffset)
                        elseif name3 == 'CFrame' then
                            local position = v1.Position
                            local rightVector = v1.RightVector
                            local upVector = v1.UpVector
                            local lookVector = v1.LookVector
                            local v2 = subName == '.Position' and vector2 or Vector3.new(subName == '.Position.X' and vector2 or position.X, subName == '.Position.Y' and vector2 or position.Y, subName == '.Position.Z' and vector2 or position.Z)
                            local v3 = subName == '.RightVector' and vector2 or Vector3.new(subName == '.RightVector.X' and vector2 or rightVector.X, subName == '.RightVector.Y' and vector2 or rightVector.Y, subName == '.RightVector.Z' and vector2 or rightVector.Z)
                            local v4 = subName == '.UpVector' and vector2 or Vector3.new(subName == '.UpVector.X' and vector2 or upVector.X, subName == '.UpVector.Y' and vector2 or upVector.Y, subName == '.UpVector.Z' and vector2 or upVector.Z)
                            local v5 = subName == '.LookVector' and vector2 or Vector3.new(subName == '.LookVector.X' and vector2 or lookVector.X, subName == '.RightVector.Y' and vector2 or lookVector.Y, subName == '.RightVector.Z' and vector2 or lookVector.Z)
                            vector2 = CFrame.fromMatrix(v2, v3, v4, -v5)
                        elseif name3 == 'Rect' then
                            local min = v1.Min
                            local max = v1.Max
                            local vector22 = Vector2.new(subName == '.Min.X' and vector2 or min.X, subName == '.Min.Y' and vector2 or min.Y)
                            local vector23 = Vector2.new(subName == '.Max.X' and vector2 or max.X, subName == '.Max.Y' and vector2 or max.Y)
                            vector2 = Rect.new(vector22, vector23)
                        elseif name3 == 'PhysicalProperties' then
                            local physicalProperties = PhysicalProperties.new(obj.Material)
                            local v6 = subName == '.Density' and vector2 or v1 and v1.Density or physicalProperties.Density
                            local v7 = subName == '.Friction' and vector2 or v1 and v1.Friction or physicalProperties.Friction
                            local v8 = subName == '.Elasticity' and vector2 or v1 and v1.Elasticity or physicalProperties.Elasticity
                            local v9 = subName == '.FrictionWeight' and vector2 or v1 and v1.FrictionWeight or physicalProperties.FrictionWeight
                            local v10 = subName == '.ElasticityWeight' and vector2 or v1 and v1.ElasticityWeight or physicalProperties.ElasticityWeight
                            vector2 = PhysicalProperties.new(v6, v7, v8, v9, v10)
                        elseif name3 == 'Ray' then
                            local origin = v1.Origin
                            local direction = v1.Direction
                            local v11 = subName == '.Origin' and vector2 or Vector3.new(subName == '.Origin.X' and vector2 or origin.X, subName == '.Origin.Y' and vector2 or origin.Y, subName == '.Origin.Z' and vector2 or origin.Z)
                            local v12 = subName == '.Direction' and vector2 or Vector3.new(subName == '.Direction.X' and vector2 or direction.X, subName == '.Direction.Y' and vector2 or direction.Y, subName == '.Direction.Z' and vector2 or direction.Z)
                            vector2 = Ray.new(v11, v12)
                        elseif name3 == 'Faces' then
                            local list = {}
                            local map = {'Back', 'Bottom', 'Front', 'Left', 'Right', 'Top'}
                            for _, v in pairs(map) do
                                local v13
                                v13 = if subName == '.' .. v then vector2 else v1[v]
                                if not v13 then
                                    continue
                                end
                                list[#list + 1] = Enum.NormalId[v]
                            end
                            vector2 = Faces.new(unpack(list))
                        elseif name3 == 'Axes' then
                            local list2 = {}
                            local map2 = {'X', 'Y', 'Z'}
                            for _, v in pairs(map2) do
                                local v14
                                v14 = if subName == '.' .. v then vector2 else v1[v]
                                if not v14 then
                                    continue
                                end
                                list2[#list2 + 1] = Enum.Axis[v]
                            end
                            vector2 = Axes.new(unpack(list2))
                        elseif name3 == 'NumberRange' then
                            vector2 = NumberRange.new(subName == '.Min' and vector2 or v1.Min, subName == '.Max' and vector2 or v1.Max)
                        end
                    end
                    if name2 == 'PhysicalProperties' and vector2 then
                        vector2 = v1 or PhysicalProperties.new(obj.Material)
                    end
                    if instance.IsAttribute then
                        setAttribute(obj, attributeName, vector2)
                        return
                    end
                    obj[name] = vector2
                end)
            end
            if not arg3 then
                object.ComputeConflicts(instance)
            end
        end
        function object.InitInputBox()
            gui = callback({{1, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderSizePixel = 0, Name = 'InputBox', Size = UDim2.new(0, 200, 0, 22), Visible = false, ZIndex = 2}}, {2, 'TextBox', {BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.062745101749897, 0.51764708757401, 1), BorderSizePixel = 0, ClearTextOnFocus = false, Font = 3, Parent = {1}, PlaceholderColor3 = Color3.new(0.69803923368454, 0.69803923368454, 0.69803923368454), Position = UDim2.new(0, 3, 0, 0), Size = UDim2.new(1, -6, 1, 0), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0, ZIndex = 2}}})
            label = gui.TextBox
            gui.BackgroundColor3 = v4.Theme.TextBox
            gui.Parent = object.Window.GuiElems.Content.List
            label.FocusLost:Connect(function()
                if not v8 then
                    return
                end
                local v1 = v8
                v8 = nil
                local result = object.StringToValue(v1, label.Text)
                if result then
                    object.SetProp(v1, result)
                    return
                end
                object.Refresh()
            end)
            label.Focused:Connect(function()
                label.SelectionStart = 1
                label.CursorPosition = #label.Text + 1
            end)
            v2.ViewportTextBox.convert(label)
        end
        function object.SetInputProp(text, arg2, text2)
            local valueType = text.ValueType
            local name = valueType.Name
            local v1 = text.Class .. '.' .. text.Name .. (text.SubName or '')
            local entry = tbl2[v1]
            local propVal = object.GetPropVal(text, entry)
            if text.Tags.ReadOnly then
                return
            end
            v8 = text
            if text2 then
                if text2 == 'color' then
                    if name == 'Color3' then
                        label.Text = propVal and object.ValueToString(text, propVal) or ''
                        object.DisplayColorEditor(text, propVal)
                    elseif name == 'BrickColor' then
                        object.DisplayBrickColorEditor(text, arg2, propVal)
                    else
                        if name == 'ColorSequence' then
                            label.Text = propVal and object.ValueToString(text, propVal) or ''
                            object.DisplayColorSequenceEditor(text, propVal)
                        end
                    end
                else
                    if text2 == 'right' then
                        if name == 'NumberSequence' then
                            label.Text = propVal and object.ValueToString(text, propVal) or ''
                            object.DisplayNumberSequenceEditor(text, propVal)
                        else
                            if name == 'ColorSequence' then
                                label.Text = propVal and object.ValueToString(text, propVal) or ''
                                object.DisplayColorSequenceEditor(text, propVal)
                            end
                        end
                    end
                end
            elseif object.IsTextEditable(text) then
                label.Text = propVal and object.ValueToString(text, propVal) or ''
                label:CaptureFocus()
            elseif valueType.Category == 'Enum' then
                object.DisplayEnumDropdown(arg2)
            elseif name == 'BrickColor' then
                object.DisplayBrickColorEditor(text, arg2, propVal)
            end
            object.Refresh()
        end
        function object.InitSearch()
            local searchBox = object.GuiElems.ToolBar.SearchFrame.SearchBox
            v2.ViewportTextBox.convert(searchBox)
            searchBox:GetPropertyChangedSignal('Text'):Connect(function()
                object.SearchText = searchBox.Text
                object.Update()
                object.Refresh()
            end)
        end
        function object.InitEntryStuff()
            object.EntryTemplate = callback({{1, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderColor3 = Color3.new(0.1294117718935, 0.1294117718935, 0.1294117718935), Font = 3, Name = 'Entry', Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(0, 250, 0, 22), Text = '', TextSize = 14}}, {2, 'Frame', {BackgroundColor3 = Color3.new(0.04313725605607, 0.35294118523598, 0.68627452850342), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.33725491166115, 0.49019610881805, 0.73725491762161), BorderSizePixel = 0, Name = 'NameFrame', Parent = {1}, Position = UDim2.new(0, 20, 0, 0), Size = UDim2.new(1, -40, 1, 0)}}, {3, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'PropName', Parent = {2}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(1, -2, 1, 0), Text = 'Anchored', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextTransparency = 0.10000000149012, TextTruncate = 1, TextXAlignment = 0}}, {4, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ClipsDescendants = true, Font = 3, Name = 'Expand', Parent = {2}, Position = UDim2.new(0, -20, 0, 1), Size = UDim2.new(0, 20, 0, 20), Text = '', TextSize = 14, Visible = false}}, {5, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://5642383285', ImageRectOffset = Vector2.new(144, 16), ImageRectSize = Vector2.new(16, 16), Name = 'Icon', Parent = {4}, Position = UDim2.new(0, 2, 0, 2), ScaleType = 4, Size = UDim2.new(0, 16, 0, 16)}}, {6, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 4, Name = 'ToggleAttributes', Parent = {2}, Position = UDim2.new(1, -85, 0, 0), Size = UDim2.new(0, 85, 0, 22), Text = '[SETTING: OFF]', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextTransparency = 0.10000000149012, Visible = false}}, {7, 'Frame', {BackgroundColor3 = Color3.new(0.04313725605607, 0.35294118523598, 0.68627452850342), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.33725491166115, 0.49019607901573, 0.73725491762161), BorderSizePixel = 0, Name = 'ValueFrame', Parent = {1}, Position = UDim2.new(1, -100, 0, 0), Size = UDim2.new(0, 80, 1, 0)}}, {8, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14117647707462), BorderColor3 = Color3.new(0.33725491166115, 0.49019610881805, 0.73725491762161), BorderSizePixel = 0, Name = 'Line', Parent = {7}, Position = UDim2.new(0, -1, 0, 0), Size = UDim2.new(0, 1, 1, 0)}}, {9, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'ColorButton', Parent = {7}, Size = UDim2.new(0, 20, 0, 22), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, Visible = false}}, {10, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BorderColor3 = Color3.new(0, 0, 0), Name = 'ColorPreview', Parent = {9}, Position = UDim2.new(0, 5, 0, 6), Size = UDim2.new(0, 10, 0, 10)}}, {11, 'UIGradient', {Parent = {10}}}, {12, 'Frame', {BackgroundTransparency = 1, Name = 'EnumArrow', Parent = {7}, Position = UDim2.new(1, -16, 0, 3), Size = UDim2.new(0, 16, 0, 16), Visible = false}}, {13, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {12}, Position = UDim2.new(0, 8, 0, 9), Size = UDim2.new(0, 1, 0, 1)}}, {14, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {12}, Position = UDim2.new(0, 7, 0, 8), Size = UDim2.new(0, 3, 0, 1)}}, {15, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {12}, Position = UDim2.new(0, 6, 0, 7), Size = UDim2.new(0, 5, 0, 1)}}, {16, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'ValueBox', Parent = {7}, Position = UDim2.new(0, 4, 0, 0), Size = UDim2.new(1, -8, 1, 0), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextTransparency = 0.10000000149012, TextTruncate = 1, TextXAlignment = 0}}, {17, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'RightButton', Parent = {7}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 22), Text = '...', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, Visible = false}}, {18, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'SettingsButton', Parent = {7}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 22), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, Visible = false}}, {19, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'SoundPreview', Parent = {7}, Size = UDim2.new(1, 0, 1, 0), Visible = false}}, {20, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'ControlButton', Parent = {19}, Size = UDim2.new(0, 20, 0, 22), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14}}, {21, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://5642383285', ImageRectOffset = Vector2.new(144, 16), ImageRectSize = Vector2.new(16, 16), Name = 'Icon', Parent = {20}, Position = UDim2.new(0, 2, 0, 3), ScaleType = 4, Size = UDim2.new(0, 16, 0, 16)}}, {22, 'Frame', {BackgroundColor3 = Color3.new(0.3137255012989, 0.3137255012989, 0.3137255012989), BorderSizePixel = 0, Name = 'TimeLine', Parent = {19}, Position = UDim2.new(0, 26, 0.5, -1), Size = UDim2.new(1, -34, 0, 2)}}, {23, 'Frame', {BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderColor3 = Color3.new(0.1294117718935, 0.1294117718935, 0.1294117718935), Name = 'Slider', Parent = {22}, Position = UDim2.new(0, -4, 0, -8), Size = UDim2.new(0, 8, 0, 18)}}, {24, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'EditAttributeButton', Parent = {1}, Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 0, 22), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14}}, {25, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://5034718180', ImageTransparency = 0.20000000298023, Name = 'Icon', Parent = {24}, Position = UDim2.new(0, 2, 0, 3), Size = UDim2.new(0, 16, 0, 16)}}, {26, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderSizePixel = 0, Font = 3, Name = 'RowButton', Parent = {1}, Size = UDim2.new(1, 0, 1, 0), Text = 'Add Attribute', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextTransparency = 0.10000000149012, Visible = false}}})
            local frame = v2.Frame.new()
            local label = v2.Label.new()
            label.Parent = frame.Gui
            label.Position = UDim2.new(0, 2, 0, 0)
            label.Size = UDim2.new(1, -4, 1, 0)
            frame.Visible = false
            frame.Parent = window.Gui
            object.FullNameFrame = frame
            object.FullNameFrameAttach = v2.AttachTo(frame)
        end
        function object.Init()
            local result = callback({{1, 'Folder', {Name = 'Items'}}, {2, 'Frame', {BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BorderSizePixel = 0, Name = 'ToolBar', Parent = {1}, Size = UDim2.new(1, 0, 0, 22)}}, {3, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.1176470592618, 0.1176470592618, 0.1176470592618), BorderSizePixel = 0, Name = 'SearchFrame', Parent = {2}, Position = UDim2.new(0, 3, 0, 1), Size = UDim2.new(1, -6, 0, 18)}}, {4, 'TextBox', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ClearTextOnFocus = false, Font = 3, Name = 'SearchBox', Parent = {3}, PlaceholderColor3 = Color3.new(0.39215689897537, 0.39215689897537, 0.39215689897537), PlaceholderText = 'Search properties', Position = UDim2.new(0, 4, 0, 0), Size = UDim2.new(1, -24, 0, 18), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0}}, {5, 'UICorner', {CornerRadius = UDim.new(0, 2), Parent = {3}}}, {6, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Reset', Parent = {3}, Position = UDim2.new(1, -17, 0, 1), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14}}, {7, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://5034718129', ImageColor3 = Color3.new(0.39215686917305, 0.39215686917305, 0.39215686917305), Parent = {6}, Size = UDim2.new(0, 16, 0, 16)}}, {8, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Refresh', Parent = {2}, Position = UDim2.new(1, -20, 0, 1), Size = UDim2.new(0, 18, 0, 18), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, Visible = false}}, {9, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://5642310344', Parent = {8}, Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(0, 12, 0, 12)}}, {10, 'Frame', {BackgroundColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, Name = 'ScrollCorner', Parent = {1}, Position = UDim2.new(1, -16, 1, -16), Size = UDim2.new(0, 16, 0, 16), Visible = false}}, {11, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ClipsDescendants = true, Name = 'List', Parent = {1}, Position = UDim2.new(0, 0, 0, 23), Size = UDim2.new(1, 0, 1, -23)}}})
            v7 = v9.CategoryOrder
            for k, _ in next, v7 do
                if object.CollapsedCategories[k] then
                    continue
                end
                set['CAT_' .. k] = true
            end
            set['Sound.SoundId'] = true
            window = v2.Window.new()
            object.Window = window
            window:SetTitle('Properties')
            toolBar = result.ToolBar
            parent = result.List
            object.GuiElems.ToolBar = toolBar
            object.GuiElems.PropsFrame = parent
            object.InitEntryStuff()
            window.GuiElems.Main:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
                if object.Window:IsContentVisible() then
                    object.UpdateView()
                    object.Refresh()
                end
            end)
            window.OnActivate:Connect(function()
                object.UpdateView()
                object.Update()
                object.Refresh()
            end)
            window.OnRestore:Connect(function()
                object.UpdateView()
                object.Update()
                object.Refresh()
            end)
            v3 = v2.ScrollBar.new()
            v3.WheelIncrement = 3
            v3.Gui.Position = UDim2.new(1, -16, 0, 23)
            v3:SetScrollFrame(parent)
            v3.Scrolled:Connect(function()
                object.Index = v3.Index
                object.Refresh()
            end)
            v6 = v2.ScrollBar.new(true)
            v6.Increment = 5
            v6.WheelIncrement = 20
            v6.Gui.Position = UDim2.new(0, 0, 1, -16)
            v6.Scrolled:Connect(function()
                object.Refresh()
            end)
            window.GuiElems.Line.Position = UDim2.new(0, 0, 0, 22)
            toolBar.Parent = window.GuiElems.Content
            parent.Parent = window.GuiElems.Content
            result.ScrollCorner.Parent = window.GuiElems.Content
            v3.Gui.Parent = window.GuiElems.Content
            v6.Gui.Parent = window.GuiElems.Content
            object.InitInputBox()
            object.InitSearch()
        end
        return object
    end}
end, ScriptViewer = function()
    local v1
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
    local v12
    local v13
    local v14
    local v15
    return {InitDeps = function(self)
        v1 = self.Main
        v2 = self.Lib
        v3 = self.Apps
        v4 = self.Settings
        v9 = self.API
        v10 = self.RMD
        v11 = self.env
        v12 = self.service
        v13 = self.plr
        v14 = self.create
        v15 = self.createSimple
    end, InitAfterMain = function()
        v5 = v3.Explorer
        v6 = v3.Properties
        v7 = v3.ScriptViewer
        v8 = v3.Notebook
    end, Main = function()
        local object = {}
        local window
        local v1
        local v3
        function object.ViewScript(arg1)
            local success, result = pcall(v11.decompile or function()
            end, arg1)
            if not success or not result then
                result = '-- DEX - Source failed to decompile'
                v3 = nil
            else
                v3 = arg1
            end
            v1:SetText(result:gsub('\000', '\\0'))
            window:Show()
        end
        function object.Init()
            window = v2.Window.new()
            window:SetTitle('Script Viewer')
            window:Resize(500, 400)
            object.Window = window
            v1 = v2.CodeFrame.new()
            v1.Frame.Position = UDim2.new(0, 0, 0, 20)
            v1.Frame.Size = UDim2.new(1, 0, 1, -20)
            v1.Frame.Parent = window.GuiElems.Content
            local textButton = Instance.new('TextButton', window.GuiElems.Content)
            textButton.BackgroundTransparency = 1
            textButton.Size = UDim2.new(0.5, 0, 0, 20)
            textButton.Text = 'Copy to Clipboard'
            textButton.TextColor3 = Color3.new(1, 1, 1)
            textButton.MouseButton1Click:Connect(function()
                local text = v1:GetText()
                v11.setclipboard(text)
            end)
            local textButton2 = Instance.new('TextButton', window.GuiElems.Content)
            textButton2.BackgroundTransparency = 1
            textButton2.Position = UDim2.new(0.35, 0, 0, 0)
            textButton2.Size = UDim2.new(0.3, 0, 0, 20)
            textButton2.Text = 'Save to File'
            textButton2.TextColor3 = Color3.new(1, 1, 1)
            textButton2.MouseButton1Click:Connect(function()
                local text = v1:GetText()
                local v2 = 'Place_' .. game.PlaceId .. '_Script_' .. os.time() .. '.txt'
                v11.writefile(v2, text)
                if v11.movefileas then
                    v11.movefileas(v2, '.txt')
                end
            end)
            local textButton3 = Instance.new('TextButton', window.GuiElems.Content)
            textButton3.BackgroundTransparency = 1
            textButton3.Position = UDim2.new(0.7, 0, 0, 0)
            textButton3.Size = UDim2.new(0.3, 0, 0, 20)
            textButton3.Text = 'Dump Functions'
            textButton3.TextColor3 = Color3.new(1, 1, 1)
            textButton3.MouseButton1Click:Connect(function()
                if v3 ~= nil then
                    pcall(function()
                        local callback = getgc or get_gc_objects
                        local callback2 = debug and debug.getupvalues or getupvalues or getupvals
                        local callback3 = debug and debug.getconstants or getconstants or getconsts
                        local getinfo2
                        if debug then
                            getinfo2 = debug.getinfo or debug.info or getinfo
                        end
                        local result = ('\n-- // Function Dumper made by King.Kevin\n-- // Script Path: %s\n\n--[['):format(v3:GetFullName())
                        local result2 = result
                        local object = {}
                        local num, set = 0, {}
                        function object.add_to_dump(arg1, value, count, arg4)
                            result2 ..= ('%s%s%s'):format(string.rep('    ', count), tostring(value), (arg4 or true) and '\n' or '')
                        end
                        function object.get_function_name(arg1, arg2)
                            local name = getinfo(arg2).name
                            return name ~= '' and name or 'Unknown Name'
                        end
                        function object.dump_table(arg1, value, number, value2)
                            local v1 = number < 0 and 0 or number
                            object:add_to_dump(('%s [%s] %s'):format(tostring(value2), tostring(typeof(value)), tostring(value)), v1 - 1)
                            local count = 0
                            for k, v in pairs(value) do
                                count = count + 1
                                if type(v) == 'function' then
                                    object:add_to_dump(('%d [function] = %s'):format(count, object:get_function_name(v)), v1)
                                elseif type(v) == 'table' then
                                    if not set[v] then
                                        set[v] = true
                                        object:add_to_dump(('%d [table]:'):format(count), v1)
                                        object:dump_table(v, v1 + 1, k)
                                    else
                                        object:add_to_dump(('%d [table] (Recursive table detected)'):format(count), v1)
                                    end
                                else
                                    object:add_to_dump(('%d [%s] = %s'):format(count, tostring(typeof(v)), tostring(v)), v1)
                                end
                            end
                        end
                        function object.dump_function(arg1, arg2, number)
                            object:add_to_dump(('\nFunction Dump: %s'):format(object:get_function_name(arg2)), number)
                            object:add_to_dump(('\nFunction Upvalues: %s'):format(object:get_function_name(arg2)), number)
                            for k, v in pairs(callback2(arg2)) do
                                if type(v) == 'function' then
                                    object:add_to_dump(('%d [function] = %s'):format(k, object:get_function_name(v)), number + 1)
                                elseif type(v) == 'table' then
                                    if not set[v] then
                                        set[v] = true
                                        object:add_to_dump(('%d [table]:'):format(k), number + 1)
                                        object:dump_table(v, number + 2, k)
                                    else
                                        object:add_to_dump(('%d [table] (Recursive table detected)'):format(k), number + 1)
                                    end
                                else
                                    object:add_to_dump(('%d [%s] = %s'):format(k, tostring(typeof(v)), tostring(v)), number + 1)
                                end
                            end
                            object:add_to_dump(('\nFunction Constants: %s'):format(object:get_function_name(arg2)), number)
                            for k, v in pairs(callback3(arg2)) do
                                if type(v) == 'function' then
                                    object:add_to_dump(('%d [function] = %s'):format(k, object:get_function_name(v)), number + 1)
                                elseif type(v) == 'table' then
                                    if not set[v] then
                                        set[v] = true
                                        object:add_to_dump(('%d [table]:'):format(k), number + 1)
                                        object:dump_table(v, number + 2, k)
                                    else
                                        object:add_to_dump(('%d [table] (Recursive table detected)'):format(k), number + 1)
                                    end
                                else
                                    object:add_to_dump(('%d [%s] = %s'):format(k, tostring(typeof(v)), tostring(v)), number + 1)
                                end
                            end
                        end
                        for _, v in pairs(callback()) do
                            if typeof(v) == 'function' and getfenv(v).script and getfenv(v).script == v3 then
                                object:dump_function(v, 0)
                                object:add_to_dump('\n' .. ('='):rep(100), 0, false)
                            end
                        end
                        local text = v1:GetText()
                        if result2 ~= result then
                            text ..= result2 .. ']]'
                        end
                        v1:SetText(text)
                    end)
                end
            end)
        end
        return object
    end}
end, Lib = function()
    local v1
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
    local v12
    local v13
    local callback2
    local callback3
    return {InitDeps = function(self)
        v1 = self.Main
        v2 = self.Lib
        v3 = self.Apps
        v4 = self.Settings
        v9 = self.API
        v10 = self.RMD
        v11 = self.env
        v12 = self.service
        v13 = self.plr
        callback2 = self.create
        callback3 = self.createSimple
    end, InitAfterMain = function()
        v5 = v3.Explorer
        v6 = v3.Properties
        v7 = v3.ScriptViewer
        v8 = v3.Notebook
    end, Main = function()
        local object = {}
        local renderStepped = v12.RunService.RenderStepped
        local wait2 = renderStepped.wait
        local textBox = newproxy()
        local onClick = newproxy()
        local function initObj(arg1, class)
            local type = type
            local function copy(map)
                local map2 = {}
                for k, v in pairs(map) do
                    if v == onClick then
                        map2[k] = object.Signal.new()
                    elseif type(v) == 'table' then
                        map2[k] = copy(v)
                    else
                        map2[k] = v
                    end
                end
                return map2
            end
            local object2 = copy(arg1)
            return setmetatable(object2, class)
        end
        local function getGuiMT(arg1, arg2)
            return {__index = function(tbl, key)
                if not arg1[key] then
                    return arg2[key] or tbl.Gui[key]
                end
            end, __newindex = function(tbl, key, value)
                if not arg1[key] then
                    tbl.Gui[key] = value
                    return
                end
                rawset(tbl, key, value)
            end}
        end
        object.FormatLuaString = (function()
            local string = string
            local gsub = string.gsub
            local format = string.format
            local char = string.char
            local data = {['"'] = '\\"', ['\\'] = '\\\\'}
            for i = 0, 31 do
                data[char(i)] = '\\' .. format('%03d', i)
            end
            for i = 127, 255 do
                data[char(i)] = '\\' .. format('%03d', i)
            end
            return function(arg1)
                return gsub(arg1, '["\\\000-\031\127-\255]', data)
            end
        end)()
        function object:CheckMouseInGui()
            if self == nil then
                return false
            end
            local mouse = v1.Mouse
            local absolutePosition = self.AbsolutePosition
            local absoluteSize = self.AbsoluteSize
            return absolutePosition.X <= mouse.X and mouse.X < absolutePosition.X + absoluteSize.X and absolutePosition.Y <= mouse.Y and mouse.Y < absolutePosition.Y + absoluteSize.Y
        end
        function object.IsShiftDown()
            return v12.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or v12.UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
        end
        function object.IsCtrlDown()
            return v12.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or v12.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
        end
        function object.CreateArrow(xOffset, count, text)
            local parent = callback3('Frame', {BackgroundTransparency = 1, Name = 'Arrow', Size = UDim2.new(0, xOffset, 0, xOffset)})
            if text == 'up' then
                for i = 1, count do
                    local _ = callback3('Frame', {BackgroundColor3 = Color3.new(0.8627450980392157, 0.8627450980392157, 0.8627450980392157), BorderSizePixel = 0, Position = UDim2.new(0, math.floor(xOffset / 2) - (i - 1), 0, math.floor(xOffset / 2) + i - math.floor(count / 2) - 1), Size = UDim2.new(0, i + (i - 1), 0, 1), Parent = parent})
                end
                return parent
            end
            if text == 'down' then
                for i = 1, count do
                    local _ = callback3('Frame', {BackgroundColor3 = Color3.new(0.8627450980392157, 0.8627450980392157, 0.8627450980392157), BorderSizePixel = 0, Position = UDim2.new(0, math.floor(xOffset / 2) - (i - 1), 0, math.floor(xOffset / 2) - i + math.floor(count / 2) + 1), Size = UDim2.new(0, i + (i - 1), 0, 1), Parent = parent})
                end
                return parent
            end
            if text == 'left' then
                for i = 1, count do
                    local _ = callback3('Frame', {BackgroundColor3 = Color3.new(0.8627450980392157, 0.8627450980392157, 0.8627450980392157), BorderSizePixel = 0, Position = UDim2.new(0, math.floor(xOffset / 2) + i - math.floor(count / 2) - 1, 0, math.floor(xOffset / 2) - (i - 1)), Size = UDim2.new(0, 1, 0, i + (i - 1)), Parent = parent})
                end
                return parent
            end
            if text == 'right' then
                for i = 1, count do
                    local _ = callback3('Frame', {BackgroundColor3 = Color3.new(0.8627450980392157, 0.8627450980392157, 0.8627450980392157), BorderSizePixel = 0, Position = UDim2.new(0, math.floor(xOffset / 2) - i + math.floor(count / 2) + 1, 0, math.floor(xOffset / 2) - (i - 1)), Size = UDim2.new(0, 1, 0, i + (i - 1)), Parent = parent})
                end
                return parent
            end
            error('r u ok')
        end
        object.ParseXML = (function()
            local function callback()
                local string = string
                local print, pairs = print, pairs
                local function handleText(text)
                    local result = text:match('^%s*()')
                    if #text < result then
                        return ''
                    end
                    return (text:match('.*%S', result))
                end
                local _ = string.byte('>', 1)
                local result = string.byte('/', 1)
                local _ = string.byte('D', 1)
                local result2 = string.byte('E', 1)
                parse = function(text, arg2)
                    text = text:gsub('<!%-%-(.-)%-%->', '')
                    local list = {}
                    local entityTable
                    if arg2 then
                        local result3 = text:find('<[_%w]')
                        if result3 then
                            text:sub(1, result3):gsub('<!ENTITY%s+([_%w]+)%s+(.)(.-)%2', function(name, arg2, value)
                                list[#list + 1] = {name = name, value = value}
                            end)
                            entityTable = createEntityTable(list)
                            text = replaceEntities(text:sub(result3), entityTable)
                        end
                    end
                    local list2 = {}
                    local list3 = {}
                    local function handleText(text)
                        text = text:match('^%s*(.*%S)') or ''
                        if #text ~= 0 then
                            list2[#list2 + 1] = {text = text}
                        end
                    end
                    text:gsub('<([?!/]?)([-:_%w]+)%s*(/?>?)([^<]*)', function(list4, text, text2, text3)
                        if #list4 == 0 then
                            local attrs = {}
                            if #text2 == 0 then
                                local total = 0
                                for match, match2, _, v4, v5 in string.gmatch(text3, '(.-([-_%w]+)%s*=%s*(.)(.-)%3%s*(/?>?))') do
                                    total += #match
                                    attrs[match2] = v4
                                    if #v5 == 0 then
                                        continue
                                    end
                                    text3 = text3:sub(total + 1)
                                    text2 = v5
                                    break
                                end
                            end
                            list2[#list2 + 1] = {tag = text, attrs = attrs, children = {}}
                            if text2:byte(1) ~= result then
                                list3[#list3 + 1] = list2
                                list2 = list2[#list2].children
                            end
                            handleText(text3)
                            return
                        end
                        if list4 == '/' then
                            list2 = list3[#list3]
                            list3[#list3] = nil
                            handleText(text3)
                            return
                        end
                        if list4 == '!' and result2 == text:byte(1) then
                            text3:gsub('([_%w]+)%s+(.)(.-)%2', function(name, arg2, value)
                                list[#list + 1] = {name = name, value = value}
                            end, 1)
                        end
                    end)
                    return {children = list2, entities = list, tentities = entityTable}
                end
                parseText = function(arg1)
                    return parse(arg1)
                end
                defaultEntityTable = function()
                    return {quot = '"', apos = '\'', lt = '<', gt = '>', amp = '&', tab = '\t', nbsp = ' '}
                end
                replaceEntities = function(text, arg2)
                    return text:gsub('&([^;]+);', arg2)
                end
                createEntityTable = function(map, arg2)
                    entities = arg2 or defaultEntityTable()
                    for _, v in pairs(map) do
                        v.value = replaceEntities(v.value, entities)
                        entities[v.name] = v.value
                    end
                    return entities
                end
                return parseText
            end
            local object = setmetatable({}, {__index = getfenv()})
            setfenv(callback, object)
            return callback()
        end)()
        function object.FastWait(arg1)
            if not arg1 then
                return wait2(renderStepped)
            end
            local now = tick()
            while tick() - now < arg1 do
                wait2(renderStepped)
            end
        end
        function object.ButtonAnim(gui, arg2)
            local flag = false
            local flag2 = false
            local v1 = arg2 and arg2.Mode or 1
            local object2 = {}
            if v1 == 2 then
                local lerpTo = arg2.LerpTo or Color3.new(0, 0, 0)
                local lerpDelta = arg2.LerpDelta or 0.2
                object2.StartColor = arg2.StartColor or gui.BackgroundColor3
                object2.PressColor = arg2.PressColor or object2.StartColor:lerp(lerpTo, lerpDelta)
                object2.HoverColor = arg2.HoverColor or object2.StartColor:lerp(object2.PressColor, 0.6)
                object2.OutlineColor = arg2.OutlineColor
            end
            gui.InputBegan:Connect(function(input)
                if flag2 then
                    return
                end
                if input.UserInputType == Enum.UserInputType.MouseMovement and not flag then
                    if v1 == 1 then
                        gui.BackgroundTransparency = 0.4
                        return
                    end
                    if v1 == 2 then
                        gui.BackgroundColor3 = object2.HoverColor
                    end
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    flag = true
                    if v1 == 1 then
                        gui.BackgroundTransparency = 0
                        return
                    end
                    if v1 == 2 then
                        gui.BackgroundColor3 = object2.PressColor
                        if object2.OutlineColor then
                            gui.BorderColor3 = object2.PressColor
                        end
                    end
                end
            end)
            gui.InputEnded:Connect(function(input)
                if flag2 then
                    return
                end
                if input.UserInputType == Enum.UserInputType.MouseMovement and not flag then
                    if v1 == 1 then
                        gui.BackgroundTransparency = 1
                        return
                    end
                    if v1 == 2 then
                        gui.BackgroundColor3 = object2.StartColor
                    end
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    flag = false
                    if v1 == 1 then
                        gui.BackgroundTransparency = object.CheckMouseInGui(gui) and 0.4 or 1
                        return
                    end
                    if v1 == 2 then
                        gui.BackgroundColor3 = object.CheckMouseInGui(gui) and object2.HoverColor or object2.StartColor
                        if object2.OutlineColor then
                            gui.BorderColor3 = object2.OutlineColor
                        end
                    end
                end
            end)
            function object2.Disable()
                flag2 = true
                flag = false
                if v1 == 1 then
                    gui.BackgroundTransparency = 1
                    return
                end
                if v1 == 2 then
                    gui.BackgroundColor3 = object2.StartColor
                end
            end
            function object2.Enable()
                flag2 = false
            end
            return object2
        end
        function object.FindAndRemove(list, value)
            local index = table.find(list, value)
            if index then
                table.remove(list, index)
            end
        end
        function object.AttachTo(arg1, arg2)
            local v1
            local v2
            local v3
            local v4
            local v5
            local v6
            local connection
            local flag = false
            local function update()
                if not arg1 or not v1 then
                    return
                end
                local absolutePosition = v1.AbsolutePosition
                local absoluteSize = v1.AbsoluteSize
                arg1.Position = UDim2.new(0, absolutePosition.X + v2, 0, absolutePosition.Y + v3)
                if v6 then
                    arg1.Size = UDim2.new(0, absoluteSize.X + v4, 0, absoluteSize.Y + v5)
                end
            end
            local function setup(arg1_1, arg2)
                arg1 = arg1_1
                arg2 = arg2 or {}
                v1 = arg2.Target
                v2 = arg2.PosOffX or 0
                v3 = arg2.PosOffY or 0
                v4 = arg2.SizeOffX or 0
                v5 = arg2.SizeOffY or 0
                v6 = arg2.Resize or false
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
                if v1 then
                    connection = v1.Changed:Connect(function(value)
                        if not flag and value == 'AbsolutePosition' or value == 'AbsoluteSize' then
                            update()
                        end
                    end)
                end
                update()
            end
            setup(arg1, arg2)
            return {SetData = function(arg1, arg2)
                setup(arg1, arg2)
            end, Enable = function()
                flag = false
                update()
            end, Disable = function()
                flag = true
            end, Destroy = function()
                connection:Disconnect()
                connection = nil
            end}
        end
        object.ProtectedGuis = {}
        function object.ShowGui(instance)
            if v11.gethui then
                instance.Parent = v11.gethui()
                return
            end
            if v11.protectgui then
                v11.protectgui(instance)
                instance.Parent = v1.GuiHolder
                return
            end
            instance.Parent = v1.GuiHolder
        end
        function object:ColorToBytes()
            local round = math.round
            return string.format('%d, %d, %d', round(self.r * 255), round(self.g * 255), round(self.b * 255))
        end
        function object.ReadFile(arg1)
            if not v11.readfile then
                return
            end
            local success, result = pcall(v11.readfile, arg1)
            if success and result then
                return result
            end
        end
        function object.DeferFunc(callback, ...)
            wait2(renderStepped)
            return callback(...)
        end
        function object.LoadCustomAsset(arg1)
            if not v11.getcustomasset or not v11.isfile or not v11.isfile(arg1) then
                return
            end
            return v11.getcustomasset(arg1)
        end
        function object.FetchCustomAsset(arg1, arg2)
            if not v11.writefile then
                return
            end
            local success, result = pcall(game.HttpGet, game, arg1)
            if not success then
                return
            end
            v11.writefile(arg2, result)
            return object.LoadCustomAsset(arg2)
        end
        object.Signal = (function()
            local object = {}
            local function handler(value)
                local index = table.find(value.Signal.Connections, value)
                if index then
                    table.remove(value.Signal.Connections, index)
                end
            end
            function object.Connect(signal, func)
                if type(func) ~= 'function' then
                    error('Attempt to connect a non-function')
                end
                local data = {Signal = signal, Func = func, Disconnect = handler}
                signal.Connections[#signal.Connections + 1] = data
                return data
            end
            function object.Fire(map, ...)
                for _, connection in next, map.Connections do
                    xpcall(coroutine.wrap(connection.Func), function(text)
                        warn(text .. '\n' .. debug.traceback())
                    end, ...)
                end
            end
            local class = {__index = object, __tostring = function(self)
                return 'Signal: ' .. tostring(#self.Connections) .. ' Connections'
            end}
            return {new = function()
                local object = {Connections = {}}
                return setmetatable(object, class)
            end}
        end)()
        object.Set = (function()
            local __index = {Add = function(self, arg2)
                if self.Map[arg2] then
                    return
                end
                local list = self.List
                list[#list + 1] = arg2
                self.Map[arg2] = true
                self.Changed:Fire()
            end, AddTable = function(self, list)
                local flag
                local list2 = self.List
                local map = self.Map
                for i = 1, #list do
                    local entry = list[i]
                    if map[entry] then
                        continue
                    end
                    list2[#list2 + 1] = entry
                    map[entry] = true
                    flag = true
                end
                if flag then
                    self.Changed:Fire()
                end
            end, Remove = function(self, value)
                if not self.Map[value] then
                    return
                end
                local list = self.List
                local index = table.find(list, value)
                if index then
                    table.remove(list, index)
                end
                self.Map[value] = nil
                self.Changed:Fire()
            end, RemoveTable = function(self, list)
                local flag
                local list2 = self.List
                local map = self.Map
                local set = {}
                for i = 1, #list do
                    local entry = list[i]
                    map[entry] = nil
                    set[entry] = true
                end
                for i = #list2, 1, -1 do
                    local entry2 = list2[i]
                    if not set[entry2] then
                        continue
                    end
                    table.remove(list2, i)
                    flag = true
                end
                if flag then
                    self.Changed:Fire()
                end
            end, Set = function(list, arg2)
                if #list.List == 1 and list.List[1] == arg2 then
                    return
                end
                list.List = {arg2}
                list.Map = {[arg2] = true}
                list.Changed:Fire()
            end, SetTable = function(self, source)
                local list = {}
                local set = {}
                self.List = list
                self.Map = set
                table.move(source, 1, #source, 1, list)
                for i = 1, #source do
                    set[source[i]] = true
                end
                self.Changed:Fire()
            end, Clear = function(list)
                if #list.List == 0 then
                    return
                end
                list.List = {}
                list.Map = {}
                list.Changed:Fire()
            end}
            local class = {__index = __index}
            return {new = function()
                return (setmetatable({List = {}, Map = {}, Changed = object.Signal.new()}, class))
            end}
        end)()
        object.IconMap = (function()
            local __index = {GetLabel = function(self)
                local imageLabel = Instance.new('ImageLabel')
                self:SetupLabel(imageLabel)
                return imageLabel
            end, SetupLabel = function(self, arg2)
                arg2.BackgroundTransparency = 1
                arg2.ImageRectOffset = Vector2.new(0, 0)
                arg2.ImageRectSize = Vector2.new(self.IconSizeX, self.IconSizeY)
                arg2.ScaleType = Enum.ScaleType.Crop
                arg2.Size = UDim2.new(0, self.IconSizeX, 0, self.IconSizeY)
            end, Display = function(number, arg2, number2)
                arg2.Image = number.MapId
                if not number.NumX then
                    arg2.ImageRectOffset = Vector2.new(number.IconSizeX * number2, 0)
                    return
                end
                arg2.ImageRectOffset = Vector2.new(number.IconSizeX * (number2 % number.NumX), number.IconSizeY * math.floor(number2 / number.NumX))
            end, DisplayByKey = function(self, arg2, arg3)
                if self.IndexDict[arg3] then
                    self:Display(arg2, self.IndexDict[arg3])
                end
            end, SetDict = function(self, indexDict)
                self.IndexDict = indexDict
            end}
            local class = {__index = __index}
            return {new = function(mapId, mapSizeX, mapSizeY, iconSizeX, iconSizeY)
                return (setmetatable({MapId = mapId, MapSizeX = mapSizeX, MapSizeY = mapSizeY, IconSizeX = iconSizeX, IconSizeY = iconSizeY, NumX = mapSizeX / iconSizeX, IndexDict = {}}, class))
            end, newLinear = function(mapId, iconSizeX, iconSizeY)
                return (setmetatable({MapId = mapId, IconSizeX = iconSizeX, IconSizeY = iconSizeY, IndexDict = {}}, class))
            end}
        end)()
        object.ScrollBar = (function()
            local object2 = {}
            local userInputService = v12.UserInputService
            local mouse = v13:GetMouse()
            local checkMouseInGui = object.CheckMouseInGui
            local createArrow = object.CreateArrow
            local function drawThumb(arg1)
                local totalSpace = arg1.TotalSpace
                local visibleSpace = arg1.VisibleSpace
                local _ = arg1.Index
                local scrollThumb = arg1.GuiElems.ScrollThumb
                local scrollThumbFrame = arg1.GuiElems.ScrollThumbFrame
                if not arg1:CanScrollUp() and not arg1:CanScrollDown() then
                    scrollThumb.Visible = false
                else
                    scrollThumb.Visible = true
                end
                if arg1.Horizontal then
                    scrollThumb.Size = UDim2.new(visibleSpace / totalSpace, 0, 1, 0)
                    if scrollThumb.AbsoluteSize.X < 16 then
                        scrollThumb.Size = UDim2.new(0, 16, 1, 0)
                    end
                    local x = scrollThumbFrame.AbsoluteSize.X
                    local x2 = scrollThumb.AbsoluteSize.X
                    scrollThumb.Position = UDim2.new(arg1:GetScrollPercent() * (x - x2) / x, 0, 0, 0)
                    return
                else
                    scrollThumb.Size = UDim2.new(1, 0, visibleSpace / totalSpace, 0)
                    if scrollThumb.AbsoluteSize.Y < 16 then
                        scrollThumb.Size = UDim2.new(1, 0, 0, 16)
                    end
                    local y = scrollThumbFrame.AbsoluteSize.Y
                    local y2 = scrollThumb.AbsoluteSize.Y
                    scrollThumb.Position = UDim2.new(0, 0, arg1:GetScrollPercent() * (y - y2) / y, 0)
                end
            end
            local function createFrame(arg1)
                local parent = callback3('Frame', {Style = 0, Active = true, AnchorPoint = Vector2.new(0, 0), BackgroundColor3 = Color3.new(0.35294118523598, 0.35294118523598, 0.35294118523598), BackgroundTransparency = 0, BorderColor3 = Color3.new(0.10588236153126, 0.16470588743687, 0.20784315466881), BorderSizePixel = 0, ClipsDescendants = false, Draggable = false, Position = UDim2.new(1, -16, 0, 0), Rotation = 0, Selectable = false, Size = UDim2.new(0, 16, 1, 0), SizeConstraint = 0, Visible = true, ZIndex = 1, Name = 'ScrollBar'})
                local parent2
                local parent3
                if arg1.Horizontal then
                    parent.Size = UDim2.new(1, 0, 0, 16)
                    parent2 = callback3('ImageButton', {Parent = parent, Name = 'Left', Size = UDim2.new(0, 16, 0, 16), BackgroundTransparency = 1, BorderSizePixel = 0, AutoButtonColor = false})
                    createArrow(16, 4, 'left').Parent = parent2
                    parent3 = callback3('ImageButton', {Parent = parent, Name = 'Right', Position = UDim2.new(1, -16, 0, 0), Size = UDim2.new(0, 16, 0, 16), BackgroundTransparency = 1, BorderSizePixel = 0, AutoButtonColor = false})
                    createArrow(16, 4, 'right').Parent = parent3
                else
                    parent.Size = UDim2.new(0, 16, 1, 0)
                    parent2 = callback3('ImageButton', {Parent = parent, Name = 'Up', Size = UDim2.new(0, 16, 0, 16), BackgroundTransparency = 1, BorderSizePixel = 0, AutoButtonColor = false})
                    createArrow(16, 4, 'up').Parent = parent2
                    parent3 = callback3('ImageButton', {Parent = parent, Name = 'Down', Position = UDim2.new(0, 0, 1, -16), Size = UDim2.new(0, 16, 0, 16), BackgroundTransparency = 1, BorderSizePixel = 0, AutoButtonColor = false})
                    createArrow(16, 4, 'down').Parent = parent3
                end
                local parent4 = callback3('Frame', {BackgroundTransparency = 1, Parent = parent})
                if arg1.Horizontal then
                    parent4.Position = UDim2.new(0, 16, 0, 0)
                    parent4.Size = UDim2.new(1, -32, 1, 0)
                else
                    parent4.Position = UDim2.new(0, 0, 0, 16)
                    parent4.Size = UDim2.new(1, 0, 1, -32)
                end
                local scrollThumb = callback3('Frame', {BackgroundColor3 = Color3.new(0.47058823529411764, 0.47058823529411764, 0.47058823529411764), BorderSizePixel = 0, Parent = parent4})
                local markerFrame = callback3('Frame', {BackgroundTransparency = 1, Name = 'Markers', Size = UDim2.new(1, 0, 1, 0), Parent = parent4})
                local flag = false
                local flag2 = false
                local flag3 = false
                parent2.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and not flag and arg1:CanScrollUp() then
                        parent2.BackgroundTransparency = 0.8
                    end
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not arg1:CanScrollUp() then
                        return
                    end
                    flag = true
                    parent2.BackgroundTransparency = 0.5
                    if arg1:CanScrollUp() then
                        arg1:ScrollUp()
                        arg1.Scrolled:Fire()
                    end
                    local now = tick()
                    local connection
                    connection = userInputService.InputEnded:Connect(function(input)
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                            return
                        end
                        connection:Disconnect()
                        if checkMouseInGui(parent2) and arg1:CanScrollUp() then
                            parent2.BackgroundTransparency = 0.8
                        else
                            parent2.BackgroundTransparency = 1
                        end
                        flag = false
                    end)
                    while flag do
                        if tick() - now >= 0.3 and arg1:CanScrollUp() then
                            arg1:ScrollUp()
                            arg1.Scrolled:Fire()
                        end
                        wait()
                    end
                end)
                parent2.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and not flag then
                        parent2.BackgroundTransparency = 1
                    end
                end)
                parent3.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and not flag and arg1:CanScrollDown() then
                        parent3.BackgroundTransparency = 0.8
                    end
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not arg1:CanScrollDown() then
                        return
                    end
                    flag = true
                    parent3.BackgroundTransparency = 0.5
                    if arg1:CanScrollDown() then
                        arg1:ScrollDown()
                        arg1.Scrolled:Fire()
                    end
                    local now = tick()
                    local connection
                    connection = userInputService.InputEnded:Connect(function(input)
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                            return
                        end
                        connection:Disconnect()
                        if checkMouseInGui(parent3) and arg1:CanScrollDown() then
                            parent3.BackgroundTransparency = 0.8
                        else
                            parent3.BackgroundTransparency = 1
                        end
                        flag = false
                    end)
                    while flag do
                        if tick() - now >= 0.3 and arg1:CanScrollDown() then
                            arg1:ScrollDown()
                            arg1.Scrolled:Fire()
                        end
                        wait()
                    end
                end)
                parent3.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and not flag then
                        parent3.BackgroundTransparency = 1
                    end
                end)
                scrollThumb.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and not flag2 then
                        scrollThumb.BackgroundTransparency = 0.2
                        scrollThumb.BackgroundColor3 = arg1.ThumbSelectColor
                    end
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        return
                    end
                    local v1 = arg1.Horizontal and 'X' or 'Y'
                    local v2
                    flag = false
                    flag3 = false
                    flag2 = true
                    scrollThumb.BackgroundTransparency = 0
                    local v3 = mouse[v1] - scrollThumb.AbsolutePosition[v1]
                    local entry, connection = mouse[v1], nil
                    local connection2
                    connection = userInputService.InputEnded:Connect(function(input)
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                            return
                        end
                        connection:Disconnect()
                        if connection2 then
                            connection2:Disconnect()
                        end
                        if checkMouseInGui(scrollThumb) then
                            scrollThumb.BackgroundTransparency = 0.2
                        else
                            scrollThumb.BackgroundTransparency = 0
                            scrollThumb.BackgroundColor3 = arg1.ThumbColor
                        end
                        flag2 = false
                    end)
                    arg1:Update()
                    connection2 = userInputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement and flag2 and connection.Connected then
                            local v4 = parent4.AbsoluteSize[v1] - scrollThumb.AbsoluteSize[v1]
                            local num = mouse[v1] - parent4.AbsolutePosition[v1] - v3
                            if v4 < num then
                                num = v4
                            elseif num < 0 then
                                num = 0
                            end
                            if v2 ~= num then
                                v2 = num
                                arg1:ScrollTo(math.floor(0.5 + num / v4 * (arg1.TotalSpace - arg1.VisibleSpace)))
                            end
                            wait()
                        end
                    end)
                end)
                scrollThumb.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and not flag2 then
                        scrollThumb.BackgroundTransparency = 0
                        scrollThumb.BackgroundColor3 = arg1.ThumbColor
                    end
                end)
                parent4.InputBegan:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 or checkMouseInGui(scrollThumb) then
                        return
                    end
                    local v1 = arg1.Horizontal and 'X' or 'Y'
                    local num = 0
                    if mouse[v1] >= scrollThumb.AbsolutePosition[v1] + scrollThumb.AbsoluteSize[v1] then
                        num = 1
                    end
                    local function doTick()
                        local v2 = arg1.VisibleSpace - 1
                        if num == 0 and mouse[v1] < scrollThumb.AbsolutePosition[v1] then
                            arg1:ScrollTo(arg1.Index - v2)
                            return
                        end
                        if num == 1 and mouse[v1] >= scrollThumb.AbsolutePosition[v1] + scrollThumb.AbsoluteSize[v1] then
                            arg1:ScrollTo(arg1.Index + v2)
                        end
                    end
                    flag2 = false
                    flag3 = true
                    doTick()
                    local now = tick()
                    local connection
                    connection = userInputService.InputEnded:Connect(function(input)
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                            return
                        end
                        connection:Disconnect()
                        flag3 = false
                    end)
                    while flag3 do
                        if tick() - now >= 0.3 and checkMouseInGui(parent4) then
                            doTick()
                        end
                        wait()
                    end
                end)
                parent.MouseWheelForward:Connect(function()
                    arg1:ScrollTo(arg1.Index - arg1.WheelIncrement)
                end)
                parent.MouseWheelBackward:Connect(function()
                    arg1:ScrollTo(arg1.Index + arg1.WheelIncrement)
                end)
                arg1.GuiElems.ScrollThumb = scrollThumb
                arg1.GuiElems.ScrollThumbFrame = parent4
                arg1.GuiElems.Button1 = parent2
                arg1.GuiElems.Button2 = parent3
                arg1.GuiElems.MarkerFrame = markerFrame
                return parent
            end
            function object2.Update(number, arg2)
                local totalSpace = number.TotalSpace
                local visibleSpace = number.VisibleSpace
                local _ = number.Index
                local button1 = number.GuiElems.Button1
                local button2 = number.GuiElems.Button2
                number.Index = math.clamp(number.Index, 0, math.max(0, totalSpace - visibleSpace))
                if number.LastTotalSpace ~= number.TotalSpace then
                    number.LastTotalSpace = number.TotalSpace
                    number:UpdateMarkers()
                end
                if number:CanScrollUp() then
                    for _, child in pairs(button1.Arrow:GetChildren()) do
                        child.BackgroundTransparency = 0
                    end
                else
                    button1.BackgroundTransparency = 1
                    for _, child in pairs(button1.Arrow:GetChildren()) do
                        child.BackgroundTransparency = 0.5
                    end
                end
                if number:CanScrollDown() then
                    for _, child in pairs(button2.Arrow:GetChildren()) do
                        child.BackgroundTransparency = 0
                    end
                else
                    button2.BackgroundTransparency = 1
                    for _, child in pairs(button2.Arrow:GetChildren()) do
                        child.BackgroundTransparency = 0.5
                    end
                end
                drawThumb(number)
            end
            function object2:UpdateMarkers()
                local markerFrame = self.GuiElems.MarkerFrame
                markerFrame:ClearAllChildren()
                for k, marker in pairs(self.Markers) do
                    if k < self.TotalSpace then
                        callback3('Frame', {BackgroundTransparency = 0, BackgroundColor3 = marker, BorderSizePixel = 0, Position = self.Horizontal and UDim2.new(k / self.TotalSpace, 0, 1, -6) or UDim2.new(1, -6, k / self.TotalSpace, 0), Size = self.Horizontal and UDim2.new(0, 1, 0, 6) or UDim2.new(0, 6, 0, 1), Name = 'Marker' .. tostring(k), Parent = markerFrame})
                    end
                end
            end
            function object2:AddMarker(arg2, arg3)
                self.Markers[arg2] = arg3 or Color3.new(0, 0, 0)
            end
            function object2:ScrollTo(index, arg3)
                self.Index = index
                self:Update()
                if not arg3 then
                    self.Scrolled:Fire()
                end
            end
            function object2:ScrollUp()
                self.Index = self.Index - self.Increment
                self:Update()
            end
            function object2:ScrollDown()
                self.Index = self.Index + self.Increment
                self:Update()
            end
            function object2:CanScrollUp()
                return self.Index > 0
            end
            function object2:CanScrollDown()
                return self.Index + self.VisibleSpace < self.TotalSpace
            end
            function object2:GetScrollPercent()
                return self.Index / (self.TotalSpace - self.VisibleSpace)
            end
            function object2:SetScrollPercent(number)
                self.Index = math.floor(number * (self.TotalSpace - self.VisibleSpace))
                self:Update()
            end
            function object2:Texture(arg2)
                self.ThumbColor = arg2.ThumbColor or Color3.new(0, 0, 0)
                self.ThumbSelectColor = arg2.ThumbSelectColor or Color3.new(0, 0, 0)
                self.GuiElems.ScrollThumb.BackgroundColor3 = arg2.ThumbColor or Color3.new(0, 0, 0)
                self.Gui.BackgroundColor3 = arg2.FrameColor or Color3.new(0, 0, 0)
                self.GuiElems.Button1.BackgroundColor3 = arg2.ButtonColor or Color3.new(0, 0, 0)
                self.GuiElems.Button2.BackgroundColor3 = arg2.ButtonColor or Color3.new(0, 0, 0)
                for _, child in pairs(self.GuiElems.Button1.Arrow:GetChildren()) do
                    child.BackgroundColor3 = arg2.ArrowColor or Color3.new(0, 0, 0)
                end
                for _, child in pairs(self.GuiElems.Button2.Arrow:GetChildren()) do
                    child.BackgroundColor3 = arg2.ArrowColor or Color3.new(0, 0, 0)
                end
            end
            function object2:SetScrollFrame(arg2)
                if self.ScrollUpEvent then
                    self.ScrollUpEvent:Disconnect()
                    self.ScrollUpEvent = nil
                end
                if self.ScrollDownEvent then
                    self.ScrollDownEvent:Disconnect()
                    self.ScrollDownEvent = nil
                end
                self.ScrollUpEvent = arg2.MouseWheelForward:Connect(function()
                    self:ScrollTo(self.Index - self.WheelIncrement)
                end)
                self.ScrollDownEvent = arg2.MouseWheelBackward:Connect(function()
                    self:ScrollTo(self.Index + self.WheelIncrement)
                end)
            end
            local class = {__index = object2}
            return {new = function(horizontal)
                local object2 = setmetatable({Index = 0, VisibleSpace = 0, TotalSpace = 0, Increment = 1, WheelIncrement = 1, Markers = {}, GuiElems = {}, Horizontal = horizontal, LastTotalSpace = 0, Scrolled = object.Signal.new()}, class)
                object2.Gui = createFrame(object2)
                object2:Texture({ThumbColor = Color3.fromRGB(60, 60, 60), ThumbSelectColor = Color3.fromRGB(75, 75, 75), ArrowColor = Color3.new(1, 1, 1), FrameColor = Color3.fromRGB(40, 40, 40), ButtonColor = Color3.fromRGB(75, 75, 75)})
                return object2
            end}
        end)()
        object.Window = (function()
            local object2 = {}
            local object3 = {MinWidth = 200, FreeWidth = 200}
            local mouse = v13:GetMouse()
            local instance
            local parent
            local list = {}
            local data = {Width = 300, Windows = {}, ResizeCons = {}, Hidden = true}
            local data2 = {Width = 300, Windows = {}, ResizeCons = {}, Hidden = true}
            local v2
            local displayOrder
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local list2 = {}
            local isA = game.IsA
            local data3 = {MainColor1 = Color3.fromRGB(52, 52, 52), MainColor2 = Color3.fromRGB(45, 45, 45), Button = Color3.fromRGB(60, 60, 60)}
            local function stopTweens()
                for i = 1, #list2 do
                    list2[i]:Cancel()
                end
                list2 = {}
            end
            local function resizeHook(arg1, resizing, text)
                local main = arg1.GuiElems.Main
                resizing.InputBegan:Connect(function(input)
                    if not arg1.Dragging and not arg1.Resizing and arg1.Resizable and arg1.ResizableInternal then
                        local v1 = text:find('[WE]') and true
                        local v2 = text:find('[NS]') and true
                        local v3 = text:find('W', 1, true) and -1 or 1
                        local v4 = text:find('N', 1, true) and -1 or 1
                        if arg1.Minimized and v2 then
                            return
                        end
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            resizing.BackgroundTransparency = 0.5
                            return
                        end
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            local connection
                            local connection2
                            local v5 = mouse.X - resizing.AbsolutePosition.X
                            local v6 = mouse.Y - resizing.AbsolutePosition.Y
                            arg1.Resizing = resizing
                            resizing.BackgroundTransparency = 1
                            connection = v12.UserInputService.InputEnded:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    connection:Disconnect()
                                    connection2:Disconnect()
                                    arg1.Resizing = false
                                    resizing.BackgroundTransparency = 1
                                end
                            end)
                            connection2 = v12.UserInputService.InputChanged:Connect(function(input)
                                if arg1.Resizable and arg1.ResizableInternal and input.UserInputType == Enum.UserInputType.MouseMovement then
                                    arg1:StopTweens()
                                    local v7 = input.Position.X - resizing.AbsolutePosition.X - v5
                                    local v8 = input.Position.Y - resizing.AbsolutePosition.Y - v6
                                    if main.AbsoluteSize.X + v7 * v3 < arg1.MinX then
                                        v7 = v3 * (arg1.MinX - main.AbsoluteSize.X)
                                    end
                                    if main.AbsoluteSize.Y + v8 * v4 < arg1.MinY then
                                        v8 = v4 * (arg1.MinY - main.AbsoluteSize.Y)
                                    end
                                    if v4 < 0 and main.AbsolutePosition.Y + v8 < 0 then
                                        v8 = -main.AbsolutePosition.Y
                                    end
                                    main.Position = main.Position + UDim2.new(0, v3 < 0 and v7 or 0, 0, v4 < 0 and v8 or 0)
                                    arg1.SizeX = arg1.SizeX + (v1 and v7 * v3 or 0)
                                    arg1.SizeY = arg1.SizeY + (v2 and v8 * v4 or 0)
                                    main.Size = UDim2.new(0, arg1.SizeX, 0, arg1.Minimized and 20 or arg1.SizeY)
                                end
                            end)
                        end
                    end
                end)
                resizing.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and arg1.Resizing ~= resizing then
                        resizing.BackgroundTransparency = 1
                    end
                end)
            end
            local handler
            local function moveToTop(value)
                local index = table.find(list, value)
                if index then
                    table.remove(list, index)
                    table.insert(list, 1, value)
                    handler()
                end
            end
            local function sideHasRoom(list, number)
                local v1 = instance.AbsoluteSize.Y - math.max(0, #list.Windows - 1) * 4
                local total = 0
                for _, window in pairs(list.Windows) do
                    total += window.MinY or 100
                    if v1 - number < total then
                        return false
                    end
                end
                return true
            end
            local function getSideInsertPos(list, arg2)
                local v1 = #list.Windows + 1
                local numbers = {0, instance.AbsoluteSize.Y}
                for k, window in pairs(list.Windows) do
                    local v2 = window.PosY + window.SizeY / 2
                    if arg2 <= v2 then
                        v1 = k
                        numbers[2] = v2
                        return v1, numbers
                    end
                    numbers[1] = v2
                end
                return v1, numbers
            end
            local function focusInput(arg1, arg2)
                if isA(arg2, 'GuiButton') then
                    arg2.MouseButton1Down:Connect(function()
                        moveToTop(arg1)
                    end)
                    return
                end
                if isA(arg2, 'TextBox') then
                    arg2.Focused:Connect(function()
                        moveToTop(arg1)
                    end)
                end
            end
            local function handler2(arg1)
                local parent2 = callback2({{1, 'ScreenGui', {Name = 'Window'}}, {2, 'Frame', {Active = true, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Main', Parent = {1}, Position = UDim2.new(0.40000000596046, 0, 0.40000000596046, 0), Size = UDim2.new(0, 300, 0, 300)}}, {3, 'Frame', {BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderSizePixel = 0, Name = 'Content', Parent = {2}, Position = UDim2.new(0, 0, 0, 20), Size = UDim2.new(1, 0, 1, -20), ClipsDescendants = true}}, {4, 'Frame', {BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderSizePixel = 0, Name = 'Line', Parent = {3}, Size = UDim2.new(1, 0, 0, 1)}}, {5, 'Frame', {BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BorderSizePixel = 0, Name = 'TopBar', Parent = {2}, Size = UDim2.new(1, 0, 0, 20)}}, {6, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {5}, Position = UDim2.new(0, 5, 0, 0), Size = UDim2.new(1, -10, 0, 20), Text = 'Window', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0}}, {7, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Close', Parent = {5}, Position = UDim2.new(1, -18, 0, 2), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14}}, {8, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://5054663650', Parent = {7}, Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(0, 10, 0, 10)}}, {9, 'UICorner', {CornerRadius = UDim.new(0, 4), Parent = {7}}}, {10, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Minimize', Parent = {5}, Position = UDim2.new(1, -36, 0, 2), Size = UDim2.new(0, 16, 0, 16), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14}}, {11, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://5034768003', Parent = {10}, Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(0, 10, 0, 10)}}, {12, 'UICorner', {CornerRadius = UDim.new(0, 4), Parent = {10}}}, {13, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Image = 'rbxassetid://1427967925', Name = 'Outlines', Parent = {2}, Position = UDim2.new(0, -5, 0, -5), ScaleType = 1, Size = UDim2.new(1, 10, 1, 10), SliceCenter = Rect.new(6, 6, 25, 25), TileSize = UDim2.new(0, 20, 0, 20)}}, {14, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'ResizeControls', Parent = {2}, Position = UDim2.new(0, -5, 0, -5), Size = UDim2.new(1, 10, 1, 10)}}, {15, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.27450981736183, 0.27450981736183, 0.27450981736183), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'North', Parent = {14}, Position = UDim2.new(0, 5, 0, 0), Size = UDim2.new(1, -10, 0, 5), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {16, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.27450981736183, 0.27450981736183, 0.27450981736183), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'South', Parent = {14}, Position = UDim2.new(0, 5, 1, -5), Size = UDim2.new(1, -10, 0, 5), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {17, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.27450981736183, 0.27450981736183, 0.27450981736183), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'NorthEast', Parent = {14}, Position = UDim2.new(1, -5, 0, 0), Size = UDim2.new(0, 5, 0, 5), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {18, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.27450981736183, 0.27450981736183, 0.27450981736183), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'East', Parent = {14}, Position = UDim2.new(1, -5, 0, 5), Size = UDim2.new(0, 5, 1, -10), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {19, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.27450981736183, 0.27450981736183, 0.27450981736183), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'West', Parent = {14}, Position = UDim2.new(0, 0, 0, 5), Size = UDim2.new(0, 5, 1, -10), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {20, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.27450981736183, 0.27450981736183, 0.27450981736183), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'SouthEast', Parent = {14}, Position = UDim2.new(1, -5, 1, -5), Size = UDim2.new(0, 5, 0, 5), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {21, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.27450981736183, 0.27450981736183, 0.27450981736183), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'NorthWest', Parent = {14}, Size = UDim2.new(0, 5, 0, 5), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {22, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.27450981736183, 0.27450981736183, 0.27450981736183), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'SouthWest', Parent = {14}, Position = UDim2.new(0, 0, 1, -5), Size = UDim2.new(0, 5, 0, 5), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}})
                local main = parent2.Main
                local topBar = main.TopBar
                local resizeControls = main.ResizeControls
                arg1.GuiElems.Main = main
                arg1.GuiElems.TopBar = main.TopBar
                arg1.GuiElems.Content = main.Content
                arg1.GuiElems.Line = main.Content.Line
                arg1.GuiElems.Outlines = main.Outlines
                arg1.GuiElems.Title = topBar.Title
                arg1.GuiElems.Close = topBar.Close
                arg1.GuiElems.Minimize = topBar.Minimize
                arg1.GuiElems.ResizeControls = resizeControls
                arg1.ContentPane = main.Content
                topBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and arg1.Draggable then
                        local connection
                        local connection2
                        local x = instance.AbsoluteSize.X
                        local x2 = main.AbsolutePosition.X
                        local y = main.AbsolutePosition.Y
                        local v1 = mouse.X - x2
                        local v2 = mouse.Y - y
                        local v3
                        local v4
                        guiDragging = true
                        connection = callback(game:GetService('UserInputService')).InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                connection:Disconnect()
                                connection2:Disconnect()
                                guiDragging = false
                                parent.Parent = nil
                                if v4 then
                                    local v1 = v4 == 'left' and data or v4 == 'right' and data2
                                    arg1:AlignTo(v1, v3)
                                end
                            end
                        end)
                        connection2 = callback(game:GetService('UserInputService')).InputChanged:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement and arg1.Draggable and not arg1.Closed then
                                if arg1.Aligned then
                                    if data.Resizing or data2.Resizing then
                                        return
                                    end
                                    local v5 = input.Position.X - v1
                                    local v6 = input.Position.Y - v2
                                    if math.sqrt((v5 - x2) ^ 2 + (v6 - y) ^ 2) >= 5 then
                                        arg1:SetAligned(false)
                                    end
                                else
                                    local x3 = input.Position.X
                                    local y2 = input.Position.Y
                                    local xOffset = x3 - v1
                                    local yOffset = y2 - v2
                                    if yOffset < 0 then
                                        yOffset = 0
                                    end
                                    main.Position = UDim2.new(0, xOffset, 0, yOffset)
                                    if arg1.Resizable and arg1.Alignable then
                                        if x3 < 25 then
                                            if sideHasRoom(data, arg1.MinY or 100) then
                                                local v7, list = getSideInsertPos(data, y2)
                                                parent.Indicator.Position = UDim2.new(0, -15, 0, list[1])
                                                parent.Indicator.Size = UDim2.new(0, 40, 0, list[2] - list[1])
                                                object.ShowGui(parent)
                                                v3 = v7
                                                v4 = 'left'
                                                return
                                            end
                                        elseif x - 25 <= x3 and sideHasRoom(data2, arg1.MinY or 100) then
                                            local v8, list2 = getSideInsertPos(data2, y2)
                                            parent.Indicator.Position = UDim2.new(0, x - 25, 0, list2[1])
                                            parent.Indicator.Size = UDim2.new(0, 40, 0, list2[2] - list2[1])
                                            object.ShowGui(parent)
                                            v3 = v8
                                            v4 = 'right'
                                            return
                                        end
                                    end
                                    parent.Parent = nil
                                    v3 = nil
                                    v4 = nil
                                end
                            end
                        end)
                    end
                end)
                topBar.Close.MouseButton1Click:Connect(function()
                    if arg1.Closed then
                        return
                    end
                    arg1:Close()
                end)
                topBar.Minimize.MouseButton1Click:Connect(function()
                    if arg1.Closed then
                        return
                    end
                    if arg1.Aligned then
                        arg1:SetAligned(false)
                        return
                    end
                    arg1:SetMinimized()
                end)
                topBar.Minimize.MouseButton2Click:Connect(function()
                    if arg1.Closed then
                        return
                    end
                    if not arg1.Aligned then
                        arg1:SetMinimized(nil, 2)
                        topBar.Minimize.BackgroundTransparency = 1
                    end
                end)
                main.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and not arg1.Aligned and not arg1.Closed then
                        moveToTop(arg1)
                    end
                end)
                main:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
                    local absolutePosition = main.AbsolutePosition
                    arg1.PosX = absolutePosition.X
                    arg1.PosY = absolutePosition.Y
                end)
                resizeHook(arg1, resizeControls.North, 'N')
                resizeHook(arg1, resizeControls.NorthEast, 'NE')
                resizeHook(arg1, resizeControls.East, 'E')
                resizeHook(arg1, resizeControls.SouthEast, 'SE')
                resizeHook(arg1, resizeControls.South, 'S')
                resizeHook(arg1, resizeControls.SouthWest, 'SW')
                resizeHook(arg1, resizeControls.West, 'W')
                resizeHook(arg1, resizeControls.NorthWest, 'NW')
                main.Size = UDim2.new(0, arg1.SizeX, 0, arg1.SizeY)
                parent2.DescendantAdded:Connect(function(descendant)
                    focusInput(arg1, descendant)
                end)
                local descendants = parent2:GetDescendants()
                for i = 1, #descendants do
                    focusInput(arg1, descendants[i])
                end
                arg1.MinimizeAnim = object.ButtonAnim(topBar.Minimize)
                arg1.CloseAnim = object.ButtonAnim(topBar.Close)
                return parent2
            end
            local function updateSideFrames(arg1)
                stopTweens()
                data.Frame.Size = UDim2.new(0, data.Width, 1, 0)
                data2.Frame.Size = UDim2.new(0, data2.Width, 1, 0)
                data.Frame.Resizer.Position = UDim2.new(0, data.Width, 0, 0)
                data2.Frame.Resizer.Position = UDim2.new(0, -5, 0, 0)
                local v1 = #data.Windows == 0 or data.Hidden
                local v2 = #data2.Windows == 0 or data2.Hidden
                local position = v1 and UDim2.new(0, -data.Width - 10, 0, 0) or UDim2.new(0, 0, 0, 0)
                local position2 = v2 and UDim2.new(1, 10, 0, 0) or UDim2.new(1, -data2.Width, 0, 0)
                instance.LeftToggle.Text = v1 and '>' or '<'
                instance.RightToggle.Text = v2 and '<' or '>'
                if not arg1 then
                    local function insertTween(...)
                        local tween = v12.TweenService:Create(...)
                        list2[#list2 + 1] = tween
                        tween:Play()
                    end
                    insertTween(data.Frame, tweenInfo, {Position = position})
                    insertTween(data2.Frame, tweenInfo, {Position = position2})
                    insertTween(instance.LeftToggle, tweenInfo, {Position = UDim2.new(0, #data.Windows == 0 and -16 or 0, 0, -36)})
                    insertTween(instance.RightToggle, tweenInfo, {Position = UDim2.new(1, #data2.Windows == 0 and 0 or -16, 0, -36)})
                    return
                end
                data.Frame.Position = position
                data2.Frame.Position = position2
                instance.LeftToggle.Position = UDim2.new(0, #data.Windows == 0 and -16 or 0, 0, -36)
                instance.RightToggle.Position = UDim2.new(1, #data2.Windows == 0 and 0 or -16, 0, -36)
            end
            local function getSideFramePos(arg1)
                if arg1 == data then
                    return (#data.Windows == 0 or data.Hidden) and UDim2.new(0, -data.Width - 10, 0, 0) or UDim2.new(0, 0, 0, 0)
                end
                return (#data2.Windows == 0 or data2.Hidden) and UDim2.new(1, 10, 0, 0) or UDim2.new(1, -data2.Width, 0, 0)
            end
            local function sideResized(arg1)
                local total = 0
                local sideFramePos = getSideFramePos(arg1)
                for _, window in pairs(arg1.Windows) do
                    window.SizeX = arg1.Width
                    window.GuiElems.Main.Size = UDim2.new(0, arg1.Width, 0, window.SizeY)
                    window.GuiElems.Main.Position = UDim2.new(sideFramePos.X.Scale, sideFramePos.X.Offset, 0, total)
                    total = total + window.SizeY + 4
                end
            end
            local function sideResizerHook(resizing, arg2, arg3, arg4)
                local mouse = v1.Mouse
                local windows = arg3.Windows
                resizing.InputBegan:Connect(function(input)
                    if not arg3.Resizing then
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            resizing.BackgroundColor3 = data3.MainColor2
                            return
                        end
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            local connection
                            local connection2
                            local v1 = mouse.X - resizing.AbsolutePosition.X
                            local v2 = mouse.Y - resizing.AbsolutePosition.Y
                            arg3.Resizing = resizing
                            resizing.BackgroundColor3 = data3.MainColor2
                            connection = v12.UserInputService.InputEnded:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    connection:Disconnect()
                                    connection2:Disconnect()
                                    arg3.Resizing = false
                                    resizing.BackgroundColor3 = data3.Button
                                end
                            end)
                            connection2 = v12.UserInputService.InputChanged:Connect(function(input)
                                if not resizing.Parent then
                                    connection:Disconnect()
                                    connection2:Disconnect()
                                    arg3.Resizing = false
                                    return
                                end
                                if input.UserInputType == Enum.UserInputType.MouseMovement then
                                    if arg2 == 'V' then
                                        local v3 = input.Position.Y - resizing.AbsolutePosition.Y - v2
                                        if v3 > 0 then
                                            local remaining = v3
                                            for i = arg4 + 1, #windows do
                                                local window = windows[i]
                                                local max = math.max(window.SizeY - remaining, window.MinY or 100)
                                                remaining -= window.SizeY - max
                                                window.SizeY = max
                                            end
                                            windows[arg4].SizeY = windows[arg4].SizeY + math.max(0, v3 - remaining)
                                        else
                                            local remaining2 = -v3
                                            for i = arg4, 1, -1 do
                                                local window2 = windows[i]
                                                local max2 = math.max(window2.SizeY - remaining2, window2.MinY or 100)
                                                remaining2 -= window2.SizeY - max2
                                                window2.SizeY = max2
                                            end
                                            windows[arg4 + 1].SizeY = windows[arg4 + 1].SizeY + math.max(0, -v3 - remaining2)
                                        end
                                        updateSideFrames()
                                        sideResized(arg3)
                                        return
                                    end
                                    if arg2 == 'H' then
                                        local max3 = math.max(300, instance.AbsoluteSize.X - object3.FreeWidth)
                                        local v4 = arg3 == data and data2 or data
                                        local v5 = input.Position.X - resizing.AbsolutePosition.X - v1
                                        v5 = arg3 == data and v5 or -v5
                                        local max4 = math.max(object3.MinWidth, arg3.Width + v5)
                                        if max4 + v4.Width <= max3 then
                                            arg3.Width = max4
                                        else
                                            local width = max3 - max4
                                            if object3.MinWidth <= width then
                                                arg3.Width = max4
                                                v4.Width = width
                                            else
                                                arg3.Width = max3 - object3.MinWidth
                                                v4.Width = object3.MinWidth
                                            end
                                        end
                                        updateSideFrames(true)
                                        sideResized(arg3)
                                        sideResized(v4)
                                    end
                                end
                            end)
                        end
                    end
                end)
                resizing.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and arg3.Resizing ~= resizing then
                        resizing.BackgroundColor3 = data3.Button
                    end
                end)
            end
            local function renderSide(list, arg2)
                local total = 0
                local sideFramePos = getSideFramePos(list)
                local clone = list.WindowResizer:Clone()
                for _, resizeCon in pairs(list.ResizeCons) do
                    resizeCon:Disconnect()
                end
                for _, child in pairs(list.Frame:GetChildren()) do
                    if child.Name ~= 'WindowResizer' then
                        continue
                    end
                    child:Destroy()
                end
                list.ResizeCons = {}
                list.Resizing = nil
                for k, window in pairs(list.Windows) do
                    window.SidePos = k
                    local v1 = k == #list.Windows
                    local udim2 = UDim2.new(0, list.Width, 0, window.SizeY)
                    local udim22 = UDim2.new(sideFramePos.X.Scale, sideFramePos.X.Offset, 0, total)
                    object.ShowGui(window.Gui)
                    if arg2 then
                        window.GuiElems.Main.Size = udim2
                        window.GuiElems.Main.Position = udim22
                    else
                        local tween = v12.TweenService:Create(window.GuiElems.Main, tweenInfo, {Size = udim2, Position = udim22})
                        list2[#list2 + 1] = tween
                        tween:Play()
                    end
                    total = total + window.SizeY + 4
                    if not v1 then
                        local clone2 = clone:Clone()
                        clone2.Position = UDim2.new(1, -list.Width, 0, total - 4)
                        list.ResizeCons[#list.ResizeCons + 1] = window.Gui.Main:GetPropertyChangedSignal('Size'):Connect(function()
                            clone2.Position = UDim2.new(1, -list.Width, 0, window.GuiElems.Main.Position.Y.Offset + window.GuiElems.Main.Size.Y.Offset)
                        end)
                        list.ResizeCons[#list.ResizeCons + 1] = window.Gui.Main:GetPropertyChangedSignal('Position'):Connect(function()
                            clone2.Position = UDim2.new(1, -list.Width, 0, window.GuiElems.Main.Position.Y.Offset + window.GuiElems.Main.Size.Y.Offset)
                        end)
                        sideResizerHook(clone2, 'V', list, k)
                        clone2.Parent = list.Frame
                    end
                end
            end
            local function updateSide(arg1, arg2)
                local total = 0
                local total2 = 0
                local max = 0
                local windows = arg1.Windows
                local v1 = instance.AbsoluteSize.Y - math.max(0, #windows - 1) * 4
                for _, window in pairs(windows) do
                    total += window.SizeY
                end
                for k, window in pairs(windows) do
                    if k == #windows then
                        window.SizeY = v1 - total2
                        max = math.max(0, (window.MinY or 100) - window.SizeY)
                    else
                        window.SizeY = math.max(math.floor(window.SizeY / total * v1), window.MinY or 100)
                    end
                    total2 += window.SizeY
                end
                if max > 0 then
                    for i = #windows - 1, 1, -1 do
                        local window = windows[i]
                        local max2 = math.max(window.SizeY - max, window.MinY or 100)
                        max -= window.SizeY - max2
                        window.SizeY = max2
                    end
                    local v2 = windows[#windows]
                    v2.SizeY = (v2.MinY or 100) - max
                end
                renderSide(arg1, arg2)
            end
            function handler(arg1)
                updateSideFrames(arg1)
                updateSide(data, arg1)
                updateSide(data2, arg1)
                local count = 0
                for i = #list, 1, -1 do
                    list[i].Gui.DisplayOrder = v2 + count
                    object.ShowGui(list[i].Gui)
                    count = count + 1
                end
            end
            function object2:SetMinimized(arg2, arg3)
                local minimized = self.Minimized
                local minimized2
                minimized2 = if arg2 == nil then not self.Minimized else arg2
                self.Minimized = minimized2
                if not arg3 then
                    arg3 = 1
                end
                local resizeControls = self.GuiElems.ResizeControls
                local names = {'North', 'NorthEast', 'NorthWest', 'South', 'SouthEast', 'SouthWest'}
                for i = 1, #names do
                    local firstChild = resizeControls:FindFirstChild(names[i])
                    if not firstChild then
                        continue
                    end
                    firstChild.Visible = not minimized2
                end
                if arg3 == 1 or arg3 == 2 then
                    self:StopTweens()
                    if arg3 == 1 then
                        self.GuiElems.Main:TweenSize(UDim2.new(0, self.SizeX, 0, minimized2 and 20 or self.SizeY), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
                    else
                        local y = instance.AbsoluteSize.Y
                        local udim2 = UDim2.new(0, self.PosX, 0, minimized2 and math.min(y - 20, self.PosY + self.SizeY - 20) or math.max(0, self.PosY - self.SizeY + 20))
                        self.GuiElems.Main:TweenPosition(udim2, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
                        self.GuiElems.Main:TweenSize(UDim2.new(0, self.SizeX, 0, minimized2 and 20 or self.SizeY), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
                    end
                    self.GuiElems.Minimize.ImageLabel.Image = minimized2 and 'rbxassetid://5060023708' or 'rbxassetid://5034768003'
                end
                if minimized ~= minimized2 then
                    if minimized2 then
                        self.OnMinimize:Fire()
                        return
                    end
                    self.OnRestore:Fire()
                end
            end
            function object2:Resize(arg2, arg3)
                self.SizeX = arg2 or self.SizeX
                self.SizeY = arg3 or self.SizeY
                self.GuiElems.Main.Size = UDim2.new(0, self.SizeX, 0, self.SizeY)
            end
            object2.SetSize = object2.Resize
            function object2:SetTitle(text)
                self.GuiElems.Title.Text = text
            end
            function object2:SetResizable(resizable)
                self.Resizable = resizable
                self.GuiElems.ResizeControls.Visible = self.Resizable and self.ResizableInternal
            end
            function object2:SetResizableInternal(resizableInternal)
                self.ResizableInternal = resizableInternal
                self.GuiElems.ResizeControls.Visible = self.Resizable and self.ResizableInternal
            end
            function object2.SetAligned(value, aligned)
                value.Aligned = aligned
                value:SetResizableInternal(not aligned)
                value.GuiElems.Main.Active = not aligned
                value.GuiElems.Main.Outlines.Visible = not aligned
                if not aligned then
                    for k, window in pairs(data.Windows) do
                        if window ~= value then
                            continue
                        end
                        table.remove(data.Windows, k)
                        break
                    end
                    for k, window in pairs(data2.Windows) do
                        if window ~= value then
                            continue
                        end
                        table.remove(data2.Windows, k)
                        break
                    end
                    if not table.find(list, value) then
                        table.insert(list, 1, value)
                    end
                    value.GuiElems.Minimize.ImageLabel.Image = 'rbxassetid://5034768003'
                    value.Side = nil
                    handler()
                    return
                end
                value:SetMinimized(false, 3)
                for k, v in pairs(list) do
                    if v ~= value then
                        continue
                    end
                    table.remove(list, k)
                    break
                end
                value.GuiElems.Minimize.ImageLabel.Image = 'rbxassetid://5448127505'
            end
            function object2:Add(value, arg3)
                if type(value) == 'table' and value.Gui and value.Gui:IsA('GuiObject') then
                    value.Gui.Parent = self.ContentPane
                else
                    value.Parent = self.ContentPane
                end
                if arg3 then
                    self.Elements[arg3] = value
                end
            end
            function object2:GetElement(arg2, arg3)
                return self.Elements[arg3]
            end
            function object2.AlignTo(value, side, sidePos, number, arg5)
                if table.find(side.Windows, value) or value.Closed then
                    return
                end
                number = number or value.SizeY
                if number > 0 and number <= 1 then
                    local total = 0
                    for _, window in pairs(side.Windows) do
                        total += window.SizeY
                    end
                    value.SizeY = total > 0 and total * number * 2 or number
                else
                    value.SizeY = number > 0 and number or 100
                end
                value:SetAligned(true)
                value.Side = side
                value.SizeX = side.Width
                value.Gui.DisplayOrder = displayOrder + 1
                for _, window in pairs(side.Windows) do
                    window.Gui.DisplayOrder = displayOrder
                end
                sidePos = math.min(#side.Windows + 1, sidePos or 1)
                value.SidePos = sidePos
                table.insert(side.Windows, sidePos, value)
                if not arg5 then
                    side.Hidden = false
                end
            end
            function object2:Close()
                self.Closed = true
                self:SetResizableInternal(false)
                object.FindAndRemove(data.Windows, self)
                object.FindAndRemove(data2.Windows, self)
                object.FindAndRemove(list, self)
                self.MinimizeAnim.Disable()
                self.CloseAnim.Disable()
                self.ClosedSide = self.Side
                self.Side = nil
                self.OnDeactivate:Fire()
                if not self.Aligned then
                    self:StopTweens()
                    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local now = tick()
                    self.LastClose = now
                    self:DoTween(self.GuiElems.Main, tweenInfo, {Size = UDim2.new(0, self.SizeX, 0, 20)})
                    self:DoTween(self.GuiElems.Title, tweenInfo, {TextTransparency = 1})
                    self:DoTween(self.GuiElems.Minimize.ImageLabel, tweenInfo, {ImageTransparency = 1})
                    self:DoTween(self.GuiElems.Close.ImageLabel, tweenInfo, {ImageTransparency = 1})
                    object.FastWait(0.2)
                    if now ~= self.LastClose then
                        return
                    end
                    self:DoTween(self.GuiElems.TopBar, tweenInfo, {BackgroundTransparency = 1})
                    self:DoTween(self.GuiElems.Outlines, tweenInfo, {ImageTransparency = 1})
                    object.FastWait(0.2)
                    if now ~= self.LastClose then
                        return
                    end
                end
                self.Aligned = false
                self.Gui.Parent = nil
                handler(true)
            end
            object2.Hide = object2.Close
            function object2:IsVisible()
                return not self.Closed and (self.Side and not self.Side.Hidden or not self.Side)
            end
            function object2:IsContentVisible()
                return self:IsVisible() and not self.Minimized
            end
            function object2.Focus(arg1)
                moveToTop(arg1)
            end
            function object2:MoveInBoundary()
                local posX = self.PosX
                local posY = self.PosY
                local x = instance.AbsoluteSize.X
                local y = instance.AbsoluteSize.Y
                posX = math.min(posX, x - self.SizeX)
                posY = math.min(posY, y - 20)
                self.GuiElems.Main.Position = UDim2.new(0, posX, 0, posY)
            end
            function object2.DoTween(list, ...)
                local tween = v12.TweenService:Create(...)
                list.Tweens[#list.Tweens + 1] = tween
                tween:Play()
            end
            function object2:StopTweens()
                for _, tween in pairs(self.Tweens) do
                    tween:Cancel()
                end
                self.Tweens = {}
            end
            function object2.Show(arg1, arg2)
                return object3.ShowWindow(arg1, arg2)
            end
            function object2:ShowAndFocus(arg2)
                object3.ShowWindow(self, arg2)
                v12.RunService.RenderStepped:wait()
                self:Focus()
            end
            function object3.ShowWindow(value, arg2)
                arg2 = arg2 or {}
                local align = arg2.Align
                local pos = arg2.Pos
                local size = arg2.Size
                local v1 = align == 'left' and data or align == 'right' and data2
                if not value.Closed then
                    if not value.Aligned then
                        value:SetMinimized(false)
                        return
                    end
                    if value.Side and not arg2.Silent then
                        object3.SetSideVisible(value.Side, true)
                    end
                    return
                else
                    value.Closed = false
                    value.LastClose = tick()
                    value.GuiElems.Title.TextTransparency = 0
                    value.GuiElems.Minimize.ImageLabel.ImageTransparency = 0
                    value.GuiElems.Close.ImageLabel.ImageTransparency = 0
                    value.GuiElems.TopBar.BackgroundTransparency = 0
                    value.GuiElems.Outlines.ImageTransparency = 0
                    value.GuiElems.Minimize.ImageLabel.Image = 'rbxassetid://5034768003'
                    value.GuiElems.Main.Active = true
                    value.GuiElems.Main.Outlines.Visible = true
                    value:SetMinimized(false, 3)
                    value:SetResizableInternal(true)
                    value.MinimizeAnim.Enable()
                    value.CloseAnim.Enable()
                    if align then
                        value:AlignTo(v1, pos, size, arg2.Silent)
                    elseif align == nil and value.ClosedSide then
                        value:AlignTo(value.ClosedSide, value.SidePos, size, true)
                        object3.SetSideVisible(value.ClosedSide, true)
                    else
                        if table.find(list, value) then
                            return
                        end
                        value.GuiElems.Main.Size = UDim2.new(0, value.SizeX, 0, 20)
                        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        value:StopTweens()
                        value:DoTween(value.GuiElems.Main, tweenInfo, {Size = UDim2.new(0, value.SizeX, 0, value.SizeY)})
                        value.SizeY = size or value.SizeY
                        table.insert(list, 1, value)
                        handler()
                    end
                    value.ClosedSide = nil
                    value.OnActivate:Fire()
                end
            end
            function object3.ToggleSide(text)
                local v1 = text == 'left' and data or data2
                v1.Hidden = not v1.Hidden
                for _, window in pairs(v1.Windows) do
                    if v1.Hidden then
                        window.OnDeactivate:Fire()
                    else
                        window.OnActivate:Fire()
                    end
                end
                handler()
            end
            function object3.SetSideVisible(value, arg2)
                local v1 = type(value) == 'table' and value or value == 'left' and data or data2
                v1.Hidden = not arg2
                for _, window in pairs(v1.Windows) do
                    if v1.Hidden then
                        window.OnDeactivate:Fire()
                    else
                        window.OnActivate:Fire()
                    end
                end
                handler()
            end
            function object3.Init()
                v2 = v1.DisplayOrders.Window
                displayOrder = v1.DisplayOrders.SideWindow
                instance = Instance.new('ScreenGui')
                local frame = callback2({{1, 'Frame', {Active = true, Name = 'LeftSide', BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderSizePixel = 0}}, {2, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2549019753933, 0.2549019753933, 0.2549019753933), BorderSizePixel = 0, Font = 3, Name = 'Resizer', Parent = {1}, Size = UDim2.new(0, 5, 1, 0), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {3, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14117647707462), BorderSizePixel = 0, Name = 'Line', Parent = {2}, Position = UDim2.new(0, 0, 0, 0), Size = UDim2.new(0, 1, 1, 0)}}, {4, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2549019753933, 0.2549019753933, 0.2549019753933), BorderSizePixel = 0, Font = 3, Name = 'WindowResizer', Parent = {1}, Position = UDim2.new(1, -300, 0, 0), Size = UDim2.new(1, 0, 0, 4), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {5, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14117647707462), BorderSizePixel = 0, Name = 'Line', Parent = {4}, Size = UDim2.new(1, 0, 0, 1)}}})
                data.Frame = frame
                frame.Position = UDim2.new(0, -data.Width - 10, 0, 0)
                data.WindowResizer = frame.WindowResizer
                frame.WindowResizer.Parent = nil
                frame.Parent = instance
                local frame2 = callback2({{1, 'Frame', {Active = true, Name = 'RightSide', BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderSizePixel = 0}}, {2, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2549019753933, 0.2549019753933, 0.2549019753933), BorderSizePixel = 0, Font = 3, Name = 'Resizer', Parent = {1}, Size = UDim2.new(0, 5, 1, 0), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {3, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14117647707462), BorderSizePixel = 0, Name = 'Line', Parent = {2}, Position = UDim2.new(0, 4, 0, 0), Size = UDim2.new(0, 1, 1, 0)}}, {4, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2549019753933, 0.2549019753933, 0.2549019753933), BorderSizePixel = 0, Font = 3, Name = 'WindowResizer', Parent = {1}, Position = UDim2.new(1, -300, 0, 0), Size = UDim2.new(1, 0, 0, 4), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {5, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14117647707462), BorderSizePixel = 0, Name = 'Line', Parent = {4}, Size = UDim2.new(1, 0, 0, 1)}}})
                data2.Frame = frame2
                frame2.Position = UDim2.new(1, 10, 0, 0)
                data2.WindowResizer = frame2.WindowResizer
                frame2.WindowResizer.Parent = nil
                frame2.Parent = instance
                sideResizerHook(frame.Resizer, 'H', data)
                sideResizerHook(frame2.Resizer, 'H', data2)
                parent = Instance.new('ScreenGui')
                parent.DisplayOrder = v1.DisplayOrders.Core
                local frame3 = Instance.new('Frame', parent)
                frame3.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                frame3.BorderSizePixel = 0
                frame3.BackgroundTransparency = 0.8
                frame3.Name = 'Indicator'
                local uiCorner = Instance.new('UICorner', frame3)
                uiCorner.CornerRadius = UDim.new(0, 10)
                local template = callback2({{1, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BorderColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14117647707462), BorderMode = 2, Font = 10, Name = 'LeftToggle', Position = UDim2.new(0, 0, 0, -36), Size = UDim2.new(0, 16, 0, 36), Text = '<', TextColor3 = Color3.new(1, 1, 1), TextSize = 14}}})
                local clone = template:Clone()
                clone.Name = 'RightToggle'
                clone.Position = UDim2.new(1, -16, 0, -36)
                object.ButtonAnim(template, {Mode = 2, PressColor = Color3.fromRGB(32, 32, 32)})
                object.ButtonAnim(clone, {Mode = 2, PressColor = Color3.fromRGB(32, 32, 32)})
                template.MouseButton1Click:Connect(function()
                    object3.ToggleSide('left')
                end)
                clone.MouseButton1Click:Connect(function()
                    object3.ToggleSide('right')
                end)
                template.Parent = instance
                clone.Parent = instance
                instance:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
                    local max = math.max(300, instance.AbsoluteSize.X - object3.FreeWidth)
                    data.Width = math.max(object3.MinWidth, math.min(data.Width, max - data2.Width))
                    data2.Width = math.max(object3.MinWidth, math.min(data2.Width, max - data.Width))
                    for i = 1, #list do
                        list[i]:MoveInBoundary()
                    end
                    handler(true)
                end)
                instance.DisplayOrder = displayOrder - 1
                object.ShowGui(instance)
                updateSideFrames()
            end
            local class = {__index = object2}
            function object3.new()
                local object2 = setmetatable({Minimized = false, Dragging = false, Resizing = false, Aligned = false, Draggable = true, Resizable = true, ResizableInternal = true, Alignable = true, Closed = true, SizeX = 300, SizeY = 300, MinX = 200, MinY = 200, PosX = 0, PosY = 0, GuiElems = {}, Tweens = {}, Elements = {}, OnActivate = object.Signal.new(), OnDeactivate = object.Signal.new(), OnMinimize = object.Signal.new(), OnRestore = object.Signal.new()}, class)
                object2.Gui = handler2(object2)
                return object2
            end
            return object3
        end)()
        object.ContextMenu = (function()
            local object2 = {}
            local v2
            local function createGui(arg1)
                local result = callback2({{1, 'ScreenGui', {DisplayOrder = 1000000, Name = 'Context', ZIndexBehavior = 1}}, {2, 'Frame', {Active = true, BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14117647707462), BorderColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14117647707462), Name = 'Main', Parent = {1}, Position = UDim2.new(0.5, -100, 0.5, -150), Size = UDim2.new(0, 200, 0, 100)}}, {3, 'UICorner', {CornerRadius = UDim.new(0, 4), Parent = {2}}}, {4, 'Frame', {BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), Name = 'Container', Parent = {2}, Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(1, -2, 1, -2)}}, {5, 'UICorner', {CornerRadius = UDim.new(0, 4), Parent = {4}}}, {6, 'ScrollingFrame', {Active = true, BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(0, 0, 0, 0), Name = 'List', Parent = {4}, Position = UDim2.new(0, 2, 0, 2), ScrollBarImageColor3 = Color3.new(0, 0, 0), ScrollBarThickness = 4, Size = UDim2.new(1, -4, 1, -4), VerticalScrollBarInset = 1}}, {7, 'UIListLayout', {Parent = {6}, SortOrder = 2}}, {8, 'Frame', {BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BorderSizePixel = 0, Name = 'SearchFrame', Parent = {4}, Size = UDim2.new(1, 0, 0, 24), Visible = false}}, {9, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.1176470592618, 0.1176470592618, 0.1176470592618), BorderSizePixel = 0, Name = 'SearchContainer', Parent = {8}, Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(1, -6, 0, 18)}}, {10, 'TextBox', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'SearchBox', Parent = {9}, PlaceholderColor3 = Color3.new(0.39215689897537, 0.39215689897537, 0.39215689897537), PlaceholderText = 'Search', Position = UDim2.new(0, 4, 0, 0), Size = UDim2.new(1, -8, 0, 18), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 0}}, {11, 'UICorner', {CornerRadius = UDim.new(0, 2), Parent = {9}}}, {12, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14117647707462), BorderSizePixel = 0, Name = 'Line', Parent = {8}, Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 0, 0, 1)}}, {13, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.33725491166115, 0.49019610881805, 0.73725491762161), BorderSizePixel = 0, Font = 3, Name = 'Entry', Parent = {1}, Size = UDim2.new(1, 0, 0, 22), Text = '', TextSize = 14, Visible = false}}, {14, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'EntryName', Parent = {13}, Position = UDim2.new(0, 24, 0, 0), Size = UDim2.new(1, -24, 1, 0), Text = 'Duplicate', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {15, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Shortcut', Parent = {13}, Position = UDim2.new(0, 24, 0, 0), Size = UDim2.new(1, -30, 1, 0), Text = 'Ctrl+D', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {16, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ImageRectOffset = Vector2.new(304, 0), ImageRectSize = Vector2.new(16, 16), Name = 'Icon', Parent = {13}, Position = UDim2.new(0, 2, 0, 3), ScaleType = 4, Size = UDim2.new(0, 16, 0, 16)}}, {17, 'UICorner', {CornerRadius = UDim.new(0, 4), Parent = {13}}}, {18, 'Frame', {BackgroundColor3 = Color3.new(0.21568629145622, 0.21568629145622, 0.21568629145622), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Divider', Parent = {1}, Position = UDim2.new(0, 0, 0, 20), Size = UDim2.new(1, 0, 0, 7), Visible = false}}, {19, 'Frame', {BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BorderSizePixel = 0, Name = 'Line', Parent = {18}, Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, 1)}}, {20, 'TextLabel', {AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'DividerName', Parent = {18}, Position = UDim2.new(0, 2, 0.5, 0), Size = UDim2.new(1, -4, 1, 0), Text = 'Objects', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextTransparency = 0.60000002384186, TextXAlignment = 0, Visible = false}}})
                arg1.GuiElems.Main = result.Main
                arg1.GuiElems.List = result.Main.Container.List
                arg1.GuiElems.Entry = result.Entry
                arg1.GuiElems.Divider = result.Divider
                arg1.GuiElems.SearchFrame = result.Main.Container.SearchFrame
                arg1.GuiElems.SearchBar = arg1.GuiElems.SearchFrame.SearchContainer.SearchBox
                object.ViewportTextBox.convert(arg1.GuiElems.SearchBar)
                arg1.GuiElems.SearchBar:GetPropertyChangedSignal('Text'):Connect(function()
                    local lower = string.lower
                    local find = string.find
                    local result = lower(arg1.GuiElems.SearchBar.Text)
                    local items = arg1.Items
                    local itemToEntryMap = arg1.ItemToEntryMap
                    if result ~= '' then
                        local list = {}
                        local count = 1
                        for i = 1, #items do
                            local item = items[i]
                            local itemToEntry = itemToEntryMap[item]
                            if not itemToEntry then
                                continue
                            end
                            if not item.Divider and find(lower(item.Name), result, 1, true) then
                                list[count] = item
                                count = count + 1
                            else
                                itemToEntry.Visible = false
                            end
                        end
                        table.sort(list, function(a, b)
                            return a.Name < b.Name
                        end)
                        for i = 1, #list do
                            local gui = itemToEntryMap[list[i]]
                            gui.LayoutOrder = i
                            gui.Visible = true
                        end
                    else
                        for i = 1, #items do
                            local gui2 = itemToEntryMap[items[i]]
                            if not gui2 then
                                continue
                            end
                            gui2.LayoutOrder = i
                            gui2.Visible = true
                        end
                    end
                    local v1 = arg1.GuiElems.List.UIListLayout.AbsoluteContentSize.Y + 6
                    arg1.GuiElems.List.CanvasSize = UDim2.new(0, 0, 0, v1 - 6)
                end)
                return result
            end
            function object2.Add(list, instance)
                local data = {Name = instance.Name or 'Item', Icon = instance.Icon or '', Shortcut = instance.Shortcut or '', OnClick = instance.OnClick, OnHover = instance.OnHover, Disabled = instance.Disabled or false, DisabledIcon = instance.DisabledIcon or '', IconMap = instance.IconMap, OnRightClick = instance.OnRightClick}
                if list.QueuedDivider then
                    local queuedDividerText = list.QueuedDividerText and #list.QueuedDividerText > 0 and list.QueuedDividerText
                    list:AddDivider(queuedDividerText)
                end
                list.Items[#list.Items + 1] = data
                list.Updated = nil
            end
            function object2.AddRegistered(list, text, disabled)
                if not list.Registered[text] then
                    error(text .. ' is not registered')
                end
                if list.QueuedDivider then
                    local queuedDividerText = list.QueuedDividerText and #list.QueuedDividerText > 0 and list.QueuedDividerText
                    list:AddDivider(queuedDividerText)
                end
                list.Registered[text].Disabled = disabled
                list.Items[#list.Items + 1] = list.Registered[text]
                list.Updated = nil
            end
            function object2:Register(arg2, instance)
                self.Registered[arg2] = {Name = instance.Name or 'Item', Icon = instance.Icon or '', Shortcut = instance.Shortcut or '', OnClick = instance.OnClick, OnHover = instance.OnHover, DisabledIcon = instance.DisabledIcon or '', IconMap = instance.IconMap, OnRightClick = instance.OnRightClick}
            end
            function object2:UnRegister(arg2)
                self.Registered[arg2] = nil
            end
            function object2:AddDivider(text)
                self.QueuedDivider = false
                local v1 = text and v12.TextService:GetTextSize(text, 14, Enum.Font.SourceSans, Vector2.new(999999999, 20)).X or nil
                table.insert(self.Items, {Divider = true, Text = text, TextSize = v1 and v1 + 4})
                self.Updated = nil
            end
            function object2:QueueDivider(arg2)
                self.QueuedDivider = true
                self.QueuedDividerText = arg2 or ''
            end
            function object2:Clear()
                self.Items = {}
                self.Updated = nil
            end
            function object2:Refresh()
                for _, child in pairs(self.GuiElems.List:GetChildren()) do
                    if child:IsA('UIListLayout') then
                        continue
                    end
                    child:Destroy()
                end
                local itemToEntryMap = {}
                self.ItemToEntryMap = itemToEntryMap
                local divider = self.GuiElems.Divider
                local list = self.GuiElems.List
                local entry = self.GuiElems.Entry
                local items = self.Items
                for i = 1, #items do
                    local item = items[i]
                    if item.Divider then
                        local clone = divider:Clone()
                        clone.Line.BackgroundColor3 = self.Theme.DividerColor
                        if item.Text then
                            clone.Size = UDim2.new(1, 0, 0, 20)
                            clone.Line.Position = UDim2.new(0, item.TextSize, 0.5, 0)
                            clone.Line.Size = UDim2.new(1, -item.TextSize, 0, 1)
                            clone.DividerName.TextColor3 = self.Theme.TextColor
                            clone.DividerName.Text = item.Text
                            clone.DividerName.Visible = true
                        end
                        clone.Visible = true
                        itemToEntryMap[item] = clone
                        clone.Parent = list
                    else
                        local clone2 = entry:Clone()
                        clone2.BackgroundColor3 = self.Theme.HighlightColor
                        clone2.EntryName.TextColor3 = self.Theme.TextColor
                        clone2.EntryName.Text = item.Name
                        clone2.Shortcut.Text = item.Shortcut
                        if item.Disabled then
                            clone2.EntryName.TextColor3 = Color3.new(0.5882352941176471, 0.5882352941176471, 0.5882352941176471)
                            clone2.Shortcut.TextColor3 = Color3.new(0.5882352941176471, 0.5882352941176471, 0.5882352941176471)
                        end
                        if self.Iconless then
                            clone2.EntryName.Position = UDim2.new(0, 2, 0, 0)
                            clone2.EntryName.Size = UDim2.new(1, -4, 0, 20)
                            clone2.Icon.Visible = false
                        else
                            local image = item.Disabled and item.DisabledIcon or item.Icon
                            if item.IconMap then
                                if type(image) == 'number' then
                                    item.IconMap:Display(clone2.Icon, image)
                                else
                                    if type(image) == 'string' then
                                        item.IconMap:DisplayByKey(clone2.Icon, image)
                                    end
                                end
                            elseif type(image) == 'string' then
                                clone2.Icon.Image = image
                            end
                        end
                        if not item.Disabled then
                            if item.OnClick then
                                clone2.MouseButton1Click:Connect(function()
                                    item.OnClick(item.Name)
                                    if not item.NoHide then
                                        self:Hide()
                                    end
                                end)
                            end
                            if item.OnRightClick then
                                clone2.MouseButton2Click:Connect(function()
                                    item.OnRightClick(item.Name)
                                    if not item.NoHide then
                                        self:Hide()
                                    end
                                end)
                            end
                        end
                        clone2.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                clone2.BackgroundTransparency = 0
                            end
                        end)
                        clone2.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                clone2.BackgroundTransparency = 1
                            end
                        end)
                        clone2.Visible = true
                        itemToEntryMap[item] = clone2
                        clone2.Parent = list
                    end
                end
                self.Updated = true
            end
            function object2:Show(arg2, arg3)
                local guiElems = self.GuiElems
                guiElems.SearchFrame.Visible = self.SearchEnabled
                guiElems.List.Position = UDim2.new(0, 2, 0, 2 + (self.SearchEnabled and 24 or 0))
                guiElems.List.Size = UDim2.new(1, -4, 1, -4 - (self.SearchEnabled and 24 or 0))
                if self.SearchEnabled and self.ClearSearchOnShow then
                    guiElems.SearchBar.Text = ''
                end
                self.GuiElems.List.CanvasPosition = Vector2.new(0, 0)
                if not self.Updated then
                    self:Refresh()
                end
                local flag = false
                local xOffset = arg2 or v2.X
                local yOffset = arg3 or v2.Y
                local viewSizeX = v2.ViewSizeX
                local viewSizeY = v2.ViewSizeY
                if viewSizeX < xOffset + self.Width then
                    xOffset = self.ReverseX and xOffset - self.Width or viewSizeX - self.Width
                end
                guiElems.Main.Position = UDim2.new(0, xOffset, 0, yOffset)
                guiElems.Main.Size = UDim2.new(0, self.Width, 0, 0)
                self.Gui.DisplayOrder = v1.DisplayOrders.Menu
                object.ShowGui(self.Gui)
                local maxHeight = guiElems.List.UIListLayout.AbsoluteContentSize.Y + 6
                if self.MaxHeight and self.MaxHeight < maxHeight then
                    guiElems.List.CanvasSize = UDim2.new(0, 0, 0, maxHeight - 6)
                    maxHeight = self.MaxHeight
                else
                    guiElems.List.CanvasSize = UDim2.new(0, 0, 0, 0)
                end
                if viewSizeY < yOffset + maxHeight then
                    flag = true
                end
                local flag2
                if self.CloseEvent then
                    self.CloseEvent:Disconnect()
                end
                self.CloseEvent = v12.UserInputService.InputBegan:Connect(function(input)
                    if not flag2 or input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        return
                    end
                    if not object.CheckMouseInGui(guiElems.Main) then
                        self.CloseEvent:Disconnect()
                        self:Hide()
                    end
                end)
                if flag then
                    guiElems.Main.Position = UDim2.new(0, xOffset, 0, yOffset - (self.ReverseYOffset or 0))
                    local v3 = yOffset - maxHeight - (self.ReverseYOffset or 0)
                    yOffset = v3 >= 0 and v3 or 0
                    guiElems.Main:TweenSizeAndPosition(UDim2.new(0, self.Width, 0, maxHeight), UDim2.new(0, xOffset, 0, yOffset), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
                else
                    guiElems.Main:TweenSize(UDim2.new(0, self.Width, 0, maxHeight), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
                end
                object.FastWait()
                if self.SearchEnabled and self.FocusSearchOnShow then
                    guiElems.SearchBar:CaptureFocus()
                end
                flag2 = true
            end
            function object2:Hide()
                self.Gui.Parent = nil
            end
            function object2:ApplyTheme(arg2)
                local theme = self.Theme
                theme.ContentColor = arg2.ContentColor or v4.Theme.Menu
                theme.OutlineColor = arg2.OutlineColor or v4.Theme.Menu
                theme.DividerColor = arg2.DividerColor or v4.Theme.Outline2
                theme.TextColor = arg2.TextColor or v4.Theme.Text
                theme.HighlightColor = arg2.HighlightColor or v4.Theme.Main1
                self.GuiElems.Main.BackgroundColor3 = theme.OutlineColor
                self.GuiElems.Main.Container.BackgroundColor3 = theme.ContentColor
            end
            local class = {__index = object2}
            return {new = function()
                if not v2 then
                    v2 = v1.Mouse or v12.Players.LocalPlayer:GetMouse()
                end
                local object = setmetatable({Width = 200, MaxHeight = nil, Iconless = false, SearchEnabled = false, ClearSearchOnShow = true, FocusSearchOnShow = true, Updated = false, QueuedDivider = false, QueuedDividerText = '', Items = {}, Registered = {}, GuiElems = {}, Theme = {}}, class)
                object.Gui = createGui(object)
                object:ApplyTheme({})
                return object
            end}
        end)()
        object.CodeFrame = (function()
            local object2 = {}
            local data = {[1] = 'String', [2] = 'String', [3] = 'String', [4] = 'Comment', [5] = 'Operator', [6] = 'Number', [7] = 'Keyword', [8] = 'BuiltIn', [9] = 'LocalMethod', [10] = 'LocalProperty', [11] = 'Nil', [12] = 'Bool', [13] = 'Function', [14] = 'Local', [15] = 'Self', [16] = 'FunctionName', [17] = 'Bracket'}
            local data2 = {['nil'] = 11, ['true'] = 12, ['false'] = 12, ['function'] = 13, ['local'] = 14, self = 15}
            local data3 = {['and'] = true, ['break'] = true, ['do'] = true, ['else'] = true, ['elseif'] = true, ['end'] = true, ['false'] = true, ['for'] = true, ['function'] = true, ['if'] = true, ['in'] = true, ['local'] = true, ['nil'] = true, ['not'] = true, ['or'] = true, ['repeat'] = true, ['return'] = true, ['then'] = true, ['true'] = true, ['until'] = true, ['while'] = true, plugin = true}
            local data4 = {delay = true, elapsedTime = true, require = true, spawn = true, tick = true, time = true, typeof = true, UserSettings = true, wait = true, warn = true, game = true, shared = true, script = true, workspace = true, assert = true, collectgarbage = true, error = true, getfenv = true, getmetatable = true, ipairs = true, loadstring = true, newproxy = true, next = true, pairs = true, pcall = true, print = true, rawequal = true, rawget = true, rawset = true, select = true, setfenv = true, setmetatable = true, tonumber = true, tostring = true, type = true, unpack = true, xpcall = true, _G = true, _VERSION = true, coroutine = true, debug = true, math = true, os = true, string = true, table = true, bit32 = true, utf8 = true, Axes = true, BrickColor = true, CFrame = true, Color3 = true, ColorSequence = true, ColorSequenceKeypoint = true, DockWidgetPluginGuiInfo = true, Enum = true, Faces = true, Instance = true, NumberRange = true, NumberSequence = true, NumberSequenceKeypoint = true, PathWaypoint = true, PhysicalProperties = true, Random = true, Ray = true, Rect = true, Region3 = true, Region3int16 = true, TweenInfo = true, UDim = true, UDim2 = true, Vector2 = true, Vector2int16 = true, Vector3 = true, Vector3int16 = true}
            local flag = false
            local data5 = {['\''] = '&apos;', ['"'] = '&quot;', ['<'] = '&lt;', ['>'] = '&gt;', ['&'] = '&amp;'}
            local result = (' %s%s '):format('\205', '\205')
            local map = {[('[^%s] %s'):format('\205', '\205')] = 0, [(' %s%s'):format('\205', '\205')] = -1, [('%s%s '):format('\205', '\205')] = 2, [('%s [^%s]'):format('\205', '\205')] = 1}
            local tweenService = v12.TweenService
            local tbl = {}
            local function initBuiltIn()
                local result = getfenv()
                local type = type
                local tostring = tostring
                for k, _ in next, data4 do
                    local value = result[k]
                    if type(value) ~= 'table' then
                        continue
                    end
                    local set = {}
                    for k2, _ in next, value do
                        set[k2] = true
                    end
                    data4[k] = set
                end
                local set2 = {}
                local enums = Enum:GetEnums()
                for i = 1, #enums do
                    set2[tostring(enums[i])] = true
                end
                data4.Enum = set2
                flag = true
            end
            local function setupEditBox(arg1)
                local editBox = arg1.GuiElems.EditBox
                editBox.Focused:Connect(function()
                    arg1:ConnectEditBoxEvent()
                    arg1.Editing = true
                end)
                editBox.FocusLost:Connect(function()
                    arg1:DisconnectEditBoxEvent()
                    arg1.Editing = false
                end)
                editBox:GetPropertyChangedSignal('Text'):Connect(function()
                    local text = editBox.Text
                    if #text == 0 or arg1.EditBoxCopying then
                        return
                    end
                    editBox.Text = ''
                    arg1:AppendText(text)
                end)
            end
            local function setupMouseSelection(arg1)
                local mouse = v13:GetMouse()
                local linesFrame = arg1.GuiElems.LinesFrame
                local lines = arg1.Lines
                linesFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local ceiled, fontSize = math.ceil(arg1.FontSize / 2), arg1.FontSize
                        local v1 = mouse.X - linesFrame.AbsolutePosition.X
                        local v2 = mouse.Y - linesFrame.AbsolutePosition.Y
                        local min = math.round(v1 / ceiled) + arg1.ViewX
                        local min2 = math.floor(v2 / fontSize) + arg1.ViewY
                        local connection
                        local connection2
                        local connection3
                        local num = 0
                        local num2 = 0
                        min2 = math.min(#lines - 1, min2)
                        local list = lines[min2 + 1] or ''
                        min = math.min(#list, min + arg1:TabAdjust(min, min2))
                        arg1.SelectionRange = {{-1, -1}, {-1, -1}}
                        arg1:MoveCursor(min, min2)
                        arg1.FloatCursorX = min
                        local function updateSelection()
                            local v1 = mouse.X - linesFrame.AbsolutePosition.X
                            local v2 = mouse.Y - linesFrame.AbsolutePosition.Y
                            local max = math.max(0, math.round(v1 / ceiled) + arg1.ViewX)
                            local max2 = math.max(0, math.floor(v2 / fontSize) + arg1.ViewY)
                            max2 = math.min(#lines - 1, max2)
                            local list = lines[max2 + 1] or ''
                            max = math.min(#list, max + arg1:TabAdjust(max, max2))
                            if max2 < min2 or max2 == min2 and max < min then
                                arg1.SelectionRange = {{max, max2}, {min, min2}}
                            else
                                arg1.SelectionRange = {{min, min2}, {max, max2}}
                            end
                            arg1:MoveCursor(max, max2)
                            arg1.FloatCursorX = max
                            arg1:Refresh()
                        end
                        connection = v12.UserInputService.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                connection:Disconnect()
                                connection2:Disconnect()
                                connection3:Disconnect()
                                arg1:SetCopyableSelection()
                            end
                        end)
                        connection2 = v12.UserInputService.InputChanged:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                local v1 = mouse.Y - linesFrame.AbsolutePosition.Y
                                local v2 = mouse.Y - linesFrame.AbsolutePosition.Y - linesFrame.AbsoluteSize.Y
                                local v3 = mouse.X - linesFrame.AbsolutePosition.X
                                local v4 = mouse.X - linesFrame.AbsolutePosition.X - linesFrame.AbsoluteSize.X
                                num = 0
                                num2 = 0
                                if v2 > 0 then
                                    num = math.floor(v2 * 0.05) + 1
                                elseif v1 < 0 then
                                    num = math.ceil(v1 * 0.05) - 1
                                end
                                if v4 > 0 then
                                    num2 = math.floor(v4 * 0.05) + 1
                                elseif v3 < 0 then
                                    num2 = math.ceil(v3 * 0.05) - 1
                                end
                                updateSelection()
                            end
                        end)
                        connection3 = callback(game:GetService('RunService')).RenderStepped:Connect(function()
                            if num ~= 0 or num2 ~= 0 then
                                arg1:ScrollDelta(num2, num)
                                updateSelection()
                            end
                        end)
                        arg1:Refresh()
                    end
                end)
            end
            local function makeFrame(arg1)
                local parent = callback2({{1, 'Frame', {BackgroundColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, Position = UDim2.new(0.5, -300, 0.5, -200), Size = UDim2.new(0, 600, 0, 400)}}})
                local guiElems = {}
                local frame = Instance.new('Frame')
                frame.Name = 'Lines'
                frame.BackgroundTransparency = 1
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.ClipsDescendants = true
                frame.Parent = parent
                local textLabel = Instance.new('TextLabel')
                textLabel.Name = 'LineNumbers'
                textLabel.BackgroundTransparency = 1
                textLabel.Font = Enum.Font.Code
                textLabel.TextXAlignment = Enum.TextXAlignment.Right
                textLabel.TextYAlignment = Enum.TextYAlignment.Top
                textLabel.ClipsDescendants = true
                textLabel.RichText = true
                textLabel.Parent = parent
                local frame2 = Instance.new('Frame')
                frame2.Name = 'Cursor'
                frame2.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
                frame2.BorderSizePixel = 0
                frame2.Parent = parent
                local textBox = Instance.new('TextBox')
                textBox.Name = 'EditBox'
                textBox.MultiLine = true
                textBox.Visible = false
                textBox.Parent = parent
                tbl.Invis = tweenService:Create(frame2, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
                tbl.Vis = tweenService:Create(frame2, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
                guiElems.LinesFrame = frame
                guiElems.LineNumbersLabel = textLabel
                guiElems.Cursor = frame2
                guiElems.EditBox = textBox
                guiElems.ScrollCorner = callback2({{1, 'Frame', {BackgroundColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945), BorderSizePixel = 0, Name = 'ScrollCorner', Position = UDim2.new(1, -16, 1, -16), Size = UDim2.new(0, 16, 0, 16), Visible = false}}})
                guiElems.ScrollCorner.Parent = parent
                frame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        arg1:SetEditing(true, input)
                    end
                end)
                arg1.Frame = parent
                arg1.Gui = parent
                arg1.GuiElems = guiElems
                setupEditBox(arg1)
                setupMouseSelection(arg1)
                return parent
            end
            function object2:GetSelectionText()
                if not self:IsValidRange() then
                    return ''
                end
                local selectionRange = self.SelectionRange
                local v1 = selectionRange[1][1]
                local v2 = selectionRange[1][2]
                local v3 = selectionRange[2][1]
                local v4 = selectionRange[2][2]
                local v5 = v4 - v2
                local lines = self.Lines
                if not lines[v2 + 1] or not lines[v4 + 1] then
                    return ''
                elseif v5 == 0 then
                    return self:ConvertText(lines[v2 + 1]:sub(v1 + 1, v3), false)
                else
                    local result = lines[v2 + 1]:sub(v1 + 1)
                    local result2 = lines[v4 + 1]:sub(1, v3)
                    local text = result .. '\n'
                    for i = v2 + 1, v4 - 1 do
                        text ..= lines[i + 1] .. '\n'
                    end
                    text ..= result2
                    return self:ConvertText(text, false)
                end
            end
            function object2:SetCopyableSelection()
                local selectionText = self:GetSelectionText()
                local editBox = self.GuiElems.EditBox
                self.EditBoxCopying = true
                editBox.Text = selectionText
                editBox.SelectionStart = 1
                editBox.CursorPosition = #editBox.Text + 1
                self.EditBoxCopying = false
            end
            function object2:ConnectEditBoxEvent()
                if self.EditBoxEvent then
                    self.EditBoxEvent:Disconnect()
                end
                self.EditBoxEvent = v12.UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.Keyboard then
                        return
                    end
                    local keyCode = Enum.KeyCode
                    local keyCode2 = input.KeyCode
                    local function setupMove(arg1, callback)
                        local connection
                        local v1
                        connection = v12.UserInputService.InputEnded:Connect(function(input)
                            if input.KeyCode ~= arg1 then
                                return
                            end
                            connection:Disconnect()
                            v1 = true
                        end)
                        callback()
                        object.FastWait(0.5)
                        while not v1 do
                            callback()
                            object.FastWait(0.03)
                        end
                    end
                    if keyCode2 == keyCode.Down then
                        setupMove(keyCode.Down, function()
                            self.CursorX = self.FloatCursorX
                            self.CursorY = self.CursorY + 1
                            self:UpdateCursor()
                            self:JumpToCursor()
                        end)
                        return
                    end
                    if keyCode2 == keyCode.Up then
                        setupMove(keyCode.Up, function()
                            self.CursorX = self.FloatCursorX
                            self.CursorY = self.CursorY - 1
                            self:UpdateCursor()
                            self:JumpToCursor()
                        end)
                        return
                    end
                    if keyCode2 == keyCode.Left then
                        setupMove(keyCode.Left, function()
                            local text = self.Lines[self.CursorY + 1] or ''
                            self.CursorX = self.CursorX - 1 - (text:sub(self.CursorX - 3, self.CursorX) == result and 3 or 0)
                            if self.CursorX < 0 then
                                self.CursorY = self.CursorY - 1
                                local list = self.Lines[self.CursorY + 1] or ''
                                self.CursorX = #list
                            end
                            self.FloatCursorX = self.CursorX
                            self:UpdateCursor()
                            self:JumpToCursor()
                        end)
                        return
                    end
                    if keyCode2 == keyCode.Right then
                        setupMove(keyCode.Right, function()
                            local text = self.Lines[self.CursorY + 1] or ''
                            self.CursorX = self.CursorX + 1 + (text:sub(self.CursorX + 1, self.CursorX + 4) == result and 3 or 0)
                            if self.CursorX > #text then
                                self.CursorY = self.CursorY + 1
                                self.CursorX = 0
                            end
                            self.FloatCursorX = self.CursorX
                            self:UpdateCursor()
                            self:JumpToCursor()
                        end)
                        return
                    end
                    if keyCode2 == keyCode.Backspace then
                        setupMove(keyCode.Backspace, function()
                            local v1
                            local list
                            if self:IsValidRange() then
                                v1 = self.SelectionRange[1]
                                list = self.SelectionRange[2]
                            else
                                list = {self.CursorX, self.CursorY}
                            end
                            if not v1 then
                                local text = self.Lines[self.CursorY + 1] or ''
                                self.CursorX = self.CursorX - 1 - (text:sub(self.CursorX - 3, self.CursorX) == result and 3 or 0)
                                if self.CursorX < 0 then
                                    self.CursorY = self.CursorY - 1
                                    local list2 = self.Lines[self.CursorY + 1] or ''
                                    self.CursorX = #list2
                                end
                                self.FloatCursorX = self.CursorX
                                self:UpdateCursor()
                                v1 = v1 or {self.CursorX, self.CursorY}
                            end
                            self:DeleteRange({v1, list}, false, true)
                            self:ResetSelection(true)
                            self:JumpToCursor()
                        end)
                        return
                    end
                    if keyCode2 == keyCode.Delete then
                        setupMove(keyCode.Delete, function()
                            local list
                            local v1
                            if self:IsValidRange() then
                                list = self.SelectionRange[1]
                                v1 = self.SelectionRange[2]
                            else
                                list = {self.CursorX, self.CursorY}
                            end
                            if not v1 then
                                local text = self.Lines[self.CursorY + 1] or ''
                                local num = self.CursorX + 1 + (text:sub(self.CursorX + 1, self.CursorX + 4) == result and 3 or 0)
                                local cursorY = self.CursorY
                                if #text < num then
                                    cursorY += 1
                                    num = 0
                                end
                                self:UpdateCursor()
                                v1 = v1 or {num, cursorY}
                            end
                            self:DeleteRange({list, v1}, false, true)
                            self:ResetSelection(true)
                            self:JumpToCursor()
                        end)
                        return
                    end
                    if v12.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and keyCode2 == keyCode.A then
                        self.SelectionRange = {{0, 0}, {#self.Lines[#self.Lines], #self.Lines - 1}}
                        self:SetCopyableSelection()
                        self:Refresh()
                    end
                end)
            end
            function object2:DisconnectEditBoxEvent()
                if self.EditBoxEvent then
                    self.EditBoxEvent:Disconnect()
                end
            end
            function object2:ResetSelection(arg2)
                self.SelectionRange = {{-1, -1}, {-1, -1}}
                if not arg2 then
                    self:Refresh()
                end
            end
            function object2:IsValidRange(arg2)
                local list = arg2 or self.SelectionRange
                local v1 = list[1][1]
                local v2 = list[1][2]
                local v3 = list[2][1]
                local v4 = list[2][2]
                if v1 == -1 or v1 == v3 and v2 == v4 then
                    return false
                end
                return true
            end
            function object2:DeleteRange(list, arg3, arg4)
                list = list or self.SelectionRange
                if not self:IsValidRange(list) then
                    return
                end
                local lines = self.Lines
                local cursorX = list[1][1]
                local cursorY = list[1][2]
                local v1 = list[2][1]
                local v2 = list[2][2]
                local count = v2 - cursorY
                if not lines[cursorY + 1] or not lines[v2 + 1] then
                    return
                end
                local result = lines[cursorY + 1]:sub(1, cursorX)
                local result2 = lines[v2 + 1]:sub(v1 + 1)
                lines[cursorY + 1] = result .. result2
                local remove = table.remove
                for _ = 1, count do
                    remove(lines, cursorY + 2)
                end
                if list == self.SelectionRange then
                    self.SelectionRange = {{-1, -1}, {-1, -1}}
                end
                if arg4 then
                    self.CursorX = cursorX
                    self.CursorY = cursorY
                    self:UpdateCursor()
                end
                if not arg3 then
                    self:ProcessTextChange()
                end
            end
            function object2:AppendText(text)
                self:DeleteRange(nil, true, true)
                local lines = self.Lines
                local cursorX = self.CursorX
                local cursorY = self.CursorY
                local text2 = lines[cursorY + 1]
                local result = text2:sub(1, cursorX)
                local result2 = text2:sub(cursorX + 1)
                text = text:gsub('\r\n', '\n')
                text = self:ConvertText(text, true)
                local list = text:split('\n')
                local insert = table.insert
                for i = 1, #list do
                    local v1 = cursorY + i
                    if i > 1 then
                        insert(lines, v1, '')
                    end
                    local entry = list[i]
                    local v2 = i == 1 and result or ''
                    local v3 = i == #list and result2 or ''
                    lines[v1] = v2 .. entry .. v3
                end
                if #list > 1 then
                    cursorX = 0
                end
                self:ProcessTextChange()
                self.CursorX = cursorX + #list[#list]
                self.CursorY = cursorY + #list - 1
                self:UpdateCursor()
            end
            function object2:ScrollDelta(arg2, arg3)
                self.ScrollV:ScrollTo(self.ScrollV.Index + arg3)
                self.ScrollH:ScrollTo(self.ScrollH.Index + arg2)
            end
            function object2:TabAdjust(number, number2)
                local lines = self.Lines
                local text = lines[number2 + 1]
                number += 1
                if text then
                    local list = text:sub(number - 1, number - 1)
                    local list2 = text:sub(number, number)
                    local list3 = text:sub(number + 1, number + 1)
                    local text2 = (#list > 0 and list or ' ') .. (#list2 > 0 and list2 or ' ') .. (#list3 > 0 and list3 or ' ')
                    for k, v in pairs(map) do
                        if not text2:find(k) then
                            continue
                        end
                        return v
                    end
                end
                return 0
            end
            function object2:SetEditing(arg2, arg3)
                self:UpdateCursor(arg3)
                if arg2 then
                    if self.Editable then
                        self.GuiElems.EditBox.Text = ''
                        self.GuiElems.EditBox:CaptureFocus()
                    end
                else
                    self.GuiElems.EditBox:ReleaseFocus()
                end
            end
            function object2:CursorAnim(arg2)
                local cursor = self.GuiElems.Cursor
                local now = tick()
                self.LastAnimTime = now
                if not arg2 then
                    return
                end
                tbl.Invis:Cancel()
                tbl.Vis:Cancel()
                cursor.BackgroundTransparency = 0
                coroutine.wrap(function()
                    while self.Editable do
                        object.FastWait(0.5)
                        if self.LastAnimTime ~= now then
                            return
                        end
                        tbl.Invis:Play()
                        object.FastWait(0.4)
                        if self.LastAnimTime ~= now then
                            return
                        end
                        tbl.Vis:Play()
                        object.FastWait(0.2)
                    end
                end)()
            end
            function object2:MoveCursor(cursorX, cursorY)
                self.CursorX = cursorX
                self.CursorY = cursorY
                self:UpdateCursor()
                self:JumpToCursor()
            end
            function object2:JumpToCursor()
                self:Refresh()
            end
            function object2.UpdateCursor(number, arg2)
                local linesFrame = number.GuiElems.LinesFrame
                local cursor = number.GuiElems.Cursor
                local max = math.max(0, linesFrame.AbsoluteSize.X)
                local max2 = math.max(0, linesFrame.AbsoluteSize.Y)
                local ceiled = math.ceil(max2 / number.FontSize)
                local ceiled2 = math.ceil(max / math.ceil(number.FontSize / 2))
                local viewX = number.ViewX
                local viewY = number.ViewY
                local text = tostring(#number.Lines)
                local ceiled3 = math.ceil(number.FontSize / 2)
                local v1 = #text * ceiled3 + 4 * ceiled3
                if arg2 then
                    local linesFrame2 = number.GuiElems.LinesFrame
                    local x = linesFrame2.AbsolutePosition.X
                    local y = linesFrame2.AbsolutePosition.Y
                    local x2 = arg2.Position.X
                    local y2 = arg2.Position.Y
                    local ceiled4, fontSize = math.ceil(number.FontSize / 2), number.FontSize
                    number.CursorX = number.ViewX + math.round((x2 - x) / ceiled4)
                    number.CursorY = number.ViewY + math.floor((y2 - y) / fontSize)
                end
                local cursorX = number.CursorX
                local cursorY = number.CursorY
                local list = number.Lines[cursorY + 1] or ''
                if #list < cursorX then
                    cursorX = #list
                elseif cursorX < 0 then
                    cursorX = 0
                end
                cursorY = if #number.Lines > cursorY then if cursorY >= 0 then cursorY else 0 else math.max(0, #number.Lines - 1)
                cursorX += number:TabAdjust(cursorX, cursorY)
                number.CursorX = cursorX
                number.CursorY = cursorY
                if viewX <= cursorX and viewY <= cursorY and cursorX <= viewX + ceiled2 and cursorY <= viewY + ceiled then
                    local v2 = cursorX - viewX
                    local v3 = cursorY - viewY
                    cursor.Position = UDim2.new(0, v1 + v2 * math.ceil(number.FontSize / 2) - 1, 0, v3 * number.FontSize)
                    cursor.Size = UDim2.new(0, 1, 0, number.FontSize + 2)
                    cursor.Visible = true
                    number:CursorAnim(true)
                    return
                end
                cursor.Visible = false
            end
            function object2.MapNewLines(label)
                local newLines = {}
                local count = 1
                local text = label.Text
                local find = string.find
                local num = 1
                local result = find(text, '\n', num, true)
                while result do
                    newLines[count] = result
                    count = count + 1
                    local v1 = result + 1
                    result = find(text, '\n', v1, true)
                end
                label.NewLines = newLines
            end
            function object2.PreHighlight(label)
                local _ = tick()
                local list = label.Text:gsub('\\\\', '  ')
                local count = #list
                local list2 = {}
                local map = {}
                local map2 = {}
                local find = string.find
                local sub = string.sub
                label.ColoredLines = {}
                local function findAll(arg1, arg2, arg3, arg4)
                    local count = #list2 + 1
                    local num = 1
                    local v1, v2, v3 = find(arg1, arg2, num, arg4)
                    while v1 do
                        list2[count] = v1
                        map[v1] = arg3
                        if v3 then
                            map2[v1] = v3
                        end
                        count = count + 1
                        local v4 = v2 + 1
                        v1, v2, v3 = find(arg1, arg2, v4, arg4)
                    end
                end
                local _ = tick()
                findAll(list, '"', 1, true)
                findAll(list, '\'', 2, true)
                findAll(list, '%[(=*)%[', 3)
                findAll(list, '--', 4, true)
                table.sort(list2)
                local newLines = label.NewLines
                local count2 = 0
                local num = 0
                local entry = 0
                local preHighlights = {}
                for i = 1, #list2 do
                    local entry2 = list2[i]
                    if entry2 <= entry then
                        continue
                    end
                    local entry3 = entry2
                    local entry4 = map[entry2]
                    if entry4 == 1 then
                        entry3 = find(list, '"', entry2 + 1, true)
                        while entry3 and sub(list, entry3 - 1, entry3 - 1) == '\\' do
                            entry3 = find(list, '"', entry3 + 1, true)
                        end
                        if not entry3 then
                            entry3 = count
                        end
                    elseif entry4 == 2 then
                        entry3 = find(list, '\'', entry2 + 1, true)
                        while entry3 and sub(list, entry3 - 1, entry3 - 1) == '\\' do
                            entry3 = find(list, '\'', entry3 + 1, true)
                        end
                        if not entry3 then
                            entry3 = count
                        end
                    elseif entry4 == 3 then
                        _, entry3 = find(list, ']' .. map2[entry2] .. ']', entry2 + 1, true)
                        if not entry3 then
                            entry3 = count
                        end
                    elseif entry4 == 4 then
                        if map[entry2 + 2] == 3 then
                            _, entry3 = find(list, ']' .. map2[entry2 + 2] .. ']', entry2 + 1, true)
                            if not entry3 then
                                entry3 = count
                            end
                        else
                            entry3 = find(list, '\n', entry2 + 1, true) or count
                        end
                    end
                    while num < entry2 do
                        count2 += 1
                        num = newLines[count2] or count + 1
                    end
                    while true do
                        local preHighlight = preHighlights[count2]
                        if not preHighlight then
                            preHighlight = {}
                            preHighlights[count2] = preHighlight
                        end
                        preHighlight[entry2] = {entry4, entry3}
                        if num >= entry3 then
                            break
                        end
                        count2 += 1
                        num = newLines[count2] or count + 1
                    end
                    entry = entry3
                end
                label.PreHighlights = preHighlights
            end
            function object2:HighlightLine(number)
                local coloredLine = self.ColoredLines[number]
                if coloredLine then
                    return coloredLine
                else
                    local sub = string.sub
                    local find = string.find
                    local match = string.match
                    local list = {}
                    local v1 = self.PreHighlights[number] or {}
                    local list2 = self.Lines[number] or ''
                    local second = 0
                    local first = 0
                    local result
                    local flag = false
                    local num = 0
                    local v2 = self.NewLines[number - 1] or 0
                    local list3 = {}
                    for k, v in next, v1 do
                        local v3 = k - v2
                        if v3 < 1 then
                            first = v[1]
                            second = v[2] - v2
                        else
                            list3[v3] = {v[1], v[2] - v2}
                        end
                    end
                    for i = 1, #list2 do
                        if i <= second then
                            list[i] = first
                        else
                            local list4 = list3[i]
                            if list4 then
                                first = list4[1]
                                second = list4[2]
                                list[i] = first
                                flag = false
                                result = nil
                                num = 0
                            else
                                local result2 = sub(list2, i, i)
                                if find(result2, '[%a_]') then
                                    local list5 = match(list2, '[%a%d_]+', i)
                                    local v4 = data3[list5] and 7 or data4[list5] and 8
                                    second = i + #list5 - 1
                                    if v4 ~= 7 then
                                        if flag then
                                            v4 = result and 8 or 10
                                        end
                                        if v4 ~= 8 then
                                            local v5, v6, v7 = find(list2, '^%s*([%({"\'])', second + 1)
                                            if v5 then
                                                v4 = num > 0 and v7 == '(' and 16 or 9
                                                num = 0
                                            end
                                        end
                                    else
                                        v4 = data2[list5] or v4
                                        num = list5 == 'function' and 1 or 0
                                    end
                                    result = list5
                                    flag = false
                                    if num > 0 then
                                        num = 1
                                    end
                                    if v4 then
                                        first = v4
                                        list[i] = first
                                    else
                                        first = nil
                                    end
                                elseif find(result2, '%p') then
                                    local v8 = result2 == '.'
                                    local result3 = v8 and find(sub(list2, i + 1, i + 1), '%d')
                                    list[i] = result3 and 6 or 5
                                    if result3 then
                                        continue
                                    end
                                    local list6 = v8 and match(list2, '%.%.?%.?', i)
                                    if list6 and #list6 > 1 then
                                        first = 5
                                        second = i + #list6 - 1
                                        flag = false
                                        result = nil
                                        num = 0
                                    else
                                        if v8 then
                                            if flag then
                                                result = nil
                                            else
                                                flag = true
                                            end
                                        else
                                            flag = false
                                            result = nil
                                        end
                                        num = (v8 or result2 == ':') and num == 1 and 2 or 0
                                    end
                                elseif find(result2, '%d') then
                                    local v9, count = find(list2, '%x+', i)
                                    local result4 = sub(list2, count, count + 1)
                                    if (result4 == 'e+' or result4 == 'e-') and find(sub(list2, count + 2, count + 2), '%d') then
                                        count = count + 1
                                    end
                                    first = 6
                                    second = count
                                    list[i] = 6
                                    flag = false
                                    result = nil
                                    num = 0
                                else
                                    list[i] = first
                                    local v10, v11 = find(list2, '%s+', i)
                                    if not v11 then
                                        continue
                                    end
                                    second = v11
                                end
                            end
                        end
                    end
                    self.ColoredLines[number] = list
                    return list
                end
            end
            function object2.Refresh(number)
                local _ = tick()
                local lines = number.Frame.Lines
                local max = math.max(0, lines.AbsoluteSize.X)
                local max2 = math.max(0, lines.AbsoluteSize.Y)
                local ceiled = math.ceil(max2 / number.FontSize)
                local ceiled2 = math.ceil(max / math.ceil(number.FontSize / 2))
                local gsub = string.gsub
                local sub = string.sub
                local viewX = number.ViewX
                local viewY = number.ViewY
                local text = ''
                for i = 1, ceiled do
                    local frame = number.LineFrames[i]
                    if not frame then
                        frame = Instance.new('Frame')
                        frame.Name = 'Line'
                        frame.Position = UDim2.new(0, 0, 0, (i - 1) * number.FontSize)
                        frame.Size = UDim2.new(1, 0, 0, number.FontSize)
                        frame.BorderSizePixel = 0
                        frame.BackgroundTransparency = 1
                        local frame2 = Instance.new('Frame')
                        frame2.Name = 'SelectionHighlight'
                        frame2.BorderSizePixel = 0
                        frame2.BackgroundColor3 = v4.Theme.Syntax.SelectionBack
                        frame2.Parent = frame
                        local textLabel = Instance.new('TextLabel')
                        textLabel.Name = 'Label'
                        textLabel.BackgroundTransparency = 1
                        textLabel.Font = Enum.Font.Code
                        textLabel.TextSize = number.FontSize
                        textLabel.Size = UDim2.new(1, 0, 0, number.FontSize)
                        textLabel.RichText = true
                        textLabel.TextXAlignment = Enum.TextXAlignment.Left
                        textLabel.TextColor3 = number.Colors.Text
                        textLabel.ZIndex = 2
                        textLabel.Parent = frame
                        frame.Parent = lines
                        number.LineFrames[i] = frame
                    end
                    local v1 = viewY + i
                    local v2 = number.Lines[v1] or ''
                    local text2 = ''
                    local result = number:HighlightLine(v1)
                    local v3 = viewX + 1
                    local richTemplates = number.RichTemplates
                    local text3 = richTemplates.Text
                    local selection = richTemplates.Selection
                    local entry = result[v3]
                    local selection2 = richTemplates[data[entry]] or text3
                    local selectionRange = number.SelectionRange
                    local first = selectionRange[1]
                    local second = selectionRange[2]
                    local second2 = first[2]
                    local first2 = first[1]
                    local second3 = second[2]
                    local first3 = second[1]
                    local viewX2, v5 = viewX, v1 - 1
                    if first[2] <= v5 and v5 <= second[2] then
                        local ceiled3 = math.ceil(number.FontSize / 2)
                        local v6 = (v5 == first[2] and first[1] or 0) - viewX
                        local v7 = v5 == second[2] and second[1] - v6 - viewX or ceiled2 + viewX
                        frame.SelectionHighlight.Position = UDim2.new(0, v6 * ceiled3, 0, 0)
                        frame.SelectionHighlight.Size = UDim2.new(0, v7 * ceiled3, 1, 0)
                        frame.SelectionHighlight.Visible = true
                    else
                        frame.SelectionHighlight.Visible = false
                    end
                    if second2 <= v5 and v5 <= second3 and (v5 ~= second2 and v5 ~= second2 and (v5 == second3 and viewX < first3 or v5 ~= second3) or v5 == second2 and (first2 <= viewX or v5 ~= second2) and (v5 == second3 and viewX < first3 or v5 ~= second3)) then
                        entry = -999
                        selection2 = selection
                    end
                    for j = 2, ceiled2 do
                        local v8 = viewX + j
                        local v9 = v8 - 1
                        local entry2 = result[v8]
                        local v10 = second2 <= v5 and v5 <= second3 and (v5 ~= second2 and v5 ~= second2 and (v5 == second3 and v9 < first3 or v5 ~= second3) or v5 == second2 and (first2 <= v9 or v5 ~= second2) and (v5 == second3 and v9 < first3 or v5 ~= second3))
                        if v10 then
                            entry2 = -999
                        end
                        if entry2 == entry then
                            continue
                        end
                        local v11 = v10 and selection or richTemplates[data[entry2]] or text3
                        if v11 ~= selection2 then
                            local result2 = gsub(sub(v2, v3, v8 - 1), '[\'"<>&]', data5)
                            text2 ..= selection2 ~= text3 and selection2 .. result2 .. '</font>' or result2
                            v3 = v8
                            selection2 = v11
                        end
                        entry = entry2
                    end
                    local list = gsub(sub(v2, v3, viewX + ceiled2), '[\'"<>&]', data5)
                    if #list > 0 then
                        text2 ..= selection2 ~= text3 and selection2 .. list .. '</font>' or list
                    end
                    if number.Lines[v1] then
                        text ..= v1 == number.CursorY and '<b>' .. v1 .. '</b>\n' or v1 .. '\n'
                    end
                    frame.Label.Text = text2
                end
                for i = ceiled + 1, #number.LineFrames do
                    number.LineFrames[i]:Destroy()
                    number.LineFrames[i] = nil
                end
                number.Frame.LineNumbers.Text = text
                number:UpdateCursor()
            end
            function object2.UpdateView(number)
                local text = tostring(#number.Lines)
                local ceiled = math.ceil(number.FontSize / 2)
                local xOffset = #text * ceiled + 4 * ceiled
                local lines = number.Frame.Lines
                local x = lines.AbsoluteSize.X
                local y = lines.AbsoluteSize.Y
                local ceiled2 = math.ceil(y / number.FontSize)
                local v1 = number.MaxTextCols * ceiled
                local scrollV = number.ScrollV
                local scrollH = number.ScrollH
                scrollV.VisibleSpace = ceiled2
                scrollV.TotalSpace = #number.Lines + 1
                scrollH.VisibleSpace = math.ceil(x / ceiled)
                scrollH.TotalSpace = number.MaxTextCols + 1
                scrollV.Gui.Visible = ceiled2 < #number.Lines + 1
                scrollH.Gui.Visible = x < v1
                local frameOffsets = number.FrameOffsets
                number.FrameOffsets = Vector2.new(scrollV.Gui.Visible and -16 or 0, scrollH.Gui.Visible and -16 or 0)
                if frameOffsets ~= number.FrameOffsets then
                    number:UpdateView()
                    return
                end
                scrollV:ScrollTo(number.ViewY, true)
                scrollH:ScrollTo(number.ViewX, true)
                if scrollV.Gui.Visible and scrollH.Gui.Visible then
                    scrollV.Gui.Size = UDim2.new(0, 16, 1, -16)
                    scrollH.Gui.Size = UDim2.new(1, -16, 0, 16)
                    number.GuiElems.ScrollCorner.Visible = true
                else
                    scrollV.Gui.Size = UDim2.new(0, 16, 1, 0)
                    scrollH.Gui.Size = UDim2.new(1, 0, 0, 16)
                    number.GuiElems.ScrollCorner.Visible = false
                end
                number.ViewY = scrollV.Index
                number.ViewX = scrollH.Index
                number.Frame.Lines.Position = UDim2.new(0, xOffset, 0, 0)
                number.Frame.Lines.Size = UDim2.new(1, -xOffset + frameOffsets.X, 1, frameOffsets.Y)
                number.Frame.LineNumbers.Position = UDim2.new(0, ceiled, 0, 0)
                number.Frame.LineNumbers.Size = UDim2.new(0, #text * ceiled, 1, frameOffsets.Y)
                number.Frame.LineNumbers.TextSize = number.FontSize
            end
            function object2.ProcessTextChange(label)
                local maxTextCols = 0
                local lines = label.Lines
                for i = 1, #lines do
                    local v1 = #lines[i]
                    if maxTextCols < v1 then
                        maxTextCols = v1
                    end
                end
                label.MaxTextCols = maxTextCols
                label:UpdateView()
                label.Text = table.concat(label.Lines, '\n')
                label:MapNewLines()
                label:PreHighlight()
                label:Refresh()
            end
            function object2.ConvertText(arg1, text, arg3)
                if arg3 then
                    return text:gsub('\t', (' %s%s '):format('\205', '\205'))
                end
                return text:gsub((' %s%s '):format('\205', '\205'), '\t')
            end
            function object2:GetText()
                local joined = table.concat(self.Lines, '\n')
                return self:ConvertText(joined, false)
            end
            function object2:SetText(text)
                text = self:ConvertText(text, true)
                local lines = self.Lines
                table.clear(lines)
                local count = 1
                for match in text:gmatch('([^\n\r]*)[\n\r]?') do
                    lines[count] = match
                    count = count + 1
                end
                self:ProcessTextChange()
            end
            function object2:MakeRichTemplates()
                local floor = math.floor
                local richTemplates = {}
                for k, color in pairs(self.Colors) do
                    richTemplates[k] = ('<font color="rgb(%s,%s,%s)">'):format(floor(color.r * 255), floor(color.g * 255), floor(color.b * 255))
                end
                self.RichTemplates = richTemplates
            end
            function object2:ApplyTheme()
                local syntax = v4.Theme.Syntax
                self.Colors = syntax
                self.Frame.LineNumbers.TextColor3 = syntax.Text
                self.Frame.BackgroundColor3 = syntax.Background
            end
            local class = {__index = object2}
            return {new = function()
                if not flag then
                    initBuiltIn()
                end
                local scrollBar = object.ScrollBar.new()
                local scrollBar2 = object.ScrollBar.new(true)
                scrollBar2.Gui.Position = UDim2.new(0, 0, 1, -16)
                local object2 = setmetatable({FontSize = 15, ViewX = 0, ViewY = 0, Colors = v4.Theme.Syntax, ColoredLines = {}, Lines = {''}, LineFrames = {}, Editable = true, Editing = false, CursorX = 0, CursorY = 0, FloatCursorX = 0, Text = '', PreHighlights = {}, SelectionRange = {{-1, -1}, {-1, -1}}, NewLines = {}, FrameOffsets = Vector2.new(0, 0), MaxTextCols = 0, ScrollV = scrollBar, ScrollH = scrollBar2}, class)
                scrollBar.WheelIncrement = 3
                scrollBar2.Increment = 2
                scrollBar2.WheelIncrement = 7
                scrollBar.Scrolled:Connect(function()
                    object2.ViewY = scrollBar.Index
                    object2:Refresh()
                end)
                scrollBar2.Scrolled:Connect(function()
                    object2.ViewX = scrollBar2.Index
                    object2:Refresh()
                end)
                makeFrame(object2)
                object2:MakeRichTemplates()
                object2:ApplyTheme()
                scrollBar:SetScrollFrame(object2.Frame.Lines)
                scrollBar.Gui.Parent = object2.Frame
                scrollBar2.Gui.Parent = object2.Frame
                object2:UpdateView()
                object2.Frame:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
                    object2:UpdateView()
                    object2:Refresh()
                end)
                return object2
            end}
        end)()
        object.Checkbox = (function()
            local object2 = {}
            local fromRGB = Color3.fromRGB
            local new = Vector2.new
            local fromScale = UDim2.fromScale
            local fromOffset = UDim2.fromOffset
            local new2 = UDim.new
            local max = math.max
            local new3 = Instance.new
            local tweenSize = new3('Frame').TweenSize
            local new4 = TweenInfo.new
            local delay = delay
            local function ripple(parent, backgroundColor3)
                local parent2 = new3('Frame')
                parent2.BackgroundColor3 = backgroundColor3
                parent2.BackgroundTransparency = 0.75
                parent2.BorderSizePixel = 0
                parent2.AnchorPoint = new(0.5, 0.5)
                parent2.Size = fromOffset()
                parent2.Position = fromScale(0.5, 0.5)
                parent2.Parent = parent
                local result = new3('UICorner')
                result.CornerRadius = new2(1)
                result.Parent = parent2
                local absoluteSize = parent.AbsoluteSize
                local v1 = max(absoluteSize.X, absoluteSize.Y) * 5 / 3
                tweenSize(parent2, fromOffset(v1, v1), 'Out', 'Quart', 0.4)
                v12.TweenService:Create(parent2, new4(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
                v12.Debris:AddItem(parent2, 0.4)
            end
            local function initGui(arg1, arg2)
                local gui = arg2 or callback2({{1, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Checkbox', Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(0, 16, 0, 16)}}, {2, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'ripples', Parent = {1}, Size = UDim2.new(1, 0, 1, 0)}}, {3, 'Frame', {BackgroundColor3 = Color3.new(0.10196078568697, 0.10196078568697, 0.10196078568697), BorderSizePixel = 0, Name = 'outline', Parent = {1}, Size = UDim2.new(0, 16, 0, 16)}}, {4, 'Frame', {BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14117647707462), BorderSizePixel = 0, Name = 'filler', Parent = {3}, Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(0, 14, 0, 14)}}, {5, 'Frame', {BackgroundColor3 = Color3.new(0.90196084976196, 0.90196084976196, 0.90196084976196), BorderSizePixel = 0, Name = 'top', Parent = {4}, Size = UDim2.new(0, 16, 0, 0)}}, {6, 'Frame', {AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.new(0.90196084976196, 0.90196084976196, 0.90196084976196), BorderSizePixel = 0, Name = 'bottom', Parent = {4}, Position = UDim2.new(0, 0, 0, 14), Size = UDim2.new(0, 16, 0, 0)}}, {7, 'Frame', {BackgroundColor3 = Color3.new(0.90196084976196, 0.90196084976196, 0.90196084976196), BorderSizePixel = 0, Name = 'left', Parent = {4}, Size = UDim2.new(0, 0, 0, 16)}}, {8, 'Frame', {AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.new(0.90196084976196, 0.90196084976196, 0.90196084976196), BorderSizePixel = 0, Name = 'right', Parent = {4}, Position = UDim2.new(0, 14, 0, 0), Size = UDim2.new(0, 0, 0, 16)}}, {9, 'Frame', {AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Name = 'checkmark', Parent = {4}, Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 20)}}, {10, 'ImageLabel', {AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Image = 'rbxassetid://6234266378', Parent = {9}, Position = UDim2.new(0.5, 0, 0.5, 0), ScaleType = 3, Size = UDim2.new(0, 15, 0, 11)}}, {11, 'ImageLabel', {AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://6401617475', ImageColor3 = Color3.new(0.20784313976765, 0.69803923368454, 0.98431372642517), Name = 'checkmark2', Parent = {4}, Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 12, 0, 12), Visible = false}}, {12, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://6425281788', ImageTransparency = 0.20000000298023, Name = 'middle', Parent = {4}, ScaleType = 2, Size = UDim2.new(1, 0, 1, 0), TileSize = UDim2.new(0, 2, 0, 2), Visible = false}}, {13, 'UICorner', {CornerRadius = UDim.new(0, 2), Parent = {3}}}})
                local outline = gui.outline
                local filler = outline.filler
                local checkmark = filler.checkmark
                local ripples = gui.ripples
                local top = filler.top
                local bottom = filler.bottom
                local left = filler.left
                local right = filler.right
                arg1.Gui = gui
                arg1.GuiElems = {Top = top, Bottom = bottom, Left = left, Right = right, Outline = outline, Filler = filler, Checkmark = checkmark, Checkmark2 = filler.checkmark2, Middle = filler.middle}
                gui.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local connection
                        connection = v12.UserInputService.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                connection:Disconnect()
                                if object.CheckMouseInGui(gui) then
                                    if arg1.Style == 0 then
                                        ripple(ripples, arg1.Disabled and arg1.Colors.Disabled or arg1.Colors.Primary)
                                    end
                                    if not arg1.Disabled then
                                        arg1:SetState(not arg1.Toggled, true)
                                    else
                                        arg1:Paint()
                                    end
                                    arg1.OnInput:Fire()
                                end
                            end
                        end)
                    end
                end)
                arg1:Paint()
            end
            function object2:Collapse(arg2)
                local guiElems = self.GuiElems
                if arg2 then
                    tweenSize(guiElems.Top, fromOffset(14, 14), 'In', 'Quart', 0.26666666666666666, true)
                    tweenSize(guiElems.Bottom, fromOffset(14, 14), 'In', 'Quart', 0.26666666666666666, true)
                    tweenSize(guiElems.Left, fromOffset(14, 14), 'In', 'Quart', 0.26666666666666666, true)
                    tweenSize(guiElems.Right, fromOffset(14, 14), 'In', 'Quart', 0.26666666666666666, true)
                    return
                end
                guiElems.Top.Size = fromOffset(14, 14)
                guiElems.Bottom.Size = fromOffset(14, 14)
                guiElems.Left.Size = fromOffset(14, 14)
                guiElems.Right.Size = fromOffset(14, 14)
            end
            function object2:Expand(arg2)
                local guiElems = self.GuiElems
                if arg2 then
                    tweenSize(guiElems.Top, fromOffset(14, 0), 'InOut', 'Quart', 0.26666666666666666, true)
                    tweenSize(guiElems.Bottom, fromOffset(14, 0), 'InOut', 'Quart', 0.26666666666666666, true)
                    tweenSize(guiElems.Left, fromOffset(0, 14), 'InOut', 'Quart', 0.26666666666666666, true)
                    tweenSize(guiElems.Right, fromOffset(0, 14), 'InOut', 'Quart', 0.26666666666666666, true)
                    return
                end
                guiElems.Top.Size = fromOffset(14, 0)
                guiElems.Bottom.Size = fromOffset(14, 0)
                guiElems.Left.Size = fromOffset(0, 14)
                guiElems.Right.Size = fromOffset(0, 14)
            end
            function object2:Paint()
                local guiElems = self.GuiElems
                if self.Style == 0 then
                    local disabled = self.Disabled and self.Colors.Disabled
                    guiElems.Outline.BackgroundColor3 = disabled or self.Toggled and self.Colors.Primary or self.Colors.Secondary
                    local backgroundColor3 = disabled or self.Colors.Primary
                    guiElems.Top.BackgroundColor3 = backgroundColor3
                    guiElems.Bottom.BackgroundColor3 = backgroundColor3
                    guiElems.Left.BackgroundColor3 = backgroundColor3
                    guiElems.Right.BackgroundColor3 = backgroundColor3
                    return
                end
                guiElems.Outline.BackgroundColor3 = self.Disabled and self.Colors.Disabled or self.Colors.Secondary
                guiElems.Filler.BackgroundColor3 = self.Disabled and self.Colors.DisabledBackground or self.Colors.Background
                guiElems.Checkmark2.ImageColor3 = self.Disabled and self.Colors.DisabledCheck or self.Colors.Primary
            end
            function object2:SetState(toggled, arg3)
                self.Toggled = toggled
                if self.OutlineColorTween then
                    self.OutlineColorTween:Cancel()
                end
                local now = tick()
                self.LastSetStateTime = now
                if self.Toggled then
                    if self.Style == 0 then
                        if arg3 then
                            self.OutlineColorTween = v12.TweenService:Create(self.GuiElems.Outline, new4(0.26666666666666666, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {BackgroundColor3 = self.Colors.Primary})
                            self.OutlineColorTween:Play()
                            delay(0.15, function()
                                if now ~= self.LastSetStateTime then
                                    return
                                end
                                self:Paint()
                                tweenSize(self.GuiElems.Checkmark, fromOffset(14, 20), 'Out', 'Bounce', 0.13333333333333333, true)
                            end)
                        else
                            self.GuiElems.Outline.BackgroundColor3 = self.Colors.Primary
                            self:Paint()
                            self.GuiElems.Checkmark.Size = fromOffset(14, 20)
                        end
                        self:Collapse(arg3)
                        return
                    end
                    self:Paint()
                    self.GuiElems.Checkmark2.Visible = true
                    self.GuiElems.Middle.Visible = false
                    return
                end
                if self.Style == 0 then
                    if arg3 then
                        self.OutlineColorTween = v12.TweenService:Create(self.GuiElems.Outline, new4(0.26666666666666666, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {BackgroundColor3 = self.Colors.Secondary})
                        self.OutlineColorTween:Play()
                        delay(0.15, function()
                            if now ~= self.LastSetStateTime then
                                return
                            end
                            self:Paint()
                            tweenSize(self.GuiElems.Checkmark, fromOffset(0, 20), 'Out', 'Quad', 0.06666666666666667, true)
                        end)
                    else
                        self.GuiElems.Outline.BackgroundColor3 = self.Colors.Secondary
                        self:Paint()
                        self.GuiElems.Checkmark.Size = fromOffset(0, 20)
                    end
                    self:Expand(arg3)
                    return
                end
                self:Paint()
                self.GuiElems.Checkmark2.Visible = false
                self.GuiElems.Middle.Visible = self.Toggled == nil
            end
            local class = {__index = object2}
            local function new5(arg1)
                local object2 = setmetatable({Toggled = false, Disabled = false, OnInput = object.Signal.new(), Style = arg1 or 0, Colors = {Background = fromRGB(36, 36, 36), Primary = fromRGB(49, 176, 230), Secondary = fromRGB(25, 25, 25), Disabled = fromRGB(64, 64, 64), DisabledBackground = fromRGB(52, 52, 52), DisabledCheck = fromRGB(80, 80, 80)}}, class)
                initGui(object2)
                return object2
            end
            local function fromFrame(arg1)
                local object = setmetatable({Toggled = false, Disabled = false, Colors = {Background = fromRGB(36, 36, 36), Primary = fromRGB(49, 176, 230), Secondary = fromRGB(25, 25, 25), Disabled = fromRGB(64, 64, 64), DisabledBackground = fromRGB(52, 52, 52)}}, class)
                initGui(object, arg1)
                return object
            end
            return {new = new5, fromFrame}
        end)()
        object.BrickColorPicker = (function()
            local object2 = {}
            local num = 0
            local mouse = v12.Players.LocalPlayer:GetMouse()
            local list = {Color3.fromRGB(17, 17, 17), Color3.fromRGB(99, 95, 98), Color3.fromRGB(163, 162, 165), Color3.fromRGB(205, 205, 205), Color3.fromRGB(223, 223, 222), Color3.fromRGB(237, 234, 234), Color3.fromRGB(27, 42, 53), Color3.fromRGB(91, 93, 105), Color3.fromRGB(159, 161, 172), Color3.fromRGB(202, 203, 209), Color3.fromRGB(231, 231, 236), Color3.fromRGB(248, 248, 248)}
            local function isMouseInHexagon(arg1)
                local remaining = mouse.X - arg1.AbsolutePosition.X
                local v1 = mouse.Y - arg1.AbsolutePosition.Y
                if remaining >= 4 and remaining < 31 then
                    remaining -= 4
                    local v2 = (13 - math.min(remaining, 26 - remaining)) / 13
                    if 1 + 8 * v2 <= v1 and v1 < arg1.AbsoluteSize.Y - 1 - 8 * v2 then
                        return true
                    end
                end
                return false
            end
            local function hexInput(arg1, userInputService, arg3)
                userInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and isMouseInHexagon(userInputService) then
                        arg1.OnSelect:Fire(arg3)
                        arg1:Close()
                    end
                end)
                userInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and isMouseInHexagon(userInputService) then
                        arg1.OnPreview:Fire(arg3)
                    end
                end)
            end
            local function createGui(arg1)
                local gui = callback2({{1, 'ScreenGui', {Name = 'BrickColor'}}, {2, 'Frame', {Active = true, BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderColor3 = Color3.new(0.1294117718935, 0.1294117718935, 0.1294117718935), Parent = {1}, Position = UDim2.new(0.40000000596046, 0, 0.40000000596046, 0), Size = UDim2.new(0, 337, 0, 380)}}, {3, 'TextButton', {BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), BorderSizePixel = 0, Font = 3, Name = 'MoreColors', Parent = {2}, Position = UDim2.new(0, 5, 1, -30), Size = UDim2.new(1, -10, 0, 25), Text = 'More Colors', TextColor3 = Color3.new(1, 1, 1), TextSize = 14}}, {4, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Image = 'rbxassetid://1281023007', ImageColor3 = Color3.new(0.33333334326744, 0.33333334326744, 0.49803924560547), Name = 'Hex', Parent = {2}, Size = UDim2.new(0, 35, 0, 35), Visible = false}}})
                local frame = gui.Frame
                local hex = frame.Hex
                for i = 1, 13 do
                    local count = math.min(i, 14 - i) + 6
                    for j = 1, count do
                        local color = BrickColor.palette(num).Color
                        local clone = hex:Clone()
                        clone.Position = UDim2.new(0, (j - 1) * 25 - (count - 7) * 13 + 78 + 1, 0, (i - 1) * 23 + 4)
                        clone.ImageColor3 = color
                        clone.Visible = true
                        hexInput(arg1, clone, color)
                        clone.Parent = frame
                        num = num + 1
                    end
                end
                for i = 1, 12 do
                    local imageColor3 = list[i]
                    local clone2 = hex:Clone()
                    clone2.Position = UDim2.new(0, (i - 1) * 25 - 65 + 78 + 3, 0, 308)
                    clone2.ImageColor3 = imageColor3
                    clone2.Visible = true
                    hexInput(arg1, clone2, imageColor3)
                    clone2.Parent = frame
                    num = num + 1
                end
                frame.MoreColors.MouseButton1Click:Connect(function()
                    arg1.OnMoreColors:Fire()
                    arg1:Close()
                end)
                arg1.Gui = gui
            end
            function object2:SetMoreColorsVisible(visible)
                local frame = self.Gui.Frame
                frame.Size = UDim2.new(0, 337, 0, 380 - (not visible and 33 or 0))
                frame.MoreColors.Visible = visible
            end
            function object2:Show(arg2, arg3, arg4)
                self.PrevColor = arg4 or self.PrevColor
                local flag = false
                local xOffset = arg2 or mouse.X
                local yOffset = arg3 or mouse.Y
                local viewSizeX = mouse.ViewSizeX
                local viewSizeY = mouse.ViewSizeY
                object.ShowGui(self.Gui)
                local x = self.Gui.Frame.AbsoluteSize.X
                local y = self.Gui.Frame.AbsoluteSize.Y
                if viewSizeX < xOffset + x then
                    xOffset = self.ReverseX and xOffset - x or viewSizeX - x
                end
                if viewSizeY < yOffset + y then
                    flag = true
                end
                local flag2 = false
                if self.CloseEvent then
                    self.CloseEvent:Disconnect()
                end
                self.CloseEvent = v12.UserInputService.InputBegan:Connect(function(input)
                    if not flag2 or input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        return
                    end
                    if not object.CheckMouseInGui(self.Gui.Frame) then
                        self.CloseEvent:Disconnect()
                        self:Close()
                    end
                end)
                if flag then
                    local v1 = yOffset - y - (self.ReverseYOffset or 0)
                    yOffset = v1 >= 0 and v1 or 0
                end
                self.Gui.Frame.Position = UDim2.new(0, xOffset, 0, yOffset)
                object.FastWait()
                flag2 = true
            end
            function object2:Close()
                self.Gui.Parent = nil
                self.OnCancel:Fire()
            end
            local class = {__index = object2}
            return {new = function()
                local object2 = setmetatable({OnPreview = object.Signal.new(), OnSelect = object.Signal.new(), OnCancel = object.Signal.new(), OnMoreColors = object.Signal.new(), PrevColor = Color3.new(0, 0, 0)}, class)
                createGui(object2)
                return object2
            end}
        end)()
        object.ColorPicker = (function()
            local _ = {}
            return {new = function()
                local object2 = setmetatable({}, {})
                object2.OnSelect = object.Signal.new()
                object2.OnCancel = object.Signal.new()
                object2.OnPreview = object.Signal.new()
                local parent = callback2({{1, 'Frame', {BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderSizePixel = 0, ClipsDescendants = true, Name = 'Content', Position = UDim2.new(0, 0, 0, 20), Size = UDim2.new(1, 0, 1, -20)}}, {2, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'BasicColors', Parent = {1}, Position = UDim2.new(0, 5, 0, 5), Size = UDim2.new(0, 180, 0, 200)}}, {3, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {2}, Position = UDim2.new(0, 0, 0, -5), Size = UDim2.new(1, 0, 0, 26), Text = 'Basic Colors', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {4, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), Name = 'Blue', Parent = {1}, Position = UDim2.new(1, -63, 0, 255), Size = UDim2.new(0, 52, 0, 16)}}, {5, 'TextBox', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), Font = 3, Name = 'Input', Parent = {4}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 50, 0, 16), Text = '0', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {6, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'ArrowFrame', Parent = {5}, Position = UDim2.new(1, -16, 0, 0), Size = UDim2.new(0, 16, 1, 0)}}, {7, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Up', Parent = {6}, Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {8, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {7}, Size = UDim2.new(0, 16, 0, 8)}}, {9, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {8}, Position = UDim2.new(0, 8, 0, 3), Size = UDim2.new(0, 1, 0, 1)}}, {10, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {8}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {11, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {8}, Position = UDim2.new(0, 6, 0, 5), Size = UDim2.new(0, 5, 0, 1)}}, {12, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Down', Parent = {6}, Position = UDim2.new(0, 0, 0, 8), Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {13, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {12}, Size = UDim2.new(0, 16, 0, 8)}}, {14, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {13}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(0, 1, 0, 1)}}, {15, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {13}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {16, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {13}, Position = UDim2.new(0, 6, 0, 3), Size = UDim2.new(0, 5, 0, 1)}}, {17, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {4}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Blue:', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {18, 'Frame', {BackgroundColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), BorderSizePixel = 0, ClipsDescendants = true, Name = 'ColorSpaceFrame', Parent = {1}, Position = UDim2.new(1, -261, 0, 4), Size = UDim2.new(0, 222, 0, 202)}}, {19, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), BorderSizePixel = 0, Image = 'rbxassetid://1072518406', Name = 'ColorSpace', Parent = {18}, Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(0, 220, 0, 200)}}, {20, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Scope', Parent = {19}, Position = UDim2.new(0, 210, 0, 190), Size = UDim2.new(0, 20, 0, 20)}}, {21, 'Frame', {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Name = 'Line', Parent = {20}, Position = UDim2.new(0, 9, 0, 0), Size = UDim2.new(0, 2, 0, 20)}}, {22, 'Frame', {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Name = 'Line', Parent = {20}, Position = UDim2.new(0, 0, 0, 9), Size = UDim2.new(0, 20, 0, 2)}}, {23, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'CustomColors', Parent = {1}, Position = UDim2.new(0, 5, 0, 210), Size = UDim2.new(0, 180, 0, 90)}}, {24, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {23}, Size = UDim2.new(1, 0, 0, 20), Text = 'Custom Colors (RC = Set)', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {25, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), Name = 'Green', Parent = {1}, Position = UDim2.new(1, -63, 0, 233), Size = UDim2.new(0, 52, 0, 16)}}, {26, 'TextBox', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), Font = 3, Name = 'Input', Parent = {25}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 50, 0, 16), Text = '0', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {27, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'ArrowFrame', Parent = {26}, Position = UDim2.new(1, -16, 0, 0), Size = UDim2.new(0, 16, 1, 0)}}, {28, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Up', Parent = {27}, Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {29, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {28}, Size = UDim2.new(0, 16, 0, 8)}}, {30, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {29}, Position = UDim2.new(0, 8, 0, 3), Size = UDim2.new(0, 1, 0, 1)}}, {31, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {29}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {32, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {29}, Position = UDim2.new(0, 6, 0, 5), Size = UDim2.new(0, 5, 0, 1)}}, {33, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Down', Parent = {27}, Position = UDim2.new(0, 0, 0, 8), Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {34, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {33}, Size = UDim2.new(0, 16, 0, 8)}}, {35, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {34}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(0, 1, 0, 1)}}, {36, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {34}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {37, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {34}, Position = UDim2.new(0, 6, 0, 3), Size = UDim2.new(0, 5, 0, 1)}}, {38, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {25}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Green:', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {39, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), Name = 'Hue', Parent = {1}, Position = UDim2.new(1, -180, 0, 211), Size = UDim2.new(0, 52, 0, 16)}}, {40, 'TextBox', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), Font = 3, Name = 'Input', Parent = {39}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 50, 0, 16), Text = '0', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {41, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'ArrowFrame', Parent = {40}, Position = UDim2.new(1, -16, 0, 0), Size = UDim2.new(0, 16, 1, 0)}}, {42, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Up', Parent = {41}, Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {43, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {42}, Size = UDim2.new(0, 16, 0, 8)}}, {44, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {43}, Position = UDim2.new(0, 8, 0, 3), Size = UDim2.new(0, 1, 0, 1)}}, {45, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {43}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {46, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {43}, Position = UDim2.new(0, 6, 0, 5), Size = UDim2.new(0, 5, 0, 1)}}, {47, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Down', Parent = {41}, Position = UDim2.new(0, 0, 0, 8), Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {48, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {47}, Size = UDim2.new(0, 16, 0, 8)}}, {49, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {48}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(0, 1, 0, 1)}}, {50, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {48}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {51, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {48}, Position = UDim2.new(0, 6, 0, 3), Size = UDim2.new(0, 5, 0, 1)}}, {52, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {39}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Hue:', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {53, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), Name = 'Preview', Parent = {1}, Position = UDim2.new(1, -260, 0, 211), Size = UDim2.new(0, 35, 1, -245)}}, {54, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), Name = 'Red', Parent = {1}, Position = UDim2.new(1, -63, 0, 211), Size = UDim2.new(0, 52, 0, 16)}}, {55, 'TextBox', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), Font = 3, Name = 'Input', Parent = {54}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 50, 0, 16), Text = '0', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {56, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'ArrowFrame', Parent = {55}, Position = UDim2.new(1, -16, 0, 0), Size = UDim2.new(0, 16, 1, 0)}}, {57, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Up', Parent = {56}, Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {58, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {57}, Size = UDim2.new(0, 16, 0, 8)}}, {59, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {58}, Position = UDim2.new(0, 8, 0, 3), Size = UDim2.new(0, 1, 0, 1)}}, {60, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {58}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {61, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {58}, Position = UDim2.new(0, 6, 0, 5), Size = UDim2.new(0, 5, 0, 1)}}, {62, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Down', Parent = {56}, Position = UDim2.new(0, 0, 0, 8), Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {63, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {62}, Size = UDim2.new(0, 16, 0, 8)}}, {64, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {63}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(0, 1, 0, 1)}}, {65, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {63}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {66, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {63}, Position = UDim2.new(0, 6, 0, 3), Size = UDim2.new(0, 5, 0, 1)}}, {67, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {54}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Red:', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {68, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), Name = 'Sat', Parent = {1}, Position = UDim2.new(1, -180, 0, 233), Size = UDim2.new(0, 52, 0, 16)}}, {69, 'TextBox', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), Font = 3, Name = 'Input', Parent = {68}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 50, 0, 16), Text = '0', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {70, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'ArrowFrame', Parent = {69}, Position = UDim2.new(1, -16, 0, 0), Size = UDim2.new(0, 16, 1, 0)}}, {71, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Up', Parent = {70}, Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {72, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {71}, Size = UDim2.new(0, 16, 0, 8)}}, {73, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {72}, Position = UDim2.new(0, 8, 0, 3), Size = UDim2.new(0, 1, 0, 1)}}, {74, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {72}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {75, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {72}, Position = UDim2.new(0, 6, 0, 5), Size = UDim2.new(0, 5, 0, 1)}}, {76, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Down', Parent = {70}, Position = UDim2.new(0, 0, 0, 8), Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {77, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {76}, Size = UDim2.new(0, 16, 0, 8)}}, {78, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {77}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(0, 1, 0, 1)}}, {79, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {77}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {80, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {77}, Position = UDim2.new(0, 6, 0, 3), Size = UDim2.new(0, 5, 0, 1)}}, {81, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {68}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Sat:', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {82, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), Name = 'Val', Parent = {1}, Position = UDim2.new(1, -180, 0, 255), Size = UDim2.new(0, 52, 0, 16)}}, {83, 'TextBox', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), Font = 3, Name = 'Input', Parent = {82}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 50, 0, 16), Text = '255', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {84, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'ArrowFrame', Parent = {83}, Position = UDim2.new(1, -16, 0, 0), Size = UDim2.new(0, 16, 1, 0)}}, {85, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Up', Parent = {84}, Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {86, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {85}, Size = UDim2.new(0, 16, 0, 8)}}, {87, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {86}, Position = UDim2.new(0, 8, 0, 3), Size = UDim2.new(0, 1, 0, 1)}}, {88, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {86}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {89, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {86}, Position = UDim2.new(0, 6, 0, 5), Size = UDim2.new(0, 5, 0, 1)}}, {90, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'Down', Parent = {84}, Position = UDim2.new(0, 0, 0, 8), Size = UDim2.new(1, 0, 0, 8), Text = '', TextSize = 14}}, {91, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {90}, Size = UDim2.new(0, 16, 0, 8)}}, {92, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {91}, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(0, 1, 0, 1)}}, {93, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {91}, Position = UDim2.new(0, 7, 0, 4), Size = UDim2.new(0, 3, 0, 1)}}, {94, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {91}, Position = UDim2.new(0, 6, 0, 3), Size = UDim2.new(0, 5, 0, 1)}}, {95, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {82}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Val:', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {96, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), Font = 3, Name = 'Cancel', Parent = {1}, Position = UDim2.new(1, -105, 1, -28), Size = UDim2.new(0, 100, 0, 25), Text = 'Cancel', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14}}, {97, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), Font = 3, Name = 'Ok', Parent = {1}, Position = UDim2.new(1, -210, 1, -28), Size = UDim2.new(0, 100, 0, 25), Text = 'OK', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14}}, {98, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), Image = 'rbxassetid://1072518502', Name = 'ColorStrip', Parent = {1}, Position = UDim2.new(1, -30, 0, 5), Size = UDim2.new(0, 13, 0, 200)}}, {99, 'Frame', {BackgroundColor3 = Color3.new(0.3137255012989, 0.3137255012989, 0.3137255012989), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'ArrowFrame', Parent = {1}, Position = UDim2.new(1, -16, 0, 1), Size = UDim2.new(0, 5, 0, 208)}}, {100, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {99}, Position = UDim2.new(0, -2, 0, -4), Size = UDim2.new(0, 8, 0, 16)}}, {101, 'Frame', {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Parent = {100}, Position = UDim2.new(0, 2, 0, 8), Size = UDim2.new(0, 1, 0, 1)}}, {102, 'Frame', {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Parent = {100}, Position = UDim2.new(0, 3, 0, 7), Size = UDim2.new(0, 1, 0, 3)}}, {103, 'Frame', {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Parent = {100}, Position = UDim2.new(0, 4, 0, 6), Size = UDim2.new(0, 1, 0, 5)}}, {104, 'Frame', {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Parent = {100}, Position = UDim2.new(0, 5, 0, 5), Size = UDim2.new(0, 1, 0, 7)}}, {105, 'Frame', {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Parent = {100}, Position = UDim2.new(0, 6, 0, 4), Size = UDim2.new(0, 1, 0, 9)}}})
                local window = object.Window.new()
                window.Resizable = false
                window.Alignable = false
                window:SetTitle('Color Picker')
                window:Resize(450, 330)
                for _, child in pairs(parent:GetChildren()) do
                    child.Parent = window.GuiElems.Content
                end
                object2.Window = window
                object2.Gui = window.Gui
                local main = window.Gui.Main
                local topBar = main.TopBar
                local content = main.Content
                local colorSpace = content.ColorSpaceFrame.ColorSpace
                local colorStrip = content.ColorStrip
                local preview = content.Preview
                local basicColors = content.BasicColors
                local customColors = content.CustomColors
                local ok = content.Ok
                local cancel = content.Cancel
                local close, scope = topBar.Close, colorSpace.Scope
                local arrow = content.ArrowFrame.Arrow
                local input = content.Hue.Input
                local input2 = content.Sat.Input
                local input3 = content.Val.Input
                local input4 = content.Red.Input
                local input5 = content.Green.Input
                local input6 = content.Blue.Input
                local result = callback(game:GetService('UserInputService'))
                local mouse = callback(game:GetService('Players')).LocalPlayer:GetMouse()
                local num = 0
                local num2 = 0
                local num3 = 1
                local num4 = 1
                local num5 = 1
                local num6 = 1
                local color3 = Color3.new(0, 0, 0)
                local map = {Color3.new(0, 0, 0), Color3.new(0.66666668653488, 0, 0), Color3.new(0, 0.33333334326744, 0), Color3.new(0.66666668653488, 0.33333334326744, 0), Color3.new(0, 0.66666668653488, 0), Color3.new(0.66666668653488, 0.66666668653488, 0), Color3.new(0, 1, 0), Color3.new(0.66666668653488, 1, 0), Color3.new(0, 0, 0.49803924560547), Color3.new(0.66666668653488, 0, 0.49803924560547), Color3.new(0, 0.33333334326744, 0.49803924560547), Color3.new(0.66666668653488, 0.33333334326744, 0.49803924560547), Color3.new(0, 0.66666668653488, 0.49803924560547), Color3.new(0.66666668653488, 0.66666668653488, 0.49803924560547), Color3.new(0, 1, 0.49803924560547), (Color3.new(0.66666668653488, 1, 0.49803924560547)), Color3.new(0, 0, 1), Color3.new(0.66666668653488, 0, 1), Color3.new(0, 0.33333334326744, 1), Color3.new(0.66666668653488, 0.33333334326744, 1), Color3.new(0, 0.66666668653488, 1), Color3.new(0.66666668653488, 0.66666668653488, 1), Color3.new(0, 1, 1), Color3.new(0.66666668653488, 1, 1), Color3.new(0.33333334326744, 0, 0), Color3.new(1, 0, 0), Color3.new(0.33333334326744, 0.33333334326744, 0), Color3.new(1, 0.33333334326744, 0), Color3.new(0.33333334326744, 0.66666668653488, 0), Color3.new(1, 0.66666668653488, 0), Color3.new(0.33333334326744, 1, 0), (Color3.new(1, 1, 0)), Color3.new(0.33333334326744, 0, 0.49803924560547), Color3.new(1, 0, 0.49803924560547), Color3.new(0.33333334326744, 0.33333334326744, 0.49803924560547), Color3.new(1, 0.33333334326744, 0.49803924560547), Color3.new(0.33333334326744, 0.66666668653488, 0.49803924560547), Color3.new(1, 0.66666668653488, 0.49803924560547), Color3.new(0.33333334326744, 1, 0.49803924560547), Color3.new(1, 1, 0.49803924560547), Color3.new(0.33333334326744, 0, 1), Color3.new(1, 0, 1), Color3.new(0.33333334326744, 0.33333334326744, 1), Color3.new(1, 0.33333334326744, 1), Color3.new(0.33333334326744, 0.66666668653488, 1), Color3.new(1, 0.66666668653488, 1), Color3.new(0.33333334326744, 1, 1), Color3.new(1, 1, 1)}
                local list = {}
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
                    object2.Color = color3
                    object2.OnPreview:Fire(color3)
                end
                local function colorSpaceInput()
                    local v1 = mouse.X - colorSpace.AbsolutePosition.X
                    local v2 = mouse.Y - colorSpace.AbsolutePosition.Y
                    local v3 = if v1 >= 0 then if v1 <= 219 then v1 else 219 else 0
                    local v4 = if v2 >= 0 then if v2 <= 199 then v2 else 199 else 0
                    num = (219 - v3) / 219
                    num2 = (199 - v4) / 199
                    local color = Color3.fromHSV(num, num2, num3)
                    num4, num5, num6 = color.r, color.g, color.b
                    updateColor()
                end
                local function colorStripInput()
                    local v1 = if mouse.Y - colorStrip.AbsolutePosition.Y >= 0 then if mouse.Y - colorStrip.AbsolutePosition.Y <= 199 then mouse.Y - colorStrip.AbsolutePosition.Y else 199 else 0
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
                            connection = result.InputEnded:Connect(function(input)
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
                            connection = result.InputEnded:Connect(function(input)
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
                        connection = result.InputEnded:Connect(function(input)
                            if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                                return
                            end
                            connection:Disconnect()
                            connection2:Disconnect()
                        end)
                        connection2 = result.InputChanged:Connect(function(input)
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
                        connection = result.InputEnded:Connect(function(input)
                            if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                                return
                            end
                            connection:Disconnect()
                            connection2:Disconnect()
                        end)
                        connection2 = result.InputChanged:Connect(function(input)
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
                textButton.BorderColor3 = Color3.fromRGB(55, 55, 55)
                textButton.Text = ''
                textButton.AutoButtonColor = false
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
                    count = count + 1
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
                ok.MouseButton1Click:Connect(function()
                    object2.OnSelect:Fire(color3)
                    window:Close()
                end)
                ok.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        ok.BackgroundTransparency = 0.4
                    end
                end)
                ok.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        ok.BackgroundTransparency = 0
                    end
                end)
                cancel.MouseButton1Click:Connect(function()
                    object2.OnCancel:Fire()
                    window:Close()
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
                updateColor()
                function object2.SetColor(arg1, arg2)
                    num4, num5, num6 = arg2.r, arg2.g, arg2.b
                    num, num2, num3 = Color3.toHSV(arg2)
                    updateColor()
                end
                function object2:Show()
                    self.Window:Show()
                end
                return object2
            end}
        end)()
        object.NumberSequenceEditor = (function()
            return {new = function()
                local object2 = setmetatable({}, {})
                object2.OnSelect = object.Signal.new()
                object2.OnCancel = object.Signal.new()
                object2.OnPreview = object.Signal.new()
                local parent = callback2({{1, 'Frame', {BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderSizePixel = 0, ClipsDescendants = true, Name = 'Content', Position = UDim2.new(0, 0, 0, 20), Size = UDim2.new(1, 0, 1, -20)}}, {2, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), Name = 'Time', Parent = {1}, Position = UDim2.new(0, 40, 0, 210), Size = UDim2.new(0, 60, 0, 20)}}, {3, 'TextBox', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), ClipsDescendants = true, Font = 3, Name = 'Input', Parent = {2}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 58, 0, 20), Text = '0', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {4, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {2}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Time', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {5, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), Font = 3, Name = 'Close', Parent = {1}, Position = UDim2.new(1, -90, 0, 210), Size = UDim2.new(0, 80, 0, 20), Text = 'Close', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14}}, {6, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), Font = 3, Name = 'Reset', Parent = {1}, Position = UDim2.new(1, -180, 0, 210), Size = UDim2.new(0, 80, 0, 20), Text = 'Reset', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14}}, {7, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), Font = 3, Name = 'Delete', Parent = {1}, Position = UDim2.new(0, 380, 0, 210), Size = UDim2.new(0, 80, 0, 20), Text = 'Delete', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14}}, {8, 'Frame', {BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), Name = 'NumberLineOutlines', Parent = {1}, Position = UDim2.new(0, 10, 0, 20), Size = UDim2.new(1, -20, 0, 170)}}, {9, 'Frame', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), Name = 'NumberLine', Parent = {1}, Position = UDim2.new(0, 10, 0, 20), Size = UDim2.new(1, -20, 0, 170)}}, {10, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), Name = 'Value', Parent = {1}, Position = UDim2.new(0, 170, 0, 210), Size = UDim2.new(0, 60, 0, 20)}}, {11, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {10}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Value', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {12, 'TextBox', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), ClipsDescendants = true, Font = 3, Name = 'Input', Parent = {10}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 58, 0, 20), Text = '0', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {13, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), Name = 'Envelope', Parent = {1}, Position = UDim2.new(0, 300, 0, 210), Size = UDim2.new(0, 60, 0, 20)}}, {14, 'TextBox', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), ClipsDescendants = true, Font = 3, Name = 'Input', Parent = {13}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 58, 0, 20), Text = '0', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {15, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {13}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Envelope', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}})
                local window = object.Window.new()
                window.Resizable = false
                window:Resize(680, 265)
                window:SetTitle('NumberSequence Editor')
                object2.Window = window
                object2.Gui = window.Gui
                for _, child in pairs(parent:GetChildren()) do
                    child.Parent = window.GuiElems.Content
                end
                local gui = window.Gui
                local main = gui.Main
                local topBar = main.TopBar
                local content = main.Content
                local numberLine = content.NumberLine
                local numberLineOutlines = content.NumberLineOutlines
                local input = content.Time.Input
                local input2 = content.Value.Input
                local input3 = content.Envelope.Input
                local delete = content.Delete
                local reset = content.Reset
                local close = content.Close
                local close2, map = topBar.Close, {{1, 0, 3}, {8, 0.05, 1}, {5, 0.6, 2}, {4, 0.7, 4}, {6, 1, 4}}
                local list = {}
                local list2 = {}
                local first = map[1]
                local v1 = map[#map]
                local v2
                local list3
                local v3
                local result = callback(game:GetService('UserInputService'))
                local mouse = callback(game:GetService('Players')).LocalPlayer:GetMouse()
                for i = 2, 10 do
                    local frame = Instance.new('Frame')
                    frame.BackgroundTransparency = 0.5
                    frame.BackgroundColor3 = Color3.new(0.3764705882352941, 0.3764705882352941, 0.3764705882352941)
                    frame.BorderSizePixel = 0
                    frame.Size = UDim2.new(0, 1, 1, 0)
                    frame.Position = UDim2.new((i - 1) / 10, 0, 0, 0)
                    frame.Parent = numberLineOutlines
                end
                for i = 2, 4 do
                    local frame2 = Instance.new('Frame')
                    frame2.BackgroundTransparency = 0.5
                    frame2.BackgroundColor3 = Color3.new(0.3764705882352941, 0.3764705882352941, 0.3764705882352941)
                    frame2.BorderSizePixel = 0
                    frame2.Size = UDim2.new(1, 0, 0, 1)
                    frame2.Position = UDim2.new(0, 0, (i - 1) / 4, 0)
                    frame2.Parent = numberLineOutlines
                end
                local frame3 = Instance.new('Frame')
                frame3.BackgroundColor3 = Color3.new(0, 0, 0)
                frame3.BorderSizePixel = 0
                frame3.Size = UDim2.new(0, 1, 0, 1)
                local frame4 = Instance.new('Frame')
                frame4.BackgroundColor3 = Color3.new(0, 0, 0)
                frame4.BorderSizePixel = 0
                frame4.Size = UDim2.new(0, 1, 0, 0)
                for i = 1, numberLine.AbsoluteSize.X do
                    local clone = frame4:Clone()
                    list2[i] = clone
                    clone.Name = 'E' .. tostring(i)
                    clone.BackgroundTransparency = 0.5
                    clone.BackgroundColor3 = Color3.new(0.7803921568627451, 0.17254901960784313, 0.10980392156862745)
                    clone.Position = UDim2.new(0, i - 1, 0, 0)
                    clone.Parent = numberLine
                end
                for i = 1, numberLine.AbsoluteSize.X do
                    local clone2 = frame4:Clone()
                    list[i] = clone2
                    clone2.Name = tostring(i)
                    clone2.Position = UDim2.new(0, i - 1, 0, 0)
                    clone2.Parent = numberLine
                end
                local frame5 = Instance.new('Frame')
                frame5.BackgroundTransparency = 1
                frame5.BackgroundColor3 = Color3.new(0, 0, 0)
                frame5.BorderSizePixel = 0
                frame5.Size = UDim2.new(0, 7, 0, 20)
                frame5.Visible = false
                frame5.ZIndex = 2
                local frame6 = Instance.new('Frame', frame5)
                frame6.Name = 'Line'
                frame6.BackgroundColor3 = Color3.new(0, 0, 0)
                frame6.BorderSizePixel = 0
                frame6.Position = UDim2.new(0, 3, 0, 0)
                frame6.Size = UDim2.new(0, 1, 0, 20)
                frame6.ZIndex = 2
                local clone3, clone4 = frame5:Clone(), frame5:Clone()
                clone3.Parent = numberLine
                clone4.Parent = numberLine
                local function buildSequence()
                    local list = {}
                    for _, v in pairs(map) do
                        table.insert(list, NumberSequenceKeypoint.new(v[2], v[1], v[3]))
                    end
                    object2.Sequence = NumberSequence.new(list)
                    object2.OnSelect:Fire(object2.Sequence)
                end
                local function round(number, arg2)
                    local v1 = 10 ^ arg2
                    return math.floor(number * v1 + 0.5) / v1
                end
                local function updateInputs(list)
                    if list then
                        list3 = list
                        local second = list[2]
                        local first = list[1]
                        local third = list[3]
                        input.Text = round(second, second < 0.01 and 5 or second < 0.1 and 4 or 3)
                        input2.Text = round(first, first < 0.01 and 5 or first < 0.1 and 4 or first < 1 and 3 or 2)
                        input3.Text = round(third, third < 0.01 and 5 or third < 0.1 and 4 or first < 1 and 3 or 2)
                        local v1 = numberLine.AbsoluteSize.Y * (list[3] / 10)
                        clone3.Position = UDim2.new(0, list[4].Position.X.Offset - 1, 0, list[4].Position.Y.Offset - v1 - 17)
                        clone3.Visible = true
                        clone4.Position = UDim2.new(0, list[4].Position.X.Offset - 1, 0, list[4].Position.Y.Offset + v1 + 2)
                        clone4.Visible = true
                    end
                end
                clone3.InputBegan:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not list3 or object.CheckMouseInGui(list3[4].Select) then
                        return
                    end
                    local connection
                    local connection2
                    local y = numberLine.AbsoluteSize.Y
                    local abs = math.abs(clone3.AbsolutePosition.Y - mouse.Y)
                    clone3.Line.Position = UDim2.new(0, 2, 0, 0)
                    clone3.Line.Size = UDim2.new(0, 3, 0, 20)
                    connection2 = result.InputEnded:Connect(function(input)
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                            return
                        end
                        connection:Disconnect()
                        connection2:Disconnect()
                        clone3.Line.Position = UDim2.new(0, 3, 0, 0)
                        clone3.Line.Size = UDim2.new(0, 1, 0, 20)
                    end)
                    connection = result.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            local a = list3[4].AbsolutePosition.Y + 2 - (mouse.Y - abs) - 19
                            local a2 = 10 * (math.max(a, 0) / y)
                            local min = math.min(list3[1], 10 - list3[1])
                            list3[3] = math.min(a2, min)
                            object2:Redraw()
                            buildSequence()
                            updateInputs(list3)
                        end
                    end)
                end)
                clone4.InputBegan:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not list3 or object.CheckMouseInGui(list3[4].Select) then
                        return
                    end
                    local connection
                    local connection2
                    local y = numberLine.AbsoluteSize.Y
                    local abs = math.abs(clone4.AbsolutePosition.Y - mouse.Y)
                    clone4.Line.Position = UDim2.new(0, 2, 0, 0)
                    clone4.Line.Size = UDim2.new(0, 3, 0, 20)
                    connection2 = result.InputEnded:Connect(function(input)
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                            return
                        end
                        connection:Disconnect()
                        connection2:Disconnect()
                        clone4.Line.Position = UDim2.new(0, 3, 0, 0)
                        clone4.Line.Size = UDim2.new(0, 1, 0, 20)
                    end)
                    connection = result.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            local a = mouse.Y + (20 - abs) - (list3[4].AbsolutePosition.Y + 2) - 19
                            local a2 = 10 * (math.max(a, 0) / y)
                            local min = math.min(list3[1], 10 - list3[1])
                            list3[3] = math.min(a2, min)
                            object2:Redraw()
                            buildSequence()
                            updateInputs(list3)
                        end
                    end)
                end)
                local function placePoint(list)
                    local frame = Instance.new('Frame')
                    frame.Name = 'Point'
                    frame.BorderSizePixel = 0
                    frame.Size = UDim2.new(0, 5, 0, 5)
                    frame.Position = UDim2.new(0, math.floor((numberLine.AbsoluteSize.X - 1) * list[2]) - 2, 0, numberLine.AbsoluteSize.Y * (10 - list[1]) / 10 - 2)
                    frame.BackgroundColor3 = Color3.new(0, 0, 0)
                    local frame2 = Instance.new('Frame')
                    frame2.Name = 'Select'
                    frame2.BackgroundTransparency = 1
                    frame2.BackgroundColor3 = Color3.new(0.7803921568627451, 0.17254901960784313, 0.10980392156862745)
                    frame2.Position = UDim2.new(0, -2, 0, -2)
                    frame2.Size = UDim2.new(0, 9, 0, 9)
                    frame2.Parent = frame
                    frame.Parent = numberLine
                    frame2.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            for _, v in pairs(map) do
                                v[4].Select.BackgroundTransparency = 1
                            end
                            frame2.BackgroundTransparency = 0
                            updateInputs(list)
                        end
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and not v2 then
                            list3 = list
                            local connection
                            local connection2
                            v2 = true
                            frame2.BackgroundColor3 = Color3.new(0.9764705882352941, 0.7490196078431373, 0.23137254901960785)
                            local third = list[3]
                            connection2 = result.InputEnded:Connect(function(input)
                                if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                                    return
                                end
                                connection:Disconnect()
                                connection2:Disconnect()
                                v2 = nil
                                frame2.BackgroundColor3 = Color3.new(0.7803921568627451, 0.17254901960784313, 0.10980392156862745)
                            end)
                            connection = result.InputChanged:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseMovement then
                                    local v2 = numberLine.AbsoluteSize.X - 1
                                    local num = mouse.X - numberLine.AbsolutePosition.X
                                    if num < 0 then
                                        num = 0
                                    end
                                    if v2 < num then
                                        num = v2
                                    end
                                    local v3 = numberLine.AbsoluteSize.Y - 1
                                    local num2 = mouse.Y - numberLine.AbsolutePosition.Y
                                    if num2 < 0 then
                                        num2 = 0
                                    end
                                    if v3 < num2 then
                                        num2 = v3
                                    end
                                    if list ~= first and list ~= v1 then
                                        list[2] = num / v2
                                    end
                                    list[1] = 10 - num2 / v3 * 10
                                    local min = math.min(list[1], 10 - list[1])
                                    list[3] = math.min(third, min)
                                    object2:Redraw()
                                    updateInputs(list)
                                    for _, v in pairs(map) do
                                        v[4].Select.BackgroundTransparency = 1
                                    end
                                    frame2.BackgroundTransparency = 0
                                    buildSequence()
                                end
                            end)
                        end
                    end)
                    return frame
                end
                local function placePoints()
                    for _, v in pairs(map) do
                        v[4] = placePoint(v)
                    end
                end
                local function redraw(arg1)
                    local absoluteSize = numberLine.AbsoluteSize
                    table.sort(map, function(a, b)
                        return a[2] < b[2]
                    end)
                    for _, v in pairs(map) do
                        v[4].Position = UDim2.new(0, math.floor((absoluteSize.X - 1) * v[2]) - 2, 0, (absoluteSize.Y - 1) * (10 - v[1]) / 10 - 2)
                    end
                    list[1].Size = UDim2.new(0, 1, 0, 0)
                    for i = 1, #map - 1 do
                        local list3 = map[i]
                        local list4 = map[i + 1]
                        local v1 = list4[4].Position.Y.Offset - list3[4].Position.Y.Offset
                        local v2 = list4[4].Position.X.Offset - list3[4].Position.X.Offset
                        local value = v1 / v2
                        local third = list3[3]
                        local third2 = list4[3]
                        local abs = math.abs(value)
                        local total = 0
                        local abs2 = math.abs(list4[4].Position.Y.Offset - list3[4].Position.Y.Offset)
                        for j = math.min(list3[4].Position.X.Offset + 1, list4[4].Position.X.Offset), list4[4].Position.X.Offset do
                            if v2 == 0 and v1 == 0 then
                                return
                            end
                            local floored = math.floor(abs)
                            local v3 = list[j + 3]
                            if v3 then
                                if abs2 < total + floored then
                                    floored = abs2 - total
                                end
                                if math.sign(value) == -1 then
                                    v3.Position = UDim2.new(0, j + 2, 0, list3[4].Position.Y.Offset + -(total + floored) + 2)
                                else
                                    v3.Position = UDim2.new(0, j + 2, 0, list3[4].Position.Y.Offset + total + 2)
                                end
                                v3.Size = UDim2.new(0, 1, 0, math.max(floored, 1))
                            end
                            total += floored
                            abs = abs - floored + math.abs(value)
                            local v4 = (j - list3[4].Position.X.Offset) / (list4[4].Position.X.Offset - list3[4].Position.X.Offset)
                            local v5 = third + (third2 - third) * v4
                            local value2 = v5 / 10 * absoluteSize.Y
                            local v6 = list2[j + 3]
                            if not v6 then
                                continue
                            end
                            v6.Position = UDim2.new(0, j + 2, 0, list[j + 3].Position.Y.Offset - math.floor(value2))
                            v6.Size = UDim2.new(0, 1, 0, math.floor(value2 * 2))
                        end
                    end
                end
                object2.Redraw = redraw
                local function loadSequence(arg1, arg2)
                    v3 = arg2
                    for _, v in pairs(map) do
                        if not v[4] then
                            continue
                        end
                        v[4]:Destroy()
                    end
                    map = {}
                    for _, keypoint in pairs(arg2.Keypoints) do
                        local min = math.min(keypoint.Value, 10 - keypoint.Value)
                        local item = {keypoint.Value, keypoint.Time, math.min(keypoint.Envelope, min)}
                        item[4] = placePoint(item)
                        table.insert(map, item)
                    end
                    first = map[1]
                    v1 = map[#map]
                    v2 = nil
                    redraw()
                    clone3.Visible = false
                    clone4.Visible = false
                end
                object2.SetSequence = loadSequence
                input.FocusLost:Connect(function()
                    local list = list3
                    local number = tonumber(input.Text)
                    if list and number and list ~= first and list ~= v1 then
                        number = math.clamp(number, 0, 1)
                        list[2] = number
                        redraw()
                        buildSequence()
                        updateInputs(list)
                    end
                end)
                input2.FocusLost:Connect(function()
                    local list = list3
                    local number = tonumber(input2.Text)
                    if list and number then
                        local third = list[3]
                        number = math.clamp(number, 0, 10)
                        list[1] = number
                        local min = math.min(list[1], 10 - list[1])
                        list[3] = math.min(third, min)
                        redraw()
                        buildSequence()
                        updateInputs(list)
                    end
                end)
                input3.FocusLost:Connect(function()
                    local list = list3
                    local number = tonumber(input3.Text)
                    if list and number then
                        number = math.clamp(number, 0, 5)
                        local min = math.min(list[1], 10 - list[1])
                        list[3] = math.min(number, min)
                        redraw()
                        buildSequence()
                        updateInputs(list)
                    end
                end)
                local function buttonAnimations(userInputService, arg2)
                    userInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            userInputService.BackgroundTransparency = arg2 and 0.5 or 0.4
                        end
                    end)
                    userInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            userInputService.BackgroundTransparency = arg2 and 1 or 0
                        end
                    end)
                end
                numberLine.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and #map < 20 then
                        if object.CheckMouseInGui(clone3) or object.CheckMouseInGui(clone4) then
                            return
                        end
                        for _, v in pairs(map) do
                            if not object.CheckMouseInGui(v[4].Select) then
                                continue
                            end
                            return
                        end
                        local v1 = numberLine.AbsoluteSize.X - 1
                        local num = mouse.X - numberLine.AbsolutePosition.X
                        if num < 0 then
                            num = 0
                        end
                        if v1 < num then
                            num = v1
                        end
                        local v2 = numberLine.AbsoluteSize.Y - 1
                        local num2 = mouse.Y - numberLine.AbsolutePosition.Y
                        if num2 < 0 then
                            num2 = 0
                        end
                        if v2 < num2 then
                            num2 = v2
                        end
                        local v3 = num / v1
                        local item = {10 - num2 / v2 * 10, v3, 0}
                        item[4] = placePoint(item)
                        table.insert(map, item)
                        redraw()
                        buildSequence()
                    end
                end)
                delete.MouseButton1Click:Connect(function()
                    if list3 and list3 ~= first and list3 ~= v1 then
                        for k, v in pairs(map) do
                            if v ~= list3 then
                                continue
                            end
                            v[4]:Destroy()
                            table.remove(map, k)
                            break
                        end
                        v2 = nil
                        redraw()
                        buildSequence()
                        updateInputs(map[1])
                    end
                end)
                reset.MouseButton1Click:Connect(function()
                    if v3 then
                        object2:SetSequence(v3)
                        buildSequence()
                    end
                end)
                close.MouseButton1Click:Connect(function()
                    window:Close()
                end)
                buttonAnimations(delete)
                buttonAnimations(reset)
                buttonAnimations(close)
                placePoints()
                redraw()
                function object2.Show(arg1)
                    window:Show()
                end
                return object2
            end}
        end)()
        object.ColorSequenceEditor = (function()
            return {new = function()
                local object2 = setmetatable({}, {})
                object2.OnSelect = object.Signal.new()
                object2.OnCancel = object.Signal.new()
                object2.OnPreview = object.Signal.new()
                object2.OnPickColor = object.Signal.new()
                local parent = callback2({{1, 'Frame', {BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderSizePixel = 0, ClipsDescendants = true, Name = 'Content', Position = UDim2.new(0, 0, 0, 20), Size = UDim2.new(1, 0, 1, -20)}}, {2, 'Frame', {BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), Name = 'ColorLine', Parent = {1}, Position = UDim2.new(0, 10, 0, 5), Size = UDim2.new(1, -20, 0, 70)}}, {3, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Name = 'Gradient', Parent = {2}, Size = UDim2.new(1, 0, 1, 0)}}, {4, 'UIGradient', {Parent = {3}}}, {5, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Name = 'Arrows', Parent = {1}, Position = UDim2.new(0, 1, 0, 73), Size = UDim2.new(1, -2, 0, 16)}}, {6, 'Frame', {BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Name = 'Cursor', Parent = {1}, Position = UDim2.new(0, 10, 0, 0), Size = UDim2.new(0, 1, 0, 80)}}, {7, 'Frame', {BackgroundColor3 = Color3.new(0.14901961386204, 0.14901961386204, 0.14901961386204), BorderColor3 = Color3.new(0.12549020349979, 0.12549020349979, 0.12549020349979), Name = 'Time', Parent = {1}, Position = UDim2.new(0, 40, 0, 95), Size = UDim2.new(0, 100, 0, 20)}}, {8, 'TextBox', {BackgroundColor3 = Color3.new(0.25098040699959, 0.25098040699959, 0.25098040699959), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.37647062540054, 0.37647062540054, 0.37647062540054), ClipsDescendants = true, Font = 3, Name = 'Input', Parent = {7}, Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 98, 0, 20), Text = '0', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 0}}, {9, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {7}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Time', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {10, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), Name = 'ColorBox', Parent = {1}, Position = UDim2.new(0, 220, 0, 95), Size = UDim2.new(0, 20, 0, 20)}}, {11, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Title', Parent = {10}, Position = UDim2.new(0, -40, 0, 0), Size = UDim2.new(0, 34, 1, 0), Text = 'Color', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14, TextXAlignment = 1}}, {12, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), BorderSizePixel = 0, Font = 3, Name = 'Close', Parent = {1}, Position = UDim2.new(1, -90, 0, 95), Size = UDim2.new(0, 80, 0, 20), Text = 'Close', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14}}, {13, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), BorderSizePixel = 0, Font = 3, Name = 'Reset', Parent = {1}, Position = UDim2.new(1, -180, 0, 95), Size = UDim2.new(0, 80, 0, 20), Text = 'Reset', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14}}, {14, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderColor3 = Color3.new(0.21568627655506, 0.21568627655506, 0.21568627655506), BorderSizePixel = 0, Font = 3, Name = 'Delete', Parent = {1}, Position = UDim2.new(0, 280, 0, 95), Size = UDim2.new(0, 80, 0, 20), Text = 'Delete', TextColor3 = Color3.new(0.86274516582489, 0.86274516582489, 0.86274516582489), TextSize = 14}}, {15, 'Frame', {BackgroundTransparency = 1, Name = 'Arrow', Parent = {1}, Size = UDim2.new(0, 16, 0, 16), Visible = false}}, {16, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {15}, Position = UDim2.new(0, 8, 0, 3), Size = UDim2.new(0, 1, 0, 2)}}, {17, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {15}, Position = UDim2.new(0, 7, 0, 5), Size = UDim2.new(0, 3, 0, 2)}}, {18, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {15}, Position = UDim2.new(0, 6, 0, 7), Size = UDim2.new(0, 5, 0, 2)}}, {19, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {15}, Position = UDim2.new(0, 5, 0, 9), Size = UDim2.new(0, 7, 0, 2)}}, {20, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {15}, Position = UDim2.new(0, 4, 0, 11), Size = UDim2.new(0, 9, 0, 2)}}})
                local window = object.Window.new()
                window.Resizable = false
                window:Resize(650, 150)
                window:SetTitle('ColorSequence Editor')
                object2.Window = window
                object2.Gui = window.Gui
                for _, child in pairs(parent:GetChildren()) do
                    child.Parent = window.GuiElems.Content
                end
                local gui = window.Gui
                local main = gui.Main
                local topBar = main.TopBar
                local content = main.Content
                local colorLine = content.ColorLine
                local uiGradient = colorLine.Gradient.UIGradient
                local arrows = content.Arrows
                local arrow = content.Arrow
                local cursor = content.Cursor
                local input = content.Time.Input
                local colorBox = content.ColorBox
                local delete = content.Delete
                local reset = content.Reset
                local close = content.Close
                local close2 = topBar.Close
                local result = callback(game:GetService('UserInputService'))
                local mouse = callback(game:GetService('Players')).LocalPlayer:GetMouse()
                local list = {{Color3.new(1, 0, 1), 0}, {Color3.new(0.2, 0.9, 0.2), 0.2}, {Color3.new(0.4, 0.5, 0.9), 0.7}, {Color3.new(0.6, 1, 1), 1}}
                local v1
                local first = list[1]
                local v2 = list[#list]
                local v3
                local list2
                local frame = Instance.new('Frame')
                frame.BorderSizePixel = 0
                frame.Size = UDim2.new(0, 1, 1, 0)
                object2.Sequence = ColorSequence.new(Color3.new(1, 1, 1))
                local function buildSequence(arg1)
                    local list2 = {}
                    table.sort(list, function(a, b)
                        return a[2] < b[2]
                    end)
                    for _, v in pairs(list) do
                        table.insert(list2, ColorSequenceKeypoint.new(v[2], v[1]))
                    end
                    object2.Sequence = ColorSequence.new(list2)
                    if not arg1 then
                        object2.OnSelect:Fire(object2.Sequence)
                    end
                end
                local function round(number, arg2)
                    local v1 = 10 ^ arg2
                    return math.floor(number * v1 + 0.5) / v1
                end
                local function updateInputs(list)
                    if list then
                        list2 = list
                        local second = list[2]
                        input.Text = round(second, second < 0.01 and 5 or second < 0.1 and 4 or 3)
                        colorBox.BackgroundColor3 = list[1]
                    end
                end
                local function placeArrow(number, list)
                    local clone = arrow:Clone()
                    clone.Position = UDim2.new(0, number - 1, 0, 0)
                    clone.Visible = true
                    clone.Parent = arrows
                    clone.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            cursor.Visible = true
                            cursor.Position = UDim2.new(0, 9 + clone.Position.X.Offset, 0, 0)
                        end
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            updateInputs(list)
                            if list == first or list == v2 or v3 then
                                return
                            end
                            local connection
                            local connection2
                            v3 = true
                            connection2 = result.InputEnded:Connect(function(input)
                                if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                                    return
                                end
                                connection:Disconnect()
                                connection2:Disconnect()
                                v3 = nil
                                cursor.Visible = false
                            end)
                            connection = result.InputChanged:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseMovement then
                                    local v1 = colorLine.AbsoluteSize.X - 1
                                    local num = mouse.X - colorLine.AbsolutePosition.X
                                    if num < 0 then
                                        num = 0
                                    end
                                    if v1 < num then
                                        num = v1
                                    end
                                    list[2] = num / v1
                                    updateInputs(list)
                                    cursor.Visible = true
                                    cursor.Position = UDim2.new(0, 9 + clone.Position.X.Offset, 0, 0)
                                    buildSequence()
                                    object2:Redraw()
                                end
                            end)
                        end
                    end)
                    clone.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            cursor.Visible = false
                        end
                    end)
                    return clone
                end
                local function placeArrows()
                    for _, v in pairs(list) do
                        v[3] = placeArrow(math.floor((colorLine.AbsoluteSize.X - 1) * v[2]) + 1, v)
                    end
                end
                local function redraw(arg1)
                    uiGradient.Color = object2.Sequence or ColorSequence.new(Color3.new(1, 1, 1))
                    for i = 2, #list do
                        local list2 = list[i]
                        local xOffset = math.floor((colorLine.AbsoluteSize.X - 1) * list2[2]) + 1
                        list2[3].Position = UDim2.new(0, xOffset, 0, 0)
                    end
                end
                object2.Redraw = redraw
                local function loadSequence(arg1, arg2)
                    v1 = arg2
                    for _, v in pairs(list) do
                        if not v[3] then
                            continue
                        end
                        v[3]:Destroy()
                    end
                    list = {}
                    v3 = nil
                    for _, keypoint in pairs(arg2.Keypoints) do
                        local item = {keypoint.Value, keypoint.Time}
                        item[3] = placeArrow(keypoint.Time, item)
                        table.insert(list, item)
                    end
                    first = list[1]
                    v2 = list[#list]
                    v3 = nil
                    updateInputs(list[1])
                    buildSequence(true)
                    redraw()
                end
                object2.SetSequence = loadSequence
                local function buttonAnimations(userInputService, arg2)
                    userInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            userInputService.BackgroundTransparency = arg2 and 0.5 or 0.4
                        end
                    end)
                    userInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            userInputService.BackgroundTransparency = arg2 and 1 or 0
                        end
                    end)
                end
                colorLine.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and #list < 20 then
                        local v1 = colorLine.AbsoluteSize.X - 1
                        local num = mouse.X - colorLine.AbsolutePosition.X
                        if num < 0 then
                            num = 0
                        end
                        if v1 < num then
                            num = v1
                        end
                        local v2 = num / v1
                        local list2
                        local list3
                        for k, v in pairs(list) do
                            if v2 <= v[2] then
                                list2 = list[math.max(k - 1, 1)]
                                list3 = list[k]
                                break
                            end
                        end
                        local result = list2[1]:lerp(list3[1], (v2 - list2[2]) / (list3[2] - list2[2]))
                        local item = {result, v2}
                        item[3] = placeArrow(item[2], item)
                        table.insert(list, item)
                        updateInputs(item)
                        buildSequence()
                        redraw()
                    end
                end)
                colorLine.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        local v1 = colorLine.AbsoluteSize.X - 1
                        local num = mouse.X - colorLine.AbsolutePosition.X
                        if num < 0 then
                            num = 0
                        end
                        if v1 < num then
                            num = v1
                        end
                        cursor.Visible = true
                        cursor.Position = UDim2.new(0, 10 + num, 0, 0)
                    end
                end)
                colorLine.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        local third = false
                        for _, v in pairs(list) do
                            if not object.CheckMouseInGui(v[3]) then
                                continue
                            end
                            third = v[3]
                        end
                        cursor.Visible = third and true or false
                        if third then
                            cursor.Position = UDim2.new(0, 9 + third.Position.X.Offset, 0, 0)
                        end
                    end
                end)
                input:GetPropertyChangedSignal('Text'):Connect(function()
                    local list = list2
                    local number = tonumber(input.Text)
                    if list and number and list ~= first and list ~= v2 then
                        number = math.clamp(number, 0, 1)
                        list[2] = number
                        buildSequence()
                        redraw()
                    end
                end)
                colorBox.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local colorPicker = object2.ColorPicker
                        if not colorPicker then
                            colorPicker = object.ColorPicker.new()
                            colorPicker.Window:SetTitle('ColorSequence Color Picker')
                            colorPicker.OnSelect:Connect(function(arg1)
                                if list2 then
                                    list2[1] = arg1
                                end
                                buildSequence()
                                redraw()
                            end)
                            object2.ColorPicker = colorPicker
                        end
                        colorPicker.Window:ShowAndFocus()
                    end
                end)
                delete.MouseButton1Click:Connect(function()
                    if list2 and list2 ~= first and list2 ~= v2 then
                        for k, v in pairs(list) do
                            if v ~= list2 then
                                continue
                            end
                            v[3]:Destroy()
                            table.remove(list, k)
                            break
                        end
                        v3 = nil
                        updateInputs(list[1])
                        buildSequence()
                        redraw()
                    end
                end)
                reset.MouseButton1Click:Connect(function()
                    if v1 then
                        object2:SetSequence(v1)
                    end
                end)
                close.MouseButton1Click:Connect(function()
                    window:Close()
                end)
                close2.MouseButton1Click:Connect(function()
                    window:Close()
                end)
                buttonAnimations(delete)
                buttonAnimations(reset)
                buttonAnimations(close)
                placeArrows()
                redraw()
                function object2.Show(arg1)
                    window:Show()
                end
                return object2
            end}
        end)()
        object.ViewportTextBox = (function()
            local result = callback(game:GetService('TextService'))
            local data = {OffsetX = 0, TextBox = textBox, CursorPos = -1, Gui = textBox, View = textBox}
            local data2 = {Update = function(number)
                local cursorPos = number.CursorPos or -1
                local text = number.TextBox.Text
                if text == '' then
                    number.TextBox.Position = UDim2.new(0, 0, 0, 0)
                    return
                elseif cursorPos == -1 then
                    return
                else
                    local result2 = text:sub(1, cursorPos - 1)
                    local xOffset
                    local v1 = -number.TextBox.Position.X.Offset
                    local v2 = v1 + number.View.AbsoluteSize.X
                    local x = result:GetTextSize(text, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X
                    xOffset = if v2 < result:GetTextSize(result2, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X then math.max(-1, result:GetTextSize(result2, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X - number.View.AbsoluteSize.X + 2) else if result:GetTextSize(result2, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X >= v1 then if x >= v2 then math.max(-1, result:GetTextSize(result2, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X - number.View.AbsoluteSize.X + 2) else math.max(-1, x - number.View.AbsoluteSize.X + 2) else math.max(-1, result:GetTextSize(result2, number.TextBox.TextSize, number.TextBox.Font, Vector2.new(999999999, 100)).X - 2)
                    if xOffset then
                        number.TextBox.Position = UDim2.new(0, -xOffset, 0, 0)
                        number.TextBox.Size = UDim2.new(1, xOffset, 1, 0)
                    end
                end
            end, GetText = function(self)
                return self.TextBox.Text
            end, SetText = function(self, text)
                self.TextBox.Text = text
            end}
            local guiMT = getGuiMT(data, data2)
            local function convert(textBox)
                local result = initObj(data, guiMT)
                local frame = Instance.new('Frame')
                frame.BackgroundTransparency = textBox.BackgroundTransparency
                frame.BackgroundColor3 = textBox.BackgroundColor3
                frame.BorderSizePixel = textBox.BorderSizePixel
                frame.BorderColor3 = textBox.BorderColor3
                frame.Position = textBox.Position
                frame.Size = textBox.Size
                frame.ClipsDescendants = true
                frame.Name = textBox.Name
                textBox.BackgroundTransparency = 1
                textBox.Position = UDim2.new(0, 0, 0, 0)
                textBox.Size = UDim2.new(1, 0, 1, 0)
                textBox.TextXAlignment = Enum.TextXAlignment.Left
                textBox.Name = 'Input'
                result.TextBox = textBox
                result.View = frame
                result.Gui = frame
                textBox.Changed:Connect(function(value)
                    if value == 'Text' or value == 'CursorPosition' or value == 'AbsoluteSize' then
                        local cursorPosition = result.TextBox.CursorPosition
                        if cursorPosition ~= -1 then
                            result.CursorPos = cursorPosition
                        end
                        result:Update()
                    end
                end)
                result:Update()
                frame.Parent = textBox.Parent
                textBox.Parent = frame
                return result
            end
            return {new = function()
                local textBox = Instance.new('TextBox')
                textBox.Size = UDim2.new(0, 100, 0, 20)
                textBox.BackgroundColor3 = v4.Theme.TextBox
                textBox.BorderColor3 = v4.Theme.Outline3
                textBox.ClearTextOnFocus = false
                textBox.TextColor3 = v4.Theme.Text
                textBox.Font = Enum.Font.SourceSans
                textBox.TextSize = 14
                textBox.Text = ''
                return convert(textBox)
            end, convert = convert}
        end)()
        object.Label = (function()
            local tbl = {}
            local tbl2 = {}
            local guiMT = getGuiMT(tbl, tbl2)
            return {new = function()
                local textLabel = Instance.new('TextLabel')
                textLabel.BackgroundTransparency = 1
                textLabel.TextXAlignment = Enum.TextXAlignment.Left
                textLabel.TextColor3 = v4.Theme.Text
                textLabel.TextTransparency = 0.1
                textLabel.Size = UDim2.new(0, 100, 0, 20)
                textLabel.Font = Enum.Font.SourceSans
                textLabel.TextSize = 14
                return (setmetatable({Gui = textLabel}, guiMT))
            end}
        end)()
        object.Frame = (function()
            local tbl = {}
            local tbl2 = {}
            local guiMT = getGuiMT(tbl, tbl2)
            return {new = function()
                local frame = Instance.new('Frame')
                frame.BackgroundColor3 = v4.Theme.Main1
                frame.BorderColor3 = v4.Theme.Outline1
                frame.Size = UDim2.new(0, 50, 0, 50)
                return (setmetatable({Gui = frame}, guiMT))
            end}
        end)()
        object.Button = (function()
            local data = {Gui = textBox, Anim = textBox, Disabled = false, OnClick = onClick, OnDown = onClick, OnUp = onClick, AllowedButtons = {1}}
            local object2 = {}
            local find = table.find
            function object2:Trigger(text, arg3)
                if not self.Disabled and find(self.AllowedButtons, arg3) then
                    self['On' .. text]:Fire(arg3)
                end
            end
            function object2:SetDisabled(disabled)
                self.Disabled = disabled
                if disabled then
                    self.Anim:Disable()
                    self.Gui.TextTransparency = 0.5
                    return
                end
                self.Anim.Enable()
                self.Gui.TextTransparency = 0
            end
            local guiMT = getGuiMT(data, object2)
            return {new = function()
                local textButton = Instance.new('TextButton')
                textButton.AutoButtonColor = false
                textButton.TextColor3 = v4.Theme.Text
                textButton.TextTransparency = 0.1
                textButton.Size = UDim2.new(0, 100, 0, 20)
                textButton.Font = Enum.Font.SourceSans
                textButton.TextSize = 14
                textButton.BackgroundColor3 = v4.Theme.Button
                textButton.BorderColor3 = v4.Theme.Outline2
                local result = initObj(data, guiMT)
                result.Gui = textButton
                result.Anim = object.ButtonAnim(textButton, {Mode = 2, StartColor = v4.Theme.Button, HoverColor = v4.Theme.ButtonHover, PressColor = v4.Theme.ButtonPress, OutlineColor = v4.Theme.Outline2})
                textButton.MouseButton1Click:Connect(function()
                    result:Trigger('Click', 1)
                end)
                textButton.MouseButton1Down:Connect(function()
                    result:Trigger('Down', 1)
                end)
                textButton.MouseButton1Up:Connect(function()
                    result:Trigger('Up', 1)
                end)
                textButton.MouseButton2Click:Connect(function()
                    result:Trigger('Click', 2)
                end)
                textButton.MouseButton2Down:Connect(function()
                    result:Trigger('Down', 2)
                end)
                textButton.MouseButton2Up:Connect(function()
                    result:Trigger('Up', 2)
                end)
                return result
            end}
        end)()
        object.DropDown = (function()
            local data = {Gui = textBox, Anim = textBox, Context = textBox, Selected = textBox, Disabled = false, CanBeEmpty = true, Options = {}, GuiElems = {}, OnSelect = onClick}
            local data2 = {Update = function(self)
                local options = self.Options
                if #options > 0 then
                    if not self.Selected then
                        if not self.CanBeEmpty then
                            self.Selected = options[1]
                            self.GuiElems.Label.Text = options[1]
                            return
                        end
                        self.GuiElems.Label.Text = '- Select -'
                        return
                    end
                    self.GuiElems.Label.Text = self.Selected
                    return
                end
                self.GuiElems.Label.Text = '- Select -'
            end, ShowOptions = function(self)
                local context = self.Context
                context.Width = self.Gui.AbsoluteSize.X
                context.ReverseYOffset = self.Gui.AbsoluteSize.Y
                context:Show(self.Gui.AbsolutePosition.X, self.Gui.AbsolutePosition.Y + context.ReverseYOffset)
            end, SetOptions = function(self, options)
                self.Options = options
                local context = self.Context
                local options2 = self.Options
                context:Clear()
                local function onClick(selected)
                    self.Selected = selected
                    self.OnSelect:Fire(selected)
                    self:Update()
                end
                if self.CanBeEmpty then
                    context:Add({Name = '- Select -', OnClick = function()
                        self.Selected = nil
                        self.OnSelect:Fire(nil)
                        self:Update()
                    end})
                end
                for i = 1, #options2 do
                    context:Add({Name = options2[i], OnClick = onClick})
                end
                self:Update()
            end, SetSelected = function(self, value)
                self.Selected = type(value) == 'number' and self.Options[value] or value
                self:Update()
            end}
            local guiMT = getGuiMT(data, data2)
            return {new = function()
                local textButton = Instance.new('TextButton')
                textButton.AutoButtonColor = false
                textButton.Text = ''
                textButton.Size = UDim2.new(0, 100, 0, 20)
                textButton.BackgroundColor3 = v4.Theme.TextBox
                textButton.BorderColor3 = v4.Theme.Outline3
                local label = object.Label.new()
                label.Position = UDim2.new(0, 2, 0, 0)
                label.Size = UDim2.new(1, -22, 1, 0)
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = textButton
                local result = callback2({{1, 'Frame', {BackgroundTransparency = 1, Name = 'EnumArrow', Position = UDim2.new(1, -16, 0, 2), Size = UDim2.new(0, 16, 0, 16)}}, {2, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {1}, Position = UDim2.new(0, 8, 0, 9), Size = UDim2.new(0, 1, 0, 1)}}, {3, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {1}, Position = UDim2.new(0, 7, 0, 8), Size = UDim2.new(0, 3, 0, 1)}}, {4, 'Frame', {BackgroundColor3 = Color3.new(0.86274510622025, 0.86274510622025, 0.86274510622025), BorderSizePixel = 0, Parent = {1}, Position = UDim2.new(0, 6, 0, 7), Size = UDim2.new(0, 5, 0, 1)}}})
                result.Parent = textButton
                local result2 = initObj(data, guiMT)
                result2.Gui = textButton
                result2.Anim = object.ButtonAnim(textButton, {Mode = 2, StartColor = v4.Theme.TextBox, LerpTo = v4.Theme.Button, LerpDelta = 0.15})
                result2.Context = object.ContextMenu.new()
                result2.Context.Iconless = true
                result2.Context.MaxHeight = 200
                result2.Selected = nil
                result2.GuiElems = {Label = label}
                textButton.MouseButton1Down:Connect(function()
                    result2:ShowOptions()
                end)
                result2:Update()
                return result2
            end}
        end)()
        object.ClickSystem = (function()
            local data = {LastItem = textBox, OnDown = onClick, OnRelease = onClick, AllowedButtons = {1}, Combo = 0, MaxCombo = 2, ComboTime = 0.5, Items = {}, ItemCons = {}, ClickId = -1, LastButton = ''}
            local object2 = {}
            local tostring, handler = tostring, function(value)
                local index = table.find(value.Signal.Connections, value)
                if index then
                    table.remove(value.Signal.Connections, index)
                end
            end
            function object2:Trigger(lastItem, lastButton)
                if table.find(self.AllowedButtons, lastButton) then
                    if self.LastButton ~= lastButton or self.LastItem ~= lastItem or self.Combo == self.MaxCombo or tick() - self.ClickId > self.ComboTime then
                        self.Combo = 0
                        self.LastButton = lastButton
                        self.LastItem = lastItem
                    end
                    self.Combo = self.Combo + 1
                    self.ClickId = tick()
                    local connection
                    connection = v12.UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType['MouseButton' .. lastButton] then
                            connection:Disconnect()
                            if object.CheckMouseInGui(lastItem) and self.LastButton == lastButton and self.LastItem == lastItem then
                                self.OnRelease:Fire(lastItem, self.Combo, lastButton)
                            end
                        end
                    end)
                    self.OnDown:Fire(lastItem, self.Combo, lastButton)
                end
            end
            function object2.Add(list, value)
                if table.find(list.Items, value) then
                    return
                end
                local data = {[1] = value.MouseButton1Down:Connect(function()
                    list:Trigger(value, 1)
                end), [2] = value.MouseButton2Down:Connect(function()
                    list:Trigger(value, 2)
                end)}
                list.ItemCons[value] = data
                list.Items[#list.Items + 1] = value
            end
            function object2:Remove(value)
                local index = table.find(self.Items, value)
                if not index then
                    return
                end
                for _, v in pairs(self.ItemCons[value]) do
                    v:Disconnect()
                end
                self.ItemCons[value] = nil
                table.remove(self.Items, index)
            end
            local data2 = {__index = object2}
            return {new = function()
                return (initObj(data, data2))
            end}
        end)()
        return object
    end}
end}
local v1
local explorer
local properties
local scriptViewer
local v2
local notebook
local v3
local lib
local api
local rmd
v2 = (function()
    local fromRGB = Color3.fromRGB
    return {Explorer = {_Recurse = true, Sorting = true, TeleportToOffset = Vector3.new(0, 0, 0), ClickToRename = true, AutoUpdateSearch = true, AutoUpdateMode = 0, PartSelectionBox = true, GuiSelectionBox = true, CopyPathUseGetChildren = true}, Properties = {_Recurse = true, MaxConflictCheck = 50, ShowDeprecated = false, ShowHidden = false, ClearOnFocus = false, LoadstringInput = true, NumberRounding = 3, ShowAttributes = false, MaxAttributes = 50, ScaleType = 1}, Theme = {_Recurse = true, Main1 = fromRGB(52, 52, 52), Main2 = fromRGB(45, 45, 45), Outline1 = fromRGB(33, 33, 33), Outline2 = fromRGB(55, 55, 55), Outline3 = fromRGB(30, 30, 30), TextBox = fromRGB(38, 38, 38), Menu = fromRGB(32, 32, 32), ListSelection = fromRGB(11, 90, 175), Button = fromRGB(60, 60, 60), ButtonHover = fromRGB(68, 68, 68), ButtonPress = fromRGB(40, 40, 40), Highlight = fromRGB(75, 75, 75), Text = fromRGB(255, 255, 255), PlaceholderText = fromRGB(100, 100, 100), Important = fromRGB(255, 0, 0), ExplorerIconMap = '', MiscIconMap = '', Syntax = {Text = fromRGB(204, 204, 204), Background = fromRGB(36, 36, 36), Selection = fromRGB(255, 255, 255), SelectionBack = fromRGB(11, 90, 175), Operator = fromRGB(204, 204, 204), Number = fromRGB(255, 198, 0), String = fromRGB(173, 241, 149), Comment = fromRGB(102, 102, 102), Keyword = fromRGB(248, 109, 124), Error = fromRGB(255, 0, 0), FindBackground = fromRGB(141, 118, 0), MatchingWord = fromRGB(85, 85, 85), BuiltIn = fromRGB(132, 214, 247), CurrentLine = fromRGB(45, 50, 65), LocalMethod = fromRGB(253, 251, 172), LocalProperty = fromRGB(97, 161, 241), Nil = fromRGB(255, 198, 0), Bool = fromRGB(255, 198, 0), Function = fromRGB(248, 109, 124), Local = fromRGB(248, 109, 124), Self = fromRGB(248, 109, 124), FunctionName = fromRGB(253, 251, 172), Bracket = fromRGB(204, 204, 204)}}}
end)()
local settings = {}
local apps = {}
local env = {}
local object = setmetatable({}, {__index = function(tbl, key)
    local result = callback(game:GetService(key))
    tbl[key] = result
    return result
end})
local parent = object.Players.LocalPlayer or object.Players.PlayerAdded:wait()
local function handleMap(map)
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
local function handleClassName(className, map)
    local map2 = Instance.new(className)
    for k, v in next, map do
        map2[k] = v
    end
    return map2
end
v1 = (function()
    local object2 = {ModuleList = {'Explorer', 'Properties', 'ScriptViewer'}, Elevated = false, MissingEnv = {}, Version = '', Mouse = parent:GetMouse(), AppControls = {}, Apps = apps, MenuApps = {}, DisplayOrders = {SideWindow = 8, Window = 10, Menu = 100000, Core = 101000}}
    function object2.GetInitDeps()
        return {Main = object2, Lib = lib, Apps = apps, Settings = settings, API = api, RMD = rmd, env = env, service = object, plr = parent, create = handleMap, createSimple = handleClassName}
    end
    function object2.Error(value)
        if rconsoleprint then
            rconsoleprint('DEX ERROR: ' .. tostring(value) .. '\n')
            wait(9000000000)
            return
        end
        error(value)
    end
    function object2.LoadModule(name)
        if object2.Elevated then
            local v1
            if data then
                v1 = data[name]()
                if not v1 then
                    object2.Error('Missing Embedded Module: ' .. name)
                end
            end
            object2.AppControls[name] = v1
            v1.InitDeps(object2.GetInitDeps())
            local result = v1.Main()
            apps[name] = result
            return result
        end
        local result2 = script:WaitForChild('Modules'):WaitForChild(name, 2)
        if not result2 then
            object2.Error('CANNOT FIND MODULE ' .. name)
        end
        local v2 = require(result2)
        object2.AppControls[name] = v2
        v2.InitDeps(object2.GetInitDeps())
        local result3 = v2.Main()
        apps[name] = result3
        return result3
    end
    function object2.LoadModules()
        for _, module in pairs(object2.ModuleList) do
            local success, result = pcall(object2.LoadModule, module)
            if success then
                continue
            end
            object2.Error('FAILED LOADING ' + module + ' CAUSE ' + result)
        end
        explorer = apps.Explorer
        properties = apps.Properties
        scriptViewer = apps.ScriptViewer
        notebook = apps.Notebook
        local data = {Explorer = explorer, Properties = properties, ScriptViewer = scriptViewer, Notebook = notebook}
        object2.AppControls.Lib.InitAfterMain(data)
        for _, module in pairs(object2.ModuleList) do
            local appControl = object2.AppControls[module]
            if not appControl then
                continue
            end
            appControl.InitAfterMain(data)
        end
    end
    function object2.InitEnv()
        setmetatable(env, {__newindex = function(tbl, key, value)
            if not value then
                object2.MissingEnv[#object2.MissingEnv + 1] = key
                return
            end
            rawset(tbl, key, value)
        end})
        env.readfile = readfile
        env.writefile = writefile
        env.appendfile = appendfile
        env.makefolder = makefolder
        env.listfiles = listfiles
        env.loadfile = loadfile
        env.movefileas = movefileas
        env.saveinstance = saveinstance
        env.getupvalues = debug and debug.getupvalues or getupvalues or getupvals
        env.getconstants = debug and debug.getconstants or getconstants or getconsts
        env.getinfo = not debug and getinfo or debug and (debug.getinfo or debug.info or getinfo)
        env.islclosure = islclosure or is_l_closure or is_lclosure
        env.checkcaller = checkcaller
        env.getgc = getgc or get_gc_objects
        env.base64encode = crypt and crypt.base64 and crypt.base64.encode
        env.getscriptbytecode = getscriptbytecode
        env.request = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request
        local env2 = env
        local decompile = decompile
        if not decompile then
            decompile = env
            decompile = decompile.getscriptbytecode
            if decompile then
                decompile = env
                decompile = decompile.request
                if decompile then
                    decompile = env
                    decompile = decompile.base64encode
                    if decompile then
                        function decompile(arg1)
                            local success, result = pcall(env.getscriptbytecode, arg1)
                            if not success then
                                return 'failed to get bytecode ' .. tostring(result)
                            else
                                local result2 = env.request({Url = 'https://unluau.lonegladiator.dev/unluau/decompile', Method = 'POST', Headers = {['Content-Type'] = 'application/json'}, Body = object.HttpService:JSONEncode({version = 5, bytecode = env.base64encode(result)})})
                                local result3 = object.HttpService:JSONDecode(result2.Body)
                                if result3.status ~= 'ok' then
                                    return 'decompilation failed: ' .. tostring(result3.status)
                                end
                                return result3.output
                            end
                        end
                    end
                end
            end
        end
        env2.decompile = decompile
        env.protectgui = protect_gui or syn and syn.protect_gui
        env.gethui = gethui or get_hidden_gui
        env.setclipboard = setclipboard or toclipboard or set_clipboard or Clipboard and Clipboard.set
        env.getnilinstances = getnilinstances or get_nil_instances
        env.getloadedmodules = getloadedmodules
        object2.GuiHolder = object2.Elevated and object.CoreGui or parent:FindFirstChildWhichIsA('PlayerGui')
        setmetatable(env, nil)
    end
    function object2.LoadSettings()
        local success, result = pcall(env.readfile or error, 'DexSettings.json')
        if success and result and result ~= '' then
            local v1, v2 = object.HttpService:JSONDecode(result)
            if v1 and v2 then
                for _, _ in next, v2 do
                end
                return
            end
        else
            object2.ResetSettings()
        end
    end
    function object2.ResetSettings()
        local function recur(map, arg2)
            for k, v in pairs(map) do
                if type(v) == 'table' and v._Recurse then
                    if type(arg2[k]) ~= 'table' then
                        arg2[k] = {}
                    end
                    recur(v, arg2[k])
                else
                    arg2[k] = v
                end
            end
            return arg2
        end
        recur(v2, settings)
    end
    function object2.FetchAPI()
        local result
        local API
        if object2.Elevated then
            if object2.LocalDepsUpToDate() then
                local file = lib.ReadFile('dex/rbx_api.dat')
                if file then
                    API = file
                else
                    object2.DepsVersionData[1] = ''
                end
            end
            API = API or game:HttpGet('http://setup.roblox.com/' .. object2.RobloxVersion .. '-API-Dump.json')
        elseif script:FindFirstChild('API') then
            API = require(script.API)
        else
            error('NO API EXISTS')
        end
        object2.RawAPI = API
        result = object.HttpService:JSONDecode(API)
        local classes = {}
        local enums = {}
        local list = {}
        local set = {}
        local function insertAbove(list, value, value2)
            local index = table.find(list, value)
            if not index then
                return
            else
                table.remove(list, index)
                local index2 = table.find(list, value2)
                if not index2 then
                    return
                end
                table.insert(list, index2, value)
            end
        end
        for _, class in pairs(result.Classes) do
            local data = {Name = class.Name, Superclass = class.Superclass, Properties = {}, Functions = {}, Events = {}, Callbacks = {}, Tags = {}}
            if class.Tags then
                for _, tag in pairs(class.Tags) do
                    data.Tags[tag] = true
                end
            end
            for _, member in pairs(class.Members) do
                local item = {Name = member.Name, Class = class.Name, Security = member.Security, Tags = {}}
                if member.Tags then
                    for _, tag in pairs(member.Tags) do
                        item.Tags[tag] = true
                    end
                end
                local memberType = member.MemberType
                if memberType == 'Property' then
                    local category = member.Category or 'Other'
                    category = category:match('^%s*(.-)%s*$')
                    if not set[category] then
                        list[#list + 1] = category
                        set[category] = true
                    end
                    item.ValueType = member.ValueType
                    item.Category = category
                    item.Serialization = member.Serialization
                    table.insert(data.Properties, item)
                elseif memberType == 'Function' then
                    item.Parameters = {}
                    item.ReturnType = member.ReturnType.Name
                    for _, parameter in pairs(member.Parameters) do
                        table.insert(item.Parameters, {Name = parameter.Name, Type = parameter.Type.Name})
                    end
                    table.insert(data.Functions, item)
                elseif memberType == 'Event' then
                    item.Parameters = {}
                    for _, parameter in pairs(member.Parameters) do
                        table.insert(item.Parameters, {Name = parameter.Name, Type = parameter.Type.Name})
                    end
                    table.insert(data.Events, item)
                end
            end
            classes[class.Name] = data
        end
        for _, class in pairs(classes) do
            class.Superclass = classes[class.Superclass]
        end
        for _, enum in pairs(result.Enums) do
            local info = {Name = enum.Name, Items = {}, Tags = {}}
            if enum.Tags then
                for _, tag in pairs(enum.Tags) do
                    info.Tags[tag] = true
                end
            end
            for _, item2 in pairs(enum.Items) do
                local item3 = {Name = item2.Name, Value = item2.Value}
                table.insert(info.Items, item3)
            end
            enums[enum.Name] = info
        end
        local function getMember(arg1, arg2)
            if not classes[arg1] or not classes[arg1][arg2] then
                return
            end
            local list = {}
            local superclass = classes[arg1]
            while superclass do
                for _, v in pairs(superclass[arg2]) do
                    list[#list + 1] = v
                end
                superclass = superclass.Superclass
            end
            table.sort(list, function(a, b)
                return a.Name < b.Name
            end)
            return list
        end
        insertAbove(list, 'Behavior', 'Tuning')
        insertAbove(list, 'Appearance', 'Data')
        insertAbove(list, 'Attachments', 'Axes')
        insertAbove(list, 'Cylinder', 'Slider')
        insertAbove(list, 'Localization', 'Jump Settings')
        insertAbove(list, 'Surface', 'Motion')
        insertAbove(list, 'Surface Inputs', 'Surface')
        insertAbove(list, 'Part', 'Surface Inputs')
        insertAbove(list, 'Assembly', 'Surface Inputs')
        insertAbove(list, 'Character', 'Controls')
        list[#list + 1] = 'Unscriptable'
        list[#list + 1] = 'Attributes'
        local categoryOrder = {}
        for i = 1, #list do
            categoryOrder[list[i]] = i
        end
        return {Classes = classes, Enums = enums, CategoryOrder = categoryOrder, GetMember = getMember}
    end
    function object2.FetchRMD()
        local RMD
        if object2.Elevated then
            if object2.LocalDepsUpToDate() then
                local file = lib.ReadFile('dex/rbx_rmd.dat')
                if file then
                    RMD = file
                else
                    object2.DepsVersionData[1] = ''
                end
            end
            RMD = RMD or game:HttpGet('https://raw.githubusercontent.com/CloneTrooper1019/Roblox-Client-Tracker/roblox/ReflectionMetadata.xml')
        elseif script:FindFirstChild('RMD') then
            RMD = require(script.RMD)
        else
            error('NO RMD EXISTS')
        end
        object2.RawRMD = RMD
        local xml = lib.ParseXML(RMD)
        local children = xml.children[1].children[1].children
        local children2 = xml.children[1].children[2].children
        local propertyOrders = {}
        local classes = {}
        local enums = {}
        for _, child in pairs(children) do
            local name = ''
            for _, child2 in pairs(child.children) do
                if child2.tag == 'Properties' then
                    local data = {Properties = {}, Functions = {}}
                    local children3 = child2.children
                    for _, v in pairs(children3) do
                        local name2 = v.attrs.name
                        data[name2:sub(1, 1):upper() .. name2:sub(2)] = v.children[1].text
                    end
                    name = data.Name
                    classes[name] = data
                elseif child2.attrs.class == 'ReflectionMetadataProperties' then
                    local children4 = child2.children
                    for _, v in pairs(children4) do
                        if v.attrs.class ~= 'ReflectionMetadataMember' then
                            continue
                        end
                        local map = {}
                        if v.children[1].tag ~= 'Properties' then
                            continue
                        end
                        local children5 = v.children[1].children
                        for _, v2 in pairs(children5) do
                            if not v2.attrs then
                                continue
                            end
                            local name3 = v2.attrs.name
                            map[name3:sub(1, 1):upper() .. name3:sub(2)] = v2.children[1].text
                        end
                        if map.PropertyOrder then
                            local propertyOrder = propertyOrders[name]
                            if not propertyOrder then
                                propertyOrder = {}
                                propertyOrders[name] = propertyOrder
                            end
                            propertyOrder[map.Name] = tonumber(map.PropertyOrder)
                        end
                        classes[name].Properties[map.Name] = map
                    end
                elseif child2.attrs.class == 'ReflectionMetadataFunctions' then
                    local children6 = child2.children
                    for _, v in pairs(children6) do
                        if v.attrs.class ~= 'ReflectionMetadataMember' then
                            continue
                        end
                        local map2 = {}
                        if v.children[1].tag ~= 'Properties' then
                            continue
                        end
                        local children7 = v.children[1].children
                        for _, v3 in pairs(children7) do
                            if not v3.attrs then
                                continue
                            end
                            local name4 = v3.attrs.name
                            map2[name4:sub(1, 1):upper() .. name4:sub(2)] = v3.children[1].text
                        end
                        classes[name].Functions[map2.Name] = map2
                    end
                end
            end
        end
        for _, v in pairs(children2) do
            local name5 = ''
            for _, child in pairs(v.children) do
                if child.tag == 'Properties' then
                    local data2 = {Items = {}}
                    local children8 = child.children
                    for _, v4 in pairs(children8) do
                        local name6 = v4.attrs.name
                        data2[name6:sub(1, 1):upper() .. name6:sub(2)] = v4.children[1].text
                    end
                    name5 = data2.Name
                    enums[name5] = data2
                elseif child.attrs.class == 'ReflectionMetadataEnumItem' then
                    local map3 = {}
                    if child.children[1].tag ~= 'Properties' then
                        continue
                    end
                    local children9 = child.children[1].children
                    for _, v5 in pairs(children9) do
                        local name7 = v5.attrs.name
                        map3[name7:sub(1, 1):upper() .. name7:sub(2)] = v5.children[1].text
                    end
                    enums[name5].Items[map3.Name] = map3
                end
            end
        end
        return {Classes = classes, Enums = enums, PropertyOrders = propertyOrders}
    end
    function object2.ShowGui(instance)
        if env.gethui then
            instance.Parent = env.gethui()
            return
        end
        if env.protectgui then
            env.protectgui(instance)
            instance.Parent = object2.GuiHolder
            return
        end
        instance.Parent = object2.GuiHolder
    end
    function object2.CreateIntro(text)
        local result = handleMap({{1, 'ScreenGui', {Name = 'Intro'}}, {2, 'Frame', {Active = true, BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BorderSizePixel = 0, Name = 'Main', Parent = {1}, Position = UDim2.new(0.5, -175, 0.5, -100), Size = UDim2.new(0, 350, 0, 200)}}, {3, 'Frame', {BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderSizePixel = 0, ClipsDescendants = true, Name = 'Holder', Parent = {2}, Size = UDim2.new(1, 0, 1, 0)}}, {4, 'UIGradient', {Parent = {3}, Rotation = 30, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})}}, {5, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 4, Name = 'Title', Parent = {3}, Position = UDim2.new(0, -190, 0, 15), Size = UDim2.new(0, 100, 0, 50), Text = 'Dex', TextColor3 = Color3.new(1, 1, 1), TextSize = 50, TextTransparency = 1}}, {6, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Desc', Parent = {3}, Position = UDim2.new(0, -230, 0, 60), Size = UDim2.new(0, 180, 0, 25), Text = 'Ultimate Debugging Suite', TextColor3 = Color3.new(1, 1, 1), TextSize = 18, TextTransparency = 1}}, {7, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'StatusText', Parent = {3}, Position = UDim2.new(0, 20, 0, 110), Size = UDim2.new(0, 180, 0, 25), Text = 'Fetching API', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextTransparency = 1}}, {8, 'Frame', {BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BorderSizePixel = 0, Name = 'ProgressBar', Parent = {3}, Position = UDim2.new(0, 110, 0, 145), Size = UDim2.new(0, 0, 0, 4)}}, {9, 'Frame', {BackgroundColor3 = Color3.new(0.2392156869173, 0.56078433990479, 0.86274510622025), BorderSizePixel = 0, Name = 'Bar', Parent = {8}, Size = UDim2.new(0, 0, 1, 0)}}, {10, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://2764171053', ImageColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), Parent = {8}, ScaleType = 1, Size = UDim2.new(1, 0, 1, 0), SliceCenter = Rect.new(2, 2, 254, 254)}}, {11, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Creator', Parent = {2}, Position = UDim2.new(1, -110, 1, -20), Size = UDim2.new(0, 105, 0, 20), Text = 'Developed by Moon', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 1}}, {12, 'UIGradient', {Parent = {11}, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})}}, {13, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Version', Parent = {2}, Position = UDim2.new(1, -110, 1, -35), Size = UDim2.new(0, 105, 0, 20), Text = object2.Version, TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextXAlignment = 1}}, {14, 'UIGradient', {Parent = {13}, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})}}, {15, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Image = 'rbxassetid://1427967925', Name = 'Outlines', Parent = {2}, Position = UDim2.new(0, -5, 0, -5), ScaleType = 1, Size = UDim2.new(1, 10, 1, 10), SliceCenter = Rect.new(6, 6, 25, 25), TileSize = UDim2.new(0, 20, 0, 20)}}, {16, 'UIGradient', {Parent = {15}, Rotation = -30, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})}}, {17, 'UIGradient', {Parent = {2}, Rotation = -30, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})}}})
        object2.ShowGui(result)
        local uiGradient = result.Main.UIGradient
        local uiGradient2 = result.Main.Outlines.UIGradient
        local uiGradient3 = result.Main.Holder.UIGradient
        local title = result.Main.Holder.Title
        local desc = result.Main.Holder.Desc
        local version = result.Main.Version
        local uiGradient4 = version.UIGradient
        local creator = result.Main.Creator
        local uiGradient5 = creator.UIGradient
        local statusText = result.Main.Holder.StatusText
        local progressBar = result.Main.Holder.ProgressBar
        local tweenService = object.TweenService
        local renderStepped = object.RunService.RenderStepped
        local wait2 = renderStepped.wait
        local function compute(arg1)
            if not arg1 then
                return wait2(renderStepped)
            end
            local now = tick()
            while tick() - now < arg1 do
                wait2(renderStepped)
            end
        end
        statusText.Text = text
        local function tweenNumber(value, tweenInfo, arg3)
            local intValue = Instance.new('IntValue')
            intValue.Value = 0
            intValue.Changed:Connect(arg3)
            local tween = tweenService:Create(intValue, tweenInfo, {Value = value})
            tween:Play()
            tween.Completed:Connect(function()
                intValue:Destroy()
            end)
        end
        local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        tweenNumber(100, tweenInfo, function(b)
            b /= 200
            local numberSequenceKeypoint = NumberSequenceKeypoint.new(0, 0)
            local numberSequenceKeypoint2 = NumberSequenceKeypoint.new(b, 0)
            local numberSequenceKeypoint3 = NumberSequenceKeypoint.new(math.min(0.5, b + math.min(0.05, b)), 1)
            if numberSequenceKeypoint2.Time == numberSequenceKeypoint3.Time then
                numberSequenceKeypoint3 = numberSequenceKeypoint2
            end
            local numberSequenceKeypoint4 = NumberSequenceKeypoint.new(1 - b, 0)
            local numberSequenceKeypoint5 = NumberSequenceKeypoint.new(math.max(0.5, 1 - b - math.min(0.05, b)), 1)
            if numberSequenceKeypoint4.Time == numberSequenceKeypoint5.Time then
                numberSequenceKeypoint5 = numberSequenceKeypoint4
            end
            local numberSequenceKeypoint6 = NumberSequenceKeypoint.new(1, 0)
            uiGradient.Transparency = NumberSequence.new({numberSequenceKeypoint, numberSequenceKeypoint2, numberSequenceKeypoint3, numberSequenceKeypoint5, numberSequenceKeypoint4, numberSequenceKeypoint6})
            uiGradient2.Transparency = NumberSequence.new({numberSequenceKeypoint, numberSequenceKeypoint2, numberSequenceKeypoint3, numberSequenceKeypoint5, numberSequenceKeypoint4, numberSequenceKeypoint6})
        end)
        compute(0.4)
        tweenNumber(100, tweenInfo, function(number)
            number /= 166.66
            local numberSequenceKeypoint = NumberSequenceKeypoint.new(0, 0)
            local numberSequenceKeypoint2 = NumberSequenceKeypoint.new(number, 0)
            local numberSequenceKeypoint3 = NumberSequenceKeypoint.new(number + 0.01, 1)
            local numberSequenceKeypoint4 = NumberSequenceKeypoint.new(1, 1)
            uiGradient3.Transparency = NumberSequence.new({numberSequenceKeypoint, numberSequenceKeypoint2, numberSequenceKeypoint3, numberSequenceKeypoint4})
        end)
        tweenService:Create(title, tweenInfo, {Position = UDim2.new(0, 60, 0, 15), TextTransparency = 0}):Play()
        tweenService:Create(desc, tweenInfo, {Position = UDim2.new(0, 20, 0, 60), TextTransparency = 0}):Play()
        local function rightTextTransparency(part)
            tweenNumber(100, tweenInfo, function(number)
                number /= 100
                local numberSequenceKeypoint = NumberSequenceKeypoint.new(1 - number, 0)
                local numberSequenceKeypoint2 = NumberSequenceKeypoint.new(math.max(0, 1 - number - 0.01), 1)
                if numberSequenceKeypoint.Time == numberSequenceKeypoint2.Time then
                    numberSequenceKeypoint2 = numberSequenceKeypoint
                end
                local numberSequenceKeypoint3 = NumberSequenceKeypoint.new(0, numberSequenceKeypoint == numberSequenceKeypoint2 and 0 or 1)
                local numberSequenceKeypoint4 = NumberSequenceKeypoint.new(1, 0)
                part.Transparency = NumberSequence.new({numberSequenceKeypoint3, numberSequenceKeypoint2, numberSequenceKeypoint, numberSequenceKeypoint4})
            end)
        end
        rightTextTransparency(uiGradient4)
        rightTextTransparency(uiGradient5)
        compute(0.9)
        local tweenInfo2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        tweenService:Create(statusText, tweenInfo2, {Position = UDim2.new(0, 20, 0, 120), TextTransparency = 0}):Play()
        tweenService:Create(progressBar, tweenInfo2, {Position = UDim2.new(0, 60, 0, 145), Size = UDim2.new(0, 100, 0, 4)}):Play()
        compute(0.25)
        return {SetProgress = function(text, xScale)
            statusText.Text = text
            tweenService:Create(progressBar.Bar, tweenInfo2, {Size = UDim2.new(xScale, 0, 1, 0)}):Play()
        end, Close = function()
            tweenService:Create(title, tweenInfo2, {TextTransparency = 1}):Play()
            tweenService:Create(desc, tweenInfo2, {TextTransparency = 1}):Play()
            tweenService:Create(version, tweenInfo2, {TextTransparency = 1}):Play()
            tweenService:Create(creator, tweenInfo2, {TextTransparency = 1}):Play()
            tweenService:Create(statusText, tweenInfo2, {TextTransparency = 1}):Play()
            tweenService:Create(progressBar, tweenInfo2, {BackgroundTransparency = 1}):Play()
            tweenService:Create(progressBar.Bar, tweenInfo2, {BackgroundTransparency = 1}):Play()
            tweenService:Create(progressBar.ImageLabel, tweenInfo2, {ImageTransparency = 1}):Play()
            tweenNumber(100, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), function(number)
                number /= 250
                local numberSequenceKeypoint = NumberSequenceKeypoint.new(0, 0)
                local numberSequenceKeypoint2 = NumberSequenceKeypoint.new(0.6 + number, 0)
                local numberSequenceKeypoint3 = NumberSequenceKeypoint.new(math.min(1, 0.601 + number), 1)
                if numberSequenceKeypoint2.Time == numberSequenceKeypoint3.Time then
                    numberSequenceKeypoint3 = numberSequenceKeypoint2
                end
                local numberSequenceKeypoint4 = NumberSequenceKeypoint.new(1, numberSequenceKeypoint2 == numberSequenceKeypoint3 and 0 or 1)
                uiGradient3.Transparency = NumberSequence.new({numberSequenceKeypoint, numberSequenceKeypoint2, numberSequenceKeypoint3, numberSequenceKeypoint4})
            end)
            compute(0.5)
            result.Main.BackgroundTransparency = 1
            uiGradient2.Rotation = 30
            tweenNumber(100, tweenInfo, function(b)
                b /= 100
                local numberSequenceKeypoint = NumberSequenceKeypoint.new(0, 1)
                local numberSequenceKeypoint2 = NumberSequenceKeypoint.new(b, 1)
                local numberSequenceKeypoint3 = NumberSequenceKeypoint.new(math.min(1, b + math.min(0.05, b)), 0)
                if numberSequenceKeypoint2.Time == numberSequenceKeypoint3.Time then
                    numberSequenceKeypoint3 = numberSequenceKeypoint2
                end
                local numberSequenceKeypoint4 = NumberSequenceKeypoint.new(1, numberSequenceKeypoint2 == numberSequenceKeypoint3 and 1 or 0)
                uiGradient2.Transparency = NumberSequence.new({numberSequenceKeypoint, numberSequenceKeypoint2, numberSequenceKeypoint3, numberSequenceKeypoint4})
                uiGradient3.Transparency = NumberSequence.new({numberSequenceKeypoint, numberSequenceKeypoint2, numberSequenceKeypoint3, numberSequenceKeypoint4})
            end)
            compute(0.45)
            result:Destroy()
        end}
    end
    function object2.CreateApp(instance)
        if object2.MenuApps[instance.Name] then
            return
        end
        local tbl = {}
        local clone = object2.AppTemplate:Clone()
        local icon = instance.Icon
        if instance.IconMap and icon then
            if type(icon) == 'number' then
                instance.IconMap:Display(clone.Main.Icon, icon)
            else
                if type(icon) == 'string' then
                    instance.IconMap:DisplayByKey(clone.Main.Icon, icon)
                end
            end
        elseif type(icon) == 'string' then
            clone.Main.Icon.Image = icon
        else
            clone.Main.Icon.Image = ''
        end
        local function updateState()
            clone.Main.BackgroundTransparency = instance.Open and 0 or lib.CheckMouseInGui(clone.Main) and 0 or 1
            clone.Main.Highlight.Visible = instance.Open
        end
        local function enable(arg1)
            if instance.Open then
                return
            end
            instance.Open = true
            updateState()
            if not arg1 then
                if instance.Window then
                    instance.Window:Show()
                end
                if instance.OnClick then
                    instance.OnClick(instance.Open)
                end
            end
        end
        local function disable(arg1)
            if not instance.Open then
                return
            end
            instance.Open = false
            updateState()
            if not arg1 then
                if instance.Window then
                    instance.Window:Hide()
                end
                if instance.OnClick then
                    instance.OnClick(instance.Open)
                end
            end
        end
        updateState()
        local y = object.TextService:GetTextSize(instance.Name, 14, Enum.Font.SourceSans, Vector2.new(62, 999999)).Y
        clone.Main.Size = UDim2.new(1, 0, 0, math.clamp(46 + y, 60, 74))
        clone.Main.AppName.Text = instance.Name
        clone.Main.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                clone.Main.BackgroundTransparency = 0
                clone.Main.BackgroundColor3 = settings.Theme.ButtonHover
            end
        end)
        clone.Main.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                clone.Main.BackgroundTransparency = instance.Open and 0 or 1
                clone.Main.BackgroundColor3 = settings.Theme.Button
            end
        end)
        clone.Main.MouseButton1Click:Connect(function()
            if instance.Open then
                disable()
                return
            end
            enable()
        end)
        local window = instance.Window
        if window then
            window.OnActivate:Connect(function()
                enable(true)
            end)
            window.OnDeactivate:Connect(function()
                disable(true)
            end)
        end
        clone.Visible = true
        clone.Parent = object2.AppsContainer
        object2.AppsFrame.CanvasSize = UDim2.new(0, 0, 0, object2.AppsContainerGrid.AbsoluteCellCount.Y * 82 + 8)
        tbl.Enable = enable
        tbl.Disable = disable
        object2.MenuApps[instance.Name] = tbl
        return tbl
    end
    function object2.SetMainGuiOpen(mainGuiOpen)
        object2.MainGuiOpen = mainGuiOpen
        object2.MainGui.OpenButton.Text = mainGuiOpen and 'X' or 'Dex'
        if mainGuiOpen then
            object2.MainGui.OpenButton.MainFrame.Visible = true
        end
        object2.MainGui.OpenButton.MainFrame:TweenSize(mainGuiOpen and UDim2.new(0, 224, 0, 200) or UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        object.TweenService:Create(object2.MainGui.OpenButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = mainGuiOpen and 0 or lib.CheckMouseInGui(object2.MainGui.OpenButton) and 0 or 0.2}):Play()
        if object2.MainGuiMouseEvent then
            object2.MainGuiMouseEvent:Disconnect()
        end
        if not mainGuiOpen then
            local now = tick()
            object2.MainGuiCloseTime = now
            coroutine.wrap(function()
                lib.FastWait(0.2)
                if not object2.MainGuiOpen and now == object2.MainGuiCloseTime then
                    object2.MainGui.OpenButton.MainFrame.Visible = false
                end
            end)()
            return
        end
        object2.MainGuiMouseEvent = object.UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and not lib.CheckMouseInGui(object2.MainGui.OpenButton) and not lib.CheckMouseInGui(object2.MainGui.OpenButton.MainFrame) then
                object2.SetMainGuiOpen(false)
            end
        end)
    end
    function object2.CreateMainGui()
        local mainGui = handleMap({{1, 'ScreenGui', {IgnoreGuiInset = true, Name = 'MainMenu'}}, {2, 'TextButton', {AnchorPoint = Vector2.new(0.5, 0), AutoButtonColor = false, BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), BorderSizePixel = 0, Font = 4, Name = 'OpenButton', Parent = {1}, Position = UDim2.new(0.5, 0, 0, 2), Size = UDim2.new(0, 32, 0, 32), Text = 'Dex', TextColor3 = Color3.new(1, 1, 1), TextSize = 16, TextTransparency = 0.20000000298023}}, {3, 'UICorner', {CornerRadius = UDim.new(0, 4), Parent = {2}}}, {4, 'Frame', {AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.new(0.17647059261799, 0.17647059261799, 0.17647059261799), ClipsDescendants = true, Name = 'MainFrame', Parent = {2}, Position = UDim2.new(0.5, 0, 1, -4), Size = UDim2.new(0, 224, 0, 200)}}, {5, 'UICorner', {CornerRadius = UDim.new(0, 4), Parent = {4}}}, {6, 'Frame', {BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), Name = 'BottomFrame', Parent = {4}, Position = UDim2.new(0, 0, 1, -24), Size = UDim2.new(1, 0, 0, 24)}}, {7, 'UICorner', {CornerRadius = UDim.new(0, 4), Parent = {6}}}, {8, 'Frame', {BackgroundColor3 = Color3.new(0.20392157137394, 0.20392157137394, 0.20392157137394), BorderSizePixel = 0, Name = 'CoverFrame', Parent = {6}, Size = UDim2.new(1, 0, 0, 4)}}, {9, 'Frame', {BackgroundColor3 = Color3.new(0.1294117718935, 0.1294117718935, 0.1294117718935), BorderSizePixel = 0, Name = 'Line', Parent = {8}, Position = UDim2.new(0, 0, 0, -1), Size = UDim2.new(1, 0, 0, 1)}}, {10, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Settings', Parent = {6}, Position = UDim2.new(1, -48, 0, 0), Size = UDim2.new(0, 24, 1, 0), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14}}, {11, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://6578871732', ImageTransparency = 0.20000000298023, Name = 'Icon', Parent = {10}, Position = UDim2.new(0, 4, 0, 4), Size = UDim2.new(0, 16, 0, 16)}}, {12, 'TextButton', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Font = 3, Name = 'Information', Parent = {6}, Position = UDim2.new(1, -24, 0, 0), Size = UDim2.new(0, 24, 1, 0), Text = '', TextColor3 = Color3.new(1, 1, 1), TextSize = 14}}, {13, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://6578933307', ImageTransparency = 0.20000000298023, Name = 'Icon', Parent = {12}, Position = UDim2.new(0, 4, 0, 4), Size = UDim2.new(0, 16, 0, 16)}}, {14, 'ScrollingFrame', {Active = true, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderColor3 = Color3.new(0.1294117718935, 0.1294117718935, 0.1294117718935), BorderSizePixel = 0, Name = 'AppsFrame', Parent = {4}, Position = UDim2.new(0.5, 0, 0, 0), ScrollBarImageColor3 = Color3.new(0, 0, 0), ScrollBarThickness = 4, Size = UDim2.new(0, 222, 1, -25)}}, {15, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'Container', Parent = {14}, Position = UDim2.new(0, 7, 0, 8), Size = UDim2.new(1, -14, 0, 2)}}, {16, 'UIGridLayout', {CellSize = UDim2.new(0, 66, 0, 74), Parent = {15}, SortOrder = 2}}, {17, 'Frame', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Name = 'App', Parent = {1}, Size = UDim2.new(0, 100, 0, 100), Visible = false}}, {18, 'TextButton', {AutoButtonColor = false, BackgroundColor3 = Color3.new(0.2352941185236, 0.2352941185236, 0.2352941185236), BorderSizePixel = 0, Font = 3, Name = 'Main', Parent = {17}, Size = UDim2.new(1, 0, 0, 60), Text = '', TextColor3 = Color3.new(0, 0, 0), TextSize = 14}}, {19, 'ImageLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Image = 'rbxassetid://6579106223', ImageRectSize = Vector2.new(32, 32), Name = 'Icon', Parent = {18}, Position = UDim2.new(0.5, -16, 0, 4), ScaleType = 4, Size = UDim2.new(0, 32, 0, 32)}}, {20, 'TextLabel', {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Font = 3, Name = 'AppName', Parent = {18}, Position = UDim2.new(0, 2, 0, 38), Size = UDim2.new(1, -4, 1, -40), Text = 'Explorer', TextColor3 = Color3.new(1, 1, 1), TextSize = 14, TextTransparency = 0.10000000149012, TextTruncate = 1, TextWrapped = true, TextYAlignment = 0}}, {21, 'Frame', {BackgroundColor3 = Color3.new(0, 0.66666668653488, 1), BorderSizePixel = 0, Name = 'Highlight', Parent = {18}, Position = UDim2.new(0, 0, 1, -2), Size = UDim2.new(1, 0, 0, 2)}}})
        object2.MainGui = mainGui
        object2.AppsFrame = mainGui.OpenButton.MainFrame.AppsFrame
        object2.AppsContainer = object2.AppsFrame.Container
        object2.AppsContainerGrid = object2.AppsContainer.UIGridLayout
        object2.AppTemplate = mainGui.App
        object2.MainGuiOpen = false
        local openButton = mainGui.OpenButton
        openButton.BackgroundTransparency = 0.2
        openButton.MainFrame.Size = UDim2.new(0, 0, 0, 0)
        openButton.MainFrame.Visible = false
        openButton.MouseButton1Click:Connect(function()
            object2.SetMainGuiOpen(not object2.MainGuiOpen)
        end)
        openButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                object.TweenService:Create(object2.MainGui.OpenButton, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
            end
        end)
        openButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                object.TweenService:Create(object2.MainGui.OpenButton, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = object2.MainGuiOpen and 0 or 0.2}):Play()
            end
        end)
        object2.CreateApp({Name = 'Explorer', IconMap = object2.LargeIcons, Icon = 'Explorer', Open = true, Window = explorer.Window})
        object2.CreateApp({Name = 'Properties', IconMap = object2.LargeIcons, Icon = 'Properties', Open = true, Window = properties.Window})
        object2.CreateApp({Name = 'Script Viewer', IconMap = object2.LargeIcons, Icon = 'Script_Viewer', Window = scriptViewer.Window})
        local connection
        object2.CreateApp({Name = 'Click part to select', IconMap = object2.LargeIcons, Icon = 6, OnClick = function(arg1)
            if arg1 then
                local mouse = object2.Mouse
                connection = mouse.Button1Down:Connect(function()
                    pcall(function()
                        local target = mouse.Target
                        if nodes[target] then
                            selection:Set(nodes[target])
                            explorer.ViewNode(nodes[target])
                        end
                    end)
                end)
                return
            end
            if connection ~= nil then
                connection:Disconnect()
                connection = nil
            end
        end})
        lib.ShowGui(mainGui)
    end
    function object2.SetupFilesystem()
        if not env.writefile or not env.makefolder then
            return
        end
        local _ = env.writefile
        local makefolder2 = env.makefolder
        makefolder2('dex')
        makefolder2('dex/assets')
        makefolder2('dex/saved')
        makefolder2('dex/plugins')
        makefolder2('dex/ModuleCache')
    end
    function object2.LocalDepsUpToDate()
        return object2.DepsVersionData and object2.ClientVersion == object2.DepsVersionData[1]
    end
    function object2.Init()
        object2.Elevated = pcall(function()
            local _ = callback(game:GetService('CoreGui')):GetFullName()
        end)
        object2.InitEnv()
        object2.LoadSettings()
        object2.SetupFilesystem()
        local intro = object2.CreateIntro('Initializing Library')
        lib = object2.LoadModule('Lib')
        lib.FastWait()
        object2.MiscIcons = lib.IconMap.new('rbxassetid://6511490623', 256, 256, 16, 16)
        object2.MiscIcons:SetDict({Reference = 0, Cut = 1, Cut_Disabled = 2, Copy = 3, Copy_Disabled = 4, Paste = 5, Paste_Disabled = 6, Delete = 7, Delete_Disabled = 8, Group = 9, Group_Disabled = 10, Ungroup = 11, Ungroup_Disabled = 12, TeleportTo = 13, Rename = 14, JumpToParent = 15, ExploreData = 16, Save = 17, CallFunction = 18, CallRemote = 19, Undo = 20, Undo_Disabled = 21, Redo = 22, Redo_Disabled = 23, Expand_Over = 24, Expand = 25, Collapse_Over = 26, Collapse = 27, SelectChildren = 28, SelectChildren_Disabled = 29, InsertObject = 30, ViewScript = 31, AddStar = 32, RemoveStar = 33, Script_Disabled = 34, LocalScript_Disabled = 35, Play = 36, Pause = 37, Rename_Disabled = 38})
        object2.LargeIcons = lib.IconMap.new('rbxassetid://6579106223', 256, 256, 32, 32)
        object2.LargeIcons:SetDict({Explorer = 0, Properties = 1, Script_Viewer = 2})
        intro.SetProgress('Fetching Roblox Version', 0.2)
        if object2.Elevated then
            local file = lib.ReadFile('dex/deps_version.dat')
            object2.ClientVersion = Version()
            if file then
                object2.DepsVersionData = string.split(file, '\n')
                if object2.LocalDepsUpToDate() then
                    object2.RobloxVersion = object2.DepsVersionData[2]
                end
            end
            object2.RobloxVersion = object2.RobloxVersion or game:HttpGet('http://setup.roblox.com/versionQTStudio')
        end
        intro.SetProgress('Fetching API', 0.35)
        api = object2.FetchAPI()
        lib.FastWait()
        intro.SetProgress('Fetching RMD', 0.5)
        rmd = object2.FetchRMD()
        lib.FastWait()
        if object2.Elevated and env.writefile and not object2.LocalDepsUpToDate() then
            env.writefile('dex/deps_version.dat', object2.ClientVersion .. '\n' .. object2.RobloxVersion)
            env.writefile('dex/rbx_api.dat', object2.RawAPI)
            env.writefile('dex/rbx_rmd.dat', object2.RawRMD)
        end
        intro.SetProgress('Loading Modules', 0.75)
        object2.AppControls.Lib.InitDeps(object2.GetInitDeps())
        object2.LoadModules()
        lib.FastWait()
        intro.SetProgress('Initializing Modules', 0.9)
        explorer.Init()
        properties.Init()
        scriptViewer.Init()
        lib.FastWait()
        intro.SetProgress('Complete', 1)
        coroutine.wrap(function()
            lib.FastWait(1.25)
            intro.Close()
        end)()
        lib.Window.Init()
        object2.CreateMainGui()
        explorer.Window:Show({Align = 'right', Pos = 1, Size = 0.5, Silent = true})
        properties.Window:Show({Align = 'right', Pos = 2, Size = 0.5, Silent = true})
        lib.DeferFunc(function()
            lib.Window.ToggleSide('right')
        end)
    end
    return object2
end)()
v1.Init()