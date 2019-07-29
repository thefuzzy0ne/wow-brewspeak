local addonName = ...
local addon = DongleStub("Dongle-1.0"):New(addonName)
_G[addonName] = addon

local function split_into_chars(text)
	local split_chars = {}

	for i=1, #text do
		table.insert(split_chars, strsub(text, i, i))
	end

	return split_chars
end

local function BrewSpeakFilter(text)
	if text == "" then return "" end
	text = split_into_chars(text)
	
	-- Randomly replace "s" with "sh" so long as an "s" doesn't preceed or follow, and an "it" doesn't follow.
	for i=1, #text do
		if strlower(text[i]) == "s" then
			local prev_char = text[i-1] and strlower(text[i-1]) or ""
			local next_char = text[i+1] and strlower(text[i+1]) or ""
			local char_after_next = text[i+2] and strlower(text[i+2]) or ""
			if next_char == "s"
			or next_char == "h"
			or prev_char == "s"
			-- Don't swear. Is naughty. ¬.¬
			or (next_char == "i" and char_after_next == "t") then
				-- This is an attempt at making the loop a little faster.
				-- The whole if statement won't be executed if it fails before the end.
			else
				if random(10) <= 4 then
					text[i] = text[i].."h"
				end
			end
		end
	end
	
	text = table.concat(text, "")
	
	if random(3) == 1 then
		text = text .. " ...hic!"
	end
	
	return text
end

local SendChatMessage_Old = SendChatMessage

function SendChatMessage(text, chatType, ...)
	if addon.db.Enabled then
		if chatType == "BATTLEGROUND" and addon.db.Battleground
		or chatType == "GUILD" and addon.db.Guild
		or chatType == "PARTY" and addon.db.Party
		or chatType == "RAID" and addon.db.Raid
		or chatType == "SAY" and addon.db.Say
		or chatType == "WHISPER" and addon.db.Whisper
		or chatType == "YELL" and addon.db.Yell then
			text = BrewSpeakFilter(text)
		end
	end
	
	SendChatMessage_Old(text, chatType, ...)
end

local DBDefaults = {
	Enabled = true,
	Battleground = true,
	Guild = true,
	Officer = true,
	Party = true,
	Raid = true,
	Say = true,
	Whisper = true,
	Yell = true,
}

function addon:SetDBDefaults()
	BrewSpeak_DB = BrewSpeak_DB or {}
	self.db = BrewSpeak_DB
	
	for k,v in pairs(DBDefaults) do
		if self.db[k] == nil then 
			self.db[k] = DBDefaults[k] 
		end
	end
end

function addon:Enable()
	self:SetDBDefaults()	
	addon.Config:Initialize()
end

SLASH_BREWSPEAK1 = "/bspeak"
SLASH_BREWSPEAK2 = "/brewspeak"

function SlashCmdList.BREWSPEAK(msg)
	local arg1 = strsplit(" ", strlower(msg))
	if arg1 == "on" or arg1 == "enable" or arg1 == "enabled" then
		addon.db.Enabled = true
		print("|cFF99CCFFBrewSpeak is now |cFF00FF00Enabled")
	elseif arg1 == "off" or arg1 == "disable" or arg1 == "disabled" then
		addon.db.Enabled = false
		print("|cFF99CCFFBrewSpeak is now |cFFFF0000Disabled")
	else
		print("|cFF99CCFFBrewSpeak is currently", addon.db.Enabled and "|cFF00FF00Enabled" or "|cFFFF0000Disabled")
		print("|cFF99CCFFSyntax: /bspeak (|cFF00FF00on|cFF99CCFF|||cFFFF0000off|cFF99CCFF)")
	end
end