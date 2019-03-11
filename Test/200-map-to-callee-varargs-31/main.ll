; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s2 = type { [1 x %struct.__va_list_tag] }
%struct.s1 = type { %struct.s2 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"hello world\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(%struct.__va_list_tag* %args) #0 !dbg !9 {
entry:
  %args.addr = alloca %struct.__va_list_tag*, align 8
  %t = alloca i32, align 4
  %t2 = alloca i8*, align 8
  %nt = alloca i8*, align 8
  %nt2 = alloca i32, align 4
  store %struct.__va_list_tag* %args, %struct.__va_list_tag** %args.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.__va_list_tag** %args.addr, metadata !21, metadata !22), !dbg !23
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !24
  %cmp = icmp ne i8* %call, null, !dbg !26
  br i1 %cmp, label %if.then, label %if.end, !dbg !27

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %t, metadata !28, metadata !22), !dbg !30
  %0 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !31
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 0, !dbg !31
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !31
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !31
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !31

vaarg.in_reg:                                     ; preds = %if.then
  %1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 3, !dbg !31
  %reg_save_area = load i8*, i8** %1, align 8, !dbg !31
  %2 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !31
  %3 = bitcast i8* %2 to i32*, !dbg !31
  %4 = add i32 %gp_offset, 8, !dbg !31
  store i32 %4, i32* %gp_offset_p, align 8, !dbg !31
  br label %vaarg.end, !dbg !31

vaarg.in_mem:                                     ; preds = %if.then
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 2, !dbg !31
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !31
  %5 = bitcast i8* %overflow_arg_area to i32*, !dbg !31
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !31
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !31
  br label %vaarg.end, !dbg !31

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i32* [ %3, %vaarg.in_reg ], [ %5, %vaarg.in_mem ], !dbg !31
  %6 = load i32, i32* %vaarg.addr, align 4, !dbg !31
  store i32 %6, i32* %t, align 4, !dbg !30
  br label %if.end, !dbg !32

if.end:                                           ; preds = %vaarg.end, %entry
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !33, metadata !22), !dbg !36
  %7 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !37
  %gp_offset_p1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 0, !dbg !37
  %gp_offset2 = load i32, i32* %gp_offset_p1, align 8, !dbg !37
  %fits_in_gp3 = icmp ule i32 %gp_offset2, 40, !dbg !37
  br i1 %fits_in_gp3, label %vaarg.in_reg4, label %vaarg.in_mem6, !dbg !37

vaarg.in_reg4:                                    ; preds = %if.end
  %8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 3, !dbg !37
  %reg_save_area5 = load i8*, i8** %8, align 8, !dbg !37
  %9 = getelementptr i8, i8* %reg_save_area5, i32 %gp_offset2, !dbg !37
  %10 = bitcast i8* %9 to i8**, !dbg !37
  %11 = add i32 %gp_offset2, 8, !dbg !37
  store i32 %11, i32* %gp_offset_p1, align 8, !dbg !37
  br label %vaarg.end10, !dbg !37

vaarg.in_mem6:                                    ; preds = %if.end
  %overflow_arg_area_p7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 2, !dbg !37
  %overflow_arg_area8 = load i8*, i8** %overflow_arg_area_p7, align 8, !dbg !37
  %12 = bitcast i8* %overflow_arg_area8 to i8**, !dbg !37
  %overflow_arg_area.next9 = getelementptr i8, i8* %overflow_arg_area8, i32 8, !dbg !37
  store i8* %overflow_arg_area.next9, i8** %overflow_arg_area_p7, align 8, !dbg !37
  br label %vaarg.end10, !dbg !37

vaarg.end10:                                      ; preds = %vaarg.in_mem6, %vaarg.in_reg4
  %vaarg.addr11 = phi i8** [ %10, %vaarg.in_reg4 ], [ %12, %vaarg.in_mem6 ], !dbg !37
  %13 = load i8*, i8** %vaarg.addr11, align 8, !dbg !37
  store i8* %13, i8** %t2, align 8, !dbg !36
  call void @llvm.dbg.declare(metadata i8** %nt, metadata !38, metadata !22), !dbg !39
  %14 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !40
  %gp_offset_p12 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 0, !dbg !40
  %gp_offset13 = load i32, i32* %gp_offset_p12, align 8, !dbg !40
  %fits_in_gp14 = icmp ule i32 %gp_offset13, 40, !dbg !40
  br i1 %fits_in_gp14, label %vaarg.in_reg15, label %vaarg.in_mem17, !dbg !40

vaarg.in_reg15:                                   ; preds = %vaarg.end10
  %15 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 3, !dbg !40
  %reg_save_area16 = load i8*, i8** %15, align 8, !dbg !40
  %16 = getelementptr i8, i8* %reg_save_area16, i32 %gp_offset13, !dbg !40
  %17 = bitcast i8* %16 to i8**, !dbg !40
  %18 = add i32 %gp_offset13, 8, !dbg !40
  store i32 %18, i32* %gp_offset_p12, align 8, !dbg !40
  br label %vaarg.end21, !dbg !40

