; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %struct.s2 }
%struct.s2 = type { i32, i8*, %struct.s3 }
%struct.s3 = type { i32, i32, i32, i8* }
%struct.s4 = type { i32, i32, i32, i32, i32, %struct.s5 }
%struct.s5 = type { %struct.s6 }
%struct.s6 = type { %struct.s2 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"untaint\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %s4 = alloca %struct.s4, align 8
  %tainted = alloca i8*, align 8
  %untainted = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !11, metadata !29), !dbg !30
  call void @llvm.dbg.declare(metadata %struct.s4* %s4, metadata !31, metadata !29), !dbg !46
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !47
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !48
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !49
  %t3 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 3, !dbg !50
  store i8* %call, i8** %t3, align 8, !dbg !51
  %s5 = getelementptr inbounds %struct.s4, %struct.s4* %s4, i32 0, i32 5, !dbg !52
  %s6 = getelementptr inbounds %struct.s5, %struct.s5* %s5, i32 0, i32 0, !dbg !53
  %s21 = getelementptr inbounds %struct.s6, %struct.s6* %s6, i32 0, i32 0, !dbg !54
  %0 = bitcast %struct.s2* %s21 to i8*, !dbg !55
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !56
  %1 = bitcast %struct.s2* %s22 to i8*, !dbg !55
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 1024, i32 8, i1 false), !dbg !55
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !57, metadata !29), !dbg !58
  %s53 = getelementptr inbounds %struct.s4, %struct.s4* %s4, i32 0, i32 5, !dbg !59
  %s64 = getelementptr inbounds %struct.s5, %struct.s5* %s53, i32 0, i32 0, !dbg !60
  %s25 = getelementptr inbounds %struct.s6, %struct.s6* %s64, i32 0, i32 0, !dbg !61
  %s36 = getelementptr inbounds %struct.s2, %struct.s2* %s25, i32 0, i32 2, !dbg !62
  %t37 = getelementptr inbounds %struct.s3, %struct.s3* %s36, i32 0, i32 3, !dbg !63
  %2 = load i8*, i8** %t37, align 8, !dbg !63
  store i8* %2, i8** %tainted, align 8, !dbg !58
  %s58 = getelementptr inbounds %struct.s4, %struct.s4* %s4, i32 0, i32 5, !dbg !64
  %s69 = getelementptr inbounds %struct.s5, %struct.s5* %s58, i32 0, i32 0, !dbg !65
  %s210 = getelementptr inbounds %struct.s6, %struct.s6* %s69, i32 0, i32 0, !dbg !66
  %s311 = getelementptr inbounds %struct.s2, %struct.s2* %s210, i32 0, i32 2, !dbg !67
  %t312 = getelementptr inbounds %struct.s3, %struct.s3* %s311, i32 0, i32 3, !dbg !68
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i32 0, i32 0), i8** %t312, align 8, !dbg !69
  call void @llvm.dbg.declare(metadata i8** %untainted, metadata !70, metadata !29), !dbg !71
  %s513 = getelementptr inbounds %struct.s4, %struct.s4* %s4, i32 0, i32 5, !dbg !72
  %s614 = getelementptr inbounds %struct.s5, %struct.s5* %s513, i32 0, i32 0, !dbg !73
  %s215 = getelementptr inbounds %struct.s6, %struct.s6* %s614, i32 0, i32 0, !dbg !74
  %s316 = getelementptr inbounds %struct.s2, %struct.s2* %s215, i32 0, i32 2, !dbg !75
  %t317 = getelementptr inbounds %struct.s3, %struct.s3* %s316, i32 0, i32 3, !dbg !76
  %3 = load i8*, i8** %t317, align 8, !dbg !76
  store i8* %3, i8** %untainted, align 8, !dbg !71
  ret i32 0, !dbg !77
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/121-memcpy-7")
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
!31 = !DILocalVariable(name: "s4", scope: !7, file: !1, line: 47, type: !32)
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s4", file: !1, line: 33, size: 512, elements: !33)
!33 = !{!34, !35, !36, !37, !38, !39}
!34 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !32, file: !1, line: 34, baseType: !10, size: 32)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !32, file: !1, line: 35, baseType: !10, size: 32, offset: 32)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !32, file: !1, line: 36, baseType: !10, size: 32, offset: 64)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "d", scope: !32, file: !1, line: 37, baseType: !10, size: 32, offset: 96)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "e", scope: !32, file: !1, line: 38, baseType: !10, size: 32, offset: 128)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "s5", scope: !32, file: !1, line: 39, baseType: !40, size: 320, offset: 192)
!40 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s5", file: !1, line: 29, size: 320, elements: !41)
!41 = !{!42}
!42 = !DIDerivedType(tag: DW_TAG_member, name: "s6", scope: !40, file: !1, line: 30, baseType: !43, size: 320)
!43 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s6", file: !1, line: 25, size: 320, elements: !44)
!44 = !{!45}
!45 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !43, file: !1, line: 26, baseType: !18, size: 320)
!46 = !DILocation(line: 47, column: 15, scope: !7)
!47 = !DILocation(line: 48, column: 19, scope: !7)
!48 = !DILocation(line: 48, column: 8, scope: !7)
!49 = !DILocation(line: 48, column: 11, scope: !7)
!50 = !DILocation(line: 48, column: 14, scope: !7)
!51 = !DILocation(line: 48, column: 17, scope: !7)
!52 = !DILocation(line: 50, column: 16, scope: !7)
!53 = !DILocation(line: 50, column: 19, scope: !7)
!54 = !DILocation(line: 50, column: 22, scope: !7)
!55 = !DILocation(line: 50, column: 5, scope: !7)
!56 = !DILocation(line: 50, column: 30, scope: !7)
!57 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 52, type: !15)
!58 = !DILocation(line: 52, column: 11, scope: !7)
!59 = !DILocation(line: 52, column: 24, scope: !7)
!60 = !DILocation(line: 52, column: 27, scope: !7)
!61 = !DILocation(line: 52, column: 30, scope: !7)
!62 = !DILocation(line: 52, column: 33, scope: !7)
!63 = !DILocation(line: 52, column: 36, scope: !7)
!64 = !DILocation(line: 54, column: 8, scope: !7)
!65 = !DILocation(line: 54, column: 11, scope: !7)
!66 = !DILocation(line: 54, column: 14, scope: !7)
!67 = !DILocation(line: 54, column: 17, scope: !7)
!68 = !DILocation(line: 54, column: 20, scope: !7)
!69 = !DILocation(line: 54, column: 23, scope: !7)
!70 = !DILocalVariable(name: "untainted", scope: !7, file: !1, line: 56, type: !15)
!71 = !DILocation(line: 56, column: 11, scope: !7)
!72 = !DILocation(line: 56, column: 26, scope: !7)
!73 = !DILocation(line: 56, column: 29, scope: !7)
!74 = !DILocation(line: 56, column: 32, scope: !7)
!75 = !DILocation(line: 56, column: 35, scope: !7)
!76 = !DILocation(line: 56, column: 38, scope: !7)
!77 = !DILocation(line: 58, column: 5, scope: !7)
