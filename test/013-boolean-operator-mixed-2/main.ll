; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %taint = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %taint, metadata !11, metadata !12), !dbg !13
  %call = call i32 @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !14
  %tobool = icmp ne i32 %call, 0, !dbg !14
  br i1 %tobool, label %land.rhs, label %lor.lhs.false, !dbg !15

lor.lhs.false:                                    ; preds = %entry
  %call1 = call i32 (...) @foo(), !dbg !16
  %tobool2 = icmp ne i32 %call1, 0, !dbg !16
  br i1 %tobool2, label %land.end, label %land.rhs, !dbg !17

land.rhs:                                         ; preds = %lor.lhs.false, %entry
  %call3 = call i32 (...) @bar(), !dbg !18
  %tobool4 = icmp ne i32 %call3, 0, !dbg !17
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.lhs.false
  %0 = phi i1 [ false, %lor.lhs.false ], [ %tobool4, %land.rhs ]
  %land.ext = zext i1 %0 to i32, !dbg !17
  store i32 %land.ext, i32* %taint, align 4, !dbg !13
  call void @llvm.dbg.declare(metadata i32* %a, metadata !19, metadata !12), !dbg !20
  %1 = load i32, i32* %taint, align 4, !dbg !21
  store i32 %1, i32* %a, align 4, !dbg !20
  ret i32 0, !dbg !22
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @getenv(i8*) #2

declare i32 @foo(...) #2

declare i32 @bar(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/013-boolean-operator-mixed-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "taint", scope: !7, file: !1, line: 8, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 8, column: 9, scope: !7)
!14 = !DILocation(line: 8, column: 18, scope: !7)
!15 = !DILocation(line: 8, column: 31, scope: !7)
!16 = !DILocation(line: 8, column: 35, scope: !7)
!17 = !DILocation(line: 8, column: 42, scope: !7)
!18 = !DILocation(line: 8, column: 45, scope: !7)
!19 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 9, type: !10)
!20 = !DILocation(line: 9, column: 9, scope: !7)
!21 = !DILocation(line: 9, column: 13, scope: !7)
!22 = !DILocation(line: 11, column: 5, scope: !7)
