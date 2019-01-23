; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i32, i32, %struct.s2 }
%struct.s2 = type { [2 x i8*] }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %arr_decay = alloca i8**, align 8
  %ut1 = alloca i8*, align 8
  %t1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !11, metadata !25), !dbg !26
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !27
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !28
  %strings = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !29
  %arrayidx = getelementptr inbounds [2 x i8*], [2 x i8*]* %strings, i64 0, i64 1, !dbg !30
  store i8* %call, i8** %arrayidx, align 8, !dbg !31
  call void @llvm.dbg.declare(metadata i8*** %arr_decay, metadata !32, metadata !25), !dbg !34
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !35
  %strings2 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 0, !dbg !36
  %arraydecay = getelementptr inbounds [2 x i8*], [2 x i8*]* %strings2, i32 0, i32 0, !dbg !37
  store i8** %arraydecay, i8*** %arr_decay, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !38, metadata !25), !dbg !39
  %0 = load i8**, i8*** %arr_decay, align 8, !dbg !40
  %arrayidx3 = getelementptr inbounds i8*, i8** %0, i64 0, !dbg !40
  %1 = load i8*, i8** %arrayidx3, align 8, !dbg !40
  store i8* %1, i8** %ut1, align 8, !dbg !39
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !41, metadata !25), !dbg !42
  %2 = load i8**, i8*** %arr_decay, align 8, !dbg !43
  %arrayidx4 = getelementptr inbounds i8*, i8** %2, i64 1, !dbg !43
  %3 = load i8*, i8** %arrayidx4, align 8, !dbg !43
  store i8* %3, i8** %t1, align 8, !dbg !42
  ret i32 0, !dbg !44
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/071-arrays-10")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !8, isLocal: false, isDefinition: true, scopeLine: 17, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 18, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 9, size: 192, elements: !13)
!13 = !{!14, !15, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 10, baseType: !10, size: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !12, file: !1, line: 11, baseType: !10, size: 32, offset: 32)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !12, file: !1, line: 12, baseType: !17, size: 128, offset: 64)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 5, size: 128, elements: !18)
!18 = !{!19}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "strings", scope: !17, file: !1, line: 6, baseType: !20, size: 128)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 128, elements: !23)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!23 = !{!24}
!24 = !DISubrange(count: 2)
!25 = !DIExpression()
!26 = !DILocation(line: 18, column: 15, scope: !7)
!27 = !DILocation(line: 19, column: 24, scope: !7)
!28 = !DILocation(line: 19, column: 8, scope: !7)
!29 = !DILocation(line: 19, column: 11, scope: !7)
!30 = !DILocation(line: 19, column: 5, scope: !7)
!31 = !DILocation(line: 19, column: 22, scope: !7)
!32 = !DILocalVariable(name: "arr_decay", scope: !7, file: !1, line: 21, type: !33)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!34 = !DILocation(line: 21, column: 12, scope: !7)
!35 = !DILocation(line: 21, column: 27, scope: !7)
!36 = !DILocation(line: 21, column: 30, scope: !7)
!37 = !DILocation(line: 21, column: 24, scope: !7)
!38 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 23, type: !21)
!39 = !DILocation(line: 23, column: 11, scope: !7)
!40 = !DILocation(line: 23, column: 17, scope: !7)
!41 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 24, type: !21)
!42 = !DILocation(line: 24, column: 11, scope: !7)
!43 = !DILocation(line: 24, column: 16, scope: !7)
!44 = !DILocation(line: 26, column: 5, scope: !7)
