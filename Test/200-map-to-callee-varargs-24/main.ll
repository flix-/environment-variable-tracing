; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s1 = type { i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %n, ...) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %args1 = alloca [1 x %struct.__va_list_tag], align 16
  %args2 = alloca [1 x %struct.__va_list_tag], align 16
  %s1 = alloca %struct.s1, align 8
  %nt = alloca i8*, align 8
  %s11 = alloca %struct.s1, align 8
  %t1 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %args1, metadata !14, metadata !12), !dbg !29
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !30
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !30
  call void @llvm.va_start(i8* %arraydecay1), !dbg !30
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %args2, metadata !31, metadata !12), !dbg !32
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !33
  %arraydecay23 = bitcast %struct.__va_list_tag* %arraydecay2 to i8*, !dbg !33
  call void @llvm.va_start(i8* %arraydecay23), !dbg !33
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !34, metadata !12), !dbg !41
  %arraydecay4 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !42
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay4, i32 0, i32 0, !dbg !42
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !42
  %fits_in_gp = icmp ule i32 %gp_offset, 32, !dbg !42
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !42

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay4, i32 0, i32 3, !dbg !42
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !42
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !42
  %2 = bitcast i8* %1 to %struct.s1*, !dbg !42
  %3 = add i32 %gp_offset, 16, !dbg !42
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !42
  br label %vaarg.end, !dbg !42

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay4, i32 0, i32 2, !dbg !42
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !42
  %4 = bitcast i8* %overflow_arg_area to %struct.s1*, !dbg !42
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 16, !dbg !42
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !42
  br label %vaarg.end, !dbg !42

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi %struct.s1* [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !42
  %5 = bitcast %struct.s1* %s1 to i8*, !dbg !42
  %6 = bitcast %struct.s1* %vaarg.addr to i8*, !dbg !42
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 16, i32 8, i1 false), !dbg !42
  %arraydecay5 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !43
  %arraydecay56 = bitcast %struct.__va_list_tag* %arraydecay5 to i8*, !dbg !43
  call void @llvm.va_end(i8* %arraydecay56), !dbg !43
  call void @llvm.dbg.declare(metadata i8** %nt, metadata !44, metadata !12), !dbg !45
  %arraydecay7 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !46
  %gp_offset_p8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay7, i32 0, i32 0, !dbg !46
  %gp_offset9 = load i32, i32* %gp_offset_p8, align 16, !dbg !46
  %fits_in_gp10 = icmp ule i32 %gp_offset9, 40, !dbg !46
  br i1 %fits_in_gp10, label %vaarg.in_reg11, label %vaarg.in_mem13, !dbg !46

vaarg.in_reg11:                                   ; preds = %vaarg.end
  %7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay7, i32 0, i32 3, !dbg !46
  %reg_save_area12 = load i8*, i8** %7, align 16, !dbg !46
  %8 = getelementptr i8, i8* %reg_save_area12, i32 %gp_offset9, !dbg !46
  %9 = bitcast i8* %8 to i8**, !dbg !46
  %10 = add i32 %gp_offset9, 8, !dbg !46
  store i32 %10, i32* %gp_offset_p8, align 16, !dbg !46
  br label %vaarg.end17, !dbg !46

vaarg.in_mem13:                                   ; preds = %vaarg.end
  %overflow_arg_area_p14 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay7, i32 0, i32 2, !dbg !46
  %overflow_arg_area15 = load i8*, i8** %overflow_arg_area_p14, align 8, !dbg !46
  %11 = bitcast i8* %overflow_arg_area15 to i8**, !dbg !46
  %overflow_arg_area.next16 = getelementptr i8, i8* %overflow_arg_area15, i32 8, !dbg !46
  store i8* %overflow_arg_area.next16, i8** %overflow_arg_area_p14, align 8, !dbg !46
  br label %vaarg.end17, !dbg !46

