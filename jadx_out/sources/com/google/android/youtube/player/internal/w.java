package com.google.android.youtube.player.internal;

import android.app.Activity;
import android.content.Context;
import android.os.IBinder;
import com.google.android.youtube.player.internal.d;
import java.lang.reflect.InvocationTargetException;

/* JADX INFO: loaded from: classes2.dex */
public final class w {

    public static final class a extends Exception {
        public a(String str) {
            super(str);
        }

        public a(String str, Throwable th) {
            super(str, th);
        }
    }

    private static IBinder a(Class<?> cls, IBinder iBinder, IBinder iBinder2) throws a {
        try {
            return (IBinder) cls.getConstructor(IBinder.class, IBinder.class).newInstance(iBinder, iBinder2);
        } catch (IllegalAccessException e) {
            throw new a("Unable to call the default constructor of " + cls.getName(), e);
        } catch (InstantiationException e2) {
            throw new a("Unable to instantiate the dynamic class " + cls.getName(), e2);
        } catch (NoSuchMethodException e3) {
            throw new a("Could not find the right constructor for " + cls.getName(), e3);
        } catch (InvocationTargetException e4) {
            throw new a("Exception thrown by invoked constructor in " + cls.getName(), e4);
        }
    }

    private static IBinder a(ClassLoader classLoader, String str, IBinder iBinder, IBinder iBinder2) throws a {
        try {
            return a(classLoader.loadClass(str), iBinder, iBinder2);
        } catch (ClassNotFoundException e) {
            throw new a("Unable to find dynamic class " + str, e);
        }
    }

    public static d a(Activity activity, IBinder iBinder) throws a {
        ac.a(activity, "activity cannot be null");
        ac.a(iBinder, "serviceBinder cannot be null");
        Context contextB = z.b(activity);
        if (contextB == null) {
            throw new a("Could not create remote context");
        }
        return d.a.a(a(contextB.getClassLoader(), "com.google.android.youtube.api.jar.client.RemoteEmbeddedPlayer", v.a(new aa(activity, contextB.getResources(), contextB.getClassLoader(), z.a(activity, contextB))).asBinder(), iBinder));
    }
}
