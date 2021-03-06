; RUN: %llc_dwarf -filetype=obj < %s | llvm-dwarfdump -debug-dump=info - | FileCheck %s
; REQUIRES: object-emission

; Generated by clang++ -c -g -std=c++11 -S -emit-llvm from the following C++11 source
; struct S {
;   char x;
;   alignas(128) char xx;
; };
;
; class alignas(64) C0 {
; };
;
; class C1 {
;   alignas(64) static void *p;
; };
;
; enum alignas(16) E {
;   A,
;   B,
;   C,
; };
;
; C0 c0;
;
; alignas(2048) S s;
;
; void foo()
; {
;     S ss;
;     E e;
;     C1 c1;
;     alignas(32) int i = 42;
;     auto Lambda = [i](){};
; }

; CHECK: DW_TAG_class_type
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_name{{.*}}"C0"
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_alignment{{.*}}64

; CHECK: DW_TAG_variable
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_name{{.*}}"s"
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_alignment{{.*}}2048

; CHECK: DW_TAG_structure_type
; CHECK: DW_TAG_member
; CHECK: DW_AT_name{{.*}}"xx"
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_alignment{{.*}}128

; CHECK: DW_TAG_enumeration_type
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_alignment{{.*}}16

; CHECK: DW_TAG_variable
; CHECK: DW_AT_name{{.*}}"i"
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_alignment{{.*}}32
; CHECK: DW_TAG_class_type
; CHECK: DW_TAG_member
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_name{{.*}}"i"
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_alignment{{.*}}32

; CHECK: DW_TAG_class_type
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_name{{.*}}"C1"
; CHECK: DW_TAG_member
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_name{{.*}}"p"
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_alignment{{.*}}64

; ModuleID = 'test.cpp'
source_filename = "test.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.C0 = type { [64 x i8] }
%struct.S = type { i8, [127 x i8], i8, [127 x i8] }
%class.C1 = type { i8 }
%class.anon = type { i32 }

@c0 = global %class.C0 zeroinitializer, align 64, !dbg !0
@s = global %struct.S zeroinitializer, align 2048, !dbg !11

; Function Attrs: nounwind uwtable
define void @_Z3foov() #0 !dbg !22 {
entry:
  %ss = alloca %struct.S, align 128
  %e = alloca i32, align 16
  %c1 = alloca %class.C1, align 1
  %i = alloca i32, align 32
  %Lambda = alloca %class.anon, align 4
  call void @llvm.dbg.declare(metadata %struct.S* %ss, metadata !25, metadata !26), !dbg !27
  call void @llvm.dbg.declare(metadata i32* %e, metadata !28, metadata !26), !dbg !29
  call void @llvm.dbg.declare(metadata %class.C1* %c1, metadata !30, metadata !26), !dbg !35
  call void @llvm.dbg.declare(metadata i32* %i, metadata !36, metadata !26), !dbg !38
  store i32 42, i32* %i, align 32, !dbg !38
  call void @llvm.dbg.declare(metadata %class.anon* %Lambda, metadata !39, metadata !26), !dbg !48
  %0 = getelementptr inbounds %class.anon, %class.anon* %Lambda, i32 0, i32 0, !dbg !49
  %1 = load i32, i32* %i, align 32, !dbg !50
  store i32 %1, i32* %0, align 4, !dbg !49
  ret void, !dbg !51
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { nounwind uwtable }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!1}
!llvm.module.flags = !{!19, !20}
!llvm.ident = !{!21}

