local Library = {
	Open = true;
	Accent = Color3.fromRGB(100, 149, 237);
	Pages = {};
	Sections = {};
	Flags = {};
	UnNamedFlags = 0;
	ThemeObjects = {};
	Instances = {};
	Holder = nil;
	PageHolder = nil;
	CopiedColor = Color3.new(1, 1, 1);
	CopiedAlpha = 0;
	Keys = {
		[Enum.KeyCode.LeftShift] = "LShift",
		[Enum.KeyCode.RightShift] = "RShift",
		[Enum.KeyCode.LeftControl] = "LCtrl",
		[Enum.KeyCode.RightControl] = "RCtrl",
		[Enum.KeyCode.LeftAlt] = "LAlt",
		[Enum.KeyCode.RightAlt] = "RAlt",
		[Enum.KeyCode.CapsLock] = "Caps",
		[Enum.KeyCode.One] = "1",
		[Enum.KeyCode.Two] = "2",
		[Enum.KeyCode.Three] = "3",
		[Enum.KeyCode.Four] = "4",
		[Enum.KeyCode.Five] = "5",
		[Enum.KeyCode.Six] = "6",
		[Enum.KeyCode.Seven] = "7",
		[Enum.KeyCode.Eight] = "8",
		[Enum.KeyCode.Nine] = "9",
		[Enum.KeyCode.Zero] = "0",
		[Enum.KeyCode.KeypadOne] = "Num1",
		[Enum.KeyCode.KeypadTwo] = "Num2",
		[Enum.KeyCode.KeypadThree] = "Num3",
		[Enum.KeyCode.KeypadFour] = "Num4",
		[Enum.KeyCode.KeypadFive] = "Num5",
		[Enum.KeyCode.KeypadSix] = "Num6",
		[Enum.KeyCode.KeypadSeven] = "Num7",
		[Enum.KeyCode.KeypadEight] = "Num8",
		[Enum.KeyCode.KeypadNine] = "Num9",
		[Enum.KeyCode.KeypadZero] = "Num0",
		[Enum.KeyCode.Minus] = "-",
		[Enum.KeyCode.Equals] = "=",
		[Enum.KeyCode.Tilde] = "~",
		[Enum.KeyCode.LeftBracket] = "[",
		[Enum.KeyCode.RightBracket] = "]",
		[Enum.KeyCode.RightParenthesis] = ")",
		[Enum.KeyCode.LeftParenthesis] = "(",
		[Enum.KeyCode.Semicolon] = ",",
		[Enum.KeyCode.Quote] = "'",
		[Enum.KeyCode.BackSlash] = "\\",
		[Enum.KeyCode.Comma] = ",",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Slash] = "/",
		[Enum.KeyCode.Asterisk] = "*",
		[Enum.KeyCode.Plus] = "+",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Backquote] = "`",
		[Enum.UserInputType.MouseButton1] = "MB1",
		[Enum.UserInputType.MouseButton2] = "MB2",
		[Enum.UserInputType.MouseButton3] = "MB3"
	};
	Connections = {};
	Font = nil;
	FontSize = 12;
	Notifs = {};
	KeyList = nil;
	KeyshitList = nil;
	ScreenGUI = nil;
	Folder = "soulhub/"
}

local Players = game:GetService("Players");
local userinput = game:GetService("UserInputService");
local tweenserv = game:GetService("TweenService")
local runserv = game:GetService("RunService")
local httpserv = game:GetService("HttpService")
local Flags = {}; 
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local viewportSize = game.Workspace.Camera.ViewportSize;
local ProtectGui = protectgui or (function()
end);
local NewVector2 = Vector2.new;
Library.__index = Library;
Library.Pages.__index = Library.Pages;
Library.Sections.__index = Library.Sections;

if not isfolder(Library.Folder) then
	makefolder(Library.Folder)
end
if not isfile(Library.Folder .. "alpha.jpg") then
	writefile(Library.Folder .. "alpha.jpg", game:HttpGet("https://raw.githubusercontent.com/s0opdev/s0op.dev/main/alpha.png?raw=true"))
end
if not isfile(Library.Folder .. "hue.jpg") then
	writefile(Library.Folder .. "hue.jpg", game:HttpGet("https://raw.githubusercontent.com/s0opdev/s0op.dev/main/hue.png?raw=true"))
end
if not isfile(Library.Folder .. "sat.jpg") then
	writefile(Library.Folder .. "sat.jpg", game:HttpGet("https://raw.githubusercontent.com/s0opdev/s0op.dev/main/sat.png?raw=true"))
end
if not isfile(Library.Folder .. "val.jpg") then
	writefile(Library.Folder .. "val.jpg", game:HttpGet("https://raw.githubusercontent.com/s0opdev/s0op.dev/main/val.png?raw=true"))
end
if not isfile(Library.Folder .. "cursor.jpg") then
	writefile(Library.Folder .. "cursor.jpg", game:HttpGet("https://raw.githubusercontent.com/s0opdev/s0op.dev/main/cursor.png?raw=true"))
end
if not isfile(Library.Folder .. "ProggyClean.ttf") then
	writefile(Library.Folder .. "ProggyClean.ttf", game:HttpGet("https://raw.githubusercontent.com/s0opdev/s0op.dev/main/ProggyClean.ttf?raw=true"))
end
if not isfile(Library.Folder .. "ProggyClean.font") then
	local Data = {
		name = "ProggyClean",
		faces = {
			{
				name = "Regular",
				weight = 200,
				style = "normal",
				assetId = getcustomasset(Library.Folder .. "ProggyClean.ttf"),
			},
		},
	}
	writefile(Library.Folder .. "ProggyClean.font", httpserv:JSONEncode(Data))
end

