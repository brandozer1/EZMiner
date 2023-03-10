print("Test!")
shell.run("copy disk/EZMiner .")
local handle = fs.open("disk/EZMiner/branchData", "r")
if handle then
    branchData = textutils.unserialize(handle.readAll())
end
handle.close()
CURRENTBOT = branchData.currentbot

local handle = fs.open("disk/EZMiner/botData", "r")
if handle then
    botData = textutils.unserialize(handle.readAll())
end
handle.close()

for key, value in pairs(botData) do
    if key == CURRENTBOT then
        bot = textutils.unserialize(value)
        bot.index = key
        branchData.currentbot = branchData.currentbot + 1
    end
end

local handle = assert(fs.open("disk/EZMiner/branchData", "w"), "Couldn't save branch data")
handle.write(textutils.serialize(branchData))
handle.close()

function refuelToLevel(level)
  while turtle.getFuelLevel() < level do -- Keep looping until desired fuel level is reached
    for i = 1, 16 do -- Cycle through all slots
      turtle.select(i)
      if turtle.getItemCount() > 0 and turtle.refuel(0) then -- Check if slot has items and is fuel
        local fuelAmount = turtle.getItemCount()
        while turtle.getFuelLevel() < level and fuelAmount > 0 do -- Refuel until desired level is reached or fuel runs out
          turtle.refuel(1)
          fuelAmount = fuelAmount - 1
        end
      end
    end
  end
end

local success, ahead = turtle.inspect()
if success and string.find(ahead.name, "turtle") then
    turtle.turnRight()
    turtle.turnRight()
end

print("waiting for fuel")
refuelToLevel(bot.coal)




print("EZMiner/EZMine " .. branchData.posX .. " " .. branchData.posY  .. " " .. branchData.posZ .. " " .. branchData.posDir .. " " .. branchData.branchDir .. " " .. branchData.depth .. " " .. branchData.branchLength .. " " .. branchData.branchAmount .. " " .. branchData.branchGap .. " " .. bot.offsetX .. " " .. bot.offsetY .. " " .. bot.index-1)
shell.run("EZMiner/EZMine " .. branchData.posX .. " " .. branchData.posY  .. " " .. branchData.posZ .. " " .. branchData.posDir .. " " .. branchData.branchDir .. " " .. branchData.depth .. " " .. branchData.branchLength .. " " .. branchData.branchAmount .. " " .. branchData.branchGap .. " " .. bot.offsetX .. " " .. bot.offsetY .. " " .. bot.index-1)
