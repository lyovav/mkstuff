#include <stdint.h>
#include <Arduino.h>

void prints(uint8_t row, char const* text);

#define Cyr_B 0xa0
#define Cyr_b 0xb2
#define Cyr_v 0xb3
#define Cyr_G 0xa1
#define Cyr_g 0xb4
#define Cyr_D 0xe0
#define Cyr_d 0xe3
#define Cyr_Jo 0xa2
#define Cyr_jo 0xb5
#define Cyr_Zsch 0xa3
#define Cyr_zsch 0xb6
#define Cyr_Z 0xa4
#define Cyr_z 0xb7
#define Cyr_I 0xa5
#define Cyr_i 0xb8
#define Cyr_J 0xa6
#define Cyr_j 0xb9
#define Cyr_k 0xba
#define Cyr_L 0xa7
#define Cyr_l 0xbb
#define Cyr_m 0xbc
#define Cyr_n 0xbd
#define Cyr_P 0xa8
#define Cyr_p 0xbe
#define Cyr_U 0xa9
#define Cyr_t 0xbf
#define Cyr_F 0xaa
#define Cyr_f 0xe4
#define Cyr_C 0xe1
#define Cyr_c 0xe5
#define Cyr_Tsch 0xab
#define Cyr_tsch 0xc0
#define Cyr_Sch 0xac
#define Cyr_sch 0xc1
#define Cyr_Schtsch 0xe2
#define Cyr_schtsch 0xe6
#define Cyr_HH 0xad
#define Cyr_hh 0xc2
#define Cyr_Y 0xae
#define Cyr_y 0xc3
#define Cyr_ww 0xc4
#define Cyr_E 0xaf
#define Cyr_e 0xc5
#define Cyr_Ju 0xb0
#define Cyr_ju 0xc6
#define Cyr_Ja 0xb1
#define Cyr_ja 0xc7

void show_logo()
{
  static const char cyr_l1[] = { " DDS \xa1" "e\xbd" "epamop  " };
  static const char cyr_l2[] = { "H\xb8ko\xbdo\xb3 M.  2015" };
  
  prints(0, cyr_l1);
  prints(1, cyr_l2);
  
  delay(3000);
}
