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
define i32 @user(%struct.s2* %s2, %struct.__va_list_tag* %args) #0 !dbg !7 {
entry:
  %s2.addr = alloca %struct.s2*, align 8
  %args.addr = alloca %struct.__va_list_tag*, align 8
  %t1 = alloca i8*, align 8
  %nt1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %nt2 = alloca i8*, align 8
  %nt3 = alloca i8*, align 8
  %t12 = alloca i8*, align 8
  %nt12 = alloca i8*, align 8
  %t22 = alloca i8*, align 8
  %nt22 = alloca i8*, align 8
  %nt32 = alloca i8*, align 8
  store %struct.s2* %s2, %struct.s2** %s2.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.s2** %s2.addr, metadata !30, metadata !31), !dbg !32
  store %struct.__va_list_tag* %args, %struct.__va_list_tag** %args.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.__va_list_tag** %args.addr, metadata !33, metadata !31), !dbg !34
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !35, metadata !31), !dbg !38
  %0 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !39
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %0, i32 0, i32 0, !dbg !39
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !39
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 0, !dbg !39
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !39
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !39
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !39

vaarg.in_reg:                                     ; preds = %entry
  %1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 3, !dbg !39
  %reg_save_area = load i8*, i8** %1, align 8, !dbg !39
  %2 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !39
  %3 = bitcast i8* %2 to i8**, !dbg !39
  %4 = add i32 %gp_offset, 8, !dbg !39
  store i32 %4, i32* %gp_offset_p, align 8, !dbg !39
  br label %vaarg.end, !dbg !39

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 2, !dbg !39
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !39
  %5 = bitcast i8* %overflow_arg_area to i8**, !dbg !39
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !39
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !39
  br label %vaarg.end, !dbg !39

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %3, %vaarg.in_reg ], [ %5, %vaarg.in_mem ], !dbg !39
  %6 = load i8*, i8** %vaarg.addr, align 8, !dbg !39
  store i8* %6, i8** %t1, align 8, !dbg !38
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !40, metadata !31), !dbg !41
  %7 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !42
  %vas1 = getelementptr inbounds %struct.s2, %struct.s2* %7, i32 0, i32 0, !dbg !42
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas1, i32 0, i32 0, !dbg !42
  %gp_offset_p3 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !42
  %gp_offset4 = load i32, i32* %gp_offset_p3, align 8, !dbg !42
  %fits_in_gp5 = icmp ule i32 %gp_offset4, 40, !dbg !42
  br i1 %fits_in_gp5, label %vaarg.in_reg6, label %vaarg.in_mem8, !dbg !42

vaarg.in_reg6:                                    ; preds = %vaarg.end
  %8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !42
  %reg_save_area7 = load i8*, i8** %8, align 8, !dbg !42
  %9 = getelementptr i8, i8* %reg_save_area7, i32 %gp_offset4, !dbg !42
  %10 = bitcast i8* %9 to i8**, !dbg !42
  %11 = add i32 %gp_offset4, 8, !dbg !42
  store i32 %11, i32* %gp_offset_p3, align 8, !dbg !42
  br label %vaarg.end12, !dbg !42

vaarg.in_mem8:                                    ; preds = %vaarg.end
  %overflow_arg_area_p9 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !42
  %overflow_arg_area10 = load i8*, i8** %overflow_arg_area_p9, align 8, !dbg !42
  %12 = bitcast i8* %overflow_arg_area10 to i8**, !dbg !42
  %overflow_arg_area.next11 = getelementptr i8, i8* %overflow_arg_area10, i32 8, !dbg !42
  store i8* %overflow_arg_area.next11, i8** %overflow_arg_area_p9, align 8, !dbg !42
  br label %vaarg.end12, !dbg !42

vaarg.end12:                                      ; preds = %vaarg.in_mem8, %vaarg.in_reg6
  %vaarg.addr13 = phi i8** [ %10, %vaarg.in_reg6 ], [ %12, %vaarg.in_mem8 ], !dbg !42
  %13 = load i8*, i8** %vaarg.addr13, align 8, !dbg !42
  store i8* %13, i8** %nt1, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !43, metadata !31), !dbg !44
  %14 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !45
  %vas14 = getelementptr inbounds %struct.s2, %struct.s2* %14, i32 0, i32 0, !dbg !45
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas14, i32 0, i32 0, !dbg !45
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !45
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 8, !dbg !45
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !45
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !45

