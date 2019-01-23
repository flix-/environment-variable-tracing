; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i8* @foo(i8* %t1) #0 !dbg !7 {
entry:
  %t1.addr = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  store i8* %t1, i8** %t1.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %t1.addr, metadata !12, metadata !13), !dbg !14
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !15, metadata !13), !dbg !16
  %0 = load i8*, i8** %t1.addr, align 8, !dbg !17
  store i8* %0, i8** %t2, align 8, !dbg !16
  %1 = load i8*, i8** %t2, align 8, !dbg !18
  ret i8* %1, !dbg !19
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !20 {
entry:
  %retval = alloca i32, align 4
  %t1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %t3 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !24, metadata !13), !dbg !25
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !26
  store i8* %call, i8** %t1, align 8, !dbg !25
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !27, metadata !13), !dbg !28
  %0 = load i8*, i8** %t1, align 8, !dbg !29
  %call1 = call i8* @foo(i8* %0), !dbg !30
  store i8* %call1, i8** %t2, align 8, !dbg !28
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !31, metadata !13), !dbg !32
  %1 = load i8*, i8** %t2, align 8, !dbg !33
  store i8* %1, i8** %t3, align 8, !dbg !32
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/210-map-to-caller-variable-1")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 4, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !DILocalVariable(name: "t1", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!13 = !DIExpression()
!14 = !DILocation(line: 4, column: 11, scope: !7)
!15 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 6, type: !10)
!16 = !DILocation(line: 6, column: 11, scope: !7)
!17 = !DILocation(line: 6, column: 16, scope: !7)
!18 = !DILocation(line: 8, column: 12, scope: !7)
!19 = !DILocation(line: 8, column: 5, scope: !7)
!20 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !21, isLocal: false, isDefinition: true, scopeLine: 13, isOptimized: false, unit: !0, variables: !2)
!21 = !DISubroutineType(types: !22)
!22 = !{!23}
!23 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!24 = !DILocalVariable(name: "t1", scope: !20, file: !1, line: 14, type: !10)
!25 = !DILocation(line: 14, column: 11, scope: !20)
!26 = !DILocation(line: 14, column: 16, scope: !20)
!27 = !DILocalVariable(name: "t2", scope: !20, file: !1, line: 16, type: !10)
!28 = !DILocation(line: 16, column: 11, scope: !20)
!29 = !DILocation(line: 16, column: 20, scope: !20)
!30 = !DILocation(line: 16, column: 16, scope: !20)
!31 = !DILocalVariable(name: "t3", scope: !20, file: !1, line: 18, type: !10)
!32 = !DILocation(line: 18, column: 11, scope: !20)
!33 = !DILocation(line: 18, column: 16, scope: !20)
!34 = !DILocation(line: 20, column: 5, scope: !20)
