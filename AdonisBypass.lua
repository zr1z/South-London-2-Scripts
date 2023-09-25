hookfunction(debug.info, function()end)

for _, V in pairs(getgc(true)) do
    if type(V) ~= "function" or not islclosure(V) then continue end

    for _, Constant in ipairs(debug.getconstants(V)) do
        if tostring(Constant):lower():find("adonis anti cheat") then
            local old = nil
            old = hookfunction(V, function(...)
                return task.wait(math.huge)
            end)
        end
    end
end