//
// http://libdill.org/ 
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "./../SATS/libdill.sats"



fun worker(count: int, text: string): void = let
  var i : int
  val () = for (i := 0; i != count; i := i+1) {
    val () = println!(text)
    val rc = msleep(now() + 10LL)
    val () = assertloc(rc = 0)
  }
in end
  


implement main0() = let
  val cr1 = go(worker(4, "a"))
  val ()  = assertloc(cr1 >= 0)
  val cr2 = go(worker(2, "b"))
  val ()  = assertloc(cr2 >= 0)
  val cr3 = go(worker(3, "c"))
  val ()  = assertloc(cr3 >= 0)
  val rc  = msleep(now() + 100LL)
  val ()  = assertloc(rc = 0)
  val rc  = hclose(cr1)
  val ()  = assertloc(rc = 0)
  val rc  = hclose(cr2)
  val ()  = assertloc(rc = 0)
  val rc  = hclose(cr3)
  val ()  = assertloc(rc = 0)
in end

