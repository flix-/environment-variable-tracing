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
  %s3 = alloca %struct.s3*, align 8
  %t14 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %ut2 = alloca i8*, align 8
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
  call void @llvm.dbg.declare(metadata %struct.s3** %s3, metadata !51, metadata !33), !dbg !53
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !54
  %s33 = getelementptr inbounds %struct.s2, %struct.s2* %s22, i32 0, i32 2, !dbg !55
  store %struct.s3* %s33, %struct.s3** %s3, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata i8** %t14, metadata !56, metadata !33), !dbg !57
  %4 = load %struct.s3*, %struct.s3** %s3, align 8, !dbg !58
  %s4 = getelementptr inbounds %struct.s3, %struct.s3* %4, i32 0, i32 0, !dbg !59
  %t15 = getelementptr inbounds %struct.s4, %struct.s4* %s4, i32 0, i32 0, !dbg !60
  %5 = load i8*, i8** %t15, align 8, !dbg !60
  store i8* %5, i8** %t14, align 8, !dbg !57
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !61, metadata !33), !dbg !62
  %6 = load %struct.s3*, %struct.s3** %s3, align 8, !dbg !63
  %s46 = getelementptr inbounds %struct.s3, %struct.s3* %6, i32 0, i32 0, !dbg !64
  %t27 = getelementptr inbounds %struct.s4, %struct.s4* %s46, i32 0, i32 1, !dbg !65
  %7 = load i8*, i8** %t27, align 8, !dbg !65
  store i8* %7, i8** %t2, align 8, !dbg !62
  store %struct.s3* null, %struct.s3** %s3, align 8, !dbg !66
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !67, metadata !33), !dbg !68
  %8 = load %struct.s3*, %struct.s3** %s3, align 8, !dbg !69
  %s48 = getelementptr inbounds %struct.s3, %struct.s3* %8, i32 0, i32 0, !dbg !70
  %t19 = getelementptr inbounds %struct.s4, %struct.s4* %s48, i32 0, i32 0, !dbg !71
  %9 = load i8*, i8** %t19, align 8, !dbg !71
  store i8* %9, i8** %ut1, align 8, !dbg !68
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !72, metadata !33), !dbg !73
  %10 = load %struct.s3*, %struct.s3** %s3, align 8, !dbg !74
  %s410 = getelementptr inbounds %struct.s3, %struct.s3* %10, i32 0, i32 0, !dbg !75
  %t211 = getelementptr inbounds %struct.s4, %struct.s4* %s410, i32 0, i32 1, !dbg !76
  %11 = load i8*, i8** %t211, align 8, !dbg !76
  store i8* %11, i8** %ut2, align 8, !dbg !73
  ret i32 0, !dbg !77
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-12")
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
!51 = !DILocalVariable(name: "s3", scope: !9, file: !1, line: 41, type: !52)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!53 = !DILocation(line: 41, column: 16, scope: !9)
!54 = !DILocation(line: 41, column: 25, scope: !9)
!55 = !DILocation(line: 41, column: 28, scope: !9)
!56 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 43, type: !21)
!57 = !DILocation(line: 43, column: 11, scope: !9)
!58 = !DILocation(line: 43, column: 16, scope: !9)
!59 = !DILocation(line: 43, column: 20, scope: !9)
!60 = !DILocation(line: 43, column: 23, scope: !9)
!61 = !DILocalVariable(name: "t2", scope: !9, file: !1, line: 44, type: !21)
!62 = !DILocation(line: 44, column: 11, scope: !9)
!63 = !DILocation(line: 44, column: 16, scope: !9)
!64 = !DILocation(line: 44, column: 20, scope: !9)
!65 = !DILocation(line: 44, column: 23, scope: !9)
!66 = !DILocation(line: 46, column: 8, scope: !9)
!67 = !DILocalVariable(name: "ut1", scope: !9, file: !1, line: 48, type: !21)
!68 = !DILocation(line: 48, column: 11, scope: !9)
!69 = !DILocation(line: 48, column: 17, scope: !9)
!70 = !DILocation(line: 48, column: 21, scope: !9)
!71 = !DILocation(line: 48, column: 24, scope: !9)
!72 = !DILocalVariable(name: "ut2", scope: !9, file: !1, line: 49, type: !21)
!73 = !DILocation(line: 49, column: 11, scope: !9)
!74 = !DILocation(line: 49, column: 17, scope: !9)
!75 = !DILocation(line: 49, column: 21, scope: !9)
!76 = !DILocation(line: 49, column: 24, scope: !9)
!77 = !DILocation(line: 51, column: 5, scope: !9)
