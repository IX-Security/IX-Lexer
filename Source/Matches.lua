local NUMBER_TOKEN = "NUMBER"
local NAME_TOKEN = "NAME"
local BOOLEAN_TOKEN = "BOOLEAN"
local STRING_TOKEN = "STRING"
local SPACE_TOKEN = "WHITESPACE"
local COMMENT_TOKEN = "COMMENT"
local NIL_TOKEN = "NIL"

return {
	{ "^nil", NIL_TOKEN, },

	{ "^false", BOOLEAN_TOKEN },
	{ "^true", BOOLEAN_TOKEN },

	{ "^[%a_][%w_]*", NAME_TOKEN },
	{ "^%s+", SPACE_TOKEN },

	{ "^0x[%da-fA-F]+", NUMBER_TOKEN },
	{ "^%d+%.?%d*[eE][%+%-]?%d+", NUMBER_TOKEN },
	{ "^%d+%.?%d*", NUMBER_TOKEN },

	{ "^(['\"])%1", STRING_TOKEN },
	{ [[^(['"])(\*)%2%1]], STRING_TOKEN },
	{ [[^(['"]).-[^\](\*)%2%1]], STRING_TOKEN },
	{ "^(['\"]).-.*", STRING_TOKEN },
	{ "^%[(=*)%[.-%]%1%]", STRING_TOKEN },
	{ "^%[%[.-.*", STRING_TOKEN },

	{ "^%-%-%[(=*)%[.-%]%1%]", COMMENT_TOKEN },
	{ "^%-%-%[%[.-.*", COMMENT_TOKEN },
	{ "^%-%-.-\n", COMMENT_TOKEN },
	{ "^%-%-.-.*", COMMENT_TOKEN },

	{ "^==", "^==" },
	{ "^~=", "^~=" },
	{ "^<=", "^<=" },
	{ "^>=", "^>=" },
	{ "^%.%.%.", "^%.%.%." },
	{ "^%.%.", "^%.%." },
	{ "^.", "^."}
}