local oldK; oldK = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    args = {...}
    
    if tostring(self) == "AirbagSystem" then
        args[1] = nil
        return oldK(self, unpack(args))
    end
    
    return oldK(self, ...)
end))