; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %rc = alloca i32, align 4
  %i = alloca i32, align 4
  %a18 = alloca i32, align 4
  %b19 = alloca i32, align 4
  %d27 = alloca i32, align 4
  %end1 = alloca i32, align 4
  %end2 = alloca i32, align 4
  %ut1 = alloca i32, align 4
  %j = alloca i32, align 4
  %taint_me = alloca i32, align 4
  %ut4 = alloca i32, align 4
  %t = alloca i32, align 4
  %ut6 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %b, metadata !16, metadata !14), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %c, metadata !18, metadata !14), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %d, metadata !20, metadata !14), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %e, metadata !22, metadata !14), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !24, metadata !14), !dbg !25
  %0 = load i32, i32* %a, align 4, !dbg !26
  %tobool = icmp ne i32 %0, 0, !dbg !26
  br i1 %tobool, label %if.then, label %if.else51, !dbg !28

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %i, metadata !29, metadata !14), !dbg !32
  store i32 0, i32* %i, align 4, !dbg !32
  br label %for.cond, !dbg !33

for.cond:                                         ; preds = %for.inc, %if.then
  %1 = load i32, i32* %i, align 4, !dbg !34
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !36
  %cmp = icmp eq i8* %call, null, !dbg !37
  %conv = zext i1 %cmp to i32, !dbg !37
  %cmp1 = icmp slt i32 %1, %conv, !dbg !38
  br i1 %cmp1, label %for.body, label %for.end, !dbg !39

for.body:                                         ; preds = %for.cond
  br label %do.body, !dbg !40, !llvm.loop !42

do.body:                                          ; preds = %do.cond, %for.body
  br label %while.cond, !dbg !44

while.cond:                                       ; preds = %if.end29, %do.body
  %call3 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !46
  %cmp4 = icmp ne i8* %call3, null, !dbg !47
  br i1 %cmp4, label %while.body, label %while.end, !dbg !44

while.body:                                       ; preds = %while.cond
  %call6 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !48
  %tobool7 = icmp ne i8* %call6, null, !dbg !48
  br i1 %tobool7, label %land.lhs.true, label %lor.lhs.false, !dbg !51

land.lhs.true:                                    ; preds = %while.body
  %2 = load i32, i32* %a, align 4, !dbg !52
  %tobool8 = icmp ne i32 %2, 0, !dbg !52
  br i1 %tobool8, label %land.lhs.true9, label %lor.lhs.false, !dbg !53

land.lhs.true9:                                   ; preds = %land.lhs.true
  %3 = load i32, i32* %b, align 4, !dbg !54
  %tobool10 = icmp ne i32 %3, 0, !dbg !54
  br i1 %tobool10, label %land.lhs.true11, label %lor.lhs.false, !dbg !55

land.lhs.true11:                                  ; preds = %land.lhs.true9
  %4 = load i32, i32* %c, align 4, !dbg !56
  %tobool12 = icmp ne i32 %4, 0, !dbg !56
  br i1 %tobool12, label %if.then14, label %lor.lhs.false, !dbg !57

lor.lhs.false:                                    ; preds = %land.lhs.true11, %land.lhs.true9, %land.lhs.true, %while.body
  %5 = load i32, i32* %e, align 4, !dbg !58
  %tobool13 = icmp ne i32 %5, 0, !dbg !58
  br i1 %tobool13, label %if.then14, label %if.else20, !dbg !59

if.then14:                                        ; preds = %lor.lhs.false, %land.lhs.true11
  %6 = load i32, i32* %a, align 4, !dbg !60
  %tobool15 = icmp ne i32 %6, 0, !dbg !60
  br i1 %tobool15, label %if.then16, label %if.else, !dbg !63

if.then16:                                        ; preds = %if.then14
  br label %do.body17, !dbg !64, !llvm.loop !66

do.body17:                                        ; preds = %if.then16
  call void @llvm.dbg.declare(metadata i32* %a18, metadata !68, metadata !14), !dbg !70
  store i32 0, i32* %a18, align 4, !dbg !70
  br label %do.end, !dbg !71

do.end:                                           ; preds = %do.body17
  br label %if.end, !dbg !72

if.else:                                          ; preds = %if.then14
  call void @llvm.dbg.declare(metadata i32* %b19, metadata !73, metadata !14), !dbg !75
  store i32 1, i32* %b19, align 4, !dbg !75
  br label %if.end

