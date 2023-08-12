//#include "MurmurHash3.h"
#include<iostream>
using namespace std;
#include <chrono>
using namespace std::chrono;
#include <time.h>

void MurmurHash3_x86_32  ( const void * key, int len, void * out );

#define	FORCE_INLINE inline __attribute__((always_inline))

FORCE_INLINE uint32_t getblock32 ( const uint32_t * p, int i )
{
  return p[i];
}

inline uint32_t ROTL32 ( uint32_t x, int8_t r )
{
  return (x << r) | (x >> (32 - r));
}

FORCE_INLINE uint32_t fmix32 ( uint32_t h )
{
  h ^= h >> 16;
  h *= 0x85ebca6b;
  h ^= h >> 13;
  h *= 0xc2b2ae35;
  h ^= h >> 16;

  return h;
}




int main()
{
    cout << "hello world\n";
    uint32_t out = 0x00000000;
    const uint8_t key[32][4]= {
                        {255,255,255,255},
                        {171,171,171,171},
                        {255,255,255,255},
                        {171,171,171,171},
                        {255,255,255,255},
                        {171,171,171,171},
                        {255,255,255,255},
                        {171,171,171,171},
                        {255,255,255,255},
                        {171,2,171,171},
                        {255,255,255,255},
                        {171,171,171,171},
                        {255,255,255,255},
                        {171,171,171,171},
                        {255,255,255,255},
                        {171,171,171,171},
                        {255,255,255,255},
                        {171,171,5,171},
                        {255,255,255,255},
                        {171,171,171,171},
                        {255,255,255,255},
                        {171,171,171,171},
                        {255,255,255,255},
                        {171,171,171,171},
                        {255,255,255,255},
                        {171,1,171,171},
                        {255,255,255,255},
                        {171,171,9,171},
                        {255,255,255,255},
                        {171,171,171,124},
                        {255,255,52,255},
                        {255,255,255,255}
                        }; 
    int len = 4;
    int test = 4;
    
    //auto start = high_resolution_clock::now();   

    struct timespec begin2;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &begin2);

    for(int i = 0; i < 256*256*256*8 ; i++) 
    {
    MurmurHash3_x86_32 ( key[i%32], len, &out);
    }

    struct timespec end2;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end2);
    //auto stop = high_resolution_clock::now();


    //auto duration = duration_cast<nanoseconds>(stop - start);
    double time_spent2 = (end2.tv_sec - begin2.tv_sec) + (end2.tv_nsec - begin2.tv_nsec) / 1000000000.0;


    cout<<"result is ";
    cout<<hex<<out<<"\n";
    //cout<<hex<<key[0]<<"\n";

    //cout << duration.count() << endl;
    printf("Time it took to execute (CPU TIME): %lf\n", time_spent2);
    //scanf("%d", test);


    return 0;
}

void MurmurHash3_x86_32 ( const void * key, int len,
                          void * out )
{
  const uint8_t * data = (const uint8_t*)key;
  const int nblocks = len / 4;

  uint32_t h1 = 0x00000000;

  const uint32_t c1 = 0xcc9e2d51;
  const uint32_t c2 = 0x1b873593;

  //----------
  // body

  const uint32_t * blocks = (const uint32_t *)(data + nblocks*4);

  for(int i = -nblocks; i; i++)
  {
    uint32_t k1 = getblock32(blocks,i);

    k1 *= c1;
    //cout<<hex<<k1<<"\n";
    k1 = ROTL32(k1,15);
    //cout<<hex<<k1<<"\n";
    k1 *= c2;
    //cout<<hex<<k1<<"\n";
    h1 ^= k1;
    h1 = ROTL32(h1,13); 
    //cout<<hex<<h1<<"\n";
    h1 = h1*5+0xe6546b64;
    //cout<<hex<<h1<<"\n";
  }

  //----------
  // tail

  const uint8_t * tail = (const uint8_t*)(data + nblocks*4);

  uint32_t k1 = 0;

  switch(len & 3)
  {
  case 3: k1 ^= tail[2] << 16;
  case 2: k1 ^= tail[1] << 8;
  case 1: k1 ^= tail[0];
          k1 *= c1; k1 = ROTL32(k1,15); k1 *= c2; h1 ^= k1;
  };

  //----------
  // finalization

  h1 ^= len;

  h1 = fmix32(h1);

  *(uint32_t*)out = h1;
} 
 
 //ters sırada