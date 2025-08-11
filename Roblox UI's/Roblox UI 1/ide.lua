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
local function c3(h)
  if typeof(h) ~= "string" then return Color3.fromRGB(255,255,255) end; if h:sub(1,1) == "#" then h = h:sub(2) end; if #h ~= 6 then return Color3.fromRGB(255,255,255) end; local n = tonumber(h,16) or 16777215; local r = math.floor(n/65536)%256; local g = math.floor(n/256)%256; local b = n%256; return Color3.fromRGB(r,g,b);
end
local ui = {
  root_bg = "#111114", top_bg = "#1B1B20", main_bg = "#16161A", gut_bg = "#131317", scroll = "#3C3C42",
  txt = "#C8C8CD", subtxt = "#B4B4BC", tab_on = "#C8C8CD", tab_off = "#8C8C96",
  sec_bg = "#1A1A1E", sec_stroke = "#303036",
  input_bg = "#121216", input_tx = "#C8C8CD",
  btn_ok_bg = "#1C241C", btn_ok_tx = "#BEDEBE", btn_rs_bg = "#241C1C", btn_rs_tx = "#DEC0C0",
  tg_off = "#121216", tg_on = "#2C402C", tg_dot = "#C8C8CD",
  sld_bar = "#121216", sld_fill = "#78B478",
};
local defui = {}; for k,v in pairs(ui) do defui[k]=v end;
local sg = make(cg, "ScreenGui", "rbx_ide"); sg.ResetOnSpawn = false;
local root = make(sg, "Frame", "root"); root.Size = UDim2.new(0,900,0,600); root.Position = UDim2.new(0.5,-450,0.5,-300); root.BackgroundColor3 = c3(ui.root_bg); root.BorderSizePixel = 0;
local top = make(root, "Frame", "top"); top.Size = UDim2.new(1,0,0,28); top.BackgroundColor3 = c3(ui.top_bg); top.BorderSizePixel = 0;
local tabs = make(top, "Frame", "tabs"); tabs.Size = UDim2.new(0,160,1,0); tabs.Position = UDim2.new(0,10,0,0); tabs.BackgroundTransparency = 1;
local btnedit = make(tabs, "TextButton", "edit"); btnedit.Size = UDim2.new(0,60,1,0); btnedit.Position = UDim2.new(0,0,0,0); btnedit.Text = "edit"; btnedit.Font = Enum.Font.Code; btnedit.TextSize = 16; btnedit.TextColor3 = c3(ui.tab_on); btnedit.BackgroundTransparency = 1;
local btncfg = make(tabs, "TextButton", "settings"); btncfg.Size = UDim2.new(0,90,1,0); btncfg.Position = UDim2.new(0,70,0,0); btncfg.Text = "settings"; btncfg.Font = Enum.Font.Code; btncfg.TextSize = 16; btncfg.TextColor3 = c3(ui.tab_off); btncfg.BackgroundTransparency = 1;
local btnx = make(top, "TextButton", "x"); btnx.Size = UDim2.new(0,46,1,0); btnx.Position = UDim2.new(1,-46,0,0); btnx.Text = "x"; btnx.Font = Enum.Font.Code; btnx.TextSize = 16; btnx.TextColor3 = Color3.fromRGB(220,120,120); btnx.BackgroundTransparency = 1;
local ttl = make(top, "TextLabel", "ttl"); ttl.Size = UDim2.new(1,-(180+46),1,0); ttl.Position = UDim2.new(0,180,0,0); ttl.BackgroundTransparency = 1; ttl.Text = "roblox ide"; ttl.Font = Enum.Font.Code; ttl.TextSize = 16; ttl.TextColor3 = c3(ui.txt);
local main = make(root, "Frame", "main"); main.Size = UDim2.new(1,-20,1,-48); main.Position = UDim2.new(0,10,0,38); main.BackgroundColor3 = c3(ui.main_bg); main.BorderSizePixel = 0; main.ClipsDescendants = true;
local editv = make(main, "Frame", "editv"); editv.Size = UDim2.new(1,0,1,0); editv.Position = UDim2.new(0,0,0,0); editv.BackgroundTransparency = 1; editv.BorderSizePixel = 0;
local gutw = 48;
local gut = make(editv, "ScrollingFrame", "gut"); gut.Size = UDim2.new(0,gutw,1,0); gut.Position = UDim2.new(0,0,0,0); gut.CanvasSize = UDim2.new(0,0,0,0); gut.ScrollBarThickness = 6; gut.ScrollBarImageColor3 = c3(ui.scroll); gut.BackgroundColor3 = c3(ui.gut_bg); gut.BorderSizePixel = 0;
local ln = make(gut, "TextLabel", "ln"); ln.Size = UDim2.new(1,-6,0,0); ln.Position = UDim2.new(0,6,0,0); ln.BackgroundTransparency = 1; ln.TextXAlignment = Enum.TextXAlignment.Right; ln.TextYAlignment = Enum.TextYAlignment.Top; ln.Font = Enum.Font.Code; ln.TextSize = 16; ln.TextColor3 = c3(ui.subtxt); ln.RichText = false; ln.Text = "1";
local sc = make(editv, "ScrollingFrame", "sc"); sc.Size = UDim2.new(1,-gutw,1,0); sc.Position = UDim2.new(0,gutw,0,0); sc.CanvasSize = UDim2.new(0,0,0,0); sc.ScrollBarThickness = 6; sc.ScrollBarImageColor3 = c3(ui.scroll); sc.BackgroundColor3 = c3(ui.main_bg); sc.BorderSizePixel = 0;
local cnt = make(sc, "Frame", "cnt"); cnt.Size = UDim2.new(1,-12,0,0); cnt.Position = UDim2.new(0,6,0,0); cnt.BackgroundTransparency = 1;
local hi = make(cnt, "TextLabel", "hi"); hi.Size = UDim2.new(1,0,0,0); hi.BackgroundTransparency = 1; hi.TextXAlignment = Enum.TextXAlignment.Left; hi.TextYAlignment = Enum.TextYAlignment.Top; hi.Font = Enum.Font.Code; hi.TextSize = 16; hi.TextColor3 = c3(ui.txt); hi.RichText = true; hi.TextWrapped = false; hi.Text = "";
local txt = make(cnt, "TextBox", "txt"); txt.ClearTextOnFocus = false; txt.MultiLine = true; txt.TextEditable = true; txt.Size = UDim2.new(1,0,0,0); txt.Position = UDim2.new(0,0,0,0); txt.BackgroundTransparency = 1; txt.TextTransparency = 1; txt.TextXAlignment = Enum.TextXAlignment.Left; txt.TextYAlignment = Enum.TextYAlignment.Top; txt.Font = Enum.Font.Code; txt.TextSize = 16; txt.TextColor3 = c3(ui.txt);
local setv = make(main, "Frame", "setv"); setv.Size = UDim2.new(1,0,1,0); setv.Position = UDim2.new(1,0,0,0); setv.BackgroundColor3 = c3(ui.main_bg); setv.BorderSizePixel = 0; setv.Visible = false;
local ssc = make(setv, "ScrollingFrame", "ssc"); ssc.Size = UDim2.new(1,0,1,0); ssc.BackgroundTransparency = 1; ssc.ScrollBarThickness = 6; ssc.ScrollBarImageColor3 = c3(ui.scroll); ssc.AutomaticCanvasSize = Enum.AutomaticSize.Y;
local setc = make(ssc, "Frame", "setc"); setc.Size = UDim2.new(1,-20,0,0); setc.Position = UDim2.new(0,10,0,8); setc.BackgroundTransparency = 1; setc.AutomaticSize = Enum.AutomaticSize.Y;
local stack = Instance.new("UIListLayout"); stack.Padding = UDim.new(0,8); stack.FillDirection = Enum.FillDirection.Vertical; stack.SortOrder = Enum.SortOrder.LayoutOrder; stack.Parent = setc;
local defcol = {}; for k,v in pairs(syn.col) do defcol[k]=v end;
local list = {"kw","str","com","num","lib","fn"};
local flds = {};
local headh = 26; local pad = 10;
local stl = make(setc, "TextLabel", "ttl"); stl.Size = UDim2.new(1,0,0,headh); stl.BackgroundTransparency = 1; stl.TextXAlignment = Enum.TextXAlignment.Left; stl.Font = Enum.Font.Code; stl.TextSize = 16; stl.TextColor3 = c3(ui.txt); stl.Text = "settings"; stl.LayoutOrder = 1;
local cols = make(setc, "Frame", "cols"); cols.BackgroundTransparency = 1; cols.AutomaticSize = Enum.AutomaticSize.Y; cols.LayoutOrder = 2;
local gl = Instance.new("UIGridLayout"); gl.Parent = cols; gl.FillDirection = Enum.FillDirection.Horizontal; gl.HorizontalAlignment = Enum.HorizontalAlignment.Left; gl.VerticalAlignment = Enum.VerticalAlignment.Top; gl.CellPadding = UDim2.new(0,10,0,10); gl.FillDirectionMaxCells = 3; gl.SortOrder = Enum.SortOrder.Name; gl.CellSize = UDim2.new(1/3,-14,0,100);
local function mksec(p, n)
  local s = make(p, "Frame", n); s.BackgroundColor3 = c3(ui.sec_bg); s.BorderSizePixel = 0; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,4); c.Parent = s; local st = Instance.new("UIStroke"); st.Color = c3(ui.sec_stroke); st.Thickness = 1; st.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; st.Parent = s; return s;
