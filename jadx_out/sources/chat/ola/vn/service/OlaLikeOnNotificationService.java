package chat.ola.vn.service;

import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.IBinder;
import android.support.v4.app.NotificationCompat;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.activity.OlaReplyMeOnNotificationActivity;
import chat.ola.vn.c.e;
import chat.ola.vn.c.t;
import chat.ola.vn.f.a;
import chat.ola.vn.h;
import chat.ola.vn.j;
import chat.ola.vn.me.c;
import chat.ola.vn.message.f;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.m;
import com.google.android.gms.common.util.CrashUtils;
import com.mg.ola.common.d.g;

/* JADX INFO: loaded from: classes.dex */
public class OlaLikeOnNotificationService extends Service implements a {
    private boolean b;
    private long d;
    private String a = "";
    private String c = "";

    private void a() {
        int i;
        String string;
        try {
            final Context contextA = OlaApplication.a();
            final NotificationCompat.Builder builder = new NotificationCompat.Builder(contextA);
            final f fVarE = h.t.e(this.a, (short) 0);
            if (fVarE == null) {
                fVarE = new f(this.a, (short) 0);
            }
            builder.setContentTitle(contextA.getString(R.string.app_name));
            builder.setSmallIcon(R.drawable.ic_notify_ola);
            String str = fVarE.b() + " " + this.c;
            if (!m.a(str)) {
                builder.setTicker(str);
                builder.setContentText(str);
            }
            Intent intent = new Intent(contextA, (Class<?>) OlaBottomTabActivity.class);
            intent.setFlags(1350565888);
            intent.putExtra("_me_entry_id", this.d);
            intent.putExtra("_index", 117);
            intent.setAction("chat.ola.vn.ACTION_VIEW_ME");
            PendingIntent activity = PendingIntent.getActivity(contextA, 0, intent, 134217728);
            if (g.g()) {
                builder.setStyle(new NotificationCompat.BigTextStyle().bigText(str));
                Intent intent2 = new Intent(contextA, (Class<?>) OlaReplyMeOnNotificationActivity.class);
                intent2.addFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
                intent2.setAction("chat.ola.vn.ACTION_VIEW_ME");
                intent2.putExtra("_me_entry_id", this.d);
                intent2.putExtra("_sender", this.a);
                intent2.putExtra("me_message", this.c);
                intent2.putExtra("_index", 117);
                intent2.putExtra("_action", true);
                builder.addAction(R.drawable.ic_action_reply, contextA.getString(R.string.string_reply), PendingIntent.getActivity(contextA, 0, intent2, 134217728));
                Intent intent3 = new Intent(contextA, (Class<?>) OlaLikeOnNotificationService.class);
                intent3.addFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
                intent3.setAction("chat.ola.vn.ACTION_VIEW_ME");
                intent3.putExtra("_me_entry_id", this.d);
                intent3.putExtra("me_like_state", this.b);
                intent3.putExtra("_sender", this.a);
                intent3.putExtra("me_message", this.c);
                PendingIntent service = PendingIntent.getService(contextA, 0, intent3, 134217728);
                if (this.b) {
                    i = R.drawable.ic_like_white;
                    string = contextA.getString(R.string.string_like);
                } else {
                    i = R.drawable.ic_like_selected;
                    string = contextA.getString(R.string.string_like);
                }
                builder.addAction(i, string, service);
                builder.setAutoCancel(false);
            }
            builder.setContentIntent(activity);
            String lowerCase = fVarE.j().toLowerCase();
            Bitmap bitmapC = t.a().c(lowerCase);
            if (bitmapC != null) {
                builder.setLargeIcon(bitmapC);
                ((NotificationManager) contextA.getSystemService("notification")).notify(117, builder.build());
            } else {
                builder.setLargeIcon(BitmapFactory.decodeResource(OlaApplication.a().getResources(), R.drawable.ic_contact_photo));
                chat.ola.vn.c.f fVarA = chat.ola.vn.c.f.a(lowerCase);
                fVarA.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.service.OlaLikeOnNotificationService.1
                    @Override // chat.ola.vn.c.g
                    public void a(chat.ola.vn.c.f fVar) {
                        builder.setLargeIcon(fVar.c());
                        ((NotificationManager) contextA.getSystemService("notification")).notify(117, builder.build());
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(chat.ola.vn.c.f fVar) {
                        if (fVarE.i() != 0) {
                            builder.setLargeIcon(j.a().a(fVarE.i()));
                        }
                        ((NotificationManager) contextA.getSystemService("notification")).notify(117, builder.build());
                    }
                });
                new e().a(fVarA);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override // android.app.Service
    public void onCreate() {
        super.onCreate();
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        OlaNetworkService olaNetworkService;
        long j;
        boolean z;
        try {
            this.d = intent.getLongExtra("_me_entry_id", 0L);
            this.a = intent.getStringExtra("_sender");
            this.c = intent.getStringExtra("me_message");
            if (this.d != 0) {
                this.b = intent.getBooleanExtra("me_like_state", false);
                if (this.b) {
                    if (OlaApplication.b != null) {
                        olaNetworkService = OlaApplication.b;
                        j = this.d;
                        z = this.b;
                        olaNetworkService.b(j, z);
                    }
                    this.b = !this.b;
                    a();
                } else {
                    if (OlaApplication.b != null) {
                        olaNetworkService = OlaApplication.b;
                        j = this.d;
                        z = this.b;
                        olaNetworkService.b(j, z);
                    }
                    this.b = !this.b;
                    a();
                }
            } else {
                c.a(this, OlaApplication.b, (String) null);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return super.onStartCommand(intent, i, i2);
    }
}
