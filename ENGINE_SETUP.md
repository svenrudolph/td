# Engine Installation Guide

This project uses the Godot Engine. Follow these steps to install the engine in a clean Linux environment so that the project can run or be tested from the command line.

1. **Download Godot 4.2.2**
   ```bash
   wget https://github.com/godotengine/godot/releases/download/4.2.2-stable/Godot_v4.2.2-stable_linux.x86_64.zip
   ```

2. **Extract the archive**
   ```bash
   unzip Godot_v4.2.2-stable_linux.x86_64.zip
   ```

3. **Install the binary**
   ```bash
   chmod +x Godot_v4.2.2-stable_linux.x86_64
   sudo mv Godot_v4.2.2-stable_linux.x86_64 /usr/local/bin/godot
   ```
   This places the `godot` executable in your `PATH`.

4. **Verify the installation**
   ```bash
   godot --version
   ```
   You should see a version string like `4.2.2.stable.official`.

5. **Run the project headlessly for tests**
   From the repository root:
   ```bash
   godot --headless --path . --quit
   ```
   This loads the project and exits immediately, useful for ensuring assets load correctly in CI environments.

These steps can be repeated whenever the environment is reset to ensure the engine is available.
