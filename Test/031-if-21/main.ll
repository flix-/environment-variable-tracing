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
  %ut1 = alloca i32, align 4
  %ut2 = alloca i32, align 4
  %ut3 = alloca i32, align 4
  %ut4 = alloca i32, align 4
  %ut5 = alloca i32, align 4
  %taint = alloca i8*, align 8
  %t = alloca i32, align 4
  %a = alloca i32, align 4
  %a13 = alloca i32, align 4
  %t18 = alloca i32, align 4
  %a24 = alloca i32, align 4
  %a26 = alloca i32, align 4
  %a29 = alloca i32, align 4
  %nt = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !16, metadata !14), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %ut2, metadata !18, metadata !14), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %ut3, metadata !20, metadata !14), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %ut4, metadata !22, metadata !14), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %ut5, metadata !24, metadata !14), !dbg !25
  call void @llvm.dbg.declare(metadata i8** %taint, metadata !26, metadata !14), !dbg !29
  %0 = load i8*, i8** %taint, align 8, !dbg !30
  %arrayidx = getelementptr inbounds i8, i8* %0, i64 12, !dbg !30
  %1 = load i8, i8* %arrayidx, align 1, !dbg !30
  %conv = sext i8 %1 to i32, !dbg !30
  %cmp = icmp ne i32 %conv, 97, !dbg !32
  br i1 %cmp, label %if.then, label %if.end, !dbg !33

if.then:                                          ; preds = %entry
  store i32 -1, i32* %retval, align 4, !dbg !34
  br label %return, !dbg !34

if.end:                                           ; preds = %entry
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !35
  store i8* %call, i8** %taint, align 8, !dbg !37
  %cmp2 = icmp ne i8* %call, null, !dbg !38
  br i1 %cmp2, label %if.then4, label %if.else31, !dbg !39

if.then4:                                         ; preds = %if.end
  call void @llvm.dbg.declare(metadata i32* %t, metadata !40, metadata !14), !dbg !42
  %2 = load i8*, i8** %taint, align 8, !dbg !43
  %cmp5 = icmp ne i8* %2, null, !dbg !44
  %3 = zext i1 %cmp5 to i64, !dbg !43
  %cond = select i1 %cmp5, i32 0, i32 1, !dbg !43
  store i32 %cond, i32* %t, align 4, !dbg !42
  %4 = load i32, i32* %ut1, align 4, !dbg !45
  %tobool = icmp ne i32 %4, 0, !dbg !45
  br i1 %tobool, label %if.then7, label %if.else, !dbg !47

if.then7:                                         ; preds = %if.then4
  %5 = load i32, i32* %ut2, align 4, !dbg !48
  %tobool8 = icmp ne i32 %5, 0, !dbg !48
  br i1 %tobool8, label %if.then9, label %if.end10, !dbg !51

if.then9:                                         ; preds = %if.then7
  call void @llvm.dbg.declare(metadata i32* %a, metadata !52, metadata !14), !dbg !54
  store i32 0, i32* %a, align 4, !dbg !54
  br label %if.end10, !dbg !55

if.end10:                                         ; preds = %if.then9, %if.then7
  br label %if.end15, !dbg !56

if.else:                                          ; preds = %if.then4
  %6 = load i32, i32* %ut3, align 4, !dbg !57
  %tobool11 = icmp ne i32 %6, 0, !dbg !57
  br i1 %tobool11, label %if.then12, label %if.end14, !dbg !59

if.then12:                                        ; preds = %if.else
  call void @llvm.dbg.declare(metadata i32* %a13, metadata !60, metadata !14), !dbg !62
  store i32 0, i32* %a13, align 4, !dbg !62
  br label %if.end14, !dbg !63

if.end14:                                         ; preds = %if.then12, %if.else
  br label %if.end15

if.end15:                                         ; preds = %if.end14, %if.end10
  %7 = load i32, i32* %ut4, align 4, !dbg !64
  %tobool16 = icmp ne i32 %7, 0, !dbg !64
  br i1 %tobool16, label %if.then17, label %if.else28, !dbg !66

