; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %n, ...) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %x = alloca i8*, align 8
  %y = alloca i8*, align 8
  %z = alloca i8*, align 8
  %t1 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %ut2 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !14, metadata !12), !dbg !29
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !30
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !30
  call void @llvm.va_start(i8* %arraydecay1), !dbg !30
  call void @llvm.dbg.declare(metadata i8** %x, metadata !31, metadata !12), !dbg !34
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !35
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !35
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !35
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !35
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !35

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !35
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !35
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !35
  %2 = bitcast i8* %1 to i8**, !dbg !35
  %3 = add i32 %gp_offset, 8, !dbg !35
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !35
  br label %vaarg.end, !dbg !35

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !35
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !35
  %4 = bitcast i8* %overflow_arg_area to i8**, !dbg !35
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !35
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !35
  br label %vaarg.end, !dbg !35

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !35
  %5 = load i8*, i8** %vaarg.addr, align 8, !dbg !35
  store i8* %5, i8** %x, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata i8** %y, metadata !36, metadata !12), !dbg !37
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !38
  %gp_offset_p4 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 0, !dbg !38
  %gp_offset5 = load i32, i32* %gp_offset_p4, align 16, !dbg !38
  %fits_in_gp6 = icmp ule i32 %gp_offset5, 40, !dbg !38
  br i1 %fits_in_gp6, label %vaarg.in_reg7, label %vaarg.in_mem9, !dbg !38

vaarg.in_reg7:                                    ; preds = %vaarg.end
  %6 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 3, !dbg !38
  %reg_save_area8 = load i8*, i8** %6, align 16, !dbg !38
  %7 = getelementptr i8, i8* %reg_save_area8, i32 %gp_offset5, !dbg !38
  %8 = bitcast i8* %7 to i8**, !dbg !38
  %9 = add i32 %gp_offset5, 8, !dbg !38
  store i32 %9, i32* %gp_offset_p4, align 16, !dbg !38
  br label %vaarg.end13, !dbg !38

vaarg.in_mem9:                                    ; preds = %vaarg.end
  %overflow_arg_area_p10 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !38
  %overflow_arg_area11 = load i8*, i8** %overflow_arg_area_p10, align 8, !dbg !38
  %10 = bitcast i8* %overflow_arg_area11 to i8**, !dbg !38
  %overflow_arg_area.next12 = getelementptr i8, i8* %overflow_arg_area11, i32 8, !dbg !38
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10, align 8, !dbg !38
  br label %vaarg.end13, !dbg !38

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %vaarg.addr14 = phi i8** [ %8, %vaarg.in_reg7 ], [ %10, %vaarg.in_mem9 ], !dbg !38
  %11 = load i8*, i8** %vaarg.addr14, align 8, !dbg !38
  store i8* %11, i8** %y, align 8, !dbg !37
  call void @llvm.dbg.declare(metadata i8** %z, metadata !39, metadata !12), !dbg !40
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !41
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !41
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 16, !dbg !41
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !41
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !41

vaarg.in_reg19:                                   ; preds = %vaarg.end13
  %12 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !41
  %reg_save_area20 = load i8*, i8** %12, align 16, !dbg !41
  %13 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !41
  %14 = bitcast i8* %13 to i8**, !dbg !41
  %15 = add i32 %gp_offset17, 8, !dbg !41
  store i32 %15, i32* %gp_offset_p16, align 16, !dbg !41
  br label %vaarg.end25, !dbg !41

