DISPLAY_INFO_BEGIN="\e[7m"
DISPLAY_INFO_END="\e[27m"

DISPLAY_WARNING_BEGIN="\e[21m"
DISPLAY_WARNING_END="\e[00m"

DISPLAY_GRAY_BEGIN="\e[2m"
DISPLAY_GRAY_END="\e[22m"


display_info() {
    echo; echo -e "$DISPLAY_INFO_BEGIN $@ $DISPLAY_INFO_END"
}

display_warning() {
    echo; echo -e "$DISPLAY_WARNING_BEGIN $@ $DISPLAY_WARNING_END"
}

display_gray() {
    echo; echo -e "$DISPLAY_GRAY_BEGIN $@ $DISPLAY_GRAY_END"
}