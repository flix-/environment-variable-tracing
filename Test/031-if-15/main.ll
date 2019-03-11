; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !16 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1*, align 8
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1** %s1, metadata !20, metadata !21), !dbg !22
  %call = call noalias i8* @malloc(i64 16) #3, !dbg !23
  %0 = bitcast i8* %call to %struct.s1*, !dbg !24
  store %struct.s1* %0, %struct.s1** %s1, align 8, !dbg !22
  %1 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !25
  %tobool = icmp ne %struct.s1* %1, null, !dbg !25
  br i1 %tobool, label %if.end, label %if.then, !dbg !27

if.then:                                          ; preds = %entry
  store i32 -1, i32* %retval, align 4, !dbg !28
  br label %return, !dbg !28

if.end:                                           ; preds = %entry
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !29
  %2 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !30
  %t1 = getelementptr inbounds %struct.s1, %struct.s1* %2, i32 0, i32 0, !dbg !31
  store i8* %call1, i8** %t1, align 8, !dbg !32
  %3 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !33
  %cmp = icmp ne %struct.s1* %3, null, !dbg !35
  br i1 %cmp, label %if.then2, label %if.end3, !dbg !36

if.then2:                                         ; preds = %if.end
  call void @llvm.dbg.declare(metadata i32* %a, metadata !37, metadata !21), !dbg !39
  store i32 4711, i32* %a, align 4, !dbg !39
  br label %if.end3, !dbg !40

if.end3:                                          ; preds = %if.then2, %if.end
  %4 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !41
  %t14 = getelementptr inbounds %struct.s1, %struct.s1* %4, i32 0, i32 0, !dbg !43
  %5 = load i8*, i8** %t14, align 8, !dbg !43
  %cmp5 = icmp ne i8* %5, null, !dbg !44
  br i1 %cmp5, label %if.then6, label %if.end7, !dbg !45

if.then6:                                         ; preds = %if.end3
  call void @llvm.dbg.declare(metadata i32* %b, metadata !46, metadata !21), !dbg !48
  store i32 4711, i32* %b, align 4, !dbg !48
  br label %if.end7, !dbg !49

if.end7:                                          ; preds = %if.then6, %if.end3
  %6 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !50
  %ut1 = getelementptr inbounds %struct.s1, %struct.s1* %6, i32 0, i32 1, !dbg !52
  %7 = load i8*, i8** %ut1, align 8, !dbg !52
  %cmp8 = icmp ne i8* %7, null, !dbg !53
  br i1 %cmp8, label %if.then9, label %if.end10, !dbg !54

if.then9:                                         ; preds = %if.end7
  call void @llvm.dbg.declare(metadata i32* %c, metadata !55, metadata !21), !dbg !57
  store i32 4711, i32* %c, align 4, !dbg !57
  br label %if.end10, !dbg !58

if.end10:                                         ; preds = %if.then9, %if.end7
  store i32 0, i32* %retval, align 4, !dbg !59
  br label %return, !dbg !59

return:                                           ; preds = %if.end10, %if.then
  %8 = load i32, i32* %retval, align 4, !dbg !60
  ret i32 %8, !dbg !60
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!12, !13, !14}
!llvm.ident = !{!15}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-15")
!2 = !{}
!3 = !{!4, !11}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 5, size: 128, elements: !6)
!6 = !{!7, !10}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !5, file: !1, line: 6, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "ut1", scope: !5, file: !1, line: 7, baseType: !8, size: 64, offset: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!12 = !{i32 2, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!16 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !17, isLocal: false, isDefinition: true, scopeLine: 12, isOptimized: false, unit: !0, variables: !2)
!17 = !DISubroutineType(types: !18)
!18 = !{!19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DILocalVariable(name: "s1", scope: !16, file: !1, line: 13, type: !4)
!21 = !DIExpression()
!22 = !DILocation(line: 13, column: 16, scope: !16)
!23 = !DILocation(line: 13, column: 33, scope: !16)
!24 = !DILocation(line: 13, column: 21, scope: !16)
!25 = !DILocation(line: 14, column: 10, scope: !26)
!26 = distinct !DILexicalBlock(scope: !16, file: !1, line: 14, column: 9)
!27 = !DILocation(line: 14, column: 9, scope: !16)
!28 = !DILocation(line: 14, column: 14, scope: !26)
!29 = !DILocation(line: 16, column: 14, scope: !16)
!30 = !DILocation(line: 16, column: 5, scope: !16)
!31 = !DILocation(line: 16, column: 9, scope: !16)
!32 = !DILocation(line: 16, column: 12, scope: !16)
!33 = !DILocation(line: 18, column: 9, scope: !34)
!34 = distinct !DILexicalBlock(scope: !16, file: !1, line: 18, column: 9)
!35 = !DILocation(line: 18, column: 12, scope: !34)
!36 = !DILocation(line: 18, column: 9, scope: !16)
!37 = !DILocalVariable(name: "a", scope: !38, file: !1, line: 19, type: !19)
!38 = distinct !DILexicalBlock(scope: !34, file: !1, line: 18, column: 21)
!39 = !DILocation(line: 19, column: 13, scope: !38)
!40 = !DILocation(line: 20, column: 5, scope: !38)
!41 = !DILocation(line: 22, column: 9, scope: !42)
!42 = distinct !DILexicalBlock(scope: !16, file: !1, line: 22, column: 9)
!43 = !DILocation(line: 22, column: 13, scope: !42)
!44 = !DILocation(line: 22, column: 16, scope: !42)
!45 = !DILocation(line: 22, column: 9, scope: !16)
!46 = !DILocalVariable(name: "b", scope: !47, file: !1, line: 23, type: !19)
!47 = distinct !DILexicalBlock(scope: !42, file: !1, line: 22, column: 25)
!48 = !DILocation(line: 23, column: 13, scope: !47)
!49 = !DILocation(line: 24, column: 5, scope: !47)
!50 = !DILocation(line: 26, column: 9, scope: !51)
!51 = distinct !DILexicalBlock(scope: !16, file: !1, line: 26, column: 9)
!52 = !DILocation(line: 26, column: 13, scope: !51)
!53 = !DILocation(line: 26, column: 17, scope: !51)
!54 = !DILocation(line: 26, column: 9, scope: !16)
!55 = !DILocalVariable(name: "c", scope: !56, file: !1, line: 27, type: !19)
!56 = distinct !DILexicalBlock(scope: !51, file: !1, line: 26, column: 26)
!57 = !DILocation(line: 27, column: 13, scope: !56)
!58 = !DILocation(line: 28, column: 5, scope: !56)
!59 = !DILocation(line: 30, column: 5, scope: !16)
!60 = !DILocation(line: 31, column: 1, scope: !16)
