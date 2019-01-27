; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s2 = type { %struct.s3*, double }
%struct.s3 = type { i8*, i8* }
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
  %s3 = alloca %struct.s3, align 8
  %s3ptr = alloca %struct.s3*, align 8
  %ut2 = alloca i8*, align 8
  %t1 = alloca i8*, align 8
  %ut3 = alloca i8*, align 8
  %ut4 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %ut5 = alloca i8*, align 8
  %ut6 = alloca i8*, align 8
  %t3 = alloca i8*, align 8
  %ut7 = alloca i8*, align 8
  %t4 = alloca i8*, align 8
  %ut8 = alloca i8*, align 8
  %t5 = alloca i8*, align 8
  %ut9 = alloca i8*, align 8
  %t6 = alloca i8*, align 8
  %ut10 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !26, metadata !27), !dbg !28
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !29, metadata !27), !dbg !43
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !44
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !44
  call void @llvm.va_start(i8* %arraydecay1), !dbg !44
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !45, metadata !27), !dbg !46
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !47
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !47
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !47
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !47
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !47

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !47
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !47
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !47
  %2 = bitcast i8* %1 to i32*, !dbg !47
  %3 = add i32 %gp_offset, 8, !dbg !47
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !47
  br label %vaarg.end, !dbg !47

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !47
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !47
  %4 = bitcast i8* %overflow_arg_area to i32*, !dbg !47
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !47
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !47
  br label %vaarg.end, !dbg !47

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i32* [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !47
  %5 = load i32, i32* %vaarg.addr, align 4, !dbg !47
  store i32 %5, i32* %ut1, align 4, !dbg !46
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !48, metadata !27), !dbg !55
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !56
  %overflow_arg_area_p4 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !56
  %overflow_arg_area5 = load i8*, i8** %overflow_arg_area_p4, align 8, !dbg !56
  %6 = bitcast i8* %overflow_arg_area5 to %struct.s1*, !dbg !56
  %overflow_arg_area.next6 = getelementptr i8, i8* %overflow_arg_area5, i32 32, !dbg !56
  store i8* %overflow_arg_area.next6, i8** %overflow_arg_area_p4, align 8, !dbg !56
  %7 = bitcast %struct.s1* %s1 to i8*, !dbg !56
  %8 = bitcast %struct.s1* %6 to i8*, !dbg !56
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* %8, i64 32, i32 8, i1 false), !dbg !56
  call void @llvm.dbg.declare(metadata %struct.s1** %s1ptr, metadata !57, metadata !27), !dbg !59
  %arraydecay7 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !60
  %gp_offset_p8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay7, i32 0, i32 0, !dbg !60
  %gp_offset9 = load i32, i32* %gp_offset_p8, align 16, !dbg !60
  %fits_in_gp10 = icmp ule i32 %gp_offset9, 40, !dbg !60
  br i1 %fits_in_gp10, label %vaarg.in_reg11, label %vaarg.in_mem13, !dbg !60

vaarg.in_reg11:                                   ; preds = %vaarg.end
  %9 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay7, i32 0, i32 3, !dbg !60
  %reg_save_area12 = load i8*, i8** %9, align 16, !dbg !60
  %10 = getelementptr i8, i8* %reg_save_area12, i32 %gp_offset9, !dbg !60
  %11 = bitcast i8* %10 to %struct.s1**, !dbg !60
  %12 = add i32 %gp_offset9, 8, !dbg !60
  store i32 %12, i32* %gp_offset_p8, align 16, !dbg !60
  br label %vaarg.end17, !dbg !60

vaarg.in_mem13:                                   ; preds = %vaarg.end
  %overflow_arg_area_p14 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay7, i32 0, i32 2, !dbg !60
  %overflow_arg_area15 = load i8*, i8** %overflow_arg_area_p14, align 8, !dbg !60
  %13 = bitcast i8* %overflow_arg_area15 to %struct.s1**, !dbg !60
  %overflow_arg_area.next16 = getelementptr i8, i8* %overflow_arg_area15, i32 8, !dbg !60
  store i8* %overflow_arg_area.next16, i8** %overflow_arg_area_p14, align 8, !dbg !60
  br label %vaarg.end17, !dbg !60

vaarg.end17:                                      ; preds = %vaarg.in_mem13, %vaarg.in_reg11
  %vaarg.addr18 = phi %struct.s1** [ %11, %vaarg.in_reg11 ], [ %13, %vaarg.in_mem13 ], !dbg !60
  %14 = load %struct.s1*, %struct.s1** %vaarg.addr18, align 8, !dbg !60
  store %struct.s1* %14, %struct.s1** %s1ptr, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !61, metadata !27), !dbg !62
  %arraydecay19 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !63
  %gp_offset_p20 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 0, !dbg !63
  %gp_offset21 = load i32, i32* %gp_offset_p20, align 16, !dbg !63
  %fits_in_gp22 = icmp ule i32 %gp_offset21, 40, !dbg !63
  %fp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 1, !dbg !63
  %fp_offset = load i32, i32* %fp_offset_p, align 4, !dbg !63
  %fits_in_fp = icmp ule i32 %fp_offset, 160, !dbg !63
  %15 = and i1 %fits_in_gp22, %fits_in_fp, !dbg !63
  br i1 %15, label %vaarg.in_reg23, label %vaarg.in_mem25, !dbg !63

