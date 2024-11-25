# Amazon Elastic Container Service
## Компоненты
### ECS Cluster
`ECS Cluster` — это логическая группа ресурсов, которая включает:
- `EC2 Instances` (если используется EC2 тип запуска).
- `Fargate Tasks` (если используется Fargate тип запуска).
Кластер управляет ресурсами, необходимыми для выполнения задач (Tasks). Он может быть связан с разными сетями, конфигурациями и `IAM` ролями.
Пример использования:
- Один кластер может управлять несколькими приложениями (с разными `Task Definitions`).
- Отдельные кластеры для среды разработки, тестирования и продакшена.
### ECS Instance
`ECS Instance` — это EC2-экземпляр, зарегистрированный в `ECS` кластере (при использовании типа запуска EC2).
- Контейнеры запускаются внутри этих экземпляров.
- На каждой `Instance` запускается `ECS Agent`, который координирует выполнение задач и отправляет информацию в ECS.
- `ECS Instance` должна иметь `IAM Instance Profile` для взаимодействия с `ECS API`.
### ECS Task Definition
`ECS Task Definition` — это шаблон, описывающий:
`ECS Task Definition` — это шаблон, описывающий:

- Какой контейнер использовать (например, из `ECR`, `Docker Hub`).
- Параметры контейнера:
    - Порты.
    - Переменные окружения.
    - Лимиты памяти и CPU.
    - Логирование (например, `AWS CloudWatch`).
- Тип сети (`bridge`, `host`, `awsvpc`).
- Специфику запуска (`EC2` или `Fargate`).

Пример:
```json
{
  "family": "example-task",
  "containerDefinitions": [
    {
      "name": "web",
      "image": "nginx:latest",
      "memory": 512,
      "cpu": 256,
      "portMappings": [
        { "containerPort": 80, "hostPort": 80 }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/example",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "web"
        }
      }
    }
  ],
  "requiresCompatibilities": ["FARGATE"],
  "networkMode": "awsvpc",
  "memory": "1024",
  "cpu": "512"
}
```
### ECS Task
`ECS Task` — это единичный экземпляр задачи, запускаемый на основе Task Definition.
- Задача может быть одиночной (standalone) или частью сервиса.
- При запуске можно указать параметры, такие как количество задач, специфические переменные окружения или теги.

Пример сценария использования:

- Тестирование приложения с запуском одной задачи в ручном режиме.
- Обработка очереди сообщений в виде временных задач.

### ECS Service
`ECS Service` — это управление долгоживущими ECS задачами:
- Обеспечивает поддержание заданного количества активных задач.
Позволяет подключить `Application Load Balancer (ALB)` или `Network` 
- `Load Balancer (NLB)` для распределения трафика.
- Поддерживает автоматическое масштабирование `(Auto Scaling)` на основе `CloudWatch Metrics`.

Функции сервиса:

- `High Availability`: Если задача выходит из строя, ECS автоматически перезапустит её.
- `Load Balancing`: `ALB/NLB` обеспечивает маршрутизацию входящего трафика.
- `Auto Scaling`: Увеличение/уменьшение числа задач на основе нагрузки.

Пример сценария использования:

- Веб-приложение, обрабатывающее запросы пользователей.
- Поддержание постоянно активного микросервиса.

## Связь компонентов
- `Cluster`: Содержит ресурсы (`EC2` или `Fargate`), на которых выполняются задачи.
- `Instance` (при использовании `EC2`): `EC2` экземпляры, которые обеспечивают вычислительные мощности для задач.
- `Task Definition`: Шаблон для запуска задач, описывающий контейнеры и их параметры.
- `Task`: Запущенная инстанция `Task Definition`.
- `Service`: Управляет жизненным циклом задач и обеспечивает их доступность через балансировщик нагрузки.