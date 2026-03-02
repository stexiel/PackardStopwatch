# Packard Stopwatch

Секундомер для iOS на Flutter

## Функции

- ⏱️ Точный секундомер с миллисекундами
- 👆 **Одиночный тап** - старт/пауза
- 👆👆 **Двойной тап** - сброс
- 🟢 Зеленый цвет когда работает
- 🔴 Красный цвет когда на паузе

## Сборка iOS через Codemagic

### 1. Подготовка проекта

Проект уже настроен для сборки через Codemagic CI/CD.

### 2. Настройка Codemagic

1. Зайдите на https://codemagic.io
2. Войдите через GitHub/GitLab/Bitbucket
3. Добавьте этот репозиторий в Codemagic
4. Codemagic автоматически обнаружит `codemagic.yaml`

### 3. Запуск сборки

1. В Codemagic выберите workflow `ios-workflow`
2. Нажмите "Start new build"
3. Дождитесь завершения сборки (15-20 минут)

### 4. Скачивание .ipa

После успешной сборки:
1. Откройте завершенную сборку в Codemagic
2. Перейдите в раздел "Artifacts"
3. Скачайте файл `packard_stopwatch.ipa`

### 5. Установка на iPhone

Используйте один из методов:
- **AltStore** (https://altstore.io/)
- **Sideloadly** (https://sideloadly.io/)
- **TrollStore** (для jailbroken устройств)

### Локальная разработка (если установлен Flutter)

```bash
# Установка зависимостей
flutter pub get

# Запуск на iOS симуляторе
flutter run

# Сборка iOS (требуется macOS)
flutter build ios --release --no-codesign
```

## Структура проекта

```
packard_stopwatch/
├── lib/
│   └── main.dart          # Основной код приложения
├── ios/                   # iOS конфигурация
│   ├── Runner/
│   │   ├── Info.plist
│   │   └── AppDelegate.swift
│   └── Podfile
├── pubspec.yaml           # Flutter зависимости
└── codemagic.yaml         # CI/CD конфигурация
```

## Технологии

- Flutter 3.x
- Dart 3.x
- iOS 12.0+
- Codemagic CI/CD

## Bundle ID

`com.packard.stopwatch`
