/*
**  DeSR
**  src/MorphExtractor.cpp
**  ----------------------------------------------------------------------
**  Copyright (c) 2005  Giuseppe Attardi (attardi@di.unipi.it).
**  ----------------------------------------------------------------------
**
**  This file is part of DeSR.
**
**  DeSR is free software; you can redistribute it and/or modify it
**  under the terms of the GNU General Public License, version 3,
**  as published by the Free Software Foundation.
**
**  DeSR is distributed in the hope that it will be useful,
**  but WITHOUT ANY WARRANTY; without even the implied warranty of
**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
**  GNU General Public License for more details.
**
**  You should have received a copy of the GNU General Public License
**  along with this program.  If not, see <http://www.gnu.org/licenses/>.
**  ----------------------------------------------------------------------
*/

#include "MorphExtractor.h"
#include "conf/conf_bool.h"

// standard
#include <cstdio>		// sprintf

namespace Tanl {

/**	Whether to create morpho feature by extracting elementary features
 *	like gender, number, case
 */
IXE::conf<bool>	MorphExtract("MorphExtract", false);

char* strnzcpy(char *dest, const char *src, size_t n) {
  strncpy(dest, src, n);
  dest[n] = '\0';
  return dest;
}

void MorphExtractor::operator() (char const* start, char const* end,
				 Features& mf) const
{
  mf.gender[0] = '\0';
  mf.number[0] = '\0';
  mf.person[0] = '\0';
  if (end - start == 1 && !strncmp(start, "_", 1))
    mf.full[0] = '\0';
  else
    strnzcpy(mf.full, start, end - start);
}

// ======================================================================
// Arabic

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern ArabicMorphExtractor::reCase("case=(\\d)");
Tanl::Text::RegExp::Pattern ArabicMorphExtractor::reGender("gen=(\\w)");
Tanl::Text::RegExp::Pattern ArabicMorphExtractor::reNumber("num=(\\w)");
Tanl::Text::RegExp::Pattern ArabicMorphExtractor::rePerson("pers=(\\d)");

void ArabicMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{ 
  MorphExtractor::operator() (start, end, mf);

  Tanl::Text::RegExp::MatchGroups match(2);

  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (reCase.match(start, end, match) > 0)
    strnzcpy(mf.Case, start + match[1].first, match[1].second - match[1].first);
}

// ======================================================================
// Indian

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern IndianMorphExtractor::reCase("case-(\\w*)");
Tanl::Text::RegExp::Pattern IndianMorphExtractor::reGender("gend-(\\w*)");
Tanl::Text::RegExp::Pattern IndianMorphExtractor::reNumber("num-(\\w*)");
Tanl::Text::RegExp::Pattern IndianMorphExtractor::rePerson("pers-(\\w*)");
Tanl::Text::RegExp::Pattern IndianMorphExtractor::reVibhakti("vib-(\\w*)");
// Tense, Aspect, Modality
Tanl::Text::RegExp::Pattern IndianMorphExtractor::reTam("tam-(\\w*)");

void IndianMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{ 
  MorphExtractor::operator() (start, end, mf);

  Tanl::Text::RegExp::MatchGroups match(2);

  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (reCase.match(start, end, match) > 0)
    strnzcpy(mf.Case, start + match[1].first, match[1].second - match[1].first);
  if (reVibhakti.match(start, end, match) > 0)
    strnzcpy(mf.extra, start + match[1].first, match[1].second - match[1].first);
  if (reTam.match(start, end, match) > 0)
    strnzcpy(mf.tense, start + match[1].first, match[1].second - match[1].first);

}

// ======================================================================
// Basque

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern BasqueMorphExtractor::reNumber("NUM([SP])");

void BasqueMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
}

// ======================================================================
// Catalan
// use Spanish

