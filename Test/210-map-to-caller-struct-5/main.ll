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
  %s11 = alloca %struct.s1, align 8
  %s12 = alloca %struct.s1, align 8
  %coerce = alloca %struct.s1, align 8
  %coerce3 = alloca %struct.s1, align 8
  %coerce5 = alloca %struct.s1, align 8
  %coerce7 = alloca %struct.s1, align 8
  %not_tainted = alloca i32, align 4
  %tainted8 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s11, metadata !25, metadata !18), !dbg !26
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !27
  %tainted = getelementptr inbounds %struct.s1, %struct.s1* %s11, i32 0, i32 1, !dbg !28
  store i8* %call, i8** %tainted, align 8, !dbg !29
  call void @llvm.dbg.declare(metadata %struct.s1* %s12, metadata !30, metadata !18), !dbg !31
  %0 = bitcast %struct.s1* %s11 to { i32, i8* }*, !dbg !32
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
  %10 = bitcast %struct.s1* %s12 to i8*, !dbg !32
  %11 = bitcast %struct.s1* %coerce to i8*, !dbg !32
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %10, i8* %11, i64 16, i32 8, i1 false), !dbg !32
  %12 = bitcast %struct.s1* %s11 to { i32, i8* }*, !dbg !33
  %13 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %12, i32 0, i32 0, !dbg !33
  %14 = load i32, i32* %13, align 8, !dbg !33
  %15 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %12, i32 0, i32 1, !dbg !33
  %16 = load i8*, i8** %15, align 8, !dbg !33
  %call2 = call { i32, i8* } @foo(i32 %14, i8* %16), !dbg !33
  %17 = bitcast %struct.s1* %coerce3 to { i32, i8* }*, !dbg !33
  %18 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %17, i32 0, i32 0, !dbg !33
  %19 = extractvalue { i32, i8* } %call2, 0, !dbg !33
  store i32 %19, i32* %18, align 8, !dbg !33
  %20 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %17, i32 0, i32 1, !dbg !33
  %21 = extractvalue { i32, i8* } %call2, 1, !dbg !33
  store i8* %21, i8** %20, align 8, !dbg !33
  %22 = bitcast %struct.s1* %s12 to i8*, !dbg !33
  %23 = bitcast %struct.s1* %coerce3 to i8*, !dbg !33
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %22, i8* %23, i64 16, i32 8, i1 false), !dbg !33
  %24 = bitcast %struct.s1* %s11 to { i32, i8* }*, !dbg !34
  %25 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %24, i32 0, i32 0, !dbg !34
  %26 = load i32, i32* %25, align 8, !dbg !34
  %27 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %24, i32 0, i32 1, !dbg !34
  %28 = load i8*, i8** %27, align 8, !dbg !34
  %call4 = call { i32, i8* } @foo(i32 %26, i8* %28), !dbg !34
  %29 = bitcast %struct.s1* %coerce5 to { i32, i8* }*, !dbg !34
  %30 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %29, i32 0, i32 0, !dbg !34
  %31 = extractvalue { i32, i8* } %call4, 0, !dbg !34
  store i32 %31, i32* %30, align 8, !dbg !34
  %32 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %29, i32 0, i32 1, !dbg !34
  %33 = extractvalue { i32, i8* } %call4, 1, !dbg !34
  store i8* %33, i8** %32, align 8, !dbg !34
  %34 = bitcast %struct.s1* %s12 to i8*, !dbg !34
  %35 = bitcast %struct.s1* %coerce5 to i8*, !dbg !34
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %34, i8* %35, i64 16, i32 8, i1 false), !dbg !34
  %36 = bitcast %struct.s1* %s11 to { i32, i8* }*, !dbg !35
  %37 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %36, i32 0, i32 0, !dbg !35
  %38 = load i32, i32* %37, align 8, !dbg !35
  %39 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %36, i32 0, i32 1, !dbg !35
  %40 = load i8*, i8** %39, align 8, !dbg !35
  %call6 = call { i32, i8* } @foo(i32 %38, i8* %40), !dbg !35
  %41 = bitcast %struct.s1* %coerce7 to { i32, i8* }*, !dbg !35
  %42 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %41, i32 0, i32 0, !dbg !35
  %43 = extractvalue { i32, i8* } %call6, 0, !dbg !35
  store i32 %43, i32* %42, align 8, !dbg !35
  %44 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %41, i32 0, i32 1, !dbg !35
  %45 = extractvalue { i32, i8* } %call6, 1, !dbg !35
  store i8* %45, i8** %44, align 8, !dbg !35
  %46 = bitcast %struct.s1* %s12 to i8*, !dbg !35
  %47 = bitcast %struct.s1* %coerce7 to i8*, !dbg !35
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %46, i8* %47, i64 16, i32 8, i1 false), !dbg !35
  call void @llvm.dbg.declare(metadata i32* %not_tainted, metadata !36, metadata !18), !dbg !37
  %a = getelementptr inbounds %struct.s1, %struct.s1* %s12, i32 0, i32 0, !dbg !38
  %48 = load i32, i32* %a, align 8, !dbg !38
  store i32 %48, i32* %not_tainted, align 4, !dbg !37
  call void @llvm.dbg.declare(metadata i8** %tainted8, metadata !39, metadata !18), !dbg !40
  %tainted9 = getelementptr inbounds %struct.s1, %struct.s1* %s12, i32 0, i32 1, !dbg !41
  %49 = load i8*, i8** %tainted9, align 8, !dbg !41
  store i8* %49, i8** %tainted8, align 8, !dbg !40
  ret i32 0, !dbg !42
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/210-map-to-caller-struct-5")
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
!25 = !DILocalVariable(name: "s11", scope: !22, file: !1, line: 17, type: !10)
!26 = !DILocation(line: 17, column: 15, scope: !22)
!27 = !DILocation(line: 18, column: 19, scope: !22)
!28 = !DILocation(line: 18, column: 9, scope: !22)
!29 = !DILocation(line: 18, column: 17, scope: !22)
!30 = !DILocalVariable(name: "s12", scope: !22, file: !1, line: 20, type: !10)
!31 = !DILocation(line: 20, column: 15, scope: !22)
!32 = !DILocation(line: 21, column: 11, scope: !22)
!33 = !DILocation(line: 22, column: 11, scope: !22)
!34 = !DILocation(line: 23, column: 11, scope: !22)
!35 = !DILocation(line: 24, column: 11, scope: !22)
!36 = !DILocalVariable(name: "not_tainted", scope: !22, file: !1, line: 26, type: !13)
!37 = !DILocation(line: 26, column: 9, scope: !22)
!38 = !DILocation(line: 26, column: 27, scope: !22)
!39 = !DILocalVariable(name: "tainted", scope: !22, file: !1, line: 27, type: !15)
!40 = !DILocation(line: 27, column: 11, scope: !22)
!41 = !DILocation(line: 27, column: 25, scope: !22)
!42 = !DILocation(line: 29, column: 5, scope: !22)
