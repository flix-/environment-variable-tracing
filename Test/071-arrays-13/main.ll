; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i8* @foo() #0 !dbg !7 {
entry:
  %str = alloca [2 x i8*], align 16
  call void @llvm.dbg.declare(metadata [2 x i8*]* %str, metadata !12, metadata !16), !dbg !17
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !18
  %arrayidx = getelementptr inbounds [2 x i8*], [2 x i8*]* %str, i64 0, i64 1, !dbg !19
  store i8* %call, i8** %arrayidx, align 8, !dbg !20
  %arrayidx1 = getelementptr inbounds [2 x i8*], [2 x i8*]* %str, i64 0, i64 1, !dbg !21
  %0 = load i8*, i8** %arrayidx1, align 8, !dbg !21
  ret i8* %0, !dbg !22
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !23 {
entry:
  %retval = alloca i32, align 4
  %str = alloca i8*, align 8
  %t = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %str, metadata !27, metadata !16), !dbg !28
  %call = call i8* @foo(), !dbg !29
  store i8* %call, i8** %str, align 8, !dbg !28
  call void @llvm.dbg.declare(metadata i8** %t, metadata !30, metadata !16), !dbg !31
  %0 = load i8*, i8** %str, align 8, !dbg !32
  store i8* %0, i8** %t, align 8, !dbg !31
  ret i32 0, !dbg !33
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/071-arrays-13")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 4, type: !8, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !DILocalVariable(name: "str", scope: !7, file: !1, line: 5, type: !13)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 128, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 2)
!16 = !DIExpression()
!17 = !DILocation(line: 5, column: 11, scope: !7)
!18 = !DILocation(line: 6, column: 14, scope: !7)
!19 = !DILocation(line: 6, column: 5, scope: !7)
!20 = !DILocation(line: 6, column: 12, scope: !7)
!21 = !DILocation(line: 8, column: 12, scope: !7)
!22 = !DILocation(line: 8, column: 5, scope: !7)
!23 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !24, isLocal: false, isDefinition: true, scopeLine: 13, isOptimized: false, unit: !0, variables: !2)
!24 = !DISubroutineType(types: !25)
!25 = !{!26}
!26 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!27 = !DILocalVariable(name: "str", scope: !23, file: !1, line: 14, type: !10)
!28 = !DILocation(line: 14, column: 11, scope: !23)
!29 = !DILocation(line: 14, column: 17, scope: !23)
!30 = !DILocalVariable(name: "t", scope: !23, file: !1, line: 16, type: !10)
!31 = !DILocation(line: 16, column: 11, scope: !23)
!32 = !DILocation(line: 16, column: 15, scope: !23)
!33 = !DILocation(line: 18, column: 5, scope: !23)
