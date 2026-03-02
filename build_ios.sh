#!/bin/bash

echo "🚀 Сборка iOS приложения Packard Stopwatch"
echo "=========================================="

# Проверка Flutter
if ! command -v flutter &> /dev/null
then
    echo "❌ Flutter не найден. Установите Flutter сначала."
    exit 1
fi

echo "📦 Установка зависимостей..."
flutter pub get

echo "🔨 Сборка iOS релиза..."
flutter build ios --release

echo "✅ Сборка завершена!"
echo ""
echo "📱 Следующие шаги:"
echo "1. Откройте ios/Runner.xcworkspace в Xcode"
echo "2. Настройте подпись (Signing & Capabilities)"
echo "3. Product → Archive"
echo "4. Distribute App → Ad Hoc/Development"
echo ""
echo "Или запустите на подключенном устройстве:"
echo "flutter run --release"
