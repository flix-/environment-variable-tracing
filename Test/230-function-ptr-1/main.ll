; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { double, %struct.s2 }
%struct.s2 = type { i32, i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i8* @foo(%struct.s1* byval align 8 %s1) #0 !dbg !7 {
entry:
  %tainted = alloca i8*, align 8
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !23, metadata !24), !dbg !25
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !26, metadata !24), !dbg !27
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !28
  %t1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !29
  %0 = load i8*, i8** %t1, align 8, !dbg !29
  store i8* %0, i8** %tainted, align 8, !dbg !27
  %1 = load i8*, i8** %tainted, align 8, !dbg !30
  ret i8* %1, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !32 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %foo_ptr = alloca i8* (%struct.s1*)*, align 8
  %ret = alloca i8*, align 8
  %t12 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !35, metadata !24), !dbg !36
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !37
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !38
  %t1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !39
  store i8* %call, i8** %t1, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata i8* (%struct.s1*)** %foo_ptr, metadata !41, metadata !24), !dbg !43
  store i8* (%struct.s1*)* @foo, i8* (%struct.s1*)** %foo_ptr, align 8, !dbg !43
  call void @llvm.dbg.declare(metadata i8** %ret, metadata !44, metadata !24), !dbg !45
  %0 = load i8* (%struct.s1*)*, i8* (%struct.s1*)** %foo_ptr, align 8, !dbg !46
  %call1 = call i8* %0(%struct.s1* byval align 8 %s1), !dbg !46
  store i8* %call1, i8** %ret, align 8, !dbg !45
  call void @llvm.dbg.declare(metadata i8** %t12, metadata !47, metadata !24), !dbg !48
  %1 = load i8*, i8** %ret, align 8, !dbg !49
  store i8* %1, i8** %t12, align 8, !dbg !48
  ret i32 0, !dbg !50
}

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/230-function-ptr-1")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 15, type: !8, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !12}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 9, size: 192, elements: !13)
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 10, baseType: !15, size: 64)
!15 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !12, file: !1, line: 11, baseType: !17, size: 128, offset: 64)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 3, size: 128, elements: !18)
!18 = !{!19, !21, !22}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !17, file: !1, line: 4, baseType: !20, size: 32)
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !17, file: !1, line: 5, baseType: !20, size: 32, offset: 32)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !17, file: !1, line: 6, baseType: !10, size: 64, offset: 64)
!23 = !DILocalVariable(name: "s1", arg: 1, scope: !7, file: !1, line: 15, type: !12)
!24 = !DIExpression()
!25 = !DILocation(line: 15, column: 15, scope: !7)
!26 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 16, type: !10)
!27 = !DILocation(line: 16, column: 11, scope: !7)
!28 = !DILocation(line: 16, column: 24, scope: !7)
!29 = !DILocation(line: 16, column: 27, scope: !7)
!30 = !DILocation(line: 18, column: 12, scope: !7)
!31 = !DILocation(line: 18, column: 5, scope: !7)
!32 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 22, type: !33, isLocal: false, isDefinition: true, scopeLine: 22, isOptimized: false, unit: !0, variables: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!20}
!35 = !DILocalVariable(name: "s1", scope: !32, file: !1, line: 23, type: !12)
!36 = !DILocation(line: 23, column: 15, scope: !32)
!37 = !DILocation(line: 24, column: 16, scope: !32)
!38 = !DILocation(line: 24, column: 8, scope: !32)
!39 = !DILocation(line: 24, column: 11, scope: !32)
!40 = !DILocation(line: 24, column: 14, scope: !32)
!41 = !DILocalVariable(name: "foo_ptr", scope: !32, file: !1, line: 26, type: !42)
!42 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!43 = !DILocation(line: 26, column: 14, scope: !32)
!44 = !DILocalVariable(name: "ret", scope: !32, file: !1, line: 28, type: !10)
!45 = !DILocation(line: 28, column: 11, scope: !32)
!46 = !DILocation(line: 28, column: 17, scope: !32)
!47 = !DILocalVariable(name: "t1", scope: !32, file: !1, line: 30, type: !10)
!48 = !DILocation(line: 30, column: 11, scope: !32)
!49 = !DILocation(line: 30, column: 16, scope: !32)
!50 = !DILocation(line: 32, column: 5, scope: !32)
