; ModuleID = 'll.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list_el = type { i32, %struct.list_el* }

@.str = internal unnamed_addr constant { [4 x i8], [60 x i8] } { [4 x i8] c"%d\0A\00", [60 x i8] zeroinitializer }, align 32
@.str1 = private unnamed_addr constant [5 x i8] c"ll.c\00", align 1
@.asan_loc_descr = private unnamed_addr constant { [5 x i8]*, i32, i32 } { [5 x i8]* @.str1, i32 26, i32 14 }
@.str2 = private unnamed_addr constant [17 x i8] c"<string literal>\00", align 1
@llvm.compiler.used = appending global [2 x i8*] [i8* bitcast ({ [5 x i8]*, i32, i32 }* @.asan_loc_descr to i8*), i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0)], section "llvm.metadata"
@llvm.global_ctors = appending global [1 x { i32, void ()* }] [{ i32, void ()* } { i32 1, void ()* @asan.module_ctor }]
@__asan_option_detect_stack_use_after_return = external global i32
@__asan_gen_ = private unnamed_addr constant [35 x i8] c"3 32 8 4 curr 64 8 4 head 96 4 1 i\00", align 1
@__asan_gen_3 = private constant [5 x i8] c"ll.c\00", align 1
@0 = internal global [1 x { i64, i64, i64, i64, i64, i64, i64 }] [{ i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint ({ [4 x i8], [60 x i8] }* @.str to i64), i64 4, i64 64, i64 ptrtoint ([17 x i8]* @.str2 to i64), i64 ptrtoint ([5 x i8]* @__asan_gen_3 to i64), i64 0, i64 ptrtoint ({ [5 x i8]*, i32, i32 }* @.asan_loc_descr to i64) }]
@llvm.global_dtors = appending global [1 x { i32, void ()* }] [{ i32, void ()* } { i32 1, void ()* @asan.module_dtor }]

; Function Attrs: nounwind sanitize_address uwtable
define void @main() #0 {
  %MyAlloca = alloca [128 x i8], align 32, !dbg !12
  %1 = ptrtoint [128 x i8]* %MyAlloca to i64, !dbg !12
  %2 = load i32* @__asan_option_detect_stack_use_after_return, !dbg !12
  %3 = icmp ne i32 %2, 0, !dbg !12
  br i1 %3, label %4, label %6

; <label>:4                                       ; preds = %0
  %5 = call i64 @__asan_stack_malloc_1(i64 128, i64 %1), !dbg !12
  br label %6

; <label>:6                                       ; preds = %0, %4
  %7 = phi i64 [ %1, %0 ], [ %5, %4 ], !dbg !12
  %8 = add i64 %7, 32, !dbg !12
  %9 = inttoptr i64 %8 to %struct.list_el**, !dbg !12
  %10 = add i64 %7, 64, !dbg !12
  %11 = inttoptr i64 %10 to %struct.list_el**, !dbg !12
  %12 = add i64 %7, 96, !dbg !12
  %13 = inttoptr i64 %12 to i32*, !dbg !12
  %14 = inttoptr i64 %7 to i64*, !dbg !12
  store i64 1102416563, i64* %14, !dbg !12
  %15 = add i64 %7, 8, !dbg !12
  %16 = inttoptr i64 %15 to i64*, !dbg !12
  store i64 ptrtoint ([35 x i8]* @__asan_gen_ to i64), i64* %16, !dbg !12
  %17 = add i64 %7, 16, !dbg !12
  %18 = inttoptr i64 %17 to i64*, !dbg !12
  store i64 ptrtoint (void ()* @main to i64), i64* %18, !dbg !12
  %19 = lshr i64 %7, 3, !dbg !12
  %20 = add i64 %19, 2147450880, !dbg !12
  %21 = add i64 %20, 0, !dbg !12
  %22 = inttoptr i64 %21 to i64*, !dbg !12
  store i64 -940423286293925391, i64* %22, !dbg !12
  %23 = add i64 %20, 8, !dbg !12
  %24 = inttoptr i64 %23 to i64*, !dbg !12
  store i64 -868083100570947072, i64* %24, !dbg !12
  %25 = ptrtoint %struct.list_el** %11 to i64, !dbg !13
  %26 = lshr i64 %25, 3, !dbg !13
  %27 = add i64 %26, 2147450880, !dbg !13
  %28 = inttoptr i64 %27 to i8*, !dbg !13
  %29 = load i8* %28, !dbg !13
  %30 = icmp ne i8 %29, 0, !dbg !13
  call void @llvm.dbg.declare(metadata !{%struct.list_el** %9}, metadata !14)
  call void @llvm.dbg.declare(metadata !{%struct.list_el** %11}, metadata !24)
  call void @llvm.dbg.declare(metadata !{i32* %13}, metadata !25)
  br i1 %30, label %31, label %32, !dbg !13

