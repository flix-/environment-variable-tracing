; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %tainted) #0 !dbg !7 {
entry:
  %tainted.addr = alloca i32, align 4
  store i32 %tainted, i32* %tainted.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %tainted.addr, metadata !11, metadata !12), !dbg !13
  %0 = load i32, i32* %tainted.addr, align 4, !dbg !14
  ret i32 %0, !dbg !15
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !16 {
entry:
  %retval = alloca i32, align 4
  %tainted = alloca i32, align 4
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %tainted, metadata !19, metadata !12), !dbg !20
  %call = call i32 @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !21
  store i32 %call, i32* %tainted, align 4, !dbg !20
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !22, metadata !12), !dbg !23
  %0 = load i32, i32* %tainted, align 4, !dbg !24
  %call1 = call i32 @foo(i32 %0), !dbg !25
  store i32 %call1, i32* %rc, align 4, !dbg !23
  %1 = load i32, i32* %rc, align 4, !dbg !26
  ret i32 %1, !dbg !27
}

declare i32 @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/210-map-to-caller-variable-1")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 4, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "tainted", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 4, column: 9, scope: !7)
!14 = !DILocation(line: 6, column: 12, scope: !7)
!15 = !DILocation(line: 6, column: 5, scope: !7)
!16 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 10, type: !17, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !0, variables: !2)
!17 = !DISubroutineType(types: !18)
!18 = !{!10}
!19 = !DILocalVariable(name: "tainted", scope: !16, file: !1, line: 12, type: !10)
!20 = !DILocation(line: 12, column: 9, scope: !16)
!21 = !DILocation(line: 12, column: 19, scope: !16)
!22 = !DILocalVariable(name: "rc", scope: !16, file: !1, line: 13, type: !10)
!23 = !DILocation(line: 13, column: 9, scope: !16)
!24 = !DILocation(line: 13, column: 18, scope: !16)
!25 = !DILocation(line: 13, column: 14, scope: !16)
!26 = !DILocation(line: 15, column: 12, scope: !16)
!27 = !DILocation(line: 15, column: 5, scope: !16)
