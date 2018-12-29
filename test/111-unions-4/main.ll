; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %union.u1, i32 }
%union.u1 = type { %struct.s2 }
%struct.s2 = type { [2 x %union.u2] }
%union.u2 = type { i8* }

@.str = private unnamed_addr constant [12 x i8] c"hello world\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  %also_tainted = alloca i8*, align 8
  %not_tainted = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !11, metadata !35), !dbg !36
  %call = call i8* @getenv(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0)), !dbg !37
  %u = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !38
  %s1 = bitcast %union.u1* %u to %struct.s2*, !dbg !39
  %u2 = getelementptr inbounds %struct.s2, %struct.s2* %s1, i32 0, i32 0, !dbg !40
  %arrayidx = getelementptr inbounds [2 x %union.u2], [2 x %union.u2]* %u2, i64 0, i64 0, !dbg !41
  %taint = bitcast %union.u2* %arrayidx to i8**, !dbg !42
  store i8* %call, i8** %taint, align 8, !dbg !43
  call void @llvm.dbg.declare(metadata i8** %also_tainted, metadata !44, metadata !35), !dbg !45
  %u3 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !46
  %s4 = bitcast %union.u1* %u3 to %struct.s2*, !dbg !47
  %u5 = getelementptr inbounds %struct.s2, %struct.s2* %s4, i32 0, i32 0, !dbg !48
  %arrayidx6 = getelementptr inbounds [2 x %union.u2], [2 x %union.u2]* %u5, i64 0, i64 0, !dbg !49
  %taint7 = bitcast %union.u2* %arrayidx6 to i8**, !dbg !50
  %0 = load i8*, i8** %taint7, align 8, !dbg !50
  store i8* %0, i8** %also_tainted, align 8, !dbg !45
  %u8 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !51
  %a = bitcast %union.u1* %u8 to i32*, !dbg !52
  store i32 1, i32* %a, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !54, metadata !35), !dbg !55
  %u9 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !56
  %s10 = bitcast %union.u1* %u9 to %struct.s2*, !dbg !57
  %u11 = getelementptr inbounds %struct.s2, %struct.s2* %s10, i32 0, i32 0, !dbg !58
  %arrayidx12 = getelementptr inbounds [2 x %union.u2], [2 x %union.u2]* %u11, i64 0, i64 0, !dbg !59
  %taint13 = bitcast %union.u2* %arrayidx12 to i8**, !dbg !60
  %1 = load i8*, i8** %taint13, align 8, !dbg !60
  store i8* %1, i8** %not_tainted, align 8, !dbg !55
  ret i32 0, !dbg !61
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/111-unions-4")
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
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 20, size: 256, elements: !13)
!13 = !{!14, !17, !34}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !12, file: !1, line: 21, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !12, file: !1, line: 22, baseType: !18, size: 128, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u1", file: !1, line: 14, size: 128, elements: !19)
!19 = !{!20, !21, !23}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !18, file: !1, line: 15, baseType: !10, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !18, file: !1, line: 16, baseType: !22, size: 64)
!22 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !18, file: !1, line: 17, baseType: !24, size: 128)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 10, size: 128, elements: !25)
!25 = !{!26}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !24, file: !1, line: 11, baseType: !27, size: 128)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 128, elements: !32)
!28 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u2", file: !1, line: 5, size: 64, elements: !29)
!29 = !{!30, !31}
!30 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !28, file: !1, line: 6, baseType: !10, size: 32)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !28, file: !1, line: 7, baseType: !15, size: 64)
!32 = !{!33}
!33 = !DISubrange(count: 2)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 23, baseType: !10, size: 32, offset: 192)
!35 = !DIExpression()
!36 = !DILocation(line: 29, column: 15, scope: !7)
!37 = !DILocation(line: 30, column: 24, scope: !7)
!38 = !DILocation(line: 30, column: 7, scope: !7)
!39 = !DILocation(line: 30, column: 9, scope: !7)
!40 = !DILocation(line: 30, column: 11, scope: !7)
!41 = !DILocation(line: 30, column: 5, scope: !7)
!42 = !DILocation(line: 30, column: 16, scope: !7)
!43 = !DILocation(line: 30, column: 22, scope: !7)
!44 = !DILocalVariable(name: "also_tainted", scope: !7, file: !1, line: 31, type: !15)
!45 = !DILocation(line: 31, column: 11, scope: !7)
!46 = !DILocation(line: 31, column: 28, scope: !7)
!47 = !DILocation(line: 31, column: 30, scope: !7)
!48 = !DILocation(line: 31, column: 32, scope: !7)
!49 = !DILocation(line: 31, column: 26, scope: !7)
!50 = !DILocation(line: 31, column: 37, scope: !7)
!51 = !DILocation(line: 33, column: 7, scope: !7)
!52 = !DILocation(line: 33, column: 9, scope: !7)
!53 = !DILocation(line: 33, column: 11, scope: !7)
!54 = !DILocalVariable(name: "not_tainted", scope: !7, file: !1, line: 34, type: !15)
!55 = !DILocation(line: 34, column: 11, scope: !7)
!56 = !DILocation(line: 34, column: 27, scope: !7)
!57 = !DILocation(line: 34, column: 29, scope: !7)
!58 = !DILocation(line: 34, column: 31, scope: !7)
!59 = !DILocation(line: 34, column: 25, scope: !7)
!60 = !DILocation(line: 34, column: 36, scope: !7)
!61 = !DILocation(line: 36, column: 5, scope: !7)