vaarg.in_mem21:                                   ; preds = %vaarg.end13
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !41
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !41
  %16 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !41
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !41
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !41
  br label %vaarg.end25, !dbg !41

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %14, %vaarg.in_reg19 ], [ %16, %vaarg.in_mem21 ], !dbg !41
  %17 = load i8*, i8** %vaarg.addr26, align 8, !dbg !41
  store i8* %17, i8** %z, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !42, metadata !12), !dbg !43
  %18 = load i8*, i8** %x, align 8, !dbg !44
  store i8* %18, i8** %t1, align 8, !dbg !43
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !45, metadata !12), !dbg !46
  %19 = load i8*, i8** %y, align 8, !dbg !47
  store i8* %19, i8** %ut1, align 8, !dbg !46
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !48, metadata !12), !dbg !49
  %20 = load i8*, i8** %z, align 8, !dbg !50
  store i8* %20, i8** %ut2, align 8, !dbg !49
  %arraydecay27 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !51
  %arraydecay2728 = bitcast %struct.__va_list_tag* %arraydecay27 to i8*, !dbg !51
  call void @llvm.va_end(i8* %arraydecay2728), !dbg !51
  ret void, !dbg !52
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !53 {
entry:
  %retval = alloca i32, align 4
  %t = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %t, metadata !56, metadata !12), !dbg !57
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !58
  store i8* %call, i8** %t, align 8, !dbg !57
  %0 = load i8*, i8** %t, align 8, !dbg !59
  call void (i32, ...) @foo(i32 1, i8* %0), !dbg !60
  ret i32 0, !dbg !61
}

declare i8* @getenv(i8*) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, null}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 6, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 6, column: 9, scope: !7)
!14 = !DILocalVariable(name: "ap", scope: !7, file: !1, line: 8, type: !15)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !16, line: 30, baseType: !17)
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-2")
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 8, baseType: !18)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 192, elements: !27)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 8, size: 192, elements: !20)
!20 = !{!21, !23, !24, !26}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !19, file: !1, line: 8, baseType: !22, size: 32)
!22 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !19, file: !1, line: 8, baseType: !22, size: 32, offset: 32)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !19, file: !1, line: 8, baseType: !25, size: 64, offset: 64)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !19, file: !1, line: 8, baseType: !25, size: 64, offset: 128)
!27 = !{!28}
!28 = !DISubrange(count: 1)
!29 = !DILocation(line: 8, column: 13, scope: !7)
!30 = !DILocation(line: 9, column: 5, scope: !7)
!31 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 11, type: !32)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!34 = !DILocation(line: 11, column: 11, scope: !7)
!35 = !DILocation(line: 11, column: 15, scope: !7)
!36 = !DILocalVariable(name: "y", scope: !7, file: !1, line: 12, type: !32)
!37 = !DILocation(line: 12, column: 11, scope: !7)
!38 = !DILocation(line: 12, column: 15, scope: !7)
!39 = !DILocalVariable(name: "z", scope: !7, file: !1, line: 13, type: !32)
!40 = !DILocation(line: 13, column: 11, scope: !7)
!41 = !DILocation(line: 13, column: 15, scope: !7)
!42 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 15, type: !32)
!43 = !DILocation(line: 15, column: 11, scope: !7)
!44 = !DILocation(line: 15, column: 16, scope: !7)
!45 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 16, type: !32)
!46 = !DILocation(line: 16, column: 11, scope: !7)
!47 = !DILocation(line: 16, column: 17, scope: !7)
!48 = !DILocalVariable(name: "ut2", scope: !7, file: !1, line: 17, type: !32)
!49 = !DILocation(line: 17, column: 11, scope: !7)
!50 = !DILocation(line: 17, column: 17, scope: !7)
!51 = !DILocation(line: 19, column: 5, scope: !7)
!52 = !DILocation(line: 20, column: 1, scope: !7)
!53 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 23, type: !54, isLocal: false, isDefinition: true, scopeLine: 24, isOptimized: false, unit: !0, variables: !2)
!54 = !DISubroutineType(types: !55)
!55 = !{!10}
!56 = !DILocalVariable(name: "t", scope: !53, file: !1, line: 25, type: !32)
!57 = !DILocation(line: 25, column: 11, scope: !53)
!58 = !DILocation(line: 25, column: 15, scope: !53)
!59 = !DILocation(line: 27, column: 12, scope: !53)
!60 = !DILocation(line: 27, column: 5, scope: !53)
!61 = !DILocation(line: 29, column: 5, scope: !53)
