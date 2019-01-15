; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i32, %struct.s2, i8* }
%struct.s2 = type { i8*, i8* }

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  %ss = alloca %struct.s2, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !11, metadata !23), !dbg !24
  call void @llvm.dbg.declare(metadata %struct.s2* %ss, metadata !25, metadata !23), !dbg !26
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !27
  %s1 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !28
  %tainted = getelementptr inbounds %struct.s2, %struct.s2* %s1, i32 0, i32 0, !dbg !29
  store i8* %call, i8** %tainted, align 8, !dbg !30
  %0 = bitcast %struct.s2* %ss to i8*, !dbg !31
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !32
  %1 = bitcast %struct.s2* %s2 to i8*, !dbg !31
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 1024, i32 8, i1 false), !dbg !31
  ret i32 0, !dbg !33
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/121-memcpy-6")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 19, type: !8, isLocal: false, isDefinition: true, scopeLine: 20, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 21, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 12, size: 256, elements: !13)
!13 = !{!14, !15, !22}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 13, baseType: !10, size: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !12, file: !1, line: 14, baseType: !16, size: 128, offset: 64)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 7, size: 128, elements: !17)
!17 = !{!18, !21}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "tainted", scope: !16, file: !1, line: 8, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "untainted", scope: !16, file: !1, line: 9, baseType: !19, size: 64, offset: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "tainted", scope: !12, file: !1, line: 15, baseType: !19, size: 64, offset: 192)
!23 = !DIExpression()
!24 = !DILocation(line: 21, column: 15, scope: !7)
!25 = !DILocalVariable(name: "ss", scope: !7, file: !1, line: 22, type: !16)
!26 = !DILocation(line: 22, column: 15, scope: !7)
!27 = !DILocation(line: 23, column: 19, scope: !7)
!28 = !DILocation(line: 23, column: 7, scope: !7)
!29 = !DILocation(line: 23, column: 9, scope: !7)
!30 = !DILocation(line: 23, column: 17, scope: !7)
!31 = !DILocation(line: 25, column: 5, scope: !7)
!32 = !DILocation(line: 25, column: 20, scope: !7)
!33 = !DILocation(line: 27, column: 5, scope: !7)
