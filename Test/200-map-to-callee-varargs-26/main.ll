; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.va = type { [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag] }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s1 = type { i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %n, ...) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %va_lists = alloca %struct.va, align 8
  %t1 = alloca %struct.s1, align 8
  %nt1 = alloca %struct.s1, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata %struct.va* %va_lists, metadata !14, metadata !12), !dbg !33
  %a1 = getelementptr inbounds %struct.va, %struct.va* %va_lists, i32 0, i32 0, !dbg !34
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %a1, i32 0, i32 0, !dbg !34
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !34
  call void @llvm.va_start(i8* %arraydecay1), !dbg !34
  call void @llvm.dbg.declare(metadata %struct.s1* %t1, metadata !35, metadata !12), !dbg !42
  %a12 = getelementptr inbounds %struct.va, %struct.va* %va_lists, i32 0, i32 0, !dbg !43
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %a12, i32 0, i32 0, !dbg !43
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 0, !dbg !43
  %gp_offset = load i32, i32* %gp_offset_p, align 8, !dbg !43
  %fits_in_gp = icmp ule i32 %gp_offset, 32, !dbg !43
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !43

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 3, !dbg !43
  %reg_save_area = load i8*, i8** %0, align 8, !dbg !43
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !43
  %2 = bitcast i8* %1 to %struct.s1*, !dbg !43
  %3 = add i32 %gp_offset, 16, !dbg !43
  store i32 %3, i32* %gp_offset_p, align 8, !dbg !43
  br label %vaarg.end, !dbg !43

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !43
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !43
  %4 = bitcast i8* %overflow_arg_area to %struct.s1*, !dbg !43
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 16, !dbg !43
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !43
  br label %vaarg.end, !dbg !43

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi %struct.s1* [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !43
  %5 = bitcast %struct.s1* %t1 to i8*, !dbg !43
  %6 = bitcast %struct.s1* %vaarg.addr to i8*, !dbg !43
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 16, i32 8, i1 false), !dbg !43
  call void @llvm.dbg.declare(metadata %struct.s1* %nt1, metadata !44, metadata !12), !dbg !45
  %a2 = getelementptr inbounds %struct.va, %struct.va* %va_lists, i32 0, i32 1, !dbg !46
  %arraydecay4 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %a2, i32 0, i32 0, !dbg !46
  %gp_offset_p5 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay4, i32 0, i32 0, !dbg !46
  %gp_offset6 = load i32, i32* %gp_offset_p5, align 8, !dbg !46
  %fits_in_gp7 = icmp ule i32 %gp_offset6, 32, !dbg !46
  br i1 %fits_in_gp7, label %vaarg.in_reg8, label %vaarg.in_mem10, !dbg !46

vaarg.in_reg8:                                    ; preds = %vaarg.end
  %7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay4, i32 0, i32 3, !dbg !46
  %reg_save_area9 = load i8*, i8** %7, align 8, !dbg !46
  %8 = getelementptr i8, i8* %reg_save_area9, i32 %gp_offset6, !dbg !46
  %9 = bitcast i8* %8 to %struct.s1*, !dbg !46
  %10 = add i32 %gp_offset6, 16, !dbg !46
  store i32 %10, i32* %gp_offset_p5, align 8, !dbg !46
  br label %vaarg.end14, !dbg !46

vaarg.in_mem10:                                   ; preds = %vaarg.end
  %overflow_arg_area_p11 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay4, i32 0, i32 2, !dbg !46
  %overflow_arg_area12 = load i8*, i8** %overflow_arg_area_p11, align 8, !dbg !46
  %11 = bitcast i8* %overflow_arg_area12 to %struct.s1*, !dbg !46
  %overflow_arg_area.next13 = getelementptr i8, i8* %overflow_arg_area12, i32 16, !dbg !46
  store i8* %overflow_arg_area.next13, i8** %overflow_arg_area_p11, align 8, !dbg !46
  br label %vaarg.end14, !dbg !46

