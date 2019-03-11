; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %rc = alloca i32, align 4
  %t1 = alloca i8*, align 8
  %is_env_set = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %a4 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !16, metadata !14), !dbg !19
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !20
  store i8* %call, i8** %t1, align 8, !dbg !19
  call void @llvm.dbg.declare(metadata i32* %is_env_set, metadata !21, metadata !14), !dbg !22
  %0 = load i8*, i8** %t1, align 8, !dbg !23
  %cmp = icmp ne i8* %0, null, !dbg !24
  %conv = zext i1 %cmp to i32, !dbg !24
  store i32 %conv, i32* %is_env_set, align 4, !dbg !22
  %1 = load i32, i32* %is_env_set, align 4, !dbg !25
  %tobool = icmp ne i32 %1, 0, !dbg !25
  br i1 %tobool, label %if.then, label %if.end3, !dbg !27

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %a, metadata !28, metadata !14), !dbg !30
  store i32 0, i32* %a, align 4, !dbg !30
  %2 = load i32, i32* %is_env_set, align 4, !dbg !31
  %tobool1 = icmp ne i32 %2, 0, !dbg !31
  br i1 %tobool1, label %if.then2, label %if.else, !dbg !33

if.then2:                                         ; preds = %if.then
  store i32 1, i32* %rc, align 4, !dbg !34
  br label %if.end, !dbg !36

if.else:                                          ; preds = %if.then
  store i32 0, i32* %rc, align 4, !dbg !37
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then2
  call void @llvm.dbg.declare(metadata i32* %b, metadata !39, metadata !14), !dbg !40
  store i32 0, i32* %b, align 4, !dbg !40
  br label %if.end3, !dbg !41

if.end3:                                          ; preds = %if.end, %entry
  call void @llvm.dbg.declare(metadata i32* %a4, metadata !42, metadata !14), !dbg !43
  store i32 0, i32* %a4, align 4, !dbg !43
  %3 = load i32, i32* %rc, align 4, !dbg !44
  ret i32 %3, !dbg !45
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-13")
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
!16 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 11, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!19 = !DILocation(line: 11, column: 11, scope: !9)
!20 = !DILocation(line: 11, column: 16, scope: !9)
!21 = !DILocalVariable(name: "is_env_set", scope: !9, file: !1, line: 12, type: !12)
!22 = !DILocation(line: 12, column: 9, scope: !9)
!23 = !DILocation(line: 12, column: 22, scope: !9)
!24 = !DILocation(line: 12, column: 25, scope: !9)
!25 = !DILocation(line: 14, column: 9, scope: !26)
!26 = distinct !DILexicalBlock(scope: !9, file: !1, line: 14, column: 9)
!27 = !DILocation(line: 14, column: 9, scope: !9)
!28 = !DILocalVariable(name: "a", scope: !29, file: !1, line: 15, type: !12)
!29 = distinct !DILexicalBlock(scope: !26, file: !1, line: 14, column: 21)
!30 = !DILocation(line: 15, column: 13, scope: !29)
!31 = !DILocation(line: 16, column: 13, scope: !32)
!32 = distinct !DILexicalBlock(scope: !29, file: !1, line: 16, column: 13)
!33 = !DILocation(line: 16, column: 13, scope: !29)
!34 = !DILocation(line: 17, column: 16, scope: !35)
!35 = distinct !DILexicalBlock(scope: !32, file: !1, line: 16, column: 25)
!36 = !DILocation(line: 18, column: 9, scope: !35)
!37 = !DILocation(line: 19, column: 16, scope: !38)
!38 = distinct !DILexicalBlock(scope: !32, file: !1, line: 18, column: 16)
!39 = !DILocalVariable(name: "b", scope: !29, file: !1, line: 21, type: !12)
!40 = !DILocation(line: 21, column: 13, scope: !29)
!41 = !DILocation(line: 22, column: 5, scope: !29)
!42 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 24, type: !12)
!43 = !DILocation(line: 24, column: 9, scope: !9)
!44 = !DILocation(line: 26, column: 12, scope: !9)
!45 = !DILocation(line: 26, column: 5, scope: !9)
