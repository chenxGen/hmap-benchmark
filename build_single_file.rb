# !/usr/bin/ruby
# usage:  ruby build_single_file.rb --times=120

require './print_table.rb'

if ARGV.size() == 0
  puts 'Usage: $ruby build_single_file.rb --times=120'
  return
end

args=ARGV.first.split('=')
count=100
if args != nil && args.size == 2
  if args.first == '--times'
    count=args.last.to_i
  end
end

PROJECT_ROOT=Dir.pwd + '/app'
HOME=Dir.home
DERIVED_DATA_ROOT=HOME+'/Library/Developer/Xcode/DerivedData/'
CACHE_PATH=Dir.glob(DERIVED_DATA_ROOT + 'app' + '*').first
if CACHE_PATH == nil
  puts 'cache path not found'
  return
end

BUILD_COMMAND_WITH_HMAP="/opt/llvm/llvm_xcode/Debug/bin/clang -x objective-c -target x86_64-apple-ios10.0-simulator -fmessage-length=0 -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit=0 -std=gnu11 -fobjc-arc -fobjc-weak -fmodules -gmodules -fmodules-cache-path=#{HOME}/Library/Developer/Xcode/DerivedData/ModuleCache.noindex -fmodules-prune-interval=86400 -fmodules-prune-after=345600 -fbuild-session-file=#{HOME}/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation -fmodules-validate-once-per-build-session -Wnon-modular-include-in-framework-module -Werror=non-modular-include-in-framework-module -Wno-trigraphs -fpascal-strings -O0 -fno-common -Wno-missing-field-initializers -Wno-missing-prototypes -Werror=return-type -Wno-documentation -Wunreachable-code -Wno-implicit-atomic-properties -Werror=deprecated-objc-isa-usage -Wno-objc-interface-ivars -Werror=objc-root-class -Wno-arc-repeated-use-of-weak -Wimplicit-retain-self -Wduplicate-method-match -Wno-missing-braces -Wparentheses -Wswitch -Wunused-function -Wno-unused-label -Wno-nonportable-include-path -Wno-incompatible-property-type -Wno-macro-redefined -Wno-unused-parameter -Wunused-variable -Wunused-value -Wempty-body -Wuninitialized -Wconditional-uninitialized -Wno-unknown-pragmas -Wno-shadow -Wno-four-char-constants -Wno-conversion -Wconstant-conversion -Wint-conversion -Wbool-conversion -Wenum-conversion -Wno-float-conversion -Wnon-literal-null-conversion -Wobjc-literal-conversion -Wshorten-64-to-32 -Wpointer-sign -Wno-newline-eof -Wno-selector -Wno-strict-selector-match -Wundeclared-selector -Wdeprecated-implementations -DDEBUG=1 -DCOCOAPODS=1 -DDEBUG=1 -DDEBUG=1 -DNSLOGGER_WAS_HERE=1 -DNSLOGGER_BUILD_USERNAME=Paul -DDEBUG=1 -DPB_FIELD_32BIT=1 -DPB_NO_PACKED_STRUCTS=1 -DPB_ENABLE_MALLOC=1 -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator14.2.sdk -fasm-blocks -fstrict-aliasing -Wprotocol -Wno-deprecated-declarations -g -Wno-sign-conversion -Winfinite-recursion -Wcomma -Wblock-capture-autoreleasing -Wno-strict-prototypes -Wno-semicolon-before-method-body -Wunguarded-availability -fobjc-abi-version=2 -fobjc-legacy-dispatch -iquote #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/app-generated-files.hmap -I#{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/app-own-target-headers.hmap -I#{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/app-all-non-framework-target-headers.hmap -ivfsoverlay #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/all-product-headers.yaml -iquote #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/app-project-headers.hmap -I#{CACHE_PATH}/Build/Products/Debug-iphonesimulator/include -I#{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/DerivedSources-normal/x86_64 -I#{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/DerivedSources/x86_64 -I#{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/DerivedSources -F#{CACHE_PATH}/Build/Products/Debug-iphonesimulator -F/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks -F#{PROJECT_ROOT}/Pods/Fabric/iOS -F#{PROJECT_ROOT}/Pods/Realm/core -iframework /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator14.2.sdk/Developer/Library/Frameworks -fmodule-map-file=#{PROJECT_ROOT}/Pods/Headers/Public/SSZipArchive/SSZipArchive.modulemap -fmodule-map-file=#{PROJECT_ROOT}/Pods/Headers/Public/yoga/Yoga.modulemap -Wno-nullability-completeness -I #{PROJECT_ROOT}/Pods/Pods-app.hmap -MMD -MT dependencies -MF #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/Objects-normal/x86_64/TestObject0.d --serialize-diagnostics #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/Objects-normal/x86_64/TestObject0.dia -c #{PROJECT_ROOT}/app/classes/TestObject0.m -o #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/Objects-normal/x86_64/TestObject0.o > hmap_build_log"

