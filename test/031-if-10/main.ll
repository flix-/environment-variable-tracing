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
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %untainted, metadata !14, metadata !12), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !16, metadata !12), !dbg !17
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !18
  store i32 %call, i32* %taint, align 4, !dbg !17
  %0 = load i32, i32* %taint, align 4, !dbg !19
  %tobool = icmp ne i32 %0, 0, !dbg !19
  br i1 %tobool, label %if.then, label %if.else4, !dbg !21

if.then:                                          ; preds = %entry
  %call1 = call i32 (...) @foo(), !dbg !22
  %tobool2 = icmp ne i32 %call1, 0, !dbg !22
  br i1 %tobool2, label %if.then3, label %if.else, !dbg !25

if.then3:                                         ; preds = %if.then
  store i32 1, i32* %rc, align 4, !dbg !26
  br label %if.end, !dbg !28

if.else:                                          ; preds = %if.then
  store i32 1, i32* %rc, align 4, !dbg !29
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end10, !dbg !31

if.else4:                                         ; preds = %entry
  %call5 = call i32 (...) @foo(), !dbg !32
  %tobool6 = icmp ne i32 %call5, 0, !dbg !32
  br i1 %tobool6, label %if.then7, label %if.else8, !dbg !35

if.then7:                                         ; preds = %if.else4
  store i32 1, i32* %rc, align 4, !dbg !36
  br label %if.end9, !dbg !38

if.else8:                                         ; preds = %if.else4
  store i32 1, i32* %rc, align 4, !dbg !39
  br label %if.end9

if.end9:                                          ; preds = %if.else8, %if.then7
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.end
  call void @llvm.dbg.declare(metadata i32* %a, metadata !41, metadata !12), !dbg !42
  store i32 1, i32* %a, align 4, !dbg !42
  %1 = load i32, i32* %untainted, align 4, !dbg !43
  %tobool11 = icmp ne i32 %1, 0, !dbg !43
  br i1 %tobool11, label %if.then12, label %if.else13, !dbg !45

if.then12:                                        ; preds = %if.end10
  store i32 0, i32* %a, align 4, !dbg !46
  br label %if.end14, !dbg !48

if.else13:                                        ; preds = %if.end10
  store i32 1, i32* %a, align 4, !dbg !49
  br label %if.end14

if.end14:                                         ; preds = %if.else13, %if.then12
  %2 = load i32, i32* %rc, align 4, !dbg !51
  ret i32 %2, !dbg !52
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/031-if-10")
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
!24 = distinct !DILexicalBlock(scope: !20, file: !1, line: 12, column: 16)
!25 = !DILocation(line: 13, column: 13, scope: !24)
!26 = !DILocation(line: 14, column: 16, scope: !27)
!27 = distinct !DILexicalBlock(scope: !23, file: !1, line: 13, column: 20)
!28 = !DILocation(line: 15, column: 9, scope: !27)
!29 = !DILocation(line: 16, column: 16, scope: !30)
!30 = distinct !DILexicalBlock(scope: !23, file: !1, line: 15, column: 16)
!31 = !DILocation(line: 18, column: 5, scope: !24)
!32 = !DILocation(line: 19, column: 13, scope: !33)
!33 = distinct !DILexicalBlock(scope: !34, file: !1, line: 19, column: 13)
!34 = distinct !DILexicalBlock(scope: !20, file: !1, line: 18, column: 12)
!35 = !DILocation(line: 19, column: 13, scope: !34)
!36 = !DILocation(line: 20, column: 16, scope: !37)
!37 = distinct !DILexicalBlock(scope: !33, file: !1, line: 19, column: 20)
!38 = !DILocation(line: 21, column: 9, scope: !37)
!39 = !DILocation(line: 22, column: 16, scope: !40)
!40 = distinct !DILexicalBlock(scope: !33, file: !1, line: 21, column: 16)
!41 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 25, type: !10)
!42 = !DILocation(line: 25, column: 9, scope: !7)
!43 = !DILocation(line: 27, column: 9, scope: !44)
!44 = distinct !DILexicalBlock(scope: !7, file: !1, line: 27, column: 9)
!45 = !DILocation(line: 27, column: 9, scope: !7)
!46 = !DILocation(line: 28, column: 11, scope: !47)
!47 = distinct !DILexicalBlock(scope: !44, file: !1, line: 27, column: 20)
!48 = !DILocation(line: 29, column: 5, scope: !47)
!49 = !DILocation(line: 30, column: 11, scope: !50)
!50 = distinct !DILexicalBlock(scope: !44, file: !1, line: 29, column: 12)
!51 = !DILocation(line: 33, column: 12, scope: !7)
!52 = !DILocation(line: 33, column: 5, scope: !7)
