; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"nope\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@gt = common global i8* null, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i8* @foo(i8* %param) #0 !dbg !12 {
entry:
  %param.addr = alloca i8*, align 8
  %t1 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  store i8* %param, i8** %param.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %param.addr, metadata !15, metadata !16), !dbg !17
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !18, metadata !16), !dbg !19
  %0 = load i8*, i8** %param.addr, align 8, !dbg !20
  store i8* %0, i8** %t1, align 8, !dbg !19
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0), i8** %param.addr, align 8, !dbg !21
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !22, metadata !16), !dbg !23
  %1 = load i8*, i8** %param.addr, align 8, !dbg !24
  store i8* %1, i8** %ut1, align 8, !dbg !23
  %2 = load i8*, i8** %param.addr, align 8, !dbg !25
  ret i8* %2, !dbg !26
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !27 {
entry:
  %retval = alloca i32, align 4
  %t1 = alloca i8*, align 8
  %ret = alloca i8*, align 8
  %ut2 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)), !dbg !31
  store i8* %call, i8** @gt, align 8, !dbg !32
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !33, metadata !16), !dbg !34
  %0 = load i8*, i8** @gt, align 8, !dbg !35
  store i8* %0, i8** %t1, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata i8** %ret, metadata !36, metadata !16), !dbg !37
  %1 = load i8*, i8** @gt, align 8, !dbg !38
  %call1 = call i8* @foo(i8* %1), !dbg !39
  store i8* %call1, i8** %ret, align 8, !dbg !37
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !40, metadata !16), !dbg !41
  %2 = load i8*, i8** %ret, align 8, !dbg !42
  store i8* %2, i8** %ut2, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !43, metadata !16), !dbg !44
  %3 = load i8*, i8** @gt, align 8, !dbg !45
  store i8* %3, i8** %t2, align 8, !dbg !44
  ret i32 0, !dbg !46
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!8, !9, !10}
!llvm.ident = !{!11}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "gt", scope: !2, file: !3, line: 3, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-19")
!4 = !{}
!5 = !{!0}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!8 = !{i32 2, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!12 = distinct !DISubprogram(name: "foo", scope: !3, file: !3, line: 6, type: !13, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!13 = !DISubroutineType(types: !14)
!14 = !{!6, !6}
!15 = !DILocalVariable(name: "param", arg: 1, scope: !12, file: !3, line: 6, type: !6)
!16 = !DIExpression()
!17 = !DILocation(line: 6, column: 11, scope: !12)
!18 = !DILocalVariable(name: "t1", scope: !12, file: !3, line: 7, type: !6)
!19 = !DILocation(line: 7, column: 11, scope: !12)
!20 = !DILocation(line: 7, column: 16, scope: !12)
!21 = !DILocation(line: 9, column: 11, scope: !12)
!22 = !DILocalVariable(name: "ut1", scope: !12, file: !3, line: 11, type: !6)
!23 = !DILocation(line: 11, column: 11, scope: !12)
!24 = !DILocation(line: 11, column: 17, scope: !12)
!25 = !DILocation(line: 13, column: 12, scope: !12)
!26 = !DILocation(line: 13, column: 5, scope: !12)
!27 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 17, type: !28, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !2, variables: !4)
!28 = !DISubroutineType(types: !29)
!29 = !{!30}
!30 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!31 = !DILocation(line: 19, column: 10, scope: !27)
!32 = !DILocation(line: 19, column: 8, scope: !27)
!33 = !DILocalVariable(name: "t1", scope: !27, file: !3, line: 21, type: !6)
!34 = !DILocation(line: 21, column: 11, scope: !27)
!35 = !DILocation(line: 21, column: 16, scope: !27)
!36 = !DILocalVariable(name: "ret", scope: !27, file: !3, line: 23, type: !6)
!37 = !DILocation(line: 23, column: 11, scope: !27)
!38 = !DILocation(line: 23, column: 21, scope: !27)
!39 = !DILocation(line: 23, column: 17, scope: !27)
!40 = !DILocalVariable(name: "ut2", scope: !27, file: !3, line: 24, type: !6)
!41 = !DILocation(line: 24, column: 11, scope: !27)
!42 = !DILocation(line: 24, column: 17, scope: !27)
!43 = !DILocalVariable(name: "t2", scope: !27, file: !3, line: 26, type: !6)
!44 = !DILocation(line: 26, column: 11, scope: !27)
!45 = !DILocation(line: 26, column: 16, scope: !27)
!46 = !DILocation(line: 28, column: 5, scope: !27)