; <label>:31                                      ; preds = %6
  call void @__asan_report_store8(i64 %25), !dbg !13
  call void asm sideeffect "", ""(), !dbg !13
  unreachable, !dbg !13

; <label>:32                                      ; preds = %6
  store %struct.list_el* null, %struct.list_el** %11, align 8, !dbg !13
  %33 = ptrtoint i32* %13 to i64, !dbg !26
  %34 = lshr i64 %33, 3, !dbg !26
  %35 = add i64 %34, 2147450880, !dbg !26
  %36 = inttoptr i64 %35 to i8*, !dbg !26
  %37 = load i8* %36, !dbg !26
  %38 = icmp ne i8 %37, 0, !dbg !26
  br i1 %38, label %39, label %45, !dbg !26

; <label>:39                                      ; preds = %32
  %40 = and i64 %33, 7, !dbg !26
  %41 = add i64 %40, 3, !dbg !26
  %42 = trunc i64 %41 to i8, !dbg !26
  %43 = icmp sge i8 %42, %37, !dbg !26
  br i1 %43, label %44, label %45

; <label>:44                                      ; preds = %39
  call void @__asan_report_store4(i64 %33), !dbg !26
  call void asm sideeffect "", ""()
  unreachable

; <label>:45                                      ; preds = %39, %32
  store i32 1, i32* %13, align 4, !dbg !26
  br label %46, !dbg !26

; <label>:46                                      ; preds = %135, %45
  %47 = ptrtoint i32* %13 to i64, !dbg !28
  %48 = lshr i64 %47, 3, !dbg !28
  %49 = add i64 %48, 2147450880, !dbg !28
  %50 = inttoptr i64 %49 to i8*, !dbg !28
  %51 = load i8* %50, !dbg !28
  %52 = icmp ne i8 %51, 0, !dbg !28
  br i1 %52, label %53, label %59, !dbg !28

; <label>:53                                      ; preds = %46
  %54 = and i64 %47, 7, !dbg !28
  %55 = add i64 %54, 3, !dbg !28
  %56 = trunc i64 %55 to i8, !dbg !28
  %57 = icmp sge i8 %56, %51, !dbg !28
  br i1 %57, label %58, label %59

; <label>:58                                      ; preds = %53
  call void @__asan_report_load4(i64 %47), !dbg !28
  call void asm sideeffect "", ""()
  unreachable

; <label>:59                                      ; preds = %53, %46
  %60 = load i32* %13, align 4, !dbg !28
  %61 = icmp sle i32 %60, 10, !dbg !28
  br i1 %61, label %62, label %138, !dbg !28

; <label>:62                                      ; preds = %59
  %63 = call noalias i8* @malloc(i64 16) #4, !dbg !31
  %64 = bitcast i8* %63 to %struct.list_el*, !dbg !31
  %65 = ptrtoint %struct.list_el** %9 to i64, !dbg !31
  %66 = lshr i64 %65, 3, !dbg !31
  %67 = add i64 %66, 2147450880, !dbg !31
  %68 = inttoptr i64 %67 to i8*, !dbg !31
  %69 = load i8* %68, !dbg !31
  %70 = icmp ne i8 %69, 0, !dbg !31
  br i1 %70, label %71, label %72, !dbg !31

