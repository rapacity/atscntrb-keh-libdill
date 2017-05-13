//
// http://libdill.org/ 
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "./../SATS/libdill.sats"


fun worker(ch: int): void = let
  var n : int?
  val rc = chrecv(ch, n, sizeof<int>, ~1LL)
  val () = println!("n: ", n)
in end
  

implement main0() = let
  var n   = 921
  val ch  = chmake(sizeof<int>)
  val ()  = assertloc(ch >= 0)
  val cr1 = go(worker(ch))
  val ()  = assertloc(cr1 >= 0)
  val rc  = chsend(ch, n, sizeof<int>, ~1LL)
  val ()  = assertloc(rc = 0)
  val rc  = msleep(now() + 100LL)
  val ()  = assertloc(rc = 0)
  val rc  = hclose(cr1)
  val ()  = assertloc(rc = 0)
in end

