; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %struct.s2 }
%struct.s2 = type { i32, i8*, %struct.s3** }
%struct.s3 = type { i32, i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %s31 = alloca %struct.s3, align 8
  %s32 = alloca %struct.s3*, align 8
  %s33 = alloca %struct.s3**, align 8
  %s34 = alloca %struct.s3*, align 8
  %t = alloca i8*, align 8
  %s359 = alloca %struct.s3*, align 8
  %ut = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !11, metadata !30), !dbg !31
  call void @llvm.dbg.declare(metadata %struct.s3* %s31, metadata !32, metadata !30), !dbg !33
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !34
  %t3 = getelementptr inbounds %struct.s3, %struct.s3* %s31, i32 0, i32 2, !dbg !35
  store i8* %call, i8** %t3, align 8, !dbg !36
  call void @llvm.dbg.declare(metadata %struct.s3** %s32, metadata !37, metadata !30), !dbg !38
  store %struct.s3* %s31, %struct.s3** %s32, align 8, !dbg !38
  call void @llvm.dbg.declare(metadata %struct.s3*** %s33, metadata !39, metadata !30), !dbg !40
  store %struct.s3** %s32, %struct.s3*** %s33, align 8, !dbg !40
  %0 = load %struct.s3**, %struct.s3*** %s33, align 8, !dbg !41
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !42
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !43
  store %struct.s3** %0, %struct.s3*** %s3, align 8, !dbg !44
  call void @llvm.dbg.declare(metadata %struct.s3** %s34, metadata !45, metadata !30), !dbg !46
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !47
  %s35 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 2, !dbg !48
  %1 = load %struct.s3**, %struct.s3*** %s35, align 8, !dbg !48
  %2 = load %struct.s3*, %struct.s3** %1, align 8, !dbg !49
  store %struct.s3* %2, %struct.s3** %s34, align 8, !dbg !46
  call void @llvm.dbg.declare(metadata i8** %t, metadata !50, metadata !30), !dbg !51
  %3 = load %struct.s3*, %struct.s3** %s34, align 8, !dbg !52
  %t36 = getelementptr inbounds %struct.s3, %struct.s3* %3, i32 0, i32 2, !dbg !53
  %4 = load i8*, i8** %t36, align 8, !dbg !53
  store i8* %4, i8** %t, align 8, !dbg !51
  %s27 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !54
  %s38 = getelementptr inbounds %struct.s2, %struct.s2* %s27, i32 0, i32 2, !dbg !55
  store %struct.s3** null, %struct.s3*** %s38, align 8, !dbg !56
  call void @llvm.dbg.declare(metadata %struct.s3** %s359, metadata !57, metadata !30), !dbg !58
  %s210 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !59
  %s311 = getelementptr inbounds %struct.s2, %struct.s2* %s210, i32 0, i32 2, !dbg !60
  %5 = load %struct.s3**, %struct.s3*** %s311, align 8, !dbg !60
  %6 = load %struct.s3*, %struct.s3** %5, align 8, !dbg !61
  store %struct.s3* %6, %struct.s3** %s359, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata i8** %ut, metadata !62, metadata !30), !dbg !63
  %7 = load %struct.s3*, %struct.s3** %s359, align 8, !dbg !64
  %t312 = getelementptr inbounds %struct.s3, %struct.s3* %7, i32 0, i32 2, !dbg !65
  %8 = load i8*, i8** %t312, align 8, !dbg !65
  store i8* %8, i8** %ut, align 8, !dbg !63
  ret i32 0, !dbg !66
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
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/151-ptr-8")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 25, type: !8, isLocal: false, isDefinition: true, scopeLine: 26, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 27, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 19, size: 256, elements: !13)
!13 = !{!14, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !12, file: !1, line: 20, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !12, file: !1, line: 21, baseType: !18, size: 192, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 13, size: 192, elements: !19)
!19 = !{!20, !21, !22}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !18, file: !1, line: 14, baseType: !10, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !18, file: !1, line: 15, baseType: !15, size: 64, offset: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !18, file: !1, line: 16, baseType: !23, size: 64, offset: 128)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 7, size: 128, elements: !26)
!26 = !{!27, !28, !29}
!27 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !25, file: !1, line: 8, baseType: !10, size: 32)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "i2", scope: !25, file: !1, line: 9, baseType: !10, size: 32, offset: 32)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "t3", scope: !25, file: !1, line: 10, baseType: !15, size: 64, offset: 64)
!30 = !DIExpression()
!31 = !DILocation(line: 27, column: 15, scope: !7)
!32 = !DILocalVariable(name: "s31", scope: !7, file: !1, line: 28, type: !25)
!33 = !DILocation(line: 28, column: 15, scope: !7)
!34 = !DILocation(line: 29, column: 14, scope: !7)
!35 = !DILocation(line: 29, column: 9, scope: !7)
!36 = !DILocation(line: 29, column: 12, scope: !7)
!37 = !DILocalVariable(name: "s32", scope: !7, file: !1, line: 31, type: !24)
!38 = !DILocation(line: 31, column: 16, scope: !7)
!39 = !DILocalVariable(name: "s33", scope: !7, file: !1, line: 32, type: !23)
!40 = !DILocation(line: 32, column: 17, scope: !7)
!41 = !DILocation(line: 34, column: 16, scope: !7)
!42 = !DILocation(line: 34, column: 8, scope: !7)
!43 = !DILocation(line: 34, column: 11, scope: !7)
!44 = !DILocation(line: 34, column: 14, scope: !7)
!45 = !DILocalVariable(name: "s34", scope: !7, file: !1, line: 36, type: !24)
!46 = !DILocation(line: 36, column: 16, scope: !7)
!47 = !DILocation(line: 36, column: 26, scope: !7)
!48 = !DILocation(line: 36, column: 29, scope: !7)
!49 = !DILocation(line: 36, column: 22, scope: !7)
!50 = !DILocalVariable(name: "t", scope: !7, file: !1, line: 37, type: !15)
!51 = !DILocation(line: 37, column: 11, scope: !7)
!52 = !DILocation(line: 37, column: 15, scope: !7)
!53 = !DILocation(line: 37, column: 20, scope: !7)
!54 = !DILocation(line: 39, column: 8, scope: !7)
!55 = !DILocation(line: 39, column: 11, scope: !7)
!56 = !DILocation(line: 39, column: 14, scope: !7)
!57 = !DILocalVariable(name: "s35", scope: !7, file: !1, line: 41, type: !24)
!58 = !DILocation(line: 41, column: 16, scope: !7)
!59 = !DILocation(line: 41, column: 26, scope: !7)
!60 = !DILocation(line: 41, column: 29, scope: !7)
!61 = !DILocation(line: 41, column: 22, scope: !7)
!62 = !DILocalVariable(name: "ut", scope: !7, file: !1, line: 42, type: !15)
!63 = !DILocation(line: 42, column: 11, scope: !7)
!64 = !DILocation(line: 42, column: 16, scope: !7)
!65 = !DILocation(line: 42, column: 21, scope: !7)
!66 = !DILocation(line: 44, column: 5, scope: !7)
