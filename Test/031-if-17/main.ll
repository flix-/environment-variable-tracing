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
  %a = alloca i32, align 4
  %t = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8** %tainted, metadata !11, metadata !14), !dbg !15
  %call = call i8* @getenv(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)) #3, !dbg !16
  store i8* %call, i8** %tainted, align 8, !dbg !15
  call void @llvm.dbg.declare(metadata i32* %rc, metadata !17, metadata !14), !dbg !18
  %0 = load i8*, i8** %tainted, align 8, !dbg !19
  %tobool = icmp ne i8* %0, null, !dbg !19
  br i1 %tobool, label %if.then, label %if.else, !dbg !21

if.then:                                          ; preds = %entry
  store i32 -1, i32* %retval, align 4, !dbg !22
  br label %return, !dbg !22

if.else:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %a, metadata !24, metadata !14), !dbg !26
  store i32 0, i32* %a, align 4, !dbg !26
  br label %if.end

if.end:                                           ; preds = %if.else
  call void @llvm.dbg.declare(metadata i32* %t, metadata !27, metadata !14), !dbg !28
  store i32 1, i32* %t, align 4, !dbg !28
  %1 = load i32, i32* %rc, align 4, !dbg !29
  store i32 %1, i32* %retval, align 4, !dbg !30
  br label %return, !dbg !30

return:                                           ; preds = %if.end, %if.then
  %2 = load i32, i32* %retval, align 4, !dbg !31
  ret i32 %2, !dbg !31
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
!1 = !DIFile(filename: "main.c", directory: "/home/sebastian/.qt-creator-workspace/Phasar/Test/031-if-17")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final 348479)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 5, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "tainted", scope: !7, file: !1, line: 6, type: !12)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!14 = !DIExpression()
!15 = !DILocation(line: 6, column: 11, scope: !7)
!16 = !DILocation(line: 6, column: 21, scope: !7)
!17 = !DILocalVariable(name: "rc", scope: !7, file: !1, line: 8, type: !10)
!18 = !DILocation(line: 8, column: 9, scope: !7)
!19 = !DILocation(line: 9, column: 9, scope: !20)
!20 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 9)
!21 = !DILocation(line: 9, column: 9, scope: !7)
!22 = !DILocation(line: 10, column: 9, scope: !23)
!23 = distinct !DILexicalBlock(scope: !20, file: !1, line: 9, column: 18)
!24 = !DILocalVariable(name: "a", scope: !25, file: !1, line: 12, type: !10)
!25 = distinct !DILexicalBlock(scope: !20, file: !1, line: 11, column: 12)
!26 = !DILocation(line: 12, column: 13, scope: !25)
!27 = !DILocalVariable(name: "t", scope: !7, file: !1, line: 15, type: !10)
!28 = !DILocation(line: 15, column: 9, scope: !7)
!29 = !DILocation(line: 17, column: 12, scope: !7)
!30 = !DILocation(line: 17, column: 5, scope: !7)
!31 = !DILocation(line: 18, column: 1, scope: !7)
