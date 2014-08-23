local scriptName = "YayoBuddy"
local version = "2.8.0"

require 'yprediction'
require 'spell_damage'

local yayo = require 'yayo'
local uiconfig = require 'uiconfig'
local YP = YPrediction()

Allies = {}
Enemies = {}
YayoBuddy = {}
local AllyIndex = 1
local EnemyIndex = 1
local timerHealth, timerFlask, timerMana, timerBP, bluePill = 0, 0, 0, 0, nil
local timer_BT = nil
local stacks, timer_R = 0, os.time()
local FLEEING, CHASING, STATIONARY = 0, 1, 2
local wTime, returnReady, lastCastQ = 0, 0, 0
local introTimer = GetClock()

function OnDraw()
	local target = yayo.GetTarget()
	if target then
		DrawCircleObject(target, 100, 0xff00ffff)
		DrawCircleObject(target, 120, 0xff00ffff)
		DrawCircleObject(target, 140, 0xff00ffff)
	end
	if YayoBuddy[myHero.name] and YayoBuddy[myHero.name].OnDraw then
		YayoBuddy[myHero.name].OnDraw(target)
	else
		YayoBuddy.Unsupported.OnDraw(target)
	end	
end

function BeforeAttack(target)
	if YayoBuddy[myHero.name] and YayoBuddy[myHero.name].BeforeAttack then
		return YayoBuddy[myHero.name].BeforeAttack(target)
	end
end

function OnAttack(target)
	if YayoBuddy[myHero.name] and YayoBuddy[myHero.name].OnAttack then
		YayoBuddy[myHero.name].OnAttack(target)
	end
end

function AfterAttack(target)
	if YayoBuddy[myHero.name] and YayoBuddy[myHero.name].AfterAttack then
		YayoBuddy[myHero.name].AfterAttack(target)
	end
end

function OnTick()
	SetScriptTimer(10)
	local menu = getMenu()
	local target = yayo.GetTarget()
	if ValidTarget(target) and yayo.Config.AutoCarry then
		if menu.useItems then
			UseAllItems(target)
		end
	end
	if YayoBuddy[myHero.name] and YayoBuddy[myHero.name].OnTick then
		YayoBuddy[myHero.name].OnTick(target)
	else
		YayoBuddy.Unsupported.OnTick(target)
	end	
end

function OnProcessSpell(unit,spell)
	if YayoBuddy[myHero.name] and YayoBuddy[myHero.name].OnProcessSpell then
		YayoBuddy[myHero.name].OnProcessSpell(unit,spell)
	end
end

function Init()
	createEnemyTable()
	createAllyTable()
	print('YayoBuddy '..version.." by CCONN")
	yayo.RegisterBeforeAttackCallback(BeforeAttack)
	yayo.RegisterOnAttackCallback(OnAttack)
	yayo.RegisterAfterAttackCallback(AfterAttack)
	if YayoBuddy[myHero.name] and YayoBuddy[myHero.name].Menu then
		YayoBuddy[myHero.name].Menu()
	else
		YayoBuddy.Unsupported.Menu()
	end
	if YayoBuddy[myHero.name] and YayoBuddy[myHero.name].Init then
		YayoBuddy[myHero.name].Init()
	end
end

