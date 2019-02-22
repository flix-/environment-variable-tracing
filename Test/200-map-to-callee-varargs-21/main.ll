; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [12 x i8] c"hello world\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @fake_BIO_vprintf(i32 %n, %struct.__va_list_tag* %args) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %args.addr = alloca %struct.__va_list_tag*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !20, metadata !21), !dbg !22
  store %struct.__va_list_tag* %args, %struct.__va_list_tag** %args.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.__va_list_tag** %args.addr, metadata !23, metadata !21), !dbg !24
  %0 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !25
  %call = call i32 @_dopr(%struct.__va_list_tag* %0), !dbg !26
  ret i32 %call, !dbg !27
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @_dopr(%struct.__va_list_tag* %args) #0 !dbg !28 {
entry:
  %args.addr = alloca %struct.__va_list_tag*, align 8
  %nt1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %nt2 = alloca i8*, align 8
  %nt3 = alloca i8*, align 8
  store %struct.__va_list_tag* %args, %struct.__va_list_tag** %args.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.__va_list_tag** %args.addr, metadata !31, metadata !21), !dbg !32
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !33, metadata !21), !dbg !36
  %0 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !37
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 0, !dbg !37
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !37
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !37
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !37

vaarg.in_reg:                                     ; preds = %entry
  %1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 3, !dbg !37
  %reg_save_area = load i8*, i8** %1, align 8, !dbg !37
  %2 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !37
  %3 = bitcast i8* %2 to i8**, !dbg !37
  %4 = add i32 %gp_offset, 8, !dbg !37
  store i32 %4, i32* %gp_offset_p, align 8, !dbg !37
  br label %vaarg.end, !dbg !37

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 2, !dbg !37
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !37
  %5 = bitcast i8* %overflow_arg_area to i8**, !dbg !37
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !37
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !37
  br label %vaarg.end, !dbg !37

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %3, %vaarg.in_reg ], [ %5, %vaarg.in_mem ], !dbg !37
  %6 = load i8*, i8** %vaarg.addr, align 8, !dbg !37
  store i8* %6, i8** %nt1, align 8, !dbg !36
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !38, metadata !21), !dbg !39
  %7 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !40
  %gp_offset_p1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 0, !dbg !40
  %gp_offset2 = load i32, i32* %gp_offset_p1, align 8, !dbg !40
  %fits_in_gp3 = icmp ule i32 %gp_offset2, 40, !dbg !40
  br i1 %fits_in_gp3, label %vaarg.in_reg4, label %vaarg.in_mem6, !dbg !40

vaarg.in_reg4:                                    ; preds = %vaarg.end
  %8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 3, !dbg !40
  %reg_save_area5 = load i8*, i8** %8, align 8, !dbg !40
  %9 = getelementptr i8, i8* %reg_save_area5, i32 %gp_offset2, !dbg !40
  %10 = bitcast i8* %9 to i8**, !dbg !40
  %11 = add i32 %gp_offset2, 8, !dbg !40
  store i32 %11, i32* %gp_offset_p1, align 8, !dbg !40
  br label %vaarg.end10, !dbg !40

vaarg.in_mem6:                                    ; preds = %vaarg.end
  %overflow_arg_area_p7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 2, !dbg !40
  %overflow_arg_area8 = load i8*, i8** %overflow_arg_area_p7, align 8, !dbg !40
  %12 = bitcast i8* %overflow_arg_area8 to i8**, !dbg !40
  %overflow_arg_area.next9 = getelementptr i8, i8* %overflow_arg_area8, i32 8, !dbg !40
  store i8* %overflow_arg_area.next9, i8** %overflow_arg_area_p7, align 8, !dbg !40
  br label %vaarg.end10, !dbg !40

