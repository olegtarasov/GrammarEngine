#include "stdafx.h"
#include <lem/solarix/solarix_grammar_engine.h>

int main(int argc, wchar_t *argv[])
{
	auto hEngine = sol_CreateGrammarEngine(argv[1]);

	sol_DeleteGrammarEngine(hEngine);
    return 0;
}