end
local s_col = mksec(cols, "s_col");
local ht1 = make(s_col, "TextLabel", "ttl"); ht1.Size = UDim2.new(1,-pad*2,0,headh); ht1.Position = UDim2.new(0,pad,0,pad); ht1.BackgroundTransparency = 1; ht1.TextXAlignment = Enum.TextXAlignment.Left; ht1.Font = Enum.Font.Code; ht1.TextSize = 16; ht1.TextColor3 = c3(ui.txt); ht1.Text = "colors";
local yoff = pad + headh + 6; local rowh = 36;
for i=1,#list do
  local k = list[i]; local y = yoff + (i-1)*rowh; local l = make(s_col, "TextLabel", k.."_l"); l.Size = UDim2.new(0,60,0,28); l.Position = UDim2.new(0,pad,0,y+4); l.BackgroundTransparency = 1; l.TextXAlignment = Enum.TextXAlignment.Left; l.Font = Enum.Font.Code; l.TextSize = 16; l.TextColor3 = c3(ui.subtxt); l.Text = k;
  local tb = make(s_col, "TextBox", k.."_tb"); tb.Size = UDim2.new(1,-(pad*2+70),0,28); tb.Position = UDim2.new(0,pad+70,0,y+4); tb.BackgroundColor3 = c3(ui.input_bg); tb.BorderSizePixel = 0; tb.Font = Enum.Font.Code; tb.TextSize = 16; tb.TextColor3 = c3(ui.input_tx); tb.ClearTextOnFocus = false; tb.Text = defcol[k] or "#FFFFFF"; local cr = Instance.new("UICorner"); cr.CornerRadius = UDim.new(0,4); cr.Parent = tb; flds[k]=tb;
