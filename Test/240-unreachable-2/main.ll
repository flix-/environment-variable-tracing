; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %tainted = alloca i8*, align 8
  %rc = alloca i32, align 4
  %b = alloca i32, align 4
  %ut = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !11, metadata !14), !dbg !15
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !16
  store i8* %call, i8** %tainted, align 8, !dbg !15
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !17, metadata !14), !dbg !18
  %0 = load i8*, i8** %tainted, align 8, !dbg !19
  %tobool = icmp ne i8* %0, null, !dbg !19
  br i1 %tobool, label %if.then, label %if.else, !dbg !21

if.then:                                          ; preds = %entry
  store i32 0, i32* %rc, align 4, !dbg !22
  br label %if.end, !dbg !24

if.else:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %b, metadata !25, metadata !14), !dbg !27
  store i32 0, i32* %b, align 4, !dbg !27
  call void @abort() #5, !dbg !28
  unreachable, !dbg !28

if.end:                                           ; preds = %if.then
  call void @llvm.dbg.declare(metadata i32* %ut, metadata !29, metadata !14), !dbg !30
  store i32 1, i32* %ut, align 4, !dbg !30
  %1 = load i32, i32* %rc, align 4, !dbg !31
  ret i32 %1, !dbg !32
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @getenv(i8*) #2

; Function Attrs: noreturn nounwind
declare void @abort() #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final 348479)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/240-unreachable-2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 6, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 7, type: !12)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!14 = !DIExpression()
!15 = !DILocation(line: 7, column: 11, scope: !7)
!16 = !DILocation(line: 7, column: 21, scope: !7)
!17 = !DILocalVariable(name: "rc", scope: !7, file: !1, line: 9, type: !10)
!18 = !DILocation(line: 9, column: 9, scope: !7)
!19 = !DILocation(line: 10, column: 9, scope: !20)
!20 = distinct !DILexicalBlock(scope: !7, file: !1, line: 10, column: 9)
!21 = !DILocation(line: 10, column: 9, scope: !7)
!22 = !DILocation(line: 11, column: 12, scope: !23)
!23 = distinct !DILexicalBlock(scope: !20, file: !1, line: 10, column: 18)
!24 = !DILocation(line: 12, column: 5, scope: !23)
!25 = !DILocalVariable(name: "b", scope: !26, file: !1, line: 13, type: !10)
!26 = distinct !DILexicalBlock(scope: !20, file: !1, line: 12, column: 12)
!27 = !DILocation(line: 13, column: 13, scope: !26)
!28 = !DILocation(line: 14, column: 9, scope: !26)
!29 = !DILocalVariable(name: "ut", scope: !7, file: !1, line: 17, type: !10)
!30 = !DILocation(line: 17, column: 9, scope: !7)
!31 = !DILocation(line: 19, column: 12, scope: !7)
!32 = !DILocation(line: 19, column: 5, scope: !7)
