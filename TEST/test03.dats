//
// http://libdill.org/ 
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "../SATS/libdill.sats"


fun worker(ch: &channel_id): void = let
  var n : int?
  val rc = chrecv(ch, n, sizeof<int>, ~1LL)
  val () = println!("n: ", n)
in end
  

implement main0() = let
  var n : int = 921
  var ch : channel_id = chmake(sizeof<int>)
  val ()  = assertloc(ch >= 0)
  val cr1 = make_coroutine_v(lam (x) => worker(x), ch)
  val ()  = assertloc(cr1 >= 0)
  val rc  = chsend(ch, n, sizeof<int>, ~1LL)
  val ()  = assertloc(rc = 0)
  val rc  = msleep(now() + 100LL)
  val ()  = assertloc(rc = 0)
  val rc  = hclose(cr1)
  val ()  = assertloc(rc = 0)
in end

