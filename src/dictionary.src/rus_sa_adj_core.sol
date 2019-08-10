﻿// *********************
// ПРИЛАГАТЕЛЬНОЕ
// *********************

patterns ГруппаПрил0 { language=Russian } export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ ТИП_ПРИЛ }

pattern ГруппаПрил0
{
 прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
}

// Порядковые прилагательные легко образуют сочетания через дефис:
// пятый-шестой день считается самым важным
// ^^^^^^^^^^^^
pattern ГруппаПрил0
{
 a1=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ ТИП_ПРИЛ:ПОРЯДК } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 t='-'
 a2=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ ТИП_ПРИЛ:ПОРЯДК =a1:ПАДЕЖ =a1:РОД =a1:ЧИСЛО }
} : links { a1.<RIGHT_LOGIC_ITEM>t.<NEXT_COLLOCATION_ITEM>a2 }
  : ngrams { 1 }



// Первичная (или проекционная) зона коры обеспечивает анализ и переработку информации, идущей от периферии — мышц, органов чувств, рецепторов внутренних органов и сосудов.
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил0
{
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 attr=Детализатор
} : links { a.<DETAILS>attr }
  : ngrams { -20 }



// ------------------------------------------------------------

patterns ПрефиксСоставногоПрил { language=Russian } export { node:root_node }

// Составные прилагательные:
// армяно-грузинские торгово-экономические связи
// ^^^^^^            ^^^^^^^
pattern ПрефиксСоставногоПрил
{
 prefix=ПРЕФИКС_СОСТАВ_ПРИЛ:*{} : export { node:root_node }
} : ngrams { 1 }

// Неизвестные префиксы тоже учтем, так как это крайне открытый и продуктивный класс слов.
pattern ПрефиксСоставногоПрил
{
 prefix=@regex("(.+)(О|Е)") : export { node:root_node }
} : ngrams { -2 }


// В составных прилагательных  могут быть цепочки
// "Смеси титано-тантало-вольфрамовые"
//        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ПрефиксСоставногоПрил
{
 prefix=ПРЕФИКС_СОСТАВ_ПРИЛ:*{}
 t='-'{ [-1]tokenizer_flag:word_conjunction }
 a=ПрефиксСоставногоПрил : export { node:root_node }
}
: links { a.<PREFIX_PARTICLE>t.<NEXT_COLLOCATION_ITEM>prefix }

wordentry_set НеВтораяЧастьПрил=прилагательное:{ тот }

pattern ГруппаПрил0
{
 prefix=ПрефиксСоставногоПрил
 t='-'{ tokenizer_flag:word_conjunction }
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ ~НеВтораяЧастьПрил } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ }
}
: links { a.<PREFIX_PARTICLE>t.<NEXT_COLLOCATION_ITEM>prefix }
: ngrams { 1 }


// Будет яркого, рыже - белого окраса.
//               ^^^^^^^^^^^^^
pattern ГруппаПрил0
{
 prefix=ПрефиксСоставногоПрил
 t='-'{ tokenizer_flag:word_separation }
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ ~НеВтораяЧастьПрил } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ }
}
: links { a.<PREFIX_PARTICLE>t.<NEXT_COLLOCATION_ITEM>prefix }
: ngrams { -1 }


       
// ---------------------------------------------------------------

// это случилось в далёкой-далёкой галактике
//                 ^^^^^^^^^^^^^^^
pattern ГруппаПрил0
{
 a1=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ }
 t='-'{ tokenizer_flag:word_conjunction }
 a2=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ =a1:ПАДЕЖ =a1:РОД =a1:ЧИСЛО =a1:ОДУШ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
} : links
{
 a2.<NEXT_COLLOCATION_ITEM>t.<NEXT_COLLOCATION_ITEM>a1
}
: ngrams { 1 }


// какие еще доказательства вам представить?
// ^^^^^^^^^
pattern ГруппаПрил0
{
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 m=наречие:еще{}
} : links { a.<ATTRIBUTE>m }
 : ngrams { -1 }


// она осталась все такой же быстрой
//              ^^^^^^^^^^^^
pattern ГруппаПрил0
{
 p1=частица:все{}
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 p2=частица:же{}
} : links { a.{ <PREFIX_PARTICLE>p1 <POSTFIX_PARTICLE>p2 } }
 : ngrams { 1 }


// Есть большая группа топонимов с окончаниями -СКИЙ.
// Проблема с ними состоит в том, что для многих из них есть омонимичный вариант
// существительного, а прилагательное вообще отсутствует в лексиконе.
// Из-за этого вариант прилагательного даже не рассматривается.
// Мы компенсируем этот просчет группой правил.
//
// Литва метит в лидеры Балтийского региона.
//                      ^^^^^^^^^^^
pattern ГруппаПрил0
{
 @regex_strict("[\\@А\\@Б\\@Й](.*)ского"){ class:ПРИЛАГАТЕЛЬНОЕ ПАДЕЖ:РОД } :export { node:root_node РОД ЧИСЛО:ЕД ПАДЕЖ:РОД ОДУШ:НЕОДУШ ТИП_ПРИЛ  }
}
: ngrams { 2 }

