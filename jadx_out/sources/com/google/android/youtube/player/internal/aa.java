package com.google.android.youtube.player.internal;

import android.app.Activity;
import android.content.Context;
import android.content.res.Resources;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import java.lang.reflect.InvocationTargetException;

/* JADX INFO: loaded from: classes2.dex */
public final class aa extends y {
    private static final Class<?>[] a = {Context.class, AttributeSet.class};
    private final Resources b;
    private final LayoutInflater c;
    private final Resources.Theme d;

    private static final class a implements LayoutInflater.Factory {
        private final ClassLoader a;

        public a(ClassLoader classLoader) {
            this.a = (ClassLoader) ac.a(classLoader, "remoteClassLoader cannot be null");
        }

        @Override // android.view.LayoutInflater.Factory
        public final View onCreateView(String str, Context context, AttributeSet attributeSet) {
            try {
                return (View) this.a.loadClass(str).asSubclass(View.class).getConstructor(aa.a).newInstance(context, attributeSet);
            } catch (ClassNotFoundException | IllegalAccessException | IllegalArgumentException | InstantiationException | NoClassDefFoundError | NoSuchMethodException | InvocationTargetException unused) {
                return null;
            }
        }
    }

    public aa(Activity activity, Resources resources, ClassLoader classLoader, int i) {
        super(activity);
        this.b = (Resources) ac.a(resources, "resources cannot be null");
        LayoutInflater layoutInflaterCloneInContext = ((LayoutInflater) super.getSystemService("layout_inflater")).cloneInContext(this);
        layoutInflaterCloneInContext.setFactory(new a(classLoader));
        this.c = layoutInflaterCloneInContext;
        this.d = resources.newTheme();
        this.d.applyStyle(i, false);
    }

    @Override // com.google.android.youtube.player.internal.y, android.content.ContextWrapper, android.content.Context
    public final Context getApplicationContext() {
        return super.getApplicationContext();
    }

    @Override // com.google.android.youtube.player.internal.y, android.content.ContextWrapper
    public final Context getBaseContext() {
        return super.getBaseContext();
    }

    @Override // com.google.android.youtube.player.internal.y, android.view.ContextThemeWrapper, android.content.ContextWrapper, android.content.Context
    public final Resources getResources() {
        return this.b;
    }

    @Override // com.google.android.youtube.player.internal.y, android.app.Activity, android.view.ContextThemeWrapper, android.content.ContextWrapper, android.content.Context
    public final Object getSystemService(String str) {
        return "layout_inflater".equals(str) ? this.c : super.getSystemService(str);
    }

    @Override // com.google.android.youtube.player.internal.y, android.view.ContextThemeWrapper, android.content.ContextWrapper, android.content.Context
    public final Resources.Theme getTheme() {
        return this.d;
    }
}
