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
define i32 @user(%struct.s2* %s2) #0 !dbg !7 {
entry:
  %s2.addr = alloca %struct.s2*, align 8
  %t1 = alloca i8*, align 8
  %nt1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %nt2 = alloca i8*, align 8
  %nt3 = alloca i8*, align 8
  store %struct.s2* %s2, %struct.s2** %s2.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.s2** %s2.addr, metadata !29, metadata !30), !dbg !31
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !32, metadata !30), !dbg !35
  %0 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !36
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %0, i32 0, i32 0, !dbg !36
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !36
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 0, !dbg !36
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !36
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !36
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !36

vaarg.in_reg:                                     ; preds = %entry
  %1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 3, !dbg !36
  %reg_save_area = load i8*, i8** %1, align 8, !dbg !36
  %2 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !36
  %3 = bitcast i8* %2 to i8**, !dbg !36
  %4 = add i32 %gp_offset, 8, !dbg !36
  store i32 %4, i32* %gp_offset_p, align 8, !dbg !36
  br label %vaarg.end, !dbg !36

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 2, !dbg !36
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !36
  %5 = bitcast i8* %overflow_arg_area to i8**, !dbg !36
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !36
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !36
  br label %vaarg.end, !dbg !36

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %3, %vaarg.in_reg ], [ %5, %vaarg.in_mem ], !dbg !36
  %6 = load i8*, i8** %vaarg.addr, align 8, !dbg !36
  store i8* %6, i8** %t1, align 8, !dbg !35
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !37, metadata !30), !dbg !38
  %7 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !39
  %vas1 = getelementptr inbounds %struct.s2, %struct.s2* %7, i32 0, i32 0, !dbg !39
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas1, i32 0, i32 0, !dbg !39
  %gp_offset_p3 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !39
  %gp_offset4 = load i32, i32* %gp_offset_p3, align 8, !dbg !39
  %fits_in_gp5 = icmp ule i32 %gp_offset4, 40, !dbg !39
  br i1 %fits_in_gp5, label %vaarg.in_reg6, label %vaarg.in_mem8, !dbg !39

vaarg.in_reg6:                                    ; preds = %vaarg.end
  %8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !39
  %reg_save_area7 = load i8*, i8** %8, align 8, !dbg !39
  %9 = getelementptr i8, i8* %reg_save_area7, i32 %gp_offset4, !dbg !39
  %10 = bitcast i8* %9 to i8**, !dbg !39
  %11 = add i32 %gp_offset4, 8, !dbg !39
  store i32 %11, i32* %gp_offset_p3, align 8, !dbg !39
  br label %vaarg.end12, !dbg !39

vaarg.in_mem8:                                    ; preds = %vaarg.end
  %overflow_arg_area_p9 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !39
  %overflow_arg_area10 = load i8*, i8** %overflow_arg_area_p9, align 8, !dbg !39
  %12 = bitcast i8* %overflow_arg_area10 to i8**, !dbg !39
  %overflow_arg_area.next11 = getelementptr i8, i8* %overflow_arg_area10, i32 8, !dbg !39
  store i8* %overflow_arg_area.next11, i8** %overflow_arg_area_p9, align 8, !dbg !39
  br label %vaarg.end12, !dbg !39

vaarg.end12:                                      ; preds = %vaarg.in_mem8, %vaarg.in_reg6
  %vaarg.addr13 = phi i8** [ %10, %vaarg.in_reg6 ], [ %12, %vaarg.in_mem8 ], !dbg !39
  %13 = load i8*, i8** %vaarg.addr13, align 8, !dbg !39
  store i8* %13, i8** %nt1, align 8, !dbg !38
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !40, metadata !30), !dbg !41
  %14 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !42
  %vas14 = getelementptr inbounds %struct.s2, %struct.s2* %14, i32 0, i32 0, !dbg !42
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas14, i32 0, i32 0, !dbg !42
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !42
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 8, !dbg !42
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !42
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !42

