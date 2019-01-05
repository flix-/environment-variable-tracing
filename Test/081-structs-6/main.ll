; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.a = type { i32, %struct.b }
%struct.b = type { i8* }

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.a, align 8
  %tainted = alloca i8*, align 8
  %s2_inner = alloca %struct.b, align 8
  %not_tainted = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.a* %s1, metadata !11, metadata !21), !dbg !22
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !23
  %b = getelementptr inbounds %struct.a, %struct.a* %s1, i32 0, i32 1, !dbg !24
  %taint = getelementptr inbounds %struct.b, %struct.b* %b, i32 0, i32 0, !dbg !25
  store i8* %call, i8** %taint, align 8, !dbg !26
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !27, metadata !21), !dbg !28
  %b1 = getelementptr inbounds %struct.a, %struct.a* %s1, i32 0, i32 1, !dbg !29
  %taint2 = getelementptr inbounds %struct.b, %struct.b* %b1, i32 0, i32 0, !dbg !30
  %0 = load i8*, i8** %taint2, align 8, !dbg !30
  store i8* %0, i8** %tainted, align 8, !dbg !28
  call void @llvm.dbg.declare(metadata %struct.b* %s2_inner, metadata !31, metadata !21), !dbg !32
  %b3 = getelementptr inbounds %struct.a, %struct.a* %s1, i32 0, i32 1, !dbg !33
  %1 = bitcast %struct.b* %b3 to i8*, !dbg !34
  %2 = bitcast %struct.b* %s2_inner to i8*, !dbg !34
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %2, i64 8, i32 8, i1 false), !dbg !34
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !35, metadata !21), !dbg !36
  %b4 = getelementptr inbounds %struct.a, %struct.a* %s1, i32 0, i32 1, !dbg !37
  %taint5 = getelementptr inbounds %struct.b, %struct.b* %b4, i32 0, i32 0, !dbg !38
  %3 = load i8*, i8** %taint5, align 8, !dbg !38
  store i8* %3, i8** %not_tainted, align 8, !dbg !36
  ret i32 0, !dbg !39
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/081-structs-6")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 15, type: !8, isLocal: false, isDefinition: true, scopeLine: 16, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 17, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "a", file: !1, line: 9, size: 128, elements: !13)
!13 = !{!14, !15}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 10, baseType: !10, size: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !12, file: !1, line: 11, baseType: !16, size: 64, offset: 64)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "b", file: !1, line: 5, size: 64, elements: !17)
!17 = !{!18}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !16, file: !1, line: 6, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!21 = !DIExpression()
!22 = !DILocation(line: 17, column: 14, scope: !7)
!23 = !DILocation(line: 18, column: 18, scope: !7)
!24 = !DILocation(line: 18, column: 8, scope: !7)
!25 = !DILocation(line: 18, column: 10, scope: !7)
!26 = !DILocation(line: 18, column: 16, scope: !7)
!27 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 20, type: !19)
!28 = !DILocation(line: 20, column: 11, scope: !7)
!29 = !DILocation(line: 20, column: 24, scope: !7)
!30 = !DILocation(line: 20, column: 26, scope: !7)
!31 = !DILocalVariable(name: "s2_inner", scope: !7, file: !1, line: 22, type: !16)
!32 = !DILocation(line: 22, column: 14, scope: !7)
!33 = !DILocation(line: 23, column: 8, scope: !7)
!34 = !DILocation(line: 23, column: 12, scope: !7)
!35 = !DILocalVariable(name: "not_tainted", scope: !7, file: !1, line: 25, type: !19)
!36 = !DILocation(line: 25, column: 11, scope: !7)
!37 = !DILocation(line: 25, column: 28, scope: !7)
!38 = !DILocation(line: 25, column: 30, scope: !7)
!39 = !DILocation(line: 27, column: 5, scope: !7)
