﻿automat sg
{
 #define Adj( Name, Decl ) Name : ПРИЛАГАТЕЛЬНОЕ { paradigm Прил_##Decl }

 #define a5040( Name ) Name : ПРИЛАГАТЕЛЬНОЕ { paradigm Прил_5040 }
 #define a5041( Name ) Name : ПРИЛАГАТЕЛЬНОЕ { paradigm Прил_5041 }
 #define a5012( Name ) Name : ПРИЛАГАТЕЛЬНОЕ { paradigm Прил_5012 }

 // ******************************************************************* 
 // Сразу пометим пары небольшой-большой или несделанный-сделанный
 // В качестве аргумента - позитивная форма, негативная образуется
 // автоматически приставкой не-
 // ******************************************************************* 
 #define antonyms( A ) \
  #begin
   extern entry A : ПРИЛАГАТЕЛЬНОЕ
   extern entry НЕ##A : ПРИЛАГАТЕЛЬНОЕ
   link ПРИЛАГАТЕЛЬНОЕ:A{} <antonym> ПРИЛАГАТЕЛЬНОЕ:НЕ##A{}
  #end

a5041( аборальный )
a5041( авиаразведывательный )
a5041( аногенитальный )
a5041( антигемофильный )
a5041( антиматериальный )
a5041( антиобледенительный )
a5041( базальный )
a5041( базиликальный )
a5041( белокафельный )
a5041( бескапсюльный )
a5040( беспечальный )
a5040( бесприбыльный )
a5041( бесстебельный )
a5041( бесхлорофильный )
a5041( бихевиоральный )
a5041( богомольный )
a5041( бореальный )
a5041( брахицефальный )
a5041( бронхоплевральный )
a5041( буквослагательный )
a5041( бытописательный )
a5041( вакхальный )
a5041( верхнелатеральный )
a5041( весельный )
a5041( взаимодополнительный )
a5041( взаимоистребительный )
a5040( визуальный )
a5041( винодельный )
a5041( владетельный )
a5041( внутрибронхиальный )
a5041( внутрипарадигмальный )
a5041( волеизъявительный )
a5041( воскресительный )
a5041( воспоминательный )
a5041( воспринимательный )
a5041( восхвалительный )
a5041( врачевательный )
a5040( выжидательный )
a5041( газокалильный )
a5041( гантельный )
a5041( гастрокардиальный )
a5041( глазодвигательный )
a5041( глютеальный )
a5041( голоствольный )
a5041( гомолатеральный )
a5041( двухэскадрильный )
a5012( дебильный )
a5040( дискутабельный )
a5041( доавтомобильный )
a5041( дорсолатеральный )
a5040( достопримечательный )
a5040( достохвальный )
a5040( дуальный )
a5041( ебальный )
a5041( едальный )
a5041( единительный )
a5041( единораздельный )
a5041( жантильный )
a5041( желчевыделительный )
a5041( жизнедеятельный )
a5041( затыкательный )
a5041( зрительный )
a5040( изобразительный )
a5040( инкурабельный )
a5041( иноземельный )
a5040( интактильный )
a5041( интерконтинентальный )
a5041( интразональный )
a5041( интракорпоральный )
a5041( интраназальный )
a5041( интранатальный )
a5041( инфинитезимальный )
a5041( исправительный )
a5041( ишиоректальный )
a5041( кадрильный )
a5041( камеральный )
a5041( капитульный )
a5041( карамбольный )
a5041( караульный )
a5041( карнавальный )
a5041( касательный )
a5041( кивательный )
a5041( конгрегациональный )
a5041( консисториальный )
a5041( контекстуальный )
a5041( континентальный )
a5040( континуальный )
a5041( копательный )
a5041( костемольный )
a5041( крестоцеловальный )
a5041( кривоствольный )
a5041( круглошлифовальный )
a5041( курильный )
a5012( лабильный )
a5041( литеральный )
a5040( малодоказательный )
a5040( малочувствительный )
a5041( медеплавильный )
a5041( меркуриальный )
a5041( метропольный )
a5041( мукомольный )
a5040( надындивидуальный )
a5041( наствольный )
a5041( натальный )
a5041( нательный )
a5040( небанальный )
a5040( недвусмысльный )
a5040( неизвинительный )
a5041( нейросигнальный )
a5040( нелокальный )
a5040( нелюбознательный )
a5012( неодобрительный ) antonyms( одобрительный )
a5040( непоказательный )
a5040( непунктуальный )
a5040( несодержательный )
a5040( неэмоциональный )
a5041( оберегательный )
a5041( обливательный )
a5040( октагональный )
a5041( определительный )
a5041( осязательный )
a5041( отдыхательный )
a5040( ощутительный )
a5041( переднемедиальный )
a5041( периаксиальный )
a5041( перианальный )
a5041( периартериальный )
a5041( перикардиальный )
a5041( периневральный )
a5041( периуретральный )
a5041( перифокальный )
a5041( перцептуальный )
a5041( пинбольный )
a5041( плюральный )
a5040( подпольный )
a5040( позициональный )
a5040( полуутвердительный )
a5041( похмельный )
a5041( прегенитальный )
a5041( преддуэльный )
a5041( предындустриальный )
a5012( преизобильный )
a5012( преоригинальный )
a5040( принудительный )
a5041( провиденциальный )
a5040( противобактериальный )
a5041( противоистребительный )
a5040( протокольный )
a5041( пятибальный )
a5041( радетельный )
a5041( расстрельный )
a5041( рукодельный )
a5041( секвентальный )
a5041( семибальный )
a5041( стобальный )
a5041( страдательный )
a5041( сукновальный )
a5040( танцевальный )
a5041( темпоральный )
a5040( термостабильный )
a5041( тетрафторэтильный )
a5041( тетрахлорэтильный )
a5041( трихлорэтильный )
a5041( усладительный )
a5041( усыпительный )
a5041( фактуальный )
a5012( фертильный )
a5040( фрактальный )
a5041( фратриальный )
a5041( хлорфенольный )
a5041( ходульный )
a5041( хрустальный )
a5041( шестибальный )
a5041( ширяльный )
a5041( шноркельный )
a5041( эклиптикальный )
a5041( эпитаксиальный )
a5041( мультипарадигмальный )

}
