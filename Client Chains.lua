while task.wait() do
      game:GetService("Players").LocalPlayer.Characterstats.Chains.Value = "CrossChain"
      game:GetService("Players").LocalPlayer.Character.Parent = game:GetService("ReplicatedStorage")
      game:GetService("Players").LocalPlayer.Character.Parent = game:GetService("Workspace")
      game:GetService("ReplicatedStorage").Chains.CrossChain.Parent = game:GetService("Players").LocalPlayer.Character
end

while task.wait() do
      game:GetService("Players").LocalPlayer.Characterstats.Chains.Value = "HunnidChain"
      game:GetService("Players").LocalPlayer.Character.Parent = game:GetService("ReplicatedStorage")
      game:GetService("Players").LocalPlayer.Character.Parent = game:GetService("Workspace")
      game:GetService("ReplicatedStorage").Chains.HunnidChain.Parent = game:GetService("Players").LocalPlayer.Character
end
