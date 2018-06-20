context("RecordCodec")
library(PackUnpackR)

u8 <- UnsignedCodec(1)
u16<- UnsignedCodec(2)
u32<- UnsignedCodec(4)

s8 <- SignedCodec(1)
s16<- SignedCodec(2)
s32<- SignedCodec(4)

cl <- list(u32,u8,u16,s8,s32,s16)

rc <- RecordCodec(cl,1)

d <- raw_byte_stream(list(0,0,255,0,128,0,255,128,255,255,255,255,0,128,0,0,255,0,128,0,255,128,255,255,255,255,0,128))
v <- list(255*256^2,128,255*256+0,-2^7,-1,-2^15)
test_that("MixedRecord",{
  expect_equal(decode(rc,d),v)
  expect_equal(decode(rc,d),v)
})

d <- raw_byte_stream(list(0,0,255,0,128,0,255,128,255,255,255,255,0,128,0,0,255,0,128,0,255,128,255,255,255,255,0,128,0,0,255,0,128,0,255,128,255,255,255,255,0,128,0,0,255,0,128,0,255,128,255,255,255,255,0,128))
rc4 <-permute_to_array(rc,4)

test_that("MixedRecord Array",{
  expect_equal(decode(rc4,d),v)
})
