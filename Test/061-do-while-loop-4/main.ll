; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %rc = alloca i32, align 4
  %end = alloca i32, align 4
  %ut = alloca i32, align 4
  %ut7 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !14, metadata !12), !dbg !15
  br label %do.body, !dbg !16, !llvm.loop !17

do.body:                                          ; preds = %do.cond2, %entry
  store i32 42, i32* %rc, align 4, !dbg !19
  br label %do.body1, !dbg !21, !llvm.loop !22

do.body1:                                         ; preds = %do.cond, %do.body
  store i32 1, i32* %rc, align 4, !dbg !24
  br label %do.cond, !dbg !26

do.cond:                                          ; preds = %do.body1
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !27
  %tobool = icmp ne i32 %call, 0, !dbg !26
  br i1 %tobool, label %do.body1, label %do.end, !dbg !26, !llvm.loop !22

do.end:                                           ; preds = %do.cond
  call void @llvm.dbg.declare(metadata i32* %end, metadata !28, metadata !12), !dbg !29
  store i32 1, i32* %end, align 4, !dbg !29
  br label %do.cond2, !dbg !30

do.cond2:                                         ; preds = %do.end
  %call3 = call i32 (...) @foo(), !dbg !31
  %tobool4 = icmp ne i32 %call3, 0, !dbg !30
  br i1 %tobool4, label %do.body, label %do.end5, !dbg !30, !llvm.loop !17

do.end5:                                          ; preds = %do.cond2
  %0 = load i32, i32* %a, align 4, !dbg !32
  %tobool6 = icmp ne i32 %0, 0, !dbg !32
  br i1 %tobool6, label %if.then, label %if.else, !dbg !34

if.then:                                          ; preds = %do.end5
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !35, metadata !12), !dbg !37
  store i32 1, i32* %ut, align 4, !dbg !37
  br label %if.end, !dbg !38

if.else:                                          ; preds = %do.end5
  call void @llvm.dbg.declare(metadata i32* %ut7, metadata !39, metadata !12), !dbg !41
  store i32 2, i32* %ut7, align 4, !dbg !41
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %1 = load i32, i32* %rc, align 4, !dbg !42
  ret i32 %1, !dbg !43
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @getenv(i8*) #2

declare i32 @foo(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/061-do-while-loop-4")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 8, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 8, column: 9, scope: !7)
!14 = !DILocalVariable(name: "rc", scope: !7, file: !1, line: 9, type: !10)
!15 = !DILocation(line: 9, column: 9, scope: !7)
!16 = !DILocation(line: 10, column: 5, scope: !7)
!17 = distinct !{!17, !16, !18}
!18 = !DILocation(line: 16, column: 19, scope: !7)
!19 = !DILocation(line: 11, column: 12, scope: !20)
!20 = distinct !DILexicalBlock(scope: !7, file: !1, line: 10, column: 8)
!21 = !DILocation(line: 12, column: 9, scope: !20)
!22 = distinct !{!22, !21, !23}
!23 = !DILocation(line: 14, column: 32, scope: !20)
!24 = !DILocation(line: 13, column: 16, scope: !25)
!25 = distinct !DILexicalBlock(scope: !20, file: !1, line: 12, column: 12)
!26 = !DILocation(line: 14, column: 9, scope: !25)
!27 = !DILocation(line: 14, column: 18, scope: !20)
!28 = !DILocalVariable(name: "end", scope: !20, file: !1, line: 15, type: !10)
!29 = !DILocation(line: 15, column: 13, scope: !20)
!30 = !DILocation(line: 16, column: 5, scope: !20)
!31 = !DILocation(line: 16, column: 14, scope: !7)
!32 = !DILocation(line: 18, column: 9, scope: !33)
!33 = distinct !DILexicalBlock(scope: !7, file: !1, line: 18, column: 9)
!34 = !DILocation(line: 18, column: 9, scope: !7)
!35 = !DILocalVariable(name: "ut", scope: !36, file: !1, line: 19, type: !10)
!36 = distinct !DILexicalBlock(scope: !33, file: !1, line: 18, column: 12)
!37 = !DILocation(line: 19, column: 13, scope: !36)
!38 = !DILocation(line: 20, column: 5, scope: !36)
!39 = !DILocalVariable(name: "ut", scope: !40, file: !1, line: 21, type: !10)
!40 = distinct !DILexicalBlock(scope: !33, file: !1, line: 20, column: 12)
!41 = !DILocation(line: 21, column: 13, scope: !40)
!42 = !DILocation(line: 24, column: 12, scope: !7)
!43 = !DILocation(line: 24, column: 5, scope: !7)
