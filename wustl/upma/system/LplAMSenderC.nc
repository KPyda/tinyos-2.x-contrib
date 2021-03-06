#include "AM.h"

generic configuration LplAMSenderC(am_id_t AMId)
{
  provides {
    interface AMSend;
    interface Packet;
    interface AMPacket;
    interface PacketAcknowledgements as Acks;
  }
}

implementation
{
  components new DirectAMSenderC(AMId);
  components new LplAMSenderP();
  components MacControlC;
  components SystemLowPowerListeningC;

  AMSend = LplAMSenderP;
  Packet = DirectAMSenderC;
  AMPacket = DirectAMSenderC;
  Acks = DirectAMSenderC;

  LplAMSenderP.SubAMSend -> DirectAMSenderC;
  LplAMSenderP.Lpl -> MacControlC;
  LplAMSenderP.SystemLowPowerListening -> SystemLowPowerListeningC;
}
