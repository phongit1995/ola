package chat.ola.vn.util.c;

import android.annotation.SuppressLint;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Vibrator;
import android.support.v4.app.NotificationCompat;
import android.text.format.Formatter;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.BuyVipActivity;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.badger.j;
import chat.ola.vn.c.e;
import chat.ola.vn.c.g;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.h;
import chat.ola.vn.message.d;
import chat.ola.vn.message.f;
import chat.ola.vn.util.i;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Random;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class b implements chat.ola.vn.f.a, a {
    public static int C = 6;
    public static int D;
    private static Runnable E;
    private static long F;
    private static Runnable G;
    private static int H;

    public static void a() {
        try {
            Context contextA = OlaApplication.a();
            NotificationCompat.Builder builder = new NotificationCompat.Builder(contextA);
            builder.setAutoCancel(true);
            if (x.f()) {
                builder.setVibrate(OlaApplication.e() ? a : b);
            }
            if (x.e()) {
                builder.setSound(r);
            }
            if (x.q) {
                builder.setLights(-16711936, g[0], g[1]);
            }
            ((NotificationManager) contextA.getSystemService("notification")).notify(100, builder.build());
        } catch (Throwable unused) {
        }
    }

    public static void a(int i) {
        StringBuilder sb;
        try {
            Context contextA = OlaApplication.a();
            NotificationCompat.Builder builder = new NotificationCompat.Builder(contextA);
            builder.setAutoCancel(true);
            if (x.f()) {
                builder.setVibrate(OlaApplication.e() ? a : b);
            }
            if (x.e()) {
                builder.setSound(x.d());
            }
            if (i == 1) {
                sb = new StringBuilder();
                sb.append(m.a(i, ","));
                sb.append(" ");
                sb.append(contextA.getString(R.string.string_unread_message));
            } else {
                sb = new StringBuilder();
                sb.append(m.a(i, ","));
                sb.append(" ");
                sb.append(contextA.getString(R.string.string_unread_messages));
            }
            String string = sb.toString();
            builder.setContentTitle(contextA.getString(R.string.app_name));
            builder.setContentText(string);
            builder.setSmallIcon(R.drawable.ic_notify_new_message);
            builder.setTicker(string);
            Intent intent = new Intent(contextA, (Class<?>) OlaBottomTabActivity.class);
            intent.setAction("chat.ola.vn.ACTION_SHOW_CONVERSATION");
            intent.setFlags(1350565888);
            builder.setContentIntent(PendingIntent.getActivity(contextA, 0, intent, 134217728));
            ((NotificationManager) contextA.getSystemService("notification")).notify(100, builder.build());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void a(Context context) {
        a(context, 0);
    }

    public static void a(Context context, int i) {
        try {
            NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            if (i == 0) {
                notificationManager.cancelAll();
            } else {
                notificationManager.cancel(i);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void a(Context context, long j) {
        try {
            ((Vibrator) context.getSystemService("vibrator")).vibrate(j);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void a(Context context, long j, long j2, int i, int i2, int i3) {
        try {
            final NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            builder.setNumber(i2);
            builder.setContentTitle(context.getResources().getString(R.string.message_upload_media_to_ola));
            int i4 = j2 != 0 ? (int) ((100 * j) / j2) : 0;
            builder.setProgress(100, i4, false);
            builder.setContentText(context.getResources().getString(R.string.message_send_media_progress_format, Formatter.formatShortFileSize(context, j), Formatter.formatShortFileSize(context, j2), i4 + "%"));
            D = D + 1;
            D = D >= C ? 0 : D;
            builder.setSmallIcon(R.drawable.ic_notify_upload, D);
            builder.setOngoing(true);
            builder.setContentIntent(PendingIntent.getActivity(context, 0, new Intent(), 134217728));
            notificationManager.notify(105, builder.build());
            if (G == null) {
                G = new Runnable() { // from class: chat.ola.vn.util.c.b.1
                    @Override // java.lang.Runnable
                    public void run() {
                        notificationManager.cancel(105);
                    }
                };
            }
            OlaApplication.c(G);
            OlaApplication.a(G, 10000L);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str) {
        try {
            NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            if (m.a(str)) {
                builder.setContentTitle(context.getResources().getString(R.string.message_notify_wrong_password));
                str = context.getResources().getString(R.string.message_fail_username_or_password);
            } else {
                builder.setContentTitle(str);
            }
            builder.setContentText(str);
            builder.setSmallIcon(R.drawable.ic_notify_ola);
            builder.setAutoCancel(true);
            builder.setContentIntent(PendingIntent.getActivity(context, 0, new Intent(), 134217728));
            notificationManager.notify(112, builder.build());
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str, String str2, long j) {
        try {
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            if (x.e()) {
                builder.setSound(A);
            }
            builder.setSmallIcon(R.drawable.ic_ken_white);
            String string = context.getString(R.string.message_receive_ken_from_someone, m.a(j), str, str2);
            String string2 = context.getString(R.string.message_receive_ken_from_someone_notification_title);
            builder.setTicker(string);
            builder.setContentText(string);
            builder.setContentTitle(string2);
            builder.setOnlyAlertOnce(true);
            builder.setAutoCancel(true);
            builder.setContentIntent(PendingIntent.getActivity(context, 0, new Intent(), 134217728));
            final NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            final int iNextInt = new Random().nextInt(100) + 300;
            notificationManager.notify(iNextInt, builder.build());
            if (OlaApplication.e()) {
                return;
            }
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.c.b.5
                @Override // java.lang.Runnable
                public void run() {
                    notificationManager.cancel(iNextInt);
                }
            }, 60000L);
        } catch (Throwable unused) {
        }
    }

    public static void a(f fVar) {
        try {
            final Context contextA = OlaApplication.a();
            final NotificationCompat.Builder builder = new NotificationCompat.Builder(contextA);
            builder.setAutoCancel(true);
            builder.setContentTitle(contextA.getString(R.string.app_name));
            builder.setSmallIcon(R.drawable.ic_notify_birthday);
            String string = contextA.getString(R.string.message_notify_friend_birthday, fVar.c());
            if (!m.a(string)) {
                builder.setTicker(string);
                builder.setContentText(string);
            }
            Intent intent = new Intent(contextA, (Class<?>) OlaChatViewActivity.class);
            if (h.a() != null) {
                intent.putExtra("_username", h.a());
            }
            intent.putExtra("_conv_id", fVar.j());
            intent.putExtra("_conv_type", fVar.k());
            intent.setFlags(1350565888);
            builder.setContentIntent(PendingIntent.getActivity(contextA, 0, intent, 134217728));
            final int iNextInt = new Random().nextInt(100) + 400;
            String lowerCase = fVar.j().toLowerCase();
            Bitmap bitmapC = t.a().c(lowerCase);
            if (bitmapC != null) {
                builder.setLargeIcon(bitmapC);
            } else {
                builder.setLargeIcon(BitmapFactory.decodeResource(OlaApplication.a().getResources(), R.drawable.ic_contact_photo));
                chat.ola.vn.c.f fVarA = chat.ola.vn.c.f.a(lowerCase);
                fVarA.a(new g() { // from class: chat.ola.vn.util.c.b.2
                    @Override // chat.ola.vn.c.g
                    public void a(chat.ola.vn.c.f fVar2) {
                        builder.setLargeIcon(fVar2.c());
                        ((NotificationManager) contextA.getSystemService("notification")).notify(iNextInt, builder.build());
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(chat.ola.vn.c.f fVar2) {
                        ((NotificationManager) contextA.getSystemService("notification")).notify(iNextInt, builder.build());
                    }
                });
                try {
                    new e().a(fVarA);
                } catch (Throwable unused) {
                }
            }
            ((NotificationManager) contextA.getSystemService("notification")).notify(iNextInt, builder.build());
        } catch (Throwable unused2) {
        }
    }

    public static void a(f fVar, d dVar) {
        try {
            if (fVar.k() == 1) {
                return;
            }
            if (h.t.f(fVar)) {
                b(fVar);
                return;
            }
            if (dVar != null) {
                try {
                    if (fVar.k() == 2 && i.a(dVar.k(), h.a())) {
                        a();
                    }
                } catch (Throwable unused) {
                }
            }
            b(fVar, dVar);
        } catch (Throwable unused2) {
        }
    }

    public static void a(String str, String str2) {
        PendingIntent activity;
        try {
            if (m.a(str)) {
                return;
            }
            Context contextA = OlaApplication.a();
            NotificationCompat.Builder builder = new NotificationCompat.Builder(contextA);
            builder.setSmallIcon(R.drawable.ic_notify_ola);
            builder.setContentTitle(contextA.getString(R.string.app_name));
            builder.setTicker(str);
            builder.setContentText(str);
            builder.setOnlyAlertOnce(true);
            if (m.a(str2)) {
                activity = PendingIntent.getActivity(contextA, 0, new Intent(), 0);
            } else {
                Intent intent = new Intent(contextA, (Class<?>) OlaChatViewActivity.class);
                if (h.a() != null) {
                    intent.putExtra("_username", h.a());
                }
                intent.putExtra("_conv_id", str2);
                intent.putExtra("_conv_type", (short) 0);
                activity = PendingIntent.getActivity(contextA, 0, intent, 134217728);
            }
            builder.setContentIntent(activity);
            final NotificationManager notificationManager = (NotificationManager) contextA.getSystemService("notification");
            notificationManager.notify(102, builder.build());
            if (E == null) {
                E = new Runnable() { // from class: chat.ola.vn.util.c.b.4
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            notificationManager.cancel(102);
                        } catch (Throwable unused) {
                        }
                    }
                };
            }
            OlaApplication.c(E);
            OlaApplication.a(E, 3000L);
        } catch (Throwable unused) {
        }
    }

    public static void b() {
        try {
            if (x.e()) {
                Context contextA = OlaApplication.a();
                NotificationCompat.Builder builder = new NotificationCompat.Builder(contextA);
                builder.setAutoCancel(true);
                builder.setSound(x.d());
                ((NotificationManager) contextA.getSystemService("notification")).notify(100, builder.build());
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void b(int i) {
        try {
            if (chat.ola.vn.e.a().f(i)) {
                chat.ola.vn.e.a().g(i);
                Context contextA = OlaApplication.a();
                NotificationCompat.Builder builder = new NotificationCompat.Builder(contextA);
                builder.setAutoCancel(true);
                builder.setContentTitle(contextA.getString(R.string.app_name));
                builder.setSmallIcon(R.drawable.ic_notify_ola);
                String string = i <= 0 ? contextA.getString(R.string.message_unread_me_notification, "") : contextA.getString(R.string.message_unread_me_notification, m.a(i));
                if (!m.a(string)) {
                    builder.setTicker(string);
                    builder.setContentText(string);
                }
                Intent intent = new Intent(contextA, (Class<?>) OlaBottomTabActivity.class);
                if (h.a() != null) {
                    intent.putExtra("_username", h.a());
                    intent.setAction("chat.ola.vn.ACTION_VIEW_ME");
                    intent.putExtra("_me_entry_id", 0);
                    intent.setFlags(268566528);
                    builder.setContentIntent(PendingIntent.getActivity(contextA, 0, intent, 134217728));
                    ((NotificationManager) contextA.getSystemService("notification")).notify(117, builder.build());
                }
            }
        } catch (Throwable unused) {
        }
    }

    public static void b(Context context) {
        if (context == null || OlaApplication.b == null || !OlaApplication.b.h()) {
            return;
        }
        try {
            NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            builder.setContentTitle(context.getResources().getString(R.string.message_inform));
            builder.setContentText(context.getResources().getString(R.string.message_vip_need_extension_notify));
            builder.setTicker(context.getResources().getString(R.string.message_vip_need_extension_notify));
            builder.setSmallIcon(R.drawable.ic_notify_new_notify);
            builder.setAutoCancel(true);
            builder.setContentIntent(PendingIntent.getActivity(context, 0, new Intent(context, (Class<?>) BuyVipActivity.class), 134217728));
            notificationManager.notify(116, builder.build());
        } catch (Throwable unused) {
        }
    }

    public static void b(Context context, int i) {
        if (i < 0) {
            i = 0;
        }
        if (i > 99) {
            i = 99;
        }
        try {
            if (H == 0 && i == 0) {
                return;
            }
            H = i;
            j.a(context, i);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void b(Context context, String str) {
        try {
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            if (x.e()) {
                builder.setSound(A);
            }
            ((NotificationManager) context.getSystemService("notification")).notify(f.c(str, (short) 0), builder.build());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private static void b(f fVar) {
        try {
            Context contextA = OlaApplication.a();
            NotificationCompat.Builder builder = new NotificationCompat.Builder(contextA);
            builder.setAutoCancel(true);
            if (fVar.N()) {
                builder.setSound(l);
            }
            ((NotificationManager) contextA.getSystemService("notification")).notify(fVar.U(), builder.build());
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Failed to find 'out' block for switch in B:58:0x00f9. Please report as an issue. */
    private static void b(final f fVar, final d dVar) {
        int iZ;
        StringBuilder sb;
        String string;
        StringBuilder sb2;
        String string2;
        String string3;
        Object[] objArr;
        Object[] objArr2;
        int i;
        Object[] objArr3;
        ArrayList<String> arrayListB;
        try {
            if (fVar.W() && (iZ = fVar.z()) != 0) {
                if (iZ > 0) {
                    try {
                        if (((OlaBottomTabActivity) OlaBottomTabActivity.c()).L() == 0) {
                            if (chat.ola.vn.m.e.c().d() == 0) {
                                return;
                            }
                        }
                    } catch (Throwable unused) {
                    }
                }
                final Context contextA = OlaApplication.a();
                if (x.k == 2) {
                    return;
                }
                final NotificationCompat.Builder builder = new NotificationCompat.Builder(contextA);
                builder.setAutoCancel(true);
                int i2 = R.drawable.ic_notify_new_message;
                if (fVar.k() == 2) {
                    i2 = R.drawable.ic_notify_new_chat_group_message;
                }
                if (x.q) {
                    builder.setLights(-16711936, d[0], d[1]);
                }
                if (fVar.P() && !fVar.x()) {
                    builder.setVibrate(a);
                }
                if (fVar.N() && !fVar.x()) {
                    if (m.b(dVar.k(), chat.ola.vn.f.c.a)) {
                        long jCurrentTimeMillis = System.currentTimeMillis();
                        builder.setSound(jCurrentTimeMillis - F < 180000 ? fVar.O() : k);
                        F = jCurrentTimeMillis;
                    } else {
                        builder.setSound(fVar.O());
                    }
                    fVar.r = System.currentTimeMillis();
                }
                if (dVar != null) {
                    chat.ola.vn.entity.i iVar = null;
                    String strK = dVar.k();
                    if (!m.a(strK) && (arrayListB = i.b((CharSequence) strK)) != null && arrayListB.size() > 0) {
                        String str = arrayListB.get(0);
                        chat.ola.vn.entity.i iVar2 = new chat.ola.vn.entity.i();
                        iVar2.a(str);
                        iVar = iVar2;
                    }
                    if (iZ == 1) {
                        if (iVar == null) {
                            if (m.a(strK)) {
                                if (fVar.k() == 2) {
                                    objArr2 = new Object[]{fVar.b(), dVar.i()};
                                } else if (dVar.o() > 0) {
                                    sb = new StringBuilder();
                                    sb.append(fVar.j());
                                    sb.append(": ");
                                    string = contextA.getString(R.string.string_sticker);
                                } else {
                                    objArr = new Object[]{dVar.i()};
                                    string3 = contextA.getString(R.string.message_receive_message_single, objArr);
                                }
                            } else if (fVar.k() == 2) {
                                objArr2 = new Object[]{fVar.b(), dVar.i()};
                            } else {
                                sb = new StringBuilder();
                                sb.append(fVar.j());
                                sb.append(": ");
                                sb.append(strK);
                                string3 = sb.toString();
                            }
                            string3 = contextA.getString(R.string.message_receive_text_chatgroup, objArr2);
                            i2 = R.drawable.ic_notify_new_chat_group_message;
                        } else if (fVar.k() != 2) {
                            switch (iVar.f()) {
                                case 1:
                                    string3 = contextA.getString(R.string.message_receive_photo_notification2, dVar.i());
                                    i2 = R.drawable.ic_notify_media_receive_photo;
                                    break;
                                case 2:
                                    string3 = contextA.getString(R.string.message_receive_video_notification2, dVar.i());
                                    i2 = R.drawable.ic_notify_media_receive_video;
                                    break;
                                case 3:
                                    string3 = contextA.getString(R.string.message_receive_sound_notification2, dVar.i());
                                    i2 = R.drawable.ic_notify_media_receive_voice;
                                    break;
                                default:
                                    objArr = new Object[1];
                                    objArr[0] = dVar.i();
                                    string3 = contextA.getString(R.string.message_receive_message_single, objArr);
                                    break;
                            }
                        } else {
                            switch (iVar.f()) {
                                case 1:
                                    i = R.string.message_receive_photo_chatgroup;
                                    objArr3 = new Object[]{fVar.b(), dVar.i()};
                                    string3 = contextA.getString(i, objArr3);
                                    break;
                                case 2:
                                    i = R.string.message_receive_video_chatgroup;
                                    objArr3 = new Object[]{fVar.b(), dVar.i()};
                                    string3 = contextA.getString(i, objArr3);
                                    break;
                                case 3:
                                    i = R.string.message_receive_sound_chatgroup;
                                    objArr3 = new Object[]{fVar.b(), dVar.i()};
                                    string3 = contextA.getString(i, objArr3);
                                    break;
                                default:
                                    objArr2 = new Object[2];
                                    objArr2[0] = fVar.b();
                                    objArr2[1] = dVar.i();
                                    string3 = contextA.getString(R.string.message_receive_text_chatgroup, objArr2);
                                    break;
                            }
                            i2 = R.drawable.ic_notify_new_chat_group_message;
                        }
                    } else if (iZ > 0) {
                        if (fVar.k() == 2) {
                            sb2 = new StringBuilder();
                            sb2.append(contextA.getString(R.string.string_chat_group));
                            sb2.append(" ");
                            sb2.append(fVar.b());
                            sb2.append(": ");
                            sb2.append(m.a(iZ, ","));
                            sb2.append(" ");
                            string2 = contextA.getString(R.string.string_unread_messages);
                        } else {
                            sb2 = new StringBuilder();
                            sb2.append(m.a(iZ, ","));
                            sb2.append(" ");
                            string2 = contextA.getString(R.string.string_unread_messages);
                        }
                        sb2.append(string2);
                        string3 = sb2.toString();
                    } else {
                        if (fVar.k() == 2) {
                            sb = new StringBuilder();
                            sb.append(contextA.getString(R.string.string_chat_group));
                            sb.append(" ");
                            sb.append(fVar.b());
                            sb.append(": ");
                            string = contextA.getString(R.string.message_receive_message_notification);
                        }
                        string3 = contextA.getString(R.string.message_receive_message_notification);
                    }
                    sb.append(string);
                    string3 = sb.toString();
                } else if (iZ > 0) {
                    if (fVar.k() == 2) {
                        sb2 = new StringBuilder();
                        sb2.append(contextA.getString(R.string.string_chat_group));
                        sb2.append(" ");
                        sb2.append(fVar.b());
                        sb2.append(": ");
                        sb2.append(m.a(iZ, ","));
                        sb2.append(" ");
                        string2 = contextA.getString(R.string.string_unread_messages);
                    } else {
                        sb2 = new StringBuilder();
                        sb2.append(m.a(iZ, ","));
                        sb2.append(" ");
                        string2 = contextA.getString(R.string.string_unread_messages);
                    }
                    sb2.append(string2);
                    string3 = sb2.toString();
                } else {
                    if (fVar.k() == 2) {
                        sb = new StringBuilder();
                        sb.append(contextA.getString(R.string.string_chat_group));
                        sb.append(" ");
                        sb.append(fVar.b());
                        sb.append(": ");
                        string = contextA.getString(R.string.message_receive_message_notification);
                        sb.append(string);
                        string3 = sb.toString();
                    }
                    string3 = contextA.getString(R.string.message_receive_message_notification);
                }
                builder.setSmallIcon(i2);
                builder.setContentTitle(contextA.getString(R.string.app_name));
                builder.setTicker(string3);
                builder.setContentText(string3);
                Intent intent = new Intent(contextA, (Class<?>) OlaChatViewActivity.class);
                if (h.a() != null) {
                    intent.putExtra("_username", h.a());
                }
                intent.setAction(fVar.y());
                intent.putExtra("_conv_id", fVar.j());
                intent.putExtra("_conv_type", fVar.k());
                builder.setContentIntent(PendingIntent.getActivity(contextA, 0, intent, 134217728));
                String lowerCase = dVar.i().toLowerCase(Locale.US);
                Bitmap bitmapC = t.a().c(lowerCase);
                if (bitmapC != null) {
                    builder.setLargeIcon(bitmapC);
                } else {
                    builder.setLargeIcon(BitmapFactory.decodeResource(OlaApplication.a().getResources(), R.drawable.ic_contact_photo));
                    chat.ola.vn.c.f fVarA = chat.ola.vn.c.f.a(lowerCase);
                    fVarA.a(new g() { // from class: chat.ola.vn.util.c.b.3
                        @Override // chat.ola.vn.c.g
                        public void a(chat.ola.vn.c.f fVar2) {
                            builder.setLargeIcon(fVar2.c());
                            ((NotificationManager) contextA.getSystemService("notification")).notify(fVar.U(), builder.build());
                        }

                        @Override // chat.ola.vn.c.g
                        public void b(chat.ola.vn.c.f fVar2) {
                            if (dVar.n() != 0) {
                                builder.setLargeIcon(chat.ola.vn.j.a().a(dVar.n()));
                            }
                            ((NotificationManager) contextA.getSystemService("notification")).notify(fVar.U(), builder.build());
                        }
                    });
                    try {
                        new e().a(fVarA);
                    } catch (Throwable unused2) {
                    }
                }
                ((NotificationManager) contextA.getSystemService("notification")).notify(fVar.U(), builder.build());
            }
        } catch (Throwable unused3) {
        }
    }

    public static void c() {
        try {
            if (x.f()) {
                Context contextA = OlaApplication.a();
                NotificationCompat.Builder builder = new NotificationCompat.Builder(contextA);
                builder.setAutoCancel(true);
                builder.setVibrate(a);
                ((NotificationManager) contextA.getSystemService("notification")).notify(100, builder.build());
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void c(Context context) {
        try {
            NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            builder.setContentTitle(context.getResources().getString(R.string.message_inform));
            builder.setContentText(context.getResources().getString(R.string.message_connection_login_another_content));
            builder.setTicker(context.getResources().getString(R.string.message_connection_login_another_content));
            builder.setSmallIcon(R.drawable.ic_notify_ola);
            builder.setAutoCancel(true);
            builder.setContentIntent(PendingIntent.getActivity(context, 0, new Intent(), 134217728));
            notificationManager.notify(115, builder.build());
        } catch (Throwable unused) {
        }
    }

    public static void c(Context context, String str) {
        try {
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            if (x.e()) {
                builder.setSound(B);
            }
            ((NotificationManager) context.getSystemService("notification")).notify(f.c(str, (short) 0), builder.build());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void d(Context context) {
        try {
            a(context, 115);
        } catch (Throwable unused) {
        }
    }

    public static void e(Context context) {
        try {
            NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
            builder.setContentTitle(context.getResources().getString(R.string.message_notify_system_error));
            builder.setContentText(context.getResources().getString(R.string.message_notify_system_error));
            builder.setSmallIcon(R.drawable.ic_notify_ola);
            builder.setAutoCancel(true);
            builder.setContentIntent(PendingIntent.getActivity(context, 0, new Intent(), 134217728));
            notificationManager.notify(112, builder.build());
        } catch (Throwable unused) {
        }
    }

    public static void f(Context context) {
        try {
            j.a(context, 0);
        } catch (Throwable unused) {
        }
    }
}
