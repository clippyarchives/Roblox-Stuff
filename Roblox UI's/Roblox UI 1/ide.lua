local plrs = game:GetService("Players");
local rs = game:GetService("RunService");
local uis = game:GetService("UserInputService");
local syn = require(script.Parent:WaitForChild("syntax"));
local m = {};
function m.open()
  local cons = {};
  local plr = plrs.LocalPlayer;
  if not plr then return end;
  local pg = plr:WaitForChild("PlayerGui");
  local sg = Instance.new("ScreenGui"); sg.Name = "rbx_ide"; sg.ResetOnSpawn = false; sg.Parent = pg;
  local root = Instance.new("Frame"); root.Name = "root"; root.Size = UDim2.new(0,900,0,600); root.Position = UDim2.new(0.5,-450,0.5,-300); root.BackgroundColor3 = Color3.fromRGB(17,17,20); root.BorderSizePixel = 0; root.Parent = sg;
  local top = Instance.new("Frame"); top.Name = "top"; top.Size = UDim2.new(1,0,0,28); top.BackgroundColor3 = Color3.fromRGB(27,27,32); top.BorderSizePixel = 0; top.Parent = root;
  local ttl = Instance.new("TextLabel"); ttl.Name = "ttl"; ttl.Size = UDim2.new(1,-56,1,0); ttl.Position = UDim2.new(0,10,0,0); ttl.BackgroundTransparency = 1; ttl.Text = "roblox ide"; ttl.Font = Enum.Font.Code; ttl.TextSize = 16; ttl.TextColor3 = Color3.fromRGB(200,200,205); ttl.Parent = top;
  local btnx = Instance.new("TextButton"); btnx.Name = "x"; btnx.Size = UDim2.new(0,46,1,0); btnx.Position = UDim2.new(1,-46,0,0); btnx.Text = "x"; btnx.Font = Enum.Font.Code; btnx.TextSize = 16; btnx.TextColor3 = Color3.fromRGB(220,120,120); btnx.BackgroundTransparency = 1; btnx.Parent = top;
  local main = Instance.new("Frame"); main.Name = "main"; main.Size = UDim2.new(1,-20,1,-48); main.Position = UDim2.new(0,10,0,38); main.BackgroundColor3 = Color3.fromRGB(22,22,26); main.BorderSizePixel = 0; main.Parent = root;
  local gutw = 48;
  local gut = Instance.new("ScrollingFrame"); gut.Name = "gut"; gut.Size = UDim2.new(0,gutw,1,0); gut.CanvasSize = UDim2.new(0,0,0,0); gut.ScrollBarThickness = 6; gut.ScrollBarImageColor3 = Color3.fromRGB(60,60,66); gut.BackgroundColor3 = Color3.fromRGB(19,19,23); gut.BorderSizePixel = 0; gut.Parent = main;
  local ln = Instance.new("TextLabel"); ln.Name = "ln"; ln.Size = UDim2.new(1,-6,0,0); ln.Position = UDim2.new(0,6,0,0); ln.BackgroundTransparency = 1; ln.TextXAlignment = Enum.TextXAlignment.Right; ln.TextYAlignment = Enum.TextYAlignment.Top; ln.Font = Enum.Font.Code; ln.TextSize = 16; ln.TextColor3 = Color3.fromRGB(110,110,118); ln.RichText = false; ln.Text = "1"; ln.Parent = gut;
  local sc = Instance.new("ScrollingFrame"); sc.Name = "sc"; sc.Size = UDim2.new(1,-gutw,1,0); sc.Position = UDim2.new(0,gutw,0,0); sc.CanvasSize = UDim2.new(0,0,0,0); sc.ScrollBarThickness = 6; sc.ScrollBarImageColor3 = Color3.fromRGB(60,60,66); sc.BackgroundColor3 = Color3.fromRGB(22,22,26); sc.BorderSizePixel = 0; sc.Parent = main;
  local cnt = Instance.new("Frame"); cnt.Name = "cnt"; cnt.Size = UDim2.new(1,-12,0,0); cnt.Position = UDim2.new(0,6,0,0); cnt.BackgroundTransparency = 1; cnt.Parent = sc;
  local hi = Instance.new("TextLabel"); hi.Name = "hi"; hi.Size = UDim2.new(1,0,0,0); hi.BackgroundTransparency = 1; hi.TextXAlignment = Enum.TextXAlignment.Left; hi.TextYAlignment = Enum.TextYAlignment.Top; hi.Font = Enum.Font.Code; hi.TextSize = 16; hi.TextColor3 = Color3.fromRGB(200,200,205); hi.RichText = true; hi.TextWrapped = false; hi.Text = ""; hi.Parent = cnt;
  local txt = Instance.new("TextBox"); txt.Name = "txt"; txt.ClearTextOnFocus = false; txt.MultiLine = true; txt.TextEditable = true; txt.Size = UDim2.new(1,0,0,0); txt.Position = UDim2.new(0,0,0,0); txt.BackgroundTransparency = 1; txt.TextTransparency = 1; txt.TextXAlignment = Enum.TextXAlignment.Left; txt.TextYAlignment = Enum.TextYAlignment.Top; txt.Font = Enum.Font.Code; txt.TextSize = 16; txt.TextColor3 = Color3.fromRGB(200,200,205); txt.Parent = cnt;
  local function setln(s)
    local n = 1; for _ in s:gmatch("\n") do n = n + 1 end;
    local t = {}; for i=1,n do t[#t+1] = tostring(i) end;
    local v = table.concat(t, "\n"); ln.Text = v;
    ln.Size = UDim2.new(1,-6,0,hi.TextBounds.Y);
    gut.CanvasSize = UDim2.new(0,0,0,math.max(hi.TextBounds.Y, main.AbsoluteSize.Y));
  end
  local t0 = 0; local dt = 0.05; local pend = false;
  local function upd()
    local s = txt.Text;
    hi.Text = syn.hl(s);
    hi.Size = UDim2.new(1,0,0,hi.TextBounds.Y+8);
    txt.Size = hi.Size;
    sc.CanvasSize = UDim2.new(0,0,0,math.max(hi.TextBounds.Y, main.AbsoluteSize.Y));
    setln(s);
  end
  cons[#cons+1] = txt:GetPropertyChangedSignal("Text"):Connect(function()
    pend = true;
  end);
  cons[#cons+1] = rs.Heartbeat:Connect(function()
    if not pend then return end;
    local now = os.clock(); if now - t0 < dt then return end;
    t0 = now; pend = false; upd();
  end);
  cons[#cons+1] = sc:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
    gut.CanvasPosition = Vector2.new(0, sc.CanvasPosition.Y);
  end);
  cons[#cons+1] = btnx.MouseButton1Click:Connect(function()
    for i=#cons,1,-1 do local c = cons[i]; if c and c.Disconnect then c:Disconnect() end end;
    sg:Destroy();
  end);
  upd();
end
return m;