; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s2 = type { i8*, i32, i32 }
%struct.s1 = type { %struct.s2, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@s2 = common global %struct.s2 zeroinitializer, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !18 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %t1 = alloca i8*, align 8
  %nt1 = alloca i32, align 4
  %nt2 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !21, metadata !26), !dbg !27
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !28
  %s = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !29
  %t = getelementptr inbounds %struct.s2, %struct.s2* %s, i32 0, i32 0, !dbg !30
  store i8* %call, i8** %t, align 8, !dbg !31
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !32
  %0 = bitcast %struct.s2* %s2 to i8*, !dbg !32
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.s2* @s2 to i8*), i8* %0, i64 16, i32 8, i1 false), !dbg !32
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !33, metadata !26), !dbg !34
  %1 = load i8*, i8** getelementptr inbounds (%struct.s2, %struct.s2* @s2, i32 0, i32 0), align 8, !dbg !35
  store i8* %1, i8** %t1, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata i32* %nt1, metadata !36, metadata !26), !dbg !37
  %2 = load i32, i32* getelementptr inbounds (%struct.s2, %struct.s2* @s2, i32 0, i32 1), align 8, !dbg !38
  store i32 %2, i32* %nt1, align 4, !dbg !37
  call void @llvm.dbg.declare(metadata i32* %nt2, metadata !39, metadata !26), !dbg !40
  %3 = load i32, i32* getelementptr inbounds (%struct.s2, %struct.s2* @s2, i32 0, i32 2), align 4, !dbg !41
  store i32 %3, i32* %nt2, align 4, !dbg !40
  ret i32 0, !dbg !42
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!14, !15, !16}
!llvm.ident = !{!17}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "s2", scope: !2, file: !3, line: 16, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-5")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !3, line: 5, size: 128, elements: !7)
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
!21 = !DILocalVariable(name: "s1", scope: !18, file: !3, line: 20, type: !22)
!22 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !3, line: 11, size: 192, elements: !23)
!23 = !{!24, !25}
!24 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !22, file: !3, line: 12, baseType: !6, size: 128)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !22, file: !3, line: 13, baseType: !9, size: 64, offset: 128)
!26 = !DIExpression()
!27 = !DILocation(line: 20, column: 15, scope: !18)
!28 = !DILocation(line: 21, column: 14, scope: !18)
!29 = !DILocation(line: 21, column: 8, scope: !18)
!30 = !DILocation(line: 21, column: 10, scope: !18)
!31 = !DILocation(line: 21, column: 12, scope: !18)
!32 = !DILocation(line: 23, column: 13, scope: !18)
!33 = !DILocalVariable(name: "t1", scope: !18, file: !3, line: 25, type: !9)
!34 = !DILocation(line: 25, column: 11, scope: !18)
!35 = !DILocation(line: 25, column: 19, scope: !18)
!36 = !DILocalVariable(name: "nt1", scope: !18, file: !3, line: 26, type: !12)
!37 = !DILocation(line: 26, column: 9, scope: !18)
!38 = !DILocation(line: 26, column: 18, scope: !18)
!39 = !DILocalVariable(name: "nt2", scope: !18, file: !3, line: 27, type: !12)
!40 = !DILocation(line: 27, column: 9, scope: !18)
!41 = !DILocation(line: 27, column: 18, scope: !18)
!42 = !DILocation(line: 29, column: 5, scope: !18)
