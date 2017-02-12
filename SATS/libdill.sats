
%{#
#ifndef ATSCNTRB_KEH_LIBDILL_LIBDILL_SATS
#define ATSCNTRB_KEH_LIBDILL_LIBDILL_SATS
#pragma push_macro("asm")
#undef asm
#define asm __asm__
#include <libdill.h>

coroutine void make_coroutine_aux(void(*f)(void)) {
  f();
}

int __attribute__ ((noinline)) make_coroutine(void(*f)(void)) {
  int cr = go(make_coroutine_aux(f));
  return cr;
}

coroutine void make_coroutine_aux2(void(*f)(void*), void*v) {
  f(v);
}

int __attribute__ ((noinline)) make_coroutine_v(void(*f)(void*), void*v) {
  int cr = go(make_coroutine_aux2(f,v));
  return cr;
}

int __attribute__ ((noinline)) my_chsend(int ch, const void *val, size_t len, int64_t deadline) {
  return chsend(ch, val, len, deadline);
}


int __attribute__ ((noinline)) my_chrecv(int ch, void *val, size_t len, int64_t deadline) {
  return chrecv(ch, val, len, deadline);
}

#pragma pop_macro("asm")
#endif
%}

// http://libdill.org/documentation.html 

typedef hvfs_ptr = $extype"struct hvfs*"
typedef chmem_ptr = $extype"struct chmem*"

typedef coroutine_id = int
typedef channel_id = int
typedef timestamp_t = llint // int64_t

(*
typedef chclause = $extype_struct "struct chclause" of {
  op = int,
  ch = int,
  val = ptr,
  len = size_t
};
*)

fun chdone(channel_id): int = "mac#chdone"
fun chmake(size_t): channel_id = "mac#chmake"
fun chmake_mem(size_t, chmem_ptr): int = "mac#chmake_mem"
fun choose(chclauses: ptr (*struct chclause **), nclauses: int, deadline: timestamp_t): int = "mac#choose"
fun chrecv{a:t@ype}(channel_id, &INV(a)? >> INV(a), size_t, timestamp_t): int = "mac#my_chrecv"
fun chsend{a:t@ype}(channel_id, &INV(a), size_t, timestamp_t): int = "mac#my_chsend"
fun fdclean(fd:int): void = "mac#fdclean"
fun fdin(fd: int, deadline: timestamp_t): void = "mac#fdin"
fun fdout(fd: int, deadline: timestamp_t): void = "mac#fdout"
fun hclose(coroutine_id): int = "mac#hclose"
fun hdup(int): int = "mac#hdup"
fun hmake(hvfs_ptr): int = "mac#hmake"
fun hquery(int, ptr): void = "mac#hquery"
fun msleep(timestamp_t): int = "mac#msleep"
fun now(): timestamp_t = "mac#now"
fun yield(): int = "mac#yield"




fun{} chsends_ptr(channel_id, ptr): int
fun{} chsends_strptr(channel_id, strptr): int


fun chrecvp(channel_id, ptr, size_t, timestamp_t): int = "mac#my_chrecv"
fun{} chrecvs_strptr(channel_id): (int, strptr)
fun{} chrecvs_ptr(channel_id): (int, ptr)
fun{a:t@ype} chsends(channel_id, &INV(a)): int
fun chsendp(channel_id, ptr, size_t, timestamp_t): int = "mac#my_chsend"
fun{a:t@ype} chmakes(): channel_id
fun{a:t@ype} chrecvs(channel_id, &INV(a)? >> INV(a)): int

//fun chrecvp(channel_id, ptr, size_t, llint): int = "mac#chrecv"
//fun chsendp(channel_id, ptr, size_t, llint): int = "mac#chsend"
//fun{a:vt@ype} chsend_vt_unsafe(channel_id, a): int
//fun{a:vt@ype} chrecv_vt_unsafe(channel_id): a
//fun{a:vt@ype} chsend_vt_unsafe(channel_id, a): int
//fun{a:vt@ype} chrecv_vt_unsafe(channel_id): a

fun make_coroutine(() -> void): coroutine_id = "mac#make_coroutine"
fun make_coroutine_v{a:vt@ype}((&a) -> void, &a): coroutine_id = "mac#make_coroutine_v"
fun make_coroutine_ptr((ptr) -> void, ptr): coroutine_id = "mac#make_coroutine_v"


