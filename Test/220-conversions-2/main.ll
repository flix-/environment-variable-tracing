; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, i32, i32 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %t = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !14, metadata !20), !dbg !21
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !22
  %t1 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !23
  store i8* %call, i8** %t1, align 8, !dbg !24
  call void @llvm.dbg.declare(metadata i8** %t, metadata !25, metadata !20), !dbg !26
  %0 = bitcast %struct.s1* %s1 to i8*, !dbg !27
  store i8* %0, i8** %t, align 8, !dbg !26
  ret i32 0, !dbg !28
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/220-conversions-2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!6 = !{i32 2, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 10, type: !11, isLocal: false, isDefinition: true, scopeLine: 10, isOptimized: false, unit: !0, variables: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DILocalVariable(name: "s1", scope: !10, file: !1, line: 11, type: !15)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 3, size: 128, elements: !16)
!16 = !{!17, !18, !19}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !15, file: !1, line: 4, baseType: !4, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !15, file: !1, line: 5, baseType: !13, size: 32, offset: 64)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !15, file: !1, line: 6, baseType: !13, size: 32, offset: 96)
!20 = !DIExpression()
!21 = !DILocation(line: 11, column: 15, scope: !10)
!22 = !DILocation(line: 12, column: 13, scope: !10)
!23 = !DILocation(line: 12, column: 8, scope: !10)
!24 = !DILocation(line: 12, column: 11, scope: !10)
!25 = !DILocalVariable(name: "t", scope: !10, file: !1, line: 14, type: !4)
!26 = !DILocation(line: 14, column: 11, scope: !10)
!27 = !DILocation(line: 14, column: 15, scope: !10)
!28 = !DILocation(line: 16, column: 5, scope: !10)
