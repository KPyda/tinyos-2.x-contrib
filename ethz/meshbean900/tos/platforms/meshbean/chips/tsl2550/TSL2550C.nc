/* Copyright (c) 2009, Distributed Computing Group (DCG), ETH Zurich.
*  All rights reserved.
*
*  Redistribution and use in source and binary forms, with or without
*  modification, are permitted provided that the following conditions
*  are met:
*
*  1. Redistributions of source code must retain the above copyright
*     notice, this list of conditions and the following disclaimer.
*  2. Redistributions in binary form must reproduce the above copyright
*     notice, this list of conditions and the following disclaimer in the
*     documentation and/or other materials provided with the distribution.
*  3. Neither the name of the copyright holders nor the names of
*     contributors may be used to endorse or promote products derived
*     from this software without specific prior written permission.
*
*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS `AS IS'
*  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
*  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
*  ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS
*  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
*  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, LOSS OF USE, DATA,
*  OR PROFITS) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
*  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
*  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
*  THE POSSIBILITY OF SUCH DAMAGE.
*
*  @author Philipp Sommer <sommer@tik.ee.ethz.ch>
* 
* 
*/

generic configuration TSL2550C() {
	
  provides interface Read<uint8_t> as Channel0;
  provides interface DeviceMetadata as Channel0Metadata;
	
  provides interface Read<uint8_t> as Channel1;
  provides interface DeviceMetadata as Channel1Metadata;
	
  provides interface SplitControl;
}

implementation {
	
  enum {
    TSL2550_RESOURCE_0 = unique("TSL2550.Resource"),
    TSL2550_RESOURCE_1 = unique("TSL2550.Resource"),
    TSL2550_LOGIC = unique("TSL2550.Logic")
  };
	
  components new TSL2550ReaderP(), HalTSL2550C;
	
  Channel0 = TSL2550ReaderP.Channel0;
  Channel1 = TSL2550ReaderP.Channel1;
	
  Channel0Metadata = TSL2550ReaderP.Channel0Metadata;
  Channel1Metadata = TSL2550ReaderP.Channel1Metadata;
	
  SplitControl = HalTSL2550C;
	
  TSL2550ReaderP.Resource0 -> HalTSL2550C.Resource[TSL2550_RESOURCE_0];
  TSL2550ReaderP.Resource1 -> HalTSL2550C.Resource[TSL2550_RESOURCE_1];
  TSL2550ReaderP.TSL2550 -> HalTSL2550C.TSL2550[TSL2550_LOGIC];
		
}
