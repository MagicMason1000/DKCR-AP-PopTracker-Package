function orbCheck(n)
    local count = Tracker:ProviderCountForCode('rare_orb')
    local val = (count > tonumber(n))
    if ENABLE_DEBUG_LOG then
        print(string.format("called orbCheck. count: %s, n: %s, val: %s", count, n, val))
    end
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end