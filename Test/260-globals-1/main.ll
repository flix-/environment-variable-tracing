; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = global i32 1, align 4, !dbg !0
@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@gt = common global i8* null, align 8, !dbg !6

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !15 {
entry:
  %retval = alloca i32, align 4
  %t = alloca i8*, align 8
  %nt = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !18
  store i8* %call, i8** @gt, align 8, !dbg !19
  call void @llvm.dbg.declare(metadata i8** %t, metadata !20, metadata !21), !dbg !22
  %0 = load i8*, i8** @gt, align 8, !dbg !23
  store i8* %0, i8** %t, align 8, !dbg !22
  store i8* null, i8** @gt, align 8, !dbg !24
  call void @llvm.dbg.declare(metadata i8** %nt, metadata !25, metadata !21), !dbg !26
  %1 = load i8*, i8** @gt, align 8, !dbg !27
  store i8* %1, i8** %nt, align 8, !dbg !26
  ret i32 0, !dbg !28
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #1

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!11, !12, !13}
!llvm.ident = !{!14}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 6, type: !10, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-1")
!4 = !{}
!5 = !{!0, !6}
!6 = !DIGlobalVariableExpression(var: !7)
!7 = distinct !DIGlobalVariable(name: "gt", scope: !2, file: !3, line: 5, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{i32 2, !"Dwarf Version", i32 4}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{i32 1, !"wchar_size", i32 4}
!14 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!15 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 9, type: !16, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: false, unit: !2, variables: !4)
!16 = !DISubroutineType(types: !17)
!17 = !{!10}
!18 = !DILocation(line: 10, column: 10, scope: !15)
!19 = !DILocation(line: 10, column: 8, scope: !15)
!20 = !DILocalVariable(name: "t", scope: !15, file: !3, line: 12, type: !8)
!21 = !DIExpression()
!22 = !DILocation(line: 12, column: 11, scope: !15)
!23 = !DILocation(line: 12, column: 15, scope: !15)
!24 = !DILocation(line: 14, column: 8, scope: !15)
!25 = !DILocalVariable(name: "nt", scope: !15, file: !3, line: 16, type: !8)
!26 = !DILocation(line: 16, column: 11, scope: !15)
!27 = !DILocation(line: 16, column: 16, scope: !15)
!28 = !DILocation(line: 18, column: 5, scope: !15)
