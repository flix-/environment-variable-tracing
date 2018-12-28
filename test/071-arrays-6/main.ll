; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s = type { i32, %struct.t }
%struct.t = type { [2 x i8*] }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"untaint\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %str_array = alloca [2 x [2 x %struct.s]], align 16
  %tainted1 = alloca i8*, align 8
  %tainted2 = alloca i8*, align 8
  %not_tainted = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x [2 x %struct.s]]* %str_array, metadata !11, metadata !26), !dbg !27
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !28
  %arrayidx = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !29
  %arrayidx1 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx, i64 0, i64 0, !dbg !29
  %b = getelementptr inbounds %struct.s, %struct.s* %arrayidx1, i32 0, i32 1, !dbg !30
  %taint = getelementptr inbounds %struct.t, %struct.t* %b, i32 0, i32 0, !dbg !31
  %arrayidx2 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint, i64 0, i64 0, !dbg !29
  store i8* %call, i8** %arrayidx2, align 8, !dbg !32
  %arrayidx3 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !33
  %arrayidx4 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx3, i64 0, i64 0, !dbg !33
  %b5 = getelementptr inbounds %struct.s, %struct.s* %arrayidx4, i32 0, i32 1, !dbg !34
  %taint6 = getelementptr inbounds %struct.t, %struct.t* %b5, i32 0, i32 0, !dbg !35
  %arrayidx7 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint6, i64 0, i64 0, !dbg !33
  %0 = load i8*, i8** %arrayidx7, align 8, !dbg !33
  %arrayidx8 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !36
  %arrayidx9 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx8, i64 0, i64 1, !dbg !36
  %b10 = getelementptr inbounds %struct.s, %struct.s* %arrayidx9, i32 0, i32 1, !dbg !37
  %taint11 = getelementptr inbounds %struct.t, %struct.t* %b10, i32 0, i32 0, !dbg !38
  %arrayidx12 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint11, i64 0, i64 1, !dbg !36
  store i8* %0, i8** %arrayidx12, align 8, !dbg !39
  call void @llvm.dbg.declare(metadata i8** %tainted1, metadata !40, metadata !26), !dbg !41
  %arrayidx13 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !42
  %arrayidx14 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx13, i64 0, i64 0, !dbg !42
  %b15 = getelementptr inbounds %struct.s, %struct.s* %arrayidx14, i32 0, i32 1, !dbg !43
  %taint16 = getelementptr inbounds %struct.t, %struct.t* %b15, i32 0, i32 0, !dbg !44
  %arrayidx17 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint16, i64 0, i64 0, !dbg !42
  %1 = load i8*, i8** %arrayidx17, align 8, !dbg !42
  store i8* %1, i8** %tainted1, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata i8** %tainted2, metadata !45, metadata !26), !dbg !46
  %arrayidx18 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !47
  %arrayidx19 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx18, i64 0, i64 1, !dbg !47
  %b20 = getelementptr inbounds %struct.s, %struct.s* %arrayidx19, i32 0, i32 1, !dbg !48
  %taint21 = getelementptr inbounds %struct.t, %struct.t* %b20, i32 0, i32 0, !dbg !49
  %arrayidx22 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint21, i64 0, i64 1, !dbg !47
  %2 = load i8*, i8** %arrayidx22, align 8, !dbg !47
  store i8* %2, i8** %tainted2, align 8, !dbg !46
  %arrayidx23 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !50
  %arrayidx24 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx23, i64 0, i64 0, !dbg !50
  %b25 = getelementptr inbounds %struct.s, %struct.s* %arrayidx24, i32 0, i32 1, !dbg !51
  %taint26 = getelementptr inbounds %struct.t, %struct.t* %b25, i32 0, i32 0, !dbg !52
  %arrayidx27 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint26, i64 0, i64 0, !dbg !50
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i32 0, i32 0), i8** %arrayidx27, align 8, !dbg !53
  %arrayidx28 = getelementptr inbounds [2 x [2 x %struct.s]], [2 x [2 x %struct.s]]* %str_array, i64 0, i64 0, !dbg !54
  %arrayidx29 = getelementptr inbounds [2 x %struct.s], [2 x %struct.s]* %arrayidx28, i64 0, i64 0, !dbg !54
  %b30 = getelementptr inbounds %struct.s, %struct.s* %arrayidx29, i32 0, i32 1, !dbg !55
  %taint31 = getelementptr inbounds %struct.t, %struct.t* %b30, i32 0, i32 0, !dbg !56
  %arrayidx32 = getelementptr inbounds [2 x i8*], [2 x i8*]* %taint31, i64 0, i64 0, !dbg !54
  %3 = load i8*, i8** %arrayidx32, align 8, !dbg !54
  store i8* %3, i8** %tainted1, align 8, !dbg !57
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !58, metadata !26), !dbg !59
  %4 = load i8*, i8** %tainted1, align 8, !dbg !60
  store i8* %4, i8** %not_tainted, align 8, !dbg !59
  ret i32 0, !dbg !61
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/test/071-arrays-6")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 15, type: !8, isLocal: false, isDefinition: true, scopeLine: 16, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "str_array", scope: !7, file: !1, line: 17, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 768, elements: !25)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s", file: !1, line: 9, size: 192, elements: !14)
!14 = !{!15, !16}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !13, file: !1, line: 10, baseType: !10, size: 32)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !13, file: !1, line: 11, baseType: !17, size: 128, offset: 64)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "t", file: !1, line: 5, size: 128, elements: !18)
!18 = !{!19}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "taint", scope: !17, file: !1, line: 6, baseType: !20, size: 128)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 128, elements: !23)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!23 = !{!24}
!24 = !DISubrange(count: 2)
!25 = !{!24, !24}
!26 = !DIExpression()
!27 = !DILocation(line: 17, column: 14, scope: !7)
!28 = !DILocation(line: 18, column: 34, scope: !7)
!29 = !DILocation(line: 18, column: 5, scope: !7)
!30 = !DILocation(line: 18, column: 21, scope: !7)
!31 = !DILocation(line: 18, column: 23, scope: !7)
!32 = !DILocation(line: 18, column: 32, scope: !7)
!33 = !DILocation(line: 19, column: 34, scope: !7)
!34 = !DILocation(line: 19, column: 50, scope: !7)
!35 = !DILocation(line: 19, column: 52, scope: !7)
!36 = !DILocation(line: 19, column: 5, scope: !7)
!37 = !DILocation(line: 19, column: 21, scope: !7)
!38 = !DILocation(line: 19, column: 23, scope: !7)
!39 = !DILocation(line: 19, column: 32, scope: !7)
!40 = !DILocalVariable(name: "tainted1", scope: !7, file: !1, line: 21, type: !21)
!41 = !DILocation(line: 21, column: 11, scope: !7)
!42 = !DILocation(line: 21, column: 22, scope: !7)
!43 = !DILocation(line: 21, column: 38, scope: !7)
!44 = !DILocation(line: 21, column: 40, scope: !7)
!45 = !DILocalVariable(name: "tainted2", scope: !7, file: !1, line: 22, type: !21)
!46 = !DILocation(line: 22, column: 11, scope: !7)
!47 = !DILocation(line: 22, column: 22, scope: !7)
!48 = !DILocation(line: 22, column: 38, scope: !7)
!49 = !DILocation(line: 22, column: 40, scope: !7)
!50 = !DILocation(line: 24, column: 5, scope: !7)
!51 = !DILocation(line: 24, column: 21, scope: !7)
!52 = !DILocation(line: 24, column: 23, scope: !7)
!53 = !DILocation(line: 24, column: 32, scope: !7)
!54 = !DILocation(line: 26, column: 16, scope: !7)
!55 = !DILocation(line: 26, column: 32, scope: !7)
!56 = !DILocation(line: 26, column: 34, scope: !7)
!57 = !DILocation(line: 26, column: 14, scope: !7)
!58 = !DILocalVariable(name: "not_tainted", scope: !7, file: !1, line: 28, type: !21)
!59 = !DILocation(line: 28, column: 11, scope: !7)
!60 = !DILocation(line: 28, column: 25, scope: !7)
!61 = !DILocation(line: 30, column: 5, scope: !7)