vaarg.end17:                                      ; preds = %vaarg.in_mem13, %vaarg.in_reg11
  %vaarg.addr18 = phi i8** [ %9, %vaarg.in_reg11 ], [ %11, %vaarg.in_mem13 ], !dbg !46
  %12 = load i8*, i8** %vaarg.addr18, align 8, !dbg !46
  store i8* %12, i8** %nt, align 8, !dbg !45
  call void @llvm.dbg.declare(metadata %struct.s1* %s11, metadata !47, metadata !12), !dbg !48
  %arraydecay19 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !49
  %gp_offset_p20 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 0, !dbg !49
  %gp_offset21 = load i32, i32* %gp_offset_p20, align 16, !dbg !49
  %fits_in_gp22 = icmp ule i32 %gp_offset21, 32, !dbg !49
  br i1 %fits_in_gp22, label %vaarg.in_reg23, label %vaarg.in_mem25, !dbg !49

vaarg.in_reg23:                                   ; preds = %vaarg.end17
  %13 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 3, !dbg !49
  %reg_save_area24 = load i8*, i8** %13, align 16, !dbg !49
  %14 = getelementptr i8, i8* %reg_save_area24, i32 %gp_offset21, !dbg !49
  %15 = bitcast i8* %14 to %struct.s1*, !dbg !49
  %16 = add i32 %gp_offset21, 16, !dbg !49
  store i32 %16, i32* %gp_offset_p20, align 16, !dbg !49
  br label %vaarg.end29, !dbg !49

vaarg.in_mem25:                                   ; preds = %vaarg.end17
  %overflow_arg_area_p26 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 2, !dbg !49
  %overflow_arg_area27 = load i8*, i8** %overflow_arg_area_p26, align 8, !dbg !49
  %17 = bitcast i8* %overflow_arg_area27 to %struct.s1*, !dbg !49
  %overflow_arg_area.next28 = getelementptr i8, i8* %overflow_arg_area27, i32 16, !dbg !49
  store i8* %overflow_arg_area.next28, i8** %overflow_arg_area_p26, align 8, !dbg !49
  br label %vaarg.end29, !dbg !49

vaarg.end29:                                      ; preds = %vaarg.in_mem25, %vaarg.in_reg23
  %vaarg.addr30 = phi %struct.s1* [ %15, %vaarg.in_reg23 ], [ %17, %vaarg.in_mem25 ], !dbg !49
  %18 = bitcast %struct.s1* %s11 to i8*, !dbg !49
  %19 = bitcast %struct.s1* %vaarg.addr30 to i8*, !dbg !49
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 16, i32 8, i1 false), !dbg !49
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !50, metadata !12), !dbg !51
  %arraydecay31 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !52
  %gp_offset_p32 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay31, i32 0, i32 0, !dbg !52
  %gp_offset33 = load i32, i32* %gp_offset_p32, align 16, !dbg !52
  %fits_in_gp34 = icmp ule i32 %gp_offset33, 40, !dbg !52
  br i1 %fits_in_gp34, label %vaarg.in_reg35, label %vaarg.in_mem37, !dbg !52

vaarg.in_reg35:                                   ; preds = %vaarg.end29
  %20 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay31, i32 0, i32 3, !dbg !52
  %reg_save_area36 = load i8*, i8** %20, align 16, !dbg !52
  %21 = getelementptr i8, i8* %reg_save_area36, i32 %gp_offset33, !dbg !52
  %22 = bitcast i8* %21 to i8**, !dbg !52
  %23 = add i32 %gp_offset33, 8, !dbg !52
  store i32 %23, i32* %gp_offset_p32, align 16, !dbg !52
  br label %vaarg.end41, !dbg !52

vaarg.in_mem37:                                   ; preds = %vaarg.end29
  %overflow_arg_area_p38 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay31, i32 0, i32 2, !dbg !52
  %overflow_arg_area39 = load i8*, i8** %overflow_arg_area_p38, align 8, !dbg !52
  %24 = bitcast i8* %overflow_arg_area39 to i8**, !dbg !52
  %overflow_arg_area.next40 = getelementptr i8, i8* %overflow_arg_area39, i32 8, !dbg !52
  store i8* %overflow_arg_area.next40, i8** %overflow_arg_area_p38, align 8, !dbg !52
  br label %vaarg.end41, !dbg !52

