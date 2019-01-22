; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s3 = type { i32*, i32*, i8* }
%struct.s1 = type { i32, i32, %struct.s2* }
%struct.s2 = type { i8*, %struct.s3 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(%struct.s3* byval align 8 %s3) #0 !dbg !9 {
entry:
  %t1 = alloca i32*, align 8
  %t2 = alloca i32*, align 8
  %t3 = alloca i8*, align 8
  call void @llvm.dbg.declare(metadata %struct.s3* %s3, metadata !21, metadata !22), !dbg !23
  call void @llvm.dbg.declare(metadata i32** %t1, metadata !24, metadata !22), !dbg !25
  %a = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 0, !dbg !26
  %0 = load i32*, i32** %a, align 8, !dbg !26
  store i32* %0, i32** %t1, align 8, !dbg !25
  call void @llvm.dbg.declare(metadata i32** %t2, metadata !27, metadata !22), !dbg !28
  %b = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 1, !dbg !29
  %1 = load i32*, i32** %b, align 8, !dbg !29
  store i32* %1, i32** %t2, align 8, !dbg !28
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !30, metadata !22), !dbg !31
  %t11 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 2, !dbg !32
  %2 = load i8*, i8** %t11, align 8, !dbg !32
  store i8* %2, i8** %t3, align 8, !dbg !31
  ret void, !dbg !33
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !34 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %s2 = alloca %struct.s2, align 8
  %is_env_set = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !37, metadata !22), !dbg !48
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !49, metadata !22), !dbg !50
  call void @llvm.dbg.declare(metadata i32* %is_env_set, metadata !51, metadata !22), !dbg !52
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !53
  %cmp = icmp ne i8* %call, null, !dbg !54
  %conv = zext i1 %cmp to i32, !dbg !54
  store i32 %conv, i32* %is_env_set, align 4, !dbg !52
  %0 = load i32, i32* %is_env_set, align 4, !dbg !55
  %tobool = icmp ne i32 %0, 0, !dbg !55
  br i1 %tobool, label %if.then, label %if.end, !dbg !57

if.then:                                          ; preds = %entry
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !58
  store %struct.s2* %s2, %struct.s2** %s21, align 8, !dbg !60
  br label %if.end, !dbg !61

if.end:                                           ; preds = %if.then, %entry
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !62
  %1 = load %struct.s2*, %struct.s2** %s22, align 8, !dbg !62
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %1, i32 0, i32 1, !dbg !63
  call void @foo(%struct.s3* byval align 8 %s3), !dbg !64
  ret i32 0, !dbg !65
}

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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-random-4")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 23, type: !10, isLocal: false, isDefinition: true, scopeLine: 24, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12}
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 5, size: 192, elements: !13)
!13 = !{!14, !17, !18}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 6, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !12, file: !1, line: 7, baseType: !15, size: 64, offset: 64)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !12, file: !1, line: 8, baseType: !19, size: 64, offset: 128)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!21 = !DILocalVariable(name: "s3", arg: 1, scope: !9, file: !1, line: 23, type: !12)
!22 = !DIExpression()
!23 = !DILocation(line: 23, column: 15, scope: !9)
!24 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 25, type: !15)
!25 = !DILocation(line: 25, column: 10, scope: !9)
!26 = !DILocation(line: 25, column: 18, scope: !9)
!27 = !DILocalVariable(name: "t2", scope: !9, file: !1, line: 26, type: !15)
!28 = !DILocation(line: 26, column: 10, scope: !9)
!29 = !DILocation(line: 26, column: 18, scope: !9)
!30 = !DILocalVariable(name: "t3", scope: !9, file: !1, line: 27, type: !19)
!31 = !DILocation(line: 27, column: 11, scope: !9)
!32 = !DILocation(line: 27, column: 19, scope: !9)
!33 = !DILocation(line: 28, column: 1, scope: !9)
!34 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 31, type: !35, isLocal: false, isDefinition: true, scopeLine: 32, isOptimized: false, unit: !0, variables: !2)
!35 = !DISubroutineType(types: !36)
!36 = !{!16}
!37 = !DILocalVariable(name: "s1", scope: !34, file: !1, line: 33, type: !38)
!38 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 16, size: 128, elements: !39)
!39 = !{!40, !41, !42}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !38, file: !1, line: 17, baseType: !16, size: 32)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !38, file: !1, line: 18, baseType: !16, size: 32, offset: 32)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !38, file: !1, line: 19, baseType: !43, size: 64, offset: 64)
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!44 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 11, size: 256, elements: !45)
!45 = !{!46, !47}
!46 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !44, file: !1, line: 12, baseType: !19, size: 64)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !44, file: !1, line: 13, baseType: !12, size: 192, offset: 64)
!48 = !DILocation(line: 33, column: 15, scope: !34)
!49 = !DILocalVariable(name: "s2", scope: !34, file: !1, line: 34, type: !44)
!50 = !DILocation(line: 34, column: 15, scope: !34)
!51 = !DILocalVariable(name: "is_env_set", scope: !34, file: !1, line: 36, type: !16)
!52 = !DILocation(line: 36, column: 9, scope: !34)
!53 = !DILocation(line: 36, column: 22, scope: !34)
!54 = !DILocation(line: 36, column: 37, scope: !34)
!55 = !DILocation(line: 37, column: 9, scope: !56)
!56 = distinct !DILexicalBlock(scope: !34, file: !1, line: 37, column: 9)
!57 = !DILocation(line: 37, column: 9, scope: !34)
!58 = !DILocation(line: 38, column: 12, scope: !59)
!59 = distinct !DILexicalBlock(scope: !56, file: !1, line: 37, column: 21)
!60 = !DILocation(line: 38, column: 15, scope: !59)
!61 = !DILocation(line: 39, column: 5, scope: !59)
!62 = !DILocation(line: 41, column: 12, scope: !34)
!63 = !DILocation(line: 41, column: 16, scope: !34)
!64 = !DILocation(line: 41, column: 5, scope: !34)
!65 = !DILocation(line: 43, column: 5, scope: !34)
