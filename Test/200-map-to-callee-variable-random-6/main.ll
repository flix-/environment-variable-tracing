; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i32, i32, %struct.s2* }
%struct.s2 = type { i8*, [2 x i8*] }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @bar(i8* %t) #0 !dbg !7 {
entry:
  %t.addr = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  store i8* %t, i8** %t.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %t.addr, metadata !12, metadata !13), !dbg !14
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !15, metadata !13), !dbg !16
  %0 = load i8*, i8** %t.addr, align 8, !dbg !17
  store i8* %0, i8** %t2, align 8, !dbg !16
  ret void, !dbg !18
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i8** %t2) #0 !dbg !19 {
entry:
  %t2.addr = alloca i8**, align 8
  %t1 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  store i8** %t2, i8*** %t2.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %t2.addr, metadata !23, metadata !13), !dbg !24
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !25, metadata !13), !dbg !26
  %0 = load i8**, i8*** %t2.addr, align 8, !dbg !27
  %arrayidx = getelementptr inbounds i8*, i8** %0, i64 1, !dbg !27
  %1 = load i8*, i8** %arrayidx, align 8, !dbg !27
  store i8* %1, i8** %t1, align 8, !dbg !26
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !28, metadata !13), !dbg !29
  %2 = load i8**, i8*** %t2.addr, align 8, !dbg !30
  %arrayidx1 = getelementptr inbounds i8*, i8** %2, i64 0, !dbg !30
  %3 = load i8*, i8** %arrayidx1, align 8, !dbg !30
  store i8* %3, i8** %ut1, align 8, !dbg !29
  %4 = load i8*, i8** %t1, align 8, !dbg !31
  call void @bar(i8* %4), !dbg !32
  ret void, !dbg !33
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !34 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %s2 = alloca %struct.s2, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !38, metadata !13), !dbg !52
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !53, metadata !13), !dbg !54
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !55
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !56
  %arrayidx = getelementptr inbounds [2 x i8*], [2 x i8*]* %t2, i64 0, i64 1, !dbg !57
  store i8* %call, i8** %arrayidx, align 8, !dbg !58
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !59
  store %struct.s2* %s2, %struct.s2** %s21, align 8, !dbg !60
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !61
  %0 = load %struct.s2*, %struct.s2** %s22, align 8, !dbg !61
  %t23 = getelementptr inbounds %struct.s2, %struct.s2* %0, i32 0, i32 1, !dbg !62
  %arraydecay = getelementptr inbounds [2 x i8*], [2 x i8*]* %t23, i32 0, i32 0, !dbg !63
  call void @foo(i8** %arraydecay), !dbg !64
  ret i32 0, !dbg !65
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-random-6")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 17, type: !8, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !DILocalVariable(name: "t", arg: 1, scope: !7, file: !1, line: 17, type: !10)
!13 = !DIExpression()
!14 = !DILocation(line: 17, column: 11, scope: !7)
!15 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 18, type: !10)
!16 = !DILocation(line: 18, column: 11, scope: !7)
!17 = !DILocation(line: 18, column: 16, scope: !7)
!18 = !DILocation(line: 19, column: 1, scope: !7)
!19 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 22, type: !20, isLocal: false, isDefinition: true, scopeLine: 23, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!20 = !DISubroutineType(types: !21)
!21 = !{null, !22}
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!23 = !DILocalVariable(name: "t2", arg: 1, scope: !19, file: !1, line: 22, type: !22)
!24 = !DILocation(line: 22, column: 11, scope: !19)
!25 = !DILocalVariable(name: "t1", scope: !19, file: !1, line: 24, type: !10)
!26 = !DILocation(line: 24, column: 11, scope: !19)
!27 = !DILocation(line: 24, column: 16, scope: !19)
!28 = !DILocalVariable(name: "ut1", scope: !19, file: !1, line: 25, type: !10)
!29 = !DILocation(line: 25, column: 11, scope: !19)
!30 = !DILocation(line: 25, column: 17, scope: !19)
!31 = !DILocation(line: 27, column: 9, scope: !19)
!32 = !DILocation(line: 27, column: 5, scope: !19)
!33 = !DILocation(line: 28, column: 1, scope: !19)
!34 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 31, type: !35, isLocal: false, isDefinition: true, scopeLine: 32, isOptimized: false, unit: !0, variables: !2)
!35 = !DISubroutineType(types: !36)
!36 = !{!37}
!37 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!38 = !DILocalVariable(name: "s1", scope: !34, file: !1, line: 33, type: !39)
!39 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 10, size: 128, elements: !40)
!40 = !{!41, !42, !43}
!41 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !39, file: !1, line: 11, baseType: !37, size: 32)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !39, file: !1, line: 12, baseType: !37, size: 32, offset: 32)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !39, file: !1, line: 13, baseType: !44, size: 64, offset: 64)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 64)
!45 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 5, size: 192, elements: !46)
!46 = !{!47, !48}
!47 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !45, file: !1, line: 6, baseType: !10, size: 64)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !45, file: !1, line: 7, baseType: !49, size: 128, offset: 64)
!49 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 128, elements: !50)
!50 = !{!51}
!51 = !DISubrange(count: 2)
!52 = !DILocation(line: 33, column: 15, scope: !34)
!53 = !DILocalVariable(name: "s2", scope: !34, file: !1, line: 34, type: !45)
!54 = !DILocation(line: 34, column: 15, scope: !34)
!55 = !DILocation(line: 36, column: 16, scope: !34)
!56 = !DILocation(line: 36, column: 8, scope: !34)
!57 = !DILocation(line: 36, column: 5, scope: !34)
!58 = !DILocation(line: 36, column: 14, scope: !34)
!59 = !DILocation(line: 37, column: 8, scope: !34)
!60 = !DILocation(line: 37, column: 11, scope: !34)
!61 = !DILocation(line: 39, column: 12, scope: !34)
!62 = !DILocation(line: 39, column: 16, scope: !34)
!63 = !DILocation(line: 39, column: 9, scope: !34)
!64 = !DILocation(line: 39, column: 5, scope: !34)
!65 = !DILocation(line: 41, column: 5, scope: !34)
