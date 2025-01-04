local player = game.Players.LocalPlayer
local car = Workspace:FindFirstChild(player.Name .. "'s Car") or nil
local isRag = false
local bugging = false

-- Username abbreviation finder
local function findPlayerByNameAbbreviation(abbrev)
    abbrev = abbrev:lower()
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p.Name:lower():sub(1, #abbrev) == abbrev then
            return p
        end
    end
    return nil
end

-- Do not edit these arguments, this can break the script
local function fireEvents()
    if not car then return end

    local tireArg = {car, 10000000, 10000000, 0, 0}
    game:GetService("ReplicatedStorage").TireSmoke:FireServer(unpack(tireArg))

    local carSoundArgs = {car, 1000, 1000, false, 1000, 1000, 0, 1000, false}
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
    end
end

local function stopBugging()
    bugging = false
end

local function monitorRAGG(character)
    character.ChildAdded:Connect(function(child)
        if child.Name == "RAGG" then
            isRag = true
        end
    end)

    character.ChildRemoved:Connect(function(child)
        if child.Name == "RAGG" then
            isRag = false
        end
    end)
end

if player.Character then
    monitorRAGG(player.Character)
end

local function moveCarToPlayerUntilRag()
    if car then
        local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
        car.PrimaryPart = car:FindFirstChild("Body"):FindFirstChild("CollisionPart")

        if car.PrimaryPart then
            repeat
                task.wait()
                car:SetPrimaryPartCFrame(humanoidRootPart.CFrame)
            until isRag == true
            print("First Rag Check Complete")
        else
            local carBody = car:FindFirstChild("Body")
            if carBody and carBody:FindFirstChild("CollisionPart") then
                repeat
                    task.wait()
                    carBody.CollisionPart.CFrame = humanoidRootPart.CFrame
                until isRag == true
                print("Second Rag Check Complete")
            end
        end
    end
end

local function teleportToPlayer(targetPlayerName)
    local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
    print("Found Target")
    if isRag == true and targetPlayer and targetPlayer.Character then
        print("Has Met Character Checks")
        player.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
        print("Has Been Teleported")
    else
        warn("Teleportation Failed: RAGG not present or user not found. Try again")
    end
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
        if car then
            car:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame)
            task.wait()
            car:FindFirstChild("DriveSeat"):Sit(player.Character:FindFirstChild("Humanoid"))
        end
    elseif args[1] == ":to" and args[2] then
        car = Workspace:FindFirstChild(player.Name .. "'s Car") or nil
        if car then
            moveCarToPlayerUntilRag()
            print("Done 1")
            teleportToPlayer(args[2])
            print("Done 2")
        else
            warn("Car not found.")
        end
    end
end)

game.Workspace.ChildAdded:Connect(function(child)
    if child.Name == player.Name .. "'s Car" then
        task.wait(1)
        child:WaitForChild("DriveSeat"):Sit(player.Character.Humanoid)
        car = child
    end
end)

player.CharacterAdded:Connect(monitorRAGG)
