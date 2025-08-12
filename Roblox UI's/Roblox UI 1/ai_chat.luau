local ai = {};

local hs = game:GetService("HttpService");
local plrs = game:GetService("Players");
local rs = game:GetService("RunService");

local root = nil;
local cons = {};
local msgs = {};
local mods = {};
local selmod = nil;
local busy = false;
local maxn = 50;
local cfgp = "ai_chat/cfg.json";
local keyp = "ai_chat/key.txt";
local key = nil;
local sys = "";
local rules = "";

local function addcon(s, f)
    local c = s:Connect(f);
    table.insert(cons, c);
    return c;
end;

local function i(t)
    return Instance.new(t);
end;

local function ensurefs()
    if not isfolder("ai_chat") then
        makefolder("ai_chat");
    end;
end;

local function loadcfg()
    ensurefs();
    if isfile(keyp) then
        key = readfile(keyp);
    end;
    if isfile(cfgp) then
        local ok, d = pcall(function()
            return hs:JSONDecode(readfile(cfgp));
        end);
        if ok and typeof(d) == "table" then
            sys = typeof(d.sys) == "string" and d.sys or "";
            rules = typeof(d.rules) == "string" and d.rules or "";
            selmod = typeof(d.selmod) == "string" and d.selmod or nil;
        end;
    end;
end;

local function savecfg()
    ensurefs();
    if key and #key > 0 then
        writefile(keyp, key);
    end;
    local d = { sys = sys, rules = rules, selmod = selmod };
    writefile(cfgp, hs:JSONEncode(d));
end;

local function setstat(lbl, t)
    if lbl then
        lbl.Text = t or "";
    end;
end;

local function addmsg(list, role, txt)
    while #msgs >= maxn do
        table.remove(msgs, 1);
    end;
    table.insert(msgs, { role = role, content = txt });
    local fr = i("Frame");
    fr.Size = UDim2.new(1, 0, 0, 0);
    fr.BackgroundTransparency = 1;
    fr.BorderSizePixel = 0;
    fr.LayoutOrder = #list:GetChildren() + 1;
    local tb = i("TextLabel");
    tb.BackgroundTransparency = 1;
    tb.BorderSizePixel = 0;
    tb.TextWrapped = true;
    tb.RichText = false;
    tb.TextXAlignment = Enum.TextXAlignment.Left;
    tb.TextYAlignment = Enum.TextYAlignment.Top;
    tb.Font = Enum.Font.SourceSans;
    tb.TextSize = 16;
    tb.Text = (role == "user" and "you: " or role .. ": ") .. txt;
    tb.Size = UDim2.new(1, -10, 0, 0);
    tb.Position = UDim2.new(0, 10, 0, 0);
    tb.Parent = fr;
    fr.Parent = list;
    tb.Size = UDim2.new(1, -10, 0, math.max(24, tb.TextBounds.Y + 6));
end;

local function setbusy(ui, b)
    busy = b;
    if ui and ui.send then
        ui.send.AutoButtonColor = not b;
        ui.send.Active = not b;
        ui.send.Text = b and "sending" or "send";
    end;
end;

