; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s2 = type { i8*, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %n, ...) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %ap1 = alloca [1 x %struct.__va_list_tag], align 16
  %ap2 = alloca [1 x %struct.__va_list_tag], align 16
  %s2 = alloca %struct.s2, align 8
  %t1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %s21 = alloca %struct.s2, align 8
  %t12 = alloca i8*, align 8
  %t22 = alloca i8*, align 8
  %ut12 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap1, metadata !14, metadata !12), !dbg !29
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap1, i32 0, i32 0, !dbg !30
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !30
  call void @llvm.va_start(i8* %arraydecay1), !dbg !30
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap2, metadata !31, metadata !12), !dbg !32
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap2, i32 0, i32 0, !dbg !33
  %arraydecay23 = bitcast %struct.__va_list_tag* %arraydecay2 to i8*, !dbg !33
  call void @llvm.va_start(i8* %arraydecay23), !dbg !33
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !34, metadata !12), !dbg !42
  %arraydecay4 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap1, i32 0, i32 0, !dbg !43
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay4, i32 0, i32 2, !dbg !43
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !43
  %0 = bitcast i8* %overflow_arg_area to %struct.s2*, !dbg !43
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 24, !dbg !43
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !43
  %1 = bitcast %struct.s2* %s2 to i8*, !dbg !43
  %2 = bitcast %struct.s2* %0 to i8*, !dbg !43
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %2, i64 24, i32 8, i1 false), !dbg !43
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !44, metadata !12), !dbg !45
  %t15 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !46
  %3 = load i8*, i8** %t15, align 8, !dbg !46
  store i8* %3, i8** %t1, align 8, !dbg !45
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !47, metadata !12), !dbg !48
  %t26 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !49
  %4 = load i8*, i8** %t26, align 8, !dbg !49
  store i8* %4, i8** %t2, align 8, !dbg !48
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !50, metadata !12), !dbg !51
  %ut17 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 2, !dbg !52
  %5 = load i8*, i8** %ut17, align 8, !dbg !52
  store i8* %5, i8** %ut1, align 8, !dbg !51
  %arraydecay8 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap1, i32 0, i32 0, !dbg !53
  %arraydecay89 = bitcast %struct.__va_list_tag* %arraydecay8 to i8*, !dbg !53
  call void @llvm.va_end(i8* %arraydecay89), !dbg !53
  call void @llvm.dbg.declare(metadata %struct.s2* %s21, metadata !54, metadata !12), !dbg !55
  %arraydecay10 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap2, i32 0, i32 0, !dbg !56
  %overflow_arg_area_p11 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay10, i32 0, i32 2, !dbg !56
  %overflow_arg_area12 = load i8*, i8** %overflow_arg_area_p11, align 8, !dbg !56
  %6 = bitcast i8* %overflow_arg_area12 to %struct.s2*, !dbg !56
  %overflow_arg_area.next13 = getelementptr i8, i8* %overflow_arg_area12, i32 24, !dbg !56
  store i8* %overflow_arg_area.next13, i8** %overflow_arg_area_p11, align 8, !dbg !56
  %7 = bitcast %struct.s2* %s21 to i8*, !dbg !56
  %8 = bitcast %struct.s2* %6 to i8*, !dbg !56
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* %8, i64 24, i32 8, i1 false), !dbg !56
  call void @llvm.dbg.declare(metadata i8** %t12, metadata !57, metadata !12), !dbg !58
  %t114 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 0, !dbg !59
  %9 = load i8*, i8** %t114, align 8, !dbg !59
  store i8* %9, i8** %t12, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata i8** %t22, metadata !60, metadata !12), !dbg !61
  %t215 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 1, !dbg !62
  %10 = load i8*, i8** %t215, align 8, !dbg !62
  store i8* %10, i8** %t22, align 8, !dbg !61
  call void @llvm.dbg.declare(metadata i8** %ut12, metadata !63, metadata !12), !dbg !64
  %ut116 = getelementptr inbounds %struct.s2, %struct.s2* %s21, i32 0, i32 2, !dbg !65
  %11 = load i8*, i8** %ut116, align 8, !dbg !65
  store i8* %11, i8** %ut12, align 8, !dbg !64
  %arraydecay17 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap2, i32 0, i32 0, !dbg !66
  %arraydecay1718 = bitcast %struct.__va_list_tag* %arraydecay17 to i8*, !dbg !66
  call void @llvm.va_end(i8* %arraydecay1718), !dbg !66
  ret void, !dbg !67
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !68 {
entry:
  %retval = alloca i32, align 4
  %s2 = alloca %struct.s2, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !71, metadata !12), !dbg !72
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !73
  %t1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !74
  store i8* %call, i8** %t1, align 8, !dbg !75
  %t11 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !76
  %0 = load i8*, i8** %t11, align 8, !dbg !76
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !77
  store i8* %0, i8** %t2, align 8, !dbg !78
  call void (i32, ...) @foo(i32 1, %struct.s2* byval align 8 %s2), !dbg !79
  ret i32 0, !dbg !80
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-9")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 19, type: !8, isLocal: false, isDefinition: true, scopeLine: 20, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, null}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 19, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 19, column: 9, scope: !7)
!14 = !DILocalVariable(name: "ap1", scope: !7, file: !1, line: 21, type: !15)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !16, line: 30, baseType: !17)
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-9")
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 21, baseType: !18)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 192, elements: !27)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 21, size: 192, elements: !20)
!20 = !{!21, !23, !24, !26}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !19, file: !1, line: 21, baseType: !22, size: 32)
!22 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !19, file: !1, line: 21, baseType: !22, size: 32, offset: 32)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !19, file: !1, line: 21, baseType: !25, size: 64, offset: 64)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !19, file: !1, line: 21, baseType: !25, size: 64, offset: 128)
!27 = !{!28}
!28 = !DISubrange(count: 1)
!29 = !DILocation(line: 21, column: 13, scope: !7)
!30 = !DILocation(line: 22, column: 5, scope: !7)
!31 = !DILocalVariable(name: "ap2", scope: !7, file: !1, line: 23, type: !15)
!32 = !DILocation(line: 23, column: 13, scope: !7)
!33 = !DILocation(line: 24, column: 5, scope: !7)
!34 = !DILocalVariable(name: "s2", scope: !7, file: !1, line: 26, type: !35)
!35 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 6, size: 192, elements: !36)
!36 = !{!37, !40, !41}
!37 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !35, file: !1, line: 7, baseType: !38, size: 64)
!38 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !39, size: 64)
!39 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !35, file: !1, line: 8, baseType: !38, size: 64, offset: 64)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "ut1", scope: !35, file: !1, line: 9, baseType: !38, size: 64, offset: 128)
!42 = !DILocation(line: 26, column: 15, scope: !7)
!43 = !DILocation(line: 26, column: 20, scope: !7)
!44 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 28, type: !38)
!45 = !DILocation(line: 28, column: 11, scope: !7)
!46 = !DILocation(line: 28, column: 19, scope: !7)
!47 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 29, type: !38)
!48 = !DILocation(line: 29, column: 11, scope: !7)
!49 = !DILocation(line: 29, column: 19, scope: !7)
!50 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 30, type: !38)
!51 = !DILocation(line: 30, column: 11, scope: !7)
!52 = !DILocation(line: 30, column: 20, scope: !7)
!53 = !DILocation(line: 32, column: 5, scope: !7)
!54 = !DILocalVariable(name: "s21", scope: !7, file: !1, line: 34, type: !35)
!55 = !DILocation(line: 34, column: 15, scope: !7)
!56 = !DILocation(line: 34, column: 21, scope: !7)
!57 = !DILocalVariable(name: "t12", scope: !7, file: !1, line: 36, type: !38)
!58 = !DILocation(line: 36, column: 11, scope: !7)
!59 = !DILocation(line: 36, column: 21, scope: !7)
!60 = !DILocalVariable(name: "t22", scope: !7, file: !1, line: 37, type: !38)
!61 = !DILocation(line: 37, column: 11, scope: !7)
!62 = !DILocation(line: 37, column: 21, scope: !7)
!63 = !DILocalVariable(name: "ut12", scope: !7, file: !1, line: 38, type: !38)
!64 = !DILocation(line: 38, column: 11, scope: !7)
!65 = !DILocation(line: 38, column: 22, scope: !7)
!66 = !DILocation(line: 40, column: 5, scope: !7)
!67 = !DILocation(line: 41, column: 1, scope: !7)
!68 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 44, type: !69, isLocal: false, isDefinition: true, scopeLine: 45, isOptimized: false, unit: !0, variables: !2)
!69 = !DISubroutineType(types: !70)
!70 = !{!10}
!71 = !DILocalVariable(name: "s2", scope: !68, file: !1, line: 46, type: !35)
!72 = !DILocation(line: 46, column: 15, scope: !68)
!73 = !DILocation(line: 47, column: 13, scope: !68)
!74 = !DILocation(line: 47, column: 8, scope: !68)
!75 = !DILocation(line: 47, column: 11, scope: !68)
!76 = !DILocation(line: 48, column: 16, scope: !68)
!77 = !DILocation(line: 48, column: 8, scope: !68)
!78 = !DILocation(line: 48, column: 11, scope: !68)
!79 = !DILocation(line: 50, column: 5, scope: !68)
!80 = !DILocation(line: 52, column: 5, scope: !68)
