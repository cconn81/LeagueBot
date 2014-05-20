--[[Deadly Miss Fortune PRO V1.6 by CCONN81]]
require "Utils"
require "spell_damage"

----------[[MF Pro Variables]]
local target
local target3
local targetE
local targetignite
local range = myHero.range + GetDistance(GetMinBBox(myHero))
----------[End of MF Pro Variables]]
--[[Red Elixer Variables]]
local wUsedAt = 0
local vUsedAt = 0
local timer = os.clock()
local bluePill = nil
----------
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
MissFortuneProConfig = scriptConfig("Deadly MissFortune Pro", "MissFortunePro")
MissFortuneProConfig:addParam("AutoQ", "Auto Q", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("AutoW", "Auto W", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("AutoE", "Auto E", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("SmartEHarass", "Smart E Harass", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("RToggle", "R Killsteals", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("AutoKS", "Auto Kill Steal", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("AutoSS", "Auto Summoner Spells", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("UseULT", "Cast R", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("A"))
MissFortuneProConfig:addParam("UnbreakableR", "Do not break R", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("Draw", "Draw Circles", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("Elixir", "RED ELIXIR", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("EnableAutoCarry", "Enable AutoCarry", SCRIPT_PARAM_ONOFF, true)
MissFortuneProConfig:addParam("AutoCarry", "OrbWalk", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
MissFortuneProConfig:addParam("Hybrid", "Push Lane", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
MissFortuneProConfig:addParam("Farm", "Farm", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C")) 
MissFortuneProConfig:addParam("MasterSwitch", "Master Switch", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("S"))
----------[[End of Script Config Menu]]

----------[[Core Script Function]]
function DeadlyMFPRO()
	if MissFortuneProConfig.MasterSwitch then
		targetReset()
		target = GetWeakEnemy('PHYS', range)
		targetE = GetWeakEnemy('PHYS', 800)
		if MissFortuneProConfig.Draw then Draw() end
		if MissFortuneProConfig.Elixir then RedElixir() end
		if MissFortuneProConfig.AutoSS then SummonerSpells() end
		if MissFortuneProConfig.AutoKS then KillSteal() end
		if target ~= nil then
			if GetDistance(target) <= range then
				if MissFortuneProConfig.AutoW then W() end
				if MissFortuneProConfig.AutoQ then Q() end
				if MissFortuneProConfig.AutoE then E() end
			end
		end
		if targetE ~= nil then	
			if MissFortuneProConfig.SmartEHarass then
				if myHero.mana >= myHero.maxMana*.80 then
					SmartEHarass()
				end
			end
		end
	end
	if MissFortuneProConfig.UseULT then R() end
	if MissFortuneProConfig.EnableAutoCarry then
			if MissFortuneProConfig.AutoCarry and IsChatOpen() == 0 then
				AutoCarry()
			end
			if MissFortuneProConfig.Hybrid and IsChatOpen() == 0 then
				Hybrid()
				LaneClear()
			end            
			if MissFortuneProConfig.Farm and IsChatOpen() == 0 then
				Hybrid()
			end
		end
	if MissFortuneProConfig.AutoCarry or MissFortuneProConfig.Hybrid or MissFortuneProConfig.Farm then 
			moveToCursor()
		end
end
----------[[End of Core Script Function]]

----------[[Utility Functions]]
function Draw()
	CustomCircle(range,2,4,myHero)
	CustomCircle(1400,2,4,myHero)
	if target ~= nil then 
		CustomCircle(100,20,2,target)
	end
end
----------[[End of Utility Functions]]

----------[[Spell Functions]]
function Q()
	if target ~= nil then
	local QManaCost = 70 + GetSpellLevel("Q")*5
		if myHero.mana >= QManaCost then
			if myHero.SpellTimeQ > 1.0 then
				QRDY = 1
			else QRDY = 0 end
			if QRDY == 1 and GetDistance(myHero, target) <= 650 then
				CastSpellTarget('Q',target)
			end
		end
	end
end

function W()
	if target ~= nil then
		if myHero.mana >= 50 then
			if myHero.SpellTimeW > 1.0 then
				WRDY = 1
			else WRDY = 0 end
			if WRDY == 1 and GetDistance(myHero, target) <= range then
				CastSpellTarget('W',myHero)
			end
		end
	end
end

function E()
	if target ~= nil then
		if myHero.mana >= 80 then
			if myHero.SpellTimeE > 1.0 then
				ERDY = 1
			else ERDY = 0 end
			if ERDY == 1 and GetDistance(myHero, target) <= 800 then
				CastSpellTarget("E",target)
			end
		end
	end
end

function R()
	target3 = GetWeakEnemy('PHYS',1400)
	if target3 ~= nil then
		if myHero.mana >= 100 then
			if myHero.SpellTimeR > 1.0 then
				RRDY = 1
			else RRDY = 0 end
			if RRDY == 1 and GetDistance(myHero, target3) <= 1400 then
				CastSpellTarget("R",target3)
				if MissFortuneProConfig.UnbreakableR then
					local timer = os.time()
					BlockOrders()
					repeat until os.time() > timer + 2
					UnblockOrders()
				end
			end	
		end
	end
end

function SmartEHarass()
	if targetE ~= nil then
		if myHero.mana >= 80 then
			if myHero.SpellTimeE > 1.0 then
				ERDY = 1
			else ERDY = 0 end
			if ERDY == 1 and GetDistance(myHero, targetE) <= 800 then
				CastSpellTarget("E",targetE)
			end
		end
	end
end
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

function SummonerExhaust()
	if target ~= nil then
		if myHero.SummonerD == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*.40 then
				if myHero.health < target.health then
					CastSpellTarget('D',target)
				end
			end
		end
		if myHero.SummonerF == 'SummonerExhaust' then
			if myHero.health < myHero.maxHealth*.40 then
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
	local QManaCost = 70 + GetSpellLevel("Q")*5

	if myHero.SpellTimeQ > 1.0 and myHero.mana >= QManaCost then
        QRDY = 1
	else QRDY = 0
	end
	if myHero.SpellTimeE > 1.0 and myHero.mana >= 80 then
        ERDY = 1
	else ERDY = 0
	end
	if myHero.SpellTimeR > 1.0 and myHero.mana >= 100 then
        RRDY = 1
	else RRDY = 0
	end
	
    for i = 1, objManager:GetMaxHeroes()  do
    	local enemy = objManager:GetHero(i)
    	if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable==0 and enemy.dead == 0) then
    		local qdmg = getDmg("Q",enemy,myHero)*QRDY
			local wdmg = getDmg("W",enemy,myHero)
    		local edmg = getDmg("E",enemy,myHero)*ERDY
    		local rdmg = getDmg("R",enemy,myHero)*RRDY
    		local aadmg = getDmg("AD",enemy,myHero)
				if qdmg > enemy.health and GetDistance(enemy) < 650 then
        		    CastSpellXYZ('Q',GetFireahead(enemy,2,20))
				end
				if edmg > enemy.health and GetDistance(enemy) < 800 then
        		    CastSpellTarget("E",enemy)
				end
				if MissFortuneProConfig.RToggle then
					if rdmg > enemy.health and GetDistance(enemy) < 1200 then
						CastSpellTarget("R",enemy)
						if MissFortuneProConfig.UnbreakableR then
							local timer = os.time()
							BlockOrders()
							repeat until os.time() > timer + 2
							UnblockOrders()
						end
					end
				end
				if edmg + qdmg > enemy.health and GetDistance(enemy) < 650 then
					if ERDY == 1 and QRDY ==1 and myHero.mana > QManaCost + 80 then
						CastSpellTarget('E',enemy)
						CastSpellTarget('Q',enemy)
					end
				end
				if MissFortuneProConfig.RToggle then
					if edmg + rdmg > enemy.health and GetDistance(enemy) < 800 then
						if ERDY == 1 and RRDY == 1 and myHero.mana > 180 then
							if GetDistance(myHero, enemy) < 650 then
								CastSpellTarget('E',enemy)
								CastSpellTarget("R",enemy)
								if MissFortuneProConfig.UnbreakableR then
									local timer = os.time()
									BlockOrders()
									repeat until os.time() > timer + 2
									UnblockOrders()
								end
							end
						end
					end
				end
				if MissFortuneProConfig.RToggle then
					if edmg + qdmg + rdmg > enemy.health and GetDistance(enemy) < 650 then
						if ERDY == 1 and QRDY == 1 and RRDY == 1 and myHero.mana > QManaCost + 180 then
							CastSpellTarget('E',enemy)
							CastSpellTarget('Q',enemy)
							CastSpellTarget("R",enemy)
							if MissFortuneProConfig.UnbreakableR then
								local timer = os.time()
								BlockOrders()
								repeat until os.time() > timer + 2
								UnblockOrders()
							end
						end
					end
				end
				if aadmg + getDmg("W",enemy,myHero) > enemy.health and GetDistance(enemy) < 550 then
					AttackTarget(enemy)
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
----------[[End of Integrated Red Elixir]]

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
         MissFortune  = { projSpeed = 2.0, aaParticles = {"missFortune_basicAttack_mis", "missFortune_crit_mis"}, aaSpellName = "missfortunebasicattack", startAttackSpeed = "0.656" },
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

function Farm()
    CustomCircle(range,2,4,myHero)
    
    if target2 ~= nil then 
        target = target2 
    end

    if GetLowestHealthEnemyMinion(range) ~= nil then 
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

OnLoad()
----------[[End of AutoCarry 3.0.1 Functions]]

SetTimerCallback("DeadlyMFPRO")