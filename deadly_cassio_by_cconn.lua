--[[
 ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄   ▄       ▄         ▄       ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ 
▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░▌     ▐░▌       ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌     ▐░▌       ▐░▌     ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀  ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌
▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌     ▐░▌       ▐░▌     ▐░▌          ▐░▌       ▐░▌▐░▌          ▐░▌               ▐░▌     ▐░▌       ▐░▌
▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░▌     ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌          ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄      ▐░▌     ▐░▌       ▐░▌
▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌     ▐░░░░░░░░░░░▌     ▐░▌          ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░▌     ▐░▌       ▐░▌
▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░▌      ▀▀▀▀█░█▀▀▀▀      ▐░▌          ▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌     ▐░▌     ▐░▌       ▐░▌
▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌          ▐░▌          ▐░▌       ▐░▌          ▐░▌          ▐░▌     ▐░▌     ▐░▌       ▐░▌
▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌          ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌ ▄▄▄▄▄▄▄▄▄█░▌ ▄▄▄▄▄▄▄▄▄█░▌ ▄▄▄▄█░█▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌
▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░▌          ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
 ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀  ▀            ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 
                                                                                                                                                            
 ▄▄▄▄▄▄▄▄▄▄   ▄         ▄       ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄  ▄▄        ▄                                                             
▐░░░░░░░░░░▌ ▐░▌       ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌▐░░▌      ▐░▌                                                            
▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌     ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░▌░▌     ▐░▌▐░▌░▌     ▐░▌                                                            
▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌          ▐░▌          ▐░▌       ▐░▌▐░▌▐░▌    ▐░▌▐░▌▐░▌    ▐░▌                                                            
▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌     ▐░▌          ▐░▌          ▐░▌       ▐░▌▐░▌ ▐░▌   ▐░▌▐░▌ ▐░▌   ▐░▌                                                            
▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌     ▐░▌          ▐░▌          ▐░▌       ▐░▌▐░▌  ▐░▌  ▐░▌▐░▌  ▐░▌  ▐░▌                                                            
▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀      ▐░▌          ▐░▌          ▐░▌       ▐░▌▐░▌   ▐░▌ ▐░▌▐░▌   ▐░▌ ▐░▌                                                            
▐░▌       ▐░▌     ▐░▌          ▐░▌          ▐░▌          ▐░▌       ▐░▌▐░▌    ▐░▌▐░▌▐░▌    ▐░▌▐░▌                                                            
▐░█▄▄▄▄▄▄▄█░▌     ▐░▌          ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░▌     ▐░▐░▌▐░▌     ▐░▐░▌                                                            
▐░░░░░░░░░░▌      ▐░▌          ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌      ▐░░▌▐░▌      ▐░░▌                                                            
 ▀▀▀▀▀▀▀▀▀▀        ▀            ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀  ▀        ▀▀                                                             
                                                                                                                                                            
 ▄               ▄   ▄▄▄▄         ▄▄▄▄▄▄▄▄▄▄▄                                                                                                               
▐░▌             ▐░▌▄█░░░░▌       ▐░░░░░░░░░░░▌                                                                                                              
 ▐░▌           ▐░▌▐░░▌▐░░▌       ▐░█▀▀▀▀▀▀▀█░▌                                                                                                              
  ▐░▌         ▐░▌  ▀▀ ▐░░▌       ▐░▌       ▐░▌                                                                                                              
   ▐░▌       ▐░▌      ▐░░▌       ▐░█▄▄▄▄▄▄▄█░▌                                                                                                              
    ▐░▌     ▐░▌       ▐░░▌       ▐░░░░░░░░░░░▌                                                                                                              
     ▐░▌   ▐░▌        ▐░░▌        ▀▀▀▀▀▀▀▀▀█░▌                                                                                                              
      ▐░▌ ▐░▌         ▐░░▌                 ▐░▌                                                                                                              
       ▐░▐░▌      ▄▄▄▄█░░█▄▄▄  ▄  ▄▄▄▄▄▄▄▄▄█░▌                                                                                                              
        ▐░▌      ▐░░░░░░░░░░░▌▐░▌▐░░░░░░░░░░░▌                                                                                                              
         ▀        ▀▀▀▀▀▀▀▀▀▀▀  ▀  ▀▀▀▀▀▀▀▀▀▀▀                                                                                                               
                                                                                                                                                            
                                                                                                                                                         
		Follow me on Facebook! I post info on all new scripts and updates there
		CCONN's Facebook: https://www.facebook.com/CCONN81
		
		Feel like you have too much money? Give me some :) haha
		CCONN's DONATE LINK: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=JTWL7DK86V56S
		
		Like the script? +Rep my profile. My signature has a list of all my released scripts and current projects
		CCONN's Leaguebot Profile: http://leaguebot.net/forum/Upload/member.php?action=profile&uid=814
]]


require 'Utils'
require 'spell_damage'
require 'uiconfig'
require 'winapi'
require 'SKeys'

----------[[Deadly Cassio Variables]]
local target
local target2
local targetHero
local targetignite
local range = myHero.range + GetDistance(GetMinBBox(myHero))
local FLEEING = 0
local CHASING = 1
local STATIONARY = 2
local qTimer = os.time()
local wTimer = os.time()
local uiconfig = require 'uiconfig'
local HavocDamage = 0
local ExecutionerDamage = 0
local True_Attack_Damage_Against_Minions = 0
local Range = myHero.range + GetDistance(GetMinBBox(myHero))
local UltPOS
local SORT_CUSTOM = function(a, b) return a.maxHealth and b.maxHealth and a.maxHealth < b.maxHealth end
----------[[End of Deadly Cassio Variables]]

----------[[Farming Variables]]
local Target, M_Target
local TEAM
if myHero.team == 100 then
	TEAM = "Blue"
else
	TEAM = "Red"
end
local Cassio = { projSpeed = 1.22, aaParticles = {"CassBasicAttack_mis"}, aaSpellName = { "cassiopeiabasicattack" }, startAttackSpeed = "0.644" }
local MinionInfo = { }
MinionInfo[TEAM.."_Minion_Basic"] 		= 	{ aaDelay = 400, projSpeed = 0		}
MinionInfo[TEAM.."_Minion_Caster"] 		=	{ aaDelay = 484, projSpeed = 0.68	}
MinionInfo[TEAM.."_Minion_Wizard"]		=	{ aaDelay = 484, projSpeed = 0.68	}
MinionInfo[TEAM.."_Minion_MechCannon"] 	=	{ aaDelay = 365, projSpeed = 1.18	}
local Minions = { }
local aaDelay = 320
local aaPos = {x = 0, z = 0}
local Ping = 60
local IncomingDamage = { }
local AnimationBeginTimer = 0
local AnimationSpeedTimer = 0.1 * (1 / myHero.attackspeed)
local TimeToAA = os.clock()
----------[[End of Farming Variables]]

----------[[Red Elixer Variables]]
local wUsedAt = 0
local vUsedAt = 0
local mUsedAt = 0
local timer = os.clock()
local bluePill = nil
----------[[End of Red Elixir Variables]]

----------[[IGERs Auto Level Variables]]
local send = require 'SendInputScheduled'

local version = "1.2.2"
local Q,W,E,R = 'Q','W','E','R'
local metakey = SKeys.Control
local attempts = 0
local lastAttempt = 0
----------[[End of IGERs Auto Level Variables]]

----------[[Auto Dodge Skillshot Variables]]
local version = '1.0'
local cc = 0
local skillshotArray = {}
local colorcyan = 0x0000FFFF
local coloryellow = 0xFFFFFF00
local colorgreen = 0xFF00FF00
local skillshotcharexist = false
local show_allies=0
----------[[End of Auto Dodge Skillshot Variables]]

----------[[Roam Helper Variables]]
local Enemies = {}
local EnemyIndex = 1
----------[[End of Roam Helper Variables]]

----------[[Script Config Menu]]
CfgControls, menu = uiconfig.add_menu('1. Cassio Controls', 200)
menu.keydown('Combo', 'Combo', Keys.Space)
menu.keytoggle('ComboR', 'R in Combo', Keys.Z, false)
menu.keydown('Harass', 'Harass', Keys.X)
menu.keydown('PassiveFarm', 'Farm', Keys.C)
menu.keydown('PushLane', 'Lane Clear', Keys.V)
menu.keydown('Cast_Ult', 'Cast Ultimate', Keys.A)
menu.label('lbl7', ' ')																				
menu.label('lbl8', 'MEC Ultimate Options')															
menu.checkbutton('useAutoMECR', 'use Auto MEC R', true)
menu.slider('valMECR', 'Minimum MEC Value', 1, 5, 3, {1,2,3,4,5})
	menu.permashow('Combo')
	menu.permashow('ComboR')
	menu.permashow('Harass')
	menu.permashow('PassiveFarm')
	menu.permashow('PushLane')
	menu.permashow('Cast_Ult')
	menu.permashow('useAutoMECR')
	menu.permashow('valMECR')

