if myHero.name ~= "Fizz" then return end --will not load script if you aren't playing Fizz
--[[
▓█████▄ ▓█████ ▄▄▄      ▓█████▄  ██▓   ▓██   ██▓     █████▒██▓▒███████▒▒███████▒
▒██▀ ██▌▓█   ▀▒████▄    ▒██▀ ██▌▓██▒    ▒██  ██▒   ▓██   ▒▓██▒▒ ▒ ▒ ▄▀░▒ ▒ ▒ ▄▀░
░██   █▌▒███  ▒██  ▀█▄  ░██   █▌▒██░     ▒██ ██░   ▒████ ░▒██▒░ ▒ ▄▀▒░ ░ ▒ ▄▀▒░ 
░▓█▄   ▌▒▓█  ▄░██▄▄▄▄██ ░▓█▄   ▌▒██░     ░ ▐██▓░   ░▓█▒  ░░██░  ▄▀▒   ░  ▄▀▒   ░
░▒████▓ ░▒████▒▓█   ▓██▒░▒████▓ ░██████▒ ░ ██▒▓░   ░▒█░   ░██░▒███████▒▒███████▒
 ▒▒▓  ▒ ░░ ▒░ ░▒▒   ▓▒█░ ▒▒▓  ▒ ░ ▒░▓  ░  ██▒▒▒     ▒ ░   ░▓  ░▒▒ ▓░▒░▒░▒▒ ▓░▒░▒
 ░ ▒  ▒  ░ ░  ░ ▒   ▒▒ ░ ░ ▒  ▒ ░ ░ ▒  ░▓██ ░▒░     ░      ▒ ░░░▒ ▒ ░ ▒░░▒ ▒ ░ ▒
 ░ ░  ░    ░    ░   ▒    ░ ░  ░   ░ ░   ▒ ▒ ░░      ░ ░    ▒ ░░ ░ ░ ░ ░░ ░ ░ ░ ░
   ░       ░  ░     ░  ░   ░        ░  ░░ ░                ░    ░ ░      ░ ░    
 ░                       ░              ░ ░                   ░        ░        
 ▄▄▄▄ ▓██   ██▓    ▄████▄   ▄████▄   ▒█████   ███▄    █  ███▄    █              
▓█████▄▒██  ██▒   ▒██▀ ▀█  ▒██▀ ▀█  ▒██▒  ██▒ ██ ▀█   █  ██ ▀█   █              
▒██▒ ▄██▒██ ██░   ▒▓█    ▄ ▒▓█    ▄ ▒██░  ██▒▓██  ▀█ ██▒▓██  ▀█ ██▒             
▒██░█▀  ░ ▐██▓░   ▒▓▓▄ ▄██▒▒▓▓▄ ▄██▒▒██   ██░▓██▒  ▐▌██▒▓██▒  ▐▌██▒             
░▓█  ▀█▓░ ██▒▓░   ▒ ▓███▀ ░▒ ▓███▀ ░░ ████▓▒░▒██░   ▓██░▒██░   ▓██░             
░▒▓███▀▒ ██▒▒▒    ░ ░▒ ▒  ░░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒ ░ ▒░   ▒ ▒              
▒░▒   ░▓██ ░▒░      ░  ▒     ░  ▒     ░ ▒ ▒░ ░ ░░   ░ ▒░░ ░░   ░ ▒░             
 ░    ░▒ ▒ ░░     ░        ░        ░ ░ ░ ▒     ░   ░ ░    ░   ░ ░              
 ░     ░ ░        ░ ░      ░ ░          ░ ░           ░          ░              
      ░░ ░        ░        ░                                                    

                                                                              
                                I+?          ,                                  
                               +$7III?$$=:$++++~                                
                             +77$8D7++++++?8??++?,                              
                             $7$OI++++++++++?7II++?                             
                            ,:7O87+?~+=++++++D7Z?++:                            
                            :~Z8?N++:+++++$=ZOI77++?+                           
                             I$NIZ+?+?+++ZZ? I$Z7I77II7=,                       
                           =,Z$D77$+++++?D$ ZIO$    =+?I                        
                             IO8Z$87++++O,ZZ8O7??                               
                            , 7$8ZDZ7++++OO?$$Z$I:                              
                             :, =IDD8888ND8~   7$Z+                             
                             ~~   =78O8DOZ$?     ZZD:,~                         
                                  78D$I?OZZ7I        +                          
                                ,7ZN???=I7$ZO~                       ,====      
                               ,OZ8$??==Z777$$                      ~=~==?:     
                              Z$ZONO?===$?7I7$Z                    ===~=???     
                            ~Z7O8O??==  II7 =77I7               ,====+??+:      
                           ~O7Z788Z=~ ,I?I7  ?Z7$Z            ====+~:?=:        
                        , =8$ZO8ZD7=   ???Z  :ZZ77Z        +~???~               
                       ~ 7O7$OODZ8+, , 7?+7   OOZ$7?    ,=+???:                 
                         8O$OO8ZZO 7~~ $77+$  ~ZO$$?+  =~???                    
                         =D8O8ZZ$?    +OZ7?7   7$O$7?O~~?:                      
                          ,~ZD$Z8      ,$77II  :ODO$7+O                         
                            8O$$Z     , ,ZZ77=???OD88N+~                        
                            $D8$?    ,   :~=?????+OD?,                          
                           ?Z=========~?+????DO  +                              
                       ======?I?+:?+??????  ?O$77                               
                      ::$DO8~====????I~      IZ87?7                             
                  ~?ZOO=????++??::???::      =7Z8$7?                            
             ~~OZ?????DDD8OOO7=====$$7777777787ZOO87+:                          
            ,=7~===877777$$+==+?7Z$777777777777OOOOOOO8?=                       
             ~~~~~???????=~+???777777777777777777ZOOOO$Z7=                      
                                                +????+I?~                       
                                                                                
																				
	Follow me on Facebook! I post info on all new scripts and updates there
	CCONN's Facebook: https://www.facebook.com/CCONN81
		
	Feel like you have too much money? Give me some :) haha
	CCONN's DONATE LINK: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=JTWL7DK86V56S
		
	Like the script? +Rep my profile. My signature has a list of all my released scripts and current projects
	CCONN's Leaguebot Profile: http://leaguebot.net/forum/Upload/member.php?action=profile&uid=814
		

VERSION: 1.00b
UPDATED: 02/02/2014
BY: CCONN

CHANGELOG:		VERSION 1.0b		First BETA release																				
--]]
--[[
		REQUIRED LIBS
]]
require 'Utils'
require 'spell_damage'
require 'uiconfig'
require 'winapi'
require 'SKeys'
--[[
		VARIABLES: DEADLY FIZZ MAIN
]]
local uiconfig = require 'uiconfig'
local range = myHero.range + GetDistance(GetMinBBox(myHero))
local HavocDamage, ExecutionerDamage, True_Attack_Damage_Against_Minions = 0, 0, 0
local target
local target2
local targetHero
local tlow
local UltPOS
local timerPlayful = 0
local timerBP = 0
local ultPos
--[[
		VARIABLES: AUTO LEVEL SPELLS
]]
local send = require 'SendInputScheduled'
local version = "1.2.2"
local Q,W,E,R = 'Q','W','E','R'
local metakey = SKeys.Control
local attempts = 0
local lastAttempt = 0
--[[
		VARIABLES: DODGE SKILLSHOTS
]]
local send = require 'SendInputScheduled'
local uiconfig = require 'uiconfig'
local version = '1.4.4'
local skillshotArray = {}
local xa = 50/1920*GetScreenX()
local xb = 1870/1920*GetScreenX()
local ya = 50/1080*GetScreenY()
local yb = 1030/1080*GetScreenY()
local cc = 0
--[[
		VARIABLES: ROAM HELPER
]]
local Enemies = {}
local EnemyIndex = 1
--[[
		SCRIPT MENU: CONTROLS
		
		Menu for keybinds, toggles and sliders
		related to the the most frequently used
		features of the script.
]]
CfgFizzControls, menu = uiconfig.add_menu('1. Fizz Controls', 200)
menu.label('lbl1', 'Deadly Fizz by CCONN')															
menu.label('lbl2', 'Version: 1.0b')																
menu.label('lbl3', ' ')																				
menu.label('lbl4', 'Follow my Facebook:')															
menu.label('lbl5', 'www.facebook.com/CCONN81')														
menu.label('lbl6', ' ')																				
menu.keydown('Combo', 'Combo', Keys.Space) 															--CfgFizzControls.Combo
menu.keydown('Harass', 'Harass', Keys.Z) 															--CfgFizzControls.Harass
menu.keydown('Farm', 'Farm', Keys.X) 																--CfgFizzControls.Farm
menu.keydown('mixedMode', 'Mixed Mode', Keys.C) 													--CfgFizzControls.mixedMode
menu.keydown('laneClear', 'Lane Clear', Keys.V) 													--CfgFizzControls.laneClear
menu.keydown('castR', 'Cast Ultimate', Keys.A) 														--CfgFizzControls.castR
menu.label('lbl7', ' ')																				
menu.label('lbl8', 'MEC Ultimate Options')															
menu.checkbutton('useAutoMECR', 'use Auto MEC R', true)												--CfgFizzControls.useAutoMECR
menu.slider('valMECR', 'Minimum MEC Value', 1, 5, 3, {1,2,3,4,5}) 									--CfgFizzControls.valMECR
menu.label('lbl9', ' ')																				
menu.label('lbl10', 'Combat Values')																
menu.slider('valAllIn', 'All-In Value', 0, 100, 40, nil, true) 										--CfgFizzControls.valAllIn
menu.slider('valEmergency', 'Emergency Value', 0, 100, 20, nil, true) 								--CfgFizzControls.valEmergency
--[[
		SCRIPT MENU: SETTINGS
		
		Setup which spells, items, and summoners are used for:
			Combo
			Mixed Mode
			Lane Clear
			Auto Harass
			Harass
]]
CfgFizzSettings, menu = uiconfig.add_menu('2. Fizz Settings', 200)
menu.label('lbl1', 'Deadly Fizz by CCONN')															
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ Combo Settings ↓↓↓')														
menu.checkbutton('useQ1', 'use Urchin Strike', true) 												--CfgFizzSettings.useQ1
menu.checkbutton('useW1', 'use Seastone Triden', true) 												--CfgFizzSettings.useW1
menu.checkbutton('useE1', 'use Playful', false) 													--CfgFizzSettings.useE1
menu.checkbutton('useE1a', 'use Trickster', false) 													--CfgFizzSettings.useE1a
menu.keytoggle('useR1', 'use Ult', Keys.Z, true) 													--CfgFizzSettings.useR1
menu.checkbutton('useItems1', 'use Active Items', true) 											--CfgFizzSettings.useItems1
menu.checkbutton('useAA1', 'use Auto Attacks', true) 												--CfgFizzSettings.useAA1
menu.checkbutton('useIgnite1', 'use Ignite', true) 													--CfgFizzSettings.useIgnite1
menu.checkbutton('useExhaust1', 'use Exhaust', true) 												--CfgFizzSettings.useExhaust1
menu.checkbutton('useMoveToMouse1', 'Move to Mouse', true) 											--CfgFizzSettings.useMoveToMouse1
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ Mixed Mode Settings ↓↓↓')													
menu.checkbutton('useQ2', 'use Urchin Strike', true) 												--CfgFizzSettings.useQ2
menu.checkbutton('useW2', 'use Seastone Triden', true) 												--CfgFizzSettings.useW2
menu.checkbutton('useE2', 'use Playful', false) 													--CfgFizzSettings.useE2
menu.checkbutton('useE2a', 'use Trickster', false) 													--CfgFizzSettings.useR2
menu.keytoggle('useR2', 'use Ult', Keys.Z, true) 													--CfgFizzSettings.useR2
menu.checkbutton('useItems2', 'use Active Items', true) 											--CfgFizzSettings.useItems2
menu.checkbutton('useAA2', 'use Auto Attacks', true) 	
menu.checkbutton('useMoveToMouse2', 'Move to Mouse', true) 											--CfgFizzSettings.useMoveToMouse1
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ Lane Clear Settings ↓↓↓')													
menu.checkbutton('useQ3', 'clear with Urchin Strike', true) 										--CfgFizzSettings.useQ3
menu.checkbutton('useW3', 'clear with Seastone Triden', true) 										--CfgFizzSettings.useW3
menu.checkbutton('useE3', 'clear wtih Playful Trickster', true) 									--CfgFizzSettings.useE3
menu.checkbutton('useMoveToMouse3', 'Move to Mouse', true) 											--CfgFizzSettings.useMoveToMouse1
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ Auto Harass Settings ↓↓↓')													
menu.checkbutton('useQ4', 'use Urchin Strike', true) 												--CfgFizzSettings.useQ4
menu.checkbutton('useW4', 'use Seastone Triden', true) 												--CfgFizzSettings.useW4
menu.checkbutton('useE4', 'use Playful', true) 														--CfgFizzSettings.useE4
menu.checkbutton('useE4a', 'use Trickster', true) 													--CfgFizzSettings.useE4a
menu.slider('ahThreshold', 'Mana Threshold', 0, 100, 50, nil, true) 								--CfgFizzSettings.ahThreshold
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ Manual Harass Settings ↓↓↓')													
menu.checkbutton('useQ5', 'use Urchin Strike', true) 												--CfgFizzSettings.useQ5
menu.checkbutton('useW5', 'use Seastone Triden', true) 												--CfgFizzSettings.useW5
menu.checkbutton('useE5', 'use Playful', true) 														--CfgFizzSettings.useE5
menu.checkbutton('useE5a', 'use Trickster', true) 													--CfgFizzSettings.useE5a
menu.checkbutton('useAA5', 'use Auto Attacks', true) 	
menu.checkbutton('useMoveToMouse5', 'Move to Mouse', true) 											--CfgFizzSettings.useMoveToMouse5

