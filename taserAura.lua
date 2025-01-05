local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local whitelistedUsers = {
    [UserId] = true -- Replace UserId with actual user IDs
}

shared.taserToggle = true

while shared.taserToggle do
    task.wait(0.1);
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not whitelistedUsers[player.UserId] then
            local target = player.Character and player.Character:FindFirstChild("UpperTorso")
            if target then
                local args = {CFrame.new(0, 0, 0), target}
                LocalPlayer.Character.Taser.Fire:FireServer(unpack(args))
            end
        end
    end
end
