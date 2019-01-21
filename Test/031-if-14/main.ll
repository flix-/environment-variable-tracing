; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i32, %struct.s2, i8* }
%struct.s2 = type { i8*, i32, %struct.s3 }
%struct.s3 = type { %struct.s4 }
%struct.s4 = type { i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %is_env_set = alloca i32, align 4
  %s2_ut = alloca %struct.s2, align 8
  %s11 = alloca %struct.s1*, align 8
  %s22 = alloca %struct.s2*, align 8
  %s3 = alloca %struct.s3*, align 8
  %s4 = alloca %struct.s4*, align 8
  %ut1 = alloca i32, align 4
  %t19 = alloca i32, align 4
  %t2 = alloca i8*, align 8
  %t3 = alloca i8*, align 8
  %t4 = alloca i8*, align 8
  %t5 = alloca i8*, align 8
  %t6 = alloca i8*, align 8
  %ut2 = alloca i8*, align 8
  %ut3 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !13, metadata !33), !dbg !34
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !35
  %t1 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !36
  store i8* %call, i8** %t1, align 8, !dbg !37
  call void @llvm.dbg.declare(metadata i32* %is_env_set, metadata !38, metadata !33), !dbg !39
  %t11 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !40
  %0 = load i8*, i8** %t11, align 8, !dbg !40
  %cmp = icmp ne i8* %0, null, !dbg !41
  %conv = zext i1 %cmp to i32, !dbg !41
  store i32 %conv, i32* %is_env_set, align 4, !dbg !39
  %1 = load i32, i32* %is_env_set, align 4, !dbg !42
  %tobool = icmp ne i32 %1, 0, !dbg !42
  br i1 %tobool, label %if.then, label %if.end, !dbg !44

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata %struct.s2* %s2_ut, metadata !45, metadata !33), !dbg !47
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !48
  %2 = bitcast %struct.s2* %s2 to i8*, !dbg !49
  %3 = bitcast %struct.s2* %s2_ut to i8*, !dbg !49
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 32, i32 8, i1 false), !dbg !49
  br label %if.end, !dbg !50