CfgSettings, menu = uiconfig.add_menu('2. Cassio Settings', 200)
menu.checkbutton('Auto_Q_ONOFF', 'Auto Q', true)
menu.checkbutton('Auto_W_ONOFF', 'Auto W', true)
menu.checkbutton('Auto_E_ONOFF', 'Auto E', true)
menu.checkbutton('Auto_Harass_ONOFF', 'Auto Harass', true)
menu.checkbutton('Auto_Ult_ONOFF', 'Auto Ultimate', true)
menu.checkbutton('Low_HP_Ult_ONOFF', 'Low HP Auto Ult', true)
menu.checkbutton('DMG_Predict_Farm_ONOFF', 'Use Damage Prediction Farming', true)
menu.checkbutton('Lane_Clear_With_W', 'Lane Clear with Miasma', true)
menu.checkbutton('Auto_Kill_Steal_ONOFF', 'Kill Steal', true)
menu.checkbutton('AutoLevelSpells_ONOFF', 'Auto Level Spells', true)
menu.checkbutton('drawskillshot', 'Draw Skillshots', true)
menu.checkbutton('dodgeskillshot', 'Dodge Skillshots', true)
menu.checkbutton('RoamHelper_ONOFF', 'Roam Helper', true)
menu.checkbutton('Combo_Circles_ONOFF', 'Combo Circles', true)
menu.checkbutton('Draw_ONOFF', 'Range Circles', true)
menu.checkbutton('MoveToMouse', 'Move To Mouse', true)
menu.slider('ComboType', 'Choose Combo Type', 1, 3, 1, {"W First","Q First", "CCONN"})
menu.slider('RTYPE', 'Manual R Type', 1, 2, 1, {"No Facing Detection","Facing Detection"})
menu.slider('QRNG', 'Q Range', 100, 850, 850, nil, true)
menu.slider('WRNG', 'W Range', 100, 850, 850, nil, true)
menu.slider('RRNG', 'R Range', 100, 850, 750, nil, true)
menu.slider('Auto_Harass_Value', 'Auto Harass Value', 0, 100, 50, nil, true)
menu.slider('Auto_Ult_Value', 'Auto Ultimate Value', 0, 100, 40, nil, true)
menu.slider('Low_HP_Ult_Value', 'Low HP Auto Ult Value', 0, 100, 15, nil, true)
menu.slider('SkillOrder', 'Auto Level Profile', 1, 2, 1, {"Max E","Max Q"})
	menu.permashow('Auto_Harass_ONOFF')
	menu.permashow('Auto_Ult_ONOFF')
	menu.permashow('Low_HP_Ult_ONOFF')
	
CfgMasteries, menu = uiconfig.add_menu('3. Cassio Masteries', 200)
menu.slider('Butcher_Mastery', 'Butcher', 0, 2, 2, nil, true)
menu.slider('Havoc_Mastery', 'Havoc', 0, 3, 3, nil, true)
menu.slider('Brute_Force_Mastery', 'Brute Force', 0, 2, 0, nil, true)
menu.checkbutton('Spellsword_Mastery', 'Spellsword', true)
menu.checkbutton('Executioner_Mastery', 'Executioner', true)

CfgSummonerSpells, menu = uiconfig.add_menu('4. Summoner Spells', 200)
menu.checkbutton('Auto_Summoner_Spells_ONOFF', 'Enable Auto Summoner Spells', true)
menu.checkbutton('Auto_Ignite_ONOFF', 'Ignite', true)
menu.checkbutton('Auto_Ignite_COMBO_ONOFF', 'Use Ignite in Combo', true)
menu.checkbutton('Auto_Exhaust_COMBO_ONOFF', 'Use Exhaust in Combo', true)
menu.checkbutton('Auto_Exhaust_ONOFF', 'Exhaust', true)
menu.checkbutton('Auto_Barrier_ONOFF', 'Barrier', true)
menu.checkbutton('Auto_Heal_ONOFF', 'Heal', true)
menu.checkbutton('Auto_Clarity_ONOFF', 'Clarity', true)
menu.slider('AutoHealValue', 'Auto Heal Value', 0, 100, 15, nil, true)
menu.slider('AutoBarrierValue', 'Auto Barrier Value', 0, 100, 15, nil, true)
menu.slider('AutoExhaustValue', 'Auto Exhaust Value', 0, 100, 20, nil, true)
menu.slider('AutoClarityValue', 'Auto Clarity Value', 0, 100, 40, nil, true)
menu.slider('AutoIgniteComboValue', 'Ignite Combo Value', 0, 100, 40, nil, true)
menu.slider('AutoExhaustComboValue', 'Exhaust Combo Value', 0, 100, 40, nil, true)