vaarg.in_reg19:                                   ; preds = %vaarg.end12
  %15 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !45
  %reg_save_area20 = load i8*, i8** %15, align 8, !dbg !45
  %16 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !45
  %17 = bitcast i8* %16 to i8**, !dbg !45
  %18 = add i32 %gp_offset17, 8, !dbg !45
  store i32 %18, i32* %gp_offset_p16, align 8, !dbg !45
  br label %vaarg.end25, !dbg !45

vaarg.in_mem21:                                   ; preds = %vaarg.end12
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !45
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !45
  %19 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !45
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !45
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !45
  br label %vaarg.end25, !dbg !45

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %17, %vaarg.in_reg19 ], [ %19, %vaarg.in_mem21 ], !dbg !45
  %20 = load i8*, i8** %vaarg.addr26, align 8, !dbg !45
  store i8* %20, i8** %t2, align 8, !dbg !44
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !46, metadata !31), !dbg !47
  %21 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !48
  %vas27 = getelementptr inbounds %struct.s2, %struct.s2* %21, i32 0, i32 0, !dbg !48
  %arraydecay28 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas27, i32 0, i32 0, !dbg !48
  %gp_offset_p29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 0, !dbg !48
  %gp_offset30 = load i32, i32* %gp_offset_p29, align 8, !dbg !48
  %fits_in_gp31 = icmp ule i32 %gp_offset30, 40, !dbg !48
  br i1 %fits_in_gp31, label %vaarg.in_reg32, label %vaarg.in_mem34, !dbg !48

vaarg.in_reg32:                                   ; preds = %vaarg.end25
  %22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 3, !dbg !48
  %reg_save_area33 = load i8*, i8** %22, align 8, !dbg !48
  %23 = getelementptr i8, i8* %reg_save_area33, i32 %gp_offset30, !dbg !48
  %24 = bitcast i8* %23 to i8**, !dbg !48
  %25 = add i32 %gp_offset30, 8, !dbg !48
  store i32 %25, i32* %gp_offset_p29, align 8, !dbg !48
  br label %vaarg.end38, !dbg !48

vaarg.in_mem34:                                   ; preds = %vaarg.end25
  %overflow_arg_area_p35 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 2, !dbg !48
  %overflow_arg_area36 = load i8*, i8** %overflow_arg_area_p35, align 8, !dbg !48
  %26 = bitcast i8* %overflow_arg_area36 to i8**, !dbg !48
  %overflow_arg_area.next37 = getelementptr i8, i8* %overflow_arg_area36, i32 8, !dbg !48
  store i8* %overflow_arg_area.next37, i8** %overflow_arg_area_p35, align 8, !dbg !48
  br label %vaarg.end38, !dbg !48

vaarg.end38:                                      ; preds = %vaarg.in_mem34, %vaarg.in_reg32
  %vaarg.addr39 = phi i8** [ %24, %vaarg.in_reg32 ], [ %26, %vaarg.in_mem34 ], !dbg !48
  %27 = load i8*, i8** %vaarg.addr39, align 8, !dbg !48
  store i8* %27, i8** %nt2, align 8, !dbg !47
  call void @llvm.dbg.declare(metadata i8** %nt3, metadata !49, metadata !31), !dbg !50
  %28 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !51
  %vas40 = getelementptr inbounds %struct.s2, %struct.s2* %28, i32 0, i32 0, !dbg !51
  %arraydecay41 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas40, i32 0, i32 0, !dbg !51
  %gp_offset_p42 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 0, !dbg !51
  %gp_offset43 = load i32, i32* %gp_offset_p42, align 8, !dbg !51
  %fits_in_gp44 = icmp ule i32 %gp_offset43, 40, !dbg !51
  br i1 %fits_in_gp44, label %vaarg.in_reg45, label %vaarg.in_mem47, !dbg !51

