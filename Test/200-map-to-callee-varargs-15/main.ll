; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"hello world\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %n, ...) #0 !dbg !9 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %v0 = alloca i8*, align 8
  %v1 = alloca i8*, align 8
  %nt = alloca i8*, align 8
  %v2 = alloca i8*, align 8
  %v3 = alloca i8*, align 8
  %no = alloca i8*, align 8
  %nt_1 = alloca i32, align 4
  %nt_2 = alloca i32, align 4
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
  %cmp = icmp ne i8* %6, null, !dbg !39
  br i1 %cmp, label %if.then, label %if.end, !dbg !40

if.then:                                          ; preds = %vaarg.end
  call void @llvm.dbg.declare(metadata i8** %v1, metadata !41, metadata !14), !dbg !43
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !44
  %gp_offset_p4 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 0, !dbg !44
  %gp_offset5 = load i32, i32* %gp_offset_p4, align 16, !dbg !44
  %fits_in_gp6 = icmp ule i32 %gp_offset5, 40, !dbg !44
  br i1 %fits_in_gp6, label %vaarg.in_reg7, label %vaarg.in_mem9, !dbg !44

vaarg.in_reg7:                                    ; preds = %if.then
  %7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 3, !dbg !44
  %reg_save_area8 = load i8*, i8** %7, align 16, !dbg !44
  %8 = getelementptr i8, i8* %reg_save_area8, i32 %gp_offset5, !dbg !44
  %9 = bitcast i8* %8 to i8**, !dbg !44
  %10 = add i32 %gp_offset5, 8, !dbg !44
  store i32 %10, i32* %gp_offset_p4, align 16, !dbg !44
  br label %vaarg.end13, !dbg !44

vaarg.in_mem9:                                    ; preds = %if.then
  %overflow_arg_area_p10 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !44
  %overflow_arg_area11 = load i8*, i8** %overflow_arg_area_p10, align 8, !dbg !44
  %11 = bitcast i8* %overflow_arg_area11 to i8**, !dbg !44
  %overflow_arg_area.next12 = getelementptr i8, i8* %overflow_arg_area11, i32 8, !dbg !44
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10, align 8, !dbg !44
  br label %vaarg.end13, !dbg !44

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %vaarg.addr14 = phi i8** [ %9, %vaarg.in_reg7 ], [ %11, %vaarg.in_mem9 ], !dbg !44
  %12 = load i8*, i8** %vaarg.addr14, align 8, !dbg !44
  store i8* %12, i8** %v1, align 8, !dbg !43
  br label %if.end, !dbg !45

if.end:                                           ; preds = %vaarg.end13, %vaarg.end
  call void @llvm.dbg.declare(metadata i8** %nt, metadata !46, metadata !14), !dbg !47
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0), i8** %nt, align 8, !dbg !47
  call void @llvm.dbg.declare(metadata i8** %v2, metadata !48, metadata !14), !dbg !49
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !50
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !50
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 16, !dbg !50
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !50
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !50

vaarg.in_reg19:                                   ; preds = %if.end
  %13 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !50
  %reg_save_area20 = load i8*, i8** %13, align 16, !dbg !50
  %14 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !50
  %15 = bitcast i8* %14 to i8**, !dbg !50
  %16 = add i32 %gp_offset17, 8, !dbg !50
  store i32 %16, i32* %gp_offset_p16, align 16, !dbg !50
  br label %vaarg.end25, !dbg !50

vaarg.in_mem21:                                   ; preds = %if.end
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !50
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !50
  %17 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !50
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !50
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !50
  br label %vaarg.end25, !dbg !50

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %15, %vaarg.in_reg19 ], [ %17, %vaarg.in_mem21 ], !dbg !50
  %18 = load i8*, i8** %vaarg.addr26, align 8, !dbg !50
  store i8* %18, i8** %v2, align 8, !dbg !49
  call void @llvm.dbg.declare(metadata i8** %v3, metadata !51, metadata !14), !dbg !52
  %arraydecay27 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !53
  %gp_offset_p28 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay27, i32 0, i32 0, !dbg !53
  %gp_offset29 = load i32, i32* %gp_offset_p28, align 16, !dbg !53
  %fits_in_gp30 = icmp ule i32 %gp_offset29, 40, !dbg !53
  br i1 %fits_in_gp30, label %vaarg.in_reg31, label %vaarg.in_mem33, !dbg !53

vaarg.in_reg31:                                   ; preds = %vaarg.end25
  %19 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay27, i32 0, i32 3, !dbg !53
  %reg_save_area32 = load i8*, i8** %19, align 16, !dbg !53
  %20 = getelementptr i8, i8* %reg_save_area32, i32 %gp_offset29, !dbg !53
  %21 = bitcast i8* %20 to i8**, !dbg !53
  %22 = add i32 %gp_offset29, 8, !dbg !53
  store i32 %22, i32* %gp_offset_p28, align 16, !dbg !53
  br label %vaarg.end37, !dbg !53