--[[
		SCRIPT MENU: KILL STEALS
		
		Toggles to enable individual kill steal combinations
]]
CfgFizzKSSettings, menu = uiconfig.add_menu('3. Kill Steals', 200)
menu.label('lbl1', 'Deadly Fizz by CCONN')															
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ Adjust Individual Kill Steals ↓↓↓')											
menu.checkbutton('useQKS', 'KS w/ Q', true) 														--CfgFizzSettings.useQKS
menu.checkbutton('useWQKS', 'KS w/ W+Q', true) 														--CfgFizzSettings.useWQKS
menu.checkbutton('useRKS', 'KS w/ R', true) 														--CfgFizzSettings.useRKS
--[[
		SCRIPT MENU: ITEMS
		
		Toggles for individual active item usage
]]
CfgFizzItemSettings, menu = uiconfig.add_menu('4. Items', 200)
menu.label('lbl1', 'Deadly Fizz by CCONN')															
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ CCONNs Custom Items ↓↓↓')													
menu.checkbutton('useBFT', 'use Blackfire Torch', true) 											--CfgFizzItemSettings.useBFT
menu.checkbutton('useDFG', 'use Deathfire Grasp', true) 											--CfgFizzItemSettings.useDFG
menu.checkbutton('useFQC', 'use Frost Queens Claim', true) 											--CfgFizzItemSettings.useFQC
menu.checkbutton('useHGB', 'use Hextech Gunblade', true) 											--CfgFizzItemSettings.useHGB
menu.checkbutton('useSeraph', 'use Seraphs Embrace', true) 											--CfgFizzItemSettings.useSeraph
menu.checkbutton('useTwinShadows', 'use Twin Shadows', true) 										--CfgFizzItemSettings.useTwinShadows
menu.checkbutton('useWWC', 'use Wooglets Witchcap', true) 											--CfgFizzItemSettings.useWWC
menu.checkbutton('useZHG', 'use Zhonyas Hourglass', true) 											--CfgFizzItemSettings.useZHG
--[[
		SCRIPT MENU: AUTO POT
		
		Toggles and threashold sliders for consumables
]]
CfgFizzAutoPotSettings, menu = uiconfig.add_menu('5. Auto Pot', 200)
menu.label('lbl1', 'Deadly Fizz by CCONN')															
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ CCONNs Auto Pot Settings ↓↓↓')												
menu.checkbutton('useHPPot', 'use Health Potions & Biscuits', true) 								--CfgFizzAutoPotSettings.useHPPot
menu.checkbutton('useHPElixir', 'use Elixir of Fortiude', true) 									--CfgFizzAutoPotSettings.useHPElixir
menu.checkbutton('useFlask', 'use Chrystalline Flask', true) 										--CfgFizzAutoPotSettings.useFlask
menu.checkbutton('useManaPot', 'use Mana Potions', true) 											--CfgFizzAutoPotSettings.useManaPot
menu.slider('thresholdHPPot', 'HP Pot Threshold', 0, 100, 75, nil, true) 							--CfgFizzAutoPotSettings.thresholdHPPot
menu.slider('thresholdHPElixir', 'HP Elixir Threshold', 0, 100, 20, nil, true) 						--CfgFizzAutoPotSettings.thresholdHPElixir
menu.slider('thresholdFlask', 'Flask Threshold', 0, 100, 75, nil, true) 							--CfgFizzAutoPotSettings.thresholdFlask
menu.slider('thresholdManaPot', 'Mana Pot Threshold', 0, 100, 75, nil, true) 						--CfgFizzAutoPotSettings.thresholdManaPot
--[[
		SCRIPT MENU: DODGE SKILLSHOTS
		
		Toggles for using E for dodging skillshots and moving to dodge skillshots
]]
CfgFizzDodgeSettings, menu = uiconfig.add_menu('6. Dodge Skillshots', 200)
menu.label('lbl1', 'Deadly Fizz by CCONN')															
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ Dodge with Playful Trickster ↓↓↓')											
menu.checkbutton('dodgePlayfulTrickster', 'Playful Trickster Dodge (line)', true) 					--CfgFizzDodgeSettings.dodgePlayfulTrickster
menu.checkbutton('dodgeAOEPlayfulTrickster', 'Playful Trickster Dodge (AOE)', true) 				--CfgFizzDodgeSettings.dodgeAOEPlayfulTrickster
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ Dodge by Moving ↓↓↓')														
menu.checkbutton('DodgeSkillShots', 'Dodge Skillshots', true) 										--CfgFizzDodgeSettings.DodgeSkillShots
menu.checkbutton('DodgeSkillShotsAOE', 'Dodge Skillshots for AOE', true) 							--CfgFizzDodgeSettings.DodgeSkillShotsAOE
menu.slider('BlockSettings', 'Block user input', 1, 2, 1, {'FixBlock','NoBlock'}) 					--CfgFizzDodgeSettings.BlockSettings
menu.slider('BlockSettingsAOE', 'Block user input for AOE', 1, 2, 2, {'FixBlock','NoBlock'}) 		--CfgFizzDodgeSettings.BlockSettingsAOE
menu.slider('BlockTime', 'Block imput time', 0, 1000, 750) 											--CfgFizzDodgeSettings.BlockTime
--[[
		SCRIPT MENU: MASTERIES
		
		Slider values to set how many mastery points you have
		within each supported mastery
]]
CfgFizzMasterySettings, menu = uiconfig.add_menu('7. Masteries', 200)
menu.label('lbl1', 'Deadly Fizz by CCONN')															
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ CCONNs Custom Masteries ↓↓↓')												
menu.slider('valDoubleEdgedSword', 'Double Edged Sword', 1, 2, 1, {0,1}) 							--CfgFizzMasterySettings.valDoubleEdgedSword
menu.slider('valBruteForce', 'Brute Force', 1, 4, 1, {0,1,2,3}) 									--CfgFizzMasterySettings.valBruteForce
menu.slider('valMartial', 'Martial', 1, 2, 1, {0,1}) 												--CfgFizzMasterySettings.valMartial
menu.slider('valWarlord', 'Warlord', 1, 4, 1, {0,1,2,3}) 											--CfgFizzMasterySettings.valWarlord
menu.slider('valMentalForce', 'Mental Force', 1, 4, 1, {0,1,2,3}) 									--CfgFizzMasterySettings.valMentalForce
menu.slider('valArcaneMastery', 'Arcane Mastery', 1, 2, 1, {0,1}) 									--CfgFizzMasterySettings.valArcaneMastery
menu.slider('valArchMage', 'Arch Mage', 1, 4, 1, {0,1,2,3}) 										--CfgFizzMasterySettings.valArchMage
menu.slider('valButcher', 'Butcher', 1, 2, 1, {0,1}) 												--CfgFizzMasterySettings.valButcher
menu.slider('valExecutioner', 'Executioner', 1, 4, 1, {0,1,2,3}) 									--CfgFizzMasterySettings.valExecutioner
menu.slider('valArcaneBlade', 'Arcane Blade', 1, 2, 1, {0,1}) 										--CfgFizzMasterySettings.valArcaneBlade
--[[
		SCRIPT MENU: AUTO LEVEL ABILITIES
		Toggle to enable and slider to set the skill profile
]]
CfgFizzAutoLevelSettings, menu = uiconfig.add_menu('8. Auto Level Abilities', 200)
menu.label('lbl1', 'Deadly Fizz by CCONN')															
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ Auto Level Settings ↓↓↓')													
menu.checkbutton('onoff_AutoLevelSpells', 'use Auto Level Spells', true)							--CfgFizzAutoLevelSettings.onoff_AutoLevelSpells
menu.slider('valSkillOrder', 'Auto Level Profile', 1, 2, 1, {"Max W","Max E"})						--CfgFizzAutoLevelSettings.valSkillOrder
--[[
		SCRIPT MENU: DRAW
		
		Individual toggles for ranges and all drawing related functions
]]
CfgFizzDrawSettings, menu = uiconfig.add_menu('9. Draw', 200)
menu.label('lbl1', 'Deadly Fizz by CCONN')															
menu.label('lbl2', ' ')																				
menu.label('lbl3', '↓↓↓ Draw Settings ↓↓↓')															
menu.checkbutton('drawQRange', 'Draw Q Range', true) 												--CfgFizzDrawSettings.drawQRange
menu.checkbutton('drawRRange', 'Draw R Range', true) 												--CfgFizzDrawSettings.drawRRange
menu.checkbutton('drawXPRange', 'Draw XP Range', true) 												--CfgFizzDrawSettings.drawXPRange
menu.checkbutton('drawComboCircles', 'Draw Combo Circles', true) 									--CfgFizzDrawSettings.drawComboCircles
menu.checkbutton('drawRoamHelper', 'Draw Roam Helper', true) 										--CfgFizzDrawSettings.drawRoamHelper
menu.checkbutton('drawTargetIndicator', 'Draw Target Indicator', true) 								--CfgFizzDrawSettings.drawTargetIndicator
menu.checkbutton('drawFarmCircles', 'Draw Farm Circles', true) 										--CfgFizzDrawSettings.drawFarmCircles
menu.checkbutton('drawSkillShots', 'Draw Skillshots', true) 										--CfgFizzDrawSettings.drawSkillShots
--[[
		CORE SCRIPT FUNCTION
		
		This is the function with a callback timer
		and calls all other script functions
]]
function DeadlyFizz()
	if IsChatOpen() == 0 and tostring(winapi.get_foreground_window()) == "League of Legends (TM) Client" then
		target = GetWeakEnemy('MAGIC', 550)
		target2 = GetWeakEnemy('MAGIC', 1275)
		SummonerSpells()
		Draw()
		KillSteal()
		if CfgFizzControls.Combo then Combo() end
		if CfgFizzControls.Harass then Harass() end
		if CfgFizzControls.Farm then farmMode() end
		if CfgFizzControls.mixedMode then mixedMode() end
		if CfgFizzControls.laneClear then laneClear() end
		if CfgFizzControls.castR then castChumTheWaters(target2) end
		if myHero.mana >= CfgFizzSettings.ahThreshold then autoHarass() end
		if CfgFizzAutoPotSettings.useHPPot then usePotion(CfgFizzAutoPotSettings.thresholdHPPot) end
		if CfgFizzAutoPotSettings.useHPElixir then useElixir(CfgFizzAutoPotSettings.thresholdHPElixir) end
		if CfgFizzAutoPotSettings.useFlask then useFlask(CfgFizzAutoPotSettings.thresholdFlask) end
		if CfgFizzAutoPotSettings.useManaPot then useManaPot(CfgFizzAutoPotSettings.thresholdManaPot) end
		if CfgFizzControls.useAutoMECR then mecChumTheWaters(CfgFizzControls.valMECR) end
	end