pattern ГруппаПрил0
{
 @regex_strict("[\\@А\\@Б\\@Й](.*)ского") :export { node:root_node РОД ЧИСЛО:ЕД ПАДЕЖ:РОД ОДУШ:НЕОДУШ ТИП_ПРИЛ  }
}
: ngrams { -1 }




// Информацию подтвердили и в Ангарском лесничестве.
//                            ^^^^^^^^^
pattern ГруппаПрил0
{
 @regex_strict("[\\@А\\@Б\\@Й](.*)ском"){ class:ПРИЛАГАТЕЛЬНОЕ ПАДЕЖ:ПРЕДЛ } :export { node:root_node РОД ЧИСЛО:ЕД ПАДЕЖ:ПРЕДЛ ОДУШ:НЕОДУШ ТИП_ПРИЛ  }
}
: ngrams { 2 }


pattern ГруппаПрил0
{
 @regex_strict("[\\@А\\@Б\\@Й](.*)ском") :export { node:root_node РОД ЧИСЛО:ЕД ПАДЕЖ:ПРЕДЛ ОДУШ:НЕОДУШ ТИП_ПРИЛ  }
}
: ngrams { -1 }



// ++++++++++++++++++++++++++++++++++++++++++++

pattern ПравАтрибНеопрМест
{
 наречие:угодно{} : export { node:root_node }
}

pattern ПравАтрибНеопрМест
{
 'попало' : export { node:root_node }
}


