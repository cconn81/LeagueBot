-- Simple yayo mini-scripts can be pasted at the end
-- * edited, not tested
require 'yprediction'
require 'spell_damage'
local yayo = require 'yayo'
local YP = YPrediction()

Simple = {}

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
	local target = yayo.GetTarget()
	if ValidTarget(target) and yayo.Config.AutoCarry then
		-- UseAllItems(target)
	end
	if Simple[myHero.name] and Simple[myHero.name].OnTick then
		Simple[myHero.name].OnTick(target)
	end	
end

function Init()
	print('MapName', GetMapName())
	print('Champ', myHero.name)
	yayo.RegisterBeforeAttackCallback(BeforeAttack)
	yayo.RegisterOnAttackCallback(OnAttack)
	yayo.RegisterAfterAttackCallback(AfterAttack)
end

Simple.Ezreal = {
	OnTick = function(target)
		local Qrange, Qwidth, Qspeed, Qdelay = 1150, 80, 2000, 0.25
		if target and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(target, Qrange) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, Qdelay, Qwidth, Qrange, Qspeed, myHero, true)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
	end,
	AfterAttack = function(target)
		local Wrange, Wwidth, Wspeed, Wdelay = 1050, 90, 1600, 0.25
		if target and yayo.Config.AutoCarry then
			if ValidTarget(target, Qrange) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, Wdelay, Wwidth, Wrange, Wspeed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('W', x, y, z)
				end
			end
		end
	end
}

Simple.Vayne = {
	OnTick = function(target)
    	if target ~= nil then
			if WillHitWall(target,440) == 1 and (GetDistance(myHero, target) <= 550) then
				CastSpellTarget("E", target)
			end
		end
	end,
	AfterAttack = function(target)
		if yayo.Config.AutoCarry or yayo.Config.LaneClear then
			CastSpellXYZ('Q', mousePos.x, mousePos.y, mousePos.z)
		end
	end
}

Simple.Caitlyn = {
	OnTick = function(target)
		local Qrange, Qwidth, Qspeed, Qdelay = 1300, 90, 2225, 0.632
		local Wrange, Wwidth, Wspeed, Wdelay = 950, 80, 1960, 0.1
		if target and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(target, Qrange) then
				local CastPosition, HitChance, Position = YP:GetLineCastPosition(target, Qdelay, Qwidth, Qrange, Qspeed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('Q', x, y, z)
				end
			end
		end
		if target and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(target, Wrange) then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, Wdelay, Wwidth, Wrange, Wspeed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('W', x, y, z)
				end
			end
		end
	end
}

Simple.Tristana = {
	OnTick = function(target)
		if target and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(target, myHero.range) then
				CastSpellTarget('Q', myHero)
			end
		end
		if target and (yayo.Config.AutoCarry or yayo.Config.Mixed or yayo.Config.LaneClear) then
			if ValidTarget(target, myHero.range) then
				CastSpellTarget('E', target)
			end
		end
		for i = 1, objManager:GetMaxHeroes()  do
    		local enemy = objManager:GetHero(i)
    		if (enemy ~= nil and enemy.team ~= myHero.team and enemy.visible == 1 and enemy.invulnerable==0 and enemy.dead == 0) then
    			local edmg = getDmg("E",enemy,myHero)
				local rdmg = getDmg("R",enemy,myHero)
        		if edmg > enemy.health and myHero.SpellTimeE > 1.0 and GetDistance(myHero,enemy) < 550+9*(myHero.selflevel - 1) then
        		   	CastSpellTarget("E",enemy)
				end
				if rdmg > enemy.health and myHero.SpellTimeR > 1.0 and GetDistance(myHero,enemy) < 550+9*(myHero.selflevel - 1) then
        		   	CastSpellTarget("R",enemy)
				end
			end
		end
	end
}

Simple.Teemo = {
	OnTick = function(target)
		local Rrange, Rwidth, Rspeed, Rdelay = 230, 60, math.huge, 0.1
		if target and (yayo.Config.AutoCarry or yayo.Config.Mixed) then
			if ValidTarget(target, Rrange) and myHero.SpellTimeR > 1.0 then
				local CastPosition, HitChance, Position = YP:GetCircularCastPosition(target, Rdelay, Rwidth, Rrange, Rspeed, myHero, false)
				if HitChance >= 2 then
					local x, y, z = CastPosition.x, CastPosition.y, CastPosition.z
					CastSpellXYZ('R', x, y, z)
				end
			end
		end
	end,
	AfterAttack = function(target)
		if target and (yayo.Config.AutoCarry or yayo.Config.Mixed) then
			if ValidTarget(target, myHero.range) then
				CastSpellTarget('Q', target)
			end
		end
	end
}



Init()
SetTimerCallback('OnTick')