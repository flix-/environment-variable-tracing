; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.u1 = type { %union.u2 }
%union.u2 = type { i8* }
%union.u3 = type { i8* }

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %u = alloca %union.u1, align 8
  %u2 = alloca %union.u1, align 8
  %tainted = alloca i8*, align 8
  %tainted2 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %union.u1* %u, metadata !11, metadata !28), !dbg !29
  call void @llvm.dbg.declare(metadata %union.u1* %u2, metadata !30, metadata !28), !dbg !31
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !32
  %u1 = bitcast %union.u1* %u to %union.u2*, !dbg !33
  %u3 = bitcast %union.u2* %u1 to %union.u3*, !dbg !34
  %taint = bitcast %union.u3* %u3 to i8**, !dbg !35
  store i8* %call, i8** %taint, align 8, !dbg !36
  %u4 = bitcast %union.u1* %u to %union.u2*, !dbg !37
  %u5 = bitcast %union.u2* %u4 to %union.u3*, !dbg !38
  %taint6 = bitcast %union.u3* %u5 to i8**, !dbg !39
  %0 = load i8*, i8** %taint6, align 8, !dbg !39
  %u7 = bitcast %union.u1* %u2 to %union.u2*, !dbg !40
  %u8 = bitcast %union.u2* %u7 to %union.u3*, !dbg !41
  %taint9 = bitcast %union.u3* %u8 to i8**, !dbg !42
  store i8* %0, i8** %taint9, align 8, !dbg !43
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !44, metadata !28), !dbg !45
  %taint10 = bitcast %union.u1* %u to i8**, !dbg !46
  %1 = load i8*, i8** %taint10, align 8, !dbg !46
  store i8* %1, i8** %tainted, align 8, !dbg !45
  %u11 = bitcast %union.u1* %u to %union.u2*, !dbg !47
  %d = bitcast %union.u2* %u11 to double*, !dbg !48
  store double 1.000000e+00, double* %d, align 8, !dbg !49
  call void @llvm.dbg.declare(metadata i8** %tainted2, metadata !50, metadata !28), !dbg !51
  %u12 = bitcast %union.u1* %u2 to %union.u2*, !dbg !52
  %taint13 = bitcast %union.u2* %u12 to i8**, !dbg !53
  %2 = load i8*, i8** %taint13, align 8, !dbg !53
  store i8* %2, i8** %tainted2, align 8, !dbg !51
  ret i32 0, !dbg !54
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/111-unions-3")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 22, type: !8, isLocal: false, isDefinition: true, scopeLine: 23, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "u", scope: !7, file: !1, line: 24, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u1", file: !1, line: 16, size: 64, elements: !13)
!13 = !{!14, !27}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !12, file: !1, line: 17, baseType: !15, size: 64)
!15 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u2", file: !1, line: 10, size: 64, elements: !16)
!16 = !{!17, !20, !22}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !15, file: !1, line: 11, baseType: !18, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "d", scope: !15, file: !1, line: 12, baseType: !21, size: 64)
!21 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !15, file: !1, line: 13, baseType: !23, size: 64)
!23 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u3", file: !1, line: 5, size: 64, elements: !24)
!24 = !{!25, !26}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !23, file: !1, line: 6, baseType: !18, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "tainted", scope: !23, file: !1, line: 7, baseType: !18, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !12, file: !1, line: 18, baseType: !18, size: 64)
!28 = !DIExpression()
!29 = !DILocation(line: 24, column: 14, scope: !7)
!30 = !DILocalVariable(name: "u2", scope: !7, file: !1, line: 25, type: !12)
!31 = !DILocation(line: 25, column: 14, scope: !7)
!32 = !DILocation(line: 27, column: 19, scope: !7)
!33 = !DILocation(line: 27, column: 7, scope: !7)
!34 = !DILocation(line: 27, column: 9, scope: !7)
!35 = !DILocation(line: 27, column: 11, scope: !7)
!36 = !DILocation(line: 27, column: 17, scope: !7)
!37 = !DILocation(line: 28, column: 22, scope: !7)
!38 = !DILocation(line: 28, column: 24, scope: !7)
!39 = !DILocation(line: 28, column: 26, scope: !7)
!40 = !DILocation(line: 28, column: 8, scope: !7)
!41 = !DILocation(line: 28, column: 10, scope: !7)
!42 = !DILocation(line: 28, column: 12, scope: !7)
!43 = !DILocation(line: 28, column: 18, scope: !7)
!44 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 30, type: !18)
!45 = !DILocation(line: 30, column: 11, scope: !7)
!46 = !DILocation(line: 30, column: 23, scope: !7)
!47 = !DILocation(line: 32, column: 7, scope: !7)
!48 = !DILocation(line: 32, column: 9, scope: !7)
!49 = !DILocation(line: 32, column: 11, scope: !7)
!50 = !DILocalVariable(name: "tainted2", scope: !7, file: !1, line: 34, type: !18)
!51 = !DILocation(line: 34, column: 11, scope: !7)
!52 = !DILocation(line: 34, column: 25, scope: !7)
!53 = !DILocation(line: 34, column: 27, scope: !7)
!54 = !DILocation(line: 36, column: 5, scope: !7)