end
--[[
		COMBO FUNCTION
		
		This is the function that executes Fizz's 'all-in' combo
		Used to kill an enemy, and not harass
		Will use ultimate, active items, and summoner spells to kill
]]
function Combo()
	target = GetWeakEnemy('MAGIC', 550)
	target2 = GetWeakEnemy('MAGIC', 1275)
	if target ~= nil then
		if GetDistance(target) <= 550 then
			if CfgFizzSettings.useItems1 then cconnItems() end
			if CfgFizzSettings.useW1 then castSeastoneTrident(target) end
			if CfgFizzSettings.useQ1 then castUrchinStrike(target) end
			if CfgFizzSettings.useR1 then castChumTheWaters(target2) end
			if CfgFizzSettings.useE1 then castPlayful(target) end
			if CfgFizzSettings.useE1a then castTrickster(target) end
			--if CfgFizzSettings.useIgnite1 then castIgnite(target, CfgFizzControls.valAllIn) end
			--if CfgFizzSettings.useExhaust1 then castExhaust(target, CfgFizzControls.valAllIn) end
			if CfgFizzSettings.useIgnite1 then SummonerIgniteCombo(CfgFizzControls.valAllIn) end
			if CfgFizzSettings.useExhaust1 then SummonerExhaustCombo(CfgFizzControls.valAllIn) end
			if CfgFizzSettings.useAA1 then AttackTarget(target) end
		end
		if CfgFizzSettings.useMoveToMouse1 then MoveToMouse() end
	else 
		if CfgFizzSettings.useMoveToMouse1 then MoveToMouse() end
	end