vaarg.in_reg19:                                   ; preds = %vaarg.end12
  %15 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !42
  %reg_save_area20 = load i8*, i8** %15, align 8, !dbg !42
  %16 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !42
  %17 = bitcast i8* %16 to i8**, !dbg !42
  %18 = add i32 %gp_offset17, 8, !dbg !42
  store i32 %18, i32* %gp_offset_p16, align 8, !dbg !42
  br label %vaarg.end25, !dbg !42

vaarg.in_mem21:                                   ; preds = %vaarg.end12
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !42
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !42
  %19 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !42
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !42
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !42
  br label %vaarg.end25, !dbg !42

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %17, %vaarg.in_reg19 ], [ %19, %vaarg.in_mem21 ], !dbg !42
  %20 = load i8*, i8** %vaarg.addr26, align 8, !dbg !42
  store i8* %20, i8** %t2, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !43, metadata !30), !dbg !44
  %21 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !45
  %vas27 = getelementptr inbounds %struct.s2, %struct.s2* %21, i32 0, i32 0, !dbg !45
  %arraydecay28 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas27, i32 0, i32 0, !dbg !45
  %gp_offset_p29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 0, !dbg !45
  %gp_offset30 = load i32, i32* %gp_offset_p29, align 8, !dbg !45
  %fits_in_gp31 = icmp ule i32 %gp_offset30, 40, !dbg !45
  br i1 %fits_in_gp31, label %vaarg.in_reg32, label %vaarg.in_mem34, !dbg !45

vaarg.in_reg32:                                   ; preds = %vaarg.end25
  %22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 3, !dbg !45
  %reg_save_area33 = load i8*, i8** %22, align 8, !dbg !45
  %23 = getelementptr i8, i8* %reg_save_area33, i32 %gp_offset30, !dbg !45
  %24 = bitcast i8* %23 to i8**, !dbg !45
  %25 = add i32 %gp_offset30, 8, !dbg !45
  store i32 %25, i32* %gp_offset_p29, align 8, !dbg !45
  br label %vaarg.end38, !dbg !45

vaarg.in_mem34:                                   ; preds = %vaarg.end25
  %overflow_arg_area_p35 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 2, !dbg !45
  %overflow_arg_area36 = load i8*, i8** %overflow_arg_area_p35, align 8, !dbg !45
  %26 = bitcast i8* %overflow_arg_area36 to i8**, !dbg !45
  %overflow_arg_area.next37 = getelementptr i8, i8* %overflow_arg_area36, i32 8, !dbg !45
  store i8* %overflow_arg_area.next37, i8** %overflow_arg_area_p35, align 8, !dbg !45
  br label %vaarg.end38, !dbg !45

vaarg.end38:                                      ; preds = %vaarg.in_mem34, %vaarg.in_reg32
  %vaarg.addr39 = phi i8** [ %24, %vaarg.in_reg32 ], [ %26, %vaarg.in_mem34 ], !dbg !45
  %27 = load i8*, i8** %vaarg.addr39, align 8, !dbg !45
  store i8* %27, i8** %nt2, align 8, !dbg !44
  call void @llvm.dbg.declare(metadata i8** %nt3, metadata !46, metadata !30), !dbg !47
  %28 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !48
  %vas40 = getelementptr inbounds %struct.s2, %struct.s2* %28, i32 0, i32 0, !dbg !48
  %arraydecay41 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas40, i32 0, i32 0, !dbg !48
  %gp_offset_p42 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 0, !dbg !48
  %gp_offset43 = load i32, i32* %gp_offset_p42, align 8, !dbg !48
  %fits_in_gp44 = icmp ule i32 %gp_offset43, 40, !dbg !48
  br i1 %fits_in_gp44, label %vaarg.in_reg45, label %vaarg.in_mem47, !dbg !48

vaarg.in_reg45:                                   ; preds = %vaarg.end38
  %29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 3, !dbg !48
  %reg_save_area46 = load i8*, i8** %29, align 8, !dbg !48
  %30 = getelementptr i8, i8* %reg_save_area46, i32 %gp_offset43, !dbg !48
  %31 = bitcast i8* %30 to i8**, !dbg !48
  %32 = add i32 %gp_offset43, 8, !dbg !48
  store i32 %32, i32* %gp_offset_p42, align 8, !dbg !48
  br label %vaarg.end51, !dbg !48

