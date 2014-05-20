--[[
Deadly Graves by CCONN81
Version 1.0 updated 7/19/2013--]]

require "Utils"
require "spell_damage"
 
p = printtext
 
local target
local target2
local target3
local target4
local targetignite
local targetHero
local startAttackSpeed
local projSpeed = 3
local lastAttack = GetTickCount()
local shotFired = false
local range = myHero.range + GetDistance(GetMinBBox(myHero))
local attackDelayOffset = 600
local isMoving = false
local startAttackSpeed = 0.625
 
function OnTick()
targetReset()
KillSteal()
ignite()
        if target and target.dead == 1 then target = nil end
 
        if GravesConfig.AutoCarry and IsChatOpen() == 0 then
        CustomCircle(range,2,4,myHero)
            if target2 ~= nil then target = target2 else target = GetWeakEnemy("PHYS",range) end
                if target ~= nil then
                UseAllItems(target)
                Action() 
                Q()
				W()
				E()
				if GravesConfig.RinCombo then
					R()
				end
                else
				moveToCursor()
                end
        end    
       
        if GravesConfig.Hybrid and IsChatOpen() == 0 then
			CustomCircle(range,2,4,myHero)
			DrawTextObject("PUSH LANE", myHero, Color.Yellow)
			harassQ()
			targetHero = GetWeakEnemy("PHYS",range)
            if targetHero ~= nil then
				target = targetHero
				Action()
            else target = GetLowestHealthEnemyMinion(range) end
            if target ~= nil then
                Action()
                else
				moveToCursor()
            end
        end
                       
       
		if GravesConfig.Farm and IsChatOpen() == 0 then
			CustomCircle(range,2,4,myHero)
			DrawTextObject("FARM", myHero, Color.Yellow)
			harassQ()
			targetHero = GetWeakEnemy("PHYS",range)
            if targetHero ~= nil then
				target = targetHero
				Action()
            else target = GetLowestHealthEnemyMinion(range) 
			end
            if target ~= nil then
				if getDmg("AD",target,myHero) >= target.health then
					Action()
				end
			else
			moveToCursor()
			end
		end
               
        if GravesConfig.AutoCarry or GravesConfig.Hybrid or GravesConfig.Farm then
		moveToCursor()
        end
       
        if GravesConfig.Draw then
        if myHero.dead ~= 1 then
        CustomCircle(trueRange(),2,5,myHero)
        end
        end    
end

--[[Farming functions - COMING SOON--]]

--[[Spells and Combos--]]

function Q()
	if CanCastSpell("Q") and GetDistance(target) < 950 then
		CastSpellXYZ("Q",GetFireahead(target,2,20)) 
	end
end

function W()
	if CanCastSpell("W") and GetDistance(target) < 950 then
		CastSpellXYZ("W",GetFireahead(target,2,20)) 
	end
end

function E()
	if CanCastSpell("E") then
		CastSpellXYZ("E",mousePos.x,0,mousePos.z) 
	end
end

function R()
	target3 = GetWeakEnemy('PHYS',1000)
	if target3 ~= nil then
		if CanCastSpell("R") and GetDistance(myHero, target) <= 1000 then
				CastSpellXYZ("R",GetFireahead(target3,2,20))
		end
	end
end

function harassQ()
	target3 = GetWeakEnemy('PHYS',950)
	if target3 ~= nil then
		if CanCastSpell("Q") and GetDistance(myHero, target) <= 950 then
				CastSpellXYZ("Q",GetFireahead(target3,2,20)) 
		end
	end
end

--[[KillSteals--]]
function KillSteal()
    for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable==0 and enemy.dead == 0) then
    		local qdmg = getDmg("Q",enemy,myHero)*CanUseSpell("Q")
			local wdmg = getDmg("W",enemy,myHero)*CanUseSpell("W")
    		local edmg = getDmg("E",enemy,myHero)*CanUseSpell("E")
    		local rdmg = getDmg("R",enemy,myHero)*CanUseSpell("R")
    		local aadmg = getDmg("AD",enemy,myHero)
				if qdmg > enemy.health and CanCastSpell("Q") and GetDistance(enemy) < 950 then
        		    CastSpellXYZ("Q",GetFireahead(enemy,2,20))
				end
				if rdmg > enemy.health and CanCastSpell("R") and GetDistance(enemy) < 1000 then
					CastSpellXYZ("R",GetFireahead(enemy,2,20))
				end
		end
	end
end

--[[AutIgnite--]]
function ignite()
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

--[[Autocarry --]]
 
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
       Graves       = { projSpeed = 3.0, aaParticles = {"Graves_BasicAttack_mis",}, aaSpellName = "gravesbasicattack", startAttackSpeed = "0.625" },
    }
end
 
OnLoad()
if GetAAData()[myHero.name] ~= nil then p("\n\nAuto Carry Loaded: "..myHero.name.."\n") end
  
GravesConfig = scriptConfig("Deadly Graves", "Graves")
GravesConfig:addParam("AutoCarry", "OrbWalk", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
GravesConfig:addParam("RinCombo", "Use R in Combo", SCRIPT_PARAM_ONOFF, false)
GravesConfig:addParam("Hybrid", "Hybrid", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
GravesConfig:addParam("Farm", "Farm", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
GravesConfig:addParam("Kite", "Kite", SCRIPT_PARAM_ONOFF, true,string.byte("O"))
GravesConfig:addParam("Draw", "Draw Circles", SCRIPT_PARAM_ONOFF, true,string.byte("P"))

SetTimerCallback("OnTick")