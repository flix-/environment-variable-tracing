; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s2 = type { i8*, i8*, i32 }
%struct.s1 = type { i32, i32, [1 x %struct.__va_list_tag] }

@.str = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo([1 x %struct.__va_list_tag]* %args) #0 !dbg !7 {
entry:
  %args.addr = alloca [1 x %struct.__va_list_tag]*, align 8
  %s = alloca %struct.s2, align 8
  store [1 x %struct.__va_list_tag]* %args, [1 x %struct.__va_list_tag]** %args.addr, align 8
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]** %args.addr, metadata !25, metadata !26), !dbg !27
  call void @llvm.dbg.declare(metadata %struct.s2* %s, metadata !28, metadata !26), !dbg !37
  %0 = load [1 x %struct.__va_list_tag]*, [1 x %struct.__va_list_tag]** %args.addr, align 8, !dbg !38
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %0, i32 0, i32 0, !dbg !38
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 0, !dbg !38
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !38
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !38
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !38

vaarg.in_reg:                                     ; preds = %entry
  %1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 3, !dbg !38
  %reg_save_area = load i8*, i8** %1, align 8, !dbg !38
  %2 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !38
  %3 = bitcast i8* %2 to i32*, !dbg !38
  %4 = add i32 %gp_offset, 8, !dbg !38
  store i32 %4, i32* %gp_offset_p, align 8, !dbg !38
  br label %vaarg.end, !dbg !38

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 2, !dbg !38
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !38
  %5 = bitcast i8* %overflow_arg_area to i32*, !dbg !38
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !38
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !38
  br label %vaarg.end, !dbg !38

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i32* [ %3, %vaarg.in_reg ], [ %5, %vaarg.in_mem ], !dbg !38
  %6 = load i32, i32* %vaarg.addr, align 4, !dbg !38
  %a = getelementptr inbounds %struct.s2, %struct.s2* %s, i32 0, i32 2, !dbg !39
  store i32 %6, i32* %a, align 8, !dbg !40
  %7 = load [1 x %struct.__va_list_tag]*, [1 x %struct.__va_list_tag]** %args.addr, align 8, !dbg !41
  %arraydecay1 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %7, i32 0, i32 0, !dbg !41
  %gp_offset_p2 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay1, i32 0, i32 0, !dbg !41
  %gp_offset3 = load i32, i32* %gp_offset_p2, align 8, !dbg !41
  %fits_in_gp4 = icmp ule i32 %gp_offset3, 40, !dbg !41
  br i1 %fits_in_gp4, label %vaarg.in_reg5, label %vaarg.in_mem7, !dbg !41

vaarg.in_reg5:                                    ; preds = %vaarg.end
  %8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay1, i32 0, i32 3, !dbg !41
  %reg_save_area6 = load i8*, i8** %8, align 8, !dbg !41
  %9 = getelementptr i8, i8* %reg_save_area6, i32 %gp_offset3, !dbg !41
  %10 = bitcast i8* %9 to i8**, !dbg !41
  %11 = add i32 %gp_offset3, 8, !dbg !41
  store i32 %11, i32* %gp_offset_p2, align 8, !dbg !41
  br label %vaarg.end11, !dbg !41

vaarg.in_mem7:                                    ; preds = %vaarg.end
  %overflow_arg_area_p8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay1, i32 0, i32 2, !dbg !41
  %overflow_arg_area9 = load i8*, i8** %overflow_arg_area_p8, align 8, !dbg !41
  %12 = bitcast i8* %overflow_arg_area9 to i8**, !dbg !41
  %overflow_arg_area.next10 = getelementptr i8, i8* %overflow_arg_area9, i32 8, !dbg !41
  store i8* %overflow_arg_area.next10, i8** %overflow_arg_area_p8, align 8, !dbg !41
  br label %vaarg.end11, !dbg !41

