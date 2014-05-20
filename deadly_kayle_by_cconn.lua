----------[[Deadly Kayle v1.0 by CCONN]]
require 'Utils'
require 'spell_damage'

----------[[Deadly Kayle Variables]]
local target
local target2
local wTimer = os.time()
local enemyult={Off}
	for i=1, objManager:GetMaxHeroes(), 1 do
		hero = objManager:GetHero(i)
		if hero~=nil and hero.team==myHero.team then
			table.insert(enemyult,hero)
		end
	end
----------[[End of Deadly Kayle Variables]]

----------[[Smart Ward v1.1 Variables]]
local version = "1.1 (by Val)"
local AUTOPLACE_IF_MISS = 0
mousePos = {x=0,y=0,z=0}
items = {2045,2049,3154,2044,2043}
wardSpots = {
        -- ward spots
        { x = 2572,    y = 45.84,  z = 7457},     -- BLUE GOLEM
        { x = 7422,    y = 46.53,  z = 3282},     -- BLUE LIZARD
        { x = 10148,   y = 44.41,  z = 2839},     -- BLUE TRI BUSH
        { x = 6269,    y = 42.51,  z = 4445},     -- BLUE PASS BUSH
        { x = 7406,    y = 43.31,  z = 4995},     -- BLUE RIVER ENTRANCE
        { x = 4325,    y = 44.38,  z = 7241.54},  -- BLUE ROUND BUSH
        { x = 4728,    y = -51.29, z = 8336},     -- BLUE RIVER ROUND BUSH
        { x = 6598,    y = 46.15,  z = 2799},     -- BLUE SPLIT PUSH BUSH

        { x = 11500,   y = 45.75,  z = 7095},     -- PURPLE GOLEM
        { x = 6661,    y = 44.46,  z = 11197},    -- PURPLE LIZARD
        { x = 3883,    y = 39.87,  z = 11577},    -- PURPLE TRI BUSH
        { x = 7775,    y = 43.14,  z = 10046.49}, -- PURPLE PASS BUSH
        { x = 6625.47, y = 47.66,  z = 9463},     -- PURPLE RIVER ENTRANCE
        { x = 9720,    y = 45.79,  z = 7210},     -- PURPLE ROUND BUSH
        { x = 9191,    y = -73.46, z = 6004},     -- PURPLE RIVER ROUND BUSH
        { x = 7490,    y = 41,     z = 11681},    -- PURPLE SPLIT PUSH BUSH

        { x = 3527.43, y = -74.95, z = 9534.51},  -- NASHOR
        { x = 10473,   y = -73,    z = 5059},     -- DRAGON
}
----------[[End of Smart Ward v1.1 Variables]]

----------[[Red Elixer Variables]]
local wUsedAt = 0
local vUsedAt = 0
local timer = os.clock()
local bluePill = nil
----------[[End of Red Elixir Variables]]

