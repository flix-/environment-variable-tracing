; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, %struct.s2 }
%struct.s2 = type { i8*, i32 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %rc = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %s28 = alloca %struct.s2, align 8
  %s2nt = alloca %struct.s2, align 8
  %nt1 = alloca i32, align 4
  %nt2 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !16, metadata !14), !dbg !27
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !28
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !29
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !30
  store i8* %call, i8** %t2, align 8, !dbg !31
  call void @llvm.dbg.declare(metadata i32* %i, metadata !32, metadata !14), !dbg !34
  store i32 0, i32* %i, align 4, !dbg !34
  br label %for.cond, !dbg !35

for.cond:                                         ; preds = %for.inc16, %entry
  %0 = load i32, i32* %i, align 4, !dbg !36
  %cmp = icmp slt i32 %0, 10, !dbg !38
  br i1 %cmp, label %for.body, label %for.end18, !dbg !39

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !40, metadata !14), !dbg !43
  store i32 0, i32* %j, align 4, !dbg !43
  br label %for.cond1, !dbg !44

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !45
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !47
  %t23 = getelementptr inbounds %struct.s2, %struct.s2* %s22, i32 0, i32 0, !dbg !48
  %2 = load i8*, i8** %t23, align 8, !dbg !48
  %cmp4 = icmp ne i8* %2, null, !dbg !49
  %conv = zext i1 %cmp4 to i32, !dbg !49
  %cmp5 = icmp slt i32 %1, %conv, !dbg !50
  br i1 %cmp5, label %for.body7, label %for.end, !dbg !51

for.body7:                                        ; preds = %for.cond1
  call void @llvm.dbg.declare(metadata %struct.s2* %s28, metadata !52, metadata !14), !dbg !54
  %s29 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !55
  %3 = bitcast %struct.s2* %s29 to i8*, !dbg !56
  %4 = bitcast %struct.s2* %s28 to i8*, !dbg !56
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %4, i64 16, i32 8, i1 false), !dbg !56
  br label %for.inc, !dbg !57

for.inc:                                          ; preds = %for.body7
  %5 = load i32, i32* %j, align 4, !dbg !58
  %inc = add nsw i32 %5, 1, !dbg !58
  store i32 %inc, i32* %j, align 4, !dbg !58
  br label %for.cond1, !dbg !59, !llvm.loop !60

for.end:                                          ; preds = %for.cond1
  %s210 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !62
  %a = getelementptr inbounds %struct.s2, %struct.s2* %s210, i32 0, i32 1, !dbg !63
  %6 = load i32, i32* %a, align 8, !dbg !63
  store i32 %6, i32* %rc, align 4, !dbg !64
  call void @llvm.dbg.declare(metadata %struct.s2* %s2nt, metadata !65, metadata !14), !dbg !66
  %s211 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !67
  %7 = bitcast %struct.s2* %s211 to i8*, !dbg !68
  %8 = bitcast %struct.s2* %s2nt to i8*, !dbg !68
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* %8, i64 16, i32 8, i1 false), !dbg !68
  call void @llvm.dbg.declare(metadata i32* %nt1, metadata !69, metadata !14), !dbg !70
  %s212 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !71
  %a13 = getelementptr inbounds %struct.s2, %struct.s2* %s212, i32 0, i32 1, !dbg !72
  %9 = load i32, i32* %a13, align 8, !dbg !72
  store i32 %9, i32* %nt1, align 4, !dbg !70
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !73, metadata !14), !dbg !74
  %s214 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !75
  %t215 = getelementptr inbounds %struct.s2, %struct.s2* %s214, i32 0, i32 0, !dbg !76
  %10 = load i8*, i8** %t215, align 8, !dbg !76
  store i8* %10, i8** %nt2, align 8, !dbg !74
  br label %for.inc16, !dbg !77

for.inc16:                                        ; preds = %for.end
  %11 = load i32, i32* %i, align 4, !dbg !78
  %inc17 = add nsw i32 %11, 1, !dbg !78
  store i32 %inc17, i32* %i, align 4, !dbg !78
  br label %for.cond, !dbg !79, !llvm.loop !80

