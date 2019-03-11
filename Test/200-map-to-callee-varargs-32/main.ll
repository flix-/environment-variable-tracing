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
define i32 @forwarder(i32 %n, ...) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  %ss = alloca %struct.s4, align 8
  %t1 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !14, metadata !12), !dbg !35
  %s1 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !36
  %vas = getelementptr inbounds %struct.s2, %struct.s2* %s1, i32 0, i32 0, !dbg !36
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas, i32 0, i32 0, !dbg !36
  %arraydecay2 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !36
  call void @llvm.va_start(i8* %arraydecay2), !dbg !36
  call void @llvm.dbg.declare(metadata %struct.s4* %ss, metadata !37, metadata !12), !dbg !52
  %s3 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !53
  %vas4 = getelementptr inbounds %struct.s2, %struct.s2* %s3, i32 0, i32 0, !dbg !53
  %arraydecay5 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas4, i32 0, i32 0, !dbg !53
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay5, i32 0, i32 0, !dbg !53
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !53
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !53
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !53

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay5, i32 0, i32 3, !dbg !53
  %reg_save_area = load i8*, i8** %0, align 8, !dbg !53
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !53
  %2 = bitcast i8* %1 to %struct.s5**, !dbg !53
  %3 = add i32 %gp_offset, 8, !dbg !53
  store i32 %3, i32* %gp_offset_p, align 8, !dbg !53
  br label %vaarg.end, !dbg !53

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay5, i32 0, i32 2, !dbg !53
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !53
  %4 = bitcast i8* %overflow_arg_area to %struct.s5**, !dbg !53
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !53
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !53
  br label %vaarg.end, !dbg !53

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi %struct.s5** [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !53
  %5 = load %struct.s5*, %struct.s5** %vaarg.addr, align 8, !dbg !53
  %s5 = getelementptr inbounds %struct.s4, %struct.s4* %ss, i32 0, i32 4, !dbg !54
  store %struct.s5* %5, %struct.s5** %s5, align 8, !dbg !55
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !56, metadata !12), !dbg !57
  %s56 = getelementptr inbounds %struct.s4, %struct.s4* %ss, i32 0, i32 4, !dbg !58
  %6 = load %struct.s5*, %struct.s5** %s56, align 8, !dbg !58
  %t17 = getelementptr inbounds %struct.s5, %struct.s5* %6, i32 0, i32 0, !dbg !59
  %7 = load i8*, i8** %t17, align 8, !dbg !59
  store i8* %7, i8** %t1, align 8, !dbg !57
  %s8 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !60
  %vas9 = getelementptr inbounds %struct.s2, %struct.s2* %s8, i32 0, i32 0, !dbg !60
  %arraydecay10 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %vas9, i32 0, i32 0, !dbg !60
  %arraydecay1011 = bitcast %struct.__va_list_tag* %arraydecay10 to i8*, !dbg !60
  call void @llvm.va_end(i8* %arraydecay1011), !dbg !60
  ret i32 0, !dbg !61
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !62 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s4, align 8
  %ss = alloca %struct.s5, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s4* %s, metadata !65, metadata !12), !dbg !66
  call void @llvm.dbg.declare(metadata %struct.s5* %ss, metadata !67, metadata !12), !dbg !68
  %s5 = getelementptr inbounds %struct.s4, %struct.s4* %s, i32 0, i32 4, !dbg !69
  store %struct.s5* %ss, %struct.s5** %s5, align 8, !dbg !70
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !71
  %s51 = getelementptr inbounds %struct.s4, %struct.s4* %s, i32 0, i32 4, !dbg !72
  %0 = load %struct.s5*, %struct.s5** %s51, align 8, !dbg !72
  %t1 = getelementptr inbounds %struct.s5, %struct.s5* %0, i32 0, i32 0, !dbg !73
  store i8* %call, i8** %t1, align 8, !dbg !74
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !75, metadata !12), !dbg !76
  %s52 = getelementptr inbounds %struct.s4, %struct.s4* %s, i32 0, i32 4, !dbg !77
  %call3 = call i32 (i32, ...) @forwarder(i32 1, %struct.s5** %s52), !dbg !78
  store i32 %call3, i32* %rc, align 4, !dbg !76
  %1 = load i32, i32* %rc, align 4, !dbg !79
  ret i32 %1, !dbg !80
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-32")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "forwarder", scope: !1, file: !1, line: 28, type: !8, isLocal: false, isDefinition: true, scopeLine: 29, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, null}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 28, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 28, column: 15, scope: !7)
!14 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 30, type: !15)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 10, size: 192, elements: !16)
!16 = !{!17}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !15, file: !1, line: 11, baseType: !18, size: 192)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s2", file: !1, line: 6, size: 192, elements: !19)
!19 = !{!20}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "vas", scope: !18, file: !1, line: 7, baseType: !21, size: 192)
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !22, line: 30, baseType: !23)
!22 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-32")
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 30, baseType: !24)
!24 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 192, elements: !33)
!25 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 30, size: 192, elements: !26)
!26 = !{!27, !29, !30, !32}
!27 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !25, file: !1, line: 30, baseType: !28, size: 32)
!28 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !25, file: !1, line: 30, baseType: !28, size: 32, offset: 32)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !25, file: !1, line: 30, baseType: !31, size: 64, offset: 64)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !25, file: !1, line: 30, baseType: !31, size: 64, offset: 128)
!33 = !{!34}
!34 = !DISubrange(count: 1)
!35 = !DILocation(line: 30, column: 15, scope: !7)
!36 = !DILocation(line: 32, column: 5, scope: !7)
!37 = !DILocalVariable(name: "ss", scope: !7, file: !1, line: 34, type: !38)
!38 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s4", file: !1, line: 19, size: 256, elements: !39)
!39 = !{!40, !41, !42, !45, !46}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !38, file: !1, line: 20, baseType: !10, size: 32)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !38, file: !1, line: 21, baseType: !10, size: 32, offset: 32)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !38, file: !1, line: 22, baseType: !43, size: 64, offset: 64)
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!44 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "ut2", scope: !38, file: !1, line: 23, baseType: !43, size: 64, offset: 128)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "s5", scope: !38, file: !1, line: 24, baseType: !47, size: 64, offset: 192)
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s5", file: !1, line: 14, size: 128, elements: !49)
!49 = !{!50, !51}
!50 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !48, file: !1, line: 15, baseType: !43, size: 64)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "ut1", scope: !48, file: !1, line: 16, baseType: !43, size: 64, offset: 64)
!52 = !DILocation(line: 34, column: 15, scope: !7)
!53 = !DILocation(line: 35, column: 13, scope: !7)
!54 = !DILocation(line: 35, column: 8, scope: !7)
!55 = !DILocation(line: 35, column: 11, scope: !7)
!56 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 37, type: !43)
!57 = !DILocation(line: 37, column: 11, scope: !7)
!58 = !DILocation(line: 37, column: 19, scope: !7)
!59 = !DILocation(line: 37, column: 23, scope: !7)
!60 = !DILocation(line: 39, column: 5, scope: !7)
!61 = !DILocation(line: 41, column: 5, scope: !7)
!62 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 45, type: !63, isLocal: false, isDefinition: true, scopeLine: 46, isOptimized: false, unit: !0, variables: !2)
!63 = !DISubroutineType(types: !64)
!64 = !{!10}
!65 = !DILocalVariable(name: "s", scope: !62, file: !1, line: 47, type: !38)
!66 = !DILocation(line: 47, column: 15, scope: !62)
!67 = !DILocalVariable(name: "ss", scope: !62, file: !1, line: 48, type: !48)
!68 = !DILocation(line: 48, column: 15, scope: !62)
!69 = !DILocation(line: 49, column: 7, scope: !62)
!70 = !DILocation(line: 49, column: 10, scope: !62)
!71 = !DILocation(line: 51, column: 16, scope: !62)
!72 = !DILocation(line: 51, column: 7, scope: !62)
!73 = !DILocation(line: 51, column: 11, scope: !62)
!74 = !DILocation(line: 51, column: 14, scope: !62)
!75 = !DILocalVariable(name: "rc", scope: !62, file: !1, line: 53, type: !10)
!76 = !DILocation(line: 53, column: 9, scope: !62)
!77 = !DILocation(line: 53, column: 30, scope: !62)
!78 = !DILocation(line: 53, column: 14, scope: !62)
!79 = !DILocation(line: 55, column: 12, scope: !62)
!80 = !DILocation(line: 55, column: 5, scope: !62)
