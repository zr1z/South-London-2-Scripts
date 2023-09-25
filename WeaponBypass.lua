local oldK; oldK = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    args = {...}
    
    if tostring(self) == "Equipping" then
        args[1] = nil
        return oldK(self, unpack(args))
    end
    
    return oldK(self, ...)
end))