vaarg.in_reg45:                                   ; preds = %vaarg.end38
  %29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 3, !dbg !51
  %reg_save_area46 = load i8*, i8** %29, align 8, !dbg !51
  %30 = getelementptr i8, i8* %reg_save_area46, i32 %gp_offset43, !dbg !51
  %31 = bitcast i8* %30 to i8**, !dbg !51
  %32 = add i32 %gp_offset43, 8, !dbg !51
  store i32 %32, i32* %gp_offset_p42, align 8, !dbg !51
  br label %vaarg.end51, !dbg !51

vaarg.in_mem47:                                   ; preds = %vaarg.end38
  %overflow_arg_area_p48 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 2, !dbg !51
  %overflow_arg_area49 = load i8*, i8** %overflow_arg_area_p48, align 8, !dbg !51
  %33 = bitcast i8* %overflow_arg_area49 to i8**, !dbg !51
  %overflow_arg_area.next50 = getelementptr i8, i8* %overflow_arg_area49, i32 8, !dbg !51
  store i8* %overflow_arg_area.next50, i8** %overflow_arg_area_p48, align 8, !dbg !51
  br label %vaarg.end51, !dbg !51

vaarg.end51:                                      ; preds = %vaarg.in_mem47, %vaarg.in_reg45
  %vaarg.addr52 = phi i8** [ %31, %vaarg.in_reg45 ], [ %33, %vaarg.in_mem47 ], !dbg !51
  %34 = load i8*, i8** %vaarg.addr52, align 8, !dbg !51
  store i8* %34, i8** %nt3, align 8, !dbg !50
  call void @llvm.dbg.declare(metadata i8** %t12, metadata !52, metadata !31), !dbg !53
  %35 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !54
  %gp_offset_p53 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %35, i32 0, i32 0, !dbg !54
  %gp_offset54 = load i32, i32* %gp_offset_p53, align 8, !dbg !54
  %fits_in_gp55 = icmp ule i32 %gp_offset54, 40, !dbg !54
  br i1 %fits_in_gp55, label %vaarg.in_reg56, label %vaarg.in_mem58, !dbg !54

vaarg.in_reg56:                                   ; preds = %vaarg.end51
  %36 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %35, i32 0, i32 3, !dbg !54
  %reg_save_area57 = load i8*, i8** %36, align 8, !dbg !54
  %37 = getelementptr i8, i8* %reg_save_area57, i32 %gp_offset54, !dbg !54
  %38 = bitcast i8* %37 to i8**, !dbg !54
  %39 = add i32 %gp_offset54, 8, !dbg !54
  store i32 %39, i32* %gp_offset_p53, align 8, !dbg !54
  br label %vaarg.end62, !dbg !54

vaarg.in_mem58:                                   ; preds = %vaarg.end51
  %overflow_arg_area_p59 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %35, i32 0, i32 2, !dbg !54
  %overflow_arg_area60 = load i8*, i8** %overflow_arg_area_p59, align 8, !dbg !54
  %40 = bitcast i8* %overflow_arg_area60 to i8**, !dbg !54
  %overflow_arg_area.next61 = getelementptr i8, i8* %overflow_arg_area60, i32 8, !dbg !54
  store i8* %overflow_arg_area.next61, i8** %overflow_arg_area_p59, align 8, !dbg !54
  br label %vaarg.end62, !dbg !54

vaarg.end62:                                      ; preds = %vaarg.in_mem58, %vaarg.in_reg56
  %vaarg.addr63 = phi i8** [ %38, %vaarg.in_reg56 ], [ %40, %vaarg.in_mem58 ], !dbg !54
  %41 = load i8*, i8** %vaarg.addr63, align 8, !dbg !54
  store i8* %41, i8** %t12, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata i8** %nt12, metadata !55, metadata !31), !dbg !56
  %42 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !57
  %gp_offset_p64 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %42, i32 0, i32 0, !dbg !57
  %gp_offset65 = load i32, i32* %gp_offset_p64, align 8, !dbg !57
  %fits_in_gp66 = icmp ule i32 %gp_offset65, 40, !dbg !57
  br i1 %fits_in_gp66, label %vaarg.in_reg67, label %vaarg.in_mem69, !dbg !57

