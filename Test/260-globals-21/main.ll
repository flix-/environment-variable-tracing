; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@gt = common global i8* null, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !14 {
entry:
  %retval = alloca i32, align 4
  %t = alloca i32, align 4
  %t2 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !18
  store i8* %call, i8** @gt, align 8, !dbg !19
  call void @llvm.dbg.declare(metadata i32* %t, metadata !20, metadata !21), !dbg !22
  %0 = load i8*, i8** @gt, align 8, !dbg !23
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
  store i32 %xor, i32* %t, align 4, !dbg !22
  call void @llvm.dbg.declare(metadata i32* %t2, metadata !29, metadata !21), !dbg !30
  %2 = load i32, i32* %t, align 4, !dbg !31
  store i32 %2, i32* %t2, align 4, !dbg !30
  ret i32 0, !dbg !32
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #1

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

declare i32 @foo(...) #3

declare i32 @bar(...) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!10, !11, !12}
!llvm.ident = !{!13}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "gt", scope: !2, file: !3, line: 7, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !7)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-21")
!4 = !{}
!5 = !{!6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !{!0}
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!10 = !{i32 2, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{i32 1, !"wchar_size", i32 4}
!13 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!14 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 10, type: !15, isLocal: false, isDefinition: true, scopeLine: 10, isOptimized: false, unit: !2, variables: !4)
!15 = !DISubroutineType(types: !16)
!16 = !{!17}
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !DILocation(line: 11, column: 10, scope: !14)
!19 = !DILocation(line: 11, column: 8, scope: !14)
!20 = !DILocalVariable(name: "t", scope: !14, file: !3, line: 13, type: !17)
!21 = !DIExpression()
!22 = !DILocation(line: 13, column: 9, scope: !14)
!23 = !DILocation(line: 13, column: 14, scope: !14)
!24 = !DILocation(line: 13, column: 17, scope: !14)
!25 = !DILocation(line: 13, column: 25, scope: !14)
!26 = !DILocation(line: 13, column: 28, scope: !14)
!27 = !DILocation(line: 13, column: 37, scope: !14)
!28 = !DILocation(line: 13, column: 35, scope: !14)
!29 = !DILocalVariable(name: "t2", scope: !14, file: !3, line: 15, type: !17)
!30 = !DILocation(line: 15, column: 9, scope: !14)
!31 = !DILocation(line: 15, column: 14, scope: !14)
!32 = !DILocation(line: 17, column: 5, scope: !14)
