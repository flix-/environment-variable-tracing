; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo([2 x i8*]* %s) #0 !dbg !7 {
entry:
  %s.addr = alloca [2 x i8*]*, align 8
  %nt1 = alloca i8*, align 8
  %t1 = alloca i8*, align 8
  %nt2 = alloca i8*, align 8
  %nt3 = alloca i8*, align 8
  store [2 x i8*]* %s, [2 x i8*]** %s.addr, align 8
  call void @llvm.dbg.declare(metadata [2 x i8*]** %s.addr, metadata !16, metadata !17), !dbg !18
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !19, metadata !17), !dbg !20
  %0 = load [2 x i8*]*, [2 x i8*]** %s.addr, align 8, !dbg !21
  %arrayidx = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, !dbg !21
  %arrayidx1 = getelementptr inbounds [2 x i8*], [2 x i8*]* %arrayidx, i64 0, i64 0, !dbg !21
  %1 = load i8*, i8** %arrayidx1, align 8, !dbg !21
  store i8* %1, i8** %nt1, align 8, !dbg !20
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !22, metadata !17), !dbg !23
  %2 = load [2 x i8*]*, [2 x i8*]** %s.addr, align 8, !dbg !24
  %arrayidx2 = getelementptr inbounds [2 x i8*], [2 x i8*]* %2, i64 0, !dbg !24
  %arrayidx3 = getelementptr inbounds [2 x i8*], [2 x i8*]* %arrayidx2, i64 0, i64 1, !dbg !24
  %3 = load i8*, i8** %arrayidx3, align 8, !dbg !24
  store i8* %3, i8** %t1, align 8, !dbg !23
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !25, metadata !17), !dbg !26
  %4 = load [2 x i8*]*, [2 x i8*]** %s.addr, align 8, !dbg !27
  %arrayidx4 = getelementptr inbounds [2 x i8*], [2 x i8*]* %4, i64 1, !dbg !27
  %arrayidx5 = getelementptr inbounds [2 x i8*], [2 x i8*]* %arrayidx4, i64 0, i64 0, !dbg !27
  %5 = load i8*, i8** %arrayidx5, align 8, !dbg !27
  store i8* %5, i8** %nt2, align 8, !dbg !26
  call void @llvm.dbg.declare(metadata i8** %nt3, metadata !28, metadata !17), !dbg !29
  %6 = load [2 x i8*]*, [2 x i8*]** %s.addr, align 8, !dbg !30
  %arrayidx6 = getelementptr inbounds [2 x i8*], [2 x i8*]* %6, i64 1, !dbg !30
  %arrayidx7 = getelementptr inbounds [2 x i8*], [2 x i8*]* %arrayidx6, i64 0, i64 1, !dbg !30
  %7 = load i8*, i8** %arrayidx7, align 8, !dbg !30
  store i8* %7, i8** %nt3, align 8, !dbg !29
  ret void, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !32 {
entry:
  %retval = alloca i32, align 4
  %s = alloca [2 x [2 x i8*]], align 16
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x [2 x i8*]]* %s, metadata !36, metadata !17), !dbg !39
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !40
  %arrayidx = getelementptr inbounds [2 x [2 x i8*]], [2 x [2 x i8*]]* %s, i64 0, i64 0, !dbg !41
  %arrayidx1 = getelementptr inbounds [2 x i8*], [2 x i8*]* %arrayidx, i64 0, i64 1, !dbg !41
  store i8* %call, i8** %arrayidx1, align 8, !dbg !42
  %arraydecay = getelementptr inbounds [2 x [2 x i8*]], [2 x [2 x i8*]]* %s, i32 0, i32 0, !dbg !43
  call void @foo([2 x i8*]* %arraydecay), !dbg !44
  ret i32 0, !dbg !45
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-array-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 4, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 128, elements: !14)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!14 = !{!15}
!15 = !DISubrange(count: 2)
!16 = !DILocalVariable(name: "s", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!17 = !DIExpression()
!18 = !DILocation(line: 4, column: 11, scope: !7)
!19 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 6, type: !12)
!20 = !DILocation(line: 6, column: 11, scope: !7)
!21 = !DILocation(line: 6, column: 17, scope: !7)
!22 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 7, type: !12)
!23 = !DILocation(line: 7, column: 11, scope: !7)
!24 = !DILocation(line: 7, column: 16, scope: !7)
!25 = !DILocalVariable(name: "nt2", scope: !7, file: !1, line: 8, type: !12)
!26 = !DILocation(line: 8, column: 11, scope: !7)
!27 = !DILocation(line: 8, column: 17, scope: !7)
!28 = !DILocalVariable(name: "nt3", scope: !7, file: !1, line: 9, type: !12)
!29 = !DILocation(line: 9, column: 11, scope: !7)
!30 = !DILocation(line: 9, column: 17, scope: !7)
!31 = !DILocation(line: 10, column: 1, scope: !7)
!32 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !33, isLocal: false, isDefinition: true, scopeLine: 14, isOptimized: false, unit: !0, variables: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!35}
!35 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!36 = !DILocalVariable(name: "s", scope: !32, file: !1, line: 15, type: !37)
!37 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 256, elements: !38)
!38 = !{!15, !15}
!39 = !DILocation(line: 15, column: 11, scope: !32)
!40 = !DILocation(line: 16, column: 15, scope: !32)
!41 = !DILocation(line: 16, column: 5, scope: !32)
!42 = !DILocation(line: 16, column: 13, scope: !32)
!43 = !DILocation(line: 18, column: 9, scope: !32)
!44 = !DILocation(line: 18, column: 5, scope: !32)
!45 = !DILocation(line: 20, column: 5, scope: !32)
