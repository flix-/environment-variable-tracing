; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.a = type { i8* }

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i8* %tainted) #0 !dbg !7 {
entry:
  %tainted.addr = alloca i8*, align 8
  %tainted2 = alloca i8*, align 8
  store i8* %tainted, i8** %tainted.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %tainted.addr, metadata !12, metadata !13), !dbg !14
  call void @llvm.dbg.declare(metadata i8** %tainted2, metadata !15, metadata !13), !dbg !16
  %0 = load i8*, i8** %tainted.addr, align 8, !dbg !17
  store i8* %0, i8** %tainted2, align 8, !dbg !16
  ret void, !dbg !18
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !19 {
entry:
  %retval = alloca i32, align 4
  %f = alloca %union.a, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %union.a* %f, metadata !23, metadata !13), !dbg !28
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !29
  %tainted = bitcast %union.a* %f to i8**, !dbg !30
  store i8* %call, i8** %tainted, align 8, !dbg !31
  %foo = bitcast %union.a* %f to i8**, !dbg !32
  %0 = load i8*, i8** %foo, align 8, !dbg !32
  call void @foo(i8* %0), !dbg !33
  ret i32 0, !dbg !34
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-union-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !DILocalVariable(name: "tainted", arg: 1, scope: !7, file: !1, line: 9, type: !10)
!13 = !DIExpression()
!14 = !DILocation(line: 9, column: 11, scope: !7)
!15 = !DILocalVariable(name: "tainted2", scope: !7, file: !1, line: 11, type: !10)
!16 = !DILocation(line: 11, column: 11, scope: !7)
!17 = !DILocation(line: 11, column: 22, scope: !7)
!18 = !DILocation(line: 12, column: 1, scope: !7)
!19 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 15, type: !20, isLocal: false, isDefinition: true, scopeLine: 16, isOptimized: false, unit: !0, variables: !2)
!20 = !DISubroutineType(types: !21)
!21 = !{!22}
!22 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!23 = !DILocalVariable(name: "f", scope: !19, file: !1, line: 17, type: !24)
!24 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "a", file: !1, line: 3, size: 64, elements: !25)
!25 = !{!26, !27}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "tainted", scope: !24, file: !1, line: 4, baseType: !10, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "foo", scope: !24, file: !1, line: 5, baseType: !10, size: 64)
!28 = !DILocation(line: 17, column: 13, scope: !19)
!29 = !DILocation(line: 18, column: 17, scope: !19)
!30 = !DILocation(line: 18, column: 7, scope: !19)
!31 = !DILocation(line: 18, column: 15, scope: !19)
!32 = !DILocation(line: 20, column: 11, scope: !19)
!33 = !DILocation(line: 20, column: 5, scope: !19)
!34 = !DILocation(line: 22, column: 5, scope: !19)
