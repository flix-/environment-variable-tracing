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
  %a1 = alloca i32, align 4
  %nt = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !14, metadata !12), !dbg !15
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !16
  store i32 %call, i32* %taint, align 4, !dbg !15
  %0 = load i32, i32* %taint, align 4, !dbg !17
  %cmp = icmp eq i32 %0, 0, !dbg !19
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !20

cond.true:                                        ; preds = %entry
  br i1 false, label %if.then, label %if.else, !dbg !17

cond.false:                                       ; preds = %entry
  br i1 true, label %if.then, label %if.else, !dbg !20

if.then:                                          ; preds = %cond.false, %cond.true
  call void @llvm.dbg.declare(metadata i32* %a, metadata !21, metadata !12), !dbg !23
  store i32 2, i32* %a, align 4, !dbg !23
  br label %if.end, !dbg !24

if.else:                                          ; preds = %cond.false, %cond.true
  call void @llvm.dbg.declare(metadata i32* %a1, metadata !25, metadata !12), !dbg !27
  store i32 3, i32* %a1, align 4, !dbg !27
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  call void @llvm.dbg.declare(metadata i32* %nt, metadata !28, metadata !12), !dbg !29
  store i32 1, i32* %nt, align 4, !dbg !29
  %1 = load i32, i32* %rc, align 4, !dbg !30
  ret i32 %1, !dbg !31
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-20")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 5, type: !8, isLocal: false, isDefinition: true, scopeLine: 6, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "rc", scope: !7, file: !1, line: 7, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 7, column: 9, scope: !7)
!14 = !DILocalVariable(name: "taint", scope: !7, file: !1, line: 8, type: !10)
!15 = !DILocation(line: 8, column: 9, scope: !7)
!16 = !DILocation(line: 8, column: 17, scope: !7)
!17 = !DILocation(line: 10, column: 9, scope: !18)
!18 = distinct !DILexicalBlock(scope: !7, file: !1, line: 10, column: 9)
!19 = !DILocation(line: 10, column: 15, scope: !18)
!20 = !DILocation(line: 10, column: 9, scope: !7)
!21 = !DILocalVariable(name: "a", scope: !22, file: !1, line: 11, type: !10)
!22 = distinct !DILexicalBlock(scope: !18, file: !1, line: 10, column: 29)
!23 = !DILocation(line: 11, column: 13, scope: !22)
!24 = !DILocation(line: 12, column: 5, scope: !22)
!25 = !DILocalVariable(name: "a", scope: !26, file: !1, line: 13, type: !10)
!26 = distinct !DILexicalBlock(scope: !18, file: !1, line: 12, column: 12)
!27 = !DILocation(line: 13, column: 13, scope: !26)
!28 = !DILocalVariable(name: "nt", scope: !7, file: !1, line: 16, type: !10)
!29 = !DILocation(line: 16, column: 9, scope: !7)
!30 = !DILocation(line: 18, column: 12, scope: !7)
!31 = !DILocation(line: 18, column: 5, scope: !7)
