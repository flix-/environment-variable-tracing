; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.a = type { i8* }

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i8* %f.coerce) #0 !dbg !7 {
entry:
  %f = alloca %union.a, align 8
  %tainted = alloca i8*, align 8
  %coerce.dive = getelementptr inbounds %union.a, %union.a* %f, i32 0, i32 0
  store i8* %f.coerce, i8** %coerce.dive, align 8
  call void @llvm.dbg.declare(metadata %union.a* %f, metadata !15, metadata !16), !dbg !17
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !18, metadata !16), !dbg !19
  %tainted1 = bitcast %union.a* %f to i8**, !dbg !20
  %0 = load i8*, i8** %tainted1, align 8, !dbg !20
  store i8* %0, i8** %tainted, align 8, !dbg !19
  ret void, !dbg !21
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !22 {
entry:
  %retval = alloca i32, align 4
  %f = alloca %union.a, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %union.a* %f, metadata !26, metadata !16), !dbg !27
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !28
  %tainted = bitcast %union.a* %f to i8**, !dbg !29
  store i8* %call, i8** %tainted, align 8, !dbg !30
  %coerce.dive = getelementptr inbounds %union.a, %union.a* %f, i32 0, i32 0, !dbg !31
  %0 = load i8*, i8** %coerce.dive, align 8, !dbg !31
  call void @foo(i8* %0), !dbg !31
  ret i32 0, !dbg !32
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-union-1")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 8, type: !8, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "a", file: !1, line: 3, size: 64, elements: !11)
!11 = !{!12}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "tainted", scope: !10, file: !1, line: 4, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !DILocalVariable(name: "f", arg: 1, scope: !7, file: !1, line: 8, type: !10)
!16 = !DIExpression()
!17 = !DILocation(line: 8, column: 13, scope: !7)
!18 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 10, type: !13)
!19 = !DILocation(line: 10, column: 11, scope: !7)
!20 = !DILocation(line: 10, column: 23, scope: !7)
!21 = !DILocation(line: 11, column: 1, scope: !7)
!22 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 14, type: !23, isLocal: false, isDefinition: true, scopeLine: 15, isOptimized: false, unit: !0, variables: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{!25}
!25 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!26 = !DILocalVariable(name: "f", scope: !22, file: !1, line: 16, type: !10)
!27 = !DILocation(line: 16, column: 13, scope: !22)
!28 = !DILocation(line: 17, column: 17, scope: !22)
!29 = !DILocation(line: 17, column: 7, scope: !22)
!30 = !DILocation(line: 17, column: 15, scope: !22)
!31 = !DILocation(line: 19, column: 5, scope: !22)
!32 = !DILocation(line: 21, column: 5, scope: !22)
