; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  %a = alloca i32, align 4
  %a5 = alloca i32, align 4
  %eob = alloca i32, align 4
  %eob8 = alloca i32, align 4
  %t1 = alloca i8*, align 8
  %ut = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !13, metadata !16), !dbg !17
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !18
  store i8* %call, i8** %tainted, align 8, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !19, metadata !16), !dbg !20
  %0 = load i32, i32* %rc, align 4, !dbg !21
  %cmp = icmp ne i32 %0, 0, !dbg !23
  br i1 %cmp, label %if.then, label %if.else9, !dbg !24

if.then:                                          ; preds = %entry
  %1 = load i8*, i8** %tainted, align 8, !dbg !25
  %cmp1 = icmp ne i8* %1, null, !dbg !28
  br i1 %cmp1, label %if.then2, label %if.else6, !dbg !29

if.then2:                                         ; preds = %if.then
  %2 = load i8*, i8** %tainted, align 8, !dbg !30
  %cmp3 = icmp ne i8* %2, null, !dbg !33
  br i1 %cmp3, label %if.then4, label %if.else, !dbg !34

if.then4:                                         ; preds = %if.then2
  br label %do.body, !dbg !35, !llvm.loop !37

do.body:                                          ; preds = %if.then4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !39, metadata !16), !dbg !41
  store i32 0, i32* %a, align 4, !dbg !41
  br label %do.end, !dbg !42

do.end:                                           ; preds = %do.body
  store i32 -1, i32* %retval, align 4, !dbg !43
  br label %return, !dbg !43

if.else:                                          ; preds = %if.then2
  call void @llvm.dbg.declare(metadata i32* %a5, metadata !44, metadata !16), !dbg !46
  store i32 1, i32* %a5, align 4, !dbg !46
  br label %if.end

if.end:                                           ; preds = %if.else
  call void @llvm.dbg.declare(metadata i32* %eob, metadata !47, metadata !16), !dbg !48
  store i32 1, i32* %eob, align 4, !dbg !48
  store i32 -1, i32* %retval, align 4, !dbg !49
  br label %return, !dbg !49

if.else6:                                         ; preds = %if.then
  store i32 1, i32* %rc, align 4, !dbg !50
  br label %if.end7

if.end7:                                          ; preds = %if.else6
  call void @llvm.dbg.declare(metadata i32* %eob8, metadata !52, metadata !16), !dbg !53
  store i32 2, i32* %eob8, align 4, !dbg !53
  br label %if.end13, !dbg !54

if.else9:                                         ; preds = %entry
  %3 = load i32, i32* %rc, align 4, !dbg !55
  %cmp10 = icmp eq i32 %3, 1, !dbg !58
  br i1 %cmp10, label %if.then11, label %if.end12, !dbg !59

if.then11:                                        ; preds = %if.else9
  store i32 -1, i32* %retval, align 4, !dbg !60
  br label %return, !dbg !60

if.end12:                                         ; preds = %if.else9
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !62, metadata !16), !dbg !63
  %4 = load i8*, i8** %tainted, align 8, !dbg !64
  store i8* %4, i8** %t1, align 8, !dbg !63
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.end7
  call void @llvm.dbg.declare(metadata i8** %ut, metadata !65, metadata !16), !dbg !66
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0), i8** %ut, align 8, !dbg !66
  %5 = load i32, i32* %rc, align 4, !dbg !67
  store i32 %5, i32* %retval, align 4, !dbg !68
  br label %return, !dbg !68