vaarg.end10:                                      ; preds = %vaarg.in_mem6, %vaarg.in_reg4
  %vaarg.addr11 = phi i8** [ %10, %vaarg.in_reg4 ], [ %12, %vaarg.in_mem6 ], !dbg !40
  %13 = load i8*, i8** %vaarg.addr11, align 8, !dbg !40
  store i8* %13, i8** %t2, align 8, !dbg !39
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !41, metadata !21), !dbg !42
  %14 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !43
  %gp_offset_p12 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 0, !dbg !43
  %gp_offset13 = load i32, i32* %gp_offset_p12, align 8, !dbg !43
  %fits_in_gp14 = icmp ule i32 %gp_offset13, 40, !dbg !43
  br i1 %fits_in_gp14, label %vaarg.in_reg15, label %vaarg.in_mem17, !dbg !43

vaarg.in_reg15:                                   ; preds = %vaarg.end10
  %15 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 3, !dbg !43
  %reg_save_area16 = load i8*, i8** %15, align 8, !dbg !43
  %16 = getelementptr i8, i8* %reg_save_area16, i32 %gp_offset13, !dbg !43
  %17 = bitcast i8* %16 to i8**, !dbg !43
  %18 = add i32 %gp_offset13, 8, !dbg !43
  store i32 %18, i32* %gp_offset_p12, align 8, !dbg !43
  br label %vaarg.end21, !dbg !43

vaarg.in_mem17:                                   ; preds = %vaarg.end10
  %overflow_arg_area_p18 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 2, !dbg !43
  %overflow_arg_area19 = load i8*, i8** %overflow_arg_area_p18, align 8, !dbg !43
  %19 = bitcast i8* %overflow_arg_area19 to i8**, !dbg !43
  %overflow_arg_area.next20 = getelementptr i8, i8* %overflow_arg_area19, i32 8, !dbg !43
  store i8* %overflow_arg_area.next20, i8** %overflow_arg_area_p18, align 8, !dbg !43
  br label %vaarg.end21, !dbg !43

vaarg.end21:                                      ; preds = %vaarg.in_mem17, %vaarg.in_reg15
  %vaarg.addr22 = phi i8** [ %17, %vaarg.in_reg15 ], [ %19, %vaarg.in_mem17 ], !dbg !43
  %20 = load i8*, i8** %vaarg.addr22, align 8, !dbg !43
  store i8* %20, i8** %nt2, align 8, !dbg !42
  call void @llvm.dbg.declare(metadata i8** %nt3, metadata !44, metadata !21), !dbg !45
  %21 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !46
  %gp_offset_p23 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 0, !dbg !46
  %gp_offset24 = load i32, i32* %gp_offset_p23, align 8, !dbg !46
  %fits_in_gp25 = icmp ule i32 %gp_offset24, 40, !dbg !46
  br i1 %fits_in_gp25, label %vaarg.in_reg26, label %vaarg.in_mem28, !dbg !46

vaarg.in_reg26:                                   ; preds = %vaarg.end21
  %22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 3, !dbg !46
  %reg_save_area27 = load i8*, i8** %22, align 8, !dbg !46
  %23 = getelementptr i8, i8* %reg_save_area27, i32 %gp_offset24, !dbg !46
  %24 = bitcast i8* %23 to i8**, !dbg !46
  %25 = add i32 %gp_offset24, 8, !dbg !46
  store i32 %25, i32* %gp_offset_p23, align 8, !dbg !46
  br label %vaarg.end32, !dbg !46

vaarg.in_mem28:                                   ; preds = %vaarg.end21
  %overflow_arg_area_p29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 2, !dbg !46
  %overflow_arg_area30 = load i8*, i8** %overflow_arg_area_p29, align 8, !dbg !46
  %26 = bitcast i8* %overflow_arg_area30 to i8**, !dbg !46
  %overflow_arg_area.next31 = getelementptr i8, i8* %overflow_arg_area30, i32 8, !dbg !46
  store i8* %overflow_arg_area.next31, i8** %overflow_arg_area_p29, align 8, !dbg !46
  br label %vaarg.end32, !dbg !46

