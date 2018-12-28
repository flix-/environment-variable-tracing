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
  %b = alloca i32, align 4
  %f = alloca i32, align 4
  %a4 = alloca i32, align 4
  %b6 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !14, metadata !12), !dbg !15
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !16
  store i32 %call, i32* %taint, align 4, !dbg !15
  %0 = load i32, i32* %rc, align 4, !dbg !17
  switch i32 %0, label %sw.default5 [
    i32 0, label %sw.bb
    i32 1, label %sw.bb3
  ], !dbg !18

sw.bb:                                            ; preds = %entry
  %1 = load i32, i32* %taint, align 4, !dbg !19
  switch i32 %1, label %sw.default [
    i32 0, label %sw.bb1
    i32 1, label %sw.bb2
  ], !dbg !21

sw.bb1:                                           ; preds = %sw.bb
  call void @llvm.dbg.declare(metadata i32* %a, metadata !22, metadata !12), !dbg !24
  store i32 1, i32* %a, align 4, !dbg !24
  br label %sw.epilog, !dbg !25

sw.bb2:                                           ; preds = %sw.bb
  call void @llvm.dbg.declare(metadata i32* %b, metadata !26, metadata !12), !dbg !27
  store i32 2, i32* %b, align 4, !dbg !27
  br label %sw.epilog, !dbg !28

sw.default:                                       ; preds = %sw.bb
  store i32 3, i32* %rc, align 4, !dbg !29
  br label %sw.epilog, !dbg !30

sw.epilog:                                        ; preds = %sw.default, %sw.bb2, %sw.bb1
  call void @llvm.dbg.declare(metadata i32* %f, metadata !31, metadata !12), !dbg !32
  store i32 1, i32* %f, align 4, !dbg !32
  br label %sw.epilog7, !dbg !33

sw.bb3:                                           ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %a4, metadata !34, metadata !12), !dbg !35
  store i32 1, i32* %a4, align 4, !dbg !35
  br label %sw.epilog7, !dbg !36

sw.default5:                                      ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %b6, metadata !37, metadata !12), !dbg !38
  store i32 2, i32* %b6, align 4, !dbg !38
  br label %sw.epilog7, !dbg !39

sw.epilog7:                                       ; preds = %sw.default5, %sw.bb3, %sw.epilog
  %2 = load i32, i32* %rc, align 4, !dbg !40
  ret i32 %2, !dbg !41
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/091-switch-3")
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
!19 = !DILocation(line: 12, column: 17, scope: !20)
!20 = distinct !DILexicalBlock(scope: !7, file: !1, line: 10, column: 17)
!21 = !DILocation(line: 12, column: 9, scope: !20)
!22 = !DILocalVariable(name: "a", scope: !23, file: !1, line: 15, type: !10)
!23 = distinct !DILexicalBlock(scope: !20, file: !1, line: 12, column: 24)
!24 = !DILocation(line: 15, column: 17, scope: !23)
!25 = !DILocation(line: 16, column: 13, scope: !23)
!26 = !DILocalVariable(name: "b", scope: !23, file: !1, line: 19, type: !10)
!27 = !DILocation(line: 19, column: 17, scope: !23)
!28 = !DILocation(line: 20, column: 13, scope: !23)
!29 = !DILocation(line: 23, column: 16, scope: !23)
!30 = !DILocation(line: 24, column: 9, scope: !23)
!31 = !DILocalVariable(name: "f", scope: !20, file: !1, line: 25, type: !10)
!32 = !DILocation(line: 25, column: 13, scope: !20)
!33 = !DILocation(line: 26, column: 9, scope: !20)
!34 = !DILocalVariable(name: "a", scope: !20, file: !1, line: 29, type: !10)
!35 = !DILocation(line: 29, column: 13, scope: !20)
!36 = !DILocation(line: 30, column: 9, scope: !20)
!37 = !DILocalVariable(name: "b", scope: !20, file: !1, line: 33, type: !10)
!38 = !DILocation(line: 33, column: 13, scope: !20)
!39 = !DILocation(line: 34, column: 5, scope: !20)
!40 = !DILocation(line: 36, column: 12, scope: !7)
!41 = !DILocation(line: 36, column: 5, scope: !7)