vaarg.end11:                                      ; preds = %vaarg.in_mem7, %vaarg.in_reg5
  %vaarg.addr12 = phi i8** [ %10, %vaarg.in_reg5 ], [ %12, %vaarg.in_mem7 ], !dbg !41
  %13 = load i8*, i8** %vaarg.addr12, align 8, !dbg !41
  %ut1 = getelementptr inbounds %struct.s2, %struct.s2* %s, i32 0, i32 1, !dbg !42
  store i8* %13, i8** %ut1, align 8, !dbg !43
  %14 = load [1 x %struct.__va_list_tag]*, [1 x %struct.__va_list_tag]** %args.addr, align 8, !dbg !44
  %arraydecay13 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %14, i32 0, i32 0, !dbg !44
  %gp_offset_p14 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay13, i32 0, i32 0, !dbg !44
  %gp_offset15 = load i32, i32* %gp_offset_p14, align 8, !dbg !44
  %fits_in_gp16 = icmp ule i32 %gp_offset15, 40, !dbg !44
  br i1 %fits_in_gp16, label %vaarg.in_reg17, label %vaarg.in_mem19, !dbg !44

vaarg.in_reg17:                                   ; preds = %vaarg.end11
  %15 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay13, i32 0, i32 3, !dbg !44
  %reg_save_area18 = load i8*, i8** %15, align 8, !dbg !44
  %16 = getelementptr i8, i8* %reg_save_area18, i32 %gp_offset15, !dbg !44
  %17 = bitcast i8* %16 to i8**, !dbg !44
  %18 = add i32 %gp_offset15, 8, !dbg !44
  store i32 %18, i32* %gp_offset_p14, align 8, !dbg !44
  br label %vaarg.end23, !dbg !44

vaarg.in_mem19:                                   ; preds = %vaarg.end11
  %overflow_arg_area_p20 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay13, i32 0, i32 2, !dbg !44
  %overflow_arg_area21 = load i8*, i8** %overflow_arg_area_p20, align 8, !dbg !44
  %19 = bitcast i8* %overflow_arg_area21 to i8**, !dbg !44
  %overflow_arg_area.next22 = getelementptr i8, i8* %overflow_arg_area21, i32 8, !dbg !44
  store i8* %overflow_arg_area.next22, i8** %overflow_arg_area_p20, align 8, !dbg !44
  br label %vaarg.end23, !dbg !44

