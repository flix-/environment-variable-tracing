; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(%struct.s1* byval align 8 %fs, i32 %a) #0 !dbg !7 {
entry:
  %a.addr = alloca i32, align 4
  %also_tainted = alloca i8*, align 8
  %also_tainted2 = alloca i8*, align 8
  %nope = alloca i32, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %fs, metadata !19, metadata !20), !dbg !21
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !22, metadata !20), !dbg !23
  call void @llvm.dbg.declare(metadata i8** %also_tainted, metadata !24, metadata !20), !dbg !25
  %tainted1 = getelementptr inbounds %struct.s1, %struct.s1* %fs, i32 0, i32 2, !dbg !26
  %0 = load i8*, i8** %tainted1, align 8, !dbg !26
  store i8* %0, i8** %also_tainted, align 8, !dbg !25
  %tainted11 = getelementptr inbounds %struct.s1, %struct.s1* %fs, i32 0, i32 2, !dbg !27
  %1 = load i8*, i8** %tainted11, align 8, !dbg !27
  %tainted2 = getelementptr inbounds %struct.s1, %struct.s1* %fs, i32 0, i32 3, !dbg !28
  store i8* %1, i8** %tainted2, align 8, !dbg !29
  call void @llvm.dbg.declare(metadata i8** %also_tainted2, metadata !30, metadata !20), !dbg !31
  %tainted22 = getelementptr inbounds %struct.s1, %struct.s1* %fs, i32 0, i32 3, !dbg !32
  %2 = load i8*, i8** %tainted22, align 8, !dbg !32
  store i8* %2, i8** %also_tainted2, align 8, !dbg !31
  call void @llvm.dbg.declare(metadata i32* %nope, metadata !33, metadata !20), !dbg !34
  %3 = load i32, i32* %a.addr, align 4, !dbg !35
  store i32 %3, i32* %nope, align 4, !dbg !34
  ret void, !dbg !36
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !37 {
entry:
  %retval = alloca i32, align 4
  %ms = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %ms, metadata !40, metadata !20), !dbg !41
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !42
  %tainted1 = getelementptr inbounds %struct.s1, %struct.s1* %ms, i32 0, i32 2, !dbg !43
  store i8* %call, i8** %tainted1, align 8, !dbg !44
  call void @foo(%struct.s1* byval align 8 %ms, i32 42), !dbg !45
  ret i32 0, !dbg !46
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-struct-by-val-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 11, type: !8, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !13}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 3, size: 192, elements: !11)
!11 = !{!12, !14, !15, !18}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !10, file: !1, line: 4, baseType: !13, size: 32)
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !10, file: !1, line: 5, baseType: !13, size: 32, offset: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "tainted1", scope: !10, file: !1, line: 6, baseType: !16, size: 64, offset: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "tainted2", scope: !10, file: !1, line: 7, baseType: !16, size: 64, offset: 128)
!19 = !DILocalVariable(name: "fs", arg: 1, scope: !7, file: !1, line: 11, type: !10)
!20 = !DIExpression()
!21 = !DILocation(line: 11, column: 15, scope: !7)
!22 = !DILocalVariable(name: "a", arg: 2, scope: !7, file: !1, line: 11, type: !13)
!23 = !DILocation(line: 11, column: 23, scope: !7)
!24 = !DILocalVariable(name: "also_tainted", scope: !7, file: !1, line: 13, type: !16)
!25 = !DILocation(line: 13, column: 11, scope: !7)
!26 = !DILocation(line: 13, column: 29, scope: !7)
!27 = !DILocation(line: 14, column: 22, scope: !7)
!28 = !DILocation(line: 14, column: 8, scope: !7)
!29 = !DILocation(line: 14, column: 17, scope: !7)
!30 = !DILocalVariable(name: "also_tainted2", scope: !7, file: !1, line: 15, type: !16)
!31 = !DILocation(line: 15, column: 11, scope: !7)
!32 = !DILocation(line: 15, column: 30, scope: !7)
!33 = !DILocalVariable(name: "nope", scope: !7, file: !1, line: 16, type: !13)
!34 = !DILocation(line: 16, column: 9, scope: !7)
!35 = !DILocation(line: 16, column: 16, scope: !7)
!36 = !DILocation(line: 17, column: 1, scope: !7)
!37 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !38, isLocal: false, isDefinition: true, scopeLine: 21, isOptimized: false, unit: !0, variables: !2)
!38 = !DISubroutineType(types: !39)
!39 = !{!13}
!40 = !DILocalVariable(name: "ms", scope: !37, file: !1, line: 22, type: !10)
!41 = !DILocation(line: 22, column: 15, scope: !37)
!42 = !DILocation(line: 23, column: 19, scope: !37)
!43 = !DILocation(line: 23, column: 8, scope: !37)
!44 = !DILocation(line: 23, column: 17, scope: !37)
!45 = !DILocation(line: 24, column: 5, scope: !37)
!46 = !DILocation(line: 26, column: 5, scope: !37)