vaarg.end14:                                      ; preds = %vaarg.in_mem10, %vaarg.in_reg8
  %vaarg.addr15 = phi %struct.s1* [ %9, %vaarg.in_reg8 ], [ %11, %vaarg.in_mem10 ], !dbg !46
  %12 = bitcast %struct.s1* %nt1 to i8*, !dbg !46
  %13 = bitcast %struct.s1* %vaarg.addr15 to i8*, !dbg !46
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* %13, i64 16, i32 8, i1 false), !dbg !46
  %a116 = getelementptr inbounds %struct.va, %struct.va* %va_lists, i32 0, i32 0, !dbg !47
  %arraydecay17 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %a116, i32 0, i32 0, !dbg !47
  %arraydecay1718 = bitcast %struct.__va_list_tag* %arraydecay17 to i8*, !dbg !47
  call void @llvm.va_end(i8* %arraydecay1718), !dbg !47
  ret i32 0, !dbg !48
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !49 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !52, metadata !12), !dbg !53
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !54
  %t = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !55
  store i8* %call, i8** %t, align 8, !dbg !56
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !57
  %0 = bitcast %struct.s1* %s to { i32, i8* }*, !dbg !58
  %1 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 0, !dbg !58
  %2 = load i32, i32* %1, align 8, !dbg !58
  %3 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 1, !dbg !58
  %4 = load i8*, i8** %3, align 8, !dbg !58
  %call2 = call i32 (i32, ...) @foo(i32 1, i32 %2, i8* %4, i8* %call1), !dbg !58
  ret i32 0, !dbg !59
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-26")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 17, type: !8, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, null}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 17, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 17, column: 9, scope: !7)
!14 = !DILocalVariable(name: "va_lists", scope: !7, file: !1, line: 19, type: !15)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "va", file: !1, line: 6, size: 384, elements: !16)
!16 = !{!17, !32}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "a1", scope: !15, file: !1, line: 7, baseType: !18, size: 192)
!18 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !19, line: 30, baseType: !20)
!19 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-26")
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 19, baseType: !21)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 192, elements: !30)
!22 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 19, size: 192, elements: !23)
!23 = !{!24, !26, !27, !29}
!24 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !22, file: !1, line: 19, baseType: !25, size: 32)
!25 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !22, file: !1, line: 19, baseType: !25, size: 32, offset: 32)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !22, file: !1, line: 19, baseType: !28, size: 64, offset: 64)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !22, file: !1, line: 19, baseType: !28, size: 64, offset: 128)
!30 = !{!31}
!31 = !DISubrange(count: 1)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "a2", scope: !15, file: !1, line: 8, baseType: !18, size: 192, offset: 192)
!33 = !DILocation(line: 19, column: 15, scope: !7)
!34 = !DILocation(line: 21, column: 5, scope: !7)
!35 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 23, type: !36)
!36 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 11, size: 128, elements: !37)
!37 = !{!38, !39}
!38 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !36, file: !1, line: 12, baseType: !10, size: 32)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !36, file: !1, line: 13, baseType: !40, size: 64, offset: 64)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!41 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!42 = !DILocation(line: 23, column: 15, scope: !7)
!43 = !DILocation(line: 23, column: 20, scope: !7)
!44 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 25, type: !36)
!45 = !DILocation(line: 25, column: 15, scope: !7)
!46 = !DILocation(line: 25, column: 21, scope: !7)
!47 = !DILocation(line: 27, column: 5, scope: !7)
!48 = !DILocation(line: 29, column: 5, scope: !7)
!49 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 33, type: !50, isLocal: false, isDefinition: true, scopeLine: 34, isOptimized: false, unit: !0, variables: !2)
!50 = !DISubroutineType(types: !51)
!51 = !{!10}
!52 = !DILocalVariable(name: "s", scope: !49, file: !1, line: 35, type: !36)
!53 = !DILocation(line: 35, column: 15, scope: !49)
!54 = !DILocation(line: 36, column: 11, scope: !49)
!55 = !DILocation(line: 36, column: 7, scope: !49)
!56 = !DILocation(line: 36, column: 9, scope: !49)
!57 = !DILocation(line: 38, column: 15, scope: !49)
!58 = !DILocation(line: 38, column: 5, scope: !49)
!59 = !DILocation(line: 40, column: 5, scope: !49)
