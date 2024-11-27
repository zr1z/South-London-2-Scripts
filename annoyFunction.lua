-- [sl2.fucker] - Car Bug Preview
















local player = game.Players.LocalPlayer;
local car = Workspace:WaitForChild(player.Name .. "'s Car", 1) or nil;

local isRag = false
local bugging = false

local function findPlayerByNameAbbreviation(abbrev)
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p.Name:lower():sub(1, #abbrev) == abbrev:lower() then
            return p
        end
    end
    return nil
end

local function fireEvents()
    local tireArg = {
        [1] = game.Workspace[game.Players.LocalPlayer.Name .. "'s Car"],
        [2] = 10000000,
        [3] = 10000000,
        [4] = 0,
        [5] = 0
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("TireSmoke"):FireServer(unpack(tireArg))
    
    local carSoundArgs = {
        [1] = game.Workspace[game.Players.LocalPlayer.Name .. "'s Car"],
        [2] = 1000,
        [3] = 1000,
        [4] = false,
        [5] = 1000,
        [6] = 1000,
        [7] = 0,
        [8] = 1000,
        [9] = false
    }
    game:GetService("ReplicatedStorage").CarSound:FireServer(unpack(carSoundArgs))
end

local function moveCarToTargetPlayer(targetPlayerName)
    local targetPlayer = findPlayerByNameAbbreviation(targetPlayerName)

    if targetPlayer then
        bugging = true
        while bugging do
            if car and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                car:SetPrimaryPartCFrame(targetPlayer.Character.HumanoidRootPart.CFrame)
                fireEvents()
            else
                warn("Player Not Found!")
                bugging = false
            end
            task.wait(0.1)
        end
    else
        warn("Player Not Found!")
    end
end

local function stopBugging()
    bugging = false
end

game.Players.LocalPlayer.Chatted:Connect(function(msg)
    local args = msg:split(" ")
    
    if args[1] == ":bug" and args[2] then
        car = Workspace:FindFirstChild(player.Name .. "'s Car") or nil
        if car then
            car.PrimaryPart = car:FindFirstChild("Body"):FindFirstChild("CollisionPart")
            moveCarToTargetPlayer(args[2])
        else
            warn("Car not found.")
        end
    elseif args[1] == ":stop" then
        stopBugging()
        car:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame)
        task.wait()
        car:FindFirstChild("DriveSeat"):Sit(player.Character:FindFirstChild("Humanoid"))
    end
end)

game.Workspace.ChildAdded:Connect(function(child)
    if child.Name == player.Name .. "'s Car" then
        car = child
    end
end)