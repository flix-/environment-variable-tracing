; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %rc = alloca i32, align 4
  %taint = alloca i32, align 4
  %taint2 = alloca i32, align 4
  %i = alloca i32, align 4
  %a25 = alloca i32, align 4
  %b26 = alloca i32, align 4
  %t = alloca i32, align 4
  %t38 = alloca i32, align 4
  %end1 = alloca i32, align 4
  %end2 = alloca i32, align 4
  %ut1 = alloca i32, align 4
  %j = alloca i32, align 4
  %taint_me = alloca i32, align 4
  %ut4 = alloca i32, align 4
  %t68 = alloca i32, align 4
  %no_taint = alloca i32, align 4
  %taint_me80 = alloca i32, align 4
  %t84 = alloca i32, align 4
  %ut6 = alloca i32, align 4
  %no_taint88 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %b, metadata !16, metadata !14), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %c, metadata !18, metadata !14), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %d, metadata !20, metadata !14), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %e, metadata !22, metadata !14), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !24, metadata !14), !dbg !25
  %0 = load i32, i32* %a, align 4, !dbg !26
  %tobool = icmp ne i32 %0, 0, !dbg !26
  br i1 %tobool, label %if.then, label %if.end87, !dbg !28

if.then:                                          ; preds = %entry
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !29
  %1 = ptrtoint i8* %call to i32, !dbg !31
  switch i32 %1, label %sw.default [
    i32 0, label %sw.bb
    i32 1, label %sw.bb1
  ], !dbg !32

sw.bb:                                            ; preds = %if.then
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !33, metadata !14), !dbg !35
  store i32 1, i32* %taint, align 4, !dbg !35
  br label %sw.epilog, !dbg !36

sw.bb1:                                           ; preds = %if.then
  call void @llvm.dbg.declare(metadata i32* %taint2, metadata !37, metadata !14), !dbg !38
  store i32 2, i32* %taint2, align 4, !dbg !38
  br label %sw.default, !dbg !39

sw.default:                                       ; preds = %if.then, %sw.bb1
  br label %err, !dbg !40

sw.epilog:                                        ; preds = %sw.bb
  %2 = load i32, i32* %b, align 4, !dbg !41
  %tobool2 = icmp ne i32 %2, 0, !dbg !41
  br i1 %tobool2, label %if.then3, label %if.else63, !dbg !43

if.then3:                                         ; preds = %sw.epilog
  br label %while.cond, !dbg !44

while.cond:                                       ; preds = %for.end, %if.then3
  %3 = load i32, i32* %a, align 4, !dbg !46
  %cmp = icmp ne i32 %3, 4711, !dbg !47
  br i1 %cmp, label %while.body, label %while.end44, !dbg !44

while.body:                                       ; preds = %while.cond
  call void @llvm.dbg.declare(metadata i32* %i, metadata !48, metadata !14), !dbg !51
  store i32 0, i32* %i, align 4, !dbg !51
  br label %for.cond, !dbg !52

for.cond:                                         ; preds = %for.inc, %while.body
  %4 = load i32, i32* %i, align 4, !dbg !53
  %call4 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !55
  %cmp5 = icmp eq i8* %call4, null, !dbg !56
  %conv = zext i1 %cmp5 to i32, !dbg !56
  %cmp6 = icmp slt i32 %4, %conv, !dbg !57
  br i1 %cmp6, label %for.body, label %for.end, !dbg !58

for.body:                                         ; preds = %for.cond
  br label %do.body, !dbg !59, !llvm.loop !61

do.body:                                          ; preds = %do.cond, %for.body
  br label %while.cond8, !dbg !63

while.cond8:                                      ; preds = %if.end40, %do.body
  %call9 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !65
  %cmp10 = icmp ne i8* %call9, null, !dbg !66
  br i1 %cmp10, label %while.body12, label %while.end, !dbg !63

