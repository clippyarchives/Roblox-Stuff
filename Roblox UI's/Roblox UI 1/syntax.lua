local syn = {};
syn.kw = { ["and"]=true,["break"]=true,["do"]=true,["else"]=true,["elseif"]=true,["end"]=true,["false"]=true,["for"]=true,["function"]=true,["if"]=true,["in"]=true,["local"]=true,["nil"]=true,["not"]=true,["or"]=true,["repeat"]=true,["return"]=true,["then"]=true,["true"]=true,["until"]=true,["while"]=true };
syn.col = {kw="#569CD6", str="#CE9178", com="#6A9955", num="#B5CEA8"};
local sent = string.char(30);
local function esc(s)
  s = s:gsub("&","&amp;"); s = s:gsub("<","&lt;"); s = s:gsub(">","&gt;"); return s;
end
local function hold(segs, v)
  local i = #segs+1; segs[i] = v; return sent..i..sent;
end
function syn.hl(s)
  if typeof(s) ~= "string" then return "" end;
  local segs = {};
  s = esc(s);
  s = s:gsub("(%b\"\")", function(m) return hold(segs, "<font color=\""..syn.col.str.."\">"..m.."</font>") end);
  s = s:gsub("(%b'')", function(m) return hold(segs, "<font color=\""..syn.col.str.."\">"..m.."</font>") end);
  s = s:gsub("(%-%-[^\n]*)", function(m) return hold(segs, "<font color=\""..syn.col.com.."\">"..m.."</font>") end);
  for k,_ in pairs(syn.kw) do
    s = s:gsub("%f[%a_]"..k.."%f[^%a_]", "<font color=\""..syn.col.kw.."\">"..k.."</font>");
  end
  s = s:gsub("%f[%d]([%d]+%.?[%d]*)%f[^%d]", "<font color=\""..syn.col.num.."\">%1</font>");
  s = s:gsub(sent.."(%d+)"..sent, function(i) return segs[tonumber(i)] or "" end);
  return s;
end
return syn;