vaarg.in_mem17:                                   ; preds = %vaarg.end10
  %overflow_arg_area_p18 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 2, !dbg !40
  %overflow_arg_area19 = load i8*, i8** %overflow_arg_area_p18, align 8, !dbg !40
  %19 = bitcast i8* %overflow_arg_area19 to i8**, !dbg !40
  %overflow_arg_area.next20 = getelementptr i8, i8* %overflow_arg_area19, i32 8, !dbg !40
  store i8* %overflow_arg_area.next20, i8** %overflow_arg_area_p18, align 8, !dbg !40
  br label %vaarg.end21, !dbg !40

vaarg.end21:                                      ; preds = %vaarg.in_mem17, %vaarg.in_reg15
  %vaarg.addr22 = phi i8** [ %17, %vaarg.in_reg15 ], [ %19, %vaarg.in_mem17 ], !dbg !40
  %20 = load i8*, i8** %vaarg.addr22, align 8, !dbg !40
  store i8* %20, i8** %nt, align 8, !dbg !39
  call void @llvm.dbg.declare(metadata i32* %nt2, metadata !41, metadata !22), !dbg !42
  store i32 1, i32* %nt2, align 4, !dbg !42
  ret i32 -1, !dbg !43
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @user(%struct.s2* %s2, %struct.__va_list_tag* %args, ...) #0 !dbg !44 {
entry:
  %s2.addr = alloca %struct.s2*, align 8
  %args.addr = alloca %struct.__va_list_tag*, align 8
  %nt1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %nt2 = alloca i8*, align 8
  %nt3 = alloca i8*, align 8
  %t12 = alloca i8*, align 8
  %nt12 = alloca i8*, align 8
  %t22 = alloca i8*, align 8
  %nt22 = alloca i8*, align 8
  %ap1 = alloca [1 x %struct.__va_list_tag], align 16
  %a = alloca i32, align 4
  %t123 = alloca i8*, align 8
  %ap2 = alloca [1 x %struct.__va_list_tag], align 16
  store %struct.s2* %s2, %struct.s2** %s2.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.s2** %s2.addr, metadata !57, metadata !22), !dbg !58
  store %struct.__va_list_tag* %args, %struct.__va_list_tag** %args.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.__va_list_tag** %args.addr, metadata !59, metadata !22), !dbg !60
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !61, metadata !22), !dbg !62
  %0 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !63
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %0, i32 0, i32 0, !dbg !63
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !63
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 0, !dbg !63
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !63
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !63
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !63

vaarg.in_reg:                                     ; preds = %entry
  %1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 3, !dbg !63
  %reg_save_area = load i8*, i8** %1, align 8, !dbg !63
  %2 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !63
  %3 = bitcast i8* %2 to i8**, !dbg !63
  %4 = add i32 %gp_offset, 8, !dbg !63
  store i32 %4, i32* %gp_offset_p, align 8, !dbg !63
  br label %vaarg.end, !dbg !63

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 2, !dbg !63
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !63
  %5 = bitcast i8* %overflow_arg_area to i8**, !dbg !63
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !63
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !63
  br label %vaarg.end, !dbg !63

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %3, %vaarg.in_reg ], [ %5, %vaarg.in_mem ], !dbg !63
  %6 = load i8*, i8** %vaarg.addr, align 8, !dbg !63
  store i8* %6, i8** %nt1, align 8, !dbg !62
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !64, metadata !22), !dbg !65
  %7 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !66
  %vas1 = getelementptr inbounds %struct.s2, %struct.s2* %7, i32 0, i32 0, !dbg !66
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas1, i32 0, i32 0, !dbg !66
  %gp_offset_p3 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !66
  %gp_offset4 = load i32, i32* %gp_offset_p3, align 8, !dbg !66
  %fits_in_gp5 = icmp ule i32 %gp_offset4, 40, !dbg !66
  br i1 %fits_in_gp5, label %vaarg.in_reg6, label %vaarg.in_mem8, !dbg !66

vaarg.in_reg6:                                    ; preds = %vaarg.end
  %8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !66
  %reg_save_area7 = load i8*, i8** %8, align 8, !dbg !66
  %9 = getelementptr i8, i8* %reg_save_area7, i32 %gp_offset4, !dbg !66
  %10 = bitcast i8* %9 to i8**, !dbg !66
  %11 = add i32 %gp_offset4, 8, !dbg !66
  store i32 %11, i32* %gp_offset_p3, align 8, !dbg !66
  br label %vaarg.end12, !dbg !66

vaarg.in_mem8:                                    ; preds = %vaarg.end
  %overflow_arg_area_p9 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !66
  %overflow_arg_area10 = load i8*, i8** %overflow_arg_area_p9, align 8, !dbg !66
  %12 = bitcast i8* %overflow_arg_area10 to i8**, !dbg !66
  %overflow_arg_area.next11 = getelementptr i8, i8* %overflow_arg_area10, i32 8, !dbg !66
  store i8* %overflow_arg_area.next11, i8** %overflow_arg_area_p9, align 8, !dbg !66
  br label %vaarg.end12, !dbg !66

vaarg.end12:                                      ; preds = %vaarg.in_mem8, %vaarg.in_reg6
  %vaarg.addr13 = phi i8** [ %10, %vaarg.in_reg6 ], [ %12, %vaarg.in_mem8 ], !dbg !66
  %13 = load i8*, i8** %vaarg.addr13, align 8, !dbg !66
  store i8* %13, i8** %t2, align 8, !dbg !65
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !67, metadata !22), !dbg !68
  %14 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !69
  %vas14 = getelementptr inbounds %struct.s2, %struct.s2* %14, i32 0, i32 0, !dbg !69
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas14, i32 0, i32 0, !dbg !69
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !69
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 8, !dbg !69
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !69
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !69

