# 🚀 Руководство по развертыванию iOS приложения

## Вариант 1: GitHub Actions (Рекомендуется)

### Шаг 1: Создать GitHub репозиторий
1. Зайдите на https://github.com
2. Нажмите "New repository"
3. Назовите репозиторий (например: `packard-stopwatch`)
4. Нажмите "Create repository"

### Шаг 2: Загрузить код на GitHub
Откройте терминал в папке проекта:
```bash
cd "c:\Users\Aser\Downloads\CATEC\Packard Stopwatch"
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/ВАШ_USERNAME/packard-stopwatch.git
git push -u origin main
```

### Шаг 3: Автоматическая сборка
После загрузки кода:
1. Зайдите в ваш репозиторий на GitHub
2. Перейдите во вкладку **Actions**
3. Сборка запустится автоматически
4. Дождитесь завершения (5-10 минут)

### Шаг 4: Скачать .ipa файл
1. В разделе **Actions** → выберите последний успешный build
2. Прокрутите вниз до раздела **Artifacts**
3. Скачайте `ios-app-unsigned.ipa`

### Шаг 5: Установить на iPhone
**Вариант A: AltStore (Бесплатно)**
1. Установите AltStore на iPhone: https://altstore.io
2. Подключите iPhone к компьютеру
3. Откройте AltStore на iPhone
4. Нажмите "+" и выберите скачанный .ipa файл
5. Приложение установится!

**Вариант B: Sideloadly (Бесплатно)**
1. Скачайте Sideloadly: https://sideloadly.io
2. Подключите iPhone к компьютеру
3. Перетащите .ipa файл в Sideloadly
4. Введите Apple ID
5. Нажмите "Start"

---

## Вариант 2: Codemagic

### Шаг 1: Регистрация
1. Зайдите на https://codemagic.io
2. Зарегистрируйтесь (можно через GitHub)
3. Бесплатный план дает 500 минут в месяц

### Шаг 2: Подключить репозиторий
1. Нажмите "Add application"
2. Выберите ваш GitHub репозиторий
3. Codemagic автоматически найдет `codemagic.yaml`

### Шаг 3: Запустить сборку
1. Нажмите "Start new build"
2. Выберите ветку `main`
3. Дождитесь завершения (5-10 минут)

### Шаг 4: Скачать .ipa
1. После завершения сборки
2. Перейдите в раздел **Artifacts**
3. Скачайте `PackardStopwatch.ipa`

### Шаг 5: Установить на iPhone
Используйте AltStore или Sideloadly (см. выше)

---

## ⚠️ Важные замечания

### Неподписанный .ipa
- Файл будет **неподписанным** (unsigned)
- Работает через AltStore/Sideloadly
- Нужно переустанавливать каждые 7 дней (бесплатный Apple ID)
- Или каждый год (платный Apple Developer аккаунт)

### Для подписанного .ipa
Нужен Apple Developer аккаунт ($99/год):
1. Добавьте сертификаты в GitHub Secrets
2. Измените workflow для подписи
3. Получите полностью подписанный .ipa

### Альтернатива: TestFlight
С Apple Developer аккаунтом:
1. Загрузите .ipa в App Store Connect
2. Добавьте в TestFlight
3. Пригласите себя как тестера
4. Установите через TestFlight (без ограничений)

---

## 🆘 Решение проблем

### "Unable to install app"
- Убедитесь, что используете AltStore или Sideloadly
- Проверьте, что iPhone доверяет вашему компьютеру

### "Untrusted Developer"
1. Настройки → Основные → VPN и управление устройством
2. Найдите ваш Apple ID
3. Нажмите "Доверять"

### Сборка не запускается на GitHub
- Убедитесь, что файл `.github/workflows/ios-build.yml` загружен
- Проверьте вкладку Actions в репозитории

### Нужна помощь?
- GitHub Actions документация: https://docs.github.com/actions
- Codemagic документация: https://docs.codemagic.io
- AltStore FAQ: https://altstore.io/faq

---

## 📱 Быстрый старт (кратко)

1. **Загрузите код на GitHub**
2. **Дождитесь автоматической сборки** (вкладка Actions)
3. **Скачайте .ipa** из Artifacts
4. **Установите через AltStore** на iPhone
5. **Готово!** 🎉
