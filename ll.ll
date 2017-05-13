; ModuleID = 'll.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list_el = type { i32, %struct.list_el* }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @main() #0 {
  %curr = alloca %struct.list_el*, align 8
  %head = alloca %struct.list_el*, align 8
  %i = alloca i32, align 4
  call void @llvm.dbg.declare(metadata !{%struct.list_el** %curr}, metadata !11), !dbg !20
  call void @llvm.dbg.declare(metadata !{%struct.list_el** %head}, metadata !21), !dbg !22
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !23), !dbg !24
  store %struct.list_el* null, %struct.list_el** %head, align 8, !dbg !25
  store i32 1, i32* %i, align 4, !dbg !26
  br label %1, !dbg !26

; <label>:1                                       ; preds = %14, %0
  %2 = load i32* %i, align 4, !dbg !28
  %3 = icmp sle i32 %2, 10, !dbg !28
  br i1 %3, label %4, label %17, !dbg !28

; <label>:4                                       ; preds = %1
  %5 = call noalias i8* @malloc(i64 16) #4, !dbg !31
  %6 = bitcast i8* %5 to %struct.list_el*, !dbg !31
  store %struct.list_el* %6, %struct.list_el** %curr, align 8, !dbg !31
  %7 = load i32* %i, align 4, !dbg !33
  %8 = load %struct.list_el** %curr, align 8, !dbg !33
  %9 = getelementptr inbounds %struct.list_el* %8, i32 0, i32 0, !dbg !33
  store i32 %7, i32* %9, align 4, !dbg !33
  %10 = load %struct.list_el** %head, align 8, !dbg !34
  %11 = load %struct.list_el** %curr, align 8, !dbg !34
  %12 = getelementptr inbounds %struct.list_el* %11, i32 0, i32 1, !dbg !34
  store %struct.list_el* %10, %struct.list_el** %12, align 8, !dbg !34
  %13 = load %struct.list_el** %curr, align 8, !dbg !35
  store %struct.list_el* %13, %struct.list_el** %head, align 8, !dbg !35
  br label %14, !dbg !36

; <label>:14                                      ; preds = %4
  %15 = load i32* %i, align 4, !dbg !37
  %16 = add nsw i32 %15, 1, !dbg !37
  store i32 %16, i32* %i, align 4, !dbg !37
  br label %1, !dbg !37

; <label>:17                                      ; preds = %1
  %18 = load %struct.list_el** %head, align 8, !dbg !38
  store %struct.list_el* %18, %struct.list_el** %curr, align 8, !dbg !38
  br label %19, !dbg !39

; <label>:19                                      ; preds = %22, %17
  %20 = load %struct.list_el** %curr, align 8, !dbg !40
  %21 = icmp ne %struct.list_el* %20, null, !dbg !40
  br i1 %21, label %22, label %30, !dbg !40

; <label>:22                                      ; preds = %19
  %23 = load %struct.list_el** %curr, align 8, !dbg !42
  %24 = getelementptr inbounds %struct.list_el* %23, i32 0, i32 0, !dbg !42
  %25 = load i32* %24, align 4, !dbg !42
  %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %25), !dbg !42
  %27 = load %struct.list_el** %curr, align 8, !dbg !44
  %28 = getelementptr inbounds %struct.list_el* %27, i32 0, i32 1, !dbg !44
  %29 = load %struct.list_el** %28, align 8, !dbg !44
  store %struct.list_el* %29, %struct.list_el** %curr, align 8, !dbg !44
  br label %19, !dbg !45

; <label>:30                                      ; preds = %19
  ret void, !dbg !46
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

declare i32 @printf(i8*, ...) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!8, !9}
!llvm.ident = !{!10}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/home/user/Code/calpoly-csc-projects/Testing_530/final-project/ll.c] [DW_LANG_C99]
!1 = metadata !{metadata !"ll.c", metadata !"/home/user/Code/calpoly-csc-projects/Testing_530/final-project"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 10, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, void ()* @main, null, null, metadata !2, i32 10} ; [ DW_TAG_subprogram ] [line 10] [def] [main]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/user/Code/calpoly-csc-projects/Testing_530/final-project/ll.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null}
!8 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!9 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!10 = metadata !{metadata !"Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)"}
!11 = metadata !{i32 786688, metadata !4, metadata !"curr", metadata !5, i32 11, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [curr] [line 11]
!12 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !13} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from item]
!13 = metadata !{i32 786454, metadata !1, null, metadata !"item", i32 8, i64 0, i64 0, i64 0, i32 0, metadata !14} ; [ DW_TAG_typedef ] [item] [line 8, size 0, align 0, offset 0] [from list_el]
!14 = metadata !{i32 786451, metadata !1, null, metadata !"list_el", i32 3, i64 128, i64 64, i32 0, i32 0, null, metadata !15, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [list_el] [line 3, size 128, align 64, offset 0] [def] [from ]
!15 = metadata !{metadata !16, metadata !18}
!16 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"val", i32 4, i64 32, i64 32, i64 0, i32 0, metadata !17} ; [ DW_TAG_member ] [val] [line 4, size 32, align 32, offset 0] [from int]
!17 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!18 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"next", i32 5, i64 64, i64 64, i64 64, i32 0, metadata !19} ; [ DW_TAG_member ] [next] [line 5, size 64, align 64, offset 64] [from ]
!19 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from list_el]
!20 = metadata !{i32 11, i32 11, metadata !4, null}
!21 = metadata !{i32 786688, metadata !4, metadata !"head", metadata !5, i32 11, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [head] [line 11]
!22 = metadata !{i32 11, i32 19, metadata !4, null}
!23 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 12, metadata !17, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 12]
!24 = metadata !{i32 12, i32 8, metadata !4, null}
!25 = metadata !{i32 14, i32 4, metadata !4, null}
!26 = metadata !{i32 16, i32 8, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 16, i32 4, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/user/Code/calpoly-csc-projects/Testing_530/final-project/ll.c]
!28 = metadata !{i32 16, i32 8, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !30, i32 16, i32 8, i32 2, i32 4} ; [ DW_TAG_lexical_block ] [/home/user/Code/calpoly-csc-projects/Testing_530/final-project/ll.c]
!30 = metadata !{i32 786443, metadata !1, metadata !27, i32 16, i32 8, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/home/user/Code/calpoly-csc-projects/Testing_530/final-project/ll.c]
!31 = metadata !{i32 17, i32 22, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !27, i32 16, i32 23, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/user/Code/calpoly-csc-projects/Testing_530/final-project/ll.c]
!33 = metadata !{i32 18, i32 7, metadata !32, null}
!34 = metadata !{i32 19, i32 7, metadata !32, null}
!35 = metadata !{i32 20, i32 7, metadata !32, null}
!36 = metadata !{i32 21, i32 4, metadata !32, null}
!37 = metadata !{i32 16, i32 18, metadata !27, null}
!38 = metadata !{i32 23, i32 4, metadata !4, null}
!39 = metadata !{i32 25, i32 4, metadata !4, null}
!40 = metadata !{i32 25, i32 4, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !4, i32 25, i32 4, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/home/user/Code/calpoly-csc-projects/Testing_530/final-project/ll.c]
!42 = metadata !{i32 26, i32 7, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !4, i32 25, i32 16, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/user/Code/calpoly-csc-projects/Testing_530/final-project/ll.c]
!44 = metadata !{i32 27, i32 7, metadata !43, null}
!45 = metadata !{i32 28, i32 4, metadata !43, null}
!46 = metadata !{i32 29, i32 1, metadata !4, null}
