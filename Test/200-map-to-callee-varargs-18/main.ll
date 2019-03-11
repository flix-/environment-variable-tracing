; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"hello world\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @user(%struct.__va_list_tag* %args) #0 !dbg !9 {
entry:
  %args.addr = alloca %struct.__va_list_tag*, align 8
  %t1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %t3 = alloca i8*, align 8
  %t4 = alloca i8*, align 8
  %nt = alloca i8*, align 8
  store %struct.__va_list_tag* %args, %struct.__va_list_tag** %args.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.__va_list_tag** %args.addr, metadata !21, metadata !22), !dbg !23
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !24, metadata !22), !dbg !27
  %0 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !28
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 0, !dbg !28
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !28
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !28
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !28

vaarg.in_reg:                                     ; preds = %entry
  %1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 3, !dbg !28
  %reg_save_area = load i8*, i8** %1, align 8, !dbg !28
  %2 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !28
  %3 = bitcast i8* %2 to i8**, !dbg !28
  %4 = add i32 %gp_offset, 8, !dbg !28
  store i32 %4, i32* %gp_offset_p, align 8, !dbg !28
  br label %vaarg.end, !dbg !28

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %0, i32 0, i32 2, !dbg !28
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !28
  %5 = bitcast i8* %overflow_arg_area to i8**, !dbg !28
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !28
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !28
  br label %vaarg.end, !dbg !28

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %3, %vaarg.in_reg ], [ %5, %vaarg.in_mem ], !dbg !28
  %6 = load i8*, i8** %vaarg.addr, align 8, !dbg !28
  store i8* %6, i8** %t1, align 8, !dbg !27
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !29
  %cmp = icmp ne i8* %call, null, !dbg !31
  br i1 %cmp, label %if.then, label %if.end, !dbg !32

if.then:                                          ; preds = %vaarg.end
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !33, metadata !22), !dbg !35
  %7 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !36
  %gp_offset_p1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 0, !dbg !36
  %gp_offset2 = load i32, i32* %gp_offset_p1, align 8, !dbg !36
  %fits_in_gp3 = icmp ule i32 %gp_offset2, 40, !dbg !36
  br i1 %fits_in_gp3, label %vaarg.in_reg4, label %vaarg.in_mem6, !dbg !36

vaarg.in_reg4:                                    ; preds = %if.then
  %8 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 3, !dbg !36
  %reg_save_area5 = load i8*, i8** %8, align 8, !dbg !36
  %9 = getelementptr i8, i8* %reg_save_area5, i32 %gp_offset2, !dbg !36
  %10 = bitcast i8* %9 to i8**, !dbg !36
  %11 = add i32 %gp_offset2, 8, !dbg !36
  store i32 %11, i32* %gp_offset_p1, align 8, !dbg !36
  br label %vaarg.end10, !dbg !36

vaarg.in_mem6:                                    ; preds = %if.then
  %overflow_arg_area_p7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %7, i32 0, i32 2, !dbg !36
  %overflow_arg_area8 = load i8*, i8** %overflow_arg_area_p7, align 8, !dbg !36
  %12 = bitcast i8* %overflow_arg_area8 to i8**, !dbg !36
  %overflow_arg_area.next9 = getelementptr i8, i8* %overflow_arg_area8, i32 8, !dbg !36
  store i8* %overflow_arg_area.next9, i8** %overflow_arg_area_p7, align 8, !dbg !36
  br label %vaarg.end10, !dbg !36

vaarg.end10:                                      ; preds = %vaarg.in_mem6, %vaarg.in_reg4
  %vaarg.addr11 = phi i8** [ %10, %vaarg.in_reg4 ], [ %12, %vaarg.in_mem6 ], !dbg !36
  %13 = load i8*, i8** %vaarg.addr11, align 8, !dbg !36
  store i8* %13, i8** %t2, align 8, !dbg !35
  br label %if.end, !dbg !37

if.end:                                           ; preds = %vaarg.end10, %vaarg.end
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !38, metadata !22), !dbg !39
  %14 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !40
  %gp_offset_p12 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 0, !dbg !40
  %gp_offset13 = load i32, i32* %gp_offset_p12, align 8, !dbg !40
  %fits_in_gp14 = icmp ule i32 %gp_offset13, 40, !dbg !40
  br i1 %fits_in_gp14, label %vaarg.in_reg15, label %vaarg.in_mem17, !dbg !40

