#set terminal x11 persist enhanced
#
# Output to xfig to set the correct colors and get aligned type. Then
# export to MetaPost:
#
#   mpost file.mp && mv file.0 file.mps
#
set terminal fig color textspecial metric size 12 5
set output "chart_javascript_size.fig"

set yrange [0:300]
set auto x
unset key
set xtics nomirror
set ytics nomirror
#set border 3 front linetype -1 linewidth 1.000
unset border
unset mxtics

set style data histogram
set style histogram rowstacked

set style fill solid
set boxwidth 0.75

plot "chart_javascript_size.dat" using 2:xtic(1) linetype rgb "#8D9965"