end
--[[
		MANUAL HARASS FUNCTION
		
		This function will harass the target champion.
		It will not use ultimate, active items, or summoner spells
		
		DISABLED AT THIS TIME - FOR FUTURE RELEASE
]]
function Harass()
	target = GetWeakEnemy('MAGIC', 550)
	if target ~= nil then
		if GetDistance(target) <= 550 then
			if CfgFizzSettings.useW5 then castSeastoneTrident(target) end
			if CfgFizzSettings.useQ5 then castUrchinStrike(target) end
			if CfgFizzSettings.useE5 then castPlayful(target) end
			if CfgFizzSettings.useE5a then castTrickster(target) end
			if CfgFizzSettings.useAA5 then AttackTarget(target) end
		end
		if CfgFizzSettings.useMoveToMouse1 then MoveToMouse() end
	else 
		if CfgFizzSettings.useMoveToMouse1 then MoveToMouse() end
	end
end
--[[
		AUTO HARASS FUNCTION
		
		This function will automatically use selected skills on
		any enemy champion within range as long as your mana
		is above the defined theshold.
		Will not use ultimate, active items or summoner spells
]]
function autoHarass()
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			if  myHero.mana >= CfgFizzSettings.ahThreshold then
				if CfgFizzSettings.useW5 then castSeastoneTrident(enemy) end
				if CfgFizzSettings.useQ4 then castUrchinStrike(enemy) end
				if CfgFizzSettings.useE4 then castPlayful(enemy) end
				if CfgFizzSettings.useE4a then castTrickster(enemy) end
			end
		end
	end
end
--[[
		Q: URCHIN STRIKE
		
		Will cast Q if it is not on cooldown, you have enough mana,
		there is a target, and the target is within range of the ability
]]
function castUrchinStrike(Target)
	if myHero.SpellTimeQ > 1.0 and --[[myHero.mana >= 45+(myHero.SpellLevelQ*5) and]] Target ~= nil and GetDistance(myHero, Target) <= 550 then
		CastSpellTarget('Q',Target)
	end
end
--[[
		W: SEASTONE TRIDENT
		
		Will cast W if it is not on cooldown, you have enough mana,
		there is a target, and the target is within range of Q
]]
function castSeastoneTrident(Target)
	if myHero.SpellTimeW > 1.0 and myHero.mana >= 40 and Target ~= nil and GetDistance(myHero, Target) <= 550 then
		CastSpellTarget('W',myHero)
	end
end
--[[
		E: PLAYFUL
		
		Will cast E if it is off cooldown, you have enough mana,
		there is a target, and the target is within range of the spell.
		
		After casting E it will set a timer that is used to track how long
		you have to cast Trickster before Playful is cancelled.
]]
function castPlayful(Target)
	if myHero.SpellTimeE >= 1.0 and myHero.mana >= (80+(myHero.SpellLevelE*10)) and Target ~= nil and GetDistance(myHero, Target) <= 400 then
		CastSpellTarget('E',Target)
		timerPlayful = GetClock()
	end
end
--[[
		E: TRICKSTER
		
		Will cast E if it is off cooldown, the timer that tracks when Playful
		was last cast was reset less than 0.75 seconds ago,
		there is a target, and the target is within range of the spell.
]]
function castTrickster(Target)
	if myHero.SpellTimeE >= 1.0 and GetClock() <= timerPlayful + 750 and Target ~= nil and GetDistance(myHero, Target) <= 400 then
		CastSpellTarget('E',Target)
	end
end
--[[
		R: CHUM THE WATERS
		
		Will cast R if is is off cooldown, you have enough mana,
		there is a target, and the target is within range of the spell
]]
function castChumTheWaters(Target)
	if myHero.SpellTimeR >= 1.0 and myHero.mana >= 100 and Target ~= nil and GetDistance(myHero, Target) <= 1275 then
		CastSpellXYZ('R',GetFireahead(Target,2,14))
	end
end
--[[
		R: CHUM THE WATERS
		ADVANCED MEC FUNCTION
		
		Will look for the best XYZ position to cast R on that can hit the
		minimum number of enemy champions specified within the menu options.
]]
function mecChumTheWaters(Value) --New R Function: will auto R if it will hit x number of enemies specified in menu
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			ultPos = GetMEC(250, 1275, enemy)
			if ultPos and GetDistance(ultPos) < 1275 and CountUnit(ultPos,250) >= Value then
				if  myHero.SpellLevelR >= 1 and myHero.SpellTimeR > 1.0 and myHero.mana >= 100 then
					CastSpellXYZ('R', ultPos.x, 0, ultPos.z)
				end
			end
		end
	end
end
--[[
		For loop that will populate the Enemies Table with the name of
		all enemy champions within the game. This table is used
		by the Roam Helper draw function.
]]
for i = 1, objManager:GetMaxHeroes(), 1 do
	Hero = objManager:GetHero(i)
	if Hero ~= nil and Hero.team ~= myHero.team then
		if Enemies[Hero.name] == nil then
			Enemies[Hero.name] = { Unit = Hero, Number = EnemyIndex }
			EnemyIndex = EnemyIndex + 1
		end
	end
end
--[[
		FARMING: FARM MODE
		
		Last hits creep only - will ignore enemy champions
]]
function farmMode()
	local tlow = GetLowestHealthEnemyMinion(myHero.range)
    
	if tlow ~= nil and tlow.health <= (myHero.baseDamage + myHero.addDamage) then
		target = tlow
    end   
    if target ~= nil then
        if (myHero.baseDamage + myHero.addDamage) >= target.health then
            AttackTarget(target)
		end
    else
        if CfgFizzSettings.useMoveToMouse2 then MoveToMouse() end
    end
	if CfgFizzSettings.useMoveToMouse2 then MoveToMouse() end
end
--[[
		FARMING: MIXED MODE
		
		Last hits creep and will attack enemy champions within range
]]
function mixedMode()
    local targetHero = GetWeakEnemy("MAGIC",550)
	local tlow = GetLowestHealthEnemyMinion(myHero.range)
    
	if tlow ~= nil and tlow.health <= (myHero.baseDamage + myHero.addDamage) then
		target = tlow
	elseif targetHero ~= nil then
        target = targetHero
		if CfgFizzSettings.useW2 then castSeastoneTrident(target) end
		if CfgFizzSettings.useQ2 then castUrchinStrike(target) end
		if CfgFizzSettings.useE1 then castPlayful(target) end
		if CfgFizzSettings.useE1a then castTrickster(target) end
    else 
        target = GetLowestHealthEnemyMinion(range) 
    end   
    if target ~= nil then
        if (myHero.baseDamage + myHero.addDamage) >= target.health then
            AttackTarget(target)
		end
    else
        if CfgFizzSettings.useMoveToMouse2 then MoveToMouse() end
    end
	if CfgFizzSettings.useMoveToMouse2 then MoveToMouse() end
end
--[[
		FARMING: LANE CLEAR
		
		Will last hit creep if able to. If creep health is too high
		to last it then the target changes to the highest health minion
		until one can be last hit.
		
		Option to last hit with Urchin Strike and use Playful Trickster
		if it can hit more than 2 enemy creep.
]]
function laneClear()
    local tlow=GetLowestHealthEnemyMinion(myHero.range) 
    local thigh=GetHighestHealthEnemyMinion(myHero.range)
	local targetHero = GetWeakEnemy("MAGIC",550)

    if tlow~= nil then 
		if (myHero.baseDamage + myHero.addDamage) >= tlow.health then
			target = tlow
			CustomCircle(100,20,1,target)
		elseif getDmg("Q",tlow,myHero) >= tlow.health then
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
        if (myHero.baseDamage + myHero.addDamage) >= target.health then
				AttackTarget(target)
		elseif
			CfgFizzSettings.useQ3 and getDmg("Q",target,myHero) >= target.health then
				castUrchinStrike(target)
		else
		CastHotkey('AUTO 100,0 ATTACK:WEAKMINION PATROLSTRAFE')
			if CfgFizzSettings.useW3 then
				if target == thigh then
					local EPos = GetMEC(270, 400, target)
					if EPos and CountCreep(EPos, 270) > 2 then
						CastSpellXYZ("E", EPos.x, 0, EPos.z)
						timerPlayful = GetClock()
						if GetClock() <= timerPlayful + 750 then
							CastSpellXYZ("E", EPos.x, 0, EPos.z)
						end
					end
				end
			end
		end
		AttackTarget(target)
    else
    if CfgFizzSettings.useMoveToMouse3 then MoveToMouse() end
    end
	if CfgFizzSettings.useMoveToMouse3 then MoveToMouse() end
