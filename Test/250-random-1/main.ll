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
  %a = alloca i32, align 4
  store i8* %t, i8** %t.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %t.addr, metadata !15, metadata !16), !dbg !17
  store i8* %ut, i8** %ut.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %ut.addr, metadata !18, metadata !16), !dbg !19
  %0 = load i8*, i8** %t.addr, align 8, !dbg !20
  %cmp = icmp eq i8* %0, null, !dbg !22
  br i1 %cmp, label %if.then, label %lor.lhs.false, !dbg !23

lor.lhs.false:                                    ; preds = %entry
  %1 = load i8*, i8** %ut.addr, align 8, !dbg !24
  %cmp1 = icmp eq i8* %1, null, !dbg !25
  br i1 %cmp1, label %if.then, label %if.end, !dbg !26

if.then:                                          ; preds = %lor.lhs.false, %entry
  br label %do.body, !dbg !27, !llvm.loop !29

do.body:                                          ; preds = %if.then
  br label %do.end, !dbg !31

do.end:                                           ; preds = %do.body
  br label %if.end, !dbg !33

if.end:                                           ; preds = %do.end, %lor.lhs.false
  call void @llvm.dbg.declare(metadata i32* %a, metadata !34, metadata !16), !dbg !35
  store i32 0, i32* %a, align 4, !dbg !35
  ret i32 1, !dbg !36
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !37 {
entry:
  %retval = alloca i32, align 4
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !40, metadata !16), !dbg !41
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !42
  store i8* %call, i8** %tainted, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !43, metadata !16), !dbg !44
  %0 = load i8*, i8** %tainted, align 8, !dbg !45
  %call1 = call i32 @foo(i8* %0, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i32 0, i32 0)), !dbg !46
  store i32 %call1, i32* %rc, align 4, !dbg !44
  ret i32 0, !dbg !47
}

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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/250-random-1")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 5, type: !10, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !13, !13}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !DILocalVariable(name: "t", arg: 1, scope: !9, file: !1, line: 5, type: !13)
!16 = !DIExpression()
!17 = !DILocation(line: 5, column: 11, scope: !9)
!18 = !DILocalVariable(name: "ut", arg: 2, scope: !9, file: !1, line: 5, type: !13)
!19 = !DILocation(line: 5, column: 20, scope: !9)
!20 = !DILocation(line: 8, column: 13, scope: !21)
!21 = distinct !DILexicalBlock(scope: !9, file: !1, line: 8, column: 13)
!22 = !DILocation(line: 8, column: 15, scope: !21)
!23 = !DILocation(line: 8, column: 23, scope: !21)
!24 = !DILocation(line: 8, column: 26, scope: !21)
!25 = !DILocation(line: 8, column: 29, scope: !21)
!26 = !DILocation(line: 8, column: 13, scope: !9)
!27 = !DILocation(line: 9, column: 13, scope: !28)
!28 = distinct !DILexicalBlock(scope: !21, file: !1, line: 8, column: 38)
!29 = distinct !{!29, !27, !30}
!30 = !DILocation(line: 10, column: 23, scope: !28)
!31 = !DILocation(line: 10, column: 13, scope: !32)
!32 = distinct !DILexicalBlock(scope: !28, file: !1, line: 9, column: 16)
!33 = !DILocation(line: 11, column: 9, scope: !28)
!34 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 14, type: !12)
!35 = !DILocation(line: 14, column: 9, scope: !9)
!36 = !DILocation(line: 16, column: 5, scope: !9)
!37 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !38, isLocal: false, isDefinition: true, scopeLine: 20, isOptimized: false, unit: !0, variables: !2)
!38 = !DISubroutineType(types: !39)
!39 = !{!12}
!40 = !DILocalVariable(name: "tainted", scope: !37, file: !1, line: 21, type: !13)
!41 = !DILocation(line: 21, column: 11, scope: !37)
!42 = !DILocation(line: 21, column: 21, scope: !37)
!43 = !DILocalVariable(name: "rc", scope: !37, file: !1, line: 23, type: !12)
!44 = !DILocation(line: 23, column: 9, scope: !37)
!45 = !DILocation(line: 23, column: 18, scope: !37)
!46 = !DILocation(line: 23, column: 14, scope: !37)
!47 = !DILocation(line: 25, column: 5, scope: !37)
