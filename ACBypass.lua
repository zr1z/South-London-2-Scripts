local Player = game.Players.LocalPlayer.Character;

local sFPS = setfpscap
local isKeyPressed = false;

local function onKeyPress(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.RightShift then
        isKeyPressed = true;
    end;
end;

local function onKeyRelease(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.RightShift then
        isKeyPressed = false;
        sFPS(500)
        Player.Humanoid.WalkSpeed = 7
    end;
end;

game:GetService('UserInputService').InputBegan:Connect(onKeyPress);
game:GetService('UserInputService').InputEnded:Connect(onKeyRelease);

while true do
    if isKeyPressed then
        sFPS(5)
        Player.Humanoid.WalkSpeed = 90
        task.wait();
    else
        task.wait();
    end;
end;