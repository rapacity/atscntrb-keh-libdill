//
// http://libdill.org/ 
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "../SATS/libdill.sats"




fun loop(msg: string, n: int): void =
  if n <= 0 then
    ()
  else {
    val () = println!(msg)
    val _ = msleep(now() + 100ll)
    val _ = loop(msg, n-1)
  }

implement main0() = {
  val x0 = go(loop("Hello 4", 15))
  val x1 = go(loop("Hello 0", 1))
  val x2 = go(loop("Hello 1", 1))
  val x3 = go(loop("Hello 2", 1))
  val x4 = go(loop("Hello 3", 1))
  val _  = hdone(x0, ~1ll)
  val _  = hdone(x1, ~1ll)
  val _  = hdone(x2, ~1ll)
  val _  = hdone(x3, ~1ll)
  val _  = hdone(x4, ~1ll)
  val _  = msleep(now() + 2000ll)
  val _  = hclose(x0)
  val _  = hclose(x1)
  val _  = hclose(x2)
  val _  = hclose(x3)
  val _  = hclose(x4)
  val () = println!("all done")
  val x0 = go(loop("Hello 4", 15))
  val _  = msleep(now() + 2000ll)
  val () = println!("all done2")

}

