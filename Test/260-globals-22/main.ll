; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@gt = common global i8* null, align 8, !dbg !0
@.str.1 = private unnamed_addr constant [3 x i8] c"hi\00", align 1
@gt2 = common global i8* null, align 8, !dbg !8

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !16 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %t1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !20
  store i8* %call, i8** @gt, align 8, !dbg !21
  %0 = load i8*, i8** @gt, align 8, !dbg !22
  %cmp = icmp ne i8* %0, null, !dbg !24
  br i1 %cmp, label %lor.end, label %lor.rhs, !dbg !25

lor.rhs:                                          ; preds = %entry
  %call1 = call i32 (...) @foo(), !dbg !26
  %tobool = icmp ne i32 %call1, 0, !dbg !25
  br label %lor.end, !dbg !25

lor.end:                                          ; preds = %lor.rhs, %entry
  %1 = phi i1 [ true, %entry ], [ %tobool, %lor.rhs ]
  %lor.ext = zext i1 %1 to i32, !dbg !25
  %call2 = call i32 (...) @bar(), !dbg !27
  %xor = xor i32 %lor.ext, %call2, !dbg !28
  %tobool3 = icmp ne i32 %xor, 0, !dbg !28
  br i1 %tobool3, label %if.then, label %if.end, !dbg !29

if.then:                                          ; preds = %lor.end
  call void @llvm.dbg.declare(metadata i32* %a, metadata !30, metadata !32), !dbg !33
  store i32 0, i32* %a, align 4, !dbg !33
  br label %while.cond, !dbg !34

while.cond:                                       ; preds = %while.body, %if.then
  %2 = load i32, i32* %a, align 4, !dbg !35
  %tobool4 = icmp ne i32 %2, 0, !dbg !34
  br i1 %tobool4, label %while.body, label %while.end, !dbg !34

while.body:                                       ; preds = %while.cond
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i32 0, i32 0), i8** @gt2, align 8, !dbg !36
  br label %while.cond, !dbg !34, !llvm.loop !38

while.end:                                        ; preds = %while.cond
  br label %if.end, !dbg !40

if.end:                                           ; preds = %while.end, %lor.end
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !41, metadata !32), !dbg !42
  %3 = load i8*, i8** @gt, align 8, !dbg !43
  store i8* %3, i8** %t1, align 8, !dbg !42
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !44, metadata !32), !dbg !45
  %4 = load i8*, i8** @gt2, align 8, !dbg !46
  store i8* %4, i8** %t2, align 8, !dbg !45
  ret i32 0, !dbg !47
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #1

declare i32 @foo(...) #2

declare i32 @bar(...) #2

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!12, !13, !14}
!llvm.ident = !{!15}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "gt", scope: !2, file: !3, line: 7, type: !10, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !7)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-22")
!4 = !{}
!5 = !{!6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !{!0, !8}
!8 = !DIGlobalVariableExpression(var: !9)
!9 = distinct !DIGlobalVariable(name: "gt2", scope: !2, file: !3, line: 8, type: !10, isLocal: false, isDefinition: true)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !{i32 2, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!16 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 11, type: !17, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !2, variables: !4)
!17 = !DISubroutineType(types: !18)
!18 = !{!19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DILocation(line: 12, column: 10, scope: !16)
!21 = !DILocation(line: 12, column: 8, scope: !16)
!22 = !DILocation(line: 14, column: 10, scope: !23)
!23 = distinct !DILexicalBlock(scope: !16, file: !3, line: 14, column: 9)
!24 = !DILocation(line: 14, column: 13, scope: !23)
!25 = !DILocation(line: 14, column: 21, scope: !23)
!26 = !DILocation(line: 14, column: 24, scope: !23)
!27 = !DILocation(line: 14, column: 33, scope: !23)
!28 = !DILocation(line: 14, column: 31, scope: !23)
!29 = !DILocation(line: 14, column: 9, scope: !16)
!30 = !DILocalVariable(name: "a", scope: !31, file: !3, line: 15, type: !19)
!31 = distinct !DILexicalBlock(scope: !23, file: !3, line: 14, column: 40)
!32 = !DIExpression()
!33 = !DILocation(line: 15, column: 13, scope: !31)
!34 = !DILocation(line: 17, column: 9, scope: !31)
!35 = !DILocation(line: 17, column: 16, scope: !31)
!36 = !DILocation(line: 18, column: 17, scope: !37)
!37 = distinct !DILexicalBlock(scope: !31, file: !3, line: 17, column: 19)
!38 = distinct !{!38, !34, !39}
!39 = !DILocation(line: 19, column: 9, scope: !31)
!40 = !DILocation(line: 20, column: 5, scope: !31)
!41 = !DILocalVariable(name: "t1", scope: !16, file: !3, line: 22, type: !10)
!42 = !DILocation(line: 22, column: 11, scope: !16)
!43 = !DILocation(line: 22, column: 16, scope: !16)
!44 = !DILocalVariable(name: "t2", scope: !16, file: !3, line: 23, type: !10)
!45 = !DILocation(line: 23, column: 11, scope: !16)
!46 = !DILocation(line: 23, column: 16, scope: !16)
!47 = !DILocation(line: 25, column: 5, scope: !16)
