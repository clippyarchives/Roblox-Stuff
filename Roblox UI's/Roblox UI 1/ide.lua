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
local headh = 26; local pad = 10;
local stl = make(setc, "TextLabel", "ttl"); stl.Size = UDim2.new(1,0,0,headh); stl.Position = UDim2.new(0,0,0,0); stl.BackgroundTransparency = 1; stl.TextXAlignment = Enum.TextXAlignment.Left; stl.Font = Enum.Font.Code; stl.TextSize = 16; stl.TextColor3 = Color3.fromRGB(200,200,205); stl.Text = "settings";
local cols = make(setc, "Frame", "cols"); cols.Position = UDim2.new(0,0,0,headh+pad); cols.Size = UDim2.new(1,0,1,-(headh+pad+48)); cols.BackgroundTransparency = 1;
local gl = Instance.new("UIGridLayout"); gl.Parent = cols; gl.FillDirection = Enum.FillDirection.Horizontal; gl.HorizontalAlignment = Enum.HorizontalAlignment.Left; gl.VerticalAlignment = Enum.VerticalAlignment.Top; gl.CellPadding = UDim2.new(0,10,0,10); gl.FillDirectionMaxCells = 3; gl.SortOrder = Enum.SortOrder.Name; gl.CellSize = UDim2.new(1/3,-14,0,100);
local s_col = make(cols, "Frame", "s_col"); s_col.BackgroundColor3 = Color3.fromRGB(26,26,30); s_col.BorderSizePixel = 0; local scc = Instance.new("UICorner"); scc.CornerRadius = UDim.new(0,4); scc.Parent = s_col; local scs = Instance.new("UIStroke"); scs.Color = Color3.fromRGB(48,48,54); scs.Thickness = 1; scs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; scs.Parent = s_col;
local ht1 = make(s_col, "TextLabel", "ttl"); ht1.Size = UDim2.new(1,-pad*2,0,headh); ht1.Position = UDim2.new(0,pad,0,pad); ht1.BackgroundTransparency = 1; ht1.TextXAlignment = Enum.TextXAlignment.Left; ht1.Font = Enum.Font.Code; ht1.TextSize = 16; ht1.TextColor3 = Color3.fromRGB(200,200,205); ht1.Text = "colors";
local yoff = pad + headh + 6; local rowh = 36;
for i=1,#list do
  local k = list[i]; local y = yoff + (i-1)*rowh; local l = make(s_col, "TextLabel", k.."_l"); l.Size = UDim2.new(0,60,0,28); l.Position = UDim2.new(0,pad,0,y+4); l.BackgroundTransparency = 1; l.TextXAlignment = Enum.TextXAlignment.Left; l.Font = Enum.Font.Code; l.TextSize = 16; l.TextColor3 = Color3.fromRGB(180,180,188); l.Text = k;
  local tb = make(s_col, "TextBox", k.."_tb"); tb.Size = UDim2.new(1,-(pad*2+70),0,28); tb.Position = UDim2.new(0,pad+70,0,y+4); tb.BackgroundColor3 = Color3.fromRGB(18,18,22); tb.BorderSizePixel = 0; tb.Font = Enum.Font.Code; tb.TextSize = 16; tb.TextColor3 = Color3.fromRGB(200,200,205); tb.ClearTextOnFocus = false; tb.Text = defcol[k] or "#FFFFFF"; local cr = Instance.new("UICorner"); cr.CornerRadius = UDim.new(0,4); cr.Parent = tb; flds[k]=tb;
end
local s_col_h = yoff + #list*rowh + pad; s_col.Size = UDim2.new(1,0,0,s_col_h);
local s_tog = make(cols, "Frame", "s_tog"); s_tog.BackgroundColor3 = Color3.fromRGB(26,26,30); s_tog.BorderSizePixel = 0; local tgc = Instance.new("UICorner"); tgc.CornerRadius = UDim.new(0,4); tgc.Parent = s_tog; local tgs = Instance.new("UIStroke"); tgs.Color = Color3.fromRGB(48,48,54); tgs.Thickness = 1; tgs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; tgs.Parent = s_tog;
local ht2 = make(s_tog, "TextLabel", "ttl"); ht2.Size = UDim2.new(1,-pad*2,0,headh); ht2.Position = UDim2.new(0,pad,0,pad); ht2.BackgroundTransparency = 1; ht2.TextXAlignment = Enum.TextXAlignment.Left; ht2.Font = Enum.Font.Code; ht2.TextSize = 16; ht2.TextColor3 = Color3.fromRGB(200,200,205); ht2.Text = "toggles";
for i=1,3 do
  local y = pad + headh + 6 + (i-1)*36; local l = make(s_tog, "TextLabel", "tg_"..i); l.Size = UDim2.new(0,90,0,24); l.Position = UDim2.new(0,pad,0,y+2); l.BackgroundTransparency = 1; l.TextXAlignment = Enum.TextXAlignment.Left; l.Font = Enum.Font.Code; l.TextSize = 16; l.TextColor3 = Color3.fromRGB(180,180,188); l.Text = "ph "..i;
  local sw = make(s_tog, "Frame", "sw_"..i); sw.Size = UDim2.new(0,44,0,22); sw.Position = UDim2.new(0,pad+100,0,y); sw.BackgroundColor3 = Color3.fromRGB(18,18,22); sw.BorderSizePixel = 0; local swc = Instance.new("UICorner"); swc.CornerRadius = UDim.new(1,0); swc.Parent = sw; local dot = make(sw, "Frame", "dot"); dot.Size = UDim2.new(0,20,0,20); dot.Position = UDim2.new(0,1,0,1); dot.BackgroundColor3 = Color3.fromRGB(200,200,205); dot.BorderSizePixel = 0; local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1,0); dc.Parent = dot;
