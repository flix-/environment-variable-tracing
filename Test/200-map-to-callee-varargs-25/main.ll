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
  %nt1 = alloca %struct.s1, align 8
  %nt2 = alloca i8*, align 8
  %nt12 = alloca %struct.s1, align 8
  %nt22 = alloca i8*, align 8
  %s11 = alloca %struct.s1, align 8
  %t1 = alloca i8*, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %args1, metadata !14, metadata !12), !dbg !29
  call void @llvm.dbg.declare(metadata [1 x %struct.__va_list_tag]* %args2, metadata !30, metadata !12), !dbg !31
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !32
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*, !dbg !32
  call void @llvm.va_start(i8* %arraydecay1), !dbg !32
  call void @llvm.dbg.declare(metadata %struct.s1* %nt1, metadata !33, metadata !12), !dbg !40
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !41
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 0, !dbg !41
  %gp_offset = load i32, i32* %gp_offset_p, align 16, !dbg !41
  %fits_in_gp = icmp ule i32 %gp_offset, 32, !dbg !41
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem, !dbg !41

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 3, !dbg !41
  %reg_save_area = load i8*, i8** %0, align 16, !dbg !41
  %1 = getelementptr i8, i8* %reg_save_area, i32 %gp_offset, !dbg !41
  %2 = bitcast i8* %1 to %struct.s1*, !dbg !41
  %3 = add i32 %gp_offset, 16, !dbg !41
  store i32 %3, i32* %gp_offset_p, align 16, !dbg !41
  br label %vaarg.end, !dbg !41

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay2, i32 0, i32 2, !dbg !41
  %overflow_arg_area = load i8*, i8** %overflow_arg_area_p, align 8, !dbg !41
  %4 = bitcast i8* %overflow_arg_area to %struct.s1*, !dbg !41
  %overflow_arg_area.next = getelementptr i8, i8* %overflow_arg_area, i32 16, !dbg !41
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8, !dbg !41
  br label %vaarg.end, !dbg !41

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi %struct.s1* [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ], !dbg !41
  %5 = bitcast %struct.s1* %nt1 to i8*, !dbg !41
  %6 = bitcast %struct.s1* %vaarg.addr to i8*, !dbg !41
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 16, i32 8, i1 false), !dbg !41
  call void @llvm.dbg.declare(metadata i8** %nt2, metadata !42, metadata !12), !dbg !43
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !44
  %gp_offset_p4 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 0, !dbg !44
  %gp_offset5 = load i32, i32* %gp_offset_p4, align 16, !dbg !44
  %fits_in_gp6 = icmp ule i32 %gp_offset5, 40, !dbg !44
  br i1 %fits_in_gp6, label %vaarg.in_reg7, label %vaarg.in_mem9, !dbg !44

vaarg.in_reg7:                                    ; preds = %vaarg.end
  %7 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 3, !dbg !44
  %reg_save_area8 = load i8*, i8** %7, align 16, !dbg !44
  %8 = getelementptr i8, i8* %reg_save_area8, i32 %gp_offset5, !dbg !44
  %9 = bitcast i8* %8 to i8**, !dbg !44
  %10 = add i32 %gp_offset5, 8, !dbg !44
  store i32 %10, i32* %gp_offset_p4, align 16, !dbg !44
  br label %vaarg.end13, !dbg !44

vaarg.in_mem9:                                    ; preds = %vaarg.end
  %overflow_arg_area_p10 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay3, i32 0, i32 2, !dbg !44
  %overflow_arg_area11 = load i8*, i8** %overflow_arg_area_p10, align 8, !dbg !44
  %11 = bitcast i8* %overflow_arg_area11 to i8**, !dbg !44
  %overflow_arg_area.next12 = getelementptr i8, i8* %overflow_arg_area11, i32 8, !dbg !44
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10, align 8, !dbg !44
  br label %vaarg.end13, !dbg !44

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %vaarg.addr14 = phi i8** [ %9, %vaarg.in_reg7 ], [ %11, %vaarg.in_mem9 ], !dbg !44
  %12 = load i8*, i8** %vaarg.addr14, align 8, !dbg !44
  store i8* %12, i8** %nt2, align 8, !dbg !43
  %arraydecay15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !45
  %arraydecay1516 = bitcast %struct.__va_list_tag* %arraydecay15 to i8*, !dbg !45
  call void @llvm.va_end(i8* %arraydecay1516), !dbg !45
  call void @llvm.dbg.declare(metadata %struct.s1* %nt12, metadata !46, metadata !12), !dbg !47
  %arraydecay17 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !48
  %gp_offset_p18 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay17, i32 0, i32 0, !dbg !48
  %gp_offset19 = load i32, i32* %gp_offset_p18, align 16, !dbg !48
  %fits_in_gp20 = icmp ule i32 %gp_offset19, 32, !dbg !48
  br i1 %fits_in_gp20, label %vaarg.in_reg21, label %vaarg.in_mem23, !dbg !48

