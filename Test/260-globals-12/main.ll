; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@str = common global [1024 x i8*] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i8** %s) #0 !dbg !15 {
entry:
  %s.addr = alloca i8**, align 8
  %t1 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  store i8** %s, i8*** %s.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %s.addr, metadata !20, metadata !21), !dbg !22
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !23, metadata !21), !dbg !24
  %0 = load i8**, i8*** %s.addr, align 8, !dbg !25
  %arrayidx = getelementptr inbounds i8*, i8** %0, i64 2, !dbg !25
  %1 = load i8*, i8** %arrayidx, align 8, !dbg !25
  store i8* %1, i8** %t1, align 8, !dbg !24
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !26, metadata !21), !dbg !27
  %2 = load i8**, i8*** %s.addr, align 8, !dbg !28
  %arrayidx1 = getelementptr inbounds i8*, i8** %2, i64 1, !dbg !28
  %3 = load i8*, i8** %arrayidx1, align 8, !dbg !28
  store i8* %3, i8** %ut1, align 8, !dbg !27
  ret i32 0, !dbg !29
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !30 {
entry:
  %retval = alloca i32, align 4
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !33
  store i8* %call, i8** getelementptr inbounds ([1024 x i8*], [1024 x i8*]* @str, i64 0, i64 2), align 16, !dbg !34
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !35, metadata !21), !dbg !36
  %call1 = call i32 @foo(i8** getelementptr inbounds ([1024 x i8*], [1024 x i8*]* @str, i32 0, i32 0)), !dbg !37
  store i32 %call1, i32* %rc, align 4, !dbg !36
  %0 = load i32, i32* %rc, align 4, !dbg !38
  ret i32 %0, !dbg !39
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!11, !12, !13}
!llvm.ident = !{!14}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "str", scope: !2, file: !3, line: 5, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-12")
!4 = !{}
!5 = !{!0}
!6 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 65536, elements: !9)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!9 = !{!10}
!10 = !DISubrange(count: 1024)
!11 = !{i32 2, !"Dwarf Version", i32 4}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{i32 1, !"wchar_size", i32 4}
!14 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!15 = distinct !DISubprogram(name: "foo", scope: !3, file: !3, line: 8, type: !16, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!16 = !DISubroutineType(types: !17)
!17 = !{!18, !19}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!20 = !DILocalVariable(name: "s", arg: 1, scope: !15, file: !3, line: 8, type: !19)
!21 = !DIExpression()
!22 = !DILocation(line: 8, column: 11, scope: !15)
!23 = !DILocalVariable(name: "t1", scope: !15, file: !3, line: 9, type: !7)
!24 = !DILocation(line: 9, column: 11, scope: !15)
!25 = !DILocation(line: 9, column: 16, scope: !15)
!26 = !DILocalVariable(name: "ut1", scope: !15, file: !3, line: 11, type: !7)
!27 = !DILocation(line: 11, column: 11, scope: !15)
!28 = !DILocation(line: 11, column: 17, scope: !15)
!29 = !DILocation(line: 13, column: 5, scope: !15)
!30 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 17, type: !31, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !2, variables: !4)
!31 = !DISubroutineType(types: !32)
!32 = !{!18}
!33 = !DILocation(line: 19, column: 14, scope: !30)
!34 = !DILocation(line: 19, column: 12, scope: !30)
!35 = !DILocalVariable(name: "rc", scope: !30, file: !3, line: 21, type: !18)
!36 = !DILocation(line: 21, column: 9, scope: !30)
!37 = !DILocation(line: 21, column: 14, scope: !30)
!38 = !DILocation(line: 23, column: 12, scope: !30)
!39 = !DILocation(line: 23, column: 5, scope: !30)
