/*
 * "Copyright (c) 2005 Stanford University. All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and
 * its documentation for any purpose, without fee, and without written
 * agreement is hereby granted, provided that the above copyright
 * notice, the following two paragraphs and the author appear in all
 * copies of this software.
 * 
 * IN NO EVENT SHALL STANFORD UNIVERSITY BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN
 * IF STANFORD UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 * 
 * STANFORD UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND STANFORD UNIVERSITY
 * HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES,
 * ENHANCEMENTS, OR MODIFICATIONS."
 *
 * Copyright (c) 2007 University of Southern Denmark
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the the copyright holders nor the names of
 *   their contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
 * HOLDERS OR THEIR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */


/**
 * Implementation of TEP 112 (Microcontroller Power Management) for
 * the Atmega128. Power state calculation code copied from Rob
 * Szewczyk's 1.x code in HPLPowerManagementM.nc.
 * --stripped down version to provide a stub for future implementation--
 *
 * @author Philip Levis
 * @author Robert Szewczyk
 * @author Mirko Bordignon
 */

module McuSleepC {
  provides {
    interface McuSleep;
    interface McuPowerState;
  }
  uses {
    interface McuPowerOverride;
  }
}
implementation {
  /* There is no dirty bit management because the sleep mode depends on
     the amount of time remaining in timer0. Note also that the
     sleep cost depends typically depends on waiting for ASSR to clear. */

  /* Note that the power values are maintained in an order
   * based on their active components, NOT on their values.
   * Look at atm128hardware.h and page 42 of the ATmeg128
   * manual (table 17).*/
  const_uint8_t atm128PowerBits[ATM128_POWER_DOWN + 1] = {
    0,				/* idle */
    (1 << SM0),			/* adc */
    (1 << SM2) | (1 << SM1) | (1 << SM0), /* ext standby */
    (1 << SM1) | (1 << SM0),	/* power save */
    (1 << SM2) | (1 << SM1),	/* standby */
    (1 << SM1)};		/* power down */

  mcu_power_t getPowerState() {

    // for the moment we assume there's always something running
    // and therefore the MCU cannot be put in low-power modes
    return ATM128_POWER_IDLE;

    /*
    // Note: we go to sleep even if timer 1, 2, or 3's overflow interrupt
    // is enabled - this allows using these timers as TinyOS "Alarm"s
    // while still having power management.

    // Are external timers running?  
    if (TIMSK & ~(1 << OCIE0 | 1 << TOIE0 | 1 << TOIE1 | 1 << TOIE2) ||
	ETIMSK & ~(1 << TOIE3)) {
      return ATM128_POWER_IDLE;
    }
    // SPI (Radio stack on mica/micaZ
    else if (bit_is_set(SPCR, SPE)) { 
      return ATM128_POWER_IDLE;
    }
    // A UART is active
    else if ((UCSR0B | UCSR1B) & (1 << TXCIE | 1 << RXCIE)) { // UART
      return ATM128_POWER_IDLE;
    }
    // I2C (Two-wire) is active
    else if (bit_is_set(TWCR, TWEN)){
      return ATM128_POWER_IDLE;
    }
    // ADC is enabled
    else if (bit_is_set(ADCSR, ADEN)) { 
      return ATM128_POWER_ADC_NR;
    }
    else {
      return ATM128_POWER_DOWN;
      }
    */
  }
  
  async command void McuSleep.sleep() {
    
    uint8_t powerState;

    powerState = mcombine(getPowerState(), call McuPowerOverride.lowestState());
    MCUCR =
      (MCUCR & 0xe3) | 1 << SE | read_uint8_t(&atm128PowerBits[powerState]);

    sei();
    asm volatile ("sleep");
    cli();
    
  }

  async command void McuPowerState.update() {
  }

  default async command mcu_power_t McuPowerOverride.lowestState() {
    return ATM128_POWER_DOWN;
  }
}
