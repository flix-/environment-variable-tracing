; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@gt = common global i8* null, align 8, !dbg !0
@str = common global [1024 x i8*] zeroinitializer, align 16, !dbg !6

; Function Attrs: noinline nounwind optnone uwtable
define i8* @foo(i32 %n, ...) #0 !dbg !17 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %t1 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !21, metadata !22), !dbg !23
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !24, metadata !22), !dbg !39
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !40
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !40
  call void @llvm.va_start(i8* %arraydecay1), !dbg !40
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !41, metadata !22), !dbg !42
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !43
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !43
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !43
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !43
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !43

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !43
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !43
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !43
  %2 = bitcast i8* %1 to i8**, !dbg !43
  %3 = add i32 %gp_offset, 8, !dbg !43
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !43
  br label %vaarg.end, !dbg !43

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !43
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !43
  %4 = bitcast i8* %overflow_arg_area to i8**, !dbg !43
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !43
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !43
  br label %vaarg.end, !dbg !43

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !43
  %5 = load i8*, i8** %vaarg.addr, align 8, !dbg !43
  store i8* %5, i8** %t1, align 8, !dbg !42
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !44, metadata !22), !dbg !45
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !46
  %gp_offset_p4 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 0, !dbg !46
  %gp_offset5 = load i32, i32* %gp_offset_p4, align 16, !dbg !46
  %fits_in_gp6 = icmp ule i32 %gp_offset5, 40, !dbg !46
  br i1 %fits_in_gp6, label %vaarg.in_reg7, label %vaarg.in_mem9, !dbg !46

vaarg.in_reg7:                                    ; preds = %vaarg.end
  %6 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 3, !dbg !46
  %reg_save_area8 = load i8*, i8** %6, align 16, !dbg !46
  %7 = getelementptr i8, i8* %reg_save_area8, i32 %gp_offset5, !dbg !46
  %8 = bitcast i8* %7 to i8**, !dbg !46
  %9 = add i32 %gp_offset5, 8, !dbg !46
  store i32 %9, i32* %gp_offset_p4, align 16, !dbg !46
  br label %vaarg.end13, !dbg !46

vaarg.in_mem9:                                    ; preds = %vaarg.end
  %overflow_arg_area_p10 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !46
  %overflow_arg_area11 = load i8*, i8** %overflow_arg_area_p10, align 8, !dbg !46
  %10 = bitcast i8* %overflow_arg_area11 to i8**, !dbg !46
  %overflow_arg_area.next12 = getelementptr i8, i8* %overflow_arg_area11, i32 8, !dbg !46
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10, align 8, !dbg !46
  br label %vaarg.end13, !dbg !46

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %vaarg.addr14 = phi i8** [ %8, %vaarg.in_reg7 ], [ %10, %vaarg.in_mem9 ], !dbg !46
  %11 = load i8*, i8** %vaarg.addr14, align 8, !dbg !46
  store i8* %11, i8** %ut1, align 8, !dbg !45
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !47, metadata !22), !dbg !48
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !49
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !49
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 16, !dbg !49
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !49
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !49

vaarg.in_reg19:                                   ; preds = %vaarg.end13
  %12 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !49
  %reg_save_area20 = load i8*, i8** %12, align 16, !dbg !49
  %13 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !49
  %14 = bitcast i8* %13 to i8**, !dbg !49
  %15 = add i32 %gp_offset17, 8, !dbg !49
  store i32 %15, i32* %gp_offset_p16, align 16, !dbg !49
  br label %vaarg.end25, !dbg !49

vaarg.in_mem21:                                   ; preds = %vaarg.end13
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !49
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !49
  %16 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !49
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !49
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !49
  br label %vaarg.end25, !dbg !49

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %14, %vaarg.in_reg19 ], [ %16, %vaarg.in_mem21 ], !dbg !49
  %17 = load i8*, i8** %vaarg.addr26, align 8, !dbg !49
  store i8* %17, i8** %t2, align 8, !dbg !48
  %arraydecay27 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !50
  %arraydecay2728 = bitcast %struct.__va_list_tag* %arraydecay27 to i8*, !dbg !50
  call void @llvm.va_end(i8* %arraydecay2728), !dbg !50
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !51
  store i8* %call, i8** @gt, align 8, !dbg !52
  %18 = load i8*, i8** @gt, align 8, !dbg !53
  ret i8* %18, !dbg !54
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