end
--[[
		DRAW FUNCTION
		
		All drawing related functions are housed within this function.
		It includes: 
			spell ranges
			XP range
			target indicator circle
			Roam Helper
			Combo Circles
]]
function Draw()
	if CfgFizzDrawSettings.drawQRange and myHero.SpellLevelQ > 0.00 and myHero.SpellTimeQ > 1.0 then CustomCircle(550,2,4,myHero) end
	--if myHero.SpellLevelW > 0.00 and myHero.SpellTimeW > 1.0 then CustomCircle(CfgSettings.WRNG,2,4,myHero) end  
	--if myHero.SpellLevelE > 0.00 and myHero.SpellTimeE > 1.0 then CustomCircle(700,2,4,myHero) end  --[[change this to only show up when trickster is available]]
	if CfgFizzDrawSettings.drawRRange and myHero.SpellLevelR > 0.00 and myHero.SpellTimeR > 1.0 then CustomCircle(1275,2,4,myHero) end
	if CfgFizzDrawSettings.drawXPRange then CustomCircle(1700,2,4,myHero) end
	if CfgFizzDrawTargetIndicator and target ~= nil then CustomCircle(100,10,1,target) end
	if CfgFizzDrawSettings.drawRoamHelper then
		for i, Enemy in pairs(Enemies) do
			if Enemy ~= nil then
				Hero = Enemy.Unit
				local PositionX = (13.3/16) * GetScreenX()
				local QDMG = getDmg('Q', Hero, myHero)--+(getDmg('Q',Hero,myHero)*(HavocDamage + ExecutionerDamage))
				local WDMG = getDmg('W', Hero, myHero)--+(getDmg('W',Hero,myHero)*(HavocDamage + ExecutionerDamage))
				local EDMG = getDmg('E', Hero, myHero)--+(getDmg('E',Hero,myHero)*(HavocDamage + ExecutionerDamage))
				local RDMG = getDmg('R', Hero, myHero)--+(getDmg('R',Hero,myHero)*(HavocDamage + ExecutionerDamage))
				local Current_Burst
				local Damage
				if myHero.selflevel >= 6 and myHero.SpellTimeR > 1.0 then
					Current_Burst = Round(QDMG + WDMG + RDMG, 0)
				else
					Current_Burst = Round(QDMG + WDMG, 0)
				end
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					Current_Burst = Current_Burst + ((myHero.selflevel*20)+50)
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
	if CfgFizzDrawSettings.drawComboCircles then
		for i = 1, objManager:GetMaxHeroes()  do
		local enemy = objManager:GetHero(i)
			if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable==0 and enemy.dead == 0) then
			local qdmg = getDmg('Q', Hero, myHero)--+(getDmg('Q',Hero,myHero)*(HavocDamage + ExecutionerDamage))
			local wdmg = getDmg('W', Hero, myHero)--+(getDmg('W',Hero,myHero)*(HavocDamage + ExecutionerDamage))
			local edmg = getDmg('E', Hero, myHero)--+(getDmg('E',Hero,myHero)*(HavocDamage + ExecutionerDamage))
			local rdmg = getDmg('R', Hero, myHero)--+(getDmg('R',Hero,myHero)*(HavocDamage + ExecutionerDamage))
			local ignitedmg = (myHero.selflevel*20)+50
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 then
					if wdmg+qdmg+ignitedmg > enemy.health then CustomCircle(50,10,5,enemy) DrawTextObject("FISH FISH FISH!", enemy, Color.Red) end
				end
				if myHero.SpellTimeR > 1.0 then
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 and myHero.SpellTimeR > 1.0 then
						if wdmg+qdmg+rdmg+ignitedmg > enemy.health then CustomCircle(50,10,5,enemy) DrawTextObject("FISH FISH FISH!", enemy, Color.Red) end
					end
				end
				if myHero.SpellTimeR > 1.0 and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 then
					if wdmg+qdmg+rdmg > enemy.health then CustomCircle(50,10,5,enemy) DrawTextObject("FISH FISH FISH!", enemy, Color.Red) end
				end
			end
		end
	end
end
--[[
		ROUND FUNCTION
		
		Will round any arguments passed to the function
]]
function Round(val, decimal)
	if (decimal) then
		return math.floor( (val * 10 ^ decimal) + 0.5) / (10 ^ decimal)
	else
		return math.floor(val + 0.5)
	end
end
--[[
		COUNT UNIT FUNCTION
		
		Will count the number of enemy champions within a radius of a center point
		The center point and radius are arguments passed to the function
		Will only count enemy champions that are: Visible, NOT Invulnurable, and Alive
]]
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
--[[
		COUNT CREEP FUNCTION
		
		Will count the number of enemy creep within a radius of a center point
		The center point and radius are arguments passed to the function
]]
function CountCreep(Center,Radius)
	local CreepCount = 0
	for i = 1, objManager:GetMaxCreatures()  do
    	local creep = objManager:GetCreature(i)
    	if (nil ~= nil and creep.team ~= myHero.team and creep.visible == 1 and creep.dead == 0) then
			if GetDistance(creep,Center) < Radius then
				CreepCount = CreepCount + 1
			end
		end
	end
	return CreepCount
end
--[[
		CCONN ITEMS FUNCTION
		
		This function links the script menu options to the casting
		of the individual active item functions below it.
]]
function cconnItems()
	if CfgFizzItemSettings.useBFT then useBFT(CfgFizzControls.valAllIn) end
	if CfgFizzItemSettings.useDFG then useDFG(CfgFizzControls.valAllIn) end
	if CfgFizzItemSettings.useFQC then useFQC(CfgFizzControls.valAllIn, target) end
	if CfgFizzItemSettings.useHGB then useHGB(CfgFizzControls.valAllIn) end
	if CfgFizzItemSettings.useSeraph then useSeraph(CfgFizzControls.valEmergency) end
	if CfgFizzItemSettings.useTwinShadows then useTwinShadows(CfgFizzControls.valAllIn, 1275) end
	if CfgFizzItemSettings.useWWC then useWWC(CfgFizzControls.valEmergency) end
	if CfgFizzItemSettings.useZHG then useZHG(CfgFizzControls.valEmergency) end
end
--[[
		BLACKFIRE TORCH
]]
function useBFT(Value)
local cdTimer = 0
	if target ~= nil and target.health <= target.maxHealth * (Value / 100) and GetClock() > cdTimer + 60000 and GetDistance(target) <= 750 then
		GetInventorySlot(3188)
		UseItemOnTarget(3188,target)
		local cdTimer = GetClock()
	end
end
--[[
		DEATHFIRE GRASP
]]
function useDFG(Value)
local cdTimer = 0
	if target ~= nil and target.health <= target.maxHealth * (Value / 100) and GetClock() > cdTimer + 60000 and GetDistance(target) <= 750 then
		GetInventorySlot(3128)
		UseItemOnTarget(3146,target)
		local cdTimer = GetClock()
	end
end
--[[
		FROST QUEEN'S CLAIM (600 range)
]]
function useFQC(Value, Target)
local cdTimer = 0
	if target.health <= Target.maxHealth * (Value / 100) and GetClock() > cdTimer + 60000 and GetDistance(Target) <= 600 then
		GetInventorySlot(3092)
		UseItemOnTarget(3092,target)
		local cdTimer = GetClock()
	end
end
--[[
		HEXTECH GUNBLADE
]]
function useHGB(Value)
local cdTimer = 0
	if target ~= nil and target.health <= target.maxHealth * (Value / 100) and GetClock() > cdTimer + 60000 and GetDistance(target) <= 700 then
		GetInventorySlot(3146)
		UseItemOnTarget(3146,target)
		local cdTimer = GetClock()
	end
end
--[[
		SERAPH'S EMBRACE
]]
function useSeraph(Value)
local cdTimer = 0
	if myHero.health <= myHero.maxHealth * (Value / 100) and GetClock() > cdTimer + 120000 then
		GetInventorySlot(3040)
		UseItemOnTarget(3040,myHero)
		local cdTimer = GetClock()
	end
end
--[[
		TWIN SHADOWS (Max Range 2700)
]]
function useTwinShadows(Value,Range)
local cdTimer = 0
	if target ~= nil and target.health <= target.maxHealth * (Value / 100) and GetClock() > cdTimer + 60000 and GetDistance(target) <= Range then
		GetInventorySlot(3023)
		UseItemOnTarget(3023,target)
		local cdTimer = GetClock()
	end
