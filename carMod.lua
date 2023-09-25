local newIndexHP = 500

for _, zR1 in next, getgc(not false) do
    if type(zR1) == "table" and rawget(zR1, "Horsepower") then
          rawset(zR1, "Horsepower", newIndexHP);
    else
        if not newIndexHP or type(zR1) then return end;
    end
end