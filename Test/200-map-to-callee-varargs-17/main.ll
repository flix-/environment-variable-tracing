; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [12 x i8] c"hello world\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @user(%struct.__va_list_tag* %args) #0 !dbg !7 {
entry:
  %args.addr = alloca %struct.__va_list_tag*, align 8
  %t1 = alloca i8*, align 8
  %nt1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %nt2 = alloca i8*, align 8
  %nt3 = alloca i8*, align 8
  store %struct.__va_list_tag* %args, %struct.__va_list_tag** %args.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.__va_list_tag** %args.addr, metadata !20, metadata !21), !dbg !22
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !23, metadata !21), !dbg !26
  %0 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !27
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 0, !dbg !27
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !27
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !27
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !27

vaarg.in_reg:                                     ; preds = %entry
  %1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 3, !dbg !27
  %reg_save_area = load i8*, i8** %1, align 8, !dbg !27
  %2 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !27
  %3 = bitcast i8* %2 to i8**, !dbg !27
  %4 = add i32 %gp_offset, 8, !dbg !27
  store i32 %4, i32* %gp_offset_p, align 8, !dbg !27
  br label %vaarg.end, !dbg !27

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 2, !dbg !27
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !27
  %5 = bitcast i8* %overflow_arg_area to i8**, !dbg !27
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !27
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !27
  br label %vaarg.end, !dbg !27

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %3, %vaarg.in_reg ], [ %5, %vaarg.in_mem ], !dbg !27
  %6 = load i8*, i8** %vaarg.addr, align 8, !dbg !27
  store i8* %6, i8** %t1, align 8, !dbg !26
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !28, metadata !21), !dbg !29
  %7 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !30
  %gp_offset_p1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 0, !dbg !30
  %gp_offset2 = load i32, i32* %gp_offset_p1, align 8, !dbg !30
  %fits_in_gp3 = icmp ule i32 %gp_offset2, 40, !dbg !30
  br i1 %fits_in_gp3, label %vaarg.in_reg4, label %vaarg.in_mem6, !dbg !30

vaarg.in_reg4:                                    ; preds = %vaarg.end
  %8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 3, !dbg !30
  %reg_save_area5 = load i8*, i8** %8, align 8, !dbg !30
  %9 = getelementptr i8, i8* %reg_save_area5, i32 %gp_offset2, !dbg !30
  %10 = bitcast i8* %9 to i8**, !dbg !30
  %11 = add i32 %gp_offset2, 8, !dbg !30
  store i32 %11, i32* %gp_offset_p1, align 8, !dbg !30
  br label %vaarg.end10, !dbg !30

vaarg.in_mem6:                                    ; preds = %vaarg.end
  %overflow_arg_area_p7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 2, !dbg !30
  %overflow_arg_area8 = load i8*, i8** %overflow_arg_area_p7, align 8, !dbg !30
  %12 = bitcast i8* %overflow_arg_area8 to i8**, !dbg !30
  %overflow_arg_area.next9 = getelementptr i8, i8* %overflow_arg_area8, i32 8, !dbg !30
  store i8* %overflow_arg_area.next9, i8** %overflow_arg_area_p7, align 8, !dbg !30
  br label %vaarg.end10, !dbg !30

vaarg.end10:                                      ; preds = %vaarg.in_mem6, %vaarg.in_reg4
  %vaarg.addr11 = phi i8** [ %10, %vaarg.in_reg4 ], [ %12, %vaarg.in_mem6 ], !dbg !30
  %13 = load i8*, i8** %vaarg.addr11, align 8, !dbg !30
  store i8* %13, i8** %nt1, align 8, !dbg !29
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !31, metadata !21), !dbg !32
  %14 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !33
  %gp_offset_p12 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 0, !dbg !33
  %gp_offset13 = load i32, i32* %gp_offset_p12, align 8, !dbg !33
  %fits_in_gp14 = icmp ule i32 %gp_offset13, 40, !dbg !33
  br i1 %fits_in_gp14, label %vaarg.in_reg15, label %vaarg.in_mem17, !dbg !33

