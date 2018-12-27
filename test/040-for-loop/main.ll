; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !11, metadata !13), !dbg !14
  store i32 0, i32* %i, align 4, !dbg !14
  br label %for.cond, !dbg !15

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !16
  %cmp = icmp slt i32 %0, 10, !dbg !18
  br i1 %cmp, label %for.body, label %for.end, !dbg !19

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %a, metadata !20, metadata !13), !dbg !22
  %1 = load i32, i32* %i, align 4, !dbg !23
  store i32 %1, i32* %a, align 4, !dbg !22
  br label %for.inc, !dbg !24

for.inc:                                          ; preds = %for.body
  %2 = load i32, i32* %i, align 4, !dbg !25
  %inc = add nsw i32 %2, 1, !dbg !25
  store i32 %inc, i32* %i, align 4, !dbg !25
  br label %for.cond, !dbg !26, !llvm.loop !27

for.end:                                          ; preds = %for.cond
  ret i32 0, !dbg !29
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/040-for-loop")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "i", scope: !12, file: !1, line: 8, type: !10)
!12 = distinct !DILexicalBlock(scope: !7, file: !1, line: 8, column: 5)
!13 = !DIExpression()
!14 = !DILocation(line: 8, column: 14, scope: !12)
!15 = !DILocation(line: 8, column: 10, scope: !12)
!16 = !DILocation(line: 8, column: 21, scope: !17)
!17 = distinct !DILexicalBlock(scope: !12, file: !1, line: 8, column: 5)
!18 = !DILocation(line: 8, column: 23, scope: !17)
!19 = !DILocation(line: 8, column: 5, scope: !12)
!20 = !DILocalVariable(name: "a", scope: !21, file: !1, line: 9, type: !10)
!21 = distinct !DILexicalBlock(scope: !17, file: !1, line: 8, column: 34)
!22 = !DILocation(line: 9, column: 13, scope: !21)
!23 = !DILocation(line: 9, column: 17, scope: !21)
!24 = !DILocation(line: 10, column: 5, scope: !21)
!25 = !DILocation(line: 8, column: 30, scope: !17)
!26 = !DILocation(line: 8, column: 5, scope: !17)
!27 = distinct !{!27, !19, !28}
!28 = !DILocation(line: 10, column: 5, scope: !12)
!29 = !DILocation(line: 12, column: 5, scope: !7)
