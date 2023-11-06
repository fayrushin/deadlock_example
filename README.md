# Запуск

Проверить deadlock можно утилитой

```
check_deadlock.sh {0,1}
```

0 - запуск без deadlock

1 - запуск с deadlock

## Возможные проблемы

1. Core dump не сохраняется в /var/lib/systemd/coredump.
   Решение: поменять путь для поиска core dump в `check_deadlock.sh`,
   обычно можно указать текущую директорию.

2. Core dump сохраняется в зашифрованном виде.
   Решение: Отключить сжатие в файле `/etc/systemd/coredump.conf`

   `Compress=no`

3. Ошибка следующего характера:
   `Error occurred in Python: A syntax error in expression, near .__data.__owner.`
   Решение: Включить debuginfod в файле `~/.gdbinit`

   `set debuginfod enabled on`

4. gdb должен быть собран или установлен с поддержкой python
   `https://askubuntu.com/questions/513626/cannot-compile-gdb7-8-with-python-support`
