local p = game.Players.LocalPlayer
local v;

local gunTypes = {"Pistol", "Auto", "Semi"}

local function doChanges(v)
    v.MaxAmmo.Value = 1
    v.ClipSize.Original.Value = 1000
    v.ClipSize.Value = 1
    v.FireRate.Value = 0
    v.Recoil.Value = 0
    v.Damage.Value = 1000
end

for _, t in pairs(p.Character:GetChildren()) do
    if t and t:FindFirstChild("Stats") then
        v = t:FindFirstChild("Stats")
        if table.find(gunTypes, v.GunType.Value) then
            if v.GunType.Value == gunTypes[1] or v.GunType.Value == gunTypes[3] then
                v.GunType.Value = gunTypes[2]
            end
        end
        while p.Character:FindFirstChild(v.Parent.Name) do
            doChanges(v)
            task.wait()
        end
    end
end

p.Character.ChildAdded:Connect(function(c)
    if c:FindFirstChild("Stats") then
        local newV = c:FindFirstChild("Stats")
        if table.find(gunTypes, newV.GunType.Value) then
            if newV.GunType.Value == gunTypes[1] or v.GunType.Value == gunTypes[3] then
                newV.GunType.Value = gunTypes[2]
            end
        end
        while p.Character:FindFirstChild(newV.Parent.Name) do
            doChanges(newV)
            task.wait()
        end
    end
end)