// ======================================================================
// Czech

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern CzechMorphExtractor::reGender("Gen=(\\w)");
Tanl::Text::RegExp::Pattern CzechMorphExtractor::reNumber("Num=(\\w)");
Tanl::Text::RegExp::Pattern CzechMorphExtractor::rePerson("Per=(\\d)");
Tanl::Text::RegExp::Pattern CzechMorphExtractor::reCase("Cas=(\\d)");
Tanl::Text::RegExp::Pattern CzechMorphExtractor::reNegative("Neg=(\\w)");
Tanl::Text::RegExp::Pattern CzechMorphExtractor::reGra("Gra=(\\w)");

void CzechMorphExtractor::operator() (char const* start, char const* end,
				      Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

# ifdef CZ_FEATS
  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
# endif
  if (reCase.match(start, end, match) > 0)
    strnzcpy(mf.Case, start + match[1].first, match[1].second - match[1].first);
}

// ======================================================================
// Bulgarian

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern BulgarianMorphExtractor::reGender("gen=(\\w)");
Tanl::Text::RegExp::Pattern BulgarianMorphExtractor::reNumber("num=(\\w)");
Tanl::Text::RegExp::Pattern BulgarianMorphExtractor::rePerson("pers=(\\d)");

void BulgarianMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
}

// ======================================================================
// Danish

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern DanishMorphExtractor::reGender("gender=(\\w)");
Tanl::Text::RegExp::Pattern DanishMorphExtractor::reNumber("number=(\\w)");
Tanl::Text::RegExp::Pattern DanishMorphExtractor::rePerson("person=(\\d)");
Tanl::Text::RegExp::Pattern DanishMorphExtractor::reCase("case=(\\w)");

void DanishMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (reCase.match(start, end, match) > 0)
    strnzcpy(mf.Case, start + match[1].first, match[1].second - match[1].first);
}

// ======================================================================
// Dutch

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern DutchMorphExtractor::reGender("\\|(onzijd|onzijd)\\|");
Tanl::Text::RegExp::Pattern DutchMorphExtractor::reNumber("\\|(e|m)v\\|");
Tanl::Text::RegExp::Pattern DutchMorphExtractor::rePerson("\\|(\\d)\\|");
Tanl::Text::RegExp::Pattern DutchMorphExtractor::reCase("(neut|gen|dat)");

void DutchMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (reCase.match(start, end, match) > 0)
    strnzcpy(mf.Case, start + match[1].first, match[1].second - match[1].first);
  if (MorphExtract)
    // combine morphological features
    sprintf(mf.full, "%s%s%s%s", mf.gender, mf.number, mf.person, mf.Case);
}

// ======================================================================
// English

// ======================================================================
// French

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern FrenchMorphExtractor::reNumber("n=(\\w)+");
Tanl::Text::RegExp::Pattern FrenchMorphExtractor::rePerson("p=(\\d)");
Tanl::Text::RegExp::Pattern FrenchMorphExtractor::reSubcat("s=(\\w)+");

void FrenchMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (reSubcat.match(start, end, match) > 0)
    strnzcpy(mf.subcat, start + match[1].first, match[1].second - match[1].first);
}

// ======================================================================
// German

// ======================================================================
// Greek

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern GreekMorphExtractor::reGender("(Fe|Ma|Ne)\\|");
Tanl::Text::RegExp::Pattern GreekMorphExtractor::reNumber("\\|(Sg|Pl)");
Tanl::Text::RegExp::Pattern GreekMorphExtractor::rePerson("\\|(0\\d)");
Tanl::Text::RegExp::Pattern GreekMorphExtractor::reCase("\\|(Ge|Ac|Da|Vo)");

void GreekMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (reCase.match(start, end, match) > 0)
    strnzcpy(mf.Case, start + match[1].first, match[1].second - match[1].first);
  if (MorphExtract)
    // combine morphological features
    sprintf(mf.full, "%s%s%s%s", mf.gender, mf.number, mf.person, mf.Case);
}

// ======================================================================
// Hungarian

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern HungarianMorphExtractor::reNumber("n=(\\w)+");
Tanl::Text::RegExp::Pattern HungarianMorphExtractor::rePerson("p=(\\d)");
Tanl::Text::RegExp::Pattern HungarianMorphExtractor::reCase("c=(\\w)+");

void HungarianMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (reCase.match(start, end, match) > 0)
    strnzcpy(mf.Case, start + match[1].first, match[1].second - match[1].first);
}

// ======================================================================
// Italian

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern ItalianMorphExtractor::reGender("gen=(\\w)");
Tanl::Text::RegExp::Pattern ItalianMorphExtractor::reMode("mod=(\\w)");
Tanl::Text::RegExp::Pattern ItalianMorphExtractor::reNumber("num=(\\w)");
Tanl::Text::RegExp::Pattern ItalianMorphExtractor::rePerson("per=(\\d)");
Tanl::Text::RegExp::Pattern ItalianMorphExtractor::reTense("ten=(\\w)");

void ItalianMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reMode.match(start, end, match) > 0)
    strnzcpy(mf.mode, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (reTense.match(start, end, match) > 0)
    strnzcpy(mf.tense, start + match[1].first, match[1].second - match[1].first);
  // complete participles
  if (!strcmp(mf.mode, "p")) {
    if (!strcmp(mf.tense, "p"))
      strcpy(mf.gender, "n");
    else
      strcpy(mf.tense, "s");
  }
  if (MorphExtract)
    // combine morphological features
    sprintf(mf.full, "%s%s%s", mf.gender, mf.number, mf.person);
}

// ======================================================================
// Italian TUT

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern ItalianTutMorphExtractor::reCase("cas=([A-Z+]+)");
Tanl::Text::RegExp::Pattern ItalianTutMorphExtractor::reGender("gen=(\\w)");
Tanl::Text::RegExp::Pattern ItalianTutMorphExtractor::reMode("mod=(\\w)");
Tanl::Text::RegExp::Pattern ItalianTutMorphExtractor::reNumber("num=(\\w)");
Tanl::Text::RegExp::Pattern ItalianTutMorphExtractor::rePerson("per=(\\d)");
Tanl::Text::RegExp::Pattern ItalianTutMorphExtractor::reSem("sem=(\\w+)");
Tanl::Text::RegExp::Pattern ItalianTutMorphExtractor::reTense("tmp=(\\w)");
Tanl::Text::RegExp::Pattern ItalianTutMorphExtractor::reTrans("trans=(\\w)");
Tanl::Text::RegExp::Pattern ItalianTutMorphExtractor::reVTrans("v-trans=(\\w)");

void ItalianTutMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reCase.match(start, end, match) > 0)
    strnzcpy(mf.extra, start + match[1].first, match[1].second - match[1].first);
  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reMode.match(start, end, match) > 0)
    strnzcpy(mf.mode, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  /* forget it: it coincides with whole FEATS
  if (reSem.match(start, end, match) > 0)
    strnzcpy(mf.extra2, start + match[1].first, match[1].second - match[1].first);
  */
  if (reTense.match(start, end, match) > 0)
    strnzcpy(mf.tense, start + match[1].first, match[1].second - match[1].first);
  if (reTrans.match(start, end, match) > 0)
    strnzcpy(mf.trans, start + match[1].first, match[1].second - match[1].first);
  // use same field as trans, but in lowercase
  if (reVTrans.match(start, end, match) > 0) {
    mf.trans[0] = tolower(*(start + match[1].first));
    mf.trans[1] = '\0';
  }
  if (MorphExtract)
    // combine morphological features
    sprintf(mf.full, "%s%s%s", mf.gender, mf.number, mf.person);
}

// ======================================================================
// Portuguese

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern PortugueseMorphExtractor::reGender("([MF])\\|");
Tanl::Text::RegExp::Pattern PortugueseMorphExtractor::reNumber("\\|([SP])");
Tanl::Text::RegExp::Pattern PortugueseMorphExtractor::rePerson("\\|(\\d[SP])\\|");

void PortugueseMorphExtractor::operator() (char const* start, char const* end,
					   Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (MorphExtract)
    // combine morphological features
    sprintf(mf.full, "%s%s%s", mf.gender, mf.number, mf.person);
}