vaarg.in_reg15:                                   ; preds = %if.end
  %15 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 3, !dbg !40
  %reg_save_area16 = load i8*, i8** %15, align 8, !dbg !40
  %16 = getelementptr i8, i8* %reg_save_area16, i32 %gp_offset13, !dbg !40
  %17 = bitcast i8* %16 to i8**, !dbg !40
  %18 = add i32 %gp_offset13, 8, !dbg !40
  store i32 %18, i32* %gp_offset_p12, align 8, !dbg !40
  br label %vaarg.end21, !dbg !40

vaarg.in_mem17:                                   ; preds = %if.end
  %overflow_arg_area_p18 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %14, i32 0, i32 2, !dbg !40
  %overflow_arg_area19 = load i8*, i8** %overflow_arg_area_p18, align 8, !dbg !40
  %19 = bitcast i8* %overflow_arg_area19 to i8**, !dbg !40
  %overflow_arg_area.next20 = getelementptr i8, i8* %overflow_arg_area19, i32 8, !dbg !40
  store i8* %overflow_arg_area.next20, i8** %overflow_arg_area_p18, align 8, !dbg !40
  br label %vaarg.end21, !dbg !40

vaarg.end21:                                      ; preds = %vaarg.in_mem17, %vaarg.in_reg15
  %vaarg.addr22 = phi i8** [ %17, %vaarg.in_reg15 ], [ %19, %vaarg.in_mem17 ], !dbg !40
  %20 = load i8*, i8** %vaarg.addr22, align 8, !dbg !40
  store i8* %20, i8** %t3, align 8, !dbg !39
  call void @llvm.dbg.declare(metadata i8** %t4, metadata !41, metadata !22), !dbg !42
  %21 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !43
  %gp_offset_p23 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 0, !dbg !43
  %gp_offset24 = load i32, i32* %gp_offset_p23, align 8, !dbg !43
  %fits_in_gp25 = icmp ule i32 %gp_offset24, 40, !dbg !43
  br i1 %fits_in_gp25, label %vaarg.in_reg26, label %vaarg.in_mem28, !dbg !43

vaarg.in_reg26:                                   ; preds = %vaarg.end21
  %22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 3, !dbg !43
  %reg_save_area27 = load i8*, i8** %22, align 8, !dbg !43
  %23 = getelementptr i8, i8* %reg_save_area27, i32 %gp_offset24, !dbg !43
  %24 = bitcast i8* %23 to i8**, !dbg !43
  %25 = add i32 %gp_offset24, 8, !dbg !43
  store i32 %25, i32* %gp_offset_p23, align 8, !dbg !43
  br label %vaarg.end32, !dbg !43

vaarg.in_mem28:                                   ; preds = %vaarg.end21
  %overflow_arg_area_p29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 2, !dbg !43
  %overflow_arg_area30 = load i8*, i8** %overflow_arg_area_p29, align 8, !dbg !43
  %26 = bitcast i8* %overflow_arg_area30 to i8**, !dbg !43
  %overflow_arg_area.next31 = getelementptr i8, i8* %overflow_arg_area30, i32 8, !dbg !43
  store i8* %overflow_arg_area.next31, i8** %overflow_arg_area_p29, align 8, !dbg !43
  br label %vaarg.end32, !dbg !43

vaarg.end32:                                      ; preds = %vaarg.in_mem28, %vaarg.in_reg26
  %vaarg.addr33 = phi i8** [ %24, %vaarg.in_reg26 ], [ %26, %vaarg.in_mem28 ], !dbg !43
  %27 = load i8*, i8** %vaarg.addr33, align 8, !dbg !43
  store i8* %27, i8** %t4, align 8, !dbg !42
  call void @llvm.dbg.declare(metadata i8** %nt, metadata !44, metadata !22), !dbg !45
  %28 = load %struct.__va_list_tag*, %struct.__va_list_tag** %args.addr, align 8, !dbg !46
  %gp_offset_p34 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %28, i32 0, i32 0, !dbg !46
  %gp_offset35 = load i32, i32* %gp_offset_p34, align 8, !dbg !46
  %fits_in_gp36 = icmp ule i32 %gp_offset35, 40, !dbg !46
  br i1 %fits_in_gp36, label %vaarg.in_reg37, label %vaarg.in_mem39, !dbg !46

