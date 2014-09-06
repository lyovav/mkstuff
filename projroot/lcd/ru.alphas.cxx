#include "ru.alphas.hxx"
#include <inttypes.h>

char const* lstring[LStringCount] = 
{
// 0123456789012345
  "אבגדהוזחטיךכלםמן"
, "נסעףפץצרשקתûü‎‏ÿ"
};

struct dos_cp_symbol
{
    uint8_t symbol;
    uint8_t data[8];
};

static const dos_cp_symbol _font[] = 
{
  { 'a', { 0b00000000
         , 0b00111001
         , 0b01000101
         , 0b10000011
         , 0b10000011
         , 0b01000101
         , 0b00111001
         , 0b00000000
  }},
  { 'ב', { 0b00011100
         , 0b00100000
         , 0b01011000
         , 0b10000100
         , 0b10000010
         , 0b01000100
         , 0b00111000
         , 0b00000000
  }},
};

void init_ru_cp(Generic::LCD const& lcd)
{
    for (unsigned i=0; i < (sizeof(_font) / sizeof(_font[0])); i++)
        lcd.createChar(_font[i].symbol, _font[i].data);

    lcd.setCursor(0, 0);
    lcd.printf("%c:%d%c:%d%c:%d", 'א', 'א', 'ב', 'ב', 'ג', 'ג');

    lcd.setCursor(0, 1);
    lcd.printf("%c:%d%c:%d%c:%d", 'ד', 'ד', 'ה', 'ה', 'ו', 'ו');
}
