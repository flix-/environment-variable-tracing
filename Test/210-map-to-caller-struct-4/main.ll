; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s2 = type { i8*, i8* }
%struct.s1 = type { i8*, %struct.s2 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define { i8*, i8* } @foo() #0 !dbg !7 {
entry:
  %retval = alloca %struct.s2, align 8
  %s1 = alloca %struct.s1, align 8
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !16, metadata !21), !dbg !22
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !23
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !24
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !25
  store i8* %call, i8** %t2, align 8, !dbg !26
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !27
  %0 = bitcast %struct.s2* %retval to i8*, !dbg !27
  %1 = bitcast %struct.s2* %s21 to i8*, !dbg !27
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 16, i32 8, i1 false), !dbg !27
  %2 = bitcast %struct.s2* %retval to { i8*, i8* }*, !dbg !28
  %3 = load { i8*, i8* }, { i8*, i8* }* %2, align 8, !dbg !28
  ret { i8*, i8* } %3, !dbg !28
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !29 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %coerce = alloca %struct.s2, align 8
  %t1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !33, metadata !21), !dbg !34
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !35
  %call = call { i8*, i8* } @foo(), !dbg !36
  %0 = bitcast %struct.s2* %coerce to { i8*, i8* }*, !dbg !36
  %1 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %0, i32 0, i32 0, !dbg !36
  %2 = extractvalue { i8*, i8* } %call, 0, !dbg !36
  store i8* %2, i8** %1, align 8, !dbg !36
  %3 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %0, i32 0, i32 1, !dbg !36
  %4 = extractvalue { i8*, i8* } %call, 1, !dbg !36
  store i8* %4, i8** %3, align 8, !dbg !36
  %5 = bitcast %struct.s2* %s2 to i8*, !dbg !36
  %6 = bitcast %struct.s2* %coerce to i8*, !dbg !36
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 16, i32 8, i1 false), !dbg !36
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !37, metadata !21), !dbg !38
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !39
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 0, !dbg !40
  %7 = load i8*, i8** %t2, align 8, !dbg !40
  store i8* %7, i8** %t1, align 8, !dbg !38
  ret i32 0, !dbg !41
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/210-map-to-caller-struct-4")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 14, type: !8, isLocal: false, isDefinition: true, scopeLine: 15, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 3, size: 128, elements: !11)
!11 = !{!12, !15}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !10, file: !1, line: 4, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "t3", scope: !10, file: !1, line: 5, baseType: !13, size: 64, offset: 64)
!16 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 16, type: !17)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 8, size: 192, elements: !18)
!18 = !{!19, !20}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !17, file: !1, line: 9, baseType: !13, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !17, file: !1, line: 10, baseType: !10, size: 128, offset: 64)
!21 = !DIExpression()
!22 = !DILocation(line: 16, column: 15, scope: !7)
!23 = !DILocation(line: 17, column: 16, scope: !7)
!24 = !DILocation(line: 17, column: 8, scope: !7)
!25 = !DILocation(line: 17, column: 11, scope: !7)
!26 = !DILocation(line: 17, column: 14, scope: !7)
!27 = !DILocation(line: 19, column: 15, scope: !7)
!28 = !DILocation(line: 19, column: 5, scope: !7)
!29 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 23, type: !30, isLocal: false, isDefinition: true, scopeLine: 24, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!32}
!32 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!33 = !DILocalVariable(name: "s1", scope: !29, file: !1, line: 25, type: !17)
!34 = !DILocation(line: 25, column: 15, scope: !29)
!35 = !DILocation(line: 26, column: 8, scope: !29)
!36 = !DILocation(line: 26, column: 13, scope: !29)
!37 = !DILocalVariable(name: "t1", scope: !29, file: !1, line: 28, type: !13)
!38 = !DILocation(line: 28, column: 11, scope: !29)
!39 = !DILocation(line: 28, column: 19, scope: !29)
!40 = !DILocation(line: 28, column: 22, scope: !29)
!41 = !DILocation(line: 30, column: 5, scope: !29)