CfgPotions, menu = uiconfig.add_menu('5. Potions', 200)
menu.checkbutton('Red_Elixir_ONOFF', 'Master Switch: Potions', true)
menu.checkbutton('Health_Potion_ONOFF', 'Health Potions', true)
menu.checkbutton('Mana_Potion_ONOFF', 'Mana Potions', true)
menu.checkbutton('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
menu.checkbutton('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
menu.checkbutton('Biscuit_ONOFF', 'Biscuit', true)
menu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
menu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
menu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
menu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
menu.slider('Biscuit_Value', 'Biscuit Value', 0, 100, 60, nil, true)

CfgItems, menu = uiconfig.add_menu('6. Items', 200)
menu.checkbutton('Zhonyas_Hourglass_ONOFF', 'Zhonyas Hourglass', true)
menu.checkbutton('Deathfire_Grasp_ONOFF', 'Deathfire Grasp', true)
menu.checkbutton('Hextech_Gunblade_ONOFF', 'Hextech Gunblade', true)
menu.checkbutton('Twin_Shadows_ONOFF', 'Twin Shadows', true)
menu.checkbutton('Wooglets_Witchcap_ONOFF', 'Wooglets Witchcap', true)
menu.checkbutton('Shard_of_True_Ice_ONOFF', 'Shard of True Ice', true)
menu.checkbutton('Seraphs_Embrace_ONOFF', 'Seraphs Embrace', true)
menu.checkbutton('Blackfire_Torch_ONOFF', 'Blackfire Torch', true)
menu.slider('Zhonyas_Hourglass_Value', 'Zhonya Hourglass Value', 0, 100, 15, nil, true)
menu.slider('Wooglets_Witchcap_Value', 'Wooglets Witchcap Value', 0, 100, 15, nil, true)
menu.slider('Seraphs_Embrace_Value', 'Seraphs Embrace Value', 0, 100, 15, nil, true)
----------[[End of Script Config Menu]]

----------[[Core Script Function]]
function DeadlyCassio()
	if IsChatOpen() == 0 and tostring(winapi.get_foreground_window()) == "League of Legends (TM) Client" then
		target = GetWeakEnemy('MAGIC', 850)
		targetHero = GetWeakEnemy('MAGIC', 850)
		target2 = GetWeakEnemy('MAGIC', 700)
		Mastery_Damage()
		if CfgControls.useAutoMECR then mecPetrifyingGaze(CfgControls.valMECR) end
		if CfgPotions.Red_Elixir_ONOFF then RedElixir() end
		if CfgSettings.Draw_ONOFF then Draw() end
		if CfgSummonerSpells.Auto_Summoner_Spells_ONOFF then SummonerSpells() end
		if CfgSettings.Auto_Kill_Steal_ONOFF then KillSteal() end
		if CfgControls.Combo then Combo() end
		if CfgControls.Combo then Cassio_Items() end
		if CfgControls.Harass then Harass() end
		if CfgControls.PassiveFarm and CfgSettings.DMG_Predict_Farm_ONOFF then
			Farm()
		elseif CfgControls.PassiveFarm then
			Hybrid()
		else end
		if CfgControls.PushLane then LaneClear() end
		if CfgControls.Cast_Ult then
			if CfgSettings.RTYPE == 1 then
				R_No_Facing_Detection()
			elseif CfgSettings.RTYPE == 2 then
				R()
			end
		end
		if CfgSettings.Low_HP_Ult_ONOFF then Low_HP_Ult() end
		--if CfgSettings.Auto_GetMEC_Ult_ONOFF then AutoGetMecULT() end
		if CfgControls.Cast_Ult then R() end
		if CfgSettings.Auto_Harass_ONOFF then Auto_Harass() end
	end
end
----------[[End of Core Script Function]]

----------[[Utility Functions]]
for i = 1, objManager:GetMaxHeroes(), 1 do
	Hero = objManager:GetHero(i)
	if Hero ~= nil and Hero.team ~= myHero.team then
		if Enemies[Hero.name] == nil then
			Enemies[Hero.name] = { Unit = Hero, Number = EnemyIndex }
			EnemyIndex = EnemyIndex + 1
		end
	end
end

function Draw()
	if myHero.SpellLevelQ > 0.00 and myHero.SpellTimeQ > 1.0 then CustomCircle(CfgSettings.QRNG,2,4,myHero) end
	if myHero.SpellLevelW > 0.00 and myHero.SpellTimeW > 1.0 then CustomCircle(CfgSettings.WRNG,2,4,myHero) end
	if myHero.SpellLevelE > 0.00 and myHero.SpellTimeE > 1.0 then CustomCircle(700,2,4,myHero) end
	if CfgControls.PushLane or CfgControls.PassiveFarm then CustomCircle(range,2,4,myHero) end
	if target2 ~= nil then 
		CustomCircle(100,5,2,target2)
		if GetTargetDirection() == CHASING then
			CustomCircle(125,20,2,target2)
		end
	end
	if CfgSettings.RoamHelper_ONOFF then
		for i, Enemy in pairs(Enemies) do
			if Enemy ~= nil then
				Hero = Enemy.Unit
			
				local PositionX = (13.3/16) * GetScreenX()
			
				local QDMG = getDmg('Q', Hero, myHero)+(getDmg('Q',Hero,myHero)*(HavocDamage + ExecutionerDamage))
				local WDMG = getDmg('W', Hero, myHero)+(getDmg('W',Hero,myHero)*(HavocDamage + ExecutionerDamage))
				local EDMG = getDmg('E', Hero, myHero)+(getDmg('E',Hero,myHero)*(HavocDamage + ExecutionerDamage))
				local RDMG = getDmg('R', Hero, myHero)+(getDmg('R',Hero,myHero)*(HavocDamage + ExecutionerDamage))
				local Current_Burst
				local Damage
				if myHero.selflevel >= 6 and myHero.SpellTimeR > 1.0 then
					Current_Burst = Round(QDMG + WDMG + EDMG * 3 + RDMG, 0) --Show damage of QWEEER combo if Ult is available
				else
					Current_Burst = Round(QDMG + WDMG + EDMG * 3, 0) --Show damage of QWEEE combo if Ult is not available
				end
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					Current_Burst = Current_Burst + ((myHero.selflevel*20)+50) --If Ignite detected and is not on cooldown add ignite damage to combo damage
				end

				Damage = Current_Burst
			
				DrawText("Champion: "..Hero.name, PositionX, ((15/900) * GetScreenY()) * Enemy.Number + ((53/90) * GetScreenY()), Color.SkyBlue)
			
				if Hero.visible == 1 and Hero.dead ~= 1 then
					if Damage < Hero.health then
						DrawText("DMG "..Damage, PositionX + 150, ((15/900) * GetScreenY()) * Enemy.Number + ((53/90) * GetScreenY()), Color.Yellow)
					elseif Damage > Hero.health then
						DrawText("Killable!", PositionX + 150, ((15/900) * GetScreenY()) * Enemy.Number + ((53/90) * GetScreenY()), Color.Red)
					end
				end
			
				if Hero.visible == 0 and Hero.dead ~= 1 then
					DrawText("MIA", PositionX + 150, ((15/900) * GetScreenY()) * Enemy.Number + ((53/90) * GetScreenY()), Color.Orange)
				elseif Hero.dead == 1 then
					DrawText("Dead", PositionX + 150, ((15/900) * GetScreenY()) * Enemy.Number + ((53/90) * GetScreenY()), Color.Green)
				end
			end
		end
	end
end

function Round(val, decimal)
	if (decimal) then
		return math.floor( (val * 10 ^ decimal) + 0.5) / (10 ^ decimal)
	else
		return math.floor(val + 0.5)
	end
end

function DetectPoison()
    for i = 1, objManager:GetMaxObjects(), 1 do
        obj = objManager:GetObject(i)
        if obj~=nil and target~=nil then
            if (obj.charName:lower():find("global_poison")) and GetDistance(obj, target) < 100 then
                return true
            end
        end
    end
end

function GetTargetDirection()
	local distanceTarget = GetDistance(target)
    local x1, y1, z1 = GetFireahead(target,2,10)
    local distancePredicted = GetDistance({x = x1, y = y1, z = z1})
	
	return (distanceTarget > distancePredicted and CHASING or (distanceTarget < distancePredicted and FLEEING or STATIONARY))
end

function Cassio_Items()
	local target = GetWeakEnemy('MAGIC',700)
	if target ~= nil then
		if GetDistance(myHero,target) <= 700 then
			if CfgItems.Hextech_Gunblade_ONOFF then useHextechGunblade() end
			if CfgItems.Deathfire_Grasp_ONOFF then useDeathfireGrasp() end
			if CfgItems.Twin_Shadows_ONOFF then useTwinShadows() end
			if CfgItems.Shard_of_True_Ice_ONOFF then useShardofTrueIce() end
			if CfgItems.Blackfire_Torch_ONOFF then useBlackfireTorch() end
		end
		if CfgItems.Zhonyas_Hourglass_ONOFF then
			if myHero.health < myHero.maxHealth*(CfgItems.Zhonyas_Hourglass_Value / 100) then
				useZhonyas()
			end
		end
		if CfgItems.Wooglets_Witchcap_ONOFF then
			if myHero.health < myHero.maxHealth*(CfgItems.Wooglets_Witchcap_Value / 100) then
				useWoogletsWitchcap()
			end
		end
		if CfgItems.Seraphs_Embrace_ONOFF then
			if myHero.health <= (CfgItems.Seraphs_Embrace_Value / 100) then
				useSeraphsEmbrace()
			end
		end
	end
end
function useZhonyas()
	GetInventorySlot(3157)
	UseItemOnTarget(3157,myHero)
end
function useHextechGunblade()
	if target ~= nil then
		GetInventorySlot(3146)
		UseItemOnTarget(3146,target)
	end
end
function useDeathfireGrasp()
	if target ~= nil then
		GetInventorySlot(3128)
		UseItemOnTarget(3128,target)
	end
end
function useTwinShadows()
	if target ~= nil then
		GetInventorySlot(3023)
		UseItemOnTarget(3023,target)
	end
end
function useWoogletsWitchcap()
	GetInventorySlot(3090)
	UseItemOnTarget(3090,myHero)
end
function useShardofTrueIce()
	GetInventorySlot(3092)
	UseItemOnTarget(3092,myHero)
end
function useSeraphsEmbrace()
	GetInventorySlot(3040)
	UseItemOnTarget(3040,myHero)
end
function useBlackfireTorch()
	if target ~= nil then
		GetInventorySlot(3188)
		UseItemOnTarget(3188,target)
	end
end

function Mastery_Damage()
	local Mast_ButcherDMG = 0
	local Mast_BruteForceDMG = 0
	local Mast_SpellswordDMG = 0
	if CfgMasteries.Butcher_Mastery > 0 then
		Mast_ButcherDMG = CfgMasteries.Butcher_Mastery
	end
	if CfgMasteries.Brute_Force_Mastery then
		if CfgMasteries.Brute_Force_Mastery == 1 then
			Mast_BruteForceDMG = 1.5
		end
		if CfgMasteries.Brute_Force_Mastery == 2 then
			Mast_BruteForceDMG = 3
		end
	end
	if CfgMasteries.Spellsword_Mastery then
		Mast_SpellswordDMG = myHero.ap * .05
	end
	if CfgMasteries.Havoc_Mastery then
		if CfgMasteries.Havoc_Mastery == 1 then
			HavocDamage = 0.0067
		end
		if CfgMasteries.Havoc_Mastery == 2 then
			HavocDamage = 0.0133
		end
		if CfgMasteries.Havoc_Mastery == 3 then
			HavocDamage = 0.02
		end
	end
	if CfgMasteries.Executioner_Mastery then
		ExecutionerDamage = .05
	end
	True_Attack_Damage_Against_Minions = (myHero.baseDamage + myHero.addDamage + Mast_BruteForceDMG + Mast_SpellswordDMG)+((myHero.baseDamage + myHero.addDamage + Mast_BruteForceDMG + Mast_SpellswordDMG)*(HavocDamage + ExecutionerDamage))
end
----------[[End of Utility Functions]]

----------[[Farming Functions]]

function Farm()
	Minions = GetEnemyMinions(SORT_CUSTOM)
	AnimationSpeedTimer = 0.085 * (1 / myHero.attackspeed)
	
	for i, Minion in pairs(Minions) do
		if Minion ~= nil then
			local PredictedDamage = 0
			local aaTime = Ping + aaDelay + ( GetDistance2D(myHero, Minion) / Cassio.projSpeed )
			
			for k, DMG in pairs(IncomingDamage) do
				if DMG ~= nil then
					if (DMG.Source == nil or DMG.Source.dead or DMG.Target == nil or DMG.Target.dead) or (DMG.Source.x ~= DMG.aaPos.x or DMG.Source.z ~= DMG.aaPos.z) then
						IncomingDamage[k] = nil
					elseif Minion == DMG.Target then
						DMG.aaTime = (DMG.projSpeed == 0 and (DMG.aaDelay) or (DMG.aaDelay + GetDistance2D(DMG.Source, Minion) / DMG.projSpeed))
						if GetTickCount() >= (DMG.Start + DMG.aaTime) then
							IncomingDamage[k] = nil
						elseif GetTickCount() + aaTime > (DMG.Start + DMG.aaTime) then
							PredictedDamage = PredictedDamage + DMG.Damage
						end
					end
				end
			end
				
			if Minion.dead == 0 and Minion.health - PredictedDamage <= True_Attack_Damage_Against_Minions and Minion.health - PredictedDamage > 0 and GetDistance(Minion, myHero) < Range then
				if os.clock() > TimeToAA then AttackTarget(Minion)
				CustomCircle(100, 1, 2, Minion)
--[[				elseif target ~= nil then
					Harass()]]
				end
			end
		end
	end
	if os.clock() > (AnimationBeginTimer + AnimationSpeedTimer) then MoveToMouse() end
end

function OnProcessSpell(unit, spell)
	if unit ~= nil and GetDistance(myHero, unit) < 1000 then
		for i, Minion in pairs(Minions) do
			if Minion ~= nil then
				if MinionInfo[unit.charName] ~= nil then
					local m_aaDelay = MinionInfo[unit.charName].aaDelay
					local m_projSpeed = MinionInfo[unit.charName].projSpeed
					
					if spell.target == Minion then
						IncomingDamage[unit.name] = { Source = unit, Target = Minion, Damage = getDmg("AD", Minion, unit), Start = GetTickCount(), aaPos = { x = unit.x, z = unit.z }, aaDelay = m_aaDelay, projSpeed = m_projSpeed }
					end
				end
			end
		end
	end
	if unit.charName == myHero.charName then
		for i, aaSpellName in pairs(Cassio.aaSpellName) do
			if spell.name == aaSpellName then
				AnimationBeginTimer = os.clock()
				TimeToAA = os.clock() + (1 / myHero.attackspeed) - 0.35 * (1 / myHero.attackspeed)
			end
		end
	end
end

function GetDistance2D(o1, o2)
   local c = "z"
   if o1.z == nil or o2.z == nil then c = "y" end
   return math.sqrt(math.pow(o1.x - o2.x, 2) + math.pow(o1[c] - o2[c], 2))
end

function Hybrid()		-----> Hybrid function changed to prioritze last hits over champions
    targetHero = GetWeakEnemy("MAGIC",850)
	tlow = GetLowestHealthEnemyMinion(range)
    
	if tlow ~= nil and tlow.health <= True_Attack_Damage_Against_Minions then
		target = tlow
	elseif targetHero ~= nil then
        target = targetHero
		Harass()
    else 
        target = GetLowestHealthEnemyMinion(range) 
    end
        
    if target ~= nil then
        if True_Attack_Damage_Against_Minions >= target.health then
            AttackTarget(target)
--[[		else 
			if CfgSettings.FarmWithE then
				getDmg('E',target,myHero)*(HavocDamage + ExecutionerDamage) >= target.health then
				if os.time() < qTimer + 3 or os.time() < wTimer + 2 then
					E()
				end
			end]]
		end
    else
        if CfgSettings.MoveToMouse then MoveToMouse() end
    end
	if CfgSettings.MoveToMouse then MoveToMouse() end
end
	
function LaneClear()
    local tlow=GetLowestHealthEnemyMinion(range) 
    local thigh=GetHighestHealthEnemyMinion(range)
	targetHero = GetWeakEnemy("MAGIC",range)

    if target2 ~= nil  and target2.visible == 1 and target2.dead == 0 then 
        target = target2 
    end

    if tlow~= nil then 
		if True_Attack_Damage_Against_Minions >= tlow.health then
			target = tlow
			CustomCircle(100,20,1,target)
		elseif getDmg("E",tlow,myHero)+(getDmg("E",tlow,myHero)*(HavocDamage + ExecutionerDamage)) >= tlow.health then
			target = tlow
			CustomCircle(100,20,1,target)			
		elseif targetHero ~= nil then
			target = targetHero
		elseif thigh ~= nil then
			target = thigh
			CustomCircle(110,10,5,target)
		else end
	end

    if target ~= nil and target.visible == 1 and target.dead == 0 then 
        if True_Attack_Damage_Against_Minions >= target.health then
				AttackTarget(target)
		elseif
			getDmg("E",target,myHero)+(getDmg("E",target,myHero)*(HavocDamage + ExecutionerDamage)) >= target.health and DetectPoison() then
					E()
		else
		CastHotkey('AUTO 100,0 ATTACK:WEAKMINION PATROLSTRAFE')
			if CfgSettings.Lane_Clear_With_W then
				if target == thigh then
					local WPos = GetMEC(175, 850, target)
					if WPos then
						CastSpellXYZ("W", WPos.x, 0, WPos.z)
						wTimer = os.time()
					else
						CastSpellXYZ("W",GetFireahead(target,2.65,25))
						wTimer = os.time()
					end
				end
			end
			local QPos = GetMEC(75, 850, target)
			if QPos then
				CastSpellXYZ("Q", QPos.x, 0, QPos.z)
				qTimer = os.time()
			else
				CastSpellXYZ("Q",GetFireahead(target,6,0))
				qTimer = os.time()
			end
		end
		--Action()
    else
    if CfgSettings.MoveToMouse then MoveToMouse() end
    end
	if CfgSettings.MoveToMouse then MoveToMouse() end
end
----------[[End of Farming Functions]]

----------[[Combo Functions]]
function Combo()
	if CfgSettings.ComboType == 1 then
		if target ~= nil then
			if GetDistance(target) < 850 then
				if CfgSettings.Auto_W_ONOFF then W() end
				if CfgSettings.Auto_Q_ONOFF then Q() end
				if CfgControls.ComboR then R() end
			end
			if GetDistance(target) <= 700 then
				if CfgSettings.Auto_E_ONOFF then E() end
			end
			if GetDistance(target) <= 600 then
				if CfgSummonerSpells.Auto_Ignite_COMBO_ONOFF then SummonerIgniteCombo() end
				if CfgSummonerSpells.Auto_Exhaust_COMBO_ONOFF then SummonerExhaustCombo() end
			end
			--[[if CfgSettings.AutoCarry_ONOFF and myHero.SpellTimeE < 1.0 and myHero.SpellTimeQ < 1.0 and GetDistance(myHero, target) <= range then
				AutoCarry()
			end]]
			if CfgSettings.MoveToMouse then MoveToMouse() end
		else 
			if CfgSettings.MoveToMouse then MoveToMouse() end
		end
	end
	if CfgSettings.ComboType == 2 then
		if target ~= nil then
			if GetDistance(target) < 850 then
				if CfgSettings.Auto_Q_ONOFF then Q() end
				if CfgSettings.Auto_W_ONOFF then W() end
				if CfgControls.ComboR then R() end
			end
			if GetDistance(target) <= 700 then
				if CfgSettings.Auto_E_ONOFF then E() end
			end
			if GetDistance(target) <= 600 then
				if CfgSummonerSpells.Auto_Ignite_COMBO_ONOFF then SummonerIgniteCombo() end
				if CfgSummonerSpells.Auto_Exhaust_COMBO_ONOFF then SummonerExhaustCombo() end
			end
			--[[if CfgSettings.AutoCarry_ONOFF and myHero.SpellTimeE < 1.0 and myHero.SpellTimeQ < 1.0 and GetDistance(myHero, target) <= range then
				AutoCarry()
			end]]
			if CfgSettings.MoveToMouse then MoveToMouse() end
		else 
			if CfgSettings.MoveToMouse then MoveToMouse() end
		end
	end
	if CfgSettings.ComboType == 3 then
		if target ~= nil then
			if DetectPoison() and myHero.SpellTimeE > 1.0 and GetDistance(myHero, target) <= 700 then
				E()
			elseif not DetectPoison() and myHero.SpellTimeW > 1.0 and GetDistance(myHero, target) <= 850 then
				W()
			elseif not DetectPoison() and myHero.SpellTimeQ > 1.0 and GetDistance(myHero, target) <= 850 then
				Q()
			elseif CfgControls.ComboR and myHero.SpellTimeR > 1.0 and GetDistance(myHero, target) <= 700 then
				R()
			end
			if GetDistance(target) <= 600 then
				if CfgSummonerSpells.Auto_Ignite_COMBO_ONOFF then SummonerIgniteCombo() end
				if CfgSummonerSpells.Auto_Exhaust_COMBO_ONOFF then SummonerExhaustCombo() end
			end
			--[[if CfgSettings.AutoCarry_ONOFF and myHero.SpellTimeE < 1.0 and myHero.SpellTimeQ < 1.0 and GetDistance(myHero, target) <= range then
				AutoCarry()
			end]]
			if CfgSettings.MoveToMouse then MoveToMouse() end
		else 
			if CfgSettings.MoveToMouse then MoveToMouse() end
		end
	end
end

function Harass()
	if CfgSettings.ComboType == 1 then
		if target ~= nil then
			if GetDistance(target) < 850 then
				if CfgSettings.Auto_W_ONOFF then W() end
				if CfgSettings.Auto_Q_ONOFF then Q() end
			end
			if GetDistance(target) <= 700 then
				if CfgSettings.Auto_E_ONOFF then E() end
			end
			if CfgSettings.MoveToMouse then MoveToMouse() end
		else 
			if CfgSettings.MoveToMouse then MoveToMouse() end
		end
	end
	if CfgSettings.ComboType == 2 then
		if target ~= nil then
			if GetDistance(target) < 850 then
				if CfgSettings.Auto_Q_ONOFF then Q() end
				if CfgSettings.Auto_W_ONOFF then W() end
			end
			if GetDistance(target) <= 700 then
				if CfgSettings.Auto_E_ONOFF then E() end
			end
			if CfgSettings.MoveToMouse then MoveToMouse() end
		else 
			if CfgSettings.MoveToMouse then MoveToMouse() end
		end
	end
end
----------[[End of Combo Functions]]

----------[[Spell Functions]]
function Q()
	if target ~= nil then
		if GetDistance(myHero, target) <= CfgSettings.QRNG and myHero.SpellTimeQ > 1.0 then
				CastSpellXYZ("Q",GetFireahead(target,6,0))
				qTimer = os.time()
		end
	end
end

function W()
	if target ~= nil then
		if GetDistance(myHero, target) <= CfgSettings.WRNG and myHero.SpellTimeW > 1.0 then
			CastSpellXYZ("W",GetFireahead(target,2.65,42))  --2.65,45 need to test
			wTimer = os.time()
		end
	end
end

function E()
	if target ~= nil then
		if DetectPoison() then
			if CfgSettings.Auto_Q_ONOFF and CfgSettings.Auto_W_ONOFF then
				--if os.time() < qTimer + 3 or os.time() < wTimer + 2 then
					if GetDistance(target) <= 700 then
						CastSpellTarget("E",target)
					end
				--end
			else
				if GetDistance(target) <= 700 then
					CastSpellTarget("E",target)
				end
			end
		end
	end
end

function R()
	if target2 ~= nil and myHero.selflevel >= 6 then
		if myHero.SpellTimeR > 1.0 and myHero.mana >= 80 + (myHero.SpellLevelR * 40) then
			if GetDistance(myHero, target2) <= CfgSettings.RRNG and GetTargetDirection(target2) == CHASING then
				ultPos = GetMEC(230, 800, target2)
				if ultPos then
					CastSpellXYZ("R", ultPos.x, 0, ultPos.z)
				else
					CastSpellXYZ("R",GetFireahead(target2,2,10))
				end
			end
		end
	end
end

function R_No_Facing_Detection()
	if target2 ~= nil and myHero.selflevel >= 6 then
		if myHero.SpellTimeR > 1.0 and myHero.mana >= 80 + (myHero.SpellLevelR * 40) then
			if GetDistance(myHero, target2) <= CfgSettings.RRNG then
				ultPos = GetMEC(230, CfgSettings.RRNG, target2)
				if ultPos then
					CastSpellXYZ("R", ultPos.x, 0, ultPos.z)
				else
					CastSpellXYZ("R",GetFireahead(target2,2,10))
				end
			end
		end
	end
end

function AutoR()
	if target2 ~= nil and target2.health < (target2.maxHealth*(CfgSettings.Auto_Ult_Value / 100)) then
		if CfgSettings.Auto_Ult_ONOFF then
			if myHero.selflevel >= 6 then
				if myHero.SpellTimeR > 1.0 and myHero.mana >= 100 then
					if GetDistance(target2) <= CfgSettings.RRNG and GetTargetDirection(target2) == CHASING then
						ultPos = GetMEC(230, CfgSettings.RRNG, target2)
						if ultPos then
							CastSpellXYZ("R", ultPos.x, 0, ultPos.z)
						else
							CastSpellXYZ("R",GetFireahead(target2,2,10))
						end
					end
				end
			end
		end
	end
end

function Auto_Harass()
	if targetHero ~= nil then
		if myHero.mana >= myHero.maxMana*(CfgSettings.Auto_Harass_Value / 100) then
			if CfgSettings.Auto_Q_ONOFF then
				if GetDistance(myHero, targetHero) <= CfgSettings.QRNG then
					CastSpellXYZ("Q",GetFireahead(targetHero,6,0))
					qTimer = os.time()
				end
			end
			if GetDistance(targetHero) <= 700 then
				if DetectPoison() then
					if CfgSettings.Auto_Q_ONOFF and CfgSettings.Auto_W_ONOFF then
						if os.time() < qTimer + 3 or os.time() < wTimer + 2 then
							if GetDistance(target) <= 700 then
								CastSpellTarget("E",target)
							end
						end
					else
						if GetDistance(target) <= 700 then
							CastSpellTarget("E",target)
						end
					end
				end
			end
		end
	end
end

function Low_HP_Ult()
	if target2 ~= nil and GetDistance(myHero,target) <= 400 then
		if myHero.selflevel >= 6 then
			if myHero.health < myHero.maxHealth*(CfgSettings.Low_HP_Ult_Value / 100) then
				if myHero.SpellTimeR > 1.0 and myHero.mana >= 80 + (myHero.SpellLevelR * 40) then
					if GetDistance(target2) <= CfgSettings.RRNG and GetTargetDirection(target2) == CHASING then
						ultPos = GetMEC(230, CfgSettings.RRNG, target2)
						if ultPos then
							CastSpellXYZ("R", ultPos.x, 0, ultPos.z)
						else
							CastSpellXYZ("R",GetFireahead(target2,2,10))
						end
					end
				end
			end
		end
	end
end

function mecPetrifyingGaze(Value)
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			ultPos = GetMEC(230, CfgSettings.RRNG, enemy)
			if ultPos and GetDistance(ultPos) < CfgSettings.RRNG and CountUnit(ultPos,230) >= Value then
				if  myHero.SpellLevelR >= 1 and myHero.SpellTimeR > 1.0 and myHero.mana >= 100 then
					CastSpellXYZ('R', ultPos.x, 0, ultPos.z)
				end
			end
		end
	end
end

----------[[End of Spell Functions]]

----------[[Summoner Spell Functions]]
function SummonerSpells()
	if CfgSummonerSpells.Auto_Ignite_ONOFF then SummonerIgnite() end
	if CfgSummonerSpells.Auto_Barrier_ONOFF then SummonerBarrier() end
	if CfgSummonerSpells.Auto_Heal_ONOFF then SummonerHeal() end
	if CfgSummonerSpells.Auto_Exhaust_ONOFF then SummonerExhaust() end
	if CfgSummonerSpells.Auto_Clarity_ONOFF then SummonerClarity() end
end

function SummonerIgniteCombo()
	if target ~= nil then
		if myHero.SummonerD == 'SummonerDot' then
			if target.health <= target.maxHealth*(CfgSummonerSpells.AutoIgniteComboValue / 100) then
				CastSpellTarget('D',target)
			end
		end
		if myHero.SummonerF == 'SummonerDot' then
			if target.health <= target.maxHealth*(CfgSummonerSpells.AutoIgniteComboValue / 100) then
				CastSpellTarget('F',target)
			end
		end
	end
end

function SummonerIgnite()
	targetignite = GetWeakEnemy("TRUE",600)
	local damage = (myHero.selflevel*20)+50
	if targetignite ~= nil then
		if myHero.SummonerD == 'SummonerDot' then
			if targetignite.health < damage then
				CastSpellTarget('D',targetignite)
			end
		end
		if myHero.SummonerF == 'SummonerDot' then
			if targetignite.health < damage then
				CastSpellTarget('F',targetignite)
			end
		end
	end
end

function SummonerBarrier()
		if myHero.SummonerD == 'SummonerBarrier' then
			if myHero.health < myHero.maxHealth*(CfgSummonerSpells.AutoBarrierValue / 100) then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerBarrier' then
			if myHero.health < myHero.maxHealth*(CfgSummonerSpells.AutoBarrierValue / 100) then
				CastSpellTarget('F',myHero)
			end
		end
end

function SummonerHeal()
		if myHero.SummonerD == 'SummonerHeal' then
			if myHero.health < myHero.maxHealth*(CfgSummonerSpells.AutoHealValue / 100) then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerHeal' then
			if myHero.health < myHero.maxHealth*(CfgSummonerSpells.AutoHealValue / 100) then
				CastSpellTarget('F',myHero)
			end
		end
end

function SummonerExhaustCombo()
	if target ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if target.health <= target.maxHealth*(CfgSummonerSpells.AutoExhaustComboValue / 100) then
				CastSpellTarget('D',target)
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if target.health <= target.maxHealth*(CfgSummonerSpells.AutoExhaustComboValue / 100) then
				CastSpellTarget('F',target)
			end
		end
	end
end

function SummonerExhaust()
	if target ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*(CfgSummonerSpells.AutoExhaustValue / 100) then
				if myHero.health < target.health then
					CastSpellTarget('D',target)
				end
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*(CfgSummonerSpells.AutoExhaustValue / 100) then
				if myHero.health < target.health then
					CastSpellTarget('F',target)
				end
			end
		end
	end
end

function SummonerClarity()
		if myHero.SummonerD == 'SummonerMana' then
			if myHero.mana < myHero.maxMana*(CfgSummonerSpells.AutoClarityValue / 100) then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerMana' then
			if myHero.mana < myHero.maxMana*(CfgSummonerSpells.AutoClarityValue / 100) then
				CastSpellTarget('F',myHero)
			end
		end
end
----------[[End of Summoner Spell Functions]]

----------[[Kill Steal Functions]]
function KillSteal()
    for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable==0 and enemy.dead == 0) then
    		local qdmg = getDmg("Q",enemy,myHero)
			local wdmg = getDmg("W",enemy,myHero)
    		local edmg = getDmg("E",enemy,myHero)
			local rdmg = getDmg("R",enemy,myHero)
			local ignitedmg = (myHero.selflevel*20)+50
			if CfgSettings.Combo_Circles_ONOFF then
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					if qdmg+wdmg+edmg*3+ignitedmg > enemy.health then CustomCircle(50,10,5,enemy) DrawTextObject("ComboKill!", enemy, Color.Red) end
				end
				if myHero.SpellTimeR > 1.0 then
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						if rdmg+qdmg+wdmg+edmg*3+ignitedmg > enemy.health then CustomCircle(50,10,5,enemy) DrawTextObject("ComboKill!", enemy, Color.Red) end
					end
				end
				if myHero.SpellTimeR > 1.0 then
					if rdmg+qdmg+wdmg+edmg*3 > enemy.health then CustomCircle(50,10,5,enemy) DrawTextObject("ComboKill!", enemy, Color.Red) end
				end
			end
        	if CfgSettings.Auto_Kill_Steal_ONOFF then
        		if qdmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) < 850 then
        		    CastSpellXYZ("Q",GetFireahead(enemy,6,0))
				end
				if wdmg > enemy.health and myHero.SpellTimeW > 1.0 and GetDistance(myHero,enemy) < 850 then
        		    CastSpellXYZ("W",GetFireahead(enemy,2.65,25))
				end
				if edmg > enemy.health and GetDistance(enemy) < 700 then
        		    CastSpellTarget("E",enemy)
        		end
				if qdmg + wdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 and GetDistance(myHero,enemy) <= 850 then
					CastSpellXYZ("Q",GetFireahead(enemy,6,0))
					CastSpellXYZ("W",GetFireahead(enemy,2.65,25))
				end
			end
		end
	end
