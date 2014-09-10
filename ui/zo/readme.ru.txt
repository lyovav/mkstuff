10.09.2014 ----------------------------------------------------------------------

v 2.0.1: Реализована галерея - 
         Программа парсит каталог `gallery` и грузит из него все картинки, 
         потом показывает их в режиме слайдшоу в нижней панели формы. Для
         визуального восприятия - самое оно!
         Настройка:
         Создаём файл 1.reg следующего содержания

Windows Registry Editor Version 5.00
[HKEY_CURRENT_USER\Software\VB and VBA Program Settings\Michael Nikonov's: The Ohm Rulez 2.0.1\Common]
"GalleryPath"="ВАШ ПУТЬ К ГАЛЕРЕЕ"
"SlideShowTimeout"="ВАШ ТАЙМАУТ ПОКАЗА в миллисекундах"

         GalleryPath - в качестве сепаратора `\` нужно вписывать `\\` т.е. "C:\Путь\К\Папке" ==> "C:\\Путь\\К\\Папке"

         https://drive.google.com/folderview?id=0BxzXbjdHEOBmZ0Vzb1pUZ1U4MVE&usp=sharing

         WARN: Перед использованием установить шрифт из .\fonts