vaarg.in_reg67:                                   ; preds = %vaarg.end62
  %43 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %42, i32 0, i32 3, !dbg !57
  %reg_save_area68 = load i8*, i8** %43, align 8, !dbg !57
  %44 = getelementptr i8, i8* %reg_save_area68, i32 %gp_offset65, !dbg !57
  %45 = bitcast i8* %44 to i8**, !dbg !57
  %46 = add i32 %gp_offset65, 8, !dbg !57
  store i32 %46, i32* %gp_offset_p64, align 8, !dbg !57
  br label %vaarg.end73, !dbg !57

vaarg.in_mem69:                                   ; preds = %vaarg.end62
  %overflow_arg_area_p70 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %42, i32 0, i32 2, !dbg !57
  %overflow_arg_area71 = load i8*, i8** %overflow_arg_area_p70, align 8, !dbg !57
  %47 = bitcast i8* %overflow_arg_area71 to i8**, !dbg !57
  %overflow_arg_area.next72 = getelementptr i8, i8* %overflow_arg_area71, i32 8, !dbg !57
  store i8* %overflow_arg_area.next72, i8** %overflow_arg_area_p70, align 8, !dbg !57
  br label %vaarg.end73, !dbg !57

vaarg.end73:                                      ; preds = %vaarg.in_mem69, %vaarg.in_reg67
  %vaarg.addr74 = phi i8** [ %45, %vaarg.in_reg67 ], [ %47, %vaarg.in_mem69 ], !dbg !57
  %48 = load i8*, i8** %vaarg.addr74, align 8, !dbg !57
  store i8* %48, i8** %nt12, align 8, !dbg !56
  call void @llvm.dbg.declare(metadata i8** %t22, metadata !58, metadata !31), !dbg !59
  %49 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !60
  %gp_offset_p75 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %49, i32 0, i32 0, !dbg !60
  %gp_offset76 = load i32, i32* %gp_offset_p75, align 8, !dbg !60
  %fits_in_gp77 = icmp ule i32 %gp_offset76, 40, !dbg !60
  br i1 %fits_in_gp77, label %vaarg.in_reg78, label %vaarg.in_mem80, !dbg !60

vaarg.in_reg78:                                   ; preds = %vaarg.end73
  %50 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %49, i32 0, i32 3, !dbg !60
  %reg_save_area79 = load i8*, i8** %50, align 8, !dbg !60
  %51 = getelementptr i8, i8* %reg_save_area79, i32 %gp_offset76, !dbg !60
  %52 = bitcast i8* %51 to i8**, !dbg !60
  %53 = add i32 %gp_offset76, 8, !dbg !60
  store i32 %53, i32* %gp_offset_p75, align 8, !dbg !60
  br label %vaarg.end84, !dbg !60

vaarg.in_mem80:                                   ; preds = %vaarg.end73
  %overflow_arg_area_p81 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %49, i32 0, i32 2, !dbg !60
  %overflow_arg_area82 = load i8*, i8** %overflow_arg_area_p81, align 8, !dbg !60
  %54 = bitcast i8* %overflow_arg_area82 to i8**, !dbg !60
  %overflow_arg_area.next83 = getelementptr i8, i8* %overflow_arg_area82, i32 8, !dbg !60
  store i8* %overflow_arg_area.next83, i8** %overflow_arg_area_p81, align 8, !dbg !60
  br label %vaarg.end84, !dbg !60

vaarg.end84:                                      ; preds = %vaarg.in_mem80, %vaarg.in_reg78
  %vaarg.addr85 = phi i8** [ %52, %vaarg.in_reg78 ], [ %54, %vaarg.in_mem80 ], !dbg !60
  %55 = load i8*, i8** %vaarg.addr85, align 8, !dbg !60
  store i8* %55, i8** %t22, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata i8** %nt22, metadata !61, metadata !31), !dbg !62
  %56 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !63
  %gp_offset_p86 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %56, i32 0, i32 0, !dbg !63
  %gp_offset87 = load i32, i32* %gp_offset_p86, align 8, !dbg !63
  %fits_in_gp88 = icmp ule i32 %gp_offset87, 40, !dbg !63
  br i1 %fits_in_gp88, label %vaarg.in_reg89, label %vaarg.in_mem91, !dbg !63

