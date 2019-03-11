; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s1 = type { i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %n, ...) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %args1 = alloca [1 x %struct.__va_list_tag], align 16
  %args2 = alloca [1 x %struct.__va_list_tag], align 16
  %s2n = alloca %struct.s1, align 8
  %s2nn = alloca %struct.s1, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %args1, metadata !14, metadata !12), !dbg !29
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !30
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !30
  call void @llvm.va_start(i8* %arraydecay1), !dbg !30
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %args2, metadata !31, metadata !12), !dbg !32
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !33
  %arraydecay23 = bitcast %struct.__va_list_tag* %arraydecay2 to i8*, !dbg !33
  call void @llvm.va_start(i8* %arraydecay23), !dbg !33
  %arraydecay4 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !34
  %arraydecay45 = bitcast %struct.__va_list_tag* %arraydecay4 to i8*, !dbg !34
  call void @llvm.va_end(i8* %arraydecay45), !dbg !34
  %arraydecay6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !35
  %arraydecay67 = bitcast %struct.__va_list_tag* %arraydecay6 to i8*, !dbg !35
  call void @llvm.va_end(i8* %arraydecay67), !dbg !35
  call void @llvm.dbg.declare(metadata %struct.s1* %s2n, metadata !36, metadata !12), !dbg !43
  %arraydecay8 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !44
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay8, i32 0, i32 0, !dbg !44
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !44
  %fits_in_gp = icmp ule i32 %gp_offset, 32, !dbg !44
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !44

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay8, i32 0, i32 3, !dbg !44
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !44
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !44
  %2 = bitcast i8* %1 to %struct.s1*, !dbg !44
  %3 = add i32 %gp_offset, 16, !dbg !44
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !44
  br label %vaarg.end, !dbg !44

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay8, i32 0, i32 2, !dbg !44
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !44
  %4 = bitcast i8* %overflow_arg_area to %struct.s1*, !dbg !44
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 16, !dbg !44
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !44
  br label %vaarg.end, !dbg !44

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi %struct.s1* [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !44
  %5 = bitcast %struct.s1* %s2n to i8*, !dbg !44
  %6 = bitcast %struct.s1* %vaarg.addr to i8*, !dbg !44
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 16, i32 8, i1 false), !dbg !44
  call void @llvm.dbg.declare(metadata %struct.s1* %s2nn, metadata !45, metadata !12), !dbg !46
  %arraydecay9 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !47
  %gp_offset_p10 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay9, i32 0, i32 0, !dbg !47
  %gp_offset11 = load i32, i32* %gp_offset_p10, align 16, !dbg !47
  %fits_in_gp12 = icmp ule i32 %gp_offset11, 32, !dbg !47
  br i1 %fits_in_gp12, label %vaarg.in_reg13, label %vaarg.in_mem15, !dbg !47

vaarg.in_reg13:                                   ; preds = %vaarg.end
  %7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay9, i32 0, i32 3, !dbg !47
  %reg_save_area14 = load i8*, i8** %7, align 16, !dbg !47
  %8 = getelementptr i8, i8* %reg_save_area14, i32 %gp_offset11, !dbg !47
  %9 = bitcast i8* %8 to %struct.s1*, !dbg !47
  %10 = add i32 %gp_offset11, 16, !dbg !47
  store i32 %10, i32* %gp_offset_p10, align 16, !dbg !47
  br label %vaarg.end19, !dbg !47

vaarg.in_mem15:                                   ; preds = %vaarg.end
  %overflow_arg_area_p16 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay9, i32 0, i32 2, !dbg !47
  %overflow_arg_area17 = load i8*, i8** %overflow_arg_area_p16, align 8, !dbg !47
  %11 = bitcast i8* %overflow_arg_area17 to %struct.s1*, !dbg !47
  %overflow_arg_area.next18 = getelementptr i8, i8* %overflow_arg_area17, i32 16, !dbg !47
  store i8* %overflow_arg_area.next18, i8** %overflow_arg_area_p16, align 8, !dbg !47
  br label %vaarg.end19, !dbg !47