vaarg.in_reg21:                                   ; preds = %vaarg.end13
  %13 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay17, i32 0, i32 3, !dbg !48
  %reg_save_area22 = load i8*, i8** %13, align 16, !dbg !48
  %14 = getelementptr i8, i8* %reg_save_area22, i32 %gp_offset19, !dbg !48
  %15 = bitcast i8* %14 to %struct.s1*, !dbg !48
  %16 = add i32 %gp_offset19, 16, !dbg !48
  store i32 %16, i32* %gp_offset_p18, align 16, !dbg !48
  br label %vaarg.end27, !dbg !48

vaarg.in_mem23:                                   ; preds = %vaarg.end13
  %overflow_arg_area_p24 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay17, i32 0, i32 2, !dbg !48
  %overflow_arg_area25 = load i8*, i8** %overflow_arg_area_p24, align 8, !dbg !48
  %17 = bitcast i8* %overflow_arg_area25 to %struct.s1*, !dbg !48
  %overflow_arg_area.next26 = getelementptr i8, i8* %overflow_arg_area25, i32 16, !dbg !48
  store i8* %overflow_arg_area.next26, i8** %overflow_arg_area_p24, align 8, !dbg !48
  br label %vaarg.end27, !dbg !48

vaarg.end27:                                      ; preds = %vaarg.in_mem23, %vaarg.in_reg21
  %vaarg.addr28 = phi %struct.s1* [ %15, %vaarg.in_reg21 ], [ %17, %vaarg.in_mem23 ], !dbg !48
  %18 = bitcast %struct.s1* %nt12 to i8*, !dbg !48
  %19 = bitcast %struct.s1* %vaarg.addr28 to i8*, !dbg !48
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 16, i32 8, i1 false), !dbg !48
  call void @llvm.dbg.declare(metadata i8** %nt22, metadata !49, metadata !12), !dbg !50
  %arraydecay29 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args1, i32 0, i32 0, !dbg !51
  %gp_offset_p30 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay29, i32 0, i32 0, !dbg !51
  %gp_offset31 = load i32, i32* %gp_offset_p30, align 16, !dbg !51
  %fits_in_gp32 = icmp ule i32 %gp_offset31, 40, !dbg !51
  br i1 %fits_in_gp32, label %vaarg.in_reg33, label %vaarg.in_mem35, !dbg !51

vaarg.in_reg33:                                   ; preds = %vaarg.end27
  %20 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay29, i32 0, i32 3, !dbg !51
  %reg_save_area34 = load i8*, i8** %20, align 16, !dbg !51
  %21 = getelementptr i8, i8* %reg_save_area34, i32 %gp_offset31, !dbg !51
  %22 = bitcast i8* %21 to i8**, !dbg !51
  %23 = add i32 %gp_offset31, 8, !dbg !51
  store i32 %23, i32* %gp_offset_p30, align 16, !dbg !51
  br label %vaarg.end39, !dbg !51

vaarg.in_mem35:                                   ; preds = %vaarg.end27
  %overflow_arg_area_p36 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay29, i32 0, i32 2, !dbg !51
  %overflow_arg_area37 = load i8*, i8** %overflow_arg_area_p36, align 8, !dbg !51
  %24 = bitcast i8* %overflow_arg_area37 to i8**, !dbg !51
  %overflow_arg_area.next38 = getelementptr i8, i8* %overflow_arg_area37, i32 8, !dbg !51
  store i8* %overflow_arg_area.next38, i8** %overflow_arg_area_p36, align 8, !dbg !51
  br label %vaarg.end39, !dbg !51

