; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.a = type { i32, %struct.b }
%struct.b = type { i32, i8*, %struct.c }
%struct.c = type { double, i8*, %struct.d }
%struct.d = type { i32, i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"untaint\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %a1 = alloca %struct.a, align 8
  %c1 = alloca %struct.c, align 8
  %t1 = alloca i8*, align 8
  %d1 = alloca %struct.d, align 8
  %t2 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %t3 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.a* %a1, metadata !11, metadata !34), !dbg !35
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !36
  %b = getelementptr inbounds %struct.a, %struct.a* %a1, i32 0, i32 1, !dbg !37
  %c = getelementptr inbounds %struct.b, %struct.b* %b, i32 0, i32 2, !dbg !38
  %d = getelementptr inbounds %struct.c, %struct.c* %c, i32 0, i32 2, !dbg !39
  %taint = getelementptr inbounds %struct.d, %struct.d* %d, i32 0, i32 2, !dbg !40
  store i8* %call, i8** %taint, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata %struct.c* %c1, metadata !42, metadata !34), !dbg !43
  %b1 = getelementptr inbounds %struct.a, %struct.a* %a1, i32 0, i32 1, !dbg !44
  %c2 = getelementptr inbounds %struct.b, %struct.b* %b1, i32 0, i32 2, !dbg !45
  %0 = bitcast %struct.c* %c1 to i8*, !dbg !45
  %1 = bitcast %struct.c* %c2 to i8*, !dbg !45
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 32, i32 8, i1 false), !dbg !45
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !46, metadata !34), !dbg !47
  %d3 = getelementptr inbounds %struct.c, %struct.c* %c1, i32 0, i32 2, !dbg !48
  %taint4 = getelementptr inbounds %struct.d, %struct.d* %d3, i32 0, i32 2, !dbg !49
  %2 = load i8*, i8** %taint4, align 8, !dbg !49
  store i8* %2, i8** %t1, align 8, !dbg !47
  call void @llvm.dbg.declare(metadata %struct.d* %d1, metadata !50, metadata !34), !dbg !51
  %d5 = getelementptr inbounds %struct.c, %struct.c* %c1, i32 0, i32 2, !dbg !52
  %3 = bitcast %struct.d* %d1 to i8*, !dbg !52
  %4 = bitcast %struct.d* %d5 to i8*, !dbg !52
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %4, i64 16, i32 8, i1 false), !dbg !52
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !53, metadata !34), !dbg !54
  %taint6 = getelementptr inbounds %struct.d, %struct.d* %d1, i32 0, i32 2, !dbg !55
  %5 = load i8*, i8** %taint6, align 8, !dbg !55
  store i8* %5, i8** %t2, align 8, !dbg !54
  %d7 = getelementptr inbounds %struct.c, %struct.c* %c1, i32 0, i32 2, !dbg !56
  %taint8 = getelementptr inbounds %struct.d, %struct.d* %d7, i32 0, i32 2, !dbg !57
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i32 0, i32 0), i8** %taint8, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !59, metadata !34), !dbg !60
  %d9 = getelementptr inbounds %struct.c, %struct.c* %c1, i32 0, i32 2, !dbg !61
  %taint10 = getelementptr inbounds %struct.d, %struct.d* %d9, i32 0, i32 2, !dbg !62
  %6 = load i8*, i8** %taint10, align 8, !dbg !62
  store i8* %6, i8** %ut1, align 8, !dbg !60
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !63, metadata !34), !dbg !64
  %taint11 = getelementptr inbounds %struct.d, %struct.d* %d1, i32 0, i32 2, !dbg !65
  %7 = load i8*, i8** %taint11, align 8, !dbg !65
  store i8* %7, i8** %t3, align 8, !dbg !64
  ret i32 0, !dbg !66
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/081-structs-8")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 29, type: !8, isLocal: false, isDefinition: true, scopeLine: 30, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a1", scope: !7, file: !1, line: 31, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "a", file: !1, line: 23, size: 448, elements: !13)
!13 = !{!14, !15}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 24, baseType: !10, size: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !12, file: !1, line: 25, baseType: !16, size: 384, offset: 64)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "b", file: !1, line: 17, size: 384, elements: !17)
!17 = !{!18, !19, !22}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "f", scope: !16, file: !1, line: 18, baseType: !10, size: 32)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !16, file: !1, line: 19, baseType: !20, size: 64, offset: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !16, file: !1, line: 20, baseType: !23, size: 256, offset: 128)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "c", file: !1, line: 11, size: 256, elements: !24)
!24 = !{!25, !27, !28}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !23, file: !1, line: 12, baseType: !26, size: 64)
!26 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !23, file: !1, line: 13, baseType: !20, size: 64, offset: 64)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "d", scope: !23, file: !1, line: 14, baseType: !29, size: 128, offset: 128)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "d", file: !1, line: 5, size: 128, elements: !30)
!30 = !{!31, !32, !33}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !29, file: !1, line: 6, baseType: !10, size: 32)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !29, file: !1, line: 7, baseType: !10, size: 32, offset: 32)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !29, file: !1, line: 8, baseType: !20, size: 64, offset: 64)
!34 = !DIExpression()
!35 = !DILocation(line: 31, column: 14, scope: !7)
!36 = !DILocation(line: 32, column: 22, scope: !7)
!37 = !DILocation(line: 32, column: 8, scope: !7)
!38 = !DILocation(line: 32, column: 10, scope: !7)
!39 = !DILocation(line: 32, column: 12, scope: !7)
!40 = !DILocation(line: 32, column: 14, scope: !7)
!41 = !DILocation(line: 32, column: 20, scope: !7)
!42 = !DILocalVariable(name: "c1", scope: !7, file: !1, line: 34, type: !23)
!43 = !DILocation(line: 34, column: 14, scope: !7)
!44 = !DILocation(line: 34, column: 22, scope: !7)
!45 = !DILocation(line: 34, column: 24, scope: !7)
!46 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 35, type: !20)
!47 = !DILocation(line: 35, column: 11, scope: !7)
!48 = !DILocation(line: 35, column: 19, scope: !7)
!49 = !DILocation(line: 35, column: 21, scope: !7)
!50 = !DILocalVariable(name: "d1", scope: !7, file: !1, line: 37, type: !29)
!51 = !DILocation(line: 37, column: 14, scope: !7)
!52 = !DILocation(line: 37, column: 22, scope: !7)
!53 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 38, type: !20)
!54 = !DILocation(line: 38, column: 11, scope: !7)
!55 = !DILocation(line: 38, column: 19, scope: !7)
!56 = !DILocation(line: 40, column: 8, scope: !7)
!57 = !DILocation(line: 40, column: 10, scope: !7)
!58 = !DILocation(line: 40, column: 16, scope: !7)
!59 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 41, type: !20)
!60 = !DILocation(line: 41, column: 11, scope: !7)
!61 = !DILocation(line: 41, column: 20, scope: !7)
!62 = !DILocation(line: 41, column: 22, scope: !7)
!63 = !DILocalVariable(name: "t3", scope: !7, file: !1, line: 43, type: !20)
!64 = !DILocation(line: 43, column: 11, scope: !7)
!65 = !DILocation(line: 43, column: 19, scope: !7)
!66 = !DILocation(line: 45, column: 5, scope: !7)
