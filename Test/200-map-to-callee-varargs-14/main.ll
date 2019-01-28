; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s2 = type { double, %union.u1 }
%union.u1 = type { i8* }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s1 = type { i32, i32, i8*, %struct.s2 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"not tainted\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define %struct.s2* @foo(i32 %n, ...) #0 !dbg !9 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %ut1 = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %s1ptr = alloca %struct.s1*, align 8
  %s2 = alloca %struct.s2, align 8
  %tmp = alloca %struct.s2, align 8
  %s2ptr = alloca %struct.s2*, align 8
  %ut2 = alloca i8*, align 8
  %t1 = alloca i8*, align 8
  %ut3 = alloca i32, align 4
  %t2 = alloca i8*, align 8
  %ut4 = alloca i32, align 4
  %t3 = alloca i8*, align 8
  %ut5 = alloca i32, align 4
  %t4 = alloca i8*, align 8
  %ut6 = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !25, metadata !26), !dbg !27
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !28, metadata !26), !dbg !42
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !43
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !43
  call void @llvm.va_start(i8* %arraydecay1), !dbg !43
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !44, metadata !26), !dbg !45
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !46
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !46
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !46
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !46
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !46

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !46
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !46
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !46
  %2 = bitcast i8* %1 to i32*, !dbg !46
  %3 = add i32 %gp_offset, 8, !dbg !46
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !46
  br label %vaarg.end, !dbg !46

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !46
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !46
  %4 = bitcast i8* %overflow_arg_area to i32*, !dbg !46
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !46
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !46
  br label %vaarg.end, !dbg !46

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i32* [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !46
  %5 = load i32, i32* %vaarg.addr, align 4, !dbg !46
  store i32 %5, i32* %ut1, align 4, !dbg !45
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !47, metadata !26), !dbg !54
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !55
  %overflow_arg_area_p4 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !55
  %overflow_arg_area5 = load i8*, i8** %overflow_arg_area_p4, align 8, !dbg !55
  %6 = bitcast i8* %overflow_arg_area5 to %struct.s1*, !dbg !55
  %overflow_arg_area.next6 = getelementptr i8, i8* %overflow_arg_area5, i32 32, !dbg !55
  store i8* %overflow_arg_area.next6, i8** %overflow_arg_area_p4, align 8, !dbg !55
  %7 = bitcast %struct.s1* %s1 to i8*, !dbg !55
  %8 = bitcast %struct.s1* %6 to i8*, !dbg !55
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* %8, i64 32, i32 8, i1 false), !dbg !55
  call void @llvm.dbg.declare(metadata %struct.s1** %s1ptr, metadata !56, metadata !26), !dbg !58
  %arraydecay7 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !59
  %gp_offset_p8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay7, i32 0, i32 0, !dbg !59
  %gp_offset9 = load i32, i32* %gp_offset_p8, align 16, !dbg !59
  %fits_in_gp10 = icmp ule i32 %gp_offset9, 40, !dbg !59
  br i1 %fits_in_gp10, label %vaarg.in_reg11, label %vaarg.in_mem13, !dbg !59

vaarg.in_reg11:                                   ; preds = %vaarg.end
  %9 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay7, i32 0, i32 3, !dbg !59
  %reg_save_area12 = load i8*, i8** %9, align 16, !dbg !59
  %10 = getelementptr i8, i8* %reg_save_area12, i32 %gp_offset9, !dbg !59
  %11 = bitcast i8* %10 to %struct.s1**, !dbg !59
  %12 = add i32 %gp_offset9, 8, !dbg !59
  store i32 %12, i32* %gp_offset_p8, align 16, !dbg !59
  br label %vaarg.end17, !dbg !59

vaarg.in_mem13:                                   ; preds = %vaarg.end
  %overflow_arg_area_p14 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay7, i32 0, i32 2, !dbg !59
  %overflow_arg_area15 = load i8*, i8** %overflow_arg_area_p14, align 8, !dbg !59
  %13 = bitcast i8* %overflow_arg_area15 to %struct.s1**, !dbg !59
  %overflow_arg_area.next16 = getelementptr i8, i8* %overflow_arg_area15, i32 8, !dbg !59
  store i8* %overflow_arg_area.next16, i8** %overflow_arg_area_p14, align 8, !dbg !59
  br label %vaarg.end17, !dbg !59

