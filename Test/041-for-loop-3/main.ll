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
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %i, metadata !14, metadata !12), !dbg !16
  store i32 0, i32* %i, align 4, !dbg !16
  br label %for.cond, !dbg !17

for.cond:                                         ; preds = %for.inc3, %entry
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !18
  %tobool = icmp ne i32 %call, 0, !dbg !20
  br i1 %tobool, label %for.body, label %for.end5, !dbg !20

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !21, metadata !12), !dbg !24
  store i32 0, i32* %j, align 4, !dbg !24
  br label %for.cond1, !dbg !25

for.cond1:                                        ; preds = %for.inc, %for.body
  %0 = load i32, i32* %j, align 4, !dbg !26
  %cmp = icmp slt i32 %0, 10, !dbg !28
  br i1 %cmp, label %for.body2, label %for.end, !dbg !29

for.body2:                                        ; preds = %for.cond1
  %1 = load i32, i32* %j, align 4, !dbg !30
  store i32 %1, i32* %rc, align 4, !dbg !32
  br label %for.inc, !dbg !33

for.inc:                                          ; preds = %for.body2
  %2 = load i32, i32* %j, align 4, !dbg !34
  %inc = add nsw i32 %2, 1, !dbg !34
  store i32 %inc, i32* %j, align 4, !dbg !34
  br label %for.cond1, !dbg !35, !llvm.loop !36

for.end:                                          ; preds = %for.cond1
  br label %for.inc3, !dbg !38

for.inc3:                                         ; preds = %for.end
  %3 = load i32, i32* %i, align 4, !dbg !39
  %inc4 = add nsw i32 %3, 1, !dbg !39
  store i32 %inc4, i32* %i, align 4, !dbg !39
  br label %for.cond, !dbg !40, !llvm.loop !41

for.end5:                                         ; preds = %for.cond
  %4 = load i32, i32* %rc, align 4, !dbg !43
  ret i32 %4, !dbg !44
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/041-for-loop-3")
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
!14 = !DILocalVariable(name: "i", scope: !15, file: !1, line: 9, type: !10)
!15 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 5)
!16 = !DILocation(line: 9, column: 14, scope: !15)
!17 = !DILocation(line: 9, column: 10, scope: !15)
!18 = !DILocation(line: 9, column: 21, scope: !19)
!19 = distinct !DILexicalBlock(scope: !15, file: !1, line: 9, column: 5)
!20 = !DILocation(line: 9, column: 5, scope: !15)
!21 = !DILocalVariable(name: "j", scope: !22, file: !1, line: 10, type: !10)
!22 = distinct !DILexicalBlock(scope: !23, file: !1, line: 10, column: 9)
!23 = distinct !DILexicalBlock(scope: !19, file: !1, line: 9, column: 42)
!24 = !DILocation(line: 10, column: 18, scope: !22)
!25 = !DILocation(line: 10, column: 14, scope: !22)
!26 = !DILocation(line: 10, column: 25, scope: !27)
!27 = distinct !DILexicalBlock(scope: !22, file: !1, line: 10, column: 9)
!28 = !DILocation(line: 10, column: 27, scope: !27)
!29 = !DILocation(line: 10, column: 9, scope: !22)
!30 = !DILocation(line: 11, column: 18, scope: !31)
!31 = distinct !DILexicalBlock(scope: !27, file: !1, line: 10, column: 38)
!32 = !DILocation(line: 11, column: 16, scope: !31)
!33 = !DILocation(line: 12, column: 9, scope: !31)
!34 = !DILocation(line: 10, column: 34, scope: !27)
!35 = !DILocation(line: 10, column: 9, scope: !27)
!36 = distinct !{!36, !29, !37}
!37 = !DILocation(line: 12, column: 9, scope: !22)
!38 = !DILocation(line: 13, column: 5, scope: !23)
!39 = !DILocation(line: 9, column: 38, scope: !19)
!40 = !DILocation(line: 9, column: 5, scope: !19)
!41 = distinct !{!41, !20, !42}
!42 = !DILocation(line: 13, column: 5, scope: !15)
!43 = !DILocation(line: 15, column: 12, scope: !7)
!44 = !DILocation(line: 15, column: 5, scope: !7)
