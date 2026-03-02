# Packard Stopwatch

Секундомер для iOS на React Native + Expo

## Функции

- ⏱️ Точный секундомер с миллисекундами
- 👆 **Одиночный тап** - старт/пауза
- 👆👆 **Двойной тап** - сброс
- 🟢 Зеленый цвет когда работает
- 🔴 Красный цвет когда на паузе

## Установка зависимостей

```bash
npm install
```

## Запуск для разработки

```bash
npm start
```

## Сборка iOS через EAS

### 1. Установка EAS CLI

```bash
npm install -g eas-cli
```

### 2. Логин в Expo

```bash
eas login
```

### 3. Конфигурация проекта

```bash
eas build:configure
```

### 4. Сборка iOS

```bash
eas build --platform ios --profile preview
```

### 5. Скачивание .ipa

После успешной сборки:
1. Перейдите на https://expo.dev
2. Откройте ваш проект
3. Перейдите в раздел "Builds"
4. Скачайте .ipa файл

### 6. Установка на iPhone

Используйте:
- **AltStore** (https://altstore.io/)
- **Sideloadly** (https://sideloadly.io/)

## Технологии

- React Native
- Expo SDK 51
- React Native Gesture Handler
