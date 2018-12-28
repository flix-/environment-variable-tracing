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
  %taint = alloca i32, align 4
  %a = alloca i32, align 4
  %a3 = alloca i32, align 4
  %a5 = alloca i32, align 4
  %a7 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !14, metadata !12), !dbg !15
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !16
  store i32 %call, i32* %taint, align 4, !dbg !15
  %0 = load i32, i32* %taint, align 4, !dbg !17
  switch i32 %0, label %sw.default [
    i32 0, label %sw.bb
  ], !dbg !18

sw.default:                                       ; preds = %entry
  store i32 1, i32* %rc, align 4, !dbg !19
  br label %sw.bb, !dbg !21

sw.bb:                                            ; preds = %entry, %sw.default
  %1 = load i32, i32* %rc, align 4, !dbg !22
  switch i32 %1, label %sw.default1 [
    i32 0, label %sw.bb2
  ], !dbg !23

sw.default1:                                      ; preds = %sw.bb
  store i32 1, i32* %rc, align 4, !dbg !24
  br label %sw.bb2, !dbg !26

sw.bb2:                                           ; preds = %sw.bb, %sw.default1
  call void @llvm.dbg.declare(metadata i32* %a, metadata !27, metadata !12), !dbg !28
  store i32 1, i32* %a, align 4, !dbg !28
  br label %sw.epilog, !dbg !29

sw.epilog:                                        ; preds = %sw.bb2
  call void @llvm.dbg.declare(metadata i32* %a3, metadata !30, metadata !12), !dbg !31
  store i32 1, i32* %a3, align 4, !dbg !31
  br label %sw.epilog4, !dbg !32

sw.epilog4:                                       ; preds = %sw.epilog
  call void @llvm.dbg.declare(metadata i32* %a5, metadata !33, metadata !12), !dbg !34
  store i32 0, i32* %a5, align 4, !dbg !34
  %2 = load i32, i32* %taint, align 4, !dbg !35
  switch i32 %2, label %sw.epilog8 [
    i32 0, label %sw.bb6
  ], !dbg !36

sw.bb6:                                           ; preds = %sw.epilog4
  call void @llvm.dbg.declare(metadata i32* %a7, metadata !37, metadata !12), !dbg !39
  store i32 0, i32* %a7, align 4, !dbg !39
  br label %sw.epilog8, !dbg !40

sw.epilog8:                                       ; preds = %sw.epilog4, %sw.bb6
  %3 = load i32, i32* %rc, align 4, !dbg !41
  ret i32 %3, !dbg !42
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/091-switch-9")
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
!14 = !DILocalVariable(name: "taint", scope: !7, file: !1, line: 9, type: !10)
!15 = !DILocation(line: 9, column: 9, scope: !7)
!16 = !DILocation(line: 9, column: 17, scope: !7)
!17 = !DILocation(line: 10, column: 13, scope: !7)
!18 = !DILocation(line: 10, column: 5, scope: !7)
!19 = !DILocation(line: 13, column: 12, scope: !20)
!20 = distinct !DILexicalBlock(scope: !7, file: !1, line: 10, column: 20)
!21 = !DILocation(line: 13, column: 9, scope: !20)
!22 = !DILocation(line: 15, column: 17, scope: !20)
!23 = !DILocation(line: 15, column: 9, scope: !20)
!24 = !DILocation(line: 18, column: 16, scope: !25)
!25 = distinct !DILexicalBlock(scope: !20, file: !1, line: 15, column: 21)
!26 = !DILocation(line: 18, column: 13, scope: !25)
!27 = !DILocalVariable(name: "a", scope: !25, file: !1, line: 21, type: !10)
!28 = !DILocation(line: 21, column: 17, scope: !25)
!29 = !DILocation(line: 22, column: 13, scope: !25)
!30 = !DILocalVariable(name: "a", scope: !20, file: !1, line: 24, type: !10)
!31 = !DILocation(line: 24, column: 13, scope: !20)
!32 = !DILocation(line: 25, column: 9, scope: !20)
!33 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 27, type: !10)
!34 = !DILocation(line: 27, column: 9, scope: !7)
!35 = !DILocation(line: 29, column: 13, scope: !7)
!36 = !DILocation(line: 29, column: 5, scope: !7)
!37 = !DILocalVariable(name: "a", scope: !38, file: !1, line: 32, type: !10)
!38 = distinct !DILexicalBlock(scope: !7, file: !1, line: 29, column: 20)
!39 = !DILocation(line: 32, column: 13, scope: !38)
!40 = !DILocation(line: 33, column: 9, scope: !38)
!41 = !DILocation(line: 36, column: 12, scope: !7)
!42 = !DILocation(line: 36, column: 5, scope: !7)
