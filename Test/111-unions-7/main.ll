; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { %union.u1, i8* }
%union.u1 = type { %struct.s2 }
%struct.s2 = type { [2 x i8*] }

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"untaint\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  %tainted = alloca i8*, align 8
  %not_tainted = alloca i8*, align 8
  %not_tainted2 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !11, metadata !28), !dbg !29
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !30
  %u = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !31
  %s1 = bitcast %union.u1* %u to %struct.s2*, !dbg !32
  %strings = getelementptr inbounds %struct.s2, %struct.s2* %s1, i32 0, i32 0, !dbg !33
  %arrayidx = getelementptr inbounds [2 x i8*], [2 x i8*]* %strings, i64 0, i64 0, !dbg !34
  store i8* %call, i8** %arrayidx, align 8, !dbg !35
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !36, metadata !28), !dbg !37
  %u2 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !38
  %taint = bitcast %union.u1* %u2 to i8**, !dbg !39
  %0 = load i8*, i8** %taint, align 8, !dbg !39
  store i8* %0, i8** %tainted, align 8, !dbg !37
  %u3 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !40
  %s4 = bitcast %union.u1* %u3 to %struct.s2*, !dbg !41
  %strings5 = getelementptr inbounds %struct.s2, %struct.s2* %s4, i32 0, i32 0, !dbg !42
  %arrayidx6 = getelementptr inbounds [2 x i8*], [2 x i8*]* %strings5, i64 0, i64 1, !dbg !43
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i32 0, i32 0), i8** %arrayidx6, align 8, !dbg !44
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !45, metadata !28), !dbg !46
  %u7 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !47
  %s8 = bitcast %union.u1* %u7 to %struct.s2*, !dbg !48
  %strings9 = getelementptr inbounds %struct.s2, %struct.s2* %s8, i32 0, i32 0, !dbg !49
  %arrayidx10 = getelementptr inbounds [2 x i8*], [2 x i8*]* %strings9, i64 0, i64 0, !dbg !50
  %1 = load i8*, i8** %arrayidx10, align 8, !dbg !50
  store i8* %1, i8** %not_tainted, align 8, !dbg !46
  call void @llvm.dbg.declare(metadata i8** %not_tainted2, metadata !51, metadata !28), !dbg !52
  %u11 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !53
  %s12 = bitcast %union.u1* %u11 to %struct.s2*, !dbg !54
  %strings13 = getelementptr inbounds %struct.s2, %struct.s2* %s12, i32 0, i32 0, !dbg !55
  %arrayidx14 = getelementptr inbounds [2 x i8*], [2 x i8*]* %strings13, i64 0, i64 1, !dbg !56
  %2 = load i8*, i8** %arrayidx14, align 8, !dbg !56
  store i8* %2, i8** %not_tainted2, align 8, !dbg !52
  ret i32 0, !dbg !57
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/111-unions-7")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !8, isLocal: false, isDefinition: true, scopeLine: 21, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 22, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 14, size: 192, elements: !13)
!13 = !{!14, !27}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !12, file: !1, line: 15, baseType: !15, size: 128)
!15 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u1", file: !1, line: 9, size: 128, elements: !16)
!16 = !{!17, !20}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !15, file: !1, line: 10, baseType: !18, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !15, file: !1, line: 11, baseType: !21, size: 128)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 5, size: 128, elements: !22)
!22 = !{!23}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "strings", scope: !21, file: !1, line: 6, baseType: !24, size: 128)
!24 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 128, elements: !25)
!25 = !{!26}
!26 = !DISubrange(count: 2)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !12, file: !1, line: 16, baseType: !18, size: 64, offset: 128)
!28 = !DIExpression()
!29 = !DILocation(line: 22, column: 15, scope: !7)
!30 = !DILocation(line: 23, column: 24, scope: !7)
!31 = !DILocation(line: 23, column: 7, scope: !7)
!32 = !DILocation(line: 23, column: 9, scope: !7)
!33 = !DILocation(line: 23, column: 11, scope: !7)
!34 = !DILocation(line: 23, column: 5, scope: !7)
!35 = !DILocation(line: 23, column: 22, scope: !7)
!36 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 25, type: !18)
!37 = !DILocation(line: 25, column: 11, scope: !7)
!38 = !DILocation(line: 25, column: 23, scope: !7)
!39 = !DILocation(line: 25, column: 25, scope: !7)
!40 = !DILocation(line: 26, column: 7, scope: !7)
!41 = !DILocation(line: 26, column: 9, scope: !7)
!42 = !DILocation(line: 26, column: 11, scope: !7)
!43 = !DILocation(line: 26, column: 5, scope: !7)
!44 = !DILocation(line: 26, column: 22, scope: !7)
!45 = !DILocalVariable(name: "not_tainted", scope: !7, file: !1, line: 28, type: !18)
!46 = !DILocation(line: 28, column: 11, scope: !7)
!47 = !DILocation(line: 28, column: 27, scope: !7)
!48 = !DILocation(line: 28, column: 29, scope: !7)
!49 = !DILocation(line: 28, column: 31, scope: !7)
!50 = !DILocation(line: 28, column: 25, scope: !7)
!51 = !DILocalVariable(name: "not_tainted2", scope: !7, file: !1, line: 29, type: !18)
!52 = !DILocation(line: 29, column: 11, scope: !7)
!53 = !DILocation(line: 29, column: 28, scope: !7)
!54 = !DILocation(line: 29, column: 30, scope: !7)
!55 = !DILocation(line: 29, column: 32, scope: !7)
!56 = !DILocation(line: 29, column: 26, scope: !7)
!57 = !DILocation(line: 31, column: 5, scope: !7)
