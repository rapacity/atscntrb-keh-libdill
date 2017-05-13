//
// http://libdill.org/ 
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "./../SATS/libdill.sats"
staload _ = "./../DATS/libdill.dats"


fun worker(ch: int): void = let
  val-~Some_vt(n) = chrecv_boxed<int>(ch)
  val () = println!("n: ", n)
in end
  

implement main0() = let
  val ch         = chmake_boxed()
  val ()         = assertloc(ch >= 0)
  val cr1        = go(worker(ch))
  val ()         = assertloc(cr1 >= 0)
  val-~None_vt() = chsend_boxed<int>(ch, 921)
  val rc         = msleep(now() + 100LL)
  val ()         = assertloc(rc = 0)
  val rc         = hclose(cr1)
  val ()         = assertloc(rc = 0)
in end