----------[[Script Config Menu]]
DeadlyKayleConfig = scriptConfig("Deadly Kayle by CCONN81", "KayleConfig")
DeadlyKayleConfig:addParam("Combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
DeadlyKayleConfig:addParam("smartward", "Smart Ward", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
DeadlyKayleConfig:addParam("AutoR", "Auto Intervention (R)", SCRIPT_PARAM_ONOFF, true)
DeadlyKayleConfig:addParam("AutoSS", "Auto Summoner Spells", SCRIPT_PARAM_ONOFF, true)
DeadlyKayleConfig:addParam("AutoHealAmount", "Auto Heal Health %", SCRIPT_PARAM_NUMERICUPDOWN, 15, 97, 0, 100, 5)
DeadlyKayleConfig:addParam("AutoBarrierAmount", "Auto Barrier Health %", SCRIPT_PARAM_NUMERICUPDOWN, 15, 98, 0, 100, 5)
DeadlyKayleConfig:addParam("AutoExhaustAmount", "Auto Exhaust Health %", SCRIPT_PARAM_NUMERICUPDOWN, 20, 99, 0, 100, 5)
DeadlyKayleConfig:addParam("AutoClarityAmount", "Auto Clarity Mana %", SCRIPT_PARAM_NUMERICUPDOWN, 40, 100, 0, 100, 10)
DeadlyKayleConfig:addParam("Elixir", "RED ELIXIR", SCRIPT_PARAM_ONOFF, true)
DeadlyKayleConfig:addParam("Draw", "Draw Circles", SCRIPT_PARAM_ONOFF, true)
--DeadlyKayleConfig:addParam("AntiKS", "Anti Killsteal", SCRIPT_PARAM_ONOFF, false)  --Need to add this into spell functions
----------[[End of Script Config Menu]]

----------[[Core Script Function]]
function DeadlyKayle()
	target = GetWeakEnemy('PHYS', 700)
	target2 = GetWeakEnemy('PHYS', 1200)
	Smart_Ward()
	if DeadlyKayleConfig.Draw then Draw() end
	if DeadlyKayleConfig.AutoSS then AutoSS() end
	if DeadlyKayleConfig.Elixir then RedElixir () end
	if DeadlyKayleConfig.Combo then Combo() end
	if DeadlyKayleConfig.Combo then MoveToMouse() end
end
----------[[End of Core Script Function]]

----------[[Utility Functions]]
function Draw()
	CustomCircle(125,2,4,myHero)
	if myHero.SpellLevelW >= 1 and myHero.SpellTimeW > 1.0 then CustomCircle(275,2,4,myHero) end
	if myHero.SpellLevelE >= 1 and myHero.SpellTimeE > 1.0 then CustomCircle(700,2,4,myHero) end
	if myHero.SpellLevelR >= 1 and myHero.SpellTimeR > 1.0 then CustomCircle(1200,2,4,myHero) end
	if target ~= nil then CustomCircle(100,5,2,target) end
end

--[[function StunCheck()  <---Coming Soon
	for i = 1, objManager:GetMaxObjects(), 1 do
        obj = objManager:GetObject(i)
        if obj~=nil and target~=nil then
            if (obj.charName:lower():find("?????")) and GetDistance(obj, target) < 100 then
                return true
            end
        end
    end
end]]

local items = {
        LCK = {id=3190, range = 10000, reqTarget = false, slot = nil},    -- Locket of the Iron Solari
        }
               
function UseLocket()
    for _,item in pairs(items) do
        item.slot = GetInventorySlot(item.id)
        if item.slot ~= nil then
            if not item.reqTarget then
                    CastSpellTarget(item.slot,myHero)
            end
        end
    end
end
----------[[End of Utility Functions]]

----------[[Spells and Combos]]
function Combo()
	if target ~= nil then
		if DeadlyKayleConfig.AutoR then autoR() end
		if myHero.SpellTimeQ > 1.0 then Q() end
		if myHero.SpellTimeW > 1.0 then W() end
		if myHero.SpellTimeE > 1.0 then E() end
		UseAllItems(target)
		UseLocket()
		AttackTarget(target)
	end
	if target2 ~= nil then
		if myHero.SpellTimeQ < 1.0 then
			if DeadlyKayleConfig.ComboR then R() end
		end
	end
end

function Q()
	if target ~= nil then
		if myHero.SpellTimeQ > 1.0 and GetDistance(myHero, target) <= 650 then
			CastSpellTarget('Q',target)
		end
	end
end

function W()
	if target ~= nil then
		if myHero.SpellTimeW > 1.0 and GetDistance(myHero, target) <= 900 then
			CastSpellTarget('W',myHero)
		end
	end
end

function E()
	if target ~= nil then
		if myHero.SpellTimeE > 1.0 and GetDistance(myHero, target) <= 650 then
			CastSpellTarget('E', myHero)
			wTimer = os.time()
		end
	end
end

function R()
	if target2 ~= nil then
		if myHero.SpellTimeR > 1.0 and GetDistance(target2) <= 900 then
			CastSpellTarget('R', target2)
		end
	end
end

----------[[Auto Ult function --> Credits to Malbert from his Zilean script]]
function autoR()
	local enemies = {}
	local allies = {}
	local allytarget = nil
	for i = 1, objManager:GetMaxHeroes(), 1 do
		hero = objManager:GetHero(i)
		if hero ~= nil and hero.team == myHero.team and hero.dead ~= 1 and GetDistance(hero,myHero) < 900 then
			table.insert(allies,hero)
		elseif hero ~= nil and hero.team ~= myHero.team and hero.dead ~= 1 then
			table.insert(enemies,hero)
		end
	end

	for i,ally4R in ipairs(allies) do
		if ally4R ~= nil and ally4R.dead ~= 1 then
			for j,EIR in ipairs(enemies) do
				if EIR ~= nil and EIR.dead ~= 1 then
					if ally4R ~= nil and ally4R.dead ~= 1 and (allytarget == nil or allytarget.dead == 0) and ((ally4R.health < (2/10*hero.maxHealth) and GetDistance(ally4R,EIR) < 900) or (ally4R.health < (1/10*hero.maxHealth) and GetDistance(ally4R,EIR) < 900)) then
						allytarget = ally4R
					elseif ally4R ~= nil and ally4R.dead ~= 1  and allytarget ~= nil and allytarget.dead ~= 1 and ((ally4R.health < (2/10*hero.maxHealth) and GetDistance(ally4R,EIR) < 900) or (ally4R.health < (1/10*hero.maxHealth) and GetDistance(ally4R,EIR) < 900)) and allytarget.ap + allytarget.addDamage + allytarget.baseDamage < ally4R.ap + ally4R.addDamage + ally4R.baseDamage then
						allytarget = ally4R	
					end
				end
			end
		end
	end
	if index ~= 1 then
		for j,EIR in ipairs(enemies) do
			if EIR ~= nil and EIR.dead ~= 1 then
				if enemyult[index] ~= nil and enemyult[index].dead ~= 1 and ((enemyult[index].health < (2/10*enemyult[index].maxHealth) and GetDistance(enemyult[index],EIR) < 900) or (enemyult[index].health < (1/10*enemyult[index].maxHealth) and GetDistance(enemyult[index],EIR) < 900)) then
					allytarget = enemyult[index]
				end
			end
		end
	end
	
	if allytarget ~= nil and allytarget.dead ~= 1 and myHero.SpellTimeR > 1.0 then
		CastSpellTarget('R',allytarget)
	end
end
----------[[End of Spells and Combos]]

----------[[Summoner Spell Functions]]
function AutoSS()
	SummonerIgnite()
	SummonerBarrier()
	SummonerHeal()
	SummonerExhaust()
	SummonerClarity()
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
			if myHero.health < myHero.maxHealth*(DeadlyKayleConfig.AutoBarrierAmount / 100) then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerBarrier' then
			if myHero.health < myHero.maxHealth*(DeadlyKayleConfig.AutoBarrierAmount / 100) then
				CastSpellTarget('F',myHero)
			end
		end
end
function SummonerHeal()
		if myHero.SummonerD == 'SummonerHeal' then
			if myHero.health < myHero.maxHealth*(DeadlyKayleConfig.AutoHealAmount / 100) then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerHeal' then
			if myHero.health < myHero.maxHealth*(DeadlyKayleConfig.AutoHealAmount / 100) then
				CastSpellTarget('F',myHero)
			end
		end
end
function SummonerExhaust()
	if target ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*(DeadlyKayleConfig.AutoExhaustAmount / 100) then
				if myHero.health < target.health then
					CastSpellTarget('D',target)
				end
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*(DeadlyKayleConfig.AutoExhaustAmount / 100) then
				if myHero.health < target.health then
					CastSpellTarget('F',target)
				end
			end
		end
	end
end
function SummonerClarity()
		if myHero.SummonerD == 'SummonerMana' then
			if myHero.mana < myHero.maxMana*(DeadlyKayleConfig.AutoClarityAmount / 100) then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerMana' then
			if myHero.mana < myHero.maxMana*(DeadlyKayleConfig.AutoClarityAmount / 100) then
				CastSpellTarget('F',myHero)
			end
		end
end
----------[[End of Summoner Spell Functions]]

----------[[Smart Ward v1.1]]
function Smart_Ward()
    CLOCK=os.clock()
    if DeadlyKayleConfig.smartward then
        --print("\nkshowcircles")
        mousePos.x=GetCursorWorldX()
        mousePos.y=GetCursorWorldY()
        mousePos.z=GetCursorWorldZ()
        keypressed=1
        for i,wardSpot in pairs(wardSpots) do
        if GetDistance(wardSpot, mousePos) <= 250 then
                                wardColor = 0x02
                        else
                                wardColor = 0x01
                        end
            DrawCircle(wardSpot.x, wardSpot.y, wardSpot.z, 28, wardColor)
                        DrawCircle(wardSpot.x, wardSpot.y, wardSpot.z, 29, wardColor)
                        DrawCircle(wardSpot.x, wardSpot.y, wardSpot.z, 30, wardColor)
                        DrawCircle(wardSpot.x, wardSpot.y, wardSpot.z, 31, wardColor)
                        DrawCircle(wardSpot.x, wardSpot.y, wardSpot.z, 32, wardColor)
                        DrawCircle(wardSpot.x, wardSpot.y, wardSpot.z, 250, wardColor)
        end
    end
    if (DeadlyKayleConfig.smartward == false and (keypressed==1)) then
        smartwarded=0
        mousePos.x=GetCursorWorldX()
        mousePos.y=GetCursorWorldY()
        mousePos.z=GetCursorWorldZ()
        for i,wardSpot in pairs(wardSpots) do
        if GetDistance(wardSpot, mousePos) <= 250 then
			for i,item in pairs(items) do
				UseItemLocation(item, wardSpot.x, wardSpot.y, wardSpot.z)
				UseItemLocation(item, wardSpot.x, wardSpot.y, wardSpot.z)
			end
            smartwarded=1
        end
        end
        if (smartwarded==0 and AUTOPLACE_IF_MISS==1) then
			for i,item in pairs(items) do
				UseItemLocation(item, wardSpot.x, wardSpot.y, wardSpot.z)
				UseItemLocation(item, wardSpot.x, wardSpot.y, wardSpot.z)
			end
        end
        keypressed=0
    end

end
----------[[End of Smart Ward v1.1]]

----------[[Integrated RED ELIXIR]]
function RedElixir()
	if bluePill == nil then
		if myHero.health < myHero.maxHealth * 0.75 and GetClock() > wUsedAt + 15000 then
			usePotion()
			wUsedAt = GetTick()
		elseif myHero.health < myHero.maxHealth * 0.74 and GetClock() > vUsedAt + 10000 then 
			useFlask()
			vUsedAt = GetTick()
		elseif myHero.health < myHero.maxHealth * 0.60 then
			useBiscuit()
		elseif myHero.health < myHero.maxHealth * 0.30 then
			useElixir()
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
function GetTick()
	return GetClock()
end
----------[[End of Integrated Red Elixir]]

SetTimerCallback("DeadlyKayle")