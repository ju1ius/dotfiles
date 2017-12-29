onedark_black="#282c34"
onedark_blue="#61afef"
onedark_yellow="#e5c07b"
onedark_red="#e06c75"
onedark_white="#aab2bf"
onedark_green="#98c379"
onedark_visual_grey="#3e4452"
onedark_comment_grey="#5c6370"

set -gq status on
set -gq status-justify left

set -gq status-left-length 100
set -gq status-right-length 100
set -gq status-right-attr none

set -gq message-fg $onedark_white
set -gq message-bg $onedark_black

set -gq message-command-fg $onedark_white
set -gq message-command-bg $onedark_black

set -gq status-attr none
set -gq status-left-attr none

setw -gq window-status-fg $onedark_black
setw -gq window-status-bg $onedark_black
setw -gq window-status-attr none

setw -gq window-status-activity-bg $onedark_black
setw -gq window-status-activity-fg $onedark_black
setw -gq window-status-activity-attr none

setw -gq window-status-separator ""

set -gq window-style "fg=$onedark_comment_grey,bg=$onedark_black"
set -gq window-active-style "fg=$onedark_white,bg=$onedark_black"

set -gq pane-border-fg $onedark_white
set -gq pane-active-border-fg $onedark_white

set -gq display-panes-active-colour $onedark_yellow
set -gq display-panes-colour $onedark_blue

set -gq status-bg $onedark_black
set -gq status-fg $onedark_white

set -gq @prefix_highlight_fg $onedark_black
set -gq @prefix_highlight_bg $onedark_green
set -gq @prefix_highlight_copy_mode_attr "fg=$onedark_black,bg=$onedark_green"
set -gq @prefix_highlight_output_prefix " ❯ "

date_widget="#[fg=$onedark_white,bg=$onedark_black,nounderscore,noitalics]%R %d/%m/%Y"
host_widget="#[fg=$onedark_black,bg=$onedark_green,bold] #h"
status_widgets="#[fg=$onedark_white, bg=$onedark_visual_grey] "
session_widget="#[fg=$onedark_visual_grey,bg=$onedark_green,bold] #S #{prefix_highlight}"

set -gq status-right "${date_widget} ${status_widgets} ${host_widget} "
set -gq status-left "${session_widget}"

set -gq window-status-format "#[fg=$onedark_white,bg=$onedark_black] #I #W "
set -gq window-status-current-format "#[fg=$onedark_white,bg=$onedark_visual_grey,nobold] #I #W "
