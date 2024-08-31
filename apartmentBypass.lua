shared.InsideApartments = true

if shared.InsideApartments then
    task.wait()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("InsideApartments") then
        game.Players.LocalPlayer.Character:FindFirstChild("InsideApartments"):Destroy()
    end
end
