; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"huhu\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %rc = alloca i32, align 4
  %taint = alloca i8*, align 8
  %is_env_set = alloca i32, align 4
  %a = alloca i32, align 4
  %ut1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i8** %taint, metadata !16, metadata !14), !dbg !19
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !20
  store i8* %call, i8** %taint, align 8, !dbg !19
  call void @llvm.dbg.declare(metadata i32* %is_env_set, metadata !21, metadata !14), !dbg !22
  %0 = load i8*, i8** %taint, align 8, !dbg !23
  %cmp = icmp ne i8* %0, null, !dbg !24
  %conv = zext i1 %cmp to i32, !dbg !24
  store i32 %conv, i32* %is_env_set, align 4, !dbg !22
  %1 = load i32, i32* %is_env_set, align 4, !dbg !25
  switch i32 %1, label %sw.default [
    i32 0, label %sw.bb
    i32 1, label %sw.bb1
  ], !dbg !26

sw.bb:                                            ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %a, metadata !27, metadata !14), !dbg !29
  store i32 0, i32* %a, align 4, !dbg !29
  call void @abort() #5, !dbg !30
  unreachable, !dbg !30

sw.bb1:                                           ; preds = %entry
  store i32 1, i32* %rc, align 4, !dbg !31
  br label %sw.epilog, !dbg !32

sw.default:                                       ; preds = %entry
  %2 = load i32, i32* %rc, align 4, !dbg !33
  switch i32 %2, label %sw.default3 [
    i32 0, label %sw.bb2
  ], !dbg !34

sw.bb2:                                           ; preds = %sw.default
  call void @abort() #5, !dbg !35
  unreachable, !dbg !35

sw.default3:                                      ; preds = %sw.default
  call void @abort() #5, !dbg !37
  unreachable, !dbg !37

sw.epilog:                                        ; preds = %sw.bb1
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !38, metadata !14), !dbg !39
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i8** %ut1, align 8, !dbg !39
  %3 = load i32, i32* %rc, align 4, !dbg !40
  ret i32 %3, !dbg !41
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

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/091-switch-10")
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
!13 = !DILocalVariable(name: "rc", scope: !9, file: !1, line: 10, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 10, column: 9, scope: !9)
!16 = !DILocalVariable(name: "taint", scope: !9, file: !1, line: 11, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!19 = !DILocation(line: 11, column: 11, scope: !9)
!20 = !DILocation(line: 11, column: 19, scope: !9)
!21 = !DILocalVariable(name: "is_env_set", scope: !9, file: !1, line: 12, type: !12)
!22 = !DILocation(line: 12, column: 9, scope: !9)
!23 = !DILocation(line: 12, column: 22, scope: !9)
!24 = !DILocation(line: 12, column: 28, scope: !9)
!25 = !DILocation(line: 14, column: 13, scope: !9)
!26 = !DILocation(line: 14, column: 5, scope: !9)
!27 = !DILocalVariable(name: "a", scope: !28, file: !1, line: 17, type: !12)
!28 = distinct !DILexicalBlock(scope: !9, file: !1, line: 14, column: 25)
!29 = !DILocation(line: 17, column: 13, scope: !28)
!30 = !DILocation(line: 18, column: 9, scope: !28)
!31 = !DILocation(line: 21, column: 12, scope: !28)
!32 = !DILocation(line: 22, column: 9, scope: !28)
!33 = !DILocation(line: 24, column: 17, scope: !28)
!34 = !DILocation(line: 24, column: 9, scope: !28)
!35 = !DILocation(line: 26, column: 13, scope: !36)
!36 = distinct !DILexicalBlock(scope: !28, file: !1, line: 24, column: 21)
!37 = !DILocation(line: 28, column: 13, scope: !36)
!38 = !DILocalVariable(name: "ut1", scope: !9, file: !1, line: 33, type: !17)
!39 = !DILocation(line: 33, column: 11, scope: !9)
!40 = !DILocation(line: 35, column: 12, scope: !9)
!41 = !DILocation(line: 35, column: 5, scope: !9)
