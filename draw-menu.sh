#!/bin/sh
 
## draw-menu.sh ## simply a function to draw the menu 
draw_menu(){
#=============#
HORZ="~"
VERT="|"
CORNER_CHAR="o"
E_SIZE="increase window size"
R=2      # Row
C=3      # Column
H=10     # Height
W=70     # Width 
col=1    # Color (red)
BOX_HEIGHT=`expr $H - 1`   #  -1 correction needed because angle char "+"
BOX_WIDTH=`expr $W - 1`    #+ is a part of both box height and width.
T_ROWS=`tput lines`        #  Define current terminal dimension 
T_COLS=`tput cols`         #+ in rows and columns.
#=============#
# will it fit?
if [ $R -lt 1 ] || [ $R -gt $T_ROWS ]||
	[ $C -lt 1 ] || [ $C -gt $T_COLS ]||
	[ `expr $R + $BOX_HEIGHT + 1` -gt $T_ROWS ]||
	[ `expr $C + $BOX_WIDTH + 1` -gt $T_COLS ]||
	[ $H -lt 1 ] || [ $W -lt 1 ]; then
   echo -e "$e_error $E_SIZE"; return 0;
fi
# Function within a function.
plot_char(){                       
   echo -e "\x1b[${1};${2}H"$3
}
# Set title color, if defined.
echo -ne "\x1b[3${col}m"              
# Draw vertical lines using plot_char function.
count=1                                         
for (( r=$R; count<=$BOX_HEIGHT; r++)); do      
  	plot_char $r $C $VERT;
	case $count in
	    1 ) echo -e "    ""\x1b[01m$s_title\x1b[0m"; ;;
	    2 ) echo -e "    g)gui-tools.sh"; ;;
	    3 ) echo -e "    l)lamp.sh"; ;;
	    4 ) echo -e "    n)nginx.sh"; ;;
	    8 ) echo -e "    q)quit"; ;;
	esac  
	let count=count+1;
done 
count=1
c=`expr $C + $BOX_WIDTH`
for (( r=$R; count<=$BOX_HEIGHT; r++)); do
  plot_char $r $c $VERT
  let count=count+1
done 
#  Draw horizontal lines using plot_char function.
count=1                                        
for (( c=$C; count<=$BOX_WIDTH; c++)); do      
  plot_char $R $c $HORZ
  let count=count+1
done 
count=1
r=`expr $R + $BOX_HEIGHT`
for (( c=$C; count<=$BOX_WIDTH; c++)); do
  plot_char $r $c $HORZ
  let count=count+1
done 
# Draw box angles.
plot_char $R $C $CORNER_CHAR
plot_char $R `expr $C + $BOX_WIDTH` $CORNER_CHAR
plot_char `expr $R + $BOX_HEIGHT` $C $CORNER_CHAR
plot_char `expr $R + $BOX_HEIGHT` `expr $C + $BOX_WIDTH` $CORNER_CHAR
#  Restore old colors.
echo -ne "\x1b[0m"
#  Put the prompt at bottom of the terminal.
P_ROWS=`expr $T_ROWS - 1`    
echo -e "\x1b[${P_ROWS};1H"
}      