vaarg.end41:                                      ; preds = %vaarg.in_mem37, %vaarg.in_reg35
  %vaarg.addr42 = phi i8** [ %22, %vaarg.in_reg35 ], [ %24, %vaarg.in_mem37 ], !dbg !52
  %25 = load i8*, i8** %vaarg.addr42, align 8, !dbg !52
  store i8* %25, i8** %t1, align 8, !dbg !51
  %arraydecay43 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !53
  %arraydecay4344 = bitcast %struct.__va_list_tag* %arraydecay43 to i8*, !dbg !53
  call void @llvm.va_end(i8* %arraydecay4344), !dbg !53
  ret i32 0, !dbg !54
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
define i32 @main() #0 !dbg !55 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !58, metadata !12), !dbg !59
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !60
  %t = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !61
  store i8* %call, i8** %t, align 8, !dbg !62
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !63
  %0 = bitcast %struct.s1* %s to { i32, i8* }*, !dbg !64
  %1 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 0, !dbg !64
  %2 = load i32, i32* %1, align 8, !dbg !64
  %3 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 1, !dbg !64
  %4 = load i8*, i8** %3, align 8, !dbg !64
  %call2 = call i32 (i32, ...) @foo(i32 1, i32 %2, i8* %4, i8* %call1), !dbg !64
  ret i32 0, !dbg !65
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-24")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 12, type: !8, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, null}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 12, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 12, column: 9, scope: !7)
!14 = !DILocalVariable(name: "args1", scope: !7, file: !1, line: 14, type: !15)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !16, line: 30, baseType: !17)
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-24")
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 14, baseType: !18)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 192, elements: !27)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 14, size: 192, elements: !20)
!20 = !{!21, !23, !24, !26}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !19, file: !1, line: 14, baseType: !22, size: 32)
!22 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !19, file: !1, line: 14, baseType: !22, size: 32, offset: 32)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !19, file: !1, line: 14, baseType: !25, size: 64, offset: 64)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !19, file: !1, line: 14, baseType: !25, size: 64, offset: 128)
!27 = !{!28}
!28 = !DISubrange(count: 1)
!29 = !DILocation(line: 14, column: 13, scope: !7)
!30 = !DILocation(line: 15, column: 5, scope: !7)
!31 = !DILocalVariable(name: "args2", scope: !7, file: !1, line: 17, type: !15)
!32 = !DILocation(line: 17, column: 13, scope: !7)
!33 = !DILocation(line: 18, column: 5, scope: !7)
!34 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 20, type: !35)
!35 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 6, size: 128, elements: !36)
!36 = !{!37, !38}
!37 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !35, file: !1, line: 7, baseType: !10, size: 32)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !35, file: !1, line: 8, baseType: !39, size: 64, offset: 64)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!40 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!41 = !DILocation(line: 20, column: 15, scope: !7)
!42 = !DILocation(line: 20, column: 20, scope: !7)
!43 = !DILocation(line: 21, column: 5, scope: !7)
!44 = !DILocalVariable(name: "nt", scope: !7, file: !1, line: 22, type: !39)
!45 = !DILocation(line: 22, column: 11, scope: !7)
!46 = !DILocation(line: 22, column: 16, scope: !7)
!47 = !DILocalVariable(name: "s11", scope: !7, file: !1, line: 24, type: !35)
!48 = !DILocation(line: 24, column: 15, scope: !7)
!49 = !DILocation(line: 24, column: 21, scope: !7)
!50 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 25, type: !39)
!51 = !DILocation(line: 25, column: 11, scope: !7)
!52 = !DILocation(line: 25, column: 16, scope: !7)
!53 = !DILocation(line: 27, column: 5, scope: !7)
!54 = !DILocation(line: 30, column: 5, scope: !7)
!55 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 34, type: !56, isLocal: false, isDefinition: true, scopeLine: 35, isOptimized: false, unit: !0, variables: !2)
!56 = !DISubroutineType(types: !57)
!57 = !{!10}
!58 = !DILocalVariable(name: "s", scope: !55, file: !1, line: 36, type: !35)
!59 = !DILocation(line: 36, column: 15, scope: !55)
!60 = !DILocation(line: 37, column: 11, scope: !55)
!61 = !DILocation(line: 37, column: 7, scope: !55)
!62 = !DILocation(line: 37, column: 9, scope: !55)
!63 = !DILocation(line: 39, column: 15, scope: !55)
!64 = !DILocation(line: 39, column: 5, scope: !55)
!65 = !DILocation(line: 41, column: 5, scope: !55)