// ======================================================================
// Slovene

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern SloveneMorphExtractor::reCase("Case=(\\w)");
Tanl::Text::RegExp::Pattern SloveneMorphExtractor::reGender("Gender=(\\w)");
Tanl::Text::RegExp::Pattern SloveneMorphExtractor::reNegative("Negative=(\\w)");
Tanl::Text::RegExp::Pattern SloveneMorphExtractor::reNumber("Number=(\\w)");
Tanl::Text::RegExp::Pattern SloveneMorphExtractor::rePerson("Person=(\\w)");

void SloveneMorphExtractor::operator() (char const* start, char const* end,
				      Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (reCase.match(start, end, match) > 0)
    strnzcpy(mf.Case, start + match[1].first, match[1].second - match[1].first);
  if (MorphExtract)
    // combine morphological features
    sprintf(mf.full, "%s%s%s%s", mf.gender, mf.number, mf.person, mf.Case);
}

// ======================================================================
// Spanish

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern SpanishMorphExtractor::reGender("gen=(\\w)");
Tanl::Text::RegExp::Pattern SpanishMorphExtractor::reNumber("num=(\\w)");
Tanl::Text::RegExp::Pattern SpanishMorphExtractor::rePerson("per=(\\d)");

void SpanishMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (MorphExtract)
    // combine morphological features
    sprintf(mf.full, "%s%s%s", mf.gender, mf.number, mf.person);
}

// ======================================================================
// Swedish

// ======================================================================
// Turkish

// pattern for extracting morpho features
// Example: A1sg|Pnon|Nom, A3sg|P3pl|Nom
// FIXME: handle also P3pl
Tanl::Text::RegExp::Pattern TurkishMorphExtractor::reAFeats("A\\d\\w");
Tanl::Text::RegExp::Pattern TurkishMorphExtractor::rePFeats("P\\d\\w");

void TurkishMorphExtractor::operator() (char const* start, char const* end,
				      Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reAFeats.match(start, end, match) > 0) {
    strnzcpy(mf.person, start + match[1].first + 1, 1);
    strnzcpy(mf.number, start + match[1].first + 2, 1);
  }
  // FIXME: handle also P3pl
  if (MorphExtract)
    // combine morphological features
    sprintf(mf.full, "%s%s%s", mf.gender, mf.number, mf.person);
}






// ======================================================================
// RUSSIAN

// pattern for extracting morpho features
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reCase("case=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reGender("gender=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reNumber("number=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::rePerson("person=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reTense("tense=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reDegree("degree=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reAspect("aspect=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reAnimate("animate=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reMood("mood=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reModal("modal=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reTransCase("transcase=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::rePassive("voice=(.+?)\\|");
Tanl::Text::RegExp::Pattern RussianMorphExtractor::reParticiple("participle=(.+?)\\|");

void RussianMorphExtractor::operator() (char const* start, char const* end,
					Features& mf) const
{
  MorphExtractor::operator() (start, end, mf);
  Tanl::Text::RegExp::MatchGroups match(2);

  if (reCase.match(start, end, match) > 0)
    strnzcpy(mf.Case, start + match[1].first, match[1].second - match[1].first);
  if (reGender.match(start, end, match) > 0)
    strnzcpy(mf.gender, start + match[1].first, match[1].second - match[1].first);
  if (reNumber.match(start, end, match) > 0)
    strnzcpy(mf.number, start + match[1].first, match[1].second - match[1].first);
  if (rePerson.match(start, end, match) > 0)
    strnzcpy(mf.person, start + match[1].first, match[1].second - match[1].first);
  if (reTense.match(start, end, match) > 0)
    strnzcpy(mf.tense, start + match[1].first, match[1].second - match[1].first);

  // --- TODO ???
  // ...

  if (MorphExtract)
    // combine morphological features
    //sprintf(mf.full, "%s%s%s%s%s", mf.Case, mf.gender, mf.number, mf.person, mf.tense );
    strnzcpy(mf.full, start, end-start );
}

} // namespace Tanl
