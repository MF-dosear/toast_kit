package com.ex.toastkit

import android.app.Activity
import android.app.Dialog
import android.content.Context
import android.graphics.Color
import android.os.Handler
import android.os.Looper
import android.view.Gravity
import android.view.WindowManager
import android.widget.ProgressBar
import android.widget.TextView
import android.widget.Toast
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * Android 实现：使用系统 Dialog + ProgressBar + Toast，无第三方依赖，与 iOS 行为一致。
 */
class ToastkitPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var currentDialog: Dialog? = null
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
            "setDefaultStyle" -> {
                defaultStyleIndex = (call.arguments as? Number)?.toInt() ?: 0
                result.success(true)
            }
            "setDefaultMaskType" -> {
                defaultMaskTypeIndex = (call.arguments as? Number)?.toInt() ?: 0
                result.success(true)
            }
            "setDefaultAnimationType" -> {
                result.success(true)
            }
            "show" -> {
                dismissCurrent()
                currentDialog = showProgressDialog(activity, null, indeterminate = true)
                result.success(true)
            }
            "dismiss" -> {
                dismissCurrent()
                result.success(true)
            }
            "showProgress" -> {
                val value = (call.arguments as? Number)?.toDouble() ?: 0.0
                dismissCurrent()
                currentDialog = showProgressDialog(activity, null, indeterminate = false, progress = value)
                result.success(true)
            }
            "showProgressWithText" -> {
                @Suppress("UNCHECKED_CAST")
                val args = call.arguments as? Map<String, Any?>
                val value = (args?.get("value") as? Number)?.toDouble() ?: 0.0
                val text = args?.get("text") as? String ?: "unknown"
                dismissCurrent()
                currentDialog = showProgressDialog(activity, text, indeterminate = false, progress = value)
                result.success(true)
            }
            "showText" -> {
                val text = call.arguments as? String ?: ""
                showToast(activity, text)
                mainHandler.postDelayed({
                    activity.runOnUiThread { result.success(true) }
                }, 1600)
            }
            "showSuccessWithText" -> {
                val text = call.arguments as? String ?: ""
                showToast(activity, "✓ $text")
                mainHandler.postDelayed({
                    activity.runOnUiThread { result.success(true) }
                }, 1600)
            }
            "showWarnWithText" -> {
                val text = call.arguments as? String ?: ""
                showToast(activity, "⚠ $text")
                mainHandler.postDelayed({
                    activity.runOnUiThread { result.success(true) }
                }, 1600)
            }
            "showErrorWithText" -> {
                val text = call.arguments as? String ?: ""
                showToast(activity, "✗ $text")
                mainHandler.postDelayed({
                    activity.runOnUiThread { result.success(true) }
                }, 1600)
            }
            "dismissDelayWithCompletion" -> {
                val delayMs = (call.arguments as? Number)?.toInt() ?: 1600
                mainHandler.postDelayed({
                    activity.runOnUiThread {
                        dismissCurrent()
                        result.success(true)
                    }
                }, delayMs.toLong())
            }
            else -> result.notImplemented()
        }
    }

    private fun showProgressDialog(
        context: Context,
        message: String?,
        indeterminate: Boolean,
        progress: Double = 0.0
    ): Dialog {
        val dialog = Dialog(context, android.R.style.Theme_DeviceDefault_Dialog)
        val layout = android.widget.LinearLayout(context).apply {
            orientation = android.widget.LinearLayout.VERTICAL
            setPadding(80, 60, 80, 60)
            setBackgroundColor(Color.parseColor("#F5F5F5"))
        }
        if (!message.isNullOrEmpty()) {
            layout.addView(TextView(context).apply {
                text = message
                setPadding(0, 0, 0, 24)
            })
        }
        val progressBar = if (indeterminate) {
            ProgressBar(context, null, android.R.attr.progressBarStyle)
        } else {
            ProgressBar(context, null, android.R.attr.progressBarStyleHorizontal).apply {
                max = 100
                this.progress = (progress * 100).toInt().coerceIn(0, 100)
            }
        }
        layout.addView(progressBar)
        dialog.setContentView(layout)
        dialog.setCancelable(defaultMaskTypeIndex == 0)
        if (defaultMaskTypeIndex != 0) {
            dialog.window?.addFlags(WindowManager.LayoutParams.FLAG_DIM_BEHIND)
            dialog.window?.attributes?.dimAmount = 0.5f
        }
        dialog.show()
        return dialog
    }

    private fun showToast(context: Context, message: String) {
        val toast = Toast.makeText(context, message, Toast.LENGTH_SHORT)
        toast.setGravity(Gravity.CENTER, 0, 0)
        toast.show()
    }

    private fun dismissCurrent() {
        try {
            currentDialog?.dismiss()
        } catch (_: Exception) { }
        currentDialog = null
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        mainHandler.removeCallbacksAndMessages(null)
        dismissCurrent()
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
        dismissCurrent()
        mainHandler.removeCallbacksAndMessages(null)
    }
}