vaarg.in_mem33:                                   ; preds = %vaarg.end25
  %overflow_arg_area_p34 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay27, i32 0, i32 2, !dbg !53
  %overflow_arg_area35 = load i8*, i8** %overflow_arg_area_p34, align 8, !dbg !53
  %23 = bitcast i8* %overflow_arg_area35 to i8**, !dbg !53
  %overflow_arg_area.next36 = getelementptr i8, i8* %overflow_arg_area35, i32 8, !dbg !53
  store i8* %overflow_arg_area.next36, i8** %overflow_arg_area_p34, align 8, !dbg !53
  br label %vaarg.end37, !dbg !53

vaarg.end37:                                      ; preds = %vaarg.in_mem33, %vaarg.in_reg31
  %vaarg.addr38 = phi i8** [ %21, %vaarg.in_reg31 ], [ %23, %vaarg.in_mem33 ], !dbg !53
  %24 = load i8*, i8** %vaarg.addr38, align 8, !dbg !53
  store i8* %24, i8** %v3, align 8, !dbg !52
  call void @llvm.dbg.declare(metadata i8** %no, metadata !54, metadata !14), !dbg !55
  %arraydecay39 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !56
  %gp_offset_p40 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay39, i32 0, i32 0, !dbg !56
  %gp_offset41 = load i32, i32* %gp_offset_p40, align 16, !dbg !56
  %fits_in_gp42 = icmp ule i32 %gp_offset41, 40, !dbg !56
  br i1 %fits_in_gp42, label %vaarg.in_reg43, label %vaarg.in_mem45, !dbg !56

vaarg.in_reg43:                                   ; preds = %vaarg.end37
  %25 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay39, i32 0, i32 3, !dbg !56
  %reg_save_area44 = load i8*, i8** %25, align 16, !dbg !56
  %26 = getelementptr i8, i8* %reg_save_area44, i32 %gp_offset41, !dbg !56
  %27 = bitcast i8* %26 to i8**, !dbg !56
  %28 = add i32 %gp_offset41, 8, !dbg !56
  store i32 %28, i32* %gp_offset_p40, align 16, !dbg !56
  br label %vaarg.end49, !dbg !56

vaarg.in_mem45:                                   ; preds = %vaarg.end37
  %overflow_arg_area_p46 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay39, i32 0, i32 2, !dbg !56
  %overflow_arg_area47 = load i8*, i8** %overflow_arg_area_p46, align 8, !dbg !56
  %29 = bitcast i8* %overflow_arg_area47 to i8**, !dbg !56
  %overflow_arg_area.next48 = getelementptr i8, i8* %overflow_arg_area47, i32 8, !dbg !56
  store i8* %overflow_arg_area.next48, i8** %overflow_arg_area_p46, align 8, !dbg !56
  br label %vaarg.end49, !dbg !56

