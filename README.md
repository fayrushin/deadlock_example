# Запуск

Проверить deadlock можно проверить утилитой 

```
check_deadlock.sh {0,1}
```

1 - запуск с deadlock

0 - запуск без deadlock

## Возможные проблемы

1. Core dump не сохраняется в /var/lib/systemd/coredump.
    Решение: поменять путь для поиска core dump,
    обычно можно указать текущую директорию.

2. Core dump сохраняется в зашифрованном виде.
    Решение: Отключить сжатие в файле `/etc/systemd/coredump.conf`
    `Compress=no`
    
3. Ошибка следующего характера: 
    `Error occurred in Python: A syntax error in expression, near `.__data.__owner'.`
    Решение: Включить debuginfod в файле `~/.gdbinit`
    `set debuginfod enabled on`
