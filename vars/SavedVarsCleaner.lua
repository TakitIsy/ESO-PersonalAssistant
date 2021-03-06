SVC = {}

-- in case it is required since the last version, automatically update/fix changes in the saved variables
function SVC.updateSavedVars()

	-- replaced all dots with empty
    local savedVarsVersion = string.gsub(PA_SavedVars.General.savedVarsVersion, "%.", "")
	local intSavedVarsVersion = tonumber(savedVarsVersion)

	if (PA_SavedVars.General.savedVarsVersion == "") then
		-- savedVarsVersion was not yet introduced, therefore we are pre 1.5.1
		
		-- hardcoded populate profile [1] with the old pre-profile configs
		if (PA_SavedVars.General) then
			if (PA_SavedVars.General.welcome ~= nil) then PA_SavedVars.General[1].welcome = PA_SavedVars.General.welcome end
			PA_SavedVars.General.welcome = nil
		end
		
		if (PA_SavedVars.Repair) then
			if (PA_SavedVars.Repair.enabled  ~= nil) then PA_SavedVars.Repair[1].enabled = PA_SavedVars.Repair.enabled  end
			PA_SavedVars.Repair.enabled  = nil
			if (PA_SavedVars.Repair.equipped ~= nil) then PA_SavedVars.Repair[1].equipped = PA_SavedVars.Repair.equipped end
			PA_SavedVars.Repair.equipped = nil
			if (PA_SavedVars.Repair.equippedThreshold ~= nil) then PA_SavedVars.Repair[1].equippedThreshold = PA_SavedVars.Repair.equippedThreshold end
			PA_SavedVars.Repair.equippedThreshold = nil
			if (PA_SavedVars.Repair.backpack ~= nil) then PA_SavedVars.Repair[1].backpack = PA_SavedVars.Repair.backpack end
			PA_SavedVars.Repair.backpack = nil
			if (PA_SavedVars.Repair.backpackThreshold ~= nil) then PA_SavedVars.Repair[1].backpackThreshold = PA_SavedVars.Repair.backpackThreshold end
			PA_SavedVars.Repair.backpackThreshold = nil
			if (PA_SavedVars.Repair.hideNoRepairMsg ~= nil) then PA_SavedVars.Repair[1].hideNoRepairMsg = PA_SavedVars.Repair.hideNoRepairMsg end
			PA_SavedVars.Repair.hideNoRepairMsg = nil
			if (PA_SavedVars.Repair.hideAllMsg ~= nil) then PA_SavedVars.Repair[1].hideAllMsg = PA_SavedVars.Repair.hideAllMsg end
			PA_SavedVars.Repair.hideAllMsg = nil
		end
		
		if (PA_SavedVars.Banking) then
			if (PA_SavedVars.Banking.enabled ~= nil) then PA_SavedVars.Banking[1].enabled = PA_SavedVars.Banking.enabled end
			PA_SavedVars.Banking.enabled = nil
			if (PA_SavedVars.Banking.gold ~= nil) then PA_SavedVars.Banking[1].gold = PA_SavedVars.Banking.gold end
			PA_SavedVars.Banking.gold = nil
			if (PA_SavedVars.Banking.goldDepositInterval ~= nil) then PA_SavedVars.Banking[1].goldDepositInterval = PA_SavedVars.Banking.goldDepositInterval end
			PA_SavedVars.Banking.goldDepositInterval = nil
			if (PA_SavedVars.Banking.goldDepositPercentage ~= nil) then PA_SavedVars.Banking[1].goldDepositPercentage = PA_SavedVars.Banking.goldDepositPercentage end
			PA_SavedVars.Banking.goldDepositPercentage = nil
			if (PA_SavedVars.Banking.goldTransactionStep ~= nil) then PA_SavedVars.Banking[1].goldTransactionStep = PA_SavedVars.Banking.goldTransactionStep end
			PA_SavedVars.Banking.goldTransactionStep = nil
			if (PA_SavedVars.Banking.goldMinToKeep ~= nil) then PA_SavedVars.Banking[1].goldMinToKeep = PA_SavedVars.Banking.goldMinToKeep end
			PA_SavedVars.Banking.goldMinToKeep = nil
			if (PA_SavedVars.Banking.goldWithdraw ~= nil) then PA_SavedVars.Banking[1].goldWithdraw = PA_SavedVars.Banking.goldWithdraw end
			PA_SavedVars.Banking.goldWithdraw = nil
			if (PA_SavedVars.Banking.goldLastDeposit ~= nil) then PA_SavedVars.Banking[1].goldLastDeposit = PA_SavedVars.Banking.goldLastDeposit end
			PA_SavedVars.Banking.goldLastDeposit = nil
			if (PA_SavedVars.Banking.items ~= nil) then PA_SavedVars.Banking[1].items = PA_SavedVars.Banking.items end
			PA_SavedVars.Banking.items = nil
			if (PA_SavedVars.Banking.itemsTimerInterval ~= nil) then PA_SavedVars.Banking[1].itemsTimerInterval = PA_SavedVars.Banking.itemsTimerInterval end
			PA_SavedVars.Banking.itemsTimerInterval = nil
			if (PA_SavedVars.Banking.itemsJunkSetting ~= nil) then PA_SavedVars.Banking[1].itemsJunkSetting = PA_SavedVars.Banking.itemsJunkSetting end
			PA_SavedVars.Banking.itemsJunkSetting = nil
			if (PA_SavedVars.Banking.hideNoDepositMsg ~= nil) then PA_SavedVars.Banking[1].hideNoDepositMsg = PA_SavedVars.Banking.hideNoDepositMsg end
			PA_SavedVars.Banking.hideNoDepositMsg = nil
			if (PA_SavedVars.Banking.hideAllMsg ~= nil) then PA_SavedVars.Banking[1].hideAllMsg = PA_SavedVars.Banking.hideAllMsg end
			PA_SavedVars.Banking.hideAllMsg = nil
			
			if (PA_SavedVars.Banking.ItemTypes) then
				for i = 0, #PAItemTypes do
					if PAItemTypes[i] ~= "" then
						if (PA_SavedVars.Banking.ItemTypes[i] ~= nil) then PA_SavedVars.Banking[1].ItemTypes[i] = PA_SavedVars.Banking.ItemTypes[i] end
						PA_SavedVars.Banking.ItemTypes[i] = nil
					elseif (i == 17) then
						-- 17 used to be ITEMTYPE_ENCHANTING_RUNE which was replaced
						if (PA_SavedVars.Banking.ItemTypes[17] ~= nil) then PA_SavedVars.Banking[1].ItemTypes[49] = PA_SavedVars.Banking.ItemTypes[17] end	-- ITEMTYPE_ENCHANTING_RUNE_ASPECT
						if (PA_SavedVars.Banking.ItemTypes[17] ~= nil) then PA_SavedVars.Banking[1].ItemTypes[50] = PA_SavedVars.Banking.ItemTypes[17] end	-- ITEMTYPE_ENCHANTING_RUNE_ESSENCE
						if (PA_SavedVars.Banking.ItemTypes[17] ~= nil) then PA_SavedVars.Banking[1].ItemTypes[51] = PA_SavedVars.Banking.ItemTypes[17] end	-- ITEMTYPE_ENCHANTING_RUNE_POTENCY
						PA_SavedVars.Banking.ItemTypes[17] = nil
					end
				end
			end
			
			-- delete even older stuff as well!
			PA_SavedVars.Banking.openHirelingChest = nil
			PA_SavedVars.Banking.itemsJunkIncluded = nil
			PA_SavedVars.Banking.itemsIncludeJunk = nil
			PA_SavedVars.Banking.goldDepositStep = nil
			PA_SavedVars.Banking.lastDeposit = nil
		end
		
		
	elseif (PA_SavedVars.General.savedVarsVersion == "1.5.4") then
		-- we have savedVars from 1.5.4 (which introduced the first stacking options)
		
		for currProfile = 1, PAG_MAX_PROFILES do
			if (PA_SavedVars.Banking[currProfile].itemsDepStackOnly == false) then
				PA_SavedVars.Banking[currProfile].itemsDepStackType = PAB_STACKING_FULL
			else
				PA_SavedVars.Banking[currProfile].itemsDepStackType = PAB_STACKING_CONTINUE
			end
			
			if (PA_SavedVars.Banking[currProfile].itemsWitStackOnly == false) then
				PA_SavedVars.Banking[currProfile].itemsWitStackType = PAB_STACKING_FULL
			else
				PA_SavedVars.Banking[currProfile].itemsWitStackType = PAB_STACKING_CONTINUE
			end
			
			-- delete obsolete entries
			PA_SavedVars.Banking[currProfile].itemsDepStackOnly = nil
			PA_SavedVars.Banking[currProfile].itemsWitStackOnly = nil
        end


	elseif intSavedVarsVersion <= 161 then
		-- savedVars from 1.6.1 or earlier which is before the PABanking Refactoring

        for currProfile = 1, PAG_MAX_PROFILES do

            -- Before: PAItemTypes[0] = ITEMTYPE_REAGENT
            -- After: PAItemTypes[1]  = ITEMTYPE_REAGENT

            -- Before: PAItemTypes[26] = ITEMTYPE_RAW_MATERIAL
            -- After: PAItemTypes[28]  = ITEMTYPE_RAW_MATERIAL

            local originalSavedItemTypes = {}
            for i = 0, #PA_SavedVars.Banking[currProfile].ItemTypes do
                originalSavedItemTypes[i] = PA_SavedVars.Banking[currProfile].ItemTypes[i]
            end

            PA_SavedVars.Banking[currProfile].ItemTypes = {}

            -- move all ONE down (index starts at 1 now)
            for i = 1, 23  do
                local itemTypeId = PAItemTypes[i]   -- i.e. 53
                PA_SavedVars.Banking[currProfile].ItemTypes[itemTypeId] = originalSavedItemTypes[i - 1]
            end

            -- create the new entry with default '0'
            PA_SavedVars.Banking[currProfile].ItemTypes[ITEMTYPE_POISON] = 0

            -- move all TWO downs (index starts at 1 now, and new entry for index 24)
            for i = 25, 28  do
                local itemTypeId = PAItemTypes[i]   -- i.e. 41
                PA_SavedVars.Banking[currProfile].ItemTypes[itemTypeId] = originalSavedItemTypes[i - 2]
            end
        end

	end
	
	-- finally, update it with the latest addon version
	PA_SavedVars.General.savedVarsVersion = PA.AddonVersion
end