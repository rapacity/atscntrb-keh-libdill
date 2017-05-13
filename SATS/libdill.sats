
%{#
#ifndef ATSCNTRB_KEH_LIBDILL_LIBDILL_SATS
#define ATSCNTRB_KEH_LIBDILL_LIBDILL_SATS
#pragma push_macro("asm")
#undef asm
#define asm __asm__
#include <libdill.h>

int __attribute__ ((noinline)) my_chsend(int ch, const void *val, size_t len, int64_t deadline) {
  return chsend(ch, val, len, deadline);
}

int __attribute__ ((noinline)) my_chrecv(int ch, void *val, size_t len, int64_t deadline) {
  return chrecv(ch, val, len, deadline);
}

//coroutine ATSstatic() atsvoid_t0ype apply_and_consume_cloptr(atstype_cloptr arg0) {
coroutine void apply_and_consume_cloptr(atstype_cloptr arg0) {
  ATSfunbody_beg()
  ATSINSflab(__patsflab_apply_and_consume_cloptr):
  ATSINSmove_void(dilltmp942, ATSfunclo_clo(ATSPMVrefarg0(arg0), (atstype_cloptr), atsvoid_t0ype)(ATSPMVrefarg0(arg0)));
  ATSINSmove_void(dilltmp943, atspre_cloptr_free(arg0));
//  ATSINSmove_void(dilltmpret941, ATSPMVempty());
  ATSfunbody_end()
//  ATSreturn_void(dilltmpret941);
}

int __attribute__ ((noinline)) go_cloptr(atstype_cloptr arg0) {
  return go(apply_and_consume_cloptr(arg0));
}

struct chclause chclause_make(int op, int ch, void* ptr, size_t len) {
  return (struct chclause){ op, ch, ptr, len };
}



#pragma pop_macro("asm")
#endif
%}

// http://libdill.org/documentation.html 

typedef hvfs_ptr = $extype"struct hvfs*"
typedef chmem_ptr = $extype"struct chmem*"
typedef timestamp_t = llint // int64_t

macdef errno     = $extval(int, "errno")
macdef EBADF     = $extval(int, "EBADF")
macdef ECANCELED = $extval(int, "ECANCELED")
macdef EINVAL    = $extval(int, "EINVAL")
macdef ENOTSUP   = $extval(int, "ENOTSUP")
macdef EPIPE     = $extval(int, "EPIPE")
macdef ETIMEDOUT = $extval(int, "ETIMEDOUT")

typedef chclause = $extype "struct chclause"
macdef CHSEND    = $extval(int, "CHSEND")
macdef CHRECV    = $extval(int, "CHRECV")

fun chclause(int, int, ptr, size_t): chclause = "mac#chclause_make"

// --------------------------------------------------------------------------- 

fun hdone(int, llint): int = "mac#hdone"
fun chdone(int): int = "mac#chdone"
fun chmake(size_t): int = "mac#chmake"
fun chmake_mem(size_t, chmem_ptr): int = "mac#chmake_mem"
fun choose(chclauses: ptr (*struct chclause **), nclauses: int, deadline: timestamp_t): int = "mac#choose"
fun chrecv{a:vt@ype}(int, &INV(a)? >> INV(a), size_t, timestamp_t): int = "mac#my_chrecv"
fun chsend{a:vt@ype}(int, &INV(a), size_t, timestamp_t): int = "mac#my_chsend"
fun fdclean(fd:int): void = "mac#fdclean"
fun fdin(fd: int, deadline: timestamp_t): void = "mac#fdin"
fun fdout(fd: int, deadline: timestamp_t): void = "mac#fdout"
fun hclose(int): int = "mac#hclose"
fun hdup(int): int = "mac#hdup"
fun hmake(hvfs_ptr): int = "mac#hmake"
fun hquery(int, ptr): void = "mac#hquery"
fun msleep(timestamp_t): int = "mac#msleep"
fun now(): timestamp_t = "mac#now"
fun yield(): int = "mac#yield"

// --------------------------------------------------------------------------- 

fun chrecv_ptr(int, ptr, size_t, llint): int = "mac#chrecv"
fun chsend_ptr(int, ptr, size_t, llint): int = "mac#chsend"

// --------------------------------------------------------------------------- 

fun go_cloptr(() -<lin,cloptr1> void): int = "mac#go_cloptr"
macdef go(f) = go_cloptr(llam() =<lin,cloptr1> ,(f))

// --------------------------------------------------------------------------- 

dataviewtype linbox(A:vt@ype) = linbox(A) of (A)
fun {}chmake_boxed(): int
fun {a:vt@ype}chrecv_boxed(ch: int): Option_vt(a)
fun {a:vt@ype}chsend_boxed(ch: int, v: a): Option_vt(a)


