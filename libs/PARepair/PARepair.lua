-- Module: PersonalAssistant.PARepair
-- Developer: Klingo

PAR = {}

function PAR.OnShopOpen()
    local activeProfile = PA_SavedVars.General.activeProfile

    -- check if addon is enabled
	if PA_SavedVars.Repair[activeProfile].enabled == true then
		-- early check if there is something to repair
		if GetRepairAllCost() > 0 then
			-- check if equipped items shall be repaired
			if PA_SavedVars.Repair[activeProfile].equipped then
				PAR.RepairItems(BAG_WORN, PA_SavedVars.Repair[activeProfile].equippedThreshold)
			end
			-- check if backpack items shall be repaired
			if PA_SavedVars.Repair[activeProfile].backpack then
				PAR.RepairItems(BAG_BACKPACK, PA_SavedVars.Repair[activeProfile].backpackThreshold)
			end
		else
			if (not PA_SavedVars.Repair[activeProfile].hideNoRepairMsg) then
				PAR.println("PAR_NoRepair")
			end
		end
	end
end

-- repair all items that are below the given threshold for the bag
function PAR.RepairItems(bagId, threshold)
    local activeProfile = PA_SavedVars.General.activeProfile

	local bagSlots = GetBagSize(bagId)
	local repairCost = 0
	local missingGold = 0
	local repairedItems = 0
	local notRepairedItems = 0
	local notRepairedItemsCost = 0
	local currentMoney = GetCurrentMoney()
	
	-- loop through all items of the corresponding bagId
	for slotIndex = 0, bagSlots - 1 do
		-- check first if the item has durability (and therefore is repairable)
		if DoesItemHaveDurability(bagId, slotIndex) then
			-- then compare it with the threshold
			if GetItemCondition(bagId, slotIndex) <= threshold then
				local stackSize = GetSlotStackSize(bagId, slotIndex)
				if stackSize > 0 then
					-- get the repair cost for that item and repair if possible
					local itemRepairCost = GetItemRepairCost(bagId, slotIndex)
					if itemRepairCost > 0 then
						if (itemRepairCost > GetCurrentMoney()) then
							-- even though not enough money available, continue as maybe a cheaper item still can be repaired
							notRepairedItems = notRepairedItems + stackSize
							notRepairedItemsCost = notRepairedItemsCost + itemRepairCost
						else
							-- sum up the total repair costs
							repairCost = repairCost + itemRepairCost;
							repairedItems = repairedItems + stackSize
							RepairItem(bagId, slotIndex)
							-- it has to be manually calculated, as in the end the "GetCurrentMoney()" 
							-- does not yet reflect the repairs that were just done
							currentMoney = currentMoney - itemRepairCost
						end
					end
				end
			end
		end
	end

	local bagName = PA.getBagNameAdjective(bagId)

	-- check if the msg-output shall be skipped
	if PA_SavedVars.Repair[activeProfile].hideAllMsg then return end
	
	if (notRepairedItemsCost > 0) then
		missingGold = notRepairedItemsCost - currentMoney
	end
	
	if repairedItems > 0 then
		if notRepairedItems > 0 then
			PAR.println("PAR_PartialRepair", repairedItems, (repairedItems + notRepairedItems), bagName, repairCost, missingGold)
		else
			PAR.println("PAR_FullRepair", bagName, repairCost)
		end
	else
		if notRepairedItems > 0 then
			PAR.println("PAR_NoGoldToRepair", notRepairedItems, bagName, missingGold)
		else
			if (not PA_SavedVars.Repair[activeProfile].hideNoRepairMsg) then
				PAR.println("PAR_NoRepair")
			end
		end
	end
end

function PAR.println(key, ...)
	if (not PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].hideAllMsg) then
		local args = {...}
		PA.println(key, unpack(args))
	end
end