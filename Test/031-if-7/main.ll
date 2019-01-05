; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %ret = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %ret, metadata !11, metadata !12), !dbg !13
  %call = call i32 (...) @foo(), !dbg !14
  %tobool = icmp ne i32 %call, 0, !dbg !14
  br i1 %tobool, label %if.then, label %if.else13, !dbg !16

if.then:                                          ; preds = %entry
  %call1 = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !17
  %tobool2 = icmp ne i32 %call1, 0, !dbg !17
  br i1 %tobool2, label %if.then3, label %if.else, !dbg !20

if.then3:                                         ; preds = %if.then
  call void @llvm.dbg.declare(metadata i32* %a, metadata !21, metadata !12), !dbg !23
  store i32 100, i32* %a, align 4, !dbg !23
  %0 = load i32, i32* %a, align 4, !dbg !24
  store i32 %0, i32* %ret, align 4, !dbg !25
  br label %if.end12, !dbg !26

if.else:                                          ; preds = %if.then
  %call4 = call i32 (...) @bar(), !dbg !27
  %tobool5 = icmp ne i32 %call4, 0, !dbg !27
  br i1 %tobool5, label %if.then6, label %if.else7, !dbg !29

if.then6:                                         ; preds = %if.else
  store i32 100, i32* %ret, align 4, !dbg !30
  br label %if.end11, !dbg !32

if.else7:                                         ; preds = %if.else
  %call8 = call i32 (...) @foo(), !dbg !33
  %tobool9 = icmp ne i32 %call8, 0, !dbg !33
  br i1 %tobool9, label %if.then10, label %if.end, !dbg !36

if.then10:                                        ; preds = %if.else7
  store i32 100, i32* %ret, align 4, !dbg !37
  br label %if.end, !dbg !39

if.end:                                           ; preds = %if.then10, %if.else7
  br label %if.end11

if.end11:                                         ; preds = %if.end, %if.then6
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then3
  store i32 100, i32* %ret, align 4, !dbg !40
  br label %if.end14, !dbg !41

if.else13:                                        ; preds = %entry
  store i32 100, i32* %ret, align 4, !dbg !42
  br label %if.end14

if.end14:                                         ; preds = %if.else13, %if.end12
  %1 = load i32, i32* %ret, align 4, !dbg !44
  ret i32 %1, !dbg !45
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @foo(...) #2

declare i32 @getenv(i8*) #2

declare i32 @bar(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-7")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "ret", scope: !7, file: !1, line: 8, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 8, column: 9, scope: !7)
!14 = !DILocation(line: 9, column: 9, scope: !15)
!15 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 9)
!16 = !DILocation(line: 9, column: 9, scope: !7)
!17 = !DILocation(line: 10, column: 13, scope: !18)
!18 = distinct !DILexicalBlock(scope: !19, file: !1, line: 10, column: 13)
!19 = distinct !DILexicalBlock(scope: !15, file: !1, line: 9, column: 16)
!20 = !DILocation(line: 10, column: 13, scope: !19)
!21 = !DILocalVariable(name: "a", scope: !22, file: !1, line: 11, type: !10)
!22 = distinct !DILexicalBlock(scope: !18, file: !1, line: 10, column: 29)
!23 = !DILocation(line: 11, column: 17, scope: !22)
!24 = !DILocation(line: 12, column: 19, scope: !22)
!25 = !DILocation(line: 12, column: 17, scope: !22)
!26 = !DILocation(line: 13, column: 9, scope: !22)
!27 = !DILocation(line: 13, column: 20, scope: !28)
!28 = distinct !DILexicalBlock(scope: !18, file: !1, line: 13, column: 20)
!29 = !DILocation(line: 13, column: 20, scope: !18)
!30 = !DILocation(line: 14, column: 17, scope: !31)
!31 = distinct !DILexicalBlock(scope: !28, file: !1, line: 13, column: 27)
!32 = !DILocation(line: 15, column: 9, scope: !31)
!33 = !DILocation(line: 16, column: 17, scope: !34)
!34 = distinct !DILexicalBlock(scope: !35, file: !1, line: 16, column: 17)
!35 = distinct !DILexicalBlock(scope: !28, file: !1, line: 15, column: 16)
!36 = !DILocation(line: 16, column: 17, scope: !35)
!37 = !DILocation(line: 17, column: 21, scope: !38)
!38 = distinct !DILexicalBlock(scope: !34, file: !1, line: 16, column: 24)
!39 = !DILocation(line: 18, column: 13, scope: !38)
!40 = !DILocation(line: 20, column: 13, scope: !19)
!41 = !DILocation(line: 21, column: 5, scope: !19)
!42 = !DILocation(line: 22, column: 13, scope: !43)
!43 = distinct !DILexicalBlock(scope: !15, file: !1, line: 21, column: 12)
!44 = !DILocation(line: 25, column: 12, scope: !7)
!45 = !DILocation(line: 25, column: 5, scope: !7)
