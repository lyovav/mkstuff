#define SEG_A 1
#define SEG_B 2
#define SEG_C 4
#define SEG_D 8
#define SEG_E 16
#define SEG_F 32
#define SEG_G 64

#define DASH 10
#define DEGRE 18

const byte DIG_LED[20] = {
  SEG_A+SEG_B+SEG_C+SEG_D+SEG_E+SEG_F,        // 0
  SEG_B+SEG_C,                                // 1
  SEG_A+SEG_B+SEG_D+SEG_E+SEG_G,              // 2
  SEG_A+SEG_B+SEG_C+SEG_D+SEG_G,              // 3
  SEG_B+SEG_C+SEG_F+SEG_G,                    // 4
  SEG_A+SEG_C+SEG_D+SEG_F+SEG_G,              // 5
  SEG_A+SEG_C+SEG_D+SEG_E+SEG_F+SEG_G,        // 6
  SEG_A+SEG_B+SEG_C,                          // 7
  SEG_A+SEG_B+SEG_C+SEG_D+SEG_E+SEG_F+SEG_G,  // 8
  SEG_A+SEG_B+SEG_C+SEG_D+SEG_F+SEG_G,        // 9
  SEG_G,                                      // -
  SEG_C+SEG_E+SEG_G,                          // n
  SEG_C+SEG_D+SEG_E+SEG_G,                    // o
  SEG_B+SEG_C+SEG_D+SEG_E+SEG_G,              // d
  /*SEG_B+*/SEG_C+SEG_E+SEG_F+SEG_G,          // h - H
  SEG_D+SEG_E+SEG_F+SEG_G,                    // t
  SEG_A+SEG_C+SEG_E+SEG_G,                    // m
  SEG_A+SEG_B+SEG_E+SEG_F+SEG_G,              // P
  SEG_A+SEG_B+SEG_F+SEG_G                     // degre
};