-------------------CHAMPION SECTION
YayoBuddy.Unsupported = {
	OnTick = function(target)
		YayoBuddy.Unsupported.Intro()
	end,
	OnDraw = function(target)
		if CfgYayoBuddy_Unsupported.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Unsupported.RoamHelper.AAnumb, CfgYayoBuddy_Unsupported.RoamHelper.Qnumb, CfgYayoBuddy_Unsupported.RoamHelper.Wnumb, CfgYayoBuddy_Unsupported.RoamHelper.Enumb, CfgYayoBuddy_Unsupported.RoamHelper.Rnumb, CfgYayoBuddy_Unsupported.RoamHelper.ignite) end
		if CfgYayoBuddy_Unsupported.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Unsupported.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Unsupported.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Unsupported.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Unsupported.AutoPotions.Mana_Potion_Value) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy ", 100, 80, Color.White)
			DrawText("Version "..version, 226, 80, Color.Purple)
			DrawText("Loaded!", 306, 80, Color.Green)
			DrawText(myHero.name.." is not supported. But you have access to utility features and Yayo.", 380, 80, Color.Yellow)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Unsupported, menu = uiconfig.add_menu("YayoBuddy: Unsupported")
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 2, {"0", "1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 2, {"0", "1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 2, {"0", "1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 2, {"0", "1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 2, {"0", "1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
--		local submenu = menu.submenu('Enemies')
--		for i, Enemy in pairs(Enemies) do
--			if Enemy ~= nil then
--			local Enemy = Enemy.Unit
--				if Enemy.team ~= myHero.team then submenu.checkbutton("Enemy"..i, "Target "..Enemy.name, true) end
--			end
--		end
--		local submenu = menu.submenu('Allies')
--		for i, Ally in pairs(Allies) do
--			if Ally ~= nil then
--			local Ally = Ally.Unit
--				if Ally.team == myHero.team then submenu.checkbutton("Ally"..i, "Heal "..Ally.name, true) end
--			end
--		end
		menu.label('lblspace0', ' ')
		menu.label('lbl1', myHero.name.." is currently not \n supported by YayoBuddy.")
		menu.label('lblspace1', ' ')
		menu.label('lbl2', 'You still have access to Yayo \n and all utility features.')
		menu.label('lblspace2', ' ')
		local submenu = menu.submenu('AutoPotions')
		menu.checkbutton('useItems', 'Use Active Items', true)
	end
}

YayoBuddy.Ahri = {
	OnTick = function(target)
		YayoBuddy.Ahri.Intro()
		comboYayoBuddy(M, 975, 4, YayoBuddy.Ahri.R, 3, YayoBuddy.Ahri.E, 1, YayoBuddy.Ahri.Q, 2, YayoBuddy.Ahri.W)
		if CfgYayoBuddy_Ahri.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.Ahri.Q, 880, YayoBuddy.Ahri.W, 800, YayoBuddy.Ahri.E, 975, x, 0, x) end
		spellFarm(880, YayoBuddy.Ahri.Q, YayoBuddy.Ahri.W, x, x)
		if CfgYayoBuddy_Ahri.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Ahri.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Ahri.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Ahri.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Ahri.AutoPotions.Mana_Potion_Value) end
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_Ahri.SpellOptions.qRNG, width = 100, speed = 1600, delay = 0.25, mana = (50+(5*myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_Ahri.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeQ > 1.0 then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_Ahri.SpellOptions.wRNG, mana = 50, manaThreshold = CfgYayoBuddy_Ahri.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeW > 1.0 then
				CastSpellTarget('W', myHero)
			end
		end
	end,
	E = function(target)
		local spellData = { range = CfgYayoBuddy_Ahri.SpellOptions.eRNG, width = 60, speed = 1500, delay = 0.25, mana = 85, manaThreshold = CfgYayoBuddy_Ahri.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeE > 1.0 then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('E', x, y, z)
				end
			end
		end
	end,
	R = function(target)
		local spellData = { range = CfgYayoBuddy_Ahri.SpellOptions.rRNG, mana = 100, manaThreshold = CfgYayoBuddy_Ahri.ManaManager.manaR }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= 100 and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeR > 1.0 then
				CastSpellXYZ('R',mousePos.x, mousePos.y, mousePos.z)
			end
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Ahri.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_Ahri.SpellOptions.qRNG, CfgYayoBuddy_Ahri.Draw.colorQ)
		end
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Ahri.Draw.drawW then
			DrawCircleObject(myHero, CfgYayoBuddy_Ahri.SpellOptions.wRNG, CfgYayoBuddy_Ahri.Draw.colorW)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Ahri.Draw.drawE then
			DrawCircleObject(myHero, CfgYayoBuddy_Ahri.SpellOptions.eRNG, CfgYayoBuddy_Ahri.Draw.colorE)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Ahri.Draw.drawR then
			DrawCircleObject(myHero, 450, CfgYayoBuddy_Ahri.Draw.colorR)
		end
		if CfgYayoBuddy_Ahri.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Ahri.RoamHelper.AAnumb, CfgYayoBuddy_Ahri.RoamHelper.Qnumb, CfgYayoBuddy_Ahri.RoamHelper.Wnumb, CfgYayoBuddy_Ahri.RoamHelper.Enumb, CfgYayoBuddy_Ahri.RoamHelper.Rnumb, CfgYayoBuddy_Ahri.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Ahri ", 225, 80, Color.White)
			DrawText("Version "..version, 256, 80, Color.Purple)
			DrawText("Loaded!", 336, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Ahri, menu = uiconfig.add_menu("YayoBuddy: Ahri", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Orb of Deception', true)
		submenu.checkbox('useW', 'W: Fox-Fire', true)
		submenu.checkbox('useE', 'E: Charm', true)
		submenu.checkbox('useR', 'R: Spirit Rush', false)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Orb of Deception', true)
		submenu.checkbox('useW', 'W: Fox-Fire', false)
		submenu.checkbox('useE', 'E: Charm', true)
		submenu.checkbox('useR', 'R: Spirit Rush', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Orb of Deception', true)
		submenu.checkbox('farmW', 'W: Fox-Fire', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Orb of Deception', true)
		submenu.checkbox('useW', 'W: Fox-Fire', false)
		submenu.checkbox('useE', 'E: Charm', true)
		submenu.checkbox('useR', 'R: Spirit Rush', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Orb of Deception', false)
		submenu.checkbox('farmW', 'W: Fox-Fire', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Orb of Deception', true)
		submenu.checkbox('useW', 'W: Fox-Fire', false)
		submenu.checkbox('useE', 'E: Charm', true)
		submenu.checkbox('useR', 'R: Spirit Rush', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Orb of Deception', false)
		submenu.checkbox('farmW', 'W: Fox-Fire', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Orb of Deception', 0, 880, 880, nil, true)
		submenu.slider('wRNG', 'W: Fox-Fire', 0, 800, 800, nil, true)
		submenu.slider('eRNG', 'E: Charm', 0, 950, 950, nil, true)
		submenu.slider('rRNG', 'R: Spirit Rush', 0, 950, 950, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 2, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 3, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.Caitlyn = {
	OnTick = function(target)
		YayoBuddy.Caitlyn.Intro()
		local targetEQ = GetWeakEnemy('PHYS', 1300)
		comboYayoBuddy(P, 3000, 1, YayoBuddy.Caitlyn.Q, 2, YayoBuddy.Caitlyn.W, 3, YayoBuddy.Caitlyn.E, 4, YayoBuddy.Caitlyn.R)
		if CfgYayoBuddy_Caitlyn.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.Caitlyn.Q, 1300, YayoBuddy.Caitlyn.W, 800, YayoBuddy.Caitlyn.E, 950, YayoBuddy.Caitlyn.R, 3000, x) end
		if CfgYayoBuddy_Caitlyn.useEQ then YayoBuddy.Caitlyn.EQ(targetEQ) end
		spellFarm(1300, YayoBuddy.Caitlyn.Q, x, x, x)
		if CfgYayoBuddy_Caitlyn.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Caitlyn.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Caitlyn.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Caitlyn.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Caitlyn.AutoPotions.Mana_Potion_Value) end
	end,
	AfterAttack = function(target)
		
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_Caitlyn.SpellOptions.qRNG, width = 90, speed = 2225, delay = 0.632, mana = (40+(10*myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_Caitlyn.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_Caitlyn.SpellOptions.wRNG, width = 80, speed = 1960, delay = 0.1, mana = 50, manaThreshold = CfgYayoBuddy_Caitlyn.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= 50 and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('W', x, y, z)
				end
			end
		end
	end,
	E = function(target)
		local spellData = { range = CfgYayoBuddy_Caitlyn.SpellOptions.eRNG, width = 80, speed = 1960, delay = 0.1, mana = 75, manaThreshold = CfgYayoBuddy_Caitlyn.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('E', x, y, z)
				end
			end
		end
	end,
	R = function(target)
		local spellData = { range = getAceRange(), mana = 100, manaThreshold = CfgYayoBuddy_Caitlyn.ManaManager.manaR }
		if target ~= nil then
			if CfgYayoBuddy_Caitlyn.SpellOptions.safeR and SafeR() then
				if GetDistance(myHero, target) > myHero.range and GetDistance(myHero, target) <= spellData.range and myHero.mana >= 100 and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
					CastSpellTarget('R',target)
				end
			else
				if GetDistance(myHero, target) > myHero.range and GetDistance(myHero, target) <= spellData.range and myHero.mana >= 100 and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
					CastSpellTarget('R',target)
				end
			end
		end
	end,
	EQ = function(target)
		local spellQData = { range = CfgYayoBuddy_Caitlyn.SpellOptions.qRNG, width = 90, speed = 2225, delay = 0.632, mana = (40+(10*myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_Caitlyn.ManaManager.manaQ }
		local spellEData = { range = CfgYayoBuddy_Caitlyn.SpellOptions.eRNG, width = 80, speed = 1960, delay = 0.1, mana = 75, manaThreshold = CfgYayoBuddy_Caitlyn.ManaManager.manaE }
		if GetDistance(myHero, target) <= spellEData.range and myHero.mana >= spellEData.mana and myHero.mana >= myHero.maxMana * (spellEData.manaThreshold / 100) then
			local CastPosition = Vector(myHero) + (Vector(myHero) - Vector(mousePos.x, mousePos.y, mousePos.z))*(950/GetDistance(mousePos))
			CastSpellXYZ('E', CastPosition.x, CastPosition.y, CastPosition.z)
		end
		if target ~= nil then
			if GetDistance(myHero, target) <= spellQData.range and myHero.mana >= spellQData.mana and myHero.mana >= myHero.maxMana * (spellQData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellQData.delay, spellQData.width, spellQData.range, spellQData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
	end,
	OnProcessSpell = function(unit, spell)
		if unit ~= nil and spell ~= nil and IsHero(unit) then
			print("OnProcessSpell detected for "..unit.name.." spell name: "..spell.name)
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Caitlyn.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_Caitlyn.SpellOptions.qRNG, CfgYayoBuddy_Caitlyn.Draw.colorQ)
		end
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Caitlyn.Draw.drawW then
			DrawCircleObject(myHero, CfgYayoBuddy_Caitlyn.SpellOptions.wRNG, CfgYayoBuddy_Caitlyn.Draw.colorW)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Caitlyn.Draw.drawE then
			DrawCircleObject(myHero, CfgYayoBuddy_Caitlyn.SpellOptions.eRNG, CfgYayoBuddy_Caitlyn.Draw.colorE)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Caitlyn.Draw.drawR then
			DrawCircleObject(myHero, getAceRange(), CfgYayoBuddy_Caitlyn.Draw.colorR)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Caitlyn.Draw.drawSafeR then
			DrawCircleObject(myHero, CfgYayoBuddy_Caitlyn.SpellOptions.SafeR_Value, CfgYayoBuddy_Caitlyn.Draw.colorSafeR)
		end
		if CfgYayoBuddy_Caitlyn.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Caitlyn.RoamHelper.AAnumb, CfgYayoBuddy_Caitlyn.RoamHelper.Qnumb, CfgYayoBuddy_Caitlyn.RoamHelper.Wnumb, CfgYayoBuddy_Caitlyn.RoamHelper.Enumb, CfgYayoBuddy_Caitlyn.RoamHelper.Rnumb, CfgYayoBuddy_Caitlyn.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Caitlyn ", 225, 80, Color.White)
			DrawText("Version "..version, 271, 80, Color.Purple)
			DrawText("Loaded!", 351, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Caitlyn, menu = uiconfig.add_menu("YayoBuddy: Caitlyn", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Piltover Peacemaker', true)
		submenu.checkbox('useW', 'W: Yordle Trap', true)
		submenu.checkbox('useE', 'E: 90 Caliber Net', false)
		submenu.checkbox('useR', 'R: Ace in the Hole', false)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Piltover Peacemaker', true)
		submenu.checkbox('useW', 'W: Yordle Trap', true)
		submenu.checkbox('useE', 'E: 90 Caliber Net', false)
		submenu.checkbox('useR', 'R: Ace in the Hole', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Piltover Peacemaker', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Piltover Peacemaker', false)
		submenu.checkbox('useW', 'W: Yordle Trap', false)
		submenu.checkbox('useE', 'E: 90 Caliber Net', false)
		submenu.checkbox('useR', 'R: Ace in the Hole', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Piltover Peacemaker', false)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Piltover Peacemaker', true)
		submenu.checkbox('useW', 'W: Yordle Trap', true)
		submenu.checkbox('useE', 'E: 90 Caliber Net', false)
		submenu.checkbox('useR', 'R: Ace in the Hole', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Piltover Peacemaker', false)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Piltover Peacemaker', 0, 1300, 1000, nil, true)
		submenu.slider('wRNG', 'W: Yordle Snap Trap', 0, 800, 800, nil, true)
		submenu.slider('eRNG', 'E: 90 Caliber Net', 0, 950, 950, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SAFE ULTIMATE OPTIONS:')
		submenu.checkbox('safeR', 'Use Safe Ultimate', true)
		submenu.slider('SafeR_Value', 'Safe Zone Range', 0, 2000, 700, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawSafeR', 'Safe R Range', true)
		submenu.slider('colorSafeR', 'Safe R Range Color:', 1, 6, 1, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.keydown('useEQ', 'EQ Combo', Keys.Z)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.Cassiopeia = {
	OnTick = function(target) --add MEC ultimate
		YayoBuddy.Cassiopeia.Intro()
		comboYayoBuddy(M, 850, 3, YayoBuddy.Cassiopeia.E, 1, YayoBuddy.Cassiopeia.Q, 2, YayoBuddy.Cassiopeia.W, 4, YayoBuddy.Cassiopeia.R)
		if CfgYayoBuddy_Cassiopeia.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.Cassiopeia.Q, 850, YayoBuddy.Cassiopeia.W, 850, YayoBuddy.Cassiopeia.E, 700, YayoBuddy.Cassiopeia.R, 825, x) end
		spellFarm(850, YayoBuddy.Cassiopeia.Q, YayoBuddy.Cassiopeia.W, YayoBuddy.Cassiopeia.E, x)
		if CfgYayoBuddy_Cassiopeia.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Cassiopeia.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Cassiopeia.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Cassiopeia.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Cassiopeia.AutoPotions.Mana_Potion_Value) end
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_Cassiopeia.SpellOptions.qRNG, width = 80, speed = math.huge, delay = 0.535, mana = (25+(10*myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_Cassiopeia.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeQ > 1.0 then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_Cassiopeia.SpellOptions.wRNG, width = 80, speed = math.huge, delay = 0.350, mana = (60+(10*myHero.SpellLevelW)), manaThreshold = CfgYayoBuddy_Cassiopeia.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeW > 1.0 then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('W', x, y, z)
				end
			end
		end
	end,
	E = function(target)
		local spellData = { range = CfgYayoBuddy_Cassiopeia.SpellOptions.eRNG, mana = (40+(10*myHero.SpellLevelE)), manaThreshold = CfgYayoBuddy_Cassiopeia.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeE > 1.0 and DetectPoison(target) then
					CastSpellTarget('E', target)
			end
		end
	end,
	R = function(target)
		local spellData = { range = CfgYayoBuddy_Cassiopeia.SpellOptions.rRNG, width = 350, speed = math.huge, delay = 0.535, mana = 100, manaThreshold = CfgYayoBuddy_Cassiopeia.ManaManager.manaR }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellLevelR >= 1 and myHero.SpellTimeR > 1.0 and GetTargetDirection(target) == CHASING then
				local CastPosition, HitChance, Position = YP:GetConeAOECastPosition(target, spellData.delay, 80, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('R', x, y, z)
				end
			end
		end
	end,
	OnProcessSpell = function(unit, spell)
		if unit ~= nil and spell ~= nil and IsHero(unit) then
			print("OnProcessSpell detected for "..unit.name.." spell name: "..spell.name) -- setup timers
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Cassiopeia.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_Cassiopeia.SpellOptions.qRNG, CfgYayoBuddy_Cassiopeia.Draw.colorQ)
		end
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Cassiopeia.Draw.drawW then
			DrawCircleObject(myHero, CfgYayoBuddy_Cassiopeia.SpellOptions.wRNG, CfgYayoBuddy_Cassiopeia.Draw.colorW)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Cassiopeia.Draw.drawE then
			DrawCircleObject(myHero, CfgYayoBuddy_Cassiopeia.SpellOptions.eRNG, CfgYayoBuddy_Cassiopeia.Draw.colorE)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Cassiopeia.Draw.drawR then
			DrawCircleObject(myHero, CfgYayoBuddy_Cassiopeia.SpellOptions.rRNG, CfgYayoBuddy_Cassiopeia.Draw.colorR)
		end
		if CfgYayoBuddy_Cassiopeia.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Cassiopeia.RoamHelper.AAnumb, CfgYayoBuddy_Cassiopeia.RoamHelper.Qnumb, CfgYayoBuddy_Cassiopeia.RoamHelper.Wnumb, CfgYayoBuddy_Cassiopeia.RoamHelper.Enumb, CfgYayoBuddy_Cassiopeia.RoamHelper.Rnumb, CfgYayoBuddy_Cassiopeia.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Cassiopeia ", 225, 80, Color.White)
			DrawText("Version "..version, 296, 80, Color.Purple)
			DrawText("Loaded!", 376, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Cassiopeia, menu = uiconfig.add_menu("YayoBuddy: Cassiopeia", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Noxious Blast', true)
		submenu.checkbox('useW', 'W: Miasma', true)
		submenu.checkbox('useE', 'E: Twin Fang', true)
		submenu.checkbox('useR', 'R: Petrifying Gaze', false)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Noxious Blast', true)
		submenu.checkbox('useW', 'W: Miasma', true)
		submenu.checkbox('useE', 'E: Twin Fang', true)
		submenu.checkbox('useR', 'R: Petrifying Gaze', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Noxious Blast', true)
		submenu.checkbox('farmW', 'W: Miasma', true)
		submenu.checkbox('farmE', 'E: Twin Fang', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Noxious Blast', false)
		submenu.checkbox('useW', 'W: Miasma', false)
		submenu.checkbox('useE', 'E: Twin Fang', false)
		submenu.checkbox('useR', 'R: Petrifying Gaze', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Noxious Blast', true)
		submenu.checkbox('farmW', 'W: Miasma', true)
		submenu.checkbox('farmE', 'E: Twin Fang', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Noxious Blast', true)
		submenu.checkbox('useW', 'W: Miasma', true)
		submenu.checkbox('useE', 'E: Twin Fang', true)
		submenu.checkbox('useR', 'R: Petrifying Gaze', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Noxious Blast', true)
		submenu.checkbox('farmW', 'W: Miasma', true)
		submenu.checkbox('farmE', 'E: Twin Fang', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Noxious Blast', 0, 850, 850, nil, true)
		submenu.slider('wRNG', 'W: Miasma', 0, 850, 850, nil, true)
		submenu.slider('eRNG', 'E: Twin Fang', 0, 700, 700, nil, true)
		submenu.slider('rRNG', 'R: Petrifying Gaze', 0, 825, 825, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.Corki = {
	OnTick = function(target)
		YayoBuddy.Corki.Intro()
		comboYayoBuddy(P, 1225, 1, YayoBuddy.Corki.Q, 3, YayoBuddy.Corki.E, 4, YayoBuddy.Corki.R, x, x)
		if CfgYayoBuddy_Corki.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.Corki.Q, 825, x, x, YayoBuddy.Corki.E, 600, YayoBuddy.Corki.R, 1225, x) end
		spellFarm(1225, YayoBuddy.Corki.Q, x, x, YayoBuddy.Corki.R)
		if CfgYayoBuddy_Corki.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Corki.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Corki.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Corki.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Corki.AutoPotions.Mana_Potion_Value) end
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_Corki.SpellOptions.qRNG, width = 250, speed = 850, delay = 0.5, mana = (50+(10*myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_Corki.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
	end,
	W = function(target)
		print('Error: W Spell not supported.')
	end,
	E = function(target)
		local spellData = { range = CfgYayoBuddy_Corki.SpellOptions.eRNG, width = 100, speed = 902, delay = 0.5, mana = 50, manaThreshold = CfgYayoBuddy_Corki.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetConeAOECastPosition(target, spellData.delay, 35, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('E', x, y, z)
				end
			end
		end
	end,
	R = function(target)
		local spellData = { range = CfgYayoBuddy_Corki.SpellOptions.rRNG, width = 80, speed = 828, delay = 0.5, mana = 20, manaThreshold = CfgYayoBuddy_Corki.ManaManager.manaR }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('R', x, y, z)
				end
			end
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Corki.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_Corki.SpellOptions.qRNG, CfgYayoBuddy_Corki.Draw.colorQ)
		end
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Corki.Draw.drawW then
			DrawCircleObject(myHero, 800, CfgYayoBuddy_Corki.Draw.colorW)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Corki.Draw.drawE then
			DrawCircleObject(myHero, CfgYayoBuddy_Corki.SpellOptions.eRNG, CfgYayoBuddy_Corki.Draw.colorE)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Corki.Draw.drawR then
			DrawCircleObject(myHero, CfgYayoBuddy_Corki.SpellOptions.rRNG, CfgYayoBuddy_Corki.Draw.colorR)
		end
		if CfgYayoBuddy_Corki.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Corki.RoamHelper.AAnumb, CfgYayoBuddy_Corki.RoamHelper.Qnumb, CfgYayoBuddy_Corki.RoamHelper.Wnumb, CfgYayoBuddy_Corki.RoamHelper.Enumb, CfgYayoBuddy_Corki.RoamHelper.Rnumb, CfgYayoBuddy_Corki.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Corki ", 225, 80, Color.White)
			DrawText("Version "..version, 261, 80, Color.Purple)
			DrawText("Loaded!", 341, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Corki, menu = uiconfig.add_menu("YayoBuddy: Corki", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Phosphorus Bomb', true)
		--submenu.checkbox('useW', 'W: Valkyrie', true)
		submenu.checkbox('useE', 'E: Gatling Gun', true)
		submenu.checkbox('useR', 'R: Missile Barrage', true)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Phosphorus Bomb', true)
		--submenu.checkbox('useW', 'W: Valkyrie', false)
		submenu.checkbox('useE', 'E: Gatling Gun', false)
		submenu.checkbox('useR', 'R: Missile Barrage', true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Phosphorus Bomb', true)
		submenu.checkbox('farmR', 'R: Missile Barrage', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Phosphorus Bomb', false)
		--submenu.checkbox('useW', 'W: Valkyrie', false)
		submenu.checkbox('useE', 'E: Gatling Gun', false)
		submenu.checkbox('useR', 'R: Missile Barrage', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Phosphorus Bomb', true)
		submenu.checkbox('farmR', 'R: Missile Barrage', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Phosphorus Bomb', true)
		--submenu.checkbox('useW', 'W: Valkyrie', false)
		submenu.checkbox('useE', 'E: Gatling Gun', false)
		submenu.checkbox('useR', 'R: Missile Barrage', true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Phosphorus Bomb', true)
		submenu.checkbox('farmR', 'R: Missile Barrage', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		--submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Phosphorus Bomb', 0, 825, 825, nil, true)
		--submenu.slider('wRNG', 'W: Valkyrie', 0, 800, 800, nil, true)
		submenu.slider('eRNG', 'E: Gatling Gun', 0, 600, 600, nil, true)
		submenu.slider('rRNG', 'R: Missile Barrage', 0, 1225, 1225, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Distance', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 2, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.Ezreal = {
	OnTick = function(target)
		YayoBuddy.Ezreal.Intro()
		comboYayoBuddy(P, 3000, 1, YayoBuddy.Ezreal.Q, 3, YayoBuddy.Ezreal.E, 4, YayoBuddy.Ezreal.R, x, x)
		if CfgYayoBuddy_Ezreal.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.Ezreal.Q, 1150, YayoBuddy.Ezreal.W, 1000, x, 0, YayoBuddy.Ezreal.R, 3000, x) end
		spellFarm(1150, YayoBuddy.Ezreal.Q, x, x, x)
		if CfgYayoBuddy_Ezreal.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Ezreal.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Ezreal.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Ezreal.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Ezreal.AutoPotions.Mana_Potion_Value) end
	end,
	AfterAttack = function(target)
		comboYayoBuddy(P, 1000, 2, YayoBuddy.Ezreal.W, x, x, x, x, x, x)
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_Ezreal.SpellOptions.qRNG, width = 80, speed = 2000, delay = 0.25, mana = (25+(3*myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_Ezreal.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_Ezreal.SpellOptions.wRNG, width = 90, speed = 1600, delay = 0.25, mana = (50+(10*myHero.SpellLevelW)), manaThreshold = CfgYayoBuddy_Ezreal.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('W', x, y, z)
				end
			end
		end
	end,
	E = function(target)
		local spellData = { range = CfgYayoBuddy_Ezreal.SpellOptions.eRNG, mana = 90, manaThreshold = CfgYayoBuddy_Ezreal.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				CastSpellXYZ('E', mousePos.x, mousePos.y, mousePos.z)
			end
		end
	end,
	R = function(target)
		local spellData = { range = CfgYayoBuddy_Ezreal.SpellOptions.rRNG, width = 150, speed = 2000, delay = 0.25, mana = 100, manaThreshold = CfgYayoBuddy_Ezreal.ManaManager.manaR }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('R', x, y, z)
				end
			end
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Ezreal.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_Ezreal.SpellOptions.qRNG, CfgYayoBuddy_Ezreal.Draw.colorQ)
		end
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Ezreal.Draw.drawW then
			DrawCircleObject(myHero, CfgYayoBuddy_Ezreal.SpellOptions.wRNG, CfgYayoBuddy_Ezreal.Draw.colorW)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Ezreal.Draw.drawE then
			DrawCircleObject(myHero, 475, CfgYayoBuddy_Ezreal.Draw.colorE)
		end
		if CfgYayoBuddy_Ezreal.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Ezreal.RoamHelper.AAnumb, CfgYayoBuddy_Ezreal.RoamHelper.Qnumb, CfgYayoBuddy_Ezreal.RoamHelper.Wnumb, CfgYayoBuddy_Ezreal.RoamHelper.Enumb, CfgYayoBuddy_Ezreal.RoamHelper.Rnumb, CfgYayoBuddy_Ezreal.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Ezreal ", 225, 80, Color.White)
			DrawText("Version "..version, 266, 80, Color.Purple)
			DrawText("Loaded!", 346, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Ezreal, menu = uiconfig.add_menu("YayoBuddy: Ezreal", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Mystic Shot', true)
		submenu.checkbox('useW', 'W: Essence Flux', true)
		submenu.checkbox('useE', 'E: Arcane Shift', false)
		submenu.checkbox('useR', 'R: Trueshot Barrage', false)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Mystic Shot', true)
		submenu.checkbox('useW', 'W: Essence Flux', true)
		submenu.checkbox('useE', 'E: Arcane Shift', false)
		submenu.checkbox('useR', 'R: Trueshot Barrage', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Mystic Shot', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Mystic Shot', false)
		submenu.checkbox('useW', 'W: Essence Flux', false)
		submenu.checkbox('useE', 'E: Arcane Shift', false)
		submenu.checkbox('useR', 'R: Trueshot Barrage', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Mystic Shot', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Mystic Shot', true)
		submenu.checkbox('useW', 'W: Essence Flux', true)
		submenu.checkbox('useE', 'E: Arcane Shift', false)
		submenu.checkbox('useR', 'R: Trueshot Barrage', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Mystic Shot', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Mystic Shot', 0, 1150, 1150, nil, true)
		submenu.slider('wRNG', 'W: Essence Flux', 0, 1000, 1000, nil, true)
		submenu.slider('eRNG', 'E: Arcane Shift', 0, 1025, 550, nil, true)
		submenu.slider('rRNG', 'R: Trueshot Barrage', 0, 3000, 3000, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Distance', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 2, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.Graves = {
	OnTick = function(target)
		YayoBuddy.Graves.Intro()
		comboYayoBuddy(P, 1000, 2, YayoBuddy.Graves.W, 3, YayoBuddy.Graves.E, 1, YayoBuddy.Graves.Q, 4, YayoBuddy.Graves.R)
		if CfgYayoBuddy_Graves.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.Graves.Q, 950, x, x, x, x, YayoBuddy.Graves.R, 1000, x) end
		spellFarm(950, YayoBuddy.Graves.Q, x, x, x)
		if CfgYayoBuddy_Graves.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Graves.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Graves.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Graves.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Graves.AutoPotions.Mana_Potion_Value) end
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_Graves.SpellOptions.qRNG, width = 100, speed = 902, delay = 0.5, mana = (50+(10 * myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_Graves.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_Graves.SpellOptions.wRNG, width = 250, speed = 1650, delay = 0.5, mana = (65 + (10 * myHero.SpellLevelW)), manaThreshold = CfgYayoBuddy_Graves.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('W', x, y, z)
				end
			end
		end
	end,
	E = function(target)
		local spellData = { range = 950, mana = 40, manaThreshold = CfgYayoBuddy_Graves.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				CastSpellXYZ('E', mousePos.x, mousePos.y, mousePos.z)
			end
		end
	end,
	R = function(target)
		local spellData = { range = CfgYayoBuddy_Graves.SpellOptions.rRNG, width = 100, speed = 1650, delay = 0.5, mana = 100, manaThreshold = CfgYayoBuddy_Graves.ManaManager.manaR }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('R', x, y, z)
				end
			end
		end
	end,
	OnProcessSpell = function(unit, spell)
		if unit ~= nil and spell ~= nil and IsHero(unit) then
			print("OnProcessSpell detected for "..unit.name.." spell name: "..spell.name)
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Graves.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_Graves.SpellOptions.qRNG, CfgYayoBuddy_Graves.Draw.colorQ)
		end
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Graves.Draw.drawW then
			DrawCircleObject(myHero, CfgYayoBuddy_Graves.SpellOptions.wRNG, CfgYayoBuddy_Graves.Draw.colorW)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Graves.Draw.drawE then
			DrawCircleObject(myHero, 425, CfgYayoBuddy_Graves.Draw.colorE)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Graves.Draw.drawR then
			DrawCircleObject(myHero, CfgYayoBuddy_Graves.SpellOptions.rRNG, CfgYayoBuddy_Graves.Draw.colorR)
		end
		if CfgYayoBuddy_Graves.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Graves.RoamHelper.AAnumb, CfgYayoBuddy_Graves.RoamHelper.Qnumb, CfgYayoBuddy_Graves.RoamHelper.Wnumb, CfgYayoBuddy_Graves.RoamHelper.Enumb, CfgYayoBuddy_Graves.RoamHelper.Rnumb, CfgYayoBuddy_Graves.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Graves ", 225, 80, Color.White)
			DrawText("Version "..version, 271, 80, Color.Purple)
			DrawText("Loaded!", 351, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Graves, menu = uiconfig.add_menu("YayoBuddy: Graves", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Buckshot', true)
		submenu.checkbox('useW', 'W: Smoke Screen', true)
		submenu.checkbox('useE', 'E: Quickdraw', true)
		submenu.checkbox('useR', 'R: Collateral Damage', false)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Buckshot', true)
		submenu.checkbox('useW', 'W: Smoke Screen', true)
		submenu.checkbox('useE', 'E: Quickdraw', false)
		submenu.checkbox('useR', 'R: Collateral Damage', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Buckshot', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Buckshot', false)
		submenu.checkbox('useW', 'W: Smoke Screen', false)
		submenu.checkbox('useE', 'E: Quickdraw', false)
		submenu.checkbox('useR', 'R: Collateral Damage', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Buckshot', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Buckshot', true)
		submenu.checkbox('useW', 'W: Smoke Screen', false)
		submenu.checkbox('useE', 'E: Quickdraw', false)
		submenu.checkbox('useR', 'R: Collateral Damage', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Buckshot', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Buckshot', 0, 950, 950, nil, true)
		submenu.slider('wRNG', 'W: Smoke Screen', 0, 950, 950, nil, true)
		submenu.slider('eRNG', 'E: Quickdraw', 0, 950, 950, nil, true)
		submenu.slider('rRNG', 'R: Collateral Damage', 0, 1000, 1000, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Distance', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.KogMaw = {
	OnTick = function(target)
		YayoBuddy.KogMaw.Intro()
		StackReset()
		comboYayoBuddy(P, 1800, 2, YayoBuddy.KogMaw.W, 3, YayoBuddy.KogMaw.E, 4, YayoBuddy.KogMaw.R, 1, YayoBuddy.KogMaw.Q)
		if CfgYayoBuddy_KogMaw.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.KogMaw.Q, 1000, x, x, YayoBuddy.KogMaw.E, 1280, YayoBuddy.KogMaw.R, GetRRange(), x) end
		if CfgYayoBuddy_KogMaw.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_KogMaw.AutoPotions.Health_Potion_Value, CfgYayoBuddy_KogMaw.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_KogMaw.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_KogMaw.AutoPotions.Mana_Potion_Value) end
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_KogMaw.SpellOptions.qRNG, width = 90, speed = 2225, delay = 0.632, mana = (40+(10*myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_KogMaw.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeQ > 1.0 then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
	end,
	W = function(target)
		local spellData = { range = GetWRange(), mana = (40+(10*myHero.SpellLevelW)), manaThreshold = CfgYayoBuddy_KogMaw.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeW > 1.0 then
				CastSpellTarget('W', myHero)
			end
		end
	end,
	E = function(target)
		local spellData = { range = CfgYayoBuddy_KogMaw.SpellOptions.eRNG, width = 80, speed = 800, delay = 0.60, mana = 90, manaThreshold = CfgYayoBuddy_KogMaw.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeE > 1.0 then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('E', x, y, z)
				end
			end
		end
	end,
	R = function(target)
		local spellData = { range = GetRRange(), width = 100, speed = 1000, delay = 0.25, mana = 40, manaThreshold = CfgYayoBuddy_KogMaw.ManaManager.manaR } --add stack count to mana equation
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeR > 1.0 and StackCheck() then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('R', x, y, z)
				end
			end
		end
	end,
	OnProcessSpell = function(unit, spell)
		if unit ~= nil and spell ~= nil and unit.charName == myHero.charName and spell.name:lower():find("kogmawlivingartillery") then
			stacks = stacks + 1
			timer_R = os.time()
			print('OnProcessSpell Event - Unit: '..unit.name..", spell: "..spell.name.."\n Stacks: "..stacks.."timer_R: "..timer_R)
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_KogMaw.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_KogMaw.SpellOptions.qRNG, CfgYayoBuddy_KogMaw.Draw.colorQ)
		end
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_KogMaw.Draw.drawW then
			DrawCircleObject(myHero, GetWRange(), CfgYayoBuddy_KogMaw.Draw.colorW)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_KogMaw.Draw.drawE then
			DrawCircleObject(myHero, CfgYayoBuddy_KogMaw.SpellOptions.eRNG, CfgYayoBuddy_KogMaw.Draw.colorE)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_KogMaw.Draw.drawR then
			DrawCircleObject(myHero, GetRRange(), CfgYayoBuddy_KogMaw.Draw.colorR)
		end
		if CfgYayoBuddy_KogMaw.RoamHelper.Enable then roamHelper(CfgYayoBuddy_KogMaw.RoamHelper.AAnumb, CfgYayoBuddy_KogMaw.RoamHelper.Qnumb, CfgYayoBuddy_KogMaw.RoamHelper.Wnumb, CfgYayoBuddy_KogMaw.RoamHelper.Enumb, CfgYayoBuddy_KogMaw.RoamHelper.Rnumb, CfgYayoBuddy_KogMaw.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("KogMaw ", 225, 80, Color.White)
			DrawText("Version "..version, 281, 80, Color.Purple)
			DrawText("Loaded!", 361, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_KogMaw, menu = uiconfig.add_menu("YayoBuddy: KogMaw", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Caustic Spittle', true)
		submenu.checkbox('useW', 'W: Bio-Arcane Barrage', true)
		submenu.checkbox('useE', 'E: Void Ooze', true)
		submenu.checkbox('useR', 'R: Living Artillery', true)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Caustic Spittle', false)
		submenu.checkbox('useW', 'W: Bio-Arcane Barrage', false)
		submenu.checkbox('useE', 'E: Void Ooze', false)
		submenu.checkbox('useR', 'R: Living Artillery', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Caustic Spittle', false)
		submenu.checkbox('useW', 'W: Bio-Arcane Barrage', false)
		submenu.checkbox('useE', 'E: Void Ooze', false)
		submenu.checkbox('useR', 'R: Living Artillery', false)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Caustic Spittle', false)
		submenu.checkbox('useW', 'W: Bio-Arcane Barrage', false)
		submenu.checkbox('useE', 'E: Void Ooze', false)
		submenu.checkbox('useR', 'R: Living Artillery', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Caustic Spittle', 0, 1000, 1000, nil, true)
		submenu.slider('eRNG', 'E: Void OOze', 0, 1280, 1000, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'Living Artillery Stack Manager:')
		submenu.slider('RStack1', 'Rank 1 max stacks', 1, 10, 2, nil, true)
		submenu.slider('RStack2', 'Rank 2 max stacks', 1, 10, 3, nil, true)
		submenu.slider('RStack3', 'Rank 3 max stacks', 1, 10, 4, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 2, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.MasterYi = {
	OnTick = function(target)
		YayoBuddy.MasterYi.Intro()
		comboYayoBuddy(P, 600, 1, YayoBuddy.MasterYi.Q, 4, YayoBuddy.MasterYi.R, 3, YayoBuddy.MasterYi.E, x, x)
		if CfgYayoBuddy_MasterYi.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.MasterYi.Q, 600, x, 0, x, 0, x, 0, x) end
		spellFarm(600, YayoBuddy.MasterYi.Q, x, x, x)
		if CfgYayoBuddy_MasterYi.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_MasterYi.AutoPotions.Health_Potion_Value, CfgYayoBuddy_MasterYi.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_MasterYi.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_MasterYi.AutoPotions.Mana_Potion_Value) end
	end,
	AfterAttack = function(target)
		comboYayoBuddy(P, 125, 2, YayoBuddy.MasterYi.W, x, x, x, x, x, x, x)
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_MasterYi.SpellOptions.qRNG, mana = (50+(10*myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_MasterYi.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeQ > 1.0 then
				CastSpellTarget('Q', target)
			end
		end
	end,
	W = function(target)
		local spellData = { range = 125, mana = 50, manaThreshold = CfgYayoBuddy_MasterYi.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeW > 1.0 then
				CastSpellTarget('W', myHero)
			end
		end
	end,
	E = function(target)
		local spellData = { range = myHero.range }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.SpellTimeE > 1.0 then
				CastSpellTarget('E', myHero)
			end
		end
	end,
	R = function(target)
		local spellData = { range = myHero.range, mana = 100, manaThreshold = CfgYayoBuddy_MasterYi.ManaManager.manaR }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeR > 1.0 then
				CastSpellTarget('R',myHero)
			end
		end
	end,
	OnProcessSpell = function(unit, spell)
		if unit ~= nil and spell ~= nil and IsHero(unit) then
			print("OnProcessSpell detected for "..unit.name.." spell name: "..spell.name) --add meditate detection and a full channeled mediate function to on tick tied to myHero.health
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_MasterYi.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_MasterYi.SpellOptions.qRNG, CfgYayoBuddy_MasterYi.Draw.colorQ)
		end
		if CfgYayoBuddy_MasterYi.RoamHelper.Enable then roamHelper(CfgYayoBuddy_MasterYi.RoamHelper.AAnumb, CfgYayoBuddy_MasterYi.RoamHelper.Qnumb, CfgYayoBuddy_MasterYi.RoamHelper.Wnumb, CfgYayoBuddy_MasterYi.RoamHelper.Enumb, CfgYayoBuddy_MasterYi.RoamHelper.Rnumb, CfgYayoBuddy_MasterYi.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Master Yi ", 225, 80, Color.White)
			DrawText("Version "..version, 286, 80, Color.Purple)
			DrawText("Loaded!", 366, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_MasterYi, menu = uiconfig.add_menu("YayoBuddy: Master Yi", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Alpha Strike', true)
		submenu.checkbox('useW', 'W: Meditate', true)
		submenu.checkbox('useE', 'E: Wuju Style', true)
		submenu.checkbox('useR', 'R: Highlander', false)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Alpha Strike', true)
		submenu.checkbox('useW', 'W: Meditate', false)
		submenu.checkbox('useE', 'E: Wuju Style', false)
		submenu.checkbox('useR', 'R: Highlander', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Alpha Strike', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Alpha Strike', false)
		submenu.checkbox('useW', 'W: Meditate', false)
		submenu.checkbox('useE', 'E: Wuju Style', false)
		submenu.checkbox('useR', 'R: Highlander', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Alpha Strike', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Alpha Strike', true)
		submenu.checkbox('useW', 'W: Meditate', false)
		submenu.checkbox('useE', 'E: Wuju Style', false)
		submenu.checkbox('useR', 'R: Highlander', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Alpha Strike', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		--submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Alpha Strike', 0, 600, 600, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.Leblanc = {
	OnTick = function(target)
	YayoBuddy.Leblanc.Intro()
	if myHero.SpellTimeW < 0 then returnReady = 0 end
	if returnReady == 1 then
		comboYayoBuddy(M, 1300, 1, YayoBuddy.Leblanc.Q, 4, YayoBuddy.Leblanc.R, 3, YayoBuddy.Leblanc.E, 2, YayoBuddy.Leblanc.W)
	else
		comboYayoBuddy(M, 1300, 1, YayoBuddy.Leblanc.Q, 4, YayoBuddy.Leblanc.R, 2, YayoBuddy.Leblanc.W, 3, YayoBuddy.Leblanc.E)
	end
		if CfgYayoBuddy_Leblanc.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.Leblanc.Q, 700, YayoBuddy.Leblanc.W, 1300, YayoBuddy.Leblanc.E, 850, YayoBuddy.Leblanc.R, 700, x) end
		spellFarm(700, YayoBuddy.Leblanc.Q, YayoBuddy.Leblanc.W, YayoBuddy.Leblanc.E, YayoBuddy.Leblanc.R)
		if CfgYayoBuddy_Leblanc.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Leblanc.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Leblanc.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Leblanc.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Leblanc.AutoPotions.Mana_Potion_Value) end
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_Leblanc.SpellOptions.qRNG, mana = (40+(10*myHero.SpellLevelQ)) }
		if not ValidTarget(target) or myHero.SpellLevelQ < 1 or myHero.SpellTimeQ < 1.0 or GetDistance(target) > 700 then
			--if GetDistance(target) > spellData.range or myHero.mana < (spellData.mana or myHero.maxMana * (spellData.manaThreshold / 100)) then 
				return false
			--end
		end
		CastSpellTarget('Q', target)
		if (myHero.SpellLevelQ < 1 and myHero.SpellTimeQ < 1.0) and (myHero.SpellLevelQ < 1 and myHero.SpellTimeR > 1.0) then
			return false
		end
		wTime = (GetClock() + 250)
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_Leblanc.SpellOptions.wRNG, mana = (75+(5*myHero.SpellLevelW)) }
		if myHero.SpellLevelW < 1 or myHero.SpellTimeW < 1.0 then
				return false
		end 
		if not YayoBuddy.Leblanc.ReturnCheck() then
			if ValidTarget(target) and returnReady == 0 then
				if GetDistance(target) < 700 then
					CastSpellTarget('W', target)
				elseif GetDistance(target) < 1200 and (myHero.SpellTimeE > 1.0 or myHero.SpellTimeQ > 1.0 or myHero.SpellTimeR > 1.0) then
					CastSpellTarget('W', target)
				end
			end
		elseif YayoBuddy.Leblanc.ReturnCheck() and (GetClock() - wTime > 0) then
			if ValidTarget(target) then
				if GetDistance(target) < 700 then
					CastSpellTarget('W', target)
				elseif GetDistance(target) < 1200 and (myHero.SpellTimeE > 1.0 or myHero.SpellTimeQ > 1.0 or myHero.SpellTimeR > 1.0) then
					CastSpellTarget('W', target)
				end
			elseif returnready == 1 and not ValidTarget(target) then
				CastSpellTarget('W', myHero)
			end
		end
	end,
	E = function(target)
		local spellData = { range = CfgYayoBuddy_Leblanc.SpellOptions.eRNG, width = 95, speed = 1600, delay = 0.25, mana = 80 }
		if myHero.SpellLevelE < 1 or myHero.SpellTimeE < 1.0 then
			--if GetDistance(target) > spellData.range or myHero.mana < (spellData.mana or myHero.maxMana * (spellData.manaThreshold / 100)) then
				return false
			--end
		end
		if ValidTarget(target) and GetDistance(target) < spellData.range then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, true)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				wTime = GetClock() + 200 * ((850 - GetDistance(target))/850)
				CastSpellXYZ('E', x, y, z)
				if myHero.SpellTimeQ > 1.0 then
					wTime = wTime + 250
				end
			end
		end
	end,
	R = function(target)
		local spellData = { range = 700 }
		if myHero.SpellLevelR < 1 or myHero.SpellTimeR < 1.0 or lastCastQ == 0 then
			--if GetDistance(target) > spellData.range or myHero.mana < (spellData.mana or myHero.maxMana * (spellData.manaThreshold / 100)) then
				return false
			--end
		end
		if ValidTarget(target) and GetDistance(myHero, target) < spellData.range then
			CastSpellTarget('R', target)
			wTime = GetClock() + 250
		end
	end,
	ReturnCheck = function()
		if CfgYayoBuddy_Leblanc.Return then
			return true
		end
		return false
	end,
	OnProcessSpell = function(unit, spell)
		if spell.name == "LeblancChaosOrb" then
			lastCastQ = 1
			print("Q Detected. lastCastQ = "..lastCastQ)
		elseif spell.name == "LeblancSoulShackle" then
			lastCastQ = 0
			print("E Detected. lastCastQ = "..lastCastQ)
		elseif spell.name == "LeblancSlide" then
			wTime = GetClock()
			print("W Detected. wTime = "..wTime)
			lastCastQ = 0
			print("W Detected. lastCastQ = "..lastCastQ)
			returnReady = 1
			print("W Detected. returnReady = "..returnReady)
		elseif spell.name == "leblancslidereturn" then
			returnReady = 0
			print("W Return Detected. returnReady = "..returnReady)
		end
	end,
	OnDraw = function(target)
		if CfgYayoBuddy_Leblanc.Draw.useCDCircles and CfgYayoBuddy_Leblanc.Draw.drawQ then
			if myHero.SpellLevelQ >= 1 and myHero.SpellTimeQ < -1 then
				DrawCircleObject(myHero, (700/(-myHero.SpellTimeQ*-myHero.SpellTimeQ)), CfgYayoBuddy_Leblanc.Draw.colorQ)
			elseif myHero.SpellLevelQ >= 1 and myHero.SpellTimeQ > -1 then
				DrawCircleObject(myHero, 700, CfgYayoBuddy_Leblanc.Draw.colorQ)
			end
		elseif CfgYayoBuddy_Leblanc.Draw.drawQ then
			if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Leblanc.Draw.drawQ then
				DrawCircleObject(myHero, CfgYayoBuddy_Leblanc.SpellOptions.qRNG, CfgYayoBuddy_Leblanc.Draw.colorQ)
			end
		end
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Leblanc.Draw.drawW then
			DrawCircleObject(myHero, CfgYayoBuddy_Leblanc.SpellOptions.wRNG, CfgYayoBuddy_Leblanc.Draw.colorW)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Leblanc.Draw.drawE then
			DrawCircleObject(myHero, CfgYayoBuddy_Leblanc.SpellOptions.eRNG, CfgYayoBuddy_Leblanc.Draw.colorE)
		end
		if CfgYayoBuddy_Leblanc.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Leblanc.RoamHelper.AAnumb, CfgYayoBuddy_Leblanc.RoamHelper.Qnumb, CfgYayoBuddy_Leblanc.RoamHelper.Wnumb, CfgYayoBuddy_Leblanc.RoamHelper.Enumb, CfgYayoBuddy_Leblanc.RoamHelper.Rnumb, CfgYayoBuddy_Leblanc.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Leblanc ", 225, 80, Color.White)
			DrawText("Version "..version, 276, 80, Color.Purple)
			DrawText("Loaded!", 356, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Leblanc, menu = uiconfig.add_menu("YayoBuddy: Leblanc", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Sigil of Malice', true)
		submenu.checkbox('useW', 'W: Distortion', true)
		submenu.checkbox('useE', 'E: Ethereal Chains', true)
		submenu.checkbox('useR', 'R: Mimic', true)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Sigil of Malice', true)
		submenu.checkbox('useW', 'W: Distortion', true)
		submenu.checkbox('useE', 'E: Ethereal Chains', true)
		submenu.checkbox('useR', 'R: Mimic', true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Sigil of Malice', true)
		submenu.checkbox('farmW', 'W: Distortion', true)
		submenu.checkbox('farmE', 'E: Ethereal Chains', true)
		submenu.checkbox('farmR', 'R: Mimic Sigil of Malice', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Sigil of Malice', true)
		submenu.checkbox('useW', 'W: Distortion', true)
		submenu.checkbox('useE', 'E: Ethereal Chains', true)
		submenu.checkbox('useR', 'R: Mimic', true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Sigil of Malice', true)
		submenu.checkbox('farmW', 'W: Distortion', true)
		submenu.checkbox('farmE', 'E: Ethereal Chains', true)
		submenu.checkbox('farmR', 'R: Mimic Sigil of Malice', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Sigil of Malice', true)
		submenu.checkbox('useW', 'W: Distortion', true)
		submenu.checkbox('useE', 'E: Ethereal Chains', true)
		submenu.checkbox('useR', 'R: Mimic', true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Sigil of Malice', true)
		submenu.checkbox('farmW', 'W: Distortion', true)
		submenu.checkbox('farmE', 'E: Ethereal Chains', true)
		submenu.checkbox('farmR', 'R: Mimic Sigil of Malice', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.label('lbl', 'Leblanc does not support mana \n manager vs champions.')
		submenu.label('lbl', ' ')
		--submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		--submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		--submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		--submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Sigil of Malice', 0, 700, 700, nil, true)
		submenu.slider('wRNG', 'W: Distortion', 0, 1300, 1300, nil, true)
		submenu.slider('eRNG', 'E: Ethereal Chains', 0, 850, 850, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('useCDCircles', 'Use Cooldown Circles', true)
		submenu.label('lbl', ' ')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.keytoggle('Return', 'Return', Keys.Z, true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.permashow('Return')
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.MissFortune = {
	OnTick = function(target)
		YayoBuddy.MissFortune.Intro()
		bulletTimeReset()
		comboYayoBuddy(P, 1400, 2, YayoBuddy.MissFortune.W, 1, YayoBuddy.MissFortune.Q, 3, YayoBuddy.MissFortune.E, 4, YayoBuddy.MissFortune.R)
		if CfgYayoBuddy_MissFortune.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.MissFortune.Q, 650, x, x, YayoBuddy.MissFortune.E, 800, YayoBuddy.MissFortune.R, 1400, x) end
		spellFarm(650, YayoBuddy.MissFortune.Q, x, x, x)
		if CfgYayoBuddy_MissFortune.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_MissFortune.AutoPotions.Health_Potion_Value, CfgYayoBuddy_MissFortune.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_MissFortune.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_MissFortune.AutoPotions.Mana_Potion_Value) end
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_MissFortune.SpellOptions.qRNG, mana = (40+(3*myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_MissFortune.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				CastSpellTarget('Q', target)
			end
		end
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_MissFortune.SpellOptions.wRNG, mana = (25 + (5 * myHero.SpellLevelW)), manaThreshold = CfgYayoBuddy_MissFortune.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				CastSpellTarget('W', myHero)
			end
		end
	end,
	E = function(target)
		local spellData = { range = CfgYayoBuddy_MissFortune.SpellOptions.eRNG, width = 300, speed = 500, delay = 0.5, mana = 80, manaThreshold = CfgYayoBuddy_MissFortune.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('E', x, y, z)
				end
			end
		end
	end,
	R = function(target)
		local spellData = { range = CfgYayoBuddy_MissFortune.SpellOptions.rRNG, width = 100, speed = 780, delay = 0.333, mana = 100, manaThreshold = CfgYayoBuddy_MissFortune.ManaManager.manaR }
		if target ~= nil then
			if CfgYayoBuddy_MissFortune.SpellOptions.safeR and SafeR() then
				if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellLevelR >= 1 and myHero.SpellTimeR > 1.0 then
					local CastPosition, HitChance, Position = YP:GetConeAOECastPosition(target, spellData.delay, 30, spellData.range, spellData.speed, myHero, false)
					if HitChance >= 2 then
						local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
						CastSpellXYZ('R', x, y, z)
						yayo.DisableAttacks()
						yayo.DisableMove()
						--timer_BT = os.clock()
					end
				end
			else
				if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellLevelR >= 1 and myHero.SpellTimeR > 1.0 then
				local CastPosition, HitChance, Position = YP:GetConeAOECastPosition(target, spellData.delay, 30, spellData.range, spellData.speed, myHero, false)
					if HitChance >= 2 then
						local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
						CastSpellXYZ('R', x, y, z)
						yayo.DisableAttacks()
						yayo.DisableMove()
						--timer_BT = os.clock()
					end
				end
			end
		end
	end,
	OnProcessSpell = function(unit,spell)
		if unit ~= nil and spell ~= nil and unit.charName == myHero.charName and spell.name == "MissFortuneBulletTime" then
			--yayo.DisableAttacks()
			--yayo.DisableMove()
			timer_BT = os.clock()
			print("Bullet Time Detected. Setting timer_BT.")
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_MissFortune.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_MissFortune.SpellOptions.qRNG, CfgYayoBuddy_MissFortune.Draw.colorQ)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_MissFortune.Draw.drawE then
			DrawCircleObject(myHero, CfgYayoBuddy_MissFortune.SpellOptions.eRNG, CfgYayoBuddy_MissFortune.Draw.colorE)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_MissFortune.Draw.drawR then
			DrawCircleObject(myHero, CfgYayoBuddy_MissFortune.SpellOptions.rRNG, CfgYayoBuddy_MissFortune.Draw.colorR)
		end
		if CfgYayoBuddy_MissFortune.RoamHelper.Enable then roamHelper(CfgYayoBuddy_MissFortune.RoamHelper.AAnumb, CfgYayoBuddy_MissFortune.RoamHelper.Qnumb, CfgYayoBuddy_MissFortune.RoamHelper.Wnumb, CfgYayoBuddy_MissFortune.RoamHelper.Enumb, CfgYayoBuddy_MissFortune.RoamHelper.Rnumb, CfgYayoBuddy_MissFortune.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Miss Fortune ", 225, 80, Color.White)
			DrawText("Version "..version, 306, 80, Color.Purple)
			DrawText("Loaded!", 386, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_MissFortune, menu = uiconfig.add_menu("YayoBuddy: MissFortune", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Double Up', true)
		submenu.checkbox('useW', 'W: Impure Shots', true)
		submenu.checkbox('useE', 'E: Make It Rain', true)
		submenu.checkbox('useR', 'R: Bullet Time', false)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Double Up', true)
		submenu.checkbox('useW', 'W: Impure Shots', false)
		submenu.checkbox('useE', 'E: Make It Rain', false)
		submenu.checkbox('useR', 'R: Bullet Time', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Double Up', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Double Up', false)
		submenu.checkbox('useW', 'W: Impure Shots', false)
		submenu.checkbox('useE', 'E: Make It Rain', false)
		submenu.checkbox('useR', 'R: Bullet Time', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Double Up', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Double Up', true)
		submenu.checkbox('useW', 'W: Impure Shots', false)
		submenu.checkbox('useE', 'E: Make It Rain', false)
		submenu.checkbox('useR', 'R: Bullet Time', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Double Up', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Double Up', 0, 650, 650, nil, true)
		submenu.slider('wRNG', 'W: Impure Shots', 0, 650, 650, nil, true)
		submenu.slider('eRNG', 'E: Make It Rain', 0, 800, 800, nil, true)
		submenu.slider('rRNG', 'R: Bullet Time', 0, 1400, 1400, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SAFE ULTIMATE OPTIONS:')
		submenu.checkbox('safeR', 'Use Safe Ultimate', true)
		submenu.slider('SafeR_Value', 'Safe Zone Range', 0, 2000, 700, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawSafeR', 'Safe R Range', true)
		submenu.slider('colorSafeR', 'Safe R Range Color:', 1, 6, 1, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.Ryze = {
	OnTick = function(target)
		YayoBuddy.Ryze.Intro()
		local ryzeTarget = GetWeakEnemy("MAGIC", 700)
		rangeAdjustRyze(target,CfgYayoBuddy_Ryze._AutoCarry.aaRNG)
		if ryzeTarget ~= nil and GetTargetDirection(ryzeTarget) == FLEEING then
			comboYayoBuddy(M, 600, 2, YayoBuddy.Ryze.W, 1, YayoBuddy.Ryze.Q, 3, YayoBuddy.Ryze.E, 4, YayoBuddy.Ryze.R) -- snare combo
			print("Yayo Buddy: using Ryze Snare Combo")
		else
			comboYayoBuddy(M, 625, 1, YayoBuddy.Ryze.Q, 2, YayoBuddy.Ryze.W, 3, YayoBuddy.Ryze.E, 4, YayoBuddy.Ryze.R) -- standard combo
		end
		if CfgYayoBuddy_Ryze.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.Ryze.Q, 625, YayoBuddy.Ryze.W, 600, YayoBuddy.Ryze.E, 600, YayoBuddy.Ryze.R, 600, x) end
		spellFarm(625, YayoBuddy.Ryze.Q, YayoBuddy.Ryze.W, YayoBuddy.Ryze.E, x)
		if CfgYayoBuddy_Ryze.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Ryze.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Ryze.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Ryze.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Ryze.AutoPotions.Mana_Potion_Value) end
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_Ryze.SpellOptions.qRNG, mana = 60, manaThreshold = CfgYayoBuddy_Ryze.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeQ > 1.0 then
				CastSpellTarget('Q', target)
			end
		end
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_Ryze.SpellOptions.wRNG, mana = (50 + (10 * myHero.SpellLevelW)), manaThreshold = CfgYayoBuddy_Ryze.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeW > 1.0 then
				CastSpellTarget('W', target)
			end
		end
	end,
	E = function(target)
		local spellData = { range = CfgYayoBuddy_Ryze.SpellOptions.eRNG, mana = (70 + (10 * myHero.SpellLevelW)), manaThreshold = CfgYayoBuddy_Ryze.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeE > 1.0 then
				CastSpellTarget('E', target)
			end
		end
	end,
	R = function(target)
		local spellData = { range = CfgYayoBuddy_Ryze.SpellOptions.rRNG }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.SpellLevelR >= 1 and myHero.SpellTimeR > 1.0 and myHero.SpellTimeQ < 1.0 and myHero.SpellTimeW < 1.0 and myHero.SpellTimeE < 1.0 then
				CastSpellTarget('R',myHero)
			end
		end
	end,
	OnProcessSpell = function(unit, spell)
		if unit ~= nil and spell ~= nil and IsHero(unit) then
			if spell.name == "Overload" then
				if CfgYayoBuddy_Ryze.SpellOptions.useRHP and myHero.health <= myHero.maxHealth * (CfgYayoBuddy_Ryze.SpellOptions.rVAL / 100) then 
					CastSpellTarget('R', myHero) 
				end
			end
			print("OnProcessSpell detected for "..unit.name.." spell name: "..spell.name)
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Ryze.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_Ryze.SpellOptions.qRNG, CfgYayoBuddy_Ryze.Draw.colorQ)
		end
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Ryze.Draw.drawW then
			DrawCircleObject(myHero, CfgYayoBuddy_Ryze.SpellOptions.wRNG, CfgYayoBuddy_Ryze.Draw.colorW)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Ryze.Draw.drawE then
			DrawCircleObject(myHero, CfgYayoBuddy_Ryze.SpellOptions.eRNG, CfgYayoBuddy_Ryze.Draw.colorE)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Ryze.Draw.drawR then
			DrawCircleObject(myHero, CfgYayoBuddy_Ryze.SpellOptions.rRNG, CfgYayoBuddy_Ryze.Draw.colorR)
		end
		if CfgYayoBuddy_Ryze.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Ryze.RoamHelper.AAnumb, CfgYayoBuddy_Ryze.RoamHelper.Qnumb, CfgYayoBuddy_Ryze.RoamHelper.Wnumb, CfgYayoBuddy_Ryze.RoamHelper.Enumb, CfgYayoBuddy_Ryze.RoamHelper.Rnumb, CfgYayoBuddy_Ryze.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Ryze ", 225, 80, Color.White)
			DrawText("Version "..version, 261, 80, Color.Purple)
			DrawText("Loaded!", 341, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Ryze, menu = uiconfig.add_menu("YayoBuddy: Ryze", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Overload', true)
		submenu.checkbox('useW', 'W: Rune Prison', true)
		submenu.checkbox('useE', 'E: Spell Flux', true)
		submenu.checkbox('useR', 'R: Desperate Power', false)
		submenu.slider('aaRNG', 'AA Range', 0, 550, 400, nil, true)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Overload', true)
		submenu.checkbox('useW', 'W: Rune Prison', true)
		submenu.checkbox('useE', 'E: Spell Flux', true)
		submenu.checkbox('useR', 'R: Desperate Power', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Overload', true)
		submenu.checkbox('farmW', 'W: Rune Prison', true)
		submenu.checkbox('farmE', 'E: Spell Flux', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Overload', false)
		submenu.checkbox('useW', 'W: Rune Prison', false)
		submenu.checkbox('useE', 'E: Spell Flux', false)
		submenu.checkbox('useR', 'R: Desperate Power', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Overload', true)
		submenu.checkbox('farmW', 'W: Rune Prison', true)
		submenu.checkbox('farmE', 'E: Spell Flux', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Overload', true)
		submenu.checkbox('useW', 'W: Rune Prison', true)
		submenu.checkbox('useE', 'E: Spell Flux', true)
		submenu.checkbox('useR', 'R: Desperate Power', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Overload', true)
		submenu.checkbox('farmW', 'W: Rune Prison', true)
		submenu.checkbox('farmE', 'E: Spell Flux', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Overload', 0, 625, 625, nil, true)
		submenu.slider('wRNG', 'W: Rune Prison', 0, 600, 600, nil, true)
		submenu.slider('eRNG', 'E: Spell Flux', 0, 600, 600, nil, true)
		submenu.slider('rRNG', 'R: Desperate Power', 0, 600, 600, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'Ultimate Options:')
		submenu.checkbox('useRHP', 'Use Ultimate when low HP', true)
		submenu.slider('rVAL', 'R: Health Threshold', 0, 100, 50, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 2, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.Teemo = {
	OnTick = function(target)
		YayoBuddy.Teemo.Intro()
		comboYayoBuddy(M, 580, 1, YayoBuddy.Teemo.Q, 2, YayoBuddy.Teemo.W, x, x, 4, YayoBuddy.Teemo.R)
		if CfgYayoBuddy_Teemo.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.Teemo.Q, 580, x, 0, x, 0, YayoBuddy.Teemo.R, 230, x) end
		spellFarm(580, YayoBuddy.Teemo.Q2, x, x, x)
		if CfgYayoBuddy_Teemo.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Teemo.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Teemo.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Teemo.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Teemo.AutoPotions.Mana_Potion_Value) end
	end,
	AfterAttack = function(target)
		comboYayoBuddy(M, 580, 1, YayoBuddy.Teemo.Q2, x, x, x, x, x, x)
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_Teemo.SpellOptions.qRNG, mana = (60 + (10 * myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_Teemo.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and GetDistance(myHero, target) > myHero.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeQ > 1.0 then
				CastSpellTarget('Q', target)
			end
		end
	end,
	Q2 = function(target)
		local spellData = { range = CfgYayoBuddy_Teemo.SpellOptions.qRNG, mana = (60 + (10 * myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_Teemo.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= myHero.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeQ > 1.0 then
				CastSpellTarget('Q', target)
			end
		end
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_Teemo.SpellOptions.wRNG, mana = 40, manaThreshold = CfgYayoBuddy_Teemo.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeW > 1.0 then
				CastSpellTarget('W', myHero)
			end
		end
	end,
	E = function(target)
		return print("Teemo E no supported functions")
	end,
	R = function(target)
		local spellData = { range = 230, width = 60, speed = math.huge, delay = 0.1, mana = (50 + (25 * myHero.SpellLevelR)), manaThreshold = CfgYayoBuddy_Teemo.ManaManager.manaR }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) and myHero.SpellTimeR > 1.0 then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('R', x, y, z)
				end
			end
		end
	end,
	OnProcessSpell = function(unit, spell)
		if unit ~= nil and spell ~= nil and IsHero(unit) then
			print("OnProcessSpell detected for "..unit.name.." spell name: "..spell.name) -- add shroom detection, store xyz of cast position and then add range check in R(target) against that xyz
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Teemo.Draw.drawQ then
			DrawCircleObject(myHero, CfgYayoBuddy_Teemo.SpellOptions.qRNG, CfgYayoBuddy_Teemo.Draw.colorQ)
		end
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Teemo.Draw.drawW then
			DrawCircleObject(myHero, CfgYayoBuddy_Teemo.SpellOptions.wRNG, CfgYayoBuddy_Teemo.Draw.colorW)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Teemo.Draw.drawR then
			DrawCircleObject(myHero, 230, CfgYayoBuddy_Teemo.Draw.colorR)
		end
		if CfgYayoBuddy_Teemo.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Teemo.RoamHelper.AAnumb, CfgYayoBuddy_Teemo.RoamHelper.Qnumb, CfgYayoBuddy_Teemo.RoamHelper.Wnumb, CfgYayoBuddy_Teemo.RoamHelper.Enumb, CfgYayoBuddy_Teemo.RoamHelper.Rnumb, CfgYayoBuddy_Teemo.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Teemo ", 225, 80, Color.White)
			DrawText("Version "..version, 271, 80, Color.Purple)
			DrawText("Loaded!", 351, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Teemo, menu = uiconfig.add_menu("YayoBuddy: Teemo", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Blinding Dart', true)
		submenu.checkbox('useW', 'W: Move Quick', true)
		submenu.checkbox('useE', 'E: Toxic Shot', false)
		submenu.checkbox('useR', 'R: Noxious Trap', true)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Blinding Dart', true)
		submenu.checkbox('useW', 'W: Move Quick', false)
		submenu.checkbox('useE', 'E: Toxic Shot', false)
		submenu.checkbox('useR', 'R: Noxious Trap', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Blinding Dart', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Blinding Dart', false)
		submenu.checkbox('useW', 'W: Move Quick', false)
		submenu.checkbox('useE', 'E: Toxic Shot', false)
		submenu.checkbox('useR', 'R: Noxious Trap', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Blinding Dart', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Blinding Dart', true)
		submenu.checkbox('useW', 'W: Move Quick', false)
		submenu.checkbox('useE', 'E: Toxic Shot', false)
		submenu.checkbox('useR', 'R: Noxious Trap', true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Blinding Dart', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		--submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Blinding Dart', 0, 1300, 1000, nil, true)
		submenu.slider('wRNG', 'W: Move Quick', 0, 800, 800, nil, true)
		--submenu.slider('eRNG', 'E: 90 Caliber Net', 0, 950, 950, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawSafeR', 'Safe R Range', true)
		submenu.slider('colorSafeR', 'Safe R Range Color:', 1, 6, 1, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.Tristana = {
	OnTick = function(target)
		YayoBuddy.Tristana.Intro()
		if CfgYayoBuddy_Tristana.TristMode == 1 then
			comboYayoBuddy(P, 900, 1, YayoBuddy.Tristana.Q, 2, YayoBuddy.Tristana.W, 3, YayoBuddy.Tristana.E, 4, YayoBuddy.Tristana.R)
		elseif CfgYayoBuddy_Tristana.TristMode == 2 then
			comboYayoBuddy(M, 900, 2, YayoBuddy.Tristana.W, 3, YayoBuddy.Tristana.E, 4, YayoBuddy.Tristana.R, 1, YayoBuddy.Tristana.Q)
		end
		if CfgYayoBuddy_Tristana.KillSteals.ks_ONOFF then killStealTest(x, x, YayoBuddy.Tristana.W, 900, YayoBuddy.Tristana.E, myHero.range, YayoBuddy.Tristana.R, myHero.range, x) end --add ignite
		spellFarm(myHero.range, x, YayoBuddy.Tristana.W, YayoBuddy.Tristana.E, x)
		if CfgYayoBuddy_Tristana.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Tristana.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Tristana.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Tristana.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Tristana.AutoPotions.Mana_Potion_Value) end
	end,
	AfterAttack = function(target)
		
	end,
	Q = function(target)
		local spellData = { range = myHero.range, mana = 0 }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana then
				CastSpellTarget('Q', myHero)
			end
		end
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_Tristana.SpellOptions.wRNG, width = 270, speed = 1150, delay = 0.5, mana = 60, manaThreshold = CfgYayoBuddy_Tristana.ManaManager.manaW }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= 50 and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				if CfgYayoBuddy_Tristana.SpellOptions.safeW and SafeW(target) then
					if CfgYayoBuddy_Tristana.SpellOptions.RocketMode == 1 then
						CastSpellXYZ('W', mousePos.x, mousePos.y, mousePos.z)
					elseif CfgYayoBuddy_Tristana.SpellOptions.RocketMode == 2 then
						local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
						if HitChance >= 2 then
							local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
							CastSpellXYZ('W', x, y, z)
						end
					end
				else
					if CfgYayoBuddy_Tristana.SpellOptions.RocketMode == 1 then
						CastSpellXYZ('W', mousePos.x, mousePos.y, mousePos.z)
					elseif CfgYayoBuddy_Tristana.SpellOptions.RocketMode == 2 then
						local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
						if HitChance >= 2 then
							local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
							CastSpellXYZ('W', x, y, z)
						end
					end
				end
			end
		end
	end,
	E = function(target)
		local spellData = { range = 550, mana = (40 + (10 * myHero.SpellLevel * 10)), manaThreshold = CfgYayoBuddy_Tristana.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				CastSpellTarget('E', target)
			end
		end
	end,
	R = function(target)
		local spellData = { range = myHero.range, mana = 100, manaThreshold = CfgYayoBuddy_Tristana.ManaManager.manaR }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= 100 and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				CastSpellTarget('R',target)
			end
		end
	end,
	OnProcessSpell = function(unit, spell)
		if unit ~= nil and spell ~= nil and IsHero(unit) then
			print("OnProcessSpell detected for "..unit.name.." spell name: "..spell.name) --add interrupts / anti gap closer
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Tristana.Draw.drawW then
			DrawCircleObject(myHero, CfgYayoBuddy_Tristana.SpellOptions.wRNG, CfgYayoBuddy_Tristana.Draw.colorW)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Tristana.Draw.drawE then
			DrawCircleObject(myHero, myHero.range, CfgYayoBuddy_Tristana.Draw.colorE)
		end
		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Tristana.Draw.drawR then
			DrawCircleObject(myHero, myHero.range, CfgYayoBuddy_Tristana.Draw.colorR)
		end
		if CfgYayoBuddy_Tristana.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Tristana.RoamHelper.AAnumb, CfgYayoBuddy_Tristana.RoamHelper.Qnumb, CfgYayoBuddy_Tristana.RoamHelper.Wnumb, CfgYayoBuddy_Tristana.RoamHelper.Enumb, CfgYayoBuddy_Tristana.RoamHelper.Rnumb, CfgYayoBuddy_Tristana.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Tristana ", 225, 80, Color.White)
			DrawText("Version "..version, 281, 80, Color.Purple)
			DrawText("Loaded!", 361, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Tristana, menu = uiconfig.add_menu("YayoBuddy: Tristana", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Rapid Fire', true)
		submenu.checkbox('useW', 'W: Rocket Jump', false)
		submenu.checkbox('useE', 'E: Explosive Shot', true)
		submenu.checkbox('useR', 'R: Buster Shot', false)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Rapid Fire', true)
		submenu.checkbox('useW', 'W: Rocket Jump', false)
		submenu.checkbox('useE', 'E: Explosive Shot', true)
		submenu.checkbox('useR', 'R: Buster Shot', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Rapid Fire', false)
		submenu.checkbox('farmW', 'W: Rocket Jump', false)
		submenu.checkbox('farmE', 'E: Explosive Shot', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Rapid Fire', false)
		submenu.checkbox('useW', 'W: Rocket Jump', false)
		submenu.checkbox('useE', 'E: Explosive Shot', true)
		submenu.checkbox('useR', 'R: Buster Shot', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Rapid Fire', false)
		submenu.checkbox('farmW', 'W: Rocket Jump', false)
		submenu.checkbox('farmE', 'E: Explosive Shot', true)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Rapid Fire', true)
		submenu.checkbox('useW', 'W: Rocket Jump', false)
		submenu.checkbox('useE', 'E: Explosive Shot', true)
		submenu.checkbox('useR', 'R: Buster Shot', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Rapid Fire', false)
		submenu.checkbox('farmW', 'W: Rocket Jump', false)
		submenu.checkbox('farmE', 'E: Explosive Shot', true)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('wRNG', 'W: Rocket Jump', 0, 800, 800, nil, true)
		submenu.slider('RocketMode', 'Rocket Jump Mode:', 1, 2, 1, {"To Mouse","To Target"})
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SAFE JUMP OPTIONS:')
		submenu.checkbox('safeW', 'Use Safe Jump', true)
		submenu.slider('SafeW_Value', 'Safe Zone Range', 0, 2000, 700, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawSafeW', 'Safe W Range', true)
		submenu.slider('colorSafeW', 'Safe W Range Color:', 1, 6, 1, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.slider('TristMode', 'Choose AD or AP', 1, 2, 1, {"AD","AP"})
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

YayoBuddy.Vayne = {
	OnTick = function(target)
		YayoBuddy.Vayne.Intro()
		if CfgYayoBuddy_Vayne.ActiveItems.smartBWC then smartBWC(target) end
		if CfgYayoBuddy_Vayne.ActiveItems.smartBOTRK then smartBOTRK(target) end
		spellFarm(myHero.range, YayoBuddy.Vayne.Q, x, x, x)
		if CfgYayoBuddy_Vayne.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Vayne.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Vayne.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Vayne.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Vayne.AutoPotions.Mana_Potion_Value) end
		if target ~= nil and CfgYayoBuddy_Vayne.SpellOptions.Vayne_AutoCondemn then
			if WillHitWall(target,440) == 1 and (GetDistance(myHero, target) <= 550) then
				CastSpellTarget('E', target)
			end
		end
	end,
	AfterAttack = function(target)
		comboYayoBuddy(P, 550, 1, YayoBuddy.Vayne.Q, x, x, x, x, x, x)
	end,
	Q = function(target)
		local spellData = { range = myHero.range, mana = 30, manaThreshold = CfgYayoBuddy_Vayne.ManaManager.manaQ }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				CastSpellXYZ('Q', mousePos.x, mousePos.y, mousePos.z)
			end
		end
	end,
	W = function(target)
		print('Error calling Vayne W spell')
	end,
	E = function(target)
		local spellData = { range = 550, mana = 90, manaThreshold = CfgYayoBuddy_Vayne.ManaManager.manaE }
		if target ~= nil then
			if GetDistance(myHero, target) <= spellData.range and myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
				CastSpellTarget('E', target)
			end
		end
	end,
	R = function(target)
		print('Error calling Vayne R spell')
	end,
	OnProcessSpell = function(unit, spell)
		local InterruptList = {"CaitlynAceintheHole","Crowstorm","DrainChannel","GalioIdolOfDurand","FallenOne","KatarinaR","AlZaharNetherGrasp","MissFortuneBulletTime","AbsoluteZero","Pantheon_GrandSkyfall_Jump","ShenStandUnited","UrgotSwap2","VarusQ","InfiniteDuress","JaxCounterStrike"}
		local GapCloserTargetList = {"AkaliShadowDance", "Headbutt", "DianaTeleport", "IreliaGatotsu", "JaxLeapStrike", "JayceToTheSkies", "MaokaiUnstableGrowth", "MonkeyKingNimbus", "Pantheon_LeapBash", "PoppyHeroicCharge", "QuinnE", "XenZhaoSweep", "blindmonkqtwo", "FizzPiercingStrike", "RengarLeap"}
		local GapCloserNoTargetList = {"AatroxQ", "GragasE", "GravesMove", "HecarimUlt", "JarvanIVDragonStrike", "JarvanIVCataclysm", "KhazixE", "khazixelong", "LeblancSlide", "LeblancSlideM", "LeonaZenithBlade", "UFSlash", "RenektonSliceAndDice", "SejuaniArcticAssault", "ShenShadowDash", "RocketJump", "slashCast"}
		if unit ~= nil and spell ~= nil and IsHero(unit) then
			print("SpellName: "..spell.name)
			if CfgYayoBuddy_Vayne.SpellOptions.Interrupt then
				for _, interrupt in pairs(InterruptList) do
					if spell.name == interrupt then
						YayoBuddy.Vayne.E(unit)
					end
				end
			end
			if CfgYayoBuddy_Vayne.SpellOptions.AntiGapCloser then
				for _, gapclosertarget in pairs(GapCloserTargetList) do
					if spell.name == gapclosertarget and spell.target ~= nil then
						if IsHero(spell.target) and spell.target.charName == myHero.charName then
							YayoBuddy.Vayne.E(unit)
						end
					end
				end
				for _, gapclosernotarget in pairs(GapCloserNoTargetList) do
					if spell.name == gapclosernotarget then
						if GetDistance(spell.endPos) <= 250 then
							YayoBuddy.Vayne.E(unit)
						end
					end
				end
			end
		end
	end,
	OnDraw = function(target)
		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Vayne.Draw.drawQ then
			DrawCircleObject(myHero, 300, CfgYayoBuddy_Vayne.Draw.colorQ)
		end
		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Vayne.Draw.drawE then
			DrawCircleObject(myHero, 550, CfgYayoBuddy_Vayne.Draw.colorE)
		end
		if CfgYayoBuddy_Vayne.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Vayne.RoamHelper.AAnumb, CfgYayoBuddy_Vayne.RoamHelper.Qnumb, CfgYayoBuddy_Vayne.RoamHelper.Wnumb, CfgYayoBuddy_Vayne.RoamHelper.Enumb, CfgYayoBuddy_Vayne.RoamHelper.Rnumb, CfgYayoBuddy_Vayne.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Vayne ", 225, 80, Color.White)
			DrawText("Version "..version, 266, 80, Color.Purple)
			DrawText("Loaded!", 346, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Vayne, menu = uiconfig.add_menu("YayoBuddy: Vayne", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Tubmle', true)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Tumble', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Tumble', true)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Tumble', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.label('farmQ', 'Q: LastHit Not Supported', false)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: LastHit Not Supported', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.label('farmQ', 'Q: Tumble', false)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.label('lbl', 'Vayne spell ranges are \n not adjustable.')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'AUTO CONDEMN:')
		submenu.checkbutton('Vayne_AutoCondemn', 'Use LB API Auto Condemn', false)
		submenu.checkbutton('Vayne_AutoCondemnVMA', 'Use Vayne Mighty Assistant', true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'INTERRUPT CHANNELED SPELLS:')
		submenu.checkbox('Interrupt', 'Interrupt', true)
		submenu.label('lbl', 'ANTI GAP CLOSER:')
		submenu.checkbox('AntiGapCloser', 'Anti Gap Closer', true)
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('ActiveItems')
		submenu.checkbox('smartBWC', 'Smart Bilgewater Cutless', true)
		submenu.checkbox('smartBOTRK', 'Smart Blade of the Ruined King', true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Tumble Distance', true)
		submenu.slider('colorQ', 'Tumble Distance Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 4, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 2, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		--submenu.checkbox('silverbolts', 'Silver Bolts Damage', true)
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
		if myHero.name == "Vayne" and CfgYayoBuddy_Vayne.SpellOptions.Vayne_AutoCondemnVMA then
			require "vayne_mighty_assistant"
		end
	end
}

YayoBuddy.Veigar = {
	OnTick = function(target)
		YayoBuddy.Veigar.Intro()
		YayoBuddy.Veigar.DFGandUltTest()
		comboYayoBuddy(M, 900, 3, YayoBuddy.Veigar.E, 2, YayoBuddy.Veigar.W, 4, YayoBuddy.Veigar.R, 1, YayoBuddy.Veigar.Q)
		if CfgYayoBuddy_Veigar.KillSteals.ks_ONOFF then killStealTest(YayoBuddy.Veigar.Q, 650, YayoBuddy.Veigar.W, 650, YayoBuddy.Veigar.E, 900, YayoBuddy.Veigar.R, 650, x) end
		spellFarm(650, YayoBuddy.Veigar.Q, YayoBuddy.Veigar.W, x, x)
		if CfgYayoBuddy_Veigar.AutoPotions.AutoPotions_ONOFF then autoPotions(CfgYayoBuddy_Veigar.AutoPotions.Health_Potion_Value, CfgYayoBuddy_Veigar.AutoPotions.Chrystalline_Flask_Value, CfgYayoBuddy_Veigar.AutoPotions.Elixir_of_Fortitude_Value, CfgYayoBuddy_Veigar.AutoPotions.Mana_Potion_Value) end
	end,
	Q = function(target)
		local spellData = { range = CfgYayoBuddy_Veigar.SpellOptions.qRNG, mana = (55+(10*myHero.SpellLevelQ)), manaThreshold = CfgYayoBuddy_Veigar.ManaManager.manaQ }
		if target == nil or myHero.SpellLevelQ < 1 or myHero.SpellTimeQ < 1.0 or GetDistance(target) > spellData.range then
			return false
		end
		if myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
			CastSpellTarget('Q', target)
		end
	end,
	W = function(target)
		local spellData = { range = CfgYayoBuddy_Veigar.SpellOptions.wRNG, width = 230, speed = 1.25, delay = 0.5, mana = (70+(10*myHero.SpellLevelW)), manaThreshold = CfgYayoBuddy_Veigar.ManaManager.manaW } --add spell info
		if target == nil or myHero.SpellLevelW < 1 or myHero.SpellTimeW < 1.0 or GetDistance(target) > spellData.range then
			return false
		end
		if GetTargetDirection(target) ~= STATIONARY then
			return false
		end
		if myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
			local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('W', x, y, z)
			end
		end
	end,
	E = function(target)
		local spellData = { range = CfgYayoBuddy_Veigar.SpellOptions.eRNG, width = 330, speed = 0.34, delay = 0.5, mana = (75+(50*myHero.SpellLevelE)), manaThreshold = CfgYayoBuddy_Veigar.ManaManager.manaE } --add spell info
		if target == nil or myHero.SpellLevelE < 1 or myHero.SpellTimeE < 1.0 or GetDistance(target) > spellData.range then
			return false
		end
		if myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
			local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, spellData.delay, spellData.width, spellData.range, spellData.speed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('E', x, y, z)
			end
		end
	end,
	R = function(target)
		local spellData = { range = CfgYayoBuddy_Veigar.SpellOptions.rRNG, mana = (75+(50*myHero.SpellLevelR)), manaThreshold = CfgYayoBuddy_Veigar.ManaManager.manaR }
		if target == nil or myHero.SpellLevelR < 1 or myHero.SpellTimeR < 1.0 or GetDistance(target) > spellData.range then
			return false
		end
		if myHero.mana >= spellData.mana and myHero.mana >= myHero.maxMana * (spellData.manaThreshold / 100) then
			CastSpellTarget('R', target)
		end
	end,
	BeforeAttack = function(target)
		spellFarm(650, YayoBuddy.Veigar.Q, x, x, x)
	end,
	DFGandUltTest = function()
		for i = 1, objManager:GetMaxHeroes() do
		local enemy = objManager:GetHero(i)
			if (enemy and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
				local DFGdmg = getDmg('DFG', enemy, myHero)
				local Rdmg = getDmg('R', enemy, myHero)+(getDmg('R', enemy, myHero)*.20)
				if DFGdmg + Rdmg > enemy.health and GetDistance(enemy) < 650 then
					useDeathfireGrasp(enemy)
					YayoBuddy.Veigar.R(enemy)
				end
			end
		end

	end,
	OnDraw = function(target)
		if CfgYayoBuddy_Veigar.Draw.drawQ and CfgYayoBuddy_Veigar.Draw.qType == 1 then
			if myHero.SpellLevelQ >= 1 and myHero.SpellTimeQ < -1 then
				DrawCircleObject(myHero, (CfgYayoBuddy_Veigar.SpellOptions.qRNG/(-myHero.SpellTimeQ*-myHero.SpellTimeQ)), CfgYayoBuddy_Veigar.Draw.colorQ)
			elseif myHero.SpellLevelQ >= 1 and myHero.SpellTimeQ > -1 then
				DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.qRNG, CfgYayoBuddy_Veigar.Draw.colorQ)
			end
		elseif CfgYayoBuddy_Veigar.Draw.drawQ and CfgYayoBuddy_Veigar.Draw.qType == 2 then
			if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Veigar.Draw.drawQ then
				DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.qRNG, CfgYayoBuddy_Veigar.Draw.colorQ)
			end
		end
--		if myHero.SpellTimeQ > 1.0 and myHero.SpellLevelQ >= 1 and CfgYayoBuddy_Veigar.Draw.drawQ then
--			DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.qRNG, CfgYayoBuddy_Veigar.Draw.colorQ)
--		end
		if CfgYayoBuddy_Veigar.Draw.drawW and CfgYayoBuddy_Veigar.Draw.wType == 1 then
			if myHero.SpellLevelW >= 1 and myHero.SpellTimeW < -1 then
				DrawCircleObject(myHero, (CfgYayoBuddy_Veigar.SpellOptions.wRNG/(-myHero.SpellTimeW*-myHero.SpellTimeW)), CfgYayoBuddy_Veigar.Draw.colorW)
			elseif myHero.SpellLevelW >= 1 and myHero.SpellTimeW > -1 then
				DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.wRNG, CfgYayoBuddy_Veigar.Draw.colorW)
			end
		elseif CfgYayoBuddy_Veigar.Draw.drawW and CfgYayoBuddy_Veigar.Draw.wType == 2 then
			if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Veigar.Draw.drawW then
				DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.wRNG, CfgYayoBuddy_Veigar.Draw.colorW)
			end
		end
--		if myHero.SpellTimeW > 1.0 and myHero.SpellLevelW >= 1 and CfgYayoBuddy_Veigar.Draw.drawW then
--			DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.wRNG, CfgYayoBuddy_Veigar.Draw.colorW)
--		end
		if CfgYayoBuddy_Veigar.Draw.drawE and CfgYayoBuddy_Veigar.Draw.eType == 1 then
			if myHero.SpellLevelE >= 1 and myHero.SpellTimeE < -1 then
				DrawCircleObject(myHero, (CfgYayoBuddy_Veigar.SpellOptions.eRNG/(-myHero.SpellTimeE*-myHero.SpellTimeE)), CfgYayoBuddy_Veigar.Draw.colorE)
			elseif myHero.SpellLevelE >= 1 and myHero.SpellTimeE > -1 then
				DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.eRNG, CfgYayoBuddy_Veigar.Draw.colorE)
			end
		elseif CfgYayoBuddy_Veigar.Draw.drawE and CfgYayoBuddy_Veigar.Draw.eType == 2 then
			if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Veigar.Draw.drawE then
				DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.eRNG, CfgYayoBuddy_Veigar.Draw.colorE)
			end
		end
--		if myHero.SpellTimeE > 1.0 and myHero.SpellLevelE >= 1 and CfgYayoBuddy_Veigar.Draw.drawE then
--			DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.eRNG, CfgYayoBuddy_Veigar.Draw.colorE)
--		end
		if CfgYayoBuddy_Veigar.Draw.drawR and CfgYayoBuddy_Veigar.Draw.rType == 1 then
			if myHero.SpellLevelR >= 1 and myHero.SpellTimeR < -1 then
				DrawCircleObject(myHero, (CfgYayoBuddy_Veigar.SpellOptions.rRNG/(-myHero.SpellTimeR*-myHero.SpellTimeR)), CfgYayoBuddy_Veigar.Draw.colorR)
			elseif myHero.SpellLevelR >= 1 and myHero.SpellTimeR > -1 then
				DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.rRNG, CfgYayoBuddy_Veigar.Draw.colorR)
			end
		elseif CfgYayoBuddy_Veigar.Draw.drawR and CfgYayoBuddy_Veigar.Draw.rType == 2 then
			if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Veigar.Draw.drawR then
				DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.rRNG, CfgYayoBuddy_Veigar.Draw.colorR)
			end
		end
--		if myHero.SpellTimeR > 1.0 and myHero.SpellLevelR >= 1 and CfgYayoBuddy_Veigar.Draw.drawR then
--			DrawCircleObject(myHero, CfgYayoBuddy_Veigar.SpellOptions.rRNG, CfgYayoBuddy_Veigar.Draw.colorR)
--		end
		if CfgYayoBuddy_Veigar.RoamHelper.Enable then roamHelper(CfgYayoBuddy_Veigar.RoamHelper.AAnumb, CfgYayoBuddy_Veigar.RoamHelper.Qnumb, CfgYayoBuddy_Veigar.RoamHelper.Wnumb, CfgYayoBuddy_Veigar.RoamHelper.Enumb, CfgYayoBuddy_Veigar.RoamHelper.Rnumb, CfgYayoBuddy_Veigar.RoamHelper.ignite) end
	end,
	Intro = function()
		if GetClock() > introTimer + 15000 then
			return false
		end
			DrawText("CCONN's Yayo Buddy: ", 100, 80, Color.White)
			DrawText("Veigar ", 225, 80, Color.White)
			DrawText("Version "..version, 266, 80, Color.Purple)
			DrawText("Loaded!", 346, 80, Color.Green)
			DrawText("Don't forget to donate and +Rep!", 100, 100, Color.Gray)
			DrawText("www.Facebook.com/CCONN81", 100, 115, Color.Gray)
	end,
	Menu = function()
		CfgYayoBuddy_Veigar, menu = uiconfig.add_menu("YayoBuddy: Veigar", 200)
		local submenu = menu.submenu('_AutoCarry')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Baleful Strike', true)
		submenu.checkbox('useW', 'W: Dark Matter', true)
		submenu.checkbox('useE', 'E: Event Horizon', true)
		submenu.checkbox('useR', 'R: Primordial Burst', false)
		local submenu = menu.submenu('_LaneClear')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Baleful Strike', false)
		submenu.checkbox('useW', 'W: Dark Matter', false)
		submenu.checkbox('useE', 'E: Event Horizon', true)
		submenu.checkbox('useR', 'R: Primordial Burst', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Baleful Strike', true)
		submenu.checkbox('farmW', 'W: Dark Matter', false)
		local submenu = menu.submenu('_LastHit')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Baleful Strike', true)
		submenu.checkbox('useW', 'W: Dark Matter', false)
		submenu.checkbox('useE', 'E: Event Horizon', false)
		submenu.checkbox('useR', 'R: Primordial Burst', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Baleful Strike', true)
		submenu.checkbox('farmW', 'W: Dark Matter', false)
		local submenu = menu.submenu('_MixedMode')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS CHAMPIONS:')
		submenu.checkbox('useQ', 'Q: Baleful Strike', false)
		submenu.checkbox('useW', 'W: Dark Matter', false)
		submenu.checkbox('useE', 'E: Event Horizon', false)
		submenu.checkbox('useR', 'R: Primordial Burst', false)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'USE VS MINIONS:')
		submenu.checkbox('farmQ', 'Q: Baleful Strike', true)
		submenu.checkbox('farmW', 'W: Dark Matter', false)
		local submenu = menu.submenu('ManaManager')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS CHAMPIONS:')
		submenu.slider('manaQ','Q Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaW','W Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaE','E Mana Threshold', 0, 100, 0, nil, true)
		submenu.slider('manaR','R Mana Threshold', 0, 100, 0, nil, true)
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'MANA MANAGER: VS MINIONS:')
		submenu.slider('manaSpellFarm','Spell Farm Mana Threshold', 0, 100, 75, nil, true)
		local submenu = menu.submenu('SpellOptions')
		submenu.label('lbl', '--------------------')
		submenu.label('lbl', 'SPELL RANGES:')
		submenu.slider('qRNG', 'Q: Baleful Strike', 0, 650, 650, nil, true)
		submenu.slider('wRNG', 'W: Dark Matter', 0, 900, 650, nil, true)
		submenu.slider('eRNG', 'E: Event Horizon', 0, 650, 650, nil, true)
		submenu.slider('rRNG', 'R: Primordial Burst', 0, 650, 650, nil, true)
		local submenu = menu.submenu('KillSteals')
		submenu.checkbutton('ks_ONOFF', 'Enable Kill Steals', true)
		submenu.checkbox('ksQ', 'Kill Steal with Q', true)
		submenu.checkbox('ksW', 'Kill Steal with W', true)
		submenu.checkbox('ksE', 'Kill Steal with E', true)
		submenu.checkbox('ksR', 'Kill Steal with R', true)
		submenu.checkbox('ksI', 'Kill Steal with Ignite', true)
		submenu.label('lbl', ' ')
		submenu.label('lbl', '31 possible kill steal combinations. \n Unchecking a spell will disable all \n possible combinations for that spell.')
		submenu.label('lbl', ' ')
		submenu.label('lbl', ' ')
		local submenu = menu.submenu('AutoPotions')
		submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
		submenu.checkbox('Health_Potion_ONOFF', 'Health Potions', true)
		submenu.checkbox('Mana_Potion_ONOFF', 'Mana Potions', true)
		submenu.checkbox('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
		submenu.checkbox('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
		submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
		submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
		submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
		local submenu = menu.submenu('Draw')
		submenu.checkbox('drawQ', 'Q Range', true)
		submenu.slider('qType', 'Q Circle Type:', 1, 2, 1, {"Cool Down Circles","Standard Circles"})
		submenu.slider('colorQ', 'Q Range Color:', 1, 6, 4, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawW', 'W Range', true)
		submenu.slider('wType', 'W Circle Type:', 1, 2, 2, {"Cool Down Circles","Standard Circles"})
		submenu.slider('colorW', 'W Range Color:', 1, 6, 5, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawE', 'E Range', true)
		submenu.slider('eType', 'E Circle Type:', 1, 2, 2, {"Cool Down Circles","Standard Circles"})
		submenu.slider('colorE', 'E Range Color:', 1, 6, 6, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		submenu.checkbox('drawR', 'R Range', true)
		submenu.slider('rType', 'R Circle Type:', 1, 2, 2, {"Cool Down Circles","Standard Circles"})
		submenu.slider('colorR', 'R Range Color:', 1, 6, 2, {"Green","Red", "Aqua", "Light Purple", "Blue", "Dark Purple"})
		local submenu = menu.submenu('RoamHelper')
		submenu.checkbutton('Enable', 'Enable Roam Helper', true)
		submenu.slider('AAnumb', 'Number of AAs', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Qnumb', 'Number of Qs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Wnumb', 'Number of Ws', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Enumb', 'Number of Es', 0, 10, 0, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.slider('Rnumb', 'Number of Rs', 0, 10, 1, {"1","2", "3", "4", "5", "6", "7", "8", "9", "10"})
		submenu.checkbox('ignite', 'Summoner Ignite', true)
		menu.checkbutton('useItems', 'Use Active Items', true)
		menu.label('lbl1', ' ')
		menu.label('lbl2', 'CCONNs Yayo Buddy Version '..version)
		menu.label('lbl3', 'www.facebook.com/CCONN81')
	end
}

-------------------GLOBAL FUNCTIONS

function smartBOTRK(target)
	if target == nil or GetInventorySlot(3153) == nil then 
		return false 
	end
	local dmgBOTRK = getDmg('RUINEDKING', target, myHero, 2)
	local healthMissing = (myHero.maxHealth - myHero.health)
	if healthMissing >= dmgBOTRK and GetDistance(target) <= 450 then 
		useBOTRK(target) 
	end  
end

function smartBWC(target)
	if target == nil or GetInventorySlot(3144) == nil then 
		return false
	end
	local dmgBWC = getDmg('BWC', target, myHero)
	local healthMissing = (myHero.maxHealth - myHero.health)
	if healthMissing >= dmgBWC and GetDistance(target) <= 450 then useBWC(target) end  
end

function useDeathfireGrasp(target)
	if target ~= nil then
		GetInventorySlot(3128)
		UseItemOnTarget(3128,target)
	end
end

function useBFT(target)
	if target ~= nil then
		GetInventorySlot(3188)
		UseItemOnTarget(3188,target)
	end
end

function useBWC(target)
	if target ~= nil then
		GetInventorySlot(3144)
		UseItemOnTarget(3144,target)
	end
end

function useBOTRK(target)
	if target ~= nil then
		GetInventorySlot(3153)
		UseItemOnTarget(3153,target)
	end
end


function rangeAdjustRyze(target, range)
	if yayo.Config.AutoCarry and target == nil then
		yayo.DisableAttacks()
	end
	if target ~= nil then
		if GetDistance(target, myHero) >= range and GetTargetDirection(target) ~= CHASING then
			yayo.DisableAttacks()
		elseif GetDistance(target, myHero) < range then
			yayo.EnableAttacks()
		end
	end
	if yayo.Config.LastHit or yayo.Config.Mixed or yayo.Config.LaneClear then
		yayo.EnableAttacks()
	end
end

function GetTargetDirection(target)
	local distanceTarget = GetDistance(target)
    local x1, y1, z1 = GetFireahead(target,2,10)
    local distancePredicted = GetDistance({x = x1, y = y1, z = z1})
	
	return (distanceTarget > distancePredicted and CHASING or (distanceTarget < distancePredicted and FLEEING or STATIONARY))
end

function DetectPoison(target)
    for i = 1, objManager:GetMaxObjects(), 1 do
        obj = objManager:GetObject(i)
        if obj~=nil and target~=nil then
            if (obj.charName:lower():find("global_poison")) and GetDistance(obj, target) < 100 then
                return true
            end
        end
    end
end

function bulletTimeReset()
	if timer_BT ~= nil then
		if os.clock() > timer_BT + 2 then
			yayo.EnableAttacks()
			yayo.EnableMove()
			timer_BT = nil
			print("Bullet Time fully channeled. Enabling movement & attacks. Clearing timer_BT.")
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

function createEnemyTable()
	for i = 1, objManager:GetMaxHeroes(), 1 do
		Hero = objManager:GetHero(i)
		if Hero ~= nil and Hero.team ~= myHero.team then
			if Enemies[Hero.name] == nil then
				Enemies[Hero.name] = { Unit = Hero, Number = EnemyIndex }
				EnemyIndex = EnemyIndex + 1
			end
		end
	end
end

function createAllyTable()
	for i = 1, objManager:GetMaxHeroes(), 1 do
		Hero = objManager:GetHero(i)
		if Hero ~= nil and Hero.team == myHero.team then
			if Allies[Hero.name] == nil then
				Allies[Hero.name] = { Unit = Hero, Number = AllyIndex }
				AllyIndex = AllyIndex + 1
			end
		end
	end
end

function getAceRange()
	if myHero.SpellLevelR == 1 then
		return 2000
	elseif myHero.SpellLevelR == 2 then
		return 2500
	elseif myHero.SpellLevelR == 3 then
		return 3000
	else
		return 0
	end
end

function SafeR()
	local menu = getMenu()
	if CountUnit(myHero,menu.SpellOptions.SafeR_Value) < 1 then
		return true
	end
	return false
end

function SafeW(target)
	if CountUnit(target,CfgYayoBuddy_Tristana.SpellOptions.SafeW_Value) < 1 then
		return true
	end
	return false
end

function GetWRange()
	if myHero.SpellLevelW == 1 then
		return 630
	elseif myHero.SpellLevelW == 2 then
		return 650
	elseif myHero.SpellLevelW == 3 then
		return 670
	elseif myHero.SpellLevelW == 4 then
		return 690
	elseif myHero.SpellLevelW == 5 then
		return 710
	else
		return 0
	end
end

function GetRRange()
	if myHero.SpellLevelR == 1 then
		return 1200
	elseif myHero.SpellLevelR == 2 then
		return 1500
	elseif myHero.SpellLevelR == 3 then
		return 1800
	else
		return 0
	end
end

function StackCheck()
	if (myHero.SpellLevelR == 1 and stacks < CfgYayoBuddy_KogMaw.SpellOptions.RStack1)
	or (myHero.SpellLevelR == 2 and stacks < CfgYayoBuddy_KogMaw.SpellOptions.RStack2)
	or (myHero.SpellLevelR == 3 and stacks < CfgYayoBuddy_KogMaw.SpellOptions.RStack3) then
		return true
	end
	return false
end

function StackReset()
	if os.time() > timer_R + 6.5 then 
		stacks = 0
	end
end

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

function IsHero(unit)
	for i=1, objManager:GetMaxHeroes(), 1 do
		local object = objManager:GetHero(i)
		if object ~= nil and object.charName == unit.charName then
			return true
		end
	end
	return false
end

function getMenu()
	if myHero.name == "Ahri" then
		return CfgYayoBuddy_Ahri
	elseif myHero.name == "Caitlyn" then
		return CfgYayoBuddy_Caitlyn
	elseif myHero.name == "Cassiopeia" then
		return CfgYayoBuddy_Cassiopeia
	elseif myHero.name == "Corki" then
		return CfgYayoBuddy_Corki
	elseif myHero.name == "Ezreal" then
		return CfgYayoBuddy_Ezreal
	elseif myHero.name == "Graves" then
		return CfgYayoBuddy_Graves
	elseif myHero.name == "KogMaw" then
		return CfgYayoBuddy_KogMaw
	elseif myHero.name == "Leblanc" then
		return CfgYayoBuddy_Leblanc
	elseif myHero.name == "MasterYi" then
		return CfgYayoBuddy_MasterYi
	elseif myHero.name == "MissFortune" then
		return CfgYayoBuddy_MissFortune
	elseif myHero.name == "Ryze" then
		return CfgYayoBuddy_Ryze
	elseif myHero.name == "Teemo" then
		return CfgYayoBuddy_Teemo
	elseif myHero.name == "Tristana" then
		return CfgYayoBuddy_Tristana
	elseif myHero.name == "Veigar" then
		return CfgYayoBuddy_Veigar
	elseif myHero.name == "Vayne" then
		return CfgYayoBuddy_Vayne
	else
		return CfgYayoBuddy_Unsupported
	end
	return nil
end

function autoPotions(healthval, flaskval, elixirval, manaval)
	local menu = getMenu()
	if bluePill == nil then
		if menu.AutoPotions.Health_Potion_ONOFF and myHero.health <= myHero.maxHealth * (healthval / 100) and GetClock() > timerHealth + 15000 then
			UseItemOnTarget(2003, myHero)
			UseItemOnTarget(2009, myHero)
			timerHealth = GetClock()
		elseif menu.AutoPotions.Chrystalline_Flask_ONOFF and myHero.health <= myHero.maxHealth * (flaskval / 100) and GetClock() > timerFlask + 10000 then 
			UseItemOnTarget(2041, myHero)
			timerFlask = GetClock()
		elseif menu.AutoPotions.Chrystalline_Flask_ONOFF and myHero.health <= myHero.maxHealth * (elixirval / 100) then
			UseItemOnTarget(2037, myHero)
		elseif menu.AutoPotions.Mana_Potion_ONOFF and myHero.mana <= myHero.maxMana * (manaval / 100) and GetClock() > timerMana + 15000 then
			UseItemOnTarget(2004, myHero)
		end
	end
	if os.clock() < timerBP + 5000 then bluePill = nil end
end
--[[ NOT NEEDED - SPELL DMG LIBRARY CALCS THIS FOR WDMG
function getSilverBoltDmg(unit)
	if unit and myHero.SpellLevelW >= 1 then
	local flat_dmg = (10 + (10 * myHero.SpellLevelW))
	local true_dmg = unit.maxHealth * (3 * myHero.SpellLevelW / 100)
		return Round(flat_dmg + true_dmg)
	end
	return 0
end
]]

function roamHelper(aanumb, qnumb, wnumb, enumb, rnumb, ignite)
	for i, Enemy in pairs(Enemies) do
		if Enemy ~= nil then
		Hero = Enemy.Unit
		local PositionX = (13.3/16) * GetScreenX()
		local AADMG = getDmg('AD', Hero, myHero)*aanumb
		local QDMG = getDmg('Q', Hero, myHero)*qnumb
		local WDMG = getDmg('W', Hero, myHero)*wnumb
		local EDMG = getDmg('E', Hero, myHero)*enumb
		--local RDMG = getDmg('R', Hero, myHero)*rnumb
		if myHero.name == "Caitlyn" then
				RDMG = getDmg('R', Hero, myHero)-((47+(myHero.selflevel * 3))*2)*rnumb
			elseif myHero.name == "MissFortune" then
				RDMG = getDmg('R', Hero, myHero)*8
			else
				RDMG = getDmg('R', Hero, myHero) 
		end
		local IDMG = (50 +(20 * myHero.selflevel))
		local Damage = 0
			if aanumb > 0 then
				Damage = Damage + Round(AADMG)
			end
			if qnumb > 0 and myHero.SpellLevelQ >= 1 and myHero.SpellTimeQ > 1.0 then
				Damage = Damage + Round(QDMG)
			end
			if wnumb > 0 and myHero.SpellLevelW >= 1 and myHero.SpellTimeW > 1.0 then
				Damage = Damage + Round(WDMG)
			end
			if enumb > 0 and myHero.SpellLevelE >= 1 and myHero.SpellTimeE > 1.0 then
				Damage = Damage + Round(EDMG)
			end
			if rnumb > 0 and myHero.SpellLevelR >= 1 and myHero.SpellTimeR > 1.0 then
				Damage = Damage + Round(RDMG)
			end
			if ignite then
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					Damage = Damage + IDMG
				end
			end
--			if myHero.name == "Vayne" and CfgYayoBuddy_Vayne.RoamHelper.silverbolts then
--				Damage = Damage + (getSilverBoltDmg(Hero)*aanumb/3)
--			end
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

function spellFarm(range, func1, func2, func3, func4)
	local minionTarget, menu, menu1
	local minionTarget = GetLowestHealthEnemyMinion(range)
	if getMenu() ~= nil then menu = getMenu() end

	if minionTarget and myHero.mana >= myHero.maxMana * (menu.ManaManager.manaSpellFarm / 100) then
		if yayo.Config.LastHit and func1 ~= x then
			if menu._LastHit.farmQ and getDmg('Q', minionTarget, myHero) >= minionTarget.health then func1(minionTarget) end
		end
		if yayo.Config.LastHit and func2 ~= x then
			if menu._LastHit.farmW and getDmg('W', minionTarget, myHero) >= minionTarget.health then func2(minionTarget) end
		end
		if yayo.Config.LastHit and func3 ~= x then
			if menu._LastHit.farmE  and getDmg('E', minionTarget, myHero) >= minionTarget.health then func3(minionTarget) end
		end
		if yayo.Config.LastHit and func4 ~= x then
			if menu._LastHit.farmR and getDmg('R', minionTarget, myHero) >= minionTarget.health then func4(spellTarget) end
		end
		if yayo.Config.Mixed and func1 ~= x then
			if menu._MixedMode.farmQ and getDmg('Q', minionTarget, myHero) >= minionTarget.health then func1(minionTarget) end
		end
		if yayo.Config.Mixed and func2 ~= x then
			if menu._MixedMode.farmW and getDmg('W', minionTarget, myHero) >= minionTarget.health then func2(minionTarget) end
		end
		if yayo.Config.Mixed and func3 ~= x then
			if menu._MixedMode.farmE and getDmg('E', minionTarget, myHero) >= minionTarget.health then func3(minionTarget) end
		end
		if yayo.Config.Mixed and func4 ~= x then
			if menu._MixedMode.farmR and getDmg('R', minionTarget, myHero) >= minionTarget.health then func4(minionTarget) end
		end
		if yayo.Config.LaneClear and func1 ~= x then
			if menu._LaneClear.farmQ then func1(minionTarget) end
		end
		if yayo.Config.LaneClear and func2 ~= x then
			if menu._LaneClear.farmW then func2(minionTarget) end
		end
		if yayo.Config.LaneClear and func3 ~= x then
			if menu._LaneClear.farmE then func3(minionTarget) end
		end
		if yayo.Config.LaneClear and func4 ~= x then
			if menu._LaneClear.farmR then func4(minionTarget) end
		end
	end
end

--for spell1, spell2, spell3 & spell4: 1 == Q, 2 == W, 3 == E, 4 == R
function comboYayoBuddy(targettype, range, spell1, func1, spell2, func2, spell3, func3, spell4, func4)
	local spellTarget, menu
	if targettype == M then spellTarget = GetWeakEnemy('MAGIC', range) end
	if targettype == P then spellTarget = GetWeakEnemy('PHYS', range) end
	if getMenu() ~= nil then menu = getMenu() end

	if spellTarget then
		if yayo.Config.AutoCarry and func1 ~= x then
			if spell1 == 1 and menu._AutoCarry.useQ then func1(spellTarget)
			elseif spell1 == 2 and menu._AutoCarry.useW then func1(spellTarget)
			elseif spell1 == 3 and menu._AutoCarry.useE then func1(spellTarget)
			elseif spell1 == 4 and menu._AutoCarry.useR then func1(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell1")
			end
		end
		if yayo.Config.AutoCarry and func2 ~= x then
			if spell2 == 1 and menu._AutoCarry.useQ then func2(spellTarget)
			elseif spell2 == 2 and menu._AutoCarry.useW then func2(spellTarget)
			elseif spell2 == 3 and menu._AutoCarry.useE then func2(spellTarget)
			elseif spell2 == 4 and menu._AutoCarry.useR then func2(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell2")
			end
		end
		if yayo.Config.AutoCarry and func3 ~= x then
			if spell3 == 1 and menu._AutoCarry.useQ then func3(spellTarget)
			elseif spell3 == 2 and menu._AutoCarry.useW then func3(spellTarget)
			elseif spell3 == 3 and menu._AutoCarry.useE then func3(spellTarget)
			elseif spell3 == 4 and menu._AutoCarry.useR then func3(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell3")
			end
		end
		if yayo.Config.AutoCarry and func4 ~= x then
			if spell4 == 1 and menu._AutoCarry.useQ then func4(spellTarget)
			elseif spell4 == 2 and menu._AutoCarry.useW then func4(spellTarget)
			elseif spell4 == 3 and menu._AutoCarry.useE then func4(spellTarget)
			elseif spell4 == 4 and menu._AutoCarry.useR then func4(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell4")
			end
		end

		if yayo.Config.LastHit and func1 ~= x then
			if spell1 == 1 and menu._LastHit.useQ then func1(spellTarget)
			elseif spell1 == 2 and menu._LastHit.useW then func1(spellTarget)
			elseif spell1 == 3 and menu._LastHit.useE then func1(spellTarget)
			elseif spell1 == 4 and menu._LastHit.useR then func1(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell1")
			end
		end
		if yayo.Config.LastHit and func2 ~= x then
			if spell2 == 1 and menu._LastHit.useQ then func2(spellTarget)
			elseif spell2 == 2 and menu._LastHit.useW then func2(spellTarget)
			elseif spell2 == 3 and menu._LastHit.useE then func2(spellTarget)
			elseif spell2 == 4 and menu._LastHit.useR then func2(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell2")
			end
		end
		if yayo.Config.LastHit and func3 ~= x then
			if spell3 == 1 and menu._LastHit.useQ then func3(spellTarget)
			elseif spell3 == 2 and menu._LastHit.useW then func3(spellTarget)
			elseif spell3 == 3 and menu._LastHit.useE then func3(spellTarget)
			elseif spell3 == 4 and menu._LastHit.useR then func3(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell3")
			end
		end
		if yayo.Config.LastHit and func4 ~= x then
			if spell4 == 1 and menu._LastHit.useQ then func4(spellTarget)
			elseif spell4 == 2 and menu._LastHit.useW then func4(spellTarget)
			elseif spell4 == 3 and menu._LastHit.useE then func4(spellTarget)
			elseif spell4 == 4 and menu._LastHit.useR then func4(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell4")
			end
		end
		if yayo.Config.Mixed and func1 ~= x then
			if spell1 == 1 and menu._MixedMode.useQ then func1(spellTarget)
			elseif spell1 == 2 and menu._MixedMode.useW then func1(spellTarget)
			elseif spell1 == 3 and menu._MixedMode.useE then func1(spellTarget)
			elseif spell1 == 4 and menu._MixedMode.useR then func1(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell1")
			end
		end
		if yayo.Config.Mixed and func2 ~= x then
			if spell2 == 1 and menu._MixedMode.useQ then func2(spellTarget)
			elseif spell2 == 2 and menu._MixedMode.useW then func2(spellTarget)
			elseif spell2 == 3 and menu._MixedMode.useE then func2(spellTarget)
			elseif spell2 == 4 and menu._MixedMode.useR then func2(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell2")
			end
		end
		if yayo.Config.Mixed and func3 ~= x then
			if spell3 == 1 and menu._MixedMode.useQ then func3(spellTarget)
			elseif spell3 == 2 and menu._MixedMode.useW then func3(spellTarget)
			elseif spell3 == 3 and menu._MixedMode.useE then func3(spellTarget)
			elseif spell3 == 4 and menu._MixedMode.useR then func3(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell3")
			end
		end
		if yayo.Config.Mixed and func4 ~= x then
			if spell4 == 1 and menu._MixedMode.useQ then func4(spellTarget)
			elseif spell4 == 2 and menu._MixedMode.useW then func4(spellTarget)
			elseif spell4 == 3 and menu._MixedMode.useE then func4(spellTarget)
			elseif spell4 == 4 and menu._MixedMode.useR then func4(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell4")
			end
		end
		if yayo.Config.LaneClear and func1 ~= x then
			if spell1 == 1 and menu._LaneClear.useQ then func1(spellTarget)
			elseif spell1 == 2 and menu._LaneClear.useW then func1(spellTarget)
			elseif spell1 == 3 and menu._LaneClear.useE then func1(spellTarget)
			elseif spell1 == 4 and menu._LaneClear.useR then func1(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell1")
			end
		end
		if yayo.Config.LaneClear and func2 ~= x then
			if spell2 == 1 and menu._LaneClear.useQ then func2(spellTarget)
			elseif spell2 == 2 and menu._LaneClear.useW then func2(spellTarget)
			elseif spell2 == 3 and menu._LaneClear.useE then func2(spellTarget)
			elseif spell2 == 4 and menu._LaneClear.useR then func2(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell2")
			end
		end
		if yayo.Config.LaneClear and func3 ~= x then
			if spell3 == 1 and menu._LaneClear.useQ then func3(spellTarget)
			elseif spell3 == 2 and menu._LaneClear.useW then func3(spellTarget)
			elseif spell3 == 3 and menu._LaneClear.useE then func3(spellTarget)
			elseif spell3 == 4 and menu._LaneClear.useR then func3(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell3")
			end
		end
		if yayo.Config.LaneClear and func4 ~= x then
			if spell4 == 1 and menu._LaneClear.useQ then func4(spellTarget)
			elseif spell4 == 2 and menu._LaneClear.useW then func4(spellTarget)
			elseif spell4 == 3 and menu._LaneClear.useE then func4(spellTarget)
			elseif spell4 == 4 and menu._LaneClear.useR then func4(spellTarget)
			else
				--print("Error in function comboYayoBuddy: Cannot identify spell4")
			end
		end
	end
end

function killStealTest(qfunc, qrange, wfunc, wrange, efunc, erange, rfunc, rrange, ignite)
	local debug = true
	local log = false
	local file
	local QFUNC, QRANGE, WFUNC, WRANGE, EFUNC, ERANGE, RFUNC, RRANGE, IGNITE, menu
	menu = getMenu()
	if menu.KillSteals.ksQ then QFUNC = qfunc elseif qfunc == x then QFUNC = x else QFunction = x end
	if menu.KillSteals.ksW then WFUNC = wfunc elseif wfunc == x then QFUNC = x else WFunction = x end
	if menu.KillSteals.ksE then EFUNC = efunc elseif efunc == x then EFUNC = x else EFunction = x end
	if menu.KillSteals.ksR then RFUNC = rfunc elseif rfunc == x then RFUNC = x else RFunction = x end
	if menu.KillSteals.ksI then IGNITE = ignite elseif ignite == x then IGNITE = x else IGNITE = x end
	local qdmg, wdmg, edmg, rdmg, ignitedmg = nil, nil, nil, nil, 0
	for i = 1, objManager:GetMaxHeroes() do
		local enemy = objManager:GetHero(i)
		if (enemy and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			if qfunc ~= x then qdmg = getDmg('Q', enemy, myHero) end
			if wfunc ~= x then wdmg = getDmg('W', enemy, myHero) end
			if efunc ~= x then edmg = getDmg('E', enemy, myHero) end
			if myHero.name == "Caitlyn" then
				if rfunc ~= x then rdmg = getDmg('R', enemy, myHero)-((47+(myHero.selflevel * 3))*2) end
			elseif myHero.name == "MissFortune" then
				if rfunc ~= x then rdmg = getDmg('R', enemy, myHero)*8 end
			elseif rfunc ~= x then rdmg = getDmg('R', enemy, myHero) end
			if ignite ~= x and (myHero.SummonerD == "SummonerDot" or myHero.SummonerF == "SummonerDot") then ignitedmg = (50 +(20 * myHero.selflevel)) end
			if QFUNC ~= x and GetDistance(enemy, myHero) <= qrange and myHero.SpellTimeQ > 1.0 then
				if qdmg > enemy.health then
					qfunc(enemy)
					if debug then print('KS - Q: DMG: '..qdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..qrange) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q: DMG: '..qdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..qrange)
						file:close()
					end
				end
			end
			if WFUNC ~= x and GetDistance(enemy, myHero) <= wrange and myHero.SpellTimeW > 1.0 then
				if wdmg > enemy.health then
					wfunc(enemy)
					if debug then print('KS - W: DMG: '..wdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..wrange) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - W: DMG: '..wdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..wrange) 
						file:close()
					end
				end
			end
			if EFUNC ~= x and GetDistance(enemy, myHero) <= erange and myHero.SpellTimeE > 1.0 then
				if edmg > enemy.health then
					efunc(enemy)
					if debug then print('KS - E: DMG: '..edmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..erange) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - E: DMG: '..edmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..erange) 
						file:close()
					end
				end
			end
			if RFUNC ~= x and GetDistance(enemy, myHero) <= rrange and myHero.SpellTimeR > 1.0 then 
				if rdmg > enemy.health then
					rfunc(enemy)
					if debug then print('KS - R: DMG: '..rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..rrange) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - E: DMG: '..edmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..erange) 
						file:close()
					end
				end
			end
			if IGNITE ~= x and GetDistance(enemy, myHero) <= 600 and ignitedmg > 0 then
				if ignitedmg > enemy.health then
					ignite(enemy)
					if debug then print('KS - Ignite: DMG: '..ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: 600") end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Ignite: DMG: '..ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: 600") 
						file:close()
					end
				end
			end
			if QFUNC ~= x and WFUNC ~= x and GetDistance(enemy, myHero) <= math.min(qrange, wrange) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 then
				if qdmg + wdmg > enemy.health then
					qfunc(enemy)
					wfunc(enemy)
					if debug then print('KS - Q+W: DMG: '..qdmg + wdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+W: DMG: '..qdmg + wdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange)) 
						file:close()
					end
				end
			end
			if QFUNC ~= x and EFUNC ~= x and GetDistance(enemy, myHero) <= math.min(qrange, erange) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 then
				if qdmg + edmg > enemy.health then
					qfunc(enemy)
					efunc(enemy)
					if debug then print('KS - Q+E: DMG: '..qdmg + edmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, erange)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+E: DMG: '..qdmg + edmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, erange)) 
						file:close()
					end
				end
			end
			if QFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(qrange, 600) and myHero.SpellTimeQ > 1.0 and ignitedmg > 0 then
				if qdmg + ignitedmg > enemy.health then
					qfunc(enemy)
					ignite(enemy)
					if debug then print('KS - Q+Ignite: DMG: '..qdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+Ignite: DMG: '..qdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, 600))
						file:close()
					end
				end
			end
			if WFUNC ~= x and EFUNC ~= x and GetDistance(enemy, myHero) <= math.min(wrange, erange) and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 then
				if wdmg + edmg > enemy.health then
					wfunc(enemy)
					efunc(enemy)
					if debug then print('KS - W+E: DMG: '..wdmg + edmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, erange)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - W+E: DMG: '..wdmg + edmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, erange))
						file:close()
					end
				end
			end
			if WFUNC ~= x and RFUNC ~= x and GetDistance(enemy, myHero) <= math.min(wrange, rrange) and myHero.SpellTimeW > 1.0 and myHero.SpellTimeR > 1.0 then
				if wdmg + rdmg > enemy.health then
					wfunc(enemy)
					rfunc(enemy)
					if debug then print('KS - W+R: DMG: '..wdmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, rrange)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - W+R: DMG: '..wdmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, rrange))
						file:close()
					end
				end
			end
			if WFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(wrange, 600) and myHero.SpellTimeW > 1.0 and ignitedmg > 0 then
				if wdmg + ignitedmg > enemy.health then
					wfunc(enemy)
					ignite(enemy)
					if debug then print('KS - W+Ignite: DMG: '..wdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - W+Ignite: DMG: '..wdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, 600))
						file:close()
					end
				end
			end
			if EFUNC ~= x and RFUNC ~= x and GetDistance(enemy, myHero) <= math.min(erange, rrange) and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 then
				if edmg + rdmg > enemy.health then
					efunc(enemy)
					rfunc(enemy)
					if debug then print('KS - E+R: DMG: '..edmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(erange, rrange)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - E+R: DMG: '..edmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(erange, rrange))
						file:close()
					end
				end
			end
			if EFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(erange, 600) and myHero.SpellTimeE > 1.0 and ignitedmg > 0 then
				if edmg + ignitedmg > enemy.health then
					efunc(enemy)
					ignite(enemy)
					if debug then print('KS - E+Ignite: DMG: '..edmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(erange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - E+Ignite: DMG: '..edmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(erange, 600)) 
						file:close()
					end
				end
			end
			if RFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(rrange, 600) and myHero.SpellTimeR > 1.0 and ignitedmg > 0 then
				if rdmg + ignitedmg > enemy.health then
					rfunc(enemy)
					ignite(enemy)
					if debug then print('KS - R+Ignite: DMG: '..rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(rrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - R+Ignite: DMG: '..rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(rrange, 600))
						file:close()
					end
				end
			end
			if QFUNC ~= x and WFUNC ~= x and EFUNC ~= x and GetDistance(enemy, myHero) <= math.min(qrange, wrange, erange) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 then
				if qdmg + wdmg + edmg > enemy.health then
					qfunc(enemy)
					wfunc(enemy)
					efunc(enemy)
					if debug then print('KS - Q+W+E: DMG: '..qdmg + wdmg + edmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, erange)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+W+E: DMG: '..qdmg + wdmg + edmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, erange))
						file:close()
					end
				end
			end
			if QFUNC ~= x and WFUNC ~= x and RFUNC ~= x and GetDistance(enemy, myHero) <= math.min(qrange, wrange, rrange) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 and myHero.SpellTimeR > 1.0 then
				if qdmg + wdmg + rdmg > enemy.health then
					qfunc(enemy)
					wfunc(enemy)
					rfunc(enemy)
					if debug then print('KS - Q+W+E: DMG: '..qdmg + wdmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, erange)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+W+E: DMG: '..qdmg + wdmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, erange))
						file:close()
					end
				end
			end
			if QFUNC ~= x and WFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(qrange, wrange, 600) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 and ignitedmg > 0 then
				if qdmg + wdmg + ignitedmg > enemy.health then
					qfunc(enemy)
					wfunc(enemy)
					ignite(enemy)
					if debug then print('KS - Q+W+Ignite: DMG: '..qdmg + wdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+W+Ignite: DMG: '..qdmg + wdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, 600))
						file:close()
					end
				end
			end
			if QFUNC ~= x and EFUNC ~= x and RFUNC ~= x and GetDistance(enemy, myHero) <= math.min(qrange, erange, rrange) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 then
				if qdmg + edmg + rdmg > enemy.health then
					qfunc(enemy)
					efunc(enemy)
					rfunc(enemy)
					if debug then print('KS - Q+E+R: DMG: '..qdmg + edmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, erange, rrange)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+E+R: DMG: '..qdmg + edmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, erange, rrange))
						file:close()
					end
				end
			end
			if QFUNC ~= x and EFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(qrange, erange, 600) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and ignitedmg > 0 then
				if qdmg + edmg + ignitedmg > enemy.health then
					qfunc(enemy)
					efunc(enemy)
					ignite(enemy)
					if debug then print('KS - Q+E+Ignite: DMG: '..qdmg + edmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, erange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+E+Ignite: DMG: '..qdmg + edmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, erange, 600))
						file:close()
					end
				end
			end
			if QFUNC ~= x and RFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(qrange, rrange, 600) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and ignitedmg > 0 then
				if qdmg + rdmg + ignitedmg > enemy.health then
					qfunc(enemy)
					rfunc(enemy)
					ignite(enemy)
					if debug then print('KS - Q+R+Ignite: DMG: '..qdmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, rrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+R+Ignite: DMG: '..qdmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, rrange, 600))
						file:close()
					end
				end
			end
			if WFUNC ~= x and EFUNC ~= x and RFUNC ~= x and GetDistance(enemy, myHero) <= math.min(wrange, erange, rrange) and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 then
				if wdmg + edmg + rdmg > enemy.health then
					wfunc(enemy)
					efunc(enemy)
					rfunc(enemy)
					if debug then print('KS - W+E+R: DMG: '..wdmg + edmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, erange, rrange)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - W+E+R: DMG: '..wdmg + edmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, erange, rrange))
						file:close()
					end
				end
			end
			if WFUNC ~= x and EFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(wrange, erange, 600) and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and ignitedmg > 0 then
				if wdmg + edmg + ignitedmg > enemy.health then
					wfunc(enemy)
					efunc(enemy)
					ignite(enemy)
					if debug then print('KS - W+E+Ignite: DMG: '..wdmg + edmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, erange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - W+E+Ignite: DMG: '..wdmg + edmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, erange, 600))
						file:close()
					end
				end
			end
			if WFUNC ~= x and RFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(wrange, rrange, 600) and myHero.SpellTimeW > 1.0 and myHero.SpellTimeR > 1.0 and ignitedmg > 0 then
				if wdmg + rdmg + ignitedmg > enemy.health then
					wfunc(enemy)
					rfunc(enemy)
					ignite(enemy)
					if debug then print('KS - W+R+Ignite: DMG: '..wdmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, rrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - W+R+Ignite: DMG: '..wdmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, rrange, 600))
						file:close()
					end
				end
			end
			if EFUNC ~= x and RFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(erange, rrange, 600) and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and ignitedmg > 0 then
				if edmg + rdmg + ignitedmg > enemy.health then
					efunc(enemy)
					rfunc(enemy)
					ignite(enemy)
					if debug then print('KS - E+R+Ignite: DMG: '..edmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(erange, rrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - E+R+Ignite: DMG: '..edmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(erange, rrange, 600))
						file:close()
					end
				end
			end
			if QFUNC ~= x and WFUNC ~= x and EFUNC ~= x and RFUNC ~= x and GetDistance(enemy, myHero) <= math.min(qrange, wrange, erange, rrange) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 then
				if qdmg + wdmg + edmg + rdmg > enemy.health then
					qfunc(enemy)
					wfunc(enemy)
					efunc(enemy)
					rfunc(enemy)
					if debug then print('KS - Q+W+E+R: DMG: '..qdmg + wdmg + edmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, erange, rrange)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+W+E+R: DMG: '..qdmg + wdmg + edmg + rdmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, erange, rrange))
						file:close()
					end
				end
			end
			if QFUNC ~= x and WFUNC ~= x and EFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(qrange, wrange, erange, 600) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and ignitedmg > 0 then
				if qdmg + wdmg + edmg + ignitedmg > enemy.health then
					qfunc(enemy)
					wfunc(enemy)
					efunc(enemy)
					ignite(enemy)
					if debug then print('KS - Q+W+E+Ignite: DMG: '..qdmg + wdmg + edmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, erange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+W+E+Ignite: DMG: '..qdmg + wdmg + edmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, erange, 600))
						file:close()
					end
				end
			end
			if QFUNC ~= x and WFUNC ~= x and RFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(qrange, wrange, rrange, 600) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 and myHero.SpellTimeR > 1.0 and ignitedmg > 0 then
				if qdmg + wdmg + rdmg + ignitedmg > enemy.health then
					qfunc(enemy)
					wfunc(enemy)
					rfunc(enemy)
					ignite(enemy)
					if debug then print('KS - Q+W+R+Ignite: DMG: '..qdmg + wdmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, rrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+W+R+Ignite: DMG: '..qdmg + wdmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, rrange, 600))
						file:close()
					end
				end
			end
			if QFUNC ~= x and EFUNC ~= x and RFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(qrange, erange, rrange, 600) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and ignitedmg > 0 then
				if qdmg + edmg + rdmg + ignitedmg > enemy.health then
					qfunc(enemy)
					efunc(enemy)
					rfunc(enemy)
					ignite(enemy)
					if debug then print('KS - Q+E+R+Ignite: DMG: '..qdmg + edmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, erange, rrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+E+R+Ignite: DMG: '..qdmg + edmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, erange, rrange, 600))
						file:close()
					end
				end
			end
			if WFUNC ~= x and EFUNC ~= x and RFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(wrange, erange, rrange, 600) and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and ignitedmg > 0 then
				if wdmg + edmg + rdmg + ignitedmg > enemy.health then
					wfunc(enemy)
					efunc(enemy)
					rfunc(enemy)
					ignite(enemy)
					if debug then print('KS - W+E+R+Ignite: DMG: '..wdmg + edmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, erange, rrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - W+E+R+Ignite: DMG: '..wdmg + edmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(wrange, erange, rrange, 600))
						file:close()
					end
				end
			end
			if QFUNC ~= x and WFUNC ~= x and EFUNC ~= x and RFUNC ~= x and IGNITE ~= x and GetDistance(enemy, myHero) <= math.min(qrange, wrange, erange, rrange, 600) and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and ignitedmg > 0 then
				if qdmg + wdmg + edmg + rdmg + ignitedmg > enemy.health then
					qfunc(enemy)
					wfunc(enemy)
					efunc(enemy)
					rfunc(enemy)
					ignite(enemy)
					if debug then print('KS - Q+W+E+R+Ignite: DMG: '..qdmg + wdmg + edmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, erange, rrange, 600)) end
					if log then 
						file = io.open("CCONN_KillSteal_Log.txt", "W")
						file:write('KS - Q+W+E+R+Ignite: DMG: '..qdmg + wdmg + edmg + rdmg + ignitedmg..", target: "..enemy.name..", target hp: "..enemy.health.."\n Range from me to target: "..GetDistance(enemy, myHero)..", Theoretical max range: "..math.min(qrange, wrange, erange, rrange, 600))
						file:close()
					end
				end
			end
		end
	end
end

Init()
SetTimerCallback('OnTick')