vaarg.in_reg89:                                   ; preds = %vaarg.end84
  %57 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %56, i32 0, i32 3, !dbg !63
  %reg_save_area90 = load i8*, i8** %57, align 8, !dbg !63
  %58 = getelementptr i8, i8* %reg_save_area90, i32 %gp_offset87, !dbg !63
  %59 = bitcast i8* %58 to i8**, !dbg !63
  %60 = add i32 %gp_offset87, 8, !dbg !63
  store i32 %60, i32* %gp_offset_p86, align 8, !dbg !63
  br label %vaarg.end95, !dbg !63

vaarg.in_mem91:                                   ; preds = %vaarg.end84
  %overflow_arg_area_p92 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %56, i32 0, i32 2, !dbg !63
  %overflow_arg_area93 = load i8*, i8** %overflow_arg_area_p92, align 8, !dbg !63
  %61 = bitcast i8* %overflow_arg_area93 to i8**, !dbg !63
  %overflow_arg_area.next94 = getelementptr i8, i8* %overflow_arg_area93, i32 8, !dbg !63
  store i8* %overflow_arg_area.next94, i8** %overflow_arg_area_p92, align 8, !dbg !63
  br label %vaarg.end95, !dbg !63

vaarg.end95:                                      ; preds = %vaarg.in_mem91, %vaarg.in_reg89
  %vaarg.addr96 = phi i8** [ %59, %vaarg.in_reg89 ], [ %61, %vaarg.in_mem91 ], !dbg !63
  %62 = load i8*, i8** %vaarg.addr96, align 8, !dbg !63
  store i8* %62, i8** %nt22, align 8, !dbg !62
  call void @llvm.dbg.declare(metadata i8** %nt32, metadata !64, metadata !31), !dbg !65
  %63 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !66
  %gp_offset_p97 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %63, i32 0, i32 0, !dbg !66
  %gp_offset98 = load i32, i32* %gp_offset_p97, align 8, !dbg !66
  %fits_in_gp99 = icmp ule i32 %gp_offset98, 40, !dbg !66
  br i1 %fits_in_gp99, label %vaarg.in_reg100, label %vaarg.in_mem102, !dbg !66

vaarg.in_reg100:                                  ; preds = %vaarg.end95
  %64 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %63, i32 0, i32 3, !dbg !66
  %reg_save_area101 = load i8*, i8** %64, align 8, !dbg !66
  %65 = getelementptr i8, i8* %reg_save_area101, i32 %gp_offset98, !dbg !66
  %66 = bitcast i8* %65 to i8**, !dbg !66
  %67 = add i32 %gp_offset98, 8, !dbg !66
  store i32 %67, i32* %gp_offset_p97, align 8, !dbg !66
  br label %vaarg.end106, !dbg !66

vaarg.in_mem102:                                  ; preds = %vaarg.end95
  %overflow_arg_area_p103 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %63, i32 0, i32 2, !dbg !66
  %overflow_arg_area104 = load i8*, i8** %overflow_arg_area_p103, align 8, !dbg !66
  %68 = bitcast i8* %overflow_arg_area104 to i8**, !dbg !66
  %overflow_arg_area.next105 = getelementptr i8, i8* %overflow_arg_area104, i32 8, !dbg !66
  store i8* %overflow_arg_area.next105, i8** %overflow_arg_area_p103, align 8, !dbg !66
  br label %vaarg.end106, !dbg !66

