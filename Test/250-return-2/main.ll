; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i8* @foo() #0 !dbg !9 {
entry:
  %retval = alloca %struct.s1, align 8
  %a = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %t = alloca i8*, align 8
  call void @llvm.dbg.declare(metadata i32* %a, metadata !17, metadata !19), !dbg !20
  store i32 0, i32* %a, align 4, !dbg !20
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !21, metadata !19), !dbg !22
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !23
  %t1 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !24
  store i8* %call, i8** %t1, align 8, !dbg !25
  %0 = load i32, i32* %a, align 4, !dbg !26
  %tobool = icmp ne i32 %0, 0, !dbg !26
  br i1 %tobool, label %if.then, label %if.end, !dbg !28

if.then:                                          ; preds = %entry
  %1 = bitcast %struct.s1* %retval to i8*, !dbg !29
  %2 = bitcast %struct.s1* %s1 to i8*, !dbg !29
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %2, i64 8, i32 8, i1 false), !dbg !29
  br label %return, !dbg !31

if.end:                                           ; preds = %entry
  call void @llvm.dbg.declare(metadata i8** %t, metadata !32, metadata !19), !dbg !33
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !34
  store i8* %call1, i8** %t, align 8, !dbg !33
  %3 = load i8*, i8** %t, align 8, !dbg !35
  %cmp = icmp ne i8* %3, null, !dbg !37
  br i1 %cmp, label %if.then2, label %if.end3, !dbg !38

if.then2:                                         ; preds = %if.end
  %4 = bitcast %struct.s1* %retval to i8*, !dbg !39
  %5 = bitcast %struct.s1* %s1 to i8*, !dbg !39
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %4, i8* %5, i64 8, i32 8, i1 false), !dbg !39
  br label %return, !dbg !41

if.end3:                                          ; preds = %if.end
  %6 = bitcast %struct.s1* %retval to i8*, !dbg !42
  %7 = bitcast %struct.s1* %s1 to i8*, !dbg !42
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* %7, i64 8, i32 8, i1 false), !dbg !42
  br label %return, !dbg !43

return:                                           ; preds = %if.end3, %if.then2, %if.then
  %coerce.dive = getelementptr inbounds %struct.s1, %struct.s1* %retval, i32 0, i32 0, !dbg !44
  %8 = load i8*, i8** %coerce.dive, align 8, !dbg !44
  ret i8* %8, !dbg !44
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !45 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !48, metadata !19), !dbg !49
  %call = call i8* @foo(), !dbg !50
  %coerce.dive = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 0, !dbg !50
  store i8* %call, i8** %coerce.dive, align 8, !dbg !50
  ret i32 -1, !dbg !51
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/250-return-2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!9 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 10, type: !10, isLocal: false, isDefinition: true, scopeLine: 10, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 5, size: 64, elements: !13)
!13 = !{!14}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !12, file: !1, line: 6, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 11, type: !18)
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DIExpression()
!20 = !DILocation(line: 11, column: 9, scope: !9)
!21 = !DILocalVariable(name: "s1", scope: !9, file: !1, line: 12, type: !12)
!22 = !DILocation(line: 12, column: 15, scope: !9)
!23 = !DILocation(line: 13, column: 13, scope: !9)
!24 = !DILocation(line: 13, column: 8, scope: !9)
!25 = !DILocation(line: 13, column: 11, scope: !9)
!26 = !DILocation(line: 15, column: 9, scope: !27)
!27 = distinct !DILexicalBlock(scope: !9, file: !1, line: 15, column: 9)
!28 = !DILocation(line: 15, column: 9, scope: !9)
!29 = !DILocation(line: 16, column: 16, scope: !30)
!30 = distinct !DILexicalBlock(scope: !27, file: !1, line: 15, column: 12)
!31 = !DILocation(line: 16, column: 9, scope: !30)
!32 = !DILocalVariable(name: "t", scope: !9, file: !1, line: 19, type: !15)
!33 = !DILocation(line: 19, column: 11, scope: !9)
!34 = !DILocation(line: 19, column: 15, scope: !9)
!35 = !DILocation(line: 20, column: 9, scope: !36)
!36 = distinct !DILexicalBlock(scope: !9, file: !1, line: 20, column: 9)
!37 = !DILocation(line: 20, column: 11, scope: !36)
!38 = !DILocation(line: 20, column: 9, scope: !9)
!39 = !DILocation(line: 21, column: 16, scope: !40)
!40 = distinct !DILexicalBlock(scope: !36, file: !1, line: 20, column: 20)
!41 = !DILocation(line: 21, column: 9, scope: !40)
!42 = !DILocation(line: 24, column: 12, scope: !9)
!43 = !DILocation(line: 24, column: 5, scope: !9)
!44 = !DILocation(line: 25, column: 1, scope: !9)
!45 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 28, type: !46, isLocal: false, isDefinition: true, scopeLine: 28, isOptimized: false, unit: !0, variables: !2)
!46 = !DISubroutineType(types: !47)
!47 = !{!18}
!48 = !DILocalVariable(name: "s", scope: !45, file: !1, line: 29, type: !12)
!49 = !DILocation(line: 29, column: 15, scope: !45)
!50 = !DILocation(line: 29, column: 19, scope: !45)
!51 = !DILocation(line: 31, column: 5, scope: !45)
