; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i32, i32, i8*, %struct.s2 }
%struct.s2 = type { i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define { i8*, i8* } @foo(%struct.s1* byval align 8 %s1) #0 !dbg !7 {
entry:
  %retval = alloca %struct.s2, align 8
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !23, metadata !24), !dbg !25
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !26
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !27
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !28
  store i8* %call, i8** %t2, align 8, !dbg !29
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !30
  %0 = bitcast %struct.s2* %retval to i8*, !dbg !30
  %1 = bitcast %struct.s2* %s21 to i8*, !dbg !30
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 16, i32 8, i1 false), !dbg !30
  %2 = bitcast %struct.s2* %retval to { i8*, i8* }*, !dbg !31
  %3 = load { i8*, i8* }, { i8*, i8* }* %2, align 8, !dbg !31
  ret { i8*, i8* } %3, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !32 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %s21 = alloca %struct.s2, align 8
  %t13 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !35, metadata !24), !dbg !36
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !37
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !38
  %t1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !39
  store i8* %call, i8** %t1, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata %struct.s2* %s21, metadata !41, metadata !24), !dbg !42
  %call2 = call { i8*, i8* } @foo(%struct.s1* byval align 8 %s1), !dbg !43
  %0 = bitcast %struct.s2* %s21 to { i8*, i8* }*, !dbg !43
  %1 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %0, i32 0, i32 0, !dbg !43
  %2 = extractvalue { i8*, i8* } %call2, 0, !dbg !43
  store i8* %2, i8** %1, align 8, !dbg !43
  %3 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %0, i32 0, i32 1, !dbg !43
  %4 = extractvalue { i8*, i8* } %call2, 1, !dbg !43
  store i8* %4, i8** %3, align 8, !dbg !43
  call void @llvm.dbg.declare(metadata i8** %t13, metadata !44, metadata !24), !dbg !45
  %t14 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 0, !dbg !46
  %5 = load i8*, i8** %t14, align 8, !dbg !46
  store i8* %5, i8** %t13, align 8, !dbg !45
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !47, metadata !24), !dbg !48
  %t25 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 1, !dbg !49
  %6 = load i8*, i8** %t25, align 8, !dbg !49
  store i8* %6, i8** %t2, align 8, !dbg !48
  ret i32 0, !dbg !50
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/210-map-to-caller-struct-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 16, type: !8, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !16}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 3, size: 128, elements: !11)
!11 = !{!12, !15}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !10, file: !1, line: 4, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !10, file: !1, line: 5, baseType: !13, size: 64, offset: 64)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 8, size: 256, elements: !17)
!17 = !{!18, !20, !21, !22}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !16, file: !1, line: 9, baseType: !19, size: 32)
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !16, file: !1, line: 10, baseType: !19, size: 32, offset: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !16, file: !1, line: 11, baseType: !13, size: 64, offset: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !16, file: !1, line: 12, baseType: !10, size: 128, offset: 128)
!23 = !DILocalVariable(name: "s1", arg: 1, scope: !7, file: !1, line: 16, type: !16)
!24 = !DIExpression()
!25 = !DILocation(line: 16, column: 15, scope: !7)
!26 = !DILocation(line: 18, column: 16, scope: !7)
!27 = !DILocation(line: 18, column: 8, scope: !7)
!28 = !DILocation(line: 18, column: 11, scope: !7)
!29 = !DILocation(line: 18, column: 14, scope: !7)
!30 = !DILocation(line: 19, column: 15, scope: !7)
!31 = !DILocation(line: 19, column: 5, scope: !7)
!32 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 23, type: !33, isLocal: false, isDefinition: true, scopeLine: 24, isOptimized: false, unit: !0, variables: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!19}
!35 = !DILocalVariable(name: "s1", scope: !32, file: !1, line: 25, type: !16)
!36 = !DILocation(line: 25, column: 15, scope: !32)
!37 = !DILocation(line: 26, column: 16, scope: !32)
!38 = !DILocation(line: 26, column: 8, scope: !32)
!39 = !DILocation(line: 26, column: 11, scope: !32)
!40 = !DILocation(line: 26, column: 14, scope: !32)
!41 = !DILocalVariable(name: "s2", scope: !32, file: !1, line: 28, type: !10)
!42 = !DILocation(line: 28, column: 15, scope: !32)
!43 = !DILocation(line: 28, column: 20, scope: !32)
!44 = !DILocalVariable(name: "t1", scope: !32, file: !1, line: 30, type: !13)
!45 = !DILocation(line: 30, column: 11, scope: !32)
!46 = !DILocation(line: 30, column: 19, scope: !32)
!47 = !DILocalVariable(name: "t2", scope: !32, file: !1, line: 31, type: !13)
!48 = !DILocation(line: 31, column: 11, scope: !32)
!49 = !DILocation(line: 31, column: 19, scope: !32)
!50 = !DILocation(line: 33, column: 5, scope: !32)
