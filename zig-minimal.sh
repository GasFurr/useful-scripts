#!/bin/bash

# --- Script Configuration ---
# Default project name if none is provided
DEFAULT_PROJECT_NAME="zig_project"

# --- Functions ---

# Function to display help message
show_help() {
    echo "Usage: $0 [project_name]"
    echo ""
    echo "Creates a minimal Zig 'Hello World' project setup."
    echo ""
    echo "Arguments:"
    echo "  project_name  Optional. The name for your new project directory."
    echo "                If not provided, it defaults to '$DEFAULT_PROJECT_NAME'."
    echo ""
    echo "Example:"
    echo "  $0 my_hello_app"
    echo "  $0"
}

# Function to create src/main.zig
create_main_zig() {
    local project_dir="$1"
    local main_zig_path="${project_dir}/src/main.zig"
    echo "const std = @import(\"std\");

pub fn main() !void {
    std.debug.print(\"Hello, world!\n\", .{});
}
" > "$main_zig_path"
    echo "  Created ${main_zig_path}"
}

# Function to create minimal build.zig
create_build_zig() {
    local project_dir="$1"
    local build_zig_path="${project_dir}/build.zig"
    echo "const std = @import(\"std\");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Create an executable artifact
    const exe = b.addExecutable(.{
        .name = \"${project_dir}\", // Name of the executable will match the project directory
        .root_source_file = b.path(\"src/main.zig\"),
        .target = target,
        .optimize = optimize,
    });

    // Install the executable
    b.installArtifact(exe);

}
" > "$build_zig_path"
    echo "  Created ${build_zig_path}"
}

# --- Main Script Logic ---

# Check for help argument
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Determine project name
PROJECT_NAME="${1:-$DEFAULT_PROJECT_NAME}" # Use provided name or default

echo "Creating minimal Zig project: ${PROJECT_NAME}"

# Create project directory
if [ -d "$PROJECT_NAME" ]; then
    echo "Error: Directory '$PROJECT_NAME' already exists. Please choose a different name or remove the existing directory."
    exit 1
fi
mkdir "$PROJECT_NAME"
echo "  Created directory: ${PROJECT_NAME}"

# Create src directory
mkdir "${PROJECT_NAME}/src"
echo "  Created directory: ${PROJECT_NAME}/src"

# Create src/main.zig
create_main_zig "$PROJECT_NAME"

# Create build.zig
create_build_zig "$PROJECT_NAME"

echo ""
echo "Minimal Zig project '${PROJECT_NAME}' created successfully!"