vaarg.end17:                                      ; preds = %vaarg.in_mem13, %vaarg.in_reg11
  %vaarg.addr18 = phi %struct.s1** [ %11, %vaarg.in_reg11 ], [ %13, %vaarg.in_mem13 ], !dbg !59
  %14 = load %struct.s1*, %struct.s1** %vaarg.addr18, align 8, !dbg !59
  store %struct.s1* %14, %struct.s1** %s1ptr, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !60, metadata !26), !dbg !61
  %arraydecay19 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !62
  %gp_offset_p20 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 0, !dbg !62
  %gp_offset21 = load i32, i32* %gp_offset_p20, align 16, !dbg !62
  %fits_in_gp22 = icmp ule i32 %gp_offset21, 40, !dbg !62
  %fp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 1, !dbg !62
  %fp_offset = load i32, i32* %fp_offset_p, align 4, !dbg !62
  %fits_in_fp = icmp ule i32 %fp_offset, 160, !dbg !62
  %15 = and i1 %fits_in_gp22, %fits_in_fp, !dbg !62
  br i1 %15, label %vaarg.in_reg23, label %vaarg.in_mem25, !dbg !62

vaarg.in_reg23:                                   ; preds = %vaarg.end17
  %16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 3, !dbg !62
  %reg_save_area24 = load i8*, i8** %16, align 16, !dbg !62
  %17 = bitcast %struct.s2* %tmp to { double, i8* }*, !dbg !62
  %18 = getelementptr i8, i8* %reg_save_area24, i32 %gp_offset21, !dbg !62
  %19 = getelementptr i8, i8* %reg_save_area24, i32 %fp_offset, !dbg !62
  %20 = bitcast i8* %19 to double*, !dbg !62
  %21 = load double, double* %20, align 8, !dbg !62
  %22 = getelementptr inbounds { double, i8* }, { double, i8* }* %17, i32 0, i32 0, !dbg !62
  store double %21, double* %22, align 8, !dbg !62
  %23 = bitcast i8* %18 to i8**, !dbg !62
  %24 = load i8*, i8** %23, align 8, !dbg !62
  %25 = getelementptr inbounds { double, i8* }, { double, i8* }* %17, i32 0, i32 1, !dbg !62
  store i8* %24, i8** %25, align 8, !dbg !62
  %26 = bitcast { double, i8* }* %17 to %struct.s2*, !dbg !62
  %27 = add i32 %gp_offset21, 8, !dbg !62
  store i32 %27, i32* %gp_offset_p20, align 16, !dbg !62
  %28 = add i32 %fp_offset, 16, !dbg !62
  store i32 %28, i32* %fp_offset_p, align 4, !dbg !62
  br label %vaarg.end29, !dbg !62

vaarg.in_mem25:                                   ; preds = %vaarg.end17
  %overflow_arg_area_p26 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 2, !dbg !62
  %overflow_arg_area27 = load i8*, i8** %overflow_arg_area_p26, align 8, !dbg !62
  %29 = bitcast i8* %overflow_arg_area27 to %struct.s2*, !dbg !62
  %overflow_arg_area.next28 = getelementptr i8, i8* %overflow_arg_area27, i32 16, !dbg !62
  store i8* %overflow_arg_area.next28, i8** %overflow_arg_area_p26, align 8, !dbg !62
  br label %vaarg.end29, !dbg !62

