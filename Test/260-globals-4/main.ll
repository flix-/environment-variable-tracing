; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { %struct.s2, i8* }
%struct.s2 = type { i8*, i32, i32 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@s1 = common global %struct.s1 zeroinitializer, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !22 {
entry:
  %retval = alloca i32, align 4
  %s2 = alloca %struct.s2, align 8
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !25
  store i8* %call, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 0, i32 0), align 8, !dbg !26
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !27, metadata !28), !dbg !29
  %0 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 0, i32 0), align 8, !dbg !30
  %t = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !31
  store i8* %0, i8** %t, align 8, !dbg !32
  %1 = load i32, i32* getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 0, i32 1), align 8, !dbg !33
  %a = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !34
  store i32 %1, i32* %a, align 8, !dbg !35
  %2 = load i32, i32* getelementptr inbounds (%struct.s1, %struct.s1* @s1, i32 0, i32 0, i32 2), align 4, !dbg !36
  %b = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !37
  store i32 %2, i32* %b, align 4, !dbg !38
  ret i32 0, !dbg !39
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
!llvm.module.flags = !{!18, !19, !20}
!llvm.ident = !{!21}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "s1", scope: !2, file: !3, line: 16, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-4")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !3, line: 11, size: 192, elements: !7)
!7 = !{!8, !17}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !6, file: !3, line: 12, baseType: !9, size: 128)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !3, line: 5, size: 128, elements: !10)
!10 = !{!11, !14, !16}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !9, file: !3, line: 6, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !9, file: !3, line: 7, baseType: !15, size: 32, offset: 64)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !9, file: !3, line: 8, baseType: !15, size: 32, offset: 96)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !6, file: !3, line: 13, baseType: !12, size: 64, offset: 128)
!18 = !{i32 2, !"Dwarf Version", i32 4}
!19 = !{i32 2, !"Debug Info Version", i32 3}
!20 = !{i32 1, !"wchar_size", i32 4}
!21 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!22 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 19, type: !23, isLocal: false, isDefinition: true, scopeLine: 19, isOptimized: false, unit: !2, variables: !4)
!23 = !DISubroutineType(types: !24)
!24 = !{!15}
!25 = !DILocation(line: 20, column: 14, scope: !22)
!26 = !DILocation(line: 20, column: 12, scope: !22)
!27 = !DILocalVariable(name: "s2", scope: !22, file: !3, line: 22, type: !9)
!28 = !DIExpression()
!29 = !DILocation(line: 22, column: 15, scope: !22)
!30 = !DILocation(line: 23, column: 17, scope: !22)
!31 = !DILocation(line: 23, column: 8, scope: !22)
!32 = !DILocation(line: 23, column: 10, scope: !22)
!33 = !DILocation(line: 24, column: 17, scope: !22)
!34 = !DILocation(line: 24, column: 8, scope: !22)
!35 = !DILocation(line: 24, column: 10, scope: !22)
!36 = !DILocation(line: 25, column: 17, scope: !22)
!37 = !DILocation(line: 25, column: 8, scope: !22)
!38 = !DILocation(line: 25, column: 10, scope: !22)
!39 = !DILocation(line: 27, column: 5, scope: !22)
