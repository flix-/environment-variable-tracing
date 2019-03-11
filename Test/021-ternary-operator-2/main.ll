; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %taint = alloca i32, align 4
  %a = alloca i32, align 4
  %a3 = alloca i32, align 4
  %b = alloca i32, align 4
  %ut = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !11, metadata !12), !dbg !13
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !14
  %cmp = icmp eq i32 %call, 0, !dbg !15
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !14

cond.true:                                        ; preds = %entry
  %call1 = call i32 (...) @foo(), !dbg !16
  br label %cond.end, !dbg !14

cond.false:                                       ; preds = %entry
  br label %cond.end, !dbg !14

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %call1, %cond.true ], [ 1, %cond.false ], !dbg !14
  store i32 %cond, i32* %taint, align 4, !dbg !13
  call void @llvm.dbg.declare(metadata i32* %a, metadata !17, metadata !12), !dbg !18
  %0 = load i32, i32* %taint, align 4, !dbg !19
  store i32 %0, i32* %a, align 4, !dbg !18
  %call2 = call i32 (...) @foo(), !dbg !20
  %tobool = icmp ne i32 %call2, 0, !dbg !20
  br i1 %tobool, label %if.then, label %if.else, !dbg !22

if.then:                                          ; preds = %cond.end
  call void @llvm.dbg.declare(metadata i32* %a3, metadata !23, metadata !12), !dbg !25
  store i32 0, i32* %a3, align 4, !dbg !25
  br label %if.end, !dbg !26

if.else:                                          ; preds = %cond.end
  call void @llvm.dbg.declare(metadata i32* %b, metadata !27, metadata !12), !dbg !29
  store i32 0, i32* %b, align 4, !dbg !29
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !30, metadata !12), !dbg !31
  store i32 1, i32* %ut, align 4, !dbg !31
  ret i32 0, !dbg !32
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/021-ternary-operator-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "taint", scope: !7, file: !1, line: 8, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 8, column: 9, scope: !7)
!14 = !DILocation(line: 8, column: 17, scope: !7)
!15 = !DILocation(line: 8, column: 32, scope: !7)
!16 = !DILocation(line: 8, column: 39, scope: !7)
!17 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 9, type: !10)
!18 = !DILocation(line: 9, column: 9, scope: !7)
!19 = !DILocation(line: 9, column: 13, scope: !7)
!20 = !DILocation(line: 11, column: 9, scope: !21)
!21 = distinct !DILexicalBlock(scope: !7, file: !1, line: 11, column: 9)
!22 = !DILocation(line: 11, column: 9, scope: !7)
!23 = !DILocalVariable(name: "a", scope: !24, file: !1, line: 12, type: !10)
!24 = distinct !DILexicalBlock(scope: !21, file: !1, line: 11, column: 16)
!25 = !DILocation(line: 12, column: 13, scope: !24)
!26 = !DILocation(line: 13, column: 5, scope: !24)
!27 = !DILocalVariable(name: "b", scope: !28, file: !1, line: 14, type: !10)
!28 = distinct !DILexicalBlock(scope: !21, file: !1, line: 13, column: 12)
!29 = !DILocation(line: 14, column: 13, scope: !28)
!30 = !DILocalVariable(name: "ut", scope: !7, file: !1, line: 17, type: !10)
!31 = !DILocation(line: 17, column: 9, scope: !7)
!32 = !DILocation(line: 19, column: 5, scope: !7)