if.end:                                           ; preds = %if.else, %do.end
  br label %if.end29, !dbg !76

if.else20:                                        ; preds = %lor.lhs.false
  %7 = load i32, i32* %a, align 4, !dbg !77
  %tobool21 = icmp ne i32 %7, 0, !dbg !77
  br i1 %tobool21, label %if.then26, label %lor.lhs.false22, !dbg !79

lor.lhs.false22:                                  ; preds = %if.else20
  %8 = load i32, i32* %b, align 4, !dbg !80
  %tobool23 = icmp ne i32 %8, 0, !dbg !80
  br i1 %tobool23, label %if.then26, label %lor.lhs.false24, !dbg !81

lor.lhs.false24:                                  ; preds = %lor.lhs.false22
  %9 = load i32, i32* %c, align 4, !dbg !82
  %tobool25 = icmp ne i32 %9, 0, !dbg !82
  br i1 %tobool25, label %if.then26, label %if.end28, !dbg !83

if.then26:                                        ; preds = %lor.lhs.false24, %lor.lhs.false22, %if.else20
  call void @llvm.dbg.declare(metadata i32* %d27, metadata !84, metadata !14), !dbg !86
  %10 = load i32, i32* %a, align 4, !dbg !87
  store i32 %10, i32* %d27, align 4, !dbg !86
  store i32 -1, i32* %retval, align 4, !dbg !88
  br label %return, !dbg !88

if.end28:                                         ; preds = %lor.lhs.false24
  br label %if.end29

if.end29:                                         ; preds = %if.end28, %if.end
  store i32 4711, i32* %rc, align 4, !dbg !89
  br label %while.cond, !dbg !44, !llvm.loop !90

while.end:                                        ; preds = %while.cond
  call void @llvm.dbg.declare(metadata i32* %end1, metadata !92, metadata !14), !dbg !93
  store i32 1, i32* %end1, align 4, !dbg !93
  br label %do.cond, !dbg !94

do.cond:                                          ; preds = %while.end
  %call30 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !95
  %tobool31 = icmp ne i8* %call30, null, !dbg !94
  br i1 %tobool31, label %do.body, label %do.end32, !dbg !94, !llvm.loop !42

do.end32:                                         ; preds = %do.cond
  call void @llvm.dbg.declare(metadata i32* %end2, metadata !96, metadata !14), !dbg !97
  store i32 1, i32* %end2, align 4, !dbg !97
  br label %for.inc, !dbg !98

for.inc:                                          ; preds = %do.end32
  %11 = load i32, i32* %i, align 4, !dbg !99
  %inc = add nsw i32 %11, 1, !dbg !99
  store i32 %inc, i32* %i, align 4, !dbg !99
  br label %for.cond, !dbg !100, !llvm.loop !101

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !103, metadata !14), !dbg !104
  store i32 1, i32* %ut1, align 4, !dbg !104
  call void @llvm.dbg.declare(metadata i32* %j, metadata !105, metadata !14), !dbg !107
  store i32 0, i32* %j, align 4, !dbg !107
  br label %for.cond33, !dbg !108

for.cond33:                                       ; preds = %for.inc48, %for.end
  %12 = load i32, i32* %j, align 4, !dbg !109
  %cmp34 = icmp slt i32 %12, 42, !dbg !111
  br i1 %cmp34, label %for.body36, label %for.end50, !dbg !112

for.body36:                                       ; preds = %for.cond33
  br label %while.cond37, !dbg !113

while.cond37:                                     ; preds = %while.body46, %for.body36
  %13 = load i32, i32* %a, align 4, !dbg !115
  %tobool38 = icmp ne i32 %13, 0, !dbg !115
  br i1 %tobool38, label %land.rhs, label %lor.lhs.false39, !dbg !116

lor.lhs.false39:                                  ; preds = %while.cond37
  %14 = load i32, i32* %b, align 4, !dbg !117
  %tobool40 = icmp ne i32 %14, 0, !dbg !117
  br i1 %tobool40, label %land.rhs, label %lor.lhs.false41, !dbg !118

lor.lhs.false41:                                  ; preds = %lor.lhs.false39
  %15 = load i32, i32* %c, align 4, !dbg !119
  %tobool42 = icmp ne i32 %15, 0, !dbg !119
  br i1 %tobool42, label %land.rhs, label %land.end, !dbg !120