vaarg.in_reg19:                                   ; preds = %vaarg.end12
  %15 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !69
  %reg_save_area20 = load i8*, i8** %15, align 8, !dbg !69
  %16 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !69
  %17 = bitcast i8* %16 to i8**, !dbg !69
  %18 = add i32 %gp_offset17, 8, !dbg !69
  store i32 %18, i32* %gp_offset_p16, align 8, !dbg !69
  br label %vaarg.end25, !dbg !69

vaarg.in_mem21:                                   ; preds = %vaarg.end12
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !69
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !69
  %19 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !69
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !69
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !69
  br label %vaarg.end25, !dbg !69

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %17, %vaarg.in_reg19 ], [ %19, %vaarg.in_mem21 ], !dbg !69
  %20 = load i8*, i8** %vaarg.addr26, align 8, !dbg !69
  store i8* %20, i8** %nt2, align 8, !dbg !68
  call void @llvm.dbg.declare(metadata i8** %nt3, metadata !70, metadata !22), !dbg !71
  %21 = load %struct.s2*, %struct.s2** %s2.addr, align 8, !dbg !72
  %vas27 = getelementptr inbounds %struct.s2, %struct.s2* %21, i32 0, i32 0, !dbg !72
  %arraydecay28 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas27, i32 0, i32 0, !dbg !72
  %gp_offset_p29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 0, !dbg !72
  %gp_offset30 = load i32, i32* %gp_offset_p29, align 8, !dbg !72
  %fits_in_gp31 = icmp ule i32 %gp_offset30, 40, !dbg !72
  br i1 %fits_in_gp31, label %vaarg.in_reg32, label %vaarg.in_mem34, !dbg !72

vaarg.in_reg32:                                   ; preds = %vaarg.end25
  %22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 3, !dbg !72
  %reg_save_area33 = load i8*, i8** %22, align 8, !dbg !72
  %23 = getelementptr i8, i8* %reg_save_area33, i32 %gp_offset30, !dbg !72
  %24 = bitcast i8* %23 to i8**, !dbg !72
  %25 = add i32 %gp_offset30, 8, !dbg !72
  store i32 %25, i32* %gp_offset_p29, align 8, !dbg !72
  br label %vaarg.end38, !dbg !72

vaarg.in_mem34:                                   ; preds = %vaarg.end25
  %overflow_arg_area_p35 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay28, i32 0, i32 2, !dbg !72
  %overflow_arg_area36 = load i8*, i8** %overflow_arg_area_p35, align 8, !dbg !72
  %26 = bitcast i8* %overflow_arg_area36 to i8**, !dbg !72
  %overflow_arg_area.next37 = getelementptr i8, i8* %overflow_arg_area36, i32 8, !dbg !72
  store i8* %overflow_arg_area.next37, i8** %overflow_arg_area_p35, align 8, !dbg !72
  br label %vaarg.end38, !dbg !72

vaarg.end38:                                      ; preds = %vaarg.in_mem34, %vaarg.in_reg32
  %vaarg.addr39 = phi i8** [ %24, %vaarg.in_reg32 ], [ %26, %vaarg.in_mem34 ], !dbg !72
  %27 = load i8*, i8** %vaarg.addr39, align 8, !dbg !72
  store i8* %27, i8** %nt3, align 8, !dbg !71
  call void @llvm.dbg.declare(metadata i8** %t12, metadata !73, metadata !22), !dbg !74
  %28 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !75
  %gp_offset_p40 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %28, i32 0, i32 0, !dbg !75
  %gp_offset41 = load i32, i32* %gp_offset_p40, align 8, !dbg !75
  %fits_in_gp42 = icmp ule i32 %gp_offset41, 40, !dbg !75
  br i1 %fits_in_gp42, label %vaarg.in_reg43, label %vaarg.in_mem45, !dbg !75

vaarg.in_reg43:                                   ; preds = %vaarg.end38
  %29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %28, i32 0, i32 3, !dbg !75
  %reg_save_area44 = load i8*, i8** %29, align 8, !dbg !75
  %30 = getelementptr i8, i8* %reg_save_area44, i32 %gp_offset41, !dbg !75
  %31 = bitcast i8* %30 to i8**, !dbg !75
  %32 = add i32 %gp_offset41, 8, !dbg !75
  store i32 %32, i32* %gp_offset_p40, align 8, !dbg !75
  br label %vaarg.end49, !dbg !75

vaarg.in_mem45:                                   ; preds = %vaarg.end38
  %overflow_arg_area_p46 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %28, i32 0, i32 2, !dbg !75
  %overflow_arg_area47 = load i8*, i8** %overflow_arg_area_p46, align 8, !dbg !75
  %33 = bitcast i8* %overflow_arg_area47 to i8**, !dbg !75
  %overflow_arg_area.next48 = getelementptr i8, i8* %overflow_arg_area47, i32 8, !dbg !75
  store i8* %overflow_arg_area.next48, i8** %overflow_arg_area_p46, align 8, !dbg !75
  br label %vaarg.end49, !dbg !75

