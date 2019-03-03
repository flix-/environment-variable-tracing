; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@str = common global [1024 x i8*] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %n, ...) #0 !dbg !15 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %t1 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !19, metadata !20), !dbg !21
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !22, metadata !20), !dbg !37
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !38
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !38
  call void @llvm.va_start(i8* %arraydecay1), !dbg !38
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !39, metadata !20), !dbg !40
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !41
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !41
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !41
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !41
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !41

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !41
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !41
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !41
  %2 = bitcast i8* %1 to i8**, !dbg !41
  %3 = add i32 %gp_offset, 8, !dbg !41
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !41
  br label %vaarg.end, !dbg !41

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !41
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !41
  %4 = bitcast i8* %overflow_arg_area to i8**, !dbg !41
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !41
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !41
  br label %vaarg.end, !dbg !41

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !41
  %5 = load i8*, i8** %vaarg.addr, align 8, !dbg !41
  store i8* %5, i8** %t1, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !42, metadata !20), !dbg !43
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !44
  %gp_offset_p4 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 0, !dbg !44
  %gp_offset5 = load i32, i32* %gp_offset_p4, align 16, !dbg !44
  %fits_in_gp6 = icmp ule i32 %gp_offset5, 40, !dbg !44
  br i1 %fits_in_gp6, label %vaarg.in_reg7, label %vaarg.in_mem9, !dbg !44

vaarg.in_reg7:                                    ; preds = %vaarg.end
  %6 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 3, !dbg !44
  %reg_save_area8 = load i8*, i8** %6, align 16, !dbg !44
  %7 = getelementptr i8, i8* %reg_save_area8, i32 %gp_offset5, !dbg !44
  %8 = bitcast i8* %7 to i8**, !dbg !44
  %9 = add i32 %gp_offset5, 8, !dbg !44
  store i32 %9, i32* %gp_offset_p4, align 16, !dbg !44
  br label %vaarg.end13, !dbg !44

vaarg.in_mem9:                                    ; preds = %vaarg.end
  %overflow_arg_area_p10 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !44
  %overflow_arg_area11 = load i8*, i8** %overflow_arg_area_p10, align 8, !dbg !44
  %10 = bitcast i8* %overflow_arg_area11 to i8**, !dbg !44
  %overflow_arg_area.next12 = getelementptr i8, i8* %overflow_arg_area11, i32 8, !dbg !44
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10, align 8, !dbg !44
  br label %vaarg.end13, !dbg !44

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %vaarg.addr14 = phi i8** [ %8, %vaarg.in_reg7 ], [ %10, %vaarg.in_mem9 ], !dbg !44
  %11 = load i8*, i8** %vaarg.addr14, align 8, !dbg !44
  store i8* %11, i8** %ut1, align 8, !dbg !43
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !45, metadata !20), !dbg !46
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !47
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !47
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 16, !dbg !47
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !47
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !47

vaarg.in_reg19:                                   ; preds = %vaarg.end13
  %12 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !47
  %reg_save_area20 = load i8*, i8** %12, align 16, !dbg !47
  %13 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !47
  %14 = bitcast i8* %13 to i8**, !dbg !47
  %15 = add i32 %gp_offset17, 8, !dbg !47
  store i32 %15, i32* %gp_offset_p16, align 16, !dbg !47
  br label %vaarg.end25, !dbg !47

vaarg.in_mem21:                                   ; preds = %vaarg.end13
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !47
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !47
  %16 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !47
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !47
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !47
  br label %vaarg.end25, !dbg !47

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %14, %vaarg.in_reg19 ], [ %16, %vaarg.in_mem21 ], !dbg !47
  %17 = load i8*, i8** %vaarg.addr26, align 8, !dbg !47
  store i8* %17, i8** %t2, align 8, !dbg !46
  %arraydecay27 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !48
  %arraydecay2728 = bitcast %struct.__va_list_tag* %arraydecay27 to i8*, !dbg !48
  call void @llvm.va_end(i8* %arraydecay2728), !dbg !48
  ret i32 0, !dbg !49
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !50 {
entry:
  %retval = alloca i32, align 4
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !53
  store i8* %call, i8** getelementptr inbounds ([1024 x i8*], [1024 x i8*]* @str, i64 0, i64 10), align 16, !dbg !54
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !55, metadata !20), !dbg !56
  %0 = load i8*, i8** getelementptr inbounds ([1024 x i8*], [1024 x i8*]* @str, i64 0, i64 10), align 16, !dbg !57
  %1 = load i8*, i8** getelementptr inbounds ([1024 x i8*], [1024 x i8*]* @str, i64 0, i64 9), align 8, !dbg !58
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !59
  %call2 = call i32 (i32, ...) @foo(i32 2, i8* %0, i8* %1, i8* %call1), !dbg !60
  store i32 %call2, i32* %rc, align 4, !dbg !56
  %2 = load i32, i32* %rc, align 4, !dbg !61
  ret i32 %2, !dbg !62
}