vaarg.in_reg15:                                   ; preds = %vaarg.end10
  %15 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 3, !dbg !33
  %reg_save_area16 = load i8*, i8** %15, align 8, !dbg !33
  %16 = getelementptr i8, i8* %reg_save_area16, i32 %gp_offset13, !dbg !33
  %17 = bitcast i8* %16 to i8**, !dbg !33
  %18 = add i32 %gp_offset13, 8, !dbg !33
  store i32 %18, i32* %gp_offset_p12, align 8, !dbg !33
  br label %vaarg.end21, !dbg !33

vaarg.in_mem17:                                   ; preds = %vaarg.end10
  %overflow_arg_area_p18 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 2, !dbg !33
  %overflow_arg_area19 = load i8*, i8** %overflow_arg_area_p18, align 8, !dbg !33
  %19 = bitcast i8* %overflow_arg_area19 to i8**, !dbg !33
  %overflow_arg_area.next20 = getelementptr i8, i8* %overflow_arg_area19, i32 8, !dbg !33
  store i8* %overflow_arg_area.next20, i8** %overflow_arg_area_p18, align 8, !dbg !33
  br label %vaarg.end21, !dbg !33

vaarg.end21:                                      ; preds = %vaarg.in_mem17, %vaarg.in_reg15
  %vaarg.addr22 = phi i8** [ %17, %vaarg.in_reg15 ], [ %19, %vaarg.in_mem17 ], !dbg !33
  %20 = load i8*, i8** %vaarg.addr22, align 8, !dbg !33
  store i8* %20, i8** %t2, align 8, !dbg !32
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !34, metadata !21), !dbg !35
  %21 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !36
  %gp_offset_p23 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 0, !dbg !36
  %gp_offset24 = load i32, i32* %gp_offset_p23, align 8, !dbg !36
  %fits_in_gp25 = icmp ule i32 %gp_offset24, 40, !dbg !36
  br i1 %fits_in_gp25, label %vaarg.in_reg26, label %vaarg.in_mem28, !dbg !36

vaarg.in_reg26:                                   ; preds = %vaarg.end21
  %22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 3, !dbg !36
  %reg_save_area27 = load i8*, i8** %22, align 8, !dbg !36
  %23 = getelementptr i8, i8* %reg_save_area27, i32 %gp_offset24, !dbg !36
  %24 = bitcast i8* %23 to i8**, !dbg !36
  %25 = add i32 %gp_offset24, 8, !dbg !36
  store i32 %25, i32* %gp_offset_p23, align 8, !dbg !36
  br label %vaarg.end32, !dbg !36

vaarg.in_mem28:                                   ; preds = %vaarg.end21
  %overflow_arg_area_p29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 2, !dbg !36
  %overflow_arg_area30 = load i8*, i8** %overflow_arg_area_p29, align 8, !dbg !36
  %26 = bitcast i8* %overflow_arg_area30 to i8**, !dbg !36
  %overflow_arg_area.next31 = getelementptr i8, i8* %overflow_arg_area30, i32 8, !dbg !36
  store i8* %overflow_arg_area.next31, i8** %overflow_arg_area_p29, align 8, !dbg !36
  br label %vaarg.end32, !dbg !36

vaarg.end32:                                      ; preds = %vaarg.in_mem28, %vaarg.in_reg26
  %vaarg.addr33 = phi i8** [ %24, %vaarg.in_reg26 ], [ %26, %vaarg.in_mem28 ], !dbg !36
  %27 = load i8*, i8** %vaarg.addr33, align 8, !dbg !36
  store i8* %27, i8** %nt2, align 8, !dbg !35
  call void @llvm.dbg.declare(metadata i8** %nt3, metadata !37, metadata !21), !dbg !38
  %28 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !39
  %gp_offset_p34 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %28, i32 0, i32 0, !dbg !39
  %gp_offset35 = load i32, i32* %gp_offset_p34, align 8, !dbg !39
  %fits_in_gp36 = icmp ule i32 %gp_offset35, 40, !dbg !39
  br i1 %fits_in_gp36, label %vaarg.in_reg37, label %vaarg.in_mem39, !dbg !39

