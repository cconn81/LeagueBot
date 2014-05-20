----------[[Deadly Leona v1.3 by CCONN81]]
require 'Utils'
require 'spell_damage'

----------[[Deadly Leona Variables]]
local target
local target2
local lastQ = os.time()
local lastR = os.time()
----------[[End of Deadly Leona Variables]]

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
DeadlyLeonaConfig = scriptConfig("Deadly Leona by CCONN81", "LeonaConfig")
DeadlyLeonaConfig:addParam("Combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
DeadlyLeonaConfig:addParam("CastR", "Cast R", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
DeadlyLeonaConfig:addParam("ComboR", "Use R in Combo", SCRIPT_PARAM_ONOFF, true)
DeadlyLeonaConfig:addParam("smartward", "Smart Ward", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
DeadlyLeonaConfig:addParam("AutoSS", "Auto Summoner Spells", SCRIPT_PARAM_ONOFF, true)
DeadlyLeonaConfig:addParam("AutoHealAmount", "Auto Heal Health %", SCRIPT_PARAM_NUMERICUPDOWN, 15, 97, 0, 100, 5)
DeadlyLeonaConfig:addParam("AutoBarrierAmount", "Auto Barrier Health %", SCRIPT_PARAM_NUMERICUPDOWN, 15, 98, 0, 100, 5)
DeadlyLeonaConfig:addParam("AutoExhaustAmount", "Auto Exhaust Health %", SCRIPT_PARAM_NUMERICUPDOWN, 20, 99, 0, 100, 5)
DeadlyLeonaConfig:addParam("AutoClarityAmount", "Auto Clarity Mana %", SCRIPT_PARAM_NUMERICUPDOWN, 40, 100, 0, 100, 10)
DeadlyLeonaConfig:addParam("Elixir", "RED ELIXIR", SCRIPT_PARAM_ONOFF, true)
DeadlyLeonaConfig:addParam("Draw", "Draw Circles", SCRIPT_PARAM_ONOFF, true)
--DeadlyLeonaConfig:addParam("AntiKS", "Anti Killsteal", SCRIPT_PARAM_ONOFF, false)  --Need to add this into spell functions
----------[[End of Script Config Menu]]

----------[[Core Script Function]]
function DeadlyLeona()
	target = GetWeakEnemy('PHYS', 700)
	target2 = GetWeakEnemy('PHYS', 1200)
	Smart_Ward()
	if DeadlyLeonaConfig.Draw then Draw() end
	if DeadlyLeonaConfig.AutoSS then AutoSS() end
	if DeadlyLeonaConfig.Elixir then RedElixir () end
	if DeadlyLeonaConfig.Combo then Combo() end
	if DeadlyLeonaConfig.CastR then R() end
	if DeadlyLeonaConfig.Combo or DeadlyLeonaConfig.CastR then MoveToMouse() end
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
		if myHero.SpellLevelE >= 1 then E() end
		if myHero.SpellLevelW >= 1 then W() end
		if myHero.SpellLevelQ >= 1 then Q() end
		UseAllItems(target)
		UseLocket()
		AttackTarget(target)
	end
	if target2 ~= nil then
		if myHero.SpellTimeQ < 1.0 then
			if DeadlyLeonaConfig.ComboR then R() end
		end
	end
end

function Q()
	if target ~= nil then
		if os.time() >= lastR + 1.5 then
			if myHero.SpellTimeQ > 1.0 and GetDistance(target) <= 150 then
				CastSpellTarget('Q',myHero)
				AttackTarget(target)
			end
		end
	end
end

function W()
	if target ~= nil then
		if myHero.SpellTimeW > 1.0 and GetDistance(target) <= 275 then
			CastSpellTarget('W',myHero)
		end
	end
end

function E()
	if target ~= nil then
		if myHero.SpellTimeE > 1.0 and GetDistance(myHero, target) <= 700 then
			CastSpellXYZ('E', GetFireahead(target,1.8,26))
		end
	end
end

function R()
	if target2 ~= nil then
		if os.time() >= lastQ + 1.25 then
			if myHero.SpellTimeR > 1.0 and GetDistance(target2) <= 1200 then
				ultPos = GetMEC(250,1200,target2)
				if ultPOS then
					CastSpellXYZ('R', GetFireahead(ultPos.x,0,ultPos.z))
					lastR = os.time()
				else 
					CastSpellXYZ('R', GetFireahead(target2,5,0))
					lastR = os.time()
				end
			end
		end
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
			if myHero.health < myHero.maxHealth*(DeadlyLeonaConfig.AutoBarrierAmount / 100) then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerBarrier' then
			if myHero.health < myHero.maxHealth*(DeadlyLeonaConfig.AutoBarrierAmount / 100) then
				CastSpellTarget('F',myHero)
			end
		end
end
function SummonerHeal()
		if myHero.SummonerD == 'SummonerHeal' then
			if myHero.health < myHero.maxHealth*(DeadlyLeonaConfig.AutoHealAmount / 100) then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerHeal' then
			if myHero.health < myHero.maxHealth*(DeadlyLeonaConfig.AutoHealAmount / 100) then
				CastSpellTarget('F',myHero)
			end
		end
end
function SummonerExhaust()
	if target ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*(DeadlyLeonaConfig.AutoExhaustAmount / 100) then
				if myHero.health < target.health then
					CastSpellTarget('D',target)
				end
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*(DeadlyLeonaConfig.AutoExhaustAmount / 100) then
				if myHero.health < target.health then
					CastSpellTarget('F',target)
				end
			end
		end
	end
end
function SummonerClarity()
		if myHero.SummonerD == 'SummonerMana' then
			if myHero.mana < myHero.maxMana*(DeadlyLeonaConfig.AutoClarityAmount / 100) then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerMana' then
			if myHero.mana < myHero.maxMana*(DeadlyLeonaConfig.AutoClarityAmount / 100) then
				CastSpellTarget('F',myHero)
			end
		end
end
----------[[End of Summoner Spell Functions]]

----------[[Smart Ward v1.1]]
function Smart_Ward()
    CLOCK=os.clock()
    if DeadlyLeonaConfig.smartward then
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
    if (DeadlyLeonaConfig.smartward == false and (keypressed==1)) then
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

SetTimerCallback("DeadlyLeona")