end
--[[
		WOOGLET'S WITCHCAP
]]
function useWWC(Value)
local cdTimer = 0
	if myHero.health <= myHero.maxHealth * (Value / 100) and GetClock() > cdTimer + 90000 then
		GetInventorySlot(3090)
		UseItemOnTarget(3090,myHero)
		local cdTimer = GetClock()
	end
end
--[[
		ZHONYA'S HOURGLASS
]]
function useZHG(Value)
local cdTimer = 0
	if myHero.health <= myHero.maxHealth * (Value / 100) and GetClock() > cdTimer + 90000 then
		GetInventorySlot(3157)
		UseItemOnTarget(3157,myHero)
		local cdTimer = GetClock()
	end
end
--[[
		MASTERY RELATED FUNCTIONS
		
		These functions calculate the bonuses granted from masteries
		and assign them to a variable that can be used in a damage calculation.
		
		Supported Masteries:
			Double Edged Sword
			Brute Force
			Martial
			Warlord
			Mental Force
			Arcane Mastery
			Arch Mage
			Butcher
			Executioner
			Arcane Blade
]]
--[[

		DISABLED CURRENTLY
	

local mastDES = calcDoubleEdgedSword(CfgFizzMasterySettings.valDoubleEdgedSword)

function calcDoubleEdgedSword(value) --% total damage increase
	if value == 2 then
		return 0.02
	else
		return 0
	end
end

local mastBF = calcBruteForce(CfgFizzMasterySEttings.valBruteForce)

function calcBruteForce(value) --AD per lvl increase
	if value == 2 then
		return (myHero.SelfLevel * 0.22)
	elseif value == 3 then
		return (myHero.SelfLevel * 0.39)
	elseif value == 4 then
		return (myHero.SelfLevel * 0.55)
	else
		return 0
	end
end

local mastMartial = calcMartial(CfgFizzMasterySettings.valMartial)

function calcMartial(value) --Flat AD Increase
	if value == 2 then
		return 4
	else
		return 0
	end
end

local mastWarlord = calcWarlod(CfgFizzMasterySettings.valWarlord)

function calcWarlord() --Bonus AD
	if value == 2 then
		return (myHero.addDamage * .02)
	elseif value == 3 then
		return (myHero.addDamage * .035)
	elseif value == 4 then
		return (myHero.addDamage * .05)
	else
		return 0
	end
end

local mastMentalForce = calcMentalForce(CfgFizzMasterySettings.valMentalForce)

function calcMentalForce(value) --AP per level increase
	if value == 2 then
		return (myHero.SelfLevel * 0.33)
	elseif value == 3 then
		return (myHero.SelfLevel * 0.61)
	elseif value == 4 then
		return (myHero.SelfLevel * 0.89)
	else
		return 0
	end
end

local mastArcaneMastery = calcArcaneMastery(CfgFizzMasterySettings.valArcaneMastery)

function calcArcaneMastery(value) --Flat AP increase
	if value == 2 then
		return 6
	else
		return 0
	end
end

local mastArchMage = calcArchMage(CfgFizzMasterySettings.valArchMage)

function calcArchMage(value) --% Total AP Increase
	if value == 2 then
		return 0.02
	elseif value == 3 then
		return 0.035
	elseif value == 4 then
		return 0.05
	else
		return 0
	end
end

local mastButcher = calcButcher(CfgFizzMasterySettings.valButcher)

function calcButcher(value) --Flat damage bonus to AD and Single Target spells against minions / monsters only
	if value == 2 then
		return 2
	else
		return 0
	end
end

local mastExecutionerHP = calcExecutioner(CfgFizzMasterySettings.valExecutioner)

function calcExecutioner(value) --% Damage increase to champions below X% health
	if value == 2 then
		return .20
	elseif value == 3 then
		return .35
	elseif value == 4 then
		return .50
	end
end

local mastArcaneBlade = calcArcaneBlade(CfgFizzMasterySettings.ArcaneBlade)

function calcArcaneBlade(value) --Basic attack increase by % of AP
	if value == 1 then
		return (myHero.ap * .05)
	else
		return 0
	end
end
]]
--[[
		SUMMONER SPELL FUNCTIONS
]]
function SummonerSpells()
	SummonerBarrier(CfgFizzControls.valEmergency)
	SummonerHeal(CfgFizzControls.valEmergency)
	SummonerClarity()
end

function SummonerIgniteCombo(Value)
	if target ~= nil then
		if myHero.SummonerD == 'SummonerDot' then
			if target.health <= target.maxHealth*(Value / 100) then
				CastSpellTarget('D',target)
			end
		end
		if myHero.SummonerF == 'SummonerDot' then
			if target.health <= target.maxHealth*(Value / 100) then
				CastSpellTarget('F',target)
			end
		end
	end
end

function SummonerExhaustCombo(Value)
	if target ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if target.health <= target.maxHealth*(Value / 100) then
				CastSpellTarget('D',target)
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if target.health <= target.maxHealth*(Value / 100) then
				CastSpellTarget('F',target)
			end
		end
	end
end

function SummonerBarrier(Value)
	if myHero.SummonerD == 'SummonerBarrier' then
		if myHero.health < myHero.maxHealth*(Value / 100) then
			CastSpellTarget('D',myHero)
		end
	end
	if myHero.SummonerF == 'SummonerBarrier' then
		if myHero.health < myHero.maxHealth*(Value / 100) then
			CastSpellTarget('F',myHero)
		end
	end
end

function SummonerHeal(Value)
	if myHero.SummonerD == 'SummonerHeal' then
		if myHero.health < myHero.maxHealth*(Value / 100) then
			CastSpellTarget('D',myHero)
		end
	end
	if myHero.SummonerF == 'SummonerHeal' then
		if myHero.health < myHero.maxHealth*(Value / 100) then
			CastSpellTarget('F',myHero)
		end
	end
end

function SummonerClarity()
	if myHero.SummonerD == 'SummonerMana' then
		if myHero.mana < myHero.maxMana*(50 / 100) then
			CastSpellTarget('D',myHero)
		end
	end
	if myHero.SummonerF == 'SummonerMana' then
		if myHero.mana < myHero.maxMana*(50 / 100) then
			CastSpellTarget('F',myHero)
		end
	end
end
--[[
		SUMMONER SPELL FUNCTIONS
		From Dasia's Summoner Spells
		
		These functions populate a table identifying which key
		a summoner spell is mapped to. After the table is populated
		the summoner spells may be cast from the functions below it.
		Each summoner spell is linked to a threshhold value spcified
		within the summoner spells settings menu.
		
		DISABLED AT THIS TIME - FOR FUTURE RELEASE
]]
local summonerSpells = {
  Clarity = { Key = nil, Match = "SummonerMana",    Spell = "Clarity" },
  Heal    = { Key = nil, Match = "SummonerHeal",    Spell = "Heal"    },
  Smite   = { Key = nil, Match = "SummonerSmite",   Spell = "Smite"   },
  Cleanse = { Key = nil, Match = "SummonerBoost",   Spell = "Cleanse" },
  Barrier = { Key = nil, Match = "SummonerBarrier", Spell = "Barrier" },
  Exhaust = { Key = nil, Match = "SummonerExhaust", Spell = "Exhaust" },
  Ignite  = { Key = nil, Match = "SummonerDot",     Spell = "Ignite"  }
}

function updateSummoners()
	for s,summoner in pairs(summonerSpells) do
		if myHero.SummonerD == summoner.Match then
			summoner.Key = "D"
			summonerD = s
		elseif myHero.SummonerF == summoner.Match then
			summoner.Key = "F"
			summonerF = s
		end
	end
end

function castIgnite(Target, Value)
	local key = tostring(summonerSpells["Ignite"].Key)
	if IsSpellReady(key) == 1 then
		if Target ~= nil and Target.health < Value then
			CastSpellTarget(key, Target)
		end
	end
end

function castExhaust(Target, Value)
	local threshold = Value
	local key = tostring(summonerSpells["Exhaust"].Key)
	if IsSpellReady(key) == 1 then
		if Target ~= nil and Target.health < threshold then
		CastSpellTarget(key, Target)
		end
	end
end

function castBarrier(Value)
	local threshold = Value
	local key = tostring(summonerSpells["Barrier"].Key)
	if IsSpellReady(key) == 1 then
		if myHero.health <= threshold then
			CastSpellTarget(key, myHero)
		end
	end
end

function castHeal(Value)
	local threshold = Value
	local amount = 75 + (15 * myHero.selflevel)
	local key = tostring(summonerSpells["Heal"].Key)
	if myHero.health <= threshold then
		if IsSpellReady(key) == 1 then
			CastSpellTarget(key, myHero)
		end
	end
end

function castClarity(Value)
	local threshold = Value
	local amount = math.round(myHero.maxMana * 0.4)
	local key = tostring(summonerSpells["Clarity"].Key)
	if myHero.mana <= threshold then
		if IsSpellReady(key) == 1 then
			CastSpellTarget(key, myHero)
		end
	end