vaarg.end49:                                      ; preds = %vaarg.in_mem45, %vaarg.in_reg43
  %vaarg.addr50 = phi i8** [ %31, %vaarg.in_reg43 ], [ %33, %vaarg.in_mem45 ], !dbg !75
  %34 = load i8*, i8** %vaarg.addr50, align 8, !dbg !75
  store i8* %34, i8** %t12, align 8, !dbg !74
  call void @llvm.dbg.declare(metadata i8** %nt12, metadata !76, metadata !22), !dbg !77
  %35 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !78
  %gp_offset_p51 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %35, i32 0, i32 0, !dbg !78
  %gp_offset52 = load i32, i32* %gp_offset_p51, align 8, !dbg !78
  %fits_in_gp53 = icmp ule i32 %gp_offset52, 40, !dbg !78
  br i1 %fits_in_gp53, label %vaarg.in_reg54, label %vaarg.in_mem56, !dbg !78

vaarg.in_reg54:                                   ; preds = %vaarg.end49
  %36 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %35, i32 0, i32 3, !dbg !78
  %reg_save_area55 = load i8*, i8** %36, align 8, !dbg !78
  %37 = getelementptr i8, i8* %reg_save_area55, i32 %gp_offset52, !dbg !78
  %38 = bitcast i8* %37 to i8**, !dbg !78
  %39 = add i32 %gp_offset52, 8, !dbg !78
  store i32 %39, i32* %gp_offset_p51, align 8, !dbg !78
  br label %vaarg.end60, !dbg !78

vaarg.in_mem56:                                   ; preds = %vaarg.end49
  %overflow_arg_area_p57 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %35, i32 0, i32 2, !dbg !78
  %overflow_arg_area58 = load i8*, i8** %overflow_arg_area_p57, align 8, !dbg !78
  %40 = bitcast i8* %overflow_arg_area58 to i8**, !dbg !78
  %overflow_arg_area.next59 = getelementptr i8, i8* %overflow_arg_area58, i32 8, !dbg !78
  store i8* %overflow_arg_area.next59, i8** %overflow_arg_area_p57, align 8, !dbg !78
  br label %vaarg.end60, !dbg !78

vaarg.end60:                                      ; preds = %vaarg.in_mem56, %vaarg.in_reg54
  %vaarg.addr61 = phi i8** [ %38, %vaarg.in_reg54 ], [ %40, %vaarg.in_mem56 ], !dbg !78
  %41 = load i8*, i8** %vaarg.addr61, align 8, !dbg !78
  store i8* %41, i8** %nt12, align 8, !dbg !77
  call void @llvm.dbg.declare(metadata i8** %t22, metadata !79, metadata !22), !dbg !80
  %42 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !81
  %gp_offset_p62 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %42, i32 0, i32 0, !dbg !81
  %gp_offset63 = load i32, i32* %gp_offset_p62, align 8, !dbg !81
  %fits_in_gp64 = icmp ule i32 %gp_offset63, 40, !dbg !81
  br i1 %fits_in_gp64, label %vaarg.in_reg65, label %vaarg.in_mem67, !dbg !81

vaarg.in_reg65:                                   ; preds = %vaarg.end60
  %43 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %42, i32 0, i32 3, !dbg !81
  %reg_save_area66 = load i8*, i8** %43, align 8, !dbg !81
  %44 = getelementptr i8, i8* %reg_save_area66, i32 %gp_offset63, !dbg !81
  %45 = bitcast i8* %44 to i8**, !dbg !81
  %46 = add i32 %gp_offset63, 8, !dbg !81
  store i32 %46, i32* %gp_offset_p62, align 8, !dbg !81
  br label %vaarg.end71, !dbg !81

vaarg.in_mem67:                                   ; preds = %vaarg.end60
  %overflow_arg_area_p68 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %42, i32 0, i32 2, !dbg !81
  %overflow_arg_area69 = load i8*, i8** %overflow_arg_area_p68, align 8, !dbg !81
  %47 = bitcast i8* %overflow_arg_area69 to i8**, !dbg !81
  %overflow_arg_area.next70 = getelementptr i8, i8* %overflow_arg_area69, i32 8, !dbg !81
  store i8* %overflow_arg_area.next70, i8** %overflow_arg_area_p68, align 8, !dbg !81
  br label %vaarg.end71, !dbg !81

vaarg.end71:                                      ; preds = %vaarg.in_mem67, %vaarg.in_reg65
  %vaarg.addr72 = phi i8** [ %45, %vaarg.in_reg65 ], [ %47, %vaarg.in_mem67 ], !dbg !81
  %48 = load i8*, i8** %vaarg.addr72, align 8, !dbg !81
  store i8* %48, i8** %t22, align 8, !dbg !80
  call void @llvm.dbg.declare(metadata i8** %nt22, metadata !82, metadata !22), !dbg !83
  %49 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !84
  %gp_offset_p73 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %49, i32 0, i32 0, !dbg !84
  %gp_offset74 = load i32, i32* %gp_offset_p73, align 8, !dbg !84
  %fits_in_gp75 = icmp ule i32 %gp_offset74, 40, !dbg !84
  br i1 %fits_in_gp75, label %vaarg.in_reg76, label %vaarg.in_mem78, !dbg !84

