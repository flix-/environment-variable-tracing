; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s1 = type { i32, i32, %struct.s2 }
%struct.s2 = type { i8*, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"i am not tainted\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %n, ...) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %s1 = alloca %struct.s1, align 8
  %t2 = alloca i8*, align 8
  %t128 = alloca i8*, align 8
  %t3 = alloca i8*, align 8
  %ut2 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !14, metadata !12), !dbg !29
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !30
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !30
  call void @llvm.va_start(i8* %arraydecay1), !dbg !30
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !31, metadata !12), !dbg !44
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !45
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !45
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !45
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !45
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !45

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !45
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !45
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !45
  %2 = bitcast i8* %1 to i8**, !dbg !45
  %3 = add i32 %gp_offset, 8, !dbg !45
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !45
  br label %vaarg.end, !dbg !45

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !45
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !45
  %4 = bitcast i8* %overflow_arg_area to i8**, !dbg !45
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !45
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !45
  br label %vaarg.end, !dbg !45

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !45
  %5 = load i8*, i8** %vaarg.addr, align 8, !dbg !45
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !46
  %t1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !47
  store i8* %5, i8** %t1, align 8, !dbg !48
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !49, metadata !12), !dbg !50
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !51
  %gp_offset_p4 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 0, !dbg !51
  %gp_offset5 = load i32, i32* %gp_offset_p4, align 16, !dbg !51
  %fits_in_gp6 = icmp ule i32 %gp_offset5, 40, !dbg !51
  br i1 %fits_in_gp6, label %vaarg.in_reg7, label %vaarg.in_mem9, !dbg !51

vaarg.in_reg7:                                    ; preds = %vaarg.end
  %6 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 3, !dbg !51
  %reg_save_area8 = load i8*, i8** %6, align 16, !dbg !51
  %7 = getelementptr i8, i8* %reg_save_area8, i32 %gp_offset5, !dbg !51
  %8 = bitcast i8* %7 to i8**, !dbg !51
  %9 = add i32 %gp_offset5, 8, !dbg !51
  store i32 %9, i32* %gp_offset_p4, align 16, !dbg !51
  br label %vaarg.end13, !dbg !51

vaarg.in_mem9:                                    ; preds = %vaarg.end
  %overflow_arg_area_p10 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !51
  %overflow_arg_area11 = load i8*, i8** %overflow_arg_area_p10, align 8, !dbg !51
  %10 = bitcast i8* %overflow_arg_area11 to i8**, !dbg !51
  %overflow_arg_area.next12 = getelementptr i8, i8* %overflow_arg_area11, i32 8, !dbg !51
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10, align 8, !dbg !51
  br label %vaarg.end13, !dbg !51

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %vaarg.addr14 = phi i8** [ %8, %vaarg.in_reg7 ], [ %10, %vaarg.in_mem9 ], !dbg !51
  %11 = load i8*, i8** %vaarg.addr14, align 8, !dbg !51
  store i8* %11, i8** %t2, align 8, !dbg !50
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !52
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !52
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 16, !dbg !52
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !52
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !52

vaarg.in_reg19:                                   ; preds = %vaarg.end13
  %12 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !52
  %reg_save_area20 = load i8*, i8** %12, align 16, !dbg !52
  %13 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !52
  %14 = bitcast i8* %13 to i8**, !dbg !52
  %15 = add i32 %gp_offset17, 8, !dbg !52
  store i32 %15, i32* %gp_offset_p16, align 16, !dbg !52
  br label %vaarg.end25, !dbg !52

