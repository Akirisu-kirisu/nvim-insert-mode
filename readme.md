
## Overview

This Neovim configuration provides a set of custom functions and key mappings designed to improve text manipulation and navigation within the editor. It includes functionalities for dynamic text replacement, efficient line hopping, and seamless mode transitions, catering to both beginners and experienced users.
Key Features

    * Dynamic Text Replacement:
        Users can replace text efficiently based on their input, allowing for quick adjustments without leaving insert mode.
        Supports varying lengths of replacement text, accommodating different editing needs.

    * Anywhere Functionality:
        Integrates with the Hop plugin to enable quick navigation within lines and across the buffer.
        Offers different hopping modes based on the context (e.g., empty lines vs. current line), making it versatile for various editing scenarios.

    * Seamless Mode Transition:
        Implements a wrapper function to switch to normal mode briefly (<C-o>), ensuring that the user remains focused on their task without manual mode switching.
        This functionality helps in performing complex editing tasks without disrupting the flow of text input.

    * User-Friendly Key Mappings:
        Configurable key mappings make it easy to access the new functionalities without needing to memorize complex commands.
        Mappings are intuitive, allowing users to quickly adapt to the configuration.

    * Modular Structure:
        The configuration is organized in a modular way, making it easy to extend or modify. Users can add new functions or adjust existing ones as their editing needs evolve.

## Todo
<A-r>
    "1. The <A-r> command should function like a vertical hop, 
        allowing the selection of empty lines, with an optional width of 80 characters."
     2. like precognation that uses gutter lines
     3. has search history select prev and next history
     optional:
        ui

