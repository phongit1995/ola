package chat.ola.vn.service;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Handler;
import android.os.IBinder;
import chat.ola.vn.R;
import chat.ola.vn.f.a;
import chat.ola.vn.message.aa;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import java.io.File;
import java.io.FileInputStream;
import java.util.LinkedList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaVoiceChatService extends Service implements MediaPlayer.OnCompletionListener, MediaPlayer.OnErrorListener, MediaPlayer.OnPreparedListener, a {
    protected static MediaPlayer a = null;
    private static boolean b = false;
    private static boolean c = false;
    private static List<aa> d;
    private static Handler e;
    private static Runnable f = new Runnable() { // from class: chat.ola.vn.service.OlaVoiceChatService.1
        @Override // java.lang.Runnable
        public void run() {
            try {
                OlaVoiceChatService.g.c(OlaVoiceChatService.g.a(), OlaVoiceChatService.a.getCurrentPosition(), OlaVoiceChatService.a.getDuration());
                OlaVoiceChatService.e.postDelayed(OlaVoiceChatService.f, 100L);
            } catch (Throwable unused) {
            }
        }
    };
    private static aa g;

    public static void a(Context context, aa aaVar) {
        a(context, aaVar, true);
    }

    private static void a(Context context, aa aaVar, boolean z) {
        if (aaVar != null) {
            if (d == null) {
                d = new LinkedList();
            }
            if (c) {
                c = false;
                if (g != null && m.b(g.a(), aaVar.a()) && !a.isPlaying()) {
                    g.b(g.a(), a.getCurrentPosition(), a.getDuration());
                    e.post(f);
                    a.start();
                    return;
                }
                d();
            }
            if (z) {
                d();
                d.clear();
            }
            if (!d.contains(aaVar)) {
                d.add(aaVar);
            }
            if (b) {
                return;
            }
            b = true;
            Intent intent = new Intent();
            intent.setClass(context, OlaVoiceChatService.class);
            context.startService(intent);
        }
    }

    public static void a(aa aaVar) {
        try {
            if (m.b(g.a(), aaVar.a()) && a.isPlaying()) {
                e.removeCallbacks(f);
                c = true;
                a.pause();
                g.a(g.a(), a.getCurrentPosition(), a.getDuration());
            }
        } catch (Throwable unused) {
        }
    }

    public static void b(Context context, aa aaVar) {
        a(context, aaVar, false);
    }

    private static void d() {
        try {
            a.stop();
        } catch (Throwable unused) {
        }
        try {
            g.r(g.a());
        } catch (Throwable unused2) {
        }
        g = null;
        b = false;
    }

    private boolean e() {
        try {
            if (d != null && d.size() > 0) {
                g = d.remove(0);
                a = new MediaPlayer();
                String strA = g.a();
                if (!m.a(strA)) {
                    e.removeCallbacks(f);
                    FileInputStream fileInputStream = new FileInputStream(new File(strA));
                    a.setDataSource(fileInputStream.getFD());
                    fileInputStream.close();
                    a.setLooping(false);
                    a.setOnPreparedListener(this);
                    a.setOnErrorListener(this);
                    a.setOnCompletionListener(this);
                    a.setWakeMode(getApplicationContext(), 1);
                    a.prepareAsync();
                    return true;
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return false;
    }

    private void f() {
        if (n.d(this) <= (n.e(this) * 5) / 100) {
            j.c(this, R.string.message_media_volume_too_small, "");
        }
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override // android.media.MediaPlayer.OnCompletionListener
    public void onCompletion(MediaPlayer mediaPlayer) {
        try {
            g.r(g.a());
        } catch (Throwable unused) {
        }
        try {
            if (e()) {
                return;
            }
            b = false;
            stopSelf();
        } catch (Throwable unused2) {
        }
    }

    @Override // android.app.Service
    public void onDestroy() {
        super.onDestroy();
        if (a != null) {
            try {
                if (a.isPlaying()) {
                    a.stop();
                }
                a.release();
                e.removeCallbacks(f);
                e = null;
                g = null;
            } catch (Throwable th) {
                a = null;
                throw th;
            }
            a = null;
        }
    }

    @Override // android.media.MediaPlayer.OnErrorListener
    public boolean onError(MediaPlayer mediaPlayer, int i, int i2) {
        try {
            if (e()) {
                return true;
            }
            b = false;
            stopSelf();
            return true;
        } catch (Throwable unused) {
            return true;
        }
    }

    @Override // android.media.MediaPlayer.OnPreparedListener
    public void onPrepared(MediaPlayer mediaPlayer) {
        g.a(g.a(), a.getDuration());
        e.post(f);
        a.start();
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        f();
        if (a != null) {
            try {
                a.stop();
            } catch (Throwable th) {
                a = null;
                throw th;
            }
            a = null;
        }
        if (e == null) {
            e = new Handler();
        }
        if (e()) {
            return 2;
        }
        stopSelf();
        return 2;
    }
}
