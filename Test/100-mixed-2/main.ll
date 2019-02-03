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
  %a12 = alloca i32, align 4
  %a14 = alloca i32, align 4
  %a19 = alloca i32, align 4
  %a23 = alloca i32, align 4
  %a25 = alloca i32, align 4
  %a28 = alloca i32, align 4
  %a29 = alloca i32, align 4
  %eot = alloca i32, align 4
  %a33 = alloca i32, align 4
  %a39 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %untainted, metadata !14, metadata !12), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !16, metadata !12), !dbg !17
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !18
  store i32 %call, i32* %taint, align 4, !dbg !17
  %0 = load i32, i32* %rc, align 4, !dbg !19
  %tobool = icmp ne i32 %0, 0, !dbg !19
  br i1 %tobool, label %if.then, label %if.end32, !dbg !21

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %taint, align 4, !dbg !22
  %tobool1 = icmp ne i32 %1, 0, !dbg !22
  br i1 %tobool1, label %if.then2, label %if.end31, !dbg !25

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
    i32 0, label %sw.bb16
  ], !dbg !33

sw.default3:                                      ; preds = %sw.bb
  %call4 = call i32 (...) @bar(), !dbg !34
  %tobool5 = icmp ne i32 %call4, 0, !dbg !34
  br i1 %tobool5, label %if.then6, label %if.else, !dbg !37

if.then6:                                         ; preds = %sw.default3
  call void @llvm.dbg.declare(metadata i32* %a, metadata !38, metadata !12), !dbg !40
  store i32 2, i32* %a, align 4, !dbg !40
  br label %if.end15, !dbg !41

if.else:                                          ; preds = %sw.default3
  %call7 = call i32 (...) @foo(), !dbg !42
  %tobool8 = icmp ne i32 %call7, 0, !dbg !42
  br i1 %tobool8, label %if.then11, label %lor.lhs.false, !dbg !44

lor.lhs.false:                                    ; preds = %if.else
  %call9 = call i32 (...) @bar(), !dbg !45
  %tobool10 = icmp ne i32 %call9, 0, !dbg !45
  br i1 %tobool10, label %if.then11, label %if.else13, !dbg !46

if.then11:                                        ; preds = %lor.lhs.false, %if.else
  call void @llvm.dbg.declare(metadata i32* %a12, metadata !47, metadata !12), !dbg !49
  store i32 1, i32* %a12, align 4, !dbg !49
  br label %if.end, !dbg !50

if.else13:                                        ; preds = %lor.lhs.false
  call void @llvm.dbg.declare(metadata i32* %a14, metadata !51, metadata !12), !dbg !53
  store i32 3, i32* %a14, align 4, !dbg !53
  br label %if.end

if.end:                                           ; preds = %if.else13, %if.then11
  br label %if.end15

if.end15:                                         ; preds = %if.end, %if.then6
  store i32 1, i32* %rc, align 4, !dbg !54
  br label %sw.bb16, !dbg !55

sw.bb16:                                          ; preds = %sw.bb, %if.end15
  %4 = load i32, i32* %taint, align 4, !dbg !56
  %tobool17 = icmp ne i32 %4, 0, !dbg !56
  br i1 %tobool17, label %if.then18, label %if.else20, !dbg !58

if.then18:                                        ; preds = %sw.bb16
  call void @llvm.dbg.declare(metadata i32* %a19, metadata !59, metadata !12), !dbg !61
  store i32 2, i32* %a19, align 4, !dbg !61
  br label %if.end27, !dbg !62

if.else20:                                        ; preds = %sw.bb16
  %call21 = call i32 (...) @foo(), !dbg !63
  %cmp = icmp eq i32 %call21, 0, !dbg !65
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !66

cond.true:                                        ; preds = %if.else20
  br i1 false, label %if.then22, label %if.else24, !dbg !63

cond.false:                                       ; preds = %if.else20
  br i1 true, label %if.then22, label %if.else24, !dbg !66

if.then22:                                        ; preds = %cond.false, %cond.true
  call void @llvm.dbg.declare(metadata i32* %a23, metadata !67, metadata !12), !dbg !69
  store i32 1, i32* %a23, align 4, !dbg !69
  br label %if.end26, !dbg !70