vaarg.end29:                                      ; preds = %vaarg.in_mem25, %vaarg.in_reg23
  %vaarg.addr30 = phi %struct.s2* [ %26, %vaarg.in_reg23 ], [ %29, %vaarg.in_mem25 ], !dbg !62
  %30 = bitcast %struct.s2* %s2 to i8*, !dbg !62
  %31 = bitcast %struct.s2* %vaarg.addr30 to i8*, !dbg !62
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %30, i8* %31, i64 16, i32 8, i1 false), !dbg !62
  call void @llvm.dbg.declare(metadata %struct.s2** %s2ptr, metadata !63, metadata !26), !dbg !64
  %arraydecay31 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !65
  %gp_offset_p32 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay31, i32 0, i32 0, !dbg !65
  %gp_offset33 = load i32, i32* %gp_offset_p32, align 16, !dbg !65
  %fits_in_gp34 = icmp ule i32 %gp_offset33, 40, !dbg !65
  br i1 %fits_in_gp34, label %vaarg.in_reg35, label %vaarg.in_mem37, !dbg !65

vaarg.in_reg35:                                   ; preds = %vaarg.end29
  %32 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay31, i32 0, i32 3, !dbg !65
  %reg_save_area36 = load i8*, i8** %32, align 16, !dbg !65
  %33 = getelementptr i8, i8* %reg_save_area36, i32 %gp_offset33, !dbg !65
  %34 = bitcast i8* %33 to %struct.s2**, !dbg !65
  %35 = add i32 %gp_offset33, 8, !dbg !65
  store i32 %35, i32* %gp_offset_p32, align 16, !dbg !65
  br label %vaarg.end41, !dbg !65

vaarg.in_mem37:                                   ; preds = %vaarg.end29
  %overflow_arg_area_p38 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay31, i32 0, i32 2, !dbg !65
  %overflow_arg_area39 = load i8*, i8** %overflow_arg_area_p38, align 8, !dbg !65
  %36 = bitcast i8* %overflow_arg_area39 to %struct.s2**, !dbg !65
  %overflow_arg_area.next40 = getelementptr i8, i8* %overflow_arg_area39, i32 8, !dbg !65
  store i8* %overflow_arg_area.next40, i8** %overflow_arg_area_p38, align 8, !dbg !65
  br label %vaarg.end41, !dbg !65

vaarg.end41:                                      ; preds = %vaarg.in_mem37, %vaarg.in_reg35
  %vaarg.addr42 = phi %struct.s2** [ %34, %vaarg.in_reg35 ], [ %36, %vaarg.in_mem37 ], !dbg !65
  %37 = load %struct.s2*, %struct.s2** %vaarg.addr42, align 8, !dbg !65
  store %struct.s2* %37, %struct.s2** %s2ptr, align 8, !dbg !64
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !66, metadata !26), !dbg !67
  %arraydecay43 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !68
  %gp_offset_p44 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay43, i32 0, i32 0, !dbg !68
  %gp_offset45 = load i32, i32* %gp_offset_p44, align 16, !dbg !68
  %fits_in_gp46 = icmp ule i32 %gp_offset45, 40, !dbg !68
  br i1 %fits_in_gp46, label %vaarg.in_reg47, label %vaarg.in_mem49, !dbg !68

vaarg.in_reg47:                                   ; preds = %vaarg.end41
  %38 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay43, i32 0, i32 3, !dbg !68
  %reg_save_area48 = load i8*, i8** %38, align 16, !dbg !68
  %39 = getelementptr i8, i8* %reg_save_area48, i32 %gp_offset45, !dbg !68
  %40 = bitcast i8* %39 to i8**, !dbg !68
  %41 = add i32 %gp_offset45, 8, !dbg !68
  store i32 %41, i32* %gp_offset_p44, align 16, !dbg !68
  br label %vaarg.end53, !dbg !68

vaarg.in_mem49:                                   ; preds = %vaarg.end41
  %overflow_arg_area_p50 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay43, i32 0, i32 2, !dbg !68
  %overflow_arg_area51 = load i8*, i8** %overflow_arg_area_p50, align 8, !dbg !68
  %42 = bitcast i8* %overflow_arg_area51 to i8**, !dbg !68
  %overflow_arg_area.next52 = getelementptr i8, i8* %overflow_arg_area51, i32 8, !dbg !68
  store i8* %overflow_arg_area.next52, i8** %overflow_arg_area_p50, align 8, !dbg !68
  br label %vaarg.end53, !dbg !68

