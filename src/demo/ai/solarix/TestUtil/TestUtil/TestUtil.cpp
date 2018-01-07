#include "stdafx.h"
#include <lem/solarix/solarix_grammar_engine.h>
#include <lem/solarix/_sg_api.h>
#include <stdio.h>

void wide(FILE *f, const wchar_t *ustr)
{
	const int l = wcslen(ustr);
	char *abuffer = new char[l * 6 + 1];
	memset(abuffer, 0, l * 6 + 1);
	WideCharToMultiByte(CP_OEMCP, 0, ustr, l + 1, abuffer, l * 6 + 1, NULL, NULL);
	fprintf(f, "%s", abuffer);
	fflush(f);
	delete[] abuffer;
	return;
}

int main(int argc, char *argv[])
{
	auto hEngine = sol_CreateGrammarEngineExA(argv[1], SOL_GREN_LAZY_LEXICON);
	auto words = sol_TokenizeFormsW(hEngine, L"Мы ели суп, а ели шумели.", RUSSIAN_LANGUAGE);
	int cnt = sol_CountTokens(words);
	int* entries = new int[cnt];

	sol_GetTokenEntries(words, entries, cnt);

	wchar_t* buff = new wchar_t[100];
	for (int i = 0; i < cnt; i++)
	{
		int len = sol_GetTokenStringLen(words, i);
		
		sol_GetTokenStringW(words, i, buff);

		wide(stdout, buff);
		wide(stdout, L"\t");
		
		sol_GetEntryName(hEngine, entries[i], buff);
		
		wide(stdout, buff);
		wide(stdout, L"\t");

		sol_GetClassName(hEngine, sol_GetEntryClass(hEngine, entries[i]), buff);
		wide(stdout, buff);

		wide(stdout, L"\n");
	}

	delete[] buff;
	delete[] entries;

	sol_DeleteTokens(words);
	sol_DeleteGrammarEngine(hEngine);
	return 0;
}
