; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"noe\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s11 = alloca %struct.s1, align 8
  %s12 = alloca %struct.s1*, align 8
  %t12 = alloca i8*, align 8
  %t24 = alloca i8*, align 8
  %ut1 = alloca i8*, align 8
  %t3 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1* %s11, metadata !11, metadata !18), !dbg !19
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !20
  %t1 = getelementptr inbounds %struct.s1, %struct.s1* %s11, i32 0, i32 0, !dbg !21
  store i8* %call, i8** %t1, align 8, !dbg !22
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !23
  %t2 = getelementptr inbounds %struct.s1, %struct.s1* %s11, i32 0, i32 1, !dbg !24
  store i8* %call1, i8** %t2, align 8, !dbg !25
  call void @llvm.dbg.declare(metadata %struct.s1** %s12, metadata !26, metadata !18), !dbg !28
  store %struct.s1* %s11, %struct.s1** %s12, align 8, !dbg !28
  call void @llvm.dbg.declare(metadata i8** %t12, metadata !29, metadata !18), !dbg !30
  %0 = load %struct.s1*, %struct.s1** %s12, align 8, !dbg !31
  %t13 = getelementptr inbounds %struct.s1, %struct.s1* %0, i32 0, i32 0, !dbg !32
  %1 = load i8*, i8** %t13, align 8, !dbg !32
  store i8* %1, i8** %t12, align 8, !dbg !30
  call void @llvm.dbg.declare(metadata i8** %t24, metadata !33, metadata !18), !dbg !34
  %2 = load %struct.s1*, %struct.s1** %s12, align 8, !dbg !35
  %t25 = getelementptr inbounds %struct.s1, %struct.s1* %2, i32 0, i32 1, !dbg !36
  %3 = load i8*, i8** %t25, align 8, !dbg !36
  store i8* %3, i8** %t24, align 8, !dbg !34
  %t16 = getelementptr inbounds %struct.s1, %struct.s1* %s11, i32 0, i32 0, !dbg !37
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0), i8** %t16, align 8, !dbg !38
  store %struct.s1* %s11, %struct.s1** %s12, align 8, !dbg !39
  call void @llvm.dbg.declare(metadata i8** %ut1, metadata !40, metadata !18), !dbg !41
  %4 = load %struct.s1*, %struct.s1** %s12, align 8, !dbg !42
  %t17 = getelementptr inbounds %struct.s1, %struct.s1* %4, i32 0, i32 0, !dbg !43
  %5 = load i8*, i8** %t17, align 8, !dbg !43
  store i8* %5, i8** %ut1, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata i8** %t3, metadata !44, metadata !18), !dbg !45
  %6 = load %struct.s1*, %struct.s1** %s12, align 8, !dbg !46
  %t28 = getelementptr inbounds %struct.s1, %struct.s1* %6, i32 0, i32 1, !dbg !47
  %7 = load i8*, i8** %t28, align 8, !dbg !47
  store i8* %7, i8** %t3, align 8, !dbg !45
  ret i32 0, !dbg !48
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/151-ptr-9")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !8, isLocal: false, isDefinition: true, scopeLine: 14, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s11", scope: !7, file: !1, line: 15, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 7, size: 128, elements: !13)
!13 = !{!14, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !12, file: !1, line: 8, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "t2", scope: !12, file: !1, line: 9, baseType: !15, size: 64, offset: 64)
!18 = !DIExpression()
!19 = !DILocation(line: 15, column: 15, scope: !7)
!20 = !DILocation(line: 16, column: 14, scope: !7)
!21 = !DILocation(line: 16, column: 9, scope: !7)
!22 = !DILocation(line: 16, column: 12, scope: !7)
!23 = !DILocation(line: 17, column: 14, scope: !7)
!24 = !DILocation(line: 17, column: 9, scope: !7)
!25 = !DILocation(line: 17, column: 12, scope: !7)
!26 = !DILocalVariable(name: "s12", scope: !7, file: !1, line: 19, type: !27)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!28 = !DILocation(line: 19, column: 16, scope: !7)
!29 = !DILocalVariable(name: "t1", scope: !7, file: !1, line: 20, type: !15)
!30 = !DILocation(line: 20, column: 11, scope: !7)
!31 = !DILocation(line: 20, column: 16, scope: !7)
!32 = !DILocation(line: 20, column: 21, scope: !7)
!33 = !DILocalVariable(name: "t2", scope: !7, file: !1, line: 21, type: !15)
!34 = !DILocation(line: 21, column: 11, scope: !7)
!35 = !DILocation(line: 21, column: 16, scope: !7)
!36 = !DILocation(line: 21, column: 21, scope: !7)
!37 = !DILocation(line: 23, column: 9, scope: !7)
!38 = !DILocation(line: 23, column: 12, scope: !7)
!39 = !DILocation(line: 25, column: 9, scope: !7)
!40 = !DILocalVariable(name: "ut1", scope: !7, file: !1, line: 26, type: !15)
!41 = !DILocation(line: 26, column: 11, scope: !7)
!42 = !DILocation(line: 26, column: 17, scope: !7)
!43 = !DILocation(line: 26, column: 22, scope: !7)
!44 = !DILocalVariable(name: "t3", scope: !7, file: !1, line: 27, type: !15)
!45 = !DILocation(line: 27, column: 11, scope: !7)
!46 = !DILocation(line: 27, column: 16, scope: !7)
!47 = !DILocation(line: 27, column: 21, scope: !7)
!48 = !DILocation(line: 29, column: 5, scope: !7)