land.rhs:                                         ; preds = %lor.lhs.false41, %lor.lhs.false39, %while.cond37
  %16 = load i32, i32* %e, align 4, !dbg !121
  %call43 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !122
  %17 = ptrtoint i8* %call43 to i32, !dbg !123
  %cmp44 = icmp ne i32 %16, %17, !dbg !124
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.lhs.false41
  %18 = phi i1 [ false, %lor.lhs.false41 ], [ %cmp44, %land.rhs ]
  br i1 %18, label %while.body46, label %while.end47, !dbg !113

while.body46:                                     ; preds = %land.end
  call void @llvm.dbg.declare(metadata i32* %taint_me, metadata !125, metadata !14), !dbg !127
  store i32 1, i32* %taint_me, align 4, !dbg !127
  br label %while.cond37, !dbg !113, !llvm.loop !128

while.end47:                                      ; preds = %land.end
  call void @llvm.dbg.declare(metadata i32* %ut4, metadata !130, metadata !14), !dbg !131
  store i32 1, i32* %ut4, align 4, !dbg !131
  br label %for.inc48, !dbg !132

for.inc48:                                        ; preds = %while.end47
  %19 = load i32, i32* %j, align 4, !dbg !133
  %inc49 = add nsw i32 %19, 1, !dbg !133
  store i32 %inc49, i32* %j, align 4, !dbg !133
  br label %for.cond33, !dbg !134, !llvm.loop !135

for.end50:                                        ; preds = %for.cond33
  br label %if.end57, !dbg !137

if.else51:                                        ; preds = %entry
  %call52 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !138
  %cmp53 = icmp ne i8* %call52, null, !dbg !140
  br i1 %cmp53, label %if.then55, label %if.end56, !dbg !141

if.then55:                                        ; preds = %if.else51
  call void @llvm.dbg.declare(metadata i32* %t, metadata !142, metadata !14), !dbg !144
  store i32 1, i32* %t, align 4, !dbg !144
  br label %if.end56, !dbg !145

if.end56:                                         ; preds = %if.then55, %if.else51
  br label %if.end57

if.end57:                                         ; preds = %if.end56, %for.end50
  call void @llvm.dbg.declare(metadata i32* %ut6, metadata !146, metadata !14), !dbg !147
  store i32 1, i32* %ut6, align 4, !dbg !147
  %20 = load i32, i32* %rc, align 4, !dbg !148
  store i32 %20, i32* %retval, align 4, !dbg !149
  br label %return, !dbg !149