end
local s_col_h = yoff + #list*rowh + pad; s_col.Size = UDim2.new(1,0,0,s_col_h);
local s_sld = mksec(cols, "s_sld");
local ht3 = make(s_sld, "TextLabel", "ttl"); ht3.Size = UDim2.new(1,-pad*2,0,headh); ht3.Position = UDim2.new(0,pad,0,pad); ht3.BackgroundTransparency = 1; ht3.TextXAlignment = Enum.TextXAlignment.Left; ht3.Font = Enum.Font.Code; ht3.TextSize = 16; ht3.TextColor3 = c3(ui.txt); ht3.Text = "sliders";
local sd = {}; local drag_i = nil; local function sd_set(i, a)
  local d = sd[i]; if not d then return end; if typeof(a) ~= "number" then return end; if a < 0 then a = 0 elseif a > 1 then a = 1 end; d.val = a; d.fill.Size = UDim2.new(a,0,1,0);
end
local function sd_pos_to_val(bar)
  local m = uis:GetMouseLocation(); local x = m.X - bar.AbsolutePosition.X; local w = bar.AbsoluteSize.X; if w <= 0 then return 0 end; local v = x / w; if v < 0 then v = 0 elseif v > 1 then v = 1 end; return v;
end
for i=1,3 do
  local y = pad + headh + 6 + (i-1)*40; local l = make(s_sld, "TextLabel", "sd_"..i); l.Size = UDim2.new(0,90,0,24); l.Position = UDim2.new(0,pad,0,y+2); l.BackgroundTransparency = 1; l.TextXAlignment = Enum.TextXAlignment.Left; l.Font = Enum.Font.Code; l.TextSize = 16; l.TextColor3 = c3(ui.subtxt); l.Text = "ph "..i;
  local bar = make(s_sld, "Frame", "bar_"..i); bar.Size = UDim2.new(1,-(pad*2+100),0,6); bar.Position = UDim2.new(0,pad+100,0,y+9); bar.BackgroundColor3 = c3(ui.sld_bar); bar.BorderSizePixel = 0; local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(1,0); bc.Parent = bar; local fill = make(bar, "Frame", "fill"); fill.Size = UDim2.new(0.5,0,1,0); fill.Position = UDim2.new(0,0,0,0); fill.BackgroundColor3 = c3(ui.sld_fill); fill.BorderSizePixel = 0; local fc = Instance.new("UICorner"); fc.CornerRadius = UDim.new(1,0); fc.Parent = fill; sd[i] = {bar=bar,fill=fill,val=0.5};
  cons[#cons+1] = bar.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then drag_i = i; sd_set(i, sd_pos_to_val(bar)) end end);
  cons[#cons+1] = fill.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then drag_i = i; sd_set(i, sd_pos_to_val(bar)) end end);
end
cons[#cons+1] = uis.InputChanged:Connect(function(inp)
  if not drag_i then return end; if inp.UserInputType ~= Enum.UserInputType.MouseMovement and inp.UserInputType ~= Enum.UserInputType.Touch then return end; local d = sd[drag_i]; if not d then return end; sd_set(drag_i, sd_pos_to_val(d.bar));
end);
cons[#cons+1] = uis.InputEnded:Connect(function(inp)
  if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then drag_i = nil end
end);
local s_tog = mksec(cols, "s_tog");
local ht2 = make(s_tog, "TextLabel", "ttl"); ht2.Size = UDim2.new(1,-pad*2,0,headh); ht2.Position = UDim2.new(0,pad,0,pad); ht2.BackgroundTransparency = 1; ht2.TextXAlignment = Enum.TextXAlignment.Left; ht2.Font = Enum.Font.Code; ht2.TextSize = 16; ht2.TextColor3 = c3(ui.txt); ht2.Text = "toggles";
local tg = {}; local function tg_set(i, v)
  local d = tg[i]; if not d then return end; d.val = v and true or false; ts:Create(d.dot, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = v and UDim2.new(1,-21,0,1) or UDim2.new(0,1,0,1)}):Play(); ts:Create(d.sw, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = v and c3(ui.tg_on) or c3(ui.tg_off)}):Play();