// по каким угодно причинам
// ^^^^^^^^^^^^^^^
pattern ГруппаПрил0
{
 a=прилагательное:какой { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 m=ПравАтрибНеопрМест
} : links { a.<ATTRIBUTE>m }
  : ngrams { -1 }

// из одного лишь желания отомстить?
//    ^^^^^^^^^^^
pattern ГруппаПрил0
{
 a=прилагательное:один { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 m=наречие:лишь{}
} : links { a.<ATTRIBUTE>m }
  : ngrams { -1 }



// какую бы песню сложил!
// ^^^^^^^^
pattern ГруппаПрил0
{
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 p=ЧастицаБы
} : links { a.<POSTFIX_PARTICLE>p }


// той ли дорогой возвращалась?
pattern ГруппаПрил0
{
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 p=частица:ли{}
} : links { a.<POSTFIX_PARTICLE>p }


// Такой-то студент просил вас позвонить ему
// ^^^^^^^^
pattern ГруппаПрил0
{
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 t='-'
 p=частица:то{}
} : links { a.<POSTFIX_PARTICLE>t.<NEXT_COLLOCATION_ITEM>p }






// вот такой был намек
// ^^^^^^^^^
pattern ГруппаПрил0
{
 p=частица:вот{}
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
} : links { a.<PREFIX_PARTICLE>p }

// такой вот был намек
// ^^^^^^^^^
pattern ГруппаПрил0
{
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 p=частица:вот{}
} : links { a.<POSTFIX_PARTICLE>p }



pattern ГруппаПрил0
{
 прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:ПРЕВОСХ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
}

// на этом же участке
//    ^^^^^^^
pattern ГруппаПрил0
{
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 p=частица:же{}
} : links { a.<POSTFIX_PARTICLE>p }

// по все той же причине
//    ^^^^^^^^^^
pattern ГруппаПрил0
{
 p=частица:всё{}
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 p2=частица:же{}
} : links { a.{
               <PREFIX_PARTICLE>p
               <POSTFIX_PARTICLE>p2
              }
          }


// с каких это пор дети стали летать на парашютах?
//   ^^^^^^^^^
pattern ГруппаПрил0
{
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 p=частица:это{}
}
: links { a.<POSTFIX_PARTICLE>p }
: ngrams { -1 }


pattern ГруппаПрил0
{
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:ПРЕВОСХ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 p=частица:же{}
} : links { a.<POSTFIX_PARTICLE>p }

// Однако не все разведданные были недостоверными
//        ^^^^^^
pattern ГруппаПрил0
{
 p=частица:не{}
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
} : links { a.<NEGATION_PARTICLE>p }

// Спускаясь, они заметили, что отвесная скала оказалась не такой уж и гладкой.
//                                                       ^^^^^^^^^^^
pattern ГруппаПрил0
{
 p=частица:не{}
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 x=частица:уж{}
} : links
{
 a.{
    <NEGATION_PARTICLE>p
    <POSTFIX_PARTICLE>x
   }
}


// ---------------------------------------------------------

// Эти прилагательные не могут модифицироваться наречиями
wordentry_set CanAdjModifByAdv=прилагательное:{ этот, тот, наш, ваш, твой, мой }


// квартира выглядела абсолютно пустой.
//                    ^^^^^^^^^^^^^^^^
pattern ГруппаПрил0
{
 adv=ГруппаНареч1{ ~CannotAdvModifAdj [-5]ТИП_МОДИФ:ПРИЛ }
 adj=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ ~CanAdjModifByAdv } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
}
: links { adj.<ATTRIBUTE>adv }
: ngrams
{
 adv_adj_score(adv,adj)
 ВалентностьПрил(adj)
}



wordentry_set НаречДляЭтот=наречие:{ именно, только, лишь }

// Прилагательные ЭТОТ, ТОТ могут присоединять некоторые наречия:
// однако ж увижу перед глазами именно эти знаки.
pattern ГруппаПрил0
{
 adv=НаречДляЭтот
 adj=прилагательное:этот{} :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
}
: links { adj.<ATTRIBUTE>adv }


pattern ГруппаПрил0
{
 adv=НаречДляЭтот
 adj=прилагательное:тот{} :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
}
: links { adj.<ATTRIBUTE>adv }


wordentry_set НаречДляОдин=наречие:{ всего, лишь, именно, только }

// а им нужен был всего один.
//                ^^^^^^^^^^
pattern ГруппаПрил0
{
 adv=НаречДляОдин
 adj=прилагательное:один{} :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
}
: links { adj.<ATTRIBUTE>adv }


wordentry_set НаречиеПолностью=наречие:{ полностью, целиком }
wordentry_set ПритяжПрилагМестоим=прилагательное:{ мой, наш, твой, ваш }

// была ли она полностью моей
//             ^^^^^^^^^^^^^^
pattern ГруппаПрил0
{
 adv=НаречиеПолностью
 adj=ПритяжПрилагМестоим :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
}
: links { adj.<ATTRIBUTE>adv }



// довольная покупками жена была крайне разговорчива
// ^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил0
{
 a=прилагательное:* { ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ~ПРИЧАСТИЕ ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 obj=ГлДополнение{ =ПАДЕЖ->a:ПАДЕЖВАЛ }
} : links { a.<OBJECT>obj }
  : ngrams { -1 }


// очень довольный результатом бегун пошел к трибунам
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил0
{
 mod=ГруппаНареч1{ ~CannotAdvModifAdj [-1]ТИП_МОДИФ:ПРИЛ }
 a=прилагательное:* { ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ~ПРИЧАСТИЕ ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
 obj=ГлДополнение{ =ПАДЕЖ->a:ПАДЕЖВАЛ }
}
: links
{
 a.{
    <ATTRIBUTE>mod
    <OBJECT>obj
   }
}
: ngrams
{
 -1
 ВалентностьПрил(a)
}


pattern ГруппаПрил0
{
 mod=ГруппаНареч1{ [-1]ТИП_МОДИФ:ПРИЛ }
 a=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
}
: links { a.<ATTRIBUTE>mod }
: ngrams { -10 }


// ------------------------------------------------------------

// Левый объект, подчиненный "переходному" прилагательному:
// так человек поступает с себе подобными
//                         ^^^^^^^^^^^^^^

patterns ЛевыйОбъектДляПрил export { node:root_node ПАДЕЖ }

pattern ЛевыйОбъектДляПрил
{
 СамПрефикс : export { node:root_node ПАДЕЖ }
}

pattern ЛевыйОбъектДляПрил
{
 МестоимСПостфиксом : export { node:root_node ПАДЕЖ }
}

pattern ЛевыйОбъектДляПрил
{
 УказМест : export { node:root_node ПАДЕЖ }
}

pattern ЛевыйОбъектДляПрил
{
 Сущ0 : export { node:root_node ПАДЕЖ }
}


pattern ГруппаПрил0
{
 obj=ЛевыйОбъектДляПрил
 a=прилагательное:* { ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ~ПРИЧАСТИЕ ~КРАТКИЙ =ПАДЕЖВАЛ->obj:ПАДЕЖ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ ТИП_ПРИЛ  }
}
: links { a.<OBJECT>obj }
: ngrams { -5 }



// ------------------------------------------------------------




pattern ГруппаПрил1
{
 ГруппаПрил0 :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
}


// ох какая женщина стала!
// ^^^^^^^^
pattern ГруппаПрил1
{
 p=частица:*{}
 a=ГруппаПрил1:export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ } 
}
: links { a.<PREFIX_PARTICLE>p }
: ngrams { -10 }



// прячась от всех тех глаз
//            ^^^^^^^^
pattern ГруппаПрил1
{
 adj=прилагательное:весь{}
 a2=ГруппаПрил1{ =Adj:ЧИСЛО =Adj:ПАДЕЖ =Adj:РОД =Adj:ОДУШ } : export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
} : links { a2.<NEXT_ADJECTIVE>adj }


// Дефолтное правило - связываем два прилагательных без проверки согласования
pattern ГруппаПрил1
{
 adj=прилагательное:*{}
 a2=ГруппаПрил1 : export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}
: links { a2.<NEXT_ADJECTIVE>adj }
: ngrams { -10 }




// ты холодный как рыба!
//    ^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил1
{
 a=ГруппаПрил0 :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 comp=наречие:как{}
 n=ГлДополнение{ ПАДЕЖ:ИМ }
}
: links { a.<ATTRIBUTE>comp.<OBJECT>n }
: ngrams { 1 }




// аналитические конструкции для прилагательных

// этот боец применяет один и тот же прием снова и снова
//                     ^^^^^^^^^^^^^
pattern ГруппаПрил1
{
 @mark(прилагательное:один{},A1):export { РОД ЧИСЛО ПАДЕЖ ОДУШ node:root_node }
 conj=союз:и{}
 a2=прилагательное:тот{ =A1:ЧИСЛО =A1:РОД =A1:ПАДЕЖ }
 p=частица:же{}
} : links
{
 a1.<RIGHT_LOGIC_ITEM>conj.<NEXT_COLLOCATION_ITEM>a2.<POSTFIX_PARTICLE>p
}
: ngrams { 1 }


// этот боец берет то же самое оружие снова и снова
//                 ^^^^^^^^^^^
pattern ГруппаПрил1
{
 @mark(прилагательное:тот{},A1)
 p=частица:же{}
 a2=прилагательное:самый{ =A1:ЧИСЛО =A1:РОД =A1:ПАДЕЖ }:export { РОД ЧИСЛО ПАДЕЖ ОДУШ node:root_node }
} : links
{
 a2.<ATTRIBUTE>a1.<POSTFIX_PARTICLE>p
}


// -------------------------------------------------------------------------------------

wordentry_set ЧислДляПорядкПрил0={
 числительное:двадцать{},
 числительное:тридцать{},
 числительное:сорок{},
 числительное:пятьдесят{},
 числительное:шестьдесят{},
 числительное:семьдесят{},
 числительное:восемьдесят{},
 числительное:девяносто{},
 числительное:сто{},
 числительное:двести{},
 числительное:триста{},
 числительное:четыреста{},
 числительное:пятьсот{},
 числительное:шестьсот{},
 числительное:семьсот{},
 числительное:восемьсот{},
 числительное:девятьсот{},
 существительное:тысяча{},
 существительное:миллион{},
 существительное:миллиард{}
}


// Ответь Двадцать первому.
//        ^^^^^^^^^^^^^^^^
pattern ГруппаПрил1
{
 num=ГруппаЧисл{ ЧислДляПорядкПрил0 }
 adj=прилагательное:*{ ТИП_ПРИЛ:ПОРЯДК }:export { РОД ЧИСЛО ПАДЕЖ ОДУШ node:root_node }
}
: links { adj.<ATTRIBUTE>num }
: ngrams { 1 }


// -------------------------------------------------------------------------------------


// -----------------------------------------
// Модальные конструкции прилагательного:
// -----------------------------------------

patterns МодалПолнПрил00 export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
pattern МодалПолнПрил00
{
 прилагательное:*{ ~КРАТКИЙ МОДАЛЬНЫЙ }:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

pattern МодалПолнПрил00
{
 n=частица:не{}
 a=прилагательное:*{ ~КРАТКИЙ МОДАЛЬНЫЙ }:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
} : links { a.<NEGATION_PARTICLE>n }


patterns МодалПолнПрил0 export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
pattern МодалПолнПрил0
{
 МодалПолнПрил00:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

pattern МодалПолнПрил0
{
 q1=ОткрывающаяКавычка
 a=МодалПолнПрил00:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 q2=ЗакрывающаяКавычка
} : links
{
 a.{
    <PREPEND_QUOTE>q1
    <APPEND_QUOTE>q2
   }
}

// уже способный летать недалеко от земли аппарат
// ^^^^^^^^^^^^^
pattern МодалПолнПрил0
{
 adv=ГруппаНареч1{ ~CannotAdvModifAdj [-1]ТИП_МОДИФ:ПРИЛ }
 adj=МодалПолнПрил0 :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
}
: links { adj.<ATTRIBUTE>adv }
: ngrams
{
 adv_adj_score(adv,adj)
 ВалентностьПрил(adj)
}




// способный летать недалеко от земли аппарат
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// организм, способный заменить приматов
//           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил1
{
 adj=МодалПолнПрил0:export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 inf=Инф2
} : links { adj.<INFINITIVE>inf }


// -------------------------------------------------




// -------------------------------------------------






// Конструкция, похожая на элективную, но с обычным прилагательным:
//
// иные из них работают
// ^^^^^^^^^^^
pattern ГруппаПрил1
{
 a=ГруппаПрил0 :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 p=предлог:из{}
 n=РодДополнение
}
: links { a.<PREPOS_ADJUNCT>p.<OBJECT>n }
: ngrams { -1 }




// Его кожа стала серо-синей, как у трупа.
//                ^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил1
{
 a=ГруппаПрил0 :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 comma=','
 comp=наречие:как{}
 n=ПредлогИСущ
} : links { a.<ATTRIBUTE>comp.{
                               <PUNCTUATION>comma
                               <OBJECT>n
                              } }

/*
 // В то же время были и другие данные об арсенале
 //                    ^^^^^^^^
 pattern ГруппаПрил1
 {
  p=частица:и{}
  a=ГруппаПрил1:export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ } 
 } : ngrams { -2 }
*/


 // Переливчатые «радужные» цвета мыльных пузырей
 //              ^^^^^^^^^^
 pattern ГруппаПрил1
 {
  q1=ОткрывающаяКавычка
  a=ГруппаПрил1 :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
  q2=ЗакрывающаяКавычка
 } : links
 {
  a.{
     <PREPEND_QUOTE>q1
     <APPEND_QUOTE>q2
    }
 }


 pattern ГруппаПрил1
 {
  adv=наречие:еще{}
  adj=прилагательное:один{} :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 } : links { adj.<ATTRIBUTE>adv }
   : ngrams { 2 }


 // Особый случай для местоимения ТОТ - модификация наречием ВОН
 // вон тот корм
 pattern ГруппаПрил1
 {
  adv=наречие:вон{}
  adj=прилагательное:тот {} :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 } : links { adj.<ATTRIBUTE>adv }
   : ngrams { 1 }


 // Особый случай для местоимения ЭТОТ - модификация частицей ВОТ
 // вот этот корм
 pattern ГруппаПрил1
 {
  adv=частица:вот{}
  adj=прилагательное:этот {} :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 } : links { adj.<ATTRIBUTE>adv }
   : ngrams { 1 }

 // вот та каша
 pattern ГруппаПрил1
 {
  adv=частица:вот{}
  adj=прилагательное:тот {} :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 } : links { adj.<ATTRIBUTE>adv }
   : ngrams { 1 }





// ******************************
// Аналитический компаратив
// ******************************

wordentry_set ПрилБезКомпарат=прилагательное:{ весь, этот, тот, каждый, любой, один }
wordentry_set БолееМенее=наречие:{ более, менее }
 
patterns МодификаторКомпаратПрил export { node:root_node }


patterns ГруппаСрНареч1 export { node:root_node }
//patterns ГруппаСрНареч2 export { node:root_node }

// Дайте мне более интересное задание
//           ^^^^^^^^^^^^^^^^
// Он получил менее интересное задание
//            ^^^^^^^^^^^^^^^^
// А кое-где сидели  не  менее  пьяные  женщины.
//                   ^^^^^^^^^^^^^^^^^
pattern МодификаторКомпаратПрил
{
 ГруппаСрНареч2{ БолееМенее } : export { node:root_node }
}
: ngrams { 1 }


// Наречие КУДА, как ни странно, употребляется как
// модификатор для БОЛЕЕ/МЕНЕЕ:
//
// она нашла нечто куда более интересное!
//                 ^^^^^^^^^^
pattern МодификаторКомпаратПрил
{
 adv0=наречие:куда{}
 adv=БолееМенее : export { node:root_node }
}
: links { adv.<ATTRIBUTE>adv0 }
: ngrams { 1 }


// Гонка вооружений в Азии становится все более интенсивной
//                                    ^^^^^^^^^^^^^^^^^^^^^
pattern МодификаторКомпаратПрил
{
 p=частица:всё{}
 adv=БолееМенее : export { node:root_node }
}
: links { adv.<PREFIX_PARTICLE>p }
: ngrams { 1 }


wordentry_set МодифБолееМенее=наречие:{
существенно,
ощутимо,
еще, // действовать еще более отчаянно
немного, // действовать немного более аккуратно
чуточку, // надавить чуточку более аккуратно
'чуть-чуть', // взлететь чуть-чуть более высоко
слегка, // закричать слегка более тонко
намного, // блюдо получилось намного более острым.
немножко, // запеть немножко менее громко
несравненно, // Были стадии несравненно более разряженной материи.
немножечко // запеть немножечко менее громко
}


// Аналитическая конструкция компаратива с дополнительным модификатором
// блюдо получилось намного более острым.
//                  ^^^^^^^
pattern МодификаторКомпаратПрил
{
 mod=МодифБолееМенее
 adv=БолееМенее : export { node:root_node }
}
: links { adv.<ATTRIBUTE>mod }
: ngrams { 4 }



// освещение становилось все более слабым.
//                       ^^^^^^^^^^^^^^^^
pattern ГруппаПрил1
{
 adv=МодификаторКомпаратПрил
 adj=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ ~ПрилБезКомпарат } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
}
: links { adj.<ATTRIBUTE>adv }
: ngrams { 2 }


// -----------------------------------


 pattern ГруппаПрил1
 {
  прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:ПРЕВОСХ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 }

 pattern ГруппаПрил1
 {
  adv=ГруппаНареч1{ ~CannotAdvModifAdj [-1]ТИП_МОДИФ:ПРИЛ}
  adj=прилагательное:* { ~КРАТКИЙ СТЕПЕНЬ:ПРЕВОСХ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 } : links { adj.<ATTRIBUTE>adv }
 : ngrams
 {
  adv_adj_score(adv,adj)
 }


 wordentry_set НаречДляПрилЖе = 
 {
  наречие:точно{},
  наречие:абсолютно{}
 }

 // для паттернов типа "звезда ТОГО ЖЕ спектрального типа"
 pattern ГруппаПрил1
 {
  adj=прилагательное:тот { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
  p=частица:же{}
 } : links { adj.<POSTFIX_PARTICLE>p }


 // для паттернов типа "звезда такого же спектрального типа"
 pattern ГруппаПрил1
 {
  adv=@optional(НаречДляПрилЖе)
  adj=прилагательное:такой { ~КРАТКИЙ СТЕПЕНЬ:АТРИБ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
  p=частица:же{}
 } : links {
            adj.{
                 ~<ATTRIBUTE>adv
                 <POSTFIX_PARTICLE>p
                }
           }
 : ngrams
 {
  adv_adj_score(adv,adj)
 }


 // Предложное дополнение может присоединяться к прилагательному:
 // ее голос был тусклым от усталости.
 //              ^^^^^^^^^^^^^^^^^^^^
 wordentry_set ПредлогДляПрил=предлог:{ от, для, "из-за", с, к }

 pattern ГруппаПрил1
 {
  a=прилагательное:* { ~КРАТКИЙ ~СТЕПЕНЬ:СРАВН ~ТИП_ПРИЛ:ПРИТЯЖ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
  p=ПредлогДляПрил
  n=ГлДополнение{ =p:ПАДЕЖ }
 } : links
 {
  a.<PREPOS_ADJUNCT>p.<OBJECT>n
 }
 : ngrams
 {
  -5
  ВалентностьПрил(a)
 }

 
// это делало их похожими на насекомых.
//               ^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил1
{
 a=прилагательное:* { ~КРАТКИЙ ~СТЕПЕНЬ:СРАВН ~ТИП_ПРИЛ:ПРИТЯЖ } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 p=предлог:на{}
 n=ГлДополнение{ ПАДЕЖ:ВИН }
} : links
{
 a.<PREPOS_ADJUNCT>p.<OBJECT>n
}
: ngrams
{
 -5
 ВалентностьПрил(a)
}



 // кто-то очень необычный для этих мест
 //        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 pattern ГруппаПрил1
 {
  adv=ГруппаНареч1{ ~CannotAdvModifAdj [-1]ТИП_МОДИФ:ПРИЛ}
  a=прилагательное:* { ~КРАТКИЙ ~СТЕПЕНЬ:СРАВН } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
  p=ПредлогДляПрил
  n=ГлДополнение{ =p:ПАДЕЖ }
 } : links
 {
  a.{
     <PREPOS_ADJUNCT>p.<OBJECT>n
     <ATTRIBUTE>adv
    }
 }
 : ngrams
 {
  -5
  ВалентностьПрил(a)
 }


 // создал межведомственную стратегическую группу по украинско-российским отношениям
 //                                                  ^^^^^^^^^^^^^^^^^^^^
 pattern ГруппаПрил1
 {
  prefix=@regex("[\\@а\\@б\\@й]*[\\@б]о")
  tire='-'{ tokenizer_flag:word_conjunction }
  a=прилагательное:* { ~КРАТКИЙ ~СТЕПЕНЬ:СРАВН } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 } : links
 {
  a.<PUNCTUATION>tire.<NEXT_COLLOCATION_ITEM>prefix
 }





 
wordentry_set СравнитПрил=прилагательное:{ такой }

// Пусть жизнь  молодых будет такой же сладкой, как хлеб, испеченный к их свадьбе
//                            ^^^^^^^^^^^^^^^^^^^^^^^^....
pattern ГруппаПрил1
{
 a=ГруппаПрил0{ СравнитПрил } :export { node:root_node РОД ЧИСЛО ПАДЕЖ ОДУШ }
 p=частица:же{}
 a2=ГруппаПрил2{ =a:ПАДЕЖ =a:ЧИСЛО =a:РОД }
 comma1=','
 comp=наречие:как{}
 n=ГлДополнение{ ПАДЕЖ:ИМ }
 @noshift(ПравыйОграничительОборота)
 comma2=@coalesce(',')
} : links
{
 a.{
    <POSTFIX_PARTICLE>p
    <RIGHT_LOGIC_ITEM>a2
    <RIGHT_COMPARISON_Y>comma1.
     <NEXT_COLLOCATION_ITEM>comp.
      <OBJECT>n.
       ~<PUNCTUATION>comma2
   }
}
: ngrams { 6 }




// ---------------------------------------------------------------------------------
// ПЕРЕХОДНЫЕ ПРИЛАГАТЕЛЬНЫЕ
// Они похожи на причастия тем,
// что могут управлять существительным-дополнением. Но отличаются некоторыми
// другими аспектами, например краткая форма может присоединять родительный падеж:
//
// холл был полон людей
// ---------------------------------------------------------------------------------
patterns ПерехПрил export { node:root_node РОД ЧИСЛО ПАДЕЖ ПАДЕЖВАЛ КРАТКИЙ }

pattern ПерехПрил
{
 прилагательное:*{ ~ПРИЧАСТИЕ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ }:export{ node:root_node РОД ЧИСЛО ПАДЕЖ ПАДЕЖВАЛ КРАТКИЙ }
}

patterns Нареч0 { language=Russian } export { СТЕПЕНЬ ТИП_МОДИФ node:root_node }

pattern ПерехПрил
{
 adv=Нареч0{ степень:атриб ~CannotAdvModifAdj }
 a=прилагательное:*{ ~ПРИЧАСТИЕ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ }:export{ node:root_node РОД ЧИСЛО ПАДЕЖ ПАДЕЖВАЛ КРАТКИЙ }
}
: links { a.<ATTRIBUTE>adv }
: ngrams { adv_adj_score(adv,a) }

pattern ПерехПрил
{
 n=частица:не{}
 a=прилагательное:*{ ~ПРИЧАСТИЕ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ }:export{ node:root_node РОД ЧИСЛО ПАДЕЖ ПАДЕЖВАЛ КРАТКИЙ }
} : links { a.<NEGATION_PARTICLE>n }

pattern ПерехПрил
{
 a=прилагательное:*{ ~ПРИЧАСТИЕ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ }:export{ node:root_node РОД ЧИСЛО ПАДЕЖ ПАДЕЖВАЛ КРАТКИЙ }
 p=частица:ли{}
} : links { a.<POSTFIX_PARTICLE>p }

pattern ПерехПрил
{
 a=прилагательное:*{ ~ПРИЧАСТИЕ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ }:export{ node:root_node РОД ЧИСЛО ПАДЕЖ ПАДЕЖВАЛ КРАТКИЙ }
 p=частица:же{}
} : links { a.<POSTFIX_PARTICLE>p }


// -------------------------------------------------------

 patterns КраткПрил0 export { node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }


 // продолжающиеся переговоры обнадеживающи
 //                           ^^^^^^^^^^^^^
 pattern КраткПрил0
 {
  прилагательное:*{ КРАТКИЙ }:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 }

 // Совместимы ли мракобесие и инновации?
 // ^^^^^^^^^^^^^
 pattern КраткПрил0
 {
  a=прилагательное:*{ КРАТКИЙ }:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
  p=частица:ли{}
 } : links { a.<POSTFIX_PARTICLE>p }


 // Какова бы она ни была.
 // ^^^^^^^^^
 pattern КраткПрил0
 {
  a=прилагательное:*{ КРАТКИЙ }:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
  p=ЧастицаБы
 } : links { a.<POSTFIX_PARTICLE>p }

 // Какова же она была
 // ^^^^^^^^^
 pattern КраткПрил0
 {
  a=прилагательное:*{ КРАТКИЙ }:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
  p=ЧастицаЖе
 } : links { a.<POSTFIX_PARTICLE>p }

 // Сильна-то была она?
 // ^^^^^^^^^
 pattern КраткПрил0
 {
  a=прилагательное:*{ КРАТКИЙ }:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
  t='-'
  x=частица:то{}
 } : links { a.<POSTFIX_PARTICLE>t.<NEXT_COLLOCATION_ITEM>x }
 

patterns КраткПрил1 export { node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }

 // Какова она была?
 pattern КраткПрил1
 {
  КраткПрил0:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 }


 // В ходе обыска были вновь "обнаружены" боеприпасы.
 //                          ^^^^^^^^^^^^
 pattern КраткПрил1
 {
  q1=ОткрывающаяКавычка
  x=КраткПрил0:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
  q2=ЗакрывающаяКавычка
 } : links
 {
  x.{
     <PREPEND_QUOTE>q1
     <APPEND_QUOTE>q2
    }
 }



 // Особый случай - "переходные прилагательные". Они похожи на причастия тем,
 // что могут управлять существительным-дополнением. Но отличаются некоторыми
 // другими аспектами, например краткая форма может присоединять родительный падеж:
 //
 // холл был полон людей
 pattern КраткПрил1 export { node:root_node РОД ЧИСЛО (ПРИЧАСТИЕ) (СТРАД) (ПАДЕЖВАЛ) (ПЕРЕХОДНОСТЬ) }
 {
  a=ПерехПрил{ КРАТКИЙ }:export{ node:root_node РОД ЧИСЛО }
  obj=ГлДополнение{ =ПАДЕЖ->a:ПАДЕЖВАЛ }
 } : links { a.<OBJECT>obj }

 // прямое дополнение может стоять перед прилагательным:
 // мне очень нужна твоя помощь
 pattern КраткПрил1 export { node:root_node РОД ЧИСЛО (ПРИЧАСТИЕ) (СТРАД) (ПАДЕЖВАЛ) (ПЕРЕХОДНОСТЬ) }
 {
  obj=ГлДополнение
  adv=@optional( Нареч0{ степень:атриб ~CannotAdvModifAdj } )
  a=ПерехПрил{ КРАТКИЙ =ПАДЕЖВАЛ->obj:ПАДЕЖ }:export{ node:root_node РОД ЧИСЛО }
 } : links
 {
  a.{
     <OBJECT>obj
     ~<ATTRIBUTE>adv
    }
 }
 : ngrams { adj_obj_score(a,obj) }

 // На случай, если дополнение оторвано от управляющего прилагательного:
 // ему было приятно ее присутствие
 //          ^^^^^^^
 pattern КраткПрил1 export { node:root_node РОД ЧИСЛО (ПРИЧАСТИЕ) (СТРАД) (ПАДЕЖВАЛ) (ПЕРЕХОДНОСТЬ) }
 {
  ПерехПрил{ КРАТКИЙ }:export{ node:root_node РОД ЧИСЛО }
 }




 // очень холодно
 pattern КраткПрил1
 {
  adv=Нареч0{ степень:атриб ~CannotAdvModifAdj }
  adj=КраткПрил0:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 } : links { adj.<ATTRIBUTE>adv }
   : ngrams { adv_adj_score(adv,adj) }

 // теперь старый волк был более осторожен.
 //                        ^^^^^^^^^^^^^^^
 pattern КраткПрил1
 {
  adv=БолееМенее
  adj=КраткПрил0:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 } : links { adj.<ATTRIBUTE>adv }
 
 // наша техника куда более  совершенна.
 pattern КраткПрил1
 {
  adv0=наречие:куда{}
  adv=БолееМенее
  adj=КраткПрил0:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 }
 : links { adj.<ATTRIBUTE>adv.<ATTRIBUTE>adv0 }
 : ngrams { 1 }

 // теперь старый волк будет намного более осторожен
 pattern КраткПрил1
 {
  mod=МодифБолееМенее
  adv=БолееМенее
  adj=КраткПрил0:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 } : links { adj.<ATTRIBUTE>adv.<ATTRIBUTE>mod }



 // столь же прост
 pattern КраткПрил1
 {
  adv=Нареч0{ степень:атриб ~CannotAdvModifAdj }
  p=частица:же{}
  adj=КраткПрил0:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 } : links { adj.<ATTRIBUTE>adv.<POSTFIX_PARTICLE>p }
   : ngrams { adv_adj_score(adv,adj) }
 

 // день был хорош для охоты.
 //          ^^^^^^^^^^^^^^^
 pattern КраткПрил1
 {
  a=КраткПрил0 :export { node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
  p=ПредлогДляПрил
  n=ГлДополнение{ =p:ПАДЕЖ }
 } : links
 {
  a.<PREPOS_ADJUNCT>p.<OBJECT>n
 }
 : ngrams
 {
  -2
  ВалентностьПрил(a)
 }

 // этот мир был чересчур мал для них обоих.
 //              ^^^^^^^^^^^^^^^^^^^^^^^^^^
 pattern КраткПрил1
 {
  adv=ГруппаНареч1{ ~CannotAdvModifAdj [-1]ТИП_МОДИФ:ПРИЛ}
  a=КраткПрил0 :export { node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
  p=ПредлогДляПрил
  n=ГлДополнение{ =p:ПАДЕЖ }
 } : links
 {
  a.{
     <PREPOS_ADJUNCT>p.<OBJECT>n
     <ATTRIBUTE>adv
    }
 }
 : ngrams
 {
  -2
  adv_adj_score(adv,a)
  ВалентностьПрил(a)
 }




 // почему вы так одеты?
 wordentry_set ОсобМодифКратк=наречие:{ так }
 pattern КраткПрил1
 {
  adv=Нареч0{ степень:атриб ОсобМодифКратк }
  adj=КраткПрил0:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 } : links { adj.<ATTRIBUTE>adv }

 // не уверен
 pattern КраткПрил1
 {
  n=частица:не{}
  a=прилагательное:*{ КРАТКИЙ }:export{ node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 } : links { a.<NEGATION_PARTICLE>n }

 // не очень благонадежен
 pattern КраткПрил1
 {
  n=частица:не{}
  adv=Нареч0{ степень:атриб ~CannotAdvModifAdj }
  adj=КраткПрил0:export { node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 } : links
 {
  adj.<ATTRIBUTE>adv.<NEGATION_PARTICLE>n
 }


wordentry_set СопоставлНаречПрил=наречие:{ столь, так }
// Шифр был столь же прост, как пароль
//          ^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern КраткПрил1
{
 mod=ГруппаНареч1{ СопоставлНаречПрил [-1]ТИП_МОДИФ:ПРИЛ}
 p=частица:же{}
 a=КраткПрил0 : export { node:root_node РОД ЧИСЛО ПРИЧАСТИЕ СТРАД ПАДЕЖВАЛ ПЕРЕХОДНОСТЬ }
 comma1=','
 comp=наречие:как{}
 n=ГлДополнение{ ПАДЕЖ:ИМ }
 @noshift(ПравыйОграничительОборота)
 comma2=@coalesce(',')
} : links
{
 a.{
    <ATTRIBUTE>mod.<POSTFIX_PARTICLE>p
    <RIGHT_COMPARISON_Y>comma1.
     <NEXT_COLLOCATION_ITEM>comp.
      <OBJECT>n.
       ~<PUNCTUATION>comma2
   }
}
: ngrams { 3 }