; <label>:71                                      ; preds = %62
  call void @__asan_report_store8(i64 %65), !dbg !31
  call void asm sideeffect "", ""(), !dbg !31
  unreachable, !dbg !31

; <label>:72                                      ; preds = %62
  store %struct.list_el* %64, %struct.list_el** %9, align 8, !dbg !31
  %73 = ptrtoint i32* %13 to i64, !dbg !33
  %74 = lshr i64 %73, 3, !dbg !33
  %75 = add i64 %74, 2147450880, !dbg !33
  %76 = inttoptr i64 %75 to i8*, !dbg !33
  %77 = load i8* %76, !dbg !33
  %78 = icmp ne i8 %77, 0, !dbg !33
  br i1 %78, label %79, label %85, !dbg !33

; <label>:79                                      ; preds = %72
  %80 = and i64 %73, 7, !dbg !33
  %81 = add i64 %80, 3, !dbg !33
  %82 = trunc i64 %81 to i8, !dbg !33
  %83 = icmp sge i8 %82, %77, !dbg !33
  br i1 %83, label %84, label %85

; <label>:84                                      ; preds = %79
  call void @__asan_report_load4(i64 %73), !dbg !33
  call void asm sideeffect "", ""()
  unreachable

; <label>:85                                      ; preds = %79, %72
  %86 = load i32* %13, align 4, !dbg !33
  %87 = load %struct.list_el** %9, align 8, !dbg !33
  %88 = getelementptr inbounds %struct.list_el* %87, i32 0, i32 0, !dbg !33
  %89 = ptrtoint i32* %88 to i64, !dbg !33
  %90 = lshr i64 %89, 3, !dbg !33
  %91 = add i64 %90, 2147450880, !dbg !33
  %92 = inttoptr i64 %91 to i8*, !dbg !33
  %93 = load i8* %92, !dbg !33
  %94 = icmp ne i8 %93, 0, !dbg !33
  br i1 %94, label %95, label %101, !dbg !33

; <label>:95                                      ; preds = %85
  %96 = and i64 %89, 7, !dbg !33
  %97 = add i64 %96, 3, !dbg !33
  %98 = trunc i64 %97 to i8, !dbg !33
  %99 = icmp sge i8 %98, %93, !dbg !33
  br i1 %99, label %100, label %101

; <label>:100                                     ; preds = %95
  call void @__asan_report_store4(i64 %89), !dbg !33
  call void asm sideeffect "", ""()
  unreachable

; <label>:101                                     ; preds = %95, %85
  store i32 %86, i32* %88, align 4, !dbg !33
  %102 = ptrtoint %struct.list_el** %11 to i64, !dbg !34
  %103 = lshr i64 %102, 3, !dbg !34
  %104 = add i64 %103, 2147450880, !dbg !34
  %105 = inttoptr i64 %104 to i8*, !dbg !34
  %106 = load i8* %105, !dbg !34
  %107 = icmp ne i8 %106, 0, !dbg !34
  br i1 %107, label %108, label %109, !dbg !34

; <label>:108                                     ; preds = %101
  call void @__asan_report_load8(i64 %102), !dbg !34
  call void asm sideeffect "", ""(), !dbg !34
  unreachable, !dbg !34

; <label>:109                                     ; preds = %101
  %110 = load %struct.list_el** %11, align 8, !dbg !34
  %111 = load %struct.list_el** %9, align 8, !dbg !34
  %112 = getelementptr inbounds %struct.list_el* %111, i32 0, i32 1, !dbg !34
  %113 = ptrtoint %struct.list_el** %112 to i64, !dbg !34
  %114 = lshr i64 %113, 3, !dbg !34
  %115 = add i64 %114, 2147450880, !dbg !34
  %116 = inttoptr i64 %115 to i8*, !dbg !34
  %117 = load i8* %116, !dbg !34
  %118 = icmp ne i8 %117, 0, !dbg !34
  br i1 %118, label %119, label %120, !dbg !34

