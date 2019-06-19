; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -instcombine -S < %s | FileCheck %s

define i32 @cttz_neg_value(i32 %x) {
; CHECK-LABEL: @cttz_neg_value(
; CHECK-NEXT:    [[A:%.*]] = sub nsw i32 0, [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = call i32 @llvm.cttz.i32(i32 [[A]], i1 false), !range !0
; CHECK-NEXT:    ret i32 [[B]]
;
  %a = sub nsw i32 0, %x
  %b = tail call i32 @llvm.cttz.i32(i32 %a)
  ret i32 %b
}

define i64 @cttz_neg_value_64(i64 %x) {
; CHECK-LABEL: @cttz_neg_value_64(
; CHECK-NEXT:    [[A:%.*]] = sub nsw i64 0, [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[A]], i1 true), !range !1
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = sub nsw i64 0, %x
  %b = tail call i64 @llvm.cttz.i64(i64 %a, i1 true)
  ret i64 %b
}

define i64 @cttz_neg_value2_64(i64 %x) {
; CHECK-LABEL: @cttz_neg_value2_64(
; CHECK-NEXT:    [[A:%.*]] = sub nsw i64 0, [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[A]], i1 false), !range !1
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = sub nsw i64 0, %x
  %b = tail call i64 @llvm.cttz.i64(i64 %a, i1 false)
  ret i64 %b
}

define <2 x i64> @cttz_neg_value_vec(<2 x i64> %x) {
; CHECK-LABEL: @cttz_neg_value_vec(
; CHECK-NEXT:    [[A:%.*]] = sub nsw <2 x i64> zeroinitializer, [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = call <2 x i64> @llvm.cttz.v2i64(<2 x i64> [[A]], i1 false)
; CHECK-NEXT:    ret <2 x i64> [[B]]
;
  %a = sub nsw  <2 x i64> zeroinitializer, %x
  %b = tail call <2 x i64> @llvm.cttz.v2i64(<2 x i64> %a)
  ret <2 x i64> %b
}

; Negative tests

define i32 @cttz_nonneg_value(i32 %x) {
; CHECK-LABEL: @cttz_nonneg_value(
; CHECK-NEXT:    [[A:%.*]] = sub nsw i32 1, [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = call i32 @llvm.cttz.i32(i32 [[A]], i1 false), !range !0
; CHECK-NEXT:    ret i32 [[B]]
;
  %a = sub nsw i32 1, %x
  %b = tail call i32 @llvm.cttz.i32(i32 %a)
  ret i32 %b
}

define <2 x i64> @cttz_nonneg_value_vec(<2 x i64> %x) {
; CHECK-LABEL: @cttz_nonneg_value_vec(
; CHECK-NEXT:    [[A:%.*]] = sub nsw <2 x i64> <i64 1, i64 0>, [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = call <2 x i64> @llvm.cttz.v2i64(<2 x i64> [[A]], i1 false)
; CHECK-NEXT:    ret <2 x i64> [[B]]
;
  %a = sub nsw  <2 x i64> <i64 1, i64 0>, %x
  %b = tail call <2 x i64> @llvm.cttz.v2i64(<2 x i64> %a)
  ret <2 x i64> %b
}

declare i32 @llvm.cttz.i32(i32)
declare i64 @llvm.cttz.i64(i64, i1)
declare <2 x i64> @llvm.cttz.v2i64(<2 x i64>)