vaarg.in_reg76:                                   ; preds = %vaarg.end71
  %50 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %49, i32 0, i32 3, !dbg !84
  %reg_save_area77 = load i8*, i8** %50, align 8, !dbg !84
  %51 = getelementptr i8, i8* %reg_save_area77, i32 %gp_offset74, !dbg !84
  %52 = bitcast i8* %51 to i8**, !dbg !84
  %53 = add i32 %gp_offset74, 8, !dbg !84
  store i32 %53, i32* %gp_offset_p73, align 8, !dbg !84
  br label %vaarg.end82, !dbg !84

vaarg.in_mem78:                                   ; preds = %vaarg.end71
  %overflow_arg_area_p79 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %49, i32 0, i32 2, !dbg !84
  %overflow_arg_area80 = load i8*, i8** %overflow_arg_area_p79, align 8, !dbg !84
  %54 = bitcast i8* %overflow_arg_area80 to i8**, !dbg !84
  %overflow_arg_area.next81 = getelementptr i8, i8* %overflow_arg_area80, i32 8, !dbg !84
  store i8* %overflow_arg_area.next81, i8** %overflow_arg_area_p79, align 8, !dbg !84
  br label %vaarg.end82, !dbg !84

vaarg.end82:                                      ; preds = %vaarg.in_mem78, %vaarg.in_reg76
  %vaarg.addr83 = phi i8** [ %52, %vaarg.in_reg76 ], [ %54, %vaarg.in_mem78 ], !dbg !84
  %55 = load i8*, i8** %vaarg.addr83, align 8, !dbg !84
  store i8* %55, i8** %nt22, align 8, !dbg !83
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap1, metadata !85, metadata !22), !dbg !86
  %arraydecay84 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap1, i32 0, i32 0, !dbg !87
  %arraydecay8485 = bitcast %struct.__va_list_tag* %arraydecay84 to i8*, !dbg !87
  call void @llvm.va_start(i8* %arraydecay8485), !dbg !87
  call void @llvm.dbg.declare(metadata i32* %a, metadata !88, metadata !22), !dbg !89
  %arraydecay86 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap1, i32 0, i32 0, !dbg !90
  %gp_offset_p87 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay86, i32 0, i32 0, !dbg !90
  %gp_offset88 = load i32, i32* %gp_offset_p87, align 16, !dbg !90
  %fits_in_gp89 = icmp ule i32 %gp_offset88, 40, !dbg !90
  br i1 %fits_in_gp89, label %vaarg.in_reg90, label %vaarg.in_mem92, !dbg !90

vaarg.in_reg90:                                   ; preds = %vaarg.end82
  %56 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay86, i32 0, i32 3, !dbg !90
  %reg_save_area91 = load i8*, i8** %56, align 16, !dbg !90
  %57 = getelementptr i8, i8* %reg_save_area91, i32 %gp_offset88, !dbg !90
  %58 = bitcast i8* %57 to i32*, !dbg !90
  %59 = add i32 %gp_offset88, 8, !dbg !90
  store i32 %59, i32* %gp_offset_p87, align 16, !dbg !90
  br label %vaarg.end96, !dbg !90

vaarg.in_mem92:                                   ; preds = %vaarg.end82
  %overflow_arg_area_p93 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay86, i32 0, i32 2, !dbg !90
  %overflow_arg_area94 = load i8*, i8** %overflow_arg_area_p93, align 8, !dbg !90
  %60 = bitcast i8* %overflow_arg_area94 to i32*, !dbg !90
  %overflow_arg_area.next95 = getelementptr i8, i8* %overflow_arg_area94, i32 8, !dbg !90
  store i8* %overflow_arg_area.next95, i8** %overflow_arg_area_p93, align 8, !dbg !90
  br label %vaarg.end96, !dbg !90

vaarg.end96:                                      ; preds = %vaarg.in_mem92, %vaarg.in_reg90
  %vaarg.addr97 = phi i32* [ %58, %vaarg.in_reg90 ], [ %60, %vaarg.in_mem92 ], !dbg !90
  %61 = load i32, i32* %vaarg.addr97, align 4, !dbg !90
  store i32 %61, i32* %a, align 4, !dbg !89
  call void @llvm.dbg.declare(metadata i8** %t123, metadata !91, metadata !22), !dbg !92
  %arraydecay98 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap1, i32 0, i32 0, !dbg !93
  %gp_offset_p99 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay98, i32 0, i32 0, !dbg !93
  %gp_offset100 = load i32, i32* %gp_offset_p99, align 16, !dbg !93
  %fits_in_gp101 = icmp ule i32 %gp_offset100, 40, !dbg !93
  br i1 %fits_in_gp101, label %vaarg.in_reg102, label %vaarg.in_mem104, !dbg !93

vaarg.in_reg102:                                  ; preds = %vaarg.end96
  %62 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay98, i32 0, i32 3, !dbg !93
  %reg_save_area103 = load i8*, i8** %62, align 16, !dbg !93
  %63 = getelementptr i8, i8* %reg_save_area103, i32 %gp_offset100, !dbg !93
  %64 = bitcast i8* %63 to i8**, !dbg !93
  %65 = add i32 %gp_offset100, 8, !dbg !93
  store i32 %65, i32* %gp_offset_p99, align 16, !dbg !93
  br label %vaarg.end108, !dbg !93

