; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"gude\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"huhu\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %tainted = alloca i8*, align 8
  %a = alloca i32, align 4
  %t1 = alloca i8*, align 8
  %b = alloca i32, align 4
  %nt = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !11, metadata !14), !dbg !15
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #4, !dbg !16
  store i8* %call, i8** %tainted, align 8, !dbg !15
  %0 = load i8*, i8** %tainted, align 8, !dbg !17
  %tobool = icmp ne i8* %0, null, !dbg !17
  br i1 %tobool, label %if.then, label %if.else, !dbg !19

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %a, metadata !20, metadata !14), !dbg !22
  store i32 0, i32* %a, align 4, !dbg !22
  call void @llvm.dbg.declare(metadata i8** %t1, metadata !23, metadata !14), !dbg !24
  %call1 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0)) #4, !dbg !25
  store i8* %call1, i8** %t1, align 8, !dbg !24
  call void @abort() #5, !dbg !26
  unreachable, !dbg !26

if.else:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %b, metadata !27, metadata !14), !dbg !29
  store i32 1, i32* %b, align 4, !dbg !29
  call void @abort() #5, !dbg !30
  unreachable, !dbg !30

return:                                           ; No predecessors!
  %1 = load i32, i32* %retval, align 4, !dbg !31
  ret i32 %1, !dbg !31
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/240-unreachable-4")
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
!17 = !DILocation(line: 9, column: 9, scope: !18)
!18 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 9)
!19 = !DILocation(line: 9, column: 9, scope: !7)
!20 = !DILocalVariable(name: "a", scope: !21, file: !1, line: 10, type: !10)
!21 = distinct !DILexicalBlock(scope: !18, file: !1, line: 9, column: 18)
!22 = !DILocation(line: 10, column: 13, scope: !21)
!23 = !DILocalVariable(name: "t1", scope: !21, file: !1, line: 11, type: !12)
!24 = !DILocation(line: 11, column: 15, scope: !21)
!25 = !DILocation(line: 11, column: 20, scope: !21)
!26 = !DILocation(line: 12, column: 9, scope: !21)
!27 = !DILocalVariable(name: "b", scope: !28, file: !1, line: 14, type: !10)
!28 = distinct !DILexicalBlock(scope: !18, file: !1, line: 13, column: 12)
!29 = !DILocation(line: 14, column: 13, scope: !28)
!30 = !DILocation(line: 15, column: 9, scope: !28)
!31 = !DILocation(line: 21, column: 1, scope: !7)