vaarg.end49:                                      ; preds = %vaarg.in_mem45, %vaarg.in_reg43
  %vaarg.addr50 = phi i8** [ %27, %vaarg.in_reg43 ], [ %29, %vaarg.in_mem45 ], !dbg !56
  %30 = load i8*, i8** %vaarg.addr50, align 8, !dbg !56
  store i8* %30, i8** %no, align 8, !dbg !55
  call void @llvm.dbg.declare(metadata i32* %nt_1, metadata !57, metadata !14), !dbg !58
  store i32 1, i32* %nt_1, align 4, !dbg !58
  %arraydecay51 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !59
  %arraydecay5152 = bitcast %struct.__va_list_tag* %arraydecay51 to i8*, !dbg !59
  call void @llvm.va_end(i8* %arraydecay5152), !dbg !59
  call void @llvm.dbg.declare(metadata i32* %nt_2, metadata !60, metadata !14), !dbg !61
  store i32 1, i32* %nt_2, align 4, !dbg !61
  ret i32 0, !dbg !62
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !63 {
entry:
  %retval = alloca i32, align 4
  %not_tainted = alloca i8*, align 8
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !66, metadata !14), !dbg !67
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0), i8** %not_tainted, align 8, !dbg !67
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !68, metadata !14), !dbg !69
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !70
  store i8* %call, i8** %tainted, align 8, !dbg !69
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !71, metadata !14), !dbg !72
  %0 = load i8*, i8** %tainted, align 8, !dbg !73
  %1 = load i8*, i8** %not_tainted, align 8, !dbg !74
  %2 = load i8*, i8** %tainted, align 8, !dbg !75
  %3 = load i8*, i8** %not_tainted, align 8, !dbg !76
  %4 = load i8*, i8** %not_tainted, align 8, !dbg !77
  %call1 = call i32 (i32, ...) @foo(i32 6, i8* %0, i8* %1, i8* %2, i8* %3, i8* %4), !dbg !78
  store i32 %call1, i32* %rc, align 4, !dbg !72
  %5 = load i32, i32* %rc, align 4, !dbg !79
  ret i32 %5, !dbg !80
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-15")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 7, type: !10, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !12, null}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "n", arg: 1, scope: !9, file: !1, line: 7, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 7, column: 9, scope: !9)
!16 = !DILocalVariable(name: "ap", scope: !9, file: !1, line: 9, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !18, line: 30, baseType: !19)
!18 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-15")
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 9, baseType: !20)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 192, elements: !28)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 9, size: 192, elements: !22)
!22 = !{!23, !25, !26, !27}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !21, file: !1, line: 9, baseType: !24, size: 32)
!24 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !21, file: !1, line: 9, baseType: !24, size: 32, offset: 32)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !21, file: !1, line: 9, baseType: !4, size: 64, offset: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !21, file: !1, line: 9, baseType: !4, size: 64, offset: 128)
!28 = !{!29}
!29 = !DISubrange(count: 1)
!30 = !DILocation(line: 9, column: 13, scope: !9)
!31 = !DILocation(line: 10, column: 5, scope: !9)
!32 = !DILocalVariable(name: "v0", scope: !9, file: !1, line: 12, type: !33)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!35 = !DILocation(line: 12, column: 11, scope: !9)
!36 = !DILocation(line: 12, column: 16, scope: !9)
!37 = !DILocation(line: 14, column: 9, scope: !38)
!38 = distinct !DILexicalBlock(scope: !9, file: !1, line: 14, column: 9)
!39 = !DILocation(line: 14, column: 12, scope: !38)
!40 = !DILocation(line: 14, column: 9, scope: !9)
!41 = !DILocalVariable(name: "v1", scope: !42, file: !1, line: 15, type: !33)
!42 = distinct !DILexicalBlock(scope: !38, file: !1, line: 14, column: 21)
!43 = !DILocation(line: 15, column: 15, scope: !42)
!44 = !DILocation(line: 15, column: 20, scope: !42)
!45 = !DILocation(line: 16, column: 5, scope: !42)
!46 = !DILocalVariable(name: "nt", scope: !9, file: !1, line: 18, type: !33)
!47 = !DILocation(line: 18, column: 11, scope: !9)
!48 = !DILocalVariable(name: "v2", scope: !9, file: !1, line: 20, type: !33)
!49 = !DILocation(line: 20, column: 11, scope: !9)
!50 = !DILocation(line: 20, column: 16, scope: !9)
!51 = !DILocalVariable(name: "v3", scope: !9, file: !1, line: 21, type: !33)
!52 = !DILocation(line: 21, column: 11, scope: !9)
!53 = !DILocation(line: 21, column: 16, scope: !9)
!54 = !DILocalVariable(name: "no", scope: !9, file: !1, line: 23, type: !33)
!55 = !DILocation(line: 23, column: 11, scope: !9)
!56 = !DILocation(line: 23, column: 16, scope: !9)
!57 = !DILocalVariable(name: "nt_1", scope: !9, file: !1, line: 25, type: !12)
!58 = !DILocation(line: 25, column: 9, scope: !9)
!59 = !DILocation(line: 27, column: 5, scope: !9)
!60 = !DILocalVariable(name: "nt_2", scope: !9, file: !1, line: 29, type: !12)
!61 = !DILocation(line: 29, column: 9, scope: !9)
!62 = !DILocation(line: 31, column: 5, scope: !9)
!63 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 35, type: !64, isLocal: false, isDefinition: true, scopeLine: 36, isOptimized: false, unit: !0, variables: !2)
!64 = !DISubroutineType(types: !65)
!65 = !{!12}
!66 = !DILocalVariable(name: "not_tainted", scope: !63, file: !1, line: 37, type: !33)
!67 = !DILocation(line: 37, column: 11, scope: !63)
!68 = !DILocalVariable(name: "tainted", scope: !63, file: !1, line: 38, type: !33)
!69 = !DILocation(line: 38, column: 11, scope: !63)
!70 = !DILocation(line: 38, column: 21, scope: !63)
!71 = !DILocalVariable(name: "rc", scope: !63, file: !1, line: 40, type: !12)
!72 = !DILocation(line: 40, column: 9, scope: !63)
!73 = !DILocation(line: 40, column: 21, scope: !63)
!74 = !DILocation(line: 40, column: 30, scope: !63)
!75 = !DILocation(line: 40, column: 43, scope: !63)
!76 = !DILocation(line: 40, column: 52, scope: !63)
!77 = !DILocation(line: 40, column: 65, scope: !63)
!78 = !DILocation(line: 40, column: 14, scope: !63)
!79 = !DILocation(line: 42, column: 12, scope: !63)
!80 = !DILocation(line: 42, column: 5, scope: !63)
