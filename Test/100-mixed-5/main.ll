; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.SH = type { i32, i8*, i32, i32 }

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@sh = internal global %struct.SH zeroinitializer, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !19 {
entry:
  %retval = alloca i32, align 4
  %ptr = alloca i8*, align 8
  %rc = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %ptr, metadata !22, metadata !23), !dbg !24
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !25
  store i8* %call, i8** %ptr, align 8, !dbg !24
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !26, metadata !23), !dbg !27
  %0 = load i8*, i8** %ptr, align 8, !dbg !28
  %call1 = call i32 @sh_getlist(i8* %0), !dbg !29
  store i32 %call1, i32* %rc, align 4, !dbg !27
  %1 = load i32, i32* %rc, align 4, !dbg !30
  ret i32 %1, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @sh_getlist(i8* %ptr) #0 !dbg !32 {
entry:
  %ptr.addr = alloca i8*, align 8
  %size = alloca i32, align 4
  %bit = alloca i32, align 4
  %t = alloca i32, align 4
  store i8* %ptr, i8** %ptr.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %ptr.addr, metadata !35, metadata !23), !dbg !36
  call void @llvm.dbg.declare(metadata i32* %size, metadata !37, metadata !23), !dbg !38
  %0 = load i32, i32* getelementptr inbounds (%struct.SH, %struct.SH* @sh, i32 0, i32 3), align 4, !dbg !39
  %sub = sub nsw i32 %0, 1, !dbg !40
  store i32 %sub, i32* %size, align 4, !dbg !38
  call void @llvm.dbg.declare(metadata i32* %bit, metadata !41, metadata !23), !dbg !42
  %1 = load i32, i32* getelementptr inbounds (%struct.SH, %struct.SH* @sh, i32 0, i32 0), align 8, !dbg !43
  %2 = load i8*, i8** %ptr.addr, align 8, !dbg !44
  %idx.ext = sext i32 %1 to i64, !dbg !45
  %add.ptr = getelementptr inbounds i8, i8* %2, i64 %idx.ext, !dbg !45
  %3 = load i8*, i8** getelementptr inbounds (%struct.SH, %struct.SH* @sh, i32 0, i32 1), align 8, !dbg !46
  %sub.ptr.lhs.cast = ptrtoint i8* %add.ptr to i64, !dbg !47
  %sub.ptr.rhs.cast = ptrtoint i8* %3 to i64, !dbg !47
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast, !dbg !47
  %4 = load i32, i32* getelementptr inbounds (%struct.SH, %struct.SH* @sh, i32 0, i32 2), align 8, !dbg !48
  %conv = sext i32 %4 to i64, !dbg !49
  %div = sdiv i64 %sub.ptr.sub, %conv, !dbg !50
  %conv1 = trunc i64 %div to i32, !dbg !51
  store i32 %conv1, i32* %bit, align 4, !dbg !42
  call void @llvm.dbg.declare(metadata i32* %t, metadata !52, metadata !23), !dbg !53
  %5 = load i32, i32* %bit, align 4, !dbg !54
  store i32 %5, i32* %t, align 4, !dbg !53
  ret i32 0, !dbg !55
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!15, !16, !17}
!llvm.ident = !{!18}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "sh", scope: !2, file: !3, line: 12, type: !6, isLocal: true, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/100-mixed-5")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "SH", file: !3, line: 5, size: 192, elements: !7)
!7 = !{!8, !10, !13, !14}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "arena_size", scope: !6, file: !3, line: 6, baseType: !9, size: 32)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "arena", scope: !6, file: !3, line: 7, baseType: !11, size: 64, offset: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!13 = !DIDerivedType(tag: DW_TAG_member, name: "minsize", scope: !6, file: !3, line: 8, baseType: !9, size: 32, offset: 128)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "freelist_size", scope: !6, file: !3, line: 9, baseType: !9, size: 32, offset: 160)
!15 = !{i32 2, !"Dwarf Version", i32 4}
!16 = !{i32 2, !"Debug Info Version", i32 3}
!17 = !{i32 1, !"wchar_size", i32 4}
!18 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!19 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 26, type: !20, isLocal: false, isDefinition: true, scopeLine: 26, isOptimized: false, unit: !2, variables: !4)
!20 = !DISubroutineType(types: !21)
!21 = !{!9}
!22 = !DILocalVariable(name: "ptr", scope: !19, file: !3, line: 27, type: !11)
!23 = !DIExpression()
!24 = !DILocation(line: 27, column: 11, scope: !19)
!25 = !DILocation(line: 27, column: 17, scope: !19)
!26 = !DILocalVariable(name: "rc", scope: !19, file: !3, line: 29, type: !9)
!27 = !DILocation(line: 29, column: 9, scope: !19)
!28 = !DILocation(line: 29, column: 25, scope: !19)
!29 = !DILocation(line: 29, column: 14, scope: !19)
!30 = !DILocation(line: 31, column: 12, scope: !19)
!31 = !DILocation(line: 31, column: 5, scope: !19)
!32 = distinct !DISubprogram(name: "sh_getlist", scope: !3, file: !3, line: 15, type: !33, isLocal: true, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!33 = !DISubroutineType(types: !34)
!34 = !{!9, !11}
!35 = !DILocalVariable(name: "ptr", arg: 1, scope: !32, file: !3, line: 15, type: !11)
!36 = !DILocation(line: 15, column: 18, scope: !32)
!37 = !DILocalVariable(name: "size", scope: !32, file: !3, line: 16, type: !9)
!38 = !DILocation(line: 16, column: 9, scope: !32)
!39 = !DILocation(line: 16, column: 19, scope: !32)
!40 = !DILocation(line: 16, column: 33, scope: !32)
!41 = !DILocalVariable(name: "bit", scope: !32, file: !3, line: 18, type: !9)
!42 = !DILocation(line: 18, column: 9, scope: !32)
!43 = !DILocation(line: 18, column: 19, scope: !32)
!44 = !DILocation(line: 18, column: 32, scope: !32)
!45 = !DILocation(line: 18, column: 30, scope: !32)
!46 = !DILocation(line: 18, column: 41, scope: !32)
!47 = !DILocation(line: 18, column: 36, scope: !32)
!48 = !DILocation(line: 18, column: 53, scope: !32)
!49 = !DILocation(line: 18, column: 50, scope: !32)
!50 = !DILocation(line: 18, column: 48, scope: !32)
!51 = !DILocation(line: 18, column: 15, scope: !32)
!52 = !DILocalVariable(name: "t", scope: !32, file: !3, line: 20, type: !9)
!53 = !DILocation(line: 20, column: 9, scope: !32)
!54 = !DILocation(line: 20, column: 13, scope: !32)
!55 = !DILocation(line: 22, column: 5, scope: !32)
