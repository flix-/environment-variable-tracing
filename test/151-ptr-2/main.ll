; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i8*, align 8
  %b = alloca i8*, align 8
  %c = alloca i8**, align 8
  %tainted1 = alloca i8*, align 8
  %tainted = alloca i8**, align 8
  %tainted2 = alloca i8***, align 8
  %not_tainted1 = alloca i8*, align 8
  %not_tained2 = alloca i8**, align 8
  %not_tained3 = alloca i8***, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %a, metadata !11, metadata !14), !dbg !15
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !16
  store i8* %call, i8** %a, align 8, !dbg !15
  call void @llvm.dbg.declare(metadata i8** %b, metadata !17, metadata !14), !dbg !18
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i8** %b, align 8, !dbg !18
  call void @llvm.dbg.declare(metadata i8*** %c, metadata !19, metadata !14), !dbg !21
  store i8** %a, i8*** %c, align 8, !dbg !21
  call void @llvm.dbg.declare(metadata i8** %tainted1, metadata !22, metadata !14), !dbg !23
  %0 = load i8**, i8*** %c, align 8, !dbg !24
  %1 = load i8*, i8** %0, align 8, !dbg !25
  store i8* %1, i8** %tainted1, align 8, !dbg !23
  call void @llvm.dbg.declare(metadata i8*** %tainted, metadata !26, metadata !14), !dbg !27
  %2 = load i8**, i8*** %c, align 8, !dbg !28
  store i8** %2, i8*** %tainted, align 8, !dbg !27
  call void @llvm.dbg.declare(metadata i8**** %tainted2, metadata !29, metadata !14), !dbg !31
  store i8*** %c, i8**** %tainted2, align 8, !dbg !31
  %3 = load i8*, i8** %b, align 8, !dbg !32
  %4 = load i8**, i8*** %c, align 8, !dbg !33
  store i8* %3, i8** %4, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata i8** %not_tainted1, metadata !35, metadata !14), !dbg !36
  %5 = load i8**, i8*** %c, align 8, !dbg !37
  %6 = load i8*, i8** %5, align 8, !dbg !38
  store i8* %6, i8** %not_tainted1, align 8, !dbg !36
  call void @llvm.dbg.declare(metadata i8*** %not_tained2, metadata !39, metadata !14), !dbg !40
  %7 = load i8**, i8*** %c, align 8, !dbg !41
  store i8** %7, i8*** %not_tained2, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata i8**** %not_tained3, metadata !42, metadata !14), !dbg !43
  store i8*** %c, i8**** %not_tained3, align 8, !dbg !43
  ret i32 0, !dbg !44
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/151-ptr-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 8, type: !12)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!14 = !DIExpression()
!15 = !DILocation(line: 8, column: 11, scope: !7)
!16 = !DILocation(line: 8, column: 15, scope: !7)
!17 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 9, type: !12)
!18 = !DILocation(line: 9, column: 11, scope: !7)
!19 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 11, type: !20)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!21 = !DILocation(line: 11, column: 12, scope: !7)
!22 = !DILocalVariable(name: "tainted1", scope: !7, file: !1, line: 12, type: !12)
!23 = !DILocation(line: 12, column: 11, scope: !7)
!24 = !DILocation(line: 12, column: 23, scope: !7)
!25 = !DILocation(line: 12, column: 22, scope: !7)
!26 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 13, type: !20)
!27 = !DILocation(line: 13, column: 12, scope: !7)
!28 = !DILocation(line: 13, column: 22, scope: !7)
!29 = !DILocalVariable(name: "tainted2", scope: !7, file: !1, line: 14, type: !30)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!31 = !DILocation(line: 14, column: 13, scope: !7)
!32 = !DILocation(line: 16, column: 10, scope: !7)
!33 = !DILocation(line: 16, column: 6, scope: !7)
!34 = !DILocation(line: 16, column: 8, scope: !7)
!35 = !DILocalVariable(name: "not_tainted1", scope: !7, file: !1, line: 18, type: !12)
!36 = !DILocation(line: 18, column: 11, scope: !7)
!37 = !DILocation(line: 18, column: 27, scope: !7)
!38 = !DILocation(line: 18, column: 26, scope: !7)
!39 = !DILocalVariable(name: "not_tained2", scope: !7, file: !1, line: 19, type: !20)
!40 = !DILocation(line: 19, column: 12, scope: !7)
!41 = !DILocation(line: 19, column: 26, scope: !7)
!42 = !DILocalVariable(name: "not_tained3", scope: !7, file: !1, line: 20, type: !30)
!43 = !DILocation(line: 20, column: 13, scope: !7)
!44 = !DILocation(line: 22, column: 5, scope: !7)