if.then17:                                        ; preds = %if.end15
  call void @llvm.dbg.declare(metadata i32* %t18, metadata !67, metadata !14), !dbg !69
  %8 = load i8*, i8** %taint, align 8, !dbg !70
  %cmp19 = icmp ne i8* %8, null, !dbg !71
  %9 = zext i1 %cmp19 to i64, !dbg !70
  %cond21 = select i1 %cmp19, i32 0, i32 1, !dbg !70
  store i32 %cond21, i32* %t18, align 4, !dbg !69
  %10 = load i32, i32* %ut5, align 4, !dbg !72
  %tobool22 = icmp ne i32 %10, 0, !dbg !72
  br i1 %tobool22, label %if.then23, label %if.else25, !dbg !74

if.then23:                                        ; preds = %if.then17
  call void @llvm.dbg.declare(metadata i32* %a24, metadata !75, metadata !14), !dbg !77
  store i32 0, i32* %a24, align 4, !dbg !77
  br label %if.end27, !dbg !78

if.else25:                                        ; preds = %if.then17
  call void @llvm.dbg.declare(metadata i32* %a26, metadata !79, metadata !14), !dbg !81
  store i32 0, i32* %a26, align 4, !dbg !81
  br label %if.end27

if.end27:                                         ; preds = %if.else25, %if.then23
  br label %if.end30, !dbg !82

if.else28:                                        ; preds = %if.end15
  call void @llvm.dbg.declare(metadata i32* %a29, metadata !83, metadata !14), !dbg !85
  store i32 0, i32* %a29, align 4, !dbg !85
  br label %if.end30

if.end30:                                         ; preds = %if.else28, %if.end27
  br label %if.end32, !dbg !86

if.else31:                                        ; preds = %if.end
  store i32 0, i32* %rc, align 4, !dbg !87
  br label %if.end32

if.end32:                                         ; preds = %if.else31, %if.end30
  call void @llvm.dbg.declare(metadata i32* %nt, metadata !89, metadata !14), !dbg !90
  store i32 1, i32* %nt, align 4, !dbg !90
  %11 = load i32, i32* %rc, align 4, !dbg !91
  store i32 %11, i32* %retval, align 4, !dbg !92
  br label %return, !dbg !92