; <label>:119                                     ; preds = %109
  call void @__asan_report_store8(i64 %113), !dbg !34
  call void asm sideeffect "", ""(), !dbg !34
  unreachable, !dbg !34

; <label>:120                                     ; preds = %109
  store %struct.list_el* %110, %struct.list_el** %112, align 8, !dbg !34
  %121 = load %struct.list_el** %9, align 8, !dbg !35
  store %struct.list_el* %121, %struct.list_el** %11, align 8, !dbg !35
  br label %122, !dbg !36

; <label>:122                                     ; preds = %120
  %123 = ptrtoint i32* %13 to i64, !dbg !37
  %124 = lshr i64 %123, 3, !dbg !37
  %125 = add i64 %124, 2147450880, !dbg !37
  %126 = inttoptr i64 %125 to i8*, !dbg !37
  %127 = load i8* %126, !dbg !37
  %128 = icmp ne i8 %127, 0, !dbg !37
  br i1 %128, label %129, label %135, !dbg !37

; <label>:129                                     ; preds = %122
  %130 = and i64 %123, 7, !dbg !37
  %131 = add i64 %130, 3, !dbg !37
  %132 = trunc i64 %131 to i8, !dbg !37
  %133 = icmp sge i8 %132, %127, !dbg !37
  br i1 %133, label %134, label %135

; <label>:134                                     ; preds = %129
  call void @__asan_report_load4(i64 %123), !dbg !37
  call void asm sideeffect "", ""()
  unreachable

; <label>:135                                     ; preds = %129, %122
  %136 = load i32* %13, align 4, !dbg !37
  %137 = add nsw i32 %136, 1, !dbg !37
  store i32 %137, i32* %13, align 4, !dbg !37
  br label %46, !dbg !37

; <label>:138                                     ; preds = %59
  %139 = ptrtoint %struct.list_el** %11 to i64, !dbg !38
  %140 = lshr i64 %139, 3, !dbg !38
  %141 = add i64 %140, 2147450880, !dbg !38
  %142 = inttoptr i64 %141 to i8*, !dbg !38
  %143 = load i8* %142, !dbg !38
  %144 = icmp ne i8 %143, 0, !dbg !38
  br i1 %144, label %145, label %146, !dbg !38

; <label>:145                                     ; preds = %138
  call void @__asan_report_load8(i64 %139), !dbg !38
  call void asm sideeffect "", ""(), !dbg !38
  unreachable, !dbg !38

; <label>:146                                     ; preds = %138
  %147 = load %struct.list_el** %11, align 8, !dbg !38
  %148 = ptrtoint %struct.list_el** %9 to i64, !dbg !38
  %149 = lshr i64 %148, 3, !dbg !38
  %150 = add i64 %149, 2147450880, !dbg !38
  %151 = inttoptr i64 %150 to i8*, !dbg !38
  %152 = load i8* %151, !dbg !38
  %153 = icmp ne i8 %152, 0, !dbg !38
  br i1 %153, label %154, label %155, !dbg !38

; <label>:154                                     ; preds = %146
  call void @__asan_report_store8(i64 %148), !dbg !38
  call void asm sideeffect "", ""(), !dbg !38
  unreachable, !dbg !38

; <label>:155                                     ; preds = %146
  store %struct.list_el* %147, %struct.list_el** %9, align 8, !dbg !38
  br label %156, !dbg !39

; <label>:156                                     ; preds = %210, %155
  %157 = ptrtoint %struct.list_el** %9 to i64, !dbg !40
  %158 = lshr i64 %157, 3, !dbg !40
  %159 = add i64 %158, 2147450880, !dbg !40
  %160 = inttoptr i64 %159 to i8*, !dbg !40
  %161 = load i8* %160, !dbg !40
  %162 = icmp ne i8 %161, 0, !dbg !40
  br i1 %162, label %163, label %164, !dbg !40

; <label>:163                                     ; preds = %156
  call void @__asan_report_load8(i64 %157), !dbg !40
  call void asm sideeffect "", ""(), !dbg !40
  unreachable, !dbg !40