end
--[[
		CCONN'S AUTO POT FUNCTIONS
		Based on Red Elixir by Kyuuketsuuki
		
		Supported Consumables:
			Health Potion
			Mana Potion
			Chrystalline Flask
			Elixir of Fortitude
]]
local bluePill = nil
local pot1Timer = 0
local pot2Timer = 0
local pot3Timer = 0

function usePotion(Value)
	if bluePill == nil then
		if myHero.health <= myHero.maxHealth * (Value / 100) and GetClock() > pot1Timer + 15000 then
			GetInventorySlot(2003)
			UseItemOnTarget(2003,myHero)
			GetInventorySlot(2010)
			UseItemOnTarget(2010,myHero)
			pot1Timer = GetTick()
		end
	end
end

function useManaPot(Value)
	bpReset()
	if bluePill == nil then
		if myHero.mana <= myHero.maxMana * (Value / 100) and GetClock() > pot2Timer + 15000 then
			GetInventorySlot(2004)
			UseItemOnTarget(2004,myHero)
			pot2Timer = GetTick()
		end
	end
end

function useFlask(Value)
	bpReset()
	if bluePill == nil then
		if myHero.health <= myHero.maxHealth * (Value / 100) and GetClock() > pot3Timer + 10000 then
			GetInventorySlot(2041)
			UseItemOnTarget(2041,myHero)
			pot3Timer = GetTick()
		end
	end
end

function useElixir(Value)
	bpReset()
	if bluePill == nil then
		if myHero.health <= myHero.maxHealth * (Value / 100) then
			GetInventorySlot(2037)
			UseItemOnTarget(2037,myHero)
		end
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

function bpReset()
	if os.clock() < timerBP + 5000 then
		bluePill = nil
	end
end

function GetTick()
	return GetClock()
end
--[[
		KILL STEAL FUNCTION
		
		Supported Kill Steal Combos:
			Q
			W+Q
			R
]]
function KillSteal()
    for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable==0 and enemy.dead == 0) then
    		local qdmg = getDmg("Q",enemy,myHero)
			local wdmg = getDmg("W",enemy,myHero)
    		local edmg = getDmg("E",enemy,myHero)
			local rdmg = getDmg("R",enemy,myHero)
			local ignitedmg = (myHero.selflevel*20)+50
        	if CfgFizzKSSettings.useQKS then
        		if qdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.mana > (45+(myHero.SpellLevelQ*5)) and GetDistance(myHero,enemy) <= 550 then
        		    castUrchinStrike(enemy)
				end
			end
			if CfgFizzKSSettings.useWQKS then
				if wdmg + qdmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeQ > 1.0 and myHero.mana >= ((45+(myHero.SpellLevelQ*5))+40) and GetDistance(myHero,enemy) <= 550 then
        		    castSeastoneTrident(myHero)
					castUrchinStrike(enemy)
				end
			end
			if CfgFizzKSSettings.useRKS then
				if rdmg > enemy.health and myHero.SpellTimeR > 1.0 and myHero.mana >= 100 and GetDistance(myHero,enemy) <= 1275 then
					castChumTheWaters(enemy)
				end
			end
		end
	end
