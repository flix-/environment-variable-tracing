; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.s1 = type { i32, i32, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %n, ...) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %s1 = alloca %struct.s1, align 8
  %t1 = alloca i8*, align 8
  %ut1 = alloca i32, align 4
  %ut2 = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !14, metadata !12), !dbg !29
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !30
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !30
  call void @llvm.va_start(i8* %arraydecay1), !dbg !30
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !31, metadata !12), !dbg !39
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !40
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !40
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !40
  %fits_in_gp = icmp ule i32 %gp_offset, 32, !dbg !40
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !40

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !40
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !40
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !40
  %2 = bitcast i8* %1 to %struct.s1*, !dbg !40
  %3 = add i32 %gp_offset, 16, !dbg !40
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !40
  br label %vaarg.end, !dbg !40

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !40
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !40
  %4 = bitcast i8* %overflow_arg_area to %struct.s1*, !dbg !40
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 16, !dbg !40
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !40
  br label %vaarg.end, !dbg !40

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi %struct.s1* [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !40
  %5 = bitcast %struct.s1* %s1 to i8*, !dbg !40
  %6 = bitcast %struct.s1* %vaarg.addr to i8*, !dbg !40
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 16, i32 8, i1 false), !dbg !40
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !41, metadata !12), !dbg !42
  %t13 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !43
  %7 = load i8*, i8** %t13, align 8, !dbg !43
  store i8* %7, i8** %t1, align 8, !dbg !42
  call void @llvm.dbg.declare(metadata i32* %ut1, metadata !44, metadata !12), !dbg !45
  %a = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !46
  %8 = load i32, i32* %a, align 8, !dbg !46
  store i32 %8, i32* %ut1, align 4, !dbg !45
  call void @llvm.dbg.declare(metadata i32* %ut2, metadata !47, metadata !12), !dbg !48
  %b = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 1, !dbg !49
  %9 = load i32, i32* %b, align 4, !dbg !49
  store i32 %9, i32* %ut2, align 4, !dbg !48
  %arraydecay4 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !50
  %arraydecay45 = bitcast %struct.__va_list_tag* %arraydecay4 to i8*, !dbg !50
  call void @llvm.va_end(i8* %arraydecay45), !dbg !50
  ret void, !dbg !51
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
define i32 @main() #0 !dbg !52 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !55, metadata !12), !dbg !56
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !57
  %t1 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 2, !dbg !58
  store i8* %call, i8** %t1, align 8, !dbg !59
  %0 = bitcast %struct.s1* %s1 to { i64, i8* }*, !dbg !60
  %1 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 0, !dbg !60
  %2 = load i64, i64* %1, align 8, !dbg !60
  %3 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %0, i32 0, i32 1, !dbg !60
  %4 = load i8*, i8** %3, align 8, !dbg !60
  call void (i32, ...) @foo(i32 1, i64 %2, i8* %4), !dbg !60
  ret i32 0, !dbg !61
}

declare i8* @getenv(i8*) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { argmemonly nounwind }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-10")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 12, type: !8, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, null}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 12, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 12, column: 9, scope: !7)
!14 = !DILocalVariable(name: "ap", scope: !7, file: !1, line: 14, type: !15)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !16, line: 30, baseType: !17)
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-10")
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
!31 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 17, type: !32)
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 5, size: 128, elements: !33)
!33 = !{!34, !35, !36}
!34 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !32, file: !1, line: 6, baseType: !10, size: 32)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !32, file: !1, line: 7, baseType: !10, size: 32, offset: 32)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !32, file: !1, line: 8, baseType: !37, size: 64, offset: 64)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!39 = !DILocation(line: 17, column: 15, scope: !7)
!40 = !DILocation(line: 17, column: 20, scope: !7)
!41 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 19, type: !37)
!42 = !DILocation(line: 19, column: 11, scope: !7)
!43 = !DILocation(line: 19, column: 19, scope: !7)
!44 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 20, type: !10)
!45 = !DILocation(line: 20, column: 9, scope: !7)
!46 = !DILocation(line: 20, column: 18, scope: !7)
!47 = !DILocalVariable(name: "ut2", scope: !7, file: !1, line: 21, type: !10)
!48 = !DILocation(line: 21, column: 9, scope: !7)
!49 = !DILocation(line: 21, column: 18, scope: !7)
!50 = !DILocation(line: 23, column: 5, scope: !7)
!51 = !DILocation(line: 24, column: 1, scope: !7)
!52 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 27, type: !53, isLocal: false, isDefinition: true, scopeLine: 28, isOptimized: false, unit: !0, variables: !2)
!53 = !DISubroutineType(types: !54)
!54 = !{!10}
!55 = !DILocalVariable(name: "s1", scope: !52, file: !1, line: 29, type: !32)
!56 = !DILocation(line: 29, column: 15, scope: !52)
!57 = !DILocation(line: 30, column: 13, scope: !52)
!58 = !DILocation(line: 30, column: 8, scope: !52)
!59 = !DILocation(line: 30, column: 11, scope: !52)
!60 = !DILocation(line: 32, column: 5, scope: !52)
!61 = !DILocation(line: 34, column: 5, scope: !52)
