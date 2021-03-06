
#include <stdint.h>
#include <stdio.h>

#include "Ieee154.h"
#include "ip.h"
#include "lib6lowpan.h"
#include "nwbyte.h"
#include "6lowpan.h"



uint8_t ctx[8] = {0x20, 0x02,1,2,3,4,5,6};
int lowpan_extern_read_context(struct in6_addr *addr, int context) {
  memcpy(addr, ctx, 8);
  return 64;
}

int lowpan_extern_match_context(struct in6_addr *addr, UNUSED uint8_t *ctx_id) {
  if (memcmp(addr, ctx, 8) == 0) {
    printf("CONTEXT MATCH!\n");
    return 64;
  } else {
    return 0;
  }
}


struct test_case {
  uint8_t  tc;
  uint32_t fl;
  uint8_t  nxt;
  uint8_t  hlim;
  char *ip6_src;
  char *ip6_dst;

  char *l2src, *l2dst;
  ieee154_panid_t   panid;

  /*  the result of executing the test case */
  int      result_len;
  uint8_t  result[64];
};

struct test_case cases[] = {
  {0, 0, 12, 100, "fe80::1", "ff02::1", "1", "65535", 10, 
   0, {}},

  {1, 0, 12, 100, "fe80::1", "fe80::2", "1", "65535", 10, 
   0, {}},

  {0, 0, 12, 100, "fe80::aa00:1122:3344:5566", "ff02::ab", "aa:00:11:22:33:44:55:66:", "0xab", 10, 0, {}},

  {0, 0, 12, 100, "2002:102:304:506:aa00:1122:3344:5566", "ff02::12:4567:abcd", "aa:00:11:22:33:44:55:66:", "0xab", 10, 0, {}},

};

void setup_test(struct test_case *cse, struct ip6_hdr *hdr, struct ieee154_frame_addr *frame) {
  uint32_t val;
  val = htonl(0x6 << 28 | ((cse->tc & 0xff) << 20) | (cse->fl & 0x000fffff));
  hdr->ip6_flow = val;
  hdr->ip6_nxt  = cse->nxt;
  hdr->ip6_plen = 0;
  hdr->ip6_hlim = cse->hlim;
  inet_pton6(cse->ip6_src, &hdr->ip6_src);
  inet_pton6(cse->ip6_dst, &hdr->ip6_dst);

  memset(frame, 0, sizeof(frame));
  ieee154_parse(cse->l2src, &frame->ieee_src);
  ieee154_parse(cse->l2dst, &frame->ieee_dst);
  frame->ieee_dstpan = htole16(cse->panid);
}

int run_tests() {
  int i;
  int success = 0, total = 0;
  for (i = 0; i < (sizeof(cases) / sizeof(cases[0])); i++) {
    uint8_t buf[512], *rp, unpack[512];
    struct ip6_packet packet;
    struct ieee154_frame_addr fr, result_fr;
    memset(buf, 0, 512);
    total++;
    printf("\n\n----- Test case %i ----\n", i+1);

    setup_test(&cases[i], &packet.ip6_hdr, &fr);
    printf("IEEE 802.15.4 frame: ");
    print_buffer(&fr, sizeof(struct ieee154_frame_addr));
    printf("\n");
    printf("IPv6 Header:\n");
    print_buffer(&packet.ip6_hdr, sizeof(struct ip6_hdr));
    printf("\n");

    rp = lowpan_pack_headers(&packet, &fr, buf, 512);
    printf("Packed result:\n");
    print_buffer(buf, rp - buf);


    rp = lowpan_unpack_headers(unpack, sizeof(unpack), &result_fr, buf, rp - buf);

    printf("Unpacked result:\n");
    print_buffer(unpack, 40);

    if (memcmp(unpack, &packet.ip6_hdr, 40) == 0)
      success++;
  }
  printf("%s: %i/%i tests succeeded\n", __FILE__, success, total);
  if (success == total) return 0;
  return 1;
}

int main() {
  return run_tests();
}