while.body12:                                     ; preds = %while.cond8
  %call13 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !67
  %tobool14 = icmp ne i8* %call13, null, !dbg !67
  br i1 %tobool14, label %land.lhs.true, label %lor.lhs.false, !dbg !70

land.lhs.true:                                    ; preds = %while.body12
  %5 = load i32, i32* %a, align 4, !dbg !71
  %tobool15 = icmp ne i32 %5, 0, !dbg !71
  br i1 %tobool15, label %land.lhs.true16, label %lor.lhs.false, !dbg !72

land.lhs.true16:                                  ; preds = %land.lhs.true
  %6 = load i32, i32* %b, align 4, !dbg !73
  %tobool17 = icmp ne i32 %6, 0, !dbg !73
  br i1 %tobool17, label %land.lhs.true18, label %lor.lhs.false, !dbg !74

land.lhs.true18:                                  ; preds = %land.lhs.true16
  %7 = load i32, i32* %c, align 4, !dbg !75
  %tobool19 = icmp ne i32 %7, 0, !dbg !75
  br i1 %tobool19, label %if.then21, label %lor.lhs.false, !dbg !76

lor.lhs.false:                                    ; preds = %land.lhs.true18, %land.lhs.true16, %land.lhs.true, %while.body12
  %8 = load i32, i32* %e, align 4, !dbg !77
  %tobool20 = icmp ne i32 %8, 0, !dbg !77
  br i1 %tobool20, label %if.then21, label %if.else27, !dbg !78

if.then21:                                        ; preds = %lor.lhs.false, %land.lhs.true18
  %9 = load i32, i32* %a, align 4, !dbg !79
  %tobool22 = icmp ne i32 %9, 0, !dbg !79
  br i1 %tobool22, label %if.then23, label %if.else, !dbg !82

if.then23:                                        ; preds = %if.then21
  br label %do.body24, !dbg !83, !llvm.loop !85

do.body24:                                        ; preds = %if.then23
  call void @llvm.dbg.declare(metadata i32* %a25, metadata !87, metadata !14), !dbg !89
  store i32 0, i32* %a25, align 4, !dbg !89
  br label %do.end, !dbg !90

do.end:                                           ; preds = %do.body24
  br label %if.end, !dbg !91

if.else:                                          ; preds = %if.then21
  call void @llvm.dbg.declare(metadata i32* %b26, metadata !92, metadata !14), !dbg !94
  store i32 1, i32* %b26, align 4, !dbg !94
  br label %if.end

if.end:                                           ; preds = %if.else, %do.end
  br label %if.end40, !dbg !95

if.else27:                                        ; preds = %lor.lhs.false
  %10 = load i32, i32* %a, align 4, !dbg !96
  %tobool28 = icmp ne i32 %10, 0, !dbg !96
  br i1 %tobool28, label %if.then33, label %lor.lhs.false29, !dbg !98

lor.lhs.false29:                                  ; preds = %if.else27
  %11 = load i32, i32* %b, align 4, !dbg !99
  %tobool30 = icmp ne i32 %11, 0, !dbg !99
  br i1 %tobool30, label %if.then33, label %lor.lhs.false31, !dbg !100

lor.lhs.false31:                                  ; preds = %lor.lhs.false29
  %12 = load i32, i32* %c, align 4, !dbg !101
  %tobool32 = icmp ne i32 %12, 0, !dbg !101
  br i1 %tobool32, label %if.then33, label %if.else37, !dbg !102

if.then33:                                        ; preds = %lor.lhs.false31, %lor.lhs.false29, %if.else27
  call void @llvm.dbg.declare(metadata i32* %t, metadata !103, metadata !14), !dbg !105
  %13 = load i32, i32* %a, align 4, !dbg !106
  store i32 %13, i32* %t, align 4, !dbg !105
  %14 = load i32, i32* %b, align 4, !dbg !107
  %tobool34 = icmp ne i32 %14, 0, !dbg !107
  br i1 %tobool34, label %if.end36, label %if.then35, !dbg !109

