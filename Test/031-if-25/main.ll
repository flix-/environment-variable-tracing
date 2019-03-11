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
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %a12 = alloca i32, align 4
  %b13 = alloca i32, align 4
  %d21 = alloca i32, align 4
  %end1 = alloca i32, align 4
  %end2 = alloca i32, align 4
  %ut = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata i32* %b, metadata !14, metadata !12), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %c, metadata !16, metadata !12), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %d, metadata !18, metadata !12), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %e, metadata !20, metadata !12), !dbg !21
  %0 = load i32, i32* %a, align 4, !dbg !22
  %tobool = icmp ne i32 %0, 0, !dbg !22
  br i1 %tobool, label %if.then, label %if.end27, !dbg !24

if.then:                                          ; preds = %entry
  br label %do.body, !dbg !25, !llvm.loop !27

do.body:                                          ; preds = %do.cond, %if.then
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !29
  %tobool1 = icmp ne i8* %call, null, !dbg !29
  br i1 %tobool1, label %land.lhs.true, label %lor.lhs.false, !dbg !32

land.lhs.true:                                    ; preds = %do.body
  %1 = load i32, i32* %a, align 4, !dbg !33
  %tobool2 = icmp ne i32 %1, 0, !dbg !33
  br i1 %tobool2, label %land.lhs.true3, label %lor.lhs.false, !dbg !34

land.lhs.true3:                                   ; preds = %land.lhs.true
  %2 = load i32, i32* %b, align 4, !dbg !35
  %tobool4 = icmp ne i32 %2, 0, !dbg !35
  br i1 %tobool4, label %land.lhs.true5, label %lor.lhs.false, !dbg !36

land.lhs.true5:                                   ; preds = %land.lhs.true3
  %3 = load i32, i32* %c, align 4, !dbg !37
  %tobool6 = icmp ne i32 %3, 0, !dbg !37
  br i1 %tobool6, label %if.then8, label %lor.lhs.false, !dbg !38

lor.lhs.false:                                    ; preds = %land.lhs.true5, %land.lhs.true3, %land.lhs.true, %do.body
  %4 = load i32, i32* %e, align 4, !dbg !39
  %tobool7 = icmp ne i32 %4, 0, !dbg !39
  br i1 %tobool7, label %if.then8, label %if.else14, !dbg !40

if.then8:                                         ; preds = %lor.lhs.false, %land.lhs.true5
  %5 = load i32, i32* %a, align 4, !dbg !41
  %tobool9 = icmp ne i32 %5, 0, !dbg !41
  br i1 %tobool9, label %if.then10, label %if.else, !dbg !44

if.then10:                                        ; preds = %if.then8
  br label %do.body11, !dbg !45, !llvm.loop !47

do.body11:                                        ; preds = %if.then10
  call void @llvm.dbg.declare(metadata i32* %a12, metadata !49, metadata !12), !dbg !51
  store i32 0, i32* %a12, align 4, !dbg !51
  br label %do.end, !dbg !52

do.end:                                           ; preds = %do.body11
  br label %if.end, !dbg !53

if.else:                                          ; preds = %if.then8
  call void @llvm.dbg.declare(metadata i32* %b13, metadata !54, metadata !12), !dbg !56
  store i32 1, i32* %b13, align 4, !dbg !56
  br label %if.end

if.end:                                           ; preds = %if.else, %do.end
  br label %if.end23, !dbg !57

if.else14:                                        ; preds = %lor.lhs.false
  %6 = load i32, i32* %a, align 4, !dbg !58
  %tobool15 = icmp ne i32 %6, 0, !dbg !58
  br i1 %tobool15, label %if.then20, label %lor.lhs.false16, !dbg !60

lor.lhs.false16:                                  ; preds = %if.else14
  %7 = load i32, i32* %b, align 4, !dbg !61
  %tobool17 = icmp ne i32 %7, 0, !dbg !61
  br i1 %tobool17, label %if.then20, label %lor.lhs.false18, !dbg !62

lor.lhs.false18:                                  ; preds = %lor.lhs.false16
  %8 = load i32, i32* %c, align 4, !dbg !63
  %tobool19 = icmp ne i32 %8, 0, !dbg !63
  br i1 %tobool19, label %if.then20, label %if.end22, !dbg !64

if.then20:                                        ; preds = %lor.lhs.false18, %lor.lhs.false16, %if.else14
  call void @llvm.dbg.declare(metadata i32* %d21, metadata !65, metadata !12), !dbg !67
  %9 = load i32, i32* %a, align 4, !dbg !68
  store i32 %9, i32* %d21, align 4, !dbg !67
  br label %if.end22, !dbg !69

if.end22:                                         ; preds = %if.then20, %lor.lhs.false18
  br label %if.end23

if.end23:                                         ; preds = %if.end22, %if.end
  call void @llvm.dbg.declare(metadata i32* %end1, metadata !70, metadata !12), !dbg !71
  store i32 1, i32* %end1, align 4, !dbg !71
  br label %do.cond, !dbg !72

do.cond:                                          ; preds = %if.end23
  %call24 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !73
  %tobool25 = icmp ne i8* %call24, null, !dbg !72
  br i1 %tobool25, label %do.body, label %do.end26, !dbg !72, !llvm.loop !27

