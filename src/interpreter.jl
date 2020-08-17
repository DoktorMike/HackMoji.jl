"""
    runme(code::String = ",.", tapelen = 10000, a)

The interpreter of the HackMoji language.

# Arguments:
- `code`: Your HackMoji code given as a string
- `tapelen`: Your HackMoji memory given as number of bytes
"""
function runme(code::String=",.", tapelen=10000)
    data = fill(UInt8(0), tapelen)
    index = 1
    ptr = 1
    jumps = mapjumps(code)
    jumpstarts = collect(values(jumps))
    jumpends = collect(keys(jumps))
    while index <= length(code)
        op = code[index]
        if op=='.' print(Char(data[ptr]))
        elseif op==','
            inp=readline()
            if(length(inp)>0) data[ptr] = UInt8(inp[1])
            else data[ptr] = UInt8(0)
            end
        elseif op=='+' data[ptr] += UInt8(1)
        elseif op=='-' data[ptr] -= UInt8(1)
        elseif op=='>' ptr += 1
        elseif op=='<' ptr -= 1
        elseif op=='['
            if data[ptr] == 0x00
                index = jumpends[findfirst(isequal(index), jumpstarts)]
            end
        elseif op==']'
            if data[ptr] != 0x00
                index = jumps[index]
            end
        end
        index += 1
    end
end

"""
    mapjumps(code=",.[,.,.+++[,..],--]..,")

Register the beginning and end of all loops in the HackMoji Code.
"""
function mapjumps(code::String=",.[,.,.+++[,..],--]..,")
    jumps = Dict{Int, Int}()
    stack = []
    for i in 1:length(code)
        if code[i] == '['  push!(stack, i)
        elseif code[i] == ']' jumps[i] = pop!(stack) 
        end
    end
    return jumps
end

