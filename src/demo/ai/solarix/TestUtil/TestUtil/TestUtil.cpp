#include "stdafx.h"
#include <lem/solarix/solarix_grammar_engine.h>

int main(int argc, char *argv[])
{
	auto hEngine = sol_CreateGrammarEngineA(argv[1]);

	sol_DeleteGrammarEngine(hEngine);
    return 0;
}
