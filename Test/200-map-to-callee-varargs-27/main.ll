; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s2 = type { [1 x %struct.__va_list_tag] }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s1 = type { %struct.s2 }

@.str = private unnamed_addr constant [12 x i8] c"hello world\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @user(%struct.s2* byval align 8 %s2) #0 !dbg !7 {
entry:
  %t1 = alloca i8*, align 8
  %nt1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %nt2 = alloca i8*, align 8
  %nt3 = alloca i8*, align 8
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !28, metadata !29), !dbg !30
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !31, metadata !29), !dbg !34
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !35
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !35
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 0, !dbg !35
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !35
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !35
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !35

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 3, !dbg !35
  %reg_save_area = load i8*, i8** %0, align 8, !dbg !35
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !35
  %2 = bitcast i8* %1 to i8**, !dbg !35
  %3 = add i32 %gp_offset, 8, !dbg !35
  store i32 %3, i32* %gp_offset_p, align 8, !dbg !35
  br label %vaarg.end, !dbg !35

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 2, !dbg !35
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !35
  %4 = bitcast i8* %overflow_arg_area to i8**, !dbg !35
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !35
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !35
  br label %vaarg.end, !dbg !35

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !35
  %5 = load i8*, i8** %vaarg.addr, align 8, !dbg !35
  store i8* %5, i8** %t1, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !36, metadata !29), !dbg !37
  %vas1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !38
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas1, i32 0, i32 0, !dbg !38
  %gp_offset_p3 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !38
  %gp_offset4 = load i32, i32* %gp_offset_p3, align 8, !dbg !38
  %fits_in_gp5 = icmp ule i32 %gp_offset4, 40, !dbg !38
  br i1 %fits_in_gp5, label %vaarg.in_reg6, label %vaarg.in_mem8, !dbg !38

vaarg.in_reg6:                                    ; preds = %vaarg.end
  %6 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !38
  %reg_save_area7 = load i8*, i8** %6, align 8, !dbg !38
  %7 = getelementptr i8, i8* %reg_save_area7, i32 %gp_offset4, !dbg !38
  %8 = bitcast i8* %7 to i8**, !dbg !38
  %9 = add i32 %gp_offset4, 8, !dbg !38
  store i32 %9, i32* %gp_offset_p3, align 8, !dbg !38
  br label %vaarg.end12, !dbg !38

vaarg.in_mem8:                                    ; preds = %vaarg.end
  %overflow_arg_area_p9 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !38
  %overflow_arg_area10 = load i8*, i8** %overflow_arg_area_p9, align 8, !dbg !38
  %10 = bitcast i8* %overflow_arg_area10 to i8**, !dbg !38
  %overflow_arg_area.next11 = getelementptr i8, i8* %overflow_arg_area10, i32 8, !dbg !38
  store i8* %overflow_arg_area.next11, i8** %overflow_arg_area_p9, align 8, !dbg !38
  br label %vaarg.end12, !dbg !38

vaarg.end12:                                      ; preds = %vaarg.in_mem8, %vaarg.in_reg6
  %vaarg.addr13 = phi i8** [ %8, %vaarg.in_reg6 ], [ %10, %vaarg.in_mem8 ], !dbg !38
  %11 = load i8*, i8** %vaarg.addr13, align 8, !dbg !38
  store i8* %11, i8** %nt1, align 8, !dbg !37
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !39, metadata !29), !dbg !40
  %vas14 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !41
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas14, i32 0, i32 0, !dbg !41
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !41
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 8, !dbg !41
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !41
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !41

vaarg.in_reg19:                                   ; preds = %vaarg.end12
  %12 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !41
  %reg_save_area20 = load i8*, i8** %12, align 8, !dbg !41
  %13 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !41
  %14 = bitcast i8* %13 to i8**, !dbg !41
  %15 = add i32 %gp_offset17, 8, !dbg !41
  store i32 %15, i32* %gp_offset_p16, align 8, !dbg !41
  br label %vaarg.end25, !dbg !41

