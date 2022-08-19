local Stream = { }

function Stream:Skip(Int)
	for _ = 1, Int or 1 do
		self:Advance()
	end
end

function Stream:Advance()
	self.Previous = { self.Lexeme, self.Token }
	self.Lexeme, self.Token = self.Head[1], self.Head[2]
	self.Head = { self.Lexer:Advance() }

	if self.Lexeme == self.Lexer.EOS then
		self.Completed = true
	end

	return self.Lexeme, self.Token
end

function Stream:IsNext(...)
	local DatasToFind = { ...}
	local IndexResult = table.find(DatasToFind, self.Head[1])
	IndexResult = IndexResult or table.find(DatasToFind, self.Head[2])

	return (IndexResult and DatasToFind[IndexResult]) or false
end

function Stream:Is(...)
	local DatasToFind = { ...}
	local IndexResult = table.find(DatasToFind, self.Lexeme)
	IndexResult = IndexResult or table.find(DatasToFind, self.Token)

	return (IndexResult and DatasToFind[IndexResult]) or false
end

function Stream.new(Lexer)
	local self = setmetatable({ Lexer = Lexer, Completed = false }, { __index = Stream })

	self.Previous = { }
	self.Head = { }

	self:Advance()

	return self
end

return Stream