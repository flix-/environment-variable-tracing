; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %rc = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %ut = alloca i32, align 4
  %i = alloca i32, align 4
  %a17 = alloca i32, align 4
  %taint_me = alloca i32, align 4
  %ut1 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !13, metadata !14), !dbg !15
  br label %do.body, !dbg !16, !llvm.loop !17

do.body:                                          ; preds = %do.cond11, %entry
  br label %do.body1, !dbg !19, !llvm.loop !21

do.body1:                                         ; preds = %do.cond7, %do.body
  call void @llvm.dbg.declare(metadata i32* %a, metadata !23, metadata !14), !dbg !25
  br label %do.body2, !dbg !26, !llvm.loop !27

do.body2:                                         ; preds = %do.cond, %do.body1
  store i32 1, i32* %a, align 4, !dbg !29
  br label %while.cond, !dbg !31

while.cond:                                       ; preds = %if.end, %do.body2
  %0 = load i32, i32* %a, align 4, !dbg !32
  %tobool = icmp ne i32 %0, 0, !dbg !31
  br i1 %tobool, label %while.body, label %while.end, !dbg !31

while.body:                                       ; preds = %while.cond
  call void @llvm.dbg.declare(metadata i32* %b, metadata !33, metadata !14), !dbg !35
  store i32 0, i32* %b, align 4, !dbg !35
  %1 = load i32, i32* %b, align 4, !dbg !36
  %cmp = icmp eq i32 %1, 1, !dbg !38
  br i1 %cmp, label %if.then, label %if.end, !dbg !39

if.then:                                          ; preds = %while.body
  br label %err, !dbg !40

if.end:                                           ; preds = %while.body
  br label %while.cond, !dbg !31, !llvm.loop !41

while.end:                                        ; preds = %while.cond
  %2 = load i32, i32* %a, align 4, !dbg !43
  %cmp3 = icmp ne i32 %2, 1, !dbg !45
  br i1 %cmp3, label %if.then4, label %if.end5, !dbg !46

if.then4:                                         ; preds = %while.end
  br label %do.cond, !dbg !47

if.end5:                                          ; preds = %while.end
  br label %do.cond, !dbg !48

do.cond:                                          ; preds = %if.end5, %if.then4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !49
  %cmp6 = icmp ne i8* %call, null, !dbg !50
  br i1 %cmp6, label %do.body2, label %do.end, !dbg !48, !llvm.loop !27

do.end:                                           ; preds = %do.cond
  %3 = load i32, i32* %a, align 4, !dbg !51
  store i32 %3, i32* %rc, align 4, !dbg !52
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !53, metadata !14), !dbg !54
  store i32 0, i32* %ut, align 4, !dbg !54
  br label %do.cond7, !dbg !55

do.cond7:                                         ; preds = %do.end
  %call8 = call i32 (...) @foo(), !dbg !56
  %tobool9 = icmp ne i32 %call8, 0, !dbg !55
  br i1 %tobool9, label %do.body1, label %do.end10, !dbg !55, !llvm.loop !21

do.end10:                                         ; preds = %do.cond7
  br label %do.cond11, !dbg !57

do.cond11:                                        ; preds = %do.end10
  %call12 = call i32 (...) @bar(), !dbg !58
  %tobool13 = icmp ne i32 %call12, 0, !dbg !57
  br i1 %tobool13, label %do.body, label %do.end14, !dbg !57, !llvm.loop !17

do.end14:                                         ; preds = %do.cond11
  call void @llvm.dbg.declare(metadata i32* %i, metadata !59, metadata !14), !dbg !61
  store i32 0, i32* %i, align 4, !dbg !61
  br label %for.cond, !dbg !62

for.cond:                                         ; preds = %for.inc, %do.end14
  %call15 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !63
  %cmp16 = icmp ne i8* %call15, null, !dbg !65
  br i1 %cmp16, label %for.body, label %for.end, !dbg !66

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %a17, metadata !67, metadata !14), !dbg !69
  %4 = load i32, i32* %i, align 4, !dbg !70
  store i32 %4, i32* %a17, align 4, !dbg !69
  br label %for.inc, !dbg !71

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* %i, align 4, !dbg !72
  %inc = add nsw i32 %5, 1, !dbg !72
  store i32 %inc, i32* %i, align 4, !dbg !72
  br label %for.cond, !dbg !73, !llvm.loop !74

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %taint_me, metadata !76, metadata !14), !dbg !77
  store i32 1, i32* %taint_me, align 4, !dbg !77
  br label %err, !dbg !78

err:                                              ; preds = %for.end, %if.then
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !79, metadata !14), !dbg !80
  store i32 0, i32* %ut1, align 4, !dbg !80
  %6 = load i32, i32* %rc, align 4, !dbg !81
  ret i32 %6, !dbg !82
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

declare i32 @foo(...) #3