vaarg.in_mem21:                                   ; preds = %vaarg.end12
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !41
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !41
  %16 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !41
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !41
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !41
  br label %vaarg.end25, !dbg !41

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %14, %vaarg.in_reg19 ], [ %16, %vaarg.in_mem21 ], !dbg !41
  %17 = load i8*, i8** %vaarg.addr26, align 8, !dbg !41
  store i8* %17, i8** %t2, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !42, metadata !29), !dbg !43
  %vas27 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !44
  %arraydecay28 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas27, i32 0, i32 0, !dbg !44
  %gp_offset_p29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 0, !dbg !44
  %gp_offset30 = load i32, i32* %gp_offset_p29, align 8, !dbg !44
  %fits_in_gp31 = icmp ule i32 %gp_offset30, 40, !dbg !44
  br i1 %fits_in_gp31, label %vaarg.in_reg32, label %vaarg.in_mem34, !dbg !44

vaarg.in_reg32:                                   ; preds = %vaarg.end25
  %18 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 3, !dbg !44
  %reg_save_area33 = load i8*, i8** %18, align 8, !dbg !44
  %19 = getelementptr i8, i8* %reg_save_area33, i32 %gp_offset30, !dbg !44
  %20 = bitcast i8* %19 to i8**, !dbg !44
  %21 = add i32 %gp_offset30, 8, !dbg !44
  store i32 %21, i32* %gp_offset_p29, align 8, !dbg !44
  br label %vaarg.end38, !dbg !44

vaarg.in_mem34:                                   ; preds = %vaarg.end25
  %overflow_arg_area_p35 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 2, !dbg !44
  %overflow_arg_area36 = load i8*, i8** %overflow_arg_area_p35, align 8, !dbg !44
  %22 = bitcast i8* %overflow_arg_area36 to i8**, !dbg !44
  %overflow_arg_area.next37 = getelementptr i8, i8* %overflow_arg_area36, i32 8, !dbg !44
  store i8* %overflow_arg_area.next37, i8** %overflow_arg_area_p35, align 8, !dbg !44
  br label %vaarg.end38, !dbg !44

vaarg.end38:                                      ; preds = %vaarg.in_mem34, %vaarg.in_reg32
  %vaarg.addr39 = phi i8** [ %20, %vaarg.in_reg32 ], [ %22, %vaarg.in_mem34 ], !dbg !44
  %23 = load i8*, i8** %vaarg.addr39, align 8, !dbg !44
  store i8* %23, i8** %nt2, align 8, !dbg !43
  call void @llvm.dbg.declare(metadata i8** %nt3, metadata !45, metadata !29), !dbg !46
  %vas40 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !47
  %arraydecay41 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas40, i32 0, i32 0, !dbg !47
  %gp_offset_p42 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 0, !dbg !47
  %gp_offset43 = load i32, i32* %gp_offset_p42, align 8, !dbg !47
  %fits_in_gp44 = icmp ule i32 %gp_offset43, 40, !dbg !47
  br i1 %fits_in_gp44, label %vaarg.in_reg45, label %vaarg.in_mem47, !dbg !47

vaarg.in_reg45:                                   ; preds = %vaarg.end38
  %24 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 3, !dbg !47
  %reg_save_area46 = load i8*, i8** %24, align 8, !dbg !47
  %25 = getelementptr i8, i8* %reg_save_area46, i32 %gp_offset43, !dbg !47
  %26 = bitcast i8* %25 to i8**, !dbg !47
  %27 = add i32 %gp_offset43, 8, !dbg !47
  store i32 %27, i32* %gp_offset_p42, align 8, !dbg !47
  br label %vaarg.end51, !dbg !47