vaarg.in_mem47:                                   ; preds = %vaarg.end38
  %overflow_arg_area_p48 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 2, !dbg !48
  %overflow_arg_area49 = load i8*, i8** %overflow_arg_area_p48, align 8, !dbg !48
  %33 = bitcast i8* %overflow_arg_area49 to i8**, !dbg !48
  %overflow_arg_area.next50 = getelementptr i8, i8* %overflow_arg_area49, i32 8, !dbg !48
  store i8* %overflow_arg_area.next50, i8** %overflow_arg_area_p48, align 8, !dbg !48
  br label %vaarg.end51, !dbg !48

vaarg.end51:                                      ; preds = %vaarg.in_mem47, %vaarg.in_reg45
  %vaarg.addr52 = phi i8** [ %31, %vaarg.in_reg45 ], [ %33, %vaarg.in_mem47 ], !dbg !48
  %34 = load i8*, i8** %vaarg.addr52, align 8, !dbg !48
  store i8* %34, i8** %nt3, align 8, !dbg !47
  ret i32 0, !dbg !49
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @forwarder(i32 %n, ...) #0 !dbg !50 {
entry:
  %n.addr = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  %rc = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !53, metadata !30), !dbg !54
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !55, metadata !30), !dbg !59
  %s1 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !60
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %s1, i32 0, i32 0, !dbg !60
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !60
  %arraydecay2 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !60
  call void @llvm.va_start(i8* %arraydecay2), !dbg !60
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !61, metadata !30), !dbg !62
  %s3 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !63
  %call = call i32 @user(%struct.s2* %s3), !dbg !64
  store i32 %call, i32* %rc, align 4, !dbg !62
  %s4 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !65
  %vas5 = getelementptr inbounds %struct.s2, %struct.s2* %s4, i32 0, i32 0, !dbg !65
  %arraydecay6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas5, i32 0, i32 0, !dbg !65
  %arraydecay67 = bitcast %struct.__va_list_tag* %arraydecay6 to i8*, !dbg !65
  call void @llvm.va_end(i8* %arraydecay67), !dbg !65
  %0 = load i32, i32* %rc, align 4, !dbg !66
  ret i32 %0, !dbg !67
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !68 {
entry:
  %retval = alloca i32, align 4
  %not_tainted = alloca i8*, align 8
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !71, metadata !30), !dbg !72
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0), i8** %not_tainted, align 8, !dbg !72
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !73, metadata !30), !dbg !74
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)) #2, !dbg !75
  store i8* %call, i8** %tainted, align 8, !dbg !74
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !76, metadata !30), !dbg !77
  %0 = load i8*, i8** %tainted, align 8, !dbg !78
  %1 = load i8*, i8** %not_tainted, align 8, !dbg !79
  %2 = load i8*, i8** %tainted, align 8, !dbg !80
  %3 = load i8*, i8** %not_tainted, align 8, !dbg !81
  %4 = load i8*, i8** %not_tainted, align 8, !dbg !82
  %call1 = call i32 (i32, ...) @forwarder(i32 6, i8* %0, i8* %1, i8* %2, i8* %3, i8* %4), !dbg !83
  store i32 %call1, i32* %rc, align 4, !dbg !77
  %5 = load i32, i32* %rc, align 4, !dbg !84
  ret i32 %5, !dbg !85
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-28")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "user", scope: !1, file: !1, line: 15, type: !8, isLocal: false, isDefinition: true, scopeLine: 16, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 6, size: 192, elements: !13)
!13 = !{!14}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "vas", scope: !12, file: !1, line: 7, baseType: !15, size: 192)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !16, line: 30, baseType: !17)
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-28")
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, baseType: !18)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 192, elements: !27)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, size: 192, elements: !20)
!20 = !{!21, !23, !24, !26}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !19, file: !1, baseType: !22, size: 32)
!22 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !19, file: !1, baseType: !22, size: 32, offset: 32)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !19, file: !1, baseType: !25, size: 64, offset: 64)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !19, file: !1, baseType: !25, size: 64, offset: 128)
!27 = !{!28}
!28 = !DISubrange(count: 1)
!29 = !DILocalVariable(name: "s2", arg: 1, scope: !7, file: !1, line: 15, type: !11)
!30 = !DIExpression()
!31 = !DILocation(line: 15, column: 17, scope: !7)
!32 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 17, type: !33)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!35 = !DILocation(line: 17, column: 11, scope: !7)
!36 = !DILocation(line: 17, column: 16, scope: !7)
!37 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 18, type: !33)
!38 = !DILocation(line: 18, column: 11, scope: !7)
!39 = !DILocation(line: 18, column: 17, scope: !7)
!40 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 19, type: !33)
!41 = !DILocation(line: 19, column: 11, scope: !7)
!42 = !DILocation(line: 19, column: 16, scope: !7)
!43 = !DILocalVariable(name: "nt2", scope: !7, file: !1, line: 20, type: !33)
!44 = !DILocation(line: 20, column: 11, scope: !7)
!45 = !DILocation(line: 20, column: 17, scope: !7)
!46 = !DILocalVariable(name: "nt3", scope: !7, file: !1, line: 21, type: !33)
!47 = !DILocation(line: 21, column: 11, scope: !7)
!48 = !DILocation(line: 21, column: 17, scope: !7)
!49 = !DILocation(line: 23, column: 5, scope: !7)
!50 = distinct !DISubprogram(name: "forwarder", scope: !1, file: !1, line: 27, type: !51, isLocal: false, isDefinition: true, scopeLine: 28, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!51 = !DISubroutineType(types: !52)
!52 = !{!10, !10, null}
!53 = !DILocalVariable(name: "n", arg: 1, scope: !50, file: !1, line: 27, type: !10)
!54 = !DILocation(line: 27, column: 15, scope: !50)
!55 = !DILocalVariable(name: "s", scope: !50, file: !1, line: 29, type: !56)
!56 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 10, size: 192, elements: !57)
!57 = !{!58}
!58 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !56, file: !1, line: 11, baseType: !12, size: 192)
!59 = !DILocation(line: 29, column: 15, scope: !50)
!60 = !DILocation(line: 31, column: 5, scope: !50)
!61 = !DILocalVariable(name: "rc", scope: !50, file: !1, line: 33, type: !10)
!62 = !DILocation(line: 33, column: 9, scope: !50)
!63 = !DILocation(line: 33, column: 22, scope: !50)
!64 = !DILocation(line: 33, column: 14, scope: !50)
!65 = !DILocation(line: 35, column: 5, scope: !50)
!66 = !DILocation(line: 37, column: 12, scope: !50)
!67 = !DILocation(line: 37, column: 5, scope: !50)
!68 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 41, type: !69, isLocal: false, isDefinition: true, scopeLine: 42, isOptimized: false, unit: !0, variables: !2)
!69 = !DISubroutineType(types: !70)
!70 = !{!10}
!71 = !DILocalVariable(name: "not_tainted", scope: !68, file: !1, line: 43, type: !33)
!72 = !DILocation(line: 43, column: 11, scope: !68)
!73 = !DILocalVariable(name: "tainted", scope: !68, file: !1, line: 44, type: !33)
!74 = !DILocation(line: 44, column: 11, scope: !68)
!75 = !DILocation(line: 44, column: 21, scope: !68)
!76 = !DILocalVariable(name: "rc", scope: !68, file: !1, line: 46, type: !10)
!77 = !DILocation(line: 46, column: 9, scope: !68)
!78 = !DILocation(line: 46, column: 27, scope: !68)
!79 = !DILocation(line: 46, column: 36, scope: !68)
!80 = !DILocation(line: 46, column: 49, scope: !68)
!81 = !DILocation(line: 46, column: 58, scope: !68)
!82 = !DILocation(line: 46, column: 71, scope: !68)
!83 = !DILocation(line: 46, column: 14, scope: !68)
!84 = !DILocation(line: 48, column: 12, scope: !68)
!85 = !DILocation(line: 48, column: 5, scope: !68)