declare i8* @getenv(i8*) #3

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !55 {
entry:
  %retval = alloca i32, align 4
  %ret = alloca i8*, align 8
  %t1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !58
  store i8* %call, i8** getelementptr inbounds ([1024 x i8*], [1024 x i8*]* @str, i64 0, i64 10), align 16, !dbg !59
  call void @llvm.dbg.declare(metadata i8** %ret, metadata !60, metadata !22), !dbg !61
  %0 = load i8*, i8** getelementptr inbounds ([1024 x i8*], [1024 x i8*]* @str, i64 0, i64 10), align 16, !dbg !62
  %1 = load i8*, i8** getelementptr inbounds ([1024 x i8*], [1024 x i8*]* @str, i64 0, i64 9), align 8, !dbg !63
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !64
  %call2 = call i8* (i32, ...) @foo(i32 2, i8* %0, i8* %1, i8* %call1), !dbg !65
  store i8* %call2, i8** %ret, align 8, !dbg !61
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !66, metadata !22), !dbg !67
  %2 = load i8*, i8** %ret, align 8, !dbg !68
  store i8* %2, i8** %t1, align 8, !dbg !67
  ret i32 0, !dbg !69
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!13, !14, !15}
!llvm.ident = !{!16}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "gt", scope: !2, file: !3, line: 6, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-15")
!4 = !{}
!5 = !{!6, !0}
!6 = !DIGlobalVariableExpression(var: !7)
!7 = distinct !DIGlobalVariable(name: "str", scope: !2, file: !3, line: 5, type: !8, isLocal: false, isDefinition: true)
!8 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 65536, elements: !11)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!11 = !{!12}
!12 = !DISubrange(count: 1024)
!13 = !{i32 2, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!17 = distinct !DISubprogram(name: "foo", scope: !3, file: !3, line: 9, type: !18, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!18 = !DISubroutineType(types: !19)
!19 = !{!9, !20, null}
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DILocalVariable(name: "n", arg: 1, scope: !17, file: !3, line: 9, type: !20)
!22 = !DIExpression()
!23 = !DILocation(line: 9, column: 9, scope: !17)
!24 = !DILocalVariable(name: "ap", scope: !17, file: !3, line: 10, type: !25)
!25 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !26, line: 30, baseType: !27)
!26 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-15")
!27 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !3, line: 10, baseType: !28)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 192, elements: !37)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !3, line: 10, size: 192, elements: !30)
!30 = !{!31, !33, !34, !36}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !29, file: !3, line: 10, baseType: !32, size: 32)
!32 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !29, file: !3, line: 10, baseType: !32, size: 32, offset: 32)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !29, file: !3, line: 10, baseType: !35, size: 64, offset: 64)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !29, file: !3, line: 10, baseType: !35, size: 64, offset: 128)
!37 = !{!38}
!38 = !DISubrange(count: 1)
!39 = !DILocation(line: 10, column: 13, scope: !17)
!40 = !DILocation(line: 11, column: 5, scope: !17)
!41 = !DILocalVariable(name: "t1", scope: !17, file: !3, line: 13, type: !9)
!42 = !DILocation(line: 13, column: 11, scope: !17)
!43 = !DILocation(line: 13, column: 16, scope: !17)
!44 = !DILocalVariable(name: "ut1", scope: !17, file: !3, line: 14, type: !9)
!45 = !DILocation(line: 14, column: 11, scope: !17)
!46 = !DILocation(line: 14, column: 17, scope: !17)
!47 = !DILocalVariable(name: "t2", scope: !17, file: !3, line: 15, type: !9)
!48 = !DILocation(line: 15, column: 11, scope: !17)
!49 = !DILocation(line: 15, column: 16, scope: !17)
!50 = !DILocation(line: 17, column: 5, scope: !17)
!51 = !DILocation(line: 19, column: 10, scope: !17)
!52 = !DILocation(line: 19, column: 8, scope: !17)
!53 = !DILocation(line: 21, column: 12, scope: !17)
!54 = !DILocation(line: 21, column: 5, scope: !17)
!55 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 25, type: !56, isLocal: false, isDefinition: true, scopeLine: 26, isOptimized: false, unit: !2, variables: !4)
!56 = !DISubroutineType(types: !57)
!57 = !{!20}
!58 = !DILocation(line: 27, column: 15, scope: !55)
!59 = !DILocation(line: 27, column: 13, scope: !55)
!60 = !DILocalVariable(name: "ret", scope: !55, file: !3, line: 29, type: !9)
!61 = !DILocation(line: 29, column: 11, scope: !55)
!62 = !DILocation(line: 29, column: 24, scope: !55)
!63 = !DILocation(line: 29, column: 33, scope: !55)
!64 = !DILocation(line: 29, column: 41, scope: !55)
!65 = !DILocation(line: 29, column: 17, scope: !55)
!66 = !DILocalVariable(name: "t1", scope: !55, file: !3, line: 31, type: !9)
!67 = !DILocation(line: 31, column: 11, scope: !55)
!68 = !DILocation(line: 31, column: 16, scope: !55)
!69 = !DILocation(line: 33, column: 5, scope: !55)
