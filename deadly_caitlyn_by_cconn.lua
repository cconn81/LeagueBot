--[[
 _______   _______     ___       _______   __      ____    ____            
|       \ |   ____|   /   \     |       \ |  |     \   \  /   /            
|  .--.  ||  |__     /  ^  \    |  .--.  ||  |      \   \/   /             
|  |  |  ||   __|   /  /_\  \   |  |  |  ||  |       \_    _/              
|  '--'  ||  |____ /  _____  \  |  '--'  ||  `----.    |  |                
|_______/ |_______/__/     \__\ |_______/ |_______|    |__|                
                                                                           
  ______     ___       __  .___________. __      ____    ____ .__   __.    
 /      |   /   \     |  | |           ||  |     \   \  /   / |  \ |  |    
|  ,----'  /  ^  \    |  | `---|  |----`|  |      \   \/   /  |   \|  |    
|  |      /  /_\  \   |  |     |  |     |  |       \_    _/   |  . `  |    
|  `----./  _____  \  |  |     |  |     |  `----.    |  |     |  |\   |    
 \______/__/     \__\ |__|     |__|     |_______|    |__|     |__| \__|    
                                                                           
.______   ____    ____      ______   ______   ______   .__   __. .__   __. 
|   _  \  \   \  /   /     /      | /      | /  __  \  |  \ |  | |  \ |  | 
|  |_)  |  \   \/   /     |  ,----'|  ,----'|  |  |  | |   \|  | |   \|  | 
|   _  <    \_    _/      |  |     |  |     |  |  |  | |  . `  | |  . `  | 
|  |_)  |     |  |        |  `----.|  `----.|  `--'  | |  |\   | |  |\   | 
|______/      |__|         \______| \______| \______/  |__| \__| |__| \__| 
                                                                           
                                                                         
VERSION: 1.23
UPDATED: 2/17/2014
BY: CCONN

CHANGELOG:		VERSION 1.20		initial release - complete rewrite of v1.1
				VERSION 1.21		Tweaks to auto carry settings and farming,
									updated SafeR to use CountUnit,
									corected damage calc for ultimate
				VERSION 1.22		minor code error fixes,
									changes to Q, W, E, R functions
				VERSION 1.23		Updated Lane Clear to use Jinx's Lane Clear function
									Added a minimum range to ultimate so it will not cast within auto attack range
									Added keybind to toggle all killsteals on/off
									Added keybind to orbwalk without skills
									Updated Potions to use new Biscuit
									Adjusted minion last hit circles and auto carry target circles
]]

require 'Utils'
require 'spell_damage'
require 'uiconfig'
require 'winapi'
require 'SKeys'

--VARIABLES-----------------------------------
local uiconfig = require 'uiconfig'
local target
local target2
local target3
local targetIgnite
local SORT_CUSTOM = function(a, b) return a.maxHealth and b.maxHealth and a.maxHealth < b.maxHealth end
--POTION VARIABLES----------------------------
local wUsedAt = 0
local vUsedAt = 0
local mUsedAt = 0
local timer = os.clock()
local bluePill = nil
--MASTERY VARIABLES------------------------------
local HavocDamage = 0
local ExecutionerDamage = 0
local True_Attack_Damage_Against_Minions = 0
--AUTO CARRY VARIABLES---------------------------
local targetHero
local startAttackSpeed
local projSpeed = 2.5
local lastAttack = GetTickCount()
local shotFired = false
local range = myHero.range + GetDistance(GetMinBBox(myHero))
local attackDelayOffset = 325
local isMoving = false
local startAttackSpeed = 0.628
local tlow
local thigh
--FARMING VARIABLES------------------------------
local Target, M_Target
local TEAM
if myHero.team == 100 then
	TEAM = "Blue"
else
	TEAM = "Red"
end
local Caitlyn = { projSpeed = 2.5, aaParticles = {"caitlyn_basicAttack_cas", "caitlyn_headshot_tar", "caitlyn_mis_04"}, aaSpellName = { "caitlynbasicattack" }, startAttackSpeed = "0.668" }
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
--END OF VARIABLES----------------------------


--UTILITY FUNCTIONS---------------------------
function Draw()
	if CfgCaitDraw.DrawAARange then 
		CustomCircle(range,2,4,myHero) 
	end
	if CfgCaitDraw.TargetCircle and target ~= nil then 
		CustomCircle(100,1,2,target) 
	end
	if CfgCaitDraw.DrawQRange and myHero.SpellLevelQ > 0.00 and myHero.SpellTimeQ > 1.0 then 
		CustomCircle(1300,2,4,myHero) 
	end
	if CfgCaitDraw.DrawERange and myHero.SpellLevelE > 0.00 and myHero.SpellTimeE > 1.0 then 
		CustomCircle(1000,2,4,myHero) 
	end
	if CfgCaitDraw.DrawWRange and myHero.SpellLevelW > 0.00 and myHero.SpellTimeW > 1.0 then 
		CustomCircle(800,2,4,myHero) 
	end
	if CfgCaitDraw.DrawRRange and myHero.SpellLevelR > 0.00 and myHero.SpellTimeR > 1.0 then 
		CustomCircle((1500+(500*myHero.SpellLevelR)),2,4,myHero) 
	end
	if CfgCaitDraw.DrawSafeRRange and myHero.SpellLevelR > 0.00 and myHero.SpellTimeR > 1.0 then 
		CustomCircle(CfgCaitSettings.SafeR_Value,2,4,myHero) 
	end
end

function HeadShotReady()
    for i = 1, objManager:GetMaxObjects(), 1 do
        obj = objManager:GetObject(i)
        if obj~=nil and target~=nil then
			if (obj.charName:find("headshot_rdy_indicator")) and GetDistance(obj, myHero) < 100 then
                return true
            end
        end
    end
end

function SafeR()
	if CountUnit(myHero,CfgCaitSettings.SafeR_Value) < 1 then
		return true
	else
		return false
	end
end

--[[  DEPREICATED
function SafeR()
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			if GetDistance(myHero,enemy) > CfgCaitSettings.SafeR_Value then
				return true
			end
		end
	end
end
]]

function Mastery_Damage()
	local Mast_ButcherDMG = 0
	local Mast_BruteForceDMG = 0
	local Mast_SpellswordDMG = 0
	if CfgCaitMasteries.Butcher_Mastery > 0 then
		Mast_ButcherDMG = CfgCaitMasteries.Butcher_Mastery
	end
	if CfgCaitMasteries.Brute_Force_Mastery then
		if CfgCaitMasteries.Brute_Force_Mastery == 1 then
			Mast_BruteForceDMG = 1.5
		end
		if CfgCaitMasteries.Brute_Force_Mastery == 2 then
			Mast_BruteForceDMG = 3
		end
	end
	if CfgCaitMasteries.Spellsword_Mastery then
		Mast_SpellswordDMG = myHero.ap * .05
	end
	if CfgCaitMasteries.Havoc_Mastery then
		if CfgCaitMasteries.Havoc_Mastery == 1 then
			HavocDamage = 0.0067
		end
		if CfgCaitMasteries.Havoc_Mastery == 2 then
			HavocDamage = 0.0133
		end
		if CfgCaitMasteries.Havoc_Mastery == 3 then
			HavocDamage = 0.02
		end
	end
	if CfgCaitMasteries.Executioner_Mastery then
		ExecutionerDamage = .05
	end
	True_Attack_Damage_Against_Minions = (myHero.baseDamage + myHero.addDamage + Mast_BruteForceDMG + Mast_SpellswordDMG)+((myHero.baseDamage + myHero.addDamage + Mast_BruteForceDMG + Mast_SpellswordDMG)*(HavocDamage + ExecutionerDamage))
end

function Farm()
	Minions = GetEnemyMinions(SORT_CUSTOM)
	AnimationSpeedTimer = 0.085 * (1 / myHero.attackspeed)
	
	for i, Minion in pairs(Minions) do
		if Minion ~= nil then
			local PredictedDamage = 0
			local aaTime = Ping + aaDelay + ( GetDistance2D(myHero, Minion) / Caitlyn.projSpeed )
			
			for k, DMG in pairs(IncomingDamage) do
				if DMG ~= nil then
					if (DMG.Source == nil or DMG.Source.dead == 1 or DMG.Target == nil or DMG.Target.dead == 1) or (DMG.Source.x ~= DMG.aaPos.x or DMG.Source.z ~= DMG.aaPos.z) then
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
				
			if Minion.dead == 0 and Minion.health - PredictedDamage <= True_Attack_Damage_Against_Minions and Minion.health - PredictedDamage > 0 and GetDistance(Minion, myHero) < range then
				if timeToShoot() then AttackTarget(Minion)
				CustomCircle(100, 1, 2, Minion)
				end
			end
		end
	end
	if CfgCaitSettings.MoveToMouse and os.clock() > (AnimationBeginTimer + AnimationSpeedTimer) then MoveToMouse() end
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
		for i, aaSpellName in pairs(Caitlyn.aaSpellName) do
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

function LaneClear() --
    local tlow=GetLowestHealthEnemyMinion(600) 
    local thigh=GetHighestHealthEnemyMinion(600)
	local targetHero = GetWeakEnemy("MAGIC",600)

    if target2 ~= nil  and target2.visible == 1 and target2.dead == 0 then 
        target = target2 
    end

    if tlow~= nil then --Cycles target depending on if the minion can be last hit by AA or spells
		if True_Attack_Damage_Against_Minions >= tlow.health then
			target = tlow
			CustomCircle(100,20,1,target)
		--[[elseif getDmg('Q',tlow,myHero)+(getDmg('Q',tlow,myHero)*(HavocDamage + ExecutionerDamage)) >= tlow.health then
			target = tlow
			CustomCircle(100,20,1,target)			
		elseif getDmg('E',tlow,myHero)+(getDmg('E',tlow,myHero)*(HavocDamage + ExecutionerDamage)) >= tlow.health then
			target = tlow
			CustomCircle(100,20,1,target)]]			
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
		--[[elseif CfgSettings.LC_Q_ONOFF and myHero.SpellTimeQ > 1.0 and getDmg('Q',target,myHero)+(getDmg('Q',target,myHero)*(HavocDamage + ExecutionerDamage)) >= target.health then
			Q()
		elseif CfgSettings.LC_E_ONOFF and myHero.SpellTimeE > 1.0 and getDmg('E',target,myHero)+(getDmg('E',target,myHero)*(HavocDamage + ExecutionerDamage)) >= target.health then
			E()
		else ]]end
		Action()
    else
    if CfgCaitSettings.MoveToMouse and os.clock() > (AnimationBeginTimer + AnimationSpeedTimer) then MoveToMouse() end
    end
	if CfgCaitSettings.MoveToMouse and os.clock() > (AnimationBeginTimer + AnimationSpeedTimer) then MoveToMouse() end
end
--END OF UTILITY FUNCTIONS--------------------

--SCRIPT MAIN FUNCTION------------------------
function Deadly_Caitlyn()
	target = GetWeakEnemy('PHYS', 600)
	Mastery_Damage()
	if IsChatOpen() == 0 and tostring(winapi.get_foreground_window()) == "League of Legends (TM) Client" then
		Draw()
		if CfgCaitSummoner.Auto_Summoner_Spells_ONOFF then SummonerSpells() end
		if CfgCaitPotions.CCONN_Potions_ONOFF then CCONN_Potions() end
		if CfgCaitControls.Combo then Combo() end
		if CfgCaitControls.AutoCarryOnly then AutoCarry() end
		if CfgCaitKillSteal.Killsteal then Killsteal() end
		if CfgCaitControls.AutoHarass then AutoHarass() end
		if CfgCaitControls.Cast_Ult then if CfgCaitSettings.SafeR and SafeR() then R(target) else R(target) end end
		if CfgCaitControls.LaneClear then LaneClear() end
		if CfgCaitControls.Farm then Farm() end
		if CfgCaitControls.EQCombo then EQCombo(target) end
	end	
end
--END OF SCRIPT MAIN FUNCTION-----------------

--CALL FUNCTIONS------------------------------
function AutoHarass()
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			if myHero.mana >= myHero.maxMana * (CfgCaitControls.AutoHarass_Value / 100) and GetDistance(myHero,enemy) <= CfgCaitSettings.AutoHarassRange then
				Q(enemy)
			end
		end
	end
end

function Combo()
	if target ~= nil then
		if CfgCaitSettings.Combo_Q_ONOFF then Q(target) end
		if CfgCaitSettings.Combo_W_ONOFF then W(target) end
		if CfgCaitSettings.Combo_R_ONOFF then
			if CfgCaitSettings.SafeR then
				if SafeR() then R(target) end
			else R(target) end end
		if GetDistance(myHero,target) <= range then
			CCONN_Items(target)
			if CfgCaitSettings.Combo_OrbWalk_ONOFF then AutoCarry() end
		end
		if GetDistance(target) <= 600 then
			if CfgCaitSummoner.Auto_Ignite_COMBO_ONOFF then SummonerIgniteCombo(target) end
			if CfgCaitSummoner.Auto_Exhaust_COMBO_ONOFF then SummonerExhaustCombo(target) end
		end
		if CfgCaitSettings.MoveToMouse then MoveToMouse() end
	else 
		if CfgCaitSettings.MoveToMouse then MoveToMouse() end
	end
end

--KILL STEAL FUNCTIONS---------------------------
function Killsteal() --15 KS Combinations
	for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
			local qdmg = getDmg("Q",enemy,myHero)
			local wdmg = getDmg("W",enemy,myHero)
    		local edmg = getDmg("E",enemy,myHero)
			local rdmg = getDmg("R",enemy,myHero)-47
			local ignitedmg = (myHero.selflevel*20)+50
			if CfgCaitKillSteal.Q and qdmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 1300 then --Q KS
				Q(enemy)
			end
			if CfgCaitKillSteal.E and edmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E KS
				E(enemy)
			end
			if CfgCaitSettings.SafeR and SafeR() then
				if CfgCaitKillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= (1500+(500*myHero.SpellLevelR)) then --R KS --SafeR
					R(enemy)
				end
			else
				if CfgCaitKillSteal.R and rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= (1500+(500*myHero.SpellLevelR)) then --R KS
					R(enemy)
				end
			end
			if CfgCaitKillSteal.Ignite and ignitedmg > enemy.health and GetDistance(myHero,enemy) <= 600 then --Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
				end
			end
			if CfgCaitKillSteal.QE and qdmg + edmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E KS
				Q(enemy)
				E(enemy)
			end
			if CfgCaitSettings.SafeR and SafeR() then
				if CfgCaitKillSteal.QR and qdmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1300 then --Q,R KS --SafeR
					Q(enemy)
					R(enemy)
				end
			else
				if CfgCaitKillSteal.QR and qdmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1300 then --Q,R KS
					Q(enemy)
					R(enemy)
				end
			end
			if CfgCaitKillSteal.QIgnite and qdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Q(enemy)
				end
			end
			if CfgCaitSettings.SafeR and SafeR() then
				if CfgCaitKillSteal.ER and edmg + rdmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E,R KS
					E(enemy)
					R(enemy)
				end
			else
				if CfgCaitKillSteal.ER and edmg + rdmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --E,R KS --SafeR
					E(enemy)
					R(enemy)
				end
			end
			if CfgCaitKillSteal.EIgnite and edmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					E(enemy)
				end
			end
			if CfgCaitSettings.SafeR and SafeR() then
				if CfgCaitKillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						R(enemy)
					end
				end
			else
				if CfgCaitKillSteal.RIgnite and rdmg + ignitedmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						R(enemy)
					end
				end
			end
			if CfgCaitSettings.SafeR and SafeR() then
				if CfgCaitKillSteal.QER and qdmg + edmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E,R KS --SafeR
					Q(enemy)
					E(enemy)
					R(enemy)
				end
			else
				if CfgCaitKillSteal.QER and qdmg + edmg + rdmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 1000 then --Q,E,R KS
					Q(enemy)
					E(enemy)
					R(enemy)
				end
			end
			if CfgCaitKillSteal.QEIgnite and qdmg + edmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,E,Ignite KS
				if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
					SummonerIgnite(enemy)
					Q(enemy)
					E(enemy)
				end
			end
			if CfgCaitSettings.SafeR and SafeR() then
				if CfgCaitKillSteal.QRIgnite and qdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Q(enemy)
						R(enemy)
					end
				end
			else
				if CfgCaitKillSteal.QRIgnite and qdmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Q(enemy)
						R(enemy)
					end
				end
			end
			if CfgCaitSettings.SafeR and SafeR() then
				if CfgCaitKillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						E(enemy)
						R(enemy)
					end
				end
			else
				if CfgCaitKillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						E(enemy)
						R(enemy)
					end
				end
			end
			if CfgCaitSettings.SafeR and SafeR() then
				if CfgCaitKillSteal.QERIgnite and qdmg + edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeQ > 1.0 and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --Q,E,R,Ignite KS --SafeR
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						Q(enemy)
						E(enemy)
						R(enemy)
					end
				end
			else
				if CfgCaitKillSteal.ERIgnite and edmg + rdmg + ignitedmg > enemy.health and myHero.SpellTimeE > 1.0 and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) <= 600 then --E,R,Ignite KS
					if myHero.SummonerD == 'SummonerDot' and myHero.SpellTimeD > 1.0 or myHero.SummonerF == 'SummonerDot' and myHero.SpellTimeF > 1.0 then
						SummonerIgnite(enemy)
						E(enemy)
						R(enemy)
					end
				end
			end
		end
	end
end

--SPELL FUNCTIONS---------------------------------
function Q(QTarget)
	if QTarget ~= nil then
		if GetDistance(myHero, QTarget) <= 1300 and GetDistance(myHero,QTarget) > 500 and myHero.mana >= (40 + (10 * myHero.SpellLevelQ)) then
			CastSpellXYZ('Q',GetFireahead(QTarget,2,16))
		end
	end
end

function W(WTarget)
	if WTarget ~= nil then
		if GetDistance(myHero, WTarget) <= 800 and myHero.mana >= 50 then
			CastSpellTarget('W',WTarget)
		end
	end
end

function E(ETarget)
	if ETarget ~= nil then
		if GetDistance(myHero, ETarget) <= 1000 and myHero.mana >= 75 then
			CastSpellXYZ('E',GetFireahead(ETarget,2,32))
		end
	end
end

function R(RTarget)
	if RTarget ~= nil then
		if GetDistance(myHero, RTarget) > range and GetDistance(myHero, RTarget) <= (1500+(500*myHero.SpellLevelR)) and myHero.mana >= 100 then
			CastSpellTarget('R',RTarget)
		end
	end
end

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

--SUMMONER SPELLS---------------------------------
function SummonerSpells()
	if CfgCaitSummoner.Auto_Barrier_ONOFF then SummonerBarrier() end
	if CfgCaitSummoner.Auto_Heal_ONOFF then SummonerHeal() end
	if CfgCaitSummoner.Auto_Exhaust_ONOFF then SummonerExhaust() end
	if CfgCaitSummoner.Auto_Clarity_ONOFF then SummonerClarity() end
end

function SummonerIgniteCombo(TargetIgnite)
	if TargetIgnite ~= nil then
		if myHero.SummonerD == 'SummonerDot' then
			if TargetIgnite.health <= TargetIgnite.maxHealth*(CfgCaitSummoner.AutoIgniteComboValue / 100) then
				CastSpellTarget('D',TargetIgnite)
			end
		end
		if myHero.SummonerF == 'SummonerDot' then
			if TargetIgnite.health <= TargetIgnite.maxHealth*(CfgCaitSummoner.AutoIgniteComboValue / 100) then
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
	if myHero.SummonerD == 'SummonerBarrier' then
		if myHero.health < myHero.maxHealth*(CfgCaitSummoner.AutoBarrierValue / 100) then
			CastSpellTarget('D',myHero)
		end
	end
	if myHero.SummonerF == 'SummonerBarrier' then
		if myHero.health < myHero.maxHealth*(CfgCaitSummoner.AutoBarrierValue / 100) then
			CastSpellTarget('F',myHero)
		end
	end
end

function SummonerHeal()
	if myHero.SummonerD == 'SummonerHeal' then
		if myHero.health < myHero.maxHealth*(CfgCaitSummoner.AutoHealValue / 100) then
			CastSpellTarget('D',myHero)
		end
	end
	if myHero.SummonerF == 'SummonerHeal' then
		if myHero.health < myHero.maxHealth*(CfgCaitSummoner.AutoHealValue / 100) then
			CastSpellTarget('F',myHero)
		end
	end
end

function SummonerExhaustCombo(ExhaustTarget)
	if ExhaustTarget ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if ExhaustTarget.health <= ExhaustTarget.maxHealth*(CfgCaitSummoner.AutoExhaustComboValue / 100) then
				CastSpellTarget('D',ExhaustTarget)
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if ExhaustTarget.health <= ExhaustTarget.maxHealth*(CfgCaitSummoner.AutoExhaustComboValue / 100) then
				CastSpellTarget('F',ExhaustTarget)
			end
		end
	end
end

function SummonerExhaust()
	if target ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*(CfgCaitSummoner.AutoExhaustValue / 100) then
				if myHero.health < target.health then
					CastSpellTarget('D',target)
				end
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*(CfgCaitSummoner.AutoExhaustValue / 100) then
				if myHero.health < target.health then
					CastSpellTarget('F',target)
				end
			end
		end
	end
end

function SummonerClarity()
	if myHero.SummonerD == 'SummonerMana' then
		if myHero.mana < myHero.maxMana*(CfgCaitSummoner.AutoClarityValue / 100) then
			CastSpellTarget('D',myHero)
		end
	end
	if myHero.SummonerF == 'SummonerMana' then
		if myHero.mana < myHero.maxMana*(CfgCaitSummoner.AutoClarityValue / 100) then
			CastSpellTarget('F',myHero)
		end
	end
end

--ITEMS-------------------------------------------
function CCONN_Items(ItemTarget)
	if ItemTarget ~= nil then
		if CfgCaitItems.BWC_ONOFF then BWCutlass(ItemTarget) end
		if CfgCaitItems.BOTRK_ONOFF then BOTRK(ItemTarget) end
	end
end

function BWCutlass(BWCTarget)
	if BWCTarget ~= nil then
	local range = 450
		if GetDistance(myHero,BWCTarget) <= range then
			GetInventorySlot(3144)
			UseItemOnTarget(3144,BWCTarget)
		end
	end
end

function BOTRK(BOTRKTarget)
	if BOTRKTarget ~= nil then
	local range = 450
	local lifesteal = BOTRKTarget.maxHealth * .15
		if CfgCaitItems.Smart_BOTRK then
			if GetDistance(myHero,BOTRKTarget) <= range and myHero.maxHealth - myHero.health <= lifesteal then
				GetInventorySlot(3153)
				UseItemOnTarget(3153,BOTRKTarget)
			end
		else
			GetInventorySlot(3153)
			UseItemOnTarget(3153,BOTRKTarget)
		end
	end
end	

--lib functions
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

--POTIONS-----------------------------------------
function CCONN_Potions()
	if bluePill == nil then
		if myHero.health < myHero.maxHealth * (CfgCaitPotions.Health_Potion_Value / 100) and GetClock() > wUsedAt + 15000 then
			usePotion()
			wUsedAt = GetTick()
		elseif myHero.health < myHero.maxHealth * (CfgCaitPotions.Chrystalline_Flask_Value / 100) and GetClock() > vUsedAt + 10000 then 
			useFlask()
			vUsedAt = GetTick()
		elseif myHero.health < myHero.maxHealth * (CfgCaitPotions.Biscuit_Value / 100) then
			useBiscuit()
		elseif myHero.health < myHero.maxHealth * (CfgCaitPotions.Elixir_of_Fortitude_Value / 100) then
			useElixir()
		end
		if myHero.mana < myHero.maxMana * (CfgCaitPotions.Mana_Potion_Value / 100) and GetClock() > mUsedAt + 15000 then
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
	GetInventorySlot(2010)
	UseItemOnTarget(2010,myHero)
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
--END OF CALL FUNCTIONS-----------------------

--AUTO CARRY 3.0.1-------------------------------
function OnLoad()
    if GetAAData()[myHero.name] ~= nil then
        if GetAAData()[myHero.name].projSpeed ~= nil then
            projSpeed = GetAAData()[myHero.name].projSpeed
        end
    end
    if GetAAData()[myHero.name] ~= nil then
        if GetAAData()[myHero.name].startAttackSpeed ~= nil then
            startAttackSpeed = GetAAData()[myHero.name].startAttackSpeed
        end
    end
end

function trueRange()
local trueRangeValue
        if target ~= nil and GetDistance(target) < range then
                trueRangeValue = range -(range-GetDistance(target))
        else
                trueRangeValue = range
        end
        return trueRangeValue
end

function targetReset()
        if not target and not target2 and not targetHero then
        target = nil
        target2 = nil
        targetHero = nil
        end
end

function Action()
        if timeToShoot() then
            attackEnemy(target)
            CustomCircle(100,10,1,target)
        else
            CustomCircle(100,5,2,target)
            if heroCanMove() then moveToCursor() end
        end
end

function attackEnemy(target)
        if ValidTarget(target) then
        AttackTarget(target)
        shotFired = True
        end
end

function GetNextAttackTime()
    return lastAttack + attackDelayOffset / GetAttackSpeed()
end

function GetAttackSpeed()
    return myHero.attackspeed/(1/startAttackSpeed)
end

function timeToShoot()
    if GetTickCount() > GetNextAttackTime() then
    return true
    end
    return false
end

function heroCanMove()
    if shotFired == false or timeToShoot() then
        return true
    end
    return false
end

function moveToCursor() -- Removes derping when mouse is in one position instead of myHero:MoveTo mousePos
    isMoving = true
    local moveSqr = math.sqrt((mousePos.x - myHero.x)^2+(mousePos.z - myHero.z)^2)
    local moveX = myHero.x + 300*((mousePos.x - myHero.x)/moveSqr)
    local moveZ = myHero.z + 300*((mousePos.z - myHero.z)/moveSqr)
    MoveToXYZ(moveX,0,moveZ)
end

function OnCreateObj(object)
    if GetAAData()[myHero.name] ~= nil then
        for _, v in pairs(GetAAData()[myHero.name].aaParticles) do
            if string.find(object.charName,v) then
                shotFired = false
                lastAttack = GetTickCount()
            end
        end
    end
end

function OnProcessSpell(obj,spell)
    if obj ~= nil and obj.name == myHero.name then
        if string.find(spell.name,"attack") then                       
            lastAttack = GetTickCount()
        end
    end
end

function GetAAData()
    return {  
         Caitlyn	=	{ projSpeed = 2.5, aaParticles = {"caitlyn_basicAttack_cas", "caitlyn_headshot_tar", "caitlyn_mis_04"}, aaSpellName = "caitlynbasicattack", startAttackSpeed = "0.668" },
    }
end

function getAdditionalDamage() 
    if myHero.name == "Thresh" then
        local attacku = 0.01
        local ticky
        ticky=GetTickCount()
            if GetSpellLevel("E") > 0 then
                if (ticky - lastAttack) > 10000 then
                    attacku = 1
                else
                    attacku = (ticky - lastAttack)/10001
                end
            return
                math.round((((GetSpellLevel("E")*30)+50)/100)*(myHero.addDamage+myHero.baseDamage)*attacku+(myHero.ap))
            end
    end

    if myHero.name == "Orianna" then
        if myHero.selflevel > 15 then
        return math.round( 50 + (myHero.ap * 0.15) )
        elseif myHero.selflevel > 12 then
        return math.round( 42 + (myHero.ap * 0.15) )
        elseif myHero.selflevel > 9 then
        return math.round( 34 + (myHero.ap * 0.15) )
        elseif myHero.selflevel > 6 then
        return math.round( 26 + (myHero.ap * 0.15) )
        elseif myHero.selflevel > 3 then
        return math.round( 18 + (myHero.ap * 0.15) )
        elseif myHero.selflevel > 0 then
        return math.round( 10 + (myHero.ap * 0.15) )
        end
    end
    return 0
end

function AutoCarry()
    CustomCircle(range,2,4,myHero)
    if target2 ~= nil then 
        target = target2 
    else 
        target = GetWeakEnemy("PHYS",range) 
    end
    
    if target ~= nil then
        Action()
    else
        moveToCursor()
    end
end

function Hybrid()
    CustomCircle(range,2,4,myHero)
    targetHero = GetWeakEnemy("PHYS",range)

    if targetHero ~= nil then
        target = targetHero
    Action()
    else 
        target = GetLowestHealthEnemyMinion(range) 
    end
        
    if target ~= nil then
        if ( getDmg("AD",target,myHero) + getDmg("W",target,myHero) ) >= target.health then
            Action()
        end
    else
        moveToCursor()
    end
end
--[[
function Farm()
    CustomCircle(range,2,4,myHero)
    
    if target2 ~= nil then 
        target = target2 
    end

    if GetLowestHealthEnemyMinion(range) ~= nil then 
        target = GetLowestHealthEnemyMinion(range) 
    end
    
    if target ~= nil then
        if getDmg("AD",target,myHero) >= target.health then
            Action()
        end
    else
        moveToCursor()
    end
	moveToCursor()
end

function LaneClear()
    CustomCircle(range,2,4,myHero)
    tlow=GetLowestHealthEnemyMinion(range) 
    thigh=GetHighestHealthEnemyMinion(range) 

    if target2 ~= nil then 
        target = target2 
    end

    if tlow~= nil then 
        target = tlow
		CustomCircle(100,10,1,target)
    end

    if thigh ~= nil then     
    target = thigh
	CustomCircle(110,10,5,target)
    end
	
	if target ~= nil then 
        Action()
    
    else
    moveToCursor()
    end
end
]]
OnLoad()
--END OF AUTOCARRY 3.0.1-------------------------

--SCRIPT MENU------------------------------------
CfgCaitControls, menu = uiconfig.add_menu('1. Cait Controls', 200)
menu.keydown('Combo', 'Combo', Keys.Space)
menu.keydown('AutoCarryOnly', 'Orbwalk w/ no skills', Keys.B)
menu.keydown('Farm', 'Farm', Keys.C)
menu.keydown('LaneClear', 'Lane Clear', Keys.V)
menu.keydown('Cast_Ult', 'Cast Ultimate', Keys.T)
menu.keydown('EQCombo', 'EQ Combo', Keys.A)
menu.checkbutton('AutoHarass', 'Auto Harass', true)
menu.slider('AutoHarass_Value', 'Auto Harass Value', 0, 100, 50, nil, true)
	menu.permashow('Combo')
	menu.permashow('AutoHarass')
	menu.permashow('LaneClear')
	
CfgCaitSettings, menu = uiconfig.add_menu('2. Cait Settings', 200)
menu.checkbutton('Combo_OrbWalk_ONOFF', 'Orbwalk in Combo', true)
menu.checkbutton('Combo_Q_ONOFF', 'Use Q in Combo', true)
menu.checkbutton('Combo_W_ONOFF', 'Use W in Combo', true)
menu.checkbutton('Combo_E_ONOFF', 'Use E in Combo', true)
menu.keytoggle('Combo_R_ONOFF', 'Combo R', Keys.Z, false)
menu.checkbutton('SafeR', 'Use Safe R', true)
menu.slider('SafeR_Value', 'Safe R Range', 100, 1500, 700, nil, true)
menu.slider('AutoHarassRange', 'Auto Harass Range', 100, 1300, 1000, nil, true)
menu.checkbutton('MoveToMouse', 'Move To Mouse', true)
	menu.permashow('Combo_R_ONOFF')
	menu.permashow('SafeR')

CfgCaitMasteries, menu = uiconfig.add_menu('3. Cait Masteries', 200)
menu.slider('Butcher_Mastery', 'Butcher', 0, 2, 2, nil, true)
menu.slider('Havoc_Mastery', 'Havoc', 0, 3, 3, nil, true)
menu.slider('Brute_Force_Mastery', 'Brute Force', 0, 2, 0, nil, true)
menu.checkbutton('Spellsword_Mastery', 'Spellsword', true)
menu.checkbutton('Executioner_Mastery', 'Executioner', true)

CfgCaitKillSteal, menu = uiconfig.add_menu('4. Cait KillSteals', 200)
menu.keytoggle('Killsteal', 'Use Killsteals', Keys.Y, true)
menu.checkbutton('Q', 'Q', true)
menu.checkbutton('E', 'E', true)
menu.checkbutton('R', 'R', true)
menu.checkbutton('Ignite', 'Ignite', true)
menu.checkbutton('QE', 'Q + E', true)
menu.checkbutton('QR', 'Q + R', true)
menu.checkbutton('QIgnite', 'Q + Ignite', true)
menu.checkbutton('ER', 'E + R', true)
menu.checkbutton('EIgnite', 'E + Ignite', true)
menu.checkbutton('RIgnite', 'R + Ignite', true)
menu.checkbutton('QER', 'Q + E + R', true)
menu.checkbutton('QEIgnite', 'Q + E + Ignite', true)
menu.checkbutton('QRIgnite', 'Q + R + Ignite', true)
menu.checkbutton('ERIgnite', 'E + R + Ignite', true)
menu.checkbutton('QERIgnite', 'Q + E + R + Ignite', true)

CfgCaitSummoner, menu = uiconfig.add_menu('5. Cait Summoners', 200)
menu.checkbutton('Auto_Summoner_Spells_ONOFF', 'Enable Auto Summoner Spells', true)
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

CfgCaitPotions, menu = uiconfig.add_menu('6. Cait Potions', 200)
menu.checkbutton('CCONN_Potions_ONOFF', 'Master Switch: Potions', true)
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

CfgCaitItems, menu = uiconfig.add_menu('7. Cait Items', 200)
menu.checkbutton('BWC_ONOFF', 'Bilgewater Cutlass', true)
menu.checkbutton('BOTRK_ONOFF', 'Blade of the Ruined King', true)
menu.checkbutton('Smart_BOTRK', 'Smart BOTRK', true)

CfgCaitDraw, menu = uiconfig.add_menu('8. Cait Draw', 200)
menu.checkbutton('DrawAARange', 'Auto Attack Range', true)
menu.checkbutton('DrawQRange', 'Q Range', true)
menu.checkbutton('DrawWRange', 'W Range', true)
menu.checkbutton('DrawRRange', 'R Range', true)
menu.checkbutton('DrawERange', 'E Range', true)
menu.checkbutton('DrawSafeRRange', 'Safe R Range', true)
menu.checkbutton('TargetCircle', 'Target Indicator', true)
menu.checkbutton('MinionLastHit', 'Minion Last Hit Circle', true)
--END OF SCRIPT MENU-----------------------------

--CALLBACKS--------------------------------------
SetTimerCallback('Deadly_Caitlyn')
--END OF CALLBACKS-------------------------------