Library.Font = Font.new(getcustomasset(Library.Folder .. "ProggyClean.font"))
-- // Functions
-- // Library Functions
do
	function Library:Create(Class, Properties, Secure)
		local _Instance
		if Secure then
			_Instance = Instance.new(Class)
			ProtectGui(_Instance)
		else
			_Instance = type(Class) == 'string' and Instance.new(Class) or Class
		end
		for Property, Value in next, Properties do
			_Instance[Property] = Value
		end
		table.insert(Library.Instances, _Instance)
		return _Instance
	end
	function Library:Connection(Signal, Callback)
		local Con = Signal:Connect(Callback)
		table.insert(Library.Connections, Con)
		return Con
	end
	function Library:SetFlagsToDefault()
		local defaultValues = {
			["bool"] = false,
			["string"] = "",
			["number"] = 0,
			["table"] = {},
			["Color3"] = "rgb(0,0,0,1)",
			["Enum"] = Enum.KeyCode.Home
		}
		for flagName, flag in pairs(Flags) do
			local defaultValue = defaultValues[typeof(Library.Flags[flagName])] or defaultValues["string"]
			if not string.find(flagName, "MenuKey") then
				if typeof(flag) == "table" then
					if flag.Set then
						flag:Set(defaultValue)
					end
				else
					Flags[flagName](defaultValue)
				end
			end
		end
	end
	function Library:Unload()
		setmetatable(self.Flags, nil)
		self:SetFlagsToDefault()
		self.ScreenGui:Destroy()
		for _, v in ipairs(Library.Connections) do
			v:Disconnect()
		end
		self.Connections = {}
		userinput.MouseIconEnabled = true
	end
    --
	function Library:updateNotifsPositions(position)
		for i, v in pairs(Library.Notifs) do
			local Position = position == "Middle" and NewVector2(viewportSize.X / 2 - (v["Objects"][3].TextBounds.X + 4) / 2, 600) or NewVector2(20, 20)
			tweenserv:Create(v.Container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0, Position.X, 0, Position.Y + (i * 25))
			}):Play()
		end
	end
    --
	function Library:Notification(message, duration, color, position)
		if typeof(message) == "string" then
			local notification = {
				Container = nil,
				Objects = {}
			}
			local NotifContainer = Library:Create("Frame", {
				Parent = Library.ScreenGui,
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0),
				ZIndex = 99999999,
			})
			local Background = Library:Create("Frame", {
				Parent = NotifContainer,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundColor3 = Color3.new(0.0588, 0.0588, 0.0784),
				BorderColor3 = Color3.new(0.1373, 0.1373, 0.1569)
			})
			local Outline = Library:Create('Frame', {
				Parent = Background,
				Position = UDim2.new(0, -1, 0, -1),
				Size = UDim2.new(1, 2, 1, 2),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0),
			})
			local UIStroke = Library:Create('UIStroke', {
				Parent = Outline
			})
			local TextLabel = Library:Create('TextLabel', {
				Parent = Background,
				Position = UDim2.new(0, 1, 0, 0),
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0),
				Text = message,
				TextColor3 = Color3.new(0.9216, 0.9216, 0.9216),
				FontFace = Library.Font,
				TextSize = Library.FontSize,
				AutomaticSize = Enum.AutomaticSize.X,
				TextXAlignment = Enum.TextXAlignment.Left,
			})
			local Accemt = Library:Create('Frame', {
				Parent = Background,
				Size = UDim2.new(1, 0, 0, 1),
				BackgroundColor3 = Library.Accent,
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0),
			})
			local Progress = Library:Create('Frame', {
				Parent = Background,
				Position = UDim2.new(0, 0, 1, -1),
				Size = UDim2.new(0, 0, 0, 1),
				BackgroundColor3 = Color3.new(1, 0, 0),
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0),
			})
			--
			local Position = position == "Middle" and NewVector2(viewportSize.X / 2 - (TextLabel.TextBounds.X + 4) / 2, 600) or NewVector2(20, 20)
			--
			NotifContainer.Position = UDim2.new(0, Position.X, 0, Position.Y)
			NotifContainer.Size = UDim2.new(0, TextLabel.TextBounds.X + 4, 0, 20)
			notification.Container = NotifContainer
			table.insert(notification.Objects, Background)
			table.insert(notification.Objects, Outline)
			table.insert(notification.Objects, TextLabel)
			table.insert(notification.Objects, Accemt)
			table.insert(notification.Objects, Progress)
			if color ~= nil then
				Progress.BackgroundColor3 = color
				Accemt.BackgroundColor3 = color
			end
			function notification:remove()
				table.remove(Library.Notifs, table.find(Library.Notifs, notification))
				Library:updateNotifsPositions(position)
				notification.Container:Destroy()
			end
			task.spawn(function()
				Background.AnchorPoint = NewVector2(1, 0)
				tweenserv:Create(Background, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					AnchorPoint = NewVector2(0, 0)
				}):Play()
				tweenserv:Create(Progress, TweenInfo.new(duration or 5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Size = UDim2.new(1, 0, 0, 1)
				}):Play()
				tweenserv:Create(Progress, TweenInfo.new(duration or 5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					BackgroundColor3 = Color3.new(0, 1, 0)
				}):Play()
				task.wait(duration)
				tweenserv:Create(Background, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					AnchorPoint = NewVector2(1, 0)
				}):Play()
				for i, v in next, notification.Objects do
					tweenserv:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						BackgroundTransparency = 1
					}):Play()
				end
				tweenserv:Create(TextLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					TextTransparency = 1
				}):Play()
				tweenserv:Create(UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1
				}):Play()
			end)
			task.delay(0.25 + duration + 0.25, function()
				notification:remove()
			end)
			table.insert(Library.Notifs, notification)
			NotifContainer.Position = UDim2.new(0, Position.X, 0, Position.Y + (table.find(Library.Notifs, notification) * 25))
			NotifContainer.Size = UDim2.new(0, TextLabel.TextBounds.X + 4, 0, 18)
			Library:updateNotifsPositions(position)
			return notification
		end
	end
    --
	function Library:Disconnect(Connection)
		Connection:Disconnect()
	end
    --
	function Library.NextFlag()
		Library.UnNamedFlags = Library.UnNamedFlags + 1
		return string.format("%.14g", Library.UnNamedFlags)
	end
    --
	function Library:GetConfig()
		local Config = ""
		for Index, Value in pairs(self.Flags) do
			if Index ~= "SettingsConfigurationName" and Index ~= "SettingConfigurationList" and Index ~= "MenuKey" then
				local Value2 = Value
				local Final = ""
                --
				if typeof(Value2) == "Color3" then
					local hue, sat, val = Value2:ToHSV()
                    --
					Final = ("rgb(%s,%s,%s,%s)"):format(hue, sat, val, 1)
				elseif typeof(Value2) == "table" and Value2.Color and Value2.Transparency then
					local hue, sat, val = Value2.Color:ToHSV()
                    --
					Final = ("rgb(%s,%s,%s,%s)"):format(hue, sat, val, Value2.Transparency)
				elseif Value2 ~= nil then
					if typeof(Value2) == "boolean" then
						Value2 = ("bool(%s)"):format(tostring(Value2))
					elseif typeof(Value2) == "table" then
						local New = "table("
                        --
						for Index2, Value3 in pairs(Value2) do
							New = New .. Value3 .. ","
						end
                        --
						if New:sub(#New) == "," then
							New = New:sub(0, #New - 1)
						end
                        --
						Value2 = New .. ")"
					elseif typeof(Value2) == "string" then
						Value2 = ("string(%s)"):format(Value2)
					elseif typeof(Value2) == "number" then
						Value2 = ("number(%s)"):format(Value2)
					end
                    --
					Final = Value2
				end
                --
				Config = Config .. Index .. ": " .. tostring(Final) .. "\n"
			end
		end
        --
		return Config
	end
    --
	function Library:LoadConfig(Config)
		Library:SetFlagsToDefault()
		for i = 1, 10 do
			local Table = string.split(Config, "\n")
			local Table2 = {}
			for Index, Value in pairs(Table) do
				local Table3 = string.split(Value, ":")
                --
				if Table3[1] ~= "ConfigConfig_List" and #Table3 >= 2 then
					local Value = Table3[2]:sub(2, #Table3[2])
                    --
					if Value:sub(1, 3) == "rgb" then
						local Table4 = string.split(Value:sub(5, #Value - 1), ",")
                        --
						Value = Table4
					elseif Value:sub(1, 3) == "key" then
						local Table4 = string.split(Value:sub(5, #Value - 1), ",")
                        --
						if Table4[1] == "nil" and Table4[2] == "nil" then
							Table4[1] = nil
							Table4[2] = nil
						end
                        --
						Value = Table4
					elseif Value:sub(1, 4) == "bool" then
						local Bool = Value:sub(6, #Value - 1)
                        --
						Value = Bool == "true"
					elseif Value:sub(1, 5) == "table" then
						local Table4 = string.split(Value:sub(7, #Value - 1), ",")
                        --
						Value = Table4
					elseif Value:sub(1, 6) == "string" then
						local String = Value:sub(8, #Value - 1)
                        --
						Value = String
					elseif Value:sub(1, 6) == "number" then
						local Number = tonumber(Value:sub(8, #Value - 1))
                        --
						Value = Number
					end
                    --
					Table2[Table3[1]] = Value
				end
			end 
            --
			for i, v in pairs(Table2) do
				if Flags[i] then
					if i ~= "SettingsConfigurationName" and i ~= "SettingConfigurationList" and i ~= "MenuKey" then
						if typeof(Flags[i]) == "table" then
							Flags[i]:Set(v)
						else
							Flags[i](v)
						end
					end
				end
			end
		end
	end
	--
	function Library:SetOpen(bool)
		if typeof(bool) == 'boolean' then
			userinput.MouseIconEnabled = not bool
			Library.Open = bool;
			Library.Holder.Visible = bool;
		end
	end;
    --
	function Library:ChangeAccent(Color)
		Library.Accent = Color
		for obj, theme in next, Library.ThemeObjects do
			if theme:IsA("Frame") or theme:IsA("TextButton") then
				theme.BackgroundColor3 = Color
			elseif theme:IsA("TextLabel") then
				theme.TextColor3 = Color
			elseif theme:IsA("TextButton") and theme.BackgroundTransparency == 1 then
				theme.TextColor3 = Color
			end
		end
	end
    --
	function Library:IsMouseOverFrame(Frame)
		local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;
		if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
            and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
			return true;
		end;
	end;
    --
	function Library:KeybindList()
		local KeyList = {
			Keybinds = {}
		};
		Library.KeyList = KeyList
		local KeyOutline = Library:Create('Frame', {
			Parent = Library.ScreenGui,
			Position = UDim2.new(0.01, 0, 0.5, 0),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			AnchorPoint = NewVector2(0.009999999776482582, 0.5),
			AutomaticSize = Enum.AutomaticSize.XY
		})
		local KeyInline = Library:Create('Frame', {
			Parent = KeyOutline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(0, -2, 0, -2),
			BackgroundColor3 = Color3.new(0.0745, 0.0745, 0.0745),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.XY
		})
		local KeyAccent = Library:Create('Frame', {
			Parent = KeyInline,
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = Library.Accent,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local KeyHolder = Library:Create('Frame', {
			Parent = KeyInline,
			Position = UDim2.new(0, 0, 0, 22),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.XY
		})
		local UIListLayout = Library:Create('UIListLayout', {
			Parent = KeyHolder,
			SortOrder = Enum.SortOrder.LayoutOrder
		})
		local KeyTitle = Library:Create('TextLabel', {
			Parent = KeyInline,
			Size = UDim2.new(1, 0, 0, 20),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "Keybinds",
			TextColor3 = Color3.new(1, 1, 1),
			FontFace = Library.Font,
			TextSize = 12,
			TextStrokeTransparency = 0
		})
		local LineThing = Library:Create('Frame', {
			Parent = KeyInline,
			Position = UDim2.new(0, 0, 0, 20),
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
        -- Functions
		function KeyList:SetVisible(State)
			KeyOutline.Visible = State;
		end;
        --
		function KeyList:NewKey(Name, Key, Mode)
			local KeyValue = {}
            --
			local NewValue = Library:Create('TextLabel', {
				Parent = KeyHolder,
				Size = UDim2.new(0, 0, 0, 15),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0),
				Text = tostring(" [" .. Key .. "] " .. Name .. " (" .. Mode .. ") "),
				TextColor3 = Color3.new(1, 1, 1),
				FontFace = Library.Font,
				TextSize = 12,
				AutomaticSize = Enum.AutomaticSize.X,
				TextXAlignment = Enum.TextXAlignment.Left,
				Visible = false
			})
            --
			function KeyValue:SetVisible(value)
				NewValue.Visible = value
			end
			function KeyValue:Update(NewName, NewKey, NewMode)
				NewValue.Text = tostring(" [" .. NewName .. "] " .. NewKey .. " (" .. NewMode .. ") ")
				NewValue.Visible = true
			end;
			function KeyValue:SetColorBlue(State)
				if State then
					NewValue.TextColor3 = Library.Accent
				else
					NewValue.TextColor3 = Color3.new(1, 1, 1)
				end
			end
			return KeyValue
		end;
		return KeyList
	end
	    --
		function Library:LoadConfigTab(Window)
			local Config = Window:Page({
				Name = "Settings"
			})
			do
				local Menu = Config:Section({
					Name = "Menu",
					Size = 120
				})
				local Cfgs = Config:Section({
					Name = "Configs",
					Size = 200,
					Side = "Right"
				})
				local abc = false
				local CurrentList = {}
				local CFGList, loadedcfgshit, autoloadlabel, randomfunc
				local function UpdateConfigList()
					local List = {}
					local SelectedConfig = Library.Flags.SettingConfigurationList
					for idx, file in ipairs(listfiles(ConfigFolder .. "/configs")) do
						local FileName = file:gsub(ConfigFolder .. "/configs\\", "")
						List[#List + 1] = FileName
					end
					local IsNew = #List ~= #CurrentList
					if not IsNew then
						for idx, file in ipairs(List) do
							if file ~= CurrentList[idx] then
								IsNew = true
								break
							end
						end
					end
					if IsNew then
						CurrentList = List
						CFGList:Refresh(CurrentList)
					end
					if SelectedConfig then
						randomfunc:set("")
						CFGList:Set(SelectedConfig)
					end
				end
				Menu:Keybind({
					Name = "UI Toggle",
					Flag = "MenuKey",
					Default = Enum.KeyCode.End,
					Mode = "Toggle",
					Callback = function()
						abc = not abc
						Library:SetOpen(abc)
					end
				})
				Menu:Toggle({
					Name = "Keybind List",
					Flag = "KeybindList",
					State = true,
					Callback = function(v)
						Library.KeyshitList:SetVisible(v)
					end
				})
				Menu:Button({
					Name = "Unload",
					Callback = function()
						Library:Unload()
					end
				})
				randomfunc = Cfgs:Textbox({
					Flag = "SettingsConfigurationName",
					Name = "Config name"
				})
				Cfgs:Button({
					Name = "Create",
					Callback = function()
						local ConfigName = Library.Flags.SettingsConfigurationName
						if ConfigName ~= "" or not isfile(ConfigFolder .. "/configs/" .. ConfigName) then
							writefile(ConfigFolder .. "/configs/" .. ConfigName, Library:GetConfig())
							UpdateConfigList()
							randomfunc:set("")
							CFGList:Set(ConfigName)
							Library:Notification("Config Created: " .. ConfigName, 3, nil, "Top")
						end
					end
				})
				CFGList = Cfgs:Dropdown({
					Name = "Saved Configs",
					Flag = "SettingConfigurationList",
					Options = {}
				})
				if not isfolder(ConfigFolder) then
					makefolder(ConfigFolder)
				end
				if not isfolder(ConfigFolder .. "/configs") then
					makefolder(ConfigFolder .. "/configs")
				end
				Cfgs:Button({
					Name = "Save",
					Callback = function()
						local SelectedConfig = Library.Flags.SettingConfigurationList
						if SelectedConfig then
							writefile(ConfigFolder .. "/configs/" .. SelectedConfig, Library:GetConfig())
							Library:Notification("Config Saved: " .. SelectedConfig, 3, nil, "Top")
						else
							Library:Notification("No Config Selected!", 3, nil, "Top")
						end
					end
				})
				Cfgs:Button({
					Name = "Load",
					Callback = function()
						local SelectedConfig = Library.Flags.SettingConfigurationList
						if SelectedConfig then
							Library:LoadConfig(readfile(ConfigFolder .. "/configs/" .. SelectedConfig))
							CFGList:Set(SelectedConfig)
							Library:Notification("Config Loaded: " .. SelectedConfig, 3, nil, "Top")
						else
							Library:Notification("No Config Selected!", 3, nil, "Top")
						end
					end
				})
				Cfgs:Button({
					Name = "Set Auto Load",
					Callback = function()
						local SelectedConfig = Library.Flags.SettingConfigurationList
						if SelectedConfig then
							writefile(ConfigFolder .. "/autoload.txt", Library.Flags.SettingConfigurationList)
							Library:Notification("Config Auto Loaded: " .. Library.Flags.SettingConfigurationList, 7, nil, "Top")
							autoloadlabel:SetText("Current Auto Load: " .. Library.Flags.SettingConfigurationList)
							loadedcfgshit = Library.Flags.SettingConfigurationList
						else
							Library:Notification("No Config Selected!", 3, nil, "Top")
						end
					end
				})
				Cfgs:Button({
					Name = "Delete",
					Callback = function()
						local SelectedConfig = Library.Flags.SettingConfigurationList
						if SelectedConfig then
							delfile(ConfigFolder .. "/configs/" .. SelectedConfig)
							Library:Notification("Config Deleted: " .. SelectedConfig, 3, nil, "Top")
							UpdateConfigList()
							CFGList:Set()
							if SelectedConfig == loadedcfgshit then
								deletefile(ConfigFolder .. "/autoload.txt")
								autoloadlabel:SetText("Current Auto Load: None")
							end
						else
							Library:Notification("No Config Selected!", 3, nil, "Top")
						end
					end
				})
				Cfgs:Button({
					Name = "Refresh",
					Callback = function()
						UpdateConfigList()
						Library:Notification("Config List Refreshed", 3, nil, "Top")
					end
				})
				UpdateConfigList()
				autoloadlabel = Cfgs:Label({
					Name = "Current Auto Load:",
					Centered = true
				})
				if isfile(ConfigFolder .. "/autoload.txt") then
					loadedcfgshit = readfile(ConfigFolder .. "/autoload.txt")
					local configFile = ConfigFolder .. "/configs/" .. loadedcfgshit
					if isfile(configFile) then
						autoloadlabel:SetText("Current Auto Load: " .. loadedcfgshit)
						Library:LoadConfig(readfile(configFile))
						CFGList:Set(loadedcfgshit)
					else
						autoloadlabel:SetText("Current Auto Load: None")
					end
				else
					autoloadlabel:SetText("Current Auto Load: None")
				end
			end
			LocalPlayer.AncestryChanged:Connect(function(_, parent)
				if not parent then
					if #listfiles(ConfigFolder .. "/configs/") == 0 or (isfile(ConfigFolder .. "/configs/last settings") and #listfiles(ConfigFolder .. "/configs/") == 1) then
						writefile(ConfigFolder .. "/configs/last settings", Library:GetConfig())
						writefile(ConfigFolder .. "/autoload.txt", "last settings")
					end
				end
			end)
		end
end
-- // Color Picker Functions
do
	function Library:NewPicker(name, default, defaultalpha, parent, count, flag, callback)
        -- // Instances
		local Icon = Library:Create('TextButton', {
			Parent = parent,
			Position = UDim2.new(1, - (count * 20) - (count * 6), 0.5, 0),
			Size = UDim2.new(0, 20, 0, 10),
			BackgroundColor3 = Color3.fromRGB(45, 45, 45),
			BorderColor3 = Color3.fromRGB(10, 10, 10),
			AnchorPoint = NewVector2(1, 0.5),
			AutoButtonColor = false,
			Text = ""
		})
		local IconInline = Library:Create('Frame', {
			Parent = Icon,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = default,
			BorderSizePixel = 0
		})
		local ColorWindow = Library:Create('Frame', {
			Parent = parent,
			Position = UDim2.new(1, -2, 1, 2),
			Size = UDim2.new(0, 206, 0, 170),
			BackgroundColor3 = Color3.fromRGB(45, 45, 45),
			BorderColor3 = Color3.fromRGB(10, 10, 10),
			AnchorPoint = NewVector2(1, 0),
			ZIndex = 100,
			Visible = false
		})
		local WindowInline = Library:Create('Frame', {
			Parent = ColorWindow,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderSizePixel = 0,
			ZIndex = 100
		})
		local Color = Library:Create('TextButton', {
			Parent = WindowInline,
			Position = UDim2.new(0, 8, 0, 10),
			Size = UDim2.new(0, 150, 0, 150),
			BackgroundColor3 = default,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = 14,
			ZIndex = 100
		})
		local Sat = Library:Create('ImageLabel', {
			Parent = Color,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Image = getcustomasset(Library.Folder .. "sat.jpg"),
			ZIndex = 100
		})
		local Val = Library:Create('ImageLabel', {
			Parent = Color,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Image = getcustomasset(Library.Folder .. "val.jpg"),
			ZIndex = 100
		})
		local Pointer = Library:Create('Frame', {
			Parent = Color,
			Position = UDim2.new(1, 0, 1, 0),
			Size = UDim2.new(0, 1, 0, 1),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ZIndex = 100
		})
		local Container = Library:Create('Frame', {
			Parent = Color,
			Position = UDim2.new(0, -2, 1, 5),
			Size = UDim2.new(0, 189, 0, 55),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0, 0, 0),
			ZIndex = 100
		})
		local ColorOutline = Library:Create('Frame', {
			Parent = Color,
			Position = UDim2.new(0, -1, 0, -1),
			Size = UDim2.new(1, 2, 1, 2),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			ZIndex = 100
		})
		local UIStroke = Library:Create('UIStroke', {
			Parent = ColorOutline,
			Color = Color3.fromRGB(45, 45, 45)
		})
		local Hue = Library:Create('ImageButton', {
			Parent = Color,
			Position = UDim2.new(1, 10, 0, 0),
			Size = UDim2.new(0, 10, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			Image = getcustomasset(Library.Folder .. "hue.jpg"),
			AutoButtonColor = false,
			ZIndex = 100
		})
		local HueOutline = Library:Create('Frame', {
			Parent = Hue,
			Position = UDim2.new(0, -1, 0, -1);
			Size = UDim2.new(1, 2, 1, 2);
			BackgroundColor3 = Color3.new(1, 1, 1);
			BackgroundTransparency = 1;
			BorderSizePixel = 0;
			BorderColor3 = Color3.new(0, 0, 0);
			ZIndex = 100
		})
		local UIStroke2 = Library:Create('UIStroke', {
			Parent = HueOutline;
			Color = Color3.fromRGB(45, 45, 45)
		})
		local Alpha = Library:Create('ImageButton', {
			Parent = Color;
			Position = UDim2.new(1, 30, 0, 0),
			Size = UDim2.new(0, 10, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			Image = getcustomasset(Library.Folder .. "alpha.jpg"),
			AutoButtonColor = false,
			ZIndex = 100
		})
		local AlphaOutline = Library:Create('Frame', {
			Parent = Alpha;
			Position = UDim2.new(0, -1, 0, -1),
			Size = UDim2.new(1, 2, 1, 2),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			ZIndex = 100
		})
		local UIStroke3 = Library:Create('UIStroke', {
			Parent = AlphaOutline;
			Color = Color3.fromRGB(45, 45, 45)
		})
		local HueSlide = Library:Create('Frame', {
			Parent = Hue;
			Size = UDim2.new(1, 0, 0, 3),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local AlphaSlide = Library:Create('Frame', {
			Parent = Alpha;
			Size = UDim2.new(1, 0, 0, 3),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ZIndex = 100
		})
		local ModeOutline = Library:Create('Frame', {
			Parent = parent;
			Position = UDim2.new(1, 65, 0.5, 0),
			Size = UDim2.new(0, 60, 0, 12),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			AnchorPoint = NewVector2(1, 0.5),
			AutomaticSize = Enum.AutomaticSize.Y,
			Visible = false,
			ZIndex = 1020000010
		})
		local ModeInline = Library:Create('Frame', {
			Parent = ModeOutline;
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			ZIndex = 100
		})
		local UIListLayout = Library:Create('UIListLayout', {
			Parent = ModeInline;
			SortOrder = Enum.SortOrder.LayoutOrder
		})
		local Hold = Library:Create('TextButton', {
			Parent = ModeInline;
			Size = UDim2.new(1, 0, 0, 15),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "Copy",
			TextColor3 = Color3.fromRGB(145, 145, 145),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextStrokeTransparency = 0,
			ZIndex = 100
		})
		local Toggle = Library:Create('TextButton', {
			Parent = ModeInline;
			Size = UDim2.new(1, 0, 0, 15),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "Paste",
			TextColor3 = Color3.fromRGB(145, 145, 145),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextStrokeTransparency = 0,
			ZIndex = 100
		})
		Library:Connection(Icon.MouseEnter, function()
			Icon.BorderColor3 = Library.Accent
		end)
        --
		Library:Connection(Icon.MouseLeave, function()
			Icon.BorderColor3 = Color3.fromRGB(10, 10, 10)
		end)

        -- // Connections
		local hue, sat, val = default:ToHSV()
		local hsv = default:ToHSV()
		local alpha = defaultalpha
		local slidingsaturation = false
		local slidinghue = false
		local slidingalpha = false
		local function update()
			local real_pos = userinput:GetMouseLocation()
			local mouse_position = NewVector2(real_pos.X, real_pos.Y - 40)
			local relative_palette = (mouse_position - Color.AbsolutePosition)
			local relative_hue     = (mouse_position - Hue.AbsolutePosition)
			local relative_opacity = (mouse_position - Alpha.AbsolutePosition)
            --
			if slidingsaturation then
				sat = math.clamp(1 - relative_palette.X / Color.AbsoluteSize.X, 0, 1)
				val = math.clamp(1 - relative_palette.Y / Color.AbsoluteSize.Y, 0, 1)
			end 
            --
			if slidinghue then
				hue = math.clamp(relative_hue.Y / Hue.AbsoluteSize.Y, 0, 1)
			end  
            --
			if slidingalpha then
				alpha = math.clamp(relative_opacity.Y / Alpha.AbsoluteSize.Y, 0, 1)
			end
			hsv = Color3.fromHSV(hue, sat, val)
			Pointer.Position = UDim2.new(math.clamp(1 - sat, 0.005, 0.995), 0, math.clamp(1 - val, 0.005, 0.995), 0)
			Color.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
			Alpha.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
			IconInline.BackgroundColor3 = hsv
			HueSlide.Position = UDim2.new(0, 0, math.clamp(hue, 0.005, 0.995), 0)
			AlphaSlide.Position = UDim2.new(0, 0, math.clamp(alpha, 0.005, 0.995), 0)
			if flag then
				Library.Flags[flag] = {}
				Library.Flags[flag]["Color"] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
				Library.Flags[flag]["Transparency"] = alpha
			end
			callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255), alpha)
		end
		local function set(color, a)
			if type(color) == "table" then
				a = color[4]
				color = Color3.fromHSV(color[1], color[2], color[3])
			end
			if type(color) == "string" then
				color = Color3.fromHex(color)
			end
			local oldcolor = hsv
			local oldalpha = alpha
			hue, sat, val = color:ToHSV()
			alpha = a or 1
			hsv = Color3.fromHSV(hue, sat, val)
			if hsv ~= oldcolor then
				IconInline.BackgroundColor3 = hsv
				Color.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				Pointer.Position = UDim2.new(math.clamp(1 - sat, 0.005, 0.995), 0, math.clamp(1 - val, 0.005, 0.995), 0)
				Alpha.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				HueSlide.Position = UDim2.new(0, 0, math.clamp(hue, 0.005, 0.995), 0)
				AlphaSlide.Position = UDim2.new(0, 0, math.clamp(alpha, 0.005, 0.995), 0)
				if flag then
					Library.Flags[flag] = {}
					Library.Flags[flag]["Color"] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
					Library.Flags[flag]["Transparency"] = alpha
				end
				callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255), alpha)
			end
		end
		Flags[flag] = set
		set(default, defaultalpha)
		Library:Connection(Sat.InputBegan, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				slidingsaturation = true
				update()
			end
		end)
		Library:Connection(Sat.InputEnded, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				slidingsaturation = false
				update()
			end
		end)
		Library:Connection(Hue.InputBegan, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				slidinghue = true
				update()
			end
		end)
		Library:Connection(Hue.InputEnded, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				slidinghue = false
				update()
			end
		end)
		Library:Connection(Alpha.InputBegan, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				slidingalpha = true
				update()
			end
		end)
		Library:Connection(Alpha.InputEnded, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				slidingalpha = false
				update()
			end
		end)
		Library:Connection(userinput.InputChanged, function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				if slidingalpha then
					update()
				end
				if slidinghue then
					update()
				end
				if slidingsaturation then
					update()
				end
			end
		end)
		Library:Connection(Icon.MouseButton1Down, function()
			ColorWindow.Visible = not ColorWindow.Visible
			parent.ZIndex = ColorWindow.Visible and 5 or 1
			if slidinghue then
				slidinghue = false
			end
			if slidingsaturation then
				slidingsaturation = false
			end
			if slidingalpha then
				slidingalpha = false
			end
		end)
		Library:Connection(Icon.MouseButton2Down, function()
			ModeOutline.Visible = not ModeOutline.Visible
		end)
        --
		Library:Connection(Hold.MouseButton1Down, function()
			Library.CopiedColor = hsv
			Library.CopiedAlpha = alpha
		end)
        --
		Library:Connection(Toggle.MouseButton1Down, function()
			set(Library.CopiedColor or Color3.new(1, 1, 1), Library.CopiedAlpha or 0)
		end)
        --
		Library:Connection(userinput.InputBegan, function(Input)
			if ModeOutline.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
				if not Library:IsMouseOverFrame(Icon) then
					ModeOutline.Visible = false
				end
			end
		end)
		local colorpickertypes = {}
		function colorpickertypes:Set(color, newalpha)
			set(color, newalpha)
		end
		Library:Connection(userinput.InputBegan, function(Input)
			if ColorWindow.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
				if not Library:IsMouseOverFrame(ColorWindow) and not Library:IsMouseOverFrame(Icon) then
					ColorWindow.Visible = false
					parent.ZIndex = 1
				end
			end
		end)
		return colorpickertypes, ColorWindow
	end
end
-- // Doc Functions
do
	local Pages = Library.Pages;
	local Sections = Library.Sections;
	function Library:Window(Options)
		local Window = {
			Pages = {};
			Sections = {};
			Elements = {};
			Dragging = {
				false,
				UDim2.new(0, 0, 0, 0)
			};
			Size = Options.Size or Options.size or UDim2.new(0, 550, 0, 600);
		};
		Library.ScreenGui = Library:Create("ScreenGui", {
			Parent = gethui(),
			DisplayOrder = 2
		}, true)
		local Outline = Library:Create('Frame', {
			Parent = Library.ScreenGui,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = Window.Size,
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			AnchorPoint = Vector2.new(0.5, 0.5)
		})
		local Inline = Library:Create('Frame', {
			Parent = Outline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.0784, 0.0784, 0.0784),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Accent = Library:Create('Frame', {
			Parent = Inline,
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = Library.Accent,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local HolderOutline = Library:Create('Frame', {
			Parent = Inline,
			Position = UDim2.new(0, 7, 0, 21),
			Size = UDim2.new(1, -14, 1, -38),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392)
		})
		local HolderInline = Library:Create('Frame', {
			Parent = HolderOutline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.0784, 0.0784, 0.0784),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Tabs = Library:Create('Frame', {
			Parent = HolderInline,
			Size = UDim2.new(1, 0, 0, 22),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local UIListLayout = Library:Create('UIListLayout', {
			Parent = Tabs,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder
		})
		local DragButton = Library:Create('TextButton', {
			Parent = Outline,
			Size = UDim2.new(1, 0, 0, 21),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "soulhub",
			TextColor3 = Library.Accent,
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextStrokeTransparency = 0
		})
		local cursor = Library:Create("ImageLabel", {
			Size = UDim2.new(0, 18, 0, 18),
			BackgroundTransparency = 1,
			ImageColor3 = Library.Accent,
			Image = getcustomasset(Library.Folder .. "cursor.jpg"),
			ZIndex = 999,
			Parent = Library.ScreenGui,
		})
		Library:Connection(runserv.RenderStepped, function()
			cursor.Position = UDim2.new(0, Mouse.X - 6, 0, Mouse.Y - 2)
			cursor.Visible = Library.Open
		end)
        --
		Library.KeyshitList = Library:KeybindList()
		Library.Holder = Outline
		table.insert(Library.ThemeObjects, Accent)
		Window.Elements = {
			TabHolder = Tabs,
			Holder = HolderInline
		}
		Library:Connection(DragButton.MouseButton1Down, function()
			local Location = userinput:GetMouseLocation()
			Window.Dragging[1] = true
			Window.Dragging[2] = UDim2.new(0, Location.X - Outline.AbsolutePosition.X, 0, Location.Y - Outline.AbsolutePosition.Y)
		end)
		Library:Connection(userinput.InputEnded, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and Window.Dragging[1] then
				local Location = userinput:GetMouseLocation()
				Window.Dragging[1] = false
				Window.Dragging[2] = UDim2.new(0, 0, 0, 0)
			end
		end)
		Library:Connection(userinput.InputChanged, function(Input)
			local Location = userinput:GetMouseLocation()
			local ActualLocation = nil
			if Window.Dragging[1] then
				Outline.Position = UDim2.new(
                    0,
                    Location.X - Window.Dragging[2].X.Offset + (Outline.Size.X.Offset * Outline.AnchorPoint.X),
                    0,
                    Location.Y - Window.Dragging[2].Y.Offset + (Outline.Size.Y.Offset * Outline.AnchorPoint.Y)
                )
			end
		end)
		function Window:UpdateTabs()
			for Index, Page in pairs(Window.Pages) do
				Page.Elements.Button.Size = UDim2.new(1 / #Window.Pages, 0, 1, 0)
				Page:Turn(Page.Open)
			end
		end
		userinput.MouseIconEnabled = false
		Library.Holder = Outline
		return setmetatable(Window, Library)
	end
    --
	function Library:Page(Properties)
		if not Properties then
			Properties = {}
		end
        --
		local Page = {
			Name = Properties.Name or "Page",
			Window = self,
			Open = false,
			Sections = {},
			Elements = {},
			Chapters = {},
			Icons = Properties.Chapters or Properties.chapters or false,
		}
        --
		local TabButton = Library:Create('TextButton', {
			Parent = Page.Window.Elements.TabHolder,
			Size = UDim2.new(0.25, 0, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = Page.Name,
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextStrokeTransparency = 0,
			LineHeight = 1.1
		})
		local TabAccent = Library:Create('Frame', {
			Parent = TabButton,
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = Library.Accent,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Visible = false
		})
		local ChapterOutline = Library:Create('Frame', {
			Parent = Page.Window.Elements.Holder,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.fromRGB(45, 45, 45),
			BorderColor3 = Color3.fromRGB(10, 10, 10),
			Position = UDim2.new(0, 5, 1, -42),
			Size = UDim2.new(1, -10, 0, 40),
			Visible = false
		})
		local ChapterInline = Library:Create('Frame', {
			Parent = ChapterOutline,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2)
		})
		local Left = Library:Create('Frame', {
			Parent = Page.Window.Elements.Holder,
			Position = UDim2.new(0, 5, 0, 35),
			Size = UDim2.new(0.485, -3, 1, -40),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0, 0, 0),
			Visible = false,
			ZIndex = 3
		})
		local Right = Library:Create('Frame', {
			Parent = Page.Window.Elements.Holder,
			Position = UDim2.new(1, -5, 0, 35),
			Size = UDim2.new(0.485, -3, 1, -40),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			AnchorPoint = Vector2.new(1, 0),
			Visible = false,
			BackgroundTransparency = 1
		})
		local UIListLayout = Library:Create('UIListLayout', {
			Parent = Left,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 12)
		})
		local UIListLayout_2 = Library:Create('UIListLayout', {
			Parent = Right,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 12)
		})
		table.insert(Library.ThemeObjects, TabAccent)
		function Page:Turn(bool)
			Page.Open = bool
			if not Page.Icons then
				Left.Visible = Page.Open
				Right.Visible = Page.Open
			else
				ChapterOutline.Visible = Page.Open
				for Index, Chapter in pairs(Page.Chapters) do
					Chapter:Turn(Chapter.Open)
				end
			end
			TabAccent.Visible = Page.Open
			TabButton.TextColor3 = Page.Open and Library.Accent or Color3.fromRGB(145, 145, 145)
		end
        --
		Library:Connection(TabButton.MouseButton1Down, function()
			if not Page.Open then
				Page:Turn(true)
				for _, Pages in pairs(Page.Window.Pages) do
					if Pages.Open and Pages ~= Page then
						Pages:Turn(false)
					end
				end
			end
		end)
        --
		Library:Connection(TabButton.MouseEnter, function()
			if not Page.Open then
				TabButton.TextColor3 = Library.Accent
			end
		end)
        --
		Library:Connection(TabButton.MouseLeave, function()
			if not Page.Open then
				TabButton.TextColor3 = Color3.fromRGB(145, 145, 145)
			end
		end)

        -- // Functions
		function Page:UpdateChapters()
			for Index, Chapter in pairs(Page.Chapters) do
				Chapter.Elements.Button.Size = UDim2.new(1 / #Page.Chapters, 0, 1, 0)
				Chapter:Turn(Chapter.Open)
			end
		end
		local backoutline = Library:Create('Frame', {
			Parent = ChapterInline,
			BackgroundColor3 = Color3.fromRGB(45, 45, 45),
			BorderColor3 = Color3.fromRGB(10, 10, 10),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(1, -169, 2.125, 0),
			Size = UDim2.new(0, 70, 0, 28),
			Visible = true
		})
		local Backinline = Library:Create('Frame', {
			Parent = backoutline,
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2)
		})
		local Back = Library:Create("TextButton", {
			Parent = Backinline,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Text = "previous",
			TextColor3 = Color3.fromRGB(145, 145, 145),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextWrapped = true
		})
		local Nextoutline = Library:Create('Frame', {
			Parent = ChapterInline,
			BackgroundColor3 = Color3.fromRGB(45, 45, 45),
			BorderColor3 = Color3.fromRGB(10, 10, 10),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(1, -55, 2.125, 0),
			Size = UDim2.new(0, 70, 0, 28),
			Visible = true
		})
		local Nextinline = Library:Create('Frame', {
			Parent = Nextoutline,
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2)
		})
		local Next = Library:Create("TextButton", {
			Parent = Nextinline,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Text = "next",
			TextColor3 = Color3.fromRGB(145, 145, 145),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextWrapped = true
		})
		local Pageindexoutline = Library:Create('Frame', {
			Parent = ChapterInline,
			BackgroundColor3 = Color3.fromRGB(45, 45, 45),
			BorderColor3 = Color3.fromRGB(10, 10, 10),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(1, -91, 2.125, 0),
			Size = UDim2.new(0, 30, 0, 28),
			Visible = true
		})
		local Pageindexinline = Library:Create('Frame', {
			Parent = Pageindexoutline,
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2)
		})
		local Pageindextext = Library:Create('TextLabel', {
			Parent = Pageindexinline,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			Size = UDim2.new(1, 0, 1, 0),
			TextColor3 = Color3.fromRGB(255, 255, 255, 255),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			BackgroundTransparency = 1,
			TextWrapped = true
		})
        -- // Elements
		Page.Elements = {
			Next = Next,
			Back = Back,
			Left = Page.Icons and nil or Left,
			Right = Page.Icons and nil or Right,
			Button = TabButton,
			Pageindextext = Pageindextext,
			ChapterOutline = ChapterOutline,
			ChapterInline = ChapterInline,
		}

        -- // Drawings
		if #Page.Window.Pages == 0 then
			Page:Turn(true)
		end
		Page.Window.Pages[#Page.Window.Pages + 1] = Page
		Page.Window:UpdateTabs()
		return setmetatable(Page, Library.Pages)
	end
    --
	function Pages:Chapter(Properties)
		if not Properties then
			Properties = {}
		end
        --
		local Chapter = {
			Name = Properties.Name or "Chapter",
			Window = self,
			Open = false,
			Sections = {},
			Elements = {},
		}
        --
		local Left = Library:Create('Frame', {
			Parent = Chapter.Window.Window.Elements.Holder,
			Position = UDim2.new(0, 5, 0, 35),
			Size = UDim2.new(0.485, -3, 1, -40),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0, 0, 0),
			Visible = false,
			ZIndex = 3
		})
		local Right = Library:Create('Frame', {
			Parent = Chapter.Window.Window.Elements.Holder,
			Position = UDim2.new(1, -5, 0, 35),
			Size = UDim2.new(0.485, -3, 1, -40),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			AnchorPoint = Vector2.new(1, 0),
			Visible = false,
			BackgroundTransparency = 1
		})
		local UIListLayout = Library:Create('UIListLayout', {
			Parent = Left,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 12)
		})
		local UIListLayout_2 = Library:Create('UIListLayout', {
			Parent = Right,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 12)
		})
        --
        --
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 12)
		local pageIndex = 1
		function Chapter:Turn(bool)
			Chapter.Open = bool
			Left.Visible = Chapter.Open and Chapter.Window.Open
			Right.Visible = Chapter.Open and Chapter.Window.Open
			Chapter.Window.Elements.Pageindextext.Text = pageIndex .. "/" .. #Chapter.Window.Chapters
			if pageIndex == 1 then
				Chapter.Window.Elements.Back.TextColor3 = Color3.fromRGB(145, 145, 145)
				Chapter.Window.Elements.Next.TextColor3 = Library.Accent
			elseif pageIndex == #Chapter.Window.Chapters then
				Chapter.Window.Elements.Back.TextColor3 = Library.Accent
				Chapter.Window.Elements.Next.TextColor3 = Color3.fromRGB(145, 145, 145)
			else
				Chapter.Window.Elements.Back.TextColor3 = Library.Accent
				Chapter.Window.Elements.Next.TextColor3 = Library.Accent
			end
        --  New.TextColor3 = Chapter.Open and Color3.new(1,1,1) or Color3.fromRGB(145,145,145)
		end
        --
		Library:Connection(Chapter.Window.Elements.Back.MouseButton1Down, function()
			if pageIndex ~= 1 then
				pageIndex = pageIndex - 1
				if pageIndex < 1 then
					pageIndex = #Chapter.Window.Chapters
				end
				for _, Chapters in pairs(Chapter.Window.Chapters) do
					if Chapters.Open and Chapters ~= Chapter.Window.Chapters[pageIndex] then
						Chapters:Turn(false)
					elseif Chapters == Chapter.Window.Chapters[pageIndex] then
						Chapters:Turn(true)
					end
				end
			end
		end)
		Library:Connection(Chapter.Window.Elements.Next.MouseButton1Down, function()
			if pageIndex ~= #Chapter.Window.Chapters then
				pageIndex = pageIndex + 1
				if pageIndex > #Chapter.Window.Chapters then
					pageIndex = 1
				end
				--  if not Chapter.Open then
				for _, Chapters in pairs(Chapter.Window.Chapters) do
					if Chapters.Open and Chapters ~= Chapter.Window.Chapters[pageIndex] then
						Chapters:Turn(false)
					elseif Chapters == Chapter.Window.Chapters[pageIndex] then
						Chapters:Turn(true)
					end
				end
			end
		end)
        
    
        -- // Elements
		Chapter.Elements = {
			Left = Left,
			Right = Right,
        -- Button = New
		}
    
        -- // Drawings
		if #Chapter.Window.Chapters == 0 then
			Chapter:Turn(true)
		end
		Chapter.Window.Chapters[#Chapter.Window.Chapters + 1] = Chapter
    -- Chapter.Window:UpdateChapters()
		return setmetatable(Chapter, Library.Pages)
	end    
    --
	function Pages:Section(Properties)
		if not Properties then
			Properties = {}
		end
        --
		local Section = {
			Name = Properties.Name or "Section",
			Page = self,
			Side = (Properties.side or Properties.Side or "left"):lower(),
			ZIndex = Properties.ZIndex or 1, -- Idfk why
			Elements = {},
			Content = {},
		}
        --
		local SectionOutline = Library:Create('Frame', {
			Parent = Section.Side == "left" and Section.Page.Elements.Left or Section.Side == "right" and Section.Page.Elements.Right,
			Size = UDim2.new(1, 0, 0, 20),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = Section.ZIndex
		})
		local SectionInline = Library:Create('Frame', {
			Parent = SectionOutline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.0784, 0.0784, 0.0784),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Container = Library:Create('Frame', {
			Parent = SectionInline,
			Position = UDim2.new(0, 7, 0, 10),
			Size = UDim2.new(1, -14, 1, -10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y
		})
		local UIListLayout = Library:Create('UIListLayout', {
			Parent = Container,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 10)
		})
		local Space = Library:Create('Frame', {
			Parent = Container,
			Position = UDim2.new(0, 0, 1, 0),
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			LayoutOrder = 1000
		})
		local SectionAccent = Library:Create('Frame', {
			Parent = SectionInline,
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = Library.Accent,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Title = Library:Create('TextLabel', {
			Parent = SectionOutline,
			Position = UDim2.new(0, 10, 0, -8),
			Size = UDim2.new(0, 100, 0, 16),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			TextColor3 = Color3.new(1, 1, 1),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			ZIndex = 3,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = Section.Name,
			TextStrokeTransparency = 0
		})
		local TextBorder = Library:Create('Frame', {
			Parent = SectionOutline,
			Position = UDim2.new(0, 6, 0, -2),
			Size = UDim2.new(0, Title.TextBounds.X + 8, 0, 4),
			BackgroundColor3 = Color3.new(0.0784, 0.0784, 0.0784),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
        --
		table.insert(Library.ThemeObjects, SectionAccent)
		table.insert(Library.ThemeObjects, SectionAccent)
        
        -- // Elements
		Section.Elements = {
			SectionContent = Container;
			SectionHolder = SectionOutline;
		}

        -- // Returning
		Section.Page.Sections[#Section.Page.Sections + 1] = Section
		wait(0.01)
		TextBorder.Size = UDim2.new(0, Title.TextBounds.X + 8, 0, 4)
		return setmetatable(Section, Library.Sections)
	end
    --
	function Sections:Toggle(Properties)
		if not Properties then
			Properties = {}
		end
        --
		local Toggle = {
			Window = self.Window,
			Page = self.Page,
			Section = self,
			Risky = Properties.Risky or false,
			Name = Properties.Name or "Toggle",
			State = (
                Properties.state
                    or Properties.State
                    or Properties.def
                    or Properties.Def
                    or Properties.default
                    or Properties.Default
                    or false
            ),
			Callback = (
                Properties.callback
                    or Properties.Callback
                    or Properties.callBack
                    or Properties.CallBack
                    or function()
			end
            ),
			Flag = (
                Properties.flag
                    or Properties.Flag
                    or Properties.pointer
                    or Properties.Pointer
                    or Library.NextFlag()
            ),
			Toggled = false,
			Colorpickers = 0,
			ListValue = nil,
		}
        --
		local NewToggle = Library:Create('TextButton', {
			Parent = Toggle.Section.Elements.SectionContent,
			Size = UDim2.new(1, 0, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = 14
		})
		local Outline = Library:Create('Frame', {
			Parent = NewToggle,
			Size = UDim2.new(0, 10, 0, 10),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392)
		})
		local Inline = Library:Create('Frame', {
			Parent = Outline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Title = Library:Create('TextLabel', {
			Parent = NewToggle,
			Position = UDim2.new(0, 15, 0, 0),
			Size = UDim2.new(1, 0, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			TextColor3 = Toggle.Risky and Color3.fromRGB(255, 77, 74) or Color3.new(0.5686, 0.5686, 0.5686),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = Toggle.Name,
			TextStrokeTransparency = 0
		})
        -- // Functions
		local function SetState(value)
			if value == true then
				Toggle.Toggled = true
			elseif value == false then
				Toggle.Toggled = false
			else
				Toggle.Toggled = not Toggle.Toggled
			end
			if Toggle.Toggled then
				table.insert(Library.ThemeObjects, Inline)
				Inline.BackgroundColor3 = Library.Accent
				if Toggle.Risky then
					Title.TextColor3 = Color3.fromRGB(255, 0, 0)
				else
					Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				end
				if Toggle.ListValue then
					Toggle.ListValue:SetColorBlue(true)
				end
			else
				table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, Inline))
				Inline.BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294)
				if Toggle.Risky then
					Title.TextColor3 = Color3.fromRGB(255, 77, 74)
				else
					Title.TextColor3 = Color3.fromRGB(145, 145, 145)
				end
				if Toggle.ListValue then
					Toggle.ListValue:SetColorBlue(false)
				end
			end
			Library.Flags[Toggle.Flag] = Toggle.Toggled
			task.spawn(Toggle.Callback, Toggle.Toggled)
		end
        --
		Library:Connection(NewToggle.MouseButton1Down, SetState)
		Library:Connection(NewToggle.MouseEnter, function()
			if not Toggle.Toggled then
				table.insert(Library.ThemeObjects, Title)
				Title.TextColor3 = Library.Accent
			end
		end)
        --
		Library:Connection(NewToggle.MouseLeave, function()
			if not Toggle.Toggled then
				table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, Title))
				if Toggle.Risky then
					Title.TextColor3 = Color3.fromRGB(255, 77, 74)
				else
					Title.TextColor3 = Color3.fromRGB(145, 145, 145)
				end
			else
				table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, Title))
			end
		end)
		function Toggle:Keybind(Properties)
			local Properties = Properties or {}
			local Keybind = {
				Section = self,
				State = (
                    Properties.state
                        or Properties.State
                        or Properties.def
                        or Properties.Def
                        or Properties.default
                        or Properties.Default
                        or nil
                ),
				Mode = (Properties.mode or Properties.Mode or "Toggle"),
				Ignore = (Properties.ignore or Properties.Ignore or false),
				UseKey = (Properties.UseKey or false),
				Callback = (
                    Properties.callback
                        or Properties.Callback
                        or Properties.callBack
                        or Properties.CallBack
                        or function()
				end
                ),
				Flag = (
                    Properties.flag
                        or Properties.Flag
                        or Properties.pointer
                        or Properties.Pointer
                        or Library.NextFlag()
                ),
				Name = Properties.name or Properties.Name or "Keybind",
				Binding = nil,
			}
			local Key
			local State = false
            --
			local Outline = Library:Create('TextButton', {
				Parent = NewToggle,
				Position = UDim2.new(1, 0, 0.5, 0),
				Size = UDim2.new(0, 40, 0, 12),
				BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
				BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
				AnchorPoint = NewVector2(1, 0.5),
				Text = "",
				AutoButtonColor = false
			})
			local Inline = Library:Create('Frame', {
				Parent = Outline,
				Position = UDim2.new(0, 1, 0, 1),
				Size = UDim2.new(1, -2, 1, -2),
				BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0)
			})
			local Value = Library:Create('TextLabel', {
				Parent = Inline,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0),
				Text = "",
				TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
				FontFace = Library.Font,
				TextSize = Library.FontSize,
				TextStrokeTransparency = 0
			})
			local ModeOutline = Library:Create('Frame', {
				Parent = NewToggle,
				Position = UDim2.new(1, 65, 0.5, 0),
				Size = UDim2.new(0, 60, 0, 12),
				BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
				BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
				AnchorPoint = NewVector2(1, 0.5),
				AutomaticSize = Enum.AutomaticSize.Y,
				Visible = false,
				ZIndex = 1020000010
			})
			local ModeInline = Library:Create('Frame', {
				Parent = ModeOutline,
				Position = UDim2.new(0, 1, 0, 1),
				Size = UDim2.new(1, -2, 1, -2),
				BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0),
				ZIndex = 1020000011
			})
			local UIListLayout = Library:Create('UIListLayout', {
				Parent = ModeInline,
				SortOrder = Enum.SortOrder.LayoutOrder
			})
			local Hold = Library:Create('TextButton', {
				Parent = ModeInline,
				Size = UDim2.new(1, 0, 0, 15),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0),
				Text = "Hold",
				TextColor3 = Keybind.Mode == "Hold" and Color3.new(1, 1, 1) or Color3.new(0.5686, 0.5686, 0.5686),
				AutoButtonColor = false,
				FontFace = Library.Font,
				TextSize = Library.FontSize,
				TextStrokeTransparency = 0,
				ZIndex = 1020000011
			})
			local Toggle = Library:Create('TextButton', {
				Parent = ModeInline,
				Size = UDim2.new(1, 0, 0, 15),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(0, 0, 0),
				Text = "Toggle",
				TextColor3 = Keybind.Mode == "Toggle" and Color3.new(1, 1, 1) or Color3.new(0.5686, 0.5686, 0.5686),
				AutoButtonColor = false,
				FontFace = Library.Font,
				TextSize = Library.FontSize,
				TextStrokeTransparency = 0,
				ZIndex = 1020000011
			})
			self.ListValue = Library.KeyList:NewKey(tostring(Keybind.State):gsub("Enum.KeyCode.", ""), Title.Text, Keybind.Mode)
			local c
            -- // Functions
			local function set(newkey)
				if string.find(tostring(newkey), "Enum") then
					if c then
						c:Disconnect()
						SetState(false)
					end
					if tostring(newkey):find("Enum.KeyCode.") then
						newkey = Enum.KeyCode[tostring(newkey):gsub("Enum.KeyCode.", "")]
					elseif tostring(newkey):find("Enum.UserInputType.") then
						newkey = Enum.UserInputType[tostring(newkey):gsub("Enum.UserInputType.", "")]
					end
					if newkey == Enum.KeyCode.Backspace or newkey == Enum.KeyCode.Escape then
						Key = nil
						if Keybind.UseKey then
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = Key
							end
							task.spawn(Keybind.Callback, Key)
						end
						local text = ""
						Value.Text = text
						self.ListValue:Update(text, self.Name, Keybind.Mode)
						self.ListValue:SetVisible(false)
					elseif newkey ~= nil then
						Key = newkey
						if Keybind.UseKey then
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = Key
							end
							task.spawn(Keybind.Callback, Key)
						end
						local text = (Library.Keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", ""))
						Value.Text = text
						self.ListValue:Update(text, self.Name, Keybind.Mode)
					end
					Library.Flags[Keybind.Flag .. "_KEY"] = newkey
				elseif table.find({
					"Toggle",
					"Hold"
				}, newkey) then
					if not Keybind.UseKey then
						Library.Flags[Keybind.Flag .. "_KEY STATE"] = newkey
						Keybind.Mode = newkey
						if Key ~= nil then
							self.ListValue:Update((Library.Keys[Key] or tostring(Key):gsub("Enum.KeyCode.", "")), self.Name, Keybind.Mode)
						end
					end
				else
					State = newkey
					if Keybind.Flag then
						Library.Flags[Keybind.Flag] = newkey
					end
					task.spawn(Keybind.Callback, newkey)
				end
			end
            --
			set(Keybind.State)
			set(Keybind.Mode)
			Library:Connection(Outline.MouseButton1Click, function()
				if not Keybind.Binding then
					Value.Text = "..."
					Keybind.Binding = Library:Connection(
                        userinput.InputBegan,
                        function(input, gpe)
						set(
                                input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode
                                    or input.UserInputType
                            )
						Library:Disconnect(Keybind.Binding)
						task.wait()
						Keybind.Binding = nil
					end
                    )
				end
			end)
            --
			local function isPlayerChatting()
				local textBoxFocused = userinput:GetFocusedTextBox()
				return textBoxFocused ~= nil
			end
			Library:Connection(userinput.InputBegan, function(inp)
				if not isPlayerChatting() then
					if (inp.KeyCode == Key or inp.UserInputType == Key) and not Keybind.Binding and not Keybind.UseKey then
						if Keybind.Mode == "Hold" then
							c = Library:Connection(runserv.RenderStepped, function()
								SetState(true)
							end)
							self.ListValue:SetColorBlue(true)
						elseif Keybind.Mode == "Toggle" then
							SetState()
							self.ListValue:SetColorBlue(self.Toggled)
						end
					end
				end
			end)
            --
			Library:Connection(userinput.InputEnded, function(inp)
				if not isPlayerChatting() then
					if Keybind.Mode == "Hold" and not Keybind.UseKey then
						if Key ~= "" or Key ~= nil then
							if inp.KeyCode == Key or inp.UserInputType == Key then
								if c then
									c:Disconnect()
									SetState(false)
									self.ListValue:SetColorBlue(false)
								end
							end
						end
					end
				end
			end)
            --
			Library:Connection(Outline.MouseEnter, function()
				Outline.BorderColor3 = Library.Accent
			end)
            --
			Library:Connection(Outline.MouseLeave, function()
				Outline.BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392)
			end)
            --
			Library:Connection(Outline.MouseButton2Down, function()
				ModeOutline.Visible = not ModeOutline.Visible
			end)
            --
			Library:Connection(Hold.MouseButton1Down, function()
				set("Hold")
				Hold.TextColor3 = Color3.new(1, 1, 1)
				Toggle.TextColor3 = Color3.fromRGB(145, 145, 145)
			end)
            --
			Library:Connection(Toggle.MouseButton1Down, function()
				set("Toggle")
				Hold.TextColor3 = Color3.fromRGB(145, 145, 145)
				Toggle.TextColor3 = Color3.new(1, 1, 1)
			end)
            --
			Library:Connection(userinput.InputBegan, function(Input)
				if ModeOutline.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(ModeOutline) then
						ModeOutline.Visible = false
					end
				end
			end)
            --
			Library.Flags[Keybind.Flag .. "_KEY"] = Keybind.State
			Library.Flags[Keybind.Flag .. "_KEY STATE"] = Keybind.Mode
			Flags[Keybind.Flag] = set
			Flags[Keybind.Flag .. "_KEY"] = set
			Flags[Keybind.Flag .. "_KEY STATE"] = set
            --
			function Keybind:Set(key)
				set(key)
			end
        
            -- // Returning
			return Keybind
		end
		function Toggle:Colorpicker(Properties)
			local Properties = Properties or {}
			local Colorpicker = {
				State = (
                    Properties.state
                        or Properties.State
                        or Properties.def
                        or Properties.Def
                        or Properties.default
                        or Properties.Default
                        or Color3.fromRGB(255, 0, 0)
                ),
				Alpha = (
                    Properties.alpha
                        or Properties.Alpha
                        or Properties.transparency
                        or Properties.Transparency
                        or 1
                ),
				Callback = (
                    Properties.callback
                        or Properties.Callback
                        or Properties.callBack
                        or Properties.CallBack
                        or function()
				end
                ),
				Flag = (
                    Properties.flag
                        or Properties.Flag
                        or Properties.pointer
                        or Properties.Pointer
                        or Library.NextFlag()
                ),
			}
            -- // Functions
			Toggle.Colorpickers = Toggle.Colorpickers + 1
			local colorpickertypes = Library:NewPicker(
                "",
                Colorpicker.State,
                Colorpicker.Alpha,
                NewToggle,
                Toggle.Colorpickers - 1,
                Colorpicker.Flag,
                Colorpicker.Callback
            )
			function Colorpicker:Set(color)
				colorpickertypes:set(color)
			end

            -- // Returning
			return Colorpicker
		end
        
        -- // Misc Functions
		function Toggle.Set(bool)
			bool = type(bool) == "boolean" and bool or false
			if Toggle.Toggled ~= bool then
				SetState()
			end
		end
		Toggle.Set(Toggle.State)
		Library.Flags[Toggle.Flag] = Toggle.State
		Flags[Toggle.Flag] = Toggle.Set

        -- // Returning
		return Toggle
	end
    --
	function Sections:Slider(Properties)
		if not Properties then
			Properties = {}
		end
        --
		local Slider = {
			Window = self.Window,
			Page = self.Page,
			Section = self,
			Name = Properties.Name or nil,
			Min = (Properties.min or Properties.Min or Properties.minimum or Properties.Minimum or 0),
			State = (
                Properties.state
                    or Properties.State
                    or Properties.def
                    or Properties.Def
                    or Properties.default
                    or Properties.Default
                    or 10
            ),
			Max = (Properties.max or Properties.Max or Properties.maximum or Properties.Maximum or 100),
			Sub = (
                Properties.suffix
                    or Properties.Suffix
                    or Properties.ending
                    or Properties.Ending
                    or Properties.prefix
                    or Properties.Prefix
                    or Properties.measurement
                    or Properties.Measurement
                    or ""
            ),
			Decimals = (Properties.decimals or Properties.Decimals or 1),
			Callback = (
                Properties.callback
                    or Properties.Callback
                    or Properties.callBack
                    or Properties.CallBack
                    or function()
			end
            ),
			Flag = (
                Properties.flag
                    or Properties.Flag
                    or Properties.pointer
                    or Properties.Pointer
                    or Library.NextFlag()
            ),
			Disabled = (Properties.Disabled or Properties.disable or nil),
		}
		local TextValue = ("[value]" .. Slider.Sub)
        --
		local NewSlider = Library:Create('TextButton', {
			Parent = Slider.Section.Elements.SectionContent,
			Size = UDim2.new(1, 0, 0, 22),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = 14,
		})
		local Outline = Library:Create('Frame', {
			Parent = NewSlider,
			Position = UDim2.new(0, 15, 1, 0),
			Size = UDim2.new(1, -30, 0, 7),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			AnchorPoint = NewVector2(0, 1)
		})
		local Inline = Library:Create('Frame', {
			Parent = Outline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Accent = Library:Create('TextButton', {
			Parent = Inline,
			Size = UDim2.new(0, 0, 1, 0),
			BackgroundColor3 = Library.Accent,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = 14
		})
		local Add = Library:Create('TextButton', {
			Parent = Outline,
			Position = UDim2.new(1, 5, 0.5, 0),
			Size = UDim2.new(0, 10, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			AnchorPoint = NewVector2(0, 0.5),
			Text = "+",
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextStrokeTransparency = 0
		})
		local Subtract = Library:Create('TextButton', {
			Parent = Outline,
			Position = UDim2.new(0, -15, 0.5, 0),
			Size = UDim2.new(0, 10, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			AnchorPoint = NewVector2(0, 0.5),
			Text = "-",
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextStrokeTransparency = 0
		})
		local Title = Library:Create('TextLabel', {
			Parent = NewSlider,
			Position = UDim2.new(0, 15, 0, 0),
			Size = UDim2.new(1, 0, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = Slider.Name,
			TextStrokeTransparency = 0,
		})
		local Value = Library:Create('TextLabel', {
			Parent = NewSlider,
			Position = UDim2.new(0, 15, 0, 0),
			Size = UDim2.new(1, -30, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			TextColor3 = Color3.new(1, 1, 1),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextStrokeTransparency = 0
		})
        --
		table.insert(Library.ThemeObjects, Accent)
		table.insert(Library.ThemeObjects, Accent)
        
        -- // Functions
		local Sliding = false
		local Val = Slider.State
		local function Round(Number, Float)
			return math.floor(Number / Float + 0.5) * Float
		end
		
		local function Set(value)
			value = math.clamp(Round(value, Slider.Decimals), Slider.Min, Slider.Max)
			local sizeX = ((value - Slider.Min) / (Slider.Max - Slider.Min))
			Accent.Size = UDim2.new(sizeX, 0, 1, 0)
            --Value.Text = TextValue:gsub("%[value%]", string.format("%.14g", value))
			if Slider.Disabled and value == Slider.Min then
				Value.Text = Slider.Disabled
			else
				Value.Text = TextValue:gsub("%[value%]", string.format("%.14g", value))
			end
			Val = value
			Library.Flags[Slider.Flag] = value
			task.spawn(Slider.Callback, value)
		end				
        --
		local function Slide(input)
			local sizeX = (input.Position.X - Outline.AbsolutePosition.X) / Outline.AbsoluteSize.X
			local value = ((Slider.Max - Slider.Min) * sizeX) + Slider.Min
			Set(value)
		end
        --
		Library:Connection(NewSlider.InputBegan, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				Sliding = true
				Slide(input)
			end
		end)
		Library:Connection(NewSlider.InputEnded, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				Sliding = false
			end
		end)
		Library:Connection(Accent.InputBegan, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				Sliding = true
				Slide(input)
			end
		end)
		Library:Connection(Accent.InputEnded, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				Sliding = false
			end
		end)
		Library:Connection(userinput.InputChanged, function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				if Sliding then
					Slide(input)
				end
			end
		end)
		Library:Connection(NewSlider.MouseEnter, function()
			table.insert(Library.ThemeObjects, Title)
			Title.TextColor3 = Library.Accent
		end)
        --
		Library:Connection(NewSlider.MouseLeave, function()
			table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, Title))
			Title.TextColor3 = Color3.new(0.5686, 0.5686, 0.5686)
		end)
        --
		Library:Connection(Subtract.MouseButton1Down, function()
			Set(Val - Slider.Decimals)
		end)
		--
		Library:Connection(Add.MouseButton1Down, function()
			Set(Val + Slider.Decimals)
		end)
        --
		function Slider:Set(Value)
			Set(Value)
		end
        --
		function Slider:SetVisible(Bool)
			NewSlider.Visible = Bool
		end 
        --
		Flags[Slider.Flag] = Set
		Library.Flags[Slider.Flag] = Slider.State
		Set(Slider.State)

        -- // Returning
		return Slider
	end
    --
	function Sections:Dropdown(Properties)
		local Properties = Properties or {};
		local Dropdown = {
			Window = self.Window,
			Page = self.Page,
			Section = self,
			Open = false,
			Name = Properties.Name or Properties.name or nil,
			Options = (Properties.options or Properties.Options or Properties.values or Properties.Values or {
				"1",
				"2",
				"3",
			}),
			Max = (Properties.Max or Properties.max or nil),
			State = (
                Properties.state
                    or Properties.State
                    or Properties.def
                    or Properties.Def
                    or Properties.default
                    or Properties.Default
                    or nil
            ),
			Callback = (
                Properties.callback
                    or Properties.Callback
                    or Properties.callBack
                    or Properties.CallBack
                    or function()
			end
            ),
			Flag = (
                Properties.flag
                    or Properties.Flag
                    or Properties.pointer
                    or Properties.Pointer
                    or Library.NextFlag()
            ),
			OptionInsts = {},
		}
        --
		local NewDrop = Library:Create('Frame', {
			Parent = Dropdown.Section.Elements.SectionContent,
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Outline = Library:Create('TextButton', {
			Parent = NewDrop,
			Position = UDim2.new(0, 15, 1, 0),
			Size = UDim2.new(1, -30, 0, 16),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			AnchorPoint = NewVector2(0, 1),
			Text = "",
			AutoButtonColor = false
		})
		local Inline = Library:Create('Frame', {
			Parent = Outline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Value = Library:Create('TextLabel', {
			Parent = Inline,
			Position = UDim2.new(0, 2, 0, 0),
			Size = UDim2.new(1, -30, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			FontFace = Library.Font,
			Text = "",
			TextSize = Library.FontSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextStrokeTransparency = 0,
			TextWrapped = true
		})
		local Icon = Library:Create('TextLabel', {
			Parent = Inline,
			Position = UDim2.new(0, -5, 0, 0),
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "+",
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextStrokeTransparency = 0
		})
		local Title = Library:Create('TextLabel', {
			Parent = NewDrop,
			Position = UDim2.new(0, 15, 0, 0),
			Size = UDim2.new(1, 0, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextStrokeTransparency = 0,
			Text = Dropdown.Name
		})
		local ContainerOutline = Library:Create('Frame', {
			Parent = NewDrop,
			Position = UDim2.new(0, 15, 1, 2),
			Size = UDim2.new(1, -30, 0, 1),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			Visible = false,
			ZIndex = 5
		})
		local ContainerInline = Library:Create('ScrollingFrame', {
			Parent = ContainerOutline,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 3,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarImageColor3 = Library.Accent,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			ZIndex = 6;
		})
		local UIListLayout = Library:Create('UIListLayout', {
			Parent = ContainerInline,
			SortOrder = Enum.SortOrder.LayoutOrder
		})
        
        -- // Connections
		Library:Connection(Outline.MouseButton1Down, function()
			ContainerOutline.Visible = not ContainerOutline.Visible
			if ContainerOutline.Visible then
				NewDrop.ZIndex = 2
				Icon.Text = "-"
			else
				NewDrop.ZIndex = 1
				Icon.Text = "+"
			end
		end)
		Library:Connection(userinput.InputBegan, function(Input)
			if ContainerOutline.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
				if not Library:IsMouseOverFrame(ContainerOutline) and not Library:IsMouseOverFrame(NewDrop) then
					ContainerOutline.Visible = false
					NewDrop.ZIndex = 1
					Icon.Text = "+"
				end
			end
		end)
		Library:Connection(NewDrop.MouseEnter, function()
			Outline.BorderColor3 = Library.Accent
			table.insert(Library.ThemeObjects, Title)
			Title.TextColor3 = Library.Accent
		end)
        --
		Library:Connection(NewDrop.MouseLeave, function()
			Outline.BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392)
			table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, Title))
			Title.TextColor3 = Color3.new(0.5686, 0.5686, 0.5686)
		end)
        --
		local chosen = Dropdown.Max and {} or nil
        --
		local function handleoptionclick(option, button, text)
			Library:Connection(button.MouseButton1Down, function()
				if Dropdown.Max then
					if table.find(chosen, option) then
						table.remove(chosen, table.find(chosen, option))
						local textchosen = {}
						local cutobject = false
						for _, opt in next, chosen do
							table.insert(textchosen, opt)
						end
						Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")
						text.TextColor3 = Color3.fromRGB(145, 145, 145)
						Library.Flags[Dropdown.Flag] = chosen
						task.spawn(Dropdown.Callback, chosen)
					else
						if #chosen == Dropdown.Max then
							Dropdown.OptionInsts[chosen[1]].text.TextColor3 = Color3.fromRGB(145, 145, 145)
							table.remove(chosen, 1)
						end
						table.insert(chosen, option)
						local textchosen = {}
						local cutobject = false
						for _, opt in next, chosen do
							table.insert(textchosen, opt)
						end
						Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")
						text.TextColor3 = Color3.fromRGB(255, 255, 255)
						Library.Flags[Dropdown.Flag] = chosen
						task.spawn(Dropdown.Callback, chosen)
					end
				else
					for opt, tbl in next, Dropdown.OptionInsts do
						if opt ~= option then
							tbl.text.TextColor3 = Color3.fromRGB(145, 145, 145)
						end
					end
					chosen = option
					Value.Text = option
					text.TextColor3 = Color3.fromRGB(255, 255, 255)
					Library.Flags[Dropdown.Flag] = option
					task.spawn(Dropdown.Callback, option)
				end
			end)
		end
        --
		local function createoptions(tbl)
			for _, option in next, tbl do
				Dropdown.OptionInsts[option] = {}
				local NewOption = Library:Create('TextButton', {
					Parent = ContainerInline,
					Size = UDim2.new(1, 0, 0, 15),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(0, 0, 0),
					Text = "",
					TextColor3 = Color3.new(0, 0, 0),
					AutoButtonColor = false,
					FontFace = Library.Font,
					TextSize = 14,
					ZIndex = 7;
				})
				local OptionName = Library:Create('TextLabel', {
					Parent = NewOption,
					Position = UDim2.new(0, 2, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(0, 0, 0),
					Text = option,
					TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextStrokeTransparency = 0,
					ZIndex = 8;
				})
                --
				if #tbl ~= 0 then
					if #tbl == 1 then
						ContainerOutline.Size = UDim2.new(1, -30, 0, 16.5)
					else
						ContainerOutline.Size = UDim2.new(1, -30, 0, 31.25)
					end
				end
				Dropdown.OptionInsts[option].button = NewOption
				Dropdown.OptionInsts[option].text = OptionName
				handleoptionclick(option, NewOption, OptionName)
			end
		end
		createoptions(Dropdown.Options)
        --
		local set
		set = function(option)
			if Dropdown.Max then
				table.clear(chosen)
				option = type(option) == "table" and option or {}
				for opt, tbl in next, Dropdown.OptionInsts do
					if not table.find(option, opt) then
						tbl.text.TextColor3 = Color3.fromRGB(145, 145, 145)
					end
				end
				for i, opt in next, option do
					if table.find(Dropdown.Options, opt) and #chosen < Dropdown.Max then
						table.insert(chosen, opt)
						Dropdown.OptionInsts[opt].text.TextColor3 = Color3.fromRGB(255, 255, 255)
					end
				end
				local textchosen = {}
				local cutobject = false
				for _, opt in next, chosen do
					table.insert(textchosen, opt)
				end
				Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")
				Library.Flags[Dropdown.Flag] = chosen
				task.spawn(Dropdown.Callback, chosen)
			end
		end
        --
		function Dropdown:Set(option)
			if Dropdown.Max then
				set(option)
			else
				for opt, tbl in next, Dropdown.OptionInsts do
					if opt ~= option then
						tbl.text.TextColor3 = Color3.fromRGB(145, 145, 145)
					end
				end
				if option then
					chosen = option
					if typeof(option) ~= "table" then
						Value.Text = option
					end
					if table.find(Dropdown.Options, option) then
						Dropdown.OptionInsts[option].text.TextColor3 = Color3.fromRGB(255, 255, 255)
					end
					Library.Flags[Dropdown.Flag] = chosen
					task.spawn(Dropdown.Callback, chosen)
				else
					chosen = nil
					Value.Text = ""
					Library.Flags[Dropdown.Flag] = chosen
					task.spawn(Dropdown.Callback, chosen)
				end
			end
		end
        --
		function Dropdown:Refresh(tbl)
			for _, opt in next, Dropdown.OptionInsts do
				coroutine.wrap(function()
					opt.button:Destroy()
				end)()
			end
			table.clear(Dropdown.OptionInsts)
			createoptions(tbl)
			if Dropdown.Max then
				table.clear(chosen)
			else
				chosen = nil
			end
			Library.Flags[Dropdown.Flag] = chosen
			task.spawn(Dropdown.Callback, chosen)
		end

        -- // Returning
		if Dropdown.Max then
			Flags[Dropdown.Flag] = set
		else
			Flags[Dropdown.Flag] = Dropdown
		end
		Dropdown:Set(Dropdown.State)
		function Dropdown:SetVisible(Bool)
			NewDrop.Visible = Bool
		end
		return Dropdown
	end
    --
	function Sections:Keybind(Properties)
		local Properties = Properties or {}
		local Keybind = {
			Section = self,
			Name = Properties.name or Properties.Name or "Keybind",
			State = (
                Properties.state
                    or Properties.State
                    or Properties.def
                    or Properties.Def
                    or Properties.default
                    or Properties.Default
                    or nil
            ),
			Mode = (Properties.mode or Properties.Mode or "Toggle"),
			UseKey = (Properties.UseKey or false),
			Ignore = (Properties.ignore or Properties.Ignore or false),
			Callback = (
                Properties.callback
                    or Properties.Callback
                    or Properties.callBack
                    or Properties.CallBack
                    or function()
			end
            ),
			Flag = (
                Properties.flag
                    or Properties.Flag
                    or Properties.pointer
                    or Properties.Pointer
                    or Library.NextFlag()
            ),
			Binding = nil,
		}
		local Key
		local State = false
        --
		local NewKey = Library:Create('Frame', {
			Parent = Keybind.Section.Elements.SectionContent,
			Size = UDim2.new(1, 0, 0, 12),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Outline = Library:Create('TextButton', {
			Parent = NewKey,
			Position = UDim2.new(1, 0, 0.5, 0),
			Size = UDim2.new(0, 40, 0, 12),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			AnchorPoint = NewVector2(1, 0.5),
			Text = "",
			AutoButtonColor = false
		})
		local Inline = Library:Create('Frame', {
			Parent = Outline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Value = Library:Create('TextLabel', {
			Parent = Inline,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "",
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextStrokeTransparency = 0
		})
		local Title = Library:Create('TextLabel', {
			Parent = NewKey,
			Position = UDim2.new(0, 15, 0, 0),
			Size = UDim2.new(1, 0, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = Keybind.Name,
			TextStrokeTransparency = 0
		})
		local ModeOutline = Library:Create('Frame', {
			Parent = NewKey,
			Position = UDim2.new(1, 65, 0.5, 0),
			Size = UDim2.new(0, 60, 0, 12),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			AnchorPoint = NewVector2(1, 0.5),
			AutomaticSize = Enum.AutomaticSize.Y,
			Visible = false,
			ZIndex = 1020000010
		})
		local ModeInline = Library:Create('Frame', {
			Parent = ModeOutline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			ZIndex = 1020000011
		})
		local UIListLayout = Library:Create('UIListLayout', {
			Parent = ModeInline,
			SortOrder = Enum.SortOrder.LayoutOrder
		})
		local Hold = Library:Create('TextButton', {
			Parent = ModeInline,
			Size = UDim2.new(1, 0, 0, 15),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "Hold",
			TextColor3 = Keybind.Mode == "Hold" and Color3.new(1, 1, 1) or Color3.new(0.5686, 0.5686, 0.5686),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextStrokeTransparency = 0,
			ZIndex = 1020000011
		})
		local Toggle = Library:Create('TextButton', {
			Parent = ModeInline,
			Size = UDim2.new(1, 0, 0, 15),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "Toggle",
			TextColor3 = Keybind.Mode == "Toggle" and Color3.new(1, 1, 1) or Color3.new(0.5686, 0.5686, 0.5686),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextStrokeTransparency = 0,
			ZIndex = 1020000011
		})
		local Always = Library:Create('TextButton', {
			Parent = ModeInline,
			Size = UDim2.new(1, 0, 0, 15),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "Always",
			TextColor3 = Keybind.Mode == "Always" and Color3.new(1, 1, 1) or Color3.new(0.5686, 0.5686, 0.5686),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextStrokeTransparency = 0,
			ZIndex = 1020000011
		})
		local ListValue = Library.KeyList:NewKey(tostring(Keybind.State):gsub("Enum.KeyCode.", ""), Keybind.Name, Keybind.Mode)
		local c
        -- // Functions
		local function set(newkey)
			if string.find(tostring(newkey), "Enum") then
				if c then
					c:Disconnect()
					if Keybind.Flag then
						Library.Flags[Keybind.Flag] = false
					end
					task.spawn(Keybind.Callback, false)
				end
				if tostring(newkey):find("Enum.KeyCode.") then
					newkey = Enum.KeyCode[tostring(newkey):gsub("Enum.KeyCode.", "")]
				elseif tostring(newkey):find("Enum.UserInputType.") then
					newkey = Enum.UserInputType[tostring(newkey):gsub("Enum.UserInputType.", "")]
				end
				if newkey == Enum.KeyCode.Backspace or newkey == Enum.KeyCode.Escape then
					Key = nil
					if Keybind.UseKey then
						if Keybind.Flag then
							Library.Flags[Keybind.Flag] = Key
						end
						task.spawn(Keybind.Callback, Key)
					end
					local text = ""
					Value.Text = text
					ListValue:Update(text, Keybind.Name, Keybind.Mode)
					ListValue:SetVisible(false)
				elseif newkey ~= nil then
					Key = newkey
					if Keybind.UseKey then
						if Keybind.Flag then
							Library.Flags[Keybind.Flag] = Key
						end
						task.spawn(Keybind.Callback, Key)
					end
					local text = (Library.Keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", ""))
					Value.Text = text
					ListValue:Update(text, Keybind.Name, Keybind.Mode)
					if Library.Open and Keybind.Name == "UI Toggle" then
						ListValue:SetColorBlue(true)
					end
				end
				Library.Flags[Keybind.Flag .. "_KEY"] = newkey
			elseif table.find({
				"Always",
				"Toggle",
				"Hold"
			}, newkey) then
				if not Keybind.UseKey then
					Library.Flags[Keybind.Flag .. "_KEY STATE"] = newkey
					Keybind.Mode = newkey
					if Key ~= nil then
						ListValue:Update((Library.Keys[Key] or tostring(Key):gsub("Enum.KeyCode.", "")), Keybind.Name, Keybind.Mode)
					end
					if Keybind.Mode == "Always" then
						State = true
						if Keybind.Flag then
							Library.Flags[Keybind.Flag] = State
						end
						task.spawn(Keybind.Callback, true)
						ListValue:SetColorBlue(true)
					end
				end
			else
				State = newkey
				if Keybind.Flag then
					Library.Flags[Keybind.Flag] = newkey
				end
				task.spawn(Keybind.Callback, newkey)
			end
		end
        --
		set(Keybind.State)
		set(Keybind.Mode)
		Library:Connection(Outline.MouseButton1Click, function()
			if not Keybind.Binding then
				Value.Text = "..."
				Keybind.Binding = Library:Connection(
                    userinput.InputBegan,
                    function(input, gpe)
					set(
                            input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode
                                or input.UserInputType
                        )
					Library:Disconnect(Keybind.Binding)
					task.wait()
					Keybind.Binding = nil
				end
                )
			end
		end)
        --
		local function isPlayerChatting()
			local textBoxFocused = userinput:GetFocusedTextBox()
			return textBoxFocused ~= nil
		end
		Library:Connection(userinput.InputBegan, function(inp)
			if not isPlayerChatting() then
				if (inp.KeyCode == Key or inp.UserInputType == Key) and not Keybind.Binding and not Keybind.UseKey then
					if Keybind.Mode == "Hold" then
						if Keybind.Flag then
							Library.Flags[Keybind.Flag] = true
						end
						c = Library:Connection(runserv.RenderStepped, function()
							if Keybind.Callback then
								task.spawn(Keybind.Callback, true)
							end
						end)
						ListValue:SetColorBlue(true)
					elseif Keybind.Mode == "Toggle" then
						State = not State
						if Keybind.Flag then
							Library.Flags[Keybind.Flag] = State
						end
						task.spawn(Keybind.Callback, State)
						ListValue:SetColorBlue(State)
					end
				end
			end
		end)
        --
		Library:Connection(userinput.InputEnded, function(inp)
			if not isPlayerChatting() then
				if Keybind.Mode == "Hold" and not Keybind.UseKey then
					if Key ~= "" or Key ~= nil then
						if inp.KeyCode == Key or inp.UserInputType == Key then
							if c then
								c:Disconnect()
								if Keybind.Flag then
									Library.Flags[Keybind.Flag] = false
								end
								if Keybind.Callback then
									task.spawn(Keybind.Callback, false)
								end
								ListValue:SetColorBlue(true)
							end
						end
					end
				end
			end
		end)
		Library:Connection(Outline.MouseEnter, function()
			Outline.BorderColor3 = Library.Accent
		end)
        --
		Library:Connection(Outline.MouseLeave, function()
			Outline.BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392)
		end)
        --
		Library:Connection(Outline.MouseButton2Down, function()
			ModeOutline.Visible = not ModeOutline.Visible
		end)
        --
		Library:Connection(NewKey.MouseEnter, function()
			table.insert(Library.ThemeObjects, Title)
			Title.TextColor3 = Library.Accent
		end)
        --
		Library:Connection(NewKey.MouseLeave, function()
			table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, Title))
			Title.TextColor3 = Color3.new(0.5686, 0.5686, 0.5686)
		end)
        --
		Library:Connection(Hold.MouseButton1Down, function()
			set("Hold")
			Hold.TextColor3 = Color3.new(1, 1, 1)
			Toggle.TextColor3 = Color3.fromRGB(145, 145, 145)
			Always.TextColor3 = Color3.fromRGB(145, 145, 145)
		end)
        --
		Library:Connection(Toggle.MouseButton1Down, function()
			set("Toggle")
			Hold.TextColor3 = Color3.fromRGB(145, 145, 145)
			Toggle.TextColor3 = Color3.new(1, 1, 1)
			Always.TextColor3 = Color3.fromRGB(145, 145, 145)
		end)
        --
		Library:Connection(Always.MouseButton1Down, function()
			set("Always")
			Hold.TextColor3 = Color3.fromRGB(145, 145, 145)
			Toggle.TextColor3 = Color3.fromRGB(145, 145, 145)
			Always.TextColor3 = Color3.new(1, 1, 1)
		end)
        --
		Library:Connection(userinput.InputBegan, function(Input)
			if ModeOutline.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
				if not Library:IsMouseOverFrame(ModeOutline) then
					ModeOutline.Visible = false
				end
			end
		end)
        --
		Library.Flags[Keybind.Flag .. "_KEY"] = Keybind.State
		Library.Flags[Keybind.Flag .. "_KEY STATE"] = Keybind.Mode
		Flags[Keybind.Flag] = set
		Flags[Keybind.Flag .. "_KEY"] = set
		Flags[Keybind.Flag .. "_KEY STATE"] = set
        --
		function Keybind:Set(key)
			set(key)
		end

        -- // Returning
		return Keybind
	end
    --
	function Sections:Colorpicker(Properties)
		local Properties = Properties or {}
		local Colorpicker = {
			Window = self.Window,
			Page = self.Page,
			Section = self,
			Name = (Properties.Name or "Colorpicker"),
			State = (
                Properties.state
                    or Properties.State
                    or Properties.def
                    or Properties.Def
                    or Properties.default
                    or Properties.Default
                    or Color3.fromRGB(255, 0, 0)
            ),
			Alpha = (
                Properties.alpha
                    or Properties.Alpha
                    or Properties.transparency
                    or Properties.Transparency
                    or 1
            ),
			Callback = (
                Properties.callback
                    or Properties.Callback
                    or Properties.callBack
                    or Properties.CallBack
                    or function()
			end
            ),
			Flag = (
                Properties.flag
                    or Properties.Flag
                    or Properties.pointer
                    or Properties.Pointer
                    or Library.NextFlag()
            ),
			Colorpickers = 0,
		}
        --
		local NewToggle = Library:Create('Frame', {
			Parent = Colorpicker.Section.Elements.SectionContent,
			Size = UDim2.new(1, 0, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local TextLabel = Library:Create('TextLabel', {
			Parent = NewToggle,
			Position = UDim2.new(0, 15, 0, 0),
			Size = UDim2.new(0, 100, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = Colorpicker.Name,
			TextColor3 = Color3.fromRGB(145, 145, 145),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextStrokeTransparency = 0
		})
        --
		Library:Connection(NewToggle.MouseEnter, function()
			table.insert(Library.ThemeObjects, TextLabel)
			TextLabel.TextColor3 = Library.Accent
		end)
        --
		Library:Connection(NewToggle.MouseLeave, function()
			table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, TextLabel))
			TextLabel.TextColor3 = Color3.new(0.5686, 0.5686, 0.5686)
		end)

        -- // Functions
		Colorpicker.Colorpickers = Colorpicker.Colorpickers + 1
		local colorpickertypes = Library:NewPicker(
            Colorpicker.Name,
            Colorpicker.State,
            Colorpicker.Alpha,
            NewToggle,
            Colorpicker.Colorpickers - 1,
            Colorpicker.Flag,
            Colorpicker.Callback
        )
		function Colorpicker:Set(color)
			colorpickertypes:set(color, false, true)
		end

        -- // Returning
		return Colorpicker
	end
    --
	function Sections:Textbox(Properties)
		local Properties = Properties or {}
		local Textbox = {
			Window = self.Window,
			Page = self.Page,
			Section = self,
			Name = (Properties.Name or Properties.name or "textbox"),
			Placeholder = (
                Properties.placeholder
                or Properties.Placeholder
                or Properties.holder
                or Properties.Holder
                or ""
            ),
			State = (
                Properties.state
                or Properties.State
                or Properties.def
                or Properties.Def
                or Properties.default
                or Properties.Default
                or ""
            ),
			Callback = (
                Properties.callback
                or Properties.Callback
                or Properties.callBack
                or Properties.CallBack
                or function()
			end
            ),
			Flag = (
                Properties.flag
                or Properties.Flag
                or Properties.pointer
                or Properties.Pointer
                or Library.NextFlag()
            ),
		}
        --
		local NewDrop = Library:Create('Frame', {
			Parent = Textbox.Section.Elements.SectionContent,
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Outline = Library:Create('TextButton', {
			Parent = NewDrop,
			Position = UDim2.new(0, 15, 1, 0),
			Size = UDim2.new(1, -30, 0, 16),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			AnchorPoint = NewVector2(0, 1),
			Text = "",
			AutoButtonColor = false
		})
		local Inline = Library:Create('Frame', {
			Parent = Outline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Value = Library:Create('TextBox', {
			Parent = Inline,
			Position = UDim2.new(0, 2, 0, 0),
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			TextColor3 = Color3.fromRGB(145, 145, 145),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextStrokeTransparency = 0,
			TextWrapped = true,
			Text = Textbox.State,
			ClearTextOnFocus = false
		})
		local Title = Library:Create('TextLabel', {
			Parent = NewDrop,
			Position = UDim2.new(0, 15, 0, 0),
			Size = UDim2.new(1, 0, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextStrokeTransparency = 0,
			Text = Textbox.Name
		})
    
        -- // Connections
		Library:Connection(NewDrop.MouseEnter, function()
			Outline.BorderColor3 = Library.Accent
			table.insert(Library.ThemeObjects, Title)
			Title.TextColor3 = Library.Accent
		end)
        --
		Library:Connection(NewDrop.MouseLeave, function()
			Outline.BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392)
			table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, Title))
			Title.TextColor3 = Color3.new(0.5686, 0.5686, 0.5686)
		end)
		Library:Connection(Value.FocusLost, function()
			task.spawn(Textbox.Callback, Value.Text)
			Library.Flags[Textbox.Flag] = Value.Text
		end)
        --
		function Textbox:set(str)
			Value.Text = str
			Library.Flags[Textbox.Flag] = str
			task.spawn(Textbox.Callback, str)
		end
    
        -- // Return
		Flags[Textbox.Flag] = function(value)
			Textbox:set(value)
		end
		return Textbox
	end    
    --
	function Sections:Button(Properties)
		local Properties = Properties or {}
		local Button = {
			Window = self.Window,
			Page = self.Page,
			Section = self,
			Name = Properties.Name or "button",
			Callback = (
                Properties.callback
                    or Properties.Callback
                    or Properties.callBack
                    or Properties.CallBack
                    or function()
			end
            ),
		}
        --
		local NewButton = Library:Create('TextButton', {
			Parent = Button.Section.Elements.SectionContent,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			FontFace = Library.Font,
			TextSize = 14
		})
		local Outline = Library:Create('Frame', {
			Parent = NewButton,
			Position = UDim2.new(0, 15, 1, 0),
			Size = UDim2.new(1, -30, 0, 14),
			BackgroundColor3 = Color3.new(0.1765, 0.1765, 0.1765),
			BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392),
			AnchorPoint = NewVector2(0, 1)
		})
		local Inline = Library:Create('Frame', {
			Parent = Outline,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -2, 1, -2),
			BackgroundColor3 = Color3.new(0.1294, 0.1294, 0.1294),
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0)
		})
		local Value = Library:Create('TextLabel', {
			Parent = Inline,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			TextColor3 = Color3.new(0.5686, 0.5686, 0.5686),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			Text = Button.Name,
			TextStrokeTransparency = 0
		})
		Library:Connection(NewButton.MouseEnter, function()
			Outline.BorderColor3 = Library.Accent
		end)
        --
		Library:Connection(NewButton.MouseLeave, function()
			Outline.BorderColor3 = Color3.new(0.0392, 0.0392, 0.0392)
		end)
        --
		Library:Connection(NewButton.MouseButton1Down, function()
			task.spawn(Button.Callback)
			Value.TextColor3 = Library.Accent
		end)
        --
		Library:Connection(NewButton.MouseButton1Up, function()
			Value.TextColor3 = Color3.new(0.5686, 0.5686, 0.5686)
		end)
	end
    --
	function Sections:Label(Properties)
		local Properties = Properties or {}
		local Label = {
			Window = self.Window,
			Page = self.Page,
			Section = self,
			Name = Properties.Name or "label",
			Centered = Properties.Centered or false,
		}
		local NewButton = Library:Create('TextLabel', {
			Parent = Label.Section.Elements.SectionContent,
			Size = UDim2.new(1, 0, 0, 12),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderColor3 = Color3.new(0, 0, 0),
			Text = Label.Name,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			TextXAlignment = Label.Centered and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
			TextStrokeTransparency = 0,
			TextStrokeColor3 = Color3.new(0, 0, 0)
		})
        --
		function Label:SetText(NewText)
			self.Name = NewText
			NewButton.Text = NewText
		end
		return Label
	end
	return Library
end
