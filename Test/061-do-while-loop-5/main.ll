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
  %a = alloca i32, align 4
  %ut = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  br label %do.body, !dbg !14, !llvm.loop !15

do.body:                                          ; preds = %do.cond7, %entry
  br label %do.body1, !dbg !17, !llvm.loop !19

do.body1:                                         ; preds = %do.cond3, %do.body
  call void @llvm.dbg.declare(metadata i32* %a, metadata !21, metadata !12), !dbg !23
  br label %do.body2, !dbg !24, !llvm.loop !25

do.body2:                                         ; preds = %do.cond, %do.body1
  store i32 1, i32* %a, align 4, !dbg !27
  br label %do.cond, !dbg !29

do.cond:                                          ; preds = %do.body2
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !30
  %tobool = icmp ne i32 %call, 0, !dbg !29
  br i1 %tobool, label %do.body2, label %do.end, !dbg !29, !llvm.loop !25

do.end:                                           ; preds = %do.cond
  %0 = load i32, i32* %a, align 4, !dbg !31
  store i32 %0, i32* %rc, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !33, metadata !12), !dbg !34
  store i32 0, i32* %ut, align 4, !dbg !34
  br label %do.cond3, !dbg !35

do.cond3:                                         ; preds = %do.end
  %call4 = call i32 (...) @foo(), !dbg !36
  %tobool5 = icmp ne i32 %call4, 0, !dbg !35
  br i1 %tobool5, label %do.body1, label %do.end6, !dbg !35, !llvm.loop !19

do.end6:                                          ; preds = %do.cond3
  br label %do.cond7, !dbg !37

do.cond7:                                         ; preds = %do.end6
  %call8 = call i32 (...) @bar(), !dbg !38
  %tobool9 = icmp ne i32 %call8, 0, !dbg !37
  br i1 %tobool9, label %do.body, label %do.end10, !dbg !37, !llvm.loop !15

do.end10:                                         ; preds = %do.cond7
  %1 = load i32, i32* %rc, align 4, !dbg !39
  ret i32 %1, !dbg !40
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @getenv(i8*) #2

declare i32 @foo(...) #2

declare i32 @bar(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/061-do-while-loop-5")
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
!14 = !DILocation(line: 9, column: 5, scope: !7)
!15 = distinct !{!15, !14, !16}
!16 = !DILocation(line: 18, column: 19, scope: !7)
!17 = !DILocation(line: 10, column: 9, scope: !18)
!18 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 8)
!19 = distinct !{!19, !17, !20}
!20 = !DILocation(line: 17, column: 23, scope: !18)
!21 = !DILocalVariable(name: "a", scope: !22, file: !1, line: 11, type: !10)
!22 = distinct !DILexicalBlock(scope: !18, file: !1, line: 10, column: 12)
!23 = !DILocation(line: 11, column: 17, scope: !22)
!24 = !DILocation(line: 12, column: 13, scope: !22)
!25 = distinct !{!25, !24, !26}
!26 = !DILocation(line: 14, column: 36, scope: !22)
!27 = !DILocation(line: 13, column: 19, scope: !28)
!28 = distinct !DILexicalBlock(scope: !22, file: !1, line: 12, column: 16)
!29 = !DILocation(line: 14, column: 13, scope: !28)
!30 = !DILocation(line: 14, column: 22, scope: !22)
!31 = !DILocation(line: 15, column: 18, scope: !22)
!32 = !DILocation(line: 15, column: 16, scope: !22)
!33 = !DILocalVariable(name: "ut", scope: !22, file: !1, line: 16, type: !10)
!34 = !DILocation(line: 16, column: 17, scope: !22)
!35 = !DILocation(line: 17, column: 9, scope: !22)
!36 = !DILocation(line: 17, column: 18, scope: !18)
!37 = !DILocation(line: 18, column: 5, scope: !18)
!38 = !DILocation(line: 18, column: 14, scope: !7)
!39 = !DILocation(line: 20, column: 12, scope: !7)
!40 = !DILocation(line: 20, column: 5, scope: !7)