vaarg.in_reg37:                                   ; preds = %vaarg.end32
  %29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %28, i32 0, i32 3, !dbg !39
  %reg_save_area38 = load i8*, i8** %29, align 8, !dbg !39
  %30 = getelementptr i8, i8* %reg_save_area38, i32 %gp_offset35, !dbg !39
  %31 = bitcast i8* %30 to i8**, !dbg !39
  %32 = add i32 %gp_offset35, 8, !dbg !39
  store i32 %32, i32* %gp_offset_p34, align 8, !dbg !39
  br label %vaarg.end43, !dbg !39

vaarg.in_mem39:                                   ; preds = %vaarg.end32
  %overflow_arg_area_p40 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %28, i32 0, i32 2, !dbg !39
  %overflow_arg_area41 = load i8*, i8** %overflow_arg_area_p40, align 8, !dbg !39
  %33 = bitcast i8* %overflow_arg_area41 to i8**, !dbg !39
  %overflow_arg_area.next42 = getelementptr i8, i8* %overflow_arg_area41, i32 8, !dbg !39
  store i8* %overflow_arg_area.next42, i8** %overflow_arg_area_p40, align 8, !dbg !39
  br label %vaarg.end43, !dbg !39

vaarg.end43:                                      ; preds = %vaarg.in_mem39, %vaarg.in_reg37
  %vaarg.addr44 = phi i8** [ %31, %vaarg.in_reg37 ], [ %33, %vaarg.in_mem39 ], !dbg !39
  %34 = load i8*, i8** %vaarg.addr44, align 8, !dbg !39
  store i8* %34, i8** %nt3, align 8, !dbg !38
  ret i32 0, !dbg !40
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @forwarder(i32 %n, ...) #0 !dbg !41 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %rc = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !44, metadata !21), !dbg !45
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !46, metadata !21), !dbg !53
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !54
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !54
  call void @llvm.va_start(i8* %arraydecay1), !dbg !54
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !55, metadata !21), !dbg !56
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !57
  %call = call i32 @user(%struct.__va_list_tag* %arraydecay2), !dbg !58
  store i32 %call, i32* %rc, align 4, !dbg !56
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !59
  %arraydecay34 = bitcast %struct.__va_list_tag* %arraydecay3 to i8*, !dbg !59
  call void @llvm.va_end(i8* %arraydecay34), !dbg !59
  %0 = load i32, i32* %rc, align 4, !dbg !60
  ret i32 %0, !dbg !61
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !62 {
entry:
  %retval = alloca i32, align 4
  %not_tainted = alloca i8*, align 8
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !65, metadata !21), !dbg !66
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0), i8** %not_tainted, align 8, !dbg !66
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !67, metadata !21), !dbg !68
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)) #2, !dbg !69
  store i8* %call, i8** %tainted, align 8, !dbg !68
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !70, metadata !21), !dbg !71
  %0 = load i8*, i8** %tainted, align 8, !dbg !72
  %1 = load i8*, i8** %not_tainted, align 8, !dbg !73
  %2 = load i8*, i8** %tainted, align 8, !dbg !74
  %3 = load i8*, i8** %not_tainted, align 8, !dbg !75
  %4 = load i8*, i8** %not_tainted, align 8, !dbg !76
  %call1 = call i32 (i32, ...) @forwarder(i32 6, i8* %0, i8* %1, i8* %2, i8* %3, i8* %4), !dbg !77
  store i32 %call1, i32* %rc, align 4, !dbg !71
  %5 = load i32, i32* %rc, align 4, !dbg !78
  ret i32 %5, !dbg !79
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-17")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "user", scope: !1, file: !1, line: 7, type: !8, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, size: 192, elements: !13)
!13 = !{!14, !16, !17, !19}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !12, file: !1, baseType: !15, size: 32)
!15 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !12, file: !1, baseType: !15, size: 32, offset: 32)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !12, file: !1, baseType: !18, size: 64, offset: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !12, file: !1, baseType: !18, size: 64, offset: 128)
!20 = !DILocalVariable(name: "args", arg: 1, scope: !7, file: !1, line: 7, type: !11)
!21 = !DIExpression()
!22 = !DILocation(line: 7, column: 14, scope: !7)
!23 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 9, type: !24)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!26 = !DILocation(line: 9, column: 11, scope: !7)
!27 = !DILocation(line: 9, column: 16, scope: !7)
!28 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 10, type: !24)
!29 = !DILocation(line: 10, column: 11, scope: !7)
!30 = !DILocation(line: 10, column: 17, scope: !7)
!31 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 11, type: !24)
!32 = !DILocation(line: 11, column: 11, scope: !7)
!33 = !DILocation(line: 11, column: 16, scope: !7)
!34 = !DILocalVariable(name: "nt2", scope: !7, file: !1, line: 12, type: !24)
!35 = !DILocation(line: 12, column: 11, scope: !7)
!36 = !DILocation(line: 12, column: 17, scope: !7)
!37 = !DILocalVariable(name: "nt3", scope: !7, file: !1, line: 13, type: !24)
!38 = !DILocation(line: 13, column: 11, scope: !7)
!39 = !DILocation(line: 13, column: 17, scope: !7)
!40 = !DILocation(line: 15, column: 5, scope: !7)
!41 = distinct !DISubprogram(name: "forwarder", scope: !1, file: !1, line: 19, type: !42, isLocal: false, isDefinition: true, scopeLine: 20, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!42 = !DISubroutineType(types: !43)
!43 = !{!10, !10, null}
!44 = !DILocalVariable(name: "n", arg: 1, scope: !41, file: !1, line: 19, type: !10)
!45 = !DILocation(line: 19, column: 15, scope: !41)
!46 = !DILocalVariable(name: "ap", scope: !41, file: !1, line: 21, type: !47)
!47 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !48, line: 30, baseType: !49)
!48 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-17")
!49 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 21, baseType: !50)
!50 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 192, elements: !51)
!51 = !{!52}
!52 = !DISubrange(count: 1)
!53 = !DILocation(line: 21, column: 13, scope: !41)
!54 = !DILocation(line: 22, column: 5, scope: !41)
!55 = !DILocalVariable(name: "rc", scope: !41, file: !1, line: 24, type: !10)
!56 = !DILocation(line: 24, column: 9, scope: !41)
!57 = !DILocation(line: 24, column: 19, scope: !41)
!58 = !DILocation(line: 24, column: 14, scope: !41)
!59 = !DILocation(line: 26, column: 5, scope: !41)
!60 = !DILocation(line: 28, column: 12, scope: !41)
!61 = !DILocation(line: 28, column: 5, scope: !41)
!62 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 32, type: !63, isLocal: false, isDefinition: true, scopeLine: 33, isOptimized: false, unit: !0, variables: !2)
!63 = !DISubroutineType(types: !64)
!64 = !{!10}
!65 = !DILocalVariable(name: "not_tainted", scope: !62, file: !1, line: 34, type: !24)
!66 = !DILocation(line: 34, column: 11, scope: !62)
!67 = !DILocalVariable(name: "tainted", scope: !62, file: !1, line: 35, type: !24)
!68 = !DILocation(line: 35, column: 11, scope: !62)
!69 = !DILocation(line: 35, column: 21, scope: !62)
!70 = !DILocalVariable(name: "rc", scope: !62, file: !1, line: 37, type: !10)
!71 = !DILocation(line: 37, column: 9, scope: !62)
!72 = !DILocation(line: 37, column: 27, scope: !62)
!73 = !DILocation(line: 37, column: 36, scope: !62)
!74 = !DILocation(line: 37, column: 49, scope: !62)
!75 = !DILocation(line: 37, column: 58, scope: !62)
!76 = !DILocation(line: 37, column: 71, scope: !62)
!77 = !DILocation(line: 37, column: 14, scope: !62)
!78 = !DILocation(line: 39, column: 12, scope: !62)
!79 = !DILocation(line: 39, column: 5, scope: !62)
