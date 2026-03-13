# justdoit-cc

> Порт [justdoit](https://github.com/serejaris/justdoit) от [Ris](https://t.me/ris_ai) для **Claude Code**.

Превращает любую нетривиальную задачу в структурированный execution pack (`plans.md`, `status.md`, `test-plan.md`) перед выполнением. Сначала план, потом действие.

![just do it](https://raw.githubusercontent.com/serejaris/justdoit/main/assets/justdoit.gif)

## Что делает

Когда запускаешь `/justdoit <задача>` в Claude Code:

1. Анализирует репо и задачу
2. Создаёт три файла:
   - **plans.md** — milestone'ы, упорядоченные по зависимостям, с командами валидации
   - **status.md** — лог выполнения, можно продолжить в любой сессии
   - **test-plan.md** — гейты валидации, привязанные к milestone'ам
3. Предлагает план выполнения и ждёт подтверждения
4. Выполняет: реализация → валидация → фикс → отметка → следующий milestone

## Установка

### Одна команда (macOS / Linux / WSL)

```bash
curl -fsSL https://raw.githubusercontent.com/destrustor/justdoit-cc/main/install.sh | bash
```

### PowerShell (Windows)

```powershell
irm https://raw.githubusercontent.com/destrustor/justdoit-cc/main/install.ps1 | iex
```

### Вручную

Скопируй `commands/justdoit.md` в директорию команд Claude Code:

```bash
mkdir -p ~/.claude/commands
cp commands/justdoit.md ~/.claude/commands/
```

## Использование

В любом репо с Claude Code:

```
/justdoit добавить авторизацию через OAuth
/justdoit рефакторинг модуля оплаты
/justdoit реализовать PRD из docs/prd.md
```

Или просто `/justdoit` без аргументов — Claude спросит, что делать.

## Как работает

Скилл следует 9-шаговому workflow:

1. **Найти целевые файлы** — использует конвенции репо или дефолт `docs/`
2. **Нормализовать вход** — извлечь scope, цели, ограничения, риски
3. **Анализ перед выполнением** — короткий preflight: декомпозиция, риски, открытые решения
4. **Файл плана** — milestone'ы по зависимостям, каждый с командами валидации
5. **Файл статуса** — текущее состояние, audit log, smoke checklist
6. **Тест-план** — уровни тестов, edge cases, acceptance gates
7. **Умный merge** — сохраняет историю при обновлении существующих файлов
8. **Предложение к запуску** — на уровне продукта, не дамп промпта
9. **Ожидание подтверждения** — никогда не начинает без ОК

### Ключевые принципы

- **Repo-aware**: сначала читает проект, потом планирует
- **Durable files**: планы в файлах, не в памяти чата — полностью возобновляемы
- **Validation-first**: у каждого milestone конкретные проверки
- **Repair-before-continue**: сначала починить, потом двигаться дальше
- **Explicit assumptions**: ничего не спрятано в тексте milestone'ов

## Благодарности

Основано на [justdoit](https://github.com/serejaris/justdoit) от [Ris](https://t.me/ris_ai). Оригинальный скилл сделан для OpenAI Codex, это порт для Claude Code.

## Лицензия

MIT — см. [LICENSE](LICENSE).
