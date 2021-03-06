#include "stdafx.h"
#include <stdio.h>
#include <lem/solarix/solarix_grammar_engine.h>
#include <lem/solarix/_sg_api.h>

using namespace std;

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

void PrintNode(FILE * out, HGREN hEngine, HGREN_RESPACK hPack, HGREN_TREENODE hNode)
{
	wchar_t word[32];
	memset(word, 0, sizeof(word));
	sol_GetNodeContents(hNode, word);

	if (wcschr(word, L' ') != NULL)
	{
		wide(out, L"[");
		wide(out, word);
		wide(out, L"]");
	}
	else
	{
		wide(out, word);
	}

	int nleaf = sol_CountLeafs(hNode);
	if (nleaf>0)
	{
		fprintf(out, "(");

		for (int i = 0; i<nleaf; i++)
		{
			fprintf(out, " ");
			PrintNode(out, hEngine, hPack, sol_GetLeaf(hNode, i));
		}

		fprintf(out, " )");
	}

	return;
}

int main(int argc, char *argv[])
{
	auto hEngine = sol_CreateGrammarEngineExA(argv[1], SOL_GREN_LAZY_LEXICON);
	auto hs = sol_MorphologyAnalysis(hEngine, L"Мы ели жпу, а ели шумели.", SOL_GREN_MODEL | SOL_GREN_MODEL_ONLY, 0, 0, RUSSIAN_LANGUAGE);

	const int nroot = sol_CountRoots(hs, 0);

	for (int i = 1; i<nroot - 1; ++i)
	{
		auto hNode = sol_GetRoot(hs, 0, i);
		PrintNode(stdout, hEngine, hs, hNode);
	}

	sol_DeleteResPack(hs);

	sol_DeleteGrammarEngine(hEngine);
    return 0;
}

