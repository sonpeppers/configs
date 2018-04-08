#!/bin/bash

source "$(pwd)/colors.sh"

function echo_and_run {
	echo -e "${LIGHT_CYAN}\$ $@${NC}"
	eval "$@"
}

function echo_and_run_silent {
	echo -e "${LIGHT_CYAN}\$ $@${NC}"
	eval "$@" 2>/dev/null
}

function echo_and_run_all {
	cmds=("$@")
	for cmd in "${cmds[@]}";
	do
		echo_and_run "${cmd[@]}"
	done
}

function display_generic {
	echo ""
	echo -e "${LIGHT_BLUE}*************************************************************************${NC}"
	echo -e "${LIGHT_BLUE}*${NC} ${YELLOW}${1} ...${NC}"
	echo -e "${LIGHT_BLUE}*************************************************************************${NC}"
	echo ""
}

function display_remove {
	echo ""
	echo -e "${LIGHT_BLUE}*************************************************************************${NC}"
	echo -e "${LIGHT_BLUE}*${NC} ${YELLOW}Removing $@ ...${NC}"
	echo -e "${LIGHT_BLUE}*************************************************************************${NC}"
	echo ""
}

function display_install {
	echo ""
	echo -e "${LIGHT_BLUE}*************************************************************************${NC}"
	echo -e "${LIGHT_BLUE}*${NC} ${YELLOW}Installing $@ ...${NC}"
	echo -e "${LIGHT_BLUE}*************************************************************************${NC}"
	echo ""
}

function display_alias {
	echo ""
	echo -e "${LIGHT_BLUE}*************************************************************************${NC}"
	echo -e "${LIGHT_BLUE}*${NC} ${YELLOW}Adding ${LIGHT_YELLOW}$1${NC} ${YELLOW}as an alias for${NC} ${LIGHT_YELLOW}${@:2}${NC} ${YELLOW}...${NC}"
	echo -e "${LIGHT_BLUE}*************************************************************************${NC}"
	echo ""
}
