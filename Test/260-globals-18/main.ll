; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@gt = common global i8* null, align 8, !dbg !0
@.str = private unnamed_addr constant [8 x i8] c"untaint\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo() #0 !dbg !12 {
entry:
  %t1 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !15, metadata !16), !dbg !17
  %0 = load i8*, i8** @gt, align 8, !dbg !18
  store i8* %0, i8** %t1, align 8, !dbg !17
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i32 0, i32 0), i8** @gt, align 8, !dbg !19
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !20, metadata !16), !dbg !21
  %1 = load i8*, i8** @gt, align 8, !dbg !22
  store i8* %1, i8** %ut1, align 8, !dbg !21
  ret void, !dbg !23
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !24 {
entry:
  %retval = alloca i32, align 4
  %t1 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)), !dbg !28
  store i8* %call, i8** @gt, align 8, !dbg !29
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !30, metadata !16), !dbg !31
  %0 = load i8*, i8** @gt, align 8, !dbg !32
  store i8* %0, i8** %t1, align 8, !dbg !31
  call void @foo(), !dbg !33
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !34, metadata !16), !dbg !35
  %1 = load i8*, i8** @gt, align 8, !dbg !36
  store i8* %1, i8** %ut1, align 8, !dbg !35
  ret i32 0, !dbg !37
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!8, !9, !10}
!llvm.ident = !{!11}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "gt", scope: !2, file: !3, line: 5, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-18")
!4 = !{}
!5 = !{!0}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!8 = !{i32 2, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!12 = distinct !DISubprogram(name: "foo", scope: !3, file: !3, line: 8, type: !13, isLocal: false, isDefinition: true, scopeLine: 8, isOptimized: false, unit: !2, variables: !4)
!13 = !DISubroutineType(types: !14)
!14 = !{null}
!15 = !DILocalVariable(name: "t1", scope: !12, file: !3, line: 9, type: !6)
!16 = !DIExpression()
!17 = !DILocation(line: 9, column: 11, scope: !12)
!18 = !DILocation(line: 9, column: 16, scope: !12)
!19 = !DILocation(line: 11, column: 8, scope: !12)
!20 = !DILocalVariable(name: "ut1", scope: !12, file: !3, line: 13, type: !6)
!21 = !DILocation(line: 13, column: 11, scope: !12)
!22 = !DILocation(line: 13, column: 17, scope: !12)
!23 = !DILocation(line: 14, column: 1, scope: !12)
!24 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 17, type: !25, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !2, variables: !4)
!25 = !DISubroutineType(types: !26)
!26 = !{!27}
!27 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!28 = !DILocation(line: 19, column: 10, scope: !24)
!29 = !DILocation(line: 19, column: 8, scope: !24)
!30 = !DILocalVariable(name: "t1", scope: !24, file: !3, line: 21, type: !6)
!31 = !DILocation(line: 21, column: 11, scope: !24)
!32 = !DILocation(line: 21, column: 16, scope: !24)
!33 = !DILocation(line: 23, column: 5, scope: !24)
!34 = !DILocalVariable(name: "ut1", scope: !24, file: !3, line: 25, type: !6)
!35 = !DILocation(line: 25, column: 11, scope: !24)
!36 = !DILocation(line: 25, column: 17, scope: !24)
!37 = !DILocation(line: 27, column: 5, scope: !24)