if.then35:                                        ; preds = %if.then33
  store i32 -1, i32* %retval, align 4, !dbg !110
  br label %return, !dbg !110

if.end36:                                         ; preds = %if.then33
  br label %if.end39, !dbg !111

if.else37:                                        ; preds = %lor.lhs.false31
  call void @llvm.dbg.declare(metadata i32* %t38, metadata !112, metadata !14), !dbg !114
  store i32 1, i32* %t38, align 4, !dbg !114
  br label %if.end39

if.end39:                                         ; preds = %if.else37, %if.end36
  br label %if.end40

if.end40:                                         ; preds = %if.end39, %if.end
  store i32 4711, i32* %rc, align 4, !dbg !115
  br label %while.cond8, !dbg !63, !llvm.loop !116

while.end:                                        ; preds = %while.cond8
  call void @llvm.dbg.declare(metadata i32* %end1, metadata !118, metadata !14), !dbg !119
  store i32 1, i32* %end1, align 4, !dbg !119
  br label %do.cond, !dbg !120

do.cond:                                          ; preds = %while.end
  %call41 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !121
  %tobool42 = icmp ne i8* %call41, null, !dbg !120
  br i1 %tobool42, label %do.body, label %do.end43, !dbg !120, !llvm.loop !61

do.end43:                                         ; preds = %do.cond
  call void @llvm.dbg.declare(metadata i32* %end2, metadata !122, metadata !14), !dbg !123
  store i32 1, i32* %end2, align 4, !dbg !123
  br label %for.inc, !dbg !124

for.inc:                                          ; preds = %do.end43
  %15 = load i32, i32* %i, align 4, !dbg !125
  %inc = add nsw i32 %15, 1, !dbg !125
  store i32 %inc, i32* %i, align 4, !dbg !125
  br label %for.cond, !dbg !126, !llvm.loop !127

for.end:                                          ; preds = %for.cond
  br label %while.cond, !dbg !44, !llvm.loop !129

while.end44:                                      ; preds = %while.cond
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !131, metadata !14), !dbg !132
  store i32 1, i32* %ut1, align 4, !dbg !132
  call void @llvm.dbg.declare(metadata i32* %j, metadata !133, metadata !14), !dbg !135
  store i32 0, i32* %j, align 4, !dbg !135
  br label %for.cond45, !dbg !136

for.cond45:                                       ; preds = %for.inc60, %while.end44
  %16 = load i32, i32* %j, align 4, !dbg !137
  %cmp46 = icmp slt i32 %16, 42, !dbg !139
  br i1 %cmp46, label %for.body48, label %for.end62, !dbg !140

for.body48:                                       ; preds = %for.cond45
  br label %while.cond49, !dbg !141

while.cond49:                                     ; preds = %while.body58, %for.body48
  %17 = load i32, i32* %a, align 4, !dbg !143
  %tobool50 = icmp ne i32 %17, 0, !dbg !143
  br i1 %tobool50, label %land.rhs, label %lor.lhs.false51, !dbg !144

lor.lhs.false51:                                  ; preds = %while.cond49
  %18 = load i32, i32* %b, align 4, !dbg !145
  %tobool52 = icmp ne i32 %18, 0, !dbg !145
  br i1 %tobool52, label %land.rhs, label %lor.lhs.false53, !dbg !146

lor.lhs.false53:                                  ; preds = %lor.lhs.false51
  %19 = load i32, i32* %c, align 4, !dbg !147
  %tobool54 = icmp ne i32 %19, 0, !dbg !147
  br i1 %tobool54, label %land.rhs, label %land.end, !dbg !148

