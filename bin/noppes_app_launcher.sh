
cmd="jgmenu --simple"

# gcompris
applist="Gcompris,gcompris-qt,gcompris-qt"

# $HOME/roms/nes
platform="nes"
app="nestopia -f"
for dir in $HOME/roms/$platform/*/; do
	local_dir=${dir%*/}
	entry=${local_dir##*/}
	newline="${entry},${app} \"${dir}${entry}.${platform}\",${dir}${entry}.png"
	applist="${applist}\n${newline}"
done

# $HOME/roms/sfc
platform="sfc"
app="snes9x -fullscreen -xvideo"
for dir in $HOME/roms/$platform/*/; do
	local_dir=${dir%*/}
	entry=${local_dir##*/}
	newline="${entry},${app} \"${dir}${entry}.${platform}\",${dir}${entry}.png"
	applist="${applist}\n${newline}"
done

echo -e $applist | $cmd