BUILD_COMMAND_WITH_SEARCH_DIR="/opt/llvm/llvm_xcode/Debug/bin/clang -x objective-c -target x86_64-apple-ios10.0-simulator -fmessage-length=0 -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit=0 -std=gnu11 -fobjc-arc -fobjc-weak -fmodules -gmodules -fmodules-cache-path=#{HOME}/Library/Developer/Xcode/DerivedData/ModuleCache.noindex -fmodules-prune-interval=86400 -fmodules-prune-after=345600 -fbuild-session-file=#{HOME}/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation -fmodules-validate-once-per-build-session -Wnon-modular-include-in-framework-module -Werror=non-modular-include-in-framework-module -Wno-trigraphs -fpascal-strings -O0 -fno-common -Wno-missing-field-initializers -Wno-missing-prototypes -Werror=return-type -Wno-documentation -Wunreachable-code -Wno-implicit-atomic-properties -Werror=deprecated-objc-isa-usage -Wno-objc-interface-ivars -Werror=objc-root-class -Wno-arc-repeated-use-of-weak -Wimplicit-retain-self -Wduplicate-method-match -Wno-missing-braces -Wparentheses -Wswitch -Wunused-function -Wno-unused-label -Wno-nonportable-include-path -Wno-incompatible-property-type -Wno-macro-redefined -Wno-unused-parameter -Wunused-variable -Wunused-value -Wempty-body -Wuninitialized -Wconditional-uninitialized -Wno-unknown-pragmas -Wno-shadow -Wno-four-char-constants -Wno-conversion -Wconstant-conversion -Wint-conversion -Wbool-conversion -Wenum-conversion -Wno-float-conversion -Wnon-literal-null-conversion -Wobjc-literal-conversion -Wshorten-64-to-32 -Wpointer-sign -Wno-newline-eof -Wno-selector -Wno-strict-selector-match -Wundeclared-selector -Wdeprecated-implementations -DDEBUG=1 -DCOCOAPODS=1 -DDEBUG=1 -DDEBUG=1 -DNSLOGGER_WAS_HERE=1 -DNSLOGGER_BUILD_USERNAME=Paul -DDEBUG=1 -DPB_FIELD_32BIT=1 -DPB_NO_PACKED_STRUCTS=1 -DPB_ENABLE_MALLOC=1 -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator14.2.sdk -fasm-blocks -fstrict-aliasing -Wprotocol -Wno-deprecated-declarations -g -Wno-sign-conversion -Winfinite-recursion -Wcomma -Wblock-capture-autoreleasing -Wno-strict-prototypes -Wno-semicolon-before-method-body -Wunguarded-availability -fobjc-abi-version=2 -fobjc-legacy-dispatch -iquote #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/app-generated-files.hmap -I#{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/app-own-target-headers.hmap -I#{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/app-all-non-framework-target-headers.hmap -ivfsoverlay #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/all-product-headers.yaml -iquote #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/app-project-headers.hmap -I#{CACHE_PATH}/Build/Products/Debug-iphonesimulator/include -I#{PROJECT_ROOT}/Pods/Headers/Public -I#{PROJECT_ROOT}/Pods/Headers/Public/AFNetworking -I#{PROJECT_ROOT}/Pods/Headers/Public/Appirater -I#{PROJECT_ROOT}/Pods/Headers/Public/Aspects -I#{PROJECT_ROOT}/Pods/Headers/Public/AutoCompleteSuffixView -I#{PROJECT_ROOT}/Pods/Headers/Public/AwesomeMenu -I#{PROJECT_ROOT}/Pods/Headers/Public/BFKit -I#{PROJECT_ROOT}/Pods/Headers/Public/BLKFlexibleHeightBar -I#{PROJECT_ROOT}/Pods/Headers/Public/BRPickerView -I#{PROJECT_ROOT}/Pods/Headers/Public/BlocksKit -I#{PROJECT_ROOT}/Pods/Headers/Public/Bolts -I#{PROJECT_ROOT}/Pods/Headers/Public/CBStoreHouseRefreshControl -I#{PROJECT_ROOT}/Pods/Headers/Public/CHTCollectionViewWaterfallLayout -I#{PROJECT_ROOT}/Pods/Headers/Public/CMPopTipView -I#{PROJECT_ROOT}/Pods/Headers/Public/CRInputView -I#{PROJECT_ROOT}/Pods/Headers/Public/CRToast -I#{PROJECT_ROOT}/Pods/Headers/Public/CSStickyHeaderFlowLayout -I#{PROJECT_ROOT}/Pods/Headers/Public/CYLTabBarController -I#{PROJECT_ROOT}/Pods/Headers/Public/Canvas -I#{PROJECT_ROOT}/Pods/Headers/Public/Cerfing -I#{PROJECT_ROOT}/Pods/Headers/Public/CocoaAsyncSocket -I#{PROJECT_ROOT}/Pods/Headers/Public/CocoaLumberjack -I#{PROJECT_ROOT}/Pods/Headers/Public/Colours -I#{PROJECT_ROOT}/Pods/Headers/Public/ComponentKit -I#{PROJECT_ROOT}/Pods/Headers/Public/ContactsWrapper -I#{PROJECT_ROOT}/Pods/Headers/Public/CoreDragon -I#{PROJECT_ROOT}/Pods/Headers/Public/DTCoreText -I#{PROJECT_ROOT}/Pods/Headers/Public/DTFoundation -I#{PROJECT_ROOT}/Pods/Headers/Public/DateTools -I#{PROJECT_ROOT}/Pods/Headers/Public/DeepLinkKit -I#{PROJECT_ROOT}/Pods/Headers/Public/EAIntroView -I#{PROJECT_ROOT}/Pods/Headers/Public/EARestrictedScrollView -I#{PROJECT_ROOT}/Pods/Headers/Public/ECSlidingViewController -I#{PROJECT_ROOT}/Pods/Headers/Public/EZAudio -I#{PROJECT_ROOT}/Pods/Headers/Public/FLAnimatedImage -I#{PROJECT_ROOT}/Pods/Headers/Public/FLEX -I#{PROJECT_ROOT}/Pods/Headers/Public/FMDB -I#{PROJECT_ROOT}/Pods/Headers/Public/FXBlurView -I#{PROJECT_ROOT}/Pods/Headers/Public/FXForms -I#{PROJECT_ROOT}/Pods/Headers/Public/FastImageCache -I#{PROJECT_ROOT}/Pods/Headers/Public/FirebaseCore -I#{PROJECT_ROOT}/Pods/Headers/Public/FirebaseCoreDiagnostics -I#{PROJECT_ROOT}/Pods/Headers/Public/FirebaseCrashlytics -I#{PROJECT_ROOT}/Pods/Headers/Public/FirebaseInstallations -I#{PROJECT_ROOT}/Pods/Headers/Public/FlatUIKit -I#{PROJECT_ROOT}/Pods/Headers/Public/FoldingTabBar -I#{PROJECT_ROOT}/Pods/Headers/Public/GCDWebServer -I#{PROJECT_ROOT}/Pods/Headers/Public/GMGridView -I#{PROJECT_ROOT}/Pods/Headers/Public/GPUImage -I#{PROJECT_ROOT}/Pods/Headers/Public/GZIP -I#{PROJECT_ROOT}/Pods/Headers/Public/GoogleDataTransport -I#{PROJECT_ROOT}/Pods/Headers/Public/GoogleUtilities -I#{PROJECT_ROOT}/Pods/Headers/Public/HPGrowingTextView -I#{PROJECT_ROOT}/Pods/Headers/Public/IGListDiffKit -I#{PROJECT_ROOT}/Pods/Headers/Public/IGListKit -I#{PROJECT_ROOT}/Pods/Headers/Public/IQKeyboardManager -I#{PROJECT_ROOT}/Pods/Headers/Public/ISO8601DateFormatterValueTransformer -I#{PROJECT_ROOT}/Pods/Headers/Public/JBChartView -I#{PROJECT_ROOT}/Pods/Headers/Public/JDStatusBarNotification -I#{PROJECT_ROOT}/Pods/Headers/Public/JHChainableAnimations -I#{PROJECT_ROOT}/Pods/Headers/Public/JSONModel -I#{PROJECT_ROOT}/Pods/Headers/Public/JSQMessagesViewController -I#{PROJECT_ROOT}/Pods/Headers/Public/JSQSystemSoundPlayer -I#{PROJECT_ROOT}/Pods/Headers/Public/JVFloatLabeledTextField -I#{PROJECT_ROOT}/Pods/Headers/Public/KSCrash -I#{PROJECT_ROOT}/Pods/Headers/Public/KVOController -I#{PROJECT_ROOT}/Pods/Headers/Public/Kiwi -I#{PROJECT_ROOT}/Pods/Headers/Public/LEEAlert -I#{PROJECT_ROOT}/Pods/Headers/Public/MBProgressHUD -I#{PROJECT_ROOT}/Pods/Headers/Public/MCSwipeTableViewCell -I#{PROJECT_ROOT}/Pods/Headers/Public/MGSwipeTableCell -I#{PROJECT_ROOT}/Pods/Headers/Public/MJExtension -I#{PROJECT_ROOT}/Pods/Headers/Public/MJRefresh -I#{PROJECT_ROOT}/Pods/Headers/Public/MKNetworkKit -I#{PROJECT_ROOT}/Pods/Headers/Public/MMDrawerController -I#{PROJECT_ROOT}/Pods/Headers/Public/MMWormhole -I#{PROJECT_ROOT}/Pods/Headers/Public/MRProgress -I#{PROJECT_ROOT}/Pods/Headers/Public/MSDynamicsDrawerViewController -I#{PROJECT_ROOT}/Pods/Headers/Public/MSNavigationPaneViewController -I#{PROJECT_ROOT}/Pods/Headers/Public/MWFeedParser -I#{PROJECT_ROOT}/Pods/Headers/Public/MZAppearance -I#{PROJECT_ROOT}/Pods/Headers/Public/MZFormSheetPresentationController -I#{PROJECT_ROOT}/Pods/Headers/Public/MagicalRecord -I#{PROJECT_ROOT}/Pods/Headers/Public/Mantle -I#{PROJECT_ROOT}/Pods/Headers/Public/Masonry -I#{PROJECT_ROOT}/Pods/Headers/Public/MeshPipe -I#{PROJECT_ROOT}/Pods/Headers/Public/MessagePack -I#{PROJECT_ROOT}/Pods/Headers/Public/NJKWebViewProgress -I#{PROJECT_ROOT}/Pods/Headers/Public/NSLogger -I#{PROJECT_ROOT}/Pods/Headers/Public/NYXImagesKit -I#{PROJECT_ROOT}/Pods/Headers/Public/OpinionatedC -I#{PROJECT_ROOT}/Pods/Headers/Public/PGDatePicker -I#{PROJECT_ROOT}/Pods/Headers/Public/PGPickerView -I#{PROJECT_ROOT}/Pods/Headers/Public/PKRevealController -I#{PROJECT_ROOT}/Pods/Headers/Public/PNChart -I#{PROJECT_ROOT}/Pods/Headers/Public/PRTween -I#{PROJECT_ROOT}/Pods/Headers/Public/PSStackedView -I#{PROJECT_ROOT}/Pods/Headers/Public/PonyDebugger -I#{PROJECT_ROOT}/Pods/Headers/Public/PromisesObjC -I#{PROJECT_ROOT}/Pods/Headers/Public/PureLayout -I#{PROJECT_ROOT}/Pods/Headers/Public/REFrostedViewController -I#{PROJECT_ROOT}/Pods/Headers/Public/REMenu -I#{PROJECT_ROOT}/Pods/Headers/Public/RESideMenu -I#{PROJECT_ROOT}/Pods/Headers/Public/RKValueTransformers -I#{PROJECT_ROOT}/Pods/Headers/Public/RNFrostedSidebar -I#{PROJECT_ROOT}/Pods/Headers/Public/Reachability -I#{PROJECT_ROOT}/Pods/Headers/Public/Realm -I#{PROJECT_ROOT}/Pods/Headers/Public/ReflectableEnum -I#{PROJECT_ROOT}/Pods/Headers/Public/RegExCategories -I#{PROJECT_ROOT}/Pods/Headers/Public/RenderCore -I#{PROJECT_ROOT}/Pods/Headers/Public/RestKit -I#{PROJECT_ROOT}/Pods/Headers/Public/SAMKeychain -I#{PROJECT_ROOT}/Pods/Headers/Public/SDVersion -I#{PROJECT_ROOT}/Pods/Headers/Public/SDWebImage -I#{PROJECT_ROOT}/Pods/Headers/Public/SIAlertView -I#{PROJECT_ROOT}/Pods/Headers/Public/SMPageControl -I#{PROJECT_ROOT}/Pods/Headers/Public/SOCKit -I#{PROJECT_ROOT}/Pods/Headers/Public/SSZipArchive -I#{PROJECT_ROOT}/Pods/Headers/Public/SVProgressHUD -I#{PROJECT_ROOT}/Pods/Headers/Public/SVPullToRefresh -I#{PROJECT_ROOT}/Pods/Headers/Public/SVWebViewController -I#{PROJECT_ROOT}/Pods/Headers/Public/SWRevealViewController -I#{PROJECT_ROOT}/Pods/Headers/Public/SWTableViewCell -I#{PROJECT_ROOT}/Pods/Headers/Public/SocketRocket -I#{PROJECT_ROOT}/Pods/Headers/Public/TFHpple -I#{PROJECT_ROOT}/Pods/Headers/Public/TMCache -I#{PROJECT_ROOT}/Pods/Headers/Public/TPCircularBuffer -I#{PROJECT_ROOT}/Pods/Headers/Public/TTTAttributedLabel -I#{PROJECT_ROOT}/Pods/Headers/Public/TapkuLibrary -I#{PROJECT_ROOT}/Pods/Headers/Public/Toast -I#{PROJECT_ROOT}/Pods/Headers/Public/TransitionKit -I#{PROJECT_ROOT}/Pods/Headers/Public/UICountingLabel -I#{PROJECT_ROOT}/Pods/Headers/Public/UITableView+FDTemplateLayoutCell -I#{PROJECT_ROOT}/Pods/Headers/Public/VBFPopFlatButton -I#{PROJECT_ROOT}/Pods/Headers/Public/ViewDeck -I#{PROJECT_ROOT}/Pods/Headers/Public/WebViewJavascriptBridge -I#{PROJECT_ROOT}/Pods/Headers/Public/XLForm -I#{PROJECT_ROOT}/Pods/Headers/Public/XMLDictionary -I#{PROJECT_ROOT}/Pods/Headers/Public/YTKNetwork -I#{PROJECT_ROOT}/Pods/Headers/Public/YYCache -I#{PROJECT_ROOT}/Pods/Headers/Public/YYImage -I#{PROJECT_ROOT}/Pods/Headers/Public/YYModel -I#{PROJECT_ROOT}/Pods/Headers/Public/YYText -I#{PROJECT_ROOT}/Pods/Headers/Public/Yoga -I#{PROJECT_ROOT}/Pods/Headers/Public/ZXingObjC -I#{PROJECT_ROOT}/Pods/Headers/Public/ZipArchive -I#{PROJECT_ROOT}/Pods/Headers/Public/iCarousel -I#{PROJECT_ROOT}/Pods/Headers/Public/nanopb -I#{PROJECT_ROOT}/Pods/Headers/Public/pop -I#{CACHE_PATH}/Build/Products/Debug-iphonesimulator/XCFrameworkIntermediates/realm-monorepo/Headers -I/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator14.2.sdk/usr/include/libxml2 -I#{PROJECT_ROOT}/Pods/MKNetworkKit/MKNetworkKit -I/Sources/FBLPromises/include -I/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator14.2.sdk/usr/include/libxml2 -I#{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/DerivedSources-normal/x86_64 -I#{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/DerivedSources/x86_64 -I#{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/DerivedSources -F#{CACHE_PATH}/Build/Products/Debug-iphonesimulator -F/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks -F#{PROJECT_ROOT}/Pods/Fabric/iOS -F#{PROJECT_ROOT}/Pods/Realm/core -iframework /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator14.2.sdk/Developer/Library/Frameworks -fmodule-map-file=#{PROJECT_ROOT}/Pods/Headers/Public/SSZipArchive/SSZipArchive.modulemap -fmodule-map-file=#{PROJECT_ROOT}/Pods/Headers/Public/yoga/Yoga.modulemap -Wno-nullability-completeness -MMD -MT dependencies -MF #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/Objects-normal/x86_64/TestObject0.d --serialize-diagnostics #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/Objects-normal/x86_64/TestObject0.dia -c #{PROJECT_ROOT}/app/classes/TestObject0.m -o #{CACHE_PATH}/Build/Intermediates.noindex/app.build/Debug-iphonesimulator/app.build/Objects-normal/x86_64/TestObject0.o > dir_build_log"


