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
  %ut = alloca i32, align 4
  %i = alloca i32, align 4
  %a = alloca i32, align 4
  %a4 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  br label %while.cond, !dbg !14

while.cond:                                       ; preds = %if.end, %entry
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !15
  %tobool = icmp ne i32 %call, 0, !dbg !14
  br i1 %tobool, label %while.body, label %while.end, !dbg !14

while.body:                                       ; preds = %while.cond
  %0 = load i32, i32* %rc, align 4, !dbg !16
  %cmp = icmp eq i32 %0, 0, !dbg !19
  br i1 %cmp, label %if.then, label %if.end, !dbg !20

if.then:                                          ; preds = %while.body
  br label %while.end, !dbg !21

if.end:                                           ; preds = %while.body
  store i32 100, i32* %rc, align 4, !dbg !22
  br label %while.cond, !dbg !14, !llvm.loop !23

while.end:                                        ; preds = %if.then, %while.cond
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !25, metadata !12), !dbg !26
  store i32 0, i32* %ut, align 4, !dbg !26
  call void @llvm.dbg.declare(metadata i32* %i, metadata !27, metadata !12), !dbg !29
  store i32 0, i32* %i, align 4, !dbg !29
  br label %for.cond, !dbg !30

for.cond:                                         ; preds = %for.inc, %while.end
  %1 = load i32, i32* %i, align 4, !dbg !31
  %cmp1 = icmp slt i32 %1, 10, !dbg !33
  br i1 %cmp1, label %for.body, label %for.end, !dbg !34

for.body:                                         ; preds = %for.cond
  br label %while.body3, !dbg !35

while.body3:                                      ; preds = %for.body, %while.body3
  call void @llvm.dbg.declare(metadata i32* %a, metadata !37, metadata !12), !dbg !39
  store i32 0, i32* %a, align 4, !dbg !39
  br label %while.body3, !dbg !35, !llvm.loop !40

for.inc:                                          ; No predecessors!
  %2 = load i32, i32* %i, align 4, !dbg !42
  %inc = add nsw i32 %2, 1, !dbg !42
  store i32 %inc, i32* %i, align 4, !dbg !42
  br label %for.cond, !dbg !43, !llvm.loop !44

for.end:                                          ; preds = %for.cond
  %3 = load i32, i32* %rc, align 4, !dbg !46
  ret i32 %3, !dbg !47
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/051-while-loop-5")
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
!15 = !DILocation(line: 9, column: 12, scope: !7)
!16 = !DILocation(line: 10, column: 13, scope: !17)
!17 = distinct !DILexicalBlock(scope: !18, file: !1, line: 10, column: 13)
!18 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 28)
!19 = !DILocation(line: 10, column: 16, scope: !17)
!20 = !DILocation(line: 10, column: 13, scope: !18)
!21 = !DILocation(line: 10, column: 22, scope: !17)
!22 = !DILocation(line: 11, column: 12, scope: !18)
!23 = distinct !{!23, !14, !24}
!24 = !DILocation(line: 12, column: 5, scope: !7)
!25 = !DILocalVariable(name: "ut", scope: !7, file: !1, line: 14, type: !10)
!26 = !DILocation(line: 14, column: 9, scope: !7)
!27 = !DILocalVariable(name: "i", scope: !28, file: !1, line: 16, type: !10)
!28 = distinct !DILexicalBlock(scope: !7, file: !1, line: 16, column: 5)
!29 = !DILocation(line: 16, column: 14, scope: !28)
!30 = !DILocation(line: 16, column: 10, scope: !28)
!31 = !DILocation(line: 16, column: 21, scope: !32)
!32 = distinct !DILexicalBlock(scope: !28, file: !1, line: 16, column: 5)
!33 = !DILocation(line: 16, column: 23, scope: !32)
!34 = !DILocation(line: 16, column: 5, scope: !28)
!35 = !DILocation(line: 17, column: 9, scope: !36)
!36 = distinct !DILexicalBlock(scope: !32, file: !1, line: 16, column: 34)
!37 = !DILocalVariable(name: "a", scope: !38, file: !1, line: 18, type: !10)
!38 = distinct !DILexicalBlock(scope: !36, file: !1, line: 17, column: 19)
!39 = !DILocation(line: 18, column: 17, scope: !38)
!40 = distinct !{!40, !35, !41}
!41 = !DILocation(line: 19, column: 9, scope: !36)
!42 = !DILocation(line: 16, column: 29, scope: !32)
!43 = !DILocation(line: 16, column: 5, scope: !32)
!44 = distinct !{!44, !34, !45}
!45 = !DILocation(line: 21, column: 5, scope: !28)
!46 = !DILocation(line: 23, column: 12, scope: !7)
!47 = !DILocation(line: 23, column: 5, scope: !7)
