; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %tainted = alloca i8*, align 8
  %is_env_set = alloca i32, align 4
  %rc = alloca i32, align 4
  %a = alloca i32, align 4
  %ut = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !13, metadata !16), !dbg !17
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !18
  store i8* %call, i8** %tainted, align 8, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %is_env_set, metadata !19, metadata !16), !dbg !20
  %0 = load i8*, i8** %tainted, align 8, !dbg !21
  %cmp = icmp ne i8* %0, null, !dbg !22
  %conv = zext i1 %cmp to i32, !dbg !22
  store i32 %conv, i32* %is_env_set, align 4, !dbg !20
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !23, metadata !16), !dbg !24
  %1 = load i32, i32* %is_env_set, align 4, !dbg !25
  %tobool = icmp ne i32 %1, 0, !dbg !25
  br i1 %tobool, label %if.then, label %if.else8, !dbg !27

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %rc, align 4, !dbg !28
  %cmp1 = icmp ne i32 %2, 0, !dbg !31
  br i1 %cmp1, label %if.then3, label %if.else, !dbg !32

if.then3:                                         ; preds = %if.then
  call void @llvm.dbg.declare(metadata i32* %a, metadata !33, metadata !16), !dbg !35
  store i32 0, i32* %a, align 4, !dbg !35
  store i32 -1, i32* %retval, align 4, !dbg !36
  br label %return, !dbg !36

if.else:                                          ; preds = %if.then
  %3 = load i32, i32* %rc, align 4, !dbg !37
  %cmp4 = icmp eq i32 %3, 0, !dbg !39
  br i1 %cmp4, label %if.then6, label %if.else7, !dbg !40

if.then6:                                         ; preds = %if.else
  store i32 0, i32* %retval, align 4, !dbg !41
  br label %return, !dbg !41

if.else7:                                         ; preds = %if.else
  store i32 2, i32* %retval, align 4, !dbg !43
  br label %return, !dbg !43

if.else8:                                         ; preds = %entry
  store i32 1, i32* %rc, align 4, !dbg !45
  br label %if.end

if.end:                                           ; preds = %if.else8
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !47, metadata !16), !dbg !48
  store i32 1, i32* %ut, align 4, !dbg !48
  %4 = load i32, i32* %rc, align 4, !dbg !49
  store i32 %4, i32* %retval, align 4, !dbg !50
  br label %return, !dbg !50

return:                                           ; preds = %if.end, %if.else7, %if.then6, %if.then3
  %5 = load i32, i32* %retval, align 4, !dbg !51
  ret i32 %5, !dbg !51
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-23")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 5, type: !10, isLocal: false, isDefinition: true, scopeLine: 5, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "tainted", scope: !9, file: !1, line: 6, type: !14)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DIExpression()
!17 = !DILocation(line: 6, column: 11, scope: !9)
!18 = !DILocation(line: 6, column: 21, scope: !9)
!19 = !DILocalVariable(name: "is_env_set", scope: !9, file: !1, line: 7, type: !12)
!20 = !DILocation(line: 7, column: 9, scope: !9)
!21 = !DILocation(line: 7, column: 22, scope: !9)
!22 = !DILocation(line: 7, column: 30, scope: !9)
!23 = !DILocalVariable(name: "rc", scope: !9, file: !1, line: 9, type: !12)
!24 = !DILocation(line: 9, column: 9, scope: !9)
!25 = !DILocation(line: 11, column: 9, scope: !26)
!26 = distinct !DILexicalBlock(scope: !9, file: !1, line: 11, column: 9)
!27 = !DILocation(line: 11, column: 9, scope: !9)
!28 = !DILocation(line: 12, column: 13, scope: !29)
!29 = distinct !DILexicalBlock(scope: !30, file: !1, line: 12, column: 13)
!30 = distinct !DILexicalBlock(scope: !26, file: !1, line: 11, column: 21)
!31 = !DILocation(line: 12, column: 16, scope: !29)
!32 = !DILocation(line: 12, column: 13, scope: !30)
!33 = !DILocalVariable(name: "a", scope: !34, file: !1, line: 13, type: !12)
!34 = distinct !DILexicalBlock(scope: !29, file: !1, line: 12, column: 22)
!35 = !DILocation(line: 13, column: 17, scope: !34)
!36 = !DILocation(line: 14, column: 13, scope: !34)
!37 = !DILocation(line: 15, column: 20, scope: !38)
!38 = distinct !DILexicalBlock(scope: !29, file: !1, line: 15, column: 20)
!39 = !DILocation(line: 15, column: 23, scope: !38)
!40 = !DILocation(line: 15, column: 20, scope: !29)
!41 = !DILocation(line: 16, column: 13, scope: !42)
!42 = distinct !DILexicalBlock(scope: !38, file: !1, line: 15, column: 29)
!43 = !DILocation(line: 18, column: 13, scope: !44)
!44 = distinct !DILexicalBlock(scope: !38, file: !1, line: 17, column: 16)
!45 = !DILocation(line: 22, column: 12, scope: !46)
!46 = distinct !DILexicalBlock(scope: !26, file: !1, line: 21, column: 12)
!47 = !DILocalVariable(name: "ut", scope: !9, file: !1, line: 25, type: !12)
!48 = !DILocation(line: 25, column: 9, scope: !9)
!49 = !DILocation(line: 27, column: 12, scope: !9)
!50 = !DILocation(line: 27, column: 5, scope: !9)
!51 = !DILocation(line: 28, column: 1, scope: !9)
