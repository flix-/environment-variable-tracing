; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { %union.u1, %union.u3 }
%union.u1 = type { %union.u2 }
%union.u2 = type { i8* }
%union.u3 = type { i8* }

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"no_taint\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  %tainted = alloca i8*, align 8
  %not_tainted = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !11, metadata !32), !dbg !33
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !34
  %u = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !35
  %u1 = bitcast %union.u1* %u to %union.u2*, !dbg !36
  %u2 = bitcast %union.u2* %u1 to %union.u3*, !dbg !37
  %taint = bitcast %union.u3* %u2 to i8**, !dbg !38
  store i8* %call, i8** %taint, align 8, !dbg !39
  %uuu = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !40
  %taint3 = bitcast %union.u3* %uuu to i8**, !dbg !41
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i32 0, i32 0), i8** %taint3, align 8, !dbg !42
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !43, metadata !32), !dbg !44
  %u4 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !45
  %u5 = bitcast %union.u1* %u4 to %union.u2*, !dbg !46
  %u6 = bitcast %union.u2* %u5 to %union.u3*, !dbg !47
  %taint7 = bitcast %union.u3* %u6 to i8**, !dbg !48
  %0 = load i8*, i8** %taint7, align 8, !dbg !48
  store i8* %0, i8** %tainted, align 8, !dbg !44
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !49, metadata !32), !dbg !50
  %uuu8 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !51
  %taint9 = bitcast %union.u3* %uuu8 to i8**, !dbg !52
  %1 = load i8*, i8** %taint9, align 8, !dbg !52
  store i8* %1, i8** %not_tainted, align 8, !dbg !50
  ret i32 0, !dbg !53
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/111-unions-6")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 27, type: !8, isLocal: false, isDefinition: true, scopeLine: 28, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 29, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 21, size: 128, elements: !13)
!13 = !{!14, !31}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !12, file: !1, line: 22, baseType: !15, size: 64)
!15 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u1", file: !1, line: 16, size: 64, elements: !16)
!16 = !{!17, !30}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !15, file: !1, line: 17, baseType: !18, size: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u2", file: !1, line: 10, size: 64, elements: !19)
!19 = !{!20, !23, !25}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !18, file: !1, line: 11, baseType: !21, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "d", scope: !18, file: !1, line: 12, baseType: !24, size: 64)
!24 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !18, file: !1, line: 13, baseType: !26, size: 64)
!26 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u3", file: !1, line: 5, size: 64, elements: !27)
!27 = !{!28, !29}
!28 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !26, file: !1, line: 6, baseType: !21, size: 64)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "tainted", scope: !26, file: !1, line: 7, baseType: !21, size: 64)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !15, file: !1, line: 18, baseType: !21, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "uuu", scope: !12, file: !1, line: 23, baseType: !26, size: 64, offset: 64)
!32 = !DIExpression()
!33 = !DILocation(line: 29, column: 15, scope: !7)
!34 = !DILocation(line: 30, column: 21, scope: !7)
!35 = !DILocation(line: 30, column: 7, scope: !7)
!36 = !DILocation(line: 30, column: 9, scope: !7)
!37 = !DILocation(line: 30, column: 11, scope: !7)
!38 = !DILocation(line: 30, column: 13, scope: !7)
!39 = !DILocation(line: 30, column: 19, scope: !7)
!40 = !DILocation(line: 31, column: 7, scope: !7)
!41 = !DILocation(line: 31, column: 11, scope: !7)
!42 = !DILocation(line: 31, column: 17, scope: !7)
!43 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 33, type: !21)
!44 = !DILocation(line: 33, column: 11, scope: !7)
!45 = !DILocation(line: 33, column: 23, scope: !7)
!46 = !DILocation(line: 33, column: 25, scope: !7)
!47 = !DILocation(line: 33, column: 27, scope: !7)
!48 = !DILocation(line: 33, column: 29, scope: !7)
!49 = !DILocalVariable(name: "not_tainted", scope: !7, file: !1, line: 34, type: !21)
!50 = !DILocation(line: 34, column: 11, scope: !7)
!51 = !DILocation(line: 34, column: 27, scope: !7)
!52 = !DILocation(line: 34, column: 31, scope: !7)
!53 = !DILocation(line: 36, column: 5, scope: !7)
