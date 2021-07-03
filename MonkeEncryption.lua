-- magic / accually this is just garbage that just makes encrypted text longer
local charMap = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=_+/*,.[]{}!@#$%^&*()<>?;:~` '

-- make a never higher than b
local function wrapNumber(a, b)
    while a > b do
        a = a - b
    end
    return a
end

-- pass to key yes monke brain
local function passToKey(pass)
    local key = 0
    for i = 1, string.len(pass), 1 do
        key = key + string.byte(pass:sub(i, i))
    end
    return key
end

function Encrypt(text, password)
    local key = passToKey(password)
    local encryptedText = ''
    for i = 1, string.len(text), 1 do
        local secureNr = key * i
        local monkeNumber = 11%(wrapNumber(secureNr, 11) + 1) + 1
        local luckyChars = ''

        for j = 1, monkeNumber, 1 do
            local luckyNr = wrapNumber(secureNr * j + string.len(text), string.len(charMap))
            local luckyChar = charMap:sub(luckyNr, luckyNr)
            luckyChars = luckyChars .. luckyChar
        end
        encryptedText = encryptedText .. luckyChars .. text:sub(i, i)
    end

    encryptedText = encryptedText .. 'MONKEE:)'
    return encryptedText
end

function Decrypt(text, password)
    text = text:sub(1, -9)
    local key = passToKey(password)

    local decryptedText = ''
    local offset = 0

    -- make magic
    for i = 1, string.len(text), 1 do
        local secureNr = key * i
        local monkeNumber = 11%(wrapNumber(secureNr, 11) + 1) + 2
        offset = offset + monkeNumber

        local luckyChar = text:sub(offset, offset)
        if luckyChar == '' then break end
        decryptedText = decryptedText .. luckyChar
    end
    return decryptedText
end

return {encrypt = Encrypt, decrypt = Decrypt}
