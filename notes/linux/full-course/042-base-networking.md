### **Ответы на вопросы**  

1. **Как происходит обжим витой пары?**  
   - Используется коннектор **RJ-45** и обжимные клещи (кримпер).  
   - Существуют схемы: **T568A** и **T568B**.  
   - Прямой кабель: оба конца одинаковые.  
   - Кроссовер (перекрёстный) кабель: один конец по T568A, другой по T568B.  

2. **Что такое MAC-адрес, какая у него битность?**  
   - **MAC (Media Access Control) – уникальный адрес сетевой карты**.  
   - Длина **48 бит (6 байт)**.  
   - Записывается в формате `XX:XX:XX:XX:XX:XX` (где `XX` – шестнадцатеричное число).  

3. **Можно ли назвать MAC-адрес «условно уникальным»?**  
   - Да, так как **производители стараются** выдавать уникальные MAC-адреса, но возможны дубли.  
   - MAC-адрес можно **изменить программно**.  

4. **Что такое IP-адрес?**  
   - **Уникальный адрес устройства в сети**.  
   - **IPv4 (32 бита)**: `192.168.1.1`.  
   - **IPv6 (128 бит)**: `2001:db8::ff00:42:8329`.  

5. **С помощью чего IP-адреса делятся на подсети?**  
   - С помощью **маски подсети** (`subnet mask`).  
   - Например, `/24` → `255.255.255.0` (256 адресов).  

6. **Для чего нужен broadcast?**  
   - **Широковещательная передача** – отправка данных всем устройствам в сети.  
   - Например, **ARP-запросы** (`who has 192.168.1.1?`).  

7. **В чем отличие роутера от свитча?**  
   - **Свитч (Switch)** – соединяет устройства в одной сети (2-й уровень OSI).  
   - **Роутер (Router)** – соединяет разные сети (3-й уровень OSI).  

8. **Как компьютер отправляет информацию в другую подсеть?**  
   - Передаёт данные **роутеру** (шлюзу по умолчанию).  
   - Роутер определяет маршрут и передаёт пакеты дальше.  

9. **Какие проблемы решает NAT? От чего он может защитить?**  
   - **Позволяет нескольким устройствам использовать один внешний IP**.  
   - **Скрывает внутреннюю сеть** от Интернета.  

10. **Что такое TCP и UDP, и чем они отличаются?**  
    - **TCP (Transmission Control Protocol)** – надёжный, с контролем доставки (`HTTP, FTP`).  
    - **UDP (User Datagram Protocol)** – быстрый, но без подтверждения (`DNS, VoIP`).  

11. **Как решить проблему: «Компьютеров в сети стало слишком много, чтобы выдавать им IP-адреса вручную»?**  
    - Использовать **DHCP (Dynamic Host Configuration Protocol)**.  

12. **Какой протокол используется, чтобы преобразовать название сайта `gnulinux.pro` в IP-адрес?**  
    - **DNS (Domain Name System)**.  

---

### **Задания**  

1. **Запишите /22 маску в виде x.x.x.x, сколько в ней адресов?**  
   - `/22` → `255.255.252.0`.  
   - Количество адресов: `2^(32-22) = 1024`.  

2. **Примеры протоколов, использующих TCP и UDP:**  
   - **TCP**: HTTP, HTTPS, FTP, SSH.  
   - **UDP**: DNS, DHCP, VoIP, NTP.  

3. **Соотнесите с уровнями OSI:**  
   - **Ethernet** – 2-й уровень (канальный).  
   - **IP** – 3-й уровень (сетевой).  
   - **HTTP** – 7-й уровень (прикладной).  
   - **Витая пара** – 1-й уровень (физический).  
   - **UDP** – 4-й уровень (транспортный).  
   - **DNS** – 7-й уровень (прикладной).