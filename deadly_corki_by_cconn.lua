--[[
Deadly Corki by CCONN81
Version 1.2 updated 7/20/2013--]]

require "Utils"
require "spell_damage"
 
p = printtext
 
local target
local target2
local target3
local targetHero
local targetignite
local startAttackSpeed
local projSpeed = 1
local lastAttack = GetTickCount()
local shotFired = false
local range = myHero.range + GetDistance(GetMinBBox(myHero))
local attackDelayOffset = 275
local isMoving = false
local startAttackSpeed = 0.658
local timer = nil
--local hextechShrapnelDmg = getDmg("AD",target,myHero)*.10
 
function OnTick()
targetReset()
KillSteal()
SummonerIgnite()
SummonerHeal()
SummonerBarrier()
        if target and target.dead == 1 then target = nil end
 
        if CorkiConfig.AutoCarry and IsChatOpen() == 0 then
        CustomCircle(range,2,4,myHero)
		CustomCircle(1225,2,4,myHero)
            if target2 ~= nil then target = target2 else target = GetWeakEnemy("PHYS",range) end
                if target ~= nil then
                UseAllItems(target)
                Action() 
                if CorkiConfig.AutoQ then Q() end
				if CorkiConfig.AutoE then E() end
				if CorkiConfig.AutoR then R() end
                else
				moveToCursor()
                end
        end    
		
		if CorkiConfig.Artillery and IsChatOpen() == 0 then
		CustomCircle(((950+(400*GetSpellLevel("R")))-100),2,4,myHero)
			harassR()
			moveToCursor()
		end
       
        if CorkiConfig.Hybrid and IsChatOpen() == 0 then
                        CustomCircle(range,2,4,myHero)
						CustomCircle(1225,2,4,myHero)
						DrawTextObject("PUSH LANE", myHero, Color.Yellow)
						if CorkiConfig.AutoR then R() end
                        targetHero = GetWeakEnemy("PHYS",600)
            if targetHero ~= nil then
                                target = targetHero
                Action()
				if CorkiConfig.AutoQ then Q() end
				if CorkiConfig.AutoE then E() end
            else target = GetLowestHealthEnemyMinion(range) end
            if target ~= nil then
                Action()
                        else
								moveToCursor()
                        end
                end
                       
       
       if CorkiConfig.Farm and IsChatOpen() == 0 then
                CustomCircle(range,2,4,myHero)
				CustomCircle(1225,2,4,myHero)
				DrawTextObject("FARM", myHero, Color.Yellow)
				if CorkiConfig.AutoR then R() end
                targetHero = GetWeakEnemy("PHYS",600)
            if targetHero ~= nil then
                target = targetHero
                Action()
				if CorkiConfig.AutoQ then Q() end
				if CorkiConfig.AutoE then E() end
            else target = GetLowestHealthEnemyMinion(range) end
            if target ~= nil then
                if getDmg("AD",target,myHero) + getDmg("AD",target,myHero)*.10 >= target.health then
                    Action()
                end
					else
						moveToCursor()
                    end
            end
               
        if CorkiConfig.AutoCarry or CorkiConfig.Hybrid or CorkiConfig.Farm then
		moveToCursor()
        end
       
        if CorkiConfig.Draw then
        if myHero.dead ~= 1 then
        CustomCircle(trueRange(),2,5,myHero)
        end
        end    
end
 
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
        p("\nTrue Range: "..math.ceil(range).."\nTraditional Range: "..myHero.range)
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

function Q()
	if target ~= nil and GetDistance(myHero, target) < 925 then
		CastSpellXYZ('Q',GetFireahead(target,2,20))
	end
end

--[[function castW()
	if target ~= nil and GetDistance(myHero, target) < 900 then
		CastSpellXYZ('W',GetFireahead(target,2,15))
	end
end--]]

function E()
	if target ~= nil and GetDistance(myHero, target) < 600 then
		CastSpellXYZ("E",GetCursorWorldX(), GetCursorWorldY(), GetCursorWorldZ())
	end