vaarg.end39:                                      ; preds = %vaarg.in_mem35, %vaarg.in_reg33
  %vaarg.addr40 = phi i8** [ %22, %vaarg.in_reg33 ], [ %24, %vaarg.in_mem35 ], !dbg !51
  %25 = load i8*, i8** %vaarg.addr40, align 8, !dbg !51
  store i8* %25, i8** %nt22, align 8, !dbg !50
  call void @llvm.dbg.declare(metadata %struct.s1* %s11, metadata !52, metadata !12), !dbg !53
  %arraydecay41 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !54
  %gp_offset_p42 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 0, !dbg !54
  %gp_offset43 = load i32, i32* %gp_offset_p42, align 16, !dbg !54
  %fits_in_gp44 = icmp ule i32 %gp_offset43, 32, !dbg !54
  br i1 %fits_in_gp44, label %vaarg.in_reg45, label %vaarg.in_mem47, !dbg !54

vaarg.in_reg45:                                   ; preds = %vaarg.end39
  %26 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 3, !dbg !54
  %reg_save_area46 = load i8*, i8** %26, align 16, !dbg !54
  %27 = getelementptr i8, i8* %reg_save_area46, i32 %gp_offset43, !dbg !54
  %28 = bitcast i8* %27 to %struct.s1*, !dbg !54
  %29 = add i32 %gp_offset43, 16, !dbg !54
  store i32 %29, i32* %gp_offset_p42, align 16, !dbg !54
  br label %vaarg.end51, !dbg !54

vaarg.in_mem47:                                   ; preds = %vaarg.end39
  %overflow_arg_area_p48 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay41, i32 0, i32 2, !dbg !54
  %overflow_arg_area49 = load i8*, i8** %overflow_arg_area_p48, align 8, !dbg !54
  %30 = bitcast i8* %overflow_arg_area49 to %struct.s1*, !dbg !54
  %overflow_arg_area.next50 = getelementptr i8, i8* %overflow_arg_area49, i32 16, !dbg !54
  store i8* %overflow_arg_area.next50, i8** %overflow_arg_area_p48, align 8, !dbg !54
  br label %vaarg.end51, !dbg !54

vaarg.end51:                                      ; preds = %vaarg.in_mem47, %vaarg.in_reg45
  %vaarg.addr52 = phi %struct.s1* [ %28, %vaarg.in_reg45 ], [ %30, %vaarg.in_mem47 ], !dbg !54
  %31 = bitcast %struct.s1* %s11 to i8*, !dbg !54
  %32 = bitcast %struct.s1* %vaarg.addr52 to i8*, !dbg !54
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %31, i8* %32, i64 16, i32 8, i1 false), !dbg !54
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !55, metadata !12), !dbg !56
  %arraydecay53 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !57
  %gp_offset_p54 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay53, i32 0, i32 0, !dbg !57
  %gp_offset55 = load i32, i32* %gp_offset_p54, align 16, !dbg !57
  %fits_in_gp56 = icmp ule i32 %gp_offset55, 40, !dbg !57
  br i1 %fits_in_gp56, label %vaarg.in_reg57, label %vaarg.in_mem59, !dbg !57

vaarg.in_reg57:                                   ; preds = %vaarg.end51
  %33 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay53, i32 0, i32 3, !dbg !57
  %reg_save_area58 = load i8*, i8** %33, align 16, !dbg !57
  %34 = getelementptr i8, i8* %reg_save_area58, i32 %gp_offset55, !dbg !57
  %35 = bitcast i8* %34 to i8**, !dbg !57
  %36 = add i32 %gp_offset55, 8, !dbg !57
  store i32 %36, i32* %gp_offset_p54, align 16, !dbg !57
  br label %vaarg.end63, !dbg !57

vaarg.in_mem59:                                   ; preds = %vaarg.end51
  %overflow_arg_area_p60 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %arraydecay53, i32 0, i32 2, !dbg !57
  %overflow_arg_area61 = load i8*, i8** %overflow_arg_area_p60, align 8, !dbg !57
  %37 = bitcast i8* %overflow_arg_area61 to i8**, !dbg !57
  %overflow_arg_area.next62 = getelementptr i8, i8* %overflow_arg_area61, i32 8, !dbg !57
  store i8* %overflow_arg_area.next62, i8** %overflow_arg_area_p60, align 8, !dbg !57
  br label %vaarg.end63, !dbg !57

