; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %struct.s2 }
%struct.s2 = type { i32, i8*, %struct.s3 }
%struct.s3 = type { i32, i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %s31 = alloca %struct.s3, align 8
  %t1 = alloca i8*, align 8
  %s328 = alloca %struct.s3, align 8
  %nt1 = alloca i8*, align 8
  %s2110 = alloca %struct.s2*, align 8
  %t212 = alloca i8*, align 8
  %t315 = alloca i8*, align 8
  %nt2 = alloca i32, align 4
  %s22 = alloca %struct.s2**, align 8
  %t4 = alloca i8*, align 8
  %t5 = alloca i8*, align 8
  %nt3 = alloca i8*, align 8
  %nt4 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !11, metadata !28), !dbg !29
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !30
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !31
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !32
  %t3 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 2, !dbg !33
  store i8* %call, i8** %t3, align 8, !dbg !34
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !35
  %s32 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 2, !dbg !36
  %t33 = getelementptr inbounds %struct.s3, %struct.s3* %s32, i32 0, i32 2, !dbg !37
  %0 = load i8*, i8** %t33, align 8, !dbg !37
  %s24 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !38
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s24, i32 0, i32 1, !dbg !39
  store i8* %0, i8** %t2, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata %struct.s3* %s31, metadata !41, metadata !28), !dbg !42
  %s25 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !43
  %s36 = getelementptr inbounds %struct.s2, %struct.s2* %s25, i32 0, i32 2, !dbg !44
  %1 = bitcast %struct.s3* %s31 to i8*, !dbg !44
  %2 = bitcast %struct.s3* %s36 to i8*, !dbg !44
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %2, i64 16, i32 8, i1 false), !dbg !44
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !45, metadata !28), !dbg !46
  %t37 = getelementptr inbounds %struct.s3, %struct.s3* %s31, i32 0, i32 2, !dbg !47
  %3 = load i8*, i8** %t37, align 8, !dbg !47
  store i8* %3, i8** %t1, align 8, !dbg !46
  call void @llvm.dbg.declare(metadata %struct.s3* %s328, metadata !48, metadata !28), !dbg !49
  %4 = bitcast %struct.s3* %s31 to i8*, !dbg !50
  %5 = bitcast %struct.s3* %s328 to i8*, !dbg !50
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %4, i8* %5, i64 16, i32 8, i1 false), !dbg !50
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !51, metadata !28), !dbg !52
  %t39 = getelementptr inbounds %struct.s3, %struct.s3* %s31, i32 0, i32 2, !dbg !53
  %6 = load i8*, i8** %t39, align 8, !dbg !53
  store i8* %6, i8** %nt1, align 8, !dbg !52
  call void @llvm.dbg.declare(metadata %struct.s2** %s2110, metadata !54, metadata !28), !dbg !56
  %s211 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !57
  store %struct.s2* %s211, %struct.s2** %s2110, align 8, !dbg !56
  call void @llvm.dbg.declare(metadata i8** %t212, metadata !58, metadata !28), !dbg !59
  %7 = load %struct.s2*, %struct.s2** %s2110, align 8, !dbg !60
  %s313 = getelementptr inbounds %struct.s2, %struct.s2* %7, i32 0, i32 2, !dbg !61
  %t314 = getelementptr inbounds %struct.s3, %struct.s3* %s313, i32 0, i32 2, !dbg !62
  %8 = load i8*, i8** %t314, align 8, !dbg !62
  store i8* %8, i8** %t212, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata i8** %t315, metadata !63, metadata !28), !dbg !64
  %9 = load %struct.s2*, %struct.s2** %s2110, align 8, !dbg !65
  %t216 = getelementptr inbounds %struct.s2, %struct.s2* %9, i32 0, i32 1, !dbg !66
  %10 = load i8*, i8** %t216, align 8, !dbg !66
  store i8* %10, i8** %t315, align 8, !dbg !64
  call void @llvm.dbg.declare(metadata i32* %nt2, metadata !67, metadata !28), !dbg !68
  %11 = load %struct.s2*, %struct.s2** %s2110, align 8, !dbg !69
  %i1 = getelementptr inbounds %struct.s2, %struct.s2* %11, i32 0, i32 0, !dbg !70
  %12 = load i32, i32* %i1, align 8, !dbg !70
  store i32 %12, i32* %nt2, align 4, !dbg !68
  call void @llvm.dbg.declare(metadata %struct.s2*** %s22, metadata !71, metadata !28), !dbg !73
  store %struct.s2** %s2110, %struct.s2*** %s22, align 8, !dbg !73
  call void @llvm.dbg.declare(metadata i8** %t4, metadata !74, metadata !28), !dbg !75
  %13 = load %struct.s2**, %struct.s2*** %s22, align 8, !dbg !76
  %14 = load %struct.s2*, %struct.s2** %13, align 8, !dbg !77
  %s317 = getelementptr inbounds %struct.s2, %struct.s2* %14, i32 0, i32 2, !dbg !78
  %t318 = getelementptr inbounds %struct.s3, %struct.s3* %s317, i32 0, i32 2, !dbg !79
  %15 = load i8*, i8** %t318, align 8, !dbg !79
  store i8* %15, i8** %t4, align 8, !dbg !75
  call void @llvm.dbg.declare(metadata i8** %t5, metadata !80, metadata !28), !dbg !81
  %16 = load %struct.s2**, %struct.s2*** %s22, align 8, !dbg !82
  %17 = load %struct.s2*, %struct.s2** %16, align 8, !dbg !83
  %t219 = getelementptr inbounds %struct.s2, %struct.s2* %17, i32 0, i32 1, !dbg !84
  %18 = load i8*, i8** %t219, align 8, !dbg !84
  store i8* %18, i8** %t5, align 8, !dbg !81
  %19 = load %struct.s2**, %struct.s2*** %s22, align 8, !dbg !85
  store %struct.s2* null, %struct.s2** %19, align 8, !dbg !86
  call void @llvm.dbg.declare(metadata i8** %nt3, metadata !87, metadata !28), !dbg !88
  %20 = load %struct.s2**, %struct.s2*** %s22, align 8, !dbg !89
  %21 = load %struct.s2*, %struct.s2** %20, align 8, !dbg !90
  %s320 = getelementptr inbounds %struct.s2, %struct.s2* %21, i32 0, i32 2, !dbg !91
  %t321 = getelementptr inbounds %struct.s3, %struct.s3* %s320, i32 0, i32 2, !dbg !92
  %22 = load i8*, i8** %t321, align 8, !dbg !92
  store i8* %22, i8** %nt3, align 8, !dbg !88
  call void @llvm.dbg.declare(metadata i8** %nt4, metadata !93, metadata !28), !dbg !94
  %23 = load %struct.s2**, %struct.s2*** %s22, align 8, !dbg !95
  %24 = load %struct.s2*, %struct.s2** %23, align 8, !dbg !96
  %t222 = getelementptr inbounds %struct.s2, %struct.s2* %24, i32 0, i32 1, !dbg !97
  %25 = load i8*, i8** %t222, align 8, !dbg !97
  store i8* %25, i8** %nt4, align 8, !dbg !94
  ret i32 0, !dbg !98
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
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/151-ptr-6")
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
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 19, size: 320, elements: !13)
!13 = !{!14, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !12, file: !1, line: 20, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !12, file: !1, line: 21, baseType: !18, size: 256, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 13, size: 256, elements: !19)
!19 = !{!20, !21, !22}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !18, file: !1, line: 14, baseType: !10, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !18, file: !1, line: 15, baseType: !15, size: 64, offset: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !18, file: !1, line: 16, baseType: !23, size: 128, offset: 128)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 7, size: 128, elements: !24)
!24 = !{!25, !26, !27}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !23, file: !1, line: 8, baseType: !10, size: 32)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "i2", scope: !23, file: !1, line: 9, baseType: !10, size: 32, offset: 32)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "t3", scope: !23, file: !1, line: 10, baseType: !15, size: 64, offset: 64)
!28 = !DIExpression()
!29 = !DILocation(line: 27, column: 15, scope: !7)
!30 = !DILocation(line: 28, column: 19, scope: !7)
!31 = !DILocation(line: 28, column: 8, scope: !7)
!32 = !DILocation(line: 28, column: 11, scope: !7)
!33 = !DILocation(line: 28, column: 14, scope: !7)
!34 = !DILocation(line: 28, column: 17, scope: !7)
!35 = !DILocation(line: 29, column: 19, scope: !7)
!36 = !DILocation(line: 29, column: 22, scope: !7)
!37 = !DILocation(line: 29, column: 25, scope: !7)
!38 = !DILocation(line: 29, column: 8, scope: !7)
!39 = !DILocation(line: 29, column: 11, scope: !7)
!40 = !DILocation(line: 29, column: 14, scope: !7)
!41 = !DILocalVariable(name: "s31", scope: !7, file: !1, line: 31, type: !23)
!42 = !DILocation(line: 31, column: 15, scope: !7)
!43 = !DILocation(line: 31, column: 24, scope: !7)
!44 = !DILocation(line: 31, column: 27, scope: !7)
!45 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 32, type: !15)
!46 = !DILocation(line: 32, column: 11, scope: !7)
!47 = !DILocation(line: 32, column: 20, scope: !7)
!48 = !DILocalVariable(name: "s32", scope: !7, file: !1, line: 34, type: !23)
!49 = !DILocation(line: 34, column: 15, scope: !7)
!50 = !DILocation(line: 35, column: 11, scope: !7)
!51 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 37, type: !15)
!52 = !DILocation(line: 37, column: 11, scope: !7)
!53 = !DILocation(line: 37, column: 21, scope: !7)
!54 = !DILocalVariable(name: "s21", scope: !7, file: !1, line: 39, type: !55)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!56 = !DILocation(line: 39, column: 16, scope: !7)
!57 = !DILocation(line: 39, column: 26, scope: !7)
!58 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 40, type: !15)
!59 = !DILocation(line: 40, column: 11, scope: !7)
!60 = !DILocation(line: 40, column: 16, scope: !7)
!61 = !DILocation(line: 40, column: 21, scope: !7)
!62 = !DILocation(line: 40, column: 24, scope: !7)
!63 = !DILocalVariable(name: "t3", scope: !7, file: !1, line: 41, type: !15)
!64 = !DILocation(line: 41, column: 11, scope: !7)
!65 = !DILocation(line: 41, column: 16, scope: !7)
!66 = !DILocation(line: 41, column: 21, scope: !7)
!67 = !DILocalVariable(name: "nt2", scope: !7, file: !1, line: 43, type: !10)
!68 = !DILocation(line: 43, column: 9, scope: !7)
!69 = !DILocation(line: 43, column: 15, scope: !7)
!70 = !DILocation(line: 43, column: 20, scope: !7)
!71 = !DILocalVariable(name: "s22", scope: !7, file: !1, line: 45, type: !72)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!73 = !DILocation(line: 45, column: 17, scope: !7)
!74 = !DILocalVariable(name: "t4", scope: !7, file: !1, line: 46, type: !15)
!75 = !DILocation(line: 46, column: 11, scope: !7)
!76 = !DILocation(line: 46, column: 18, scope: !7)
!77 = !DILocation(line: 46, column: 17, scope: !7)
!78 = !DILocation(line: 46, column: 24, scope: !7)
!79 = !DILocation(line: 46, column: 27, scope: !7)
!80 = !DILocalVariable(name: "t5", scope: !7, file: !1, line: 47, type: !15)
!81 = !DILocation(line: 47, column: 11, scope: !7)
!82 = !DILocation(line: 47, column: 18, scope: !7)
!83 = !DILocation(line: 47, column: 17, scope: !7)
!84 = !DILocation(line: 47, column: 24, scope: !7)
!85 = !DILocation(line: 49, column: 6, scope: !7)
!86 = !DILocation(line: 49, column: 10, scope: !7)
!87 = !DILocalVariable(name: "nt3", scope: !7, file: !1, line: 50, type: !15)
!88 = !DILocation(line: 50, column: 11, scope: !7)
!89 = !DILocation(line: 50, column: 19, scope: !7)
!90 = !DILocation(line: 50, column: 18, scope: !7)
!91 = !DILocation(line: 50, column: 25, scope: !7)
!92 = !DILocation(line: 50, column: 28, scope: !7)
!93 = !DILocalVariable(name: "nt4", scope: !7, file: !1, line: 51, type: !15)
!94 = !DILocation(line: 51, column: 11, scope: !7)
!95 = !DILocation(line: 51, column: 19, scope: !7)
!96 = !DILocation(line: 51, column: 18, scope: !7)
!97 = !DILocation(line: 51, column: 25, scope: !7)
!98 = !DILocation(line: 53, column: 5, scope: !7)