land.rhs:                                         ; preds = %lor.lhs.false53, %lor.lhs.false51, %while.cond49
  %20 = load i32, i32* %e, align 4, !dbg !149
  %call55 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !150
  %21 = ptrtoint i8* %call55 to i32, !dbg !151
  %cmp56 = icmp ne i32 %20, %21, !dbg !152
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.lhs.false53
  %22 = phi i1 [ false, %lor.lhs.false53 ], [ %cmp56, %land.rhs ]
  br i1 %22, label %while.body58, label %while.end59, !dbg !141

while.body58:                                     ; preds = %land.end
  call void @llvm.dbg.declare(metadata i32* %taint_me, metadata !153, metadata !14), !dbg !155
  store i32 1, i32* %taint_me, align 4, !dbg !155
  br label %while.cond49, !dbg !141, !llvm.loop !156

while.end59:                                      ; preds = %land.end
  call void @llvm.dbg.declare(metadata i32* %ut4, metadata !158, metadata !14), !dbg !159
  store i32 1, i32* %ut4, align 4, !dbg !159
  br label %for.inc60, !dbg !160

for.inc60:                                        ; preds = %while.end59
  %23 = load i32, i32* %j, align 4, !dbg !161
  %inc61 = add nsw i32 %23, 1, !dbg !161
  store i32 %inc61, i32* %j, align 4, !dbg !161
  br label %for.cond45, !dbg !162, !llvm.loop !163

for.end62:                                        ; preds = %for.cond45
  br label %if.end70, !dbg !165

if.else63:                                        ; preds = %sw.epilog
  %call64 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !166
  %cmp65 = icmp ne i8* %call64, null, !dbg !168
  br i1 %cmp65, label %if.then67, label %if.end69, !dbg !169

if.then67:                                        ; preds = %if.else63
  call void @llvm.dbg.declare(metadata i32* %t68, metadata !170, metadata !14), !dbg !172
  store i32 1, i32* %t68, align 4, !dbg !172
  br label %if.end69, !dbg !173

if.end69:                                         ; preds = %if.then67, %if.else63
  br label %if.end70

if.end70:                                         ; preds = %if.end69, %for.end62
  call void @llvm.dbg.declare(metadata i32* %no_taint, metadata !174, metadata !14), !dbg !175
  store i32 1, i32* %no_taint, align 4, !dbg !175
  br label %while.cond71, !dbg !176

while.cond71:                                     ; preds = %if.end85, %if.end70
  %call72 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !177
  %cmp73 = icmp ne i8* %call72, null, !dbg !178
  br i1 %cmp73, label %while.body75, label %while.end86, !dbg !176

while.body75:                                     ; preds = %while.cond71
  %24 = load i32, i32* %no_taint, align 4, !dbg !179
  %cmp76 = icmp eq i32 %24, 1, !dbg !182
  br i1 %cmp76, label %if.then78, label %if.end79, !dbg !183

if.then78:                                        ; preds = %while.body75
  br label %while.end86, !dbg !184

if.end79:                                         ; preds = %while.body75
  call void @llvm.dbg.declare(metadata i32* %taint_me80, metadata !185, metadata !14), !dbg !186
  store i32 1, i32* %taint_me80, align 4, !dbg !186
  %25 = load i32, i32* %d, align 4, !dbg !187
  %tobool81 = icmp ne i32 %25, 0, !dbg !187
  br i1 %tobool81, label %if.then82, label %if.else83, !dbg !189

if.then82:                                        ; preds = %if.end79
  br label %err, !dbg !190

if.else83:                                        ; preds = %if.end79
  call void @llvm.dbg.declare(metadata i32* %t84, metadata !192, metadata !14), !dbg !194
  store i32 1, i32* %t84, align 4, !dbg !194
  br label %if.end85

if.end85:                                         ; preds = %if.else83
  br label %while.cond71, !dbg !176, !llvm.loop !195

while.end86:                                      ; preds = %if.then78, %while.cond71
  br label %if.end87, !dbg !197

if.end87:                                         ; preds = %while.end86, %entry
  call void @llvm.dbg.declare(metadata i32* %ut6, metadata !198, metadata !14), !dbg !199
  store i32 1, i32* %ut6, align 4, !dbg !199
  br label %err, !dbg !200

