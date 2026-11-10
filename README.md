# Арома Дом - учёт материалов

Демоэкзамен 09.02.07, вариант 6.

WPF приложение (C#, .NET Framework 4.7.2), база данных MS SQL Server.

## Структура

- `WpfApp5` - исходный код приложения
- `Exe` - исполняемые файлы
- `Database/AromaDom.sql` - скрипт базы данных
- `Database/ER_diagram.pdf` - ER диаграмма
- `Database/import` - подготовленные для импорта данные
- `Docs/Algorithm.md` - алгоритм модуля 2

## Запуск

1. Выполнить `Database/AromaDom.sql` в SSMS
2. В `MaterialRepository.cs` и `ProductCalculator.cs` поменять имя сервера если нужно
3. Запустить `Exe/WpfApp5.exe`
