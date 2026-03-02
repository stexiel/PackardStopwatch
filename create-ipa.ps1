# Скрипт для создания IPA из Runner.app

Write-Host "=== Создание IPA файла из Runner.app ===" -ForegroundColor Green

# Проверяем наличие Runner.app
if (-not (Test-Path "Runner.app")) {
    Write-Host "ОШИБКА: Runner.app не найден в текущей директории!" -ForegroundColor Red
    Write-Host "Скачайте Runner.app из Codemagic и поместите в эту папку" -ForegroundColor Yellow
    exit 1
}

# Создаем структуру для IPA
Write-Host "Создаю структуру Payload..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path "Payload" | Out-Null

# Копируем Runner.app в Payload
Write-Host "Копирую Runner.app в Payload..." -ForegroundColor Cyan
Copy-Item -Path "Runner.app" -Destination "Payload\" -Recurse -Force

# Создаем ZIP архив
Write-Host "Создаю IPA файл..." -ForegroundColor Cyan
Compress-Archive -Path "Payload" -DestinationPath "PackardStopwatch.zip" -Force

# Переименовываем в .ipa
Write-Host "Переименовываю в .ipa..." -ForegroundColor Cyan
if (Test-Path "PackardStopwatch.ipa") {
    Remove-Item "PackardStopwatch.ipa" -Force
}
Rename-Item "PackardStopwatch.zip" "PackardStopwatch.ipa"

# Удаляем временную папку
Write-Host "Очищаю временные файлы..." -ForegroundColor Cyan
Remove-Item -Path "Payload" -Recurse -Force

Write-Host ""
Write-Host "=== ГОТОВО! ===" -ForegroundColor Green
Write-Host "Файл PackardStopwatch.ipa создан!" -ForegroundColor Green
Write-Host ""
Write-Host "Теперь:" -ForegroundColor Yellow
Write-Host "1. Откройте Sideloadly" -ForegroundColor White
Write-Host "2. Перетащите PackardStopwatch.ipa в Sideloadly" -ForegroundColor White
Write-Host "3. Подключите iPhone и нажмите Start" -ForegroundColor White
Write-Host ""
