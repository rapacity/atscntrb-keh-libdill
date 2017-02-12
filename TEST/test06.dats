//
// http://libdill.org/ 
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "../SATS/libdill.sats"
staload _ = "../DATS/libdill.dats"


//fun worker(ch: &channel_id): void = let
//  val (rc, p) = chrecvs_ptr(ch)
//  val () = println!("n: ", $UN.cast{string}(p))
//in end
//  

fun worker(ch: &channel_id): void = let
  val (rc, p) = chrecvs_ptr(ch)
  val () = assertloc(rc = 0)
  val () = println!("n: ", $UN.cast{string}(p))
in end
  

implement main0() = let
  var n : int = 921
  var ch : channel_id = chmakes<ptr>()
  val ()  = assertloc(ch >= 0)
  val cr1 = make_coroutine_v(lam (x) => worker(x), ch)
  val ()  = assertloc(cr1 >= 0)
  val rc  = chsends_ptr(ch, string2ptr("Hello, World!"))
  val ()  = assertloc(rc = 0)
  val ()  = println!("Main Here!")
  val rc  = msleep(now() + 100LL)
  val ()  = assertloc(rc = 0)
  val rc  = hclose(cr1)
  val ()  = assertloc(rc = 0)
in end

