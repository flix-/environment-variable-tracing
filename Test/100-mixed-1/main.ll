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
  %a5 = alloca i32, align 4
  %u = alloca i32, align 4
  %a8 = alloca i32, align 4
  %a13 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %untainted, metadata !14, metadata !12), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !16, metadata !12), !dbg !17
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !18
  store i32 %call, i32* %taint, align 4, !dbg !17
  %0 = load i32, i32* %rc, align 4, !dbg !19
  %tobool = icmp ne i32 %0, 0, !dbg !19
  br i1 %tobool, label %if.then, label %if.end7, !dbg !21

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %taint, align 4, !dbg !22
  %tobool1 = icmp ne i32 %1, 0, !dbg !22
  br i1 %tobool1, label %if.then2, label %if.end, !dbg !25

if.then2:                                         ; preds = %if.then
  %2 = load i32, i32* %rc, align 4, !dbg !26
  switch i32 %2, label %sw.default [
    i32 0, label %sw.bb
  ], !dbg !28

sw.default:                                       ; preds = %if.then2
  store i32 1, i32* %rc, align 4, !dbg !29
  br label %sw.bb, !dbg !31

sw.bb:                                            ; preds = %if.then2, %sw.default
  %3 = load i32, i32* %rc, align 4, !dbg !32
  switch i32 %3, label %sw.default3 [
    i32 0, label %sw.bb4
  ], !dbg !33

sw.default3:                                      ; preds = %sw.bb
  store i32 1, i32* %rc, align 4, !dbg !34
  br label %sw.bb4, !dbg !36

sw.bb4:                                           ; preds = %sw.bb, %sw.default3
  call void @llvm.dbg.declare(metadata i32* %a, metadata !37, metadata !12), !dbg !38
  store i32 1, i32* %a, align 4, !dbg !38
  br label %sw.epilog, !dbg !39

sw.epilog:                                        ; preds = %sw.bb4
  call void @llvm.dbg.declare(metadata i32* %a5, metadata !40, metadata !12), !dbg !41
  store i32 1, i32* %a5, align 4, !dbg !41
  br label %sw.epilog6, !dbg !42

sw.epilog6:                                       ; preds = %sw.epilog
  br label %if.end, !dbg !43

if.end:                                           ; preds = %sw.epilog6, %if.then
  call void @llvm.dbg.declare(metadata i32* %u, metadata !44, metadata !12), !dbg !45
  store i32 0, i32* %u, align 4, !dbg !45
  br label %if.end7, !dbg !46

if.end7:                                          ; preds = %if.end, %entry
  call void @llvm.dbg.declare(metadata i32* %a8, metadata !47, metadata !12), !dbg !48
  store i32 0, i32* %a8, align 4, !dbg !48
  %4 = load i32, i32* %untainted, align 4, !dbg !49
  %tobool9 = icmp ne i32 %4, 0, !dbg !49
  br i1 %tobool9, label %if.then10, label %if.else, !dbg !51

if.then10:                                        ; preds = %if.end7
  store i32 1, i32* %a8, align 4, !dbg !52
  br label %if.end11, !dbg !54

if.else:                                          ; preds = %if.end7
  store i32 2, i32* %a8, align 4, !dbg !55
  br label %if.end11

if.end11:                                         ; preds = %if.else, %if.then10
  %5 = load i32, i32* %untainted, align 4, !dbg !57
  switch i32 %5, label %sw.epilog14 [
    i32 0, label %sw.bb12
  ], !dbg !58

sw.bb12:                                          ; preds = %if.end11
  call void @llvm.dbg.declare(metadata i32* %a13, metadata !59, metadata !12), !dbg !61
  store i32 0, i32* %a13, align 4, !dbg !61
  br label %sw.epilog14, !dbg !62

sw.epilog14:                                      ; preds = %if.end11, %sw.bb12
  %6 = load i32, i32* %rc, align 4, !dbg !63
  ret i32 %6, !dbg !64
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/100-mixed-1")
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
!19 = !DILocation(line: 12, column: 9, scope: !20)
!20 = distinct !DILexicalBlock(scope: !7, file: !1, line: 12, column: 9)
!21 = !DILocation(line: 12, column: 9, scope: !7)
!22 = !DILocation(line: 13, column: 13, scope: !23)
!23 = distinct !DILexicalBlock(scope: !24, file: !1, line: 13, column: 13)
!24 = distinct !DILexicalBlock(scope: !20, file: !1, line: 12, column: 13)
!25 = !DILocation(line: 13, column: 13, scope: !24)
!26 = !DILocation(line: 14, column: 21, scope: !27)
!27 = distinct !DILexicalBlock(scope: !23, file: !1, line: 13, column: 20)
!28 = !DILocation(line: 14, column: 13, scope: !27)
!29 = !DILocation(line: 17, column: 20, scope: !30)
!30 = distinct !DILexicalBlock(scope: !27, file: !1, line: 14, column: 25)
!31 = !DILocation(line: 17, column: 17, scope: !30)
!32 = !DILocation(line: 19, column: 25, scope: !30)
!33 = !DILocation(line: 19, column: 17, scope: !30)
!34 = !DILocation(line: 22, column: 24, scope: !35)
!35 = distinct !DILexicalBlock(scope: !30, file: !1, line: 19, column: 29)
!36 = !DILocation(line: 22, column: 21, scope: !35)
!37 = !DILocalVariable(name: "a", scope: !35, file: !1, line: 25, type: !10)
!38 = !DILocation(line: 25, column: 25, scope: !35)
!39 = !DILocation(line: 26, column: 21, scope: !35)
!40 = !DILocalVariable(name: "a", scope: !30, file: !1, line: 28, type: !10)
!41 = !DILocation(line: 28, column: 21, scope: !30)
!42 = !DILocation(line: 29, column: 17, scope: !30)
!43 = !DILocation(line: 31, column: 9, scope: !27)
!44 = !DILocalVariable(name: "u", scope: !24, file: !1, line: 32, type: !10)
!45 = !DILocation(line: 32, column: 13, scope: !24)
!46 = !DILocation(line: 33, column: 5, scope: !24)
!47 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 34, type: !10)
!48 = !DILocation(line: 34, column: 9, scope: !7)
!49 = !DILocation(line: 36, column: 9, scope: !50)
!50 = distinct !DILexicalBlock(scope: !7, file: !1, line: 36, column: 9)
!51 = !DILocation(line: 36, column: 9, scope: !7)
!52 = !DILocation(line: 37, column: 11, scope: !53)
!53 = distinct !DILexicalBlock(scope: !50, file: !1, line: 36, column: 20)
!54 = !DILocation(line: 38, column: 5, scope: !53)
!55 = !DILocation(line: 39, column: 11, scope: !56)
!56 = distinct !DILexicalBlock(scope: !50, file: !1, line: 38, column: 12)
!57 = !DILocation(line: 42, column: 13, scope: !7)
!58 = !DILocation(line: 42, column: 5, scope: !7)
!59 = !DILocalVariable(name: "a", scope: !60, file: !1, line: 45, type: !10)
!60 = distinct !DILexicalBlock(scope: !7, file: !1, line: 42, column: 24)
!61 = !DILocation(line: 45, column: 13, scope: !60)
!62 = !DILocation(line: 46, column: 9, scope: !60)
!63 = !DILocation(line: 49, column: 12, scope: !7)
!64 = !DILocation(line: 49, column: 5, scope: !7)