end
----------[[End of Kill Steal Functions]]

----------[[Integrated RED ELIXIR]]
function RedElixir()
	if bluePill == nil then
		if myHero.health < myHero.maxHealth * (CfgPotions.Health_Potion_Value / 100) and GetClock() > wUsedAt + 15000 then
			usePotion()
			wUsedAt = GetTick()
		elseif myHero.health < myHero.maxHealth * (CfgPotions.Chrystalline_Flask_Value / 100) and GetClock() > vUsedAt + 10000 then 
			useFlask()
			vUsedAt = GetTick()
		elseif myHero.health < myHero.maxHealth * (CfgPotions.Biscuit_Value / 100) then
			useBiscuit()
		elseif myHero.health < myHero.maxHealth * (CfgPotions.Elixir_of_Fortitude_Value / 100) then
			useElixir()
		end
		if myHero.mana < myHero.maxMana * (CfgPotions.Mana_Potion_Value / 100) and GetClock() > mUsedAt + 15000 then
			useManaPot()
			mUsedAt = GetTick()
		end
	end
	if (os.clock() < timer + 5000) then
		bluePill = nil 
	end
end
function OnCreateObj(object)
	if (GetDistance(myHero, object)) < 100 then
		if string.find(object.charName,"FountainHeal") then
			timer=os.clock()
			bluePill = object
		end
	end
