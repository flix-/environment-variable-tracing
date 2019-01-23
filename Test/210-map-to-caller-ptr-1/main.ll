; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i8*, i8* }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define %struct.s1* @foo(%struct.s1* %s1) #0 !dbg !7 {
entry:
  %s1.addr = alloca %struct.s1*, align 8
  store %struct.s1* %s1, %struct.s1** %s1.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.s1** %s1.addr, metadata !17, metadata !18), !dbg !19
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !20
  %0 = load %struct.s1*, %struct.s1** %s1.addr, align 8, !dbg !21
  %t1 = getelementptr inbounds %struct.s1, %struct.s1* %0, i32 0, i32 0, !dbg !22
  store i8* %call, i8** %t1, align 8, !dbg !23
  %1 = load %struct.s1*, %struct.s1** %s1.addr, align 8, !dbg !24
  ret %struct.s1* %1, !dbg !25
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @getenv(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !26 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.s1*, align 8
  %t1 = alloca i8*, align 8
  %nt1 = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s1** %s1, metadata !30, metadata !18), !dbg !31
  %0 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !32
  %call = call %struct.s1* @foo(%struct.s1* %0), !dbg !33
  store %struct.s1* %call, %struct.s1** %s1, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !35, metadata !18), !dbg !36
  %1 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !37
  %t11 = getelementptr inbounds %struct.s1, %struct.s1* %1, i32 0, i32 0, !dbg !38
  %2 = load i8*, i8** %t11, align 8, !dbg !38
  store i8* %2, i8** %t1, align 8, !dbg !36
  call void @llvm.dbg.declare(metadata i8** %nt1, metadata !39, metadata !18), !dbg !40
  %3 = load %struct.s1*, %struct.s1** %s1, align 8, !dbg !41
  %nt12 = getelementptr inbounds %struct.s1, %struct.s1* %3, i32 0, i32 1, !dbg !42
  %4 = load i8*, i8** %nt12, align 8, !dbg !42
  store i8* %4, i8** %nt1, align 8, !dbg !40
  ret i32 0, !dbg !43
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/210-map-to-caller-ptr-1")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s1", file: !1, line: 3, size: 128, elements: !12)
!12 = !{!13, !16}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "t1", scope: !11, file: !1, line: 4, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "nt1", scope: !11, file: !1, line: 5, baseType: !14, size: 64, offset: 64)
!17 = !DILocalVariable(name: "s1", arg: 1, scope: !7, file: !1, line: 9, type: !10)
!18 = !DIExpression()
!19 = !DILocation(line: 9, column: 16, scope: !7)
!20 = !DILocation(line: 11, column: 14, scope: !7)
!21 = !DILocation(line: 11, column: 5, scope: !7)
!22 = !DILocation(line: 11, column: 9, scope: !7)
!23 = !DILocation(line: 11, column: 12, scope: !7)
!24 = !DILocation(line: 13, column: 12, scope: !7)
!25 = !DILocation(line: 13, column: 5, scope: !7)
!26 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !27, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !0, variables: !2)
!27 = !DISubroutineType(types: !28)
!28 = !{!29}
!29 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!30 = !DILocalVariable(name: "s1", scope: !26, file: !1, line: 19, type: !10)
!31 = !DILocation(line: 19, column: 16, scope: !26)
!32 = !DILocation(line: 21, column: 14, scope: !26)
!33 = !DILocation(line: 21, column: 10, scope: !26)
!34 = !DILocation(line: 21, column: 8, scope: !26)
!35 = !DILocalVariable(name: "t1", scope: !26, file: !1, line: 23, type: !14)
!36 = !DILocation(line: 23, column: 11, scope: !26)
!37 = !DILocation(line: 23, column: 16, scope: !26)
!38 = !DILocation(line: 23, column: 20, scope: !26)
!39 = !DILocalVariable(name: "nt1", scope: !26, file: !1, line: 24, type: !14)
!40 = !DILocation(line: 24, column: 11, scope: !26)
!41 = !DILocation(line: 24, column: 17, scope: !26)
!42 = !DILocation(line: 24, column: 21, scope: !26)
!43 = !DILocation(line: 26, column: 5, scope: !26)
