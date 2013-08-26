# Updating `plist` Files

 1. Make your chosed preference changes in your app. Try to keep one logical change per commit.
 2. Quit the app to make sure it has updated its `plist`.
 3. Copy the `plist` file over the existing one in this directory:

    ```shell
    cp ~/Library/Preferences/com.googlecode.iterm2.plist modules/spp/files/
    ```

 4. Convert the `plist` file to XML format:

    ```shell
    plutil -convert xml1 modules/spp/files/com.googlecode.iterm2.plist
    ```

    This lets us see useful diffs between versions.

 5. Add, commit and push as normal.
