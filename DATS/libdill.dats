
staload UN = "prelude/SATS/unsafe.sats"
staload "./../SATS/libdill.sats"

implement (a) chmakes<a>() =
  chmake(sizeof<a>)

implement (a) chsends<a>(ch,v) =
  chsend(ch, v, sizeof<a>, ~1LL)

implement (a) chrecvs<a>(ch,v) =
  chrecv(ch, v, sizeof<a>, ~1LL)

implement chrecvs_ptr<>(ch) = let
  var p : ptr
  val s = chrecvp(ch, addr@p, sizeof<ptr>, ~1LL)
in
  (s, p) 
end



implement chsends_ptr<>(ch,v) = let
  var p : ptr = v
in
  chsend(ch, p, sizeof<ptr>, ~1LL)
end

implement chsends_strptr<>(ch,v) =
  chsends_ptr(ch,$UN.castvwtp0{ptr}(v))


implement chrecvs_strptr<>(ch) = let
  val (st, p) = chrecvs_ptr(ch) 
in
  (st, $UN.castvwtp0{strptr}(p))
end


