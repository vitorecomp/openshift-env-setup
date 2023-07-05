_show_help() {
    echo "Usage: script.sh [options]"
    echo "Options:"
    echo "  -a      Perform action A"
    echo "  -b      Perform action B"
    echo "  -h      Display this help message"
}

parse_commands() {
    touch $1/application.conf
    # convert the arguments
    while getopts "abh" opt; do
        case $opt in
        a)
            echo "Performing action A"
            ;;
        b)
            echo "Performing action B"
            ;;
        h)
            _show_help
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            _show_help
            exit 1
            ;;
        esac
    done
}

_validate_gum(){
    # test if gum is installed
    if ! command -v gum &> /dev/null
    then
        echo "gum could not be found. Please install gum to continue."
        echo "go install github.com/charmbracelet/gum@latest"
        exit
    fi
}


_validate_oc(){
    #test if oc is installed
    if ! command -v oc &> /dev/null
    then
        echo "oc could not be found. please install to continue."
        echo "https://docs.openshift.com/container-platform/4.7/cli_reference/openshift_cli/getting-started-cli.html"
        exit
    fi
}

validate_installation_commands() {
    # validate gum
    _validate_gum

    # validate oc
    _validate_oc

    #validate kustumize
    _validate_kustomize

    # validate kubectl
    _validate_kubectl

}