end
function usePotion()
	GetInventorySlot(2003)
	UseItemOnTarget(2003,myHero)
end
function useFlask()
	GetInventorySlot(2041)
	UseItemOnTarget(2041,myHero)
end
function useBiscuit()
	GetInventorySlot(2009)
	UseItemOnTarget(2009,myHero)
end
function useElixir()
	GetInventorySlot(2037)
	UseItemOnTarget(2037,myHero)
end
function useManaPot()
	GetInventorySlot(2004)
	UseItemOnTarget(2004,myHero)
end
function GetTick()
	return GetClock()
end
----------[[End of Integrated Red Elixir]]

----------[[IGERs Auto Level]]
local skillingOrder = {
    MaxE = {Q,E,E,W,E,R,Q,E,W,E,R,Q,Q,W,Q,R,W,W},
    MaxQ = {Q,E,Q,W,Q,R,Q,E,Q,E,R,E,E,W,W,R,W,W},
}

function Level_Spell(letter)  
     if letter == Q then send.key_press(0x69)
     elseif letter == W then send.key_press(0x6a)
     elseif letter == E then send.key_press(0x6b)
     elseif letter == R then send.key_press(0x6c) end
end

function IsLolActive()
    return tostring(winapi.get_foreground_window()) == "League of Legends (TM) Client"
