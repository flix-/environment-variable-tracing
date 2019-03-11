; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s2 = type { i8*, %struct.s3 }
%struct.s3 = type { i32*, i32*, i8* }
%struct.s1 = type { i32, i32, %struct.s2* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i8* %tainted) #0 !dbg !7 {
entry:
  %tainted.addr = alloca i8*, align 8
  %also_tainted = alloca i8*, align 8
  store i8* %tainted, i8** %tainted.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %tainted.addr, metadata !12, metadata !13), !dbg !14
  call void @llvm.dbg.declare(metadata i8** %also_tainted, metadata !15, metadata !13), !dbg !16
  %0 = load i8*, i8** %tainted.addr, align 8, !dbg !17
  store i8* %0, i8** %also_tainted, align 8, !dbg !16
  ret void, !dbg !18
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !19 {
entry:
  %retval = alloca i32, align 4
  %s2 = alloca %struct.s2, align 8
  %s1 = alloca %struct.s1, align 8
  %t12 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !23, metadata !13), !dbg !34
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !35
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !36
  %t1 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 2, !dbg !37
  store i8* %call, i8** %t1, align 8, !dbg !38
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !39, metadata !13), !dbg !46
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !47
  store %struct.s2* %s2, %struct.s2** %s21, align 8, !dbg !48
  call void @llvm.dbg.declare(metadata i8** %t12, metadata !49, metadata !13), !dbg !50
  %s23 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !51
  %0 = load %struct.s2*, %struct.s2** %s23, align 8, !dbg !51
  %s34 = getelementptr inbounds %struct.s2, %struct.s2* %0, i32 0, i32 1, !dbg !52
  %t15 = getelementptr inbounds %struct.s3, %struct.s3* %s34, i32 0, i32 2, !dbg !53
  %1 = load i8*, i8** %t15, align 8, !dbg !53
  store i8* %1, i8** %t12, align 8, !dbg !50
  %s26 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !54
  %2 = load %struct.s2*, %struct.s2** %s26, align 8, !dbg !54
  %s37 = getelementptr inbounds %struct.s2, %struct.s2* %2, i32 0, i32 1, !dbg !55
  %t18 = getelementptr inbounds %struct.s3, %struct.s3* %s37, i32 0, i32 2, !dbg !56
  %3 = load i8*, i8** %t18, align 8, !dbg !56
  call void @foo(i8* %3), !dbg !57
  ret i32 0, !dbg !58
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-random-1")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 21, type: !8, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !DILocalVariable(name: "tainted", arg: 1, scope: !7, file: !1, line: 21, type: !10)
!13 = !DIExpression()
!14 = !DILocation(line: 21, column: 11, scope: !7)
!15 = !DILocalVariable(name: "also_tainted", scope: !7, file: !1, line: 23, type: !10)
!16 = !DILocation(line: 23, column: 11, scope: !7)
!17 = !DILocation(line: 23, column: 26, scope: !7)
!18 = !DILocation(line: 24, column: 1, scope: !7)
!19 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 27, type: !20, isLocal: false, isDefinition: true, scopeLine: 28, isOptimized: false, unit: !0, variables: !2)
!20 = !DISubroutineType(types: !21)
!21 = !{!22}
!22 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!23 = !DILocalVariable(name: "s2", scope: !19, file: !1, line: 29, type: !24)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 9, size: 256, elements: !25)
!25 = !{!26, !27}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !24, file: !1, line: 10, baseType: !10, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !24, file: !1, line: 11, baseType: !28, size: 192, offset: 64)
!28 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 3, size: 192, elements: !29)
!29 = !{!30, !32, !33}
!30 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !28, file: !1, line: 4, baseType: !31, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !28, file: !1, line: 5, baseType: !31, size: 64, offset: 64)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !28, file: !1, line: 6, baseType: !10, size: 64, offset: 128)
!34 = !DILocation(line: 29, column: 15, scope: !19)
!35 = !DILocation(line: 30, column: 16, scope: !19)
!36 = !DILocation(line: 30, column: 8, scope: !19)
!37 = !DILocation(line: 30, column: 11, scope: !19)
!38 = !DILocation(line: 30, column: 14, scope: !19)
!39 = !DILocalVariable(name: "s1", scope: !19, file: !1, line: 31, type: !40)
!40 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 14, size: 128, elements: !41)
!41 = !{!42, !43, !44}
!42 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !40, file: !1, line: 15, baseType: !22, size: 32)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !40, file: !1, line: 16, baseType: !22, size: 32, offset: 32)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !40, file: !1, line: 17, baseType: !45, size: 64, offset: 64)
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!46 = !DILocation(line: 31, column: 15, scope: !19)
!47 = !DILocation(line: 32, column: 8, scope: !19)
!48 = !DILocation(line: 32, column: 11, scope: !19)
!49 = !DILocalVariable(name: "t1", scope: !19, file: !1, line: 34, type: !10)
!50 = !DILocation(line: 34, column: 11, scope: !19)
!51 = !DILocation(line: 34, column: 19, scope: !19)
!52 = !DILocation(line: 34, column: 23, scope: !19)
!53 = !DILocation(line: 34, column: 26, scope: !19)
!54 = !DILocation(line: 36, column: 12, scope: !19)
!55 = !DILocation(line: 36, column: 16, scope: !19)
!56 = !DILocation(line: 36, column: 19, scope: !19)
!57 = !DILocation(line: 36, column: 5, scope: !19)
!58 = !DILocation(line: 38, column: 5, scope: !19)
