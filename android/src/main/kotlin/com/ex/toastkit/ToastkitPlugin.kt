package com.ex.toastkit

import android.app.Activity
import android.os.Handler
import android.os.Looper
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.ex.toastkit.R
import com.wang.avi.AVLoadingIndicatorView
import es.dmoral.toasty.Toasty
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * Android 实现：
 * - show / dismiss / showProgress 使用 AVLoadingIndicatorView（LineSpinFadeLoaderIndicator 样式）
 * - showText/showSuccessWithText/showWarnWithText/showErrorWithText 使用 Toasty。
 */
class ToastkitPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private val mainHandler = Handler(Looper.getMainLooper())

    private var defaultStyleIndex: Int = 0
    private var defaultMaskTypeIndex: Int = 0

    private var loadingOverlay: ViewGroup? = null
    private var ivLoading: AVLoadingIndicatorView? = null
    private var progressPercentText: TextView? = null

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

    private fun ensureLoadingOverlay(activity: Activity) {
        if (loadingOverlay != null) return
        val content = activity.findViewById<ViewGroup>(android.R.id.content)
        val overlay = LayoutInflater.from(activity)
            .inflate(R.layout.toastkit_loading_overlay, content, false) as ViewGroup
        content.addView(overlay, ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
        loadingOverlay = overlay
        ivLoading = overlay.findViewById(R.id.ivLoading)
        progressPercentText = overlay.findViewById(R.id.progressPercentText)
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
            "show" -> {
                ensureLoadingOverlay(activity)
                loadingOverlay?.visibility = View.VISIBLE
                progressPercentText?.visibility = View.GONE
                ivLoading?.visibility = View.VISIBLE
                ivLoading?.show()
                result.success(true)
            }
            "dismiss" -> {
                ivLoading?.hide()
                progressPercentText?.visibility = View.GONE
                loadingOverlay?.visibility = View.GONE
                ivLoading?.visibility = View.GONE
                result.success(true)
            }
            "showProgress" -> {
                val value = when (val arg = call.arguments) {
                    is Number -> arg.toDouble().coerceIn(0.0, 1.0)
                    else -> 0.0
                }
                val percent = (value * 100).toInt().coerceIn(0, 100)
                ensureLoadingOverlay(activity)
                loadingOverlay?.visibility = View.VISIBLE
                ivLoading?.visibility = View.VISIBLE
                ivLoading?.show()
                progressPercentText?.visibility = View.VISIBLE
                progressPercentText?.text = "$percent%"
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
        activity?.runOnUiThread {
            loadingOverlay?.let { overlay ->
                (overlay.parent as? ViewGroup)?.removeView(overlay)
            }
        }
        loadingOverlay = null
        ivLoading = null
        progressPercentText = null
        activity = null
        mainHandler.removeCallbacksAndMessages(null)
    }
}
