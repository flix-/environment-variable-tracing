; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s2 = type { i8*, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %n, ...) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %s2 = alloca %struct.s2*, align 8
  %t1 = alloca i8*, align 8
  %t2 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !14, metadata !12), !dbg !29
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !30
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !30
  call void @llvm.va_start(i8* %arraydecay1), !dbg !30
  call void @llvm.dbg.declare(metadata %struct.s2** %s2, metadata !31, metadata !12), !dbg !40
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !41
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !41
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !41
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !41
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !41

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !41
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !41
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !41
  %2 = bitcast i8* %1 to %struct.s2**, !dbg !41
  %3 = add i32 %gp_offset, 8, !dbg !41
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !41
  br label %vaarg.end, !dbg !41

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !41
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !41
  %4 = bitcast i8* %overflow_arg_area to %struct.s2**, !dbg !41
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !41
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !41
  br label %vaarg.end, !dbg !41

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi %struct.s2** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !41
  %5 = load %struct.s2*, %struct.s2** %vaarg.addr, align 8, !dbg !41
  store %struct.s2* %5, %struct.s2** %s2, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !42, metadata !12), !dbg !43
  %6 = load %struct.s2*, %struct.s2** %s2, align 8, !dbg !44
  %t13 = getelementptr inbounds %struct.s2, %struct.s2* %6, i32 0, i32 0, !dbg !45
  %7 = load i8*, i8** %t13, align 8, !dbg !45
  store i8* %7, i8** %t1, align 8, !dbg !43
  call void @llvm.dbg.declare(metadata i8** %t2, metadata !46, metadata !12), !dbg !47
  %8 = load %struct.s2*, %struct.s2** %s2, align 8, !dbg !48
  %t24 = getelementptr inbounds %struct.s2, %struct.s2* %8, i32 0, i32 1, !dbg !49
  %9 = load i8*, i8** %t24, align 8, !dbg !49
  store i8* %9, i8** %t2, align 8, !dbg !47
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !50, metadata !12), !dbg !51
  %10 = load %struct.s2*, %struct.s2** %s2, align 8, !dbg !52
  %ut15 = getelementptr inbounds %struct.s2, %struct.s2* %10, i32 0, i32 2, !dbg !53
  %11 = load i8*, i8** %ut15, align 8, !dbg !53
  store i8* %11, i8** %ut1, align 8, !dbg !51
  %arraydecay6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !54
  %arraydecay67 = bitcast %struct.__va_list_tag* %arraydecay6 to i8*, !dbg !54
  call void @llvm.va_end(i8* %arraydecay67), !dbg !54
  ret void, !dbg !55
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !56 {
entry:
  %retval = alloca i32, align 4
  %s2 = alloca %struct.s2, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !59, metadata !12), !dbg !60
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !61
  %t1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !62
  store i8* %call, i8** %t1, align 8, !dbg !63
  %t11 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 0, !dbg !64
  %0 = load i8*, i8** %t11, align 8, !dbg !64
  %t2 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !65
  store i8* %0, i8** %t2, align 8, !dbg !66
  call void (i32, ...) @foo(i32 1, %struct.s2* %s2), !dbg !67
  ret i32 0, !dbg !68
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-7")
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
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-7")
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
!31 = !DILocalVariable(name: "s2", scope: !7, file: !1, line: 23, type: !32)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 5, size: 192, elements: !34)
!34 = !{!35, !38, !39}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !33, file: !1, line: 6, baseType: !36, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !33, file: !1, line: 7, baseType: !36, size: 64, offset: 64)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "ut1", scope: !33, file: !1, line: 8, baseType: !36, size: 64, offset: 128)
!40 = !DILocation(line: 23, column: 16, scope: !7)
!41 = !DILocation(line: 23, column: 21, scope: !7)
!42 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 25, type: !36)
!43 = !DILocation(line: 25, column: 11, scope: !7)
!44 = !DILocation(line: 25, column: 16, scope: !7)
!45 = !DILocation(line: 25, column: 20, scope: !7)
!46 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 26, type: !36)
!47 = !DILocation(line: 26, column: 11, scope: !7)
!48 = !DILocation(line: 26, column: 16, scope: !7)
!49 = !DILocation(line: 26, column: 20, scope: !7)
!50 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 27, type: !36)
!51 = !DILocation(line: 27, column: 11, scope: !7)
!52 = !DILocation(line: 27, column: 17, scope: !7)
!53 = !DILocation(line: 27, column: 21, scope: !7)
!54 = !DILocation(line: 29, column: 5, scope: !7)
!55 = !DILocation(line: 30, column: 1, scope: !7)
!56 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 33, type: !57, isLocal: false, isDefinition: true, scopeLine: 34, isOptimized: false, unit: !0, variables: !2)
!57 = !DISubroutineType(types: !58)
!58 = !{!10}
!59 = !DILocalVariable(name: "s2", scope: !56, file: !1, line: 35, type: !33)
!60 = !DILocation(line: 35, column: 15, scope: !56)
!61 = !DILocation(line: 36, column: 13, scope: !56)
!62 = !DILocation(line: 36, column: 8, scope: !56)
!63 = !DILocation(line: 36, column: 11, scope: !56)
!64 = !DILocation(line: 37, column: 16, scope: !56)
!65 = !DILocation(line: 37, column: 8, scope: !56)
!66 = !DILocation(line: 37, column: 11, scope: !56)
!67 = !DILocation(line: 39, column: 5, scope: !56)
!68 = !DILocation(line: 41, column: 5, scope: !56)