vaarg.in_mem104:                                  ; preds = %vaarg.end96
  %overflow_arg_area_p105 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay98, i32 0, i32 2, !dbg !93
  %overflow_arg_area106 = load i8*, i8** %overflow_arg_area_p105, align 8, !dbg !93
  %66 = bitcast i8* %overflow_arg_area106 to i8**, !dbg !93
  %overflow_arg_area.next107 = getelementptr i8, i8* %overflow_arg_area106, i32 8, !dbg !93
  store i8* %overflow_arg_area.next107, i8** %overflow_arg_area_p105, align 8, !dbg !93
  br label %vaarg.end108, !dbg !93

vaarg.end108:                                     ; preds = %vaarg.in_mem104, %vaarg.in_reg102
  %vaarg.addr109 = phi i8** [ %64, %vaarg.in_reg102 ], [ %66, %vaarg.in_mem104 ], !dbg !93
  %67 = load i8*, i8** %vaarg.addr109, align 8, !dbg !93
  store i8* %67, i8** %t123, align 8, !dbg !92
  %arraydecay110 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap1, i32 0, i32 0, !dbg !94
  %arraydecay110111 = bitcast %struct.__va_list_tag* %arraydecay110 to i8*, !dbg !94
  call void @llvm.va_end(i8* %arraydecay110111), !dbg !94
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap2, metadata !95, metadata !22), !dbg !96
  %arraydecay112 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap2, i32 0, i32 0, !dbg !97
  %arraydecay112113 = bitcast %struct.__va_list_tag* %arraydecay112 to i8*, !dbg !97
  call void @llvm.va_start(i8* %arraydecay112113), !dbg !97
  %arraydecay114 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap2, i32 0, i32 0, !dbg !98
  %call = call i32 @foo(%struct.__va_list_tag* %arraydecay114), !dbg !99
  %arraydecay115 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap2, i32 0, i32 0, !dbg !100
  %arraydecay115116 = bitcast %struct.__va_list_tag* %arraydecay115 to i8*, !dbg !100
  call void @llvm.va_end(i8* %arraydecay115116), !dbg !100
  ret i32 0, !dbg !101
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #3

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #3

