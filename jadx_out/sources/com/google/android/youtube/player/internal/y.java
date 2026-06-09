package com.google.android.youtube.player.internal;

import android.app.ActionBar;
import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentManager;
import android.app.LoaderManager;
import android.app.PendingIntent;
import android.app.TaskStackBuilder;
import android.content.BroadcastReceiver;
import android.content.ComponentCallbacks;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.IntentSender;
import android.content.ServiceConnection;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.AssetManager;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.database.Cursor;
import android.database.DatabaseErrorHandler;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.AttributeSet;
import android.view.ActionMode;
import android.view.ContextMenu;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.view.accessibility.AccessibilityEvent;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;

/* JADX INFO: loaded from: classes2.dex */
public class y extends Activity {
    private Activity a;

    public y(Activity activity) {
        this.a = activity;
    }

    @Override // android.app.Activity
    public void addContentView(View view, ViewGroup.LayoutParams layoutParams) {
        this.a.addContentView(view, layoutParams);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public boolean bindService(Intent intent, ServiceConnection serviceConnection, int i) {
        return this.a.bindService(intent, serviceConnection, i);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public int checkCallingOrSelfPermission(String str) {
        return this.a.checkCallingOrSelfPermission(str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public int checkCallingOrSelfUriPermission(Uri uri, int i) {
        return this.a.checkCallingOrSelfUriPermission(uri, i);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public int checkCallingPermission(String str) {
        return this.a.checkCallingPermission(str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public int checkCallingUriPermission(Uri uri, int i) {
        return this.a.checkCallingUriPermission(uri, i);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public int checkPermission(String str, int i, int i2) {
        return this.a.checkPermission(str, i, i2);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public int checkUriPermission(Uri uri, int i, int i2, int i3) {
        return this.a.checkUriPermission(uri, i, i2, i3);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public int checkUriPermission(Uri uri, String str, String str2, int i, int i2, int i3) {
        return this.a.checkUriPermission(uri, str, str2, i, i2, i3);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void clearWallpaper() {
        this.a.clearWallpaper();
    }

    @Override // android.app.Activity
    public void closeContextMenu() {
        this.a.closeContextMenu();
    }

    @Override // android.app.Activity
    public void closeOptionsMenu() {
        this.a.closeOptionsMenu();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Context createPackageContext(String str, int i) {
        return this.a.createPackageContext(str, i);
    }

    @Override // android.app.Activity
    public PendingIntent createPendingResult(int i, Intent intent, int i2) {
        return this.a.createPendingResult(i, intent, i2);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public String[] databaseList() {
        return this.a.databaseList();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public boolean deleteDatabase(String str) {
        return this.a.deleteDatabase(str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public boolean deleteFile(String str) {
        return this.a.deleteFile(str);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean dispatchGenericMotionEvent(MotionEvent motionEvent) {
        return this.a.dispatchGenericMotionEvent(motionEvent);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean dispatchKeyEvent(KeyEvent keyEvent) {
        return this.a.dispatchKeyEvent(keyEvent);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean dispatchKeyShortcutEvent(KeyEvent keyEvent) {
        return this.a.dispatchKeyShortcutEvent(keyEvent);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
        return this.a.dispatchPopulateAccessibilityEvent(accessibilityEvent);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean dispatchTouchEvent(MotionEvent motionEvent) {
        return this.a.dispatchTouchEvent(motionEvent);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean dispatchTrackballEvent(MotionEvent motionEvent) {
        return this.a.dispatchTrackballEvent(motionEvent);
    }

    @Override // android.app.Activity
    public void dump(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
        this.a.dump(str, fileDescriptor, printWriter, strArr);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void enforceCallingOrSelfPermission(String str, String str2) {
        this.a.enforceCallingOrSelfPermission(str, str2);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void enforceCallingOrSelfUriPermission(Uri uri, int i, String str) {
        this.a.enforceCallingOrSelfUriPermission(uri, i, str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void enforceCallingPermission(String str, String str2) {
        this.a.enforceCallingPermission(str, str2);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void enforceCallingUriPermission(Uri uri, int i, String str) {
        this.a.enforceCallingUriPermission(uri, i, str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void enforcePermission(String str, int i, int i2, String str2) {
        this.a.enforcePermission(str, i, i2, str2);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void enforceUriPermission(Uri uri, int i, int i2, int i3, String str) {
        this.a.enforceUriPermission(uri, i, i2, i3, str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void enforceUriPermission(Uri uri, String str, String str2, int i, int i2, int i3, String str3) {
        this.a.enforceUriPermission(uri, str, str2, i, i2, i3, str3);
    }

    public boolean equals(Object obj) {
        return this.a.equals(obj);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public String[] fileList() {
        return this.a.fileList();
    }

    @Override // android.app.Activity
    public View findViewById(int i) {
        return this.a.findViewById(i);
    }

    @Override // android.app.Activity
    public void finish() {
        this.a.finish();
    }

    @Override // android.app.Activity
    public void finishActivity(int i) {
        this.a.finishActivity(i);
    }

    @Override // android.app.Activity
    public void finishActivityFromChild(Activity activity, int i) {
        this.a.finishActivityFromChild(activity, i);
    }

    @Override // android.app.Activity
    public void finishAffinity() {
        this.a.finishAffinity();
    }

    @Override // android.app.Activity
    public void finishFromChild(Activity activity) {
        this.a.finishFromChild(activity);
    }

    @Override // android.app.Activity
    public ActionBar getActionBar() {
        return this.a.getActionBar();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Context getApplicationContext() {
        return this.a.getApplicationContext();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public ApplicationInfo getApplicationInfo() {
        return this.a.getApplicationInfo();
    }

    @Override // android.view.ContextThemeWrapper, android.content.ContextWrapper, android.content.Context
    public AssetManager getAssets() {
        return this.a.getAssets();
    }

    @Override // android.content.ContextWrapper
    public Context getBaseContext() {
        return this.a.getBaseContext();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public File getCacheDir() {
        return this.a.getCacheDir();
    }

    @Override // android.app.Activity
    public ComponentName getCallingActivity() {
        return this.a.getCallingActivity();
    }

    @Override // android.app.Activity
    public String getCallingPackage() {
        return this.a.getCallingPackage();
    }

    @Override // android.app.Activity
    public int getChangingConfigurations() {
        return this.a.getChangingConfigurations();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public ClassLoader getClassLoader() {
        return this.a.getClassLoader();
    }

    @Override // android.app.Activity
    public ComponentName getComponentName() {
        return this.a.getComponentName();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public ContentResolver getContentResolver() {
        return this.a.getContentResolver();
    }

    @Override // android.app.Activity
    public View getCurrentFocus() {
        return this.a.getCurrentFocus();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public File getDatabasePath(String str) {
        return this.a.getDatabasePath(str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public File getDir(String str, int i) {
        return this.a.getDir(str, i);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public File getExternalCacheDir() {
        return this.a.getExternalCacheDir();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public File getExternalFilesDir(String str) {
        return this.a.getExternalFilesDir(str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public File getFileStreamPath(String str) {
        return this.a.getFileStreamPath(str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public File getFilesDir() {
        return this.a.getFilesDir();
    }

    @Override // android.app.Activity
    public FragmentManager getFragmentManager() {
        return this.a.getFragmentManager();
    }

    @Override // android.app.Activity
    public Intent getIntent() {
        return this.a.getIntent();
    }

    @Override // android.app.Activity
    public Object getLastNonConfigurationInstance() {
        return this.a.getLastNonConfigurationInstance();
    }

    @Override // android.app.Activity
    public LayoutInflater getLayoutInflater() {
        return this.a.getLayoutInflater();
    }

    @Override // android.app.Activity
    public LoaderManager getLoaderManager() {
        return this.a.getLoaderManager();
    }

    @Override // android.app.Activity
    public String getLocalClassName() {
        return this.a.getLocalClassName();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Looper getMainLooper() {
        return this.a.getMainLooper();
    }

    @Override // android.app.Activity
    public MenuInflater getMenuInflater() {
        return this.a.getMenuInflater();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public File getObbDir() {
        return this.a.getObbDir();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public String getPackageCodePath() {
        return this.a.getPackageCodePath();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public PackageManager getPackageManager() {
        return this.a.getPackageManager();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public String getPackageName() {
        return this.a.getPackageName();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public String getPackageResourcePath() {
        return this.a.getPackageResourcePath();
    }

    @Override // android.app.Activity
    public Intent getParentActivityIntent() {
        return this.a.getParentActivityIntent();
    }

    @Override // android.app.Activity
    public SharedPreferences getPreferences(int i) {
        return this.a.getPreferences(i);
    }

    @Override // android.app.Activity
    public int getRequestedOrientation() {
        return this.a.getRequestedOrientation();
    }

    @Override // android.view.ContextThemeWrapper, android.content.ContextWrapper, android.content.Context
    public Resources getResources() {
        return this.a.getResources();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public SharedPreferences getSharedPreferences(String str, int i) {
        return this.a.getSharedPreferences(str, i);
    }

    @Override // android.app.Activity, android.view.ContextThemeWrapper, android.content.ContextWrapper, android.content.Context
    public Object getSystemService(String str) {
        return this.a.getSystemService(str);
    }

    @Override // android.app.Activity
    public int getTaskId() {
        return this.a.getTaskId();
    }

    @Override // android.view.ContextThemeWrapper, android.content.ContextWrapper, android.content.Context
    public Resources.Theme getTheme() {
        return this.a.getTheme();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Drawable getWallpaper() {
        return this.a.getWallpaper();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public int getWallpaperDesiredMinimumHeight() {
        return this.a.getWallpaperDesiredMinimumHeight();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public int getWallpaperDesiredMinimumWidth() {
        return this.a.getWallpaperDesiredMinimumWidth();
    }

    @Override // android.app.Activity
    public Window getWindow() {
        return this.a.getWindow();
    }

    @Override // android.app.Activity
    public WindowManager getWindowManager() {
        return this.a.getWindowManager();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void grantUriPermission(String str, Uri uri, int i) {
        this.a.grantUriPermission(str, uri, i);
    }

    @Override // android.app.Activity
    public boolean hasWindowFocus() {
        return this.a.hasWindowFocus();
    }

    public int hashCode() {
        return this.a.hashCode();
    }

    @Override // android.app.Activity
    public void invalidateOptionsMenu() {
        this.a.invalidateOptionsMenu();
    }

    @Override // android.app.Activity
    public boolean isChangingConfigurations() {
        return this.a.isChangingConfigurations();
    }

    @Override // android.app.Activity
    public boolean isFinishing() {
        return this.a.isFinishing();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public boolean isRestricted() {
        return this.a.isRestricted();
    }

    @Override // android.app.Activity
    public boolean isTaskRoot() {
        return this.a.isTaskRoot();
    }

    @Override // android.app.Activity
    public boolean moveTaskToBack(boolean z) {
        return this.a.moveTaskToBack(z);
    }

    @Override // android.app.Activity
    public boolean navigateUpTo(Intent intent) {
        return this.a.navigateUpTo(intent);
    }

    @Override // android.app.Activity
    public boolean navigateUpToFromChild(Activity activity, Intent intent) {
        return this.a.navigateUpToFromChild(activity, intent);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onActionModeFinished(ActionMode actionMode) {
        this.a.onActionModeFinished(actionMode);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onActionModeStarted(ActionMode actionMode) {
        this.a.onActionModeStarted(actionMode);
    }

    @Override // android.app.Activity
    public void onAttachFragment(Fragment fragment) {
        this.a.onAttachFragment(fragment);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onAttachedToWindow() {
        this.a.onAttachedToWindow();
    }

    @Override // android.app.Activity
    public void onBackPressed() {
        this.a.onBackPressed();
    }

    @Override // android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        this.a.onConfigurationChanged(configuration);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onContentChanged() {
        this.a.onContentChanged();
    }

    @Override // android.app.Activity
    public boolean onContextItemSelected(MenuItem menuItem) {
        return this.a.onContextItemSelected(menuItem);
    }

    @Override // android.app.Activity
    public void onContextMenuClosed(Menu menu) {
        this.a.onContextMenuClosed(menu);
    }

    @Override // android.app.Activity, android.view.View.OnCreateContextMenuListener
    public void onCreateContextMenu(ContextMenu contextMenu, View view, ContextMenu.ContextMenuInfo contextMenuInfo) {
        this.a.onCreateContextMenu(contextMenu, view, contextMenuInfo);
    }

    @Override // android.app.Activity
    public CharSequence onCreateDescription() {
        return this.a.onCreateDescription();
    }

    @Override // android.app.Activity
    public void onCreateNavigateUpTaskStack(TaskStackBuilder taskStackBuilder) {
        this.a.onCreateNavigateUpTaskStack(taskStackBuilder);
    }

    @Override // android.app.Activity
    public boolean onCreateOptionsMenu(Menu menu) {
        return this.a.onCreateOptionsMenu(menu);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean onCreatePanelMenu(int i, Menu menu) {
        return this.a.onCreatePanelMenu(i, menu);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public View onCreatePanelView(int i) {
        return this.a.onCreatePanelView(i);
    }

    @Override // android.app.Activity
    public boolean onCreateThumbnail(Bitmap bitmap, Canvas canvas) {
        return this.a.onCreateThumbnail(bitmap, canvas);
    }

    @Override // android.app.Activity, android.view.LayoutInflater.Factory2
    public View onCreateView(View view, String str, Context context, AttributeSet attributeSet) {
        return this.a.onCreateView(view, str, context, attributeSet);
    }

    @Override // android.app.Activity, android.view.LayoutInflater.Factory
    public View onCreateView(String str, Context context, AttributeSet attributeSet) {
        return this.a.onCreateView(str, context, attributeSet);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onDetachedFromWindow() {
        this.a.onDetachedFromWindow();
    }

    @Override // android.app.Activity
    public boolean onGenericMotionEvent(MotionEvent motionEvent) {
        return this.a.onGenericMotionEvent(motionEvent);
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        return this.a.onKeyDown(i, keyEvent);
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyLongPress(int i, KeyEvent keyEvent) {
        return this.a.onKeyLongPress(i, keyEvent);
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyMultiple(int i, int i2, KeyEvent keyEvent) {
        return this.a.onKeyMultiple(i, i2, keyEvent);
    }

    @Override // android.app.Activity
    public boolean onKeyShortcut(int i, KeyEvent keyEvent) {
        return this.a.onKeyShortcut(i, keyEvent);
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        return this.a.onKeyUp(i, keyEvent);
    }

    @Override // android.app.Activity, android.content.ComponentCallbacks
    public void onLowMemory() {
        this.a.onLowMemory();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean onMenuItemSelected(int i, MenuItem menuItem) {
        return this.a.onMenuItemSelected(i, menuItem);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean onMenuOpened(int i, Menu menu) {
        return this.a.onMenuOpened(i, menu);
    }

    @Override // android.app.Activity
    public boolean onNavigateUp() {
        return this.a.onNavigateUp();
    }

    @Override // android.app.Activity
    public boolean onNavigateUpFromChild(Activity activity) {
        return this.a.onNavigateUpFromChild(activity);
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        return this.a.onOptionsItemSelected(menuItem);
    }

    @Override // android.app.Activity
    public void onOptionsMenuClosed(Menu menu) {
        this.a.onOptionsMenuClosed(menu);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onPanelClosed(int i, Menu menu) {
        this.a.onPanelClosed(i, menu);
    }

    @Override // android.app.Activity
    public void onPrepareNavigateUpTaskStack(TaskStackBuilder taskStackBuilder) {
        this.a.onPrepareNavigateUpTaskStack(taskStackBuilder);
    }

    @Override // android.app.Activity
    public boolean onPrepareOptionsMenu(Menu menu) {
        return this.a.onPrepareOptionsMenu(menu);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean onPreparePanel(int i, View view, Menu menu) {
        return this.a.onPreparePanel(i, view, menu);
    }

    @Override // android.app.Activity
    public Object onRetainNonConfigurationInstance() {
        return this.a.onRetainNonConfigurationInstance();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean onSearchRequested() {
        return this.a.onSearchRequested();
    }

    @Override // android.app.Activity
    public boolean onTouchEvent(MotionEvent motionEvent) {
        return this.a.onTouchEvent(motionEvent);
    }

    @Override // android.app.Activity
    public boolean onTrackballEvent(MotionEvent motionEvent) {
        return this.a.onTrackballEvent(motionEvent);
    }

    @Override // android.app.Activity, android.content.ComponentCallbacks2
    public void onTrimMemory(int i) {
        this.a.onTrimMemory(i);
    }

    @Override // android.app.Activity
    public void onUserInteraction() {
        this.a.onUserInteraction();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onWindowAttributesChanged(WindowManager.LayoutParams layoutParams) {
        this.a.onWindowAttributesChanged(layoutParams);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onWindowFocusChanged(boolean z) {
        this.a.onWindowFocusChanged(z);
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public ActionMode onWindowStartingActionMode(ActionMode.Callback callback) {
        return this.a.onWindowStartingActionMode(callback);
    }

    @Override // android.app.Activity
    public void openContextMenu(View view) {
        this.a.openContextMenu(view);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public FileInputStream openFileInput(String str) {
        return this.a.openFileInput(str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public FileOutputStream openFileOutput(String str, int i) {
        return this.a.openFileOutput(str, i);
    }

    @Override // android.app.Activity
    public void openOptionsMenu() {
        this.a.openOptionsMenu();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public SQLiteDatabase openOrCreateDatabase(String str, int i, SQLiteDatabase.CursorFactory cursorFactory) {
        return this.a.openOrCreateDatabase(str, i, cursorFactory);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public SQLiteDatabase openOrCreateDatabase(String str, int i, SQLiteDatabase.CursorFactory cursorFactory, DatabaseErrorHandler databaseErrorHandler) {
        return this.a.openOrCreateDatabase(str, i, cursorFactory, databaseErrorHandler);
    }

    @Override // android.app.Activity
    public void overridePendingTransition(int i, int i2) {
        this.a.overridePendingTransition(i, i2);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Drawable peekWallpaper() {
        return this.a.peekWallpaper();
    }

    @Override // android.app.Activity
    public void recreate() {
        this.a.recreate();
    }

    @Override // android.app.Activity, android.content.ContextWrapper, android.content.Context
    public void registerComponentCallbacks(ComponentCallbacks componentCallbacks) {
        this.a.registerComponentCallbacks(componentCallbacks);
    }

    @Override // android.app.Activity
    public void registerForContextMenu(View view) {
        this.a.registerForContextMenu(view);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Intent registerReceiver(BroadcastReceiver broadcastReceiver, IntentFilter intentFilter) {
        return this.a.registerReceiver(broadcastReceiver, intentFilter);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Intent registerReceiver(BroadcastReceiver broadcastReceiver, IntentFilter intentFilter, String str, Handler handler) {
        return this.a.registerReceiver(broadcastReceiver, intentFilter, str, handler);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void removeStickyBroadcast(Intent intent) {
        this.a.removeStickyBroadcast(intent);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void revokeUriPermission(Uri uri, int i) {
        this.a.revokeUriPermission(uri, i);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void sendBroadcast(Intent intent) {
        this.a.sendBroadcast(intent);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void sendBroadcast(Intent intent, String str) {
        this.a.sendBroadcast(intent, str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void sendOrderedBroadcast(Intent intent, String str) {
        this.a.sendOrderedBroadcast(intent, str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void sendOrderedBroadcast(Intent intent, String str, BroadcastReceiver broadcastReceiver, Handler handler, int i, String str2, Bundle bundle) {
        this.a.sendOrderedBroadcast(intent, str, broadcastReceiver, handler, i, str2, bundle);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void sendStickyBroadcast(Intent intent) {
        this.a.sendStickyBroadcast(intent);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void sendStickyOrderedBroadcast(Intent intent, BroadcastReceiver broadcastReceiver, Handler handler, int i, String str, Bundle bundle) {
        this.a.sendStickyOrderedBroadcast(intent, broadcastReceiver, handler, i, str, bundle);
    }

    @Override // android.app.Activity
    public void setContentView(int i) {
        this.a.setContentView(i);
    }

    @Override // android.app.Activity
    public void setContentView(View view) {
        this.a.setContentView(view);
    }

    @Override // android.app.Activity
    public void setContentView(View view, ViewGroup.LayoutParams layoutParams) {
        this.a.setContentView(view, layoutParams);
    }

    @Override // android.app.Activity
    public void setFinishOnTouchOutside(boolean z) {
        this.a.setFinishOnTouchOutside(z);
    }

    @Override // android.app.Activity
    public void setIntent(Intent intent) {
        this.a.setIntent(intent);
    }

    @Override // android.app.Activity
    public void setRequestedOrientation(int i) {
        this.a.setRequestedOrientation(i);
    }

    @Override // android.app.Activity, android.view.ContextThemeWrapper, android.content.ContextWrapper, android.content.Context
    public void setTheme(int i) {
        this.a.setTheme(i);
    }

    @Override // android.app.Activity
    public void setTitle(int i) {
        this.a.setTitle(i);
    }

    @Override // android.app.Activity
    public void setTitle(CharSequence charSequence) {
        this.a.setTitle(charSequence);
    }

    @Override // android.app.Activity
    public void setTitleColor(int i) {
        this.a.setTitleColor(i);
    }

    @Override // android.app.Activity
    public void setVisible(boolean z) {
        this.a.setVisible(z);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void setWallpaper(Bitmap bitmap) {
        this.a.setWallpaper(bitmap);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void setWallpaper(InputStream inputStream) {
        this.a.setWallpaper(inputStream);
    }

    @Override // android.app.Activity
    public boolean shouldUpRecreateTask(Intent intent) {
        return this.a.shouldUpRecreateTask(intent);
    }

    @Override // android.app.Activity
    public ActionMode startActionMode(ActionMode.Callback callback) {
        return this.a.startActionMode(callback);
    }

    @Override // android.app.Activity, android.content.ContextWrapper, android.content.Context
    public void startActivities(Intent[] intentArr) {
        this.a.startActivities(intentArr);
    }

    @Override // android.app.Activity, android.content.ContextWrapper, android.content.Context
    public void startActivities(Intent[] intentArr, Bundle bundle) {
        this.a.startActivities(intentArr, bundle);
    }

    @Override // android.app.Activity, android.content.ContextWrapper, android.content.Context
    public void startActivity(Intent intent) {
        this.a.startActivity(intent);
    }

    @Override // android.app.Activity, android.content.ContextWrapper, android.content.Context
    public void startActivity(Intent intent, Bundle bundle) {
        this.a.startActivity(intent, bundle);
    }

    @Override // android.app.Activity
    public void startActivityForResult(Intent intent, int i) {
        this.a.startActivityForResult(intent, i);
    }

    @Override // android.app.Activity
    public void startActivityForResult(Intent intent, int i, Bundle bundle) {
        this.a.startActivityForResult(intent, i, bundle);
    }

    @Override // android.app.Activity
    public void startActivityFromChild(Activity activity, Intent intent, int i) {
        this.a.startActivityFromChild(activity, intent, i);
    }

    @Override // android.app.Activity
    public void startActivityFromChild(Activity activity, Intent intent, int i, Bundle bundle) {
        this.a.startActivityFromChild(activity, intent, i, bundle);
    }

    @Override // android.app.Activity
    public void startActivityFromFragment(Fragment fragment, Intent intent, int i) {
        this.a.startActivityFromFragment(fragment, intent, i);
    }

    @Override // android.app.Activity
    public void startActivityFromFragment(Fragment fragment, Intent intent, int i, Bundle bundle) {
        this.a.startActivityFromFragment(fragment, intent, i, bundle);
    }

    @Override // android.app.Activity
    public boolean startActivityIfNeeded(Intent intent, int i) {
        return this.a.startActivityIfNeeded(intent, i);
    }

    @Override // android.app.Activity
    public boolean startActivityIfNeeded(Intent intent, int i, Bundle bundle) {
        return this.a.startActivityIfNeeded(intent, i, bundle);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public boolean startInstrumentation(ComponentName componentName, String str, Bundle bundle) {
        return this.a.startInstrumentation(componentName, str, bundle);
    }

    @Override // android.app.Activity, android.content.ContextWrapper, android.content.Context
    public void startIntentSender(IntentSender intentSender, Intent intent, int i, int i2, int i3) throws IntentSender.SendIntentException {
        this.a.startIntentSender(intentSender, intent, i, i2, i3);
    }

    @Override // android.app.Activity, android.content.ContextWrapper, android.content.Context
    public void startIntentSender(IntentSender intentSender, Intent intent, int i, int i2, int i3, Bundle bundle) throws IntentSender.SendIntentException {
        this.a.startIntentSender(intentSender, intent, i, i2, i3, bundle);
    }

    @Override // android.app.Activity
    public void startIntentSenderForResult(IntentSender intentSender, int i, Intent intent, int i2, int i3, int i4) throws IntentSender.SendIntentException {
        this.a.startIntentSenderForResult(intentSender, i, intent, i2, i3, i4);
    }

    @Override // android.app.Activity
    public void startIntentSenderForResult(IntentSender intentSender, int i, Intent intent, int i2, int i3, int i4, Bundle bundle) throws IntentSender.SendIntentException {
        this.a.startIntentSenderForResult(intentSender, i, intent, i2, i3, i4, bundle);
    }

    @Override // android.app.Activity
    public void startIntentSenderFromChild(Activity activity, IntentSender intentSender, int i, Intent intent, int i2, int i3, int i4) throws IntentSender.SendIntentException {
        this.a.startIntentSenderFromChild(activity, intentSender, i, intent, i2, i3, i4);
    }

    @Override // android.app.Activity
    public void startIntentSenderFromChild(Activity activity, IntentSender intentSender, int i, Intent intent, int i2, int i3, int i4, Bundle bundle) throws IntentSender.SendIntentException {
        this.a.startIntentSenderFromChild(activity, intentSender, i, intent, i2, i3, i4, bundle);
    }

    @Override // android.app.Activity
    public void startManagingCursor(Cursor cursor) {
        this.a.startManagingCursor(cursor);
    }

    @Override // android.app.Activity
    public boolean startNextMatchingActivity(Intent intent) {
        return this.a.startNextMatchingActivity(intent);
    }

    @Override // android.app.Activity
    public boolean startNextMatchingActivity(Intent intent, Bundle bundle) {
        return this.a.startNextMatchingActivity(intent, bundle);
    }

    @Override // android.app.Activity
    public void startSearch(String str, boolean z, Bundle bundle, boolean z2) {
        this.a.startSearch(str, z, bundle, z2);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public ComponentName startService(Intent intent) {
        return this.a.startService(intent);
    }

    @Override // android.app.Activity
    public void stopManagingCursor(Cursor cursor) {
        this.a.stopManagingCursor(cursor);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public boolean stopService(Intent intent) {
        return this.a.stopService(intent);
    }

    @Override // android.app.Activity
    public void takeKeyEvents(boolean z) {
        this.a.takeKeyEvents(z);
    }

    public String toString() {
        return this.a.toString();
    }

    @Override // android.app.Activity
    public void triggerSearch(String str, Bundle bundle) {
        this.a.triggerSearch(str, bundle);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void unbindService(ServiceConnection serviceConnection) {
        this.a.unbindService(serviceConnection);
    }

    @Override // android.app.Activity, android.content.ContextWrapper, android.content.Context
    public void unregisterComponentCallbacks(ComponentCallbacks componentCallbacks) {
        this.a.unregisterComponentCallbacks(componentCallbacks);
    }

    @Override // android.app.Activity
    public void unregisterForContextMenu(View view) {
        this.a.unregisterForContextMenu(view);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void unregisterReceiver(BroadcastReceiver broadcastReceiver) {
        this.a.unregisterReceiver(broadcastReceiver);
    }
}
