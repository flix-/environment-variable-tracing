; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { float, float, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(<2 x float> %s1.coerce0, i8* %s1.coerce1) #0 !dbg !7 {
entry:
  %s1 = alloca %struct.s1, align 8
  %t1 = alloca i8*, align 8
  %0 = bitcast %struct.s1* %s1 to { <2 x float>, i8* }*
  %1 = getelementptr inbounds { <2 x float>, i8* }, { <2 x float>, i8* }* %0, i32 0, i32 0
  store <2 x float> %s1.coerce0, <2 x float>* %1, align 8
  %2 = getelementptr inbounds { <2 x float>, i8* }, { <2 x float>, i8* }* %0, i32 0, i32 1
  store i8* %s1.coerce1, i8** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !18, metadata !19), !dbg !20
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !21, metadata !19), !dbg !22
  %t11 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !23
  %3 = load i8*, i8** %t11, align 8, !dbg !23
  store i8* %3, i8** %t1, align 8, !dbg !22
  ret void, !dbg !24
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !25 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !29, metadata !19), !dbg !30
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !31
  %t1 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !32
  store i8* %call, i8** %t1, align 8, !dbg !33
  %0 = bitcast %struct.s1* %s1 to { <2 x float>, i8* }*, !dbg !34
  %1 = getelementptr inbounds { <2 x float>, i8* }, { <2 x float>, i8* }* %0, i32 0, i32 0, !dbg !34
  %2 = load <2 x float>, <2 x float>* %1, align 8, !dbg !34
  %3 = getelementptr inbounds { <2 x float>, i8* }, { <2 x float>, i8* }* %0, i32 0, i32 1, !dbg !34
  %4 = load i8*, i8** %3, align 8, !dbg !34
  call void @foo(<2 x float> %2, i8* %4), !dbg !34
  ret i32 0, !dbg !35
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-struct-by-coerce-5")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 3, size: 128, elements: !11)
!11 = !{!12, !14, !15}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !10, file: !1, line: 4, baseType: !13, size: 32)
!13 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !10, file: !1, line: 5, baseType: !13, size: 32, offset: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !10, file: !1, line: 6, baseType: !16, size: 64, offset: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!18 = !DILocalVariable(name: "s1", arg: 1, scope: !7, file: !1, line: 10, type: !10)
!19 = !DIExpression()
!20 = !DILocation(line: 10, column: 15, scope: !7)
!21 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 12, type: !16)
!22 = !DILocation(line: 12, column: 11, scope: !7)
!23 = !DILocation(line: 12, column: 19, scope: !7)
!24 = !DILocation(line: 13, column: 1, scope: !7)
!25 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !26, isLocal: false, isDefinition: true, scopeLine: 17, isOptimized: false, unit: !0, variables: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{!28}
!28 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!29 = !DILocalVariable(name: "s1", scope: !25, file: !1, line: 18, type: !10)
!30 = !DILocation(line: 18, column: 15, scope: !25)
!31 = !DILocation(line: 19, column: 13, scope: !25)
!32 = !DILocation(line: 19, column: 8, scope: !25)
!33 = !DILocation(line: 19, column: 11, scope: !25)
!34 = !DILocation(line: 20, column: 5, scope: !25)
!35 = !DILocation(line: 22, column: 5, scope: !25)
