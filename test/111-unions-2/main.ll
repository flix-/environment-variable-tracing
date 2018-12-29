; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.u1 = type { double }
%union.u2 = type { i8* }

@.str = private unnamed_addr constant [12 x i8] c"hello world\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %un = alloca %union.u1, align 8
  %a = alloca i8*, align 8
  %b = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %union.u1* %un, metadata !11, metadata !24), !dbg !25
  %call = call i8* @getenv(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0)), !dbg !26
  %u = bitcast %union.u1* %un to %union.u2*, !dbg !27
  %taint = bitcast %union.u2* %u to i8**, !dbg !28
  store i8* %call, i8** %taint, align 8, !dbg !29
  call void @llvm.dbg.declare(metadata i8** %a, metadata !30, metadata !24), !dbg !31
  %u1 = bitcast %union.u1* %un to %union.u2*, !dbg !32
  %taint2 = bitcast %union.u2* %u1 to i8**, !dbg !33
  %0 = load i8*, i8** %taint2, align 8, !dbg !33
  store i8* %0, i8** %a, align 8, !dbg !31
  %a3 = bitcast %union.u1* %un to i32*, !dbg !34
  store i32 1, i32* %a3, align 8, !dbg !35
  call void @llvm.dbg.declare(metadata i8** %b, metadata !36, metadata !24), !dbg !37
  %u4 = bitcast %union.u1* %un to %union.u2*, !dbg !38
  %taint5 = bitcast %union.u2* %u4 to i8**, !dbg !39
  %1 = load i8*, i8** %taint5, align 8, !dbg !39
  store i8* %1, i8** %b, align 8, !dbg !37
  ret i32 0, !dbg !40
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/111-unions-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !8, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "un", scope: !7, file: !1, line: 19, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u1", file: !1, line: 10, size: 64, elements: !13)
!13 = !{!14, !15, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 11, baseType: !10, size: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !12, file: !1, line: 12, baseType: !16, size: 64)
!16 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !12, file: !1, line: 13, baseType: !18, size: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u2", file: !1, line: 5, size: 64, elements: !19)
!19 = !{!20, !21}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !18, file: !1, line: 6, baseType: !10, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !18, file: !1, line: 7, baseType: !22, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!24 = !DIExpression()
!25 = !DILocation(line: 19, column: 14, scope: !7)
!26 = !DILocation(line: 20, column: 18, scope: !7)
!27 = !DILocation(line: 20, column: 8, scope: !7)
!28 = !DILocation(line: 20, column: 10, scope: !7)
!29 = !DILocation(line: 20, column: 16, scope: !7)
!30 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 22, type: !22)
!31 = !DILocation(line: 22, column: 11, scope: !7)
!32 = !DILocation(line: 22, column: 18, scope: !7)
!33 = !DILocation(line: 22, column: 20, scope: !7)
!34 = !DILocation(line: 24, column: 8, scope: !7)
!35 = !DILocation(line: 24, column: 10, scope: !7)
!36 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 26, type: !22)
!37 = !DILocation(line: 26, column: 11, scope: !7)
!38 = !DILocation(line: 26, column: 18, scope: !7)
!39 = !DILocation(line: 26, column: 20, scope: !7)
!40 = !DILocation(line: 28, column: 5, scope: !7)
