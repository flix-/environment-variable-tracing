; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"ploink\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i8* %t, i8* %ut) #0 !dbg !9 {
entry:
  %t.addr = alloca i8*, align 8
  %ut.addr = alloca i8*, align 8
  %t2 = alloca i32, align 4
  %a = alloca i32, align 4
  %a5 = alloca i32, align 4
  store i8* %t, i8** %t.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %t.addr, metadata !15, metadata !16), !dbg !17
  store i8* %ut, i8** %ut.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %ut.addr, metadata !18, metadata !16), !dbg !19
  %0 = load i8*, i8** %t.addr, align 8, !dbg !20
  %cmp = icmp eq i8* %0, null, !dbg !22
  br i1 %cmp, label %land.lhs.true, label %if.else, !dbg !23

land.lhs.true:                                    ; preds = %entry
  %1 = load i8*, i8** %ut.addr, align 8, !dbg !24
  %cmp1 = icmp eq i8* %1, null, !dbg !25
  br i1 %cmp1, label %if.then, label %if.else, !dbg !26

if.then:                                          ; preds = %land.lhs.true
  br label %do.body, !dbg !27, !llvm.loop !29

do.body:                                          ; preds = %if.then
  call void @llvm.dbg.declare(metadata i32* %t2, metadata !31, metadata !16), !dbg !33
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !34
  %tobool = icmp ne i8* %call, null, !dbg !34
  br i1 %tobool, label %cond.true, label %cond.false, !dbg !34

cond.true:                                        ; preds = %do.body
  %call3 = call i32 (...) @bar(), !dbg !35
  br label %cond.end, !dbg !34

cond.false:                                       ; preds = %do.body
  %call4 = call i32 (...) @ploink(), !dbg !36
  br label %cond.end, !dbg !34

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %call3, %cond.true ], [ %call4, %cond.false ], !dbg !34
  store i32 %cond, i32* %t2, align 4, !dbg !33
  br label %do.end, !dbg !37

do.end:                                           ; preds = %cond.end
  br label %if.end, !dbg !38

if.else:                                          ; preds = %land.lhs.true, %entry
  call void @llvm.dbg.declare(metadata i32* %a, metadata !39, metadata !16), !dbg !41
  store i32 1, i32* %a, align 4, !dbg !41
  br label %if.end

if.end:                                           ; preds = %if.else, %do.end
  call void @llvm.dbg.declare(metadata i32* %a5, metadata !42, metadata !16), !dbg !43
  store i32 0, i32* %a5, align 4, !dbg !43
  ret i32 1, !dbg !44
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

declare i32 @bar(...) #3

declare i32 @ploink(...) #3

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !45 {
entry:
  %retval = alloca i32, align 4
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !48, metadata !16), !dbg !49
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !50
  store i8* %call, i8** %tainted, align 8, !dbg !49
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !51, metadata !16), !dbg !52
  %0 = load i8*, i8** %tainted, align 8, !dbg !53
  %call1 = call i32 @foo(i8* %0, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i32 0, i32 0)), !dbg !54
  store i32 %call1, i32* %rc, align 4, !dbg !52
  ret i32 0, !dbg !55
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-22")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 8, type: !10, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !13, !13}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !DILocalVariable(name: "t", arg: 1, scope: !9, file: !1, line: 8, type: !13)
!16 = !DIExpression()
!17 = !DILocation(line: 8, column: 11, scope: !9)
!18 = !DILocalVariable(name: "ut", arg: 2, scope: !9, file: !1, line: 8, type: !13)
!19 = !DILocation(line: 8, column: 20, scope: !9)
!20 = !DILocation(line: 9, column: 9, scope: !21)
!21 = distinct !DILexicalBlock(scope: !9, file: !1, line: 9, column: 9)
!22 = !DILocation(line: 9, column: 11, scope: !21)
!23 = !DILocation(line: 9, column: 19, scope: !21)
!24 = !DILocation(line: 9, column: 22, scope: !21)
!25 = !DILocation(line: 9, column: 25, scope: !21)
!26 = !DILocation(line: 9, column: 9, scope: !9)
!27 = !DILocation(line: 10, column: 9, scope: !28)
!28 = distinct !DILexicalBlock(scope: !21, file: !1, line: 9, column: 34)
!29 = distinct !{!29, !27, !30}
!30 = !DILocation(line: 12, column: 19, scope: !28)
!31 = !DILocalVariable(name: "t", scope: !32, file: !1, line: 11, type: !12)
!32 = distinct !DILexicalBlock(scope: !28, file: !1, line: 10, column: 12)
!33 = !DILocation(line: 11, column: 17, scope: !32)
!34 = !DILocation(line: 11, column: 21, scope: !32)
!35 = !DILocation(line: 11, column: 38, scope: !32)
!36 = !DILocation(line: 11, column: 46, scope: !32)
!37 = !DILocation(line: 12, column: 9, scope: !32)
!38 = !DILocation(line: 13, column: 5, scope: !28)
!39 = !DILocalVariable(name: "a", scope: !40, file: !1, line: 14, type: !12)
!40 = distinct !DILexicalBlock(scope: !21, file: !1, line: 13, column: 12)
!41 = !DILocation(line: 14, column: 13, scope: !40)
!42 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 17, type: !12)
!43 = !DILocation(line: 17, column: 9, scope: !9)
!44 = !DILocation(line: 19, column: 5, scope: !9)
!45 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 23, type: !46, isLocal: false, isDefinition: true, scopeLine: 23, isOptimized: false, unit: !0, variables: !2)
!46 = !DISubroutineType(types: !47)
!47 = !{!12}
!48 = !DILocalVariable(name: "tainted", scope: !45, file: !1, line: 24, type: !13)
!49 = !DILocation(line: 24, column: 11, scope: !45)
!50 = !DILocation(line: 24, column: 21, scope: !45)
!51 = !DILocalVariable(name: "rc", scope: !45, file: !1, line: 26, type: !12)
!52 = !DILocation(line: 26, column: 9, scope: !45)
!53 = !DILocation(line: 26, column: 18, scope: !45)
!54 = !DILocation(line: 26, column: 14, scope: !45)
!55 = !DILocation(line: 28, column: 5, scope: !45)