; <label>:164                                     ; preds = %156
  %165 = load %struct.list_el** %9, align 8, !dbg !40
  %166 = icmp ne %struct.list_el* %165, null, !dbg !40
  br i1 %166, label %167, label %212, !dbg !40

; <label>:167                                     ; preds = %164
  %168 = ptrtoint %struct.list_el** %9 to i64, !dbg !42
  %169 = lshr i64 %168, 3, !dbg !42
  %170 = add i64 %169, 2147450880, !dbg !42
  %171 = inttoptr i64 %170 to i8*, !dbg !42
  %172 = load i8* %171, !dbg !42
  %173 = icmp ne i8 %172, 0, !dbg !42
  br i1 %173, label %174, label %175, !dbg !42

; <label>:174                                     ; preds = %167
  call void @__asan_report_load8(i64 %168), !dbg !42
  call void asm sideeffect "", ""(), !dbg !42
  unreachable, !dbg !42

; <label>:175                                     ; preds = %167
  %176 = load %struct.list_el** %9, align 8, !dbg !42
  %177 = getelementptr inbounds %struct.list_el* %176, i32 0, i32 0, !dbg !42
  %178 = ptrtoint i32* %177 to i64, !dbg !42
  %179 = lshr i64 %178, 3, !dbg !42
  %180 = add i64 %179, 2147450880, !dbg !42
  %181 = inttoptr i64 %180 to i8*, !dbg !42
  %182 = load i8* %181, !dbg !42
  %183 = icmp ne i8 %182, 0, !dbg !42
  br i1 %183, label %184, label %190, !dbg !42

; <label>:184                                     ; preds = %175
  %185 = and i64 %178, 7, !dbg !42
  %186 = add i64 %185, 3, !dbg !42
  %187 = trunc i64 %186 to i8, !dbg !42
  %188 = icmp sge i8 %187, %182, !dbg !42
  br i1 %188, label %189, label %190

; <label>:189                                     ; preds = %184
  call void @__asan_report_load4(i64 %178), !dbg !42
  call void asm sideeffect "", ""()
  unreachable

; <label>:190                                     ; preds = %184, %175
  %191 = load i32* %177, align 4, !dbg !42
  %192 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ({ [4 x i8], [60 x i8] }* @.str, i32 0, i32 0, i32 0), i32 %191), !dbg !42
  %193 = ptrtoint %struct.list_el** %9 to i64, !dbg !44
  %194 = lshr i64 %193, 3, !dbg !44
  %195 = add i64 %194, 2147450880, !dbg !44
  %196 = inttoptr i64 %195 to i8*, !dbg !44
  %197 = load i8* %196, !dbg !44
  %198 = icmp ne i8 %197, 0, !dbg !44
  br i1 %198, label %199, label %200, !dbg !44

; <label>:199                                     ; preds = %190
  call void @__asan_report_load8(i64 %193), !dbg !44
  call void asm sideeffect "", ""(), !dbg !44
  unreachable, !dbg !44

; <label>:200                                     ; preds = %190
  %201 = load %struct.list_el** %9, align 8, !dbg !44
  %202 = getelementptr inbounds %struct.list_el* %201, i32 0, i32 1, !dbg !44
  %203 = ptrtoint %struct.list_el** %202 to i64, !dbg !44
  %204 = lshr i64 %203, 3, !dbg !44
  %205 = add i64 %204, 2147450880, !dbg !44
  %206 = inttoptr i64 %205 to i8*, !dbg !44
  %207 = load i8* %206, !dbg !44
  %208 = icmp ne i8 %207, 0, !dbg !44
  br i1 %208, label %209, label %210, !dbg !44

; <label>:209                                     ; preds = %200
  call void @__asan_report_load8(i64 %203), !dbg !44
  call void asm sideeffect "", ""(), !dbg !44
  unreachable, !dbg !44

; <label>:210                                     ; preds = %200
  %211 = load %struct.list_el** %202, align 8, !dbg !44
  store %struct.list_el* %211, %struct.list_el** %9, align 8, !dbg !44
  br label %156, !dbg !45

