; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { %struct.s2, i8* }
%struct.s2 = type { i8*, i32, i32, %struct.s3 }
%struct.s3 = type { %struct.s4, i32 }
%struct.s4 = type { i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@gs1 = common global %struct.s1 zeroinitializer, align 8, !dbg !0
@gs2 = common global %struct.s2 zeroinitializer, align 8, !dbg !6
@gs3 = common global %struct.s3 zeroinitializer, align 8, !dbg !24
@gs4 = common global %struct.s4 zeroinitializer, align 8, !dbg !26
@.str.1 = private unnamed_addr constant [5 x i8] c"nope\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !36 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %t1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %t3 = alloca i8*, align 8
  %t4 = alloca i8*, align 8
  %t5 = alloca i8*, align 8
  %s412 = alloca %struct.s4, align 8
  %nt = alloca i8*, align 8
  %t6 = alloca i8*, align 8
  %nt2 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !39, metadata !40), !dbg !41
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !42
  %s = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !43
  %s2 = getelementptr inbounds %struct.s2, %struct.s2* %s, i32 0, i32 3, !dbg !44
  %s3 = getelementptr inbounds %struct.s3, %struct.s3* %s2, i32 0, i32 0, !dbg !45
  %t = getelementptr inbounds %struct.s4, %struct.s4* %s3, i32 0, i32 0, !dbg !46
  store i8* %call, i8** %t, align 8, !dbg !47
  %0 = bitcast %struct.s1* %s1 to i8*, !dbg !48
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.s1* @gs1 to i8*), i8* %0, i64 40, i32 8, i1 false), !dbg !48
  %s4 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !49
  %1 = bitcast %struct.s2* %s4 to i8*, !dbg !49
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.s2* @gs2 to i8*), i8* %1, i64 32, i32 8, i1 false), !dbg !49
  %s5 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !50
  %s6 = getelementptr inbounds %struct.s2, %struct.s2* %s5, i32 0, i32 3, !dbg !51
  %2 = bitcast %struct.s3* %s6 to i8*, !dbg !51
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.s3* @gs3 to i8*), i8* %2, i64 16, i32 8, i1 false), !dbg !51
  %s7 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !52
  %s8 = getelementptr inbounds %struct.s2, %struct.s2* %s7, i32 0, i32 3, !dbg !53
  %s9 = getelementptr inbounds %struct.s3, %struct.s3* %s8, i32 0, i32 0, !dbg !54
  %3 = bitcast %struct.s4* %s9 to i8*, !dbg !54
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.s4* @gs4 to i8*), i8* %3, i64 8, i32 8, i1 false), !dbg !54
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !55, metadata !40), !dbg !56
  %4 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 0, i32 3, i32 0, i32 0), align 8, !dbg !57
  store i8* %4, i8** %t1, align 8, !dbg !56
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !58, metadata !40), !dbg !59
  %5 = load i8*, i8** getelementptr inbounds (%struct.s2, %struct.s2* @gs2, i32 0, i32 3, i32 0, i32 0), align 8, !dbg !60
  store i8* %5, i8** %t2, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !61, metadata !40), !dbg !62
  %6 = load i8*, i8** getelementptr inbounds (%struct.s3, %struct.s3* @gs3, i32 0, i32 0, i32 0), align 8, !dbg !63
  store i8* %6, i8** %t3, align 8, !dbg !62
  call void @llvm.dbg.declare(metadata i8** %t4, metadata !64, metadata !40), !dbg !65
  %7 = load i8*, i8** getelementptr inbounds (%struct.s4, %struct.s4* @gs4, i32 0, i32 0), align 8, !dbg !66
  store i8* %7, i8** %t4, align 8, !dbg !65
  %s10 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !67
  %s11 = getelementptr inbounds %struct.s2, %struct.s2* %s10, i32 0, i32 3, !dbg !68
  %8 = bitcast %struct.s3* %s11 to i8*, !dbg !68
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.s3* getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 0, i32 3) to i8*), i8* %8, i64 16, i32 8, i1 false), !dbg !68
  call void @llvm.dbg.declare(metadata i8** %t5, metadata !69, metadata !40), !dbg !70
  %9 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 0, i32 3, i32 0, i32 0), align 8, !dbg !71
  store i8* %9, i8** %t5, align 8, !dbg !70
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i8** getelementptr inbounds (%struct.s3, %struct.s3* @gs3, i32 0, i32 0, i32 0), align 8, !dbg !72
  call void @llvm.dbg.declare(metadata %struct.s4* %s412, metadata !73, metadata !40), !dbg !74
  %10 = bitcast %struct.s4* %s412 to i8*, !dbg !75
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %10, i8* bitcast (%struct.s3* @gs3 to i8*), i64 8, i32 8, i1 false), !dbg !75
  call void @llvm.dbg.declare(metadata i8** %nt, metadata !76, metadata !40), !dbg !77
  %t13 = getelementptr inbounds %struct.s4, %struct.s4* %s412, i32 0, i32 0, !dbg !78
  %11 = load i8*, i8** %t13, align 8, !dbg !78
  store i8* %11, i8** %nt, align 8, !dbg !77
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.s3* getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 0, i32 3) to i8*), i8* bitcast (%struct.s3* getelementptr inbounds (%struct.s2, %struct.s2* @gs2, i32 0, i32 3) to i8*), i64 16, i32 8, i1 false), !dbg !79
  call void @llvm.dbg.declare(metadata i8** %t6, metadata !80, metadata !40), !dbg !81
  %12 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 0, i32 3, i32 0, i32 0), align 8, !dbg !82
  store i8* %12, i8** %t6, align 8, !dbg !81
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.s3* getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 0, i32 3) to i8*), i8* bitcast (%struct.s3* @gs3 to i8*), i64 16, i32 8, i1 false), !dbg !83
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !84, metadata !40), !dbg !85
  %13 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 0, i32 3, i32 0, i32 0), align 8, !dbg !86
  store i8* %13, i8** %nt2, align 8, !dbg !85
  ret i32 0, !dbg !87
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

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!32, !33, !34}
!llvm.ident = !{!35}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "gs1", scope: !2, file: !3, line: 26, type: !28, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-6")
!4 = !{}
!5 = !{!0, !6, !24, !26}
!6 = !DIGlobalVariableExpression(var: !7)
!7 = distinct !DIGlobalVariable(name: "gs2", scope: !2, file: !3, line: 27, type: !8, isLocal: false, isDefinition: true)
!8 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !3, line: 14, size: 256, elements: !9)
!9 = !{!10, !13, !15, !16}
!10 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !8, file: !3, line: 15, baseType: !11, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!13 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !8, file: !3, line: 16, baseType: !14, size: 32, offset: 64)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !8, file: !3, line: 17, baseType: !14, size: 32, offset: 96)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !8, file: !3, line: 18, baseType: !17, size: 128, offset: 128)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !3, line: 9, size: 128, elements: !18)
!18 = !{!19, !23}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !17, file: !3, line: 10, baseType: !20, size: 64)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s4", file: !3, line: 5, size: 64, elements: !21)
!21 = !{!22}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !20, file: !3, line: 6, baseType: !11, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !17, file: !3, line: 11, baseType: !14, size: 32, offset: 64)
!24 = !DIGlobalVariableExpression(var: !25)
!25 = distinct !DIGlobalVariable(name: "gs3", scope: !2, file: !3, line: 28, type: !17, isLocal: false, isDefinition: true)
!26 = !DIGlobalVariableExpression(var: !27)
!27 = distinct !DIGlobalVariable(name: "gs4", scope: !2, file: !3, line: 29, type: !20, isLocal: false, isDefinition: true)
!28 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !3, line: 21, size: 320, elements: !29)
!29 = !{!30, !31}
!30 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !28, file: !3, line: 22, baseType: !8, size: 256)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !28, file: !3, line: 23, baseType: !11, size: 64, offset: 256)
!32 = !{i32 2, !"Dwarf Version", i32 4}
!33 = !{i32 2, !"Debug Info Version", i32 3}
!34 = !{i32 1, !"wchar_size", i32 4}
!35 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!36 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 32, type: !37, isLocal: false, isDefinition: true, scopeLine: 32, isOptimized: false, unit: !2, variables: !4)
!37 = !DISubroutineType(types: !38)
!38 = !{!14}
!39 = !DILocalVariable(name: "s1", scope: !36, file: !3, line: 33, type: !28)
!40 = !DIExpression()
!41 = !DILocation(line: 33, column: 15, scope: !36)
!42 = !DILocation(line: 34, column: 18, scope: !36)
!43 = !DILocation(line: 34, column: 8, scope: !36)
!44 = !DILocation(line: 34, column: 10, scope: !36)
!45 = !DILocation(line: 34, column: 12, scope: !36)
!46 = !DILocation(line: 34, column: 14, scope: !36)
!47 = !DILocation(line: 34, column: 16, scope: !36)
!48 = !DILocation(line: 36, column: 11, scope: !36)
!49 = !DILocation(line: 37, column: 14, scope: !36)
!50 = !DILocation(line: 38, column: 14, scope: !36)
!51 = !DILocation(line: 38, column: 16, scope: !36)
!52 = !DILocation(line: 39, column: 14, scope: !36)
!53 = !DILocation(line: 39, column: 16, scope: !36)
!54 = !DILocation(line: 39, column: 18, scope: !36)
!55 = !DILocalVariable(name: "t1", scope: !36, file: !3, line: 41, type: !11)
!56 = !DILocation(line: 41, column: 11, scope: !36)
!57 = !DILocation(line: 41, column: 26, scope: !36)
!58 = !DILocalVariable(name: "t2", scope: !36, file: !3, line: 42, type: !11)
!59 = !DILocation(line: 42, column: 11, scope: !36)
!60 = !DILocation(line: 42, column: 24, scope: !36)
!61 = !DILocalVariable(name: "t3", scope: !36, file: !3, line: 43, type: !11)
!62 = !DILocation(line: 43, column: 11, scope: !36)
!63 = !DILocation(line: 43, column: 22, scope: !36)
!64 = !DILocalVariable(name: "t4", scope: !36, file: !3, line: 44, type: !11)
!65 = !DILocation(line: 44, column: 11, scope: !36)
!66 = !DILocation(line: 44, column: 20, scope: !36)
!67 = !DILocation(line: 46, column: 18, scope: !36)
!68 = !DILocation(line: 46, column: 20, scope: !36)
!69 = !DILocalVariable(name: "t5", scope: !36, file: !3, line: 47, type: !11)
!70 = !DILocation(line: 47, column: 11, scope: !36)
!71 = !DILocation(line: 47, column: 26, scope: !36)
!72 = !DILocation(line: 49, column: 13, scope: !36)
!73 = !DILocalVariable(name: "s4", scope: !36, file: !3, line: 51, type: !20)
!74 = !DILocation(line: 51, column: 15, scope: !36)
!75 = !DILocation(line: 51, column: 24, scope: !36)
!76 = !DILocalVariable(name: "nt", scope: !36, file: !3, line: 53, type: !11)
!77 = !DILocation(line: 53, column: 11, scope: !36)
!78 = !DILocation(line: 53, column: 19, scope: !36)
!79 = !DILocation(line: 55, column: 19, scope: !36)
!80 = !DILocalVariable(name: "t6", scope: !36, file: !3, line: 56, type: !11)
!81 = !DILocation(line: 56, column: 11, scope: !36)
!82 = !DILocation(line: 56, column: 26, scope: !36)
!83 = !DILocation(line: 58, column: 15, scope: !36)
!84 = !DILocalVariable(name: "nt2", scope: !36, file: !3, line: 59, type: !11)
!85 = !DILocation(line: 59, column: 11, scope: !36)
!86 = !DILocation(line: 59, column: 27, scope: !36)
!87 = !DILocation(line: 61, column: 5, scope: !36)