err:                                              ; preds = %if.end87, %if.then82, %sw.default
  call void @llvm.dbg.declare(metadata i32* %no_taint88, metadata !201, metadata !14), !dbg !202
  store i32 1, i32* %no_taint88, align 4, !dbg !202
  %26 = load i32, i32* %rc, align 4, !dbg !203
  store i32 %26, i32* %retval, align 4, !dbg !204
  br label %return, !dbg !204

return:                                           ; preds = %err, %if.then35
  %27 = load i32, i32* %retval, align 4, !dbg !205
  ret i32 %27, !dbg !205
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-26")
!2 = !{}
!3 = !{!4, !5}
!4 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!6 = !{i32 2, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !11, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: false, unit: !0, variables: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!4}
!13 = !DILocalVariable(name: "a", scope: !10, file: !1, line: 4, type: !4)
!14 = !DIExpression()
!15 = !DILocation(line: 4, column: 9, scope: !10)
!16 = !DILocalVariable(name: "b", scope: !10, file: !1, line: 4, type: !4)
!17 = !DILocation(line: 4, column: 11, scope: !10)
!18 = !DILocalVariable(name: "c", scope: !10, file: !1, line: 4, type: !4)
!19 = !DILocation(line: 4, column: 13, scope: !10)
!20 = !DILocalVariable(name: "d", scope: !10, file: !1, line: 4, type: !4)
!21 = !DILocation(line: 4, column: 15, scope: !10)
!22 = !DILocalVariable(name: "e", scope: !10, file: !1, line: 4, type: !4)
!23 = !DILocation(line: 4, column: 17, scope: !10)
!24 = !DILocalVariable(name: "rc", scope: !10, file: !1, line: 4, type: !4)
!25 = !DILocation(line: 4, column: 19, scope: !10)
!26 = !DILocation(line: 6, column: 9, scope: !27)
!27 = distinct !DILexicalBlock(scope: !10, file: !1, line: 6, column: 9)
!28 = !DILocation(line: 6, column: 9, scope: !10)
!29 = !DILocation(line: 7, column: 21, scope: !30)
!30 = distinct !DILexicalBlock(scope: !27, file: !1, line: 6, column: 12)
!31 = !DILocation(line: 7, column: 16, scope: !30)
!32 = !DILocation(line: 7, column: 9, scope: !30)
!33 = !DILocalVariable(name: "taint", scope: !34, file: !1, line: 10, type: !4)
!34 = distinct !DILexicalBlock(scope: !30, file: !1, line: 7, column: 37)
!35 = !DILocation(line: 10, column: 17, scope: !34)
!36 = !DILocation(line: 11, column: 13, scope: !34)
!37 = !DILocalVariable(name: "taint2", scope: !34, file: !1, line: 14, type: !4)
!38 = !DILocation(line: 14, column: 17, scope: !34)
!39 = !DILocation(line: 14, column: 13, scope: !34)
!40 = !DILocation(line: 17, column: 13, scope: !34)
!41 = !DILocation(line: 20, column: 13, scope: !42)
!42 = distinct !DILexicalBlock(scope: !30, file: !1, line: 20, column: 13)
!43 = !DILocation(line: 20, column: 13, scope: !30)
!44 = !DILocation(line: 21, column: 13, scope: !45)
!45 = distinct !DILexicalBlock(scope: !42, file: !1, line: 20, column: 16)
!46 = !DILocation(line: 21, column: 20, scope: !45)
!47 = !DILocation(line: 21, column: 22, scope: !45)
!48 = !DILocalVariable(name: "i", scope: !49, file: !1, line: 22, type: !4)
!49 = distinct !DILexicalBlock(scope: !50, file: !1, line: 22, column: 17)
!50 = distinct !DILexicalBlock(scope: !45, file: !1, line: 21, column: 31)
!51 = !DILocation(line: 22, column: 26, scope: !49)
!52 = !DILocation(line: 22, column: 22, scope: !49)
!53 = !DILocation(line: 22, column: 33, scope: !54)
!54 = distinct !DILexicalBlock(scope: !49, file: !1, line: 22, column: 17)
!55 = !DILocation(line: 22, column: 38, scope: !54)
!56 = !DILocation(line: 22, column: 53, scope: !54)
!57 = !DILocation(line: 22, column: 35, scope: !54)
!58 = !DILocation(line: 22, column: 17, scope: !49)
!59 = !DILocation(line: 23, column: 21, scope: !60)
!60 = distinct !DILexicalBlock(scope: !54, file: !1, line: 22, column: 68)
!61 = distinct !{!61, !59, !62}
!62 = !DILocation(line: 42, column: 44, scope: !60)
!63 = !DILocation(line: 24, column: 25, scope: !64)
!64 = distinct !DILexicalBlock(scope: !60, file: !1, line: 23, column: 24)
!65 = !DILocation(line: 24, column: 32, scope: !64)
!66 = !DILocation(line: 24, column: 47, scope: !64)
!67 = !DILocation(line: 25, column: 34, scope: !68)
!68 = distinct !DILexicalBlock(scope: !69, file: !1, line: 25, column: 33)
!69 = distinct !DILexicalBlock(scope: !64, file: !1, line: 24, column: 56)
!70 = !DILocation(line: 25, column: 49, scope: !68)
!71 = !DILocation(line: 25, column: 52, scope: !68)
!72 = !DILocation(line: 25, column: 54, scope: !68)
!73 = !DILocation(line: 25, column: 57, scope: !68)
!74 = !DILocation(line: 25, column: 59, scope: !68)
!75 = !DILocation(line: 25, column: 62, scope: !68)
!76 = !DILocation(line: 25, column: 65, scope: !68)
!77 = !DILocation(line: 25, column: 68, scope: !68)
!78 = !DILocation(line: 25, column: 33, scope: !69)
!79 = !DILocation(line: 26, column: 37, scope: !80)
!80 = distinct !DILexicalBlock(scope: !81, file: !1, line: 26, column: 37)
!81 = distinct !DILexicalBlock(scope: !68, file: !1, line: 25, column: 71)
!82 = !DILocation(line: 26, column: 37, scope: !81)
!83 = !DILocation(line: 27, column: 37, scope: !84)
!84 = distinct !DILexicalBlock(scope: !80, file: !1, line: 26, column: 40)
!85 = distinct !{!85, !83, !86}
!86 = !DILocation(line: 29, column: 47, scope: !84)
!87 = !DILocalVariable(name: "a", scope: !88, file: !1, line: 28, type: !4)
!88 = distinct !DILexicalBlock(scope: !84, file: !1, line: 27, column: 40)
!89 = !DILocation(line: 28, column: 45, scope: !88)
!90 = !DILocation(line: 29, column: 37, scope: !88)
!91 = !DILocation(line: 30, column: 33, scope: !84)
!92 = !DILocalVariable(name: "b", scope: !93, file: !1, line: 31, type: !4)
!93 = distinct !DILexicalBlock(scope: !80, file: !1, line: 30, column: 40)
!94 = !DILocation(line: 31, column: 41, scope: !93)
!95 = !DILocation(line: 33, column: 29, scope: !81)
!96 = !DILocation(line: 33, column: 40, scope: !97)
!97 = distinct !DILexicalBlock(scope: !68, file: !1, line: 33, column: 40)
!98 = !DILocation(line: 33, column: 42, scope: !97)
!99 = !DILocation(line: 33, column: 45, scope: !97)
!100 = !DILocation(line: 33, column: 47, scope: !97)
!101 = !DILocation(line: 33, column: 50, scope: !97)
!102 = !DILocation(line: 33, column: 40, scope: !68)
!103 = !DILocalVariable(name: "t", scope: !104, file: !1, line: 34, type: !4)
!104 = distinct !DILexicalBlock(scope: !97, file: !1, line: 33, column: 53)
!105 = !DILocation(line: 34, column: 37, scope: !104)
!106 = !DILocation(line: 34, column: 41, scope: !104)
!107 = !DILocation(line: 35, column: 38, scope: !108)
!108 = distinct !DILexicalBlock(scope: !104, file: !1, line: 35, column: 37)
!109 = !DILocation(line: 35, column: 37, scope: !104)
!110 = !DILocation(line: 35, column: 41, scope: !108)
!111 = !DILocation(line: 36, column: 29, scope: !104)
!112 = !DILocalVariable(name: "t", scope: !113, file: !1, line: 37, type: !4)
!113 = distinct !DILexicalBlock(scope: !97, file: !1, line: 36, column: 36)
!114 = !DILocation(line: 37, column: 37, scope: !113)
!115 = !DILocation(line: 39, column: 32, scope: !69)
!116 = distinct !{!116, !63, !117}
!117 = !DILocation(line: 40, column: 25, scope: !64)
!118 = !DILocalVariable(name: "end1", scope: !64, file: !1, line: 41, type: !4)
!119 = !DILocation(line: 41, column: 29, scope: !64)
!120 = !DILocation(line: 42, column: 21, scope: !64)
!121 = !DILocation(line: 42, column: 30, scope: !60)
!122 = !DILocalVariable(name: "end2", scope: !60, file: !1, line: 43, type: !4)
!123 = !DILocation(line: 43, column: 25, scope: !60)
!124 = !DILocation(line: 44, column: 17, scope: !60)
!125 = !DILocation(line: 22, column: 63, scope: !54)
!126 = !DILocation(line: 22, column: 17, scope: !54)
!127 = distinct !{!127, !58, !128}
!128 = !DILocation(line: 44, column: 17, scope: !49)
!129 = distinct !{!129, !44, !130}
!130 = !DILocation(line: 45, column: 13, scope: !45)
!131 = !DILocalVariable(name: "ut1", scope: !45, file: !1, line: 46, type: !4)
!132 = !DILocation(line: 46, column: 17, scope: !45)
!133 = !DILocalVariable(name: "j", scope: !134, file: !1, line: 47, type: !4)
!134 = distinct !DILexicalBlock(scope: !45, file: !1, line: 47, column: 13)
!135 = !DILocation(line: 47, column: 22, scope: !134)
!136 = !DILocation(line: 47, column: 18, scope: !134)
!137 = !DILocation(line: 47, column: 29, scope: !138)
!138 = distinct !DILexicalBlock(scope: !134, file: !1, line: 47, column: 13)
!139 = !DILocation(line: 47, column: 31, scope: !138)
!140 = !DILocation(line: 47, column: 13, scope: !134)
!141 = !DILocation(line: 48, column: 17, scope: !142)
!142 = distinct !DILexicalBlock(scope: !138, file: !1, line: 47, column: 42)
!143 = !DILocation(line: 48, column: 25, scope: !142)
!144 = !DILocation(line: 48, column: 27, scope: !142)
!145 = !DILocation(line: 48, column: 30, scope: !142)
!146 = !DILocation(line: 48, column: 32, scope: !142)
!147 = !DILocation(line: 48, column: 35, scope: !142)
!148 = !DILocation(line: 48, column: 38, scope: !142)
!149 = !DILocation(line: 48, column: 41, scope: !142)
!150 = !DILocation(line: 48, column: 51, scope: !142)
!151 = !DILocation(line: 48, column: 46, scope: !142)
!152 = !DILocation(line: 48, column: 43, scope: !142)
!153 = !DILocalVariable(name: "taint_me", scope: !154, file: !1, line: 49, type: !4)
!154 = distinct !DILexicalBlock(scope: !142, file: !1, line: 48, column: 67)
!155 = !DILocation(line: 49, column: 25, scope: !154)
!156 = distinct !{!156, !141, !157}
!157 = !DILocation(line: 50, column: 17, scope: !142)
!158 = !DILocalVariable(name: "ut4", scope: !142, file: !1, line: 51, type: !4)
!159 = !DILocation(line: 51, column: 21, scope: !142)
!160 = !DILocation(line: 52, column: 13, scope: !142)
!161 = !DILocation(line: 47, column: 37, scope: !138)
!162 = !DILocation(line: 47, column: 13, scope: !138)
!163 = distinct !{!163, !140, !164}
!164 = !DILocation(line: 52, column: 13, scope: !134)
!165 = !DILocation(line: 53, column: 9, scope: !45)
!166 = !DILocation(line: 53, column: 20, scope: !167)
!167 = distinct !DILexicalBlock(scope: !42, file: !1, line: 53, column: 20)
!168 = !DILocation(line: 53, column: 35, scope: !167)
!169 = !DILocation(line: 53, column: 20, scope: !42)
!170 = !DILocalVariable(name: "t", scope: !171, file: !1, line: 54, type: !4)
!171 = distinct !DILexicalBlock(scope: !167, file: !1, line: 53, column: 44)
!172 = !DILocation(line: 54, column: 17, scope: !171)
!173 = !DILocation(line: 55, column: 9, scope: !171)
!174 = !DILocalVariable(name: "no_taint", scope: !30, file: !1, line: 57, type: !4)
!175 = !DILocation(line: 57, column: 13, scope: !30)
!176 = !DILocation(line: 59, column: 9, scope: !30)
!177 = !DILocation(line: 59, column: 16, scope: !30)
!178 = !DILocation(line: 59, column: 31, scope: !30)
!179 = !DILocation(line: 60, column: 17, scope: !180)
!180 = distinct !DILexicalBlock(scope: !181, file: !1, line: 60, column: 17)
!181 = distinct !DILexicalBlock(scope: !30, file: !1, line: 59, column: 40)
!182 = !DILocation(line: 60, column: 26, scope: !180)
!183 = !DILocation(line: 60, column: 17, scope: !181)
!184 = !DILocation(line: 60, column: 32, scope: !180)
!185 = !DILocalVariable(name: "taint_me", scope: !181, file: !1, line: 61, type: !4)
!186 = !DILocation(line: 61, column: 17, scope: !181)
!187 = !DILocation(line: 62, column: 17, scope: !188)
!188 = distinct !DILexicalBlock(scope: !181, file: !1, line: 62, column: 17)
!189 = !DILocation(line: 62, column: 17, scope: !181)
!190 = !DILocation(line: 63, column: 17, scope: !191)
!191 = distinct !DILexicalBlock(scope: !188, file: !1, line: 62, column: 20)
!192 = !DILocalVariable(name: "t", scope: !193, file: !1, line: 65, type: !4)
!193 = distinct !DILexicalBlock(scope: !188, file: !1, line: 64, column: 20)
!194 = !DILocation(line: 65, column: 21, scope: !193)
!195 = distinct !{!195, !176, !196}
!196 = !DILocation(line: 67, column: 9, scope: !30)
!197 = !DILocation(line: 68, column: 5, scope: !30)
!198 = !DILocalVariable(name: "ut6", scope: !10, file: !1, line: 69, type: !4)
!199 = !DILocation(line: 69, column: 9, scope: !10)
!200 = !DILocation(line: 69, column: 5, scope: !10)
!201 = !DILocalVariable(name: "no_taint", scope: !10, file: !1, line: 72, type: !4)
!202 = !DILocation(line: 72, column: 9, scope: !10)
!203 = !DILocation(line: 73, column: 12, scope: !10)
!204 = !DILocation(line: 73, column: 5, scope: !10)
!205 = !DILocation(line: 74, column: 1, scope: !10)
