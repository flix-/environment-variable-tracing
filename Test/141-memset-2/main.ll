; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %struct.s2 }
%struct.s2 = type { i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %t14 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !11, metadata !21), !dbg !22
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !23
  %t1 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !24
  store i8* %call, i8** %t1, align 8, !dbg !25
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !26
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !27
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !28
  store i8* %call1, i8** %t2, align 8, !dbg !29
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !30
  %t23 = getelementptr inbounds %struct.s2, %struct.s2* %s22, i32 0, i32 0, !dbg !31
  %0 = bitcast i8** %t23 to i8*, !dbg !32
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 3, i32 8, i1 false), !dbg !32
  call void @llvm.dbg.declare(metadata i8** %t14, metadata !33, metadata !21), !dbg !34
  %t15 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !35
  %1 = load i8*, i8** %t15, align 8, !dbg !35
  store i8* %1, i8** %t14, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !36, metadata !21), !dbg !37
  %s26 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !38
  %t27 = getelementptr inbounds %struct.s2, %struct.s2* %s26, i32 0, i32 0, !dbg !39
  %2 = load i8*, i8** %t27, align 8, !dbg !39
  store i8* %2, i8** %ut1, align 8, !dbg !37
  ret i32 0, !dbg !40
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/141-memset-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !8, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 19, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 11, size: 128, elements: !13)
!13 = !{!14, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !12, file: !1, line: 12, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !12, file: !1, line: 13, baseType: !18, size: 64, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 7, size: 64, elements: !19)
!19 = !{!20}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !18, file: !1, line: 8, baseType: !15, size: 64)
!21 = !DIExpression()
!22 = !DILocation(line: 19, column: 15, scope: !7)
!23 = !DILocation(line: 20, column: 13, scope: !7)
!24 = !DILocation(line: 20, column: 8, scope: !7)
!25 = !DILocation(line: 20, column: 11, scope: !7)
!26 = !DILocation(line: 21, column: 16, scope: !7)
!27 = !DILocation(line: 21, column: 8, scope: !7)
!28 = !DILocation(line: 21, column: 11, scope: !7)
!29 = !DILocation(line: 21, column: 14, scope: !7)
!30 = !DILocation(line: 23, column: 16, scope: !7)
!31 = !DILocation(line: 23, column: 19, scope: !7)
!32 = !DILocation(line: 23, column: 5, scope: !7)
!33 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 25, type: !15)
!34 = !DILocation(line: 25, column: 11, scope: !7)
!35 = !DILocation(line: 25, column: 19, scope: !7)
!36 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 26, type: !15)
!37 = !DILocation(line: 26, column: 11, scope: !7)
!38 = !DILocation(line: 26, column: 20, scope: !7)
!39 = !DILocation(line: 26, column: 23, scope: !7)
!40 = !DILocation(line: 28, column: 5, scope: !7)