end
--[[
		AUTO LEVEL SPELLS V1.2.2
		by PedobearIGER
		
		Linked to menu options to select an ability profile
		Current Profiles:
			Max W first
			Max E first
]]
local skillingOrder = {
	MaxW = {E,W,Q,W,W,R,W,E,W,E,R,E,E,Q,Q,R,Q,Q},
    MaxE = {Q,E,W,E,E,R,E,Q,E,Q,R,Q,Q,W,W,R,W,W},
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

function AutoLevelSpells()
    if CfgFizzAutoLevelSettings.onoff_AutoLevelSpells and IsLolActive() and IsChatOpen() == 0 then
        local spellLevelSum = myHero.SpellLevelQ + myHero.SpellLevelW + myHero.SpellLevelE + myHero.SpellLevelR
        if attempts <= 10 or (attempts > 10 and GetTickCount() > lastAttempt+1500) then
            if spellLevelSum < myHero.selflevel then
                if lastSpellLevelSum ~= spellLevelSum then attempts = 0 end
                if CfgFizzAutoLevelSettings.valSkillOrder == 1 then letter = skillingOrder["MaxW"][spellLevelSum+1] end
				if CfgFizzAutoLevelSettings.valSkillOrder == 2 then letter = skillingOrder["MaxE"][spellLevelSum+1] end
				
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
--[[
		Show & Dodge Skillshots V1.4 Beta
		Kept updated by Valdorian
		
		Modifed slightly by CCONN for Fizz
		Menu options added to dodge skillshots with Playful Trickster
		if Playful Trickster is on Cooldown or you don't have enough mana
		will dodge by moving as normal.
		
		This function has it's own Callback Timer to allow it to run independent of
		the core script function.
]]
function PlayfulDodge()
	send.tick()
	cc=cc+1
	if cc==30 then LoadTable() end
	for i=1, #skillshotArray, 1 do
		if os.clock() > (skillshotArray[i].lastshot + skillshotArray[i].time) then
			skillshotArray[i].shot = 0
		end
	end
	Skillshots()
end

function MakeStateMatch(changes)
    for scode,flag in pairs(changes) do    
        local vk = winapi.map_virtual_key(scode, 3)
        local is_down = winapi.get_async_key_state(vk)
        if flag then
            if is_down then
                send.wait(60)
                send.key_down(scode)
                send.wait(60)
            else
            end            
        else
            if is_down then
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
	local calc = (math.floor(math.sqrt((pos2.x-myHero.x)^2 + (pos2.z-myHero.z)^2)))
	local dodgex
	local dodgez
	dodgex = pos2.x + ((radius+50)/calc)*(myHero.x-pos2.x)
	dodgez = pos2.z + ((radius+50)/calc)*(myHero.z-pos2.z)
	if calc < radius and CfgFizzDodgeSettings.DodgeSkillShotsAOE == true and GetCursorX() > xa and GetCursorX() < xb and GetCursorY() > ya and GetCursorY() < yb then
		if CfgFizzDodgeSettings.BlockSettingsAOE == 1 then
			send.block_input(true,CfgFizzDodgeSettings.BlockTime)
				if CfgFizzDodgeSettings.dodgeAOEPlayfulTrickster and myHero.SpellTimeE > 1.0 and myHero.mana >= (80+(myHero.SpellLevelE*10)) then
					CastSpellXYZ('E',dodgex,0,dodgez)
				else
					MoveToXYZ(dodgex,0,dodgez)
				end
		elseif CfgFizzDodgeSettings.BlockSettingsAOE == 2 then
			if CfgFizzDodgeSettings.dodgeAOEPlayfulTrickster and myHero.SpellTimeE > 1.0 and myHero.mana >= (80+(myHero.SpellLevelE*10)) then
					CastSpellXYZ('E',dodgex,0,dodgez)
				else
					MoveToXYZ(dodgex,0,dodgez)
			end
		end
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
	if perpendicular < radius and calc1 < calc4 and calc2 < calc4 and CfgFizzDodgeSettings.DodgeSkillShots == true and GetCursorX() > xa and GetCursorX() < xb and GetCursorY() > ya and GetCursorY() < yb then
		if CfgFizzDodgeSettings.BlockSettings == 1 then
			send.block_input(true,CfgFizzDodgeSettings.BlockTime)
			if CfgFizzDodgeSettings.dodgePlayfulTrickster and myHero.SpellTimeE > 1.0 and myHero.mana >= (80+(myHero.SpellLevelE*10)) then
					CastSpellXYZ('E',dodgex,0,dodgez)
				else
					MoveToXYZ(dodgex,0,dodgez)
				end
		elseif CfgFizzDodgeSettings.BlockSettings == 2 then
			if CfgFizzDodgeSettings.dodgePlayfulTrickster and myHero.SpellTimeE > 1.0 and myHero.mana >= (80+(myHero.SpellLevelE*10)) then
					CastSpellXYZ('E',dodgex,0,dodgez)
				else
					MoveToXYZ(dodgex,0,dodgez)
				end
		end
	end
end

function dodgelinepass(pos1, pos2, radius, maxDist)
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
	if perpendicular < radius and calc1 < calc4 and calc2 < calc4 and CfgFizzDodgeSettings.DodgeSkillShots == true and GetCursorX() > xa and GetCursorX() < xb and GetCursorY() > ya and GetCursorY() < yb then
		if CfgFizzDodgeSettings.BlockSettings == 1 then
			send.block_input(true,CfgFizzDodgeSettings.BlockTime)
			if CfgFizzDodgeSettings.dodgePlayfulTrickster and myHero.SpellTimeE > 1.0 and myHero.mana >= (80+(myHero.SpellLevelE*10)) then
					CastSpellXYZ('E',dodgex,0,dodgez)
				else
					MoveToXYZ(dodgex,0,dodgez)
				end
		elseif CfgFizzDodgeSettings.BlockSettings == 2 then
			if CfgFizzDodgeSettings.dodgePlayfulTrickster and myHero.SpellTimeE > 1.0 and myHero.mana >= (80+(myHero.SpellLevelE*10)) then
					CastSpellXYZ('E',dodgex,0,dodgez)
				else
					MoveToXYZ(dodgex,0,dodgez)
				end
		end
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

function Skillshots()
	if CfgFizzDrawSettings.drawSkillShots == true then
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
end

function LoadTable()
	for i = 1, objManager:GetMaxHeroes() do
		local enemy = objManager:GetHero(i)
		if (enemy ~= nil and enemy.team ~= myHero.team) then
			if enemy.name == 'Aatrox' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 650, type = 3, radius = 225, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 125, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
			end
			if enemy.name == 'Ahri' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 880, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 975, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
			end
			if enemy.name == 'Alistar' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 50, type = 3, radius = 200, color= 0x0000FFFF, time = 0.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
			end
			if enemy.name == 'Amumu' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
			end
			if enemy.name == 'Anivia' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 90, color= 0x0000FFFF, time = 2, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
			end
			if enemy.name == 'Annie' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 3, radius = 300, color= 0x0000FFFF, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
			end
			if enemy.name == 'Ashe' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 50000, type = 4, radius = 120, color= 0x0000FFFF, time = 4, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
			end
			if enemy.name == 'Blitzcrank' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 925, type = 1, radius = 120, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
			end
			if enemy.name == 'Brand' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1050, type = 1, radius = 50, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0})
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 250, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Cassiopeia' then
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 850, type = 3, radius = 175, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 850, type = 3, radius = 125, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Caitlyn' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 50, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Corki' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1225, type = 1, radius = 100, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 800, type = 2, radius = 150, color= 0x0000FFFF, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Chogath' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 3, radius = 275, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Darius' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 540, type = 1, radius = 125, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Diana' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 1, radius = 205, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Draven' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1050, type = 1, radius = 125, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 5000, type = 1, radius = 100, color= 0x0000FFFF, time = 4, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'DrMundo' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Elise' and enemy.range>300 then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1075, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Ezreal' then
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 1, radius = 100, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 5000, type = 4, radius = 150, color= 0x0000FFFF, time = 4, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'FiddleSticks' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 800, type = 3, radius = 600, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Fizz' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 400, type = 3, radius = 300, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })				
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 550, type = 1, radius = 100, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1275, type = 2, radius = 100, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Galio' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 905, type = 3, radius = 200, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 120, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Gragas' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 3, radius = 320, color= 0xFFFFFF00, time = 2.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 650, type = 2, radius = 60, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1050, type = 3, radius = 400, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Graves' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 110, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 750, type = 1, radius = 50, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 3, radius = 275, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Hecarim' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 125, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Heimerdinger' then
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 100, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 3, radius = 225, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			--[[if enemy.name == 'Irelia' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1200, type = 1, radius = 80, color= 0x0000FFFF, time = 0.8, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end]]
			if enemy.name == 'Janna' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1700, type = 1, radius = 100, color= 0x0000FFFF, time = 2, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'JarvanIV' then
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 830, type = 3, radius = 150, color= 0xFFFFFF00, time = 2, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 770, type = 1, radius = 70, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Jayce' and enemy.range>300 then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1500, type = 1, radius = 125, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Jinx' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 1, radius = 100, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1500, type = 1.5, radius = 100, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 5000, type = 3, radius = 225, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Karma' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 1, radius = 100, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Karthus' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 875, type = 3, radius = 150, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Kassadin' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 5, radius = 150, color= 0xFF00FF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Kennen' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1050, type = 1, radius = 75, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Khazix' then	
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 75, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })	
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 310, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'KogMaw' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1115, type = 1, radius = 100, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 2200, type = 3, radius = 200, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Leblanc' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 3, radius = 250, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'LeeSin' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 975, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Leona' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 1, radius = 160, color= 0x0000FFFF, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 1, radius = 100, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Lissandra' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 725, type = 1, radius = 100, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1050, type = 1, radius = 120, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Lucian' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 100, color= 0x0000FFFF, time = 0.75, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 150, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Lulu' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 925, type = 1, radius = 50, color= 0x0000FFFF, time = 1, isline = true, px =0, py =0 , pz =0, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Lux' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1175, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 3, radius = 300, color= 0xFFFFFF00, time = 2.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 3000, type = 1, radius = 80, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Malphite' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 3, radius = 325, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Malzahar' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 100 , color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 800, type = 3, radius = 250 , color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Maokai' then
				table.insert(skillshotArray,{name= 'MaokaiTrunkLineMissile', shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 1, radius = 100, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 3, radius = 350 , color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'MissFortune' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 800, type = 3, radius = 400, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Morgana' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1300, type = 1, radius = 100, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 350, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Nami' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 875, type = 3, radius = 210, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 2750, type = 1, radius = 335, color= 0xFFFFFF00, time = 3, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Nautilus' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 1, radius = 80, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Nidalee' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1500, type = 1, radius = 80, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Nocturne' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1200, type = 1, radius = 80, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Olaf' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 2, radius = 100, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Orianna' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 825, type = 3, radius = 150, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Quinn' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1025, type = 1, radius = 150, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Renekton' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 450, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Rumble' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 100, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1700, type = 1, radius = 100, color= 0xFFFFFF00, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Sejuani' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1150, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = f, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Shen' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 2, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Shyvana' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 925, type = 1, radius = 80, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Sivir' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 100, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Skarner' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 1, radius = 100, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Sona' then
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 150, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Swain' then
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 265 , color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Syndra' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 800, type = 3, radius = 250, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 650, type = 1, radius = 100, color= 0xFFFFFF00, time = 0.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 3, radius = 210, color= 0x0000FFFF, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Thresh' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1075, type = 1, radius = 160, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Tristana' then
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 200, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Tryndamere' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 600, type = 2, radius = 100, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'TwistedFate' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1450, type = 1, radius = 100, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Urgot' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 1, radius = 80, color= 0x0000FFFF, time = 0.8, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 950, type = 3, radius = 300, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Varus' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1475, type = 1, radius = 50, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1075, type = 1, radius = 80, color= 0x0000FFFF, time = 1.5, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Veigar' then
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 225, color= 0xFFFFFF00, time = 2, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Vi' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 725, type = 1, radius = 75, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Viktor' then
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 700, type = 1, radius = 80, color= 0xFFFFFF00, time = 2})
			end
			if enemy.name == 'Xerath' then
				table.insert(skillshotArray,{name= 'xeratharcanopulsedamage', shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= 'xeratharcanopulsedamageextended', shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1300, type = 1, radius = 80, color= 0x0000FFFF, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
				table.insert(skillshotArray,{name= 'xeratharcanebarragewrapper', shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 250, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= 'xeratharcanebarragewrapperext', shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1300, type = 3, radius = 250, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
			end
			if enemy.name == 'Yasuo' then
				table.insert(skillshotArray,{name= 'YasuoQW', shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 475, type = 1, radius = 75, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= 'yasuoq2w', shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 475, type = 1, radius = 75, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= 'yasuoq3w', shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 1, radius = 125, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Zac' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 550, type = 1, radius = 100, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1550, type = 5, radius = 200, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Zed' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 1, radius = 55, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Ziggs' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 850, type = 3, radius = 160, color= 0xFFFFFF00, time = 1, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
				table.insert(skillshotArray,{name= enemy.SpellNameW, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1000, type = 3, radius = 225 , color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0  })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 900, type = 3, radius = 250, color= 0xFFFFFF00, time = 1, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameR, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 5300, type = 3, radius = 550, color= 0xFFFFFF00, time = 3, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
			if enemy.name == 'Zyra' then
				table.insert(skillshotArray,{name= enemy.SpellNameQ, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 825, type = 3, radius = 275, color= 0xFFFFFF00, time = 1.5, isline = false, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
				table.insert(skillshotArray,{name= enemy.SpellNameE, shot=0, lastshot = 0, skillshotpoint = {}, maxdistance = 1100, type = 1, radius = 90, color= 0x0000FFFF, time = 2, isline = true, p1x =0, p1y =0 , p1z =0 , p2x =0, p2y =0 , p2z =0 })
			end
		end
	end
end

SetTimerCallback('PlayfulDodge')
SetTimerCallback("DeadlyFizz")