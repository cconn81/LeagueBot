local ScriptName = 'CCONNs Yayo Buddy'
local Version = '2.4'
---------------------------------------------------------------------------------------------------
-- CHANGE LOG -------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--
--			Version 2.4
--				Imported Deadly Graves
--				Imported Deadly Corki
--			Version 2.3
--				Re-work of Teemo
--					New Menu, Spell Cast functions, Kill Steals, Combo Functions, AA Reset
--			Version 2.2
--				Fully activated auto summoner spells
--					ignite / exhaust are champion and yayo state specific and need to be added for each champion
--				Ported Deadly KogMaw from BoL
--			Version 2.1.1
--				Removed wdmg from Miss Fortune kill steal function
--			Version 2.1
--				Added Tristana W option to jump to mouse position
--				Imported Deadly Miss Fortune
--				Created new Miss Fortune menu
--				Added SafeR to Miss Fortune
--				Added vast kill steals to Miss Fortune
--			Version 2.0.1
--				Minor bug fix for Tristana AP Mixed Mode combo
--			Version 2.0
--				Copmlete re-work of Tristana
--				Added new Tristana Menu
--				AP / AD toggle in menu and different combos / targets for each
--				Added kill steal section for Tristana
--			Version 1.9
--				Modified Caitlyn R damage calculation to correct spell damage library calculation
--			Version 1.8
--				Yayo Buddy menu changes
--				Added Auto Potions from my Deadly Scripts
--				Added Auto Summoner Spells from my Deadly Scripts
--				Imported Deadly Caitlyn functions
--				Added new menu for Ezreal, Vayne, Caitlyn
--			Version 1.7
--				Added menu for Vayne
--				Added support for Samipot's Vayne Mighty Assistant
--				Added anti gap closer E options
--			Version 1.6
--				Added Ryze Combo from Deadly Ryze
--			Version 1.5
--				Added Riven Q,W,E Combo
--			Version 1.4
--				Added Cassiopeia Q,W,E Combo with Poison Detection from Deadly Cassio
--			Version 1.3
--				Added Ahri E,Q,W combo
--			Version 1.2
--				Added Master Yi Q,E Combo & W AA Reset
--			Version 1.1
--				Added Vayne wall condemn
--			Version 1.0
--				Initial release includes:
--					Ezreal Q Combo and W AA reset
--					Vayne Q AA Reset
--					Caitlyn Q,W Combo
--					Tristana Q,E Combo with E,R Kill Steal
--					Teemo - Doesn't work
--
---------------------------------------------------------------------------------------------------
-- CURRENTLY SUPPORTED CHAMPIONS ------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--	Yayo Buddy will activate Yayo for all champions.
--	All Yayo Buddy utility functions will be activated for all champions.
--	Advanced logic (combos, kill steals, etc) is activated for the following champions only:
--
--		Ahri
--		Caitlyn
--		Cassiopeia
--		Corki
--		Ezreal
--		Graves
--		KogMaw
--		Master Yi
--		Miss Fortune
--		Riven
--		Ryze
--		Teemo
--		Tristana
--		Vayne
--
---------------------------------------------------------------------------------------------------
-- CURRENTLY SUPPORTED UTILITY FEATURES -----------------------------------------------------------
---------------------------------------------------------------------------------------------------
--
--		Auto Potions by CCONN
--			Health Pots
--			Biscuits
--			Chrystalline Flask
--			Mana Pots
--			Elixir of Fortitude
--
--		Auto Summoner Spells by CCONN
--			Ignite
--			Combo Ignite
--			Heal
--			Barrier
--			Exhaust
--			Clarity
--			Smite -- coming soon
--
---------------------------------------------------------------------------------------------------
-- TO DO LIST -------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--		GENERAL CHANGES
--			Add Dodge Skillshots
--			Add Roam Helper
--			Get Summoner Spells working
--			Add custom draw ranges
--			Add auto interrupt for dangerous spells for champions who can interrupt
--			Add Mana Manager - set mana threshold for each spell in each Yayo state
--			Option to disable move to mouse
--			Add Auto Exhaust on dangerous spells, eg. Katarina Ultimate
--			Add Auto Ignite on Mundo Ultimate - other spells?
--			Re-name menu items to avoid settings not being saved for each champion (prefix widget name with 'championname_')
--
--		EZREAL
--			Add Kill Steals
--			Add spell cast functions like Caitlyn
--			Integrate E with dodge skillshots
--			Add Ignite / Exhaust for each Yayo State
--
--		TEEMO
--			Add ultimate stack manager (option to force drop shroom if 3 stacks and full mana)
--			Add shroom distance manager - prevent you from dropping multiple shrooms too close to each other
--
--		MASTER YI
--			Add kill steals
--			Add spell cast functions like Caitlyn
--			Add menu
--			Integrate Q with dodge skillshots
--			Add Ignite / Exhaust for each Yayo state
--
--		AHRI
--			Add kill steals
--			Add spell cast functions like Caitlyn
--			Add menu
--			Integrate R with dodge skillshots
--			Add Ignite / Exhaust for each Yayo state
--
--		CASSIOPEIA
--			Import Deadly Cassio functions
--			Create menu
--			Add Ignite / Exhaust for each Yayo state
--
--		RIVEN
--			Add kill steal
--			Ultimate support
--			Auto shield
--			Add menu
--			Add spellshot / auto shield
--			Integrate E with dodge skillshots - possibly Q also
--			Add Ignite / Exhaust for each Yayo state
--
--		CAITLYN
--			Add Safe E anti gap closer
--			Manual E
--			Manual Q
--			Champion collision check for ultimate
--			Integrate E with dodge skillshots
--			Add Ignite / Exhaust for each Yayo state
--
--		RYZE
--			Add reduced range auto attack option from Deadly Ryze
--			Add snare combo
--			Add Ignite / Exhaust for each Yayo state
--
--		VAYNE
--			Auto Interrupt spells with condemn
--			More detailed anti gap closer with menu options to select which champions to repel
--			Integrate Q with dodge skillshots
--			Add Ignite / Exhaust for each Yayo state
--
--		TRISTANA
--			Auto interrupt spells with condemn
--			Anti gap closer like Vayne - menu to select who to repel
--			Integrate W with dodge skillshots
--			Include SafeW to mouse position option of Rocket Jump
--			Add Ignite / Exhaust for each Yayo state
--
--		MISS FORTUNE
--			Add MEC ultimate
--			Add Q Bounce
--			Add Ignite / Exhaust for each Yayo state
--
--		Graves
--			Option to smoke screen to mouse position
--			Integrate quickdraw with dodge skillshots
--
--		Corki
--			Integrate Valkyrie with dodge skillshots
--
---------------------------------------------------------------------------------------------------
-- Required Libs ----------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
require 'yprediction'
require 'spell_damage'
---------------------------------------------------------------------------------------------------
-- Global Variables -------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
local uiconfig = require 'uiconfig'
local yayo = require 'yayo'
local YP = YPrediction()
Simple = {}

-------------------------------------------------
-- Auto Potions Variables -----------------------
-------------------------------------------------
local wUsedAt = 0
local vUsedAt = 0
local mUsedAt = 0
local timer = os.clock()
local bluePill = nil

-------------------------------------------------
-- KogMaw Variables -----------------------------
-------------------------------------------------
local stacks, timer_R = 0, os.time()

---------------------------------------------------------------------------------------------------

function OnDraw()
	local target = yayo.GetTarget()
	if target then
		DrawCircleObject(target, 100, 0xff00ffff)
		DrawCircleObject(target, 120, 0xff00ffff)
		DrawCircleObject(target, 140, 0xff00ffff)
	end
	if Simple[myHero.name] and Simple[myHero.name].OnDraw then
		Simple[myHero.name].OnDraw(target)
	end	
end

function BeforeAttack(target)
	if Simple[myHero.name] and Simple[myHero.name].BeforeAttack then
		return Simple[myHero.name].BeforeAttack(target)
	end
end

function OnAttack(target)
	if Simple[myHero.name] and Simple[myHero.name].OnAttack then
		Simple[myHero.name].OnAttack(target)
	end
end

function AfterAttack(target)
	if Simple[myHero.name] and Simple[myHero.name].AfterAttack then
		Simple[myHero.name].AfterAttack(target)
	end
end

function OnTick()
	if IsChatOpen() == 0 and tostring(winapi.get_foreground_window()) == "League of Legends (TM) Client" then
		local target = yayo.GetTarget()
		if ValidTarget(target) and yayo.Config.AutoCarry then
			UseAllItems(target)
		end
		if Simple[myHero.name] and Simple[myHero.name].OnTick then
			Simple[myHero.name].OnTick(target)
		end	
		if CfgYayoBuddy.AutoPotions.AutoPotions_ONOFF then
			CCONN_Potions()
		end
		if CfgYayoBuddy.AutoSummoners.Auto_Summoner_Spells_ONOFF then
			CCONN_Summoners()
		end
	end
end

function Init()
	print('MapName', GetMapName())
	print('Champ', myHero.name)
	yayo.RegisterBeforeAttackCallback(BeforeAttack)
	yayo.RegisterOnAttackCallback(OnAttack)
	yayo.RegisterAfterAttackCallback(AfterAttack)
end
---------------------------------------------------------------------------------------------------
-- Ezreal Section ---------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Ezreal = {
	OnTick = function(target)
		local Qrange, Qwidth, Qspeed, Qdelay = CfgYayoBuddy._SpellRanges.qRNG, 80, 2000, 0.25
		local Rrange, Rwidth, Rspeed, Rdelay = CfgYayoBuddy._SpellRanges.rRNG, 150, 2000, 0.25
		local targetQ = GetWeakEnemy("PHYS", 1150)
		local targetR = GetWeakEnemy("PHYS", 3000)
-------------------------------------------------
-- Yayo AutoCarry State -------------------------
-------------------------------------------------
		if yayo.Config.AutoCarry then
			if CfgYayoBuddy._AutoCarry.useQ and targetQ and ValidTarget(targetQ, Qrange) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetQ, Qdelay, Qwidth, Qrange, Qspeed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
			if CfgYayoBuddy._AutoCarry.useE and target and ValidTarget(target, CfgYayoBuddy._SpellRanges.eRNG) then
				CastSpellXYZ('E', mousePos.x, mousePos.y, mousePos.z)
			end
		end
		if CfgYayoBuddy._AutoCarry.useR and targetR and ValidTarget(targetR, Rrange) then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetR, Rdelay, Rwidth, Rrange, Rspeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('R', x, y, z)
			end
		end
-------------------------------------------------
-- Yayo Mixed Mode State ------------------------
-------------------------------------------------
		if yayo.Config.Mixed then
			if CfgYayoBuddy._MixedMode.useQ and targetQ and ValidTarget(targetQ, Qrange) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetQ, Qdelay, Qwidth, Qrange, Qspeed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
			if CfgYayoBuddy._MixedMode.useE and target and ValidTarget(target, CfgYayoBuddy._SpellRanges.eRNG) then
				CastSpellXYZ('E', mousePos.x, mousePos.y, mousePos.z)
			end
		end
		if CfgYayoBuddy._MixedMode.useR and targetR and ValidTarget(targetR, Rrange) then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetR, Rdelay, Rwidth, Rrange, Rspeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('R', x, y, z)
			end
		end
------------------------------------------------
-- Yayo Last Hit State -------------------------
------------------------------------------------
		if yayo.Config.LastHit then
			if CfgYayoBuddy._LastHit.useQ and targetQ and ValidTarget(targetQ, Qrange) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetQ, Qdelay, Qwidth, Qrange, Qspeed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
			if CfgYayoBuddy._LastHit.useE and target and ValidTarget(target, CfgYayoBuddy._SpellRanges.eRNG) then
				CastSpellXYZ('E', mousePos.x, mousePos.y, mousePos.z)
			end
		end
		if CfgYayoBuddy._LastHit.useR and targetR and ValidTarget(targetR, Rrange) then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetR, Rdelay, Rwidth, Rrange, Rspeed, myHero, true)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('R', x, y, z)
			end
		end
-------------------------------------------------
-- Yayo Lane Clear State ------------------------
-------------------------------------------------
		if yayo.Config.LaneClear then
			if CfgYayoBuddy._LaneClear.useQ and targetQ and ValidTarget(targetQ, Qrange) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetQ, Qdelay, Qwidth, Qrange, Qspeed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
			if CfgYayoBuddy._LaneClear.useE and target and ValidTarget(target, CfgYayoBuddy._SpellRanges.eRNG) then
				CastSpellXYZ('E', mousePos.x, mousePos.y, mousePos.z)
			end
		end
		if CfgYayoBuddy._LaneClear.useR and targetR and ValidTarget(targetR, Rrange) then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetR, Rdelay, Rwidth, Rrange, Rspeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('R', x, y, z)
			end
		end
	end,
-------------------------------------------------
-- Attack Reset with W --------------------------
-------------------------------------------------
	AfterAttack = function(target)
		local targetW = GetWeakEnemy('PHYS', 1050)
		local Wrange, Wwidth, Wspeed, Wdelay = 1050, 90, 1600, 0.25
		if CfgYayoBuddy._AutoCarry.useW and yayo.Config.AutoCarry then
			if targetW  then
				if ValidTarget(targetW, Wrange) then
					local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetW, Wdelay, Wwidth, Wrange, Wspeed, myHero, false)
					if HitChance >= 2 then
						local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
						CastSpellXYZ('W', x, y, z)
					end
				end
			end
		end
		if CfgYayoBuddy._MixedMode.useW and yayo.Config.Mixed then
			if targetW  then
				if ValidTarget(targetW, Wrange) then
					local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetW, Wdelay, Wwidth, Wrange, Wspeed, myHero, false)
					if HitChance >= 2 then
						local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
						CastSpellXYZ('W', x, y, z)
					end
				end
			end
		end
		if CfgYayoBuddy._LastHit.useW and yayo.Config.LastHit then
			if targetW  then
				if ValidTarget(targetW, Wrange) then
					local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetW, Wdelay, Wwidth, Wrange, Wspeed, myHero, false)
					if HitChance >= 2 then
						local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
						CastSpellXYZ('W', x, y, z)
					end
				end
			end
		end
		if CfgYayoBuddy._LaneClear.useW and yayo.Config.LaneClear then
			if targetW  then
				if ValidTarget(targetW, Wrange) then
					local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetW, Wdelay, Wwidth, Wrange, Wspeed, myHero, false)
					if HitChance >= 2 then
						local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
						CastSpellXYZ('W', x, y, z)
					end
				end
			end
		end
	end
}

---------------------------------------------------------------------------------------------------
-- Vayne Section ----------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Vayne = {
	OnTick = function(target)
		local targetSafe = GetWeakEnemy('PHYS', 550)
    	if target ~= nil and CfgYayoBuddy._AutoCondemn.AutoCondemn then
			if WillHitWall(target,440) == 1 and (GetDistance(myHero, target) <= 550) then
				CastSpellTarget('E', target)
			end
		end
		if targetSafe ~= nil and CfgYayoBuddy._AutoCondemn.AutoESafe then
			if GetDistance(targetSafe) <= CfgYayoBuddy._AutoCondemn.AutoESafeZone then
				CastSpellTarget('E', targetSafe)
			end
		end
	end,
-------------------------------------------------
-- Attack Reset with Tumble ---------------------
-------------------------------------------------
	AfterAttack = function(target)
		if yayo.Config.AutoCarry and CfgYayoBuddy._AutoCarry.AAQReset then
			CastSpellXYZ('Q', mousePos.x, mousePos.y, mousePos.z)
		end
		if yayo.Config.Mixed and CfgYayoBuddy._MixedMode.AAQReset then
			CastSpellXYZ('Q', mousePos.x, mousePos.y, mousePos.z)
		end
		if yayo.Config.LastHit and CfgYayoBuddy._LastHit.AAQReset then
			CastSpellXYZ('Q', mousePos.x, mousePos.y, mousePos.z)
		end
		if yayo.Config.LaneClear and CfgYayoBuddy._LaneClear.AAQReset then
			CastSpellXYZ('Q', mousePos.x, mousePos.y, mousePos.z)
		end
	end
}

