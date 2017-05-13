
staload UN = "prelude/SATS/unsafe.sats"
staload "./../SATS/libdill.sats"


implement chmake_boxed<>() = chmake(sizeof<ptr>)

implement (a) chrecv_boxed<a>(ch) = let
  var p : ptr
  val n = chrecv(ch, p, sizeof<ptr>, ~1ll)
in 
  if n <> 0 then
    None_vt() // recv fail
  else let
      val~linbox(v) = $UN.ptr0_get<linbox(a)>(addr@p)
    in
      Some_vt(v)
    end
end

implement (a) chsend_boxed<a>(ch,v) = let
  var p : ptr = $UN.castvwtp0{ptr}(linbox(v))
  val n = chsend(ch, p, sizeof<ptr>, ~1ll)
in 
  if n <> 0 then let
      // if b failed to send, then b is still preserved, the user is tasked
      // with freeing it.
      val~linbox(v) = $UN.castvwtp1{linbox(a)}(p)
    in
      Some_vt(v)
    end
  else
    None_vt()
end