if.end:                                           ; preds = %if.then, %entry
  call void @llvm.dbg.declare(metadata %struct.s1** %s11, metadata !51, metadata !33), !dbg !53
  store %struct.s1* %s1, %struct.s1** %s11, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata %struct.s2** %s22, metadata !54, metadata !33), !dbg !56
  %s23 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !57
  store %struct.s2* %s23, %struct.s2** %s22, align 8, !dbg !56
  call void @llvm.dbg.declare(metadata %struct.s3** %s3, metadata !58, metadata !33), !dbg !60
  %s24 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !61
  %s35 = getelementptr inbounds %struct.s2, %struct.s2* %s24, i32 0, i32 2, !dbg !62
  store %struct.s3* %s35, %struct.s3** %s3, align 8, !dbg !60
  call void @llvm.dbg.declare(metadata %struct.s4** %s4, metadata !63, metadata !33), !dbg !65
  %s26 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !66
  %s37 = getelementptr inbounds %struct.s2, %struct.s2* %s26, i32 0, i32 2, !dbg !67
  %s48 = getelementptr inbounds %struct.s3, %struct.s3* %s37, i32 0, i32 0, !dbg !68
  store %struct.s4* %s48, %struct.s4** %s4, align 8, !dbg !65
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !69, metadata !33), !dbg !70
  %4 = load %struct.s1*, %struct.s1** %s11, align 8, !dbg !71
  %a = getelementptr inbounds %struct.s1, %struct.s1* %4, i32 0, i32 0, !dbg !72
  %5 = load i32, i32* %a, align 8, !dbg !72
  store i32 %5, i32* %ut1, align 4, !dbg !70
  call void @llvm.dbg.declare(metadata i32* %t19, metadata !73, metadata !33), !dbg !74
  %6 = load %struct.s1*, %struct.s1** %s11, align 8, !dbg !75
  %s210 = getelementptr inbounds %struct.s1, %struct.s1* %6, i32 0, i32 1, !dbg !76
  %b = getelementptr inbounds %struct.s2, %struct.s2* %s210, i32 0, i32 1, !dbg !77
  %7 = load i32, i32* %b, align 8, !dbg !77
  store i32 %7, i32* %t19, align 4, !dbg !74
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !78, metadata !33), !dbg !79
  %8 = load %struct.s1*, %struct.s1** %s11, align 8, !dbg !80
  %s211 = getelementptr inbounds %struct.s1, %struct.s1* %8, i32 0, i32 1, !dbg !81
  %t212 = getelementptr inbounds %struct.s2, %struct.s2* %s211, i32 0, i32 0, !dbg !82
  %9 = load i8*, i8** %t212, align 8, !dbg !82
  store i8* %9, i8** %t2, align 8, !dbg !79
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !83, metadata !33), !dbg !84
  %10 = load %struct.s2*, %struct.s2** %s22, align 8, !dbg !85
  %t213 = getelementptr inbounds %struct.s2, %struct.s2* %10, i32 0, i32 0, !dbg !86
  %11 = load i8*, i8** %t213, align 8, !dbg !86
  store i8* %11, i8** %t3, align 8, !dbg !84
  call void @llvm.dbg.declare(metadata i8** %t4, metadata !87, metadata !33), !dbg !88
  %12 = load %struct.s2*, %struct.s2** %s22, align 8, !dbg !89
  %s314 = getelementptr inbounds %struct.s2, %struct.s2* %12, i32 0, i32 2, !dbg !90
  %s415 = getelementptr inbounds %struct.s3, %struct.s3* %s314, i32 0, i32 0, !dbg !91
  %t216 = getelementptr inbounds %struct.s4, %struct.s4* %s415, i32 0, i32 1, !dbg !92
  %13 = load i8*, i8** %t216, align 8, !dbg !92
  store i8* %13, i8** %t4, align 8, !dbg !88
  call void @llvm.dbg.declare(metadata i8** %t5, metadata !93, metadata !33), !dbg !94
  %14 = load %struct.s3*, %struct.s3** %s3, align 8, !dbg !95
  %s417 = getelementptr inbounds %struct.s3, %struct.s3* %14, i32 0, i32 0, !dbg !96
  %t118 = getelementptr inbounds %struct.s4, %struct.s4* %s417, i32 0, i32 0, !dbg !97
  %15 = load i8*, i8** %t118, align 8, !dbg !97
  store i8* %15, i8** %t5, align 8, !dbg !94
  call void @llvm.dbg.declare(metadata i8** %t6, metadata !98, metadata !33), !dbg !99
  %16 = load %struct.s3*, %struct.s3** %s3, align 8, !dbg !100
  %s419 = getelementptr inbounds %struct.s3, %struct.s3* %16, i32 0, i32 0, !dbg !101
  %t220 = getelementptr inbounds %struct.s4, %struct.s4* %s419, i32 0, i32 1, !dbg !102
  %17 = load i8*, i8** %t220, align 8, !dbg !102
  store i8* %17, i8** %t6, align 8, !dbg !99
  store %struct.s3* null, %struct.s3** %s3, align 8, !dbg !103
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !104, metadata !33), !dbg !105
  %18 = load %struct.s3*, %struct.s3** %s3, align 8, !dbg !106
  %s421 = getelementptr inbounds %struct.s3, %struct.s3* %18, i32 0, i32 0, !dbg !107
  %t122 = getelementptr inbounds %struct.s4, %struct.s4* %s421, i32 0, i32 0, !dbg !108
  %19 = load i8*, i8** %t122, align 8, !dbg !108
  store i8* %19, i8** %ut2, align 8, !dbg !105
  call void @llvm.dbg.declare(metadata i8** %ut3, metadata !109, metadata !33), !dbg !110
  %20 = load %struct.s3*, %struct.s3** %s3, align 8, !dbg !111
  %s423 = getelementptr inbounds %struct.s3, %struct.s3* %20, i32 0, i32 0, !dbg !112
  %t224 = getelementptr inbounds %struct.s4, %struct.s4* %s423, i32 0, i32 1, !dbg !113
  %21 = load i8*, i8** %t224, align 8, !dbg !113
  store i8* %21, i8** %ut3, align 8, !dbg !110
  ret i32 0, !dbg !114
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-14")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 29, type: !10, isLocal: false, isDefinition: true, scopeLine: 30, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "s1", scope: !9, file: !1, line: 31, type: !14)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 22, size: 384, elements: !15)
!15 = !{!16, !17, !32}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !14, file: !1, line: 23, baseType: !12, size: 32)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !14, file: !1, line: 24, baseType: !18, size: 256, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 16, size: 256, elements: !19)
!19 = !{!20, !23, !24}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !18, file: !1, line: 17, baseType: !21, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !18, file: !1, line: 18, baseType: !12, size: 32, offset: 64)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !18, file: !1, line: 19, baseType: !25, size: 128, offset: 128)
!25 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 12, size: 128, elements: !26)
!26 = !{!27}
!27 = !DIDerivedType(tag: DW_TAG_member, name: "s4", scope: !25, file: !1, line: 13, baseType: !28, size: 128)
!28 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s4", file: !1, line: 7, size: 128, elements: !29)
!29 = !{!30, !31}
!30 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !28, file: !1, line: 8, baseType: !21, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !28, file: !1, line: 9, baseType: !21, size: 64, offset: 64)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !14, file: !1, line: 25, baseType: !21, size: 64, offset: 320)
!33 = !DIExpression()
!34 = !DILocation(line: 31, column: 15, scope: !9)
!35 = !DILocation(line: 32, column: 13, scope: !9)
!36 = !DILocation(line: 32, column: 8, scope: !9)
!37 = !DILocation(line: 32, column: 11, scope: !9)
!38 = !DILocalVariable(name: "is_env_set", scope: !9, file: !1, line: 34, type: !12)
!39 = !DILocation(line: 34, column: 9, scope: !9)
!40 = !DILocation(line: 34, column: 25, scope: !9)
!41 = !DILocation(line: 34, column: 28, scope: !9)
!42 = !DILocation(line: 36, column: 9, scope: !43)
!43 = distinct !DILexicalBlock(scope: !9, file: !1, line: 36, column: 9)
!44 = !DILocation(line: 36, column: 9, scope: !9)
!45 = !DILocalVariable(name: "s2_ut", scope: !46, file: !1, line: 37, type: !18)
!46 = distinct !DILexicalBlock(scope: !43, file: !1, line: 36, column: 21)
!47 = !DILocation(line: 37, column: 19, scope: !46)
!48 = !DILocation(line: 38, column: 12, scope: !46)
!49 = !DILocation(line: 38, column: 17, scope: !46)
!50 = !DILocation(line: 39, column: 5, scope: !46)
!51 = !DILocalVariable(name: "s11", scope: !9, file: !1, line: 41, type: !52)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!53 = !DILocation(line: 41, column: 16, scope: !9)
!54 = !DILocalVariable(name: "s2", scope: !9, file: !1, line: 42, type: !55)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!56 = !DILocation(line: 42, column: 16, scope: !9)
!57 = !DILocation(line: 42, column: 25, scope: !9)
!58 = !DILocalVariable(name: "s3", scope: !9, file: !1, line: 43, type: !59)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!60 = !DILocation(line: 43, column: 16, scope: !9)
!61 = !DILocation(line: 43, column: 25, scope: !9)
!62 = !DILocation(line: 43, column: 28, scope: !9)
!63 = !DILocalVariable(name: "s4", scope: !9, file: !1, line: 44, type: !64)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!65 = !DILocation(line: 44, column: 16, scope: !9)
!66 = !DILocation(line: 44, column: 25, scope: !9)
!67 = !DILocation(line: 44, column: 28, scope: !9)
!68 = !DILocation(line: 44, column: 31, scope: !9)
!69 = !DILocalVariable(name: "ut1", scope: !9, file: !1, line: 46, type: !12)
!70 = !DILocation(line: 46, column: 9, scope: !9)
!71 = !DILocation(line: 46, column: 15, scope: !9)
!72 = !DILocation(line: 46, column: 20, scope: !9)
!73 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 47, type: !12)
!74 = !DILocation(line: 47, column: 9, scope: !9)
!75 = !DILocation(line: 47, column: 14, scope: !9)
!76 = !DILocation(line: 47, column: 19, scope: !9)
!77 = !DILocation(line: 47, column: 22, scope: !9)
!78 = !DILocalVariable(name: "t2", scope: !9, file: !1, line: 49, type: !21)
!79 = !DILocation(line: 49, column: 11, scope: !9)
!80 = !DILocation(line: 49, column: 16, scope: !9)
!81 = !DILocation(line: 49, column: 21, scope: !9)
!82 = !DILocation(line: 49, column: 24, scope: !9)
!83 = !DILocalVariable(name: "t3", scope: !9, file: !1, line: 50, type: !21)
!84 = !DILocation(line: 50, column: 11, scope: !9)
!85 = !DILocation(line: 50, column: 16, scope: !9)
!86 = !DILocation(line: 50, column: 20, scope: !9)
!87 = !DILocalVariable(name: "t4", scope: !9, file: !1, line: 51, type: !21)
!88 = !DILocation(line: 51, column: 11, scope: !9)
!89 = !DILocation(line: 51, column: 16, scope: !9)
!90 = !DILocation(line: 51, column: 20, scope: !9)
!91 = !DILocation(line: 51, column: 23, scope: !9)
!92 = !DILocation(line: 51, column: 26, scope: !9)
!93 = !DILocalVariable(name: "t5", scope: !9, file: !1, line: 52, type: !21)
!94 = !DILocation(line: 52, column: 11, scope: !9)
!95 = !DILocation(line: 52, column: 16, scope: !9)
!96 = !DILocation(line: 52, column: 20, scope: !9)
!97 = !DILocation(line: 52, column: 23, scope: !9)
!98 = !DILocalVariable(name: "t6", scope: !9, file: !1, line: 53, type: !21)
!99 = !DILocation(line: 53, column: 11, scope: !9)
!100 = !DILocation(line: 53, column: 16, scope: !9)
!101 = !DILocation(line: 53, column: 20, scope: !9)
!102 = !DILocation(line: 53, column: 23, scope: !9)
!103 = !DILocation(line: 55, column: 8, scope: !9)
!104 = !DILocalVariable(name: "ut2", scope: !9, file: !1, line: 57, type: !21)
!105 = !DILocation(line: 57, column: 11, scope: !9)
!106 = !DILocation(line: 57, column: 17, scope: !9)
!107 = !DILocation(line: 57, column: 21, scope: !9)
!108 = !DILocation(line: 57, column: 24, scope: !9)
!109 = !DILocalVariable(name: "ut3", scope: !9, file: !1, line: 58, type: !21)
!110 = !DILocation(line: 58, column: 11, scope: !9)
!111 = !DILocation(line: 58, column: 17, scope: !9)
!112 = !DILocation(line: 58, column: 21, scope: !9)
!113 = !DILocation(line: 58, column: 24, scope: !9)
!114 = !DILocation(line: 60, column: 5, scope: !9)
