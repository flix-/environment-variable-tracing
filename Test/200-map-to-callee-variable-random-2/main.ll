; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s2 = type { i8*, %struct.s3 }
%struct.s3 = type { i32*, i32*, i8* }
%struct.s1 = type { i32, i32, %struct.s2* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(%struct.s2* %s2) #0 !dbg !7 {
entry:
  %s2.addr = alloca %struct.s2*, align 8
  %also_tainted = alloca i8*, align 8
  %nt1 = alloca i8*, align 8
  %nt2 = alloca i32*, align 8
  %nt3 = alloca i32*, align 8
  store %struct.s2* %s2, %struct.s2** %s2.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.s2** %s2.addr, metadata !24, metadata !25), !dbg !26
  call void @llvm.dbg.declare(metadata i8** %also_tainted, metadata !27, metadata !25), !dbg !28
  %0 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !29
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %0, i32 0, i32 1, !dbg !30
  %t1 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 2, !dbg !31
  %1 = load i8*, i8** %t1, align 8, !dbg !31
  store i8* %1, i8** %also_tainted, align 8, !dbg !28
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !32, metadata !25), !dbg !33
  %2 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !34
  %t11 = getelementptr inbounds %struct.s2, %struct.s2* %2, i32 0, i32 0, !dbg !35
  %3 = load i8*, i8** %t11, align 8, !dbg !35
  store i8* %3, i8** %nt1, align 8, !dbg !33
  call void @llvm.dbg.declare(metadata i32** %nt2, metadata !36, metadata !25), !dbg !37
  %4 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !38
  %s32 = getelementptr inbounds %struct.s2, %struct.s2* %4, i32 0, i32 1, !dbg !39
  %a = getelementptr inbounds %struct.s3, %struct.s3* %s32, i32 0, i32 0, !dbg !40
  %5 = load i32*, i32** %a, align 8, !dbg !40
  store i32* %5, i32** %nt2, align 8, !dbg !37
  call void @llvm.dbg.declare(metadata i32** %nt3, metadata !41, metadata !25), !dbg !42
  %6 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !43
  %s33 = getelementptr inbounds %struct.s2, %struct.s2* %6, i32 0, i32 1, !dbg !44
  %b = getelementptr inbounds %struct.s3, %struct.s3* %s33, i32 0, i32 1, !dbg !45
  %7 = load i32*, i32** %b, align 8, !dbg !45
  store i32* %7, i32** %nt3, align 8, !dbg !42
  ret void, !dbg !46
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !47 {
entry:
  %retval = alloca i32, align 4
  %s2 = alloca %struct.s2, align 8
  %s1 = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !50, metadata !25), !dbg !51
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !52
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !53
  %t1 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 2, !dbg !54
  store i8* %call, i8** %t1, align 8, !dbg !55
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !56, metadata !25), !dbg !62
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !63
  store %struct.s2* %s2, %struct.s2** %s21, align 8, !dbg !64
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !65
  %0 = load %struct.s2*, %struct.s2** %s22, align 8, !dbg !65
  call void @foo(%struct.s2* %0), !dbg !66
  ret i32 0, !dbg !67
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-random-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 21, type: !8, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 9, size: 256, elements: !12)
!12 = !{!13, !16}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !11, file: !1, line: 10, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !11, file: !1, line: 11, baseType: !17, size: 192, offset: 64)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 3, size: 192, elements: !18)
!18 = !{!19, !22, !23}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !17, file: !1, line: 4, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !17, file: !1, line: 5, baseType: !20, size: 64, offset: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !17, file: !1, line: 6, baseType: !14, size: 64, offset: 128)
!24 = !DILocalVariable(name: "s2", arg: 1, scope: !7, file: !1, line: 21, type: !10)
!25 = !DIExpression()
!26 = !DILocation(line: 21, column: 16, scope: !7)
!27 = !DILocalVariable(name: "also_tainted", scope: !7, file: !1, line: 23, type: !14)
!28 = !DILocation(line: 23, column: 11, scope: !7)
!29 = !DILocation(line: 23, column: 26, scope: !7)
!30 = !DILocation(line: 23, column: 30, scope: !7)
!31 = !DILocation(line: 23, column: 33, scope: !7)
!32 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 24, type: !14)
!33 = !DILocation(line: 24, column: 11, scope: !7)
!34 = !DILocation(line: 24, column: 17, scope: !7)
!35 = !DILocation(line: 24, column: 21, scope: !7)
!36 = !DILocalVariable(name: "nt2", scope: !7, file: !1, line: 25, type: !20)
!37 = !DILocation(line: 25, column: 10, scope: !7)
!38 = !DILocation(line: 25, column: 16, scope: !7)
!39 = !DILocation(line: 25, column: 20, scope: !7)
!40 = !DILocation(line: 25, column: 23, scope: !7)
!41 = !DILocalVariable(name: "nt3", scope: !7, file: !1, line: 26, type: !20)
!42 = !DILocation(line: 26, column: 10, scope: !7)
!43 = !DILocation(line: 26, column: 16, scope: !7)
!44 = !DILocation(line: 26, column: 20, scope: !7)
!45 = !DILocation(line: 26, column: 23, scope: !7)
!46 = !DILocation(line: 27, column: 1, scope: !7)
!47 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 30, type: !48, isLocal: false, isDefinition: true, scopeLine: 31, isOptimized: false, unit: !0, variables: !2)
!48 = !DISubroutineType(types: !49)
!49 = !{!21}
!50 = !DILocalVariable(name: "s2", scope: !47, file: !1, line: 32, type: !11)
!51 = !DILocation(line: 32, column: 15, scope: !47)
!52 = !DILocation(line: 33, column: 16, scope: !47)
!53 = !DILocation(line: 33, column: 8, scope: !47)
!54 = !DILocation(line: 33, column: 11, scope: !47)
!55 = !DILocation(line: 33, column: 14, scope: !47)
!56 = !DILocalVariable(name: "s1", scope: !47, file: !1, line: 34, type: !57)
!57 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 14, size: 128, elements: !58)
!58 = !{!59, !60, !61}
!59 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !57, file: !1, line: 15, baseType: !21, size: 32)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !57, file: !1, line: 16, baseType: !21, size: 32, offset: 32)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !57, file: !1, line: 17, baseType: !10, size: 64, offset: 64)
!62 = !DILocation(line: 34, column: 15, scope: !47)
!63 = !DILocation(line: 35, column: 8, scope: !47)
!64 = !DILocation(line: 35, column: 11, scope: !47)
!65 = !DILocation(line: 37, column: 12, scope: !47)
!66 = !DILocation(line: 37, column: 5, scope: !47)
!67 = !DILocation(line: 39, column: 5, scope: !47)
