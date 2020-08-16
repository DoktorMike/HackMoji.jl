function runme(code=",.", tapelen=10000)
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

function mapjumps(code=",.[,.,.+++[,..],--]..,")
    jumps = Dict{Int, Int}()
    stack = []
    for i in 1:length(code)
        if code[i] == '['  push!(stack, i)
        elseif code[i] == ']' jumps[i] = pop!(stack) 
        end
    end
    return jumps
end

