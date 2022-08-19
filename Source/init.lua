local TypesModule = require(script.Types)
local StreamModule = require(script.Stream)
local Matches = require(script.Matches)
local Tokens = require(script.Tokens)

local Lexer: TypesModule.Lexer = { }

local StringFind = string.find
local StringSub = string.sub

Lexer.EOS = "<EOS>"

function Lexer:Advance()
	if self.Index > self.SourceSize then
		return self.EOS
	end

	self.Tail = self.Head

	for _, LexStructure in Matches do
		local LexMatch, LexMatchName = LexStructure[1], LexStructure[2]

		local LexStringQuery = { StringFind(self.Source, LexMatch, self.Index) }
		local LexStringPosition1, LexStringPosition2 = LexStringQuery[1], LexStringQuery[2]

		if LexStringPosition1 then
			local LexToken = StringSub(self.Source, LexStringPosition1, LexStringPosition2)

			self.Index = LexStringPosition2 + 1

			if LexMatchName == "WHITESPACE" then
				return self:Advance()
			else
				self.Head = { Tokens[LexToken] or LexMatchName, LexToken }

				return self.Head[1], self.Head[2]
			end
		end
	end
end

function Lexer.new(Source)
	local self = setmetatable({ SourceSize = #Source, Source = Source, Index = 1 }, { __index = Lexer })

	return StreamModule.new(self)
end

return Lexer