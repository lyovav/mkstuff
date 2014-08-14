################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../WiFi/WiFi.cpp \
../WiFi/WiFiClient.cpp \
../WiFi/WiFiServer.cpp \
../WiFi/WiFiUdp.cpp 

OBJS += \
./WiFi/WiFi.o \
./WiFi/WiFiClient.o \
./WiFi/WiFiServer.o \
./WiFi/WiFiUdp.o 

CPP_DEPS += \
./WiFi/WiFi.d \
./WiFi/WiFiClient.d \
./WiFi/WiFiServer.d \
./WiFi/WiFiUdp.d 


# Each subdirectory must supply rules for building sources it contributes
WiFi/%.o: ../WiFi/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: AVR C++ Compiler'
	avr-g++ -I"F:\mks\projroot\arduino-crt" -I"F:\mks\projroot\arduino-crt\variants\standard" -Wall -g2 -gstabs -O0 -fpack-struct -fshort-enums -funsigned-char -funsigned-bitfields -fno-exceptions -mmcu=atmega328p -DF_CPU=8000000UL -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


