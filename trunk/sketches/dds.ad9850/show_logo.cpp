#include <stdint.h>

void prints(uint8_t row, char const* text);

void show_logo()
{
  prints(0, " [WCD] mini-DDS ");
  prints(1, " M.Nikonov 2015 ");
}
