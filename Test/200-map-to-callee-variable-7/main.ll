; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { %struct.s2 }
%struct.s2 = type { i32 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %a) #0 !dbg !9 {
entry:
  %a.addr = alloca i32, align 4
  %t1 = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %t1, metadata !16, metadata !14), !dbg !17
  %0 = load i32, i32* %a.addr, align 4, !dbg !18
  store i32 %0, i32* %t1, align 4, !dbg !17
  ret void, !dbg !19
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !20 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 4
  %tainted = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !23, metadata !14), !dbg !30
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !31, metadata !14), !dbg !34
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !35
  store i8* %call, i8** %tainted, align 8, !dbg !34
  %0 = load i8*, i8** %tainted, align 8, !dbg !36
  %cmp = icmp ne i8* %0, null, !dbg !37
  %conv = zext i1 %cmp to i32, !dbg !37
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !38
  %a = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !39
  store i32 %conv, i32* %a, align 4, !dbg !40
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !41
  %a2 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 0, !dbg !42
  %1 = load i32, i32* %a2, align 4, !dbg !42
  call void @foo(i32 %1), !dbg !43
  ret i32 0, !dbg !44
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-variable-7")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 14, type: !10, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "a", arg: 1, scope: !9, file: !1, line: 14, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 14, column: 9, scope: !9)
!16 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 16, type: !12)
!17 = !DILocation(line: 16, column: 9, scope: !9)
!18 = !DILocation(line: 16, column: 14, scope: !9)
!19 = !DILocation(line: 17, column: 1, scope: !9)
!20 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !21, isLocal: false, isDefinition: true, scopeLine: 21, isOptimized: false, unit: !0, variables: !2)
!21 = !DISubroutineType(types: !22)
!22 = !{!12}
!23 = !DILocalVariable(name: "s1", scope: !20, file: !1, line: 22, type: !24)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 9, size: 32, elements: !25)
!25 = !{!26}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !24, file: !1, line: 10, baseType: !27, size: 32)
!27 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 5, size: 32, elements: !28)
!28 = !{!29}
!29 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !27, file: !1, line: 6, baseType: !12, size: 32)
!30 = !DILocation(line: 22, column: 15, scope: !20)
!31 = !DILocalVariable(name: "tainted", scope: !20, file: !1, line: 23, type: !32)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!34 = !DILocation(line: 23, column: 11, scope: !20)
!35 = !DILocation(line: 23, column: 21, scope: !20)
!36 = !DILocation(line: 24, column: 15, scope: !20)
!37 = !DILocation(line: 24, column: 23, scope: !20)
!38 = !DILocation(line: 24, column: 8, scope: !20)
!39 = !DILocation(line: 24, column: 11, scope: !20)
!40 = !DILocation(line: 24, column: 13, scope: !20)
!41 = !DILocation(line: 26, column: 12, scope: !20)
!42 = !DILocation(line: 26, column: 15, scope: !20)
!43 = !DILocation(line: 26, column: 5, scope: !20)
!44 = !DILocation(line: 28, column: 5, scope: !20)
