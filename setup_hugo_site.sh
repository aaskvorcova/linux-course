#!/bin/bash

echo "🚀 НАЧИНАЕМ СОЗДАНИЕ HUGO САЙТА"
echo "================================="

# 1. Создаём чистую папку
cd /home/aaskvorcova
rm -rf my-site-hugo
mkdir my-site-hugo
cd my-site-hugo

echo "✅ Папка создана"

# 2. Создаём сайт Hugo
hugo new site . --force

echo "✅ Hugo сайт создан"

# 3. Устанавливаем тему Wowchemy
git init
git submodule add https://github.com/wowchemy/starter-hugo-academic.git themes/wowchemy

echo "✅ Тема установлена"

# 4. Копируем конфиги темы
cp -r themes/wowchemy/config/_default/ config/

# 5. Удаляем проблемные файлы
rm -f go.mod go.sum

echo "✅ Конфигурация настроена"

# 6. Создаём папки для двух языков
mkdir -p content/ru content/en
mkdir -p content/ru/home content/en/home
mkdir -p content/ru/post content/en/post
mkdir -p content/ru/authors/admin content/en/authors/admin

# 7. Настраиваем языки
cat > config/_default/languages.yaml << 'EOF'
ru:
  languageName: Русский
  contentDir: content/ru
  weight: 1
en:
  languageName: English
  contentDir: content/en
  weight: 2
EOF

echo "✅ Двуязычность настроена"

# 8. Копируем шаблоны домашней страницы
cp -r themes/wowchemy/content/home/* content/ru/home/ 2>/dev/null || echo ""

# 9. Создаём файл автора (русский)
cat > content/ru/authors/admin/_index.md << 'EOF'
---
title: "Скворцова Анастасия"
role: "Студент"
bio: "Учусь программированию на C++ и искусственному интеллекту"
interests:
  - C++
  - Искусственный интеллект
  - Машинное обучение
education:
  courses:
    - course: "Студент"
      institution: "Российский университет дружбы народов"
      year: 2026
social:
  - icon: github
    icon_pack: fab
    link: https://github.com/aaskvorcova
---

## Биография

Скворцова Анастасия — студентка РУДН. Увлекаюсь программированием на C++ и искусственным интеллектом.
EOF

echo "✅ Данные автора добавлены"

# 10. Создаём посты (русский язык)
cat > content/ru/post/week1.md << 'EOF'
---
title: "Первая неделя работы над сайтом"
date: 2026-05-30
---

На этой неделе я:
- Установила Hugo на Fedora
- Создала структуру сайта
- Настроила двухъязычность
EOF

cat > content/ru/post/git.md << 'EOF'
---
title: "Управление версиями: Git"
date: 2026-05-30
---

Git — система контроля версий, которая помогает отслеживать изменения в коде.

## Основные команды Git
- `git init` — создать репозиторий
- `git add` — добавить файлы
- `git commit` — сохранить изменения
- `git push` — отправить на GitHub
EOF

cat > content/ru/post/markdown.md << 'EOF'
---
title: "Язык разметки Markdown"
date: 2026-05-30
---

Markdown — лёгкий язык разметки для форматирования текста.

**Примеры:** `**жирный**`, `*курсив*`, `[ссылка](url)`, `- список`
EOF

cat > content/ru/post/skills.md << 'EOF'
---
title: "Мои навыки и опыт"
date: 2026-05-30
---

## Навыки (Skills)
- C++ (продвинутый)
- Python (базовый)
- Git (базовый)
- Linux (базовый)

## Опыт (Experience)
- Учебные проекты на C++
- Работа с терминалом Linux

## Достижения (Accomplishments)
- Создала персональный сайт
- Освоила Git
EOF

cat > content/ru/post/scientific-links.md << 'EOF'
---
title: "Научные ресурсы"
date: 2026-05-30
---

## Мои профили
- [GitHub](https://github.com/aaskvorcova)
- [Google Scholar](https://scholar.google.com/)
- [ORCID](https://orcid.org/)
- [ResearchGate](https://www.researchgate.net/)
EOF

cat > content/ru/post/report.md << 'EOF'
---
title: "Оформление отчётов"
date: 2026-05-30
---

## Структура отчёта
1. Титульный лист
2. Цель работы
3. Описание алгоритма
4. Листинг кода
5. Результаты
6. Выводы
EOF

cat > content/ru/post/languages.md << 'EOF'
---
title: "Языки научного программирования"
date: 2026-05-30
---

Сравнение языков для научных расчётов:

| Язык | Плюсы | Минусы |
|------|-------|--------|
| Python | Простой, много библиотек | Медленный |
| C++ | Быстрый | Сложный |
| Julia | Быстрый, простой | Молодой |
EOF

echo "✅ Посты созданы"

# 11. Настраиваем конфиг сайта
cat > hugo.toml << 'EOF'
baseURL = "https://aaskvorcova.github.io/"
title = "Скворцова Анастасия"
defaultContentLanguage = "ru"
theme = "wowchemy"

[markup]
  [markup.highlight]
    codeFences = true
    noClasses = false
EOF

echo "✅ Конфигурация сайта завершена"

# 12. Запускаем сервер
echo ""
echo "🎉 ВСЁ ГОТОВО! ЗАПУСКАЕМ СЕРВЕР..."
echo "================================="
echo "Откройте в браузере: http://localhost:1313"
echo "Для остановки сервера нажмите Ctrl+C"
echo ""

hugo server