vaarg.in_mem21:                                   ; preds = %vaarg.end13
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !52
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !52
  %16 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !52
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !52
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !52
  br label %vaarg.end25, !dbg !52

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %14, %vaarg.in_reg19 ], [ %16, %vaarg.in_mem21 ], !dbg !52
  %17 = load i8*, i8** %vaarg.addr26, align 8, !dbg !52
  %s227 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !53
  %ut1 = getelementptr inbounds %struct.s2, %struct.s2* %s227, i32 0, i32 2, !dbg !54
  store i8* %17, i8** %ut1, align 8, !dbg !55
  call void @llvm.dbg.declare(metadata i8** %t128, metadata !56, metadata !12), !dbg !57
  %s229 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !58
  %t130 = getelementptr inbounds %struct.s2, %struct.s2* %s229, i32 0, i32 0, !dbg !59
  %18 = load i8*, i8** %t130, align 8, !dbg !59
  store i8* %18, i8** %t128, align 8, !dbg !57
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !60, metadata !12), !dbg !61
  %19 = load i8*, i8** %t2, align 8, !dbg !62
  store i8* %19, i8** %t3, align 8, !dbg !61
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !63, metadata !12), !dbg !64
  %s231 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !65
  %ut132 = getelementptr inbounds %struct.s2, %struct.s2* %s231, i32 0, i32 2, !dbg !66
  %20 = load i8*, i8** %ut132, align 8, !dbg !66
  store i8* %20, i8** %ut2, align 8, !dbg !64
  %arraydecay33 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !67
  %arraydecay3334 = bitcast %struct.__va_list_tag* %arraydecay33 to i8*, !dbg !67
  call void @llvm.va_end(i8* %arraydecay3334), !dbg !67
  ret void, !dbg !68
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !69 {
entry:
  %retval = alloca i32, align 4
  %s2 = alloca %struct.s2, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !72, metadata !12), !dbg !73
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !74
  %t1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !75
  store i8* %call, i8** %t1, align 8, !dbg !76
  %t11 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !77
  %0 = load i8*, i8** %t11, align 8, !dbg !77
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !78
  store i8* %0, i8** %t2, align 8, !dbg !79
  %t12 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !80
  %1 = load i8*, i8** %t12, align 8, !dbg !80
  %t23 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !81
  %2 = load i8*, i8** %t23, align 8, !dbg !81
  call void (i32, ...) @foo(i32 1, i8* %1, i8* %2, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0)), !dbg !82
  ret i32 0, !dbg !83
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-6")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 18, type: !8, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, null}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 18, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 18, column: 9, scope: !7)
!14 = !DILocalVariable(name: "ap", scope: !7, file: !1, line: 20, type: !15)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !16, line: 30, baseType: !17)
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-6")
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 20, baseType: !18)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 192, elements: !27)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 20, size: 192, elements: !20)
!20 = !{!21, !23, !24, !26}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !19, file: !1, line: 20, baseType: !22, size: 32)
!22 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !19, file: !1, line: 20, baseType: !22, size: 32, offset: 32)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !19, file: !1, line: 20, baseType: !25, size: 64, offset: 64)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !19, file: !1, line: 20, baseType: !25, size: 64, offset: 128)
!27 = !{!28}
!28 = !DISubrange(count: 1)
!29 = !DILocation(line: 20, column: 13, scope: !7)
!30 = !DILocation(line: 21, column: 5, scope: !7)
!31 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 23, type: !32)
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 11, size: 256, elements: !33)
!33 = !{!34, !35, !36}
!34 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !32, file: !1, line: 12, baseType: !10, size: 32)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !32, file: !1, line: 13, baseType: !10, size: 32, offset: 32)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !32, file: !1, line: 14, baseType: !37, size: 192, offset: 64)
!37 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 5, size: 192, elements: !38)
!38 = !{!39, !42, !43}
!39 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !37, file: !1, line: 6, baseType: !40, size: 64)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!41 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !37, file: !1, line: 7, baseType: !40, size: 64, offset: 64)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "ut1", scope: !37, file: !1, line: 8, baseType: !40, size: 64, offset: 128)
!44 = !DILocation(line: 23, column: 15, scope: !7)
!45 = !DILocation(line: 25, column: 16, scope: !7)
!46 = !DILocation(line: 25, column: 8, scope: !7)
!47 = !DILocation(line: 25, column: 11, scope: !7)
!48 = !DILocation(line: 25, column: 14, scope: !7)
!49 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 26, type: !40)
!50 = !DILocation(line: 26, column: 11, scope: !7)
!51 = !DILocation(line: 26, column: 16, scope: !7)
!52 = !DILocation(line: 27, column: 17, scope: !7)
!53 = !DILocation(line: 27, column: 8, scope: !7)
!54 = !DILocation(line: 27, column: 11, scope: !7)
!55 = !DILocation(line: 27, column: 15, scope: !7)
!56 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 29, type: !40)
!57 = !DILocation(line: 29, column: 11, scope: !7)
!58 = !DILocation(line: 29, column: 19, scope: !7)
!59 = !DILocation(line: 29, column: 22, scope: !7)
!60 = !DILocalVariable(name: "t3", scope: !7, file: !1, line: 30, type: !40)
!61 = !DILocation(line: 30, column: 11, scope: !7)
!62 = !DILocation(line: 30, column: 16, scope: !7)
!63 = !DILocalVariable(name: "ut2", scope: !7, file: !1, line: 31, type: !40)
!64 = !DILocation(line: 31, column: 11, scope: !7)
!65 = !DILocation(line: 31, column: 20, scope: !7)
!66 = !DILocation(line: 31, column: 23, scope: !7)
!67 = !DILocation(line: 33, column: 5, scope: !7)
!68 = !DILocation(line: 34, column: 1, scope: !7)
!69 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 37, type: !70, isLocal: false, isDefinition: true, scopeLine: 38, isOptimized: false, unit: !0, variables: !2)
!70 = !DISubroutineType(types: !71)
!71 = !{!10}
!72 = !DILocalVariable(name: "s2", scope: !69, file: !1, line: 39, type: !37)
!73 = !DILocation(line: 39, column: 15, scope: !69)
!74 = !DILocation(line: 40, column: 13, scope: !69)
!75 = !DILocation(line: 40, column: 8, scope: !69)
!76 = !DILocation(line: 40, column: 11, scope: !69)
!77 = !DILocation(line: 41, column: 16, scope: !69)
!78 = !DILocation(line: 41, column: 8, scope: !69)
!79 = !DILocation(line: 41, column: 11, scope: !69)
!80 = !DILocation(line: 43, column: 15, scope: !69)
!81 = !DILocation(line: 43, column: 22, scope: !69)
!82 = !DILocation(line: 43, column: 5, scope: !69)
!83 = !DILocation(line: 45, column: 5, scope: !69)
