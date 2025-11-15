-- https://redbean.dev/#usage
require("words")

function bytes2uint(str)
    local uint = 0
    for i = 1, #str do
        uint = uint + str:byte(i) * 0x100^(i-1)
    end
    return uint
end

math.randomseed(Rdrand())

function genword()
    i = math.random(1,#words)
    word = tostring(words[i])
    return string.gsub(word,"^%l", string.upper)
end

function genwords(numwords)
    local ret = ""
    for i = 1, numwords do
        ret = ret .. genword() .. "."
    end
    return ret
end

i = math.random(1,#words)
print(genwords(6) .. tostring(math.random(1,99)))
unix.exit(0)
-- Uncomment this to launch a browser on start
--LaunchBrowser("/")
