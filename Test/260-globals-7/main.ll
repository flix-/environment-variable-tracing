; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.u1 = type { i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@u1 = common global %union.u1 zeroinitializer, align 8, !dbg !0
@.str.1 = private unnamed_addr constant [5 x i8] c"nope\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !16 {
entry:
  %retval = alloca i32, align 4
  %t1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %ut2 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !20
  store i8* %call, i8** getelementptr inbounds (%union.u1, %union.u1* @u1, i32 0, i32 0), align 8, !dbg !21
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !22, metadata !23), !dbg !24
  %0 = load i8*, i8** getelementptr inbounds (%union.u1, %union.u1* @u1, i32 0, i32 0), align 8, !dbg !25
  store i8* %0, i8** %t1, align 8, !dbg !24
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !26, metadata !23), !dbg !27
  %1 = load i8*, i8** getelementptr inbounds (%union.u1, %union.u1* @u1, i32 0, i32 0), align 8, !dbg !28
  store i8* %1, i8** %t2, align 8, !dbg !27
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i8** getelementptr inbounds (%union.u1, %union.u1* @u1, i32 0, i32 0), align 8, !dbg !29
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !30, metadata !23), !dbg !31
  %2 = load i8*, i8** getelementptr inbounds (%union.u1, %union.u1* @u1, i32 0, i32 0), align 8, !dbg !32
  store i8* %2, i8** %ut1, align 8, !dbg !31
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !33, metadata !23), !dbg !34
  %3 = load i8*, i8** getelementptr inbounds (%union.u1, %union.u1* @u1, i32 0, i32 0), align 8, !dbg !35
  store i8* %3, i8** %ut2, align 8, !dbg !34
  ret i32 0, !dbg !36
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
!llvm.module.flags = !{!12, !13, !14}
!llvm.ident = !{!15}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "u1", scope: !2, file: !3, line: 10, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-7")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u1", file: !3, line: 5, size: 64, elements: !7)
!7 = !{!8, !11}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !6, file: !3, line: 6, baseType: !9, size: 64)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "ut", scope: !6, file: !3, line: 7, baseType: !9, size: 64)
!12 = !{i32 2, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!16 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 13, type: !17, isLocal: false, isDefinition: true, scopeLine: 13, isOptimized: false, unit: !2, variables: !4)
!17 = !DISubroutineType(types: !18)
!18 = !{!19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DILocation(line: 14, column: 12, scope: !16)
!21 = !DILocation(line: 14, column: 10, scope: !16)
!22 = !DILocalVariable(name: "t1", scope: !16, file: !3, line: 15, type: !9)
!23 = !DIExpression()
!24 = !DILocation(line: 15, column: 11, scope: !16)
!25 = !DILocation(line: 15, column: 19, scope: !16)
!26 = !DILocalVariable(name: "t2", scope: !16, file: !3, line: 16, type: !9)
!27 = !DILocation(line: 16, column: 11, scope: !16)
!28 = !DILocation(line: 16, column: 19, scope: !16)
!29 = !DILocation(line: 18, column: 11, scope: !16)
!30 = !DILocalVariable(name: "ut1", scope: !16, file: !3, line: 19, type: !9)
!31 = !DILocation(line: 19, column: 11, scope: !16)
!32 = !DILocation(line: 19, column: 20, scope: !16)
!33 = !DILocalVariable(name: "ut2", scope: !16, file: !3, line: 20, type: !9)
!34 = !DILocation(line: 20, column: 11, scope: !16)
!35 = !DILocation(line: 20, column: 20, scope: !16)
!36 = !DILocation(line: 22, column: 5, scope: !16)
