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
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  br label %while.cond, !dbg !14

while.cond:                                       ; preds = %while.end, %entry
  %call = call i32 (...) @foo(), !dbg !15
  %tobool = icmp ne i32 %call, 0, !dbg !14
  br i1 %tobool, label %while.body, label %while.end5, !dbg !14

while.body:                                       ; preds = %while.cond
  store i32 100, i32* %rc, align 4, !dbg !16
  br label %while.cond1, !dbg !18

while.cond1:                                      ; preds = %while.body4, %while.body
  %call2 = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !19
  %tobool3 = icmp ne i32 %call2, 0, !dbg !18
  br i1 %tobool3, label %while.body4, label %while.end, !dbg !18

while.body4:                                      ; preds = %while.cond1
  store i32 42, i32* %rc, align 4, !dbg !20
  br label %while.cond1, !dbg !18, !llvm.loop !22

while.end:                                        ; preds = %while.cond1
  br label %while.cond, !dbg !14, !llvm.loop !24

while.end5:                                       ; preds = %while.cond
  %0 = load i32, i32* %rc, align 4, !dbg !26
  ret i32 %0, !dbg !27
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @foo(...) #2

declare i32 @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/051-while-loop-2")
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
!15 = !DILocation(line: 9, column: 12, scope: !7)
!16 = !DILocation(line: 10, column: 12, scope: !17)
!17 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 19)
!18 = !DILocation(line: 11, column: 9, scope: !17)
!19 = !DILocation(line: 11, column: 16, scope: !17)
!20 = !DILocation(line: 12, column: 16, scope: !21)
!21 = distinct !DILexicalBlock(scope: !17, file: !1, line: 11, column: 32)
!22 = distinct !{!22, !18, !23}
!23 = !DILocation(line: 13, column: 9, scope: !17)
!24 = distinct !{!24, !14, !25}
!25 = !DILocation(line: 14, column: 5, scope: !7)
!26 = !DILocation(line: 16, column: 12, scope: !7)
!27 = !DILocation(line: 16, column: 5, scope: !7)
