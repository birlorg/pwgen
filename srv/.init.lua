-- https://redbean.dev/#usage
require("words")

function bytes2uint(str)
    local uint = 0
    for i = 1, #str do
        uint = uint + str:byte(i) * 0x100^(i-1)
    end
    return uint
end

if path.exists('/dev/random') then
    fd = assert(unix.open('/dev/random', unix.O_RDONLY))
    rand_seed = unix.read(fd,6)
-- print(rand_seed)
    rand_seed = bytes2uint(rand_seed)
-- print(rand_seed)
    math.randomseed(rand_seed)
else
    math.randomseed(unix.clock_gettime())
end

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
print(genwords(6) .. tostring(math.random(1,100)))
unix.exit(0)
-- Uncomment this to launch a browser on start
--LaunchBrowser("/")
