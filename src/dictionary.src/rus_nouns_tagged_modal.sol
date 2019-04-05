﻿// -----------------------------------------------------------------------------
// File RUS_NOUNS_TAGGED_MODAL.SOL
//
// (c) Koziev Elijah
//
// Лексикон - определения имен существительных.
// Добавлен тэг модальности для слов ВОЗМОЖНОСТЬ, ГОТОВНОСТЬ, СПОСОБНОСТЬ и др.
//
// 05.04.2010 - внес привычка, манера, привилегия (привычка говорить, манера
//              двигаться, привилегия сидеть в присутствии короля)
// -----------------------------------------------------------------------------
//
// CD->26.03.2009
// LC->20.10.2018
// --------------

#include "sg_defs.h"

automat sg
{
 // *********************************************************************************
 // Макрос добавляет признак 'управляет инфинитивом'
 // Например - существительное ВОЗМОЖНОСТЬ допускает конструкции
 // типа 'ВОЗМОЖНОСТЬ ИГРАТЬ'
 // *********************************************************************************
 #define модальный(Сущ) tag СУЩЕСТВИТЕЛЬНОЕ:Сущ { МОДАЛЬНЫЙ }

 модальный(ВОЗМОЖНОСТЬ)
 модальный(ГОТОВНОСТЬ)
 модальный(неготовность)
 модальный(НЕСПОСОБНОСТЬ)
 модальный(СПОСОБНОСТЬ)
 модальный(НЕЖЕЛАНИЕ)
 модальный(НЕУМЕНИЕ)
 модальный(УМЕНИЕ)
 модальный(ЖЕЛАНИЕ)
 модальный(разрешение)
 модальный(рекомендация)
 модальный(попытка)
 модальный(отказ)
 модальный(решение)
 модальный(повод)
 модальный(причина)
 модальный(время)
 модальный(шанс)
 модальный(желание)
 модальный(намерение)
 модальный(вероятность)
 модальный(манера)
 модальный(привычка)
 модальный(привилегия)
 модальный(угроза)
 модальный(пора) // настала пора принимать решение.
 модальный(способ) // прекрасный способ очистить территорию.
 модальный(мысль) // мелькнула мысль попытаться спрятаться.
 модальный(жажда) // жажда убить достигла предела.
 модальный(очередь) // настала моя очередь смеяться
 модальный(страх) // страх оказаться безработным
 модальный(предложение) // предложение отобедать было отвергнуто
 модальный(основание) // а между тем основания торопиться у них были.
 модальный(смысл) // есть смысл получать удовольствие.
 модальный( ПРАВО ) // твои дети имеют право сделать собственный выбор.
 модальный( КЛЯТВА ) // дали тогда клятву отомстить.
 модальный( ПОТРЕБНОСТЬ ) // у них возникла потребность попытаться еще раз найти общий язык друг с другом.
 модальный( обещание )
 модальный(РЕШИМОСТЬ) // но постепенно к нему вернулась решимость узнать о городе все. 
 модальный(ИНСТИНКТ) // у тебя есть инстинкт убивать.
 модальный(ТАЛАНТ) // у него был талант делать деньги.
 модальный(ЗАДАНИЕ) // ему дали задание уничтожать другие автоматы.
 модальный(СВОЙСТВО) // Чесноку приписывалось свойство прогонять ведьм, нечистых духов и болезни
 модальный(СИГНАЛ) // это был сигнал начинать еду
 модальный(ОСНОВАНИЕ) // тогда бы ты имел основания беспокоиться
 модальный(МУЖЕСТВО) // ты дал мне мужество идти дальше
 модальный(СОГЛАСИЕ) // их согласие отпустить вас решит все
 модальный(ИДЕЯ) // идея обратиться к нему принадлежала девушке
 модальный(НАСТРОЕНИЕ) // у тебя есть настроение слушать?
 модальный(СИЛА) // тогда дай сил вынести все это!
 модальный(СТРЕМЛЕНИЕ) // Среди евреев, живших в диаспоре, всегда было распространено сильное стремление возвратиться к Сиону
 модальный(РАСПОРЯЖЕНИЕ) //  мы получили распоряжение производить
 модальный(ПРОСЬБА) //  авиакомпании обратились с просьбой принять их самолеты
 модальный(ЗАДАЧА) //  Перед правительством поставлена задача навести порядок в сфере контроля за расходованием средств
 модальный(ПОРУЧЕНИЕ) //  поручение разработать стимулирующие меры
 модальный(НАМЕРЕНИЕ) //  упомянул о намерении команды приобрести несколько новых футболистов
 модальный(РЕШЕНИЕ) //  от решения правительства докапитализировать банки
 модальный(НУЖДА) // нам нет нужды драться
 модальный(тенденция) // они имеют тенденцию делать
 модальный(ОБЯЗАННОСТЬ) // Россиян освободят от обязанности сообщать данные счетчиков (ОБЯЗАННОСТЬ - модальный)
 модальный(НАДЕЖДА) // мои надежды найти здесь пищу исчезли (НАДЕЖДА модальный)
 модальный(СМЕЛОСТЬ) // не набрался смелости с ней познакомиться (СМЕЛОСТЬ модальное)
 модальный(МОМЕНТ) // теперь наступил момент действовать (МОМЕНТ - модальное)
 модальный(знак) // она сделала ему знак подождать. (знак-модальный)
 модальный(ОХОТА) // у него явно пропала всякая охота возражать (ОХОТА модальное)
 модальный(ВЛАСТЬ) // у меня нет власти делать чудеса! (ВЛАСТЬ модальное)
 модальный(СРЕДСТВО) // есть средство освободиться от рук этих рыцарей (СРЕДСТВО - модальное)
 модальный(ДАР) // у нее великий дар творить зеркала (ДАР модальное)
 модальный(ЛЮБИТЕЛЬ) // Красочная документальная лента для любителей увидеть загадочные глубины моря, не отрываясь от своего дивана (ЛЮБИТЕЛЬ модальное)
 модальный(ЗАТЕЯ) // Очевидно, они отказались от затеи найти его.
 модальный(ИСКУШЕНИЕ) // У него возникло искушение отклониться от намеченного маршрута
 модальный(НЕОХОТА) // Вольф подумал о ее неохоте говорить о неприятном.
 модальный(ПРИГЛАШЕНИЕ) // это означало приглашение сесть
 модальный(возможность) // существовало две возможности достать лошадей.
 модальный(запрет) // Россияне поддерживают запрет чиновникам иметь счета и активы за рубежом.
 модальный(риск) // сейчас же риск совершить ошибку был слишком велик
 модальный(СОБЛАЗН) // - Нет соблазна уехать и не вернуться?
 модальный(невозможность) // Администрация города заявила о невозможности самостоятельно выйти из кризиса.
 модальный(ПЛАН) // У концерна есть планы начать строительство в 2006 году.
 модальный(ЧЕРЁД) // Теперь настал мой черед похваляться.
 модальный(ЧЕСТЬ) // мне также выпала честь научить людей вашего племени самим делать такие крыши.
 модальный(НЕТЕРПЕНИЕ) // Я горю нетерпением изучить его.
 модальный(мастер)
 модальный(мастерица)
 модальный(любитель)
 модальный(любительница)
 модальный(охотник)
 модальный(охотница)
 модальный(трудность) // вот это и есть трудность переселиться.
 модальный(ПЕРСПЕКТИВА) // Его даже радовала перспектива проучить Лайонела.
 модальный(УКАЗАНИЕ) // Руководители администраций регионов получили указания пересмотреть свои бюджеты.
 модальный(ПРЕДПИСАНИЕ) // Корабли получили предписание не расставаться в пути
 модальный(требование) // Ее водитель не подчинился требованиям остановиться.
}
