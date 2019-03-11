; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s2 = type { i8*, %struct.s3 }
%struct.s3 = type { i32*, i32*, i8* }
%struct.s1 = type { i32, i32, %struct.s2* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %n, ...) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %s2 = alloca %struct.s2*, align 8
  %also_tainted = alloca i8*, align 8
  %nt1 = alloca i8*, align 8
  %nt2 = alloca i32*, align 8
  %nt3 = alloca i32*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !14, metadata !12), !dbg !29
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !30
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !30
  call void @llvm.va_start(i8* %arraydecay1), !dbg !30
  call void @llvm.dbg.declare(metadata %struct.s2** %s2, metadata !31, metadata !12), !dbg !45
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !46
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !46
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !46
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !46
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !46

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !46
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !46
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !46
  %2 = bitcast i8* %1 to %struct.s2**, !dbg !46
  %3 = add i32 %gp_offset, 8, !dbg !46
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !46
  br label %vaarg.end, !dbg !46

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !46
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !46
  %4 = bitcast i8* %overflow_arg_area to %struct.s2**, !dbg !46
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !46
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !46
  br label %vaarg.end, !dbg !46

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi %struct.s2** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !46
  %5 = load %struct.s2*, %struct.s2** %vaarg.addr, align 8, !dbg !46
  store %struct.s2* %5, %struct.s2** %s2, align 8, !dbg !45
  call void @llvm.dbg.declare(metadata i8** %also_tainted, metadata !47, metadata !12), !dbg !48
  %6 = load %struct.s2*, %struct.s2** %s2, align 8, !dbg !49
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %6, i32 0, i32 1, !dbg !50
  %t1 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 2, !dbg !51
  %7 = load i8*, i8** %t1, align 8, !dbg !51
  store i8* %7, i8** %also_tainted, align 8, !dbg !48
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !52, metadata !12), !dbg !53
  %8 = load %struct.s2*, %struct.s2** %s2, align 8, !dbg !54
  %t13 = getelementptr inbounds %struct.s2, %struct.s2* %8, i32 0, i32 0, !dbg !55
  %9 = load i8*, i8** %t13, align 8, !dbg !55
  store i8* %9, i8** %nt1, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata i32** %nt2, metadata !56, metadata !12), !dbg !57
  %10 = load %struct.s2*, %struct.s2** %s2, align 8, !dbg !58
  %s34 = getelementptr inbounds %struct.s2, %struct.s2* %10, i32 0, i32 1, !dbg !59
  %a = getelementptr inbounds %struct.s3, %struct.s3* %s34, i32 0, i32 0, !dbg !60
  %11 = load i32*, i32** %a, align 8, !dbg !60
  store i32* %11, i32** %nt2, align 8, !dbg !57
  call void @llvm.dbg.declare(metadata i32** %nt3, metadata !61, metadata !12), !dbg !62
  %12 = load %struct.s2*, %struct.s2** %s2, align 8, !dbg !63
  %s35 = getelementptr inbounds %struct.s2, %struct.s2* %12, i32 0, i32 1, !dbg !64
  %b = getelementptr inbounds %struct.s3, %struct.s3* %s35, i32 0, i32 1, !dbg !65
  %13 = load i32*, i32** %b, align 8, !dbg !65
  store i32* %13, i32** %nt3, align 8, !dbg !62
  %arraydecay6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !66
  %arraydecay67 = bitcast %struct.__va_list_tag* %arraydecay6 to i8*, !dbg !66
  call void @llvm.va_end(i8* %arraydecay67), !dbg !66
  ret void, !dbg !67
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !68 {
entry:
  %retval = alloca i32, align 4
  %s2 = alloca %struct.s2, align 8
  %s1 = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s2* %s2, metadata !71, metadata !12), !dbg !72
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !73
  %s3 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !74
  %t1 = getelementptr inbounds %struct.s3, %struct.s3* %s3, i32 0, i32 2, !dbg !75
  store i8* %call, i8** %t1, align 8, !dbg !76
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !77, metadata !12), !dbg !83
  %s21 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !84
  store %struct.s2* %s2, %struct.s2** %s21, align 8, !dbg !85
  %s22 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !86
  %0 = load %struct.s2*, %struct.s2** %s22, align 8, !dbg !86
  call void (i32, ...) @foo(i32 1, %struct.s2* %0), !dbg !87
  ret i32 0, !dbg !88
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-11")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 23, type: !8, isLocal: false, isDefinition: true, scopeLine: 24, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, null}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 23, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 23, column: 9, scope: !7)
!14 = !DILocalVariable(name: "ap", scope: !7, file: !1, line: 25, type: !15)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !16, line: 30, baseType: !17)
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-11")
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 25, baseType: !18)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 192, elements: !27)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 25, size: 192, elements: !20)
!20 = !{!21, !23, !24, !26}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !19, file: !1, line: 25, baseType: !22, size: 32)
!22 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !19, file: !1, line: 25, baseType: !22, size: 32, offset: 32)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !19, file: !1, line: 25, baseType: !25, size: 64, offset: 64)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !19, file: !1, line: 25, baseType: !25, size: 64, offset: 128)
!27 = !{!28}
!28 = !DISubrange(count: 1)
!29 = !DILocation(line: 25, column: 13, scope: !7)
!30 = !DILocation(line: 26, column: 5, scope: !7)
!31 = !DILocalVariable(name: "s2", scope: !7, file: !1, line: 28, type: !32)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 11, size: 256, elements: !34)
!34 = !{!35, !38}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !33, file: !1, line: 12, baseType: !36, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "s3", scope: !33, file: !1, line: 13, baseType: !39, size: 192, offset: 64)
!39 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 5, size: 192, elements: !40)
!40 = !{!41, !43, !44}
!41 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !39, file: !1, line: 6, baseType: !42, size: 64)
!42 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !39, file: !1, line: 7, baseType: !42, size: 64, offset: 64)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !39, file: !1, line: 8, baseType: !36, size: 64, offset: 128)
!45 = !DILocation(line: 28, column: 16, scope: !7)
!46 = !DILocation(line: 28, column: 21, scope: !7)
!47 = !DILocalVariable(name: "also_tainted", scope: !7, file: !1, line: 30, type: !36)
!48 = !DILocation(line: 30, column: 11, scope: !7)
!49 = !DILocation(line: 30, column: 26, scope: !7)
!50 = !DILocation(line: 30, column: 30, scope: !7)
!51 = !DILocation(line: 30, column: 33, scope: !7)
!52 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 31, type: !36)
!53 = !DILocation(line: 31, column: 11, scope: !7)
!54 = !DILocation(line: 31, column: 17, scope: !7)
!55 = !DILocation(line: 31, column: 21, scope: !7)
!56 = !DILocalVariable(name: "nt2", scope: !7, file: !1, line: 32, type: !42)
!57 = !DILocation(line: 32, column: 10, scope: !7)
!58 = !DILocation(line: 32, column: 16, scope: !7)
!59 = !DILocation(line: 32, column: 20, scope: !7)
!60 = !DILocation(line: 32, column: 23, scope: !7)
!61 = !DILocalVariable(name: "nt3", scope: !7, file: !1, line: 33, type: !42)
!62 = !DILocation(line: 33, column: 10, scope: !7)
!63 = !DILocation(line: 33, column: 16, scope: !7)
!64 = !DILocation(line: 33, column: 20, scope: !7)
!65 = !DILocation(line: 33, column: 23, scope: !7)
!66 = !DILocation(line: 35, column: 5, scope: !7)
!67 = !DILocation(line: 36, column: 1, scope: !7)
!68 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 39, type: !69, isLocal: false, isDefinition: true, scopeLine: 40, isOptimized: false, unit: !0, variables: !2)
!69 = !DISubroutineType(types: !70)
!70 = !{!10}
!71 = !DILocalVariable(name: "s2", scope: !68, file: !1, line: 41, type: !33)
!72 = !DILocation(line: 41, column: 15, scope: !68)
!73 = !DILocation(line: 42, column: 16, scope: !68)
!74 = !DILocation(line: 42, column: 8, scope: !68)
!75 = !DILocation(line: 42, column: 11, scope: !68)
!76 = !DILocation(line: 42, column: 14, scope: !68)
!77 = !DILocalVariable(name: "s1", scope: !68, file: !1, line: 43, type: !78)
!78 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 16, size: 128, elements: !79)
!79 = !{!80, !81, !82}
!80 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !78, file: !1, line: 17, baseType: !10, size: 32)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !78, file: !1, line: 18, baseType: !10, size: 32, offset: 32)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !78, file: !1, line: 19, baseType: !32, size: 64, offset: 64)
!83 = !DILocation(line: 43, column: 15, scope: !68)
!84 = !DILocation(line: 44, column: 8, scope: !68)
!85 = !DILocation(line: 44, column: 11, scope: !68)
!86 = !DILocation(line: 46, column: 15, scope: !68)
!87 = !DILocation(line: 46, column: 5, scope: !68)
!88 = !DILocation(line: 48, column: 5, scope: !68)
