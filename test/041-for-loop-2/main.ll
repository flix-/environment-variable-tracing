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
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %i, metadata !14, metadata !12), !dbg !16
  store i32 0, i32* %i, align 4, !dbg !16
  br label %for.cond, !dbg !17

for.cond:                                         ; preds = %for.inc, %entry
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !18
  %tobool = icmp ne i32 %call, 0, !dbg !18
  br i1 %tobool, label %land.rhs, label %land.end, !dbg !20

land.rhs:                                         ; preds = %for.cond
  %call1 = call i32 (...) @foo(), !dbg !21
  %tobool2 = icmp ne i32 %call1, 0, !dbg !20
  br label %land.end

land.end:                                         ; preds = %land.rhs, %for.cond
  %0 = phi i1 [ false, %for.cond ], [ %tobool2, %land.rhs ]
  br i1 %0, label %for.body, label %for.end, !dbg !22

for.body:                                         ; preds = %land.end
  %1 = load i32, i32* %i, align 4, !dbg !23
  store i32 %1, i32* %rc, align 4, !dbg !25
  br label %for.inc, !dbg !26

for.inc:                                          ; preds = %for.body
  %2 = load i32, i32* %i, align 4, !dbg !27
  %inc = add nsw i32 %2, 1, !dbg !27
  store i32 %inc, i32* %i, align 4, !dbg !27
  br label %for.cond, !dbg !28, !llvm.loop !29

for.end:                                          ; preds = %land.end
  %3 = load i32, i32* %rc, align 4, !dbg !31
  ret i32 %3, !dbg !32
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/041-for-loop-2")
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
!14 = !DILocalVariable(name: "i", scope: !15, file: !1, line: 9, type: !10)
!15 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 5)
!16 = !DILocation(line: 9, column: 14, scope: !15)
!17 = !DILocation(line: 9, column: 10, scope: !15)
!18 = !DILocation(line: 9, column: 21, scope: !19)
!19 = distinct !DILexicalBlock(scope: !15, file: !1, line: 9, column: 5)
!20 = !DILocation(line: 9, column: 36, scope: !19)
!21 = !DILocation(line: 9, column: 39, scope: !19)
!22 = !DILocation(line: 9, column: 5, scope: !15)
!23 = !DILocation(line: 10, column: 14, scope: !24)
!24 = distinct !DILexicalBlock(scope: !19, file: !1, line: 9, column: 51)
!25 = !DILocation(line: 10, column: 12, scope: !24)
!26 = !DILocation(line: 11, column: 5, scope: !24)
!27 = !DILocation(line: 9, column: 47, scope: !19)
!28 = !DILocation(line: 9, column: 5, scope: !19)
!29 = distinct !{!29, !22, !30}
!30 = !DILocation(line: 11, column: 5, scope: !15)
!31 = !DILocation(line: 13, column: 12, scope: !7)
!32 = !DILocation(line: 13, column: 5, scope: !7)