---------------------------------------------------------------------------------------------------
-- Caitlyn Section --------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Caitlyn = {
	OnTick = function(target)
		local Rrange = (1500+(500*myHero.SpellLevelR))
		local targetQ = GetWeakEnemy('PHYS', 1300)
		local targetW = GetWeakEnemy('PHYS', 800)
		local targetE = GetWeakEnemy('PHYS', 950)
		local targetR = GetWeakEnemy('PHYS', Rrange)
		local Qrange = CfgYayoBuddy._SpellRanges.qRNG
		local Wrange = CfgYayoBuddy._SpellRanges.wRNG
		local Erange = CfgYayoBuddy._SpellRanges.eRNG
		local Rrange = CfgYayoBuddy._SpellRanges.rRNG
-------------------------------------------------
-- Yayo Auto Carry State ------------------------
-------------------------------------------------		
		if yayo.Config.AutoCarry then
			if targetQ and CfgYayoBuddy._AutoCarry.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange and GetDistance(targetQ) > CfgYayoBuddy._SpellRanges.qMINRNG then
					Caitlyn_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._AutoCarry.useW then
				if ValidTarget(targetW, Wrange) then
					Caitlyn_W(targetW)
				end
			end
			if targetE and CfgYayoBuddy._AutoCarry.useE then
				if ValidTarget(targetE, Erange) then
					Caitlyn_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._AutoCarry.useR then
				if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				else
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				end
			end
		end
-------------------------------------------------
-- Yayo Mixed Mode State ------------------------
-------------------------------------------------
		if yayo.Config.Mixed then
			if targetQ and CfgYayoBuddy._MixedMode.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange and GetDistance(targetQ) > CfgYayoBuddy._SpellRanges.qMINRNG then
					Caitlyn_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._MixedMode.useW then
				if ValidTarget(targetW, Wrange) then
					Caitlyn_W(targetW)
				end
			end
			if targetE and CfgYayoBuddy._MixedMode.useE then
				if ValidTarget(targetE, Erange) then
					Caitlyn_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._MixedMode.useR then
				if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				else
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				end
			end
		end
-------------------------------------------------
-- Yayo Last Hit State --------------------------
-------------------------------------------------
		if yayo.Config.LastHit then
			if targetQ and CfgYayoBuddy._LastHit.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange and GetDistance(targetQ) > CfgYayoBuddy._SpellRanges.qMINRNG then
					Caitlyn_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._LastHit.useW then
				if ValidTarget(targetW, Wrange) then
					Caitlyn_W(targetW)
				end
			end
			if targetE and CfgYayoBuddy._LastHit.useE then
				if ValidTarget(targetE, Erange) then
					Caitlyn_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._LastHit.useR then
				if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				else
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				end
			end
		end
-------------------------------------------------
-- Yayo Lane Clear State ------------------------
-------------------------------------------------
		if yayo.Config.LaneClear then
			if targetQ and CfgYayoBuddy._LaneClear.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange and GetDistance(targetQ) > CfgYayoBuddy._SpellRanges.qMINRNG then
					Caitlyn_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._LaneClear.useW then
				if ValidTarget(targetW, Wrange) then
					Caitlyn_W(targetW)
				end
			end
			if targetE and CfgYayoBuddy._LaneClear.useE then
				if ValidTarget(targetE, Erange) then
					Caitlyn_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._LaneClear.useR then
				if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				else
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				end
			end
		end
		if CfgYayoBuddy.KillSteal.KillSteal then CaitlynKillSteal() end
	end
}

-------------------------------------------------
--KILL STEAL FUNCTIONS---------------------------
-------------------------------------------------
function CaitlynKillSteal() --15 KS Combinations
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			local qdmg = getDmg("Q",enemy,myHero)
			local wdmg = getDmg("W",enemy,myHero)
    		local edmg = getDmg("E",enemy,myHero)
			local rdmg = getDmg("R",enemy,myHero)-((47+(myHero.selflevel * 3))*2)
			local ignitedmg = (myHero.selflevel*20)+50

-------------------------------------------------
-- Q Kill Steal ---------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Q and qdmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 1300 then --Q KS
				Caitlyn_Q(enemy)
			end
-------------------------------------------------
-- E Kill Steal ---------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.E and edmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E KS
				Caitlyn_E(enemy)
			end