vaarg.end32:                                      ; preds = %vaarg.in_mem28, %vaarg.in_reg26
  %vaarg.addr33 = phi i8** [ %24, %vaarg.in_reg26 ], [ %26, %vaarg.in_mem28 ], !dbg !46
  %27 = load i8*, i8** %vaarg.addr33, align 8, !dbg !46
  store i8* %27, i8** %nt3, align 8, !dbg !45
  ret i32 -1, !dbg !47
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @fake_BIO_printf(i32 %n, ...) #0 !dbg !48 {
entry:
  %n.addr = alloca i32, align 4
  %args = alloca [1 x %struct.__va_list_tag], align 16
  %t = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !51, metadata !21), !dbg !52
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %args, metadata !53, metadata !21), !dbg !60
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args, i32 0, i32 0, !dbg !61
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !61
  call void @llvm.va_start(i8* %arraydecay1), !dbg !61
  call void @llvm.dbg.declare(metadata i8** %t, metadata !62, metadata !21), !dbg !63
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args, i32 0, i32 0, !dbg !64
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !64
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !64
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !64
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !64

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !64
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !64
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !64
  %2 = bitcast i8* %1 to i8**, !dbg !64
  %3 = add i32 %gp_offset, 8, !dbg !64
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !64
  br label %vaarg.end, !dbg !64

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !64
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !64
  %4 = bitcast i8* %overflow_arg_area to i8**, !dbg !64
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !64
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !64
  br label %vaarg.end, !dbg !64

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !64
  %5 = load i8*, i8** %vaarg.addr, align 8, !dbg !64
  store i8* %5, i8** %t, align 8, !dbg !63
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !65, metadata !21), !dbg !66
  %6 = load i32, i32* %n.addr, align 4, !dbg !67
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args, i32 0, i32 0, !dbg !68
  %call = call i32 @fake_BIO_vprintf(i32 %6, %struct.__va_list_tag* %arraydecay3), !dbg !69
  store i32 %call, i32* %rc, align 4, !dbg !66
  %arraydecay4 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args, i32 0, i32 0, !dbg !70
  %arraydecay45 = bitcast %struct.__va_list_tag* %arraydecay4 to i8*, !dbg !70
  call void @llvm.va_end(i8* %arraydecay45), !dbg !70
  %7 = load i32, i32* %rc, align 4, !dbg !71
  ret i32 %7, !dbg !72
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !73 {
entry:
  %retval = alloca i32, align 4
  %not_tainted = alloca i8*, align 8
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !76, metadata !21), !dbg !77
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0), i8** %not_tainted, align 8, !dbg !77
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !78, metadata !21), !dbg !79
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)) #2, !dbg !80
  store i8* %call, i8** %tainted, align 8, !dbg !79
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !81, metadata !21), !dbg !82
  %0 = load i8*, i8** %tainted, align 8, !dbg !83
  %1 = load i8*, i8** %not_tainted, align 8, !dbg !84
  %2 = load i8*, i8** %tainted, align 8, !dbg !85
  %3 = load i8*, i8** %not_tainted, align 8, !dbg !86
  %4 = load i8*, i8** %not_tainted, align 8, !dbg !87
  %call1 = call i32 (i32, ...) @fake_BIO_printf(i32 6, i8* %0, i8* %1, i8* %2, i8* %3, i8* %4), !dbg !88
  store i32 %call1, i32* %rc, align 4, !dbg !82
  %5 = load i32, i32* %rc, align 4, !dbg !89
  ret i32 %5, !dbg !90
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-21")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "fake_BIO_vprintf", scope: !1, file: !1, line: 18, type: !8, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !11}
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
!20 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 18, type: !10)
!21 = !DIExpression()
!22 = !DILocation(line: 18, column: 22, scope: !7)
!23 = !DILocalVariable(name: "args", arg: 2, scope: !7, file: !1, line: 18, type: !11)
!24 = !DILocation(line: 18, column: 33, scope: !7)
!25 = !DILocation(line: 20, column: 18, scope: !7)
!26 = !DILocation(line: 20, column: 12, scope: !7)
!27 = !DILocation(line: 20, column: 5, scope: !7)
!28 = distinct !DISubprogram(name: "_dopr", scope: !1, file: !1, line: 7, type: !29, isLocal: true, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!10, !11}
!31 = !DILocalVariable(name: "args", arg: 1, scope: !28, file: !1, line: 7, type: !11)
!32 = !DILocation(line: 7, column: 15, scope: !28)
!33 = !DILocalVariable(name: "nt1", scope: !28, file: !1, line: 9, type: !34)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!35 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!36 = !DILocation(line: 9, column: 11, scope: !28)
!37 = !DILocation(line: 9, column: 17, scope: !28)
!38 = !DILocalVariable(name: "t2", scope: !28, file: !1, line: 10, type: !34)
!39 = !DILocation(line: 10, column: 11, scope: !28)
!40 = !DILocation(line: 10, column: 16, scope: !28)
!41 = !DILocalVariable(name: "nt2", scope: !28, file: !1, line: 11, type: !34)
!42 = !DILocation(line: 11, column: 11, scope: !28)
!43 = !DILocation(line: 11, column: 17, scope: !28)
!44 = !DILocalVariable(name: "nt3", scope: !28, file: !1, line: 12, type: !34)
!45 = !DILocation(line: 12, column: 11, scope: !28)
!46 = !DILocation(line: 12, column: 17, scope: !28)
!47 = !DILocation(line: 14, column: 5, scope: !28)
!48 = distinct !DISubprogram(name: "fake_BIO_printf", scope: !1, file: !1, line: 24, type: !49, isLocal: false, isDefinition: true, scopeLine: 25, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!49 = !DISubroutineType(types: !50)
!50 = !{!10, !10, null}
!51 = !DILocalVariable(name: "n", arg: 1, scope: !48, file: !1, line: 24, type: !10)
!52 = !DILocation(line: 24, column: 21, scope: !48)
!53 = !DILocalVariable(name: "args", scope: !48, file: !1, line: 26, type: !54)
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !55, line: 30, baseType: !56)
!55 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-21")
!56 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 26, baseType: !57)
!57 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 192, elements: !58)
!58 = !{!59}
!59 = !DISubrange(count: 1)
!60 = !DILocation(line: 26, column: 13, scope: !48)
!61 = !DILocation(line: 27, column: 5, scope: !48)
!62 = !DILocalVariable(name: "t", scope: !48, file: !1, line: 29, type: !34)
!63 = !DILocation(line: 29, column: 11, scope: !48)
!64 = !DILocation(line: 29, column: 15, scope: !48)
!65 = !DILocalVariable(name: "rc", scope: !48, file: !1, line: 31, type: !10)
!66 = !DILocation(line: 31, column: 9, scope: !48)
!67 = !DILocation(line: 31, column: 31, scope: !48)
!68 = !DILocation(line: 31, column: 34, scope: !48)
!69 = !DILocation(line: 31, column: 14, scope: !48)
!70 = !DILocation(line: 33, column: 5, scope: !48)
!71 = !DILocation(line: 35, column: 12, scope: !48)
!72 = !DILocation(line: 35, column: 5, scope: !48)
!73 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 39, type: !74, isLocal: false, isDefinition: true, scopeLine: 40, isOptimized: false, unit: !0, variables: !2)
!74 = !DISubroutineType(types: !75)
!75 = !{!10}
!76 = !DILocalVariable(name: "not_tainted", scope: !73, file: !1, line: 41, type: !34)
!77 = !DILocation(line: 41, column: 11, scope: !73)
!78 = !DILocalVariable(name: "tainted", scope: !73, file: !1, line: 42, type: !34)
!79 = !DILocation(line: 42, column: 11, scope: !73)
!80 = !DILocation(line: 42, column: 21, scope: !73)
!81 = !DILocalVariable(name: "rc", scope: !73, file: !1, line: 44, type: !10)
!82 = !DILocation(line: 44, column: 9, scope: !73)
!83 = !DILocation(line: 44, column: 33, scope: !73)
!84 = !DILocation(line: 44, column: 42, scope: !73)
!85 = !DILocation(line: 44, column: 55, scope: !73)
!86 = !DILocation(line: 44, column: 64, scope: !73)
!87 = !DILocation(line: 44, column: 77, scope: !73)
!88 = !DILocation(line: 44, column: 14, scope: !73)
!89 = !DILocation(line: 46, column: 12, scope: !73)
!90 = !DILocation(line: 46, column: 5, scope: !73)