; Function Attrs: noinline nounwind optnone uwtable
define i32 @forwarder(i32 %n, ...) #0 !dbg !102 {
entry:
  %n.addr = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  %t1 = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !105, metadata !22), !dbg !106
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !107, metadata !22), !dbg !111
  %s1 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !112
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %s1, i32 0, i32 0, !dbg !112
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !112
  %arraydecay2 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !112
  call void @llvm.va_start(i8* %arraydecay2), !dbg !112
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !113, metadata !22), !dbg !114
  %s3 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !115
  %vas4 = getelementptr inbounds %struct.s2, %struct.s2* %s3, i32 0, i32 0, !dbg !115
  %arraydecay5 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas4, i32 0, i32 0, !dbg !115
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay5, i32 0, i32 0, !dbg !115
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !115
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !115
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !115

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay5, i32 0, i32 3, !dbg !115
  %reg_save_area = load i8*, i8** %0, align 8, !dbg !115
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !115
  %2 = bitcast i8* %1 to i8**, !dbg !115
  %3 = add i32 %gp_offset, 8, !dbg !115
  store i32 %3, i32* %gp_offset_p, align 8, !dbg !115
  br label %vaarg.end, !dbg !115

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay5, i32 0, i32 2, !dbg !115
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !115
  %4 = bitcast i8* %overflow_arg_area to i8**, !dbg !115
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !115
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !115
  br label %vaarg.end, !dbg !115

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !115
  %5 = load i8*, i8** %vaarg.addr, align 8, !dbg !115
  store i8* %5, i8** %t1, align 8, !dbg !114
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !116, metadata !22), !dbg !117
  %s6 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !118
  %s7 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !119
  %vas8 = getelementptr inbounds %struct.s2, %struct.s2* %s7, i32 0, i32 0, !dbg !120
  %arraydecay9 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas8, i32 0, i32 0, !dbg !121
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !122
  %call10 = call i32 (%struct.s2*, %struct.__va_list_tag*, ...) @user(%struct.s2* %s6, %struct.__va_list_tag* %arraydecay9, i32 4711, i8* %call), !dbg !123
  store i32 %call10, i32* %rc, align 4, !dbg !117
  %s11 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !124
  %vas12 = getelementptr inbounds %struct.s2, %struct.s2* %s11, i32 0, i32 0, !dbg !124
  %arraydecay13 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas12, i32 0, i32 0, !dbg !124
  %arraydecay1314 = bitcast %struct.__va_list_tag* %arraydecay13 to i8*, !dbg !124
  call void @llvm.va_end(i8* %arraydecay1314), !dbg !124
  %6 = load i32, i32* %rc, align 4, !dbg !125
  ret i32 %6, !dbg !126
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !127 {
entry:
  %retval = alloca i32, align 4
  %not_tainted = alloca i8*, align 8
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !130, metadata !22), !dbg !131
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0), i8** %not_tainted, align 8, !dbg !131
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !132, metadata !22), !dbg !133
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !134
  store i8* %call, i8** %tainted, align 8, !dbg !133
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !135, metadata !22), !dbg !136
  %0 = load i8*, i8** %tainted, align 8, !dbg !137
  %1 = load i8*, i8** %not_tainted, align 8, !dbg !138
  %2 = load i8*, i8** %tainted, align 8, !dbg !139
  %3 = load i8*, i8** %not_tainted, align 8, !dbg !140
  %4 = load i8*, i8** %not_tainted, align 8, !dbg !141
  %call1 = call i32 (i32, ...) @forwarder(i32 6, i8* %0, i8* %1, i8* %2, i8* %3, i8* %4), !dbg !142
  store i32 %call1, i32* %rc, align 4, !dbg !136
  %5 = load i32, i32* %rc, align 4, !dbg !143
  ret i32 %5, !dbg !144
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-31")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 15, type: !10, isLocal: false, isDefinition: true, scopeLine: 16, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !13}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, size: 192, elements: !15)
!15 = !{!16, !18, !19, !20}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !14, file: !1, baseType: !17, size: 32)
!17 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !14, file: !1, baseType: !17, size: 32, offset: 32)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !14, file: !1, baseType: !4, size: 64, offset: 64)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !14, file: !1, baseType: !4, size: 64, offset: 128)
!21 = !DILocalVariable(name: "args", arg: 1, scope: !9, file: !1, line: 15, type: !13)
!22 = !DIExpression()
!23 = !DILocation(line: 15, column: 13, scope: !9)
!24 = !DILocation(line: 17, column: 9, scope: !25)
!25 = distinct !DILexicalBlock(scope: !9, file: !1, line: 17, column: 9)
!26 = !DILocation(line: 17, column: 24, scope: !25)
!27 = !DILocation(line: 17, column: 9, scope: !9)
!28 = !DILocalVariable(name: "t", scope: !29, file: !1, line: 18, type: !12)
!29 = distinct !DILexicalBlock(scope: !25, file: !1, line: 17, column: 33)
!30 = !DILocation(line: 18, column: 13, scope: !29)
!31 = !DILocation(line: 18, column: 17, scope: !29)
!32 = !DILocation(line: 19, column: 5, scope: !29)
!33 = !DILocalVariable(name: "t2", scope: !9, file: !1, line: 21, type: !34)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!35 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!36 = !DILocation(line: 21, column: 11, scope: !9)
!37 = !DILocation(line: 21, column: 16, scope: !9)
!38 = !DILocalVariable(name: "nt", scope: !9, file: !1, line: 23, type: !34)
!39 = !DILocation(line: 23, column: 11, scope: !9)
!40 = !DILocation(line: 23, column: 16, scope: !9)
!41 = !DILocalVariable(name: "nt2", scope: !9, file: !1, line: 25, type: !12)
!42 = !DILocation(line: 25, column: 9, scope: !9)
!43 = !DILocation(line: 27, column: 5, scope: !9)
!44 = distinct !DISubprogram(name: "user", scope: !1, file: !1, line: 31, type: !45, isLocal: false, isDefinition: true, scopeLine: 32, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!45 = !DISubroutineType(types: !46)
!46 = !{!12, !47, !13, null}
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 6, size: 192, elements: !49)
!49 = !{!50}
!50 = !DIDerivedType(tag: DW_TAG_member, name: "vas", scope: !48, file: !1, line: 7, baseType: !51, size: 192)
!51 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !52, line: 30, baseType: !53)
!52 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-31")
!53 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 28, baseType: !54)
!54 = !DICompositeType(tag: DW_TAG_array_type, baseType: !14, size: 192, elements: !55)
!55 = !{!56}
!56 = !DISubrange(count: 1)
!57 = !DILocalVariable(name: "s2", arg: 1, scope: !44, file: !1, line: 31, type: !47)
!58 = !DILocation(line: 31, column: 17, scope: !44)
!59 = !DILocalVariable(name: "args", arg: 2, scope: !44, file: !1, line: 31, type: !13)
!60 = !DILocation(line: 31, column: 29, scope: !44)
!61 = !DILocalVariable(name: "nt1", scope: !44, file: !1, line: 33, type: !34)
!62 = !DILocation(line: 33, column: 11, scope: !44)
!63 = !DILocation(line: 33, column: 17, scope: !44)
!64 = !DILocalVariable(name: "t2", scope: !44, file: !1, line: 34, type: !34)
!65 = !DILocation(line: 34, column: 11, scope: !44)
!66 = !DILocation(line: 34, column: 16, scope: !44)
!67 = !DILocalVariable(name: "nt2", scope: !44, file: !1, line: 35, type: !34)
!68 = !DILocation(line: 35, column: 11, scope: !44)
!69 = !DILocation(line: 35, column: 17, scope: !44)
!70 = !DILocalVariable(name: "nt3", scope: !44, file: !1, line: 36, type: !34)
!71 = !DILocation(line: 36, column: 11, scope: !44)
!72 = !DILocation(line: 36, column: 17, scope: !44)
!73 = !DILocalVariable(name: "t12", scope: !44, file: !1, line: 38, type: !34)
!74 = !DILocation(line: 38, column: 11, scope: !44)
!75 = !DILocation(line: 38, column: 17, scope: !44)
!76 = !DILocalVariable(name: "nt12", scope: !44, file: !1, line: 39, type: !34)
!77 = !DILocation(line: 39, column: 11, scope: !44)
!78 = !DILocation(line: 39, column: 18, scope: !44)
!79 = !DILocalVariable(name: "t22", scope: !44, file: !1, line: 40, type: !34)
!80 = !DILocation(line: 40, column: 11, scope: !44)
!81 = !DILocation(line: 40, column: 17, scope: !44)
!82 = !DILocalVariable(name: "nt22", scope: !44, file: !1, line: 41, type: !34)
!83 = !DILocation(line: 41, column: 11, scope: !44)
!84 = !DILocation(line: 41, column: 18, scope: !44)
!85 = !DILocalVariable(name: "ap1", scope: !44, file: !1, line: 43, type: !51)
!86 = !DILocation(line: 43, column: 13, scope: !44)
!87 = !DILocation(line: 44, column: 5, scope: !44)
!88 = !DILocalVariable(name: "a", scope: !44, file: !1, line: 46, type: !12)
!89 = !DILocation(line: 46, column: 9, scope: !44)
!90 = !DILocation(line: 46, column: 13, scope: !44)
!91 = !DILocalVariable(name: "t123", scope: !44, file: !1, line: 47, type: !34)
!92 = !DILocation(line: 47, column: 11, scope: !44)
!93 = !DILocation(line: 47, column: 18, scope: !44)
!94 = !DILocation(line: 49, column: 5, scope: !44)
!95 = !DILocalVariable(name: "ap2", scope: !44, file: !1, line: 51, type: !51)
!96 = !DILocation(line: 51, column: 13, scope: !44)
!97 = !DILocation(line: 52, column: 5, scope: !44)
!98 = !DILocation(line: 54, column: 9, scope: !44)
!99 = !DILocation(line: 54, column: 5, scope: !44)
!100 = !DILocation(line: 56, column: 5, scope: !44)
!101 = !DILocation(line: 58, column: 5, scope: !44)
!102 = distinct !DISubprogram(name: "forwarder", scope: !1, file: !1, line: 62, type: !103, isLocal: false, isDefinition: true, scopeLine: 63, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!103 = !DISubroutineType(types: !104)
!104 = !{!12, !12, null}
!105 = !DILocalVariable(name: "n", arg: 1, scope: !102, file: !1, line: 62, type: !12)
!106 = !DILocation(line: 62, column: 15, scope: !102)
!107 = !DILocalVariable(name: "s", scope: !102, file: !1, line: 64, type: !108)
!108 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 10, size: 192, elements: !109)
!109 = !{!110}
!110 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !108, file: !1, line: 11, baseType: !48, size: 192)
!111 = !DILocation(line: 64, column: 15, scope: !102)
!112 = !DILocation(line: 66, column: 5, scope: !102)
!113 = !DILocalVariable(name: "t1", scope: !102, file: !1, line: 68, type: !34)
!114 = !DILocation(line: 68, column: 11, scope: !102)
!115 = !DILocation(line: 68, column: 16, scope: !102)
!116 = !DILocalVariable(name: "rc", scope: !102, file: !1, line: 70, type: !12)
!117 = !DILocation(line: 70, column: 9, scope: !102)
!118 = !DILocation(line: 70, column: 22, scope: !102)
!119 = !DILocation(line: 70, column: 27, scope: !102)
!120 = !DILocation(line: 70, column: 29, scope: !102)
!121 = !DILocation(line: 70, column: 25, scope: !102)
!122 = !DILocation(line: 70, column: 40, scope: !102)
!123 = !DILocation(line: 70, column: 14, scope: !102)
!124 = !DILocation(line: 72, column: 5, scope: !102)
!125 = !DILocation(line: 74, column: 12, scope: !102)
!126 = !DILocation(line: 74, column: 5, scope: !102)
!127 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 78, type: !128, isLocal: false, isDefinition: true, scopeLine: 79, isOptimized: false, unit: !0, variables: !2)
!128 = !DISubroutineType(types: !129)
!129 = !{!12}
!130 = !DILocalVariable(name: "not_tainted", scope: !127, file: !1, line: 80, type: !34)
!131 = !DILocation(line: 80, column: 11, scope: !127)
!132 = !DILocalVariable(name: "tainted", scope: !127, file: !1, line: 81, type: !34)
!133 = !DILocation(line: 81, column: 11, scope: !127)
!134 = !DILocation(line: 81, column: 21, scope: !127)
!135 = !DILocalVariable(name: "rc", scope: !127, file: !1, line: 83, type: !12)
!136 = !DILocation(line: 83, column: 9, scope: !127)
!137 = !DILocation(line: 83, column: 27, scope: !127)
!138 = !DILocation(line: 83, column: 36, scope: !127)
!139 = !DILocation(line: 83, column: 49, scope: !127)
!140 = !DILocation(line: 83, column: 58, scope: !127)
!141 = !DILocation(line: 83, column: 71, scope: !127)
!142 = !DILocation(line: 83, column: 14, scope: !127)
!143 = !DILocation(line: 85, column: 12, scope: !127)
!144 = !DILocation(line: 85, column: 5, scope: !127)
