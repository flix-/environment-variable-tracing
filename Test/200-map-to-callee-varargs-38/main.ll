; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s1 = type { i32, i32, %struct.s2 }
%struct.s2 = type { i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"hello world\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i8* @foo(i32 %n, ...) #0 !dbg !7 {
entry:
  %retval = alloca i8*, align 8
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %s1 = alloca %struct.s1, align 8
  %z = alloca i8*, align 8
  %t1 = alloca i8*, align 8
  %ut129 = alloca i8*, align 8
  %ut2 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !16, metadata !14), !dbg !31
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !32
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !32
  call void @llvm.va_start(i8* %arraydecay1), !dbg !32
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !33, metadata !14), !dbg !43
  %0 = load i32, i32* %n.addr, align 4, !dbg !44
  %tobool = icmp ne i32 %0, 0, !dbg !44
  br i1 %tobool, label %if.then, label %if.end, !dbg !46

if.then:                                          ; preds = %entry
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !47
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !47
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !47
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !47
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !47

vaarg.in_reg:                                     ; preds = %if.then
  %1 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !47
  %reg_save_area = load i8*, i8** %1, align 16, !dbg !47
  %2 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !47
  %3 = bitcast i8* %2 to i8**, !dbg !47
  %4 = add i32 %gp_offset, 8, !dbg !47
  store i32 %4, i32* %gp_offset_p, align 16, !dbg !47
  br label %vaarg.end, !dbg !47

vaarg.in_mem:                                     ; preds = %if.then
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !47
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !47
  %5 = bitcast i8* %overflow_arg_area to i8**, !dbg !47
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !47
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !47
  br label %vaarg.end, !dbg !47

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i8** [ %3, %vaarg.in_reg ], [ %5, %vaarg.in_mem ], !dbg !47
  %6 = load i8*, i8** %vaarg.addr, align 8, !dbg !47
  store i8* %6, i8** %retval, align 8, !dbg !49
  br label %return, !dbg !49

if.end:                                           ; preds = %entry
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !50
  %gp_offset_p4 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 0, !dbg !50
  %gp_offset5 = load i32, i32* %gp_offset_p4, align 16, !dbg !50
  %fits_in_gp6 = icmp ule i32 %gp_offset5, 40, !dbg !50
  br i1 %fits_in_gp6, label %vaarg.in_reg7, label %vaarg.in_mem9, !dbg !50

vaarg.in_reg7:                                    ; preds = %if.end
  %7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 3, !dbg !50
  %reg_save_area8 = load i8*, i8** %7, align 16, !dbg !50
  %8 = getelementptr i8, i8* %reg_save_area8, i32 %gp_offset5, !dbg !50
  %9 = bitcast i8* %8 to i8**, !dbg !50
  %10 = add i32 %gp_offset5, 8, !dbg !50
  store i32 %10, i32* %gp_offset_p4, align 16, !dbg !50
  br label %vaarg.end13, !dbg !50

vaarg.in_mem9:                                    ; preds = %if.end
  %overflow_arg_area_p10 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !50
  %overflow_arg_area11 = load i8*, i8** %overflow_arg_area_p10, align 8, !dbg !50
  %11 = bitcast i8* %overflow_arg_area11 to i8**, !dbg !50
  %overflow_arg_area.next12 = getelementptr i8, i8* %overflow_arg_area11, i32 8, !dbg !50
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10, align 8, !dbg !50
  br label %vaarg.end13, !dbg !50

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %vaarg.addr14 = phi i8** [ %9, %vaarg.in_reg7 ], [ %11, %vaarg.in_mem9 ], !dbg !50
  %12 = load i8*, i8** %vaarg.addr14, align 8, !dbg !50
  %s2 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !51
  %ut1 = getelementptr inbounds %struct.s2, %struct.s2* %s2, i32 0, i32 1, !dbg !52
  store i8* %12, i8** %ut1, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata i8** %z, metadata !54, metadata !14), !dbg !55
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !56
  %gp_offset_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 0, !dbg !56
  %gp_offset17 = load i32, i32* %gp_offset_p16, align 16, !dbg !56
  %fits_in_gp18 = icmp ule i32 %gp_offset17, 40, !dbg !56
  br i1 %fits_in_gp18, label %vaarg.in_reg19, label %vaarg.in_mem21, !dbg !56