vaarg.end106:                                     ; preds = %vaarg.in_mem102, %vaarg.in_reg100
  %vaarg.addr107 = phi i8** [ %66, %vaarg.in_reg100 ], [ %68, %vaarg.in_mem102 ], !dbg !66
  %69 = load i8*, i8** %vaarg.addr107, align 8, !dbg !66
  store i8* %69, i8** %nt32, align 8, !dbg !65
  ret i32 0, !dbg !67
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @forwarder(i32 %n, ...) #0 !dbg !68 {
entry:
  %n.addr = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  %rc = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !71, metadata !31), !dbg !72
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !73, metadata !31), !dbg !77
  %s1 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !78
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %s1, i32 0, i32 0, !dbg !78
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !78
  %arraydecay2 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !78
  call void @llvm.va_start(i8* %arraydecay2), !dbg !78
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !79, metadata !31), !dbg !80
  %s3 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !81
  %s4 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !82
  %vas5 = getelementptr inbounds %struct.s2, %struct.s2* %s4, i32 0, i32 0, !dbg !83
  %arraydecay6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas5, i32 0, i32 0, !dbg !84
  %call = call i32 @user(%struct.s2* %s3, %struct.__va_list_tag* %arraydecay6), !dbg !85
  store i32 %call, i32* %rc, align 4, !dbg !80
  %s7 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !86
  %vas8 = getelementptr inbounds %struct.s2, %struct.s2* %s7, i32 0, i32 0, !dbg !86
  %arraydecay9 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas8, i32 0, i32 0, !dbg !86
  %arraydecay910 = bitcast %struct.__va_list_tag* %arraydecay9 to i8*, !dbg !86
  call void @llvm.va_end(i8* %arraydecay910), !dbg !86
  %0 = load i32, i32* %rc, align 4, !dbg !87
  ret i32 %0, !dbg !88
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !89 {
entry:
  %retval = alloca i32, align 4
  %not_tainted = alloca i8*, align 8
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !92, metadata !31), !dbg !93
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0), i8** %not_tainted, align 8, !dbg !93
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !94, metadata !31), !dbg !95
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)) #2, !dbg !96
  store i8* %call, i8** %tainted, align 8, !dbg !95
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !97, metadata !31), !dbg !98
  %0 = load i8*, i8** %tainted, align 8, !dbg !99
  %1 = load i8*, i8** %not_tainted, align 8, !dbg !100
  %2 = load i8*, i8** %tainted, align 8, !dbg !101
  %3 = load i8*, i8** %not_tainted, align 8, !dbg !102
  %4 = load i8*, i8** %not_tainted, align 8, !dbg !103
  %call1 = call i32 (i32, ...) @forwarder(i32 6, i8* %0, i8* %1, i8* %2, i8* %3, i8* %4), !dbg !104
  store i32 %call1, i32* %rc, align 4, !dbg !98
  %5 = load i32, i32* %rc, align 4, !dbg !105
  ret i32 %5, !dbg !106
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-29")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "user", scope: !1, file: !1, line: 15, type: !8, isLocal: false, isDefinition: true, scopeLine: 16, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !11, !29}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 6, size: 192, elements: !13)
!13 = !{!14}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "vas", scope: !12, file: !1, line: 7, baseType: !15, size: 192)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !16, line: 30, baseType: !17)
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-29")
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
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!30 = !DILocalVariable(name: "s2", arg: 1, scope: !7, file: !1, line: 15, type: !11)
!31 = !DIExpression()
!32 = !DILocation(line: 15, column: 17, scope: !7)
!33 = !DILocalVariable(name: "args", arg: 2, scope: !7, file: !1, line: 15, type: !29)
!34 = !DILocation(line: 15, column: 29, scope: !7)
!35 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 17, type: !36)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!38 = !DILocation(line: 17, column: 11, scope: !7)
!39 = !DILocation(line: 17, column: 16, scope: !7)
!40 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 18, type: !36)
!41 = !DILocation(line: 18, column: 11, scope: !7)
!42 = !DILocation(line: 18, column: 17, scope: !7)
!43 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 19, type: !36)
!44 = !DILocation(line: 19, column: 11, scope: !7)
!45 = !DILocation(line: 19, column: 16, scope: !7)
!46 = !DILocalVariable(name: "nt2", scope: !7, file: !1, line: 20, type: !36)
!47 = !DILocation(line: 20, column: 11, scope: !7)
!48 = !DILocation(line: 20, column: 17, scope: !7)
!49 = !DILocalVariable(name: "nt3", scope: !7, file: !1, line: 21, type: !36)
!50 = !DILocation(line: 21, column: 11, scope: !7)
!51 = !DILocation(line: 21, column: 17, scope: !7)
!52 = !DILocalVariable(name: "t12", scope: !7, file: !1, line: 23, type: !36)
!53 = !DILocation(line: 23, column: 11, scope: !7)
!54 = !DILocation(line: 23, column: 17, scope: !7)
!55 = !DILocalVariable(name: "nt12", scope: !7, file: !1, line: 24, type: !36)
!56 = !DILocation(line: 24, column: 11, scope: !7)
!57 = !DILocation(line: 24, column: 18, scope: !7)
!58 = !DILocalVariable(name: "t22", scope: !7, file: !1, line: 25, type: !36)
!59 = !DILocation(line: 25, column: 11, scope: !7)
!60 = !DILocation(line: 25, column: 17, scope: !7)
!61 = !DILocalVariable(name: "nt22", scope: !7, file: !1, line: 26, type: !36)
!62 = !DILocation(line: 26, column: 11, scope: !7)
!63 = !DILocation(line: 26, column: 18, scope: !7)
!64 = !DILocalVariable(name: "nt32", scope: !7, file: !1, line: 27, type: !36)
!65 = !DILocation(line: 27, column: 11, scope: !7)
!66 = !DILocation(line: 27, column: 18, scope: !7)
!67 = !DILocation(line: 29, column: 5, scope: !7)
!68 = distinct !DISubprogram(name: "forwarder", scope: !1, file: !1, line: 33, type: !69, isLocal: false, isDefinition: true, scopeLine: 34, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!69 = !DISubroutineType(types: !70)
!70 = !{!10, !10, null}
!71 = !DILocalVariable(name: "n", arg: 1, scope: !68, file: !1, line: 33, type: !10)
!72 = !DILocation(line: 33, column: 15, scope: !68)
!73 = !DILocalVariable(name: "s", scope: !68, file: !1, line: 35, type: !74)
!74 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 10, size: 192, elements: !75)
!75 = !{!76}
!76 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !74, file: !1, line: 11, baseType: !12, size: 192)
!77 = !DILocation(line: 35, column: 15, scope: !68)
!78 = !DILocation(line: 37, column: 5, scope: !68)
!79 = !DILocalVariable(name: "rc", scope: !68, file: !1, line: 39, type: !10)
!80 = !DILocation(line: 39, column: 9, scope: !68)
!81 = !DILocation(line: 39, column: 22, scope: !68)
!82 = !DILocation(line: 39, column: 27, scope: !68)
!83 = !DILocation(line: 39, column: 29, scope: !68)
!84 = !DILocation(line: 39, column: 25, scope: !68)
!85 = !DILocation(line: 39, column: 14, scope: !68)
!86 = !DILocation(line: 41, column: 5, scope: !68)
!87 = !DILocation(line: 43, column: 12, scope: !68)
!88 = !DILocation(line: 43, column: 5, scope: !68)
!89 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 47, type: !90, isLocal: false, isDefinition: true, scopeLine: 48, isOptimized: false, unit: !0, variables: !2)
!90 = !DISubroutineType(types: !91)
!91 = !{!10}
!92 = !DILocalVariable(name: "not_tainted", scope: !89, file: !1, line: 49, type: !36)
!93 = !DILocation(line: 49, column: 11, scope: !89)
!94 = !DILocalVariable(name: "tainted", scope: !89, file: !1, line: 50, type: !36)
!95 = !DILocation(line: 50, column: 11, scope: !89)
!96 = !DILocation(line: 50, column: 21, scope: !89)
!97 = !DILocalVariable(name: "rc", scope: !89, file: !1, line: 52, type: !10)
!98 = !DILocation(line: 52, column: 9, scope: !89)
!99 = !DILocation(line: 52, column: 27, scope: !89)
!100 = !DILocation(line: 52, column: 36, scope: !89)
!101 = !DILocation(line: 52, column: 49, scope: !89)
!102 = !DILocation(line: 52, column: 58, scope: !89)
!103 = !DILocation(line: 52, column: 71, scope: !89)
!104 = !DILocation(line: 52, column: 14, scope: !89)
!105 = !DILocation(line: 54, column: 12, scope: !89)
!106 = !DILocation(line: 54, column: 5, scope: !89)
