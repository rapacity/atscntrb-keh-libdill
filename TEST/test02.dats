//
// http://libdill.org/ 
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "../SATS/libdill.sats"


fun worker(n: &int): void = let
  val () = println!("n: ", n)
in end
  

implement main0() = let
  var n : int = 6666
  val cr1 = make_coroutine_v(lam (x) => worker(x), n)
  val ()  = assertloc(cr1 >= 0)
  val rc  = msleep(now() + 100LL)
  val ()  = assertloc(rc = 0)
  val rc  = hclose(cr1)
  val ()  = assertloc(rc = 0)
in end

