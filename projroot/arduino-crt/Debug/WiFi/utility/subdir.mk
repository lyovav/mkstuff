################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../WiFi/utility/server_drv.cpp \
../WiFi/utility/spi_drv.cpp \
../WiFi/utility/wifi_drv.cpp 

C_SRCS += \
../WiFi/utility/socket.c 

OBJS += \
./WiFi/utility/server_drv.o \
./WiFi/utility/socket.o \
./WiFi/utility/spi_drv.o \
./WiFi/utility/wifi_drv.o 

C_DEPS += \
./WiFi/utility/socket.d 

CPP_DEPS += \
./WiFi/utility/server_drv.d \
./WiFi/utility/spi_drv.d \
./WiFi/utility/wifi_drv.d 


# Each subdirectory must supply rules for building sources it contributes
WiFi/utility/%.o: ../WiFi/utility/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: AVR C++ Compiler'
	avr-g++ -I"F:\mks\projroot\arduino-crt" -I"F:\mks\projroot\arduino-crt\variants\standard" -Wall -g2 -gstabs -O0 -fpack-struct -fshort-enums -funsigned-char -funsigned-bitfields -fno-exceptions -mmcu=atmega328p -DF_CPU=8000000UL -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

WiFi/utility/%.o: ../WiFi/utility/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: AVR Compiler'
	avr-gcc -I"F:\mks\projroot\arduino-crt" -I"F:\mks\projroot\arduino-crt\variants\standard" -Wall -g2 -gstabs -O0 -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=8000000UL -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


