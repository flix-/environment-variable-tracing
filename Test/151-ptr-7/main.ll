; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %struct.s2 }
%struct.s2 = type { i32, i8*, %struct.s3* }
%struct.s3 = type { i32, i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %s3 = alloca %struct.s3, align 8
  %t1 = alloca i8*, align 8
  %s32 = alloca %struct.s3, align 8
  %ut1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !11, metadata !29), !dbg !30
  call void @llvm.dbg.declare(metadata %struct.s3* %s3, metadata !31, metadata !29), !dbg !32
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !33
  %t3 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 2, !dbg !34
  store i8* %call, i8** %t3, align 8, !dbg !35
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !36
  %s31 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !37
  store %struct.s3* %s3, %struct.s3** %s31, align 8, !dbg !38
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !39, metadata !29), !dbg !40
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !41
  %s33 = getelementptr inbounds %struct.s2, %struct.s2* %s22, i32 0, i32 2, !dbg !42
  %0 = load %struct.s3*, %struct.s3** %s33, align 8, !dbg !42
  %t34 = getelementptr inbounds %struct.s3, %struct.s3* %0, i32 0, i32 2, !dbg !43
  %1 = load i8*, i8** %t34, align 8, !dbg !43
  store i8* %1, i8** %t1, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata %struct.s3* %s32, metadata !44, metadata !29), !dbg !45
  %s25 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !46
  %s36 = getelementptr inbounds %struct.s2, %struct.s2* %s25, i32 0, i32 2, !dbg !47
  store %struct.s3* %s32, %struct.s3** %s36, align 8, !dbg !48
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !49, metadata !29), !dbg !50
  %s27 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !51
  %s38 = getelementptr inbounds %struct.s2, %struct.s2* %s27, i32 0, i32 2, !dbg !52
  %2 = load %struct.s3*, %struct.s3** %s38, align 8, !dbg !52
  %t39 = getelementptr inbounds %struct.s3, %struct.s3* %2, i32 0, i32 2, !dbg !53
  %3 = load i8*, i8** %t39, align 8, !dbg !53
  store i8* %3, i8** %ut1, align 8, !dbg !50
  ret i32 0, !dbg !54
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/151-ptr-7")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 25, type: !8, isLocal: false, isDefinition: true, scopeLine: 26, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 27, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 19, size: 256, elements: !13)
!13 = !{!14, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !12, file: !1, line: 20, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !12, file: !1, line: 21, baseType: !18, size: 192, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 13, size: 192, elements: !19)
!19 = !{!20, !21, !22}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !18, file: !1, line: 14, baseType: !10, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !18, file: !1, line: 15, baseType: !15, size: 64, offset: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !18, file: !1, line: 16, baseType: !23, size: 64, offset: 128)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 7, size: 128, elements: !25)
!25 = !{!26, !27, !28}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !24, file: !1, line: 8, baseType: !10, size: 32)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "i2", scope: !24, file: !1, line: 9, baseType: !10, size: 32, offset: 32)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "t3", scope: !24, file: !1, line: 10, baseType: !15, size: 64, offset: 64)
!29 = !DIExpression()
!30 = !DILocation(line: 27, column: 15, scope: !7)
!31 = !DILocalVariable(name: "s3", scope: !7, file: !1, line: 28, type: !24)
!32 = !DILocation(line: 28, column: 15, scope: !7)
!33 = !DILocation(line: 29, column: 13, scope: !7)
!34 = !DILocation(line: 29, column: 8, scope: !7)
!35 = !DILocation(line: 29, column: 11, scope: !7)
!36 = !DILocation(line: 31, column: 8, scope: !7)
!37 = !DILocation(line: 31, column: 11, scope: !7)
!38 = !DILocation(line: 31, column: 14, scope: !7)
!39 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 32, type: !15)
!40 = !DILocation(line: 32, column: 11, scope: !7)
!41 = !DILocation(line: 32, column: 19, scope: !7)
!42 = !DILocation(line: 32, column: 22, scope: !7)
!43 = !DILocation(line: 32, column: 26, scope: !7)
!44 = !DILocalVariable(name: "s32", scope: !7, file: !1, line: 34, type: !24)
!45 = !DILocation(line: 34, column: 15, scope: !7)
!46 = !DILocation(line: 35, column: 8, scope: !7)
!47 = !DILocation(line: 35, column: 11, scope: !7)
!48 = !DILocation(line: 35, column: 14, scope: !7)
!49 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 36, type: !15)
!50 = !DILocation(line: 36, column: 11, scope: !7)
!51 = !DILocation(line: 36, column: 20, scope: !7)
!52 = !DILocation(line: 36, column: 23, scope: !7)
!53 = !DILocation(line: 36, column: 27, scope: !7)
!54 = !DILocation(line: 38, column: 5, scope: !7)