if.else24:                                        ; preds = %cond.false, %cond.true
  call void @llvm.dbg.declare(metadata i32* %a25, metadata !71, metadata !12), !dbg !73
  store i32 3, i32* %a25, align 4, !dbg !73
  br label %if.end26

if.end26:                                         ; preds = %if.else24, %if.then22
  br label %if.end27

if.end27:                                         ; preds = %if.end26, %if.then18
  call void @llvm.dbg.declare(metadata i32* %a28, metadata !74, metadata !12), !dbg !75
  store i32 1, i32* %a28, align 4, !dbg !75
  br label %sw.epilog, !dbg !76

sw.epilog:                                        ; preds = %if.end27
  call void @llvm.dbg.declare(metadata i32* %a29, metadata !77, metadata !12), !dbg !78
  store i32 1, i32* %a29, align 4, !dbg !78
  br label %sw.epilog30, !dbg !79

sw.epilog30:                                      ; preds = %sw.epilog
  br label %if.end31, !dbg !80

if.end31:                                         ; preds = %sw.epilog30, %if.then
  call void @llvm.dbg.declare(metadata i32* %eot, metadata !81, metadata !12), !dbg !82
  store i32 0, i32* %eot, align 4, !dbg !82
  br label %if.end32, !dbg !83

if.end32:                                         ; preds = %if.end31, %entry
  call void @llvm.dbg.declare(metadata i32* %a33, metadata !84, metadata !12), !dbg !85
  store i32 0, i32* %a33, align 4, !dbg !85
  %5 = load i32, i32* %untainted, align 4, !dbg !86
  %tobool34 = icmp ne i32 %5, 0, !dbg !86
  br i1 %tobool34, label %if.then35, label %if.else36, !dbg !88

if.then35:                                        ; preds = %if.end32
  store i32 1, i32* %a33, align 4, !dbg !89
  br label %if.end37, !dbg !91

if.else36:                                        ; preds = %if.end32
  store i32 2, i32* %a33, align 4, !dbg !92
  br label %if.end37

if.end37:                                         ; preds = %if.else36, %if.then35
  %6 = load i32, i32* %rc, align 4, !dbg !94
  switch i32 %6, label %sw.epilog40 [
    i32 0, label %sw.bb38
  ], !dbg !95

sw.bb38:                                          ; preds = %if.end37
  call void @llvm.dbg.declare(metadata i32* %a39, metadata !96, metadata !12), !dbg !98
  store i32 0, i32* %a39, align 4, !dbg !98
  br label %sw.epilog40, !dbg !99

sw.epilog40:                                      ; preds = %if.end37, %sw.bb38
  %7 = load i32, i32* %rc, align 4, !dbg !100
  ret i32 %7, !dbg !101
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @getenv(i8*) #2

declare i32 @bar(...) #2

