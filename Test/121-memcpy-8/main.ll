; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %struct.s2 }
%struct.s2 = type { i32, i8*, %struct.s3 }
%struct.s3 = type { i32, i32, i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %t1 = alloca i8*, align 8
  %t26 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %t316 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !11, metadata !29), !dbg !30
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !31
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !32
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !33
  %t3 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 3, !dbg !34
  store i8* %call, i8** %t3, align 8, !dbg !35
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !36
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !37
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s22, i32 0, i32 1, !dbg !38
  store i8* %call1, i8** %t2, align 8, !dbg !39
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !40, metadata !29), !dbg !41
  %s23 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !42
  %s34 = getelementptr inbounds %struct.s2, %struct.s2* %s23, i32 0, i32 2, !dbg !43
  %t35 = getelementptr inbounds %struct.s3, %struct.s3* %s34, i32 0, i32 3, !dbg !44
  %0 = load i8*, i8** %t35, align 8, !dbg !44
  store i8* %0, i8** %t1, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata i8** %t26, metadata !45, metadata !29), !dbg !46
  %s27 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !47
  %t28 = getelementptr inbounds %struct.s2, %struct.s2* %s27, i32 0, i32 1, !dbg !48
  %1 = load i8*, i8** %t28, align 8, !dbg !48
  store i8* %1, i8** %t26, align 8, !dbg !46
  %s29 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !49
  %s310 = getelementptr inbounds %struct.s2, %struct.s2* %s29, i32 0, i32 2, !dbg !50
  %t311 = getelementptr inbounds %struct.s3, %struct.s3* %s310, i32 0, i32 3, !dbg !51
  %2 = bitcast i8** %t311 to i8*, !dbg !52
  %t112 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !53
  %3 = bitcast i8** %t112 to i8*, !dbg !52
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 1024, i32 8, i1 false), !dbg !52
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !54, metadata !29), !dbg !55
  %s213 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !56
  %s314 = getelementptr inbounds %struct.s2, %struct.s2* %s213, i32 0, i32 2, !dbg !57
  %t315 = getelementptr inbounds %struct.s3, %struct.s3* %s314, i32 0, i32 3, !dbg !58
  %4 = load i8*, i8** %t315, align 8, !dbg !58
  store i8* %4, i8** %ut1, align 8, !dbg !55
  call void @llvm.dbg.declare(metadata i8** %t316, metadata !59, metadata !29), !dbg !60
  %s217 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !61
  %t218 = getelementptr inbounds %struct.s2, %struct.s2* %s217, i32 0, i32 1, !dbg !62
  %5 = load i8*, i8** %t218, align 8, !dbg !62
  store i8* %5, i8** %t316, align 8, !dbg !60
  ret i32 0, !dbg !63
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/121-memcpy-8")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 44, type: !8, isLocal: false, isDefinition: true, scopeLine: 45, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 46, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 20, size: 384, elements: !13)
!13 = !{!14, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !12, file: !1, line: 21, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !12, file: !1, line: 22, baseType: !18, size: 320, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 14, size: 320, elements: !19)
!19 = !{!20, !21, !22}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !18, file: !1, line: 15, baseType: !10, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !18, file: !1, line: 16, baseType: !15, size: 64, offset: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !18, file: !1, line: 17, baseType: !23, size: 192, offset: 128)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 7, size: 192, elements: !24)
!24 = !{!25, !26, !27, !28}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !23, file: !1, line: 8, baseType: !10, size: 32)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "i2", scope: !23, file: !1, line: 9, baseType: !10, size: 32, offset: 32)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "i3", scope: !23, file: !1, line: 10, baseType: !10, size: 32, offset: 64)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "t3", scope: !23, file: !1, line: 11, baseType: !15, size: 64, offset: 128)
!29 = !DIExpression()
!30 = !DILocation(line: 46, column: 15, scope: !7)
!31 = !DILocation(line: 47, column: 19, scope: !7)
!32 = !DILocation(line: 47, column: 8, scope: !7)
!33 = !DILocation(line: 47, column: 11, scope: !7)
!34 = !DILocation(line: 47, column: 14, scope: !7)
!35 = !DILocation(line: 47, column: 17, scope: !7)
!36 = !DILocation(line: 48, column: 16, scope: !7)
!37 = !DILocation(line: 48, column: 8, scope: !7)
!38 = !DILocation(line: 48, column: 11, scope: !7)
!39 = !DILocation(line: 48, column: 14, scope: !7)
!40 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 50, type: !15)
!41 = !DILocation(line: 50, column: 11, scope: !7)
!42 = !DILocation(line: 50, column: 19, scope: !7)
!43 = !DILocation(line: 50, column: 22, scope: !7)
!44 = !DILocation(line: 50, column: 25, scope: !7)
!45 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 51, type: !15)
!46 = !DILocation(line: 51, column: 11, scope: !7)
!47 = !DILocation(line: 51, column: 19, scope: !7)
!48 = !DILocation(line: 51, column: 22, scope: !7)
!49 = !DILocation(line: 53, column: 16, scope: !7)
!50 = !DILocation(line: 53, column: 19, scope: !7)
!51 = !DILocation(line: 53, column: 22, scope: !7)
!52 = !DILocation(line: 53, column: 5, scope: !7)
!53 = !DILocation(line: 53, column: 30, scope: !7)
!54 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 55, type: !15)
!55 = !DILocation(line: 55, column: 11, scope: !7)
!56 = !DILocation(line: 55, column: 20, scope: !7)
!57 = !DILocation(line: 55, column: 23, scope: !7)
!58 = !DILocation(line: 55, column: 26, scope: !7)
!59 = !DILocalVariable(name: "t3", scope: !7, file: !1, line: 56, type: !15)
!60 = !DILocation(line: 56, column: 11, scope: !7)
!61 = !DILocation(line: 56, column: 19, scope: !7)
!62 = !DILocation(line: 56, column: 22, scope: !7)
!63 = !DILocation(line: 58, column: 5, scope: !7)
