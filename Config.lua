local addonName = ...
local addon = _G[addonName]

addon.Config = {}

function addon.Config:OnShow(...)
	_G["BrewSpeakConfigFrameBattleground"]:SetChecked(addon.db.Battleground)
	_G["BrewSpeakConfigFrameGuild"]:SetChecked(addon.db.Guild)
	_G["BrewSpeakConfigFrameOfficer"]:SetChecked(addon.db.Officer)
	_G["BrewSpeakConfigFrameParty"]:SetChecked(addon.db.Party)
	_G["BrewSpeakConfigFrameRaid"]:SetChecked(addon.db.Raid)
	_G["BrewSpeakConfigFrameSay"]:SetChecked(addon.db.Say)
	_G["BrewSpeakConfigFrameWhisper"]:SetChecked(addon.db.Whisper)
	_G["BrewSpeakConfigFrameYell"]:SetChecked(addon.db.Yell)
end

function addon.Config:OnOkay()
	addon.db.Battleground = _G["BrewSpeakConfigFrameBattleground"]:GetChecked() and true or false
	addon.db.Guild = _G["BrewSpeakConfigFrameGuild"]:GetChecked() and true or false
	addon.db.Officer = _G["BrewSpeakConfigFrameOfficer"]:GetChecked() and true or false
	addon.db.Party = _G["BrewSpeakConfigFrameParty"]:GetChecked() and true or false
	addon.db.Raid = _G["BrewSpeakConfigFrameRaid"]:GetChecked() and true or false
	addon.db.Say = _G["BrewSpeakConfigFrameSay"]:GetChecked() and true or false
	addon.db.Whisper = _G["BrewSpeakConfigFrameWhisper"]:GetChecked() and true or false
	addon.db.Yell = _G["BrewSpeakConfigFrameYell"]:GetChecked() and true or false
end

function addon.Config:Initialize(...)
	BrewSpeakConfigFrame = BrewSpeakConfigFrame
	
	BrewSpeakConfigFrame.name = "BrewSpeak";
	BrewSpeakConfigFrame.okay = self.OnOkay
	BrewSpeakConfigFrame.refresh = self.OnShow;
	InterfaceOptions_AddCategory(BrewSpeakConfigFrame);
	
	_G["BrewSpeakConfigFrameBattlegroundText"]:SetText("Battleground Chat")
	_G["BrewSpeakConfigFrameGuildText"]:SetText("Guild Chat")
	_G["BrewSpeakConfigFrameOfficerText"]:SetText("Officer Chat")
	_G["BrewSpeakConfigFramePartyText"]:SetText("Party Chat")
	_G["BrewSpeakConfigFrameRaidText"]:SetText("Raid Chat")
	_G["BrewSpeakConfigFrameSayText"]:SetText("Say")
	_G["BrewSpeakConfigFrameWhisperText"]:SetText("Private Chat")
	_G["BrewSpeakConfigFrameYellText"]:SetText("Yell")
end