; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"untainted\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %u = alloca i8*, align 8
  %pu = alloca i8**, align 8
  %ppu = alloca i8***, align 8
  %t = alloca i8*, align 8
  %pt = alloca i8**, align 8
  %ppt = alloca i8***, align 8
  %tainted = alloca i8*, align 8
  %not_tainted = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %u, metadata !11, metadata !14), !dbg !15
  store i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i32 0, i32 0), i8** %u, align 8, !dbg !15
  call void @llvm.dbg.declare(metadata i8*** %pu, metadata !16, metadata !14), !dbg !18
  store i8** %u, i8*** %pu, align 8, !dbg !18
  call void @llvm.dbg.declare(metadata i8**** %ppu, metadata !19, metadata !14), !dbg !21
  store i8*** %pu, i8**** %ppu, align 8, !dbg !21
  call void @llvm.dbg.declare(metadata i8** %t, metadata !22, metadata !14), !dbg !23
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)), !dbg !24
  store i8* %call, i8** %t, align 8, !dbg !23
  call void @llvm.dbg.declare(metadata i8*** %pt, metadata !25, metadata !14), !dbg !26
  store i8** %t, i8*** %pt, align 8, !dbg !26
  call void @llvm.dbg.declare(metadata i8**** %ppt, metadata !27, metadata !14), !dbg !28
  store i8*** %pt, i8**** %ppt, align 8, !dbg !28
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !29, metadata !14), !dbg !30
  %0 = load i8***, i8**** %ppt, align 8, !dbg !31
  %1 = load i8**, i8*** %0, align 8, !dbg !32
  %2 = load i8*, i8** %1, align 8, !dbg !33
  store i8* %2, i8** %tainted, align 8, !dbg !30
  %3 = load i8***, i8**** %ppu, align 8, !dbg !34
  store i8*** %3, i8**** %ppt, align 8, !dbg !35
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !36, metadata !14), !dbg !37
  %4 = load i8***, i8**** %ppt, align 8, !dbg !38
  %5 = load i8**, i8*** %4, align 8, !dbg !39
  %6 = load i8*, i8** %5, align 8, !dbg !40
  store i8* %6, i8** %not_tainted, align 8, !dbg !37
  ret i32 0, !dbg !41
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/151-ptr-3")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 15, type: !8, isLocal: false, isDefinition: true, scopeLine: 16, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "u", scope: !7, file: !1, line: 17, type: !12)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!14 = !DIExpression()
!15 = !DILocation(line: 17, column: 11, scope: !7)
!16 = !DILocalVariable(name: "pu", scope: !7, file: !1, line: 18, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!18 = !DILocation(line: 18, column: 12, scope: !7)
!19 = !DILocalVariable(name: "ppu", scope: !7, file: !1, line: 19, type: !20)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!21 = !DILocation(line: 19, column: 13, scope: !7)
!22 = !DILocalVariable(name: "t", scope: !7, file: !1, line: 21, type: !12)
!23 = !DILocation(line: 21, column: 11, scope: !7)
!24 = !DILocation(line: 21, column: 15, scope: !7)
!25 = !DILocalVariable(name: "pt", scope: !7, file: !1, line: 22, type: !17)
!26 = !DILocation(line: 22, column: 12, scope: !7)
!27 = !DILocalVariable(name: "ppt", scope: !7, file: !1, line: 23, type: !20)
!28 = !DILocation(line: 23, column: 13, scope: !7)
!29 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 25, type: !12)
!30 = !DILocation(line: 25, column: 11, scope: !7)
!31 = !DILocation(line: 25, column: 23, scope: !7)
!32 = !DILocation(line: 25, column: 22, scope: !7)
!33 = !DILocation(line: 25, column: 21, scope: !7)
!34 = !DILocation(line: 27, column: 11, scope: !7)
!35 = !DILocation(line: 27, column: 9, scope: !7)
!36 = !DILocalVariable(name: "not_tainted", scope: !7, file: !1, line: 29, type: !12)
!37 = !DILocation(line: 29, column: 11, scope: !7)
!38 = !DILocation(line: 29, column: 27, scope: !7)
!39 = !DILocation(line: 29, column: 26, scope: !7)
!40 = !DILocation(line: 29, column: 25, scope: !7)
!41 = !DILocation(line: 31, column: 5, scope: !7)