declare i32 @foo(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/100-mixed-2")
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
!34 = !DILocation(line: 22, column: 25, scope: !35)
!35 = distinct !DILexicalBlock(scope: !36, file: !1, line: 22, column: 25)
!36 = distinct !DILexicalBlock(scope: !30, file: !1, line: 19, column: 29)
!37 = !DILocation(line: 22, column: 25, scope: !36)
!38 = !DILocalVariable(name: "a", scope: !39, file: !1, line: 23, type: !10)
!39 = distinct !DILexicalBlock(scope: !35, file: !1, line: 22, column: 32)
!40 = !DILocation(line: 23, column: 29, scope: !39)
!41 = !DILocation(line: 24, column: 21, scope: !39)
!42 = !DILocation(line: 24, column: 32, scope: !43)
!43 = distinct !DILexicalBlock(scope: !35, file: !1, line: 24, column: 32)
!44 = !DILocation(line: 24, column: 38, scope: !43)
!45 = !DILocation(line: 24, column: 41, scope: !43)
!46 = !DILocation(line: 24, column: 32, scope: !35)
!47 = !DILocalVariable(name: "a", scope: !48, file: !1, line: 25, type: !10)
!48 = distinct !DILexicalBlock(scope: !43, file: !1, line: 24, column: 48)
!49 = !DILocation(line: 25, column: 29, scope: !48)
!50 = !DILocation(line: 26, column: 21, scope: !48)
!51 = !DILocalVariable(name: "a", scope: !52, file: !1, line: 27, type: !10)
!52 = distinct !DILexicalBlock(scope: !43, file: !1, line: 26, column: 28)
!53 = !DILocation(line: 27, column: 29, scope: !52)
!54 = !DILocation(line: 29, column: 24, scope: !36)
!55 = !DILocation(line: 29, column: 21, scope: !36)
!56 = !DILocation(line: 32, column: 25, scope: !57)
!57 = distinct !DILexicalBlock(scope: !36, file: !1, line: 32, column: 25)
!58 = !DILocation(line: 32, column: 25, scope: !36)
!59 = !DILocalVariable(name: "a", scope: !60, file: !1, line: 33, type: !10)
!60 = distinct !DILexicalBlock(scope: !57, file: !1, line: 32, column: 32)
!61 = !DILocation(line: 33, column: 29, scope: !60)
!62 = !DILocation(line: 34, column: 21, scope: !60)
!63 = !DILocation(line: 34, column: 32, scope: !64)
!64 = distinct !DILexicalBlock(scope: !57, file: !1, line: 34, column: 32)
!65 = !DILocation(line: 34, column: 38, scope: !64)
!66 = !DILocation(line: 34, column: 32, scope: !57)
!67 = !DILocalVariable(name: "a", scope: !68, file: !1, line: 35, type: !10)
!68 = distinct !DILexicalBlock(scope: !64, file: !1, line: 34, column: 52)
!69 = !DILocation(line: 35, column: 29, scope: !68)
!70 = !DILocation(line: 36, column: 21, scope: !68)
!71 = !DILocalVariable(name: "a", scope: !72, file: !1, line: 37, type: !10)
!72 = distinct !DILexicalBlock(scope: !64, file: !1, line: 36, column: 28)
!73 = !DILocation(line: 37, column: 29, scope: !72)
!74 = !DILocalVariable(name: "a", scope: !36, file: !1, line: 39, type: !10)
!75 = !DILocation(line: 39, column: 25, scope: !36)
!76 = !DILocation(line: 40, column: 21, scope: !36)
!77 = !DILocalVariable(name: "a", scope: !30, file: !1, line: 42, type: !10)
!78 = !DILocation(line: 42, column: 21, scope: !30)
!79 = !DILocation(line: 43, column: 17, scope: !30)
!80 = !DILocation(line: 45, column: 9, scope: !27)
!81 = !DILocalVariable(name: "eot", scope: !24, file: !1, line: 46, type: !10)
!82 = !DILocation(line: 46, column: 13, scope: !24)
!83 = !DILocation(line: 47, column: 5, scope: !24)
!84 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 48, type: !10)
!85 = !DILocation(line: 48, column: 9, scope: !7)
!86 = !DILocation(line: 50, column: 9, scope: !87)
!87 = distinct !DILexicalBlock(scope: !7, file: !1, line: 50, column: 9)
!88 = !DILocation(line: 50, column: 9, scope: !7)
!89 = !DILocation(line: 51, column: 11, scope: !90)
!90 = distinct !DILexicalBlock(scope: !87, file: !1, line: 50, column: 20)
!91 = !DILocation(line: 52, column: 5, scope: !90)
!92 = !DILocation(line: 53, column: 11, scope: !93)
!93 = distinct !DILexicalBlock(scope: !87, file: !1, line: 52, column: 12)
!94 = !DILocation(line: 56, column: 13, scope: !7)
!95 = !DILocation(line: 56, column: 5, scope: !7)
!96 = !DILocalVariable(name: "a", scope: !97, file: !1, line: 59, type: !10)
!97 = distinct !DILexicalBlock(scope: !7, file: !1, line: 56, column: 17)
!98 = !DILocation(line: 59, column: 13, scope: !97)
!99 = !DILocation(line: 60, column: 9, scope: !97)
!100 = !DILocation(line: 63, column: 12, scope: !7)
!101 = !DILocation(line: 63, column: 5, scope: !7)