end
local s_tog_h = pad + headh + 6 + 3*36 + pad; s_tog.Size = UDim2.new(1,0,0,s_tog_h);
local s_sld = make(cols, "Frame", "s_sld"); s_sld.BackgroundColor3 = Color3.fromRGB(26,26,30); s_sld.BorderSizePixel = 0; local sdc = Instance.new("UICorner"); sdc.CornerRadius = UDim.new(0,4); sdc.Parent = s_sld; local sds = Instance.new("UIStroke"); sds.Color = Color3.fromRGB(48,48,54); sds.Thickness = 1; sds.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; sds.Parent = s_sld;
local ht3 = make(s_sld, "TextLabel", "ttl"); ht3.Size = UDim2.new(1,-pad*2,0,headh); ht3.Position = UDim2.new(0,pad,0,pad); ht3.BackgroundTransparency = 1; ht3.TextXAlignment = Enum.TextXAlignment.Left; ht3.Font = Enum.Font.Code; ht3.TextSize = 16; ht3.TextColor3 = Color3.fromRGB(200,200,205); ht3.Text = "sliders";
for i=1,3 do
  local y = pad + headh + 6 + (i-1)*40; local l = make(s_sld, "TextLabel", "sd_"..i); l.Size = UDim2.new(0,90,0,24); l.Position = UDim2.new(0,pad,0,y+2); l.BackgroundTransparency = 1; l.TextXAlignment = Enum.TextXAlignment.Left; l.Font = Enum.Font.Code; l.TextSize = 16; l.TextColor3 = Color3.fromRGB(180,180,188); l.Text = "ph "..i;
  local bar = make(s_sld, "Frame", "bar_"..i); bar.Size = UDim2.new(1,-(pad*2+100),0,6); bar.Position = UDim2.new(0,pad+100,0,y+9); bar.BackgroundColor3 = Color3.fromRGB(18,18,22); bar.BorderSizePixel = 0; local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(1,0); bc.Parent = bar; local fill = make(bar, "Frame", "fill"); fill.Size = UDim2.new(0.5,0,1,0); fill.Position = UDim2.new(0,0,0,0); fill.BackgroundColor3 = Color3.fromRGB(120,180,120); fill.BorderSizePixel = 0; local fc = Instance.new("UICorner"); fc.CornerRadius = UDim.new(1,0); fc.Parent = fill;
end
local s_sld_h = pad + headh + 6 + 3*40 + pad; s_sld.Size = UDim2.new(1,0,0,s_sld_h);
local colh = math.max(s_col_h, s_tog_h, s_sld_h); gl.CellSize = UDim2.new(1/3,-14,0,colh);
local act = make(setc, "Frame", "act"); act.Size = UDim2.new(1,0,0,38); act.Position = UDim2.new(0,0,1,-38); act.BackgroundTransparency = 1;
local apply = make(act, "TextButton", "apply"); apply.Size = UDim2.new(0,120,0,28); apply.Position = UDim2.new(0,0,0,5); apply.Text = "apply"; apply.Font = Enum.Font.Code; apply.TextSize = 16; apply.TextColor3 = Color3.fromRGB(190,220,190); apply.BackgroundColor3 = Color3.fromRGB(28,36,28); apply.BorderSizePixel = 0; local apc = Instance.new("UICorner"); apc.CornerRadius = UDim.new(0,4); apc.Parent = apply;
local reset = make(act, "TextButton", "reset"); reset.Size = UDim2.new(0,120,0,28); reset.Position = UDim2.new(0,130,0,5); reset.Text = "reset"; reset.Font = Enum.Font.Code; reset.TextSize = 16; reset.TextColor3 = Color3.fromRGB(220,190,190); reset.BackgroundColor3 = Color3.fromRGB(36,28,28); reset.BorderSizePixel = 0; local rsc = Instance.new("UICorner"); rsc.CornerRadius = UDim.new(0,4); rsc.Parent = reset;
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