return:                                           ; preds = %if.end57, %if.then26
  %21 = load i32, i32* %retval, align 4, !dbg !150
  ret i32 %21, !dbg !150
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-26")
!2 = !{}
!3 = !{!4, !5}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{i32 2, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !11, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!5}
!13 = !DILocalVariable(name: "a", scope: !10, file: !1, line: 8, type: !5)
!14 = !DIExpression()
!15 = !DILocation(line: 8, column: 9, scope: !10)
!16 = !DILocalVariable(name: "b", scope: !10, file: !1, line: 8, type: !5)
!17 = !DILocation(line: 8, column: 11, scope: !10)
!18 = !DILocalVariable(name: "c", scope: !10, file: !1, line: 8, type: !5)
!19 = !DILocation(line: 8, column: 13, scope: !10)
!20 = !DILocalVariable(name: "d", scope: !10, file: !1, line: 8, type: !5)
!21 = !DILocation(line: 8, column: 15, scope: !10)
!22 = !DILocalVariable(name: "e", scope: !10, file: !1, line: 8, type: !5)
!23 = !DILocation(line: 8, column: 17, scope: !10)
!24 = !DILocalVariable(name: "rc", scope: !10, file: !1, line: 10, type: !5)
!25 = !DILocation(line: 10, column: 9, scope: !10)
!26 = !DILocation(line: 11, column: 9, scope: !27)
!27 = distinct !DILexicalBlock(scope: !10, file: !1, line: 11, column: 9)
!28 = !DILocation(line: 11, column: 9, scope: !10)
!29 = !DILocalVariable(name: "i", scope: !30, file: !1, line: 12, type: !5)
!30 = distinct !DILexicalBlock(scope: !31, file: !1, line: 12, column: 9)
!31 = distinct !DILexicalBlock(scope: !27, file: !1, line: 11, column: 12)
!32 = !DILocation(line: 12, column: 18, scope: !30)
!33 = !DILocation(line: 12, column: 14, scope: !30)
!34 = !DILocation(line: 12, column: 25, scope: !35)
!35 = distinct !DILexicalBlock(scope: !30, file: !1, line: 12, column: 9)
!36 = !DILocation(line: 12, column: 30, scope: !35)
!37 = !DILocation(line: 12, column: 45, scope: !35)
!38 = !DILocation(line: 12, column: 27, scope: !35)
!39 = !DILocation(line: 12, column: 9, scope: !30)
!40 = !DILocation(line: 13, column: 13, scope: !41)
!41 = distinct !DILexicalBlock(scope: !35, file: !1, line: 12, column: 60)
!42 = distinct !{!42, !40, !43}
!43 = !DILocation(line: 30, column: 36, scope: !41)
!44 = !DILocation(line: 14, column: 17, scope: !45)
!45 = distinct !DILexicalBlock(scope: !41, file: !1, line: 13, column: 16)
!46 = !DILocation(line: 14, column: 24, scope: !45)
!47 = !DILocation(line: 14, column: 39, scope: !45)
!48 = !DILocation(line: 15, column: 26, scope: !49)
!49 = distinct !DILexicalBlock(scope: !50, file: !1, line: 15, column: 25)
!50 = distinct !DILexicalBlock(scope: !45, file: !1, line: 14, column: 48)
!51 = !DILocation(line: 15, column: 41, scope: !49)
!52 = !DILocation(line: 15, column: 44, scope: !49)
!53 = !DILocation(line: 15, column: 46, scope: !49)
!54 = !DILocation(line: 15, column: 49, scope: !49)
!55 = !DILocation(line: 15, column: 51, scope: !49)
!56 = !DILocation(line: 15, column: 54, scope: !49)
!57 = !DILocation(line: 15, column: 57, scope: !49)
!58 = !DILocation(line: 15, column: 60, scope: !49)
!59 = !DILocation(line: 15, column: 25, scope: !50)
!60 = !DILocation(line: 16, column: 29, scope: !61)
!61 = distinct !DILexicalBlock(scope: !62, file: !1, line: 16, column: 29)
!62 = distinct !DILexicalBlock(scope: !49, file: !1, line: 15, column: 63)
!63 = !DILocation(line: 16, column: 29, scope: !62)
!64 = !DILocation(line: 17, column: 29, scope: !65)
!65 = distinct !DILexicalBlock(scope: !61, file: !1, line: 16, column: 32)
!66 = distinct !{!66, !64, !67}
!67 = !DILocation(line: 19, column: 39, scope: !65)
!68 = !DILocalVariable(name: "a", scope: !69, file: !1, line: 18, type: !5)
!69 = distinct !DILexicalBlock(scope: !65, file: !1, line: 17, column: 32)
!70 = !DILocation(line: 18, column: 37, scope: !69)
!71 = !DILocation(line: 19, column: 29, scope: !69)
!72 = !DILocation(line: 20, column: 25, scope: !65)
!73 = !DILocalVariable(name: "b", scope: !74, file: !1, line: 21, type: !5)
!74 = distinct !DILexicalBlock(scope: !61, file: !1, line: 20, column: 32)
!75 = !DILocation(line: 21, column: 33, scope: !74)
!76 = !DILocation(line: 23, column: 21, scope: !62)
!77 = !DILocation(line: 23, column: 32, scope: !78)
!78 = distinct !DILexicalBlock(scope: !49, file: !1, line: 23, column: 32)
!79 = !DILocation(line: 23, column: 34, scope: !78)
!80 = !DILocation(line: 23, column: 37, scope: !78)
!81 = !DILocation(line: 23, column: 39, scope: !78)
!82 = !DILocation(line: 23, column: 42, scope: !78)
!83 = !DILocation(line: 23, column: 32, scope: !49)
!84 = !DILocalVariable(name: "d", scope: !85, file: !1, line: 24, type: !5)
!85 = distinct !DILexicalBlock(scope: !78, file: !1, line: 23, column: 45)
!86 = !DILocation(line: 24, column: 29, scope: !85)
!87 = !DILocation(line: 24, column: 33, scope: !85)
!88 = !DILocation(line: 25, column: 25, scope: !85)
!89 = !DILocation(line: 27, column: 24, scope: !50)
!90 = distinct !{!90, !44, !91}
!91 = !DILocation(line: 28, column: 17, scope: !45)
!92 = !DILocalVariable(name: "end1", scope: !45, file: !1, line: 29, type: !5)
!93 = !DILocation(line: 29, column: 21, scope: !45)
!94 = !DILocation(line: 30, column: 13, scope: !45)
!95 = !DILocation(line: 30, column: 22, scope: !41)
!96 = !DILocalVariable(name: "end2", scope: !41, file: !1, line: 31, type: !5)
!97 = !DILocation(line: 31, column: 17, scope: !41)
!98 = !DILocation(line: 32, column: 9, scope: !41)
!99 = !DILocation(line: 12, column: 55, scope: !35)
!100 = !DILocation(line: 12, column: 9, scope: !35)
!101 = distinct !{!101, !39, !102}
!102 = !DILocation(line: 32, column: 9, scope: !30)
!103 = !DILocalVariable(name: "ut1", scope: !31, file: !1, line: 33, type: !5)
!104 = !DILocation(line: 33, column: 13, scope: !31)
!105 = !DILocalVariable(name: "j", scope: !106, file: !1, line: 35, type: !5)
!106 = distinct !DILexicalBlock(scope: !31, file: !1, line: 35, column: 9)
!107 = !DILocation(line: 35, column: 18, scope: !106)
!108 = !DILocation(line: 35, column: 14, scope: !106)
!109 = !DILocation(line: 35, column: 25, scope: !110)
!110 = distinct !DILexicalBlock(scope: !106, file: !1, line: 35, column: 9)
!111 = !DILocation(line: 35, column: 27, scope: !110)
!112 = !DILocation(line: 35, column: 9, scope: !106)
!113 = !DILocation(line: 36, column: 13, scope: !114)
!114 = distinct !DILexicalBlock(scope: !110, file: !1, line: 35, column: 38)
!115 = !DILocation(line: 36, column: 21, scope: !114)
!116 = !DILocation(line: 36, column: 23, scope: !114)
!117 = !DILocation(line: 36, column: 26, scope: !114)
!118 = !DILocation(line: 36, column: 28, scope: !114)
!119 = !DILocation(line: 36, column: 31, scope: !114)
!120 = !DILocation(line: 36, column: 34, scope: !114)
!121 = !DILocation(line: 36, column: 37, scope: !114)
!122 = !DILocation(line: 36, column: 47, scope: !114)
!123 = !DILocation(line: 36, column: 42, scope: !114)
!124 = !DILocation(line: 36, column: 39, scope: !114)
!125 = !DILocalVariable(name: "taint_me", scope: !126, file: !1, line: 37, type: !5)
!126 = distinct !DILexicalBlock(scope: !114, file: !1, line: 36, column: 63)
!127 = !DILocation(line: 37, column: 21, scope: !126)
!128 = distinct !{!128, !113, !129}
!129 = !DILocation(line: 38, column: 13, scope: !114)
!130 = !DILocalVariable(name: "ut4", scope: !114, file: !1, line: 39, type: !5)
!131 = !DILocation(line: 39, column: 17, scope: !114)
!132 = !DILocation(line: 40, column: 9, scope: !114)
!133 = !DILocation(line: 35, column: 33, scope: !110)
!134 = !DILocation(line: 35, column: 9, scope: !110)
!135 = distinct !{!135, !112, !136}
!136 = !DILocation(line: 40, column: 9, scope: !106)
!137 = !DILocation(line: 41, column: 5, scope: !31)
!138 = !DILocation(line: 41, column: 16, scope: !139)
!139 = distinct !DILexicalBlock(scope: !27, file: !1, line: 41, column: 16)
!140 = !DILocation(line: 41, column: 31, scope: !139)
!141 = !DILocation(line: 41, column: 16, scope: !27)
!142 = !DILocalVariable(name: "t", scope: !143, file: !1, line: 42, type: !5)
!143 = distinct !DILexicalBlock(scope: !139, file: !1, line: 41, column: 40)
!144 = !DILocation(line: 42, column: 13, scope: !143)
!145 = !DILocation(line: 43, column: 5, scope: !143)
!146 = !DILocalVariable(name: "ut6", scope: !10, file: !1, line: 45, type: !5)
!147 = !DILocation(line: 45, column: 9, scope: !10)
!148 = !DILocation(line: 47, column: 12, scope: !10)
!149 = !DILocation(line: 47, column: 5, scope: !10)
!150 = !DILocation(line: 48, column: 1, scope: !10)