return:                                           ; preds = %if.end13, %if.then11, %if.end, %do.end
  %6 = load i32, i32* %retval, align 4, !dbg !69
  ret i32 %6, !dbg !69
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-19")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 5, type: !10, isLocal: false, isDefinition: true, scopeLine: 5, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "tainted", scope: !9, file: !1, line: 6, type: !14)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DIExpression()
!17 = !DILocation(line: 6, column: 11, scope: !9)
!18 = !DILocation(line: 6, column: 21, scope: !9)
!19 = !DILocalVariable(name: "rc", scope: !9, file: !1, line: 8, type: !12)
!20 = !DILocation(line: 8, column: 9, scope: !9)
!21 = !DILocation(line: 9, column: 9, scope: !22)
!22 = distinct !DILexicalBlock(scope: !9, file: !1, line: 9, column: 9)
!23 = !DILocation(line: 9, column: 12, scope: !22)
!24 = !DILocation(line: 9, column: 9, scope: !9)
!25 = !DILocation(line: 10, column: 13, scope: !26)
!26 = distinct !DILexicalBlock(scope: !27, file: !1, line: 10, column: 13)
!27 = distinct !DILexicalBlock(scope: !22, file: !1, line: 9, column: 18)
!28 = !DILocation(line: 10, column: 21, scope: !26)
!29 = !DILocation(line: 10, column: 13, scope: !27)
!30 = !DILocation(line: 11, column: 17, scope: !31)
!31 = distinct !DILexicalBlock(scope: !32, file: !1, line: 11, column: 17)
!32 = distinct !DILexicalBlock(scope: !26, file: !1, line: 10, column: 30)
!33 = !DILocation(line: 11, column: 25, scope: !31)
!34 = !DILocation(line: 11, column: 17, scope: !32)
!35 = !DILocation(line: 12, column: 17, scope: !36)
!36 = distinct !DILexicalBlock(scope: !31, file: !1, line: 11, column: 34)
!37 = distinct !{!37, !35, !38}
!38 = !DILocation(line: 14, column: 27, scope: !36)
!39 = !DILocalVariable(name: "a", scope: !40, file: !1, line: 13, type: !12)
!40 = distinct !DILexicalBlock(scope: !36, file: !1, line: 12, column: 20)
!41 = !DILocation(line: 13, column: 25, scope: !40)
!42 = !DILocation(line: 14, column: 17, scope: !40)
!43 = !DILocation(line: 15, column: 17, scope: !36)
!44 = !DILocalVariable(name: "a", scope: !45, file: !1, line: 17, type: !12)
!45 = distinct !DILexicalBlock(scope: !31, file: !1, line: 16, column: 20)
!46 = !DILocation(line: 17, column: 21, scope: !45)
!47 = !DILocalVariable(name: "eob", scope: !32, file: !1, line: 19, type: !12)
!48 = !DILocation(line: 19, column: 17, scope: !32)
!49 = !DILocation(line: 20, column: 13, scope: !32)
!50 = !DILocation(line: 22, column: 16, scope: !51)
!51 = distinct !DILexicalBlock(scope: !26, file: !1, line: 21, column: 16)
!52 = !DILocalVariable(name: "eob", scope: !27, file: !1, line: 24, type: !12)
!53 = !DILocation(line: 24, column: 13, scope: !27)
!54 = !DILocation(line: 25, column: 5, scope: !27)
!55 = !DILocation(line: 26, column: 13, scope: !56)
!56 = distinct !DILexicalBlock(scope: !57, file: !1, line: 26, column: 13)
!57 = distinct !DILexicalBlock(scope: !22, file: !1, line: 25, column: 12)
!58 = !DILocation(line: 26, column: 16, scope: !56)
!59 = !DILocation(line: 26, column: 13, scope: !57)
!60 = !DILocation(line: 27, column: 13, scope: !61)
!61 = distinct !DILexicalBlock(scope: !56, file: !1, line: 26, column: 22)
!62 = !DILocalVariable(name: "t1", scope: !57, file: !1, line: 29, type: !14)
!63 = !DILocation(line: 29, column: 15, scope: !57)
!64 = !DILocation(line: 29, column: 20, scope: !57)
!65 = !DILocalVariable(name: "ut", scope: !9, file: !1, line: 32, type: !14)
!66 = !DILocation(line: 32, column: 11, scope: !9)
!67 = !DILocation(line: 34, column: 12, scope: !9)
!68 = !DILocation(line: 34, column: 5, scope: !9)
!69 = !DILocation(line: 35, column: 1, scope: !9)
