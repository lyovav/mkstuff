!!! СБОРКА ПОКА НЕ РАБОТАЕТ: Ардуиновский avrdude не поддерживает 328-ой камень, только 328P

Для конкретно моей платы: 

c:\Program Files (x86)\Arduino\hardware\arduino\boards.txt 

добавляем в начало

##############################################################

wcduino.name=WCDuino
wcduino.upload.protocol=usbaspf
wcduino.upload.maximum_size=32256
wcduino.upload.speed=115200
wcduino.bootloader.low_fuses=0xff
wcduino.bootloader.high_fuses=0xde
wcduino.bootloader.extended_fuses=0x05
wcduino.bootloader.path=optiboot
wcduino.bootloader.file=optiboot_atmega328.hex
wcduino.bootloader.unlock_bits=0x3F
wcduino.bootloader.lock_bits=0x0F
wcduino.build.mcu=atmega328p
wcduino.build.f_cpu=16000000L
wcduino.build.core=arduino
wcduino.build.variant=standard 

А в файл

c:\Program Files (x86)\Arduino\hardware\arduino\programmers.txt 

добавляем 

usbaspf.name=USBasp -F Forced
usbaspf.communication=usb
usbaspf.protocol=usbasp
usbaspf.force=true

PS: Пути установки могут отличатся от приведенныйх мной.
Будьте внимательны.