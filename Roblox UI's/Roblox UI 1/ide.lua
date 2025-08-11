local rs = game:GetService("RunService");
local uis = game:GetService("UserInputService");
local ts = game:GetService("TweenService");
local cg = (gethui and gethui()) or game:GetService("CoreGui");
local syn = loadstring(game:HttpGet("https://raw.githubusercontent.com/clippyarchives/Roblox-Stuff/main/Roblox%20UI%27s/Roblox%20UI%201/syntax.lua"))();
local cons = {};
local function make(p, c, n)
  local i = Instance.new(c);
  if n then i.Name = n end; i.Parent = p; return i;
end
local sg = make(cg, "ScreenGui", "rbx_ide"); sg.ResetOnSpawn = false;
local root = make(sg, "Frame", "root"); root.Size = UDim2.new(0,900,0,600); root.Position = UDim2.new(0.5,-450,0.5,-300); root.BackgroundColor3 = Color3.fromRGB(17,17,20); root.BorderSizePixel = 0;
local top = make(root, "Frame", "top"); top.Size = UDim2.new(1,0,0,28); top.BackgroundColor3 = Color3.fromRGB(27,27,32); top.BorderSizePixel = 0;
local ttl = make(top, "TextLabel", "ttl"); ttl.Size = UDim2.new(1,-216,1,0); ttl.Position = UDim2.new(0,10,0,0); ttl.BackgroundTransparency = 1; ttl.Text = "roblox ide"; ttl.Font = Enum.Font.Code; ttl.TextSize = 16; ttl.TextColor3 = Color3.fromRGB(200,200,205);
local btnedit = make(top, "TextButton", "edit"); btnedit.Size = UDim2.new(0,60,1,0); btnedit.Position = UDim2.new(1,-156,0,0); btnedit.Text = "edit"; btnedit.Font = Enum.Font.Code; btnedit.TextSize = 16; btnedit.TextColor3 = Color3.fromRGB(200,200,205); btnedit.BackgroundTransparency = 1;
local btncfg = make(top, "TextButton", "settings"); btncfg.Size = UDim2.new(0,90,1,0); btncfg.Position = UDim2.new(1,-96,0,0); btncfg.Text = "settings"; btncfg.Font = Enum.Font.Code; btncfg.TextSize = 16; btncfg.TextColor3 = Color3.fromRGB(140,140,150); btncfg.BackgroundTransparency = 1;
local btnx = make(top, "TextButton", "x"); btnx.Size = UDim2.new(0,46,1,0); btnx.Position = UDim2.new(1,-46,0,0); btnx.Text = "x"; btnx.Font = Enum.Font.Code; btnx.TextSize = 16; btnx.TextColor3 = Color3.fromRGB(220,120,120); btnx.BackgroundTransparency = 1;
local main = make(root, "Frame", "main"); main.Size = UDim2.new(1,-20,1,-48); main.Position = UDim2.new(0,10,0,38); main.BackgroundColor3 = Color3.fromRGB(22,22,26); main.BorderSizePixel = 0; main.ClipsDescendants = true;
local editv = make(main, "Frame", "editv"); editv.Size = UDim2.new(1,0,1,0); editv.Position = UDim2.new(0,0,0,0); editv.BackgroundTransparency = 1; editv.BorderSizePixel = 0;
local gutw = 48;
local gut = make(editv, "ScrollingFrame", "gut"); gut.Size = UDim2.new(0,gutw,1,0); gut.Position = UDim2.new(0,0,0,0); gut.CanvasSize = UDim2.new(0,0,0,0); gut.ScrollBarThickness = 6; gut.ScrollBarImageColor3 = Color3.fromRGB(60,60,66); gut.BackgroundColor3 = Color3.fromRGB(19,19,23); gut.BorderSizePixel = 0;
local ln = make(gut, "TextLabel", "ln"); ln.Size = UDim2.new(1,-6,0,0); ln.Position = UDim2.new(0,6,0,0); ln.BackgroundTransparency = 1; ln.TextXAlignment = Enum.TextXAlignment.Right; ln.TextYAlignment = Enum.TextYAlignment.Top; ln.Font = Enum.Font.Code; ln.TextSize = 16; ln.TextColor3 = Color3.fromRGB(110,110,118); ln.RichText = false; ln.Text = "1";
local sc = make(editv, "ScrollingFrame", "sc"); sc.Size = UDim2.new(1,-gutw,1,0); sc.Position = UDim2.new(0,gutw,0,0); sc.CanvasSize = UDim2.new(0,0,0,0); sc.ScrollBarThickness = 6; sc.ScrollBarImageColor3 = Color3.fromRGB(60,60,66); sc.BackgroundColor3 = Color3.fromRGB(22,22,26); sc.BorderSizePixel = 0;
local cnt = make(sc, "Frame", "cnt"); cnt.Size = UDim2.new(1,-12,0,0); cnt.Position = UDim2.new(0,6,0,0); cnt.BackgroundTransparency = 1;
local hi = make(cnt, "TextLabel", "hi"); hi.Size = UDim2.new(1,0,0,0); hi.BackgroundTransparency = 1; hi.TextXAlignment = Enum.TextXAlignment.Left; hi.TextYAlignment = Enum.TextYAlignment.Top; hi.Font = Enum.Font.Code; hi.TextSize = 16; hi.TextColor3 = Color3.fromRGB(200,200,205); hi.RichText = true; hi.TextWrapped = false; hi.Text = "";
local txt = make(cnt, "TextBox", "txt"); txt.ClearTextOnFocus = false; txt.MultiLine = true; txt.TextEditable = true; txt.Size = UDim2.new(1,0,0,0); txt.Position = UDim2.new(0,0,0,0); txt.BackgroundTransparency = 1; txt.TextTransparency = 1; txt.TextXAlignment = Enum.TextXAlignment.Left; txt.TextYAlignment = Enum.TextYAlignment.Top; txt.Font = Enum.Font.Code; txt.TextSize = 16; txt.TextColor3 = Color3.fromRGB(200,200,205);
local setv = make(main, "Frame", "setv"); setv.Size = UDim2.new(1,0,1,0); setv.Position = UDim2.new(1,0,0,0); setv.BackgroundColor3 = Color3.fromRGB(22,22,26); setv.BorderSizePixel = 0; setv.Visible = false;
local setc = make(setv, "Frame", "setc"); setc.Size = UDim2.new(1,-20,1,-16); setc.Position = UDim2.new(0,10,0,8); setc.BackgroundTransparency = 1;
local defcol = {}; for k,v in pairs(syn.col) do defcol[k]=v end;
local list = {"kw","str","com","num","lib","fn"};
local flds = {};
local secw = 360; local pad = 10; local headh = 26; local rowh = 36;
local sec = make(setc, "Frame", "sec"); sec.Size = UDim2.new(0,secw,0,0); sec.Position = UDim2.new(0,0,0,0); sec.BackgroundColor3 = Color3.fromRGB(26,26,30); sec.BorderSizePixel = 0; local secc = Instance.new("UICorner"); secc.CornerRadius = UDim.new(0,4); secc.Parent = sec;
local ht = make(sec, "TextLabel", "ttl"); ht.Size = UDim2.new(1,-pad*2,0,headh); ht.Position = UDim2.new(0,pad,0,pad); ht.BackgroundTransparency = 1; ht.TextXAlignment = Enum.TextXAlignment.Left; ht.Font = Enum.Font.Code; ht.TextSize = 16; ht.TextColor3 = Color3.fromRGB(200,200,205); ht.Text = "settings";
local yoff = pad + headh + 6;
for i=1,#list do
  local k = list[i]; local y = yoff + (i-1)*rowh; local l = make(sec, "TextLabel", k.."_l"); l.Size = UDim2.new(0,60,0,28); l.Position = UDim2.new(0,pad,0,y+4); l.BackgroundTransparency = 1; l.TextXAlignment = Enum.TextXAlignment.Left; l.Font = Enum.Font.Code; l.TextSize = 16; l.TextColor3 = Color3.fromRGB(180,180,188); l.Text = k;
  local tb = make(sec, "TextBox", k.."_tb"); tb.Size = UDim2.new(0,secw - pad*2 - 80,0,28); tb.Position = UDim2.new(0,pad+70,0,y+4); tb.BackgroundColor3 = Color3.fromRGB(18,18,22); tb.BorderSizePixel = 0; tb.Font = Enum.Font.Code; tb.TextSize = 16; tb.TextColor3 = Color3.fromRGB(200,200,205); tb.ClearTextOnFocus = false; tb.Text = defcol[k] or "#FFFFFF"; local cr = Instance.new("UICorner"); cr.CornerRadius = UDim.new(0,4); cr.Parent = tb; flds[k]=tb;
