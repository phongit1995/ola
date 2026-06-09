package chat.ola.vn.util.c;

import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.v4.app.NotificationCompat;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.c.x;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class c implements chat.ola.vn.f.a, a {
    public static void a(Context context) {
        try {
            final NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            builder.setContentTitle(context.getResources().getString(R.string.message_publish_note_background_success1));
            builder.setContentText(context.getResources().getString(R.string.message_publish_note_background_success2));
            builder.setSmallIcon(R.drawable.ic_notify_upload_finish);
            builder.setAutoCancel(true);
            if (x.e()) {
                builder.setSound(p);
            }
            Intent intent = new Intent(context, (Class<?>) OlaBottomTabActivity.class);
            intent.setAction("chat.ola.vn.ACTION_VIEW_NOTE");
            intent.setFlags(268566528);
            builder.setContentIntent(PendingIntent.getActivity(context, 0, intent, 134217728));
            notificationManager.notify(105, builder.build());
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.c.c.1
                @Override // java.lang.Runnable
                public void run() {
                    notificationManager.cancel(105);
                }
            }, 15000L);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str) {
        try {
            final NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            builder.setContentTitle(context.getResources().getString(R.string.app_name));
            if (m.a(str)) {
                builder.setContentText(context.getResources().getString(R.string.message_post_me_background_fail));
                str = context.getResources().getString(R.string.message_post_me_background_fail);
            } else {
                builder.setContentText(str);
            }
            builder.setTicker(str);
            if (x.e()) {
                builder.setSound(o);
            }
            builder.setSmallIcon(R.drawable.ic_notify_upload_fail);
            builder.setAutoCancel(true);
            builder.setContentIntent(PendingIntent.getActivity(context, 0, new Intent(), 134217728));
            notificationManager.notify(105, builder.build());
            if (OlaApplication.e()) {
                return;
            }
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.c.c.4
                @Override // java.lang.Runnable
                public void run() {
                    notificationManager.cancel(105);
                }
            }, 15000L);
        } catch (Throwable unused) {
        }
    }

    public static void b(Context context) {
        try {
            final NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            builder.setContentTitle(context.getResources().getString(R.string.message_post_me_background_success1));
            builder.setContentText(context.getResources().getString(R.string.message_post_me_background_success2));
            builder.setSmallIcon(R.drawable.ic_notify_upload_finish);
            builder.setAutoCancel(true);
            if (x.e()) {
                builder.setSound(p);
            }
            Intent intent = new Intent(context, (Class<?>) OlaBottomTabActivity.class);
            intent.setAction("chat.ola.vn.ACTION_REFRESH_ME");
            intent.setFlags(268566528);
            builder.setContentIntent(PendingIntent.getActivity(context, 0, intent, 134217728));
            notificationManager.notify(105, builder.build());
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.c.c.2
                @Override // java.lang.Runnable
                public void run() {
                    notificationManager.cancel(105);
                }
            }, 15000L);
        } catch (Throwable unused) {
        }
    }

    public static void c(Context context) {
        try {
            final NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            builder.setContentTitle(context.getResources().getString(R.string.app_name));
            builder.setContentText(context.getResources().getString(R.string.message_publish_note_background_fail));
            builder.setTicker(context.getResources().getString(R.string.message_publish_note_background_fail));
            if (x.e()) {
                builder.setSound(o);
            }
            builder.setSmallIcon(R.drawable.ic_notify_upload_fail);
            builder.setAutoCancel(true);
            builder.setContentIntent(PendingIntent.getActivity(context, 0, new Intent(), 134217728));
            notificationManager.notify(105, builder.build());
            if (OlaApplication.e()) {
                return;
            }
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.c.c.3
                @Override // java.lang.Runnable
                public void run() {
                    notificationManager.cancel(105);
                }
            }, 15000L);
        } catch (Throwable unused) {
        }
    }
}
