﻿local T, C, L = unpack(ShestakUI)
if T.client ~= "ruRU" then return end

----------------------------------------------------------------------------------------
--	Localization for ruRU client
----------------------------------------------------------------------------------------
-- Key binding Header Name
L_EXTRA_HEADER_EXTRABAR = "Дополнительная панель команд"
L_EXTRA_HEADER_MARK = "Метки по наведению курсора"

-- Announce fps
L_EXTRA_ANNOUNCE_FPS = "Кадров в секунду у меня "

-- Click2Cast
L_EXTRA_BINDER_FRAMES = "Рамки"
L_EXTRA_BINDER_OPEN = "Назначения мыши"
L_EXTRA_BINDER_CLOSE = "Назначения мыши"

-- BG announce
L_EXTRA_ANNOUNCE_BG_LIGHT = "Легкая атака на "
L_EXTRA_ANNOUNCE_BG_MEDIUM = "Средняя атака на "
L_EXTRA_ANNOUNCE_BG_HEAVY = "Тяжелая атака на "
L_EXTRA_ANNOUNCE_BG_CLEAR = "Все чисто у "
L_EXTRA_ANNOUNCE_BG_FOCUS = "Фокусная атака на "
L_EXTRA_ANNOUNCE_BG_STEALTH = "Рядом враг в невидимости"

-- EnchantScroll
L_EXTRA_SCROLL = "Свиток"

-- Announce your Lightwell
L_EXTRA_ANNOUNCE_LA_USE = " выпил из моего колодца. "
L_EXTRA_ANNOUNCE_LA_CHARGE = " заряд(ов))"
L_EXTRA_ANNOUNCE_LA_USELESS = " использовал мой колодец впустую! "
L_EXTRA_ANNOUNCE_LA_STOP = "Прекрати пить из моего колодца!!!"
L_EXTRA_ANNOUNCE_LA_PLACED = "Колодец Света поставлен. "
L_EXTRA_ANNOUNCE_LA_CHARGES = " зарядов."

-- Announce flasks and food
L_EXTRA_ANNOUNCE_FF_NOFOOD = "Нет еды: "
L_EXTRA_ANNOUNCE_FF_NOFLASK = "Нет настоя: "
L_EXTRA_ANNOUNCE_FF_ALLBUFFED = "Еда и настой есть у всех. Можно щемить!"
L_EXTRA_ANNOUNCE_FF_CHECK_BUTTON = "Проверка еды и настоя"

-- Says thanks for some spells
L_EXTRA_ANNOUNCE_SS_THANKS = "Спасибо за "
L_EXTRA_ANNOUNCE_SS_RECEIVED = " получено от "

-- Taunt announce
L_EXTRA_TAUNT_UNKNOWN = "Неизвестная команда:"
L_EXTRA_TAUNT_ADD = "Добавить танка"
L_EXTRA_TAUNT_DEL = "Удалить танка"
L_EXTRA_TAUNT_DEL_ALL = "Удалить всех танков"
L_EXTRA_TAUNT_TANK_LIST = "Список танков"
L_EXTRA_TAUNT_AURA = "Проверка аур"
L_EXTRA_TAUNT_AURA_CHECK = "Проверка аур выполнена."
L_EXTRA_TAUNT_ALREADY_LIST = " уже добавлен в список танков."
L_EXTRA_TAUNT_ADDED_TANK = "Добавлен танк "
L_EXTRA_TAUNT_REMOVED_TANK = "Удалён танк "
L_EXTRA_TAUNT_TARGET_FIRST = "Необходимо выбрать игрока."
L_EXTRA_TAUNT_ALL_REMOVED = "Весь список танков очищен."

