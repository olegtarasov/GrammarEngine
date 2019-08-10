﻿// сочетания существительного и правого наречия

#define сущ_когда(n) \
#begin
tree_scorer СущИНаречие language=Russian
{
 if context { существительное:n{}.наречие:*{ ОБСТ_ВАЛ:МОМЕНТ_ВРЕМЕНИ } }
  then 11
}
#end


#define сущ_место(n) \
#begin
tree_scorer СущИНаречие language=Russian
{
 if context { существительное:n{}.наречие:*{ ОБСТ_ВАЛ:МЕСТО } }
  then 11
}
#end


#define сущ_движ(n) \
#begin
tree_scorer СущИНаречие language=Russian
{
 if context { существительное:n{}.наречие:*{ ОБСТ_ВАЛ:НАПРАВЛЕНИЕ } }
  then 11
}
#end


#define сущ_оттуда(n) \
#begin
tree_scorer СущИНаречие language=Russian
{
 if context { существительное:n{}.наречие:*{ ОБСТ_ВАЛ:НАПРАВЛЕНИЕ_ОТКУДА } }
  then 11
}
#end


сущ_движ(лестница) // мы должны найти лестницу наверх
сущ_движ(толчок) // придать добавочный толчок вверх
сущ_движ(дорога) // Я встретил знакомого по дороге домой.
сущ_движ(шаг) // еще один шаг вперед
сущ_движ(прыжок) // прыжок назад освободил его от опасности
сущ_движ(продвижение) // Продвижения вперед почти нет
сущ_движ(путь) // путь вниз был открыт
сущ_движ(путешествие) // путешествие вниз было очень долгим
сущ_движ(полёт) // беспосадочный полёт туда и обратно
сущ_движ(плата) // проездная плата туда и обратно
сущ_движ(скачок) // серьёзный скачок вперед
сущ_движ(вид) // а вот вид сбоку
сущ_движ(рывок) // Последовал резкий рывок вперед и вверх
сущ_движ(стремление) // при жизни - стремление вверх
сущ_движ(выход) // единственный выход наружу - по этому туннелю
сущ_движ(возвращение) // возвращение домой
сущ_движ(тяга) // Но тяга вверх была слабая

сущ_оттуда(письмо) // у меня три или четыре письма оттуда

сущ_место(пребывание) // никаких следов нашего пребывания здесь
сущ_место(присутствие) // мое присутствие здесь
сущ_место(появление) // это было еще до твоего появления здесь

сущ_когда(появление) // его появление днем наверняка означало нечто иное
