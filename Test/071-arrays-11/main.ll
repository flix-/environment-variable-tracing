; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %str = alloca [2 x i8*], align 16
  %t = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x i8*]* %str, metadata !11, metadata !17), !dbg !18
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !19
  %arrayidx = getelementptr inbounds [2 x i8*], [2 x i8*]* %str, i64 0, i64 0, !dbg !20
  store i8* %call, i8** %arrayidx, align 16, !dbg !21
  %arrayidx1 = getelementptr inbounds [2 x i8*], [2 x i8*]* %str, i64 0, i64 0, !dbg !22
  %0 = load i8*, i8** %arrayidx1, align 16, !dbg !22
  %arrayidx2 = getelementptr inbounds [2 x i8*], [2 x i8*]* %str, i64 0, i64 1, !dbg !23
  store i8* %0, i8** %arrayidx2, align 8, !dbg !24
  call void @llvm.dbg.declare(metadata i8** %t, metadata !25, metadata !17), !dbg !26
  %arrayidx3 = getelementptr inbounds [2 x i8*], [2 x i8*]* %str, i64 0, i64 1, !dbg !27
  %1 = load i8*, i8** %arrayidx3, align 8, !dbg !27
  store i8* %1, i8** %t, align 8, !dbg !26
  %arrayidx4 = getelementptr inbounds [2 x i8*], [2 x i8*]* %str, i64 0, i64 0, !dbg !28
  store i8* null, i8** %arrayidx4, align 16, !dbg !29
  %arrayidx5 = getelementptr inbounds [2 x i8*], [2 x i8*]* %str, i64 0, i64 0, !dbg !30
  %2 = load i8*, i8** %arrayidx5, align 16, !dbg !30
  %arrayidx6 = getelementptr inbounds [2 x i8*], [2 x i8*]* %str, i64 0, i64 1, !dbg !31
  store i8* %2, i8** %arrayidx6, align 8, !dbg !32
  ret i32 0, !dbg !33
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/071-arrays-11")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "str", scope: !7, file: !1, line: 8, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 128, elements: !15)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !{!16}
!16 = !DISubrange(count: 2)
!17 = !DIExpression()
!18 = !DILocation(line: 8, column: 11, scope: !7)
!19 = !DILocation(line: 9, column: 14, scope: !7)
!20 = !DILocation(line: 9, column: 5, scope: !7)
!21 = !DILocation(line: 9, column: 12, scope: !7)
!22 = !DILocation(line: 10, column: 14, scope: !7)
!23 = !DILocation(line: 10, column: 5, scope: !7)
!24 = !DILocation(line: 10, column: 12, scope: !7)
!25 = !DILocalVariable(name: "t", scope: !7, file: !1, line: 12, type: !13)
!26 = !DILocation(line: 12, column: 11, scope: !7)
!27 = !DILocation(line: 12, column: 15, scope: !7)
!28 = !DILocation(line: 14, column: 5, scope: !7)
!29 = !DILocation(line: 14, column: 12, scope: !7)
!30 = !DILocation(line: 15, column: 14, scope: !7)
!31 = !DILocation(line: 15, column: 5, scope: !7)
!32 = !DILocation(line: 15, column: 12, scope: !7)
!33 = !DILocation(line: 17, column: 5, scope: !7)
