; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, i32, i32 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1, align 8
  %f = alloca float, align 4
  %t12 = alloca i32, align 4
  %t2 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s1, metadata !11, metadata !19), !dbg !20
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !21
  %t1 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !22
  store i8* %call, i8** %t1, align 8, !dbg !23
  call void @llvm.dbg.declare(metadata float* %f, metadata !24, metadata !19), !dbg !26
  %t11 = getelementptr inbounds %struct.s1, %struct.s1* %s1, i32 0, i32 0, !dbg !27
  %0 = load i8*, i8** %t11, align 8, !dbg !27
  %tobool = icmp ne i8* %0, null, !dbg !28
  br i1 %tobool, label %lor.end, label %lor.rhs, !dbg !29

lor.rhs:                                          ; preds = %entry
  br label %lor.end, !dbg !29

lor.end:                                          ; preds = %lor.rhs, %entry
  %1 = phi i1 [ true, %entry ], [ true, %lor.rhs ]
  %lor.ext = zext i1 %1 to i32, !dbg !29
  %conv = sitofp i32 %lor.ext to float, !dbg !28
  store float %conv, float* %f, align 4, !dbg !26
  call void @llvm.dbg.declare(metadata i32* %t12, metadata !30, metadata !19), !dbg !32
  %2 = load float, float* %f, align 4, !dbg !33
  %conv3 = fptoui float %2 to i32, !dbg !33
  store i32 %conv3, i32* %t12, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata i32* %t2, metadata !34, metadata !19), !dbg !35
  %3 = load float, float* %f, align 4, !dbg !36
  %conv4 = fptosi float %3 to i32, !dbg !36
  store i32 %conv4, i32* %t2, align 4, !dbg !35
  ret i32 0, !dbg !37
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/220-conversions-3")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 11, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 3, size: 128, elements: !13)
!13 = !{!14, !17, !18}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !12, file: !1, line: 4, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 5, baseType: !10, size: 32, offset: 64)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !12, file: !1, line: 6, baseType: !10, size: 32, offset: 96)
!19 = !DIExpression()
!20 = !DILocation(line: 11, column: 15, scope: !7)
!21 = !DILocation(line: 12, column: 13, scope: !7)
!22 = !DILocation(line: 12, column: 8, scope: !7)
!23 = !DILocation(line: 12, column: 11, scope: !7)
!24 = !DILocalVariable(name: "f", scope: !7, file: !1, line: 14, type: !25)
!25 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!26 = !DILocation(line: 14, column: 11, scope: !7)
!27 = !DILocation(line: 14, column: 18, scope: !7)
!28 = !DILocation(line: 14, column: 15, scope: !7)
!29 = !DILocation(line: 14, column: 21, scope: !7)
!30 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 15, type: !31)
!31 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!32 = !DILocation(line: 15, column: 18, scope: !7)
!33 = !DILocation(line: 15, column: 23, scope: !7)
!34 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 17, type: !10)
!35 = !DILocation(line: 17, column: 9, scope: !7)
!36 = !DILocation(line: 17, column: 14, scope: !7)
!37 = !DILocation(line: 19, column: 5, scope: !7)