vaarg.end63:                                      ; preds = %vaarg.in_mem59, %vaarg.in_reg57
  %vaarg.addr64 = phi i8** [ %35, %vaarg.in_reg57 ], [ %37, %vaarg.in_mem59 ], !dbg !57
  %38 = load i8*, i8** %vaarg.addr64, align 8, !dbg !57
  store i8* %38, i8** %t1, align 8, !dbg !56
  %arraydecay65 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %args2, i32 0, i32 0, !dbg !58
  %arraydecay6566 = bitcast %struct.__va_list_tag* %arraydecay65 to i8*, !dbg !58
  call void @llvm.va_end(i8* %arraydecay6566), !dbg !58
  ret i32 0, !dbg !59
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
define i32 @main() #0 !dbg !60 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !63, metadata !12), !dbg !64
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !65
  %t = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !66
  store i8* %call, i8** %t, align 8, !dbg !67
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #2, !dbg !68
  %0 = bitcast %struct.s1* %s to { i32, i8* }*, !dbg !69
  %1 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 0, !dbg !69
  %2 = load i32, i32* %1, align 8, !dbg !69
  %3 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %0, i32 0, i32 1, !dbg !69
  %4 = load i8*, i8** %3, align 8, !dbg !69
  %call2 = call i32 (i32, ...) @foo(i32 1, i32 %2, i8* %4, i8* %call1), !dbg !69
  ret i32 0, !dbg !70
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-25")
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
!16 = !DIFile(filename: "/home/sebastian/documents/programming/llvm/jail/llvm501-debug/lib/clang/5.0.1/include/stdarg.h", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/200-map-to-callee-varargs-25")
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
!30 = !DILocalVariable(name: "args2", scope: !7, file: !1, line: 16, type: !15)
!31 = !DILocation(line: 16, column: 13, scope: !7)
!32 = !DILocation(line: 17, column: 5, scope: !7)
!33 = !DILocalVariable(name: "nt1", scope: !7, file: !1, line: 19, type: !34)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 6, size: 128, elements: !35)
!35 = !{!36, !37}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !34, file: !1, line: 7, baseType: !10, size: 32)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !34, file: !1, line: 8, baseType: !38, size: 64, offset: 64)
!38 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !39, size: 64)
!39 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!40 = !DILocation(line: 19, column: 15, scope: !7)
!41 = !DILocation(line: 19, column: 21, scope: !7)
!42 = !DILocalVariable(name: "nt2", scope: !7, file: !1, line: 20, type: !38)
!43 = !DILocation(line: 20, column: 11, scope: !7)
!44 = !DILocation(line: 20, column: 17, scope: !7)
!45 = !DILocation(line: 21, column: 5, scope: !7)
!46 = !DILocalVariable(name: "nt12", scope: !7, file: !1, line: 23, type: !34)
!47 = !DILocation(line: 23, column: 15, scope: !7)
!48 = !DILocation(line: 23, column: 22, scope: !7)
!49 = !DILocalVariable(name: "nt22", scope: !7, file: !1, line: 24, type: !38)
!50 = !DILocation(line: 24, column: 11, scope: !7)
!51 = !DILocation(line: 24, column: 18, scope: !7)
!52 = !DILocalVariable(name: "s11", scope: !7, file: !1, line: 26, type: !34)
!53 = !DILocation(line: 26, column: 15, scope: !7)
!54 = !DILocation(line: 26, column: 21, scope: !7)
!55 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 27, type: !38)
!56 = !DILocation(line: 27, column: 11, scope: !7)
!57 = !DILocation(line: 27, column: 16, scope: !7)
!58 = !DILocation(line: 29, column: 5, scope: !7)
!59 = !DILocation(line: 31, column: 5, scope: !7)
!60 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 35, type: !61, isLocal: false, isDefinition: true, scopeLine: 36, isOptimized: false, unit: !0, variables: !2)
!61 = !DISubroutineType(types: !62)
!62 = !{!10}
!63 = !DILocalVariable(name: "s", scope: !60, file: !1, line: 37, type: !34)
!64 = !DILocation(line: 37, column: 15, scope: !60)
!65 = !DILocation(line: 38, column: 11, scope: !60)
!66 = !DILocation(line: 38, column: 7, scope: !60)
!67 = !DILocation(line: 38, column: 9, scope: !60)
!68 = !DILocation(line: 40, column: 15, scope: !60)
!69 = !DILocation(line: 40, column: 5, scope: !60)
!70 = !DILocation(line: 42, column: 5, scope: !60)
