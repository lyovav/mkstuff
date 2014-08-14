################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../CDC.cpp \
../HID.cpp \
../HardwareSerial.cpp \
../IPAddress.cpp \
../LiquidCrystal.cpp \
../Print.cpp \
../SoftwareSerial.cpp \
../Stream.cpp \
../Tone.cpp \
../USBCore.cpp \
../WMath.cpp \
../WString.cpp \
../Wire.cpp \
../main.cpp \
../new.cpp 

C_SRCS += \
../WInterrupts.c \
../twi.c \
../wiring.c \
../wiring_analog.c \
../wiring_digital.c \
../wiring_pulse.c \
../wiring_shift.c 

CXX_SRCS += \
../CRTMisc.cxx 

OBJS += \
./CDC.o \
./CRTMisc.o \
./HID.o \
./HardwareSerial.o \
./IPAddress.o \
./LiquidCrystal.o \
./Print.o \
./SoftwareSerial.o \
./Stream.o \
./Tone.o \
./USBCore.o \
./WInterrupts.o \
./WMath.o \
./WString.o \
./Wire.o \
./main.o \
./new.o \
./twi.o \
./wiring.o \
./wiring_analog.o \
./wiring_digital.o \
./wiring_pulse.o \
./wiring_shift.o 

C_DEPS += \
./WInterrupts.d \
./twi.d \
./wiring.d \
./wiring_analog.d \
./wiring_digital.d \
./wiring_pulse.d \
./wiring_shift.d 

CXX_DEPS += \
./CRTMisc.d 

CPP_DEPS += \
./CDC.d \
./HID.d \
./HardwareSerial.d \
./IPAddress.d \
./LiquidCrystal.d \
./Print.d \
./SoftwareSerial.d \
./Stream.d \
./Tone.d \
./USBCore.d \
./WMath.d \
./WString.d \
./Wire.d \
./main.d \
./new.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: AVR C++ Compiler'
	avr-g++ -I"F:\mks\projroot\arduino-crt" -I"F:\mks\projroot\arduino-crt\variants\standard" -Wall -g2 -gstabs -O0 -fpack-struct -fshort-enums -funsigned-char -funsigned-bitfields -fno-exceptions -mmcu=atmega328p -DF_CPU=8000000UL -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

%.o: ../%.cxx
	@echo 'Building file: $<'
	@echo 'Invoking: AVR C++ Compiler'
	avr-g++ -I"F:\mks\projroot\arduino-crt" -I"F:\mks\projroot\arduino-crt\variants\standard" -Wall -g2 -gstabs -O0 -fpack-struct -fshort-enums -funsigned-char -funsigned-bitfields -fno-exceptions -mmcu=atmega328p -DF_CPU=8000000UL -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: AVR Compiler'
	avr-gcc -I"F:\mks\projroot\arduino-crt" -I"F:\mks\projroot\arduino-crt\variants\standard" -Wall -g2 -gstabs -O0 -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=8000000UL -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


