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
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %end = alloca i32, align 4
  %a7 = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !14, metadata !12), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %i, metadata !16, metadata !12), !dbg !18
  store i32 0, i32* %i, align 4, !dbg !18
  br label %for.cond, !dbg !19

for.cond:                                         ; preds = %for.inc4, %entry
  %0 = load i32, i32* %i, align 4, !dbg !20
  %cmp = icmp slt i32 %0, 10, !dbg !22
  br i1 %cmp, label %for.body, label %for.end6, !dbg !23

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !24, metadata !12), !dbg !27
  store i32 0, i32* %j, align 4, !dbg !27
  br label %for.cond1, !dbg !28

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !29
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !31
  %cmp2 = icmp slt i32 %1, %call, !dbg !32
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !33

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %j, align 4, !dbg !34
  store i32 %2, i32* %rc, align 4, !dbg !36
  br label %for.inc, !dbg !37

for.inc:                                          ; preds = %for.body3
  %3 = load i32, i32* %j, align 4, !dbg !38
  %inc = add nsw i32 %3, 1, !dbg !38
  store i32 %inc, i32* %j, align 4, !dbg !38
  br label %for.cond1, !dbg !39, !llvm.loop !40

for.end:                                          ; preds = %for.cond1
  call void @llvm.dbg.declare(metadata i32* %end, metadata !42, metadata !12), !dbg !43
  store i32 1, i32* %end, align 4, !dbg !43
  br label %for.inc4, !dbg !44

for.inc4:                                         ; preds = %for.end
  %4 = load i32, i32* %i, align 4, !dbg !45
  %inc5 = add nsw i32 %4, 1, !dbg !45
  store i32 %inc5, i32* %i, align 4, !dbg !45
  br label %for.cond, !dbg !46, !llvm.loop !47

for.end6:                                         ; preds = %for.cond
  %5 = load i32, i32* %a, align 4, !dbg !49
  %tobool = icmp ne i32 %5, 0, !dbg !49
  br i1 %tobool, label %if.then, label %if.else, !dbg !51

if.then:                                          ; preds = %for.end6
  call void @llvm.dbg.declare(metadata i32* %a7, metadata !52, metadata !12), !dbg !54
  store i32 0, i32* %a7, align 4, !dbg !54
  br label %if.end, !dbg !55

if.else:                                          ; preds = %for.end6
  call void @llvm.dbg.declare(metadata i32* %b, metadata !56, metadata !12), !dbg !58
  store i32 1, i32* %b, align 4, !dbg !58
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %6 = load i32, i32* %rc, align 4, !dbg !59
  ret i32 %6, !dbg !60
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/041-for-loop-4")
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
!16 = !DILocalVariable(name: "i", scope: !17, file: !1, line: 11, type: !10)
!17 = distinct !DILexicalBlock(scope: !7, file: !1, line: 11, column: 5)
!18 = !DILocation(line: 11, column: 14, scope: !17)
!19 = !DILocation(line: 11, column: 10, scope: !17)
!20 = !DILocation(line: 11, column: 21, scope: !21)
!21 = distinct !DILexicalBlock(scope: !17, file: !1, line: 11, column: 5)
!22 = !DILocation(line: 11, column: 23, scope: !21)
!23 = !DILocation(line: 11, column: 5, scope: !17)
!24 = !DILocalVariable(name: "j", scope: !25, file: !1, line: 12, type: !10)
!25 = distinct !DILexicalBlock(scope: !26, file: !1, line: 12, column: 9)
!26 = distinct !DILexicalBlock(scope: !21, file: !1, line: 11, column: 34)
!27 = !DILocation(line: 12, column: 18, scope: !25)
!28 = !DILocation(line: 12, column: 14, scope: !25)
!29 = !DILocation(line: 12, column: 25, scope: !30)
!30 = distinct !DILexicalBlock(scope: !25, file: !1, line: 12, column: 9)
!31 = !DILocation(line: 12, column: 29, scope: !30)
!32 = !DILocation(line: 12, column: 27, scope: !30)
!33 = !DILocation(line: 12, column: 9, scope: !25)
!34 = !DILocation(line: 13, column: 18, scope: !35)
!35 = distinct !DILexicalBlock(scope: !30, file: !1, line: 12, column: 50)
!36 = !DILocation(line: 13, column: 16, scope: !35)
!37 = !DILocation(line: 14, column: 9, scope: !35)
!38 = !DILocation(line: 12, column: 46, scope: !30)
!39 = !DILocation(line: 12, column: 9, scope: !30)
!40 = distinct !{!40, !33, !41}
!41 = !DILocation(line: 14, column: 9, scope: !25)
!42 = !DILocalVariable(name: "end", scope: !26, file: !1, line: 15, type: !10)
!43 = !DILocation(line: 15, column: 13, scope: !26)
!44 = !DILocation(line: 16, column: 5, scope: !26)
!45 = !DILocation(line: 11, column: 30, scope: !21)
!46 = !DILocation(line: 11, column: 5, scope: !21)
!47 = distinct !{!47, !23, !48}
!48 = !DILocation(line: 16, column: 5, scope: !17)
!49 = !DILocation(line: 18, column: 9, scope: !50)
!50 = distinct !DILexicalBlock(scope: !7, file: !1, line: 18, column: 9)
!51 = !DILocation(line: 18, column: 9, scope: !7)
!52 = !DILocalVariable(name: "a", scope: !53, file: !1, line: 19, type: !10)
!53 = distinct !DILexicalBlock(scope: !50, file: !1, line: 18, column: 12)
!54 = !DILocation(line: 19, column: 13, scope: !53)
!55 = !DILocation(line: 20, column: 5, scope: !53)
!56 = !DILocalVariable(name: "b", scope: !57, file: !1, line: 21, type: !10)
!57 = distinct !DILexicalBlock(scope: !50, file: !1, line: 20, column: 12)
!58 = !DILocation(line: 21, column: 13, scope: !57)
!59 = !DILocation(line: 24, column: 12, scope: !7)
!60 = !DILocation(line: 24, column: 5, scope: !7)
