; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %struct.s2* }
%struct.s2 = type { i32, i8*, %struct.s3, i8* }
%struct.s3 = type { i8* }

@gs1 = common global %struct.s1 zeroinitializer, align 8, !dbg !0
@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@gs2 = common global %struct.s2 zeroinitializer, align 8, !dbg !6
@gs3 = common global %struct.s3 zeroinitializer, align 8, !dbg !20
@.str.1 = private unnamed_addr constant [5 x i8] c"nope\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !31 {
entry:
  %retval = alloca i32, align 4
  %s2 = alloca %struct.s2*, align 8
  %t12 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %t3 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %t4 = alloca i8*, align 8
  %ut2 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s2** %s2, metadata !34, metadata !35), !dbg !36
  %call = call noalias i8* @malloc(i64 32) #4, !dbg !37
  %0 = bitcast i8* %call to %struct.s2*, !dbg !37
  store %struct.s2* %0, %struct.s2** %s2, align 8, !dbg !36
  %1 = load %struct.s2*, %struct.s2** %s2, align 8, !dbg !38
  %tobool = icmp ne %struct.s2* %1, null, !dbg !38
  br i1 %tobool, label %if.end, label %if.then, !dbg !40

if.then:                                          ; preds = %entry
  store i32 -1, i32* %retval, align 4, !dbg !41
  br label %return, !dbg !41

if.end:                                           ; preds = %entry
  %2 = load %struct.s2*, %struct.s2** %s2, align 8, !dbg !42
  store %struct.s2* %2, %struct.s2** getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 1), align 8, !dbg !43
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !44
  %3 = load %struct.s2*, %struct.s2** getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 1), align 8, !dbg !45
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %3, i32 0, i32 2, !dbg !46
  %t1 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 0, !dbg !47
  store i8* %call1, i8** %t1, align 8, !dbg !48
  %4 = load %struct.s2*, %struct.s2** getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 1), align 8, !dbg !49
  %5 = bitcast %struct.s2* %4 to i8*, !dbg !50
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.s2* @gs2 to i8*), i8* %5, i64 32, i32 8, i1 false), !dbg !50
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.s3* @gs3 to i8*), i8* bitcast (%struct.s3* getelementptr inbounds (%struct.s2, %struct.s2* @gs2, i32 0, i32 2) to i8*), i64 8, i32 8, i1 false), !dbg !51
  %6 = load %struct.s2*, %struct.s2** getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 1), align 8, !dbg !52
  %ut = getelementptr inbounds %struct.s2, %struct.s2* %6, i32 0, i32 3, !dbg !53
  %7 = load i8*, i8** %ut, align 8, !dbg !53
  store i8* %7, i8** getelementptr inbounds (%struct.s2, %struct.s2* @gs2, i32 0, i32 1), align 8, !dbg !54
  call void @llvm.dbg.declare(metadata i8** %t12, metadata !55, metadata !35), !dbg !56
  %8 = load i8*, i8** getelementptr inbounds (%struct.s3, %struct.s3* @gs3, i32 0, i32 0), align 8, !dbg !57
  store i8* %8, i8** %t12, align 8, !dbg !56
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !58, metadata !35), !dbg !59
  %9 = load i8*, i8** getelementptr inbounds (%struct.s2, %struct.s2* @gs2, i32 0, i32 2, i32 0), align 8, !dbg !60
  store i8* %9, i8** %t2, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !61, metadata !35), !dbg !62
  %10 = load %struct.s2*, %struct.s2** getelementptr inbounds (%struct.s1, %struct.s1* @gs1, i32 0, i32 1), align 8, !dbg !63
  %s33 = getelementptr inbounds %struct.s2, %struct.s2* %10, i32 0, i32 2, !dbg !64
  %t14 = getelementptr inbounds %struct.s3, %struct.s3* %s33, i32 0, i32 0, !dbg !65
  %11 = load i8*, i8** %t14, align 8, !dbg !65
  store i8* %11, i8** %t3, align 8, !dbg !62
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i8** getelementptr inbounds (%struct.s3, %struct.s3* @gs3, i32 0, i32 0), align 8, !dbg !66
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !67, metadata !35), !dbg !68
  %12 = load i8*, i8** getelementptr inbounds (%struct.s3, %struct.s3* @gs3, i32 0, i32 0), align 8, !dbg !69
  store i8* %12, i8** %ut1, align 8, !dbg !68
  call void @llvm.dbg.declare(metadata i8** %t4, metadata !70, metadata !35), !dbg !71
  %13 = load i8*, i8** getelementptr inbounds (%struct.s2, %struct.s2* @gs2, i32 0, i32 2, i32 0), align 8, !dbg !72
  store i8* %13, i8** %t4, align 8, !dbg !71
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i8** getelementptr inbounds (%struct.s2, %struct.s2* @gs2, i32 0, i32 2, i32 0), align 8, !dbg !73
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !74, metadata !35), !dbg !75
  %14 = load i8*, i8** getelementptr inbounds (%struct.s2, %struct.s2* @gs2, i32 0, i32 2, i32 0), align 8, !dbg !76
  store i8* %14, i8** %ut2, align 8, !dbg !75
  store i32 0, i32* %retval, align 4, !dbg !77
  br label %return, !dbg !77