vaarg.in_reg19:                                   ; preds = %vaarg.end13
  %13 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 3, !dbg !56
  %reg_save_area20 = load i8*, i8** %13, align 16, !dbg !56
  %14 = getelementptr i8, i8* %reg_save_area20, i32 %gp_offset17, !dbg !56
  %15 = bitcast i8* %14 to i8**, !dbg !56
  %16 = add i32 %gp_offset17, 8, !dbg !56
  store i32 %16, i32* %gp_offset_p16, align 16, !dbg !56
  br label %vaarg.end25, !dbg !56

vaarg.in_mem21:                                   ; preds = %vaarg.end13
  %overflow_arg_area_p22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay15, i32 0, i32 2, !dbg !56
  %overflow_arg_area23 = load i8*, i8** %overflow_arg_area_p22, align 8, !dbg !56
  %17 = bitcast i8* %overflow_arg_area23 to i8**, !dbg !56
  %overflow_arg_area.next24 = getelementptr i8, i8* %overflow_arg_area23, i32 8, !dbg !56
  store i8* %overflow_arg_area.next24, i8** %overflow_arg_area_p22, align 8, !dbg !56
  br label %vaarg.end25, !dbg !56

vaarg.end25:                                      ; preds = %vaarg.in_mem21, %vaarg.in_reg19
  %vaarg.addr26 = phi i8** [ %15, %vaarg.in_reg19 ], [ %17, %vaarg.in_mem21 ], !dbg !56
  %18 = load i8*, i8** %vaarg.addr26, align 8, !dbg !56
  store i8* %18, i8** %z, align 8, !dbg !55
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !57, metadata !14), !dbg !58
  %s227 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !59
  %t128 = getelementptr inbounds %struct.s2, %struct.s2* %s227, i32 0, i32 0, !dbg !60
  %19 = load i8*, i8** %t128, align 8, !dbg !60
  store i8* %19, i8** %t1, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata i8** %ut129, metadata !61, metadata !14), !dbg !62
  %s230 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !63
  %ut131 = getelementptr inbounds %struct.s2, %struct.s2* %s230, i32 0, i32 1, !dbg !64
  %20 = load i8*, i8** %ut131, align 8, !dbg !64
  store i8* %20, i8** %ut129, align 8, !dbg !62
  call void @llvm.dbg.declare(metadata i8** %ut2, metadata !65, metadata !14), !dbg !66
  %21 = load i8*, i8** %z, align 8, !dbg !67
  store i8* %21, i8** %ut2, align 8, !dbg !66
  %arraydecay32 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !68
  %arraydecay3233 = bitcast %struct.__va_list_tag* %arraydecay32 to i8*, !dbg !68
  call void @llvm.va_end(i8* %arraydecay3233), !dbg !68
  store i8* null, i8** %retval, align 8, !dbg !69
  br label %return, !dbg !69

