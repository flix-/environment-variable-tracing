; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, i32, i32 }
%struct.s2 = type { %struct.s1, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@s = common global %struct.s1 zeroinitializer, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !18 {
entry:
  %retval = alloca i32, align 4
  %s2 = alloca %struct.s2, align 8
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !21
  store i8* %call, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s, i32 0, i32 0), align 8, !dbg !22
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !23, metadata !28), !dbg !29
  %0 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s, i32 0, i32 0), align 8, !dbg !30
  %s = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !31
  %t = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !32
  store i8* %0, i8** %t, align 8, !dbg !33
  %1 = load i32, i32* getelementptr inbounds (%struct.s1, %struct.s1* @s, i32 0, i32 1), align 8, !dbg !34
  %s1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !35
  %a = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !36
  store i32 %1, i32* %a, align 8, !dbg !37
  %2 = load i32, i32* getelementptr inbounds (%struct.s1, %struct.s1* @s, i32 0, i32 2), align 4, !dbg !38
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !39
  %b = getelementptr inbounds %struct.s1, %struct.s1* %s3, i32 0, i32 2, !dbg !40
  store i32 %2, i32* %b, align 4, !dbg !41
  ret i32 0, !dbg !42
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
!llvm.module.flags = !{!14, !15, !16}
!llvm.ident = !{!17}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "s", scope: !2, file: !3, line: 16, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-3")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !3, line: 5, size: 128, elements: !7)
!7 = !{!8, !11, !13}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !6, file: !3, line: 6, baseType: !9, size: 64)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !6, file: !3, line: 7, baseType: !12, size: 32, offset: 64)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !6, file: !3, line: 8, baseType: !12, size: 32, offset: 96)
!14 = !{i32 2, !"Dwarf Version", i32 4}
!15 = !{i32 2, !"Debug Info Version", i32 3}
!16 = !{i32 1, !"wchar_size", i32 4}
!17 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!18 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 19, type: !19, isLocal: false, isDefinition: true, scopeLine: 19, isOptimized: false, unit: !2, variables: !4)
!19 = !DISubroutineType(types: !20)
!20 = !{!12}
!21 = !DILocation(line: 20, column: 11, scope: !18)
!22 = !DILocation(line: 20, column: 9, scope: !18)
!23 = !DILocalVariable(name: "s2", scope: !18, file: !3, line: 22, type: !24)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !3, line: 11, size: 192, elements: !25)
!25 = !{!26, !27}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !24, file: !3, line: 12, baseType: !6, size: 128)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !24, file: !3, line: 13, baseType: !9, size: 64, offset: 128)
!28 = !DIExpression()
!29 = !DILocation(line: 22, column: 15, scope: !18)
!30 = !DILocation(line: 23, column: 16, scope: !18)
!31 = !DILocation(line: 23, column: 8, scope: !18)
!32 = !DILocation(line: 23, column: 10, scope: !18)
!33 = !DILocation(line: 23, column: 12, scope: !18)
!34 = !DILocation(line: 24, column: 16, scope: !18)
!35 = !DILocation(line: 24, column: 8, scope: !18)
!36 = !DILocation(line: 24, column: 10, scope: !18)
!37 = !DILocation(line: 24, column: 12, scope: !18)
!38 = !DILocation(line: 25, column: 16, scope: !18)
!39 = !DILocation(line: 25, column: 8, scope: !18)
!40 = !DILocation(line: 25, column: 10, scope: !18)
!41 = !DILocation(line: 25, column: 12, scope: !18)
!42 = !DILocation(line: 27, column: 5, scope: !18)