vaarg.in_reg23:                                   ; preds = %vaarg.end17
  %16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 3, !dbg !63
  %reg_save_area24 = load i8*, i8** %16, align 16, !dbg !63
  %17 = bitcast %struct.s2* %tmp to { %struct.s3*, double }*, !dbg !63
  %18 = getelementptr i8, i8* %reg_save_area24, i32 %gp_offset21, !dbg !63
  %19 = getelementptr i8, i8* %reg_save_area24, i32 %fp_offset, !dbg !63
  %20 = bitcast i8* %18 to %struct.s3**, !dbg !63
  %21 = load %struct.s3*, %struct.s3** %20, align 8, !dbg !63
  %22 = getelementptr inbounds { %struct.s3*, double }, { %struct.s3*, double }* %17, i32 0, i32 0, !dbg !63
  store %struct.s3* %21, %struct.s3** %22, align 8, !dbg !63
  %23 = bitcast i8* %19 to double*, !dbg !63
  %24 = load double, double* %23, align 8, !dbg !63
  %25 = getelementptr inbounds { %struct.s3*, double }, { %struct.s3*, double }* %17, i32 0, i32 1, !dbg !63
  store double %24, double* %25, align 8, !dbg !63
  %26 = bitcast { %struct.s3*, double }* %17 to %struct.s2*, !dbg !63
  %27 = add i32 %gp_offset21, 8, !dbg !63
  store i32 %27, i32* %gp_offset_p20, align 16, !dbg !63
  %28 = add i32 %fp_offset, 16, !dbg !63
  store i32 %28, i32* %fp_offset_p, align 4, !dbg !63
  br label %vaarg.end29, !dbg !63

vaarg.in_mem25:                                   ; preds = %vaarg.end17
  %overflow_arg_area_p26 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay19, i32 0, i32 2, !dbg !63
  %overflow_arg_area27 = load i8*, i8** %overflow_arg_area_p26, align 8, !dbg !63
  %29 = bitcast i8* %overflow_arg_area27 to %struct.s2*, !dbg !63
  %overflow_arg_area.next28 = getelementptr i8, i8* %overflow_arg_area27, i32 16, !dbg !63
  store i8* %overflow_arg_area.next28, i8** %overflow_arg_area_p26, align 8, !dbg !63
  br label %vaarg.end29, !dbg !63

vaarg.end29:                                      ; preds = %vaarg.in_mem25, %vaarg.in_reg23
  %vaarg.addr30 = phi %struct.s2* [ %26, %vaarg.in_reg23 ], [ %29, %vaarg.in_mem25 ], !dbg !63
  %30 = bitcast %struct.s2* %s2 to i8*, !dbg !63
  %31 = bitcast %struct.s2* %vaarg.addr30 to i8*, !dbg !63
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %30, i8* %31, i64 16, i32 8, i1 false), !dbg !63
  call void @llvm.dbg.declare(metadata %struct.s2** %s2ptr, metadata !64, metadata !27), !dbg !65
  %arraydecay31 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !66
  %gp_offset_p32 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay31, i32 0, i32 0, !dbg !66
  %gp_offset33 = load i32, i32* %gp_offset_p32, align 16, !dbg !66
  %fits_in_gp34 = icmp ule i32 %gp_offset33, 40, !dbg !66
  br i1 %fits_in_gp34, label %vaarg.in_reg35, label %vaarg.in_mem37, !dbg !66

vaarg.in_reg35:                                   ; preds = %vaarg.end29
  %32 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay31, i32 0, i32 3, !dbg !66
  %reg_save_area36 = load i8*, i8** %32, align 16, !dbg !66
  %33 = getelementptr i8, i8* %reg_save_area36, i32 %gp_offset33, !dbg !66
  %34 = bitcast i8* %33 to %struct.s2**, !dbg !66
  %35 = add i32 %gp_offset33, 8, !dbg !66
  store i32 %35, i32* %gp_offset_p32, align 16, !dbg !66
  br label %vaarg.end41, !dbg !66

vaarg.in_mem37:                                   ; preds = %vaarg.end29
  %overflow_arg_area_p38 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay31, i32 0, i32 2, !dbg !66
  %overflow_arg_area39 = load i8*, i8** %overflow_arg_area_p38, align 8, !dbg !66
  %36 = bitcast i8* %overflow_arg_area39 to %struct.s2**, !dbg !66
  %overflow_arg_area.next40 = getelementptr i8, i8* %overflow_arg_area39, i32 8, !dbg !66
  store i8* %overflow_arg_area.next40, i8** %overflow_arg_area_p38, align 8, !dbg !66
  br label %vaarg.end41, !dbg !66

