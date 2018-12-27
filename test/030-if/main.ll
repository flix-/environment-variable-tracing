; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %no_taint = alloca i8*, align 8
  %ret = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %no_taint, metadata !13, metadata !16), !dbg !17
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0), i8** %no_taint, align 8, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %ret, metadata !18, metadata !16), !dbg !19
  %0 = load i8*, i8** %no_taint, align 8, !dbg !20
  %cmp = icmp ne i8* %0, null, !dbg !22
  br i1 %cmp, label %if.then, label %if.end, !dbg !23

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %a, metadata !24, metadata !16), !dbg !26
  store i32 42, i32* %a, align 4, !dbg !26
  %1 = load i32, i32* %a, align 4, !dbg !27
  store i32 %1, i32* %ret, align 4, !dbg !28
  br label %if.end, !dbg !29

if.end:                                           ; preds = %if.then, %entry
  %2 = load i32, i32* %ret, align 4, !dbg !30
  ret i32 %2, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/030-if")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !10, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "no_taint", scope: !9, file: !1, line: 10, type: !14)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DIExpression()
!17 = !DILocation(line: 10, column: 11, scope: !9)
!18 = !DILocalVariable(name: "ret", scope: !9, file: !1, line: 12, type: !12)
!19 = !DILocation(line: 12, column: 9, scope: !9)
!20 = !DILocation(line: 13, column: 9, scope: !21)
!21 = distinct !DILexicalBlock(scope: !9, file: !1, line: 13, column: 9)
!22 = !DILocation(line: 13, column: 18, scope: !21)
!23 = !DILocation(line: 13, column: 9, scope: !9)
!24 = !DILocalVariable(name: "a", scope: !25, file: !1, line: 14, type: !12)
!25 = distinct !DILexicalBlock(scope: !21, file: !1, line: 13, column: 27)
!26 = !DILocation(line: 14, column: 13, scope: !25)
!27 = !DILocation(line: 15, column: 15, scope: !25)
!28 = !DILocation(line: 15, column: 13, scope: !25)
!29 = !DILocation(line: 16, column: 5, scope: !25)
!30 = !DILocation(line: 18, column: 12, scope: !9)
!31 = !DILocation(line: 18, column: 5, scope: !9)
