; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %struct.s2 }
%struct.s2 = type { i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"nope\00", align 1
@s1 = common global %struct.s1 zeroinitializer, align 8, !dbg !0
@.str.1 = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @bar() #0 !dbg !20 {
entry:
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0), i8** getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 1, i32 1), align 8, !dbg !23
  ret void, !dbg !24
}

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i8* %s2.coerce0, i8* %s2.coerce1) #0 !dbg !25 {
entry:
  %s2 = alloca %struct.s2, align 8
  %t1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %ut2 = alloca i8*, align 8
  %0 = bitcast %struct.s2* %s2 to { i8*, i8* }*
  %1 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %0, i32 0, i32 0
  store i8* %s2.coerce0, i8** %1, align 8
  %2 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %0, i32 0, i32 1
  store i8* %s2.coerce1, i8** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !28, metadata !29), !dbg !30
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !31, metadata !29), !dbg !32
  %3 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 1, i32 1), align 8, !dbg !33
  store i8* %3, i8** %t1, align 8, !dbg !32
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !34, metadata !29), !dbg !35
  %t = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !36
  %4 = load i8*, i8** %t, align 8, !dbg !36
  store i8* %4, i8** %t2, align 8, !dbg !35
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !37, metadata !29), !dbg !38
  %ut = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !39
  %5 = load i8*, i8** %ut, align 8, !dbg !39
  store i8* %5, i8** %ut1, align 8, !dbg !38
  call void @bar(), !dbg !40
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !41, metadata !29), !dbg !42
  %6 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 1, i32 1), align 8, !dbg !43
  store i8* %6, i8** %ut2, align 8, !dbg !42
  ret void, !dbg !44
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !45 {
entry:
  %retval = alloca i32, align 4
  %ut1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)), !dbg !49
  store i8* %call, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 1, i32 1), align 8, !dbg !50
  %0 = load i8*, i8** getelementptr inbounds ({ i8*, i8* }, { i8*, i8* }* bitcast (%struct.s2* getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 1) to { i8*, i8* }*), i32 0, i32 0), align 8, !dbg !51
  %1 = load i8*, i8** getelementptr inbounds ({ i8*, i8* }, { i8*, i8* }* bitcast (%struct.s2* getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 1) to { i8*, i8* }*), i32 0, i32 1), align 8, !dbg !51
  call void @foo(i8* %0, i8* %1), !dbg !51
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !52, metadata !29), !dbg !53
  %2 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 1, i32 1), align 8, !dbg !54
  store i8* %2, i8** %ut1, align 8, !dbg !53
  ret i32 0, !dbg !55
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!16, !17, !18}
!llvm.ident = !{!19}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "s1", scope: !2, file: !3, line: 13, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-20")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !3, line: 8, size: 192, elements: !7)
!7 = !{!8, !11}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !6, file: !3, line: 9, baseType: !9, size: 64)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !6, file: !3, line: 10, baseType: !12, size: 128, offset: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !3, line: 3, size: 128, elements: !13)
!13 = !{!14, !15}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "ut", scope: !12, file: !3, line: 4, baseType: !9, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !12, file: !3, line: 5, baseType: !9, size: 64, offset: 64)
!16 = !{i32 2, !"Dwarf Version", i32 4}
!17 = !{i32 2, !"Debug Info Version", i32 3}
!18 = !{i32 1, !"wchar_size", i32 4}
!19 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!20 = distinct !DISubprogram(name: "bar", scope: !3, file: !3, line: 16, type: !21, isLocal: false, isDefinition: true, scopeLine: 16, isOptimized: false, unit: !2, variables: !4)
!21 = !DISubroutineType(types: !22)
!22 = !{null}
!23 = !DILocation(line: 17, column: 13, scope: !20)
!24 = !DILocation(line: 18, column: 1, scope: !20)
!25 = distinct !DISubprogram(name: "foo", scope: !3, file: !3, line: 21, type: !26, isLocal: false, isDefinition: true, scopeLine: 21, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!26 = !DISubroutineType(types: !27)
!27 = !{null, !12}
!28 = !DILocalVariable(name: "s2", arg: 1, scope: !25, file: !3, line: 21, type: !12)
!29 = !DIExpression()
!30 = !DILocation(line: 21, column: 15, scope: !25)
!31 = !DILocalVariable(name: "t1", scope: !25, file: !3, line: 22, type: !9)
!32 = !DILocation(line: 22, column: 11, scope: !25)
!33 = !DILocation(line: 22, column: 22, scope: !25)
!34 = !DILocalVariable(name: "t2", scope: !25, file: !3, line: 23, type: !9)
!35 = !DILocation(line: 23, column: 11, scope: !25)
!36 = !DILocation(line: 23, column: 19, scope: !25)
!37 = !DILocalVariable(name: "ut1", scope: !25, file: !3, line: 24, type: !9)
!38 = !DILocation(line: 24, column: 11, scope: !25)
!39 = !DILocation(line: 24, column: 20, scope: !25)
!40 = !DILocation(line: 26, column: 5, scope: !25)
!41 = !DILocalVariable(name: "ut2", scope: !25, file: !3, line: 28, type: !9)
!42 = !DILocation(line: 28, column: 11, scope: !25)
!43 = !DILocation(line: 28, column: 23, scope: !25)
!44 = !DILocation(line: 29, column: 1, scope: !25)
!45 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 32, type: !46, isLocal: false, isDefinition: true, scopeLine: 33, isOptimized: false, unit: !2, variables: !4)
!46 = !DISubroutineType(types: !47)
!47 = !{!48}
!48 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!49 = !DILocation(line: 34, column: 15, scope: !45)
!50 = !DILocation(line: 34, column: 13, scope: !45)
!51 = !DILocation(line: 36, column: 5, scope: !45)
!52 = !DILocalVariable(name: "ut1", scope: !45, file: !3, line: 38, type: !9)
!53 = !DILocation(line: 38, column: 11, scope: !45)
!54 = !DILocation(line: 38, column: 23, scope: !45)
!55 = !DILocation(line: 40, column: 5, scope: !45)