------------------------------------------------
-- R Kill Steal --------------------------------
------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= (1500+(500*myHero.SpellLevelR)) then --R KS --SafeR
					Caitlyn_R(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= (1500+(500*myHero.SpellLevelR)) then --R KS
					Caitlyn_R(enemy)
				end
			end
-------------------------------------------------
-- Ignite Kill Steal ----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Ignite and ignitedmg > enemy.health and GetDistance(myHero,enemy) <= 600 then --Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
				end
			end
-------------------------------------------------
-- Q + E Kill Steal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QE and qdmg + edmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E KS
				Caitlyn_Q(enemy)
				Caitlyn_E(enemy)
			end
-------------------------------------------------
-- Q + R Kill Steal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.QR and qdmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1300 then --Q,R KS --SafeR
					Caitlyn_Q(enemy)
					Caitlyn_R(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.QR and qdmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1300 then --Q,R KS
					Caitlyn_Q(enemy)
					Caitlyn_R(enemy)
				end
			end
-------------------------------------------------
-- Q + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QIgnite and qdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Caitlyn_Q(enemy)
				end
			end
-------------------------------------------------
-- E + R Kill Steal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.ER and edmg + rdmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E,R KS
					Caitlyn_E(enemy)
					Caitlyn_R(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.ER and edmg + rdmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E,R KS --SafeR
					Caitlyn_E(enemy)
					Caitlyn_R(enemy)
				end
			end
-------------------------------------------------
-- E + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.EIgnite and edmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Caitlyn_E(enemy)
				end
			end
-------------------------------------------------
-- R + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Caitlyn_R(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Caitlyn_R(enemy)
					end
				end
			end
-------------------------------------------------
-- Q + E + R Kill Steal -------------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.QER and qdmg + edmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E,R KS --SafeR
					Caitlyn_Q(enemy)
					Caitlyn_E(enemy)
					Caitlyn_R(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.QER and qdmg + edmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E,R KS
					Caitlyn_Q(enemy)
					Caitlyn_E(enemy)
					Caitlyn_R(enemy)
				end
			end
-------------------------------------------------
-- Q + E + Ignite Kill Steal --------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QEIgnite and qdmg + edmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,E,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Caitlyn_Q(enemy)
					Caitlyn_E(enemy)
				end
			end
-------------------------------------------------
-- Q + R + Ignite Kill Steal --------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.QRIgnite and qdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Caitlyn_Q(enemy)
						Caitlyn_R(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.QRIgnite and qdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Caitlyn_Q(enemy)
						Caitlyn_R(enemy)
					end
				end
			end
-------------------------------------------------
-- E + R + Igite Kill Steal ---------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Caitlyn_E(enemy)
						Caitlyn_R(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Caitlyn_E(enemy)
						Caitlyn_R(enemy)
					end
				end
			end
-------------------------------------------------
-- Q + E + R + Ignite Kill Steal ----------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.QERIgnite and qdmg + edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,E,R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Caitlyn_Q(enemy)
						Caitlyn_E(enemy)
						Caitlyn_R(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Caitlyn_E(enemy)
						Caitlyn_R(enemy)
					end
				end
			end
		end
	end
end

-------------------------------------------------
-- Safe R Related -------------------------------
-------------------------------------------------
function SafeR()
	if CountUnit(myHero,CfgYayoBuddy.UltimateOptions.SafeR_Value) < 1 then
		return true
	else
		return false
	end
end

-------------------------------------------------
-- Caitlyn Spell Functions ----------------------
-------------------------------------------------
function Caitlyn_Q(QTarget)
	local Qrange, Qwidth, Qspeed, Qdelay = CfgYayoBuddy._SpellRanges.qRNG, 90, 2225, 0.632
	if QTarget ~= nil then
		if GetDistance(myHero, QTarget) <= CfgYayoBuddy._SpellRanges.qRNG and GetDistance(myHero,QTarget) > CfgYayoBuddy._SpellRanges.qMINRNG and myHero.mana >= (40 + (10 * myHero.SpellLevelQ)) then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(QTarget, Qdelay, Qwidth, Qrange, Qspeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('Q', x, y, z)
			end
		end
	end
end

function Caitlyn_W(WTarget)
	local Wrange, Wwidth, Wspeed, Wdelay = CfgYayoBuddy._SpellRanges.wRNG, 80, 1960, 0.1
	if WTarget ~= nil then
		if GetDistance(myHero, WTarget) <= CfgYayoBuddy._SpellRanges.wRNG and myHero.mana >= 50 then
			local CastPosition, HitChance, Position = YP:GetCircularCastPosition(WTarget, Wdelay, Wwidth, Wrange, Wspeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('W', x, y, z)
			end
		end
	end
end

function Caitlyn_E(ETarget)
	local Erange, Ewidth, Espeed, Edelay = CfgYayoBuddy._SpellRanges.eRNG, 80, 1960, 0.1
	if ETarget ~= nil then
		if GetDistance(myHero, ETarget) <= 1000 and myHero.mana >= 75 then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(ETarget, Edelay, Ewidth, Erange, Espeed, myHero, true)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('E', x, y, z)
			end
		end
	end
end

function Caitlyn_R(RTarget)
	if RTarget ~= nil then
		if GetDistance(myHero, RTarget) > myHero.range and GetDistance(myHero, RTarget) <= (1500+(500*myHero.SpellLevelR)) and myHero.mana >= 100 then
			CastSpellTarget('R',RTarget)
		end
	end
end

--[[
function EQCombo(EQTarget)
	if EQTarget ~= nil then
		if GetDistance(myHero, EQTarget) <= 1000 and myHero.mana >= 75 then
			CastSpellXYZ('E',GetFireahead(EQTarget,2,32))
		end
		if GetDistance(myHero, EQTarget) <= 1300 and myHero.mana >= (40 + (10 * myHero.SpellLevelQ)) then
			CastSpellXYZ('Q',GetFireahead(EQTarget,2,16))
		end
	end
end
]]

---------------------------------------------------------------------------------------------------
-- Graves Section ---------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Graves = {
	OnTick = function(target)
		local Qrange = CfgYayoBuddy._SpellRanges.qRNG
		local Wrange = CfgYayoBuddy._SpellRanges.wRNG
		local Erange = CfgYayoBuddy._SpellRanges.eRNG
		local Rrange = CfgYayoBuddy._SpellRanges.rRNG
		local targetQ = GetWeakEnemy('PHYS', 950)
		local targetW = GetWeakEnemy('PHYS', 950)
		local targetE = GetWeakEnemy('PHYS', 950)
		local targetR = GetWeakEnemy('PHYS', Rrange)
-------------------------------------------------
-- Yayo Auto Carry State ------------------------
-------------------------------------------------		
		if yayo.Config.AutoCarry then
			if targetW and CfgYayoBuddy._AutoCarry.useW then
				if ValidTarget(targetW, Wrange) then
					Graves_W(targetW)
				end
			end
			if targetE and CfgYayoBuddy._AutoCarry.useE then
				if ValidTarget(targetE, Erange) then
					Graves_E(targetE)
				end
			end
			if targetQ and CfgYayoBuddy._AutoCarry.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					Graves_Q(targetQ)
				end
			end
			if targetR and CfgYayoBuddy._AutoCarry.useR then
				if ValidTarget(targetR, Rrange) then
					Graves_R(targetR)
				end
			end
		end
-------------------------------------------------
-- Yayo Mixed Mode State ------------------------
-------------------------------------------------
		if yayo.Config.Mixed then
			if targetE and CfgYayoBuddy._MixedMode.useE then
				if ValidTarget(targetE, Erange) then
					Graves_E(targetE)
				end
			end
			if targetQ and CfgYayoBuddy._MixedMode.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					Graves_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._MixedMode.useW then
				if ValidTarget(targetW, Wrange) then
					Graves_W(targetW)
				end
			end
			if targetR and CfgYayoBuddy._MixedMode.useR then
				if ValidTarget(targetR, Rrange) then
					Caitlyn_R(targetR)
				end
			end
		end
-------------------------------------------------
-- Yayo Last Hit State --------------------------
-------------------------------------------------
		if yayo.Config.LastHit then
			if targetE and CfgYayoBuddy._LastHit.useE then
				if ValidTarget(targetE, Erange) then
					Graves_E(targetE)
				end
			end
			if targetQ and CfgYayoBuddy._LastHit.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					Graves_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._LastHit.useW then
				if ValidTarget(targetW, Wrange) then
					Graves_W(targetW)
				end
			end
			if targetR and CfgYayoBuddy._LastHit.useR then
				if ValidTarget(targetR, Rrange) then
					Graves_R(targetR)
				end
			end
		end
-------------------------------------------------
-- Yayo Lane Clear State ------------------------
-------------------------------------------------
		if yayo.Config.LaneClear then
			if targetE and CfgYayoBuddy._LaneClear.useE then
				if ValidTarget(targetE, Erange) then
					Graves_E(targetE)
				end
			end
			if targetQ and CfgYayoBuddy._LaneClear.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					Graves_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._LaneClear.useW then
				if ValidTarget(targetW, Wrange) then
					Graves_W(targetW)
				end
			end
			if targetR and CfgYayoBuddy._LaneClear.useR then
				if ValidTarget(targetR, Rrange) then
					Graves_R(targetR)
				end
			end
		end
		if CfgYayoBuddy.KillSteal.KillSteal then GravesKillSteal() end
	end
}

-------------------------------------------------
--KILL STEAL FUNCTIONS---------------------------
-------------------------------------------------
function GravesKillSteal() --15 KS Combinations
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			local qdmg = getDmg("Q",enemy,myHero)
			local wdmg = getDmg("W",enemy,myHero)
    		local edmg = getDmg("E",enemy,myHero)
			local rdmg = getDmg("R",enemy,myHero)
			local ignitedmg = (myHero.selflevel*20)+50

-------------------------------------------------
-- Q Kill Steal ---------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Q and qdmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 950 then --Q KS
				Graves_Q(enemy)
			end
------------------------------------------------
-- R Kill Steal --------------------------------
------------------------------------------------
			if CfgYayoBuddy.KillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --R KS
				Graves_R(enemy)
			end
-------------------------------------------------
-- Ignite Kill Steal ----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Ignite and ignitedmg > enemy.health and GetDistance(myHero,enemy) <= 600 then --Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
				end
			end
-------------------------------------------------
-- Q + R Kill Steal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QR and qdmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 950 then --Q,R KS
				Graves_Q(enemy)
				Graves_R(enemy)
			end
-------------------------------------------------
-- Q + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QIgnite and qdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Graves_Q(enemy)
				end
			end
-------------------------------------------------
-- R + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --R,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Graves_R(enemy)
				end
			end
-------------------------------------------------
-- Q + R + Ignite Kill Steal --------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QRIgnite and qdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,R,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Graves_Q(enemy)
					Graves_R(enemy)
				end
			end
		end
	end
end

-------------------------------------------------
-- Caitlyn Spell Functions ----------------------
-------------------------------------------------
function Graves_Q(QTarget)
	local Qrange, Qwidth, Qspeed, Qdelay = CfgYayoBuddy._SpellRanges.qRNG, 100, 902, 0.5
	if QTarget ~= nil then
		if GetDistance(myHero, QTarget) <= CfgYayoBuddy._SpellRanges.qRNG and myHero.mana >= (50 + (10 * myHero.SpellLevelQ)) then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(QTarget, Qdelay, Qwidth, Qrange, Qspeed, myHero, false) --use linecast until find the angle of Q
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('Q', x, y, z)
			end
		end
	end
end

function Graves_W(WTarget)
	local Wrange, Wwidth, Wspeed, Wdelay = CfgYayoBuddy._SpellRanges.wRNG, 250, 1650, 0.5
	if WTarget ~= nil then
		if GetDistance(myHero, WTarget) <= CfgYayoBuddy._SpellRanges.wRNG and myHero.mana >= (65 + (10 * myHero.SpellLevelW)) then
			local CastPosition, HitChance, Position = YP:GetCircularCastPosition(WTarget, Wdelay, Wwidth, Wrange, Wspeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('W', x, y, z)
			end
		end
	end
end

function Graves_E(ETarget)
	if ETarget ~= nil then
		if GetDistance(myHero, ETarget) <= 950 and myHero.mana >= 40 then
			CastSpellXYZ('E', mousePos.x, mousePos.y, mousePos.z)
		end
	end
end

function Graves_R(RTarget)
	local Rrange, Rwidth, Rspeed, Rdelay = CfgYayoBuddy._SpellRanges.rRNG, 100, 1400, 0.5
	if RTarget ~= nil then
		if GetDistance(myHero, RTarget) <= CfgYayoBuddy._SpellRanges.rRNG and myHero.mana >= 100 then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(RTarget, Rdelay, Rwidth, Rrange, Rspeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('R', x, y, z)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------
-- Tristana Section -------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Tristana = {
	OnTick = function(target)
	local Qrange = myHero.range
	local Wrange = CfgYayoBuddy._SpellRanges.wRNG
	local Erange = myHero.range
	local Rrange = myHero.range
	local targetQ = GetWeakEnemy('PHYS', myHero.range)
	local targetW = GetWeakEnemy('PHYS', CfgYayoBuddy._SpellRanges.wRNG)
	local targetE = GetWeakEnemy('PHYS', myHero.range)
	local targetR = GetWeakEnemy('PHYS', myHero.range)
	local targetAP = GetWeakEnemy('MAGIC', CfgYayoBuddy._SpellRanges.wRNG)
-------------------------------------------------
-- Yayo Auto Carry State ------------------------
-------------------------------------------------		
		if yayo.Config.AutoCarry then
-------------------------------------------------
-- AD Tristana Combo ----------------------------
-------------------------------------------------
			if CfgYayoBuddy.TristMode == 1 then
				if targetQ and CfgYayoBuddy._AutoCarry.useQ then
					if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
						Tristana_Q(targetQ)
					end
				end
				if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(targetW) then
					if targetW and CfgYayoBuddy._AutoCarry.useW then
						if ValidTarget(targetW, Wrange) then
							Tristana_W(targetW)
						end
					end
				else
					if targetW and CfgYayoBuddy._AutoCarry.useW then
						if ValidTarget(targetW, Wrange) then
							Tristana_W(targetW)
						end
					end
				end
				if targetE and CfgYayoBuddy._AutoCarry.useE then
					if ValidTarget(targetE, Erange) then
						Tristana_E(targetE)
					end
				end
				if targetR and CfgYayoBuddy._AutoCarry.useR then
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				end
-------------------------------------------------
-- AP Tristana Combo ----------------------------
-------------------------------------------------
			elseif CfgYayoBuddy.TristMode == 2 then
				if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(targetAP) then
					if targetAP and CfgYayoBuddy._AutoCarry.useW then
						if ValidTarget(targetAP, Wrange) and GetDistance(targetAP) <= Wrange then
							Tristana_W(targetAP)
						end
					end
				else
					if targetAP and CfgYayoBuddy._AutoCarry.useW then
						if ValidTarget(targetAP, Wrange) and GetDistance(targetAP) <= Wrange then
							Tristana_W(targetAP)
						end
					end
				end
				if targetAP and CfgYayoBuddy._AutoCarry.useE then
					if ValidTarget(targetAP, Erange) then
						Tristana_E(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._AutoCarry.useR then
					if ValidTarget(targetAP, Rrange) then
						Tristana_R(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._AutoCarry.useR then
					if ValidTarget(targetR, Rrange) then
						Tristana_R(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._AutoCarry.useQ then
					if ValidTarget(targetAP, Qrange) and GetDistance(targetAP) <= Qrange then
						Tristana_Q(targetAP)
					end
				end
			end
		end
-------------------------------------------------
-- Yayo Mixed Mode State ------------------------
-------------------------------------------------
		if yayo.Config.Mixed then
-------------------------------------------------
-- AD Tristana Combo ----------------------------
-------------------------------------------------
			if CfgYayoBuddy.TristMode == 1 then
				if targetQ and CfgYayoBuddy._MixedMode.useQ then
					if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
						Tristana_Q(targetQ)
					end
				end
				if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(targetW) then
					if targetW and CfgYayoBuddy._MixedMode.useW then
						if ValidTarget(targetW, Wrange) then
							Tristana_W(targetW)
						end
					end
				else
					if targetW and CfgYayoBuddy._MixedMode.useW then
						if ValidTarget(targetW, Wrange) then
							Tristana_W(targetW)
						end
					end
				end
				if targetE and CfgYayoBuddy._MixedMode.useE then
					if ValidTarget(targetE, Erange) then
						Tristana_E(targetE)
					end
				end
				if targetR and CfgYayoBuddy._MixedMode.useR then
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				end
-------------------------------------------------
-- AP Tristana Combo ----------------------------
-------------------------------------------------
			elseif CfgYayoBuddy.TristMode == 2 then
				if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(targetAP) then
					if targetAP and CfgYayoBuddy._MixedMode.useW then
						if ValidTarget(targetAP, Wrange) and GetDistance(targetAP) <= Wrange then
							Tristana_W(targetAP)
						end
					end
				else
					if targetAP and CfgYayoBuddy._MixedMode.useW then
						if ValidTarget(targetAP, Wrange) and GetDistance(targetAP) <= Wrange then
							Tristana_W(targetAP)
						end
					end
				end
				if targetAP and CfgYayoBuddy._MixedMode.useE then
					if ValidTarget(targetAP, Erange) then
						Tristana_E(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._MixedMode.useR then
					if ValidTarget(targetAP, Rrange) then
						Tristana_R(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._MixedMode.useR then
					if ValidTarget(targetR, Rrange) then
						Tristana_R(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._MixedMode.useQ then
					if ValidTarget(targetAP, Qrange) and GetDistance(targetAP) <= Qrange then
						Tristana_Q(targetAP)
					end
				end
			end
		end
-------------------------------------------------
-- Yayo Last Hit State --------------------------
-------------------------------------------------
		if yayo.Config.LastHit then
			-------------------------------------------------
-- AD Tristana Combo ----------------------------
-------------------------------------------------
			if CfgYayoBuddy.TristMode == 1 then
				if targetQ and CfgYayoBuddy._LastHit.useQ then
					if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
						Tristana_Q(targetQ)
					end
				end
				if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(targetW) then
					if targetW and CfgYayoBuddy._LastHit.useW then
						if ValidTarget(targetW, Wrange) then
							Tristana_W(targetW)
						end
					end
				else
					if targetW and CfgYayoBuddy._LastHit.useW then
						if ValidTarget(targetW, Wrange) then
							Tristana_W(targetW)
						end
					end
				end
				if targetE and CfgYayoBuddy._LastHit.useE then
					if ValidTarget(targetE, Erange) then
						Tristana_E(targetE)
					end
				end
				if targetR and CfgYayoBuddy._LastHit.useR then
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				end
-------------------------------------------------
-- AP Tristana Combo ----------------------------
-------------------------------------------------
			elseif CfgYayoBuddy.TristMode == 2 then
				if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(targetAP) then
					if targetAP and CfgYayoBuddy._LastHit.useW then
						if ValidTarget(targetAP, Wrange) and GetDistance(targetAP) <= Wrange then
							Tristana_W(targetAP)
						end
					end
				else
					if targetAP and CfgYayoBuddy._LastHit.useW then
						if ValidTarget(targetAP, Wrange) and GetDistance(targetAP) <= Wrange then
							Tristana_W(targetAP)
						end
					end
				end
				if targetAP and CfgYayoBuddy._LastHit.useE then
					if ValidTarget(targetAP, Erange) then
						Tristana_E(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._LastHit.useR then
					if ValidTarget(targetAP, Rrange) then
						Tristana_R(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._LastHit.useR then
					if ValidTarget(targetR, Rrange) then
						Tristana_R(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._LastHit.useQ then
					if ValidTarget(targetAP, Qrange) and GetDistance(targetAP) <= Qrange then
						Tristana_Q(targetAP)
					end
				end
			end
		end
-------------------------------------------------
-- Yayo Lane Clear State ------------------------
-------------------------------------------------
		if yayo.Config.LaneClear then
			-------------------------------------------------
-- AD Tristana Combo ----------------------------
-------------------------------------------------
			if CfgYayoBuddy.TristMode == 1 then
				if targetQ and CfgYayoBuddy._LaneClear.useQ then
					if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
						Tristana_Q(targetQ)
					end
				end
				if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(targetW) then
					if targetW and CfgYayoBuddy._LaneClear.useW then
						if ValidTarget(targetW, Wrange) then
							Tristana_W(targetW)
						end
					end
				else
					if targetW and CfgYayoBuddy._LaneClear.useW then
						if ValidTarget(targetW, Wrange) then
							Tristana_W(targetW)
						end
					end
				end
				if targetE and CfgYayoBuddy._LaneClear.useE then
					if ValidTarget(targetE, Erange) then
						Tristana_E(targetE)
					end
				end
				if targetR and CfgYayoBuddy._LaneClear.useR then
					if ValidTarget(targetR, Rrange) then
						Caitlyn_R(targetR)
					end
				end
-------------------------------------------------
-- AP Tristana Combo ----------------------------
-------------------------------------------------
			elseif CfgYayoBuddy.TristMode == 2 then
				if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(targetAP) then
					if targetAP and CfgYayoBuddy._LaneClear.useW then
						if ValidTarget(targetAP, Wrange) and GetDistance(targetAP) <= Wrange then
							Tristana_W(targetAP)
						end
					end
				else
					if targetAP and CfgYayoBuddy._LaneClear.useW then
						if ValidTarget(targetAP, Wrange) and GetDistance(targetAP) <= Wrange then
							Tristana_W(targetAP)
						end
					end
				end
				if targetAP and CfgYayoBuddy._LaneClear.useE then
					if ValidTarget(targetAP, Erange) then
						Tristana_E(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._LaneClear.useR then
					if ValidTarget(targetAP, Rrange) then
						Tristana_R(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._LaneClear.useR then
					if ValidTarget(targetR, Rrange) then
						Tristana_R(targetAP)
					end
				end
				if targetAP and CfgYayoBuddy._LaneClear.useQ then
					if ValidTarget(targetAP, Qrange) and GetDistance(targetAP) <= Qrange then
						Tristana_Q(targetAP)
					end
				end
			end
		end
		if CfgYayoBuddy.KillSteal.KillSteal then TristanaKillSteal() end
	end
}

-------------------------------------------------
-- Tristana Spell Functions ---------------------
-------------------------------------------------
function Tristana_Q(QTarget)
	local Qrange = myHero.range
	if QTarget ~= nil then
		if GetDistance(myHero, QTarget) <= Qrange then
			CastSpellTarget('Q', myHero)
		end
	end
end

function Tristana_W(WTarget)
	local Wrange, Wwidth, Wspeed, Wdelay = CfgYayoBuddy._SpellRanges.wRNG, 270, 1150, 0.5
	if WTarget ~= nil then
		if GetDistance(myHero, WTarget) <= Wrange and myHero.mana >= 60 then
			if CfgYayoBuddy.RocketJumpOptions.TristWMode == 1 then
				CastSpellXYZ('W', mousePos.x, mousePos.y, mousePos.z)
			else
				if CfgYayoBuddy.RocketJumpOptions.TristWMode == 2 then
					local CastPosition, HitChance, Position = YP:GetCircularCastPosition(WTarget, Wdelay, Wwidth, Wrange, Wspeed, myHero, false)
					if HitChance >= 2 then
						local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
						CastSpellXYZ('W', x, y, z)
					end
				end
			end
		end
	end
end

function Tristana_E(ETarget)
	local Erange = myHero.range
	if ETarget ~= nil then
		if GetDistance(myHero, ETarget) <= Erange and myHero.mana >= 40+(myHero.selflevel * 10) then
			if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW() then
				CastSpellTarget('E', ETarget)
			else
				CastSpellTarget('E', ETarget)
			end
		end
	end
end

function Tristana_R(RTarget)
	Rrange = myHero.range
	if RTarget ~= nil then
		if GetDistance(myHero, RTarget) <= Rrange and myHero.mana >= 100 then
			CastSpellTarget('R',RTarget)
		end
	end
end

-------------------------------------------------
-- Safe E Related -------------------------------
-------------------------------------------------
function SafeW(target)
	if CountUnit(target,CfgYayoBuddy.RocketJumpOptions.SafeW_Value) < 1 then
		return true
	else
		return false
	end
end

-------------------------------------------------
--KILL STEAL FUNCTIONS---------------------------
-------------------------------------------------
function TristanaKillSteal() --15 KS Combinations
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			local qdmg = getDmg("Q",enemy,myHero)
			local wdmg = getDmg("W",enemy,myHero)
    		local edmg = getDmg("E",enemy,myHero)
			local rdmg = getDmg("R",enemy,myHero)
			local ignitedmg = (myHero.selflevel*20)+50
-------------------------------------------------
-- W KillSteal ----------------------------------
-------------------------------------------------
			if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(enemy) then
				if CfgYayoBuddy.KillSteal.W and wdmg > enemy.health and myHero.SpellTimeW > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W with SafeW KS
					Tristana_W(enemy)
				else
					if CfgYayoBuddy.KillSteal.W and wdmg > enemy.health and myHero.SpellTimeW > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W without SafeW KS
						Tristana_W(enemy)
					end
				end
			end
-------------------------------------------------
-- E KillSteal ----------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.E and edmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= myHero.range then --E KS
				Tristana_E(enemy)
			end
-------------------------------------------------
-- R KillSteal ----------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= myHero.range then --R KS
				Tristana_R(enemy)
			end
-------------------------------------------------
-- Ignite KillSteal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Ignite and ignitedmg > enemy.health and GetDistance(myHero,enemy) <= 600 then --Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
				end
			end
-------------------------------------------------
-- W + E KillSteal ------------------------------
-------------------------------------------------
			if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(enemy) then
				if CfgYayoBuddy.KillSteal.WE and wdmg + edmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,E with SafeW KS
					Tristana_W(enemy)
					Tristana_E(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.WE and wdmg + edmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,E without SafeW KS
					Tristana_W(enemy)
					Tristana_E(enemy)
				end
			end
-------------------------------------------------
-- W + R KillSteal ------------------------------
-------------------------------------------------
			if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(enemy) then
				if CfgYayoBuddy.KillSteal.WR and wdmg + rdmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,R with SafeW KS
					Tristana_W(enemy)
					Tristana_R(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.WR and wdmg + rdmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,R without SafeW KS
					Tristana_W(enemy)
					Tristana_R(enemy)
				end
			end
-------------------------------------------------
-- W + Ignite KillSteal -------------------------
-------------------------------------------------
			if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(enemy) then
				if CfgYayoBuddy.KillSteal.WIgnite and wdmg + ignitedmg > enemy.health and myHero.SpellTimeW > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,Ignite with SafeW KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						Tristana_W(enemy)
						SummonerIgnite(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.WIgnite and wdmg + ignitedmg > enemy.health and myHero.SpellTimeW > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,Ignite without SafeW KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						Tristana_W(enemy)
						SummonerIgnite(enemy)
					end
				end
			end
-------------------------------------------------
-- E + R KillSteal ------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.ER and edmg + rdmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= myHero.range then --E,R KS
				Tristana_E(enemy)
				Tristana_R(enemy)
			end
-------------------------------------------------
-- E + Ignite KillSteal -------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.EIgnite and edmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Tristana_E(enemy)
				end
			end
-------------------------------------------------
-- R + Ignite KillSteal -------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --R,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Tristana_R(enemy)
				end
			end
-------------------------------------------------
-- W + E + R KillSteal --------------------------
-------------------------------------------------
			if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(enemy) then
				if CfgYayoBuddy.KillSteal.WER and wdmg + edmg + rdmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,E,R with SafeW KS
					Tristana_W(enemy)
					Tristana_E(enemy)
					Tristana_R(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.WER and wdmg + edmg + rdmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,E,R without SafeW KS
					Tristana_W(enemy)
					Tristana_E(enemy)
					Tristana_R(enemy)
				end
			end
-------------------------------------------------
-- W + E + Ignite KillSteal ---------------------
-------------------------------------------------
			if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(enemy) then
				if CfgYayoBuddy.KillSteal.WEIgnite and wdmg + edmg + ignitedmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,E,Ignite with SafeW KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						Tristana_W(enemy)
						Tristana_E(enemy)
						SummonerIgnite(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.WEIgnite and wdmg + edmg + ignitedmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,E,Ignite without SafeW KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						Tristana_W(enemy)
						Tristana_E(enemy)
						SummonerIgnite(enemy)
					end
				end
			end
-------------------------------------------------
-- W + R + Ignite KillSteal ---------------------
-------------------------------------------------
			if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(enemy) then
				if CfgYayoBuddy.KillSteal.WRIgnite and wdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,R,Ignite with SafeW KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						Tristana_W(enemy)
						SummonerIgnite(enemy)
						Tristana_R(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.WRIgnite and wdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,R,Ignite without SafeW KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						Tristana_W(enemy)
						SummonerIgnite(enemy)
						Tristana_R(enemy)
					end
				end
			end
-------------------------------------------------
-- E + R + Ignite KillSteal ---------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Tristana_E(enemy)
					Tristana_R(enemy)
				end
			end
-------------------------------------------------
-- W + E + R + Ignite KillSteal -----------------
-------------------------------------------------
			if CfgYayoBuddy.RocketJumpOptions.SafeW and SafeW(enemy) then
				if CfgYayoBuddy.KillSteal.WERIgnite and wdmg + edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,E,R,Ignite KS --SafeW
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						Tristana_W(enemy)
						SummonerIgnite(enemy)
						Tristana_E(enemy)
						Tristana_R(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.WERIgnite and wdmg + edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeW > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= CfgYayoBuddy._SpellRanges.wRNG then --W,E,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						Tristana_W(enemy)
						SummonerIgnite(enemy)
						Tristana_E(enemy)
						Tristana_R(enemy)
					end
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------
-- Teemo Section ----------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Teemo = {
	OnTick = function(target)
		local Qrange = CfgYayoBuddy._SpellRanges.qRNG
		local Wrange = CfgYayoBuddy._SpellRanges.wRNG
		local Rrange = 230
		local targetQ = GetWeakEnemy('MAGIC',Qrange)
		local targetW = GetWeakEnemy('MAGIC', Wrange)
		local targetR = GetWeakEnemy('MAGIC', Rrange)
-------------------------------------------------
-- Yayo Auto Carry State ------------------------
-------------------------------------------------		
		if yayo.Config.AutoCarry then
			if targetQ and CfgYayoBuddy._AutoCarry.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) > myHero.range then
					Teemo_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._AutoCarry.useW then
				if ValidTarget(targetW, Wrange) then
					Teemo_W(targetW)
				end
			end
			if targetR and CfgYayoBuddy._AutoCarry.useR then
				if ValidTarget(targetR, Rrange) then
					Teemo_R(targetR)
				end
			end
		end
-------------------------------------------------
-- Yayo Mixed Mode State ------------------------
-------------------------------------------------
		if yayo.Config.Mixed then
			if targetQ and CfgYayoBuddy._MixedMode.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) > myHero.range then
					Teemo_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._MixedMode.useW then
				if ValidTarget(targetW, Wrange) then
					Teemo_W(targetW)
				end
			end
			if targetR and CfgYayoBuddy._MixedMode.useR then
				if ValidTarget(targetR, Rrange) then
					Teemo_R(targetR)
				end
			end
		end
-------------------------------------------------
-- Yayo Last Hit State --------------------------
-------------------------------------------------
		if yayo.Config.LastHit then
			if targetQ and CfgYayoBuddy._LastHit.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) > myHero.range then
					Teemo_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._LastHit.useW then
				if ValidTarget(targetW, Wrange) then
					Teemo_W(targetW)
				end
			end
			if targetR and CfgYayoBuddy._LastHit.useR then
				if ValidTarget(targetR, Rrange) then
					Teemo_R(targetR)
				end
			end
		end
-------------------------------------------------
-- Yayo Lane Clear State ------------------------
-------------------------------------------------
		if yayo.Config.LaneClear then
			if targetQ and CfgYayoBuddy._LaneClear.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) > myHero.range then
					Teemo_Q(targetQ)
				end
			end
			if targetW and CfgYayoBuddy._LaneClear.useW then
				if ValidTarget(targetW, Wrange) then
					Teemo_W(targetW)
				end
			end
			if targetR and CfgYayoBuddy._LaneClear.useR then
				if ValidTarget(targetR, Rrange) then
					Teemo_R(targetR)
				end
			end
		end
		if CfgYayoBuddy.KillSteal.KillSteal then TeemoKillSteal() end
	end,
	AfterAttack = function(target)
		if target and yayo.Config.AutoCarry then
			if CfgYayoBuddy._AutoCarry.useQ then
				Teemo_Q(target)
			end
		end
		if target and yayo.Config.Mixed then
			if CfgYayoBuddy._MixedMode.useQ then
				Teemo_Q(target)
			end
		end
		if target and yayo.Config.LastHit then
			if CfgYayoBuddy._LastHit.useQ then
				Teemo_Q(target)
			end
		end
		if target and yayo.Config.LaneClear then
			if CfgYayoBuddy._LaneClear.useQ then
				Teemo_Q(target)
			end
		end
	end
}

-------------------------------------------------
--KILL STEAL FUNCTIONS---------------------------
-------------------------------------------------
	function TeemoKillSteal() --15 KS Combinations
		for i = 1, objManager:GetMaxHeroes()  do
	    	local enemy = objManager:GetHero(i)
	    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
				local qdmg = getDmg("Q",enemy,myHero)
				local rdmg = getDmg("R",enemy,myHero)
				local ignitedmg = (myHero.selflevel*20)+50

	-------------------------------------------------
	-- Q Kill Steal ---------------------------------
	-------------------------------------------------
				if CfgYayoBuddy.KillSteal.Q and qdmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 580 then --Q KS
					Teemo_Q(enemy)
				end
	------------------------------------------------
	-- R Kill Steal --------------------------------
	------------------------------------------------
				if CfgYayoBuddy.KillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 230 then --R KS
					Teemo_R(enemy)
				end
	-------------------------------------------------
	-- Ignite Kill Steal ----------------------------
	-------------------------------------------------
				if CfgYayoBuddy.KillSteal.Ignite and ignitedmg > enemy.health and GetDistance(myHero,enemy) <= 600 then --Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
					end
				end
	-------------------------------------------------
	-- Q + R Kill Steal -----------------------------
	-------------------------------------------------
				if CfgYayoBuddy.KillSteal.QR and qdmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 230 then --Q,R KS
					Teemo_Q(enemy)
					Teemo_R(enemy)
				end
	-------------------------------------------------
	-- Q + Ignite Kill Steal ------------------------
	-------------------------------------------------
				if CfgYayoBuddy.KillSteal.QIgnite and qdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 580 then --Q,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Teemo_Q(enemy)
					end
				end
	-------------------------------------------------
	-- R + Ignite Kill Steal ------------------------
	-------------------------------------------------
				if CfgYayoBuddy.KillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 230 then --R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Teemo_R(enemy)
					end
				end
	-------------------------------------------------
	-- Q + R + Ignite Kill Steal --------------------
	-------------------------------------------------
				if CfgYayoBuddy.KillSteal.QRIgnite and qdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 230 then --Q,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Teemo_Q(enemy)
						Teemo_R(enemy)
					end
				end
			end
		end
	end

-------------------------------------------------
-- Teemo Spell Functions ----------------------
-------------------------------------------------
function Teemo_Q(QTarget)
	if QTarget ~= nil then
		if GetDistance(myHero, QTarget) <= CfgYayoBuddy._SpellRanges.qRNG and myHero.mana >= (60 + (10 * myHero.SpellLevelQ)) then
			CastSpellTarget('Q', QTarget)
		end
	end
end

function Teemo_W(WTarget)
	if WTarget ~= nil then
		if GetDistance(myHero, WTarget) <= CfgYayoBuddy._SpellRanges.wRNG and myHero.mana >= 40 then
			CastSpellTarget('W', myHero)
		end
	end
end

function Teemo_R(RTarget)
	local Rrange, Rwidth, Rspeed, Rdelay = 230, 60, math.huge, 0.1
	if RTarget ~= nil then
		if GetDistance(myHero, RTarget) <= 230 and myHero.mana >= (50 + (25 * myHero.SpellLevelR)) and myHero.SpellTimeR > 1.0 then
			local CastPosition, HitChance, Position = YP:GetCircularCastPosition(RTarget, Rdelay, Rwidth, Rrange, Rspeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('R', x, y, z)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------
-- Master Yi Section ------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.MasterYi = {
	OnTick = function(target)
		local targetQ = GetWeakEnemy('PHYS', 600)
		if targetQ and (yayo.Config.AutoCarry or yayo.Config.Mixed) then
			CastSpellTarget('Q', targetQ)
		end
		if target and yayo.Config.AutoCarry then
			CastSpellTarget('E', myHero)
		end
	end,
	AfterAttack = function(target)
		if target and yayo.Config.AutoCarry then
			if ValidTarget(target, myHero.range) then
				CastSpellTarget('W', myHero)
			end
		end
	end
}

---------------------------------------------------------------------------------------------------
-- Ahri Section -----------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Ahri = {
	OnTick = function(target)
		local Qrange, Qwidth, Qspeed, Qdelay = 950, 100, 1600, 0.25
		local Erange, Ewidth, Espeed, Edelay = 975, 60, 1500, 0.25
		local targetQ = GetWeakEnemy("MAGIC", 950)
		local targetE = GetWeakEnemy("MAGIC", 975)
		local targetW = GetWeakEnemy("MAGIC", 800)
		if targetE and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(targetE, 975) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetE, Edelay, Ewidth, Erange, Espeed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('E', x, y, z)
				end
			end
		end
		if targetQ and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(targetQ, 950) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(targetQ, Qdelay, Qwidth, Qrange, Qspeed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
		if targetW and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(targetW, 800) then
				CastSpellTarget('W', myHero)
			end
		end
	end,
}

---------------------------------------------------------------------------------------------------
-- Cassiopeia Section -----------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Cassiopeia = {
	OnTick = function(target)
		local Qrange, Qwidth, Qspeed, Qdelay = 875, 80, math.huge, 0.535
		local Wrange, Wwidth, Wspeed, Wdelay = 875, 80, math.huge, 0.350
		local targetQ = GetWeakEnemy("MAGIC", 875)
		local targetE = GetWeakEnemy("MAGIC", 700)
		local targetW = GetWeakEnemy("MAGIC", 875)
		if targetE and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(targetE, 700) and DetectPoison(targetE) then
				CastSpellTarget('E', targetE)
			end
		end
		if targetQ and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(targetQ, 875) then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(targetQ, Qdelay, Qwidth, Qrange, Qspeed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
		if targetW and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(targetW, 875) then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(targetW, Wdelay, Wwidth, Wrange, Wspeed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('W', x, y, z)
				end
			end
		end
	end,
}

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

---------------------------------------------------------------------------------------------------
-- Riven Section ----------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Riven = {
	OnTick = function(target)
		local targetQ = GetWeakEnemy("PHYS", 385)
		if targetQ and (yayo.Config.AutoCarry or yayo.Config.Mixed) then
			if ValidTarget(targetQ, 385) and GetDistance(targetQ) > 125 then
				CastSpellXYZ('Q', mousePos.x, mousePos.y, mousePos.z)
			end
		end
		local targetW = GetWeakEnemy("PHYS", 125)
		if targetW and (yayo.Config.AutoCarry or yayo.Config.Mixed) then
			if ValidTarget(targetW, 125) then
				CastSpellTarget('W', myHero)
			end
		end
		local targetE = GetWeakEnemy("PHYS", 325)
		if targetE and (yayo.Config.AutoCarry or yayo.Config.Mixed) then
			if ValidTarget(targetE, 325) then
				CastSpellXYZ('E', mousePos.x, mousePos.y, mousePos.z)
			end
		end
	end,
	AfterAttack = function(target)
		if target and yayo.Config.AutoCarry then
			if ValidTarget(target, 260) then
				CastSpellXYZ('Q', mousePos.x, mousePos.y, mousePos.z)
			end
		end
	end
}

---------------------------------------------------------------------------------------------------
-- Ryze Section -----------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Ryze = {
	OnTick = function(target)
		local target = GetWeakEnemy('Magic', 625)
		if yayo.Config.AutoCarry then
			if target then
				if CfgYayoBuddy._AutoCarry.useAA then yayo.EnableAttacks() else yayo.DisableAttacks() end
				if CfgYayoBuddy._AutoCarry.useQ and myHero.SpellTimeQ > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.qRNG then
					CastSpellTarget('Q', target)
				elseif CfgYayoBuddy._AutoCarry.useW and myHero.SpellTimeW > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.wRNG then
					CastSpellTarget('W', target)
				elseif CfgYayoBuddy._AutoCarry.useE and myHero.SpellTimeE > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.eRNG then
					CastSpellTarget('E', target)
				elseif CfgYayoBuddy._AutoCarry.useR and myHero.SpellTimeR > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.rRNG then
					CastSpellTarget('R', myHero)
				end
			end
		end
		if yayo.Config.Mixed then
			if target then
				if CfgYayoBuddy._MixedMode.useQ and myHero.SpellTimeQ > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.qRNG then
					CastSpellTarget('Q', target)
				elseif CfgYayoBuddy._MixedMode.useW and myHero.SpellTimeW > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.wRNG then
					CastSpellTarget('W', target)
				elseif CfgYayoBuddy._MixedMode.useE and myHero.SpellTimeE > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.eRNG then
					CastSpellTarget('E', target)
				elseif CfgYayoBuddy._MixedMode.useR and myHero.SpellTimeR > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.rRNG then
					CastSpellTarget('R', myHero)
				end
			end
		end
		if yayo.Config.LaneClear then
			if target then
				if CfgYayoBuddy._LaneClear.useQ and myHero.SpellTimeQ > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.qRNG then
					CastSpellTarget('Q', target)
				elseif CfgYayoBuddy._LaneClear.useW and myHero.SpellTimeW > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.wRNG then
					CastSpellTarget('W', target)
				elseif CfgYayoBuddy._LaneClear.useE and myHero.SpellTimeE > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.eRNG then
					CastSpellTarget('E', target)
				elseif CfgYayoBuddy._LaneClear.useR and myHero.SpellTimeR > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.rRNG then
					CastSpellTarget('R', myHero)
				end
			end
		end
		if yayo.Config.LastHit then
			if target then
				if CfgYayoBuddy._LastHit.useQ and myHero.SpellTimeQ > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.qRNG then
					CastSpellTarget('Q', target)
				elseif CfgYayoBuddy._LastHit.useW and myHero.SpellTimeW > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.wRNG then
					CastSpellTarget('W', target)
				elseif CfgYayoBuddy._LastHit.useE and myHero.SpellTimeE > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.eRNG then
					CastSpellTarget('E', target)
				elseif CfgYayoBuddy._LastHit.useR and myHero.SpellTimeR > 1.0 and GetDistance(myHero, target) <= CfgYayoBuddy._SpellRanges.rRNG then
					CastSpellTarget('R', myHero)
				end
			end
		end
	end
}

---------------------------------------------------------------------------------------------------
-- Miss Fortune Section ---------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.MissFortune = {
	OnTick = function(target)
		local targetQ = GetWeakEnemy('PHYS', 650)
		local targetW = GetWeakEnemy('PHYS', 650)
		local targetE = GetWeakEnemy('PHYS', 800)
		local targetR = GetWeakEnemy('PHYS', 1400)
		local Qrange = CfgYayoBuddy._SpellRanges.qRNG
		local Wrange = CfgYayoBuddy._SpellRanges.wRNG
		local Erange = CfgYayoBuddy._SpellRanges.eRNG
		local Rrange = CfgYayoBuddy._SpellRanges.rRNG
-------------------------------------------------
-- Yayo Auto Carry State ------------------------
-------------------------------------------------		
		if yayo.Config.AutoCarry then
			if targetW and CfgYayoBuddy._AutoCarry.useW then
				if ValidTarget(targetW, Wrange) then
					MissFortune_W(targetW)
				end
			end
			if targetQ and CfgYayoBuddy._AutoCarry.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					MissFortune_Q(targetQ)
				end
			end
			if targetE and CfgYayoBuddy._AutoCarry.useE then
				if ValidTarget(targetE, Erange) then
					MissFortune_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._AutoCarry.useR then
				if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
					if ValidTarget(targetR, Rrange) then
						MissFortune_R(targetR)
					end
				else
					if ValidTarget(targetR, Rrange) then
						MissFortune_R(targetR)
					end
				end
			end
		end
-------------------------------------------------
-- Yayo Mixed Mode State ------------------------
-------------------------------------------------
		if yayo.Config.Mixed then
			if targetW and CfgYayoBuddy._MixedMode.useW then
				if ValidTarget(targetW, Wrange) then
					MissFortune_W(targetW)
				end
			end
			if targetQ and CfgYayoBuddy._MixedMode.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					MissFortune_Q(targetQ)
				end
			end
			if targetE and CfgYayoBuddy._MixedMode.useE then
				if ValidTarget(targetE, Erange) then
					MissFortune_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._MixedMode.useR then
				if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
					if ValidTarget(targetR, Rrange) then
						MissFortune_R(targetR)
					end
				else
					if ValidTarget(targetR, Rrange) then
						MissFortune_R(targetR)
					end
				end
			end
		end
-------------------------------------------------
-- Yayo Last Hit State --------------------------
-------------------------------------------------
		if yayo.Config.LastHit then
			if targetW and CfgYayoBuddy._LastHit.useW then
				if ValidTarget(targetW, Wrange) then
					MissFortune_W(targetW)
				end
			end
			if targetQ and CfgYayoBuddy._LastHit.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					MissFortune_Q(targetQ)
				end
			end
			if targetE and CfgYayoBuddy._LastHit.useE then
				if ValidTarget(targetE, Erange) then
					MissFortune_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._LastHit.useR then
				if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
					if ValidTarget(targetR, Rrange) then
						MissFortune_R(targetR)
					end
				else
					if ValidTarget(targetR, Rrange) then
						MissFortune_R(targetR)
					end
				end
			end
		end
-------------------------------------------------
-- Yayo Lane Clear State ------------------------
-------------------------------------------------
		if yayo.Config.LaneClear then
			if targetW and CfgYayoBuddy._LaneClear.useW then
				if ValidTarget(targetW, Wrange) then
					MissFortune_W(targetW)
				end
			end
			if targetQ and CfgYayoBuddy._LaneClear.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					MissFortune_Q(targetQ)
				end
			end
			if targetE and CfgYayoBuddy._LaneClear.useE then
				if ValidTarget(targetE, Erange) then
					MissFortune_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._LaneClear.useR then
				if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
					if ValidTarget(targetR, Rrange) then
						MissFortune_R(targetR)
					end
				else
					if ValidTarget(targetR, Rrange) then
						MissFortune_R(targetR)
					end
				end
			end
		end
		if CfgYayoBuddy.KillSteal.KillSteal then MissFortuneKillSteal() end
	end
}

-------------------------------------------------
--KILL STEAL FUNCTIONS---------------------------
-------------------------------------------------
function MissFortuneKillSteal() --15 KS Combinations
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			local qdmg = getDmg("Q",enemy,myHero)
    		local edmg = getDmg("E",enemy,myHero)
			local rdmg = getDmg("R",enemy,myHero)
			local ignitedmg = (myHero.selflevel*20)+50

-------------------------------------------------
-- Q Kill Steal ---------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Q and qdmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 1300 then --Q KS
				MissFortune_Q(enemy)
			end
-------------------------------------------------
-- E Kill Steal ---------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.E and edmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E KS
				MissFortune_E(enemy)
			end
------------------------------------------------
-- R Kill Steal --------------------------------
------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= (1500+(500*myHero.SpellLevelR)) then --R KS --SafeR
					MissFortune_R(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= (1500+(500*myHero.SpellLevelR)) then --R KS
					MissFortune_R(enemy)
				end
			end
-------------------------------------------------
-- Ignite Kill Steal ----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Ignite and ignitedmg > enemy.health and GetDistance(myHero,enemy) <= 600 then --Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
				end
			end
-------------------------------------------------
-- Q + E Kill Steal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QE and qdmg + edmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E KS
				MissFortune_Q(enemy)
				MissFortune_E(enemy)
			end
-------------------------------------------------
-- Q + R Kill Steal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.QR and qdmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1300 then --Q,R KS --SafeR
					MissFortune_Q(enemy)
					MissFortune_R(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.QR and qdmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1300 then --Q,R KS
					MissFortune_Q(enemy)
					MissFortune_R(enemy)
				end
			end
-------------------------------------------------
-- Q + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QIgnite and qdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					MissFortune_Q(enemy)
				end
			end
-------------------------------------------------
-- E + R Kill Steal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.ER and edmg + rdmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E,R KS
					MissFortune_E(enemy)
					MissFortune_R(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.ER and edmg + rdmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E,R KS --SafeR
					MissFortune_E(enemy)
					MissFortune_R(enemy)
				end
			end
-------------------------------------------------
-- E + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.EIgnite and edmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					MissFortune_E(enemy)
				end
			end
-------------------------------------------------
-- R + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						MissFortune_R(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						MissFortune_R(enemy)
					end
				end
			end
-------------------------------------------------
-- Q + E + R Kill Steal -------------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.QER and qdmg + edmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E,R KS --SafeR
					MissFortune_Q(enemy)
					MissFortune_E(enemy)
					MissFortune_R(enemy)
				end
			else
				if CfgYayoBuddy.KillSteal.QER and qdmg + edmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E,R KS
					MissFortune_Q(enemy)
					MissFortune_E(enemy)
					MissFortune_R(enemy)
				end
			end
-------------------------------------------------
-- Q + E + Ignite Kill Steal --------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QEIgnite and qdmg + edmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,E,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					MissFortune_Q(enemy)
					MissFortune_E(enemy)
				end
			end
-------------------------------------------------
-- Q + R + Ignite Kill Steal --------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.QRIgnite and qdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						MissFortune_Q(enemy)
						MissFortune_R(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.QRIgnite and qdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						MissFortune_Q(enemy)
						MissFortune_R(enemy)
					end
				end
			end
-------------------------------------------------
-- E + R + Igite Kill Steal ---------------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						MissFortune_E(enemy)
						MissFortune_R(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						MissFortune_E(enemy)
						MissFortune_R(enemy)
					end
				end
			end
-------------------------------------------------
-- Q + E + R + Ignite Kill Steal ----------------
-------------------------------------------------
			if CfgYayoBuddy.UltimateOptions.SafeR and SafeR() then
				if CfgYayoBuddy.KillSteal.QERIgnite and qdmg + edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,E,R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						MissFortune_Q(enemy)
						MissFortune_E(enemy)
						MissFortune_R(enemy)
					end
				end
			else
				if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						MissFortune_E(enemy)
						MissFortune_R(enemy)
					end
				end
			end
		end
	end
end

-------------------------------------------------
-- Miss Fortune Spell Functions -----------------
-------------------------------------------------
function MissFortune_Q(QTarget)
	if QTarget ~= nil then
		if GetDistance(myHero, QTarget) <= CfgYayoBuddy._SpellRanges.qRNG and myHero.mana >= (40 + (3 * myHero.SpellLevelQ)) then
			CastSpellTarget('Q', QTarget)
		end
	end
end

function MissFortune_W(WTarget)
	if WTarget ~= nil then
		if GetDistance(myHero, WTarget) <= CfgYayoBuddy._SpellRanges.wRNG and myHero.mana >= (25 + (5 * myHero.SpellLevelQ)) then
			CastSpellTarget('W', myHero)
		end
	end
end

function MissFortune_E(ETarget)
	local Erange, Ewidth, Espeed, Edelay = CfgYayoBuddy._SpellRanges.eRNG, 300, 500, 0.5
	if ETarget ~= nil then
		if GetDistance(myHero, ETarget) <= Espeed and myHero.mana >= 80 then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(ETarget, Edelay, Ewidth, Erange, Espeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('E', x, y, z)
			end
		end
	end
end

function MissFortune_R(RTarget)
	if RTarget ~= nil then
		local Rrange, Rwidth, Rspeed, Rdelay = CfgYayoBuddy._SpellRanges.rRNG, 100, 780, 0.333
		if RTarget ~= nil then
			if GetDistance(myHero, RTarget) <= Rspeed and myHero.mana >= 100 then
				local CastPosition, HitChance, Position = YP:GetConeAOECastPosition(RTarget, Rdelay, 30, Rrange, Rspeed, myHero)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('R', x, y, z)
					local timer = os.time()
					yayo.DisableAttacks()
					yayo.DisableMove()
					repeat until os.time() > timer + 2
					yayo.EnableAttacks()
					yayo.EnableMove()
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------
-- KogMaw Section ---------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.KogMaw = {
	OnTick = function(target)
		StackReset()
		local Qrange = CfgYayoBuddy._SpellRanges.qRNG
		local Wrange = GetWRange()
		local Erange = CfgYayoBuddy._SpellRanges.eRNG
		local Rrange = GetRRange()
		local targetQ = GetWeakEnemy('PHYS', 1150)
		local targetW = GetWeakEnemy('PHYS', Wrange)
		local targetE = GetWeakEnemy('PHYS', 1000)
		local targetR = GetWeakEnemy('PHYS', Rrange)
-------------------------------------------------
-- Yayo Auto Carry State ------------------------
-------------------------------------------------
		if yayo.Config.AutoCarry then
			if targetW and CfgYayoBuddy._AutoCarry.useW then
				if ValidTarget(targetW, Wrange) then
					KogMaw_W(targetW)
				end
			end
			if targetE and CfgYayoBuddy._AutoCarry.useE then
				if ValidTarget(targetE, Erange) then
					KogMaw_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._AutoCarry.useR then
				if ValidTarget(targetR, Rrange) then
					KogMaw_R(targetR)
				end
			end
			if targetQ and CfgYayoBuddy._AutoCarry.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					KogMaw_Q(targetQ)
				end
			end
		end
-------------------------------------------------
-- Yayo Mixed Mode State ------------------------
-------------------------------------------------
		if yayo.Config.Mixed then
			if targetW and CfgYayoBuddy._MixedMode.useW then
				if ValidTarget(targetW, Wrange) then
					KogMaw_W(targetW)
				end
			end
			if targetE and CfgYayoBuddy._MixedMode.useE then
				if ValidTarget(targetE, Erange) then
					KogMaw_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._MixedMode.useR then
				if ValidTarget(targetR, Rrange) then
					KogMaw_R(targetR)
				end
			end
			if targetQ and CfgYayoBuddy._MixedMode.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					KogMaw_Q(targetQ)
				end
			end
		end
-------------------------------------------------
-- Yayo Last Hit State --------------------------
-------------------------------------------------
		if yayo.Config.LastHit then
			if targetW and CfgYayoBuddy._LastHit.useW then
				if ValidTarget(targetW, Wrange) then
					KogMaw_W(targetW)
				end
			end
			if targetE and CfgYayoBuddy._LastHit.useE then
				if ValidTarget(targetE, Erange) then
					KogMaw_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._LastHit.useR then
				if ValidTarget(targetR, Rrange) then
					KogMaw_R(targetR)
				end
			end
			if targetQ and CfgYayoBuddy._LastHit.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					KogMaw_Q(targetQ)
				end
			end
		end
-------------------------------------------------
-- Yayo Lane Clear State ------------------------
-------------------------------------------------
		if yayo.Config.LaneClear then
			if targetW and CfgYayoBuddy._LaneClear.useW then
				if ValidTarget(targetW, Wrange) then
					KogMaw_W(targetW)
				end
			end
			if targetE and CfgYayoBuddy._LaneClear.useE then
				if ValidTarget(targetE, Erange) then
					KogMaw_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._LaneClear.useR then
				if ValidTarget(targetR, Rrange) then
					KogMaw_R(targetR)
				end
			end
			if targetQ and CfgYayoBuddy._LaneClear.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					KogMaw_Q(targetQ)
				end
			end
		end
		if CfgYayoBuddy.KillSteal.KillSteal then KogMawKillSteal() end
	end
}

-------------------------------------------------
--KILL STEAL FUNCTIONS---------------------------
-------------------------------------------------
function KogMawKillSteal()
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			local qdmg = getDmg("Q",enemy,myHero)
    		local edmg = getDmg("E",enemy,myHero)
			local rdmg = getDmg("R",enemy,myHero)
			local ignitedmg = (myHero.selflevel*20)+50

-------------------------------------------------
-- Q Kill Steal ---------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Q and qdmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q KS
				KogMaw_Q(enemy)
			end
-------------------------------------------------
-- E Kill Steal ---------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.E and edmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E KS
				KogMaw_E(enemy)
			end
------------------------------------------------
-- R Kill Steal --------------------------------
------------------------------------------------
			if CfgYayoBuddy.KillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= GetRRange() then --R KS
				KogMaw_R(enemy)
			end
-------------------------------------------------
-- Ignite Kill Steal ----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Ignite and ignitedmg > enemy.health and GetDistance(myHero,enemy) <= 600 then --Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
				end
			end
-------------------------------------------------
-- Q + E Kill Steal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QE and qdmg + edmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E KS
				KogMaw_Q(enemy)
				KogMaw_E(enemy)
			end
-------------------------------------------------
-- Q + R Kill Steal -----------------------------
-------------------------------------------------
				if CfgYayoBuddy.KillSteal.QR and qdmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,R KS
					KogMaw_Q(enemy)
					KogMaw_R(enemy)
				end
-------------------------------------------------
-- Q + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QIgnite and qdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					KogMaw_Q(enemy)
				end
			end
-------------------------------------------------
-- E + R Kill Steal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.ER and edmg + rdmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E,R KS --SafeR
				KogMaw_E(enemy)
				KogMaw_R(enemy)
			end
-------------------------------------------------
-- E + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.EIgnite and edmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					KogMaw_E(enemy)
				end
			end
-------------------------------------------------
-- R + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --R,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					KogMaw_R(enemy)
				end
			end
-------------------------------------------------
-- Q + E + R Kill Steal -------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QER and qdmg + edmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E,R KS
				KogMaw_Q(enemy)
				KogMaw_E(enemy)
				KogMaw_R(enemy)
			end
-------------------------------------------------
-- Q + E + Ignite Kill Steal --------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QEIgnite and qdmg + edmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,E,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					KogMaw_Q(enemy)
					KogMaw_E(enemy)
				end
			end
-------------------------------------------------
-- Q + R + Ignite Kill Steal --------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QRIgnite and qdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,R,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					KogMaw_Q(enemy)
					KogMaw_R(enemy)
				end
			end
-------------------------------------------------
-- E + R + Igite Kill Steal ---------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					KogMaw_E(enemy)
					KogMaw_R(enemy)
				end
			end
-------------------------------------------------
-- Q + E + R + Ignite Kill Steal ----------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					KogMaw_E(enemy)
					KogMaw_R(enemy)
				end
			end
		end
	end
end

-------------------------------------------------
-- Calculate W Range ----------------------------
-------------------------------------------------
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

-------------------------------------------------
-- Calculate R Range ----------------------------
-------------------------------------------------
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

-------------------------------------------------
-- Registers an R stack -------------------------
-------------------------------------------------
function OnProcessSpell(unit, spell)
	if unit ~= nil and spell ~= nil and unit.charName == myHero.charName and spell.name:lower():find("kogmawlivingartillery") then
		stacks = stacks + 1
		timer_R = os.time()
		print('Stack2', stacks)
		print('StackCheck', StackCheck())
		print('RRange', GetRRange())
	end
end

-------------------------------------------------
-- Stack Check ----------------------------------
-------------------------------------------------
function StackCheck()
	if (myHero.SpellLevelR == 1 and stacks < CfgYayoBuddy.UltimateOptions.RStack1)
	or (myHero.SpellLevelR == 2 and stacks < CfgYayoBuddy.UltimateOptions.RStack2)
	or (myHero.SpellLevelR == 3 and stacks < CfgYayoBuddy.UltimateOptions.RStack3) then
		return true
	end
end

-------------------------------------------------
-- Stack Reset ----------------------------------
-------------------------------------------------
function StackReset()
	if os.time() > timer_R + 6.5 then 
		stacks = 0
	end
end

-------------------------------------------------
-- KogMaw Spell Functions -----------------------
-------------------------------------------------
function KogMaw_Q(QTarget)
	local Qrange, Qwidth, Qspeed, Qdelay = CfgYayoBuddy._SpellRanges.qRNG, 90, 2225, 0.632
	if QTarget ~= nil then
		if GetDistance(myHero, QTarget) <= CfgYayoBuddy._SpellRanges.qRNG and myHero.mana >= (40 + (10 * myHero.SpellLevelQ)) then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(QTarget, Qdelay, Qwidth, Qrange, Qspeed, myHero, true)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('Q', x, y, z)
			end
		end
	end
end

function KogMaw_W(WTarget)
	if WTarget ~= nil then
		if GetDistance(myHero, WTarget) <= CfgYayoBuddy._SpellRanges.wRNG and myHero.mana >= (40 + (10 * myHero.SpellLevelW)) then
				CastSpellTarget('W', myHero)
		end
	end
end

function KogMaw_E(ETarget)
	local Erange, Ewidth, Espeed, Edelay = CfgYayoBuddy._SpellRanges.eRNG, 80, 800, 0.60
	if ETarget ~= nil then
		if GetDistance(myHero, ETarget) <= Erange and myHero.mana >= 90 then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(ETarget, Edelay, Ewidth, Erange, Espeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('E', x, y, z)
			end
		end
	end
end

function KogMaw_R(RTarget)
	local Rrange, Rwidth, Rspeed, Rdelay = GetRRange(), 100, 1000, 0.25
	if RTarget ~= nil then
		if myHero.SpellTimeR > 1.0 and StackCheck() and myHero.mana >= 40 and GetDistance(RTarget) <= Rrange then
			local CastPosition, HitChance, Position = YP:GetCircularCastPosition(RTarget, Rdelay, Rwidth, Rrange, Rspeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('R', x, y, z)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------
-- Auto Potions -----------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
function CCONN_Potions()
	if bluePill == nil then
		if myHero.health < myHero.maxHealth * (CfgYayoBuddy.AutoPotions.Health_Potion_Value / 100) and GetClock() > wUsedAt + 15000 then
			usePotion()
			wUsedAt = GetTick()
		elseif myHero.health < myHero.maxHealth * (CfgYayoBuddy.AutoPotions.Chrystalline_Flask_Value / 100) and GetClock() > vUsedAt + 10000 then 
			useFlask()
			vUsedAt = GetTick()
		elseif myHero.health < myHero.maxHealth * (CfgYayoBuddy.AutoPotions.Biscuit_Value / 100) then
			useBiscuit()
		elseif myHero.health < myHero.maxHealth * (CfgYayoBuddy.AutoPotions.Elixir_of_Fortitude_Value / 100) then
			useElixir()
		end
		if myHero.mana < myHero.maxMana * (CfgYayoBuddy.AutoPotions.Mana_Potion_Value / 100) and GetClock() > mUsedAt + 15000 then
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

---------------------------------------------------------------------------------------------------
-- Summoner Spells --------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

function CCONN_Summoners()
	if CfgYayoBuddy.AutoSummoners.Auto_Barrier_ONOFF then
		SummonerBarrier()
	end
	if CfgYayoBuddy.AutoSummoners.Auto_Heal_ONOFF then
		SummonerHeal()
	end
	if CfgYayoBuddy.AutoSummoners.Auto_Clarity_ONOFF then
		SummonerClarity()
	end
end

function SummonerIgniteCombo(TargetIgnite)
	if TargetIgnite ~= nil then
		if myHero.SummonerD == 'SummonerDot' then
			if TargetIgnite.health <= TargetIgnite.maxHealth*(CfgYayoBuddy.SummonerSpells.AutoIgniteComboValue / 100) then
				CastSpellTarget('D',TargetIgnite)
			end
		end
		if myHero.SummonerF == 'SummonerDot' then
			if TargetIgnite.health <= TargetIgnite.maxHealth*(CfgYayoBuddy.SummonerSpells.AutoIgniteComboValue / 100) then
				CastSpellTarget('F',TargetIgnite)
			end
		end
	end
end

function SummonerIgnite(TargetIgnite)
	local damage = (myHero.selflevel*20)+50
	if TargetIgnite ~= nil then
		if myHero.SummonerD == 'SummonerDot' then
			CastSpellTarget('D',TargetIgnite)
		end
		if myHero.SummonerF == 'SummonerDot' then
			CastSpellTarget('F',TargetIgnite)
		end
	end
end

function SummonerBarrier()
	if myHero.SummonerD == 'SummonerFlash' then return end
		if myHero.SummonerD == 'SummonerBarrier' then
			if myHero.health < myHero.maxHealth*(CfgYayoBuddy.AutoSummoners.AutoBarrierValue / 100) then
				CastSummonerBarrier()
			end
		end
	if myHero.SummonerF == 'SummonerFlash' then return end
		if myHero.SummonerF == 'SummonerBarrier' then
			if myHero.health < myHero.maxHealth*(CfgYayoBuddy.AutoSummoners.AutoBarrierValue / 100) then
				CastSummonerBarrier()
			end
		end
end

function SummonerHeal()
	if myHero.SummonerD == 'SummonerHeal' then
		if myHero.health < myHero.maxHealth*(CfgYayoBuddy.AutoSummoners.AutoHealValue / 100) then
			CastSummonerHeal()
		end
	end
	if myHero.SummonerF == 'SummonerHeal' then
		if myHero.health < myHero.maxHealth*(CfgYayoBuddy.AutoSummoners.AutoHealValue / 100) then
			CastSummonerHeal()
		end
	end
end

function SummonerExhaustCombo(ExhaustTarget)
	if ExhaustTarget ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if ExhaustTarget.health <= ExhaustTarget.maxHealth*(CfgYayoBuddy.SumonerSpells.AutoExhaustComboValue / 100) then
				CastSpellTarget('D',ExhaustTarget)
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if ExhaustTarget.health <= ExhaustTarget.maxHealth*(CfgYayoBuddy.SummonerSpells.AutoExhaustComboValue / 100) then
				CastSpellTarget('F',ExhaustTarget)
			end
		end
	end
end

function SummonerExhaust(ExhaustTarget)
	if ExhaustTarget ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*(CfgYayoBuddy.SummonerSpells.AutoExhaustValue / 100) then
				if myHero.health < ExhaustTarget.health then
					CastSpellTarget('D',ExhaustTarget)
				end
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*(CfgYayoBuddy.SummonerSpells.AutoExhaustValue / 100) then
				if myHero.health < ExhaustTarget.health then
					CastSpellTarget('F',ExhaustTarget)
				end
			end
		end
	end
end

function SummonerClarity()
	if myHero.SummonerD == 'SummonerMana' then
		if myHero.mana < myHero.maxMana*(CfgYayoBuddy.AutoSummoners.AutoClarityValue / 100) then
			CastSummonerClarity()
		end
	end
	if myHero.SummonerF == 'SummonerMana' then
		if myHero.mana < myHero.maxMana*(CfgYayoBuddy.AutoSummoners.AutoClarityValue / 100) then
			CastSummonerClarity()
		end
	end
end

---------------------------------------------------------------------------------------------------
-- Counts Units within a radius of a point --------------------------------------------------------
---------------------------------------------------------------------------------------------------
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

---------------------------------------------------------------------------------------------------
-- Caitlyn Section --------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Simple.Corki = {
	OnTick = function(target)
		local Qrange = CfgYayoBuddy._SpellRanges.qRNG
		local Erange = CfgYayoBuddy._SpellRanges.eRNG
		local Rrange = CfgYayoBuddy._SpellRanges.rRNG
		local targetQ = GetWeakEnemy('PHYS', 825)
		local targetW = GetWeakEnemy('PHYS', 800)
		local targetE = GetWeakEnemy('PHYS', 600)
		local targetR = GetWeakEnemy('PHYS', 1225)
-------------------------------------------------
-- Yayo Auto Carry State ------------------------
-------------------------------------------------		
		if yayo.Config.AutoCarry then
			if targetQ and CfgYayoBuddy._AutoCarry.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					Corki_Q(targetQ)
				end
			end
			if targetE and CfgYayoBuddy._AutoCarry.useE then
				if ValidTarget(targetE, Erange) then
					Corki_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._AutoCarry.useR then
				if ValidTarget(targetR, Rrange) then
					Corki_R(targetR)
				end
			end
		end
-------------------------------------------------
-- Yayo Mixed Mode State ------------------------
-------------------------------------------------
		if yayo.Config.Mixed then
			if targetQ and CfgYayoBuddy._MixedMode.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					Corki_Q(targetQ)
				end
			end
			if targetE and CfgYayoBuddy._MixedMode.useE then
				if ValidTarget(targetE, Erange) then
					Corki_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._MixedMode.useR then
				if ValidTarget(targetR, Rrange) then
					Corki_R(targetR)
				end
			end
		end
-------------------------------------------------
-- Yayo Last Hit State --------------------------
-------------------------------------------------
		if yayo.Config.LastHit then
			if targetQ and CfgYayoBuddy._LastHit.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					Corki_Q(targetQ)
				end
			end
			if targetE and CfgYayoBuddy._LastHit.useE then
				if ValidTarget(targetE, Erange) then
					Corki_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._LastHit.useR then
				if ValidTarget(targetR, Rrange) then
					Corki_R(targetR)
				end
			end
		end
-------------------------------------------------
-- Yayo Lane Clear State ------------------------
-------------------------------------------------
		if yayo.Config.LaneClear then
			if targetQ and CfgYayoBuddy._LaneClear.useQ then
				if ValidTarget(targetQ, Qrange) and GetDistance(targetQ) <= Qrange then
					Corki_Q(targetQ)
				end
			end
			if targetE and CfgYayoBuddy._LaneClear.useE then
				if ValidTarget(targetE, Erange) then
					Corki_E(targetE)
				end
			end
			if targetR and CfgYayoBuddy._LaneClear.useR then
				if ValidTarget(targetR, Rrange) then
					Corki_R(targetR)
				end
			end
		end
		if CfgYayoBuddy.KillSteal.KillSteal then CorkiKillSteal() end
	end
}

-------------------------------------------------
--KILL STEAL FUNCTIONS---------------------------
-------------------------------------------------
function CorkiKillSteal() --15 KS Combinations
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			local qdmg = getDmg("Q",enemy,myHero)
			--local wdmg = getDmg("W",enemy,myHero)
    		local edmg = getDmg("E",enemy,myHero)
			local rdmg = getDmg("R",enemy,myHero)
			local ignitedmg = (myHero.selflevel*20)+50

-------------------------------------------------
-- Q Kill Steal ---------------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Q and qdmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 825 then --Q KS
				Corki_Q(enemy)
			end
-------------------------------------------------
-- E Kill Steal --------------------------------- Disabled all E related kill steals - don't like how they feel. Leaving code for future testing.
-------------------------------------------------
--			if CfgYayoBuddy.KillSteal.E and edmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --E KS
--				Corki_E(enemy)
--			end
------------------------------------------------
-- R Kill Steal --------------------------------
------------------------------------------------
			if CfgYayoBuddy.KillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1225 then --R KS
				Corki_R(enemy)
			end
-------------------------------------------------
-- Ignite Kill Steal ----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.Ignite and ignitedmg > enemy.health and GetDistance(myHero,enemy) <= 600 then --Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
				end
			end
-------------------------------------------------
-- Q + E Kill Steal -----------------------------
-------------------------------------------------
--			if CfgYayoBuddy.KillSteal.QE and qdmg + edmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,E KS
--				Corki_Q(enemy)
--				Corki_E(enemy)
--			end
-------------------------------------------------
-- Q + R Kill Steal -----------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QR and qdmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 825 then --Q,R KS
				Corki_Q(enemy)
				Corki_R(enemy)
			end
-------------------------------------------------
-- Q + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QIgnite and qdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Corki_Q(enemy)
				end
			end
-------------------------------------------------
-- E + R Kill Steal -----------------------------
-------------------------------------------------
--			if CfgYayoBuddy.KillSteal.ER and edmg + rdmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R KS --SafeR
--				Corki_E(enemy)
--				Corki_R(enemy)
--			end
-------------------------------------------------
-- E + Ignite Kill Steal ------------------------
-------------------------------------------------
--			if CfgYayoBuddy.KillSteal.EIgnite and edmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,Ignite KS
--				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
--					SummonerIgnite(enemy)
--					Corki_E(enemy)
--				end
--			end
-------------------------------------------------
-- R + Ignite Kill Steal ------------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --R,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Corki_R(enemy)
				end
			end
-------------------------------------------------
-- Q + E + R Kill Steal -------------------------
-------------------------------------------------
--				if CfgYayoBuddy.KillSteal.QER and qdmg + edmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,E,R KS
--					Corki_Q(enemy)
--					Corki_E(enemy)
--					Corki_R(enemy)
--				end
-------------------------------------------------
-- Q + E + Ignite Kill Steal --------------------
-------------------------------------------------
--			if CfgYayoBuddy.KillSteal.QEIgnite and qdmg + edmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,E,Ignite KS
--				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
--					SummonerIgnite(enemy)
--					Corki_Q(enemy)
--					Corki_E(enemy)
--				end
--			end
-------------------------------------------------
-- Q + R + Ignite Kill Steal --------------------
-------------------------------------------------
			if CfgYayoBuddy.KillSteal.QRIgnite and qdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,R,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Corki_Q(enemy)
					Corki_R(enemy)
				end
			end
-------------------------------------------------
-- E + R + Igite Kill Steal ---------------------
-------------------------------------------------
--			if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
--				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
--					SummonerIgnite(enemy)
--					Corki_E(enemy)
--					Corki_R(enemy)
--				end
--			end
-------------------------------------------------
-- Q + E + R + Ignite Kill Steal ----------------
-------------------------------------------------
--			if CfgYayoBuddy.KillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
--				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
--					SummonerIgnite(enemy)
--					Caitlyn_E(enemy)
--					Caitlyn_R(enemy)
--				end
--			end
		end
	end
end

-------------------------------------------------
-- Caitlyn Spell Functions ----------------------
-------------------------------------------------
function Corki_Q(QTarget)
	local Qrange, Qwidth, Qspeed, Qdelay = CfgYayoBuddy._SpellRanges.qRNG, 250, 850, 0.5
	if QTarget ~= nil then
		if GetDistance(myHero, QTarget) <= CfgYayoBuddy._SpellRanges.qRNG and myHero.mana >= (50 + (10 * myHero.SpellLevelQ)) then
			local CastPosition, HitChance, Position = YP:GetCircularCastPosition(QTarget, Qdelay, Qwidth, Qrange, Qspeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('Q', x, y, z)
			end
		end
	end
end

function Corki_E(ETarget)
	local Erange, Ewidth, Espeed, Edelay = CfgYayoBuddy._SpellRanges.eRNG, 100, 902, 0.5
	if ETarget ~= nil then
		if GetDistance(myHero, ETarget) <= 1000 and myHero.mana >= 50 then
			local CastPosition, HitChance, Position = YP:GetConeAOECastPosition(ETarget, Edelay, 35, Erange, Espeed, myHero, false)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('E', x, y, z)
			end
		end
	end
end

function Corki_R(RTarget)
	local Rrange, Rwidth, Rspeed, Rdelay = CfgYayoBuddy._SpellRanges.rRNG, 80, 828, 0.5
	if RTarget ~= nil then
		if GetDistance(myHero, RTarget) <= CfgYayoBuddy._SpellRanges.rRNG and myHero.mana >= 20 then
			local CastPosition, HitChance, Position = YP:GetLineCastPosition(RTarget, Rdelay, Rwidth, Rrange, Rspeed, myHero, true)
			if HitChance >= 2 then
				local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
				CastSpellXYZ('R', x, y, z)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------
-- Menu Items -------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
CfgYayoBuddy, menu = uiconfig.add_menu("CCONN's Yayo Buddy", 200)
-------------------------------------------------
-- Ryze Sub Menus -------------------------------
-------------------------------------------------
if myHero.name == "Ryze" then
	local submenu = menu.submenu('_AutoCarry')
	submenu.checkbutton('useAA', 'Use Auto Attacks', true)
	submenu.checkbutton('useQ', 'Q: Overload', true)
	submenu.checkbutton('useW', 'W: Rune Prison', true)
	submenu.checkbutton('useE', 'E: Spell Flux', true)
	submenu.keytoggle('useR', 'R: Desperate Power', Keys.Z, false)
	local submenu = menu.submenu('_LastHit')
	submenu.checkbutton('useQ', 'Q: Overload', true)
	submenu.checkbutton('useW', 'W: Rune Prison', true)
	submenu.checkbutton('useE', 'E: Spell Flux', true)
	submenu.checkbutton('useR', 'R: Desperate Power', false)
	local submenu = menu.submenu('_MixedMode')
	submenu.checkbutton('useQ', 'Q: Overload', true)
	submenu.checkbutton('useW', 'W: Rune Prison', true)
	submenu.checkbutton('useE', 'E: Spell Flux', true)
	submenu.checkbutton('useR', 'R: Desperate Power', false)
	local submenu = menu.submenu('_LaneClear')
	submenu.checkbutton('useQ', 'Q: Overload', true)
	submenu.checkbutton('useW', 'W: Rune Prison', true)
	submenu.checkbutton('useE', 'E: Spell Flux', true)
	submenu.checkbutton('useR', 'R: Desperate Power', false)
	local submenu = menu.submenu('_SpellRanges')
	submenu.slider('qRNG', 'Q: Overload', 0, 625, 625, nil, true)
	submenu.slider('wRNG', 'W: Rune Prison', 0, 600, 600, nil, true)
	submenu.slider('eRNG', 'E: Spell Flux', 0, 600, 600, nil, true)
	submenu.slider('rRNG', 'R: Desperate Power', 0, 600, 600, nil, true)
end
-------------------------------------------------
-- Ezreal Sub Menus -----------------------------
-------------------------------------------------
if myHero.name == "Ezreal" then
	local submenu = menu.submenu('_AutoCarry')
	submenu.checkbutton('useQ', 'Q: Mystic Shot', true)
	submenu.checkbutton('useW', 'W: Essence Flux', true)
	submenu.checkbutton('useE', 'E: Arcane Shift', false)
	submenu.keytoggle('useR', 'R: Trueshot Barrage', Keys.Z, false)
	local submenu = menu.submenu('_LastHit')
	submenu.checkbutton('useQ', 'Q: Mystic Shot', true)
	submenu.checkbutton('useW', 'W: Essence Flux', false)
	submenu.checkbutton('useE', 'E: Arcane Shift', false)
	submenu.checkbutton('useR', 'R: Trueshot Barrage', false)
	local submenu = menu.submenu('_MixedMode')
	submenu.checkbutton('useQ', 'Q: Mystic Shot', true)
	submenu.checkbutton('useW', 'W: Essence Flux', false)
	submenu.checkbutton('useE', 'E: Arcane Shift', false)
	submenu.checkbutton('useR', 'R: Trueshot Barrage', false)
	local submenu = menu.submenu('_LaneClear')
	submenu.checkbutton('useQ', 'Q: Mystic Shot', true)
	submenu.checkbutton('useW', 'W: Essence Flux', false)
	submenu.checkbutton('useE', 'E: Arcane Shift', false)
	submenu.checkbutton('useR', 'R: Trueshot Barrage', false)
	local submenu = menu.submenu('_SpellRanges')
	submenu.slider('qRNG', 'Q: Mystic Shot', 0, 1150, 1150, nil, true)
	submenu.slider('wRNG', 'W: Essence Flux', 0, 1000, 1000, nil, true)
	submenu.slider('eRNG', 'E: Arcane Shift', 0, 475, 475, nil, true)
	submenu.slider('rRNG', 'R: Trueshot Barrage', 0, 3000, 2000, nil, true)
end
-------------------------------------------------
-- Caitlyn Sub Menus ----------------------------
-------------------------------------------------
if myHero.name == "Caitlyn" then
	local submenu = menu.submenu('_AutoCarry')
	submenu.checkbutton('useQ', 'Q: Piltover Peacemaker', true)
	submenu.checkbutton('useW', 'W: Yordle Snap Trap', true)
	submenu.checkbutton('useE', 'E: 90 Caliber Net', true)
	submenu.keytoggle('useR', 'R: Ace in the Hole', Keys.Z, false)
	local submenu = menu.submenu('_LastHit')
	submenu.checkbutton('useQ', 'Q: Piltover Peacemaker', true)
	submenu.checkbutton('useW', 'W: Yordle Snap Trap', true)
	submenu.checkbutton('useE', 'E: 90 Caliber Net', true)
	submenu.checkbutton('useR', 'R: Ace in the Hole', false)
	local submenu = menu.submenu('_MixedMode')
	submenu.checkbutton('useQ', 'Q: Piltover Peacemaker', true)
	submenu.checkbutton('useW', 'W: Yordle Snap Trap', true)
	submenu.checkbutton('useE', 'E: 90 Caliber Net', true)
	submenu.checkbutton('useR', 'R: Ace in the Hole', false)
	local submenu = menu.submenu('_LaneClear')
	submenu.checkbutton('useQ', 'Q: Piltover Peacemaker', true)
	submenu.checkbutton('useW', 'W: Yordle Snap Trap', true)
	submenu.checkbutton('useE', 'E: 90 Caliber Net', true)
	submenu.checkbutton('useR', 'R: Ace in the Hole', false)
	local submenu = menu.submenu('_SpellRanges')
	submenu.slider('qRNG', 'Q: Piltover Peacemaker', 0, 1300, 1000, nil, true)
	submenu.slider('qMINRNG', 'Q: Minimum Range', 0, 1300, 550, nil, true)
	submenu.slider('wRNG', 'W: Yordle Snap Trap', 0, 800, 800, nil, true)
	submenu.slider('eRNG', 'E: 90 Caliber Net', 0, 950, 950, nil, true)
	submenu.slider('rRNG', 'R: Ace in the Hole', 0, 3000, 3000, nil, true)
	local submenu = menu.submenu('UltimateOptions')
	submenu.checkbutton('SafeR', 'Use Safe Ultimate')
	submenu.slider('SafeR_Value', 'Safe Zone Range', 0, 2000, 700, nil, true)
	local submenu = menu.submenu('KillSteal')
	submenu.checkbutton('KillSteal', 'Use Killsteals', true)
	submenu.checkbutton('Q', 'Q', true)
	submenu.checkbutton('E', 'E', true)
	submenu.checkbutton('R', 'R', true)
	submenu.checkbutton('Ignite', 'Ignite', true)
	submenu.checkbutton('QE', 'Q + E', true)
	submenu.checkbutton('QR', 'Q + R', true)
	submenu.checkbutton('QIgnite', 'Q + Ignite', true)
	submenu.checkbutton('ER', 'E + R', true)
	submenu.checkbutton('EIgnite', 'E + Ignite', true)
	submenu.checkbutton('RIgnite', 'R + Ignite', true)
	submenu.checkbutton('QER', 'Q + E + R', true)
	submenu.checkbutton('QEIgnite', 'Q + E + Ignite', true)
	submenu.checkbutton('QRIgnite', 'Q + R + Ignite', true)
	submenu.checkbutton('ERIgnite', 'E + R + Ignite', true)
	submenu.checkbutton('QERIgnite', 'Q + E + R + Ignite', true)
end
-------------------------------------------------
-- Corki Sub Menus ----------------------------
-------------------------------------------------
if myHero.name == "Corki" then
	local submenu = menu.submenu('_AutoCarry')
	submenu.checkbutton('useQ', 'Q: Phosphorous Bomb', true)
	--submenu.checkbutton('useW', 'W: Valkyrie', true)
	submenu.checkbutton('useE', 'E: Gatling Gun', true)
	submenu.keytoggle('useR', 'R: Missile Barrage', Keys.Z, false)
	local submenu = menu.submenu('_LastHit')
	submenu.checkbutton('useQ', 'Q: Phosphorous Bomb', false)
	--submenu.checkbutton('useW', 'W: Valyrie', true)
	submenu.checkbutton('useE', 'E: Gatling Gun', false)
	submenu.checkbutton('useR', 'R: Missile Barrage', false)
	local submenu = menu.submenu('_MixedMode')
	submenu.checkbutton('useQ', 'Q: Phosphorous Bomb', true)
	--submenu.checkbutton('useW', 'W: Valkyrie', true)
	submenu.checkbutton('useE', 'E: Gatling Gun', false)
	submenu.checkbutton('useR', 'R: Missile Barrage', true)
	local submenu = menu.submenu('_LaneClear')
	submenu.checkbutton('useQ', 'Q: Phosphorous Bomb', true)
	--submenu.checkbutton('useW', 'W: Valkyrie', true)
	submenu.checkbutton('useE', 'E: Gatling Gun', true)
	submenu.checkbutton('useR', 'R: Missile Barrage', false)
	local submenu = menu.submenu('_SpellRanges')
	submenu.slider('qRNG', 'Q: Phosphorous Bomb', 0, 825, 825, nil, true)
	--submenu.slider('wRNG', 'W: Valkyrie', 0, 800, 800, nil, true)
	submenu.slider('eRNG', 'E: Gatling Gun', 0, 600, 600, nil, true)
	submenu.slider('rRNG', 'R: Missile Barrage', 0, 1225, 1225, nil, true)
	local submenu = menu.submenu('KillSteal')
	submenu.checkbutton('KillSteal', 'Use Killsteals', true)
	submenu.checkbutton('Q', 'Q', true)
	--submenu.checkbutton('E', 'E', true)
	submenu.checkbutton('R', 'R', true)
	submenu.checkbutton('Ignite', 'Ignite', true)
	--submenu.checkbutton('QE', 'Q + E', true)
	submenu.checkbutton('QR', 'Q + R', true)
	submenu.checkbutton('QIgnite', 'Q + Ignite', true)
	--submenu.checkbutton('ER', 'E + R', true)
	--submenu.checkbutton('EIgnite', 'E + Ignite', true)
	submenu.checkbutton('RIgnite', 'R + Ignite', true)
	--submenu.checkbutton('QER', 'Q + E + R', true)
	--submenu.checkbutton('QEIgnite', 'Q + E + Ignite', true)
	submenu.checkbutton('QRIgnite', 'Q + R + Ignite', true)
	--submenu.checkbutton('ERIgnite', 'E + R + Ignite', true)
	--submenu.checkbutton('QERIgnite', 'Q + E + R + Ignite', true)
end
-------------------------------------------------
-- Graves Sub Menus -----------------------------
-------------------------------------------------
if myHero.name == "Graves" then
	local submenu = menu.submenu('_AutoCarry')
	submenu.checkbutton('useQ', 'Q: Buckshot', true)
	submenu.checkbutton('useW', 'W: Smoke Screen', true)
	submenu.checkbutton('useE', 'E: Quickdraw', true)
	submenu.keytoggle('useR', 'R: Collateral Damage', Keys.Z, false)
	local submenu = menu.submenu('_LastHit')
	submenu.checkbutton('useQ', 'Q: Buckshot', false)
	submenu.checkbutton('useW', 'W: Smoke Screen', false)
	submenu.checkbutton('useE', 'E: Quickdraw', false)
	submenu.checkbutton('useR', 'R: Collateral Damage', false)
	local submenu = menu.submenu('_MixedMode')
	submenu.checkbutton('useQ', 'Q: Buckshot', true)
	submenu.checkbutton('useW', 'W: Smoke Screen', false)
	submenu.checkbutton('useE', 'E: Quickdraw', false)
	submenu.checkbutton('useR', 'R: Collateral Damage', false)
	local submenu = menu.submenu('_LaneClear')
	submenu.checkbutton('useQ', 'Q: Buckshot', true)
	submenu.checkbutton('useW', 'W: Smoke Screen', false)
	submenu.checkbutton('useE', 'E: Quickdraw', false)
	submenu.checkbutton('useR', 'R: Collateral Damage', false)
	local submenu = menu.submenu('_SpellRanges')
	submenu.slider('qRNG', 'Q: Buckshot', 0, 950, 950, nil, true)
	submenu.slider('wRNG', 'W: Smoke Screen', 0, 950, 950, nil, true)
	submenu.slider('eRNG', 'E: Quickdraw', 0, 950, 950, nil, true)
	submenu.slider('rRNG', 'R: Collateral Damage', 0, 1000, 1000, nil, true)
	local submenu = menu.submenu('KillSteal')
	submenu.checkbutton('KillSteal', 'Use Killsteals', true)
	submenu.checkbutton('Q', 'Q', true)
	submenu.checkbutton('R', 'R', true)
	submenu.checkbutton('Ignite', 'Ignite', true)
	submenu.checkbutton('QR', 'Q + R', true)
	submenu.checkbutton('QIgnite', 'Q + Ignite', true)
	submenu.checkbutton('RIgnite', 'R + Ignite', true)
	submenu.checkbutton('QRIgnite', 'Q + R + Ignite', true)
end
-------------------------------------------------
-- Miss Fortune Sub Menus -----------------------
-------------------------------------------------
if myHero.name == "MissFortune" then
	local submenu = menu.submenu('_AutoCarry')
	submenu.checkbutton('useQ', 'Q: Double Up', true)
	submenu.checkbutton('useW', 'W: Impure Shots', true)
	submenu.checkbutton('useE', 'E: Make It Rain', true)
	submenu.keytoggle('useR', 'R: Bullet Time', Keys.Z, false)
	local submenu = menu.submenu('_LastHit')
	submenu.checkbutton('useQ', 'Q: Double Up', true)
	submenu.checkbutton('useW', 'W: Impure Shots', false)
	submenu.checkbutton('useE', 'E: Make It Rain', false)
	submenu.checkbutton('useR', 'R: Bullet Time', false)
	local submenu = menu.submenu('_MixedMode')
	submenu.checkbutton('useQ', 'Q: Double Up', true)
	submenu.checkbutton('useW', 'W: Impure Shots', false)
	submenu.checkbutton('useE', 'E: Make It Rain', false)
	submenu.checkbutton('useR', 'R: Bullet Time', false)
	local submenu = menu.submenu('_LaneClear')
	submenu.checkbutton('useQ', 'Q: Double Up', true)
	submenu.checkbutton('useW', 'W: Impure Shots', false)
	submenu.checkbutton('useE', 'E: Make It Rain', false)
	submenu.checkbutton('useR', 'R: Bullet Time', false)
	local submenu = menu.submenu('_SpellRanges')
	submenu.slider('qRNG', 'Q: Double Up', 0, 650, 650, nil, true)
	submenu.slider('wRNG', 'W: Impure Shots', 0, 650, 650, nil, true)
	submenu.slider('eRNG', 'E: Make It Rain', 0, 800, 800, nil, true)
	submenu.slider('rRNG', 'R: Bullet Time', 0, 1400, 1400, nil, true)
	local submenu = menu.submenu('UltimateOptions')
	submenu.checkbutton('SafeR', 'Use Safe Ultimate')
	submenu.slider('SafeR_Value', 'Safe Zone Range', 0, 2000, 700, nil, true)
	local submenu = menu.submenu('KillSteal')
	submenu.checkbutton('KillSteal', 'Use Killsteals', true)
	submenu.checkbutton('Q', 'Q', true)
	submenu.checkbutton('E', 'E', true)
	submenu.checkbutton('R', 'R', true)
	submenu.checkbutton('Ignite', 'Ignite', true)
	submenu.checkbutton('QE', 'Q + E', true)
	submenu.checkbutton('QR', 'Q + R', true)
	submenu.checkbutton('QIgnite', 'Q + Ignite', true)
	submenu.checkbutton('ER', 'E + R', true)
	submenu.checkbutton('EIgnite', 'E + Ignite', true)
	submenu.checkbutton('RIgnite', 'R + Ignite', true)
	submenu.checkbutton('QER', 'Q + E + R', true)
	submenu.checkbutton('QEIgnite', 'Q + E + Ignite', true)
	submenu.checkbutton('QRIgnite', 'Q + R + Ignite', true)
	submenu.checkbutton('ERIgnite', 'E + R + Ignite', true)
	submenu.checkbutton('QERIgnite', 'Q + E + R + Ignite', true)
end
-------------------------------------------------
-- KogMaw Sub Menus ----------------------------
-------------------------------------------------
if myHero.name == "KogMaw" then
	local submenu = menu.submenu('_AutoCarry')
	submenu.checkbutton('useQ', 'Q: Caustic Spittle', true)
	submenu.checkbutton('useW', 'W: Bio-Arcane Barrage', true)
	submenu.checkbutton('useE', 'E: Void Ooze', true)
	submenu.keytoggle('useR', 'R: Living Artillery', Keys.Z, true)
	local submenu = menu.submenu('_LastHit')
	submenu.checkbutton('useQ', 'Q: Caustic Spittle', false)
	submenu.checkbutton('useW', 'W: Bio-Arcane Barrage', false)
	submenu.checkbutton('useE', 'E: Void Ooze', false)
	submenu.checkbutton('useR', 'R: Living Artillery', true)
	local submenu = menu.submenu('_MixedMode')
	submenu.checkbutton('useQ', 'Q: Caustic Spittle', false)
	submenu.checkbutton('useW', 'W: Bio-Arcane Barrage', false)
	submenu.checkbutton('useE', 'E: Void Ooze', false)
	submenu.checkbutton('useR', 'R: Living Artillery', true)
	local submenu = menu.submenu('_LaneClear')
	submenu.checkbutton('useQ', 'Q: Caustic Spittle', false)
	submenu.checkbutton('useW', 'W: Bio-Arcane Barrage', false)
	submenu.checkbutton('useE', 'E: Void Ooze', false)
	submenu.checkbutton('useR', 'R: Living Artillery', true)
	local submenu = menu.submenu('_SpellRanges')
	submenu.slider('qRNG', 'Q: Caustic Spittle', 0, 1000, 1000, nil, true)
	submenu.slider('wRNG', 'W: Bio-Arcane Barrage', 0, 1000, 1000, nil, true)
	submenu.slider('eRNG', 'E: Void Ooze', 0, 1280, 1000, nil, true)
	--submenu.slider('rRNG', 'R: Living Artillery', 0, 3000, 3000, nil, true)
	local submenu = menu.submenu('UltimateOptions')
	submenu.label('lblkog1', '>> Stack Management <<')
	submenu.checkbutton('StackCheck', 'Use Stack Check', true)
	submenu.slider('RStack1', 'Rank 1 max stacks', 1, 10, 2, nil, true)
	submenu.slider('RStack2', 'Rank 2 max stacks', 1, 10, 3, nil, true)
	submenu.slider('RStack3', 'Rank 3 max stacks', 1, 10, 4, nil, true)
	local submenu = menu.submenu('KillSteal')
	submenu.checkbutton('KillSteal', 'Use Killsteals', true)
	submenu.checkbutton('Q', 'Q', true)
	submenu.checkbutton('E', 'E', true)
	submenu.checkbutton('R', 'R', true)
	submenu.checkbutton('Ignite', 'Ignite', true)
	submenu.checkbutton('QE', 'Q + E', true)
	submenu.checkbutton('QR', 'Q + R', true)
	submenu.checkbutton('QIgnite', 'Q + Ignite', true)
	submenu.checkbutton('ER', 'E + R', true)
	submenu.checkbutton('EIgnite', 'E + Ignite', true)
	submenu.checkbutton('RIgnite', 'R + Ignite', true)
	submenu.checkbutton('QER', 'Q + E + R', true)
	submenu.checkbutton('QEIgnite', 'Q + E + Ignite', true)
	submenu.checkbutton('QRIgnite', 'Q + R + Ignite', true)
	submenu.checkbutton('ERIgnite', 'E + R + Ignite', true)
	submenu.checkbutton('QERIgnite', 'Q + E + R + Ignite', true)
end

-------------------------------------------------
-- Tristana Sub Menus ----------------------------
-------------------------------------------------
if myHero.name == "Tristana" then
	local submenu = menu.submenu('_AutoCarry')
	submenu.checkbutton('useQ', 'Q: Rapid Fire', true)
	submenu.checkbutton('useW', 'W: Rocket Jump', false)
	submenu.checkbutton('useE', 'E: Explosive Shot', true)
	submenu.keytoggle('useR', 'R: Buster Shot', Keys.Z, false)
	local submenu = menu.submenu('_LastHit')
	submenu.checkbutton('useQ', 'Q: Rapid Fire', true)
	submenu.checkbutton('useW', 'W: Rocket Jump', false)
	submenu.checkbutton('useE', 'E: Explosive Shot', true)
	submenu.checkbutton('useR', 'R: Buster Shot', false)
	local submenu = menu.submenu('_MixedMode')
	submenu.checkbutton('useQ', 'Q: Rapid Fire', true)
	submenu.checkbutton('useW', 'W: Rocket Jump', false)
	submenu.checkbutton('useE', 'E: Explosive Shot', true)
	submenu.checkbutton('useR', 'R: Buster Shot', false)
	local submenu = menu.submenu('_LaneClear')
	submenu.checkbutton('useQ', 'Q: Rapid Fire', true)
	submenu.checkbutton('useW', 'W: Rocket Jump', false)
	submenu.checkbutton('useE', 'E: Explosive Shot', true)
	submenu.checkbutton('useR', 'R: Buster Shot', false)
	local submenu = menu.submenu('_SpellRanges')
	--submenu.slider('qRNG', 'Q: Rapid Fire', 0, 703, 703, nil, true)
	submenu.slider('wRNG', 'W: Rocket Jump', 0, 900, 900, nil, true)
	--submenu.slider('eRNG', 'E: Explosive Shot', 0, 703, 703, nil, true)
	--submenu.slider('rRNG', 'R: Buster Shot', 0, 703, 703, nil, true)
	local submenu = menu.submenu('RocketJumpOptions')
	submenu.slider('TristWMode', 'Jump To:', 1, 2, 1, {"Mouse Position","Target"})
	submenu.checkbutton('SafeW', 'Use Safe Rocket Jump')
	submenu.slider('SafeW_Value', 'Safe Zone Range', 0, 2000, 700, nil, true)
	local submenu = menu.submenu('KillSteal')
	submenu.checkbutton('KillSteal', 'Use Killsteals', true)
	submenu.checkbutton('W', 'W', true)
	submenu.checkbutton('E', 'E', true)
	submenu.checkbutton('R', 'R', true)
	submenu.checkbutton('Ignite', 'Ignite', true)
	submenu.checkbutton('WE', 'W + E', true)
	submenu.checkbutton('WR', 'W + R', true)
	submenu.checkbutton('WIgnite', 'W + Ignite', true)
	submenu.checkbutton('ER', 'E + R', true)
	submenu.checkbutton('EIgnite', 'E + Ignite', true)
	submenu.checkbutton('RIgnite', 'R + Ignite', true)
	submenu.checkbutton('WER', 'W + E + R', true)
	submenu.checkbutton('WEIgnite', 'W + E + Ignite', true)
	submenu.checkbutton('WRIgnite', 'W + R + Ignite', true)
	submenu.checkbutton('ERIgnite', 'E + R + Ignite', true)
	submenu.checkbutton('WERIgnite', 'W + E + R + Ignite', true)
	menu.slider('TristMode', 'Choose AD or AP', 1, 2, 1, {"AD","AP"})
end
-------------------------------------------------
-- Vayne Sub Menus ------------------------------
-------------------------------------------------
if myHero.name == "Vayne" then
	local submenu = menu.submenu('_AutoCarry')
	submenu.checkbutton('AAQReset', 'Reset AA with Q', true)
	local submenu = menu.submenu('_LastHit')
	submenu.checkbutton('AAQReset', 'Reset AA with Q', true)
	local submenu = menu.submenu('_MixedMode')
	submenu.checkbutton('AAQReset', 'Reset AA with Q', true)
	local submenu = menu.submenu('_LaneClear')
	submenu.checkbutton('AAQReset', 'Reset AA with Q', true)
	local submenu = menu.submenu('_AutoCondemn')
	submenu.checkbutton('AutoCondemn', 'Use LB API Auto Condemn', false)
	submenu.checkbutton('AutoCondemnVMA', 'Use Vayne Mighty Assistant', true)
	submenu.checkbutton('AutoESafe', 'Auto E for Anti Gap Closer', true)
	submenu.slider('AutoESafeZone', 'Anti Gap Closer Distance', 0, 550, 150, nil, true)
end
if myHero.name == "Vayne" and CfgYayoBuddy._AutoCondemn.AutoCondemnVMA then
	require "vayne_mighty_assistant"
end
-------------------------------------------------
-- Teemo Sub Menus ----------------------------
-------------------------------------------------
if myHero.name == "Teemo" then
	local submenu = menu.submenu('_AutoCarry')
	submenu.checkbutton('useQ', 'Q: Blinding Dart', true)
	submenu.checkbutton('useW', 'W: Move Quick', true)
	submenu.keytoggle('useR', 'R: Noxious Trap', Keys.Z, true)
	local submenu = menu.submenu('_LastHit')
	submenu.checkbutton('useQ', 'Q: Blinding Dart', false)
	submenu.checkbutton('useW', 'W: Move Quick', false)
	submenu.checkbutton('useR', 'R: Noxious Trap', false)
	local submenu = menu.submenu('_MixedMode')
	submenu.checkbutton('useQ', 'Q: Blinding Dart', true)
	submenu.checkbutton('useW', 'W: Move Quick', false)
	submenu.checkbutton('useR', 'R: Noxious Trap', false)
	local submenu = menu.submenu('_LaneClear')
	submenu.checkbutton('useQ', 'Q: Blinding Dart', true)
	submenu.checkbutton('useW', 'W: Move Quick', false)
	submenu.checkbutton('useR', 'R: Noxious Trap', false)
	local submenu = menu.submenu('_SpellRanges')
	submenu.slider('qRNG', 'Q: Blinding Dart', 0, 580, 580, nil, true)
	submenu.slider('wRNG', 'W: Move Quick', 0, 800, 700, nil, true)
	local submenu = menu.submenu('KillSteal')
	submenu.checkbutton('KillSteal', 'Use Killsteals', true)
	submenu.checkbutton('Q', 'Q', true)
	submenu.checkbutton('R', 'R', true)
	submenu.checkbutton('Ignite', 'Ignite', true)
	submenu.checkbutton('QR', 'Q + R', true)
	submenu.checkbutton('QIgnite', 'Q + Ignite', true)
	submenu.checkbutton('RIgnite', 'R + Ignite', true)
	submenu.checkbutton('QRIgnite', 'Q + R + Ignite', true)
end
-------------------------------------------------
-- Auto Potions Sub Menus -----------------------
-------------------------------------------------
	local submenu = menu.submenu('AutoPotions')
	submenu.checkbutton('AutoPotions_ONOFF', 'Enable Auto Potions', true)
	submenu.checkbutton('Health_Potion_ONOFF', 'Health Potions', true)
	submenu.checkbutton('Mana_Potion_ONOFF', 'Mana Potions', true)
	submenu.checkbutton('Chrystalline_Flask_ONOFF', 'Chrystalline Flask', true)
	submenu.checkbutton('Elixir_of_Fortitude_ONOFF', 'Elixir of Fortitude', true)
	submenu.checkbutton('Biscuit_ONOFF', 'Biscuit', true)
	submenu.slider('Health_Potion_Value', 'Health Potion Value', 0, 100, 75, nil, true)
	submenu.slider('Mana_Potion_Value', 'Mana Potion Value', 0, 100, 75, nil, true)
	submenu.slider('Chrystalline_Flask_Value', 'Chrystalline Flask Value', 0, 100, 75, nil, true)
	submenu.slider('Elixir_of_Fortitude_Value', 'Elixir of Fortitude Value', 0, 100, 30, nil, true)
	submenu.slider('Biscuit_Value', 'Biscuit Value', 0, 100, 60, nil, true)
-------------------------------------------------
-- Auto Summoner Spells Sub Menu ----------------
-------------------------------------------------
	local submenu = menu.submenu('AutoSummoners')
	submenu.checkbutton('Auto_Summoner_Spells_ONOFF', 'Enable Auto Summoner Spells', true)
	--submenu.checkbutton('Auto_Ignite_COMBO_ONOFF', 'Use Ignite in Combo', true)
	--submenu.checkbutton('Auto_Exhaust_COMBO_ONOFF', 'Use Exhaust in Combo', true)
	--submenu.checkbutton('Auto_Exhaust_ONOFF', 'Exhaust', true)
	submenu.checkbutton('Auto_Barrier_ONOFF', 'Barrier', true)
	submenu.checkbutton('Auto_Heal_ONOFF', 'Heal', true)
	submenu.checkbutton('Auto_Clarity_ONOFF', 'Clarity', true)
	submenu.slider('AutoHealValue', 'Auto Heal Value', 0, 100, 15, nil, true)
	submenu.slider('AutoBarrierValue', 'Auto Barrier Value', 0, 100, 15, nil, true)
	--submenu.slider('AutoExhaustValue', 'Auto Exhaust Value', 0, 100, 20, nil, true)
	submenu.slider('AutoClarityValue', 'Auto Clarity Value', 0, 100, 40, nil, true)
	--submenu.slider('AutoIgniteComboValue', 'Ignite Combo Value', 0, 100, 40, nil, true)
	--submenu.slider('AutoExhaustComboValue', 'Exhaust Combo Value', 0, 100, 40, nil, true)
-------------------------------------------------
-------------------------------------------------
-------------------------------------------------
menu.label('lbl0', ' ')
menu.label('lbl1', 'CCONNs Yayo Buddy Version '..tostring(Version))
menu.label('lbl2', 'www.facebook.com/CCONN81')

Init()
SetTimerCallback('OnTick')