BASE_LOCALIZATION_FILE_PATH=TinkerBell/Resources/Base.lproj/Localizable.strings
L10N_FILE_PATH=TinkerBell/Resources/L10n.swift
ASSETS_FILE_PATH=TinkerBell/Resources/Assets.xcassets
UIIMAGE_EXT_FILE_PATH=TinkerBell/Resources/GeneratedUIImage.swift

echo "Updateing..."

swiftgen strings -t flat-swift3 $BASE_LOCALIZATION_FILE_PATH --output $L10N_FILE_PATH
swiftgen xcassets -t swift3 $ASSETS_FILE_PATH --output $UIIMAGE_EXT_FILE_PATH

echo "Updated"