end
local y0 = yoff + #list*rowh + 6;
local apply = make(sec, "TextButton", "apply"); apply.Size = UDim2.new(0,120,0,28); apply.Position = UDim2.new(0,pad,0,y0); apply.Text = "apply"; apply.Font = Enum.Font.Code; apply.TextSize = 16; apply.TextColor3 = Color3.fromRGB(190,220,190); apply.BackgroundColor3 = Color3.fromRGB(28,36,28); apply.BorderSizePixel = 0; local apc = Instance.new("UICorner"); apc.CornerRadius = UDim.new(0,4); apc.Parent = apply;
local reset = make(sec, "TextButton", "reset"); reset.Size = UDim2.new(0,120,0,28); reset.Position = UDim2.new(0,pad+130,0,y0); reset.Text = "reset"; reset.Font = Enum.Font.Code; reset.TextSize = 16; reset.TextColor3 = Color3.fromRGB(220,190,190); reset.BackgroundColor3 = Color3.fromRGB(36,28,28); reset.BorderSizePixel = 0; local rsc = Instance.new("UICorner"); rsc.CornerRadius = UDim.new(0,4); rsc.Parent = reset;
sec.Size = UDim2.new(0,secw,0,y0 + 28 + pad);
local function setln(s)
  local n = 1; for _ in s:gmatch("\n") do n = n + 1 end; local t = {}; for i=1,n do t[#t+1] = tostring(i) end; ln.Text = table.concat(t, "\n"); ln.Size = UDim2.new(1,-6,0,hi.TextBounds.Y); gut.CanvasSize = UDim2.new(0,0,0,math.max(hi.TextBounds.Y, main.AbsoluteSize.Y));
end
local t0 = 0; local dt = 0.05; local pend = false;
local function upd()
  local s = txt.Text; hi.Text = syn.hl(s); hi.Size = UDim2.new(1,0,0,hi.TextBounds.Y+8); txt.Size = hi.Size; sc.CanvasSize = UDim2.new(0,0,0,math.max(hi.TextBounds.Y, main.AbsoluteSize.Y)); setln(s);
end
cons[#cons+1] = txt:GetPropertyChangedSignal("Text"):Connect(function() pend = true; end);
cons[#cons+1] = rs.Heartbeat:Connect(function() if not pend then return end; local now = os.clock(); if now - t0 < dt then return end; t0 = now; pend = false; upd(); end);
cons[#cons+1] = sc:GetPropertyChangedSignal("CanvasPosition"):Connect(function() gut.CanvasPosition = Vector2.new(0, sc.CanvasPosition.Y); end);
cons[#cons+1] = btnx.MouseButton1Click:Connect(function() for i=#cons,1,-1 do local c = cons[i]; if c and c.Disconnect then c:Disconnect() end end; sg:Destroy(); end);
local function normhex(s)
  if typeof(s) ~= "string" then return nil end; s = s:gsub("%s+",""); if s == "" then return nil end; if s:sub(1,1) ~= "#" then s = "#"..s end; if #s ~= 7 then return nil end; if not s:match("^#%x%x%x%x%x%x$") then return nil end; return s:upper();
end
local function fill()
  for k,tb in pairs(flds) do tb.Text = syn.col[k] or defcol[k] or "#FFFFFF" end;
end
local cur = "edit"; local anim = false; local tinfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local function tab(n)
  if anim then return end; if n == cur then return end; anim = true;
  local on = Color3.fromRGB(200,200,205); local off = Color3.fromRGB(140,140,150);
  if n == "settings" then
    btnedit.TextColor3 = off; btncfg.TextColor3 = on; fill(); setv.Visible = true; editv.Visible = true; setv.Position = UDim2.new(1,0,0,0); editv.Position = UDim2.new(0,0,0,0);
    local a = ts:Create(editv, tinfo, {Position = UDim2.new(-1,0,0,0)});
    local b = ts:Create(setv, tinfo, {Position = UDim2.new(0,0,0,0)});
    local con; con = b.Completed:Connect(function()
      if con and con.Disconnect then con:Disconnect() end; editv.Visible = false; editv.Position = UDim2.new(0,0,0,0); cur = n; anim = false;
    end);
    a:Play(); b:Play();
  else
    btnedit.TextColor3 = on; btncfg.TextColor3 = off; editv.Visible = true; setv.Visible = true; editv.Position = UDim2.new(-1,0,0,0); setv.Position = UDim2.new(0,0,0,0);
    local a = ts:Create(editv, tinfo, {Position = UDim2.new(0,0,0,0)});
    local b = ts:Create(setv, tinfo, {Position = UDim2.new(1,0,0,0)});
    local con; con = a.Completed:Connect(function()
      if con and con.Disconnect then con:Disconnect() end; setv.Visible = false; setv.Position = UDim2.new(1,0,0,0); cur = n; anim = false;
    end);
    a:Play(); b:Play();
  end
end
cons[#cons+1] = btnedit.MouseButton1Click:Connect(function() tab("edit") end);
cons[#cons+1] = btncfg.MouseButton1Click:Connect(function() tab("settings") end);
cons[#cons+1] = apply.MouseButton1Click:Connect(function()
  for k,tb in pairs(flds) do local v = normhex(tb.Text); if v then syn.col[k]=v end end; upd();
end);
cons[#cons+1] = reset.MouseButton1Click:Connect(function()
  for k,v in pairs(defcol) do syn.col[k]=v end; fill(); upd();
end);
btnedit.TextColor3 = Color3.fromRGB(200,200,205); btncfg.TextColor3 = Color3.fromRGB(140,140,150); setv.Visible = false; editv.Visible = true; editv.Position = UDim2.new(0,0,0,0);
upd();
