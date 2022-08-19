export type Stream = {
	Lexeme: string,
	Token: string,

	Head: { [number]: string },
	Previous: { [number]: string },

	Is: (...string) -> boolean,
	IsNext: (...string) -> boolean,
	Skip: (Int: number) -> nil,
	Advance: () -> nil
}

export type Lexer = {
	new: (Source: string) -> Stream
}

return "IX-Lexer-Types"