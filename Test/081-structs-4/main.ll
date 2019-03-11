; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.a = type { i8*, %struct.b }
%struct.b = type { [2 x %struct.c] }
%struct.c = type { [2 x i8*] }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"untaint\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %foo = alloca %struct.a, align 8
  %a5 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.a* %foo, metadata !11, metadata !28), !dbg !29
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !30
  %a = getelementptr inbounds %struct.a, %struct.a* %foo, i32 0, i32 0, !dbg !31
  store i8* %call, i8** %a, align 8, !dbg !32
  %a1 = getelementptr inbounds %struct.a, %struct.a* %foo, i32 0, i32 0, !dbg !33
  %0 = load i8*, i8** %a1, align 8, !dbg !33
  %b = getelementptr inbounds %struct.a, %struct.a* %foo, i32 0, i32 1, !dbg !34
  %a2 = getelementptr inbounds %struct.b, %struct.b* %b, i32 0, i32 0, !dbg !35
  %arrayidx = getelementptr inbounds [2 x %struct.c], [2 x %struct.c]* %a2, i64 0, i64 0, !dbg !36
  %a3 = getelementptr inbounds %struct.c, %struct.c* %arrayidx, i32 0, i32 0, !dbg !37
  %arrayidx4 = getelementptr inbounds [2 x i8*], [2 x i8*]* %a3, i64 0, i64 0, !dbg !36
  store i8* %0, i8** %arrayidx4, align 8, !dbg !38
  call void @llvm.dbg.declare(metadata i8** %a5, metadata !39, metadata !28), !dbg !40
  %b6 = getelementptr inbounds %struct.a, %struct.a* %foo, i32 0, i32 1, !dbg !41
  %a7 = getelementptr inbounds %struct.b, %struct.b* %b6, i32 0, i32 0, !dbg !42
  %arrayidx8 = getelementptr inbounds [2 x %struct.c], [2 x %struct.c]* %a7, i64 0, i64 0, !dbg !43
  %a9 = getelementptr inbounds %struct.c, %struct.c* %arrayidx8, i32 0, i32 0, !dbg !44
  %arrayidx10 = getelementptr inbounds [2 x i8*], [2 x i8*]* %a9, i64 0, i64 0, !dbg !43
  %1 = load i8*, i8** %arrayidx10, align 8, !dbg !43
  store i8* %1, i8** %a5, align 8, !dbg !40
  %b11 = getelementptr inbounds %struct.a, %struct.a* %foo, i32 0, i32 1, !dbg !45
  %a12 = getelementptr inbounds %struct.b, %struct.b* %b11, i32 0, i32 0, !dbg !46
  %arrayidx13 = getelementptr inbounds [2 x %struct.c], [2 x %struct.c]* %a12, i64 0, i64 0, !dbg !47
  %a14 = getelementptr inbounds %struct.c, %struct.c* %arrayidx13, i32 0, i32 0, !dbg !48
  %arrayidx15 = getelementptr inbounds [2 x i8*], [2 x i8*]* %a14, i64 0, i64 0, !dbg !47
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i32 0, i32 0), i8** %arrayidx15, align 8, !dbg !49
  %b16 = getelementptr inbounds %struct.a, %struct.a* %foo, i32 0, i32 1, !dbg !50
  %a17 = getelementptr inbounds %struct.b, %struct.b* %b16, i32 0, i32 0, !dbg !51
  %arrayidx18 = getelementptr inbounds [2 x %struct.c], [2 x %struct.c]* %a17, i64 0, i64 0, !dbg !52
  %a19 = getelementptr inbounds %struct.c, %struct.c* %arrayidx18, i32 0, i32 0, !dbg !53
  %arrayidx20 = getelementptr inbounds [2 x i8*], [2 x i8*]* %a19, i64 0, i64 0, !dbg !52
  %2 = load i8*, i8** %arrayidx20, align 8, !dbg !52
  store i8* %2, i8** %a5, align 8, !dbg !54
  ret i32 0, !dbg !55
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/081-structs-4")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 19, type: !8, isLocal: false, isDefinition: true, scopeLine: 20, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "foo", scope: !7, file: !1, line: 21, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "a", file: !1, line: 13, size: 320, elements: !13)
!13 = !{!14, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 14, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !12, file: !1, line: 15, baseType: !18, size: 256, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "b", file: !1, line: 9, size: 256, elements: !19)
!19 = !{!20}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !18, file: !1, line: 10, baseType: !21, size: 256)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 256, elements: !26)
!22 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "c", file: !1, line: 5, size: 128, elements: !23)
!23 = !{!24}
!24 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !22, file: !1, line: 6, baseType: !25, size: 128)
!25 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 128, elements: !26)
!26 = !{!27}
!27 = !DISubrange(count: 2)
!28 = !DIExpression()
!29 = !DILocation(line: 21, column: 14, scope: !7)
!30 = !DILocation(line: 22, column: 13, scope: !7)
!31 = !DILocation(line: 22, column: 9, scope: !7)
!32 = !DILocation(line: 22, column: 11, scope: !7)
!33 = !DILocation(line: 23, column: 27, scope: !7)
!34 = !DILocation(line: 23, column: 9, scope: !7)
!35 = !DILocation(line: 23, column: 11, scope: !7)
!36 = !DILocation(line: 23, column: 5, scope: !7)
!37 = !DILocation(line: 23, column: 16, scope: !7)
!38 = !DILocation(line: 23, column: 21, scope: !7)
!39 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 25, type: !15)
!40 = !DILocation(line: 25, column: 11, scope: !7)
!41 = !DILocation(line: 25, column: 19, scope: !7)
!42 = !DILocation(line: 25, column: 21, scope: !7)
!43 = !DILocation(line: 25, column: 15, scope: !7)
!44 = !DILocation(line: 25, column: 26, scope: !7)
!45 = !DILocation(line: 27, column: 9, scope: !7)
!46 = !DILocation(line: 27, column: 11, scope: !7)
!47 = !DILocation(line: 27, column: 5, scope: !7)
!48 = !DILocation(line: 27, column: 16, scope: !7)
!49 = !DILocation(line: 27, column: 21, scope: !7)
!50 = !DILocation(line: 29, column: 13, scope: !7)
!51 = !DILocation(line: 29, column: 15, scope: !7)
!52 = !DILocation(line: 29, column: 9, scope: !7)
!53 = !DILocation(line: 29, column: 20, scope: !7)
!54 = !DILocation(line: 29, column: 7, scope: !7)
!55 = !DILocation(line: 31, column: 5, scope: !7)
