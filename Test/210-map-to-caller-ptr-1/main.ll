; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i8* @foo(i8* %s) #0 !dbg !7 {
entry:
  %s.addr = alloca i8*, align 8
  store i8* %s, i8** %s.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %s.addr, metadata !12, metadata !13), !dbg !14
  %0 = load i8*, i8** %s.addr, align 8, !dbg !15
  ret i8* %0, !dbg !16
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !17 {
entry:
  %retval = alloca i32, align 4
  %s = alloca i8*, align 8
  %t = alloca i8*, align 8
  %t1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %s, metadata !21, metadata !13), !dbg !22
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !23
  store i8* %call, i8** %s, align 8, !dbg !22
  call void @llvm.dbg.declare(metadata i8** %t, metadata !24, metadata !13), !dbg !25
  %0 = load i8*, i8** %s, align 8, !dbg !26
  %call1 = call i8* @foo(i8* %0), !dbg !27
  store i8* %call1, i8** %t, align 8, !dbg !25
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !28, metadata !13), !dbg !29
  %1 = load i8*, i8** %t, align 8, !dbg !30
  store i8* %1, i8** %t1, align 8, !dbg !29
  ret i32 0, !dbg !31
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/210-map-to-caller-ptr-1")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 4, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !DILocalVariable(name: "s", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!13 = !DIExpression()
!14 = !DILocation(line: 4, column: 11, scope: !7)
!15 = !DILocation(line: 6, column: 12, scope: !7)
!16 = !DILocation(line: 6, column: 5, scope: !7)
!17 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 10, type: !18, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !0, variables: !2)
!18 = !DISubroutineType(types: !19)
!19 = !{!20}
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DILocalVariable(name: "s", scope: !17, file: !1, line: 12, type: !10)
!22 = !DILocation(line: 12, column: 11, scope: !17)
!23 = !DILocation(line: 12, column: 15, scope: !17)
!24 = !DILocalVariable(name: "t", scope: !17, file: !1, line: 13, type: !10)
!25 = !DILocation(line: 13, column: 11, scope: !17)
!26 = !DILocation(line: 13, column: 19, scope: !17)
!27 = !DILocation(line: 13, column: 15, scope: !17)
!28 = !DILocalVariable(name: "t1", scope: !17, file: !1, line: 15, type: !10)
!29 = !DILocation(line: 15, column: 11, scope: !17)
!30 = !DILocation(line: 15, column: 16, scope: !17)
!31 = !DILocation(line: 17, column: 5, scope: !17)
