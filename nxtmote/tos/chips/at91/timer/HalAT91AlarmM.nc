/*
 * Copyright (c) 2005 Arched Rock Corporation 
 * All rights reserved. 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *	Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *	Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 *  
 *   Neither the name of the Arched Rock Corporation nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE ARCHED
 * ROCK OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
 * TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */
/** 
 * @author Phil Buonadonna
 *
 */

// @author Phil Buonadonna
/**
 * Adapted for nxtmote.
 * @author Rasmus Pedersen
 */
#include "Timer.h"

generic module HalAT91AlarmM(typedef frequency_tag, uint8_t resolution) 
{
  provides {
    interface Init;
    interface Alarm<frequency_tag,uint32_t> as Alarm;
  }
  uses {
    interface Init as OSTInit;
    interface HplAT91OSTimer as OSTChnl;
  }
}

implementation
{
  bool mfRunning;
  uint32_t mMinDeltaT;
  // When to really fire
  uint32_t mTf;
  // Counts number of compare interrupts (fires)
  uint32_t mTc;

  task void lateAlarm() {
    atomic {
      mfRunning = FALSE;
      signal Alarm.fired();
    }
  }
  
  command error_t Init.init() {

    call OSTInit.init(); 
    // Continue on match, Non-periodic, w/ given resolution
    atomic {
      mfRunning = FALSE;
      switch (resolution) {
        case 1: // 1/32768 second
  	      mMinDeltaT = 10;
  	      break;
        case 2: // 1 ms
  	      mMinDeltaT = 1;
  	      break;
        case 3: // 1 s
  	      mMinDeltaT = 1;
  	      break;
        case 4: // 1 us
  	      mMinDeltaT = 300;
  	      break;
        default:  // External
  	      mMinDeltaT = 0;
  	      break;
      }
      call OSTChnl.open();
      call OSTChnl.setTCRC(TICKSONEMSCLK2);
    }
    return SUCCESS;
  }

  async command void Alarm.start( uint32_t dt ) {
    // TODO: pending alarm

    if (dt < mMinDeltaT) 
      dt = mMinDeltaT;

    atomic {
      mTf = dt;
      mTc = 0;
      call OSTChnl.setICCR();
      call OSTChnl.setIECR();
      call OSTChnl.setSWTRG();
      mfRunning = TRUE;
    }

    return;
  }

  async command void Alarm.startAt( uint32_t t0, uint32_t dt ) {
    call Alarm.start(t0+dt);
    return;
  } 


  async command void Alarm.stop() {
    atomic {
      call OSTChnl.setIDCR();
      call OSTChnl.setICCR();
      mfRunning = FALSE;
    }
    return;
  }

  async command bool Alarm.isRunning() {
    bool flag;
    atomic flag = mfRunning;
    return flag;
  }

  async command uint32_t Alarm.getNow() {
    return mTc;
  }

  async command uint32_t Alarm.getAlarm() {
    return mTf;
  }

  async event void OSTChnl.fired() {
    // Increment the counter
    mTc++;
    
    // Check the stop condition
    if(mTc < mTf){ // continue by restarting the timer
      call OSTChnl.setSWTRG();      
    } 
    else{ //fire
      call Alarm.stop();    
      signal Alarm.fired();
    }
    return;
  }

  default async event void Alarm.fired() {
    return;
  }


}