vaarg.end53:                                      ; preds = %vaarg.in_mem49, %vaarg.in_reg47
  %vaarg.addr54 = phi i8** [ %40, %vaarg.in_reg47 ], [ %42, %vaarg.in_mem49 ], !dbg !68
  %43 = load i8*, i8** %vaarg.addr54, align 8, !dbg !68
  store i8* %43, i8** %ut2, align 8, !dbg !67
  %arraydecay55 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !69
  %arraydecay5556 = bitcast %struct.__va_list_tag* %arraydecay55 to i8*, !dbg !69
  call void @llvm.va_end(i8* %arraydecay5556), !dbg !69
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !70, metadata !26), !dbg !71
  %s257 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !72
  %u = getelementptr inbounds %struct.s2, %struct.s2* %s257, i32 0, i32 1, !dbg !73
  %t158 = bitcast %union.u1* %u to i8**, !dbg !74
  %44 = load i8*, i8** %t158, align 8, !dbg !74
  store i8* %44, i8** %t1, align 8, !dbg !71
  call void @llvm.dbg.declare(metadata i32* %ut3, metadata !75, metadata !26), !dbg !76
  %s259 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !77
  %u60 = getelementptr inbounds %struct.s2, %struct.s2* %s259, i32 0, i32 1, !dbg !78
  %a = bitcast %union.u1* %u60 to i32*, !dbg !79
  %45 = load i32, i32* %a, align 8, !dbg !79
  store i32 %45, i32* %ut3, align 4, !dbg !76
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !80, metadata !26), !dbg !81
  %46 = load %struct.s1*, %struct.s1** %s1ptr, align 8, !dbg !82
  %s261 = getelementptr inbounds %struct.s1, %struct.s1* %46, i32 0, i32 3, !dbg !83
  %u62 = getelementptr inbounds %struct.s2, %struct.s2* %s261, i32 0, i32 1, !dbg !84
  %t163 = bitcast %union.u1* %u62 to i8**, !dbg !85
  %47 = load i8*, i8** %t163, align 8, !dbg !85
  store i8* %47, i8** %t2, align 8, !dbg !81
  call void @llvm.dbg.declare(metadata i32* %ut4, metadata !86, metadata !26), !dbg !87
  %48 = load %struct.s1*, %struct.s1** %s1ptr, align 8, !dbg !88
  %s264 = getelementptr inbounds %struct.s1, %struct.s1* %48, i32 0, i32 3, !dbg !89
  %u65 = getelementptr inbounds %struct.s2, %struct.s2* %s264, i32 0, i32 1, !dbg !90
  %a66 = bitcast %union.u1* %u65 to i32*, !dbg !91
  %49 = load i32, i32* %a66, align 8, !dbg !91
  store i32 %49, i32* %ut4, align 4, !dbg !87
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !92, metadata !26), !dbg !93
  %u67 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !94
  %t168 = bitcast %union.u1* %u67 to i8**, !dbg !95
  %50 = load i8*, i8** %t168, align 8, !dbg !95
  store i8* %50, i8** %t3, align 8, !dbg !93
  call void @llvm.dbg.declare(metadata i32* %ut5, metadata !96, metadata !26), !dbg !97
  %u69 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !98
  %a70 = bitcast %union.u1* %u69 to i32*, !dbg !99
  %51 = load i32, i32* %a70, align 8, !dbg !99
  store i32 %51, i32* %ut5, align 4, !dbg !97
  call void @llvm.dbg.declare(metadata i8** %t4, metadata !100, metadata !26), !dbg !101
  %52 = load %struct.s2*, %struct.s2** %s2ptr, align 8, !dbg !102
  %u71 = getelementptr inbounds %struct.s2, %struct.s2* %52, i32 0, i32 1, !dbg !103
  %t172 = bitcast %union.u1* %u71 to i8**, !dbg !104
  %53 = load i8*, i8** %t172, align 8, !dbg !104
  store i8* %53, i8** %t4, align 8, !dbg !101
  call void @llvm.dbg.declare(metadata i32* %ut6, metadata !105, metadata !26), !dbg !106
  %54 = load %struct.s2*, %struct.s2** %s2ptr, align 8, !dbg !107
  %u73 = getelementptr inbounds %struct.s2, %struct.s2* %54, i32 0, i32 1, !dbg !108
  %a74 = bitcast %union.u1* %u73 to i32*, !dbg !109
  %55 = load i32, i32* %a74, align 8, !dbg !109
  store i32 %55, i32* %ut6, align 4, !dbg !106
  %56 = load %struct.s2*, %struct.s2** %s2ptr, align 8, !dbg !110
  ret %struct.s2* %56, !dbg !111
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
define i32 @main() #0 !dbg !112 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %s21 = alloca %struct.s2*, align 8
  %t15 = alloca i8*, align 8
  %ut1 = alloca i32, align 4
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !115, metadata !26), !dbg !116
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !117
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !118
  %u = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !119
  %t1 = bitcast %union.u1* %u to i8**, !dbg !120
  store i8* %call, i8** %t1, align 8, !dbg !121
  call void @llvm.dbg.declare(metadata %struct.s2** %s21, metadata !122, metadata !26), !dbg !123
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !124
  %s23 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !125
  %0 = bitcast %struct.s2* %s22 to { double, i8* }*, !dbg !126
  %1 = getelementptr inbounds { double, i8* }, { double, i8* }* %0, i32 0, i32 0, !dbg !126
  %2 = load double, double* %1, align 8, !dbg !126
  %3 = getelementptr inbounds { double, i8* }, { double, i8* }* %0, i32 0, i32 1, !dbg !126
  %4 = load i8*, i8** %3, align 8, !dbg !126
  %call4 = call %struct.s2* (i32, ...) @foo(i32 8, i32 4711, %struct.s1* byval align 8 %s1, %struct.s1* %s1, double %2, i8* %4, %struct.s2* %s23, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0)), !dbg !126
  store %struct.s2* %call4, %struct.s2** %s21, align 8, !dbg !123
  call void @llvm.dbg.declare(metadata i8** %t15, metadata !127, metadata !26), !dbg !128
  %5 = load %struct.s2*, %struct.s2** %s21, align 8, !dbg !129
  %u6 = getelementptr inbounds %struct.s2, %struct.s2* %5, i32 0, i32 1, !dbg !130
  %t17 = bitcast %union.u1* %u6 to i8**, !dbg !131
  %6 = load i8*, i8** %t17, align 8, !dbg !131
  store i8* %6, i8** %t15, align 8, !dbg !128
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !132, metadata !26), !dbg !133
  %7 = load %struct.s2*, %struct.s2** %s21, align 8, !dbg !134
  %u8 = getelementptr inbounds %struct.s2, %struct.s2* %7, i32 0, i32 1, !dbg !135
  %a = bitcast %union.u1* %u8 to i32*, !dbg !136
  %8 = load i32, i32* %a, align 8, !dbg !136
  store i32 %8, i32* %ut1, align 4, !dbg !133
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !137, metadata !26), !dbg !138
  %9 = load i8*, i8** %t15, align 8, !dbg !139
  %cmp = icmp ne i8* %9, null, !dbg !140
  %conv = zext i1 %cmp to i32, !dbg !140
  store i32 %conv, i32* %rc, align 4, !dbg !138
  %10 = load i32, i32* %rc, align 4, !dbg !141
  ret i32 %10, !dbg !142
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-14")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 24, type: !10, isLocal: false, isDefinition: true, scopeLine: 25, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !24, null}
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 11, size: 128, elements: !14)
!14 = !{!15, !17}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "i", scope: !13, file: !1, line: 12, baseType: !16, size: 64)
!16 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !13, file: !1, line: 13, baseType: !18, size: 64, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "u1", file: !1, line: 6, size: 64, elements: !19)
!19 = !{!20, !23}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !18, file: !1, line: 7, baseType: !21, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !18, file: !1, line: 8, baseType: !24, size: 32)
!24 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!25 = !DILocalVariable(name: "n", arg: 1, scope: !9, file: !1, line: 24, type: !24)
!26 = !DIExpression()
!27 = !DILocation(line: 24, column: 9, scope: !9)
!28 = !DILocalVariable(name: "ap", scope: !9, file: !1, line: 26, type: !29)
!29 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !30, line: 30, baseType: !31)
!30 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-14")
!31 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 26, baseType: !32)
!32 = !DICompositeType(tag: DW_TAG_array_type, baseType: !33, size: 192, elements: !40)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 26, size: 192, elements: !34)
!34 = !{!35, !37, !38, !39}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !33, file: !1, line: 26, baseType: !36, size: 32)
!36 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !33, file: !1, line: 26, baseType: !36, size: 32, offset: 32)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !33, file: !1, line: 26, baseType: !4, size: 64, offset: 64)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !33, file: !1, line: 26, baseType: !4, size: 64, offset: 128)
!40 = !{!41}
!41 = !DISubrange(count: 1)
!42 = !DILocation(line: 26, column: 13, scope: !9)
!43 = !DILocation(line: 27, column: 5, scope: !9)
!44 = !DILocalVariable(name: "ut1", scope: !9, file: !1, line: 29, type: !24)
!45 = !DILocation(line: 29, column: 9, scope: !9)
!46 = !DILocation(line: 29, column: 15, scope: !9)
!47 = !DILocalVariable(name: "s1", scope: !9, file: !1, line: 30, type: !48)
!48 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 16, size: 256, elements: !49)
!49 = !{!50, !51, !52, !53}
!50 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !48, file: !1, line: 17, baseType: !24, size: 32)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !48, file: !1, line: 18, baseType: !24, size: 32, offset: 32)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !48, file: !1, line: 19, baseType: !21, size: 64, offset: 64)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !48, file: !1, line: 20, baseType: !13, size: 128, offset: 128)
!54 = !DILocation(line: 30, column: 15, scope: !9)
!55 = !DILocation(line: 30, column: 20, scope: !9)
!56 = !DILocalVariable(name: "s1ptr", scope: !9, file: !1, line: 31, type: !57)
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!58 = !DILocation(line: 31, column: 16, scope: !9)
!59 = !DILocation(line: 31, column: 24, scope: !9)
!60 = !DILocalVariable(name: "s2", scope: !9, file: !1, line: 32, type: !13)
!61 = !DILocation(line: 32, column: 15, scope: !9)
!62 = !DILocation(line: 32, column: 20, scope: !9)
!63 = !DILocalVariable(name: "s2ptr", scope: !9, file: !1, line: 33, type: !12)
!64 = !DILocation(line: 33, column: 16, scope: !9)
!65 = !DILocation(line: 33, column: 24, scope: !9)
!66 = !DILocalVariable(name: "ut2", scope: !9, file: !1, line: 34, type: !21)
!67 = !DILocation(line: 34, column: 11, scope: !9)
!68 = !DILocation(line: 34, column: 17, scope: !9)
!69 = !DILocation(line: 36, column: 5, scope: !9)
!70 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 38, type: !21)
!71 = !DILocation(line: 38, column: 11, scope: !9)
!72 = !DILocation(line: 38, column: 19, scope: !9)
!73 = !DILocation(line: 38, column: 22, scope: !9)
!74 = !DILocation(line: 38, column: 24, scope: !9)
!75 = !DILocalVariable(name: "ut3", scope: !9, file: !1, line: 39, type: !24)
!76 = !DILocation(line: 39, column: 9, scope: !9)
!77 = !DILocation(line: 39, column: 18, scope: !9)
!78 = !DILocation(line: 39, column: 21, scope: !9)
!79 = !DILocation(line: 39, column: 23, scope: !9)
!80 = !DILocalVariable(name: "t2", scope: !9, file: !1, line: 41, type: !21)
!81 = !DILocation(line: 41, column: 11, scope: !9)
!82 = !DILocation(line: 41, column: 16, scope: !9)
!83 = !DILocation(line: 41, column: 23, scope: !9)
!84 = !DILocation(line: 41, column: 26, scope: !9)
!85 = !DILocation(line: 41, column: 28, scope: !9)
!86 = !DILocalVariable(name: "ut4", scope: !9, file: !1, line: 42, type: !24)
!87 = !DILocation(line: 42, column: 9, scope: !9)
!88 = !DILocation(line: 42, column: 15, scope: !9)
!89 = !DILocation(line: 42, column: 22, scope: !9)
!90 = !DILocation(line: 42, column: 25, scope: !9)
!91 = !DILocation(line: 42, column: 27, scope: !9)
!92 = !DILocalVariable(name: "t3", scope: !9, file: !1, line: 44, type: !21)
!93 = !DILocation(line: 44, column: 11, scope: !9)
!94 = !DILocation(line: 44, column: 19, scope: !9)
!95 = !DILocation(line: 44, column: 21, scope: !9)
!96 = !DILocalVariable(name: "ut5", scope: !9, file: !1, line: 45, type: !24)
!97 = !DILocation(line: 45, column: 9, scope: !9)
!98 = !DILocation(line: 45, column: 18, scope: !9)
!99 = !DILocation(line: 45, column: 20, scope: !9)
!100 = !DILocalVariable(name: "t4", scope: !9, file: !1, line: 47, type: !21)
!101 = !DILocation(line: 47, column: 11, scope: !9)
!102 = !DILocation(line: 47, column: 16, scope: !9)
!103 = !DILocation(line: 47, column: 23, scope: !9)
!104 = !DILocation(line: 47, column: 25, scope: !9)
!105 = !DILocalVariable(name: "ut6", scope: !9, file: !1, line: 48, type: !24)
!106 = !DILocation(line: 48, column: 9, scope: !9)
!107 = !DILocation(line: 48, column: 15, scope: !9)
!108 = !DILocation(line: 48, column: 22, scope: !9)
!109 = !DILocation(line: 48, column: 24, scope: !9)
!110 = !DILocation(line: 50, column: 12, scope: !9)
!111 = !DILocation(line: 50, column: 5, scope: !9)
!112 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 54, type: !113, isLocal: false, isDefinition: true, scopeLine: 55, isOptimized: false, unit: !0, variables: !2)
!113 = !DISubroutineType(types: !114)
!114 = !{!24}
!115 = !DILocalVariable(name: "s1", scope: !112, file: !1, line: 56, type: !48)
!116 = !DILocation(line: 56, column: 15, scope: !112)
!117 = !DILocation(line: 57, column: 18, scope: !112)
!118 = !DILocation(line: 57, column: 8, scope: !112)
!119 = !DILocation(line: 57, column: 11, scope: !112)
!120 = !DILocation(line: 57, column: 13, scope: !112)
!121 = !DILocation(line: 57, column: 16, scope: !112)
!122 = !DILocalVariable(name: "s2", scope: !112, file: !1, line: 59, type: !12)
!123 = !DILocation(line: 59, column: 16, scope: !112)
!124 = !DILocation(line: 59, column: 46, scope: !112)
!125 = !DILocation(line: 59, column: 54, scope: !112)
!126 = !DILocation(line: 59, column: 21, scope: !112)
!127 = !DILocalVariable(name: "t1", scope: !112, file: !1, line: 61, type: !21)
!128 = !DILocation(line: 61, column: 11, scope: !112)
!129 = !DILocation(line: 61, column: 16, scope: !112)
!130 = !DILocation(line: 61, column: 20, scope: !112)
!131 = !DILocation(line: 61, column: 22, scope: !112)
!132 = !DILocalVariable(name: "ut1", scope: !112, file: !1, line: 62, type: !24)
!133 = !DILocation(line: 62, column: 9, scope: !112)
!134 = !DILocation(line: 62, column: 15, scope: !112)
!135 = !DILocation(line: 62, column: 19, scope: !112)
!136 = !DILocation(line: 62, column: 21, scope: !112)
!137 = !DILocalVariable(name: "rc", scope: !112, file: !1, line: 64, type: !24)
!138 = !DILocation(line: 64, column: 9, scope: !112)
!139 = !DILocation(line: 64, column: 14, scope: !112)
!140 = !DILocation(line: 64, column: 17, scope: !112)
!141 = !DILocation(line: 66, column: 12, scope: !112)
!142 = !DILocation(line: 66, column: 5, scope: !112)
