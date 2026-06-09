package chat.ola.vn.balloon;

import android.annotation.TargetApi;
import android.app.Service;
import android.content.Intent;
import android.graphics.Point;
import android.os.Handler;
import android.os.IBinder;
import android.view.Display;
import android.view.View;
import android.view.WindowManager;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.activity.OlaBalloonChatViewActivity;
import chat.ola.vn.h;
import com.mg.ola.common.d.g;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

/* JADX INFO: loaded from: classes.dex */
public class OlaBalloonService extends Service {
    public d a;
    List<e> b;
    Handler c;
    Runnable d;
    private WindowManager e;

    /* JADX INFO: Access modifiers changed from: private */
    public void b(e eVar) {
        try {
            if (eVar.n >= 0 && eVar.o >= 0) {
                eVar.b.x = eVar.n;
                eVar.b.y = eVar.o;
                eVar.n = -1;
                eVar.o = -1;
            }
            this.e.addView(eVar, eVar.b);
        } catch (Throwable unused) {
        }
    }

    public void a() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.balloon.OlaBalloonService.2
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (OlaBalloonService.this.b != null) {
                        Iterator<e> it2 = OlaBalloonService.this.b.iterator();
                        while (it2.hasNext()) {
                            try {
                                OlaBalloonService.this.a((View) it2.next());
                            } catch (Throwable unused) {
                            }
                        }
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    void a(int i) {
        try {
            a(this.b.get(i));
        } catch (Throwable unused) {
        }
    }

    public void a(View view) {
        try {
            this.e.removeView(view);
        } catch (Throwable unused) {
        }
    }

    public void a(View view, WindowManager.LayoutParams layoutParams) {
        try {
            this.e.updateViewLayout(view, layoutParams);
        } catch (Throwable unused) {
        }
    }

    public void a(a aVar, WindowManager.LayoutParams layoutParams, int i, int i2) {
        a(aVar, layoutParams, i, i2, 1000L);
    }

    public void a(a aVar, WindowManager.LayoutParams layoutParams, int i, int i2, long j) {
        chat.ola.vn.balloon.a.b bVar = new chat.ola.vn.balloon.a.b(aVar, aVar.getBalloonHandler());
        bVar.a(layoutParams.x, i, layoutParams.y, i2);
        bVar.a(j);
        bVar.a();
    }

    void a(e eVar) {
        try {
            if (!this.b.remove(eVar)) {
                Iterator<e> it2 = this.b.iterator();
                while (it2.hasNext()) {
                    if (!it2.next().s.equals(eVar.s)) {
                    }
                }
            }
        } catch (Throwable unused) {
        }
        try {
            this.e.removeViewImmediate(eVar);
        } catch (Throwable unused2) {
        }
    }

    public void a(chat.ola.vn.message.f fVar) {
        a(fVar, (chat.ola.vn.message.d) null, true);
    }

    public void a(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar, boolean z) {
        e next;
        if (fVar.k() == 4 || fVar.k() == 1) {
            return;
        }
        if (this.b == null) {
            this.b = new ArrayList(4);
        }
        int iNextInt = new Random().nextInt(60) - 30;
        Iterator<e> it2 = this.b.iterator();
        while (true) {
            if (!it2.hasNext()) {
                next = null;
                break;
            } else {
                next = it2.next();
                if (fVar.equals(next.getContact())) {
                    break;
                }
            }
        }
        if (next == null) {
            if (z) {
                e eVar = new e(this);
                eVar.setBalloonTerminator(this.a);
                eVar.b.x = eVar.getWindowWidth() - eVar.getBalloonWidth();
                eVar.b.y = (eVar.getWindowHeight() / 3) - ((eVar.getBalloonHeight() / 2) + iNextInt);
                eVar.setBackupX(eVar.b.x);
                eVar.setBackupY(eVar.b.y);
                eVar.setVisibility(0);
                fVar.a((Long) null);
                eVar.setContact(fVar);
                if (this.b.size() >= 4) {
                    a(0);
                }
                this.b.add(eVar);
                if (OlaBalloonChatViewActivity.E()) {
                    try {
                        ((OlaBalloonChatViewActivity) chat.ola.vn.c.c()).G();
                        return;
                    } catch (Throwable unused) {
                        return;
                    }
                } else {
                    try {
                        this.e.addView(eVar, eVar.b);
                    } catch (Throwable unused2) {
                    }
                    if (dVar != null) {
                        eVar.a(dVar, true);
                    }
                    eVar.setNotify(fVar.z());
                    return;
                }
            }
            return;
        }
        if (OlaBalloonChatViewActivity.E()) {
            return;
        }
        if (next.getVisibility() != 0) {
            if (z) {
                try {
                    next.setVisibility(0);
                    fVar.a((Long) null);
                    next.setBackupX(next.b.x);
                    next.setBackupY(next.b.y);
                    next.b.x = 0;
                    next.bringToFront();
                    a(next, next.b);
                    if (dVar != null) {
                        next.a(dVar, true);
                        return;
                    }
                    return;
                } catch (Throwable unused3) {
                    return;
                }
            }
            return;
        }
        if (next.a == 0) {
            try {
                next.bringToFront();
                next.setBackupX(next.b.x);
                next.setBackupY(next.b.y);
                next.a = (byte) 1;
                chat.ola.vn.balloon.a.b bVar = new chat.ola.vn.balloon.a.b(next, next.getBalloonHandler());
                bVar.a(next.b.x, 0, next.b.y, next.b.y);
                bVar.a(300L);
                bVar.a();
            } catch (Throwable unused4) {
            }
        }
        if (dVar == null || next == null) {
            return;
        }
        next.a(dVar, true);
    }

    public void a(chat.ola.vn.message.f fVar, boolean z) {
        a(fVar, (chat.ola.vn.message.d) null, z);
    }

    public void a(String str, short s, int i) {
        try {
            for (e eVar : this.b) {
                if (eVar.s.a(str, s)) {
                    eVar.setNotify(i);
                    return;
                }
            }
        } catch (Throwable unused) {
        }
    }

    public void b() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.balloon.OlaBalloonService.3
            @Override // java.lang.Runnable
            public void run() {
                try {
                    OlaBalloonChatViewActivity.F();
                } catch (Throwable unused) {
                }
                try {
                    Iterator<e> it2 = OlaBalloonService.this.b.iterator();
                    while (it2.hasNext()) {
                        OlaBalloonService.this.a((View) it2.next());
                    }
                    OlaBalloonService.this.b.clear();
                } catch (Throwable unused2) {
                }
                try {
                    OlaBalloonService.this.c.removeCallbacks(OlaBalloonService.this.d);
                    OlaBalloonService.this.c.post(OlaBalloonService.this.d);
                } catch (Throwable unused3) {
                }
            }
        });
    }

    public void b(View view) {
        try {
            if (view instanceof e) {
                a((e) view);
            } else {
                this.e.removeView(view);
            }
        } catch (Throwable unused) {
        }
    }

    void b(View view, WindowManager.LayoutParams layoutParams) {
        try {
            this.e.addView(view, layoutParams);
        } catch (Throwable unused) {
        }
    }

    public void b(chat.ola.vn.message.f fVar) {
        if (this.b != null) {
            try {
                Iterator<e> it2 = this.b.iterator();
                while (it2.hasNext()) {
                    e next = it2.next();
                    if (fVar.equals(next.getContact())) {
                        try {
                            it2.remove();
                        } catch (Throwable unused) {
                        }
                        this.e.removeViewImmediate(next);
                        return;
                    }
                }
            } catch (Throwable unused2) {
            }
        }
    }

    public void c() {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.balloon.OlaBalloonService.4
                @Override // java.lang.Runnable
                public void run() {
                    if (OlaBalloonService.this.b != null) {
                        Collections.sort(OlaBalloonService.this.b, new chat.ola.vn.e.e());
                        for (int size = OlaBalloonService.this.b.size() - 1; size >= 0; size--) {
                            e eVar = OlaBalloonService.this.b.get(size);
                            try {
                                eVar.setVisibility(0);
                                OlaBalloonService.this.b(eVar);
                            } catch (Throwable unused) {
                            }
                        }
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    public void c(chat.ola.vn.message.f fVar) {
        if (fVar == null) {
            return;
        }
        Collections.sort(this.b, new chat.ola.vn.e.e());
        if (!OlaBalloonChatViewActivity.E()) {
            OlaBalloonChatViewActivity.a(this, fVar.j(), fVar.k());
        } else {
            try {
                ((OlaBalloonChatViewActivity) chat.ola.vn.c.c()).a(fVar);
            } catch (Throwable unused) {
            }
        }
    }

    @TargetApi(13)
    public int d() {
        try {
            Display defaultDisplay = ((WindowManager) getSystemService("window")).getDefaultDisplay();
            if (!g.e()) {
                return defaultDisplay.getWidth();
            }
            Point point = new Point();
            defaultDisplay.getSize(point);
            return point.x;
        } catch (Throwable unused) {
            return chat.ola.vn.e.c;
        }
    }

    @TargetApi(13)
    public int e() {
        try {
            Display defaultDisplay = ((WindowManager) getSystemService("window")).getDefaultDisplay();
            if (!g.e()) {
                return defaultDisplay.getHeight();
            }
            Point point = new Point();
            defaultDisplay.getSize(point);
            return point.y;
        } catch (Throwable unused) {
            return chat.ola.vn.e.d;
        }
    }

    public List<e> f() {
        try {
            return this.b;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override // android.app.Service
    public void onCreate() {
        super.onCreate();
        this.e = (WindowManager) getSystemService("window");
        OlaApplication.c = this;
        try {
            if (this.a == null) {
                this.a = new d(this);
            }
            this.a.setVisibility(8);
            this.e.addView(this.a, this.a.b);
        } catch (Throwable unused) {
        }
        if (this.d == null) {
            this.d = new Runnable() { // from class: chat.ola.vn.balloon.OlaBalloonService.1
                @Override // java.lang.Runnable
                public void run() {
                    List<chat.ola.vn.message.f> listO;
                    if (OlaBalloonService.this.c == null || (listO = h.t.o()) == null) {
                        return;
                    }
                    Iterator<chat.ola.vn.message.f> it2 = listO.iterator();
                    while (it2.hasNext()) {
                        OlaBalloonService.this.a(it2.next());
                    }
                }
            };
        }
        if (this.c == null) {
            this.c = new Handler();
        }
        this.c.post(this.d);
    }

    @Override // android.app.Service
    public void onDestroy() {
        super.onDestroy();
        b();
        OlaApplication.c = null;
    }
}