!0 = distinct !DIGlobalVariableExpression(var: !DIGlobalVariable(name: "c0", scope: !1, file: !5, line: 19, type: !17, isLocal: false, isDefinition: true))
!1 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !2, producer: "clang version 4.0.0 (http://llvm.org/git/clang.git 9ce5220b821054019059c2ac4a9b132c7723832d) (http://llvm.org/git/llvm.git 9a6298be89ce0359b151c0a37af2776a12c69e85)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !3, globals: !10)
!2 = !DIFile(filename: "test.cpp", directory: "/tmp")
!3 = !{!4}
!4 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "E", file: !5, line: 13, size: 32, align: 128, elements: !6, identifier: "_ZTS1E")
!5 = !DIFile(filename: "./test.cpp", directory: "/tmp")
!6 = !{!7, !8, !9}
!7 = !DIEnumerator(name: "A", value: 0)
!8 = !DIEnumerator(name: "B", value: 1)
!9 = !DIEnumerator(name: "C", value: 2)
!10 = !{!0, !11}
!11 = distinct !DIGlobalVariableExpression(var: !DIGlobalVariable(name: "s", scope: !1, file: !5, line: 21, type: !12, isLocal: false, isDefinition: true, align: 16384))
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S", file: !5, line: 1, size: 2048, elements: !13, identifier: "_ZTS1S")
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !12, file: !5, line: 2, baseType: !15, size: 8)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "xx", scope: !12, file: !5, line: 3, baseType: !15, size: 8, align: 1024, offset: 1024)
!17 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "C0", file: !5, line: 6, size: 512, align: 512, elements: !18, identifier: "_ZTS2C0")
!18 = !{}
!19 = !{i32 2, !"Dwarf Version", i32 4}
!20 = !{i32 2, !"Debug Info Version", i32 3}
!21 = !{!"clang version 4.0.0 (http://llvm.org/git/clang.git 9ce5220b821054019059c2ac4a9b132c7723832d) (http://llvm.org/git/llvm.git 9a6298be89ce0359b151c0a37af2776a12c69e85)"}
!22 = distinct !DISubprogram(name: "foo", linkageName: "_Z3foov", scope: !5, file: !5, line: 23, type: !23, isLocal: false, isDefinition: true, scopeLine: 24, flags: DIFlagPrototyped, isOptimized: false, unit: !1, variables: !18)
!23 = !DISubroutineType(types: !24)
!24 = !{null}
!25 = !DILocalVariable(name: "ss", scope: !22, file: !5, line: 25, type: !12)
!26 = !DIExpression()
!27 = !DILocation(line: 25, column: 7, scope: !22)
!28 = !DILocalVariable(name: "e", scope: !22, file: !5, line: 26, type: !4)
!29 = !DILocation(line: 26, column: 7, scope: !22)
!30 = !DILocalVariable(name: "c1", scope: !22, file: !5, line: 27, type: !31)
!31 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "C1", file: !5, line: 9, size: 8, elements: !32, identifier: "_ZTS2C1")
!32 = !{!33}
!33 = !DIDerivedType(tag: DW_TAG_member, name: "p", scope: !31, file: !5, line: 10, baseType: !34, align: 512, flags: DIFlagStaticMember)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!35 = !DILocation(line: 27, column: 8, scope: !22)
!36 = !DILocalVariable(name: "i", scope: !22, file: !5, line: 28, type: !37, align: 256)
!37 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!38 = !DILocation(line: 28, column: 21, scope: !22)
!39 = !DILocalVariable(name: "Lambda", scope: !22, file: !5, line: 29, type: !40)
!40 = distinct !DICompositeType(tag: DW_TAG_class_type, scope: !22, file: !5, line: 29, size: 32, elements: !41)
!41 = !{!42, !43}
!42 = !DIDerivedType(tag: DW_TAG_member, name: "i", scope: !40, file: !5, line: 29, baseType: !37, size: 32, align: 256)
!43 = !DISubprogram(name: "operator()", scope: !40, file: !5, line: 29, type: !44, isLocal: false, isDefinition: false, scopeLine: 29, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!44 = !DISubroutineType(types: !45)
!45 = !{null, !46}
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!47 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !40)
!48 = !DILocation(line: 29, column: 10, scope: !22)
!49 = !DILocation(line: 29, column: 19, scope: !22)
!50 = !DILocation(line: 29, column: 20, scope: !22)
!51 = !DILocation(line: 30, column: 1, scope: !22)
