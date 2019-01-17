; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %struct.s2 }
%struct.s2 = type { i32, i8*, %struct.s3 }
%struct.s3 = type { i32, i32, i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s11 = alloca %struct.s1, align 8
  %s12 = alloca %struct.s1, align 8
  %t1 = alloca i8*, align 8
  %s24 = alloca %struct.s2, align 8
  %t2 = alloca i8*, align 8
  %s38 = alloca %struct.s3, align 8
  %t311 = alloca i8*, align 8
  %t4 = alloca i8*, align 8
  %t5 = alloca i8*, align 8
  %s13 = alloca %struct.s1, align 8
  %t6 = alloca i8*, align 8
  %nt1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s11, metadata !11, metadata !29), !dbg !30
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !31
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s11, i32 0, i32 1, !dbg !32
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !33
  %t3 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 3, !dbg !34
  store i8* %call, i8** %t3, align 8, !dbg !35
  call void @llvm.dbg.declare(metadata %struct.s1* %s12, metadata !36, metadata !29), !dbg !37
  %0 = bitcast %struct.s1* %s12 to i8*, !dbg !38
  %1 = bitcast %struct.s1* %s11 to i8*, !dbg !38
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 1024, i32 8, i1 false), !dbg !38
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !39, metadata !29), !dbg !40
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s12, i32 0, i32 1, !dbg !41
  %s32 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 2, !dbg !42
  %t33 = getelementptr inbounds %struct.s3, %struct.s3* %s32, i32 0, i32 3, !dbg !43
  %2 = load i8*, i8** %t33, align 8, !dbg !43
  store i8* %2, i8** %t1, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata %struct.s2* %s24, metadata !44, metadata !29), !dbg !45
  %3 = bitcast %struct.s2* %s24 to i8*, !dbg !46
  %s25 = getelementptr inbounds %struct.s1, %struct.s1* %s11, i32 0, i32 1, !dbg !47
  %4 = bitcast %struct.s2* %s25 to i8*, !dbg !46
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %4, i64 1024, i32 8, i1 false), !dbg !46
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !48, metadata !29), !dbg !49
  %s36 = getelementptr inbounds %struct.s2, %struct.s2* %s24, i32 0, i32 2, !dbg !50
  %t37 = getelementptr inbounds %struct.s3, %struct.s3* %s36, i32 0, i32 3, !dbg !51
  %5 = load i8*, i8** %t37, align 8, !dbg !51
  store i8* %5, i8** %t2, align 8, !dbg !49
  call void @llvm.dbg.declare(metadata %struct.s3* %s38, metadata !52, metadata !29), !dbg !53
  %6 = bitcast %struct.s3* %s38 to i8*, !dbg !54
  %s29 = getelementptr inbounds %struct.s1, %struct.s1* %s11, i32 0, i32 1, !dbg !55
  %s310 = getelementptr inbounds %struct.s2, %struct.s2* %s29, i32 0, i32 2, !dbg !56
  %7 = bitcast %struct.s3* %s310 to i8*, !dbg !54
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* %7, i64 1024, i32 8, i1 false), !dbg !54
  call void @llvm.dbg.declare(metadata i8** %t311, metadata !57, metadata !29), !dbg !58
  %t312 = getelementptr inbounds %struct.s3, %struct.s3* %s38, i32 0, i32 3, !dbg !59
  %8 = load i8*, i8** %t312, align 8, !dbg !59
  store i8* %8, i8** %t311, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata i8** %t4, metadata !60, metadata !29), !dbg !61
  %9 = bitcast i8** %t4 to i8*, !dbg !62
  %s213 = getelementptr inbounds %struct.s1, %struct.s1* %s11, i32 0, i32 1, !dbg !63
  %s314 = getelementptr inbounds %struct.s2, %struct.s2* %s213, i32 0, i32 2, !dbg !64
  %t315 = getelementptr inbounds %struct.s3, %struct.s3* %s314, i32 0, i32 3, !dbg !65
  %10 = bitcast i8** %t315 to i8*, !dbg !62
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %9, i8* %10, i64 1024, i32 8, i1 false), !dbg !62
  call void @llvm.dbg.declare(metadata i8** %t5, metadata !66, metadata !29), !dbg !67
  %11 = load i8*, i8** %t4, align 8, !dbg !68
  store i8* %11, i8** %t5, align 8, !dbg !67
  call void @llvm.dbg.declare(metadata %struct.s1* %s13, metadata !69, metadata !29), !dbg !70
  %s216 = getelementptr inbounds %struct.s1, %struct.s1* %s13, i32 0, i32 1, !dbg !71
  %t217 = getelementptr inbounds %struct.s2, %struct.s2* %s216, i32 0, i32 1, !dbg !72
  %12 = bitcast i8** %t217 to i8*, !dbg !73
  %s218 = getelementptr inbounds %struct.s1, %struct.s1* %s11, i32 0, i32 1, !dbg !74
  %s319 = getelementptr inbounds %struct.s2, %struct.s2* %s218, i32 0, i32 2, !dbg !75
  %t320 = getelementptr inbounds %struct.s3, %struct.s3* %s319, i32 0, i32 3, !dbg !76
  %13 = bitcast i8** %t320 to i8*, !dbg !73
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* %13, i64 1024, i32 8, i1 false), !dbg !73
  call void @llvm.dbg.declare(metadata i8** %t6, metadata !77, metadata !29), !dbg !78
  %s221 = getelementptr inbounds %struct.s1, %struct.s1* %s13, i32 0, i32 1, !dbg !79
  %t222 = getelementptr inbounds %struct.s2, %struct.s2* %s221, i32 0, i32 1, !dbg !80
  %14 = load i8*, i8** %t222, align 8, !dbg !80
  store i8* %14, i8** %t6, align 8, !dbg !78
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !81, metadata !29), !dbg !82
  %t123 = getelementptr inbounds %struct.s1, %struct.s1* %s13, i32 0, i32 0, !dbg !83
  %15 = load i8*, i8** %t123, align 8, !dbg !83
  store i8* %15, i8** %nt1, align 8, !dbg !82
  ret i32 0, !dbg !84
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/121-memcpy-6")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 26, type: !8, isLocal: false, isDefinition: true, scopeLine: 27, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s11", scope: !7, file: !1, line: 28, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 20, size: 384, elements: !13)
!13 = !{!14, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !12, file: !1, line: 21, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !12, file: !1, line: 22, baseType: !18, size: 320, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 14, size: 320, elements: !19)
!19 = !{!20, !21, !22}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !18, file: !1, line: 15, baseType: !10, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !18, file: !1, line: 16, baseType: !15, size: 64, offset: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !18, file: !1, line: 17, baseType: !23, size: 192, offset: 128)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 7, size: 192, elements: !24)
!24 = !{!25, !26, !27, !28}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !23, file: !1, line: 8, baseType: !10, size: 32)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "i2", scope: !23, file: !1, line: 9, baseType: !10, size: 32, offset: 32)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "i3", scope: !23, file: !1, line: 10, baseType: !10, size: 32, offset: 64)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "t3", scope: !23, file: !1, line: 11, baseType: !15, size: 64, offset: 128)
!29 = !DIExpression()
!30 = !DILocation(line: 28, column: 15, scope: !7)
!31 = !DILocation(line: 29, column: 20, scope: !7)
!32 = !DILocation(line: 29, column: 9, scope: !7)
!33 = !DILocation(line: 29, column: 12, scope: !7)
!34 = !DILocation(line: 29, column: 15, scope: !7)
!35 = !DILocation(line: 29, column: 18, scope: !7)
!36 = !DILocalVariable(name: "s12", scope: !7, file: !1, line: 31, type: !12)
!37 = !DILocation(line: 31, column: 15, scope: !7)
!38 = !DILocation(line: 32, column: 5, scope: !7)
!39 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 34, type: !15)
!40 = !DILocation(line: 34, column: 11, scope: !7)
!41 = !DILocation(line: 34, column: 20, scope: !7)
!42 = !DILocation(line: 34, column: 23, scope: !7)
!43 = !DILocation(line: 34, column: 26, scope: !7)
!44 = !DILocalVariable(name: "s2", scope: !7, file: !1, line: 36, type: !18)
!45 = !DILocation(line: 36, column: 15, scope: !7)
!46 = !DILocation(line: 37, column: 5, scope: !7)
!47 = !DILocation(line: 37, column: 22, scope: !7)
!48 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 39, type: !15)
!49 = !DILocation(line: 39, column: 11, scope: !7)
!50 = !DILocation(line: 39, column: 19, scope: !7)
!51 = !DILocation(line: 39, column: 22, scope: !7)
!52 = !DILocalVariable(name: "s3", scope: !7, file: !1, line: 41, type: !23)
!53 = !DILocation(line: 41, column: 15, scope: !7)
!54 = !DILocation(line: 42, column: 5, scope: !7)
!55 = !DILocation(line: 42, column: 22, scope: !7)
!56 = !DILocation(line: 42, column: 25, scope: !7)
!57 = !DILocalVariable(name: "t3", scope: !7, file: !1, line: 44, type: !15)
!58 = !DILocation(line: 44, column: 11, scope: !7)
!59 = !DILocation(line: 44, column: 19, scope: !7)
!60 = !DILocalVariable(name: "t4", scope: !7, file: !1, line: 46, type: !15)
!61 = !DILocation(line: 46, column: 11, scope: !7)
!62 = !DILocation(line: 47, column: 5, scope: !7)
!63 = !DILocation(line: 47, column: 22, scope: !7)
!64 = !DILocation(line: 47, column: 25, scope: !7)
!65 = !DILocation(line: 47, column: 28, scope: !7)
!66 = !DILocalVariable(name: "t5", scope: !7, file: !1, line: 49, type: !15)
!67 = !DILocation(line: 49, column: 11, scope: !7)
!68 = !DILocation(line: 49, column: 16, scope: !7)
!69 = !DILocalVariable(name: "s13", scope: !7, file: !1, line: 51, type: !12)
!70 = !DILocation(line: 51, column: 15, scope: !7)
!71 = !DILocation(line: 52, column: 17, scope: !7)
!72 = !DILocation(line: 52, column: 20, scope: !7)
!73 = !DILocation(line: 52, column: 5, scope: !7)
!74 = !DILocation(line: 52, column: 29, scope: !7)
!75 = !DILocation(line: 52, column: 32, scope: !7)
!76 = !DILocation(line: 52, column: 35, scope: !7)
!77 = !DILocalVariable(name: "t6", scope: !7, file: !1, line: 53, type: !15)
!78 = !DILocation(line: 53, column: 11, scope: !7)
!79 = !DILocation(line: 53, column: 20, scope: !7)
!80 = !DILocation(line: 53, column: 23, scope: !7)
!81 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 54, type: !15)
!82 = !DILocation(line: 54, column: 11, scope: !7)
!83 = !DILocation(line: 54, column: 21, scope: !7)
!84 = !DILocation(line: 56, column: 5, scope: !7)