end

function OnTick()
    if CfgSettings.AutoLevelSpells_ONOFF and IsLolActive() and IsChatOpen() == 0 then
        local spellLevelSum = myHero.SpellLevelQ + myHero.SpellLevelW + myHero.SpellLevelE + myHero.SpellLevelR
        if attempts <= 10 or (attempts > 10 and GetTickCount() > lastAttempt+1500) then
            if spellLevelSum < myHero.selflevel then
                if lastSpellLevelSum ~= spellLevelSum then attempts = 0 end
                if CfgSettings.SkillOrder == 1 then letter = skillingOrder["MaxE"][spellLevelSum+1] end
				if CfgSettings.SkillOrder == 2 then letter = skillingOrder["MaxQ"][spellLevelSum+1] end
				
                Level_Spell(letter, spellLevelSum)
                attempts = attempts+1
                lastAttempt = GetTickCount()
                lastSpellLevelSum = spellLevelSum
            else
                attempts = 0
            end
        end
    end
    send.tick()
end

SetTimerCallback("OnTick")
----------[[End of IGERs Auto Level]]

----------[[Lib Func]]
function CountUnit(Center,Radius)
	local UnitCount = 0
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			if GetDistance(enemy,Center) < Radius then
				UnitCount = UnitCount + 1
			end
		end
	end
	return UnitCount
end

----------[[Auto Dodge Skillhots]]
function Main()
	if tostring(winapi.get_foreground_window()) == "League of Legends (TM) Client" then
		Skillshots()
		if blockAndMove ~= nil then blockAndMove() end
		send.tick()
	end
end

function CreateBlockAndMoveToXYZ(x, y, z)
    print('CreateBlockAndMoveToXYZ', x, y, z)
    local move_start_time, move_dest, move_pending
    send.block_input(true,750,MakeStateMatch)
    move_start_time = os.clock()
    move_dest = {x=x, y=y, z=z}
    move_pending = true
    MoveToXYZ(move_dest.x, 0, move_dest.z)
    run_once = false
    return function()
        if move_pending then
            printtext('.')
            local waited_too_long = move_start_time + 1 < os.clock()    
            if waited_too_long or GetDistance(move_dest)<75 then
                print('\nremaining distance: '..tostring(GetDistance(move_dest)))
                move_pending = false
                send.block_input(false)
            end
        else
            printtext(' ')
        end
    end
end

function MakeStateMatch(changes)
    for scode,flag in pairs(changes) do    
        print(scode)
        if flag then print('went down') else print('went up') end
        local vk = winapi.map_virtual_key(scode, 3)
        local is_down = winapi.get_async_key_state(vk)
        if flag then -- went down
            if is_down then
                send.wait(60)
                send.key_down(scode)
                send.wait(60)
            else
                -- up before, up after, down during, we don't care
            end            
        else -- went up
            if is_down then
                -- down before, down after, up during, we don't care
            else
                send.wait(60)
                send.key_up(scode)
                send.wait(60)
            end
        end
    end
end

function OnProcessSpell(unit,spell)
	local P1 = spell.startPos
	local P2 = spell.endPos
	local calc = (math.floor(math.sqrt((P2.x-unit.x)^2 + (P2.z-unit.z)^2)))
	if string.find(unit.name,"Minion_") == nil and string.find(unit.name,"Turret_") == nil then
		if (unit.team ~= myHero.team or (show_allies==1)) and string.find(spell.name,"Basic") == nil then
			for i=1, #skillshotArray, 1 do
				local maxdist
				local dodgeradius
				dodgeradius = skillshotArray[i].radius
				maxdist = skillshotArray[i].maxdistance
				if spell.name == skillshotArray[i].name then
					skillshotArray[i].shot = 1
					skillshotArray[i].lastshot = os.clock()
					if skillshotArray[i].type == 1 then
						skillshotArray[i].p1x = unit.x
						skillshotArray[i].p1y = unit.y
						skillshotArray[i].p1z = unit.z
						skillshotArray[i].p2x = unit.x + (maxdist)/calc*(P2.x-unit.x)
						skillshotArray[i].p2y = P2.y
						skillshotArray[i].p2z = unit.z + (maxdist)/calc*(P2.z-unit.z)
						dodgelinepass(unit, P2, dodgeradius, maxdist)
					elseif skillshotArray[i].type == 2 then
						skillshotArray[i].px = P2.x
						skillshotArray[i].py = P2.y
						skillshotArray[i].pz = P2.z
						dodgelinepoint(unit, P2, dodgeradius)
					elseif skillshotArray[i].type == 3 then
						skillshotArray[i].skillshotpoint = calculateLineaoe(unit, P2, maxdist)
						if skillshotArray[i].name ~= "SummonerClairvoyance" then
							dodgeaoe(unit, P2, dodgeradius)
						end
					elseif skillshotArray[i].type == 4 then
						skillshotArray[i].px = unit.x + (maxdist)/calc*(P2.x-unit.x)
						skillshotArray[i].py = P2.y
						skillshotArray[i].pz = unit.z + (maxdist)/calc*(P2.z-unit.z)
						dodgelinepass(unit, P2, dodgeradius, maxdist)
					elseif skillshotArray[i].type == 5 then
						skillshotArray[i].skillshotpoint = calculateLineaoe2(unit, P2, maxdist)
						dodgeaoe(unit, P2, dodgeradius)
					end
				end
			end
		end
	end
end

function dodgeaoe(pos1, pos2, radius)
	print('dodgeaoe', pos1, pos2, radius, maxDist)
	print('dodgeaoe:pos1:', pos1.x, pos1.y, pos1.z)
	print('dodgeaoe:pos2:', pos2.x, pos2.y, pos2.z)
	local calc = (math.floor(math.sqrt((pos2.x-myHero.x)^2 + (pos2.z-myHero.z)^2)))
	local dodgex
	local dodgez
	dodgex = pos2.x + ((radius+100)/calc)*(myHero.x-pos2.x)
	dodgez = pos2.z + ((radius+100)/calc)*(myHero.z-pos2.z)
	if calc < radius and CfgSettings.dodgeskillshot == true then
        MoveToXYZ(dodgex,0,dodgez)
	end
end

function dodgelinepoint(pos1, pos2, radius)
	local calc1 = (math.floor(math.sqrt((pos2.x-myHero.x)^2 + (pos2.z-myHero.z)^2)))
	local calc2 = (math.floor(math.sqrt((pos1.x-myHero.x)^2 + (pos1.z-myHero.z)^2)))
	local calc4 = (math.floor(math.sqrt((pos1.x-pos2.x)^2 + (pos1.z-pos2.z)^2)))
	local calc3
	local perpendicular
	local k
	local x4
	local z4
	local dodgex
	local dodgez
	perpendicular = (math.floor((math.abs((pos2.x-pos1.x)*(pos1.z-myHero.z)-(pos1.x-myHero.x)*(pos2.z-pos1.z)))/(math.sqrt((pos2.x-pos1.x)^2 + (pos2.z-pos1.z)^2))))
	k = ((pos2.z-pos1.z)*(myHero.x-pos1.x) - (pos2.x-pos1.x)*(myHero.z-pos1.z)) / ((pos2.z-pos1.z)^2 + (pos2.x-pos1.x)^2)
	x4 = myHero.x - k * (pos2.z-pos1.z)
	z4 = myHero.z + k * (pos2.x-pos1.x)
	calc3 = (math.floor(math.sqrt((x4-myHero.x)^2 + (z4-myHero.z)^2)))
	dodgex = x4 + ((radius+100)/calc3)*(myHero.x-x4)
	dodgez = z4 + ((radius+100)/calc3)*(myHero.z-z4)
	if perpendicular < radius and calc1 < calc4 and calc2 < calc4 and CfgSettings.dodgeskillshot == true then
		blockAndMove = CreateBlockAndMoveToXYZ(dodgex,0,dodgez)
	end
end

