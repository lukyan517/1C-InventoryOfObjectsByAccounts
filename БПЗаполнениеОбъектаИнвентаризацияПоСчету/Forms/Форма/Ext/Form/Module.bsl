﻿&НаКлиенте
Процедура ВыполнитьКоманду(ИдентификаторКоманды, ОбъектыНазначенияМассив) Экспорт
	Если ИдентификаторКоманды = "БПЗаполнениеОбъектаИнвентаризацияПоСчету" Тогда
		Оповещение = Новый ОписаниеОповещения("ВыполнитьКомандуЗавершение", ЭтаФорма);
		ОткрытьФорму("ВнешняяОбработка.БПЗаполнениеОбъектаИнвентаризацияПоСчету.Форма.ФормаОтбора",, ВладелецФормы,,,,Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКомандуЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("Счет", 					Результат.Счет);
	ПараметрыОтбора.Вставить("Склад", 				ВладелецФормы.Объект.Склад);
	ПараметрыОтбора.Вставить("ОтветственноеЛицо", 	ВладелецФормы.Объект.ОтветственноеЛицо);
	ПараметрыОтбора.Вставить("Дата", 					ВладелецФормы.Объект.Дата);
	ПараметрыОтбора.Вставить("Организация", 			ВладелецФормы.Объект.Организация);
	ЗаполнитьОстаткиНаСервере(ПараметрыОтбора);
	
	ВладелецФормы.Объект.Товары.Очистить();
	Для Каждого СтрокаТовары Из ОстаткиТоваров Цикл
		НоваяСтрока = ВладелецФормы.Объект.Товары.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаТовары);
	КонецЦикла;
	ВладелецФормы.Модифицированность = Истина;
	
КонецПроцедуры // ВыполнитьКомандуЗавершение()

&НаСервере
Процедура ЗаполнитьОстаткиНаСервере(ПараметрыОтбора)
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОстаткиТоваров.Загрузить(ОбработкаОбъект.ПолучитьОстаткиНаСкладе(ПараметрыОтбора));
	
КонецПроцедуры // ЗаполнитьОстаткиНаСвервере()

&НаКлиенте
Процедура Отладка(Команда)
	
	Оповещение = Новый ОписаниеОповещения("ВыполнитьКомандуЗавершениеОтладка", ЭтаФорма);
	ОткрытьФорму("ВнешняяОбработка.БПЗаполнениеОбъектаИнвентаризацияПоСчету.Форма.ФормаОтбора",, ВладелецФормы,,,,Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКомандуЗавершениеОтладка(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("Счет", 					Результат.Счет);
	ПараметрыОтбора.Вставить("Склад", 				Склад);
	ПараметрыОтбора.Вставить("ОтветственноеЛицо", 	ОтветственноеЛицо);
	ПараметрыОтбора.Вставить("Дата", 					Дата);
	ПараметрыОтбора.Вставить("Организация", 			Организация);
	ЗаполнитьОстаткиНаСервере(ПараметрыОтбора);
	
КонецПроцедуры // ВыполнитьКомандуЗавершение()