do.end26:                                         ; preds = %do.cond
  call void @llvm.dbg.declare(metadata i32* %end2, metadata !74, metadata !12), !dbg !75
  store i32 2, i32* %end2, align 4, !dbg !75
  br label %if.end27, !dbg !76

if.end27:                                         ; preds = %do.end26, %entry
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !77, metadata !12), !dbg !78
  store i32 0, i32* %ut, align 4, !dbg !78
  ret i32 0, !dbg !79
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-25")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 4, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 6, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 6, column: 9, scope: !7)
!14 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 6, type: !10)
!15 = !DILocation(line: 6, column: 11, scope: !7)
!16 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 6, type: !10)
!17 = !DILocation(line: 6, column: 13, scope: !7)
!18 = !DILocalVariable(name: "d", scope: !7, file: !1, line: 6, type: !10)
!19 = !DILocation(line: 6, column: 15, scope: !7)
!20 = !DILocalVariable(name: "e", scope: !7, file: !1, line: 6, type: !10)
!21 = !DILocation(line: 6, column: 17, scope: !7)
!22 = !DILocation(line: 8, column: 9, scope: !23)
!23 = distinct !DILexicalBlock(scope: !7, file: !1, line: 8, column: 9)
!24 = !DILocation(line: 8, column: 9, scope: !7)
!25 = !DILocation(line: 9, column: 9, scope: !26)
!26 = distinct !DILexicalBlock(scope: !23, file: !1, line: 8, column: 12)
!27 = distinct !{!27, !25, !28}
!28 = !DILocation(line: 22, column: 32, scope: !26)
!29 = !DILocation(line: 10, column: 18, scope: !30)
!30 = distinct !DILexicalBlock(scope: !31, file: !1, line: 10, column: 17)
!31 = distinct !DILexicalBlock(scope: !26, file: !1, line: 9, column: 12)
!32 = !DILocation(line: 10, column: 33, scope: !30)
!33 = !DILocation(line: 10, column: 36, scope: !30)
!34 = !DILocation(line: 10, column: 38, scope: !30)
!35 = !DILocation(line: 10, column: 41, scope: !30)
!36 = !DILocation(line: 10, column: 43, scope: !30)
!37 = !DILocation(line: 10, column: 46, scope: !30)
!38 = !DILocation(line: 10, column: 49, scope: !30)
!39 = !DILocation(line: 10, column: 52, scope: !30)
!40 = !DILocation(line: 10, column: 17, scope: !31)
!41 = !DILocation(line: 11, column: 21, scope: !42)
!42 = distinct !DILexicalBlock(scope: !43, file: !1, line: 11, column: 21)
!43 = distinct !DILexicalBlock(scope: !30, file: !1, line: 10, column: 55)
!44 = !DILocation(line: 11, column: 21, scope: !43)
!45 = !DILocation(line: 12, column: 21, scope: !46)
!46 = distinct !DILexicalBlock(scope: !42, file: !1, line: 11, column: 24)
!47 = distinct !{!47, !45, !48}
!48 = !DILocation(line: 14, column: 31, scope: !46)
!49 = !DILocalVariable(name: "a", scope: !50, file: !1, line: 13, type: !10)
!50 = distinct !DILexicalBlock(scope: !46, file: !1, line: 12, column: 24)
!51 = !DILocation(line: 13, column: 29, scope: !50)
!52 = !DILocation(line: 14, column: 21, scope: !50)
!53 = !DILocation(line: 15, column: 17, scope: !46)
!54 = !DILocalVariable(name: "b", scope: !55, file: !1, line: 16, type: !10)
!55 = distinct !DILexicalBlock(scope: !42, file: !1, line: 15, column: 24)
!56 = !DILocation(line: 16, column: 25, scope: !55)
!57 = !DILocation(line: 18, column: 13, scope: !43)
!58 = !DILocation(line: 18, column: 24, scope: !59)
!59 = distinct !DILexicalBlock(scope: !30, file: !1, line: 18, column: 24)
!60 = !DILocation(line: 18, column: 26, scope: !59)
!61 = !DILocation(line: 18, column: 29, scope: !59)
!62 = !DILocation(line: 18, column: 31, scope: !59)
!63 = !DILocation(line: 18, column: 34, scope: !59)
!64 = !DILocation(line: 18, column: 24, scope: !30)
!65 = !DILocalVariable(name: "d", scope: !66, file: !1, line: 19, type: !10)
!66 = distinct !DILexicalBlock(scope: !59, file: !1, line: 18, column: 37)
!67 = !DILocation(line: 19, column: 21, scope: !66)
!68 = !DILocation(line: 19, column: 25, scope: !66)
!69 = !DILocation(line: 20, column: 13, scope: !66)
!70 = !DILocalVariable(name: "end1", scope: !31, file: !1, line: 21, type: !10)
!71 = !DILocation(line: 21, column: 17, scope: !31)
!72 = !DILocation(line: 22, column: 9, scope: !31)
!73 = !DILocation(line: 22, column: 18, scope: !26)
!74 = !DILocalVariable(name: "end2", scope: !26, file: !1, line: 23, type: !10)
!75 = !DILocation(line: 23, column: 13, scope: !26)
!76 = !DILocation(line: 24, column: 5, scope: !26)
!77 = !DILocalVariable(name: "ut", scope: !7, file: !1, line: 26, type: !10)
!78 = !DILocation(line: 26, column: 9, scope: !7)
!79 = !DILocation(line: 28, column: 5, scope: !7)
