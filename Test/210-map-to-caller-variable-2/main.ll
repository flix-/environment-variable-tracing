; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define { i32, i8* } @foo(i32 %s.coerce0, i8* %s.coerce1) #0 !dbg !7 {
entry:
  %retval = alloca %struct.s1, align 8
  %s = alloca %struct.s1, align 8
  %0 = bitcast %struct.s1* %s to { i32, i8* }*
  %1 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 0
  store i32 %s.coerce0, i32* %1, align 8
  %2 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 1
  store i8* %s.coerce1, i8** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !17, metadata !18), !dbg !19
  %3 = bitcast %struct.s1* %retval to i8*, !dbg !20
  %4 = bitcast %struct.s1* %s to i8*, !dbg !20
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %4, i64 16, i32 8, i1 false), !dbg !20
  %5 = bitcast %struct.s1* %retval to { i32, i8* }*, !dbg !21
  %6 = load { i32, i8* }, { i32, i8* }* %5, align 8, !dbg !21
  ret { i32, i8* } %6, !dbg !21
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !22 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  %s2 = alloca %struct.s1, align 8
  %coerce = alloca %struct.s1, align 8
  %tainted2 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !25, metadata !18), !dbg !26
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !27
  %tainted = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !28
  store i8* %call, i8** %tainted, align 8, !dbg !29
  call void @llvm.dbg.declare(metadata %struct.s1* %s2, metadata !30, metadata !18), !dbg !31
  %0 = bitcast %struct.s1* %s to { i32, i8* }*, !dbg !32
  %1 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 0, !dbg !32
  %2 = load i32, i32* %1, align 8, !dbg !32
  %3 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 1, !dbg !32
  %4 = load i8*, i8** %3, align 8, !dbg !32
  %call1 = call { i32, i8* } @foo(i32 %2, i8* %4), !dbg !32
  %5 = bitcast %struct.s1* %coerce to { i32, i8* }*, !dbg !32
  %6 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %5, i32 0, i32 0, !dbg !32
  %7 = extractvalue { i32, i8* } %call1, 0, !dbg !32
  store i32 %7, i32* %6, align 8, !dbg !32
  %8 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %5, i32 0, i32 1, !dbg !32
  %9 = extractvalue { i32, i8* } %call1, 1, !dbg !32
  store i8* %9, i8** %8, align 8, !dbg !32
  %10 = bitcast %struct.s1* %s2 to i8*, !dbg !32
  %11 = bitcast %struct.s1* %coerce to i8*, !dbg !32
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %10, i8* %11, i64 16, i32 8, i1 false), !dbg !32
  call void @llvm.dbg.declare(metadata i8** %tainted2, metadata !33, metadata !18), !dbg !34
  %tainted3 = getelementptr inbounds %struct.s1, %struct.s1* %s2, i32 0, i32 1, !dbg !35
  %12 = load i8*, i8** %tainted3, align 8, !dbg !35
  store i8* %12, i8** %tainted2, align 8, !dbg !34
  ret i32 0, !dbg !36
}

declare i8* @getenv(i8*) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/210-map-to-caller-variable-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 3, size: 128, elements: !11)
!11 = !{!12, !14}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !10, file: !1, line: 4, baseType: !13, size: 32)
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "tainted", scope: !10, file: !1, line: 5, baseType: !15, size: 64, offset: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DILocalVariable(name: "s", arg: 1, scope: !7, file: !1, line: 9, type: !10)
!18 = !DIExpression()
!19 = !DILocation(line: 9, column: 15, scope: !7)
!20 = !DILocation(line: 11, column: 12, scope: !7)
!21 = !DILocation(line: 11, column: 5, scope: !7)
!22 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 15, type: !23, isLocal: false, isDefinition: true, scopeLine: 16, isOptimized: false, unit: !0, variables: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{!13}
!25 = !DILocalVariable(name: "s", scope: !22, file: !1, line: 17, type: !10)
!26 = !DILocation(line: 17, column: 15, scope: !22)
!27 = !DILocation(line: 18, column: 17, scope: !22)
!28 = !DILocation(line: 18, column: 7, scope: !22)
!29 = !DILocation(line: 18, column: 15, scope: !22)
!30 = !DILocalVariable(name: "s2", scope: !22, file: !1, line: 20, type: !10)
!31 = !DILocation(line: 20, column: 15, scope: !22)
!32 = !DILocation(line: 21, column: 10, scope: !22)
!33 = !DILocalVariable(name: "tainted", scope: !22, file: !1, line: 22, type: !15)
!34 = !DILocation(line: 22, column: 11, scope: !22)
!35 = !DILocation(line: 22, column: 24, scope: !22)
!36 = !DILocation(line: 24, column: 5, scope: !22)
