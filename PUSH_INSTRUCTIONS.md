# Инструкция по Push в Репозиторий

## Быстрый старт

```bash
# 1. Инициализировать Git (если еще не сделано)
git init

# 2. Добавить все файлы
git add .

# 3. Создать первый коммит
git commit -m "Initial commit: Flutter iOS Stopwatch with Always On Top"

# 4. Добавить удаленный репозиторий (замените URL на свой)
git remote add origin https://github.com/YOUR_USERNAME/packard-stopwatch.git

# 5. Отправить в репозиторий
git push -u origin main
```

## Если репозиторий уже существует

```bash
# 1. Добавить изменения
git add .

# 2. Создать коммит
git commit -m "Update: Added Always On Top feature for iOS"

# 3. Отправить изменения
git push
```

## Создание нового репозитория на GitHub

1. Зайдите на https://github.com
2. Нажмите "New repository"
3. Название: `packard-stopwatch`
4. Описание: `iOS Stopwatch with Always On Top feature`
5. Выберите Public или Private
6. **НЕ** добавляйте README, .gitignore или лицензию (они уже есть)
7. Нажмите "Create repository"
8. Скопируйте URL репозитория

## Подключение к Codemagic

После push в репозиторий:

1. Зайдите на https://codemagic.io
2. Войдите через GitHub/GitLab/Bitbucket
3. Нажмите "Add application"
4. Выберите ваш репозиторий `packard-stopwatch`
5. Codemagic автоматически обнаружит `codemagic.yaml`
6. Выберите workflow `ios-workflow`
7. Нажмите "Start new build"

## Структура проекта

```
packard_stopwatch/
├── lib/
│   └── main.dart              # Основной код приложения
├── ios/                       # iOS конфигурация
│   ├── Runner/
│   │   ├── Info.plist         # iOS настройки + PiP поддержка
│   │   └── AppDelegate.swift
│   └── Podfile
├── test/
│   └── index.html             # Веб-версия для тестирования
├── pubspec.yaml               # Flutter зависимости
├── codemagic.yaml             # CI/CD конфигурация
├── .gitignore                 # Игнорируемые файлы
└── README.md                  # Документация
```

## Что включено в проект

✅ Flutter iOS приложение
✅ Секундомер с миллисекундами
✅ Одиночный тап - старт/пауза
✅ Двойной тап - сброс
✅ Always On Top индикатор
✅ Fullscreen режим
✅ Поддержка всех ориентаций
✅ Codemagic CI/CD настроен
✅ Веб-версия для тестирования

## После сборки в Codemagic

1. Скачайте .ipa файл из Artifacts
2. Установите через:
   - AltStore (https://altstore.io/)
   - Sideloadly (https://sideloadly.io/)
   - TrollStore (для jailbroken устройств)

## Bundle ID

`com.packard.stopwatch`
