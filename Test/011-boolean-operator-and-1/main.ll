; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %taint = alloca i32, align 4
  %a = alloca i32, align 4
  %no_taint = alloca i32, align 4
  %a4 = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !11, metadata !12), !dbg !13
  %call = call i32 @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !14
  %tobool = icmp ne i32 %call, 0, !dbg !14
  br i1 %tobool, label %land.rhs, label %land.end, !dbg !15

land.rhs:                                         ; preds = %entry
  %call1 = call i32 (...) @bar(), !dbg !16
  %tobool2 = icmp ne i32 %call1, 0, !dbg !15
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %0 = phi i1 [ false, %entry ], [ %tobool2, %land.rhs ]
  %land.ext = zext i1 %0 to i32, !dbg !15
  store i32 %land.ext, i32* %taint, align 4, !dbg !13
  call void @llvm.dbg.declare(metadata i32* %a, metadata !17, metadata !12), !dbg !18
  %1 = load i32, i32* %taint, align 4, !dbg !19
  store i32 %1, i32* %a, align 4, !dbg !18
  call void @llvm.dbg.declare(metadata i32* %no_taint, metadata !20, metadata !12), !dbg !21
  store i32 1, i32* %no_taint, align 4, !dbg !21
  %2 = load i32, i32* %no_taint, align 4, !dbg !22
  %tobool3 = icmp ne i32 %2, 0, !dbg !22
  br i1 %tobool3, label %if.then, label %if.else, !dbg !24

if.then:                                          ; preds = %land.end
  call void @llvm.dbg.declare(metadata i32* %a4, metadata !25, metadata !12), !dbg !27
  store i32 0, i32* %a4, align 4, !dbg !27
  br label %if.end, !dbg !28

if.else:                                          ; preds = %land.end
  call void @llvm.dbg.declare(metadata i32* %b, metadata !29, metadata !12), !dbg !31
  store i32 0, i32* %b, align 4, !dbg !31
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret i32 0, !dbg !32
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @getenv(i8*) #2

declare i32 @bar(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/011-boolean-operator-and-1")
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
!15 = !DILocation(line: 8, column: 30, scope: !7)
!16 = !DILocation(line: 8, column: 33, scope: !7)
!17 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 9, type: !10)
!18 = !DILocation(line: 9, column: 9, scope: !7)
!19 = !DILocation(line: 9, column: 13, scope: !7)
!20 = !DILocalVariable(name: "no_taint", scope: !7, file: !1, line: 11, type: !10)
!21 = !DILocation(line: 11, column: 9, scope: !7)
!22 = !DILocation(line: 12, column: 9, scope: !23)
!23 = distinct !DILexicalBlock(scope: !7, file: !1, line: 12, column: 9)
!24 = !DILocation(line: 12, column: 9, scope: !7)
!25 = !DILocalVariable(name: "a", scope: !26, file: !1, line: 13, type: !10)
!26 = distinct !DILexicalBlock(scope: !23, file: !1, line: 12, column: 19)
!27 = !DILocation(line: 13, column: 13, scope: !26)
!28 = !DILocation(line: 14, column: 5, scope: !26)
!29 = !DILocalVariable(name: "b", scope: !30, file: !1, line: 15, type: !10)
!30 = distinct !DILexicalBlock(scope: !23, file: !1, line: 14, column: 12)
!31 = !DILocation(line: 15, column: 13, scope: !30)
!32 = !DILocation(line: 18, column: 5, scope: !7)
