; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %rc = alloca i32, align 4
  %untainted = alloca i32, align 4
  %taint = alloca i32, align 4
  %a = alloca i32, align 4
  %a3 = alloca i32, align 4
  %a5 = alloca i32, align 4
  %a7 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %untainted, metadata !14, metadata !12), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !16, metadata !12), !dbg !17
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !18
  store i32 %call, i32* %taint, align 4, !dbg !17
  %0 = load i32, i32* %taint, align 4, !dbg !19
  switch i32 %0, label %sw.default [
    i32 0, label %sw.bb
  ], !dbg !20

sw.default:                                       ; preds = %entry
  store i32 1, i32* %rc, align 4, !dbg !21
  br label %sw.bb, !dbg !23

sw.bb:                                            ; preds = %entry, %sw.default
  %1 = load i32, i32* %rc, align 4, !dbg !24
  switch i32 %1, label %sw.default1 [
    i32 0, label %sw.bb2
  ], !dbg !25

sw.default1:                                      ; preds = %sw.bb
  store i32 1, i32* %rc, align 4, !dbg !26
  br label %sw.bb2, !dbg !28

sw.bb2:                                           ; preds = %sw.bb, %sw.default1
  call void @llvm.dbg.declare(metadata i32* %a, metadata !29, metadata !12), !dbg !30
  store i32 1, i32* %a, align 4, !dbg !30
  br label %sw.epilog, !dbg !31

sw.epilog:                                        ; preds = %sw.bb2
  call void @llvm.dbg.declare(metadata i32* %a3, metadata !32, metadata !12), !dbg !33
  store i32 1, i32* %a3, align 4, !dbg !33
  br label %sw.epilog4, !dbg !34

sw.epilog4:                                       ; preds = %sw.epilog
  call void @llvm.dbg.declare(metadata i32* %a5, metadata !35, metadata !12), !dbg !36
  store i32 0, i32* %a5, align 4, !dbg !36
  %2 = load i32, i32* %untainted, align 4, !dbg !37
  switch i32 %2, label %sw.epilog8 [
    i32 0, label %sw.bb6
  ], !dbg !38

sw.bb6:                                           ; preds = %sw.epilog4
  call void @llvm.dbg.declare(metadata i32* %a7, metadata !39, metadata !12), !dbg !41
  store i32 0, i32* %a7, align 4, !dbg !41
  br label %sw.epilog8, !dbg !42

sw.epilog8:                                       ; preds = %sw.epilog4, %sw.bb6
  %3 = load i32, i32* %rc, align 4, !dbg !43
  ret i32 %3, !dbg !44
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/091-switch-8")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "rc", scope: !7, file: !1, line: 8, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 8, column: 9, scope: !7)
!14 = !DILocalVariable(name: "untainted", scope: !7, file: !1, line: 9, type: !10)
!15 = !DILocation(line: 9, column: 9, scope: !7)
!16 = !DILocalVariable(name: "taint", scope: !7, file: !1, line: 10, type: !10)
!17 = !DILocation(line: 10, column: 9, scope: !7)
!18 = !DILocation(line: 10, column: 17, scope: !7)
!19 = !DILocation(line: 11, column: 13, scope: !7)
!20 = !DILocation(line: 11, column: 5, scope: !7)
!21 = !DILocation(line: 14, column: 12, scope: !22)
!22 = distinct !DILexicalBlock(scope: !7, file: !1, line: 11, column: 20)
!23 = !DILocation(line: 14, column: 9, scope: !22)
!24 = !DILocation(line: 16, column: 17, scope: !22)
!25 = !DILocation(line: 16, column: 9, scope: !22)
!26 = !DILocation(line: 19, column: 16, scope: !27)
!27 = distinct !DILexicalBlock(scope: !22, file: !1, line: 16, column: 21)
!28 = !DILocation(line: 19, column: 13, scope: !27)
!29 = !DILocalVariable(name: "a", scope: !27, file: !1, line: 22, type: !10)
!30 = !DILocation(line: 22, column: 17, scope: !27)
!31 = !DILocation(line: 23, column: 13, scope: !27)
!32 = !DILocalVariable(name: "a", scope: !22, file: !1, line: 25, type: !10)
!33 = !DILocation(line: 25, column: 13, scope: !22)
!34 = !DILocation(line: 26, column: 9, scope: !22)
!35 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 28, type: !10)
!36 = !DILocation(line: 28, column: 9, scope: !7)
!37 = !DILocation(line: 30, column: 13, scope: !7)
!38 = !DILocation(line: 30, column: 5, scope: !7)
!39 = !DILocalVariable(name: "a", scope: !40, file: !1, line: 33, type: !10)
!40 = distinct !DILexicalBlock(scope: !7, file: !1, line: 30, column: 24)
!41 = !DILocation(line: 33, column: 13, scope: !40)
!42 = !DILocation(line: 34, column: 9, scope: !40)
!43 = !DILocation(line: 37, column: 12, scope: !7)
!44 = !DILocation(line: 37, column: 5, scope: !7)