return:                                           ; preds = %if.end, %if.then
  %15 = load i32, i32* %retval, align 4, !dbg !78
  ret i32 %15, !dbg !78
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

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
!llvm.module.flags = !{!27, !28, !29}
!llvm.ident = !{!30}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "gs1", scope: !2, file: !3, line: 21, type: !22, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-10")
!4 = !{}
!5 = !{!0, !6, !20}
!6 = !DIGlobalVariableExpression(var: !7)
!7 = distinct !DIGlobalVariable(name: "gs2", scope: !2, file: !3, line: 22, type: !8, isLocal: false, isDefinition: true)
!8 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !3, line: 9, size: 256, elements: !9)
!9 = !{!10, !12, !15, !19}
!10 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !8, file: !3, line: 10, baseType: !11, size: 32)
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !8, file: !3, line: 11, baseType: !13, size: 64, offset: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !8, file: !3, line: 12, baseType: !16, size: 64, offset: 128)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !3, line: 5, size: 64, elements: !17)
!17 = !{!18}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !16, file: !3, line: 6, baseType: !13, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "ut", scope: !8, file: !3, line: 13, baseType: !13, size: 64, offset: 192)
!20 = !DIGlobalVariableExpression(var: !21)
!21 = distinct !DIGlobalVariable(name: "gs3", scope: !2, file: !3, line: 23, type: !16, isLocal: false, isDefinition: true)
!22 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !3, line: 16, size: 128, elements: !23)
!23 = !{!24, !25}
!24 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !22, file: !3, line: 17, baseType: !13, size: 64)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !22, file: !3, line: 18, baseType: !26, size: 64, offset: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!27 = !{i32 2, !"Dwarf Version", i32 4}
!28 = !{i32 2, !"Debug Info Version", i32 3}
!29 = !{i32 1, !"wchar_size", i32 4}
!30 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!31 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 26, type: !32, isLocal: false, isDefinition: true, scopeLine: 26, isOptimized: false, unit: !2, variables: !4)
!32 = !DISubroutineType(types: !33)
!33 = !{!11}
!34 = !DILocalVariable(name: "s2", scope: !31, file: !3, line: 27, type: !26)
!35 = !DIExpression()
!36 = !DILocation(line: 27, column: 16, scope: !31)
!37 = !DILocation(line: 27, column: 21, scope: !31)
!38 = !DILocation(line: 28, column: 10, scope: !39)
!39 = distinct !DILexicalBlock(scope: !31, file: !3, line: 28, column: 9)
!40 = !DILocation(line: 28, column: 9, scope: !31)
!41 = !DILocation(line: 28, column: 14, scope: !39)
!42 = !DILocation(line: 30, column: 14, scope: !31)
!43 = !DILocation(line: 30, column: 12, scope: !31)
!44 = !DILocation(line: 32, column: 21, scope: !31)
!45 = !DILocation(line: 32, column: 9, scope: !31)
!46 = !DILocation(line: 32, column: 13, scope: !31)
!47 = !DILocation(line: 32, column: 16, scope: !31)
!48 = !DILocation(line: 32, column: 19, scope: !31)
!49 = !DILocation(line: 34, column: 16, scope: !31)
!50 = !DILocation(line: 34, column: 11, scope: !31)
!51 = !DILocation(line: 35, column: 15, scope: !31)
!52 = !DILocation(line: 37, column: 18, scope: !31)
!53 = !DILocation(line: 37, column: 22, scope: !31)
!54 = !DILocation(line: 37, column: 12, scope: !31)
!55 = !DILocalVariable(name: "t1", scope: !31, file: !3, line: 39, type: !13)
!56 = !DILocation(line: 39, column: 11, scope: !31)
!57 = !DILocation(line: 39, column: 20, scope: !31)
!58 = !DILocalVariable(name: "t2", scope: !31, file: !3, line: 40, type: !13)
!59 = !DILocation(line: 40, column: 11, scope: !31)
!60 = !DILocation(line: 40, column: 23, scope: !31)
!61 = !DILocalVariable(name: "t3", scope: !31, file: !3, line: 41, type: !13)
!62 = !DILocation(line: 41, column: 11, scope: !31)
!63 = !DILocation(line: 41, column: 20, scope: !31)
!64 = !DILocation(line: 41, column: 24, scope: !31)
!65 = !DILocation(line: 41, column: 27, scope: !31)
!66 = !DILocation(line: 43, column: 12, scope: !31)
!67 = !DILocalVariable(name: "ut1", scope: !31, file: !3, line: 44, type: !13)
!68 = !DILocation(line: 44, column: 11, scope: !31)
!69 = !DILocation(line: 44, column: 21, scope: !31)
!70 = !DILocalVariable(name: "t4", scope: !31, file: !3, line: 46, type: !13)
!71 = !DILocation(line: 46, column: 11, scope: !31)
!72 = !DILocation(line: 46, column: 23, scope: !31)
!73 = !DILocation(line: 47, column: 15, scope: !31)
!74 = !DILocalVariable(name: "ut2", scope: !31, file: !3, line: 49, type: !13)
!75 = !DILocation(line: 49, column: 11, scope: !31)
!76 = !DILocation(line: 49, column: 24, scope: !31)
!77 = !DILocation(line: 51, column: 5, scope: !31)
!78 = !DILocation(line: 52, column: 1, scope: !31)
