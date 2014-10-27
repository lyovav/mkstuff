
########### Compile C source only
 
$(ObjD)/font.o: ./font.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/lcd-draw.o: ./lcd-draw.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/DisplayValue.o: ./DisplayValue.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/function_menu.o: ./function_menu.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/message_key_released.o: ./message_key_released.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/ReadCapacity.o: ./ReadCapacity.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/CalibrationCap.o: ./CalibrationCap.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/ReadBigCap.o: ./ReadBigCap.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/ReadInductance.o: ./ReadInductance.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/Calibrate_UR.o: ./Calibrate_UR.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/CheckPins.o: ./CheckPins.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/GetVloss.o: ./GetVloss.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/GetFrequency.o: ./GetFrequency.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/CheckRotaryEncoder.o: ./CheckRotaryEncoder.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/main.o: ./main.c $(MKFILES) Transistortester.h
	$(CC) $(INCLUDES) $(CFLAGS) -D$(UI_LANGUAGE) -c  $< -o $@

$(ObjD)/ChargePin10ms.o: ./ChargePin10ms.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/EntladePins.o: ./EntladePins.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

$(ObjD)/EE_check_init.o: ./EE_check_init.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@
	
$(ObjD)/ShowData.o: ./ShowData.c $(MKFILES)
	$(CC) $(INCLUDES) $(CFLAGS) -c  $< -o $@

##Link
$(TARGET): $(OBJECTS)
	mkdir -p $(ObjD)
	 $(CC) $(LDFLAGS) $(OBJECTS) $(LINKONLYOBJECTS) $(LIBDIRS) $(LIBS) -o $(TARGET)

%.hex: $(TARGET)
	avr-objcopy -O ihex $(HEX_FLASH_FLAGS)  $< $@

%.eep: $(TARGET)
	-avr-objcopy $(HEX_EEPROM_FLAGS) -O ihex $< $@ || exit 0

%.lss: $(TARGET)
	avr-objdump -h -S $< > $@

size: ${TARGET}
	@echo
	@echo $(OP_MHZ) MHz operation configured.
	@avr-size -C --mcu=${MCU} ${TARGET}

## Clean target
.PHONY: clean
clean:
	-rm -rf $(OBJECTS) $(PROJECT).elf dep/* $(PROJECT).hex $(PROJECT).eep $(PROJECT).lss $(PROJECT).map
steril:
	$(MAKE)
	-rm -rf $(OBJECTS) $(PROJECT).elf dep/* $(PROJECT).lss $(PROJECT).map


## Other dependencies
-include $(shell mkdir dep 2>/dev/null) $(wildcard dep/*)


# device programming
# make fuses  call if you don't have installed a crystal
fuses:
	avrdude -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT)  $(FUSES_INT)

# fuses-crytal can only used if a 8MHz Crytal is installed (between Pin 9 and 10)
fuses-crystal:
	avrdude -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT)  $(FUSES_CRY)
fuses-crystal-lp:
	avrdude -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT)  $(FUSES_CRY_L)

# erases the FLASH ROM, EEPROM and clears all lock bits 
erase:
	avrdude -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT) -e

# make upload  additionally calls make to compile the software for selected target
upload:
	$(MAKE)
	avrdude -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT) -U flash:w:./$(PROJECT).hex:a \
	-U eeprom:w:./$(PROJECT).eep:a
program:
	$(MAKE)
	avrdude -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT) -U flash:w:./$(PROJECT).hex:a \
	-U eeprom:w:./$(PROJECT).eep:a
flash:
	avrdude -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT) -U flash:w:./$(PROJECT).hex:a 
eeprom:
	avrdude -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT) \
	-U eeprom:w:./$(PROJECT).eep:a
eeread:
	avrdude -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT) \
	-U eeprom:r:./TTactual.eep:i
verify:
	avrdude -D -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT) -U flash:v:./$(PROJECT).hex:a \
	-U eeprom:v:./$(PROJECT).eep:a -v
upload_orig:
	avrdude -c $(PROGRAMMER) -B $(BitClock) -p $(PARTNO) -P $(PORT) -U flash:w:./TransistorTestorig.hex:a \
	-U eeprom:w:./TransistorTestorig.eep:a
