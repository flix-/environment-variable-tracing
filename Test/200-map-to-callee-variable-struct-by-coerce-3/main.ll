; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i32, i32, i8* }

@.str = private unnamed_addr constant [8 x i8] c"untaint\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @bar(i64 %str_bar.coerce0, i8* %str_bar.coerce1) #0 !dbg !7 {
entry:
  %str_bar = alloca %struct.s1, align 8
  %tainted_bar = alloca i8*, align 8
  %0 = bitcast %struct.s1* %str_bar to { i64, i8* }*
  %1 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 0
  store i64 %str_bar.coerce0, i64* %1, align 8
  %2 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 1
  store i8* %str_bar.coerce1, i8** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.s1* %str_bar, metadata !18, metadata !19), !dbg !20
  call void @llvm.dbg.declare(metadata i8** %tainted_bar, metadata !21, metadata !19), !dbg !22
  %tainted1 = getelementptr inbounds %struct.s1, %struct.s1* %str_bar, i32 0, i32 2, !dbg !23
  %3 = load i8*, i8** %tainted1, align 8, !dbg !23
  store i8* %3, i8** %tainted_bar, align 8, !dbg !22
  %tainted11 = getelementptr inbounds %struct.s1, %struct.s1* %str_bar, i32 0, i32 2, !dbg !24
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i32 0, i32 0), i8** %tainted11, align 8, !dbg !25
  ret void, !dbg !26
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i64 %str_foo.coerce0, i8* %str_foo.coerce1, i32 %a) #0 !dbg !27 {
entry:
  %str_foo = alloca %struct.s1, align 8
  %a.addr = alloca i32, align 4
  %tainted_foo = alloca i8*, align 8
  %still_tainted = alloca i8*, align 8
  %0 = bitcast %struct.s1* %str_foo to { i64, i8* }*
  %1 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 0
  store i64 %str_foo.coerce0, i64* %1, align 8
  %2 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 1
  store i8* %str_foo.coerce1, i8** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.s1* %str_foo, metadata !30, metadata !19), !dbg !31
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !32, metadata !19), !dbg !33
  call void @llvm.dbg.declare(metadata i8** %tainted_foo, metadata !34, metadata !19), !dbg !35
  %tainted1 = getelementptr inbounds %struct.s1, %struct.s1* %str_foo, i32 0, i32 2, !dbg !36
  %3 = load i8*, i8** %tainted1, align 8, !dbg !36
  store i8* %3, i8** %tainted_foo, align 8, !dbg !35
  %4 = bitcast %struct.s1* %str_foo to { i64, i8* }*, !dbg !37
  %5 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %4, i32 0, i32 0, !dbg !37
  %6 = load i64, i64* %5, align 8, !dbg !37
  %7 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %4, i32 0, i32 1, !dbg !37
  %8 = load i8*, i8** %7, align 8, !dbg !37
  call void @bar(i64 %6, i8* %8), !dbg !37
  call void @llvm.dbg.declare(metadata i8** %still_tainted, metadata !38, metadata !19), !dbg !39
  %tainted11 = getelementptr inbounds %struct.s1, %struct.s1* %str_foo, i32 0, i32 2, !dbg !40
  %9 = load i8*, i8** %tainted11, align 8, !dbg !40
  store i8* %9, i8** %still_tainted, align 8, !dbg !39
  ret void, !dbg !41
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !42 {
entry:
  %retval = alloca i32, align 4
  %str_main = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %str_main, metadata !45, metadata !19), !dbg !46
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)), !dbg !47
  %tainted1 = getelementptr inbounds %struct.s1, %struct.s1* %str_main, i32 0, i32 2, !dbg !48
  store i8* %call, i8** %tainted1, align 8, !dbg !49
  %0 = bitcast %struct.s1* %str_main to { i64, i8* }*, !dbg !50
  %1 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 0, !dbg !50
  %2 = load i64, i64* %1, align 8, !dbg !50
  %3 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 1, !dbg !50
  %4 = load i8*, i8** %3, align 8, !dbg !50
  call void @foo(i64 %2, i8* %4, i32 42), !dbg !50
  ret i32 0, !dbg !51
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-struct-by-coerce-3")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 3, size: 128, elements: !11)
!11 = !{!12, !14, !15}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !10, file: !1, line: 4, baseType: !13, size: 32)
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !10, file: !1, line: 5, baseType: !13, size: 32, offset: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "tainted1", scope: !10, file: !1, line: 6, baseType: !16, size: 64, offset: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!18 = !DILocalVariable(name: "str_bar", arg: 1, scope: !7, file: !1, line: 10, type: !10)
!19 = !DIExpression()
!20 = !DILocation(line: 10, column: 15, scope: !7)
!21 = !DILocalVariable(name: "tainted_bar", scope: !7, file: !1, line: 11, type: !16)
!22 = !DILocation(line: 11, column: 11, scope: !7)
!23 = !DILocation(line: 11, column: 33, scope: !7)
!24 = !DILocation(line: 12, column: 13, scope: !7)
!25 = !DILocation(line: 12, column: 22, scope: !7)
!26 = !DILocation(line: 13, column: 1, scope: !7)
!27 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 16, type: !28, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!28 = !DISubroutineType(types: !29)
!29 = !{null, !10, !13}
!30 = !DILocalVariable(name: "str_foo", arg: 1, scope: !27, file: !1, line: 16, type: !10)
!31 = !DILocation(line: 16, column: 15, scope: !27)
!32 = !DILocalVariable(name: "a", arg: 2, scope: !27, file: !1, line: 16, type: !13)
!33 = !DILocation(line: 16, column: 28, scope: !27)
!34 = !DILocalVariable(name: "tainted_foo", scope: !27, file: !1, line: 18, type: !16)
!35 = !DILocation(line: 18, column: 11, scope: !27)
!36 = !DILocation(line: 18, column: 33, scope: !27)
!37 = !DILocation(line: 19, column: 5, scope: !27)
!38 = !DILocalVariable(name: "still_tainted", scope: !27, file: !1, line: 20, type: !16)
!39 = !DILocation(line: 20, column: 11, scope: !27)
!40 = !DILocation(line: 20, column: 35, scope: !27)
!41 = !DILocation(line: 21, column: 1, scope: !27)
!42 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 24, type: !43, isLocal: false, isDefinition: true, scopeLine: 25, isOptimized: false, unit: !0, variables: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{!13}
!45 = !DILocalVariable(name: "str_main", scope: !42, file: !1, line: 26, type: !10)
!46 = !DILocation(line: 26, column: 15, scope: !42)
!47 = !DILocation(line: 27, column: 25, scope: !42)
!48 = !DILocation(line: 27, column: 14, scope: !42)
!49 = !DILocation(line: 27, column: 23, scope: !42)
!50 = !DILocation(line: 28, column: 5, scope: !42)
!51 = !DILocation(line: 30, column: 5, scope: !42)
