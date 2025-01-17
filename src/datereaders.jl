
try
    cd("C:/Users/francis.smart.ctr/GitDir/SoftDates.jl")
catch
   cd("C:/Users/Francis Smart/Documents/GitHub/SoftDates.jl")
end
using Pkg
Pkg.activate(".")
using Pkg, Dates, DataFrames, Distributions, CSV, StatsBase, IterTools

##############################################################################
# Read in Dates

# Load the dates without errors first
dtrange = CSV.read("sampledata/SampleDateRanges.csv")

DTStart = dtrange[:Start]
DTEnd   = dtrange[:End]
DTtext  = dtrange[:Text]

x = softdate(DTtext[1], Date(DTStart[1]), Date(DTEnd[1]))
[println(y) for y in x[:txt]]

function trunk(x,n=60)
 x = replace(x, "\n\r"=>"]")
 join([x[1:min(length(x), n)], repeat(" ", n-min(length(x), n))])
end
trunk(x[:txt][1])

#presenting problems
# 459
# 463
# 465 # range not Interprettable! What happenned to "17 12 16 Maecenas tellus metus, venenatis ut faucibus in, eleifend at ipsum Nullam enim nibh, rhoncus eu odio nec, condimentum ele"

i = 465
while i <= length(DTtext)
  println("\n------Input $i -- Start Date $(Date(DTStart[i])) till $(Date(DTEnd[i]))------")
  [println(trunk(tx,130)) for tx in split(DTtext[i], r"\n\r|\r\n|\r") if strip(tx) != ""]
  println("------SoftDates-------")
   x = softdate(DTtext[i], dtstart = Date(DTStart[i]), dtend = Date(DTEnd[i]))
  sort!(x, :date)
  [println("$(x[:date][j]) || $(trunk(x[:txt][j], 130)) || $(x[:indt][j]) || $(x[:score][j])") for j in 1:size(x)[1]]
  println()
  print("Type \"break\" or enter to continue:")
  userinput = readline(stdin)
  (length(userinput)>0) && (userinput[1:1] ∈ ["b"]) && break
  global i
  i += 1
end

x = "10 14 16 through 16 12 16"
((x,I...)->replace(x, r"([0-9]{2}).*?([0-9]{2}).*?(1[0-9])(.*)([0-9]{2}).*?([0-9]{2}).*?\3"=>s"\1 \2 20\3 \4 \5 \6 20\3"))(x)
