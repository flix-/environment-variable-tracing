; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %n, ...) #0 !dbg !9 {
entry:
  %n.addr = alloca i32, align 4
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %t1 = alloca i32, align 4
  %t2 = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %ap, metadata !16, metadata !14), !dbg !30
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !31
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !31
  call void @llvm.va_start(i8* %arraydecay1), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %t1, metadata !32, metadata !14), !dbg !33
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !34
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !34
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !34
  %fits_in_gp = icmp ule i32 %gp_offset, 40, !dbg !34
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !34

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !34
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !34
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !34
  %2 = bitcast i8* %1 to i32*, !dbg !34
  %3 = add i32 %gp_offset, 8, !dbg !34
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !34
  br label %vaarg.end, !dbg !34

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !34
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !34
  %4 = bitcast i8* %overflow_arg_area to i32*, !dbg !34
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 8, !dbg !34
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !34
  br label %vaarg.end, !dbg !34

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i32* [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !34
  %5 = load i32, i32* %vaarg.addr, align 4, !dbg !34
  store i32 %5, i32* %t1, align 4, !dbg !33
  call void @llvm.dbg.declare(metadata i32* %t2, metadata !35, metadata !14), !dbg !36
  %6 = load i32, i32* %t1, align 4, !dbg !37
  store i32 %6, i32* %t2, align 4, !dbg !36
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0, !dbg !38
  %arraydecay34 = bitcast %struct.__va_list_tag* %arraydecay3 to i8*, !dbg !38
  call void @llvm.va_end(i8* %arraydecay34), !dbg !38
  ret void, !dbg !39
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !40 {
entry:
  %retval = alloca i32, align 4
  %t = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %t, metadata !43, metadata !14), !dbg !44
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !45
  %cmp = icmp ne i8* %call, null, !dbg !46
  %0 = zext i1 %cmp to i64, !dbg !45
  %cond = select i1 %cmp, i32 1, i32 0, !dbg !45
  store i32 %cond, i32* %t, align 4, !dbg !44
  %1 = load i32, i32* %t, align 4, !dbg !47
  %add = add nsw i32 %1, 1, !dbg !48
  call void (i32, ...) @foo(i32 1, i32 %add), !dbg !49
  ret i32 0, !dbg !50
}

; Function Attrs: nounwind
declare i8* @getenv(i8*) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-12")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 7, type: !10, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12, null}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "n", arg: 1, scope: !9, file: !1, line: 7, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 7, column: 9, scope: !9)
!16 = !DILocalVariable(name: "ap", scope: !9, file: !1, line: 9, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !18, line: 30, baseType: !19)
!18 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-12")
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1, line: 9, baseType: !20)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 192, elements: !28)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !1, line: 9, size: 192, elements: !22)
!22 = !{!23, !25, !26, !27}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !21, file: !1, line: 9, baseType: !24, size: 32)
!24 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !21, file: !1, line: 9, baseType: !24, size: 32, offset: 32)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !21, file: !1, line: 9, baseType: !4, size: 64, offset: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !21, file: !1, line: 9, baseType: !4, size: 64, offset: 128)
!28 = !{!29}
!29 = !DISubrange(count: 1)
!30 = !DILocation(line: 9, column: 13, scope: !9)
!31 = !DILocation(line: 10, column: 5, scope: !9)
!32 = !DILocalVariable(name: "t1", scope: !9, file: !1, line: 12, type: !12)
!33 = !DILocation(line: 12, column: 9, scope: !9)
!34 = !DILocation(line: 12, column: 14, scope: !9)
!35 = !DILocalVariable(name: "t2", scope: !9, file: !1, line: 14, type: !12)
!36 = !DILocation(line: 14, column: 9, scope: !9)
!37 = !DILocation(line: 14, column: 14, scope: !9)
!38 = !DILocation(line: 16, column: 5, scope: !9)
!39 = !DILocation(line: 17, column: 1, scope: !9)
!40 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !41, isLocal: false, isDefinition: true, scopeLine: 21, isOptimized: false, unit: !0, variables: !2)
!41 = !DISubroutineType(types: !42)
!42 = !{!12}
!43 = !DILocalVariable(name: "t", scope: !40, file: !1, line: 22, type: !12)
!44 = !DILocation(line: 22, column: 9, scope: !40)
!45 = !DILocation(line: 22, column: 13, scope: !40)
!46 = !DILocation(line: 22, column: 28, scope: !40)
!47 = !DILocation(line: 24, column: 12, scope: !40)
!48 = !DILocation(line: 24, column: 14, scope: !40)
!49 = !DILocation(line: 24, column: 5, scope: !40)
!50 = !DILocation(line: 26, column: 5, scope: !40)
