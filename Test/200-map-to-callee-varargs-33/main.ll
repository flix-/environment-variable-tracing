; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { %struct.s2 }
%struct.s2 = type { [1 x %struct.__va_list_tag] }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s4 = type { i32, i32, i8*, i8*, %struct.s5* }
%struct.s5 = type { i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(%struct.s1* byval align 8 %s) #0 !dbg !7 {
entry:
  %ss = alloca %struct.s4, align 8
  %nt = alloca i8*, align 8
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !30, metadata !31), !dbg !32
  call void @llvm.dbg.declare(metadata %struct.s4* %ss, metadata !33, metadata !31), !dbg !49
  %s1 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !50
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %s1, i32 0, i32 0, !dbg !50
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !50
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 0, !dbg !50
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !50
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !50
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !50

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 3, !dbg !50
  %reg_save_area = load i8*, i8** %0, align 8, !dbg !50
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !50
  %2 = bitcast i8* %1 to %struct.s5**, !dbg !50
  %3 = add i32 %gp_offset, 8, !dbg !50
  store i32 %3, i32* %gp_offset_p, align 8, !dbg !50
  br label %vaarg.end, !dbg !50

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay, i32 0, i32 2, !dbg !50
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !50
  %4 = bitcast i8* %overflow_arg_area to %struct.s5**, !dbg !50
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !50
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !50
  br label %vaarg.end, !dbg !50

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi %struct.s5** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !50
  %5 = load %struct.s5*, %struct.s5** %vaarg.addr, align 8, !dbg !50
  %s5 = getelementptr inbounds %struct.s4, %struct.s4* %ss, i32 0, i32 4, !dbg !51
  store %struct.s5* %5, %struct.s5** %s5, align 8, !dbg !52
  call void @llvm.dbg.declare(metadata i8** %nt, metadata !53, metadata !31), !dbg !54
  %s52 = getelementptr inbounds %struct.s4, %struct.s4* %ss, i32 0, i32 4, !dbg !55
  %6 = load %struct.s5*, %struct.s5** %s52, align 8, !dbg !55
  %t1 = getelementptr inbounds %struct.s5, %struct.s5* %6, i32 0, i32 0, !dbg !56
  %7 = load i8*, i8** %t1, align 8, !dbg !56
  store i8* %7, i8** %nt, align 8, !dbg !54
  ret void, !dbg !57
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @forwarder(i32 %n, ...) #0 !dbg !58 {
entry:
  %n.addr = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !61, metadata !31), !dbg !62
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !63, metadata !31), !dbg !64
  %s1 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !65
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %s1, i32 0, i32 0, !dbg !65
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !65
  %arraydecay2 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !65
  call void @llvm.va_start(i8* %arraydecay2), !dbg !65
  %s3 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !66
  %vas4 = getelementptr inbounds %struct.s2, %struct.s2* %s3, i32 0, i32 0, !dbg !66
  %arraydecay5 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas4, i32 0, i32 0, !dbg !66
  %arraydecay56 = bitcast %struct.__va_list_tag* %arraydecay5 to i8*, !dbg !66
  call void @llvm.va_end(i8* %arraydecay56), !dbg !66
  call void @foo(%struct.s1* byval align 8 %s), !dbg !67
  ret i32 0, !dbg !68
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !69 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s4, align 8
  %ss = alloca %struct.s5, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s4* %s, metadata !72, metadata !31), !dbg !73
  call void @llvm.dbg.declare(metadata %struct.s5* %ss, metadata !74, metadata !31), !dbg !75
  %s5 = getelementptr inbounds %struct.s4, %struct.s4* %s, i32 0, i32 4, !dbg !76
  store %struct.s5* %ss, %struct.s5** %s5, align 8, !dbg !77
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !78
  %s51 = getelementptr inbounds %struct.s4, %struct.s4* %s, i32 0, i32 4, !dbg !79
  %0 = load %struct.s5*, %struct.s5** %s51, align 8, !dbg !79
  %t1 = getelementptr inbounds %struct.s5, %struct.s5* %0, i32 0, i32 0, !dbg !80
  store i8* %call, i8** %t1, align 8, !dbg !81
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !82, metadata !31), !dbg !83
  %s52 = getelementptr inbounds %struct.s4, %struct.s4* %s, i32 0, i32 4, !dbg !84
  %call3 = call i32 (i32, ...) @forwarder(i32 1, %struct.s5** %s52), !dbg !85
  store i32 %call3, i32* %rc, align 4, !dbg !83
  %1 = load i32, i32* %rc, align 4, !dbg !86
  ret i32 %1, !dbg !87
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-33")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 28, type: !8, isLocal: false, isDefinition: true, scopeLine: 28, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 10, size: 192, elements: !11)
!11 = !{!12}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !10, file: !1, line: 11, baseType: !13, size: 192)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 6, size: 192, elements: !14)
!14 = !{!15}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "vas", scope: !13, file: !1, line: 7, baseType: !16, size: 192)
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !17, line: 30, baseType: !18)
!17 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-33")
!18 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, baseType: !19)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !20, size: 192, elements: !28)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, size: 192, elements: !21)
!21 = !{!22, !24, !25, !27}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !20, file: !1, baseType: !23, size: 32)
!23 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !20, file: !1, baseType: !23, size: 32, offset: 32)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !20, file: !1, baseType: !26, size: 64, offset: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !20, file: !1, baseType: !26, size: 64, offset: 128)
!28 = !{!29}
!29 = !DISubrange(count: 1)
!30 = !DILocalVariable(name: "s", arg: 1, scope: !7, file: !1, line: 28, type: !10)
!31 = !DIExpression()
!32 = !DILocation(line: 28, column: 15, scope: !7)
!33 = !DILocalVariable(name: "ss", scope: !7, file: !1, line: 29, type: !34)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s4", file: !1, line: 19, size: 256, elements: !35)
!35 = !{!36, !38, !39, !42, !43}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !34, file: !1, line: 20, baseType: !37, size: 32)
!37 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !34, file: !1, line: 21, baseType: !37, size: 32, offset: 32)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !34, file: !1, line: 22, baseType: !40, size: 64, offset: 64)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!41 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "ut2", scope: !34, file: !1, line: 23, baseType: !40, size: 64, offset: 128)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "s5", scope: !34, file: !1, line: 24, baseType: !44, size: 64, offset: 192)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 64)
!45 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s5", file: !1, line: 14, size: 128, elements: !46)
!46 = !{!47, !48}
!47 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !45, file: !1, line: 15, baseType: !40, size: 64)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "ut1", scope: !45, file: !1, line: 16, baseType: !40, size: 64, offset: 64)
!49 = !DILocation(line: 29, column: 15, scope: !7)
!50 = !DILocation(line: 30, column: 13, scope: !7)
!51 = !DILocation(line: 30, column: 8, scope: !7)
!52 = !DILocation(line: 30, column: 11, scope: !7)
!53 = !DILocalVariable(name: "nt", scope: !7, file: !1, line: 32, type: !40)
!54 = !DILocation(line: 32, column: 11, scope: !7)
!55 = !DILocation(line: 32, column: 19, scope: !7)
!56 = !DILocation(line: 32, column: 23, scope: !7)
!57 = !DILocation(line: 33, column: 1, scope: !7)
!58 = distinct !DISubprogram(name: "forwarder", scope: !1, file: !1, line: 36, type: !59, isLocal: false, isDefinition: true, scopeLine: 37, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!59 = !DISubroutineType(types: !60)
!60 = !{!37, !37, null}
!61 = !DILocalVariable(name: "n", arg: 1, scope: !58, file: !1, line: 36, type: !37)
!62 = !DILocation(line: 36, column: 15, scope: !58)
!63 = !DILocalVariable(name: "s", scope: !58, file: !1, line: 38, type: !10)
!64 = !DILocation(line: 38, column: 15, scope: !58)
!65 = !DILocation(line: 40, column: 5, scope: !58)
!66 = !DILocation(line: 41, column: 5, scope: !58)
!67 = !DILocation(line: 43, column: 5, scope: !58)
!68 = !DILocation(line: 45, column: 5, scope: !58)
!69 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 49, type: !70, isLocal: false, isDefinition: true, scopeLine: 50, isOptimized: false, unit: !0, variables: !2)
!70 = !DISubroutineType(types: !71)
!71 = !{!37}
!72 = !DILocalVariable(name: "s", scope: !69, file: !1, line: 51, type: !34)
!73 = !DILocation(line: 51, column: 15, scope: !69)
!74 = !DILocalVariable(name: "ss", scope: !69, file: !1, line: 52, type: !45)
!75 = !DILocation(line: 52, column: 15, scope: !69)
!76 = !DILocation(line: 53, column: 7, scope: !69)
!77 = !DILocation(line: 53, column: 10, scope: !69)
!78 = !DILocation(line: 55, column: 16, scope: !69)
!79 = !DILocation(line: 55, column: 7, scope: !69)
!80 = !DILocation(line: 55, column: 11, scope: !69)
!81 = !DILocation(line: 55, column: 14, scope: !69)
!82 = !DILocalVariable(name: "rc", scope: !69, file: !1, line: 57, type: !37)
!83 = !DILocation(line: 57, column: 9, scope: !69)
!84 = !DILocation(line: 57, column: 30, scope: !69)
!85 = !DILocation(line: 57, column: 14, scope: !69)
!86 = !DILocation(line: 59, column: 12, scope: !69)
!87 = !DILocation(line: 59, column: 5, scope: !69)
