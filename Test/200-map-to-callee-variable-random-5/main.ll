; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s2 = type { i8*, [2 x [2 x %struct.s3]] }
%struct.s3 = type { i32*, i32*, i8* }
%struct.s1 = type { i32, i32, %struct.s2* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(%struct.s2* %s2) #0 !dbg !7 {
entry:
  %s2.addr = alloca %struct.s2*, align 8
  %t1 = alloca i8*, align 8
  %ut1 = alloca i32*, align 8
  %ut2 = alloca i8*, align 8
  store %struct.s2* %s2, %struct.s2** %s2.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.s2** %s2.addr, metadata !27, metadata !28), !dbg !29
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !30, metadata !28), !dbg !31
  %0 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !32
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %0, i32 0, i32 1, !dbg !33
  %arrayidx = getelementptr inbounds [2 x [2 x %struct.s3]], [2 x [2 x %struct.s3]]* %s3, i64 0, i64 0, !dbg !32
  %arrayidx1 = getelementptr inbounds [2 x %struct.s3], [2 x %struct.s3]* %arrayidx, i64 0, i64 1, !dbg !32
  %t12 = getelementptr inbounds %struct.s3, %struct.s3* %arrayidx1, i32 0, i32 2, !dbg !34
  %1 = load i8*, i8** %t12, align 8, !dbg !34
  store i8* %1, i8** %t1, align 8, !dbg !31
  call void @llvm.dbg.declare(metadata i32** %ut1, metadata !35, metadata !28), !dbg !36
  %2 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !37
  %s33 = getelementptr inbounds %struct.s2, %struct.s2* %2, i32 0, i32 1, !dbg !38
  %arrayidx4 = getelementptr inbounds [2 x [2 x %struct.s3]], [2 x [2 x %struct.s3]]* %s33, i64 0, i64 0, !dbg !37
  %arrayidx5 = getelementptr inbounds [2 x %struct.s3], [2 x %struct.s3]* %arrayidx4, i64 0, i64 0, !dbg !37
  %a = getelementptr inbounds %struct.s3, %struct.s3* %arrayidx5, i32 0, i32 0, !dbg !39
  %3 = load i32*, i32** %a, align 8, !dbg !39
  store i32* %3, i32** %ut1, align 8, !dbg !36
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !40, metadata !28), !dbg !41
  %4 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !42
  %s36 = getelementptr inbounds %struct.s2, %struct.s2* %4, i32 0, i32 1, !dbg !43
  %arrayidx7 = getelementptr inbounds [2 x [2 x %struct.s3]], [2 x [2 x %struct.s3]]* %s36, i64 0, i64 0, !dbg !42
  %arrayidx8 = getelementptr inbounds [2 x %struct.s3], [2 x %struct.s3]* %arrayidx7, i64 0, i64 0, !dbg !42
  %t19 = getelementptr inbounds %struct.s3, %struct.s3* %arrayidx8, i32 0, i32 2, !dbg !44
  %5 = load i8*, i8** %t19, align 8, !dbg !44
  store i8* %5, i8** %ut2, align 8, !dbg !41
  ret void, !dbg !45
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !46 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %s2 = alloca %struct.s2, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !49, metadata !28), !dbg !55
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !56, metadata !28), !dbg !57
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !58
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !59
  %arrayidx = getelementptr inbounds [2 x [2 x %struct.s3]], [2 x [2 x %struct.s3]]* %s3, i64 0, i64 0, !dbg !60
  %arrayidx1 = getelementptr inbounds [2 x %struct.s3], [2 x %struct.s3]* %arrayidx, i64 0, i64 1, !dbg !60
  %t1 = getelementptr inbounds %struct.s3, %struct.s3* %arrayidx1, i32 0, i32 2, !dbg !61
  store i8* %call, i8** %t1, align 8, !dbg !62
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !63
  store %struct.s2* %s2, %struct.s2** %s22, align 8, !dbg !64
  %s23 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !65
  %0 = load %struct.s2*, %struct.s2** %s23, align 8, !dbg !65
  call void @foo(%struct.s2* %0), !dbg !66
  ret i32 0, !dbg !67
}

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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-random-5")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 23, type: !8, isLocal: false, isDefinition: true, scopeLine: 24, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 11, size: 832, elements: !12)
!12 = !{!13, !16}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !11, file: !1, line: 12, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !11, file: !1, line: 13, baseType: !17, size: 768, offset: 64)
!17 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 768, elements: !25)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 5, size: 192, elements: !19)
!19 = !{!20, !23, !24}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !18, file: !1, line: 6, baseType: !21, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !18, file: !1, line: 7, baseType: !21, size: 64, offset: 64)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !18, file: !1, line: 8, baseType: !14, size: 64, offset: 128)
!25 = !{!26, !26}
!26 = !DISubrange(count: 2)
!27 = !DILocalVariable(name: "s2", arg: 1, scope: !7, file: !1, line: 23, type: !10)
!28 = !DIExpression()
!29 = !DILocation(line: 23, column: 16, scope: !7)
!30 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 25, type: !14)
!31 = !DILocation(line: 25, column: 11, scope: !7)
!32 = !DILocation(line: 25, column: 16, scope: !7)
!33 = !DILocation(line: 25, column: 20, scope: !7)
!34 = !DILocation(line: 25, column: 29, scope: !7)
!35 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 26, type: !21)
!36 = !DILocation(line: 26, column: 10, scope: !7)
!37 = !DILocation(line: 26, column: 16, scope: !7)
!38 = !DILocation(line: 26, column: 20, scope: !7)
!39 = !DILocation(line: 26, column: 29, scope: !7)
!40 = !DILocalVariable(name: "ut2", scope: !7, file: !1, line: 27, type: !14)
!41 = !DILocation(line: 27, column: 11, scope: !7)
!42 = !DILocation(line: 27, column: 17, scope: !7)
!43 = !DILocation(line: 27, column: 21, scope: !7)
!44 = !DILocation(line: 27, column: 30, scope: !7)
!45 = !DILocation(line: 28, column: 1, scope: !7)
!46 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 31, type: !47, isLocal: false, isDefinition: true, scopeLine: 32, isOptimized: false, unit: !0, variables: !2)
!47 = !DISubroutineType(types: !48)
!48 = !{!22}
!49 = !DILocalVariable(name: "s1", scope: !46, file: !1, line: 33, type: !50)
!50 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 16, size: 128, elements: !51)
!51 = !{!52, !53, !54}
!52 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !50, file: !1, line: 17, baseType: !22, size: 32)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !50, file: !1, line: 18, baseType: !22, size: 32, offset: 32)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !50, file: !1, line: 19, baseType: !10, size: 64, offset: 64)
!55 = !DILocation(line: 33, column: 15, scope: !46)
!56 = !DILocalVariable(name: "s2", scope: !46, file: !1, line: 34, type: !11)
!57 = !DILocation(line: 34, column: 15, scope: !46)
!58 = !DILocation(line: 36, column: 22, scope: !46)
!59 = !DILocation(line: 36, column: 8, scope: !46)
!60 = !DILocation(line: 36, column: 5, scope: !46)
!61 = !DILocation(line: 36, column: 17, scope: !46)
!62 = !DILocation(line: 36, column: 20, scope: !46)
!63 = !DILocation(line: 37, column: 8, scope: !46)
!64 = !DILocation(line: 37, column: 11, scope: !46)
!65 = !DILocation(line: 39, column: 12, scope: !46)
!66 = !DILocation(line: 39, column: 5, scope: !46)
!67 = !DILocation(line: 41, column: 5, scope: !46)
