; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"hi\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %tainted = alloca i8*, align 8
  %t = alloca [3 x i8], align 1
  %also_tainted = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !11, metadata !14), !dbg !15
  %call = call i8* @getenv(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !16
  store i8* %call, i8** %tainted, align 8, !dbg !15
  call void @llvm.dbg.declare(metadata [3 x i8]* %t, metadata !17, metadata !14), !dbg !21
  %arraydecay = getelementptr inbounds [3 x i8], [3 x i8]* %t, i32 0, i32 0, !dbg !22
  %0 = load i8*, i8** %tainted, align 8, !dbg !23
  call void @llvm.memmove.p0i8.p0i8.i64(i8* %arraydecay, i8* %0, i64 3, i32 1, i1 false), !dbg !22
  call void @llvm.dbg.declare(metadata i8** %also_tainted, metadata !24, metadata !14), !dbg !25
  %arraydecay1 = getelementptr inbounds [3 x i8], [3 x i8]* %t, i32 0, i32 0, !dbg !26
  store i8* %arraydecay1, i8** %also_tainted, align 8, !dbg !25
  ret i32 0, !dbg !27
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/131-memmove-1")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !8, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 10, type: !12)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!14 = !DIExpression()
!15 = !DILocation(line: 10, column: 11, scope: !7)
!16 = !DILocation(line: 10, column: 21, scope: !7)
!17 = !DILocalVariable(name: "t", scope: !7, file: !1, line: 11, type: !18)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 24, elements: !19)
!19 = !{!20}
!20 = !DISubrange(count: 3)
!21 = !DILocation(line: 11, column: 10, scope: !7)
!22 = !DILocation(line: 13, column: 5, scope: !7)
!23 = !DILocation(line: 13, column: 16, scope: !7)
!24 = !DILocalVariable(name: "also_tainted", scope: !7, file: !1, line: 15, type: !12)
!25 = !DILocation(line: 15, column: 11, scope: !7)
!26 = !DILocation(line: 15, column: 26, scope: !7)
!27 = !DILocation(line: 17, column: 5, scope: !7)