declare i8* @getenv(i8*) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!11, !12, !13}
!llvm.ident = !{!14}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "str", scope: !2, file: !3, line: 5, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-14")
!4 = !{}
!5 = !{!0}
!6 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 65536, elements: !9)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!9 = !{!10}
!10 = !DISubrange(count: 1024)
!11 = !{i32 2, !"Dwarf Version", i32 4}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{i32 1, !"wchar_size", i32 4}
!14 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!15 = distinct !DISubprogram(name: "foo", scope: !3, file: !3, line: 8, type: !16, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!16 = !DISubroutineType(types: !17)
!17 = !{!18, !18, null}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DILocalVariable(name: "n", arg: 1, scope: !15, file: !3, line: 8, type: !18)
!20 = !DIExpression()
!21 = !DILocation(line: 8, column: 9, scope: !15)
!22 = !DILocalVariable(name: "ap", scope: !15, file: !3, line: 9, type: !23)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !24, line: 30, baseType: !25)
!24 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-14")
!25 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !3, line: 9, baseType: !26)
!26 = !DICompositeType(tag: DW_TAG_array_type, baseType: !27, size: 192, elements: !35)
!27 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !3, line: 9, size: 192, elements: !28)
!28 = !{!29, !31, !32, !34}
!29 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !27, file: !3, line: 9, baseType: !30, size: 32)
!30 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !27, file: !3, line: 9, baseType: !30, size: 32, offset: 32)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !27, file: !3, line: 9, baseType: !33, size: 64, offset: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !27, file: !3, line: 9, baseType: !33, size: 64, offset: 128)
!35 = !{!36}
!36 = !DISubrange(count: 1)
!37 = !DILocation(line: 9, column: 13, scope: !15)
!38 = !DILocation(line: 10, column: 5, scope: !15)
!39 = !DILocalVariable(name: "t1", scope: !15, file: !3, line: 12, type: !7)
!40 = !DILocation(line: 12, column: 11, scope: !15)
!41 = !DILocation(line: 12, column: 16, scope: !15)
!42 = !DILocalVariable(name: "ut1", scope: !15, file: !3, line: 13, type: !7)
!43 = !DILocation(line: 13, column: 11, scope: !15)
!44 = !DILocation(line: 13, column: 17, scope: !15)
!45 = !DILocalVariable(name: "t2", scope: !15, file: !3, line: 14, type: !7)
!46 = !DILocation(line: 14, column: 11, scope: !15)
!47 = !DILocation(line: 14, column: 16, scope: !15)
!48 = !DILocation(line: 16, column: 5, scope: !15)
!49 = !DILocation(line: 18, column: 5, scope: !15)
!50 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 22, type: !51, isLocal: false, isDefinition: true, scopeLine: 23, isOptimized: false, unit: !2, variables: !4)
!51 = !DISubroutineType(types: !52)
!52 = !{!18}
!53 = !DILocation(line: 24, column: 15, scope: !50)
!54 = !DILocation(line: 24, column: 13, scope: !50)
!55 = !DILocalVariable(name: "rc", scope: !50, file: !3, line: 26, type: !18)
!56 = !DILocation(line: 26, column: 9, scope: !50)
!57 = !DILocation(line: 26, column: 21, scope: !50)
!58 = !DILocation(line: 26, column: 30, scope: !50)
!59 = !DILocation(line: 26, column: 38, scope: !50)
!60 = !DILocation(line: 26, column: 14, scope: !50)
!61 = !DILocation(line: 28, column: 12, scope: !50)
!62 = !DILocation(line: 28, column: 5, scope: !50)