return:                                           ; preds = %vaarg.end25, %vaarg.end
  %22 = load i8*, i8** %retval, align 8, !dbg !70
  ret i8* %22, !dbg !70
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !71 {
entry:
  %retval = alloca i32, align 4
  %t = alloca i8*, align 8
  %ut = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %t, metadata !74, metadata !14), !dbg !75
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !76
  store i8* %call, i8** %t, align 8, !dbg !75
  call void @llvm.dbg.declare(metadata i8** %ut, metadata !77, metadata !14), !dbg !78
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0), i8** %ut, align 8, !dbg !78
  %0 = load i8*, i8** %t, align 8, !dbg !79
  %1 = load i8*, i8** %ut, align 8, !dbg !80
  %call1 = call i8* (i32, ...) @foo(i32 1, i8* %0, i8* %1), !dbg !81
  ret i32 0, !dbg !82
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-38")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 18, type: !8, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !12, null}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 18, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 18, column: 9, scope: !7)
!16 = !DILocalVariable(name: "ap", scope: !7, file: !1, line: 20, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !18, line: 30, baseType: !19)
!18 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-38")
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 20, baseType: !20)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 192, elements: !29)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 20, size: 192, elements: !22)
!22 = !{!23, !25, !26, !28}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !21, file: !1, line: 20, baseType: !24, size: 32)
!24 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !21, file: !1, line: 20, baseType: !24, size: 32, offset: 32)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !21, file: !1, line: 20, baseType: !27, size: 64, offset: 64)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !21, file: !1, line: 20, baseType: !27, size: 64, offset: 128)
!29 = !{!30}
!30 = !DISubrange(count: 1)
!31 = !DILocation(line: 20, column: 13, scope: !7)
!32 = !DILocation(line: 21, column: 5, scope: !7)
!33 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 23, type: !34)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 11, size: 192, elements: !35)
!35 = !{!36, !37, !38}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !34, file: !1, line: 12, baseType: !12, size: 32)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !34, file: !1, line: 13, baseType: !12, size: 32, offset: 32)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !34, file: !1, line: 14, baseType: !39, size: 128, offset: 64)
!39 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 6, size: 128, elements: !40)
!40 = !{!41, !42}
!41 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !39, file: !1, line: 7, baseType: !10, size: 64)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "ut1", scope: !39, file: !1, line: 8, baseType: !10, size: 64, offset: 64)
!43 = !DILocation(line: 23, column: 15, scope: !7)
!44 = !DILocation(line: 25, column: 9, scope: !45)
!45 = distinct !DILexicalBlock(scope: !7, file: !1, line: 25, column: 9)
!46 = !DILocation(line: 25, column: 9, scope: !7)
!47 = !DILocation(line: 26, column: 16, scope: !48)
!48 = distinct !DILexicalBlock(scope: !45, file: !1, line: 25, column: 12)
!49 = !DILocation(line: 26, column: 9, scope: !48)
!50 = !DILocation(line: 28, column: 17, scope: !7)
!51 = !DILocation(line: 28, column: 8, scope: !7)
!52 = !DILocation(line: 28, column: 11, scope: !7)
!53 = !DILocation(line: 28, column: 15, scope: !7)
!54 = !DILocalVariable(name: "z", scope: !7, file: !1, line: 29, type: !10)
!55 = !DILocation(line: 29, column: 11, scope: !7)
!56 = !DILocation(line: 29, column: 15, scope: !7)
!57 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 31, type: !10)
!58 = !DILocation(line: 31, column: 11, scope: !7)
!59 = !DILocation(line: 31, column: 19, scope: !7)
!60 = !DILocation(line: 31, column: 22, scope: !7)
!61 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 32, type: !10)
!62 = !DILocation(line: 32, column: 11, scope: !7)
!63 = !DILocation(line: 32, column: 20, scope: !7)
!64 = !DILocation(line: 32, column: 23, scope: !7)
!65 = !DILocalVariable(name: "ut2", scope: !7, file: !1, line: 33, type: !10)
!66 = !DILocation(line: 33, column: 11, scope: !7)
!67 = !DILocation(line: 33, column: 17, scope: !7)
!68 = !DILocation(line: 35, column: 5, scope: !7)
!69 = !DILocation(line: 37, column: 5, scope: !7)
!70 = !DILocation(line: 38, column: 1, scope: !7)
!71 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 41, type: !72, isLocal: false, isDefinition: true, scopeLine: 42, isOptimized: false, unit: !0, variables: !2)
!72 = !DISubroutineType(types: !73)
!73 = !{!12}
!74 = !DILocalVariable(name: "t", scope: !71, file: !1, line: 43, type: !10)
!75 = !DILocation(line: 43, column: 11, scope: !71)
!76 = !DILocation(line: 43, column: 15, scope: !71)
!77 = !DILocalVariable(name: "ut", scope: !71, file: !1, line: 44, type: !10)
!78 = !DILocation(line: 44, column: 11, scope: !71)
!79 = !DILocation(line: 46, column: 12, scope: !71)
!80 = !DILocation(line: 46, column: 15, scope: !71)
!81 = !DILocation(line: 46, column: 5, scope: !71)
!82 = !DILocation(line: 48, column: 5, scope: !71)
