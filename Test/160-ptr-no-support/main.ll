; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s3 = type { i8* }
%struct.s1 = type { i32, %struct.s3* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %sss = alloca %struct.s3, align 8
  %s = alloca %struct.s1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s3* %sss, metadata !11, metadata !17), !dbg !18
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !19
  %tainted = getelementptr inbounds %struct.s3, %struct.s3* %sss, i32 0, i32 0, !dbg !20
  store i8* %call, i8** %tainted, align 8, !dbg !21
  call void @llvm.dbg.declare(metadata %struct.s1* %s, metadata !22, metadata !17), !dbg !28
  %ps3 = getelementptr inbounds %struct.s1, %struct.s1* %s, i32 0, i32 1, !dbg !29
  store %struct.s3* %sss, %struct.s3** %ps3, align 8, !dbg !30
  ret i32 0, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/160-ptr-no-support")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !8, isLocal: false, isDefinition: true, scopeLine: 14, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "sss", scope: !7, file: !1, line: 15, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s3", file: !1, line: 3, size: 64, elements: !13)
!13 = !{!14}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "tainted", scope: !12, file: !1, line: 4, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIExpression()
!18 = !DILocation(line: 15, column: 15, scope: !7)
!19 = !DILocation(line: 16, column: 19, scope: !7)
!20 = !DILocation(line: 16, column: 9, scope: !7)
!21 = !DILocation(line: 16, column: 17, scope: !7)
!22 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 18, type: !23)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 7, size: 128, elements: !24)
!24 = !{!25, !26}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !23, file: !1, line: 8, baseType: !10, size: 32)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "ps3", scope: !23, file: !1, line: 9, baseType: !27, size: 64, offset: 64)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!28 = !DILocation(line: 18, column: 15, scope: !7)
!29 = !DILocation(line: 19, column: 7, scope: !7)
!30 = !DILocation(line: 19, column: 11, scope: !7)
!31 = !DILocation(line: 21, column: 5, scope: !7)
