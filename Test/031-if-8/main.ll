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
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !14, metadata !12), !dbg !15
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !16
  store i32 %call, i32* %taint, align 4, !dbg !15
  %0 = load i32, i32* %taint, align 4, !dbg !17
  %tobool = icmp ne i32 %0, 0, !dbg !17
  br i1 %tobool, label %if.then, label %if.else4, !dbg !19

if.then:                                          ; preds = %entry
  %call1 = call i32 (...) @foo(), !dbg !20
  %tobool2 = icmp ne i32 %call1, 0, !dbg !20
  br i1 %tobool2, label %if.then3, label %if.else, !dbg !23

if.then3:                                         ; preds = %if.then
  store i32 1, i32* %rc, align 4, !dbg !24
  br label %if.end, !dbg !26

if.else:                                          ; preds = %if.then
  store i32 1, i32* %rc, align 4, !dbg !27
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end10, !dbg !29

if.else4:                                         ; preds = %entry
  %call5 = call i32 (...) @foo(), !dbg !30
  %tobool6 = icmp ne i32 %call5, 0, !dbg !30
  br i1 %tobool6, label %if.then7, label %if.else8, !dbg !33

if.then7:                                         ; preds = %if.else4
  store i32 1, i32* %rc, align 4, !dbg !34
  br label %if.end9, !dbg !36

if.else8:                                         ; preds = %if.else4
  store i32 1, i32* %rc, align 4, !dbg !37
  br label %if.end9

if.end9:                                          ; preds = %if.else8, %if.then7
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.end
  call void @llvm.dbg.declare(metadata i32* %a, metadata !39, metadata !12), !dbg !40
  store i32 1, i32* %a, align 4, !dbg !40
  %1 = load i32, i32* %rc, align 4, !dbg !41
  ret i32 %1, !dbg !42
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-8")
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
!17 = !DILocation(line: 11, column: 9, scope: !18)
!18 = distinct !DILexicalBlock(scope: !7, file: !1, line: 11, column: 9)
!19 = !DILocation(line: 11, column: 9, scope: !7)
!20 = !DILocation(line: 12, column: 13, scope: !21)
!21 = distinct !DILexicalBlock(scope: !22, file: !1, line: 12, column: 13)
!22 = distinct !DILexicalBlock(scope: !18, file: !1, line: 11, column: 16)
!23 = !DILocation(line: 12, column: 13, scope: !22)
!24 = !DILocation(line: 13, column: 16, scope: !25)
!25 = distinct !DILexicalBlock(scope: !21, file: !1, line: 12, column: 20)
!26 = !DILocation(line: 14, column: 9, scope: !25)
!27 = !DILocation(line: 15, column: 16, scope: !28)
!28 = distinct !DILexicalBlock(scope: !21, file: !1, line: 14, column: 16)
!29 = !DILocation(line: 17, column: 5, scope: !22)
!30 = !DILocation(line: 18, column: 13, scope: !31)
!31 = distinct !DILexicalBlock(scope: !32, file: !1, line: 18, column: 13)
!32 = distinct !DILexicalBlock(scope: !18, file: !1, line: 17, column: 12)
!33 = !DILocation(line: 18, column: 13, scope: !32)
!34 = !DILocation(line: 19, column: 16, scope: !35)
!35 = distinct !DILexicalBlock(scope: !31, file: !1, line: 18, column: 20)
!36 = !DILocation(line: 20, column: 9, scope: !35)
!37 = !DILocation(line: 21, column: 16, scope: !38)
!38 = distinct !DILexicalBlock(scope: !31, file: !1, line: 20, column: 16)
!39 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 24, type: !10)
!40 = !DILocation(line: 24, column: 9, scope: !7)
!41 = !DILocation(line: 26, column: 12, scope: !7)
!42 = !DILocation(line: 26, column: 5, scope: !7)
