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
  %a1 = alloca i8*, align 8
  %eob = alloca i32, align 4
  %ut1 = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %ut2 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %a, metadata !16, metadata !14), !dbg !17
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !18
  %cmp = icmp ne i8* %call, null, !dbg !20
  br i1 %cmp, label %if.then, label %if.else, !dbg !21

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i8** %a1, metadata !22, metadata !14), !dbg !26
  %call2 = call noalias i8* @malloc(i64 8) #3, !dbg !27
  store i8* %call2, i8** %a1, align 8, !dbg !26
  %0 = load i8*, i8** %a1, align 8, !dbg !28
  %tobool = icmp ne i8* %0, null, !dbg !28
  br i1 %tobool, label %if.end, label %if.then3, !dbg !30

if.then3:                                         ; preds = %if.then
  br label %out, !dbg !31

if.end:                                           ; preds = %if.then
  store i32 1, i32* %rc, align 4, !dbg !32
  br label %if.end4, !dbg !33

if.else:                                          ; preds = %entry
  store i32 0, i32* %a, align 4, !dbg !34
  br label %if.end4

if.end4:                                          ; preds = %if.else, %if.end
  call void @llvm.dbg.declare(metadata i32* %eob, metadata !36, metadata !14), !dbg !37
  store i32 1, i32* %eob, align 4, !dbg !37
  br label %out, !dbg !38

out:                                              ; preds = %if.end4, %if.then3
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !39, metadata !14), !dbg !40
  store i32 0, i32* %ut1, align 4, !dbg !40
  %1 = load i32, i32* %a, align 4, !dbg !41
  %tobool5 = icmp ne i32 %1, 0, !dbg !41
  br i1 %tobool5, label %if.then6, label %if.else7, !dbg !43

if.then6:                                         ; preds = %out
  call void @llvm.dbg.declare(metadata i32* %b, metadata !44, metadata !14), !dbg !46
  store i32 1, i32* %b, align 4, !dbg !46
  br label %if.end8, !dbg !47

if.else7:                                         ; preds = %out
  call void @llvm.dbg.declare(metadata i32* %c, metadata !48, metadata !14), !dbg !50
  store i32 2, i32* %c, align 4, !dbg !50
  br label %if.end8

if.end8:                                          ; preds = %if.else7, %if.then6
  call void @llvm.dbg.declare(metadata i32* %ut2, metadata !51, metadata !14), !dbg !52
  store i32 0, i32* %ut2, align 4, !dbg !52
  %2 = load i32, i32* %rc, align 4, !dbg !53
  ret i32 %2, !dbg !54
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-27")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !10, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "rc", scope: !9, file: !1, line: 8, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 8, column: 9, scope: !9)
!16 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 9, type: !12)
!17 = !DILocation(line: 9, column: 9, scope: !9)
!18 = !DILocation(line: 11, column: 9, scope: !19)
!19 = distinct !DILexicalBlock(scope: !9, file: !1, line: 11, column: 9)
!20 = !DILocation(line: 11, column: 24, scope: !19)
!21 = !DILocation(line: 11, column: 9, scope: !9)
!22 = !DILocalVariable(name: "a", scope: !23, file: !1, line: 12, type: !24)
!23 = distinct !DILexicalBlock(scope: !19, file: !1, line: 11, column: 33)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!26 = !DILocation(line: 12, column: 15, scope: !23)
!27 = !DILocation(line: 12, column: 19, scope: !23)
!28 = !DILocation(line: 13, column: 14, scope: !29)
!29 = distinct !DILexicalBlock(scope: !23, file: !1, line: 13, column: 13)
!30 = !DILocation(line: 13, column: 13, scope: !23)
!31 = !DILocation(line: 13, column: 17, scope: !29)
!32 = !DILocation(line: 15, column: 12, scope: !23)
!33 = !DILocation(line: 16, column: 5, scope: !23)
!34 = !DILocation(line: 17, column: 11, scope: !35)
!35 = distinct !DILexicalBlock(scope: !19, file: !1, line: 16, column: 12)
!36 = !DILocalVariable(name: "eob", scope: !9, file: !1, line: 19, type: !12)
!37 = !DILocation(line: 19, column: 9, scope: !9)
!38 = !DILocation(line: 19, column: 5, scope: !9)
!39 = !DILocalVariable(name: "ut1", scope: !9, file: !1, line: 23, type: !12)
!40 = !DILocation(line: 23, column: 9, scope: !9)
!41 = !DILocation(line: 25, column: 9, scope: !42)
!42 = distinct !DILexicalBlock(scope: !9, file: !1, line: 25, column: 9)
!43 = !DILocation(line: 25, column: 9, scope: !9)
!44 = !DILocalVariable(name: "b", scope: !45, file: !1, line: 26, type: !12)
!45 = distinct !DILexicalBlock(scope: !42, file: !1, line: 25, column: 12)
!46 = !DILocation(line: 26, column: 13, scope: !45)
!47 = !DILocation(line: 27, column: 5, scope: !45)
!48 = !DILocalVariable(name: "c", scope: !49, file: !1, line: 28, type: !12)
!49 = distinct !DILexicalBlock(scope: !42, file: !1, line: 27, column: 12)
!50 = !DILocation(line: 28, column: 13, scope: !49)
!51 = !DILocalVariable(name: "ut2", scope: !9, file: !1, line: 31, type: !12)
!52 = !DILocation(line: 31, column: 9, scope: !9)
!53 = !DILocation(line: 33, column: 12, scope: !9)
!54 = !DILocation(line: 33, column: 5, scope: !9)
