local ServerStorage = game:GetService("ServerStorage")
local Lexer = require(ServerStorage.Lexer)
local LexerStream = Lexer.new([[
	local function ABC()
		return false
	end

	print(ABC())
]])

while not LexerStream.Completed do
	print(LexerStream:Advance())
end