end

function R()
	target3 = GetWeakEnemy('PHYS',1225)
	if target3 ~= nil and CreepBlock(myHero.x,myHero.y,myHero.z,GetFireahead(target3,2,19)) == 0 then
		if GetDistance(myHero, target) <= 1225 then
				CastSpellXYZ("R",GetFireahead(target3,2,19))
		end
	end
end

--[[function harassR()
	target3 = GetWeakEnemy('PHYS',((950+(400*GetSpellLevel("R")))-100))
	if target3 ~= nil then
		if CanCastSpell("R") and GetDistance(myHero, target) <= ((950+(400*GetSpellLevel("R")))-100) then
			if os.time() > lastR + 6 then
				CastSpellXYZ("R",GetFireahead(target3,8,99)) 
				lastR = os.time()
			end
		end
	end
end--]]
 
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
                        if string.find(object.charName,v)  
                                then
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
       Corki        = { projSpeed = 2.0, aaParticles = {"corki_basicAttack_mis", "Corki_crit_mis"}, aaSpellName = "CorkiBasicAttack", startAttackSpeed = "0.658" },
    }
end

function KillSteal()
    for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable==0) then
    		local qdmg = getDmg("Q",enemy,myHero)*CanUseSpell("Q")
			local wdmg = getDmg("W",enemy,myHero)*CanUseSpell("W")
    		local edmg = getDmg("E",enemy,myHero)*CanUseSpell("E")
    		local rdmg = getDmg("R",enemy,myHero)*CanUseSpell("R")
    		local aadmg = getDmg("AD",enemy,myHero)
				if qdmg > enemy.health and GetDistance(enemy) < 600 then
        		    CastSpellXYZ('Q',GetFireahead(enemy,2,20))
				end
				if edmg > enemy.health and GetDistance(enemy) < 600 then
        		    CastSpellXYZ("E",GetCursorWorldX(), GetCursorWorldY(), GetCursorWorldZ())
				end
				if rdmg > enemy.health and GetDistance(enemy) < 1225 and CreepBlock(myHero.x,myHero.y,myHero.z,GetFireahead(enemy,2,19)) == 0 then
					CastSpellXYZ("R",GetFireahead(enemy,2,19))
				end
				if aadmg + getDmg("AD",enemy,myHero)*.10 > enemy.health and GetDistance(enemy) < 550 then
					AttackTarget(enemy)
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
			if myHero.health < myHero.maxHealth*.25 then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerBarrier' then
			if myHero.health < myHero.maxHealth*.25 then
				CastSpellTarget('F',myHero)
			end
		end
end

function SummonerHeal()
		if myHero.SummonerD == 'SummonerHeal' then
			if myHero.health < myHero.maxHealth*.25 then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerHeal' then
			if myHero.health < myHero.maxHealth*.25 then
				CastSpellTarget('F',myHero)
			end
		end
end
 
OnLoad()
if GetAAData()[myHero.name] ~= nil then p("\n\nAuto Carry Loaded: "..myHero.name.."\n") end
  
CorkiConfig = scriptConfig("Deadly Corki", "Corki")
CorkiConfig:addParam("AutoCarry", "OrbWalk", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
CorkiConfig:addParam("AutoQ", "AutoQ", SCRIPT_PARAM_ONOFF, true)
CorkiConfig:addParam("AutoE", "AutoE", SCRIPT_PARAM_ONOFF, true)
CorkiConfig:addParam("AutoR", "AutoR", SCRIPT_PARAM_ONOFF, true)
CorkiConfig:addParam("Hybrid", "Hybrid", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
CorkiConfig:addParam("Farm", "Farm", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
CorkiConfig:addParam("Kite", "Kite", SCRIPT_PARAM_ONOFF, true,string.byte("O"))
CorkiConfig:addParam("Draw", "Draw Circles", SCRIPT_PARAM_ONOFF, true,string.byte("P"))

SetTimerCallback("OnTick")