local function fetchmods(stat, ddlist, ddlabel)
    if not key or #key == 0 then
        setstat(stat, "no api key");
        return;
    end;
    setstat(stat, "loading models");
    local r = request({
        Url = "https://openrouter.ai/api/v1/models",
        Method = "GET",
        Headers = {
            ["Authorization"] = "Bearer " .. key,
            ["Content-Type"] = "application/json",
            ["X-Title"] = "roblox-ui",
        },
    });
    if not r or r.StatusCode < 200 or r.StatusCode >= 300 then
        setstat(stat, "models err " .. tostring(r and r.StatusCode or ""));
        return;
    end;
    local ok, data = pcall(function()
        return hs:JSONDecode(r.Body);
    end);
    if not ok or typeof(data) ~= "table" or typeof(data.data) ~= "table" then
        setstat(stat, "models parse err");
        return;
    end;
    table.clear(mods);
    for _, m in ipairs(data.data) do
        if typeof(m) == "table" and typeof(m.id) == "string" then
            table.insert(mods, { id = m.id, name = typeof(m.name) == "string" and m.name or m.id });
        end;
    end;
    table.sort(mods, function(a, b)
        return a.id < b.id;
    end);
    if ddlist then
        for _, c in ipairs(ddlist:GetChildren()) do
            if c:IsA("TextButton") then
                c:Destroy();
            end;
        end;
        local idx = 0;
        for _, m in ipairs(mods) do
            idx += 1;
            local btn = i("TextButton");
            btn.Size = UDim2.new(1, -4, 0, 24);
            btn.Position = UDim2.new(0, 2, 0, (idx - 1) * 26);
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
            btn.TextColor3 = Color3.fromRGB(230, 230, 230);
            btn.Font = Enum.Font.SourceSans;
            btn.TextSize = 14;
            btn.TextXAlignment = Enum.TextXAlignment.Left;
            btn.Text = m.name .. " (" .. m.id .. ")";
            addcon(btn.MouseButton1Click, function()
                selmod = m.id;
                if ddlabel then
                    ddlabel.Text = m.name;
                end;
                savecfg();
            end);
            btn.Parent = ddlist;
        end;
        ddlist.CanvasSize = UDim2.new(0, 0, 0, math.max(0, (#mods * 26)));
    end;
    setstat(stat, "models " .. tostring(#mods));
end;

local function callchat(stat, list, ui, usertxt)
    if busy then
        return;
    end;
    if not key or #key == 0 then
        setstat(stat, "no api key");
        return;
    end;
    if not selmod or #selmod == 0 then
        setstat(stat, "no model");
        return;
    end;
    setbusy(ui, true);
    setstat(stat, "sending");
    local sendmsgs = {};
    if sys and #sys > 0 then
        table.insert(sendmsgs, { role = "system", content = sys });
    end;
    if rules and #rules > 0 then
        table.insert(sendmsgs, { role = "system", content = rules });
    end;
    for _, m in ipairs(msgs) do
        table.insert(sendmsgs, { role = m.role, content = m.content });
    end;
    table.insert(sendmsgs, { role = "user", content = usertxt });
    local body = hs:JSONEncode({
        model = selmod,
        messages = sendmsgs,
    });
    local r = request({
        Url = "https://openrouter.ai/api/v1/chat/completions",
        Method = "POST",
        Headers = {
            ["Authorization"] = "Bearer " .. key,
            ["Content-Type"] = "application/json",
            ["HTTP-Referer"] = "https://github.com/clippyarchives/Roblox-Stuff",
            ["X-Title"] = "roblox-ui",
        },
        Body = body,
    });
    if not r or r.StatusCode < 200 or r.StatusCode >= 300 then
        setstat(stat, "http " .. tostring(r and r.StatusCode or ""));
        setbusy(ui, false);
        return;
    end;
    local ok, data = pcall(function()
        return hs:JSONDecode(r.Body);
    end);
    if not ok or typeof(data) ~= "table" or typeof(data.choices) ~= "table" or not data.choices[1] or not data.choices[1].message then
        setstat(stat, "parse err");
        setbusy(ui, false);
        return;
    end;
    local out = tostring(data.choices[1].message.content or "");
    addmsg(list, "user", usertxt);
    addmsg(list, "assistant", out);
    setstat(stat, "ok");
    setbusy(ui, false);
end;

function ai.create(parent)
    loadcfg();
    local pg = parent or gethui();
    local sg = i("ScreenGui");
    sg.ResetOnSpawn = false;
    sg.IgnoreGuiInset = true;
    sg.Name = "ai_chat";
    sg.Parent = pg;
    root = sg;

    local main = i("Frame");
    main.Name = "main";
    main.Size = UDim2.new(0, 520, 0, 420);
    main.Position = UDim2.new(0.5, -260, 0.5, -210);
    main.BackgroundColor3 = Color3.fromRGB(26, 26, 30);
    main.BorderSizePixel = 0;
    main.Parent = sg;

    local top = i("Frame");
    top.Size = UDim2.new(1, 0, 0, 36);
    top.Position = UDim2.new(0, 0, 0, 0);
    top.BackgroundColor3 = Color3.fromRGB(32, 32, 38);
    top.BorderSizePixel = 0;
    top.Parent = main;

    local stat = i("TextLabel");
    stat.Size = UDim2.new(1, -10, 0, 16);
    stat.Position = UDim2.new(0, 5, 0, 10);
    stat.BackgroundTransparency = 1;
    stat.TextColor3 = Color3.fromRGB(180, 180, 190);
    stat.TextXAlignment = Enum.TextXAlignment.Left;
    stat.Font = Enum.Font.SourceSans;
    stat.TextSize = 14;
    stat.Text = "";
    stat.Parent = top;

    local body = i("Frame");
    body.Size = UDim2.new(1, -12, 1, -48);
    body.Position = UDim2.new(0, 6, 0, 42);
    body.BackgroundTransparency = 1;
    body.Parent = main;

    local cfg = i("Frame");
    cfg.Size = UDim2.new(1, 0, 0, 96);
    cfg.Position = UDim2.new(0, 0, 0, 0);
    cfg.BackgroundColor3 = Color3.fromRGB(28, 28, 34);
    cfg.BorderSizePixel = 0;
    cfg.Parent = body;

    local keybx = i("TextBox");
    keybx.Size = UDim2.new(0.5, -8, 0, 24);
    keybx.Position = UDim2.new(0, 8, 0, 8);
    keybx.Text = key or "";
    keybx.PlaceholderText = "api key";
    keybx.TextXAlignment = Enum.TextXAlignment.Left;
    keybx.TextColor3 = Color3.fromRGB(230, 230, 230);
    keybx.BackgroundColor3 = Color3.fromRGB(40, 40, 46);
    keybx.BorderSizePixel = 0;
    keybx.ClearTextOnFocus = false;
    keybx.TextSize = 14;
    keybx.Parent = cfg;

    local savebtn = i("TextButton");
    savebtn.Size = UDim2.new(0, 80, 0, 24);
    savebtn.Position = UDim2.new(0, 8, 0, 36);
    savebtn.Text = "save";
    savebtn.Font = Enum.Font.SourceSans;
    savebtn.TextSize = 14;
    savebtn.TextColor3 = Color3.fromRGB(230, 230, 230);
    savebtn.BackgroundColor3 = Color3.fromRGB(50, 50, 56);
    savebtn.BorderSizePixel = 0;
    savebtn.Parent = cfg;

    local dd = i("Frame");
    dd.Size = UDim2.new(0.5, -8, 0, 24);
    dd.Position = UDim2.new(0.5, 0, 0, 8);
    dd.BackgroundColor3 = Color3.fromRGB(40, 40, 46);
    dd.BorderSizePixel = 0;
    dd.Parent = cfg;

    local ddlabel = i("TextButton");
    ddlabel.Size = UDim2.new(1, -24, 1, 0);
    ddlabel.Position = UDim2.new(0, 8, 0, 0);
    ddlabel.TextXAlignment = Enum.TextXAlignment.Left;
    ddlabel.Font = Enum.Font.SourceSans;
    ddlabel.TextSize = 14;
    ddlabel.TextColor3 = Color3.fromRGB(230, 230, 230);
    ddlabel.BackgroundTransparency = 1;
    ddlabel.Text = selmod or "select model";
    ddlabel.Parent = dd;

    local ddlist = i("ScrollingFrame");
    ddlist.Visible = false;
    ddlist.Size = UDim2.new(1, 0, 0, 140);
    ddlist.Position = UDim2.new(0, 0, 0, 24);
    ddlist.BackgroundColor3 = Color3.fromRGB(36, 36, 42);
    ddlist.BorderSizePixel = 0;
    ddlist.CanvasSize = UDim2.new(0, 0, 0, 0);
    ddlist.ScrollBarThickness = 4;
    ddlist.Parent = dd;

    local refbtn = i("TextButton");
    refbtn.Size = UDim2.new(0, 80, 0, 24);
    refbtn.Position = UDim2.new(0, 96, 0, 36);
    refbtn.Text = "refresh";
    refbtn.Font = Enum.Font.SourceSans;
    refbtn.TextSize = 14;
    refbtn.TextColor3 = Color3.fromRGB(230, 230, 230);
    refbtn.BackgroundColor3 = Color3.fromRGB(50, 50, 56);
    refbtn.BorderSizePixel = 0;
    refbtn.Parent = cfg;

    local sysbx = i("TextBox");
    sysbx.MultiLine = true;
    sysbx.Size = UDim2.new(0.5, -8, 0, 24);
    sysbx.Position = UDim2.new(0.5, 0, 0, 36);
    sysbx.Text = sys or "";
    sysbx.PlaceholderText = "system";
    sysbx.TextXAlignment = Enum.TextXAlignment.Left;
    sysbx.TextYAlignment = Enum.TextYAlignment.Top;
    sysbx.TextColor3 = Color3.fromRGB(230, 230, 230);
    sysbx.BackgroundColor3 = Color3.fromRGB(40, 40, 46);
    sysbx.BorderSizePixel = 0;
    sysbx.ClearTextOnFocus = false;
    sysbx.TextSize = 14;
    sysbx.Parent = cfg;

    local rulesbx = i("TextBox");
    rulesbx.MultiLine = true;
    rulesbx.Size = UDim2.new(0.5, -8, 0, 24);
    rulesbx.Position = UDim2.new(0, 96, 0, 36);
    rulesbx.Text = rules or "";
    rulesbx.PlaceholderText = "rules";
    rulesbx.TextXAlignment = Enum.TextXAlignment.Left;
    rulesbx.TextYAlignment = Enum.TextYAlignment.Top;
    rulesbx.TextColor3 = Color3.fromRGB(230, 230, 230);
    rulesbx.BackgroundColor3 = Color3.fromRGB(40, 40, 46);
    rulesbx.BorderSizePixel = 0;
    rulesbx.ClearTextOnFocus = false;
    rulesbx.TextSize = 14;
    rulesbx.Parent = cfg;

    local chat = i("Frame");
    chat.Size = UDim2.new(1, 0, 1, -96);
    chat.Position = UDim2.new(0, 0, 0, 96);
    chat.BackgroundTransparency = 1;
    chat.Parent = body;

    local list = i("ScrollingFrame");
    list.Size = UDim2.new(1, 0, 1, -40);
    list.Position = UDim2.new(0, 0, 0, 0);
    list.BackgroundColor3 = Color3.fromRGB(24, 24, 28);
    list.BorderSizePixel = 0;
    list.CanvasSize = UDim2.new(0, 0, 0, 0);
    list.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    list.ScrollBarThickness = 4;
    list.Parent = chat;

    local layout = i("UIListLayout");
    layout.Padding = UDim.new(0, 6);
    layout.SortOrder = Enum.SortOrder.LayoutOrder;
    layout.Parent = list;

    local inp = i("TextBox");
    inp.Size = UDim2.new(1, -84, 0, 32);
    inp.Position = UDim2.new(0, 0, 1, -36);
    inp.Text = "";
    inp.PlaceholderText = "type";
    inp.TextXAlignment = Enum.TextXAlignment.Left;
    inp.TextYAlignment = Enum.TextYAlignment.Center;
    inp.TextColor3 = Color3.fromRGB(230, 230, 230);
    inp.BackgroundColor3 = Color3.fromRGB(40, 40, 46);
    inp.BorderSizePixel = 0;
    inp.ClearTextOnFocus = false;
    inp.TextSize = 16;
    inp.Parent = chat;

    local send = i("TextButton");
    send.Size = UDim2.new(0, 80, 0, 32);
    send.Position = UDim2.new(1, -80, 1, -36);
    send.Text = "send";
    send.Font = Enum.Font.SourceSans;
    send.TextSize = 16;
    send.TextColor3 = Color3.fromRGB(230, 230, 230);
    send.BackgroundColor3 = Color3.fromRGB(60, 60, 66);
    send.BorderSizePixel = 0;
    send.Parent = chat;

    addcon(savebtn.MouseButton1Click, function()
        key = keybx.Text or "";
        sys = sysbx.Text or "";
        rules = rulesbx.Text or "";
        savecfg();
        setstat(stat, "saved");
    end);

    addcon(ddlabel.MouseButton1Click, function()
        ddlist.Visible = not ddlist.Visible;
    end);

    addcon(refbtn.MouseButton1Click, function()
        fetchmods(stat, ddlist, ddlabel);
    end);

    addcon(send.MouseButton1Click, function()
        local t = inp.Text or "";
        if #t == 0 then
            return;
        end;
        inp.Text = "";
        callchat(stat, list, { send = send }, t);
    end);

    addcon(inp.FocusLost, function(enter)
        if enter then
            local t = inp.Text or "";
            if #t == 0 then
                return;
            end;
            inp.Text = "";
            callchat(stat, list, { send = send }, t);
        end;
    end);

    if selmod and #selmod > 0 then
        ddlabel.Text = selmod;
    end;

    return {
        gui = sg,
        main = main,
        destroy = function()
            for _, c in ipairs(cons) do
                pcall(function()
                    c:Disconnect();
                end);
            end;
            if sg then
                sg:Destroy();
            end;
            root = nil;
        end,
    };
end;

return ai;