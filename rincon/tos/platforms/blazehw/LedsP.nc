
/*                                                                        tab:4
 * "Copyright (c) 2000-2005 The Regents of the University  of California.  
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF
 * CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 */

/**
 * The implementation of the standard 3 LED mote abstraction.
 *
 * @author Joe Polastre
 * @author Philip Levis
 *
 * @date   March 21, 2005
 */

module LedsP {
  provides {
    interface Init;
    interface Leds;
  }
  uses {
    interface GeneralIO as Led0;
    interface GeneralIO as Led1;
    interface GeneralIO as Led2;
    interface GeneralIO as Led3;
  }
}
implementation {
  command error_t Init.init() {
    atomic {
      call Led0.clr();
      call Led1.clr();
      call Led2.clr();
      call Led3.clr();
      call Led0.makeOutput();
      call Led1.makeOutput();
      call Led2.makeOutput();
      call Led3.makeOutput();
    }
    return SUCCESS;
  }

  async command void Leds.led0On() {
    call Led0.set();
  }

  async command void Leds.led0Off() {
    call Led0.clr();
  }

  async command void Leds.led0Toggle() {
    call Led0.toggle();
  }

  async command void Leds.led1On() {
    call Led1.set();
  }

  async command void Leds.led1Off() {
    call Led1.clr();
  }

  async command void Leds.led1Toggle() {
    call Led1.toggle();
  }

  async command void Leds.led2On() {
    call Led2.set();
  }

  async command void Leds.led2Off() {
    call Led2.clr();
  }

  async command void Leds.led2Toggle() {
    call Led2.toggle();
  }

  async command void Leds.led3On() {
    call Led3.set();
  }

  async command void Leds.led3Off() {
    call Led3.clr();
  }

  async command void Leds.led3Toggle() {
    call Led3.toggle();
  }

  async command uint8_t Leds.get() {
    
    uint8_t rval;
    atomic {
      rval = 0;
      
      if (call Led0.get()) {
        rval |= LEDS_LED0;
      }
      
      if (call Led1.get()) {
        rval |= LEDS_LED1;
      }
      
      if (call Led2.get()) {
        rval |= LEDS_LED2;
      }
      
      if (call Led3.get()) {
        rval |= LEDS_LED3;
      }
    }
    
    return rval;
  }

  async command void Leds.set(uint8_t val) {
    atomic {
    
      if (val & LEDS_LED0) {
        call Leds.led0On();
      } else {
        call Leds.led0Off();
      }
      
      if (val & LEDS_LED1) {
        call Leds.led1On();
      } else {
        call Leds.led1Off();
      }
      
      if (val & LEDS_LED2) {
        call Leds.led2On();
      } else {
        call Leds.led2Off();
      }
      
      if (val & LEDS_LED3) {
        call Led3.set();
      } else {
        call Led3.clr();
      }
    }
  }
}
