**.so & .h to apt**
| .so  | .h  | apt | tips | errors
|:---:|:---:|:----:|:----:|:----:|
| libMIOpen |      | 	miopen-hip | rocm | Could not load dynamic library 'libMIOpen.so'; dlerror: libMIOpen.so: cannot open shared object file: No such file |
| libMIOpen.so.1| | miopen-hip | rocm	| Could not load dynamic library 'libMIOpen.so'; dlerror: libMIOpen.so: cannot open shared object file: No such file |
| libamdhip64.so| |	hip-rocclr	| rocm>=3.5	| ImportError: libamdhip64.so: cannot open shared object file: No such file or directory |
| libamdhip64.so.3| | hip-rocclr | rocm>=3.5 | ImportError: libamdhip64.so.3: cannot open shared object file: No such file or directory |
| libmcwamp.so| | hcc | rocm |	ImportError: libmcwamp.so: cannot open shared object file: No such file or directory |
| libmcwamp.so.2| | hcc |	rocm>=2.8	| ImportError: libmcwamp.so.2: cannot open shared object file: No such file or directory |
| libmcwamp.so.3| | hcc |	rocm>=3.0 |	ImportError: libmcwamp.so.3: cannot open shared object file: No such file or directory |
| libstdc++.so.6| |     | rocm4.0.1 | ImportError: /lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.29' not found  |

**symbol error to whl**

|symbol	whl	Tips|
|:--:|
|undefined symbol: _ZN8hip_impl19Bundled_code_header13magic_string_E	tensorflow-rocm	try 1.13.3 or later version|
|undefined symbol: _ZN8hip_impl7kernarg6resizeEm	tensorflow-rocm	try 1.13.3 or later version|

**some rocm and tensorflow-rocm realeases**

| rocm | tf | python | tips |
|:--:|:--:|:--:|:--:|
| 1.9.3 |	1.8.0 |	<=3.5	| |
|1.9.3	| 1.10.0 |	<=3.5	| |
|1.9.3 |	1.10.1 |	<=3.6	| |
|1.9.3 |	1.11.0 |	<=3.6	| |
|1.9.3 |	1.12.0 |	<=3.6	| |
|1.9.3 |	1.12.0 |	<=3.6	| |
|2.3 |	1.13.2 |	<=3.7	| |
|2.5 |	1.13.3 |	<=3.7	| |
|2.7 |	1.14.1 |	<=3.7	| |
|2.7 |	1.14.2 |	<=3.7	| sudo ln -s ./libmcwamp.so /opt/rocm/hcc/lib/libmcwamp.so.2 |
|2.7 |	1.14.3 |	<=3.7	| sudo ln -s ./libmcwamp.so /opt/rocm/hcc/lib/libmcwamp.so.2 |
|2.7 |	1.14.4 |	<=3.7	| sudo ln -s ./libmcwamp.so /opt/rocm/hcc/lib/libmcwamp.so.2 |
|2.8 |	1.14.2 |	<=3.7	| |
|2.8 |	1.14.3 |	<=3.7	| |
|2.8 |	1.14.4 |	<=3.7	| |
|2.9 |	1.14.2 |	<=3.7	| |
|2.9 |	1.14.3 |	<=3.7	| |
|2.9 |	1.14.4 |	<=3.7	| |
|2.10 |	1.14.4 |	<=3.7	| |
|2.10 |	1.15.0 |	<=3.7	| |
|2.10 |	2.0.1 |	<=3.7	| |
|3.0 |	1.14.5 |	<=3.7 | |
|3.0 |	1.15.1 |	<=3.7 | |
|3.0 |	2.0.2 |	<=3.7	| |
|3.1.1 |	1.14.6 |	<=3.7	| |
|3.1.1 |	1.15.2 |	<=3.7	| |
|3.1.1 |	1.15.3 |	<=3.7 |	|
|3.1.1 |	2.0.3 |	<=3.7	| |
|3.1.1 |	2.0.4 |	<=3.7	| |
|3.1.1 |	2.1.0 |	<=3.7	| |
|3.1.1 |	2.1.1 |	<=3.7	| |
|3.3 |	1.15.3 |	<=3.7 |	|
|3.3 |	2.0.3 |	<=3.7	| |
|3.3 |	2.0.4 |	<=3.7	| |
|3.3 |	2.1.0 |	<=3.7	| |
|3.3 |	2.1.1 |	<=3.7	| |
|3.3 |	2.2.rc5 |	<=3.8	| |
|3.5.1 |	1.15.4 |	<=3.7 | |
|3.5.1 |	2.1.2 |	<=3.7	| |
|3.5.1 |	2.2.0 | <=3.8 |	|

**Reference:**
http://www.yangwaiyang.com/so2lib.html
