; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"hello world\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %n, ...) #0 !dbg !10 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %v0 = alloca i8*, align 8
  %v1 = alloca i8*, align 8
  %t = alloca i32, align 4
  %nt = alloca i8*, align 8
  %v2 = alloca i8*, align 8
  %v3 = alloca i8*, align 8
  %no = alloca i8*, align 8
  %nt_1 = alloca i32, align 4
  %nt_2 = alloca i32, align 4
  %t1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !16, metadata !14), !dbg !30
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !31
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !31
  call void @llvm.va_start(i8* %arraydecay1), !dbg !31
  call void @llvm.dbg.declare(metadata i8** %v0, metadata !32, metadata !14), !dbg !35
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !36
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !36
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !36
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !36
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !36

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !36
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !36
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !36
  %2 = bitcast i8* %1 to i8**, !dbg !36
  %3 = add i32 %gp_offset, 8, !dbg !36
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !36
  br label %vaarg.end, !dbg !36

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !36
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !36
  %4 = bitcast i8* %overflow_arg_area to i8**, !dbg !36
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !36
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !36
  br label %vaarg.end, !dbg !36

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !36
  %5 = load i8*, i8** %vaarg.addr, align 8, !dbg !36
  store i8* %5, i8** %v0, align 8, !dbg !35
  %6 = load i8*, i8** %v0, align 8, !dbg !37
  %cmp = icmp ne i8* %6, null, !dbg !38
  %conv = zext i1 %cmp to i32, !dbg !38
  switch i32 %conv, label %sw.default [
    i32 0, label %sw.bb
  ], !dbg !39

sw.bb:                                            ; preds = %vaarg.end
  br label %do.body, !dbg !40, !llvm.loop !42

do.body:                                          ; preds = %do.cond, %sw.bb
  call void @llvm.dbg.declare(metadata i8** %v1, metadata !44, metadata !14), !dbg !46
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !47
  %gp_offset_p4 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 0, !dbg !47
  %gp_offset5 = load i32, i32* %gp_offset_p4, align 16, !dbg !47
  %fits_in_gp6 = icmp ule i32 %gp_offset5, 40, !dbg !47
  br i1 %fits_in_gp6, label %vaarg.in_reg7, label %vaarg.in_mem9, !dbg !47

vaarg.in_reg7:                                    ; preds = %do.body
  %7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 3, !dbg !47
  %reg_save_area8 = load i8*, i8** %7, align 16, !dbg !47
  %8 = getelementptr i8, i8* %reg_save_area8, i32 %gp_offset5, !dbg !47
  %9 = bitcast i8* %8 to i8**, !dbg !47
  %10 = add i32 %gp_offset5, 8, !dbg !47
  store i32 %10, i32* %gp_offset_p4, align 16, !dbg !47
  br label %vaarg.end13, !dbg !47

vaarg.in_mem9:                                    ; preds = %do.body
  %overflow_arg_area_p10 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !47
  %overflow_arg_area11 = load i8*, i8** %overflow_arg_area_p10, align 8, !dbg !47
  %11 = bitcast i8* %overflow_arg_area11 to i8**, !dbg !47
  %overflow_arg_area.next12 = getelementptr i8, i8* %overflow_arg_area11, i32 8, !dbg !47
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10, align 8, !dbg !47
  br label %vaarg.end13, !dbg !47

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %vaarg.addr14 = phi i8** [ %9, %vaarg.in_reg7 ], [ %11, %vaarg.in_mem9 ], !dbg !47
  %12 = load i8*, i8** %vaarg.addr14, align 8, !dbg !47
  store i8* %12, i8** %v1, align 8, !dbg !46
  br label %do.cond, !dbg !48

do.cond:                                          ; preds = %vaarg.end13
  br i1 true, label %do.body, label %do.end, !dbg !48, !llvm.loop !42

do.end:                                           ; preds = %do.cond
  br label %sw.default, !dbg !48

sw.default:                                       ; preds = %vaarg.end, %do.end
  call void @llvm.dbg.declare(metadata i32* %t, metadata !49, metadata !14), !dbg !50
  store i32 1, i32* %t, align 4, !dbg !50
  br label %sw.epilog, !dbg !51

sw.epilog:                                        ; preds = %sw.default
  call void @llvm.dbg.declare(metadata i8** %nt, metadata !52, metadata !14), !dbg !53
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0), i8** %nt, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata i8** %v2, metadata !54, metadata !14), !dbg !55
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !56
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !56
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 16, !dbg !56
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !56
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !56