-- ExploreMap
L_EXTRA_EXPLORED = "Исследовано: "
L_EXTRA_ZONEACHID = {
	-- http://www.wowhead.com/achievement=*
	-- e(X)plore achievement id, (Q)uest achievement id
	["Восточные королевства"]			= {X =   42, A =    0, H =    0},
	["Калимдор"]						= {X =   43, A =    0, H =    0},
	["Запределье"]						= {X =   44, A =    0, H =    0},
	["Нордскол"]						= {X =   45, A =    0, H =    0},
	["Карта мира"]						= {X =  nil, A =    0, H =    0},
	-- Eastern Kingdoms
	["Нагорье Арати"]					= {X =  761, A = 4896, H = 4896},
	["Бесплодные земли"]				= {X =  765, A = 4900, H = 4900},
	["Выжженные земли"]					= {X =  766, A = 4909, H = 4909},
	["Пылающие степи"]					= {X =  775, A = 4901, H = 4901},
	["Перевал Мертвого Ветра"]			= {X =  777, A =    0, H =    0},
	["Дун Морог"]						= {X =  627, A =    0, H =    0},
	["Сумеречный лес"]					= {X =  778, A = 4907, H =    0},
	["Восточные Чумные земли"]			= {X =  771, A = 4892, H = 4892},
	["Элвиннский лес"]					= {X =  776, A =    0, H =    0},
	["Леса Вечной Песни"]				= {X =  859, A =    0, H =    0},
	["Призрачные земли"]				= {X =  858, A =    0, H = 4908},
	["Предгорья Хилсбрада"]				= {X =  772, A =    0, H = 4895},
	["Лок Модан"]						= {X =  779, A = 4899, H =    0},
	["Северная Тернистая долина"]		= {X =  781, A = 4906, H = 4906},
	["Красногорье"]						= {X =  780, A = 4902, H =    0},
	["Тлеющее ущелье"]					= {X =  774, A = 4910, H = 4910},
	["Серебряный бор"]					= {X =  769, A =    0, H = 4894},
	["Болото Печали"]					= {X =  782, A = 4904, H = 4904},
	["Мыс Тернистой долины"]			= {X = 4995, A = 4905, H = 4905},
	["Внутренние земли"]				= {X =  773, A = 4897, H = 4897},
	["Тирисфальские леса"]				= {X =  768, A =    0, H =    0},
	["Западные Чумные земли"]			= {X =  770, A = 4893, H = 4893},
	["Западный Край"]					= {X =  802, A = 4903, H =    0},
	["Болотина"]						= {X =  841, A = 4898, H =    0},
	-- Kalimdor
	["Ясеневый лес"]					= {X =  845, A = 4925, H = 4976},
	["Азшара"]							= {X =  852, A =    0, H = 4927},
	["Остров Лазурной Дымки"]			= {X =  860, A =    0, H =    0},
	["Остров Кровавой Дымки"]			= {X =  861, A = 4926, H = 4926},
	["Темные берега"]					= {X =  844, A = 4928, H = 4928},
	["Пустоши"]							= {X =  848, A = 4930, H = 4930},
	["Дуротар"]							= {X =  728, A =    0, H =    0},
	["Пылевые топи"]					= {X =  850, A = 4929, H = 4978},
	["Оскверненный лес"]				= {X =  853, A = 4931, H = 4931},
	["Фералас"]							= {X =  849, A = 4932, H = 4979},
	["Лунная поляна"]					= {X =  855, A =    0, H =    0},
	["Мулгор"]							= {X =  736, A =    0, H =    0},
	["Северные Степи"]					= {X =  750, A =    0, H = 4933},
	["Силитус"]							= {X =  856, A = 4934, H = 4934},
	["Южные Степи"]						= {X = 4996, A = 4937, H = 4981},
	["Когтистые горы"]					= {X =  847, A = 4936, H = 4980},
	["Танарис"]							= {X =  851, A = 4935, H = 4935},
	["Тельдрассил"]						= {X =  842, A =    0, H =    0},
	["Тысяча Игл"]						= {X =  846, A = 4938, H = 4938},
	["Кратер Ун'Горо"]					= {X =  854, A = 4939, H = 4939},
	["Зимние Ключи"]					= {X =  857, A = 4940, H = 4940},
	-- Outland
	["Острогорье"]						= {X =  865, A = 1193, H = 1193},
	["Полуостров Адского Пламени"]		= {X =  862, A = 1189, H = 1271},
	["Награнд"]							= {X =  866, A = 1192, H = 1273},
	["Пустоверть"]						= {X =  843, A = 1194, H = 1194},
	["Долина Призрачной Луны"]			= {X =  864, A = 1195, H = 1195},
	["Лес Тероккар"]					= {X =  867, A = 1191, H = 1272},
	["Зангартопь"]						= {X =  863, A = 1190, H = 1190},
	-- Northrend
	["Борейская тундра"]				= {X = 1264, A =   33, H = 1358},
	["Лес Хрустальной Песни"]			= {X = 1457, A =    0, H =    0},
	["Драконий Погост"]					= {X = 1265, A =   35, H = 1356},
	["Седые холмы"]						= {X = 1266, A =   37, H = 1357},
	["Ревущий фьорд"]					= {X = 1263, A =   34, H = 1356},
	["Ледяная Корона"]					= {X = 1270, A =   40, H =   40},
	["Низина Шолазар"]					= {X = 1268, A =   39, H =   39},
	["Грозовая Гряда"]					= {X = 1269, A =   38, H =   38},
	["Зул'Драк"]						= {X = 1267, A =   36, H =   36},
	-- Cataclysm
	["Подземье"]						= {X = 4864, A = 4871, H = 4871},
	["Хиджал"]							= {X = 4863, A = 4870, H = 4870},
	["Сумеречное нагорье"]				= {X = 4866, A = 4873, H = 5501},
	["Ульдум"]							= {X = 4865, A = 4872, H = 4872},
	["Вайш'ир"]							= {X = 4825, A = 4869, H = 4982},
	["Тол Барад"]						= {X =    0, A = 4874, H = 4874},
	["Полуостров Тол Барад"]			= {X =    0, A = 4874, H = 4874},
	-- Boolean Explores
	["Остров Кель'Данас"]				= {X =  868, A =    0, H =    0},
	["Ан'Кираж: Павшее Королевство"]	= {X =    0, A =    0, H =    0},
	["Озеро Ледяных Оков"]				= {X =    0, A =    0, H =    0},
}