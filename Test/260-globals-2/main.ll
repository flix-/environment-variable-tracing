; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, i32, i32 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@s = common global %struct.s1 zeroinitializer, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !18 {
entry:
  %retval = alloca i32, align 4
  %t = alloca i8*, align 8
  %nt1 = alloca i32, align 4
  %nt2 = alloca i32, align 4
  %nt3 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !21
  store i8* %call, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s, i32 0, i32 0), align 8, !dbg !22
  call void @llvm.dbg.declare(metadata i8** %t, metadata !23, metadata !24), !dbg !25
  %0 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s, i32 0, i32 0), align 8, !dbg !26
  store i8* %0, i8** %t, align 8, !dbg !25
  call void @llvm.dbg.declare(metadata i32* %nt1, metadata !27, metadata !24), !dbg !28
  %1 = load i32, i32* getelementptr inbounds (%struct.s1, %struct.s1* @s, i32 0, i32 1), align 8, !dbg !29
  store i32 %1, i32* %nt1, align 4, !dbg !28
  call void @llvm.dbg.declare(metadata i32* %nt2, metadata !30, metadata !24), !dbg !31
  %2 = load i32, i32* getelementptr inbounds (%struct.s1, %struct.s1* @s, i32 0, i32 2), align 4, !dbg !32
  store i32 %2, i32* %nt2, align 4, !dbg !31
  store i8* null, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s, i32 0, i32 0), align 8, !dbg !33
  call void @llvm.dbg.declare(metadata i8** %nt3, metadata !34, metadata !24), !dbg !35
  %3 = load i8*, i8** getelementptr inbounds (%struct.s1, %struct.s1* @s, i32 0, i32 0), align 8, !dbg !36
  store i8* %3, i8** %nt3, align 8, !dbg !35
  ret i32 0, !dbg !37
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
!1 = distinct !DIGlobalVariable(name: "s", scope: !2, file: !3, line: 11, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-2")
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
!18 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 14, type: !19, isLocal: false, isDefinition: true, scopeLine: 14, isOptimized: false, unit: !2, variables: !4)
!19 = !DISubroutineType(types: !20)
!20 = !{!12}
!21 = !DILocation(line: 15, column: 11, scope: !18)
!22 = !DILocation(line: 15, column: 9, scope: !18)
!23 = !DILocalVariable(name: "t", scope: !18, file: !3, line: 17, type: !9)
!24 = !DIExpression()
!25 = !DILocation(line: 17, column: 11, scope: !18)
!26 = !DILocation(line: 17, column: 17, scope: !18)
!27 = !DILocalVariable(name: "nt1", scope: !18, file: !3, line: 18, type: !12)
!28 = !DILocation(line: 18, column: 9, scope: !18)
!29 = !DILocation(line: 18, column: 17, scope: !18)
!30 = !DILocalVariable(name: "nt2", scope: !18, file: !3, line: 19, type: !12)
!31 = !DILocation(line: 19, column: 9, scope: !18)
!32 = !DILocation(line: 19, column: 17, scope: !18)
!33 = !DILocation(line: 21, column: 9, scope: !18)
!34 = !DILocalVariable(name: "nt3", scope: !18, file: !3, line: 23, type: !9)
!35 = !DILocation(line: 23, column: 11, scope: !18)
!36 = !DILocation(line: 23, column: 19, scope: !18)
!37 = !DILocation(line: 25, column: 5, scope: !18)
