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
  %b = alloca i32, align 4
  %ut = alloca i32, align 4
  %ut1 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  br label %do.body, !dbg !14, !llvm.loop !15

do.body:                                          ; preds = %do.cond8, %entry
  br label %do.body1, !dbg !17, !llvm.loop !19

do.body1:                                         ; preds = %do.cond4, %do.body
  call void @llvm.dbg.declare(metadata i32* %a, metadata !21, metadata !12), !dbg !23
  br label %do.body2, !dbg !24, !llvm.loop !25

do.body2:                                         ; preds = %do.cond, %do.body1
  store i32 1, i32* %a, align 4, !dbg !27
  br label %while.cond, !dbg !29

while.cond:                                       ; preds = %while.body, %do.body2
  %0 = load i32, i32* %a, align 4, !dbg !30
  %tobool = icmp ne i32 %0, 0, !dbg !29
  br i1 %tobool, label %while.body, label %while.end, !dbg !29

while.body:                                       ; preds = %while.cond
  call void @llvm.dbg.declare(metadata i32* %b, metadata !31, metadata !12), !dbg !33
  store i32 0, i32* %b, align 4, !dbg !33
  br label %while.cond, !dbg !29, !llvm.loop !34

while.end:                                        ; preds = %while.cond
  br label %do.cond, !dbg !36

do.cond:                                          ; preds = %while.end
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !37
  %tobool3 = icmp ne i32 %call, 0, !dbg !36
  br i1 %tobool3, label %do.body2, label %do.end, !dbg !36, !llvm.loop !25

do.end:                                           ; preds = %do.cond
  %1 = load i32, i32* %a, align 4, !dbg !38
  store i32 %1, i32* %rc, align 4, !dbg !39
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !40, metadata !12), !dbg !41
  store i32 0, i32* %ut, align 4, !dbg !41
  br label %do.cond4, !dbg !42

do.cond4:                                         ; preds = %do.end
  %call5 = call i32 (...) @foo(), !dbg !43
  %tobool6 = icmp ne i32 %call5, 0, !dbg !42
  br i1 %tobool6, label %do.body1, label %do.end7, !dbg !42, !llvm.loop !19

do.end7:                                          ; preds = %do.cond4
  br label %do.cond8, !dbg !44

do.cond8:                                         ; preds = %do.end7
  %call9 = call i32 (...) @bar(), !dbg !45
  %tobool10 = icmp ne i32 %call9, 0, !dbg !44
  br i1 %tobool10, label %do.body, label %do.end11, !dbg !44, !llvm.loop !15

do.end11:                                         ; preds = %do.cond8
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !46, metadata !12), !dbg !47
  store i32 0, i32* %ut1, align 4, !dbg !47
  %2 = load i32, i32* %rc, align 4, !dbg !48
  ret i32 %2, !dbg !49
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/061-do-while-loop-6")
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
!16 = !DILocation(line: 21, column: 19, scope: !7)
!17 = !DILocation(line: 10, column: 9, scope: !18)
!18 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 8)
!19 = distinct !{!19, !17, !20}
!20 = !DILocation(line: 20, column: 23, scope: !18)
!21 = !DILocalVariable(name: "a", scope: !22, file: !1, line: 11, type: !10)
!22 = distinct !DILexicalBlock(scope: !18, file: !1, line: 10, column: 12)
!23 = !DILocation(line: 11, column: 17, scope: !22)
!24 = !DILocation(line: 12, column: 13, scope: !22)
!25 = distinct !{!25, !24, !26}
!26 = !DILocation(line: 17, column: 36, scope: !22)
!27 = !DILocation(line: 13, column: 19, scope: !28)
!28 = distinct !DILexicalBlock(scope: !22, file: !1, line: 12, column: 16)
!29 = !DILocation(line: 14, column: 17, scope: !28)
!30 = !DILocation(line: 14, column: 24, scope: !28)
!31 = !DILocalVariable(name: "b", scope: !32, file: !1, line: 15, type: !10)
!32 = distinct !DILexicalBlock(scope: !28, file: !1, line: 14, column: 27)
!33 = !DILocation(line: 15, column: 25, scope: !32)
!34 = distinct !{!34, !29, !35}
!35 = !DILocation(line: 16, column: 17, scope: !28)
!36 = !DILocation(line: 17, column: 13, scope: !28)
!37 = !DILocation(line: 17, column: 22, scope: !22)
!38 = !DILocation(line: 18, column: 18, scope: !22)
!39 = !DILocation(line: 18, column: 16, scope: !22)
!40 = !DILocalVariable(name: "ut", scope: !22, file: !1, line: 19, type: !10)
!41 = !DILocation(line: 19, column: 17, scope: !22)
!42 = !DILocation(line: 20, column: 9, scope: !22)
!43 = !DILocation(line: 20, column: 18, scope: !18)
!44 = !DILocation(line: 21, column: 5, scope: !18)
!45 = !DILocation(line: 21, column: 14, scope: !7)
!46 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 23, type: !10)
!47 = !DILocation(line: 23, column: 9, scope: !7)
!48 = !DILocation(line: 25, column: 12, scope: !7)
!49 = !DILocation(line: 25, column: 5, scope: !7)
