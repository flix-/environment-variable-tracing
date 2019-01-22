; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i8** %s) #0 !dbg !7 {
entry:
  %s.addr = alloca i8**, align 8
  %t1 = alloca i8*, align 8
  %nt1 = alloca i8*, align 8
  store i8** %s, i8*** %s.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %s.addr, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !16, metadata !14), !dbg !17
  %0 = load i8**, i8*** %s.addr, align 8, !dbg !18
  %arrayidx = getelementptr inbounds i8*, i8** %0, i64 1, !dbg !18
  %1 = load i8*, i8** %arrayidx, align 8, !dbg !18
  store i8* %1, i8** %t1, align 8, !dbg !17
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !19, metadata !14), !dbg !20
  %2 = load i8**, i8*** %s.addr, align 8, !dbg !21
  %arrayidx1 = getelementptr inbounds i8*, i8** %2, i64 2, !dbg !21
  %3 = load i8*, i8** %arrayidx1, align 8, !dbg !21
  store i8* %3, i8** %nt1, align 8, !dbg !20
  ret void, !dbg !22
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !23 {
entry:
  %retval = alloca i32, align 4
  %s = alloca [42 x i8*], align 16
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [42 x i8*]* %s, metadata !27, metadata !14), !dbg !31
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !32
  %arrayidx = getelementptr inbounds [42 x i8*], [42 x i8*]* %s, i64 0, i64 1, !dbg !33
  store i8* %call, i8** %arrayidx, align 8, !dbg !34
  %arraydecay = getelementptr inbounds [42 x i8*], [42 x i8*]* %s, i32 0, i32 0, !dbg !35
  call void @foo(i8** %arraydecay), !dbg !36
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-array-1")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 4, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!13 = !DILocalVariable(name: "s", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!14 = !DIExpression()
!15 = !DILocation(line: 4, column: 11, scope: !7)
!16 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 6, type: !11)
!17 = !DILocation(line: 6, column: 11, scope: !7)
!18 = !DILocation(line: 6, column: 16, scope: !7)
!19 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 7, type: !11)
!20 = !DILocation(line: 7, column: 11, scope: !7)
!21 = !DILocation(line: 7, column: 17, scope: !7)
!22 = !DILocation(line: 8, column: 1, scope: !7)
!23 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !24, isLocal: false, isDefinition: true, scopeLine: 12, isOptimized: false, unit: !0, variables: !2)
!24 = !DISubroutineType(types: !25)
!25 = !{!26}
!26 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!27 = !DILocalVariable(name: "s", scope: !23, file: !1, line: 13, type: !28)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 2688, elements: !29)
!29 = !{!30}
!30 = !DISubrange(count: 42)
!31 = !DILocation(line: 13, column: 11, scope: !23)
!32 = !DILocation(line: 14, column: 12, scope: !23)
!33 = !DILocation(line: 14, column: 5, scope: !23)
!34 = !DILocation(line: 14, column: 10, scope: !23)
!35 = !DILocation(line: 16, column: 9, scope: !23)
!36 = !DILocation(line: 16, column: 5, scope: !23)
!37 = !DILocation(line: 18, column: 5, scope: !23)