vaarg.in_reg37:                                   ; preds = %vaarg.end32
  %29 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %28, i32 0, i32 3, !dbg !46
  %reg_save_area38 = load i8*, i8** %29, align 8, !dbg !46
  %30 = getelementptr i8, i8* %reg_save_area38, i32 %gp_offset35, !dbg !46
  %31 = bitcast i8* %30 to i8**, !dbg !46
  %32 = add i32 %gp_offset35, 8, !dbg !46
  store i32 %32, i32* %gp_offset_p34, align 8, !dbg !46
  br label %vaarg.end43, !dbg !46

vaarg.in_mem39:                                   ; preds = %vaarg.end32
  %overflow_arg_area_p40 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %28, i32 0, i32 2, !dbg !46
  %overflow_arg_area41 = load i8*, i8** %overflow_arg_area_p40, align 8, !dbg !46
  %33 = bitcast i8* %overflow_arg_area41 to i8**, !dbg !46
  %overflow_arg_area.next42 = getelementptr i8, i8* %overflow_arg_area41, i32 8, !dbg !46
  store i8* %overflow_arg_area.next42, i8** %overflow_arg_area_p40, align 8, !dbg !46
  br label %vaarg.end43, !dbg !46

vaarg.end43:                                      ; preds = %vaarg.in_mem39, %vaarg.in_reg37
  %vaarg.addr44 = phi i8** [ %31, %vaarg.in_reg37 ], [ %33, %vaarg.in_mem39 ], !dbg !46
  %34 = load i8*, i8** %vaarg.addr44, align 8, !dbg !46
  store i8* %34, i8** %nt, align 8, !dbg !45
  ret i32 0, !dbg !47
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @forwarder(i32 %n, ...) #0 !dbg !48 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %rc = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !51, metadata !22), !dbg !52
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !53, metadata !22), !dbg !60
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !61
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !61
  call void @llvm.va_start(i8* %arraydecay1), !dbg !61
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !62, metadata !22), !dbg !63
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !64
  %call = call i32 @user(%struct.__va_list_tag* %arraydecay2), !dbg !65
  store i32 %call, i32* %rc, align 4, !dbg !63
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !66
  %arraydecay34 = bitcast %struct.__va_list_tag* %arraydecay3 to i8*, !dbg !66
  call void @llvm.va_end(i8* %arraydecay34), !dbg !66
  %0 = load i32, i32* %rc, align 4, !dbg !67
  ret i32 %0, !dbg !68
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #3

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #3

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !69 {
entry:
  %retval = alloca i32, align 4
  %not_tainted = alloca i8*, align 8
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %not_tainted, metadata !72, metadata !22), !dbg !73
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0), i8** %not_tainted, align 8, !dbg !73
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !74, metadata !22), !dbg !75
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !76
  store i8* %call, i8** %tainted, align 8, !dbg !75
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !77, metadata !22), !dbg !78
  %0 = load i8*, i8** %tainted, align 8, !dbg !79
  %1 = load i8*, i8** %not_tainted, align 8, !dbg !80
  %2 = load i8*, i8** %tainted, align 8, !dbg !81
  %3 = load i8*, i8** %not_tainted, align 8, !dbg !82
  %4 = load i8*, i8** %not_tainted, align 8, !dbg !83
  %call1 = call i32 (i32, ...) @forwarder(i32 6, i8* %0, i8* %1, i8* %2, i8* %3, i8* %4), !dbg !84
  store i32 %call1, i32* %rc, align 4, !dbg !78
  %5 = load i32, i32* %rc, align 4, !dbg !85
  ret i32 %5, !dbg !86
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-18")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "user", scope: !1, file: !1, line: 7, type: !10, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
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
!21 = !DILocalVariable(name: "args", arg: 1, scope: !9, file: !1, line: 7, type: !13)
!22 = !DIExpression()
!23 = !DILocation(line: 7, column: 14, scope: !9)
!24 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 9, type: !25)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64)
!26 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!27 = !DILocation(line: 9, column: 11, scope: !9)
!28 = !DILocation(line: 9, column: 16, scope: !9)
!29 = !DILocation(line: 11, column: 9, scope: !30)
!30 = distinct !DILexicalBlock(scope: !9, file: !1, line: 11, column: 9)
!31 = !DILocation(line: 11, column: 24, scope: !30)
!32 = !DILocation(line: 11, column: 9, scope: !9)
!33 = !DILocalVariable(name: "t2", scope: !34, file: !1, line: 12, type: !25)
!34 = distinct !DILexicalBlock(scope: !30, file: !1, line: 11, column: 33)
!35 = !DILocation(line: 12, column: 15, scope: !34)
!36 = !DILocation(line: 12, column: 20, scope: !34)
!37 = !DILocation(line: 13, column: 5, scope: !34)
!38 = !DILocalVariable(name: "t3", scope: !9, file: !1, line: 15, type: !25)
!39 = !DILocation(line: 15, column: 11, scope: !9)
!40 = !DILocation(line: 15, column: 16, scope: !9)
!41 = !DILocalVariable(name: "t4", scope: !9, file: !1, line: 16, type: !25)
!42 = !DILocation(line: 16, column: 11, scope: !9)
!43 = !DILocation(line: 16, column: 16, scope: !9)
!44 = !DILocalVariable(name: "nt", scope: !9, file: !1, line: 18, type: !25)
!45 = !DILocation(line: 18, column: 11, scope: !9)
!46 = !DILocation(line: 18, column: 16, scope: !9)
!47 = !DILocation(line: 20, column: 5, scope: !9)
!48 = distinct !DISubprogram(name: "forwarder", scope: !1, file: !1, line: 24, type: !49, isLocal: false, isDefinition: true, scopeLine: 25, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!49 = !DISubroutineType(types: !50)
!50 = !{!12, !12, null}
!51 = !DILocalVariable(name: "n", arg: 1, scope: !48, file: !1, line: 24, type: !12)
!52 = !DILocation(line: 24, column: 15, scope: !48)
!53 = !DILocalVariable(name: "ap", scope: !48, file: !1, line: 26, type: !54)
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !55, line: 30, baseType: !56)
!55 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-18")
!56 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 26, baseType: !57)
!57 = !DICompositeType(tag: DW_TAG_array_type, baseType: !14, size: 192, elements: !58)
!58 = !{!59}
!59 = !DISubrange(count: 1)
!60 = !DILocation(line: 26, column: 13, scope: !48)
!61 = !DILocation(line: 27, column: 5, scope: !48)
!62 = !DILocalVariable(name: "rc", scope: !48, file: !1, line: 29, type: !12)
!63 = !DILocation(line: 29, column: 9, scope: !48)
!64 = !DILocation(line: 29, column: 19, scope: !48)
!65 = !DILocation(line: 29, column: 14, scope: !48)
!66 = !DILocation(line: 31, column: 5, scope: !48)
!67 = !DILocation(line: 33, column: 12, scope: !48)
!68 = !DILocation(line: 33, column: 5, scope: !48)
!69 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 37, type: !70, isLocal: false, isDefinition: true, scopeLine: 38, isOptimized: false, unit: !0, variables: !2)
!70 = !DISubroutineType(types: !71)
!71 = !{!12}
!72 = !DILocalVariable(name: "not_tainted", scope: !69, file: !1, line: 39, type: !25)
!73 = !DILocation(line: 39, column: 11, scope: !69)
!74 = !DILocalVariable(name: "tainted", scope: !69, file: !1, line: 40, type: !25)
!75 = !DILocation(line: 40, column: 11, scope: !69)
!76 = !DILocation(line: 40, column: 21, scope: !69)
!77 = !DILocalVariable(name: "rc", scope: !69, file: !1, line: 42, type: !12)
!78 = !DILocation(line: 42, column: 9, scope: !69)
!79 = !DILocation(line: 42, column: 27, scope: !69)
!80 = !DILocation(line: 42, column: 36, scope: !69)
!81 = !DILocation(line: 42, column: 49, scope: !69)
!82 = !DILocation(line: 42, column: 58, scope: !69)
!83 = !DILocation(line: 42, column: 71, scope: !69)
!84 = !DILocation(line: 42, column: 14, scope: !69)
!85 = !DILocation(line: 44, column: 12, scope: !69)
!86 = !DILocation(line: 44, column: 5, scope: !69)
