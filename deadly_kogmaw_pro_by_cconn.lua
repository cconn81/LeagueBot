--[[Deadly KogMaw PRO V1.4 by CCONN81]]
require "Utils"
require "spell_damage"

----------[[KogMaw Pro Variables]]
local target
local target3
local targetignite
local range = myHero.range + GetDistance(GetMinBBox(myHero))
local lastR = os.time()
local lastW = os.time()
local timerw = nil
local timer = nil
----------[[End of KogMaw Pro Variables]]

----------[[Red Elixer Variables]]
local wUsedAt = 0
local vUsedAt = 0
local timer = os.clock()
local bluePill = nil
----------[[End of Red Elixir Variables]]

----------[[AutoCarry 3.0.1 Variables]]
local target
local target2
local targetHero
local tlow
local thigh
local startAttackSpeed
local projSpeed = 1
local lastAttack = GetTickCount()
local shotFired = false
local attackDelayOffset = 275
local isMoving = false
local startAttackSpeed = 0.625 
----------[[End of AutoCarry 3.0.1 Variables]]

----------[[Script Config Menu]]
KogMawProConfig = scriptConfig("Deadly KogMaw Pro by CCONN81", "KogMaw")
KogMawProConfig:addParam("AutoQ", "Auto Q", SCRIPT_PARAM_ONOFF, true)
KogMawProConfig:addParam("AutoW", "Auto W", SCRIPT_PARAM_ONOFF, true)
KogMawProConfig:addParam("AutoE", "Auto E", SCRIPT_PARAM_ONOFF, true)
KogMawProConfig:addParam("AutoR", "Auto R", SCRIPT_PARAM_ONOFF, true)
--KogMawProConfig:addParam("AutoPassive", "Auto Passive", SCRIPT_PARAM_ONOFF, true)
KogMawProConfig:addParam("AutoKS", "Auto Kill Steal", SCRIPT_PARAM_ONOFF, true)
KogMawProConfig:addParam("AutoSS", "Auto Summoner Spells", SCRIPT_PARAM_ONOFF, true)
KogMawProConfig:addParam("Artillery", "Artillery", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("A"))
KogMawProConfig:addParam("ArtilleryMana", "Auto Artillery Mana%", SCRIPT_PARAM_NUMERICUPDOWN, 50, 97, 0, 100, 10)
KogMawProConfig:addParam("Draw", "Draw Circles", SCRIPT_PARAM_ONOFF, true)
KogMawProConfig:addParam("Elixir", "RED ELIXIR", SCRIPT_PARAM_ONOFF, true)
KogMawProConfig:addParam("EnableAutoCarry", "Enable AutoCarry", SCRIPT_PARAM_ONOFF, true)
KogMawProConfig:addParam("AutoCarry", "OrbWalk", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
KogMawProConfig:addParam("Hybrid", "Push Lane", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
KogMawProConfig:addParam("Farm", "Farm", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C")) 
KogMawProConfig:addParam("MasterSwitch", "Master Switch", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("S")) 
----------[[End of Script Config Menu]]

--[[Core Script Function]]
function DeadlyKogMawPRO()
	if KogMawProConfig.MasterSwitch and IsChatOpen() == 0 then
		UpdateRange()
		targetReset()
		target = GetWeakEnemy('PHYS', (610+(20*GetSpellLevel("W"))))
		if target and target.dead == 1 then target = nil end
		if KogMawProConfig.Draw and IsChatOpen() == 0 then Draw() end
		if KogMawProConfig.Elixir and IsChatOpen() == 0 then RedElixir() end
		if KogMawProConfig.AutoSS and IsChatOpen == 0 then SummonerSpells() end
		if KogMawProConfig.AutoKS  and IsChatOpen() == 0 then KillSteal() end
		--if KogMawProConfig.AutoPassive then KogPassive() end
		if KogMawProConfig.Artillery and IsChatOpen() == 0 then harassR() end
		if target ~= nil then
			if GetDistance(target) <= (610+(20*GetSpellLevel("W"))) then
				if KogMawProConfig.AutoW and IsChatOpen() == 0 then W() end end
			if GetDistance(target) <= range then
				if KogMawProConfig.AutoE and IsChatOpen() == 0 then E() end
				if KogMawProConfig.AutoQ and IsChatOpen() == 0 then Q() end
				if KogMawProConfig.AutoR and IsChatOpen() == 0 then R() end
				UseAllItems(target)
			end
		end
		if KogMawProConfig.EnableAutoCarry then
			if KogMawProConfig.AutoCarry and IsChatOpen() == 0 then
				AutoCarry()
			end
			if KogMawProConfig.Hybrid and IsChatOpen() == 0 then
				LaneClear()
			end            
			if KogMawProConfig.Farm and IsChatOpen() == 0 then
				Hybrid()
			end
		end
		if KogMawProConfig.UseULT then R() end
		if KogMawProConfig.AutoCarry or KogMawProConfig.Hybrid or KogMawProConfig.Farm then 
			moveToCursor()
		end
	end
end
----------[[End of Core Script Function]]

----------[[Utility Functions]]
function Draw()
	CustomCircle(range,2,4,myHero)
	if target ~= nil then 
		CustomCircle(100,20,2,target)
	end
	if KogMawProConfig.Artillery and IsChatOpen() == 0 then
	CustomCircle(((950+(400*GetSpellLevel("R")))-100),2,4,myHero)
	end
	if target3 ~= nil then
		if myHero.selflevel >= 6 and KogMawProConfig.Artillery then
			if GetDistance(myHero, target3) > range then
				if target3.dead == 0 then
					CustomCircle(100,10,3,target3)
					DrawTextObject("Artillery Lock", target3, Color.Blue)
				end
			end
		end
	end
	if KogMawProConfig.AutoCarry then
		DrawTextObject("ORBWALKING...", myHero, Color.Yellow)
	end
	if KogMawProConfig.Hybrid then
		DrawTextObject("PUSHING THE LANE...", myHero, Color.Yellow)
	end
	if KogMawProConfig.Farm then
		DrawTextObject("FARMING...", myHero, Color.Yellow)
	end
end

function UpdateRange()
	if timerw ~= nil then
		if os.time() < timerw + 8 then
			range = myHero.range + GetDistance(GetMinBBox(myHero)) + (110+(20*GetSpellLevel("W")))
			else
			range = myHero.range + GetDistance(GetMinBBox(myHero))
		end
	end
end
----------[[End of Utility Functions]]

----------[[Spell Functions]]
function Q()
	if myHero.SpellTimeQ > 1.0 and GetDistance(target) < 625 then
		CastSpellTarget("Q",target) 
	end
end

function W()
	if myHero.SpellTimeW > 1.0 and GetDistance(target) < (610+(20*GetSpellLevel("W"))) then
		CastSpellTarget("W",target)
		timerw = os.time()
	end
end

function E()
	if myHero.SpellTimeE > 1.0 and GetDistance(target) < 1000 then
		CastSpellXYZ("E",GetFireahead(target,2,20)) 
	end
end

function R()
	target3 = GetWeakEnemy('PHYS',((950+(400*GetSpellLevel("R")))-100))
	if target3 ~= nil then
		if myHero.SpellTimeR > 1.0 and GetDistance(myHero, target3) <= ((950+(400*GetSpellLevel("R")))-100) then
			ultPos = GetMEC(100, ((950+(400*GetSpellLevel("R")))-100), target3)
				if ultPos then
					CastSpellXYZ("R", ultPos.x, 0, ultPos.z)
					lastR = os.time()
				else
					CastSpellXYZ("R",GetFireahead(target3,8,99))
					lastR = os.time()
				end
		end
	end
end

function harassR()
	if myHero.mana >= myHero.maxMana*(KogMawProConfig.ArtilleryMana / 100) then
		target3 = GetWeakEnemy('PHYS',((950+(400*GetSpellLevel("R")))-100))
		if target3 ~= nil then
			if myHero.SpellTimeR > 1.0 and GetDistance(myHero, target3) <= ((950+(400*GetSpellLevel("R")))-100) then
				if os.time() > lastR + 6 then
					ultPos = GetMEC(100, ((950+(400*GetSpellLevel("R")))-100), target3)
					if ultPos then
						CastSpellXYZ("R", ultPos.x, 0, ultPos.z)
						lastR = os.time()
					else
						CastSpellXYZ("R",GetFireahead(target3,8,99))
						lastR = os.time()
					end
				end
			end
		end
	end
end

--[[function KogPassive()	-----> Coming soon auto passive control
	if target ~= nil then
		if myHero.dead == 1 then
			AttackTarget(target)
			local timer = os.time()
			BlockOrders()
			repeat until os.time() > timer + 4
			UnblockOrders()
		end
	end
end]]
----------[[End of Spell Functions]]

----------[[Summoner Spell Functions]]
function SummonerSpells()
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
			if myHero.health < myHero.maxHealth*.15 then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerBarrier' then
			if myHero.health < myHero.maxHealth*.15 then
				CastSpellTarget('F',myHero)
			end
		end
end

function SummonerHeal()
		if myHero.SummonerD == 'SummonerHeal' then
			if myHero.health < myHero.maxHealth*.15 then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerHeal' then
			if myHero.health < myHero.maxHealth*.15 then
				CastSpellTarget('F',myHero)
			end
		end
end

function SummonerExhaust()
	if target ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*.25 then
				if myHero.health < target.health then
					CastSpellTarget('D',target)
				end
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*.25 then
				if myHero.health < target.health then
					CastSpellTarget('F',target)
				end
			end
		end
	end
end

function SummonerClarity()
		if myHero.SummonerD == 'SummonerMana' then
			if myHero.mana < myHero.maxMana*.40 then
				CastSpellTarget('D',myHero)
			end
		end
		if myHero.SummonerF == 'SummonerMana' then
			if myHero.mana < myHero.maxMana*.40 then
				CastSpellTarget('F',myHero)
			end
		end
end
----------[[End of Summoner Spell Functions]]

----------[[Kill Steal Functions]]
function KillSteal()
    for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable == 0 and enemy.dead == 0) then
    		local qdmg = getDmg("Q",enemy,myHero)
    		local rdmg = getDmg("R",enemy,myHero)
			if qdmg > enemy.health and myHero.SpellTimeQ > 1.0 and GetDistance(enemy) < 625 then
        	    CastSpellTarget("Q",enemy)
			end
			if rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(enemy) < ((950+(400*GetSpellLevel("R")))-100) then
				CastSpellXYZ("R",GetFireahead(enemy,8,99))
			end
		end
	end
end
----------[[End of Kill Steal Functions]]

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
----------[[End of Integrated RED ELIXIR]]

----------[[AutoCarry 3.0.1 Functions]]
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
        KogMaw       = { projSpeed = 1.8, aaParticles = {"KogMawBasicAttack_mis", "KogMawBioArcaneBarrage_mis"}, aaSpellName = "kogmawbasicattack", startAttackSpeed = "0.665", },
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
        UseAllItems(target)
        Action()
    else
        moveToCursor()
    end
end

function Hybrid()		-----> Hybrid function changed to prioritze last hits over champions
    CustomCircle(range,2,4,myHero)
    targetHero = GetWeakEnemy("PHYS",range)
	tlow = GetLowestHealthEnemyMinion(range)
    
	if tlow ~= nil and tlow.health <= getDmg('AD',tlow,myHero) then
		target = tlow
		Action()
	elseif targetHero ~= nil then
        target = targetHero
		Action()
    else 
        target = GetLowestHealthEnemyMinion(range) 
    end
        
    if target ~= nil then
        if ( getDmg("AD",target,myHero) + getAdditionalDamage() ) >= target.health then
            Action()
        end
    else
        moveToCursor()
    end
end

--[[function Farm()        -----> Farm function not used by Deadly KogMaw
    CustomCircle(range,2,4,myHero)
    
    if target2 ~= nil then 
        target = target2 
    end
	
    if GetLowestHealthEnemyMinion(range) ~= nil then 
        target = GetLowestHealthEnemyMinion(range) 
    end
    
    if target ~= nil then
        if ( getDmg("AD",target,myHero) + getAdditionalDamage() ) >= target.health then
            Action()
        end
    else
        moveToCursor()
    end
end]]

function LaneClear()
    CustomCircle(range,2,4,myHero)
    local tlow=GetLowestHealthEnemyMinion(range) 
    local thigh=GetHighestHealthEnemyMinion(range)
	targetHero = GetWeakEnemy("PHYS",range)

    if target2 ~= nil  and target2.visible == 1 and target2.dead == 0 then 
        target = target2 
    end

    if tlow~= nil then 
		if getDmg('AD', tlow, myHero) >= tlow.health then
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
        Action()
    
    else
    moveToCursor()
    end
end

OnLoad()
----------[[End of AutoCarry 3.0.1 Functions]]

SetTimerCallback("DeadlyKogMawPRO")