for.end18:                                        ; preds = %for.cond
  %12 = load i32, i32* %rc, align 4, !dbg !82
  ret i32 %12, !dbg !83
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

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/041-for-loop-6")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 18, type: !10, isLocal: false, isDefinition: true, scopeLine: 19, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "rc", scope: !9, file: !1, line: 20, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 20, column: 9, scope: !9)
!16 = !DILocalVariable(name: "s1", scope: !9, file: !1, line: 21, type: !17)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 12, size: 192, elements: !18)
!18 = !{!19, !22}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !17, file: !1, line: 13, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !17, file: !1, line: 14, baseType: !23, size: 128, offset: 64)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 7, size: 128, elements: !24)
!24 = !{!25, !26}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !23, file: !1, line: 8, baseType: !20, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !23, file: !1, line: 9, baseType: !12, size: 32, offset: 64)
!27 = !DILocation(line: 21, column: 15, scope: !9)
!28 = !DILocation(line: 22, column: 16, scope: !9)
!29 = !DILocation(line: 22, column: 8, scope: !9)
!30 = !DILocation(line: 22, column: 11, scope: !9)
!31 = !DILocation(line: 22, column: 14, scope: !9)
!32 = !DILocalVariable(name: "i", scope: !33, file: !1, line: 24, type: !12)
!33 = distinct !DILexicalBlock(scope: !9, file: !1, line: 24, column: 5)
!34 = !DILocation(line: 24, column: 14, scope: !33)
!35 = !DILocation(line: 24, column: 10, scope: !33)
!36 = !DILocation(line: 24, column: 21, scope: !37)
!37 = distinct !DILexicalBlock(scope: !33, file: !1, line: 24, column: 5)
!38 = !DILocation(line: 24, column: 23, scope: !37)
!39 = !DILocation(line: 24, column: 5, scope: !33)
!40 = !DILocalVariable(name: "j", scope: !41, file: !1, line: 25, type: !12)
!41 = distinct !DILexicalBlock(scope: !42, file: !1, line: 25, column: 9)
!42 = distinct !DILexicalBlock(scope: !37, file: !1, line: 24, column: 34)
!43 = !DILocation(line: 25, column: 18, scope: !41)
!44 = !DILocation(line: 25, column: 14, scope: !41)
!45 = !DILocation(line: 25, column: 25, scope: !46)
!46 = distinct !DILexicalBlock(scope: !41, file: !1, line: 25, column: 9)
!47 = !DILocation(line: 25, column: 33, scope: !46)
!48 = !DILocation(line: 25, column: 36, scope: !46)
!49 = !DILocation(line: 25, column: 39, scope: !46)
!50 = !DILocation(line: 25, column: 27, scope: !46)
!51 = !DILocation(line: 25, column: 9, scope: !41)
!52 = !DILocalVariable(name: "s2", scope: !53, file: !1, line: 26, type: !23)
!53 = distinct !DILexicalBlock(scope: !46, file: !1, line: 25, column: 54)
!54 = !DILocation(line: 26, column: 23, scope: !53)
!55 = !DILocation(line: 27, column: 16, scope: !53)
!56 = !DILocation(line: 27, column: 21, scope: !53)
!57 = !DILocation(line: 28, column: 9, scope: !53)
!58 = !DILocation(line: 25, column: 50, scope: !46)
!59 = !DILocation(line: 25, column: 9, scope: !46)
!60 = distinct !{!60, !51, !61}
!61 = !DILocation(line: 28, column: 9, scope: !41)
!62 = !DILocation(line: 29, column: 17, scope: !42)
!63 = !DILocation(line: 29, column: 20, scope: !42)
!64 = !DILocation(line: 29, column: 12, scope: !42)
!65 = !DILocalVariable(name: "s2nt", scope: !42, file: !1, line: 31, type: !23)
!66 = !DILocation(line: 31, column: 19, scope: !42)
!67 = !DILocation(line: 32, column: 12, scope: !42)
!68 = !DILocation(line: 32, column: 17, scope: !42)
!69 = !DILocalVariable(name: "nt1", scope: !42, file: !1, line: 34, type: !12)
!70 = !DILocation(line: 34, column: 13, scope: !42)
!71 = !DILocation(line: 34, column: 22, scope: !42)
!72 = !DILocation(line: 34, column: 25, scope: !42)
!73 = !DILocalVariable(name: "nt2", scope: !42, file: !1, line: 35, type: !20)
!74 = !DILocation(line: 35, column: 15, scope: !42)
!75 = !DILocation(line: 35, column: 24, scope: !42)
!76 = !DILocation(line: 35, column: 27, scope: !42)
!77 = !DILocation(line: 36, column: 5, scope: !42)
!78 = !DILocation(line: 24, column: 30, scope: !37)
!79 = !DILocation(line: 24, column: 5, scope: !37)
!80 = distinct !{!80, !39, !81}
!81 = !DILocation(line: 36, column: 5, scope: !33)
!82 = !DILocation(line: 38, column: 12, scope: !9)
!83 = !DILocation(line: 38, column: 5, scope: !9)