; <label>:212                                     ; preds = %164
  store i64 1172321806, i64* %14, !dbg !46
  %213 = icmp ne i64 %7, %1, !dbg !46
  br i1 %213, label %214, label %223, !dbg !46

; <label>:214                                     ; preds = %212
  %215 = add i64 %20, 0, !dbg !46
  %216 = inttoptr i64 %215 to i64*, !dbg !46
  store i64 -723401728380766731, i64* %216, !dbg !46
  %217 = add i64 %20, 8, !dbg !46
  %218 = inttoptr i64 %217 to i64*, !dbg !46
  store i64 -723401728380766731, i64* %218, !dbg !46
  %219 = add i64 %7, 120, !dbg !46
  %220 = inttoptr i64 %219 to i64*, !dbg !46
  %221 = load i64* %220, !dbg !46
  %222 = inttoptr i64 %221 to i8*, !dbg !46
  store i8 0, i8* %222, !dbg !46
  br label %228, !dbg !46

; <label>:223                                     ; preds = %212
  %224 = add i64 %20, 0, !dbg !46
  %225 = inttoptr i64 %224 to i64*, !dbg !46
  store i64 0, i64* %225, !dbg !46
  %226 = add i64 %20, 8, !dbg !46
  %227 = inttoptr i64 %226 to i64*, !dbg !46
  store i64 0, i64* %227, !dbg !46
  br label %228, !dbg !46

; <label>:228                                     ; preds = %223, %214
  ret void, !dbg !46
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

declare i32 @printf(i8*, ...) #3

define internal void @asan.module_ctor() {
  call void @__asan_init_v4()
  call void @__asan_register_globals(i64 ptrtoint ([1 x { i64, i64, i64, i64, i64, i64, i64 }]* @0 to i64), i64 1)
  ret void
}

declare void @__asan_init_v4()

declare void @__asan_report_load1(i64)

declare void @__asan_load1(i64)

declare void @__asan_report_load2(i64)

declare void @__asan_load2(i64)

declare void @__asan_report_load4(i64)

declare void @__asan_load4(i64)

declare void @__asan_report_load8(i64)

declare void @__asan_load8(i64)

declare void @__asan_report_load16(i64)

declare void @__asan_load16(i64)

declare void @__asan_report_store1(i64)

declare void @__asan_store1(i64)

declare void @__asan_report_store2(i64)

declare void @__asan_store2(i64)

declare void @__asan_report_store4(i64)

declare void @__asan_store4(i64)

declare void @__asan_report_store8(i64)

declare void @__asan_store8(i64)

declare void @__asan_report_store16(i64)

declare void @__asan_store16(i64)

declare void @__asan_report_load_n(i64, i64)

declare void @__asan_report_store_n(i64, i64)

declare void @__asan_loadN(i64, i64)

declare void @__asan_storeN(i64, i64)

declare i8* @__asan_memmove(i8*, i8*, i64)

declare i8* @__asan_memcpy(i8*, i8*, i64)

declare i8* @__asan_memset(i8*, i32, i64)

declare void @__asan_handle_no_return()

declare void @__sanitizer_cov()

declare void @__sanitizer_ptr_cmp(i64, i64)

declare void @__sanitizer_ptr_sub(i64, i64)

declare i64 @__asan_stack_malloc_0(i64, i64)

declare void @__asan_stack_free_0(i64, i64, i64)

declare i64 @__asan_stack_malloc_1(i64, i64)

declare void @__asan_stack_free_1(i64, i64, i64)

declare i64 @__asan_stack_malloc_2(i64, i64)

declare void @__asan_stack_free_2(i64, i64, i64)

declare i64 @__asan_stack_malloc_3(i64, i64)

declare void @__asan_stack_free_3(i64, i64, i64)

declare i64 @__asan_stack_malloc_4(i64, i64)

declare void @__asan_stack_free_4(i64, i64, i64)

declare i64 @__asan_stack_malloc_5(i64, i64)

declare void @__asan_stack_free_5(i64, i64, i64)

