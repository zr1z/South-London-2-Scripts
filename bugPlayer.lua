local localPlayer = game.Players.LocalPlayer;
local car = Workspace:WaitForChild(localPlayer.Name .. "'s Car", 1) or nil;
local replicatedStorage = game:GetService("ReplicatedStorage");

shared.isRag = false;
shared.bugging = false;

local function findPlayerByNameAbbreviation(abbrev)
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name:lower():sub(1, #abbrev) == abbrev:lower() then
            return player;
        end;
    end;
    return nil;
end

local function fireRemotes()
    if not car then return end;
    
    local carSoundArgs = {car, 1000, 1000, false, 1000, 1000, 0, 1000, false};
    -- local tireArgs = {car, 10000000, 10000000, 0, 0};
    
    replicatedStorage.CarSound:FireServer(unpack(carSoundArgs));
    -- replicatedStorage.TireSmoke:FireServer(unpack(tireArgs));
end;

local function moveCarToTargetPlayer(targetPlayerName)
    local targetPlayer = findPlayerByNameAbbreviation(targetPlayerName);

    if targetPlayer then
        shared.bugging = true;
        while shared.bugging do
            if car and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                car:SetPrimaryPartCFrame(targetPlayer.Character.HumanoidRootPart.CFrame);
                fireRemotes();
            else
                warn("Target Player Has Not Been Found");
                shared.bugging = false;
            end;
            task.wait(0.1);
        end;
    else
        warn("Player Not Found!");
    end;
end;

localPlayer.Chatted:Connect(function(msg)
    local args = msg:split(" ")
    
    if args[1] == ":bug" and args[2] then
        car = Workspace:FindFirstChild(localPlayer.Name .. "'s Car") or nil;
        if car then
            car.PrimaryPart = car:FindFirstChild("Body"):FindFirstChild("CollisionPart")
            moveCarToTargetPlayer(args[2])
        else
            warn("Player Car Has Not Been Found")
        end
    elseif args[1] == ":stop" then
        shared.bugging = false;
        car:SetPrimaryPartCFrame(localPlayer.Character.HumanoidRootPart.CFrame);
        task.wait();
        car:FindFirstChild("DriveSeat"):Sit(localPlayer.Character:FindFirstChild("Humanoid"));
    end;
end);

game.Workspace.ChildAdded:Connect(function(child)
    if child.Name == localPlayer.Name .. "'s Car" then
        task.wait(1);
        child:WaitForChild("DriveSeat"):Sit(localPlayer.Character.Humanoid);
        car = child;
    end;
end);
