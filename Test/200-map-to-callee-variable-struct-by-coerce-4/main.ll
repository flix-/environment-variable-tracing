; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s2 = type { i32, i32, i8* }
%struct.s1 = type { i32, i32, %struct.s2 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i64 %fs.coerce0, i8* %fs.coerce1) #0 !dbg !7 {
entry:
  %fs = alloca %struct.s2, align 8
  %t2 = alloca i8*, align 8
  %ut1 = alloca i32, align 4
  %ut2 = alloca i32, align 4
  %0 = bitcast %struct.s2* %fs to { i64, i8* }*
  %1 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 0
  store i64 %fs.coerce0, i64* %1, align 8
  %2 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 1
  store i8* %fs.coerce1, i8** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.s2* %fs, metadata !18, metadata !19), !dbg !20
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !21, metadata !19), !dbg !22
  %t1 = getelementptr inbounds %struct.s2, %struct.s2* %fs, i32 0, i32 2, !dbg !23
  %3 = load i8*, i8** %t1, align 8, !dbg !23
  store i8* %3, i8** %t2, align 8, !dbg !22
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !24, metadata !19), !dbg !25
  %a = getelementptr inbounds %struct.s2, %struct.s2* %fs, i32 0, i32 0, !dbg !26
  %4 = load i32, i32* %a, align 8, !dbg !26
  store i32 %4, i32* %ut1, align 4, !dbg !25
  call void @llvm.dbg.declare(metadata i32* %ut2, metadata !27, metadata !19), !dbg !28
  %b = getelementptr inbounds %struct.s2, %struct.s2* %fs, i32 0, i32 1, !dbg !29
  %5 = load i32, i32* %b, align 4, !dbg !29
  store i32 %5, i32* %ut2, align 4, !dbg !28
  ret void, !dbg !30
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !31 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !34, metadata !19), !dbg !40
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !41
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !42
  %t1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !43
  store i8* %call, i8** %t1, align 8, !dbg !44
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !45
  %0 = bitcast %struct.s2* %s21 to { i64, i8* }*, !dbg !46
  %1 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 0, !dbg !46
  %2 = load i64, i64* %1, align 8, !dbg !46
  %3 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 1, !dbg !46
  %4 = load i8*, i8** %3, align 8, !dbg !46
  call void @foo(i64 %2, i8* %4), !dbg !46
  ret i32 0, !dbg !47
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-struct-by-coerce-4")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 16, type: !8, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 3, size: 128, elements: !11)
!11 = !{!12, !14, !15}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !10, file: !1, line: 4, baseType: !13, size: 32)
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !10, file: !1, line: 5, baseType: !13, size: 32, offset: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !10, file: !1, line: 6, baseType: !16, size: 64, offset: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!18 = !DILocalVariable(name: "fs", arg: 1, scope: !7, file: !1, line: 16, type: !10)
!19 = !DIExpression()
!20 = !DILocation(line: 16, column: 15, scope: !7)
!21 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 18, type: !16)
!22 = !DILocation(line: 18, column: 11, scope: !7)
!23 = !DILocation(line: 18, column: 19, scope: !7)
!24 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 19, type: !13)
!25 = !DILocation(line: 19, column: 9, scope: !7)
!26 = !DILocation(line: 19, column: 18, scope: !7)
!27 = !DILocalVariable(name: "ut2", scope: !7, file: !1, line: 20, type: !13)
!28 = !DILocation(line: 20, column: 9, scope: !7)
!29 = !DILocation(line: 20, column: 18, scope: !7)
!30 = !DILocation(line: 21, column: 1, scope: !7)
!31 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 24, type: !32, isLocal: false, isDefinition: true, scopeLine: 25, isOptimized: false, unit: !0, variables: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!13}
!34 = !DILocalVariable(name: "s1", scope: !31, file: !1, line: 26, type: !35)
!35 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 9, size: 192, elements: !36)
!36 = !{!37, !38, !39}
!37 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !35, file: !1, line: 10, baseType: !13, size: 32)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !35, file: !1, line: 11, baseType: !13, size: 32, offset: 32)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !35, file: !1, line: 12, baseType: !10, size: 128, offset: 64)
!40 = !DILocation(line: 26, column: 15, scope: !31)
!41 = !DILocation(line: 27, column: 16, scope: !31)
!42 = !DILocation(line: 27, column: 8, scope: !31)
!43 = !DILocation(line: 27, column: 11, scope: !31)
!44 = !DILocation(line: 27, column: 14, scope: !31)
!45 = !DILocation(line: 28, column: 12, scope: !31)
!46 = !DILocation(line: 28, column: 5, scope: !31)
!47 = !DILocation(line: 30, column: 5, scope: !31)
