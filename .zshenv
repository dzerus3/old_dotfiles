# Sets XDG folder environments if they are not set already.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_DOWNLOAD_DIR="$HOME/dls"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pics"
export XDG_VIDEOS_DIR="$HOME/video"
export XDG_PUBLICSHARE_DIR="$HOME/pub"

# Commented because I don't use these
#export XDG_TEMPLATES_DIR="$HOME/Templates"
#export XDG_DESKTOP_DIR="$HOME/Desktop"

# Moves zsh config to config folder
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
