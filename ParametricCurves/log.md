
julia> include("ParametricCurves/Pull/Chase.jl")
Could not start dynamically linked executable: /home/ace/.julia/artifacts/fdb14f7b1bf6766687af4e3951c4d982cee66086/bin/ffmpeg
NixOS cannot run dynamically linked executables intended for generic
linux environments out of the box. For more information, see:
https://nix.dev/permalink/stub-ld
ERROR: LoadError: IOError: write: broken pipe (EPIPE)
Stacktrace:
  [1] uv_write(s::Base.PipeEndpoint, p::Ptr{UInt8}, n::UInt64)
    @ Base ./stream.jl:1066
  [2] unsafe_write(s::Base.PipeEndpoint, p::Ptr{UInt8}, n::UInt64)
    @ Base ./stream.jl:1120
  [3] unsafe_write
    @ ./io.jl:698 [inlined]
  [4] write
    @ ./io.jl:721 [inlined]
  [5] recordframe!(io::VideoStream)
    @ Makie ~/.julia/packages/Makie/YkotL/src/ffmpeg-util.jl:290
  [6] Record(func::var"#15#16", figlike::Figure, iter::Tuple{…}; kw_args::@Kwargs{…})
    @ Makie ~/.julia/packages/Makie/YkotL/src/recording.jl:174
  [7] record(func::Function, figlike::Figure, path::String, iter::Tuple{Vector{…}, Vector{…}}; kw_args::@Kwargs{framerate::Int64})
    @ Makie ~/.julia/packages/Makie/YkotL/src/recording.jl:154
  [8] top-level scope
    @ ~/SynthStuff/Dev/Numerical/NumericalAlgorithmsJulia/ParametricCurves/Pull/Chase.jl:31
  [9] include(fname::String)
    @ Base.MainInclude ./client.jl:489
 [10] top-level scope
    @ REPL[7]:1
in expression starting at /home/ace/SynthStuff/Dev/Numerical/NumericalAlgorithmsJulia/ParametricCurves/Pull/Chase.jl:31
Some type information was truncated. Use `show(err)` to see complete types.