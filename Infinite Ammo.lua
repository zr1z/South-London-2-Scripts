--/Execute Once Gun Has Been Shot Once, Otherwise Will Break Gun!/--

local oldK; oldK = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    args = {...}
    
    if tostring(self) == "Fire" then
        args[1] = nil
        return oldK(self, unpack(args))
    end
    
    return oldK(self, ...)
end))
