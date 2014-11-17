/* Rotary encoder handler for arduino. v1.1
 *
 * Copyright 2011 Ben Buxton. Licenced under the GNU GPL Version 3.
 * Contact: bb@cactii.net
 *
 * A typical mechanical rotary encoder emits a two bit gray code
 * on 3 output pins. Every step in the output (often accompanied
 * by a physical 'click') generates a specific sequence of output
 * codes on the pins.
 *
 * There are 3 pins used for the rotary encoding - one common and
 * two 'bit' pins.
 *
 * The following is the typical sequence of code on the output when
 * moving from one step to the next:
 *
 *   Position   Bit1   Bit2
 *   ----------------------
 *     Step1     0      0
 *      1/4      1      0
 *      1/2      1      1
 *      3/4      0      1
 *     Step2     0      0
 *
 * From this table, we can see that when moving from one 'click' to
 * the next, there are 4 changes in the output code.
 *
 * - From an initial 0 - 0, Bit1 goes high, Bit0 stays low.
 * - Then both bits are high, halfway through the step.
 * - Then Bit1 goes low, but Bit2 stays high.
 * - Finally at the end of the step, both bits return to 0.
 *
 * Detecting the direction is easy - the table simply goes in the other
 * direction (read up instead of down).
 *
 * To decode this, we use a simple state machine. Every time the output
 * code changes, it follows state, until finally a full steps worth of
 * code is received (in the correct order). At the final 0-0, it returns
 * a value indicating a step in one direction or the other.
 *
 * It's also possible to use 'half-step' mode. This just emits an event
 * at both the 0-0 and 1-1 positions. This might be useful for some
 * encoders where you want to detect all positions.
 *
 * If an invalid state happens (for example we go from '0-1' straight
 * to '1-0'), the state machine resets to the start until 0-0 and the
 * next valid codes occur.
 *
 * The biggest advantage of using a state machine over other algorithms
 * is that this has inherent debounce built in. Other algorithms emit spurious
 * output with switch bounce, but this one will simply flip between
 * sub-states until the bounce settles, then continue along the state
 * machine.
 * A side effect of debounce is that fast rotations can cause steps to
 * be skipped. By not requiring debounce, fast rotations can be accurately
 * measured.
 * Another advantage is the ability to properly handle bad state, such
 * as due to EMI, etc.
 * It is also a lot simpler than others - a static state table and less
 * than 10 lines of logic.
 */

#include <Arduino.h>
#include "rotary_impl.h"

// Half-step mode?
#define HALF_STEP

// define to enable weak pullups.
#define ENABLE_PULLUPS

namespace rotary
{

#ifdef HALF_STEP
    // Use the half-step state table (emits a code at 00 and 11)
    const unsigned char ttable[6][4] =
    {
      {0x3 , 0x2, 0x1,  0x0}, {0x23, 0x0, 0x1,  0x0},
      {0x13, 0x2, 0x0,  0x0}, {0x3 , 0x5, 0x4,  0x0},
      {0x3 , 0x3, 0x4, 0x10}, {0x3 , 0x5, 0x3, 0x20}
    };
#else
    // Use the full-step state table (emits a code at 00 only)
    const unsigned char ttable[7][4] =
    {
      {0x0, 0x2, 0x4,  0x0}, {0x3, 0x0, 0x1, 0x10},
      {0x3, 0x2, 0x0,  0x0}, {0x3, 0x2, 0x1,  0x0},
      {0x6, 0x0, 0x4,  0x0}, {0x6, 0x5, 0x0, 0x10},
      {0x6, 0x5, 0x4,  0x0},
    };
#endif

    volatile static unsigned char state = 0;

    /* Call this once in setup(). */
    void init()
    {
        pinMode(ROTARY_PIN1, INPUT);
        pinMode(ROTARY_PIN2, INPUT);
#ifdef ENABLE_PULLUPS
        digitalWrite(ROTARY_PIN1, HIGH);
        digitalWrite(ROTARY_PIN2, HIGH);
#endif
    }

    /* Read input pins and process for events. Call this either from a
     * loop or an interrupt (eg pin change or timer).
     *
     * Returns 0 on no event, otherwise 0x80 or 0x40 depending on the direction.
     */
    unsigned char get_value()
    {
        unsigned char pinstate = (digitalRead(ROTARY_PIN2) << 1) | digitalRead(ROTARY_PIN1);
        state = ttable[state & 0xf][pinstate];
        return (state & 0x30);
    }
}