function dodgelinepass(pos1, pos2, radius, maxDist)
	print('dodgelinepass', pos1, pos2, radius, maxDist)
	print('dodgelinepass:pos1:', pos1.x, pos1.y, pos1.z)
	print('dodgelinepass:pos2:', pos2.x, pos2.y, pos2.z)
	local pm2x = pos1.x + (maxDist)/(math.floor(math.sqrt((pos1.x-pos2.x)^2 + (pos1.z-pos2.z)^2)))*(pos2.x-pos1.x)
	local pm2z = pos1.z + (maxDist)/(math.floor(math.sqrt((pos1.x-pos2.x)^2 + (pos1.z-pos2.z)^2)))*(pos2.z-pos1.z)
	local calc1 = (math.floor(math.sqrt((pm2x-myHero.x)^2 + (pm2z-myHero.z)^2)))
	local calc2 = (math.floor(math.sqrt((pos1.x-myHero.x)^2 + (pos1.z-myHero.z)^2)))
	local calc3
	local calc4 = (math.floor(math.sqrt((pos1.x-pm2x)^2 + (pos1.z-pm2z)^2)))
	local perpendicular
	local k
	local x4
	local z4
	local dodgex
	local dodgez
	perpendicular = (math.floor((math.abs((pm2x-pos1.x)*(pos1.z-myHero.z)-(pos1.x-myHero.x)*(pm2z-pos1.z)))/(math.sqrt((pm2x-pos1.x)^2 + (pm2z-pos1.z)^2))))
	k = ((pm2z-pos1.z)*(myHero.x-pos1.x) - (pm2x-pos1.x)*(myHero.z-pos1.z)) / ((pm2z-pos1.z)^2 + (pm2x-pos1.x)^2)
	x4 = myHero.x - k * (pm2z-pos1.z)
	z4 = myHero.z + k * (pm2x-pos1.x)
	calc3 = (math.floor(math.sqrt((x4-myHero.x)^2 + (z4-myHero.z)^2)))
	dodgex = x4 + ((radius+100)/calc3)*(myHero.x-x4)
	dodgez = z4 + ((radius+100)/calc3)*(myHero.z-z4)
	if perpendicular < radius and calc1 < calc4 and calc2 < calc4 and CfgSettings.dodgeskillshot == true then
		blockAndMove = CreateBlockAndMoveToXYZ(dodgex,0,dodgez)
	end
end


function calculateLinepass(pos1, pos2, spacing, maxDist)
	local calc = (math.floor(math.sqrt((pos2.x-pos1.x)^2 + (pos2.z-pos1.z)^2)))
	local line = {}
	local point1 = {}
	point1.x = pos1.x
	point1.y = pos1.y
	point1.z = pos1.z
	local point2 = {}
	point1.x = pos1.x + (maxDist)/calc*(pos2.x-pos1.x)
	point1.y = pos2.y
	point1.z = pos1.z + (maxDist)/calc*(pos2.z-pos1.z)
	table.insert(line, point2)
	table.insert(line, point1)
	return line
end

function calculateLineaoe(pos1, pos2, maxDist)
	local line = {}
	local point = {}
	point.x = pos2.x
	point.y = pos2.y
	point.z = pos2.z
	table.insert(line, point)
	return line
end

function calculateLineaoe2(pos1, pos2, maxDist)
	local calc = (math.floor(math.sqrt((pos2.x-pos1.x)^2 + (pos2.z-pos1.z)^2)))
	local line = {}
	local point = {}
		if calc < maxDist then
		point.x = pos2.x
		point.y = pos2.y
		point.z = pos2.z
		table.insert(line, point)
	else
		point.x = pos1.x + maxDist/calc*(pos2.x-pos1.x)
		point.z = pos1.z + maxDist/calc*(pos2.z-pos1.z)
		point.y = pos2.y
		table.insert(line, point)
	end
	return line
end

function calculateLinepoint(pos1, pos2, spacing, maxDist)
	local line = {}
	local point1 = {}
	point1.x = pos1.x
	point1.y = pos1.y
	point1.z = pos1.z
	local point2 = {}
	point1.x = pos2.x
	point1.y = pos2.y
	point1.z = pos2.z
	table.insert(line, point2)
	table.insert(line, point1)
	return line
end

function table_print (tt, indent, done)
	done = done or {}
	indent = indent or 0
	if type(tt) == "table" then
		local sb = {}
		for key, value in pairs (tt) do
			table.insert(sb, string.rep (" ", indent)) -- indent it
			if type (value) == "table" and not done [value] then
				done [value] = true
				table.insert(sb, "{\n");
				table.insert(sb, table_print (value, indent + 2, done))
				table.insert(sb, string.rep (" ", indent)) -- indent it
				table.insert(sb, "}\n");
			elseif "number" == type(key) then
				table.insert(sb, string.format("\"%s\"\n", tostring(value)))
			else
				table.insert(sb, string.format(
				"%s = \"%s\"\n", tostring (key), tostring(value)))
			end
		end
		return table.concat(sb)
	else
	return tt .. "\n"
	end
end

function Skillshots()
	cc=cc+1
	if (cc==30) then
		LoadTable()
	end
	if CfgSettings.drawskillshot == true then
		for i=1, #skillshotArray, 1 do
			if skillshotArray[i].shot == 1 then
				local radius = skillshotArray[i].radius
				local color = skillshotArray[i].color
				if skillshotArray[i].isline == false then
					for number, point in pairs(skillshotArray[i].skillshotpoint) do
						DrawCircle(point.x, point.y, point.z, radius, color)
					end
				else
					startVector = Vector(skillshotArray[i].p1x,skillshotArray[i].p1y,skillshotArray[i].p1z)
					endVector = Vector(skillshotArray[i].p2x,skillshotArray[i].p2y,skillshotArray[i].p2z)
					directionVector = (endVector-startVector):normalized()
					local angle=0
					if (math.abs(directionVector.x)<.00001) then
						if directionVector.z > 0 then angle=90
						elseif directionVector.z < 0 then angle=270
						else angle=0
						end
					else
						local theta = math.deg(math.atan(directionVector.z / directionVector.x))
						if directionVector.x < 0 then theta = theta + 180 end
							if theta < 0 then theta = theta + 360 end
								angle=theta
							end
								angle=((90-angle)*2*math.pi)/360
								DrawLine(startVector.x, startVector.y, startVector.z, GetDistance(startVector, endVector)+170, 1,angle,radius)
						end
					end
				end
			end
	for i=1, #skillshotArray, 1 do
		if os.clock() > (skillshotArray[i].lastshot + skillshotArray[i].time) then
		skillshotArray[i].shot = 0
		end
	end
end

