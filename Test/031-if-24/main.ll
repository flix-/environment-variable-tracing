; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %rc = alloca i32, align 4
  %ut = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %b, metadata !16, metadata !14), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %c, metadata !18, metadata !14), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %d, metadata !20, metadata !14), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !22, metadata !14), !dbg !23
  %0 = load i32, i32* %a, align 4, !dbg !24
  %cmp = icmp eq i32 %0, 0, !dbg !26
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false, !dbg !27

lor.lhs.false:                                    ; preds = %entry
  %1 = load i32, i32* %b, align 4, !dbg !28
  %cmp1 = icmp eq i32 %1, 1, !dbg !29
  br i1 %cmp1, label %land.lhs.true, label %lor.lhs.false2, !dbg !30

lor.lhs.false2:                                   ; preds = %lor.lhs.false
  %2 = load i32, i32* %c, align 4, !dbg !31
  %cmp3 = icmp eq i32 %2, 2, !dbg !32
  br i1 %cmp3, label %land.lhs.true, label %if.else, !dbg !33

land.lhs.true:                                    ; preds = %lor.lhs.false2, %lor.lhs.false, %entry
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !34
  %cmp4 = icmp ne i8* %call, null, !dbg !35
  br i1 %cmp4, label %if.then, label %if.else, !dbg !36

if.then:                                          ; preds = %land.lhs.true
  %3 = load i32, i32* %d, align 4, !dbg !37
  %tobool = icmp ne i32 %3, 0, !dbg !37
  br i1 %tobool, label %if.end, label %if.then5, !dbg !40

if.then5:                                         ; preds = %if.then
  br label %err, !dbg !41

if.end:                                           ; preds = %if.then
  store i32 1, i32* %rc, align 4, !dbg !42
  br label %if.end9, !dbg !43

if.else:                                          ; preds = %land.lhs.true, %lor.lhs.false2
  %4 = load i32, i32* %d, align 4, !dbg !44
  %tobool6 = icmp ne i32 %4, 0, !dbg !44
  br i1 %tobool6, label %if.end8, label %if.then7, !dbg !47

if.then7:                                         ; preds = %if.else
  br label %err, !dbg !48

if.end8:                                          ; preds = %if.else
  store i32 1, i32* %rc, align 4, !dbg !49
  br label %if.end9

if.end9:                                          ; preds = %if.end8, %if.end
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !50, metadata !14), !dbg !51
  store i32 1, i32* %ut, align 4, !dbg !51
  br label %err, !dbg !52

err:                                              ; preds = %if.end9, %if.then7, %if.then5
  %5 = load i32, i32* %rc, align 4, !dbg !53
  ret i32 %5, !dbg !54
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-24")
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
!13 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 6, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 6, column: 9, scope: !9)
!16 = !DILocalVariable(name: "b", scope: !9, file: !1, line: 6, type: !12)
!17 = !DILocation(line: 6, column: 11, scope: !9)
!18 = !DILocalVariable(name: "c", scope: !9, file: !1, line: 6, type: !12)
!19 = !DILocation(line: 6, column: 13, scope: !9)
!20 = !DILocalVariable(name: "d", scope: !9, file: !1, line: 6, type: !12)
!21 = !DILocation(line: 6, column: 15, scope: !9)
!22 = !DILocalVariable(name: "rc", scope: !9, file: !1, line: 8, type: !12)
!23 = !DILocation(line: 8, column: 9, scope: !9)
!24 = !DILocation(line: 10, column: 10, scope: !25)
!25 = distinct !DILexicalBlock(scope: !9, file: !1, line: 10, column: 9)
!26 = !DILocation(line: 10, column: 12, scope: !25)
!27 = !DILocation(line: 11, column: 9, scope: !25)
!28 = !DILocation(line: 11, column: 12, scope: !25)
!29 = !DILocation(line: 11, column: 14, scope: !25)
!30 = !DILocation(line: 12, column: 9, scope: !25)
!31 = !DILocation(line: 12, column: 12, scope: !25)
!32 = !DILocation(line: 12, column: 14, scope: !25)
!33 = !DILocation(line: 13, column: 9, scope: !25)
!34 = !DILocation(line: 13, column: 12, scope: !25)
!35 = !DILocation(line: 13, column: 27, scope: !25)
!36 = !DILocation(line: 10, column: 9, scope: !9)
!37 = !DILocation(line: 15, column: 14, scope: !38)
!38 = distinct !DILexicalBlock(scope: !39, file: !1, line: 15, column: 13)
!39 = distinct !DILexicalBlock(scope: !25, file: !1, line: 13, column: 36)
!40 = !DILocation(line: 15, column: 13, scope: !39)
!41 = !DILocation(line: 15, column: 17, scope: !38)
!42 = !DILocation(line: 17, column: 12, scope: !39)
!43 = !DILocation(line: 18, column: 5, scope: !39)
!44 = !DILocation(line: 19, column: 14, scope: !45)
!45 = distinct !DILexicalBlock(scope: !46, file: !1, line: 19, column: 13)
!46 = distinct !DILexicalBlock(scope: !25, file: !1, line: 18, column: 12)
!47 = !DILocation(line: 19, column: 13, scope: !46)
!48 = !DILocation(line: 19, column: 17, scope: !45)
!49 = !DILocation(line: 20, column: 12, scope: !46)
!50 = !DILocalVariable(name: "ut", scope: !9, file: !1, line: 23, type: !12)
!51 = !DILocation(line: 23, column: 9, scope: !9)
!52 = !DILocation(line: 23, column: 5, scope: !9)
!53 = !DILocation(line: 26, column: 12, scope: !9)
!54 = !DILocation(line: 26, column: 5, scope: !9)