declare i64 @__asan_stack_malloc_6(i64, i64)

declare void @__asan_stack_free_6(i64, i64, i64)

declare i64 @__asan_stack_malloc_7(i64, i64)

declare void @__asan_stack_free_7(i64, i64, i64)

declare i64 @__asan_stack_malloc_8(i64, i64)

declare void @__asan_stack_free_8(i64, i64, i64)

declare i64 @__asan_stack_malloc_9(i64, i64)

declare void @__asan_stack_free_9(i64, i64, i64)

declare i64 @__asan_stack_malloc_10(i64, i64)

declare void @__asan_stack_free_10(i64, i64, i64)

declare void @__asan_poison_stack_memory(i64, i64)

declare void @__asan_unpoison_stack_memory(i64, i64)

declare void @__asan_before_dynamic_init(i64)

declare void @__asan_after_dynamic_init()

declare void @__asan_register_globals(i64, i64)

declare void @__asan_unregister_globals(i64, i64)

declare void @__sanitizer_cov_module_init(i64)

define internal void @asan.module_dtor() {
  call void @__asan_unregister_globals(i64 ptrtoint ([1 x { i64, i64, i64, i64, i64, i64, i64 }]* @0 to i64), i64 1)
  ret void
}

attributes #0 = { nounwind sanitize_address uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.asan.globals = !{!8}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/home/user/Code/calpoly-csc-projects/Testing_530/final-project/ll.c] [DW_LANG_C99]
!1 = metadata !{metadata !"ll.c", metadata !"/home/user/Code/calpoly-csc-projects/Testing_530/final-project"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 10, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, void ()* @main, null, null, metadata !2, i32 10} ; [ DW_TAG_subprogram ] [line 10] [def] [main]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/user/Code/calpoly-csc-projects/Testing_530/final-project/ll.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null}
!8 = metadata !{[4 x i8]* getelementptr inbounds ({ [4 x i8], [60 x i8] }* @.str, i32 0, i32 0), { [5 x i8]*, i32, i32 }* @.asan_loc_descr, [17 x i8]* @.str2, i1 false, i1 false}
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)"}
!12 = metadata !{i32 11, i32 11, metadata !4, null}
!13 = metadata !{i32 14, i32 4, metadata !4, null}
!14 = metadata !{i32 786688, metadata !4, metadata !"curr", metadata !5, i32 11, metadata !15, i32 0, i32 0, metadata !23} ; [ DW_TAG_auto_variable ] [curr] [line 11]
!15 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !16} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from item]
!16 = metadata !{i32 786454, metadata !1, null, metadata !"item", i32 8, i64 0, i64 0, i64 0, i32 0, metadata !17} ; [ DW_TAG_typedef ] [item] [line 8, size 0, align 0, offset 0] [from list_el]
!17 = metadata !{i32 786451, metadata !1, null, metadata !"list_el", i32 3, i64 128, i64 64, i32 0, i32 0, null, metadata !18, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [list_el] [line 3, size 128, align 64, offset 0] [def] [from ]
!18 = metadata !{metadata !19, metadata !21}
!19 = metadata !{i32 786445, metadata !1, metadata !17, metadata !"val", i32 4, i64 32, i64 32, i64 0, i32 0, metadata !20} ; [ DW_TAG_member ] [val] [line 4, size 32, align 32, offset 0] [from int]
!20 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!21 = metadata !{i32 786445, metadata !1, metadata !17, metadata !"next", i32 5, i64 64, i64 64, i64 64, i32 0, metadata !22} ; [ DW_TAG_member ] [next] [line 5, size 64, align 64, offset 64] [from ]
!22 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !17} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from list_el]
!23 = metadata !{i64 2}
!24 = metadata !{i32 786688, metadata !4, metadata !"head", metadata !5, i32 11, metadata !15, i32 0, i32 0, metadata !23} ; [ DW_TAG_auto_variable ] [head] [line 11]
!25 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 12, metadata !20, i32 0, i32 0, metadata !23} ; [ DW_TAG_auto_variable ] [i] [line 12]
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
