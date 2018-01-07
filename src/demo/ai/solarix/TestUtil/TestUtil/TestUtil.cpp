#include "stdafx.h"
#include <lem/solarix/solarix_grammar_engine.h>
#include <lem/solarix/_sg_api.h>

int main(int argc, char *argv[])
{
	auto hEngine = sol_CreateGrammarEngineExA(argv[1], SOL_GREN_LAZY_LEXICON);
	auto words = sol_TokenizeW(hEngine, L"Мы ели суп, а ели шумели.", RUSSIAN_LANGUAGE);

	sol_DeleteGrammarEngine(hEngine);
    return 0;
}
