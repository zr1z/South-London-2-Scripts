local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CallEvent = ReplicatedStorage:WaitForChild("Call");

local callingStatus = false -- false = off, true = on

for _, v in ipairs(Players:GetPlayers()) do
    if toggle then
        local callStart = {
            [1] = v,
            [2] = "Starting"
        }

        local callEnd = {
            [1] = v,
            [2] = "EndCall"
        }
        
        CallEvent:FireServer(unpack(callStart))
        CallEvent:FireServer(unpack(callEnd))
    end
end
