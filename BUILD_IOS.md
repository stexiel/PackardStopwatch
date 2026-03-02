# Инструкция по сборке iOS приложения (.ipa)

## Метод 1: Через Xcode (Рекомендуется)

### Шаг 1: Подготовка проекта
```bash
cd "c:\Users\Aser\Downloads\CATEC\Packard Stopwatch"
flutter pub get
flutter build ios --release
```

### Шаг 2: Открыть проект в Xcode
1. Откройте файл: `ios/Runner.xcworkspace` в Xcode
2. Подключите ваше iOS устройство к Mac

### Шаг 3: Настройка подписи
1. В Xcode выберите проект `Runner` слева
2. Выберите таргет `Runner`
3. Перейдите на вкладку "Signing & Capabilities"
4. Выберите вашу команду разработчика (Team)
5. Убедитесь, что "Automatically manage signing" включено

### Шаг 4: Изменить Bundle Identifier
1. В разделе "Signing & Capabilities"
2. Измените Bundle Identifier на уникальный (например: `com.yourname.packardstopwatch`)

### Шаг 5: Создать архив
1. В Xcode: Product → Archive
2. Дождитесь завершения сборки
3. Откроется окно Organizer с вашим архивом

### Шаг 6: Экспорт IPA
1. Нажмите "Distribute App"
2. Выберите "Ad Hoc" или "Development"
3. Следуйте инструкциям мастера
4. Сохраните .ipa файл

## Метод 2: Через командную строку

### Требования:
- Mac с установленным Xcode
- Apple Developer аккаунт
- Сертификаты разработчика настроены

### Команды:
```bash
# Перейти в папку проекта
cd "c:\Users\Aser\Downloads\CATEC\Packard Stopwatch"

# Собрать iOS релиз
flutter build ios --release

# Открыть в Xcode для архивации
open ios/Runner.xcworkspace
```

## Метод 3: Для тестирования без Mac (TestFlight/App Store Connect)

Если у вас нет Mac, но есть Apple Developer аккаунт:

1. Используйте облачный Mac сервис (MacinCloud, MacStadium)
2. Или попросите кого-то с Mac собрать приложение
3. Загрузите в TestFlight для распространения

## Установка на устройство

### Вариант A: Через Xcode
1. Подключите iPhone/iPad к Mac
2. В Xcode выберите ваше устройство
3. Нажмите Run (▶️)

### Вариант B: Через .ipa файл
1. Используйте Apple Configurator 2
2. Или загрузите в TestFlight
3. Или используйте сторонние инструменты (AltStore, Sideloadly)

## Важные замечания

⚠️ **Для сборки iOS приложения требуется:**
- Mac компьютер с macOS
- Xcode (бесплатно из App Store)
- Apple ID (бесплатно)
- Apple Developer аккаунт ($99/год) - для распространения вне разработки

⚠️ **Без Mac:**
- Невозможно собрать .ipa файл напрямую
- Нужен доступ к Mac (физический или облачный)

## Быстрое тестирование (без .ipa)

Если у вас есть Mac и iPhone:
```bash
flutter run --release
```
Это установит приложение напрямую на подключенное устройство.
