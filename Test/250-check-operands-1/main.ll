; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1*, align 8
  %t1 = alloca i32, align 4
  %t2 = alloca i32, align 4
  %ut1 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1** %s1, metadata !11, metadata !19), !dbg !20
  %call = call noalias i8* @malloc(i64 16) #3, !dbg !21
  %0 = bitcast i8* %call to %struct.s1*, !dbg !21
  store %struct.s1* %0, %struct.s1** %s1, align 8, !dbg !20
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !22
  %1 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !23
  %tainted = getelementptr inbounds %struct.s1, %struct.s1* %1, i32 0, i32 0, !dbg !24
  store i8* %call1, i8** %tainted, align 8, !dbg !25
  call void @llvm.dbg.declare(metadata i32* %t1, metadata !26, metadata !19), !dbg !27
  %2 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !28
  %3 = ptrtoint %struct.s1* %2 to i32, !dbg !29
  %add = add nsw i32 %3, 1, !dbg !30
  store i32 %add, i32* %t1, align 4, !dbg !27
  call void @llvm.dbg.declare(metadata i32* %t2, metadata !31, metadata !19), !dbg !32
  %4 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !33
  %tainted2 = getelementptr inbounds %struct.s1, %struct.s1* %4, i32 0, i32 0, !dbg !34
  %5 = load i8*, i8** %tainted2, align 8, !dbg !34
  %6 = ptrtoint i8* %5 to i32, !dbg !35
  %add3 = add nsw i32 %6, 1, !dbg !36
  store i32 %add3, i32* %t2, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !37, metadata !19), !dbg !38
  %7 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !39
  %not_tainted = getelementptr inbounds %struct.s1, %struct.s1* %7, i32 0, i32 1, !dbg !40
  %8 = load i8*, i8** %not_tainted, align 8, !dbg !40
  %9 = ptrtoint i8* %8 to i32, !dbg !41
  %add4 = add nsw i32 %9, 1, !dbg !42
  store i32 %add4, i32* %ut1, align 4, !dbg !38
  ret i32 -1, !dbg !43
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/250-check-operands-1")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !10, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !3)
!11 = !DILocalVariable(name: "s1", scope: !9, file: !1, line: 12, type: !12)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 5, size: 128, elements: !14)
!14 = !{!15, !18}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "tainted", scope: !13, file: !1, line: 6, baseType: !16, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "not_tainted", scope: !13, file: !1, line: 7, baseType: !16, size: 64, offset: 64)
!19 = !DIExpression()
!20 = !DILocation(line: 12, column: 16, scope: !9)
!21 = !DILocation(line: 12, column: 21, scope: !9)
!22 = !DILocation(line: 13, column: 19, scope: !9)
!23 = !DILocation(line: 13, column: 5, scope: !9)
!24 = !DILocation(line: 13, column: 9, scope: !9)
!25 = !DILocation(line: 13, column: 17, scope: !9)
!26 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 15, type: !4)
!27 = !DILocation(line: 15, column: 9, scope: !9)
!28 = !DILocation(line: 15, column: 19, scope: !9)
!29 = !DILocation(line: 15, column: 14, scope: !9)
!30 = !DILocation(line: 15, column: 22, scope: !9)
!31 = !DILocalVariable(name: "t2", scope: !9, file: !1, line: 16, type: !4)
!32 = !DILocation(line: 16, column: 9, scope: !9)
!33 = !DILocation(line: 16, column: 19, scope: !9)
!34 = !DILocation(line: 16, column: 23, scope: !9)
!35 = !DILocation(line: 16, column: 14, scope: !9)
!36 = !DILocation(line: 16, column: 31, scope: !9)
!37 = !DILocalVariable(name: "ut1", scope: !9, file: !1, line: 17, type: !4)
!38 = !DILocation(line: 17, column: 9, scope: !9)
!39 = !DILocation(line: 17, column: 20, scope: !9)
!40 = !DILocation(line: 17, column: 24, scope: !9)
!41 = !DILocation(line: 17, column: 15, scope: !9)
!42 = !DILocation(line: 17, column: 36, scope: !9)
!43 = !DILocation(line: 19, column: 5, scope: !9)