declare i32 @bar(...) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/061-do-while-loop-7")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !10, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "rc", scope: !9, file: !1, line: 10, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 10, column: 9, scope: !9)
!16 = !DILocation(line: 11, column: 5, scope: !9)
!17 = distinct !{!17, !16, !18}
!18 = !DILocation(line: 25, column: 19, scope: !9)
!19 = !DILocation(line: 12, column: 9, scope: !20)
!20 = distinct !DILexicalBlock(scope: !9, file: !1, line: 11, column: 8)
!21 = distinct !{!21, !19, !22}
!22 = !DILocation(line: 24, column: 23, scope: !20)
!23 = !DILocalVariable(name: "a", scope: !24, file: !1, line: 13, type: !12)
!24 = distinct !DILexicalBlock(scope: !20, file: !1, line: 12, column: 12)
!25 = !DILocation(line: 13, column: 17, scope: !24)
!26 = !DILocation(line: 14, column: 13, scope: !24)
!27 = distinct !{!27, !26, !28}
!28 = !DILocation(line: 21, column: 44, scope: !24)
!29 = !DILocation(line: 15, column: 19, scope: !30)
!30 = distinct !DILexicalBlock(scope: !24, file: !1, line: 14, column: 16)
!31 = !DILocation(line: 16, column: 17, scope: !30)
!32 = !DILocation(line: 16, column: 24, scope: !30)
!33 = !DILocalVariable(name: "b", scope: !34, file: !1, line: 17, type: !12)
!34 = distinct !DILexicalBlock(scope: !30, file: !1, line: 16, column: 27)
!35 = !DILocation(line: 17, column: 25, scope: !34)
!36 = !DILocation(line: 18, column: 25, scope: !37)
!37 = distinct !DILexicalBlock(scope: !34, file: !1, line: 18, column: 25)
!38 = !DILocation(line: 18, column: 27, scope: !37)
!39 = !DILocation(line: 18, column: 25, scope: !34)
!40 = !DILocation(line: 18, column: 33, scope: !37)
!41 = distinct !{!41, !31, !42}
!42 = !DILocation(line: 19, column: 17, scope: !30)
!43 = !DILocation(line: 20, column: 21, scope: !44)
!44 = distinct !DILexicalBlock(scope: !30, file: !1, line: 20, column: 21)
!45 = !DILocation(line: 20, column: 23, scope: !44)
!46 = !DILocation(line: 20, column: 21, scope: !30)
!47 = !DILocation(line: 20, column: 29, scope: !44)
!48 = !DILocation(line: 21, column: 13, scope: !30)
!49 = !DILocation(line: 21, column: 22, scope: !24)
!50 = !DILocation(line: 21, column: 37, scope: !24)
!51 = !DILocation(line: 22, column: 18, scope: !24)
!52 = !DILocation(line: 22, column: 16, scope: !24)
!53 = !DILocalVariable(name: "ut", scope: !24, file: !1, line: 23, type: !12)
!54 = !DILocation(line: 23, column: 17, scope: !24)
!55 = !DILocation(line: 24, column: 9, scope: !24)
!56 = !DILocation(line: 24, column: 18, scope: !20)
!57 = !DILocation(line: 25, column: 5, scope: !20)
!58 = !DILocation(line: 25, column: 14, scope: !9)
!59 = !DILocalVariable(name: "i", scope: !60, file: !1, line: 27, type: !12)
!60 = distinct !DILexicalBlock(scope: !9, file: !1, line: 27, column: 5)
!61 = !DILocation(line: 27, column: 14, scope: !60)
!62 = !DILocation(line: 27, column: 10, scope: !60)
!63 = !DILocation(line: 27, column: 21, scope: !64)
!64 = distinct !DILexicalBlock(scope: !60, file: !1, line: 27, column: 5)
!65 = !DILocation(line: 27, column: 36, scope: !64)
!66 = !DILocation(line: 27, column: 5, scope: !60)
!67 = !DILocalVariable(name: "a", scope: !68, file: !1, line: 28, type: !12)
!68 = distinct !DILexicalBlock(scope: !64, file: !1, line: 27, column: 50)
!69 = !DILocation(line: 28, column: 13, scope: !68)
!70 = !DILocation(line: 28, column: 17, scope: !68)
!71 = !DILocation(line: 29, column: 5, scope: !68)
!72 = !DILocation(line: 27, column: 45, scope: !64)
!73 = !DILocation(line: 27, column: 5, scope: !64)
!74 = distinct !{!74, !66, !75}
!75 = !DILocation(line: 29, column: 5, scope: !60)
!76 = !DILocalVariable(name: "taint_me", scope: !9, file: !1, line: 31, type: !12)
!77 = !DILocation(line: 31, column: 9, scope: !9)
!78 = !DILocation(line: 31, column: 5, scope: !9)
!79 = !DILocalVariable(name: "ut1", scope: !9, file: !1, line: 35, type: !12)
!80 = !DILocation(line: 35, column: 9, scope: !9)
!81 = !DILocation(line: 37, column: 12, scope: !9)
!82 = !DILocation(line: 37, column: 5, scope: !9)