vaarg.end23:                                      ; preds = %vaarg.in_mem19, %vaarg.in_reg17
  %vaarg.addr24 = phi i8** [ %17, %vaarg.in_reg17 ], [ %19, %vaarg.in_mem19 ], !dbg !44
  %20 = load i8*, i8** %vaarg.addr24, align 8, !dbg !44
  %t1 = getelementptr inbounds %struct.s2, %struct.s2* %s, i32 0, i32 0, !dbg !45
  store i8* %20, i8** %t1, align 8, !dbg !46
  ret void, !dbg !47
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @forwarder(i32 %n, ...) #0 !dbg !48 {
entry:
  %n.addr = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !51, metadata !26), !dbg !52
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !53, metadata !26), !dbg !59
  %vas = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 2, !dbg !60
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !60
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !60
  call void @llvm.va_start(i8* %arraydecay1), !dbg !60
  %vas2 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 2, !dbg !61
  call void @foo([1 x %struct.__va_list_tag]* %vas2), !dbg !62
  %vas3 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 2, !dbg !63
  %arraydecay4 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas3, i32 0, i32 0, !dbg !63
  %arraydecay45 = bitcast %struct.__va_list_tag* %arraydecay4 to i8*, !dbg !63
  call void @llvm.va_end(i8* %arraydecay45), !dbg !63
  ret i32 0, !dbg !64
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !65 {
entry:
  %retval = alloca i32, align 4
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !68, metadata !26), !dbg !69
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)) #2, !dbg !70
  %call1 = call i32 (i32, ...) @forwarder(i32 3, i32 1, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i8* %call), !dbg !71
  store i32 %call1, i32* %rc, align 4, !dbg !69
  %0 = load i32, i32* %rc, align 4, !dbg !72
  ret i32 %0, !dbg !73
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-36")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 19, type: !8, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !12, line: 30, baseType: !13)
!12 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-36")
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, baseType: !14)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 192, elements: !23)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, size: 192, elements: !16)
!16 = !{!17, !19, !20, !22}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !15, file: !1, baseType: !18, size: 32)
!18 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !15, file: !1, baseType: !18, size: 32, offset: 32)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !15, file: !1, baseType: !21, size: 64, offset: 64)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !15, file: !1, baseType: !21, size: 64, offset: 128)
!23 = !{!24}
!24 = !DISubrange(count: 1)
!25 = !DILocalVariable(name: "args", arg: 1, scope: !7, file: !1, line: 19, type: !10)
!26 = !DIExpression()
!27 = !DILocation(line: 19, column: 14, scope: !7)
!28 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 20, type: !29)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 6, size: 192, elements: !30)
!30 = !{!31, !34, !35}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !29, file: !1, line: 7, baseType: !32, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "ut1", scope: !29, file: !1, line: 8, baseType: !32, size: 64, offset: 64)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !29, file: !1, line: 9, baseType: !36, size: 32, offset: 128)
!36 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!37 = !DILocation(line: 20, column: 15, scope: !7)
!38 = !DILocation(line: 22, column: 11, scope: !7)
!39 = !DILocation(line: 22, column: 7, scope: !7)
!40 = !DILocation(line: 22, column: 9, scope: !7)
!41 = !DILocation(line: 23, column: 13, scope: !7)
!42 = !DILocation(line: 23, column: 7, scope: !7)
!43 = !DILocation(line: 23, column: 11, scope: !7)
!44 = !DILocation(line: 24, column: 12, scope: !7)
!45 = !DILocation(line: 24, column: 7, scope: !7)
!46 = !DILocation(line: 24, column: 10, scope: !7)
!47 = !DILocation(line: 25, column: 1, scope: !7)
!48 = distinct !DISubprogram(name: "forwarder", scope: !1, file: !1, line: 28, type: !49, isLocal: false, isDefinition: true, scopeLine: 29, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!49 = !DISubroutineType(types: !50)
!50 = !{!36, !36, null}
!51 = !DILocalVariable(name: "n", arg: 1, scope: !48, file: !1, line: 28, type: !36)
!52 = !DILocation(line: 28, column: 15, scope: !48)
!53 = !DILocalVariable(name: "s", scope: !48, file: !1, line: 30, type: !54)
!54 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 12, size: 256, elements: !55)
!55 = !{!56, !57, !58}
!56 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !54, file: !1, line: 13, baseType: !36, size: 32)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !54, file: !1, line: 14, baseType: !36, size: 32, offset: 32)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "vas", scope: !54, file: !1, line: 15, baseType: !11, size: 192, offset: 64)
!59 = !DILocation(line: 30, column: 15, scope: !48)
!60 = !DILocation(line: 32, column: 5, scope: !48)
!61 = !DILocation(line: 34, column: 12, scope: !48)
!62 = !DILocation(line: 34, column: 5, scope: !48)
!63 = !DILocation(line: 36, column: 5, scope: !48)
!64 = !DILocation(line: 38, column: 5, scope: !48)
!65 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 42, type: !66, isLocal: false, isDefinition: true, scopeLine: 43, isOptimized: false, unit: !0, variables: !2)
!66 = !DISubroutineType(types: !67)
!67 = !{!36}
!68 = !DILocalVariable(name: "rc", scope: !65, file: !1, line: 44, type: !36)
!69 = !DILocation(line: 44, column: 9, scope: !65)
!70 = !DILocation(line: 44, column: 39, scope: !65)
!71 = !DILocation(line: 44, column: 14, scope: !65)
!72 = !DILocation(line: 46, column: 12, scope: !65)
!73 = !DILocation(line: 46, column: 5, scope: !65)
