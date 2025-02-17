# Ansible
![](https://www.padok.fr/hubfs/Imported_Blog_Media/ansible_code.webp)
## Почему Ansible
Ansible — это программное решение для удаленного управления конфигурациями. Оно позволяет настраивать удаленные машины. Главное его отличие от других подобных систем в том, что Ansible использует существующую инфраструктуру SSH, в то время как другие (chef, puppet, и пр.) требуют установки специального PKI-окружения. 

Ansible использует так называемый push mode: конфигурация «проталкивается» (push) с главной машины. Другие CM-системы обычно поступают наоборот – узлы «тянут» (pull) конфигурацию с главной машины.

## Роль
`Роль` (`Role`) в `Ansible` — это способ структурировать код для автоматизации, упрощая управление конфигурациями, разбиение задач на логические части и их повторное использование. Это особенно полезно, когда вы работаете над сложными проектами или хотите делиться своими настройками с другими

`Роль` — это набор файлов и директорий с чётко определённой структурой. Она позволяет изолировать задачи, переменные, обработчики, файлы и шаблоны для определённой цели (например, установка и настройка веб-сервера, базы данных или приложений).

`Роли` можно легко подключать в плейбуках, используя ключевое слово `roles`.
```
roles/
  role_name/
    tasks/        # Основные задачи (main.yml)
    handlers/     # Обработчики событий
    templates/    # Шаблоны (Jinja2)
    files/        # Статические файлы
    vars/         # Переменные для роли
    defaults/     # Переменные по умолчанию
    meta/         # Метаданные и зависимости
```

###  Преимущества ролей
- `Повторное использование`: Роли можно использовать в разных плейбуках и проектах.
- `Организация кода`: Чёткое разделение задач, переменных и шаблонов.
- `Удобство документации`: README-файлы в ролях делают код понятным.
- `Зависимости`: Возможность указывать зависимости от других ролей.
- `Поддержка масштабируемости`: Удобно для работы в больших командах и проектах.

## Плейбук (Playbook)

Плейбук (Playbook) — это один из ключевых элементов в Ansible, который описывает серию действий (тасков) для выполнения на целевых хостах. Плейбук представляет собой файл в формате YAML, где описываются шаги автоматизации с указанием, какие действия должны быть выполнены на каких хостах или группах хостов.

Плейбук обычно состоит из одного или нескольких "игр" (plays). Каждый "игра" описывает, какие задачи нужно выполнить на группе хостов.


```yml 
---
- name: Описание игры
  hosts: хосты_или_группы
  become: true  # если необходимо использовать привилегии суперпользователя
  vars:
    переменная: значение  # переменные, которые будут использоваться в задаче
  tasks:
    - name: Описание задачи
      модуль:
        параметр: значение
```
- `name`: Краткое описание того, что будет сделано.
- `hosts`: Определяет, на какие хосты или группы хостов будет направлена эта игра.
- `become`: Указывает, что необходимо выполнять задачи с привилегиями администратора (например, через `sudo`).
- `vars`: Определение переменных, которые можно использовать в задаче.
- `tasks`: Список задач, каждая из которых описана с помощью модуля `Ansible` и его параметров.

### Обработчики (Handlers)
Обработчики в Ansible — это задачи, которые выполняются в ответ на изменения, произошедшие во время выполнения других задач. Например, если в ходе выполнения задачи был изменён конфигурационный файл, обработчик может перезапустить сервис.

Пример использования обработчиков:
```yml
- name: Настройка конфигурации Nginx
  ansible.builtin.template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify:
    - Перезапустить Nginx

handlers:
  - name: Перезапустить Nginx
    ansible.builtin.service:
      name: nginx
      state: restarted
```
Обработчики могут быть вызваны с помощью директивы `notify`. Если задача изменила состояние системы, то будет выполнен соответствующий обработчик.

### Условия и циклы в плейбуке
Плейбуки поддерживают условия (when) и циклы (loop), что позволяет выполнять задачи в зависимости от определённых условий или повторять задачи для нескольких объектов.

Пример с условием:
```yml
- name: Установить пакет, если не установлен
  ansible.builtin.yum:
    name: nginx
    state: present
  when: ansible_facts['pkg_mgr'] == 'yum'
```
Пример с циклом:
```yml
- name: Установить несколько пакетов
  ansible.builtin.yum:
    name: "{{ item }}"
    state: present
  loop:
    - nginx
    - curl
    - git
```
## Таска
Таски — это основные единицы работы, которые выполняются на целевых хостах. Каждая задача представляет собой конкретное действие, которое `Ansible` должен выполнить, например, установку пакета, копирование файла, запуск службы и т. д. Задачи используют модули для выполнения этих действий.

Задача в `Ansible` — это комбинация модуля и параметров, которые указывают, что именно и как должно быть выполнено. В основной структуре задачи вы указываете:

1. Название задачи (name).
2. Модуль, который будет выполняться (например, `apt`).
3. Параметры, которые задают поведение модуля.

```yml 
- name: Install Apache
  apt:
    name: httpd
    state: present
```

## Группы 
В Ansible группы используются для логической организации управляемых хостов (серверов), чтобы управлять ими централизованно, упрощать конфигурацию и облегчать выполнение задач. Группы определяются в инвентори-файле, который может быть статическим (`INI` или `YAML`) или динамическим.

```yml
all:
  children:
    web:
      hosts:
        web01.example.com:
        web02.example.com:
    db:
      hosts:
        db01.example.com:
        db02.example.com:
    load_balancers:
      hosts:
        lb01.example.com:
  vars:
    ansible_user: admin
    ansible_ssh_private_key_file: ~/.ssh/id_rsa
```
`children` — используется для создания подгрупп внутри основной группы.

`vars` — глобальные переменные для всех хостов.

- Вы можете назначить переменные для всей группы, чтобы они автоматически применялись к хостам.

```yml
all:
  children:
    web:
      hosts:
        web01.example.com:
        web02.example.com:
      vars:
        ansible_user: webadmin
        ansible_ssh_private_key_file: ~/.ssh/web_key.pem
```
- Вы можете выбрать несколько групп одновременно или исключить определенные группы.

`hosts: all:!db` — все хосты, кроме группы `db`.

`hosts: web:db` — объединение групп `web` и `db`.

- Полезные практики:
    - Используйте `YAML` для инвентори: `YAML` более структурирован и понятен.
    - Группируйте по ролям или окружениям: Например, `web`, `db`, `staging`, `production`.
    - Применяйте переменные на уровне групп: Это упрощает конфигурацию.

## Переменные
Переменные в Ansible — это важный элемент для гибкости и повторного использования плейбуков, ролей и задач. С помощью переменных можно параметризовать различные значения, такие как пути, имена пользователей, списки пакетов и т. д., чтобы легко изменять их в разных контекстах без необходимости редактировать сам код.


## Модули

Модули в Ansible — это основные строительные блоки, которые выполняют задачи на удалённых хостах, такие как управление пакетами, файлами, пользователями, настройка служб и так далее. Каждый модуль выполняет одну задачу, и их можно использовать для автоматизации различных аспектов инфраструктуры.

Ansible предоставляет более 300 модулей для различных задач. Эти модули являются встроенными, но также существуют модули, разработанные сообществом, которые можно установить через ansible-galaxy.

Основные типы модулей в Ansible
1. Управление пакетами (Package Management): Модули для установки, удаления и обновления пакетов в различных операционных системах.
  - `apt` (для Debian/Ubuntu)
  - `yum` (для RHEL/CentOS/Fedora)
  - `dnf` (для RHEL 8 и новее)
  - `pip` (для установки Python пакетов)
  - `npm` (для установки Node.js пакетов)
2. Управление файлами (Files and Directories): Модули для работы с файлами и каталогами на удалённых хостах.
  - `copy`: Копирует файл с локальной машины на удалённую.
  - `template`: Копирует файл, обрабатывая его через шаблон Jinja2.
  - `file`: Управляет файлами и каталогами (права доступа, владельцы).
  - `fetch`: Загружает файлы с удалённого хоста на локальную машину.
3. Управление пользователями и группами (`Users` and `Groups`): Модули для управления пользователями, группами и правами доступа.
  - `user`: Управляет пользователями (создание, удаление, изменение паролей).
  - `group`: Управляет группами пользователей.
  - `authorized_key`: Управляет SSH-ключами для пользователей.
4. Управление службами (Services): Модули для управления службами и демонами на удалённых хостах.
  - `service`: Управляет службами (запуск, остановка, перезапуск, включение/выключение автозапуска).
  - `systemd`: Управляет системными сервисами через systemd.
5. Управление пактами и репозиториями (Repositories): Модули для работы с репозиториями пакетов.
  - `yum_repository`: Добавление и удаление репозиториев для `yum`.
  - `apt_repository`: Добавление и удаление репозиториев для `apt`.
  - `pip`: Управление пакетами `Python` через `pip`.
6. Работа с системой (`System`): Модули для работы с системными настройками.
  - `hostname`: Управляет именем хоста.
  - `timezone`: Настройка временной зоны.
  - `sysctl`: Управление параметрами ядра.
  - `selinux`: Управление режимом `SELinux`.
7. Управление хранилищами (Storage): Модули для работы с дисками и разделами.
  - `parted`: Управление разделами дисков.
  - `mount`: Монтирование файловых систем.
  - `lvm`: Управление логическими томами.
8. Виртуализация и контейнеры (Virtualization & Containers): Модули для работы с виртуальными машинами и контейнерами.
  - `docker`: Управление контейнерами Docker.
  - `lxc`: Управление контейнерами LXC.
  - `openstack`: Управление ресурсами OpenStack.
  - `vmware`: Управление виртуальными машинами VMware.
9. Работа с сетью (Networking): Модули для управления сетевыми настройками.

- `network`: Модуль для настройки интерфейсов, маршрутов и `DNS`.
- `ios`: Модули для работы с сетевыми устройствами Cisco.
- `netbox`: Интеграция с `NetBox` для управления сетевой инфраструктурой.

### Как работают модули в Ansible?
- Модули как автономные программы: Каждый модуль — это независимая программа, которая выполняет задачу на удалённом хосте. Она может быть написана на Python, но может быть и на других языках, таких как Bash, PowerShell, Ruby.

- Модули не изменяют состояние хоста напрямую: Ansible проверяет, нужно ли выполнить задачу, сравнивая текущее состояние хоста с желаемым состоянием. Если состояние уже соответствует заданному, модуль не будет выполнять никаких действий. Это предотвращает нежелательные изменения.

- Результаты работы модулей: Каждый модуль возвращает стандартный JSON-ответ, который содержит информацию о выполненной операции. Это может быть сообщение о результате работы, изменениях или ошибке.

- Использование ansible для тестирования модулей: Для тестирования модулей можно использовать команду ansible с флагом -m для указания модуля и -a для передачи аргументов.

## Аналоги
|Инструмент | Агент | Подход | Основное применение |
| --- | --- | --- | --- |   
| `Ansible` | Нет | Push | Конфигурация, оркестрация |   
| `Puppet` | Да | Pull | Конфигурация |   
| `Chef` | Да | Pull | Конфигурация |   
| `SaltStack` | Да/Нет | Push/Pull | Оркестрация |   
| `Terraform` | Нет | Push | IaC |   
| `Fabric` | Нет | Push | Скрипты |   
| `Pulumi` | Нет | Push | IaC |    
| `CFEngine` | Да | Pull | Конфигурация | 

## Чем отличаются роли от плейбуков
- `Модульность`: Роли предлагают высокий уровень модульности и переиспользования, в то время как плейбуки обычно определяют конкретные процедуры автоматизации для конкретных сценариев.
- `Организация`: Плейбуки могут использовать роли для организации и сокращения количества кода, делая плейбуки более читаемыми и легкими для поддержки.
- `Повторное использование`: Роли могут быть легко переиспользованы в разных проектах и плейбуках, в то время как плейбуки обычно специфичны для проекта.


Плейбуки являются основными файлами, которые вызывают роли и другие задачи для выполнения операций на управляемых машинах. Роли представляют собой модульные блоки, которые организуют код, связанный с определённой функциональностью, и позволяют его переиспользовать в различных плейбуках. Разделение задач и кода между плейбуками и ролями улучшает организацию, облегчает управление и повышает эффективность процесса автоматизации.

## Ansible
Ansible Vault — это функция Ansible, позволяющая безопасно хранить и управлять конфиденциальными данными, такими как пароли, ключи API и другие секреты, в зашифрованном виде. Это особенно полезно, если ваши плейбуки или файлы инвентаря находятся в системе контроля версий.
## Что такое динамический инвентарь
Динамические инвентаризации в Ansible позволяют вам динамически получать данные инвентаризации из внешних систем. Это могут быть поставщики облачных услуг, базы данных или любая система, которая может выводить JSON в формате, соответствующем спецификациям Ansible. Динамические инвентаризации гарантируют, что запуски вашего playbook отражают текущее состояние ваших систем, без необходимости ручного обновления файлов инвентаризации.

Зачем использовать `inventory`:
- `Масштабируемость`: автоматически адаптируется к изменениям в вашей инфраструктуре.
- `Точность`: гарантирует, что ваши сценарии используют самую актуальную информацию с сервера.
- `Гибкость`: легко интегрируется с облачными провайдерами и другими динамическими системами.