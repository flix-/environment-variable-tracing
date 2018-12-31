; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.u1 = type { i8* }

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"untaint\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %u = alloca %union.u1, align 8
  %uu = alloca %union.u1, align 8
  %tainted = alloca i8*, align 8
  %not_tainted = alloca i8*, align 8
  %still_tainted = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %union.u1* %u, metadata !11, metadata !17), !dbg !18
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !19
  %t = bitcast %union.u1* %u to i8**, !dbg !20
  store i8* %call, i8** %t, align 8, !dbg !21
  call void @llvm.dbg.declare(metadata %union.u1* %uu, metadata !22, metadata !17), !dbg !23
  %0 = bitcast %union.u1* %uu to i8*, !dbg !24
  %1 = bitcast %union.u1* %u to i8*, !dbg !24
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 8, i32 8, i1 false), !dbg !24
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !25, metadata !17), !dbg !26
  %t1 = bitcast %union.u1* %uu to i8**, !dbg !27
  %2 = load i8*, i8** %t1, align 8, !dbg !27
  store i8* %2, i8** %tainted, align 8, !dbg !26
  %t2 = bitcast %union.u1* %uu to i8**, !dbg !28
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i32 0, i32 0), i8** %t2, align 8, !dbg !29
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !30, metadata !17), !dbg !31
  %t3 = bitcast %union.u1* %uu to i8**, !dbg !32
  %3 = load i8*, i8** %t3, align 8, !dbg !32
  store i8* %3, i8** %not_tainted, align 8, !dbg !31
  call void @llvm.dbg.declare(metadata i8** %still_tainted, metadata !33, metadata !17), !dbg !34
  %t4 = bitcast %union.u1* %u to i8**, !dbg !35
  %4 = load i8*, i8** %t4, align 8, !dbg !35
  store i8* %4, i8** %still_tainted, align 8, !dbg !34
  ret i32 0, !dbg !36
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/111-unions-8")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "u", scope: !7, file: !1, line: 12, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u1", file: !1, line: 5, size: 64, elements: !13)
!13 = !{!14}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !12, file: !1, line: 6, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIExpression()
!18 = !DILocation(line: 12, column: 14, scope: !7)
!19 = !DILocation(line: 13, column: 11, scope: !7)
!20 = !DILocation(line: 13, column: 7, scope: !7)
!21 = !DILocation(line: 13, column: 9, scope: !7)
!22 = !DILocalVariable(name: "uu", scope: !7, file: !1, line: 15, type: !12)
!23 = !DILocation(line: 15, column: 14, scope: !7)
!24 = !DILocation(line: 15, column: 19, scope: !7)
!25 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 17, type: !15)
!26 = !DILocation(line: 17, column: 11, scope: !7)
!27 = !DILocation(line: 17, column: 24, scope: !7)
!28 = !DILocation(line: 19, column: 8, scope: !7)
!29 = !DILocation(line: 19, column: 10, scope: !7)
!30 = !DILocalVariable(name: "not_tainted", scope: !7, file: !1, line: 21, type: !15)
!31 = !DILocation(line: 21, column: 11, scope: !7)
!32 = !DILocation(line: 21, column: 28, scope: !7)
!33 = !DILocalVariable(name: "still_tainted", scope: !7, file: !1, line: 23, type: !15)
!34 = !DILocation(line: 23, column: 11, scope: !7)
!35 = !DILocation(line: 23, column: 29, scope: !7)
!36 = !DILocation(line: 25, column: 5, scope: !7)