vaarg.in_mem47:                                   ; preds = %vaarg.end38
  %overflow_arg_area_p48 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 2, !dbg !47
  %overflow_arg_area49 = load i8*, i8** %overflow_arg_area_p48, align 8, !dbg !47
  %28 = bitcast i8* %overflow_arg_area49 to i8**, !dbg !47
  %overflow_arg_area.next50 = getelementptr i8, i8* %overflow_arg_area49, i32 8, !dbg !47
  store i8* %overflow_arg_area.next50, i8** %overflow_arg_area_p48, align 8, !dbg !47
  br label %vaarg.end51, !dbg !47

vaarg.end51:                                      ; preds = %vaarg.in_mem47, %vaarg.in_reg45
  %vaarg.addr52 = phi i8** [ %26, %vaarg.in_reg45 ], [ %28, %vaarg.in_mem47 ], !dbg !47
  %29 = load i8*, i8** %vaarg.addr52, align 8, !dbg !47
  store i8* %29, i8** %nt3, align 8, !dbg !46
  ret i32 0, !dbg !48
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @forwarder(i32 %n, ...) #0 !dbg !49 {
entry:
  %n.addr = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  %rc = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !52, metadata !29), !dbg !53
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !54, metadata !29), !dbg !58
  %s1 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !59
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %s1, i32 0, i32 0, !dbg !59
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !59
  %arraydecay2 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !59
  call void @llvm.va_start(i8* %arraydecay2), !dbg !59
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !60, metadata !29), !dbg !61
  %s3 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !62
  %call = call i32 @user(%struct.s2* byval align 8 %s3), !dbg !63
  store i32 %call, i32* %rc, align 4, !dbg !61
  %s4 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !64
  %vas5 = getelementptr inbounds %struct.s2, %struct.s2* %s4, i32 0, i32 0, !dbg !64
  %arraydecay6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas5, i32 0, i32 0, !dbg !64
  %arraydecay67 = bitcast %struct.__va_list_tag* %arraydecay6 to i8*, !dbg !64
  call void @llvm.va_end(i8* %arraydecay67), !dbg !64
  %0 = load i32, i32* %rc, align 4, !dbg !65
  ret i32 %0, !dbg !66
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !67 {
entry:
  %retval = alloca i32, align 4
  %not_tainted = alloca i8*, align 8
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !70, metadata !29), !dbg !71
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0), i8** %not_tainted, align 8, !dbg !71
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !72, metadata !29), !dbg !73
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)) #2, !dbg !74
  store i8* %call, i8** %tainted, align 8, !dbg !73
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !75, metadata !29), !dbg !76
  %0 = load i8*, i8** %tainted, align 8, !dbg !77
  %1 = load i8*, i8** %not_tainted, align 8, !dbg !78
  %2 = load i8*, i8** %tainted, align 8, !dbg !79
  %3 = load i8*, i8** %not_tainted, align 8, !dbg !80
  %4 = load i8*, i8** %not_tainted, align 8, !dbg !81
  %call1 = call i32 (i32, ...) @forwarder(i32 6, i8* %0, i8* %1, i8* %2, i8* %3, i8* %4), !dbg !82
  store i32 %call1, i32* %rc, align 4, !dbg !76
  %5 = load i32, i32* %rc, align 4, !dbg !83
  ret i32 %5, !dbg !84
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-27")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "user", scope: !1, file: !1, line: 15, type: !8, isLocal: false, isDefinition: true, scopeLine: 16, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 6, size: 192, elements: !12)
!12 = !{!13}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "vas", scope: !11, file: !1, line: 7, baseType: !14, size: 192)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !15, line: 30, baseType: !16)
!15 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-27")
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, baseType: !17)
!17 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 192, elements: !26)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, size: 192, elements: !19)
!19 = !{!20, !22, !23, !25}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !18, file: !1, baseType: !21, size: 32)
!21 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !18, file: !1, baseType: !21, size: 32, offset: 32)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !18, file: !1, baseType: !24, size: 64, offset: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !18, file: !1, baseType: !24, size: 64, offset: 128)
!26 = !{!27}
!27 = !DISubrange(count: 1)
!28 = !DILocalVariable(name: "s2", arg: 1, scope: !7, file: !1, line: 15, type: !11)
!29 = !DIExpression()
!30 = !DILocation(line: 15, column: 16, scope: !7)
!31 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 17, type: !32)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!34 = !DILocation(line: 17, column: 11, scope: !7)
!35 = !DILocation(line: 17, column: 16, scope: !7)
!36 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 18, type: !32)
!37 = !DILocation(line: 18, column: 11, scope: !7)
!38 = !DILocation(line: 18, column: 17, scope: !7)
!39 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 19, type: !32)
!40 = !DILocation(line: 19, column: 11, scope: !7)
!41 = !DILocation(line: 19, column: 16, scope: !7)
!42 = !DILocalVariable(name: "nt2", scope: !7, file: !1, line: 20, type: !32)
!43 = !DILocation(line: 20, column: 11, scope: !7)
!44 = !DILocation(line: 20, column: 17, scope: !7)
!45 = !DILocalVariable(name: "nt3", scope: !7, file: !1, line: 21, type: !32)
!46 = !DILocation(line: 21, column: 11, scope: !7)
!47 = !DILocation(line: 21, column: 17, scope: !7)
!48 = !DILocation(line: 23, column: 5, scope: !7)
!49 = distinct !DISubprogram(name: "forwarder", scope: !1, file: !1, line: 27, type: !50, isLocal: false, isDefinition: true, scopeLine: 28, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!50 = !DISubroutineType(types: !51)
!51 = !{!10, !10, null}
!52 = !DILocalVariable(name: "n", arg: 1, scope: !49, file: !1, line: 27, type: !10)
!53 = !DILocation(line: 27, column: 15, scope: !49)
!54 = !DILocalVariable(name: "s", scope: !49, file: !1, line: 29, type: !55)
!55 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 10, size: 192, elements: !56)
!56 = !{!57}
!57 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !55, file: !1, line: 11, baseType: !11, size: 192)
!58 = !DILocation(line: 29, column: 15, scope: !49)
!59 = !DILocation(line: 31, column: 5, scope: !49)
!60 = !DILocalVariable(name: "rc", scope: !49, file: !1, line: 33, type: !10)
!61 = !DILocation(line: 33, column: 9, scope: !49)
!62 = !DILocation(line: 33, column: 21, scope: !49)
!63 = !DILocation(line: 33, column: 14, scope: !49)
!64 = !DILocation(line: 35, column: 5, scope: !49)
!65 = !DILocation(line: 37, column: 12, scope: !49)
!66 = !DILocation(line: 37, column: 5, scope: !49)
!67 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 41, type: !68, isLocal: false, isDefinition: true, scopeLine: 42, isOptimized: false, unit: !0, variables: !2)
!68 = !DISubroutineType(types: !69)
!69 = !{!10}
!70 = !DILocalVariable(name: "not_tainted", scope: !67, file: !1, line: 43, type: !32)
!71 = !DILocation(line: 43, column: 11, scope: !67)
!72 = !DILocalVariable(name: "tainted", scope: !67, file: !1, line: 44, type: !32)
!73 = !DILocation(line: 44, column: 11, scope: !67)
!74 = !DILocation(line: 44, column: 21, scope: !67)
!75 = !DILocalVariable(name: "rc", scope: !67, file: !1, line: 46, type: !10)
!76 = !DILocation(line: 46, column: 9, scope: !67)
!77 = !DILocation(line: 46, column: 27, scope: !67)
!78 = !DILocation(line: 46, column: 36, scope: !67)
!79 = !DILocation(line: 46, column: 49, scope: !67)
!80 = !DILocation(line: 46, column: 58, scope: !67)
!81 = !DILocation(line: 46, column: 71, scope: !67)
!82 = !DILocation(line: 46, column: 14, scope: !67)
!83 = !DILocation(line: 48, column: 12, scope: !67)
!84 = !DILocation(line: 48, column: 5, scope: !67)
