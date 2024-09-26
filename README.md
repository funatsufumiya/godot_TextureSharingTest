# Godot TextureSharingTest

Realtime Texture Share example using [ZMQ](https://github.com/funatsufumiya/godot_zeromq/), [GVTextureSerializer](https://github.com/funatsufumiya/godot_gv_texture_serializer). Transferring bytes size is 1/40 (max) smaller than normal RGBA8 texture transport.

(en)

## Build

- Using [GodotEnv](https://github.com/chickensoft-games/GodotEnv) for managing addons.
  - (You can install GodotEnv itself by `dotnet tool install --global Chickensoft.GodotEnv`. NOTE: Requires .NET 7 SDK or later to be installed first.)
- After installing GodotEnv, run `godotenv addons install` in the project folder.
- Then, open the project (`project.godot`) in Godot.

NOTE: If you want to add an addon, do not put it directly in the addons folder. Instead, edit `addons.jsonc` and run `godotenv addons install`. (If an error occurs, try deleting the contents of the `addons` folder or deleting the `.addons` cache folder.)

(ja)

## ビルド

<!-- - 各種アドオンを使っているので、最初に `git submodule update --init --recursive --recommend-shallow --depth 1` してください。 -->
- [GodotEnv](https://github.com/chickensoft-games/GodotEnv)をアドオン管理に使っています。
  - (GodotEnv自体は、`dotnet tool install --global Chickensoft.GodotEnv` でインストールできます。※ .NET 7 SDK 以降のインストールが先に必要。)
- まずGodotEnvをインストールしたあと、`godotenv addons install`　をプロジェクトフォルダ上で実行してください。
- その後、Godotでプロジェクト (`project.godot`) を開けばOKです。

※ アドオンを追加したい場合は、addonsフォルダに直接入れるのではなくて、`addons.jsonc` を編集して `godotenv addons install` してください。 (エラーが起きる場合は、`addons`フォルダの中身を一度削除したり、`.addons`というキャッシュフォルダを消してみてください。)
