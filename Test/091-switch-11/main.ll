; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %rc = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %t = alloca i32, align 4
  %ut = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %a, metadata !16, metadata !14), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %b, metadata !18, metadata !14), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %c, metadata !20, metadata !14), !dbg !21
  %0 = load i32, i32* %a, align 4, !dbg !22
  %tobool = icmp ne i32 %0, 0, !dbg !22
  br i1 %tobool, label %land.rhs, label %lor.lhs.false, !dbg !23

lor.lhs.false:                                    ; preds = %entry
  %1 = load i32, i32* %b, align 4, !dbg !24
  %tobool1 = icmp ne i32 %1, 0, !dbg !24
  br i1 %tobool1, label %land.lhs.true, label %land.end, !dbg !25

land.lhs.true:                                    ; preds = %lor.lhs.false
  %2 = load i32, i32* %c, align 4, !dbg !26
  %tobool2 = icmp ne i32 %2, 0, !dbg !26
  br i1 %tobool2, label %land.rhs, label %land.end, !dbg !27

land.rhs:                                         ; preds = %land.lhs.true, %entry
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !28
  %cmp = icmp ne i8* %call, null, !dbg !29
  br label %land.end

land.end:                                         ; preds = %land.rhs, %land.lhs.true, %lor.lhs.false
  %3 = phi i1 [ false, %land.lhs.true ], [ false, %lor.lhs.false ], [ %cmp, %land.rhs ]
  %land.ext = zext i1 %3 to i32, !dbg !27
  switch i32 %land.ext, label %sw.default8 [
    i32 0, label %sw.bb
    i32 1, label %sw.bb6
    i32 2, label %sw.bb7
  ], !dbg !30

sw.bb:                                            ; preds = %land.end
  %4 = load i32, i32* %a, align 4, !dbg !31
  switch i32 %4, label %sw.default [
    i32 0, label %sw.bb3
    i32 1, label %sw.bb4
    i32 2, label %sw.bb5
  ], !dbg !33

sw.bb3:                                           ; preds = %sw.bb
  br label %sw.epilog, !dbg !34

sw.bb4:                                           ; preds = %sw.bb
  br label %sw.epilog, !dbg !36

sw.bb5:                                           ; preds = %sw.bb
  br label %sw.epilog, !dbg !37

sw.default:                                       ; preds = %sw.bb
  br label %sw.epilog, !dbg !38

sw.epilog:                                        ; preds = %sw.default, %sw.bb5, %sw.bb4, %sw.bb3
  store i32 1, i32* %rc, align 4, !dbg !39
  br label %sw.epilog9, !dbg !40

sw.bb6:                                           ; preds = %land.end
  store i32 2, i32* %rc, align 4, !dbg !41
  br label %sw.epilog9, !dbg !42

sw.bb7:                                           ; preds = %land.end
  store i32 3, i32* %rc, align 4, !dbg !43
  br label %sw.default8, !dbg !44

sw.default8:                                      ; preds = %land.end, %sw.bb7
  call void @llvm.dbg.declare(metadata i32* %t, metadata !45, metadata !14), !dbg !46
  store i32 1, i32* %t, align 4, !dbg !46
  store i32 -1, i32* %retval, align 4, !dbg !47
  br label %return, !dbg !47

sw.epilog9:                                       ; preds = %sw.bb6, %sw.epilog
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !48, metadata !14), !dbg !49
  store i32 1, i32* %ut, align 4, !dbg !49
  %5 = load i32, i32* %rc, align 4, !dbg !50
  store i32 %5, i32* %retval, align 4, !dbg !51
  br label %return, !dbg !51

return:                                           ; preds = %sw.epilog9, %sw.default8
  %6 = load i32, i32* %retval, align 4, !dbg !52
  ret i32 %6, !dbg !52
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
!llvm.module.flags = !{!6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/091-switch-11")
!2 = !{}
!3 = !{!4, !5}
!4 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!6 = !{i32 2, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !11, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: false, unit: !0, variables: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!4}
!13 = !DILocalVariable(name: "rc", scope: !10, file: !1, line: 10, type: !4)
!14 = !DIExpression()
!15 = !DILocation(line: 10, column: 9, scope: !10)
!16 = !DILocalVariable(name: "a", scope: !10, file: !1, line: 12, type: !4)
!17 = !DILocation(line: 12, column: 9, scope: !10)
!18 = !DILocalVariable(name: "b", scope: !10, file: !1, line: 12, type: !4)
!19 = !DILocation(line: 12, column: 11, scope: !10)
!20 = !DILocalVariable(name: "c", scope: !10, file: !1, line: 12, type: !4)
!21 = !DILocation(line: 12, column: 13, scope: !10)
!22 = !DILocation(line: 14, column: 19, scope: !10)
!23 = !DILocation(line: 14, column: 21, scope: !10)
!24 = !DILocation(line: 14, column: 25, scope: !10)
!25 = !DILocation(line: 14, column: 27, scope: !10)
!26 = !DILocation(line: 14, column: 30, scope: !10)
!27 = !DILocation(line: 14, column: 34, scope: !10)
!28 = !DILocation(line: 14, column: 38, scope: !10)
!29 = !DILocation(line: 14, column: 53, scope: !10)
!30 = !DILocation(line: 14, column: 5, scope: !10)
!31 = !DILocation(line: 17, column: 17, scope: !32)
!32 = distinct !DILexicalBlock(scope: !10, file: !1, line: 14, column: 64)
!33 = !DILocation(line: 17, column: 9, scope: !32)
!34 = !DILocation(line: 20, column: 13, scope: !35)
!35 = distinct !DILexicalBlock(scope: !32, file: !1, line: 17, column: 20)
!36 = !DILocation(line: 23, column: 13, scope: !35)
!37 = !DILocation(line: 26, column: 13, scope: !35)
!38 = !DILocation(line: 29, column: 9, scope: !35)
!39 = !DILocation(line: 30, column: 12, scope: !32)
!40 = !DILocation(line: 31, column: 9, scope: !32)
!41 = !DILocation(line: 34, column: 12, scope: !32)
!42 = !DILocation(line: 35, column: 9, scope: !32)
!43 = !DILocation(line: 38, column: 12, scope: !32)
!44 = !DILocation(line: 38, column: 9, scope: !32)
!45 = !DILocalVariable(name: "t", scope: !32, file: !1, line: 41, type: !4)
!46 = !DILocation(line: 41, column: 13, scope: !32)
!47 = !DILocation(line: 42, column: 9, scope: !32)
!48 = !DILocalVariable(name: "ut", scope: !10, file: !1, line: 45, type: !4)
!49 = !DILocation(line: 45, column: 9, scope: !10)
!50 = !DILocation(line: 47, column: 12, scope: !10)
!51 = !DILocation(line: 47, column: 5, scope: !10)
!52 = !DILocation(line: 48, column: 1, scope: !10)
