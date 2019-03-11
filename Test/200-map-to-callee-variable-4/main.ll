; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [8 x i8] c"untaint\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"noe\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @bar(i8* %tainted_bar, i8* %not_tainted) #0 !dbg !7 {
entry:
  %tainted_bar.addr = alloca i8*, align 8
  %not_tainted.addr = alloca i8*, align 8
  %tainted2 = alloca i8*, align 8
  %not_tainted2 = alloca i8*, align 8
  store i8* %tainted_bar, i8** %tainted_bar.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %tainted_bar.addr, metadata !12, metadata !13), !dbg !14
  store i8* %not_tainted, i8** %not_tainted.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %not_tainted.addr, metadata !15, metadata !13), !dbg !16
  call void @llvm.dbg.declare(metadata i8** %tainted2, metadata !17, metadata !13), !dbg !18
  %0 = load i8*, i8** %tainted_bar.addr, align 8, !dbg !19
  store i8* %0, i8** %tainted2, align 8, !dbg !18
  call void @llvm.dbg.declare(metadata i8** %not_tainted2, metadata !20, metadata !13), !dbg !21
  %1 = load i8*, i8** %not_tainted.addr, align 8, !dbg !22
  store i8* %1, i8** %not_tainted2, align 8, !dbg !21
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i32 0, i32 0), i8** %tainted_bar.addr, align 8, !dbg !23
  ret void, !dbg !24
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i8* %tainted_foo) #0 !dbg !25 {
entry:
  %tainted_foo.addr = alloca i8*, align 8
  %also_tainted_foo = alloca i8*, align 8
  %not_tainted = alloca i8*, align 8
  %still_tainted = alloca i8*, align 8
  store i8* %tainted_foo, i8** %tainted_foo.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %tainted_foo.addr, metadata !28, metadata !13), !dbg !29
  call void @llvm.dbg.declare(metadata i8** %also_tainted_foo, metadata !30, metadata !13), !dbg !31
  %0 = load i8*, i8** %tainted_foo.addr, align 8, !dbg !32
  store i8* %0, i8** %also_tainted_foo, align 8, !dbg !31
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !33, metadata !13), !dbg !34
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0), i8** %not_tainted, align 8, !dbg !34
  %1 = load i8*, i8** %also_tainted_foo, align 8, !dbg !35
  %2 = load i8*, i8** %not_tainted, align 8, !dbg !36
  call void @bar(i8* %1, i8* %2), !dbg !37
  call void @llvm.dbg.declare(metadata i8** %still_tainted, metadata !38, metadata !13), !dbg !39
  %3 = load i8*, i8** %also_tainted_foo, align 8, !dbg !40
  store i8* %3, i8** %still_tainted, align 8, !dbg !39
  ret void, !dbg !41
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !42 {
entry:
  %retval = alloca i32, align 4
  %tainted_main = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %tainted_main, metadata !46, metadata !13), !dbg !47
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0)), !dbg !48
  store i8* %call, i8** %tainted_main, align 8, !dbg !47
  %0 = load i8*, i8** %tainted_main, align 8, !dbg !49
  call void @foo(i8* %0), !dbg !50
  ret i32 0, !dbg !51
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-4")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 4, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !DILocalVariable(name: "tainted_bar", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!13 = !DIExpression()
!14 = !DILocation(line: 4, column: 11, scope: !7)
!15 = !DILocalVariable(name: "not_tainted", arg: 2, scope: !7, file: !1, line: 4, type: !10)
!16 = !DILocation(line: 4, column: 30, scope: !7)
!17 = !DILocalVariable(name: "tainted2", scope: !7, file: !1, line: 6, type: !10)
!18 = !DILocation(line: 6, column: 11, scope: !7)
!19 = !DILocation(line: 6, column: 22, scope: !7)
!20 = !DILocalVariable(name: "not_tainted2", scope: !7, file: !1, line: 7, type: !10)
!21 = !DILocation(line: 7, column: 11, scope: !7)
!22 = !DILocation(line: 7, column: 26, scope: !7)
!23 = !DILocation(line: 8, column: 17, scope: !7)
!24 = !DILocation(line: 9, column: 1, scope: !7)
!25 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 12, type: !26, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{null, !10}
!28 = !DILocalVariable(name: "tainted_foo", arg: 1, scope: !25, file: !1, line: 12, type: !10)
!29 = !DILocation(line: 12, column: 11, scope: !25)
!30 = !DILocalVariable(name: "also_tainted_foo", scope: !25, file: !1, line: 14, type: !10)
!31 = !DILocation(line: 14, column: 11, scope: !25)
!32 = !DILocation(line: 14, column: 30, scope: !25)
!33 = !DILocalVariable(name: "not_tainted", scope: !25, file: !1, line: 15, type: !10)
!34 = !DILocation(line: 15, column: 11, scope: !25)
!35 = !DILocation(line: 16, column: 9, scope: !25)
!36 = !DILocation(line: 16, column: 27, scope: !25)
!37 = !DILocation(line: 16, column: 5, scope: !25)
!38 = !DILocalVariable(name: "still_tainted", scope: !25, file: !1, line: 17, type: !10)
!39 = !DILocation(line: 17, column: 11, scope: !25)
!40 = !DILocation(line: 17, column: 27, scope: !25)
!41 = !DILocation(line: 18, column: 1, scope: !25)
!42 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 21, type: !43, isLocal: false, isDefinition: true, scopeLine: 22, isOptimized: false, unit: !0, variables: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{!45}
!45 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!46 = !DILocalVariable(name: "tainted_main", scope: !42, file: !1, line: 23, type: !10)
!47 = !DILocation(line: 23, column: 11, scope: !42)
!48 = !DILocation(line: 23, column: 26, scope: !42)
!49 = !DILocation(line: 24, column: 9, scope: !42)
!50 = !DILocation(line: 24, column: 5, scope: !42)
!51 = !DILocation(line: 26, column: 5, scope: !42)