vaarg.in_reg19:                                   ; preds = %sw.epilog
  %13 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !56
  %reg_save_area20 = load i8*, i8** %13, align 16, !dbg !56
  %14 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !56
  %15 = bitcast i8* %14 to i8**, !dbg !56
  %16 = add i32 %gp_offset17, 8, !dbg !56
  store i32 %16, i32* %gp_offset_p16, align 16, !dbg !56
  br label %vaarg.end25, !dbg !56

vaarg.in_mem21:                                   ; preds = %sw.epilog
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !56
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !56
  %17 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !56
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !56
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !56
  br label %vaarg.end25, !dbg !56

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %15, %vaarg.in_reg19 ], [ %17, %vaarg.in_mem21 ], !dbg !56
  %18 = load i8*, i8** %vaarg.addr26, align 8, !dbg !56
  store i8* %18, i8** %v2, align 8, !dbg !55
  call void @llvm.dbg.declare(metadata i8** %v3, metadata !57, metadata !14), !dbg !58
  %arraydecay27 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !59
  %gp_offset_p28 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay27, i32 0, i32 0, !dbg !59
  %gp_offset29 = load i32, i32* %gp_offset_p28, align 16, !dbg !59
  %fits_in_gp30 = icmp ule i32 %gp_offset29, 40, !dbg !59
  br i1 %fits_in_gp30, label %vaarg.in_reg31, label %vaarg.in_mem33, !dbg !59

vaarg.in_reg31:                                   ; preds = %vaarg.end25
  %19 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay27, i32 0, i32 3, !dbg !59
  %reg_save_area32 = load i8*, i8** %19, align 16, !dbg !59
  %20 = getelementptr i8, i8* %reg_save_area32, i32 %gp_offset29, !dbg !59
  %21 = bitcast i8* %20 to i8**, !dbg !59
  %22 = add i32 %gp_offset29, 8, !dbg !59
  store i32 %22, i32* %gp_offset_p28, align 16, !dbg !59
  br label %vaarg.end37, !dbg !59

vaarg.in_mem33:                                   ; preds = %vaarg.end25
  %overflow_arg_area_p34 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay27, i32 0, i32 2, !dbg !59
  %overflow_arg_area35 = load i8*, i8** %overflow_arg_area_p34, align 8, !dbg !59
  %23 = bitcast i8* %overflow_arg_area35 to i8**, !dbg !59
  %overflow_arg_area.next36 = getelementptr i8, i8* %overflow_arg_area35, i32 8, !dbg !59
  store i8* %overflow_arg_area.next36, i8** %overflow_arg_area_p34, align 8, !dbg !59
  br label %vaarg.end37, !dbg !59

vaarg.end37:                                      ; preds = %vaarg.in_mem33, %vaarg.in_reg31
  %vaarg.addr38 = phi i8** [ %21, %vaarg.in_reg31 ], [ %23, %vaarg.in_mem33 ], !dbg !59
  %24 = load i8*, i8** %vaarg.addr38, align 8, !dbg !59
  store i8* %24, i8** %v3, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata i8** %no, metadata !60, metadata !14), !dbg !61
  %arraydecay39 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !62
  %gp_offset_p40 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay39, i32 0, i32 0, !dbg !62
  %gp_offset41 = load i32, i32* %gp_offset_p40, align 16, !dbg !62
  %fits_in_gp42 = icmp ule i32 %gp_offset41, 40, !dbg !62
  br i1 %fits_in_gp42, label %vaarg.in_reg43, label %vaarg.in_mem45, !dbg !62

vaarg.in_reg43:                                   ; preds = %vaarg.end37
  %25 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay39, i32 0, i32 3, !dbg !62
  %reg_save_area44 = load i8*, i8** %25, align 16, !dbg !62
  %26 = getelementptr i8, i8* %reg_save_area44, i32 %gp_offset41, !dbg !62
  %27 = bitcast i8* %26 to i8**, !dbg !62
  %28 = add i32 %gp_offset41, 8, !dbg !62
  store i32 %28, i32* %gp_offset_p40, align 16, !dbg !62
  br label %vaarg.end49, !dbg !62

