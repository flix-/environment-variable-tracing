; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.a = type { i8* }
%union.b = type { i8* }

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i8* %ua.coerce) #0 !dbg !7 {
entry:
  %ua = alloca %union.a, align 8
  %tainted = alloca i8*, align 8
  %coerce.dive = getelementptr inbounds %union.a, %union.a* %ua, i32 0, i32 0
  store i8* %ua.coerce, i8** %coerce.dive, align 8
  call void @llvm.dbg.declare(metadata %union.a* %ua, metadata !19, metadata !20), !dbg !21
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !22, metadata !20), !dbg !23
  %foo = bitcast %union.a* %ua to i8**, !dbg !24
  %0 = load i8*, i8** %foo, align 8, !dbg !24
  store i8* %0, i8** %tainted, align 8, !dbg !23
  ret void, !dbg !25
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !26 {
entry:
  %retval = alloca i32, align 4
  %f = alloca %union.a, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %union.a* %f, metadata !30, metadata !20), !dbg !31
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !32
  %ub = bitcast %union.a* %f to %union.b*, !dbg !33
  %tainted = bitcast %union.b* %ub to i8**, !dbg !34
  store i8* %call, i8** %tainted, align 8, !dbg !35
  %coerce.dive = getelementptr inbounds %union.a, %union.a* %f, i32 0, i32 0, !dbg !36
  %0 = load i8*, i8** %coerce.dive, align 8, !dbg !36
  call void @foo(i8* %0), !dbg !36
  ret i32 0, !dbg !37
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-union-3")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 13, type: !8, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "a", file: !1, line: 7, size: 64, elements: !11)
!11 = !{!12, !15}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "foo", scope: !10, file: !1, line: 8, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "ub", scope: !10, file: !1, line: 9, baseType: !16, size: 64)
!16 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "b", file: !1, line: 3, size: 64, elements: !17)
!17 = !{!18}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "tainted", scope: !16, file: !1, line: 4, baseType: !13, size: 64)
!19 = !DILocalVariable(name: "ua", arg: 1, scope: !7, file: !1, line: 13, type: !10)
!20 = !DIExpression()
!21 = !DILocation(line: 13, column: 13, scope: !7)
!22 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 15, type: !13)
!23 = !DILocation(line: 15, column: 11, scope: !7)
!24 = !DILocation(line: 15, column: 24, scope: !7)
!25 = !DILocation(line: 16, column: 1, scope: !7)
!26 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 19, type: !27, isLocal: false, isDefinition: true, scopeLine: 20, isOptimized: false, unit: !0, variables: !2)
!27 = !DISubroutineType(types: !28)
!28 = !{!29}
!29 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!30 = !DILocalVariable(name: "f", scope: !26, file: !1, line: 21, type: !10)
!31 = !DILocation(line: 21, column: 13, scope: !26)
!32 = !DILocation(line: 22, column: 20, scope: !26)
!33 = !DILocation(line: 22, column: 7, scope: !26)
!34 = !DILocation(line: 22, column: 10, scope: !26)
!35 = !DILocation(line: 22, column: 18, scope: !26)
!36 = !DILocation(line: 24, column: 5, scope: !26)
!37 = !DILocation(line: 26, column: 5, scope: !26)