vaarg.end41:                                      ; preds = %vaarg.in_mem37, %vaarg.in_reg35
  %vaarg.addr42 = phi %struct.s2** [ %34, %vaarg.in_reg35 ], [ %36, %vaarg.in_mem37 ], !dbg !66
  %37 = load %struct.s2*, %struct.s2** %vaarg.addr42, align 8, !dbg !66
  store %struct.s2* %37, %struct.s2** %s2ptr, align 8, !dbg !65
  call void @llvm.dbg.declare(metadata %struct.s3* %s3, metadata !67, metadata !27), !dbg !68
  %arraydecay43 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !69
  %gp_offset_p44 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay43, i32 0, i32 0, !dbg !69
  %gp_offset45 = load i32, i32* %gp_offset_p44, align 16, !dbg !69
  %fits_in_gp46 = icmp ule i32 %gp_offset45, 32, !dbg !69
  br i1 %fits_in_gp46, label %vaarg.in_reg47, label %vaarg.in_mem49, !dbg !69

vaarg.in_reg47:                                   ; preds = %vaarg.end41
  %38 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay43, i32 0, i32 3, !dbg !69
  %reg_save_area48 = load i8*, i8** %38, align 16, !dbg !69
  %39 = getelementptr i8, i8* %reg_save_area48, i32 %gp_offset45, !dbg !69
  %40 = bitcast i8* %39 to %struct.s3*, !dbg !69
  %41 = add i32 %gp_offset45, 16, !dbg !69
  store i32 %41, i32* %gp_offset_p44, align 16, !dbg !69
  br label %vaarg.end53, !dbg !69

vaarg.in_mem49:                                   ; preds = %vaarg.end41
  %overflow_arg_area_p50 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay43, i32 0, i32 2, !dbg !69
  %overflow_arg_area51 = load i8*, i8** %overflow_arg_area_p50, align 8, !dbg !69
  %42 = bitcast i8* %overflow_arg_area51 to %struct.s3*, !dbg !69
  %overflow_arg_area.next52 = getelementptr i8, i8* %overflow_arg_area51, i32 16, !dbg !69
  store i8* %overflow_arg_area.next52, i8** %overflow_arg_area_p50, align 8, !dbg !69
  br label %vaarg.end53, !dbg !69

vaarg.end53:                                      ; preds = %vaarg.in_mem49, %vaarg.in_reg47
  %vaarg.addr54 = phi %struct.s3* [ %40, %vaarg.in_reg47 ], [ %42, %vaarg.in_mem49 ], !dbg !69
  %43 = bitcast %struct.s3* %s3 to i8*, !dbg !69
  %44 = bitcast %struct.s3* %vaarg.addr54 to i8*, !dbg !69
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %43, i8* %44, i64 16, i32 8, i1 false), !dbg !69
  call void @llvm.dbg.declare(metadata %struct.s3** %s3ptr, metadata !70, metadata !27), !dbg !71
  %arraydecay55 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !72
  %gp_offset_p56 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay55, i32 0, i32 0, !dbg !72
  %gp_offset57 = load i32, i32* %gp_offset_p56, align 16, !dbg !72
  %fits_in_gp58 = icmp ule i32 %gp_offset57, 40, !dbg !72
  br i1 %fits_in_gp58, label %vaarg.in_reg59, label %vaarg.in_mem61, !dbg !72

vaarg.in_reg59:                                   ; preds = %vaarg.end53
  %45 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay55, i32 0, i32 3, !dbg !72
  %reg_save_area60 = load i8*, i8** %45, align 16, !dbg !72
  %46 = getelementptr i8, i8* %reg_save_area60, i32 %gp_offset57, !dbg !72
  %47 = bitcast i8* %46 to %struct.s3**, !dbg !72
  %48 = add i32 %gp_offset57, 8, !dbg !72
  store i32 %48, i32* %gp_offset_p56, align 16, !dbg !72
  br label %vaarg.end65, !dbg !72

vaarg.in_mem61:                                   ; preds = %vaarg.end53
  %overflow_arg_area_p62 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay55, i32 0, i32 2, !dbg !72
  %overflow_arg_area63 = load i8*, i8** %overflow_arg_area_p62, align 8, !dbg !72
  %49 = bitcast i8* %overflow_arg_area63 to %struct.s3**, !dbg !72
  %overflow_arg_area.next64 = getelementptr i8, i8* %overflow_arg_area63, i32 8, !dbg !72
  store i8* %overflow_arg_area.next64, i8** %overflow_arg_area_p62, align 8, !dbg !72
  br label %vaarg.end65, !dbg !72

