package com.ex.toastkit

import android.app.Activity
import android.os.Handler
import android.os.Looper
import es.dmoral.toasty.Toasty
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * Android 实现：showText/showSuccessWithText/showWarnWithText/showErrorWithText 使用 Toasty。
 */
class ToastkitPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private val mainHandler = Handler(Looper.getMainLooper())

    private var defaultStyleIndex: Int = 0
    private var defaultMaskTypeIndex: Int = 0

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "toastkit")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val act = activity
        if (act == null) {
            result.error("NO_ACTIVITY", "No activity available", null)
            return
        }
        act.runOnUiThread {
            handleOnUi(call, result, act)
        }
    }

    private fun handleOnUi(call: MethodCall, result: Result, activity: Activity) {
        when (call.method) {
            "init" -> {
                @Suppress("UNCHECKED_CAST")
                val args = call.arguments as? Map<String, Any?>
                defaultStyleIndex = (args?.get("style") as? Number)?.toInt() ?: 0
                defaultMaskTypeIndex = (args?.get("maskType") as? Number)?.toInt() ?: 0
                result.success(true)
            }
            "showText" -> {
                val text = call.arguments as? String ?: ""
                Toasty.info(activity, text, Toasty.LENGTH_SHORT, true).show()
                mainHandler.postDelayed({
                    activity.runOnUiThread { result.success(true) }
                }, 1600)
            }
            "showSuccessWithText" -> {
                val text = call.arguments as? String ?: ""
                Toasty.success(activity, text, Toasty.LENGTH_SHORT, true).show()
                mainHandler.postDelayed({
                    activity.runOnUiThread { result.success(true) }
                }, 1600)
            }
            "showWarnWithText" -> {
                val text = call.arguments as? String ?: ""
                Toasty.warning(activity, text, Toasty.LENGTH_SHORT, true).show()
                mainHandler.postDelayed({
                    activity.runOnUiThread { result.success(true) }
                }, 1600)
            }
            "showErrorWithText" -> {
                val text = call.arguments as? String ?: ""
                Toasty.error(activity, text, Toasty.LENGTH_SHORT, true).show()
                mainHandler.postDelayed({
                    activity.runOnUiThread { result.success(true) }
                }, 1600)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        mainHandler.removeCallbacksAndMessages(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
        mainHandler.removeCallbacksAndMessages(null)
    }
}
