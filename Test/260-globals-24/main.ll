; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@taint = common global i8* null, align 8, !dbg !0
@.str.1 = private unnamed_addr constant [5 x i8] c"huhu\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !14 {
entry:
  %retval = alloca i32, align 4
  %rc = alloca i32, align 4
  %is_env_set = alloca i32, align 4
  %a = alloca i32, align 4
  %ut1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !18, metadata !19), !dbg !20
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !21
  store i8* %call, i8** @taint, align 8, !dbg !22
  call void @llvm.dbg.declare(metadata i32* %is_env_set, metadata !23, metadata !19), !dbg !24
  %0 = load i8*, i8** @taint, align 8, !dbg !25
  %cmp = icmp ne i8* %0, null, !dbg !26
  %conv = zext i1 %cmp to i32, !dbg !26
  store i32 %conv, i32* %is_env_set, align 4, !dbg !24
  %1 = load i32, i32* %is_env_set, align 4, !dbg !27
  switch i32 %1, label %sw.default [
    i32 0, label %sw.bb
    i32 1, label %sw.bb1
  ], !dbg !28

sw.bb:                                            ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %a, metadata !29, metadata !19), !dbg !31
  store i32 0, i32* %a, align 4, !dbg !31
  call void @abort() #5, !dbg !32
  unreachable, !dbg !32

sw.bb1:                                           ; preds = %entry
  store i32 1, i32* %rc, align 4, !dbg !33
  br label %sw.epilog, !dbg !34

sw.default:                                       ; preds = %entry
  %2 = load i32, i32* %rc, align 4, !dbg !35
  switch i32 %2, label %sw.default3 [
    i32 0, label %sw.bb2
  ], !dbg !36

sw.bb2:                                           ; preds = %sw.default
  call void @abort() #5, !dbg !37
  unreachable, !dbg !37

sw.default3:                                      ; preds = %sw.default
  call void @abort() #5, !dbg !39
  unreachable, !dbg !39

sw.epilog:                                        ; preds = %sw.bb1
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !40, metadata !19), !dbg !41
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i8** %ut1, align 8, !dbg !41
  %3 = load i32, i32* %rc, align 4, !dbg !42
  ret i32 %3, !dbg !43
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

; Function Attrs: noreturn nounwind
declare void @abort() #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!10, !11, !12}
!llvm.ident = !{!13}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "taint", scope: !2, file: !3, line: 6, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !7)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-24")
!4 = !{}
!5 = !{!6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !{!0}
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!10 = !{i32 2, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{i32 1, !"wchar_size", i32 4}
!13 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!14 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 8, type: !15, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: false, unit: !2, variables: !4)
!15 = !DISubroutineType(types: !16)
!16 = !{!17}
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !DILocalVariable(name: "rc", scope: !14, file: !3, line: 10, type: !17)
!19 = !DIExpression()
!20 = !DILocation(line: 10, column: 9, scope: !14)
!21 = !DILocation(line: 11, column: 13, scope: !14)
!22 = !DILocation(line: 11, column: 11, scope: !14)
!23 = !DILocalVariable(name: "is_env_set", scope: !14, file: !3, line: 12, type: !17)
!24 = !DILocation(line: 12, column: 9, scope: !14)
!25 = !DILocation(line: 12, column: 22, scope: !14)
!26 = !DILocation(line: 12, column: 28, scope: !14)
!27 = !DILocation(line: 14, column: 13, scope: !14)
!28 = !DILocation(line: 14, column: 5, scope: !14)
!29 = !DILocalVariable(name: "a", scope: !30, file: !3, line: 17, type: !17)
!30 = distinct !DILexicalBlock(scope: !14, file: !3, line: 14, column: 25)
!31 = !DILocation(line: 17, column: 13, scope: !30)
!32 = !DILocation(line: 18, column: 9, scope: !30)
!33 = !DILocation(line: 21, column: 12, scope: !30)
!34 = !DILocation(line: 22, column: 9, scope: !30)
!35 = !DILocation(line: 24, column: 17, scope: !30)
!36 = !DILocation(line: 24, column: 9, scope: !30)
!37 = !DILocation(line: 26, column: 13, scope: !38)
!38 = distinct !DILexicalBlock(scope: !30, file: !3, line: 24, column: 21)
!39 = !DILocation(line: 28, column: 13, scope: !38)
!40 = !DILocalVariable(name: "ut1", scope: !14, file: !3, line: 33, type: !8)
!41 = !DILocation(line: 33, column: 11, scope: !14)
!42 = !DILocation(line: 35, column: 12, scope: !14)
!43 = !DILocation(line: 35, column: 5, scope: !14)