vaarg.end65:                                      ; preds = %vaarg.in_mem61, %vaarg.in_reg59
  %vaarg.addr66 = phi %struct.s3** [ %47, %vaarg.in_reg59 ], [ %49, %vaarg.in_mem61 ], !dbg !72
  %50 = load %struct.s3*, %struct.s3** %vaarg.addr66, align 8, !dbg !72
  store %struct.s3* %50, %struct.s3** %s3ptr, align 8, !dbg !71
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !73, metadata !27), !dbg !74
  %arraydecay67 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !75
  %gp_offset_p68 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay67, i32 0, i32 0, !dbg !75
  %gp_offset69 = load i32, i32* %gp_offset_p68, align 16, !dbg !75
  %fits_in_gp70 = icmp ule i32 %gp_offset69, 40, !dbg !75
  br i1 %fits_in_gp70, label %vaarg.in_reg71, label %vaarg.in_mem73, !dbg !75

vaarg.in_reg71:                                   ; preds = %vaarg.end65
  %51 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay67, i32 0, i32 3, !dbg !75
  %reg_save_area72 = load i8*, i8** %51, align 16, !dbg !75
  %52 = getelementptr i8, i8* %reg_save_area72, i32 %gp_offset69, !dbg !75
  %53 = bitcast i8* %52 to i8**, !dbg !75
  %54 = add i32 %gp_offset69, 8, !dbg !75
  store i32 %54, i32* %gp_offset_p68, align 16, !dbg !75
  br label %vaarg.end77, !dbg !75

vaarg.in_mem73:                                   ; preds = %vaarg.end65
  %overflow_arg_area_p74 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay67, i32 0, i32 2, !dbg !75
  %overflow_arg_area75 = load i8*, i8** %overflow_arg_area_p74, align 8, !dbg !75
  %55 = bitcast i8* %overflow_arg_area75 to i8**, !dbg !75
  %overflow_arg_area.next76 = getelementptr i8, i8* %overflow_arg_area75, i32 8, !dbg !75
  store i8* %overflow_arg_area.next76, i8** %overflow_arg_area_p74, align 8, !dbg !75
  br label %vaarg.end77, !dbg !75

