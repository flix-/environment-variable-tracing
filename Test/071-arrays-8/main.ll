; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s = type { i32, %struct.t }
%struct.t = type { [2 x i8*] }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %str_array = alloca [2 x [2 x %struct.s]], align 16
  %str_array_temp = alloca %struct.s, align 8
  %t1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %nt1 = alloca i8*, align 8
  %str_array_temp2 = alloca %struct.s, align 8
  %nt2 = alloca i8*, align 8
  %nt3 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x [2 x %struct.s]]* %str_array, metadata !13, metadata !28), !dbg !29
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !30
  %cmp = icmp ne i8* %call, null, !dbg !32
  br i1 %cmp, label %if.then, label %if.end, !dbg !33

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata %struct.s* %str_array_temp, metadata !34, metadata !28), !dbg !36
  %arrayidx = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !37
  %arrayidx1 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx, i64 0, i64 0, !dbg !37
  %0 = bitcast %struct.s* %arrayidx1 to i8*, !dbg !38
  %1 = bitcast %struct.s* %str_array_temp to i8*, !dbg !38
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 24, i32 8, i1 false), !dbg !38
  br label %if.end, !dbg !39

if.end:                                           ; preds = %if.then, %entry
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !40, metadata !28), !dbg !41
  %arrayidx2 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !42
  %arrayidx3 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx2, i64 0, i64 0, !dbg !42
  %b = getelementptr inbounds %struct.s, %struct.s* %arrayidx3, i32 0, i32 1, !dbg !43
  %taint = getelementptr inbounds %struct.t, %struct.t* %b, i32 0, i32 0, !dbg !44
  %arrayidx4 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint, i64 0, i64 0, !dbg !42
  %2 = load i8*, i8** %arrayidx4, align 8, !dbg !42
  store i8* %2, i8** %t1, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !45, metadata !28), !dbg !46
  %arrayidx5 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !47
  %arrayidx6 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx5, i64 0, i64 0, !dbg !47
  %b7 = getelementptr inbounds %struct.s, %struct.s* %arrayidx6, i32 0, i32 1, !dbg !48
  %taint8 = getelementptr inbounds %struct.t, %struct.t* %b7, i32 0, i32 0, !dbg !49
  %arrayidx9 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint8, i64 0, i64 1, !dbg !47
  %3 = load i8*, i8** %arrayidx9, align 8, !dbg !47
  store i8* %3, i8** %t2, align 8, !dbg !46
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !50, metadata !28), !dbg !51
  %arrayidx10 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !52
  %arrayidx11 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx10, i64 0, i64 1, !dbg !52
  %b12 = getelementptr inbounds %struct.s, %struct.s* %arrayidx11, i32 0, i32 1, !dbg !53
  %taint13 = getelementptr inbounds %struct.t, %struct.t* %b12, i32 0, i32 0, !dbg !54
  %arrayidx14 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint13, i64 0, i64 0, !dbg !52
  %4 = load i8*, i8** %arrayidx14, align 8, !dbg !52
  store i8* %4, i8** %nt1, align 8, !dbg !51
  call void @llvm.dbg.declare(metadata %struct.s* %str_array_temp2, metadata !55, metadata !28), !dbg !56
  %arrayidx15 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !57
  %arrayidx16 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx15, i64 0, i64 0, !dbg !57
  %5 = bitcast %struct.s* %arrayidx16 to i8*, !dbg !58
  %6 = bitcast %struct.s* %str_array_temp2 to i8*, !dbg !58
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 24, i32 8, i1 false), !dbg !58
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !59, metadata !28), !dbg !60
  %arrayidx17 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !61
  %arrayidx18 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx17, i64 0, i64 0, !dbg !61
  %b19 = getelementptr inbounds %struct.s, %struct.s* %arrayidx18, i32 0, i32 1, !dbg !62
  %taint20 = getelementptr inbounds %struct.t, %struct.t* %b19, i32 0, i32 0, !dbg !63
  %arrayidx21 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint20, i64 0, i64 0, !dbg !61
  %7 = load i8*, i8** %arrayidx21, align 8, !dbg !61
  store i8* %7, i8** %nt2, align 8, !dbg !60
  call void @llvm.dbg.declare(metadata i8** %nt3, metadata !64, metadata !28), !dbg !65
  %arrayidx22 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !66
  %arrayidx23 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx22, i64 0, i64 0, !dbg !66
  %b24 = getelementptr inbounds %struct.s, %struct.s* %arrayidx23, i32 0, i32 1, !dbg !67
  %taint25 = getelementptr inbounds %struct.t, %struct.t* %b24, i32 0, i32 0, !dbg !68
  %arrayidx26 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint25, i64 0, i64 1, !dbg !66
  %8 = load i8*, i8** %arrayidx26, align 8, !dbg !66
  store i8* %8, i8** %nt3, align 8, !dbg !65
  ret i32 0, !dbg !69
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/071-arrays-8")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !10, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "str_array", scope: !9, file: !1, line: 19, type: !14)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 768, elements: !27)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s", file: !1, line: 11, size: 192, elements: !16)
!16 = !{!17, !18}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !15, file: !1, line: 12, baseType: !12, size: 32)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !15, file: !1, line: 13, baseType: !19, size: 128, offset: 64)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "t", file: !1, line: 7, size: 128, elements: !20)
!20 = !{!21}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !19, file: !1, line: 8, baseType: !22, size: 128)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 128, elements: !25)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!24 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!25 = !{!26}
!26 = !DISubrange(count: 2)
!27 = !{!26, !26}
!28 = !DIExpression()
!29 = !DILocation(line: 19, column: 14, scope: !9)
!30 = !DILocation(line: 21, column: 9, scope: !31)
!31 = distinct !DILexicalBlock(scope: !9, file: !1, line: 21, column: 9)
!32 = !DILocation(line: 21, column: 24, scope: !31)
!33 = !DILocation(line: 21, column: 9, scope: !9)
!34 = !DILocalVariable(name: "str_array_temp", scope: !35, file: !1, line: 22, type: !15)
!35 = distinct !DILexicalBlock(scope: !31, file: !1, line: 21, column: 33)
!36 = !DILocation(line: 22, column: 18, scope: !35)
!37 = !DILocation(line: 23, column: 9, scope: !35)
!38 = !DILocation(line: 23, column: 27, scope: !35)
!39 = !DILocation(line: 24, column: 5, scope: !35)
!40 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 26, type: !23)
!41 = !DILocation(line: 26, column: 11, scope: !9)
!42 = !DILocation(line: 26, column: 16, scope: !9)
!43 = !DILocation(line: 26, column: 32, scope: !9)
!44 = !DILocation(line: 26, column: 34, scope: !9)
!45 = !DILocalVariable(name: "t2", scope: !9, file: !1, line: 27, type: !23)
!46 = !DILocation(line: 27, column: 11, scope: !9)
!47 = !DILocation(line: 27, column: 16, scope: !9)
!48 = !DILocation(line: 27, column: 32, scope: !9)
!49 = !DILocation(line: 27, column: 34, scope: !9)
!50 = !DILocalVariable(name: "nt1", scope: !9, file: !1, line: 28, type: !23)
!51 = !DILocation(line: 28, column: 11, scope: !9)
!52 = !DILocation(line: 28, column: 17, scope: !9)
!53 = !DILocation(line: 28, column: 33, scope: !9)
!54 = !DILocation(line: 28, column: 35, scope: !9)
!55 = !DILocalVariable(name: "str_array_temp2", scope: !9, file: !1, line: 30, type: !15)
!56 = !DILocation(line: 30, column: 14, scope: !9)
!57 = !DILocation(line: 31, column: 5, scope: !9)
!58 = !DILocation(line: 31, column: 23, scope: !9)
!59 = !DILocalVariable(name: "nt2", scope: !9, file: !1, line: 33, type: !23)
!60 = !DILocation(line: 33, column: 11, scope: !9)
!61 = !DILocation(line: 33, column: 17, scope: !9)
!62 = !DILocation(line: 33, column: 33, scope: !9)
!63 = !DILocation(line: 33, column: 35, scope: !9)
!64 = !DILocalVariable(name: "nt3", scope: !9, file: !1, line: 34, type: !23)
!65 = !DILocation(line: 34, column: 11, scope: !9)
!66 = !DILocation(line: 34, column: 17, scope: !9)
!67 = !DILocation(line: 34, column: 33, scope: !9)
!68 = !DILocation(line: 34, column: 35, scope: !9)
!69 = !DILocation(line: 36, column: 5, scope: !9)