vaarg.end19:                                      ; preds = %vaarg.in_mem15, %vaarg.in_reg13
  %vaarg.addr20 = phi %struct.s1* [ %9, %vaarg.in_reg13 ], [ %11, %vaarg.in_mem15 ], !dbg !47
  %12 = bitcast %struct.s1* %s2nn to i8*, !dbg !47
  %13 = bitcast %struct.s1* %vaarg.addr20 to i8*, !dbg !47
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* %13, i64 16, i32 8, i1 false), !dbg !47
  ret i32 0, !dbg !48
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

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
  %0 = bitcast %struct.s1* %s to { i32, i8* }*, !dbg !57
  %1 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 0, !dbg !57
  %2 = load i32, i32* %1, align 8, !dbg !57
  %3 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 1, !dbg !57
  %4 = load i8*, i8** %3, align 8, !dbg !57
  %call1 = call i32 (i32, ...) @foo(i32 1, i32 %2, i8* %4), !dbg !57
  ret i32 0, !dbg !58
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-23")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 12, type: !8, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, null}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 12, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 12, column: 9, scope: !7)
!14 = !DILocalVariable(name: "args1", scope: !7, file: !1, line: 14, type: !15)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !16, line: 30, baseType: !17)
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-23")
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 14, baseType: !18)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 192, elements: !27)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 14, size: 192, elements: !20)
!20 = !{!21, !23, !24, !26}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !19, file: !1, line: 14, baseType: !22, size: 32)
!22 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !19, file: !1, line: 14, baseType: !22, size: 32, offset: 32)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !19, file: !1, line: 14, baseType: !25, size: 64, offset: 64)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !19, file: !1, line: 14, baseType: !25, size: 64, offset: 128)
!27 = !{!28}
!28 = !DISubrange(count: 1)
!29 = !DILocation(line: 14, column: 13, scope: !7)
!30 = !DILocation(line: 15, column: 5, scope: !7)
!31 = !DILocalVariable(name: "args2", scope: !7, file: !1, line: 17, type: !15)
!32 = !DILocation(line: 17, column: 13, scope: !7)
!33 = !DILocation(line: 18, column: 5, scope: !7)
!34 = !DILocation(line: 20, column: 5, scope: !7)
!35 = !DILocation(line: 21, column: 5, scope: !7)
!36 = !DILocalVariable(name: "s2n", scope: !7, file: !1, line: 23, type: !37)
!37 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 6, size: 128, elements: !38)
!38 = !{!39, !40}
!39 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !37, file: !1, line: 7, baseType: !10, size: 32)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !37, file: !1, line: 8, baseType: !41, size: 64, offset: 64)
!41 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !42, size: 64)
!42 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!43 = !DILocation(line: 23, column: 15, scope: !7)
!44 = !DILocation(line: 23, column: 21, scope: !7)
!45 = !DILocalVariable(name: "s2nn", scope: !7, file: !1, line: 24, type: !37)
!46 = !DILocation(line: 24, column: 15, scope: !7)
!47 = !DILocation(line: 24, column: 22, scope: !7)
!48 = !DILocation(line: 26, column: 5, scope: !7)
!49 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 30, type: !50, isLocal: false, isDefinition: true, scopeLine: 31, isOptimized: false, unit: !0, variables: !2)
!50 = !DISubroutineType(types: !51)
!51 = !{!10}
!52 = !DILocalVariable(name: "s", scope: !49, file: !1, line: 32, type: !37)
!53 = !DILocation(line: 32, column: 15, scope: !49)
!54 = !DILocation(line: 33, column: 11, scope: !49)
!55 = !DILocation(line: 33, column: 7, scope: !49)
!56 = !DILocation(line: 33, column: 9, scope: !49)
!57 = !DILocation(line: 35, column: 5, scope: !49)
!58 = !DILocation(line: 37, column: 5, scope: !49)