return:                                           ; preds = %if.end32, %if.then
  %12 = load i32, i32* %retval, align 4, !dbg !93
  ret i32 %12, !dbg !93
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
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-21")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 7, type: !10, isLocal: false, isDefinition: true, scopeLine: 8, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "rc", scope: !9, file: !1, line: 9, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 9, column: 9, scope: !9)
!16 = !DILocalVariable(name: "ut1", scope: !9, file: !1, line: 10, type: !12)
!17 = !DILocation(line: 10, column: 9, scope: !9)
!18 = !DILocalVariable(name: "ut2", scope: !9, file: !1, line: 10, type: !12)
!19 = !DILocation(line: 10, column: 14, scope: !9)
!20 = !DILocalVariable(name: "ut3", scope: !9, file: !1, line: 10, type: !12)
!21 = !DILocation(line: 10, column: 19, scope: !9)
!22 = !DILocalVariable(name: "ut4", scope: !9, file: !1, line: 10, type: !12)
!23 = !DILocation(line: 10, column: 24, scope: !9)
!24 = !DILocalVariable(name: "ut5", scope: !9, file: !1, line: 10, type: !12)
!25 = !DILocation(line: 10, column: 29, scope: !9)
!26 = !DILocalVariable(name: "taint", scope: !9, file: !1, line: 11, type: !27)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!29 = !DILocation(line: 11, column: 11, scope: !9)
!30 = !DILocation(line: 13, column: 9, scope: !31)
!31 = distinct !DILexicalBlock(scope: !9, file: !1, line: 13, column: 9)
!32 = !DILocation(line: 13, column: 19, scope: !31)
!33 = !DILocation(line: 13, column: 9, scope: !9)
!34 = !DILocation(line: 13, column: 27, scope: !31)
!35 = !DILocation(line: 15, column: 18, scope: !36)
!36 = distinct !DILexicalBlock(scope: !9, file: !1, line: 15, column: 9)
!37 = !DILocation(line: 15, column: 16, scope: !36)
!38 = !DILocation(line: 15, column: 34, scope: !36)
!39 = !DILocation(line: 15, column: 9, scope: !9)
!40 = !DILocalVariable(name: "t", scope: !41, file: !1, line: 16, type: !12)
!41 = distinct !DILexicalBlock(scope: !36, file: !1, line: 15, column: 43)
!42 = !DILocation(line: 16, column: 13, scope: !41)
!43 = !DILocation(line: 16, column: 17, scope: !41)
!44 = !DILocation(line: 16, column: 23, scope: !41)
!45 = !DILocation(line: 18, column: 13, scope: !46)
!46 = distinct !DILexicalBlock(scope: !41, file: !1, line: 18, column: 13)
!47 = !DILocation(line: 18, column: 13, scope: !41)
!48 = !DILocation(line: 19, column: 17, scope: !49)
!49 = distinct !DILexicalBlock(scope: !50, file: !1, line: 19, column: 17)
!50 = distinct !DILexicalBlock(scope: !46, file: !1, line: 18, column: 18)
!51 = !DILocation(line: 19, column: 17, scope: !50)
!52 = !DILocalVariable(name: "a", scope: !53, file: !1, line: 20, type: !12)
!53 = distinct !DILexicalBlock(scope: !49, file: !1, line: 19, column: 22)
!54 = !DILocation(line: 20, column: 21, scope: !53)
!55 = !DILocation(line: 21, column: 13, scope: !53)
!56 = !DILocation(line: 22, column: 9, scope: !50)
!57 = !DILocation(line: 22, column: 20, scope: !58)
!58 = distinct !DILexicalBlock(scope: !46, file: !1, line: 22, column: 20)
!59 = !DILocation(line: 22, column: 20, scope: !46)
!60 = !DILocalVariable(name: "a", scope: !61, file: !1, line: 23, type: !12)
!61 = distinct !DILexicalBlock(scope: !58, file: !1, line: 22, column: 25)
!62 = !DILocation(line: 23, column: 17, scope: !61)
!63 = !DILocation(line: 24, column: 9, scope: !61)
!64 = !DILocation(line: 26, column: 13, scope: !65)
!65 = distinct !DILexicalBlock(scope: !41, file: !1, line: 26, column: 13)
!66 = !DILocation(line: 26, column: 13, scope: !41)
!67 = !DILocalVariable(name: "t", scope: !68, file: !1, line: 27, type: !12)
!68 = distinct !DILexicalBlock(scope: !65, file: !1, line: 26, column: 18)
!69 = !DILocation(line: 27, column: 17, scope: !68)
!70 = !DILocation(line: 27, column: 21, scope: !68)
!71 = !DILocation(line: 27, column: 27, scope: !68)
!72 = !DILocation(line: 29, column: 17, scope: !73)
!73 = distinct !DILexicalBlock(scope: !68, file: !1, line: 29, column: 17)
!74 = !DILocation(line: 29, column: 17, scope: !68)
!75 = !DILocalVariable(name: "a", scope: !76, file: !1, line: 30, type: !12)
!76 = distinct !DILexicalBlock(scope: !73, file: !1, line: 29, column: 22)
!77 = !DILocation(line: 30, column: 21, scope: !76)
!78 = !DILocation(line: 31, column: 13, scope: !76)
!79 = !DILocalVariable(name: "a", scope: !80, file: !1, line: 32, type: !12)
!80 = distinct !DILexicalBlock(scope: !73, file: !1, line: 31, column: 20)
!81 = !DILocation(line: 32, column: 21, scope: !80)
!82 = !DILocation(line: 34, column: 9, scope: !68)
!83 = !DILocalVariable(name: "a", scope: !84, file: !1, line: 35, type: !12)
!84 = distinct !DILexicalBlock(scope: !65, file: !1, line: 34, column: 16)
!85 = !DILocation(line: 35, column: 17, scope: !84)
!86 = !DILocation(line: 37, column: 5, scope: !41)
!87 = !DILocation(line: 38, column: 12, scope: !88)
!88 = distinct !DILexicalBlock(scope: !36, file: !1, line: 37, column: 12)
!89 = !DILocalVariable(name: "nt", scope: !9, file: !1, line: 41, type: !12)
!90 = !DILocation(line: 41, column: 9, scope: !9)
!91 = !DILocation(line: 43, column: 12, scope: !9)
!92 = !DILocation(line: 43, column: 5, scope: !9)
!93 = !DILocation(line: 44, column: 1, scope: !9)