vaarg.end77:                                      ; preds = %vaarg.in_mem73, %vaarg.in_reg71
  %vaarg.addr78 = phi i8** [ %53, %vaarg.in_reg71 ], [ %55, %vaarg.in_mem73 ], !dbg !75
  %56 = load i8*, i8** %vaarg.addr78, align 8, !dbg !75
  store i8* %56, i8** %ut2, align 8, !dbg !74
  %arraydecay79 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !76
  %arraydecay7980 = bitcast %struct.__va_list_tag* %arraydecay79 to i8*, !dbg !76
  call void @llvm.va_end(i8* %arraydecay7980), !dbg !76
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !77, metadata !27), !dbg !78
  %s281 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !79
  %s382 = getelementptr inbounds %struct.s2, %struct.s2* %s281, i32 0, i32 0, !dbg !80
  %57 = load %struct.s3*, %struct.s3** %s382, align 8, !dbg !80
  %t183 = getelementptr inbounds %struct.s3, %struct.s3* %57, i32 0, i32 0, !dbg !81
  %58 = load i8*, i8** %t183, align 8, !dbg !81
  store i8* %58, i8** %t1, align 8, !dbg !78
  call void @llvm.dbg.declare(metadata i8** %ut3, metadata !82, metadata !27), !dbg !83
  %t184 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !84
  %59 = load i8*, i8** %t184, align 8, !dbg !84
  store i8* %59, i8** %ut3, align 8, !dbg !83
  call void @llvm.dbg.declare(metadata i8** %ut4, metadata !85, metadata !27), !dbg !86
  %s285 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !87
  %s386 = getelementptr inbounds %struct.s2, %struct.s2* %s285, i32 0, i32 0, !dbg !88
  %60 = load %struct.s3*, %struct.s3** %s386, align 8, !dbg !88
  %ut187 = getelementptr inbounds %struct.s3, %struct.s3* %60, i32 0, i32 1, !dbg !89
  %61 = load i8*, i8** %ut187, align 8, !dbg !89
  store i8* %61, i8** %ut4, align 8, !dbg !86
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !90, metadata !27), !dbg !91
  %62 = load %struct.s1*, %struct.s1** %s1ptr, align 8, !dbg !92
  %s288 = getelementptr inbounds %struct.s1, %struct.s1* %62, i32 0, i32 3, !dbg !93
  %s389 = getelementptr inbounds %struct.s2, %struct.s2* %s288, i32 0, i32 0, !dbg !94
  %63 = load %struct.s3*, %struct.s3** %s389, align 8, !dbg !94
  %t190 = getelementptr inbounds %struct.s3, %struct.s3* %63, i32 0, i32 0, !dbg !95
  %64 = load i8*, i8** %t190, align 8, !dbg !95
  store i8* %64, i8** %t2, align 8, !dbg !91
  call void @llvm.dbg.declare(metadata i8** %ut5, metadata !96, metadata !27), !dbg !97
  %65 = load %struct.s1*, %struct.s1** %s1ptr, align 8, !dbg !98
  %t191 = getelementptr inbounds %struct.s1, %struct.s1* %65, i32 0, i32 2, !dbg !99
  %66 = load i8*, i8** %t191, align 8, !dbg !99
  store i8* %66, i8** %ut5, align 8, !dbg !97
  call void @llvm.dbg.declare(metadata i8** %ut6, metadata !100, metadata !27), !dbg !101
  %67 = load %struct.s1*, %struct.s1** %s1ptr, align 8, !dbg !102
  %s292 = getelementptr inbounds %struct.s1, %struct.s1* %67, i32 0, i32 3, !dbg !103
  %s393 = getelementptr inbounds %struct.s2, %struct.s2* %s292, i32 0, i32 0, !dbg !104
  %68 = load %struct.s3*, %struct.s3** %s393, align 8, !dbg !104
  %ut194 = getelementptr inbounds %struct.s3, %struct.s3* %68, i32 0, i32 1, !dbg !105
  %69 = load i8*, i8** %ut194, align 8, !dbg !105
  store i8* %69, i8** %ut6, align 8, !dbg !101
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !106, metadata !27), !dbg !107
  %s395 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !108
  %70 = load %struct.s3*, %struct.s3** %s395, align 8, !dbg !108
  %t196 = getelementptr inbounds %struct.s3, %struct.s3* %70, i32 0, i32 0, !dbg !109
  %71 = load i8*, i8** %t196, align 8, !dbg !109
  store i8* %71, i8** %t3, align 8, !dbg !107
  call void @llvm.dbg.declare(metadata i8** %ut7, metadata !110, metadata !27), !dbg !111
  %s397 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !112
  %72 = load %struct.s3*, %struct.s3** %s397, align 8, !dbg !112
  %ut198 = getelementptr inbounds %struct.s3, %struct.s3* %72, i32 0, i32 1, !dbg !113
  %73 = load i8*, i8** %ut198, align 8, !dbg !113
  store i8* %73, i8** %ut7, align 8, !dbg !111
  call void @llvm.dbg.declare(metadata i8** %t4, metadata !114, metadata !27), !dbg !115
  %74 = load %struct.s2*, %struct.s2** %s2ptr, align 8, !dbg !116
  %s399 = getelementptr inbounds %struct.s2, %struct.s2* %74, i32 0, i32 0, !dbg !117
  %75 = load %struct.s3*, %struct.s3** %s399, align 8, !dbg !117
  %t1100 = getelementptr inbounds %struct.s3, %struct.s3* %75, i32 0, i32 0, !dbg !118
  %76 = load i8*, i8** %t1100, align 8, !dbg !118
  store i8* %76, i8** %t4, align 8, !dbg !115
  call void @llvm.dbg.declare(metadata i8** %ut8, metadata !119, metadata !27), !dbg !120
  %77 = load %struct.s2*, %struct.s2** %s2ptr, align 8, !dbg !121
  %s3101 = getelementptr inbounds %struct.s2, %struct.s2* %77, i32 0, i32 0, !dbg !122
  %78 = load %struct.s3*, %struct.s3** %s3101, align 8, !dbg !122
  %ut1102 = getelementptr inbounds %struct.s3, %struct.s3* %78, i32 0, i32 1, !dbg !123
  %79 = load i8*, i8** %ut1102, align 8, !dbg !123
  store i8* %79, i8** %ut8, align 8, !dbg !120
  call void @llvm.dbg.declare(metadata i8** %t5, metadata !124, metadata !27), !dbg !125
  %t1103 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 0, !dbg !126
  %80 = load i8*, i8** %t1103, align 8, !dbg !126
  store i8* %80, i8** %t5, align 8, !dbg !125
  call void @llvm.dbg.declare(metadata i8** %ut9, metadata !127, metadata !27), !dbg !128
  %ut1104 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 1, !dbg !129
  %81 = load i8*, i8** %ut1104, align 8, !dbg !129
  store i8* %81, i8** %ut9, align 8, !dbg !128
  call void @llvm.dbg.declare(metadata i8** %t6, metadata !130, metadata !27), !dbg !131
  %82 = load %struct.s3*, %struct.s3** %s3ptr, align 8, !dbg !132
  %t1105 = getelementptr inbounds %struct.s3, %struct.s3* %82, i32 0, i32 0, !dbg !133
  %83 = load i8*, i8** %t1105, align 8, !dbg !133
  store i8* %83, i8** %t6, align 8, !dbg !131
  call void @llvm.dbg.declare(metadata i8** %ut10, metadata !134, metadata !27), !dbg !135
  %84 = load %struct.s3*, %struct.s3** %s3ptr, align 8, !dbg !136
  %ut1106 = getelementptr inbounds %struct.s3, %struct.s3* %84, i32 0, i32 1, !dbg !137
  %85 = load i8*, i8** %ut1106, align 8, !dbg !137
  store i8* %85, i8** %ut10, align 8, !dbg !135
  %86 = load %struct.s2*, %struct.s2** %s2ptr, align 8, !dbg !138
  ret %struct.s2* %86, !dbg !139
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
define i32 @main() #0 !dbg !140 {
entry:
  %retval = alloca i32, align 4
  %s3 = alloca %struct.s3, align 8
  %s1 = alloca %struct.s1, align 8
  %s22 = alloca %struct.s2*, align 8
  %t16 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s3* %s3, metadata !143, metadata !27), !dbg !144
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !145
  %t1 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 0, !dbg !146
  store i8* %call, i8** %t1, align 8, !dbg !147
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !148, metadata !27), !dbg !149
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !150
  %s31 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !151
  store %struct.s3* %s3, %struct.s3** %s31, align 8, !dbg !152
  call void @llvm.dbg.declare(metadata %struct.s2** %s22, metadata !153, metadata !27), !dbg !154
  %s23 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !155
  %s24 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 3, !dbg !156
  %0 = bitcast %struct.s2* %s23 to { %struct.s3*, double }*, !dbg !157
  %1 = getelementptr inbounds { %struct.s3*, double }, { %struct.s3*, double }* %0, i32 0, i32 0, !dbg !157
  %2 = load %struct.s3*, %struct.s3** %1, align 8, !dbg !157
  %3 = getelementptr inbounds { %struct.s3*, double }, { %struct.s3*, double }* %0, i32 0, i32 1, !dbg !157
  %4 = load double, double* %3, align 8, !dbg !157
  %call5 = call %struct.s2* (i32, ...) @foo(i32 8, i32 4711, %struct.s1* byval align 8 %s1, %struct.s1* %s1, %struct.s3* %2, double %4, %struct.s2* %s24, %struct.s3* byval align 8 %s3, %struct.s3* %s3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0)), !dbg !157
  store %struct.s2* %call5, %struct.s2** %s22, align 8, !dbg !154
  call void @llvm.dbg.declare(metadata i8** %t16, metadata !158, metadata !27), !dbg !159
  %5 = load %struct.s2*, %struct.s2** %s22, align 8, !dbg !160
  %s37 = getelementptr inbounds %struct.s2, %struct.s2* %5, i32 0, i32 0, !dbg !161
  %6 = load %struct.s3*, %struct.s3** %s37, align 8, !dbg !161
  %t18 = getelementptr inbounds %struct.s3, %struct.s3* %6, i32 0, i32 0, !dbg !162
  %7 = load i8*, i8** %t18, align 8, !dbg !162
  store i8* %7, i8** %t16, align 8, !dbg !159
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !163, metadata !27), !dbg !164
  %8 = load %struct.s2*, %struct.s2** %s22, align 8, !dbg !165
  %s39 = getelementptr inbounds %struct.s2, %struct.s2* %8, i32 0, i32 0, !dbg !166
  %9 = load %struct.s3*, %struct.s3** %s39, align 8, !dbg !166
  %ut110 = getelementptr inbounds %struct.s3, %struct.s3* %9, i32 0, i32 1, !dbg !167
  %10 = load i8*, i8** %ut110, align 8, !dbg !167
  store i8* %10, i8** %ut1, align 8, !dbg !164
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !168, metadata !27), !dbg !169
  %11 = load i8*, i8** %t16, align 8, !dbg !170
  %cmp = icmp ne i8* %11, null, !dbg !171
  %conv = zext i1 %cmp to i32, !dbg !171
  store i32 %conv, i32* %rc, align 4, !dbg !169
  %12 = load i32, i32* %rc, align 4, !dbg !172
  ret i32 %12, !dbg !173
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-13")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 24, type: !10, isLocal: false, isDefinition: true, scopeLine: 25, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !25, null}
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 11, size: 128, elements: !14)
!14 = !{!15, !23}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !13, file: !1, line: 12, baseType: !16, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 6, size: 128, elements: !18)
!18 = !{!19, !22}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !17, file: !1, line: 7, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "ut1", scope: !17, file: !1, line: 8, baseType: !20, size: 64, offset: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "i", scope: !13, file: !1, line: 13, baseType: !24, size: 64, offset: 64)
!24 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!25 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!26 = !DILocalVariable(name: "n", arg: 1, scope: !9, file: !1, line: 24, type: !25)
!27 = !DIExpression()
!28 = !DILocation(line: 24, column: 9, scope: !9)
!29 = !DILocalVariable(name: "ap", scope: !9, file: !1, line: 26, type: !30)
!30 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !31, line: 30, baseType: !32)
!31 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-13")
!32 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 26, baseType: !33)
!33 = !DICompositeType(tag: DW_TAG_array_type, baseType: !34, size: 192, elements: !41)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 26, size: 192, elements: !35)
!35 = !{!36, !38, !39, !40}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !34, file: !1, line: 26, baseType: !37, size: 32)
!37 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !34, file: !1, line: 26, baseType: !37, size: 32, offset: 32)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !34, file: !1, line: 26, baseType: !4, size: 64, offset: 64)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !34, file: !1, line: 26, baseType: !4, size: 64, offset: 128)
!41 = !{!42}
!42 = !DISubrange(count: 1)
!43 = !DILocation(line: 26, column: 13, scope: !9)
!44 = !DILocation(line: 27, column: 5, scope: !9)
!45 = !DILocalVariable(name: "ut1", scope: !9, file: !1, line: 29, type: !25)
!46 = !DILocation(line: 29, column: 9, scope: !9)
!47 = !DILocation(line: 29, column: 15, scope: !9)
!48 = !DILocalVariable(name: "s1", scope: !9, file: !1, line: 30, type: !49)
!49 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 16, size: 256, elements: !50)
!50 = !{!51, !52, !53, !54}
!51 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !49, file: !1, line: 17, baseType: !25, size: 32)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !49, file: !1, line: 18, baseType: !25, size: 32, offset: 32)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !49, file: !1, line: 19, baseType: !20, size: 64, offset: 64)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !49, file: !1, line: 20, baseType: !13, size: 128, offset: 128)
!55 = !DILocation(line: 30, column: 15, scope: !9)
!56 = !DILocation(line: 30, column: 20, scope: !9)
!57 = !DILocalVariable(name: "s1ptr", scope: !9, file: !1, line: 31, type: !58)
!58 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!59 = !DILocation(line: 31, column: 16, scope: !9)
!60 = !DILocation(line: 31, column: 24, scope: !9)
!61 = !DILocalVariable(name: "s2", scope: !9, file: !1, line: 32, type: !13)
!62 = !DILocation(line: 32, column: 15, scope: !9)
!63 = !DILocation(line: 32, column: 20, scope: !9)
!64 = !DILocalVariable(name: "s2ptr", scope: !9, file: !1, line: 33, type: !12)
!65 = !DILocation(line: 33, column: 16, scope: !9)
!66 = !DILocation(line: 33, column: 24, scope: !9)
!67 = !DILocalVariable(name: "s3", scope: !9, file: !1, line: 34, type: !17)
!68 = !DILocation(line: 34, column: 15, scope: !9)
!69 = !DILocation(line: 34, column: 20, scope: !9)
!70 = !DILocalVariable(name: "s3ptr", scope: !9, file: !1, line: 35, type: !16)
!71 = !DILocation(line: 35, column: 16, scope: !9)
!72 = !DILocation(line: 35, column: 24, scope: !9)
!73 = !DILocalVariable(name: "ut2", scope: !9, file: !1, line: 36, type: !20)
!74 = !DILocation(line: 36, column: 11, scope: !9)
!75 = !DILocation(line: 36, column: 17, scope: !9)
!76 = !DILocation(line: 38, column: 5, scope: !9)
!77 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 40, type: !20)
!78 = !DILocation(line: 40, column: 11, scope: !9)
!79 = !DILocation(line: 40, column: 19, scope: !9)
!80 = !DILocation(line: 40, column: 22, scope: !9)
!81 = !DILocation(line: 40, column: 26, scope: !9)
!82 = !DILocalVariable(name: "ut3", scope: !9, file: !1, line: 41, type: !20)
!83 = !DILocation(line: 41, column: 11, scope: !9)
!84 = !DILocation(line: 41, column: 20, scope: !9)
!85 = !DILocalVariable(name: "ut4", scope: !9, file: !1, line: 42, type: !20)
!86 = !DILocation(line: 42, column: 11, scope: !9)
!87 = !DILocation(line: 42, column: 20, scope: !9)
!88 = !DILocation(line: 42, column: 23, scope: !9)
!89 = !DILocation(line: 42, column: 27, scope: !9)
!90 = !DILocalVariable(name: "t2", scope: !9, file: !1, line: 44, type: !20)
!91 = !DILocation(line: 44, column: 11, scope: !9)
!92 = !DILocation(line: 44, column: 16, scope: !9)
!93 = !DILocation(line: 44, column: 23, scope: !9)
!94 = !DILocation(line: 44, column: 26, scope: !9)
!95 = !DILocation(line: 44, column: 30, scope: !9)
!96 = !DILocalVariable(name: "ut5", scope: !9, file: !1, line: 45, type: !20)
!97 = !DILocation(line: 45, column: 11, scope: !9)
!98 = !DILocation(line: 45, column: 17, scope: !9)
!99 = !DILocation(line: 45, column: 24, scope: !9)
!100 = !DILocalVariable(name: "ut6", scope: !9, file: !1, line: 46, type: !20)
!101 = !DILocation(line: 46, column: 11, scope: !9)
!102 = !DILocation(line: 46, column: 17, scope: !9)
!103 = !DILocation(line: 46, column: 24, scope: !9)
!104 = !DILocation(line: 46, column: 27, scope: !9)
!105 = !DILocation(line: 46, column: 31, scope: !9)
!106 = !DILocalVariable(name: "t3", scope: !9, file: !1, line: 48, type: !20)
!107 = !DILocation(line: 48, column: 11, scope: !9)
!108 = !DILocation(line: 48, column: 19, scope: !9)
!109 = !DILocation(line: 48, column: 23, scope: !9)
!110 = !DILocalVariable(name: "ut7", scope: !9, file: !1, line: 49, type: !20)
!111 = !DILocation(line: 49, column: 11, scope: !9)
!112 = !DILocation(line: 49, column: 20, scope: !9)
!113 = !DILocation(line: 49, column: 24, scope: !9)
!114 = !DILocalVariable(name: "t4", scope: !9, file: !1, line: 51, type: !20)
!115 = !DILocation(line: 51, column: 11, scope: !9)
!116 = !DILocation(line: 51, column: 16, scope: !9)
!117 = !DILocation(line: 51, column: 23, scope: !9)
!118 = !DILocation(line: 51, column: 27, scope: !9)
!119 = !DILocalVariable(name: "ut8", scope: !9, file: !1, line: 52, type: !20)
!120 = !DILocation(line: 52, column: 11, scope: !9)
!121 = !DILocation(line: 52, column: 17, scope: !9)
!122 = !DILocation(line: 52, column: 24, scope: !9)
!123 = !DILocation(line: 52, column: 28, scope: !9)
!124 = !DILocalVariable(name: "t5", scope: !9, file: !1, line: 54, type: !20)
!125 = !DILocation(line: 54, column: 11, scope: !9)
!126 = !DILocation(line: 54, column: 19, scope: !9)
!127 = !DILocalVariable(name: "ut9", scope: !9, file: !1, line: 55, type: !20)
!128 = !DILocation(line: 55, column: 11, scope: !9)
!129 = !DILocation(line: 55, column: 20, scope: !9)
!130 = !DILocalVariable(name: "t6", scope: !9, file: !1, line: 57, type: !20)
!131 = !DILocation(line: 57, column: 11, scope: !9)
!132 = !DILocation(line: 57, column: 16, scope: !9)
!133 = !DILocation(line: 57, column: 23, scope: !9)
!134 = !DILocalVariable(name: "ut10", scope: !9, file: !1, line: 58, type: !20)
!135 = !DILocation(line: 58, column: 11, scope: !9)
!136 = !DILocation(line: 58, column: 18, scope: !9)
!137 = !DILocation(line: 58, column: 25, scope: !9)
!138 = !DILocation(line: 60, column: 12, scope: !9)
!139 = !DILocation(line: 60, column: 5, scope: !9)
!140 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 64, type: !141, isLocal: false, isDefinition: true, scopeLine: 65, isOptimized: false, unit: !0, variables: !2)
!141 = !DISubroutineType(types: !142)
!142 = !{!25}
!143 = !DILocalVariable(name: "s3", scope: !140, file: !1, line: 66, type: !17)
!144 = !DILocation(line: 66, column: 15, scope: !140)
!145 = !DILocation(line: 67, column: 13, scope: !140)
!146 = !DILocation(line: 67, column: 8, scope: !140)
!147 = !DILocation(line: 67, column: 11, scope: !140)
!148 = !DILocalVariable(name: "s1", scope: !140, file: !1, line: 69, type: !49)
!149 = !DILocation(line: 69, column: 15, scope: !140)
!150 = !DILocation(line: 70, column: 8, scope: !140)
!151 = !DILocation(line: 70, column: 11, scope: !140)
!152 = !DILocation(line: 70, column: 14, scope: !140)
!153 = !DILocalVariable(name: "s2", scope: !140, file: !1, line: 72, type: !12)
!154 = !DILocation(line: 72, column: 16, scope: !140)
!155 = !DILocation(line: 72, column: 46, scope: !140)
!156 = !DILocation(line: 72, column: 54, scope: !140)
!157 = !DILocation(line: 72, column: 21, scope: !140)
!158 = !DILocalVariable(name: "t1", scope: !140, file: !1, line: 74, type: !20)
!159 = !DILocation(line: 74, column: 11, scope: !140)
!160 = !DILocation(line: 74, column: 16, scope: !140)
!161 = !DILocation(line: 74, column: 20, scope: !140)
!162 = !DILocation(line: 74, column: 24, scope: !140)
!163 = !DILocalVariable(name: "ut1", scope: !140, file: !1, line: 75, type: !20)
!164 = !DILocation(line: 75, column: 11, scope: !140)
!165 = !DILocation(line: 75, column: 17, scope: !140)
!166 = !DILocation(line: 75, column: 21, scope: !140)
!167 = !DILocation(line: 75, column: 25, scope: !140)
!168 = !DILocalVariable(name: "rc", scope: !140, file: !1, line: 77, type: !25)
!169 = !DILocation(line: 77, column: 9, scope: !140)
!170 = !DILocation(line: 77, column: 14, scope: !140)
!171 = !DILocation(line: 77, column: 17, scope: !140)
!172 = !DILocation(line: 79, column: 12, scope: !140)
!173 = !DILocation(line: 79, column: 5, scope: !140)