function LoadTable()
	print("table loaded::")
	local iCount=objManager:GetMaxHeroes()
	print(" heros:" .. tostring(iCount))
	iCount=1;
	for i=0, iCount, 1 do
		local skillshotplayerObj = GetSelf();
		print(" name:" .. skillshotplayerObj.name);
		if 1==1 or skillshotplayerObj.name == "Quinn" then
			table.insert(skillshotArray,{name= "QuinnQMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1025, type = 1, radius = 40, color= coloryellow, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Lissandra" then
			table.insert(skillshotArray,{name= "LissandraQ", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 725, type = 1, radius = 100, color= coloryellow, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "LissandraE", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1050, type = 1, radius = 100, color= coloryellow, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Zac" then
			table.insert(skillshotArray,{name= "ZacQ", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 550, type = 1, radius = 100, color= coloryellow, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "ZacE", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1550, type = 3, radius = 200, color= colorcyan, time = 2, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Syndra" then
			table.insert(skillshotArray,{name= "SyndraQ", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 800, type = 3, radius = 200, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "SyndraE", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 650, type = 1, radius = 100, color= coloryellow, time = 0.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "syndrawcast", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 3, radius = 200, color= colorcyan, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Jayce" then
			table.insert(skillshotArray,{name= "jayceshockblast", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1470, type = 1, radius = 100, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Nami" then
			table.insert(skillshotArray,{name= "NamiQ", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 875, type = 3, radius = 200, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "NamiR", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 2550, type = 1, radius = 350, color= colorcyan, time = 3, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Vi" then
			table.insert(skillshotArray,{name= "ViQ", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 1, radius = 150, color= coloryellow, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
			if 1==1 or skillshotplayerObj.name == "Thresh" then
			table.insert(skillshotArray,{name= "ThreshQ", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 100, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Khazix" then
			table.insert(skillshotArray,{name= "KhazixE", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 3, radius = 200, color= colorcyan, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "KhazixW", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 120, color= coloryellow, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "khazixwlong", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 150, color= coloryellow, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "khazixelong", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 200, color= colorcyan, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Elise" then
			table.insert(skillshotArray,{name= "EliseHumanE", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1075, type = 1, radius = 100, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Zed" then
			table.insert(skillshotArray,{name= "ZedShuriken", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 1, radius = 100, color= coloryellow, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "ZedShadowDash", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 550, type = 3, radius = 150, color= colorcyan, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "zedw2", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 550, type = 3, radius = 150, color= colorcyan, time = 0.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Ahri" then
			table.insert(skillshotArray,{name= "AhriOrbofDeception", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 880, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
			table.insert(skillshotArray,{name= "AhriSeduce", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 975, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Amumu" then
			table.insert(skillshotArray,{name= "BandageToss", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Anivia" then
			table.insert(skillshotArray,{name= "FlashFrostSpell", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 90, color= colorcyan, time = 2, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Ashe" then
			table.insert(skillshotArray,{name= "EnchantedCrystalArrow", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 50000, type = 4, radius = 120, color= colorcyan, time = 4, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Blitzcrank" then
			table.insert(skillshotArray,{name= "RocketGrabMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 925, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Brand" then
			table.insert(skillshotArray,{name= "BrandBlazeMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1050, type = 1, radius = 70, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
			table.insert(skillshotArray,{name= "BrandFissure", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 250, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Cassiopeia" then
			table.insert(skillshotArray,{name= "CassiopeiaMiasma", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 850, type = 3, radius = 175, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "CassiopeiaNoxiousBlast", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 850, type = 3, radius = 75, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Caitlyn" then
			table.insert(skillshotArray,{name= "CaitlynEntrapmentMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 50, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "CaitlynPiltoverPeacemaker", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1300, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Corki" then
			table.insert(skillshotArray,{name= "MissileBarrageMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1225, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "MissileBarrageMissile2", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1225, type = 1, radius = 100, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "CarpetBomb", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 800, type = 2, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Chogath" then
			table.insert(skillshotArray,{name= "Rupture", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 3, radius = 275, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "DrMundo" then
			table.insert(skillshotArray,{name= "InfectedCleaverMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Heimerdinger" then
			table.insert(skillshotArray,{name= "CH1ConcussionGrenade", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 3, radius = 225, color= coloryellow, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Draven" then
			table.insert(skillshotArray,{name= "DravenDoubleShot", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1050, type = 1, radius = 125, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "DravenRCast", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 5000, type = 1, radius = 100, color= colorcyan, time = 4, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Ezreal" then
			table.insert(skillshotArray,{name= "EzrealEssenceFluxMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 1, radius = 100, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "EzrealMysticShotMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "EzrealTrueshotBarrage", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 5000, type = 4, radius = 150, color= colorcyan, time = 4, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "EzrealArcaneShift", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 475, type = 5, radius = 100, color= colorgreen, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Fizz" then
			table.insert(skillshotArray,{name= "FizzMarinerDoom", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1275, type = 2, radius = 100, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "FiddleSticks" then
			table.insert(skillshotArray,{name= "Crowstorm", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 800, type = 3, radius = 600, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Karthus" then
			table.insert(skillshotArray,{name= "LayWaste", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 875, type = 3, radius = 150, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Galio" then
			table.insert(skillshotArray,{name= "GalioResoluteSmite", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 905, type = 3, radius = 200, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "GalioRighteousGust", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 120, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Graves" then
			table.insert(skillshotArray,{name= "GravesChargeShot", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 110, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "GravesClusterShot", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 750, type = 1, radius = 50, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "GravesSmokeGrenade", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 3, radius = 275, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Gragas" then
			table.insert(skillshotArray,{name= "GragasBarrelRoll", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 3, radius = 320, color= coloryellow, time = 2.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "GragasBodySlam", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 650, type = 2, radius = 60, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "GragasExplosiveCask", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1050, type = 3, radius = 400, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Irelia" then
			table.insert(skillshotArray,{name= "IreliaTranscendentBlades", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1200, type = 1, radius = 150, color= colorcyan, time = 0.8, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Janna" then
			table.insert(skillshotArray,{name= "HowlingGale", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1700, type = 1, radius = 100, color= colorcyan, time = 2, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "JarvanIV" then
			table.insert(skillshotArray,{name= "JarvanIVDemacianStandard", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 830, type = 3, radius = 150, color= coloryellow, time = 2, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "JarvanIVDragonStrike", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 770, type = 1, radius = 70, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "JarvanIVCataclysm", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 650, type = 3, radius = 300, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Kassadin" then
			table.insert(skillshotArray,{name= "RiftWalk", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 5, radius = 150, color= colorgreen, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Katarina" then
			table.insert(skillshotArray,{name= "ShadowStep", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 3, radius = 75, color= colorgreen, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Kennen" then
			table.insert(skillshotArray,{name= "KennenShurikenHurlMissile1", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1050, type = 1, radius = 75, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "KogMaw" then
			table.insert(skillshotArray,{name= "KogMawVoidOozeMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1115, type = 1, radius = 100, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "KogMawLivingArtillery", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 2200, type = 3, radius = 200, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Leblanc" then
			table.insert(skillshotArray,{name= "LeblancSoulShackle", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "LeblancSoulShackleM", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "LeblancSlide", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 3, radius = 250, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "LeblancSlideM", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 3, radius = 250, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "leblancslidereturn", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 3, radius = 50, color= colorgreen, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "leblancslidereturnm", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 3, radius = 50, color= colorgreen, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "LeeSin" then
			table.insert(skillshotArray,{name= "BlindMonkQOne", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 975, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "BlindMonkRKick", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1200, type = 1, radius = 100, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Leona" then
			table.insert(skillshotArray,{name= "LeonaZenithBladeMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Lucian" then
			table.insert(skillshotArray,{name= "LucianQ", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 100, color= colorcyan, time = 0.75, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "LucianW", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 150, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "LucianR", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1400, type = 1, radius = 250, color= colorcyan, time = 3, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Lux" then
			table.insert(skillshotArray,{name= "LuxLightBinding", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1175, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "LuxLightStrikeKugel", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 3, radius = 300, color= coloryellow, time = 2.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "LuxMaliceCannon", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 3000, type = 1, radius = 180, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Lulu" then
			table.insert(skillshotArray,{name= "LuluQ", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 925, type = 1, radius = 50, color= colorcyan, time = 1, isline = true, px =0, py =0 , pz =0, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Maokai" then
			table.insert(skillshotArray,{name= "MaokaiTrunkLineMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 1, radius = 100, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "MaokaiSapling2", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 3, radius = 350 , color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Malphite" then
			table.insert(skillshotArray,{name= "UFSlash", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 3, radius = 325, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Malzahar" then
			table.insert(skillshotArray,{name= "AlZaharCalloftheVoid", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 100 , color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "AlZaharNullZone", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 800, type = 3, radius = 250 , color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "MissFortune" then
			table.insert(skillshotArray,{name= "MissFortuneScattershot", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 800, type = 3, radius = 400, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Morgana" then
			table.insert(skillshotArray,{name= "DarkBindingMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1300, type = 1, radius = 90, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "TormentedSoil", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 300, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Nautilus" then
			table.insert(skillshotArray,{name= "NautilusAnchorDrag", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 1, radius = 150, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Nidalee" then
			table.insert(skillshotArray,{name= "JavelinToss", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1500, type = 1, radius = 150, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Nocturne" then
			table.insert(skillshotArray,{name= "NocturneDuskbringer", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1200, type = 1, radius = 150, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Olaf" then
			table.insert(skillshotArray,{name= "OlafAxeThrow", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 2, radius = 100, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Orianna" then
			table.insert(skillshotArray,{name= "OrianaIzunaCommand", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 825, type = 3, radius = 150, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Renekton" then
			table.insert(skillshotArray,{name= "RenektonSliceAndDice", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 450, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "renektondice", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 450, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Rumble" then
			table.insert(skillshotArray,{name= "RumbleGrenadeMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 100, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "RumbleCarpetBomb", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1700, type = 1, radius = 100, color= coloryellow, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Sivir" then
			table.insert(skillshotArray,{name= "SpiralBlade", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 100, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Singed" then
			table.insert(skillshotArray,{name= "MegaAdhesive", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 3, radius = 350, color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Shen" then
			table.insert(skillshotArray,{name= "ShenShadowDash", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 2, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Shaco" then
			table.insert(skillshotArray,{name= "Deceive", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 500, type = 5, radius = 100, color= colorgreen, time = 3.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Shyvana" then
			table.insert(skillshotArray,{name= "ShyvanaTransformLeap", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 925, type = 1, radius = 150, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "ShyvanaFireballMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Skarner" then
			table.insert(skillshotArray,{name= "SkarnerFracture", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 1, radius = 100, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Sona" then
			table.insert(skillshotArray,{name= "SonaCrescendo", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Sejuani" then
			table.insert(skillshotArray,{name= "SejuaniGlacialPrison", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1150, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Swain" then
			table.insert(skillshotArray,{name= "SwainShadowGrasp", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 265 , color= coloryellow, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Tryndamere" then
			table.insert(skillshotArray,{name= "Slash", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 2, radius = 100, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Tristana" then
			table.insert(skillshotArray,{name= "RocketJump", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 200, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "TwistedFate" then
			table.insert(skillshotArray,{name= "WildCards", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1450, type = 1, radius = 150, color= colorcyan, time = 5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Urgot" then
			table.insert(skillshotArray,{name= "UrgotHeatseekingLineMissile", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 150, color= colorcyan, time = 0.8, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "UrgotPlasmaGrenade", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 3, radius = 300, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Vayne" then
			table.insert(skillshotArray,{name= "VayneTumble", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 250, type = 3, radius = 100, color= colorgreen, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Varus" then
			--table.insert(skillshotArray,{name= "VarusQ", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1475, type = 1, radius = 50, color= coloryellow, time = 1})
			table.insert(skillshotArray,{name= "VarusR", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1075, type = 1, radius = 150, color= colorcyan, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Veigar" then
			table.insert(skillshotArray,{name= "VeigarDarkMatter", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 225, color= coloryellow, time = 2, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Viktor" then
			--table.insert(skillshotArray,{name= "ViktorDeathRay", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 1, radius = 150, color= coloryellow, time = 2})
		end
		if 1==1 or skillshotplayerObj.name == "Xerath" then
			table.insert(skillshotArray,{name= "xeratharcanopulsedamage", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "xeratharcanopulsedamageextended", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1300, type = 1, radius = 150, color= colorcyan, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "xeratharcanebarragewrapper", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 250, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "xeratharcanebarragewrapperext", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1300, type = 3, radius = 250, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Ziggs" then
			table.insert(skillshotArray,{name= "ZiggsQ", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 850, type = 3, radius = 160, color= coloryellow, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "ZiggsW", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 3, radius = 225 , color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			table.insert(skillshotArray,{name= "ZiggsE", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 250, color= coloryellow, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "ZiggsR", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 5300, type = 3, radius = 550, color= coloryellow, time = 3, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Zyra" then
			table.insert(skillshotArray,{name= "ZyraQFissure", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 825, type = 3, radius = 275, color= coloryellow, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			table.insert(skillshotArray,{name= "ZyraGraspingRoots", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 90, color= colorcyan, time = 2, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
		if 1==1 or skillshotplayerObj.name == "Diana" then
			table.insert(skillshotArray,{name= "DianaArc", shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 205, color= coloryellow, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
		skillshotcharexist = true
		end
    end
end

SetTimerCallback('Main')
----------[[End of Auto Dodge Skillshots]]

----------[[GETMECS]]
--COMING SOON
----------[[END OF GETMECS]]
SetTimerCallback("DeadlyCassio")