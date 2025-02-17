# Terraform
![](https://miro.medium.com/v2/resize:fit:400/1*lG-hTnKrmpQO306772jGpg.png)
## Theory
### Что такое terraform 
`Terraform` — это мощный программный инструмент Infrastructure as Code (IaC), предлагаемый `HashiCorp`. Он облегчает подготовку и управление вашей инфраструктурой локально и в облаке. Его можно легко расширить с помощью архитектуры на основе плагинов.
### Как он работает
На высоком уровне `Terraform` можно рассматривать как состоящий из двух основных частей : `Terraform Core` и `Plugins`. `Core` отвечает за управление жизненным циклом инфраструктуры.

`Terraform Core` учитывает текущее состояние и оценивает его в соответствии с желаемой конфигурацией. Затем он предлагает план по добавлению или удалению компонентов инфраструктуры по мере необходимости. Затем он заботится о предоставлении или выводе из эксплуатации любых ресурсов, если вы решите применить план.

Плагины `Terraform` предоставляют механизм для `Terraform Core` для связи с вашим хостом инфраструктуры или поставщиками SaaS. Провайдеры и поставщики `Terraform` являются примерами плагинов, упомянутых выше. `Terraform Core` взаимодействует с плагинами через удаленный вызов процедур (RPC).
![](https://spacelift.io/_next/image?url=https%3A%2F%2Fspaceliftio.wpcomstaging.com%2Fwp-content%2Fuploads%2F2021%2F07%2Fterraform-definition.jpg&w=1920&q=75)
### Рабочий процесс Terraform
1. Пишем код | Объявите ресурсы своей инфраструктуры в виде кода на языке конфигурирования Hashicorp (HCL). 
2. Проинициализируем все providers(plugins) | Используя команду `terraform init`.
3. Создим план по обновлению инфраструктуры | Используя команду `terraform plan`.
4. Применим наш план по обновлению инфраструктуры | Используя команду `terraform apply`.

### Основные характеристики
- `Идемпотентность`: Способен привести инфраструктуру в точное состояние, определённое в конфигурационных файлах, не внося повторных изменений в уже существующие ресурсы, если это не требуется.
- `Декларативный подход`: Пользователь описывает "что" должно быть создано, а не "как" это должно быть сделано.
- `Управление состоянием`: Отслеживает текущее состояние инфраструктуры и помогает управлять её изменениями.

## Основные элементы Terraform
### Terraform CLI
Terraform CLI — это командный интерфейс для работы с Terraform. Он используется для управления инфраструктурой с помощью набора консистентных команд.

Основные команды:

- `terraform init`: Инициализирует рабочую директорию, загружая необходимые провайдеры и модули.
- `terraform plan`: Создает план выполнения, показывая, какие изменения будут внесены в инфраструктуру.
- `terraform apply`: Применяет изменения, чтобы достичь желаемого состояния конфигурации.
- `terraform destroy`: Уничтожает ресурсы, управляемые Terraform.
- `terraform fmt`: Форматирует файлы конфигурации Terraform в соответствии с рекомендациями.
- `terraform validate`: Проверяет синтаксис и корректность конфигурационных файлов.
- `terraform state`: Управляет состоянием Terraform, позволяя просматривать или изменять его.

### Terraform Language
Terraform использует язык HCL (HashiCorp Configuration Language) для описания инфраструктуры в файлах с расширением `.tf`.

Ключевые компоненты:

- Ресурсы: Представляют компоненты инфраструктуры (например, `aws_instance`, `google_compute_instance`).
- Провайдеры: Плагины, которые управляют ресурсами для конкретных платформ (например, `AWS`, `Azure`, `GCP`).
- Переменные (`Variables`): Позволяют задавать динамическую конфигурацию через блоки variable.
- Выходные данные (`Outputs`): Экспортируют информацию из `Terraform` для использования в других системах.
- Модули: Группируют ресурсы для повторного использования и упрощения управления.
- Состояние (`State`): Terraform отслеживает текущее состояние инфраструктуры в файле `.tfstate`.
### Terraform Providers
Провайдеры — это плагины, которые позволяют `Terraform` взаимодействовать с внешними платформами (например, `AWS`, `Azure`, `Kubernetes`).

Пример `aws`: Управление ресурсами `AWS`.

Особенности:

`Terraform` автоматически загружает необходимые провайдеры при выполнении команды `terraform init`.
Каждый провайдер поддерживает специфические ресурсы и имеет свои параметры конфигурации.
### Terraform Provisioners
`Provisioners` позволяют выполнять команды или скрипты на ресурсе после его создания.

Основные `Provisioners`:

- `local-exec`: Выполняет команду локально на машине, где запущен - `Terraform`.
- `remote-exec`: Выполняет команду на удаленном ресурсе через `SSH` или `WinRM`.
- `file`: Передает файлы с локальной машины на удаленный ресурс.

Пример:

```hcl
resource "aws_instance" "example" {
  ami = "ami-123456"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
    ]
  }
}
```
### Terraform Modules
Модули — это повторно используемые блоки конфигурации Terraform. Они помогают организовать ресурсы и упрощают управление инфраструктурой.

Типы модулей:

- `Root Module`: Основной набор конфигурационных - файлов в рабочей директории.
- `Child Modules`: Модули, которые вызываются из основного или других модулей.

Структура модуля:

- `main.tf`: Основная конфигурация.
- `variables.tf`: Переменные для модуля.
- `outputs.tf`: Выходные данные модуля.
- `readme.md`: Документация (необязательно).

Модули предоставляют способ упаковки ресурсов , которые предоставляют соответствующую функциональность вместе как группа. Каждая конфигурация Terraform имеет по крайней мере один модуль, называемый корневым модулем , и может вызывать другие модули, называемые дочерними модулями. 

Легко писать модули и делиться ими с вашей командой или другими . Реестр Terraform содержит большую коллекцию модулей Terraform для часто используемых сценариев конфигурации. Terraform может автоматически загружать эти модули, если вы включите их в свою конфигурацию.

Примеры использования модулей:

- Создание сети (`VPC`, `subnet`, шлюзы, таблицы маршрутизации).
- Развертывание кластера баз данных.
- Настройка групп безопасности (`security groups`).
- Управление группами виртуальных машин.


### Terraform State
Terraform хранит представление объектов вашей инфраструктуры, их взаимозависимости и привязки в файле конфигурации с именем terraform.tfstate . Хранение информации о состоянии очень помогает Terraform в принятии решений по планированию и выполнению. Состояние может храниться как локально, так и удаленно в командной среде.

## Что такое variables.tf и outputs.tf?

Файлы `variables.tf` и `outputs.tf` помогают модулям быть гибкими, удобными и полезными для других частей инфраструктуры.

### variables.tf
Файл `variables.tf` используется для объявления входных переменных, которые определяют параметры, с которыми модуль будет работать. Входные переменные позволяют модулям быть универсальными: с их помощью вы задаете значения, такие как идентификаторы VPC, типы инстансов или параметры безопасности, во время вызова модуля.

Пример `variables.tf`:
```hcl
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "vpc_id" {
  type = string
}
```

Когда модуль вызывается, этим переменным можно присваивать значения, которые адаптируют модуль под нужды конкретного окружения.

### outputs.tf
Файл `outputs.tf` используется для объявления выходных значений, которые возвращают важные данные о созданных ресурсах. С помощью `outputs.tf` вы можете получить такие значения, как ID созданных ресурсов, IP-адреса и другие важные параметры. Эти выходные данные помогают связать работу разных модулей, делая результаты работы одного модуля доступными для других.

Пример `outputs.tf`:

```hcl
output "instance_id" {
  value = aws_instance.example.id
}

output "instance_ip" {
  value = aws_instance.example.public_ip
}
```

## Как разграничить доступ к tfstate
![](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*fTy-c4tMqwtsMfZsX0ePLw.png)

### Что такое состояние и почему оно важно в Terraform?
«Terraform должен хранить состояние вашей управляемой инфраструктуры и конфигурации. Это состояние используется Terraform для сопоставления реальных ресурсов с вашей конфигурацией, отслеживания метаданных и повышения производительности для больших инфраструктур. Этот файл состояния чрезвычайно важен ; он сопоставляет различные метаданные ресурсов с фактическими идентификаторами ресурсов, чтобы Terraform знал, чем он управляет. Этот файл должен быть сохранен и распространен среди всех, кто может запустить Terraform ».

### Steps
1. Создание S3 в Terraform
```hcl
provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region     = "us-east-1"
}

resource "aws_s3_bucket" "tf_course" {
    
    bucket = "hella-buckets"
    acl = "private"
}
```
2. Настройка нашего S3 Backend
```hcl
terraform {
  backend "s3" {
    encrypt = true    bucket = "hella-buckets"
    dynamodb_table = "terraform-state-lock-dynamo"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```
3. Создание таблицы DynamoDB
```hcl
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}
```
## Best practices

### Использовать удаленное состояние
Наличие единого удаленного бэкенда для вашего состояния считается одной из первых лучших практик, которую вы должны использовать при работе в команде. Выберите тот, который поддерживает блокировку состояния , чтобы избежать одновременного изменения состояния несколькими людьми.
### Используйте существующие общие и общественные модули
Вместо того, чтобы писать собственные модули для всего и изобретать велосипед, проверьте, нет ли уже модуля для вашего варианта использования. Таким образом, вы можете сэкономить время и использовать мощь сообщества Terraform. 
### Импорт существующей инфраструктуры
Если вы унаследовали проект, которому несколько лет, есть вероятность, что некоторые части его инфраструктуры были созданы вручную. Не бойтесь, вы можете импортировать существующую инфраструктуру в Terraform и избежать управления инфраструктурой с нескольких конечных точек.
### Избегайте жесткого кодирования переменных
Вот это плохо:
```hcl
aws_account_id=”99999999999”
```
Может возникнуть соблазн жестко закодировать некоторые значения здесь и там, но постарайтесь избегать этого, насколько это возможно. Подумайте, не будет ли более разумно определить напрямую присваиваемое вами значение как переменную, чтобы облегчить внесение изменений в будущем. Более того, проверьте, можете ли вы получить значение атрибута через источник данных , а не задавать его явно.
### Всегда форматируйте и проверяйте
В IaC согласованность имеет важное значение в долгосрочной перспективе, и Terraform предоставляет нам некоторые инструменты, которые помогут нам в этом поиске. Не забудьте запустить terraform fmt и terraform validate, чтобы правильно отформатировать код и обнаружить любые проблемы, которые вы пропустили. В идеале это должно делаться автоматически магическим образом через конвейер CI/CD или pre-commit hooks.
### Используйте единое соглашение об именовании