end
for i=1,3 do
  local y = pad + headh + 6 + (i-1)*36; local l = make(s_tog, "TextLabel", "tg_"..i); l.Size = UDim2.new(0,90,0,24); l.Position = UDim2.new(0,pad,0,y+2); l.BackgroundTransparency = 1; l.TextXAlignment = Enum.TextXAlignment.Left; l.Font = Enum.Font.Code; l.TextSize = 16; l.TextColor3 = c3(ui.subtxt); l.Text = "ph "..i;
  local sw = make(s_tog, "Frame", "sw_"..i); sw.Size = UDim2.new(0,44,0,22); sw.Position = UDim2.new(0,pad+100,0,y); sw.BackgroundColor3 = c3(ui.tg_off); sw.BorderSizePixel = 0; local swc = Instance.new("UICorner"); swc.CornerRadius = UDim.new(1,0); swc.Parent = sw; local dot = make(sw, "Frame", "dot"); dot.Size = UDim2.new(0,20,0,20); dot.Position = UDim2.new(0,1,0,1); dot.BackgroundColor3 = c3(ui.tg_dot); dot.BorderSizePixel = 0; local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1,0); dc.Parent = dot; tg[i] = {sw=sw,dot=dot,val=false};
  cons[#cons+1] = sw.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then tg_set(i, not tg[i].val) end end);
end
local function mkfld(parent, x, y, w, key, map)
  local l = make(parent, "TextLabel", key.."_l"); l.Size = UDim2.new(0,90,0,28); l.Position = UDim2.new(0,x,0,y); l.BackgroundTransparency = 1; l.TextXAlignment = Enum.TextXAlignment.Left; l.Font = Enum.Font.Code; l.TextSize = 16; l.TextColor3 = c3(ui.subtxt); l.Text = key;
  local tb = make(parent, "TextBox", key.."_tb"); tb.Size = UDim2.new(0,w,0,28); tb.Position = UDim2.new(0,x+100,0,y); tb.BackgroundColor3 = c3(ui.input_bg); tb.BorderSizePixel = 0; tb.Font = Enum.Font.Code; tb.TextSize = 16; tb.TextColor3 = c3(ui.input_tx); tb.ClearTextOnFocus = false; tb.Text = map[key]; local cr = Instance.new("UICorner"); cr.CornerRadius = UDim.new(0,4); cr.Parent = tb; return tb;
end
local s_ui = mksec(cols, "s_ui");
local htu = make(s_ui, "TextLabel", "ttl"); htu.Size = UDim2.new(1,-pad*2,0,headh); htu.Position = UDim2.new(0,pad,0,pad); htu.BackgroundTransparency = 1; htu.TextXAlignment = Enum.TextXAlignment.Left; htu.Font = Enum.Font.Code; htu.TextSize = 16; htu.TextColor3 = c3(ui.txt); htu.Text = "ui";
local ufld = {};
local ux = pad; local uy = pad + headh + 6; local uw = 150; local step = 32; local colw = 260; local colgap = 12; local colc = 2; local idx = 0;
local order = {
  "root_bg","top_bg","main_bg","gut_bg","scroll","txt","subtxt","tab_on","tab_off",
  "sec_bg","sec_stroke","input_bg","input_tx","btn_ok_bg","btn_ok_tx","btn_rs_bg","btn_rs_tx",
  "tg_off","tg_on","tg_dot","sld_bar","sld_fill",
};
for _,k in ipairs(order) do
  local cx = ux + (idx%colc)*(colw+colgap); local cy = uy + math.floor(idx/colc)*step; ufld[k] = mkfld(s_ui, cx, cy, uw, k, ui); idx = idx + 1;
end
local s_ui_h = uy + math.ceil(#order/colc)*step + pad; s_ui.Size = UDim2.new(1,0,0,s_ui_h);
local act = make(setc, "Frame", "act"); act.Size = UDim2.new(1,0,0,38); act.BackgroundTransparency = 1; act.LayoutOrder = 3;
local apply = make(act, "TextButton", "apply"); apply.Size = UDim2.new(0,120,0,28); apply.Position = UDim2.new(0,0,0,5); apply.Text = "apply"; apply.Font = Enum.Font.Code; apply.TextSize = 16; apply.TextColor3 = c3(ui.btn_ok_tx); apply.BackgroundColor3 = c3(ui.btn_ok_bg); apply.BorderSizePixel = 0; local apc = Instance.new("UICorner"); apc.CornerRadius = UDim.new(0,4); apc.Parent = apply;
local reset = make(act, "TextButton", "reset"); reset.Size = UDim2.new(0,120,0,28); reset.Position = UDim2.new(0,130,0,5); reset.Text = "reset"; reset.Font = Enum.Font.Code; reset.TextSize = 16; reset.TextColor3 = c3(ui.btn_rs_tx); reset.BackgroundColor3 = c3(ui.btn_rs_bg); reset.BorderSizePixel = 0; local rsc = Instance.new("UICorner"); rsc.CornerRadius = UDim.new(0,4); rsc.Parent = reset;
local function setln(s)
  local n = 1; for _ in s:gmatch("\n") do n = n + 1 end; local t = {}; for i=1,n do t[#t+1] = tostring(i) end; ln.Text = table.concat(t, "\n"); ln.Size = UDim2.new(1,-6,0,hi.TextBounds.Y); gut.CanvasSize = UDim2.new(0,0,0,math.max(hi.TextBounds.Y, main.AbsoluteSize.Y));
end
local t0 = 0; local dt = 0.05; local pend = false;
local function upd()
  local s = txt.Text; hi.Text = syn.hl(s); hi.Size = UDim2.new(1,0,0,hi.TextBounds.Y+8); txt.Size = hi.Size; sc.CanvasSize = UDim2.new(0,0,0,math.max(hi.TextBounds.Y, main.AbsoluteSize.Y)); setln(s);
end
local function normhex(s)
  if typeof(s) ~= "string" then return nil end; s = s:gsub("%s+",""); if s == "" then return nil end; if s:sub(1,1) ~= "#" then s = "#"..s end; if #s ~= 7 then return nil end; if not s:match("^#%x%x%x%x%x%x$") then return nil end; return s:upper();
end
local function fill()
  for k,tb in pairs(flds) do tb.Text = syn.col[k] or defcol[k] or "#FFFFFF" end;
end
local function fillui()
  for k,tb in pairs(ufld) do tb.Text = ui[k] end;
end
local function apply_ui()
  root.BackgroundColor3 = c3(ui.root_bg); top.BackgroundColor3 = c3(ui.top_bg); main.BackgroundColor3 = c3(ui.main_bg);
  ttl.TextColor3 = c3(ui.txt); btnedit.TextColor3 = c3(ui.tab_on); btncfg.TextColor3 = c3(ui.tab_off);
  gut.BackgroundColor3 = c3(ui.gut_bg); gut.ScrollBarImageColor3 = c3(ui.scroll); sc.ScrollBarImageColor3 = c3(ui.scroll); ln.TextColor3 = c3(ui.subtxt); hi.TextColor3 = c3(ui.txt);
  for _,sec in ipairs({s_col,s_sld,s_tog,s_ui}) do local st = sec:FindFirstChildOfClass("UIStroke"); if st then st.Color = c3(ui.sec_stroke) end; sec.BackgroundColor3 = c3(ui.sec_bg) end;
  for _,tb in pairs(flds) do tb.BackgroundColor3 = c3(ui.input_bg); tb.TextColor3 = c3(ui.input_tx) end; for _,tb in pairs(ufld) do tb.BackgroundColor3 = c3(ui.input_bg); tb.TextColor3 = c3(ui.input_tx) end;
  apply.BackgroundColor3 = c3(ui.btn_ok_bg); apply.TextColor3 = c3(ui.btn_ok_tx); reset.BackgroundColor3 = c3(ui.btn_rs_bg); reset.TextColor3 = c3(ui.btn_rs_tx);
  for i=1,3 do local d = tg[i]; if d then d.dot.BackgroundColor3 = c3(ui.tg_dot); d.sw.BackgroundColor3 = d.val and c3(ui.tg_on) or c3(ui.tg_off) end end;
  for i=1,3 do local d = sd[i]; if d then d.bar.BackgroundColor3 = c3(ui.sld_bar); d.fill.BackgroundColor3 = c3(ui.sld_fill) end end;
end
cons[#cons+1] = txt:GetPropertyChangedSignal("Text"):Connect(function() pend = true; end);
cons[#cons+1] = rs.Heartbeat:Connect(function() if not pend then return end; local now = os.clock(); if now - t0 < dt then return end; t0 = now; pend = false; upd(); end);
cons[#cons+1] = sc:GetPropertyChangedSignal("CanvasPosition"):Connect(function() gut.CanvasPosition = Vector2.new(0, sc.CanvasPosition.Y); end);
cons[#cons+1] = btnx.MouseButton1Click:Connect(function() for i=#cons,1,-1 do local c = cons[i]; if c and c.Disconnect then c:Disconnect() end end; sg:Destroy(); end);
local cur = "edit"; local anim = false; local tinfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local function tab(n)
  if anim then return end; if n == cur then return end; anim = true;
  local on = c3(ui.tab_on); local off = c3(ui.tab_off);
  if n == "settings" then
    btnedit.TextColor3 = off; btncfg.TextColor3 = on; fill(); fillui(); setv.Visible = true; editv.Visible = true; ssc.CanvasPosition = Vector2.new(); setv.Position = UDim2.new(1,0,0,0); editv.Position = UDim2.new(0,0,0,0);
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
  for k,tb in pairs(flds) do local v = normhex(tb.Text); if v then syn.col[k]=v end end;
  for k,tb in pairs(ufld) do local v = normhex(tb.Text); if v then ui[k]=v end end; apply_ui(); upd();
end);
cons[#cons+1] = reset.MouseButton1Click:Connect(function()
  for k,v in pairs(defcol) do syn.col[k]=v end; for k,v in pairs(defui) do ui[k]=v end; fill(); fillui(); apply_ui(); upd();
end);
apply_ui(); btnedit.TextColor3 = c3(ui.tab_on); btncfg.TextColor3 = c3(ui.tab_off); setv.Visible = false; editv.Visible = true; editv.Position = UDim2.new(0,0,0,0);
upd();
