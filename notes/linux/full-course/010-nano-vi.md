### **Практические задания:**  

#### **1. Создание директории `myfiles` и копирование файла `/etc/passwd` в неё**  
```bash
mkdir ~/myfiles
cp /etc/passwd ~/myfiles/
```

---

#### **2. Открытие файла в `nano`, поиск и удаление 16-й строки**  
```bash
nano ~/myfiles/passwd
```
- Нажмите `Ctrl + _` (нижнее подчеркивание).  
- Введите `16` и нажмите `Enter` (перейдёт на строку 16).  
- Удалите строку с помощью `Ctrl + K`.  
- Сохраните (`Ctrl + O`, `Enter`) и выйдите (`Ctrl + X`).  

---

#### **3. Найти слово `false` и заменить на `true` в `nano`**  
- Открываем файл:  
  ```bash
  nano ~/myfiles/passwd
  ```
- Нажимаем `Ctrl + \` (поиск и замена).  
- Вводим `false`, нажимаем `Enter`.  
- Вводим `true`, нажимаем `Enter`.  
- Подтверждаем замену (`A` — заменить всё).  
- Сохраняем и выходим (`Ctrl + O`, `Enter`, `Ctrl + X`).  

---

#### **4. Сделать так, чтобы нумерация строк оставалась после перезапуска `nano`**  
Добавляем параметр в конфигурацию `nano`:  
```bash
echo "set linenumbers" >> ~/.nanorc
```
Теперь строки будут нумероваться всегда.  

---

#### **5. Добавить строку "Hello" между 5 и 6 в `vi`**  
Открываем файл в `vi`:  
```bash
vi ~/myfiles/passwd
```
- Перейти на 5-ю строку: `5G`  
- Нажать `o` (откроется новая строка ниже)  
- Ввести `Hello`  
- Нажать `Esc`, затем `:wq` (сохранить и выйти)  

---

#### **6. Добавить "World" в конце файла, но выйти без сохранения в `vi`**  
Открываем файл:  
```bash
vi ~/myfiles/passwd
```
- Нажимаем `G` (переход в конец файла).  
- Нажимаем `o`, вводим `World`.  
- Выходим **без сохранения**:  
  - Нажимаем `Esc`, затем `:q!` и `Enter`.