labels={case:'Case', average:'Average(s)', total:'Total(s)'}
$datas = []
module Helper
  def append_data(title, costs, costs_with_plugin)
    ave_cost_origin=costs.sum/costs.size
    ave_cost_plugin=costs_with_plugin.sum/costs_with_plugin.size
    $datas << {case:"#{title} (dir)", average:"#{ave_cost_origin}", total:"#{costs.sum}"}
    $datas << {case:"#{title} (hmap)", average:"#{ave_cost_plugin}", total:"#{costs_with_plugin.sum}"}
    speed=(1.0/ave_cost_plugin - 1.0/ave_cost_origin)/(1.0/ave_cost_origin)
    time_saved_rate=(ave_cost_origin - ave_cost_plugin)/ave_cost_origin
    $datas << {case:"> optimization (speed)", average:"#{(speed*100).round(2)}%", total:""}
    $datas << {case:"> optimization (time cost)", average:"#{(time_saved_rate*100).round(2)}%", total:""}
  end
  module_function :append_data
end

module Build
  class Task
    attr_accessor :command
    attr_accessor :name
    attr_accessor :loop_count
    attr_accessor :costs

    def initialize(command, name, loop_count=1000)
      @command = command
      @name = name
      @loop_count = loop_count
    end
    def clean
      system('xcodebuild clean > /dev/null')
    end
    def run
      clean
      puts "- BEGIN TASK: #{@name}"
      costs=[]
      counts=Array(0..loop_count)
      counts.each do |idx|
        start=Time.new.to_f
        system(@command)
        now=Time.new.to_f
        cost = now - start
        costs << cost
      end
      @costs = costs
      puts "- END TASK: #{@name}"
    end

    def print
        build_average_cost=@costs.sum/@costs.size
        puts "[#{@name}] total cost : #{@costs.sum}s"
        puts "[#{@name}] average cost : #{build_average_cost}s"
    end

  end
end

dir_build_task=Build::Task.new(BUILD_COMMAND_WITH_SEARCH_DIR, 'DIR', count)
hmap_build_task=Build::Task.new(BUILD_COMMAND_WITH_HMAP, 'HMAP', count)

Dir.chdir(PROJECT_ROOT)

dir_build_task.run
hmap_build_task.run

Helper::append_data("build #{count} times", dir_build_task.costs, hmap_build_task.costs)
tbl=Print::Table.new(labels, $datas)
tbl.print