local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CallEvent = ReplicatedStorage:WaitForChild("Call");

shared.toggle = true;

for _, v in ipairs(Players:GetPlayers()) do
    if shared.toggle then
        task.wait();
        local callStart = {v, "Starting"}
        local callEnd = {v, "EndCall"}
        
        CallEvent:FireServer(unpack(callStart))
        -- CallEvent:FireServer(unpack(callEnd))
    end
end