vaarg.in_mem45:                                   ; preds = %vaarg.end37
  %overflow_arg_area_p46 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay39, i32 0, i32 2, !dbg !62
  %overflow_arg_area47 = load i8*, i8** %overflow_arg_area_p46, align 8, !dbg !62
  %29 = bitcast i8* %overflow_arg_area47 to i8**, !dbg !62
  %overflow_arg_area.next48 = getelementptr i8, i8* %overflow_arg_area47, i32 8, !dbg !62
  store i8* %overflow_arg_area.next48, i8** %overflow_arg_area_p46, align 8, !dbg !62
  br label %vaarg.end49, !dbg !62

vaarg.end49:                                      ; preds = %vaarg.in_mem45, %vaarg.in_reg43
  %vaarg.addr50 = phi i8** [ %27, %vaarg.in_reg43 ], [ %29, %vaarg.in_mem45 ], !dbg !62
  %30 = load i8*, i8** %vaarg.addr50, align 8, !dbg !62
  store i8* %30, i8** %no, align 8, !dbg !61
  call void @llvm.dbg.declare(metadata i32* %nt_1, metadata !63, metadata !14), !dbg !64
  store i32 1, i32* %nt_1, align 4, !dbg !64
  %arraydecay51 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !65
  %arraydecay5152 = bitcast %struct.__va_list_tag* %arraydecay51 to i8*, !dbg !65
  call void @llvm.va_end(i8* %arraydecay5152), !dbg !65
  call void @llvm.dbg.declare(metadata i32* %nt_2, metadata !66, metadata !14), !dbg !67
  store i32 1, i32* %nt_2, align 4, !dbg !67
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !68, metadata !14), !dbg !69
  %31 = load i8*, i8** %v2, align 8, !dbg !70
  store i8* %31, i8** %t1, align 8, !dbg !69
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !71, metadata !14), !dbg !72
  %32 = load i8*, i8** %v3, align 8, !dbg !73
  store i8* %32, i8** %t2, align 8, !dbg !72
  ret i32 0, !dbg !74
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !75 {
entry:
  %retval = alloca i32, align 4
  %not_tainted = alloca i8*, align 8
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !78, metadata !14), !dbg !79
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0), i8** %not_tainted, align 8, !dbg !79
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !80, metadata !14), !dbg !81
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !82
  store i8* %call, i8** %tainted, align 8, !dbg !81
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !83, metadata !14), !dbg !84
  %0 = load i8*, i8** %tainted, align 8, !dbg !85
  %1 = load i8*, i8** %not_tainted, align 8, !dbg !86
  %2 = load i8*, i8** %tainted, align 8, !dbg !87
  %3 = load i8*, i8** %not_tainted, align 8, !dbg !88
  %4 = load i8*, i8** %not_tainted, align 8, !dbg !89
  %call1 = call i32 (i32, ...) @foo(i32 6, i8* %0, i8* %1, i8* %2, i8* %3, i8* %4), !dbg !90
  store i32 %call1, i32* %rc, align 4, !dbg !84
  %5 = load i32, i32* %rc, align 4, !dbg !91
  ret i32 %5, !dbg !92
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-16")
!2 = !{}
!3 = !{!4, !5}
!4 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!6 = !{i32 2, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!10 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 7, type: !11, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!4, !4, null}
!13 = !DILocalVariable(name: "n", arg: 1, scope: !10, file: !1, line: 7, type: !4)
!14 = !DIExpression()
!15 = !DILocation(line: 7, column: 9, scope: !10)
!16 = !DILocalVariable(name: "ap", scope: !10, file: !1, line: 9, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !18, line: 30, baseType: !19)
!18 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-16")
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 9, baseType: !20)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 192, elements: !28)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 9, size: 192, elements: !22)
!22 = !{!23, !25, !26, !27}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !21, file: !1, line: 9, baseType: !24, size: 32)
!24 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !21, file: !1, line: 9, baseType: !24, size: 32, offset: 32)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !21, file: !1, line: 9, baseType: !5, size: 64, offset: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !21, file: !1, line: 9, baseType: !5, size: 64, offset: 128)
!28 = !{!29}
!29 = !DISubrange(count: 1)
!30 = !DILocation(line: 9, column: 13, scope: !10)
!31 = !DILocation(line: 10, column: 5, scope: !10)
!32 = !DILocalVariable(name: "v0", scope: !10, file: !1, line: 12, type: !33)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!35 = !DILocation(line: 12, column: 11, scope: !10)
!36 = !DILocation(line: 12, column: 16, scope: !10)
!37 = !DILocation(line: 14, column: 19, scope: !10)
!38 = !DILocation(line: 14, column: 22, scope: !10)
!39 = !DILocation(line: 14, column: 5, scope: !10)
!40 = !DILocation(line: 17, column: 9, scope: !41)
!41 = distinct !DILexicalBlock(scope: !10, file: !1, line: 14, column: 32)
!42 = distinct !{!42, !40, !43}
!43 = !DILocation(line: 19, column: 19, scope: !41)
!44 = !DILocalVariable(name: "v1", scope: !45, file: !1, line: 18, type: !33)
!45 = distinct !DILexicalBlock(scope: !41, file: !1, line: 17, column: 12)
!46 = !DILocation(line: 18, column: 19, scope: !45)
!47 = !DILocation(line: 18, column: 24, scope: !45)
!48 = !DILocation(line: 19, column: 9, scope: !45)
!49 = !DILocalVariable(name: "t", scope: !41, file: !1, line: 22, type: !4)
!50 = !DILocation(line: 22, column: 13, scope: !41)
!51 = !DILocation(line: 23, column: 5, scope: !41)
!52 = !DILocalVariable(name: "nt", scope: !10, file: !1, line: 25, type: !33)
!53 = !DILocation(line: 25, column: 11, scope: !10)
!54 = !DILocalVariable(name: "v2", scope: !10, file: !1, line: 27, type: !33)
!55 = !DILocation(line: 27, column: 11, scope: !10)
!56 = !DILocation(line: 27, column: 16, scope: !10)
!57 = !DILocalVariable(name: "v3", scope: !10, file: !1, line: 28, type: !33)
!58 = !DILocation(line: 28, column: 11, scope: !10)
!59 = !DILocation(line: 28, column: 16, scope: !10)
!60 = !DILocalVariable(name: "no", scope: !10, file: !1, line: 30, type: !33)
!61 = !DILocation(line: 30, column: 11, scope: !10)
!62 = !DILocation(line: 30, column: 16, scope: !10)
!63 = !DILocalVariable(name: "nt_1", scope: !10, file: !1, line: 32, type: !4)
!64 = !DILocation(line: 32, column: 9, scope: !10)
!65 = !DILocation(line: 34, column: 5, scope: !10)
!66 = !DILocalVariable(name: "nt_2", scope: !10, file: !1, line: 36, type: !4)
!67 = !DILocation(line: 36, column: 9, scope: !10)
!68 = !DILocalVariable(name: "t1", scope: !10, file: !1, line: 38, type: !33)
!69 = !DILocation(line: 38, column: 11, scope: !10)
!70 = !DILocation(line: 38, column: 16, scope: !10)
!71 = !DILocalVariable(name: "t2", scope: !10, file: !1, line: 39, type: !33)
!72 = !DILocation(line: 39, column: 11, scope: !10)
!73 = !DILocation(line: 39, column: 16, scope: !10)
!74 = !DILocation(line: 41, column: 5, scope: !10)
!75 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 45, type: !76, isLocal: false, isDefinition: true, scopeLine: 46, isOptimized: false, unit: !0, variables: !2)
!76 = !DISubroutineType(types: !77)
!77 = !{!4}
!78 = !DILocalVariable(name: "not_tainted", scope: !75, file: !1, line: 47, type: !33)
!79 = !DILocation(line: 47, column: 11, scope: !75)
!80 = !DILocalVariable(name: "tainted", scope: !75, file: !1, line: 48, type: !33)
!81 = !DILocation(line: 48, column: 11, scope: !75)
!82 = !DILocation(line: 48, column: 21, scope: !75)
!83 = !DILocalVariable(name: "rc", scope: !75, file: !1, line: 50, type: !4)
!84 = !DILocation(line: 50, column: 9, scope: !75)
!85 = !DILocation(line: 50, column: 21, scope: !75)
!86 = !DILocation(line: 50, column: 30, scope: !75)
!87 = !DILocation(line: 50, column: 43, scope: !75)
!88 = !DILocation(line: 50, column: 52, scope: !75)
!89 = !DILocation(line: 50, column: 65, scope: !75)
!90 = !DILocation(line: 50, column: 14, scope: !75)
!91 = !DILocation(line: 52, column: 12, scope: !75)
!92 = !DILocation(line: 52, column: 5, scope: !75)
