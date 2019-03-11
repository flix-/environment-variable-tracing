; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@str = common global [1024 x i8*] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !15 {
entry:
  %retval = alloca i32, align 4
  %strl = alloca [1024 x i8*], align 16
  %t1 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [1024 x i8*]* %strl, metadata !19, metadata !20), !dbg !21
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !22
  %arrayidx = getelementptr inbounds [1024 x i8*], [1024 x i8*]* %strl, i64 0, i64 100, !dbg !23
  store i8* %call, i8** %arrayidx, align 16, !dbg !24
  %arraydecay = getelementptr inbounds [1024 x i8*], [1024 x i8*]* %strl, i32 0, i32 0, !dbg !25
  %0 = bitcast i8** %arraydecay to i8*, !dbg !25
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast ([1024 x i8*]* @str to i8*), i8* %0, i64 1024, i32 16, i1 false), !dbg !25
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !26, metadata !20), !dbg !27
  %1 = load i8*, i8** getelementptr inbounds ([1024 x i8*], [1024 x i8*]* @str, i64 0, i64 100), align 16, !dbg !28
  store i8* %1, i8** %t1, align 8, !dbg !27
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !29, metadata !20), !dbg !30
  %2 = load i8*, i8** getelementptr inbounds ([1024 x i8*], [1024 x i8*]* @str, i64 0, i64 99), align 8, !dbg !31
  store i8* %2, i8** %ut1, align 8, !dbg !30
  ret i32 0, !dbg !32
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!11, !12, !13}
!llvm.ident = !{!14}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "str", scope: !2, file: !3, line: 7, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/260-globals-13")
!4 = !{}
!5 = !{!0}
!6 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 65536, elements: !9)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!9 = !{!10}
!10 = !DISubrange(count: 1024)
!11 = !{i32 2, !"Dwarf Version", i32 4}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{i32 1, !"wchar_size", i32 4}
!14 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!15 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 10, type: !16, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !2, variables: !4)
!16 = !DISubroutineType(types: !17)
!17 = !{!18}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DILocalVariable(name: "strl", scope: !15, file: !3, line: 12, type: !6)
!20 = !DIExpression()
!21 = !DILocation(line: 12, column: 11, scope: !15)
!22 = !DILocation(line: 13, column: 17, scope: !15)
!23 = !DILocation(line: 13, column: 5, scope: !15)
!24 = !DILocation(line: 13, column: 15, scope: !15)
!25 = !DILocation(line: 15, column: 5, scope: !15)
!26 = !DILocalVariable(name: "t1", scope: !15, file: !3, line: 17, type: !7)
!27 = !DILocation(line: 17, column: 11, scope: !15)
!28 = !DILocation(line: 17, column: 16, scope: !15)
!29 = !DILocalVariable(name: "ut1", scope: !15, file: !3, line: 18, type: !7)
!30 = !DILocation(line: 18, column: 11, scope: !15)
!31 = !DILocation(line: 18, column: 17, scope: !15)
!32 = !DILocation(line: 20, column: 5, scope: !15)
